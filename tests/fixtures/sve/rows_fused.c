/* The ACLE SVE multiply-adds, each checked against scalar C: svmla,
 * svmls, svmad and svmsb over integer and floating lanes and svnmla,
 * svnmls, svnmad and svnmsb over floating ones, in the merging, zeroing
 * and don't-care forms and with a scalar. Functions taking the operands in
 * every order have the result's register hold each operand in turn. The
 * floating operands are small enough that every product is exact, so the
 * fused result is the rounded sum. The exit status is the vector length
 * in 128-bit granules. */
#include <arm_sve.h>

#define N 45

static int32_t a32[N], b32[N], c32[N], r32[N];
static uint32_t m32[N];
static uint8_t a8[N], b8[N], c8[N], r8[N];
static int64_t a64[N], b64[N], c64[N], r64[N];
static float f32[N], g32[N], h32[N], o32[N];
static double f64[N], g64[N], h64[N], o64[N];

static void fill(void) {
    for (int i = 0; i < N; i++) {
        uint32_t h = (uint32_t)i * 2654435761u;
        a32[i] = (int32_t)h;
        b32[i] = (int32_t)(h >> 11) - 99999;
        c32[i] = i * 7 - 150;
        m32[i] = (uint32_t)(i % 3 != 1);
        a8[i] = (uint8_t)(h >> 3);
        b8[i] = (uint8_t)(i * 13);
        c8[i] = (uint8_t)(255 - i);
        a64[i] = (int64_t)((uint64_t)i * 0x9E3779B97F4A7C15ull);
        b64[i] = i * 1234567 - 7654321;
        c64[i] = -i;
        f32[i] = (float)(i % 11) - 5.5f;
        g32[i] = (float)(i % 7) * 0.25f - 1.0f;
        h32[i] = (float)(i * 3 % 17) - 8.0f;
        f64[i] = (double)(i % 13) * 1.5;
        g64[i] = 3.0 - (double)(i % 5);
        h64[i] = (double)i * -0.125;
    }
}

/* The operands in every order, so the result's register holds the first,
 * the second, the third or none of them. */
#define ORDERS(T, F)                                                          \
    __attribute__((noinline)) static T F##_abc(svbool_t g, T a, T b, T c) {   \
        return F(g, a, b, c);                                                 \
    }                                                                         \
    __attribute__((noinline)) static T F##_bac(svbool_t g, T b, T a, T c) {   \
        return F(g, a, b, c);                                                 \
    }                                                                         \
    __attribute__((noinline)) static T F##_cab(svbool_t g, T c, T a, T b) {   \
        return F(g, a, b, c);                                                 \
    }                                                                         \
    __attribute__((noinline)) static T F##_xabc(svbool_t g, T x, T a, T b, T c) { \
        (void)x;                                                              \
        return F(g, a, b, c);                                                 \
    }

ORDERS(svint32_t, svmla_m)
ORDERS(svint32_t, svmls_z)
ORDERS(svint32_t, svmad_x)
ORDERS(svint32_t, svmsb_m)
ORDERS(svint32_t, svmla_x)
ORDERS(svint32_t, svmsb_z)
ORDERS(svfloat32_t, svmls_x)
ORDERS(svfloat32_t, svnmla_m)
ORDERS(svfloat32_t, svmsb_x)
ORDERS(svfloat32_t, svnmad_z)

static int words(void) {
    for (int op = 0; op < 24; op++) {
        for (int i = 0; i < N; i += (int)svcntw()) {
            svbool_t pg = svwhilelt_b32(i, N);
            svint32_t a = svld1(pg, &a32[i]), b = svld1(pg, &b32[i]), c = svld1(pg, &c32[i]);
            svbool_t on = svcmpne_n_u32(pg, svld1(pg, &m32[i]), 0);
            svbool_t g = on;
            if (op % 4 == 0)
                g = pg;
            svint32_t r;
            switch (op / 4) {
            case 0: r = svmla_m_abc(g, a, b, c); break;
            case 1: r = svmls_z_bac(g, b, a, c); break;
            case 2: r = svmad_x_cab(pg, c, a, b); break;
            case 3: r = svmsb_m_xabc(g, c, a, b, c); break;
            case 4:
                if (op % 2)
                    r = svmla_x_bac(pg, b, a, c);
                else
                    r = svmla_x_xabc(pg, a, a, b, c);
                break;
            default:
                if (op % 2)
                    r = svmsb_z_cab(g, c, a, b);
                else
                    r = svmsb_z_abc(g, a, b, c);
                break;
            }
            svst1(pg, &r32[i], r);
        }
        for (int i = 0; i < N; i++) {
            uint32_t a = (uint32_t)a32[i], b = (uint32_t)b32[i], c = (uint32_t)c32[i];
            int on = op % 4 == 0 || m32[i] != 0;
            uint32_t want;
            switch (op / 4) {
            case 0: want = on ? a + b * c : a; break;
            case 1: want = on ? a - b * c : 0; break;
            case 2: want = c + a * b; break;
            case 3: want = on ? c - a * b : a; break;
            case 4: want = a + b * c; break;
            default: want = on ? c - a * b : 0; break;
            }
            if ((uint32_t)r32[i] != want)
                return 10 + op;
        }
    }
    return 0;
}

static int bytes_and_doublewords(void) {
    for (int i = 0; i < N; i += (int)svcntb()) {
        svbool_t pg = svwhilelt_b8(i, N);
        svuint8_t a = svld1(pg, &a8[i]), b = svld1(pg, &b8[i]), c = svld1(pg, &c8[i]);
        svst1(pg, &r8[i], svmls_n_u8_x(pg, svmad_u8_z(pg, a, b, c), c, 3));
    }
    for (int i = 0; i < N; i += (int)svcntd()) {
        svbool_t pg = svwhilelt_b64(i, N);
        svint64_t a = svld1(pg, &a64[i]), b = svld1(pg, &b64[i]), c = svld1(pg, &c64[i]);
        svbool_t odd = svcmplt_n_s64(pg, c, -20);
        svst1(pg, &r64[i], svmad_n_s64_m(odd, svmla_s64_x(pg, a, b, c), b, -7));
    }
    for (int i = 0; i < N; i++) {
        unsigned m = (uint8_t)(c8[i] + a8[i] * b8[i]);
        if (r8[i] != (uint8_t)(m - c8[i] * 3u))
            return 40;
        uint64_t x = (uint64_t)a64[i] + (uint64_t)b64[i] * (uint64_t)c64[i];
        uint64_t want = c64[i] < -20 ? (uint64_t)-7 + x * (uint64_t)b64[i] : x;
        if ((uint64_t)r64[i] != want)
            return 41;
    }
    return 0;
}

static int floats(void) {
    for (int op = 0; op < 16; op++) {
        for (int i = 0; i < N; i += (int)svcntw()) {
            svbool_t pg = svwhilelt_b32(i, N);
            svfloat32_t a = svld1(pg, &f32[i]), b = svld1(pg, &g32[i]), c = svld1(pg, &h32[i]);
            svbool_t on = svcmpne_n_u32(pg, svld1(pg, &m32[i]), 0);
            svfloat32_t r;
            switch (op) {
            case 0: r = svmls_x_abc(pg, a, b, c); break;
            case 1: r = svmls_x_bac(pg, b, a, c); break;
            case 2: r = svmls_x_cab(pg, c, a, b); break;
            case 3: r = svnmla_m_cab(on, c, a, b); break;
            case 4: r = svnmla_m_xabc(on, b, a, b, c); break;
            case 5: r = svmsb_x_cab(pg, c, a, b); break;
            case 6: r = svmsb_x_bac(pg, b, a, c); break;
            case 7: r = svnmad_z_abc(on, a, b, c); break;
            case 8: r = svnmad_z_bac(on, b, a, c); break;
            case 9: r = svmla_f32_m(on, a, b, c); break;
            case 10: r = svnmls_n_f32_z(on, a, b, 0.5f); break;
            case 11: r = svmad_f32_x(pg, a, b, c); break;
            case 12: r = svnmsb_f32_m(on, a, b, c); break;
            case 13: r = svmla_n_f32_z(on, a, b, -2.0f); break;
            case 14: r = svnmla_x(pg, a, b, c); break;
            default: r = svmsb_n_f32_m(on, a, b, 3.0f); break;
            }
            svst1(pg, &o32[i], r);
        }
        for (int i = 0; i < N; i++) {
            float a = f32[i], b = g32[i], c = h32[i], want;
            int on = m32[i] != 0;
            switch (op) {
            case 0: case 1: case 2: want = a - b * c; break;
            case 3: case 4: want = on ? -a - b * c : a; break;
            case 5: case 6: want = c - a * b; break;
            case 7: case 8: want = on ? -c - a * b : 0.0f; break;
            case 9: want = on ? a + b * c : a; break;
            case 10: want = on ? -a + b * 0.5f : 0.0f; break;
            case 11: want = c + a * b; break;
            case 12: want = on ? -c + a * b : a; break;
            case 13: want = on ? a + b * -2.0f : 0.0f; break;
            case 14: want = -a - b * c; break;
            default: want = on ? 3.0f - a * b : a; break;
            }
            if (o32[i] != want)
                return 50 + op;
        }
    }
    for (int i = 0; i < N; i += (int)svcntd()) {
        svbool_t pg = svwhilelt_b64(i, N);
        svfloat64_t a = svld1(pg, &f64[i]), b = svld1(pg, &g64[i]), c = svld1(pg, &h64[i]);
        svst1(pg, &o64[i], svnmls_x(pg, svmls_f64_z(pg, a, b, c), c, svmad_x(pg, a, c, b)));
    }
    for (int i = 0; i < N; i++) {
        double a = f64[i], b = g64[i], c = h64[i];
        double x = a - b * c, y = b + a * c;
        if (o64[i] != -x + c * y)
            return 70;
    }
    return 0;
}

int main(void) {
    fill();
    int r = words();
    if (!r)
        r = bytes_and_doublewords();
    if (!r)
        r = floats();
    if (r)
        return r;
    return (int)(svcntb() / 16);
}
