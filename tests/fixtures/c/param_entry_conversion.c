// The entry converts each narrow parameter on its way from the incoming
// register to its home: a callee-saved register, a frame slot under a
// capped register pool, or the incoming register itself. Each callee is
// reached through a volatile pointer whose type passes 64-bit integers, so
// a pattern sits above every narrow value (AAPCS64 6.8.2, System V AMD64
// 3.2.3, the x64 convention).

#define NOINLINE __attribute__((noinline))

typedef unsigned long long u64;
typedef long long i64;

NOINLINE static i64 pass(i64 x) { return x; }

// Every parameter is live across the calls.
NOINLINE static i64 across(signed char a, short b, int c, unsigned char d, i64 e,
                           unsigned short f) {
    i64 s = pass(a) + pass(b) + pass(c);
    return s * 2 + a + b + c + d + e + f;
}

// A leaf: each parameter can convert in its incoming register.
NOINLINE static i64 leaf(signed char a, short b, int c, int d) {
    return (i64)a * 1000000000000 + (i64)b * 1000000 + (i64)c * 3 + d;
}

NOINLINE static i64 order(i64 a, i64 b, i64 c) { return a * 10000 + b * 100 + c; }

// The parameters reach the calls in other orders.
NOINLINE static i64 permute(int a, short b, signed char c) {
    return order(c, a, b) - order(b, c, a);
}

// Only the low word of each parameter is read.
NOINLINE static int low(int a, int b) { return a * b + 1; }

int main(void) {
    i64 (*volatile f_across)(u64, u64, u64, u64, u64, u64) =
        (i64 (*)(u64, u64, u64, u64, u64, u64))across;
    i64 (*volatile f_leaf)(u64, u64, u64, u64) = (i64 (*)(u64, u64, u64, u64))leaf;
    i64 (*volatile f_permute)(u64, u64, u64) = (i64 (*)(u64, u64, u64))permute;
    int (*volatile f_low)(u64, u64) = (int (*)(u64, u64))low;

    // -5, -300, -16, 200, -1000, 65280.
    if (f_across(0x5a5a5a5a5a5a5afbull, 0xa5a5a5a5a5a5fed4ull, 0x5a5a5a5afffffff0ull,
                 0xa5a5a5a5a5a5a5c8ull, (u64)-1000, 0x5a5a5a5a5a5aff00ull) != 63517)
        return 1;
    // 100, -2, 123456789, -7.
    if (f_leaf(0xa5a5a5a5a5a5a564ull, 0x5a5a5a5a5a5afffeull, 0xa5a5a5a5075bcd15ull,
               0x5a5a5a5afffffff9ull) != 100000368370360ll)
        return 2;
    // -40000, 1234, -128.
    if (f_permute(0xa5a5a5a5ffff63c0ull, 0x5a5a5a5a5a5a04d2ull, 0xa5a5a5a5a5a5a580ull) !=
        -17565966)
        return 3;
    // 3, -2.
    if (f_low(0x5a5a5a5a00000003ull, 0xa5a5a5a5fffffffeull) != -5)
        return 4;
    return 0;
}
