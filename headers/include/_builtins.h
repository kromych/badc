// GCC `__builtin_*` macro thunks.
//
// Defining `__GNUC__` makes code reach for the GCC builtins. Two
// families are handled here as macros rather than in the compiler:
//
//   * The standard-library functions GCC also exposes under a
//     `__builtin_` prefix. Each is equivalent to the library function,
//     so the thunk forwards to it; the library name then resolves
//     through its own header (auto-included on demand).
//   * Hints with no code-generation effect: the value of
//     `__builtin_expect` is its first operand, `__builtin_constant_p`
//     conservatively reports "not a constant", and `__builtin_prefetch`
//     is discarded.
//
// The genuine code-generation builtins (`__builtin_clz`, the byte-swap
// and overflow family, `__builtin_alloca`, `__builtin_va_*`, the
// floating-point and trap builtins) are handled by the compiler, not
// here. This header is auto-included when a `__builtin_*` name that is
// not such an intrinsic is first used.

#pragma once

#define __builtin_expect(exp, c) (exp)
#define __builtin_constant_p(x) 0
#define __builtin_prefetch(...) ((void) 0)
#define __builtin_assume_aligned(p, ...) (p)

#define __builtin_memcpy memcpy
#define __builtin_memmove memmove
#define __builtin_memset memset
#define __builtin_memcmp memcmp
#define __builtin_memchr memchr
#define __builtin_strcpy strcpy
#define __builtin_strncpy strncpy
#define __builtin_strcat strcat
#define __builtin_strncat strncat
#define __builtin_strcmp strcmp
#define __builtin_strncmp strncmp
#define __builtin_strlen strlen
#define __builtin_strchr strchr
#define __builtin_strrchr strrchr
#define __builtin_strstr strstr
#define __builtin_strpbrk strpbrk
#define __builtin_strspn strspn
#define __builtin_strcspn strcspn
#define __builtin_abort abort
#define __builtin_abs abs
#define __builtin_labs labs
#define __builtin_llabs llabs
#define __builtin_malloc malloc
#define __builtin_calloc calloc
#define __builtin_realloc realloc
#define __builtin_free free
