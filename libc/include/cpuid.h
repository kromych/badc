#pragma once
// Minimal <cpuid.h>. The scalar-only builds compile no SIMD variants, so the
// query macros report no extensions and callers select the scalar paths. The
// feature-bit constants below match the GCC header so code that tests them
// against a cpuid result compiles unchanged. TODO: emit CPUID directly when
// SIMD variants are built for this target.

#define __cpuid_count(level, count, a, b, c, d)                                \
    do {                                                                       \
        (a) = (b) = (c) = (d) = 0;                                             \
    } while (0)
#define __cpuid(level, a, b, c, d) __cpuid_count((level), 0, (a), (b), (c), (d))
#define __get_cpuid_max(ext, sig) 0

// Leaf-checked queries. Bit 31 of the leaf selects the extended range, so the
// maximum comes from leaf 0x80000000 rather than leaf 0. A zero maximum means
// the range is unavailable and no leaf in it can be read, which is what the
// macros above report. The checks go through __get_cpuid_max, so they follow it
// if it starts returning a real maximum.

static inline int __get_cpuid(unsigned int __leaf, unsigned int *__eax,
                              unsigned int *__ebx, unsigned int *__ecx,
                              unsigned int *__edx) {
    unsigned int __max = __get_cpuid_max(__leaf & 0x80000000, 0);

    if (__max == 0 || __max < __leaf) {
        return 0;
    }
    __cpuid(__leaf, *__eax, *__ebx, *__ecx, *__edx);
    return 1;
}

static inline int __get_cpuid_count(unsigned int __leaf, unsigned int __subleaf,
                                    unsigned int *__eax, unsigned int *__ebx,
                                    unsigned int *__ecx, unsigned int *__edx) {
    unsigned int __max = __get_cpuid_max(__leaf & 0x80000000, 0);

    if (__max == 0 || __max < __leaf) {
        return 0;
    }
    __cpuid_count(__leaf, __subleaf, *__eax, *__ebx, *__ecx, *__edx);
    return 1;
}

// Leaf 1, %ecx.
#define bit_SSE3        (1 << 0)
#define bit_PCLMUL      (1 << 1)
#define bit_LZCNT       (1 << 5)
#define bit_SSSE3       (1 << 9)
#define bit_FMA         (1 << 12)
#define bit_CMPXCHG16B  (1 << 13)
#define bit_SSE4_1      (1 << 19)
#define bit_SSE4_2      (1 << 20)
#define bit_MOVBE       (1 << 22)
#define bit_POPCNT      (1 << 23)
#define bit_AES         (1 << 25)
#define bit_XSAVE       (1 << 26)
#define bit_OSXSAVE     (1 << 27)
#define bit_AVX         (1 << 28)
#define bit_F16C        (1 << 29)
#define bit_RDRND       (1 << 30)

// Leaf 1, %edx.
#define bit_CMPXCHG8B   (1 << 8)
#define bit_CMOV        (1 << 15)
#define bit_MMX         (1 << 23)
#define bit_FXSAVE      (1 << 24)
#define bit_SSE         (1 << 25)
#define bit_SSE2        (1 << 26)

// Extended features, leaf 0x80000001, %ecx / %edx.
#define bit_LAHF_LM     (1 << 0)
#define bit_ABM         (1 << 5)
#define bit_SSE4a       (1 << 6)
#define bit_PRFCHW      (1 << 8)
#define bit_XOP         (1 << 11)
#define bit_LWP         (1 << 15)
#define bit_FMA4        (1 << 16)
#define bit_TBM         (1 << 21)
#define bit_MWAITX      (1 << 29)
#define bit_MMXEXT      (1 << 22)
#define bit_LM          (1 << 29)
#define bit_3DNOWP      (1 << 30)
#define bit_3DNOW       (1u << 31)

// Structured extended features, leaf 7 %ecx==0, %ebx.
#define bit_FSGSBASE    (1 << 0)
#define bit_SGX         (1 << 2)
#define bit_BMI         (1 << 3)
#define bit_HLE         (1 << 4)
#define bit_AVX2        (1 << 5)
#define bit_SMEP        (1 << 7)
#define bit_BMI2        (1 << 8)
#define bit_RTM         (1 << 11)
#define bit_MPX         (1 << 14)
#define bit_AVX512F     (1 << 16)
#define bit_AVX512DQ    (1 << 17)
#define bit_RDSEED      (1 << 18)
#define bit_ADX         (1 << 19)
#define bit_AVX512IFMA  (1 << 21)
#define bit_CLFLUSHOPT  (1 << 23)
#define bit_CLWB        (1 << 24)
#define bit_AVX512PF    (1 << 26)
#define bit_AVX512ER    (1 << 27)
#define bit_AVX512CD    (1 << 28)
#define bit_SHA         (1 << 29)
#define bit_AVX512BW    (1 << 30)
#define bit_AVX512VL    (1u << 31)

// Structured extended features, leaf 7 %ecx==0, %ecx.
#define bit_AVX512VBMI  (1 << 1)
#define bit_PKU         (1 << 3)
#define bit_OSPKE       (1 << 4)
#define bit_AVX512VBMI2 (1 << 6)
#define bit_GFNI        (1 << 8)
#define bit_VAES        (1 << 9)
#define bit_VPCLMULQDQ  (1 << 10)
#define bit_AVX512VNNI  (1 << 11)
#define bit_AVX512BITALG (1 << 12)
#define bit_AVX512VPOPCNTDQ (1 << 14)
#define bit_RDPID       (1 << 22)
