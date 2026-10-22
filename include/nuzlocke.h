#ifndef NUZLOCKE_H
#define NUZLOCKE_H

#include "types.h"
#include "pokemon.h"

/*
 *  hack: Nuzlocke mode (RadiantRed-style rules), chosen once at the start of a new game.
 *
 *  - only the first wild encounter in each map section can be caught (once you own Poke Balls)
 *  - shiny clause and dupes clause (a dupe can't be caught, but the area stays open)
 *  - scripted/static encounters, roamers, gifts and the Bug-Catching Contest are free extras
 *  - a Pokemon that faints is dead: it is moved into the last PC Box (the graveyard) and can't be
 *    healed or revived
 *  - battle style is forced to Set
 *  - if the whole party is dead the run is over: the save is marked and can't be continued
 */

#define FLAG_NUZLOCKE_ENABLED   2602
#define FLAG_NUZLOCKE_RUN_OVER  2603

// 16 otherwise unused script vars = 256 bits, one per map section (235 map sections in HGSS)
#define NUZLOCKE_AREA_VAR_BASE  0x4152
#define NUZLOCKE_AREA_VAR_COUNT 16

// MON_DATA_RESERVED_114 bit marking a dead Pokemon (bits 0x0001-0x0800 are used by the engine)
#define NUZLOCKE_DEAD_BIT       0x8000

#define NUZLOCKE_GRAVEYARD_BOX  (NUM_PC_BOXES - 1)

// std script 2075 (commonscript entry 075): game over / run ended
#define NUZLOCKE_GAME_OVER_SCRIPT 2075

// reasons a catch is blocked (newBS.nuzlockeCatchBlocked)
#define NUZLOCKE_CATCH_OK          0
#define NUZLOCKE_CATCH_AREA_USED   1
#define NUZLOCKE_CATCH_DUPE        2

BOOL LONG_CALL Nuzlocke_IsActive(void);
BOOL LONG_CALL Nuzlocke_IsAreaUsed(u32 mapsec);
void LONG_CALL Nuzlocke_SetAreaUsed(u32 mapsec);
BOOL LONG_CALL Nuzlocke_IsMonDead(struct PartyPokemon *mon);
void LONG_CALL Nuzlocke_MarkMonDead(struct PartyPokemon *mon);
BOOL LONG_CALL Nuzlocke_IsRunOver(void);
void LONG_CALL Nuzlocke_BuryDeadPartyMons(void);

#endif // NUZLOCKE_H
