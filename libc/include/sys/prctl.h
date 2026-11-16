#pragma once

// sys/prctl.h -- operations on a process or thread (Linux).

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::prctl, "prctl")
#endif

#include <linux/prctl.h>

#ifdef __linux__
int prctl(int option, ...);
#endif
