#pragma once
#include "string.h"
#include "types.h"
#include <stddef.h>

typedef enum VGA_COLOR {
    VGA_COLOR_BLACK = 0,
    VGA_COLOR_BLUE = 1,
    VGA_COLOR_GREEN = 2,
    VGA_COLOR_CYAN = 3,
    VGA_COLOR_RED = 4,
    VGA_COLOR_MAGENTA = 5,
    VGA_COLOR_BROWN = 6,
    VGA_COLOR_LIGHT_GREY = 7,
    VGA_COLOR_DARK_GREY = 8,
    VGA_COLOR_LIGHT_BLUE = 9,
    VGA_COLOR_LIGHT_GREEN = 10,
    VGA_COLOR_LIGHT_CYAN = 11,
    VGA_COLOR_LIGHT_RED = 12,
    VGA_COLOR_LIGHT_MAGENTA = 13,
    VGA_COLOR_LIGHT_BROWN = 14,
    VGA_COLOR_WHITE = 15,
} VGA_COLOR;

#define VGA_ENTRY_COLOR(fg, bg) ((fg | bg) << 4)

#define VGA_ENTRY(uc, color) ((u16)(uc) | (u16)(color << 8U))

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
