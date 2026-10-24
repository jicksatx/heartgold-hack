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

// hack: the Pokemon Mansion in Part 1 (FireRed) = HeartGold's Burned Tower (1F stands for 1F/2F, B1F for 3F/B1F):
// FireRed's burglars and scientists, the four diary pages, FireRed's items and the Secret Key that opens the Gym.
// (FireRed's statue switches and their doors have no stand-in.)  events: 597 (1F), 598 (B1F), text: data/text/913.txt

.data

scrdef scr_seq_P1_MANSION_001 // diaries
scrdef scr_seq_P1_MANSION_002
scrdef scr_seq_P1_MANSION_003
scrdef scr_seq_P1_MANSION_004
scrdef scr_seq_P1_MANSION_005 // Secret Key
scrdef scr_seq_P1_MANSION_006 // CARBOS
scrdef scr_seq_P1_MANSION_007 // ESCAPE_ROPE
scrdef scr_seq_P1_MANSION_008 // PROTEIN
scrdef scr_seq_P1_MANSION_009 // CALCIUM
scrdef scr_seq_P1_MANSION_010 // ZINC
scrdef scr_seq_P1_MANSION_011 // HP_UP
scrdef scr_seq_P1_MANSION_012 // MAX_POTION
scrdef scr_seq_P1_MANSION_013 // IRON
scrdef scr_seq_P1_MANSION_014 // TM14
scrdef scr_seq_P1_MANSION_015 // TM22
scrdef scr_seq_P1_MANSION_016 // FULL_RESTORE
scrdef_end

scr_seq_P1_MANSION_001:
	simple_npc_msg 0
	end

scr_seq_P1_MANSION_002:
	simple_npc_msg 1
	end

scr_seq_P1_MANSION_003:
	simple_npc_msg 2
	end

scr_seq_P1_MANSION_004:
	simple_npc_msg 3
	end

scr_seq_P1_MANSION_005:
	play_se SEQ_SE_DP_SELECT
	lockall
	hide_person VAR_SPECIAL_LAST_TALKED
	setflag FLAG_P1_HIDE_SECRET_KEY
	setflag FLAG_P1_SECRET_KEY
	buffer_players_name 0
	play_fanfare SEQ_ME_KEYITEM
	npc_msg 4
	wait_fanfare
	npc_msg 5
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_MANSION_006:
	play_se SEQ_SE_DP_SELECT
	lockall
	goto_if_no_item_space ITEM_CARBOS, 1, _ballFull
	hide_person VAR_SPECIAL_LAST_TALKED
	setflag FLAG_P1_ITEM_MANSION_CARBOS
	giveitem_no_check ITEM_CARBOS, 1
	closemsg
	releaseall
	end

scr_seq_P1_MANSION_007:
	play_se SEQ_SE_DP_SELECT
	lockall
	goto_if_no_item_space ITEM_ESCAPE_ROPE, 1, _ballFull
	hide_person VAR_SPECIAL_LAST_TALKED
	setflag FLAG_P1_ITEM_MANSION_ESCAPE_ROPE
	giveitem_no_check ITEM_ESCAPE_ROPE, 1
	closemsg
	releaseall
	end

scr_seq_P1_MANSION_008:
	play_se SEQ_SE_DP_SELECT
	lockall
	goto_if_no_item_space ITEM_PROTEIN, 1, _ballFull
	hide_person VAR_SPECIAL_LAST_TALKED
	setflag FLAG_P1_ITEM_MANSION_PROTEIN
	giveitem_no_check ITEM_PROTEIN, 1
	closemsg
	releaseall
	end

scr_seq_P1_MANSION_009:
	play_se SEQ_SE_DP_SELECT
	lockall
	goto_if_no_item_space ITEM_CALCIUM, 1, _ballFull
	hide_person VAR_SPECIAL_LAST_TALKED
	setflag FLAG_P1_ITEM_MANSION_CALCIUM
	giveitem_no_check ITEM_CALCIUM, 1
	closemsg
	releaseall
	end

scr_seq_P1_MANSION_010:
	play_se SEQ_SE_DP_SELECT
	lockall
	goto_if_no_item_space ITEM_ZINC, 1, _ballFull
	hide_person VAR_SPECIAL_LAST_TALKED
	setflag FLAG_P1_ITEM_MANSION_ZINC
	giveitem_no_check ITEM_ZINC, 1
	closemsg
	releaseall
	end

scr_seq_P1_MANSION_011:
	play_se SEQ_SE_DP_SELECT
	lockall
	goto_if_no_item_space ITEM_HP_UP, 1, _ballFull
	hide_person VAR_SPECIAL_LAST_TALKED
	setflag FLAG_P1_ITEM_MANSION_HP_UP
	giveitem_no_check ITEM_HP_UP, 1
	closemsg
	releaseall
	end

scr_seq_P1_MANSION_012:
	play_se SEQ_SE_DP_SELECT
	lockall
	goto_if_no_item_space ITEM_MAX_POTION, 1, _ballFull
	hide_person VAR_SPECIAL_LAST_TALKED
	setflag FLAG_P1_ITEM_MANSION_MAX_POTION
	giveitem_no_check ITEM_MAX_POTION, 1
	closemsg
	releaseall
	end

scr_seq_P1_MANSION_013:
	play_se SEQ_SE_DP_SELECT
	lockall
	goto_if_no_item_space ITEM_IRON, 1, _ballFull
	hide_person VAR_SPECIAL_LAST_TALKED
	setflag FLAG_P1_ITEM_MANSION_IRON
	giveitem_no_check ITEM_IRON, 1
	closemsg
	releaseall
	end

scr_seq_P1_MANSION_014:
	play_se SEQ_SE_DP_SELECT
	lockall
	goto_if_no_item_space ITEM_TM014, 1, _ballFull
	hide_person VAR_SPECIAL_LAST_TALKED
	setflag FLAG_P1_ITEM_MANSION_TM14
	giveitem_no_check ITEM_TM014, 1
	closemsg
	releaseall
	end

scr_seq_P1_MANSION_015:
	play_se SEQ_SE_DP_SELECT
	lockall
	goto_if_no_item_space ITEM_TM022, 1, _ballFull
	hide_person VAR_SPECIAL_LAST_TALKED
	setflag FLAG_P1_ITEM_MANSION_TM22
	giveitem_no_check ITEM_TM022, 1
	closemsg
	releaseall
	end

scr_seq_P1_MANSION_016:
	play_se SEQ_SE_DP_SELECT
	lockall
	goto_if_no_item_space ITEM_FULL_RESTORE, 1, _ballFull
	hide_person VAR_SPECIAL_LAST_TALKED
	setflag FLAG_P1_ITEM_MANSION_FULL_RESTORE
	giveitem_no_check ITEM_FULL_RESTORE, 1
	closemsg
	releaseall
	end

_ballFull:
	callstd std_bag_is_full
	closemsg
	releaseall
	end
