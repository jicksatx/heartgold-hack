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

// hack: Indigo Plateau and the Pokemon League lobby in Part 1 (FireRed).  The lobby resets the Elite Four on every
// entry (HeartGold's own Elite Four flags, which its lobby resets the same way in Part 2): lose once and you start
// over, as in FireRed.  The guard at the Elite Four door steps aside when you talk to him.
// events: 599 (Indigo Plateau), 600 (lobby), header scr_seq_01045 (lobby), text: data/text/917.txt

.equ OBJ_GUARD, 6

.data

scrdef scr_seq_P1_T10_001 // Indigo Plateau sign
scrdef scr_seq_P1_T10_002 // nurse
scrdef scr_seq_P1_T10_003 // gym guy
scrdef scr_seq_P1_T10_004 // cooltrainer
scrdef scr_seq_P1_T10_005 // mart clerk
scrdef scr_seq_P1_T10_006 // guard at the Elite Four door
scrdef scr_seq_P1_T10_007 // lobby on transition
scrdef_end

scr_seq_P1_T10_001:
	simple_npc_msg 0
	end

scr_seq_P1_T10_002:
	setvar VAR_SPECIAL_x8007, 0
	callstd std_nurse_joy
	end

scr_seq_P1_T10_003:
	simple_npc_msg 1
	end

scr_seq_P1_T10_004:
	simple_npc_msg 2
	end

scr_seq_P1_T10_005:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	callstd std_mart_intro
	holdmsg
	setvar VAR_SPECIAL_x8004, 1
	callstd std_pokemart
	releaseall
	end

scr_seq_P1_T10_006:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	compare VAR_TEMP_x4005, 1
	goto_if_ge _guardMoved
	npc_msg 3
	closemsg
	get_player_facing VAR_TEMP_x4000
	compare VAR_TEMP_x4000, 2
	goto_if_ne _guardEast
	apply_movement OBJ_GUARD, _guardStepWest
	goto _guardWait

_guardEast:
	apply_movement OBJ_GUARD, _guardStepEast
_guardWait:
	wait_movement
	setvar VAR_TEMP_x4005, 1
_guardMoved:
	releaseall
	end

scr_seq_P1_T10_007:
	setflag 523 // FLAG_HIDE_WILLS_ROOM_RETREAT .. KARENS (the doors behind you)
	setflag 524
	setflag 525
	setflag 526
	clearflag 529 // FLAG_HIDE_WILLS_ROOM_EXIT .. KARENS (the doors ahead)
	clearflag 530
	clearflag 531
	clearflag 532
	clearflag 228 // FLAG_DEFEATED_WILL .. KAREN (here: Lorelei, Bruno, Agatha, Lance)
	clearflag 229
	clearflag 230
	clearflag 231
	end

	.balign 4
_guardStepWest:
	step 14, 1
	step 3, 1
	step_end

	.balign 4
_guardStepEast:
	step 15, 1
	step 2, 1
	step_end
