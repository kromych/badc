// GCC vector extension over floating element types: `+ - * /` and unary `-`,
// element-wise, with a scalar operand broadcast to every lane. `%` and the
// bitwise and shift operators are not defined on a floating vector and are
// rejected (checked in the parser tests).
//
// Each result is checked against a scalar loop over the lanes at the element
// type. Lane values are exact in binary floating point, so the comparison is
// exact; the signed zero produced by `-0.0` pins that unary `-` negates rather
// than subtracting from zero.

typedef __attribute__((vector_size(16))) float f32x4;
typedef __attribute__((vector_size(16))) double f64x2;
typedef __attribute__((vector_size(32))) float f32x8;

static int same(const void *a, const void *b, int n) {
    const unsigned char *p = (const unsigned char *)a;
    const unsigned char *q = (const unsigned char *)b;
    for (int i = 0; i < n; i++) {
        if (p[i] != q[i]) return 0;
    }
    return 1;
}

#define CHECK(vty, ety, lanes, va, vb, op, code)                                                   \
    do {                                                                                           \
        vty vr = (va)op(vb);                                                                        \
        ety ref[lanes];                                                                            \
        const ety *pa = (const ety *)&(va);                                                        \
        const ety *pb = (const ety *)&(vb);                                                        \
        for (int i = 0; i < (lanes); i++) ref[i] = (ety)(pa[i] op pb[i]);                          \
        if (!same(&vr, ref, (int)sizeof(vr))) return (code);                                       \
    } while (0)

#define CHECK_BC(vty, ety, lanes, va, s, op, code)                                                 \
    do {                                                                                           \
        vty vr = (va)op(s);                                                                         \
        ety ref[lanes];                                                                            \
        const ety *pa = (const ety *)&(va);                                                        \
        for (int i = 0; i < (lanes); i++) ref[i] = (ety)(pa[i] op(ety)(s));                        \
        if (!same(&vr, ref, (int)sizeof(vr))) return (code);                                       \
    } while (0)

#define CHECK_CA(vty, va, vb, op, code)                                                            \
    do {                                                                                           \
        vty want = (va)op(vb);                                                                      \
        vty got = (va);                                                                            \
        got op## = (vb);                                                                           \
        if (!same(&got, &want, (int)sizeof(got))) return (code);                                   \
    } while (0)

int main(void) {
    f32x4 fa = {1.5f, -2.25f, 3.75f, 0.0f};
    f32x4 fb = {0.5f, 4.0f, -1.5f, 2.0f};
    f64x2 da = {1.5, -2.25};
    f64x2 db = {0.5, 4.0};
    f32x8 wa = {1.0f, 2.0f, 4.0f, 8.0f, 16.0f, 32.0f, 64.0f, 128.0f};
    f32x8 wb = {0.5f, 0.25f, 2.0f, 4.0f, 0.125f, 8.0f, 16.0f, 0.0625f};

    CHECK(f32x4, float, 4, fa, fb, +, 1);
    CHECK(f32x4, float, 4, fa, fb, -, 2);
    CHECK(f32x4, float, 4, fa, fb, *, 3);
    CHECK(f32x4, float, 4, fa, fb, /, 4);
    CHECK(f64x2, double, 2, da, db, +, 5);
    CHECK(f64x2, double, 2, da, db, -, 6);
    CHECK(f64x2, double, 2, da, db, *, 7);
    CHECK(f64x2, double, 2, da, db, /, 8);
    CHECK(f32x8, float, 8, wa, wb, +, 9);
    CHECK(f32x8, float, 8, wa, wb, *, 10);

    // A scalar broadcast converts to the lane type: an `int` scalar becomes a
    // float, and a `double` literal rounds to `float` for a float lane.
    CHECK_BC(f32x4, float, 4, fa, 2.5f, *, 11);
    CHECK_BC(f32x4, float, 4, fa, 3, *, 12);
    CHECK_BC(f64x2, double, 2, da, 4.0, /, 13);
    CHECK_BC(f64x2, double, 2, da, 3, +, 14);

    CHECK_CA(f32x4, fa, fb, *, 15);
    CHECK_CA(f32x4, fa, fb, +, 16);
    CHECK_CA(f64x2, da, db, /, 17);
    {
        f32x4 w = fa;
        w *= 2.0f;
        f32x4 want = fa * 2.0f;
        if (!same(&w, &want, 16)) return 18;
    }

    // Unary `-` flips the sign bit; the `0.0f` lane must become `-0.0f`, which
    // `0.0f - 0.0f` would not produce.
    {
        f32x4 r = -fa;
        float ref[4];
        const float *p = (const float *)&fa;
        for (int i = 0; i < 4; i++) ref[i] = -p[i];
        if (!same(&r, ref, 16)) return 19;
        const unsigned char *q = (const unsigned char *)&r;
        if (q[15] != 0x80) return 20; // lane 3 is -0.0f
    }
    {
        f64x2 r = -da;
        double ref[2];
        const double *p = (const double *)&da;
        for (int i = 0; i < 2; i++) ref[i] = -p[i];
        if (!same(&r, ref, 16)) return 21;
    }

    // Chained expressions keep the vector type across operators.
    {
        f32x4 r = (fa + fb) * 2.0f - fa;
        float ref[4];
        const float *p = (const float *)&fa;
        const float *q = (const float *)&fb;
        for (int i = 0; i < 4; i++) ref[i] = (p[i] + q[i]) * 2.0f - p[i];
        if (!same(&r, ref, 16)) return 22;
    }

    return 0;
}
