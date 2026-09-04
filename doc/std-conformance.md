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
Windows, matching each host. The widths are also readable from the
`__SIZEOF_*__` predefines, which agree with the table by construction.

Plain `char` signedness is implementation-defined (C99 6.2.5p15).
c5 follows the host C ABI: signed on x86_64 (all OSes), Apple
AArch64, and Windows AArch64; unsigned on AArch64 ELF. The chosen
signedness agrees with the `__CHAR_UNSIGNED__` predefine and
drives the extension when an 8-bit `char` l-value widens to a
larger integer.

**`long double`'s storage follows the target ABI.** C99 6.2.5p10 permits
any FP type at least as wide as `double`. `sizeof`, `_Alignof`, struct
offsets, array stride, static initializers, `<float.h>`, and the
`__LDBL_*` / `__SIZEOF_LONG_DOUBLE__` predefines all report one layout
per target:

| target          | platform `long double` | badc stores    | size / align |
|-----------------|------------------------|----------------|--------------|
| linux-x64       | x87 80-bit             | x87 80-bit     | 16 / 16      |
| linux-aarch64   | IEEE binary128         | IEEE binary128 | 16 / 16      |
| macos-aarch64   | IEEE binary64          | IEEE binary64  | 8 / 8        |
| windows-x64     | IEEE binary64          | IEEE binary64  | 8 / 8        |
| windows-aarch64 | IEEE binary64          | IEEE binary64  | 8 / 8        |

An object therefore has the platform's layout and encoding on every
target, so a struct, an array, or a `.data` object shared with code
built by the platform toolchain agrees byte for byte. A load converts
the stored value to binary64 and a store converts back exactly: on
linux-x64 through `fld`/`fstp`, matching the hardware conversions bit
for bit including the noncanonical encodings; on linux-aarch64, which
has no quad-precision unit, through open-coded integer sequences that
match gcc's `__extenddftf2` / `__trunctfdf2` bit for bit.

Two consequences remain on both Linux targets:

* **Precision.** Arithmetic is carried out at binary64 precision on
  every target, so a value needing more than 53 significand bits does
  not round-trip -- `(unsigned long long)(long double)((1ULL<<53)+1)`
  loses the low bit where the platform types keep it. On linux-x64 the
  stored object holds the full 64-bit significand, but a value that
  passes through the compute path has already been rounded.
* **Argument passing.** Where a `long double` reaches a platform-libc
  callee still typed `long double`, the callee decodes it in the
  platform's calling convention -- a 16-byte stack slot on System V
  x86-64, a vector register on AAPCS64 -- while badc supplies the
  binary64 it computes with in the FP argument bank. That is the
  variadic tail: `printf("%Lf", 1.0L)` prints `nan` on linux-x64 and
  `0.000000` on linux-aarch64. Each such argument draws a compile-time
  warning naming the platform format, so the mismatch is not silent. The
  fixed parameters are unaffected -- `<math.h>` binds the `l` entry
  points (`ldexpl`, `fabsl`, ...) to their `double` counterparts, so the
  argument converts to a `double` parameter exactly and the ABI matches.
* **Returns** are handled: the libc-boundary readers narrow the wider
  platform return into the FP64 slot (x87 `fstp QWORD PTR [rsp]` and a
  `__trunctfdf2` libgcc call respectively), so `strtold` and friends
  round-trip to FP64 precision.

The remaining work is the argument / return conventions (a MEMORY-class
16-byte stack slot and an `st(0)` return on System V, a Q register on
AAPCS64) and extended-precision arithmetic. TODO: extended-precision
`long double`.

Byte order is little-endian on every target: `__BYTE_ORDER__` expands to
`__ORDER_LITTLE_ENDIAN__` and `__LITTLE_ENDIAN__` is defined.

## Divergences from C99

Severity (for compiling existing C): 1 = blocks almost everything,
2 = blocks much real code, 3 = blocks specific idioms, 4 = workaround
exists, 5 = rare in modern source.

### `const` accepted but not enforced, severity 4

`volatile` is enforced (6.7.3p6): an access through a volatile-qualified
lvalue is marked through the IR, performed exactly once in program order at
every optimization level, kept memory-resident (no promotion, coalescing,
forwarding, or dead-access elision), and never moved across an inline-asm
statement. One gap remains: a whole-aggregate copy of a volatile-qualified
struct is lowered as an unmarked block copy. `const` is accepted but not
enforced: c5 does not diagnose assignment to a `const`-qualified object (a
6.5.16.1 constraint violation) or the discarding of `const` in a conversion,
so a program that modifies a `const` object compiles without the required
diagnostic. `restrict` is accepted as a sound no-op -- it is only an
aliasing hint with no observable semantics.

### Function-pointer return lineage carries one call level, severity 5

A pointer to a function returning a function pointer
(`int (*(*p)(int))(int) = f`) is called correctly in every spelling --
`(*p)(0)(3)`, `p(0)(3)`, `(*(*p)(0))(3)` -- for local, global, typedef,
struct-member, and parameter carriers. The flat tag holds only the total
pointer depth (shared with `int (**)(int)`); the symbol carries the split
as two scalars, the derefs down to the function pointer and the return
value's own lineage, and the call sites seed the decay tracking from them
(C99 6.3.2.1p4). One scalar per side covers one function-pointer level per
call: a return chain that is *itself* a pointer to a
function-pointer-returning function (`int (*(*(*p)(int))(int))(int)`)
calls correctly without `*` between the later calls, while a
star-decorated later call (`(*(*(*p)(0))(0))(3)`) is rejected with a
diagnostic rather than compiled. TODO: carry the full per-level lineage.

### An inline definition is materialized unit-locally, severity 5

C99 6.7.4p6-p7 decides whether a definition is an *inline definition*: it
is when every file-scope declaration of the function includes `inline` and
none includes `extern`. An inline definition provides no external
definition, and badc emits none. Where gcc leaves the un-inlined reference
undefined, for the program's external definition to satisfy, badc gives the
definition internal linkage and binds the reference to the unit-local body
-- the alternative 6.7.4p6 grants the translator ("an alternative to an
external definition, which a translator may use to implement any call to
the function in the same translation unit"). Consequence: `&f` in such a
unit is that unit's copy, so it need not compare equal to a pointer another
unit takes.

### `__STDC_HOSTED__` is always 1, severity 5

C99 6.10.8p3 defines `__STDC_HOSTED__` as 1 only for a hosted
implementation. c5 defines it as 1 unconditionally, including under
`--freestanding`, so source that selects a freestanding subset from this
macro alone takes the hosted branch. `--freestanding` changes what is
linked, not what is predefined.

### Not implemented, severity 4-5

C99 features rejected (all rare in current source): `_Complex` /
`_Imaginary` (6.2.5), universal character names (6.4.3), and digraphs and
trigraphs (6.4.6 / 5.2.1.1). The absence of complex types is announced in
the C11-conforming way: `__STDC_NO_COMPLEX__` is defined as 1.
`#pragma STDC FP_CONTRACT` / `FENV_ACCESS` / `CX_LIMITED_RANGE` (7.1.2p6)
are accepted and ignored: `-O` contracts `a*b+c` into an FMA whatever the
pragma says.

Implemented, and listed here because they sit next to the above in C99:
K&R identifier-list function declarators with separate parameter
declarations (obsolescent, 6.11.7) are accepted and lowered. `_Noreturn` is
recorded on the function symbol and propagated -- a call to a `_Noreturn`
function does not reach its continuation in the fall-through reachability
analysis, which also errors on a non-`void`, non-`main` function that can
fall off its end without returning a value.

`__STDC__`, `__STDC_HOSTED__`, `__DATE__`, and `__TIME__` are predefined.
`__STDC_VERSION__` is defined as `201112L` (C11): the implemented surface
is C99 plus the C11 features real code gates on this macro
(`_Static_assert`, `_Noreturn`, `_Atomic`, `_Thread_local`, `_Generic`,
anonymous members, `<stdatomic.h>`).

### Unrecognized command-line options are fatal, severity 4

badc's driver has no accept-and-ignore bucket: any dash-prefixed argument
no option arm matches is an error, not a warning. Common gcc spellings
badc does not implement -- `-x`, `-isystem`, `-static`, and `-gdwarf-<n>`
-- therefore fail the invocation rather than being dropped. A build system
that passes a compiler's whole flag set through has to filter it; the
kernel harness under `demos/linux/` does exactly that.

The `-W` family follows the same rule against the diagnostic catalogue.
`-w`, `-Werror`, `-Wno-error`, `-Werror=<sel>`, `-Wno-error=<sel>`,
`-W<sel>`, `-Wno-<sel>`, `-Wall`, `-Wextra` and `-Wpedantic` are
implemented; a selector is a diagnostic's name, one of its aliases, its
`B` code or a group name, and one no catalogue row answers to is refused
by name. `--list-diagnostics` prints the catalogue.

`-Wa,<opt>` and `-Xassembler <opt>` are checked rather than passed on, since
the assembler is built in: an option badc's assembler has no equivalent for
is refused by name (`unsupported assembler option`) instead of reaching a
program that is not there. `-L` / `--keep-locals` is accepted and keeps the
local-label temporaries in the symbol table, as GNU as does.

`-std=<dialect>` is accepted. badc compiles C99 with the GNU extensions
always available, so the name selects only whether `__STRICT_ANSI__` is
defined under `--gnu`: `gnu*` clears it and `c*` / `iso*` set it, as in
gcc and clang. Without the flag `--gnu` reports strict conformance, so a
header takes its standard-C path for the GNU features badc lacks.

## Extensions implemented

### C11 / C23

- `_Static_assert`, the C23 `static_assert` alias, and the C23 form with no
  message, at file and block scope; the operand flows through the full C99
  6.6 constant-expression grammar (float casts and arithmetic work in the
  condition).
- `_Generic` selection (C11 6.5.1.1).
- `_Atomic(type-name)` specifier (6.7.2.4) and the `_Atomic` qualifier
  (6.7.3) are accepted and reduce to the unqualified inner type; the
  qualifier itself carries no atomicity.
- C11 7.17 atomic operations, reached through `<stdatomic.h>`, which binds
  them with `#pragma intrinsic`: `atomic_load`, `atomic_store`,
  `atomic_exchange`, `atomic_fetch_add` / `sub` / `and` / `or` / `xor`,
  `atomic_compare_exchange_strong`. The width is the pointee type of the
  first argument. All of them are atomic against concurrent access: loads
  and stores are naturally-aligned scalar accesses, and the
  read-modify-write forms lower to `lock xadd` / `xchg` / `lock cmpxchg` on
  x86_64 and to `cas` or an `ldaxr` / `stlxr` pair on aarch64. Memory-order
  arguments are not modelled -- every form carries the target's strongest
  ordering -- and only the non-`_explicit` spellings are recognized.
- `_Thread_local`, and the GNU `__thread` spelling, at file and block scope
  (a block-scope `static _Thread_local` gets one per-thread instance) on
  every target. On ELF, variables land in `.tdata` / `.tbss`, their
  symbols are typed `STT_TLS`, and TLS-relative relocations let a badc object
  link against external TLS through the system linker; on PE the image
  carries an `IMAGE_TLS_DIRECTORY64`; on Mach-O each variable gets a
  `__DATA,__thread_vars` descriptor whose getter slot dyld binds to
  libSystem's `__tlv_bootstrap`, with the per-thread image in
  `__thread_data` / `__thread_bss` (libSystem is added to the dylib list
  when nothing else pulls it in). File-scope initializers are limited to
  scalars and NULL, and an initializer on a block-scope `_Thread_local`
  object is rejected.
- Anonymous `struct` / `union` members (C11 6.7.2.1p13).
- Binary integer literals `0b...` / `0B...` (C23 / GCC), with the same
  `u` / `l` suffix handling as hex and decimal.

### POSIX

- The `<dlfcn.h>`, `<pthread.h>`, `<dirent.h>`, `<setjmp.h>`, and related
  surfaces in `libc/include/`; `struct dirent` matches the host libc
  byte layout so `readdir` reads `d_name` at its real offset.
- `fseeko` / `ftello` (the `off_t` seek/tell pair), and the glibc
  `malloc_usable_size` and `sighandler_t` on Linux.

### GCC

- Statement expressions (`({ ... })`), `typeof` / `__typeof__`, and the
  case-range form `case a ... b:`.
- Computed goto / labels as values: `&&label` and `goto *expr`, including a
  `&&label` element in an automatic or static array initializer (the
  dispatch-table idiom; a static table is filled by runtime stores since a
  block address is not a link-time constant).
- The array range designator `[a ... b] = value`.
- Zero-length arrays (`T x[0]`) accepted as flexible array members.
- `__int128` / `unsigned __int128`, with `__SIZEOF_INT128__` defined as 16.
- The x86 named address spaces `__seg_gs` / `__seg_fs`, which lower to a
  segment override on the access.
- Compiler builtins with no header:
  - bit counting -- `__builtin_clz` / `ctz` / `popcount` / `clrsb` /
    `parity` / `ffs`, each with `l` and `ll` forms;
  - byte swapping -- `__builtin_bswap16` / `32` / `64`;
  - control -- `__builtin_expect`, `__builtin_unreachable`,
    `__builtin_trap`, `__builtin_prefetch`, `__builtin_assume_aligned`;
  - frame -- `__builtin_frame_address`, `__builtin_return_address` (any
    constant level, walking the frame-pointer chain), `__builtin_alloca`;
  - variadics -- `__builtin_va_list`, `__builtin_va_start` / `va_arg` /
    `va_end` / `va_copy`;
  - compile-time queries -- `__builtin_constant_p`,
    `__builtin_choose_expr`, `__builtin_types_compatible_p`,
    `__builtin_offsetof`, `__builtin_object_size`;
  - checked arithmetic -- `__builtin_add_overflow` / `sub` / `mul`;
  - memory -- `__builtin_memcpy` / `memmove` / `memset`.

  The bit-count and byte-swap builtins lower to a portable shift / mask
  sequence in the SSA walker rather than to `lzcnt` / `tzcnt` / `popcnt` /
  `bswap` / `rbit`, so the interpreter and every target agree bit for bit.
  A consequence of that lowering: `__builtin_clz(0)` and
  `__builtin_ctz(0)` return the operand width instead of being undefined.
  `__builtin_unreachable` lowers to a trap, so reaching one aborts.
  `__builtin_has_attribute` is accepted and always folds to 0.
  The remaining string, allocation and absolute-value `__builtin_`
  spellings are equivalent to the library function of the same name, which
  the parser binds them to through the symbol table -- a unit that defines
  a macro of the library name (as the fortified string headers do) still
  gets the builtin from the `__builtin_` spelling. A few
  (`__builtin_strlen`, `strcmp`, `strncmp`, `memcmp`, `abs` and its wider
  forms) additionally constant-fold on literal operands. The hints with no
  code-generation effect and the infinity / NaN constants stay macros in
  the bundled `_builtins.h`, which every translation unit includes.
- The `__sync_*` and `__atomic_*` families are recognized by prefix and
  lowered at the call site, so a spelling outside the C11 set above still
  compiles.
- `__FUNCTION__` / `__PRETTY_FUNCTION__` (alongside the C99 `__func__`).
- The GNU `# N "file"` line-marker shape (alongside C99 `#line N "file"`).
- Inline asm (`asm` / `__asm__`, a common extension listed in C99 Annex
  J.5.10) on both architectures: the basic form, the extended form
  `asm(template : outputs : inputs : clobbers)` with register, memory and
  immediate constraints, `asm goto`, `__attribute__((naked))` function
  bodies, and file-scope `asm(...)`. The same assembler stands behind
  `badc -c foo.S -o foo.o`. It accepts a substantial GAS subset -- enough
  that the demos boot interrupt handlers and context-switch coroutines
  through it, and that badc assembles most of the Linux kernel's `.S`
  units ([kernel work](linux-kernel.md) carries the counts). It is not a
  complete GAS implementation.
- The asm-label rename, `T name asm("label")`, on objects and functions at
  file and block scope. The label is the assembler symbol name the
  declaration emits, taken as written; the identifier keeps its own
  identity, so it stays the lookup key, the redeclaration match and the
  spelling every diagnostic uses. It composes with `extern`, `static`,
  `weak`, `alias` and the visibility attributes, and reaches the object
  writers, the linker and inline-asm references to the name. Two
  declarations of one identifier with different labels are rejected; a
  label on an automatic object is ignored with a warning, as it names no
  symbol.
- `__attribute__((...))` / `__declspec(...)` / C23 `[[...]]` decorators.
  The honored ones: `packed` (struct / union packing; an anonymous union
  inside a packed struct keeps its members overlapping), `aligned(N)` /
  `_Alignas`, `section(name)`, `alias(target)`, `visibility(kind)`
  (`hidden` / `internal` map to `STV_HIDDEN`), `weak`, `used`, `naked`,
  `always_inline`, `gnu_inline`, `ms_abi` / `sysv_abi` (the x86_64
  calling convention of a function or of a function pointer's pointee;
  x86-only, inert elsewhere, as in GCC),
  `cleanup(fn)` (the function runs on scope exit), `constructor` /
  `destructor` (run before / after `main`, optional priority), `noreturn`,
  `unused` / `maybe_unused`, `vector_size(N)` (modeled as an aggregate),
  and the MSVC `__declspec(thread)` / `dllexport`. Other attributes --
  `noinline`, `format`, `pure` / `const`, `deprecated`, `fallthrough`,
  `transparent_union` and the rest -- are parsed and silently discarded;
  there is no "attribute ignored" diagnostic. Two asymmetries are worth
  knowing: `__has_attribute` answers
  1 for a fixed list of GCC attribute names wider than the honored set
  (and 0 for the honored `vector_size` / `dllexport`), and the C23
  `[[...]]` syntax honors only the bare names plus `aligned`,
  `constructor` and `destructor`, so `[[gnu::section("x")]]` parses and is
  dropped while `__attribute__((section("x")))` takes effect.
- GCC named-rest variadic macro (`#define foo(args...)`).
- The GNU89 inline linkage model, per function via
  `__attribute__((gnu_inline))` and per unit via `-fgnu89-inline`: `extern
  inline` provides no external definition and a plain `inline` does, the
  inverse of C99 6.7.4p6. With `--gnu`, `__GNUC_STDC_INLINE__` or
  `__GNUC_GNU_INLINE__` reports which model is in force.
- `--gnu` additionally defines the GCC identity macros (`__GNUC__` 4,
  `__GNUC_MINOR__` 2, `__GNUC_PATCHLEVEL__` 1, `__VERSION__`),
  `__STRICT_ANSI__`, the `__GCC_HAVE_SYNC_COMPARE_AND_SWAP_{1,2,4,8}` set,
  and on x86_64 `__GCC_ASM_FLAG_OUTPUTS__`.

### MSVC-compatible

- `#pragma warning(push)` / `pop` / `disable : N` (and `enable` / `default`;
  `error` / `once` / `suppress` are recognized and do nothing), plus the
  Borland / Watcom `#pragma warn -N` form.
- `__pragma(...)`, the MSVC counterpart of `_Pragma`.
- `__COUNTER__` (also recognized by GCC), `__BASE_FILE__`.
- On Windows targets, `__int8` / `__int16` / `__int32` / `__int64`. The
  wider MSVC / MinGW mimicry surface (`_MSC_VER`, `__MINGW32__`, ...) is
  opt-in per translation unit with `-include msvc_compat.h`.
- On x86 targets, the SIMD intrinsic headers `<xmmintrin.h>`,
  `<emmintrin.h>`, `<tmmintrin.h>`, `<smmintrin.h>`, `<wmmintrin.h>` and
  `<immintrin.h>`, reached through `<x86intrin.h>`. They are
  compiler-owned and carry the SSE2 integer core plus a subset of SSSE3 /
  SSE4.1 / AES-NI / PCLMUL / RDRAND: each operation lowers to the
  instruction the SDM documents for it, over `__builtin_ia32_*` builtins
  with gcc's names. The SSE2 integer set covers the lane arithmetic,
  logic and compares, the packs and interleaves, the shifts, the
  shuffles, the element accesses and the sign mask, plus `__m128i_u` and
  the composition intrinsics (`_mm_set*`, `_mm_setr*`, `_mm_cvtsi*`, the
  casts) the header builds over the vector extension. Not carried: the
  packed-single and packed-double operations, the saturating and
  averaging integer arithmetic, the min / max / absolute-difference
  family, the shifts whose count is a vector rather than an integer, the
  non-temporal transfers, and everything above SSE4.1 (AVX, AVX2,
  AVX-512, FMA). An operation outside the subset is
  absent rather than emulated, so a unit needing one fails at the
  undeclared name. The forms whose last operand the instruction encodes
  as `imm8` are macros, as gcc's are without `-O`.

### c5-specific

- `#pragma dylib` / `#pragma binding` / `#pragma export` -- per-target
  loader symbol resolution and shared-library export. A struct passed to or
  returned by value from a bound import rides the host ABI like any other
  call.
- `#pragma intrinsic(<name>)` -- bind a library name to a badc-lowered
  intrinsic. This is how the bundled headers reach `sqrt`, `fma`, `alloca`
  and the C11 atomics.
- `#pragma entrypoint(<name>)` -- override the default `main` entry point
  (e.g. `WinMain`).
- `#pragma subsystem(<kind>)` -- the Windows PE optional-header `Subsystem`
  field; ignored on non-PE targets. Kinds: `console` / `cui`, `windows` /
  `gui`, `native` / `nt` / `driver`, and `efi_application`,
  `efi_boot_service_driver`, `efi_runtime_driver`, `efi_rom` (each also
  spelled with `-` and in upper case).
- `#pragma pack(N)` / `push` / `pop`, `#pragma GCC visibility push/pop`,
  and `#pragma once`.
- The C99 6.10.9 `_Pragma(<string-literal>)` operator, processed as the
  destringized `#pragma` directive (including via the `#x` stringize
  feeding `_Pragma(#x)`).
- `--interp` (SSA interpreter with pointer tracking), `--jit` (in-process),
  `--dump-ssa`.
- `-H` / `--show-includes` -- gcc-`-H`-shape `#include` resolution trace.
- The gcc `-M` dependency-output family: `-M`, `-MM`, `-MD`, `-MMD`,
  `-MF`, `-MT`, `-MQ`, `-MP`, and the `-Wp,-MD,<file>` / `-Wp,-MMD,<file>`
  spellings. `-MM` / `-MMD` omit system headers, which here means the
  compiler's own header set and the system fallback directories; a header
  from `-I`, `-iquote` or the including file's directory is a user header.
  A header served from the in-binary set has no filesystem path and is
  omitted from the prerequisite list.
- The `__has_include`, `__has_include_next`, `__has_builtin` and
  `__has_attribute` operators. `__has_feature` is not implemented.
- An unknown preprocessor directive is a *warning*, not a fatal error, so
  legacy sources keep compiling; clang / gcc treat it as fatal. A missing
  `#include` file is an error, as in clang / gcc. An unknown `#pragma`
  likewise warns, except that the `pack`, `once`, `STDC`, `GCC` and `clang`
  heads are accepted silently.
- `__BADC_VERSION__`, `__BADC_TARGET__`, `__BADC_WINDOWS__` predefines.
- Extension: a `#if` / `#elif` controlling expression accepts string-literal
  operands to `==` / `!=` (e.g. `#if __BADC_TARGET__ == "macos-aarch64"`,
  `#if __BADC_VERSION__ == "0.1.0"`). C99 6.10.1p4 restricts `#if` to an
  integer constant expression; c5 permits string equality so the
  string-valued `__BADC_TARGET__` / `__BADC_VERSION__` predefines can gate
  source. Strings remain rejected in every other operator context.

## Roadmap

1. Volatile-marked whole-aggregate copies (scalar volatile accesses are
   enforced; a volatile struct assignment's block copy is not marked).
2. x86_64 Windows UNWIND_INFO describes only the frame-pointer prologue
   (RIP/RSP/RBP recover exactly); callee-saved GPR spills are not yet
   described, so a debugger / profiler / SEH unwind crossing such a frame
   does not recover those registers. Program execution is unaffected --
   badc emits no exception-using code. A faithful description needs a
   push-before-setframe prologue restructure.
3. Thread-local storage on the Mach-O target.
4. Rejecting, then implementing, a call through a variable whose pointee
   returns a function pointer.
