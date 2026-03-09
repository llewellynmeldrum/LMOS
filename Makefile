.PHONY: assemble-boot
AS	 	:=i686-elf-as
LD 		:=i686-elf-ld
CC 		:=i686-elf-gcc


boot.o: boot.s
	$(AS) $*.s -o $@


