// stddef.h -- the standard "common definitions" header.
// `size_t` and `ptrdiff_t` are pointer-wide on every 64-bit
// host (LP64 macOS / Linux: 8 bytes; LLP64 Windows: 8 bytes
// pointer but 4-byte `long`; we still alias `long` and accept
// the small Windows skew per #51). `wchar_t` stays at `int`
// width since UTF-16 / UTF-32 codepoints fit in 4 bytes and
// no host expects a wider value here.
//
// NULL is the canonical zero pointer literal. The offsetof
// shape `&((T*)0)->m` is recognised by the constant-expression
// evaluator (see parse_const_offsetof in the compiler); the
// macro form below is the customary expansion.
#ifndef _C5_STDDEF_H
#define _C5_STDDEF_H

typedef long size_t;
typedef long ptrdiff_t;
typedef int wchar_t;

#ifndef NULL
#define NULL ((void*)0)
#endif

#ifndef offsetof
#define offsetof(t, m) ((size_t)((char*)&((t*)0)->m - (char*)0))
#endif

#endif
