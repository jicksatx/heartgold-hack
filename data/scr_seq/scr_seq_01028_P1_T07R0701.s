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

// hack: Celadon Restaurant in Part 1 (FireRed): FireRed's diners; the busted gambler gives the Coin Case.
// events: 562_P1_T07R0701.json, text: data/text/902.txt

.data

scrdef scr_seq_P1_T07R0701_001 // chef
scrdef scr_seq_P1_T07R0701_002 // woman
scrdef scr_seq_P1_T07R0701_003 // man
scrdef scr_seq_P1_T07R0701_004 // man
scrdef scr_seq_P1_T07R0701_005 // busted gambler (Coin Case)
scrdef_end

scr_seq_P1_T07R0701_001:
	simple_npc_msg 0
	end

scr_seq_P1_T07R0701_002:
	simple_npc_msg 1
	end

scr_seq_P1_T07R0701_003:
	simple_npc_msg 2
	end

scr_seq_P1_T07R0701_004:
	simple_npc_msg 3
	end

scr_seq_P1_T07R0701_005:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	hasitem ITEM_COIN_CASE, 1, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _gotCase
	npc_msg 4
	goto_if_no_item_space ITEM_COIN_CASE, 1, _bagFull
	giveitem_no_check ITEM_COIN_CASE, 1
	closemsg
	releaseall
	end

_gotCase:
	npc_msg 5
	wait_button
	closemsg
	releaseall
	end

_bagFull:
	callstd std_bag_is_full
	closemsg
	releaseall
	end
