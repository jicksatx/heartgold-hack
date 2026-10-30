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

// hack: the Elite Four, the Champion and the Hall of Fame in Part 1 (FireRed), in HeartGold's League rooms: Lorelei in
// Will's room, Bruno in Koga's, Agatha in Bruno's, Lance in Karen's, Champion Blue in Lance's, Professor Oak in the Hall
// of Fame.  Each room works like HeartGold's (doors shut behind you, the way on opens on a win; the lobby resets them:
// scr_seq_01044).  After the Hall of Fame and the credits, Part 1 is over (src/chapter.c takes Red's team on Continue).
// events: 601-606, headers: scr_seq_01047-01052, text: data/text/918.txt

.equ SCORE_EVENT_LEAGUE_WIN, 23
.equ OBJ_BLUE, 0
.equ OBJ_OAK, 1
.equ OBJ_CHAMP_RETREAT, 3
.equ OBJ_CHAMP_EXIT, 4

.data

scrdef scr_seq_P1_LEAGUE_001 // Lorelei
scrdef scr_seq_P1_LEAGUE_002 // Bruno
scrdef scr_seq_P1_LEAGUE_003 // Agatha
scrdef scr_seq_P1_LEAGUE_004 // Lance
scrdef scr_seq_P1_LEAGUE_005 // Lorelei's room: walking in (frame table)
scrdef scr_seq_P1_LEAGUE_006 // Bruno's room: walking in (frame table)
scrdef scr_seq_P1_LEAGUE_007 // Agatha's room: walking in (frame table)
scrdef scr_seq_P1_LEAGUE_008 // Lance's room: walking in (frame table)
scrdef scr_seq_P1_LEAGUE_009 // Lorelei's room: on load
scrdef scr_seq_P1_LEAGUE_010 // Bruno's room: on load
scrdef scr_seq_P1_LEAGUE_011 // Agatha's room: on load
scrdef scr_seq_P1_LEAGUE_012 // Lance's room: on load
scrdef scr_seq_P1_LEAGUE_013 // Champion: Blue (coord), Oak
scrdef scr_seq_P1_LEAGUE_014 // Champion's room: walking in
scrdef scr_seq_P1_LEAGUE_015 // Champion's room: on transition
scrdef scr_seq_P1_LEAGUE_016 // Hall of Fame (frame table)
scrdef scr_seq_P1_LEAGUE_017 // Hall of Fame: on load
scrdef_end

scr_seq_P1_LEAGUE_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_set 228, _after0
	buffer_players_name 0
	npc_msg 0
	closemsg
	trainer_battle TRAINER_P1_ELITE_FOUR_LORELEI, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	setflag 228 // FLAG_DEFEATED_*
	buffer_players_name 0
	npc_msg 1
	wait_button
	closemsg
	play_se SEQ_SE_DP_KI_GASYAN
	hide_person 2
	hide_person 3
	hide_person 4
	releaseall
	end

_after0:
	buffer_players_name 0
	npc_msg 1
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_LEAGUE_002:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_set 229, _after1
	buffer_players_name 0
	npc_msg 2
	closemsg
	trainer_battle TRAINER_P1_ELITE_FOUR_BRUNO, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	setflag 229 // FLAG_DEFEATED_*
	buffer_players_name 0
	npc_msg 3
	wait_button
	closemsg
	play_se SEQ_SE_DP_KI_GASYAN
	hide_person 2
	hide_person 3
	hide_person 4
	releaseall
	end

_after1:
	buffer_players_name 0
	npc_msg 3
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_LEAGUE_003:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_set 230, _after2
	buffer_players_name 0
	npc_msg 4
	closemsg
	trainer_battle TRAINER_P1_ELITE_FOUR_AGATHA, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	setflag 230 // FLAG_DEFEATED_*
	buffer_players_name 0
	npc_msg 5
	wait_button
	closemsg
	play_se SEQ_SE_DP_KI_GASYAN
	hide_person 2
	hide_person 3
	hide_person 4
	releaseall
	end

_after2:
	buffer_players_name 0
	npc_msg 5
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_LEAGUE_004:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_set 231, _after3
	buffer_players_name 0
	npc_msg 6
	closemsg
	trainer_battle TRAINER_P1_ELITE_FOUR_LANCE, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	setflag 231 // FLAG_DEFEATED_*
	buffer_players_name 0
	npc_msg 7
	wait_button
	closemsg
	play_se SEQ_SE_DP_KI_GASYAN
	hide_person 2
	hide_person 3
	hide_person 4
	releaseall
	end

_after3:
	buffer_players_name 0
	npc_msg 7
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_LEAGUE_005:
	lockall
	apply_movement obj_player, _walkIn
	wait_movement
	play_se SEQ_SE_DP_KI_GASYAN
	clearflag 523 // the door behind you shuts
	show_person 1
	setvar VAR_TEMP_x4001, 1
	releaseall
	end

scr_seq_P1_LEAGUE_006:
	lockall
	apply_movement obj_player, _walkIn
	wait_movement
	play_se SEQ_SE_DP_KI_GASYAN
	clearflag 524 // the door behind you shuts
	show_person 1
	setvar VAR_TEMP_x4001, 1
	releaseall
	end

scr_seq_P1_LEAGUE_007:
	lockall
	apply_movement obj_player, _walkIn
	wait_movement
	play_se SEQ_SE_DP_KI_GASYAN
	clearflag 525 // the door behind you shuts
	show_person 1
	setvar VAR_TEMP_x4001, 1
	releaseall
	end

scr_seq_P1_LEAGUE_008:
	lockall
	apply_movement obj_player, _walkIn
	wait_movement
	play_se SEQ_SE_DP_KI_GASYAN
	clearflag 526 // the door behind you shuts
	show_person 1
	setvar VAR_TEMP_x4001, 1
	releaseall
	end

scr_seq_P1_LEAGUE_009:
	goto_if_set 228, _onLoadDone
	make_object_visible 3
	make_object_visible 4
	end

scr_seq_P1_LEAGUE_010:
	goto_if_set 229, _onLoadDone
	make_object_visible 3
	make_object_visible 4
	end

scr_seq_P1_LEAGUE_011:
	goto_if_set 230, _onLoadDone
	make_object_visible 3
	make_object_visible 4
	end

scr_seq_P1_LEAGUE_012:
	goto_if_set 231, _onLoadDone
	make_object_visible 3
	make_object_visible 4
	end

_onLoadDone:
	end

_lost:
	white_out
	releaseall
	end

scr_seq_P1_LEAGUE_013:
	lockall
	apply_movement obj_player, _walkNorth2
	wait_movement
	buffer_players_name 0
	npc_msg 8
	closemsg
	get_starter_choice VAR_TEMP_x4002
	compare VAR_TEMP_x4002, 152
	goto_if_eq _champVsGrass
	compare VAR_TEMP_x4002, 155
	goto_if_eq _champVsFire
	trainer_battle TRAINER_P1_CHAMPION_FIRST_BULBASAUR, 0, 0, 0
	goto _champAfter

_champVsGrass:
	trainer_battle TRAINER_P1_CHAMPION_FIRST_CHARMANDER, 0, 0, 0
	goto _champAfter

_champVsFire:
	trainer_battle TRAINER_P1_CHAMPION_FIRST_SQUIRTLE, 0, 0, 0
_champAfter:
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	npc_msg 9
	closemsg
	wait 10, VAR_SPECIAL_x8004
	play_se SEQ_SE_DP_KI_GASYAN
	hide_person OBJ_CHAMP_EXIT
	stop_bgm 0
	temp_bgm SEQ_GS_OHKIDO
	buffer_players_name 0
	npc_msg 10
	closemsg
	move_person_facing OBJ_OAK, 6, 0, 17, DIR_NORTH
	apply_movement OBJ_OAK, _oakEnter
	apply_movement obj_player, _faceSouth
	wait_movement
	buffer_players_name 0
	npc_msg 11
	closemsg
	apply_movement OBJ_BLUE, _faceSouth
	wait_movement
	npc_msg 12
	closemsg
	buffer_players_name 0
	npc_msg 13
	closemsg
	setvar VAR_TEMP_x4001, 1
	fade_screen 6, 1, 0, RGB_BLACK
	wait_fade
	warp MAP_T10R0701, 0, 6, 22, DIR_NORTH
	fade_screen 6, 1, 1, RGB_BLACK
	wait_fade
	releaseall
	end

scr_seq_P1_LEAGUE_014:
	lockall
	apply_movement obj_player, _walkIn
	wait_movement
	play_se SEQ_SE_DP_KI_GASYAN
	clearflag 528 // FLAG_UNK_210: the door behind you
	show_person OBJ_CHAMP_RETREAT
	setvar VAR_TEMP_x4001, 1
	releaseall
	end

scr_seq_P1_LEAGUE_015:
	setflag 528
	end

scr_seq_P1_LEAGUE_016:
	lockall
	apply_movement obj_player, _hofPlayerWalk
	apply_movement 0, _hofOakWalk
	wait_movement
	buffer_players_name 0
	npc_msg 14
	closemsg
	apply_movement obj_player, _hofPlayerToMachine
	wait_movement
	setvar VAR_TEMP_x4001, 1
	party_count_not_egg VAR_SPECIAL_RESULT
	hall_of_fame_anim VAR_SPECIAL_RESULT
	add_special_game_stat SCORE_EVENT_LEAGUE_WIN
	fade_screen 6, 1, 0, RGB_BLACK
	wait_fade
	hof_credits 0
	restore_overworld
	fade_screen 6, 1, 1, RGB_BLACK
	wait_fade
	releaseall
	end

scr_seq_P1_LEAGUE_017:
	stop_bgm 0
	end

	.balign 4
_walkIn:
	step 12, 6  // walk north
	step_end

	.balign 4
_walkNorth2:
	step 12, 2
	step_end

	.balign 4
_faceSouth:
	step 1, 1
	step_end

	.balign 4
_oakEnter:
	step 12, 7  // up to the player
	step_end

	.balign 4
_hofPlayerWalk:
	step 12, 14
	step 3, 1   // face east
	step_end

	.balign 4
_hofOakWalk:
	step 12, 12
	step 15, 1  // walk east
	step 2, 1   // face west
	step_end

	.balign 4
_hofPlayerToMachine:
	step 0, 1   // face north
	step 12, 4
	step_end
