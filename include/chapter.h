#ifndef CHAPTER_H
#define CHAPTER_H

#include "types.h"
#include "pokemon.h"

/*
 *  hack: two-part game.  Part 1 is FireRed's Kanto played as Red; after Part 1's Hall of Fame the next Continue
 *  starts Part 2 (HeartGold, Ethan or Lyra) on the same save.  only Red's Hall of Fame team carries over, to be
 *  his team at Mt. Silver.
 */

// which part the save is in.  0 = a save from before the two-part system (plays as plain HeartGold)
#define VAR_CHAPTER        0x4166
#define CHAPTER_LEGACY     0
#define CHAPTER_RED        1
#define CHAPTER_GOLD       2

// Part 1 story progress, see asm/include/vars.inc
#define VAR_P1_STORY       0x4167

#define FLAG_GAME_CLEAR    2404

// Part 1 wild tables are encounter narc members 143 + bank (data/EncountersPart1.inc)
#define PART1_ENCOUNTER_OFFSET 143

// Red's team is kept in the unused padding at the end of each PC Box (16 bytes x 30 boxes)
#define CHAPTER_TEAM_MAGIC 0x31444552 // "RED1"
#define CHAPTER_TEAM_SIZE  6

struct PACKED ChapterTeamMon {
    u16 species;
    u8 form;
    u8 level;
    u32 personality;
    u32 ivs; // 5 bits each: hp, atk, def, speed, sp.atk, sp.def
    u16 item;
    u16 moves[4];
    u16 reserved114; // engine bits: ability slot swap, nature override (mints), IV overrides
    u8 reserved113; // engine bits: hidden ability
    u8 ball;
    u8 flags; // bit 0: shiny
    u8 padding[3];
    u16 nickname[11];
}; // 52 bytes

struct PACKED ChapterTeam {
    u32 magic;
    struct ChapterTeamMon mons[CHAPTER_TEAM_SIZE];
}; // 316 bytes

u32 LONG_CALL Chapter_Get(void);
void LONG_CALL Chapter_Location_SetToPlayerRoom(Location *dest);
void LONG_CALL Chapter_Location_SetToOutsidePlayerHome(Location *dest);
BOOL LONG_CALL Chapter_ReadRedTeam(struct ChapterTeam *team);

#endif // CHAPTER_H
