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

// hack: Route 22 in Part 1 (FireRed).  events: data/eventdata/part1/497_P1_R22.json, text: data/text/860.txt,
// header scr_seq_00976_P1_R22_hdr.s.  Blue's first Route 22 battle (after the Pokedex, a battle Red may lose): the trigger column is x 948, just
// east of the League gate, past the route's grass, and Blue walks in from the gate side, as in FireRed.
// Blue's second battle once Red has the Earth Badge (VAR_P1_ROUTE22 3 -> 4).

.equ OBJ_BLUE, 0

.data

scrdef scr_seq_P1_R22_001 // Blue's challenge
scrdef scr_seq_P1_R22_002 // League gate
scrdef scr_seq_P1_R22_003 // route sign
scrdef scr_seq_P1_R22_004 // on transition
scrdef scr_seq_P1_R22_005 // Blue's second Route 22 battle (after the Earth Badge, VAR_P1_ROUTE22 3)
scrdef_end

scr_seq_P1_R22_001:
	lockall
	get_player_coords VAR_SPECIAL_x8004, VAR_SPECIAL_x8005
	move_person OBJ_BLUE, 939, VAR_SPECIAL_x8005
	clearflag FLAG_P1_HIDE_ROUTE22_BLUE
	callstd 2031 // rival intro music
	show_person OBJ_BLUE
	apply_movement OBJ_BLUE, _blueApproach
	apply_movement obj_player, _faceWest
	wait_movement
	buffer_players_name 0
	npc_msg 0
	closemsg
	get_starter_choice VAR_TEMP_x4001
	compare VAR_TEMP_x4001, 152
	goto_if_eq _battleVsGrass
	compare VAR_TEMP_x4001, 155
	goto_if_eq _battleVsFire
	trainer_battle TRAINER_P1_BLUE_ROUTE22_VS_WATER, 0, 1, 0
	goto _afterBattle

_battleVsGrass:
	trainer_battle TRAINER_P1_BLUE_ROUTE22_VS_GRASS, 0, 1, 0
	goto _afterBattle

_battleVsFire:
	trainer_battle TRAINER_P1_BLUE_ROUTE22_VS_FIRE, 0, 1, 0
_afterBattle:
	callstd 2070 // rival outro music
	heal_party
	npc_msg 1
	closemsg
	apply_movement OBJ_BLUE, _blueLeave
	wait_movement
	hide_person OBJ_BLUE
	callstd 2071 // back to the map music
	setflag FLAG_P1_HIDE_ROUTE22_BLUE
	setvar VAR_P1_ROUTE22, 2
	releaseall
	end

scr_seq_P1_R22_005:
	lockall
	get_player_coords VAR_SPECIAL_x8004, VAR_SPECIAL_x8005
	move_person OBJ_BLUE, 939, VAR_SPECIAL_x8005
	clearflag FLAG_P1_HIDE_ROUTE22_BLUE
	callstd 2031 // rival intro music
	show_person OBJ_BLUE
	apply_movement OBJ_BLUE, _blueApproach
	apply_movement obj_player, _faceWest
	wait_movement
	buffer_players_name 0
	npc_msg 4
	closemsg
	get_starter_choice VAR_TEMP_x4001
	compare VAR_TEMP_x4001, 152
	goto_if_eq _lateVsGrass
	compare VAR_TEMP_x4001, 155
	goto_if_eq _lateVsFire
	trainer_battle TRAINER_P1_RIVAL_ROUTE22_LATE_BULBASAUR, 0, 0, 0
	goto _lateAfter

_lateVsGrass:
	trainer_battle TRAINER_P1_RIVAL_ROUTE22_LATE_CHARMANDER, 0, 0, 0
	goto _lateAfter

_lateVsFire:
	trainer_battle TRAINER_P1_RIVAL_ROUTE22_LATE_SQUIRTLE, 0, 0, 0
_lateAfter:
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lateLost
	callstd 2070 // rival outro music
	buffer_players_name 0
	npc_msg 5
	closemsg
	apply_movement OBJ_BLUE, _blueLeave
	wait_movement
	hide_person OBJ_BLUE
	callstd 2071 // back to the map music
	setflag FLAG_P1_HIDE_ROUTE22_BLUE
	setvar VAR_P1_ROUTE22, 4
	releaseall
	end

_lateLost:
	white_out
	releaseall
	end

scr_seq_P1_R22_002:
	scrcmd_055 2, 0
	scrcmd_057 3
	scrcmd_058
	trainer_tips 2, VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_R22_003:
	direction_signpost 3, 0, 1, VAR_SPECIAL_RESULT
	scrcmd_057 3
	scrcmd_058
	scrcmd_060 VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_R22_004:
	setflag FLAG_P1_HIDE_ROUTE22_BLUE
	end

	.balign 4
_blueApproach:
	step 15, 8  // walk east from the League gate side (FireRed: Blue comes from Route 23's direction)
	step_end

	.balign 4
_faceWest:
	step 2, 1
	step_end

	.balign 4
_blueLeave:
	step 14, 8  // walk west, back toward the League gate
	step_end
