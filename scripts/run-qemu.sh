#!/bin/zsh
set -e 
. ./make-iso.sh

qemu-system-$(./triplet-to-arch.sh $HOST) -cdrom $(LMOS).iso
