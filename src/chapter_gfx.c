#include "../../include/config.h"
#include "../../include/types.h"
#include "../../include/chapter.h"

/*
 *  hack: Part 1's player is Red, but the Trainer Card, Professor Oak's intro pictures and the Hall of Fame pose only
 *  have Ethan's art.  in Part 1, Ethan's cap is recolored from yellow to Red's red in the palettes those screens load
 *  (like Red's battle back sprite, scripts/hack/make_red_backpic.py).  Part 2 loads them unchanged.
 *
 *  replaces GfGfxLoader_LoadFromNarc (0x02007A44): the same load (and LZ decompression), then the palette touch-up.
 */

#ifdef CHAPTER_SYSTEM

#define GetNarcMemberSizeByIdPair ((u32 (*)(u32 narcId, s32 member))(0x020075BC | 1))
#define ReadWholeNarcMemberByIdPair ((void (*)(void *dest, u32 narcId, s32 member))(0x02007508 | 1))
#define Heap_Alloc ((void *(*)(u32 heapId, u32 size))(0x0201AA8C | 1))
#define Heap_AllocAtEnd ((void *(*)(u32 heapId, u32 size))(0x0201AACC | 1))
#define Heap_Free ((void (*)(void *ptr))(0x0201AB0C | 1))
#define MI_UncompressLZ8 ((void (*)(const void *src, void *dest))(0x020D4BE8)) // ARM

#define NARC_TRAINER_CARD   49  // a/0/4/9
#define NARC_TRAINER_PICS   58  // a/0/5/8: Ethan's front pic palette is member 1 (class 0 * 5 + 1)
#define NARC_INTRO          120 // demo/intro/intro: Ethan's pictures' palette is member 16
#define NCLR_COLORS_OFFSET  0x28


static const u16 sYellow[3] = { RGB(31, 27, 11), RGB(27, 23, 7), RGB(20, 14, 4) };  // light, mid, dark
static const u16 sRed[3] = { RGB(31, 14, 12), RGB(29, 9, 7), RGB(21, 5, 5) };

static void Recolor(u16 *colors, u32 first, u32 count)
{
    for (u32 i = 0; i < count; i++) {
        for (u32 j = 0; j < 3; j++) {
            if (colors[first + i] == sYellow[j]) {
                colors[first + i] = sRed[j];
                break;
            }
        }
    }
}

static void RedCapPalette(u32 narcId, s32 member, u8 *data)
{
    if (data == NULL || data[0] != 'R' || data[1] != 'L' || data[2] != 'C' || data[3] != 'N' || Chapter_Get() != CHAPTER_RED) {
        return;
    }
    u16 *colors = (u16 *)(data + NCLR_COLORS_OFFSET);
    if (narcId == NARC_TRAINER_CARD && member <= 30) {
        // the card palettes keep Ethan's colors at 80-95 (Lyra's at 64-79): recolor only if they're Ethan's yellows
        if (colors[82] == sYellow[1] && colors[83] == sYellow[2]) {
            Recolor(colors, 81, 3);
        }
    } else if (narcId == NARC_TRAINER_PICS && member == 1) {
        Recolor(colors, 1, 3);
    } else if (narcId == NARC_INTRO && member == 16) {
        colors[7] = sRed[2];
        colors[8] = sRed[1];
    }
}

void *LONG_CALL Chapter_GfGfxLoader_LoadFromNarc(u32 narcId, s32 member, BOOL isCompressed, u32 heapId, BOOL atEnd)
{
    void *data;
    if (isCompressed || atEnd == TRUE) {
        data = Heap_AllocAtEnd(heapId, GetNarcMemberSizeByIdPair(narcId, member));
    } else {
        data = Heap_Alloc(heapId, GetNarcMemberSizeByIdPair(narcId, member));
    }
    if (data != NULL) {
        ReadWholeNarcMemberByIdPair(data, narcId, member);
        if (isCompressed) {
            u32 size = *(u32 *)data >> 8;
            void *uncomp = (atEnd == FALSE) ? Heap_Alloc(heapId, size) : Heap_AllocAtEnd(heapId, size);
            if (uncomp != NULL) {
                MI_UncompressLZ8(data, uncomp);
                Heap_Free(data);
            }
            data = uncomp;
        }
        RedCapPalette(narcId, member, data);
    }
    return data;
}

#endif // CHAPTER_SYSTEM
