// DEFERRED: C99 integer-boundary "final-boss" fixture.
// Every signed / unsigned x {char, short, int, long} combination,
// across load, store, sign / zero extension, narrowing cast,
// overflow / underflow, and the full shift / compare set. Encodes
// the C99 spec; today c5 fails some of these by design.
//
// Known divergences (each CHECK carries a unique exit code so a
// non-zero exit pinpoints the bug):
//   * code 100: sizeof(signed char) == 1 fails because c5 promotes
//     `signed char` -> int (it has to, otherwise parser-generator
//     tables that store negative rule sizes in `signed char` slots
//     read those values as 255 and walk off into wild memory).
//   * codes 150 / 151: (i8)(int)-300 == -44 fails for the same
//     reason -- signed char is int, so the narrowing cast is a
//     no-op.
//   * code 136: (u64)(u32)INT_MIN == 0x80000000ul fails because
//     c5's same-width signed -> unsigned cast doesn't emit a
//     mask, and the value lives 64-bit-sign-extended in the
//     register before the (u64) widens it.
//
// Future-fix layers:
//   1. `signed char` as a real 1-byte type with proper sign-
//      extending load (would need to revisit the lemon-tables
//      regression that drove the int promotion in the first
//      place).
//   2. Same-width signed -> unsigned cast: emit `Op::And mask`
//      when the cast target is unsigned and the source is signed,
//      regardless of width parity.
//
// Layered on top of integer_ops_exhaustive.c (happy path); this
// fixture focuses on signed / unsigned boundary values where
// bugs hide:
//   * char     -- 0x7F / 0x80 / 0xFF
//   * short    -- 0x7FFF / 0x8000 / 0xFFFF
//   * int      -- 0x7FFFFFFF / 0x80000000 / 0xFFFFFFFF
//   * long     -- 0x7FFFFFFFFFFFFFFF / 0x8000000000000000 / 0xFFFFFFFFFFFFFFFF
#include <stdio.h>
#include <stdlib.h>

static int err = 0;
#define CHECK(cond, code) do { if (!(cond)) { err = (code); fprintf(stderr, "fail at line %d (code %d)\n", __LINE__, code); } } while (0)

typedef signed char   i8;
typedef unsigned char u8;
typedef short         i16;
typedef unsigned short u16;
typedef int           i32;
typedef unsigned int  u32;
typedef long          i64;
typedef unsigned long u64;

int main() {
    // ===== sizeof =====
    CHECK(sizeof(i8)  == 1, 100);
    CHECK(sizeof(u8)  == 1, 101);
    CHECK(sizeof(i16) == 2, 102);
    CHECK(sizeof(u16) == 2, 103);
    CHECK(sizeof(i32) == 4, 104);
    CHECK(sizeof(u32) == 4, 105);
    CHECK(sizeof(i64) == 8, 106);
    CHECK(sizeof(u64) == 8, 107);

    // ===== char boundary =====
    {
        u8 a = 0xFF;
        CHECK(a == 255, 110);
        a++;
        CHECK(a == 0, 111);                 // u8 overflow wraps
        a--;
        CHECK(a == 0xFF, 112);              // u8 underflow wraps

        i8 b = 0x7F;          // INT8_MAX (after promotion to int)
        CHECK(b == 127, 113);
        i8 c = -128;
        CHECK(c == -128, 114);              // INT8_MIN survives load
        c--;
        CHECK((u8)c == 0x7F, 115);          // 8-bit underflow
    }

    // ===== short boundary =====
    {
        u16 a = 0xFFFF;
        CHECK(a == 65535, 120);
        a++;
        CHECK(a == 0, 121);                 // u16 wraps
        a = 0;
        a--;
        CHECK(a == 0xFFFF, 122);

        i16 b = 0x7FFF;
        CHECK(b == 32767, 123);
        i16 c = -32768;
        CHECK(c == -32768, 124);            // INT16_MIN survives
        u16 d = (u16)c;
        CHECK(d == 0x8000, 125);            // signed -> unsigned bitcast

        // 16-bit truncation on store
        i32 wide = 0x12345;
        i16 narrow = (i16)wide;
        CHECK(narrow == 0x2345, 126);

        // Sign extension on load: -42 round-trip
        i16 e = -42;
        i32 ext = e;
        CHECK(ext == -42, 127);

        // Zero extension on unsigned load: 0xFFFF stays 0xFFFF
        u16 f = 0xFFFF;
        u32 ze = f;
        CHECK(ze == 0xFFFF, 128);
        // And not sign-extended into the high half
        CHECK((u64)f == 0xFFFFul, 129);
    }

    // ===== int boundary =====
    {
        u32 a = 0xFFFFFFFFu;
        CHECK(a == 4294967295u, 130);
        a++;
        CHECK(a == 0, 131);                 // u32 wraps to 0
        a = 0;
        a--;
        CHECK(a == 0xFFFFFFFFu, 132);       // underflow

        i32 b = 0x7FFFFFFF;
        CHECK(b == 2147483647, 133);
        i32 c = -2147483647 - 1;            // INT32_MIN; written this way
        CHECK(c == -2147483648, 134);       // to avoid the -2147483648 literal
                                            // tripping unary-minus-of-positive
                                            // overflow in some C frontends

        // Widening to long: signed sign-extends, unsigned zero-extends.
        i64 ws = c;
        CHECK(ws == -2147483648l, 135);
        u64 wu = (u64)(u32)c;               // bitcast through unsigned 32
        CHECK(wu == 0x80000000ul, 136);
    }

    // ===== long boundary =====
    {
        u64 a = 0xFFFFFFFFFFFFFFFFul;
        CHECK(a == 18446744073709551615ul, 140);
        a++;
        CHECK(a == 0, 141);
        a--;
        CHECK(a == 0xFFFFFFFFFFFFFFFFul, 142);

        i64 b = 0x7FFFFFFFFFFFFFFFl;
        CHECK(b == 9223372036854775807l, 143);

        // Right shift: arithmetic (signed) preserves sign,
        // logical (unsigned) zero-fills.
        i64 c = -1;
        CHECK((c >> 1) == -1, 144);          // arithmetic SAR

        u64 d = 0x8000000000000000ul;
        CHECK((d >> 1) == 0x4000000000000000ul, 145);  // logical LSR

        u64 e = 0xFFFFFFFFFFFFFFFFul;
        CHECK((e >> 32) == 0xFFFFFFFFul, 146);         // logical
    }

    // ===== mixed-width operations =====
    {
        // (i8)(i32) cast: high half discarded, sign-extension on
        // re-load.
        i32 wide = -300;
        i8 narrow = (i8)wide;
        CHECK(narrow == (i8)0xD4, 150);     // -300 & 0xFF = 0xD4 = -44 (signed)
        CHECK(narrow == -44, 151);

        // (u8)(i32) cast: high half discarded, zero-extension on
        // re-load.
        u8 zerow = (u8)wide;
        CHECK(zerow == 0xD4, 152);
        CHECK((i32)zerow == 212, 153);

        // (i16)(i32) -- truncation + sign-extension round-trip.
        wide = 0x12345;
        i16 si = (i16)wide;
        CHECK(si == 0x2345, 154);
        CHECK((i32)si == 0x2345, 155);

        wide = 0x1FFFF;
        si = (i16)wide;
        CHECK(si == -1, 156);                // 0xFFFF as i16 = -1
        CHECK((i32)si == -1, 157);
    }

    // ===== unsigned compare boundaries =====
    {
        u32 a = 0xFFFFFFFFu;
        u32 b = 1u;
        CHECK(a > b, 160);                   // unsigned: a is huge
        i32 sa = (i32)a;                     // signed: -1
        i32 sb = (i32)b;
        CHECK(sa < sb, 161);                 // signed: -1 < 1
    }

    // ===== shift edge cases (per C99 6.5.7) =====
    {
        // Left shift of negative signed int is UB but commonly
        // does the bitwise thing. Skip for portability.
        i32 a = 1;
        CHECK((a << 30) == 0x40000000, 170);
        u32 ua = 1u;
        CHECK((ua << 31) == 0x80000000u, 171);

        // Right-shift count = 0 must be a no-op.
        i32 b = -1;
        CHECK((b >> 0) == -1, 172);
        u32 ub = 0xFFFFFFFFu;
        CHECK((ub >> 0) == 0xFFFFFFFFu, 173);
    }

    if (err == 0) {
        printf("OK\n");
        return 0;
    }
    return err;
}
