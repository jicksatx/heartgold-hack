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

// hack: Lavender Town in Part 1 (FireRed).  events: data/eventdata/part1/532_P1_T05.json, text: data/text/884.txt.
// HeartGold's Radio Tower stands where the Pokemon Tower was; its door is closed until the Tower is built (3D map).
// Route 8 (west) and Route 12 (south) are test-build stops for now.

.data

scrdef scr_seq_P1_T05_001 // town sign
scrdef scr_seq_P1_T05_002 // Pokemon Tower sign
scrdef scr_seq_P1_T05_003 // House of Memories sign
scrdef scr_seq_P1_T05_004 // Volunteer Pokemon House sign
scrdef scr_seq_P1_T05_005 // Tower door (test build)
scrdef scr_seq_P1_T05_006 // woman (ghosts)
scrdef scr_seq_P1_T05_007 // boy
scrdef scr_seq_P1_T05_008 // girl
scrdef scr_seq_P1_T05_009 // test build stop
scrdef_end

scr_seq_P1_T05_001:
	direction_signpost 0, 0, 5, VAR_SPECIAL_RESULT
	scrcmd_057 3
	scrcmd_058
	scrcmd_060 VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_T05_002:
	scrcmd_055 2, 0
	scrcmd_057 3
	scrcmd_058
	trainer_tips 1, VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_T05_003:
	scrcmd_055 2, 0
	scrcmd_057 3
	scrcmd_058
	trainer_tips 2, VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_T05_004:
	scrcmd_055 2, 0
	scrcmd_057 3
	scrcmd_058
	trainer_tips 3, VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_T05_005:
	simple_npc_msg 4
	end

scr_seq_P1_T05_006:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	npc_msg 5
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _noGhosts
	npc_msg 6
	goto _talkDone

_noGhosts:
	npc_msg 7
_talkDone:
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_T05_007:
	simple_npc_msg 8
	end

scr_seq_P1_T05_008:
	simple_npc_msg 9
	end

scr_seq_P1_T05_009:
	lockall
	get_player_facing VAR_SPECIAL_RESULT
	npc_msg 10
	closemsg
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _backSouth
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _backNorth
	compare VAR_SPECIAL_RESULT, 2
	goto_if_eq _backEast
	apply_movement obj_player, _stepWest
	goto _stopDone

_backSouth:
	apply_movement obj_player, _stepSouth
	goto _stopDone

_backNorth:
	apply_movement obj_player, _stepNorth
	goto _stopDone

_backEast:
	apply_movement obj_player, _stepEast
_stopDone:
	wait_movement
	releaseall
	end

	.balign 4
_stepSouth:
	step 13, 1
	step_end

	.balign 4
_stepNorth:
	step 12, 1
	step_end

	.balign 4
_stepEast:
	step 15, 1
	step_end

	.balign 4
_stepWest:
	step 14, 1
	step_end
