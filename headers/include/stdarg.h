// stdarg.h -- variadic-argument access for c5.
//
// `va_list` is a pointer that walks the c5 stack starting just past
// the last named argument. c5's cdecl push order parks the first
// declared parameter at val=2 (`bp + 16`) and successive parameters
// at val=3, val=4, ...; the variadic tail begins at val=N+2 where N
// is the fixed-arg count.
//
// Each c5 stack slot is 16 bytes (8 bytes of value + 8 bytes of
// pad). Pointer arithmetic on `long long *` strides 8 bytes per
// `+1` on every supported target -- LP64 (Linux/macOS) and LLP64
// (Windows) both -- so "skip one 16-byte slot" is `+2`. We use
// `long long *` rather than `long *` because `long` is only 4
// bytes on Windows LLP64 and `long *` would stride 4 there,
// landing mid-slot. `int *` has the same 4-byte-stride problem
// on every target.
//
// TODO: replace this c5-specific cursor with the host's native
// `va_list` representation. That requires:
//
//   * Variadic c5 functions reached via the host-ABI call shape
//     (host arg regs + host stack overflow) instead of the
//     bare-bl + c5-stack-args path. The compiler's
//     `Symbol::is_variadic` flag plus `Program::variadic_functions`
//     already plumbs the declarator info to the codegen; today
//     the codegen still routes variadic targets through the
//     legacy c5-stack path to keep this header's macros valid.
//   * A per-host-ABI variadic register save area emitted in the
//     prologue of every variadic c5 function. AAPCS64: x0..x7
//     contiguous in the gr-save area + d0..d7 contiguous in the
//     vr-save area. SysV x86_64: rdi..r9 + xmm0..xmm7. Windows
//     (both ISAs): variadic_int_only -- save only the int arg
//     bank; FP args ride int regs as bit patterns.
//   * `va_list` becomes the platform's documented struct (or
//     `char *` on Windows). `va_start` initialises the offsets
//     and pointers to the prologue-spilled save area; `va_arg`
//     walks per the host's variadic protocol.
//
// Net effect: libc's `vfprintf` / `vsnprintf` / etc. would take
// c5's `va_list` directly, retiring the c5_v* shims in
// `<c5io.h>` and the `#define vsnprintf c5_vsnprintf` redirects
// in `<stdio.h>`.
//
// Usage:
//
//   int sum(int count, ...) {
//       va_list ap;
//       int total;
//       int i;
//       total = 0;
//       va_start(ap, count);
//       i = 0;
//       while (i < count) {
//           total = total + va_arg(ap, int);
//           i = i + 1;
//       }
//       va_end(ap);
//       return total;
//   }
//
// `va_arg(ap, T)` advances `ap` by one slot and yields the slot it
// just stepped over, cast to `T`. The expansion uses the c5 dialect's
// comma operator, so the advance-and-read happens in a single
// expression.

#pragma once

// `va_list` is opaque to user code. The four intrinsics below
// own the layout, so the header advertises `void *` and lets the
// per-target codegen pick the representation. Today's cursor
// model uses one pointer's worth of storage; the per-host-ABI
// variants (AAPCS64 / SysV gr/vr structs) will keep `va_list`
// pointer-sized only when the underlying region is a single
// cursor and otherwise widen the typedef to match the platform.
typedef void *va_list;

// The four operations are codegen intrinsics rather than open-
// coded macros. The frontend recognises each name via
// `#pragma intrinsic(...)` and emits `Op::Intrinsic` with the
// per-target expansion picked at lowering time. The header just
// declares prototypes so c5's type checker sees a callable.
#pragma intrinsic("__builtin_va_start")
#pragma intrinsic("__builtin_va_arg")
#pragma intrinsic("__builtin_va_end")
#pragma intrinsic("__builtin_va_copy")
void __builtin_va_start(va_list *ap, void *last_addr);
void *__builtin_va_arg(va_list *ap);
void __builtin_va_end(va_list *ap);
void __builtin_va_copy(va_list *dst, va_list *src);

#define va_start(ap, last) __builtin_va_start(&(ap), (void *)&(last))
// `__builtin_va_arg(&ap)` returns the address of the just-vacated
// 8-byte slot and advances the cursor by one slot. The macro
// dereferences as the requested type; on every supported target
// the c5 stack stores each value in the low bytes of an 8-byte
// (or larger) slot so a typed dereference reads the right
// width regardless of T's size.
#define va_arg(ap, T)      (*(T *)__builtin_va_arg(&(ap)))
#define va_end(ap)         __builtin_va_end(&(ap))
// C99 7.15.1.2: `va_copy(dst, src)` initialises `dst` to the
// same list position as `src`. On the cursor model this is just
// pointer assignment; the intrinsic gives per-target code a
// hook for struct-shaped `va_list` layouts.
#define va_copy(dst, src)  __builtin_va_copy(&(dst), &(src))
