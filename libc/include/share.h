// share.h -- the sharing modes of _sopen, _sopen_s and _fsopen, with the
// values and the unprefixed names mingw-w64's share.h gives them.

#pragma once

#ifdef _WIN32

#define _SH_COMPAT 0x00
#define _SH_DENYRW 0x10
#define _SH_DENYWR 0x20
#define _SH_DENYRD 0x30
#define _SH_DENYNO 0x40
#define _SH_SECURE 0x80

#ifndef NO_OLDNAMES
#define SH_COMPAT _SH_COMPAT
#define SH_DENYRW _SH_DENYRW
#define SH_DENYWR _SH_DENYWR
#define SH_DENYRD _SH_DENYRD
#define SH_DENYNO _SH_DENYNO
#endif

#endif
