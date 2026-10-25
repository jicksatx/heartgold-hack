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

// hack: the Pokemon League reception gate in Part 1 (FireRed).  It stands in for Route 23's badge checks: the way
// north to Victory Road needs all eight Badges.  Its doors to Routes 26 and 28 (Johto) are parked and turn Red back.
// events: 598, text: data/text/916.txt

.data

scrdef scr_seq_P1_R22R0101_001 // badge check (coord across the north corridor)
scrdef scr_seq_P1_R22R0101_002 // Johto doors (coords in front)
scrdef scr_seq_P1_R22R0101_003 // guards
scrdef scr_seq_P1_R22R0101_004 // guard by the south door
scrdef_end

scr_seq_P1_R22R0101_001:
	lockall
	count_badges VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 8
	goto_if_ge _pass
	npc_msg 0
	closemsg
	apply_movement obj_player, _stepSouth
	wait_movement
_pass:
	releaseall
	end

scr_seq_P1_R22R0101_002:
	lockall
	get_player_facing VAR_SPECIAL_RESULT
	npc_msg 2
	closemsg
	compare VAR_SPECIAL_RESULT, 2
	goto_if_eq _backEast
	apply_movement obj_player, _stepNorth
	goto _stopDone

_backEast:
	apply_movement obj_player, _stepEast
_stopDone:
	wait_movement
	releaseall
	end

scr_seq_P1_R22R0101_003:
	simple_npc_msg 1
	end

scr_seq_P1_R22R0101_004:
	simple_npc_msg 3
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
