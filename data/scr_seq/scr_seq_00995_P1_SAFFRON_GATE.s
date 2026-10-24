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
// until it gets the Tea (then VAR_P1_SAFFRON 1 and the gates open).  events: data/eventdata/part1/513_P1_R05R0301.json / 514_P1_R06R0201.json, text: data/text/875.txt

.data

scrdef scr_seq_P1_SAFFRON_GATE_001 // guard
scrdef scr_seq_P1_SAFFRON_GATE_002 // road closed (toward Saffron)
scrdef_end

scr_seq_P1_SAFFRON_GATE_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	compare VAR_P1_SAFFRON, 1
	goto_if_ge _guardHi
	npc_msg 1
	goto _guardDone

_guardHi:
	npc_msg 4
_guardDone:
	wait_button
	closemsg
	releaseall
	end

// with the Tea in the bag, the guard drinks it and the Saffron gates open (FireRed)
_giveTea:
	npc_msg 2
	takeitem_no_check ITEM_TEA, 1
	setvar VAR_P1_SAFFRON, 1
	npc_msg 3
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_SAFFRON_GATE_002:
	lockall
	hasitem ITEM_TEA, 1, VAR_SPECIAL_x8004
	compare VAR_SPECIAL_x8004, 1
	goto_if_eq _giveTea
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
