/* The ACLE SVE rows with a constant operand, each checked against scalar
 * C: svdup_n of constants DUP, FDUP and DUPM encode and of others; the
 * integer _x arithmetic, minimum, maximum and bitwise rows, the shifts and
 * the floating arithmetic at the edges of their immediates' ranges and
 * past them; the compares with a constant second or first operand; and
 * svdup_lane at constant indices within DUP's reach, past it and past the
 * vector. A constant one row reads as an immediate and another as a
 * register, and one live across a call, are read right. The exit status
 * is the vector length in 128-bit granules. */
#include <arm_sve.h>

#define N 53

static int8_t s8[N], r8[N];
static uint8_t u8[N], q8[N], m8[N];
static int16_t s16[N], r16[N];
static int32_t s32[N], r32[N];
static uint32_t u32[N], q32[N], m32[N];
static int64_t s64[N], r64[N];
static uint64_t u64[N], q64[N], m64[N];
static float f32[N], g32[N];
static double f64[N], g64[N];

static volatile int touched;
static void touch(void) { touched++; }
static void (*volatile hook)(void) = touch;

static void fill(void) {
    static const float fs[] = {0.0f, -0.0f, 1.0f, -1.5f, 0.25f, 3e9f, -7e-5f, 0.5f, 2.0f};
    for (int i = 0; i < N; i++) {
        uint32_t h = (uint32_t)i * 2654435761u;
        s8[i] = (int8_t)(h >> 9);
        u8[i] = (uint8_t)(i * 37 + 3);
        m8[i] = (uint8_t)(i % 3 == 1);
        s16[i] = (int16_t)(i * 1297 - 32000);
        s32[i] = (int32_t)h;
        u32[i] = h ^ 0x5A5A5A5Au;
        m32[i] = (uint32_t)(i & 1);
        s64[i] = (int64_t)((uint64_t)i * 0x9E3779B97F4A7C15ull);
        u64[i] = (uint64_t)i * 0xD1B54A32D192ED03ull;
        m64[i] = (uint64_t)(i % 4 != 0);
        f32[i] = fs[i % 9] * (float)(1 + i / 9);
        f64[i] = (double)fs[(i + 4) % 9] * (double)(1 + i / 9);
    }
    s32[3] = -16;
    s32[4] = 15;
    s32[5] = 16;
    u8[6] = 127;
    u8[7] = 128;
    u8[8] = 0;
}

static uint32_t bits32(float x) {
    union { float f; uint32_t u; } v = {x};
    return v.u;
}

static uint64_t bits64(double x) {
    union { double f; uint64_t u; } v = {x};
    return v.u;
}

static int64_t asr(int64_t x, uint64_t n, uint64_t width) {
    if (n >= width)
        n = width - 1;
    return x < 0 ? ~(~x >> n) : x >> n;
}

/* FMAX and FMIN order -0.0 below +0.0. */
static double fmax_ref(double a, double b) {
    if (a == b)
        return bits64(a) == 0 ? a : b;
    return a > b ? a : b;
}

static double fmin_ref(double a, double b) {
    if (a == b)
        return bits64(a) != 0 ? a : b;
    return a < b ? a : b;
}

#define DUP(code, T, sv, b, cnt, c, same)                            \
    do {                                                             \
        static T out[256 / sizeof(T)];                               \
        svst1(svptrue_##b(), out, sv(c));                            \
        for (int i = 0; i < (int)cnt(); i++)                         \
            if (!same(out[i], (T)(c)))                               \
                return code;                                         \
    } while (0)

#define EQ(a, b) ((a) == (b))
#define SAME32(a, b) (bits32(a) == bits32(b))
#define SAME64(a, b) (bits64(a) == bits64(b))

static int dups(void) {
    DUP(1, int32_t, svdup_n_s32, b32, svcntw, 3, EQ);
    DUP(2, int32_t, svdup_n_s32, b32, svcntw, 0x1200, EQ);
    DUP(3, int16_t, svdup_n_s16, b16, svcnth, -32768, EQ);
    DUP(4, int8_t, svdup_n_s8, b8, svcntb, -128, EQ);
    DUP(5, uint64_t, svdup_n_u64, b64, svcntd, 0x00FF00FF00FF00FFull, EQ);
    DUP(6, uint32_t, svdup_n_u32, b32, svcntw, 0x12345678u, EQ);
    DUP(7, uint16_t, svdup_n_u16, b16, svcnth, 0xFF00u, EQ);
    DUP(8, float, svdup_n_f32, b32, svcntw, 1.0f, SAME32);
    DUP(9, float, svdup_n_f32, b32, svcntw, -2.5f, SAME32);
    DUP(10, float, svdup_n_f32, b32, svcntw, 0.0f, SAME32);
    DUP(11, float, svdup_n_f32, b32, svcntw, -0.0f, SAME32);
    DUP(12, double, svdup_n_f64, b64, svcntd, 0.1, SAME64);
    DUP(13, double, svdup_n_f64, b64, svcntd, -0.0, SAME64);
    DUP(14, double, svdup_n_f64, b64, svcntd, 31.0, SAME64);
    return 0;
}

/* Word lanes: the _x immediates at their range's edges and past them, the
 * shifts in each form, and the _m and _z forms with a constant. */
static int words(void) {
    for (int op = 0; op < 20; op++) {
        for (int i = 0; i < N; i += (int)svcntw()) {
            svbool_t pg = svwhilelt_b32(i, N);
            svint32_t a = svld1(pg, &s32[i]);
            svbool_t odd = svcmpne_n_u32(pg, svld1(pg, &m32[i]), 0);
            svint32_t r;
            switch (op) {
            case 0: r = svadd_n_s32_x(pg, a, 255); break;
            case 1: r = svadd_n_s32_x(pg, a, -256); break;
            case 2: r = svsub_n_s32_x(pg, a, 0x7F00); break;
            case 3: r = svsub_n_s32_x(pg, a, 0x10000); break;
            case 4: r = svmul_n_s32_x(pg, a, -128); break;
            case 5: r = svmul_n_s32_x(pg, a, 128); break;
            case 6: r = svmin_n_s32_x(pg, a, 127); break;
            case 7: r = svmax_n_s32_x(pg, a, -128); break;
            case 8: r = svand_n_s32_x(pg, a, 0x00FF00FF); break;
            case 9: r = svorr_n_s32_x(pg, a, (int32_t)0x80000001u); break;
            case 10: r = sveor_n_s32_x(pg, a, 0x12345); break;
            case 11: r = svbic_n_s32_x(pg, a, 0xFF); break;
            case 12: r = svlsl_n_s32_x(pg, a, 31); break;
            case 13: r = svasr_n_s32_m(odd, a, 32); break;
            case 14: r = svlsl_n_s32_z(odd, a, 32); break;
            case 15: r = svasr_n_s32_x(pg, a, 0); break;
            case 16: r = svadd_n_s32_m(odd, a, 7); break;
            case 17: r = svmin_n_s32_z(odd, a, 5); break;
            case 18: r = svasr_n_s32_z(odd, a, 3); break;
            default: r = svlsl_n_s32_m(odd, a, 1); break;
            }
            svst1(pg, &r32[i], r);
        }
        for (int i = 0; i < N; i++) {
            int32_t a = s32[i], want;
            uint32_t ua = (uint32_t)a;
            int on = m32[i] != 0;
            switch (op) {
            case 0: want = (int32_t)(ua + 255u); break;
            case 1: want = (int32_t)(ua - 256u); break;
            case 2: want = (int32_t)(ua - 0x7F00u); break;
            case 3: want = (int32_t)(ua - 0x10000u); break;
            case 4: want = (int32_t)(ua * (uint32_t)-128); break;
            case 5: want = (int32_t)(ua * 128u); break;
            case 6: want = a < 127 ? a : 127; break;
            case 7: want = a > -128 ? a : -128; break;
            case 8: want = (int32_t)(ua & 0x00FF00FFu); break;
            case 9: want = (int32_t)(ua | 0x80000001u); break;
            case 10: want = (int32_t)(ua ^ 0x12345u); break;
            case 11: want = (int32_t)(ua & ~0xFFu); break;
            case 12: want = (int32_t)(ua << 31); break;
            case 13: want = on ? (int32_t)asr(a, 32, 32) : a; break;
            case 14: want = 0; break;
            case 15: want = a; break;
            case 16: want = on ? (int32_t)(ua + 7u) : a; break;
            case 17: want = on ? (a < 5 ? a : 5) : 0; break;
            case 18: want = on ? (int32_t)asr(a, 3, 32) : 0; break;
            default: want = on ? (int32_t)(ua << 1) : a; break;
            }
            if (r32[i] != want)
                return 20 + op;
        }
    }
    return 0;
}

/* Byte, halfword and doubleword lanes, signed and unsigned. */
static int other_widths(void) {
    for (int op = 0; op < 8; op++) {
        for (int i = 0; i < N; i += (int)svcntb()) {
            svbool_t pg = svwhilelt_b8(i, N);
            svint8_t a = svld1(pg, &s8[i]);
            svuint8_t u = svld1(pg, &u8[i]);
            svbool_t on = svcmpne_n_u8(pg, svld1(pg, &m8[i]), 0);
            svint8_t r;
            svuint8_t q;
            switch (op) {
            case 0: r = svadd_n_s8_x(pg, a, -1); q = svmax_n_u8_x(pg, u, 255); break;
            case 1: r = svsub_n_s8_x(pg, a, -128); q = svmin_n_u8_x(pg, u, 0); break;
            case 2: r = svmin_n_s8_x(pg, a, -128); q = svlsr_n_u8_x(pg, u, 7); break;
            case 3: r = svlsl_n_s8_x(pg, a, 8); q = svlsr_n_u8_m(on, u, 8); break;
            case 4: r = svasr_n_s8_z(on, a, 200); q = svlsl_n_u8_z(on, u, 7); break;
            case 5: r = svmul_n_s8_x(pg, a, 127); q = svand_n_u8_x(pg, u, 0x3C); break;
            case 6: r = sveor_n_s8_x(pg, a, -1); q = svorr_n_u8_x(pg, u, 0x81); break;
            default: r = svmax_n_s8_m(on, a, 3); q = svmul_n_u8_x(pg, u, 200); break;
            }
            svst1(pg, &r8[i], r);
            svst1(pg, &q8[i], q);
        }
        for (int i = 0; i < N; i++) {
            int a = s8[i];
            unsigned u = u8[i];
            int on = m8[i] != 0;
            int r;
            unsigned q;
            switch (op) {
            case 0: r = a - 1; q = 255; break;
            case 1: r = a + 128; q = 0; break;
            case 2: r = -128; q = u >> 7; break;
            case 3: r = 0; q = on ? 0 : u; break;
            case 4: r = on ? (int)asr(a, 200, 8) : 0; q = on ? u << 7 : 0; break;
            case 5: r = a * 127; q = u & 0x3C; break;
            case 6: r = ~a; q = u | 0x81; break;
            default: r = on ? (a > 3 ? a : 3) : a; q = u * 200; break;
            }
            if (r8[i] != (int8_t)(uint8_t)r || q8[i] != (uint8_t)q)
                return 40 + op;
        }
    }
    for (int op = 0; op < 4; op++) {
        for (int i = 0; i < N; i += (int)svcnth()) {
            svbool_t pg = svwhilelt_b16(i, N);
            svint16_t a = svld1(pg, &s16[i]);
            svint16_t r;
            switch (op) {
            case 0: r = svadd_n_s16_x(pg, a, -256); break;
            case 1: r = svsub_n_s16_x(pg, a, 0x100); break;
            case 2: r = svasr_n_s16_x(pg, a, 16); break;
            default: r = svand_n_s16_x(pg, a, 0x7FFE); break;
            }
            svst1(pg, &r16[i], r);
        }
        for (int i = 0; i < N; i++) {
            int a = s16[i], r;
            switch (op) {
            case 0: r = a - 256; break;
            case 1: r = a - 0x100; break;
            case 2: r = a < 0 ? -1 : 0; break;
            default: r = a & 0x7FFE; break;
            }
            if (r16[i] != (int16_t)(uint16_t)r)
                return 50 + op;
        }
    }
    for (int op = 0; op < 6; op++) {
        for (int i = 0; i < N; i += (int)svcntd()) {
            svbool_t pg = svwhilelt_b64(i, N);
            svint64_t a = svld1(pg, &s64[i]);
            svuint64_t u = svld1(pg, &u64[i]);
            svbool_t on = svcmpne_n_u64(pg, svld1(pg, &m64[i]), 0);
            svint64_t r;
            svuint64_t q;
            switch (op) {
            case 0: r = svmul_n_s64_x(pg, a, -3); q = svlsr_n_u64_x(pg, u, 63); break;
            case 1: r = svand_n_s64_x(pg, a, (int64_t)0xFFFFFFFF00000000ull); q = svlsr_n_u64_z(on, u, 64); break;
            case 2: r = svasr_n_s64_m(on, a, 70); q = svlsl_n_u64_m(on, u, 63); break;
            case 3: r = svsub_n_s64_x(pg, a, -0xFF00); q = svmax_n_u64_x(pg, u, 200); break;
            case 4: r = svbic_n_s64_x(pg, a, 0x1); q = svmin_n_u64_x(pg, u, 0x8000000000000000ull); break;
            default: r = svadd_n_s64_x(pg, a, 0x100000000ll); q = sveor_n_u64_x(pg, u, 0x5555555555555555ull); break;
            }
            svst1(pg, &r64[i], r);
            svst1(pg, &q64[i], q);
        }
        for (int i = 0; i < N; i++) {
            uint64_t a = (uint64_t)s64[i], u = u64[i], r, q;
            int on = m64[i] != 0;
            switch (op) {
            case 0: r = a * (uint64_t)-3; q = u >> 63; break;
            case 1: r = a & 0xFFFFFFFF00000000ull; q = 0; break;
            case 2: r = on ? (uint64_t)asr((int64_t)a, 70, 64) : a; q = on ? u << 63 : u; break;
            case 3: r = a + 0xFF00; q = u > 200 ? u : 200; break;
            case 4: r = a & ~1ull; q = u < 0x8000000000000000ull ? u : 0x8000000000000000ull; break;
            default: r = a + 0x100000000ull; q = u ^ 0x5555555555555555ull; break;
            }
            if ((uint64_t)r64[i] != r || q64[i] != q)
                return 60 + op;
        }
    }
    return 0;
}

/* The floating rows with the constants their immediates name and others. */
static int floats(void) {
    for (int op = 0; op < 12; op++) {
        for (int i = 0; i < N; i += (int)svcntw()) {
            svbool_t pg = svwhilelt_b32(i, N);
            svfloat32_t a = svld1(pg, &f32[i]);
            svbool_t odd = svcmpne_n_u32(pg, svld1(pg, &m32[i]), 0);
            svfloat32_t r;
            switch (op) {
            case 0: r = svadd_n_f32_m(odd, a, 0.5f); break;
            case 1: r = svadd_n_f32_x(pg, a, 1.0f); break;
            case 2: r = svadd_n_f32_x(pg, a, 1.5f); break;
            case 3: r = svsub_n_f32_z(odd, a, 1.0f); break;
            case 4: r = svsub_n_f32_m(odd, a, 0.5f); break;
            case 5: r = svmul_n_f32_x(pg, a, 2.0f); break;
            case 6: r = svmul_n_f32_m(odd, a, 0.5f); break;
            case 7: r = svmul_n_f32_z(odd, a, 3.0f); break;
            case 8: r = svmax_n_f32_m(odd, a, 0.0f); break;
            case 9: r = svmax_n_f32_x(pg, a, -0.0f); break;
            case 10: r = svmin_n_f32_z(odd, a, 1.0f); break;
            default: r = svmaxnm_n_f32_x(pg, a, 0.0f); break;
            }
            svst1(pg, &g32[i], r);
        }
        for (int i = 0; i < N; i++) {
            float a = f32[i], want;
            int on = m32[i] != 0;
            switch (op) {
            case 0: want = on ? a + 0.5f : a; break;
            case 1: want = a + 1.0f; break;
            case 2: want = a + 1.5f; break;
            case 3: want = on ? a - 1.0f : 0.0f; break;
            case 4: want = on ? a - 0.5f : a; break;
            case 5: want = a * 2.0f; break;
            case 6: want = on ? a * 0.5f : a; break;
            case 7: want = on ? a * 3.0f : 0.0f; break;
            case 8: want = on ? (float)fmax_ref(a, 0.0) : a; break;
            case 9: want = (float)fmax_ref(a, -0.0); break;
            case 10: want = on ? (float)fmin_ref(a, 1.0) : 0.0f; break;
            default: want = (float)fmax_ref(a, 0.0); break;
            }
            if (bits32(g32[i]) != bits32(want))
                return 70 + op;
        }
    }
    for (int op = 0; op < 4; op++) {
        for (int i = 0; i < N; i += (int)svcntd()) {
            svbool_t pg = svwhilelt_b64(i, N);
            svfloat64_t a = svld1(pg, &f64[i]);
            svbool_t on = svcmpne_n_u64(pg, svld1(pg, &m64[i]), 0);
            svfloat64_t r;
            switch (op) {
            case 0: r = svminnm_n_f64_m(on, a, 1.0); break;
            case 1: r = svsub_n_f64_x(pg, a, 1.0); break;
            case 2: r = svmin_n_f64_x(pg, a, 0.0); break;
            default: r = svmul_n_f64_z(on, a, 2.0); break;
            }
            svst1(pg, &g64[i], r);
        }
        for (int i = 0; i < N; i++) {
            double a = f64[i], want;
            int on = m64[i] != 0;
            switch (op) {
            case 0: want = on ? fmin_ref(a, 1.0) : a; break;
            case 1: want = a - 1.0; break;
            case 2: want = fmin_ref(a, 0.0); break;
            default: want = on ? a * 2.0 : 0.0; break;
            }
            if (bits64(g64[i]) != bits64(want))
                return 80 + op;
        }
    }
    return 0;
}

/* The compares, the constant second or, swapping the relation, first. */
static int compares(void) {
    for (int op = 0; op < 8; op++) {
        for (int i = 0; i < N; i += (int)svcntw()) {
            svbool_t pg = svwhilelt_b32(i, N);
            svint32_t a = svld1(pg, &s32[i]);
            svbool_t p;
            switch (op) {
            case 0: p = svcmpeq_n_s32(pg, a, -16); break;
            case 1: p = svcmpne_n_s32(pg, a, 15); break;
            case 2: p = svcmpgt_n_s32(pg, a, 16); break;
            case 3: p = svcmpge_n_s32(pg, a, -17); break;
            case 4: p = svcmplt_n_s32(pg, a, -16); break;
            case 5: p = svcmple_n_s32(pg, a, 15); break;
            case 6: p = svcmpgt(pg, svdup_n_s32(15), a); break;
            default: p = svcmpeq(pg, svdup_n_s32(-16), a); break;
            }
            svst1(pg, &q32[i], svsel(p, svdup_n_u32(1), svdup_n_u32(0)));
        }
        for (int i = 0; i < N; i++) {
            int32_t a = s32[i];
            int want;
            switch (op) {
            case 0: want = a == -16; break;
            case 1: want = a != 15; break;
            case 2: want = a > 16; break;
            case 3: want = a >= -17; break;
            case 4: want = a < -16; break;
            case 5: want = a <= 15; break;
            case 6: want = 15 > a; break;
            default: want = a == -16; break;
            }
            if (q32[i] != (uint32_t)want)
                return 90 + op;
        }
    }
    for (int op = 0; op < 5; op++) {
        for (int i = 0; i < N; i += (int)svcntb()) {
            svbool_t pg = svwhilelt_b8(i, N);
            svuint8_t u = svld1(pg, &u8[i]);
            svbool_t p;
            switch (op) {
            case 0: p = svcmpgt_n_u8(pg, u, 127); break;
            case 1: p = svcmpge_n_u8(pg, u, 128); break;
            case 2: p = svcmplt_n_u8(pg, u, 0); break;
            case 3: p = svcmple_n_u8(pg, u, 127); break;
            default: p = svcmpeq_n_u8(pg, u, 255); break;
            }
            svst1(pg, &q8[i], svsel(p, svdup_n_u8(1), svdup_n_u8(0)));
        }
        for (int i = 0; i < N; i++) {
            unsigned u = u8[i];
            int want;
            switch (op) {
            case 0: want = u > 127; break;
            case 1: want = u >= 128; break;
            case 2: want = 0; break;
            case 3: want = u <= 127; break;
            default: want = u == 255; break;
            }
            if (q8[i] != (uint8_t)want)
                return 100 + op;
        }
    }
    for (int op = 0; op < 5; op++) {
        for (int i = 0; i < N; i += (int)svcntd()) {
            svbool_t pg = svwhilelt_b64(i, N);
            svfloat64_t a = svld1(pg, &f64[i]);
            svbool_t p;
            switch (op) {
            case 0: p = svcmpeq_n_f64(pg, a, 0.0); break;
            case 1: p = svcmpgt_n_f64(pg, a, -0.0); break;
            case 2: p = svcmple_n_f64(pg, a, 0.0); break;
            case 3: p = svcmplt_n_f64(pg, a, 1.0); break;
            default: p = svcmpne_n_f64(pg, a, -0.0); break;
            }
            svst1(pg, &q64[i], svsel(p, svdup_n_u64(1), svdup_n_u64(0)));
        }
        for (int i = 0; i < N; i++) {
            double a = f64[i];
            int want;
            switch (op) {
            case 0: want = a == 0.0; break;
            case 1: want = a > 0.0; break;
            case 2: want = a <= 0.0; break;
            case 3: want = a < 1.0; break;
            default: want = a != 0.0; break;
            }
            if (q64[i] != (uint64_t)want)
                return 110 + op;
        }
    }
    return 0;
}

#define LANE(code, T, sv, b, cnt, src, k)                            \
    do {                                                             \
        static T out[256 / sizeof(T)];                               \
        svbool_t all = svptrue_##b();                                \
        svst1(all, out, sv(svld1(all, src), k));                     \
        int n = (int)cnt();                                          \
        for (int i = 0; i < n; i++)                                  \
            if (out[i] != ((k) < n ? src[k] : 0))                    \
                return code;                                         \
    } while (0)

/* svdup_lane at constant indices: DUP reaches 512 bits, TBL past them,
 * and an index past the vector gives zero lanes. */
static int lanes(void) {
    static int8_t b[256];
    static int16_t h[128];
    static int32_t w[64];
    static int64_t d[32];
    for (int i = 0; i < 256; i++) {
        b[i] = (int8_t)(i * 7 - 100);
        if (i < 128)
            h[i] = (int16_t)(i * 300 - 9000);
        if (i < 64)
            w[i] = i * 100003 - 7;
        if (i < 32)
            d[i] = (int64_t)i * -1000000007;
    }
    LANE(120, int8_t, svdup_lane_s8, b8, svcntb, b, 0);
    LANE(121, int8_t, svdup_lane_s8, b8, svcntb, b, 63);
    LANE(122, int8_t, svdup_lane_s8, b8, svcntb, b, 64);
    LANE(123, int8_t, svdup_lane_s8, b8, svcntb, b, 255);
    LANE(124, int16_t, svdup_lane_s16, b16, svcnth, h, 31);
    LANE(125, int16_t, svdup_lane_s16, b16, svcnth, h, 32);
    LANE(126, int32_t, svdup_lane_s32, b32, svcntw, w, 15);
    LANE(127, int32_t, svdup_lane_s32, b32, svcntw, w, 16);
    LANE(128, int64_t, svdup_lane_s64, b64, svcntd, d, 1);
    LANE(129, int64_t, svdup_lane_s64, b64, svcntd, d, 7);
    LANE(130, int64_t, svdup_lane_s64, b64, svcntd, d, 8);
    return 0;
}

/* One constant two rows read, as an immediate and as a register, and one
 * live across a call. */
static int shared(void) {
    for (int i = 0; i < N; i += (int)svcntw()) {
        svbool_t pg = svwhilelt_b32(i, N);
        svint32_t a = svld1(pg, &s32[i]);
        svbool_t odd = svcmpne_n_u32(pg, svld1(pg, &m32[i]), 0);
        svint32_t c = svdup_n_s32(9), k = svdup_n_s32(-5);
        hook();
        svint32_t r = svadd_x(pg, svmul_m(odd, a, c), c);
        svst1(pg, &r32[i], svsub_x(pg, r, k));
    }
    for (int i = 0; i < N; i++) {
        uint32_t a = (uint32_t)s32[i];
        uint32_t want = (m32[i] ? a * 9u : a) + 9u + 5u;
        if (r32[i] != (int32_t)want)
            return 140;
    }
    return 0;
}

int main(void) {
    fill();
    int r = dups();
    if (!r)
        r = words();
    if (!r)
        r = other_widths();
    if (!r)
        r = floats();
    if (!r)
        r = compares();
    if (!r)
        r = lanes();
    if (!r)
        r = shared();
    if (r)
        return r;
    return (int)(svcntb() / 16);
}
