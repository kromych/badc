// linux/types.h -- the kernel fixed-width and endian-annotated types used by
// the uapi headers (real linux/types.h pulls these from
// <asm-generic/int-ll64.h> plus the __bitwise aliases). `__bitwise` is a
// sparse-only annotation, empty in a normal build. Self-contained, matching
// the bundled linux/ shims. (__u128/__s128 carry aligned(16) and are unused
// here, so omitted.)

#pragma once

#ifdef __linux__
#ifndef __bitwise
#define __bitwise
#endif

typedef signed char __s8;
typedef unsigned char __u8;
typedef signed short __s16;
typedef unsigned short __u16;
typedef signed int __s32;
typedef unsigned int __u32;
typedef signed long long __s64;
typedef unsigned long long __u64;

typedef __u16 __bitwise __le16;
typedef __u16 __bitwise __be16;
typedef __u32 __bitwise __le32;
typedef __u32 __bitwise __be32;
typedef __u64 __bitwise __le64;
typedef __u64 __bitwise __be64;
typedef __u16 __bitwise __sum16;
typedef __u32 __bitwise __wsum;

#define __aligned_u64 __u64 __attribute__((aligned(8)))
#define __aligned_be64 __be64 __attribute__((aligned(8)))
#define __aligned_le64 __le64 __attribute__((aligned(8)))

typedef unsigned __bitwise __poll_t;

// Kernel posix types (real kernel: <asm/posix_types.h>). LP64 on every
// badc Linux target, so `long`-width fields are 64-bit here.
typedef long __kernel_long_t;
typedef unsigned long __kernel_ulong_t;
typedef __kernel_long_t __kernel_off_t;
typedef long long __kernel_loff_t;
typedef long long __kernel_time64_t;
typedef __kernel_long_t __kernel_old_time_t;
typedef __kernel_long_t __kernel_time_t;
typedef __kernel_long_t __kernel_clock_t;
typedef __kernel_long_t __kernel_suseconds_t;
typedef unsigned short __kernel_sa_family_t;
#endif
