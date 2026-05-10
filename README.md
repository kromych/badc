# `badc`

`badc` (other name ideas were `betsy` and `badseed`) is a rather
small compiler of a pretty large chunk of the C language as defined in
the C99 standard.

`badc` produces real native binaries (macOs Mach-O, Linux ELF, or
Windows PE32+), on any of five targets, from any host - macOS (ARM64),
Linux (ARM64, x86_64), Windows (ARM64,x86_64) with full debug information
(can be omitted).

There are various demo's under [`demos`](./demos/).

It can also run the code JiT-ted in-process so no binary is written
to the disk. That option might be useful for using `badc` to run the
C code as a script. Finally, there's an option to run the IR (intermediate
representation) with tracking pointer access and bounds to catch
memory issues.

## How to install

TBD

It started out as a Rust port of Robert Swierczek's
[c4](https://github.com/rswier/c4) and grew from there. There has been
enough divergence from the original to call the dialect **c5**. Due to
that facetious naming the source tree spells that out as the `c5` module
and `C5Error` type.

The original `c4.c` compiler ships as a test fixture and self-hosts:

    badc tests/fixtures/c/c4.c -o c4         # compile c4 to a native binary
    ./c4 hello.c                       # which then runs hello.c

or you can really crank the fun up with something like

    badc --jit tests/fixtures/c/c4.c tests/fixtures/c/c4.c tests/fixtures/c/c4.c tests/fixtures/c/c4.c

to run it quadro-nested :)

## Build and run from the source code

    cargo build --release
    ./target/release/badc path/to/file.c [-o <out>]

A first run:

    $ cargo run --quiet -- --jit hello.c # runs native code in-process
    Hello 123

or

    $ cargo run --quiet -- hello.c     # Produces native binary
    $ ./hello                          # produced by the previous line
    Hello 123

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
`--list-symbols`, plus the VM-only `--track-pointers` / `--trace`)
can appear anywhere before the source.

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

    badc tests/fixtures/c/c4.c -o c4-native              # macOS host -> Mach-O
    ./c4-native hello.c

    badc --target=linux-aarch64 tests/fixtures/c/c4.c -o c4-arm
    docker run --platform linux/arm64 -v $PWD:/w debian:stable-slim /w/c4-arm /w/hello.c

    badc --target=windows-x64 tests/fixtures/c/c4.c -o c4.exe
    wine c4.exe hello.c

The Windows targets produce a PE that runs on a real Windows (x86_64, ARM64) box
or under WINE on Linux (x86_64, ARM64).

What the native backend executes faithfully: every fixture in
`tests/fixtures/c/` that runs under the VM and isn't a deliberate
safety-net check. The Mach-O, ELF, and PE paths are mirrored
test-for-test. What native mode doesn't have: the VM's runtime
safety net (`--track-pointers`, code-vs-data separation checks).
Use `--interp` if you want those.

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
`binding` / `export`, `#pragma once`, the bytecode VM, the
in-process JIT).

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

    __BADC_VERSION__   "0.0.6"           crate version (string literal)
    __BADC_TARGET__    "macos-aarch64"   canonical target id (string literal)
    __aarch64__ / __arm64__              AArch64 targets
    __x86_64__ / __amd64__               x86_64 targets
    _WIN32 / _WIN64                      Windows targets only
    __BADC_WINDOWS__                     Windows targets only
    __APPLE__                            macOS target only
    __linux__                            Linux targets only

The MSVC mimicry surface (`_MSC_VER` / `__MINGW32__` / `__int64`
/ `__declspec` / etc.) lives in `headers/include/msvc_compat.h`
and is opted into per translation unit with
`-include msvc_compat.h`.

### Per-target headers and bindings

Every native build auto-prepends `headers/badc-{target}.h` to the
source before the lexer sees it. The header tells the preprocessor
which dylibs the target offers and which local names resolve to
which exported symbols. A snippet:

    #pragma dylib(libsystem, "/usr/lib/libSystem.B.dylib")
    #pragma binding(libsystem::printf, "_printf")
    int printf(char *fmt, ...);

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

### Reaching beyond the predefined set

The compiler ships a fixed set of intrinsic ops it knows how to
lower directly (`printf`, `malloc`, the rest of the historical c4
list). For anything else -- `strlen`, `qsort`, `fopen`, `socket`,
the entire Win32 API, libobjc -- the door is `dlopen` / `dlsym`:

    int main() {
        int *h, *fn;
        h = dlopen(0, 2);                  // RTLD_NOW
        fn = dlsym(h, "strlen");
        return fn("hello, world!");        // exits 13
    }

`dlopen(NULL, RTLD_NOW)` returns the calling process's symbol
scope -- libc on POSIX, the loaded set on Windows. Whatever you
look up by name with `dlsym` comes back as a callable function
pointer, and `Op::Jsri` (the indirect-call op) puts the c5 stack
args into the host ABI's argument registers before jumping.

The same shape works for `atoi`, `strchr`, `strstr`, `getenv`,
`fopen`, ... anything libc exports. Whichever target you build for,
the right symbol resolves -- macOS finds `_strlen` in
`libSystem.B.dylib`, Linux finds bare `strlen` in `libc.so.6`,
Windows reaches `strlen` in `msvcrt.dll` via
`LoadLibraryA` / `GetProcAddress` (`dlopen` and `dlsym` map to
those on Windows).

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

    badc --jit tests/fixtures/c/c4.c hello.c       # JIT'd c4 self-hosts hello.c

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
are patched against this region. POSIX uses `dlopen(NULL,
RTLD_NOW)` + `dlsym` to find each symbol in the loaded process;
Windows uses `LoadLibraryA` per declared dylib (kernel32, msvcrt,
ws2_32, ...) + `GetProcAddress`. macOS uses Apple's `MAP_JIT` +
per-thread W^X toggle for the hardware-enforced W^X on Apple
Silicon.

`--dump-asm` produces a textual listing of the lowered code grouped
by the c5 op that produced each region.

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

    $ cargo run --quiet -- --interp hello.c
    Hello 123
    exit(0)

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

    cargo build --no-default-features --lib

In that mode the `StdHost` adapter (file IO, env vars, real
stdin/stdout) is gone. Consumers supply their own `Host` impl and
construct the VM with `Vm::with_host(program, my_host)`. Everything
else -- lexer, parser, preprocessor, VM dispatch, pointer tracking,
native backends -- runs on `extern crate alloc`.

The CLI binary always builds with the default `std` feature.

## Tests

    cargo test

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
`macos-latest`, `windows-latest`, and `windows-11-arm`. The two
Windows runners additionally run the sqlite3 amalgamation smoke
(`demos/sqlite3/smoke.py`) end-to-end. The PE-via-WINE lane is
gated on `BADC_RUN_WINE=1`; a bare `cargo test` on a developer
machine skips it, and CI doesn't currently set it (the native
Windows runners cover the same surface directly).

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
