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

// hack: Cerulean Gym in Part 1 (FireRed): Picnicker Diana, Swimmer Luis, Misty (scripts/hack/gen_part1_trainers.py).
// events: data/eventdata/part1/510_P1_T04GYM0101.json, text: data/text/872.txt

.data

scrdef scr_seq_P1_T04GYM0101_001 // Misty
scrdef scr_seq_P1_T04GYM0101_002 // Gym guide
scrdef scr_seq_P1_T04GYM0101_003 // statues
scrdef_end

scr_seq_P1_T04GYM0101_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	check_badge BADGE_CASCADE, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _mistyAfter
	trainer_message TRAINER_P1_LEADER_MISTY, 0
	closemsg
	trainer_battle TRAINER_P1_LEADER_MISTY, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	give_badge BADGE_CASCADE
	add_special_game_stat SCORE_EVENT_BADGE_GET
	settrainerflag TRAINER_P1_PICNICKER_DIANA
	settrainerflag TRAINER_P1_SWIMMER_MALE_LUIS
	buffer_players_name 0
	npc_msg 4
	play_fanfare SEQ_ME_BADGE
	wait_fanfare
	npc_msg 5
_giveTM:
	goto_if_no_item_space ITEM_TM003, 1, _bagFull
	giveitem_no_check ITEM_TM003, 1
	setflag FLAG_P1_GOT_TM03
	npc_msg 6
	wait_button
	closemsg
	releaseall
	end

_mistyAfter:
	goto_if_unset FLAG_P1_GOT_TM03, _giveTM
	trainer_message TRAINER_P1_LEADER_MISTY, 2
	wait_button
	closemsg
	releaseall
	end

_bagFull:
	callstd std_bag_is_full
	closemsg
	releaseall
	end

_lost:
	white_out
	releaseall
	end

scr_seq_P1_T04GYM0101_002:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	check_badge BADGE_CASCADE, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _guideAfter
	npc_msg 0
	goto _talkDone

_guideAfter:
	npc_msg 1
	goto _talkDone

scr_seq_P1_T04GYM0101_003:
	play_se SEQ_SE_DP_SELECT
	lockall
	buffer_players_name 0
	check_badge BADGE_CASCADE, VAR_SPECIAL_RESULT
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
