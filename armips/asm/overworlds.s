.nds
.thumb

.open "base/overlay/overlay_0001.bin", 0x021E5900

//.org 0x021F73C4
//
//.halfword NUM_OF_MON_OVERWORLDS + 0x1E4 // update the limiter
//// 0x1E4 is the start of the follower mon tags

// ov01_021F72DC (a map object's render data): sprites 0x1AC..limit keep it in the follower layout (unk108[0]).
// hg-engine nopped the upper bound so every new tag counted as a follower; the hack's own sheets (the Red player sprites,
// 7000+ = NEW_NPC_TAG_START) are billboards like the vanilla player, so the bound is back and stops below them.
// (Build 75: with the nop, saving / Pokegear / heal / bike as Red read the billboard data as a follower model and
// melonDS aborted at 0x02023F9C.)  followers are MON_OVERWORLD_TAG_START (2500) + species.
.org 0x021F7394
bgt 0x021F73A0

.org 0x021F73C4
.word 6999 // NEW_NPC_TAG_START - 1

.close


// limiter for hall of fame overworlds

.open "base/overlay/overlay_0063.bin", 0x0221BE20

.org 0x0221E448

.word NUM_OF_MONS

.close


// limiter for pokeathlon overworlds

.open "base/overlay/overlay_0096.bin", 0x021E5900

.org 0x021E91FC

.word NUM_OF_MONS

.close


.open "base/arm9.bin", 0x02000000

.org 0x0206A330
.word NUM_OF_MONS

//.org 0x0206A338
//
//
//.area 0x28
//
//// rewrite this to use a byte per mon instead of a whole hword
//// might rewrite to use a nybble eventually
//// pokemon above brute bonnet can not have gender differences atm
//
//// r0 is species
//does_species_have_dimorphism:
//    push {r3, lr}
//    cmp r0, #0
//    ble @@_invalidMon
//    ldr r1, =493 * 2
//    cmp r0, r1
//    ble @@_validMon
//
//@@_invalidMon:
//    mov r0, #0
//    b @@_getDimorphism
//
//@@_validMon:
//    sub r0, r0, #1
//
//@@_getDimorphism:
//    ldr r1, =0x020FECAE
//    ldrb r0, [r1, r0]
//    pop {r3, pc}
//
//.pool
//
//.endarea

.close
