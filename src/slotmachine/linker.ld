/* Overlay 152 */
/* hack: Platinum's slot machine (slots/, built by slots/build.sh), loaded where Voltorb Flip (overlay 122) loads */
OUTPUT_ARCH(arm)
MEMORY {

        rom     : ORIGIN = 0x021E5900, LENGTH = 0x24000
        ewram   : ORIGIN = 0x021E5900, LENGTH = 0x24000
}

SECTIONS {
        .text : {

                FILL (0xABCD)

                __text_start = . ;
                *(.init)
                *(.text)
                *(.ctors)
                *(.dtors)
                *(.rodata)
                *(.fini)
                *(COMMON)
                __text_end  = . ;

                __bss_start__ = . ;
                *(.bss)
                __bss_end__ = . ;
        _end = __bss_end__ ;
        __end__ = __bss_end__ ;
        } >rom = 0xff
}