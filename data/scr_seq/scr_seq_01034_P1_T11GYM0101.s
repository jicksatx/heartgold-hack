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

// hack: Saffron Gym in Part 1 (FireRed): HeartGold's warp-pad gym (FireRed's has the same kind of puzzle) with
// FireRed's Psychics and Channelers in its side rooms, and Sabrina.  events: 573_P1_T11GYM0101.json, text: 908.txt

.data

scrdef scr_seq_P1_T11GYM0101_001 // Sabrina
scrdef scr_seq_P1_T11GYM0101_002 // gym guide
scrdef scr_seq_P1_T11GYM0101_003 // statues
scrdef_end

scr_seq_P1_T11GYM0101_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	check_badge BADGE_MARSH, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _sabrinaAfter
	trainer_message TRAINER_P1_LEADER_SABRINA, 0
	closemsg
	trainer_battle TRAINER_P1_LEADER_SABRINA, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	give_badge BADGE_MARSH
	add_special_game_stat SCORE_EVENT_BADGE_GET
	settrainerflag TRAINER_P1_PSYCHIC_JOHAN
	settrainerflag TRAINER_P1_PSYCHIC_TYRON
	settrainerflag TRAINER_P1_PSYCHIC_CAMERON
	settrainerflag TRAINER_P1_PSYCHIC_PRESTON
	settrainerflag TRAINER_P1_CHANNELER_AMANDA
	settrainerflag TRAINER_P1_CHANNELER_STACY
	settrainerflag TRAINER_P1_CHANNELER_TASHA
	buffer_players_name 0
	npc_msg 2
	play_fanfare SEQ_ME_BADGE
	wait_fanfare
	npc_msg 3
_giveTM:
	goto_if_no_item_space ITEM_TM004, 1, _bagFull
	giveitem_no_check ITEM_TM004, 1
	setflag FLAG_P1_GOT_TM04
	npc_msg 4
	goto _talkDone

_sabrinaAfter:
	goto_if_unset FLAG_P1_GOT_TM04, _giveTM
	trainer_message TRAINER_P1_LEADER_SABRINA, 2
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

scr_seq_P1_T11GYM0101_002:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	check_badge BADGE_MARSH, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _guideAfter
	npc_msg 5
	goto _talkDone

_guideAfter:
	npc_msg 6
	goto _talkDone

scr_seq_P1_T11GYM0101_003:
	play_se SEQ_SE_DP_SELECT
	lockall
	buffer_players_name 0
	check_badge BADGE_MARSH, VAR_SPECIAL_RESULT
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
