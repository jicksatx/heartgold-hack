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

// hack: the S.S. Anne captain's office in Part 1 (FireRed): rub the seasick Captain's back for HM01 Cut.
// events: data/eventdata/part1/523_P1_P01R0302.json, text: data/text/879.txt

.data

scrdef scr_seq_P1_P01R0302_001 // Captain
scrdef_end

scr_seq_P1_P01R0302_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	compare VAR_P1_SSANNE, 2
	goto_if_eq _done
	npc_msg 0
	buffer_players_name 0
	npc_msg 1
	play_fanfare SEQ_ME_ASA
	wait_fanfare
	closemsg
	faceplayer
	npc_msg 2
	goto_if_no_item_space ITEM_HM01, 1, _bagFull
	giveitem_no_check ITEM_HM01, 1
	setvar VAR_P1_SSANNE, 2
	npc_msg 3
	wait_button
	closemsg
	releaseall
	end

_done:
	faceplayer
	npc_msg 4
	wait_button
	closemsg
	releaseall
	end

_bagFull:
	callstd std_bag_is_full
	closemsg
	releaseall
	end
