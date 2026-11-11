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

// hack: Celadon Game Corner in Part 2.  Part 2 now uses the Japanese release's full Game Corner room (map 381, the
// same room as Part 1's Rocket Game Corner) instead of HeartGold's small US room: the left bank plays Voltorb Flip and
// the right bank is Platinum's slot machine game (slots/, overlay 152; casino_game N, 2 = machine N).  Mr. Game and
// the gambler keep HeartGold's lines.  events: data/eventdata/part1/683_P2_T07R0401.json, text: 511.txt (HeartGold's
// Celadon Game Corner text + lines 15-17).  Celadon City's door: data/eventdata/part1/682_P2_T07.json.

.data

scrdef scr_seq_P2_T07R0401_001 // Mr. Game (Coin Case)
scrdef scr_seq_P2_T07R0401_002 // gambler
scrdef scr_seq_P2_T07R0401_003 // Voltorb Flip machines
scrdef scr_seq_P2_T07R0401_004 // slot machines 0-6
scrdef scr_seq_P2_T07R0401_005
scrdef scr_seq_P2_T07R0401_006
scrdef scr_seq_P2_T07R0401_007
scrdef scr_seq_P2_T07R0401_008
scrdef scr_seq_P2_T07R0401_009
scrdef scr_seq_P2_T07R0401_010
scrdef_end

// HeartGold's Mr. Game (scr_seq_0806 script 003): gives the Coin Case, then cheers you on
scr_seq_P2_T07R0401_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	hasitem ITEM_COIN_CASE, 1, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _gameNoCase
	compare VAR_TEMP_x4001, 0
	goto_if_ne _game2
	npc_msg 6
	setvar VAR_TEMP_x4001, 1
	goto _gameEnd

_game2:
	compare VAR_TEMP_x4001, 1
	goto_if_ne _game3
	npc_msg 7
	goto _gameEnd

_game3:
	npc_msg 8
_gameEnd:
	wait_button
	closemsg
	releaseall
	end

_gameNoCase:
	compare VAR_TEMP_x4001, 0
	goto_if_ne _gameAgain
	npc_msg 0
	goto _gameAsk

_gameAgain:
	npc_msg 9
_gameAsk:
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _gameDecline
	npc_msg 3
	setvar VAR_TEMP_x4001, 1
	giveitem_no_check ITEM_COIN_CASE, 1
	npc_msg 4
	goto _gameEnd

_gameDecline:
	setvar VAR_TEMP_x4001, 1
	npc_msg 5
	goto _gameEnd

scr_seq_P2_T07R0401_002:
	simple_npc_msg 14
	end

scr_seq_P2_T07R0401_003:
	play_se SEQ_SE_DP_SELECT
	lockall
	hasitem ITEM_COIN_CASE, 1, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _noCase
	npc_msg 16
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _no
	closemsg
	fade_screen 6, 1, 0, 0
	wait_fade
	casino_game 0, 1
	goto _gameDone

scr_seq_P2_T07R0401_004:
	call _slotAsk
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _no
	casino_game 0, 2
	goto _gameDone

scr_seq_P2_T07R0401_005:
	call _slotAsk
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _no
	casino_game 1, 2
	goto _gameDone

scr_seq_P2_T07R0401_006:
	call _slotAsk
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _no
	casino_game 2, 2
	goto _gameDone

scr_seq_P2_T07R0401_007:
	call _slotAsk
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _no
	casino_game 3, 2
	goto _gameDone

scr_seq_P2_T07R0401_008:
	call _slotAsk
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _no
	casino_game 4, 2
	goto _gameDone

scr_seq_P2_T07R0401_009:
	call _slotAsk
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _no
	casino_game 5, 2
	goto _gameDone

scr_seq_P2_T07R0401_010:
	call _slotAsk
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _no
	casino_game 6, 2
	goto _gameDone

_slotAsk:
	play_se SEQ_SE_DP_SELECT
	lockall
	hasitem ITEM_COIN_CASE, 1, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _noCase
	npc_msg 17
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _slotAskEnd
	closemsg
	fade_screen 6, 1, 0, 0
	wait_fade
_slotAskEnd:
	return

_gameDone:
	restore_overworld
	fade_screen 6, 1, 1, 0
	wait_fade
	releaseall
	end

_no:
	closemsg
	releaseall
	end

_noCase:
	npc_msg 15
	wait_button
	closemsg
	releaseall
	end
	.balign 4
