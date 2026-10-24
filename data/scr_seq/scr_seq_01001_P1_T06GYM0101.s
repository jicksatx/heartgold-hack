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
.include "asm/include/game_stats.inc"

// hack: Vermilion Gym in Part 1 (FireRed): HeartGold's trash-can switch puzzle (the same game logic as FireRed's),
// FireRed's three trainers and Lt. Surge.  events: data/eventdata/part1/524_P1_T06GYM0101.json, text:
// data/text/880.txt, header scr_seq_01002_P1_T06GYM0101_hdr.s

.equ FLAG_HIDE_VERMILION_GYM_STOPS, 794
.equ OBJ_STOP_1, 0

.data

scrdef scr_seq_P1_T06GYM0101_001 // trash cans 0-14
scrdef scr_seq_P1_T06GYM0101_002
scrdef scr_seq_P1_T06GYM0101_003
scrdef scr_seq_P1_T06GYM0101_004
scrdef scr_seq_P1_T06GYM0101_005
scrdef scr_seq_P1_T06GYM0101_006
scrdef scr_seq_P1_T06GYM0101_007
scrdef scr_seq_P1_T06GYM0101_008
scrdef scr_seq_P1_T06GYM0101_009
scrdef scr_seq_P1_T06GYM0101_010
scrdef scr_seq_P1_T06GYM0101_011
scrdef scr_seq_P1_T06GYM0101_012
scrdef scr_seq_P1_T06GYM0101_013
scrdef scr_seq_P1_T06GYM0101_014
scrdef scr_seq_P1_T06GYM0101_015
scrdef scr_seq_P1_T06GYM0101_016 // Lt. Surge
scrdef scr_seq_P1_T06GYM0101_017 // Gym guide
scrdef scr_seq_P1_T06GYM0101_018 // statues
scrdef scr_seq_P1_T06GYM0101_019 // on transition
scrdef scr_seq_P1_T06GYM0101_020 // on resume
scrdef_end

scr_seq_P1_T06GYM0101_001:
	vermilion_gym_can_check 0, VAR_SPECIAL_RESULT
	goto _canResult

scr_seq_P1_T06GYM0101_002:
	vermilion_gym_can_check 1, VAR_SPECIAL_RESULT
	goto _canResult

scr_seq_P1_T06GYM0101_003:
	vermilion_gym_can_check 2, VAR_SPECIAL_RESULT
	goto _canResult

scr_seq_P1_T06GYM0101_004:
	vermilion_gym_can_check 3, VAR_SPECIAL_RESULT
	goto _canResult

scr_seq_P1_T06GYM0101_005:
	vermilion_gym_can_check 4, VAR_SPECIAL_RESULT
	goto _canResult

scr_seq_P1_T06GYM0101_006:
	vermilion_gym_can_check 5, VAR_SPECIAL_RESULT
	goto _canResult

scr_seq_P1_T06GYM0101_007:
	vermilion_gym_can_check 6, VAR_SPECIAL_RESULT
	goto _canResult

scr_seq_P1_T06GYM0101_008:
	vermilion_gym_can_check 7, VAR_SPECIAL_RESULT
	goto _canResult

scr_seq_P1_T06GYM0101_009:
	vermilion_gym_can_check 8, VAR_SPECIAL_RESULT
	goto _canResult

scr_seq_P1_T06GYM0101_010:
	vermilion_gym_can_check 9, VAR_SPECIAL_RESULT
	goto _canResult

scr_seq_P1_T06GYM0101_011:
	vermilion_gym_can_check 10, VAR_SPECIAL_RESULT
	goto _canResult

scr_seq_P1_T06GYM0101_012:
	vermilion_gym_can_check 11, VAR_SPECIAL_RESULT
	goto _canResult

scr_seq_P1_T06GYM0101_013:
	vermilion_gym_can_check 12, VAR_SPECIAL_RESULT
	goto _canResult

scr_seq_P1_T06GYM0101_014:
	vermilion_gym_can_check 13, VAR_SPECIAL_RESULT
	goto _canResult

scr_seq_P1_T06GYM0101_015:
	vermilion_gym_can_check 14, VAR_SPECIAL_RESULT
	goto _canResult

_canResult:
	play_se SEQ_SE_DP_SELECT
	lockall
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _firstSwitch
	compare VAR_SPECIAL_RESULT, 2
	goto_if_eq _secondSwitch
	compare VAR_SPECIAL_RESULT, 3
	goto_if_eq _reset
	npc_msg 4
	goto _talkDone

_firstSwitch:
	npc_msg 5
	wait_button
	closemsg
	vermilion_gym_lock_action 0, 0
	releaseall
	end

_secondSwitch:
	npc_msg 6
	wait_button
	closemsg
	vermilion_gym_lock_action 1, 0
	setflag FLAG_SYS_SOLVED_LT_SURGE_GYM
	stop_se SEQ_SE_GS_DENGEKIBARIA
	npc_msg 7
	goto _talkDone

_reset:
	npc_msg 8
	wait_button
	closemsg
	vermilion_gym_lock_action 0, 1
	resample_vermilion_gym_cans
	releaseall
	end

scr_seq_P1_T06GYM0101_016:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	check_badge BADGE_THUNDER, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _surgeAfter
	trainer_message TRAINER_P1_LEADER_LT_SURGE, 0
	closemsg
	trainer_battle TRAINER_P1_LEADER_LT_SURGE, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	give_badge BADGE_THUNDER
	add_special_game_stat SCORE_EVENT_BADGE_GET
	setflag FLAG_HIDE_VERMILION_GYM_STOPS
	hide_person 0
	hide_person 1
	hide_person 2
	hide_person 3
	hide_person 4
	hide_person 5
	settrainerflag TRAINER_P1_ENGINEER_BAILY
	settrainerflag TRAINER_P1_SAILOR_DWAYNE
	settrainerflag TRAINER_P1_GENTLEMAN_TUCKER
	buffer_players_name 0
	npc_msg 9
	play_fanfare SEQ_ME_BADGE
	wait_fanfare
	npc_msg 10
_giveTM:
	goto_if_no_item_space ITEM_TM034, 1, _bagFull
	giveitem_no_check ITEM_TM034, 1
	setflag FLAG_P1_GOT_TM34
	npc_msg 11
	goto _talkDone

_surgeAfter:
	goto_if_unset FLAG_P1_GOT_TM34, _giveTM
	trainer_message TRAINER_P1_LEADER_LT_SURGE, 2
	goto _talkDone

_bagFull:
	callstd std_bag_is_full
	closemsg
	releaseall
	end

_lost:
	white_out
	releaseall
	end

scr_seq_P1_T06GYM0101_017:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	check_badge BADGE_THUNDER, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _guideAfter
	npc_msg 0
	goto _talkDone

_guideAfter:
	npc_msg 1
	goto _talkDone

scr_seq_P1_T06GYM0101_018:
	play_se SEQ_SE_DP_SELECT
	lockall
	buffer_players_name 0
	check_badge BADGE_THUNDER, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _statueAfter
	npc_msg 2
	goto _talkDone

_statueAfter:
	npc_msg 3
_talkDone:
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_T06GYM0101_019:
	goto_if_set FLAG_HIDE_VERMILION_GYM_STOPS, _init
	clearflag FLAG_SYS_SOLVED_LT_SURGE_GYM
_init:
	vermilion_gym_init
	end

scr_seq_P1_T06GYM0101_020:
	goto_if_set FLAG_HIDE_VERMILION_GYM_STOPS, _resumeDone
	make_object_visible 0
	make_object_visible 1
	make_object_visible 2
	make_object_visible 3
	make_object_visible 4
	make_object_visible 5
_resumeDone:
	end
