// stddef.h -- the standard "common definitions" header.
// `size_t` and `ptrdiff_t` are pointer-wide on every 64-bit
// host: 8 bytes on LP64 (Linux/macOS) where `long` already
// matches a pointer, and 8 bytes on LLP64 (Windows) where
// `long` is only 32 bits and we have to fall back to
// `long long` to keep the right width. `wchar_t` stays at
// `int` width since UTF-16 / UTF-32 codepoints fit in 4 bytes
// and no host expects a wider value here.
//
// C99 7.17p2: `size_t` is the unsigned integer type of the
// result of `sizeof`. A signed underlying type makes
// `~(size_t)0` evaluate to -1 instead of the max value and
// silently corrupts the `((size_t)-1) / N`-style allocation
// caps that user code derives from `SIZE_MAX`.
//
// NULL is the canonical zero pointer literal. The offsetof
// shape `&((T*)0)->m` is recognised by the constant-expression
// evaluator (see parse_const_offsetof in the compiler); the
// macro form below is the customary expansion.
#ifndef _C5_STDDEF_H
#define _C5_STDDEF_H

#ifdef __BADC_WINDOWS__
typedef unsigned long long size_t;
typedef long long ptrdiff_t;
#else
typedef unsigned long size_t;
typedef long ptrdiff_t;
#endif
typedef int wchar_t;

#ifndef NULL
#define NULL ((void*)0)
#endif

#ifndef offsetof
#define offsetof(t, m) ((size_t)((char*)&((t*)0)->m - (char*)0))
#endif

#endif
