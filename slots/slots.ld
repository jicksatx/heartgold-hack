/* hack: the slot machine overlay (152), loaded where Voltorb Flip (overlay 122) loads */
OUTPUT_ARCH(arm)
ENTRY(ov101_021D0D80)
SECTIONS {
    . = 0x021E5900;
    .text : {
        __slots_start = .;
        *(.text*) *(.rodata*) *(.data*) *(.sdata*)
        . = ALIGN(4);
        *(.bss*) *(.sbss*) *(COMMON)
        . = ALIGN(4);
        LONG(0x534C4F54) /* "TOLS": keeps the zeroed .bss inside the binary */
        __slots_end = .;
    }
    /DISCARD/ : { *(.debug*) *(.comment) *(.mwcats*) *(.ARM.attributes) }
}
/* the app's init / main / exit (OverlayManager template in src/field/slot_machine.c) */
SlotMachine_Init = ov101_021D0D80;
SlotMachine_Main = ov101_021D0E40;
SlotMachine_Exit = ov101_021D0EE4;
