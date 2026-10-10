// x86-64 inline asm whose register operands bind to their values'
// registers while more of them lack a register than the two scratch
// registers a site reserves ahead of the allocation: constant and static
// address `r` inputs while the six System V argument registers hold
// parameters read after the statement, and inputs reaching the statement
// from spill slots while the caller-saved registers hold values live
// across it. Each template reads its inputs before it writes an output.
// Returns 42. Native x86-64 only.

#define NOINLINE __attribute__((noinline))

typedef long long i64;

static i64 cells[4];

/* Two constants and a static address: three scratch registers. */
NOINLINE static i64 store_constants(i64 a, i64 b, i64 c, i64 d, i64 e, i64 g) {
    __asm__ volatile("movq %0, (%1,%2,8)" : : "r"(5LL), "r"(cells), "r"(1LL) : "memory");
    return cells[1] + a * 2 + b * 3 + c * 5 + d * 7 + e * 11 + g * 13;
}

/* A read-write output and three constant inputs. */
NOINLINE static i64 add_constants(i64 a, i64 b, i64 c, i64 d, i64 e, i64 g) {
    i64 r = 100;
    __asm__("add %1, %0\n\tadd %2, %0\n\tadd %3, %0" : "+r"(r) : "r"(1LL), "r"(2LL), "r"(3LL));
    return r + a * 2 + b * 3 + c * 5 + d * 7 + e * 11 + g * 13;
}

/* Fifteen values live across the statement; its three inputs reach it
   from spill slots. */
NOINLINE static i64 add_spilled(const i64 *p, i64 k) {
    i64 a0 = p[0] * k, a1 = p[1] * k, a2 = p[2] * k, a3 = p[3] * k;
    i64 a4 = p[4] * k, a5 = p[5] * k, a6 = p[6] * k, a7 = p[7] * k;
    i64 a8 = p[8] * k, a9 = p[9] * k, a10 = p[10] * k, a11 = p[11] * k;
    i64 a12 = p[12] * k, a13 = p[13] * k, a14 = p[14] * k;
    i64 x = p[15], y = p[16], z = p[17];
    for (int i = 0; i < 3; i++) {
        a3 += a4 ^ i; a4 += a5 ^ i; a5 += a6 ^ i; a6 += a7 ^ i; a7 += a8 ^ i;
        a8 += a9 ^ i; a9 += a10 ^ i; a10 += a11 ^ i; a11 += a12 ^ i; a12 += a13 ^ i;
        a13 += a14 ^ i; a14 += a3 ^ i; a0 += a1 ^ i; a1 += a2 ^ i; a2 += a0 ^ i;
    }
    i64 r = 0;
    __asm__("add %1, %0\n\tadd %2, %0\n\tadd %3, %0" : "+r"(r) : "r"(x), "r"(y), "r"(z));
    return r + a0 + a1 * 3 + a2 * 5 + a3 * 7 + a4 * 11 + a5 * 13 + a6 * 17 + a7 * 19 +
           a8 * 23 + a9 * 29 + a10 * 31 + a11 * 37 + a12 * 41 + a13 * 43 + a14 * 47;
}

/* Read through a volatile, so no callee sees a constant argument. */
static volatile i64 in[6] = {1, 2, 3, 4, 5, 6};

int main(void) {
    i64 p[18];
    for (int i = 0; i < 18; i++)
        p[i] = i * 3 + 1;
    if (store_constants(in[0], in[1], in[2], in[3], in[4], in[5]) != 189 || cells[1] != 5)
        return 1;
    if (add_constants(in[0], in[1], in[2], in[3], in[4], in[5]) != 290)
        return 2;
    if (add_spilled(p, in[2]) != 240948)
        return 3;
    return 42;
}
