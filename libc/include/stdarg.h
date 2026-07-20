// stdarg.h -- variadic-argument access for c5 (C99 7.15).
//
// `va_list` aliases the compiler's `__builtin_va_list`, the host
// platform's own representation, so a c5 `va_list` forwarded to
// libc's `vfprintf` / `vsnprintf` / etc. is walked the same way
// libc walks its own:
//
//   * System V AMD64 (Linux x86_64): the documented `__va_list_tag`
//     record (System V AMD64 ABI 3.5.7) as an array of one element.
//     The array form makes `va_list ap;` decay to the record pointer
//     on use, so passing a `va_list` argument passes a pointer to
//     the record -- byte-identical to libc's.
//   * AAPCS64 (Linux aarch64): the documented `__va_list` record
//     (AAPCS64 Appendix B) as an array of one element: `__stack`,
//     `__gr_top`, `__vr_top` pointers plus the `__gr_offs` /
//     `__vr_offs` negative offsets into the register save areas.
//   * Every other target: a single-pointer cursor over the incoming
//     stack / home area at 8-byte stride (Win64 / Win-arm64 home
//     area + stack, macOS arm64 stack).
//
// The four operations are compiler builtins with the GCC call
// shapes: `__builtin_va_start(ap, last)` takes the va_list and the
// rightmost fixed parameter by name, `__builtin_va_arg(ap, T)`
// yields the next argument as a value of type T, and
// `__builtin_va_end` / `__builtin_va_copy` take the va_list(s)
// directly. Each is usable with no header; the macros below are the
// C99 spellings.

#pragma once

typedef __builtin_va_list va_list;

#define va_start(ap, last) __builtin_va_start(ap, last)
#define va_arg(ap, T)      __builtin_va_arg(ap, T)
#define va_end(ap)         __builtin_va_end(ap)
#define va_copy(dst, src)  __builtin_va_copy(dst, src)
