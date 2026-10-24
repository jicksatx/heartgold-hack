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

// hack: the S.S. Anne in Part 1 (FireRed) is HeartGold's S.S. Aqua: FireRed's passengers and sailors in its cabins
// and hold, Blue on the way to the Captain.  shared by the deck and every cabin (events 517-522), text:
// data/text/878.txt, header scr_seq_00999_P1_SSANNE_hdr.s

.equ OBJ_BLUE, 0

.data

scrdef scr_seq_P1_SSANNE_001 // Blue
scrdef scr_seq_P1_SSANNE_002 // on transition
scrdef_end

scr_seq_P1_SSANNE_001:
	lockall
	get_player_coords VAR_SPECIAL_x8004, VAR_SPECIAL_x8005
	move_person OBJ_BLUE, VAR_SPECIAL_x8004, 16
	clearflag FLAG_P1_HIDE_SSANNE_BLUE
	show_person OBJ_BLUE
	apply_movement OBJ_BLUE, _blueEnter
	apply_movement obj_player, _faceSouth
	wait_movement
	buffer_players_name 0
	npc_msg 0
	closemsg
	get_starter_choice VAR_TEMP_x4001
	compare VAR_TEMP_x4001, 152
	goto_if_eq _battleVsGrass
	compare VAR_TEMP_x4001, 155
	goto_if_eq _battleVsFire
	trainer_battle TRAINER_P1_RIVAL_SS_ANNE_BULBASAUR, 0, 0, 0
	goto _afterBattle

_battleVsGrass:
	trainer_battle TRAINER_P1_RIVAL_SS_ANNE_CHARMANDER, 0, 0, 0
	goto _afterBattle

_battleVsFire:
	trainer_battle TRAINER_P1_RIVAL_SS_ANNE_SQUIRTLE, 0, 0, 0
_afterBattle:
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	setvar VAR_P1_SSANNE, 1
	npc_msg 1
	closemsg
	apply_movement OBJ_BLUE, _blueExit
	wait_movement
	hide_person OBJ_BLUE
	setflag FLAG_P1_HIDE_SSANNE_BLUE
	releaseall
	end

_lost:
	white_out
	releaseall
	end

scr_seq_P1_SSANNE_002:
	setflag FLAG_P1_HIDE_SSANNE_BLUE
	end

	.balign 4
_blueEnter:
	step 12, 2  // walk north
	step_end

	.balign 4
_faceSouth:
	step 1, 1
	step_end

	.balign 4
_blueExit:
	step 13, 2
	step 69, 1
	step_end
