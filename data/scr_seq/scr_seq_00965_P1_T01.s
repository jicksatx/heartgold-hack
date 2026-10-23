.include "asm/include/interop_macros.inc"

.include "asm/include/scriptmacros.inc"
.include "asm/include/flags.inc"
.include "asm/include/soundeffects.inc"
.include "asm/include/vars.inc"

.include "asm/include/maps.inc"
.include "asm/include/std_scripts.inc"
.include "asm/include/trainers.inc"

#include "config.h"

// hack: Pallet Town in Part 1 (FireRed).  events: data/eventdata/part1/491_P1_T01.json, text: data/text/854.txt,
// map script header: scr_seq_00966_P1_T01_hdr.s.  wired up in src/field/chapter_field.c

.data

scrdef scr_seq_P1_T01_001 // girl
scrdef scr_seq_P1_T01_002 // technology man
scrdef scr_seq_P1_T01_003 // town sign
scrdef scr_seq_P1_T01_004 // Red's house sign
scrdef scr_seq_P1_T01_005 // Oak's lab sign
scrdef scr_seq_P1_T01_006 // Blue's house sign
scrdef scr_seq_P1_T01_007 // Oak stops Red at the edge of town
scrdef scr_seq_P1_T01_008 // on transition
scrdef_end

scr_seq_P1_T01_001:
	simple_npc_msg 0
	end

scr_seq_P1_T01_002:
	simple_npc_msg 1
	end

scr_seq_P1_T01_003:
	direction_signpost 2, 0, 1, VAR_SPECIAL_RESULT
	scrcmd_057 3
	scrcmd_058
	scrcmd_060 VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_T01_004:
	buffer_players_name 0
	scrcmd_055 2, 0
	scrcmd_057 3
	scrcmd_058
	trainer_tips 3, VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_T01_005:
	scrcmd_055 2, 0
	scrcmd_057 3
	scrcmd_058
	trainer_tips 4, VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_T01_006:
	scrcmd_055 2, 0
	scrcmd_057 3
	scrcmd_058
	trainer_tips 5, VAR_SPECIAL_RESULT
	callstd std_signpost
	end

// FireRed: heading into Route 1's tall grass without a Pokemon, Oak calls out and takes Red to his lab
scr_seq_P1_T01_007:
	lockall
	play_bgm SEQ_GS_OHKIDO
	npc_msg 6
	closemsg
	apply_movement obj_player, _playerNotice
	wait_movement
	get_player_coords VAR_SPECIAL_x8004, VAR_SPECIAL_x8005
	move_person 2, VAR_SPECIAL_x8004, 358
	clearflag FLAG_P1_HIDE_PALLET_OAK
	show_person 2
	apply_movement 2, _oakWalkUp
	wait_movement
	buffer_players_name 0
	npc_msg 7
	closemsg
	setvar VAR_P1_STORY, 1
	fade_screen 6, 1, 0, 0
	wait_fade
	hide_person 2
	setflag FLAG_P1_HIDE_PALLET_OAK
	warp MAP_T01R0301, 0, 8, 6, DIR_NORTH
	fade_screen 6, 1, 1, 0
	wait_fade
	releaseall
	end

// Oak only appears for the scene above
scr_seq_P1_T01_008:
	setflag FLAG_P1_HIDE_PALLET_OAK
	end

	.balign 4
_playerNotice:
	step 1, 1   // face south
	step 75, 1  // !
	step_end

	.balign 4
_oakWalkUp:
	step 12, 2  // walk north
	step_end
