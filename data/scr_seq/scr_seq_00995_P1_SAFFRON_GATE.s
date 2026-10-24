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

// hack: the Saffron gatehouses of Routes 5 and 6 in Part 1 (FireRed): the thirsty guard won't let Red into Saffron
// yet.  events: data/eventdata/part1/513_P1_R05R0301.json / 514_P1_R06R0201.json, text: data/text/875.txt

.data

scrdef scr_seq_P1_SAFFRON_GATE_001 // guard
scrdef scr_seq_P1_SAFFRON_GATE_002 // road closed (toward Saffron)
scrdef_end

scr_seq_P1_SAFFRON_GATE_001:
	simple_npc_msg 1
	end

scr_seq_P1_SAFFRON_GATE_002:
	lockall
	get_player_facing VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _turnBackSouth
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _turnBackNorth
	releaseall
	end

_turnBackSouth:
	npc_msg 0
	closemsg
	apply_movement obj_player, _stepSouth
	wait_movement
	releaseall
	end

_turnBackNorth:
	npc_msg 0
	closemsg
	apply_movement obj_player, _stepNorth
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
