#include "config.h"
#include "debug.h"
#include "types.h"

#include "chapter.h"
#include "randomizer.h"
#include "script.h"

/*
 *  hack: two-part game, field side (include/chapter.h).
 *
 *  Part 1 (FireRed's Kanto) reuses HeartGold's Kanto maps, but gives them their own events, scripts and text.  the
 *  four map header lookups the field makes for those are replaced here: in Part 1, a map listed in sPart1Maps uses
 *  the listed narc members instead of its HeartGold ones.  everything else (matrix, music, wild bank, map name) still
 *  comes from the map header.
 */

#ifdef CHAPTER_SYSTEM

struct Part1Map {
    u16 mapId;
    u16 events;       // zone_event (a/0/3/2) member
    u16 scripts;      // scr_seq (a/0/1/2) member
    u16 scriptHeader; // scr_seq (a/0/1/2) member
    u16 msg;          // msg (a/0/2/7) archive
};

// keep in sync with data/eventdata/part1/, data/scr_seq/scr_seq_009xx_P1_*.s and data/text/85x.txt
static const struct Part1Map sPart1Maps[] = {
    { 49,  491, 965, 966, 854 }, // Pallet Town
    { 505, 492, 967, 968, 855 }, // Professor Oak's Lab
    { 504, 493, 969, 970, 856 }, // Blue's house 1F
    { 9,   494, 971, 970, 859 }, // Route 1
    { 50,  495, 972, 970, 857 }, // Viridian City
    { 500, 496, 973, 974, 858 }, // Viridian City Poke Mart
    { 27,  497, 975, 976, 860 }, // Route 22
    { 10,  498, 977, 970, 864 }, // Route 2 (south)
    { 414, 499, 977, 970, 864 }, // Route 2 (north)
    { 147, 500, 978, 970, 863 }, // Viridian Forest
    { 51,  501, 979, 980, 862 }, // Pewter City
    { 473, 502, 981, 970, 861 }, // Pewter Gym
    { 11,  503, 982, 970, 865 }, // Route 3
    { 107, 504, 983, 984, 866 }, // Mt. Moon
    { 12,  505, 985, 970, 867 }, // Route 4
    { 52,  506, 986, 992, 868 }, // Cerulean City
    { 28,  507, 987, 970, 869 }, // Route 24 (Nugget Bridge)
    { 29,  508, 988, 970, 870 }, // Route 25
    { 440, 509, 989, 990, 871 }, // Sea Cottage
    { 427, 510, 991, 970, 872 }, // Cerulean Gym
    { 13,  511, 993, 970, 873 }, // Route 5
    { 14,  512, 994, 970, 874 }, // Route 6
    { 391, 513, 995, 970, 875 }, // Route 5 Saffron gatehouse
    { 389, 514, 995, 970, 875 }, // Route 6 Saffron gatehouse
    { 54,  515, 996, 970, 876 }, // Vermilion City
    { 386, 516, 997, 970, 877 }, // Vermilion harbor building
    { 307, 517, 998, 999, 878 }, // S.S. Anne (S.S. Aqua) deck
    { 310, 518, 998, 970, 878 }, // S.S. Anne cabins
    { 309, 519, 998, 970, 878 },
    { 311, 520, 998, 970, 878 },
    { 328, 521, 998, 970, 878 },
    { 329, 522, 998, 970, 878 }, // S.S. Anne hold
    { 308, 523, 1000, 970, 879 }, // S.S. Anne captain's office
    { 365, 524, 1001, 1002, 880 }, // Vermilion Gym
    { 19,  525, 1003, 970, 881 }, // Route 11
    { 106, 526, 1003, 970, 881 }, // Diglett's Cave
    { 17,  527, 1004, 970, 882 }, // Route 9
    { 18,  528, 1005, 970, 883 }, // Route 10 (north)
    { 388, 529, 1005, 970, 883 }, // Route 10 (south)
    { 108, 530, 1005, 970, 883 }, // Rock Tunnel 1F
    { 452, 531, 1005, 970, 883 }, // Rock Tunnel B1F
    { 53,  532, 1006, 970, 884 }, // Lavender Town
    { 16,  533, 1008, 970, 885 }, // Route 8
    { 390, 534, 1009, 970, 887 }, // Route 8 Saffron gatehouse
    { 493, 535, 1009, 970, 887 }, // Route 7 Saffron gatehouse
    { 15,  536, 1007, 970, 886 }, // Route 7
    { 55,  537, 1010, 970, 888 }, // Celadon City
    { 395, 538, 1011, 970, 889 }, // Celadon Gym
    { 376, 539, 1012, 970, 890 }, // Celadon Condominiums 1F
    { 381, 540, 1013, 970, 891 }, // Rocket Game Corner (the Japanese release's Game Corner map)
    { 247, 541, 1014, 970, 892 }, // Rocket Hideout B1F (Team Rocket HQ)
    { 248, 542, 1014, 970, 892 }, // Rocket Hideout B2F
    { 249, 543, 1014, 970, 892 }, // Rocket Hideout B3F
    { 110, 544, 1015, 1016, 893 }, // Pokemon Tower 1F (Sprout Tower)
    { 155, 545, 1015, 1016, 893 }, // Pokemon Tower 2F
    { 156, 546, 1015, 1016, 893 }, // Pokemon Tower 3F
    { 435, 547, 1017, 1018, 894 }, // Mr. Fuji's house (Lavender Volunteer Pokemon House)
};

#define MAP_HEADERS        ((const u8 *)0x020F6BE0) // sMapHeaders
#define MAP_HEADER_SIZE    24
#define NUM_MAP_HEADERS    540
#define MAP_NOTHING        1

enum {
    PART1_EVENTS = 1,
    PART1_SCRIPTS,
    PART1_SCRIPT_HEADER,
    PART1_MSG,
};

static u16 Part1Map_GetBank(u32 mapId, u32 field, u32 headerOffset)
{
    if (Chapter_Get() == CHAPTER_RED) {
        for (u32 i = 0; i < NELEMS(sPart1Maps); i++) {
            if (sPart1Maps[i].mapId == mapId) {
                return (&sPart1Maps[i].mapId)[field];
            }
        }
    }
    if (mapId >= NUM_MAP_HEADERS) {
        mapId = MAP_NOTHING;
    }
    return *(const u16 *)(MAP_HEADERS + mapId * MAP_HEADER_SIZE + headerOffset);
}

// replace MapHeader_GetMsgBank (0x0203B2C0), _GetScriptsBank (0x0203B2D4), _GetScriptHeaderBank (0x0203B2E8) and
// _GetEventsBank (0x0203B358).  only the script manager and the map event loader call them, both field-only.
u16 LONG_CALL Chapter_MapHeader_GetMsgBank(u32 mapId)
{
    return Part1Map_GetBank(mapId, PART1_MSG, 10);
}

u16 LONG_CALL Chapter_MapHeader_GetScriptsBank(u32 mapId)
{
    return Part1Map_GetBank(mapId, PART1_SCRIPTS, 6);
}

u16 LONG_CALL Chapter_MapHeader_GetScriptHeaderBank(u32 mapId)
{
    return Part1Map_GetBank(mapId, PART1_SCRIPT_HEADER, 8);
}

u16 LONG_CALL Chapter_MapHeader_GetEventsBank(u32 mapId)
{
    return Part1Map_GetBank(mapId, PART1_EVENTS, 16);
}

#endif // CHAPTER_SYSTEM

#define VAR_PLAYER_STARTER 0x4030

/**
 *  @brief replaces ScrCmd_GetStarterChoice (206, 0x02043938).  the rival scripts pick the rival's team by comparing
 *         the player's starter with Chikorita (152) and Cyndaquil (155), anything else meaning Totodile.  with
 *         randomized starters (and FireRed's in Part 1) that test fails, so the starter is reported as the Johto
 *         starter of the same type: 152 grass, 155 fire, 158 water.
 *
 *  @param ctx script context
 *  @return FALSE
 */
BOOL LONG_CALL Chapter_ScrCmd_GetStarterChoice(SCRIPTCONTEXT *ctx)
{
    static const u16 sJohtoStarters[3] = { 152, 155, 158 };
    u16 *ret = ScriptGetVarPointer(ctx);
    u16 species = VarGet(ctx->fsys, VAR_PLAYER_STARTER);

    for (int i = 0; i < 3; i++) {
        if (species == Randomizer_GetStarterSpecies(i)) {
            species = sJohtoStarters[i];
            break;
        }
    }
    *ret = species;
    return FALSE;
}
