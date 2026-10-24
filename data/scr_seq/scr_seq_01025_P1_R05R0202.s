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

// hack: the Underground Path (HeartGold's Route 5-6 tunnel) in Part 1.  Walked normally it connects Routes 5 and 6;
// entered from the Route 7/8 gates (VAR_P1_UGPATH 1) it stands in for FireRed's Route 7-8 path: its north stairs lead
// back to the Route 8 gate and its south stairs to the Route 7 gate.  events: 558_P1_R05R0202.json, text: 901.txt

.data

scrdef scr_seq_P1_R05R0202_001 // north stairs -> Route 8 gate
scrdef scr_seq_P1_R05R0202_002 // south stairs -> Route 7 gate
scrdef_end

scr_seq_P1_R05R0202_001:
	lockall
	setvar VAR_P1_UGPATH, 0
	fade_screen 6, 1, 0, 0
	wait_fade
	warp MAP_R08R0201, 0, 9, 7, DIR_EAST
	fade_screen 6, 1, 1, 0
	wait_fade
	releaseall
	end

scr_seq_P1_R05R0202_002:
	lockall
	setvar VAR_P1_UGPATH, 0
	fade_screen 6, 1, 0, 0
	wait_fade
	warp MAP_R07R0101, 0, 2, 7, DIR_WEST
	fade_screen 6, 1, 1, 0
	wait_fade
	releaseall
	end
