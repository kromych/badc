# Standard conformance

c5 targets C99. Anything a C99 program relies on that is not listed here
follows C99; the standard is the reference for the conforming surface.
This document records three things: the implementation-defined choices C99
requires a compiler to make (6.2.5, 6.7.2), the divergences from C99, and
the non-C99 extensions c5 implements (C11, C23, POSIX, GCC, MSVC, and
c5-specific).

## Implementation-defined choices (C99 6.2.5, 6.7.2)

| type            | macOS / Linux | Windows |
|-----------------|---------------|---------|
| `char`          | 1             | 1       |
| `short`         | 2             | 2       |
| `int`           | 4             | 4       |
| `long`          | 8             | 4       |
| `long long`     | 8             | 8       |
| pointer / `T *` | 8             | 8       |
| `float`         | 4             | 4       |
| `double`        | 8             | 8       |

LP64 on macOS / Linux, LLP64 on Windows -- both match the host platform
ABI. `wchar_t` is 4-byte `int` on macOS / Linux and 2-byte UTF-16 on
Windows, matching each host.

**Bare `char` is unsigned** on every target (1-byte zero-extending load).
gcc and clang differ on this per host architecture; portable code that
walks bytes by sign already spells `signed char` explicitly. `signed char`
is a distinct type and integer-promotes to signed `int`.

**`long double` is 8-byte IEEE binary64** (the same representation as
`double`) regardless of host. C99 6.2.5p10 permits any FP type at least as
wide as `double`. This matches macOS and Windows directly. On Linux x86_64
(host 80-bit x87) and Linux aarch64 (host IEEE binary128) the libc-boundary
readers narrow the wider host return into the FP64 slot (x87
`fstp QWORD PTR [rsp]` and a `__trunctfdf2` libgcc call respectively), so
`strtold` and friends round-trip to FP64 precision; a `long double` literal
and any value held in c5 cannot represent the wider host dynamic range.

## Divergences from C99

Severity (for compiling existing C): 1 = blocks almost everything,
2 = blocks much real code, 3 = blocks specific idioms, 4 = workaround
exists, 5 = rare in modern source.

### `struct`-by-value through a `#pragma binding` import, severity 4

A struct passed or returned by value follows the host ABI for c5-to-c5
calls and for regular `extern` declarations (System V AMD64 rax/rdx + the
integer arg registers, AAPCS64 x0/x1, the AAPCS64 x8 indirect class for
aggregates larger than 16 bytes), including the inline libc wrappers in the
bundled headers (`div()` returns its `div_t` in registers). The remaining
gap is a struct passed or returned by value across a `#pragma binding`
import (a `Token::Sys` symbol): the call is rejected at compile time (the
diagnostic names the argument or call) because the address-as-value
internal convention reaches those symbols before the host-ABI packing. Pass
`&s` or a pointer-returning variant.

### Brace-wrapped string initializer for a `char` array, severity 4

`char a[N] = {"abc"}` and the compound-literal form `(char[N]){"abc"}` are
rejected. The unbraced `char a[N] = "abc"` works; the brace-wrapped variant
shares one parse limitation. Other compound-literal shapes (scalar, struct,
array, including non-constant element values) work at file and block scope.

### `volatile` is accepted but not honored, severity 4

`volatile` is parsed at every position and discarded. c5 does not guarantee
that a `volatile` access is preserved or unreordered against other memory
accesses, so memory-mapped-IO code that relies on the access actually
happening is not safe. `const` and `restrict` are likewise accepted as
no-ops; for those the no-op is sound (const violations are undefined,
`restrict` is an aliasing hint).

### `sizeof` an abstract function-pointer declarator, severity 5

`sizeof(int(*)(int))` is rejected (the `sizeof` operand parser does not
accept the abstract function-pointer declarator). The same declarator in
cast position (`(int(*)(int))p`) and in typedef / parameter / struct-field
declarators is accepted.

### Function-pointer return through a function-pointer variable, severity 5

A function whose return type is itself a function pointer is called
correctly when the callee is named: `int (*f(void))(int)` then `(*f())(3)`,
`f()(3)`, or `int (*q)(int) = f(); q(3)`. The unhandled shape is calling
such a function *through a function-pointer variable*
(`int (*(*p)(int))(int) = f; (*p)(0)(3)`): c5 records a function pointer's
indirection as a single scalar on the flat type, so `p` and
`int (**)(int)` collapse to the same encoding, and the indirect-call result
type drops the return type's own function-pointer level.

### Not implemented, severity 4-5

C99 features rejected (all rare in current source): `_Complex` /
`_Imaginary` (6.2.5), `_Pragma` (6.10.9), universal character names
(6.4.3), digraphs and trigraphs (6.4.6 / 5.2.1.1), K&R identifier-list
function declarators (obsolescent, 6.11.7), and `++` / `--` on a `float`
lvalue. `inline` / `__inline` / `__inline__` and `_Noreturn` are accepted
but inert (no inlining, no `noreturn` propagation). `__STDC_VERSION__` /
`__STDC_HOSTED__` are not predefined.

The C11 `_Generic` selection and the GCC named-rest variadic macro
(`#define foo(args...)`) are likewise not implemented.

## Extensions implemented

### C11 / C23

- `_Static_assert`, and the C23 `static_assert` alias, at file and block
  scope; the operand flows through the full C99 6.6 constant-expression
  grammar (float casts and arithmetic work in the condition).
- `_Atomic(type-name)` specifier (6.7.2.4) and the `_Atomic` qualifier
  (6.7.3) are accepted and reduce to the unqualified inner type; atomicity
  is not modelled.
- C11 7.17 atomic operations as header-less builtins: `atomic_load`,
  `atomic_store`, `atomic_exchange`, `atomic_fetch_add` / `sub` / `and` /
  `or` / `xor`, `atomic_compare_exchange_strong`; the width is the pointee
  type of the first argument. `load` / `store` are atomic (a
  naturally-aligned scalar access already is on the supported targets); the
  read-modify-write forms lower to a non-atomic load-operate-store sequence
  (correct for one thread, not atomic against concurrent access).
  Memory-order arguments are not modelled; only the non-`_explicit` forms
  are recognized.
- `_Thread_local` (init limited to scalars + NULL).
- Anonymous `struct` / `union` members (C11 6.7.2.1p13).
- Binary integer literals `0b...` / `0B...` (C23 / GCC), with the same
  `u` / `l` suffix handling as hex and decimal.

### POSIX

- The `<dlfcn.h>`, `<pthread.h>`, `<dirent.h>`, `<setjmp.h>`, and related
  surfaces in `headers/include/`; `struct dirent` matches the host libc
  byte layout so `readdir` reads `d_name` at its real offset.
- `fseeko` / `ftello` (the `off_t` seek/tell pair), and the glibc
  `malloc_usable_size` and `sighandler_t` on Linux.

### GCC

- Computed goto / labels as values: `&&label` and `goto *expr`, including a
  `&&label` element in an automatic or static array initializer (the
  dispatch-table idiom; a static table is filled by runtime stores since a
  block address is not a link-time constant).
- The array range designator `[a ... b] = value`.
- Zero-length arrays (`T x[0]`) accepted as flexible array members.
- Compiler builtins with no header: `__builtin_clz` / `ctz` / `popcount`
  (+ `ll` forms), `__builtin_bswap16` / `32` / `64`, `__builtin_expect`,
  `__builtin_unreachable`, `__builtin_frame_address(0)`, `__builtin_trap`,
  `__builtin_alloca`. The bit-count and byte-swap builtins lower to a
  portable shift / mask sequence.
- `__FUNCTION__` / `__PRETTY_FUNCTION__` (alongside the C99 `__func__`).
- The GNU `# N "file"` line-marker shape (alongside C99 `#line N "file"`).
- Inline asm (`asm` / `__asm__`, a common extension listed in C99 Annex
  J.5.10), in its operand-free forms only: an empty template (a compiler
  barrier, no instruction emitted, weaker than a hardware memory barrier)
  and the `pause` / `yield` spin-loop hint. Operand constraints and
  arbitrary instruction text are rejected -- c5 emits machine code directly
  and has no assembler for an arbitrary template.

### MSVC-compatible

- `#pragma warning(push)` / `pop` / `disable : N`.
- `__COUNTER__` (also recognized by GCC).

### c5-specific

- `#pragma dylib` / `#pragma binding` / `#pragma export` -- per-target
  loader symbol resolution and shared-library export.
- `#pragma entrypoint(<name>)` -- override the default `main` entry point
  (e.g. `WinMain`).
- `#pragma subsystem(console | windows | native | driver)` -- the Windows PE optional-header
  `Subsystem` field; ignored on non-PE targets.
- `#pragma once`.
- `--interp` (SSA interpreter with pointer tracking), `--jit` (in-process),
  `--dump-ssa`.
- `-H` / `--show-includes` -- gcc-`-H`-shape `#include` resolution trace.
- A missing `#include` file or an unknown preprocessor directive is a
  *warning*, not a fatal error, so legacy sources sprinkled with
  documentation-only includes keep compiling. clang / gcc treat both as
  fatal.
- `__BADC_VERSION__`, `__BADC_TARGET__`, `__BADC_WINDOWS__` predefines.

## Roadmap

1. `struct`-by-value across a `#pragma binding` import (host-ABI packing
   reaching `Token::Sys` symbols).
2. Brace-wrapped string initializer for `char` arrays.
3. Abstract function-pointer declarator in `sizeof`.
4. `volatile`-honored loads / stores.
