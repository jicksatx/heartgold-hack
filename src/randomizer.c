#include "config.h"
#include "debug.h"
#include "types.h"

#include "constants/species.h"
#include "rtc.h"
#include "save.h"
#include "pokemon.h"

#include "randomizer.h"
#include "nuzlocke.h"
#include "chapter.h"
#include "script.h"

/*
 *  hack: seeded randomizer shared by the starter randomizer and (later) the area randomizer.
 *
 *  the seed is created once per new game, the first time anything asks for it (the starter selection in
 *  Elm's lab comes before any wild encounter), and is kept in two otherwise unused script vars so it is
 *  saved with the game.  everything derived from it is deterministic for that save.
 */

#define RANDOMIZER_SEED_VAR_LO 0x4164
#define RANDOMIZER_SEED_VAR_HI 0x4165

u32 LONG_CALL Randomizer_GetSeed(void)
{
    u32 seed = GetScriptVar(RANDOMIZER_SEED_VAR_LO) | (GetScriptVar(RANDOMIZER_SEED_VAR_HI) << 16);

    if (seed == 0) {
        struct RTCTime time;
        GF_RTC_CopyTime(&time);
        seed = ((u32)gf_rand() << 16) ^ gf_rand() ^ (time.second * 2654435761u) ^ (time.minute << 8);
        if (seed == 0) {
            seed = 0x1D872B41;
        }
        SetScriptVar(RANDOMIZER_SEED_VAR_LO, seed & 0xFFFF);
        SetScriptVar(RANDOMIZER_SEED_VAR_HI, seed >> 16);
    }
    return seed;
}

/**
 *  @brief deterministic hash of (seed, salt) -> 32 bit value.  same inputs always give the same output.
 */
u32 LONG_CALL Randomizer_Hash(u32 seed, u32 salt)
{
    u32 x = seed ^ (salt * 0x9E3779B9u);
    x ^= x >> 16;
    x *= 0x7FEB352Du;
    x ^= x >> 15;
    x *= 0x846CA68Bu;
    x ^= x >> 16;
    return x;
}

// ---------------------------------------------------------------- starters

enum {
    STARTER_GRASS,
    STARTER_FIRE,
    STARTER_WATER,
};

#define STARTER_LINES_PER_TYPE 9
#define KANTO_LINE_INDEX       0 // Bulbasaur / Charmander / Squirtle, the lines Blue's Part 1 trainer data uses
#define JOHTO_LINE_INDEX       1 // Chikorita / Cyndaquil / Totodile, the lines Silver's trainer data uses

// hack: Part 1 (FireRed) offers its own starters (include/chapter.h)
static BOOL Randomizer_IsPart1(void)
{
#ifdef CHAPTER_SYSTEM
    return Chapter_Get() == CHAPTER_RED;
#else
    return FALSE;
#endif
}

// [type][line][stage]
static const u16 sStarterLines[3][STARTER_LINES_PER_TYPE][3] = {
    [STARTER_GRASS] = {
        { SPECIES_BULBASAUR,  SPECIES_IVYSAUR,    SPECIES_VENUSAUR    },
        { SPECIES_CHIKORITA,  SPECIES_BAYLEEF,    SPECIES_MEGANIUM    },
        { SPECIES_TREECKO,    SPECIES_GROVYLE,    SPECIES_SCEPTILE    },
        { SPECIES_TURTWIG,    SPECIES_GROTLE,     SPECIES_TORTERRA    },
        { SPECIES_SNIVY,      SPECIES_SERVINE,    SPECIES_SERPERIOR   },
        { SPECIES_CHESPIN,    SPECIES_QUILLADIN,  SPECIES_CHESNAUGHT  },
        { SPECIES_ROWLET,     SPECIES_DARTRIX,    SPECIES_DECIDUEYE   },
        { SPECIES_GROOKEY,    SPECIES_THWACKEY,   SPECIES_RILLABOOM   },
        { SPECIES_SPRIGATITO, SPECIES_FLORAGATO,  SPECIES_MEOWSCARADA },
    },
    [STARTER_FIRE] = {
        { SPECIES_CHARMANDER, SPECIES_CHARMELEON, SPECIES_CHARIZARD   },
        { SPECIES_CYNDAQUIL,  SPECIES_QUILAVA,    SPECIES_TYPHLOSION  },
        { SPECIES_TORCHIC,    SPECIES_COMBUSKEN,  SPECIES_BLAZIKEN    },
        { SPECIES_CHIMCHAR,   SPECIES_MONFERNO,   SPECIES_INFERNAPE   },
        { SPECIES_TEPIG,      SPECIES_PIGNITE,    SPECIES_EMBOAR      },
        { SPECIES_FENNEKIN,   SPECIES_BRAIXEN,    SPECIES_DELPHOX     },
        { SPECIES_LITTEN,     SPECIES_TORRACAT,   SPECIES_INCINEROAR  },
        { SPECIES_SCORBUNNY,  SPECIES_RABOOT,     SPECIES_CINDERACE   },
        { SPECIES_FUECOCO,    SPECIES_CROCALOR,   SPECIES_SKELEDIRGE  },
    },
    [STARTER_WATER] = {
        { SPECIES_SQUIRTLE,   SPECIES_WARTORTLE,  SPECIES_BLASTOISE   },
        { SPECIES_TOTODILE,   SPECIES_CROCONAW,   SPECIES_FERALIGATR  },
        { SPECIES_MUDKIP,     SPECIES_MARSHTOMP,  SPECIES_SWAMPERT    },
        { SPECIES_PIPLUP,     SPECIES_PRINPLUP,   SPECIES_EMPOLEON    },
        { SPECIES_OSHAWOTT,   SPECIES_DEWOTT,     SPECIES_SAMUROTT    },
        { SPECIES_FROAKIE,    SPECIES_FROGADIER,  SPECIES_GRENINJA    },
        { SPECIES_POPPLIO,    SPECIES_BRIONNE,    SPECIES_PRIMARINA   },
        { SPECIES_SOBBLE,     SPECIES_DRIZZILE,   SPECIES_INTELEON    },
        { SPECIES_QUAXLY,     SPECIES_QUAXWELL,   SPECIES_QUAQUAVAL   },
    },
};

/**
 *  @brief which line (0-8) the seed picked for the given starter type
 */
static u32 Randomizer_GetStarterLine(u32 type)
{
#ifdef RANDOMIZE_STARTERS
    return Randomizer_Hash(Randomizer_GetSeed(), 0x57A27E00 + type + (Randomizer_IsPart1() ? 0x10 : 0)) % STARTER_LINES_PER_TYPE;
#else
    return Randomizer_IsPart1() ? KANTO_LINE_INDEX : JOHTO_LINE_INDEX;
#endif
}

/**
 *  @brief species offered in Elm's lab for slot 0 (grass), 1 (fire), 2 (water)
 */
u16 LONG_CALL Randomizer_GetStarterSpecies(int slot)
{
    if (slot < 0 || slot > 2) {
        return SPECIES_NONE;
    }
    return sStarterLines[slot][Randomizer_GetStarterLine(slot)][0];
}

/**
 *  @brief true if the species is in any starter line (used to keep starters out of the wild)
 */
BOOL LONG_CALL Randomizer_IsStarterLineSpecies(u16 species)
{
    for (int type = 0; type < 3; type++) {
        for (int line = 0; line < STARTER_LINES_PER_TYPE; line++) {
            for (int stage = 0; stage < 3; stage++) {
                if (sStarterLines[type][line][stage] == species) {
                    return TRUE;
                }
            }
        }
    }
    return FALSE;
}

/**
 *  @brief Silver's trainer data uses the Johto starter lines (Blue's in Part 1, the Kanto ones).  swap them for the
 *         randomized line of the same type at the same evolution stage, so the rival still has the starter that is
 *         strong against the player's.
 */
u16 LONG_CALL Randomizer_RemapRivalSpecies(u16 species)
{
#ifdef RANDOMIZE_STARTERS
    u32 line = Randomizer_IsPart1() ? KANTO_LINE_INDEX : JOHTO_LINE_INDEX;
    for (int type = 0; type < 3; type++) {
        for (int stage = 0; stage < 3; stage++) {
            if (sStarterLines[type][line][stage] == species) {
                return sStarterLines[type][Randomizer_GetStarterLine(type)][stage];
            }
        }
    }
#endif
    return species;
}

// ---------------------------------------------------------------- wild encounters

#ifdef RANDOMIZE_WILD_ENCOUNTERS

#include "encounter.h"

extern const u16 sBaseStatTotals[1076];
extern const u16 sWildPool[];
extern const u16 sWildPoolCount;
// base stat total of pool entry i (regional forms aren't in this pool: they're the Safari Zone's, src/field/regional_pool.c)
static s32 PoolBST(s32 i)
{
    return sBaseStatTotals[sWildPool[i]];
}

BOOL LONG_CALL MapHeader_HasWildEncounters(u32 mapId);
u32 LONG_CALL MapHeader_GetWildEncounterBank(u32 mapId);

#define ENCDATA_NARC 37
#define WILD_POOL_MIN_CANDIDATES 8

static BOOL IsExcludedOriginal(u16 species)
{
    // keep legendaries etc. as they are if they ever show up in a table (none do in vanilla HGSS)
    return IS_SPECIES_LEGENDARY(species) || IS_SPECIES_MYTHICAL(species) || IS_SPECIES_SUBLEGEND(species) || IS_SPECIES_ULTRA_BEAST(species);
}

/**
 *  @brief replacement for one wild species in one area.  the same original species in the same area always gets
 *         the same replacement (for this save), chosen among pool species with a similar base stat total.
 *
 *  @param speciesAndForm species | (form << 11) as stored in the encounter table
 *  @param area encounter bank id of the map
 */
u16 LONG_CALL Randomizer_RemapWildSpecies(u16 speciesAndForm, u32 area)
{
    u16 species = speciesAndForm & 0x7FF;

    if (species == SPECIES_NONE || species > 1075 || IsExcludedOriginal(species)) {
        return speciesAndForm;
    }

    s32 target = sBaseStatTotals[species];
    if (target == 0) {
        return speciesAndForm;
    }

    // find the window of pool species whose BST is within +-tolerance of the original; widen until there's enough choice
    s32 tolerance = target / 10;
    if (tolerance < 20) {
        tolerance = 20;
    }
    s32 lo = 0, hi = 0;
    for (;;) {
        lo = 0;
        while (lo < sWildPoolCount && PoolBST(lo) < target - tolerance) {
            lo++;
        }
        hi = lo;
        while (hi < sWildPoolCount && PoolBST(hi) <= target + tolerance) {
            hi++;
        }
        if (hi - lo >= WILD_POOL_MIN_CANDIDATES || (lo == 0 && hi == sWildPoolCount)) {
            break;
        }
        tolerance += 20;
    }

    u32 count = hi - lo;
    u32 pick = Randomizer_Hash(Randomizer_GetSeed(), 0xA4EA0000 ^ (area << 11) ^ species) % count;
    u16 newSpecies = sWildPool[lo + pick];
    if (newSpecies == speciesAndForm && count > 1) {
        newSpecies = sWildPool[lo + (pick + 1) % count];
    }
    return newSpecies;
}

static void RemapList(u16 *list, u32 n, u32 area)
{
    for (u32 i = 0; i < n; i++) {
        list[i] = Randomizer_RemapWildSpecies(list[i], area);
    }
}

static void RemapSlots(EncounterDataSlot *slots, u32 n, u32 area)
{
    for (u32 i = 0; i < n; i++) {
        slots[i].species = Randomizer_RemapWildSpecies(slots[i].species, area);
    }
}

void LONG_CALL Randomizer_RandomizeEncounterTable(EncounterData *enc, u32 area)
{
    RemapList(enc->landSlots.speciesMorning, NUM_ENCOUNTERS_LAND, area);
    RemapList(enc->landSlots.speciesDay, NUM_ENCOUNTERS_LAND, area);
    RemapList(enc->landSlots.speciesNight, NUM_ENCOUNTERS_LAND, area);
    RemapList(enc->hoennSoundSpecies, NUM_ENCOUNTERS_SOUNDS, area);
    RemapList(enc->sinnohSoundSpecies, NUM_ENCOUNTERS_SOUNDS, area);
    RemapSlots(enc->surfSlots, NUM_ENCOUNTERS_SURF, area);
    RemapSlots(enc->rockSmashSlots, NUM_ENCOUNTERS_ROCKSMASH, area);
    RemapSlots(enc->oldRodSlots, NUM_ENCOUNTERS_FISH, area);
    RemapSlots(enc->goodRodSlots, NUM_ENCOUNTERS_FISH, area);
    RemapSlots(enc->superRodSlots, NUM_ENCOUNTERS_FISH, area);
    enc->landSwarm = Randomizer_RemapWildSpecies(enc->landSwarm, area);
    enc->surfSwarm = Randomizer_RemapWildSpecies(enc->surfSwarm, area);
    enc->nightFish = Randomizer_RemapWildSpecies(enc->nightFish, area);
    enc->fishSwarm = Randomizer_RemapWildSpecies(enc->fishSwarm, area);
}

/**
 *  @brief replaces the vanilla WildEncounters_ReadFromNarc (0x0203B88C): loads a map's encounter table, then randomizes it.
 *         everything that reads wild species (grass/surf/fishing/rock smash, swarms, Static/Magnet Pull slot picks) sees the result.
 */
void LONG_CALL WildEncounters_ReadFromNarc(EncounterData *encData, u32 mapno)
{
    memset(encData, 0, sizeof(EncounterData));
    if (MapHeader_HasWildEncounters(mapno)) {
        u32 bank = MapHeader_GetWildEncounterBank(mapno);
        ReadWholeNarcMemberByIdPair(encData, ENCDATA_NARC, bank);
#ifdef CHAPTER_SYSTEM
        // Part 1 (FireRed Kanto) uses FireRed's table where there is one: member 143 + bank, marked with dummy[0]
        if (Chapter_Get() == CHAPTER_RED) {
            ReadWholeNarcMemberByIdPair(encData, ENCDATA_NARC, PART1_ENCOUNTER_OFFSET + bank);
            if (encData->dummy[0] != 1) {
                ReadWholeNarcMemberByIdPair(encData, ENCDATA_NARC, bank);
            }
        }
#endif
        Randomizer_RandomizeEncounterTable(encData, bank);
    }

#ifdef NUZLOCKE_MODE
    // the player's map is (re)loading: move any Pokemon that died since the last map load into the graveyard box
    if (gFieldSysPtr != NULL && gFieldSysPtr->location != NULL && (u32)gFieldSysPtr->location->mapId == mapno) {
        Nuzlocke_BuryDeadPartyMons();
    }
#endif
}

#endif // RANDOMIZE_WILD_ENCOUNTERS

