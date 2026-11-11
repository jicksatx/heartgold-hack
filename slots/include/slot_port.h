#ifndef SLOT_PORT_H
#define SLOT_PORT_H
// hack: Platinum's slot machine (pret/pokeplatinum overlay 101) ported to HeartGold.  Ids that differ between the
// games are redirected here; the functions Platinum gets from its own engine are mapped onto HeartGold's in shim.c.

#define SLOT_HEAP_ID      160 // HeartGold's HEAP_ID_VOLTORB_FLIP (free while the slots run)
#define SLOT_MSG_NARC     27                 // HeartGold's NARC_msgdata_msg
#define SLOT_TEXT_BANK    924                // data/text/924.txt
#define SLOT_MAX_COINS    50000

struct NARC;
struct NARC *SlotPort_OpenSlotNarc(int heapID); // HeartGold's /data/slot.narc

#endif
