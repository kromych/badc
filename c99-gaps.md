# C99 conformance

c5 implements most of C99 verbatim. This document lists the
divergences and impl-defined choices a C99 program is likely
to hit. Anything not listed matches C99.

Severity scale (for compiling the C code out there):
1 = blocks almost everything, 2 = blocks much real code,
3 = blocks specific idioms, 4 = workaround exists, 5 = rare
in modern source.

## What works (not exhaustive)

Full preprocessor (incl. `#if` arithmetic, function-like
macros, stringification, token paste, varargs `__VA_ARGS__`,
`#pragma once`); the integer + float arithmetic surface with
C99 6.3.1.8 usual-arithmetic-conversions and 6.3.1.1 integer
promotions; signed and unsigned `char` / `short` / `int` /
`long` / `long long`; pointers, arrays, multi-dim arrays,
function pointers and chains thereof; `struct` / `union` /
`enum` / `typedef`, bitfields, `#pragma pack(N)`, anonymous
struct/union members; `static` / `extern` / `_Thread_local`;
varargs at the c5-internal calling convention; switch with
`case` / `default` / fall-through; full set of compound
assignment and increment/decrement operators; pointer
arithmetic, ordered pointer compares (against zero and
exhaustive equality); the `<stdio.h>` / `<stdlib.h>` /
`<string.h>` / `<math.h>` / `<time.h>` / `<dlfcn.h>` /
`<pthread.h>` / `<windows.h>` surfaces documented in
`headers/include/`.

The integer-arithmetic surface is C99-correct end-to-end:
unsigned wrap-modulo-2^N, signed-overflow truncate-and-sign-
extend (matching clang/gcc), unsigned divide / modulo,
mixed signed/unsigned through the C99 common type, and
zero-extending vs sign-extending loads for unsigned and
signed narrow types. See `tests/fixtures/c/integer_boundary_c99.c`,
`tests/fixtures/c/c99_arith_common_width.c`, and
`tests/fixtures/c/zero_sign_extension_32bit.c` for the regression
markers.

## Impl-defined choices (sec 6.2.5, 6.7.2)

| type             | macOS / Linux | Windows |
|------------------|---------------|---------|
| `char`           | 1             | 1       |
| `short`          | 2             | 2       |
| `int`            | 4             | 4       |
| `long`           | 8             | 4       |
| `long long`      | 8             | 8       |
| pointer / `T *`  | 8             | 8       |
| `float`          | 8 (stored as `double`) | 8 (stored as `double`) |
| `double`         | 8             | 8       |

LP64 on macOS / Linux, LLP64 on Windows -- both match the
host platform ABI.

**Bare `char` is unsigned** on every target (1-byte zero-
extending load). gcc and clang differ on this per host
architecture; portable code that walks bytes by sign already
spells `signed char` explicitly. `signed char` is recognised
as a distinct type and integer-promotes to signed `int` for
arithmetic. Severity: 4.

**`float` storage** is 8 bytes (alias of `double`). Within
c5-to-c5 arithmetic this is C99-conforming (the spec permits
`float` to be an alias for `double`); at the variadic-call
boundary the host ABI's `float -> double` default-argument
promotion may diverge. Severity: 3.

## Divergences

### Translation units (sec 6.9), severity 1

`badc` compiles a single source file at a time. `extern int
x;` in one TU and `int x;` in another can't be linked.

### libc `struct`-by-value ABI, severity 2

`div(...)`, `gmtime(...)`, and other libc functions that
take or return a struct by value are rejected at compile
time. The c5-internal struct ABI doesn't match SysV / Win64
/ AAPCS64.

### Floating-point variadic boundary, severity 3

AArch64 macOS variadic FP spills differ from Linux / x86_64;
programs that pass more than a couple of FP variadic args
may see garbage.

### libc `int`-returning calls used as register-resident
rvalue, severity 3

`strcmp`, `atoi`, etc. leave only the low 32 bits defined
per ABI; not every libc sign-extends. Storing through an
`int` lvalue truncates and sign-extends correctly; using the
rvalue directly without a typed slot may carry the host's
high-half garbage.

### `_Bool` 0/1 normalisation, severity 4

`_Bool` tokenizes and stores; loads don't mask to 0/1.

### `void`-returning function still produces a value, severity 3

The unused accumulator. Doesn't break valid C99 -- just
means a `void` callee can be (mis)read by a caller that
ignores its prototype.

### Constant expressions, severity 3

Array sizes and static initializers accept integer literals
(with optional unary `-`), `&global`, function names, string
literals, and identifiers bound to compile-time integer
constants (`enum` values, `#define`d numeric macros).
General arithmetic in `int xs[N + 1]` or `(int)(1.5 * 2)`
is rejected.

### Compound literals (`(struct Foo){.x=1}`), severity 3

Rejected.

### Standalone abstract function-pointer declarators, severity 4

`(int(*)(int))ptr` in `sizeof` / cast position is rejected.
Works inside typedef / parameter / struct-field declarators.

### `for (int i = 0; ...)` C99 for-init declaration, severity 4

Rejected; hoist the declaration.

### Function-scope struct designated init, severity 3

File-scope works; function-scope is rejected.

### Field access on opaque forward-declared struct, severity 4

Compile error at the access site (the struct has no fields
to look up).

### Wide string literals (`L"..."`), severity 4

Rejected.

## Rejected modern features (rare in C99 source)

`register` / `auto` are accepted as no-ops. `inline` /
`__inline` / `__inline__` are accepted but don't expand.
`const` / `volatile` / `restrict` are accepted as no-ops at
every position. `_Noreturn`, `_Complex`, `_Imaginary`,
`_Pragma`, `#line`, `__func__`, `__STDC_VERSION__`,
`__STDC_HOSTED__`, hex floats (`0x1p10`), float `++`/`--`,
universal character names, digraphs / trigraphs, K&R
identifier-list function declarators, GCC named-rest
variadic (`#define foo(args...)`) -- all rejected (or, for
the no-op qualifier set, silently dropped). Severity 4-5.

## Beyond C99

C11+ features showing up in modern code:

- `_Generic`, `_Atomic`, `_Static_assert` -- rejected.
- `_Thread_local` -- supported; init limited to scalars +
  NULL.
- Anonymous struct / union members -- supported
  (C11 6.7.2.1p13).

## c5-only extensions

- `#pragma dylib` / `#pragma binding` / `#pragma export` --
  per-target loader symbol resolution and shared-library
  export.
- `#pragma once`.
- `--interp` (bytecode VM with pointer tracking),
  `--jit` (in-process), `--dump-asm`.
- `__BADC_VERSION__`, `__BADC_TARGET__`, `__BADC_WINDOWS__`.

## Roadmap

1. Multiple translation units (sec 6.9).
2. libc `struct`-by-value ABI bridge.
3. Constant-expression evaluator (general arithmetic in array sizes / static initializers).
4. Function-scope struct designated init.
5. `_Bool` 0/1 normalisation.
6. Real IEEE-754 single-precision `float` (`double` is used behind the curtains).
