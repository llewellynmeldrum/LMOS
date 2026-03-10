# Setup some constants for the mutliboot header
.set ALIGN,     1<<0            # FLAGS[0] Loaded modules are aligned on page boundaries
.set MEMINFO,   1<<1            # FLAGS[1] Provide us with a memory map
.set FLAGS, ALIGN  | MEMINFO
.set MAGIC,     0x1BADB002      #This identfies (to grub?) that we are defining a multiboot1 header.
.set CHECKSUM, -(MAGIC + FLAGS)

#Setup some other constants
.set INIT_STACK_SZ, 16384 # 16KiB <-- WARNING: Ensure this number is a multiple of 16B 


# Declares a 'multiboot' section, which marks the program as a kernel.
# Align the header at 4B boundary.
.section .multiboot 
.align 4
.long MAGIC             
.long FLAGS
.long CHECKSUM



# Create the section for uninitialized static data and the stack.
.section bss
.align 16
stack_bottom: 
    .skip INIT_STACK_SZ 
stack_top:


# Kernel entry point, as specified by our linker.ld script
# We dont return from this function, as the bootloader is gone after the kernel has begun running.

# create the section for code
.section .text 
.global _start          # Define _start label as global, making it visible to the linker.
.type _start, @function # Define the ELF symbol type of _start
_start:
    # At this point, we are now in 32-bit protected mode. We have 100% full control of the CPU (essentially).
    
    # Set up the stack 
    mov $stack_top, %esp

    # In future, this is a good place to do things like enabling paging,call  C++ global constructors/exceptions, and the GDT (global dsecriptor table)


    # call our high level kernel
    call kernel_main
    #WARNING: The stack MUST be 16B aligned at the time of this call!!!

    # if the kernel returns for whatever reason, we want to infinitely hang.
    cli     # Disable interupts 
1:  hlt     # Await next interupt. Bro (the cpu) doesnt know theyre disabled, point and laugh 
    jmp 1b  # If we somehow reach here, (perhaps from non-maskable interupt/system management mode), just loop

# Set the size of _start to current location(.) - location of _start (_start)
.size _start, . - _start




/*
#NOTE:
 GNU ASM SYNTAX NOTES:

source: https://ftp.gnu.org/old-gnu/Manuals/gas/html_chapter/as_toc.html

#NOTE:
 SECTIONS:

#NOTE:
 ASSEMBLER DIRECTIVES:

.align  <A>, [B], [C]
    <A>: Pad the current location counter, in the current subsection, st. it aligns with `A` byte boundaries.
    [B]: Optionally, specify the byte used for padding. Default is usually 0 but might be NO-OP on some systems
    [C]: Optionally, specify the maximum number of bytes that this instruction can skip.

.long   <CONSTANT>      Allocate 4 bytes and initialize it with <CONSTANT>
.section <>

*/

