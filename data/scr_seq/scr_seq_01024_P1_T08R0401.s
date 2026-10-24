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

// hack: Fuchsia's southwest house and the Warden's house in Part 1 (FireRed): the Fishing Guru's older brother gives the Good Rod; the Warden has lost his teeth.  events: 556_P1_T08R0401.json, 557_P1_T08R0601.json.  text: data/text/900.txt

.data

scrdef scr_seq_P1_T08R0401_001 // fishing guru's brother
scrdef scr_seq_P1_T08R0401_002 // Warden
scrdef_end

scr_seq_P1_T08R0401_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_set FLAG_P1_GOT_GOOD_ROD, _gotRod
	npc_msg 0
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _no
	npc_msg 1
	goto_if_no_item_space ITEM_GOOD_ROD, 1, _bagFull
	giveitem_no_check ITEM_GOOD_ROD, 1
	setflag FLAG_P1_GOT_GOOD_ROD
	npc_msg 2
	goto _done

_no:
	npc_msg 3
	goto _done

_gotRod:
	buffer_players_name 0
	npc_msg 4
_done:
	wait_button
	closemsg
	releaseall
	end

_bagFull:
	callstd std_bag_is_full
	closemsg
	releaseall
	end
scr_seq_P1_T08R0401_002:
	simple_npc_msg 5
	end
