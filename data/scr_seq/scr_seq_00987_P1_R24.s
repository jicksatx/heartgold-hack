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

// hack: Route 24 (Nugget Bridge) in Part 1 (FireRed).  events: data/eventdata/part1/507_P1_R24.json, text:
// data/text/869.txt.  five trainers on the bridge, then the Rocket "prize" man (Nugget, then a battle)

.equ OBJ_ROCKET, 0

.data

scrdef scr_seq_P1_R24_001 // Rocket (talk)
scrdef scr_seq_P1_R24_002 // Rocket (bridge end trigger)
scrdef_end

scr_seq_P1_R24_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	compare VAR_P1_ROUTE24, 1
	goto_if_eq _after
	goto _prize

scr_seq_P1_R24_002:
	lockall
	apply_movement OBJ_ROCKET, _notice
	wait_movement
_prize:
	npc_msg 0
	goto_if_no_item_space ITEM_NUGGET, 1, _noRoom
	giveitem_no_check ITEM_NUGGET, 1
	npc_msg 1
	closemsg
	trainer_battle TRAINER_P1_TEAM_ROCKET_GRUNT_6, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	setvar VAR_P1_ROUTE24, 1
_after:
	npc_msg 2
	wait_button
	closemsg
	releaseall
	end

_noRoom:
	npc_msg 3
	closemsg
	apply_movement obj_player, _stepSouth
	wait_movement
	releaseall
	end

_lost:
	white_out
	releaseall
	end

	.balign 4
_notice:
	step 75, 1
	step_end

	.balign 4
_stepSouth:
	step 13, 1
	step_end
