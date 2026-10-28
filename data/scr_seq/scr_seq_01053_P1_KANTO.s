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

// hack: Kanto houses and gates Part 1 fills with FireRed's people (HeartGold's own scripts run there in Part 2):
// FireRed's in-game trades (HeartGold's trade screen; trades 26+ in data/NpcTrades.c), Professor Oak's Aides with
// TM70 Flash (10 species; FireRed's HM05) and the Dowsing Machine (30 species; FireRed's Itemfinder), and the Route 18
// gate's Cycling Road check.  events: 610-616, header scr_seq_01054 (Route 18 gate), text: data/text/919.txt

.data

scrdef scr_seq_P1_KANTO_001 // Route 2 house: Mr. Mime trade
scrdef scr_seq_P1_KANTO_002 // Cerulean west house: Jynx trade
scrdef scr_seq_P1_KANTO_003 // Underground Path (Route 5 gate): Nidoran trade
scrdef scr_seq_P1_KANTO_004 // Vermilion south house: Farfetch'd trade
scrdef scr_seq_P1_KANTO_005 // Route 11 gate: Nidorina trade
scrdef scr_seq_P1_KANTO_006 // Route 18 gate: Lickitung trade
scrdef scr_seq_P1_KANTO_007 // Route 2 gate: Aide, TM70 Flash
scrdef scr_seq_P1_KANTO_008 // Route 11 gate: Aide, Dowsing Machine
scrdef scr_seq_P1_KANTO_009 // Route 2 house
scrdef scr_seq_P1_KANTO_010 // Route 2 gate guard
scrdef scr_seq_P1_KANTO_011 // Cerulean: the trader's wife
scrdef scr_seq_P1_KANTO_012 // Route 11 gate guard
scrdef scr_seq_P1_KANTO_013 // Route 11 gate: binoculars
scrdef scr_seq_P1_KANTO_014 // Route 18 gate guard
scrdef scr_seq_P1_KANTO_015 // Route 18 gate: Cycling Road check (coord, westbound)
scrdef scr_seq_P1_KANTO_016 // Route 18 gate: off Cycling Road (coord, eastbound)
scrdef scr_seq_P1_KANTO_017 // Route 18 gate: binoculars
scrdef scr_seq_P1_KANTO_018 // Route 11 gate: binoculars
scrdef scr_seq_P1_KANTO_019 // Route 18 gate: on resume
scrdef_end

scr_seq_P1_KANTO_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	load_npc_trade 26
	get_offered_species VAR_SPECIAL_x8006
	npc_trade_get_req_species VAR_SPECIAL_x8007
	npc_trade_end
	buffer_species_name 0, VAR_SPECIAL_x8007, 0, 0
	buffer_species_name 1, VAR_SPECIAL_x8006, 0, 0
	goto_if_set FLAG_P1_TRADE_MR_MIME, _tradeAfter1
	npc_msg 0
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _tradeDecline1
	closemsg
	fade_screen 6, 1, 0, 0
	wait_fade
	scrcmd_566
	get_party_selection VAR_SPECIAL_RESULT
	restore_overworld
	fade_screen 6, 1, 1, 0
	wait_fade
	compare VAR_SPECIAL_RESULT, 255
	goto_if_eq _tradeDecline1
	copyvar VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
	get_partymon_species VAR_SPECIAL_x8004, VAR_SPECIAL_x8005
	compare_var_to_var VAR_SPECIAL_x8005, VAR_SPECIAL_x8007
	goto_if_ne _tradeWrong1
	load_npc_trade 26
	npc_trade_exec VAR_SPECIAL_x8004
	npc_trade_end
	setflag FLAG_P1_TRADE_MR_MIME
	npc_msg 1
	goto _tradeDone1

_tradeWrong1:
	npc_msg 3
	goto _tradeDone1

_tradeDecline1:
	npc_msg 2
	goto _tradeDone1

_tradeAfter1:
	npc_msg 4
_tradeDone1:
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_KANTO_002:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	load_npc_trade 27
	get_offered_species VAR_SPECIAL_x8006
	npc_trade_get_req_species VAR_SPECIAL_x8007
	npc_trade_end
	buffer_species_name 0, VAR_SPECIAL_x8007, 0, 0
	buffer_species_name 1, VAR_SPECIAL_x8006, 0, 0
	goto_if_set FLAG_P1_TRADE_JYNX, _tradeAfter2
	npc_msg 5
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _tradeDecline2
	closemsg
	fade_screen 6, 1, 0, 0
	wait_fade
	scrcmd_566
	get_party_selection VAR_SPECIAL_RESULT
	restore_overworld
	fade_screen 6, 1, 1, 0
	wait_fade
	compare VAR_SPECIAL_RESULT, 255
	goto_if_eq _tradeDecline2
	copyvar VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
	get_partymon_species VAR_SPECIAL_x8004, VAR_SPECIAL_x8005
	compare_var_to_var VAR_SPECIAL_x8005, VAR_SPECIAL_x8007
	goto_if_ne _tradeWrong2
	load_npc_trade 27
	npc_trade_exec VAR_SPECIAL_x8004
	npc_trade_end
	setflag FLAG_P1_TRADE_JYNX
	npc_msg 6
	goto _tradeDone2

_tradeWrong2:
	npc_msg 8
	goto _tradeDone2

_tradeDecline2:
	npc_msg 7
	goto _tradeDone2

_tradeAfter2:
	npc_msg 9
_tradeDone2:
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_KANTO_003:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	load_npc_trade 28
	get_offered_species VAR_SPECIAL_x8006
	npc_trade_get_req_species VAR_SPECIAL_x8007
	npc_trade_end
	buffer_species_name 0, VAR_SPECIAL_x8007, 0, 0
	buffer_species_name 1, VAR_SPECIAL_x8006, 0, 0
	goto_if_set FLAG_P1_TRADE_NIDORAN, _tradeAfter3
	npc_msg 10
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _tradeDecline3
	closemsg
	fade_screen 6, 1, 0, 0
	wait_fade
	scrcmd_566
	get_party_selection VAR_SPECIAL_RESULT
	restore_overworld
	fade_screen 6, 1, 1, 0
	wait_fade
	compare VAR_SPECIAL_RESULT, 255
	goto_if_eq _tradeDecline3
	copyvar VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
	get_partymon_species VAR_SPECIAL_x8004, VAR_SPECIAL_x8005
	compare_var_to_var VAR_SPECIAL_x8005, VAR_SPECIAL_x8007
	goto_if_ne _tradeWrong3
	load_npc_trade 28
	npc_trade_exec VAR_SPECIAL_x8004
	npc_trade_end
	setflag FLAG_P1_TRADE_NIDORAN
	npc_msg 11
	goto _tradeDone3

_tradeWrong3:
	npc_msg 13
	goto _tradeDone3

_tradeDecline3:
	npc_msg 12
	goto _tradeDone3

_tradeAfter3:
	npc_msg 14
_tradeDone3:
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_KANTO_004:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	load_npc_trade 29
	get_offered_species VAR_SPECIAL_x8006
	npc_trade_get_req_species VAR_SPECIAL_x8007
	npc_trade_end
	buffer_species_name 0, VAR_SPECIAL_x8007, 0, 0
	buffer_species_name 1, VAR_SPECIAL_x8006, 0, 0
	goto_if_set FLAG_P1_TRADE_FARFETCHD, _tradeAfter4
	npc_msg 10
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _tradeDecline4
	closemsg
	fade_screen 6, 1, 0, 0
	wait_fade
	scrcmd_566
	get_party_selection VAR_SPECIAL_RESULT
	restore_overworld
	fade_screen 6, 1, 1, 0
	wait_fade
	compare VAR_SPECIAL_RESULT, 255
	goto_if_eq _tradeDecline4
	copyvar VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
	get_partymon_species VAR_SPECIAL_x8004, VAR_SPECIAL_x8005
	compare_var_to_var VAR_SPECIAL_x8005, VAR_SPECIAL_x8007
	goto_if_ne _tradeWrong4
	load_npc_trade 29
	npc_trade_exec VAR_SPECIAL_x8004
	npc_trade_end
	setflag FLAG_P1_TRADE_FARFETCHD
	npc_msg 11
	goto _tradeDone4

_tradeWrong4:
	npc_msg 13
	goto _tradeDone4

_tradeDecline4:
	npc_msg 12
	goto _tradeDone4

_tradeAfter4:
	npc_msg 14
_tradeDone4:
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_KANTO_005:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	load_npc_trade 30
	get_offered_species VAR_SPECIAL_x8006
	npc_trade_get_req_species VAR_SPECIAL_x8007
	npc_trade_end
	buffer_species_name 0, VAR_SPECIAL_x8007, 0, 0
	buffer_species_name 1, VAR_SPECIAL_x8006, 0, 0
	goto_if_set FLAG_P1_TRADE_NIDORINA, _tradeAfter5
	npc_msg 0
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _tradeDecline5
	closemsg
	fade_screen 6, 1, 0, 0
	wait_fade
	scrcmd_566
	get_party_selection VAR_SPECIAL_RESULT
	restore_overworld
	fade_screen 6, 1, 1, 0
	wait_fade
	compare VAR_SPECIAL_RESULT, 255
	goto_if_eq _tradeDecline5
	copyvar VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
	get_partymon_species VAR_SPECIAL_x8004, VAR_SPECIAL_x8005
	compare_var_to_var VAR_SPECIAL_x8005, VAR_SPECIAL_x8007
	goto_if_ne _tradeWrong5
	load_npc_trade 30
	npc_trade_exec VAR_SPECIAL_x8004
	npc_trade_end
	setflag FLAG_P1_TRADE_NIDORINA
	npc_msg 1
	goto _tradeDone5

_tradeWrong5:
	npc_msg 3
	goto _tradeDone5

_tradeDecline5:
	npc_msg 2
	goto _tradeDone5

_tradeAfter5:
	npc_msg 4
_tradeDone5:
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_KANTO_006:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	load_npc_trade 31
	get_offered_species VAR_SPECIAL_x8006
	npc_trade_get_req_species VAR_SPECIAL_x8007
	npc_trade_end
	buffer_species_name 0, VAR_SPECIAL_x8007, 0, 0
	buffer_species_name 1, VAR_SPECIAL_x8006, 0, 0
	goto_if_set FLAG_P1_TRADE_LICKITUNG, _tradeAfter6
	npc_msg 0
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _tradeDecline6
	closemsg
	fade_screen 6, 1, 0, 0
	wait_fade
	scrcmd_566
	get_party_selection VAR_SPECIAL_RESULT
	restore_overworld
	fade_screen 6, 1, 1, 0
	wait_fade
	compare VAR_SPECIAL_RESULT, 255
	goto_if_eq _tradeDecline6
	copyvar VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
	get_partymon_species VAR_SPECIAL_x8004, VAR_SPECIAL_x8005
	compare_var_to_var VAR_SPECIAL_x8005, VAR_SPECIAL_x8007
	goto_if_ne _tradeWrong6
	load_npc_trade 31
	npc_trade_exec VAR_SPECIAL_x8004
	npc_trade_end
	setflag FLAG_P1_TRADE_LICKITUNG
	npc_msg 1
	goto _tradeDone6

_tradeWrong6:
	npc_msg 3
	goto _tradeDone6

_tradeDecline6:
	npc_msg 2
	goto _tradeDone6

_tradeAfter6:
	npc_msg 4
_tradeDone6:
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_KANTO_007:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_set FLAG_P1_GOT_TM70, _aideExplainFlash
	buffer_players_name 0
	npc_msg 15
	count_national_dex_owned VAR_SPECIAL_x8004
	buffer_int 1, VAR_SPECIAL_x8004
	compare VAR_SPECIAL_x8004, 10
	goto_if_lt _aideShortFlash
	npc_msg 16
	goto_if_no_item_space ITEM_TM070, 1, _aideBagFullFlash
	giveitem_no_check ITEM_TM070, 1
	setflag FLAG_P1_GOT_TM70
_aideExplainFlash:
	npc_msg 17
	goto _aideDoneFlash

_aideShortFlash:
	npc_msg 18
_aideDoneFlash:
	wait_button
	closemsg
	releaseall
	end

_aideBagFullFlash:
	callstd std_bag_is_full
	closemsg
	releaseall
	end

scr_seq_P1_KANTO_008:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_set FLAG_P1_GOT_ITEMFINDER, _aideExplainDowse
	buffer_players_name 0
	npc_msg 19
	count_national_dex_owned VAR_SPECIAL_x8004
	buffer_int 1, VAR_SPECIAL_x8004
	compare VAR_SPECIAL_x8004, 30
	goto_if_lt _aideShortDowse
	npc_msg 16
	goto_if_no_item_space ITEM_DOWSING_MACHINE, 1, _aideBagFullDowse
	giveitem_no_check ITEM_DOWSING_MACHINE, 1
	setflag FLAG_P1_GOT_ITEMFINDER
_aideExplainDowse:
	npc_msg 20
	goto _aideDoneDowse

_aideShortDowse:
	npc_msg 21
_aideDoneDowse:
	wait_button
	closemsg
	releaseall
	end

_aideBagFullDowse:
	callstd std_bag_is_full
	closemsg
	releaseall
	end

scr_seq_P1_KANTO_009:
	simple_npc_msg 22
	end

scr_seq_P1_KANTO_010:
	simple_npc_msg 23
	end

scr_seq_P1_KANTO_011:
	simple_npc_msg 24
	end

scr_seq_P1_KANTO_012:
	simple_npc_msg 25
	end

scr_seq_P1_KANTO_013:
	simple_npc_msg 26
	end

scr_seq_P1_KANTO_014:
	simple_npc_msg 27
	end

scr_seq_P1_KANTO_017:
	simple_npc_msg 29
	end

scr_seq_P1_KANTO_018:
	simple_npc_msg 30
	end

// HeartGold's Route 18 gate logic (vars 0x4129/0x412A, flag 0x149 are HeartGold's own)
scr_seq_P1_KANTO_015:
	lockall
	player_on_bike_check VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _onBike
	apply_movement obj_player, _faceNorth
	wait_movement
	npc_msg 28
	closemsg
	apply_movement obj_player, _stepEast
	wait_movement
	releaseall
	end

_onBike:
	scrcmd_186 1
	setvar 0x4129, 1
	setvar 0x412A, 1
	setflag 0x149
	releaseall
	end

scr_seq_P1_KANTO_016:
	scrcmd_186 0
	setvar 0x4129, 0
	setvar 0x412A, 0
	clearflag 0x149
	end

scr_seq_P1_KANTO_019:
	goto_if_unset 0x149, _resumeDone
	scrcmd_186 1
_resumeDone:
	end

	.balign 4
_faceNorth:
	step 0, 1
	step_end

	.balign 4
_stepEast:
	step 15, 1
	step_end
