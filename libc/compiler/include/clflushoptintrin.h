/* CLFLUSHOPT intrinsics, which <x86intrin.h> carries, under the name gcc and clang
** give their header. */
#pragma once

#if !defined(__x86_64__) && !defined(__i386__)
#error "clflushoptintrin.h is only available when targeting x86"
#endif

#include <x86intrin.h>
