/* A named argument of 32 bits or less reaches its callee in the low word
   of its register, the upper half unspecified (System V AMD64 3.2.3,
   AAPCS64 6.8.2), so a caller passes the value its 64-bit arithmetic left
   without the mask or extension the argument's type implies, and the
   callee converts it where it reads more. Each check hands on the low word
   of a value whose upper half is set; the `static` callee's parameter range
   comes from its one call site. A narrower argument keeps its extension to
   32 bits. The exit code names the first failing check. */

typedef unsigned long long u64;
typedef long long s64;

__attribute__((noinline)) static u64 scale(unsigned x) { return (u64)x * 3; }
__attribute__((noinline)) s64 widen(int x) { return x; }
__attribute__((noinline)) u64 halve(unsigned x) { return (u64)x >> 1; }
__attribute__((noinline)) s64 sum(int a, int b) { return (s64)a + (s64)b; }
__attribute__((noinline)) s64 pick(const s64 *a, int i) { return a[i]; }
__attribute__((noinline)) s64 pick_u(const s64 *a, unsigned i) { return a[i]; }
__attribute__((noinline)) s64 byte(signed char c) { return c; }
__attribute__((noinline)) u64 half(unsigned short h) { return h; }

__attribute__((noinline)) u64 via_scale(u64 v) { return scale((unsigned)v | 1); }
__attribute__((noinline)) s64 via_widen(u64 v) { return widen((int)v + 1); }
__attribute__((noinline)) u64 via_halve(u64 v) { return halve((unsigned)v ^ 2); }
__attribute__((noinline)) s64 via_sum(u64 v, u64 w) { return sum((int)v, (int)w - 1); }
__attribute__((noinline)) s64 via_pick(const s64 *a, u64 v) { return pick(a, (int)v - 5); }
__attribute__((noinline)) s64 via_pick_u(const s64 *a, u64 v) { return pick_u(a, (unsigned)v + 1); }
__attribute__((noinline)) s64 via_byte(u64 v) { return byte((signed char)v); }
__attribute__((noinline)) u64 via_half(u64 v) { return half((unsigned short)v); }

int main(void) {
    static const s64 table[8] = {10, 11, 12, 13, 14, 15, 16, 17};
    volatile u64 hi = 0xdeadbeef00000004ULL, neg = 0x12345678fffffffcULL;

    if (via_scale(hi) != 15)
        return 1;
    if (via_widen(neg) != -3)
        return 2;
    if (via_halve(hi) != 3)
        return 3;
    if (via_sum(hi, neg) != -1)
        return 4;
    if (via_pick(table + 4, hi) != 13)
        return 5;
    if (via_pick_u(table, hi) != 15)
        return 6;
    if (via_byte(0x12345678ffffff85ULL) != -123)
        return 7;
    if (via_half(0xdeadbeef1234fffeULL) != 0xfffe)
        return 8;
    return 0;
}
