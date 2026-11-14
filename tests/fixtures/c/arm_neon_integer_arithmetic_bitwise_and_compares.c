/* <arm_neon.h> integer arithmetic, saturating, halving, pairwise, bitwise,
 * bit-count and compare operations on every element type they are defined
 * for, 64- and 128-bit forms. Each intrinsic runs through a wrapper over
 * byte buffers; its lanes are checked against the operation the Arm ARM
 * defines, computed in 128-bit integers over edge and pseudo-random inputs.
 * The exit code has a bit per failing group; elsewhere than AArch64 the
 * unit is empty. */
// snapshot-budget: exempt
#if defined(__aarch64__)
#include <arm_neon.h>
#include <string.h>

typedef __int128 i128;
typedef unsigned __int128 u128;
typedef void (*wrap_fn)(void *r_, const void *a_, const void *b_, const void *c_);
enum {
    O_ADD, O_SUB, O_MUL, O_MLA, O_MLS, O_QADD, O_QSUB, O_NEG, O_ABS, O_QNEG, O_QABS,
    O_HADD, O_RHADD, O_HSUB, O_ABD, O_ABA, O_MAX, O_MIN, O_PADD, O_PMAX, O_PMIN,
    O_AND, O_ORR, O_EOR, O_BIC, O_ORN, O_MVN, O_BSL, O_CNT, O_CLZ, O_CLS,
    O_EQ, O_GE, O_GT, O_LE, O_LT, O_TST
};
struct test {
    wrap_fn fn;
    int bit, op, w, s, n;
};

#define LANES(T) ((int)(sizeof(T) / sizeof(((T){0})[0])))
#define PUT(e)                                                            \
    __auto_type v_ = (e);                                                 \
    typedef __typeof__(v_) __attribute__((may_alias)) tr_;                \
    *(tr_ *)r_ = v_;
/* A test: its wrapper, which reads a, b and c as types T, U and V from
 * 16-byte aligned buffers and runs body, and its table entry; the lanes
 * are w bits wide and signed when s. */
#define WRAP(id, bit, op, w, s, T, U, V, body)                            \
    static void w_##id(void *r_, const void *a_, const void *b_, const void *c_) { \
        typedef T __attribute__((may_alias)) ta_;                         \
        typedef U __attribute__((may_alias)) tb_;                         \
        typedef V __attribute__((may_alias)) tc_;                         \
        T a = *(const ta_ *)a_;                                           \
        U b = *(const tb_ *)b_;                                           \
        V c = *(const tc_ *)c_;                                           \
        (void)b, (void)c;                                                 \
        body                                                              \
    }
#define ENTRY(id, bit, op, w, s, T, U, V, body) {w_##id, bit, op, w, s, LANES(T)},

/* Rows: suffix, the 64- and 128-bit vectors, the lane width and sign, the
 * unsigned vectors of the same lanes. */
#define S8_32(F, ...)                                                     \
    F(__VA_ARGS__, s8, int8x8_t, int8x16_t, 8, 1, uint8x8_t, uint8x16_t)  \
    F(__VA_ARGS__, s16, int16x4_t, int16x8_t, 16, 1, uint16x4_t, uint16x8_t) \
    F(__VA_ARGS__, s32, int32x2_t, int32x4_t, 32, 1, uint32x2_t, uint32x4_t)
#define U8_32(F, ...)                                                     \
    F(__VA_ARGS__, u8, uint8x8_t, uint8x16_t, 8, 0, uint8x8_t, uint8x16_t) \
    F(__VA_ARGS__, u16, uint16x4_t, uint16x8_t, 16, 0, uint16x4_t, uint16x8_t) \
    F(__VA_ARGS__, u32, uint32x2_t, uint32x4_t, 32, 0, uint32x2_t, uint32x4_t)
#define S64(F, ...) F(__VA_ARGS__, s64, int64x1_t, int64x2_t, 64, 1, uint64x1_t, uint64x2_t)
#define U64(F, ...) F(__VA_ARGS__, u64, uint64x1_t, uint64x2_t, 64, 0, uint64x1_t, uint64x2_t)
#define INT8_32(F, ...) S8_32(F, __VA_ARGS__) U8_32(F, __VA_ARGS__)
#define INT(F, ...) INT8_32(F, __VA_ARGS__) S64(F, __VA_ARGS__) U64(F, __VA_ARGS__)
#define SINT(F, ...) S8_32(F, __VA_ARGS__) S64(F, __VA_ARGS__)

/* The 64- and 128-bit forms of f over one, two or three operands. */
#define T1(X, bit, op, f, s, D, Q, w, sg, ...)                            \
    X(f##_##s, bit, op, w, sg, D, D, D, PUT(f##_##s(a)))                  \
    X(f##q_##s, bit, op, w, sg, Q, Q, Q, PUT(f##q_##s(a)))
#define T2(X, bit, op, f, s, D, Q, w, sg, ...)                            \
    X(f##_##s, bit, op, w, sg, D, D, D, PUT(f##_##s(a, b)))               \
    X(f##q_##s, bit, op, w, sg, Q, Q, Q, PUT(f##q_##s(a, b)))
#define T2Q(X, bit, op, f, s, D, Q, w, sg, ...) X(f##q_##s, bit, op, w, sg, Q, Q, Q, PUT(f##q_##s(a, b)))
#define T3(X, bit, op, f, s, D, Q, w, sg, ...)                            \
    X(f##_##s, bit, op, w, sg, D, D, D, PUT(f##_##s(a, b, c)))            \
    X(f##q_##s, bit, op, w, sg, Q, Q, Q, PUT(f##q_##s(a, b, c)))
#define TBSL(X, bit, op, f, s, D, Q, w, sg, UD, UQ)                       \
    X(f##_##s, bit, op, w, sg, UD, D, D, PUT(f##_##s(a, b, c)))           \
    X(f##q_##s, bit, op, w, sg, UQ, Q, Q, PUT(f##q_##s(a, b, c)))

#define TESTS(X)                                                          \
    INT(T2, X, 1, O_ADD, vadd) INT(T2, X, 1, O_SUB, vsub) INT8_32(T2, X, 1, O_MUL, vmul) \
    INT8_32(T3, X, 1, O_MLA, vmla) INT8_32(T3, X, 1, O_MLS, vmls)        \
    INT(T2, X, 2, O_QADD, vqadd) INT(T2, X, 2, O_QSUB, vqsub)            \
    SINT(T1, X, 2, O_NEG, vneg) SINT(T1, X, 2, O_ABS, vabs)              \
    SINT(T1, X, 2, O_QNEG, vqneg) SINT(T1, X, 2, O_QABS, vqabs)          \
    INT8_32(T2, X, 4, O_HADD, vhadd) INT8_32(T2, X, 4, O_RHADD, vrhadd)  \
    INT8_32(T2, X, 4, O_HSUB, vhsub) INT8_32(T2, X, 4, O_ABD, vabd)      \
    INT8_32(T3, X, 4, O_ABA, vaba)                                        \
    INT8_32(T2, X, 8, O_MAX, vmax) INT8_32(T2, X, 8, O_MIN, vmin)        \
    INT8_32(T2, X, 8, O_PADD, vpadd) S64(T2Q, X, 8, O_PADD, vpadd) U64(T2Q, X, 8, O_PADD, vpadd) \
    INT8_32(T2, X, 8, O_PMAX, vpmax) INT8_32(T2, X, 8, O_PMIN, vpmin)    \
    INT(T2, X, 16, O_AND, vand) INT(T2, X, 16, O_ORR, vorr) INT(T2, X, 16, O_EOR, veor) \
    INT(T2, X, 16, O_BIC, vbic) INT(T2, X, 16, O_ORN, vorn) INT8_32(T1, X, 16, O_MVN, vmvn) \
    INT(TBSL, X, 16, O_BSL, vbsl)                                         \
    X(vcnt_s8, 32, O_CNT, 8, 1, int8x8_t, int8x8_t, int8x8_t, PUT(vcnt_s8(a))) \
    X(vcntq_u8, 32, O_CNT, 8, 0, uint8x16_t, uint8x16_t, uint8x16_t, PUT(vcntq_u8(a))) \
    X(vcnt_p8, 32, O_CNT, 8, 0, poly8x8_t, poly8x8_t, poly8x8_t, PUT(vcnt_p8(a))) \
    INT8_32(T1, X, 32, O_CLZ, vclz) S8_32(T1, X, 32, O_CLS, vcls)        \
    INT(T2, X, 64, O_EQ, vceq) INT(T2, X, 64, O_GE, vcge) INT(T2, X, 64, O_GT, vcgt) \
    INT(T2, X, 64, O_LE, vcle) INT(T2, X, 64, O_LT, vclt) INT(T2, X, 64, O_TST, vtst)
TESTS(WRAP)
static const struct test tests[] = {TESTS(ENTRY)};

/* Lane i of the w-bit lanes at p, sign-extended when s. */
static i128 lane(const unsigned char *p, int i, int w, int s) {
    u128 u = 0;
    memcpy(&u, p + i * w / 8, (size_t)(w / 8));
    if (s && (u >> (w - 1)) & 1)
        u |= ~(u128)0 << w;
    return (i128)u;
}

static int clz_of(i128 v, int w) {
    int n = 0;
    for (int b = w - 1; b >= 0 && !((v >> b) & 1); b--)
        n++;
    return n;
}

static i128 sat(i128 v, i128 lo, i128 hi) {
    return v < lo ? lo : v > hi ? hi : v;
}

static i128 model(int op, i128 x, i128 y, i128 z, int w, int s) {
    i128 lo = s ? -((i128)1 << (w - 1)) : 0;
    i128 hi = s ? ((i128)1 << (w - 1)) - 1 : ((i128)1 << w) - 1;
    switch (op) {
    case O_ADD: case O_PADD: return x + y;
    case O_SUB: return x - y;
    case O_MUL: return x * y;
    case O_MLA: return x + y * z;
    case O_MLS: return x - y * z;
    case O_QADD: return sat(x + y, lo, hi);
    case O_QSUB: return sat(x - y, lo, hi);
    case O_NEG: return -x;
    case O_ABS: return x < 0 ? -x : x;
    case O_QNEG: return sat(-x, lo, hi);
    case O_QABS: return sat(x < 0 ? -x : x, lo, hi);
    case O_HADD: return (x + y) >> 1;
    case O_RHADD: return (x + y + 1) >> 1;
    case O_HSUB: return (x - y) >> 1;
    case O_ABD: return x > y ? x - y : y - x;
    case O_ABA: return x + (y > z ? y - z : z - y);
    case O_MAX: case O_PMAX: return x > y ? x : y;
    case O_MIN: case O_PMIN: return x < y ? x : y;
    case O_AND: return x & y;
    case O_ORR: return x | y;
    case O_EOR: return x ^ y;
    case O_BIC: return x & ~y;
    case O_ORN: return x | ~y;
    case O_MVN: return ~x;
    case O_BSL: return (x & y) | (~x & z);
    case O_CNT: return __builtin_popcount((unsigned)(x & 0xFF));
    case O_CLZ: return clz_of(x, w);
    case O_CLS: return clz_of(x ^ (x >> 1), w) - 1;
    case O_EQ: return -(i128)(x == y);
    case O_GE: return -(i128)(x >= y);
    case O_GT: return -(i128)(x > y);
    case O_LE: return -(i128)(x <= y);
    case O_LT: return -(i128)(x < y);
    default: return -(i128)((x & y) != 0);
    }
}

enum { ROWS = 6 };
static unsigned char pat[16 * ROWS] __attribute__((aligned(16)));

int main(void) {
    static const unsigned char edges[32] = {
        0,    0,    0,    0,    0,    0,    0,    0x80, 0xFF, 0xFF, 0xFF,
        0xFF, 0xFF, 0xFF, 0xFF, 0x7F, 0x01, 0x00, 0x00, 0x00, 0xFF, 0xFF,
        0xFF, 0xFF, 0x81, 0x80, 0x00, 0x80, 0x7F, 0x7F, 0xFE, 0x00};
    memcpy(pat, edges, sizeof edges);
    unsigned x = 0x9E3779B9u;
    for (unsigned i = sizeof edges; i < sizeof pat; i++) {
        x ^= x << 13;
        x ^= x >> 17;
        x ^= x << 5;
        pat[i] = (unsigned char)(x >> 3);
    }
    int fails = 0;
    for (unsigned t = 0; t < sizeof tests / sizeof tests[0]; t++) {
        const struct test *e = &tests[t];
        int pairwise = e->op == O_PADD || e->op == O_PMAX || e->op == O_PMIN;
        for (int j = 0; j < ROWS; j++)
            for (int k = 0; k < ROWS; k++) {
                const unsigned char *a = pat + 16 * j, *b = pat + 16 * k;
                const unsigned char *c = pat + 16 * ((j + k) % ROWS);
                unsigned char r[16] __attribute__((aligned(16))), ab[32];
                e->fn(r, a, b, c);
                memcpy(ab, a, (size_t)(e->n * e->w / 8));
                memcpy(ab + e->n * e->w / 8, b, (size_t)(e->n * e->w / 8));
                for (int i = 0; i < e->n; i++) {
                    i128 m = pairwise ? model(e->op, lane(ab, 2 * i, e->w, e->s),
                                              lane(ab, 2 * i + 1, e->w, e->s), 0, e->w, e->s)
                                      : model(e->op, lane(a, i, e->w, e->s), lane(b, i, e->w, e->s),
                                              lane(c, i, e->w, e->s), e->w, e->s);
                    u128 mask = ((u128)1 << e->w) - 1;
                    if (((u128)m ^ (u128)lane(r, i, e->w, 0)) & mask)
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
