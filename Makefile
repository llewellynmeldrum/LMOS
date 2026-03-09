.PHONY: clean all

define GRUB_CFG
menuentry "lmos" {
	multiboot /boot/myos
}

endef



BUILD_DIR	:=build
BIN_DIR		:=bin
SRC_DIR		:=src

AS	 		:=i686-elf-as
LD 			:=i686-elf-ld
CC 			:=i686-elf-gcc
CFLAGS		:=-Iinclude -std=c11 -ffreestanding -O2 -Wall -Wextra
LDFLAGS		:=-ffreestanding -O2 -nostdlib -lgcc

SRC := $(wildcard $(SRC_DIR)/*.c)
OBJ := $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(SRC))
OBJ += $(BUILD_DIR)/boot.o

verify: all
	./verifyKernelMutliboot.zsh

boot-img: verify
	rm -rf isodir/
	mkdir -p isodir/boot/grub
	cp bin/lmos isodir/boot/lmos
	cp grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o lmos.iso isodir

run: boot-img
	qemu-system-i386 -cdrom lmos.iso


$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BIN_DIR):
	mkdir -p $(BIN_DIR)


$(BUILD_DIR)/boot.o: $(SRC_DIR)/boot.s | $(BUILD_DIR)
	$(AS) $< -o $@


$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@


lmos: $(OBJ) linker.ld | $(BIN_DIR)
	$(CC) $(OBJ) -T linker.ld -o $(BIN_DIR)/$@ $(LDFLAGS)
all: lmos




clean: 
	rm -rf $(BUILD_DIR)/*


