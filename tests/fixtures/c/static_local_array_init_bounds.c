// C99 6.7.8p2/p14/p21: a static-local array initializer stays inside the
// storage reserved for the declared bound. The reservation is sized from
// the bound, so a list longer than it is rejected rather than written past
// the object (the diagnostics are locked in `tests::parser`); the legal
// shapes below fill the object and leave the neighbouring statics intact.
//
// The wide rows also cover C99 6.7.8p15: the element width must match the
// literal's, and a bounded array that outruns the literal zero-fills.

#include <stddef.h>

int main(void) {
    static int guard_lo[2] = {0x11, 0x22};
    static int brace[4] = {1, 2, 3};          /* short list zero-pads */
    static char narrow_exact[3] = "abc";      /* exact fit drops the NUL */
    static char narrow_pad[5] = "ab";         /* NUL plus zero tail */
    static wchar_t wide_exact[3] = L"xyz";    /* exact fit drops the NUL */
    static wchar_t wide_pad[5] = L"xy";       /* NUL plus zero tail */
    static int guard_hi[2] = {0x33, 0x44};

    if (guard_lo[0] != 0x11 || guard_lo[1] != 0x22) return 1;
    if (guard_hi[0] != 0x33 || guard_hi[1] != 0x44) return 2;

    if (brace[0] != 1 || brace[1] != 2 || brace[2] != 3 || brace[3] != 0) return 3;

    if (narrow_exact[0] != 'a' || narrow_exact[1] != 'b' || narrow_exact[2] != 'c') return 4;
    if (narrow_pad[0] != 'a' || narrow_pad[1] != 'b') return 5;
    if (narrow_pad[2] != 0 || narrow_pad[3] != 0 || narrow_pad[4] != 0) return 6;

    if (wide_exact[0] != L'x' || wide_exact[1] != L'y' || wide_exact[2] != L'z') return 7;
    if (wide_pad[0] != L'x' || wide_pad[1] != L'y') return 8;
    if (wide_pad[2] != 0 || wide_pad[3] != 0 || wide_pad[4] != 0) return 9;

    return 0;
}
