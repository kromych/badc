// Division and modulo by a constant power of two are strength-reduced
// to shifts / masks (signed via the truncate-toward-zero bias of
// C99 6.5.5p6). `volatile` operands keep the dividend a runtime value
// so the reduced sequence is exercised rather than constant-folded.
// Returns 0 when every case matches the C semantics.

int main(void) {
    // Signed int: truncation toward zero, including negatives.
    volatile int si = -7;
    if (si / 2 != -3 || si % 2 != -1) return 1;
    si = -16;
    if (si / 16 != -1 || si % 16 != 0) return 2;
    si = -17;
    if (si / 16 != -1 || si % 16 != -1) return 3;
    si = 100;
    if (si / 8 != 12 || si % 8 != 4) return 4;
    si = -2147483647 - 1; // INT_MIN
    if (si / 2 != -1073741824 || si % 2 != 0) return 5;

    // Unsigned int: logical shift / mask, high bit set.
    volatile unsigned ui = 0xFFFFFFFFu;
    if (ui / 2u != 0x7FFFFFFFu || ui % 2u != 1u) return 6;
    ui = 0x80000000u;
    if (ui / 16u != 0x08000000u || ui % 16u != 0u) return 7;

    // Signed long.
    volatile long sl = -1234567L;
    if (sl / 1024 != -1234567L / 1024 || sl % 1024 != -1234567L % 1024) return 8;
    sl = -9223372036854775807L - 1; // LONG_MIN
    if (sl / 2 != -4611686018427387904L || sl % 2 != 0) return 9;

    // Unsigned long, top bit set.
    volatile unsigned long ul = 0xFFFFFFFFFFFFFFFFUL;
    if (ul / 2UL != 0x7FFFFFFFFFFFFFFFUL || ul % 256UL != 255UL) return 10;

    // Divisor of 1: division is identity, modulo is zero.
    si = -5;
    if (si / 1 != -5 || si % 1 != 0) return 11;

    return 0;
}
