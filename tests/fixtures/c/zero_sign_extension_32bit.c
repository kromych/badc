// 32-bit r-value zero / sign extension audit.
//
// Every load of a 32-bit slot must extend to the full 64-bit
// accumulator per the slot's signedness:
//   * `int x;`           sign-extends   (Op::Lw)
//   * `unsigned int u;`  zero-extends   (Op::Lwu)
// Casts and arithmetic that flow through the slot must also
// preserve the right extension.
#include <stdio.h>
#include <stdlib.h>

static int err = 0;
#define CHECK(cond, code) do { \
    if (!(cond)) { err = (code); fprintf(stderr, "fail line %d code %d\n", __LINE__, code); } \
} while (0)

typedef int           i32;
typedef unsigned int  u32;
typedef long          i64;
typedef unsigned long u64;

int main() {
    // ---- Direct loads ----
    {
        i32 s = -1;                       // 0xFFFFFFFF in 4 bytes
        i64 widened = s;                  // sign-extend on load
        CHECK(widened == -1L, 1);
        CHECK((u64)s == 0xFFFFFFFFFFFFFFFFul, 2);

        u32 u = 0xFFFFFFFFu;
        i64 z = u;                        // zero-extend on load
        CHECK(z == 0xFFFFFFFFL, 3);
        CHECK((u64)u == 0xFFFFFFFFul, 4);
    }

    // ---- Cast int <-> unsigned int round-trip ----
    {
        i32 s = -7;
        u32 u = (u32)s;                   // bit-cast: 0xFFFFFFF9
        CHECK(u == 0xFFFFFFF9u, 10);
        i32 back = (i32)u;
        CHECK(back == -7, 11);

        // Same-width signed -> unsigned must mask the high half.
        // `(u64)(u32)s` is a two-step cast: int -> uint -> ulong.
        // Result must be 0xFFFFFFF9, NOT 0xFFFFFFFFFFFFFFF9.
        u64 wide = (u64)(u32)s;
        CHECK(wide == 0xFFFFFFF9ul, 12);
    }

    // ---- Arithmetic results must extend correctly when stored ----
    {
        i32 a = 1000000;
        i32 b = 3000;
        i32 prod_lo = a * b;              // overflow truncate-and-sign-extend
        // 1e6 * 3e3 = 3e9, > INT_MAX (2.147e9). Wraps to
        // 3000000000 - 2^32 = -1294967296 as int.
        CHECK(prod_lo == -1294967296, 20);
        CHECK((i64)prod_lo == -1294967296L, 21);

        u32 ua = 0x10000u;
        u32 ub = 0x10000u;
        u32 uprod = ua * ub;              // overflow wraps to 0
        CHECK(uprod == 0u, 22);
        CHECK((u64)uprod == 0ul, 23);
    }

    // ---- Bare register-resident expressions, no slot round-trip ----
    {
        u32 u = 0x80000000u;
        // Right shift on unsigned: result type stays unsigned int.
        // (u >> 1) is u32 = 0x40000000. Widen to u64 -> 0x40000000.
        u64 r = (u64)(u >> 1);
        CHECK(r == 0x40000000ul, 30);

        // Left shift on unsigned: must mask to 32 bits.
        u32 v = 0x12345678u;
        u64 sh = (u64)(v << 4);           // 0x23456780, NOT 0x123456780
        CHECK(sh == 0x23456780ul, 31);

        // Unary `~` on unsigned: must mask to 32 bits.
        u32 w = 0x0u;
        u64 nt = (u64)(~w);                // 0xFFFFFFFF, NOT 0xFFFFFFFFFFFFFFFF
        CHECK(nt == 0xFFFFFFFFul, 32);
    }

    // ---- Function call return widths ----
    {
        // atoi returns int -- result must sign-extend through the
        // 64-bit return register no matter what host libc puts in
        // the high half.
        int n = atoi("-2147483647");
        CHECK(n == -2147483647, 40);
        CHECK((i64)n == -2147483647L, 41);
    }

    // ---- Mixed signed/unsigned widening ----
    {
        i32 s = -1;
        u32 u = 1u;
        // C99: common = uint. (s + u) at uint = 0. Stored in a u64
        // slot: zero-extend.
        u64 sum = (u64)(s + u);
        CHECK(sum == 0ul, 50);

        // (s - u) at uint = 0xFFFFFFFE. Widened to u64.
        u64 diff = (u64)(s - u);
        CHECK(diff == 0xFFFFFFFEul, 51);
    }

    // ---- Sign-extended store-and-reload for narrow signed ints ----
    {
        i32 s = 0x12345678;
        // Read back through int slot: must round-trip exactly.
        CHECK(s == 0x12345678, 60);
        i64 wide = s;
        CHECK(wide == 0x12345678L, 61);

        // Negative round-trip.
        s = -2000000000;
        wide = s;
        CHECK(wide == -2000000000L, 62);
        CHECK(s == -2000000000, 63);
    }

    if (err == 0) {
        printf("OK\n");
        return 0;
    }
    return err;
}
