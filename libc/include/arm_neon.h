/* AArch64 Advanced SIMD (NEON) intrinsics, expressed as inline-asm wrappers
 * over the vector-register (`w`) operand class. Each intrinsic is a single
 * instruction over its operands, so a wrapper costs one instruction wherever
 * the optimizer splices it into the caller.
 *
 * Scope: the integer subset used by RAID-syndrome / xor / AEAD kernels
 * (ld1/st1-class loads and stores, bitwise ops, immediate shifts, dup, the
 * polynomial byte multiply, table lookups, byte equality, halfword reversal,
 * the across-lanes minimum, 64-bit lane composition) plus the FEAT_AES
 * surface host crypto acceleration uses (AES single rounds and the 64x64->128
 * carryless multiply). The vector typedefs are gcc's `[u]intNxM_t` set for
 * the 64- and 128-bit widths. The immediate-shift forms are macros because
 * the shift count must be a template literal.
 *
 * The floating vectors float32x2_t, float32x4_t, float64x1_t and float64x2_t
 * take the basic ACLE surface: vld1/vst1, vdup_n/vmov_n, vadd, vsub, vmul,
 * vdiv, vmax, vmin, vabs, vneg, vsqrt, the fused vfma/vfms, vceq/vcge/vcgt/
 * vcle/vclt, vbsl, the integer conversions vcvt_{f32,f64}_{s,u}{32,64} and
 * vcvt_{s,u}{32,64}_{f32,f64} (truncating), vcvt_f64_f32 / vcvt_f32_f64 and
 * their _high forms, the lane reads and writes vget{q}_lane / vset{q}_lane,
 * vget_low/vget_high/vcombine and the reinterpretations with the integer
 * vectors of their width. Not provided: the lane-indexed and by-scalar
 * multiplies, the non-fused vmla/vmls, rounding (vrnd*), estimates (vrecpe,
 * vrsqrte), pairwise and across-lane forms, structure loads (vld2-4), the
 * fixed-point and rounding-mode conversions, and float16 / bfloat16.
 *
 * The element typedefs match <stdint.h>; they are repeated here (rather than
 * included) so the header stays usable in freestanding units that define
 * their own pointer-width types. poly128_t is a 128-bit value with no scalar
 * operations; it is carried as a 16-byte vector so values stay in q-register
 * and memory forms.
 */
#ifndef BADC_ARM_NEON_H
#define BADC_ARM_NEON_H

#ifndef __aarch64__
#error "arm_neon.h requires an AArch64 target"
#endif

typedef signed char int8_t;
typedef short int16_t;
typedef int int32_t;
typedef __INT64_TYPE__ int64_t;
typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;
typedef __UINT64_TYPE__ uint64_t;

typedef __UINT64_TYPE__ poly64_t;

typedef signed char int8x8_t __attribute__((vector_size(8)));
typedef short int16x4_t __attribute__((vector_size(8)));
typedef int int32x2_t __attribute__((vector_size(8)));
typedef int64_t int64x1_t __attribute__((vector_size(8)));
typedef unsigned char uint8x8_t __attribute__((vector_size(8)));
typedef unsigned short uint16x4_t __attribute__((vector_size(8)));
typedef unsigned int uint32x2_t __attribute__((vector_size(8)));
typedef uint64_t uint64x1_t __attribute__((vector_size(8)));

typedef signed char int8x16_t __attribute__((vector_size(16)));
typedef short int16x8_t __attribute__((vector_size(16)));
typedef int int32x4_t __attribute__((vector_size(16)));
typedef int64_t int64x2_t __attribute__((vector_size(16)));
typedef unsigned char uint8x16_t __attribute__((vector_size(16)));
typedef unsigned short uint16x8_t __attribute__((vector_size(16)));
typedef unsigned int uint32x4_t __attribute__((vector_size(16)));
typedef uint64_t uint64x2_t __attribute__((vector_size(16)));
typedef unsigned char poly8x16_t __attribute__((vector_size(16)));
typedef poly64_t poly64x2_t __attribute__((vector_size(16)));
typedef poly64_t poly128_t __attribute__((vector_size(16)));

static inline uint8x16_t vld1q_u8(const uint8_t *__p) {
    uint8x16_t __r;
    __asm__("ldr %q0, [%1]" : "=w"(__r) : "r"(__p) : "memory");
    return __r;
}

static inline uint64x2_t vld1q_u64(const uint64_t *__p) {
    uint64x2_t __r;
    __asm__("ldr %q0, [%1]" : "=w"(__r) : "r"(__p) : "memory");
    return __r;
}

static inline void vst1q_u8(uint8_t *__p, uint8x16_t __v) {
    __asm__("str %q1, [%0]" : : "r"(__p), "w"(__v) : "memory");
}

static inline void vst1q_u64(uint64_t *__p, uint64x2_t __v) {
    __asm__("str %q1, [%0]" : : "r"(__p), "w"(__v) : "memory");
}

static inline uint8x16_t veorq_u8(uint8x16_t __a, uint8x16_t __b) {
    uint8x16_t __r;
    __asm__("eor %0.16b, %1.16b, %2.16b" : "=w"(__r) : "w"(__a), "w"(__b));
    return __r;
}

static inline uint64x2_t veorq_u64(uint64x2_t __a, uint64x2_t __b) {
    uint64x2_t __r;
    __asm__("eor %0.16b, %1.16b, %2.16b" : "=w"(__r) : "w"(__a), "w"(__b));
    return __r;
}

static inline uint8x16_t vandq_u8(uint8x16_t __a, uint8x16_t __b) {
    uint8x16_t __r;
    __asm__("and %0.16b, %1.16b, %2.16b" : "=w"(__r) : "w"(__a), "w"(__b));
    return __r;
}

static inline uint8x16_t vdupq_n_u8(uint8_t __a) {
    uint8x16_t __r;
    __asm__("dup %0.16b, %w1" : "=w"(__r) : "r"(__a));
    return __r;
}

/* Polynomial (carryless) byte multiply. */
static inline poly8x16_t vmulq_p8(poly8x16_t __a, poly8x16_t __b) {
    poly8x16_t __r;
    __asm__("pmul %0.16b, %1.16b, %2.16b" : "=w"(__r) : "w"(__a), "w"(__b));
    return __r;
}

/* Byte table lookup: each index byte selects a byte of the table (or 0 when
 * out of range). */
static inline uint8x16_t vqtbl1q_u8(uint8x16_t __t, uint8x16_t __idx) {
    uint8x16_t __r;
    __asm__("tbl %0.16b, {%1.16b}, %2.16b" : "=w"(__r) : "w"(__t), "w"(__idx));
    return __r;
}

/* Byte table lookup with fallback: an out-of-range index byte keeps the
 * destination byte. */
static inline uint8x16_t vqtbx1q_u8(uint8x16_t __d, uint8x16_t __t, uint8x16_t __idx) {
    __asm__("tbx %0.16b, {%1.16b}, %2.16b" : "+w"(__d) : "w"(__t), "w"(__idx));
    return __d;
}

/* Per-byte equality: a lane holds 0xff where the bytes are equal, 0 where
 * they differ. */
static inline uint8x16_t vceqq_u8(uint8x16_t __a, uint8x16_t __b) {
    uint8x16_t __r;
    __asm__("cmeq %0.16b, %1.16b, %2.16b" : "=w"(__r) : "w"(__a), "w"(__b));
    return __r;
}

/* Reverse the 16-bit elements within each 32-bit word. */
static inline uint16x8_t vrev32q_u16(uint16x8_t __a) {
    uint16x8_t __r;
    __asm__("rev32 %0.8h, %1.8h" : "=w"(__r) : "w"(__a));
    return __r;
}

/* Minimum across the signed byte lanes; the reduction rides a clobbered
 * register because a `b`-register operand view would need a template
 * modifier the wrappers here avoid. */
static inline int8_t vminvq_s8(int8x16_t __a) {
    int __r;
    __asm__("sminv b7, %1.16b\n\tsmov %w0, v7.b[0]" : "=r"(__r) : "w"(__a) : "v7");
    return (int8_t)__r;
}

/* Single-lane 64-bit vector from a scalar, and the 128-bit concatenation of
 * two of them, spelled through lane assignment. */
static inline uint64x1_t vmov_n_u64(uint64_t __a) {
    uint64x1_t __r;
    __r[0] = __a;
    return __r;
}

static inline uint64x2_t vcombine_u64(uint64x1_t __lo, uint64x1_t __hi) {
    uint64x2_t __r;
    __r[0] = __lo[0];
    __r[1] = __hi[0];
    return __r;
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

/* Reinterpretations. Every 128-bit vector type here shares one
 * representation, so these are casts and cost nothing; they exist because
 * portable code spells the type change through them. */
static inline uint64x2_t vreinterpretq_u64_u8(uint8x16_t __a) {
    return (uint64x2_t)__a;
}

static inline uint8x16_t vreinterpretq_u8_u64(uint64x2_t __a) {
    return (uint8x16_t)__a;
}

static inline uint64x2_t vreinterpretq_u64_p128(poly128_t __a) {
    return (uint64x2_t)__a;
}

static inline poly128_t vreinterpretq_p128_u64(uint64x2_t __a) {
    return (poly128_t)__a;
}

static inline poly64x2_t vreinterpretq_p64_u64(uint64x2_t __a) {
    return (poly64x2_t)__a;
}

static inline uint64x2_t vreinterpretq_u64_p64(poly64x2_t __a) {
    return (uint64x2_t)__a;
}

/* Immediate shifts: the count is pasted into the template, so it must be an
 * integer literal (as in the reference headers, where it must be a constant
 * expression). */
#define vshlq_n_u8(__a, __n) __extension__({                              \
    uint8x16_t __sa = (__a), __sr;                                        \
    __asm__("shl %0.16b, %1.16b, #" #__n : "=w"(__sr) : "w"(__sa));       \
    __sr;                                                                 \
})

#define vshrq_n_u8(__a, __n) __extension__({                              \
    uint8x16_t __sa = (__a), __sr;                                        \
    __asm__("ushr %0.16b, %1.16b, #" #__n : "=w"(__sr) : "w"(__sa));      \
    __sr;                                                                 \
})

#define vshrq_n_s8(__a, __n) __extension__({                              \
    int8x16_t __sa = (__a), __sr;                                         \
    __asm__("sshr %0.16b, %1.16b, #" #__n : "=w"(__sr) : "w"(__sa));      \
    __sr;                                                                 \
})

/* Lane read: the lane index is pasted into the template, so it must be an
 * integer literal (as in the reference headers, where it must be a constant
 * expression). */
#define vgetq_lane_u64(__a, __n) __extension__({                          \
    uint64x2_t __ga = (__a);                                              \
    uint64_t __gr;                                                        \
    __asm__("umov %x0, %1.d[" #__n "]" : "=r"(__gr) : "w"(__ga));         \
    __gr;                                                                 \
})

/* Concatenate two vectors and take the 128-bit window starting at element
 * __n; the instruction's index is in bytes. */
#define vextq_u64(__a, __b, __n) __extension__({                          \
    uint64x2_t __xa = (__a), __xb = (__b), __xr;                          \
    __asm__("ext %0.16b, %1.16b, %2.16b, #" #__n "*8"                     \
            : "=w"(__xr) : "w"(__xa), "w"(__xb));                         \
    __xr;                                                                 \
})

/* Floating vectors. The 64-bit forms work on the d view (`.2s`); the
 * float64x1_t arithmetic is the scalar d-register instruction, and its
 * compares and integer conversions are C on the one lane. */
typedef float float32_t;
typedef double float64_t;
typedef float float32x2_t __attribute__((vector_size(8)));
typedef float float32x4_t __attribute__((vector_size(16)));
typedef double float64x1_t __attribute__((vector_size(8)));
typedef double float64x2_t __attribute__((vector_size(16)));

#define __BADC_NEON_LOAD(name, T, E, view)                                \
    static inline T name(const E *__p) {                                  \
        T __r;                                                            \
        __asm__("ldr %" view "0, [%1]" : "=w"(__r) : "r"(__p) : "memory"); \
        return __r;                                                       \
    }
#define __BADC_NEON_STORE(name, T, E, view)                               \
    static inline void name(E *__p, T __v) {                              \
        __asm__("str %" view "1, [%0]" : : "r"(__p), "w"(__v) : "memory"); \
    }
/* `insn %0.A, %1.A`, the result of type R. */
#define __BADC_NEON_1(name, R, T, insn, A)                                \
    static inline R name(T __a) {                                         \
        R __r;                                                            \
        __asm__(insn " %0." A ", %1." A : "=w"(__r) : "w"(__a));          \
        return __r;                                                       \
    }
/* `insn %0.A, %1.A, %2.A` over (x, y), the result of type R. */
#define __BADC_NEON_2(name, R, T, insn, A, x, y)                          \
    static inline R name(T __a, T __b) {                                  \
        R __r;                                                            \
        __asm__(insn " %0." A ", %1." A ", %2." A : "=w"(__r) : "w"(x), "w"(y)); \
        return __r;                                                       \
    }
/* The fused multiply-accumulate into the first operand. */
#define __BADC_NEON_ACC(name, T, insn, A)                                 \
    static inline T name(T __a, T __b, T __c) {                           \
        __asm__(insn " %0." A ", %1." A ", %2." A : "+w"(__a) : "w"(__b), "w"(__c)); \
        return __a;                                                       \
    }
#define __BADC_NEON_D1(name, insn)                                        \
    static inline float64x1_t name(float64x1_t __a) {                     \
        float64x1_t __r;                                                  \
        __asm__(insn " %d0, %d1" : "=w"(__r) : "w"(__a));                 \
        return __r;                                                       \
    }
#define __BADC_NEON_D2(name, insn)                                        \
    static inline float64x1_t name(float64x1_t __a, float64x1_t __b) {   \
        float64x1_t __r;                                                  \
        __asm__(insn " %d0, %d1, %d2" : "=w"(__r) : "w"(__a), "w"(__b));  \
        return __r;                                                       \
    }
/* `vX_f32`, `vXq_f32`, `vX_f64` and `vXq_f64` of one operation. */
#define __BADC_NEON_ARITH2(op, insn)                                      \
    __BADC_NEON_2(op##_f32, float32x2_t, float32x2_t, insn, "2s", __a, __b) \
    __BADC_NEON_2(op##q_f32, float32x4_t, float32x4_t, insn, "4s", __a, __b) \
    __BADC_NEON_2(op##q_f64, float64x2_t, float64x2_t, insn, "2d", __a, __b) \
    __BADC_NEON_D2(op##_f64, insn)
#define __BADC_NEON_ARITH1(op, insn)                                      \
    __BADC_NEON_1(op##_f32, float32x2_t, float32x2_t, insn, "2s")         \
    __BADC_NEON_1(op##q_f32, float32x4_t, float32x4_t, insn, "4s")        \
    __BADC_NEON_1(op##q_f64, float64x2_t, float64x2_t, insn, "2d")        \
    __BADC_NEON_D1(op##_f64, insn)
/* A compare, its operands in the instruction's order x, y; C on the one
 * lane of float64x1_t. */
#define __BADC_NEON_CMP(op, insn, x, y, rel)                              \
    __BADC_NEON_2(op##_f32, uint32x2_t, float32x2_t, insn, "2s", x, y)    \
    __BADC_NEON_2(op##q_f32, uint32x4_t, float32x4_t, insn, "4s", x, y)   \
    __BADC_NEON_2(op##q_f64, uint64x2_t, float64x2_t, insn, "2d", x, y)   \
    static inline uint64x1_t op##_f64(float64x1_t __a, float64x1_t __b) { \
        return (uint64x1_t){-(uint64_t)(__a[0] rel __b[0])};              \
    }

__BADC_NEON_LOAD(vld1_f32, float32x2_t, float32_t, "d")
__BADC_NEON_LOAD(vld1q_f32, float32x4_t, float32_t, "q")
__BADC_NEON_LOAD(vld1_f64, float64x1_t, float64_t, "d")
__BADC_NEON_LOAD(vld1q_f64, float64x2_t, float64_t, "q")
__BADC_NEON_STORE(vst1_f32, float32x2_t, float32_t, "d")
__BADC_NEON_STORE(vst1q_f32, float32x4_t, float32_t, "q")
__BADC_NEON_STORE(vst1_f64, float64x1_t, float64_t, "d")
__BADC_NEON_STORE(vst1q_f64, float64x2_t, float64_t, "q")

__BADC_NEON_ARITH2(vadd, "fadd")
__BADC_NEON_ARITH2(vsub, "fsub")
__BADC_NEON_ARITH2(vmul, "fmul")
__BADC_NEON_ARITH2(vdiv, "fdiv")
__BADC_NEON_ARITH2(vmax, "fmax")
__BADC_NEON_ARITH2(vmin, "fmin")
__BADC_NEON_ARITH1(vabs, "fabs")
__BADC_NEON_ARITH1(vneg, "fneg")
__BADC_NEON_ARITH1(vsqrt, "fsqrt")

/* vfma: a + b * c, vfms: a - b * c, each rounded once. */
__BADC_NEON_ACC(vfma_f32, float32x2_t, "fmla", "2s")
__BADC_NEON_ACC(vfmaq_f32, float32x4_t, "fmla", "4s")
__BADC_NEON_ACC(vfmaq_f64, float64x2_t, "fmla", "2d")
__BADC_NEON_ACC(vfms_f32, float32x2_t, "fmls", "2s")
__BADC_NEON_ACC(vfmsq_f32, float32x4_t, "fmls", "4s")
__BADC_NEON_ACC(vfmsq_f64, float64x2_t, "fmls", "2d")
static inline float64x1_t vfma_f64(float64x1_t __a, float64x1_t __b, float64x1_t __c) {
    return (float64x1_t){__builtin_fma(__b[0], __c[0], __a[0])};
}
static inline float64x1_t vfms_f64(float64x1_t __a, float64x1_t __b, float64x1_t __c) {
    return (float64x1_t){__builtin_fma(-__b[0], __c[0], __a[0])};
}

/* All-ones lanes where the relation holds; vcle and vclt are vcge and vcgt
 * with the operands swapped. */
__BADC_NEON_CMP(vceq, "fcmeq", __a, __b, ==)
__BADC_NEON_CMP(vcge, "fcmge", __a, __b, >=)
__BADC_NEON_CMP(vcgt, "fcmgt", __a, __b, >)
__BADC_NEON_CMP(vcle, "fcmge", __b, __a, <=)
__BADC_NEON_CMP(vclt, "fcmgt", __b, __a, <)

/* Bitwise select: the mask's set bits take the first operand's. */
#define __BADC_NEON_BSL(name, M, T, A)                                    \
    static inline T name(M __m, T __a, T __b) {                           \
        __asm__("bsl %0." A ", %1." A ", %2." A : "+w"(__m) : "w"(__a), "w"(__b)); \
        return (T)__m;                                                    \
    }
__BADC_NEON_BSL(vbsl_f32, uint32x2_t, float32x2_t, "8b")
__BADC_NEON_BSL(vbslq_f32, uint32x4_t, float32x4_t, "16b")
__BADC_NEON_BSL(vbsl_f64, uint64x1_t, float64x1_t, "8b")
__BADC_NEON_BSL(vbslq_f64, uint64x2_t, float64x2_t, "16b")

/* Integer <-> floating lanes of one width; to integer truncates toward
 * zero and saturates. */
__BADC_NEON_1(vcvt_f32_s32, float32x2_t, int32x2_t, "scvtf", "2s")
__BADC_NEON_1(vcvtq_f32_s32, float32x4_t, int32x4_t, "scvtf", "4s")
__BADC_NEON_1(vcvt_f32_u32, float32x2_t, uint32x2_t, "ucvtf", "2s")
__BADC_NEON_1(vcvtq_f32_u32, float32x4_t, uint32x4_t, "ucvtf", "4s")
__BADC_NEON_1(vcvtq_f64_s64, float64x2_t, int64x2_t, "scvtf", "2d")
__BADC_NEON_1(vcvtq_f64_u64, float64x2_t, uint64x2_t, "ucvtf", "2d")
__BADC_NEON_1(vcvt_s32_f32, int32x2_t, float32x2_t, "fcvtzs", "2s")
__BADC_NEON_1(vcvtq_s32_f32, int32x4_t, float32x4_t, "fcvtzs", "4s")
__BADC_NEON_1(vcvt_u32_f32, uint32x2_t, float32x2_t, "fcvtzu", "2s")
__BADC_NEON_1(vcvtq_u32_f32, uint32x4_t, float32x4_t, "fcvtzu", "4s")
__BADC_NEON_1(vcvtq_s64_f64, int64x2_t, float64x2_t, "fcvtzs", "2d")
__BADC_NEON_1(vcvtq_u64_f64, uint64x2_t, float64x2_t, "fcvtzu", "2d")
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

/* Every lane set to the scalar. */
static inline float32x2_t vdup_n_f32(float32_t __x) { return (float32x2_t){__x, __x}; }
static inline float32x4_t vdupq_n_f32(float32_t __x) { return (float32x4_t){__x, __x, __x, __x}; }
static inline float64x1_t vdup_n_f64(float64_t __x) { return (float64x1_t){__x}; }
static inline float64x2_t vdupq_n_f64(float64_t __x) { return (float64x2_t){__x, __x}; }
static inline float32x2_t vmov_n_f32(float32_t __x) { return vdup_n_f32(__x); }
static inline float32x4_t vmovq_n_f32(float32_t __x) { return vdupq_n_f32(__x); }
static inline float64x1_t vmov_n_f64(float64_t __x) { return vdup_n_f64(__x); }
static inline float64x2_t vmovq_n_f64(float64_t __x) { return vdupq_n_f64(__x); }

/* Halves and their concatenation. */
static inline float32x2_t vget_low_f32(float32x4_t __a) { return (float32x2_t){__a[0], __a[1]}; }
static inline float32x2_t vget_high_f32(float32x4_t __a) { return (float32x2_t){__a[2], __a[3]}; }
static inline float64x1_t vget_low_f64(float64x2_t __a) { return (float64x1_t){__a[0]}; }
static inline float64x1_t vget_high_f64(float64x2_t __a) { return (float64x1_t){__a[1]}; }
static inline float32x4_t vcombine_f32(float32x2_t __lo, float32x2_t __hi) {
    return (float32x4_t){__lo[0], __lo[1], __hi[0], __hi[1]};
}
static inline float64x2_t vcombine_f64(float64x1_t __lo, float64x1_t __hi) {
    return (float64x2_t){__lo[0], __hi[0]};
}

/* Lane reads and writes; the lane is an integer constant expression within
 * the vector. */
#define __BADC_NEON_LANE(__n, __lanes) \
    _Static_assert((__n) >= 0 && (__n) < (__lanes), "lane index out of range")
#define __BADC_NEON_GET(T, __v, __n, __lanes) __extension__({             \
    T __lv = (__v);                                                       \
    __BADC_NEON_LANE(__n, __lanes);                                       \
    __lv[__n];                                                            \
})
#define __BADC_NEON_SET(T, __x, __v, __n, __lanes) __extension__({        \
    T __lv = (__v);                                                       \
    __BADC_NEON_LANE(__n, __lanes);                                       \
    __lv[__n] = (__x);                                                    \
    __lv;                                                                 \
})
#define vget_lane_f32(__v, __n) __BADC_NEON_GET(float32x2_t, __v, __n, 2)
#define vgetq_lane_f32(__v, __n) __BADC_NEON_GET(float32x4_t, __v, __n, 4)
#define vget_lane_f64(__v, __n) __BADC_NEON_GET(float64x1_t, __v, __n, 1)
#define vgetq_lane_f64(__v, __n) __BADC_NEON_GET(float64x2_t, __v, __n, 2)
#define vset_lane_f32(__x, __v, __n) __BADC_NEON_SET(float32x2_t, __x, __v, __n, 2)
#define vsetq_lane_f32(__x, __v, __n) __BADC_NEON_SET(float32x4_t, __x, __v, __n, 4)
#define vset_lane_f64(__x, __v, __n) __BADC_NEON_SET(float64x1_t, __x, __v, __n, 1)
#define vsetq_lane_f64(__x, __v, __n) __BADC_NEON_SET(float64x2_t, __x, __v, __n, 2)

/* Reinterpretations with the integer vectors of the same width. */
#define __BADC_NEON_CAST(name, R, T) \
    static inline R name(T __a) { return (R)__a; }
__BADC_NEON_CAST(vreinterpret_f32_u32, float32x2_t, uint32x2_t)
__BADC_NEON_CAST(vreinterpret_u32_f32, uint32x2_t, float32x2_t)
__BADC_NEON_CAST(vreinterpret_f32_s32, float32x2_t, int32x2_t)
__BADC_NEON_CAST(vreinterpret_s32_f32, int32x2_t, float32x2_t)
__BADC_NEON_CAST(vreinterpretq_f32_u32, float32x4_t, uint32x4_t)
__BADC_NEON_CAST(vreinterpretq_u32_f32, uint32x4_t, float32x4_t)
__BADC_NEON_CAST(vreinterpretq_f32_s32, float32x4_t, int32x4_t)
__BADC_NEON_CAST(vreinterpretq_s32_f32, int32x4_t, float32x4_t)
__BADC_NEON_CAST(vreinterpretq_f32_u8, float32x4_t, uint8x16_t)
__BADC_NEON_CAST(vreinterpretq_u8_f32, uint8x16_t, float32x4_t)
__BADC_NEON_CAST(vreinterpret_f64_u64, float64x1_t, uint64x1_t)
__BADC_NEON_CAST(vreinterpret_u64_f64, uint64x1_t, float64x1_t)
__BADC_NEON_CAST(vreinterpret_f64_s64, float64x1_t, int64x1_t)
__BADC_NEON_CAST(vreinterpret_s64_f64, int64x1_t, float64x1_t)
__BADC_NEON_CAST(vreinterpretq_f64_u64, float64x2_t, uint64x2_t)
__BADC_NEON_CAST(vreinterpretq_u64_f64, uint64x2_t, float64x2_t)
__BADC_NEON_CAST(vreinterpretq_f64_s64, float64x2_t, int64x2_t)
__BADC_NEON_CAST(vreinterpretq_s64_f64, int64x2_t, float64x2_t)
__BADC_NEON_CAST(vreinterpretq_f64_f32, float64x2_t, float32x4_t)
__BADC_NEON_CAST(vreinterpretq_f32_f64, float32x4_t, float64x2_t)

#undef __BADC_NEON_LOAD
#undef __BADC_NEON_STORE
#undef __BADC_NEON_1
#undef __BADC_NEON_2
#undef __BADC_NEON_ACC
#undef __BADC_NEON_D1
#undef __BADC_NEON_D2
#undef __BADC_NEON_ARITH1
#undef __BADC_NEON_ARITH2
#undef __BADC_NEON_CMP
#undef __BADC_NEON_BSL
#undef __BADC_NEON_CAST

#endif /* BADC_ARM_NEON_H */
