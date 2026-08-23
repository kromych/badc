/* GCC <x86intrin.h> umbrella: the scalar ia32 subset (byte swaps and
** bit scans over the compiler builtins, rotates, and the rdtsc / rdpmc
** / pause instructions as inline asm) plus the SIMD family headers.
** Those carry the SSE2 / SSSE3 / SSE4.1 / AES / PCLMUL / RDRAND subset
** this build lowers; an operation outside it is absent rather than
** emulated. TODO: extend the subset to the rest of the family. */
#pragma once

#if !defined(__x86_64__) && !defined(__i386__)
#error "x86intrin.h is only available when targeting x86"
#endif

#include <immintrin.h>

static inline int __bsfd(int __x) {
    return __builtin_ctz((unsigned int)__x);
}

static inline int __bsrd(int __x) {
    return 31 - __builtin_clz((unsigned int)__x);
}

static inline int __bswapd(int __x) {
    return (int)__builtin_bswap32((unsigned int)__x);
}

#define _bit_scan_forward(x) __bsfd(x)
#define _bit_scan_reverse(x) __bsrd(x)
#define _bswap(x) __bswapd(x)

/* Rotate counts are reduced modulo the width, which is what the
** instruction does; the reduction also keeps a zero count defined. */
static inline unsigned char __rolb(unsigned char __x, int __c) {
    return (unsigned char)((__x << (__c & 7)) | (__x >> (-__c & 7)));
}

static inline unsigned char __rorb(unsigned char __x, int __c) {
    return (unsigned char)((__x >> (__c & 7)) | (__x << (-__c & 7)));
}

static inline unsigned short __rolw(unsigned short __x, int __c) {
    return (unsigned short)((__x << (__c & 15)) | (__x >> (-__c & 15)));
}

static inline unsigned short __rorw(unsigned short __x, int __c) {
    return (unsigned short)((__x >> (__c & 15)) | (__x << (-__c & 15)));
}

static inline unsigned int __rold(unsigned int __x, int __c) {
    return (__x << (__c & 31)) | (__x >> (-__c & 31));
}

static inline unsigned int __rord(unsigned int __x, int __c) {
    return (__x >> (__c & 31)) | (__x << (-__c & 31));
}

#define _rotwl(x, c) __rolw((x), (c))
#define _rotwr(x, c) __rorw((x), (c))
#define _rotl(x, c) __rold((x), (c))
#define _rotr(x, c) __rord((x), (c))

static inline unsigned long long __rdtsc(void) {
    unsigned int __lo, __hi;
    __asm__ __volatile__("rdtsc" : "=a"(__lo), "=d"(__hi));
    return ((unsigned long long)__hi << 32) | __lo;
}

static inline unsigned long long __rdtscp(unsigned int *__aux) {
    unsigned int __lo, __hi, __cx;
    __asm__ __volatile__("rdtscp" : "=a"(__lo), "=d"(__hi), "=c"(__cx));
    *__aux = __cx;
    return ((unsigned long long)__hi << 32) | __lo;
}

static inline unsigned long long __rdpmc(int __counter) {
    unsigned int __lo, __hi;
    __asm__ __volatile__("rdpmc" : "=a"(__lo), "=d"(__hi) : "c"(__counter));
    return ((unsigned long long)__hi << 32) | __lo;
}

static inline void __pause(void) {
    __asm__ __volatile__("pause");
}

#define _rdtsc() __rdtsc()
#define _rdpmc(c) __rdpmc(c)

#ifdef __x86_64__
static inline long long __bsfq(long long __x) {
    return __builtin_ctzll((unsigned long long)__x);
}

static inline long long __bsrq(long long __x) {
    return 63 - __builtin_clzll((unsigned long long)__x);
}

static inline long long __bswapq(long long __x) {
    return (long long)__builtin_bswap64((unsigned long long)__x);
}

#define _bswap64(x) __bswapq(x)

static inline unsigned long long __rolq(unsigned long long __x, int __c) {
    return (__x << (__c & 63)) | (__x >> (-__c & 63));
}

static inline unsigned long long __rorq(unsigned long long __x, int __c) {
    return (__x >> (__c & 63)) | (__x << (-__c & 63));
}

#define _lrotl(x, c) __rolq((x), (c))
#define _lrotr(x, c) __rorq((x), (c))
#else
#define _lrotl(x, c) __rold((x), (c))
#define _lrotr(x, c) __rord((x), (c))
#endif
