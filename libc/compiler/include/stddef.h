// stddef.h -- the standard "common definitions" header.
// `size_t` and `ptrdiff_t` are pointer-wide on every 64-bit
// host: 8 bytes on LP64 (Linux/macOS) where `long` already
// matches a pointer, and 8 bytes on LLP64 (Windows) where
// `long` is only 32 bits and we have to fall back to
// `long long` to keep the right width. `wchar_t` follows the
// width the driver selected, reported as `__SIZEOF_WCHAR_T__`.
//
// C99 7.17p2: `size_t` is the unsigned integer type of the
// result of `sizeof`. A signed underlying type makes
// `~(size_t)0` evaluate to -1 instead of the max value and
// silently corrupts the `((size_t)-1) / N`-style allocation
// caps that user code derives from `SIZE_MAX`.
//
// NULL is the canonical zero pointer literal. The offsetof
// shape `&((T*)0)->m` is recognized by the constant-expression
// evaluator (see parse_const_offsetof in the compiler); the
// macro form below is the customary expansion.
#pragma once

#ifdef __BADC_WINDOWS__
typedef unsigned long long size_t;
typedef long long ptrdiff_t;
#else
typedef unsigned long size_t;
typedef long ptrdiff_t;
#endif

// Width and signedness both come from the target ABI: 2 bytes and
// unsigned on Windows, whose wide-string APIs take UTF-16 code units,
// and under `-fshort-wchar`; 4 bytes elsewhere, unsigned under AAPCS64
// and signed under the Linux/x86-64 and Apple arm64 ABIs. Taking the
// predefine verbatim keeps the typedef, `__SIZEOF_WCHAR_T__` and the
// type of `L"..."` in agreement by construction.
typedef __WCHAR_TYPE__ wchar_t;

// C11 6.2.8: a type whose alignment is the greatest fundamental
// alignment, as the platform's headers define it: `long double` on Apple
// targets, a structure of `long long` and `long double` elsewhere.
#ifndef __max_align_t_defined
#ifdef __APPLE__
typedef long double max_align_t;
#else
typedef struct {
    long long __max_align_ll;
    long double __max_align_ld;
} max_align_t;
#endif
#define __max_align_t_defined 1
#endif

#ifndef NULL
#define NULL ((void*)0)
#endif

#ifndef offsetof
#define offsetof(t, m) ((size_t)((char*)&((t*)0)->m - (char*)0))
#endif
