# Gaps to C99

c5 is a deliberately small subset of C with extras for the
compiler's own use. This document only catalogs the cases
where the dialect rejects valid C99 source or accepts it but
produces a different result than the spec mandates -- "what
will surprise me when I try to compile a real codebase".

Nothing rejection-or-divergence-free is mentioned here.
Working features (`int` / `long`, signed / unsigned integers,
`signed char` / `short` / `int` / `long` widths, `union`,
bitfields, `enum`, function pointers, `typedef`, the full
preprocessor surface, struct-by-value at the c5-internal ABI,
varargs, the standard library subset documented in
`headers/include/`, and so on) all match C99 within their
declared scope.

Severity is from the perspective of porting mainstream C:
1 = blocks almost everything, 2 = blocks much real code,
3 = blocks specific idioms, 4 = workaround exists, 5 = rare
in modern source.

## Translation units (sec 6.9)

- **Multiple translation units**: `badc` compiles a single
  source file at a time. `extern int x;` in one TU and
  `int x;` in another can't be linked together. Severity: 1.

## Storage / function specifiers (sec 6.7)

- `register`, `auto` -- accepted as no-ops. Severity: 5.
- `inline`, `__inline`, `__inline__` -- accepted as no-ops;
  no inline expansion. Severity: 4.
- `_Noreturn` (C11) -- not recognised. Severity: 5.

## Type qualifiers (sec 6.7.3)

- `const`, `volatile`, `restrict` -- accepted as no-ops at
  every declaration / qualifier position. No
  const-correctness, no reordering barrier, no aliasing
  assumptions. Severity: 4.

## Integer arithmetic intermediate-value width (sec 6.3, 6.5)

- **Unsigned arithmetic propagation between ops.** A value
  held in a 64-bit register after a single op (e.g. `~u32`,
  `u32 + u32` that overflows) doesn't mask to the slot
  width until stored and reloaded through a typed lvalue.
  Code that expects bit-exact intermediate values without
  an intervening store can diverge. Round-tripping through
  a typed slot is the correctness contract today.
  Severity: 4.
- **Unsigned division / modulo** (`Op::Div` / `Op::Mod` are
  signed-only on every backend). Programs computing
  `(unsigned)x / (unsigned)y` with operands in the
  signed-negative range will diverge. Severity: 3.

## Type specifiers (sec 6.7.2)

- `_Bool` -- tokenizes; treated as `int` (full integer
  range, not 0/1 normalised). Programs that rely on `_Bool`
  storing exactly 0 or 1 diverge. Severity: 4.
- `_Complex`, `_Imaginary` -- not recognised. Severity: 5.
- `void` -- internally equivalent to `char`-typed pointers.
  `void f(void)` parses but a `void`-returning function
  still produces a value (the unused accumulator).
  Severity: 3.

## Floating-point variadic call boundary

- `1.0f` doesn't promote to `double` in variadic calls; the
  caller's stored width carries through. Severity: 3.
- AArch64 macOS variadic FP spills differ from
  Linux / x86_64; programs that pass more than a couple of
  FP variadic args may see garbage. Severity: 3.
- Hex floats (`0x1p10`) -- not parsed. Severity: 5.
- Float `++` / `--` (prefix or postfix) -- rejected.
  Severity: 5.

## Constant expressions (sec 6.6)

- Array sizes: only integer literals (with optional unary
  `-`) and identifiers bound to compile-time integer
  constants (enum values, `#define`d numeric macros).
  General arithmetic in `int xs[N + 1]` is rejected.
  Severity: 3.
- Static initializers: integer constants (with optional
  unary `-`), `&global`, function names, and string
  literals. Casts and arithmetic in initializers
  (`(int)(1.5 * 2)`, `&arr[1]`) are rejected. Severity: 3.

## Casts and compound literals

- Compound literals (`(struct Foo){.x = 1, .y = 2}`) --
  rejected. Severity: 3.
- Standalone abstract function-pointer declarators in
  `sizeof` / casts (`(int(*)(int))ptr`) -- rejected. The
  shape works inside typedef / parameter / struct-field
  declarators. Severity: 4.

## Statements (sec 6.8)

- `for ( int i = 0; ... )` (C99 for-init declaration) --
  rejected; declare in the enclosing block, then
  `for (i = 0; ...)`. Severity: 4.
- `restrict`-qualified locals -- rejected. Severity: 5.
- K&R-style identifier-list function declarators --
  rejected. Severity: 5.

## Aggregate initializers

- File-scope struct designated / positional / mixed init
  (M28b) and array brace-list / string-literal init (M28a)
  work. **Function-scope** struct designated init isn't
  yet supported. Severity: 3.
- Anonymous structs / unions inside another aggregate
  (C11 feature) -- rejected. Severity: 4.

## Pointer arithmetic and structs

- Ordered comparisons between two pointers (`p1 < p2`) --
  not exhaustively validated; equality / inequality and
  ordered-against-zero work. Severity: 4.
- libc `struct`-by-value calls (`div(...)`, `gmtime(...)`,
  ...) -- rejected at compile time. The c5-internal
  struct ABI doesn't match SysV / Win64 / AAPCS64.
  Severity: 2 for cross-format binary compatibility.
- Field access on a forward-declared opaque struct value
  (the struct has no fields to look up) -- compile error
  at the access site. Severity: 4.

## Lexical (sec 6.4)

- Universal character names (`A`) in identifiers --
  rejected. Severity: 5.
- Wide string literals (`L"..."`) -- rejected. Severity: 4.
- Digraphs / trigraphs (`<:`, `??/`) -- rejected.
  Severity: 5.
- `__func__` -- not recognised. Severity: 4.
- `__STDC_VERSION__`, `__STDC_HOSTED__` -- not predefined.
  Severity: 4.
- Header search path: `badc` ships its own
  `headers/include/` set; user `-I` paths aren't a CLI
  option. Severity: 3.

## Preprocessor (sec 6.10)

- `_Pragma(...)` operator -- rejected. Severity: 5.
- `#line` -- rejected. Severity: 5.
- GCC named-rest variadic (`#define foo(args...)`) --
  rejected; the parameter must be the literal `...`.
  Severity: 5.

## Library

- libc functions returning `int` (e.g. `strcmp`) leave only
  the low 32 bits defined per ABI; c5 reads the full 64-bit
  return register and not every libc sign-extends. Storing
  through an `int` lvalue (which truncates to 4 bytes via
  `Op::Sw` and sign-extends back via `Op::Lw`) yields the
  right value; using the call's rvalue directly may carry
  the high half from the return register's prior contents.
  Severity: 3.

## Beyond C99

These C11+ features show up in modern code but aren't in
C99 either; listed for completeness:

- `_Generic`, `_Atomic`, `_Static_assert` -- rejected.
- `_Thread_local` -- supported; init limited to scalars +
  NULL.
- Anonymous struct / union members -- rejected.

## c5-only features (not in C99)

These don't exist in C99 and shouldn't go away:

- `#pragma dylib` / `#pragma binding` / `#pragma export` --
  per-target loader-symbol-resolution and shared-library
  export.
- `#pragma once` (a near-universal extension; not in C99).
- The bytecode interpreter (`--interp`), in-process JIT
  (`--jit`), and `--dump-asm` listing.
- The `__BADC_*` predefines (`__BADC_VERSION__`,
  `__BADC_TARGET__`, `__BADC_WINDOWS__`).

## Roadmap to "compile mainstream C"

If the goal is to grow the dialect to compile arbitrary
C99 code, the gaps are roughly tiered:

1. **Multiple translation units** (sec 6.9) -- the only
   severity-1 item. Without these, library-shaped projects
   beyond a single `#include`-ed `main` aren't reachable.
2. **libc `struct`-by-value ABI** -- the c5-internal struct
   ABI works for c5-to-c5 calls; cross-ABI calls error at
   compile time today.
3. **Unsigned divide / modulo** -- `Op::Divu` / `Op::Modu`
   routed when either operand is unsigned, mirroring the
   `Op::Shr` / `Op::Shru` split.
4. **Constant-expression evaluator** -- general arithmetic
   in array sizes and static initializers.
5. **Function-scope struct designated init** -- M28b
   covered file scope; the function-scope tail follows the
   same shape.
6. **`_Bool` 0/1 normalisation** -- the lexer already
   accepts `_Bool`; the load needs a `Op::And 1` mask.
