// <uchar.h> (C17 7.28): the `char16_t` / `char32_t` types and the
// restartable conversions between them and the multibyte encoding of the
// current locale. glibc defines the four functions; on macOS and Windows,
// whose C libraries do not, libc/lib/uchar_ext.c defines them over
// `mbrtowc` and `wcrtomb`.

#pragma once

#include <stddef.h>
#include <wchar.h>

typedef __CHAR16_TYPE__ char16_t;
typedef __CHAR32_TYPE__ char32_t;

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::mbrtoc16, "mbrtoc16")
#pragma binding(libc::c16rtomb, "c16rtomb")
#pragma binding(libc::mbrtoc32, "mbrtoc32")
#pragma binding(libc::c32rtomb, "c32rtomb")
#endif

size_t mbrtoc16(char16_t *restrict pc16, const char *restrict s, size_t n,
                mbstate_t *restrict ps);
size_t c16rtomb(char *restrict s, char16_t c16, mbstate_t *restrict ps);
size_t mbrtoc32(char32_t *restrict pc32, const char *restrict s, size_t n,
                mbstate_t *restrict ps);
size_t c32rtomb(char *restrict s, char32_t c32, mbstate_t *restrict ps);
