# Standard conformance

badc implements C17 (ISO/IEC 9899:2018, C11 with its corrections). Without
`-std=` it compiles C17: `__STDC_VERSION__` is `201710L`. `-std=` selects C90,
C99 or C11 instead, or C23, of which badc implements part. Where this document
says nothing, badc follows C17. It records:

- the implementation-defined choices badc makes;
- the divergences, where badc departs from C17, or from gcc and clang where
  the standard leaves the choice open;
- the C11 features badc implements, and its extensions: C23 features, POSIX
  interfaces, and the GCC, MSVC and badc-specific ones.

## Contents

- [Implementation-defined choices](#implementation-defined-choices)
  - [Types and sizes](#types-and-sizes)
  - [`long double`](#long-double)
  - [Floating-point contraction](#floating-point-contraction)
  - [`_Atomic` objects](#_atomic-objects)
  - [Standard predefined macros](#standard-predefined-macros)
  - [Translation and the library](#translation-and-the-library)
- [Divergences](#divergences)
  - [Features not implemented](#features-not-implemented)
  - [An inline definition serves the calls of its unit](#an-inline-definition-serves-the-calls-of-its-unit)
  - [gcc options badc does not implement are refused](#gcc-options-badc-does-not-implement-are-refused)
  - [ELF imports take their versions from a pinned manifest](#elf-imports-take-their-versions-from-a-pinned-manifest)
  - [Argument passing the ABI documents leave open](#argument-passing-the-abi-documents-leave-open)
- [Command-line compatibility](#command-line-compatibility)
- [Extensions implemented](#extensions-implemented)
  - [C11 and C23](#c11-and-c23)
  - [POSIX](#posix)
  - [GCC](#gcc)
  - [Intrinsic headers](#intrinsic-headers)
  - [MSVC](#msvc)
  - [badc-specific](#badc-specific)
- [Roadmap](#roadmap)

## Implementation-defined choices

### Types and sizes

Each target follows its platform ABI: LP64 on macOS and Linux, LLP64 on
Windows (C99 6.2.5, 6.7.2). Sizes are in bytes, and the `__SIZEOF_*__`
predefines report the same values.

| type          | macos-aarch64 | linux-x64 | linux-aarch64    | windows-x64, windows-arm64 |
|---------------|---------------|-----------|------------------|----------------------------|
| `char`        | 1, signed     | 1, signed | 1, unsigned      | 1, signed                  |
| `short`       | 2             | 2         | 2                | 2                          |
| `int`         | 4             | 4         | 4                | 4                          |
| `long`        | 8             | 8         | 8                | 4                          |
| `long long`   | 8             | 8         | 8                | 8                          |
| pointer       | 8             | 8         | 8                | 8                          |
| `float`       | 4             | 4         | 4                | 4                          |
| `double`      | 8             | 8         | 8                | 8                          |
| `long double` | 8             | 16        | 16               | 8                          |
| `wchar_t`     | 4, `int`      | 4, `int`  | 4, `unsigned int`| 2, `unsigned short`        |

The signedness of plain `char` (C99 6.2.5p15) follows the platform C ABI.
`__CHAR_UNSIGNED__` is defined where `char` is unsigned, and the signedness
decides how a `char` value widens. `-funsigned-char` and `-fsigned-char`
override it. `-fshort-wchar` makes `wchar_t` a 2-byte `unsigned short`, as in
gcc.

Byte order is little-endian on every target: `__BYTE_ORDER__` is
`__ORDER_LITTLE_ENDIAN__` and `__LITTLE_ENDIAN__` is defined.

### `long double`

`long double` is stored in the format of the target ABI; C99 6.2.5p10 allows
any format at least as wide as `double`. `sizeof`, `_Alignof`, struct offsets,
array stride, static initializers, `<float.h>` and the `__LDBL_*` and
`__SIZEOF_LONG_DOUBLE__` predefines all follow it:

| target                                    | format              | size / align |
|-------------------------------------------|---------------------|--------------|
| linux-x64                                 | x87 80-bit extended | 16 / 16      |
| linux-aarch64                             | IEEE binary128      | 16 / 16      |
| macos-aarch64, windows-x64, windows-arm64 | IEEE binary64       | 8 / 8        |

An object has the platform's layout and encoding, so a struct, an array or a
`.data` object shared with code built by the platform toolchain agrees byte for
byte. A load converts the stored value to binary64, and a store converts it
back exactly. On linux-x64 the conversions are `fld` and `fstp`, which match
the hardware bit for bit, noncanonical encodings included. linux-aarch64 has
no quad-precision unit; there the conversions are inline integer sequences
that match gcc's `__extenddftf2` and `__trunctfdf2` bit for bit.

Calls follow the platform convention, so the type crosses calls to code built
by the platform toolchain, `printf("%Lf", x)` and `strtold` included:

- System V AMD64 passes a `long double`, and an aggregate whose only member is
  one, in memory as its x87 image, 16-byte aligned, fixed or variadic. It
  returns one in `st(0)`.
- AAPCS64 passes and returns binary128 in a whole vector register, fixed or
  variadic. An aggregate of up to four is a homogeneous floating-point
  aggregate.

**Precision.** badc computes `long double` arithmetic in binary64 on every
target. A value that needs more than 53 significand bits does not round-trip:
`(unsigned long long)(long double)((1ULL<<53)+1)` loses the low bit, which gcc
and clang keep on linux-x64 and linux-aarch64. The stored object has the full
significand of its format, but a value that went through arithmetic is already
rounded to binary64. A `<float.h>` constant outside binary64's range, such as
`LDBL_MAX` on linux-x64 and linux-aarch64, evaluates to infinity. On Linux,
`<math.h>` binds C99 7.12's `l` functions to libm's `l` entry points: the
library computes in the full format, and the caller rounds the result to
binary64 when it reads it.

### Floating-point contraction

`#pragma STDC FP_CONTRACT` is on by default (C99 6.5p8, 7.12.2). Under `-O`,
badc fuses a multiply with the add or subtract that uses it into one fused
multiply-add when both are in one expression and the pragma is on. Without
`-O` nothing is fused. `-ffp-contract=off` disables fusion.
`-ffp-contract=fast` ignores the pragma and also fuses across expressions when
the product has no other use.

`#pragma STDC FENV_ACCESS` and `#pragma STDC CX_LIMITED_RANGE` are accepted
and have no effect.

The relational operators `<`, `>`, `<=` and `>=` on floating operands raise
`FE_INVALID` for an unordered operand, as IEC 60559's signaling predicates do
(C99 F.3) and gcc's code does; `==`, `!=` and the 7.12.14 comparison macros
are quiet, raising it only for a signaling NaN.

### `_Atomic` objects

`_Atomic` qualifies a type (C17 6.7.2.4, 6.7.3), so `_Atomic int` and `int`
are different types: a pointer to one does not convert to a pointer to the
other without a cast, as under gcc and clang. Reading an `_Atomic` object,
assigning to it, `++`, `--` and compound assignment are seq_cst atomic
operations (C17 6.2.6.1p9, 6.5.2.4p2, 6.5.16.2p3). They take the lowering of
the `<stdatomic.h>` functions ([C11 and C23](#c11-and-c23)):

- An object of 1, 2, 4 or 8 bytes, a structure included, is aligned to its
  size. A read is a load (`mov` on x86-64, `ldar` on AArch64) and an assignment
  a store (`xchg`, `stlr`). `++`, `--`, `+=`, `-=`, `&=`, `|=` and `^=` on an
  integer or a pointer are one locked instruction or one LSE instruction. Any
  other update is a compare-exchange retried after a load: `*=`, `/=`, `%=`, a
  shift, a floating object, a `_Bool`, and an operation carried out in a
  floating type.
- An object of 16 bytes takes the paired compare-exchange (`cmpxchg16b`,
  `casp`) on Linux and macOS.
- Other sizes take the layout and the access of the target's system compiler.
  The layout follows when the type is complete; `sizeof` and `_Alignof` report
  it.

  | target | layout | access |
  |---|---|---|
  | Linux (gcc) | the type's size and alignment | `__atomic_load`, `__atomic_store`, `__atomic_exchange` and `__atomic_compare_exchange`, gcc's and clang's generic functions. A libatomic on the link line supplies them, or else badc's runtime does: it holds one of 1024 spin locks, chosen by the object's address, around each copy |
  | macOS (clang) | a size below 16 rounds up to a power of two, which the instructions above access; a larger one keeps its size | above 16 bytes, as on Linux |
  | Windows (MSVC) | `round_up(n, 4) + 4` bytes aligned to at least 4: a 4-byte lock word follows the value, as in `struct { T v; int lock; }`. 16 bytes take this layout too | the code badc emits spins on the lock word |

A unit compiled with `-ffreestanding` or `-fno-hosted` takes the Windows
layout and access on every target, so a freestanding image needs no runtime
function for its atomic objects. A freestanding unit and a hosted one lay out
such an object differently and cannot share it. MSVC does not document the
values of its lock word, so an `_Atomic` object of a size other than 1, 2, 4
or 8 bytes cannot be shared with code MSVC compiled.

A lock word starts clear in a static object (zero-initialized), an automatic
object, a compound literal and a parameter, and `atomic_init` clears it
without taking it, so an object in allocated storage becomes valid through
`atomic_init` (C17 7.17.2.2). A copy of an atomic object's bytes, by `memcpy`
or by assigning a structure holding one, copies its lock word, which is clear
unless another thread holds the lock during the copy. No array type and no
bit-field is `_Atomic`. A member of an atomic structure or union is not
accessed atomically (C17 6.5.2.3p5); badc refuses the access, as clang does.

### Standard predefined macros

| macro                                   | value                                                                     |
|-----------------------------------------|---------------------------------------------------------------------------|
| `__STDC__`                              | `1`; undefined under `--msvc`                                             |
| `__STDC_HOSTED__`                       | `1`; `0` under `-ffreestanding` or `-fno-hosted`, and `-fhosted` restores `1` |
| `__STDC_VERSION__`                      | `201710L`; `-std=` selects another ([Command-line compatibility](#command-line-compatibility)) |
| `__DATE__`, `__TIME__`                  | the time of translation in UTC; `SOURCE_DATE_EPOCH` fixes it |
| `__STDC_NO_COMPLEX__`, `__STDC_NO_THREADS__` | `1`                                                                  |
| `__STDC_UTF_16__`, `__STDC_UTF_32__`    | `1`                                                                       |
| `__STDC_IEC_559__`                      | not defined                                                               |
| `__STDC_NO_ATOMICS__`, `__STDC_NO_VLA__` | not defined; `1` under `--msvc`                                          |

`-ffreestanding` also implies `-fno-builtin`. `--freestanding`, the link
option that leaves out the startup runtime, does not change
`__STDC_HOSTED__`. `__STDC_NO_ATOMICS__` is undefined: `_Atomic` objects are
atomic ([`_Atomic` objects](#_atomic-objects)). Under `--msvc` it and
`__STDC_NO_VLA__` are `1`, as cl's C17 mode defines them.

### Translation and the library

- Trigraphs (5.2.1.1) are replaced under an ISO dialect before C23
  (`-std=c89` through `-std=c17`, `-std=iso9899:*`) and under `-trigraphs` or
  `-ftrigraphs`; `-fno-trigraphs` turns them off. The default dialect, the
  GNU dialects and C23, which removed them, keep `??` sequences as written.
- `MB_LEN_MAX` is the C library's: 16 on Linux, 6 on macOS, 5 on Windows.
- `<uchar.h>` (7.28) on every target. glibc defines its conversions; on macOS
  and Windows badc's runtime defines them over `mbrtowc` and `wcrtomb`. A
  character outside the Basic Multilingual Plane has no multibyte form on
  Windows, whose code pages hold none.
- `timespec_get` with `TIME_UTC` (7.27.2.5), `quick_exit` and `at_quick_exit`
  (7.22.4.3, 7.22.4.7) on every target, from badc's runtime on Windows.
- `aligned_alloc` (7.22.3.1) on every target. On Windows it takes the
  alignments up to 16, those msvcrt's `malloc` provides and `free` releases;
  a wider one fails with `EINVAL`, as 7.22.3.1p3 allows.

## Divergences

### Features not implemented

- The optional complex types (6.10.8.3): `_Complex`, `_Imaginary` and
  `<complex.h>`. `__STDC_NO_COMPLEX__` is `1`.
- The optional `<threads.h>` (7.26): `__STDC_NO_THREADS__` is `1`.
  `_Thread_local` is implemented.
- Most of C23. `-std=c23` sets the version macro and makes `bool`, `true` and
  `false` keywords, and the C23 features under [C11 and C23](#c11-and-c23) are
  available in every dialect. Not implemented: `nullptr`, `constexpr`, `auto`
  type inference, `_BitInt`, `#elifdef` and `#elifndef`,
  `__has_c_attribute`, digit separators, `u8` character constants, the
  `alignas`, `alignof` and `thread_local` keywords, a label before a
  declaration, `unreachable`, one-argument `va_start` and `<stdbit.h>`.

In the same areas, these are implemented: digraphs (C99 6.4.6); universal
character names in literals (6.4.3) and in identifiers, where 6.4.2.1 limits
them to the Annex D ranges and the UTF-8 spelling of a character names the
same identifier; and K&R identifier-list function definitions (6.11.7). A call to a `_Noreturn`
function ends control flow for the reachability analysis behind
`-Wreturn-type` (B3003), which reports a non-`void` function other than `main`
that can reach its end. That warning is off by default and enabled by `-Wall`;
clang enables its counterpart by default.

### An inline definition serves the calls of its unit

This applies to the ELF and Mach-O targets. A function whose file-scope
declarations all say `inline` and none says `extern` has an inline
definition, which provides no external definition (C99 6.7.4p7), and badc
emits none. gcc and clang without optimization leave a call to such a function
undefined, for another unit's external definition to satisfy. badc gives the
body internal linkage and binds the unit's calls to it, which 6.7.4p7 permits.
Taking the address, with `&f` or by passing `f`, still references the external
symbol, so the link fails when no unit defines it. The
PE targets use MSVC's inline linkage instead ([MSVC](#msvc)).

### gcc options badc does not implement are refused

badc implements a subset of gcc's options and has no list of options it
accepts and ignores. Any other option is an error. Options that fail this way
include `-static`, `-nostdlib`, `-fno-common`, `-fomit-frame-pointer`, `-pipe`
and `-march=native`. A build that passes another compiler's full flag set has
to filter it. [Command-line compatibility](#command-line-compatibility) lists
the options badc accepts with a narrower meaning than gcc's.

### ELF imports take their versions from a pinned manifest

A GNU linker takes each import's symbol version from the shared library on its
link path, so the image depends on the C library of the build machine. badc
reads the versions from `libc/versions/elf-<arch>.txt` instead. Each entry is
the newest version at or below a glibc 2.17 floor, or the symbol's oldest
version where the floor predates it. `libc/versions/minimums.txt` lists the
symbols whose floor definition behaves differently from the current one,
states which interface the bundled headers declare, and raises the version
where only the newer definition implements it. A library named with `-l`
supplies its own version data, so `-L <sysroot>/lib -lc` takes that sysroot's
versions on any host. An import the manifest gives no version stays
unversioned.

### Argument passing the ABI documents leave open

In the cases below the ABI document gives no rule, and gcc and clang place the
value differently. badc follows one of them, so a call to or from code built by
the other compiler finds the value in a different place. The Microsoft x64
convention places each of these shapes by size and is not affected.

**System V AMD64: an unnamed bit-field is classified INTEGER.** The psABI
(3.2.3) does not say whether an unnamed bit-field takes part in classifying an
eightbyte. badc follows gcc. In a structure, the bytes a non-zero width spans
are INTEGER. In a union, the leading bytes its width spans are, and a zero
width covers the first byte. An anonymous member's unnamed bit-fields count at
the member's offset. clang gives an unnamed bit-field no class:

| argument                                         | badc and gcc                                              | clang                                         |
|--------------------------------------------------|-----------------------------------------------------------|-----------------------------------------------|
| `struct { int :32; int :32; double d; }`         | first eightbyte in `rdi`, `d` in `xmm0`, next integer in `rsi` | `d` in `xmm0`, next integer in `rdi`     |
| `struct { float a; int :8; float b; }`           | eightbyte of `a` in `rdi`, `b` in `xmm0`, next integer in `rsi` | `a` in `xmm0`, `b` in `xmm1`, next integer in `rdi` |
| `union { int :0; double d; }`                    | `rdi`                                                     | `xmm0`                                        |
| `struct { char c[5]; union { int :24; char x; } u; float f[2]; }` | memory                                   | `rdi` and `xmm0`                              |

The last row comes from the union: gcc types a union's bit-field, named or
not, as the narrowest integer mode that holds its width, and an aggregate whose
union sits off that mode's alignment is MEMORY class. AAPCS64 passes these
structures in general-purpose registers under either compiler.

**System V AMD64: a misaligned member past an array's first element.** The
psABI sends an aggregate with an unaligned field to memory without saying how
array elements count. badc follows gcc, which examines an array's first
element only: `struct { struct __attribute__((packed)) { int x; char c; } a[2]; }`
passes in `rdi` and `rsi`. clang finds `a[1].x` at offset 5 and passes the
structure in memory.

**System V AMD64: a floating-point vector of one element.** The psABI classes
`__m64`, `__m128` and the wider vector types. A `float` or `double` vector of
its own width is none of them. badc follows gcc: such a vector is MEMORY class,
alone or as a member of a struct, union or array, so it is passed on the stack
and returned through the pointer the caller passes in `rdi`. clang passes the
`float` vector, and a struct holding it, in a general-purpose register, and
returns a lone `double` vector in `xmm0`. The compilers therefore disagree on
`float __attribute__((vector_size(4)))`, alone or in an aggregate, as an
argument or a result, and on a lone `double __attribute__((vector_size(8)))`
result. AAPCS64 passes a struct holding the `float` vector in general-purpose
registers and the `double` vector in `d0` under either compiler.

**AAPCS64: a vector narrower than 8 bytes.** AAPCS64 (6.4.2) defines short
vectors of 8 and 16 bytes and has no rule for a narrower one. badc follows
clang on every AArch64 target. Such a vector is passed as a 32-bit integer: in
the low word of the next general-purpose register, else in the stack slot an
`int` takes, which is 4 bytes at a 4-byte boundary for a named argument on
macOS and 8 bytes elsewhere. It is returned in `v0`.
`float __attribute__((vector_size(4)))` and a one-element vector occupy the
low bytes (`s0`, `h0` or `b0`). A vector of several integer elements has each
element widened to an equal lane of `d0`: 16-bit lanes for four `char`s,
32-bit lanes for two `short`s or two `char`s. gcc on Linux passes the `float`
vector, and the arguments after it, on the stack, and returns it and the
integer vectors in `w0`. A struct holding such a vector is passed in
general-purpose registers under either compiler.

## Command-line compatibility

badc accepts these gcc options with a narrower meaning than gcc's:

| options | what badc does |
|---------|----------------|
| `-O1`, `-O2`, `-O3`, `-Os`, `-Oz`, `-Ofast`, `-Og` | Select badc's one optimization level, as `-O` does. `-O0` turns it off. |
| `-g`, `-g1` to `-g3`, `-ggdb`, `-ggdb0` to `-ggdb3` | Select badc's one level of debug information. |
| `-gdwarf`, `-gdwarf-<n>`, `-gdwarf32`, `-gdwarf64`, `-gstrict-dwarf`, `-gno-strict-dwarf` | badc writes DWARF version 4 in the 32-bit format. A request for another version from 2 to 5, or for the 64-bit format, is reported as `dwarf-output` (B7011) with what is written instead, and the compile continues. A version outside 2 to 5, a level above 3 or a non-integer version is refused with gcc's message. |
| `-gsplit-dwarf`, `-gz`, `-gline-tables-only` | Refused. |
| `-mcpu=<part>[+ext...]` | AArch64 only. The part must be one badc knows. It selects no scheduling model, and the instructions stay the [baseline](./native-compilation.md#instruction-set-baseline). `+aes`, `+sha2` and `+crypto` define the `__ARM_FEATURE_*` macros as gcc does. |
| `-Wa,<opt>`, `-Xassembler <opt>` | Checked against the built-in assembler. `-L` and `--keep-locals` keep the local labels in the symbol table, as GNU as does. `--fatal-warnings`, `-mrelax-relocations=`, `--noexecstack`, `--no-warn-rwx-segments` and `-march=` are accepted and change nothing, because the assembler already behaves that way; `-march=` does not reject instructions above a lower ceiling. Any other option is refused as `unsupported assembler option`. |

**Warnings.** `-w`, `-Werror`, `-Wno-error`, `-Werror=<sel>`,
`-Wno-error=<sel>`, `-W<sel>`, `-Wno-<sel>`, `-Wall`, `-Wextra` and
`-Wpedantic` are implemented. A selector is a diagnostic's name, one of its
aliases, its `B` code or a group name; `--list-diagnostics` prints the
catalogue. A gcc or clang warning badc does not implement is accepted and
reported as `unimplemented-warning-option` (B7012). `-Wno-` takes any name, as
in gcc. Any other selector is refused.

`#pragma GCC diagnostic`, `#pragma clang diagnostic` and MSVC's
`#pragma warning(...)` take the same selectors. Each sets a diagnostic's level
from the position it appears at, for preprocessor and parser diagnostics
alike. A pragma that covers a position overrides the command line, and `push`
and `pop` bound the region it covers. A link diagnostic has no source
position, so only the command line controls it.

**Dialects.** `-std=` takes the dialect names gcc 16 takes and refuses any
other. It sets `__STDC_VERSION__` as gcc does:

| `-std=`                                                       | `__STDC_VERSION__` |
|---------------------------------------------------------------|--------------------|
| `c89`, `c90`, `gnu89`, `gnu90`, `iso9899:1990`                | not defined        |
| `iso9899:199409`                                              | `199409L`          |
| `c99`, `c9x`, `gnu99`, `gnu9x`, `iso9899:1999`                | `199901L`          |
| `c11`, `c1x`, `gnu11`, `gnu1x`, `iso9899:2011`                | `201112L`          |
| `c17`, `c18`, `gnu17`, `gnu18`, `iso9899:2017`, `iso9899:2018`; the default | `201710L` |
| `c23`, `c2x`, `gnu23`, `gnu2x`, `iso9899:2024`                | `202311L`          |
| `c2y`, `gnu2y`                                                | `202500L`          |

From `c23` on, `bool`, `true` and `false` are keywords, `1` and `0` in `#if`
as well, and `<stdbool.h>` defines only `__bool_true_false_are_defined`. An
empty parameter list declares no parameters, as `(void)` does (C23
6.7.7.4p13), and an identifier list is an error, C23 having removed K&R
function definitions. The
GNU extensions are available in every dialect. `__STRICT_ANSI__` is defined
only under `--gnu` ([GCC](#gcc)): a `gnu*` name leaves it undefined, and a
`c*` or `iso9899:*` name defines it. With `--gnu` and no
`-std=`, `__STRICT_ANSI__` is defined, so a header takes its standard-C path
for the GNU features badc lacks. The editions before C99 (`c89`, `c90`,
`gnu89`, `gnu90`, `iso9899:1990`, `iso9899:199409`) select the GNU89 inline
model, as gcc's do; `-fgnu89-inline` and `-fno-gnu89-inline` override the
edition. In them a declaration without a type specifier takes `int` (C90
6.5.2) and a call to an undeclared function declares it as
`extern int f();` (C90 6.3.2.2), unless the auto-include retry finds a
bundled header that declares it; `-Wall` reports both, as in gcc.

## Extensions implemented

### C11 and C23

- `_Static_assert`, C23's `static_assert` spelling and its form without a
  message, at file and block scope. The condition is a full C99 6.6 constant
  expression, floating casts and arithmetic included.
- `_Generic` (C11 6.5.1.1).
- Anonymous structure and union members (C11 6.7.2.1p13).
- `_Alignas`, `_Alignof`, `<stdalign.h>`, `_Noreturn` and `<stdnoreturn.h>`.
- `typeof` and `typeof_unqual` (C23 6.7.2.5), also spelled `__typeof__`,
  `__typeof`, `__typeof_unqual__` and `__typeof_unqual`. `typeof_unqual`
  removes the qualifiers of the type itself: a pointee keeps its qualifiers,
  and array elements lose theirs.
- `bool`, `true` and `false` as keywords under `-std=c23` and later (C23
  6.4.1).
- The `u8` string prefix (C11 6.4.5p2), alongside `L`, `u` and `U`. A
  universal character name encodes as UTF-8 in a narrow literal and as its
  code point in a wide one.
- Binary integer constants `0b...` and `0B...` (C23), with the same suffixes as
  hexadecimal and decimal ones.
- C23 `[[...]]` attributes; [GCC](#gcc) lists which take effect.
- `_Thread_local` and the GNU `__thread`, at file and block scope, on every
  target. `--jit` refuses them. A block-scope `static _Thread_local` has one
  instance per thread. A thread-local object takes the initializers of an
  object with static storage duration (C11 6.7.9): arrays, a deferred size,
  structures, string literals and address constants, but not a label address.
  - ELF: the objects are in `.tdata` and `.tbss` with `STT_TLS` symbols. An
    object whose image is all zeros goes to `.tbss` even when it has an
    initializer, as gcc places it. TLS relocations let a badc object link
    against external TLS through the system linker.
  - PE: the image carries an `IMAGE_TLS_DIRECTORY64`.
  - Mach-O: each variable has a `__DATA,__thread_vars` descriptor whose getter
    dyld binds to libSystem's `__tlv_bootstrap`. The per-thread image is
    `__thread_data`, or `__thread_bss` when no variable has an initializer.
    libSystem is linked when nothing else pulls it in.
- C11 7.17 atomics through `<stdatomic.h>`. The generic functions are macros:
  the `_explicit` forms and the fences map to the `__atomic_*` builtins, and
  the other forms to the `_explicit` ones with seq_cst order, so they work
  under `-fno-builtin` and `-ffreestanding`. On an `_Atomic` object of any type an operation
  takes the access the operators do ([`_Atomic` objects](#_atomic-objects)).
  On another object, the object is a scalar of 1, 2, 4 or 8 bytes, or a 16-byte
  integer. An object in a named address space is rejected at compile time.
  Each operation carries the order it names
  (7.17.1). `consume` is treated as acquire. An order the operation may not
  take (7.17.7.1p2, 7.17.7.2p2), or one that is not a constant, is treated as
  seq_cst. `atomic_fetch_add` and `atomic_fetch_sub` on an atomic pointer move
  it by whole pointees, as `+` and `-` do; the GNU `__atomic_fetch_add` and
  `__atomic_fetch_sub` keep their byte operand.
  `atomic_compare_exchange_weak` is the strong form. `atomic_flag` is
  a byte, and `atomic_init` is a plain store that clears the object's lock
  word without taking it (7.17.2.2). The optimizer does
  not forward, merge, hoist or remove an atomic access.

  | operation                               | x86-64                                   | AArch64                                    |
  |-----------------------------------------|------------------------------------------|--------------------------------------------|
  | load                                    | `mov`                                    | `ldr` relaxed, `ldapr` acquire, `ldar` seq_cst |
  | store                                   | `mov` relaxed or release, `xchg` seq_cst | `str` relaxed, `stlr` release or seq_cst  |
  | `fetch_add`, `fetch_sub`                | `lock xadd`                              | `ldadd`                                    |
  | `fetch_and`, `fetch_or`, `fetch_xor`    | `lock cmpxchg` loop                      | `ldclr`, `ldset`, `ldeor`                  |
  | `exchange`                              | `xchg`                                   | `swp`                                      |
  | `compare_exchange`                      | `lock cmpxchg`                           | `cas`                                      |
  | any 16-byte operation                   | `lock cmpxchg16b`                        | `casp`                                     |
  | `atomic_thread_fence`                   | `mfence` for seq_cst; acquire and release are compiler barriers | `dmb ishld` for acquire, `dmb ish` otherwise |

  On AArch64 the read-modify-write instructions carry the acquire and release
  bits of the order. A relaxed fence emits nothing (7.17.4.1p4), and
  `atomic_signal_fence` is a compiler barrier on both architectures.

### POSIX

On macOS and Linux the bundled headers declare the platform C library's POSIX
interfaces, `<dlfcn.h>`, `<pthread.h>`, `<dirent.h>` and `<setjmp.h>` among
them. `struct dirent` has the host C library's layout, so `readdir` finds
`d_name` where the library writes it.

- `fseeko` and `ftello` take and return `long` rather than `off_t`; both are
  64 bits on every LP64 target. The Windows targets have `_fseeki64` and
  `_ftelli64` instead, as their C library does.
- On Linux, glibc's `malloc_usable_size` and `sighandler_t`.

On the Windows targets a header declares what mingw-w64's header of the same
name declares ([native-compilation.md](native-compilation.md#headers-and-bindings)
states the rule). Sources in `libc/lib/` define the POSIX names mingw-w64
declares and msvcrt.dll does not, over kernel32, msvcrt and ucrtbase:

| header | names |
|--------|-------|
| `<time.h>`, `<sys/time.h>` | `clock_gettime`, `clock_getres`, `clock_settime` and `clock_nanosleep` with mingw-w64's clock ids; `nanosleep`; `gettimeofday`; `localtime_r`, `gmtime_r` and `ctime_r` under `_POSIX_C_SOURCE` |
| `<dlfcn.h>` | `dlopen`, `dlsym`, `dlclose`, `dlerror` |
| `<dirent.h>` | mingw-w64's: `opendir`, `readdir`, `closedir`, `rewinddir`, `telldir` and `seekdir` over the kernel32 file search, with its `struct dirent` (`d_name`, `d_namlen`). Under `msvc_compat.h`'s `_MSC_VER` it declares nothing, as cl ships none. |
| `<pthread.h>` | winpthreads' types and numbering: threads, mutexes (normal, recursive and error-checking), condition variables on either clock, once controls, thread-specific data and creation attributes. Thread-specific data destructors also run when a thread started with `CreateThread` exits, and none run at process exit. Cancellation, `pthread_kill` and the scheduling setters of a running thread are not declared. |
| `<semaphore.h>` | winpthreads': unnamed semaphores; `sem_open`, `sem_close` and `sem_unlink` fail with `ENOSYS` |
| `<getopt.h>`, `<unistd.h>` | libmingwex's `getopt`, `getopt_long` and `getopt_long_only` with their state (`getopt` stops at the first operand, the long forms permute); `sleep`, `usleep`, `ftruncate`, `truncate` |
| `<libgen.h>`, `<ftw.h>` | `basename` and `dirname`, which handle `\` and drive letters; `ftw` |
| `<stdlib.h>`, `<stdio.h>`, `<string.h>` | `mkstemp`, `mkdtemp`; `getline`, `getdelim`, `dprintf`, `vdprintf`; `strndup`, `memmem` |
| `<fnmatch.h>`, `<regex.h>`, `<search.h>` | `fnmatch`; `regcomp`, `regexec`, `regerror` and `regfree` (basic and extended syntax); `tsearch`, `tfind`, `tdelete`, `twalk`, `tdestroy` |
| `<fenv.h>` | `feraiseexcept` |

The CRT's `chmod`, `mktemp` and exec family are bound under their POSIX names.
`iswblank`, `wctype`, `wctrans` and `towctrans`, which msvcrt.dll lacks, are
bound to ucrtbase.dll. A POSIX name mingw-w64 does not declare is not
declared.

### GCC

- Statement expressions (`({ ... })`) and case ranges (`case a ... b:`).
- Labels as values: `&&label` and `goto *expr`, including `&&label` elements
  in an automatic or static array initializer. A static table is filled by
  stores at run time, since a label address is not a link-time constant. A
  computed goto runs the `cleanup` functions of the scopes it leaves when every
  label whose address is taken leaves the same ones, and is rejected otherwise.
  gcc runs none of them, and clang rejects the jump.
- Array range designators (`[a ... b] = value`).
- Zero-length arrays (`T x[0]`) as flexible array members.
- `__int128` and `unsigned __int128`; `__SIZEOF_INT128__` is 16.
- The x86-64 named address spaces `__seg_gs` and `__seg_fs`, which become a
  segment override on each access. AArch64 refuses them.
- The vector extension: `vector_size(N)` types with element-wise arithmetic,
  comparison and subscripting.
- Named variadic macro parameters (`#define f(args...)`).
- `__FUNCTION__` and `__PRETTY_FUNCTION__`, alongside C99's `__func__`.
- GNU line markers (`# N "file"`), alongside C99's `#line N "file"`.
- Pragmas: `#pragma pack(N)` with `push` and `pop`; `#pragma GCC visibility`
  `push` and `pop`; `#pragma weak name` and `#pragma weak alias = target`;
  `#pragma push_macro` and `pop_macro`; `#pragma once`.
- The GNU89 inline model, per function with `__attribute__((gnu_inline))` and
  per unit with `-fgnu89-inline` or an edition before C99: an `extern inline` definition provides no
  external definition and a plain `inline` one does, the reverse of C99
  6.7.4p7. With `--gnu`, `__GNUC_STDC_INLINE__` or `__GNUC_GNU_INLINE__` names
  the model in force.
- `--gnu`, off by default, defines the GCC identity macros: `__GNUC__` 4,
  `__GNUC_MINOR__` 3, `__GNUC_PATCHLEVEL__` 0 and `__VERSION__`, with
  `__GCC_HAVE_SYNC_COMPARE_AND_SWAP_{1,2,4,8,16}`, the
  `__GCC_ATOMIC_*_LOCK_FREE` set, `__GCC_ATOMIC_TEST_AND_SET_TRUEVAL` and, on
  x86-64, `__GCC_ASM_FLAG_OUTPUTS__`. `__STRICT_ANSI__` follows `-std=`
  ([Command-line compatibility](#command-line-compatibility)).

**Builtins.** These are available without a header:

- bit counting: `__builtin_clz`, `ctz`, `popcount`, `clrsb`, `parity` and
  `ffs`, each with `l` and `ll` forms;
- byte swapping: `__builtin_bswap16`, `32` and `64`;
- control: `__builtin_expect`, `__builtin_unreachable`, `__builtin_trap`,
  `__builtin_prefetch`, `__builtin_assume_aligned`;
- frame: `__builtin_frame_address`, `__builtin_return_address` (any constant
  level, by walking the frame-pointer chain), `__builtin_alloca`;
- variadic: `__builtin_va_list`, `__builtin_va_start`, `va_arg`, `va_end` and
  `va_copy`;
- compile-time queries: `__builtin_constant_p`, `__builtin_choose_expr`,
  `__builtin_types_compatible_p`, `__builtin_offsetof`,
  `__builtin_object_size`;
- checked arithmetic: `__builtin_add_overflow`, `sub` and `mul`;
- memory: `__builtin_memcpy`, `memmove` and `memset`.

`__builtin_clz(0)` and `__builtin_ctz(0)` return the operand width on every
target and in the interpreter; gcc leaves them undefined.
`__builtin_unreachable` becomes a trap instruction, so reaching it aborts.
`__builtin_has_attribute` is accepted and always yields 0.

The `__builtin_` spelling of a library function that gcc or clang provide as
the function itself calls the library function of that name. This covers the
stdio, stdlib, string, ctype, wide-character and math functions, among others.
The parser binds the call through the symbol table. The call takes the function's
declaration, a header the unit did not include is included as for the plain
name, and a macro of the library name in the unit, as fortified string headers
define, does not capture the builtin spelling. gcc's `__builtin_setjmp` and
`__builtin_longjmp`, which take a five-word buffer, are not provided.
`__builtin_isdigit`, `__builtin_isascii` and `__builtin_toascii` fold from
their operand as gcc folds them. `__builtin_strlen`, `strcmp`, `strncmp`,
`memcmp`, `abs` and its wider forms also fold with literal operands.
`__builtin_expect`, `__builtin_prefetch`, `__builtin_assume_aligned` and the
infinity and NaN constants are parsed at the call site with gcc's signatures
and operand checks, so they work in preprocessed input too. `__builtin_nan`
folds a string literal's payload as gcc does and calls `nan` for any other
operand.

The `__sync_*` and `__atomic_*` families are recognized by prefix and lowered
at the call site, so a name outside the C11 set also compiles. The memory
order of an `__atomic_*` call selects the instructions as for
`<stdatomic.h>`. `__sync_lock_release` is a release store,
`__sync_synchronize` a seq_cst fence, and the other `__sync_*` operations are
seq_cst.

**Inline assembly.** `asm` and `__asm__` (C99 J.5.10) on both architectures:
the basic form, the extended form `asm(template : outputs : inputs : clobbers)`
with register, memory and immediate constraints, `asm goto`,
`__attribute__((naked))` function bodies, and file-scope `asm(...)`. The same
assembler builds `.s` and `.S` files (`badc -c foo.S -o foo.o`). It implements
a subset of GNU as; [linux-kernel.md](linux-kernel.md) has coverage figures.
File-scope `asm(...)` belongs to no function: its text reaches the object as
written, and the assembler and linker resolve the names in it. Naming a
`static` definition there does not keep the definition; mark it
`__attribute__((used))`, as gcc requires at `-O2`. A `static` named in a
template inside a function body is kept.

Where the Intel SDM and GNU as encode an x86 instruction differently, badc
follows the SDM, and the operand width as written selects the encoding. Six
forms differ from GNU as. With a 64-bit register, `mov` to and from a segment
register (`8C`, `8E`), `sldt`, `str`, `lar` and `lsl` (`0F 00 /0`,
`0F 00 /1`, `0F 02`, `0F 03`) take the `REX.W` prefix, which GNU as omits and
clang emits. Both forms write 16 bits and zero the rest. `smsw` with a 64-bit
register keeps `REX.W` in GNU as too, and the control- and debug-register moves
take no prefix in either.

**Assembler names.** `T name asm("label")` on an object or a function, at file
or block scope, sets the assembler symbol name the declaration emits. The
identifier stays the lookup key, the redeclaration match and the name
diagnostics use. The label composes with `extern`, `static`, `weak`, `alias`
and the visibility attributes, and reaches the object writers, the linker and
inline-asm references to the name. Two declarations of one identifier with
different labels are rejected. A label on an automatic object is ignored with
a warning (`ignored-asm-label`). On ELF and PE the symbol is the label as
written. On Mach-O badc prefixes the label with the `_` it gives every C name,
where gcc and clang emit the label as written.

**Attributes.** `__attribute__((...))`, `__declspec(...)` and C23 `[[...]]`
attributes are parsed. These take effect:

| attribute | effect |
|-----------|--------|
| `packed` | Packs a structure or union. An anonymous union inside a packed structure keeps its members overlapping. |
| `aligned(N)`, `aligned`, `_Alignas` | Sets the alignment; bare `aligned` is 16. |
| `section("name")` | Places the object or function in that section. |
| `alias("target")` | Defines the name as an alias of `target`. |
| `visibility("kind")` | `default`, `hidden`, `protected` or `internal`, written to the ELF symbol. |
| `weak` | A weak definition or reference. On Mach-O a reference binds as a weak import, and the link fails when no input defines the name, as under ld64. |
| `weak_import` | Mach-O only: as `weak`. |
| `selectany` | The link keeps one unit's definition. |
| `used` | Keeps a definition nothing references. |
| `naked` | The function has no prologue or epilogue. |
| `always_inline`, `noinline`, `gnu_inline` | Inlining control. `always_inline` applies without `-O` too. |
| `ms_abi`, `sysv_abi` | The x86-64 calling convention of a function or of a function pointer's pointee. Ignored on AArch64. |
| `cleanup(fn)` | Calls `fn` on every exit from the scope, `goto` and `asm goto` included. A jump into the scope past the declaration is rejected, as clang does; gcc accepts it. |
| `constructor`, `destructor` | Runs the function before or after `main`, with an optional priority. |
| `noreturn` | As `_Noreturn`. |
| `unused`, `maybe_unused` | Silences the unused-entity warnings. |
| `vector_size(N)` | Makes a vector type. |
| `mode(M)` | The integer or floating type of machine mode `M`. |
| `transparent_union` | A parameter of the union type accepts an argument of any member's type. |
| `designated_init` | A positional initializer for the structure is diagnosed. |
| `no_instrument_function` | No `-pg` profiling call. |
| `no_stack_protector` | No stack canary under `-fstack-protector*`. |
| `uninitialized` | The automatic object is exempt from `-ftrivial-auto-var-init`. |
| `patchable_function_entry(N[,M])` | NOP padding at the function entry, as `-fpatchable-function-entry`. |
| `__declspec(thread)` | As `_Thread_local`. |
| `dllexport`, `dllimport` | PE targets: exports the definition; a dllimport reference reads the import-address slot `__imp_<name>`, as MSVC, mingw-w64 gcc and clang emit it. Elsewhere `dllimport` is ignored with a warning and `dllexport` without one. |

Other attributes, such as `format`, `pure`, `const`, `deprecated` and
`fallthrough`, are parsed and discarded without a diagnostic.
`__has_attribute` answers 1 for a fixed list of gcc attribute names wider than
the set above. It answers 0 for `vector_size`, `mode`, `ms_abi`, `sysv_abi`,
`selectany` and `weak_import`, although badc honours them, and for `dllexport`
and `dllimport` outside the PE targets. The `[[...]]` form honours
the attributes without arguments plus `aligned`, `constructor` and
`destructor`. It drops any other attribute with arguments, so
`[[gnu::section("x")]]` has no effect while `__attribute__((section("x")))`
does.

**Vector arguments.** A `vector_size(N)` value crosses a call in the SIMD
argument registers. The System V AMD64 psABI (3.2.3) classes a 16-byte vector
SSE and SSEUP and gives it one `xmm0`-`xmm7` register. AAPCS64 (6.4.2, stage
C.1) assigns a 64- or 128-bit short vector to `v0`-`v7`. A result is returned
in `xmm0` or `v0`. A variadic vector uses the same registers, counted in `al`
on System V and read back from the vector save area. Windows x64 passes a
16-byte vector by implicit reference, as its convention states, and macOS
arm64 puts variadic arguments on the stack, as its variant of AAPCS64 states.
On System V a vector wider than a register (32 bytes and up) goes to memory,
as gcc places it without `-mavx`; AAPCS64 passes it by reference. A
floating-point vector of one element also goes to memory on System V
([Divergences](#argument-passing-the-abi-documents-leave-open)). A struct of
two to four vectors of one width, an AAPCS64 homogeneous vector aggregate,
takes one of `v0`-`v7` per vector.

### Intrinsic headers

On the x86-64 targets the compiler's own headers provide a subset of the
Intel intrinsics, reached through `<x86intrin.h>` or `<immintrin.h>`. Most
operations lower to the instruction the Intel SDM gives for them, through
`__builtin_ia32_*` builtins with gcc's names. The composition intrinsics
(`_mm_set*`, `_mm_setr*`, `_mm_cvtsi*`), `_mm_loadl_epi64`,
`_mm_storel_epi64`, the 16-, 32- and 64-bit `_mm_loadu_si*` and
`_mm_storeu_si*`, the SSE3 floating operations, the `__m64` operations and the
256-bit integer subset are written lane by lane over the vector extension; the
`__m64` ones use no MMX register and the 256-bit ones no VEX instruction. An operation outside the subset is absent, so a unit that needs
one fails at the undeclared name.

| header | contents |
|--------|----------|
| `<mmintrin.h>` | MMX: gcc's `__m64` operations and their `_m_` names; `_mm_empty` executes `emms`. |
| `<xmmintrin.h>` | SSE: `__m128`, `_MM_SHUFFLE`, MXCSR access, `_mm_sfence`, `_mm_pause`, `_mm_prefetch` with the `_MM_HINT_*` hints, `_mm_and_ps`, `_mm_andnot_ps`, `_mm_or_ps`, `_mm_xor_ps` and the `__m64` operations. No packed-single arithmetic. |
| `<emmintrin.h>` | SSE2 on `__m128i`: add and subtract, saturating add and subtract, `_mm_sad_epu8`, `_mm_mullo_epi16`, `_mm_mulhi_epi16`, `_mm_madd_epi16`, logic, compares, packs, interleaves, immediate shifts, shuffles, element access, `_mm_movemask_epi8`, loads and stores; `_mm_set*`, `_mm_setr*` and `_mm_cvtsi*`; `_mm_shuffle_pd`; the `__m128`, `__m128i` and `__m128d` casts; the fences. |
| `<pmmintrin.h>` | SSE3: `addsub`, horizontal add and subtract, `lddqu`, the duplicating moves and loads, `monitor` and `mwait`. |
| `<tmmintrin.h>` | SSSE3: `_mm_shuffle_epi8`, `_mm_maddubs_epi16` and the `__m64` forms. |
| `<smmintrin.h>` | SSE4.1: `_mm_cmpeq_epi64`, `_mm_extract_epi32`, `_mm_insert_epi32`. |
| `<wmmintrin.h>` | AES-NI and `_mm_clmulepi64_si128`. |
| `<immintrin.h>` | The above; of AVX and AVX2, `__m256i` with its loads, stores, `_mm256_setzero_si256`, `_mm256_set1_*`, the broadcasts from `__m128i`, the 128-bit casts, extract and insert, logic, `_mm256_testz_si256`, add, subtract, `_mm256_cmpeq_*` and `_mm256_movemask_epi8`; `_rdrand16_step`, `_rdrand32_step`, `_rdrand64_step`, `_xgetbv`, `_tzcnt_u32`, `_tzcnt_u64`, `_mm_popcnt_u32` and `_mm_popcnt_u64`. |
| `<x86intrin.h>` | The above and the scalar set: byte swaps, bit scans, rotates, `rdtsc`, `rdtscp`, `rdpmc` and the RFLAGS access. |

Not provided: packed-single arithmetic, packed-double operations other than
`_mm_shuffle_pd` and the SSE3 ones, the 128-bit averaging, minimum and maximum
integer operations, shifts by a vector count,
the 128-bit non-temporal stores, and everything past SSE4.1 (AVX, AVX2,
AVX-512, FMA) but the 256-bit integer subset. `_mm_load_si128` and `_mm_store_si128` use the unaligned move.
An intrinsic whose last operand is an `imm8` is a macro, as gcc's are without
`-O`. The rest are `static inline` functions, which `-O` inlines so the
instruction appears at the call site; without `-O` they stay calls.

On the AArch64 targets `<arm_neon.h>` provides a subset of the ACLE NEON
intrinsics, and `<intrin.h>` includes it on windows-arm64 as MSVC's includes
its own NEON header. For the integer vectors: `vld1` and `vst1`, bitwise operations,
immediate shifts, `vdup`, the polynomial byte multiply, table lookups, byte
equality, halfword reversal, the across-lanes minimum and 64-bit lane
composition; the halfword broadcast and equality, the narrowing shift right,
the doubleword load, the integer lane reads and the reinterpretations between
lane widths. The FEAT_AES rounds and the 64-bit carry-less multiply. For
`float32x2_t`, `float32x4_t`, `float64x1_t` and `float64x2_t`: loads and
stores, arithmetic, square root, fused multiply-add, compares, `vbsl`,
conversions, lane access, `vget_low`, `vget_high`, `vcombine` and the
reinterpretations. Lane-indexed multiplies, rounding, estimates, structure
loads (`vld2` to `vld4`), float16 and bfloat16 are not provided.

### MSVC

- `#pragma warning(push)`, `pop`, `disable : N`, `enable`, `default`, `error`,
  `once` and `suppress`, with MSVC's meanings: `error` makes the diagnostic an
  error, `once` reports it once, and `suppress` covers the next line only. `N`
  is a `B` code or an MSVC warning number badc carries as an alias. The Borland
  and Watcom form `#pragma warn -N` is accepted too.
- `__pragma(...)`, MSVC's counterpart of `_Pragma`.
- Structured exception handling on the PE targets: `__try`, `__except`,
  `__finally`, `__leave`, and `GetExceptionCode`, `GetExceptionInformation`
  and `AbnormalTermination`, with cl's placement rules. A linked image carries
  scope tables for `__C_specific_handler`. A filter other than the constant
  `EXCEPTION_EXECUTE_HANDLER`, and a `__finally` block, are funclets that reach
  the function's objects through the frame the handler passes them; they nest
  inside a `__finally` block to any depth. A `__finally` block may allocate on
  its stack; a filter may not (cl's C2494). `longjmp` unwinds, running the
  `__finally` blocks it passes. The tables interoperate with cl's objects, and
  across a DLL boundary with cl's code in either module. cl for ARM64 rejects
  an `__except` inside a `__finally` block (C2702); badc accepts it there too.
  `--interp` and `--jit` refuse a `__try` region.
- `__COUNTER__` and `__BASE_FILE__`.
- `#pragma section("name", ...)` and `__declspec(allocate("name"))` on the
  PE targets: the object goes to the named section, as with GNU `section`, and
  the image keeps it under the name's first eight bytes.
- `#pragma comment(lib, "name")`, a default library, and on the PE targets
  `#pragma comment(linker, "options")`, link.exe options the object carries as
  cl's `.drectve` does: `/EXPORT:` (under another name, or forwarded as
  `name=dll.export`; `,DATA`), `/INCLUDE:`, `/DEFAULTLIB:`, `/alternatename:`
  and `/FAILIFMISMATCH:`. Elsewhere it warns and is ignored, as in clang.
- `<intrin.h>` on the Windows targets is the compiler's own, like the
  intrinsic headers: MSVC's include directory on the search path does not
  supply it, as clang's copy shadows MSVC's.
- MSVC's inline linkage on the PE targets, in place of C99 6.7.4p6-p7, as MSVC
  and clang's `*-windows-msvc` targets apply it to C. An inline function of
  external linkage without `gnu_inline` is emitted, as an
  `IMAGE_COMDAT_SELECT_ANY` definition, by each unit that references it and by
  no other; the link keeps one. A unit with a declaration that spells `extern`
  emits it even when nothing references it. `__inline`, `_inline` and
  `__forceinline` are keywords; `__forceinline` is `inline` with
  `always_inline`.
- On windows-x64 the string intrinsics `__stosb`, `__stosw`, `__stosd`,
  `__stosq`, `__movsb`, `__movsw`, `__movsd` and `__movsq` lower to `rep stos`
  and `rep movs`.
- The `_Interlocked` intrinsics are each one atomic instruction:
  `lock`-prefixed on x64, and the FEAT_LSE form on arm64, with the `_acq`,
  `_rel` and `_nf` orders. cl emits the LSE form under `/arch:armv8.1`; its
  default calls out-of-line helpers. `<windows.h>` maps winnt.h's Interlocked
  names onto them. The `_InterlockedMax`, `_InterlockedMin`,
  `_InterlockedUMax`, `_InterlockedUMin` and `_InterlockedNand` families are
  not provided.
- `__int8`, `__int16`, `__int32` and `__int64` on the Windows targets.
- `--msvc`, off by default and taken by the Windows targets only, gives the
  identity of cl 19.28, the first with `/std:c17`: `_MSC_VER` 1928,
  `_MSC_FULL_VER`, `_MSC_BUILD`, `_MSC_EXTENSIONS`, `_INTEGRAL_MAX_BITS` and
  `_M_X64` / `_M_AMD64` or `_M_ARM64`. `__STDC__` is then undefined, as cl
  leaves it without `/Zc:__STDC__`, so the SDK headers that test it take their
  Microsoft layouts; `__STDC_VERSION__` stays, and `__STDC_NO_ATOMICS__` and
  `__STDC_NO_VLA__` are `1`, as under cl's `/std:c17`. A tag a parameter
  list declares takes the enclosing scope, as cl gives it (warning C4115),
  where C17 6.2.1p4 limits it to the list. The Microsoft extensions above
  apply with or without it. `-include msvc_compat.h` adds the MinGW identity
  and the calling-convention and SAL no-ops.

### badc-specific

- `#pragma dylib`, `#pragma binding` and `#pragma export`: per-target loader
  symbol resolution, and the functions and objects a shared library exports. A
  struct passed to or returned from a bound import by value follows the
  platform ABI like any other call.
- `#pragma intrinsic(<name>)` binds a library name to an intrinsic badc
  lowers. The bundled headers reach `sqrt` and `fma` this way. Under
  `-fno-builtin` it binds only reserved names (7.1.3); `alloca` is a macro
  over `__builtin_alloca`, as in the glibc and macOS headers.
- `#pragma entrypoint(<name>)` replaces `main` as the entry point, for example
  with `WinMain`.
- `#pragma subsystem(<kind>)` sets the PE optional header's `Subsystem` field
  and is ignored on the other targets. `--subsystem=` takes the same kinds.
  Each is accepted in any case and with `-` for `_`:

  | kind | subsystem |
  |------|-----------|
  | `console`, `cui` | Windows console, the default |
  | `windows`, `gui` | Windows GUI |
  | `native`, `nt` | native, with the C runtime from ntdll.dll |
  | `driver` | native kernel-mode driver, with the C runtime from ntoskrnl.exe |
  | `efi_application`, `efi_boot_service_driver`, `efi_runtime_driver`, `efi_rom` | the EFI subsystems |

- `_Pragma(<string-literal>)` (C99 6.10.9) runs as the destringized
  `#pragma`, also when the `#x` stringize produces the operand
  (`_Pragma(#x)`).
- `--interp` runs the program in the SSA interpreter with pointer tracking,
  `--jit` lowers it in-process and calls `main`, and `--dump-ssa` prints the
  SSA. The interpreter implements a subset of the library; a call it has no
  implementation for is reported when the call is reached.
- `-H` and `--show-includes` print the include trace on stderr: one line per
  include, with leading dots for depth and the path the include resolved to.
  A header from the compiler's own in-binary set has no path and prints its
  name, and a repeated include that the guard or `#pragma once` dropped is
  marked `(cached)`.
- The `-M` dependency options: `-M`, `-MM`, `-MD`, `-MMD`, `-MF`, `-MT`,
  `-MQ`, `-MP`, and the `-Wp,-MD,<file>` and `-Wp,-MMD,<file>` spellings.
  `-MM` and `-MMD` leave out system headers: the compiler's own headers, the
  `-isystem` directories and the system fallback directories. A header from
  `-I`, `-iquote` or the including file's directory is a user header; the
  unused-binding warnings draw the same line. A header from the in-binary set
  has no file and is never a prerequisite.
- The `__has_include`, `__has_include_next`, `__has_builtin` and
  `__has_attribute` operators. `__has_feature` is not implemented.
- A directive name badc does not implement is an error in a group that is
  not skipped (`directive`, B1010), as in gcc and clang; `#ident` and `#sccs`
  are accepted without effect. A missing `#include` file is an error.
- C23 6.10.4 `#embed` is accepted in every edition, as gcc and clang accept
  it: the `limit`, `prefix`, `suffix` and `if_empty` parameters, gcc's and
  clang's `offset`, the `__has_embed` operator and the
  `__STDC_EMBED_NOT_FOUND__` / `__STDC_EMBED_FOUND__` / `__STDC_EMBED_EMPTY__`
  values. `#embed "..."` searches the including file's directory and then the
  `--embed-dir` directories; `#embed <...>` searches only the latter. An unknown `#pragma` warns
  too (`unknown-pragmas`, B1004), except that pragmas headed `pack`, `once`,
  `STDC`, `GCC`, `clang`, `region` or `endregion` are accepted silently.
- The predefines `__BADC_VERSION__` and `__BADC_TARGET__`, both string
  literals, on every target, and `__BADC_WINDOWS__` on the Windows targets.
- A `#if` or `#elif` condition accepts a string operand in one position: as an
  operand of `==` or `!=` whose other operand is also a string. The operand is
  a string literal, with any encoding prefix and its escapes left undecoded, or
  a macro that expands to one. The two strings compare by spelling, prefix
  excluded: `#if __BADC_TARGET__ == "macos-aarch64"`,
  `#if __BADC_VERSION__ != "0.1.0"`. C99 6.10.1p4 restricts `#if` to an integer
  constant expression; badc admits this comparison so the string-valued
  predefines can select source. A string anywhere else is an error naming the
  operator, whether or not that operand is evaluated: the whole condition, an
  operand of a unary, arithmetic, bitwise, shift, relational or logical
  operator, a `?:` condition or arm, or the other side of an integer in `==`
  or `!=`. Adjacent string literals do not concatenate. An identifier left
  after macro expansion is 0, as in C99.

## Roadmap

1. `long double` arithmetic at the precision of the target's storage format.
2. Structured exception handling under `--interp` and `--jit`.
3. ELF import versions for a named library: a link that names a real shared
   object (`-L <sysroot>/lib -lc`) takes that library's version data, so it can
   bind a definition whose interface differs from the one the bundled headers
   declare.
