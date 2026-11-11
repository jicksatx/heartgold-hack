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

// hack: Rocket Game Corner in Part 1 (FireRed).  HeartGold's US Game Corner is a small closed room, so Part 1 uses the
// Japanese release's full Game Corner map (still in the ROM).  Its left bank of slot machines plays Voltorb Flip (the
// US game's coin game), the right bank is out of order; the clerk sells Coins.  a Rocket guards the poster; the
// switch behind it leads down to the Rocket Hideout (Team Rocket HQ).  events: data/eventdata/part1/540_P1_T07R0401.json, text: 891.txt

.equ OBJ_GRUNT, 0

.data

scrdef scr_seq_P1_T07R0401_001 // Rocket guarding the poster
scrdef scr_seq_P1_T07R0401_002 // clerk (sells Coins)
scrdef scr_seq_P1_T07R0401_003 // gamblers
scrdef scr_seq_P1_T07R0401_004
scrdef scr_seq_P1_T07R0401_005
scrdef scr_seq_P1_T07R0401_006
scrdef scr_seq_P1_T07R0401_007
scrdef scr_seq_P1_T07R0401_008 // slot machines
scrdef scr_seq_P1_T07R0401_009 // poster
scrdef scr_seq_P1_T07R0401_010 // Voltorb Flip machines
scrdef scr_seq_P1_T07R0401_011 // slot machines (one script per machine: its id picks its setting)
scrdef scr_seq_P1_T07R0401_012
scrdef scr_seq_P1_T07R0401_013
scrdef scr_seq_P1_T07R0401_014
scrdef scr_seq_P1_T07R0401_015
scrdef scr_seq_P1_T07R0401_016
scrdef scr_seq_P1_T07R0401_017
scrdef scr_seq_P1_T07R0401_018 // sign: VOLTORB Flip (left bank)
scrdef scr_seq_P1_T07R0401_019 // sign: slot machines (right bank)
scrdef scr_seq_P1_T07R0401_020 // guide by the entrance
scrdef_end

scr_seq_P1_T07R0401_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	npc_msg 0
	closemsg
	trainer_battle TRAINER_P1_TEAM_ROCKET_GRUNT_7, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	npc_msg 1
	closemsg
	get_player_facing VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 3
	goto_if_eq _playerWest
	apply_movement OBJ_GRUNT, _gruntLeaveWest
	goto _gruntGone

_playerWest:
	apply_movement OBJ_GRUNT, _gruntLeaveSouth
_gruntGone:
	wait_movement
	hide_person OBJ_GRUNT
	setflag FLAG_P1_HIDE_GC_GRUNT
	releaseall
	end

_lost:
	white_out
	releaseall
	end

scr_seq_P1_T07R0401_002:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	npc_msg 11
	hasitem ITEM_COIN_CASE, 1, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _noCoinCase
	script_overlay_cmd 3, 0
	touchscreen_menu_hide
	scrcmd_116 0, 20, 2
	show_money_box 20, 7
	menu_init 1, 1, 0, 1, VAR_SPECIAL_RESULT
	menu_item_add 17, 255, 0
	menu_item_add 18, 255, 1
	menu_item_add 19, 255, 2
	menu_exec
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _buy50
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _buy500
	npc_msg 16
	goto _coinsDone

_buy50:
	hasenoughmoneyimmediate VAR_SPECIAL_RESULT, 1000
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _cantAfford
	checkgivecoins VAR_SPECIAL_RESULT, 50
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _caseFull
	submoneyimmediate 1000
	give_coins 50
	goto _bought

_buy500:
	hasenoughmoneyimmediate VAR_SPECIAL_RESULT, 10000
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _cantAfford
	checkgivecoins VAR_SPECIAL_RESULT, 500
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _caseFull
	submoneyimmediate 10000
	give_coins 500
_bought:
	scrcmd_118 0
	update_money_box
	play_se SEQ_SE_DP_REGI
	wait_se SEQ_SE_DP_REGI
	npc_msg 15
	goto _coinsDone

_cantAfford:
	npc_msg 13
	goto _coinsDone

_caseFull:
	npc_msg 14
_coinsDone:
	wait_button
	closemsg
	touchscreen_menu_show
	scrcmd_117
	hide_money_box
	script_overlay_cmd 3, 1
	releaseall
	end

_noCoinCase:
	npc_msg 12
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_T07R0401_003:
	simple_npc_msg 4
	end

scr_seq_P1_T07R0401_004:
	simple_npc_msg 5
	end

scr_seq_P1_T07R0401_005:
	simple_npc_msg 6
	end

scr_seq_P1_T07R0401_006:
	simple_npc_msg 7
	end

scr_seq_P1_T07R0401_007:
	simple_npc_msg 8
	end

scr_seq_P1_T07R0401_008:
	simple_npc_msg 3
	end

scr_seq_P1_T07R0401_009:
	goto_if_set FLAG_P1_HIDE_GC_GRUNT, _switch
	simple_npc_msg 10
	end

_switch:
	lockall
	npc_msg 2
	closemsg
	play_se SEQ_SE_DP_SELECT
	fade_screen 6, 1, 0, 0
	wait_fade
	warp MAP_D35R0102, 0, 50, 4, DIR_WEST
	fade_screen 6, 1, 1, 0
	wait_fade
	releaseall
	end

	.balign 4
_gruntLeaveWest:
	step 14, 1
	step 13, 1
	step 69, 1
	step_end

	.balign 4
_gruntLeaveSouth:
	step 13, 2
	step 69, 1
	step_end

scr_seq_P1_T07R0401_010:
	play_se SEQ_SE_DP_SELECT
	lockall
	hasitem ITEM_COIN_CASE, 1, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _flipNoCase
	npc_msg 21
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _flipNo
	closemsg
	fade_screen 6, 1, 0, 0
	wait_fade
	casino_game 0, 0
	restore_overworld
	fade_screen 6, 1, 1, 0
	wait_fade
	releaseall
	end

_flipNo:
	closemsg
	releaseall
	end

_flipNoCase:
	npc_msg 20
	wait_button
	closemsg
	releaseall
	end

// hack: working slot machines (Platinum's slot game, slots/ -> overlay 152; casino_game N, 2 in src/field/slot_machine.c)
scr_seq_P1_T07R0401_011:
	call _slotAsk
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _slotNo
	casino_game 0, 2
	goto _slotDone

scr_seq_P1_T07R0401_012:
	call _slotAsk
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _slotNo
	casino_game 1, 2
	goto _slotDone

scr_seq_P1_T07R0401_013:
	call _slotAsk
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _slotNo
	casino_game 2, 2
	goto _slotDone

scr_seq_P1_T07R0401_014:
	call _slotAsk
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _slotNo
	casino_game 3, 2
	goto _slotDone

scr_seq_P1_T07R0401_015:
	call _slotAsk
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _slotNo
	casino_game 4, 2
	goto _slotDone

scr_seq_P1_T07R0401_016:
	call _slotAsk
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _slotNo
	casino_game 5, 2
	goto _slotDone

scr_seq_P1_T07R0401_017:
	call _slotAsk
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _slotNo
	casino_game 6, 2
	goto _slotDone

_slotAsk:
	play_se SEQ_SE_DP_SELECT
	lockall
	hasitem ITEM_COIN_CASE, 1, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _slotNoCase
	npc_msg 22
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _slotAskEnd
	closemsg
	fade_screen 6, 1, 0, 0
	wait_fade
_slotAskEnd:
	return

_slotDone:
	restore_overworld
	fade_screen 6, 1, 1, 0
	wait_fade
	releaseall
	end

_slotNo:
	closemsg
	releaseall
	end

_slotNoCase:
	npc_msg 20
	wait_button
	closemsg
	releaseall
	end

// hack: signs on the counter screens by the entrance and a guide explaining the two banks
scr_seq_P1_T07R0401_018:
	play_se SEQ_SE_DP_SELECT
	lockall
	npc_msg 23
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_T07R0401_019:
	play_se SEQ_SE_DP_SELECT
	lockall
	npc_msg 24
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_T07R0401_020:
	simple_npc_msg 25
	end
	.balign 4
