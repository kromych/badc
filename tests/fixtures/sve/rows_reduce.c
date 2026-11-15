/* The ACLE SVE reductions into a lane's value: svmaxv and svminv over
 * signed, unsigned and floating lanes, svmaxnmv and svminnmv over floating
 * ones, and svandv, svorv and sveorv over integer ones, governed by a
 * predicate over each step's lanes and checked against the same reduction
 * of those lanes in scalar C. With no lane active a reduction gives its
 * operation's identity: the lane type's minimum for svmaxv, all ones for
 * svandv, -infinity for the floating svmaxv and a NaN for svmaxnmv; a NaN
 * lane is the floating svmaxv's result and svmaxnmv passes over it. The
 * exit status is the vector length in 128-bit granules. */
#include <arm_sve.h>

#define N 77

static int8_t s8[N];
static uint8_t u8[N];
static int16_t s16[N];
static uint32_t u32[N];
static int64_t s64[N];
static float f32[N];
static double f64[N];

static void fill(void) {
    for (int i = 0; i < N; i++) {
        s8[i] = (int8_t)((i * 37) % 256 - 128);
        u8[i] = (uint8_t)(i * 53 + 7);
        s16[i] = (int16_t)(i * 997 - 30000);
        u32[i] = (uint32_t)i * 2654435761u;
        s64[i] = (int64_t)((uint64_t)i * 0x9E3779B97F4A7C15ull);
        f32[i] = (float)(i % 13) * 1.5f - (float)(i % 7);
        f64[i] = (double)(i % 11) * -2.25 + (double)(i % 5);
    }
}

/* The lanes k of [i, end) whose index is odd when `odd`, all otherwise. */
static int on(int k, int odd) {
    return !odd || (k & 1);
}

static int integers(void) {
    for (int odd = 0; odd < 2; odd++) {
        int step = (int)svcntb();
        for (int i = 0; i < N; i += step) {
            int end = i + step < N ? i + step : N;
            svbool_t pg = svwhilelt_b8(i, N);
            int8_t idx[256];
            for (int k = 0; k < step; k++)
                idx[k] = (int8_t)(odd ? (i + k) & 1 : 1);
            svbool_t act = svcmpne_n_s8(pg, svld1(pg, idx), 0);
            int8_t mx = INT8_MIN, mn = INT8_MAX;
            uint8_t umx = 0, umn = UINT8_MAX;
            for (int k = i; k < end; k++)
                if (on(k, odd)) {
                    mx = s8[k] > mx ? s8[k] : mx;
                    mn = s8[k] < mn ? s8[k] : mn;
                    umx = u8[k] > umx ? u8[k] : umx;
                    umn = u8[k] < umn ? u8[k] : umn;
                }
            if (svmaxv_s8(act, svld1(pg, &s8[i])) != mx || svminv(act, svld1(pg, &s8[i])) != mn)
                return 10;
            if (svmaxv(act, svld1(pg, &u8[i])) != umx || svminv_u8(act, svld1(pg, &u8[i])) != umn)
                return 11;
        }
        step = (int)svcnth();
        for (int i = 0; i < N; i += step) {
            int end = i + step < N ? i + step : N;
            svbool_t pg = svwhilelt_b16(i, N);
            int16_t idx[128];
            for (int k = 0; k < step; k++)
                idx[k] = (int16_t)(odd ? (i + k) & 1 : 1);
            svbool_t act = svcmpne_n_s16(pg, svld1(pg, idx), 0);
            int16_t a = -1, o = 0, x = 0;
            for (int k = i; k < end; k++)
                if (on(k, odd)) {
                    a &= s16[k];
                    o |= s16[k];
                    x ^= s16[k];
                }
            svint16_t v = svld1(pg, &s16[i]);
            if (svandv(act, v) != a || svorv_s16(act, v) != o || sveorv(act, v) != x)
                return 12;
        }
        step = (int)svcntw();
        for (int i = 0; i < N; i += step) {
            int end = i + step < N ? i + step : N;
            svbool_t pg = svwhilelt_b32(i, N);
            uint32_t idx[64];
            for (int k = 0; k < step; k++)
                idx[k] = (uint32_t)(odd ? (i + k) & 1 : 1);
            svbool_t act = svcmpne_n_u32(pg, svld1(pg, idx), 0);
            uint32_t a = UINT32_MAX, o = 0, x = 0;
            for (int k = i; k < end; k++)
                if (on(k, odd)) {
                    a &= u32[k];
                    o |= u32[k];
                    x ^= u32[k];
                }
            svuint32_t v = svld1(pg, &u32[i]);
            if (svandv_u32(act, v) != a || svorv(act, v) != o || sveorv_u32(act, v) != x)
                return 13;
        }
        step = (int)svcntd();
        for (int i = 0; i < N; i += step) {
            int end = i + step < N ? i + step : N;
            svbool_t pg = svwhilelt_b64(i, N);
            int64_t idx[32];
            for (int k = 0; k < step; k++)
                idx[k] = odd ? (i + k) & 1 : 1;
            svbool_t act = svcmpne_n_s64(pg, svld1(pg, idx), 0);
            int64_t mx = INT64_MIN, mn = INT64_MAX;
            for (int k = i; k < end; k++)
                if (on(k, odd)) {
                    mx = s64[k] > mx ? s64[k] : mx;
                    mn = s64[k] < mn ? s64[k] : mn;
                }
            svint64_t v = svld1(pg, &s64[i]);
            if (svmaxv(act, v) != mx || svminv_s64(act, v) != mn)
                return 14;
        }
    }
    return 0;
}

static int floats(void) {
    int step = (int)svcntw();
    for (int i = 0; i < N; i += step) {
        int end = i + step < N ? i + step : N;
        svbool_t pg = svwhilelt_b32(i, N);
        svfloat32_t v = svld1(pg, &f32[i]);
        float mx = f32[i], mn = f32[i];
        for (int k = i; k < end; k++) {
            mx = f32[k] > mx ? f32[k] : mx;
            mn = f32[k] < mn ? f32[k] : mn;
        }
        if (svmaxv(pg, v) != mx || svminv_f32(pg, v) != mn)
            return 20;
        if (svmaxnmv_f32(pg, v) != mx || svminnmv(pg, v) != mn)
            return 21;
    }
    step = (int)svcntd();
    for (int i = 0; i < N; i += step) {
        int end = i + step < N ? i + step : N;
        svbool_t pg = svwhilelt_b64(i, N);
        svfloat64_t v = svld1(pg, &f64[i]);
        double mx = f64[i], mn = f64[i];
        for (int k = i; k < end; k++) {
            mx = f64[k] > mx ? f64[k] : mx;
            mn = f64[k] < mn ? f64[k] : mn;
        }
        if (svmaxv_f64(pg, v) != mx || svminv(pg, v) != mn)
            return 22;
        if (svmaxnmv(pg, v) != mx || svminnmv_f64(pg, v) != mn)
            return 23;
    }
    return 0;
}

/* The identities, with no lane active, and a NaN lane. */
static int edges(void) {
    svbool_t none = svwhilelt_b8(0, 0);
    if (svmaxv(none, svdup_n_s8(5)) != INT8_MIN || svminv(none, svdup_n_u16(5)) != UINT16_MAX)
        return 30;
    if (svandv(none, svdup_n_s32(5)) != -1 || svorv(none, svdup_n_u64(5)) != 0)
        return 31;
    float m = svmaxv(none, svdup_n_f32(1.0f));
    if (!(m < 0 && m * 0.0f != m * 0.0f))
        return 32;
    double nm = svmaxnmv(none, svdup_n_f64(1.0));
    if (nm == nm)
        return 33;
    float nan = 0.0f / 0.0f;
    svfloat32_t one = svdup_n_f32(1.0f);
    svfloat32_t v = svsel(svwhilelt_b32(0, 1), svdup_n_f32(nan), one);
    float mx = svmaxv(svptrue_b32(), v);
    if (mx == mx || svmaxnmv(svptrue_b32(), v) != 1.0f)
        return 34;
    return 0;
}

int main(void) {
    fill();
    int r = integers();
    if (!r)
        r = floats();
    if (!r)
        r = edges();
    if (r)
        return r;
    return (int)(svcntb() / 16);
}
