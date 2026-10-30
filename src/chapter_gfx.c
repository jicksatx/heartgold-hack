#include "../include/config.h"
#include "../include/types.h"
#include "../include/chapter.h"
#include "../include/overlay.h"
#include "../include/constants/file.h"

/*
 *  hack: Part 1's player is Red, but the Trainer Card, Professor Oak's intro pictures and the Hall of Fame pose only
 *  have Ethan's art.  in Part 1, Ethan's cap is recolored from yellow to Red's red in the palettes those screens load
 *  (like Red's battle back sprite, scripts/hack/make_red_backpic.py).  Part 2 loads them unchanged.
 *
 *  GfGfxLoader_LoadFromNarc (0x02007A44) ends at 0x02007ABE with a BL to Chapter_LoadFromNarcTail (asm/general_hooks.s),
 *  which passes the loaded data here and then returns it as the original did.  this has to live in the always-loaded
 *  code: the opening movie loads graphics before the field overlay (src/field) is loaded.
 */

#ifdef CHAPTER_SYSTEM

#define NARC_TRAINER_CARD   49  // a/0/4/9
#define NARC_TRAINER_PICS   58  // a/0/5/8: Ethan's front pic palette is member 1 (class 0 * 5 + 1)
#define NARC_INTRO          120 // demo/intro/intro: Ethan's pictures' palette is member 16
#define NCLR_COLORS_OFFSET  0x28


// each entry: narc, first member, last member, color index, Ethan's yellow, Red's red (5-bit RGB).  a color is
// changed only while it still holds Ethan's yellow.
static const struct { u8 narc, first, last, index; u16 yellow, red; } sCapColors[] = {
    { NARC_TRAINER_CARD, 0, 24, 81, RGB(31, 27, 11), RGB(31, 14, 12) }, // card palettes keep Ethan's colors at 80-95
    { NARC_TRAINER_CARD, 0, 24, 82, RGB(27, 23, 7), RGB(29, 9, 7) },
    { NARC_TRAINER_CARD, 0, 24, 83, RGB(20, 14, 4), RGB(21, 5, 5) },
    { NARC_TRAINER_PICS, 1, 1, 1, RGB(31, 27, 11), RGB(31, 14, 12) },
    { NARC_TRAINER_PICS, 1, 1, 2, RGB(27, 23, 7), RGB(29, 9, 7) },
    { NARC_TRAINER_PICS, 1, 1, 3, RGB(20, 14, 4), RGB(21, 5, 5) },
    { NARC_INTRO, 16, 16, 7, RGB(25, 19, 7), RGB(21, 5, 5) },
    { NARC_INTRO, 16, 16, 8, RGB(31, 27, 11), RGB(29, 9, 7) },
};

void LONG_CALL Chapter_RedCapPalette(u8 *data, u32 narcId, s32 member)
{
    if (data == NULL) {
        return;
    }
    u16 *colors = (u16 *)(data + NCLR_COLORS_OFFSET);
    for (u32 i = 0; i < NELEMS(sCapColors); i++) {
        if (narcId == sCapColors[i].narc && member >= sCapColors[i].first && member <= sCapColors[i].last
            && *(u32 *)data == 0x4E434C52 // 'RLCN': a palette
            && colors[sCapColors[i].index] == sCapColors[i].yellow && Chapter_Get() == CHAPTER_RED) {
            colors[sCapColors[i].index] = sCapColors[i].red;
        }
    }
}

/**
 *  @brief loads the field extension overlay (131, src/field) if it isn't loaded yet: Part 1's map header hooks live
 *         there, and the game reads map headers before it loads the field overlay (new game, Continue).
 */
void LONG_CALL Chapter_LoadFieldExt(void)
{
    if (!IsOverlayLoaded(OVERLAY_FIELD_EXTENSION)) {
        HandleLoadOverlay(OVERLAY_FIELD_EXTENSION, 2);
    }
}

#endif // CHAPTER_SYSTEM
