// ACLE floating vectors through <arm_neon.h>: float32x2_t, float32x4_t,
// float64x1_t and float64x2_t with their loads and stores, broadcasts,
// arithmetic, fused multiply-accumulates, compares, selects, integer and
// precision conversions, lane access, halves and reinterpretations. Each
// lane is checked bit for bit against the value the instruction defines:
// fmax propagates a NaN, fcmeq is false for one, and the conversions to
// integer truncate toward zero and saturate. AArch64 only; elsewhere the
// unit is empty.

#if defined(__aarch64__)
#include <arm_neon.h>

static int same_f32(float32x4_t v, float a, float b, float c, float d) {
    float32_t out[4];
    vst1q_f32(out, v);
    return out[0] == a && out[1] == b && out[2] == c && out[3] == d;
}

static int same_u32(uint32x4_t v, unsigned a, unsigned b, unsigned c, unsigned d) {
    return v[0] == a && v[1] == b && v[2] == c && v[3] == d;
}

int main(void) {
    static const float32_t fa[4] = {1.5f, -2.0f, 3.25f, 8.0f};
    static const float32_t fb[4] = {0.5f, 4.0f, -1.0f, 2.0f};
    static const float64_t da[2] = {10.5, -0.25};
    static const float64_t db[2] = {2.0, 4.0};
    float32x4_t a = vld1q_f32(fa), b = vld1q_f32(fb);
    float32x2_t a2 = vld1_f32(fa), b2 = vld1_f32(fb);
    float64x2_t x = vld1q_f64(da), y = vld1q_f64(db);
    float64x1_t x1 = vld1_f64(da), y1 = vld1_f64(db);

    if (!same_f32(vaddq_f32(a, b), 2.0f, 2.0f, 2.25f, 10.0f)) return 1;
    if (!same_f32(vsubq_f32(a, b), 1.0f, -6.0f, 4.25f, 6.0f)) return 2;
    if (!same_f32(vmulq_f32(a, b), 0.75f, -8.0f, -3.25f, 16.0f)) return 3;
    if (!same_f32(vdivq_f32(a, b), 3.0f, -0.5f, -3.25f, 4.0f)) return 4;
    if (!same_f32(vmaxq_f32(a, b), 1.5f, 4.0f, 3.25f, 8.0f)) return 5;
    if (!same_f32(vminq_f32(a, b), 0.5f, -2.0f, -1.0f, 2.0f)) return 6;
    if (!same_f32(vabsq_f32(a), 1.5f, 2.0f, 3.25f, 8.0f)) return 7;
    if (!same_f32(vnegq_f32(a), -1.5f, 2.0f, -3.25f, -8.0f)) return 8;
    if (!same_f32(vsqrtq_f32(vmulq_f32(b, b)), 0.5f, 4.0f, 1.0f, 2.0f)) return 9;
    // a + b * b and a - b * b.
    if (!same_f32(vfmaq_f32(a, b, b), 1.75f, 14.0f, 4.25f, 12.0f)) return 10;
    if (!same_f32(vfmsq_f32(a, b, b), 1.25f, -18.0f, 2.25f, 4.0f)) return 11;

    float32x2_t s2 = vadd_f32(a2, b2);
    if (vget_lane_f32(s2, 0) != 2.0f || vget_lane_f32(s2, 1) != 2.0f) return 12;
    float32x2_t m2 = vfma_f32(a2, b2, b2);
    if (vget_lane_f32(m2, 0) != 1.75f || vget_lane_f32(m2, 1) != 14.0f) return 13;
    if (vget_lane_f32(vmul_f32(a2, b2), 1) != -8.0f || vget_lane_f32(vabs_f32(a2), 1) != 2.0f)
        return 14;

    float64x2_t q = vfmaq_f64(x, y, y);
    if (vgetq_lane_f64(q, 0) != 14.5 || vgetq_lane_f64(q, 1) != 15.75) return 15;
    if (vgetq_lane_f64(vdivq_f64(x, y), 0) != 5.25) return 16;
    if (vgetq_lane_f64(vsubq_f64(x, y), 1) != -4.25) return 17;
    float64x1_t r1 = vadd_f64(x1, y1);
    if (vget_lane_f64(r1, 0) != 12.5) return 18;
    if (vget_lane_f64(vfma_f64(x1, y1, y1), 0) != 14.5) return 19;
    if (vget_lane_f64(vfms_f64(x1, y1, y1), 0) != 6.5) return 20;
    if (vget_lane_f64(vsqrt_f64(vmul_f64(y1, y1)), 0) != 2.0) return 21;
    if (vget_lane_f64(vneg_f64(vmax_f64(x1, y1)), 0) != -10.5) return 22;

    // Compares give all-ones lanes; a NaN compares unequal and fmax keeps it.
    volatile float nan = __builtin_nanf("");
    float32x4_t n = vsetq_lane_f32(nan, a, 2);
    if (!same_u32(vceqq_f32(a, n), ~0u, ~0u, 0, ~0u)) return 23;
    if (!same_u32(vcgeq_f32(a, b), ~0u, 0, ~0u, ~0u)) return 24;
    if (!same_u32(vcgtq_f32(a, b), ~0u, 0, ~0u, ~0u)) return 25;
    if (!same_u32(vcleq_f32(a, b), 0, ~0u, 0, 0)) return 26;
    if (!same_u32(vcltq_f32(a, b), 0, ~0u, 0, 0)) return 27;
    float32x4_t mx = vmaxq_f32(n, b);
    if (vgetq_lane_f32(mx, 2) == vgetq_lane_f32(mx, 2) || vgetq_lane_f32(mx, 0) != 1.5f) return 28;
    uint64x2_t lt = vcltq_f64(x, y);
    if (lt[0] != 0 || lt[1] != ~0ull) return 29;
    if (vceq_f64(x1, x1)[0] != ~0ull || vcgt_f64(x1, y1)[0] != ~0ull || vcle_f64(x1, y1)[0] != 0)
        return 30;
    if (vceq_f32(a2, b2)[0] != 0 || vcge_f32(a2, a2)[1] != ~0u) return 31;

    // The mask selects lanes of the first operand.
    if (!same_f32(vbslq_f32(vcgtq_f32(a, b), a, b), 1.5f, 4.0f, 3.25f, 8.0f)) return 32;
    float64x2_t sel = vbslq_f64(vcltq_f64(x, y), x, y);
    if (vgetq_lane_f64(sel, 0) != 2.0 || vgetq_lane_f64(sel, 1) != -0.25) return 33;

    // Integer conversions truncate toward zero and saturate.
    static const float32_t big[4] = {-2.75f, 2.75f, 3e9f, -3e9f};
    float32x4_t bf = vld1q_f32(big);
    int32x4_t si = vcvtq_s32_f32(bf);
    if (si[0] != -2 || si[1] != 2 || si[2] != 2147483647 || si[3] != -2147483647 - 1) return 34;
    uint32x4_t ui = vcvtq_u32_f32(bf);
    if (ui[0] != 0 || ui[1] != 2 || ui[2] != 3000000000u || ui[3] != 0) return 35;
    int32x4_t iv = {-3, 0, 7, 16777217};
    if (!same_f32(vcvtq_f32_s32(iv), -3.0f, 0.0f, 7.0f, 16777216.0f)) return 36;
    uint32x4_t uv = {4294967295u, 1, 2, 3};
    if (!same_f32(vcvtq_f32_u32(uv), 4294967296.0f, 1.0f, 2.0f, 3.0f)) return 37;
    int32x2_t i2 = vcvt_s32_f32(a2);
    if (i2[0] != 1 || i2[1] != -2) return 38;
    if (vget_lane_f32(vcvt_f32_s32(i2), 1) != -2.0f) return 39;
    int64x2_t l2 = vcvtq_s64_f64(x);
    if (l2[0] != 10 || l2[1] != 0) return 40;
    uint64x2_t u2 = {18446744073709551615ull, 5};
    float64x2_t du = vcvtq_f64_u64(u2);
    if (vgetq_lane_f64(du, 0) != 18446744073709551616.0 || vgetq_lane_f64(du, 1) != 5.0) return 41;
    if (vcvt_s64_f64(x1)[0] != 10 || vget_lane_f64(vcvt_f64_s64((int64x1_t){-7}), 0) != -7.0)
        return 42;

    // Precision conversions and halves.
    float64x2_t wide = vcvt_f64_f32(vget_high_f32(a));
    if (vgetq_lane_f64(wide, 0) != 3.25 || vgetq_lane_f64(wide, 1) != 8.0) return 43;
    if (vgetq_lane_f64(vcvt_high_f64_f32(a), 1) != 8.0) return 44;
    float32x2_t narrow = vcvt_f32_f64(x);
    if (vget_lane_f32(narrow, 0) != 10.5f || vget_lane_f32(narrow, 1) != -0.25f) return 45;
    float32x4_t joined = vcvt_high_f32_f64(vget_low_f32(a), y);
    if (!same_f32(joined, 1.5f, -2.0f, 2.0f, 4.0f)) return 46;
    if (!same_f32(vcombine_f32(vget_high_f32(a), vget_low_f32(b)), 3.25f, 8.0f, 0.5f, 4.0f))
        return 47;
    float64x2_t c2 = vcombine_f64(vget_high_f64(x), vget_low_f64(y));
    if (vgetq_lane_f64(c2, 0) != -0.25 || vgetq_lane_f64(c2, 1) != 2.0) return 48;

    // Broadcasts, stores and reinterpretations.
    if (!same_f32(vdupq_n_f32(-0.5f), -0.5f, -0.5f, -0.5f, -0.5f)) return 49;
    if (vgetq_lane_f64(vmovq_n_f64(6.5), 1) != 6.5 || vget_lane_f64(vdup_n_f64(1.0), 0) != 1.0)
        return 50;
    float32_t out2[2];
    vst1_f32(out2, vdup_n_f32(9.0f));
    float64_t outd[2];
    vst1q_f64(outd, y);
    vst1_f64(outd, x1);
    if (out2[0] != 9.0f || out2[1] != 9.0f || outd[0] != 10.5 || outd[1] != 4.0) return 51;
    uint32x4_t bits = vreinterpretq_u32_f32(vdupq_n_f32(1.0f));
    if (bits[3] != 0x3f800000u) return 52;
    uint64x2_t two = {0x4000000000000000ull, 0};
    if (vgetq_lane_f64(vreinterpretq_f64_u64(two), 0) != 2.0) return 53;
    return 0;
}
#else
int main(void) { return 0; }
#endif
