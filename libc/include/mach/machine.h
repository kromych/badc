// mach/machine.h -- the Mach cpu type and subtype namespace. Values
// match the macOS SDK header of the same name. The namespace is part of
// the Mach-O file format, so the definitions are usable on any host.
//
// Only the architecture ids appear here. The host_basic_info / machine
// slot structures the SDK header also carries are reachable only through
// host_info, which badc does not bind.

#pragma once

// integer_t on Darwin, which is `int` on every architecture Apple ships.
typedef int cpu_type_t;
typedef int cpu_subtype_t;
typedef int cpu_threadtype_t;

#define CPU_STATE_MAX           4
#define CPU_STATE_USER          0
#define CPU_STATE_SYSTEM        1
#define CPU_STATE_IDLE          2
#define CPU_STATE_NICE          3

#define CPU_ARCH_MASK           0xff000000
#define CPU_ARCH_ABI64          0x01000000
#define CPU_ARCH_ABI64_32       0x02000000

#define CPU_TYPE_ANY            ((cpu_type_t) -1)
#define CPU_TYPE_VAX            ((cpu_type_t) 1)
#define CPU_TYPE_MC680x0        ((cpu_type_t) 6)
#define CPU_TYPE_X86            ((cpu_type_t) 7)
#define CPU_TYPE_I386           CPU_TYPE_X86
#define CPU_TYPE_X86_64         (CPU_TYPE_X86 | CPU_ARCH_ABI64)
#define CPU_TYPE_MC98000        ((cpu_type_t) 10)
#define CPU_TYPE_HPPA           ((cpu_type_t) 11)
#define CPU_TYPE_ARM            ((cpu_type_t) 12)
#define CPU_TYPE_ARM64          (CPU_TYPE_ARM | CPU_ARCH_ABI64)
#define CPU_TYPE_ARM64_32       (CPU_TYPE_ARM | CPU_ARCH_ABI64_32)
#define CPU_TYPE_MC88000        ((cpu_type_t) 13)
#define CPU_TYPE_SPARC          ((cpu_type_t) 14)
#define CPU_TYPE_I860           ((cpu_type_t) 15)
#define CPU_TYPE_POWERPC        ((cpu_type_t) 18)
#define CPU_TYPE_POWERPC64      (CPU_TYPE_POWERPC | CPU_ARCH_ABI64)

#define CPU_SUBTYPE_MASK        0xff000000
#define CPU_SUBTYPE_LIB64       0x80000000
#define CPU_SUBTYPE_PTRAUTH_ABI 0x80000000

#define CPU_SUBTYPE_ANY           ((cpu_subtype_t) -1)
#define CPU_SUBTYPE_MULTIPLE      ((cpu_subtype_t) -1)
#define CPU_SUBTYPE_LITTLE_ENDIAN ((cpu_subtype_t) 0)
#define CPU_SUBTYPE_BIG_ENDIAN    ((cpu_subtype_t) 1)

#define CPU_SUBTYPE_X86_ALL     ((cpu_subtype_t) 3)
#define CPU_SUBTYPE_X86_64_ALL  ((cpu_subtype_t) 3)
#define CPU_SUBTYPE_X86_ARCH1   ((cpu_subtype_t) 4)
#define CPU_SUBTYPE_X86_64_H    ((cpu_subtype_t) 8)
#define CPU_SUBTYPE_I386_ALL    CPU_SUBTYPE_X86_ALL

#define CPU_SUBTYPE_ARM_ALL     ((cpu_subtype_t) 0)
#define CPU_SUBTYPE_ARM_V4T     ((cpu_subtype_t) 5)
#define CPU_SUBTYPE_ARM_V6      ((cpu_subtype_t) 6)
#define CPU_SUBTYPE_ARM_V5TEJ   ((cpu_subtype_t) 7)
#define CPU_SUBTYPE_ARM_XSCALE  ((cpu_subtype_t) 8)
#define CPU_SUBTYPE_ARM_V7      ((cpu_subtype_t) 9)
#define CPU_SUBTYPE_ARM_V7F     ((cpu_subtype_t) 10)
#define CPU_SUBTYPE_ARM_V7S     ((cpu_subtype_t) 11)
#define CPU_SUBTYPE_ARM_V7K     ((cpu_subtype_t) 12)
#define CPU_SUBTYPE_ARM_V8      ((cpu_subtype_t) 13)
#define CPU_SUBTYPE_ARM_V6M     ((cpu_subtype_t) 14)
#define CPU_SUBTYPE_ARM_V7M     ((cpu_subtype_t) 15)
#define CPU_SUBTYPE_ARM_V7EM    ((cpu_subtype_t) 16)
#define CPU_SUBTYPE_ARM_V8M     ((cpu_subtype_t) 17)
#define CPU_SUBTYPE_ARM_V8M_BASE   ((cpu_subtype_t) 18)
#define CPU_SUBTYPE_ARM_V8_1M_MAIN ((cpu_subtype_t) 19)

#define CPU_SUBTYPE_ARM64_ALL   ((cpu_subtype_t) 0)
#define CPU_SUBTYPE_ARM64_V8    ((cpu_subtype_t) 1)
#define CPU_SUBTYPE_ARM64E      ((cpu_subtype_t) 2)
#define CPU_SUBTYPE_ARM64_32_ALL ((cpu_subtype_t) 0)
#define CPU_SUBTYPE_ARM64_32_V8  ((cpu_subtype_t) 1)

// arm64e pointer-authentication ABI version, carried in the subtype.
#define CPU_SUBTYPE_ARM64_PTR_AUTH_MASK 0x0f000000
#define CPU_SUBTYPE_ARM64_PTR_AUTH_VERSION(x) \
    (((x) & CPU_SUBTYPE_ARM64_PTR_AUTH_MASK) >> 24)
