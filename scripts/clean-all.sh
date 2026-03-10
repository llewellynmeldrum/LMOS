#!/bin/zsh
set -e
. ./setup-environment.sh

for SUBDIR in $SUBDIRS; do
    (cd $SUBDIR && $MAKE clean)
done

rm -rf sysroot
rm -rf isodir 
rm -rf $(LMOS).iso
