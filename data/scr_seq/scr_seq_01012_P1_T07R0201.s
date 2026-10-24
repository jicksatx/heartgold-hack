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

// hack: Celadon Condominiums 1F in Part 1 (FireRed): the old woman gives Red Tea, for the thirsty Saffron guards.
// events: data/eventdata/part1/539_P1_T07R0201.json, text: data/text/890.txt

.data

scrdef scr_seq_P1_T07R0201_001 // old woman
scrdef scr_seq_P1_T07R0201_002 // manager's suite sign
scrdef_end

scr_seq_P1_T07R0201_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_set FLAG_P1_GOT_TEA, _gotTea
	npc_msg 0
	goto_if_no_item_space ITEM_TEA, 1, _bagFull
	giveitem_no_check ITEM_TEA, 1
	setflag FLAG_P1_GOT_TEA
_gotTea:
	npc_msg 1
	wait_button
	closemsg
	releaseall
	end

_bagFull:
	callstd std_bag_is_full
	closemsg
	releaseall
	end

scr_seq_P1_T07R0201_002:
	simple_npc_msg 2
	end
