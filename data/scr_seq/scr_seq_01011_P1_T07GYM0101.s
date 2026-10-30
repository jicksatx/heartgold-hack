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

// hack: Celadon Gym in Part 1 (FireRed): FireRed's 7 trainers and Erika.  events:
// data/eventdata/part1/538_P1_T07GYM0101.json, text: data/text/889.txt

.data

scrdef scr_seq_P1_T07GYM0101_001 // Erika
scrdef scr_seq_P1_T07GYM0101_002 // statues
scrdef_end

scr_seq_P1_T07GYM0101_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	check_badge BADGE_RAINBOW, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _erikaAfter
	openmsg // trainer_message needs the window open (HeartGold's trainer scripts do the same)
	trainer_message TRAINER_P1_LEADER_ERIKA, 0
	closemsg
	trainer_battle TRAINER_P1_LEADER_ERIKA, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	give_badge BADGE_RAINBOW
	add_special_game_stat SCORE_EVENT_BADGE_GET
	settrainerflag TRAINER_P1_LASS_KAY
	settrainerflag TRAINER_P1_LASS_LISA
	settrainerflag TRAINER_P1_PICNICKER_TINA
	settrainerflag TRAINER_P1_BEAUTY_BRIDGET
	settrainerflag TRAINER_P1_BEAUTY_TAMIA
	settrainerflag TRAINER_P1_BEAUTY_LORI
	settrainerflag TRAINER_P1_COOLTRAINER_MARY
	buffer_players_name 0
	npc_msg 2
	play_fanfare SEQ_ME_BADGE
	wait_fanfare
	npc_msg 3
_giveTM:
	goto_if_no_item_space ITEM_TM019, 1, _bagFull
	giveitem_no_check ITEM_TM019, 1
	setflag FLAG_P1_GOT_TM19
	npc_msg 4
	goto _talkDone

_erikaAfter:
	goto_if_unset FLAG_P1_GOT_TM19, _giveTM
	openmsg
	trainer_message TRAINER_P1_LEADER_ERIKA, 2
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

scr_seq_P1_T07GYM0101_002:
	play_se SEQ_SE_DP_SELECT
	lockall
	buffer_players_name 0
	check_badge BADGE_RAINBOW, VAR_SPECIAL_RESULT
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
