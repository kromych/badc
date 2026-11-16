/* The ACLE SVE arithmetic intrinsics past svadd, svsub and svmul over
 * arrays whose length is no multiple of the vector length: svdiv, svmin,
 * svmax, svminnm, svmaxnm and svbic in the merging, zeroing and don't-care
 * forms and with a scalar operand, and svnot, svabs and svneg in the three
 * forms, each checked against the same computation in scalar C. A zero
 * divisor gives zero and the signed minimum over -1 itself, as SDIV does.
 * The exit status is the vector length in 128-bit granules. */
#include <arm_sve.h>

#define N 77

static int32_t a32[N], b32[N], r32[N];
static uint64_t a64[N], b64[N], r64[N];
static int8_t a8[N], b8[N], r8[N];
static uint16_t a16[N], b16[N], r16[N];
static float af[N], bf[N], rf[N];
static double ad[N], bd[N], rd[N];

static void fill(void) {
    for (int i = 0; i < N; i++) {
        a32[i] = (int32_t)((uint32_t)i * 2654435761u);
        b32[i] = i % 7 == 0 ? 0 : i % 5 == 0 ? -1 : (int32_t)(i * 37 % 211) - 100;
        a64[i] = (uint64_t)i * 0x9E3779B97F4A7C15ull;
        b64[i] = i % 6 == 0 ? 0 : a64[i] >> (i % 50) ^ (uint64_t)i;
        a8[i] = (int8_t)((i * 37) % 256 - 128);
        b8[i] = (int8_t)((i * 11 + 5) % 256 - 128);
        a16[i] = (uint16_t)(i * 1300u);
        b16[i] = (uint16_t)(60000u - (unsigned)i * i * 7u);
        af[i] = (float)i * 0.5f - 11.0f;
        bf[i] = i % 9 == 0 ? 0.0f : 7.25f - (float)i * 0.25f;
        ad[i] = (double)i * 1.25 - 40.0;
        bd[i] = i % 8 == 0 ? 0.0 : 3.0 - (double)i * 0.5;
    }
    a32[3] = INT32_MIN;
    b32[3] = -1;
}

static int32_t sdiv32(int32_t x, int32_t y) {
    if (y == 0)
        return 0;
    if (x == INT32_MIN && y == -1)
        return x;
    return x / y;
}

/* The word lanes, governed by the odd lanes of b: the merging forms keep
 * a, or the inactive operand b of a unary one, the zeroing forms zero. */
static int words(void) {
    for (int op = 0; op < 12; op++) {
        for (int i = 0; i < N; i += (int)svcntw()) {
            svbool_t pg = svwhilelt_b32(i, N);
            svint32_t a = svld1(pg, &a32[i]), b = svld1_s32(pg, &b32[i]);
            svbool_t odd = svcmpne_n_s32(pg, svand_n_s32_x(pg, b, 1), 0);
            svint32_t r;
            switch (op) {
            case 0: r = svdiv_s32_m(odd, a, b); break;
            case 1: r = svdiv_z(odd, a, b); break;
            case 2: r = svdiv_x(pg, a, b); break;
            case 3: r = svdiv_n_s32_m(odd, a, -3); break;
            case 4: r = svmin_z(odd, a, b); break;
            case 5: r = svmax_x(pg, a, b); break;
            case 6: r = svmin_n_s32_m(odd, a, 17); break;
            case 7: r = svbic_m(odd, a, b); break;
            case 8: r = svbic_n_s32_z(odd, a, 0x00FF00FF); break;
            case 9: r = svnot_s32_m(b, odd, a); break;
            case 10: r = svabs_z(odd, a); break;
            default: r = svneg_m(b, odd, a); break;
            }
            svst1(pg, &r32[i], r);
        }
        for (int i = 0; i < N; i++) {
            int32_t a = a32[i], b = b32[i], want;
            int on = (b & 1) != 0;
            uint32_t ua = (uint32_t)a;
            switch (op) {
            case 0: want = on ? sdiv32(a, b) : a; break;
            case 1: want = on ? sdiv32(a, b) : 0; break;
            case 2: want = sdiv32(a, b); break;
            case 3: want = on ? sdiv32(a, -3) : a; break;
            case 4: want = on ? (a < b ? a : b) : 0; break;
            case 5: want = a > b ? a : b; break;
            case 6: want = on ? (a < 17 ? a : 17) : a; break;
            case 7: want = on ? a & ~b : a; break;
            case 8: want = on ? a & ~0x00FF00FF : 0; break;
            case 9: want = on ? ~a : b; break;
            case 10: want = on ? (int32_t)(a < 0 ? 0u - ua : ua) : 0; break;
            default: want = on ? (int32_t)(0u - ua) : b; break;
            }
            if (r32[i] != want)
                return 10 + op;
        }
    }
    return 0;
}

/* Unsigned doublewords and halfwords, bytes signed; the don't-care forms
 * under the loop's predicate. */
static int other_widths(void) {
    for (int i = 0; i < N; i += (int)svcntd()) {
        svbool_t pg = svwhilelt_b64((uint64_t)i, (uint64_t)N);
        svuint64_t a = svld1(pg, &a64[i]), b = svld1_u64(pg, &b64[i]);
        svbool_t gt = svcmpgt(pg, a, b);
        svuint64_t q = svdiv_u64_z(gt, a, b);
        svst1(pg, &r64[i], svmax_m(gt, svnot_x(pg, q), svmin_x(pg, a, b)));
    }
    for (int i = 0; i < N; i += (int)svcnth()) {
        svbool_t pg = svwhilelt_b16(i, N);
        svuint16_t a = svld1(pg, &a16[i]), b = svld1(pg, &b16[i]);
        svbool_t lt = svcmplt(pg, a, b);
        svst1(pg, &r16[i], svbic_x(pg, svmax_n_u16_z(lt, a, 4000), svnot_u16_z(pg, b)));
    }
    for (int i = 0; i < N; i += (int)svcntb()) {
        svbool_t pg = svwhilelt_b8(i, N);
        svint8_t a = svld1(pg, &a8[i]), b = svld1(pg, &b8[i]);
        svbool_t neg = svcmplt_n_s8(pg, a, 0);
        svint8_t m = svmin_s8_x(pg, svabs_x(pg, a), svneg_s8_z(neg, b));
        svst1(pg, &r8[i], svmax_n_s8_m(neg, m, -100));
    }
    for (int i = 0; i < N; i++) {
        uint64_t x = a64[i], y = b64[i];
        uint64_t q = x > y ? (y ? x / y : 0) : 0;
        uint64_t mn = x < y ? x : y;
        uint64_t w64 = x > y ? (~q > mn ? ~q : mn) : ~q;
        if (r64[i] != w64)
            return 30;
        unsigned a = a16[i], b = b16[i];
        unsigned mx = a < b ? (a > 4000 ? a : 4000) : 0;
        if (r16[i] != (uint16_t)(mx & b))
            return 31;
        int8_t c = a8[i], d = b8[i];
        int8_t abs_c = (int8_t)(uint8_t)(c < 0 ? 0u - (unsigned)c : (unsigned)c);
        int8_t neg_d = c < 0 ? (int8_t)(uint8_t)(0u - (unsigned)d) : 0;
        int8_t m = abs_c < neg_d ? abs_c : neg_d;
        if (r8[i] != (c < 0 ? (m > -100 ? m : -100) : m))
            return 32;
    }
    return 0;
}

/* The floating forms: division, the minimum and maximum and their number
 * forms, the magnitude and the negation. */
static int floats(void) {
    for (int op = 0; op < 7; op++) {
        for (int i = 0; i < N; i += (int)svcntw()) {
            svbool_t pg = svwhilelt_b32(i, N);
            svfloat32_t a = svld1(pg, &af[i]), b = svld1_f32(pg, &bf[i]);
            svbool_t ge = svcmpge(pg, a, b);
            svfloat32_t r;
            switch (op) {
            case 0: r = svdiv_f32_m(ge, a, b); break;
            case 1: r = svdiv_n_f32_z(ge, a, 4.0f); break;
            case 2: r = svmin_x(pg, a, b); break;
            case 3: r = svmax_f32_z(ge, a, b); break;
            case 4: r = svminnm_m(ge, a, b); break;
            case 5: r = svabs_f32_m(b, ge, a); break;
            default: r = svneg_x(pg, svmaxnm_n_f32_x(pg, a, 1.5f)); break;
            }
            svst1(pg, &rf[i], r);
        }
        for (int i = 0; i < N; i++) {
            float a = af[i], b = bf[i], want;
            int on = a >= b;
            switch (op) {
            case 0: want = on ? a / b : a; break;
            case 1: want = on ? a / 4.0f : 0.0f; break;
            case 2: want = a < b ? a : b; break;
            case 3: want = on ? (a > b ? a : b) : 0.0f; break;
            case 4: want = on ? (a < b ? a : b) : a; break;
            case 5: want = on ? (a < 0 ? -a : a) : b; break;
            default: want = -(a > 1.5f ? a : 1.5f); break;
            }
            if (rf[i] != want)
                return 40 + op;
        }
    }
    for (int i = 0; i < N; i += (int)svcntd()) {
        svbool_t pg = svwhilelt_b64(i, N);
        svfloat64_t a = svld1(pg, &ad[i]), b = svld1(pg, &bd[i]);
        svbool_t lt = svcmplt(pg, a, b);
        svfloat64_t q = svdiv_x(pg, a, svmaxnm_x(pg, svabs_x(pg, b), svdup_n_f64(0.5)));
        svst1(pg, &rd[i], svneg_f64_m(q, lt, svmin_n_f64_x(pg, q, 2.0)));
    }
    for (int i = 0; i < N; i++) {
        double a = ad[i], b = bd[i];
        double m = b < 0 ? -b : b;
        double q = a / (m > 0.5 ? m : 0.5);
        if (rd[i] != (a < b ? -(q < 2.0 ? q : 2.0) : q))
            return 50;
    }
    return 0;
}

int main(void) {
    fill();
    int r = words();
    if (!r)
        r = other_widths();
    if (!r)
        r = floats();
    if (r)
        return r;
    return (int)(svcntb() / 16);
}
