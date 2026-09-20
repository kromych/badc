// Divisions whose operands and neighbors compete for the registers the
// x86-64 divide uses implicitly: quotient and remainder of every sign
// combination at both widths, signed and unsigned, with the dividend, the
// divisor or both read again afterwards; many values live across one
// divide, in a loop and across two divides in a row; a division by a
// constant; and a 128-bit division. The exit code names the first check
// that fails.

#define NOINLINE __attribute__((noinline))

NOINLINE static long quot(long a, long b) { return a / b; }
NOINLINE static long rem(long a, long b) { return a % b; }
NOINLINE static unsigned long uquot(unsigned long a, unsigned long b) { return a / b; }
NOINLINE static unsigned long urem(unsigned long a, unsigned long b) { return a % b; }
NOINLINE static int quot32(int a, int b) { return a / b; }
NOINLINE static int rem32(int a, int b) { return a % b; }
NOINLINE static unsigned uquot32(unsigned a, unsigned b) { return a / b; }
NOINLINE static unsigned urem32(unsigned a, unsigned b) { return a % b; }

// The dividend and the divisor are read after the division.
NOINLINE static long reread(long a, long b) { return a / b * 1000 + a % b * 10 + a - b; }

// Six values live across the divide, more than the caller-saved registers
// outside rdx:rax.
NOINLINE static long six(long a, long b, long c, long d, long e, long f) {
    long q = a / b;
    return q + a * 2 + b * 3 + c * 5 + d * 7 + e * 11 + f * 13;
}

// Values carried around a loop across a divide.
NOINLINE static long digits(unsigned long n, long base, long weight) {
    long sum = 0, count = 0;
    while (n) {
        sum += (long)(n % (unsigned long)base) * weight;
        n /= (unsigned long)base;
        count++;
        weight++;
    }
    return sum * 100 + count;
}

// Two divides in a row, the first quotient live across the second.
NOINLINE static long chain(long a, long b, long c) {
    long q = a / b;
    long r = (a + q) % c;
    return q * 1000 + r;
}

NOINLINE static long by_const(long a) { return a / 7 + a % 10; }

NOINLINE static unsigned __int128 wide_quot(unsigned __int128 a, unsigned __int128 b) {
    return a / b;
}

static volatile long vl[] = {17, 5, -17, -5, 0, 7, 1000003, 97};
static volatile unsigned long vu[] = {0xfffffffffffffffful, 3, 0x8000000000000000ul, 10};

int main(void) {
    long p = vl[0], q = vl[1], m = vl[2], n = vl[3];
    if (quot(p, q) != 3 || rem(p, q) != 2) return 1;
    if (quot(m, q) != -3 || rem(m, q) != -2) return 2;
    if (quot(p, n) != -3 || rem(p, n) != 2) return 3;
    if (quot(m, n) != 3 || rem(m, n) != -2) return 4;
    if (quot(vl[4], vl[5]) != 0 || rem(vl[5], vl[5]) != 0) return 5;
    if (quot32((int)p, (int)n) != -3 || rem32((int)m, (int)q) != -2) return 6;
    if (uquot(vu[0], vu[1]) != 0x5555555555555555ul || urem(vu[0], vu[3]) != 5) return 7;
    if (uquot(vu[2], vu[3]) != 0x0cccccccccccccccul || urem(vu[2], vu[1]) != 2) return 8;
    if (uquot32(0xffffffffu, (unsigned)vu[1]) != 0x55555555u || urem32(0xffffffffu, 10u) != 5) return 9;
    if (reread(p, q) != 3000 + 20 + 12) return 10;
    if (reread(m, q) != -3000 - 20 - 22) return 11;
    if (six(vl[6], vl[7], 1, 2, 3, 4) != 2010710) return 12;
    if (digits(vu[0], 10, 1) != 93820) return 13;
    if (chain(p, q, 4) != 3000 + 0) return 14;
    if (chain(m, q, 7) != -3000 - 6) return 15;
    if (by_const(vl[6]) != 142857 + 3 || by_const(m) != -2 - 7) return 16;
    unsigned __int128 big = ((unsigned __int128)vu[0] << 64) | vu[0];
    unsigned __int128 third = ((unsigned __int128)0x5555555555555555ul << 64) | 0x5555555555555555ul;
    if (wide_quot(big, vu[1]) != third || wide_quot(big, big) != 1) return 17;
    return 0;
}
