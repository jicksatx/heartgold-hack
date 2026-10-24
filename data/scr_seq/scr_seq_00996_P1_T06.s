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

// hack: Vermilion City in Part 1 (FireRed).  events: data/eventdata/part1/515_P1_T06.json, text: data/text/876.txt.
// FireRed's small tree in front of the Gym (HeartGold's Cut tree there); Route 11 is a test-build stop for now

.data

scrdef scr_seq_P1_T06_001 // city sign
scrdef scr_seq_P1_T06_002 // Gym sign
scrdef scr_seq_P1_T06_003 // fan club sign
scrdef scr_seq_P1_T06_004 // harbor sign
scrdef scr_seq_P1_T06_005 // woman (Grimer)
scrdef scr_seq_P1_T06_006 // sailor (S.S. Anne)
scrdef scr_seq_P1_T06_007 // test build stop
scrdef scr_seq_P1_T06_008 // Gym door (test build)
scrdef_end

scr_seq_P1_T06_001:
	direction_signpost 0, 0, 6, VAR_SPECIAL_RESULT
	scrcmd_057 3
	scrcmd_058
	scrcmd_060 VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_T06_002:
	scrcmd_055 2, 0
	scrcmd_057 3
	scrcmd_058
	trainer_tips 1, VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_T06_003:
	scrcmd_055 2, 0
	scrcmd_057 3
	scrcmd_058
	trainer_tips 2, VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_T06_004:
	scrcmd_055 2, 0
	scrcmd_057 3
	scrcmd_058
	trainer_tips 3, VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_T06_005:
	simple_npc_msg 4
	end

scr_seq_P1_T06_006:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	compare VAR_P1_SSANNE, 2
	goto_if_eq _sailed
	npc_msg 5
	goto _talkDone

_sailed:
	npc_msg 6
_talkDone:
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_T06_007:
	lockall
	npc_msg 7
	closemsg
	apply_movement obj_player, _stepWest
	wait_movement
	releaseall
	end

scr_seq_P1_T06_008:
	simple_npc_msg 8
	end

	.balign 4
_stepWest:
	step 14, 1
	step_end
