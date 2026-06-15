// langinfo.h -- language information constants (POSIX 7.21). Only the CODESET
// query (the locale's character encoding) is provided; its item number differs
// per target.

#pragma once

typedef int nl_item;

#ifdef __APPLE__
#define CODESET 0
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::nl_langinfo, "_nl_langinfo")
#elif defined(__linux__)
#define CODESET 14
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::nl_langinfo, "nl_langinfo")
#endif

char *nl_langinfo(nl_item item);
