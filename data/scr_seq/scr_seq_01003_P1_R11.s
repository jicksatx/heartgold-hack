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

// hack: Route 11 in Part 1 (FireRed): FireRed trainers, no Snorlax at Diglett's Cave.  events:
// data/eventdata/part1/525_P1_R11.json (and Diglett's Cave 526 uses this file), text: data/text/881.txt

.data

scrdef scr_seq_P1_R11_001 // Diglett's Cave sign
scrdef scr_seq_P1_R11_002 // test build stop
scrdef_end

scr_seq_P1_R11_001:
	scrcmd_055 2, 0
	scrcmd_057 3
	scrcmd_058
	trainer_tips 0, VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_R11_002:
	lockall
	get_player_facing VAR_SPECIAL_RESULT
	npc_msg 1
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
