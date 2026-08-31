// GCC vector extension: the equality and relational operators compare
// element-wise. The result is a vector of the same byte width whose elements
// are the signed integer type of the operands' element width, -1 in a lane
// where the relation holds and 0 where it does not. A scalar operand
// broadcasts (converting to the element type first, so the vector's element
// decides the flavour); between two integer vectors the compare runs
// unsigned when either element type is (the 6.3.1.8 common type). On a NaN
// lane every ordered compare and `==` are false and `!=` is true.
// Semantics measured against gcc 16.2 (aarch64).

typedef __attribute__((vector_size(16))) unsigned char u8x16;
typedef __attribute__((vector_size(16))) signed char i8x16;
typedef __attribute__((vector_size(16))) unsigned short u16x8;
typedef __attribute__((vector_size(16))) short i16x8;
typedef __attribute__((vector_size(16))) unsigned int u32x4;
typedef __attribute__((vector_size(16))) int i32x4;
typedef __attribute__((vector_size(16))) unsigned long long u64x2;
typedef __attribute__((vector_size(16))) long long i64x2;
typedef __attribute__((vector_size(16))) float f32x4;
typedef __attribute__((vector_size(16))) double f64x2;
typedef __attribute__((vector_size(8))) unsigned char u8x8;
typedef __attribute__((vector_size(8))) signed char i8x8;

static int same(const void *a, const void *b, int n) {
    const unsigned char *p = (const unsigned char *)a;
    const unsigned char *q = (const unsigned char *)b;
    for (int i = 0; i < n; i++) {
        if (p[i] != q[i]) return 0;
    }
    return 1;
}

// One check per operator per element type: compare the vectors, build the
// reference by looping the same operator over the lanes at the element type.
#define CHECK(rty, rety, ety, lanes, va, vb, op, code)                                             \
    do {                                                                                           \
        rty vr = (va)op(vb);                                                                       \
        rety ref[lanes];                                                                           \
        const ety *pa = (const ety *)&(va);                                                        \
        const ety *pb = (const ety *)&(vb);                                                        \
        for (int i = 0; i < (lanes); i++) ref[i] = (rety)((pa[i] op pb[i]) ? -1 : 0);              \
        if (!same(&vr, ref, (int)sizeof(vr))) return (code);                                       \
    } while (0)

// Scalar broadcast, on either side; the scalar converts to the element type.
#define CHECK_BC(rty, rety, ety, lanes, va, s, op, code)                                           \
    do {                                                                                           \
        rty vr = (va)op(s);                                                                        \
        rety ref[lanes];                                                                           \
        const ety *pa = (const ety *)&(va);                                                        \
        for (int i = 0; i < (lanes); i++) ref[i] = (rety)((pa[i] op(ety)(s)) ? -1 : 0);            \
        if (!same(&vr, ref, (int)sizeof(vr))) return (code);                                       \
    } while (0)

#define CHECK_RBC(rty, rety, ety, lanes, s, va, op, code)                                          \
    do {                                                                                           \
        rty vr = (s)op(va);                                                                        \
        rety ref[lanes];                                                                           \
        const ety *pa = (const ety *)&(va);                                                        \
        for (int i = 0; i < (lanes); i++) ref[i] = (rety)(((ety)(s)op pa[i]) ? -1 : 0);            \
        if (!same(&vr, ref, (int)sizeof(vr))) return (code);                                       \
    } while (0)

int main(void) {
    u8x16 a = {0, 1, 2, 3, 100, 127, 128, 200, 255, 5, 6, 7, 8, 9, 10, 11};
    u8x16 b = {1, 1, 3, 3, 200, 127, 127, 201, 0, 5, 7, 6, 9, 9, 11, 10};
    i8x16 sa = {0, 1, -1, 3, 100, 127, -128, -100, -1, 5, -6, 7, -8, 9, -10, 11};
    i8x16 sb = {1, 1, 3, 3, -100, 127, -127, -100, 1, 5, -6, 8, -8, 10, -10, 12};
    u16x8 ha = {0, 1, 32767, 32768, 65535, 1000, 4321, 9};
    u16x8 hb = {1, 1, 32768, 32768, 7, 1000, 65535, 3};
    i16x8 sha = {0, 1, -1, 32767, -32768, 1000, -4321, 9};
    i16x8 shb = {1, 1, 3, 32767, 7, -999, -4321, -3};
    u32x4 wa = {0, 2147483647u, 2147483648u, 4294967295u};
    u32x4 wb = {1, 2147483647u, 65537, 7};
    i32x4 swa = {0, 2147483647, -2147483647 - 1, -1};
    i32x4 swb = {1, 3, -65537, -1};
    u64x2 qa = {0, 18446744073709551615ull};
    u64x2 qb = {3, 18446744073709551615ull};
    i64x2 sqa = {-9223372036854775807LL - 1, -1};
    i64x2 sqb = {3, -1};
    u8x8 na = {5, 200, 7, 8, 9, 10, 11, 12};
    u8x8 nb = {6, 100, 7, 9, 8, 10, 12, 11};

    // The result type: same byte width, signed elements, lanes 0 / -1.
    {
        i8x16 e = a == a;
        if (sizeof(e) != 16) return 1;
        for (int i = 0; i < 16; i++) {
            if (e[i] != -1) return 2;
        }
        i8x8 n8 = na < nb;
        if (sizeof(n8) != 8 || n8[0] != -1 || n8[1] != 0) return 3;
    }

    // 1-byte lanes, unsigned then signed, every operator.
    CHECK(i8x16, signed char, unsigned char, 16, a, b, ==, 4);
    CHECK(i8x16, signed char, unsigned char, 16, a, b, !=, 5);
    CHECK(i8x16, signed char, unsigned char, 16, a, b, <, 6);
    CHECK(i8x16, signed char, unsigned char, 16, a, b, <=, 7);
    CHECK(i8x16, signed char, unsigned char, 16, a, b, >, 8);
    CHECK(i8x16, signed char, unsigned char, 16, a, b, >=, 9);
    CHECK(i8x16, signed char, signed char, 16, sa, sb, ==, 10);
    CHECK(i8x16, signed char, signed char, 16, sa, sb, !=, 11);
    CHECK(i8x16, signed char, signed char, 16, sa, sb, <, 12);
    CHECK(i8x16, signed char, signed char, 16, sa, sb, <=, 13);
    CHECK(i8x16, signed char, signed char, 16, sa, sb, >, 14);
    CHECK(i8x16, signed char, signed char, 16, sa, sb, >=, 15);

    // Wider lanes.
    CHECK(i16x8, short, unsigned short, 8, ha, hb, ==, 16);
    CHECK(i16x8, short, unsigned short, 8, ha, hb, <, 17);
    CHECK(i16x8, short, unsigned short, 8, ha, hb, >=, 18);
    CHECK(i16x8, short, short, 8, sha, shb, !=, 19);
    CHECK(i16x8, short, short, 8, sha, shb, <=, 20);
    CHECK(i16x8, short, short, 8, sha, shb, >, 21);
    CHECK(i32x4, int, unsigned int, 4, wa, wb, <, 22);
    CHECK(i32x4, int, unsigned int, 4, wa, wb, ==, 23);
    CHECK(i32x4, int, int, 4, swa, swb, <, 24);
    CHECK(i32x4, int, int, 4, swa, swb, >=, 25);
    CHECK(i32x4, int, int, 4, swa, swb, !=, 26);
    CHECK(i64x2, long long, unsigned long long, 2, qa, qb, <, 27);
    CHECK(i64x2, long long, unsigned long long, 2, qa, qb, >, 28);
    CHECK(i64x2, long long, long long, 2, sqa, sqb, <, 29);
    CHECK(i64x2, long long, long long, 2, sqa, sqb, ==, 30);

    // An 8-byte vector.
    CHECK(i8x8, signed char, unsigned char, 8, na, nb, <, 31);

    // Float lanes with a NaN: ordered compares and `==` are false there,
    // `!=` is true.
    {
        union {
            unsigned int u;
            float f;
        } nan32 = {0x7fc00000u};
        f32x4 x = {1.0f, 2.0f, 0.0f, 4.0f};
        f32x4 y = {1.0f, 1.0f, 1.0f, 4.0f};
        x[2] = nan32.f;
        CHECK(i32x4, int, float, 4, x, y, ==, 32);
        CHECK(i32x4, int, float, 4, x, y, !=, 33);
        CHECK(i32x4, int, float, 4, x, y, <, 34);
        CHECK(i32x4, int, float, 4, x, y, <=, 35);
        CHECK(i32x4, int, float, 4, x, y, >, 36);
        CHECK(i32x4, int, float, 4, x, y, >=, 37);
        // A double scalar broadcasts across a float vector.
        CHECK_BC(i32x4, int, float, 4, x, 2.0, >, 38);
    }
    {
        union {
            unsigned long long u;
            double f;
        } nan64 = {0x7ff8000000000000ull};
        f64x2 dx = {1.5, 0.0};
        f64x2 dy = {1.5, 2.5};
        dx[1] = nan64.f;
        CHECK(i64x2, long long, double, 2, dx, dy, ==, 39);
        CHECK(i64x2, long long, double, 2, dx, dy, !=, 40);
        CHECK(i64x2, long long, double, 2, dx, dy, <, 41);
    }

    // Scalar broadcast, both sides. A negative scalar against an unsigned
    // element converts to it first, so the compare stays unsigned.
    CHECK_BC(i8x16, signed char, unsigned char, 16, a, 100, >, 42);
    CHECK_BC(i8x16, signed char, unsigned char, 16, a, 3, ==, 43);
    CHECK_BC(i8x16, signed char, unsigned char, 16, a, -1, <, 44);
    CHECK_BC(i8x16, signed char, signed char, 16, sa, -5, >, 45);
    CHECK_BC(i32x4, int, int, 4, swa, 0, <, 46);
    CHECK_BC(i64x2, long long, unsigned long long, 2, qa, 5, !=, 47);
    CHECK_RBC(i8x16, signed char, unsigned char, 16, 100, a, >, 48);
    CHECK_RBC(i32x4, int, int, 4, 0, swa, <=, 49);

    // Two vectors whose elements differ only in signedness compare
    // unsigned (200 > 1 holds, 255 > 0xfe holds).
    {
        u8x16 ub = {200, 1, 3, 255};
        i8x16 sv = {1, 1, 3, -2};
        i8x16 m = ub > sv;
        if (m[0] != -1 || m[1] != 0 || m[2] != 0 || m[3] != -1) return 50;
    }

    // The mask is an ordinary integer vector: the select idiom.
    {
        i32x4 xa = {1, 5, 3, 9};
        i32x4 xb = {2, 4, 6, 8};
        i32x4 m = xa < xb;
        i32x4 mn = (m & xa) | (~m & xb);
        if (mn[0] != 1 || mn[1] != 4 || mn[2] != 3 || mn[3] != 8) return 51;
    }

    return 0;
}
