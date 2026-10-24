#include "config.h"
#include "debug.h"
#include "types.h"
#include "constants/species.h"
#include "randomizer.h"

#ifdef RANDOMIZE_WILD_ENCOUNTERS

/*
 *  hack: the Safari Zone (Part 2's, and Part 1's stand-in) reads its encounters from its own data (a/2/3/2, one file per
 *  area type) instead of the map encounter tables, so the map-load hook above never sees them.  this replaces the
 *  loader, SafariZoneAreaSet_LoadAreaEncounters (0x020974C4), with the same logic plus the remap.  each area type is its
 *  own randomizer area.  the Safari Zone is the only place regional forms appear (Safari_Remap): the route pool
 *  has none, and every Safari slot becomes a regional form of similar strength.  the Safari encounter goes through the
 *  same wild-Pokemon builder as the routes, which reads the form from the top bits of the species.
 */

#define SAFARI_NARC              232
#define NUM_ENCOUNTERS_SAFARI    10
#define NUM_SAFARI_ENC_TYPES     5
#define TIMEOFDAY_WILD_MAX       3
#define SAFARI_AREA_SIZE         122

typedef struct SafariSlot {
    u32 species;
    u16 minLevel;
    u16 maxLevel;
} SafariSlot;

typedef struct SafariAreaSlot {
    u16 species;
    u16 level;
} SafariAreaSlot;

typedef struct SafariUnlock {
    u8 object1Type;
    u8 object1Level;
    u8 object2Type;
    u8 object2Level;
} SafariUnlock;

#define GfGfxLoader_LoadFromNarc ((void *(*)(u32, u32, u32, u32, u32))(0x02007A44 | 1))
#define SafariZoneAreaSet_GetObjectsInArea ((void (*)(void *, int, u8 *))(0x02097694 | 1))

extern const u16 sBaseStatTotals[1076];
extern const u16 sRegionalPool[][2];
extern const u16 sRegionalPoolCount;

/**
 *  @brief the Safari Zone is the only place regional forms appear: each Safari species becomes a regional form with a
 *         similar base stat total (the same one for the same species and area type, for this save).
 */
static u16 Safari_Remap(u16 species, u32 areaNo)
{
    species &= 0x7FF;
    if (species == SPECIES_NONE || species > 1075 || sBaseStatTotals[species] == 0) {
        return species;
    }
    s32 target = sBaseStatTotals[species];
    s32 tolerance = target / 10 < 20 ? 20 : target / 10;
    u32 lo, hi;
    for (;;) {
        lo = 0;
        while (lo < sRegionalPoolCount && sRegionalPool[lo][1] < target - tolerance) {
            lo++;
        }
        hi = lo;
        while (hi < sRegionalPoolCount && sRegionalPool[hi][1] <= target + tolerance) {
            hi++;
        }
        if (hi - lo >= 4 || (lo == 0 && hi == sRegionalPoolCount)) {
            break;
        }
        tolerance += 20;
    }
    u32 pick = Randomizer_Hash(Randomizer_GetSeed(), 0x5AFA0000 ^ (areaNo << 11) ^ species) % (hi - lo);
    return sRegionalPool[lo + pick][0];
}

void *LONG_CALL Randomizer_SafariLoadAreaEncounters(u8 *areaSet, int area, int encounterType, int timeOfDay, u32 heapId)
{
    u32 areaNo = areaSet[area * SAFARI_AREA_SIZE];
    SafariSlot *ret = sys_AllocMemoryLo(heapId, NUM_ENCOUNTERS_SAFARI * sizeof(SafariSlot));

    for (int i = 0; i < NUM_ENCOUNTERS_SAFARI; i++) {
        ret[i].species = (encounterType == 0) ? SPECIES_RATTATA : SPECIES_MAGIKARP;
        ret[i].maxLevel = ret[i].minLevel = 5;
    }

    u8 *arc = GfGfxLoader_LoadFromNarc(SAFARI_NARC, areaNo, FALSE, heapId, TRUE);
    if (arc == NULL) {
        return ret;
    }

    SafariAreaSlot *baseMons[NUM_SAFARI_ENC_TYPES], *bonusMons[NUM_SAFARI_ENC_TYPES];
    SafariUnlock *unlocks[NUM_SAFARI_ENC_TYPES];
    u8 numBonus[NUM_SAFARI_ENC_TYPES];
    int offset = 8;
    for (int i = 0; i < NUM_SAFARI_ENC_TYPES; i++) {
        baseMons[i] = (SafariAreaSlot *)&arc[offset];
        offset += TIMEOFDAY_WILD_MAX * NUM_ENCOUNTERS_SAFARI * sizeof(SafariAreaSlot);
        bonusMons[i] = (SafariAreaSlot *)&arc[offset];
        numBonus[i] = arc[i];
        offset += TIMEOFDAY_WILD_MAX * numBonus[i] * sizeof(SafariAreaSlot);
        unlocks[i] = (SafariUnlock *)&arc[offset];
        offset += numBonus[i] * sizeof(SafariUnlock);
    }
    if (numBonus[1] == 0 && encounterType > 0) {
        sys_FreeMemoryEz(arc);
        return ret;
    }

    offset = NUM_ENCOUNTERS_SAFARI * timeOfDay;
    for (int i = 0; i < NUM_ENCOUNTERS_SAFARI; i++) {
        SafariAreaSlot *slot = &baseMons[encounterType][offset + i];
        ret[i].species = Safari_Remap(slot->species, areaNo);
        ret[i].maxLevel = ret[i].minLevel = slot->level;
    }

    u8 objectLevels[8];
    u8 n = 0;
    SafariZoneAreaSet_GetObjectsInArea(areaSet, area, objectLevels);
    for (int i = 0; i < numBonus[encounterType]; i++) {
        SafariUnlock *u = &unlocks[encounterType][i];
        if (objectLevels[u->object1Type - 1] < u->object1Level) {
            continue;
        }
        if (u->object2Type != 0 && objectLevels[u->object2Type - 1] < u->object2Level) {
            continue;
        }
        SafariAreaSlot *slot = &bonusMons[encounterType][numBonus[encounterType] * timeOfDay + i];
        ret[n].species = Safari_Remap(slot->species, areaNo);
        ret[n].maxLevel = ret[n].minLevel = slot->level;
        if (++n > NUM_ENCOUNTERS_SAFARI - 1) {
            break;
        }
    }

    sys_FreeMemoryEz(arc);
    return ret;
}

#endif // RANDOMIZE_WILD_ENCOUNTERS
