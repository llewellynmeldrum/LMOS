# Sets up the environment for further build scripts.

SYSTEM_SUBDIRS="libc kernel"
SUBDIRS="libc kernel"

# syntax notes because I suck at shell scripts:
# ${<var> :- <default>}  # -> if var is not set, var=<default>
export MAKE=${MAKE:-make} # if MAKE is not set, MAKE="make"
export HOST=${HOST:-$(./get-default-host.sh)}
export LMOS="lmos"

# setup build tools for this host
export AR=${HOST}-ar
export AS=${HOST}-as
export CC=${HOST}-gcc

# setup directories
export PREFIX=/usr
export EXEC_PREFIX=$PREFIX
export BOOT_DIR=/boot
export LIB_DIR=$EXEC_PREFIX/lib
export INC_DIR=$PREFIX/include

# enable default C flags
export CFLAGS='-O2 -g'
export CPPFLAGS=''

# Configure the css-compiler to use the desired system root.
export SYSROOT="$(pwd)/sysroot"
export CC="$CC --sysroot=$SYSROOT"

# Work around that the -elf gcc targets doesn't have a system include directory
# because it was configured with --without-headers rather than --with-sysroot.
if echo "$HOST" | grep -Eq -- '-elf($|-)'; then
  export CC="$CC -isystem=$INCLUDEDIR"
fi
