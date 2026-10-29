#include "config.h"
#include "types.h"

#include "constants/ability.h"
#include "constants/battle_script_constants.h"
#include "constants/file.h"
#include "constants/item.h"
#include "constants/move_effects.h"
#include "constants/moves.h"
#include "constants/species.h"
#include "constants/system_control.h"
#include "chapter.h"

#include "battle.h"
#include "item.h"
#include "mega.h"
#include "nuzlocke.h"
#include "pokemon_storage_system.h"
#include "save.h"
#include "bag.h"
#include "overlay.h"
#include "pokemon.h"

#ifdef DEBUG_BATTLE_SCENARIOS
#include "test_battle.h"
#endif // DEBUG_BATTLE_SCENARIOS

/********************************************************************************************************************/
/********************************************************************************************************************/
//                                                战斗前准备
/********************************************************************************************************************/
/********************************************************************************************************************/
// bubble lives on in the repository o7
// would not be here without him

#ifdef NUZLOCKE_MODE

_Static_assert(offsetof(struct BattleSystem, options) == 0x1B4, "BattleSystem options offset");
_Static_assert(offsetof(struct BattleSystem, battleSpecial) == 0x240C, "BattleSystem battleSpecial offset");

#define SAVE_PCSTORAGE 41

extern const u16 sNuzlockeFamilyRoot[1076];
void *SaveArray_Get(SaveData *saveData, int id);

static u16 Nuzlocke_GetFamilyRoot(u16 species)
{
    if (species == 0 || species > SPECIES_PECHARUNT) {
        return species;
    }
    u16 root = sNuzlockeFamilyRoot[species];
    return root ? root : species;
}

static BOOL BoxMonIsInFamily(struct BoxPokemon *boxMon, u16 root)
{
    BOOL wasFast = BoxMonSetFastModeOn(boxMon); // decrypt once for both reads
    u16 species = GetBoxMonData(boxMon, MON_DATA_SPECIES, NULL);
    BOOL isEgg = GetBoxMonData(boxMon, MON_DATA_IS_EGG, NULL);
    BoxMonSetFastModeOff(boxMon, wasFast);

    if (species == 0 || isEgg) {
        return FALSE;
    }
    return Nuzlocke_GetFamilyRoot(species) == root;
}

/**
 *  @brief dupes clause: does the player already have (in the party, any PC Box, or the graveyard) a Pokemon
 *         from the same evolution family?
 */
static BOOL Nuzlocke_PlayerOwnsFamily(u16 species)
{
    SaveData *saveData = SaveBlock2_get();
    struct Party *party = SaveData_GetPlayerPartyPtr(saveData);
    PCStorage *storage = SaveArray_Get(saveData, SAVE_PCSTORAGE);
    u16 root = Nuzlocke_GetFamilyRoot(species);
    int i, j;

    for (i = 0; i < party->count; i++) {
        if (BoxMonIsInFamily(&party->members[i].box, root)) {
            return TRUE;
        }
    }
    for (i = 0; i < NUM_PC_BOXES; i++) {
        for (j = 0; j < MONS_PER_BOX; j++) {
            struct BoxPokemon *boxMon = &storage->boxes[i].mons[j];
            if (boxMon->pid == 0 && boxMon->checksum == 0) {
                continue; // empty slot, skip the decryption
            }
            if (BoxMonIsInFamily(boxMon, root)) {
                return TRUE;
            }
        }
    }
    return FALSE;
}

/**
 *  @brief hack: Nuzlocke rules applied when a battle starts.
 *         decides whether the wild Pokemon may be caught (first encounter per map section, shiny and dupes clauses,
 *         scripted encounters/roamers/Bug Contest are free) and forces the Set battle style.
 *
 *  @param bw battle work structure
 */
static void Nuzlocke_BattleStart(struct BattleSystem *bw)
{
    u32 battleType = BattleTypeGet(bw);
    struct PartyPokemon *wildMon;
    u16 species, root;
    int i;

    newBS.nuzlockeCatchBlocked = NUZLOCKE_CATCH_OK;
    newBS.nuzlockeFaintMask = 0;

    if (!Nuzlocke_IsActive()) {
        return;
    }

    // forced Set style: the battle uses its own copy of the options, so the player's setting is left alone
    if (bw->options != NULL) {
        bw->options->battleStyle = 1;
    }

    if (battleType & (BATTLE_TYPE_TRAINER | BATTLE_TYPE_LINK | BATTLE_TYPE_FRONTIER | BATTLE_TYPE_ROAMER
                      | BATTLE_TYPE_PAL_PARK | BATTLE_TYPE_TUTORIAL | BATTLE_TYPE_BUG_CONTEST)) {
        return;
    }
    if (bw->battleSpecial & BATTLE_SPECIAL_LEGENDARY) { // scripted/static encounter: a free extra
        return;
    }

    wildMon = BattleWorkPokemonParamGet(bw, 1, 0);
    species = GetMonData(wildMon, MON_DATA_SPECIES, NULL);
    if (species == 0) {
        return;
    }
    if (MonIsShiny(wildMon)) { // shiny clause
        return;
    }
    if (!(battleType & BATTLE_TYPE_SAFARI) && !Bag_PocketNotEmpty(bw->bag, POCKET_BALLS)) {
        return; // encounters only count once the player can actually catch something
    }
    if (Nuzlocke_IsAreaUsed(bw->location)) {
        newBS.nuzlockeCatchBlocked = NUZLOCKE_CATCH_AREA_USED;
        return;
    }

    // dupes clause: the area stays open if this family is already owned
    root = Nuzlocke_GetFamilyRoot(species);
    if (Nuzlocke_PlayerOwnsFamily(species)) {
        newBS.nuzlockeCatchBlocked = NUZLOCKE_CATCH_DUPE;
        return;
    }
    for (i = 1; i <= SPECIES_ARCEUS; i++) { // the vanilla Pokedex only tracks the first 493
        if (Nuzlocke_GetFamilyRoot(i) == root && Battle_CheckIfHasCaughtMon(bw, i)) {
            newBS.nuzlockeCatchBlocked = NUZLOCKE_CATCH_DUPE;
            return;
        }
    }

    Nuzlocke_SetAreaUsed(bw->location);
}

#endif // NUZLOCKE_MODE

/**
 *  @brief initialize the global battle structure and return it
 *
 *  @param bw battle work structure
 */
struct BattleStruct *ServerInit(struct BattleSystem *bw)
{
    struct BattleStruct *sp;

    sp = sys_AllocMemory(HEAPID_BATTLE_HEAP, sizeof(struct BattleStruct));
    memset(sp, 0, sizeof(struct BattleStruct));
    BattleStructureInit(sp);
    BattleStructureCounterInit(bw, sp);
    ServerMoveAIInit(bw, sp);
    DumpMoveTableData(&sp->moveTbl[0]);
    sp->aiWorkTable.item = ItemDataTableLoad(HEAPID_BATTLE_HEAP);

#ifdef RESTORE_ITEMS_AT_BATTLE_END

    // store items for the player's party in sp so we can restore them at the end
    struct Party *party = SaveData_GetPlayerPartyPtr(SaveBlock2_get());
    for (int i = 0; i < party->count; i++) {
        newBS.itemsToRestore[i] = GetMonData(Party_GetMonByIndex(party, i), MON_DATA_HELD_ITEM, NULL);
    }

#endif // RESTORE_ITEMS_AT_BATTLE_END

#ifdef CHAPTER_SYSTEM
    // hack: on Part 1's Sevii stand-ins the battle's map section (met location, Nuzlocke area) is the Sevii place
    // (src/field/chapter_field.c)
    bw->location = Chapter_SeviiMapSec(bw->location);
#endif // CHAPTER_SYSTEM

#ifdef NUZLOCKE_MODE
    Nuzlocke_BattleStart(bw);
#endif // NUZLOCKE_MODE

    sp->original_terrain = bw->terrain;
    sp->original_bgId = bw->bgId;
    bw->sp = sp;
    BattleBgExpansionLoader(bw);

    gBattleSystem = bw;

#ifdef DEBUG_BATTLE_SCENARIOS
    // Apply test battle state (recharge, charging, etc.)
    TestBattle_ApplyBattleState(sp);
#endif

    return sp;
}

/**
 *  @brief actions that take precedence over all moves
 *         loads in battle sub script and queues it up by setting server_seq_no to 22
 *
 *  @param bw battle work structure
 *  @param sp global battle structure
 */
u32 ServerBeforeAct_restoreOverlay = 0;

void ServerBeforeAct(struct BattleSystem *bsys, struct BattleStruct *ctx)
{
    u32 ovyId = OVERLAY_SERVERBEFOREACT, offset = 0x021FD900 | 1;

    void (*internalFunc)(struct BattleSystem *bsys, struct BattleStruct *ctx);

    // if ctx->sba_seq_no == SBA_RESET_DEFIANT before func is called, it is the first call
    // if (ctx->sba_seq_no == SBA_RESET_DEFIANT)
    {
        if (IsOverlayLoaded(OVERLAY_WIFI)) { // we are taking overlay 0's place
            ServerBeforeAct_restoreOverlay = TRUE;
            UnloadOverlayByID(OVERLAY_WIFI);
        } else if (IsOverlayLoaded(OVERLAY_POKEDEX)) {
            ServerBeforeAct_restoreOverlay = OVERLAY_POKEDEX;
            UnloadOverlayByID(18);
        }

        // #ifdef DEBUG_BEFORE_MOVE_LOGIC
        //         debug_printf("Load OVERLAY_SERVERBEFOREACT\n");
        // #endif

        HandleLoadOverlay(ovyId, 2);
    }
    internalFunc = (void (*)(struct BattleSystem *bsys, struct BattleStruct *ctx))(offset);
    internalFunc(bsys, ctx);

    // if (ctx->sba_seq_no == SBA_RESET_DEFIANT)
    {
        if (ServerBeforeAct_restoreOverlay) {
            UnloadOverlayByID(ovyId);
            // #ifdef DEBUG_BEFORE_MOVE_LOGIC
            //             debug_printf("Restoring overlay %d...\n", (ServerBeforeAct_restoreOverlay == 1 ? 0 : ServerBeforeAct_restoreOverlay));
            // #endif
            HandleLoadOverlay(ServerBeforeAct_restoreOverlay == 1 ? OVERLAY_WIFI : ServerBeforeAct_restoreOverlay, 2);
        }
    }
}

/********************************************************************************************************************/
/********************************************************************************************************************/
//                                                技能使用前判断
/********************************************************************************************************************/
/********************************************************************************************************************/

// 08014ACC

/**
 *  @brief run through everything before any of the moves are used
 *         modified for protean and stance change and megas
 *
 *  @param bw battle work structure
 *  @param sp global battle structure
 */
u32 ServerWazaBefore_restoreOverlay = 0;

void ServerWazaBefore(void *bw, struct BattleStruct *sp)
{
    // #ifdef DEBUG_BEFORE_MOVE_LOGIC
    //     debug_printf("In BattleController_BeforeMove landing pad\n");
    // #endif
    u32 ovyId, offset;

    void (*internalFunc)(void *bw, struct BattleStruct *sp);

    // if wb_seq_no == BEFORE_MOVE_START_FLAG_UNLOAD before func is called, it is the first call
    if (sp->wb_seq_no == BEFORE_MOVE_START_FLAG_UNLOAD) {
        if (IsOverlayLoaded(OVERLAY_WIFI)) { // we are taking overlay 0's place
            ServerWazaBefore_restoreOverlay = TRUE;
            UnloadOverlayByID(OVERLAY_WIFI);
        } else if (IsOverlayLoaded(OVERLAY_POKEDEX)) {
            ServerWazaBefore_restoreOverlay = OVERLAY_POKEDEX;
            UnloadOverlayByID(OVERLAY_POKEDEX);
        }

        // #ifdef DEBUG_BEFORE_MOVE_LOGIC
        //         debug_printf("Load OVERLAY_BATTLECONTROLLER_BEFOREMOVE\n");
        // #endif
        ovyId = OVERLAY_BATTLECONTROLLER_BEFOREMOVE;

        // offset = 0x023C0400 | 1;
        HandleLoadOverlay(ovyId, 2);
    }

    offset = 0x021E5900 | 1;
    internalFunc = (void (*)(void *bw, struct BattleStruct *sp))(offset);
    internalFunc(bw, sp);

    // if wb_seq_no == BEFORE_MOVE_START_FLAG_UNLOAD after the func is called, it is the last call
    if (sp->wb_seq_no == BEFORE_MOVE_START_FLAG_UNLOAD) {
        // needs to unload regardless of if it took OVERLAY_POKEDEX space
        UnloadOverlayByID(ovyId);
        if (ServerWazaBefore_restoreOverlay) {
            // #ifdef DEBUG_BEFORE_MOVE_LOGIC
            //             debug_printf("Restoring overlay %d...\n", (ServerWazaBefore_restoreOverlay == 1 ? 0 : ServerWazaBefore_restoreOverlay));
            // #endif
            HandleLoadOverlay(ServerWazaBefore_restoreOverlay == 1 ? OVERLAY_WIFI : ServerWazaBefore_restoreOverlay, 2);
            ServerWazaBefore_restoreOverlay = FALSE;
        }
    }
}
