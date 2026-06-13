// A function returning a `char` or `short` converts its result to that
// type (C99 6.8.6.4 / 6.3.1.1): a body value wider than the declared
// return type is narrowed -- masked for an unsigned type, sign-extended
// for a signed one -- before the result reaches the caller. The classic
// case is a `uint16_t` byte-swap whose `(x << 8) | (x >> 8)` exceeds 16
// bits. Asserted by return code.

static unsigned short bswap16(unsigned short x) {
    return (x >> 8) | (x << 8);
}
static unsigned char u8_wrap(unsigned char x) {
    return x + 200;
}
static short s16_shift(short x) {
    return x << 8;
}
static signed char s8_wrap(signed char x) {
    return x + 100;
}

int main(void) {
    if (bswap16(0x3412) != 0x1234) return 1;
    if (u8_wrap(100) != 44) return 2;             // 300 & 0xff
    if (s16_shift(0x0140) != 16384) return 3;     // 0x14000 truncated to 16 bits
    if (s8_wrap(100) != -56) return 4;            // 200 as signed char
    return 0;
}
