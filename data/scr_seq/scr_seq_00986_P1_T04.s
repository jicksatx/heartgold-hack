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

// hack: Cerulean City in Part 1 (FireRed).  events: data/eventdata/part1/506_P1_T04.json, text: data/text/868.txt.
// Blue battles Red at the road north to Nugget Bridge.  no Cerulean Cave warp in Part 1.  after Bill's S.S.
// Ticket the Rocket burglar shows up.  the exits south / east are test-build stops for now.

.equ OBJ_BLUE, 0
.equ OBJ_GRUNT, 3

.data

scrdef scr_seq_P1_T04_001 // Blue
scrdef scr_seq_P1_T04_002 // city sign
scrdef scr_seq_P1_T04_003 // Gym sign
scrdef scr_seq_P1_T04_004 // bike shop sign
scrdef scr_seq_P1_T04_005 // trainer tips
scrdef scr_seq_P1_T04_006 // youngster
scrdef scr_seq_P1_T04_007 // old man (robbery)
scrdef scr_seq_P1_T04_008 // test build stop
scrdef scr_seq_P1_T04_009 // Gym door (test build)
scrdef scr_seq_P1_T04_010 // Rt. 24 sign
scrdef scr_seq_P1_T04_011 // Team Rocket burglar (after the S.S. Ticket)
scrdef scr_seq_P1_T04_012 // on transition
scrdef_end

scr_seq_P1_T04_001:
	lockall
	get_player_coords VAR_SPECIAL_x8004, VAR_SPECIAL_x8005
	move_person OBJ_BLUE, VAR_SPECIAL_x8004, 96
	clearflag FLAG_P1_HIDE_CERULEAN_BLUE
	show_person OBJ_BLUE
	apply_movement OBJ_BLUE, _blueEnter
	wait_movement
	buffer_players_name 0
	npc_msg 0
	closemsg
	get_starter_choice VAR_TEMP_x4001
	compare VAR_TEMP_x4001, 152
	goto_if_eq _battleVsGrass
	compare VAR_TEMP_x4001, 155
	goto_if_eq _battleVsFire
	trainer_battle TRAINER_P1_RIVAL_CERULEAN_BULBASAUR, 0, 0, 0
	goto _afterBattle

_battleVsGrass:
	trainer_battle TRAINER_P1_RIVAL_CERULEAN_CHARMANDER, 0, 0, 0
	goto _afterBattle

_battleVsFire:
	trainer_battle TRAINER_P1_RIVAL_CERULEAN_SQUIRTLE, 0, 0, 0
_afterBattle:
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	setvar VAR_P1_CERULEAN, 1
	npc_msg 1
	closemsg
	apply_movement OBJ_BLUE, _blueExit
	wait_movement
	hide_person OBJ_BLUE
	setflag FLAG_P1_HIDE_CERULEAN_BLUE
	releaseall
	end

_lost:
	white_out
	releaseall
	end

scr_seq_P1_T04_002:
	direction_signpost 3, 0, 4, VAR_SPECIAL_RESULT
	scrcmd_057 3
	scrcmd_058
	scrcmd_060 VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_T04_003:
	scrcmd_055 2, 0
	scrcmd_057 3
	scrcmd_058
	trainer_tips 4, VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_T04_004:
	scrcmd_055 2, 0
	scrcmd_057 3
	scrcmd_058
	trainer_tips 5, VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_T04_005:
	scrcmd_055 2, 0
	scrcmd_057 3
	scrcmd_058
	trainer_tips 6, VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_T04_006:
	simple_npc_msg 7
	end

scr_seq_P1_T04_007:
	simple_npc_msg 8
	end

scr_seq_P1_T04_008:
	lockall
	npc_msg 9
	closemsg
	get_player_facing VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _backSouth
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _backNorth
	apply_movement obj_player, _backWest
	goto _stopDone

_backSouth:
	apply_movement obj_player, _stepSouth
	goto _stopDone

_backNorth:
	apply_movement obj_player, _stepNorth
_stopDone:
	wait_movement
	releaseall
	end

scr_seq_P1_T04_009:
	simple_npc_msg 10
	end

scr_seq_P1_T04_010:
	direction_signpost 11, 1, 14, VAR_SPECIAL_RESULT
	scrcmd_057 3
	scrcmd_058
	scrcmd_060 VAR_SPECIAL_RESULT
	callstd std_signpost
	end

// FireRed: the Rocket who robbed the house returns the stolen TM28
scr_seq_P1_T04_011:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_defeated TRAINER_P1_TEAM_ROCKET_GRUNT_5, _gruntGiveTM
	npc_msg 12
	closemsg
	trainer_battle TRAINER_P1_TEAM_ROCKET_GRUNT_5, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
_gruntGiveTM:
	npc_msg 13
	goto_if_no_item_space ITEM_TM028, 1, _gruntBagFull
	giveitem_no_check ITEM_TM028, 1
	setflag FLAG_P1_GOT_TM28
	npc_msg 14
	wait_button
	closemsg
	fade_screen 6, 1, 0, 0
	wait_fade
	hide_person OBJ_GRUNT
	setflag FLAG_P1_HIDE_CERULEAN_GRUNT
	fade_screen 6, 1, 1, 0
	wait_fade
	releaseall
	end

_gruntBagFull:
	callstd std_bag_is_full
	closemsg
	releaseall
	end

scr_seq_P1_T04_012:
	setflag FLAG_P1_HIDE_CERULEAN_GRUNT
	goto_if_set FLAG_P1_GOT_TM28, _onTransitionDone
	compare VAR_P1_BILL, 2
	goto_if_ne _onTransitionDone
	clearflag FLAG_P1_HIDE_CERULEAN_GRUNT
_onTransitionDone:
	end

	.balign 4
_blueEnter:
	step 13, 3  // walk south
	step_end

	.balign 4
_blueExit:
	step 12, 4  // walk north
	step 69, 1
	step_end

	.balign 4
_stepSouth:
	step 13, 1
	step_end

	.balign 4
_stepNorth:
	step 12, 1
	step_end

	.balign 4
_backWest:
	step 14, 1
	step_end
