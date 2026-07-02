// sys/auxv.h -- read entries from the ELF auxiliary vector (glibc).

#pragma once

#ifdef __linux__
#include <linux/auxvec.h>

#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::getauxval, "getauxval")

// Value of the auxiliary-vector entry `type` (an AT_* constant), or 0
// with errno ENOENT when the vector carries no such entry.
unsigned long getauxval(unsigned long type);
#endif
