/* Apple <crt_externs.h>: accessors for the process argument and
** environment vectors, which a Mach-O image reaches through
** libSystem rather than as data symbols. */
#pragma once

#ifdef __APPLE__

#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::_NSGetEnviron,  "__NSGetEnviron")
#pragma binding(libc::_NSGetArgc,     "__NSGetArgc")
#pragma binding(libc::_NSGetArgv,     "__NSGetArgv")
#pragma binding(libc::_NSGetProgname, "__NSGetProgname")

char ***_NSGetEnviron(void);
int *_NSGetArgc(void);
char ***_NSGetArgv(void);
char **_NSGetProgname(void);

#endif
