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

// hack: Mr. Fuji's house in Part 1 (FireRed) is HeartGold's Lavender Volunteer Pokemon House.  Mr. Fuji is home once
// he's been rescued from the Pokemon Tower, and gives Red the Poke Flute.  events: 547_P1_T05R0201.json, text:
// data/text/894.txt, header scr_seq_01018_P1_T05R0201_hdr.s

.data

scrdef scr_seq_P1_T05R0201_001 // Mr. Fuji
scrdef scr_seq_P1_T05R0201_002 // man
scrdef scr_seq_P1_T05R0201_003 // girl
scrdef scr_seq_P1_T05R0201_004 // Nidorino
scrdef scr_seq_P1_T05R0201_005 // Psyduck
scrdef scr_seq_P1_T05R0201_006 // on transition
scrdef_end

scr_seq_P1_T05R0201_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_set FLAG_P1_GOT_POKE_FLUTE, _gotFlute
	buffer_players_name 0
	npc_msg 5
	goto_if_no_item_space ITEM_POKE_FLUTE, 1, _bagFull
	giveitem_no_check ITEM_POKE_FLUTE, 1
	setflag FLAG_P1_GOT_POKE_FLUTE
	npc_msg 6
	wait_button
	closemsg
	releaseall
	end

_gotFlute:
	npc_msg 7
	wait_button
	closemsg
	releaseall
	end

_bagFull:
	callstd std_bag_is_full
	closemsg
	releaseall
	end

scr_seq_P1_T05R0201_002:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	compare VAR_P1_TOWER, 3
	goto_if_ge _fujiBack
	npc_msg 0
	goto _manDone

_fujiBack:
	npc_msg 1
_manDone:
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_T05R0201_003:
	simple_npc_msg 2
	end

scr_seq_P1_T05R0201_004:
	simple_npc_msg 3
	end

scr_seq_P1_T05R0201_005:
	simple_npc_msg 4
	end

scr_seq_P1_T05R0201_006:
	compare VAR_P1_TOWER, 3
	goto_if_ge _fujiHome
	setflag FLAG_P1_HIDE_HOUSE_FUJI
	end

_fujiHome:
	clearflag FLAG_P1_HIDE_HOUSE_FUJI
	end
