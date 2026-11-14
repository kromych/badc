/* <arm_neon.h> loads, stores, broadcasts, halves, lanes, reinterpretations,
 * permutes, vext, vrev and vbsl on every element type, 64- and 128-bit
 * forms, each run through a wrapper over byte buffers and checked against
 * the permutation of lanes the Arm ARM defines, as bytes so a NaN pattern
 * compares exactly. The exit code has a bit per failing group; elsewhere
 * than AArch64 the unit is empty. */
// snapshot-budget: exempt
#if defined(__aarch64__)
#include <arm_neon.h>
#include <string.h>

typedef void (*wrap_fn)(void *r_, const void *a_, const void *b_, const void *c_);
typedef int (*index_fn)(int i, int ns, int k);
struct test {
    wrap_fn fn;
    index_fn at; /* null: the bitwise select */
    int bit, k, nr, ns, es;
};

/* Result lane i is lane at(i, ns, k) of the concatenation a:b. */
static int at_same(int i, int ns, int k) { return i + 0 * (ns + k); }
static int at_lane(int i, int ns, int k) { return k + 0 * (i + ns); }
static int at_offset(int i, int ns, int k) { return k + i + 0 * ns; }
static int at_set(int i, int ns, int k) { return i == k ? ns : i; }
static int at_st1(int i, int ns, int k) { return i == 0 ? k : ns + i; }
static int at_rev(int i, int ns, int k) { return i / k * k + k - 1 - i % k + 0 * ns; }
static int at_zip1(int i, int ns, int k) { return (i % 2 ? ns : 0) + i / 2 + 0 * k; }
static int at_zip2(int i, int ns, int k) { return (i % 2 ? ns : 0) + ns / 2 + i / 2 + 0 * k; }
static int at_uzp1(int i, int ns, int k) { return 2 * i + 0 * (ns + k); }
static int at_uzp2(int i, int ns, int k) { return 2 * i + 1 + 0 * (ns + k); }
static int at_trn1(int i, int ns, int k) { return i % 2 ? ns + i - 1 + 0 * k : i; }
static int at_trn2(int i, int ns, int k) { return i % 2 ? ns + i + 0 * k : i + 1; }
static int at_zip(int i, int ns, int k) { return i < ns ? at_zip1(i, ns, k) : at_zip2(i - ns, ns, k); }
static int at_uzp(int i, int ns, int k) { return i < ns ? at_uzp1(i, ns, k) : at_uzp2(i - ns, ns, k); }
static int at_trn(int i, int ns, int k) { return i < ns ? at_trn1(i, ns, k) : at_trn2(i - ns, ns, k); }

#define LANES(T) ((int)(sizeof(T) / sizeof(((T){0})[0])))
#define ES(T) ((int)sizeof(((T){0})[0]))
#define PUT(e)                                                            \
    __auto_type v_ = (e);                                                 \
    typedef __typeof__(v_) __attribute__((may_alias)) tr_;                \
    *(tr_ *)r_ = v_;
/* A test: its wrapper, which reads a, b and c as types T, U and V from
 * 16-byte aligned buffers and runs body, and its table entry. */
#define WRAP(id, bit, at, k, nr, ns, es, T, U, V, body)                   \
    static void w_##id(void *r_, const void *a_, const void *b_, const void *c_) { \
        typedef T __attribute__((may_alias)) ta_;                         \
        typedef U __attribute__((may_alias)) tb_;                         \
        typedef V __attribute__((may_alias)) tc_;                         \
        T a = *(const ta_ *)a_;                                           \
        U b = *(const tb_ *)b_;                                           \
        V c = *(const tc_ *)c_;                                           \
        (void)a, (void)b, (void)c;                                        \
        body                                                              \
    }
#define ENTRY(id, bit, at, k, nr, ns, es, T, U, V, body) {w_##id, at, bit, k, nr, ns, es},

/* Rows: suffix, vectors, element, unsigned vectors of the same lanes. */
#define R_s8(F, ...) F(__VA_ARGS__, s8, int8x8_t, int8x16_t, int8_t, uint8x8_t, uint8x16_t)
#define R_u8(F, ...) F(__VA_ARGS__, u8, uint8x8_t, uint8x16_t, uint8_t, uint8x8_t, uint8x16_t)
#define R_p8(F, ...) F(__VA_ARGS__, p8, poly8x8_t, poly8x16_t, poly8_t, uint8x8_t, uint8x16_t)
#define R_s16(F, ...) F(__VA_ARGS__, s16, int16x4_t, int16x8_t, int16_t, uint16x4_t, uint16x8_t)
#define R_u16(F, ...) F(__VA_ARGS__, u16, uint16x4_t, uint16x8_t, uint16_t, uint16x4_t, uint16x8_t)
#define R_p16(F, ...) F(__VA_ARGS__, p16, poly16x4_t, poly16x8_t, poly16_t, uint16x4_t, uint16x8_t)
#define R_s32(F, ...) F(__VA_ARGS__, s32, int32x2_t, int32x4_t, int32_t, uint32x2_t, uint32x4_t)
#define R_u32(F, ...) F(__VA_ARGS__, u32, uint32x2_t, uint32x4_t, uint32_t, uint32x2_t, uint32x4_t)
#define R_f32(F, ...) F(__VA_ARGS__, f32, float32x2_t, float32x4_t, float32_t, uint32x2_t, uint32x4_t)
#define R_s64(F, ...) F(__VA_ARGS__, s64, int64x1_t, int64x2_t, int64_t, uint64x1_t, uint64x2_t)
#define R_u64(F, ...) F(__VA_ARGS__, u64, uint64x1_t, uint64x2_t, uint64_t, uint64x1_t, uint64x2_t)
#define R_p64(F, ...) F(__VA_ARGS__, p64, poly64x1_t, poly64x2_t, poly64_t, uint64x1_t, uint64x2_t)
#define R_f64(F, ...) F(__VA_ARGS__, f64, float64x1_t, float64x2_t, float64_t, uint64x1_t, uint64x2_t)
#define MULTI(F, ...)                                                     \
    R_s8(F, __VA_ARGS__) R_u8(F, __VA_ARGS__) R_p8(F, __VA_ARGS__)        \
    R_s16(F, __VA_ARGS__) R_u16(F, __VA_ARGS__) R_p16(F, __VA_ARGS__)     \
    R_s32(F, __VA_ARGS__) R_u32(F, __VA_ARGS__) R_f32(F, __VA_ARGS__)
#define SINGLE(F, ...)                                                    \
    R_s64(F, __VA_ARGS__) R_u64(F, __VA_ARGS__) R_p64(F, __VA_ARGS__) R_f64(F, __VA_ARGS__)
#define ALL(F, ...) MULTI(F, __VA_ARGS__) SINGLE(F, __VA_ARGS__)

/* Loads, stores and their single-lane and replicating forms. */
#define MEM1(X, s, T, E, q)                                               \
    X(vld1##q##_##s, 1, at_same, 0, LANES(T), LANES(T), ES(T), T, T, T,   \
      PUT(vld1##q##_##s((const E *)a_)))                                  \
    X(vst1##q##_##s, 1, at_same, 0, LANES(T), LANES(T), ES(T), T, T, T,   \
      vst1##q##_##s((E *)r_, a);)                                         \
    X(vld1##q##_dup_##s, 1, at_lane, 0, LANES(T), LANES(T), ES(T), T, T, T, \
      PUT(vld1##q##_dup_##s((const E *)a_)))                              \
    X(vld1##q##_lane_##s, 1, at_set, LANES(T) - 1, LANES(T), LANES(T), ES(T), T, T, T, \
      PUT(vld1##q##_lane_##s((const E *)b_, a, LANES(T) - 1)))            \
    X(vst1##q##_lane_##s, 1, at_st1, LANES(T) - 1, LANES(T), LANES(T), ES(T), T, T, T, \
      *(tb_ *)r_ = b; vst1##q##_lane_##s((E *)r_, a, LANES(T) - 1);)
#define MEM(X, s, D, Q, E, ...) MEM1(X, s, D, E, ) MEM1(X, s, Q, E, q)

/* Broadcasts of a scalar and of a lane, halves, lane reads and writes. */
#define DUP(X, s, D, Q, E, ...)                                           \
    X(vdup_n_##s, 2, at_lane, 0, LANES(D), LANES(D), ES(D), D, D, D, PUT(vdup_n_##s(a[0]))) \
    X(vmovq_n_##s, 2, at_lane, 0, LANES(Q), LANES(Q), ES(Q), Q, Q, Q, PUT(vmovq_n_##s(a[0]))) \
    X(vdup_lane_##s, 2, at_lane, LANES(D) - 1, LANES(D), LANES(D), ES(D), D, D, D, \
      PUT(vdup_lane_##s(a, LANES(D) - 1)))                                \
    X(vdupq_lane_##s, 2, at_lane, 0, LANES(Q), LANES(D), ES(D), D, D, D,  \
      PUT(vdupq_lane_##s(a, 0)))                                          \
    X(vdup_laneq_##s, 2, at_lane, LANES(Q) - 1, LANES(D), LANES(Q), ES(D), Q, Q, Q, \
      PUT(vdup_laneq_##s(a, LANES(Q) - 1)))                               \
    X(vdupq_laneq_##s, 2, at_lane, LANES(Q) / 2, LANES(Q), LANES(Q), ES(Q), Q, Q, Q, \
      PUT(vdupq_laneq_##s(a, LANES(Q) / 2)))
#define HALF(X, s, D, Q, E, ...)                                          \
    X(vget_low_##s, 4, at_same, 0, LANES(D), LANES(Q), ES(D), Q, Q, Q, PUT(vget_low_##s(a))) \
    X(vget_high_##s, 4, at_offset, LANES(D), LANES(D), LANES(Q), ES(D), Q, Q, Q, \
      PUT(vget_high_##s(a)))                                              \
    X(vcombine_##s, 4, at_same, 0, LANES(Q), LANES(D), ES(D), D, D, D, PUT(vcombine_##s(a, b))) \
    X(vget_lane_##s, 4, at_lane, LANES(D) - 1, 1, LANES(D), ES(D), D, D, D, \
      PUT(vget_lane_##s(a, LANES(D) - 1)))                                \
    X(vgetq_lane_##s, 4, at_lane, 1, 1, LANES(Q), ES(Q), Q, Q, Q, PUT(vgetq_lane_##s(a, 1))) \
    X(vset_lane_##s, 4, at_set, 0, LANES(D), LANES(D), ES(D), D, D, D,    \
      PUT(vset_lane_##s(b[0], a, 0)))                                     \
    X(vsetq_lane_##s, 4, at_set, LANES(Q) - 1, LANES(Q), LANES(Q), ES(Q), Q, Q, Q, \
      PUT(vsetq_lane_##s(b[0], a, LANES(Q) - 1)))

/* Reinterpretations keep the bytes; each pair of rows once, both ways.
 * AFTER_x names the rows after x. */
#define CAST(X, a0, A, AQ, E, UA, UAQ, b0, B, BQ, ...)                    \
    X(vreinterpret_##a0##_##b0, 8, at_same, 0, 8, 8, 1, B, B, B, PUT(vreinterpret_##a0##_##b0(a))) \
    X(vreinterpret_##b0##_##a0, 8, at_same, 0, 8, 8, 1, A, A, A, PUT(vreinterpret_##b0##_##a0(a))) \
    X(vreinterpretq_##a0##_##b0, 8, at_same, 0, 16, 16, 1, BQ, BQ, BQ,    \
      PUT(vreinterpretq_##a0##_##b0(a)))                                  \
    X(vreinterpretq_##b0##_##a0, 8, at_same, 0, 16, 16, 1, AQ, AQ, AQ,    \
      PUT(vreinterpretq_##b0##_##a0(a)))
#define CASTS(X, a0, A, AQ, ...)                                          \
    AFTER_##a0(CAST, X, a0, A, AQ, __VA_ARGS__)                           \
    X(vreinterpretq_p128_##a0, 8, at_same, 0, 16, 16, 1, AQ, AQ, AQ,      \
      PUT(vreinterpretq_p128_##a0(a)))                                    \
    X(vreinterpretq_##a0##_p128, 8, at_same, 0, 16, 16, 1, poly128_t, poly128_t, poly128_t, \
      PUT(vreinterpretq_##a0##_p128(a)))
#define AFTER_s8(F, ...) R_u8(F, __VA_ARGS__) AFTER_u8(F, __VA_ARGS__)
#define AFTER_u8(F, ...) R_p8(F, __VA_ARGS__) AFTER_p8(F, __VA_ARGS__)
#define AFTER_p8(F, ...) R_s16(F, __VA_ARGS__) AFTER_s16(F, __VA_ARGS__)
#define AFTER_s16(F, ...) R_u16(F, __VA_ARGS__) AFTER_u16(F, __VA_ARGS__)
#define AFTER_u16(F, ...) R_p16(F, __VA_ARGS__) AFTER_p16(F, __VA_ARGS__)
#define AFTER_p16(F, ...) R_s32(F, __VA_ARGS__) AFTER_s32(F, __VA_ARGS__)
#define AFTER_s32(F, ...) R_u32(F, __VA_ARGS__) AFTER_u32(F, __VA_ARGS__)
#define AFTER_u32(F, ...) R_f32(F, __VA_ARGS__) AFTER_f32(F, __VA_ARGS__)
#define AFTER_f32(F, ...) R_s64(F, __VA_ARGS__) AFTER_s64(F, __VA_ARGS__)
#define AFTER_s64(F, ...) R_u64(F, __VA_ARGS__) AFTER_u64(F, __VA_ARGS__)
#define AFTER_u64(F, ...) R_p64(F, __VA_ARGS__) AFTER_p64(F, __VA_ARGS__)
#define AFTER_p64(F, ...) R_f64(F, __VA_ARGS__)
#define AFTER_f64(F, ...)

/* Permutes (128-bit only for a single-lane type), the pairs, vext, the
 * reversals in groups of g bits, and the bitwise select. */
#define PERM1(X, op, T, at) X(op, 16, at, 0, LANES(T), LANES(T), ES(T), T, T, T, PUT(op(a, b)))
#define PERMQ(X, s, D, Q, ...)                                            \
    PERM1(X, vzip1q_##s, Q, at_zip1) PERM1(X, vzip2q_##s, Q, at_zip2)     \
    PERM1(X, vuzp1q_##s, Q, at_uzp1) PERM1(X, vuzp2q_##s, Q, at_uzp2)     \
    PERM1(X, vtrn1q_##s, Q, at_trn1) PERM1(X, vtrn2q_##s, Q, at_trn2)
#define PAIR1(X, op, T, at) X(op, 16, at, 0, 2 * LANES(T), LANES(T), ES(T), T, T, T, PUT(op(a, b)))
#define PERMS(X, s, D, Q, ...)                                            \
    PERMQ(X, s, D, Q, __VA_ARGS__)                                        \
    PERM1(X, vzip1_##s, D, at_zip1) PERM1(X, vzip2_##s, D, at_zip2)       \
    PERM1(X, vuzp1_##s, D, at_uzp1) PERM1(X, vuzp2_##s, D, at_uzp2)       \
    PERM1(X, vtrn1_##s, D, at_trn1) PERM1(X, vtrn2_##s, D, at_trn2)       \
    PAIR1(X, vzip_##s, D, at_zip) PAIR1(X, vzipq_##s, Q, at_zip)          \
    PAIR1(X, vuzp_##s, D, at_uzp) PAIR1(X, vuzpq_##s, Q, at_uzp)          \
    PAIR1(X, vtrn_##s, D, at_trn) PAIR1(X, vtrnq_##s, Q, at_trn)
#define EXT(X, s, D, Q, ...)                                              \
    X(vext_##s, 32, at_offset, LANES(D) - 1, LANES(D), LANES(D), ES(D), D, D, D, \
      PUT(vext_##s(a, b, LANES(D) - 1)))                                  \
    X(vextq_##s, 32, at_offset, 1, LANES(Q), LANES(Q), ES(Q), Q, Q, Q, PUT(vextq_##s(a, b, 1)))
#define REV(X, g, s, D, Q, ...)                                           \
    X(vrev##g##_##s, 32, at_rev, g / 8 / ES(D), LANES(D), LANES(D), ES(D), D, D, D, \
      PUT(vrev##g##_##s(a)))                                              \
    X(vrev##g##q_##s, 32, at_rev, g / 8 / ES(Q), LANES(Q), LANES(Q), ES(Q), Q, Q, Q, \
      PUT(vrev##g##q_##s(a)))
#define BSL(X, s, D, Q, E, UD, UQ)                                        \
    X(vbsl_##s, 64, 0, 0, 8, 8, 1, UD, D, D, PUT(vbsl_##s(a, b, c)))      \
    X(vbslq_##s, 64, 0, 0, 16, 16, 1, UQ, Q, Q, PUT(vbslq_##s(a, b, c)))

#define TESTS(X)                                                          \
    ALL(MEM, X) ALL(DUP, X) ALL(HALF, X) ALL(CASTS, X) MULTI(PERMS, X)    \
    SINGLE(PERMQ, X) ALL(EXT, X) ALL(BSL, X)                              \
    R_s8(REV, X, 16) R_u8(REV, X, 16) R_p8(REV, X, 16)                    \
    R_s8(REV, X, 32) R_u8(REV, X, 32) R_p8(REV, X, 32)                    \
    R_s16(REV, X, 32) R_u16(REV, X, 32) R_p16(REV, X, 32) MULTI(REV, X, 64)
TESTS(WRAP)
static const struct test tests[] = {TESTS(ENTRY)};

static unsigned char pat[64] __attribute__((aligned(16)));

int main(void) {
    unsigned x = 0x6A09E667u;
    for (unsigned i = 0; i < sizeof pat; i++) {
        x ^= x << 13;
        x ^= x >> 17;
        x ^= x << 5;
        pat[i] = (unsigned char)(x >> 7);
    }
    int fails = 0;
    for (unsigned t = 0; t < sizeof tests / sizeof tests[0]; t++) {
        const struct test *e = &tests[t];
        for (int j = 0; j < 4; j++) {
            const unsigned char *a = pat + 16 * j, *b = pat + 16 * ((j + 1) % 4);
            const unsigned char *c = pat + 16 * ((j + 2) % 4);
            unsigned char r[32] __attribute__((aligned(16))) = {0}, ab[32];
            e->fn(r, a, b, c);
            memcpy(ab, a, (size_t)(e->ns * e->es));
            memcpy(ab + e->ns * e->es, b, (size_t)(e->ns * e->es));
            for (int i = 0; i < e->nr * e->es; i++) {
                int want = e->at ? ab[e->at(i / e->es, e->ns, e->k) * e->es + i % e->es]
                                 : ((a[i] & b[i]) | (~a[i] & c[i])) & 0xFF;
                if (r[i] != want)
                    fails |= e->bit;
            }
        }
    }
    return fails;
}
#else
int main(void) {
    return 0;
}
#endif
