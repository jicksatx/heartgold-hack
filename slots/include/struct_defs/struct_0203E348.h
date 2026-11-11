#ifndef POKEPLATINUM_STRUCT_0203E348_H
#define POKEPLATINUM_STRUCT_0203E348_H

#include "game_records.h"

// hack: the slot machine's arguments (src/field/slot_machine.c fills them in).  saveCoins is new: on exit the app
// writes the coin count straight back to HeartGold's save.
typedef struct {
    int *unk_00;     // coins (in/out)
    int unk_04;      // machine setting 0-5
    GameRecords *records; // NULL: no game records in this port
    int unk_0C;      // out: consecutive bonus rounds won
    int msgBoxFrame;
    u16 *saveCoins;
    int coins;
} UnkStruct_0203E348;

#endif // POKEPLATINUM_STRUCT_0203E348_H
