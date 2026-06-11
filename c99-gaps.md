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
`#pragma once`); standard predefines `__STDC__`, `__DATE__`,
`__TIME__`, `__FILE__`, `__LINE__` per C99 6.10.8 plus the
GCC / MSVC `__COUNTER__` and `__func__` / `__FUNCTION__` /
`__PRETTY_FUNCTION__` (C99 6.4.2.2) extensions;
MSVC-shape `#pragma warning(push)` / `#pragma warning(pop)`
/ `#pragma warning(disable : N)`; the integer + float
arithmetic surface with C99 6.3.1.8 usual-arithmetic-
conversions and 6.3.1.1 integer promotions; integer literal
`u` / `U` / `l` / `L` / `ll` / `LL` suffixes per C99 6.4.4.1
drive longness + signedness in decimal, hex, octal, and
binary constants; signed and unsigned `char` / `short` /
`int` / `long` / `long long`; `_Bool` as a distinct one-byte
type that normalises any scalar to 0 / 1 on every conversion
(assignment, cast, initialiser, argument, return) per C99
6.3.1.2; `void`-returning functions
(with the 6.8.6.4p1 constraint on `return <expr>;` diagnosed
and 6.8.6.4p3 "no value" enforced); IEEE 754 single-
precision `float` (4-byte storage) and double-precision
`double` (8-byte); decimal and C99 6.4.4.2 hexadecimal
(`0x1.8p3`) floating constants; wide string / character
literals (`L"..."` / `L'...'`, UTF-16 storage); pointers, arrays, multi-dim arrays,
function pointers and chains thereof; `struct` / `union` /
`enum` / `typedef`, bitfields (signed and unsigned, sign-
extending read per C99 6.7.2.1p4, adjacent same-base-type
fields sharing a storage unit of `sizeof(base_type)` per
C99 6.7.2.1p11), `#pragma pack(N)`, anonymous struct / union
members; struct designated initializers (`{.x = 1}`) at file
and function scope, including non-constant runtime values;
array designated initializers (`[N] = ...`); partial brace
initializers for function-scope arrays zero-fill the trailing
range per C99 6.7.9p21 (both the constant Mcpy-from-data fast
path and the per-element runtime store path); `static` /
`extern` / `_Thread_local`; varargs through the host variadic
ABI (SysV AMD64 / AAPCS64 / Win64), including floating-point
variadic arguments and the integer / FP register split; libc
calls whose declared return type is narrower than the register
get the matching sign / zero extension applied to the result
before it is used (`tests/fixtures/c/libc_fp_return_value.c`,
`aapcs64_variadic_host_abi.c`, `sysv_variadic_host_abi.c`); the
C99 for-init declaration
(`for (int i = 0; ...; ...)`); switch with `case` /
`default` / fall-through; full set of compound assignment
and increment / decrement operators; pointer arithmetic,
ordered pointer compares (against zero and exhaustive
equality); the full C99 6.6 constant-expression grammar
with FP folding (`int xs[(int)(1.5 * 2.0)];`, arithmetic /
comparisons / conditional / sizeof / bitwise / logical
operators) in array sizes, bitfield widths, enum
initializers, `_Static_assert`, and scalar global integer
initializers; `sizeof` over typedef-of-array operands
returns the total byte count per C99 6.5.3.4p4 + 6.7.7p3;
the `<stdio.h>` / `<stdlib.h>` / `<string.h>` / `<math.h>`
/ `<time.h>` / `<setjmp.h>` / `<dlfcn.h>` / `<pthread.h>` /
`<windows.h>` surfaces documented in `headers/include/`
(setjmp / longjmp coexist as both the macro and the function
form per C99 7.1.4 so bare-identifier uses still resolve);
multi-source compile + link (`badc -c foo.c bar.c` followed
by `badc -o app foo.o bar.o`, plus `--ar` for archives and
`-L<dir>` / `-l<name>` for archive resolution); multiple
translation units (C99 5.1.1.1) merge through the cross-TU
linker with binding tables remapped against each unit's
final import set; binary integer literals (`0b...` / `0B...`,
C23 / GCC extension) with the same suffix-letter handling
as hex and decimal constants.

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
host platform ABI. `float` and `double` are first-class
floating-point values: the register allocator gives them a
separate FP register bank. `double` loads / stores with a
single FP move; `float` is IEEE 754 single-precision storage
(4 bytes) that widens to f64 on load and narrows on store.

**Bare `char` is unsigned** on every target (1-byte zero-
extending load). gcc and clang differ on this per host
architecture; portable code that walks bytes by sign already
spells `signed char` explicitly. `signed char` is recognised
as a distinct type and integer-promotes to signed `int` for
arithmetic. Severity: 4.

## Divergences

### Address of a dynamically-imported function on native targets, severity 3

Taking the address of a function resolved through a `#pragma
binding` import (a libc / libm symbol such as `fabs`, `sin`,
`memcpy`) is unsupported when emitting a native binary, in both
data and code:

```c
typedef double (*fn1)(double);
static fn1 table[] = { fabs, sin, cos };   // error: undefined reference to `fabs` (data initializer)
fn1 p = fabs;                              // error: undefined reference to `fabs`
```

The native path lowers a *call* to an imported function to a
PLT-relative call resolved by the per-import trampoline, but it
does not materialize the import's *address* as a value: the
operand decays to a plain global-undef symbol that the linker
cannot place. The address of a c5-*defined* function in the same
position works (it resolves against the merged Text section);
only dynamic imports diverge. The interpreter and JIT resolve the
address at run time, so this is native-only. Fixing it spans
codegen (emit an address-of-import relocation), the linker (a GOT
slot per address-taken import), and all three object writers
(Mach-O / ELF / PE) across both architectures. The common idiom
it blocks is a static dispatch table of libc functions (math
expression evaluators, scripting glue).

### libc `struct`-by-value ABI, severity 2

`div(...)`, `gmtime(...)`, and other libc functions that take
or return a struct by value are rejected at compile time (the
diagnostic names the call). c5's own struct calling convention
passes every struct argument by the source's address and returns
every struct through a hidden out-pointer prepended to the
argument list, regardless of the struct's size. SysV / Win64 /
AAPCS64 instead pack a small struct (typically <= 16 bytes) into
argument / result registers, so c5's convention cannot call a
host function that takes or returns a struct by value. c5-to-c5
struct pass / return works (see `tests/fixtures/c/
struct_by_value_param.c` and `struct_by_value_return.c`).

### `long double` is 8-byte FP64 in c5 storage, severity 5

C99 6.2.5p10 lets `long double` be any FP type at least as wide as
`double`, and the host ABIs differ:

| Target           | Platform-correct `long double` |
|------------------|--------------------------------|
| Linux x86_64     | 80-bit x87 extended (10 bytes, 16-byte aligned) |
| Linux aarch64    | IEEE binary128 (16 bytes)      |
| macOS aarch64    | IEEE binary64 -- same as `double` (8 bytes) |
| Windows x86_64   | IEEE binary64 -- same as `double` (8 bytes) |
| Windows aarch64  | IEEE binary64 -- same as `double` (8 bytes) |

c5 stores every `long double` as 8-byte FP64 regardless of host.
That matches macOS / Windows directly; on Linux x86_64 and Linux
aarch64 the libc-boundary readers narrow the wider host return
value into c5's FP64 slot via x87-`fstp QWORD PTR [rsp]` and a
`__trunctfdf2` libgcc helper call respectively, so `strtold` and
friends round-trip the value the host computes (down to FP64
precision). Long-double *literals* inside c5 source still compile
through the FP64 pipeline, so an `0x1p120L` literal would lose
the trailing exponent range and a binary built against c5 cannot
represent the full Linux aarch64 binary128 dynamic range.

### Compound literals (`(struct Foo){.x=1}`), severity 4

Supported at file scope (C99 6.5.2.5p5, static storage
duration): `Type *p = &(T){...};` and the empty form
`Scope *s = &(T){};` synthesize an anonymous internal-linkage
symbol of the named struct type and patch the surrounding `&`
reloc to point at it. Block-scope compound literals (automatic
storage duration with lifetime equal to the enclosing block,
6.5.2.5p5) are also supported for scalar, struct, and array
types: `f(&(struct Pt){1, 2})`, `(int[]){1, 2, 3}`,
`(char *[]){"a", "b"}`. Non-constant element values are stored
at the evaluation point so the surrounding evaluation order is
observed. The one remaining gap is a brace-wrapped string
initializer for a `char` array (`(char[N]){"abc"}`), which
shares the file-scope `char a[N] = {"abc"}` limitation.

### Abstract function-pointer declarator in `sizeof`, severity 5

`sizeof(int(*)(int))` is rejected (the `sizeof` operand parser
doesn't accept the abstract function-pointer declarator). The
same declarator in cast position -- `(int(*)(int))p` -- is
accepted and calls through correctly, as does its use in
typedef / parameter / struct-field declarators.

### Function-pointer return through a function-pointer variable, severity 5

A function whose return type is itself a function pointer is
called correctly when the callee is a named function:
`int (*f(void))(int)` then `(*f())(3)`, `f()(3)`, or
`int (*q)(int) = f();  q(3);` all work. The unhandled shape is
calling such a function *through a function-pointer variable*:

```c
int (*(*p)(int))(int) = f;   /* p: ptr to fn returning fn-ptr */
(*p)(0)(3);                  /* indirect call returns fn-ptr   */
```

c5 records a function pointer's indirection as a single scalar
(`Symbol::fn_ptr_indirection`) on the flat type, so the variable
`p` and the type `int (**)(int)` (pointer-to-pointer-to-int-fn)
collapse to the same encoding. The indirect-call path derives the
result type by removing one pointer level, which drops the return
type's own function-pointer level and narrows the returned 64-bit
pointer. TODO: track the return type's pointer/function shape
distinctly from the variable's own indirection.

## Rejected modern features (rare in C99 source)

`register` / `auto` are accepted as no-ops. `inline` /
`__inline` / `__inline__` are accepted but don't expand.
`const` / `volatile` / `restrict` are accepted as no-ops at
every position. `_Noreturn` (C11 6.7.4) is accepted as a
no-op (the optimizer hint isn't propagated). `#line` is
supported -- both the C99 `#line N "file"` form and the GNU
`# N "file"` shape route through the same lexer hook.
`_Complex`, `_Imaginary`, `_Pragma`, `__STDC_VERSION__`,
`__STDC_HOSTED__`, float `++` / `--`, universal character
names, digraphs / trigraphs, K&R identifier-list function
declarators, GCC named-rest variadic (`#define foo(args...)`)
-- all rejected. Severity 4-5.

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
  custom non-`main` entry.
- `#pragma subsystem(console | windows)` -- pick the Windows
  PE optional-header `Subsystem` field. Quietly ignored on
  non-PE targets so the same source builds for every OS.
- `#pragma once`.
- `--interp` (SSA interpreter with pointer tracking),
  `--jit` (in-process), `--dump-ssa`.
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
2. Abstract function-pointer declarator in `sizeof`.
3. Brace-wrapped string initializer for `char` arrays
   (`char a[N] = {"abc"}` / `(char[N]){"abc"}`).
