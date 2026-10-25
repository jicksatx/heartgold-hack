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

// hack: Viridian Gym in Part 1 (FireRed) = HeartGold's Viridian Gym (Blue's in Part 2).  Its sliding floor stands in
// for FireRed's spin tiles; FireRed's 8 trainers; Giovanni: Earth Badge, TM26 Earthquake, then he leaves Team Rocket
// (gone next visit) and Blue waits on Route 22 (VAR_P1_ROUTE22 3).  events: 597, text: data/text/915.txt

.data

scrdef scr_seq_P1_T02GYM_001 // Giovanni
scrdef scr_seq_P1_T02GYM_002 // gym guide
scrdef scr_seq_P1_T02GYM_003 // statues
scrdef_end

scr_seq_P1_T02GYM_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	check_badge BADGE_EARTH, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _giovanniAfter
	trainer_message TRAINER_P1_LEADER_GIOVANNI, 0
	closemsg
	trainer_battle TRAINER_P1_LEADER_GIOVANNI, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	give_badge BADGE_EARTH
	add_special_game_stat SCORE_EVENT_BADGE_GET
	settrainerflag TRAINER_P1_TAMER_JASON
	settrainerflag TRAINER_P1_TAMER_COLE
	settrainerflag TRAINER_P1_BLACK_BELT_ATSUSHI
	settrainerflag TRAINER_P1_BLACK_BELT_KIYO
	settrainerflag TRAINER_P1_BLACK_BELT_TAKASHI
	settrainerflag TRAINER_P1_COOLTRAINER_SAMUEL
	settrainerflag TRAINER_P1_COOLTRAINER_YUJI
	settrainerflag TRAINER_P1_COOLTRAINER_WARREN
	setvar VAR_P1_ROUTE22, 3
	buffer_players_name 0
	npc_msg 0
	play_fanfare SEQ_ME_BADGE
	wait_fanfare
	npc_msg 1
_giveTM:
	goto_if_no_item_space ITEM_TM026, 1, _bagFull
	giveitem_no_check ITEM_TM026, 1
	setflag FLAG_P1_GOT_TM26
	setflag FLAG_P1_HIDE_VIRIDIAN_GIOVANNI
	npc_msg 2
	goto _talkDone

_giovanniAfter:
	goto_if_unset FLAG_P1_GOT_TM26, _giveTM
	trainer_message TRAINER_P1_LEADER_GIOVANNI, 2
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

scr_seq_P1_T02GYM_002:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	check_badge BADGE_EARTH, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _guideAfter
	npc_msg 3
	goto _talkDone

_guideAfter:
	npc_msg 4
	goto _talkDone

scr_seq_P1_T02GYM_003:
	play_se SEQ_SE_DP_SELECT
	lockall
	check_badge BADGE_EARTH, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _statueAfter
	npc_msg 5
	goto _talkDone

_statueAfter:
	buffer_players_name 0
	npc_msg 6
_talkDone:
	wait_button
	closemsg
	releaseall
	end
