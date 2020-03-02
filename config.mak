# ./configure --enable-wrapper=clang
# Any changes made here will be lost if configure is re-run
AR = llvm-ar
RANLIB = llvm-ranlib
ARCH = x86_64
SUBARCH = 
ASMSUBARCH = 
srcdir = .
prefix = /usr/local/musl
exec_prefix = $(prefix)
bindir = $(exec_prefix)/bin
libdir = $(prefix)/lib
includedir = $(prefix)/include
syslibdir = /usr/local/lib
CC = clang
CFLAGS = -Oz
CFLAGS_AUTO = -pipe -fomit-frame-pointer -fno-unwind-tables -fno-asynchronous-unwind-tables -ffunction-sections -fdata-sections -Werror=implicit-function-declaration -Werror=implicit-int -Werror=pointer-sign -Werror=pointer-arith -Qunused-arguments
CFLAGS_C99FSE = -std=c99 -nostdinc -ffreestanding -Wa,--noexecstack
CFLAGS_MEMOPS = 
CFLAGS_NOSSP = -fno-stack-protector
CPPFLAGS = 
LDFLAGS = -Wl,--plugin-opt=O3 -Wl,-O2 -Wl,--as-needed
LDFLAGS_AUTO = -Wl,--sort-section,alignment -Wl,--sort-common -Wl,--gc-sections -Wl,--hash-style=both -Wl,--no-undefined -Wl,--exclude-libs=ALL -Wl,--dynamic-list=./dynamic.list
CROSS_COMPILE = 
LIBCC = -lgcc -lgcc_eh
OPTIMIZE_GLOBS = 
ALL_TOOLS =  obj/musl-clang obj/ld.musl-clang
TOOL_LIBS = 
ADD_CFI = no
WRAPCC_CLANG = $(CC)
