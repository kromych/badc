// C99 7.24.4.4 wide-character array functions: wmemchr / wmemcmp /
// wmemcpy / wmemmove / wmemset, declared by <wchar.h> and bound to the
// host libc (msvcrt on Windows).

#include <wchar.h>

int main(void) {
    wchar_t src[5] = { 10, 20, 30, 40, 50 };
    wchar_t dst[5];

    if (wmemchr(src, 30, 5) != &src[2]) return 1;
    if (wmemchr(src, 99, 5) != 0) return 2;

    wmemcpy(dst, src, 5);
    if (wmemcmp(dst, src, 5) != 0) return 3;

    wmemset(dst, 7, 3);
    if (dst[0] != 7 || dst[1] != 7 || dst[2] != 7 || dst[3] != 40) return 4;

    wmemmove(dst + 1, dst, 3);
    if (dst[1] != 7 || dst[2] != 7 || dst[3] != 7) return 5;

    return 0;
}
