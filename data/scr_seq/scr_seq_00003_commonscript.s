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


// text archive to grab from: 040.txt

.data


scrdef scr_seq_0003_000
scrdef scr_seq_0003_001
scrdef scr_seq_0003_002
scrdef scr_seq_0003_003
scrdef scr_seq_0003_004
scrdef scr_seq_0003_005
scrdef scr_seq_0003_006
scrdef scr_seq_0003_007
scrdef scr_seq_0003_008
scrdef scr_seq_0003_009
scrdef scr_seq_0003_010
scrdef scr_seq_0003_011
scrdef scr_seq_0003_012
scrdef scr_seq_0003_013
scrdef scr_seq_0003_014
scrdef scr_seq_0003_015
scrdef scr_seq_0003_016
scrdef scr_seq_0003_017
scrdef scr_seq_0003_018
scrdef scr_seq_0003_019
scrdef scr_seq_0003_020
scrdef scr_seq_0003_021
scrdef scr_seq_0003_022
scrdef scr_seq_0003_023
scrdef scr_seq_0003_024
scrdef scr_seq_0003_025
scrdef scr_seq_0003_026
scrdef scr_seq_0003_027
scrdef scr_seq_0003_028
scrdef scr_seq_0003_029
scrdef scr_seq_0003_030
scrdef scr_seq_0003_031
scrdef scr_seq_0003_032
scrdef scr_seq_0003_033_give_item_verbose
scrdef scr_seq_0003_034
scrdef scr_seq_0003_035
scrdef scr_seq_0003_036
scrdef scr_seq_0003_037
scrdef scr_seq_0003_038
scrdef scr_seq_0003_039
scrdef scr_seq_0003_040
scrdef scr_seq_0003_041
scrdef scr_seq_0003_042
scrdef scr_seq_0003_043
scrdef scr_seq_0003_044
scrdef scr_seq_0003_045
scrdef scr_seq_0003_046
scrdef scr_seq_0003_047
scrdef scr_seq_0003_048
scrdef scr_seq_0003_049
scrdef scr_seq_0003_050
scrdef scr_seq_0003_051
scrdef scr_seq_0003_052
scrdef scr_seq_0003_053
scrdef scr_seq_0003_054
scrdef scr_seq_0003_055
scrdef scr_seq_0003_056
scrdef scr_seq_0003_057
scrdef scr_seq_0003_058
scrdef scr_seq_0003_059
scrdef scr_seq_0003_060
scrdef scr_seq_0003_061
scrdef scr_seq_0003_062
scrdef scr_seq_0003_063
scrdef scr_seq_0003_064
scrdef scr_seq_0003_065
scrdef scr_seq_0003_066
scrdef scr_seq_0003_067
scrdef scr_seq_0003_068
scrdef scr_seq_0003_069
scrdef scr_seq_0003_070
scrdef scr_seq_0003_071
scrdef scr_seq_0003_072_repels
scrdef scr_seq_0003_073_autobattle_testing
scrdef scr_seq_0003_074_move_relearner
scrdef scr_seq_0003_075_nuzlocke_game_over
scrdef scr_seq_0003_p1ball_2076
scrdef scr_seq_0003_p1ball_2077
scrdef scr_seq_0003_p1ball_2078
scrdef scr_seq_0003_p1ball_2079
scrdef scr_seq_0003_p1ball_2080
scrdef scr_seq_0003_p1ball_2081
scrdef scr_seq_0003_p1ball_2082
scrdef scr_seq_0003_p1ball_2083
scrdef scr_seq_0003_p1ball_2084
scrdef scr_seq_0003_p1ball_2085
scrdef scr_seq_0003_p1ball_2086
scrdef scr_seq_0003_p1ball_2087
scrdef scr_seq_0003_p1ball_2088
scrdef scr_seq_0003_p1ball_2089
scrdef scr_seq_0003_p1ball_2090
scrdef scr_seq_0003_p1ball_2091
scrdef scr_seq_0003_p1ball_2092
scrdef scr_seq_0003_p1ball_2093
scrdef scr_seq_0003_p1ball_2094
scrdef scr_seq_0003_p1ball_2095
scrdef scr_seq_0003_p1ball_2096
scrdef scr_seq_0003_p1ball_2097
scrdef scr_seq_0003_p1ball_2098
scrdef scr_seq_0003_p1ball_2099
scrdef scr_seq_0003_p1ball_2100
scrdef scr_seq_0003_p1ball_2101
scrdef scr_seq_0003_p1ball_2102
scrdef scr_seq_0003_p1ball_2103
scrdef scr_seq_0003_p1ball_2104
scrdef scr_seq_0003_p1ball_2105
scrdef scr_seq_0003_p1ball_2106
scrdef scr_seq_0003_p1ball_2107
scrdef scr_seq_0003_p1ball_2108
scrdef scr_seq_0003_p1ball_2109
scrdef scr_seq_0003_p1ball_2110
scrdef scr_seq_0003_p1ball_2111
scrdef scr_seq_0003_p1ball_2112
scrdef scr_seq_0003_p1ball_2113
scrdef scr_seq_0003_p1ball_2114
scrdef scr_seq_0003_p1ball_2115
scrdef scr_seq_0003_p1ball_2116
scrdef scr_seq_0003_p1ball_2117
scrdef scr_seq_0003_p1ball_2118
scrdef scr_seq_0003_p1ball_2119
scrdef scr_seq_0003_p1ball_2120
scrdef scr_seq_0003_p1ball_2121
scrdef scr_seq_0003_p1ball_2122
scrdef scr_seq_0003_p1ball_2123
scrdef scr_seq_0003_p1ball_2124
scrdef scr_seq_0003_p1ball_2125
scrdef scr_seq_0003_p1ball_2126
scrdef scr_seq_0003_p1ball_2127
scrdef scr_seq_0003_p1ball_2128
scrdef scr_seq_0003_p1ball_2129
scrdef scr_seq_0003_p1ball_2130
scrdef scr_seq_0003_p1ball_2131
scrdef scr_seq_0003_p1ball_2132
scrdef scr_seq_0003_p1ball_2133
scrdef scr_seq_0003_p1ball_2134
scrdef scr_seq_0003_p1ball_2135
scrdef scr_seq_0003_p1ball_2136
scrdef scr_seq_0003_p1ball_2137
scrdef scr_seq_0003_p1ball_2138
scrdef scr_seq_0003_p1ball_2139
scrdef scr_seq_0003_p1ball_2140
scrdef scr_seq_0003_p1ball_2141
scrdef scr_seq_0003_p1ball_2142
scrdef scr_seq_0003_p1ball_2143
scrdef scr_seq_0003_p1ball_2144
scrdef scr_seq_0003_p1ball_2145
scrdef scr_seq_0003_p1ball_2146
scrdef scr_seq_0003_p1ball_2147
scrdef scr_seq_0003_p1ball_2148
scrdef scr_seq_0003_p1ball_2149
scrdef scr_seq_0003_p1ball_2150
scrdef scr_seq_0003_p1ball_2151
scrdef scr_seq_0003_p1ball_2152
scrdef scr_seq_0003_p1ball_2153
scrdef scr_seq_0003_p1ball_2154
scrdef scr_seq_0003_p1ball_2155
scrdef scr_seq_0003_p1ball_2156
scrdef scr_seq_0003_p1ball_2157
scrdef scr_seq_0003_p1ball_2158
scrdef scr_seq_0003_p1ball_2159
scrdef scr_seq_0003_p1ball_2160
scrdef scr_seq_0003_p1ball_2161
scrdef scr_seq_0003_p1ball_2162
scrdef scr_seq_0003_p1ball_2163
scrdef scr_seq_0003_p1ball_2164
scrdef scr_seq_0003_p1ball_2165
scrdef scr_seq_0003_p1ball_2166
scrdef scr_seq_0003_p1ball_2167
scrdef scr_seq_0003_p1ball_2168
scrdef scr_seq_0003_p1ball_2169
scrdef scr_seq_0003_p1ball_2170
scrdef scr_seq_0003_p1ball_2171
scrdef scr_seq_0003_p1ball_2172
scrdef scr_seq_0003_p1ball_2173
scrdef scr_seq_0003_p1ball_2174
scrdef scr_seq_0003_p1ball_2175
scrdef scr_seq_0003_p1ball_2176
scrdef scr_seq_0003_p1ball_2177
scrdef scr_seq_0003_p1ball_2178
scrdef scr_seq_0003_p1ball_2179
scrdef scr_seq_0003_p1ball_2180
scrdef scr_seq_0003_p1ball_2181
scrdef scr_seq_0003_p1ball_2182
scrdef scr_seq_0003_p1ball_2183
scrdef scr_seq_0003_p1ball_2184
scrdef scr_seq_0003_p1ball_2185
scrdef scr_seq_0003_p1ball_2186
scrdef scr_seq_0003_p1ball_2187
scrdef scr_seq_0003_p1ball_2188
scrdef scr_seq_0003_p1ball_2189
scrdef scr_seq_0003_p1ball_2190
scrdef scr_seq_0003_p1ball_2191
scrdef scr_seq_0003_p1ball_2192
scrdef scr_seq_0003_p1ball_2193
scrdef scr_seq_0003_p1ball_2194
scrdef scr_seq_0003_p1ball_2195
scrdef scr_seq_0003_p1ball_2196
scrdef scr_seq_0003_p1ball_2197
scrdef scr_seq_0003_p1ball_2198
scrdef scr_seq_0003_p1ball_2199
scrdef scr_seq_0003_p1ball_2200
scrdef scr_seq_0003_p1ball_2201
scrdef scr_seq_0003_p1ball_2202
scrdef scr_seq_0003_p1ball_2203
scrdef scr_seq_0003_p1ball_2204
scrdef scr_seq_0003_p1ball_2205
scrdef_end

scr_seq_0003_002:
    play_se SEQ_SE_DP_SELECT
    lockall
    faceplayer
    get_trcard_stars VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 4
    goto_if_ge _03E3
    setvar VAR_SPECIAL_x8004, 0
    scrcmd_379 VAR_SPECIAL_RESULT
    debugwatch VAR_SPECIAL_RESULT
    setvar VAR_SPECIAL_x8004, 83
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _0175
    setvar VAR_SPECIAL_x8004, 84
    compare VAR_SPECIAL_RESULT, 1
    goto_if_eq _0175
    setvar VAR_SPECIAL_x8004, 0
_0175:
    non_npc_msg_var VAR_SPECIAL_x8004
    touchscreen_menu_hide
    getmenuchoice VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _01AA
    compare VAR_SPECIAL_RESULT, 1
    goto_if_eq _019B
    end

_019B:
    npc_msg 3
    wait_button_or_walk_away
    touchscreen_menu_show
    closemsg
    releaseall
    endstd
    end

_01AA:
    get_player_state VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, PLAYER_STATE_ROCKET
    goto_if_ne _01C5
    set_avatar_bits PLAYER_TRANSITION_ROCKET_HEAL
    goto _01C9

_01C5:
    set_avatar_bits PLAYER_TRANSITION_HEAL
_01C9:
    update_avatar_state
    apply_movement obj_player, _0460
    wait_movement
    scrcmd_599
    get_trcard_stars VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 4
    call_if_ge _0211
    compare VAR_SPECIAL_RESULT, 4
    call_if_lt _020C
    call _0216
    goto_if_unset FLAG_UNK_065, _034D
    goto _023A

_020C:
    npc_msg 1
    return

_0211:
    npc_msg 7
    return

_0216:
    apply_movement VAR_SPECIAL_x8007, _1064
    wait_movement
    party_count_not_egg VAR_SPECIAL_x8006
    pokecen_anim VAR_SPECIAL_x8006
    apply_movement VAR_SPECIAL_x8007, _107C
    wait_movement
    get_party_lead_alive VAR_SPECIAL_x8008
    heal_party
    return

_023A:
    compare VAR_SPECIAL_x8004, 1
    goto_if_eq _02CB
    npc_msg 2
    apply_movement obj_player, _0468
    wait_movement
    get_player_state VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, PLAYER_STATE_ROCKET
    goto_if_ne _026F
    set_avatar_bits PLAYER_TRANSITION_ROCKET
    goto _0273

_026F:
    set_avatar_bits PLAYER_TRANSITION_WALKING
_0273:
    update_avatar_state
    get_party_lead_alive VAR_SPECIAL_x8009
    compare VAR_SPECIAL_x8008, VAR_SPECIAL_x8009
    goto_if_eq _02B2
    wait 15, VAR_SPECIAL_x800A
    fade_screen 6, 1, 0, RGB_BLACK
    wait_fade
    closemsg
    scrcmd_436
    restore_overworld
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    bufferpartymonnick 0, VAR_SPECIAL_x8009
    npc_msg 102
_02B2:
    apply_movement VAR_SPECIAL_x8007, _0454
    wait_movement
    npc_msg 3
    wait_button_or_walk_away
    closemsg
    touchscreen_menu_show
    releaseall
    endstd
    end

_02CB:
    npc_msg 8
    apply_movement obj_player, _0468
    wait_movement
    get_player_state VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, PLAYER_STATE_ROCKET
    goto_if_ne _02F3
    set_avatar_bits PLAYER_TRANSITION_ROCKET
    goto _02F7

_02F3:
    set_avatar_bits PLAYER_TRANSITION_WALKING
_02F7:
    update_avatar_state
    get_party_lead_alive VAR_SPECIAL_x8009
    compare VAR_SPECIAL_x8008, VAR_SPECIAL_x8009
    goto_if_eq _0336
    wait 15, VAR_SPECIAL_x800A
    fade_screen 6, 1, 0, RGB_BLACK
    wait_fade
    closemsg
    scrcmd_436
    restore_overworld
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    bufferpartymonnick 0, VAR_SPECIAL_x8009
    npc_msg 102
_0336:
    apply_movement VAR_SPECIAL_x8007, _0454
    wait_movement
    npc_msg 9
    wait_button_or_walk_away
    closemsg
    releaseall
    endstd
    end

_034D:
    party_has_pokerus VAR_SPECIAL_x8006
    compare VAR_SPECIAL_x8006, 1
    goto_if_eq _0364
    goto _023A

_0364:
    setflag FLAG_UNK_065
    scrcmd_148 1, 0
    apply_movement obj_player, _0468
    wait_movement
    get_player_state VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, PLAYER_STATE_ROCKET
    goto_if_ne _0391
    set_avatar_bits PLAYER_TRANSITION_ROCKET
    goto _0395

_0391:
    set_avatar_bits PLAYER_TRANSITION_WALKING
_0395:
    get_party_lead_alive VAR_SPECIAL_x8009
    compare VAR_SPECIAL_x8008, VAR_SPECIAL_x8009
    goto_if_eq _03D4
    update_avatar_state
    wait 15, VAR_SPECIAL_x800A
    fade_screen 6, 1, 0, RGB_BLACK
    wait_fade
    closemsg
    scrcmd_436
    restore_overworld
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    bufferpartymonnick 0, VAR_SPECIAL_x8009
    npc_msg 102
_03D4:
    npc_msg 10
    wait_button_or_walk_away
    closemsg
    touchscreen_menu_show
    releaseall
    endstd
    end

_03E3:
    goto_if_set FLAG_NURSE_NOTICED_TRAINER_CARD, _041D
    setflag FLAG_NURSE_NOTICED_TRAINER_CARD
    npc_msg 4
    buffer_players_name 0
    npc_msg 5
    touchscreen_menu_hide
    getmenuchoice VAR_SPECIAL_RESULT
    touchscreen_menu_show
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _0445
    npc_msg 9
    wait_button_or_walk_away
    closemsg
    releaseall
    endstd
    end

_041D:
    buffer_players_name 0
    npc_msg 6
    touchscreen_menu_hide
    getmenuchoice VAR_SPECIAL_RESULT
    touchscreen_menu_show
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _0445
    npc_msg 9
    wait_button_or_walk_away
    closemsg
    releaseall
    endstd
    end

_0445:
    setvar VAR_SPECIAL_x8004, 1
    goto _01AA

.balign 4

_0454:
    step 100, 1
    step 62, 1
    step_end

_0460:
    step 102, 1
    step_end

_0468:
    step 104, 1
    step_end


scr_seq_0003_069:
    fade_screen 6, 1, 0, RGB_BLACK
    wait_fade
    scrcmd_436
    play_fanfare SEQ_ME_ASA
    wait_fanfare
    heal_party
    restore_overworld
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    endstd
    end

scr_seq_0003_000:
    switch VAR_SPECIAL_RESULT
    case 0, _04D6
    case 1, _04DD
    scrcmd_060 VAR_SPECIAL_RESULT
    switch VAR_SPECIAL_RESULT
    case 1, _04DD
    scrcmd_057 2
    endstd
    end

_04D6:
    scrcmd_057 2
    endstd
    end

_04DD:
    scrcmd_057 4
    scrcmd_058
    scrcmd_061
    endstd
    end

scr_seq_0003_001:
    call _04F2
    endstd
    end

_04F2:
    getitempocket VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
    switch VAR_SPECIAL_RESULT
    case 7, _0574
    case 0, _0568
    case 4, _0568
    case 1, _0568
    case 2, _0568
    case 6, _0568
    case 5, _057A
    case 3, _056E
    end

_0568:
    play_fanfare SEQ_ME_ITEM
    return

_056E:
    play_fanfare SEQ_ME_WAZA
    return

_0574:
    play_fanfare SEQ_ME_KEYITEM
    return

_057A:
    play_fanfare SEQ_ME_HYOUKA2
    return
    .byte 0x15, 0x00, 0x02, 0x00
scr_seq_0003_003:
    scrcmd_609
    lockall
    get_party_count VAR_SPECIAL_x8004
    setvar VAR_SPECIAL_x8005, 0
_0592:
    survive_poisoning VAR_SPECIAL_RESULT, VAR_SPECIAL_x8005
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _05AD
    bufferpartymonnick 0, VAR_SPECIAL_x8005
    npc_msg 53
_05AD:
    addvar VAR_SPECIAL_x8005, 1
    compare VAR_SPECIAL_x8004, VAR_SPECIAL_x8005
    goto_if_ne _0592
    count_alive_mons VAR_SPECIAL_RESULT, 6
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _05F5
    closemsg
    releaseall
    end

scr_seq_0003_004:
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    wait_button
    fade_screen 6, 1, 0, RGB_BLACK
    wait_fade
    end

_05F5:
    buffer_players_name 0
    npc_msg 11
    wait_button
    closemsg
    fade_out_bgm 0, 10
    fade_screen 6, 1, 0, RGB_BLACK
    wait_fade
    scrcmd_436
    overworld_white_out
    end

scr_seq_0003_005:
    clearflag FLAG_MAPTEMP_020
    call _0646
    scrcmd_347 VAR_SPECIAL_RESULT
    closemsg
    end

scr_seq_0003_024:
    npc_msg 20
    wait_button
    closemsg
    end

scr_seq_0003_006:
    setflag FLAG_MAPTEMP_020
    call _0646
    copyvar VAR_TEMP_x4000, VAR_SPECIAL_RESULT
    endstd
    end

_0646:
    show_save_stats
    npc_msg 13
    touchscreen_menu_hide
    getmenuchoice VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 1
    goto_if_eq _0740
    get_save_file_state VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _0698
    compare VAR_SPECIAL_RESULT, 1
    goto_if_eq _06BD
    compare VAR_SPECIAL_RESULT, 2
    goto_if_eq _06A9
    compare VAR_SPECIAL_RESULT, 3
    goto_if_eq _06C6
    end

_0698:
    hide_save_stats
    touchscreen_menu_show
    npc_msg 20
    wait_button
    setvar VAR_SPECIAL_RESULT, 0
    return

_06A9:
    npc_msg 14
    getmenuchoice VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 1
    goto_if_eq _0740
_06BD:
    npc_msg 21
    goto _06F2

_06C6:
    npc_msg 14
    getmenuchoice VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 1
    goto_if_eq _0740
    goto_if_unset FLAG_MAPTEMP_020, _076A
    goto_if_set FLAG_MAPTEMP_020, _0775
    end

_06F2:
    player_movement_saving_set
    wait 2, VAR_SPECIAL_RESULT
    call _0708
    player_movement_saving_clear
    goto _071D

_0708:
    add_waiting_icon
    call_if_set FLAG_MAPTEMP_020, _0762
    save_game_normal VAR_SPECIAL_RESULT
    remove_waiting_icon
    return

_071D:
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _074C
    buffer_players_name 0
    npc_msg 16
    play_se SEQ_SE_DP_SAVE
    wait_se SEQ_SE_DP_SAVE
    wait_button_or_delay 30
    hide_save_stats
    return

_0740:
    hide_save_stats
    touchscreen_menu_show
    setvar VAR_SPECIAL_RESULT, 0
    return

_074C:
    npc_msg 18
    wait_button
    hide_save_stats
    touchscreen_menu_show
    return

_0757:
    npc_msg 21
    goto _06F2
    .byte 0x02, 0x00
_0762:
    save_wipe_extra_chunks
    clearflag FLAG_MAPTEMP_020
    return

_076A:
    npc_msg 15
    goto _06F2
    .byte 0x02, 0x00
_0775:
    scrcmd_642 VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _0757
    goto _076A
    .byte 0x02, 0x00
scr_seq_0003_007:
    call _07AA
    npc_msg 32
    wait_button
    endstd
    end

scr_seq_0003_035:
    call _07AA
    npc_msg 90
    endstd
    end

_07AA:
    play_fanfare SEQ_ME_ACCE
    scrcmd_403 VAR_SPECIAL_x8004, VAR_SPECIAL_x8005
    buffer_fashion_name 0, VAR_SPECIAL_x8004
    npc_msg 25
    wait_fanfare
    buffer_players_name 0
    buffer_fashion_name 1, VAR_SPECIAL_x8004
    return

scr_seq_0003_026:
    call _07E4
    npc_msg 32
    wait_button
    endstd
    end

scr_seq_0003_034:
    call _07E4
    npc_msg 90
    endstd
    end

_07E4:
    play_fanfare SEQ_ME_ACCE
    scrcmd_406 VAR_SPECIAL_x8004
    buffer_background_name 0, VAR_SPECIAL_x8004
    npc_msg 25
    wait_fanfare
    buffer_players_name 0
    buffer_background_name 1, VAR_SPECIAL_x8004
    return

scr_seq_0003_008:
    call _080A
    endstd
    end

_080A:
    call _04F2
    giveitem VAR_SPECIAL_x8004, VAR_SPECIAL_x8005, VAR_SPECIAL_RESULT
    getitempocket VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 7
    call_if_eq _0892
    compare VAR_SPECIAL_RESULT, 7
    call_if_ne _08A3
    compare VAR_SPECIAL_x8005, 1
    goto_if_gt _084E
    npc_msg 30
    goto _0851

_084E:
    npc_msg 31
_0851:
    wait_button_or_walk_away
    return

scr_seq_0003_033_give_item_verbose:
    call _085F
    endstd
    end

_085F:
    call _04F2
    giveitem VAR_SPECIAL_x8004, VAR_SPECIAL_x8005, VAR_SPECIAL_RESULT
    getitempocket VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 7
    call_if_eq _0892
    compare VAR_SPECIAL_RESULT, 7
    call_if_ne _08A3
    npc_msg 89
    return

_0892:
    buffer_players_name 0
    buffer_item_name_indef 1, VAR_SPECIAL_x8004
    npc_msg 28
    goto _08C9

_08A3:
    compare VAR_SPECIAL_x8005, 1
    goto_if_gt _08BB
    buffer_item_name_indef 0, VAR_SPECIAL_x8004
    goto _08C0

_08BB:
    buffer_item_name_plural 0, VAR_SPECIAL_x8004
_08C0:
    npc_msg 25
    goto _08C9

_08C9:
    wait_fanfare
    buffer_players_name 0
    compare VAR_SPECIAL_x8005, 1
    goto_if_gt _08E6
    buffer_item_name 1, VAR_SPECIAL_x8004
    goto _08EB

_08E6:
    buffer_item_name_plural 1, VAR_SPECIAL_x8004
_08EB:
    getitempocket VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
    switch VAR_SPECIAL_RESULT
    case 7, _0972
    case 0, _0961
    case 4, _09B6
    case 1, _09A5
    case 2, _09C7
    case 6, _0983
    case 5, _0994
    case 3, _09D8
    end

_0961:
    getitempocket VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
    buffer_pocket_name 2, VAR_SPECIAL_RESULT
    goto _09E9

_0972:
    getitempocket VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
    buffer_pocket_name 2, VAR_SPECIAL_RESULT
    goto _09E9

_0983:
    getitempocket VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
    buffer_pocket_name 2, VAR_SPECIAL_RESULT
    goto _09E9

_0994:
    getitempocket VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
    buffer_pocket_name 2, VAR_SPECIAL_RESULT
    goto _09E9

_09A5:
    getitempocket VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
    buffer_pocket_name 2, VAR_SPECIAL_RESULT
    goto _09E9

_09B6:
    getitempocket VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
    buffer_pocket_name 2, VAR_SPECIAL_RESULT
    goto _09E9

_09C7:
    getitempocket VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
    buffer_pocket_name 2, VAR_SPECIAL_RESULT
    goto _09E9

_09D8:
    getitempocket VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
    buffer_pocket_name 2, VAR_SPECIAL_RESULT
    goto _09E9

_09E9:
    return

scr_seq_0003_009:
    call _09F5
    endstd
    end

_09F5:
    npc_msg 27
    wait_button_or_walk_away
    return

scr_seq_0003_010:
    scrcmd_609
    lockall
    play_se SEQ_SE_DP_PC_ON
    call _0A18
    buffer_players_name 0
    npc_msg 33
    touchscreen_menu_hide
    goto _0A2E

_0A18:
    scrcmd_500 90
    scrcmd_501 90
    scrcmd_308 90
    return

_0A23:
    scrcmd_502 90
    scrcmd_308 90
    scrcmd_309 90
    return

_0A2E:
    buffer_players_name 0
    npc_msg 34
    menu_init_std_gmm 1, 1, 0, 1, VAR_SPECIAL_x8006
    call_if_unset FLAG_SYS_MET_BILL, _0A78
    call_if_set FLAG_SYS_MET_BILL, _0A82
    menu_item_add 63, 255, 1
    goto_if_set FLAG_GAME_CLEAR, _0A8C
    goto_if_unset FLAG_GAME_CLEAR, _0AD1
    goto _0AD1
    .byte 0x02, 0x00
_0A78:
    menu_item_add 61, 255, 0
    return

_0A82:
    menu_item_add 62, 255, 0
    return

_0A8C:
    menu_item_add 64, 255, 2
    menu_item_add 66, 255, 3
    menu_exec
    switch VAR_SPECIAL_x8006
    case 0, _0B01
    case 1, _0C23
    case 2, _0DBA
    goto _0DF0

_0AD1:
    menu_item_add 66, 255, 2
    menu_exec
    switch VAR_SPECIAL_x8006
    case 0, _0B01
    case 1, _0C23
    goto _0DF0

_0B01:
    play_se SEQ_SE_DP_PC_LOGIN
    buffer_players_name 0
    npc_msg 35
    call _0B17
    goto _0B53

_0B17:
    menu_init_std_gmm 1, 1, 0, 1, VAR_SPECIAL_RESULT
    menu_item_add 67, 76, 0
    menu_item_add 68, 77, 1
    menu_item_add 69, 78, 2
    menu_item_add 70, 79, 3
    menu_item_add 72, 81, 5
    return
    .byte 0x46, 0x00, 0x47, 0x00, 0x50, 0x00, 0x04
    .byte 0x00, 0x1b, 0x00
_0B53:
    menu_exec
    switch VAR_SPECIAL_RESULT
    case 0, _0BA2
    case 1, _0BB5
    case 2, _0BC8
    case 3, _0BDB
    case 4, _0BEE
    goto _0A2E

_0BA2:
    closemsg
    call _0E16
    scrcmd_158 0
    restore_overworld
    goto _0C01

_0BB5:
    closemsg
    call _0E16
    scrcmd_158 1
    restore_overworld
    goto _0C01

_0BC8:
    closemsg
    call _0E16
    scrcmd_158 2
    restore_overworld
    goto _0C01

_0BDB:
    closemsg
    call _0E16
    scrcmd_158 3
    restore_overworld
    goto _0C01

_0BEE:
    closemsg
    call _0E16
    scrcmd_158 4
    restore_overworld
    goto _0C01

_0C01:
    buffer_players_name 0
    non_npc_msg 34
    call _0B17
    call _0A18
    fade_screen 6, 1, 1, RGB_BLACK
    goto _0B53

_0C23:
    play_se SEQ_SE_DP_PC_LOGIN
    buffer_players_name 0
    npc_msg 36
    goto _0C33

_0C33:
    call _0CA7
_0C39:
    count_saved_photos VAR_TEMP_x4000
    compare VAR_TEMP_x4000, 0
    goto_if_ne _0C72
    menu_exec
    switch VAR_SPECIAL_RESULT
    case 0, _0CEC
    case 1, _0D3A
    goto _0A2E

_0C72:
    menu_exec
    switch VAR_SPECIAL_RESULT
    case 0, _0CEC
    case 1, _0D3A
    case 2, _0D86
    goto _0A2E

_0CA7:
    menu_init_std_gmm 1, 1, 0, 1, VAR_SPECIAL_RESULT
    menu_item_add 73, 82, 0
    menu_item_add 74, 83, 1
    count_saved_photos VAR_TEMP_x4000
    compare VAR_TEMP_x4000, 0
    goto_if_ne _0CDA
    menu_item_add 75, 84, 2
    return

_0CDA:
    menu_item_add 65, 85, 2
    menu_item_add 75, 84, 3
    return

_0CEC:
    closemsg
    scrcmd_377 VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _0D0F
    call _0E16
    scrcmd_376
    restore_overworld
    goto _0D18

_0D0F:
    npc_msg 47
    goto _0C33

_0D18:
    buffer_players_name 0
    non_npc_msg 34
    call _0CA7
    call _0A18
    fade_screen 6, 1, 1, RGB_BLACK
    goto _0C39

_0D3A:
    get_unique_seals_quantity VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _0D5B
    closemsg
    call _0E16
    scrcmd_156
    goto _0D64

_0D5B:
    npc_msg 79
    goto _0C33

_0D64:
    buffer_players_name 0
    non_npc_msg 34
    call _0CA7
    call _0A18
    fade_screen 6, 1, 1, RGB_BLACK
    goto _0C39

_0D86:
    closemsg
    call _0E16
    open_photo_album
    restore_overworld
    goto _0D98

_0D98:
    buffer_players_name 0
    non_npc_msg 34
    call _0CA7
    call _0A18
    fade_screen 6, 1, 1, RGB_BLACK
    goto _0C39

_0DBA:
    play_se SEQ_SE_DP_PC_LOGIN
    closemsg
    scrcmd_706 VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 1
    goto_if_eq _0DE7
    call _0E16
    scrcmd_164
    restore_overworld
    call _0E02
    goto _0A2E

_0DE7:
    npc_msg 94
    goto _0A2E

_0DF0:
    closemsg
    play_se SEQ_SE_DP_PC_LOGOFF
    call _0A23
    touchscreen_menu_show
    releaseall
    end

_0E02:
    call _0A18
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    return

_0E16:
    fade_screen 6, 1, 0, RGB_BLACK
    wait_fade
    scrcmd_309 90
    return

scr_seq_0003_014:
    fade_screen 6, 1, 0, RGB_BLACK
    wait_fade
    scrcmd_156
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    end

scr_seq_0003_011:
    npc_msg 38
    endstd
    end

scr_seq_0003_012:
    goto_if_set FLAG_NUZLOCKE_ENABLED, _nuzlockeWhitedOut
    scrcmd_609
    lockall
    apply_movement obj_player, _1054
    apply_movement 0, _105C
    wait_movement
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    buffer_players_name 0
    npc_msg 41
    fade_screen 6, 1, 0, RGB_BLACK
    wait_fade
    closemsg
    play_fanfare SEQ_ME_ASA
    wait_fanfare
    heal_party
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    npc_msg 42
    wait_button_or_walk_away
    closemsg
    releaseall
    end
    .byte 0x2d
    .byte 0x00, 0x2a, 0x1b, 0x00, 0x2d, 0x00, 0x2b, 0x1b, 0x00
scr_seq_0003_013:
    goto_if_set FLAG_NUZLOCKE_ENABLED, _nuzlockeWhitedOut
    scrcmd_609
    lockall
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    get_player_state VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, PLAYER_STATE_ROCKET
    goto_if_ne _0ED4
    set_avatar_bits PLAYER_TRANSITION_ROCKET_HEAL
    goto _0ED8

_0ED4:
    set_avatar_bits PLAYER_TRANSITION_HEAL
_0ED8:
    update_avatar_state
    apply_movement obj_player, _0460
    wait_movement
    npc_msg 44
    call _0F89
    call _0216
    check_badge BADGE_ZEPHYR, VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 1
    goto_if_eq _0F49
    npc_msg 45
    apply_movement obj_player, _0468
    wait_movement
    get_player_state VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, PLAYER_STATE_ROCKET
    goto_if_ne _0F2E
    set_avatar_bits PLAYER_TRANSITION_ROCKET
    goto _0F32

_0F2E:
    set_avatar_bits PLAYER_TRANSITION_WALKING
_0F32:
    update_avatar_state
    apply_movement VAR_SPECIAL_x8007, _0454
    wait_movement
    npc_msg 46
    wait_button_or_walk_away
    closemsg
    releaseall
    end

_0F49:
    apply_movement obj_player, _0468
    wait_movement
    get_player_state VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, PLAYER_STATE_ROCKET
    goto_if_ne _0F6E
    set_avatar_bits PLAYER_TRANSITION_ROCKET
    goto _0F72

_0F6E:
    set_avatar_bits PLAYER_TRANSITION_WALKING
_0F72:
    update_avatar_state
    apply_movement VAR_SPECIAL_x8007, _0454
    wait_movement
    npc_msg 40
    wait_button_or_walk_away
    closemsg
    releaseall
    end

_0F89:
    scrcmd_446 VAR_SPECIAL_x8004
    compare VAR_SPECIAL_x8004, 69
    goto_if_eq _100A
    compare VAR_SPECIAL_x8004, 158
    goto_if_eq _1012
    compare VAR_SPECIAL_x8004, 166
    goto_if_eq _101A
    compare VAR_SPECIAL_x8004, 236
    goto_if_eq _1022
    compare VAR_SPECIAL_x8004, 185
    goto_if_eq _102A
    compare VAR_SPECIAL_x8004, 81
    goto_if_eq _1032
    compare VAR_SPECIAL_x8004, 246
    goto_if_eq _103A
    compare VAR_SPECIAL_x8004, 293
    goto_if_eq _1042
    compare VAR_SPECIAL_x8004, 169
    goto_if_eq _104A
    setvar VAR_SPECIAL_x8007, 0
    return

_100A:
    setvar VAR_SPECIAL_x8007, 0
    return

_1012:
    setvar VAR_SPECIAL_x8007, 3
    return

_101A:
    setvar VAR_SPECIAL_x8007, 6
    return

_1022:
    setvar VAR_SPECIAL_x8007, 3
    return

_102A:
    setvar VAR_SPECIAL_x8007, 0
    return

_1032:
    setvar VAR_SPECIAL_x8007, 0
    return

_103A:
    setvar VAR_SPECIAL_x8007, 2
    return

_1042:
    setvar VAR_SPECIAL_x8007, 3
    return

_104A:
    setvar VAR_SPECIAL_x8007, 3
    return

.balign 4

_1054:
    step 0, 1
    step_end

_105C:
    step 1, 1
    step_end

_1064:
    step 2, 1
    step_end
    .byte 0x00, 0x00, 0x01, 0x00
    .byte 0xfe, 0x00, 0x00, 0x00, 0x03, 0x00, 0x01, 0x00, 0xfe, 0x00, 0x00, 0x00

_107C:
    step 1, 1
    step_end


scr_seq_0003_015:
    play_se SEQ_SE_DP_SELECT
    lockall
    fade_screen 6, 1, 0, RGB_BLACK
    wait_fade
    scrcmd_450
    restore_overworld
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    releaseall
    end

scr_seq_0003_016:
    play_se SEQ_SE_DP_SELECT
    lockall
    faceplayer
    scrcmd_455
    wait_button_or_walk_away
    closemsg
    releaseall
    end

scr_seq_0003_017:
    simple_npc_msg 54
    end

scr_seq_0003_018:
    simple_npc_msg 57
    end

scr_seq_0003_019:
    simple_npc_msg 58
    end

scr_seq_0003_020:
    hasitem 450, 1, VAR_SPECIAL_RESULT // ITEM_BIKE
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _1163
    scrcmd_609
    lockall
    play_se SEQ_SE_DP_SELECT
    player_on_bike_check VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 1
    goto_if_eq _1140
    npc_msg 59
    yesno VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 1
    goto_if_eq _115D
    player_on_bike_set 1
    closemsg
    releaseall
    end

_1140:
    npc_msg 60
    yesno VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 1
    goto_if_eq _115D
    player_on_bike_set 0
    closemsg
    releaseall
    end

_115D:
    closemsg
    releaseall
    end

_1163:
    end

scr_seq_0003_021:
    play_se SEQ_SE_DP_SELECT
    lockall
    npc_msg 62
    wait_button
    fade_screen 6, 1, 0, RGB_BLACK
    wait_fade
    closemsg
    egg_hatch_anim
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    releaseall
    end

scr_seq_0003_022:
    play_se SEQ_SE_DP_SELECT
    lockall
    npc_msg 65
    wait_button
    closemsg
    releaseall
    end

scr_seq_0003_072_repels:
    play_se SEQ_SE_DP_SELECT
    lockall
    npc_msg 118
    yesno VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 1
    goto_if_eq scr_seq_0003_072_end
    QueueNewRepel
    PlayFanfare SEQ_SE_DP_CARD2
    buffer_players_name 0
    buffer_item_name 1, VAR_SPECIAL_RESULT
    npc_msg 119
    wait_button_or_walk_away
scr_seq_0003_072_end:
    closemsg
    releaseall
    end

scr_seq_0003_023:
    play_se SEQ_SE_DP_SELECT
    lockall
    faceplayer
    npc_msg 103
    touchscreen_menu_hide
_11AE:
    menu_init 1, 1, 0, 1, VAR_SPECIAL_RESULT
    menu_item_add 112, 255, 0
    menu_item_add 113, 255, 1
    menu_item_add 114, 255, 2
    menu_item_add 115, 255, 3
    menu_item_add 116, 255, 4
    menu_exec
    compare VAR_SPECIAL_RESULT, 4
    goto_if_ge _1277
    setvar VAR_SPECIAL_x8004, 104
    addvar VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
    non_npc_msg_var VAR_SPECIAL_x8004
    fade_screen 6, 1, 0, RGB_BLACK
    wait_fade
    closemsg
    setvar VAR_SPECIAL_x8000, 2
    addvar VAR_SPECIAL_x8000, VAR_SPECIAL_RESULT
    scrcmd_492 VAR_SPECIAL_x8000, VAR_SPECIAL_RESULT, VAR_SPECIAL_x8001
    restore_overworld
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _1277
    npc_msg 109
    getmenuchoice VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _11AE
    compare VAR_SPECIAL_x8001, 65535
    goto_if_eq _126A
    scrcmd_494 0, VAR_SPECIAL_x8001
    npc_msg 111
    goto _126D

_126A:
    npc_msg 110
_126D:
    wait_button_or_walk_away
    closemsg
    touchscreen_menu_show
    releaseall
    end

_1277:
    npc_msg 108
    goto _126D
    .byte 0x02, 0x00
scr_seq_0003_025:
    simple_npc_msg 68
    end

scr_seq_0003_027:
    end

scr_seq_0003_028:
    scrcmd_609
    lockall
    releaseall
    end
    .byte 0x2d
    .byte 0x00, 0x58, 0x32, 0x00, 0x35, 0x00, 0x61, 0x00, 0x02, 0x00, 0x35, 0x00, 0x61, 0x00, 0x02, 0x00
scr_seq_0003_029:
    stop_bgm 0
    get_player_gender VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 0
    call_if_eq _12D6
    compare VAR_SPECIAL_RESULT, 1
    call_if_eq _12DC
    endstd
    end

_12D6:
    temp_bgm SEQ_GS_E_SUPPORT_F
    return

_12DC:
    temp_bgm SEQ_GS_E_SUPPORT_M
    return

scr_seq_0003_031:
    stop_bgm 0
    temp_bgm SEQ_GS_E_RIVAL1
    endstd
    end

scr_seq_0003_070:
    stop_bgm 0
    temp_bgm SEQ_GS_E_RIVAL2
    endstd
    end

scr_seq_0003_042:
    stop_bgm 0
    temp_bgm SEQ_GS_E_MINAKI
    endstd
    end

scr_seq_0003_044:
    stop_bgm 0
    temp_bgm SEQ_GS_IBUKI
    endstd
    end

scr_seq_0003_036:
    stop_bgm 0
    temp_bgm SEQ_GS_E_TSURETEKE1
    endstd
    end

scr_seq_0003_037:
    stop_bgm 0
    temp_bgm SEQ_GS_E_TSURETEKE2
    endstd
    end

scr_seq_0003_065:
    stop_bgm 0
    temp_bgm SEQ_GS_E_G_PICHU
    endstd
    end

scr_seq_0003_067:
    stop_bgm 0
    temp_bgm SEQ_GS_E_MAIKO_THEME
    endstd
    end

scr_seq_0003_030:
scr_seq_0003_032:
scr_seq_0003_038:
scr_seq_0003_043:
scr_seq_0003_045:
scr_seq_0003_066:
scr_seq_0003_068:
scr_seq_0003_071:
    fade_out_bgm 0, 30
    stop_bgm 0
    reset_bgm
    endstd
    end

scr_seq_0003_039:
    set_phone_call VAR_SPECIAL_x8004, VAR_SPECIAL_x8005, VAR_SPECIAL_x8006
    call _136C
    endstd
    end

scr_seq_0003_047:
    call _136C
    end

_136C:
    play_se SEQ_SE_GS_PHONE0
    wait_se SEQ_SE_GS_PHONE0
    play_se SEQ_SE_GS_PHONE0
    wait_se SEQ_SE_GS_PHONE0
    fade_screen 6, 1, 0, RGB_BLACK
    wait_fade
    run_phone_call
    restore_overworld
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    return

scr_seq_0003_040:
    goto_if_set FLAG_GOT_ALL_FOUR_FRONTIER_PRINTS, _13F6
    compare VAR_BATTLE_FACTORY_PRINT_PROGRESS, 4
    goto_if_ne _13F6
    compare VAR_BATTLE_HALL_PRINT_PROGRESS, 4
    goto_if_ne _13F6
    compare VAR_BATTLE_CASTLE_PRINT_PROGRESS, 4
    goto_if_ne _13F6
    compare VAR_BATTLE_ARCADE_PRINT_PROGRESS, 4
    goto_if_ne _13F6
    compare VAR_BATTLE_TOWER_PRINT_PROGRESS, 4
    goto_if_ne _13F6
    setflag FLAG_GOT_ALL_FOUR_FRONTIER_PRINTS
    add_special_game_stat_2 31
    goto _13F6
    .byte 0x02, 0x00
_13F6:
    endstd
    end

scr_seq_0003_041:
    npc_msg 93
    wait_button_or_walk_away
    closemsg
    releaseall
    endstd
    end

scr_seq_0003_046:
    fade_screen 6, 1, 0, RGB_BLACK
    wait_fade
    scrcmd_166 VAR_SPECIAL_RESULT
    copyvar VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
    scrcmd_662 VAR_SPECIAL_x8005, VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _1444
    restore_overworld
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    endstd
    end

_1444:
    restore_overworld
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    endstd
    end

scr_seq_0003_048:
    goto _145E
    .byte 0x02, 0x00
_145E:
    touchscreen_menu_hide
    menu_init_std_gmm 1, 1, 0, 1, VAR_SPECIAL_RESULT
    menu_item_add 321, 255, 0
    menu_item_add 322, 255, 1
    menu_item_add 323, 255, 2
    menu_exec
    switch VAR_SPECIAL_RESULT
    case 0, scr_seq_0003_049
    case 1, scr_seq_0003_050
    case 2, scr_seq_0003_051
    end

scr_seq_0003_049:
    mart_buy VAR_SPECIAL_x8004
    goto _14DD
    .byte 0x02, 0x00
scr_seq_0003_050:
    mart_sell
    goto _14DD
    .byte 0x02, 0x00
scr_seq_0003_051:
    touchscreen_menu_show
    get_std_msg_naix 3, VAR_SPECIAL_RESULT
    msgbox_extern VAR_SPECIAL_RESULT, 1
    wait_button_or_walk_away
    closemsg
    endstd
    end

_14DD:
    get_std_msg_naix 3, VAR_SPECIAL_RESULT
    msgbox_extern VAR_SPECIAL_RESULT, 6
    holdmsg
    goto _145E
    .byte 0x02, 0x00
scr_seq_0003_052:
    goto _14FB
    .byte 0x02, 0x00
_14FB:
    touchscreen_menu_hide
    menu_init_std_gmm 1, 1, 0, 1, VAR_SPECIAL_RESULT
    menu_item_add 321, 255, 0
    menu_item_add 322, 255, 1
    menu_item_add 323, 255, 2
    menu_exec
    switch VAR_SPECIAL_RESULT
    case 0, scr_seq_0003_053
    case 1, scr_seq_0003_054
    case 2, scr_seq_0003_055
    end

scr_seq_0003_053:
    special_mart_buy VAR_SPECIAL_x8004
    goto _15A6
    .byte 0x02, 0x00
scr_seq_0003_054:
    mart_sell
    goto _15A6
    .byte 0x02, 0x00
scr_seq_0003_055:
    touchscreen_menu_show
    goto_if_set FLAG_SPECIAL_MART_PHARMACY, _15E8
    goto_if_set FLAG_SPECIAL_MART_BITTER, _160C
    goto_if_set FLAG_SPECIAL_MART_MAHOGANY_GOOD, _1630
    goto_if_set FLAG_SPECIAL_MART_MT_MOON, _1654
    get_std_msg_naix 3, VAR_SPECIAL_RESULT
    msgbox_extern VAR_SPECIAL_RESULT, 1
_159E:
    wait_button_or_walk_away
    closemsg
    endstd
    end

_15A6:
    goto_if_set FLAG_SPECIAL_MART_PHARMACY, _15FA
    goto_if_set FLAG_SPECIAL_MART_BITTER, _161E
    goto_if_set FLAG_SPECIAL_MART_MAHOGANY_GOOD, _1642
    goto_if_set FLAG_SPECIAL_MART_MT_MOON, _1666
    get_std_msg_naix 3, VAR_SPECIAL_RESULT
    msgbox_extern VAR_SPECIAL_RESULT, 6
_15DE:
    holdmsg
    goto _14FB
    .byte 0x02, 0x00
_15E8:
    get_std_msg_naix 3, VAR_SPECIAL_RESULT
    msgbox_extern VAR_SPECIAL_RESULT, 2
    goto _159E

_15FA:
    get_std_msg_naix 3, VAR_SPECIAL_RESULT
    msgbox_extern VAR_SPECIAL_RESULT, 7
    goto _15DE

_160C:
    get_std_msg_naix 3, VAR_SPECIAL_RESULT
    msgbox_extern VAR_SPECIAL_RESULT, 3
    goto _159E

_161E:
    get_std_msg_naix 3, VAR_SPECIAL_RESULT
    msgbox_extern VAR_SPECIAL_RESULT, 8
    goto _15DE

_1630:
    get_std_msg_naix 3, VAR_SPECIAL_RESULT
    msgbox_extern VAR_SPECIAL_RESULT, 4
    goto _159E

_1642:
    get_std_msg_naix 3, VAR_SPECIAL_RESULT
    msgbox_extern VAR_SPECIAL_RESULT, 9
    goto _15DE

_1654:
    get_std_msg_naix 3, VAR_SPECIAL_RESULT
    msgbox_extern VAR_SPECIAL_RESULT, 5
    goto _159E

_1666:
    get_std_msg_naix 3, VAR_SPECIAL_RESULT
    msgbox_extern VAR_SPECIAL_RESULT, 10
    goto _15DE

scr_seq_0003_056:
    touchscreen_menu_hide
    menu_init_std_gmm 1, 1, 0, 1, VAR_SPECIAL_RESULT
    menu_item_add 321, 255, 0
    menu_item_add 324, 255, 1
    menu_item_add 323, 255, 2
    menu_exec
    switch VAR_SPECIAL_RESULT
    case 0, scr_seq_0003_057
    case 1, scr_seq_0003_058
    case 2, scr_seq_0003_059
    end

scr_seq_0003_057:
    scrcmd_771
    endstd
    end

scr_seq_0003_058:
    touchscreen_menu_show
    endstd
    end

scr_seq_0003_059:
    touchscreen_menu_show
    endstd
    end

scr_seq_0003_060:
    touchscreen_menu_hide
    menu_init_std_gmm 1, 1, 0, 1, VAR_SPECIAL_RESULT
    menu_item_add 321, 255, 0
    menu_item_add 324, 255, 1
    menu_item_add 323, 255, 2
    menu_exec
    switch VAR_SPECIAL_RESULT
    case 0, scr_seq_0003_061
    case 1, scr_seq_0003_062
    case 2, scr_seq_0003_063
    end

scr_seq_0003_061:
    scrcmd_772
    endstd
    end

scr_seq_0003_062:
    touchscreen_menu_show
    endstd
    end

scr_seq_0003_063:
    touchscreen_menu_show
    endstd
    end

scr_seq_0003_064:
    play_se SEQ_SE_DP_SELECT
    lockall
    get_follow_poke_party_index VAR_SPECIAL_x8005
    bufferpartymonnick 0, VAR_SPECIAL_x8005
    npc_msg 99
    closemsg
    scrcmd_806
    get_follow_poke_party_index VAR_SPECIAL_x8005
    bufferpartymonnick 0, VAR_SPECIAL_x8005
    npc_msg 100
    wait_button
    closemsg
    releaseall
    end

scr_seq_0003_073_autobattle_testing:
    play_se SEQ_SE_DP_SELECT
    lockall
    npc_msg 120
    closemsg
    trainer_battle 5, 0, 0, 0
    //setvar 0x800B, 1
    //WildBattleSp 785 | (1 << 11), 50, 0
    releaseall
    end

// hack: Move Relearner (std 2074, called from an NPC in each gym town's Pokemon Center).
// standard relearner (level-up moves up to the current level), costs 500 per move, only charged if a move is learned.
scr_seq_0003_074_move_relearner:
    play_se SEQ_SE_DP_SELECT
    lockall
    faceplayer
    show_money_box 20, 2
    npc_msg 121
    touchscreen_menu_hide
    getmenuchoice VAR_SPECIAL_RESULT
    touchscreen_menu_show
    compare VAR_SPECIAL_RESULT, 0
    goto_if_ne _relearnCancel
    hasenoughmoneyimmediate VAR_SPECIAL_RESULT, 500
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _relearnNoMoney
    npc_msg 122
    closemsg
    hide_money_box
    fade_screen 6, 1, 0, RGB_BLACK
    wait_fade
    party_select_ui
    get_party_selection VAR_SPECIAL_x8005
    restore_overworld
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    compare VAR_SPECIAL_x8005, 255
    goto_if_eq _relearnCancelNoBox
    get_partymon_species VAR_SPECIAL_x8005, VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _relearnEgg
    scrcmd_466 VAR_SPECIAL_RESULT, VAR_SPECIAL_x8005
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _relearnNoMoves
    fade_screen 6, 1, 0, RGB_BLACK
    wait_fade
    move_relearner_init VAR_SPECIAL_x8005
    move_relearner_get_result VAR_SPECIAL_RESULT
    restore_overworld
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    compare VAR_SPECIAL_RESULT, 255
    goto_if_eq _relearnCancelNoBox
    submoneyimmediate 500
    show_money_box 20, 2
    npc_msg 126
    wait_button
    hide_money_box
    closemsg
    releaseall
    end

_relearnNoMoney:
    npc_msg 123
    wait_button
    hide_money_box
    closemsg
    releaseall
    end

_relearnCancel:
    npc_msg 127
    wait_button
    hide_money_box
    closemsg
    releaseall
    end

_relearnCancelNoBox:
    npc_msg 127
    wait_button
    closemsg
    releaseall
    end

_relearnEgg:
    npc_msg 125
    wait_button
    closemsg
    releaseall
    end

_relearnNoMoves:
    npc_msg 124
    wait_button
    closemsg
    releaseall
    end

// hack: Nuzlocke game over.  queued by the whiteout scripts above, and by every map's scene check once the run is
// over (src/nuzlocke.c), so a finished run can't be continued.  it never ends: the player has to reset.
_nuzlockeWhitedOut:
    scrcmd_609
    lockall
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    goto _nuzlockeGameOver

scr_seq_0003_075_nuzlocke_game_over:
    scrcmd_609
    lockall
_nuzlockeGameOver:
    goto_if_set FLAG_NUZLOCKE_RUN_OVER, _nuzlockeGameOverLoop
    npc_msg 128
    setflag FLAG_NUZLOCKE_RUN_OVER
    add_waiting_icon
    save_game_normal VAR_SPECIAL_RESULT
    remove_waiting_icon
_nuzlockeGameOverLoop:
    npc_msg 129
    wait_button
    goto _nuzlockeGameOverLoop

// ---- Part 1: FireRed's hidden items as item balls (generated, scratch build33_items.py) ----

scr_seq_0003_p1ball_2076: // CeladonCity -> map 55
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_PP_UP, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1057
    giveitem_no_check ITEM_PP_UP, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2077: // CeruleanCity -> map 52
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_RARE_CANDY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1058
    giveitem_no_check ITEM_RARE_CANDY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2078: // FuchsiaCity -> map 56
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_MAX_REVIVE, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1059
    giveitem_no_check ITEM_MAX_REVIVE, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2079: // MtEmber_Exterior -> map 122
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_FIRE_STONE, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1060
    giveitem_no_check ITEM_FIRE_STONE, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2080: // MtEmber_Exterior -> map 122
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_ULTRA_BALL, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1065
    giveitem_no_check ITEM_ULTRA_BALL, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2081: // MtMoon_B1F -> map 107
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_TINY_MUSHROOM, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1066
    giveitem_no_check ITEM_TINY_MUSHROOM, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2082: // MtMoon_B1F -> map 107
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_TINY_MUSHROOM, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1067
    giveitem_no_check ITEM_TINY_MUSHROOM, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2083: // MtMoon_B1F -> map 107
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_TINY_MUSHROOM, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1068
    giveitem_no_check ITEM_TINY_MUSHROOM, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2084: // MtMoon_B1F -> map 107
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_BIG_MUSHROOM, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1069
    giveitem_no_check ITEM_BIG_MUSHROOM, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2085: // MtMoon_B1F -> map 107
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_BIG_MUSHROOM, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1070
    giveitem_no_check ITEM_BIG_MUSHROOM, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2086: // MtMoon_B1F -> map 107
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_BIG_MUSHROOM, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1071
    giveitem_no_check ITEM_BIG_MUSHROOM, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2087: // MtMoon_B2F -> map 107
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_MOON_STONE, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1072
    giveitem_no_check ITEM_MOON_STONE, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2088: // MtMoon_B2F -> map 107
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_ETHER, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1075
    giveitem_no_check ITEM_ETHER, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2089: // OneIsland_TreasureBeach -> map 75
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_STARDUST, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1076
    giveitem_no_check ITEM_STARDUST, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2090: // OneIsland_TreasureBeach -> map 75
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_STARDUST, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1078
    giveitem_no_check ITEM_STARDUST, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2091: // OneIsland_TreasureBeach -> map 75
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_PEARL, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1079
    giveitem_no_check ITEM_PEARL, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2092: // OneIsland_TreasureBeach -> map 75
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_ULTRA_BALL, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1081
    giveitem_no_check ITEM_ULTRA_BALL, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2093: // PewterCity -> map 51
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_POKE_BALL, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1082
    giveitem_no_check ITEM_POKE_BALL, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2094: // PokemonMansion_1F -> map 7
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_MOON_STONE, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1083
    giveitem_no_check ITEM_MOON_STONE, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2095: // PokemonMansion_3F -> map 217
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_RARE_CANDY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1087
    giveitem_no_check ITEM_RARE_CANDY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2096: // PokemonMansion_B1F -> map 217
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_ELIXIR, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1090
    giveitem_no_check ITEM_ELIXIR, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2097: // PokemonTower_5F -> map 156
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_BIG_MUSHROOM, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1091
    giveitem_no_check ITEM_BIG_MUSHROOM, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2098: // PokemonTower_7F -> map 156
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_SOOTHE_BELL, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1092
    giveitem_no_check ITEM_SOOTHE_BELL, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2099: // PowerPlant -> map 467
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_MAX_ELIXIR, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1093
    giveitem_no_check ITEM_MAX_ELIXIR, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2100: // PowerPlant -> map 467
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_THUNDER_STONE, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1094
    giveitem_no_check ITEM_THUNDER_STONE, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2101: // RocketHideout_B1F -> map 247
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_PP_UP, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1095
    giveitem_no_check ITEM_PP_UP, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2102: // RocketHideout_B3F -> map 238
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_NUGGET, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1096
    giveitem_no_check ITEM_NUGGET, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2103: // RocketHideout_B4F -> map 249
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_NEST_BALL, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1097
    giveitem_no_check ITEM_NEST_BALL, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2104: // RocketHideout_B4F -> map 249
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_NET_BALL, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1098
    giveitem_no_check ITEM_NET_BALL, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2105: // Route10 -> map 18
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_SUPER_POTION, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1099
    giveitem_no_check ITEM_SUPER_POTION, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2106: // Route10 -> map 18
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_MAX_ETHER, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1100
    giveitem_no_check ITEM_MAX_ETHER, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2107: // Route10 -> map 18
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_CHERI_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1101
    giveitem_no_check ITEM_CHERI_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2108: // Route10 -> map 18
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_PERSIM_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1111
    giveitem_no_check ITEM_PERSIM_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2109: // Route10 -> map 18
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_NANAB_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1112
    giveitem_no_check ITEM_NANAB_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2110: // Route11 -> map 19
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_ESCAPE_ROPE, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1113
    giveitem_no_check ITEM_ESCAPE_ROPE, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2111: // Route12 -> map 20
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_HYPER_POTION, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1114
    giveitem_no_check ITEM_HYPER_POTION, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2112: // Route12 -> map 20
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_LEFTOVERS, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1115
    giveitem_no_check ITEM_LEFTOVERS, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2113: // Route12 -> map 20
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_RARE_CANDY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1116
    giveitem_no_check ITEM_RARE_CANDY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2114: // Route13 -> map 21
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_PP_UP, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1117
    giveitem_no_check ITEM_PP_UP, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2115: // Route14 -> map 22
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_ZINC, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1118
    giveitem_no_check ITEM_ZINC, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2116: // Route14 -> map 22
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_PINAP_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1128
    giveitem_no_check ITEM_PINAP_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2117: // Route16 -> map 24
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_LEFTOVERS, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1129
    giveitem_no_check ITEM_LEFTOVERS, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2118: // Route17 -> map 25
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_RARE_CANDY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1130
    giveitem_no_check ITEM_RARE_CANDY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2119: // Route17 -> map 25
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_FULL_RESTORE, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1131
    giveitem_no_check ITEM_FULL_RESTORE, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2120: // Route17 -> map 25
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_PP_UP, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1132
    giveitem_no_check ITEM_PP_UP, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2121: // Route17 -> map 25
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_MAX_REVIVE, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1133
    giveitem_no_check ITEM_MAX_REVIVE, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2122: // Route17 -> map 25
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_MAX_ELIXIR, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1134
    giveitem_no_check ITEM_MAX_ELIXIR, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2123: // Route20 -> map 92
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_STARDUST, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1135
    giveitem_no_check ITEM_STARDUST, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2124: // Route21_North -> map 93
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_PEARL, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1136
    giveitem_no_check ITEM_PEARL, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2125: // Route23 -> map 124
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_FULL_RESTORE, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1137
    giveitem_no_check ITEM_FULL_RESTORE, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2126: // Route23 -> map 124
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_ULTRA_BALL, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1138
    giveitem_no_check ITEM_ULTRA_BALL, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2127: // Route23 -> map 124
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_MAX_ETHER, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1139
    giveitem_no_check ITEM_MAX_ETHER, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2128: // Route23 -> map 124
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_LUM_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1140
    giveitem_no_check ITEM_LUM_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2129: // Route23 -> map 124
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_SITRUS_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1141
    giveitem_no_check ITEM_SITRUS_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2130: // Route23 -> map 124
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_ASPEAR_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1142
    giveitem_no_check ITEM_ASPEAR_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2131: // Route23 -> map 124
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_LEPPA_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1143
    giveitem_no_check ITEM_LEPPA_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2132: // Route23 -> map 124
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_MAX_ELIXIR, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1144
    giveitem_no_check ITEM_MAX_ELIXIR, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2133: // VictoryRoad_1F -> map 124
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_ULTRA_BALL, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1145
    giveitem_no_check ITEM_ULTRA_BALL, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2134: // VictoryRoad_1F -> map 124
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_FULL_RESTORE, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1146
    giveitem_no_check ITEM_FULL_RESTORE, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2135: // Route24 -> map 28
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_PECHA_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1147
    giveitem_no_check ITEM_PECHA_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2136: // Route25 -> map 29
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_ELIXIR, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1148
    giveitem_no_check ITEM_ELIXIR, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2137: // Route25 -> map 29
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_ETHER, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1149
    giveitem_no_check ITEM_ETHER, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2138: // Route25 -> map 29
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_ORAN_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1150
    giveitem_no_check ITEM_ORAN_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2139: // Route25 -> map 29
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_BLUK_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1151
    giveitem_no_check ITEM_BLUK_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2140: // Route3 -> map 11
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_ORAN_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1152
    giveitem_no_check ITEM_ORAN_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2141: // Route4 -> map 12
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_GREAT_BALL, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1153
    giveitem_no_check ITEM_GREAT_BALL, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2142: // Route4 -> map 12
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_PERSIM_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1154
    giveitem_no_check ITEM_PERSIM_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2143: // Route4 -> map 12
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_RAZZ_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1155
    giveitem_no_check ITEM_RAZZ_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2144: // Route6 -> map 14
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_SITRUS_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1156
    giveitem_no_check ITEM_SITRUS_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2145: // Route6 -> map 14
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_RARE_CANDY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1157
    giveitem_no_check ITEM_RARE_CANDY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2146: // Route7 -> map 15
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_WEPEAR_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1158
    giveitem_no_check ITEM_WEPEAR_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2147: // Route8 -> map 16
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_RAWST_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1159
    giveitem_no_check ITEM_RAWST_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2148: // Route8 -> map 16
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_LUM_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1160
    giveitem_no_check ITEM_LUM_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2149: // Route8 -> map 16
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_LEPPA_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1161
    giveitem_no_check ITEM_LEPPA_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2150: // Route9 -> map 17
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_ETHER, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1162
    giveitem_no_check ITEM_ETHER, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2151: // Route9 -> map 17
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_RARE_CANDY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1163
    giveitem_no_check ITEM_RARE_CANDY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2152: // Route9 -> map 17
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_CHESTO_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1164
    giveitem_no_check ITEM_CHESTO_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2153: // SSAnne_B1F_Corridor -> map 329
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_HYPER_POTION, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1165
    giveitem_no_check ITEM_HYPER_POTION, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2154: // SSAnne_Exterior -> map 307
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_LAVA_COOKIE, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1166
    giveitem_no_check ITEM_LAVA_COOKIE, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2155: // SSAnne_Kitchen -> map 310
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_CHESTO_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1167
    giveitem_no_check ITEM_CHESTO_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2156: // SSAnne_Kitchen -> map 310
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_PECHA_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1168
    giveitem_no_check ITEM_PECHA_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2157: // SSAnne_Kitchen -> map 310
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_CHERI_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1169
    giveitem_no_check ITEM_CHERI_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2158: // SafariZone_Center -> map 173
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_LEAF_STONE, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1170
    giveitem_no_check ITEM_LEAF_STONE, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2159: // SafariZone_West -> map 173
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_REVIVE, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1171
    giveitem_no_check ITEM_REVIVE, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2160: // SaffronCity_CopycatsHouse_2F -> map 405
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_NUGGET, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1193
    giveitem_no_check ITEM_NUGGET, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2161: // SeafoamIslands_B3F -> map 454
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_NUGGET, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1194
    giveitem_no_check ITEM_NUGGET, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2162: // SeafoamIslands_B4F -> map 456
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_WATER_STONE, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1195
    giveitem_no_check ITEM_WATER_STONE, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2163: // SilphCo_10F -> map 189
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_HP_UP, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1198
    giveitem_no_check ITEM_HP_UP, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2164: // SilphCo_11F -> map 189
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_REVIVE, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1200
    giveitem_no_check ITEM_REVIVE, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2165: // SilphCo_5F -> map 189
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_ELIXIR, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1201
    giveitem_no_check ITEM_ELIXIR, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2166: // SilphCo_5F -> map 189
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_PP_UP, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1202
    giveitem_no_check ITEM_PP_UP, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2167: // SilphCo_9F -> map 189
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_MAX_POTION, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1203
    giveitem_no_check ITEM_MAX_POTION, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2168: // SilphCo_9F -> map 189
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_CALCIUM, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1204
    giveitem_no_check ITEM_CALCIUM, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2169: // SilphCo_2F -> map 186
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_ULTRA_BALL, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1205
    giveitem_no_check ITEM_ULTRA_BALL, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2170: // SilphCo_6F -> map 186
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_CARBOS, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1208
    giveitem_no_check ITEM_CARBOS, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2171: // SilphCo_3F -> map 187
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_PROTEIN, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1209
    giveitem_no_check ITEM_PROTEIN, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2172: // SilphCo_7F -> map 187
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_ZINC, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1210
    giveitem_no_check ITEM_ZINC, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2173: // SilphCo_4F -> map 188
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_IRON, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1211
    giveitem_no_check ITEM_IRON, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2174: // SilphCo_8F -> map 188
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_NUGGET, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1212
    giveitem_no_check ITEM_NUGGET, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2175: // ThreeIsland_BerryForest -> map 117
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_RAZZ_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1213
    giveitem_no_check ITEM_RAZZ_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2176: // ThreeIsland_BerryForest -> map 117
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_BLUK_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1214
    giveitem_no_check ITEM_BLUK_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2177: // ThreeIsland_BerryForest -> map 117
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_NANAB_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1215
    giveitem_no_check ITEM_NANAB_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2178: // ThreeIsland_BerryForest -> map 117
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_WEPEAR_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1216
    giveitem_no_check ITEM_WEPEAR_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2179: // ThreeIsland_BerryForest -> map 117
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_ORAN_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1217
    giveitem_no_check ITEM_ORAN_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2180: // ThreeIsland_BerryForest -> map 117
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_CHERI_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1218
    giveitem_no_check ITEM_CHERI_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2181: // ThreeIsland_BerryForest -> map 117
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_CHESTO_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1219
    giveitem_no_check ITEM_CHESTO_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2182: // ThreeIsland_BerryForest -> map 117
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_PECHA_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1220
    giveitem_no_check ITEM_PECHA_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2183: // ThreeIsland_BerryForest -> map 117
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_RAWST_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1221
    giveitem_no_check ITEM_RAWST_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2184: // ThreeIsland_BerryForest -> map 117
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_ASPEAR_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1231
    giveitem_no_check ITEM_ASPEAR_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2185: // ThreeIsland_BerryForest -> map 117
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_PERSIM_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1239
    giveitem_no_check ITEM_PERSIM_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2186: // ThreeIsland_BerryForest -> map 117
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_PINAP_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1242
    giveitem_no_check ITEM_PINAP_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2187: // ThreeIsland_BerryForest -> map 117
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_LUM_BERRY, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1243
    giveitem_no_check ITEM_LUM_BERRY, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2188: // UndergroundPath_EastWestTunnel -> map 532
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_POTION, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1244
    giveitem_no_check ITEM_POTION, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2189: // UndergroundPath_EastWestTunnel -> map 532
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_PARALYZE_HEAL, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1245
    giveitem_no_check ITEM_PARALYZE_HEAL, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2190: // UndergroundPath_EastWestTunnel -> map 532
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_AWAKENING, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1246
    giveitem_no_check ITEM_AWAKENING, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2191: // UndergroundPath_EastWestTunnel -> map 532
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_BURN_HEAL, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1266
    giveitem_no_check ITEM_BURN_HEAL, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2192: // UndergroundPath_EastWestTunnel -> map 532
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_ICE_HEAL, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1273
    giveitem_no_check ITEM_ICE_HEAL, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2193: // UndergroundPath_EastWestTunnel -> map 532
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_ETHER, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1274
    giveitem_no_check ITEM_ETHER, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2194: // UndergroundPath_EastWestTunnel -> map 532
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_ANTIDOTE, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1275
    giveitem_no_check ITEM_ANTIDOTE, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2195: // UndergroundPath_NorthSouthTunnel -> map 532
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_POTION, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1276
    giveitem_no_check ITEM_POTION, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2196: // UndergroundPath_NorthSouthTunnel -> map 532
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_ANTIDOTE, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1277
    giveitem_no_check ITEM_ANTIDOTE, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2197: // UndergroundPath_NorthSouthTunnel -> map 532
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_BURN_HEAL, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1278
    giveitem_no_check ITEM_BURN_HEAL, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2198: // UndergroundPath_NorthSouthTunnel -> map 532
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_AWAKENING, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1279
    giveitem_no_check ITEM_AWAKENING, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2199: // UndergroundPath_NorthSouthTunnel -> map 532
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_ICE_HEAL, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1280
    giveitem_no_check ITEM_ICE_HEAL, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2200: // UndergroundPath_NorthSouthTunnel -> map 532
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_PARALYZE_HEAL, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1284
    giveitem_no_check ITEM_PARALYZE_HEAL, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2201: // UndergroundPath_NorthSouthTunnel -> map 532
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_ETHER, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1285
    giveitem_no_check ITEM_ETHER, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2202: // VermilionCity -> map 54
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_MAX_ETHER, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1286
    giveitem_no_check ITEM_MAX_ETHER, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2203: // ViridianCity_Gym -> map 496
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_MACHO_BRACE, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1288
    giveitem_no_check ITEM_MACHO_BRACE, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2204: // ViridianForest -> map 147
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_POTION, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1289
    giveitem_no_check ITEM_POTION, 1
    closemsg
    releaseall
    end

scr_seq_0003_p1ball_2205: // ViridianForest -> map 147
    play_se SEQ_SE_DP_SELECT
    lockall
    goto_if_no_item_space ITEM_ANTIDOTE, 1, _p1BallFull
    hide_person VAR_SPECIAL_LAST_TALKED
    setflag 1290
    giveitem_no_check ITEM_ANTIDOTE, 1
    closemsg
    releaseall
    end

_p1BallFull:
    callstd std_bag_is_full
    closemsg
    releaseall
    end
