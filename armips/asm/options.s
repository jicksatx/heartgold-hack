// hack (Build 77): the Options menu's TEXT SPEED row (0) is gone like BATTLE STYLE (2): text is always instant.
// The cursor skip is in asm/general_hooks.s (OptionsApp_CursorUp/Down), the blank labels in data/text/045.txt and
// the row backgrounds in scripts/hack/options_bg.py.

.nds
.thumb
.open "base/overlay/overlay_0054.bin", 0x021E5900

// OptionsApp_SetupGraphicsData: the menu opens on BATTLE SCENE (row 1): currentMenuEntryId (bits 2-4 of data+0x10)
// = 1 and the row highlight at sMenuEntryBorderYCoords[1] (-32) instead of reading row 0's
.org 0x021E5FE2
    ldr r3, [r4, #16]
    mov r2, #0x1C
    bic r3, r2
    add r3, #4
    str r3, [r4, #16]
    ldr r0, [r4, #20]
    ldr r3, [pc, #12] // 0x021E5FFC
    mov r1, #0
    mov r2, #3
.org 0x021E5FFC
.word -32

// ov54_021E6EAC sprite templates: the value markers of rows 0 and 2 start below the screen (y 220)
.org 0x021E6EAC + 40 * 0 + 6
.halfword 220
.org 0x021E6EAC + 40 * 2 + 6
.halfword 220

// the original calls at the two spots Build 77's first try hooked (base overlays are patched in place)
.org 0x021E5D48
    bl 0x021E5F40 // OptionsApp_SetupGraphicsData
.org 0x021E5D82
    bl 0x021E6B5C // OptionsApp_SetupSprites

.close
