/*
 * Marks _start as the entry point for the kernel.
*/
ENTRY(_start)

SECTIONS{
    /* 1MiB is the recommended size for multiboot, 2MiB is the recommended size for multiboot2*/
    . = 1M;


    .text BLOCK(4K) : ALIGN(4K){
        *(.multiboot)   /* 1. The multiboot header. It must be very early.*/
        *(.text)        /* 2. contains _main entry point*/
    }

    /* Read only data that is initailized */
    .rodata BLOCK(4K) : ALIGN(4K){
        *(.rodata)
    }
    /* R/W data which is initailized */
    .data BLOCK(4K) : ALIGN(4K){
        *(.data)
    }

    /* Read only data which is NOT initailized, and our call stack*/
    .bss BLOCK(4K) : ALIGN(4K){
        *(COMMON)
        *(.bss)
    }
}

