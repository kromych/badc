// GCC vector extension: element-wise `+ - * / %` and the shifts over integer
// vectors, plus unary `-` and `~`. A scalar operand on either side broadcasts
// to every lane, and compound assignment is `v = v OP w` (C99 6.5.16.2p3).
//
// Every result is checked against a scalar loop over the lanes at the element
// type, which is the semantics the extension defines. Both signedness flavours
// and all five integer element widths are covered, with lane values chosen so
// the narrow widths wrap on add / sub / mul.
//
// Shift counts stay below the element width: a count at or past it is
// undefined (6.5.7p3) and the reference compilers already differ on it.
// A zero lane divisor is likewise left out -- it is the scalar 6.5.5p5 case
// and traps or not exactly as the target's scalar divide does.

typedef __attribute__((vector_size(16))) unsigned char u8x16;
typedef __attribute__((vector_size(16))) signed char i8x16;
typedef __attribute__((vector_size(16))) unsigned short u16x8;
typedef __attribute__((vector_size(16))) short i16x8;
typedef __attribute__((vector_size(16))) unsigned int u32x4;
typedef __attribute__((vector_size(16))) int i32x4;
typedef __attribute__((vector_size(16))) unsigned long long u64x2;
typedef __attribute__((vector_size(16))) long long i64x2;
typedef __attribute__((vector_size(8))) unsigned char u8x8;
typedef __attribute__((vector_size(32))) unsigned int u32x8;

static int same(const void *a, const void *b, int n) {
    const unsigned char *p = (const unsigned char *)a;
    const unsigned char *q = (const unsigned char *)b;
    for (int i = 0; i < n; i++) {
        if (p[i] != q[i]) return 0;
    }
    return 1;
}

// One check per operator per element type: compute the vector result, build
// the reference by looping the same operator over the lanes, compare bytes.
#define CHECK(vty, ety, lanes, va, vb, op, code)                                                   \
    do {                                                                                           \
        vty vr = (va)op(vb);                                                                        \
        ety ref[lanes];                                                                            \
        const ety *pa = (const ety *)&(va);                                                        \
        const ety *pb = (const ety *)&(vb);                                                        \
        for (int i = 0; i < (lanes); i++) ref[i] = (ety)(pa[i] op pb[i]);                          \
        if (!same(&vr, ref, (int)sizeof(vr))) return (code);                                       \
    } while (0)

// Scalar broadcast: `v op s` and `s op v`.
#define CHECK_BC(vty, ety, lanes, va, s, op, code)                                                 \
    do {                                                                                           \
        vty vr = (va)op(s);                                                                         \
        ety ref[lanes];                                                                            \
        const ety *pa = (const ety *)&(va);                                                        \
        for (int i = 0; i < (lanes); i++) ref[i] = (ety)(pa[i] op(ety)(s));                        \
        if (!same(&vr, ref, (int)sizeof(vr))) return (code);                                       \
    } while (0)

#define CHECK_RBC(vty, ety, lanes, s, va, op, code)                                                \
    do {                                                                                           \
        vty vr = (s)op(va);                                                                         \
        ety ref[lanes];                                                                            \
        const ety *pa = (const ety *)&(va);                                                        \
        for (int i = 0; i < (lanes); i++) ref[i] = (ety)((ety)(s)op pa[i]);                        \
        if (!same(&vr, ref, (int)sizeof(vr))) return (code);                                       \
    } while (0)

// `v OP= w` must land the same value `v = v OP w` does.
#define CHECK_CA(vty, va, vb, op, code)                                                            \
    do {                                                                                           \
        vty want = (va)op(vb);                                                                      \
        vty got = (va);                                                                            \
        got op## = (vb);                                                                           \
        if (!same(&got, &want, (int)sizeof(got))) return (code);                                   \
    } while (0)

int main(void) {
    u8x16 a = {0, 1, 2, 3, 100, 127, 128, 200, 255, 5, 6, 7, 8, 9, 10, 11};
    u8x16 b = {1, 2, 3, 4, 200, 129, 128, 100, 1, 3, 7, 9, 11, 13, 17, 19};
    // sb[6] avoids -1 against sa[6] == -128: INT_MIN / -1 overflows (6.5.5p6).
    i8x16 sa = {0, 1, -1, 3, 100, 127, -128, -100, -1, 5, -6, 7, -8, 9, -10, 11};
    i8x16 sb = {1, 2, 3, -4, 100, 3, 5, 7, -3, 3, 7, -9, 11, 13, -17, 19};
    u16x8 ha = {0, 1, 32767, 32768, 65535, 1000, 4321, 9};
    u16x8 hb = {1, 2, 3, 32768, 7, 999, 65535, 3};
    i16x8 sha = {0, 1, -1, 32767, -32768, 1000, -4321, 9};
    i16x8 shb = {1, 2, 3, -4, 7, -999, 32767, -3};
    u32x4 wa = {0, 2147483647u, 2147483648u, 4294967295u};
    u32x4 wb = {1, 3, 65537, 7};
    i32x4 swa = {0, 2147483647, -2147483647 - 1, -1};
    i32x4 swb = {1, 3, -65537, 7};
    u64x2 qa = {0, 18446744073709551615ull};
    u64x2 qb = {3, 1000000007ull};
    i64x2 sqa = {-9223372036854775807LL - 1, -1};
    i64x2 sqb = {3, -1000000007LL};
    u8x8 na = {1, 2, 3, 4, 250, 251, 252, 253};
    u8x8 nb = {9, 8, 7, 6, 10, 11, 12, 13};
    u32x8 xa = {1, 2, 3, 4, 5, 6, 7, 8};
    u32x8 xb = {8, 7, 6, 5, 4, 3, 2, 1};

    // 1-byte lanes, unsigned then signed.
    CHECK(u8x16, unsigned char, 16, a, b, +, 1);
    CHECK(u8x16, unsigned char, 16, a, b, -, 2);
    CHECK(u8x16, unsigned char, 16, a, b, *, 3);
    CHECK(u8x16, unsigned char, 16, a, b, /, 4);
    CHECK(u8x16, unsigned char, 16, a, b, %, 5);
    CHECK(u8x16, unsigned char, 16, a, b, &, 6);
    CHECK(u8x16, unsigned char, 16, a, b, |, 7);
    CHECK(u8x16, unsigned char, 16, a, b, ^, 8);
    CHECK(i8x16, signed char, 16, sa, sb, +, 9);
    CHECK(i8x16, signed char, 16, sa, sb, -, 10);
    CHECK(i8x16, signed char, 16, sa, sb, *, 11);
    CHECK(i8x16, signed char, 16, sa, sb, /, 12);
    CHECK(i8x16, signed char, 16, sa, sb, %, 13);
    CHECK(i8x16, signed char, 16, sa, sb, &, 14);

    // 2-byte lanes.
    CHECK(u16x8, unsigned short, 8, ha, hb, +, 15);
    CHECK(u16x8, unsigned short, 8, ha, hb, -, 16);
    CHECK(u16x8, unsigned short, 8, ha, hb, *, 17);
    CHECK(u16x8, unsigned short, 8, ha, hb, /, 18);
    CHECK(u16x8, unsigned short, 8, ha, hb, %, 19);
    CHECK(i16x8, short, 8, sha, shb, +, 20);
    CHECK(i16x8, short, 8, sha, shb, -, 21);
    CHECK(i16x8, short, 8, sha, shb, *, 22);
    CHECK(i16x8, short, 8, sha, shb, /, 23);
    CHECK(i16x8, short, 8, sha, shb, %, 24);

    // 4-byte lanes.
    CHECK(u32x4, unsigned int, 4, wa, wb, +, 25);
    CHECK(u32x4, unsigned int, 4, wa, wb, -, 26);
    CHECK(u32x4, unsigned int, 4, wa, wb, *, 27);
    CHECK(u32x4, unsigned int, 4, wa, wb, /, 28);
    CHECK(u32x4, unsigned int, 4, wa, wb, %, 29);
    CHECK(i32x4, int, 4, swa, swb, +, 30);
    CHECK(i32x4, int, 4, swa, swb, -, 31);
    CHECK(i32x4, int, 4, swa, swb, *, 32);
    CHECK(i32x4, int, 4, swa, swb, /, 33);
    CHECK(i32x4, int, 4, swa, swb, %, 34);

    // 8-byte lanes.
    CHECK(u64x2, unsigned long long, 2, qa, qb, +, 35);
    CHECK(u64x2, unsigned long long, 2, qa, qb, -, 36);
    CHECK(u64x2, unsigned long long, 2, qa, qb, *, 37);
    CHECK(u64x2, unsigned long long, 2, qa, qb, /, 38);
    CHECK(u64x2, unsigned long long, 2, qa, qb, %, 39);
    CHECK(i64x2, long long, 2, sqa, sqb, +, 40);
    CHECK(i64x2, long long, 2, sqa, sqb, -, 41);
    CHECK(i64x2, long long, 2, sqa, sqb, *, 42);
    CHECK(i64x2, long long, 2, sqa, sqb, /, 43);
    CHECK(i64x2, long long, 2, sqa, sqb, %, 44);

    // Vector widths other than 16 bytes.
    CHECK(u8x8, unsigned char, 8, na, nb, +, 45);
    CHECK(u8x8, unsigned char, 8, na, nb, *, 46);
    CHECK(u32x8, unsigned int, 8, xa, xb, +, 47);
    CHECK(u32x8, unsigned int, 8, xa, xb, -, 48);

    // Shifts: vector count, and a scalar count on the right. The arithmetic
    // flavour follows the element type, not the count's.
    u8x16 sc8 = {0, 1, 2, 3, 4, 5, 6, 7, 0, 1, 2, 3, 4, 5, 6, 7};
    i16x8 sci16 = {0, 1, 5, 9, 12, 15, 3, 7};
    CHECK(u8x16, unsigned char, 16, a, sc8, <<, 49);
    CHECK(u8x16, unsigned char, 16, a, sc8, >>, 50);
    CHECK(i16x8, short, 8, sha, sci16, >>, 51);
    CHECK(i16x8, short, 8, sha, sci16, <<, 52);
    CHECK_BC(i32x4, int, 4, swa, 3, >>, 53);
    CHECK_BC(u32x4, unsigned int, 4, wa, 3, >>, 54);
    CHECK_BC(i8x16, signed char, 16, sa, 2, <<, 55);

    // Scalar broadcast, right operand and left operand. `a - 0x40` is the
    // shape the kernel's aegis128 round steps its table index with.
    CHECK_BC(u8x16, unsigned char, 16, a, 0x40, -, 56);
    CHECK_BC(u8x16, unsigned char, 16, a, 100, +, 57);
    CHECK_BC(u8x16, unsigned char, 16, a, 7, *, 58);
    CHECK_BC(u8x16, unsigned char, 16, a, 7, /, 59);
    CHECK_BC(u8x16, unsigned char, 16, a, 7, %, 60);
    CHECK_BC(u8x16, unsigned char, 16, a, 0x0f, &, 61);
    CHECK_BC(u8x16, unsigned char, 16, a, 0xf0, |, 62);
    CHECK_BC(u8x16, unsigned char, 16, a, 0x55, ^, 63);
    CHECK_BC(i8x16, signed char, 16, sa, 100, -, 64);
    CHECK_BC(i8x16, signed char, 16, sa, 3, /, 65);
    CHECK_BC(i8x16, signed char, 16, sa, 3, %, 66);
    CHECK_BC(u16x8, unsigned short, 8, ha, 1000, *, 67);
    CHECK_BC(i64x2, long long, 2, sqa, 7, *, 68);
    CHECK_RBC(u8x16, unsigned char, 16, 0x40, a, -, 69);
    CHECK_RBC(i8x16, signed char, 16, 100, sa, -, 70);
    CHECK_RBC(u8x16, unsigned char, 16, 250, b, /, 71);
    CHECK_RBC(u8x16, unsigned char, 16, 250, b, %, 97);
    CHECK_RBC(u8x16, unsigned char, 16, 0x0f, b, &, 98);
    CHECK_RBC(u8x16, unsigned char, 16, 3, sc8, <<, 99);
    CHECK_RBC(u8x16, unsigned char, 16, 0x80, sc8, >>, 100);
    CHECK_RBC(i32x4, int, 4, -7, swb, /, 101);
    CHECK_RBC(i32x4, int, 4, -7, swb, %, 102);

    // A scalar wider than the lane converts to the lane type before the
    // operation, so the divide runs at the element width.
    CHECK_BC(u8x16, unsigned char, 16, a, (long)3, /, 72);
    CHECK_BC(i32x4, int, 4, swa, (long long)7, /, 96);

    // Unary `-` and `~`, element-wise, no integer promotion of the result.
    {
        u8x16 r = -a;
        unsigned char ref[16];
        const unsigned char *p = (const unsigned char *)&a;
        for (int i = 0; i < 16; i++) ref[i] = (unsigned char)(-p[i]);
        if (!same(&r, ref, 16)) return 73;
    }
    {
        i8x16 r = -sa;
        signed char ref[16];
        const signed char *p = (const signed char *)&sa;
        for (int i = 0; i < 16; i++) ref[i] = (signed char)(-p[i]);
        if (!same(&r, ref, 16)) return 74;
    }
    {
        i32x4 r = -swa;
        int ref[4];
        const int *p = (const int *)&swa;
        for (int i = 0; i < 4; i++) ref[i] = -p[i];
        if (!same(&r, ref, 16)) return 75;
    }
    {
        u8x16 r = ~a;
        unsigned char ref[16];
        const unsigned char *p = (const unsigned char *)&a;
        for (int i = 0; i < 16; i++) ref[i] = (unsigned char)(~p[i]);
        if (!same(&r, ref, 16)) return 76;
    }
    {
        i64x2 r = ~sqa;
        long long ref[2];
        const long long *p = (const long long *)&sqa;
        for (int i = 0; i < 2; i++) ref[i] = ~p[i];
        if (!same(&r, ref, 16)) return 77;
    }

    // Compound assignment, every operator.
    CHECK_CA(u8x16, a, b, +, 78);
    CHECK_CA(u8x16, a, b, -, 79);
    CHECK_CA(u8x16, a, b, *, 80);
    CHECK_CA(u8x16, a, b, /, 81);
    CHECK_CA(u8x16, a, b, %, 82);
    CHECK_CA(u8x16, a, b, &, 83);
    CHECK_CA(u8x16, a, b, |, 84);
    CHECK_CA(u8x16, a, b, ^, 85);
    CHECK_CA(u8x16, a, sc8, <<, 86);
    CHECK_CA(u8x16, a, sc8, >>, 87);
    CHECK_CA(i16x8, sha, shb, /, 88);
    CHECK_CA(i64x2, sqa, sqb, *, 89);
    // Broadcast compound assignment: the `w -= 0x40` spelling itself.
    {
        u8x16 w = a;
        w -= 0x40;
        u8x16 want = a - 0x40;
        if (!same(&w, &want, 16)) return 90;
    }
    // Repeated stepping, as the aegis128 round does between its tbx pairs.
    {
        u8x16 w = a;
        w -= 0x40;
        w -= 0x40;
        w -= 0x40;
        unsigned char ref[16];
        const unsigned char *p = (const unsigned char *)&a;
        for (int i = 0; i < 16; i++) ref[i] = (unsigned char)(p[i] - 0xc0);
        if (!same(&w, ref, 16)) return 91;
    }

    // Chained and nested expressions keep the vector type across operators.
    {
        u8x16 r = (a + b) * 3 - a;
        unsigned char ref[16];
        const unsigned char *p = (const unsigned char *)&a;
        const unsigned char *q = (const unsigned char *)&b;
        for (int i = 0; i < 16; i++)
            ref[i] = (unsigned char)((unsigned char)((unsigned char)(p[i] + q[i]) * 3) - p[i]);
        if (!same(&r, ref, 16)) return 92;
    }
    {
        i32x4 r = -(swa / 3) + swb;
        int ref[4];
        const int *p = (const int *)&swa;
        const int *q = (const int *)&swb;
        for (int i = 0; i < 4; i++) ref[i] = -(p[i] / 3) + q[i];
        if (!same(&r, ref, 16)) return 93;
    }

    // The mix-columns step of the kernel's aegis128 round: a shift by a
    // scalar, a signed lane shift, and a mask, all element-wise.
    {
        u8x16 v = a;
        u8x16 r = (v << 1) ^ (u8x16)(((i8x16)v >> 7) & 0x1b);
        unsigned char ref[16];
        const unsigned char *p = (const unsigned char *)&a;
        for (int i = 0; i < 16; i++) {
            unsigned char hi = (unsigned char)((signed char)p[i] >> 7) & 0x1b;
            ref[i] = (unsigned char)((unsigned char)(p[i] << 1) ^ hi);
        }
        if (!same(&r, ref, 16)) return 94;
    }

    // Two vectors whose elements differ only in signedness operate at the
    // shared element width.
    {
        u8x16 r = a + (u8x16)sa;
        unsigned char ref[16];
        const unsigned char *p = (const unsigned char *)&a;
        const unsigned char *q = (const unsigned char *)&sa;
        for (int i = 0; i < 16; i++) ref[i] = (unsigned char)(p[i] + q[i]);
        if (!same(&r, ref, 16)) return 95;
    }
    // On the sign-sensitive operators a mixed-signedness pair operates at the
    // result vector's element type, which is the left operand's.
    {
        u8x16 ua = {200, 201, 202, 203, 204, 205, 206, 207, 1, 2, 3, 4, 5, 6, 7, 8};
        i8x16 sq = {3, -3, 5, -5, 7, -7, 9, -9, 1, 1, 1, 1, 1, 1, 1, 1};
        u8x16 r = ua / sq;
        unsigned char ref[16];
        const unsigned char *p = (const unsigned char *)&ua;
        const unsigned char *q = (const unsigned char *)&sq;
        for (int i = 0; i < 16; i++) ref[i] = (unsigned char)(p[i] / q[i]);
        if (!same(&r, ref, 16)) return 103;
        i8x16 r2 = (i8x16)ua / (i8x16)sq;
        signed char ref2[16];
        const signed char *sp = (const signed char *)&ua;
        const signed char *sqp = (const signed char *)&sq;
        for (int i = 0; i < 16; i++) ref2[i] = (signed char)(sp[i] / sqp[i]);
        if (!same(&r2, ref2, 16)) return 104;
    }

    return 0;
}
