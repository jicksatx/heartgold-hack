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

// hack: Mt. Moon in Part 1 (FireRed).  HeartGold's Mt. Moon is a single small floor, so FireRed's 1F trainers,
// the Team Rocket grunts and Super Nerd Miguel with the two fossils all share it.  events:
// data/eventdata/part1/504_P1_D02R0101.json, text: data/text/866.txt, header scr_seq_00984_P1_D02R0101_hdr.s

.equ OBJ_MIGUEL, 0
.equ OBJ_DOME_FOSSIL, 1
.equ OBJ_HELIX_FOSSIL, 2

.data

scrdef scr_seq_P1_D02R0101_001 // Miguel
scrdef scr_seq_P1_D02R0101_002 // Dome Fossil
scrdef scr_seq_P1_D02R0101_003 // Helix Fossil
scrdef scr_seq_P1_D02R0101_004 // hiker (Zubat)
scrdef scr_seq_P1_D02R0101_005 // fossil digger
scrdef scr_seq_P1_D02R0101_006 // on transition
scrdef_end

scr_seq_P1_D02R0101_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_set FLAG_P1_GOT_FOSSIL, _miguelDone
	goto_if_defeated TRAINER_P1_SUPER_NERD_MIGUEL, _miguelPick
	npc_msg 0
	closemsg
	trainer_battle TRAINER_P1_SUPER_NERD_MIGUEL, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	settrainerflag TRAINER_P1_SUPER_NERD_MIGUEL // a scripted trainer_battle doesn't mark the trainer beaten
_miguelPick:
	npc_msg 1
	goto _talkDone

_miguelDone:
	npc_msg 2
	goto _talkDone

_lost:
	white_out
	releaseall
	end

scr_seq_P1_D02R0101_002:
	play_se SEQ_SE_DP_SELECT
	lockall
	goto_if_unset FLAG_P1_GOT_FOSSIL, _domeCheck
	releaseall
	end

_domeCheck:
	checktrainerflag TRAINER_P1_SUPER_NERD_MIGUEL
	goto_if 0, _notBeaten
	npc_msg 3
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _declined
	goto_if_no_item_space ITEM_DOME_FOSSIL, 1, _bagFull
	setflag FLAG_P1_HIDE_DOME_FOSSIL
	hide_person OBJ_DOME_FOSSIL
	giveitem_no_check ITEM_DOME_FOSSIL, 1
	npc_msg 5
	play_fanfare SEQ_ME_KEYITEM
	wait_fanfare
	setflag FLAG_P1_HIDE_HELIX_FOSSIL
	hide_person OBJ_HELIX_FOSSIL
	setflag FLAG_P1_GOT_FOSSIL
	closemsg
	releaseall
	end

scr_seq_P1_D02R0101_003:
	play_se SEQ_SE_DP_SELECT
	lockall
	goto_if_unset FLAG_P1_GOT_FOSSIL, _helixCheck
	releaseall
	end

_helixCheck:
	checktrainerflag TRAINER_P1_SUPER_NERD_MIGUEL
	goto_if 0, _notBeaten
	npc_msg 4
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _declined
	goto_if_no_item_space ITEM_HELIX_FOSSIL, 1, _bagFull
	setflag FLAG_P1_HIDE_HELIX_FOSSIL
	hide_person OBJ_HELIX_FOSSIL
	giveitem_no_check ITEM_HELIX_FOSSIL, 1
	npc_msg 5
	play_fanfare SEQ_ME_KEYITEM
	wait_fanfare
	setflag FLAG_P1_HIDE_DOME_FOSSIL
	hide_person OBJ_DOME_FOSSIL
	setflag FLAG_P1_GOT_FOSSIL
	closemsg
	releaseall
	end

_notBeaten:
	npc_msg 8
	goto _talkDone

_declined:
	closemsg
	releaseall
	end

_bagFull:
	callstd std_bag_is_full
	closemsg
	releaseall
	end

scr_seq_P1_D02R0101_004:
	simple_npc_msg 6
	end

scr_seq_P1_D02R0101_005:
	simple_npc_msg 7
	end

scr_seq_P1_D02R0101_006:
	goto_if_set FLAG_P1_GOT_FOSSIL, _fossilsGone
	clearflag FLAG_P1_HIDE_DOME_FOSSIL
	clearflag FLAG_P1_HIDE_HELIX_FOSSIL
	end

_fossilsGone:
	setflag FLAG_P1_HIDE_DOME_FOSSIL
	setflag FLAG_P1_HIDE_HELIX_FOSSIL
	end

_talkDone:
	wait_button
	closemsg
	releaseall
	end
