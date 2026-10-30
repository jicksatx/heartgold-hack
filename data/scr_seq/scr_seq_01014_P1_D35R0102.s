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

// hack: Rocket Hideout in Part 1 (FireRed) is HeartGold's Team Rocket HQ (B1F-B3F; entered from the Rocket Game
// Corner): B1F and B2F are the HQ's, B3F is Ice Path B2F's ice puzzle (standing in for FireRed's spin-tile mazes),
// B4F is the HQ's B3F.  A Grunt on B4F drops the Lift Key; the elevator (Goldenrod Dept. Store's) runs between B4F and
// the HQ B2F corridor whose stairs lead down to Giovanni's office, where he leaves the Silph Scope.
// shared by events 541-543 (HQ), 559 (ice room), 560 (elevator, header scr_seq_01026), text: data/text/892.txt

.equ OBJ_GIOVANNI, 0

.data

scrdef scr_seq_P1_D35R0102_001 // Giovanni
scrdef scr_seq_P1_D35R0102_002 // Grunt with the Lift Key
scrdef scr_seq_P1_D35R0102_003 // elevator panel
scrdef scr_seq_P1_D35R0102_004 // elevator: on transition
scrdef scr_seq_P1_D35R0102_005 // ice room boulders (fixed: they're part of the puzzle)
scrdef_end

scr_seq_P1_D35R0102_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	npc_msg 0
	closemsg
	trainer_battle TRAINER_P1_BOSS_GIOVANNI, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	npc_msg 1
	closemsg
	fade_screen 6, 1, 0, 0
	wait_fade
	hide_person OBJ_GIOVANNI
	setflag FLAG_P1_HIDE_HIDEOUT_GIOVANNI
	fade_screen 6, 1, 1, 0
	wait_fade
	npc_msg 2
	giveitem_no_check ITEM_SILPH_SCOPE, 1
	closemsg
	releaseall
	end

_lost:
	white_out
	releaseall
	end

scr_seq_P1_D35R0102_002:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_set FLAG_P1_GOT_LIFT_KEY, _gruntAfter
	openmsg // trainer_message needs the window open (HeartGold's trainer scripts do the same)
	trainer_message TRAINER_P1_TEAM_ROCKET_GRUNT_16, 0
	closemsg
	trainer_battle TRAINER_P1_TEAM_ROCKET_GRUNT_16, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	npc_msg 3
	giveitem_no_check ITEM_LIFT_KEY, 1
	setflag FLAG_P1_GOT_LIFT_KEY
	closemsg
	releaseall
	end

_gruntAfter:
	openmsg
	trainer_message TRAINER_P1_TEAM_ROCKET_GRUNT_16, 2
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_D35R0102_003:
	play_se SEQ_SE_DP_SELECT
	lockall
	hasitem ITEM_LIFT_KEY, 1, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _needKey
	npc_msg 5
	touchscreen_menu_hide
	menu_init 1, 1, 0, 1, VAR_SPECIAL_RESULT
	menu_item_add 6, 255, 1
	menu_item_add 7, 255, 0
	menu_item_add 8, 255, 2
	menu_exec
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 1
	goto_if_gt _liftDone
	compare_var_to_var VAR_SPECIAL_RESULT, VAR_P1_LIFT
	goto_if_eq _sameFloor
	copyvar VAR_P1_LIFT, VAR_SPECIAL_RESULT
	setvar VAR_SPECIAL_x8005, 2
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _toB2F
	set_dynamic_warp MAP_D35R0104, 3, 51, 4, DIR_SOUTH
	setvar VAR_SPECIAL_x8004, 1
	goto _ride

_toB2F:
	set_dynamic_warp MAP_D35R0103, 4, 51, 4, DIR_SOUTH
	setvar VAR_SPECIAL_x8004, 0
_ride:
	closemsg
	wait_se SEQ_SE_DP_SELECT
	elevator_anim VAR_SPECIAL_x8004, VAR_SPECIAL_x8005
	releaseall
	end

_sameFloor:
	npc_msg 9
	wait_button
_liftDone:
	closemsg
	releaseall
	end

_needKey:
	npc_msg 4
	wait_button
	closemsg
	releaseall
	end

// the elevator's door is a dynamic warp: point it at the floor the player came from (the B2F corridor's stairs arrive
// one tile to the right of the door)
scr_seq_P1_D35R0102_004:
	get_player_coords VAR_SPECIAL_x8004, VAR_SPECIAL_x8005
	compare VAR_SPECIAL_x8004, 4
	goto_if_eq _fromB2F
	setvar VAR_P1_LIFT, 0
	set_dynamic_warp MAP_D35R0104, 3, 51, 4, DIR_SOUTH
	end

_fromB2F:
	setvar VAR_P1_LIFT, 1
	set_dynamic_warp MAP_D35R0103, 4, 51, 4, DIR_SOUTH
	end

scr_seq_P1_D35R0102_005:
	end
