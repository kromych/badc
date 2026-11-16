/* The first ACLE SVE intrinsics over arrays whose length is no multiple of
 * the vector length: svwhilelt loops with svcnt* steps, svld1 and svst1,
 * svadd, svsub and svmul in the merging, zeroing and don't-care forms and
 * with a scalar operand, the compares, svaddv and svptrue, each checked
 * against the same computation in scalar C. The exit status is the vector
 * length in 128-bit granules. */
#include <arm_sve.h>

#define N 77

static int32_t a32[N], b32[N], r32[N];
static uint8_t a8[N], b8[N], r8[N];
static int64_t a64[N], r64[N];
static uint16_t a16[N];
static float af[N], bf[N], rf[N];
static double ad[N], rd[N];

static void fill(void) {
    for (int i = 0; i < N; i++) {
        a32[i] = i * 37 - 1000;
        b32[i] = 500 - i * i;
        a8[i] = (uint8_t)(i * 13 + 7);
        b8[i] = (uint8_t)(255 - i * 5);
        a64[i] = (int64_t)i * 1000000007LL - 30000000000LL;
        a16[i] = (uint16_t)(i * 997);
        af[i] = (float)i * 0.75f - 20.0f;
        bf[i] = 3.5f - (float)i * 0.25f;
        ad[i] = (double)i * 1.5 - 33.0;
    }
}

/* r = a + b, a - b, a * b by the predication forms: the merging form
 * keeps a where b is negative (an inactive lane), the zeroing form
 * zeroes it. */
static int vectors32(void) {
    for (int op = 0; op < 9; op++) {
        for (int i = 0; i < N; i += (int)svcntw()) {
            svbool_t pg = svwhilelt_b32(i, N);
            svint32_t a = svld1(pg, &a32[i]);
            svint32_t b = svld1_s32(pg, &b32[i]);
            svbool_t pos = svcmpge(pg, b, 0);
            svint32_t r;
            switch (op) {
            case 0: r = svadd_s32_m(pos, a, b); break;
            case 1: r = svadd_z(pos, a, b); break;
            case 2: r = svadd_x(pg, a, b); break;
            case 3: r = svsub_m(pos, a, b); break;
            case 4: r = svsub_s32_z(pos, a, b); break;
            case 5: r = svsub_n_s32_x(pg, a, 9); break;
            case 6: r = svmul_m(pos, a, b); break;
            case 7: r = svmul_z(pos, a, b); break;
            default: r = svmul_x(pg, a, svdup_n_s32(-3)); break;
            }
            svst1(pg, &r32[i], r);
        }
        for (int i = 0; i < N; i++) {
            int32_t a = a32[i], b = b32[i], want;
            int on = b >= 0;
            switch (op) {
            case 0: want = on ? a + b : a; break;
            case 1: want = on ? a + b : 0; break;
            case 2: want = a + b; break;
            case 3: want = on ? a - b : a; break;
            case 4: want = on ? a - b : 0; break;
            case 5: want = a - 9; break;
            case 6: want = on ? a * b : a; break;
            case 7: want = on ? a * b : 0; break;
            default: want = a * -3; break;
            }
            if (r32[i] != want)
                return 10 + op;
        }
    }
    return 0;
}

/* Byte and doubleword lanes: an unsigned compare, the sums. */
static int other_widths(void) {
    uint64_t sum8 = 0, want8 = 0;
    int64_t sum64 = 0, want64 = 0;
    for (int i = 0; i < N; i += (int)svcntb()) {
        svbool_t pg = svwhilelt_b8_s32(i, N);
        svuint8_t a = svld1_u8(pg, &a8[i]);
        svuint8_t b = svld1_u8(pg, &b8[i]);
        svbool_t gt = svcmpgt(pg, a, b);
        svst1_u8(pg, &r8[i], svadd_u8_m(gt, a, b));
        sum8 += svaddv(pg, a);
    }
    for (int i = 0; i < N; i += (int)svcntd()) {
        svbool_t pg = svwhilelt_b64((int64_t)i, (int64_t)N);
        svint64_t a = svld1_s64(pg, &a64[i]);
        svbool_t lt = svcmplt_n_s64(pg, a, 0);
        svst1(pg, &r64[i], svmul_n_s64_m(lt, a, 2));
        sum64 += svaddv_s64(svcmpne_n_s64(pg, a, a64[0]), a);
    }
    for (int i = 0; i < N; i++) {
        uint8_t want = a8[i] > b8[i] ? (uint8_t)(a8[i] + b8[i]) : a8[i];
        if (r8[i] != want)
            return 30;
        if (r64[i] != (a64[i] < 0 ? a64[i] * 2 : a64[i]))
            return 31;
        want8 += a8[i];
        want64 += i ? a64[i] : 0;
    }
    if (sum8 != want8 || sum64 != want64)
        return 32;
    /* Unsigned 16-bit lanes counted by compares: equal, not equal. */
    uint64_t eq = 0, ne = 0;
    for (int i = 0; i < N; i += (int)svcnth()) {
        svbool_t pg = svwhilelt_b16((uint32_t)i, (uint32_t)N);
        svuint16_t a = svld1(pg, &a16[i]);
        svbool_t e = svcmpeq(pg, a, a16[0]);
        eq += svaddv(e, svdup_n_u16(1));
        ne += svaddv(svcmpne(pg, a, a16[0]), svdup_u16(1));
    }
    if (eq != 1 || ne != N - 1)
        return 33;
    return 0;
}

/* Floating lanes: the arithmetic forms, the compares and an exact sum. */
static int floats(void) {
    for (int i = 0; i < N; i += (int)svcntw()) {
        svbool_t pg = svwhilelt_b32(i, N);
        svfloat32_t a = svld1(pg, &af[i]);
        svfloat32_t b = svld1_f32(pg, &bf[i]);
        svbool_t le = svcmple(pg, a, b);
        svfloat32_t r = svadd_f32_m(le, svmul_x(pg, a, b), svsub_n_f32_x(pg, b, 1.0f));
        svst1(pg, &rf[i], r);
    }
    double sum = 0, want = 0;
    for (int i = 0; i < N; i += (int)svcntd()) {
        svbool_t pg = svwhilelt_b64(i, N);
        svfloat64_t a = svld1_f64(pg, &ad[i]);
        svst1(pg, &rd[i], svmul_n_f64_z(svcmpgt_n_f64(pg, a, 0.0), a, 2.0));
        sum += svaddv(pg, a);
    }
    for (int i = 0; i < N; i++) {
        float p = af[i] * bf[i];
        float w = af[i] <= bf[i] ? p + (bf[i] - 1.0f) : p;
        if (rf[i] != w)
            return 40;
        if (rd[i] != (ad[i] > 0.0 ? ad[i] * 2.0 : 0.0))
            return 41;
        want += ad[i];
    }
    if (sum != want)
        return 42;
    return 0;
}

int main(void) {
    fill();
    int r = vectors32();
    if (!r)
        r = other_widths();
    if (!r)
        r = floats();
    if (r)
        return r;
    /* The lanes svptrue_pat selects, counted by svaddv. */
    if (svaddv(svptrue_pat_b32(SV_VL3), svdup_n_s32(1)) != 3)
        return 50;
    if (svcntw_pat(SV_ALL) != svcntw() || svcntb() != 4 * svcntw())
        return 51;
    return (int)(svcntb() / 16);
}
