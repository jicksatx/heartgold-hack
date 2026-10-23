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

// hack: Viridian Forest in Part 1 (FireRed).  events: data/eventdata/part1/500_P1_D46R0101.json, text:
// data/text/863.txt.  the Bug Catchers are FireRed's (scripts/hack/gen_part1_trainers.py), on HeartGold's spots

.data

scrdef scr_seq_P1_D46R0101_001 // youngster
scrdef scr_seq_P1_D46R0101_002 // boy
scrdef_end

scr_seq_P1_D46R0101_001:
	simple_npc_msg 0
	end

scr_seq_P1_D46R0101_002:
	simple_npc_msg 1
	end
