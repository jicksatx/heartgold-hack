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

// hack: Route 1 in Part 1 (FireRed).  events: data/eventdata/part1/494_P1_R01.json, text: data/text/859.txt.
// wired up in src/field/chapter_field.c

.data

scrdef scr_seq_P1_R01_001 // Poke Mart clerk (Potion sample)
scrdef scr_seq_P1_R01_002 // boy
scrdef scr_seq_P1_R01_003 // route sign
scrdef_end

scr_seq_P1_R01_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_set FLAG_P1_GOT_ROUTE1_POTION, _gotPotion
	npc_msg 0
	goto_if_no_item_space ITEM_POTION, 1, _bagFull
	setflag FLAG_P1_GOT_ROUTE1_POTION
	giveitem_no_check ITEM_POTION, 1
	closemsg
	releaseall
	end

_bagFull:
	callstd std_bag_is_full
	closemsg
	releaseall
	end

_gotPotion:
	npc_msg 1
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_R01_002:
	simple_npc_msg 2
	end

scr_seq_P1_R01_003:
	direction_signpost 3, 0, 1, VAR_SPECIAL_RESULT
	scrcmd_057 3
	scrcmd_058
	scrcmd_060 VAR_SPECIAL_RESULT
	callstd std_signpost
	end
