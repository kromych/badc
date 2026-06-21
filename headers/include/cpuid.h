#pragma once
// Minimal <cpuid.h>. The Windows interpreter build compiles no SIMD
// variants, so runtime feature detection reports no extensions and the
// scalar implementations are selected. TODO: emit CPUID directly when
// SIMD variants are built for this target.

#define __cpuid_count(level, count, a, b, c, d)                                \
    do {                                                                       \
        (a) = (b) = (c) = (d) = 0;                                             \
    } while (0)
#define __cpuid(level, a, b, c, d) __cpuid_count((level), 0, (a), (b), (c), (d))
#define __get_cpuid_max(ext, sig) 0
