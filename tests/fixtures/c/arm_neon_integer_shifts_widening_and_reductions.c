/* <arm_neon.h> integer shifts by register and immediate, narrowing and
 * widening, and across-lane reductions on every element type they are
 * defined for. Each intrinsic runs through a wrapper over byte buffers; its
 * lanes are checked against the operation the Arm ARM defines, computed in
 * 128-bit integers. The exit code has a bit per failing group; elsewhere
 * than AArch64 the unit is empty. */
// snapshot-budget: exempt
#if defined(__aarch64__)
#include <arm_neon.h>
#include <string.h>

typedef __int128 i128;
typedef unsigned __int128 u128;
typedef void (*wrap_fn)(void *r_, const void *a_, const void *b_, const void *c_);
enum {
    O_SHL_R, O_RSHL_R, O_QSHL_R, O_SHL, O_QSHL, O_SHR, O_RSHR, O_SRA, O_RSRA, O_SLI, O_SRI,
    O_MOVN, O_QMOVN, O_QMOVUN, O_SHRN, O_RSHRN, O_MOVN_H, O_QMOVN_H, O_QMOVUN_H,
    O_ADDL, O_SUBL, O_MULL, O_MLAL, O_MLSL, O_ADDW, O_SUBW, O_MOVL, O_PADDL,
    O_ADDV, O_ADDLV, O_MAXV, O_MINV
};
struct test {
    wrap_fn fn;
    int bit, op, w, s, n, imm, hi;
};

#define LANES(T) ((int)(sizeof(T) / sizeof(((T){0})[0])))
#define PUT(e)                                                            \
    __auto_type v_ = (e);                                                 \
    typedef __typeof__(v_) __attribute__((may_alias)) tr_;                \
    *(tr_ *)r_ = v_;
/* A test: its wrapper, which reads a, b and c as types T, U and V from
 * 16-byte aligned buffers and runs body, and its table entry: a's lanes are
 * w bits wide and signed when s, the result has n lanes. */
#define WRAP(id, bit, op, w, s, n, imm, hi, T, U, V, body)                \
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
#define ENTRY(id, bit, op, w, s, n, imm, hi, T, U, V, body) {w_##id, bit, op, w, s, n, imm, hi},

/* Rows: suffix, the 64- and 128-bit vectors, the signed vectors of the same
 * lanes, the lane width and sign. */
#define INT(F, ...)                                                       \
    F(__VA_ARGS__, s8, int8x8_t, int8x16_t, int8x8_t, int8x16_t, 8, 1)   \
    F(__VA_ARGS__, u8, uint8x8_t, uint8x16_t, int8x8_t, int8x16_t, 8, 0) \
    F(__VA_ARGS__, s16, int16x4_t, int16x8_t, int16x4_t, int16x8_t, 16, 1) \
    F(__VA_ARGS__, u16, uint16x4_t, uint16x8_t, int16x4_t, int16x8_t, 16, 0) \
    F(__VA_ARGS__, s32, int32x2_t, int32x4_t, int32x2_t, int32x4_t, 32, 1) \
    F(__VA_ARGS__, u32, uint32x2_t, uint32x4_t, int32x2_t, int32x4_t, 32, 0) \
    F(__VA_ARGS__, s64, int64x1_t, int64x2_t, int64x1_t, int64x2_t, 64, 1) \
    F(__VA_ARGS__, u64, uint64x1_t, uint64x2_t, int64x1_t, int64x2_t, 64, 0)
/* Shifts by register (the count is the low byte of b's lane) and by
 * immediate: the left ones take [0, w - 1], the right ones [1, w]. */
#define REG(X, op, f, s, D, Q, SD, SQ, w, sg)                             \
    X(f##_##s, 1, op, w, sg, LANES(D), 0, 0, D, SD, D, PUT(f##_##s(a, b))) \
    X(f##q_##s, 1, op, w, sg, LANES(Q), 0, 0, Q, SQ, Q, PUT(f##q_##s(a, b)))
#define IMM1(X, id, bit, op, f, T, n, w, sg, ...)                         \
    X(id, bit, op, w, sg, LANES(T), n, 0, T, T, T, PUT(f(__VA_ARGS__ n)))
#define IMM(X, bit, op, left, f, s, D, Q, SD, SQ, w, sg, ...)             \
    IMM1(X, f##_n_##s##_lo, bit, op, f##_n_##s, D, !(left), w, sg, __VA_ARGS__) \
    IMM1(X, f##_n_##s##_mid, bit, op, f##_n_##s, D, 3, w, sg, __VA_ARGS__) \
    IMM1(X, f##_n_##s##_hi, bit, op, f##_n_##s, D, w - (left), w, sg, __VA_ARGS__) \
    IMM1(X, f##q_n_##s##_lo, bit, op, f##q_n_##s, Q, !(left), w, sg, __VA_ARGS__) \
    IMM1(X, f##q_n_##s##_mid, bit, op, f##q_n_##s, Q, 5, w, sg, __VA_ARGS__) \
    IMM1(X, f##q_n_##s##_hi, bit, op, f##q_n_##s, Q, w - (left), w, sg, __VA_ARGS__)
#define SHIFTS(X, s, D, Q, SD, SQ, w, sg)                                 \
    REG(X, O_SHL_R, vshl, s, D, Q, SD, SQ, w, sg)                         \
    REG(X, O_RSHL_R, vrshl, s, D, Q, SD, SQ, w, sg)                       \
    REG(X, O_QSHL_R, vqshl, s, D, Q, SD, SQ, w, sg)                       \
    IMM(X, 2, O_SHL, 1, vshl, s, D, Q, SD, SQ, w, sg, a, )                \
    IMM(X, 2, O_QSHL, 1, vqshl, s, D, Q, SD, SQ, w, sg, a, )              \
    IMM(X, 2, O_SHR, 0, vshr, s, D, Q, SD, SQ, w, sg, a, )                \
    IMM(X, 2, O_RSHR, 0, vrshr, s, D, Q, SD, SQ, w, sg, a, )              \
    IMM(X, 4, O_SRA, 0, vsra, s, D, Q, SD, SQ, w, sg, b, a, )             \
    IMM(X, 4, O_RSRA, 0, vrsra, s, D, Q, SD, SQ, w, sg, b, a, )           \
    IMM(X, 4, O_SLI, 1, vsli, s, D, Q, SD, SQ, w, sg, b, a, )             \
    IMM(X, 4, O_SRI, 0, vsri, s, D, Q, SD, SQ, w, sg, b, a, )

/* Rows of a narrow type and its double: suffixes, the narrow and wide
 * vectors, the unsigned narrow vectors, the narrow width and sign. */
#define WIDE(F, ...)                                                      \
    F(__VA_ARGS__, s8, s16, int8x8_t, int8x16_t, int16x4_t, int16x8_t, uint8x8_t, uint8x16_t, 8, 1) \
    F(__VA_ARGS__, u8, u16, uint8x8_t, uint8x16_t, uint16x4_t, uint16x8_t, uint8x8_t, uint8x16_t, 8, 0) \
    F(__VA_ARGS__, s16, s32, int16x4_t, int16x8_t, int32x2_t, int32x4_t, uint16x4_t, uint16x8_t, 16, 1) \
    F(__VA_ARGS__, u16, u32, uint16x4_t, uint16x8_t, uint32x2_t, uint32x4_t, uint16x4_t, uint16x8_t, 16, 0) \
    F(__VA_ARGS__, s32, s64, int32x2_t, int32x4_t, int64x1_t, int64x2_t, uint32x2_t, uint32x4_t, 32, 1) \
    F(__VA_ARGS__, u32, u64, uint32x2_t, uint32x4_t, uint64x1_t, uint64x2_t, uint32x2_t, uint32x4_t, 32, 0)
/* Narrowing reads the wide a (lanes 2w bits wide); the _high forms take
 * the low half from b. */
#define NARROWS(X, n0, w0, ND, NQ, WD, WQ, UND, UNQ, w, sg)               \
    X(vmovn_##w0, 8, O_MOVN, 2 * w, sg, LANES(ND), 0, 0, WQ, WQ, WQ, PUT(vmovn_##w0(a))) \
    X(vqmovn_##w0, 8, O_QMOVN, 2 * w, sg, LANES(ND), 0, 0, WQ, WQ, WQ, PUT(vqmovn_##w0(a))) \
    X(vshrn_n_##w0##_3, 8, O_SHRN, 2 * w, sg, LANES(ND), 3, 0, WQ, WQ, WQ, PUT(vshrn_n_##w0(a, 3))) \
    X(vshrn_n_##w0##_w, 8, O_SHRN, 2 * w, sg, LANES(ND), w, 0, WQ, WQ, WQ, PUT(vshrn_n_##w0(a, w))) \
    X(vrshrn_n_##w0##_1, 8, O_RSHRN, 2 * w, sg, LANES(ND), 1, 0, WQ, WQ, WQ, \
      PUT(vrshrn_n_##w0(a, 1)))                                           \
    X(vrshrn_n_##w0##_w, 8, O_RSHRN, 2 * w, sg, LANES(ND), w, 0, WQ, WQ, WQ, \
      PUT(vrshrn_n_##w0(a, w)))                                           \
    X(vmovn_high_##w0, 8, O_MOVN_H, 2 * w, sg, LANES(NQ), 0, 0, WQ, ND, WQ, \
      PUT(vmovn_high_##w0(b, a)))                                         \
    X(vqmovn_high_##w0, 8, O_QMOVN_H, 2 * w, sg, LANES(NQ), 0, 0, WQ, ND, WQ, \
      PUT(vqmovn_high_##w0(b, a)))
#define NARROWS_UN(X, n0, w0, ND, NQ, WD, WQ, UND, UNQ, w, sg)            \
    X(vqmovun_##w0, 8, O_QMOVUN, 2 * w, sg, LANES(ND), 0, 0, WQ, WQ, WQ, PUT(vqmovun_##w0(a))) \
    X(vqmovun_high_##w0, 8, O_QMOVUN_H, 2 * w, sg, LANES(NQ), 0, 0, WQ, UND, WQ, \
      PUT(vqmovun_high_##w0(b, a)))
/* Widening: a and b narrow (the accumulator c wide), or a wide and b
 * narrow for the _w forms. */
#define LONG(X, op, f, n0, w0, ND, NQ, WD, WQ, UND, UNQ, w, sg)          \
    X(f##_##n0, 16, op, w, sg, LANES(WQ), 0, 0, ND, ND, WQ, PUT(f##_##n0(a, b))) \
    X(f##_high_##n0, 16, op, w, sg, LANES(WQ), 0, 1, NQ, NQ, WQ, PUT(f##_high_##n0(a, b)))
#define LONGACC(X, op, f, n0, w0, ND, NQ, WD, WQ, UND, UNQ, w, sg)       \
    X(f##_##n0, 16, op, w, sg, LANES(WQ), 0, 0, ND, ND, WQ, PUT(f##_##n0(c, a, b))) \
    X(f##_high_##n0, 16, op, w, sg, LANES(WQ), 0, 1, NQ, NQ, WQ, PUT(f##_high_##n0(c, a, b)))
#define WIDEN(X, op, f, n0, w0, ND, NQ, WD, WQ, UND, UNQ, w, sg)          \
    X(f##_##n0, 16, op, w, sg, LANES(WQ), 0, 0, WQ, ND, WQ, PUT(f##_##n0(a, b))) \
    X(f##_high_##n0, 16, op, w, sg, LANES(WQ), 0, 1, WQ, NQ, WQ, PUT(f##_high_##n0(a, b)))
#define MOVL(X, n0, w0, ND, NQ, WD, WQ, UND, UNQ, w, sg)                  \
    X(vmovl_##n0, 16, O_MOVL, w, sg, LANES(WQ), 0, 0, ND, ND, ND, PUT(vmovl_##n0(a))) \
    X(vmovl_high_##n0, 16, O_MOVL, w, sg, LANES(WQ), 0, 1, NQ, NQ, NQ, PUT(vmovl_high_##n0(a))) \
    X(vpaddl_##n0, 16, O_PADDL, w, sg, LANES(WD), 0, 0, ND, ND, ND, PUT(vpaddl_##n0(a))) \
    X(vpaddlq_##n0, 16, O_PADDL, w, sg, LANES(WQ), 0, 0, NQ, NQ, NQ, PUT(vpaddlq_##n0(a)))
#define ACROSS(X, n0, w0, ND, NQ, WD, WQ, UND, UNQ, w, sg)                \
    X(vaddv_##n0, 32, O_ADDV, w, sg, LANES(ND), 0, 0, ND, ND, ND, PUT(vaddv_##n0(a))) \
    X(vaddvq_##n0, 32, O_ADDV, w, sg, LANES(NQ), 0, 0, NQ, NQ, NQ, PUT(vaddvq_##n0(a))) \
    X(vaddlv_##n0, 32, O_ADDLV, w, sg, LANES(ND), 0, 0, ND, ND, ND, PUT(vaddlv_##n0(a))) \
    X(vaddlvq_##n0, 32, O_ADDLV, w, sg, LANES(NQ), 0, 0, NQ, NQ, NQ, PUT(vaddlvq_##n0(a))) \
    X(vmaxv_##n0, 32, O_MAXV, w, sg, LANES(ND), 0, 0, ND, ND, ND, PUT(vmaxv_##n0(a))) \
    X(vmaxvq_##n0, 32, O_MAXV, w, sg, LANES(NQ), 0, 0, NQ, NQ, NQ, PUT(vmaxvq_##n0(a))) \
    X(vminv_##n0, 32, O_MINV, w, sg, LANES(ND), 0, 0, ND, ND, ND, PUT(vminv_##n0(a))) \
    X(vminvq_##n0, 32, O_MINV, w, sg, LANES(NQ), 0, 0, NQ, NQ, NQ, PUT(vminvq_##n0(a)))

#define TESTS(X)                                                          \
    INT(SHIFTS, X)                                                        \
    X(vsli_n_p8, 4, O_SLI, 8, 0, 8, 3, 0, poly8x8_t, poly8x8_t, poly8x8_t, PUT(vsli_n_p8(b, a, 3))) \
    X(vsriq_n_p16, 4, O_SRI, 16, 0, 8, 16, 0, poly16x8_t, poly16x8_t, poly16x8_t, \
      PUT(vsriq_n_p16(b, a, 16)))                                         \
    X(vsliq_n_p64, 4, O_SLI, 64, 0, 2, 63, 0, poly64x2_t, poly64x2_t, poly64x2_t, \
      PUT(vsliq_n_p64(b, a, 63)))                                         \
    WIDE(NARROWS, X) NARROWS_UN(X, s8, s16, int8x8_t, int8x16_t, int16x4_t, int16x8_t, \
                                uint8x8_t, uint8x16_t, 8, 1)              \
    NARROWS_UN(X, s16, s32, int16x4_t, int16x8_t, int32x2_t, int32x4_t, uint16x4_t, \
               uint16x8_t, 16, 1)                                         \
    NARROWS_UN(X, s32, s64, int32x2_t, int32x4_t, int64x1_t, int64x2_t, uint32x2_t, \
               uint32x4_t, 32, 1)                                         \
    WIDE(LONG, X, O_ADDL, vaddl) WIDE(LONG, X, O_SUBL, vsubl) WIDE(LONG, X, O_MULL, vmull) \
    WIDE(LONGACC, X, O_MLAL, vmlal) WIDE(LONGACC, X, O_MLSL, vmlsl)      \
    WIDE(WIDEN, X, O_ADDW, vaddw) WIDE(WIDEN, X, O_SUBW, vsubw) WIDE(MOVL, X) WIDE(ACROSS, X) \
    X(vaddvq_s64, 32, O_ADDV, 64, 1, 2, 0, 0, int64x2_t, int64x2_t, int64x2_t, PUT(vaddvq_s64(a))) \
    X(vaddvq_u64, 32, O_ADDV, 64, 0, 2, 0, 0, uint64x2_t, uint64x2_t, uint64x2_t, PUT(vaddvq_u64(a)))
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

static i128 sat(i128 v, int w, int s) {
    i128 lo = s ? -((i128)1 << (w - 1)) : 0;
    i128 hi = s ? ((i128)1 << (w - 1)) - 1 : ((i128)1 << w) - 1;
    return v < lo ? lo : v > hi ? hi : v;
}

/* SSHL/USHL: a negative count shifts right, with rounding when round; the
 * result saturates when sat, and is taken modulo 2^w otherwise. */
static i128 shift_by(i128 x, int sh, int w, int s, int round, int sat_) {
    if (sh < 0)
        return (x + (round ? (i128)1 << (-sh - 1) : 0)) >> -sh;
    if (sat_)
        return x == 0 ? 0 : sh >= w ? sat(x < 0 ? -((i128)1 << w) : (i128)1 << w, w, s)
                                    : sat(x * ((i128)1 << sh), w, s);
    return sh >= w ? 0 : (i128)((u128)x << sh);
}

static int count_at(int k, int i, int w) {
    return (k * 7 + i * 5) % (2 * w + 5) - (w + 2);
}

int main(void) {
    enum { ROWS = 6 };
    static unsigned char pat[16 * ROWS] __attribute__((aligned(16)));
    static const unsigned char edges[32] = {
        0,    0,    0,    0,    0,    0,    0,    0x80, 0xFF, 0xFF, 0xFF,
        0xFF, 0xFF, 0xFF, 0xFF, 0x7F, 0x01, 0x00, 0x00, 0x00, 0xFF, 0xFF,
        0xFF, 0xFF, 0x81, 0x80, 0x00, 0x80, 0x7F, 0x7F, 0xFE, 0x00};
    memcpy(pat, edges, sizeof edges);
    unsigned x = 0x2545F491u;
    for (unsigned i = sizeof edges; i < sizeof pat; i++) {
        x ^= x << 13;
        x ^= x >> 17;
        x ^= x << 5;
        pat[i] = (unsigned char)(x >> 5);
    }
    int fails = 0;
    for (unsigned t = 0; t < sizeof tests / sizeof tests[0]; t++) {
        const struct test *e = &tests[t];
        int w = e->w, s = e->s, n = e->n, imm = e->imm;
        for (int j = 0; j < ROWS; j++)
            for (int k = 0; k < ROWS; k++) {
                const unsigned char *a = pat + 16 * j, *c = pat + 16 * ((j + k) % ROWS);
                unsigned char b[16] __attribute__((aligned(16))), r[16] __attribute__((aligned(16)));
                memcpy(b, pat + 16 * k, 16);
                if (e->op <= O_QSHL_R)
                    for (int i = 0; i < n; i++)
                        b[i * w / 8] = (unsigned char)count_at(k, i, w);
                e->fn(r, a, b, c);
                for (int i = 0; i < n; i++) {
                    i128 xa = lane(a, i, w, s), xb = lane(b, i, w, s), m = 0;
                    i128 ua = lane(a, i, w, 0), ub = lane(b, i, w, 0);
                    i128 na = lane(a, e->hi * n + i, w, s), nb = lane(b, e->hi * n + i, w, s);
                    int rw = w;
                    switch (e->op) {
                    case O_SHL_R: m = shift_by(xa, (signed char)b[i * w / 8], w, s, 0, 0); break;
                    case O_RSHL_R: m = shift_by(xa, (signed char)b[i * w / 8], w, s, 1, 0); break;
                    case O_QSHL_R: m = shift_by(xa, (signed char)b[i * w / 8], w, s, 0, 1); break;
                    case O_SHL: m = shift_by(xa, imm, w, s, 0, 0); break;
                    case O_QSHL: m = shift_by(xa, imm, w, s, 0, 1); break;
                    case O_SHR: m = shift_by(xa, -imm, w, s, 0, 0); break;
                    case O_RSHR: m = shift_by(xa, -imm, w, s, 1, 0); break;
                    case O_SRA: m = xb + shift_by(xa, -imm, w, s, 0, 0); break;
                    case O_RSRA: m = xb + shift_by(xa, -imm, w, s, 1, 0); break;
                    case O_SLI: m = (ua << imm) | (ub & (((i128)1 << imm) - 1)); break;
                    case O_SRI: m = (ua >> imm) | (ub & ~((((i128)1 << w) - 1) >> imm)); break;
                    case O_MOVN: case O_MOVN_H: m = xa; break;
                    case O_QMOVN: case O_QMOVN_H: m = sat(xa, w / 2, s); break;
                    case O_QMOVUN: case O_QMOVUN_H: m = sat(xa, w / 2, 0); break;
                    case O_SHRN: m = xa >> imm; break;
                    case O_RSHRN: m = (xa + ((i128)1 << (imm - 1))) >> imm; break;
                    case O_ADDL: m = na + nb; break;
                    case O_SUBL: m = na - nb; break;
                    case O_MULL: m = na * nb; break;
                    case O_MLAL: m = lane(c, i, 2 * w, s) + na * nb; break;
                    case O_MLSL: m = lane(c, i, 2 * w, s) - na * nb; break;
                    case O_ADDW: m = lane(a, i, 2 * w, s) + nb; break;
                    case O_SUBW: m = lane(a, i, 2 * w, s) - nb; break;
                    case O_MOVL: m = na; break;
                    case O_PADDL: m = lane(a, 2 * i, w, s) + lane(a, 2 * i + 1, w, s); break;
                    default:
                        m = lane(a, 0, w, s);
                        for (int l = 1; l < n; l++) {
                            i128 v = lane(a, l, w, s);
                            m = e->op == O_MAXV ? (v > m ? v : m)
                              : e->op == O_MINV ? (v < m ? v : m) : m + v;
                        }
                        break;
                    }
                    if (e->op >= O_MOVN && e->op <= O_QMOVUN_H) {
                        rw = w / 2;
                        int h = e->op >= O_MOVN_H ? n / 2 : 0;
                        if (i >= n - h)
                            break;
                        if (h && lane(r, i, rw, 0) != lane(b, i, rw, 0))
                            fails |= e->bit;
                        if (((u128)m ^ (u128)lane(r, h + i, rw, 0)) & (((u128)1 << rw) - 1))
                            fails |= e->bit;
                        continue;
                    }
                    if (e->op >= O_ADDL && e->op <= O_PADDL)
                        rw = 2 * w;
                    if (e->op >= O_ADDV) {
                        rw = e->op == O_ADDLV ? 2 * w : w;
                        if (i)
                            break;
                    }
                    if (((u128)m ^ (u128)lane(r, i, rw, 0)) & (((u128)1 << rw) - 1))
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
