/* MSVC <intrin.h> subset for x86-64 Windows targets: the __cpuid /
 * __cpuidex CPU-identification intrinsics over badc's cpuid inline-asm
 * form. stb_image's runtime SSE2 detection includes <intrin.h> for
 * __cpuid when _MSC_VER >= 1400. Resolved ahead of the bundled
 * <intrin.h> via -I; TUs built against this directory must not rely on
 * the bundled byte-swap surface.
 */
#ifndef BADC_INTRIN_H
#define BADC_INTRIN_H

#if defined(__x86_64__)

static inline void __cpuidex(int info[4], int leaf, int subleaf) {
    unsigned a, b, c, d;
    __asm__("cpuid" : "=a"(a), "=b"(b), "=c"(c), "=d"(d) : "a"(leaf), "c"(subleaf));
    info[0] = (int)a;
    info[1] = (int)b;
    info[2] = (int)c;
    info[3] = (int)d;
}

static inline void __cpuid(int info[4], int leaf) {
    __cpuidex(info, leaf, 0);
}

#endif /* __x86_64__ */

#endif /* BADC_INTRIN_H */
