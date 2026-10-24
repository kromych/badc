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
// glibc's <libgen.h> maps basename to the POSIX function; its plain
// `basename` export is the GNU one <string.h> declares under _GNU_SOURCE,
// which returns "" after a trailing separator.
#pragma binding(libc::basename, "__xpg_basename")
#endif

#ifdef _WIN32
// msvcrt has no POSIX `dirname` / `basename`; programs that
// need the equivalent on Windows route through `_splitpath`.
#endif

char *dirname(char *path);
char *basename(char *path);
