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
`long` / `long long`; `void`-returning functions (with the
6.8.6.4p1 constraint on `return <expr>;` diagnosed and
6.8.6.4p3 "no value" enforced); IEEE 754 single-precision
`float` (4-byte storage) and double-precision `double`
(8-byte); pointers, arrays, multi-dim arrays, function
pointers and chains thereof; `struct` / `union` / `enum` /
`typedef`, bitfields, `#pragma pack(N)`, anonymous
struct/union members; struct designated initializers
(`{.x = 1}`) at file and function scope, including
non-constant runtime values; array designated initializers
(`[N] = ...`); `static` / `extern` / `_Thread_local`;
varargs at the c5-internal calling convention; the C99
for-init declaration (`for (int i = 0; ...; ...)`); switch
with `case` / `default` / fall-through; full set of compound
assignment and increment/decrement operators; pointer
arithmetic, ordered pointer compares (against zero and
exhaustive equality); the full C99 6.6 constant-expression
grammar with FP folding (`int xs[(int)(1.5 * 2.0)];`,
arithmetic / comparisons / conditional / sizeof / bitwise /
logical operators) in array sizes, bitfield widths, enum
initializers, `_Static_assert`, and scalar global integer
initializers; the `<stdio.h>` / `<stdlib.h>` / `<string.h>`
/ `<math.h>` / `<time.h>` / `<dlfcn.h>` / `<pthread.h>` /
`<windows.h>` surfaces documented in `headers/include/`;
multi-source compile + link (`badc -c foo.c bar.c` followed
by `badc -o app foo.o bar.o`, plus `--ar` for archives and
`-L<dir>` / `-l<name>` for archive resolution); binary
integer literals (`0b...` / `0B...`, C23 / GCC extension)
with the same suffix-letter handling as hex and decimal
constants.

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
| `float`          | 4             | 4       |
| `double`         | 8             | 8       |

LP64 on macOS / Linux, LLP64 on Windows -- both match the
host platform ABI. `float` is real IEEE 754 single-precision
storage (4 bytes); the c5 arithmetic pipeline still carries
f64 bits in the accumulator and narrows / widens at the
load / store boundary.

**Bare `char` is unsigned** on every target (1-byte zero-
extending load). gcc and clang differ on this per host
architecture; portable code that walks bytes by sign already
spells `signed char` explicitly. `signed char` is recognised
as a distinct type and integer-promotes to signed `int` for
arithmetic. Severity: 4.

## Divergences

### libc `struct`-by-value ABI, severity 2

`div(...)`, `gmtime(...)`, and other libc functions that
take or return a struct by value are rejected at compile
time. The c5-internal struct ABI doesn't match SysV / Win64
/ AAPCS64.

### Floating-point variadic boundary, severity 3

AArch64 macOS variadic FP spills differ from Linux / x86_64;
programs that pass more than a couple of FP variadic args
may see garbage. The `objc_msgSend` shape in
`demos/gui_hello/hello_macos.c` works around this by binding
separate non-variadic prototypes per selector signature
(`objc_msgSend_rect`, `objc_msgSend_b`, `objc_msgSend_p`)
that route through the standard AAPCS64 register-passing
path.

### libc `int`-returning calls used as register-resident rvalue, severity 3

`strcmp`, `atoi`, etc. leave only the low 32 bits defined
per ABI; not every libc sign-extends. Storing through an
`int` lvalue truncates and sign-extends correctly; using the
rvalue directly without a typed slot may carry the host's
high-half garbage.

### `_Bool` 0/1 normalisation, severity 4

`_Bool` tokenizes and stores; loads don't mask to 0/1.

### Compound literals (`(struct Foo){.x=1}`), severity 3

Supported at file scope (C99 6.5.2.5p5, static storage
duration): `Type *p = &(T){...};` and the empty form
`Scope *s = &(T){};` synthesize an anonymous internal-linkage
symbol of the named struct type and patch the surrounding `&`
reloc to point at it. Block-scope compound literals
(`f(&(struct Pt){1, 2})`, automatic storage duration with
lifetime equal to the enclosing block) are still rejected.

### Standalone abstract function-pointer declarators, severity 4

`(int(*)(int))ptr` in `sizeof` / cast position is rejected.
Works inside typedef / parameter / struct-field declarators.

### Field access on opaque forward-declared struct, severity 4

Compile error at the access site (the struct has no fields
to look up).

### Wide string literals (`L"..."`), severity 4

Rejected.

## Rejected modern features (rare in C99 source)

`register` / `auto` are accepted as no-ops. `inline` /
`__inline` / `__inline__` are accepted but don't expand.
`const` / `volatile` / `restrict` are accepted as no-ops at
every position. `#line` is supported -- both the C99
`#line N "file"` form and the GNU `# N "file"` shape route
through the same lexer hook. `_Noreturn`, `_Complex`,
`_Imaginary`, `_Pragma`, `__func__`, `__STDC_VERSION__`,
`__STDC_HOSTED__`, hex floats (`0x1p10`), float `++`/`--`,
universal character names, digraphs / trigraphs, K&R
identifier-list function declarators, GCC named-rest
variadic (`#define foo(args...)`) -- all rejected (or, for
the no-op qualifier set, silently dropped). Severity 4-5.

## Beyond C99

C11+ features showing up in modern code:

- `_Generic`, `_Atomic` -- rejected.
- `_Static_assert` (and the C23 `static_assert` alias) --
  supported at file and block scope; the const-expression
  operand flows through the full C99 6.6 grammar so float
  casts and arithmetic work in the condition.
- `_Thread_local` -- supported; init limited to scalars +
  NULL.
- Anonymous struct / union members -- supported
  (C11 6.7.2.1p13).

## c5-only extensions

- `#pragma dylib` / `#pragma binding` / `#pragma export` --
  per-target loader symbol resolution and shared-library
  export.
- `#pragma entrypoint(<name>)` -- override the default `main`
  entry point. Used for `WinMain` (Win32 GUI) or any
  custom non-`main` entry. (gh #55.)
- `#pragma subsystem(console | windows)` -- pick the Windows
  PE optional-header `Subsystem` field. Quietly ignored on
  non-PE targets so the same source builds for every OS.
  (gh #32.)
- `#pragma once`.
- `--interp` (bytecode VM with pointer tracking),
  `--jit` (in-process), `--dump-asm`.
- `-H` / `--show-includes` -- gcc-`-H`-shape `#include`
  resolution trace on stderr. Missing headers print as
  `! name (missing)`.
- Missing `#include` files and unknown preprocessor
  directives produce a *warning* rather than a fatal error,
  so legacy sources sprinkled with `#include <fcntl.h>` for
  documentation keep compiling. clang / gcc treat both as
  fatal; c5 chooses the permissive shape.
- `__BADC_VERSION__`, `__BADC_TARGET__`, `__BADC_WINDOWS__`.

## Roadmap

1. libc `struct`-by-value ABI bridge.
2. `_Bool` 0/1 normalisation.
3. Block-scope compound literals (`f(&(struct Pt){1, 2})`).
4. Standalone abstract function-pointer declarators in `sizeof` / cast position.
