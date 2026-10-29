.include "asm/include/interop_macros.inc"

.include "asm/include/scriptmacros.inc"
.include "asm/include/flags.inc"
.include "asm/include/soundeffects.inc"
.include "asm/include/vars.inc"

.include "asm/include/maps.inc"
.include "asm/include/std_scripts.inc"
.include "asm/include/trainers.inc"

#include "constants/item.h"
#include "config.h"

// hack: FireRed's people in Kanto interiors that kept HeartGold's: Pokemon Centers, marts, houses, gates,
// Celadon Dept. Store, Red's house.  HeartGold's nurses/clerks keep their functions (the clerks' HeartGold marts).
// events: data/eventdata/part1/647-679, text: data/text/922.txt

.data

scrdef scr_seq_P1_INTERIORS_001 // Pokemon Center nurse
scrdef scr_seq_P1_INTERIORS_002 // Red's house: Mom
scrdef scr_seq_P1_INTERIORS_003 // Red's house: TV
scrdef scr_seq_P1_INTERIORS_004 // ViridianCity_PokemonCenter_1F: Gentleman
scrdef scr_seq_P1_INTERIORS_005 // ViridianCity_PokemonCenter_1F: Boy
scrdef scr_seq_P1_INTERIORS_006 // ViridianCity_PokemonCenter_1F: Youngster
scrdef scr_seq_P1_INTERIORS_007 // ViridianCity_House: BaldingMan
scrdef scr_seq_P1_INTERIORS_008 // ViridianCity_House: LittleGirl
scrdef scr_seq_P1_INTERIORS_009 // ViridianCity_School: Woman
scrdef scr_seq_P1_INTERIORS_010 // ViridianCity_School: Lass
scrdef scr_seq_P1_INTERIORS_011 // PewterCity_PokemonCenter_1F: Gentleman
scrdef scr_seq_P1_INTERIORS_012 // PewterCity_PokemonCenter_1F: Youngster
scrdef scr_seq_P1_INTERIORS_013 // PewterCity_PokemonCenter_1F: GBAKid1
scrdef scr_seq_P1_INTERIORS_014 // PewterCity_PokemonCenter_1F: GBAKid2
scrdef scr_seq_P1_INTERIORS_015 // clerk (std_special_mart 25)
scrdef scr_seq_P1_INTERIORS_016 // clerk (std_pokemart 1)
scrdef scr_seq_P1_INTERIORS_017 // PewterCity_Mart: Youngster
scrdef scr_seq_P1_INTERIORS_018 // PewterCity_Mart: Boy
scrdef scr_seq_P1_INTERIORS_019 // PewterCity_House1: BaldingMan
scrdef scr_seq_P1_INTERIORS_020 // PewterCity_House1: LittleBoy
scrdef scr_seq_P1_INTERIORS_021 // PewterCity_House2: OldMan
scrdef scr_seq_P1_INTERIORS_022 // PewterCity_House2: LittleBoy
scrdef scr_seq_P1_INTERIORS_023 // CeruleanCity_PokemonCenter_1F: Gentleman
scrdef scr_seq_P1_INTERIORS_024 // CeruleanCity_PokemonCenter_1F: Rocker
scrdef scr_seq_P1_INTERIORS_025 // CeruleanCity_PokemonCenter_1F: Youngster
scrdef scr_seq_P1_INTERIORS_026 // CeruleanCity_PokemonCenter_1F: Lass
scrdef scr_seq_P1_INTERIORS_027 // clerk (std_special_mart 17)
scrdef scr_seq_P1_INTERIORS_028 // CeruleanCity_Mart: Woman
scrdef scr_seq_P1_INTERIORS_029 // CeruleanCity_Mart: Youngster
scrdef scr_seq_P1_INTERIORS_030 // CeruleanCity_House1: BadgeGuy
scrdef scr_seq_P1_INTERIORS_031 // CeruleanCity_House2: Hiker
scrdef scr_seq_P1_INTERIORS_032 // CeruleanCity_House2: Lass
scrdef scr_seq_P1_INTERIORS_033 // VermilionCity_PokemonCenter_1F: Man
scrdef scr_seq_P1_INTERIORS_034 // VermilionCity_PokemonCenter_1F: Hiker
scrdef scr_seq_P1_INTERIORS_035 // VermilionCity_PokemonCenter_1F: Youngster
scrdef scr_seq_P1_INTERIORS_036 // clerk (std_special_mart 14)
scrdef scr_seq_P1_INTERIORS_037 // VermilionCity_Mart: CooltrainerF
scrdef scr_seq_P1_INTERIORS_038 // VermilionCity_Mart: BaldingMan
scrdef scr_seq_P1_INTERIORS_039 // VermilionCity_House3: Boy
scrdef scr_seq_P1_INTERIORS_040 // VermilionCity_House3: Lass
scrdef scr_seq_P1_INTERIORS_041 // LavenderTown_PokemonCenter_1F: Gentleman
scrdef scr_seq_P1_INTERIORS_042 // LavenderTown_PokemonCenter_1F: Lass
scrdef scr_seq_P1_INTERIORS_043 // LavenderTown_PokemonCenter_1F: Youngster
scrdef scr_seq_P1_INTERIORS_044 // clerk (std_special_mart 16)
scrdef scr_seq_P1_INTERIORS_045 // LavenderTown_Mart: BaldingMan
scrdef scr_seq_P1_INTERIORS_046 // LavenderTown_Mart: Rocker
scrdef scr_seq_P1_INTERIORS_047 // LavenderTown_Mart: Youngster
scrdef scr_seq_P1_INTERIORS_048 // LavenderTown_House1: CooltrainerF
scrdef scr_seq_P1_INTERIORS_049 // CeladonCity_PokemonCenter_1F: Gentleman
scrdef scr_seq_P1_INTERIORS_050 // CeladonCity_PokemonCenter_1F: CooltrainerF
scrdef scr_seq_P1_INTERIORS_051 // CeladonCity_PokemonCenter_1F: Youngster
scrdef scr_seq_P1_INTERIORS_052 // CeladonCity_DepartmentStore_1F: Receptionist
scrdef scr_seq_P1_INTERIORS_053 // clerk (std_special_mart 18)
scrdef scr_seq_P1_INTERIORS_054 // clerk (std_special_mart 19)
scrdef scr_seq_P1_INTERIORS_055 // CeladonCity_DepartmentStore_2F: Lass
scrdef scr_seq_P1_INTERIORS_056 // clerk (std_special_mart 20)
scrdef scr_seq_P1_INTERIORS_057 // CeladonCity_DepartmentStore_3F: GBAKid1
scrdef scr_seq_P1_INTERIORS_058 // CeladonCity_DepartmentStore_3F: GBAKid3
scrdef scr_seq_P1_INTERIORS_059 // CeladonCity_DepartmentStore_3F: GBAKid2
scrdef scr_seq_P1_INTERIORS_060 // CeladonCity_DepartmentStore_3F: LittleGirl
scrdef scr_seq_P1_INTERIORS_061 // clerk (std_special_mart 21)
scrdef scr_seq_P1_INTERIORS_062 // CeladonCity_DepartmentStore_4F: Man
scrdef scr_seq_P1_INTERIORS_063 // CeladonCity_DepartmentStore_4F: Youngster
scrdef scr_seq_P1_INTERIORS_064 // clerk (std_special_mart 23)
scrdef scr_seq_P1_INTERIORS_065 // clerk (std_special_mart 22)
scrdef scr_seq_P1_INTERIORS_066 // CeladonCity_DepartmentStore_5F: Gentleman
scrdef scr_seq_P1_INTERIORS_067 // CeladonCity_DepartmentStore_5F: Sailor
scrdef scr_seq_P1_INTERIORS_068 // FuchsiaCity_PokemonCenter_1F: Man
scrdef scr_seq_P1_INTERIORS_069 // FuchsiaCity_PokemonCenter_1F: CooltrainerF
scrdef scr_seq_P1_INTERIORS_070 // FuchsiaCity_PokemonCenter_1F: Youngster
scrdef scr_seq_P1_INTERIORS_071 // clerk (std_special_mart 24)
scrdef scr_seq_P1_INTERIORS_072 // FuchsiaCity_Mart: Gentleman
scrdef scr_seq_P1_INTERIORS_073 // FuchsiaCity_Mart: CooltrainerF
scrdef scr_seq_P1_INTERIORS_074 // SaffronCity_PokemonCenter_1F: Gentleman
scrdef scr_seq_P1_INTERIORS_075 // SaffronCity_PokemonCenter_1F: Woman
scrdef scr_seq_P1_INTERIORS_076 // SaffronCity_PokemonCenter_1F: Youngster
scrdef scr_seq_P1_INTERIORS_077 // clerk (std_special_mart 15)
scrdef scr_seq_P1_INTERIORS_078 // SaffronCity_Mart: Youngster
scrdef scr_seq_P1_INTERIORS_079 // SaffronCity_Mart: Lass
scrdef scr_seq_P1_INTERIORS_080 // SaffronCity_CopycatsHouse_1F: CopycatsDad
scrdef scr_seq_P1_INTERIORS_081 // SaffronCity_CopycatsHouse_1F: CopycatsMom
scrdef scr_seq_P1_INTERIORS_082 // SaffronCity_CopycatsHouse_2F: Copycat
scrdef scr_seq_P1_INTERIORS_083 // Route2_ViridianForest_SouthEntrance: Woman1
scrdef scr_seq_P1_INTERIORS_084 // Route2_ViridianForest_SouthEntrance: Woman2
scrdef scr_seq_P1_INTERIORS_085 // Route2_ViridianForest_NorthEntrance: Youngster
scrdef scr_seq_P1_INTERIORS_086 // Route2_ViridianForest_NorthEntrance: OldMan
scrdef scr_seq_P1_INTERIORS_087 // Route2_ViridianForest_NorthEntrance: CooltrainerF
scrdef scr_seq_P1_INTERIORS_088 // Route16_NorthEntrance_1F: Guard
scrdef scr_seq_P1_INTERIORS_089 // Route16_NorthEntrance_1F: OldMan
scrdef_end

scr_seq_P1_INTERIORS_001:
	setvar VAR_SPECIAL_x8007, 0
	callstd std_nurse_joy
	end

scr_seq_P1_INTERIORS_002:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	compare VAR_P1_STORY, 4
	goto_if_ge _momHeal
	npc_msg 0
	wait_button
	closemsg
	releaseall
	end

_momHeal:
	npc_msg 1
	closemsg
	fade_screen 6, 1, 0, 0
	wait_fade
	heal_party
	play_fanfare SEQ_ME_ASA
	wait_fanfare
	fade_screen 6, 1, 1, 0
	wait_fade
	npc_msg 2
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_INTERIORS_003:
	play_se SEQ_SE_DP_SELECT
	lockall
	npc_msg 3
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_INTERIORS_004:
	simple_npc_msg 4
	end

scr_seq_P1_INTERIORS_005:
	simple_npc_msg 5
	end

scr_seq_P1_INTERIORS_006:
	simple_npc_msg 6
	end

scr_seq_P1_INTERIORS_007:
	simple_npc_msg 7
	end

scr_seq_P1_INTERIORS_008:
	simple_npc_msg 8
	end

scr_seq_P1_INTERIORS_009:
	simple_npc_msg 9
	end

scr_seq_P1_INTERIORS_010:
	simple_npc_msg 10
	end

scr_seq_P1_INTERIORS_011:
	simple_npc_msg 11
	end

scr_seq_P1_INTERIORS_012:
	simple_npc_msg 12
	end

scr_seq_P1_INTERIORS_013:
	simple_npc_msg 13
	end

scr_seq_P1_INTERIORS_014:
	simple_npc_msg 14
	end

scr_seq_P1_INTERIORS_015:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	callstd std_mart_intro
	holdmsg
	setvar VAR_SPECIAL_x8004, 25
	callstd std_special_mart
	releaseall
	end

scr_seq_P1_INTERIORS_016:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	callstd std_mart_intro
	holdmsg
	setvar VAR_SPECIAL_x8004, 1
	callstd std_pokemart
	releaseall
	end

scr_seq_P1_INTERIORS_017:
	simple_npc_msg 15
	end

scr_seq_P1_INTERIORS_018:
	simple_npc_msg 16
	end

scr_seq_P1_INTERIORS_019:
	simple_npc_msg 17
	end

scr_seq_P1_INTERIORS_020:
	simple_npc_msg 18
	end

scr_seq_P1_INTERIORS_021:
	simple_npc_msg 19
	end

scr_seq_P1_INTERIORS_022:
	simple_npc_msg 20
	end

scr_seq_P1_INTERIORS_023:
	simple_npc_msg 21
	end

scr_seq_P1_INTERIORS_024:
	simple_npc_msg 22
	end

scr_seq_P1_INTERIORS_025:
	simple_npc_msg 23
	end

scr_seq_P1_INTERIORS_026:
	simple_npc_msg 24
	end

scr_seq_P1_INTERIORS_027:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	callstd std_mart_intro
	holdmsg
	setvar VAR_SPECIAL_x8004, 17
	callstd std_special_mart
	releaseall
	end

scr_seq_P1_INTERIORS_028:
	simple_npc_msg 25
	end

scr_seq_P1_INTERIORS_029:
	simple_npc_msg 26
	end

scr_seq_P1_INTERIORS_030:
	simple_npc_msg 27
	end

scr_seq_P1_INTERIORS_031:
	simple_npc_msg 28
	end

scr_seq_P1_INTERIORS_032:
	simple_npc_msg 29
	end

scr_seq_P1_INTERIORS_033:
	simple_npc_msg 30
	end

scr_seq_P1_INTERIORS_034:
	simple_npc_msg 31
	end

scr_seq_P1_INTERIORS_035:
	simple_npc_msg 32
	end

scr_seq_P1_INTERIORS_036:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	callstd std_mart_intro
	holdmsg
	setvar VAR_SPECIAL_x8004, 14
	callstd std_special_mart
	releaseall
	end

scr_seq_P1_INTERIORS_037:
	simple_npc_msg 33
	end

scr_seq_P1_INTERIORS_038:
	simple_npc_msg 34
	end

scr_seq_P1_INTERIORS_039:
	simple_npc_msg 35
	end

scr_seq_P1_INTERIORS_040:
	simple_npc_msg 36
	end

scr_seq_P1_INTERIORS_041:
	simple_npc_msg 37
	end

scr_seq_P1_INTERIORS_042:
	simple_npc_msg 38
	end

scr_seq_P1_INTERIORS_043:
	simple_npc_msg 39
	end

scr_seq_P1_INTERIORS_044:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	callstd std_mart_intro
	holdmsg
	setvar VAR_SPECIAL_x8004, 16
	callstd std_special_mart
	releaseall
	end

scr_seq_P1_INTERIORS_045:
	simple_npc_msg 40
	end

scr_seq_P1_INTERIORS_046:
	simple_npc_msg 41
	end

scr_seq_P1_INTERIORS_047:
	simple_npc_msg 42
	end

scr_seq_P1_INTERIORS_048:
	simple_npc_msg 43
	end

scr_seq_P1_INTERIORS_049:
	simple_npc_msg 44
	end

scr_seq_P1_INTERIORS_050:
	simple_npc_msg 45
	end

scr_seq_P1_INTERIORS_051:
	simple_npc_msg 46
	end

scr_seq_P1_INTERIORS_052:
	simple_npc_msg 47
	end

scr_seq_P1_INTERIORS_053:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	callstd std_mart_intro
	holdmsg
	setvar VAR_SPECIAL_x8004, 18
	callstd std_special_mart
	releaseall
	end

scr_seq_P1_INTERIORS_054:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	callstd std_mart_intro
	holdmsg
	setvar VAR_SPECIAL_x8004, 19
	callstd std_special_mart
	releaseall
	end

scr_seq_P1_INTERIORS_055:
	simple_npc_msg 48
	end

scr_seq_P1_INTERIORS_056:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	callstd std_mart_intro
	holdmsg
	setvar VAR_SPECIAL_x8004, 20
	callstd std_special_mart
	releaseall
	end

scr_seq_P1_INTERIORS_057:
	simple_npc_msg 49
	end

scr_seq_P1_INTERIORS_058:
	simple_npc_msg 50
	end

scr_seq_P1_INTERIORS_059:
	simple_npc_msg 51
	end

scr_seq_P1_INTERIORS_060:
	simple_npc_msg 52
	end

scr_seq_P1_INTERIORS_061:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	callstd std_mart_intro
	holdmsg
	setvar VAR_SPECIAL_x8004, 21
	callstd std_special_mart
	releaseall
	end

scr_seq_P1_INTERIORS_062:
	simple_npc_msg 53
	end

scr_seq_P1_INTERIORS_063:
	simple_npc_msg 54
	end

scr_seq_P1_INTERIORS_064:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	callstd std_mart_intro
	holdmsg
	setvar VAR_SPECIAL_x8004, 23
	callstd std_special_mart
	releaseall
	end

scr_seq_P1_INTERIORS_065:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	callstd std_mart_intro
	holdmsg
	setvar VAR_SPECIAL_x8004, 22
	callstd std_special_mart
	releaseall
	end

scr_seq_P1_INTERIORS_066:
	simple_npc_msg 55
	end

scr_seq_P1_INTERIORS_067:
	simple_npc_msg 56
	end

scr_seq_P1_INTERIORS_068:
	simple_npc_msg 57
	end

scr_seq_P1_INTERIORS_069:
	simple_npc_msg 58
	end

scr_seq_P1_INTERIORS_070:
	simple_npc_msg 59
	end

scr_seq_P1_INTERIORS_071:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	callstd std_mart_intro
	holdmsg
	setvar VAR_SPECIAL_x8004, 24
	callstd std_special_mart
	releaseall
	end

scr_seq_P1_INTERIORS_072:
	simple_npc_msg 60
	end

scr_seq_P1_INTERIORS_073:
	simple_npc_msg 61
	end

scr_seq_P1_INTERIORS_074:
	simple_npc_msg 62
	end

scr_seq_P1_INTERIORS_075:
	simple_npc_msg 63
	end

scr_seq_P1_INTERIORS_076:
	simple_npc_msg 64
	end

scr_seq_P1_INTERIORS_077:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	callstd std_mart_intro
	holdmsg
	setvar VAR_SPECIAL_x8004, 15
	callstd std_special_mart
	releaseall
	end

scr_seq_P1_INTERIORS_078:
	simple_npc_msg 65
	end

scr_seq_P1_INTERIORS_079:
	simple_npc_msg 66
	end

scr_seq_P1_INTERIORS_080:
	simple_npc_msg 67
	end

scr_seq_P1_INTERIORS_081:
	simple_npc_msg 68
	end

scr_seq_P1_INTERIORS_082:
	simple_npc_msg 69
	end

scr_seq_P1_INTERIORS_083:
	simple_npc_msg 70
	end

scr_seq_P1_INTERIORS_084:
	simple_npc_msg 71
	end

scr_seq_P1_INTERIORS_085:
	simple_npc_msg 72
	end

scr_seq_P1_INTERIORS_086:
	simple_npc_msg 73
	end

scr_seq_P1_INTERIORS_087:
	simple_npc_msg 74
	end

scr_seq_P1_INTERIORS_088:
	simple_npc_msg 75
	end

scr_seq_P1_INTERIORS_089:
	simple_npc_msg 76
	end
