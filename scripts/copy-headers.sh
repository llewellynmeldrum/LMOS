#!/bin/zsh

set -e # exit on error for scripts being called
. ./setup-environment.sh


mkdir -p "$SYSROOT" # ensure sysroot dir exists

# for each system subdir, `make install-headers`
for SUBDIR in $SYSTEM_SUBDIRS; do 
    (cd $SUBDIR && DEST_DIR="$SYSROOT" $MAKE install-headers)
done

