// stdarg.h -- variadic-argument access for c5.
//
// `va_list` is the host platform's own representation, so a c5
// `va_list` forwarded to libc's `vfprintf` / `vsnprintf` / etc. is
// walked the same way libc walks its own. Variadic c5 functions are
// reached through the host-ABI call shape (host argument registers +
// host stack overflow), the prologue of a variadic callee spills the
// host variadic register save area, and the four intrinsics below own
// the per-target layout:
//
//   * System V AMD64 (Linux x86_64) and AAPCS64 (Linux aarch64) use the
//     documented register-save-area struct: `va_start` records the
//     general / floating-point save areas plus the overflow pointer, and
//     `va_arg` walks per the type class.
//   * macOS arm64 and Windows (both ISAs) use a single-pointer cursor
//     over the incoming stack / home area at 8-byte stride.
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

// `va_list` is opaque to user code. The four intrinsics own the
// layout, so the header advertises the platform's representation
// and the per-target codegen picks the matching behaviour.
//
//   * System V AMD64 (Linux x86_64): `va_list` is the documented
//     `__va_list_tag` (System V AMD64 ABI 3.5.7) as an array of
//     one element. The array form makes `va_list ap;` decay to a
//     `__va_list_tag *` on use, so passing a `va_list` argument
//     passes a pointer to the struct -- byte-identical to libc, so
//     `vsnprintf` / `vfprintf` take c5's `va_list` directly.
//   * AAPCS64 (Linux aarch64): `va_list` is the documented
//     `__va_list` (AAPCS64 Appendix B) as an array of one element:
//     `__stack`, `__gr_top`, `__vr_top` pointers plus the `__gr_offs`
//     / `__vr_offs` negative offsets into the general / vector
//     register save areas. The array form decays to the struct
//     pointer the intrinsics consume; the layout is byte-identical to
//     the Linux C library's, so libc `vsnprintf` / `vfprintf` take c5's `va_list`
//     directly.
//   * Every other target keeps the single-pointer cursor model:
//     `va_list` is `void *` and the intrinsics walk one region at
//     a fixed stride (Win64 / Win-arm64 8-byte home + stack,
//     macOS arm64 8-byte stack).
//
// The intrinsics receive the ADDRESS of the va_list storage as
// their first operand. With the array form `ap` already decays to
// that address; with the cursor form the address is `&(ap)`.
// `__va_list_self(ap)` hides the difference so the macros below
// are written once.
#if defined(__x86_64__) && defined(__linux__)
typedef struct {
    unsigned int gp_offset;
    unsigned int fp_offset;
    void *overflow_arg_area;
    void *reg_save_area;
} __va_list_tag;
typedef __va_list_tag va_list[1];
// `ap` is an array of one `__va_list_tag`; it decays to
// `&ap[0]`, the struct pointer the intrinsics consume.
#define __va_list_self(ap) (ap)
#elif defined(__aarch64__) && defined(__linux__)
typedef struct {
    void *__stack;
    void *__gr_top;
    void *__vr_top;
    int __gr_offs;
    int __vr_offs;
} __va_list_tag;
typedef __va_list_tag va_list[1];
// `ap` is an array of one `__va_list_tag`; it decays to
// `&ap[0]`, the struct pointer the intrinsics consume.
#define __va_list_self(ap) (ap)
#else
typedef void *va_list;
// `ap` is a single pointer-sized cursor; its address is `&ap`.
#define __va_list_self(ap) (&(ap))
#endif

// The four operations are codegen intrinsics rather than open-
// coded macros. The frontend recognises each name via
// `#pragma intrinsic(...)` and emits `Op::Intrinsic` with the
// per-target expansion picked at lowering time. The header just
// declares prototypes so c5's type checker sees a callable.
//
// `__builtin_va_arg(ap, T)` takes the va_list-storage address and
// the argument's TYPE. The frontend classifies T (floating vs
// integer/pointer) and its size and encodes a packed descriptor
// the per-target codegen uses to pick the System V gp/fp save area;
// the cursor targets ignore the descriptor and walk their single
// region. The intrinsic returns the address of the slot holding
// the next argument; the macro dereferences it as `T`.
#pragma intrinsic("__builtin_va_start")
#pragma intrinsic("__builtin_va_arg")
#pragma intrinsic("__builtin_va_end")
#pragma intrinsic("__builtin_va_copy")
void __builtin_va_start(va_list *ap, void *last_addr);
void *__builtin_va_arg(va_list *ap, ...);
void __builtin_va_end(va_list *ap);
void __builtin_va_copy(va_list *dst, va_list *src);

#define va_start(ap, last) __builtin_va_start(__va_list_self(ap), (void *)&(last))
// `__builtin_va_arg(self, T)` returns the address of the slot
// holding the next argument and advances the list. The macro
// dereferences it as `T`. On the cursor targets each value sits in
// the low bytes of an 8-byte slot so a typed dereference reads the
// right width regardless of T's size; on System V the descriptor
// routes the read to the gp or fp save area.
#define va_arg(ap, T)      (*(T *)__builtin_va_arg(__va_list_self(ap), T))
#define va_end(ap)         __builtin_va_end(__va_list_self(ap))
// C99 7.15.1.2: `va_copy(dst, src)` initialises `dst` to the
// same list position as `src`. On the cursor model this is a
// pointer assignment; on System V it is a `__va_list_tag` struct
// copy. The intrinsic picks the size from the target's layout.
#define va_copy(dst, src)  __builtin_va_copy(__va_list_self(dst), __va_list_self(src))
