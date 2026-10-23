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

// hack: Viridian City Poke Mart in Part 1 (FireRed).  events: data/eventdata/part1/496_P1_T02FS0101.json, text:
// data/text/858.txt, header scr_seq_00974_P1_T02FS0101_hdr.s.  the first visit after the lab, the clerk hands Red
// Oak's Parcel (HeartGold's Parcel key item)

.data

scrdef scr_seq_P1_T02FS0101_001 // clerk
scrdef scr_seq_P1_T02FS0101_002 // woman
scrdef scr_seq_P1_T02FS0101_003 // youngster
scrdef scr_seq_P1_T02FS0101_004 // parcel scene (frame table)
scrdef_end

scr_seq_P1_T02FS0101_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	compare VAR_P1_STORY, 5
	goto_if_eq _sayHiToOak
	callstd std_mart_intro
	holdmsg
	setvar VAR_SPECIAL_x8004, 1
	callstd std_pokemart
	releaseall
	end

_sayHiToOak:
	npc_msg 3
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_T02FS0101_002:
	simple_npc_msg 4
	end

scr_seq_P1_T02FS0101_003:
	simple_npc_msg 5
	end

scr_seq_P1_T02FS0101_004:
	lockall
	apply_movement 0, _clerkNotice
	wait_movement
	npc_msg 0
	npc_msg 1
	setvar VAR_P1_STORY, 5
	giveitem_no_check ITEM_PARCEL, 1
	closemsg
	releaseall
	end

	.balign 4
_clerkNotice:
	step 75, 1  // !
	step_end
