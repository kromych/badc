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

## Data-model picks (sec 6.2.5)

c5 follows the host platform's data model -- LP64 on
Linux + macOS, LLP64 on Windows:

| type             | macOS / Linux | Windows |
|------------------|---------------|---------|
| `char`           | 1             | 1       |
| `short`          | 2             | 2       |
| `int`            | 4             | 4       |
| `long`           | 8             | 4       |
| `long long`      | 8             | 8       |
| pointer / `T *`  | 8             | 8       |
| `float`          | 8 (stored as double) | 8 (stored as double) |
| `double`         | 8             | 8       |

The `long` width is the only per-target divergence. The
codegen drives `Op::Lw` / `Op::Sw` (4-byte) for `long`
on Windows targets and `Op::Lwq` / `Op::Sq` (8-byte)
elsewhere. `long long` is always 8 bytes.

Implications:
- On macOS + Linux + Windows this matches the platform
  ABI, so c5 structs line up with libc's `long`-typed
  fields and `time_t` / `off_t` / `size_t` round-trip
  cleanly across each target.
- The historical 32-bit (`ILP32`) and 16-bit
  (`I16LP32`) data models are not supported -- pointers
  are 8 bytes everywhere.
- `float` is currently stored as `double` (8 bytes); the
  IEEE-754 single-precision narrowing is future work.

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

c5 keeps every integer value sign- or zero-extended in the
64-bit accumulator. After Add / Sub / Mul / Div / Mod, the
result is the raw 64-bit operation; the C99-mandated wrap-
to-common-type-width happens only when the value lands in
a typed storage slot (via `Op::Sw` for int, `Op::Sh` for
short, etc.). That covers the common case but diverges from
clang / gcc when:

- `(uint)0xFFFFFFFF + 1` is consumed without going through
  a typed slot (e.g. immediately cast to `long long` or
  passed to a wider variadic argument). C99 mandates 0
  (wrap modulo 2^32); c5 leaves 0x100000000 in the
  register. The both-unsigned-narrow case is masked
  correctly today; mixed signed/unsigned (`u + 1` where
  `1` is a bare int literal) is not. See
  `fixtures/c/deferred_c99_arith_common_width.c`.
- `(int x) * (int y)` overflows int -- C99 calls this UB,
  but clang / gcc consistently truncate-and-sign-extend to
  int width. c5 keeps the wider 64-bit product. See the
  same fixture, exit code 5.
- Bitwise / shift / unary `~` on `unsigned int`: the
  result keeps the high half of the 64-bit register
  rather than masking to 32 bits. `(~u32) & 0xFFFFFFFF`
  is correct; `~u32` on its own carries the upper half.
  See `fixtures/c/deferred_unsigned_arith_high_half.c`.

Severity: 3 for code that bypasses typed storage; 4 for
the common pattern where every result lands in a typed
variable.

- **Unsigned division / modulo** (`Op::Div` / `Op::Mod` are
  signed-only on every backend). Programs computing
  `(unsigned)x / (unsigned)y` with operands in the
  signed-negative range will diverge. Severity: 3.

- **Mixed signed / unsigned promotion to the common type.**
  Compares (`<`, `>`, `<=`, `>=`) and equality (`==`, `!=`)
  now route through the C99 6.3.1.8 common type, so
  `(long)-1 < (uint)1` returns true (signed common) and
  `(int)-1 == (uint)0xFFFFFFFF` returns true (unsigned
  common at narrow width via XOR-mask). Arithmetic still
  doesn't fully promote -- mixed `int + uint` keeps the
  signed-extended high half until the result hits a typed
  slot (see the bullet above).

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
  and array brace-list / string-literal init work.
  **Function-scope** struct designated init isn't yet
  supported. Severity: 3.

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
- Anonymous struct / union members -- supported (C11 6.7.2.1p13).

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
