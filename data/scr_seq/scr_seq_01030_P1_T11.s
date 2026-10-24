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
.include "asm/include/game_stats.inc"

// hack: Saffron City in Part 1 (FireRed): Team Rocket's Grunts loiter in the streets until Giovanni leaves Silph Co.
// (VAR_P1_SILPH 2), then FireRed's relieved townspeople take their places.  events: 565_P1_T11.json, text: 905.txt,
// header scr_seq_01031_P1_T11_hdr.s

.data

scrdef scr_seq_P1_T11_001
scrdef scr_seq_P1_T11_002
scrdef scr_seq_P1_T11_003
scrdef scr_seq_P1_T11_004
scrdef scr_seq_P1_T11_005
scrdef scr_seq_P1_T11_006
scrdef scr_seq_P1_T11_007
scrdef scr_seq_P1_T11_008
scrdef scr_seq_P1_T11_009
scrdef scr_seq_P1_T11_010
scrdef scr_seq_P1_T11_011
scrdef scr_seq_P1_T11_012
scrdef scr_seq_P1_T11_013
scrdef scr_seq_P1_T11_014
scrdef scr_seq_P1_T11_015
scrdef scr_seq_P1_T11_016
scrdef scr_seq_P1_T11_017
scrdef scr_seq_P1_T11_018
scrdef scr_seq_P1_T11_019
scrdef_end

scr_seq_P1_T11_001:
	simple_npc_msg 0
	end

scr_seq_P1_T11_002:
	simple_npc_msg 1
	end

scr_seq_P1_T11_003:
	simple_npc_msg 2
	end

scr_seq_P1_T11_004:
	simple_npc_msg 3
	end

scr_seq_P1_T11_005:
	simple_npc_msg 4
	end

scr_seq_P1_T11_006:
	simple_npc_msg 5
	end

scr_seq_P1_T11_007:
	simple_npc_msg 6
	end

scr_seq_P1_T11_008:
	simple_npc_msg 7
	end

scr_seq_P1_T11_009:
	simple_npc_msg 8
	end

scr_seq_P1_T11_010:
	simple_npc_msg 9
	end

scr_seq_P1_T11_011:
	simple_npc_msg 10
	end

scr_seq_P1_T11_012:
	simple_npc_msg 11
	end

scr_seq_P1_T11_013:
	simple_npc_msg 12
	end

scr_seq_P1_T11_014:
	simple_npc_msg 13
	end

scr_seq_P1_T11_015:
	simple_npc_msg 14
	end

scr_seq_P1_T11_016:
	simple_npc_msg 15
	end

scr_seq_P1_T11_017:
	simple_npc_msg 16
	end

scr_seq_P1_T11_018:
	simple_npc_msg 17
	end

scr_seq_P1_T11_019:
	compare VAR_P1_SILPH, 2
	goto_if_ge _rocketsGone
	clearflag FLAG_P1_HIDE_SAFFRON_ROCKETS
	setflag FLAG_P1_HIDE_SAFFRON_CIVILIANS
	end

_rocketsGone:
	setflag FLAG_P1_HIDE_SAFFRON_ROCKETS
	clearflag FLAG_P1_HIDE_SAFFRON_CIVILIANS
	end
