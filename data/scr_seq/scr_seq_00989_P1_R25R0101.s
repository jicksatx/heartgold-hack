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

// hack: the Sea Cottage in Part 1 (FireRed): Bill, stuck as a Pokemon, gets Red to run the Cell Separator, then
// gives him the S.S. Ticket.  events: data/eventdata/part1/509_P1_R25R0101.json, text: data/text/871.txt,
// header scr_seq_00990_P1_R25R0101_hdr.s

.equ OBJ_BILL_MON, 0
.equ OBJ_BILL, 1

.data

scrdef scr_seq_P1_R25R0101_001 // Bill as a Pokemon
scrdef scr_seq_P1_R25R0101_002 // Bill
scrdef scr_seq_P1_R25R0101_003 // on transition
scrdef_end

scr_seq_P1_R25R0101_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	npc_msg 0
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _help
	npc_msg 1
_help:
	npc_msg 2
	closemsg
	fade_screen 6, 1, 0, 0
	wait_fade
	hide_person OBJ_BILL_MON
	setflag FLAG_P1_HIDE_BILL_MON
	play_se SEQ_SE_DP_SELECT
	buffer_players_name 0
	npc_msg 3
	closemsg
	clearflag FLAG_P1_HIDE_BILL_HUMAN
	show_person OBJ_BILL
	setvar VAR_P1_BILL, 1
	fade_screen 6, 1, 1, 0
	wait_fade
	releaseall
	end

scr_seq_P1_R25R0101_002:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	compare VAR_P1_BILL, 2
	goto_if_eq _goToSSAnne
	npc_msg 4
	goto_if_no_item_space ITEM_SS_TICKET, 1, _noRoom
	giveitem_no_check ITEM_SS_TICKET, 1
	setvar VAR_P1_BILL, 2
_goToSSAnne:
	npc_msg 5
	wait_button
	closemsg
	releaseall
	end

_noRoom:
	npc_msg 7
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_R25R0101_003:
	compare VAR_P1_BILL, 0
	goto_if_ne _billHuman
	clearflag FLAG_P1_HIDE_BILL_MON
	setflag FLAG_P1_HIDE_BILL_HUMAN
	end

_billHuman:
	setflag FLAG_P1_HIDE_BILL_MON
	clearflag FLAG_P1_HIDE_BILL_HUMAN
	end
