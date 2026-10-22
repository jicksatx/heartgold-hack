#include "config.h"
#include "debug.h"
#include "types.h"

#include "constants/save.h"
#include "constants/species.h"
#include "pokemon.h"
#include "pokemon_storage_system.h"
#include "save.h"
#include "script.h"

#include "nuzlocke.h"

/*
 *  hack: Nuzlocke mode helpers that live in the always-loaded code (field and battle both call these).
 *  see include/nuzlocke.h for the rules.
 */

#ifdef NUZLOCKE_MODE

#define SAVE_PCSTORAGE 41

void *SaveArray_Get(SaveData *saveData, int id);
BOOL PCStorage_PlaceMonInFirstEmptySlotInAnyBox(PCStorage *storage, struct BoxPokemon *boxMon);

BOOL LONG_CALL Nuzlocke_IsActive(void)
{
    return CheckScriptFlag(FLAG_NUZLOCKE_ENABLED);
}

BOOL LONG_CALL Nuzlocke_IsAreaUsed(u32 mapsec)
{
    if (mapsec >= NUZLOCKE_AREA_VAR_COUNT * 16) {
        return FALSE;
    }
    return (GetScriptVar(NUZLOCKE_AREA_VAR_BASE + mapsec / 16) >> (mapsec % 16)) & 1;
}

void LONG_CALL Nuzlocke_SetAreaUsed(u32 mapsec)
{
    if (mapsec >= NUZLOCKE_AREA_VAR_COUNT * 16) {
        return;
    }
    u16 var = NUZLOCKE_AREA_VAR_BASE + mapsec / 16;
    SetScriptVar(var, GetScriptVar(var) | (1 << (mapsec % 16)));
}

BOOL LONG_CALL Nuzlocke_IsMonDead(struct PartyPokemon *mon)
{
    return (GetMonData(mon, MON_DATA_RESERVED_114, NULL) & NUZLOCKE_DEAD_BIT) != 0;
}

void LONG_CALL Nuzlocke_MarkMonDead(struct PartyPokemon *mon)
{
    u32 bits = GetMonData(mon, MON_DATA_RESERVED_114, NULL) | NUZLOCKE_DEAD_BIT;
    u32 hp = 0;
    SetMonData(mon, MON_DATA_RESERVED_114, &bits);
    SetMonData(mon, MON_DATA_HP, &hp);
}

/**
 *  @brief the party has dead Pokemon and no living (non-egg) ones.  an empty party (before the starter) isn't a wipe.
 */
static BOOL PartyIsWipedOut(struct Party *party)
{
    BOOL anyDead = FALSE;

    for (int i = 0; i < party->count; i++) {
        struct PartyPokemon *mon = Party_GetMonByIndex(party, i);
        if (GetMonData(mon, MON_DATA_SPECIES, NULL) == 0 || GetMonData(mon, MON_DATA_IS_EGG, NULL)) {
            continue;
        }
        if (!Nuzlocke_IsMonDead(mon)) {
            return FALSE;
        }
        anyDead = TRUE;
    }
    return anyDead;
}

BOOL LONG_CALL Nuzlocke_IsRunOver(void)
{
    if (!Nuzlocke_IsActive()) {
        return FALSE;
    }
    if (CheckScriptFlag(FLAG_NUZLOCKE_RUN_OVER)) {
        return TRUE;
    }
    return PartyIsWipedOut(SaveData_GetPlayerPartyPtr(SaveBlock2_get()));
}

static const u16 sGraveyardName[] = { 0x0131, 0x013C, 0x012B, 0x0140, 0x012F, 0x0143, 0x012B, 0x013C, 0x012E, 0xFFFF }; // GRAVEYARD

/**
 *  @brief move every dead Pokemon from the party into the graveyard box (last PC Box).  runs on every map load.
 *         never empties the party: a full wipe is a game over instead.
 */
void LONG_CALL Nuzlocke_BuryDeadPartyMons(void)
{
    if (!Nuzlocke_IsActive()) {
        return;
    }

    SaveData *saveData = SaveBlock2_get();
    struct Party *party = SaveData_GetPlayerPartyPtr(saveData);
    PCStorage *storage = SaveArray_Get(saveData, SAVE_PCSTORAGE);
    int i;

    for (i = 0; i < (int)NELEMS(sGraveyardName); i++) {
        if (storage->box_names[NUZLOCKE_GRAVEYARD_BOX][i] != sGraveyardName[i]) {
            storage->box_names[NUZLOCKE_GRAVEYARD_BOX][i] = sGraveyardName[i];
            PCStorage_SetBoxModified(storage, NUZLOCKE_GRAVEYARD_BOX);
        }
    }

    if (PartyIsWipedOut(party)) {
        return;
    }

    for (i = party->count - 1; i >= 0; i--) {
        struct PartyPokemon *mon = Party_GetMonByIndex(party, i);
        if (!Nuzlocke_IsMonDead(mon) || party->count <= 1) {
            continue;
        }
        if (PCStorage_PlaceMonInBoxFirstEmptySlot(storage, NUZLOCKE_GRAVEYARD_BOX, &mon->box)
            || PCStorage_PlaceMonInFirstEmptySlotInAnyBox(storage, &mon->box)) {
            PokeParty_Delete(party, i);
        } else {
            // every box is full: keep it in the party, but it stays fainted
            u32 hp = 0;
            SetMonData(mon, MON_DATA_HP, &hp);
        }
    }
}

/**
 *  @brief replaces the vanilla map scene-script lookup (0x0204080C).  once a Nuzlocke run is over, every map
 *         runs the game-over script as soon as the player has control, so the save can't be continued.
 *
 *  @param fsys field system
 *  @param header map script header
 *  @param type header entry type (1 = scene scripts)
 *  @return script id to run, or 0xFFFF for none
 */
u16 LONG_CALL Nuzlocke_GetMapSceneScriptId(FieldSystem *fsys, u8 *header, u8 type)
{
    u32 ofs;

    if (Nuzlocke_IsRunOver()) {
        return NUZLOCKE_GAME_OVER_SCRIPT;
    }

    while (1) {
        if (header[0] == 0) {
            return 0xFFFF;
        } else if (header[0] == type) {
            ofs = header[1] + (header[2] << 8) + (header[3] << 16) + (header[4] << 24);
            header += 5;
            break;
        } else {
            header += 5;
        }
    }
    if (ofs == 0) {
        return 0xFFFF;
    }
    header += ofs;
    while (1) {
        u16 var1 = header[0] + (header[1] << 8);
        if (var1 == 0) {
            return 0xFFFF;
        }
        u16 var2 = header[2] + (header[3] << 8);
        if (VarGet(fsys, var1) == VarGet(fsys, var2)) {
            return header[4] + (header[5] << 8);
        }
        header += 6;
    }
}

#endif // NUZLOCKE_MODE
