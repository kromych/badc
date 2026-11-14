/* MSVC's name for the NEON intrinsics on arm64, which its <intrin.h>
** includes: the compiler's own <arm_neon.h>, whose vector types are the
** Arm C Language Extensions' distinct types, as with clang. MSVC's
** `__n64` and `__n128` unions, with their `n64_*` / `n128_*` members, are
** storage here; the intrinsics take the vector types, so a value moves
** between the two through a member or memory. */
#pragma once

#include <arm_neon.h>

typedef union __attribute__((aligned(8))) __n64 {
    unsigned long long n64_u64[1];
    unsigned int n64_u32[2];
    unsigned short n64_u16[4];
    unsigned char n64_u8[8];
    long long n64_i64[1];
    int n64_i32[2];
    short n64_i16[4];
    signed char n64_i8[8];
    float n64_f32[2];
    double n64_f64[1];
} __n64;

typedef union __attribute__((aligned(16))) __n128 {
    unsigned long long n128_u64[2];
    unsigned int n128_u32[4];
    unsigned short n128_u16[8];
    unsigned char n128_u8[16];
    long long n128_i64[2];
    int n128_i32[4];
    short n128_i16[8];
    signed char n128_i8[16];
    float n128_f32[4];
    double n128_f64[2];
} __n128;
