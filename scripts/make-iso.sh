#!/bin/zsh

set -e
. ./build-subprojects.sh

# setup isodir for grub
mkdir -p isodir
mkdir -p isodir/boot
mkdir -p isodir/boot/grub

cp sysroot/boot/$(LMOS).kernel isodir/boot/$(LMOS).kernel

cat > isodir/boot/grub/grub.cfg << EOF
menuentry "$(LMOS)" {
    multiboot /boot/$(LMOS).kernel
}
EOF

grub-mkrescue -o $(LMOS).iso isodir
