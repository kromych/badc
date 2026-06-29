// atoll (C99 7.20.1.2) parses a 64-bit value the 32-bit atoi/atol pair
// cannot represent; wcsrtombs (C99 7.24.6.4.1) converts a wide string to
// a multibyte buffer. Both are bound to the platform C library.
#include <stdlib.h>
#include <wchar.h>
#include <string.h>

int main(void) {
    if (atoll("-9000000000") != -9000000000LL) return 1;

    const wchar_t *w = L"hi";
    const wchar_t *p = w;
    char buf[8];
    unsigned long n = wcsrtombs(buf, &p, sizeof buf, 0);
    if (n != 2 || strcmp(buf, "hi") != 0) return 2;

    return 0;
}
