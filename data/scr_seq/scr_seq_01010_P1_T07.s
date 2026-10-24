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

// hack: Celadon City in Part 1 (FireRed).  events: data/eventdata/part1/537_P1_T07.json, text: data/text/888.txt.
// Route 16 (west) is a test-build stop for now

.data

scrdef scr_seq_P1_T07_001 // city sign
scrdef scr_seq_P1_T07_002 // Gym sign
scrdef scr_seq_P1_T07_003 // mansion sign
scrdef scr_seq_P1_T07_004 // department store sign
scrdef scr_seq_P1_T07_005 // prize exchange sign
scrdef scr_seq_P1_T07_006 // Game Corner sign
scrdef scr_seq_P1_T07_007 // woman
scrdef scr_seq_P1_T07_008 // old man
scrdef scr_seq_P1_T07_009 // boy
scrdef scr_seq_P1_T07_010 // test build stop
scrdef_end

scr_seq_P1_T07_001:
	direction_signpost 0, 0, 7, VAR_SPECIAL_RESULT
	scrcmd_057 3
	scrcmd_058
	scrcmd_060 VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_T07_002:
	scrcmd_055 2, 0
	scrcmd_057 3
	scrcmd_058
	trainer_tips 1, VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_T07_003:
	scrcmd_055 2, 0
	scrcmd_057 3
	scrcmd_058
	trainer_tips 2, VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_T07_004:
	scrcmd_055 2, 0
	scrcmd_057 3
	scrcmd_058
	trainer_tips 3, VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_T07_005:
	scrcmd_055 2, 0
	scrcmd_057 3
	scrcmd_058
	trainer_tips 4, VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_T07_006:
	scrcmd_055 2, 0
	scrcmd_057 3
	scrcmd_058
	trainer_tips 5, VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_T07_007:
	simple_npc_msg 6
	end

scr_seq_P1_T07_008:
	simple_npc_msg 7
	end

scr_seq_P1_T07_009:
	simple_npc_msg 8
	end

scr_seq_P1_T07_010:
	lockall
	npc_msg 9
	closemsg
	apply_movement obj_player, _stepEast
	wait_movement
	releaseall
	end

	.balign 4
_stepEast:
	step 15, 1
	step_end
