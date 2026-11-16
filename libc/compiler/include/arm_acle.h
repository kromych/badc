/* The Arm C Language Extensions' <arm_acle.h> on AArch64: the barrier and
 * hint intrinsics, the data-processing ones (__clz, __cls, __rev, __rbit,
 * __ror and their l and ll forms), CRC32, __jcvt, the FRINTTS roundings,
 * __rndr / __rndrrs, the floating-point ones, prefetch, and the
 * special-register accesses. The barriers, the hints and the CRC32 family
 * lower at the call site to their instruction; the Windows targets declare
 * them in <intrin.h> with MSVC's prototypes. */
#ifndef BADC_ARM_ACLE_H
#define BADC_ARM_ACLE_H

#ifndef __aarch64__
#error "arm_acle.h requires an AArch64 target"
#endif

#include <stdint.h>

#pragma push_macro("__attribute__")
#undef __attribute__

#ifdef _WIN32
#include <intrin.h>
#else
void __dmb(unsigned int);
void __dsb(unsigned int);
void __isb(unsigned int);
void __wfe(void);
void __wfi(void);
void __sev(void);
void __sevl(void);
void __yield(void);
void __nop(void);
uint32_t __crc32b(uint32_t, uint8_t);
uint32_t __crc32h(uint32_t, uint16_t);
uint32_t __crc32w(uint32_t, uint32_t);
uint32_t __crc32d(uint32_t, uint64_t);
uint32_t __crc32cb(uint32_t, uint8_t);
uint32_t __crc32ch(uint32_t, uint16_t);
uint32_t __crc32cw(uint32_t, uint32_t);
uint32_t __crc32cd(uint32_t, uint64_t);
#endif

#define __BADC_ACLE static __inline__

/* Rotate right, the count reduced modulo the width. */
#define __BADC_ACLE_ROR(NAME, T)                                          \
    __BADC_ACLE T NAME(T __x, uint32_t __n) {                             \
        __n %= sizeof(T) * 8;                                             \
        return __n ? (T)(__x >> __n | __x << (sizeof(T) * 8 - __n)) : __x; \
    }
__BADC_ACLE_ROR(__ror, uint32_t)
__BADC_ACLE_ROR(__rorl, unsigned long)
__BADC_ACLE_ROR(__rorll, uint64_t)
#undef __BADC_ACLE_ROR

/* Leading zeros (the width for 0) and leading sign bits after the sign. */
__BADC_ACLE unsigned int __clz(uint32_t __x) { return __x ? __builtin_clz(__x) : 32; }
__BADC_ACLE unsigned int __clzll(uint64_t __x) { return __x ? __builtin_clzll(__x) : 64; }
__BADC_ACLE unsigned int __clzl(unsigned long __x) {
    return sizeof(__x) == 8 ? __clzll(__x) : __clz((uint32_t)__x);
}
__BADC_ACLE unsigned int __cls(uint32_t __x) { return __builtin_clrsb((int32_t)__x); }
__BADC_ACLE unsigned int __clsll(uint64_t __x) { return __builtin_clrsbll((int64_t)__x); }
__BADC_ACLE unsigned int __clsl(unsigned long __x) {
    return sizeof(__x) == 8 ? __clsll(__x) : __cls((uint32_t)__x);
}

/* Byte reversal of the whole value, of each halfword, and of a signed
 * halfword; bit reversal. */
__BADC_ACLE uint32_t __rev(uint32_t __x) { return __builtin_bswap32(__x); }
__BADC_ACLE uint64_t __revll(uint64_t __x) { return __builtin_bswap64(__x); }
__BADC_ACLE unsigned long __revl(unsigned long __x) {
    return sizeof(__x) == 8 ? __revll(__x) : __rev((uint32_t)__x);
}
__BADC_ACLE uint32_t __rev16(uint32_t __x) {
    return (__x >> 8 & 0x00ff00ffu) | (__x & 0x00ff00ffu) << 8;
}
__BADC_ACLE uint64_t __rev16ll(uint64_t __x) {
    return (__x >> 8 & 0x00ff00ff00ff00ffull) | (__x & 0x00ff00ff00ff00ffull) << 8;
}
__BADC_ACLE unsigned long __rev16l(unsigned long __x) {
    return sizeof(__x) == 8 ? __rev16ll(__x) : __rev16((uint32_t)__x);
}
__BADC_ACLE int16_t __revsh(int16_t __x) { return (int16_t)__builtin_bswap16((uint16_t)__x); }
__BADC_ACLE uint32_t __rbit(uint32_t __x) {
    uint32_t __r;
    __asm__("rbit %w0, %w1" : "=r"(__r) : "r"(__x));
    return __r;
}
__BADC_ACLE uint64_t __rbitll(uint64_t __x) {
    uint64_t __r;
    __asm__("rbit %0, %1" : "=r"(__r) : "r"(__x));
    return __r;
}
__BADC_ACLE unsigned long __rbitl(unsigned long __x) {
    return sizeof(__x) == 8 ? __rbitll(__x) : __rbit((uint32_t)__x);
}

/* FEAT_JSCVT: the double to int32 rounding toward zero, modulo 2^32. */
__BADC_ACLE int32_t __jcvt(double __x) {
    int32_t __r;
    __asm__("fjcvtzs %w0, %d1" : "=r"(__r) : "w"(__x) : "cc");
    return __r;
}

/* FEAT_FRINTTS: round to an integral value within the int32 / int64
 * range, toward zero (z) or in the current mode (x). */
#define __BADC_ACLE_RINT(NAME, T, MNEM, R)                       \
    __BADC_ACLE T NAME(T __x) {                                  \
        T __r;                                                   \
        __asm__(MNEM " %" R "0, %" R "1" : "=w"(__r) : "w"(__x)); \
        return __r;                                              \
    }
__BADC_ACLE_RINT(__rint32zf, float, "frint32z", "s")
__BADC_ACLE_RINT(__rint32z, double, "frint32z", "d")
__BADC_ACLE_RINT(__rint64zf, float, "frint64z", "s")
__BADC_ACLE_RINT(__rint64z, double, "frint64z", "d")
__BADC_ACLE_RINT(__rint32xf, float, "frint32x", "s")
__BADC_ACLE_RINT(__rint32x, double, "frint32x", "d")
__BADC_ACLE_RINT(__rint64xf, float, "frint64x", "s")
__BADC_ACLE_RINT(__rint64x, double, "frint64x", "d")
#undef __BADC_ACLE_RINT

/* FEAT_RNG: 0 and the random number on success, nonzero and 0 when the
 * generator has none to give. */
#define __BADC_ACLE_RNDR(NAME, REG)                                    \
    __BADC_ACLE int NAME(uint64_t *__p) {                              \
        uint64_t __v;                                                  \
        int __fail;                                                    \
        __asm__ __volatile__("mrs %0, " REG "\n\tcset %w1, eq"         \
                             : "=&r"(__v), "=r"(__fail) : : "cc");     \
        *__p = __v;                                                    \
        return __fail;                                                 \
    }
__BADC_ACLE_RNDR(__rndr, "rndr")
__BADC_ACLE_RNDR(__rndrrs, "rndrrs")
#undef __BADC_ACLE_RNDR

__BADC_ACLE double __sqrt(double __x) { return __builtin_sqrt(__x); }
__BADC_ACLE float __sqrtf(float __x) { return __builtin_sqrtf(__x); }
__BADC_ACLE double __fma(double __x, double __y, double __z) { return __builtin_fma(__x, __y, __z); }
__BADC_ACLE float __fmaf(float __x, float __y, float __z) { return __builtin_fmaf(__x, __y, __z); }

/* Prefetch for a data read or an instruction fetch, kept in L1. */
__BADC_ACLE void __pld(void const volatile *__p) { __asm__ __volatile__("prfm pldl1keep, [%0]" : : "r"(__p)); }
__BADC_ACLE void __pli(void const volatile *__p) { __asm__ __volatile__("prfm plil1keep, [%0]" : : "r"(__p)); }

/* Special registers by name, a string literal: `mrs` / `msr` of 32 or 64
 * bits, a pointer, or the bits of a float or double. */
#define __arm_rsr64(__r) \
    __extension__({ uint64_t __v; __asm__ __volatile__("mrs %0, " __r : "=r"(__v)); __v; })
#define __arm_wsr64(__r, __v) \
    __extension__({ uint64_t __w = (__v); __asm__ __volatile__("msr " __r ", %0" : : "r"(__w)); })
#define __arm_rsr(__r) ((uint32_t)__arm_rsr64(__r))
#define __arm_rsrp(__r) ((void *)__arm_rsr64(__r))
#define __arm_wsr(__r, __v) __arm_wsr64(__r, (uint32_t)(__v))
#define __arm_wsrp(__r, __v) __arm_wsr64(__r, (uint64_t)(uintptr_t)(__v))
#define __arm_rsrf(__r) \
    __extension__({ union { uint32_t __u; float __f; } __b = {(uint32_t)__arm_rsr64(__r)}; __b.__f; })
#define __arm_rsrf64(__r) \
    __extension__({ union { uint64_t __u; double __f; } __b = {__arm_rsr64(__r)}; __b.__f; })
#define __arm_wsrf(__r, __v) \
    __extension__({ union { float __f; uint32_t __u; } __b = {(__v)}; __arm_wsr64(__r, __b.__u); })
#define __arm_wsrf64(__r, __v) \
    __extension__({ union { double __f; uint64_t __u; } __b = {(__v)}; __arm_wsr64(__r, __b.__u); })

#undef __BADC_ACLE
#pragma pop_macro("__attribute__")

#endif
