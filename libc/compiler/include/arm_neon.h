/* AArch64 Advanced SIMD (NEON) intrinsics of the Arm C Language Extensions:
 * a call of the compiler's row of the instruction the ACLE maps each to
 * (`__builtin_neon_<insn>_<arrangement>`), which the optimizer and the
 * interpreter evaluate; an inline-asm wrapper over the instruction, vector
 * operands in the `w` class, where no row exists yet; or short C over the
 * vector extension for lane accesses and compositions. A family is
 * instantiated over the rows of the element types it is defined on. Forms
 * with a lane or immediate operand are macros: the operand is a
 * range-checked integer constant expression that reaches the template as
 * an `i` operand.
 *
 * Types: [u]int{8,16,32,64}, poly{8,16,64} and float{32,64} vectors of 64
 * and 128 bits, poly128_t, the x2 pairs of the 8-, 16- and 32-bit lanes and
 * uint8x16x4_t. On every element type the ACLE defines them for: vld1/vst1
 * and their _dup and _lane forms, vdup_n, vmov_n, vdup_lane[q], vget_low,
 * vget_high, vcombine, vget_lane, vset_lane, vreinterpret between any two
 * types of one width, vzip/vuzp/vtrn and their 1/2 halves, vext, vrev16/32/
 * 64, vbsl. Integer: vadd vsub vmul vmla vmls vaba vabd vneg vabs vqneg
 * vqabs vqadd vqsub vhadd vrhadd vhsub vmax vmin vpadd vpmax vpmin vpaddl,
 * vand vorr veor vbic vorn vmvn vtst vcnt vclz vcls, vceq vcge vcgt vcle
 * vclt, vshl/vrshl/vqshl by register, vshl_n vqshl_n vshr_n vrshr_n vsra_n
 * vrsra_n vsli_n vsri_n vshrn_n vrshrn_n vqshlu_n vshll_n, vpadal, vmovl vmovn vqmovn vqmovun vaddl
 * vsubl vaddw vsubw vmull vmlal vmlsl vabdl vabal with their _high forms, vaddv vaddlv
 * vmaxv vminv. Floating: vadd vsub vmul vdiv vmax vmin vabs vneg vsqrt vfma
 * vfms vrecpe vrecps vrsqrte vrsqrts with their scalar forms, the
 * compares, those against zero (vceqz ... vcltz, integer too, with their
 * scalar forms), and the conversions to
 * and from the integers of one width (truncating) and between single and
 * double. Also vrecpe_u32, vrsqrte_u32, vmul_p8, vqtbl1q_u8, vqtbx1q_u8, the FEAT_AES rounds,
 * vmull_p8, vmull_high_p8, vmull_p64, vmull_high_p64, the SHA-1, SHA-256, SHA-512, SHA3, SM3 and
 * SM4 intrinsics, vld2q_u16 and vld4q_u8.
 *
 * Not provided: float16, bfloat16, the lane-indexed and by-scalar forms,
 * the doubling multiplies, the saturating narrowing shifts, the other
 * structure
 * loads, stores and table lookups, the floating pairwise, across-lane,
 * absolute-difference, rounding and maxnum forms, the fixed-point and
 * rounding-mode conversions and the dot products.
 *
 * The element typedefs match <stdint.h>, repeated so the header serves
 * freestanding units; poly128_t is carried as a 16-byte vector.
 */
#ifndef BADC_ARM_NEON_H
#define BADC_ARM_NEON_H
#ifndef __BADC_INTRIN
/* An intrinsic is inlined at every optimization level, as a call to it would
 * pass and copy its vectors around one instruction. */
#define __BADC_INTRIN static __inline__ __attribute__((__always_inline__))
#endif

#ifndef __aarch64__
#error "arm_neon.h requires an AArch64 target"
#endif

/* A unit may define `__attribute__` away, as code written for compilers
** without it does; the declarations below need it. */
#pragma push_macro("__attribute__")
#undef __attribute__

typedef signed char int8_t;
typedef short int16_t;
typedef int int32_t;
typedef __INT64_TYPE__ int64_t;
typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;
typedef __UINT64_TYPE__ uint64_t;
typedef unsigned char poly8_t;
typedef unsigned short poly16_t;
typedef __UINT64_TYPE__ poly64_t;
typedef float float32_t;
typedef double float64_t;

typedef signed char int8x8_t __attribute__((vector_size(8)));
typedef short int16x4_t __attribute__((vector_size(8)));
typedef int int32x2_t __attribute__((vector_size(8)));
typedef int64_t int64x1_t __attribute__((vector_size(8)));
typedef unsigned char uint8x8_t __attribute__((vector_size(8)));
typedef unsigned short uint16x4_t __attribute__((vector_size(8)));
typedef unsigned int uint32x2_t __attribute__((vector_size(8)));
typedef uint64_t uint64x1_t __attribute__((vector_size(8)));
typedef poly8_t poly8x8_t __attribute__((vector_size(8)));
typedef poly16_t poly16x4_t __attribute__((vector_size(8)));
typedef poly64_t poly64x1_t __attribute__((vector_size(8)));
typedef float float32x2_t __attribute__((vector_size(8)));
typedef double float64x1_t __attribute__((vector_size(8)));

typedef signed char int8x16_t __attribute__((vector_size(16)));
typedef short int16x8_t __attribute__((vector_size(16)));
typedef int int32x4_t __attribute__((vector_size(16)));
typedef int64_t int64x2_t __attribute__((vector_size(16)));
typedef unsigned char uint8x16_t __attribute__((vector_size(16)));
typedef unsigned short uint16x8_t __attribute__((vector_size(16)));
typedef unsigned int uint32x4_t __attribute__((vector_size(16)));
typedef uint64_t uint64x2_t __attribute__((vector_size(16)));
typedef poly8_t poly8x16_t __attribute__((vector_size(16)));
typedef poly16_t poly16x8_t __attribute__((vector_size(16)));
typedef poly64_t poly64x2_t __attribute__((vector_size(16)));
typedef float float32x4_t __attribute__((vector_size(16)));
typedef double float64x2_t __attribute__((vector_size(16)));
typedef poly64_t poly128_t __attribute__((vector_size(16)));

typedef struct uint8x16x4_t {
    uint8x16_t val[4];
} uint8x16x4_t;

/* Operand n of a template in arrangement 4s, and `insn` over operands 0,
 * 1 and 2 in it: the SM3 and SM4 forms, which have no rows. */
#define __BADC_NEON_V_4s(n) "%" #n ".4s"
#define __BADC_NEON_I3(insn, A, B, C)                                     \
    insn " " __BADC_NEON_V_##A(0) ", " __BADC_NEON_V_##B(1) ", " __BADC_NEON_V_##C(2)
/* The signed or unsigned choice by kind; a polynomial lane is unsigned,
 * and a floating one takes the first, as a lane permute does. */
#define __BADC_NEON_PICK(k, s, u) __BADC_NEON_PICK_##k(s, u)
#define __BADC_NEON_PICK_s(s, u) s
#define __BADC_NEON_PICK_u(s, u) u
#define __BADC_NEON_PICK_p(s, u) u
#define __BADC_NEON_PICK_f(s, u) s
/* The compiler's row of the instruction a builtin stem names, in
 * arrangement A; its result is read as the vector R. B2R swaps the
 * operands. */
#define __BADC_NEON_B(stem, A) __BADC_NEON_B_(stem, A)
#define __BADC_NEON_B_(stem, A) stem##_##A
#define __BADC_NEON_B2(name, R, T, U, k, si, ui, A)                       \
    __BADC_INTRIN R name(T __a, U __b) {                                  \
        return (R)__BADC_NEON_B(__BADC_NEON_PICK(k, si, ui), A)(__a, __b); \
    }
#define __BADC_NEON_B2R(name, R, T, U, k, si, ui, A)                      \
    __BADC_INTRIN R name(T __a, U __b) {                                  \
        return (R)__BADC_NEON_B(__BADC_NEON_PICK(k, si, ui), A)(__b, __a); \
    }
#define __BADC_NEON_B1(name, R, T, k, si, ui, A)                          \
    __BADC_INTRIN R name(T __a) {                                         \
        return (R)__BADC_NEON_B(__BADC_NEON_PICK(k, si, ui), A)(__a);     \
    }
/* The accumulator __a is the first operand and the result; B3T's other
 * operands are of types T and U. */
#define __BADC_NEON_B3(name, R, k, si, ui, A) __BADC_NEON_B3T(name, R, R, R, k, si, ui, A)
#define __BADC_NEON_B3T(name, R, T, U, k, si, ui, A)                      \
    __BADC_INTRIN R name(R __a, T __b, U __c) {                           \
        return (R)__BADC_NEON_B(__BADC_NEON_PICK(k, si, ui), A)(__a, __b, __c); \
    }

/* One instruction into R; FN3 accumulates into __a. */
#define __BADC_NEON_FN2(name, R, T, U, tmpl)                              \
    __BADC_INTRIN R name(T __a, U __b) {                                  \
        R __r;                                                            \
        __asm__(tmpl : "=w"(__r) : "w"(__a), "w"(__b));                   \
        return __r;                                                       \
    }
#define __BADC_NEON_FN3(name, R, T, U, tmpl)                              \
    __BADC_INTRIN R name(R __a, T __b, U __c) {                           \
        __asm__(tmpl : "+w"(__a) : "w"(__b), "w"(__c));                   \
        return __a;                                                       \
    }

/* One row per element type: suffix, kind (s, u, p, f), element, the 64- and
 * 128-bit vectors and their arrangements, and the unsigned and the signed
 * vectors of the same lanes. A family takes its own arguments, then a row. */
#define __BADC_NEON_R_s8(F, ...) F(__VA_ARGS__, s8, s, int8_t, int8x8_t, int8x16_t, 8b, 16b, \
    uint8x8_t, uint8x16_t, int8x8_t, int8x16_t)
#define __BADC_NEON_R_u8(F, ...) F(__VA_ARGS__, u8, u, uint8_t, uint8x8_t, uint8x16_t, 8b, 16b, \
    uint8x8_t, uint8x16_t, int8x8_t, int8x16_t)
#define __BADC_NEON_R_p8(F, ...) F(__VA_ARGS__, p8, p, poly8_t, poly8x8_t, poly8x16_t, 8b, 16b, \
    uint8x8_t, uint8x16_t, int8x8_t, int8x16_t)
#define __BADC_NEON_R_s16(F, ...) F(__VA_ARGS__, s16, s, int16_t, int16x4_t, int16x8_t, 4h, 8h, \
    uint16x4_t, uint16x8_t, int16x4_t, int16x8_t)
#define __BADC_NEON_R_u16(F, ...) F(__VA_ARGS__, u16, u, uint16_t, uint16x4_t, uint16x8_t, 4h, \
    8h, uint16x4_t, uint16x8_t, int16x4_t, int16x8_t)
#define __BADC_NEON_R_p16(F, ...) F(__VA_ARGS__, p16, p, poly16_t, poly16x4_t, poly16x8_t, 4h, \
    8h, uint16x4_t, uint16x8_t, int16x4_t, int16x8_t)
#define __BADC_NEON_R_s32(F, ...) F(__VA_ARGS__, s32, s, int32_t, int32x2_t, int32x4_t, 2s, 4s, \
    uint32x2_t, uint32x4_t, int32x2_t, int32x4_t)
#define __BADC_NEON_R_u32(F, ...) F(__VA_ARGS__, u32, u, uint32_t, uint32x2_t, uint32x4_t, 2s, \
    4s, uint32x2_t, uint32x4_t, int32x2_t, int32x4_t)
#define __BADC_NEON_R_f32(F, ...) F(__VA_ARGS__, f32, f, float32_t, float32x2_t, float32x4_t, \
    2s, 4s, uint32x2_t, uint32x4_t, int32x2_t, int32x4_t)
#define __BADC_NEON_R_s64(F, ...) F(__VA_ARGS__, s64, s, int64_t, int64x1_t, int64x2_t, d, 2d, \
    uint64x1_t, uint64x2_t, int64x1_t, int64x2_t)
#define __BADC_NEON_R_u64(F, ...) F(__VA_ARGS__, u64, u, uint64_t, uint64x1_t, uint64x2_t, d, \
    2d, uint64x1_t, uint64x2_t, int64x1_t, int64x2_t)
#define __BADC_NEON_R_p64(F, ...) F(__VA_ARGS__, p64, p, poly64_t, poly64x1_t, poly64x2_t, d, \
    2d, uint64x1_t, uint64x2_t, int64x1_t, int64x2_t)
#define __BADC_NEON_R_f64(F, ...) F(__VA_ARGS__, f64, f, float64_t, float64x1_t, float64x2_t, \
    d, 2d, uint64x1_t, uint64x2_t, int64x1_t, int64x2_t)

#define __BADC_NEON_I8(F, ...) __BADC_NEON_R_s8(F, __VA_ARGS__) __BADC_NEON_R_u8(F, __VA_ARGS__)
#define __BADC_NEON_I16(F, ...) __BADC_NEON_R_s16(F, __VA_ARGS__) __BADC_NEON_R_u16(F, __VA_ARGS__)
#define __BADC_NEON_I32(F, ...) __BADC_NEON_R_s32(F, __VA_ARGS__) __BADC_NEON_R_u32(F, __VA_ARGS__)
#define __BADC_NEON_I64(F, ...) __BADC_NEON_R_s64(F, __VA_ARGS__) __BADC_NEON_R_u64(F, __VA_ARGS__)
#define __BADC_NEON_INT_8_32(F, ...)                                      \
    __BADC_NEON_I8(F, __VA_ARGS__) __BADC_NEON_I16(F, __VA_ARGS__) __BADC_NEON_I32(F, __VA_ARGS__)
#define __BADC_NEON_INT(F, ...) __BADC_NEON_INT_8_32(F, __VA_ARGS__) __BADC_NEON_I64(F, __VA_ARGS__)
#define __BADC_NEON_SINT_8_32(F, ...)                                     \
    __BADC_NEON_R_s8(F, __VA_ARGS__) __BADC_NEON_R_s16(F, __VA_ARGS__)    \
    __BADC_NEON_R_s32(F, __VA_ARGS__)
#define __BADC_NEON_SINT(F, ...)                                          \
    __BADC_NEON_SINT_8_32(F, __VA_ARGS__) __BADC_NEON_R_s64(F, __VA_ARGS__)
#define __BADC_NEON_E8(F, ...) __BADC_NEON_I8(F, __VA_ARGS__) __BADC_NEON_R_p8(F, __VA_ARGS__)
#define __BADC_NEON_E16(F, ...) __BADC_NEON_I16(F, __VA_ARGS__) __BADC_NEON_R_p16(F, __VA_ARGS__)
#define __BADC_NEON_E32(F, ...) __BADC_NEON_I32(F, __VA_ARGS__) __BADC_NEON_R_f32(F, __VA_ARGS__)
#define __BADC_NEON_E64(F, ...)                                           \
    __BADC_NEON_I64(F, __VA_ARGS__) __BADC_NEON_R_p64(F, __VA_ARGS__)     \
    __BADC_NEON_R_f64(F, __VA_ARGS__)
/* The rows whose 64-bit vector has more than one lane, and all of them. */
#define __BADC_NEON_LANES(F, ...)                                         \
    __BADC_NEON_E8(F, __VA_ARGS__) __BADC_NEON_E16(F, __VA_ARGS__) __BADC_NEON_E32(F, __VA_ARGS__)
#define __BADC_NEON_ALL(F, ...) __BADC_NEON_LANES(F, __VA_ARGS__) __BADC_NEON_E64(F, __VA_ARGS__)

/* Broadcasts: the value in every lane, as a compound literal of as many
 * elements as the arrangement has lanes. */
#define __BADC_NEON_N_d(x) x
#define __BADC_NEON_N_2d(x) x, x
#define __BADC_NEON_N_2s(x) x, x
#define __BADC_NEON_N_4s(x) x, x, x, x
#define __BADC_NEON_N_4h(x) x, x, x, x
#define __BADC_NEON_N_8h(x) __BADC_NEON_N_4h(x), __BADC_NEON_N_4h(x)
#define __BADC_NEON_N_8b(x) __BADC_NEON_N_4h(x), __BADC_NEON_N_4h(x)
#define __BADC_NEON_N_16b(x) __BADC_NEON_N_8b(x), __BADC_NEON_N_8b(x)
#define __BADC_NEON_F_DUP(_, sfx, k, E, D, Q, AD, AQ, ...)                \
    __BADC_INTRIN D vdup_n_##sfx(E __x) { return (D){__BADC_NEON_N_##AD(__x)}; } \
    __BADC_INTRIN Q vdupq_n_##sfx(E __x) { return (Q){__BADC_NEON_N_##AQ(__x)}; } \
    __BADC_INTRIN D vmov_n_##sfx(E __x) { return vdup_n_##sfx(__x); }     \
    __BADC_INTRIN Q vmovq_n_##sfx(E __x) { return vdupq_n_##sfx(__x); }
__BADC_NEON_ALL(__BADC_NEON_F_DUP, _)

/* Loads and stores: the vector's bytes at any address, and one element in
 * every lane. */
#define __BADC_NEON_F_MEM(_, sfx, k, E, D, Q, ...)                        \
    __BADC_INTRIN D vld1_##sfx(const E *__p) {                            \
        D __r;                                                            \
        __builtin_memcpy(&__r, __p, sizeof __r);                          \
        return __r;                                                       \
    }                                                                     \
    __BADC_INTRIN Q vld1q_##sfx(const E *__p) {                           \
        Q __r;                                                            \
        __builtin_memcpy(&__r, __p, sizeof __r);                          \
        return __r;                                                       \
    }                                                                     \
    __BADC_INTRIN void vst1_##sfx(E *__p, D __v) { __builtin_memcpy(__p, &__v, sizeof __v); } \
    __BADC_INTRIN void vst1q_##sfx(E *__p, Q __v) { __builtin_memcpy(__p, &__v, sizeof __v); } \
    __BADC_INTRIN D vld1_dup_##sfx(const E *__p) { return vdup_n_##sfx(*__p); } \
    __BADC_INTRIN Q vld1q_dup_##sfx(const E *__p) { return vdupq_n_##sfx(*__p); }
__BADC_NEON_ALL(__BADC_NEON_F_MEM, _)

/* Halves and the concatenation of two, as the 64-bit lanes of the
 * 128-bit vector. */
#define __BADC_NEON_F_HALF(_, sfx, k, E, D, Q, ...)                       \
    __BADC_INTRIN D vget_low_##sfx(Q __a) {                               \
        return (D)(float64x1_t){((float64x2_t)__a)[0]};                   \
    }                                                                     \
    __BADC_INTRIN D vget_high_##sfx(Q __a) {                              \
        return (D)(float64x1_t){((float64x2_t)__a)[1]};                   \
    }                                                                     \
    __BADC_INTRIN Q vcombine_##sfx(D __a, D __b) {                        \
        return (Q)(float64x2_t){((float64x1_t)__a)[0], ((float64x1_t)__b)[0]}; \
    }
__BADC_NEON_ALL(__BADC_NEON_F_HALF, _)

/* Reinterpretations: casts between vector types of one width. AFTER_x
 * names the rows after x in ALL's order, so each pair is spelled once. */
#define __BADC_NEON_F_CAST(a, A, AQ, b, k, E, B, BQ, ...)                 \
    __BADC_INTRIN A vreinterpret_##a##_##b(B __x) { return (A)__x; }      \
    __BADC_INTRIN B vreinterpret_##b##_##a(A __x) { return (B)__x; }      \
    __BADC_INTRIN AQ vreinterpretq_##a##_##b(BQ __x) { return (AQ)__x; }  \
    __BADC_INTRIN BQ vreinterpretq_##b##_##a(AQ __x) { return (BQ)__x; }
#define __BADC_NEON_F_CASTS(_, a, k, E, A, AQ, ...)                       \
    __BADC_NEON_AFTER_##a(__BADC_NEON_F_CAST, a, A, AQ)                   \
    __BADC_INTRIN poly128_t vreinterpretq_p128_##a(AQ __x) { return (poly128_t)__x; } \
    __BADC_INTRIN AQ vreinterpretq_##a##_p128(poly128_t __x) { return (AQ)__x; }
#define __BADC_NEON_AFTER_s8(F, ...)                                      \
    __BADC_NEON_R_u8(F, __VA_ARGS__) __BADC_NEON_AFTER_u8(F, __VA_ARGS__)
#define __BADC_NEON_AFTER_u8(F, ...)                                      \
    __BADC_NEON_R_p8(F, __VA_ARGS__) __BADC_NEON_AFTER_p8(F, __VA_ARGS__)
#define __BADC_NEON_AFTER_p8(F, ...)                                      \
    __BADC_NEON_R_s16(F, __VA_ARGS__) __BADC_NEON_AFTER_s16(F, __VA_ARGS__)
#define __BADC_NEON_AFTER_s16(F, ...)                                     \
    __BADC_NEON_R_u16(F, __VA_ARGS__) __BADC_NEON_AFTER_u16(F, __VA_ARGS__)
#define __BADC_NEON_AFTER_u16(F, ...)                                     \
    __BADC_NEON_R_p16(F, __VA_ARGS__) __BADC_NEON_AFTER_p16(F, __VA_ARGS__)
#define __BADC_NEON_AFTER_p16(F, ...)                                     \
    __BADC_NEON_R_s32(F, __VA_ARGS__) __BADC_NEON_AFTER_s32(F, __VA_ARGS__)
#define __BADC_NEON_AFTER_s32(F, ...)                                     \
    __BADC_NEON_R_u32(F, __VA_ARGS__) __BADC_NEON_AFTER_u32(F, __VA_ARGS__)
#define __BADC_NEON_AFTER_u32(F, ...)                                     \
    __BADC_NEON_R_f32(F, __VA_ARGS__) __BADC_NEON_AFTER_f32(F, __VA_ARGS__)
#define __BADC_NEON_AFTER_f32(F, ...)                                     \
    __BADC_NEON_R_s64(F, __VA_ARGS__) __BADC_NEON_AFTER_s64(F, __VA_ARGS__)
#define __BADC_NEON_AFTER_s64(F, ...)                                     \
    __BADC_NEON_R_u64(F, __VA_ARGS__) __BADC_NEON_AFTER_u64(F, __VA_ARGS__)
#define __BADC_NEON_AFTER_u64(F, ...)                                     \
    __BADC_NEON_R_p64(F, __VA_ARGS__) __BADC_NEON_AFTER_p64(F, __VA_ARGS__)
#define __BADC_NEON_AFTER_p64(F, ...) __BADC_NEON_R_f64(F, __VA_ARGS__)
#define __BADC_NEON_AFTER_f64(F, ...)
__BADC_NEON_ALL(__BADC_NEON_F_CASTS, _)

/* Permutes (none of a single lane); the pairs return both halves. */
#define __BADC_NEON_F_PERM(op, si, sfx, k, E, D, Q, AD, AQ, ...)          \
    __BADC_NEON_B2(op##_##sfx, D, D, D, k, si, si, AD)                    \
    __BADC_NEON_B2(op##q_##sfx, Q, Q, Q, k, si, si, AQ)
#define __BADC_NEON_F_PERMQ(op, si, sfx, k, E, D, Q, AD, AQ, ...)         \
    __BADC_NEON_B2(op##q_##sfx, Q, Q, Q, k, si, si, AQ)
#define __BADC_NEON_PERMS(op, si)                                         \
    __BADC_NEON_LANES(__BADC_NEON_F_PERM, op, si)                         \
    __BADC_NEON_E64(__BADC_NEON_F_PERMQ, op, si)
__BADC_NEON_PERMS(vzip1, __builtin_neon_zip1)
__BADC_NEON_PERMS(vzip2, __builtin_neon_zip2)
__BADC_NEON_PERMS(vuzp1, __builtin_neon_uzp1)
__BADC_NEON_PERMS(vuzp2, __builtin_neon_uzp2)
__BADC_NEON_PERMS(vtrn1, __builtin_neon_trn1)
__BADC_NEON_PERMS(vtrn2, __builtin_neon_trn2)
#define __BADC_NEON_PAIR(op, sfx, DN, QN)                                 \
    __BADC_INTRIN DN##x2_t op##_##sfx(DN##_t __a, DN##_t __b) {           \
        return (DN##x2_t){{op##1_##sfx(__a, __b), op##2_##sfx(__a, __b)}}; \
    }                                                                     \
    __BADC_INTRIN QN##x2_t op##q_##sfx(QN##_t __a, QN##_t __b) {          \
        return (QN##x2_t){{op##1q_##sfx(__a, __b), op##2q_##sfx(__a, __b)}}; \
    }
#define __BADC_NEON_PAIRS(sfx, DN, QN)                                    \
    typedef struct DN##x2_t {                                             \
        DN##_t val[2];                                                    \
    } DN##x2_t;                                                           \
    typedef struct QN##x2_t {                                             \
        QN##_t val[2];                                                    \
    } QN##x2_t;                                                           \
    __BADC_NEON_PAIR(vzip, sfx, DN, QN)                                   \
    __BADC_NEON_PAIR(vuzp, sfx, DN, QN)                                   \
    __BADC_NEON_PAIR(vtrn, sfx, DN, QN)
__BADC_NEON_PAIRS(s8, int8x8, int8x16)
__BADC_NEON_PAIRS(u8, uint8x8, uint8x16)
__BADC_NEON_PAIRS(p8, poly8x8, poly8x16)
__BADC_NEON_PAIRS(s16, int16x4, int16x8)
__BADC_NEON_PAIRS(u16, uint16x4, uint16x8)
__BADC_NEON_PAIRS(p16, poly16x4, poly16x8)
__BADC_NEON_PAIRS(s32, int32x2, int32x4)
__BADC_NEON_PAIRS(u32, uint32x2, uint32x4)
__BADC_NEON_PAIRS(f32, float32x2, float32x4)

/* Element reversal within each 16-, 32- or 64-bit group. */
#define __BADC_NEON_F_UN(op, si, ui, sfx, k, E, D, Q, AD, AQ, ...)        \
    __BADC_NEON_B1(op##_##sfx, D, D, k, si, ui, AD)                       \
    __BADC_NEON_B1(op##q_##sfx, Q, Q, k, si, ui, AQ)
#define __BADC_NEON_F_UNX(op, stem, sfx, k, E, D, Q, AD, AQ, ...)         \
    __BADC_NEON_B1(op##_##sfx, D, D, s, stem, stem, AD)                   \
    __BADC_NEON_B1(op##q_##sfx, Q, Q, s, stem, stem, AQ)
__BADC_NEON_E8(__BADC_NEON_F_UNX, vrev16, __builtin_neon_rev16)
__BADC_NEON_E8(__BADC_NEON_F_UNX, vrev32, __builtin_neon_rev32)
__BADC_NEON_E16(__BADC_NEON_F_UNX, vrev32, __builtin_neon_rev32)
__BADC_NEON_LANES(__BADC_NEON_F_UNX, vrev64, __builtin_neon_rev64)

/* Bitwise select: the mask's set bits take the first operand's. */
#define __BADC_NEON_BSL(name, M, T, A)                                    \
    __BADC_INTRIN T name(M __m, T __a, T __b) {                           \
        return (T)__builtin_neon_bsl_##A(__m, __a, __b);                  \
    }
#define __BADC_NEON_F_BSL(_, sfx, k, E, D, Q, AD, AQ, UD, UQ, ...)        \
    __BADC_NEON_BSL(vbsl_##sfx, UD, D, 8b)                                \
    __BADC_NEON_BSL(vbslq_##sfx, UQ, Q, 16b)
__BADC_NEON_ALL(__BADC_NEON_F_BSL, _)

/* Lane-wise integer operations; a 64-bit lane takes the d scalar form. */
#define __BADC_NEON_F_BIN(op, si, ui, sfx, k, E, D, Q, AD, AQ, ...)       \
    __BADC_NEON_B2(op##_##sfx, D, D, D, k, si, ui, AD)                    \
    __BADC_NEON_B2(op##q_##sfx, Q, Q, Q, k, si, ui, AQ)
#define __BADC_NEON_F_BINQ(op, si, ui, sfx, k, E, D, Q, AD, AQ, ...)      \
    __BADC_NEON_B2(op##q_##sfx, Q, Q, Q, k, si, ui, AQ)
#define __BADC_NEON_F_ACC(op, si, ui, sfx, k, E, D, Q, AD, AQ, ...)       \
    __BADC_NEON_B3(op##_##sfx, D, k, si, ui, AD)                          \
    __BADC_NEON_B3(op##q_##sfx, Q, k, si, ui, AQ)
__BADC_NEON_INT(__BADC_NEON_F_BIN, vadd, __builtin_neon_add, __builtin_neon_add)
__BADC_NEON_INT(__BADC_NEON_F_BIN, vsub, __builtin_neon_sub, __builtin_neon_sub)
__BADC_NEON_INT(__BADC_NEON_F_BIN, vqadd, __builtin_neon_sqadd, __builtin_neon_uqadd)
__BADC_NEON_INT(__BADC_NEON_F_BIN, vqsub, __builtin_neon_sqsub, __builtin_neon_uqsub)
__BADC_NEON_INT_8_32(__BADC_NEON_F_BIN, vmul, __builtin_neon_mul, __builtin_neon_mul)
__BADC_NEON_INT_8_32(__BADC_NEON_F_BIN, vhadd, __builtin_neon_shadd, __builtin_neon_uhadd)
__BADC_NEON_INT_8_32(__BADC_NEON_F_BIN, vrhadd, __builtin_neon_srhadd, __builtin_neon_urhadd)
__BADC_NEON_INT_8_32(__BADC_NEON_F_BIN, vhsub, __builtin_neon_shsub, __builtin_neon_uhsub)
__BADC_NEON_INT_8_32(__BADC_NEON_F_BIN, vabd, __builtin_neon_sabd, __builtin_neon_uabd)
__BADC_NEON_INT_8_32(__BADC_NEON_F_BIN, vmax, __builtin_neon_smax, __builtin_neon_umax)
__BADC_NEON_INT_8_32(__BADC_NEON_F_BIN, vmin, __builtin_neon_smin, __builtin_neon_umin)
__BADC_NEON_INT_8_32(__BADC_NEON_F_BIN, vpadd, __builtin_neon_addp, __builtin_neon_addp)
__BADC_NEON_I64(__BADC_NEON_F_BINQ, vpadd, __builtin_neon_addp, __builtin_neon_addp)
__BADC_NEON_INT_8_32(__BADC_NEON_F_BIN, vpmax, __builtin_neon_smaxp, __builtin_neon_umaxp)
__BADC_NEON_INT_8_32(__BADC_NEON_F_BIN, vpmin, __builtin_neon_sminp, __builtin_neon_uminp)
__BADC_NEON_INT_8_32(__BADC_NEON_F_ACC, vmla, __builtin_neon_mla, __builtin_neon_mla)
__BADC_NEON_INT_8_32(__BADC_NEON_F_ACC, vmls, __builtin_neon_mls, __builtin_neon_mls)
__BADC_NEON_INT_8_32(__BADC_NEON_F_ACC, vaba, __builtin_neon_saba, __builtin_neon_uaba)
__BADC_NEON_SINT(__BADC_NEON_F_UN, vneg, __builtin_neon_neg, __builtin_neon_neg)
__BADC_NEON_SINT(__BADC_NEON_F_UN, vabs, __builtin_neon_abs, __builtin_neon_abs)
__BADC_NEON_SINT(__BADC_NEON_F_UN, vqneg, __builtin_neon_sqneg, __builtin_neon_sqneg)
__BADC_NEON_SINT(__BADC_NEON_F_UN, vqabs, __builtin_neon_sqabs, __builtin_neon_sqabs)
__BADC_NEON_INT_8_32(__BADC_NEON_F_UN, vclz, __builtin_neon_clz, __builtin_neon_clz)
__BADC_NEON_SINT_8_32(__BADC_NEON_F_UN, vcls, __builtin_neon_cls, __builtin_neon_cls)
__BADC_INTRIN poly8x8_t vmul_p8(poly8x8_t __a, poly8x8_t __b) {
    return (poly8x8_t)__builtin_neon_pmul_8b(__a, __b);
}
__BADC_INTRIN poly8x16_t vmulq_p8(poly8x16_t __a, poly8x16_t __b) {
    return (poly8x16_t)__builtin_neon_pmul_16b(__a, __b);
}

/* Bitwise operations over the bytes of any integer vector. */
#define __BADC_NEON_F_LOGIC(op, stem, sfx, k, E, D, Q, ...)               \
    __BADC_NEON_B2(op##_##sfx, D, D, D, s, stem, stem, 8b)                \
    __BADC_NEON_B2(op##q_##sfx, Q, Q, Q, s, stem, stem, 16b)
#define __BADC_NEON_F_LOGIC1(op, stem, sfx, k, E, D, Q, ...)              \
    __BADC_NEON_B1(op##_##sfx, D, D, s, stem, stem, 8b)                   \
    __BADC_NEON_B1(op##q_##sfx, Q, Q, s, stem, stem, 16b)
__BADC_NEON_INT(__BADC_NEON_F_LOGIC, vand, __builtin_neon_and)
__BADC_NEON_INT(__BADC_NEON_F_LOGIC, vorr, __builtin_neon_orr)
__BADC_NEON_INT(__BADC_NEON_F_LOGIC, veor, __builtin_neon_eor)
__BADC_NEON_INT(__BADC_NEON_F_LOGIC, vbic, __builtin_neon_bic)
__BADC_NEON_INT(__BADC_NEON_F_LOGIC, vorn, __builtin_neon_orn)
__BADC_NEON_INT_8_32(__BADC_NEON_F_LOGIC1, vmvn, __builtin_neon_mvn)
__BADC_NEON_R_p8(__BADC_NEON_F_LOGIC1, vmvn, __builtin_neon_mvn)
__BADC_NEON_E8(__BADC_NEON_F_LOGIC1, vcnt, __builtin_neon_cnt)

/* All-ones lanes where the relation holds; vcle and vclt swap the operands
 * of vcge and vcgt. vshl, vrshl and vqshl shift by a signed lane count. */
#define __BADC_NEON_F_CMP(op, si, ui, sfx, k, E, D, Q, AD, AQ, UD, UQ, ...) \
    __BADC_NEON_B2(op##_##sfx, UD, D, D, k, si, ui, AD)                   \
    __BADC_NEON_B2(op##q_##sfx, UQ, Q, Q, k, si, ui, AQ)
#define __BADC_NEON_F_CMPR(op, si, ui, sfx, k, E, D, Q, AD, AQ, UD, UQ, ...) \
    __BADC_NEON_B2R(op##_##sfx, UD, D, D, k, si, ui, AD)                  \
    __BADC_NEON_B2R(op##q_##sfx, UQ, Q, Q, k, si, ui, AQ)
#define __BADC_NEON_F_SHL(op, si, ui, sfx, k, E, D, Q, AD, AQ, UD, UQ, SD, SQ) \
    __BADC_NEON_B2(op##_##sfx, D, D, SD, k, si, ui, AD)                   \
    __BADC_NEON_B2(op##q_##sfx, Q, Q, SQ, k, si, ui, AQ)
__BADC_NEON_INT(__BADC_NEON_F_CMP, vceq, __builtin_neon_cmeq, __builtin_neon_cmeq)
__BADC_NEON_R_p8(__BADC_NEON_F_CMP, vceq, __builtin_neon_cmeq, __builtin_neon_cmeq)
__BADC_NEON_R_p64(__BADC_NEON_F_CMP, vceq, __builtin_neon_cmeq, __builtin_neon_cmeq)
__BADC_NEON_INT(__BADC_NEON_F_CMP, vcge, __builtin_neon_cmge, __builtin_neon_cmhs)
__BADC_NEON_INT(__BADC_NEON_F_CMP, vcgt, __builtin_neon_cmgt, __builtin_neon_cmhi)
__BADC_NEON_INT(__BADC_NEON_F_CMPR, vcle, __builtin_neon_cmge, __builtin_neon_cmhs)
__BADC_NEON_INT(__BADC_NEON_F_CMPR, vclt, __builtin_neon_cmgt, __builtin_neon_cmhi)
__BADC_NEON_INT(__BADC_NEON_F_CMP, vtst, __builtin_neon_cmtst, __builtin_neon_cmtst)
__BADC_NEON_R_p8(__BADC_NEON_F_CMP, vtst, __builtin_neon_cmtst, __builtin_neon_cmtst)
__BADC_NEON_INT(__BADC_NEON_F_SHL, vshl, __builtin_neon_sshl, __builtin_neon_ushl)
__BADC_NEON_INT(__BADC_NEON_F_SHL, vrshl, __builtin_neon_srshl, __builtin_neon_urshl)
__BADC_NEON_INT(__BADC_NEON_F_SHL, vqshl, __builtin_neon_sqshl, __builtin_neon_uqshl)

/* Rows of a narrow type and its double: suffixes, kind, narrow and wide
 * vectors, their arrangements, and the unsigned narrow vectors. */
#define __BADC_NEON_W_s8(F, ...) F(__VA_ARGS__, s8, s16, s, int8x8_t, int8x16_t, int16x4_t, \
    int16x8_t, 8b, 16b, 4h, 8h, uint8x8_t, uint8x16_t)
#define __BADC_NEON_W_u8(F, ...) F(__VA_ARGS__, u8, u16, u, uint8x8_t, uint8x16_t, uint16x4_t, \
    uint16x8_t, 8b, 16b, 4h, 8h, uint8x8_t, uint8x16_t)
#define __BADC_NEON_W_s16(F, ...) F(__VA_ARGS__, s16, s32, s, int16x4_t, int16x8_t, int32x2_t, \
    int32x4_t, 4h, 8h, 2s, 4s, uint16x4_t, uint16x8_t)
#define __BADC_NEON_W_u16(F, ...) F(__VA_ARGS__, u16, u32, u, uint16x4_t, uint16x8_t, \
    uint32x2_t, uint32x4_t, 4h, 8h, 2s, 4s, uint16x4_t, uint16x8_t)
#define __BADC_NEON_W_s32(F, ...) F(__VA_ARGS__, s32, s64, s, int32x2_t, int32x4_t, int64x1_t, \
    int64x2_t, 2s, 4s, 1d, 2d, uint32x2_t, uint32x4_t)
#define __BADC_NEON_W_u32(F, ...) F(__VA_ARGS__, u32, u64, u, uint32x2_t, uint32x4_t, \
    uint64x1_t, uint64x2_t, 2s, 4s, 1d, 2d, uint32x2_t, uint32x4_t)
#define __BADC_NEON_SWIDE(F, ...)                                         \
    __BADC_NEON_W_s8(F, __VA_ARGS__) __BADC_NEON_W_s16(F, __VA_ARGS__)    \
    __BADC_NEON_W_s32(F, __VA_ARGS__)
#define __BADC_NEON_WIDE(F, ...)                                          \
    __BADC_NEON_SWIDE(F, __VA_ARGS__) __BADC_NEON_W_u8(F, __VA_ARGS__)    \
    __BADC_NEON_W_u16(F, __VA_ARGS__) __BADC_NEON_W_u32(F, __VA_ARGS__)

/* Widening and narrowing. The _high forms read the upper half of a 128-bit
 * source, or place a narrowed result above the 64-bit first operand. */
/* A row is named by its narrow arrangement, or by the wide source one when
 * it narrows; the _high form's stem ends in 2. */
#define __BADC_NEON_F_LONG(op, si, ui, n, w, k, ND, NQ, WD, WQ, NA, NAQ, WAD, WAQ, ...) \
    __BADC_NEON_B2(op##_##n, WQ, ND, ND, k, si, ui, NA)                   \
    __BADC_NEON_B2(op##_high_##n, WQ, NQ, NQ, k, si##2, ui##2, NAQ)
#define __BADC_NEON_F_LONGACC(op, si, ui, n, w, k, ND, NQ, WD, WQ, NA, NAQ, WAD, WAQ, ...) \
    __BADC_NEON_B3T(op##_##n, WQ, ND, ND, k, si, ui, NA)                  \
    __BADC_NEON_B3T(op##_high_##n, WQ, NQ, NQ, k, si##2, ui##2, NAQ)
#define __BADC_NEON_F_WIDEN(op, si, ui, n, w, k, ND, NQ, WD, WQ, NA, NAQ, WAD, WAQ, ...) \
    __BADC_NEON_B2(op##_##n, WQ, WQ, ND, k, si, ui, NA)                   \
    __BADC_NEON_B2(op##_high_##n, WQ, WQ, NQ, k, si##2, ui##2, NAQ)
#define __BADC_NEON_F_MOVL(_, n, w, k, ND, NQ, WD, WQ, NA, NAQ, WAD, WAQ, ...) \
    __BADC_NEON_B1(vmovl_##n, WQ, ND, k, __builtin_neon_sxtl, __builtin_neon_uxtl, NA) \
    __BADC_NEON_B1(vmovl_high_##n, WQ, NQ, k, __builtin_neon_sxtl2, __builtin_neon_uxtl2, NAQ) \
    __BADC_NEON_B1(vpaddl_##n, WD, ND, k, __builtin_neon_saddlp, __builtin_neon_uaddlp, NA) \
    __BADC_NEON_B1(vpaddlq_##n, WQ, NQ, k, __builtin_neon_saddlp, __builtin_neon_uaddlp, NAQ)
#define __BADC_NEON_F_MOVN(op, si, ui, n, w, k, ND, NQ, WD, WQ, NA, NAQ, WAD, WAQ, UND, UNQ) \
    __BADC_NEON_B1(op##_##w, ND, WQ, k, si, ui, WAQ)                      \
    __BADC_INTRIN NQ op##_high_##w(ND __r, WQ __a) {                      \
        return (NQ)vcombine_u64((uint64x1_t)__r, (uint64x1_t)op##_##w(__a)); \
    }
#define __BADC_NEON_F_QMOVUN(_, n, w, k, ND, NQ, WD, WQ, NA, NAQ, WAD, WAQ, UND, UNQ) \
    __BADC_NEON_B1(vqmovun_##w, UND, WQ, s, __builtin_neon_sqxtun, __builtin_neon_sqxtun, WAQ) \
    __BADC_INTRIN UNQ vqmovun_high_##w(UND __r, WQ __a) {                 \
        return (UNQ)vcombine_u64((uint64x1_t)__r, (uint64x1_t)vqmovun_##w(__a)); \
    }
__BADC_NEON_WIDE(__BADC_NEON_F_LONG, vaddl, __builtin_neon_saddl, __builtin_neon_uaddl)
__BADC_NEON_WIDE(__BADC_NEON_F_LONG, vsubl, __builtin_neon_ssubl, __builtin_neon_usubl)
__BADC_NEON_WIDE(__BADC_NEON_F_LONG, vmull, __builtin_neon_smull, __builtin_neon_umull)
__BADC_NEON_WIDE(__BADC_NEON_F_LONG, vabdl, __builtin_neon_sabdl, __builtin_neon_uabdl)
__BADC_NEON_WIDE(__BADC_NEON_F_LONGACC, vmlal, __builtin_neon_smlal, __builtin_neon_umlal)
__BADC_NEON_WIDE(__BADC_NEON_F_LONGACC, vmlsl, __builtin_neon_smlsl, __builtin_neon_umlsl)
__BADC_NEON_WIDE(__BADC_NEON_F_LONGACC, vabal, __builtin_neon_sabal, __builtin_neon_uabal)
__BADC_NEON_WIDE(__BADC_NEON_F_WIDEN, vaddw, __builtin_neon_saddw, __builtin_neon_uaddw)
__BADC_NEON_WIDE(__BADC_NEON_F_WIDEN, vsubw, __builtin_neon_ssubw, __builtin_neon_usubw)
__BADC_NEON_WIDE(__BADC_NEON_F_MOVL, _)
/* vpadal: the accumulator plus the pairwise long sums of the second
 * operand. */
#define __BADC_NEON_F_PADAL(_, n, w, k, ND, NQ, WD, WQ, NA, NAQ, ...)     \
    __BADC_NEON_B2(vpadal_##n, WD, WD, ND, k, __builtin_neon_sadalp, __builtin_neon_uadalp, NA) \
    __BADC_NEON_B2(vpadalq_##n, WQ, WQ, NQ, k, __builtin_neon_sadalp, __builtin_neon_uadalp, NAQ)
__BADC_NEON_WIDE(__BADC_NEON_F_PADAL, _)
__BADC_NEON_WIDE(__BADC_NEON_F_MOVN, vmovn, __builtin_neon_xtn, __builtin_neon_xtn)
__BADC_NEON_WIDE(__BADC_NEON_F_MOVN, vqmovn, __builtin_neon_sqxtn, __builtin_neon_uqxtn)
__BADC_NEON_SWIDE(__BADC_NEON_F_QMOVUN, _)

/* Across lanes: lane 0 of the reduction's row. A 2-lane 32-bit or 64-bit
 * vector takes the pairwise form of the vector with itself. */
#define __BADC_NEON_RED(name, R, T, stem, A)                              \
    __BADC_INTRIN R name(T __a) { return (R)__BADC_NEON_B(stem, A)(__a)[0]; }
#define __BADC_NEON_RED2(name, R, T, stem, A)                             \
    __BADC_INTRIN R name(T __a) { return (R)__BADC_NEON_B(stem, A)(__a, __a)[0]; }
#define __BADC_NEON_F_ACROSS(op, si, ui, sfx, k, E, D, Q, AD, AQ, ...)    \
    __BADC_NEON_RED(op##_##sfx, E, D, __BADC_NEON_PICK(k, si, ui), AD)    \
    __BADC_NEON_RED(op##q_##sfx, E, Q, __BADC_NEON_PICK(k, si, ui), AQ)
#define __BADC_NEON_F_ACROSS2(op, si, ui, sp, up, sfx, k, E, D, Q, ...)   \
    __BADC_NEON_RED2(op##_##sfx, E, D, __BADC_NEON_PICK(k, sp, up), 2s)   \
    __BADC_NEON_RED(op##q_##sfx, E, Q, __BADC_NEON_PICK(k, si, ui), 4s)
#define __BADC_NEON_F_ADDLV(ws, wu, sfx, k, E, D, Q, AD, AQ, ...)         \
    __BADC_NEON_RED(vaddlv_##sfx, __BADC_NEON_PICK(k, ws, wu), D,         \
                    __BADC_NEON_PICK(k, __builtin_neon_saddlv, __builtin_neon_uaddlv), AD) \
    __BADC_NEON_RED(vaddlvq_##sfx, __BADC_NEON_PICK(k, ws, wu), Q,        \
                    __BADC_NEON_PICK(k, __builtin_neon_saddlv, __builtin_neon_uaddlv), AQ)
#define __BADC_NEON_F_ADDLV2(_, sfx, k, E, D, Q, ...)                     \
    __BADC_NEON_RED(vaddlv_##sfx, __BADC_NEON_PICK(k, int64_t, uint64_t), D, \
                    __BADC_NEON_PICK(k, __builtin_neon_saddlp, __builtin_neon_uaddlp), 2s) \
    __BADC_NEON_RED(vaddlvq_##sfx, __BADC_NEON_PICK(k, int64_t, uint64_t), Q, \
                    __BADC_NEON_PICK(k, __builtin_neon_saddlv, __builtin_neon_uaddlv), 4s)
__BADC_NEON_I8(__BADC_NEON_F_ACROSS, vaddv, __builtin_neon_addv, __builtin_neon_addv)
__BADC_NEON_I16(__BADC_NEON_F_ACROSS, vaddv, __builtin_neon_addv, __builtin_neon_addv)
__BADC_NEON_I32(__BADC_NEON_F_ACROSS2, vaddv, __builtin_neon_addv, __builtin_neon_addv,
                __builtin_neon_addp, __builtin_neon_addp)
__BADC_NEON_RED2(vaddvq_s64, int64_t, int64x2_t, __builtin_neon_addp, 2d)
__BADC_NEON_RED2(vaddvq_u64, uint64_t, uint64x2_t, __builtin_neon_addp, 2d)
__BADC_NEON_I8(__BADC_NEON_F_ACROSS, vmaxv, __builtin_neon_smaxv, __builtin_neon_umaxv)
__BADC_NEON_I16(__BADC_NEON_F_ACROSS, vmaxv, __builtin_neon_smaxv, __builtin_neon_umaxv)
__BADC_NEON_I32(__BADC_NEON_F_ACROSS2, vmaxv, __builtin_neon_smaxv, __builtin_neon_umaxv,
                __builtin_neon_smaxp, __builtin_neon_umaxp)
__BADC_NEON_I8(__BADC_NEON_F_ACROSS, vminv, __builtin_neon_sminv, __builtin_neon_uminv)
__BADC_NEON_I16(__BADC_NEON_F_ACROSS, vminv, __builtin_neon_sminv, __builtin_neon_uminv)
__BADC_NEON_I32(__BADC_NEON_F_ACROSS2, vminv, __builtin_neon_sminv, __builtin_neon_uminv,
                __builtin_neon_sminp, __builtin_neon_uminp)
__BADC_NEON_I8(__BADC_NEON_F_ADDLV, int16_t, uint16_t)
__BADC_NEON_I16(__BADC_NEON_F_ADDLV, int32_t, uint32_t)
__BADC_NEON_I32(__BADC_NEON_F_ADDLV2, _)

/* Lane reads and writes, lane loads and stores, and the lane broadcasts,
 * as subscripts of the vector extension. */
#define __BADC_NEON_LANE(__n, __lanes)                                    \
    _Static_assert((__n) >= 0 && (__n) < (int)(__lanes), "lane index out of range")
#define __BADC_NEON_NLANES(__v) (sizeof(__v) / sizeof((__v)[0]))
#define __BADC_NEON_GET(T, __v, __n) __extension__({                      \
    __BADC_NEON_LANE(__n, __BADC_NEON_NLANES((T){0}));                    \
    ((T)(__v))[__n];                                                      \
})
#define __BADC_NEON_SET(T, __x, __v, __n) __extension__({                 \
    T __lv = (__v);                                                       \
    __BADC_NEON_LANE(__n, __BADC_NEON_NLANES(__lv));                      \
    __lv[__n] = (__x);                                                    \
    __lv;                                                                 \
})
#define __BADC_NEON_LD1L(T, __p, __v, __n) __extension__({                \
    T __lv = (__v);                                                       \
    const __typeof__(__lv[0]) *__lp = (__p);                              \
    __BADC_NEON_LANE(__n, __BADC_NEON_NLANES(__lv));                      \
    __lv[__n] = *__lp;                                                    \
    __lv;                                                                 \
})
#define __BADC_NEON_ST1L(T, __p, __v, __n) __extension__({                \
    T __lv = (__v);                                                       \
    __typeof__(__lv[0]) *__lp = (__p);                                    \
    __BADC_NEON_LANE(__n, __BADC_NEON_NLANES(__lv));                      \
    *__lp = __lv[__n];                                                    \
})
/* Lane __n of the vector T, D or Q by S, in every lane of R, arrangement A. */
#define __BADC_NEON_DUPL(R, T, A, S, __v, __n) __extension__({            \
    T __lv = (__v);                                                       \
    __BADC_NEON_LANE(__n, __BADC_NEON_NLANES(__lv));                      \
    (R)__builtin_neon_dup_##A##_##S(__lv, __n);                           \
})
#define __BADC_NEON_DUPL1(R, T, __v, __n) __extension__({                 \
    T __lv = (__v);                                                       \
    __BADC_NEON_LANE(__n, __BADC_NEON_NLANES(__lv));                      \
    (R)__lv;                                                              \
})
/* Lane __n of the 128-bit vector T of 64-bit lanes, as the 64-bit R. */
#define __BADC_NEON_DUPLQ1(R, T, __v, __n) __extension__({                \
    T __lv = (__v);                                                       \
    __BADC_NEON_LANE(__n, __BADC_NEON_NLANES(__lv));                      \
    (R)(float64x1_t){((float64x2_t)__lv)[__n]};                           \
})
/* The window of the concatenation __b:__a starting at lane __n. */
#define __BADC_NEON_EXT(T, A, __a, __b, __n) __extension__({              \
    T __ea = (__a), __eb = (__b);                                         \
    __BADC_NEON_LANE(__n, __BADC_NEON_NLANES(__ea));                      \
    (T)__builtin_neon_ext_##A(__ea, __eb, (__n) * sizeof __ea[0]);        \
})

#define vget_lane_s8(__v, __n) __BADC_NEON_GET(int8x8_t, __v, __n)
#define vgetq_lane_s8(__v, __n) __BADC_NEON_GET(int8x16_t, __v, __n)
#define vset_lane_s8(__x, __v, __n) __BADC_NEON_SET(int8x8_t, __x, __v, __n)
#define vsetq_lane_s8(__x, __v, __n) __BADC_NEON_SET(int8x16_t, __x, __v, __n)
#define vld1_lane_s8(__p, __v, __n) __BADC_NEON_LD1L(int8x8_t, __p, __v, __n)
#define vld1q_lane_s8(__p, __v, __n) __BADC_NEON_LD1L(int8x16_t, __p, __v, __n)
#define vst1_lane_s8(__p, __v, __n) __BADC_NEON_ST1L(int8x8_t, __p, __v, __n)
#define vst1q_lane_s8(__p, __v, __n) __BADC_NEON_ST1L(int8x16_t, __p, __v, __n)
#define vdup_lane_s8(__v, __n) __BADC_NEON_DUPL(int8x8_t, int8x8_t, 8b, d, __v, __n)
#define vdupq_lane_s8(__v, __n) __BADC_NEON_DUPL(int8x16_t, int8x8_t, 16b, d, __v, __n)
#define vdup_laneq_s8(__v, __n) __BADC_NEON_DUPL(int8x8_t, int8x16_t, 8b, q, __v, __n)
#define vdupq_laneq_s8(__v, __n) __BADC_NEON_DUPL(int8x16_t, int8x16_t, 16b, q, __v, __n)
#define vext_s8(__a, __b, __n) __BADC_NEON_EXT(int8x8_t, 8b, __a, __b, __n)
#define vextq_s8(__a, __b, __n) __BADC_NEON_EXT(int8x16_t, 16b, __a, __b, __n)

#define vget_lane_u8(__v, __n) __BADC_NEON_GET(uint8x8_t, __v, __n)
#define vgetq_lane_u8(__v, __n) __BADC_NEON_GET(uint8x16_t, __v, __n)
#define vset_lane_u8(__x, __v, __n) __BADC_NEON_SET(uint8x8_t, __x, __v, __n)
#define vsetq_lane_u8(__x, __v, __n) __BADC_NEON_SET(uint8x16_t, __x, __v, __n)
#define vld1_lane_u8(__p, __v, __n) __BADC_NEON_LD1L(uint8x8_t, __p, __v, __n)
#define vld1q_lane_u8(__p, __v, __n) __BADC_NEON_LD1L(uint8x16_t, __p, __v, __n)
#define vst1_lane_u8(__p, __v, __n) __BADC_NEON_ST1L(uint8x8_t, __p, __v, __n)
#define vst1q_lane_u8(__p, __v, __n) __BADC_NEON_ST1L(uint8x16_t, __p, __v, __n)
#define vdup_lane_u8(__v, __n) __BADC_NEON_DUPL(uint8x8_t, uint8x8_t, 8b, d, __v, __n)
#define vdupq_lane_u8(__v, __n) __BADC_NEON_DUPL(uint8x16_t, uint8x8_t, 16b, d, __v, __n)
#define vdup_laneq_u8(__v, __n) __BADC_NEON_DUPL(uint8x8_t, uint8x16_t, 8b, q, __v, __n)
#define vdupq_laneq_u8(__v, __n) __BADC_NEON_DUPL(uint8x16_t, uint8x16_t, 16b, q, __v, __n)
#define vext_u8(__a, __b, __n) __BADC_NEON_EXT(uint8x8_t, 8b, __a, __b, __n)
#define vextq_u8(__a, __b, __n) __BADC_NEON_EXT(uint8x16_t, 16b, __a, __b, __n)

#define vget_lane_p8(__v, __n) __BADC_NEON_GET(poly8x8_t, __v, __n)
#define vgetq_lane_p8(__v, __n) __BADC_NEON_GET(poly8x16_t, __v, __n)
#define vset_lane_p8(__x, __v, __n) __BADC_NEON_SET(poly8x8_t, __x, __v, __n)
#define vsetq_lane_p8(__x, __v, __n) __BADC_NEON_SET(poly8x16_t, __x, __v, __n)
#define vld1_lane_p8(__p, __v, __n) __BADC_NEON_LD1L(poly8x8_t, __p, __v, __n)
#define vld1q_lane_p8(__p, __v, __n) __BADC_NEON_LD1L(poly8x16_t, __p, __v, __n)
#define vst1_lane_p8(__p, __v, __n) __BADC_NEON_ST1L(poly8x8_t, __p, __v, __n)
#define vst1q_lane_p8(__p, __v, __n) __BADC_NEON_ST1L(poly8x16_t, __p, __v, __n)
#define vdup_lane_p8(__v, __n) __BADC_NEON_DUPL(poly8x8_t, poly8x8_t, 8b, d, __v, __n)
#define vdupq_lane_p8(__v, __n) __BADC_NEON_DUPL(poly8x16_t, poly8x8_t, 16b, d, __v, __n)
#define vdup_laneq_p8(__v, __n) __BADC_NEON_DUPL(poly8x8_t, poly8x16_t, 8b, q, __v, __n)
#define vdupq_laneq_p8(__v, __n) __BADC_NEON_DUPL(poly8x16_t, poly8x16_t, 16b, q, __v, __n)
#define vext_p8(__a, __b, __n) __BADC_NEON_EXT(poly8x8_t, 8b, __a, __b, __n)
#define vextq_p8(__a, __b, __n) __BADC_NEON_EXT(poly8x16_t, 16b, __a, __b, __n)

#define vget_lane_s16(__v, __n) __BADC_NEON_GET(int16x4_t, __v, __n)
#define vgetq_lane_s16(__v, __n) __BADC_NEON_GET(int16x8_t, __v, __n)
#define vset_lane_s16(__x, __v, __n) __BADC_NEON_SET(int16x4_t, __x, __v, __n)
#define vsetq_lane_s16(__x, __v, __n) __BADC_NEON_SET(int16x8_t, __x, __v, __n)
#define vld1_lane_s16(__p, __v, __n) __BADC_NEON_LD1L(int16x4_t, __p, __v, __n)
#define vld1q_lane_s16(__p, __v, __n) __BADC_NEON_LD1L(int16x8_t, __p, __v, __n)
#define vst1_lane_s16(__p, __v, __n) __BADC_NEON_ST1L(int16x4_t, __p, __v, __n)
#define vst1q_lane_s16(__p, __v, __n) __BADC_NEON_ST1L(int16x8_t, __p, __v, __n)
#define vdup_lane_s16(__v, __n) __BADC_NEON_DUPL(int16x4_t, int16x4_t, 4h, d, __v, __n)
#define vdupq_lane_s16(__v, __n) __BADC_NEON_DUPL(int16x8_t, int16x4_t, 8h, d, __v, __n)
#define vdup_laneq_s16(__v, __n) __BADC_NEON_DUPL(int16x4_t, int16x8_t, 4h, q, __v, __n)
#define vdupq_laneq_s16(__v, __n) __BADC_NEON_DUPL(int16x8_t, int16x8_t, 8h, q, __v, __n)
#define vext_s16(__a, __b, __n) __BADC_NEON_EXT(int16x4_t, 8b, __a, __b, __n)
#define vextq_s16(__a, __b, __n) __BADC_NEON_EXT(int16x8_t, 16b, __a, __b, __n)

#define vget_lane_u16(__v, __n) __BADC_NEON_GET(uint16x4_t, __v, __n)
#define vgetq_lane_u16(__v, __n) __BADC_NEON_GET(uint16x8_t, __v, __n)
#define vset_lane_u16(__x, __v, __n) __BADC_NEON_SET(uint16x4_t, __x, __v, __n)
#define vsetq_lane_u16(__x, __v, __n) __BADC_NEON_SET(uint16x8_t, __x, __v, __n)
#define vld1_lane_u16(__p, __v, __n) __BADC_NEON_LD1L(uint16x4_t, __p, __v, __n)
#define vld1q_lane_u16(__p, __v, __n) __BADC_NEON_LD1L(uint16x8_t, __p, __v, __n)
#define vst1_lane_u16(__p, __v, __n) __BADC_NEON_ST1L(uint16x4_t, __p, __v, __n)
#define vst1q_lane_u16(__p, __v, __n) __BADC_NEON_ST1L(uint16x8_t, __p, __v, __n)
#define vdup_lane_u16(__v, __n) __BADC_NEON_DUPL(uint16x4_t, uint16x4_t, 4h, d, __v, __n)
#define vdupq_lane_u16(__v, __n) __BADC_NEON_DUPL(uint16x8_t, uint16x4_t, 8h, d, __v, __n)
#define vdup_laneq_u16(__v, __n) __BADC_NEON_DUPL(uint16x4_t, uint16x8_t, 4h, q, __v, __n)
#define vdupq_laneq_u16(__v, __n) __BADC_NEON_DUPL(uint16x8_t, uint16x8_t, 8h, q, __v, __n)
#define vext_u16(__a, __b, __n) __BADC_NEON_EXT(uint16x4_t, 8b, __a, __b, __n)
#define vextq_u16(__a, __b, __n) __BADC_NEON_EXT(uint16x8_t, 16b, __a, __b, __n)

#define vget_lane_p16(__v, __n) __BADC_NEON_GET(poly16x4_t, __v, __n)
#define vgetq_lane_p16(__v, __n) __BADC_NEON_GET(poly16x8_t, __v, __n)
#define vset_lane_p16(__x, __v, __n) __BADC_NEON_SET(poly16x4_t, __x, __v, __n)
#define vsetq_lane_p16(__x, __v, __n) __BADC_NEON_SET(poly16x8_t, __x, __v, __n)
#define vld1_lane_p16(__p, __v, __n) __BADC_NEON_LD1L(poly16x4_t, __p, __v, __n)
#define vld1q_lane_p16(__p, __v, __n) __BADC_NEON_LD1L(poly16x8_t, __p, __v, __n)
#define vst1_lane_p16(__p, __v, __n) __BADC_NEON_ST1L(poly16x4_t, __p, __v, __n)
#define vst1q_lane_p16(__p, __v, __n) __BADC_NEON_ST1L(poly16x8_t, __p, __v, __n)
#define vdup_lane_p16(__v, __n) __BADC_NEON_DUPL(poly16x4_t, poly16x4_t, 4h, d, __v, __n)
#define vdupq_lane_p16(__v, __n) __BADC_NEON_DUPL(poly16x8_t, poly16x4_t, 8h, d, __v, __n)
#define vdup_laneq_p16(__v, __n) __BADC_NEON_DUPL(poly16x4_t, poly16x8_t, 4h, q, __v, __n)
#define vdupq_laneq_p16(__v, __n) __BADC_NEON_DUPL(poly16x8_t, poly16x8_t, 8h, q, __v, __n)
#define vext_p16(__a, __b, __n) __BADC_NEON_EXT(poly16x4_t, 8b, __a, __b, __n)
#define vextq_p16(__a, __b, __n) __BADC_NEON_EXT(poly16x8_t, 16b, __a, __b, __n)

#define vget_lane_s32(__v, __n) __BADC_NEON_GET(int32x2_t, __v, __n)
#define vgetq_lane_s32(__v, __n) __BADC_NEON_GET(int32x4_t, __v, __n)
#define vset_lane_s32(__x, __v, __n) __BADC_NEON_SET(int32x2_t, __x, __v, __n)
#define vsetq_lane_s32(__x, __v, __n) __BADC_NEON_SET(int32x4_t, __x, __v, __n)
#define vld1_lane_s32(__p, __v, __n) __BADC_NEON_LD1L(int32x2_t, __p, __v, __n)
#define vld1q_lane_s32(__p, __v, __n) __BADC_NEON_LD1L(int32x4_t, __p, __v, __n)
#define vst1_lane_s32(__p, __v, __n) __BADC_NEON_ST1L(int32x2_t, __p, __v, __n)
#define vst1q_lane_s32(__p, __v, __n) __BADC_NEON_ST1L(int32x4_t, __p, __v, __n)
#define vdup_lane_s32(__v, __n) __BADC_NEON_DUPL(int32x2_t, int32x2_t, 2s, d, __v, __n)
#define vdupq_lane_s32(__v, __n) __BADC_NEON_DUPL(int32x4_t, int32x2_t, 4s, d, __v, __n)
#define vdup_laneq_s32(__v, __n) __BADC_NEON_DUPL(int32x2_t, int32x4_t, 2s, q, __v, __n)
#define vdupq_laneq_s32(__v, __n) __BADC_NEON_DUPL(int32x4_t, int32x4_t, 4s, q, __v, __n)
#define vext_s32(__a, __b, __n) __BADC_NEON_EXT(int32x2_t, 8b, __a, __b, __n)
#define vextq_s32(__a, __b, __n) __BADC_NEON_EXT(int32x4_t, 16b, __a, __b, __n)

#define vget_lane_u32(__v, __n) __BADC_NEON_GET(uint32x2_t, __v, __n)
#define vgetq_lane_u32(__v, __n) __BADC_NEON_GET(uint32x4_t, __v, __n)
#define vset_lane_u32(__x, __v, __n) __BADC_NEON_SET(uint32x2_t, __x, __v, __n)
#define vsetq_lane_u32(__x, __v, __n) __BADC_NEON_SET(uint32x4_t, __x, __v, __n)
#define vld1_lane_u32(__p, __v, __n) __BADC_NEON_LD1L(uint32x2_t, __p, __v, __n)
#define vld1q_lane_u32(__p, __v, __n) __BADC_NEON_LD1L(uint32x4_t, __p, __v, __n)
#define vst1_lane_u32(__p, __v, __n) __BADC_NEON_ST1L(uint32x2_t, __p, __v, __n)
#define vst1q_lane_u32(__p, __v, __n) __BADC_NEON_ST1L(uint32x4_t, __p, __v, __n)
#define vdup_lane_u32(__v, __n) __BADC_NEON_DUPL(uint32x2_t, uint32x2_t, 2s, d, __v, __n)
#define vdupq_lane_u32(__v, __n) __BADC_NEON_DUPL(uint32x4_t, uint32x2_t, 4s, d, __v, __n)
#define vdup_laneq_u32(__v, __n) __BADC_NEON_DUPL(uint32x2_t, uint32x4_t, 2s, q, __v, __n)
#define vdupq_laneq_u32(__v, __n) __BADC_NEON_DUPL(uint32x4_t, uint32x4_t, 4s, q, __v, __n)
#define vext_u32(__a, __b, __n) __BADC_NEON_EXT(uint32x2_t, 8b, __a, __b, __n)
#define vextq_u32(__a, __b, __n) __BADC_NEON_EXT(uint32x4_t, 16b, __a, __b, __n)

#define vget_lane_f32(__v, __n) __BADC_NEON_GET(float32x2_t, __v, __n)
#define vgetq_lane_f32(__v, __n) __BADC_NEON_GET(float32x4_t, __v, __n)
#define vset_lane_f32(__x, __v, __n) __BADC_NEON_SET(float32x2_t, __x, __v, __n)
#define vsetq_lane_f32(__x, __v, __n) __BADC_NEON_SET(float32x4_t, __x, __v, __n)
#define vld1_lane_f32(__p, __v, __n) __BADC_NEON_LD1L(float32x2_t, __p, __v, __n)
#define vld1q_lane_f32(__p, __v, __n) __BADC_NEON_LD1L(float32x4_t, __p, __v, __n)
#define vst1_lane_f32(__p, __v, __n) __BADC_NEON_ST1L(float32x2_t, __p, __v, __n)
#define vst1q_lane_f32(__p, __v, __n) __BADC_NEON_ST1L(float32x4_t, __p, __v, __n)
#define vdup_lane_f32(__v, __n) __BADC_NEON_DUPL(float32x2_t, float32x2_t, 2s, d, __v, __n)
#define vdupq_lane_f32(__v, __n) __BADC_NEON_DUPL(float32x4_t, float32x2_t, 4s, d, __v, __n)
#define vdup_laneq_f32(__v, __n) __BADC_NEON_DUPL(float32x2_t, float32x4_t, 2s, q, __v, __n)
#define vdupq_laneq_f32(__v, __n) __BADC_NEON_DUPL(float32x4_t, float32x4_t, 4s, q, __v, __n)
#define vext_f32(__a, __b, __n) __BADC_NEON_EXT(float32x2_t, 8b, __a, __b, __n)
#define vextq_f32(__a, __b, __n) __BADC_NEON_EXT(float32x4_t, 16b, __a, __b, __n)

#define vget_lane_s64(__v, __n) __BADC_NEON_GET(int64x1_t, __v, __n)
#define vgetq_lane_s64(__v, __n) __BADC_NEON_GET(int64x2_t, __v, __n)
#define vset_lane_s64(__x, __v, __n) __BADC_NEON_SET(int64x1_t, __x, __v, __n)
#define vsetq_lane_s64(__x, __v, __n) __BADC_NEON_SET(int64x2_t, __x, __v, __n)
#define vld1_lane_s64(__p, __v, __n) __BADC_NEON_LD1L(int64x1_t, __p, __v, __n)
#define vld1q_lane_s64(__p, __v, __n) __BADC_NEON_LD1L(int64x2_t, __p, __v, __n)
#define vst1_lane_s64(__p, __v, __n) __BADC_NEON_ST1L(int64x1_t, __p, __v, __n)
#define vst1q_lane_s64(__p, __v, __n) __BADC_NEON_ST1L(int64x2_t, __p, __v, __n)
#define vdup_lane_s64(__v, __n) __BADC_NEON_DUPL1(int64x1_t, int64x1_t, __v, __n)
#define vdupq_lane_s64(__v, __n) __BADC_NEON_DUPL(int64x2_t, int64x1_t, 2d, d, __v, __n)
#define vdup_laneq_s64(__v, __n) __BADC_NEON_DUPLQ1(int64x1_t, int64x2_t, __v, __n)
#define vdupq_laneq_s64(__v, __n) __BADC_NEON_DUPL(int64x2_t, int64x2_t, 2d, q, __v, __n)
#define vext_s64(__a, __b, __n) __BADC_NEON_EXT(int64x1_t, 8b, __a, __b, __n)
#define vextq_s64(__a, __b, __n) __BADC_NEON_EXT(int64x2_t, 16b, __a, __b, __n)

#define vget_lane_u64(__v, __n) __BADC_NEON_GET(uint64x1_t, __v, __n)
#define vgetq_lane_u64(__v, __n) __BADC_NEON_GET(uint64x2_t, __v, __n)
#define vset_lane_u64(__x, __v, __n) __BADC_NEON_SET(uint64x1_t, __x, __v, __n)
#define vsetq_lane_u64(__x, __v, __n) __BADC_NEON_SET(uint64x2_t, __x, __v, __n)
#define vld1_lane_u64(__p, __v, __n) __BADC_NEON_LD1L(uint64x1_t, __p, __v, __n)
#define vld1q_lane_u64(__p, __v, __n) __BADC_NEON_LD1L(uint64x2_t, __p, __v, __n)
#define vst1_lane_u64(__p, __v, __n) __BADC_NEON_ST1L(uint64x1_t, __p, __v, __n)
#define vst1q_lane_u64(__p, __v, __n) __BADC_NEON_ST1L(uint64x2_t, __p, __v, __n)
#define vdup_lane_u64(__v, __n) __BADC_NEON_DUPL1(uint64x1_t, uint64x1_t, __v, __n)
#define vdupq_lane_u64(__v, __n) __BADC_NEON_DUPL(uint64x2_t, uint64x1_t, 2d, d, __v, __n)
#define vdup_laneq_u64(__v, __n) __BADC_NEON_DUPLQ1(uint64x1_t, uint64x2_t, __v, __n)
#define vdupq_laneq_u64(__v, __n) __BADC_NEON_DUPL(uint64x2_t, uint64x2_t, 2d, q, __v, __n)
#define vext_u64(__a, __b, __n) __BADC_NEON_EXT(uint64x1_t, 8b, __a, __b, __n)
#define vextq_u64(__a, __b, __n) __BADC_NEON_EXT(uint64x2_t, 16b, __a, __b, __n)

#define vget_lane_p64(__v, __n) __BADC_NEON_GET(poly64x1_t, __v, __n)
#define vgetq_lane_p64(__v, __n) __BADC_NEON_GET(poly64x2_t, __v, __n)
#define vset_lane_p64(__x, __v, __n) __BADC_NEON_SET(poly64x1_t, __x, __v, __n)
#define vsetq_lane_p64(__x, __v, __n) __BADC_NEON_SET(poly64x2_t, __x, __v, __n)
#define vld1_lane_p64(__p, __v, __n) __BADC_NEON_LD1L(poly64x1_t, __p, __v, __n)
#define vld1q_lane_p64(__p, __v, __n) __BADC_NEON_LD1L(poly64x2_t, __p, __v, __n)
#define vst1_lane_p64(__p, __v, __n) __BADC_NEON_ST1L(poly64x1_t, __p, __v, __n)
#define vst1q_lane_p64(__p, __v, __n) __BADC_NEON_ST1L(poly64x2_t, __p, __v, __n)
#define vdup_lane_p64(__v, __n) __BADC_NEON_DUPL1(poly64x1_t, poly64x1_t, __v, __n)
#define vdupq_lane_p64(__v, __n) __BADC_NEON_DUPL(poly64x2_t, poly64x1_t, 2d, d, __v, __n)
#define vdup_laneq_p64(__v, __n) __BADC_NEON_DUPLQ1(poly64x1_t, poly64x2_t, __v, __n)
#define vdupq_laneq_p64(__v, __n) __BADC_NEON_DUPL(poly64x2_t, poly64x2_t, 2d, q, __v, __n)
#define vext_p64(__a, __b, __n) __BADC_NEON_EXT(poly64x1_t, 8b, __a, __b, __n)
#define vextq_p64(__a, __b, __n) __BADC_NEON_EXT(poly64x2_t, 16b, __a, __b, __n)

#define vget_lane_f64(__v, __n) __BADC_NEON_GET(float64x1_t, __v, __n)
#define vgetq_lane_f64(__v, __n) __BADC_NEON_GET(float64x2_t, __v, __n)
#define vset_lane_f64(__x, __v, __n) __BADC_NEON_SET(float64x1_t, __x, __v, __n)
#define vsetq_lane_f64(__x, __v, __n) __BADC_NEON_SET(float64x2_t, __x, __v, __n)
#define vld1_lane_f64(__p, __v, __n) __BADC_NEON_LD1L(float64x1_t, __p, __v, __n)
#define vld1q_lane_f64(__p, __v, __n) __BADC_NEON_LD1L(float64x2_t, __p, __v, __n)
#define vst1_lane_f64(__p, __v, __n) __BADC_NEON_ST1L(float64x1_t, __p, __v, __n)
#define vst1q_lane_f64(__p, __v, __n) __BADC_NEON_ST1L(float64x2_t, __p, __v, __n)
#define vdup_lane_f64(__v, __n) __BADC_NEON_DUPL1(float64x1_t, float64x1_t, __v, __n)
#define vdupq_lane_f64(__v, __n) __BADC_NEON_DUPL(float64x2_t, float64x1_t, 2d, d, __v, __n)
#define vdup_laneq_f64(__v, __n) __BADC_NEON_DUPLQ1(float64x1_t, float64x2_t, __v, __n)
#define vdupq_laneq_f64(__v, __n) __BADC_NEON_DUPL(float64x2_t, float64x2_t, 2d, q, __v, __n)
#define vext_f64(__a, __b, __n) __BADC_NEON_EXT(float64x1_t, 8b, __a, __b, __n)
#define vextq_f64(__a, __b, __n) __BADC_NEON_EXT(float64x2_t, 16b, __a, __b, __n)

/* Shifts by an immediate in [r, bits - 1 + r]: r is 0 for the left shifts,
 * 1 for the right ones. SHA accumulates into or inserts into __a; SHN
 * narrows. */
#define __BADC_NEON_SHIFT_RANGE(__n, r, __e)                              \
    _Static_assert((__n) >= (r) && (__n) < 8 * (int)sizeof(__e) + (r), "shift count out of range")
#define __BADC_NEON_SHB(T, stem, A, r, __a, __n) __extension__({          \
    T __sa = (__a);                                                       \
    __BADC_NEON_SHIFT_RANGE(__n, r, __sa[0]);                             \
    (T)__BADC_NEON_B(stem, A)(__sa, __n);                                 \
})
#define __BADC_NEON_SHA(T, stem, A, r, __a, __b, __n) __extension__({     \
    T __sa = (__a), __sb = (__b);                                         \
    __BADC_NEON_SHIFT_RANGE(__n, r, __sa[0]);                             \
    (T)__BADC_NEON_B(stem, A)(__sa, __sb, __n);                           \
})
#define __BADC_NEON_SHN(R, T, stem, RA, TA, __a, __n) __extension__({     \
    T __sa = (__a);                                                       \
    R __sr;                                                               \
    __BADC_NEON_SHIFT_RANGE(__n, 1, __sr[0]);                             \
    (R)__BADC_NEON_B(stem, TA)(__sa, __n);                                \
})

#define vshl_n_s8(__a, __n) __BADC_NEON_SHB(int8x8_t, __builtin_neon_shl, 8b, 0, __a, __n)
#define vshlq_n_s8(__a, __n) __BADC_NEON_SHB(int8x16_t, __builtin_neon_shl, 16b, 0, __a, __n)
#define vqshl_n_s8(__a, __n) __BADC_NEON_SHB(int8x8_t, __builtin_neon_sqshl_n, 8b, 0, __a, __n)
#define vqshlq_n_s8(__a, __n) __BADC_NEON_SHB(int8x16_t, __builtin_neon_sqshl_n, 16b, 0, __a, __n)
#define vshr_n_s8(__a, __n) __BADC_NEON_SHB(int8x8_t, __builtin_neon_sshr, 8b, 1, __a, __n)
#define vshrq_n_s8(__a, __n) __BADC_NEON_SHB(int8x16_t, __builtin_neon_sshr, 16b, 1, __a, __n)
#define vrshr_n_s8(__a, __n) __BADC_NEON_SHB(int8x8_t, __builtin_neon_srshr, 8b, 1, __a, __n)
#define vrshrq_n_s8(__a, __n) __BADC_NEON_SHB(int8x16_t, __builtin_neon_srshr, 16b, 1, __a, __n)
#define vsra_n_s8(__a, __b, __n) __BADC_NEON_SHA(int8x8_t, __builtin_neon_ssra, 8b, 1, __a, __b, __n)
#define vsraq_n_s8(__a, __b, __n) __BADC_NEON_SHA(int8x16_t, __builtin_neon_ssra, 16b, 1, __a, __b, __n)
#define vrsra_n_s8(__a, __b, __n) __BADC_NEON_SHA(int8x8_t, __builtin_neon_srsra, 8b, 1, __a, __b, __n)
#define vrsraq_n_s8(__a, __b, __n) __BADC_NEON_SHA(int8x16_t, __builtin_neon_srsra, 16b, 1, __a, __b, __n)

#define vshl_n_u8(__a, __n) __BADC_NEON_SHB(uint8x8_t, __builtin_neon_shl, 8b, 0, __a, __n)
#define vshlq_n_u8(__a, __n) __BADC_NEON_SHB(uint8x16_t, __builtin_neon_shl, 16b, 0, __a, __n)
#define vqshl_n_u8(__a, __n) __BADC_NEON_SHB(uint8x8_t, __builtin_neon_uqshl_n, 8b, 0, __a, __n)
#define vqshlq_n_u8(__a, __n) __BADC_NEON_SHB(uint8x16_t, __builtin_neon_uqshl_n, 16b, 0, __a, __n)
#define vshr_n_u8(__a, __n) __BADC_NEON_SHB(uint8x8_t, __builtin_neon_ushr, 8b, 1, __a, __n)
#define vshrq_n_u8(__a, __n) __BADC_NEON_SHB(uint8x16_t, __builtin_neon_ushr, 16b, 1, __a, __n)
#define vrshr_n_u8(__a, __n) __BADC_NEON_SHB(uint8x8_t, __builtin_neon_urshr, 8b, 1, __a, __n)
#define vrshrq_n_u8(__a, __n) __BADC_NEON_SHB(uint8x16_t, __builtin_neon_urshr, 16b, 1, __a, __n)
#define vsra_n_u8(__a, __b, __n) __BADC_NEON_SHA(uint8x8_t, __builtin_neon_usra, 8b, 1, __a, __b, __n)
#define vsraq_n_u8(__a, __b, __n) __BADC_NEON_SHA(uint8x16_t, __builtin_neon_usra, 16b, 1, __a, __b, __n)
#define vrsra_n_u8(__a, __b, __n) __BADC_NEON_SHA(uint8x8_t, __builtin_neon_ursra, 8b, 1, __a, __b, __n)
#define vrsraq_n_u8(__a, __b, __n) __BADC_NEON_SHA(uint8x16_t, __builtin_neon_ursra, 16b, 1, __a, __b, __n)

#define vshl_n_s16(__a, __n) __BADC_NEON_SHB(int16x4_t, __builtin_neon_shl, 4h, 0, __a, __n)
#define vshlq_n_s16(__a, __n) __BADC_NEON_SHB(int16x8_t, __builtin_neon_shl, 8h, 0, __a, __n)
#define vqshl_n_s16(__a, __n) __BADC_NEON_SHB(int16x4_t, __builtin_neon_sqshl_n, 4h, 0, __a, __n)
#define vqshlq_n_s16(__a, __n) __BADC_NEON_SHB(int16x8_t, __builtin_neon_sqshl_n, 8h, 0, __a, __n)
#define vshr_n_s16(__a, __n) __BADC_NEON_SHB(int16x4_t, __builtin_neon_sshr, 4h, 1, __a, __n)
#define vshrq_n_s16(__a, __n) __BADC_NEON_SHB(int16x8_t, __builtin_neon_sshr, 8h, 1, __a, __n)
#define vrshr_n_s16(__a, __n) __BADC_NEON_SHB(int16x4_t, __builtin_neon_srshr, 4h, 1, __a, __n)
#define vrshrq_n_s16(__a, __n) __BADC_NEON_SHB(int16x8_t, __builtin_neon_srshr, 8h, 1, __a, __n)
#define vsra_n_s16(__a, __b, __n) __BADC_NEON_SHA(int16x4_t, __builtin_neon_ssra, 4h, 1, __a, __b, __n)
#define vsraq_n_s16(__a, __b, __n) __BADC_NEON_SHA(int16x8_t, __builtin_neon_ssra, 8h, 1, __a, __b, __n)
#define vrsra_n_s16(__a, __b, __n) __BADC_NEON_SHA(int16x4_t, __builtin_neon_srsra, 4h, 1, __a, __b, __n)
#define vrsraq_n_s16(__a, __b, __n) __BADC_NEON_SHA(int16x8_t, __builtin_neon_srsra, 8h, 1, __a, __b, __n)

#define vshl_n_u16(__a, __n) __BADC_NEON_SHB(uint16x4_t, __builtin_neon_shl, 4h, 0, __a, __n)
#define vshlq_n_u16(__a, __n) __BADC_NEON_SHB(uint16x8_t, __builtin_neon_shl, 8h, 0, __a, __n)
#define vqshl_n_u16(__a, __n) __BADC_NEON_SHB(uint16x4_t, __builtin_neon_uqshl_n, 4h, 0, __a, __n)
#define vqshlq_n_u16(__a, __n) __BADC_NEON_SHB(uint16x8_t, __builtin_neon_uqshl_n, 8h, 0, __a, __n)
#define vshr_n_u16(__a, __n) __BADC_NEON_SHB(uint16x4_t, __builtin_neon_ushr, 4h, 1, __a, __n)
#define vshrq_n_u16(__a, __n) __BADC_NEON_SHB(uint16x8_t, __builtin_neon_ushr, 8h, 1, __a, __n)
#define vrshr_n_u16(__a, __n) __BADC_NEON_SHB(uint16x4_t, __builtin_neon_urshr, 4h, 1, __a, __n)
#define vrshrq_n_u16(__a, __n) __BADC_NEON_SHB(uint16x8_t, __builtin_neon_urshr, 8h, 1, __a, __n)
#define vsra_n_u16(__a, __b, __n) __BADC_NEON_SHA(uint16x4_t, __builtin_neon_usra, 4h, 1, __a, __b, __n)
#define vsraq_n_u16(__a, __b, __n) __BADC_NEON_SHA(uint16x8_t, __builtin_neon_usra, 8h, 1, __a, __b, __n)
#define vrsra_n_u16(__a, __b, __n) __BADC_NEON_SHA(uint16x4_t, __builtin_neon_ursra, 4h, 1, __a, __b, __n)
#define vrsraq_n_u16(__a, __b, __n) __BADC_NEON_SHA(uint16x8_t, __builtin_neon_ursra, 8h, 1, __a, __b, __n)

#define vshl_n_s32(__a, __n) __BADC_NEON_SHB(int32x2_t, __builtin_neon_shl, 2s, 0, __a, __n)
#define vshlq_n_s32(__a, __n) __BADC_NEON_SHB(int32x4_t, __builtin_neon_shl, 4s, 0, __a, __n)
#define vqshl_n_s32(__a, __n) __BADC_NEON_SHB(int32x2_t, __builtin_neon_sqshl_n, 2s, 0, __a, __n)
#define vqshlq_n_s32(__a, __n) __BADC_NEON_SHB(int32x4_t, __builtin_neon_sqshl_n, 4s, 0, __a, __n)
#define vshr_n_s32(__a, __n) __BADC_NEON_SHB(int32x2_t, __builtin_neon_sshr, 2s, 1, __a, __n)
#define vshrq_n_s32(__a, __n) __BADC_NEON_SHB(int32x4_t, __builtin_neon_sshr, 4s, 1, __a, __n)
#define vrshr_n_s32(__a, __n) __BADC_NEON_SHB(int32x2_t, __builtin_neon_srshr, 2s, 1, __a, __n)
#define vrshrq_n_s32(__a, __n) __BADC_NEON_SHB(int32x4_t, __builtin_neon_srshr, 4s, 1, __a, __n)
#define vsra_n_s32(__a, __b, __n) __BADC_NEON_SHA(int32x2_t, __builtin_neon_ssra, 2s, 1, __a, __b, __n)
#define vsraq_n_s32(__a, __b, __n) __BADC_NEON_SHA(int32x4_t, __builtin_neon_ssra, 4s, 1, __a, __b, __n)
#define vrsra_n_s32(__a, __b, __n) __BADC_NEON_SHA(int32x2_t, __builtin_neon_srsra, 2s, 1, __a, __b, __n)
#define vrsraq_n_s32(__a, __b, __n) __BADC_NEON_SHA(int32x4_t, __builtin_neon_srsra, 4s, 1, __a, __b, __n)

#define vshl_n_u32(__a, __n) __BADC_NEON_SHB(uint32x2_t, __builtin_neon_shl, 2s, 0, __a, __n)
#define vshlq_n_u32(__a, __n) __BADC_NEON_SHB(uint32x4_t, __builtin_neon_shl, 4s, 0, __a, __n)
#define vqshl_n_u32(__a, __n) __BADC_NEON_SHB(uint32x2_t, __builtin_neon_uqshl_n, 2s, 0, __a, __n)
#define vqshlq_n_u32(__a, __n) __BADC_NEON_SHB(uint32x4_t, __builtin_neon_uqshl_n, 4s, 0, __a, __n)
#define vshr_n_u32(__a, __n) __BADC_NEON_SHB(uint32x2_t, __builtin_neon_ushr, 2s, 1, __a, __n)
#define vshrq_n_u32(__a, __n) __BADC_NEON_SHB(uint32x4_t, __builtin_neon_ushr, 4s, 1, __a, __n)
#define vrshr_n_u32(__a, __n) __BADC_NEON_SHB(uint32x2_t, __builtin_neon_urshr, 2s, 1, __a, __n)
#define vrshrq_n_u32(__a, __n) __BADC_NEON_SHB(uint32x4_t, __builtin_neon_urshr, 4s, 1, __a, __n)
#define vsra_n_u32(__a, __b, __n) __BADC_NEON_SHA(uint32x2_t, __builtin_neon_usra, 2s, 1, __a, __b, __n)
#define vsraq_n_u32(__a, __b, __n) __BADC_NEON_SHA(uint32x4_t, __builtin_neon_usra, 4s, 1, __a, __b, __n)
#define vrsra_n_u32(__a, __b, __n) __BADC_NEON_SHA(uint32x2_t, __builtin_neon_ursra, 2s, 1, __a, __b, __n)
#define vrsraq_n_u32(__a, __b, __n) __BADC_NEON_SHA(uint32x4_t, __builtin_neon_ursra, 4s, 1, __a, __b, __n)

#define vshl_n_s64(__a, __n) __BADC_NEON_SHB(int64x1_t, __builtin_neon_shl, d, 0, __a, __n)
#define vshlq_n_s64(__a, __n) __BADC_NEON_SHB(int64x2_t, __builtin_neon_shl, 2d, 0, __a, __n)
#define vqshl_n_s64(__a, __n) __BADC_NEON_SHB(int64x1_t, __builtin_neon_sqshl_n, d, 0, __a, __n)
#define vqshlq_n_s64(__a, __n) __BADC_NEON_SHB(int64x2_t, __builtin_neon_sqshl_n, 2d, 0, __a, __n)
#define vshr_n_s64(__a, __n) __BADC_NEON_SHB(int64x1_t, __builtin_neon_sshr, d, 1, __a, __n)
#define vshrq_n_s64(__a, __n) __BADC_NEON_SHB(int64x2_t, __builtin_neon_sshr, 2d, 1, __a, __n)
#define vrshr_n_s64(__a, __n) __BADC_NEON_SHB(int64x1_t, __builtin_neon_srshr, d, 1, __a, __n)
#define vrshrq_n_s64(__a, __n) __BADC_NEON_SHB(int64x2_t, __builtin_neon_srshr, 2d, 1, __a, __n)
#define vsra_n_s64(__a, __b, __n) __BADC_NEON_SHA(int64x1_t, __builtin_neon_ssra, d, 1, __a, __b, __n)
#define vsraq_n_s64(__a, __b, __n) __BADC_NEON_SHA(int64x2_t, __builtin_neon_ssra, 2d, 1, __a, __b, __n)
#define vrsra_n_s64(__a, __b, __n) __BADC_NEON_SHA(int64x1_t, __builtin_neon_srsra, d, 1, __a, __b, __n)
#define vrsraq_n_s64(__a, __b, __n) __BADC_NEON_SHA(int64x2_t, __builtin_neon_srsra, 2d, 1, __a, __b, __n)

#define vshl_n_u64(__a, __n) __BADC_NEON_SHB(uint64x1_t, __builtin_neon_shl, d, 0, __a, __n)
#define vshlq_n_u64(__a, __n) __BADC_NEON_SHB(uint64x2_t, __builtin_neon_shl, 2d, 0, __a, __n)
#define vqshl_n_u64(__a, __n) __BADC_NEON_SHB(uint64x1_t, __builtin_neon_uqshl_n, d, 0, __a, __n)
#define vqshlq_n_u64(__a, __n) __BADC_NEON_SHB(uint64x2_t, __builtin_neon_uqshl_n, 2d, 0, __a, __n)
#define vshr_n_u64(__a, __n) __BADC_NEON_SHB(uint64x1_t, __builtin_neon_ushr, d, 1, __a, __n)
#define vshrq_n_u64(__a, __n) __BADC_NEON_SHB(uint64x2_t, __builtin_neon_ushr, 2d, 1, __a, __n)
#define vrshr_n_u64(__a, __n) __BADC_NEON_SHB(uint64x1_t, __builtin_neon_urshr, d, 1, __a, __n)
#define vrshrq_n_u64(__a, __n) __BADC_NEON_SHB(uint64x2_t, __builtin_neon_urshr, 2d, 1, __a, __n)
#define vsra_n_u64(__a, __b, __n) __BADC_NEON_SHA(uint64x1_t, __builtin_neon_usra, d, 1, __a, __b, __n)
#define vsraq_n_u64(__a, __b, __n) __BADC_NEON_SHA(uint64x2_t, __builtin_neon_usra, 2d, 1, __a, __b, __n)
#define vrsra_n_u64(__a, __b, __n) __BADC_NEON_SHA(uint64x1_t, __builtin_neon_ursra, d, 1, __a, __b, __n)
#define vrsraq_n_u64(__a, __b, __n) __BADC_NEON_SHA(uint64x2_t, __builtin_neon_ursra, 2d, 1, __a, __b, __n)

#define vsli_n_s8(__a, __b, __n) __BADC_NEON_SHA(int8x8_t, __builtin_neon_sli, 8b, 0, __a, __b, __n)
#define vsliq_n_s8(__a, __b, __n) __BADC_NEON_SHA(int8x16_t, __builtin_neon_sli, 16b, 0, __a, __b, __n)
#define vsri_n_s8(__a, __b, __n) __BADC_NEON_SHA(int8x8_t, __builtin_neon_sri, 8b, 1, __a, __b, __n)
#define vsriq_n_s8(__a, __b, __n) __BADC_NEON_SHA(int8x16_t, __builtin_neon_sri, 16b, 1, __a, __b, __n)

#define vsli_n_u8(__a, __b, __n) __BADC_NEON_SHA(uint8x8_t, __builtin_neon_sli, 8b, 0, __a, __b, __n)
#define vsliq_n_u8(__a, __b, __n) __BADC_NEON_SHA(uint8x16_t, __builtin_neon_sli, 16b, 0, __a, __b, __n)
#define vsri_n_u8(__a, __b, __n) __BADC_NEON_SHA(uint8x8_t, __builtin_neon_sri, 8b, 1, __a, __b, __n)
#define vsriq_n_u8(__a, __b, __n) __BADC_NEON_SHA(uint8x16_t, __builtin_neon_sri, 16b, 1, __a, __b, __n)

#define vsli_n_p8(__a, __b, __n) __BADC_NEON_SHA(poly8x8_t, __builtin_neon_sli, 8b, 0, __a, __b, __n)
#define vsliq_n_p8(__a, __b, __n) __BADC_NEON_SHA(poly8x16_t, __builtin_neon_sli, 16b, 0, __a, __b, __n)
#define vsri_n_p8(__a, __b, __n) __BADC_NEON_SHA(poly8x8_t, __builtin_neon_sri, 8b, 1, __a, __b, __n)
#define vsriq_n_p8(__a, __b, __n) __BADC_NEON_SHA(poly8x16_t, __builtin_neon_sri, 16b, 1, __a, __b, __n)

#define vsli_n_s16(__a, __b, __n) __BADC_NEON_SHA(int16x4_t, __builtin_neon_sli, 4h, 0, __a, __b, __n)
#define vsliq_n_s16(__a, __b, __n) __BADC_NEON_SHA(int16x8_t, __builtin_neon_sli, 8h, 0, __a, __b, __n)
#define vsri_n_s16(__a, __b, __n) __BADC_NEON_SHA(int16x4_t, __builtin_neon_sri, 4h, 1, __a, __b, __n)
#define vsriq_n_s16(__a, __b, __n) __BADC_NEON_SHA(int16x8_t, __builtin_neon_sri, 8h, 1, __a, __b, __n)

#define vsli_n_u16(__a, __b, __n) __BADC_NEON_SHA(uint16x4_t, __builtin_neon_sli, 4h, 0, __a, __b, __n)
#define vsliq_n_u16(__a, __b, __n) __BADC_NEON_SHA(uint16x8_t, __builtin_neon_sli, 8h, 0, __a, __b, __n)
#define vsri_n_u16(__a, __b, __n) __BADC_NEON_SHA(uint16x4_t, __builtin_neon_sri, 4h, 1, __a, __b, __n)
#define vsriq_n_u16(__a, __b, __n) __BADC_NEON_SHA(uint16x8_t, __builtin_neon_sri, 8h, 1, __a, __b, __n)

#define vsli_n_p16(__a, __b, __n) __BADC_NEON_SHA(poly16x4_t, __builtin_neon_sli, 4h, 0, __a, __b, __n)
#define vsliq_n_p16(__a, __b, __n) __BADC_NEON_SHA(poly16x8_t, __builtin_neon_sli, 8h, 0, __a, __b, __n)
#define vsri_n_p16(__a, __b, __n) __BADC_NEON_SHA(poly16x4_t, __builtin_neon_sri, 4h, 1, __a, __b, __n)
#define vsriq_n_p16(__a, __b, __n) __BADC_NEON_SHA(poly16x8_t, __builtin_neon_sri, 8h, 1, __a, __b, __n)

#define vsli_n_s32(__a, __b, __n) __BADC_NEON_SHA(int32x2_t, __builtin_neon_sli, 2s, 0, __a, __b, __n)
#define vsliq_n_s32(__a, __b, __n) __BADC_NEON_SHA(int32x4_t, __builtin_neon_sli, 4s, 0, __a, __b, __n)
#define vsri_n_s32(__a, __b, __n) __BADC_NEON_SHA(int32x2_t, __builtin_neon_sri, 2s, 1, __a, __b, __n)
#define vsriq_n_s32(__a, __b, __n) __BADC_NEON_SHA(int32x4_t, __builtin_neon_sri, 4s, 1, __a, __b, __n)

#define vsli_n_u32(__a, __b, __n) __BADC_NEON_SHA(uint32x2_t, __builtin_neon_sli, 2s, 0, __a, __b, __n)
#define vsliq_n_u32(__a, __b, __n) __BADC_NEON_SHA(uint32x4_t, __builtin_neon_sli, 4s, 0, __a, __b, __n)
#define vsri_n_u32(__a, __b, __n) __BADC_NEON_SHA(uint32x2_t, __builtin_neon_sri, 2s, 1, __a, __b, __n)
#define vsriq_n_u32(__a, __b, __n) __BADC_NEON_SHA(uint32x4_t, __builtin_neon_sri, 4s, 1, __a, __b, __n)

#define vsli_n_s64(__a, __b, __n) __BADC_NEON_SHA(int64x1_t, __builtin_neon_sli, d, 0, __a, __b, __n)
#define vsliq_n_s64(__a, __b, __n) __BADC_NEON_SHA(int64x2_t, __builtin_neon_sli, 2d, 0, __a, __b, __n)
#define vsri_n_s64(__a, __b, __n) __BADC_NEON_SHA(int64x1_t, __builtin_neon_sri, d, 1, __a, __b, __n)
#define vsriq_n_s64(__a, __b, __n) __BADC_NEON_SHA(int64x2_t, __builtin_neon_sri, 2d, 1, __a, __b, __n)

#define vsli_n_u64(__a, __b, __n) __BADC_NEON_SHA(uint64x1_t, __builtin_neon_sli, d, 0, __a, __b, __n)
#define vsliq_n_u64(__a, __b, __n) __BADC_NEON_SHA(uint64x2_t, __builtin_neon_sli, 2d, 0, __a, __b, __n)
#define vsri_n_u64(__a, __b, __n) __BADC_NEON_SHA(uint64x1_t, __builtin_neon_sri, d, 1, __a, __b, __n)
#define vsriq_n_u64(__a, __b, __n) __BADC_NEON_SHA(uint64x2_t, __builtin_neon_sri, 2d, 1, __a, __b, __n)

#define vsli_n_p64(__a, __b, __n) __BADC_NEON_SHA(poly64x1_t, __builtin_neon_sli, d, 0, __a, __b, __n)
#define vsliq_n_p64(__a, __b, __n) __BADC_NEON_SHA(poly64x2_t, __builtin_neon_sli, 2d, 0, __a, __b, __n)
#define vsri_n_p64(__a, __b, __n) __BADC_NEON_SHA(poly64x1_t, __builtin_neon_sri, d, 1, __a, __b, __n)
#define vsriq_n_p64(__a, __b, __n) __BADC_NEON_SHA(poly64x2_t, __builtin_neon_sri, 2d, 1, __a, __b, __n)

#define vshrn_n_s16(__a, __n) __BADC_NEON_SHN(int8x8_t, int16x8_t, __builtin_neon_shrn, 8b, 8h, __a, __n)
#define vrshrn_n_s16(__a, __n) __BADC_NEON_SHN(int8x8_t, int16x8_t, __builtin_neon_rshrn, 8b, 8h, __a, __n)
#define vshrn_n_u16(__a, __n) __BADC_NEON_SHN(uint8x8_t, uint16x8_t, __builtin_neon_shrn, 8b, 8h, __a, __n)
#define vrshrn_n_u16(__a, __n) __BADC_NEON_SHN(uint8x8_t, uint16x8_t, __builtin_neon_rshrn, 8b, 8h, __a, __n)
#define vshrn_n_s32(__a, __n) __BADC_NEON_SHN(int16x4_t, int32x4_t, __builtin_neon_shrn, 4h, 4s, __a, __n)
#define vrshrn_n_s32(__a, __n) __BADC_NEON_SHN(int16x4_t, int32x4_t, __builtin_neon_rshrn, 4h, 4s, __a, __n)
#define vshrn_n_u32(__a, __n) __BADC_NEON_SHN(uint16x4_t, uint32x4_t, __builtin_neon_shrn, 4h, 4s, __a, __n)
#define vrshrn_n_u32(__a, __n) __BADC_NEON_SHN(uint16x4_t, uint32x4_t, __builtin_neon_rshrn, 4h, 4s, __a, __n)
#define vshrn_n_s64(__a, __n) __BADC_NEON_SHN(int32x2_t, int64x2_t, __builtin_neon_shrn, 2s, 2d, __a, __n)
#define vrshrn_n_s64(__a, __n) __BADC_NEON_SHN(int32x2_t, int64x2_t, __builtin_neon_rshrn, 2s, 2d, __a, __n)
#define vshrn_n_u64(__a, __n) __BADC_NEON_SHN(uint32x2_t, uint64x2_t, __builtin_neon_shrn, 2s, 2d, __a, __n)
#define vrshrn_n_u64(__a, __n) __BADC_NEON_SHN(uint32x2_t, uint64x2_t, __builtin_neon_rshrn, 2s, 2d, __a, __n)

/* vqshlu_n: signed lanes shifted left by an immediate in [0, bits - 1],
 * saturating to the unsigned range. */
#define __BADC_NEON_SHU(R, T, A, __a, __n) __extension__({                \
    T __sa = (__a);                                                       \
    __BADC_NEON_SHIFT_RANGE(__n, 0, __sa[0]);                             \
    (R)__builtin_neon_sqshlu_##A(__sa, __n);                              \
})
#define vqshlu_n_s8(__a, __n) __BADC_NEON_SHU(uint8x8_t, int8x8_t, 8b, __a, __n)
#define vqshluq_n_s8(__a, __n) __BADC_NEON_SHU(uint8x16_t, int8x16_t, 16b, __a, __n)
#define vqshlu_n_s16(__a, __n) __BADC_NEON_SHU(uint16x4_t, int16x4_t, 4h, __a, __n)
#define vqshluq_n_s16(__a, __n) __BADC_NEON_SHU(uint16x8_t, int16x8_t, 8h, __a, __n)
#define vqshlu_n_s32(__a, __n) __BADC_NEON_SHU(uint32x2_t, int32x2_t, 2s, __a, __n)
#define vqshluq_n_s32(__a, __n) __BADC_NEON_SHU(uint32x4_t, int32x4_t, 4s, __a, __n)
#define vqshlu_n_s64(__a, __n) __BADC_NEON_SHU(uint64x1_t, int64x1_t, d, __a, __n)
#define vqshluq_n_s64(__a, __n) __BADC_NEON_SHU(uint64x2_t, int64x2_t, 2d, __a, __n)

/* vshll_n: lanes lengthened and shifted left by an immediate in [0, bits];
 * a shift by the lane width is `shll`, the others `sshll` / `ushll`, and
 * the _high forms read the upper half. */
#define __BADC_NEON_SHLL(R, T, sstem, lstem, A, __a, __n) __extension__({  \
    T __sa = (__a);                                                       \
    _Static_assert((__n) >= 0 && (__n) <= 8 * (int)sizeof(__sa[0]), "shift count out of range"); \
    (__n) == 8 * (int)sizeof(__sa[0])                                     \
        ? (R)__BADC_NEON_B(lstem, A)(__sa, 8 * (int)sizeof(__sa[0]))      \
        : (R)__BADC_NEON_B(sstem, A)(__sa, (__n) % (8 * (int)sizeof(__sa[0]))); \
})
#define vshll_n_s8(__a, __n) \
    __BADC_NEON_SHLL(int16x8_t, int8x8_t, __builtin_neon_sshll, __builtin_neon_shll, 8b, __a, __n)
#define vshll_n_u8(__a, __n) \
    __BADC_NEON_SHLL(uint16x8_t, uint8x8_t, __builtin_neon_ushll, __builtin_neon_shll, 8b, __a, __n)
#define vshll_n_s16(__a, __n) \
    __BADC_NEON_SHLL(int32x4_t, int16x4_t, __builtin_neon_sshll, __builtin_neon_shll, 4h, __a, __n)
#define vshll_n_u16(__a, __n) \
    __BADC_NEON_SHLL(uint32x4_t, uint16x4_t, __builtin_neon_ushll, __builtin_neon_shll, 4h, __a, __n)
#define vshll_n_s32(__a, __n) \
    __BADC_NEON_SHLL(int64x2_t, int32x2_t, __builtin_neon_sshll, __builtin_neon_shll, 2s, __a, __n)
#define vshll_n_u32(__a, __n) \
    __BADC_NEON_SHLL(uint64x2_t, uint32x2_t, __builtin_neon_ushll, __builtin_neon_shll, 2s, __a, __n)
#define vshll_high_n_s8(__a, __n) \
    __BADC_NEON_SHLL(int16x8_t, int8x16_t, __builtin_neon_sshll2, __builtin_neon_shll2, 16b, __a, __n)
#define vshll_high_n_u8(__a, __n) \
    __BADC_NEON_SHLL(uint16x8_t, uint8x16_t, __builtin_neon_ushll2, __builtin_neon_shll2, 16b, __a, __n)
#define vshll_high_n_s16(__a, __n) \
    __BADC_NEON_SHLL(int32x4_t, int16x8_t, __builtin_neon_sshll2, __builtin_neon_shll2, 8h, __a, __n)
#define vshll_high_n_u16(__a, __n) \
    __BADC_NEON_SHLL(uint32x4_t, uint16x8_t, __builtin_neon_ushll2, __builtin_neon_shll2, 8h, __a, __n)
#define vshll_high_n_s32(__a, __n) \
    __BADC_NEON_SHLL(int64x2_t, int32x4_t, __builtin_neon_sshll2, __builtin_neon_shll2, 4s, __a, __n)
#define vshll_high_n_u32(__a, __n) \
    __BADC_NEON_SHLL(uint64x2_t, uint32x4_t, __builtin_neon_ushll2, __builtin_neon_shll2, 4s, __a, __n)

/* Byte table lookups in one 16-byte table: an out-of-range index gives 0
 * (vqtbl1), or keeps the destination byte (vqtbx1). */
#define __BADC_NEON_TBL(sfx, D, Q)                                        \
    __BADC_INTRIN D##_t vqtbl1_##sfx(Q##_t __t, uint8x8_t __idx) {        \
        return (D##_t)__builtin_neon_tbl_8b(__t, __idx);                  \
    }                                                                     \
    __BADC_INTRIN Q##_t vqtbl1q_##sfx(Q##_t __t, uint8x16_t __idx) {      \
        return (Q##_t)__builtin_neon_tbl_16b(__t, __idx);                 \
    }                                                                     \
    __BADC_INTRIN D##_t vqtbx1_##sfx(D##_t __d, Q##_t __t, uint8x8_t __idx) { \
        return (D##_t)__builtin_neon_tbx_8b(__d, __t, __idx);             \
    }                                                                     \
    __BADC_INTRIN Q##_t vqtbx1q_##sfx(Q##_t __d, Q##_t __t, uint8x16_t __idx) { \
        return (Q##_t)__builtin_neon_tbx_16b(__d, __t, __idx);            \
    }
__BADC_NEON_TBL(u8, uint8x8, uint8x16)
__BADC_NEON_TBL(s8, int8x8, int8x16)
__BADC_NEON_TBL(p8, poly8x8, poly8x16)

/* AES single rounds (FEAT_AES): AddRoundKey + SubBytes + ShiftRows (aese /
 * aesd) and the [inverse] MixColumns (aesmc / aesimc). */
__BADC_INTRIN uint8x16_t vaeseq_u8(uint8x16_t __d, uint8x16_t __k) {
    return (uint8x16_t)__builtin_neon_aese_16b(__d, __k);
}
__BADC_INTRIN uint8x16_t vaesdq_u8(uint8x16_t __d, uint8x16_t __k) {
    return (uint8x16_t)__builtin_neon_aesd_16b(__d, __k);
}
__BADC_INTRIN uint8x16_t vaesmcq_u8(uint8x16_t __d) {
    return (uint8x16_t)__builtin_neon_aesmc_16b(__d);
}
__BADC_INTRIN uint8x16_t vaesimcq_u8(uint8x16_t __d) {
    return (uint8x16_t)__builtin_neon_aesimc_16b(__d);
}

/* Carry-less (polynomial) products, each lane twice as wide: 8x8->16 on
 * the bytes, and 64x64->128 (FEAT_PMULL); the _high forms take the upper
 * half of each source. */
__BADC_INTRIN poly16x8_t vmull_p8(poly8x8_t __a, poly8x8_t __b) {
    return (poly16x8_t)__builtin_neon_pmull_8b(__a, __b);
}
__BADC_INTRIN poly16x8_t vmull_high_p8(poly8x16_t __a, poly8x16_t __b) {
    return (poly16x8_t)__builtin_neon_pmull2_16b(__a, __b);
}
__BADC_INTRIN poly128_t vmull_p64(poly64_t __a, poly64_t __b) {
    return (poly128_t)__builtin_neon_pmull_1d((poly64x1_t){__a}, (poly64x1_t){__b});
}
__BADC_INTRIN poly128_t vmull_high_p64(poly64x2_t __a, poly64x2_t __b) {
    return (poly128_t)__builtin_neon_pmull2_2d(__a, __b);
}

/* SHA-1 and SHA-256 (FEAT_SHA1, FEAT_SHA256): the hash updates take the
 * running state as a q register, SHA-1's e as an s register; the schedule
 * updates accumulate into their first operand. */
#define __BADC_NEON_SHA1H(name, insn)                                       \
    __BADC_INTRIN uint32x4_t name(uint32x4_t __abcd, uint32_t __e, uint32x4_t __wk) { \
        return (uint32x4_t)__builtin_neon_##insn##_4s(__abcd, (uint32x4_t){__e}, __wk); \
    }
__BADC_NEON_SHA1H(vsha1cq_u32, sha1c)
__BADC_NEON_SHA1H(vsha1pq_u32, sha1p)
__BADC_NEON_SHA1H(vsha1mq_u32, sha1m)
/* sha1h is the rotation of e left by 30, which a general register does. */
__BADC_INTRIN uint32_t vsha1h_u32(uint32_t __e) { return __e << 30 | __e >> 2; }
__BADC_INTRIN uint32x4_t vsha1su0q_u32(uint32x4_t __a, uint32x4_t __b, uint32x4_t __c) {
    return (uint32x4_t)__builtin_neon_sha1su0_4s(__a, __b, __c);
}
__BADC_INTRIN uint32x4_t vsha1su1q_u32(uint32x4_t __a, uint32x4_t __b) {
    return (uint32x4_t)__builtin_neon_sha1su1_4s(__a, __b);
}
__BADC_INTRIN uint32x4_t vsha256hq_u32(uint32x4_t __abcd, uint32x4_t __efgh, uint32x4_t __wk) {
    return (uint32x4_t)__builtin_neon_sha256h_4s(__abcd, __efgh, __wk);
}
__BADC_INTRIN uint32x4_t vsha256h2q_u32(uint32x4_t __efgh, uint32x4_t __abcd, uint32x4_t __wk) {
    return (uint32x4_t)__builtin_neon_sha256h2_4s(__efgh, __abcd, __wk);
}
__BADC_INTRIN uint32x4_t vsha256su0q_u32(uint32x4_t __a, uint32x4_t __b) {
    return (uint32x4_t)__builtin_neon_sha256su0_4s(__a, __b);
}
__BADC_INTRIN uint32x4_t vsha256su1q_u32(uint32x4_t __a, uint32x4_t __b, uint32x4_t __c) {
    return (uint32x4_t)__builtin_neon_sha256su1_4s(__a, __b, __c);
}

/* SHA-512 and SHA3 (FEAT_SHA512, FEAT_SHA3): the hash and schedule
 * updates, the three-way xor `eor3`, `bcax` (a ^ (b & ~c)), `rax1`
 * (a ^ rol(b, 1)) and `xar` (ror(a ^ b, imm)). */
__BADC_INTRIN uint64x2_t vsha512hq_u64(uint64x2_t __a, uint64x2_t __b, uint64x2_t __c) {
    return (uint64x2_t)__builtin_neon_sha512h_2d(__a, __b, __c);
}
__BADC_INTRIN uint64x2_t vsha512h2q_u64(uint64x2_t __a, uint64x2_t __b, uint64x2_t __c) {
    return (uint64x2_t)__builtin_neon_sha512h2_2d(__a, __b, __c);
}
__BADC_INTRIN uint64x2_t vsha512su0q_u64(uint64x2_t __a, uint64x2_t __b) {
    return (uint64x2_t)__builtin_neon_sha512su0_2d(__a, __b);
}
__BADC_INTRIN uint64x2_t vsha512su1q_u64(uint64x2_t __a, uint64x2_t __b, uint64x2_t __c) {
    return (uint64x2_t)__builtin_neon_sha512su1_2d(__a, __b, __c);
}
#define __BADC_NEON_XOR3(name, T, insn)                                     \
    __BADC_INTRIN T name(T __a, T __b, T __c) {                             \
        return (T)__builtin_neon_##insn##_16b(__a, __b, __c);               \
    }
__BADC_NEON_XOR3(veor3q_u8, uint8x16_t, eor3)
__BADC_NEON_XOR3(vbcaxq_u8, uint8x16_t, bcax)
__BADC_NEON_XOR3(veor3q_u16, uint16x8_t, eor3)
__BADC_NEON_XOR3(vbcaxq_u16, uint16x8_t, bcax)
__BADC_NEON_XOR3(veor3q_u32, uint32x4_t, eor3)
__BADC_NEON_XOR3(vbcaxq_u32, uint32x4_t, bcax)
__BADC_NEON_XOR3(veor3q_u64, uint64x2_t, eor3)
__BADC_NEON_XOR3(vbcaxq_u64, uint64x2_t, bcax)
__BADC_NEON_XOR3(veor3q_s8, int8x16_t, eor3)
__BADC_NEON_XOR3(vbcaxq_s8, int8x16_t, bcax)
__BADC_NEON_XOR3(veor3q_s16, int16x8_t, eor3)
__BADC_NEON_XOR3(vbcaxq_s16, int16x8_t, bcax)
__BADC_NEON_XOR3(veor3q_s32, int32x4_t, eor3)
__BADC_NEON_XOR3(vbcaxq_s32, int32x4_t, bcax)
__BADC_NEON_XOR3(veor3q_s64, int64x2_t, eor3)
__BADC_NEON_XOR3(vbcaxq_s64, int64x2_t, bcax)
__BADC_INTRIN uint64x2_t vrax1q_u64(uint64x2_t __a, uint64x2_t __b) {
    return (uint64x2_t)__builtin_neon_rax1_2d(__a, __b);
}
#define vxarq_u64(__a, __b, __n) __extension__({                            \
    uint64x2_t __xa = (__a), __xb = (__b);                                  \
    _Static_assert((__n) >= 0 && (__n) < 64, "rotate count out of range"); \
    (uint64x2_t)__builtin_neon_xar_2d(__xa, __xb, __n);                     \
})

/* SM3 and SM4 (FEAT_SM3, FEAT_SM4). */
__BADC_INTRIN uint32x4_t vsm3ss1q_u32(uint32x4_t __a, uint32x4_t __b, uint32x4_t __c) {
    uint32x4_t __r;
    __asm__("sm3ss1 %0.4s, %1.4s, %2.4s, %3.4s"
            : "=w"(__r) : "w"(__a), "w"(__b), "w"(__c));
    return __r;
}
#define __BADC_NEON_SM3TT(insn, __a, __b, __c, __n) __extension__({         \
    uint32x4_t __ta = (__a), __tb = (__b), __tc = (__c);                    \
    __BADC_NEON_LANE(__n, 4);                                               \
    __asm__(insn " %0.4s, %1.4s, %2.s[%3]"                                  \
            : "+w"(__ta) : "w"(__tb), "w"(__tc), "i"(__n));                 \
    __ta;                                                                   \
})
#define vsm3tt1aq_u32(__a, __b, __c, __n) __BADC_NEON_SM3TT("sm3tt1a", __a, __b, __c, __n)
#define vsm3tt1bq_u32(__a, __b, __c, __n) __BADC_NEON_SM3TT("sm3tt1b", __a, __b, __c, __n)
#define vsm3tt2aq_u32(__a, __b, __c, __n) __BADC_NEON_SM3TT("sm3tt2a", __a, __b, __c, __n)
#define vsm3tt2bq_u32(__a, __b, __c, __n) __BADC_NEON_SM3TT("sm3tt2b", __a, __b, __c, __n)
__BADC_NEON_FN3(vsm3partw1q_u32, uint32x4_t, uint32x4_t, uint32x4_t,
                __BADC_NEON_I3("sm3partw1", 4s, 4s, 4s))
__BADC_NEON_FN3(vsm3partw2q_u32, uint32x4_t, uint32x4_t, uint32x4_t,
                __BADC_NEON_I3("sm3partw2", 4s, 4s, 4s))
__BADC_INTRIN uint32x4_t vsm4eq_u32(uint32x4_t __a, uint32x4_t __b) {
    __asm__("sm4e %0.4s, %1.4s" : "+w"(__a) : "w"(__b));
    return __a;
}
__BADC_NEON_FN2(vsm4ekeyq_u32, uint32x4_t, uint32x4_t, uint32x4_t,
                __BADC_NEON_I3("sm4ekey", 4s, 4s, 4s))

/* Floating vectors. The float64x1_t arithmetic is the scalar d-register
 * instruction; its compares and integer conversions are C on the one lane.
 * ARITH2 and ARITH1 call the rows of `stem`. */
#define __BADC_NEON_ARITH2(op, stem)                                      \
    __BADC_NEON_B2(op##_f32, float32x2_t, float32x2_t, float32x2_t, s, stem, stem, 2s) \
    __BADC_NEON_B2(op##q_f32, float32x4_t, float32x4_t, float32x4_t, s, stem, stem, 4s) \
    __BADC_NEON_B2(op##q_f64, float64x2_t, float64x2_t, float64x2_t, s, stem, stem, 2d) \
    __BADC_NEON_B2(op##_f64, float64x1_t, float64x1_t, float64x1_t, s, stem, stem, d)
#define __BADC_NEON_ARITH1(op, stem)                                      \
    __BADC_NEON_B1(op##_f32, float32x2_t, float32x2_t, s, stem, stem, 2s) \
    __BADC_NEON_B1(op##q_f32, float32x4_t, float32x4_t, s, stem, stem, 4s) \
    __BADC_NEON_B1(op##q_f64, float64x2_t, float64x2_t, s, stem, stem, 2d) \
    __BADC_NEON_B1(op##_f64, float64x1_t, float64x1_t, s, stem, stem, d)
/* A compare, operands in B's order; C on the one lane of float64x1_t. */
#define __BADC_NEON_CMP(op, B, stem, rel)                                 \
    B(op##_f32, uint32x2_t, float32x2_t, float32x2_t, s, stem, stem, 2s)  \
    B(op##q_f32, uint32x4_t, float32x4_t, float32x4_t, s, stem, stem, 4s) \
    B(op##q_f64, uint64x2_t, float64x2_t, float64x2_t, s, stem, stem, 2d) \
    __BADC_INTRIN uint64x1_t op##_f64(float64x1_t __a, float64x1_t __b) { \
        return (uint64x1_t){-(uint64_t)(__a[0] rel __b[0])};              \
    }

__BADC_NEON_ARITH2(vadd, __builtin_neon_fadd)
__BADC_NEON_ARITH2(vsub, __builtin_neon_fsub)
__BADC_NEON_ARITH2(vmul, __builtin_neon_fmul)
__BADC_NEON_ARITH2(vdiv, __builtin_neon_fdiv)
__BADC_NEON_ARITH2(vmax, __builtin_neon_fmax)
__BADC_NEON_ARITH2(vmin, __builtin_neon_fmin)
__BADC_NEON_ARITH1(vabs, __builtin_neon_fabs)
__BADC_NEON_ARITH1(vneg, __builtin_neon_fneg)
__BADC_NEON_ARITH1(vsqrt, __builtin_neon_fsqrt)

/* The reciprocal and reciprocal square root estimates, and their
 * Newton-Raphson steps: vrecps is 2 - a * b, vrsqrts (3 - a * b) / 2. The
 * scalar forms are lane 0 of the vector ones; the u32 estimates read each
 * lane as a fraction below 1. */
__BADC_NEON_ARITH1(vrecpe, __builtin_neon_frecpe)
__BADC_NEON_ARITH1(vrsqrte, __builtin_neon_frsqrte)
__BADC_NEON_ARITH2(vrecps, __builtin_neon_frecps)
__BADC_NEON_ARITH2(vrsqrts, __builtin_neon_frsqrts)
#define __BADC_NEON_EST_SCALAR(op)                                        \
    __BADC_INTRIN float32_t op##s_f32(float32_t __a) { return op##_f32((float32x2_t){__a})[0]; } \
    __BADC_INTRIN float64_t op##d_f64(float64_t __a) { return op##_f64((float64x1_t){__a})[0]; }
#define __BADC_NEON_STEP_SCALAR(op)                                       \
    __BADC_INTRIN float32_t op##s_f32(float32_t __a, float32_t __b) {     \
        return op##_f32((float32x2_t){__a}, (float32x2_t){__b})[0];       \
    }                                                                     \
    __BADC_INTRIN float64_t op##d_f64(float64_t __a, float64_t __b) {     \
        return op##_f64((float64x1_t){__a}, (float64x1_t){__b})[0];       \
    }
__BADC_NEON_EST_SCALAR(vrecpe)
__BADC_NEON_EST_SCALAR(vrsqrte)
__BADC_NEON_STEP_SCALAR(vrecps)
__BADC_NEON_STEP_SCALAR(vrsqrts)
__BADC_NEON_B1(vrecpe_u32, uint32x2_t, uint32x2_t, s, __builtin_neon_urecpe, _, 2s)
__BADC_NEON_B1(vrecpeq_u32, uint32x4_t, uint32x4_t, s, __builtin_neon_urecpe, _, 4s)
__BADC_NEON_B1(vrsqrte_u32, uint32x2_t, uint32x2_t, s, __builtin_neon_ursqrte, _, 2s)
__BADC_NEON_B1(vrsqrteq_u32, uint32x4_t, uint32x4_t, s, __builtin_neon_ursqrte, _, 4s)

/* vfma: a + b * c, vfms: a - b * c, each rounded once. */
#define __BADC_NEON_FUSED(op, stem)                                       \
    __BADC_NEON_B3(op##_f32, float32x2_t, s, stem, stem, 2s)              \
    __BADC_NEON_B3(op##q_f32, float32x4_t, s, stem, stem, 4s)             \
    __BADC_NEON_B3(op##q_f64, float64x2_t, s, stem, stem, 2d)
__BADC_NEON_FUSED(vfma, __builtin_neon_fmla)
__BADC_NEON_FUSED(vfms, __builtin_neon_fmls)
__BADC_INTRIN float64x1_t vfma_f64(float64x1_t __a, float64x1_t __b, float64x1_t __c) {
    return (float64x1_t){__builtin_fma(__b[0], __c[0], __a[0])};
}
__BADC_INTRIN float64x1_t vfms_f64(float64x1_t __a, float64x1_t __b, float64x1_t __c) {
    return (float64x1_t){__builtin_fma(-__b[0], __c[0], __a[0])};
}

__BADC_NEON_CMP(vceq, __BADC_NEON_B2, __builtin_neon_fcmeq, ==)
__BADC_NEON_CMP(vcge, __BADC_NEON_B2, __builtin_neon_fcmge, >=)
__BADC_NEON_CMP(vcgt, __BADC_NEON_B2, __builtin_neon_fcmgt, >)
__BADC_NEON_CMP(vcle, __BADC_NEON_B2R, __builtin_neon_fcmge, <=)
__BADC_NEON_CMP(vclt, __BADC_NEON_B2R, __builtin_neon_fcmgt, <)

/* Compares against zero: all-ones lanes where the relation to 0 holds.
 * The scalar forms are lane 0 of the vector ones. */
#define __BADC_NEON_F_CMPZ(op, stem, sfx, k, E, D, Q, AD, AQ, UD, UQ, ...) \
    __BADC_NEON_B1(op##_##sfx, UD, D, s, stem, stem, AD)                  \
    __BADC_NEON_B1(op##q_##sfx, UQ, Q, s, stem, stem, AQ)
#define __BADC_NEON_CMPZ(op, istem, fstem)                                \
    __BADC_NEON_SINT(__BADC_NEON_F_CMPZ, op, istem)                       \
    __BADC_NEON_R_f32(__BADC_NEON_F_CMPZ, op, fstem)                      \
    __BADC_NEON_R_f64(__BADC_NEON_F_CMPZ, op, fstem)                      \
    __BADC_INTRIN uint64_t op##d_s64(int64_t __a) { return op##_s64((int64x1_t){__a})[0]; } \
    __BADC_INTRIN uint32_t op##s_f32(float32_t __a) { return op##_f32((float32x2_t){__a})[0]; } \
    __BADC_INTRIN uint64_t op##d_f64(float64_t __a) { return op##_f64((float64x1_t){__a})[0]; }
__BADC_NEON_CMPZ(vceqz, __builtin_neon_cmeqz, __builtin_neon_fcmeqz)
__BADC_NEON_CMPZ(vcgez, __builtin_neon_cmgez, __builtin_neon_fcmgez)
__BADC_NEON_CMPZ(vcgtz, __builtin_neon_cmgtz, __builtin_neon_fcmgtz)
__BADC_NEON_CMPZ(vclez, __builtin_neon_cmlez, __builtin_neon_fcmlez)
__BADC_NEON_CMPZ(vcltz, __builtin_neon_cmltz, __builtin_neon_fcmltz)
#define __BADC_NEON_F_CMPZU(_, sfx, k, E, D, Q, AD, AQ, UD, UQ, ...)      \
    __BADC_NEON_F_CMPZ(vceqz, __builtin_neon_cmeqz, sfx, k, E, D, Q, AD, AQ, UD, UQ)
__BADC_NEON_R_u8(__BADC_NEON_F_CMPZU, _)
__BADC_NEON_R_u16(__BADC_NEON_F_CMPZU, _)
__BADC_NEON_R_u32(__BADC_NEON_F_CMPZU, _)
__BADC_NEON_R_u64(__BADC_NEON_F_CMPZU, _)
__BADC_NEON_R_p8(__BADC_NEON_F_CMPZU, _)
__BADC_NEON_R_p64(__BADC_NEON_F_CMPZU, _)
__BADC_INTRIN uint64_t vceqzd_u64(uint64_t __a) { return vceqz_u64((uint64x1_t){__a})[0]; }

/* Integer <-> floating lanes of one width; to integer truncates toward
 * zero and saturates. */
#define __BADC_NEON_CVT(name, R, T, insn, A)                               \
    __BADC_INTRIN R name(T __a) { return (R)__builtin_neon_##insn##_##A(__a); }
__BADC_NEON_CVT(vcvt_f32_s32, float32x2_t, int32x2_t, scvtf, 2s)
__BADC_NEON_CVT(vcvtq_f32_s32, float32x4_t, int32x4_t, scvtf, 4s)
__BADC_NEON_CVT(vcvt_f32_u32, float32x2_t, uint32x2_t, ucvtf, 2s)
__BADC_NEON_CVT(vcvtq_f32_u32, float32x4_t, uint32x4_t, ucvtf, 4s)
__BADC_NEON_CVT(vcvtq_f64_s64, float64x2_t, int64x2_t, scvtf, 2d)
__BADC_NEON_CVT(vcvtq_f64_u64, float64x2_t, uint64x2_t, ucvtf, 2d)
__BADC_NEON_CVT(vcvt_s32_f32, int32x2_t, float32x2_t, fcvtzs, 2s)
__BADC_NEON_CVT(vcvtq_s32_f32, int32x4_t, float32x4_t, fcvtzs, 4s)
__BADC_NEON_CVT(vcvt_u32_f32, uint32x2_t, float32x2_t, fcvtzu, 2s)
__BADC_NEON_CVT(vcvtq_u32_f32, uint32x4_t, float32x4_t, fcvtzu, 4s)
__BADC_NEON_CVT(vcvtq_s64_f64, int64x2_t, float64x2_t, fcvtzs, 2d)
__BADC_NEON_CVT(vcvtq_u64_f64, uint64x2_t, float64x2_t, fcvtzu, 2d)
__BADC_INTRIN float64x1_t vcvt_f64_s64(int64x1_t __a) { return (float64x1_t){(float64_t)__a[0]}; }
__BADC_INTRIN float64x1_t vcvt_f64_u64(uint64x1_t __a) { return (float64x1_t){(float64_t)__a[0]}; }
__BADC_INTRIN int64x1_t vcvt_s64_f64(float64x1_t __a) { return (int64x1_t){(int64_t)__a[0]}; }
__BADC_INTRIN uint64x1_t vcvt_u64_f64(float64x1_t __a) { return (uint64x1_t){(uint64_t)__a[0]}; }

/* Single <-> double: the lower lanes, or with _high the upper ones. */
__BADC_INTRIN float64x2_t vcvt_f64_f32(float32x2_t __a) {
    return (float64x2_t)__builtin_neon_fcvtl_2s(__a);
}
__BADC_INTRIN float64x2_t vcvt_high_f64_f32(float32x4_t __a) {
    return (float64x2_t)__builtin_neon_fcvtl2_4s(__a);
}
__BADC_INTRIN float32x2_t vcvt_f32_f64(float64x2_t __a) {
    return (float32x2_t)__builtin_neon_fcvtn_2d(__a);
}
__BADC_INTRIN float32x4_t vcvt_high_f32_f64(float32x2_t __lo, float64x2_t __a) {
    return vcombine_f32(__lo, vcvt_f32_f64(__a));
}

/* Structure loads: deinterleave lane by lane into the structure types. */
__BADC_INTRIN uint16x8x2_t vld2q_u16(const uint16_t *__p) {
    uint16x8x2_t __r;
    for (int __i = 0; __i < 8; __i++) {
        __r.val[0][__i] = __p[2 * __i];
        __r.val[1][__i] = __p[2 * __i + 1];
    }
    return __r;
}

__BADC_INTRIN uint8x16x4_t vld4q_u8(const uint8_t *__p) {
    uint8x16x4_t __r;
    for (int __i = 0; __i < 16; __i++)
        for (int __k = 0; __k < 4; __k++)
            __r.val[__k][__i] = __p[4 * __i + __k];
    return __r;
}

#pragma pop_macro("__attribute__")

#endif /* BADC_ARM_NEON_H */
