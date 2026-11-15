/* An SVE floating operation raises the exceptions of its active lanes
 * alone (Arm ARM, the predicated floating-point instructions): a division
 * by zero in the merging and zeroing forms of svdiv, and an ordered
 * compare of a NaN, raise nothing in an inactive lane and their flag in
 * an active one. The operands are volatile reads after the flags are
 * cleared and the results the argument of the test, so each operation
 * lies between the two. The exit status is the vector length in 128-bit
 * granules. */
#include <arm_sve.h>
#include <fenv.h>

static volatile float one_v = 1.0f, zero_v = 0.0f, nan_v;
static int32_t lanes[64];

static int raised(float use, int flag) {
    volatile float sink = use;
    (void)sink;
    return fetestexcept(flag) != 0;
}

int main(void) {
    for (int i = 0; i < 64; i++)
        lanes[i] = i;
    nan_v = zero_v / zero_v;
    svbool_t all = svptrue_b32();
    svint32_t idx = svld1(all, lanes);
    svbool_t none = svcmplt_n_s32(all, idx, 0), first = svcmplt_n_s32(all, idx, 1);
    float n = (float)svcntw();
    feclearexcept(FE_ALL_EXCEPT);
    svfloat32_t one = svdup_n_f32(one_v), zero = svdup_n_f32(zero_v);
    float s = svaddv(all, svdiv_f32_m(none, one, zero)) + svaddv(all, svdiv_z(none, one, zero));
    if (raised(s, FE_DIVBYZERO) || s != n)
        return 10;
    s = svaddv(all, svdiv_m(first, svdup_n_f32(one_v), svdup_n_f32(zero_v)));
    if (!raised(s, FE_DIVBYZERO) || s == n)
        return 11;
    feclearexcept(FE_ALL_EXCEPT);
    svfloat32_t nan = svdup_n_f32(nan_v);
    s = svaddv(all, svsel(svcmpgt(none, nan, svdup_n_f32(one_v)), one, zero));
    if (raised(s, FE_INVALID) || s != 0.0f)
        return 12;
    s = svaddv(all, svsel(svcmpge(first, svdup_n_f32(nan_v), one), one, zero));
    if (!raised(s, FE_INVALID) || s != 0.0f)
        return 13;
    return (int)(svcntb() / 16);
}
