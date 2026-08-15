# Native compilation

Five targets, cross-compiled from any host to any of them:

| `--target=`     | format        |
|-----------------|---------------|
| `macos-aarch64` | Mach-O        |
| `linux-aarch64` | ELF           |
| `linux-x64`     | ELF           |
| `windows-x64`   | PE32+         |
| `windows-arm64` | PE32+         |

Executables are position-independent (ELF `ET_DYN` / PIE, matching Mach-O).
`--freestanding` drops the embedded startup runtime; EFI images are supported
through the PE subsystem selector.

## Multiple translation units

A single `badc` invocation can mix `.c` sources, `.o` objects, and `.a`
archives:

```sh
badc -c foo.c bar.c               # emits foo.o + bar.o (ELF64 ET_REL, target pinned)
badc -o app foo.o bar.o           # links them into a final binary

badc --ar -o libfoo.a foo.c bar.c # bundles into a SysV ar(5) archive
badc -o app main.c -L. -l foo     # link against libfoo.a, gcc-style
```

badc ships its own linker -- there is no `ld` / `lld` / `link.exe`
dependency. Object files are standard ELF64 ET_REL relocatables: a `.text`
section of native machine code, `.data` / `.bss` for static storage,
`.symtab` / `.strtab` for the name table, and `.rela.text` carrying the
relocations the linker applies once each unit's final position is known. The
target is pinned at `-c` time, and the objects are also linkable by `ld` /
`lld`. The address of -- or a data load from -- an external symbol routes
through the GOT, so a badc `-c` object links into a PIE produced by the system
toolchain. Archives are ar(5) with a SysV-style symbol index.

The `full` cargo feature gates the entire pipeline; library consumers that do
not need multi-TU artifacts can opt out via `default-features = false, features
= ["std"]` to keep the footprint slim.

Storage-class linkage follows C99 6.2.2: `static` at file scope is internal,
bare or `extern` declarations are external, and `extern T x;` with no defining
declaration becomes an unresolved external that the linker tries to satisfy
from the remaining objects or archive members.

## Linking

The linker also takes GNU-ld-shaped work directly: linker scripts
(`-T` / `--script`), `--emit-relocs`, `-z` keywords,
`--build-id`, link maps (`-Map`, `--print-map`), `--whole-archive` spans, and
symbol-export control (`--export-all`, `--export-data`). Invoked as `ld`,
`ld.badc`, or with `--ld`, badc presents a GNU ld persona with its own flag
table, which is what lets it stand in for `LD=` in an existing build --
including [the Linux kernel's](linux-kernel.md).

## What is supported

c5 covers most of C99, the C11 and C23 features real code gates on, and a wide
GCC extension surface. [`std-conformance.md`](std-conformance.md) enumerates
the rejected idioms, the divergent behavior, and the c5-only extensions.

### From the preprocessor side

The preprocessor predefines a standard set, double-underscore wrapped in the
gcc / clang / msvc convention so it does not collide with user identifiers:

```c
    __BADC_VERSION__   <crate version>   // string literal from Cargo.toml, e.g. "0.4.0"
    __BADC_TARGET__    "macos-aarch64"   // canonical target id (string literal)
    __aarch64__ / __arm64__              // AArch64 targets
    __x86_64__ / __amd64__               // x86_64 targets
    _WIN32 / _WIN64                      // Windows targets only
    __BADC_WINDOWS__                     // Windows targets only
    __APPLE__                            // macOS target only
    __linux__                            // Linux targets only
```

alongside the C99 / C11 set (`__STDC__`, `__STDC_VERSION__`, `__SIZEOF_*__`,
`__BYTE_ORDER__`, the `__ATOMIC_*` orders) and, under `--gnu`, the GCC
identity macros. `std-conformance.md` lists them all.

Comparing the string-literal predefines with `#if X == "..."` is a c5 extension
over C99, which restricts a `#if` controlling expression to an integer constant
expression.

The MSVC/MinGW mimicry surface (`_MSC_VER` / `__MINGW32__` / `__int64` /
`__declspec` / etc.) lives in `libc/include/msvc_compat.h` and is opted into
per translation unit with `-include msvc_compat.h`.

## Headers and bindings

The header tells the compiler which dylibs / shared objects / DLLs the target
offers and which local names resolve to which exported symbols:

```c
#pragma dylib(libsystem, "/usr/lib/libSystem.B.dylib")
#pragma binding(libsystem::printf, "_printf")

int printf(char *fmt, ...);
```

The codegen drives its IAT / `.got` / `DT_NEEDED` records from these
declarations. When the source calls `printf`, the parser type-checks the call
against the prototype; the codegen looks up the binding to learn that the
loader should resolve `_printf` from `libSystem.B.dylib`. Switching target
swaps the header and the bindings change with it -- `printf` lands on bare
`printf` from `libc.so.6` on Linux, `printf` from `msvcrt.dll` on Windows.

Validation runs at codegen entry: every intrinsic the program *references*
must have a matching binding for the chosen target. Unused bindings cost
nothing -- they describe the surface without forcing you to pull in everything
they name.

### Source-driven build flags via `#pragma`

badc uses `#pragma`s to lighten the command line. Dylib bindings, exports,
alignment, the entry-point name, and the Windows subsystem each live next to
the code they configure, so the source carries enough context to build with a
bare `badc <file>`.

```c
#pragma once                       // single-inclusion guard for headers.
#pragma dylib(libc, "libc.so.6")   // declare a dylib c5 can bind into.
#pragma binding(libc::sin, "sin")  // map a portable name to its dylib symbol.
#pragma export(my_api)             // promote a function to a shared-object export.
#pragma pack(N) / pop / push       // override the default 8-byte struct alignment.
#pragma entrypoint(WinMain)        // override the default `main` entry point.
#pragma subsystem(windows)         // pick the PE subsystem (console | windows | native | efi_*).
```

`#pragma entrypoint(<name>)` lets the source declare a non-`main` entry without
a build-driver flag; the compiler resolves the name through the same
symbol-table lookup it uses for `main`. `#pragma subsystem(<kind>)` drives the
PE optional-header `Subsystem` byte. The accepted kinds are `console`
(default, `IMAGE_SUBSYSTEM_WINDOWS_CUI = 3`), `windows`
(`IMAGE_SUBSYSTEM_WINDOWS_GUI = 2`), `native` (`IMAGE_SUBSYSTEM_NATIVE = 1`,
with `nt` / `driver` as aliases), and the EFI variants `efi_application`,
`efi_boot_service_driver`, `efi_runtime_driver`, and `efi_rom`. With `console`
/ `windows`, `entrypoint(WinMain)` plus `subsystem(windows)` is what a Win32
GUI app needs to skip the loader's auto-attach to a console window. Non-PE
targets keep the default and ignore the directive, so the same source builds
for every OS.

Unknown `#pragma`s and unknown preprocessor directives warn rather than
failing the build. An `#include` that resolves through neither the search paths
nor the embedded headers is an error, as in gcc / clang; pass `-H` /
`--show-includes` for the gcc-`-H`-shape resolution trace on stderr.

## Reaching beyond the predefined set

If something is not available, declare it yourself, or use runtime linking with
`dlopen` / `dlsym` (or `LoadLibrary` / `GetProcAddress`):

```c
int main() {
    int *h, *fn;
    h = dlopen(0, 2);                  // RTLD_NOW
    fn = dlsym(h, "strlen");
    return fn("hello, world!");        // exits 13
}
```

`dlopen(NULL, RTLD_NOW)` returns the calling process's symbol scope -- libc on
POSIX, the loaded set on Windows.

For a flavour of what is reachable from each system:

* **macOS** -- `dlsym(h, "objc_msgSend")` gives the Objective-C runtime entry
  point. The CoreFoundation / AppKit / Foundation surfaces are one
  `dlopen("/System/Library/.../X.framework/X")` away.
* **Linux** -- `clock_gettime`, `nanosleep`, `pipe2`, the entire `pthread_*`
  family. Anything in `/usr/lib`'s sonames if you spell the path.
* **Windows** -- `dlopen` resolves to `LoadLibraryA`, so `dlopen("user32.dll",
  0)` plus `dlsym(h, "MessageBoxA")` gives a callable Win32 API entry point.

## In-process JIT (`--jit`)

Same encoder and relocations as the AOT path. badc mmaps the result
executable, resolves libc through a runtime-built fake GOT, and calls `main`
directly via a transmuted function pointer. No subprocess, no on-disk binary --
parse, lower and exec all happen inside the badc process:

```sh
badc --jit tests/fixtures/c/c4.c hello.c       # JIT'd c4 self-hosts hello.c
```

Five hosts are supported:

| host           | mapping                                                              |
|----------------|----------------------------------------------------------------------|
| Linux/aarch64  | mmap RW -> mprotect RX, manual `dc cvau` / `ic ivau`                 |
| Linux/x86_64   | mmap RW -> mprotect RX, hardware-coherent I-cache (no-op)            |
| macOS/aarch64  | mmap RWX + `MAP_JIT`, `pthread_jit_write_protect_np` toggle          |
| Windows/x86_64 | VirtualAlloc RW -> VirtualProtect RX, FlushInstructionCache (no-op)  |
| Windows/aarch64| VirtualAlloc RW -> VirtualProtect RX, FlushInstructionCache          |

libc is bound at JIT time: a writable fake GOT gets one entry per resolved
import, and the codegen's existing GOT relocations are patched against this
region. POSIX uses `dlopen(NULL, RTLD_NOW)` + `dlsym` to find each symbol in
the loaded process; Windows uses `LoadLibraryA` per declared dylib (kernel32,
msvcrt, ws2_32, ...) + `GetProcAddress`. macOS uses Apple's `MAP_JIT` plus the
per-thread W^X toggle the hardware requires on Apple Silicon.

## Optimizations

The codegen always lowers through an SSA intermediate representation and a
graph-coloring register allocator. A handful of cheap rewrites run
unconditionally; `--optimize` adds a set of SSA passes on top.

Always on: drop self-`mov`s and fuse compare + branch into `cmp` / `b.cond`
(or `cmp` / `jcc`) without materializing a `0`/`1` boolean in between. The
register allocator builds an interference graph over phi-congruence classes and
colors it greedily, spilling to frame slots only under pressure.

`--optimize` (`-O`, and the `-O1`/`-O2`/`-O3`/`-Os`/`-Oz`/`-Ofast`/`-Og`
spellings, which all select the same single level) runs mem2reg, inlining,
rotate and branch const-folding, and immediate dedup, and predefines `NDEBUG=1`
and `__OPTIMIZE__=1`.

Optimized binaries run on any modern ARM64 processor, and on x86_64 processors
not older than Intel Haswell and AMD Zen (circa 2013 -- the optimizer emits
FMA3).

`examples/bench.rs` runs a few pure-computation workloads (`fib32`,
`quicksort-50k`, `matmul-50`) through the VM and the in-process JIT and reports
per-iteration timings:

```sh
cargo run --release --example bench -- --iter 10
```

Assembly and SSA snapshots of the test fixtures live under
[`tests/snapshots/`](../tests/snapshots/), where a codegen change shows up as a
reviewable diff.

## Hardening and code-model knobs

For kernel and firmware work the driver accepts the shapes those builds
require: `-mcmodel=small|kernel|tiny`, `-mno-sse` / `-mgeneral-regs-only`
(keep codegen off the FP/SIMD register file), `-mstrict-align`,
`-fPIC`/`-fpic`/`-fPIE`/`-fpie`, `-mindirect-branch=` and `-mfunction-return=`
(retpolines), `-mharden-sls=`, `-fcf-protection=branch` (`endbr64`), and
`-mbranch-protection=none|bti|pac-ret|standard`. Options badc does not implement
are rejected rather than accepted and ignored, so a configure-time probe gets a
truthful answer.

`pac-ret` signs the return address of every function that stores the link
register: `paciasp` ahead of the prologue, `autiasp` after the last teardown
instruction of each epilogue, where sp -- the signing modifier -- holds its
function-entry value again. A frameless leaf never stores the link register and
is left alone. `standard` is `bti+pac-ret`; a signed function opens with
`paciasp`, which is itself a landing pad for the branch types a function entry
is reached with, so it takes no separate `BTI C`. An aarch64 object built with
either claims the matching bits in a `.note.gnu.property`
`GNU_PROPERTY_AARCH64_FEATURE_1_AND` word. The linker intersects that word
across inputs, so the compiler sets a bit only where it emitted the
instructions.
