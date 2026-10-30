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

// hack: Fuchsia Gym in Part 1 (FireRed): FireRed's Jugglers and Tamers in HeartGold's walled gym, and Koga.
// events: data/eventdata/part1/555_P1_T08GYM0101.json, text: data/text/899.txt

.data

scrdef scr_seq_P1_T08GYM0101_001 // Koga
scrdef scr_seq_P1_T08GYM0101_002 // gym guide
scrdef scr_seq_P1_T08GYM0101_003 // statues
scrdef_end

scr_seq_P1_T08GYM0101_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	check_badge BADGE_SOUL, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _kogaAfter
	openmsg // trainer_message needs the window open (HeartGold's trainer scripts do the same)
	trainer_message TRAINER_P1_LEADER_KOGA, 0
	closemsg
	trainer_battle TRAINER_P1_LEADER_KOGA, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	give_badge BADGE_SOUL
	add_special_game_stat SCORE_EVENT_BADGE_GET
	settrainerflag TRAINER_P1_JUGGLER_KAYDEN
	settrainerflag TRAINER_P1_JUGGLER_KIRK
	settrainerflag TRAINER_P1_JUGGLER_NATE
	settrainerflag TRAINER_P1_JUGGLER_SHAWN
	settrainerflag TRAINER_P1_TAMER_EDGAR
	settrainerflag TRAINER_P1_TAMER_PHIL
	buffer_players_name 0
	npc_msg 2
	play_fanfare SEQ_ME_BADGE
	wait_fanfare
	npc_msg 3
_giveTM:
	goto_if_no_item_space ITEM_TM006, 1, _bagFull
	giveitem_no_check ITEM_TM006, 1
	setflag FLAG_P1_GOT_TM06
	npc_msg 4
	goto _talkDone

_kogaAfter:
	goto_if_unset FLAG_P1_GOT_TM06, _giveTM
	openmsg
	trainer_message TRAINER_P1_LEADER_KOGA, 2
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

scr_seq_P1_T08GYM0101_002:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	check_badge BADGE_SOUL, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _guideAfter
	npc_msg 5
	goto _talkDone

_guideAfter:
	npc_msg 6
	goto _talkDone

scr_seq_P1_T08GYM0101_003:
	play_se SEQ_SE_DP_SELECT
	lockall
	buffer_players_name 0
	check_badge BADGE_SOUL, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _statueAfter
	npc_msg 0
	goto _talkDone

_statueAfter:
	npc_msg 1
_talkDone:
	wait_button
	closemsg
	releaseall
	end
