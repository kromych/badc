/* The ACLE SVE absolute differences, high products, square roots and
 * saturating sums and differences, each checked against scalar C:
 * svabd and svmulh in the merging, zeroing and don't-care forms and with
 * a scalar, over signed, unsigned and (svabd) floating lanes; svsqrt in
 * each form; svqadd and svqsub at the bounds of every lane width, with a
 * vector and with a scalar. The exit status is the vector length in
 * 128-bit granules. */
#include <arm_sve.h>

#define N 61

static int8_t a8[N], b8[N], r8[N];
static uint16_t a16[N], b16[N], r16[N];
static int32_t a32[N], b32[N], r32[N];
static uint32_t m32[N];
static uint64_t a64[N], b64[N], r64[N];
static int64_t s64[N], t64[N], q64[N];
static float f32[N], g32[N], h32[N];
static double f64[N], g64[N], h64[N];

static void fill(void) {
    for (int i = 0; i < N; i++) {
        uint32_t h = (uint32_t)i * 2654435761u;
        a8[i] = (int8_t)(h >> 7);
        b8[i] = (int8_t)(h >> 15);
        a16[i] = (uint16_t)(h >> 3);
        b16[i] = (uint16_t)(i * 4099);
        a32[i] = (int32_t)h;
        b32[i] = (int32_t)(h * 2246822519u);
        m32[i] = (uint32_t)(i % 3 != 0);
        a64[i] = (uint64_t)i * 0x9E3779B97F4A7C15ull;
        b64[i] = ~(uint64_t)i * 0xC2B2AE3D27D4EB4Full;
        s64[i] = (int64_t)a64[i];
        t64[i] = (int64_t)b64[i];
        f32[i] = (float)(i * i) * 0.25f;
        g32[i] = (float)(i % 7) - 3.5f;
        f64[i] = (double)(i * i) * 4.0;
        g64[i] = (double)(i % 5) * -1.25;
    }
    a8[1] = 127;
    b8[1] = -128;
    a8[2] = -128;
    b8[2] = 127;
    a16[3] = 0xFFFF;
    b16[3] = 1;
    a32[4] = INT32_MIN;
    b32[4] = INT32_MAX;
    s64[5] = INT64_MIN;
    t64[5] = 1;
    s64[6] = INT64_MAX;
    t64[6] = -1;
    f32[7] = 2.0f;
    f64[8] = 2.0;
}

static int64_t sat(int64_t x, int64_t lo, int64_t hi) {
    return x < lo ? lo : x > hi ? hi : x;
}

static int differences(void) {
    for (int op = 0; op < 6; op++) {
        for (int i = 0; i < N; i += (int)svcntw()) {
            svbool_t pg = svwhilelt_b32(i, N);
            svint32_t a = svld1(pg, &a32[i]), b = svld1(pg, &b32[i]);
            svbool_t on = svcmpne_n_u32(pg, svld1(pg, &m32[i]), 0);
            svint32_t r;
            switch (op) {
            case 0: r = svabd_s32_m(on, a, b); break;
            case 1: r = svabd_z(on, b, a); break;
            case 2: r = svabd_n_s32_x(pg, a, -7); break;
            case 3: r = svmulh_s32_m(on, a, b); break;
            case 4: r = svmulh_n_s32_z(on, a, 0x40000000); break;
            default: r = svmulh_x(pg, b, a); break;
            }
            svst1(pg, &r32[i], r);
        }
        for (int i = 0; i < N; i++) {
            int64_t a = a32[i], b = b32[i], d = a > b ? a - b : b - a;
            int on = m32[i] != 0;
            int64_t want;
            switch (op) {
            case 0: want = on ? d : a; break;
            case 1: want = on ? d : 0; break;
            case 2: want = a > -7 ? a + 7 : -7 - a; break;
            case 3: want = on ? (a * b) >> 32 : a; break;
            case 4: want = on ? (a * 0x40000000) >> 32 : 0; break;
            default: want = (a * b) >> 32; break;
            }
            if (r32[i] != (int32_t)(uint32_t)(uint64_t)want)
                return 10 + op;
        }
    }
    for (int i = 0; i < N; i += (int)svcntb()) {
        svbool_t pg = svwhilelt_b8(i, N);
        svint8_t a = svld1(pg, &a8[i]), b = svld1(pg, &b8[i]);
        svst1(pg, &r8[i], svmulh_x(pg, svabd_x(pg, a, b), b));
    }
    for (int i = 0; i < N; i += (int)svcnth()) {
        svbool_t pg = svwhilelt_b16(i, N);
        svuint16_t a = svld1(pg, &a16[i]), b = svld1(pg, &b16[i]);
        svst1(pg, &r16[i], svabd_u16_x(pg, svmulh_n_u16_x(pg, a, 0xFFFF), b));
    }
    for (int i = 0; i < N; i += (int)svcntd()) {
        svbool_t pg = svwhilelt_b64(i, N);
        svuint64_t a = svld1(pg, &a64[i]), b = svld1(pg, &b64[i]);
        svint64_t s = svld1(pg, &s64[i]), t = svld1(pg, &t64[i]);
        svst1(pg, &r64[i], svmulh_x(pg, a, b));
        svst1(pg, &q64[i], svmulh_x(pg, s, svabd_x(pg, s, t)));
    }
    for (int i = 0; i < N; i++) {
        int a = a8[i], b = b8[i];
        int d = (int8_t)(uint8_t)(a > b ? a - b : b - a);
        if (r8[i] != (int8_t)((d * b) >> 8))
            return 20;
        unsigned h = (unsigned)(((uint32_t)a16[i] * 0xFFFFu) >> 16);
        if (r16[i] != (uint16_t)(h > b16[i] ? h - b16[i] : b16[i] - h))
            return 21;
        unsigned __int128 p = (unsigned __int128)a64[i] * b64[i];
        if (r64[i] != (uint64_t)(p >> 64))
            return 22;
        uint64_t sd = s64[i] > t64[i] ? (uint64_t)s64[i] - (uint64_t)t64[i]
                                      : (uint64_t)t64[i] - (uint64_t)s64[i];
        __int128 q = (__int128)s64[i] * (__int128)(int64_t)sd;
        if (q64[i] != (int64_t)(q >> 64))
            return 23;
    }
    return 0;
}

static int floats(void) {
    for (int op = 0; op < 5; op++) {
        for (int i = 0; i < N; i += (int)svcntw()) {
            svbool_t pg = svwhilelt_b32(i, N);
            svfloat32_t a = svld1(pg, &f32[i]), b = svld1(pg, &g32[i]);
            svbool_t on = svcmpne_n_u32(pg, svld1(pg, &m32[i]), 0);
            svfloat32_t r;
            switch (op) {
            case 0: r = svabd_f32_m(on, a, b); break;
            case 1: r = svabd_n_f32_x(pg, b, 1.5f); break;
            case 2: r = svsqrt_f32_m(b, on, a); break;
            case 3: r = svsqrt_z(on, a); break;
            default: r = svsqrt_x(pg, a); break;
            }
            svst1(pg, &h32[i], r);
        }
        for (int i = 0; i < N; i++) {
            float a = f32[i], b = g32[i], want;
            int on = m32[i] != 0;
            float root = i == 7 ? 1.41421354f : (float)i * 0.5f;
            switch (op) {
            case 0: want = on ? (a > b ? a - b : b - a) : a; break;
            case 1: want = b > 1.5f ? b - 1.5f : 1.5f - b; break;
            case 2: want = on ? root : b; break;
            case 3: want = on ? root : 0.0f; break;
            default: want = root; break;
            }
            if (h32[i] != want)
                return 30 + op;
        }
    }
    for (int i = 0; i < N; i += (int)svcntd()) {
        svbool_t pg = svwhilelt_b64(i, N);
        svfloat64_t a = svld1(pg, &f64[i]), b = svld1(pg, &g64[i]);
        svst1(pg, &h64[i], svabd_x(pg, svsqrt_f64_x(pg, a), b));
    }
    for (int i = 0; i < N; i++) {
        double root = i == 8 ? 1.4142135623730951 : (double)i * 2.0, b = g64[i];
        if (h64[i] != (root > b ? root - b : b - root))
            return 40;
    }
    return 0;
}

/* The saturating sums and differences at every lane width. */
static int saturating(void) {
    for (int i = 0; i < N; i += (int)svcntb()) {
        svbool_t pg = svwhilelt_b8(i, N);
        svint8_t a = svld1(pg, &a8[i]), b = svld1(pg, &b8[i]);
        svst1(pg, &r8[i], svqsub(svqadd_s8(a, b), svqadd_n_s8(b, -3)));
    }
    for (int i = 0; i < N; i += (int)svcnth()) {
        svbool_t pg = svwhilelt_b16(i, N);
        svuint16_t a = svld1(pg, &a16[i]), b = svld1(pg, &b16[i]);
        svst1(pg, &r16[i], svqadd(svqsub_u16(a, b), svqadd_n_u16(b, 0x100)));
    }
    for (int i = 0; i < N; i += (int)svcntw()) {
        svbool_t pg = svwhilelt_b32(i, N);
        svint32_t a = svld1(pg, &a32[i]), b = svld1(pg, &b32[i]);
        svst1(pg, &r32[i], svqsub_n_s32(svqadd(a, b), 255));
    }
    for (int i = 0; i < N; i += (int)svcntd()) {
        svbool_t pg = svwhilelt_b64(i, N);
        svuint64_t a = svld1(pg, &a64[i]), b = svld1(pg, &b64[i]);
        svint64_t s = svld1(pg, &s64[i]), t = svld1(pg, &t64[i]);
        svst1(pg, &r64[i], svqsub_n_u64(svqadd_u64(a, b), 7));
        svst1(pg, &q64[i], svqadd(svqsub_s64(s, t), svdup_n_s64(-1)));
    }
    for (int i = 0; i < N; i++) {
        int64_t x = sat((int64_t)a8[i] + b8[i], -128, 127);
        int64_t y = sat((int64_t)b8[i] - 3, -128, 127);
        if (r8[i] != (int8_t)sat(x - y, -128, 127))
            return 50;
        int64_t u = sat((int64_t)a16[i] - b16[i], 0, 0xFFFF);
        int64_t v = sat((int64_t)b16[i] + 0x100, 0, 0xFFFF);
        if (r16[i] != (uint16_t)sat(u + v, 0, 0xFFFF))
            return 51;
        int64_t w = sat((int64_t)a32[i] + b32[i], INT32_MIN, INT32_MAX);
        if (r32[i] != (int32_t)sat(w - 255, INT32_MIN, INT32_MAX))
            return 52;
        uint64_t s = a64[i] + b64[i] < a64[i] ? UINT64_MAX : a64[i] + b64[i];
        if (r64[i] != (s < 7 ? 0 : s - 7))
            return 53;
        __int128 d = (__int128)s64[i] - t64[i];
        d = d > INT64_MAX ? INT64_MAX : d < INT64_MIN ? INT64_MIN : d;
        d -= 1;
        if (q64[i] != (int64_t)(d < INT64_MIN ? INT64_MIN : d))
            return 54;
    }
    return 0;
}

int main(void) {
    fill();
    int r = differences();
    if (!r)
        r = floats();
    if (!r)
        r = saturating();
    if (r)
        return r;
    return (int)(svcntb() / 16);
}
