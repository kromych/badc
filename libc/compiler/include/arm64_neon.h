/* MSVC's name for the NEON intrinsics on arm64, which its <intrin.h>
** includes: the compiler's own <arm_neon.h>, whose vector types are the
** Arm C Language Extensions' distinct types, as with clang. MSVC's
** `__n64` / `__n128` unions and their `n64_*` / `n128_*` members are not
** provided. */
#pragma once

#include <arm_neon.h>
