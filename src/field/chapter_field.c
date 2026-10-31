#include "config.h"
#include "debug.h"
#include "types.h"

#include "chapter.h"
#include "randomizer.h"
#include "constants/species.h"
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
    { 20,  548, 1019, 970, 895 }, // Route 12
    { 533, 549, 1020, 970, 896 }, // Route 12 Fishing House
    { 21,  550, 1021, 970, 897 }, // Route 13
    { 22,  551, 1021, 970, 897 }, // Route 14
    { 23,  552, 1021, 970, 897 }, // Route 15
    { 392, 553, 1021, 970, 897 }, // Route 15 Fuchsia gatehouse
    { 56,  554, 1022, 970, 898 }, // Fuchsia City
    { 480, 555, 1023, 970, 899 }, // Fuchsia Gym
    { 481, 556, 1024, 970, 900 }, // Fuchsia southwest house (Fishing Guru's older brother)
    { 483, 557, 1024, 970, 900 }, // Safari Zone Warden's house
    { 532, 558, 1025, 970, 901 }, // Underground Path tunnel (Routes 5-6, and standing in for Routes 7-8)
    { 238, 559, 1014, 970, 892 }, // Rocket Hideout B3F (Ice Path B2F's ice puzzle)
    { 441, 560, 1014, 1026, 892 }, // Rocket Hideout elevator (Goldenrod Dept. Store elevator)
    { 382, 561, 1027, 970, 903 }, // Celadon Game Corner Prize Room
    { 383, 562, 1028, 970, 902 }, // Celadon Restaurant
    { 357, 563, 1029, 970, 904 }, // Safari Zone (HeartGold's Safari Game)
    { 173, 564, 119, 380, 135 }, // Safari Zone entrance (HeartGold's scripts; only its door leads to Fuchsia)
    { 59,  565, 1030, 1031, 905 }, // Saffron City
    { 402, 566, 1032, 970, 906 }, // Silph Co. 1F (HeartGold's Silph lobby)
    { 186, 567, 1032, 970, 906 }, // Silph Co. 2F (Goldenrod Radio Tower 2F)
    { 187, 568, 1032, 970, 906 }, // Silph Co. 3F (Radio Tower 3F)
    { 188, 569, 1032, 970, 906 }, // Silph Co. 4F (Radio Tower 4F)
    { 189, 570, 1032, 970, 906 }, // Silph Co. 5F (Radio Tower 5F)
    { 398, 571, 1033, 970, 907 }, // Fighting Dojo
    { 399, 572, 1033, 970, 907 }, // Mr. Psychic's house
    { 410, 573, 1034, 970, 908 }, // Saffron Gym
    { 24,  574, 1035, 970, 909 }, // Route 16 (Cycling Road's north end)
    { 422, 575, 1035, 970, 909 }, // Route 16 east of the gate (Snorlax)
    { 25,  576, 1035, 970, 909 }, // Route 17 (Cycling Road)
    { 26,  577, 1035, 970, 909 }, // Route 18
    { 415, 578, 1035, 970, 909 }, // Route 16 house (HM02 Fly)
    { 362, 579, 1036, 970, 910 }, // Vermilion Pokemon Fan Club (Bike Voucher)
    { 432, 580, 1036, 970, 910 }, // Cerulean bike shop (HeartGold's Bike Maniac's house)
    { 91,  581, 1037, 970, 911 }, // Route 19
    { 92,  582, 1037, 970, 911 }, // Route 20
    { 93,  583, 1037, 970, 911 }, // Route 21
    { 424, 584, 1037, 970, 911 }, // Route 19 gate (Fuchsia side)
    { 146, 585, 139, 399, 3 },    // Seafoam Islands 1F (HeartGold's scripts; its Gym door is parked)
    { 453, 586, 13, 274, 3 },     // Seafoam Islands B1F (HeartGold's scripts, without its NPC)
    { 454, 587, 139, 399, 3 },    // Seafoam Islands B2F (HeartGold's scripts, without its trainers)
    { 456, 588, 1037, 970, 911 }, // Seafoam Islands B4F (Articuno)
    { 467, 589, 1037, 970, 911 }, // Power Plant (HeartGold's repaired plant: Zapdos, Electrodes)
    { 57,  590, 1038, 1056, 912 }, // Cinnabar Island (the ruins; the buildings are doors in its walls; Bill's Sevii trip)
    { 508, 591, 1038, 589, 912 }, // Cinnabar Pokemon Center (HeartGold's header: Union Room returns)
    { 61,  592, 1038, 970, 912 }, // Cinnabar Pokemon Lab (Elm's Lab: the fossil doctor)
    { 157, 593, 1038, 970, 912 }, // Cinnabar Poke Mart (the Violet Mart)
    { 457, 594, 1040, 1041, 914 }, // Cinnabar Gym (HeartGold's Seafoam Islands Gym)
    { 7,   595, 1039, 970, 913 }, // Pokemon Mansion 1F/2F (Burned Tower 1F)
    { 217, 596, 1039, 970, 913 }, // Pokemon Mansion 3F/B1F (Burned Tower B1F)
    { 496, 597, 1042, 970, 915 }, // Viridian Gym (Giovanni)
    { 299, 598, 1043, 970, 916 }, // Pokemon League reception gate (Route 23's badge checks)
    { 58,  599, 1044, 970, 917 }, // Indigo Plateau
    { 300, 600, 1044, 1045, 917 }, // Pokemon League lobby (resets the Elite Four)
    { 301, 601, 1046, 1047, 918 }, // Lorelei (Will's room)
    { 302, 602, 1046, 1048, 918 }, // Bruno (Koga's room)
    { 303, 603, 1046, 1049, 918 }, // Agatha (Bruno's room)
    { 304, 604, 1046, 1050, 918 }, // Lance (Karen's room)
    { 305, 605, 1046, 1051, 918 }, // Champion Blue (Lance's room)
    { 306, 606, 1046, 1052, 918 }, // Hall of Fame
    { 124, 607, 139, 399, 3 },    // Victory Road 1F (HeartGold's scripts)
    { 178, 608, 109, 370, 3 },    // Victory Road 2F (HeartGold's scripts: landing from 3F's holes)
    { 179, 609, 110, 371, 128 },  // Victory Road 3F (HeartGold's scripts: its holes; Silver's battle removed)
    { 417, 610, 1053, 970, 919 }, // Route 2 house (Mr. Mime trade)
    { 418, 611, 1053, 970, 919 }, // Route 2 gatehouse (Oak's Aide: TM70 Flash)
    { 431, 612, 1053, 970, 919 }, // Cerulean west house (Jynx trade)
    { 469, 613, 1053, 970, 919 }, // Underground Path, Route 5 gate (Nidoran trade)
    { 364, 614, 1053, 970, 919 }, // Vermilion south house (Farfetch'd trade)
    { 425, 615, 1053, 970, 919 }, // Route 11-12 gate (Nidorina trade, Oak's Aide: Dowsing Machine)
    { 423, 616, 1053, 1054, 919 }, // Route 18 gate (Lickitung trade; HeartGold's Cycling Road check)
    // the Sevii Islands 1-3 on Johto stand-ins (scripts/hack/gen_sevii.py)
    { 75,  617, 1055, 970, 920 }, // One Island (Cianwood City)
    { 236, 618, 1055, 1057, 920 }, // One Island Pokemon Net Center (Cianwood Pokemon Center)
    { 232, 619, 1055, 970, 920 }, // One Island house (Cianwood west house)
    { 235, 620, 1055, 970, 920 }, // One Island house (Cianwood central house)
    { 233, 621, 1055, 970, 920 }, // Ember Spa (Cianwood photo studio)
    { 279, 622, 1055, 970, 920 }, // Cliff Edge Gate (One Island <-> Kindle Road)
    { 151, 623, 1055, 970, 920 }, // Kindle Road (Route 47)
    { 122, 624, 1055, 970, 920 }, // Mt. Ember (Mt. Silver 1F)
    { 463, 625, 1055, 970, 920 }, // Mt. Ember summit path (Mt. Silver 2F)
    { 465, 626, 1055, 970, 920 }, // Mt. Ember summit (Mt. Silver summit): Moltres
    { 67,  627, 1055, 970, 920 }, // Two Island (Cherrygrove City)
    { 69,  628, 1055, 589, 920 }, // Two Island Pokemon Center (Cherrygrove Pokemon Center)
    { 68,  629, 1055, 1058, 920 }, // Joyful Game Corner (Cherrygrove Poke Mart)
    { 70,  630, 1055, 970, 920 }, // Two Island house: the Move Maniac (Cherrygrove southwest house)
    { 34,  631, 1055, 970, 920 }, // Cape Brink (Route 30)
    { 143, 632, 1055, 970, 920 }, // Cape Brink cottage (Mr. Pokemon's house)
    { 74,  633, 1055, 970, 920 }, // Three Island (Azalea Town)
    { 166, 634, 1055, 589, 920 }, // Three Island Pokemon Center (Azalea Pokemon Center)
    { 165, 635, 1055, 970, 920 }, // Three Island Mart (Azalea Poke Mart)
    { 164, 636, 1055, 970, 920 }, // Three Island house (Kurt's house)
    { 163, 637, 1055, 970, 920 }, // Three Island house (Charcoal Kiln)
    { 37,  638, 1055, 970, 920 }, // Bond Bridge (Route 33)
    { 100, 639, 1055, 970, 920 }, // Berry Forest gate (Azalea - Ilex Forest gatehouse)
    { 117, 640, 1055, 970, 920 }, // Berry Forest (Ilex Forest)
    // FireRed's remaining gifts in Kanto interiors (scripts/hack/gen_gifts.py)
    { 361, 641, 1059, 970, 921 }, // Vermilion fishing house (the Fishing Guru: Old Rod)
    { 471, 642, 1059, 970, 921 }, // Pewter Museum of Science (Old Amber)
    { 380, 643, 1059, 970, 921 }, // Celadon Condominiums roof room (Eevee)
    { 375, 644, 1059, 970, 921 }, // Celadon Dept. Store roof (the thirsty girl's TMs, vending machines)
    { 466, 645, 1059, 589, 921 }, // Route 10 Pokemon Center (Oak's Aide: Everstone)
    { 511, 646, 1059, 589, 921 }, // Route 3 Pokemon Center (the Magikarp salesman)
    { 506, 680, 1061, 1062, 923 }, // Red's bedroom (the NES, Red's PC: the Potion; test builds: Rare Candies)
    // FireRed's people in the Kanto interiors that kept HeartGold's (Build 31, scratch build32_interiors.py)
    { 501, 648, 1060, 589, 922 }, // ViridianCity_PokemonCenter_1F (HeartGold map 501)
    { 497, 649, 1060, 970, 922 }, // ViridianCity_House (HeartGold map 497)
    { 498, 650, 1060, 970, 922 }, // ViridianCity_School (HeartGold map 498)
    { 475, 651, 1060, 589, 922 }, // PewterCity_PokemonCenter_1F (HeartGold map 475)
    { 474, 652, 1060, 970, 922 }, // PewterCity_Mart (HeartGold map 474)
    { 472, 653, 1060, 970, 922 }, // PewterCity_House1 (HeartGold map 472)
    { 477, 654, 1060, 970, 922 }, // PewterCity_House2 (HeartGold map 477)
    { 428, 655, 1060, 589, 922 }, // CeruleanCity_PokemonCenter_1F (HeartGold map 428)
    { 426, 656, 1060, 970, 922 }, // CeruleanCity_Mart (HeartGold map 426)
    { 429, 657, 1060, 970, 922 }, // CeruleanCity_House1 (HeartGold map 429)
    { 430, 658, 1060, 970, 922 }, // CeruleanCity_House2 (HeartGold map 430)
    { 358, 659, 1060, 589, 922 }, // VermilionCity_PokemonCenter_1F (HeartGold map 358)
    { 360, 660, 1060, 970, 922 }, // VermilionCity_Mart (HeartGold map 360)
    { 363, 661, 1060, 970, 922 }, // VermilionCity_House3 (HeartGold map 363)
    { 434, 662, 1060, 589, 922 }, // LavenderTown_PokemonCenter_1F (HeartGold map 434)
    { 433, 663, 1060, 970, 922 }, // LavenderTown_Mart (HeartGold map 433)
    { 436, 664, 1060, 970, 922 }, // LavenderTown_House1 (HeartGold map 436)
    { 393, 665, 1060, 589, 922 }, // CeladonCity_PokemonCenter_1F (HeartGold map 393)
    { 370, 666, 1060, 970, 922 }, // CeladonCity_DepartmentStore_1F (HeartGold map 370)
    { 371, 667, 1060, 970, 922 }, // CeladonCity_DepartmentStore_2F (HeartGold map 371)
    { 372, 668, 1060, 970, 922 }, // CeladonCity_DepartmentStore_3F (HeartGold map 372)
    { 373, 669, 1060, 970, 922 }, // CeladonCity_DepartmentStore_4F (HeartGold map 373)
    { 374, 670, 1060, 970, 922 }, // CeladonCity_DepartmentStore_5F (HeartGold map 374)
    { 482, 671, 1060, 589, 922 }, // FuchsiaCity_PokemonCenter_1F (HeartGold map 482)
    { 478, 672, 1060, 970, 922 }, // FuchsiaCity_Mart (HeartGold map 478)
    { 407, 673, 1060, 589, 922 }, // SaffronCity_PokemonCenter_1F (HeartGold map 407)
    { 409, 674, 1060, 970, 922 }, // SaffronCity_Mart (HeartGold map 409)
    { 404, 675, 1060, 970, 922 }, // SaffronCity_CopycatsHouse_1F (HeartGold map 404)
    { 405, 676, 1060, 970, 922 }, // SaffronCity_CopycatsHouse_2F (HeartGold map 405)
    { 419, 677, 1060, 970, 922 }, // Route2_ViridianForest_SouthEntrance (HeartGold map 419)
    { 420, 678, 1060, 970, 922 }, // Route2_ViridianForest_NorthEntrance (HeartGold map 420)
    { 421, 679, 1060, 1063, 922 }, // Route16_NorthEntrance_1F (HeartGold map 421; HeartGold's Cycling Road bike check)
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

/**
 *  the main-code stubs (Chapter_MapHdr* in asm/general_hooks.s) jump through this table after making sure this overlay
 *  (131, the field extension) is loaded: the map header banks are read when a game starts or continues, before the
 *  field overlay - and with it this one - is loaded.  section .init puts it first in the overlay, at 0x023C8000.
 */
__attribute__((section(".init"), used)) const void *const gChapterFieldEntries[4] = {
    Chapter_MapHeader_GetMsgBank, Chapter_MapHeader_GetScriptsBank, Chapter_MapHeader_GetScriptHeaderBank,
    Chapter_MapHeader_GetEventsBank,
};

#define FontID_String_GetWidth ((u32 (*)(u32, void *, u32))(0x02002F30 | 1))

/**
 *  @brief replaces MsgData_ReadMsgIntoStringAndGetWidth (0x02068F84), which reads a place name from the place-name
 *         archive for the map-name pop-up and the Pokegear map.  in Part 1, on a Sevii stand-in map, its Johto name
 *         is swapped for the Sevii one.  (met locations still record the stand-in's map section)
 */
u32 LONG_CALL Chapter_ReadPlaceNameAndGetWidth(void *msgData, u32 mapsec, void *dest)
{
    mapsec = Chapter_SeviiMapSec(mapsec);
    ReadMsgDataIntoString(msgData, mapsec, dest);
    return FontID_String_GetWidth(0, dest, 0);
}

#define TILE_BEHAVIOR_FLAGS ((const u8 *)0x020FCA74) // sMetatileBehaviorFlags
#define MAP_POWER_PLANT     467

/**
 *  @brief replaces MetatileBehavior_CanGenerateWalkingEncounters (0x0205B994, field encounter checks only).  in Part 1
 *         the Power Plant's plain floor (behavior 0) counts as an encounter tile like a cave floor, so FireRed's Power
 *         Plant table (encounter bank 11, see bytereplacement) is used; HeartGold's plant has no encounter tiles.
 */
BOOL LONG_CALL Chapter_CanGenerateWalkingEncounters(u8 tile)
{
    if (TILE_BEHAVIOR_FLAGS[tile] & 2) {
        return TRUE;
    }
    return tile == 0 && Chapter_Get() == CHAPTER_RED && gFieldSysPtr != NULL && gFieldSysPtr->location != NULL
        && (u32)gFieldSysPtr->location->mapId == MAP_POWER_PLANT;
}

#endif // CHAPTER_SYSTEM

#define VAR_PLAYER_STARTER 0x4030

/**
 *  @brief replaces ScrCmd_GetStarterChoice (206, 0x02043938) (and doubles as the prize Pokemon lookup, see below).  the rival scripts pick the rival's team by comparing
 *         the player's starter with Chikorita (152) and Cyndaquil (155), anything else meaning Totodile.  with
 *         randomized starters (and FireRed's in Part 1) that test fails, so the starter is reported as the Johto
 *         starter of the same type: 152 grass, 155 fire, 158 water.
 *
 *  @param ctx script context
 *  @return FALSE
 */
#define VAR_P1_PRIZE 0x4163

extern const u16 *const sPrizeTiers[5];
extern const u16 sPrizeTierCounts[5];

BOOL LONG_CALL Chapter_ScrCmd_GetStarterChoice(SCRIPTCONTEXT *ctx)
{
    static const u16 sJohtoStarters[3] = { 152, 155, 158 };
    u16 *ret = ScriptGetVarPointer(ctx);

    // hack: "get_starter_choice VAR_P1_PRIZE" with a prize slot (0-4) in VAR_P1_PRIZE returns that Rocket Game Corner
    // prize Pokemon instead: a single-stage Pokemon from the slot's base stat band (src/field/prize_pool.c), fixed per save
    if (ret == GetVarPointer(ctx->fsys, VAR_P1_PRIZE)) {
        u32 slot = *ret;
        static const u16 sFireRedPrizes[5] = { SPECIES_ABRA, SPECIES_CLEFAIRY, SPECIES_DRATINI, SPECIES_SCYTHER, SPECIES_PORYGON };
        if (slot < 5) {
            *ret = Randomizer_IsOff() ? sFireRedPrizes[slot]
                                      : sPrizeTiers[slot][Randomizer_Hash(Randomizer_GetSeed(), 0x50 + slot) % sPrizeTierCounts[slot]];
        }
        return FALSE;
    }
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
