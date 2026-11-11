/**
 *  hack: working slot machines in Celadon's Game Corner (Parts 1 and 2).
 *
 *  The game is Platinum's (pret/pokeplatinum overlay 101), ported in slots/ and built into overlay 152, which loads
 *  where Voltorb Flip does.  The slot graphics are HeartGold's own leftover /data/slot.narc; the text is 924.txt.
 *
 *  This replaces ScrCmd_CasinoGame (script command "casino_game machine, city", 0x0204FE84 region in arm9; see hooks).
 *  HeartGold's US game only ever calls it for Voltorb Flip (city 0 = Goldenrod, 1 = Celadon); city 2 is new and
 *  starts the slot machine for that machine number.
 */
#include "config.h"
#include "types.h"
#include "script.h"
#include "save.h"

struct SlotMachineArgs {        // = UnkStruct_0203E348 in slots/include/struct_defs/struct_0203E348.h
    int *coinsPtr;
    int setting;                // 0-5
    void *records;              // NULL: the port keeps no game records
    int bonusWins;
    int msgBoxFrame;
    u16 *saveCoins;             // written on exit
    int coins;
};

typedef struct {
    int (*init)(void *man, int *state);
    int (*main)(void *man, int *state);
    int (*exit)(void *man, int *state);
    u32 overlayId;
} OverlayManagerTemplate;

#define SLOT_MACHINE_OVERLAY 152
#define SCRIPTENV_RUNNING_APP_DATA 20

// overlay 152 entry points (slots/build/slots.sym; keep in sync with slots/build.sh)
extern int SlotMachine_Init(void *man, int *state);
extern int SlotMachine_Main(void *man, int *state);
extern int SlotMachine_Exit(void *man, int *state);

extern void *LONG_CALL Heap_AllocAtEnd(u32 heapID, u32 size);
extern void LONG_CALL MI_CpuFill8(void *dest, u8 data, u32 size);
extern void LONG_CALL FieldSystem_LaunchApplication(FieldSystem *fsys, const OverlayManagerTemplate *tmpl, void *args);
extern u16 *LONG_CALL Save_PlayerData_GetCoinsAddr(void *saveData);
extern void *LONG_CALL Save_PlayerData_GetOptionsAddr(void *saveData);
extern u32 LONG_CALL Options_GetFrame(void *options);
extern void *LONG_CALL VoltorbFlip_LaunchApp(FieldSystem *fsys, u32 luck);
extern u32 LONG_CALL SlotLuckiness(void *saveData, u8 machineId, u8 city);
extern void LONG_CALL SetupNativeScript(SCRIPTCONTEXT *ctx, BOOL (*func)(SCRIPTCONTEXT *));
extern BOOL LONG_CALL ScrNative_WaitApplication_DestroyTaskData(SCRIPTCONTEXT *ctx);
extern void *LONG_CALL Save_FriendGroup_Get(void *saveData);
extern u32 LONG_CALL sub_0202C7DC(void *friendGroup); // the day's random number (HeartGold's slot luck seed)
extern u32 LONG_CALL GetLCRNGSeed(void);
extern void LONG_CALL SetLCRNGSeed(u32 seed);
extern u16 LONG_CALL LCRandom(void);

#define HEAP_ID_FIELD2 11 // HeartGold: HEAP_ID_FIELD2 (Voltorb Flip's args come from here too)

/**
 *  Platinum's machine settings (sub_0203E484): each of 12 machines gets one of these, shuffled by the day's seed,
 *  so a lucky machine moves around from day to day.  0 = tightest, 5 = loosest.
 */
static u32 SlotMachine_GetSetting(void *saveData, u32 machineId)
{
    static const u8 sSettings[12] = { 0, 5, 1, 1, 4, 4, 2, 2, 2, 3, 3, 3 };
    u8 settings[12];
    u32 oldSeed = GetLCRNGSeed();

    for (u32 i = 0; i < 12; i++) {
        settings[i] = sSettings[i];
    }
    SetLCRNGSeed(sub_0202C7DC(Save_FriendGroup_Get(saveData)));
    for (u32 i = 0; i < 12; i++) {
        for (u32 j = i + 1; j < 12; j++) {
            u32 slot = LCRandom() % 12;
            u8 temp = settings[i];
            settings[i] = settings[slot];
            settings[slot] = temp;
        }
    }
    SetLCRNGSeed(oldSeed);
    return settings[machineId % 12];
}

static void *SlotMachine_Launch(FieldSystem *fsys, u32 machineId)
{
    static const OverlayManagerTemplate sTemplate = { SlotMachine_Init, SlotMachine_Main, SlotMachine_Exit, SLOT_MACHINE_OVERLAY };
    void *saveData = fsys->savedata;
    struct SlotMachineArgs *args = Heap_AllocAtEnd(HEAP_ID_FIELD2, sizeof(struct SlotMachineArgs));

    MI_CpuFill8(args, 0, sizeof(struct SlotMachineArgs));
    args->saveCoins = Save_PlayerData_GetCoinsAddr(saveData);
    args->coins = *args->saveCoins;
    args->coinsPtr = &args->coins;
    args->setting = SlotMachine_GetSetting(saveData, machineId);
    args->records = NULL;
    args->msgBoxFrame = Options_GetFrame(Save_PlayerData_GetOptionsAddr(saveData));
    FieldSystem_LaunchApplication(fsys, &sTemplate, args);
    return args;
}

BOOL LONG_CALL SlotMachine_ScrCmd_CasinoGame(SCRIPTCONTEXT *ctx)
{
    u8 machineId = ScriptReadByte(ctx);
    u8 city = ScriptReadByte(ctx); // 0 = Goldenrod, 1 = Celadon (Voltorb Flip); 2 = slot machine
    void **args = FieldSysGetAttrAddr(ctx->fsys, SCRIPTENV_RUNNING_APP_DATA);

    if (city == 2) {
        *args = SlotMachine_Launch(ctx->fsys, machineId);
    } else {
        *args = VoltorbFlip_LaunchApp(ctx->fsys, SlotLuckiness(ctx->fsys->savedata, machineId, city));
    }
    SetupNativeScript(ctx, ScrNative_WaitApplication_DestroyTaskData);
    return TRUE;
}
