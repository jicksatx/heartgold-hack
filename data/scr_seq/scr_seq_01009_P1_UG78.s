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
// between Routes 7 and 8, so heading toward Saffron here stands in for it: the thirsty guard turns Red away and he
// comes out on the other side.  events: data/eventdata/part1/534_P1_R08R0201.json, 535_P1_R07R0101.json,
// text: data/text/887.txt

.data

scrdef scr_seq_P1_UG78_001 // guard
scrdef scr_seq_P1_UG78_002 // Route 8 side -> Route 7
scrdef scr_seq_P1_UG78_003 // Route 7 side -> Route 8
scrdef_end

scr_seq_P1_UG78_001:
	simple_npc_msg 2
	end

scr_seq_P1_UG78_002:
	lockall
	get_player_facing VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 2
	goto_if_ne _release
	npc_msg 0
	buffer_players_name 0
	npc_msg 1
	closemsg
	fade_screen 6, 1, 0, 0
	wait_fade
	warp MAP_R07, 0, 1272, 240, DIR_WEST
	fade_screen 6, 1, 1, 0
	wait_fade
	releaseall
	end

scr_seq_P1_UG78_003:
	lockall
	get_player_facing VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 3
	goto_if_ne _release
	npc_msg 0
	buffer_players_name 0
	npc_msg 1
	closemsg
	fade_screen 6, 1, 0, 0
	wait_fade
	warp MAP_R08, 0, 1345, 240, DIR_EAST
	fade_screen 6, 1, 1, 0
	wait_fade
_release:
	releaseall
	end
