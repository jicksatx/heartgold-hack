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

// hack: Rocket Hideout in Part 1 (FireRed) is HeartGold's Team Rocket HQ (B1F-B3F; entered from the Rocket Game
// Corner).  FireRed's Rockets are on its floors; Giovanni waits in the HQ's back office and leaves the Silph Scope.
// shared by events 541-543, text: data/text/892.txt

.equ OBJ_GIOVANNI, 0

.data

scrdef scr_seq_P1_D35R0102_001 // Giovanni
scrdef_end

scr_seq_P1_D35R0102_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	npc_msg 0
	closemsg
	trainer_battle TRAINER_P1_BOSS_GIOVANNI, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	npc_msg 1
	closemsg
	fade_screen 6, 1, 0, 0
	wait_fade
	hide_person OBJ_GIOVANNI
	setflag FLAG_P1_HIDE_HIDEOUT_GIOVANNI
	fade_screen 6, 1, 1, 0
	wait_fade
	npc_msg 2
	giveitem_no_check ITEM_SILPH_SCOPE, 1
	closemsg
	releaseall
	end

_lost:
	white_out
	releaseall
	end
