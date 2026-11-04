// alloca.h -- variable-size stack allocation.
//
// `alloca(n)` allocates `n` bytes in the calling function's frame, which
// the function's return releases. A call is the macro over
// `__builtin_alloca`, as glibc's and the macOS SDK's headers define it, so
// the allocation stays inline under `-fno-builtin`. The declaration, bound
// to the same intrinsic, is the one the auto-include recovery finds for a
// unit that calls `alloca` without the header.

#pragma once

#include <stddef.h>

#pragma intrinsic("alloca")
extern void *alloca(size_t size);
#define alloca(size) __builtin_alloca(size)
