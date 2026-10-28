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

// hack: Cinnabar Island in Part 1 (FireRed).  HeartGold's Cinnabar is the ruins after the eruption (only a Pokemon
// Center), so the other buildings are doors you face in the ruins (bg events) that warp to stand-ins: the Pokemon
// Mansion = Burned Tower, the Gym = HeartGold's Seafoam Islands Gym, the Pokemon Lab = Elm's Lab, the Poke Mart = the
// Violet Mart.  Their exits come back to new warp spots in front of each door.  The Gym is locked until the Secret Key.
// events: 593 (island), 594 (Pokemon Center), 595 (Lab), 596 (Mart).  text: data/text/912.txt

.equ SPECIES_OMANYTE, 138
.equ SPECIES_KABUTO, 140
.equ SPECIES_AERODACTYL, 142

.data

scrdef scr_seq_P1_T09_001 // island sign
scrdef scr_seq_P1_T09_002 // Pokemon Lab door
scrdef scr_seq_P1_T09_003 // Gym door
scrdef scr_seq_P1_T09_004 // Pokemon Mansion door
scrdef scr_seq_P1_T09_005 // Poke Mart door
scrdef scr_seq_P1_T09_006 // woman
scrdef scr_seq_P1_T09_007 // man
scrdef scr_seq_P1_T09_008 // Pokemon Center nurse
scrdef scr_seq_P1_T09_009 // Pokemon Center visitors
scrdef scr_seq_P1_T09_010
scrdef scr_seq_P1_T09_011 // Mart clerk
scrdef scr_seq_P1_T09_012 // Mart shoppers
scrdef scr_seq_P1_T09_013
scrdef scr_seq_P1_T09_014 // Lab: entrance scientist
scrdef scr_seq_P1_T09_015 // Lab: photo of Dr. Fuji
scrdef scr_seq_P1_T09_016 // Lab: fossil fan
scrdef scr_seq_P1_T09_017 // Lab: Eevee researcher
scrdef scr_seq_P1_T09_018 // Lab: e-mail
scrdef scr_seq_P1_T09_019 // Lab: amber pipe
scrdef scr_seq_P1_T09_020 // Lab: the fossil doctor
scrdef scr_seq_P1_T09_021 // Lab: Electrode trade
scrdef scr_seq_P1_T09_022 // Lab: Tangela trade
scrdef scr_seq_P1_T09_023 // Lab: Seel trade
scrdef_end

scr_seq_P1_T09_001:
	simple_npc_msg 0
	end

scr_seq_P1_T09_002:
	play_se SEQ_SE_DP_SELECT
	lockall
	npc_msg 1
	closemsg
	play_se SEQ_SE_DP_DOOR_OPEN
	fade_screen 6, 1, 0, 0
	wait_fade
	warp MAP_T20R0101, 0, 4, 13, DIR_NORTH
	fade_screen 6, 1, 1, 0
	wait_fade
	releaseall
	end

scr_seq_P1_T09_003:
	play_se SEQ_SE_DP_SELECT
	lockall
	npc_msg 2
	goto_if_unset FLAG_P1_SECRET_KEY, _gymLocked
	closemsg
	play_se SEQ_SE_DP_DOOR_OPEN
	fade_screen 6, 1, 0, 0
	wait_fade
	warp MAP_D11R0106, 0, 14, 24, DIR_NORTH
	fade_screen 6, 1, 1, 0
	wait_fade
	releaseall
	end

_gymLocked:
	npc_msg 3
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_T09_004:
	play_se SEQ_SE_DP_SELECT
	lockall
	npc_msg 6
	closemsg
	play_se SEQ_SE_DP_DOOR_OPEN
	fade_screen 6, 1, 0, 0
	wait_fade
	warp MAP_D18R0101, 0, 15, 25, DIR_NORTH
	fade_screen 6, 1, 1, 0
	wait_fade
	releaseall
	end

scr_seq_P1_T09_005:
	play_se SEQ_SE_DP_SELECT
	lockall
	npc_msg 7
	closemsg
	play_se SEQ_SE_DP_DOOR_OPEN
	fade_screen 6, 1, 0, 0
	wait_fade
	warp MAP_T22FS0101, 0, 4, 10, DIR_NORTH
	fade_screen 6, 1, 1, 0
	wait_fade
	releaseall
	end

scr_seq_P1_T09_006:
	simple_npc_msg 4
	end

scr_seq_P1_T09_007:
	simple_npc_msg 5
	end

scr_seq_P1_T09_008:
	setvar VAR_SPECIAL_x8007, 0
	callstd std_nurse_joy
	end

scr_seq_P1_T09_009:
	simple_npc_msg 8
	end

scr_seq_P1_T09_010:
	simple_npc_msg 9
	end

scr_seq_P1_T09_011:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	callstd std_mart_intro
	holdmsg
	setvar VAR_SPECIAL_x8004, 1
	callstd std_pokemart
	releaseall
	end

scr_seq_P1_T09_012:
	simple_npc_msg 10
	end

scr_seq_P1_T09_013:
	simple_npc_msg 11
	end

scr_seq_P1_T09_014:
	simple_npc_msg 12
	end

scr_seq_P1_T09_015:
	simple_npc_msg 13
	end

scr_seq_P1_T09_016:
	simple_npc_msg 14
	end

scr_seq_P1_T09_017:
	simple_npc_msg 15
	end

scr_seq_P1_T09_018:
	simple_npc_msg 16
	end

scr_seq_P1_T09_019:
	simple_npc_msg 17
	end

// FireRed's doctor keeps the fossil while you take a walk; here the machine is quick (it saves a trip out and back)
scr_seq_P1_T09_020:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	npc_msg 18
	hasitem ITEM_HELIX_FOSSIL, 1, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _helix
	hasitem ITEM_DOME_FOSSIL, 1, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _dome
	hasitem ITEM_OLD_AMBER, 1, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _amber
	npc_msg 19
	goto _labDone

_helix:
	setvar VAR_SPECIAL_x8006, 0
	goto _revive
_dome:
	setvar VAR_SPECIAL_x8006, 1
	goto _revive
_amber:
	setvar VAR_SPECIAL_x8006, 2
_revive:
	get_party_count VAR_SPECIAL_x8005
	compare VAR_SPECIAL_x8005, 6
	goto_if_eq _partyFull
	buffer_players_name 0
	compare VAR_SPECIAL_x8006, 0
	goto_if_eq _reviveHelix
	compare VAR_SPECIAL_x8006, 1
	goto_if_eq _reviveDome
	npc_msg 22
	takeitem ITEM_OLD_AMBER, 1, VAR_SPECIAL_RESULT
	npc_msg 23
	give_mon SPECIES_AERODACTYL, 5, 0, 0, 0, VAR_SPECIAL_RESULT
	play_fanfare SEQ_ME_POKEGET
	npc_msg 26
	goto _revived

_reviveHelix:
	npc_msg 20
	takeitem ITEM_HELIX_FOSSIL, 1, VAR_SPECIAL_RESULT
	npc_msg 23
	give_mon SPECIES_OMANYTE, 5, 0, 0, 0, VAR_SPECIAL_RESULT
	play_fanfare SEQ_ME_POKEGET
	npc_msg 24
	goto _revived

_reviveDome:
	npc_msg 21
	takeitem ITEM_DOME_FOSSIL, 1, VAR_SPECIAL_RESULT
	npc_msg 23
	give_mon SPECIES_KABUTO, 5, 0, 0, 0, VAR_SPECIAL_RESULT
	play_fanfare SEQ_ME_POKEGET
	npc_msg 25
_revived:
	wait_fanfare
	closemsg
	releaseall
	end

_partyFull:
	npc_msg 27
_labDone:
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_T09_021:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	load_npc_trade 32
	get_offered_species VAR_SPECIAL_x8006
	npc_trade_get_req_species VAR_SPECIAL_x8007
	npc_trade_end
	buffer_species_name 0, VAR_SPECIAL_x8007, 0, 0
	buffer_species_name 1, VAR_SPECIAL_x8006, 0, 0
	goto_if_set FLAG_P1_TRADE_ELECTRODE, _tradeAfterLab1
	npc_msg 33
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _tradeDeclineLab1
	closemsg
	fade_screen 6, 1, 0, 0
	wait_fade
	scrcmd_566
	get_party_selection VAR_SPECIAL_RESULT
	restore_overworld
	fade_screen 6, 1, 1, 0
	wait_fade
	compare VAR_SPECIAL_RESULT, 255
	goto_if_eq _tradeDeclineLab1
	copyvar VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
	get_partymon_species VAR_SPECIAL_x8004, VAR_SPECIAL_x8005
	compare_var_to_var VAR_SPECIAL_x8005, VAR_SPECIAL_x8007
	goto_if_ne _tradeWrongLab1
	load_npc_trade 32
	npc_trade_exec VAR_SPECIAL_x8004
	npc_trade_end
	setflag FLAG_P1_TRADE_ELECTRODE
	npc_msg 34
	goto _tradeDoneLab1

_tradeWrongLab1:
	npc_msg 36
	goto _tradeDoneLab1

_tradeDeclineLab1:
	npc_msg 35
	goto _tradeDoneLab1

_tradeAfterLab1:
	npc_msg 37
_tradeDoneLab1:
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_T09_022:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	load_npc_trade 33
	get_offered_species VAR_SPECIAL_x8006
	npc_trade_get_req_species VAR_SPECIAL_x8007
	npc_trade_end
	buffer_species_name 0, VAR_SPECIAL_x8007, 0, 0
	buffer_species_name 1, VAR_SPECIAL_x8006, 0, 0
	goto_if_set FLAG_P1_TRADE_TANGELA, _tradeAfterLab2
	npc_msg 38
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _tradeDeclineLab2
	closemsg
	fade_screen 6, 1, 0, 0
	wait_fade
	scrcmd_566
	get_party_selection VAR_SPECIAL_RESULT
	restore_overworld
	fade_screen 6, 1, 1, 0
	wait_fade
	compare VAR_SPECIAL_RESULT, 255
	goto_if_eq _tradeDeclineLab2
	copyvar VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
	get_partymon_species VAR_SPECIAL_x8004, VAR_SPECIAL_x8005
	compare_var_to_var VAR_SPECIAL_x8005, VAR_SPECIAL_x8007
	goto_if_ne _tradeWrongLab2
	load_npc_trade 33
	npc_trade_exec VAR_SPECIAL_x8004
	npc_trade_end
	setflag FLAG_P1_TRADE_TANGELA
	npc_msg 39
	goto _tradeDoneLab2

_tradeWrongLab2:
	npc_msg 41
	goto _tradeDoneLab2

_tradeDeclineLab2:
	npc_msg 40
	goto _tradeDoneLab2

_tradeAfterLab2:
	npc_msg 42
_tradeDoneLab2:
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_T09_023:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	load_npc_trade 34
	get_offered_species VAR_SPECIAL_x8006
	npc_trade_get_req_species VAR_SPECIAL_x8007
	npc_trade_end
	buffer_species_name 0, VAR_SPECIAL_x8007, 0, 0
	buffer_species_name 1, VAR_SPECIAL_x8006, 0, 0
	goto_if_set FLAG_P1_TRADE_SEEL, _tradeAfterLab3
	npc_msg 28
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _tradeDeclineLab3
	closemsg
	fade_screen 6, 1, 0, 0
	wait_fade
	scrcmd_566
	get_party_selection VAR_SPECIAL_RESULT
	restore_overworld
	fade_screen 6, 1, 1, 0
	wait_fade
	compare VAR_SPECIAL_RESULT, 255
	goto_if_eq _tradeDeclineLab3
	copyvar VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
	get_partymon_species VAR_SPECIAL_x8004, VAR_SPECIAL_x8005
	compare_var_to_var VAR_SPECIAL_x8005, VAR_SPECIAL_x8007
	goto_if_ne _tradeWrongLab3
	load_npc_trade 34
	npc_trade_exec VAR_SPECIAL_x8004
	npc_trade_end
	setflag FLAG_P1_TRADE_SEEL
	npc_msg 29
	goto _tradeDoneLab3

_tradeWrongLab3:
	npc_msg 31
	goto _tradeDoneLab3

_tradeDeclineLab3:
	npc_msg 30
	goto _tradeDoneLab3

_tradeAfterLab3:
	npc_msg 32
_tradeDoneLab3:
	wait_button
	closemsg
	releaseall
	end

