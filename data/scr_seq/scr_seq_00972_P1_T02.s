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

// hack: Viridian City in Part 1 (FireRed).  events: data/eventdata/part1/495_P1_T02.json, text: data/text/857.txt.
// wired up in src/field/chapter_field.c.  the road north is closed until Red has the Pokedex (the old man hasn't
// had his coffee), and the Gym is locked (no warp on its door in Part 1 yet).

.data

scrdef scr_seq_P1_T02_001 // old man (catching lesson)
scrdef scr_seq_P1_T02_002 // his granddaughter
scrdef scr_seq_P1_T02_003 // youngster (caterpillar Pokemon)
scrdef scr_seq_P1_T02_004 // old man by the Gym
scrdef scr_seq_P1_T02_005 // boy
scrdef scr_seq_P1_T02_006 // city sign
scrdef scr_seq_P1_T02_007 // trainer tips
scrdef scr_seq_P1_T02_008 // Gym sign
scrdef scr_seq_P1_T02_009 // Trainer House sign
scrdef scr_seq_P1_T02_010 // Gym door
scrdef scr_seq_P1_T02_011 // road north blocked
scrdef scr_seq_P1_T02_012 // test build: end of what's built so far
scrdef_end

scr_seq_P1_T02_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	compare VAR_P1_STORY, 6
	goto_if_ge _oldManCoffee
	npc_msg 1
	goto _talkDone

_oldManCoffee:
	npc_msg 2
	goto _talkDone

scr_seq_P1_T02_002:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	compare VAR_P1_STORY, 6
	goto_if_ge _granddaughterLater
	npc_msg 3
	goto _talkDone

_granddaughterLater:
	npc_msg 4
	goto _talkDone

scr_seq_P1_T02_003:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	npc_msg 5
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _caterpillarNo
	npc_msg 6
	goto _talkDone

_caterpillarNo:
	npc_msg 7
	goto _talkDone

scr_seq_P1_T02_004:
	simple_npc_msg 8
	end

scr_seq_P1_T02_005:
	simple_npc_msg 9
	end

scr_seq_P1_T02_006:
	direction_signpost 10, 0, 2, VAR_SPECIAL_RESULT
	scrcmd_057 3
	scrcmd_058
	scrcmd_060 VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_T02_007:
	scrcmd_055 2, 0
	scrcmd_057 3
	scrcmd_058
	trainer_tips 11, VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_T02_008:
	scrcmd_055 2, 0
	scrcmd_057 3
	scrcmd_058
	trainer_tips 12, VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_T02_009:
	scrcmd_055 2, 0
	scrcmd_057 3
	scrcmd_058
	trainer_tips 13, VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_T02_010:
	simple_npc_msg 14
	end

scr_seq_P1_T02_011:
	lockall
	npc_msg 0
	closemsg
	apply_movement obj_player, _stepBack
	wait_movement
	releaseall
	end

scr_seq_P1_T02_012:
	lockall
	npc_msg 15
	closemsg
	apply_movement obj_player, _stepBack
	wait_movement
	releaseall
	end

_talkDone:
	wait_button
	closemsg
	releaseall
	end

	.balign 4
_stepBack:
	step 13, 1  // walk south
	step_end
