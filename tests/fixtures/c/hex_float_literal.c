// C99 6.4.4.2 hexadecimal floating constants.
//
// The mantissa is hexadecimal with an optional fractional part;
// the binary-exponent part `p`/`P` is mandatory and scales the
// mantissa by a power of two. A trailing `f`/`F`/`l`/`L` selects
// the type only. Each constant below is exactly representable in
// IEEE-754 double, so the equality compares are exact.

int main(void) {
    if (0x1p4 != 16.0) return 1;        // 1 * 2^4
    if (0x1p10 != 1024.0) return 2;     // 1 * 2^10
    if (0x1.8p1 != 3.0) return 3;       // 1.5 * 2^1
    if (0x1.8p+1 != 3.0) return 4;      // explicit '+' exponent sign
    if (0x10p-4 != 1.0) return 5;       // 16 * 2^-4
    if (0x0.1p4 != 1.0) return 6;       // (1/16) * 2^4
    if (0xAp0 != 10.0) return 7;        // integer-only mantissa
    if (0x1.0P0f != 1.0) return 8;      // uppercase 'P' and 'f' suffix
    if (0x1.92p+1 != 3.140625) return 9;
    if (-0x1p-1 != -0.5) return 10;     // unary minus on a hex float

    double d = 0x1.4p3;                 // 1.25 * 8
    if (d != 10.0) return 11;
    return 0;
}
