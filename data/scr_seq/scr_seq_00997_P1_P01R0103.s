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

// hack: Vermilion's harbor building in Part 1 (FireRed): the sailor checks for the S.S. Ticket, and once Red has
// HM01 the S.S. Anne has sailed.  events: data/eventdata/part1/516_P1_P01R0103.json, text: data/text/877.txt

.data

scrdef scr_seq_P1_P01R0103_001 // sailor
scrdef scr_seq_P1_P01R0103_002 // ticket gate
scrdef_end

scr_seq_P1_P01R0103_001:
	simple_npc_msg 0
	end

scr_seq_P1_P01R0103_002:
	lockall
	get_player_facing VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 1
	goto_if_ne _leaving
	compare VAR_P1_SSANNE, 2
	goto_if_eq _sailed
	npc_msg 1
	hasitem ITEM_SS_TICKET, 1, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _noTicket
	npc_msg 2
	closemsg
	releaseall
	end

_noTicket:
	npc_msg 3
	closemsg
	apply_movement obj_player, _stepNorth
	wait_movement
	releaseall
	end

_sailed:
	npc_msg 4
	closemsg
	apply_movement obj_player, _stepNorth
	wait_movement
_leaving:
	releaseall
	end

	.balign 4
_stepNorth:
	step 12, 1
	step_end
