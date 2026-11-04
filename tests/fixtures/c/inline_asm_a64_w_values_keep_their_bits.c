/* AArch64 inline asm: a `w` output or read-write operand of 4 or 8 bytes
 * holds the value of its SIMD register. The value keeps its bits when an
 * integer object receives it, when an 8-byte vector built from it is read
 * as one integer, as a lane, through memory, from a struct member or after
 * a join of two paths, and when another operand reads it.
 * The exit code is the line of the first mismatch. Elsewhere the program
 * exits 0. */

#if defined(__aarch64__)
#include <arm_neon.h>
#include <stdint.h>
#include <string.h>

#define CHECK(c)             \
    do {                     \
        if (!(c))            \
            return __LINE__; \
    } while (0)

static long long bits_d(double d) {
    long long r;
    __asm__("fmov %d0, %d1" : "=w"(r) : "w"(d));
    return r + 1;
}

static int bits_s(float f) {
    int r;
    __asm__("fmov %s0, %s1" : "=w"(r) : "w"(f));
    return r ^ 1;
}

static uint64_t vec_bits(float32x2_t v) {
    return (uint64_t)vadd_f32(v, v);
}

static float lane1(float32x2_t a, float32x2_t b) {
    float32x2_t s = vadd_f32(a, b);
    return s[1];
}

struct holder {
    int tag;
    float32x2_t v;
};

static void keep(struct holder *h, float32x2_t a) {
    h->v = vmul_f32(a, a);
}

static float32x2_t neg_then_double(float32x2_t a) {
    __asm__("fneg %0.2s, %0.2s" : "+w"(a));
    float32x2_t c = a;
    __asm__("fneg %0.2s, %0.2s\n\tfadd %0.2s, %0.2s, %0.2s" : "+w"(c));
    return c;
}

static double scale(double d, double k) {
    __asm__("fmul %d0, %d0, %d1" : "+w"(d) : "w"(k));
    return d;
}

static float scale_s(float f, float k) {
    float r;
    __asm__("fmul %s0, %s1, %s2" : "=w"(r) : "w"(f), "w"(k));
    return r + 1.0f;
}

static float32x2_t pick(int which, float32x2_t a, float32x2_t b) {
    float32x2_t r = which ? vadd_f32(a, b) : vsub_f32(a, b);
    return vdup_n_f32(r[0] + r[1]);
}

static int run(void) {
    volatile double d = 2.5;
    CHECK(bits_d(d) == 0x4004000000000001LL);
    volatile float f = 1.0f;
    CHECK(bits_s(f) == 0x3f800001);
    CHECK(scale(d, 0.5) == 1.25);
    CHECK(scale_s(f, 3.0f) == 4.0f);
    static const float in[4] = {1.5f, -2.0f, 0.25f, 4.0f};
    float32x2_t a = vld1_f32(in), b = vld1_f32(in + 2);
    CHECK(vec_bits(a) == 0xc080000040400000ULL);
    CHECK(lane1(a, b) == 2.0f);
    struct holder h = {7, {0, 0}};
    keep(&h, a);
    CHECK(h.tag == 7 && h.v[0] == 2.25f && h.v[1] == 4.0f);
    float32x2_t t = neg_then_double(a);
    CHECK(t[0] == 3.0f && t[1] == -4.0f);
    volatile int which = 1;
    float32x2_t p = pick(which, a, b);
    CHECK(p[0] == 3.75f && p[1] == 3.75f);
    which = 0;
    p = pick(which, a, b);
    CHECK(p[0] == -4.75f && p[1] == -4.75f);
    uint64_t raw;
    float32x2_t m = vmul_f32(a, b);
    memcpy(&raw, &m, sizeof raw);
    CHECK(raw == 0xc10000003ec00000ULL);
    float out[2];
    vst1_f32(out, vfma_f32(a, a, b));
    CHECK(out[0] == 1.875f && out[1] == -10.0f);
    double dd = d;
    float64x1_t x = vld1_f64(&dd), y = vadd_f64(x, x);
    CHECK(vget_lane_f64(y, 0) == 5.0);
    return 0;
}

int main(void) {
    return run();
}
#else
int main(void) {
    return 0;
}
#endif
