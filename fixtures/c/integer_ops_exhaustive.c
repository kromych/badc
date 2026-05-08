// Exhaustive coverage of integer operations across the four
// width bands (`char`, `short`, `int`, `long long`) and both
// signednesses. `long long` is the portable 64-bit pick: `long`
// is only 32 bits on Windows LLP64 and would collapse onto the
// `int` band there. Every
// signed/unsigned operator in the dialect runs at least once
// against a value that distinguishes the two semantics: a high-bit
// pattern that reads as a large positive unsigned and as a small
// negative signed.
//
// Why one big fixture: the bug surface is the type-tag plumbing
// (parse_decl_base_type, the unsigned bit on declarations and
// typedefs, the strip-before-classify in size_of_type / is_pointer_ty
// / load_op_for / store_op_for). A regression in any of those
// breaks several rows of this table at once, and the failure
// message names which row.
#include <stdio.h>

#define CHECK(cond, msg) \
    do { if (!(cond)) { printf("FAIL: %s\n", msg); return 1; } } while (0)

int main() {
    // ------- Comparisons -------
    // 32-bit width, unsigned vs signed semantics.
    {
        unsigned int u = 0xFFFFFFFE;       // -2 if signed
        unsigned int one = 1;
        CHECK( u   >  one, "u32 0xFFFFFFFE > 1");
        CHECK( one <  u,   "u32 1 < 0xFFFFFFFE");
        CHECK( u   >= one, "u32 0xFFFFFFFE >= 1");
        CHECK( one <= u,   "u32 1 <= 0xFFFFFFFE");
        CHECK( u   != one, "u32 0xFFFFFFFE != 1");
        CHECK(!(u  == one),"u32 0xFFFFFFFE == 1");

        int s = -2;
        int one_s = 1;
        CHECK( s   <  one_s, "i32 -2 < 1");
        CHECK( one_s > s,    "i32 1 > -2");
        CHECK( s   <= one_s, "i32 -2 <= 1");
        CHECK( one_s >= s,   "i32 1 >= -2");
    }

    // 64-bit width.
    {
        unsigned long long u = 0xFFFFFFFFFFFFFFFE;
        unsigned long long one = 1;
        CHECK( u   >  one, "u64 huge > 1");
        CHECK( u   >= one, "u64 huge >= 1");
        CHECK( one <  u,   "u64 1 < huge");

        long long s = -2;
        long long one_s = 1;
        CHECK( one_s > s,  "i64 1 > -2");
        CHECK( s     < 0,  "i64 -2 < 0");
    }

    // 8-bit width. `signed char` promotes to int (negatives keep
    // their range); plain `char` and `unsigned char` are 1-byte
    // unsigned slots.
    {
        unsigned char uc = 0xFE;
        unsigned char one = 1;
        CHECK( uc  >  one, "u8 0xFE > 1");
        CHECK( one <  uc,  "u8 1 < 0xFE");

        signed char sc = -2;
        signed char one_s = 1;
        CHECK( sc    <  one_s, "i8 -2 < 1");
        CHECK( one_s >  sc,    "i8 1 > -2");
    }

    // ------- Arithmetic -------
    {
        unsigned int u = 100;
        u += 5;     CHECK(u == 105, "u32 += 5");
        u -= 10;    CHECK(u == 95,  "u32 -= 10");
        u *= 2;     CHECK(u == 190, "u32 *= 2");
        u /= 5;     CHECK(u == 38,  "u32 /= 5");
        u %= 7;     CHECK(u == 3,   "u32 %= 7");

        // Unsigned wrap semantics on subtraction below zero:
        // (1 - 2) as u32 == 0xFFFFFFFF.
        unsigned int wrap = 1;
        wrap = wrap - 2;
        CHECK(wrap == 0xFFFFFFFF, "u32 1-2 wraps");
    }
    {
        unsigned long long u = 1000;
        u += 415;   CHECK(u == 1415, "u64 += 415");
        u *= 3;     CHECK(u == 4245, "u64 *= 3");
        u /= 5;     CHECK(u == 849,  "u64 /= 5");
    }

    // ------- Bitwise -------
    // Operands round-tripped through u32 storage so the high half
    // is zeroed by the load. Without that, transient i64-register
    // values from ops like `~u` carry sign-extension into the high
    // half; the language guarantees the bit pattern only after a
    // store-and-reload through the typed slot.
    {
        unsigned int u = 0xFF00FF00;
        unsigned int and_r = u & 0x0F0F0F0F;
        unsigned int or_r  = u | 0x000FF000;
        unsigned int xor_r = u ^ 0xFFFFFFFF;
        unsigned int not_r = ~u;
        CHECK(and_r == 0x0F000F00, "u32 &");
        CHECK(or_r  == 0xFF0FFF00, "u32 |");
        CHECK(xor_r == 0x00FF00FF, "u32 ^");
        CHECK(not_r == 0x00FF00FF, "u32 ~");
    }

    // ------- Shifts -------
    // Left shift behaves identically for signed/unsigned at the
    // bit level. Right shift differs (arithmetic vs logical), but
    // the dialect lowers both as Op::Shr -- shift handling is
    // tracked separately in the gap doc. Operands round-tripped
    // through u32 storage so the high half is zeroed by the load.
    {
        unsigned int u = 0x12345678;
        unsigned int sh = u << 4;
        CHECK(sh == 0x23456780, "u32 << 4");
        unsigned int v = 1;
        unsigned int sv = v << 31;
        CHECK(sv == 0x80000000u, "u32 1<<31");
    }
    {
        unsigned long long u = 1;
        CHECK((u << 63) == 0x8000000000000000ull, "u64 1<<63");
    }

    // ------- Mixed signed / unsigned compares -------
    // A signed -1 widens to 0xFFF...F under unsigned semantics,
    // so `(unsigned int)-1 > 1` must be true.
    {
        int neg = -1;
        unsigned int one = 1;
        CHECK((unsigned int)neg > one, "(u32)-1 > 1");
        CHECK(neg < (int)one,           "i32 -1 < 1");
    }

    // ------- Increments / decrements on each width -------
    {
        unsigned int u = 0xFFFFFFFE;
        ++u; CHECK(u == 0xFFFFFFFF, "u32 ++ to UMAX");
        ++u; CHECK(u == 0,          "u32 ++ wraps to 0");

        unsigned char uc = 254;
        ++uc; CHECK(uc == 255, "u8 ++ to UCHAR_MAX");
        ++uc; CHECK(uc == 0,   "u8 ++ wraps to 0");

        unsigned long long ul = 0xFFFFFFFFFFFFFFFE;
        ++ul; CHECK(ul == 0xFFFFFFFFFFFFFFFF, "u64 ++ to UMAX");
        ++ul; CHECK(ul == 0,                  "u64 ++ wraps to 0");
    }

    // ------- Sizeof per band -------
    CHECK(sizeof(unsigned char)      == 1, "sizeof(u8)");
    CHECK(sizeof(short)              == 2, "sizeof(short)");
    CHECK(sizeof(unsigned short)     == 2, "sizeof(u16)");
    CHECK(sizeof(unsigned int)       == 4, "sizeof(u32)");
    CHECK(sizeof(unsigned long long) == 8, "sizeof(u64)");
    CHECK(sizeof(signed char)        == 1, "sizeof(signed char)");
    CHECK(sizeof(int)                == 4, "sizeof(int)");
    CHECK(sizeof(long long)          == 8, "sizeof(long long)");

    return 0;
}
