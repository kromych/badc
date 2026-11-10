// asm/types.h -- the kernel's fixed-width integer types (uapi
// <asm-generic/int-ll64.h>, which every Linux architecture uses).

#pragma once

#ifdef __linux__
typedef signed char __s8;
typedef unsigned char __u8;
typedef signed short __s16;
typedef unsigned short __u16;
typedef signed int __s32;
typedef unsigned int __u32;
typedef signed long long __s64;
typedef unsigned long long __u64;
#endif
