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

// hack: the Vermilion Pokemon Fan Club and the Cerulean bike shop in Part 1 (FireRed).  Hear the Chairman out and he
// hands over the Bicycle itself (QoL: FireRed's Bike Voucher round trip to Cerulean is cut); the bike shop (HeartGold's
// Bike Maniac's house) just admires it, or points you to the Chairman.  events: 579_P1_T06R0301.json, 580_P1_T04R0401.json, text: data/text/910.txt

.data

scrdef scr_seq_P1_FANCLUB_001 // Chairman
scrdef scr_seq_P1_FANCLUB_002 // members
scrdef scr_seq_P1_FANCLUB_003
scrdef scr_seq_P1_FANCLUB_004
scrdef scr_seq_P1_FANCLUB_005 // bike shop clerk
scrdef scr_seq_P1_FANCLUB_006 // bike shop customer
scrdef_end

scr_seq_P1_FANCLUB_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_set FLAG_P1_GOT_BICYCLE, _heardIt
	npc_msg 0
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _noStory
	npc_msg 1
	goto_if_no_item_space ITEM_BIKE, 1, _bagFull
	giveitem_no_check ITEM_BIKE, 1
	setflag FLAG_P1_GOT_BICYCLE
	setflag FLAG_P1_GOT_BIKE_VOUCHER
	npc_msg 3
	goto _done

_noStory:
	npc_msg 4
	goto _done

_heardIt:
	buffer_players_name 0
	npc_msg 5
_done:
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_FANCLUB_002:
	simple_npc_msg 6
	end

scr_seq_P1_FANCLUB_003:
	simple_npc_msg 7
	end

scr_seq_P1_FANCLUB_004:
	simple_npc_msg 8
	end

scr_seq_P1_FANCLUB_005:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_unset FLAG_P1_GOT_BICYCLE, _noBike
	npc_msg 11
	goto _done

_noBike:
	npc_msg 13
	goto _done

_bagFull:
	callstd std_bag_is_full
	closemsg
	releaseall
	end

scr_seq_P1_FANCLUB_006:
	simple_npc_msg 12
	end
