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

// hack: Celadon's Game Corner Prize Room in Part 1 (FireRed).  The five prize Pokemon are randomized per save
// (single-stage Pokemon by price band, src/prize_pool.c via "get_starter_choice VAR_P1_PRIZE"); the TMs are FireRed's.
// events: 561_P1_T07R0501.json, text: data/text/903.txt

.data

scrdef scr_seq_P1_T07R0501_001 // clerk: prize Pokemon
scrdef scr_seq_P1_T07R0501_002 // clerk: prize TMs
scrdef scr_seq_P1_T07R0501_003 // gentleman
scrdef scr_seq_P1_T07R0501_004 // man
scrdef scr_seq_P1_T07R0501_005 // prize Pokemon display
scrdef scr_seq_P1_T07R0501_006 // prize TM display
scrdef_end

// buffers this save's five prize Pokemon into slots 0-4
_bufferPrizes:
	setvar VAR_P1_PRIZE, 0
	get_starter_choice VAR_P1_PRIZE
	buffer_species_name 0, VAR_P1_PRIZE, 0, 0
	setvar VAR_P1_PRIZE, 1
	get_starter_choice VAR_P1_PRIZE
	buffer_species_name 1, VAR_P1_PRIZE, 0, 0
	setvar VAR_P1_PRIZE, 2
	get_starter_choice VAR_P1_PRIZE
	buffer_species_name 2, VAR_P1_PRIZE, 0, 0
	setvar VAR_P1_PRIZE, 3
	get_starter_choice VAR_P1_PRIZE
	buffer_species_name 3, VAR_P1_PRIZE, 0, 0
	setvar VAR_P1_PRIZE, 4
	get_starter_choice VAR_P1_PRIZE
	buffer_species_name 4, VAR_P1_PRIZE, 0, 0
	return

scr_seq_P1_T07R0501_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	hasitem ITEM_COIN_CASE, 1, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _noCase
	call _bufferPrizes
	npc_msg 0
	script_overlay_cmd 3, 0
	touchscreen_menu_hide
	scrcmd_116 0, 20, 2
_monMenu:
	npc_msg 1
	menu_init 1, 1, 0, 1, VAR_TEMP_x4000
	menu_item_add 3, 255, 0
	menu_item_add 4, 255, 1
	menu_item_add 5, 255, 2
	menu_item_add 6, 255, 3
	menu_item_add 7, 255, 4
	menu_item_add 8, 255, 5
	menu_exec
	compare VAR_TEMP_x4000, 4
	goto_if_gt _prizeDone
	copyvar VAR_P1_PRIZE, VAR_TEMP_x4000
	get_starter_choice VAR_P1_PRIZE
	copyvar VAR_TEMP_x4002, VAR_P1_PRIZE
	setvar VAR_TEMP_x4003, 180
	setvar VAR_TEMP_x4004, 9
	compare VAR_TEMP_x4000, 1
	goto_if_ne _p2
	setvar VAR_TEMP_x4003, 500
	setvar VAR_TEMP_x4004, 8
_p2:
	compare VAR_TEMP_x4000, 2
	goto_if_ne _p3
	setvar VAR_TEMP_x4003, 2800
	setvar VAR_TEMP_x4004, 18
_p3:
	compare VAR_TEMP_x4000, 3
	goto_if_ne _p4
	setvar VAR_TEMP_x4003, 5500
	setvar VAR_TEMP_x4004, 25
_p4:
	compare VAR_TEMP_x4000, 4
	goto_if_ne _p5
	setvar VAR_TEMP_x4003, 9999
	setvar VAR_TEMP_x4004, 26
_p5:
	get_party_count VAR_SPECIAL_x8005
	compare VAR_SPECIAL_x8005, 6
	goto_if_eq _partyFull
	buffer_species_name 5, VAR_TEMP_x4002, 0, 0
	npc_msg 9
	getmenuchoice VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _monMenu
	get_coin_amount VAR_SPECIAL_x8006
	compare_var_to_var VAR_SPECIAL_x8006, VAR_TEMP_x4003
	goto_if_lt _needCoins
	take_coins VAR_TEMP_x4003
	scrcmd_118 0
	play_se SEQ_SE_DP_REGI
	npc_msg 12
	give_mon VAR_TEMP_x4002, VAR_TEMP_x4004, 0, 0, 0, VAR_SPECIAL_RESULT
	buffer_players_name 0
	play_fanfare SEQ_ME_POKEGET
	npc_msg 13
	wait_fanfare
	goto _prizeEnd

_needCoins:
	npc_msg 10
	goto _prizeEnd

_partyFull:
	npc_msg 11
_prizeEnd:
	wait_button
_prizeDone:
	closemsg
	touchscreen_menu_show
	scrcmd_117
	script_overlay_cmd 3, 1
	releaseall
	end

_noCase:
	npc_msg 2
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_T07R0501_002:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	hasitem ITEM_COIN_CASE, 1, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _noCase
	buffer_item_name 0, ITEM_TM013
	buffer_item_name 1, ITEM_TM023
	buffer_item_name 2, ITEM_TM024
	buffer_item_name 3, ITEM_TM030
	buffer_item_name 4, ITEM_TM035
	npc_msg 0
	script_overlay_cmd 3, 0
	touchscreen_menu_hide
	scrcmd_116 0, 20, 2
_tmMenu:
	npc_msg 1
	menu_init 1, 1, 0, 1, VAR_TEMP_x4000
	menu_item_add 14, 255, 0
	menu_item_add 15, 255, 1
	menu_item_add 16, 255, 2
	menu_item_add 17, 255, 3
	menu_item_add 18, 255, 4
	menu_item_add 8, 255, 5
	menu_exec
	compare VAR_TEMP_x4000, 4
	goto_if_gt _prizeDone
	setvar VAR_TEMP_x4002, ITEM_TM013
	setvar VAR_TEMP_x4003, 4000
	compare VAR_TEMP_x4000, 1
	goto_if_ne _t2
	setvar VAR_TEMP_x4002, ITEM_TM023
	setvar VAR_TEMP_x4003, 3500
_t2:
	compare VAR_TEMP_x4000, 2
	goto_if_ne _t3
	setvar VAR_TEMP_x4002, ITEM_TM024
_t3:
	compare VAR_TEMP_x4000, 3
	goto_if_ne _t4
	setvar VAR_TEMP_x4002, ITEM_TM030
	setvar VAR_TEMP_x4003, 4500
_t4:
	compare VAR_TEMP_x4000, 4
	goto_if_ne _t5
	setvar VAR_TEMP_x4002, ITEM_TM035
_t5:
	buffer_item_name 5, VAR_TEMP_x4002
	npc_msg 19
	getmenuchoice VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _tmMenu
	get_coin_amount VAR_SPECIAL_x8006
	compare_var_to_var VAR_SPECIAL_x8006, VAR_TEMP_x4003
	goto_if_lt _needCoins
	hasspaceforitem VAR_TEMP_x4002, 1, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _bagFull
	take_coins VAR_TEMP_x4003
	scrcmd_118 0
	play_se SEQ_SE_DP_REGI
	npc_msg 12
	giveitem VAR_TEMP_x4002, 1, VAR_SPECIAL_RESULT
	buffer_players_name 0
	npc_msg 20
	goto _prizeEnd

_bagFull:
	npc_msg 21
	goto _prizeEnd

scr_seq_P1_T07R0501_003:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	call _bufferPrizes
	npc_msg 23
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_T07R0501_004:
	simple_npc_msg 24
	end

scr_seq_P1_T07R0501_005:
	play_se SEQ_SE_DP_SELECT
	lockall
	call _bufferPrizes
	npc_msg 22
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_T07R0501_006:
	simple_npc_msg 25
	end
