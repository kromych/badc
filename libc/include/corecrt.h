// corecrt.h -- the C runtime's shared types, as mingw-w64's corecrt.h
// declares them: errno_t, rsize_t, the 32- and 64-bit time types the
// _*32 / _*64 functions take, and the _locale_t handle the *_l functions
// take.

#pragma once

#ifdef _WIN32

#include <stddef.h>

#ifndef _ERRCODE_DEFINED
#define _ERRCODE_DEFINED
typedef int errno_t;
#endif

#ifndef _RSIZE_T_DEFINED
#define _RSIZE_T_DEFINED
typedef size_t rsize_t;
#endif

typedef long __time32_t;
typedef long long __time64_t;

// The count that asks a bounds-checked copy to truncate to the buffer.
#ifndef _TRUNCATE
#define _TRUNCATE ((size_t)-1)
#endif

struct threadlocaleinfostruct;
struct threadmbcinfostruct;
typedef struct threadlocaleinfostruct *pthreadlocinfo;
typedef struct threadmbcinfostruct *pthreadmbcinfo;
struct __lc_time_data;

typedef struct localeinfo_struct {
    pthreadlocinfo locinfo;
    pthreadmbcinfo mbcinfo;
} _locale_tstruct, *_locale_t;

#endif
