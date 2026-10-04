// A phi that no instruction reads is dead, and so, transitively, are
// the pure values only it read: a dead phi's predecessor-exit moves
// are dropped, so its incoming values keep nothing alive. The first
// two functions merge the quotient and the remainder of a 128-by-64
// division through phis on their correction paths and return one half
// only, leaving the other half's phis dead (C99 6.5.5p5: the quotient
// truncates toward zero). The last leaves a cycle of phis reading only
// one another dead. The inputs are volatile so no division folds at
// compile time, and the checks compare against reference arithmetic.

typedef unsigned long long u64;

#define NOINLINE __attribute__((noinline))

NOINLINE static u64 quot128(u64 hi, u64 lo, u64 d) {
    unsigned __int128 hl = ((unsigned __int128)hi << 64) + lo;
    return (u64)(hl / d);
}

NOINLINE static u64 rem128(u64 hi, u64 lo, u64 d) {
    unsigned __int128 hl = ((unsigned __int128)hi << 64) + lo;
    return (u64)(hl % d);
}

NOINLINE static int rotate_dead(int n) {
    int a = 1, b = 2, i;
    for (i = 0; i < n; i++) {
        int t = a;
        a = b;
        b = t;
    }
    return 0;
}

static u64 ref_quot(u64 hi, u64 lo, u64 d) {
    unsigned __int128 hl = ((unsigned __int128)hi << 64) + lo;
    return (u64)(hl / d);
}

static u64 ref_rem(u64 hi, u64 lo, u64 d) {
    unsigned __int128 hl = ((unsigned __int128)hi << 64) + lo;
    return (u64)(hl % d);
}

static volatile u64 vhi = 0x123456789abcdef0ull;
static volatile u64 vlo = 0xfedcba9876543210ull;
static volatile u64 vd = 7;
static volatile int vn = 100;

int main(void) {
    u64 hi = vhi, lo = vlo, d = vd;
    if (quot128(hi, lo, d) != ref_quot(hi, lo, d)) return 1;
    if (rem128(hi, lo, d) != ref_rem(hi, lo, d)) return 2;
    if (quot128(0, lo, 3) != ref_quot(0, lo, 3)) return 3;
    if (rem128(hi, 0, 1) != ref_rem(hi, 0, 1)) return 4;
    if (quot128(hi, lo, hi) != ref_quot(hi, lo, hi)) return 5;
    if (rem128(hi, lo, lo) != ref_rem(hi, lo, lo)) return 6;
    return rotate_dead(vn) != 0;
}
