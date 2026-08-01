/* AArch64 Advanced SIMD (NEON) intrinsics, expressed as inline-asm wrappers
 * over the vector-register (`w`) operand class. Each intrinsic is one
 * instruction; badc does not inline a function containing inline asm, so the
 * wrappers are emitted out-of-line and the surrounding call is the compiler's
 * scheduling barrier.
 *
 * Scope: the integer 128-bit subset used by RAID-syndrome / xor kernels:
 * ld1/st1-class loads and stores, bitwise ops, immediate shifts, dup, the
 * polynomial byte multiply, and the single-table byte lookup. The immediate-
 * shift forms are macros because the shift count must be a template literal.
 *
 * The element typedefs match <stdint.h>; they are repeated here (rather than
 * included) so the header stays usable in freestanding units that define
 * their own pointer-width types.
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

typedef signed char int8x16_t __attribute__((vector_size(16)));
typedef unsigned char uint8x16_t __attribute__((vector_size(16)));
typedef unsigned char poly8x16_t __attribute__((vector_size(16)));
typedef unsigned long long uint64x2_t __attribute__((vector_size(16)));

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

#endif /* BADC_ARM_NEON_H */
