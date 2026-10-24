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

// hack: the Fighting Dojo and Mr. Psychic's house in Part 1 (FireRed): FireRed's Black Belts, Karate Master Koichi
// (beat him, then take Hitmonlee or Hitmonchan), and Mr. Psychic's TM29.  events: 571_P1_T11R0101.json,
// 572_P1_T11R0501.json, text: data/text/907.txt

.equ OBJ_HITMONLEE_BALL, 5
.equ OBJ_HITMONCHAN_BALL, 6

.data

scrdef scr_seq_P1_T11R0101_001 // Karate Master Koichi
scrdef scr_seq_P1_T11R0101_002 // Hitmonlee
scrdef scr_seq_P1_T11R0101_003 // Hitmonchan
scrdef scr_seq_P1_T11R0101_004 // scrolls
scrdef scr_seq_P1_T11R0101_005 // Mr. Psychic
scrdef_end

scr_seq_P1_T11R0101_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	checktrainerflag TRAINER_P1_BLACK_BELT_KOICHI
	goto_if 1, _masterBeaten
	trainer_message TRAINER_P1_BLACK_BELT_KOICHI, 0
	closemsg
	trainer_battle TRAINER_P1_BLACK_BELT_KOICHI, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
_masterBeaten:
	goto_if_set FLAG_P1_GOT_DOJO_MON, _stay
	npc_msg 0
	goto _done

_stay:
	npc_msg 1
_done:
	wait_button
	closemsg
	releaseall
	end

_lost:
	white_out
	releaseall
	end

scr_seq_P1_T11R0101_002:
	setvar VAR_SPECIAL_x8006, 106
	setvar VAR_SPECIAL_x8007, 2
	goto _ball

scr_seq_P1_T11R0101_003:
	setvar VAR_SPECIAL_x8006, 107
	setvar VAR_SPECIAL_x8007, 3
_ball:
	play_se SEQ_SE_DP_SELECT
	lockall
	checktrainerflag TRAINER_P1_BLACK_BELT_KOICHI
	goto_if 0, _notYet
	get_party_count VAR_SPECIAL_x8005
	compare VAR_SPECIAL_x8005, 6
	goto_if_eq _partyFull
	compare VAR_SPECIAL_x8007, 2
	goto_if_ne _askChan
	npc_msg 2
	goto _ask

_askChan:
	npc_msg 3
_ask:
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _no
	give_mon VAR_SPECIAL_x8006, 25, 0, 0, 0, VAR_SPECIAL_RESULT
	hide_person OBJ_HITMONLEE_BALL
	hide_person OBJ_HITMONCHAN_BALL
	setflag FLAG_P1_GOT_DOJO_MON
	play_fanfare SEQ_ME_POKEGET
	wait_fanfare
_no:
	closemsg
	releaseall
	end

_notYet:
	npc_msg 4
	goto _done

_partyFull:
	npc_msg 8
	goto _done

scr_seq_P1_T11R0101_004:
	simple_npc_msg 5
	end

scr_seq_P1_T11R0101_005:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_set FLAG_P1_GOT_TM29, _gotTM
	npc_msg 6
	goto_if_no_item_space ITEM_TM029, 1, _bagFull
	giveitem_no_check ITEM_TM029, 1
	setflag FLAG_P1_GOT_TM29
_gotTM:
	npc_msg 7
	goto _done

_bagFull:
	callstd std_bag_is_full
	closemsg
	releaseall
	end
