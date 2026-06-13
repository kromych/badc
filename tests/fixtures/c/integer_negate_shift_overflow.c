// C99 6.5.7 / 6.5.3.3p3 / 6.2.5p9: an `int`-typed operation that overflows the
// 32-bit width must renormalize its result to that width before a wider read.
// c5 keeps every value sign-/zero-extended to 64 bits per its declared type, so
// a `<<` whose result lands in bit 31, or a unary `-` of the type minimum, must
// sign-extend the 32-bit result; otherwise a later 64-bit read (arithmetic
// `>>`, widening to `long`, a 64-bit compare) sees the wrong value. Asserted by
// return code.

int main(void) {
    // `1 << 31` is INT_MIN; read back through a `long` it must stay negative.
    int a = 1 << 31;
    if ((long)a != -2147483648L) return 1;

    // Arithmetic right shift of a bit-31 result must propagate the sign.
    if ((1 << 31) >> 31 != -1) return 2;

    // Negating INT_MIN wraps to INT_MIN (modulo 2^32 in the accumulator); the
    // high half must not stay clear.
    int mn = -2147483648;
    int neg = -mn;
    if ((long)neg != -2147483648L) return 3;

    // Negating a positive value that lands in bit 31 after the unary minus.
    int p = 2147483647;          // INT_MAX
    if ((long)(-p) != -2147483647L) return 4;

    // A short LHS promotes to signed int (6.5.7); shifting its top bit into
    // bit 31 and reading back arithmetically must sign-extend.
    unsigned short s = 0x8000;
    if ((int)(s << 16) >> 16 != -32768) return 5;

    // unsigned int wraps modulo 2^32, never sign-extends.
    unsigned u = 0;
    if ((unsigned)-u != 0u) return 6;
    unsigned one = 1;
    if ((-one) != 4294967295u) return 7;

    return 0;
}
