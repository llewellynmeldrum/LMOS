#pragma once

#define VGA_WIDTH 80
#define VGA_HEIGHT 25
#define VGA_ADDRESS 0xB8000

#define TERM_IDX(x, y) (y * VGA_WIDTH + x)

typedef struct Term {
    size_t row;
    size_t col;
    u8 color;
    u16 *buf;
} Term;

extern Term term;

void term_setup(void);
void term_setcolor(u8 color);
void term_setc(char c, uint8_t color, size_t x, size_t y);
void term_puts_len(const char *str, size_t sz);
void term_puts(const char *str);
