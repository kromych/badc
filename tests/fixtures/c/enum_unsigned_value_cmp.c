/* C99 6.7.2.2 with the common extension for enumerator values outside
   int's range: a value range fitting unsigned int types the constants
   and the enum unsigned int; a wider range uses (unsigned) long long,
   for every constant of that enum. A comparison against an int then
   follows the C99 6.3.1.8 conversions: `x != BIAS` with
   BIAS = -1U<<31 converts both sides to unsigned int, so
   x == INT_MIN (bit pattern 0x80000000) compares equal. Typing BIAS
   `int` instead makes the 64-bit compare see a sign-extended lhs
   against a zero-extended rhs and `!=` is then always true. */

enum { BIAS = -1U << 31 };
enum Wide { W = 0x123456789LL };
enum Mixed { M_NEG = -1, M_TOP = 0x80000000u };
enum Sw { S_LO = 3, S_TOP = 0x80000000u };

static int ne_bias(int x) { return x != BIAS; }

static int pick(enum Sw v) {
    switch (v) {
    case S_LO:
        return 1;
    case S_TOP:
        return 2;
    default:
        return 0;
    }
}

int main(void) {
    volatile int int_min = -2147483647 - 1;
    volatile int minus1 = -1;

    /* Equality at the unsigned int common type. */
    if (ne_bias(int_min)) return 1;
    if (!(int_min == BIAS)) return 2;
    if (ne_bias(0) != 1) return 3;

    /* Ordering: both operand orders, negative and non-negative lhs.
       -1 converts to 0xFFFFFFFF, above BIAS; 0 stays below. */
    if (minus1 < BIAS) return 4;
    if (!(BIAS < minus1)) return 5;
    if (!(0 < BIAS)) return 6;
    if (BIAS < 0) return 7;
    if (!(int_min >= BIAS)) return 8;
    if (!(int_min <= BIAS)) return 9;

    /* The constant is unsigned int: 4 bytes, logical shift,
       unsigned divide. */
    if (sizeof BIAS != 4) return 10;
    if (BIAS >> 1 != 0x40000000) return 11;
    if (BIAS / 3 != 715827882u) return 12;

    /* Arithmetic mixes at unsigned int and wraps modulo 2^32. */
    if (int_min + BIAS != 0u) return 13;
    if ((long long)(1 + BIAS) != 2147483649LL) return 14;

    /* A 64-bit value range types the constant long long. */
    if (sizeof W != 8) return 15;
    if (W != 0x123456789LL) return 16;

    /* One out-of-int-range value retypes every constant of the
       enum, so M_NEG is the signed 64-bit -1, not unsigned. */
    if (sizeof M_NEG != 8) return 17;
    if (!(M_NEG < 0)) return 18;
    if (sizeof(enum Mixed) != 8) return 19;
    if (sizeof(enum Sw) != 4) return 20;

    /* Switch over an unsigned-enum-typed discriminant. */
    if (pick(S_TOP) != 2) return 21;
    if (pick(S_LO) != 1) return 22;
    if (pick((enum Sw)7) != 0) return 23;

    /* Case labels stay exact at the unsigned discriminant. */
    switch ((unsigned)int_min) {
    case BIAS:
        break;
    default:
        return 24;
    }

    return 0;
}
