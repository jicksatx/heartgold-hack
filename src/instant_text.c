#include "config.h"
#include "types.h"

/*
 *  hack: instant text.  every message prints a whole page in one frame; the game still waits for A/B at the end of a
 *  page and at the arrow prompts, and scrolling between lines is unchanged.
 *
 *  - Options_GetTextFrameDelay (0x0202AD3C) always returns 1 (the Fast setting), so no printer waits between
 *    characters; the Options menu's Text Speed row no longer changes anything.
 *  - RunTextPrinter (0x020202EC, the per-frame text printer task) is replaced by the same code with the render step in
 *    a loop: it keeps drawing characters this frame until the printer has to wait (a button prompt, a scroll, a timed
 *    pause or a callback) or the text is finished.  pret/pokeheartgold src/text.c.
 */

typedef struct TextPrinterTemplate {
    const u16 *currentChar;
    void *window;
    u8 padding[1];
    u8 fontId;
    u8 x, y;
    u16 currentX, currentY;
    u16 letterSpacing, lineSpacing;
    u8 unk14;
    u8 fgColor, bgColor, shadowColor;
    u16 glyphTable;
    u8 unk1A;
    u8 unk1B;
} TextPrinterTemplate;

typedef BOOL (*PrinterCallback_t)(TextPrinterTemplate *template, u16 glyphId);

typedef struct TextPrinter {
    TextPrinterTemplate template;
    PrinterCallback_t callback;
    u8 subStructFields[7];
    u8 active;
    u8 state;
    u8 textSpeedBottom : 7;
    u8 textSpeedTop : 1;
    u8 delayCounter;
    u8 scrollDistance;
    u8 id;
    u8 unk2D;
    u16 unk2E;
    u16 *unk30;
} TextPrinter;

enum { RENDER_PRINT, RENDER_FINISH, RENDER_REPEAT, RENDER_UPDATE };

#define TEXT_PRINTER_PAUSED (*(volatile u8 *)0x021D1F6C) // _021D1F6C: set while all printers are paused
#define MAX_GLYPHS_PER_FRAME 0x400                       // AddTextPrinter's own limit for an instant print

#define RenderFont                     ((u32 (*)(TextPrinter *))(0x02020358 | 1))
#define GenerateFontHalfRowLookupTable ((void (*)(u8, u8, u8))(0x0202036C | 1))
#define CopyWindowToVram               ((void (*)(void *))(0x0201D578 | 1))
#define DestroyTextPrinterSysTask      ((void (*)(u8))(0x02020020 | 1))

u8 LONG_CALL InstantText_GetTextFrameDelay(void *options)
{
    (void)options;
    return 1;
}

void LONG_CALL InstantText_RunTextPrinter(void *task, TextPrinter *printer)
{
    (void)task;
    if (TEXT_PRINTER_PAUSED != 0) {
        return;
    }
    if (printer->unk2D != 0) {
        printer->unk2D = printer->callback(&printer->template, printer->unk2E);
        return;
    }

    printer->unk2E = 0;
    GenerateFontHalfRowLookupTable(printer->template.fgColor, printer->template.bgColor, printer->template.shadowColor);

    u32 result;
    BOOL printed = FALSE;
    for (int i = 0; i < MAX_GLYPHS_PER_FRAME; i++) {
        result = RenderFont(printer);
        if (result != RENDER_PRINT) {
            break;
        }
        printed = TRUE;
        // stop at anything the printer has to wait for: a timed pause, or a callback signal (sound, prompt)
        if (printer->delayCounter != 0 || printer->unk2E != 0) {
            break;
        }
    }

    if (result == RENDER_FINISH) {
        if (printed) {
            CopyWindowToVram(printer->template.window);
        }
        DestroyTextPrinterSysTask(printer->id);
        return;
    }
    if (printed) {
        CopyWindowToVram(printer->template.window);
    }
    if (printer->callback != NULL) {
        printer->unk2D = printer->callback(&printer->template, printer->unk2E);
    }
}
