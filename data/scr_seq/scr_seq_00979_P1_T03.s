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

// hack: Pewter City in Part 1 (FireRed).  events: data/eventdata/part1/501_P1_T03.json, text: data/text/862.txt,
// header scr_seq_00980_P1_T03_hdr.s.  the east exit (Route 3): before the Boulder Badge the Gym guide sends Red to
// Brock; after it, Oak's aide brings the Running Shoes.

.equ OBJ_GUIDE, 0
.equ OBJ_AIDE, 1

.data

scrdef scr_seq_P1_T03_001 // Gym guide
scrdef scr_seq_P1_T03_002 // woman
scrdef scr_seq_P1_T03_003 // bug catcher
scrdef scr_seq_P1_T03_004 // city sign
scrdef scr_seq_P1_T03_005 // Gym sign
scrdef scr_seq_P1_T03_006 // museum sign
scrdef scr_seq_P1_T03_007 // welcome sign
scrdef scr_seq_P1_T03_008 // east exit before the badge
scrdef scr_seq_P1_T03_009 // east exit after the badge: Running Shoes
scrdef scr_seq_P1_T03_010 // test build: end of what's built so far
scrdef scr_seq_P1_T03_011 // on transition
scrdef_end

scr_seq_P1_T03_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	check_badge BADGE_BOULDER, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _guideAfter
	npc_msg 1
	goto _talkDone

_guideAfter:
	npc_msg 2
	goto _talkDone

scr_seq_P1_T03_002:
	simple_npc_msg 3
	end

scr_seq_P1_T03_003:
	simple_npc_msg 4
	end

scr_seq_P1_T03_004:
	direction_signpost 5, 0, 3, VAR_SPECIAL_RESULT
	scrcmd_057 3
	scrcmd_058
	scrcmd_060 VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_T03_005:
	scrcmd_055 2, 0
	scrcmd_057 3
	scrcmd_058
	trainer_tips 6, VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_T03_006:
	scrcmd_055 2, 0
	scrcmd_057 3
	scrcmd_058
	trainer_tips 7, VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_T03_007:
	direction_signpost 8, 2, 0, VAR_SPECIAL_RESULT
	scrcmd_057 3
	scrcmd_058
	scrcmd_060 VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_T03_008:
	lockall
	apply_movement OBJ_GUIDE, _notice
	wait_movement
	npc_msg 0
	closemsg
	apply_movement obj_player, _stepWest
	wait_movement
	releaseall
	end

scr_seq_P1_T03_009:
	lockall
	buffer_players_name 0
	npc_msg 9
	closemsg
	get_player_coords VAR_SPECIAL_x8004, VAR_SPECIAL_x8005
	move_person OBJ_AIDE, 1082, VAR_SPECIAL_x8005
	clearflag FLAG_P1_HIDE_PEWTER_AIDE
	show_person OBJ_AIDE
	apply_movement OBJ_AIDE, _aideApproach
	apply_movement obj_player, _faceWest
	wait_movement
	npc_msg 10
	give_running_shoes
	buffer_players_name 0
	npc_msg 11
	play_fanfare SEQ_ME_KEYITEM
	wait_fanfare
	buffer_players_name 0
	npc_msg 12
	npc_msg 13
	closemsg
	apply_movement OBJ_AIDE, _aideLeave
	wait_movement
	hide_person OBJ_AIDE
	setflag FLAG_P1_HIDE_PEWTER_AIDE
	setvar VAR_P1_STORY, 8
	releaseall
	end

scr_seq_P1_T03_010:
	lockall
	npc_msg 14
	closemsg
	apply_movement obj_player, _stepWest
	wait_movement
	releaseall
	end

scr_seq_P1_T03_011:
	setflag FLAG_P1_HIDE_PEWTER_AIDE
	end

_talkDone:
	wait_button
	closemsg
	releaseall
	end

	.balign 4
_notice:
	step 75, 1  // !
	step_end

	.balign 4
_stepWest:
	step 14, 1
	step_end

	.balign 4
_faceWest:
	step 2, 1
	step_end

	.balign 4
_aideApproach:
	step 15, 2  // walk east
	step_end

	.balign 4
_aideLeave:
	step 14, 3  // walk west
	step_end
