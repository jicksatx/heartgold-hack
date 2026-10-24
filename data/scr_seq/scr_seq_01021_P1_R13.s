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

// hack: Routes 13-15 in Part 1 (FireRed): signs, and the Route 15 gate guard; the trainers are all common trainer
// objects.  events: 550_P1_R13, 551_P1_R14, 552_P1_R15, 553_P1_R15R0101, text: data/text/897.txt

.data

scrdef scr_seq_P1_R13_001 // Route 13 sign
scrdef scr_seq_P1_R13_002 // trainer tips
scrdef scr_seq_P1_R13_003 // trainer tips
scrdef scr_seq_P1_R13_004 // Route 15 gate guard
scrdef scr_seq_P1_R13_005 // Route 15 sign
scrdef_end

scr_seq_P1_R13_001:
	simple_npc_msg 0
	end

scr_seq_P1_R13_002:
	simple_npc_msg 1
	end

scr_seq_P1_R13_003:
	simple_npc_msg 2
	end

scr_seq_P1_R13_004:
	simple_npc_msg 3
	end

scr_seq_P1_R13_005:
	simple_npc_msg 4
	end

