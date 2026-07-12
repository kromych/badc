// libgen.h -- POSIX path-component splitters.
//
// `dirname` and `basename` are non-thread-safe and may mutate
// the input buffer in place (POSIX explicitly permits writing a
// NUL byte into the argument). Callers that need to keep the
// original path intact pass a `strdup`'d copy.

#pragma once

#include <stddef.h>

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::dirname,  "_dirname")
#pragma binding(libc::basename, "_basename")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::dirname,  "dirname")
#pragma binding(libc::basename, "basename")
#endif

#ifdef _WIN32
// msvcrt has no POSIX `dirname` / `basename`; programs that
// need the equivalent on Windows route through `_splitpath`.
#endif

char *dirname(char *path);
char *basename(char *path);
