// AVX2's gathers, masked and not, by 32- and 64-bit indices into 32- and
// 64-bit lanes at every scale, and the masked loads and stores; AVX's
// 16-bit set, extract and insert forms, the split 128-bit transfers, the
// non-temporal transfers, VPTEST's and VTESTPS's flags, the variable
// permutes and the 256-bit rounding and dot product. Each is checked
// against the result the SDM defines for its instruction. A masked-off
// gather lane's index points far outside the table, so an access to it
// faults. The exit code has bit N set when group N fails; elsewhere than
// x86-64 the unit is empty.
// snapshot-budget: exempt

#ifdef __x86_64__
#include <immintrin.h>
#include <string.h>

typedef unsigned long long u64;

static u64 seed = 0x9E3779B97F4A7C15ULL;

static u64 next(void) {
    seed ^= seed >> 12;
    seed ^= seed << 25;
    seed ^= seed >> 27;
    return seed * 0x2545F4914F6CDD1DULL;
}

static void rnd(unsigned char *b, int n) {
    for (int k = 0; k < n; k++)
        b[k] = (unsigned char)(next() >> 24);
}

// The gathered table; the base points into its middle, so an index may be
// negative.
static unsigned char table[1024];
#define BASE (table + 512)
#define FAR 0x10000000

// Element `i` of width `w` bytes at byte offset `off` from the base.
static u64 at(long long off, int w) {
    u64 v = 0;
    memcpy(&v, BASE + off, (size_t)w);
    return v;
}

static void set_lane(unsigned char *b, int w, int i, u64 v) {
    for (int k = 0; k < w; k++)
        b[w * i + k] = (unsigned char)(v >> (8 * k));
}

static u64 get_lane(const unsigned char *b, int w, int i) {
    u64 v = 0;
    memcpy(&v, b + w * i, (size_t)w);
    return v;
}

// An index whose element at scale `s` lies in the table.
static long long index_for(int s) {
    long long span = (512 - 8) / s;
    return (long long)(next() % (u64)(2 * span)) - span;
}

// One gather form: `n` lanes of `w` bytes from indices of `iw` bytes; with
// `masked`, the lanes whose mask is clear keep `src`.
struct gather {
    unsigned char idx[32], mask[32], src[32], want[32];
};

static void prepare(struct gather *g, int n, int w, int iw, int s, int masked) {
    memset(g, 0, sizeof *g);
    rnd(g->src, 32);
    for (int k = 0; k < n; k++) {
        int on = !masked || (next() >> 62) != 0;
        long long ix = on ? index_for(s) : FAR;
        set_lane(g->idx, iw, k, (u64)ix);
        set_lane(g->mask, w, k, on ? ~0ULL << (8 * w - 1) : 0x7F);
        set_lane(g->want, w, k, on ? at(ix * s, w) : get_lane(g->src, w, k));
    }
}

static int check_gathers(int masked) {
    struct gather g;
    int fail = 0;
    __m128i i128, m128, s128, r128;
    __m256i i256, m256, s256, r256;
#define LOAD(g)                         \
    memcpy(&i128, g.idx, 16);           \
    memcpy(&i256, g.idx, 32);           \
    memcpy(&m128, g.mask, 16);          \
    memcpy(&m256, g.mask, 32);          \
    memcpy(&s128, g.src, 16);           \
    memcpy(&s256, g.src, 32)
#define CHECK(r, bytes)                         \
    if (memcmp(&(r), g.want, bytes) != 0)       \
        fail |= masked ? 4 : 1 << (iw == 8)
#define FORM(S)                                                                                 \
    do {                                                                                        \
        int iw = 4;                                                                             \
        prepare(&g, 4, 4, 4, S, masked);                                                    \
        LOAD(g);                                                                                \
        r128 = masked ? _mm_mask_i32gather_epi32(s128, (int const *)BASE, i128, m128, S)        \
                      : _mm_i32gather_epi32((int const *)BASE, i128, S);                        \
        CHECK(r128, 16);                                                                        \
        prepare(&g, 8, 4, 4, S, masked);                                                    \
        LOAD(g);                                                                                \
        r256 = masked ? _mm256_mask_i32gather_epi32(s256, (int const *)BASE, i256, m256, S)     \
                      : _mm256_i32gather_epi32((int const *)BASE, i256, S);                     \
        CHECK(r256, 32);                                                                        \
        prepare(&g, 2, 8, 4, S, masked);                                                    \
        LOAD(g);                                                                                \
        r128 = masked ? _mm_mask_i32gather_epi64(s128, (long long const *)BASE, i128, m128, S)  \
                      : _mm_i32gather_epi64((long long const *)BASE, i128, S);                  \
        CHECK(r128, 16);                                                                        \
        prepare(&g, 4, 8, 4, S, masked);                                                    \
        LOAD(g);                                                                                \
        r256 = masked ? _mm256_mask_i32gather_epi64(s256, (long long const *)BASE, i128, m256, S) \
                      : _mm256_i32gather_epi64((long long const *)BASE, i128, S);               \
        CHECK(r256, 32);                                                                        \
        {                                                                                       \
            __m128 f;                                                                           \
            __m256 f8;                                                                          \
            __m128d d;                                                                          \
            __m256d d4;                                                                         \
            prepare(&g, 4, 4, 4, S, masked);                                                \
            LOAD(g);                                                                            \
            f = masked ? _mm_mask_i32gather_ps(_mm_castsi128_ps(s128), (float const *)BASE, i128, \
                                               _mm_castsi128_ps(m128), S)                       \
                       : _mm_i32gather_ps((float const *)BASE, i128, S);                        \
            CHECK(f, 16);                                                                       \
            prepare(&g, 8, 4, 4, S, masked);                                                \
            LOAD(g);                                                                            \
            f8 = masked ? _mm256_mask_i32gather_ps(_mm256_castsi256_ps(s256), (float const *)BASE, \
                                                   i256, _mm256_castsi256_ps(m256), S)          \
                        : _mm256_i32gather_ps((float const *)BASE, i256, S);                    \
            CHECK(f8, 32);                                                                      \
            prepare(&g, 2, 8, 4, S, masked);                                                \
            LOAD(g);                                                                            \
            d = masked ? _mm_mask_i32gather_pd(_mm_castsi128_pd(s128), (double const *)BASE,    \
                                               i128, _mm_castsi128_pd(m128), S)                 \
                       : _mm_i32gather_pd((double const *)BASE, i128, S);                       \
            CHECK(d, 16);                                                                       \
            prepare(&g, 4, 8, 4, S, masked);                                                \
            LOAD(g);                                                                            \
            d4 = masked ? _mm256_mask_i32gather_pd(_mm256_castsi256_pd(s256),                   \
                                                   (double const *)BASE, i128,                  \
                                                   _mm256_castsi256_pd(m256), S)                \
                        : _mm256_i32gather_pd((double const *)BASE, i128, S);                   \
            CHECK(d4, 32);                                                                      \
            iw = 8;                                                                             \
            prepare(&g, 2, 4, 8, S, masked);                                                \
            LOAD(g);                                                                            \
            r128 = masked ? _mm_mask_i64gather_epi32(s128, (int const *)BASE, i128, m128, S)    \
                          : _mm_i64gather_epi32((int const *)BASE, i128, S);                    \
            CHECK(r128, 16);                                                                    \
            prepare(&g, 4, 4, 8, S, masked);                                                \
            LOAD(g);                                                                            \
            r128 = masked ? _mm256_mask_i64gather_epi32(s128, (int const *)BASE, i256, m128, S) \
                          : _mm256_i64gather_epi32((int const *)BASE, i256, S);                 \
            CHECK(r128, 16);                                                                    \
            prepare(&g, 2, 8, 8, S, masked);                                                \
            LOAD(g);                                                                            \
            r128 = masked ? _mm_mask_i64gather_epi64(s128, (long long const *)BASE, i128, m128, S) \
                          : _mm_i64gather_epi64((long long const *)BASE, i128, S);              \
            CHECK(r128, 16);                                                                    \
            prepare(&g, 4, 8, 8, S, masked);                                                \
            LOAD(g);                                                                            \
            r256 = masked ? _mm256_mask_i64gather_epi64(s256, (long long const *)BASE, i256,    \
                                                        m256, S)                                \
                          : _mm256_i64gather_epi64((long long const *)BASE, i256, S);           \
            CHECK(r256, 32);                                                                    \
            prepare(&g, 2, 4, 8, S, masked);                                                \
            LOAD(g);                                                                            \
            f = masked ? _mm_mask_i64gather_ps(_mm_castsi128_ps(s128), (float const *)BASE, i128, \
                                               _mm_castsi128_ps(m128), S)                       \
                       : _mm_i64gather_ps((float const *)BASE, i128, S);                        \
            CHECK(f, 16);                                                                       \
            prepare(&g, 4, 4, 8, S, masked);                                                \
            LOAD(g);                                                                            \
            f = masked ? _mm256_mask_i64gather_ps(_mm_castsi128_ps(s128), (float const *)BASE,  \
                                                  i256, _mm_castsi128_ps(m128), S)              \
                       : _mm256_i64gather_ps((float const *)BASE, i256, S);                     \
            CHECK(f, 16);                                                                       \
            prepare(&g, 2, 8, 8, S, masked);                                                \
            LOAD(g);                                                                            \
            d = masked ? _mm_mask_i64gather_pd(_mm_castsi128_pd(s128), (double const *)BASE,    \
                                               i128, _mm_castsi128_pd(m128), S)                 \
                       : _mm_i64gather_pd((double const *)BASE, i128, S);                       \
            CHECK(d, 16);                                                                       \
            prepare(&g, 4, 8, 8, S, masked);                                                \
            LOAD(g);                                                                            \
            d4 = masked ? _mm256_mask_i64gather_pd(_mm256_castsi256_pd(s256),                   \
                                                   (double const *)BASE, i256,                  \
                                                   _mm256_castsi256_pd(m256), S)                \
                        : _mm256_i64gather_pd((double const *)BASE, i256, S);                   \
            CHECK(d4, 32);                                                                      \
        }                                                                                       \
    } while (0)
    FORM(1);
    FORM(2);
    FORM(4);
    FORM(8);
    return fail;
}

// VPMASKMOV and VMASKMOVPS/PD: a lane moves where the mask lane's sign bit
// is set; a load gives zero elsewhere and a store leaves the memory.
static int check_masked_moves(void) {
    unsigned char mem[32], val[32], mask[32], want[32], buf[32];
    rnd(mem, 32);
    rnd(val, 32);
    rnd(mask, 32);
    int fail = 0;
    for (int w = 4; w <= 8; w += 4)
        for (int bytes = 16; bytes <= 32; bytes += 16) {
            for (int i = 0; i < bytes / w; i++)
                set_lane(want, w, i, mask[w * i + w - 1] & 0x80 ? get_lane(mem, w, i) : 0);
            __m128i m1, v1, r1;
            __m256i m2, v2, r2;
            memcpy(&m1, mask, 16);
            memcpy(&m2, mask, 32);
            memcpy(&v1, val, 16);
            memcpy(&v2, val, 32);
            if (w == 4 && bytes == 16) {
                r1 = _mm_maskload_epi32((int const *)mem, m1);
                __m128 f = _mm_maskload_ps((float const *)mem, m1);
                fail |= memcmp(&r1, want, 16) != 0 || memcmp(&f, want, 16) != 0;
            } else if (w == 4) {
                r2 = _mm256_maskload_epi32((int const *)mem, m2);
                __m256 f = _mm256_maskload_ps((float const *)mem, m2);
                fail |= memcmp(&r2, want, 32) != 0 || memcmp(&f, want, 32) != 0;
            } else if (bytes == 16) {
                r1 = _mm_maskload_epi64((long long const *)mem, m1);
                __m128d d = _mm_maskload_pd((double const *)mem, m1);
                fail |= memcmp(&r1, want, 16) != 0 || memcmp(&d, want, 16) != 0;
            } else {
                r2 = _mm256_maskload_epi64((long long const *)mem, m2);
                __m256d d = _mm256_maskload_pd((double const *)mem, m2);
                fail |= memcmp(&r2, want, 32) != 0 || memcmp(&d, want, 32) != 0;
            }
            for (int i = 0; i < bytes / w; i++)
                set_lane(want, w, i,
                         get_lane(mask[w * i + w - 1] & 0x80 ? val : mem, w, i));
            for (int form = 0; form < 2; form++) {
                memcpy(buf, mem, 32);
                if (w == 4 && bytes == 16) {
                    if (form)
                        _mm_maskstore_ps((float *)buf, m1, _mm_castsi128_ps(v1));
                    else
                        _mm_maskstore_epi32((int *)buf, m1, v1);
                } else if (w == 4) {
                    if (form)
                        _mm256_maskstore_ps((float *)buf, m2, _mm256_castsi256_ps(v2));
                    else
                        _mm256_maskstore_epi32((int *)buf, m2, v2);
                } else if (bytes == 16) {
                    if (form)
                        _mm_maskstore_pd((double *)buf, m1, _mm_castsi128_pd(v1));
                    else
                        _mm_maskstore_epi64((long long *)buf, m1, v1);
                } else {
                    if (form)
                        _mm256_maskstore_pd((double *)buf, m2, _mm256_castsi256_pd(v2));
                    else
                        _mm256_maskstore_epi64((long long *)buf, m2, v2);
                }
                fail |= memcmp(buf, want, (size_t)bytes) != 0 ||
                        memcmp(buf + bytes, mem + bytes, (size_t)(32 - bytes)) != 0;
            }
        }
    return fail ? 8 : 0;
}

// The 16-bit set forms take their lanes from the highest (set) or the
// lowest (setr); the extract zero-extends its word.
static int check_lane_access(void) {
    short w[16];
    for (int i = 0; i < 16; i++)
        w[i] = (short)next();
    long long q[4] = {(long long)next(), (long long)next(), (long long)next(), (long long)next()};
    __m256i s = _mm256_set_epi16(w[15], w[14], w[13], w[12], w[11], w[10], w[9], w[8], w[7],
                                 w[6], w[5], w[4], w[3], w[2], w[1], w[0]);
    __m256i r = _mm256_setr_epi16(w[0], w[1], w[2], w[3], w[4], w[5], w[6], w[7], w[8], w[9],
                                  w[10], w[11], w[12], w[13], w[14], w[15]);
    int fail = memcmp(&s, w, 32) != 0 || memcmp(&r, w, 32) != 0;
    __m256i e = _mm256_setr_epi64x(q[0], q[1], q[2], q[3]);
    fail |= memcmp(&e, q, 32) != 0;
    __m128i lo, hi;
    memcpy(&lo, q, 16);
    memcpy(&hi, q + 2, 16);
    __m256i m = _mm256_setr_m128i(lo, hi);
    fail |= memcmp(&m, q, 32) != 0;
    fail |= _mm256_extract_epi16(s, 0) != (unsigned short)w[0] ||
            _mm256_extract_epi16(s, 9) != (unsigned short)w[9] ||
            _mm256_extract_epi16(s, 15) != (unsigned short)w[15];
    short v[16];
    memcpy(v, w, 32);
    v[13] = (short)q[0];
    __m256i t = _mm256_insert_epi16(s, (int)q[0], 13);
    fail |= memcmp(&t, v, 32) != 0;
    int d;
    memcpy(&d, q, 4);
    fail |= _mm256_cvtsi256_si32(e) != d;
    return fail ? 16 : 0;
}

// The split transfers move the low half at the second pointer and the
// high at the first; the non-temporal transfers move what ordinary ones do.
static int check_transfers(void) {
    unsigned char h[32], l[32], both[32], out[64];
    rnd(h, 32);
    rnd(l, 32);
    memcpy(both, l, 16);
    memcpy(both + 16, h, 16);
    int fail = 0;
    __m256i a = _mm256_loadu2_m128i((__m128i_u const *)(h + 1), (__m128i_u const *)(l + 3));
    unsigned char want[32];
    memcpy(want, l + 3, 16);
    memcpy(want + 16, h + 1, 16);
    fail |= memcmp(&a, want, 32) != 0;
    __m256 f = _mm256_loadu2_m128((float const *)h, (float const *)l);
    __m256d d = _mm256_loadu2_m128d((double const *)h, (double const *)l);
    fail |= memcmp(&f, both, 32) != 0 || memcmp(&d, both, 32) != 0;
    memset(out, 0, 64);
    _mm256_storeu2_m128i((__m128i_u *)(out + 33), (__m128i_u *)(out + 5), a);
    fail |= memcmp(out + 5, want, 16) != 0 || memcmp(out + 33, want + 16, 16) != 0;
    memset(out, 0, 64);
    _mm256_storeu2_m128((float *)(out + 32), (float *)out, f);
    fail |= memcmp(out, both, 16) != 0 || memcmp(out + 32, both + 16, 16) != 0;
    memset(out, 0, 64);
    _mm256_storeu2_m128d((double *)(out + 32), (double *)out, d);
    fail |= memcmp(out, both, 16) != 0 || memcmp(out + 32, both + 16, 16) != 0;
    static __m256i slot[2];
    static __m256 fslot;
    static __m256d dslot;
    _mm256_stream_si256(&slot[1], a);
    fail |= memcmp(&slot[1], want, 32) != 0;
    __m256i b = _mm256_stream_load_si256(&slot[1]);
    __m256i c = _mm256_lddqu_si256((__m256i const *)both);
    fail |= memcmp(&b, want, 32) != 0 || memcmp(&c, both, 32) != 0;
    _mm256_stream_ps((float *)&fslot, f);
    _mm256_stream_pd((double *)&dslot, d);
    fail |= memcmp(&fslot, both, 32) != 0 || memcmp(&dslot, both, 32) != 0;
    return fail ? 32 : 0;
}

// VPTEST: ZF when the AND is zero, CF when the AND with the first operand
// complemented is; VTESTPS and VTESTPD the same over the sign bits alone.
static int check_tests(void) {
    unsigned char a[32], b[32];
    rnd(a, 32);
    rnd(b, 32);
    for (int i = 0; i < 32; i++)
        if (next() >> 62 == 0)
            b[i] &= (unsigned char)~a[i];
    int fail = 0;
    const unsigned char *ops[2] = {a, b};
    for (int p = 0; p < 4; p++) {
        const unsigned char *x = ops[p & 1], *y = ops[p >> 1];
        int z = 1, c = 1;
        for (int i = 0; i < 32; i++) {
            z &= (x[i] & y[i]) == 0;
            c &= (~x[i] & y[i] & 0xFF) == 0;
        }
        __m256i u, v;
        memcpy(&u, x, 32);
        memcpy(&v, y, 32);
        fail |= _mm256_testz_si256(u, v) != z || _mm256_testc_si256(u, v) != c ||
                _mm256_testnzc_si256(u, v) != (!z && !c);
        for (int w = 4; w <= 8; w += 4)
            for (int bytes = 16; bytes <= 32; bytes += 16) {
                int zs = 1, cs = 1;
                for (int i = w - 1; i < bytes; i += w) {
                    zs &= !(x[i] & y[i] & 0x80);
                    cs &= !(~x[i] & y[i] & 0x80);
                }
                int gz, gc, gn;
                if (w == 4 && bytes == 16) {
                    __m128 s, t;
                    memcpy(&s, x, 16);
                    memcpy(&t, y, 16);
                    gz = _mm_testz_ps(s, t), gc = _mm_testc_ps(s, t), gn = _mm_testnzc_ps(s, t);
                } else if (w == 4) {
                    __m256 s, t;
                    memcpy(&s, x, 32);
                    memcpy(&t, y, 32);
                    gz = _mm256_testz_ps(s, t), gc = _mm256_testc_ps(s, t);
                    gn = _mm256_testnzc_ps(s, t);
                } else if (bytes == 16) {
                    __m128d s, t;
                    memcpy(&s, x, 16);
                    memcpy(&t, y, 16);
                    gz = _mm_testz_pd(s, t), gc = _mm_testc_pd(s, t), gn = _mm_testnzc_pd(s, t);
                } else {
                    __m256d s, t;
                    memcpy(&s, x, 32);
                    memcpy(&t, y, 32);
                    gz = _mm256_testz_pd(s, t), gc = _mm256_testc_pd(s, t);
                    gn = _mm256_testnzc_pd(s, t);
                }
                fail |= gz != zs || gc != cs || gn != (!zs && !cs);
            }
    }
    return fail ? 64 : 0;
}

// VPERMILPS and VPERMILPD by a vector pick within each 128-bit lane, PS by
// the selector's low two bits and PD by its bit 1; VPERMPD and VPERMPS pick
// across the register. The 256-bit rounding and dot product work on each
// half as the 128-bit forms do.
static int check_permutes_and_halves(void) {
    unsigned a[8], c[8], want[8], got[8];
    for (int i = 0; i < 8; i++) {
        a[i] = (unsigned)next();
        c[i] = (unsigned)next();
    }
    __m256 x;
    __m256i k;
    memcpy(&x, a, 32);
    memcpy(&k, c, 32);
    int fail = 0;
    for (int i = 0; i < 8; i++)
        want[i] = a[(i & 4) | (c[i] & 3)];
    __m256 r = _mm256_permutevar_ps(x, k);
    memcpy(got, &r, 32);
    fail |= memcmp(got, want, 32) != 0;
    __m128 r1 = _mm_permutevar_ps(_mm256_castps256_ps128(x), _mm256_castsi256_si128(k));
    fail |= memcmp(&r1, want, 16) != 0;
    u64 qa[4], qc[4], qw[4], qg[4];
    memcpy(qa, a, 32);
    memcpy(qc, c, 32);
    for (int i = 0; i < 4; i++)
        qw[i] = qa[(i & 2) | (qc[i] >> 1 & 1)];
    __m256d d = _mm256_permutevar_pd(_mm256_castps_pd(x), k);
    memcpy(qg, &d, 32);
    fail |= memcmp(qg, qw, 32) != 0;
    __m128d d1 = _mm_permutevar_pd(_mm256_castpd256_pd128(_mm256_castps_pd(x)),
                                   _mm256_castsi256_si128(k));
    fail |= memcmp(&d1, qw, 16) != 0;
    for (int i = 0; i < 4; i++)
        qw[i] = qa[0x9C >> 2 * i & 3];
    d = _mm256_permute4x64_pd(_mm256_castps_pd(x), 0x9C);
    fail |= memcmp(&d, qw, 32) != 0;
    for (int i = 0; i < 8; i++)
        want[i] = a[c[i] & 7];
    r = _mm256_permutevar8x32_ps(x, k);
    fail |= memcmp(&r, want, 32) != 0;
    float v[8] = {2.5f, -2.5f, 0.5f, -0.75f, 7.0f, 1e30f, -3.25f, 16777215.0f};
    float near[8] = {2.0f, -2.0f, 0.0f, -1.0f, 7.0f, 1e30f, -3.0f, 16777215.0f};
    float down[8] = {2.0f, -3.0f, 0.0f, -1.0f, 7.0f, 1e30f, -4.0f, 16777215.0f};
    float up[8] = {3.0f, -2.0f, 1.0f, -0.0f, 7.0f, 1e30f, -3.0f, 16777215.0f};
    __m256 f;
    memcpy(&f, v, 32);
    __m256 n = _mm256_round_ps(f, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
    __m256 fl = _mm256_floor_ps(f), ce = _mm256_ceil_ps(f);
    fail |= memcmp(&n, near, 32) != 0 || memcmp(&fl, down, 32) != 0 || memcmp(&ce, up, 32) != 0;
    double dv[4] = {-0.5, 1.5, -1e-300, 4503599627370497.0};
    double dt[4] = {-0.0, 1.0, -0.0, 4503599627370497.0};
    double dc[4] = {-0.0, 2.0, -0.0, 4503599627370497.0};
    __m256d g;
    memcpy(&g, dv, 32);
    __m256d tr = _mm256_round_pd(g, _MM_FROUND_TO_ZERO), cp = _mm256_ceil_pd(g);
    __m256d fp = _mm256_floor_pd(g);
    double df[4] = {-1.0, 1.0, -1.0, 4503599627370497.0};
    fail |= memcmp(&tr, dt, 32) != 0 || memcmp(&cp, dc, 32) != 0 || memcmp(&fp, df, 32) != 0;
    float p[8] = {1, 2, 3, 4, 0.5f, -1, 8, 0.25f}, s[8] = {2, 3, 4, 5, 4, 4, -0.5f, 8};
    __m256 pa, pb;
    memcpy(&pa, p, 32);
    memcpy(&pb, s, 32);
    __m256 dp = _mm256_dp_ps(pa, pb, 0xB5);
    float dw[8] = {2 + 6 + 20, 0, 2 + 6 + 20, 0, 0, 0, 0, 0};
    fail |= memcmp(&dp, dw, 32) != 0;
    return fail ? 128 : 0;
}

int main(void) {
    for (int i = 0; i < 1024; i++)
        table[i] = (unsigned char)(next() >> 32);
    int fail = 0;
    for (int round = 0; round < 200; round++) {
        fail |= check_gathers(0);
        fail |= check_gathers(1);
        fail |= check_masked_moves();
        fail |= check_lane_access();
        fail |= check_transfers();
        fail |= check_tests();
        fail |= check_permutes_and_halves();
    }
    return fail;
}
#else
int main(void) {
    return 0;
}
#endif
