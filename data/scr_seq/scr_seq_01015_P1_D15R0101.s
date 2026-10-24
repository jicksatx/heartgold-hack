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

// hack: Pokemon Tower in Part 1 (FireRed) is HeartGold's Sprout Tower (1F-3F), entered by Lavender's Radio Tower
// door.  1F: Blue; the Channelers of FireRed's 3F-6F on the way up (and 5F's purified zone, on 2F); 3F: Cubone's
// mother's ghost (calmed with the Silph Scope), the Rockets and Mr. Fuji.  shared by events 544-546, text: 893.txt,
// header scr_seq_01016_P1_D15R0101_hdr.s

.equ OBJ_BLUE, 0

.data

scrdef scr_seq_P1_D15R0101_001 // Blue (only seen in the scene)
scrdef scr_seq_P1_D15R0101_002 // old woman
scrdef scr_seq_P1_D15R0101_003 // woman (Clefairy)
scrdef scr_seq_P1_D15R0101_004 // man (Growlithe)
scrdef scr_seq_P1_D15R0101_005 // Channeler
scrdef scr_seq_P1_D15R0101_006 // Blue's scene (1F)
scrdef scr_seq_P1_D15R0101_007 // purified zone Channeler (2F)
scrdef scr_seq_P1_D15R0101_008 // purified zone (2F)
scrdef scr_seq_P1_D15R0101_009 // Mr. Fuji (3F)
scrdef scr_seq_P1_D15R0101_010 // the ghost (3F)
scrdef scr_seq_P1_D15R0101_011 // on transition
scrdef_end

scr_seq_P1_D15R0101_001:
	end

scr_seq_P1_D15R0101_002:
	simple_npc_msg 2
	end

scr_seq_P1_D15R0101_003:
	simple_npc_msg 3
	end

scr_seq_P1_D15R0101_004:
	simple_npc_msg 4
	end

scr_seq_P1_D15R0101_005:
	simple_npc_msg 5
	end

scr_seq_P1_D15R0101_006:
	lockall
	get_player_coords VAR_SPECIAL_x8004, VAR_SPECIAL_x8005
	move_person OBJ_BLUE, VAR_SPECIAL_x8004, 20
	clearflag FLAG_P1_HIDE_TOWER_BLUE
	show_person OBJ_BLUE
	apply_movement OBJ_BLUE, _blueEnter
	wait_movement
	buffer_players_name 0
	npc_msg 0
	closemsg
	get_starter_choice VAR_TEMP_x4001
	compare VAR_TEMP_x4001, 152
	goto_if_eq _battleVsGrass
	compare VAR_TEMP_x4001, 155
	goto_if_eq _battleVsFire
	trainer_battle TRAINER_P1_RIVAL_POKEMON_TOWER_BULBASAUR, 0, 0, 0
	goto _afterBattle

_battleVsGrass:
	trainer_battle TRAINER_P1_RIVAL_POKEMON_TOWER_CHARMANDER, 0, 0, 0
	goto _afterBattle

_battleVsFire:
	trainer_battle TRAINER_P1_RIVAL_POKEMON_TOWER_SQUIRTLE, 0, 0, 0
_afterBattle:
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	setvar VAR_P1_TOWER, 1
	npc_msg 1
	closemsg
	apply_movement OBJ_BLUE, _blueExit
	wait_movement
	hide_person OBJ_BLUE
	setflag FLAG_P1_HIDE_TOWER_BLUE
	releaseall
	end

_lost:
	white_out
	releaseall
	end

scr_seq_P1_D15R0101_007:
	simple_npc_msg 6
	end

scr_seq_P1_D15R0101_008:
	lockall
	heal_party
	buffer_players_name 0
	npc_msg 7
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_D15R0101_009:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	npc_msg 12
	closemsg
	setvar VAR_P1_TOWER, 3
	fade_screen 6, 1, 0, 0
	wait_fade
	hide_person 0
	setflag FLAG_P1_HIDE_TOWER_FUJI
	clearflag FLAG_P1_HIDE_HOUSE_FUJI
	warp MAP_T05R0201, 0, 9, 5, DIR_NORTH
	fade_screen 6, 1, 1, 0
	wait_fade
	releaseall
	end

scr_seq_P1_D15R0101_010:
	lockall
	hasitem ITEM_SILPH_SCOPE, 1, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _noScope
	npc_msg 14
	npc_msg 10
	npc_msg 11
	closemsg
	setvar VAR_P1_TOWER, 2
	releaseall
	end

_noScope:
	npc_msg 8
	npc_msg 9
	closemsg
	apply_movement obj_player, _pushBack
	wait_movement
	releaseall
	end

scr_seq_P1_D15R0101_011:
	setflag FLAG_P1_HIDE_TOWER_BLUE
	end

	.balign 4
_blueEnter:
	step 13, 1  // walk south
	step_end

	.balign 4
_blueExit:
	step 12, 2
	step 69, 1
	step_end

	.balign 4
_pushBack:
	step 13, 1
	step_end
