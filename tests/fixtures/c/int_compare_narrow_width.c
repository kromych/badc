// C99 6.5.8 / 6.5.9: a relational or equality operator over two `int`
// operands is decided by their 32-bit values, so the comparison is
// emitted in the 32-bit register form and the operands need no
// sign-extension. The seeds here are truncating casts of wide
// constants, so the register holding the value before the conversion
// differs from the sign-extension of its low word: a comparison that
// read the wide register, or a widening conversion that failed to
// re-extend, gives a different answer than the checks expect.
//
// Covered: signed and unsigned narrow arithmetic, `int` -> 64-bit and
// `unsigned` -> unsigned 64-bit conversions, signed / unsigned /
// equality comparisons, mixed-width comparisons that must stay 64-bit,
// and array indexing by an `int`.
//
// The wide values are spelled `long long`: the checks below assert
// 64-bit results, and `long` is 8 bytes under LP64 but 4 under LLP64
// (Windows).

static volatile long long seed_hi = 0x7fffffff80000001LL; /* low word 0x80000001 */
static volatile long long seed_lo = 0x123456780000000cLL; /* low word 12 */
static volatile long long seed_ch = 0x00000000ffffff92LL; /* low byte 0x92 */

int table[20];

static int classify(int v, int lo, int hi)
{
    if (v < lo) {
        return -1;
    }
    if (v > hi) {
        return 1;
    }
    return 0;
}

int main(void)
{
    int a = (int)seed_hi; /* -2147483647 */
    int b = (int)seed_lo; /* 12 */
    unsigned ua = (unsigned)seed_hi; /* 2147483649 */
    unsigned ub = (unsigned)seed_lo; /* 12 */
    int i;

    /* Signed comparisons of two `int` values. */
    if (a >= 0) return 1;
    if (!(a < b)) return 2;
    if (!(b > a)) return 3;
    if (a != -2147483647) return 4;
    if (a == b) return 5;
    if (!(b <= 12) || !(b >= 12)) return 6;

    /* Unsigned comparisons: `ua` has bit 31 set, so it orders above
       `ub` unsigned and below it signed. */
    if (!(ua > ub)) return 7;
    if (!((int)ua < (int)ub)) return 8;
    if (ua <= 2147483648u) return 9;

    /* Usual arithmetic conversions make a mixed int/unsigned compare
       unsigned (6.3.1.8), so -1 orders above 1. */
    if (!(-1 > 1u)) return 10;
    if ((unsigned)b > ua) return 11;

    /* Widening conversions still extend (6.3.1.3). */
    {
        long long la = a;
        unsigned long long lua = ua;
        long long lb = b;
        if (la != -2147483647LL) return 12;
        if (lua != 2147483649ULL) return 13;
        if (la * 4LL != -8589934588LL) return 14;
        if (!(la < lb)) return 15;
        /* An operand outside the 32-bit range keeps the comparison at
           64 bits. */
        if (!(seed_hi > 0x100000000LL)) return 16;
        if (!((long long)ua > 0x7fffffffLL)) return 17;
    }

    /* Narrow arithmetic: unsigned wraps modulo 2^32 (6.2.5p9), signed
       stays in range. */
    if (ua + ua != 2u) return 18;
    if (ua * 3u != 2147483651u) return 19;
    if (a + 1 != -2147483646) return 20;
    if (b * b != 144) return 21;
    if (ua >> 4 != 134217728u) return 22;
    if (b << 4 != 192) return 23;
    if (b >> 2 != 3) return 24;
    if (a / 7 != -306783378) return 25;
    if (a % 7 != -1) return 26;
    if (ua / 7u != 306783378u) return 27;
    if (ua % 7u != 3u) return 28;

    /* Promoted narrow operands. */
    {
        signed char c = (signed char)seed_ch; /* -110 */
        unsigned char uc = (unsigned char)seed_ch; /* 146 */
        short s = (short)seed_ch; /* -110 */
        if (!(c < 0) || c != -110) return 29;
        if (!(uc > 0) || uc != 146) return 30;
        if (c != s) return 31;
        if (!(c < uc)) return 32;
    }

    /* Array indexing by an `int`: the index widens for addressing. */
    for (i = 0; i < 20; ++i) {
        table[i] = i * 3;
    }
    if (table[b] != 36) return 33;
    if (table[(int)ub] != 36) return 34;
    {
        int idx = b - 5;
        table[idx] += a;
        if (table[7] != 21 - 2147483647) return 35;
    }

    /* Comparisons behind a call boundary: the arguments are `int`, so
       the callee reads them from the low 32 bits. */
    if (classify(a, -2147483647, 12) != 0) return 36;
    if (classify(a, 0, 12) != -1) return 37;
    if (classify(b, -5, 5) != 1) return 38;
    if (classify((int)ua, 0, 100) != -1) return 39;

    /* `long` is the target's other signed width: 32 bits under LLP64,
       64 under LP64. These hold in either model. */
    {
        long na = a;
        long nb = b;
        if (!(na < nb)) return 40;
        if (na != -2147483647L) return 41;
        if (na / 7L != -306783378L) return 42;
    }

    return 0;
}
