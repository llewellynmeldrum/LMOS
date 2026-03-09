
/*
We use multiline comments because they are the most widely supported by the gnu assmebler. Different types of comments are supported by different arch's

Credits: osdev.org (https://wiki.osdev.org/Bare_Bones)

This file serves to bootsttrap the OS.
*/

/* Declare some constants*/
.set ALIGN,     1<<0
.set MEMINFO,   1<<1
.set FLAGS,     ALIGN  | MEMINFO
.set MAGIC,     0x1BADB002
.set CHECKSUM, -(MAGIC + FLAGS)
.set INIT_STACK_SZ, 16384   /* 16KiB <-- WARNING: Ensure this number is a multiple of 16B */

/* Declares a 'multiboot' section, which marks the program as a kernel.
source: https://www.gnu.org/software/grub/manual/multiboot/multiboot.html

These values come from the multiboot standard. The standard tells us:
- make the header 4 byte (32bit) aligned
- the header must occur within the first 8KiB of the OS image

*/
.section .multiboot 
.align 4            
.long MAGIC             /*  Allocate 4 bytes and initialize it with <...> */
.long FLAGS
.long CHECKSUM

/*
Multiboot is very barebones. We dont even get a call stack, nor are the registers which normally point to its contents initialized. We must do this ourselves.
Also, the stack must be 16B aligned according to System V ABI. Compiler will shit itself else-wise.
*/

.section bss
.align 16
stack_bottom: 
    .skip INIT_STACK_SZ 
stack_top:

/*
Our linker script will specify _start as the kernels entry point. We dont return from this function, as the bootloader is gone after the kernel has begun running.
*/

.section .text /* start of the instructions */
.global _start  /* allows the _start label to be seen by the linker.*/
.type _start, @function
_start:
    /*
    At this point, we are now in 32-bit protected mode. We have 100% full control of the CPU (essentially).
    There are no safeguards or restrictions. "I am free" - Eren Yeager 
    */

    /* Set up the stack to how C expects it (on x86). */
    mov $stack_top, %esp

    /*
    In future, this is a good place to do things like enabling paging, C++ global constructors/exceptions, and the GDT (global dsecriptor table)

    After that, we enter the high-level kernel we write in C.
    
    /* WARNING: The stack MUST be 16B aligned at the time of this call!!!

    in our case, we aligned the stack to 16B and then pushed 8KiB (multiple of 16B). So we should be good
    If you ever change the init stack size later, be aware of this.
    */
    call kernel_main

    /* Now, we want to start a (truly) infinite loop. */
    cli     /* <-- NOTE: Disables interupts */
1:  hlt     /* <-- NOTE: Await next interupt (they are disabled, it will never come)*/
    jmp 1b  /* <-- NOTE: If we somehow reach here, (non-maskable interupt/system management mode), loop*/

/* Set the size of _start to (current location) - (_start). */
.size _start, . - _start




