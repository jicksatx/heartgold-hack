.include "asm/include/interop_macros.inc"

.include "asm/include/scriptmacros.inc"
.include "asm/include/flags.inc"
.include "asm/include/soundeffects.inc"
.include "asm/include/vars.inc"

.include "asm/include/maps.inc"
.include "asm/include/std_scripts.inc"
.include "asm/include/trainers.inc"

#include "config.h"

// hack: Professor Oak's Lab in Part 1 (FireRed).  events: data/eventdata/part1/492_P1_T01R0301.json, text:
// data/text/855.txt, map script header: scr_seq_00968_P1_T01R0301_hdr.s.  wired up in src/field/chapter_field.c
//
// objects: 0 Oak, 1 Blue, 2-4 the Poke Balls (grass, fire, water - the order the starter screen shows them), 5-6 aides
// VAR_P1_STORY: 1 just arrived with Oak, 2 choosing, 3 got a starter, 4 battled Blue

.equ OBJ_OAK, 0
.equ OBJ_BLUE, 1
.equ OBJ_BALL_GRASS, 2
.equ OBJ_BALL_FIRE, 3
.equ OBJ_BALL_WATER, 4

.data

scrdef scr_seq_P1_T01R0301_001 // arrival scene (frame table)
scrdef scr_seq_P1_T01R0301_002 // Poke Ball
scrdef scr_seq_P1_T01R0301_003 // Poke Ball
scrdef scr_seq_P1_T01R0301_004 // Poke Ball
scrdef scr_seq_P1_T01R0301_005 // Oak
scrdef scr_seq_P1_T01R0301_006 // Blue
scrdef scr_seq_P1_T01R0301_007 // aides
scrdef scr_seq_P1_T01R0301_008 // trying to leave before choosing
scrdef scr_seq_P1_T01R0301_009 // Blue's challenge
scrdef scr_seq_P1_T01R0301_010 // on transition
scrdef_end

scr_seq_P1_T01R0301_001:
	lockall
	buffer_players_name 0
	npc_msg 0
	npc_msg 1
	npc_msg 2
	npc_msg 3
	closemsg
	setvar VAR_P1_STORY, 2
	releaseall
	end

scr_seq_P1_T01R0301_002:
scr_seq_P1_T01R0301_003:
scr_seq_P1_T01R0301_004:
	play_se SEQ_SE_DP_SELECT
	lockall
	compare VAR_P1_STORY, 2
	goto_if_ne _lastPokemon
	buffer_players_name 0
	npc_msg 4
	closemsg
	choose_starter
	scrcmd_605 3, 2
	toggle_following_pokemon_movement 0
	scrcmd_608
	wait 10, VAR_SPECIAL_RESULT
	toggle_following_pokemon_movement 1
	get_partymon_species 0, VAR_TEMP_x4001
	set_starter_choice VAR_TEMP_x4001
	buffer_players_name 0
	buffer_mon_species_name 1, 0
	npc_msg 5
	play_fanfare SEQ_ME_POKEGET
	wait_fanfare
	closemsg
	setvar VAR_P1_STORY, 3
	// Blue takes the starter that is strong against Red's (FireRed).  the starter screen gives the party one;
	// get_starter_choice reports its type as 152 grass / 155 fire / 158 water (src/field/chapter_field.c)
	get_starter_choice VAR_TEMP_x4001
	compare VAR_TEMP_x4001, 152
	goto_if_eq _choseGrass
	compare VAR_TEMP_x4001, 155
	goto_if_eq _choseFire
	// water: Blue takes grass
	setflag FLAG_P1_LAB_BALL_WATER
	hide_person OBJ_BALL_WATER
	npc_msg 6
	setflag FLAG_P1_LAB_BALL_GRASS
	hide_person OBJ_BALL_GRASS
	npc_msg 9
	goto _blueTook

_choseGrass:
	setflag FLAG_P1_LAB_BALL_GRASS
	hide_person OBJ_BALL_GRASS
	npc_msg 6
	setflag FLAG_P1_LAB_BALL_FIRE
	hide_person OBJ_BALL_FIRE
	npc_msg 7
	goto _blueTook

_choseFire:
	setflag FLAG_P1_LAB_BALL_FIRE
	hide_person OBJ_BALL_FIRE
	npc_msg 6
	setflag FLAG_P1_LAB_BALL_WATER
	hide_person OBJ_BALL_WATER
	npc_msg 8
_blueTook:
	play_fanfare SEQ_ME_POKEGET
	wait_fanfare
	closemsg
	releaseall
	end

_lastPokemon:
	npc_msg 17
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_T01R0301_005:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	buffer_players_name 0
	compare VAR_P1_STORY, 2
	goto_if_gt _oakAfter
	npc_msg 19
	goto _talkDone

_oakAfter:
	npc_msg 13
	goto _talkDone

scr_seq_P1_T01R0301_006:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	buffer_players_name 0
	compare VAR_P1_STORY, 2
	goto_if_lt _blueWaiting
	goto_if_eq _blueChoosing
	npc_msg 12
	goto _talkDone

_blueWaiting:
	npc_msg 10
	goto _talkDone

_blueChoosing:
	npc_msg 11
	goto _talkDone

scr_seq_P1_T01R0301_007:
	simple_npc_msg 18
	end

_talkDone:
	wait_button
	closemsg
	releaseall
	end

// FireRed: Oak won't let Red leave before choosing
scr_seq_P1_T01R0301_008:
	lockall
	npc_msg 14
	closemsg
	apply_movement obj_player, _stepBack
	wait_movement
	releaseall
	end

// FireRed: Blue challenges Red on his way out (a battle he's allowed to lose)
scr_seq_P1_T01R0301_009:
	lockall
	apply_movement OBJ_BLUE, _blueNotice
	wait_movement
	buffer_players_name 0
	npc_msg 15
	closemsg
	get_starter_choice VAR_TEMP_x4001
	compare VAR_TEMP_x4001, 152
	goto_if_eq _battleVsGrass
	compare VAR_TEMP_x4001, 155
	goto_if_eq _battleVsFire
	trainer_battle TRAINER_P1_BLUE_LAB_VS_WATER, 0, 1, 0
	goto _afterBattle

_battleVsGrass:
	trainer_battle TRAINER_P1_BLUE_LAB_VS_GRASS, 0, 1, 0
	goto _afterBattle

_battleVsFire:
	trainer_battle TRAINER_P1_BLUE_LAB_VS_FIRE, 0, 1, 0
_afterBattle:
	heal_party
	buffer_players_name 0
	npc_msg 16
	closemsg
	fade_screen 6, 1, 0, 0
	wait_fade
	setflag FLAG_P1_HIDE_LAB_BLUE
	hide_person OBJ_BLUE
	setvar VAR_P1_STORY, 4
	fade_screen 6, 1, 1, 0
	wait_fade
	releaseall
	end

// Oak is only in his lab once he has brought Red there
scr_seq_P1_T01R0301_010:
	compare VAR_P1_STORY, 0
	goto_if_ne _oakIsIn
	setflag FLAG_P1_HIDE_LAB_OAK
	end

_oakIsIn:
	clearflag FLAG_P1_HIDE_LAB_OAK
	end

	.balign 4
_stepBack:
	step 12, 1  // walk north
	step_end

	.balign 4
_blueNotice:
	step 75, 1  // !
	step_end
