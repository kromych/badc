// DEFERRED: C99 6.3.1.8 usual-arithmetic-conversions width truncation.
//
// After Add / Sub / Mul / Div / Mod the result should be at the
// common type's storage width. c5 does the right thing for the
// signed common-type case (the 64-bit accumulator's sign-ext
// value matches what a signed slot expects), but does NOT mask /
// sign-extend after the op when the common type is narrower than
// 8 bytes. Visible bit patterns diverge from clang/gcc whenever
// the intermediate value falls outside the type's representable
// range -- specifically:
//
//   1. `uint + uint` overflow (`0xFFFFFFFFu + 1`): c5 keeps
//      0x100000000 in the 64-bit register; C99 says wrap to 0.
//   2. `int + uint` mixed (common = uint per C99): c5 leaves
//      the signed-extended high half of the int operand;
//      `(int)-1 - (uint)1` reads back as -2 (sign-extended)
//      instead of 0xFFFFFFFE.
//   3. `signed-int * signed-int` overflow (e.g. `ushort * ushort`
//      after promotion -> `int * int` overflows): clang truncates
//      to int width and sign-extends back; c5 keeps the wider
//      i64 value. C99 calls this UB so both are technically
//      conforming; matching clang is the more useful behavior.
//
// The fix is to emit a post-op mask (Op::And for unsigned narrow
// common types) and a sign-extending shift-pair (Op::Shl /
// Op::Shr for signed narrow common types) after Add / Sub / Mul.
// First attempt regressed sqlite's REAL aggregate path -- some
// internal sqlite arithmetic relied on c5's wide-register
// behavior. Tracked here so the fix can be revisited with
// targeted bisection of the sqlite code path.
//
// This fixture asserts the C99-strict result for each operation;
// each CHECK has a unique exit code so a regression pinpoints
// the failing case. Today five codes (1, 2, 3, 4, 5) fire.
#include <stdio.h>
#include <stdlib.h>

static int err = 0;
#define CHECK(cond, code) do { \
    if (!(cond)) { err = (code); fprintf(stderr, "fail line %d code %d\n", __LINE__, code); } \
} while (0)

int main() {
    // 1. uint + uint overflow wraps at 32 bits.
    {
        unsigned int u = 0xFFFFFFFFu;
        unsigned int sum = u + 1u;
        CHECK(sum == 0u, 1);
    }

    // 2. uint - uint underflow wraps at 32 bits.
    {
        unsigned int v = 0u;
        unsigned int diff = v - 1u;
        CHECK(diff == 0xFFFFFFFFu, 2);
    }

    // 3. (int -1) - (uint 1) at common = uint = 0xFFFFFFFE
    {
        int i = -1;
        unsigned int u = 1u;
        unsigned int diff = i - u;
        CHECK(diff == 0xFFFFFFFEu, 3);
    }

    // 4. (int -1) * (uint 1) at common = uint = 0xFFFFFFFF
    {
        int i = -1;
        unsigned int u = 1u;
        unsigned int prod = i * u;
        CHECK(prod == 0xFFFFFFFFu, 4);
    }

    // 5. signed int * signed int overflow truncates to int width
    //    (matches clang's "truncate + sign-extend" convention; UB
    //    per C99, but useful to be consistent).
    {
        unsigned short us = 50000;
        // After integer promotion, both us are int. 50000*50000 =
        // 2,500,000,000 overflows i32; clang's representable result
        // is 2500000000 - 2^32 = -1794967296. The low 32 bits are
        // 0x9502F900 = -1794967296 sign-extended.
        long product = (long)(us * us);
        CHECK(product == -1794967296L, 5);
    }

    // ---- forward-looking checks that already pass today ----

    // (int -1) + (uint 1) -- accidentally correct because both
    // sign-ext'd value (-1 + 1) and unsigned (0xFFFFFFFF + 1) wrap
    // to 0 at the matching width. The 64-bit reg value is 0,
    // which prints as "0".
    {
        int i = -1;
        unsigned int u = 1u;
        unsigned int sum = i + u;
        CHECK(sum == 0u, 100);
    }

    // (long)-1 < (uint)1: common = signed long (long can hold all
    // uint values). Compare signed: -1 < 1 -> true. Already passes
    // after the recent compare-common-type fix.
    {
        long l = -1;
        unsigned int u = 1u;
        CHECK(l < u, 101);
    }

    // (int)-1 == (uint)0xFFFFFFFF: at common = uint, both sides
    // 0xFFFFFFFF -> equal. Already passes after the Eq XOR-mask
    // fix.
    {
        int i = -1;
        unsigned int u = 0xFFFFFFFFu;
        CHECK(i == u, 102);
    }

    if (err == 0) { printf("OK\n"); return 0; }
    return err;
}
