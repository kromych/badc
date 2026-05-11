// alloca.h -- variable-size stack allocation.
//
// Real `alloca` allocates on the *caller's* stack frame. c5's
// native codegen uses a single unified stack pointer for both
// pushed-arg slots (`Op::Psh`) and function locals, so bumping
// SP from inside an expression (between a `Psh` and the matching
// `Si`) would shift the c5 push slots out from under the
// later pop and corrupt the assignment shape. Until the codegen
// grows a separate "c5 push" register so an `Op::Intrinsic
// <Alloca>` can safely subtract from SP between an `Lea/Psh`
// and the matching `Si`, the header exposes `alloca` as a
// preprocessor macro that funnels through `malloc`. The memory
// leaks per call (no per-function release), which is bounded
// for the smoke's stb_vorbis path and a deliberate choice over
// silently mis-compiling the SP-bump shape.
//
// Both `alloca` and the gcc / clang spelling `__builtin_alloca`
// are tagged via `#pragma intrinsic("name")` so the
// `Op::Intrinsic` / `Intrinsic::Alloca` plumbing is exercised
// (and ready for atomics / cpuid / vector builtins that don't
// touch SP). The macro substitution happens at preprocessor
// time, so today the parser never actually sees the alloca
// identifier; once the codegen is ready to lower
// `Op::Intrinsic(Alloca)` in place, removing the `#define`s
// flips on real alloca semantics.

#pragma once

#include <stddef.h>
#include <stdlib.h>

#define alloca(n)            ((void *)0)
#define __builtin_alloca(n)  ((void *)0)
