// `wint_t` (C17 7.29.1) is the platform C library's type: glibc's
// `unsigned int`, Apple's `int`, the Windows C runtime's `unsigned short`.
// WINT_MIN and WINT_MAX (C17 7.20.3) are its limits.
#include <stdint.h>
#include <wchar.h>

#if defined(_WIN32)
_Static_assert(_Generic((wint_t)0, unsigned short: 1, default: 0), "wint_t");
_Static_assert(WINT_MIN == 0 && WINT_MAX == 0xffff, "wint_t limits");
#elif defined(__APPLE__)
_Static_assert(_Generic((wint_t)0, int: 1, default: 0), "wint_t");
_Static_assert(WINT_MIN == INT32_MIN && WINT_MAX == INT32_MAX, "wint_t limits");
#else
_Static_assert(_Generic((wint_t)0, unsigned int: 1, default: 0), "wint_t");
_Static_assert(WINT_MIN == 0 && WINT_MAX == UINT32_MAX, "wint_t limits");
#endif

int main(void) {
    wint_t eof = WEOF;
    return eof == WEOF && eof != L'a' ? 0 : 1;
}
