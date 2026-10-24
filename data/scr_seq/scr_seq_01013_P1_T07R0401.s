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
// Japanese release's full Game Corner map (still in the ROM).  a Rocket guards the poster; the switch behind it leads
// down to the Rocket Hideout (Team Rocket HQ).  events: data/eventdata/part1/540_P1_T07R0401.json, text: 891.txt

.equ OBJ_GRUNT, 0

.data

scrdef scr_seq_P1_T07R0401_001 // Rocket guarding the poster
scrdef scr_seq_P1_T07R0401_002 // clerk
scrdef scr_seq_P1_T07R0401_003 // gamblers
scrdef scr_seq_P1_T07R0401_004
scrdef scr_seq_P1_T07R0401_005
scrdef scr_seq_P1_T07R0401_006
scrdef scr_seq_P1_T07R0401_007
scrdef scr_seq_P1_T07R0401_008 // slot machines
scrdef scr_seq_P1_T07R0401_009 // poster
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
	simple_npc_msg 9
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
