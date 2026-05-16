# `badc`

[![CI](https://github.com/kromych/badc/actions/workflows/ci.yml/badge.svg)](https://github.com/kromych/badc/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/kromych/badc?sort=semver&display_name=tag)](https://github.com/kromych/badc/releases/latest)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)
[![OS](https://img.shields.io/badge/OS-Linux%20%7C%20macOS%20%7C%20Windows-informational)](#native-compilation)
[![Arch](https://img.shields.io/badge/arch-x86__64%20%7C%20ARM64-informational)](#native-compilation)

`badc` (other name ideas were `betsy` and `badseed`) is a rather
small compiler of a pretty large chunk of the C language as defined in
the C99 standard. It used to be a bad one when the projects just started out and the name stuck.
It supports separate translation units and has a small linker inside it as well.

Its small footprint and embedded headers (which
you can override) give a fun one-executable experience. Its codebase
of moderate size can be a good pedagogical material. It doesn't
use AST, SSA, graph coloring algorithms and lots of exquisite optimization
passes which (chances are) might not bother you much. All told,
to stay slim, it'll never surpass the ability of multi-gigabyte compiler
suites to squeeze the last drop of perf from the machine, and that's fine.

`badc` produces real native binaries (macOs Mach-O, Linux ELF, or
Windows PE32+), on any of five targets, from any host - macOS (ARM64),
Linux (ARM64, x86_64), Windows (ARM64,x86_64) with full debug information
(can be omitted). Can also JIT into the machine code and recognize being
used as `#!` so that C source code becomes a script.

There are various demo's under [`demos`](./demos/):

* Few small-ish ones (`threads.c`, `coro_pool.c`, `hello_server.c`),
* GUI demos for macOS, Linux and Windows (`gui_hello`),
* Maze builder and solver - TBD,
* `sqlite3` - the most famous embedded database,
* `miniz` - compression, CRC32, integers, bit twiddling,
* `kissfft` - floating points, Fast Fourier Transform,
* `bzip2` - compression, integers, bit twiddling,
* `stb` - header-only C library with lots of incredible features (math
  noise generation, sound, JPEG, PNG, BMP, PSD support to name a few).
  It really stresses all of the compiler.
* `chibicc` - a small C compiler
* `tinycc` - a cool and small C toolchain
* `tweetNacCl`, `MonoCypher`, `BearSSL` - cryptography
* `Lua` - the embeddable scripting language

It can also run the code JIT-ted in-process so no binary is written
to the disk. That option might be useful for using `badc` to run the
C code as a script. Finally, there's an option to run the IR (intermediate
representation) with tracking pointer access and bounds to catch
memory issues.

It started out as a Rust port of Robert Swierczek's
[c4](https://github.com/rswier/c4) and grew from there. There has been
enough divergence from the original to call the dialect **c5**. Due to
that facetious naming the source tree spells that out as the `c5` module
and `C5Error` type.

The original `c4.c` compiler ships as a test fixture and self-hosts:

```sh
badc tests/fixtures/c/c4.c -o c4         # compile c4 to a native binary
./c4 hello.c                       # which then runs hello.c
```

or you can really crank the fun up with something like

```sh
    badc --jit tests/fixtures/c/c4.c tests/fixtures/c/c4.c tests/fixtures/c/c4.c tests/fixtures/c/c4.c
```

to run it quadro-nested :)

## How to install

If you have Rust installed, clone the repo install it with

```sh
cargo install --path .
```

Now `badc` is available on the PATH.

If you don't have Rust installed, download one of the binary release packages
matching you hardware and the OS.

## Hello, ~~world~~, 123!

A first run:

```sh
$ cargo run --quiet -- --jit hello.c # runs native code in-process

Hello 123
```

or

```sh
cargo run --quiet -- hello.c     # Produces native binary
./hello                          # produced by the previous line

Hello 123
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
| `--interp` | Run the bytecode under a watchful VM (pointer tracking, traces).   |

Flags (`--target=<spec>`, `--optimize` / `-O`, `--dump-asm`,
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

Five targets, cross-compile from any host to any of them:

| `--target=`               | format        | dylibs                              |
|---------------------------|---------------|-------------------------------------|
| `macos-aarch64` (default) | Mach-O        | `/usr/lib/libSystem.B.dylib`        |
| `linux-aarch64`           | ELF           | `libc.so.6`, `libdl.so.2`           |
| `linux-x64`               | ELF           | same                                |
| `windows-x64`             | PE32+         | `msvcrt.dll`, `kernel32.dll`        |
| `windows-arm64`           | PE32+         | same                                |

```sh
badc tests/fixtures/c/c4.c -o c4-native              # macOS host -> Mach-O
./c4-native hello.c

badc --target=linux-aarch64 tests/fixtures/c/c4.c -o c4-arm
docker run --platform linux/arm64 -v $PWD:/w debian:stable-slim /w/c4-arm /w/hello.c

badc --target=windows-x64 tests/fixtures/c/c4.c -o c4.exe
wine c4.exe hello.c
```

The Windows targets produce a PE that runs on a real Windows (x86_64, ARM64) box
or under WINE on Linux (x86_64, ARM64).

What the native backend executes faithfully: every fixture in
`tests/fixtures/c/` that runs under the VM and isn't a deliberate
safety-net check. The Mach-O, ELF, and PE paths are mirrored
test-for-test. What native mode doesn't have: the VM's runtime
safety net (`--track-pointers`, code-vs-data separation checks).
Use `--interp` if you want those.

### Multiple translation units

A single `badc` invocation can mix `.c` source files, `.o`
object files, and `.a` archives:

```sh
badc -c foo.c bar.c               # emits foo.o + bar.o (target-independent bytecode)
badc -o app foo.o bar.o           # links them into a final binary

badc --ar -o libfoo.a foo.c bar.c # bundles into a SysV ar(5) archive
badc -o app main.c -L. -l foo     # link against libfoo.a, gcc-style
```

`badc` ships its own linker -- there's no `ld` / `lld` /
`link.exe` dependency. Object files are an ELF wrapper around
c5 bytecode (target-independent at `.o` time; native lowering
happens at link), with standard `.symtab` / `.strtab` /
`.rela.*` for cross-TU symbol resolution and badc-specific
`.badc.text` / `.badc.data` / `.badc.tdata` / `.badc.tbss` /
`.badc.meta` sections carrying the payload. Archives are
ar(5) with a SysV-style symbol index. The `linker` cargo
feature -- on by default -- gates the entire pipeline; library
consumers that don't need multi-TU artifacts can opt out via
`default-features = false, features = ["std"]` to keep the
footprint slim.

Storage-class linkage follows C99 6.2.2: `static` at file
scope is internal, bare or `extern` declarations are external,
and `extern T x;` with no defining declaration becomes an
unresolved external that the linker tries to satisfy from the
remaining objects or archive members.

### What is supported

A summary of what the dialect parses + lowers, and where it
diverges from C99, lives in [`c99-gaps.md`](c99-gaps.md). Short
version: c5 covers most of the language (full preprocessor, the
integer + float arithmetic surface, structs / unions / bitfields
/ enums / typedef, function pointers, varargs, `_Thread_local`,
anonymous struct/union members, `#pragma pack(N)`, ...) on the
host platform's data model (LP64 on macOS / Linux, LLP64 on
Windows). The doc enumerates rejected idioms, divergent
behaviour, and the c5-only extensions (`#pragma dylib` /
`binding` / `export` / `entrypoint` / `subsystem`,
`#pragma once`, the bytecode VM, the in-process JIT).

One implementation choice worth flagging up front: **bare `char`
is unsigned** on every target (a 1-byte zero-extending load),
matching the AArch64 platform-ABI default. Use `signed char`
where the sign matters; gcc and clang differ on this per host
architecture, so portable code that walks bytes by sign already
spells `signed char` explicitly.

#### From the pre-processor side

The preprocessor pre-defines a small standard set, double-underscore
wrapped in the gcc / clang / msvc convention so they don't collide
with user identifiers:

```c
    __BADC_VERSION__   "0.0.6"           // crate version (string literal)
    __BADC_TARGET__    "macos-aarch64"   // canonical target id (string literal)
    __aarch64__ / __arm64__              // AArch64 targets
    __x86_64__ / __amd64__               // x86_64 targets
    _WIN32 / _WIN64                      // Windows targets only
    __BADC_WINDOWS__                     // Windows targets only
    __APPLE__                            // macOS target only
    __linux__                            // Linux targets only
```

The MSVC mimicry surface (`_MSC_VER` / `__MINGW32__` / `__int64`
/ `__declspec` / etc.) lives in `headers/include/msvc_compat.h`
and is opted into per translation unit with
`-include msvc_compat.h`.

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

c5 follows a "source picks, compiler honours" pattern for
build-time choices that historically lived on the build
driver's command line. The same shape covers dylib bindings,
exports, alignment, the entry-point name, and the Windows
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
#pragma subsystem(windows)         // pick the Windows PE subsystem (windows | console).
```

`#pragma entrypoint(<name>)` (gh #55) lets the source declare
a non-`main` entry without a build-driver flag; the compiler
resolves the name through the same symbol-table lookup it uses
for `main`. `#pragma subsystem(<kind>)` (gh #32) drives the
PE optional-header `Subsystem` byte -- `console` (default,
`IMAGE_SUBSYSTEM_WINDOWS_CUI = 3`) or `windows`
(`IMAGE_SUBSYSTEM_WINDOWS_GUI = 2`); together with
`entrypoint(WinMain)` the pair is what a Win32 GUI app needs
to skip the loader's auto-attach to a console window. Non-PE
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

Five hosts ship today:

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

`--dump-asm` produces a textual listing of the lowered code grouped
by the c5 op that produced each region.

For more, one can use `objdump`, `readelf`, etc.

### Optimizations

A couple of cheap rewrites the lowering does on its own; one
heavier pass behind `--optimize`.

The cheap ones, always on: drop self-`mov`s and fuse compare +
branch into `cmp` / `b.cond` (or `cmp` / `jcc`) without
materializing a 0/1 boolean in between. Saves one uop per pattern
on aarch64 and three on x86_64.

`--optimize` (or `-O`) adds:

* **Bytecode optimizer.** Decode into a typed IR, run peephole,
  branch-threading, and dead-code passes to a fixed point, then
  re-encode. Fuses `Psh; Imm N; <op>` into immediate-form ops.
  18-30% smaller bytecode, ~40% faster wall-clock on the c4
  self-host.
* **Per-function register allocator.** Routes pushes through a
  small register pool (callee-saved bank for values live across a
  call, caller-saved bank for short-lived values) instead of the
  default `str` / `sub rsp; mov` per arithmetic op.

Bench on macos/aarch64 (Apple M-series, `--release`, 10 iters; see
`examples/bench.rs`):

    workload          jit      jit-O
    fib32          18.05ms  10.65ms
    quicksort-50k  10.93ms   5.89ms
    matmul-50       1.31ms 345.12us

Roughly 1.7x on fib, 1.86x on quicksort, 3.8x on matmul. On
linux/x86_64 the cmp+branch fusion alone is worth 6-10% across
the same workloads.

## `--interp`: the safety-net VM

`--interp` runs the program through the bytecode interpreter
instead of compiling to native:

```sh
$ cargo run --quiet -- --interp hello.c

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

The CLI binary always builds with the default `std` feature.

## Tests

```sh
cargo test
```

Tests are split by what they exercise. `lexer`, `parser`, `codegen`,
`vm` drive each phase directly. `programs` and `intrinsics` load
real C sources from `tests/fixtures/c/` and check the exit code under
the VM. `types` checks the warning-not-error behaviour.
`pointer_tracking` exercises the opt-in safety net. `optimizer`
re-runs every fixture under `-O` and asserts the exit code didn't
change. `native`, `native_elf`, `native_elf_x64`, `native_pe_x64`,
and `native_pe_arm64` compile each fixture through the matching
backend and exec it under the host kernel. `jit` covers the
in-process path the same way.

CI runs the matrix on `ubuntu-latest`, `ubuntu-24.04-arm`,
`macos-latest`, `windows-latest`, and `windows-11-arm`. Every
runner additionally runs the demo smokes -- sqlite, miniz,
kissfft, bzip2, gui_hello -- end-to-end (or build-only for
the GUI demos, which need a display). See
[`demos/`](./demos/) for what each exercises. The PE-via-
WINE lane is gated on `BADC_RUN_WINE=1`; a bare `cargo test`
on a developer machine skips it, and CI doesn't currently
set it (the native Windows runners cover the same surface
directly).

## Tools

`tools/core-walker.py` walks the saved-rbp chain in a Linux ELF
core dump and resolves every return address to the matching
`[bc=N] OP` line in a `--dump-asm` listing. Useful when an
optimized `-O` build crashes -- the source-line debug map is
dropped at `-O`, but a non-PIE x64 binary lets us subtract the
fixed `0x400000` load base from each saved return address and
look the resulting file offset up in the dump. Modes:

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

The "subtract the load base, look up in dump-asm" idea was
suggested by [@kromych](https://github.com/kromych) while we were
chasing a `-O`-only sqlite3 crash where every higher-level
debugger path was blocked (orbstack's emulated x86_64 has no
usable ptrace; lldb on macOS arm64 sees a different binary
layout). It cuts straight through to "name the function that
was running when we crashed" without needing a working debugger
on the target.
