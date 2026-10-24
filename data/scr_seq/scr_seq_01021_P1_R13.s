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

// hack: Routes 13-15 in Part 1 (FireRed): signs, and the Route 15 gate guard; the trainers are all common trainer
// objects.  events: 550_P1_R13, 551_P1_R14, 552_P1_R15, 553_P1_R15R0101, text: data/text/897.txt

.data

scrdef scr_seq_P1_R13_001 // Route 13 sign
scrdef scr_seq_P1_R13_002 // trainer tips
scrdef scr_seq_P1_R13_003 // trainer tips
scrdef scr_seq_P1_R13_004 // Route 15 gate guard
scrdef scr_seq_P1_R13_005 // Route 15 sign
scrdef scr_seq_P1_R13_006 // Professor Oak's Aide (Exp. Share)
scrdef_end

scr_seq_P1_R13_001:
	simple_npc_msg 0
	end

scr_seq_P1_R13_002:
	simple_npc_msg 1
	end

scr_seq_P1_R13_003:
	simple_npc_msg 2
	end

scr_seq_P1_R13_004:
	simple_npc_msg 3
	end

scr_seq_P1_R13_005:
	simple_npc_msg 4
	end


scr_seq_P1_R13_006:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_set FLAG_P1_GOT_EXP_SHARE, _explain
	buffer_players_name 0
	npc_msg 5
	count_national_dex_owned VAR_SPECIAL_x8004
	buffer_int 1, VAR_SPECIAL_x8004
	compare VAR_SPECIAL_x8004, 50
	goto_if_lt _notEnough
	npc_msg 6
	goto_if_no_item_space ITEM_EXP_SHARE, 1, _bagFull
	giveitem_no_check ITEM_EXP_SHARE, 1
	setflag FLAG_P1_GOT_EXP_SHARE
_explain:
	npc_msg 7
	goto _aideDone

_notEnough:
	npc_msg 8
_aideDone:
	wait_button
	closemsg
	releaseall
	end

_bagFull:
	callstd std_bag_is_full
	closemsg
	releaseall
	end
