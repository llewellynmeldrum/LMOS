#include "vga.h"
#include <kernel/types.h>

Term term;
void term_setup(void) {
    term = (Term){
        .row = 0,
        .col = 0,
        .color = VGA_ENTRY_COLOR(VGA_COLOR_GREEN, VGA_COLOR_BLACK),
        .buf = (u16 *)VGA_ADDRESS,
    };
    for (size_t y = 0; y < VGA_HEIGHT; y++) {
        for (size_t x = 0; x < VGA_WIDTH; x++) {
            term.buf[TERM_IDX(x, y)] = VGA_ENTRY(' ', term.color);
        }
    }
};
void term_setcolor(u8 color) { term.color = color; }
void term_setc(char c, uint8_t color, size_t x, size_t y) {
    term.buf[TERM_IDX(x, y)] = VGA_ENTRY(c, color);
}
void term_putc(char c) {
    if (c == '\n') {
        term.col = 0;
        term.row++;
        return;
    }
    term_setc(c, term.color, term.col, term.row);
    term.col++;
    if (term.col == VGA_WIDTH) {
        term.col = 0;
        term.row++;
        if (term.row == VGA_HEIGHT) {
            term.row = 0;
        }
    }
}

void term_puts_len(const char *str, size_t sz) {
    for (size_t i = 0; i < sz; i++) {
        term_putc(str[i]);
    }
}
void term_puts(const char *str) {
    //
    term_puts_len(str, strlen(str));
}
