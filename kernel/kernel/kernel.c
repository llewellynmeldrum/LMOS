#include <kernel/tty.h>

void kernel_main(void) {
    term_setup();
    term_puts("Hello, kernel world! This is lmos speaking!");
    term_puts("\nthis is a new line!");
}
