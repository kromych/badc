# Native compilation

badc compiles and links for five targets from any host. It carries its own
assembler and linker, so a build needs no `ld`, `lld` or `link.exe`. This page
covers the targets, object and image formats, the linker, the bundled headers
and their library bindings, the instruction-set baseline, optimization, and the
code-generation options for kernel and firmware builds.

## Contents

- [Targets](#targets)
- [Instruction-set baseline](#instruction-set-baseline)
- [Objects, archives and libraries](#objects-archives-and-libraries)
- [Linking](#linking)
  - [Undefined and weak references](#undefined-and-weak-references)
  - [Unwind tables](#unwind-tables)
- [Language and predefined macros](#language-and-predefined-macros)
- [Headers and bindings](#headers-and-bindings)
  - [The Windows C runtime](#the-windows-c-runtime)
  - [Build settings in pragmas](#build-settings-in-pragmas)
  - [Windows subsystems and default libraries](#windows-subsystems-and-default-libraries)
  - [Which headers a target has](#which-headers-a-target-has)
- [Runtime lookup](#runtime-lookup)
- [In-process JIT (`--jit`)](#in-process-jit---jit)
- [Optimizations](#optimizations)
- [Hardening and code-model knobs](#hardening-and-code-model-knobs)
  - [Reserved registers](#reserved-registers)
  - [Stack protector](#stack-protector)
  - [Automatic variable initialization](#automatic-variable-initialization)
  - [Frame size](#frame-size)
  - [AArch64 branch protection](#aarch64-branch-protection)

## Targets

| `--target=`     | also accepted                                                   | image  | data model |
|-----------------|-----------------------------------------------------------------|--------|------------|
| `macos-aarch64` | `aarch64-apple-darwin`                                          | Mach-O | LP64       |
| `linux-aarch64` | `aarch64-unknown-linux-gnu`                                     | ELF    | LP64       |
| `linux-x64`     | `linux-x86-64`, `x86_64-unknown-linux-gnu`                      | ELF    | LP64       |
| `windows-x64`   | `windows-x86-64`, `x86_64-pc-windows-gnu`, `x86_64-pc-windows-msvc` | PE32+  | LLP64      |
| `windows-arm64` | `windows-aarch64`, `aarch64-pc-windows-gnullvm`, `aarch64-pc-windows-msvc` | PE32+  | LLP64      |

The default is the host. On `linux-x64`, `-m16` and `-m32` assemble an
assembly unit into an ELF32 i386 object. badc generates no i386 code, so a C
source under either flag is refused unless the command is `-E`.

Executables are position-independent: an ELF executable is `ET_DYN` (PIE), and
Mach-O and PE images always are. On Linux, `-no-pie` links the executable at
its link address (`ET_EXEC`):

- The startup runtime and the dynamic tables stay.
- Data pointers are final at link time, with no `R_*_RELATIVE` entries.
- The absolute relocations of a `-fno-pic` object resolve. A PIE refuses them,
  as GNU ld does; on x86-64 such an object addresses its jump tables with
  `R_X86_64_32S`.

The last of `-pie` / `-no-pie` wins, and `-c` and `--shared` ignore both.
`-no-pie` is refused for a Mach-O or PE target.

`--freestanding` leaves out the embedded startup runtime. The program defines
the entry: `__c5_entry` by default, or the name `#pragma entrypoint` or
`--entry=` gives. On Linux the image is linked at its link address
(`ET_EXEC`) in two `PT_LOAD` segments, read-execute and read-write, as `ld`
lays out a static executable. It has no interpreter and no dynamic section
unless it calls a shared-library function. Then it has both, and badc warns
(`-Wfreestanding-import`). `-ffreestanding` is a compile option only: it sets
`__STDC_HOSTED__` to 0 and implies `-fno-builtin`.

An EFI image is a PE image with an EFI subsystem; see
[Windows subsystems](#windows-subsystems-and-default-libraries).

## Instruction-set baseline

On x86_64 badc assumes x86-64-v3: AVX, AVX2, FMA3, BMI1, BMI2, LZCNT, MOVBE and
F16C on top of SSE4.2 and POPCNT, as in Intel Haswell, AMD Zen and later. On
AArch64 it assumes what the Apple M1 implements, less Apple's own extensions:
ARMv8.4-A with FP16, DotProd, FHM, AES, PMULL, SHA3 and SHA512, plus FRINTTS,
FlagM2, SB and SSBS from ARMv8.5-A, without BTI, BF16 or I8MM. The emitted
code may use any instruction of the set at any optimization level. A processor
that lacks one is not a target.

`-mno-sse` and `-mgeneral-regs-only` take the floating-point and vector
registers out of the set ([Hardening and code-model
knobs](#hardening-and-code-model-knobs)). Nothing else narrows it. The driver
refuses `-march=` and `-mtune=`.

Feature macros:

- x86-64 predefines the x86-64 base set: `__MMX__`, `__SSE__`, `__SSE2__`, `__SSE_MATH__`,
  `__SSE2_MATH__` and `__FXSR__`. None of the x86-64-v3 macros (`__AVX2__`,
  `__FMA__`, ...) is predefined. `-mno-sse` and `-mgeneral-regs-only` leave the
  set unchanged.
- AArch64 predefines no feature macro, `__ARM_NEON` included. `-mcpu=`'s
  `+aes`, `+sha2` and `+crypto` modifiers define `__ARM_FEATURE_AES`,
  `__ARM_FEATURE_SHA2` and `__ARM_FEATURE_CRYPTO`.

## Objects, archives and libraries

One `badc` invocation can mix `.c` and assembly sources, objects and archives:

```sh
badc -c foo.c bar.c               # writes foo.o and bar.o
badc -o app foo.o bar.o           # links them
badc --ar -o libfoo.a foo.c bar.c # compiles and archives, with a symbol index
badc -o app main.c -L. -lfoo      # links against libfoo.a
```

`-c` writes one object per source; `-o` names it only when there is one
source. For every target the object is an ELF64 `ET_REL` file: machine code in
`.text`, static storage in `.data` and `.bss`, a symbol table, `.rela.*`
relocations, and a `.note.badc` section of records badc's linker reads. The
target is fixed at compile time. A Linux object also links with GNU ld or lld.
The address of an external symbol, and a data load from one, go through the
GOT, so the object links into a PIE the system toolchain builds.

The linker also reads ELF objects from other compilers, Mach-O `MH_OBJECT`
files, PE/COFF objects and import libraries, ar archives, and shared libraries
(`.so`, `.dylib`, `.tbd`, `.dll`). Archives are ar(5) with a SysV symbol index.
A PE link sizes the initial thread's stack under `--stack <reserve>[,<commit>]`,
link.exe's `/STACK` (default 8 MiB reserved, one page committed).
A PE DLL link writes the DLL's import library under `--out-implib=<file>`,
as link.exe writes one beside a DLL: an archive of short import members, a
data export's naming only its `__imp_` slot.
A COFF weak external or `/alternatename:` resolves a name nothing defines to its
alternate, a definition or a DLL import; an archive member holding a weak
external of the alias kind is pulled for its name, as link.exe pulls the
members of MSVC's oldnames.lib.
A compiled resource file (`.res`, as rc.exe writes it) among a PE link's inputs
becomes the image's `.rsrc` section: the resource directory by type, name and
language, which the loader reads for the manifest, the version and the strings.
A cvtres object's resources (`.rsrc$01` / `.rsrc$02`) join them.
A module-definition file (`.def`) among a PE link's inputs gives the image its
`EXPORTS`, as link.exe's `/DEF:` does: an export under another name, at an
`@ordinal`, `NONAME`, `DATA` or `PRIVATE` (kept out of `--out-implib`'s
library), and `LIBRARY` names the DLL in its export directory. An export
without an ordinal takes the lowest free one in name order, as link.exe
assigns them; `/EXPORT:` options in `.drectve` take the same forms.
Named `ar` or `*-ar`, or run as `badc --ar <key>`, badc is a POSIX `ar`; named
`ranlib` it indexes archives.

`-l<name>` is searched in the `-L` directories, in order, then in the standard
directories under `--sysroot=<dir>`:

| image  | directories under the sysroot                                              |
|--------|----------------------------------------------------------------------------|
| ELF    | `usr/lib64`, `lib64`, `usr/lib`, `lib`, `usr/lib/<arch>-linux-gnu`, `lib/<arch>-linux-gnu` |
| Mach-O | `usr/lib`, `usr/local/lib`                                                  |
| PE     | `lib`, `usr/lib`                                                            |

No other directory is read, on a native link too. The host's `/usr/lib` is an
input only when the command names it (`--sysroot=/`), so one command builds the
same image on every host. The sysroot's include directories supply the headers
the bundled set lacks (`<zlib.h>`). They are searched after the bundled
headers, so a standard header keeps the bundled copy. For a Mach-O target
`$SDKROOT` is the default sysroot, as for Apple's tools; `--sysroot=` with no
directory withdraws it.

Linkage follows C99 6.2.2. A file-scope `static` is internal; any other
file-scope declaration is external. `extern T x;` with no definition in the
unit is an undefined reference that the other objects or the archives must
resolve.

The `badc` binary needs the `full` cargo feature: native output
(`native-emit`) plus the linker. The library's default feature set is `std`,
which has the compiler and the in-process JIT but no native output; see
[`library-and-no-std.md`](library-and-no-std.md).

## Linking

The driver passes link options with `-Wl,` and `-Xlinker`. It takes GNU ld's
linker scripts (`-T` / `--script`, with `.o` and `.a` inputs only),
`--emit-relocs`, `-z` keywords, `--build-id`, link maps (`-Map`,
`--print-map`), `--whole-archive` spans, `--start-group` / `--end-group`, and
export control (`--export-all`, `--export-data`). `--help` lists the image
options. A link option badc does not implement is refused by name.

Invoked as `ld`, `ld.badc` or `<prefix>-ld`, or as `badc --ld`, badc takes GNU
ld's command line with its own flag table. That is how it serves as `LD=` in
an existing build, including [the Linux kernel's](linux-kernel.md). Its
`--version` prints `GNU ld (badc <version>) 2.33.1`.

As in GNU ld, an input whose `.note.GNU-stack` is executable makes the stack
executable, with a warning (`-Wexecstack`), unless `-z noexecstack` is given.

Inputs enter the link in command-line order, after the startup runtime.
Constructors of one priority run in that order, and the
first of two weak definitions wins. An ELF link takes archives as GNU ld does:

- an archive resolves the references made before it, rescanning itself until
  it adds nothing;
- `--start-group` / `--end-group` (`-(` / `-)`) rescan a span together;
- a `-l` shared library resolves the names it exports from its position on.

A Mach-O or PE link searches every archive until nothing changes, as ld64 and
link.exe do.

### Undefined and weak references

Each image format follows its own system linker:

| image  | executable  | shared library | weak reference no input defines |
|--------|-------------|----------------|---------------------------------|
| ELF    | error       | load-time import, as GNU ld's `-shared`; an error under `--no-undefined` / `-z defs` | 0 |
| Mach-O | error       | error, as ld64's default `-undefined error` | error |
| PE     | error       | error: a PE import must name its DLL | 0 |

On Mach-O, `-undefined dynamic_lookup`, `suppress` or `warning` (also as
`-Wl,-undefined,<value>`) turns such a reference into a flat-namespace lookup
at load time, in an executable or a dylib. `warning` also reports each one
(`-Wundefined-lookup`). An ELF or PE link refuses `-undefined`. A Mach-O import
that only weak references reach binds as a weak import: its address is 0 when
the loaded dylib lacks the name. `__attribute__((weak_import))` is `weak` on
Mach-O and ignored elsewhere.

`-bundle` (also `-Wl,-bundle`) links a Mach-O library only `dlopen` loads,
an `MH_BUNDLE` image with no install name; its undefined references follow
`-undefined` as a dylib's do. `-flat_namespace` gives every import of the
image a flat lookup and clears `MH_TWOLEVEL`. `-bundle_loader` is refused: a
bundle reaches its loader's symbols through `-undefined dynamic_lookup`.

### Unwind tables

- PE: every function has a `RUNTIME_FUNCTION` entry in `.pdata`. Its unwind
  record (x64 `UNWIND_INFO`, arm64 `.xdata`) is in `.rdata`, as link.exe lays
  them out. An arm64 record gives each epilogue its own epilog scope. The code
  generator records each prologue and epilogue step as it emits it; an object
  carries the steps to the link in its `.note.badc` section. The `.pdata` and
  `.xdata` of a COFF object from another compiler join the exception
  directory. `__try` / `__except` / `__finally` are in
  [`std-conformance.md`](std-conformance.md).
- Mach-O: a `__TEXT,__unwind_info` compact unwind table.
- ELF: badc's code has no `.eh_frame`. With `-g`, its CFI is in
  `.debug_frame`. An input's `.eh_frame` is kept, and the `ld` persona's
  `--eh-frame-hdr` indexes it.

## Language and predefined macros

badc compiles C17 by default, with part of C23 and much of the GNU C extension
set. [`std-conformance.md`](std-conformance.md) lists the
rejected constructs, the divergent behavior and badc's own extensions.

Target macros:

| macro                                      | defined for                       |
|--------------------------------------------|-----------------------------------|
| `__BADC_VERSION__`                         | every target; the crate version as a string, e.g. `"0.4.8"` |
| `__BADC_TARGET__`                          | every target; the target name as a string, e.g. `"macos-aarch64"` |
| `__aarch64__`, `__arm64__`                 | AArch64 targets                   |
| `__x86_64__`, `__x86_64`, `__amd64__`, `__amd64` | x86-64 targets              |
| `_WIN32`, `_WIN64`, `__BADC_WINDOWS__`     | Windows targets                   |
| `__APPLE__`                                | macOS                             |
| `__linux__`, `__ELF__`                     | Linux                             |
| `__BADC_JIT__`, `__BADC_INTERP__`          | 1 for every unit `--jit` / `--interp` runs |

The C17 macros are defined as well (`__STDC__`, `__STDC_VERSION__`,
`__SIZEOF_*__`, `__BYTE_ORDER__`, the `__ATOMIC_*` orders), and under `--gnu`
the GNU C identity macros. `std-conformance.md` lists them all.

`__DATE__` and `__TIME__` give the time of translation in UTC, one instant for
every unit of an invocation. `SOURCE_DATE_EPOCH` fixes it, so a build that
expands either writes the same bytes on every run.

`#if X == "..."` and `!=` compare a string-literal macro such as
`__BADC_TARGET__` with a string. This is an extension: C99 requires an integer
constant expression in `#if`, and badc admits a string in no other operand
position.

On the Windows targets `--msvc` defines the MSVC identity macros (`_MSC_VER`
and the rest) and leaves `__STDC__` undefined, as cl does. The MinGW
compatibility macros and keywords (`__MINGW32__`, `__int64`, `__declspec`, ...)
are in `libc/include/msvc_compat.h`. A unit opts in with
`-include msvc_compat.h`.

## Headers and bindings

A bundled header names the shared libraries the target offers and the symbol
each local name binds to:

```c
#pragma dylib(libsystem, "/usr/lib/libSystem.B.dylib")
#pragma binding(libsystem::puts, "_puts")

int puts(const char *s);
```

The prototype type-checks a call. The binding tells the linker to import
`_puts` from `libSystem.B.dylib`, and badc builds the image's import records
from it. Another target's headers bind the same name elsewhere: `puts` from
`libc.so.6` on Linux and from `msvcrt.dll` on Windows.
`badc --dump-bindings --target=<t>` lists every binding the bundled headers
state for a target.

A binding declares nothing. C99 has no implicit declarations, so a call to an
undeclared function is an error (B2022). When the name is a library function
a bundled header declares, badc instead includes that header and reports it
with an `info:` line; `-fno-builtin` and `-nostdinc` turn this off. A function
the program calls that no input defines and no binding names is an undefined
reference at link.

A library a bundled header names reaches the image only when an import binds
through it. Including `<math.h>` without calling into it leaves no `DT_NEEDED`
entry, as `ld --as-needed` would. A `#pragma dylib` in the program's own source
is always recorded as a load-time dependency. That is how a program names a
library it reaches only through runtime lookup, such as a framework whose
initializer has to run before `dlsym` or `objc_getClass` finds a name.

### The Windows C runtime

The Windows targets use `msvcrt.dll`, as mingw-w64's default configuration
does. Where `msvcrt.dll` lacks a C99 function or gets one wrong, the bundled
headers bind it to `ucrtbase.dll` (much of `<math.h>`, for example), or
`libc/lib/` defines it. The `printf` family is defined there and formats
through `ucrtbase.dll`. A definition in `libc/lib/` joins the link as an
archive member would.

A program built against the Windows SDK's UCRT headers links the UCRT itself
(`ucrt.lib`, or `ucrtbase.dll` named on the command line). When the link's
libraries supply the UCRT's startup interface, the startup runtime calls it as
the VC startup code does: `_set_app_type`, the argument vector and the
environment in the entry's character width, `_crt_atexit` for the destructors
and for the program's `atexit`, and the UCRT's `exit`; msvcrt.dll is not
loaded beside it.

A bundled header declares the names mingw-w64's header of the same name
declares. A name mingw-w64 leaves undeclared stays undeclared, so a program's
own Windows fallback for it compiles under badc as under mingw-w64. `setenv`
is one such name, as are `fork`, `getuid` and the other POSIX process, user and
terminal calls. A POSIX header mingw-w64 does not ship (`<termios.h>`,
`<sys/mman.h>`, `<pwd.h>`, ...) is not found. Two tests hold this:
`windows_header_declarations_resolve_at_link` walks every bundled header for
both Windows targets and fails on a declared function or object that nothing
defines, and on a Windows host `windows_bindings_name_exports_of_their_dlls`
checks that each binding names an export of its DLL.

A native-subsystem image cannot load the user-mode C runtime. What the
headers bind to `msvcrt.dll` or `ucrtbase.dll`, a driver imports from
`ntoskrnl.exe` and a native application from `ntdll.dll`, by name. A name that
module does not export is an undefined reference. The check reads the C
runtime names each module exports on x64 and arm64, measured from Windows 11's
system images (`src/c5/object/nt_crt.rs`). On every PE image, an import
library or DLL on the command line that supplies a name takes precedence over
the header's binding, as with link.exe and GNU ld.

### Build settings in pragmas

These pragmas keep build settings next to the code, so a source can build with
a bare `badc <file>`:

```c
#pragma once                       // include the header once
#pragma dylib(libc, "libc.so.6")   // name a shared library to bind to
#pragma binding(libc::sin, "sin")  // bind a name to a symbol of that library
#pragma export(my_api)             // export a function from a shared library
#pragma pack(push, 1) / pack(pop)  // set the maximum member alignment
#pragma entrypoint(start)          // enter the program at `start`, not `main`
#pragma subsystem(windows)         // pick the PE subsystem
```

`#pragma entrypoint(<name>)` resolves the name as `main` would be resolved.
`--entry=<sym>` overrides it.

Unknown pragmas and unknown directives warn and are ignored. An `#include`
that neither the search path nor the bundled headers resolve is an error. `-H`
(`--show-includes`) prints each resolved include on stderr, one leading dot per
nesting level.

### Windows subsystems and default libraries

`#pragma subsystem(<kind>)` and `--subsystem=<kind>` set the PE optional
header's `Subsystem` field. The option overrides the pragma. Kinds are taken in
any case and with `-` for `_`:

| kind                      | `Subsystem` | image |
|---------------------------|-------------|-------|
| `console` (`cui`)         | 3, `WINDOWS_CUI` | console program; the default |
| `windows` (`gui`)         | 2, `WINDOWS_GUI` | GUI program; the default for a program that defines `WinMain` or `wWinMain`, as link.exe infers |
| `native` (`nt`)           | 1, `NATIVE` | NT-native user-mode program; C runtime from `ntdll.dll` |
| `driver`                  | 1, `NATIVE` | kernel-mode driver, as `link.exe /DRIVER` builds one: sections not paged; C runtime from `ntoskrnl.exe` |
| `efi_application`         | 10 | EFI application |
| `efi_boot_service_driver` | 11 | EFI boot-service driver |
| `efi_runtime_driver`      | 12 | EFI runtime driver |
| `efi_rom`                 | 13 | EFI ROM image |

`-mwindows` and `-mconsole` select `windows` and `console`.
A non-PE target ignores the pragma, so the same source builds for every OS.

A `console` or `windows` image links `kernel32.dll` by default, as link.exe
does through the C runtime library's `/DEFAULTLIB:kernel32.lib` and the MinGW
driver through `-lkernel32`. A function that no input resolves and kernel32
exports is imported from `kernel32.dll`, even when the source declares it
itself with no header or binding. Only referenced names are imported. The
check reads kernel32's export lists for x64 and arm64, measured from Windows
11's system images (`src/c5/linker/kernel32.exports`). A native or EFI image
takes none. user32, advapi32 and shell32, which the MinGW driver also passes
and link.exe does not, are not default libraries.

### Which headers a target has

A bundled header is served on the targets whose C library, SDK or compiler
ships it, as `libc/header-targets.txt` records. `<sys/epoll.h>` is not found
for macOS, and `__has_include(<windows.h>)` is 0 for Linux, as with the system
compilers. The tree `--install` writes holds every target's headers and
follows the same rule.

## Runtime lookup

A function no bundled header declares can be declared in the program, or
looked up at run time with `dlopen` / `dlsym` (`LoadLibrary` /
`GetProcAddress` on Windows):

```c
#include <dlfcn.h>
#include <stddef.h>

int main(void) {
    void *h = dlopen(NULL, RTLD_NOW);
    size_t (*len)(const char *) = (size_t (*)(const char *))dlsym(h, "strlen");
    return (int)len("hello, world!");   /* exits 13 */
}
```

On Linux and macOS, `dlopen(NULL, RTLD_NOW)` returns the process's global
symbol scope.

- macOS: `dlsym(h, "objc_msgSend")` gives the Objective-C runtime entry point.
  A framework is one `dlopen("/System/Library/Frameworks/X.framework/X")`
  away.
- Linux: any shared library, by soname or path.
- Windows: `libc/lib/dlfcn_ext.c` defines `dlopen` over `LoadLibraryA` and
  `dlsym` over `GetProcAddress`, so `dlopen` needs a DLL name.
  `dlopen("user32.dll", 0)` and `dlsym(h, "MessageBoxA")` give a callable
  Win32 function.

## In-process JIT (`--jit`)

`--jit` compiles for the host with the same encoder and relocations as an
image, maps the code executable in the badc process, and calls `main`. No
file is written and no process is started:

```sh
badc --jit tests/fixtures/c/c4.c tests/fixtures/c/c4_selfhost_hello.c   # c4 compiles and runs the second file
```

| host            | mapping                                                                 |
|-----------------|-------------------------------------------------------------------------|
| Linux/aarch64   | mmap RW, then mprotect RX; `dc cvau` / `ic ivau`                        |
| Linux/x86_64    | mmap RW, then mprotect RX; the I-cache is coherent                      |
| macOS/aarch64   | mmap RWX with `MAP_JIT`, `pthread_jit_write_protect_np`, `sys_icache_invalidate` |
| Windows/x86_64  | VirtualAlloc RW, then VirtualProtect RX; FlushInstructionCache          |
| Windows/aarch64 | VirtualAlloc RW, then VirtualProtect RX; FlushInstructionCache          |

Library calls go through a writable table of one slot per import, patched
before the code runs. POSIX hosts fill it with `dlopen(NULL, RTLD_NOW)` and
`dlsym`; Windows with `LoadLibraryA` per declared DLL and `GetProcAddress`.

## Optimizations

Code generation always goes through an SSA form and a graph-coloring register
allocator. The allocator colors an interference graph over phi-congruence
classes and spills to frame slots only under pressure. Without `-O`, badc still
fuses a compare with the branch that reads it, inlines `always_inline`
functions, and lets locals whose lifetimes do not overlap share a stack slot.

`-O` (`--optimize`) adds the SSA passes: promotion of locals to registers,
scalar replacement of aggregates, inlining, constant folding and propagation,
branch simplification, loop rotation, unrolling of constant-trip loops,
common-subexpression elimination, store-to-load forwarding, division by
constants, tail-call and tail-recursion elimination, and block layout. It
predefines `__OPTIMIZE__=1` and leaves `NDEBUG`, which removes `assert`, to
`-D`. `-O1`, `-O2`, `-O3`, `-Os`, `-Oz`, `-Ofast` and `-Og` select the same
single level; `-O0` turns it off.

Under `-O`, `a*b+c` becomes one fused multiply-add on both architectures, an
instruction of the [baseline](#instruction-set-baseline). `-ffp-contract=`
selects where: `on` (the default) within one expression, `off` nowhere,
`fast` wherever the product has no other use.

`examples/bench.rs` times a few computational workloads (`fib32`,
`quicksort-50k`, `matmul-50`) under the interpreter and the in-process JIT:

```sh
cargo run --release --example bench -- --iter 10
```

Assembly and SSA snapshots of the test fixtures are under `tests/snapshots/`,
where a code-generation change shows up as a diff.

## Hardening and code-model knobs

For kernel and firmware builds badc takes these options. An option it does not
implement is refused, so a configure-time probe gets a true answer.

| option | effect |
|--------|--------|
| `-mcmodel=small` | the default |
| `-mcmodel=kernel` | `linux-x64` only; implies `-fno-pic` |
| `-mcmodel=tiny` | `linux-aarch64` only |
| `-mno-sse`, `-mgeneral-regs-only` | keep the code off the floating-point and vector registers |
| `-mstrict-align` | each generated access at most as wide as its operand's alignment |
| `-fPIC`, `-fpic`, `-fPIE`, `-fpie` | position-independent `-c` object |
| `-mindirect-branch=keep\|thunk-extern\|thunk-inline` | retpoline thunks for indirect branches (x86-64) |
| `-mfunction-return=keep\|thunk-extern` | return thunk (x86-64) |
| `-mharden-sls=none\|return\|indirect-jmp\|all` | straight-line-speculation barriers (x86-64) |
| `-fcf-protection=none\|branch` | `endbr64` landing pads (x86-64); `return` and `full` are refused |
| `-mbranch-protection=none\|bti\|pac-ret[+leaf]\|standard` | AArch64 only; see [below](#aarch64-branch-protection) |

On an AArch64 target, badc accepts the four x86-64 options above and the
object does not change.

### Reserved registers

`-ffixed-REG` keeps a register out of the allocator, so no compiler-chosen
value lives in it: the shadow-call-stack register (`-ffixed-x18`), or NEON
registers a unit keeps state in (`-ffixed-q16` .. `-ffixed-q31`). Any
architectural spelling names the register (`x9` / `w9`, `q16` / `v16` / `d16`
/ `s16`, `rax` / `eax` / `ax` / `al`, `r8` / `r8d` / `r8w` / `r8b`, `xmm5`).

- The ABI still passes arguments and results through a reserved register.
- An inline-asm operand, clobber or `register` variable may still name it.
- The code generator's own scratch choices avoid it.
- Refused: the stack and frame pointers, the AArch64 link register, and the
  scratch registers the code generator needs (x16, x17, x19; r10, r11).
- A function is refused when the reservations leave its floating-point work
  no scratch register.

### Stack protector

| option | protected functions |
|--------|---------------------|
| `-fstack-protector` | a character array of at least `--param ssp-buffer-size=` bytes (default 8), or a call to `alloca`, or a variable-length array |
| `-fstack-protector-strong` | also any array, any aggregate with an array member, and any automatic object whose address is taken |
| `-fstack-protector-all` | every function |
| `-fno-stack-protector` | none; the default |

The rule reads the declared automatic objects. The canary takes
the frame's topmost slot, between the locals and the saved return address. The
prologue stores the guard there. Every return path, a tail call's included,
reloads it, compares, and calls `__stack_chk_fail` on a mismatch.

`-mstack-protector-guard=global|tls|sysreg` says where the guard comes from,
with `-mstack-protector-guard-reg=`, `-mstack-protector-guard-offset=` and
`-mstack-protector-guard-symbol=` as operands:

- The default is `%fs:0x28` on Linux/x86-64 and the C library's
  `__stack_chk_guard` object elsewhere.
- Under `-mcmodel=kernel` the segment defaults to `%gs` for the default and for a `tls` guard that names no register.
- `tls` (x86-64) reads the guard at a segment-relative offset or symbol. Naming
  a register, an offset or a symbol without the form selects it.
- `sysreg` (AArch64) reads it at an offset above a system register, such as
  `-mstack-protector-guard-reg=sp_el0 -mstack-protector-guard-offset=N`.

The protector needs a linked image, since the failure path is a relocation
against `__stack_chk_fail`. `--jit` and `--interp` refuse it, as do the
Windows targets, whose C library exports neither symbol.

### Automatic variable initialization

`-ftrivial-auto-var-init=uninitialized|zero|pattern` initializes every
automatic object declared without an initializer: scalars, aggregates, arrays
and variable-length arrays. The front end supplies the value as an ordinary
initializer where the storage is established, so every output mode carries it
and `-O` treats it as any other store.

- `pattern` stores the byte `0xFE`.
- A scalar that fits a register takes the value as a constant of its type.
  Anything wider is filled byte-wise, unrolled within the inline bound and as
  a loop past it. A variable-length array's loop follows its allocation.
- `__attribute__((uninitialized))` opts an object out, as does binding it to a
  register with `asm`.
- A declaration that a `goto` or `switch` jumps past is not covered.

`-fzero-init-padding-bits=standard|unions|all` takes every value and changes
nothing. An automatic aggregate initializer already zero-fills the whole
object, padding included, before it stores the members, for structs and
unions alike.

### Frame size

`-Wframe-larger-than=<n>` reports a function whose stack frame exceeds `n`
bytes. The frame is what the prologue reserves below the return address,
saved registers and frame record included; `alloca` and variable-length arrays
are not counted. The report breaks the size down: locals, spill slots, saved
registers, inline-asm scratch, an over-aligned region, the canary and the
frame record. The diagnostic is `frame-larger-than`, so `-Werror=` makes it
fatal and `-Wno-` silences it. `n` takes the size suffixes `kB`, `KiB`, `MB`,
`MiB`, ... Without the option no bound applies.

### AArch64 branch protection

`pac-ret` signs the return address of every function that stores the link
register: `paciasp` before the prologue, and `autiasp` after the last teardown
instruction of each epilogue, where sp, the signing modifier, again holds its
value at entry. A leaf with no frame stores no link register and is left alone
unless `+leaf` is given. `bti` puts a `BTI` landing pad at each function entry
and indirect-branch target. `standard` is `bti+pac-ret`. A signed function starts with `paciasp`, which is
itself a landing pad for the branches that reach a function entry, so it takes
no separate `BTI C`.

An ELF object built with either records it in the
`GNU_PROPERTY_AARCH64_FEATURE_1_AND` word of `.note.gnu.property`. The linker
intersects that word across its inputs, so the compiler sets a bit only where
it emitted the instructions.
