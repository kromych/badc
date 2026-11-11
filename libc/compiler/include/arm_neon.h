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
 * vrsra_n vsli_n vsri_n vshrn_n vrshrn_n, vmovl vmovn vqmovn vqmovun vaddl
 * vsubl vaddw vsubw vmull vmlal vmlsl with their _high forms, vaddv vaddlv
 * vmaxv vminv. Floating: vadd vsub vmul vdiv vmax vmin vabs vneg vsqrt vfma
 * vfms vrecpe vrecps vrsqrte vrsqrts, the compares, and the conversions to
 * and from the integers of one width (truncating) and between single and
 * double. Also vmul_p8, vqtbl1q_u8, vqtbx1q_u8, the FEAT_AES rounds,
 * vmull_p64, vmull_high_p64, the SHA-1, SHA-256, SHA-512, SHA3, SM3 and
 * SM4 intrinsics, vld2q_u16 and vld4q_u8.
 *
 * Not provided: float16, bfloat16, the lane-indexed and by-scalar forms,
 * the doubling multiplies, the saturating narrowing shifts, vqshlu_n,
 * vshll_n, vabdl, vabal, vpadal, compares against zero, the other structure
 * loads, stores and table lookups, the floating pairwise, across-lane,
 * absolute-difference, rounding and maxnum forms, the fixed-point and
 * rounding-mode conversions and the dot products.
 *
 * The element typedefs match <stdint.h>, repeated so the header serves
 * freestanding units; poly128_t is carried as a 16-byte vector.
 */
#ifndef BADC_ARM_NEON_H
#define BADC_ARM_NEON_H

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

/* Operand n of a template in arrangement A; `d` is the 64-bit scalar view
 * the single-lane 64-bit forms take. */
#define __BADC_NEON_V(A, n) __BADC_NEON_V_##A(n)
#define __BADC_NEON_V_8b(n) "%" #n ".8b"
#define __BADC_NEON_V_16b(n) "%" #n ".16b"
#define __BADC_NEON_V_4h(n) "%" #n ".4h"
#define __BADC_NEON_V_8h(n) "%" #n ".8h"
#define __BADC_NEON_V_2s(n) "%" #n ".2s"
#define __BADC_NEON_V_4s(n) "%" #n ".4s"
#define __BADC_NEON_V_1d(n) "%" #n ".1d"
#define __BADC_NEON_V_2d(n) "%" #n ".2d"
#define __BADC_NEON_V_d(n) "%d" #n
/* `insn` over operands 0, 1 (and 2) in arrangements A, B (and C). */
#define __BADC_NEON_I2(insn, A, B) insn " " __BADC_NEON_V_##A(0) ", " __BADC_NEON_V_##B(1)
#define __BADC_NEON_I3(insn, A, B, C)                                     \
    insn " " __BADC_NEON_V_##A(0) ", " __BADC_NEON_V_##B(1) ", " __BADC_NEON_V_##C(2)
#define __BADC_NEON_I3R(insn, A, B, C)                                    \
    insn " " __BADC_NEON_V_##A(0) ", " __BADC_NEON_V_##B(2) ", " __BADC_NEON_V_##C(1)
/* The signed or unsigned choice by kind; a polynomial lane is unsigned. */
#define __BADC_NEON_PICK(k, s, u) __BADC_NEON_PICK_##k(s, u)
#define __BADC_NEON_PICK_s(s, u) s
#define __BADC_NEON_PICK_u(s, u) u
#define __BADC_NEON_PICK_p(s, u) u
/* The kind's instruction over three operands in arrangement A. */
#define __BADC_NEON_K3(k, si, ui, A) __BADC_NEON_I3(__BADC_NEON_PICK(k, si, ui), A, A, A)
/* The compiler's row of the instruction a builtin stem names, in
 * arrangement A; its result is read as the vector R. B2R swaps the
 * operands. */
#define __BADC_NEON_B(stem, A) __BADC_NEON_B_(stem, A)
#define __BADC_NEON_B_(stem, A) stem##_##A
#define __BADC_NEON_B2(name, R, T, U, k, si, ui, A)                       \
    static inline R name(T __a, U __b) {                                  \
        return (R)__BADC_NEON_B(__BADC_NEON_PICK(k, si, ui), A)(__a, __b); \
    }
#define __BADC_NEON_B2R(name, R, T, U, k, si, ui, A)                      \
    static inline R name(T __a, U __b) {                                  \
        return (R)__BADC_NEON_B(__BADC_NEON_PICK(k, si, ui), A)(__b, __a); \
    }
#define __BADC_NEON_B1(name, R, T, k, si, ui, A)                          \
    static inline R name(T __a) {                                         \
        return (R)__BADC_NEON_B(__BADC_NEON_PICK(k, si, ui), A)(__a);     \
    }
/* The accumulator __a is the first operand and the result. */
#define __BADC_NEON_B3(name, R, k, si, ui, A)                             \
    static inline R name(R __a, R __b, R __c) {                           \
        return (R)__BADC_NEON_B(__BADC_NEON_PICK(k, si, ui), A)(__a, __b, __c); \
    }

/* One instruction into R; FN3 accumulates into __a, FROMR reads an `r`. */
#define __BADC_NEON_FN1(name, R, T, tmpl)                                 \
    static inline R name(T __a) {                                         \
        R __r;                                                            \
        __asm__(tmpl : "=w"(__r) : "w"(__a));                             \
        return __r;                                                       \
    }
#define __BADC_NEON_FN2(name, R, T, U, tmpl)                              \
    static inline R name(T __a, U __b) {                                  \
        R __r;                                                            \
        __asm__(tmpl : "=w"(__r) : "w"(__a), "w"(__b));                   \
        return __r;                                                       \
    }
#define __BADC_NEON_FN3(name, R, T, U, tmpl)                              \
    static inline R name(R __a, T __b, U __c) {                           \
        __asm__(tmpl : "+w"(__a) : "w"(__b), "w"(__c));                   \
        return __a;                                                       \
    }
#define __BADC_NEON_FROMR(name, R, E, tmpl)                               \
    static inline R name(E __x) {                                         \
        R __r;                                                            \
        __asm__(tmpl : "=w"(__r) : "r"(__x));                             \
        return __r;                                                       \
    }
#define __BADC_NEON_LOAD(name, T, E, tmpl)                                \
    static inline T name(const E *__p) {                                  \
        T __r;                                                            \
        __asm__(tmpl : "=w"(__r) : "r"(__p) : "memory");                  \
        return __r;                                                       \
    }
#define __BADC_NEON_STORE(name, T, E, view)                               \
    static inline void name(E *__p, T __v) {                              \
        __asm__("str %" view "1, [%0]" : : "r"(__p), "w"(__v) : "memory"); \
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

/* Loads and stores: ldr/str of the vector, ld1r of one element. */
#define __BADC_NEON_F_MEM(_, sfx, k, E, D, Q, AD, AQ, ...)                \
    __BADC_NEON_LOAD(vld1_##sfx, D, E, "ldr %d0, [%1]")                   \
    __BADC_NEON_LOAD(vld1q_##sfx, Q, E, "ldr %q0, [%1]")                  \
    __BADC_NEON_STORE(vst1_##sfx, D, E, "d")                              \
    __BADC_NEON_STORE(vst1q_##sfx, Q, E, "q")                             \
    __BADC_NEON_LOAD(vld1q_dup_##sfx, Q, E, "ld1r {" __BADC_NEON_V(AQ, 0) "}, [%1]")
#define __BADC_NEON_F_LD1R(_, sfx, k, E, D, Q, AD, ...)                   \
    __BADC_NEON_LOAD(vld1_dup_##sfx, D, E, "ld1r {" __BADC_NEON_V(AD, 0) "}, [%1]")
#define __BADC_NEON_F_LD1R1(_, sfx, k, E, D, ...)                         \
    __BADC_NEON_LOAD(vld1_dup_##sfx, D, E, "ldr %d0, [%1]")
__BADC_NEON_ALL(__BADC_NEON_F_MEM, _)
__BADC_NEON_LANES(__BADC_NEON_F_LD1R, _)
__BADC_NEON_E64(__BADC_NEON_F_LD1R1, _)

/* Broadcasts: dup from a general register or a float's lane 0; fmov for one
 * 64-bit lane. */
#define __BADC_NEON_F_DUP(_, sfx, k, E, D, Q, AD, AQ, ...)                \
    __BADC_NEON_FROMR(vdup_n_##sfx, D, E, "dup " __BADC_NEON_V(AD, 0) ", %w1") \
    __BADC_NEON_FROMR(vdupq_n_##sfx, Q, E, "dup " __BADC_NEON_V(AQ, 0) ", %w1")
#define __BADC_NEON_F_DUP64(_, sfx, k, E, D, Q, ...)                      \
    __BADC_NEON_FROMR(vdup_n_##sfx, D, E, "fmov %d0, %x1")                \
    __BADC_NEON_FROMR(vdupq_n_##sfx, Q, E, "dup %0.2d, %x1")
#define __BADC_NEON_F_MOV(_, sfx, k, E, D, Q, ...)                        \
    static inline D vmov_n_##sfx(E __x) { return vdup_n_##sfx(__x); }     \
    static inline Q vmovq_n_##sfx(E __x) { return vdupq_n_##sfx(__x); }
__BADC_NEON_INT_8_32(__BADC_NEON_F_DUP, _)
__BADC_NEON_R_p8(__BADC_NEON_F_DUP, _)
__BADC_NEON_R_p16(__BADC_NEON_F_DUP, _)
__BADC_NEON_I64(__BADC_NEON_F_DUP64, _)
__BADC_NEON_R_p64(__BADC_NEON_F_DUP64, _)
__BADC_NEON_FN1(vdup_n_f32, float32x2_t, float32_t, "dup %0.2s, %1.s[0]")
__BADC_NEON_FN1(vdupq_n_f32, float32x4_t, float32_t, "dup %0.4s, %1.s[0]")
__BADC_NEON_FN1(vdup_n_f64, float64x1_t, float64_t, "fmov %d0, %d1")
__BADC_NEON_FN1(vdupq_n_f64, float64x2_t, float64_t, "dup %0.2d, %1.d[0]")
__BADC_NEON_ALL(__BADC_NEON_F_MOV, _)

/* Halves and the concatenation of two. */
#define __BADC_NEON_F_HALF(_, sfx, k, E, D, Q, ...)                       \
    __BADC_NEON_FN1(vget_low_##sfx, D, Q, "mov %d0, %1.d[0]")             \
    __BADC_NEON_FN1(vget_high_##sfx, D, Q, "mov %d0, %1.d[1]")            \
    __BADC_NEON_FN2(vcombine_##sfx, Q, D, D, "zip1 %0.2d, %1.2d, %2.2d")
__BADC_NEON_ALL(__BADC_NEON_F_HALF, _)

/* Reinterpretations: casts between vector types of one width. AFTER_x
 * names the rows after x in ALL's order, so each pair is spelled once. */
#define __BADC_NEON_F_CAST(a, A, AQ, b, k, E, B, BQ, ...)                 \
    static inline A vreinterpret_##a##_##b(B __x) { return (A)__x; }      \
    static inline B vreinterpret_##b##_##a(A __x) { return (B)__x; }      \
    static inline AQ vreinterpretq_##a##_##b(BQ __x) { return (AQ)__x; }  \
    static inline BQ vreinterpretq_##b##_##a(AQ __x) { return (BQ)__x; }
#define __BADC_NEON_F_CASTS(_, a, k, E, A, AQ, ...)                       \
    __BADC_NEON_AFTER_##a(__BADC_NEON_F_CAST, a, A, AQ)                   \
    static inline poly128_t vreinterpretq_p128_##a(AQ __x) { return (poly128_t)__x; } \
    static inline AQ vreinterpretq_##a##_p128(poly128_t __x) { return (AQ)__x; }
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
#define __BADC_NEON_F_PERM(op, insn, sfx, k, E, D, Q, AD, AQ, ...)        \
    __BADC_NEON_FN2(op##_##sfx, D, D, D, __BADC_NEON_I3(insn, AD, AD, AD)) \
    __BADC_NEON_FN2(op##q_##sfx, Q, Q, Q, __BADC_NEON_I3(insn, AQ, AQ, AQ))
#define __BADC_NEON_F_PERMQ(op, insn, sfx, k, E, D, Q, AD, AQ, ...)       \
    __BADC_NEON_FN2(op##q_##sfx, Q, Q, Q, __BADC_NEON_I3(insn, AQ, AQ, AQ))
#define __BADC_NEON_PERMS(op, insn)                                       \
    __BADC_NEON_LANES(__BADC_NEON_F_PERM, op, insn)                       \
    __BADC_NEON_E64(__BADC_NEON_F_PERMQ, op, insn)
__BADC_NEON_PERMS(vzip1, "zip1")
__BADC_NEON_PERMS(vzip2, "zip2")
__BADC_NEON_PERMS(vuzp1, "uzp1")
__BADC_NEON_PERMS(vuzp2, "uzp2")
__BADC_NEON_PERMS(vtrn1, "trn1")
__BADC_NEON_PERMS(vtrn2, "trn2")
#define __BADC_NEON_PAIR(op, sfx, DN, QN)                                 \
    static inline DN##x2_t op##_##sfx(DN##_t __a, DN##_t __b) {           \
        return (DN##x2_t){{op##1_##sfx(__a, __b), op##2_##sfx(__a, __b)}}; \
    }                                                                     \
    static inline QN##x2_t op##q_##sfx(QN##_t __a, QN##_t __b) {          \
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
#define __BADC_NEON_F_UNX(op, insn, sfx, k, E, D, Q, AD, AQ, ...)         \
    __BADC_NEON_FN1(op##_##sfx, D, D, __BADC_NEON_I2(insn, AD, AD))       \
    __BADC_NEON_FN1(op##q_##sfx, Q, Q, __BADC_NEON_I2(insn, AQ, AQ))
__BADC_NEON_E8(__BADC_NEON_F_UNX, vrev16, "rev16")
__BADC_NEON_E8(__BADC_NEON_F_UNX, vrev32, "rev32")
__BADC_NEON_E16(__BADC_NEON_F_UNX, vrev32, "rev32")
__BADC_NEON_LANES(__BADC_NEON_F_UNX, vrev64, "rev64")

/* Bitwise select: the mask's set bits take the first operand's. */
#define __BADC_NEON_BSL(name, M, T, A)                                    \
    static inline T name(M __m, T __a, T __b) {                           \
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
__BADC_NEON_FN2(vmul_p8, poly8x8_t, poly8x8_t, poly8x8_t, "pmul %0.8b, %1.8b, %2.8b")
__BADC_NEON_FN2(vmulq_p8, poly8x16_t, poly8x16_t, poly8x16_t, "pmul %0.16b, %1.16b, %2.16b")

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
    __BADC_NEON_FN2(op##_##sfx, D, D, SD, __BADC_NEON_K3(k, si, ui, AD))  \
    __BADC_NEON_FN2(op##q_##sfx, Q, Q, SQ, __BADC_NEON_K3(k, si, ui, AQ))
__BADC_NEON_INT(__BADC_NEON_F_CMP, vceq, __builtin_neon_cmeq, __builtin_neon_cmeq)
__BADC_NEON_R_p8(__BADC_NEON_F_CMP, vceq, __builtin_neon_cmeq, __builtin_neon_cmeq)
__BADC_NEON_R_p64(__BADC_NEON_F_CMP, vceq, __builtin_neon_cmeq, __builtin_neon_cmeq)
__BADC_NEON_INT(__BADC_NEON_F_CMP, vcge, __builtin_neon_cmge, __builtin_neon_cmhs)
__BADC_NEON_INT(__BADC_NEON_F_CMP, vcgt, __builtin_neon_cmgt, __builtin_neon_cmhi)
__BADC_NEON_INT(__BADC_NEON_F_CMPR, vcle, __builtin_neon_cmge, __builtin_neon_cmhs)
__BADC_NEON_INT(__BADC_NEON_F_CMPR, vclt, __builtin_neon_cmgt, __builtin_neon_cmhi)
__BADC_NEON_INT(__BADC_NEON_F_CMP, vtst, __builtin_neon_cmtst, __builtin_neon_cmtst)
__BADC_NEON_R_p8(__BADC_NEON_F_CMP, vtst, __builtin_neon_cmtst, __builtin_neon_cmtst)
__BADC_NEON_INT(__BADC_NEON_F_SHL, vshl, "sshl", "ushl")
__BADC_NEON_INT(__BADC_NEON_F_SHL, vrshl, "srshl", "urshl")
__BADC_NEON_INT(__BADC_NEON_F_SHL, vqshl, "sqshl", "uqshl")

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
#define __BADC_NEON_F_LONG(op, si, ui, n, w, k, ND, NQ, WD, WQ, NA, NAQ, WAD, WAQ, ...) \
    __BADC_NEON_FN2(op##_##n, WQ, ND, ND,                                 \
                    __BADC_NEON_I3(__BADC_NEON_PICK(k, si, ui), WAQ, NA, NA)) \
    __BADC_NEON_FN2(op##_high_##n, WQ, NQ, NQ,                            \
                    __BADC_NEON_I3(__BADC_NEON_PICK(k, si "2", ui "2"), WAQ, NAQ, NAQ))
#define __BADC_NEON_F_LONGACC(op, si, ui, n, w, k, ND, NQ, WD, WQ, NA, NAQ, WAD, WAQ, ...) \
    __BADC_NEON_FN3(op##_##n, WQ, ND, ND,                                 \
                    __BADC_NEON_I3(__BADC_NEON_PICK(k, si, ui), WAQ, NA, NA)) \
    __BADC_NEON_FN3(op##_high_##n, WQ, NQ, NQ,                            \
                    __BADC_NEON_I3(__BADC_NEON_PICK(k, si "2", ui "2"), WAQ, NAQ, NAQ))
#define __BADC_NEON_F_WIDEN(op, si, ui, n, w, k, ND, NQ, WD, WQ, NA, NAQ, WAD, WAQ, ...) \
    __BADC_NEON_FN2(op##_##n, WQ, WQ, ND,                                 \
                    __BADC_NEON_I3(__BADC_NEON_PICK(k, si, ui), WAQ, WAQ, NA)) \
    __BADC_NEON_FN2(op##_high_##n, WQ, WQ, NQ,                            \
                    __BADC_NEON_I3(__BADC_NEON_PICK(k, si "2", ui "2"), WAQ, WAQ, NAQ))
#define __BADC_NEON_F_MOVL(_, n, w, k, ND, NQ, WD, WQ, NA, NAQ, WAD, WAQ, ...) \
    __BADC_NEON_FN1(vmovl_##n, WQ, ND,                                    \
                    __BADC_NEON_I2(__BADC_NEON_PICK(k, "sxtl", "uxtl"), WAQ, NA)) \
    __BADC_NEON_FN1(vmovl_high_##n, WQ, NQ,                               \
                    __BADC_NEON_I2(__BADC_NEON_PICK(k, "sxtl2", "uxtl2"), WAQ, NAQ)) \
    __BADC_NEON_FN1(vpaddl_##n, WD, ND,                                   \
                    __BADC_NEON_I2(__BADC_NEON_PICK(k, "saddlp", "uaddlp"), WAD, NA)) \
    __BADC_NEON_FN1(vpaddlq_##n, WQ, NQ,                                  \
                    __BADC_NEON_I2(__BADC_NEON_PICK(k, "saddlp", "uaddlp"), WAQ, NAQ))
#define __BADC_NEON_F_MOVN(op, si, ui, n, w, k, ND, NQ, WD, WQ, NA, NAQ, WAD, WAQ, UND, UNQ) \
    __BADC_NEON_FN1(op##_##w, ND, WQ, __BADC_NEON_I2(__BADC_NEON_PICK(k, si, ui), NA, WAQ)) \
    static inline NQ op##_high_##w(ND __r, WQ __a) {                      \
        return (NQ)vcombine_u64((uint64x1_t)__r, (uint64x1_t)op##_##w(__a)); \
    }
#define __BADC_NEON_F_QMOVUN(_, n, w, k, ND, NQ, WD, WQ, NA, NAQ, WAD, WAQ, UND, UNQ) \
    __BADC_NEON_FN1(vqmovun_##w, UND, WQ, __BADC_NEON_I2("sqxtun", NA, WAQ)) \
    static inline UNQ vqmovun_high_##w(UND __r, WQ __a) {                 \
        return (UNQ)vcombine_u64((uint64x1_t)__r, (uint64x1_t)vqmovun_##w(__a)); \
    }
__BADC_NEON_WIDE(__BADC_NEON_F_LONG, vaddl, "saddl", "uaddl")
__BADC_NEON_WIDE(__BADC_NEON_F_LONG, vsubl, "ssubl", "usubl")
__BADC_NEON_WIDE(__BADC_NEON_F_LONG, vmull, "smull", "umull")
__BADC_NEON_WIDE(__BADC_NEON_F_LONGACC, vmlal, "smlal", "umlal")
__BADC_NEON_WIDE(__BADC_NEON_F_LONGACC, vmlsl, "smlsl", "umlsl")
__BADC_NEON_WIDE(__BADC_NEON_F_WIDEN, vaddw, "saddw", "uaddw")
__BADC_NEON_WIDE(__BADC_NEON_F_WIDEN, vsubw, "ssubw", "usubw")
__BADC_NEON_WIDE(__BADC_NEON_F_MOVL, _)
__BADC_NEON_WIDE(__BADC_NEON_F_MOVN, vmovn, "xtn", "xtn")
__BADC_NEON_WIDE(__BADC_NEON_F_MOVN, vqmovn, "sqxtn", "uqxtn")
__BADC_NEON_SWIDE(__BADC_NEON_F_QMOVUN, _)

/* Across lanes, into the scalar view `view` of the result. A 2-lane
 * 32-bit vector takes the pairwise form, whose lane 0 is the result. */
#define __BADC_NEON_F_ACROSS(op, si, ui, view, sfx, k, E, D, Q, AD, AQ, ...) \
    __BADC_NEON_FN1(op##_##sfx, E, D,                                     \
                    __BADC_NEON_PICK(k, si, ui) " %" view "0, " __BADC_NEON_V(AD, 1)) \
    __BADC_NEON_FN1(op##q_##sfx, E, Q,                                    \
                    __BADC_NEON_PICK(k, si, ui) " %" view "0, " __BADC_NEON_V(AQ, 1))
#define __BADC_NEON_F_ACROSS2(op, si, ui, sp, up, sfx, k, E, D, Q, ...)   \
    __BADC_NEON_FN1(op##_##sfx, E, D, __BADC_NEON_PICK(k, sp, up) " %0.2s, %1.2s, %1.2s") \
    __BADC_NEON_FN1(op##q_##sfx, E, Q, __BADC_NEON_PICK(k, si, ui) " %s0, %1.4s")
#define __BADC_NEON_F_ADDLV(view, ws, wu, sfx, k, E, D, Q, AD, AQ, ...)   \
    __BADC_NEON_FN1(vaddlv_##sfx, __BADC_NEON_PICK(k, ws, wu), D,         \
                    __BADC_NEON_PICK(k, "saddlv", "uaddlv") " %" view "0, " __BADC_NEON_V(AD, 1)) \
    __BADC_NEON_FN1(vaddlvq_##sfx, __BADC_NEON_PICK(k, ws, wu), Q,        \
                    __BADC_NEON_PICK(k, "saddlv", "uaddlv") " %" view "0, " __BADC_NEON_V(AQ, 1))
#define __BADC_NEON_F_ADDLV2(_, sfx, k, E, D, Q, ...)                     \
    __BADC_NEON_FN1(vaddlv_##sfx, __BADC_NEON_PICK(k, int64_t, uint64_t), D, \
                    __BADC_NEON_PICK(k, "saddlp", "uaddlp") " %0.1d, %1.2s") \
    __BADC_NEON_FN1(vaddlvq_##sfx, __BADC_NEON_PICK(k, int64_t, uint64_t), Q, \
                    __BADC_NEON_PICK(k, "saddlv", "uaddlv") " %d0, %1.4s")
__BADC_NEON_I8(__BADC_NEON_F_ACROSS, vaddv, "addv", "addv", "b")
__BADC_NEON_I16(__BADC_NEON_F_ACROSS, vaddv, "addv", "addv", "h")
__BADC_NEON_I32(__BADC_NEON_F_ACROSS2, vaddv, "addv", "addv", "addp", "addp")
__BADC_NEON_FN1(vaddvq_s64, int64_t, int64x2_t, "addp %d0, %1.2d")
__BADC_NEON_FN1(vaddvq_u64, uint64_t, uint64x2_t, "addp %d0, %1.2d")
__BADC_NEON_I8(__BADC_NEON_F_ACROSS, vmaxv, "smaxv", "umaxv", "b")
__BADC_NEON_I16(__BADC_NEON_F_ACROSS, vmaxv, "smaxv", "umaxv", "h")
__BADC_NEON_I32(__BADC_NEON_F_ACROSS2, vmaxv, "smaxv", "umaxv", "smaxp", "umaxp")
__BADC_NEON_I8(__BADC_NEON_F_ACROSS, vminv, "sminv", "uminv", "b")
__BADC_NEON_I16(__BADC_NEON_F_ACROSS, vminv, "sminv", "uminv", "h")
__BADC_NEON_I32(__BADC_NEON_F_ACROSS2, vminv, "sminv", "uminv", "sminp", "uminp")
__BADC_NEON_I8(__BADC_NEON_F_ADDLV, "h", int16_t, uint16_t)
__BADC_NEON_I16(__BADC_NEON_F_ADDLV, "s", int32_t, uint32_t)
__BADC_NEON_I32(__BADC_NEON_F_ADDLV2, _)

/* Lane reads and writes, lane loads and stores, and the lane broadcasts:
 * `e` is the element letter, `g` the general-register view. */
#define __BADC_NEON_LANE(__n, __lanes)                                    \
    _Static_assert((__n) >= 0 && (__n) < (int)(__lanes), "lane index out of range")
#define __BADC_NEON_NLANES(__v) (sizeof(__v) / sizeof((__v)[0]))
#define __BADC_NEON_GETI(T, g, e, __v, __n) __extension__({               \
    T __lv = (__v);                                                       \
    __typeof__(__lv[0]) __le;                                             \
    __BADC_NEON_LANE(__n, __BADC_NEON_NLANES(__lv));                      \
    __asm__("umov %" g "0, %1." e "[%2]" : "=r"(__le) : "w"(__lv), "i"(__n)); \
    __le;                                                                 \
})
#define __BADC_NEON_GETF(T, e, __v, __n) __extension__({                  \
    T __lv = (__v);                                                       \
    __typeof__(__lv[0]) __le;                                             \
    __BADC_NEON_LANE(__n, __BADC_NEON_NLANES(__lv));                      \
    __asm__("mov %" e "0, %1." e "[%2]" : "=w"(__le) : "w"(__lv), "i"(__n)); \
    __le;                                                                 \
})
#define __BADC_NEON_SETI(T, g, e, __x, __v, __n) __extension__({          \
    T __lv = (__v);                                                       \
    __typeof__(__lv[0]) __lx = (__x);                                     \
    __BADC_NEON_LANE(__n, __BADC_NEON_NLANES(__lv));                      \
    __asm__("ins %0." e "[%2], %" g "1" : "+w"(__lv) : "r"(__lx), "i"(__n)); \
    __lv;                                                                 \
})
#define __BADC_NEON_SETF(T, e, __x, __v, __n) __extension__({             \
    T __lv = (__v);                                                       \
    __typeof__(__lv[0]) __lx = (__x);                                     \
    __BADC_NEON_LANE(__n, __BADC_NEON_NLANES(__lv));                      \
    __asm__("mov %0." e "[%2], %1." e "[0]" : "+w"(__lv) : "w"(__lx), "i"(__n)); \
    __lv;                                                                 \
})
#define __BADC_NEON_LD1L(T, e, __p, __v, __n) __extension__({             \
    T __lv = (__v);                                                       \
    const __typeof__(__lv[0]) *__lp = (__p);                              \
    __BADC_NEON_LANE(__n, __BADC_NEON_NLANES(__lv));                      \
    __asm__("ld1 {%0." e "}[%2], [%1]" : "+w"(__lv) : "r"(__lp), "i"(__n) : "memory"); \
    __lv;                                                                 \
})
#define __BADC_NEON_ST1L(T, e, __p, __v, __n) __extension__({             \
    T __lv = (__v);                                                       \
    __typeof__(__lv[0]) *__lp = (__p);                                    \
    __BADC_NEON_LANE(__n, __BADC_NEON_NLANES(__lv));                      \
    __asm__("st1 {%1." e "}[%2], [%0]" : : "r"(__lp), "w"(__lv), "i"(__n) : "memory"); \
})
#define __BADC_NEON_DUPL(R, T, A, e, __v, __n) __extension__({            \
    T __lv = (__v);                                                       \
    R __lr;                                                               \
    __BADC_NEON_LANE(__n, __BADC_NEON_NLANES(__lv));                      \
    __asm__("dup %0." A ", %1." e "[%2]" : "=w"(__lr) : "w"(__lv), "i"(__n)); \
    __lr;                                                                 \
})
#define __BADC_NEON_DUPL1(R, T, __v, __n) __extension__({                 \
    T __lv = (__v);                                                       \
    R __lr;                                                               \
    __BADC_NEON_LANE(__n, __BADC_NEON_NLANES(__lv));                      \
    __asm__("mov %d0, %1.d[%2]" : "=w"(__lr) : "w"(__lv), "i"(__n));      \
    __lr;                                                                 \
})
/* The window of the concatenation __b:__a starting at lane __n. */
#define __BADC_NEON_EXT(T, A, __a, __b, __n) __extension__({              \
    T __ea = (__a), __eb = (__b), __er;                                   \
    __BADC_NEON_LANE(__n, __BADC_NEON_NLANES(__ea));                      \
    __asm__(__BADC_NEON_I3("ext", A, A, A) ", #%3"                        \
            : "=w"(__er) : "w"(__ea), "w"(__eb), "i"((__n) * sizeof __ea[0])); \
    __er;                                                                 \
})

#define vget_lane_s8(__v, __n) __BADC_NEON_GETI(int8x8_t, "w", "b", __v, __n)
#define vgetq_lane_s8(__v, __n) __BADC_NEON_GETI(int8x16_t, "w", "b", __v, __n)
#define vset_lane_s8(__x, __v, __n) __BADC_NEON_SETI(int8x8_t, "w", "b", __x, __v, __n)
#define vsetq_lane_s8(__x, __v, __n) __BADC_NEON_SETI(int8x16_t, "w", "b", __x, __v, __n)
#define vld1_lane_s8(__p, __v, __n) __BADC_NEON_LD1L(int8x8_t, "b", __p, __v, __n)
#define vld1q_lane_s8(__p, __v, __n) __BADC_NEON_LD1L(int8x16_t, "b", __p, __v, __n)
#define vst1_lane_s8(__p, __v, __n) __BADC_NEON_ST1L(int8x8_t, "b", __p, __v, __n)
#define vst1q_lane_s8(__p, __v, __n) __BADC_NEON_ST1L(int8x16_t, "b", __p, __v, __n)
#define vdup_lane_s8(__v, __n) __BADC_NEON_DUPL(int8x8_t, int8x8_t, "8b", "b", __v, __n)
#define vdupq_lane_s8(__v, __n) __BADC_NEON_DUPL(int8x16_t, int8x8_t, "16b", "b", __v, __n)
#define vdup_laneq_s8(__v, __n) __BADC_NEON_DUPL(int8x8_t, int8x16_t, "8b", "b", __v, __n)
#define vdupq_laneq_s8(__v, __n) __BADC_NEON_DUPL(int8x16_t, int8x16_t, "16b", "b", __v, __n)
#define vext_s8(__a, __b, __n) __BADC_NEON_EXT(int8x8_t, 8b, __a, __b, __n)
#define vextq_s8(__a, __b, __n) __BADC_NEON_EXT(int8x16_t, 16b, __a, __b, __n)

#define vget_lane_u8(__v, __n) __BADC_NEON_GETI(uint8x8_t, "w", "b", __v, __n)
#define vgetq_lane_u8(__v, __n) __BADC_NEON_GETI(uint8x16_t, "w", "b", __v, __n)
#define vset_lane_u8(__x, __v, __n) __BADC_NEON_SETI(uint8x8_t, "w", "b", __x, __v, __n)
#define vsetq_lane_u8(__x, __v, __n) __BADC_NEON_SETI(uint8x16_t, "w", "b", __x, __v, __n)
#define vld1_lane_u8(__p, __v, __n) __BADC_NEON_LD1L(uint8x8_t, "b", __p, __v, __n)
#define vld1q_lane_u8(__p, __v, __n) __BADC_NEON_LD1L(uint8x16_t, "b", __p, __v, __n)
#define vst1_lane_u8(__p, __v, __n) __BADC_NEON_ST1L(uint8x8_t, "b", __p, __v, __n)
#define vst1q_lane_u8(__p, __v, __n) __BADC_NEON_ST1L(uint8x16_t, "b", __p, __v, __n)
#define vdup_lane_u8(__v, __n) __BADC_NEON_DUPL(uint8x8_t, uint8x8_t, "8b", "b", __v, __n)
#define vdupq_lane_u8(__v, __n) __BADC_NEON_DUPL(uint8x16_t, uint8x8_t, "16b", "b", __v, __n)
#define vdup_laneq_u8(__v, __n) __BADC_NEON_DUPL(uint8x8_t, uint8x16_t, "8b", "b", __v, __n)
#define vdupq_laneq_u8(__v, __n) __BADC_NEON_DUPL(uint8x16_t, uint8x16_t, "16b", "b", __v, __n)
#define vext_u8(__a, __b, __n) __BADC_NEON_EXT(uint8x8_t, 8b, __a, __b, __n)
#define vextq_u8(__a, __b, __n) __BADC_NEON_EXT(uint8x16_t, 16b, __a, __b, __n)

#define vget_lane_p8(__v, __n) __BADC_NEON_GETI(poly8x8_t, "w", "b", __v, __n)
#define vgetq_lane_p8(__v, __n) __BADC_NEON_GETI(poly8x16_t, "w", "b", __v, __n)
#define vset_lane_p8(__x, __v, __n) __BADC_NEON_SETI(poly8x8_t, "w", "b", __x, __v, __n)
#define vsetq_lane_p8(__x, __v, __n) __BADC_NEON_SETI(poly8x16_t, "w", "b", __x, __v, __n)
#define vld1_lane_p8(__p, __v, __n) __BADC_NEON_LD1L(poly8x8_t, "b", __p, __v, __n)
#define vld1q_lane_p8(__p, __v, __n) __BADC_NEON_LD1L(poly8x16_t, "b", __p, __v, __n)
#define vst1_lane_p8(__p, __v, __n) __BADC_NEON_ST1L(poly8x8_t, "b", __p, __v, __n)
#define vst1q_lane_p8(__p, __v, __n) __BADC_NEON_ST1L(poly8x16_t, "b", __p, __v, __n)
#define vdup_lane_p8(__v, __n) __BADC_NEON_DUPL(poly8x8_t, poly8x8_t, "8b", "b", __v, __n)
#define vdupq_lane_p8(__v, __n) __BADC_NEON_DUPL(poly8x16_t, poly8x8_t, "16b", "b", __v, __n)
#define vdup_laneq_p8(__v, __n) __BADC_NEON_DUPL(poly8x8_t, poly8x16_t, "8b", "b", __v, __n)
#define vdupq_laneq_p8(__v, __n) __BADC_NEON_DUPL(poly8x16_t, poly8x16_t, "16b", "b", __v, __n)
#define vext_p8(__a, __b, __n) __BADC_NEON_EXT(poly8x8_t, 8b, __a, __b, __n)
#define vextq_p8(__a, __b, __n) __BADC_NEON_EXT(poly8x16_t, 16b, __a, __b, __n)

#define vget_lane_s16(__v, __n) __BADC_NEON_GETI(int16x4_t, "w", "h", __v, __n)
#define vgetq_lane_s16(__v, __n) __BADC_NEON_GETI(int16x8_t, "w", "h", __v, __n)
#define vset_lane_s16(__x, __v, __n) __BADC_NEON_SETI(int16x4_t, "w", "h", __x, __v, __n)
#define vsetq_lane_s16(__x, __v, __n) __BADC_NEON_SETI(int16x8_t, "w", "h", __x, __v, __n)
#define vld1_lane_s16(__p, __v, __n) __BADC_NEON_LD1L(int16x4_t, "h", __p, __v, __n)
#define vld1q_lane_s16(__p, __v, __n) __BADC_NEON_LD1L(int16x8_t, "h", __p, __v, __n)
#define vst1_lane_s16(__p, __v, __n) __BADC_NEON_ST1L(int16x4_t, "h", __p, __v, __n)
#define vst1q_lane_s16(__p, __v, __n) __BADC_NEON_ST1L(int16x8_t, "h", __p, __v, __n)
#define vdup_lane_s16(__v, __n) __BADC_NEON_DUPL(int16x4_t, int16x4_t, "4h", "h", __v, __n)
#define vdupq_lane_s16(__v, __n) __BADC_NEON_DUPL(int16x8_t, int16x4_t, "8h", "h", __v, __n)
#define vdup_laneq_s16(__v, __n) __BADC_NEON_DUPL(int16x4_t, int16x8_t, "4h", "h", __v, __n)
#define vdupq_laneq_s16(__v, __n) __BADC_NEON_DUPL(int16x8_t, int16x8_t, "8h", "h", __v, __n)
#define vext_s16(__a, __b, __n) __BADC_NEON_EXT(int16x4_t, 8b, __a, __b, __n)
#define vextq_s16(__a, __b, __n) __BADC_NEON_EXT(int16x8_t, 16b, __a, __b, __n)

#define vget_lane_u16(__v, __n) __BADC_NEON_GETI(uint16x4_t, "w", "h", __v, __n)
#define vgetq_lane_u16(__v, __n) __BADC_NEON_GETI(uint16x8_t, "w", "h", __v, __n)
#define vset_lane_u16(__x, __v, __n) __BADC_NEON_SETI(uint16x4_t, "w", "h", __x, __v, __n)
#define vsetq_lane_u16(__x, __v, __n) __BADC_NEON_SETI(uint16x8_t, "w", "h", __x, __v, __n)
#define vld1_lane_u16(__p, __v, __n) __BADC_NEON_LD1L(uint16x4_t, "h", __p, __v, __n)
#define vld1q_lane_u16(__p, __v, __n) __BADC_NEON_LD1L(uint16x8_t, "h", __p, __v, __n)
#define vst1_lane_u16(__p, __v, __n) __BADC_NEON_ST1L(uint16x4_t, "h", __p, __v, __n)
#define vst1q_lane_u16(__p, __v, __n) __BADC_NEON_ST1L(uint16x8_t, "h", __p, __v, __n)
#define vdup_lane_u16(__v, __n) __BADC_NEON_DUPL(uint16x4_t, uint16x4_t, "4h", "h", __v, __n)
#define vdupq_lane_u16(__v, __n) __BADC_NEON_DUPL(uint16x8_t, uint16x4_t, "8h", "h", __v, __n)
#define vdup_laneq_u16(__v, __n) __BADC_NEON_DUPL(uint16x4_t, uint16x8_t, "4h", "h", __v, __n)
#define vdupq_laneq_u16(__v, __n) __BADC_NEON_DUPL(uint16x8_t, uint16x8_t, "8h", "h", __v, __n)
#define vext_u16(__a, __b, __n) __BADC_NEON_EXT(uint16x4_t, 8b, __a, __b, __n)
#define vextq_u16(__a, __b, __n) __BADC_NEON_EXT(uint16x8_t, 16b, __a, __b, __n)

#define vget_lane_p16(__v, __n) __BADC_NEON_GETI(poly16x4_t, "w", "h", __v, __n)
#define vgetq_lane_p16(__v, __n) __BADC_NEON_GETI(poly16x8_t, "w", "h", __v, __n)
#define vset_lane_p16(__x, __v, __n) __BADC_NEON_SETI(poly16x4_t, "w", "h", __x, __v, __n)
#define vsetq_lane_p16(__x, __v, __n) __BADC_NEON_SETI(poly16x8_t, "w", "h", __x, __v, __n)
#define vld1_lane_p16(__p, __v, __n) __BADC_NEON_LD1L(poly16x4_t, "h", __p, __v, __n)
#define vld1q_lane_p16(__p, __v, __n) __BADC_NEON_LD1L(poly16x8_t, "h", __p, __v, __n)
#define vst1_lane_p16(__p, __v, __n) __BADC_NEON_ST1L(poly16x4_t, "h", __p, __v, __n)
#define vst1q_lane_p16(__p, __v, __n) __BADC_NEON_ST1L(poly16x8_t, "h", __p, __v, __n)
#define vdup_lane_p16(__v, __n) __BADC_NEON_DUPL(poly16x4_t, poly16x4_t, "4h", "h", __v, __n)
#define vdupq_lane_p16(__v, __n) __BADC_NEON_DUPL(poly16x8_t, poly16x4_t, "8h", "h", __v, __n)
#define vdup_laneq_p16(__v, __n) __BADC_NEON_DUPL(poly16x4_t, poly16x8_t, "4h", "h", __v, __n)
#define vdupq_laneq_p16(__v, __n) __BADC_NEON_DUPL(poly16x8_t, poly16x8_t, "8h", "h", __v, __n)
#define vext_p16(__a, __b, __n) __BADC_NEON_EXT(poly16x4_t, 8b, __a, __b, __n)
#define vextq_p16(__a, __b, __n) __BADC_NEON_EXT(poly16x8_t, 16b, __a, __b, __n)

#define vget_lane_s32(__v, __n) __BADC_NEON_GETI(int32x2_t, "w", "s", __v, __n)
#define vgetq_lane_s32(__v, __n) __BADC_NEON_GETI(int32x4_t, "w", "s", __v, __n)
#define vset_lane_s32(__x, __v, __n) __BADC_NEON_SETI(int32x2_t, "w", "s", __x, __v, __n)
#define vsetq_lane_s32(__x, __v, __n) __BADC_NEON_SETI(int32x4_t, "w", "s", __x, __v, __n)
#define vld1_lane_s32(__p, __v, __n) __BADC_NEON_LD1L(int32x2_t, "s", __p, __v, __n)
#define vld1q_lane_s32(__p, __v, __n) __BADC_NEON_LD1L(int32x4_t, "s", __p, __v, __n)
#define vst1_lane_s32(__p, __v, __n) __BADC_NEON_ST1L(int32x2_t, "s", __p, __v, __n)
#define vst1q_lane_s32(__p, __v, __n) __BADC_NEON_ST1L(int32x4_t, "s", __p, __v, __n)
#define vdup_lane_s32(__v, __n) __BADC_NEON_DUPL(int32x2_t, int32x2_t, "2s", "s", __v, __n)
#define vdupq_lane_s32(__v, __n) __BADC_NEON_DUPL(int32x4_t, int32x2_t, "4s", "s", __v, __n)
#define vdup_laneq_s32(__v, __n) __BADC_NEON_DUPL(int32x2_t, int32x4_t, "2s", "s", __v, __n)
#define vdupq_laneq_s32(__v, __n) __BADC_NEON_DUPL(int32x4_t, int32x4_t, "4s", "s", __v, __n)
#define vext_s32(__a, __b, __n) __BADC_NEON_EXT(int32x2_t, 8b, __a, __b, __n)
#define vextq_s32(__a, __b, __n) __BADC_NEON_EXT(int32x4_t, 16b, __a, __b, __n)

#define vget_lane_u32(__v, __n) __BADC_NEON_GETI(uint32x2_t, "w", "s", __v, __n)
#define vgetq_lane_u32(__v, __n) __BADC_NEON_GETI(uint32x4_t, "w", "s", __v, __n)
#define vset_lane_u32(__x, __v, __n) __BADC_NEON_SETI(uint32x2_t, "w", "s", __x, __v, __n)
#define vsetq_lane_u32(__x, __v, __n) __BADC_NEON_SETI(uint32x4_t, "w", "s", __x, __v, __n)
#define vld1_lane_u32(__p, __v, __n) __BADC_NEON_LD1L(uint32x2_t, "s", __p, __v, __n)
#define vld1q_lane_u32(__p, __v, __n) __BADC_NEON_LD1L(uint32x4_t, "s", __p, __v, __n)
#define vst1_lane_u32(__p, __v, __n) __BADC_NEON_ST1L(uint32x2_t, "s", __p, __v, __n)
#define vst1q_lane_u32(__p, __v, __n) __BADC_NEON_ST1L(uint32x4_t, "s", __p, __v, __n)
#define vdup_lane_u32(__v, __n) __BADC_NEON_DUPL(uint32x2_t, uint32x2_t, "2s", "s", __v, __n)
#define vdupq_lane_u32(__v, __n) __BADC_NEON_DUPL(uint32x4_t, uint32x2_t, "4s", "s", __v, __n)
#define vdup_laneq_u32(__v, __n) __BADC_NEON_DUPL(uint32x2_t, uint32x4_t, "2s", "s", __v, __n)
#define vdupq_laneq_u32(__v, __n) __BADC_NEON_DUPL(uint32x4_t, uint32x4_t, "4s", "s", __v, __n)
#define vext_u32(__a, __b, __n) __BADC_NEON_EXT(uint32x2_t, 8b, __a, __b, __n)
#define vextq_u32(__a, __b, __n) __BADC_NEON_EXT(uint32x4_t, 16b, __a, __b, __n)

#define vget_lane_f32(__v, __n) __BADC_NEON_GETF(float32x2_t, "s", __v, __n)
#define vgetq_lane_f32(__v, __n) __BADC_NEON_GETF(float32x4_t, "s", __v, __n)
#define vset_lane_f32(__x, __v, __n) __BADC_NEON_SETF(float32x2_t, "s", __x, __v, __n)
#define vsetq_lane_f32(__x, __v, __n) __BADC_NEON_SETF(float32x4_t, "s", __x, __v, __n)
#define vld1_lane_f32(__p, __v, __n) __BADC_NEON_LD1L(float32x2_t, "s", __p, __v, __n)
#define vld1q_lane_f32(__p, __v, __n) __BADC_NEON_LD1L(float32x4_t, "s", __p, __v, __n)
#define vst1_lane_f32(__p, __v, __n) __BADC_NEON_ST1L(float32x2_t, "s", __p, __v, __n)
#define vst1q_lane_f32(__p, __v, __n) __BADC_NEON_ST1L(float32x4_t, "s", __p, __v, __n)
#define vdup_lane_f32(__v, __n) __BADC_NEON_DUPL(float32x2_t, float32x2_t, "2s", "s", __v, __n)
#define vdupq_lane_f32(__v, __n) __BADC_NEON_DUPL(float32x4_t, float32x2_t, "4s", "s", __v, __n)
#define vdup_laneq_f32(__v, __n) __BADC_NEON_DUPL(float32x2_t, float32x4_t, "2s", "s", __v, __n)
#define vdupq_laneq_f32(__v, __n) __BADC_NEON_DUPL(float32x4_t, float32x4_t, "4s", "s", __v, __n)
#define vext_f32(__a, __b, __n) __BADC_NEON_EXT(float32x2_t, 8b, __a, __b, __n)
#define vextq_f32(__a, __b, __n) __BADC_NEON_EXT(float32x4_t, 16b, __a, __b, __n)

#define vget_lane_s64(__v, __n) __BADC_NEON_GETI(int64x1_t, "x", "d", __v, __n)
#define vgetq_lane_s64(__v, __n) __BADC_NEON_GETI(int64x2_t, "x", "d", __v, __n)
#define vset_lane_s64(__x, __v, __n) __BADC_NEON_SETI(int64x1_t, "x", "d", __x, __v, __n)
#define vsetq_lane_s64(__x, __v, __n) __BADC_NEON_SETI(int64x2_t, "x", "d", __x, __v, __n)
#define vld1_lane_s64(__p, __v, __n) __BADC_NEON_LD1L(int64x1_t, "d", __p, __v, __n)
#define vld1q_lane_s64(__p, __v, __n) __BADC_NEON_LD1L(int64x2_t, "d", __p, __v, __n)
#define vst1_lane_s64(__p, __v, __n) __BADC_NEON_ST1L(int64x1_t, "d", __p, __v, __n)
#define vst1q_lane_s64(__p, __v, __n) __BADC_NEON_ST1L(int64x2_t, "d", __p, __v, __n)
#define vdup_lane_s64(__v, __n) __BADC_NEON_DUPL1(int64x1_t, int64x1_t, __v, __n)
#define vdupq_lane_s64(__v, __n) __BADC_NEON_DUPL(int64x2_t, int64x1_t, "2d", "d", __v, __n)
#define vdup_laneq_s64(__v, __n) __BADC_NEON_DUPL1(int64x1_t, int64x2_t, __v, __n)
#define vdupq_laneq_s64(__v, __n) __BADC_NEON_DUPL(int64x2_t, int64x2_t, "2d", "d", __v, __n)
#define vext_s64(__a, __b, __n) __BADC_NEON_EXT(int64x1_t, 8b, __a, __b, __n)
#define vextq_s64(__a, __b, __n) __BADC_NEON_EXT(int64x2_t, 16b, __a, __b, __n)

#define vget_lane_u64(__v, __n) __BADC_NEON_GETI(uint64x1_t, "x", "d", __v, __n)
#define vgetq_lane_u64(__v, __n) __BADC_NEON_GETI(uint64x2_t, "x", "d", __v, __n)
#define vset_lane_u64(__x, __v, __n) __BADC_NEON_SETI(uint64x1_t, "x", "d", __x, __v, __n)
#define vsetq_lane_u64(__x, __v, __n) __BADC_NEON_SETI(uint64x2_t, "x", "d", __x, __v, __n)
#define vld1_lane_u64(__p, __v, __n) __BADC_NEON_LD1L(uint64x1_t, "d", __p, __v, __n)
#define vld1q_lane_u64(__p, __v, __n) __BADC_NEON_LD1L(uint64x2_t, "d", __p, __v, __n)
#define vst1_lane_u64(__p, __v, __n) __BADC_NEON_ST1L(uint64x1_t, "d", __p, __v, __n)
#define vst1q_lane_u64(__p, __v, __n) __BADC_NEON_ST1L(uint64x2_t, "d", __p, __v, __n)
#define vdup_lane_u64(__v, __n) __BADC_NEON_DUPL1(uint64x1_t, uint64x1_t, __v, __n)
#define vdupq_lane_u64(__v, __n) __BADC_NEON_DUPL(uint64x2_t, uint64x1_t, "2d", "d", __v, __n)
#define vdup_laneq_u64(__v, __n) __BADC_NEON_DUPL1(uint64x1_t, uint64x2_t, __v, __n)
#define vdupq_laneq_u64(__v, __n) __BADC_NEON_DUPL(uint64x2_t, uint64x2_t, "2d", "d", __v, __n)
#define vext_u64(__a, __b, __n) __BADC_NEON_EXT(uint64x1_t, 8b, __a, __b, __n)
#define vextq_u64(__a, __b, __n) __BADC_NEON_EXT(uint64x2_t, 16b, __a, __b, __n)

#define vget_lane_p64(__v, __n) __BADC_NEON_GETI(poly64x1_t, "x", "d", __v, __n)
#define vgetq_lane_p64(__v, __n) __BADC_NEON_GETI(poly64x2_t, "x", "d", __v, __n)
#define vset_lane_p64(__x, __v, __n) __BADC_NEON_SETI(poly64x1_t, "x", "d", __x, __v, __n)
#define vsetq_lane_p64(__x, __v, __n) __BADC_NEON_SETI(poly64x2_t, "x", "d", __x, __v, __n)
#define vld1_lane_p64(__p, __v, __n) __BADC_NEON_LD1L(poly64x1_t, "d", __p, __v, __n)
#define vld1q_lane_p64(__p, __v, __n) __BADC_NEON_LD1L(poly64x2_t, "d", __p, __v, __n)
#define vst1_lane_p64(__p, __v, __n) __BADC_NEON_ST1L(poly64x1_t, "d", __p, __v, __n)
#define vst1q_lane_p64(__p, __v, __n) __BADC_NEON_ST1L(poly64x2_t, "d", __p, __v, __n)
#define vdup_lane_p64(__v, __n) __BADC_NEON_DUPL1(poly64x1_t, poly64x1_t, __v, __n)
#define vdupq_lane_p64(__v, __n) __BADC_NEON_DUPL(poly64x2_t, poly64x1_t, "2d", "d", __v, __n)
#define vdup_laneq_p64(__v, __n) __BADC_NEON_DUPL1(poly64x1_t, poly64x2_t, __v, __n)
#define vdupq_laneq_p64(__v, __n) __BADC_NEON_DUPL(poly64x2_t, poly64x2_t, "2d", "d", __v, __n)
#define vext_p64(__a, __b, __n) __BADC_NEON_EXT(poly64x1_t, 8b, __a, __b, __n)
#define vextq_p64(__a, __b, __n) __BADC_NEON_EXT(poly64x2_t, 16b, __a, __b, __n)

#define vget_lane_f64(__v, __n) __BADC_NEON_GETF(float64x1_t, "d", __v, __n)
#define vgetq_lane_f64(__v, __n) __BADC_NEON_GETF(float64x2_t, "d", __v, __n)
#define vset_lane_f64(__x, __v, __n) __BADC_NEON_SETF(float64x1_t, "d", __x, __v, __n)
#define vsetq_lane_f64(__x, __v, __n) __BADC_NEON_SETF(float64x2_t, "d", __x, __v, __n)
#define vld1_lane_f64(__p, __v, __n) __BADC_NEON_LD1L(float64x1_t, "d", __p, __v, __n)
#define vld1q_lane_f64(__p, __v, __n) __BADC_NEON_LD1L(float64x2_t, "d", __p, __v, __n)
#define vst1_lane_f64(__p, __v, __n) __BADC_NEON_ST1L(float64x1_t, "d", __p, __v, __n)
#define vst1q_lane_f64(__p, __v, __n) __BADC_NEON_ST1L(float64x2_t, "d", __p, __v, __n)
#define vdup_lane_f64(__v, __n) __BADC_NEON_DUPL1(float64x1_t, float64x1_t, __v, __n)
#define vdupq_lane_f64(__v, __n) __BADC_NEON_DUPL(float64x2_t, float64x1_t, "2d", "d", __v, __n)
#define vdup_laneq_f64(__v, __n) __BADC_NEON_DUPL1(float64x1_t, float64x2_t, __v, __n)
#define vdupq_laneq_f64(__v, __n) __BADC_NEON_DUPL(float64x2_t, float64x2_t, "2d", "d", __v, __n)
#define vext_f64(__a, __b, __n) __BADC_NEON_EXT(float64x1_t, 8b, __a, __b, __n)
#define vextq_f64(__a, __b, __n) __BADC_NEON_EXT(float64x2_t, 16b, __a, __b, __n)

/* Shifts by an immediate in [r, bits - 1 + r]: r is 0 for the left shifts,
 * 1 for the right ones. SHA accumulates into or inserts into __a; SHN
 * narrows. */
#define __BADC_NEON_SHIFT_RANGE(__n, r, __e)                              \
    _Static_assert((__n) >= (r) && (__n) < 8 * (int)sizeof(__e) + (r), "shift count out of range")
#define __BADC_NEON_SH(T, insn, A, r, __a, __n) __extension__({           \
    T __sa = (__a), __sr;                                                 \
    __BADC_NEON_SHIFT_RANGE(__n, r, __sa[0]);                             \
    __asm__(__BADC_NEON_I2(insn, A, A) ", #%2" : "=w"(__sr) : "w"(__sa), "i"(__n)); \
    __sr;                                                                 \
})
#define __BADC_NEON_SHB(T, stem, A, r, __a, __n) __extension__({          \
    T __sa = (__a);                                                       \
    __BADC_NEON_SHIFT_RANGE(__n, r, __sa[0]);                             \
    (T)__BADC_NEON_B(stem, A)(__sa, __n);                                 \
})
#define __BADC_NEON_SHA(T, insn, A, r, __a, __b, __n) __extension__({     \
    T __sa = (__a), __sb = (__b);                                         \
    __BADC_NEON_SHIFT_RANGE(__n, r, __sa[0]);                             \
    __asm__(__BADC_NEON_I2(insn, A, A) ", #%2" : "+w"(__sa) : "w"(__sb), "i"(__n)); \
    __sa;                                                                 \
})
#define __BADC_NEON_SHN(R, T, insn, RA, TA, __a, __n) __extension__({     \
    T __sa = (__a);                                                       \
    R __sr;                                                               \
    __BADC_NEON_SHIFT_RANGE(__n, 1, __sr[0]);                             \
    __asm__(__BADC_NEON_I2(insn, RA, TA) ", #%2" : "=w"(__sr) : "w"(__sa), "i"(__n)); \
    __sr;                                                                 \
})

#define vshl_n_s8(__a, __n) __BADC_NEON_SHB(int8x8_t, __builtin_neon_shl, 8b, 0, __a, __n)
#define vshlq_n_s8(__a, __n) __BADC_NEON_SHB(int8x16_t, __builtin_neon_shl, 16b, 0, __a, __n)
#define vqshl_n_s8(__a, __n) __BADC_NEON_SH(int8x8_t, "sqshl", 8b, 0, __a, __n)
#define vqshlq_n_s8(__a, __n) __BADC_NEON_SH(int8x16_t, "sqshl", 16b, 0, __a, __n)
#define vshr_n_s8(__a, __n) __BADC_NEON_SHB(int8x8_t, __builtin_neon_sshr, 8b, 1, __a, __n)
#define vshrq_n_s8(__a, __n) __BADC_NEON_SHB(int8x16_t, __builtin_neon_sshr, 16b, 1, __a, __n)
#define vrshr_n_s8(__a, __n) __BADC_NEON_SH(int8x8_t, "srshr", 8b, 1, __a, __n)
#define vrshrq_n_s8(__a, __n) __BADC_NEON_SH(int8x16_t, "srshr", 16b, 1, __a, __n)
#define vsra_n_s8(__a, __b, __n) __BADC_NEON_SHA(int8x8_t, "ssra", 8b, 1, __a, __b, __n)
#define vsraq_n_s8(__a, __b, __n) __BADC_NEON_SHA(int8x16_t, "ssra", 16b, 1, __a, __b, __n)
#define vrsra_n_s8(__a, __b, __n) __BADC_NEON_SHA(int8x8_t, "srsra", 8b, 1, __a, __b, __n)
#define vrsraq_n_s8(__a, __b, __n) __BADC_NEON_SHA(int8x16_t, "srsra", 16b, 1, __a, __b, __n)

#define vshl_n_u8(__a, __n) __BADC_NEON_SHB(uint8x8_t, __builtin_neon_shl, 8b, 0, __a, __n)
#define vshlq_n_u8(__a, __n) __BADC_NEON_SHB(uint8x16_t, __builtin_neon_shl, 16b, 0, __a, __n)
#define vqshl_n_u8(__a, __n) __BADC_NEON_SH(uint8x8_t, "uqshl", 8b, 0, __a, __n)
#define vqshlq_n_u8(__a, __n) __BADC_NEON_SH(uint8x16_t, "uqshl", 16b, 0, __a, __n)
#define vshr_n_u8(__a, __n) __BADC_NEON_SHB(uint8x8_t, __builtin_neon_ushr, 8b, 1, __a, __n)
#define vshrq_n_u8(__a, __n) __BADC_NEON_SHB(uint8x16_t, __builtin_neon_ushr, 16b, 1, __a, __n)
#define vrshr_n_u8(__a, __n) __BADC_NEON_SH(uint8x8_t, "urshr", 8b, 1, __a, __n)
#define vrshrq_n_u8(__a, __n) __BADC_NEON_SH(uint8x16_t, "urshr", 16b, 1, __a, __n)
#define vsra_n_u8(__a, __b, __n) __BADC_NEON_SHA(uint8x8_t, "usra", 8b, 1, __a, __b, __n)
#define vsraq_n_u8(__a, __b, __n) __BADC_NEON_SHA(uint8x16_t, "usra", 16b, 1, __a, __b, __n)
#define vrsra_n_u8(__a, __b, __n) __BADC_NEON_SHA(uint8x8_t, "ursra", 8b, 1, __a, __b, __n)
#define vrsraq_n_u8(__a, __b, __n) __BADC_NEON_SHA(uint8x16_t, "ursra", 16b, 1, __a, __b, __n)

#define vshl_n_s16(__a, __n) __BADC_NEON_SHB(int16x4_t, __builtin_neon_shl, 4h, 0, __a, __n)
#define vshlq_n_s16(__a, __n) __BADC_NEON_SHB(int16x8_t, __builtin_neon_shl, 8h, 0, __a, __n)
#define vqshl_n_s16(__a, __n) __BADC_NEON_SH(int16x4_t, "sqshl", 4h, 0, __a, __n)
#define vqshlq_n_s16(__a, __n) __BADC_NEON_SH(int16x8_t, "sqshl", 8h, 0, __a, __n)
#define vshr_n_s16(__a, __n) __BADC_NEON_SHB(int16x4_t, __builtin_neon_sshr, 4h, 1, __a, __n)
#define vshrq_n_s16(__a, __n) __BADC_NEON_SHB(int16x8_t, __builtin_neon_sshr, 8h, 1, __a, __n)
#define vrshr_n_s16(__a, __n) __BADC_NEON_SH(int16x4_t, "srshr", 4h, 1, __a, __n)
#define vrshrq_n_s16(__a, __n) __BADC_NEON_SH(int16x8_t, "srshr", 8h, 1, __a, __n)
#define vsra_n_s16(__a, __b, __n) __BADC_NEON_SHA(int16x4_t, "ssra", 4h, 1, __a, __b, __n)
#define vsraq_n_s16(__a, __b, __n) __BADC_NEON_SHA(int16x8_t, "ssra", 8h, 1, __a, __b, __n)
#define vrsra_n_s16(__a, __b, __n) __BADC_NEON_SHA(int16x4_t, "srsra", 4h, 1, __a, __b, __n)
#define vrsraq_n_s16(__a, __b, __n) __BADC_NEON_SHA(int16x8_t, "srsra", 8h, 1, __a, __b, __n)

#define vshl_n_u16(__a, __n) __BADC_NEON_SHB(uint16x4_t, __builtin_neon_shl, 4h, 0, __a, __n)
#define vshlq_n_u16(__a, __n) __BADC_NEON_SHB(uint16x8_t, __builtin_neon_shl, 8h, 0, __a, __n)
#define vqshl_n_u16(__a, __n) __BADC_NEON_SH(uint16x4_t, "uqshl", 4h, 0, __a, __n)
#define vqshlq_n_u16(__a, __n) __BADC_NEON_SH(uint16x8_t, "uqshl", 8h, 0, __a, __n)
#define vshr_n_u16(__a, __n) __BADC_NEON_SHB(uint16x4_t, __builtin_neon_ushr, 4h, 1, __a, __n)
#define vshrq_n_u16(__a, __n) __BADC_NEON_SHB(uint16x8_t, __builtin_neon_ushr, 8h, 1, __a, __n)
#define vrshr_n_u16(__a, __n) __BADC_NEON_SH(uint16x4_t, "urshr", 4h, 1, __a, __n)
#define vrshrq_n_u16(__a, __n) __BADC_NEON_SH(uint16x8_t, "urshr", 8h, 1, __a, __n)
#define vsra_n_u16(__a, __b, __n) __BADC_NEON_SHA(uint16x4_t, "usra", 4h, 1, __a, __b, __n)
#define vsraq_n_u16(__a, __b, __n) __BADC_NEON_SHA(uint16x8_t, "usra", 8h, 1, __a, __b, __n)
#define vrsra_n_u16(__a, __b, __n) __BADC_NEON_SHA(uint16x4_t, "ursra", 4h, 1, __a, __b, __n)
#define vrsraq_n_u16(__a, __b, __n) __BADC_NEON_SHA(uint16x8_t, "ursra", 8h, 1, __a, __b, __n)

#define vshl_n_s32(__a, __n) __BADC_NEON_SHB(int32x2_t, __builtin_neon_shl, 2s, 0, __a, __n)
#define vshlq_n_s32(__a, __n) __BADC_NEON_SHB(int32x4_t, __builtin_neon_shl, 4s, 0, __a, __n)
#define vqshl_n_s32(__a, __n) __BADC_NEON_SH(int32x2_t, "sqshl", 2s, 0, __a, __n)
#define vqshlq_n_s32(__a, __n) __BADC_NEON_SH(int32x4_t, "sqshl", 4s, 0, __a, __n)
#define vshr_n_s32(__a, __n) __BADC_NEON_SHB(int32x2_t, __builtin_neon_sshr, 2s, 1, __a, __n)
#define vshrq_n_s32(__a, __n) __BADC_NEON_SHB(int32x4_t, __builtin_neon_sshr, 4s, 1, __a, __n)
#define vrshr_n_s32(__a, __n) __BADC_NEON_SH(int32x2_t, "srshr", 2s, 1, __a, __n)
#define vrshrq_n_s32(__a, __n) __BADC_NEON_SH(int32x4_t, "srshr", 4s, 1, __a, __n)
#define vsra_n_s32(__a, __b, __n) __BADC_NEON_SHA(int32x2_t, "ssra", 2s, 1, __a, __b, __n)
#define vsraq_n_s32(__a, __b, __n) __BADC_NEON_SHA(int32x4_t, "ssra", 4s, 1, __a, __b, __n)
#define vrsra_n_s32(__a, __b, __n) __BADC_NEON_SHA(int32x2_t, "srsra", 2s, 1, __a, __b, __n)
#define vrsraq_n_s32(__a, __b, __n) __BADC_NEON_SHA(int32x4_t, "srsra", 4s, 1, __a, __b, __n)

#define vshl_n_u32(__a, __n) __BADC_NEON_SHB(uint32x2_t, __builtin_neon_shl, 2s, 0, __a, __n)
#define vshlq_n_u32(__a, __n) __BADC_NEON_SHB(uint32x4_t, __builtin_neon_shl, 4s, 0, __a, __n)
#define vqshl_n_u32(__a, __n) __BADC_NEON_SH(uint32x2_t, "uqshl", 2s, 0, __a, __n)
#define vqshlq_n_u32(__a, __n) __BADC_NEON_SH(uint32x4_t, "uqshl", 4s, 0, __a, __n)
#define vshr_n_u32(__a, __n) __BADC_NEON_SHB(uint32x2_t, __builtin_neon_ushr, 2s, 1, __a, __n)
#define vshrq_n_u32(__a, __n) __BADC_NEON_SHB(uint32x4_t, __builtin_neon_ushr, 4s, 1, __a, __n)
#define vrshr_n_u32(__a, __n) __BADC_NEON_SH(uint32x2_t, "urshr", 2s, 1, __a, __n)
#define vrshrq_n_u32(__a, __n) __BADC_NEON_SH(uint32x4_t, "urshr", 4s, 1, __a, __n)
#define vsra_n_u32(__a, __b, __n) __BADC_NEON_SHA(uint32x2_t, "usra", 2s, 1, __a, __b, __n)
#define vsraq_n_u32(__a, __b, __n) __BADC_NEON_SHA(uint32x4_t, "usra", 4s, 1, __a, __b, __n)
#define vrsra_n_u32(__a, __b, __n) __BADC_NEON_SHA(uint32x2_t, "ursra", 2s, 1, __a, __b, __n)
#define vrsraq_n_u32(__a, __b, __n) __BADC_NEON_SHA(uint32x4_t, "ursra", 4s, 1, __a, __b, __n)

#define vshl_n_s64(__a, __n) __BADC_NEON_SHB(int64x1_t, __builtin_neon_shl, d, 0, __a, __n)
#define vshlq_n_s64(__a, __n) __BADC_NEON_SHB(int64x2_t, __builtin_neon_shl, 2d, 0, __a, __n)
#define vqshl_n_s64(__a, __n) __BADC_NEON_SH(int64x1_t, "sqshl", d, 0, __a, __n)
#define vqshlq_n_s64(__a, __n) __BADC_NEON_SH(int64x2_t, "sqshl", 2d, 0, __a, __n)
#define vshr_n_s64(__a, __n) __BADC_NEON_SHB(int64x1_t, __builtin_neon_sshr, d, 1, __a, __n)
#define vshrq_n_s64(__a, __n) __BADC_NEON_SHB(int64x2_t, __builtin_neon_sshr, 2d, 1, __a, __n)
#define vrshr_n_s64(__a, __n) __BADC_NEON_SH(int64x1_t, "srshr", d, 1, __a, __n)
#define vrshrq_n_s64(__a, __n) __BADC_NEON_SH(int64x2_t, "srshr", 2d, 1, __a, __n)
#define vsra_n_s64(__a, __b, __n) __BADC_NEON_SHA(int64x1_t, "ssra", d, 1, __a, __b, __n)
#define vsraq_n_s64(__a, __b, __n) __BADC_NEON_SHA(int64x2_t, "ssra", 2d, 1, __a, __b, __n)
#define vrsra_n_s64(__a, __b, __n) __BADC_NEON_SHA(int64x1_t, "srsra", d, 1, __a, __b, __n)
#define vrsraq_n_s64(__a, __b, __n) __BADC_NEON_SHA(int64x2_t, "srsra", 2d, 1, __a, __b, __n)

#define vshl_n_u64(__a, __n) __BADC_NEON_SHB(uint64x1_t, __builtin_neon_shl, d, 0, __a, __n)
#define vshlq_n_u64(__a, __n) __BADC_NEON_SHB(uint64x2_t, __builtin_neon_shl, 2d, 0, __a, __n)
#define vqshl_n_u64(__a, __n) __BADC_NEON_SH(uint64x1_t, "uqshl", d, 0, __a, __n)
#define vqshlq_n_u64(__a, __n) __BADC_NEON_SH(uint64x2_t, "uqshl", 2d, 0, __a, __n)
#define vshr_n_u64(__a, __n) __BADC_NEON_SHB(uint64x1_t, __builtin_neon_ushr, d, 1, __a, __n)
#define vshrq_n_u64(__a, __n) __BADC_NEON_SHB(uint64x2_t, __builtin_neon_ushr, 2d, 1, __a, __n)
#define vrshr_n_u64(__a, __n) __BADC_NEON_SH(uint64x1_t, "urshr", d, 1, __a, __n)
#define vrshrq_n_u64(__a, __n) __BADC_NEON_SH(uint64x2_t, "urshr", 2d, 1, __a, __n)
#define vsra_n_u64(__a, __b, __n) __BADC_NEON_SHA(uint64x1_t, "usra", d, 1, __a, __b, __n)
#define vsraq_n_u64(__a, __b, __n) __BADC_NEON_SHA(uint64x2_t, "usra", 2d, 1, __a, __b, __n)
#define vrsra_n_u64(__a, __b, __n) __BADC_NEON_SHA(uint64x1_t, "ursra", d, 1, __a, __b, __n)
#define vrsraq_n_u64(__a, __b, __n) __BADC_NEON_SHA(uint64x2_t, "ursra", 2d, 1, __a, __b, __n)

#define vsli_n_s8(__a, __b, __n) __BADC_NEON_SHA(int8x8_t, "sli", 8b, 0, __a, __b, __n)
#define vsliq_n_s8(__a, __b, __n) __BADC_NEON_SHA(int8x16_t, "sli", 16b, 0, __a, __b, __n)
#define vsri_n_s8(__a, __b, __n) __BADC_NEON_SHA(int8x8_t, "sri", 8b, 1, __a, __b, __n)
#define vsriq_n_s8(__a, __b, __n) __BADC_NEON_SHA(int8x16_t, "sri", 16b, 1, __a, __b, __n)

#define vsli_n_u8(__a, __b, __n) __BADC_NEON_SHA(uint8x8_t, "sli", 8b, 0, __a, __b, __n)
#define vsliq_n_u8(__a, __b, __n) __BADC_NEON_SHA(uint8x16_t, "sli", 16b, 0, __a, __b, __n)
#define vsri_n_u8(__a, __b, __n) __BADC_NEON_SHA(uint8x8_t, "sri", 8b, 1, __a, __b, __n)
#define vsriq_n_u8(__a, __b, __n) __BADC_NEON_SHA(uint8x16_t, "sri", 16b, 1, __a, __b, __n)

#define vsli_n_p8(__a, __b, __n) __BADC_NEON_SHA(poly8x8_t, "sli", 8b, 0, __a, __b, __n)
#define vsliq_n_p8(__a, __b, __n) __BADC_NEON_SHA(poly8x16_t, "sli", 16b, 0, __a, __b, __n)
#define vsri_n_p8(__a, __b, __n) __BADC_NEON_SHA(poly8x8_t, "sri", 8b, 1, __a, __b, __n)
#define vsriq_n_p8(__a, __b, __n) __BADC_NEON_SHA(poly8x16_t, "sri", 16b, 1, __a, __b, __n)

#define vsli_n_s16(__a, __b, __n) __BADC_NEON_SHA(int16x4_t, "sli", 4h, 0, __a, __b, __n)
#define vsliq_n_s16(__a, __b, __n) __BADC_NEON_SHA(int16x8_t, "sli", 8h, 0, __a, __b, __n)
#define vsri_n_s16(__a, __b, __n) __BADC_NEON_SHA(int16x4_t, "sri", 4h, 1, __a, __b, __n)
#define vsriq_n_s16(__a, __b, __n) __BADC_NEON_SHA(int16x8_t, "sri", 8h, 1, __a, __b, __n)

#define vsli_n_u16(__a, __b, __n) __BADC_NEON_SHA(uint16x4_t, "sli", 4h, 0, __a, __b, __n)
#define vsliq_n_u16(__a, __b, __n) __BADC_NEON_SHA(uint16x8_t, "sli", 8h, 0, __a, __b, __n)
#define vsri_n_u16(__a, __b, __n) __BADC_NEON_SHA(uint16x4_t, "sri", 4h, 1, __a, __b, __n)
#define vsriq_n_u16(__a, __b, __n) __BADC_NEON_SHA(uint16x8_t, "sri", 8h, 1, __a, __b, __n)

#define vsli_n_p16(__a, __b, __n) __BADC_NEON_SHA(poly16x4_t, "sli", 4h, 0, __a, __b, __n)
#define vsliq_n_p16(__a, __b, __n) __BADC_NEON_SHA(poly16x8_t, "sli", 8h, 0, __a, __b, __n)
#define vsri_n_p16(__a, __b, __n) __BADC_NEON_SHA(poly16x4_t, "sri", 4h, 1, __a, __b, __n)
#define vsriq_n_p16(__a, __b, __n) __BADC_NEON_SHA(poly16x8_t, "sri", 8h, 1, __a, __b, __n)

#define vsli_n_s32(__a, __b, __n) __BADC_NEON_SHA(int32x2_t, "sli", 2s, 0, __a, __b, __n)
#define vsliq_n_s32(__a, __b, __n) __BADC_NEON_SHA(int32x4_t, "sli", 4s, 0, __a, __b, __n)
#define vsri_n_s32(__a, __b, __n) __BADC_NEON_SHA(int32x2_t, "sri", 2s, 1, __a, __b, __n)
#define vsriq_n_s32(__a, __b, __n) __BADC_NEON_SHA(int32x4_t, "sri", 4s, 1, __a, __b, __n)

#define vsli_n_u32(__a, __b, __n) __BADC_NEON_SHA(uint32x2_t, "sli", 2s, 0, __a, __b, __n)
#define vsliq_n_u32(__a, __b, __n) __BADC_NEON_SHA(uint32x4_t, "sli", 4s, 0, __a, __b, __n)
#define vsri_n_u32(__a, __b, __n) __BADC_NEON_SHA(uint32x2_t, "sri", 2s, 1, __a, __b, __n)
#define vsriq_n_u32(__a, __b, __n) __BADC_NEON_SHA(uint32x4_t, "sri", 4s, 1, __a, __b, __n)

#define vsli_n_s64(__a, __b, __n) __BADC_NEON_SHA(int64x1_t, "sli", d, 0, __a, __b, __n)
#define vsliq_n_s64(__a, __b, __n) __BADC_NEON_SHA(int64x2_t, "sli", 2d, 0, __a, __b, __n)
#define vsri_n_s64(__a, __b, __n) __BADC_NEON_SHA(int64x1_t, "sri", d, 1, __a, __b, __n)
#define vsriq_n_s64(__a, __b, __n) __BADC_NEON_SHA(int64x2_t, "sri", 2d, 1, __a, __b, __n)

#define vsli_n_u64(__a, __b, __n) __BADC_NEON_SHA(uint64x1_t, "sli", d, 0, __a, __b, __n)
#define vsliq_n_u64(__a, __b, __n) __BADC_NEON_SHA(uint64x2_t, "sli", 2d, 0, __a, __b, __n)
#define vsri_n_u64(__a, __b, __n) __BADC_NEON_SHA(uint64x1_t, "sri", d, 1, __a, __b, __n)
#define vsriq_n_u64(__a, __b, __n) __BADC_NEON_SHA(uint64x2_t, "sri", 2d, 1, __a, __b, __n)

#define vsli_n_p64(__a, __b, __n) __BADC_NEON_SHA(poly64x1_t, "sli", d, 0, __a, __b, __n)
#define vsliq_n_p64(__a, __b, __n) __BADC_NEON_SHA(poly64x2_t, "sli", 2d, 0, __a, __b, __n)
#define vsri_n_p64(__a, __b, __n) __BADC_NEON_SHA(poly64x1_t, "sri", d, 1, __a, __b, __n)
#define vsriq_n_p64(__a, __b, __n) __BADC_NEON_SHA(poly64x2_t, "sri", 2d, 1, __a, __b, __n)

#define vshrn_n_s16(__a, __n) __BADC_NEON_SHN(int8x8_t, int16x8_t, "shrn", 8b, 8h, __a, __n)
#define vrshrn_n_s16(__a, __n) __BADC_NEON_SHN(int8x8_t, int16x8_t, "rshrn", 8b, 8h, __a, __n)
#define vshrn_n_u16(__a, __n) __BADC_NEON_SHN(uint8x8_t, uint16x8_t, "shrn", 8b, 8h, __a, __n)
#define vrshrn_n_u16(__a, __n) __BADC_NEON_SHN(uint8x8_t, uint16x8_t, "rshrn", 8b, 8h, __a, __n)
#define vshrn_n_s32(__a, __n) __BADC_NEON_SHN(int16x4_t, int32x4_t, "shrn", 4h, 4s, __a, __n)
#define vrshrn_n_s32(__a, __n) __BADC_NEON_SHN(int16x4_t, int32x4_t, "rshrn", 4h, 4s, __a, __n)
#define vshrn_n_u32(__a, __n) __BADC_NEON_SHN(uint16x4_t, uint32x4_t, "shrn", 4h, 4s, __a, __n)
#define vrshrn_n_u32(__a, __n) __BADC_NEON_SHN(uint16x4_t, uint32x4_t, "rshrn", 4h, 4s, __a, __n)
#define vshrn_n_s64(__a, __n) __BADC_NEON_SHN(int32x2_t, int64x2_t, "shrn", 2s, 2d, __a, __n)
#define vrshrn_n_s64(__a, __n) __BADC_NEON_SHN(int32x2_t, int64x2_t, "rshrn", 2s, 2d, __a, __n)
#define vshrn_n_u64(__a, __n) __BADC_NEON_SHN(uint32x2_t, uint64x2_t, "shrn", 2s, 2d, __a, __n)
#define vrshrn_n_u64(__a, __n) __BADC_NEON_SHN(uint32x2_t, uint64x2_t, "rshrn", 2s, 2d, __a, __n)

/* Byte table lookup; an out-of-range index gives 0. */
static inline uint8x16_t vqtbl1q_u8(uint8x16_t __t, uint8x16_t __idx) {
    uint8x16_t __r;
    __asm__("tbl %0.16b, {%1.16b}, %2.16b" : "=w"(__r) : "w"(__t), "w"(__idx));
    return __r;
}

/* Byte table lookup; an out-of-range index keeps the destination byte. */
static inline uint8x16_t vqtbx1q_u8(uint8x16_t __d, uint8x16_t __t, uint8x16_t __idx) {
    __asm__("tbx %0.16b, {%1.16b}, %2.16b" : "+w"(__d) : "w"(__t), "w"(__idx));
    return __d;
}

/* AES single rounds (FEAT_AES): AddRoundKey + SubBytes + ShiftRows (aese /
 * aesd) and the [inverse] MixColumns (aesmc / aesimc). */
static inline uint8x16_t vaeseq_u8(uint8x16_t __d, uint8x16_t __k) {
    __asm__(".arch_extension aes\n\t"
            "aese %0.16b, %1.16b" : "+w"(__d) : "w"(__k));
    return __d;
}

static inline uint8x16_t vaesdq_u8(uint8x16_t __d, uint8x16_t __k) {
    __asm__(".arch_extension aes\n\t"
            "aesd %0.16b, %1.16b" : "+w"(__d) : "w"(__k));
    return __d;
}

static inline uint8x16_t vaesmcq_u8(uint8x16_t __d) {
    uint8x16_t __r;
    __asm__(".arch_extension aes\n\t"
            "aesmc %0.16b, %1.16b" : "=w"(__r) : "w"(__d));
    return __r;
}

static inline uint8x16_t vaesimcq_u8(uint8x16_t __d) {
    uint8x16_t __r;
    __asm__(".arch_extension aes\n\t"
            "aesimc %0.16b, %1.16b" : "=w"(__r) : "w"(__d));
    return __r;
}

/* 64x64->128 carryless multiply (FEAT_PMULL). The scalar operands move to
 * the low d lanes; the product fills the q register. */
static inline poly128_t vmull_p64(poly64_t __a, poly64_t __b) {
    poly128_t __r;
    __asm__(".arch_extension aes\n\t"
            "pmull %0.1q, %1.1d, %2.1d" : "=w"(__r) : "w"(__a), "w"(__b));
    return __r;
}

/* The same product over the upper d lane of each source. */
static inline poly128_t vmull_high_p64(poly64x2_t __a, poly64x2_t __b) {
    poly128_t __r;
    __asm__(".arch_extension aes\n\t"
            "pmull2 %0.1q, %1.2d, %2.2d" : "=w"(__r) : "w"(__a), "w"(__b));
    return __r;
}

/* SHA-1 and SHA-256 (FEAT_SHA1, FEAT_SHA256): the hash updates take the
 * running state as a q register, SHA-1's e as an s register; the schedule
 * updates accumulate into their first operand. */
#define __BADC_NEON_SHA1H(name, insn)                                       \
    static inline uint32x4_t name(uint32x4_t __abcd, uint32_t __e, uint32x4_t __wk) { \
        __asm__(insn " %q0, %s1, %2.4s" : "+w"(__abcd) : "w"(__e), "w"(__wk)); \
        return __abcd;                                                      \
    }
__BADC_NEON_SHA1H(vsha1cq_u32, "sha1c")
__BADC_NEON_SHA1H(vsha1pq_u32, "sha1p")
__BADC_NEON_SHA1H(vsha1mq_u32, "sha1m")
static inline uint32_t vsha1h_u32(uint32_t __e) {
    uint32_t __r;
    __asm__("sha1h %s0, %s1" : "=w"(__r) : "w"(__e));
    return __r;
}
__BADC_NEON_FN3(vsha1su0q_u32, uint32x4_t, uint32x4_t, uint32x4_t,
                __BADC_NEON_I3("sha1su0", 4s, 4s, 4s))
static inline uint32x4_t vsha1su1q_u32(uint32x4_t __a, uint32x4_t __b) {
    __asm__("sha1su1 %0.4s, %1.4s" : "+w"(__a) : "w"(__b));
    return __a;
}
#define __BADC_NEON_SHAQ(name, T, insn, A)                                  \
    __BADC_NEON_FN3(name, T, T, T, insn " %q0, %q1, %2." #A)
__BADC_NEON_SHAQ(vsha256hq_u32, uint32x4_t, "sha256h", 4s)
__BADC_NEON_SHAQ(vsha256h2q_u32, uint32x4_t, "sha256h2", 4s)
static inline uint32x4_t vsha256su0q_u32(uint32x4_t __a, uint32x4_t __b) {
    __asm__("sha256su0 %0.4s, %1.4s" : "+w"(__a) : "w"(__b));
    return __a;
}
__BADC_NEON_FN3(vsha256su1q_u32, uint32x4_t, uint32x4_t, uint32x4_t,
                __BADC_NEON_I3("sha256su1", 4s, 4s, 4s))

/* SHA-512 and SHA3 (FEAT_SHA512, FEAT_SHA3): the hash and schedule
 * updates, the three-way xor `eor3`, `bcax` (a ^ (b & ~c)), `rax1`
 * (a ^ rol(b, 1)) and `xar` (ror(a ^ b, imm)). */
__BADC_NEON_SHAQ(vsha512hq_u64, uint64x2_t, "sha512h", 2d)
__BADC_NEON_SHAQ(vsha512h2q_u64, uint64x2_t, "sha512h2", 2d)
static inline uint64x2_t vsha512su0q_u64(uint64x2_t __a, uint64x2_t __b) {
    __asm__("sha512su0 %0.2d, %1.2d" : "+w"(__a) : "w"(__b));
    return __a;
}
__BADC_NEON_FN3(vsha512su1q_u64, uint64x2_t, uint64x2_t, uint64x2_t,
                __BADC_NEON_I3("sha512su1", 2d, 2d, 2d))
#define __BADC_NEON_XOR3(name, T, insn)                                     \
    static inline T name(T __a, T __b, T __c) {                             \
        T __r;                                                              \
        __asm__(insn " %0.16b, %1.16b, %2.16b, %3.16b"                      \
                : "=w"(__r) : "w"(__a), "w"(__b), "w"(__c));                \
        return __r;                                                         \
    }
__BADC_NEON_XOR3(veor3q_u8, uint8x16_t, "eor3")
__BADC_NEON_XOR3(vbcaxq_u8, uint8x16_t, "bcax")
__BADC_NEON_XOR3(veor3q_u16, uint16x8_t, "eor3")
__BADC_NEON_XOR3(vbcaxq_u16, uint16x8_t, "bcax")
__BADC_NEON_XOR3(veor3q_u32, uint32x4_t, "eor3")
__BADC_NEON_XOR3(vbcaxq_u32, uint32x4_t, "bcax")
__BADC_NEON_XOR3(veor3q_u64, uint64x2_t, "eor3")
__BADC_NEON_XOR3(vbcaxq_u64, uint64x2_t, "bcax")
__BADC_NEON_XOR3(veor3q_s8, int8x16_t, "eor3")
__BADC_NEON_XOR3(vbcaxq_s8, int8x16_t, "bcax")
__BADC_NEON_XOR3(veor3q_s16, int16x8_t, "eor3")
__BADC_NEON_XOR3(vbcaxq_s16, int16x8_t, "bcax")
__BADC_NEON_XOR3(veor3q_s32, int32x4_t, "eor3")
__BADC_NEON_XOR3(vbcaxq_s32, int32x4_t, "bcax")
__BADC_NEON_XOR3(veor3q_s64, int64x2_t, "eor3")
__BADC_NEON_XOR3(vbcaxq_s64, int64x2_t, "bcax")
__BADC_NEON_FN2(vrax1q_u64, uint64x2_t, uint64x2_t, uint64x2_t,
                __BADC_NEON_I3("rax1", 2d, 2d, 2d))
#define vxarq_u64(__a, __b, __n) __extension__({                            \
    uint64x2_t __xa = (__a), __xb = (__b), __xr;                            \
    _Static_assert((__n) >= 0 && (__n) < 64, "rotate count out of range"); \
    __asm__("xar %0.2d, %1.2d, %2.2d, #%3"                                  \
            : "=w"(__xr) : "w"(__xa), "w"(__xb), "i"(__n));                 \
    __xr;                                                                   \
})

/* SM3 and SM4 (FEAT_SM3, FEAT_SM4). */
static inline uint32x4_t vsm3ss1q_u32(uint32x4_t __a, uint32x4_t __b, uint32x4_t __c) {
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
static inline uint32x4_t vsm4eq_u32(uint32x4_t __a, uint32x4_t __b) {
    __asm__("sm4e %0.4s, %1.4s" : "+w"(__a) : "w"(__b));
    return __a;
}
__BADC_NEON_FN2(vsm4ekeyq_u32, uint32x4_t, uint32x4_t, uint32x4_t,
                __BADC_NEON_I3("sm4ekey", 4s, 4s, 4s))

/* Floating vectors. The float64x1_t arithmetic is the scalar d-register
 * instruction; its compares and integer conversions are C on the one lane. */
#define __BADC_NEON_ARITH2(op, insn)                                      \
    __BADC_NEON_FN2(op##_f32, float32x2_t, float32x2_t, float32x2_t,      \
                    __BADC_NEON_I3(insn, 2s, 2s, 2s))                     \
    __BADC_NEON_FN2(op##q_f32, float32x4_t, float32x4_t, float32x4_t,     \
                    __BADC_NEON_I3(insn, 4s, 4s, 4s))                     \
    __BADC_NEON_FN2(op##q_f64, float64x2_t, float64x2_t, float64x2_t,     \
                    __BADC_NEON_I3(insn, 2d, 2d, 2d))                     \
    __BADC_NEON_FN2(op##_f64, float64x1_t, float64x1_t, float64x1_t,      \
                    __BADC_NEON_I3(insn, d, d, d))
#define __BADC_NEON_ARITH1(op, insn)                                      \
    __BADC_NEON_FN1(op##_f32, float32x2_t, float32x2_t, __BADC_NEON_I2(insn, 2s, 2s)) \
    __BADC_NEON_FN1(op##q_f32, float32x4_t, float32x4_t, __BADC_NEON_I2(insn, 4s, 4s)) \
    __BADC_NEON_FN1(op##q_f64, float64x2_t, float64x2_t, __BADC_NEON_I2(insn, 2d, 2d)) \
    __BADC_NEON_FN1(op##_f64, float64x1_t, float64x1_t, __BADC_NEON_I2(insn, d, d))
/* A compare, operands in I's order; C on the one lane of float64x1_t. */
#define __BADC_NEON_CMP(op, I, insn, rel)                                 \
    __BADC_NEON_FN2(op##_f32, uint32x2_t, float32x2_t, float32x2_t, I(insn, 2s, 2s, 2s)) \
    __BADC_NEON_FN2(op##q_f32, uint32x4_t, float32x4_t, float32x4_t, I(insn, 4s, 4s, 4s)) \
    __BADC_NEON_FN2(op##q_f64, uint64x2_t, float64x2_t, float64x2_t, I(insn, 2d, 2d, 2d)) \
    static inline uint64x1_t op##_f64(float64x1_t __a, float64x1_t __b) { \
        return (uint64x1_t){-(uint64_t)(__a[0] rel __b[0])};              \
    }

__BADC_NEON_ARITH2(vadd, "fadd")
__BADC_NEON_ARITH2(vsub, "fsub")
__BADC_NEON_ARITH2(vmul, "fmul")
__BADC_NEON_ARITH2(vdiv, "fdiv")
__BADC_NEON_ARITH2(vmax, "fmax")
__BADC_NEON_ARITH2(vmin, "fmin")
__BADC_NEON_ARITH1(vabs, "fabs")
__BADC_NEON_ARITH1(vneg, "fneg")
__BADC_NEON_ARITH1(vsqrt, "fsqrt")

/* The reciprocal and reciprocal square root estimates, and their
 * Newton-Raphson steps: vrecps is 2 - a * b, vrsqrts (3 - a * b) / 2. */
__BADC_NEON_ARITH1(vrecpe, "frecpe")
__BADC_NEON_ARITH1(vrsqrte, "frsqrte")
__BADC_NEON_ARITH2(vrecps, "frecps")
__BADC_NEON_ARITH2(vrsqrts, "frsqrts")

/* vfma: a + b * c, vfms: a - b * c, each rounded once. */
#define __BADC_NEON_FUSED(op, insn)                                       \
    __BADC_NEON_FN3(op##_f32, float32x2_t, float32x2_t, float32x2_t,      \
                    __BADC_NEON_I3(insn, 2s, 2s, 2s))                     \
    __BADC_NEON_FN3(op##q_f32, float32x4_t, float32x4_t, float32x4_t,     \
                    __BADC_NEON_I3(insn, 4s, 4s, 4s))                     \
    __BADC_NEON_FN3(op##q_f64, float64x2_t, float64x2_t, float64x2_t,     \
                    __BADC_NEON_I3(insn, 2d, 2d, 2d))
__BADC_NEON_FUSED(vfma, "fmla")
__BADC_NEON_FUSED(vfms, "fmls")
static inline float64x1_t vfma_f64(float64x1_t __a, float64x1_t __b, float64x1_t __c) {
    return (float64x1_t){__builtin_fma(__b[0], __c[0], __a[0])};
}
static inline float64x1_t vfms_f64(float64x1_t __a, float64x1_t __b, float64x1_t __c) {
    return (float64x1_t){__builtin_fma(-__b[0], __c[0], __a[0])};
}

__BADC_NEON_CMP(vceq, __BADC_NEON_I3, "fcmeq", ==)
__BADC_NEON_CMP(vcge, __BADC_NEON_I3, "fcmge", >=)
__BADC_NEON_CMP(vcgt, __BADC_NEON_I3, "fcmgt", >)
__BADC_NEON_CMP(vcle, __BADC_NEON_I3R, "fcmge", <=)
__BADC_NEON_CMP(vclt, __BADC_NEON_I3R, "fcmgt", <)

/* Integer <-> floating lanes of one width; to integer truncates toward
 * zero and saturates. */
#define __BADC_NEON_CVT(name, R, T, insn, A) __BADC_NEON_FN1(name, R, T, __BADC_NEON_I2(insn, A, A))
__BADC_NEON_CVT(vcvt_f32_s32, float32x2_t, int32x2_t, "scvtf", 2s)
__BADC_NEON_CVT(vcvtq_f32_s32, float32x4_t, int32x4_t, "scvtf", 4s)
__BADC_NEON_CVT(vcvt_f32_u32, float32x2_t, uint32x2_t, "ucvtf", 2s)
__BADC_NEON_CVT(vcvtq_f32_u32, float32x4_t, uint32x4_t, "ucvtf", 4s)
__BADC_NEON_CVT(vcvtq_f64_s64, float64x2_t, int64x2_t, "scvtf", 2d)
__BADC_NEON_CVT(vcvtq_f64_u64, float64x2_t, uint64x2_t, "ucvtf", 2d)
__BADC_NEON_CVT(vcvt_s32_f32, int32x2_t, float32x2_t, "fcvtzs", 2s)
__BADC_NEON_CVT(vcvtq_s32_f32, int32x4_t, float32x4_t, "fcvtzs", 4s)
__BADC_NEON_CVT(vcvt_u32_f32, uint32x2_t, float32x2_t, "fcvtzu", 2s)
__BADC_NEON_CVT(vcvtq_u32_f32, uint32x4_t, float32x4_t, "fcvtzu", 4s)
__BADC_NEON_CVT(vcvtq_s64_f64, int64x2_t, float64x2_t, "fcvtzs", 2d)
__BADC_NEON_CVT(vcvtq_u64_f64, uint64x2_t, float64x2_t, "fcvtzu", 2d)
static inline float64x1_t vcvt_f64_s64(int64x1_t __a) { return (float64x1_t){(float64_t)__a[0]}; }
static inline float64x1_t vcvt_f64_u64(uint64x1_t __a) { return (float64x1_t){(float64_t)__a[0]}; }
static inline int64x1_t vcvt_s64_f64(float64x1_t __a) { return (int64x1_t){(int64_t)__a[0]}; }
static inline uint64x1_t vcvt_u64_f64(float64x1_t __a) { return (uint64x1_t){(uint64_t)__a[0]}; }

/* Single <-> double: the lower lanes, or with _high the upper ones. */
static inline float64x2_t vcvt_f64_f32(float32x2_t __a) {
    float64x2_t __r;
    __asm__("fcvtl %0.2d, %1.2s" : "=w"(__r) : "w"(__a));
    return __r;
}
static inline float64x2_t vcvt_high_f64_f32(float32x4_t __a) {
    float64x2_t __r;
    __asm__("fcvtl2 %0.2d, %1.4s" : "=w"(__r) : "w"(__a));
    return __r;
}
static inline float32x2_t vcvt_f32_f64(float64x2_t __a) {
    float32x2_t __r;
    __asm__("fcvtn %0.2s, %1.2d" : "=w"(__r) : "w"(__a));
    return __r;
}
static inline float32x4_t vcvt_high_f32_f64(float32x2_t __lo, float64x2_t __a) {
    float32x4_t __r = {__lo[0], __lo[1], 0, 0};
    __asm__("fcvtn2 %0.4s, %1.2d" : "+w"(__r) : "w"(__a));
    return __r;
}

/* Structure loads: deinterleave lane by lane into the structure types. */
static inline uint16x8x2_t vld2q_u16(const uint16_t *__p) {
    uint16x8x2_t __r;
    for (int __i = 0; __i < 8; __i++) {
        __r.val[0][__i] = __p[2 * __i];
        __r.val[1][__i] = __p[2 * __i + 1];
    }
    return __r;
}

static inline uint8x16x4_t vld4q_u8(const uint8_t *__p) {
    uint8x16x4_t __r;
    for (int __i = 0; __i < 16; __i++)
        for (int __k = 0; __k < 4; __k++)
            __r.val[__k][__i] = __p[4 * __i + __k];
    return __r;
}

#pragma pop_macro("__attribute__")

#endif /* BADC_ARM_NEON_H */
