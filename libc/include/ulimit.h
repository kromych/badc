// ulimit.h -- the file-size limit, bound to the C library: glibc's ulimit
// in libc.so.6 and libSystem's. glibc enumerates the commands and adds two
// reserved ones.

#pragma once

#ifdef __linux__
enum {
    UL_GETFSIZE = 1,
#define UL_GETFSIZE UL_GETFSIZE
    UL_SETFSIZE,
#define UL_SETFSIZE UL_SETFSIZE
    __UL_GETMAXBRK,
    __UL_GETOPENMAX
};

#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::ulimit, "ulimit")
#elif defined(__APPLE__)
#define UL_GETFSIZE 1
#define UL_SETFSIZE 2

#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::ulimit, "_ulimit")
#endif

long ulimit(int cmd, ...);
