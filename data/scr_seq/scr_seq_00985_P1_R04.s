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

// hack: Route 4 in Part 1 (FireRed).  events: data/eventdata/part1/505_P1_R04.json, text: data/text/867.txt

.data

scrdef scr_seq_P1_R04_001 // route sign
scrdef scr_seq_P1_R04_002 // woman
scrdef scr_seq_P1_R04_003 // man
scrdef_end

scr_seq_P1_R04_001:
	direction_signpost 0, 0, 1, VAR_SPECIAL_RESULT
	scrcmd_057 3
	scrcmd_058
	scrcmd_060 VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_R04_002:
	simple_npc_msg 2
	end

scr_seq_P1_R04_003:
	simple_npc_msg 3
	end
