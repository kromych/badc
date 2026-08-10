// glibc <byteswap.h>: the `bswap_N` macros and the `__bswap_N`
// spellings they expand through.
//
// The operand width is the macro's, not the argument's -- glibc's
// `__bswap_N` take `uintN_t`, so a wider value is truncated before the
// reversal. The kernel's TO_NATIVE expands all three macros at every
// swap site and selects on `sizeof`, so a macro that reversed the
// argument's width instead would not even compile there.
//
// Returns 0 on success, otherwise the number of the failing check.

#include <byteswap.h>

// The reversal folds at translation time, so this also covers the
// constant-expression path.
static const unsigned int FOLDED = bswap_32(0x11223344u);

int main(void) {
    // Volatile operands so the checks below exercise the runtime
    // lowering; `FOLDED` covers the constant-expression path.
    volatile unsigned long long v = 0x0102030405060708ull;
    volatile unsigned int w = 0x11223344u;
    volatile unsigned short h = 0xabcd;

    if (bswap_16(h) != 0xcdab) {
        return 1;
    }
    if (bswap_32(w) != 0x44332211u) {
        return 2;
    }
    if (bswap_64(v) != 0x0807060504030201ull) {
        return 3;
    }

    // Truncation to the operand width, from one wider value.
    if (bswap_16(v) != 0x0807) {
        return 4;
    }
    if (bswap_32(v) != 0x08070605u) {
        return 5;
    }

    // Result width is the operand's, independent of the argument's.
    if (sizeof bswap_16(v) != sizeof(unsigned short)) {
        return 6;
    }
    if (sizeof bswap_32(v) != sizeof(unsigned int)) {
        return 7;
    }
    if (sizeof bswap_64(w) != sizeof(unsigned long long)) {
        return 8;
    }

    // The reversal is its own inverse at each width.
    if (bswap_16(bswap_16(h)) != h) {
        return 9;
    }
    if (bswap_32(bswap_32(w)) != w) {
        return 10;
    }
    if (bswap_64(bswap_64(v)) != v) {
        return 11;
    }

    // The underscored spellings the header also exposes.
    if (__bswap_16(h) != bswap_16(h)) {
        return 12;
    }
    if (__bswap_32(w) != bswap_32(w)) {
        return 13;
    }
    if (__bswap_64(v) != bswap_64(v)) {
        return 14;
    }

    if (FOLDED != 0x44332211u) {
        return 15;
    }

    // A byte-symmetric value is unchanged; a single low byte moves to
    // the top of the operand width.
    if (bswap_16(0x00ffu) != 0xff00) {
        return 16;
    }
    if (bswap_64(0xffull) != 0xff00000000000000ull) {
        return 17;
    }
    return 0;
}
