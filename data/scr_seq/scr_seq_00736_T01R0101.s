.include "asm/include/interop_macros.inc"

.include "asm/include/scriptmacros.inc"
.include "asm/include/flags.inc"
.include "asm/include/soundeffects.inc"
.include "asm/include/vars.inc"

.include "asm/include/events.inc"
.include "asm/include/game_stats.inc"
.include "asm/include/maps.inc"
.include "asm/include/map_sections.inc"
.include "asm/include/movements.inc"
.include "asm/include/rankings.inc"
.include "asm/include/spawns.inc"
.include "asm/include/std_scripts.inc"
.include "asm/include/trainers.inc"

#include "constants/item.h"
#include "constants/moves.h"
#include "constants/species.h"
#include "config.h"

.include "data/scr_seq/include/event_T01R0101.inc"


// text archive to grab from: 447.txt

.data


scrdef scr_seq_T01R0101_000
scrdef scr_seq_T01R0101_001
scrdef_end

scr_seq_T01R0101_000:
	// hack: in Part 1 she's Red's mom at the start of FireRed (include/chapter.h)
	compare VAR_CHAPTER, 1
	goto_if_eq _part1Mom
	simple_npc_msg 0
	end

_part1Mom:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_set FLAG_NUZLOCKE_ASKED, _part1MomTalk
	// Nuzlocke mode is chosen once per new game (include/nuzlocke.h)
	setflag FLAG_NUZLOCKE_ASKED
	npc_msg 4
	npc_msg 5
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _nuzlockeDeclined
	setflag FLAG_NUZLOCKE_ENABLED
	npc_msg 6
	goto _part1MomRandomizer

_nuzlockeDeclined:
	npc_msg 7
_part1MomRandomizer:
	// randomizer: "no" sets the seed's high half to 0xFFFF, which a generated seed never has (include/randomizer.h)
	npc_msg 11
	npc_msg 12
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _randomizerDeclined
	npc_msg 13
	goto _part1MomTalk

_randomizerDeclined:
	setvar 0x4165, 0xFFFF
	npc_msg 14
_part1MomTalk:
	// FireRed: once Red has battled Blue in the lab, Mom heals the team
	compare VAR_P1_STORY, 4
	goto_if_ge _part1MomHeal
	npc_msg 3
#ifdef CHAPTER_DEBUG_SKIP
	wait_button
	npc_msg 8
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _debugSkipPart1
#endif
	wait_button
	closemsg
	releaseall
	end

#ifdef CHAPTER_DEBUG_SKIP
_debugSkipPart1:
	closemsg
	give_mon SPECIES_PIKACHU, 60, 0, 0, 0, VAR_SPECIAL_RESULT
	give_mon SPECIES_CHARIZARD, 60, 0, 0, 0, VAR_SPECIAL_RESULT
	give_mon SPECIES_LAPRAS, 60, 0, 0, 0, VAR_SPECIAL_RESULT
	give_mon SPECIES_SNORLAX, 60, 0, 0, 0, VAR_SPECIAL_RESULT
	fade_screen 6, 1, 0, RGB_BLACK
	wait_fade
	hof_credits 0
	restore_overworld
	fade_screen 6, 1, 1, RGB_BLACK
	wait_fade
	releaseall
	end
#endif

_part1MomHeal:
	npc_msg 9
	closemsg
	fade_screen 6, 1, 0, 0
	wait_fade
	heal_party
	play_fanfare SEQ_ME_ASA
	wait_fanfare
	fade_screen 6, 1, 1, 0
	wait_fade
	npc_msg 10
	wait_button
	closemsg
	releaseall
	end

scr_seq_T01R0101_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	npc_msg 2
	wait_button
	closemsg
	releaseall
	end
	.balign 4
