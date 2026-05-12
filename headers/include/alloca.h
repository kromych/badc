// alloca.h -- variable-size stack allocation.
//
// `alloca(n)` carves `n` bytes out of the current function's
// frame and returns a pointer. The memory is reclaimed when the
// function returns; no per-call `free` is needed.
//
// c5 lowers it via `Op::Intrinsic(Alloca)`: every function that
// uses alloca reserves a fixed-size per-frame arena at `Op::Ent`
// time (the compiler patches Ent's local count on first
// `Op::Intrinsic(Alloca)` emit), and the intrinsic decrements an
// FP-resident "alloca-top" pointer per call. The unified-SP
// stack-discipline conflict that would arise from a runtime
// `sub sp, n` is sidestepped entirely -- SP doesn't move, so
// outstanding `Op::Psh` values stay where they are.
//
// Both `alloca` and the gcc / clang spelling `__builtin_alloca`
// are tagged via `#pragma intrinsic`; call-site lowering then
// emits `Op::Intrinsic <Alloca>` instead of a regular call. The
// declarations below give the compiler a one-arg `size_t -> void *`
// signature so the call-site type-checker fires the usual
// conversion path for non-`size_t` arguments.

#pragma once

#include <stddef.h>

#pragma intrinsic("alloca")
#pragma intrinsic("__builtin_alloca")

extern void *alloca(size_t size);
extern void *__builtin_alloca(size_t size);
