#!/bin/zsh
set -e 
. ./copy-headers.sh

# call `make install` on all subdirs
for SUBDIR in $SUBDIRS; do
    (cd $SUBDIR && DEST_DIR="$SYSROOT" $MAKE install)
done
