#include "config.h"
#include "debug.h"
#include "types.h"

#include "constants/save.h"
#include "constants/species.h"
#include "pokemon.h"
#include "pokemon_storage_system.h"
#include "save.h"

#include "chapter.h"

/*
 *  hack: the Part 1 (Red) -> Part 2 (Gold) framework.  see include/chapter.h.
 *
 *  - a new game starts Part 1 in Red's room in Pallet Town (the "player's room" locations are chapter-aware)
 *  - Part 1's Hall of Fame saves and resets as usual.  on the next Continue, before the overworld starts, the save
 *    is wiped like a new game, except for Red's team (packed into PC Box padding), the Nuzlocke choice, the
 *    randomizer seed and the options.  then Professor Oak's HeartGold intro runs and Part 2 starts in New Bark.
 */

#ifdef CHAPTER_SYSTEM

#define SAVE_PCSTORAGE 41
#define VAR_SEED_LO 0x4164
#define VAR_SEED_HI 0x4165
#define FLAG_NUZLOCKE_ENABLED 2602

#define MAP_NEW_BARK_PLAYER_HOUSE_2F 64
#define MAP_NEW_BARK 60
#define MAP_PALLET_TOWN_REDS_HOUSE_2F 506
#define MAP_PALLET 49

#define HEAPID_OV36 75

void *SaveArray_Get(SaveData *saveData, int id);
void LONG_CALL Heap_Destroy(u32 heapId);
void LONG_CALL RegisterMainOverlay(int ovyId, const void *template);
void *LONG_CALL Save_PlayerData_GetOptionsAddr(SaveData *saveData);

// overlay 36 (title menu -> game start) and the apps it hands over to
#define NewGame_InitSaveData ((void (*)(u32 heapId, SaveData *saveData))(0x021E5BC8 | 1))
#define gApplication_OakSpeech ((const void *)0x02106068)
#define gApplication_ContinueFieldsys ((const void *)0x020FA16C)

static BOOL sForcePart2Locations = FALSE;

static const Location sPart1PlayerRoom = { MAP_PALLET_TOWN_REDS_HOUSE_2F, -1, 6, 6, 1 }; // open floor, like New Bark (6,6)
static const Location sPart1OutsideHome = { MAP_PALLET, -1, 1033, 364, 1 };
static const Location sPart2PlayerRoom = { MAP_NEW_BARK_PLAYER_HOUSE_2F, -1, 6, 6, 1 };
static const Location sPart2OutsideHome = { MAP_NEW_BARK, -1, 0x2B7, 0x18D, 1 };

u32 LONG_CALL Chapter_Get(void)
{
    return GetScriptVar(VAR_CHAPTER);
}

static BOOL InPart1(void)
{
    return !sForcePart2Locations && Chapter_Get() == CHAPTER_RED;
}

/**
 *  @brief replaces Location_SetToPlayerRoom (0x0203E368): new game spawn and the Hall of Fame return point
 */
void LONG_CALL Chapter_Location_SetToPlayerRoom(Location *dest)
{
    *dest = InPart1() ? sPart1PlayerRoom : sPart2PlayerRoom;
}

/**
 *  @brief replaces Location_SetToOutsidePlayerHome (0x0203E380)
 */
void LONG_CALL Chapter_Location_SetToOutsidePlayerHome(Location *dest)
{
    *dest = InPart1() ? sPart1OutsideHome : sPart2OutsideHome;
}

// Red's team lives in the 16 unused bytes at the end of every PC Box
static void TeamCopy(PCStorage *storage, struct ChapterTeam *team, BOOL write)
{
    u8 *bytes = (u8 *)team;
    for (u32 i = 0; i < sizeof(struct ChapterTeam); i++) {
        u8 *slot = &storage->boxes[i / 16].unk_FF0[i % 16];
        if (write) {
            *slot = bytes[i];
        } else {
            bytes[i] = *slot;
        }
    }
}

BOOL LONG_CALL Chapter_ReadRedTeam(struct ChapterTeam *team)
{
    TeamCopy(SaveArray_Get(SaveBlock2_get(), SAVE_PCSTORAGE), team, FALSE);
    return team->magic == CHAPTER_TEAM_MAGIC;
}

static void PackMon(struct PartyPokemon *mon, struct ChapterTeamMon *out)
{
    memset(out, 0, sizeof(*out));
    if (GetMonData(mon, MON_DATA_SPECIES, NULL) == 0 || GetMonData(mon, MON_DATA_IS_EGG, NULL)) {
        return;
    }
    out->species = GetMonData(mon, MON_DATA_SPECIES, NULL);
    out->form = GetMonData(mon, MON_DATA_FORM, NULL);
    out->level = GetMonData(mon, MON_DATA_LEVEL, NULL);
    out->personality = GetMonData(mon, MON_DATA_PERSONALITY, NULL);
    for (int i = 0; i < 6; i++) {
        out->ivs |= (GetMonData(mon, MON_DATA_HP_IV + i, NULL) & 31) << (i * 5);
    }
    out->item = GetMonData(mon, MON_DATA_HELD_ITEM, NULL);
    for (int i = 0; i < 4; i++) {
        out->moves[i] = GetMonData(mon, MON_DATA_MOVE1 + i, NULL);
    }
    out->reserved114 = GetMonData(mon, MON_DATA_RESERVED_114, NULL) & 0x0FFF; // drop the Nuzlocke dead bit
    out->reserved113 = GetMonData(mon, MON_DATA_RESERVED_113, NULL);
    out->ball = GetMonData(mon, MON_DATA_POKEBALL, NULL);
    out->flags = MonIsShiny(mon) ? 1 : 0;
    GetMonData(mon, MON_DATA_NICKNAME, out->nickname);
}

static BOOL IsPart1Finished(void)
{
    return Chapter_Get() == CHAPTER_RED && CheckScriptFlag(FLAG_GAME_CLEAR);
}

/**
 *  @brief start Part 2 on this save: wipe it like a new game, keeping Red's team, the Nuzlocke choice, the
 *         randomizer seed and the options
 */
static void BeginPart2(SaveData *saveData)
{
    struct ChapterTeam team;
    struct Party *party = SaveData_GetPlayerPartyPtr(saveData);
    int i;

    team.magic = CHAPTER_TEAM_MAGIC;
    for (i = 0; i < CHAPTER_TEAM_SIZE; i++) {
        if (i < party->count) {
            PackMon(Party_GetMonByIndex(party, i), &team.mons[i]);
        } else {
            memset(&team.mons[i], 0, sizeof(team.mons[i]));
        }
    }
    BOOL nuzlocke = CheckScriptFlag(FLAG_NUZLOCKE_ENABLED);
    u16 seedLo = GetScriptVar(VAR_SEED_LO);
    u16 seedHi = GetScriptVar(VAR_SEED_HI);
    u16 options = *(u16 *)Save_PlayerData_GetOptionsAddr(saveData);

    sForcePart2Locations = TRUE;
    NewGame_InitSaveData(HEAPID_OV36, saveData);
    sForcePart2Locations = FALSE;

    SetScriptVar(VAR_CHAPTER, CHAPTER_GOLD);
    SetScriptVar(VAR_SEED_LO, seedLo);
    SetScriptVar(VAR_SEED_HI, seedHi);
    if (nuzlocke) {
        SetScriptFlag(FLAG_NUZLOCKE_ENABLED);
    }
    *(u16 *)Save_PlayerData_GetOptionsAddr(saveData) = options;

    PCStorage *storage = SaveArray_Get(saveData, SAVE_PCSTORAGE);
    TeamCopy(storage, &team, TRUE);
    for (i = 0; i <= (int)(sizeof(struct ChapterTeam) / 16); i++) {
        PCStorage_SetBoxModified(storage, i);
    }
}

/**
 *  @brief replaces the title menu's Continue app exit (overlay 36, 0x021E5A1C).  a save that just finished Part 1
 *         goes into Part 2's intro instead of the overworld.
 */
BOOL LONG_CALL Chapter_ContinueAppExit(void *man UNUSED, int *state UNUSED)
{
    Heap_Destroy(HEAPID_OV36);
    if (IsPart1Finished()) {
        BeginPart2(SaveBlock2_get());
        RegisterMainOverlay(-1, gApplication_OakSpeech);
    } else {
        RegisterMainOverlay(-1, gApplication_ContinueFieldsys);
    }
    return TRUE;
}

// player sprite tags by state (PLAYER_STATE_*): Ethan, Lyra, and Red (0 = use Ethan's)
static const u16 sPlayerSprites[3][15] = {
    { 0, 21, 178, 258, 176, 180, 407, 188, 196, 198, 200, 248, 260, 423, 297 },
    { 97, 98, 179, 259, 177, 181, 408, 189, 197, 199, 201, 249, 261, 424, 298 },
    { 7000, 7001, 7002, 0, 7003, 7004, 0, 7005, 7006, 7007, 7008, 7009, 0, 0, 0 }, // src/field/overworld_table.c
};

/**
 *  @brief replaces PlayerAvatar_GetSpriteByStateAndGender (0x0205C898): in Part 1 the player is Red
 */
u32 LONG_CALL Chapter_GetPlayerSprite(s32 state, u32 gender)
{
    if (state < 0 || state >= 15) {
        return 0;
    }
    if (Chapter_Get() == CHAPTER_RED && sPlayerSprites[2][state] != 0) {
        return sPlayerSprites[2][state];
    }
    return sPlayerSprites[gender ? 1 : 0][state];
}

u32 LONG_CALL TrainerClass_GetGenderOrTrainerCount(int trainerClass);

/**
 *  @brief replaces TrainerClassToBackpicID (0x0207280C): in Part 1 the player's battle back sprite is Red's (17,
 *         data/graphics/trainer_back_gfx/17.png)
 */
int LONG_CALL Chapter_TrainerClassToBackpic(int trainerClass, BOOL isLink)
{
    switch (trainerClass) {
    case 0: // Ethan
    case 1: // Lyra
        if (isLink) {
            return trainerClass + 15;
        }
        if (Chapter_Get() == CHAPTER_RED) {
            return 17;
        }
        return trainerClass;
    case 23: // rival
        return 2;
    case 123: // Lance
        return 3;
    case 90: case 91: case 92: case 93: case 94: // Cheryl, Riley, Buck, Mira, Marley
        return trainerClass - 86;
    case 125: case 126: // Lucas, Dawn (DP)
        return trainerClass - 116;
    case 127: case 128: // Lucas, Dawn (Pt)
        return trainerClass - 115;
    default:
        return TrainerClass_GetGenderOrTrainerCount(trainerClass) == 1 ? 1 : 0;
    }
}

// overlay 53 (Professor Oak's speech)
#define OakSpeech_PrintDialogMsg ((BOOL (*)(void *data, int msgId, int a2))(0x021E611C | 1))
#define BeginNormalPaletteFade ((void (*)(int screen, int typeTop, int typeBottom, u16 color, int duration, int framesPer, u32 heapId))(0x0200FA24 | 1))
#define OAK_SPEECH_STATE(data) (*(int *)((u8 *)(data) + 0x0C))
#define OAK_SPEECH_PLAYER_GENDER(data) (*(u16 *)((u8 *)(data) + 0x134))
#define OAK_SPEECH_CURSOR_POS(data) (*((u8 *)(data) + 0x163))

/**
 *  @brief the "Are you a boy or a girl?" step of Oak's speech.  Part 1 is always Red, so it skips straight to
 *         "so you're a boy" -> naming.  otherwise it does what the original code did.
 */
void LONG_CALL Chapter_OakSpeechAskGender(void *data)
{
    if (Chapter_Get() == CHAPTER_RED) {
        OAK_SPEECH_PLAYER_GENDER(data) = 0;
        OAK_SPEECH_CURSOR_POS(data) = 0;
        OAK_SPEECH_STATE(data) = 93; // OAK_SPEECH_MAIN_STATE_CONFIRM_GENDER_YES
        return;
    }
    if (OakSpeech_PrintDialogMsg(data, 37, 1) == TRUE) {
        OAK_SPEECH_STATE(data) = 62; // OAK_SPEECH_MAIN_STATE_WAIT_FADE_OUT_TO_ASK_GENDER
        BeginNormalPaletteFade(4, 0, 0, 0, 6, 1, *(u32 *)data); // sub screen, brightness out, black
    }
}

#endif // CHAPTER_SYSTEM

#ifdef CHAPTER_SYSTEM

/**
 *  @brief replaces PlayerProfile_TestBadgeFlag (0x02028F98).  the field moves ask for a Johto badge (Cut: Hive,
 *         Surf: Fog, ...); Red only ever has Kanto badges, so in Part 1 a Johto badge is answered with the Kanto
 *         badge that allows the same move in FireRed (Flash: Boulder, Cut: Cascade, Fly: Thunder, Strength: Rainbow,
 *         Surf: Soul, Waterfall: Volcano).
 */
BOOL LONG_CALL Chapter_TestBadgeFlag(struct PlayerProfile *profile, s32 badge)
{
    // Zephyr, Hive, Plain, Fog, Storm, Mineral, Glacier, Rising -> Kanto badge (8 = Boulder)
    static const u8 sPart1Badge[8] = { 8, 9, 11, 12, 10, 13, 14, 14 };
    const u8 *raw = (const u8 *)profile;

    if (badge < 8 && Chapter_Get() == CHAPTER_RED) {
        badge = sPart1Badge[badge];
    }
    if (badge >= 16) {
        return FALSE;
    }
    if (badge < 8) {
        return (raw[0x1A] >> badge) & 1; // johtoBadges
    }
    return (raw[0x1F] >> (badge - 8)) & 1; // kantoBadges
}

#endif // CHAPTER_SYSTEM
