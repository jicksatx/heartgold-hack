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

// hack: Part 1's Safari Zone is HeartGold's own (its entrance building and Safari Game, entered through Fuchsia's
// Safari Zone door).  Its area layout is random per save, except the Peak area, which is always the one right past
// the entrance: FireRed's Gold Teeth and the Secret House attendant (HM03 Surf) wait at the far end of the Peak.
// events: 563_P1_D47R0102.json, text: data/text/904.txt

.equ OBJ_GOLD_TEETH, 0

.data

scrdef scr_seq_P1_D47R0102_001 // the Gold Teeth
scrdef scr_seq_P1_D47R0102_002 // Secret House attendant (HM03)
scrdef_end

scr_seq_P1_D47R0102_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	goto_if_no_item_space ITEM_GOLD_TEETH, 1, _bagFull
	hide_person OBJ_GOLD_TEETH
	setflag FLAG_P1_GOT_GOLD_TEETH
	giveitem_no_check ITEM_GOLD_TEETH, 1
	closemsg
	releaseall
	end

scr_seq_P1_D47R0102_002:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_set FLAG_P1_GOT_HM03, _gotHM
	npc_msg 0
	goto_if_no_item_space ITEM_HM03, 1, _bagFull
	giveitem_no_check ITEM_HM03, 1
	setflag FLAG_P1_GOT_HM03
_gotHM:
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
