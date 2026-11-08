/* SSE4.2 intrinsics, which <smmintrin.h> carries as gcc's does. */
#pragma once

#if !defined(__x86_64__) && !defined(__i386__)
#error "nmmintrin.h is only available when targeting x86"
#endif

#include <smmintrin.h>
