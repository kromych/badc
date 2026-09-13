# Standard conformance

badc targets C99. Anything a C99 program relies on that is not listed here
follows C99; the standard is the reference for the conforming surface.
This document records three things: the implementation-defined choices C99
requires a compiler to make (6.2.5, 6.7.2), the divergences -- from C99,
and from gcc / clang practice where the standard leaves the choice open --
and the non-C99 extensions badc implements (C11, C23, POSIX, GCC, MSVC,
and badc's own).

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
badc follows the host C ABI: signed on x86_64 (all OSes), Apple
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
| windows-arm64   | IEEE binary64          | IEEE binary64  | 8 / 8        |

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
  fixed parameters are unaffected -- `<math.h>` binds the two `l` entry
  points it declares, `ldexpl` and `fabsl`, to their `double`
  counterparts, so the argument converts to a `double` parameter exactly
  and the ABI matches. The rest of C99 7.12's `l` family is not declared.
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

## Divergences

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
enforced: badc does not diagnose assignment to a `const`-qualified object (a
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
the function in the same translation unit"). That covers a call. A use of
the function designator as a value -- `&f`, or passing `f` -- still
references the external symbol, so a unit that takes the address and no
unit supplies the external definition fails at the link, as it does under
gcc and clang.

### `__STDC_HOSTED__` is always 1, severity 5

C99 6.10.8p3 defines `__STDC_HOSTED__` as 1 only for a hosted
implementation. badc defines it as 1 unconditionally, including under
`--freestanding` and `-ffreestanding`, so source that selects a
freestanding subset from this macro alone takes the hosted branch.
`--freestanding` changes what is linked and `-ffreestanding` which calls
fold, not what is predefined.

### Not implemented, severity 4-5

C99 features rejected (all rare in current source): `_Complex` /
`_Imaginary` (6.2.5), and digraphs and trigraphs (6.4.6 / 5.2.1.1). A
universal character name is implemented in a string or character literal,
under 6.4.3's constraints, and in an identifier, where 6.4.2.1 limits it to
the Annex D characters; the UTF-8 spelling of such a character is the same
identifier. The absence of complex types is announced in
the C11-conforming way: `__STDC_NO_COMPLEX__` is defined as 1.
`#pragma STDC FP_CONTRACT` / `FENV_ACCESS` / `CX_LIMITED_RANGE` (7.1.2p6)
are accepted and ignored: `-O` contracts `a*b+c` into an FMA whatever the
pragma says.

Implemented, and listed here because they sit next to the above in C99:
K&R identifier-list function declarators with separate parameter
declarations (obsolescent, 6.11.7) are accepted and lowered. `_Noreturn` is
recorded on the function symbol and propagated -- a call to a `_Noreturn`
function does not reach its continuation in the fall-through reachability
analysis, which also reports a non-`void`, non-`main` function that can
fall off its end without returning a value. That report is `return-type`
(B3003), off by default and enabled by `-Wall`; clang's counterpart is on
by default.

`__STDC__`, `__STDC_HOSTED__`, `__DATE__`, and `__TIME__` are predefined.
`__DATE__` and `__TIME__` are the time of translation in UTC; the
`SOURCE_DATE_EPOCH` environment variable fixes it, as under gcc and clang.
`__STDC_VERSION__` is defined as `201112L` (C11): the implemented surface
is C99 plus the C11 features real code gates on this macro
(`_Static_assert`, `_Noreturn`, `_Atomic`, `_Thread_local`, `_Generic`,
anonymous members, `<stdatomic.h>`).

### Unrecognized command-line options are fatal, severity 4

badc's driver has no accept-and-ignore bucket: any dash-prefixed argument
no option arm matches is an error, not a warning. Common gcc spellings
badc does not implement -- `-x`, `-isystem`, `-static` -- therefore fail
the invocation rather than being dropped. A build system that passes a
compiler's whole flag set through has to filter it; the kernel harness
under `demos/linux/` does exactly that.

An option badc parses but cannot fully honour is the exception: it is
accepted, and the request it names selects the one behaviour badc has.
`-O1` / `-O2` / `-O3` / `-Os` / `-Oz` / `-Ofast` / `-Og` all select the
single optimization level, `-g<level>` the single amount of debug
information, and `-mcpu=<name>`, whose name must be an AArch64 part
badc knows, a scheduling model badc does not differentiate. Only the
`-g` family reports the gap, since a DWARF version and format are
written into the output.

`-g`, `-g0` .. `-g3`, `-ggdb[0-3]`, `-gdwarf`, `-gdwarf-<n>`, `-gdwarf32`,
`-gdwarf64`, `-gstrict-dwarf` and `-gno-strict-dwarf` are accepted with
gcc's meanings. badc emits DWARF version 4 in the 32-bit DWARF format, so
a request it cannot produce -- a version other than 4, or the 64-bit
format -- is reported as `dwarf-output` (B7011) naming what is emitted
instead, and the compile proceeds. A spelling that names no request is
rejected with gcc's wording: a version outside 2 .. 5, a level above 3, or a
non-integer where `-gdwarf-` takes one. `-gsplit-dwarf`, `-gz` and
`-gline-tables-only` change the file set or the section contents and stay
unimplemented, so they are refused by name.

The `-W` family follows the same rule against the diagnostic catalogue.
`-w`, `-Werror`, `-Wno-error`, `-Werror=<sel>`, `-Wno-error=<sel>`,
`-W<sel>`, `-Wno-<sel>`, `-Wall`, `-Wextra` and `-Wpedantic` are
implemented; a selector is a diagnostic's name, one of its aliases, its
`B` code or a group name, and one no catalogue row answers to is refused
by name. `--list-diagnostics` prints the catalogue.

The diagnostic pragmas -- `#pragma GCC diagnostic`, `#pragma clang
diagnostic` and MSVC's `#pragma warning(...)` -- take the same selectors
and decide a row's level at the source position they precede, for the
parser's diagnostics as well as the preprocessor's. A pragma covering
the position wins over the command line; `push` and `pop` bound the
region it covers. A link diagnostic has no position in a translation
unit, so the command line alone governs one.

`-Wa,<opt>` and `-Xassembler <opt>` are checked rather than passed on, since
the assembler is built in: an option outside the accepted set is refused by
name (`unsupported assembler option`) instead of reaching a program that is
not there. The accepted set is `-L` / `--keep-locals`, which keeps the
local-label temporaries in the symbol table as GNU as does, plus the
options whose effect badc's assembler already has -- `--fatal-warnings`,
`-mrelax-relocations=`, `--noexecstack`, `--no-warn-rwx-segments` and
`-march=`. `-march=` is the one that is not exact: badc implements a fixed
instruction set and admits every member of it, so a ceiling below that set
selects nothing rather than rejecting the instructions above it.

`-std=<dialect>` is accepted. badc compiles C99 with the GNU extensions
always available, so the name selects only whether `__STRICT_ANSI__` is
defined under `--gnu`: `gnu*` clears it and `c<digits>` / `iso9899:*` set
it, as in gcc and clang. Without the flag `--gnu` reports strict
conformance, so a header takes its standard-C path for the GNU features
badc lacks. A name outside those three shapes is refused rather than read
as strict ISO, so gcc's `-std=c2x` fails the invocation while `-std=c23`
is taken.

### ELF imports take their versions from a pinned manifest, severity 5

A GNU symbol version on an import is normally read out of the shared
object the link host carries, which makes the image a function of the
build machine: the same source and command line produced different bytes
on hosts whose own libc differed, each diverging on the target it is
native to, and a link on a current distribution stamped versions an older
one cannot resolve. badc reads them from
`libc/versions/elf-<arch>.txt` instead -- committed data keyed on
`(soname, symbol)`, each entry the newest version at or below a pinned
glibc 2.17 floor and the oldest the symbol has where the floor predates
it. A library named on the `-l` path still decides its own version data,
so `-L <sysroot>/lib -lc` pins the versions to that sysroot on any host,
and a reference to a C library the bundled headers do not describe stays
unversioned. A version at the floor can name a compatibility
implementation whose semantics differ from the header badc ships for that
name. TODO: hold the bound version and the declared interface in step.

## Extensions implemented

### C11 / C23

- `_Static_assert`, the C23 `static_assert` alias, and the C23 form with no
  message, at file and block scope; the operand flows through the full C99
  6.6 constant-expression grammar (float casts and arithmetic work in the
  condition).
- `_Generic` selection (C11 6.5.1.1).
- `typeof` and `typeof_unqual` (C23 6.7.2.5), also under the GNU spellings
  `__typeof__` / `__typeof` and `__typeof_unqual__` / `__typeof_unqual`.
  `typeof_unqual` names the operand's type without the qualifiers on the
  type itself; a pointee's stay, an array's elements lose theirs.
- `_Atomic(type-name)` specifier (6.7.2.4) and the `_Atomic` qualifier
  (6.7.3) are accepted and reduce to the unqualified inner type; the
  qualifier itself carries no atomicity.
- C11 7.17 atomic operations, reached through `<stdatomic.h>`, which binds
  the non-`_explicit` forms with `#pragma intrinsic` (`atomic_load`,
  `atomic_store`, `atomic_exchange`, `atomic_fetch_add` / `sub` / `and` /
  `or` / `xor`, `atomic_compare_exchange_strong`) and the `_explicit`
  forms and the fences to the `__atomic_*` builtins, which carry the
  memory order. The width is the pointee type of the first argument,
  restricted to 1, 2, 4 and 8 bytes; a wider object is rejected at
  compile time. All of them are atomic against concurrent access. A load
  and a store carry the order named (7.17.1; `consume` is acquire, and an
  order the operation may not name -- 7.17.7.1p2, 7.17.7.2p2 -- or one
  that is not a constant takes seq_cst): on aarch64 a relaxed access is a
  plain `ldr` / `str`, an acquire or seq_cst load `ldar` and a release or
  seq_cst store `stlr`; on x86_64 every load and a relaxed or release
  store are a plain `mov`, and a seq_cst store `xchg`. The
  read-modify-write forms lower to `lock xadd` / `xchg` / `lock cmpxchg`
  (a retry loop for the bitwise forms, which have no fetch-and-return-old
  encoding) on x86_64 and to an `ldaxr` / `stlxr` retry loop on aarch64:
  the seq_cst sequence whatever order they name, and
  `atomic_compare_exchange_weak` is the strong form. `atomic_thread_fence`
  is `dmb ish` on aarch64 (`dmb ishld` for acquire) and `mfence` for
  seq_cst on x86_64, where the acquire and release fences, like
  `atomic_signal_fence` on both targets, are compiler barriers; a relaxed
  fence is nothing (7.17.4.1p4). The `atomic_flag` operations are the
  integer ones on a byte-wide cell, and `atomic_init` is the relaxed
  store (7.17.2.2). The optimizer treats every atomic access as an
  ordering point: none is forwarded, merged, hoisted or dropped.
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
- The `u8` encoding prefix (C11 6.4.5p2), alongside C99's `L` and C11's
  `u` and `U`; a universal character name in a literal encodes as UTF-8
  in a narrow one and as a code point in a wide one. `<uchar.h>` and
  `char16_t` / `char32_t` are not provided.
- Binary integer literals `0b...` / `0B...` (C23 / GCC), with the same
  `u` / `l` suffix handling as hex and decimal.

### POSIX

- The `<dlfcn.h>`, `<pthread.h>`, `<dirent.h>`, `<setjmp.h>`, and related
  surfaces in `libc/include/`; `struct dirent` matches the host libc
  byte layout so `readdir` reads `d_name` at its real offset.
- `fseeko` / `ftello`, declared over `long` rather than `off_t` (the same
  type on every LP64 target badc has), and the glibc
  `malloc_usable_size` and `sighandler_t` on Linux. The Windows targets
  carry `_fseeki64` / `_ftelli64` in their place, as their C library
  does.

### GCC

- Statement expressions (`({ ... })`), `typeof` / `__typeof__` and
  `__typeof_unqual__` / `__typeof_unqual` (the C23 operators above under
  their GNU spellings), and the case-range form `case a ... b:`.
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

  The bit-count builtins lower to a portable shift / mask sequence in the
  SSA walker rather than to `lzcnt` / `tzcnt` / `popcnt` / `rbit`, so the
  interpreter and every target agree bit for bit. A consequence of that
  lowering: `__builtin_clz(0)` and `__builtin_ctz(0)` return the operand
  width instead of being undefined. The byte-swap builtins are an IR
  operation every backend and the interpreter implement, and select
  `bswap` on x86_64 and `rev` on aarch64.
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
  compiles. The `__atomic_*` memory-order operand selects the load, store
  and fence lowering as for `<stdatomic.h>`; `__sync_lock_release` is
  the release store, `__sync_synchronize` the seq_cst fence, and the
  rest of the `__sync_*` set is seq_cst.
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
  complete GAS implementation. A file-scope `asm(...)` belongs to no
  function: its text reaches the object as written and the assembler and
  linker resolve the names in it, so spelling the name of a `static`
  definition there does not keep that definition -- write
  `__attribute__((used))` on it, as gcc requires at `-O2`. A template
  inside a function body is emitted with that function, and a `static` it
  names is kept.
- Where an x86 instruction's encoding differs between the Intel SDM's
  row and GNU as, badc takes the SDM's, unless Linux depends on the
  specifics. The operand width as written selects the row, which is what
  stops one instruction from having two encodings depending on how its
  register was spelled. Six forms diverge, all of them a `REX.W` row the
  SDM gives a 64-bit register that GNU as drops: `mov` from and to a
  segment register (`8C` / `8E`), and `sldt`, `str`, `lar` and `lsl`
  (`0F 00 /0`, `0F 00 /1`, `0F 02`, `0F 03`). clang emits the wide form
  in all six, and qemu and unicorn both decode the destination at the
  effective operand size, so it executes as written. The narrow form is
  architecturally equivalent, since only 16 bits are produced and the
  rest are zeroed either way, so this is a choice about which rule the
  assembler follows rather than about behaviour. The rest of the family
  agrees with both references: `smsw` with a 64-bit register keeps its
  `REX.W` in GNU as too, and the control- and debug-register moves take
  the mode's own row with no prefix. Linux does not depend on the narrow
  form. It has three uses: the one inside an alternatives site forces the
  32-bit register name, where both assemblers agree byte for byte, and
  the entry-code macro and the kexec stub carry the extra byte, which the
  stub's link-time size assertion has 382 bytes of margin for.
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
  `always_inline`, `noinline`, `gnu_inline`, `ms_abi` / `sysv_abi` (the
  x86_64 calling convention of a function or of a function pointer's
  pointee; x86-only, inert elsewhere, as in GCC),
  `cleanup(fn)` (the function runs on scope exit), `constructor` /
  `destructor` (run before / after `main`, optional priority), `noreturn`,
  `unused` / `maybe_unused`, `vector_size(N)` (modeled as an aggregate),
  `transparent_union`, `no_instrument_function`, `uninitialized`,
  `patchable_function_entry`, and the MSVC `__declspec(thread)` /
  `dllexport`. Other attributes -- `format`, `pure` / `const`,
  `deprecated`, `fallthrough` and the rest -- are parsed and silently
  discarded; there is no "attribute ignored" diagnostic. Two asymmetries
  are worth knowing: `__has_attribute` answers 1 for a fixed list of GCC
  attribute names wider than the honored set
  (and 0 for the honored `vector_size` / `dllexport`), and the C23
  `[[...]]` syntax honors only the bare names plus `aligned`,
  `constructor` and `destructor`, so `[[gnu::section("x")]]` parses and is
  dropped while `__attribute__((section("x")))` takes effect.
- A `vector_size(N)` value crosses a function boundary in the SIMD
  argument registers: the System V AMD64 psABI 3.2.3 classes a 16-byte
  vector SSE + SSEUP and gives it one whole `xmm0`-`xmm7` register, and
  AAPCS64 6.4.2 Stage C.1 assigns a 64- or 128-bit Short Vector to
  `v0`-`v7`. Returns take `xmm0` / `v0`, and a variadic vector rides the
  same bank, counted in `al` on System V and read back from the vector
  save area. Windows x64 passes a 16-byte vector by an implicit
  reference, as its convention states, and macOS arm64 puts variadic
  arguments on the stack, as its divergence from AAPCS64 states. Two
  cases stay off the register path: a vector wider than a register (32
  bytes and up) goes to memory on System V, as gcc places it without
  `-mavx`, and by reference on AAPCS64; and a struct of two to four
  vectors -- an AAPCS64 homogeneous vector aggregate -- takes the
  composite rules instead of `v0`-`v3`. TODO: homogeneous vector
  aggregates.
- GCC named-rest variadic macro (`#define foo(args...)`).
- The GNU89 inline linkage model, per function via
  `__attribute__((gnu_inline))` and per unit via `-fgnu89-inline`: `extern
  inline` provides no external definition and a plain `inline` does, the
  inverse of C99 6.7.4p6. With `--gnu`, `__GNUC_STDC_INLINE__` or
  `__GNUC_GNU_INLINE__` reports which model is in force.
- `--gnu` additionally defines the GCC identity macros (`__GNUC__` 4,
  `__GNUC_MINOR__` 3, `__GNUC_PATCHLEVEL__` 0, `__VERSION__`),
  `__STRICT_ANSI__`, the `__GCC_HAVE_SYNC_COMPARE_AND_SWAP_{1,2,4,8}` set,
  and on x86_64 `__GCC_ASM_FLAG_OUTPUTS__`.

### MSVC-compatible

- `#pragma warning(push)` / `pop` / `disable : N` / `enable` / `default` /
  `error` / `once` / `suppress`, each with MSVC's meaning: `error` raises
  the row, `once` reports it a single time, `suppress` covers the next
  line only. `N` is a diagnostic's `B` code or one of the MSVC numbers
  carried as aliases. Plus the Borland / Watcom `#pragma warn -N` form.
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
  with gcc's names. Two do not: `_mm_load_si128` / `_mm_store_si128` take
  the unaligned move, and `_mm_loadl_epi64` / `_mm_storel_epi64` go
  through memory. The SSE2 integer set covers the lane arithmetic bar the
  widening and high-half multiplies, the logic and compares, the packs
  and interleaves, the shifts, the shuffles, the element accesses and the
  sign mask, plus `__m128i_u`, the composition intrinsics (`_mm_set*`,
  `_mm_setr*`, `_mm_cvtsi*`) the header builds over the vector extension,
  and the `__m128i` / `__m128d` cast pair. Not carried: the packed-single
  operations, the packed-double ones other than `_mm_shuffle_pd`, the
  saturating and averaging integer arithmetic, the min / max /
  absolute-difference family, the shifts whose count is a vector rather
  than an integer, the non-temporal transfers, and everything above
  SSE4.1 (AVX, AVX2, AVX-512, FMA). An operation outside the subset is
  absent rather than emulated, so a unit needing one fails at the
  undeclared name. The forms whose last operand the instruction encodes
  as `imm8` are macros, as gcc's are without `-O`; the rest are
  `static inline` wrappers, which `-O` inlines so the instruction is
  emitted at the use site, and which stay calls without it.

### badc-specific

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
  `efi_boot_service_driver`, `efi_runtime_driver`, `efi_rom`, each taken
  in any case and with `-` for `_`; `--subsystem=` takes the same set
  through the same lookup.
- `#pragma pack(N)` / `push` / `pop`, `#pragma GCC visibility push/pop`,
  and `#pragma once`.
- The C99 6.10.9 `_Pragma(<string-literal>)` operator, processed as the
  destringized `#pragma` directive (including via the `#x` stringize
  feeding `_Pragma(#x)`).
- `--interp` (SSA interpreter with pointer tracking), `--jit` (in-process),
  `--dump-ssa`. The interpreter implements a subset of the library calls;
  one it has no implementation for is reported when the call is reached.
- `-H` / `--show-includes` -- gcc-`-H`-shape `#include` trace on stderr,
  one line per include with leading dots for depth. The line carries the
  path the include resolved to, as gcc and clang print; a header from the
  compiler's own in-binary set has no path and prints its name, and a
  repeated include the guard or `#pragma once` dropped is marked `(cached)`.
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
- Extension: a `#if` / `#elif` controlling expression accepts a string
  operand -- a string literal, with any encoding prefix and its escapes
  undecoded, or a macro expanding to one -- in exactly one position: as an
  operand of `==` / `!=` whose other operand is also a string. The two
  compare by spelling, prefix excluded (`#if __BADC_TARGET__ ==
  "macos-aarch64"`, `#if __BADC_VERSION__ != "0.1.0"`). C99 6.10.1p4
  restricts `#if` to an integer constant expression; badc admits the
  comparison so the string-valued `__BADC_TARGET__` / `__BADC_VERSION__`
  predefines can gate source. A string anywhere else -- the whole
  controlling expression, an operand of `!`, `~`, unary `+` / `-`, of an
  arithmetic, bitwise, shift, relational or logical operator, a `?:`
  condition or arm, or the other side of an integer in `==` / `!=` -- is
  an error naming the operator, whether or not that operand is evaluated.
  Adjacent string literals do not concatenate. An identifier left after
  macro expansion is 0 as in C99, a macro whose unquoted body is not a
  number included.

## Roadmap

1. Volatile-marked whole-aggregate copies (scalar volatile accesses are
   enforced; a volatile struct assignment's block copy is not marked).
2. x86_64 Windows UNWIND_INFO describes only the frame-pointer prologue
   (RIP/RSP/RBP recover exactly); callee-saved GPR spills are not yet
   described, so a debugger / profiler / SEH unwind crossing such a frame
   does not recover those registers. Program execution is unaffected --
   badc emits no exception-using code. A faithful description needs a
   push-before-setframe prologue restructure.
