// hack: the engine functions Platinum's slot machine calls, mapped onto HeartGold's (pret/pokeheartgold names).
// Platinum's own sprite, cell/char/palette transfer, OAM, VRAM-transfer and overworld-anim helpers are compiled
// into this overlay as they are (slots/src); only the shared engine services below come from HeartGold.
#include <nitro.h>

#include "slot_port.h"

typedef void *Ptr;
typedef void (*VoidCB)(void *);
typedef void (*TaskFunc)(void *task, void *data);
typedef BOOL (*PrinterCB)(void *printer, u16 a);

// ---- HeartGold ----
extern Ptr OverlayManager_GetArgs(Ptr man);
extern Ptr OverlayManager_GetData(Ptr man);
extern void OverlayManager_FreeData(Ptr man);
extern Ptr OverlayManager_CreateAndGetData(Ptr man, u32 size, int heapID);
extern Ptr BgConfig_Alloc(int heapID);
extern void BgTilemapRectChangePalette(Ptr bg, u8 bgId, u8 x, u8 y, u8 w, u8 h, u8 pal);
extern void BgClearTilemapBufferAndCommit(Ptr bg, u8 bgId);
extern void BG_ClearCharDataRange(u8 bgId, u32 size, u32 offset, int heapID);
extern void BgCommitTilemapBufferToVram(Ptr bg, u8 bgId);
extern void FreeBgTilemapBuffer(Ptr bg, u8 bgId);
extern void InitBgFromTemplate(Ptr bg, u8 bgId, const void *tmpl, u8 bgType);
extern void BG_LoadPlttData(u32 location, const void *data, u16 size, u16 offset);
extern void BG_LoadScreenTilemapData(Ptr bg, u8 bgId, const void *data, u32 size);
extern void BG_LoadCharTilesData(Ptr bg, u8 bgId, const void *data, u32 size, u32 tileStart);
extern void DoScheduledBgGpuUpdates(Ptr bg);
extern void ScheduleBgTilemapBufferTransfer(Ptr bg, u8 bgId);
extern void SetBothScreensModesAndDisable(const void *modes);
extern void AddWindow(Ptr bg, Ptr window, const void *tmpl);
extern void ClearWindowTilemapAndCopyToVram(Ptr window);
extern void FillWindowPixelBuffer(Ptr window, u8 fill);
extern void RemoveWindow(Ptr window);
extern void ScheduleWindowCopyToVram(Ptr window);
extern void DrawFrameAndWindow2(Ptr window, BOOL dontCopy, u16 baseTile, u8 pal);
extern void ClearFrameAndWindow2(Ptr window, BOOL dontCopy);
extern void LoadUserFrameGfx1(Ptr bg, int layer, u16 baseTile, u8 pal, u8 frame, int heapID);
extern void LoadUserFrameGfx2(Ptr bg, int layer, u16 baseTile, u8 pal, u8 frame, int heapID);
extern void LoadFontPal1(int location, int offset, int heapID);
extern u16 GF_DegreeToSinCosIdx(u16 deg);
extern u16 LCRandom(void);
extern void HBlankInterruptDisable(void);
extern void Main_SetVBlankIntrCB(VoidCB cb, void *arg);
extern BOOL IsPaletteFadeFinished(void);
extern void BeginNormalPaletteFade(int mode, int typeMain, int typeSub, u16 color, int steps, int framesPerStep, int heapID);
extern Ptr NewMsgDataFromNarc(int type, int narc, s32 fileId, int heapID);
extern void ReadMsgDataIntoString(Ptr msgData, s32 strno, Ptr dest);
extern void DestroyMsgData(Ptr msgData);
extern void NARC_Delete(Ptr narc);
extern void PlayBGM(u16 seqno);
extern void PlaySE(u16 seqno);
extern void PlayCry(u16 species, u8 form);
extern void StopBGM(u16 seqno, int frames);
extern void sub_020053A8(u8 playerNo, BOOL pause); // Sound_SetBGMPlayerPaused
extern Ptr String_New(u32 maxsize, int heapID);
extern void String_Delete(Ptr str);
extern Ptr MessageFormat_New(int heapID);
extern void MessageFormat_Delete(Ptr fmt);
extern Ptr SysTask_CreateOnMainQueue(TaskFunc func, void *data, u32 priority);
extern Ptr SysTask_CreateOnVBlankQueue(TaskFunc func, void *data, u32 priority);
extern Ptr SysTask_CreateOnVWaitQueue(TaskFunc func, void *data, u32 priority);
extern void SysTask_Destroy(Ptr task);
extern u8 AddTextPrinterParameterized(Ptr window, int fontId, Ptr text, u32 x, u32 y, u32 speed, PrinterCB cb);
extern void GfGfx_SetBanks(const void *banks);
extern void GfGfx_DisableEngineAPlanes(void);
extern void GfGfx_DisableEngineBPlanes(void);
extern void GfGfx_EngineATogglePlanes(u8 mask, u8 enable);
extern void GfGfx_EngineBTogglePlanes(u8 mask, u8 enable);
extern void *Heap_Alloc(int heapID, u32 size);

// ---- Platinum names ----
Ptr ApplicationManager_Args(Ptr man) { return OverlayManager_GetArgs(man); }
Ptr ApplicationManager_Data(Ptr man) { return OverlayManager_GetData(man); }
void ApplicationManager_FreeData(Ptr man) { OverlayManager_FreeData(man); }
Ptr ApplicationManager_NewData(Ptr man, u32 size, int heapID) { return OverlayManager_CreateAndGetData(man, size, heapID); }

Ptr BgConfig_New(int heapID) { return BgConfig_Alloc(heapID); }
void Bg_ChangeTilemapRectPalette(Ptr bg, u8 l, u8 x, u8 y, u8 w, u8 h, u8 p) { BgTilemapRectChangePalette(bg, l, x, y, w, h, p); }
void Bg_ClearTilemap(Ptr bg, u8 l) { BgClearTilemapBufferAndCommit(bg, l); }
void Bg_ClearTilesRange(u8 l, u32 size, u32 offset, int heapID) { BG_ClearCharDataRange(l, size, offset, heapID); }
void Bg_CopyTilemapBufferToVRAM(Ptr bg, u8 l) { BgCommitTilemapBufferToVram(bg, l); }
void Bg_FreeTilemapBuffer(Ptr bg, u8 l) { FreeBgTilemapBuffer(bg, l); }
void Bg_InitFromTemplate(Ptr bg, u8 l, const void *t, u8 type) { InitBgFromTemplate(bg, l, t, type); }
void Bg_LoadPalette(u8 l, void *src, u16 size, u16 offset) { BG_LoadPlttData(l, src, size, offset); } // both split main/sub at 4
void Bg_LoadTilemapBuffer(Ptr bg, u8 l, void *src, u32 size) { BG_LoadScreenTilemapData(bg, l, src, size); }
void Bg_LoadTiles(Ptr bg, u8 l, void *src, u32 size, u32 start) { BG_LoadCharTilesData(bg, l, src, size, start); }
void Bg_RunScheduledUpdates(Ptr bg) { DoScheduledBgGpuUpdates(bg); }
void Bg_ScheduleTilemapTransfer(Ptr bg, u8 l) { ScheduleBgTilemapBufferTransfer(bg, l); }
void SetAllGraphicsModes(const void *modes) { SetBothScreensModesAndDisable(modes); }

void Window_AddFromTemplate(Ptr bg, Ptr w, const void *t) { AddWindow(bg, w, t); }
void Window_ClearAndCopyToVRAM(Ptr w) { ClearWindowTilemapAndCopyToVram(w); }
void Window_FillTilemap(Ptr w, u8 v) { FillWindowPixelBuffer(w, v); }
void Window_Remove(Ptr w) { RemoveWindow(w); }
void Window_ScheduleCopyToVRAM(Ptr w) { ScheduleWindowCopyToVram(w); }
void Window_DrawMessageBoxWithScrollCursor(Ptr w, u8 skip, u16 tile, u8 pal) { DrawFrameAndWindow2(w, skip, tile, pal); }
void Window_EraseMessageBox(Ptr w, u8 skip) { ClearFrameAndWindow2(w, skip); }
void LoadMessageBoxGraphics(Ptr bg, u8 l, u16 tile, u8 pal, u8 frame, u32 heapID) { LoadUserFrameGfx2(bg, l, tile, pal, frame, heapID); }
void LoadStandardWindowGraphics(Ptr bg, u8 l, u16 tile, u8 pal, u8 type, u32 heapID) { LoadUserFrameGfx1(bg, l, tile, pal, type, heapID); }
void Font_LoadScreenIndicatorsPalette(int loc, u32 offset, int heapID) { LoadFontPal1(loc, offset, heapID); }
u8 Text_AddPrinterWithParams(Ptr w, u32 font, const Ptr str, u32 x, u32 y, u32 delay, PrinterCB cb) { return AddTextPrinterParameterized(w, font, (Ptr)str, x, y, delay, cb); }

void GXLayers_SetBanks(const void *banks) { GfGfx_SetBanks(banks); }
void GXLayers_DisableEngineALayers(void) { GfGfx_DisableEngineAPlanes(); }
void GXLayers_DisableEngineBLayers(void) { GfGfx_DisableEngineBPlanes(); }
void GXLayers_EngineAToggleLayers(u8 mask, u8 enable) { GfGfx_EngineATogglePlanes(mask, enable); }
void GXLayers_EngineBToggleLayers(u8 mask, u8 enable) { GfGfx_EngineBTogglePlanes(mask, enable); }

u32 GameRecords_AddToRecordValue(Ptr records, int id, u32 toAdd) { return 0; } // the port passes no records
u16 CalcAngleRotationIdx_Wraparound(u16 degrees) { return GF_DegreeToSinCosIdx(degrees); }
u16 LCRNG_Next(void) { return LCRandom(); }
void DisableHBlank(void) { HBlankInterruptDisable(); }
void SetVBlankCallback(VoidCB cb, void *data) { Main_SetVBlankIntrCB(cb, data); }
BOOL IsScreenFadeDone(void) { return IsPaletteFadeFinished(); }
void StartScreenFade(int mode, int typeMain, int typeSub, u16 color, int steps, int frames, int heapID) { BeginNormalPaletteFade(mode, typeMain, typeSub, color, steps, frames, heapID); }

Ptr MessageLoader_Init(int mode, int narcID, u32 bankID, u32 heapID) { return NewMsgDataFromNarc(mode, narcID, bankID, heapID); }
void MessageLoader_GetString(const Ptr loader, u32 entryID, Ptr string) { ReadMsgDataIntoString((Ptr)loader, entryID, string); }
void MessageLoader_Free(Ptr loader) { DestroyMsgData(loader); }
Ptr String_Init(u32 size, u32 heapID) { return String_New(size, heapID); }
void String_Free(Ptr s) { String_Delete(s); }
Ptr StringTemplate_Default(u32 heapID) { return MessageFormat_New(heapID); }
void StringTemplate_Free(Ptr t) { MessageFormat_Delete(t); }

Ptr SysTask_Start(TaskFunc cb, void *p, u32 prio) { return SysTask_CreateOnMainQueue(cb, p, prio); }
Ptr SysTask_ExecuteOnVBlank(TaskFunc cb, void *p, u32 prio) { return SysTask_CreateOnVBlankQueue(cb, p, prio); }
Ptr SysTask_ExecuteAfterVBlank(TaskFunc cb, void *p, u32 prio) { return SysTask_CreateOnVWaitQueue(cb, p, prio); }
void SysTask_Done(Ptr task) { SysTask_Destroy(task); }

BOOL Sound_PlayBasicBGM(u16 bgm) { PlayBGM(bgm); return TRUE; }
BOOL Sound_PlayEffect(u16 seq) { PlaySE(seq); return TRUE; }
BOOL Sound_PlayPokemonCry(u16 species, u8 form) { PlayCry(species, form); return TRUE; }
void Sound_StopBGM(u16 bgm, int frames) { StopBGM(bgm, frames); }
void Sound_SetBGMPlayerPaused(u8 player, BOOL paused) { sub_020053A8(player, paused); }

void NARC_dtor(Ptr narc) { NARC_Delete(narc); }

// HeartGold's NARC (src/filesystem.c), opened by path instead of through the archive table
typedef struct {
    FSFile file;
    u32 btaf_start;
    u32 gmif_start;
    u16 num_files;
} HGNarc;

struct NARC *SlotPort_OpenSlotNarc(int heapID) {
    HGNarc *narc = Heap_Alloc(heapID, sizeof(HGNarc));
    u32 btnf_start;
    u32 chunk_size;
    if (narc != NULL) {
        narc->btaf_start = 0;
        FS_InitFile(&narc->file);
        FS_OpenFile(&narc->file, "data/slot.narc");
        FS_SeekFile(&narc->file, 12, FS_SEEK_SET);
        FS_ReadFile(&narc->file, &narc->btaf_start, 2);
        FS_SeekFile(&narc->file, (s32)(narc->btaf_start + 4), FS_SEEK_SET);
        FS_ReadFile(&narc->file, &chunk_size, 4);
        FS_ReadFile(&narc->file, &narc->num_files, 2);
        btnf_start = narc->btaf_start + chunk_size;
        FS_SeekFile(&narc->file, (s32)(btnf_start + 4), FS_SEEK_SET);
        FS_ReadFile(&narc->file, &chunk_size, 4);
        narc->gmif_start = btnf_start + chunk_size;
    }
    return (struct NARC *)narc;
}

// only used by sprite-resource paths the slot machine never takes
void *LoadMemberFromNARC(int narcID, u32 member, BOOL compressed, int heapID, BOOL atEnd) { return NULL; }
void *ReadFileToHeap(int heapID, const char *path) { return NULL; }

// Platinum's GF_ASSERT keeps its expression (some calls live inside one, e.g. NNS_G2dGetNewOamManagerInstance);
// a failed assert is ignored, as in a retail HeartGold build
void ErrorHandling_AssertFail(void) { }
