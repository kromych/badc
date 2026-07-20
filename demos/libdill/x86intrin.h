// x86intrin.h shim: badc's bundled headers do not carry the GCC x86
// intrinsics umbrella, and libdill's now.c only needs __rdtsc for its
// time-caching fast path. TODO(badc): drop once <x86intrin.h> ships
// with the bundled headers.

#pragma once

#if !defined(__x86_64__) && !defined(__i386__)
#error "x86intrin.h is only available when targeting x86"
#endif

static inline unsigned long long __rdtsc(void) {
    unsigned int __lo, __hi;
    __asm__ __volatile__("rdtsc" : "=a"(__lo), "=d"(__hi));
    return ((unsigned long long)__hi << 32) | __lo;
}
