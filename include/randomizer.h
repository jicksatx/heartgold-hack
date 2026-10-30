#ifndef RANDOMIZER_H
#define RANDOMIZER_H

#include "types.h"

u32 LONG_CALL Randomizer_GetSeed(void);
u32 LONG_CALL Randomizer_Hash(u32 seed, u32 salt);
u16 LONG_CALL Randomizer_RemapWildSpecies(u16 speciesAndForm, u32 area);
u16 LONG_CALL Randomizer_GetStarterSpecies(int slot);
BOOL LONG_CALL Randomizer_IsStarterLineSpecies(u16 species);
u16 LONG_CALL Randomizer_RemapRivalSpecies(u16 species);

// hack: Mom's randomizer question at the start of Part 1.  "no" sets the seed's high half (var 0x4165) to 0xFFFF, which
// a generated seed never has: starters, wild Pokemon, the Safari Zone, in-game trades and Game Corner prizes then stay
// as in FireRed/HeartGold.  the seed is kept into Part 2 (src/chapter.c), so the choice is too.
BOOL LONG_CALL Randomizer_IsOff(void);

#endif // RANDOMIZER_H
