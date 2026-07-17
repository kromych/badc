// sys/locking.h -- mode argument of the CRT's `_locking` (declared in
// <io.h>/<stdio.h>). Values pinned by the CRT header of the same name.

#pragma once

#ifdef _WIN32
#define _LK_UNLCK 0
#define _LK_LOCK 1
#define _LK_NBLCK 2
#define _LK_RLCK 3
#define _LK_NBRLCK 4
#endif
