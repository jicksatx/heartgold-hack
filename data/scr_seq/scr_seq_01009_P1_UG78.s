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

// hack: the Route 7 and Route 8 Saffron gatehouses in Part 1 (FireRed).  HeartGold has no Underground Path
// between Routes 7 and 8: heading toward Saffron, the thirsty guard turns Red away and he goes down into the Route 5-6
// tunnel (VAR_P1_UGPATH 1), whose stairs then lead up to the other gate (scr_seq_01025_P1_R05R0202.s).  events: data/eventdata/part1/534_P1_R08R0201.json, 535_P1_R07R0101.json,
// text: data/text/887.txt

.data

scrdef scr_seq_P1_UG78_001 // guard
scrdef scr_seq_P1_UG78_002 // Route 8 side -> Route 7
scrdef scr_seq_P1_UG78_003 // Route 7 side -> Route 8
scrdef_end

scr_seq_P1_UG78_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	compare VAR_P1_SAFFRON, 1
	goto_if_ge _guardHi
	npc_msg 2
	goto _guardDone

_guardHi:
	npc_msg 5
_guardDone:
	wait_button
	closemsg
	releaseall
	end

_giveTea:
	npc_msg 3
	takeitem_no_check ITEM_TEA, 1
	setvar VAR_P1_SAFFRON, 1
	npc_msg 4
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_UG78_002:
	lockall
	get_player_facing VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 2
	goto_if_ne _release
	hasitem ITEM_TEA, 1, VAR_SPECIAL_x8004
	compare VAR_SPECIAL_x8004, 1
	goto_if_eq _giveTea
	npc_msg 0
	buffer_players_name 0
	npc_msg 1
	closemsg
	fade_screen 6, 1, 0, 0
	wait_fade
	setvar VAR_P1_UGPATH, 1
	warp MAP_R05R0202, 0, 6, 4, DIR_EAST
	fade_screen 6, 1, 1, 0
	wait_fade
	releaseall
	end

scr_seq_P1_UG78_003:
	lockall
	get_player_facing VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 3
	goto_if_ne _release
	hasitem ITEM_TEA, 1, VAR_SPECIAL_x8004
	compare VAR_SPECIAL_x8004, 1
	goto_if_eq _giveTea
	npc_msg 0
	buffer_players_name 0
	npc_msg 1
	closemsg
	fade_screen 6, 1, 0, 0
	wait_fade
	setvar VAR_P1_UGPATH, 1
	warp MAP_R05R0202, 0, 6, 57, DIR_EAST
	fade_screen 6, 1, 1, 0
	wait_fade
_release:
	releaseall
	end
