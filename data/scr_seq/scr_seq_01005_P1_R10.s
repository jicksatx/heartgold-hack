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

// hack: Route 10 (both halves) in Part 1 (FireRed); Rock Tunnel uses this file too.  events: data/eventdata/part1/
// 528-531, text: data/text/883.txt.  the Power Plant door is rusted shut until Red has HM04
// Strength (FireRed only lets you Surf there, which comes from the same Safari trip)

.data

scrdef scr_seq_P1_R10_001 // Power Plant sign
scrdef scr_seq_P1_R10_002 // Rock Tunnel sign
scrdef scr_seq_P1_R10_003 // detour sign
scrdef scr_seq_P1_R10_004 // Power Plant door (coord in front of it, VAR_P1_POWER_PLANT 0)
scrdef_end

scr_seq_P1_R10_001:
	scrcmd_055 2, 0
	scrcmd_057 3
	scrcmd_058
	trainer_tips 0, VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_R10_002:
	scrcmd_055 2, 0
	scrcmd_057 3
	scrcmd_058
	trainer_tips 1, VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_R10_003:
	scrcmd_055 2, 0
	scrcmd_057 3
	scrcmd_058
	trainer_tips 2, VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_R10_004:
	lockall
	goto_if_set FLAG_P1_GOT_HM04, _forceOpen
	npc_msg 3
	closemsg
	apply_movement obj_player, _stepBack
	wait_movement
	releaseall
	end

_forceOpen:
	npc_msg 4
	closemsg
	setvar VAR_P1_POWER_PLANT, 1
	releaseall
	end

	.balign 4
_stepBack:
	step 13, 1
	step_end
