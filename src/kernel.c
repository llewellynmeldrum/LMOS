#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#include "vga_helper.h"

#if defined(__linux__)
#error "Bro forgot to use the cross compiler"
#endif

void kernel_main(void) {
    term_setup();
    term_puts("Hello, kernel world! This is lmos speaking!");
    term_puts("\nthis is a new line!");
}
