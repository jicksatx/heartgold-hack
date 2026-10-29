#include "../../include/config.h"
#include "../../include/types.h"
#include "../../include/script.h"
#include "../../include/overlay.h"
#include "../../include/randomizer.h"
#include "../../include/constants/species.h"

/*
 *  hack: in-game trades follow the area randomizer (data/NpcTradeAskBanks.h, scripts/hack/gen_trade_banks.py).
 *
 *  the Pokemon a trader offers becomes a random species with a similar base stat total (the area randomizer's rule,
 *  with a pseudo-area per trade), and the Pokemon asked for becomes exactly what the area randomizer turned it (or its
 *  pre-evolution) into in a wild area where it lives, so it can always be caught in that save.  done once, when the
 *  script loads the trade (load_npc_trade), so the dialogue, the species check and the traded Pokemon all agree.
 *  Kenya (HeartGold's loan Spearow) is left alone.
 */

#ifdef RANDOMIZE_WILD_ENCOUNTERS

#include "../../data/NpcTradeAskBanks.h"

#define NPC_TRADE_OVERLAY       23
#define NPC_TRADE_KENYA         7
#define SCRIPTENV_MISC_DATA_PTR 21
#define HEAP_ID_FIELD2          11

#define NPCTradeApp_Init ((void *(*)(u32 heapId, u32 tradeNo))(0x022598C0 | 1))

/**
 *  @brief replaces ScrCmd_LoadNPCTrade (script command 470, 0x0204527C)
 */
BOOL LONG_CALL Randomizer_ScrCmd_LoadNPCTrade(SCRIPTCONTEXT *ctx)
{
    void **work = FieldSysGetAttrAddr(ctx->fsys, SCRIPTENV_MISC_DATA_PTR);
    u8 tradeNo = ScriptReadByte(ctx);

    HandleLoadOverlay(NPC_TRADE_OVERLAY, 2);
    *work = NPCTradeApp_Init(HEAP_ID_FIELD2, tradeNo);

    if (tradeNo != NPC_TRADE_KENYA && tradeNo < NELEMS(sTradeAskBank)) {
        s32 *trade = *(s32 **)(*work); // NPCTrade: give_species at 0, ask_species at 0x4C
        trade[0] = Randomizer_RemapWildSpecies(trade[0], 0x300 + tradeNo);
        if (sTradeAskBank[tradeNo][0] != 0xFFFF) {
            trade[19] = Randomizer_RemapWildSpecies(sTradeAskBank[tradeNo][1], sTradeAskBank[tradeNo][0]);
        } else {
            trade[19] = Randomizer_RemapWildSpecies(trade[19], 0x380 + tradeNo);
        }
    }
    return FALSE;
}

#endif // RANDOMIZE_WILD_ENCOUNTERS
