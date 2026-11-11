#include "config.h"
#include "debug.h"
#include "types.h"
#include "constants/species.h"
#include "pokemon.h"
#include "randomizer.h"

#ifdef RANDOMIZE_WILD_ENCOUNTERS

/*
 *  hack: the randomizer for headbutt trees and the Bug-Catching Contest.  neither reads the map encounter tables, so
 *  the map-load hook in src/randomizer.c never sees them.
 *
 *  headbutt: a tree's six slots come from the headbutt archive (one file per map).  Task_TryHeadbuttEncounter hands
 *  them to FieldSystem_PerformHeadbuttEncounterCheck; the call is redirected here (hooks), the slots are remapped with
 *  the wild randomizer (a species of similar base stat total, the same one for the same species on the same map for
 *  this save), then the original check runs on the copy.
 *
 *  Bug-Catching Contest: BugContest_New (overlay 24) loads the day's ten slots from data/mushi/mushi_encount.bin into
 *  the contest struct.  after that load each slot becomes a Bug-type Pokemon of Gens 1-9 with a similar base stat total
 *  (src/field/bug_pool.c), no two slots the same.  the judge scores the catch against that same table, so the
 *  remapped species score like the slot they replaced, and the NPC contestants' catches are remapped the same way so
 *  the announcements name Pokemon that are really in the park.
 */

#define NUM_ENCOUNTERS_HEADBUTT 6
#define HEADBUTT_AREA_SALT      0x400 // keeps a map's headbutt picks apart from its grass picks

typedef struct HeadbuttSlot {
    u16 species;
    u8 minLevel;
    u8 maxLevel;
} HeadbuttSlot;

#define FieldSystem_PerformHeadbuttEncounterCheck ((BOOL (*)(void *, void **, const HeadbuttSlot *))(0x02247374 | 1))

extern const u16 sBaseStatTotals[1076];
extern const u16 sBugPool[];
extern const u16 sBugPoolCount;

static u32 Headbutt_GetMapId(FieldSystem *fieldSystem)
{
    return fieldSystem->location != NULL ? (u32)fieldSystem->location->mapId : 0;
}

BOOL LONG_CALL Randomizer_HeadbuttEncounterCheck(FieldSystem *fieldSystem, void **pBattleSetup, const HeadbuttSlot *slots)
{
    if (Randomizer_IsOff()) {
        return FieldSystem_PerformHeadbuttEncounterCheck(fieldSystem, pBattleSetup, slots);
    }
    HeadbuttSlot remapped[NUM_ENCOUNTERS_HEADBUTT];
    u32 area = HEADBUTT_AREA_SALT + Headbutt_GetMapId(fieldSystem);
    for (int i = 0; i < NUM_ENCOUNTERS_HEADBUTT; i++) {
        remapped[i] = slots[i];
        remapped[i].species = Randomizer_RemapWildSpecies(slots[i].species, area);
    }
    return FieldSystem_PerformHeadbuttEncounterCheck(fieldSystem, pBattleSetup, remapped);
}

// ---------------------------------------------------------------- Bug-Catching Contest

#define BUGMON_COUNT            10
#define BUGCONTESTANT_NPC_COUNT 5
#define BUGCONTEST_MIN_CHOICE   4

typedef struct BugMon {
    u16 species;
    u8 lvlmin;
    u8 lvlmax;
    u8 rate;
    u8 score;
    u8 dummy[2];
} BugMon;

typedef struct BugContestant {
    u8 id;
    u16 score;
    u8 national;
    u8 day;
    u16 species;
    u16 dataScore;
    u16 randmod;
} BugContestant;

// pret/pokeheartgold include/bug_contest_internal.h
typedef struct BugContest {
    u32 heapID;
    void *saveData;
    void *partyBak;
    void *partyCur;
    void *mon;
    u8 leadMonIdx;
    u8 partyCurNum;
    u8 dayOfWeek;
    u8 flags;
    u16 sportBalls;
    u16 prize;
    u32 elapsedTime;
    BugMon encounters[BUGMON_COUNT];
    BugContestant contestants[BUGCONTESTANT_NPC_COUNT + 1];
    u8 ranking[BUGCONTESTANT_NPC_COUNT + 1];
} BugContest;

#define BugContest_InitEncounters ((void (*)(BugContest *))(0x02259DF0 | 1))

/**
 *  @brief the window [lo, hi) of sBugPool whose base stat totals are within reach of the original's
 */
static void BugPool_Window(u16 species, u32 *pLo, u32 *pHi)
{
    s32 target = (species <= 1075) ? sBaseStatTotals[species] : 0;
    s32 tolerance = target / 10 < 20 ? 20 : target / 10;
    u32 lo, hi;
    for (;;) {
        lo = 0;
        while (lo < sBugPoolCount && sBaseStatTotals[sBugPool[lo]] < target - tolerance) {
            lo++;
        }
        hi = lo;
        while (hi < sBugPoolCount && sBaseStatTotals[sBugPool[hi]] <= target + tolerance) {
            hi++;
        }
        if (hi - lo >= BUGCONTEST_MIN_CHOICE || (lo == 0 && hi == sBugPoolCount)) {
            break;
        }
        tolerance += 20;
    }
    *pLo = lo;
    *pHi = hi;
}

static u16 BugPool_Remap(u16 species, u32 set, const u16 *taken, u32 numTaken)
{
    u32 lo, hi;
    BugPool_Window(species, &lo, &hi);
    u32 count = hi - lo;
    u32 pick = Randomizer_Hash(Randomizer_GetSeed(), 0xB06C0000 ^ (set << 11) ^ species) % count;
    // no two contest slots the same: step through the window, then out of it, until a free species turns up
    for (u32 tries = 0; tries < sBugPoolCount; tries++) {
        u16 cand = (tries < count) ? sBugPool[lo + (pick + tries) % count] : sBugPool[(lo + tries) % sBugPoolCount];
        BOOL used = FALSE;
        for (u32 i = 0; i < numTaken; i++) {
            if (taken[i] == cand) {
                used = TRUE;
                break;
            }
        }
        if (!used) {
            return cand;
        }
    }
    return sBugPool[lo + pick];
}

void LONG_CALL Randomizer_BugContestInitEncounters(BugContest *contest)
{
    BugContest_InitEncounters(contest);
    if (Randomizer_IsOff()) {
        return;
    }

    u16 original[BUGMON_COUNT], remapped[BUGMON_COUNT];
    u32 set = contest->dayOfWeek; // the national-dex sets change by weekday; the same day keeps the same Pokemon
    for (u32 i = 0; i < BUGMON_COUNT; i++) {
        original[i] = contest->encounters[i].species;
        remapped[i] = SPECIES_NONE;
        for (u32 j = 0; j < i; j++) {
            if (original[j] == original[i]) {
                remapped[i] = remapped[j]; // the same Pokemon in two slots stays the same Pokemon
            }
        }
        if (remapped[i] == SPECIES_NONE) {
            remapped[i] = BugPool_Remap(original[i], set, remapped, i);
        }
    }
    for (u32 i = 0; i < BUGMON_COUNT; i++) {
        contest->encounters[i].species = remapped[i];
    }

    // the NPCs' catches name a Pokemon from the table they were drawn from
    for (u32 n = 0; n < BUGCONTESTANT_NPC_COUNT; n++) {
        u16 species = contest->contestants[n].species;
        u32 i;
        for (i = 0; i < BUGMON_COUNT; i++) {
            if (original[i] == species) {
                contest->contestants[n].species = remapped[i];
                break;
            }
        }
        if (i == BUGMON_COUNT && species != SPECIES_NONE) {
            contest->contestants[n].species = remapped[Randomizer_Hash(Randomizer_GetSeed(), 0xB06C0100 + species) % BUGMON_COUNT];
        }
    }
}

#endif // RANDOMIZE_WILD_ENCOUNTERS
