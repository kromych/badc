/* C99 6.4.4.1p5 at the signed-max boundaries: an unsuffixed decimal
   constant takes the first of int, long, long long that represents
   it, so 2147483648 (2^31) is long, not a wrapped int; a decimal
   constant past LLONG_MAX takes unsigned long long (existing gcc /
   clang practice). Hex constants at 2^31 / 2^63 take the unsigned
   type at the same rank. Octal and binary literals carry the same
   u/U/l/L suffixes as decimal and hex. */
int main(void) {
    /* 2147483648 is long (or long long): the negation and subtraction
       run at 64 bits instead of wrapping at int width. */
    long long a = -2147483648 - 1;
    if (a != -2147483649LL) {
        return 1;
    }
    if (sizeof(2147483648) != sizeof(long long) && sizeof(2147483648) != 8) {
        return 2;
    }
    /* 0x80000000 is unsigned int: -1 converts to 0xFFFFFFFF and
       compares above it. */
    if (-1 < 0x80000000) {
        return 3;
    }
    if (sizeof(0x80000000) != 4) {
        return 4;
    }
    /* 2^63: hex and decimal both land at unsigned long long. */
    if (!(0x8000000000000000 > 0x7FFFFFFFFFFFFFFF)) {
        return 5;
    }
    if (9223372036854775808 / 2 != 4611686018427387904) {
        return 6;
    }
    /* Octal / binary suffixes are recorded, not dropped. */
    if (sizeof(01ll) != 8 || sizeof(0777LL) != 8 || sizeof(0b1ull) != 8) {
        return 7;
    }
    /* 010u is unsigned int: the mixed compare runs unsigned. */
    if (-1 < 010u) {
        return 8;
    }
    return 0;
}
