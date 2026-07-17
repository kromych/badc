# `badc`

[![CI](https://github.com/kromych/badc/actions/workflows/ci.yml/badge.svg)](https://github.com/kromych/badc/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/kromych/badc?sort=semver&display_name=tag)](https://github.com/kromych/badc/releases/latest)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)
[![OS](https://img.shields.io/badge/OS-Linux%20%7C%20macOS%20%7C%20Windows-informational)](#native-compilation)
[![Arch](https://img.shields.io/badge/arch-x86__64%20%7C%20ARM64-informational)](#native-compilation)

`badc` is a rather small cross-platform optimizing compiler (also a compiler-as-library)
of the C language.

It had appeared out of necessity to quickly tweak how and what a C compiler emits.
Then it was captivating making it being able to become a nimble practical tool
for everyday use rather than a niche hack. Modern approaches to coding would make
building a compiler easier than that had been before I thought :)

Now `badc` implements a very large portion of the C99, C11 standards and some
popular idioms from the later standards as well as few extensions. All of that is
enough to build and test Python 3.14 on all of the five supported targets (and
there are more [`demos`](./demos/) included, read on!).

`badc`'s small footprint and embedded headers (which you can override or `--install`
to some path for tweaking or inspecting) give a one-executable experience of the
portable tools. The compiler's codebase of moderate size can be used as a small
self-sufficient toolchain or can be used as a library giving _your project_ the
ability to build C code or just run it (the default when using as a library).

A fun extension is that `badc` can automatically add the header(s)
for the standard library so the bare `hello.c` with

```c
int main() {
    puts("Hello");
    return 0;
}
```

works:

```console
info: auto-including <stdio.h> for undeclared `puts`
info: wrote file hello for target `macos-aarch64`
```

`badc` is able to produce the debug information so that the binaries it generates
can be debugged and/or their performance can be profiled (use `-g`).

`badc` optimizes when you specify `-O` and can produce code that's faster
than `clang -O0`, especially on ARM64. To get an idea of the codegen
quality, take a look at [`./tests/snapshots`](./tests/snapshots/) with assembly and
SSA snapshots of the test fixtures. The optimized binaries will run on any modern
ARM64 processor, and on x86_64 processors not older than Intel Haswell and AMD Zen
(circa 2013, the optimizer uses FMA3 instructions).

CI runs a performance comparison against tcc and clang/MSVC on every push;
the Linux x86-64 and ARM64 tables, plus the CPython build comparison, appear
in the **Summary** of the latest
[`CI` run on `master`](https://github.com/kromych/badc/actions/workflows/ci.yml?query=branch%3Amaster+is%3Asuccess).

`badc` emits position-independent code and the real native binaries (macOS Mach-O,
Linux ELF, or Windows PE32+), on any of five targets, from any host:

* macOS (`ARM64`),
* Linux (`ARM64`, `x86_64`),
* Windows ({`ARM64`, `x86_64`} `x` {`console`, `GUI`, `NT`, `driver`}).

It supports also separate translation units (always translated to ELF) and has a small
linker (so no relaxations or LTO).  `badc` tries hard not to get in the way with assumptions
on the runtime library, and `--freestanding` as available should you need that. `EFI`
is supported as well.

`badc` can also JIT-compile into the machine code in-process so no binary is written
to the disk. Finally, it recognizes being used as `#!` so that C source code becomes
a (fast) script.

There are various demo's under [`demos`](./demos/):

* Few small-ish ones ([`threads.c`](./demos/threads.c), [`coro_pool.c`](./demos/coro_pool.c), [`hello_server.c`](./demos/hello_server.c)),
* [`maze.c`](./demos/maze.c) - maze builder and solver,
* [`gui_hello`](./demos/gui_hello/) - GUI demos for macOS, Linux and Windows,
* [`wdm_driver`](./demos/wdm_driver/), [`nt_hello`](./demos/nt_hello/), [`nt_loader`](./demos/nt_loader/) - examples of the Windows native (NT) executable, Windows driver,
* [`efi_hello`](./demos/efi_hello/) - a UEFI binary,
* [`edk2`](./demos/edk2/) - TianoCore EDK II ([tianocore/edk2](https://github.com/tianocore/edk2)): a UEFI application from MdePkg linked with badc's own linker into a PE32+ EFI image, and -- the self-host rung -- badc compiling the full **UEFI firmware** from edk2 source into a reproducible OVMF (x86_64) / ArmVirtQemu AAVMF (aarch64) image, under which the app and the `qemu` Linux boot both run,
* [`sqlite3`](./demos/sqlite3/) - the most famous embedded database ([sqlite.org](https://sqlite.org)),
* [`miniz`](./demos/miniz/) - compression, CRC32, integers, bit twiddling ([richgel999/miniz](https://github.com/richgel999/miniz)),
* [`kissfft`](./demos/kissfft/) - floating points, Fast Fourier Transform ([mborgerding/kissfft](https://github.com/mborgerding/kissfft)),
* [`bzip2`](./demos/bzip2/) - compression, integers, bit twiddling ([sourceware.org/bzip2](https://sourceware.org/bzip2/)),
* [`stb`](./demos/stb/) - header-only C library with lots of incredible features (math
  noise generation, sound, JPEG, PNG, BMP, PSD support to name a few).
  It really stresses all of the compiler ([nothings/stb](https://github.com/nothings/stb)),
* [`chibicc`](./demos/chibicc/) - a small C compiler ([rui314/chibicc](https://github.com/rui314/chibicc)),
* [`tinycc`](./demos/tinycc/) - a cool and small C toolchain ([TinyCC/tinycc](https://github.com/TinyCC/tinycc)),
* [`nasm`](./demos/nasm/) ([nasm.us](https://www.nasm.us/)), [`yasm`](./demos/yasm/) ([yasm.tortall.net](https://yasm.tortall.net/)) - x86 assemblers, each built with badc and run against its own test suite,
* [`TweetNaCl`](./demos/tweetnacl/) ([tweetnacl.cr.yp.to](https://tweetnacl.cr.yp.to/)), [`Monocypher`](./demos/monocypher/) ([monocypher.org](https://monocypher.org/)), [`BearSSL`](./demos/bearssl/) ([bearssl.org](https://bearssl.org/)) - cryptography,
* [`Lua`](./demos/lua/) - the embeddable scripting language ([lua.org](https://www.lua.org/)),
* [`quickjs`](./demos/quickjs/) - JavaScript interpreter ([bellard.org/quickjs](https://bellard.org/quickjs/)),
* [`TCL`](./demos/tcl/) - Tool command language ([tcl-lang.org](https://www.tcl-lang.org/)),
* [`raylib`](./demos/raylib/) - Library for games, (there is also [`loderunner`](./demos/raylib/loderunner.c) game included) ([raylib.com](https://www.raylib.com/)),
* [`curl`](./demos/curl/) - The library and the tools that handle HTTP and friends on PCs, smart phones/watches, TVs, ... ([curl.se](https://curl.se/)),
* [`Python`](./demos/python/) - Python 3.14 ([python.org](https://www.python.org/)),
* [`qemu`](./demos/qemu/) - the QEMU system emulator ([qemu.org](https://www.qemu.org/)); badc compiles the full source (well over a thousand translation units per target) and self-links the emulator with its own linker. Both `qemu-system-aarch64` and `qemu-system-x86_64`, self-compiled and self-linked, boot a Linux kernel + busybox initramfs **through badc's own build of the UEFI firmware** (OVMF on x86_64, ArmVirtQemu/AAVMF on aarch64 -- see the `edk2` demo) to an interactive userspace shell, and power off cleanly under TCG. The entire stack -- emulator, firmware, and the EFI-stub kernel's boot path -- is badc-compiled.

Besides these, there are some fun test fixtures implementing Horner scheme, RK4,
8-Queens and more.

Finally, there's an option to run the IR (intermediate representation) with
tracking pointer access and bounds to catch memory issues.

> * `badc` used to be bad when the projects just started out and the name stuck.
>
> * There is some compiler-building jargon in this document here and there. You can
> safely skip it, and jump to the usage section right away.
>
> * For the _true_ compiler heads there is the `--dump-ssa` option which prints each
> function's SSA IR plus the register allocator's per-value placement to stderr before
> lowering.

## Lineage

It started out as a Rust port of Robert Swierczek's teeny-tiny C compiler in 4 functions
[c4](https://github.com/rswier/c4) and grew from there. There then has been enough divergence
from the original to call the dialect **c5**. Due to that facetious naming the source tree
spells that out as the `c5` module and `C5Error` type.

The venerable 4-function `c4.c` compiler ships as a test fixture and self-hosts:

```sh
badc -O -o c4 tests/fixtures/c/c4.c   # compile c4 to a native binary
./c4 hello.c                          # which then runs hello.c
```

And you can really crank the fun up with something like

```sh
badc -O --jit tests/fixtures/c/c4.c tests/fixtures/c/c4.c tests/fixtures/c/c4.c tests/fixtures/c/c4.c
```

to run it quadro-nested :)

During the development, the `badc` compiler was "spiraling" out from the stack
IR execution and evolving frontend to the 3-operand IR and SSA IR and the optimizing
backend.

It lowers through an SSA intermediate representation and a graph-coloring
register allocator, but doesn't go for the exquisite optimization passes a
titan toolchain like clang, gcc or msvc run. All told, to stay slim,
it's unlikely to surpass the ability of multi-gigabyte compiler suites to
squeeze the last drop of perf from the machine, and that's fine.

## How to install and first steps

You can download one of the binary release packages matching your
hardware and the OS. There is one small binary inside, and that's
all you should need to start using `badc`.

If you have Rust installed, clone the repo, and install it with

```sh
cargo install --path . --features full
```

or just

```sh
cargo install badc --features full
```

if you're not interested in building from the source code.

The `--features full` is required for the command-line compiler: the
crate's default feature set is the host-architecture JIT library alone
(so `cargo add badc` pulls in a slim dependency), and the `badc` binary
additionally needs the native object writers and the cross-translation-unit
linker, which the `full` feature enables.

Now `badc` is available on the PATH.

## Hello, ~~world~~, 123!

A first run:

```sh
badc --jit hello.c # runs native code in-process
```
```console
Hello 123
```

or

```sh
badc -O hello.c     # Produces native optimized binary
./hello             # produced by the previous line
```

```console
Hello 123
```

Here's a quick debugging session:

```sh
badc -g hello.c     # Build with the debug information
```
```console
info: wrote file hello for target macos-aarch64
```

Now run under the debugger (`lldb`, `gdb`, `rr`), set breakpoints, check out the local variables:

```console
lldb ./hello

(lldb) target create "./hello"
Current executable set to '/Users/krom/src/compilers/badc/hello' (arm64).
(lldb) b main
Breakpoint 1: where = hello`main + 16 at hello.c:5, address = 0x00000001000006fc
(lldb) l
note: No source available
(lldb) run
Process 19800 launched: '/Users/krom/src/compilers/badc/hello' (arm64)
Process 19800 stopped
* thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
    frame #0: 0x00000001000006fc hello`main at hello.c:5
   2    #include <stdlib.h>
   3
   4    int main() {
-> 5        int a = 123;
   6        printf("Hello %d\n", a);
   7        return 0;
   8    }
Target 0: (hello) stopped.

(lldb) n
Process 19800 stopped
* thread #1, queue = 'com.apple.main-thread', stop reason = step over
    frame #0: 0x0000000100000704 hello`main at hello.c:6
   3
   4    int main() {
   5        int a = 123;
-> 6        printf("Hello %d\n", a);
   7        return 0;
   8    }
Target 0: (hello) stopped.

(lldb) v
(int) a = 123
```

The first non-flag argument is the source file. By default `badc`
lowers it to a native binary at the obvious path next to the
source (`hello.c` -> `hello` on POSIX targets, `hello.exe` on
Windows targets); pass `-o <path>` to choose a different one.

The three execution modes:

| flag       | what it does                                                       |
|------------|--------------------------------------------------------------------|
| (default)  | Lower to a native Mach-O / ELF / PE32+ at `-o <path>` and exit.    |
| `--jit`    | Lower in-process, mmap the result, call `main` directly.           |
| `--interp` | Run the SSA IR under a watchful VM (pointer tracking, traces).     |

Flags (`--target=<spec>`, `--optimize` / `-O`, `--dump-ssa`,
`--list-symbols`, `-H` / `--show-includes`, plus the VM-only
`--track-pointers` / `--trace`) can appear anywhere before the
source. `-D NAME[=VALUE]`, `-U NAME`, `-I path`, and `-include
FILE` work the same way they do on gcc / clang. Source-driven
build flags ride on `#pragma`s -- see "Headers and bindings"
below.

A `.c` file may start with a shebang. With `badc` on `PATH`,
`chmod +x script.c` makes the file directly executable -- in
which case the shebang line picks the mode (`#!/usr/bin/env badc
--interp` for the VM, the bare form for native compilation).

## Native compilation

Five targets are supported, and you cross-compile from any host to any of them:

| `--target=`     | format        |
|-----------------|---------------|
| `macos-aarch64` | Mach-O        |
| `linux-aarch64` | ELF           |
| `linux-x64`     | ELF           |
| `windows-x64`   | PE32+         |
| `windows-arm64` | PE32+         |

### Multiple translation units

A single `badc` invocation can mix `.c` source files, `.o`
object files, and `.a` archives:

```sh
badc -c foo.c bar.c               # emits foo.o + bar.o (native ELF64 ET_REL, target pinned)
badc -o app foo.o bar.o           # links them into a final binary

badc --ar -o libfoo.a foo.c bar.c # bundles into a SysV ar(5) archive
badc -o app main.c -L. -l foo     # link against libfoo.a, gcc-style
```

`badc` ships its own linker -- there's no `ld` / `lld` /
`link.exe` dependency. Object files are standard ELF64 ET_REL
relocatables: a `.text` section of native machine code,
`.data` / `.bss` for static storage, `.symtab` / `.strtab`
for the name table, and `.rela.text` carrying the relocations
the linker applies once each unit's final position is known.
The target is pinned at `-c` time, and the objects are also
linkable by `ld` / `lld`. Executables are position-independent
(ELF `ET_DYN` / PIE, matching Mach-O); the address of -- or a
data load from -- an external symbol routes through the GOT, so a
badc `-c` object links into a PIE produced by the system
toolchain. Archives are ar(5) with a SysV-style
symbol index. The `full` cargo feature gates the entire
pipeline; library consumers that don't need
multi-TU artifacts can opt out via
`default-features = false, features = ["std"]` to keep the
footprint slim.

Storage-class linkage follows C99 6.2.2: `static` at file
scope is internal, bare or `extern` declarations are external,
and `extern T x;` with no defining declaration becomes an
unresolved external that the linker tries to satisfy from the
remaining objects or archive members.

### What is supported

A summary of what the dialect parses + lowers, and where it
diverges from C99, lives in [`std-conformance.md`](std-conformance.md). Short
version: c5 covers most of the language and few features of the later standards.
The doc enumerates rejected idioms, divergent behavior, and the c5-only extensions
(`#pragma dylib` / `binding` / `export` / `entrypoint` / `subsystem`).

#### From the pre-processor side

The preprocessor pre-defines a small standard set, double-underscore
wrapped in the gcc / clang / msvc convention so they don't collide
with user identifiers:

```c
    __BADC_VERSION__   <crate version>   // string literal from Cargo.toml, e.g. "0.0.9"
    __BADC_TARGET__    "macos-aarch64"   // canonical target id (string literal)
    __aarch64__ / __arm64__              // AArch64 targets
    __x86_64__ / __amd64__               // x86_64 targets
    _WIN32 / _WIN64                      // Windows targets only
    __BADC_WINDOWS__                     // Windows targets only
    __APPLE__                            // macOS target only
    __linux__                            // Linux targets only
```

Comparing the string-literal predefines with `#if X == "..."` is a c5
extension over C99, which restricts a `#if` controlling expression to an
integer constant expression (see `std-conformance.md`).

The MSVC/MinGW mimicry surface (`_MSC_VER` / `__MINGW32__` / `__int64`
/ `__declspec` / etc.) lives in `libc/include/msvc_compat.h`
and is opted into per translation unit with `-include msvc_compat.h`.

### Headers and bindings

The header tells the compiler which dylib's/so's/dll's the target
offers and which local names resolve to which exported symbols.
A snippet:

```c
#pragma dylib(libsystem, "/usr/lib/libSystem.B.dylib")
#pragma binding(libsystem::printf, "_printf")

int printf(char *fmt, ...);
```

The codegen drives its IAT / `.got` / `DT_NEEDED` records from
these declarations. When the source calls `printf`, the parser
type-checks the call against the prototype; the codegen looks up
the binding to learn that the loader should resolve `_printf` from
`libSystem.B.dylib`. Switching target swaps the header and the
bindings change with it -- `printf` lands on bare `printf` from
`libc.so.6` on Linux, `printf` from `msvcrt.dll` on Windows.

Validation runs at codegen entry: every intrinsic the program
*references* must have a matching binding for the chosen target.
Unused bindings cost nothing -- they describe the surface without
forcing you to pull in everything they name.

#### Source-driven build flags via `#pragma`

`badc` uses `#pragma`'s to lighten the command line. One can specify
dylib bindings, exports, alignment, the entry-point name, and the Windows
subsystem -- every knob lives next to the code it configures
so the source carries enough context to build with a bare
`badc <file>`.

```c
#pragma once                       // single-inclusion guard for headers.
#pragma dylib(libc, "libc.so.6")   // declare a dylib c5 can bind into.
#pragma binding(libc::sin, "sin")  // map a portable name to its dylib symbol.
#pragma export(my_api)             // promote a function to a shared-object export.
#pragma pack(N) / pop / push       // override the default 8-byte struct alignment.
#pragma entrypoint(WinMain)        // override the default `main` entry point.
#pragma subsystem(windows)         // pick the PE subsystem (console | windows | native | efi_*).
```

`#pragma entrypoint(<name>)` lets the source declare a
non-`main` entry without a build-driver flag; the compiler
resolves the name through the same symbol-table lookup it uses
for `main`. `#pragma subsystem(<kind>)` drives the
PE optional-header `Subsystem` byte. The accepted kinds are
`console` (default, `IMAGE_SUBSYSTEM_WINDOWS_CUI = 3`),
`windows` (`IMAGE_SUBSYSTEM_WINDOWS_GUI = 2`), `native`
(`IMAGE_SUBSYSTEM_NATIVE = 1`, with `nt` / `driver` as
aliases), and the EFI variants `efi_application`,
`efi_boot_service_driver`, `efi_runtime_driver`, and
`efi_rom`. With `console` / `windows`, `entrypoint(WinMain)`
plus `subsystem(windows)` is what a Win32 GUI app needs to
skip the loader's auto-attach to a console window. Non-PE
targets keep the default and ignore the directive, so the
same source builds for every OS.

Unknown directives (and `#include`s that don't resolve through
the search-path / embedded-header chain) emit a warning rather
than failing the build; pass `-H` / `--show-includes` to see
the gcc-`-H`-shape resolution trace on stderr.

### Reaching beyond the predefined set

If something is not available, define it yourself for a
quick fix, open an issue or use runtime linking with `dlopen` / `dlsym`
or `LoadLibrary/GetProcAddress`:

```c
int main() {
    int *h, *fn;
    h = dlopen(0, 2);                  // RTLD_NOW
    fn = dlsym(h, "strlen");
    return fn("hello, world!");        // exits 13
}
```

`dlopen(NULL, RTLD_NOW)` returns the calling process's symbol
scope -- libc on POSIX, the loaded set on Windows.

For a flavour of what's reachable from each system:

* **macOS** -- `dlsym(h, "objc_msgSend")` gives you the Objective-C
  runtime entry point. The CoreFoundation / AppKit / Foundation
  surfaces are one `dlopen("/System/Library/.../X.framework/X")`
  away.
* **Linux** -- `clock_gettime`, `nanosleep`, `pipe2`, the entire
  `pthread_*` family. Anything in `/usr/lib`'s sonames if you spell
  the path.
* **Windows** -- `dlopen` resolves to `LoadLibraryA`, so
  `dlopen("user32.dll", 0)` plus `dlsym(h, "MessageBoxA")` gives
  you a callable Win32 API entry point.

### In-process JIT (`--jit`)

Same encoder + relocations as the AOT path. badc mmaps the result
executable, resolves libc through a runtime-built fake GOT, and
calls `main` directly via a transmuted function pointer. No
subprocess, no on-disk binary -- parse, lower, exec all happen
inside the badc process:

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

libc is bound at JIT time: a writable "fake GOT" gets one entry
per resolved import, and the codegen's existing GOT relocations
are patched against this region. POSIX uses `dlopen(NULL, RTLD_NOW)` + `dlsym`
to find each symbol in the loaded process;
Windows uses `LoadLibraryA` per declared dylib (kernel32, msvcrt,
ws2_32, ...) + `GetProcAddress`. macOS uses Apple's `MAP_JIT` +
per-thread W^X toggle for the hardware-enforced W^X on Apple
Silicon.

For more, one can use `objdump`, `readelf`, etc.

### Optimizations

The codegen always lowers through an SSA intermediate
representation and a graph-coloring register allocator. A
handful of cheap rewrites run unconditionally; `--optimize`
adds a set of SSA passes on top.

Always on: drop self-`mov`s and fuse compare + branch into
`cmp` / `b.cond` (or `cmp` / `jcc`) without materializing a `0`/`1`
boolean in between. The register allocator builds an
interference graph over phi-congruence classes and colors it
greedily, spilling to frame slots only under pressure.

`examples/bench.rs` runs a few pure-computation workloads
(`fib32`, `quicksort-50k`, `matmul-50`) through the VM and the
in-process JIT and reports per-iteration timings:

```sh
cargo run --release --example bench -- --iter 10
```

## `--interp`: the safety-net VM

`--interp` runs the program through the SSA interpreter
instead of compiling to native:

```sh
$ cargo run --quiet --features full -- --interp hello.c

Hello 123
exit(0)
```

The VM keeps code, stack, and data in three distinct address ranges
and refuses to mix them. Function pointers carry a `CODE_BASE`
bias; loading or storing through one is rejected, and so is
calling through a fabricated integer (`fp = 42; fp();`) -- the
call site refuses an address it didn't originate.

`--track-pointers` opts in to allocation tracking. With it on,
`free` on an unknown or already-freed pointer errors, and any
access into a freed allocation (or past the end of a live one) is
reported with the offending allocation's id. `--trace` opts in to
a per-instruction trace on stdout (off by default -- it's noisy).

Native and JIT modes skip this safety net by design. Use
`--interp` if you want the watchful version, especially while
debugging memory-shape issues.

## no_std

The library compiles under `--no-default-features`:

```sh
cargo build --no-default-features --lib
```

In that mode the `StdHost` adapter (file IO, env vars, real
stdin/stdout) is gone. Consumers supply their own `Host` impl and
construct the VM with `Vm::with_host(program, my_host)`. Everything
else -- lexer, parser, preprocessor, VM dispatch, pointer tracking,
native backends -- runs on `extern crate alloc`.

The CLI binary requires the `std` and `full` features (see the
install section above).

## Tests

```sh
cargo test --features full
```

`--features full` runs the full suite. A bare `cargo test` exercises
only the host-only JIT library (the default feature set), gating out
the `native*`, `linker`, and `dwarf` modules that emit on-disk images.

Tests are split by what they exercise. `lexer`, `parser`, and
`codegen` drive each phase directly. `programs` and `intrinsics`
load real C sources from `tests/fixtures/c/` and check the exit
code under the SSA interpreter. `types` checks the
warning-not-error behaviour. `pointer_tracking` exercises the
opt-in safety net. `native`, `native_elf`, `native_elf_x64`,
`native_pe_x64`, and `native_pe_arm64` compile each fixture
through the matching backend and exec it under the host kernel,
including an `-O` rerun that asserts the exit code is unchanged.
`jit` covers the in-process path the same way. `linker` exercises
the multi-TU object / archive path, `dwarf` the debug-info emit,
and `deferred` the lazy-symbol resolution.

A few fixtures under `tests/fixtures/c/` are worth reading on their
own, each pinning a distinct hard feature:

* `c4.c` -- the original c4 compiler; self-hosts (see above).
* `fma_numeric_kernels.c` -- Horner polynomial evaluation, a dense
  matrix-product inner loop, and a fourth-order Runge-Kutta step, all
  multiply-add heavy; checks that the `-O` fused multiply-add
  contraction keeps single-rounding parity with the VM.
* `fma_contraction.c` -- the `a*b+c` / `a*b-c` / `c-a*b` contraction
  shapes plus explicit C99 `fma` / `fmaf`.
* `aapcs64_variadic_host_abi.c`, `sysv_variadic_host_abi.c` -- the
  per-target variadic calling conventions on the host ABI.
* `setjmp_longjmp_roundtrip.c` -- non-local control flow, including the
  CRT-free AArch64 `setjmp` / `longjmp` intrinsic on Windows.
* `struct_by_value_param.c`, `struct_by_value_return.c` -- aggregate
  pass / return through the hidden out-pointer ABI.
* `bitfield_storage_unit.c` -- C99 6.7.2.1 bitfield packing across
  storage units.

Release builds add the JIT and native fixture-parity paths that
debug builds skip:

```sh
cargo test --release --lib
```

CI runs the matrix on `ubuntu-latest`, `ubuntu-24.04-arm`,
`macos-latest`, `windows-latest`, and `windows-11-arm`. Every
runner additionally runs the demo smokes -- sqlite3, miniz,
kissfft, bzip2, tweetnacl, monocypher, bearssl, lua, stb,
chibicc, tinycc, nasm, yasm, edk2, gui_hello, nt_loader --
end-to-end (or build-only for the GUI demos, which need a
display; edk2 additionally boots its `.efi` under OVMF). See
[`demos/`](./demos/) for what each exercises. The PE-via-
WINE lane is gated on `BADC_RUN_WINE=1`; a bare `cargo test`
on a developer machine skips it, and CI doesn't currently
set it (the native Windows runners cover the same surface
directly).

## Tools

`tools/core-walker.py` walks the saved-rbp chain in a Linux ELF
core dump and reports each frame's saved return address as a
file offset into the original non-PIE x64 binary (load base
fixed at `0x400000`). Useful for naming the crashing function
when a higher-level debugger path is blocked. Modes:

* default: walk the rbp chain, resolve each frame's saved
  return address.
* `--dump-around-rbp`: print the 16 8-byte slots around `rbp`.
* `--scan-stack`: ignore the rbp chain, scan upward from `rsp`
  for any 8-byte slot that looks like a code address, and
  resolve each. Useful when stack corruption broke the rbp
  chain -- the actual return addresses are usually still on the
  stack, just no longer reachable through the saved-rbp links.
* `--list-segments`: list every PT_LOAD in the core file with
  its vaddr range. Useful for understanding where the stack and
  the emulator's mappings ended up after a corruption.

## Disclaimer for those legally enlightened

This is a personal educational/research project, it has not been
sponsored or suggested by anyone, i.e. it is a product of my own
volition. That said, in no event I'll be responsible for how you
use this project or what happens due to that. See [LICENSE](./LICENSE)
for the exact terms.
