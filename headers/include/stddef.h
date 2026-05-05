// stddef.h -- the standard "common definitions" header.
// c5 collapses every integer to a 64-bit signed word, so size_t /
// ptrdiff_t / wchar_t all alias `int`. NULL is the canonical zero
// pointer literal. The offsetof shape `&((T*)0)->m` is recognised
// by the constant-expression evaluator (see parse_const_offsetof
// in compiler.rs); the macro form below is the customary expansion.
#ifndef _C5_STDDEF_H
#define _C5_STDDEF_H

typedef int size_t;
typedef int ptrdiff_t;
typedef int wchar_t;

#ifndef NULL
#define NULL ((void*)0)
#endif

#ifndef offsetof
#define offsetof(t, m) ((size_t)((char*)&((t*)0)->m - (char*)0))
#endif

#endif
