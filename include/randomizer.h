#ifndef RANDOMIZER_H
#define RANDOMIZER_H

#include "types.h"

u32 LONG_CALL Randomizer_GetSeed(void);
u32 LONG_CALL Randomizer_Hash(u32 seed, u32 salt);
u16 LONG_CALL Randomizer_RemapWildSpecies(u16 speciesAndForm, u32 area);
u16 LONG_CALL Randomizer_GetStarterSpecies(int slot);
BOOL LONG_CALL Randomizer_IsStarterLineSpecies(u16 species);
u16 LONG_CALL Randomizer_RemapRivalSpecies(u16 species);

#endif // RANDOMIZER_H
