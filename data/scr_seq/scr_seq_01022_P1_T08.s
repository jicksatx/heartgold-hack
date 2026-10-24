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

// hack: Fuchsia City in Part 1 (FireRed): FireRed's signs and townspeople.  The Safari Zone (next build), the Route 19
// gate and Route 18 are closed for now.  events: 554_P1_T08.json, text: data/text/898.txt

.data

scrdef scr_seq_P1_T08_001 // city sign
scrdef scr_seq_P1_T08_002 // Safari Zone sign
scrdef scr_seq_P1_T08_003 // Warden's home sign
scrdef scr_seq_P1_T08_004 // Gym sign
scrdef scr_seq_P1_T08_005 // woman
scrdef scr_seq_P1_T08_006 // man
scrdef scr_seq_P1_T08_007 // Erik
scrdef scr_seq_P1_T08_008 // man by the zoo
scrdef scr_seq_P1_T08_009 // Safari Zone door (test build)
scrdef scr_seq_P1_T08_010 // test build stop
scrdef_end

scr_seq_P1_T08_001:
	simple_npc_msg 0
	end

scr_seq_P1_T08_002:
	simple_npc_msg 1
	end

scr_seq_P1_T08_003:
	simple_npc_msg 2
	end

scr_seq_P1_T08_004:
	simple_npc_msg 3
	end

scr_seq_P1_T08_005:
	simple_npc_msg 4
	end

scr_seq_P1_T08_006:
	simple_npc_msg 5
	end

scr_seq_P1_T08_007:
	simple_npc_msg 6
	end

scr_seq_P1_T08_008:
	simple_npc_msg 7
	end

scr_seq_P1_T08_009:
	simple_npc_msg 8
	end

scr_seq_P1_T08_010:
	lockall
	get_player_facing VAR_SPECIAL_RESULT
	npc_msg 9
	closemsg
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _backNorth
	apply_movement obj_player, _stepEast
	goto _stopDone

_backNorth:
	apply_movement obj_player, _stepNorth
_stopDone:
	wait_movement
	releaseall
	end

	.balign 4
_stepNorth:
	step 12, 1
	step_end

	.balign 4
_stepEast:
	step 15, 1
	step_end
