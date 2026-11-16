// The FMA3 forms of <immintrin.h> propagate a NaN operand as it is, the
// negating forms included: a NaN multiplicand of vfnmadd or a NaN addend of
// vfmsub keeps its sign, where AArch64's FMLS and FNMADD negate it first.
// The first NaN among the multiplicands and then the addend is the result,
// quieted. Returns 0 when every lane matches, else the failing check's
// number; elsewhere than x86-64 the unit is empty.

#ifdef __x86_64__
#include <immintrin.h>
#include <string.h>

static unsigned bits(float f) {
    unsigned u;
    memcpy(&u, &f, 4);
    return u;
}

static float val(unsigned u) {
    float f;
    memcpy(&f, &u, 4);
    return f;
}

static unsigned long long dbits(double d) {
    unsigned long long u;
    memcpy(&u, &d, 8);
    return u;
}

static double dval(unsigned long long u) {
    double d;
    memcpy(&d, &u, 8);
    return d;
}

int main(void) {
    const unsigned q1 = 0x7FC00001, n2 = 0xFFC00002, s3 = 0x7F800003, one = 0x3F800000,
                   two = 0x40000000;
    // Lane 0: a NaN multiplicand; 1: a negative NaN addend; 2: a signaling
    // multiplicand before a quiet addend; 3: both multiplicands NaN.
    __m128 a = _mm_setr_ps(val(q1), val(one), val(s3), val(q1));
    __m128 b = _mm_setr_ps(val(two), val(two), val(two), val(n2));
    __m128 c = _mm_setr_ps(val(one), val(n2), val(q1), val(one));
    const unsigned want[4] = {q1, n2, s3 | 0x400000, q1};
    __m128 r[6] = {_mm_fmadd_ps(a, b, c),    _mm_fmsub_ps(a, b, c),
                   _mm_fnmadd_ps(a, b, c),   _mm_fnmsub_ps(a, b, c),
                   _mm_fmaddsub_ps(a, b, c), _mm_fmsubadd_ps(a, b, c)};
    for (int k = 0; k < 6; k++)
        for (int i = 0; i < 4; i++)
            if (bits(r[k][i]) != want[i])
                return 1 + k;
    __m256 a8 = _mm256_set_m128(a, a), b8 = _mm256_set_m128(b, b), c8 = _mm256_set_m128(c, c);
    __m256 r8[3] = {_mm256_fnmadd_ps(a8, b8, c8), _mm256_fmsub_ps(a8, b8, c8),
                    _mm256_fmsubadd_ps(a8, b8, c8)};
    for (int k = 0; k < 3; k++)
        for (int i = 0; i < 8; i++)
            if (bits(r8[k][i]) != want[i % 4])
                return 7 + k;
    const unsigned long long dq = 0x7FF8000000000001ULL, dn = 0xFFF8000000000002ULL;
    __m256d ad = _mm256_setr_pd(dval(dq), 1.0, 1.0, dval(dn));
    __m256d bd = _mm256_setr_pd(2.0, 2.0, dval(dn), 2.0);
    __m256d cd = _mm256_setr_pd(1.0, dval(dn), 1.0, dval(dq));
    const unsigned long long dwant[4] = {dq, dn, dn, dn};
    __m256d rd[4] = {_mm256_fnmsub_pd(ad, bd, cd), _mm256_fmsub_pd(ad, bd, cd),
                     _mm256_fmaddsub_pd(ad, bd, cd), _mm256_fnmadd_pd(ad, bd, cd)};
    for (int k = 0; k < 4; k++)
        for (int i = 0; i < 4; i++)
            if (dbits(rd[k][i]) != dwant[i])
                return 10 + k;
    __m128d r2 = _mm_fnmadd_pd(_mm256_castpd256_pd128(ad), _mm256_castpd256_pd128(bd),
                               _mm256_castpd256_pd128(cd));
    if (dbits(r2[0]) != dq || dbits(r2[1]) != dn)
        return 14;
    return 0;
}
#else
int main(void) {
    return 0;
}
#endif
