// sys/utsname.h -- system name structure (POSIX 7.51). The per-field buffer
// length differs by target (macOS 256, Linux 65 with a trailing domain field),
// so the layout is spelled out per target to keep field offsets correct.

#pragma once

#ifdef __APPLE__
struct utsname {
    char sysname[256];
    char nodename[256];
    char release[256];
    char version[256];
    char machine[256];
};
#elif defined(__linux__)
struct utsname {
    char sysname[65];
    char nodename[65];
    char release[65];
    char version[65];
    char machine[65];
    char __domainname[65];
};
#endif

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::uname, "_uname")
#elif defined(__linux__)
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::uname, "uname")
#endif

int uname(struct utsname *buf);
