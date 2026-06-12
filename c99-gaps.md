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
literals (`L"..."` / `L'...'`; `wchar_t` is 4-byte `int` on
macOS / Linux and 2-byte UTF-16 on Windows, matching each host);
pointers, arrays, multi-dim arrays,
function pointers and chains thereof; `struct` / `union` /
`enum` / `typedef`, bitfields (signed and unsigned, sign-
extending read per C99 6.7.2.1p4, adjacent fields packed into a
shared storage unit by a running bit cursor with the straddle
rule per C99 6.7.2.1p11, including fields of different base
types), `#pragma pack(N)`, anonymous struct / union
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

The common GCC builtins are available with no header (compiler
builtins, not library functions): `__builtin_clz` / `ctz` /
`popcount` and their `ll` forms, `__builtin_bswap16` / `32` /
`64`, `__builtin_expect`, `__builtin_unreachable`,
`__builtin_frame_address(0)`, `__builtin_trap`, and
`__builtin_alloca`. The bit-count and byte-swap builtins lower
to a portable shift / mask sequence; `frame_address(0)` reads
the frame pointer. GCC zero-length arrays (`T x[0]`) are
accepted as flexible array members. A struct passed or returned
by value follows the host ABI between c5 functions, including a
struct returned through a function pointer (register classes:
<= 16 bytes on AAPCS64 / System V, the AAPCS64 x8 indirect
class for larger aggregates). A compound literal may be nested
inside another aggregate initializer (`(Outer){(Inner){...},
...}`), and a nested struct / union member may carry
non-constant initializers. `<stdio.h>` exposes the `scanf` /
`fscanf` / `sscanf` family (C99 7.19.6). The C11 `_Atomic`
type specifier `_Atomic(type-name)` (6.7.2.4) and the
`_Atomic` type qualifier (6.7.3) are accepted and reduce to
the unqualified inner type (atomicity is not modelled). The
C11 7.17 atomic operations `atomic_load`, `atomic_store`,
`atomic_exchange`, `atomic_fetch_add` / `sub` / `and` / `or`
/ `xor`, and `atomic_compare_exchange_strong` are available
as header-less compiler builtins; the operand width is the
pointee type of the first argument. The GCC inline-asm
statement (`asm` / `__asm__`) is accepted in its operand-free
forms: an empty template (a compiler barrier) and the
`pause` / `yield` spin-loop hint.

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

### Inline asm is limited to operand-free hints and the barrier, severity 3

The GCC inline-asm statement (`asm` / `__asm__`) is accepted only in
its operand-free forms: an empty template (a compiler barrier, no
instruction emitted) and a single known operand-free hint instruction
(`pause` / `yield`, lowered to the target spin-loop hint). Output /
input operand constraints and any other instruction text are rejected
with a diagnostic, because c5 emits machine code directly and has no
assembler to translate an arbitrary template. The empty-template
barrier emits nothing; c5 does not reorder memory accesses across the
statement, but this is weaker than a full hardware memory barrier.
General inline asm needs an assembler for the template and
constraint-driven operand allocation.

### C11 atomic read-modify-write is not inter-thread atomic, severity 3

The C11 7.17 atomic operations are accepted (see "What works").
`atomic_load` and `atomic_store` carry full semantics: a
naturally-aligned scalar load and store is already atomic on the
supported targets. The read-modify-write forms (`atomic_exchange`,
`atomic_fetch_*`, `atomic_compare_exchange_strong`) lower to a
non-atomic load-operate-store sequence. The result is correct for
a single thread of execution but does not provide atomicity
against concurrent access. Memory-order arguments are not modelled;
only the non-`_explicit` forms are recognized. Making the
read-modify-write forms inter-thread atomic needs the target's
atomic instructions (x86 `lock` prefix / `xchg` / `cmpxchg`,
AArch64 LSE or load-exclusive / store-exclusive).

### Address of a single-precision intrinsic math function, severity 5

Taking the address of an imported function -- in a static
initializer or a scalar assignment, and calling through the
pointer -- works on every native target (Mach-O / ELF / PE,
both architectures) for ordinary libc / libm symbols (`sin`,
`cos`, `memcpy`, `strlen`) and for the double-precision math
functions that lower to a single FP instruction (`fabs`,
`sqrt`, `floor`, `ceil`, `trunc`), which carry a `#pragma
binding` so their address resolves to a real symbol.

The remaining gap is the single-precision variants `fabsf`,
`sqrtf`, `floorf`, `ceilf`, `truncf`: a direct call lowers to
one FP instruction through the intrinsic, so they carry no
library symbol, and taking their address in a native build
fails to link:

```c
typedef float (*ff)(float);
static ff t[] = { fabsf };   // error: undefined reference to `fabsf` (data initializer)
```

The interpreter and JIT resolve the address at run time, so
this is native-only. Binding these symbols (as the double-
precision functions are bound) resolves the address, but a
single-precision call *through* the resulting pointer hits the
function-pointer `float` ABI gap below, so the binding alone
does not make the address usable.

### `float` argument or return through a function pointer, severity 4

c5 carries no per-parameter type on a function-pointer type:
the prototype-level dialect does not distinguish `float` from
`double`. A direct call narrows each argument to the callee's
declared parameter type and widens the result from the callee's
return type, so a `float`-by-value call is single-precision
end to end. A call through a function pointer has no parameter
types to narrow to, so it applies the C99 6.5.2.2p6 default
argument promotions as if the callee were unprototyped: a
`float` argument is widened to `double` before the call and a
`float` result is read back as `double`. The callee reads the
single-precision view of the register and sees the wrong bits:

```c
static int t2i(float x) { return (int)x; }
int (*p)(float) = t2i;
int r = p(7.5f);   // r == 0, not 7
```

`double` arguments and returns through a function pointer are
correct (the 8-byte value matches). The fix is to record the
pointed-to function's parameter and return types on the
function-pointer type so the indirect call narrows / widens the
same way a direct call does.

### `struct`-by-value through a `#pragma binding` import, severity 4

A struct passed or returned by value follows the host ABI for
c5-to-c5 calls and for regular `extern` declarations, including
the inline libc wrappers in the bundled headers: `div(...)`
returns its `div_t` in the result registers, and a <= 16-byte
struct argument or return rides the argument / result registers
(System V AMD64 rax/rdx and the integer arg registers, AAPCS64
x0/x1, the AAPCS64 x8 indirect class for larger aggregates). The
remaining gap is a struct passed or returned by value across a
`#pragma binding` import (a `Token::Sys` symbol): the call is
rejected at compile time (the diagnostic names the argument or
call) because the address-as-value internal convention reaches
those symbols before the host-ABI packing. Pass `&s` or use a
pointer-returning variant. c5-to-c5 struct pass / return works
(see `tests/fixtures/c/struct_by_value_param.c`,
`struct_by_value_return.c`, and `union_fp_member_regs_return.c`).

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

1. `struct`-by-value across a `#pragma binding` import
   (the host-ABI packing reaches `Token::Sys` symbols).
2. Abstract function-pointer declarator in `sizeof`.
3. Brace-wrapped string initializer for `char` arrays
   (`char a[N] = {"abc"}` / `(char[N]){"abc"}`).
