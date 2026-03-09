/*
Begin execution at this symbol (the entry point in boot.s)
*/
ENTRY(_start)

SECTIONS{
    /*2MiB is recommended for multiboot2*/
    . = 2M;


    .text BLOCK(4K) : ALIGN(4K){
        *(.multiboot)   /* 1. The multiboot header. Recall that it must be very early.*/
        *(.text)        /* 2. contains _main entry point*/
    }
    /* Read only data which is initailized */
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

