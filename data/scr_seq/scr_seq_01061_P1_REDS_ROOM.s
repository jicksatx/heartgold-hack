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

// hack: Red's bedroom in Part 1 (FireRed): the NES, and Red's PC with the Potion in its item storage.  test builds
// (CHAPTER_DEBUG_SKIP, include/config.h) also keep unlimited Rare Candies there, plus test tools (give item, give Pokemon
// on the PC, a warp on the NES) driven by vars 0x4111/0x4112/0x4109.
// events: data/eventdata/part1/680_P1_T01R0102.json, text: data/text/923.txt

.equ FLAG_P1_GOT_PC_POTION, 2094

.data

scrdef scr_seq_P1_REDS_ROOM_001 // the NES
scrdef scr_seq_P1_REDS_ROOM_002 // Red's PC
scrdef scr_seq_P1_REDS_ROOM_003 // on transition: unlock the start menu (header scr_seq_01062)
scrdef_end

scr_seq_P1_REDS_ROOM_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	buffer_players_name 0
	npc_msg 0
	wait_button
	closemsg
#ifdef CHAPTER_DEBUG_SKIP
	// test tool: with var 0x4109 set (an emulator's memory editor), the NES warps to map 0x4111 at x 0x4112, z 0x4109.
	// (a warp straight out of the PC's touchscreen menu leaves the field blank, so it lives here)
	compare 0x4109, 0
	goto_if_eq _nesEnd
	fade_screen 6, 1, 0, 0
	wait_fade
	warp 0x4111, 0, 0x4112, 0x4109, DIR_NORTH // facing north: the walking Pokemon lands behind, not in the way
	fade_screen 6, 1, 1, 0
	wait_fade
_nesEnd:
#endif
	releaseall
	end

scr_seq_P1_REDS_ROOM_002:
	play_se SEQ_SE_DP_SELECT
	lockall
	buffer_players_name 0
	npc_msg 1
	touchscreen_menu_hide
_pcMenu:
	npc_msg 2
	menu_init 1, 1, 0, 1, VAR_SPECIAL_RESULT
	goto_if_set FLAG_P1_GOT_PC_POTION, _pcNoPotion
	menu_item_add 3, 255, 0
_pcNoPotion:
#ifdef CHAPTER_DEBUG_SKIP
	menu_item_add 4, 255, 1
	menu_item_add 8, 255, 4
	menu_item_add 9, 255, 5
#endif
	menu_item_add 5, 255, 2
	menu_exec
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _pcPotion
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _pcCandy
#ifdef CHAPTER_DEBUG_SKIP
	compare VAR_SPECIAL_RESULT, 4
	goto_if_eq _pcTestItem
	compare VAR_SPECIAL_RESULT, 5
	goto_if_eq _pcTestMon
#endif
	goto _pcOff

_pcPotion:
	goto_if_no_item_space ITEM_POTION, 1, _pcFull
	giveitem_no_check ITEM_POTION, 1
	setflag FLAG_P1_GOT_PC_POTION
	goto _pcMenu

_pcCandy:
	goto_if_no_item_space ITEM_RARE_CANDY, 50, _pcFull
	giveitem_no_check ITEM_RARE_CANDY, 50
	goto _pcMenu

#ifdef CHAPTER_DEBUG_SKIP
// test tools: the values come from vars no script uses (vanilla HeartGold never references them), set from
// outside (an emulator's memory editor) (the warp tool is on the NES, above): give item 0x4111 x 0x4112;
// give Pokemon 0x4111 at level 0x4112
_pcTestItem:
	giveitem 0x4111, 0x4112, VAR_SPECIAL_RESULT
	goto _pcMenu

_pcTestMon:
	give_mon 0x4111, 0x4112, 0, 0, 0, VAR_SPECIAL_RESULT
	play_se SEQ_SE_DP_SELECT
	npc_msg 10
	wait_button
	goto _pcMenu
#endif

_pcFull:
	callstd std_bag_is_full
_pcOff:
	touchscreen_menu_show
	closemsg
	releaseall
	end

// HeartGold unlocks the start menu's BAG, TRAINER CARD, SAVE and OPTIONS buttons in Johto's opening (src/start_menu.c
// CheckGotMenuIconI: FLAG_GOT_BAG + 0-3).  Red has them all from the start, like FireRed.
scr_seq_P1_REDS_ROOM_003:
	// first load of a new game: white out to Pallet (HeartGold's default is Mom's house in New Bark) until Red
	// reaches a Pokemon Center, which sets its own spawn as usual
	goto_if_set FLAG_GOT_BAG, _menuFlags
	set_spawn 13 // SPAWN_PALLET
_menuFlags:
	setflag FLAG_GOT_BAG
	setflag FLAG_GOT_TRAINER_CARD
	setflag FLAG_GOT_SAVE_BUTTON
	setflag FLAG_GOT_OPTIONS_BUTTON
	end
