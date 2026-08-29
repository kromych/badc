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
typedef long long int64_t;
typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;
typedef unsigned long long uint64_t;

typedef unsigned long long poly64_t;

typedef signed char int8x8_t __attribute__((vector_size(8)));
typedef short int16x4_t __attribute__((vector_size(8)));
typedef int int32x2_t __attribute__((vector_size(8)));
typedef long long int64x1_t __attribute__((vector_size(8)));
typedef unsigned char uint8x8_t __attribute__((vector_size(8)));
typedef unsigned short uint16x4_t __attribute__((vector_size(8)));
typedef unsigned int uint32x2_t __attribute__((vector_size(8)));
typedef unsigned long long uint64x1_t __attribute__((vector_size(8)));

typedef signed char int8x16_t __attribute__((vector_size(16)));
typedef short int16x8_t __attribute__((vector_size(16)));
typedef int int32x4_t __attribute__((vector_size(16)));
typedef long long int64x2_t __attribute__((vector_size(16)));
typedef unsigned char uint8x16_t __attribute__((vector_size(16)));
typedef unsigned short uint16x8_t __attribute__((vector_size(16)));
typedef unsigned int uint32x4_t __attribute__((vector_size(16)));
typedef unsigned long long uint64x2_t __attribute__((vector_size(16)));
typedef unsigned char poly8x16_t __attribute__((vector_size(16)));
typedef unsigned long long poly64x2_t __attribute__((vector_size(16)));
typedef unsigned long long poly128_t __attribute__((vector_size(16)));

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

#endif /* BADC_ARM_NEON_H */
