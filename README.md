# `badc`

`badc` is a tiny C compiler that does two things: runs your code
in-process under a watchful VM, or lowers it to a real native
binary that talks to whatever's already on the target system. It
started as a Rust port of Robert Swierczek's
[c4](https://github.com/rswier/c4) and grew from there -- structs,
type warnings, an optimizer, an in-process JIT, a rudimentary
preprocessor, per-target headers. The internal `c4` module name and
`C4Error` type are kept as a nod to the original.

The pitch in one sentence: write something that looks like a small
C program, point `--emit-native` at it, and you get a Mach-O / ELF
/ PE32+ that calls into `libSystem` / `libc` + `libdl` / `msvcrt`
+ `kernel32` and runs unmodified on the matching host. Cross-target
from anywhere to anywhere -- a macOS host happily emits an AArch64
Windows PE.

Anything c4 itself compiles, badc compiles too, with the same exit
code. The original `c4.c` ships as a fixture and self-hosts:

    badc fixtures/c/c4.c hello.c                   # badc -> c4 -> hello
    badc fixtures/c/c4.c fixtures/c/c4.c hello.c   # badc -> c4 -> c4 -> hello

## Build and run

    cargo build --release
    ./target/release/badc path/to/file.c [program args...]

A first run:

    $ cargo run --quiet -- hello.c
    Hello 123
    exit(0)

The first non-flag argument is the source file. Everything after
is forwarded to the compiled program. Flags (`--track-pointers`,
`--trace`, `--optimize`, `--emit-native`, `--target`, `--jit`) can
appear anywhere before the source.

A `.c` file may start with a shebang. With `badc` on `PATH`,
`chmod +x script.c` makes the file directly executable.

## What badc speaks

The c4 core: `int`, `char`, pointers, arrays, `if` / `else` /
`while` / `return`, enums, function calls, function pointers, the
classic libc shapes (`printf`, `malloc`, `free`, `memset`,
`memcmp`, `memcpy`, `open` / `read` / `write` / `close`, `exit`,
`getenv` / `setenv`, `dlopen` / `dlsym` / `dlclose` / `dlerror`).

What badc adds on top: `do` / `for` / `switch` / `break` /
`continue` / `goto`, block-scoped locals, bare function references
(`fp = add;` instead of `fp = &add;`), `sizeof(<expr>)`, structs
through pointers (`struct Foo *p`, `p->field`), variadic function
declarations, and a small preprocessor: `#define`, `#ifdef` /
`#ifndef`, `#if` / `#else` / `#endif` (with `==` / `!=` /
`defined(...)`), `#pragma dylib(...)` / `#pragma binding(...)`.

What it doesn't have: floats, struct values, unions. `void` is a
synonym for `char`, following c4 itself. Type checking is lax --
mismatched pointer / integer combos and arity errors print a
warning to stderr and keep going. A C-style cast silences the
warning.

The preprocessor pre-defines a small standard set, double-underscore
wrapped in the gcc / clang / msvc convention so they don't collide
with user identifiers:

    __BADC_VERSION__   "0.1.0"           crate version
    __BADC_TARGET__    "macos-aarch64"   canonical target id
    __aarch64__ / __arm64__              AArch64 targets
    __x86_64__ / __amd64__               x86_64 targets
    __BADC_WINDOWS__                     Windows targets only

POSIX-conventional integer constants (`PROT_READ`, `O_RDONLY`,
`STDIN_FILENO`, `NULL`, ...) come from each per-target header's
`#define` block, so they're visible to any source without an
`#include`. `badc --list-symbols` dumps the keyword and intrinsic
lists.

## Native compilation

`--emit-native` skips the VM and lowers the bytecode straight to
machine code, then wraps it in whatever container the target OS
wants. Five targets:

| `--target=`               | format        | dylibs                              |
|---------------------------|---------------|-------------------------------------|
| `macos-aarch64` (default) | Mach-O        | `/usr/lib/libSystem.B.dylib`        |
| `linux-aarch64`           | ELF           | `libc.so.6`, `libdl.so.2`           |
| `linux-x64`               | ELF           | same                                |
| `windows-x64`             | PE32+         | `msvcrt.dll`, `kernel32.dll`        |
| `windows-arm64`           | PE32+         | same                                |

Cross-compile from any host to any of the five:

    badc --emit-native fixtures/c/c4.c -o c4-native       # macOS
    ./c4-native hello.c

    badc --emit-native --target=linux-aarch64 fixtures/c/c4.c -o c4-arm
    docker run --platform linux/arm64 -v $PWD:/w debian:stable-slim /w/c4-arm /w/hello.c

    badc --emit-native --target=windows-x64 fixtures/c/c4.c -o c4.exe
    wine c4.exe hello.c

The Windows-on-ARM target produces a PE that runs on a real
ARM-Windows box or under wine 10's aarch64-windows DLL set on
Linux/aarch64.

What the native backend executes faithfully: every fixture in
`fixtures/c/` that runs under the VM and isn't a deliberate
safety-net check. The Mach-O, ELF, and PE paths are mirrored
test-for-test. What it doesn't have: the VM's runtime safety net
(`--track-pointers`, code-vs-data separation checks). Run under
the VM if you want those.

### Per-target headers and bindings

Every `--emit-native` build auto-prepends `headers/badc-{target}.h`
to the source before the lexer sees it. The header tells the
preprocessor which dylibs the target offers and which c4-side names
resolve to which exported symbols. A snippet:

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
lower directly (`printf`, `malloc`, the rest of the c4 list). For
anything else -- `strlen`, `qsort`, `fopen`, `socket`, the entire
Win32 API, libobjc -- the door is `dlopen` / `dlsym`:

    int main() {
        int *h, *fn;
        h = dlopen(0, 2);                 // RTLD_NOW
        fn = dlsym(h, "strlen");
        return fn("hello, world!");        // exits 13
    }

`dlopen(NULL, RTLD_NOW)` returns the calling process's symbol
scope -- libc on POSIX, the loaded set on Windows. Whatever you
look up by name with `dlsym` comes back as a callable function
pointer, and `Op::Jsri` (the indirect-call op) puts the c4 stack
args into the host ABI's argument registers before jumping.

The same shape works for `atoi`, `strchr`, `strstr`, `getenv`,
`fopen`, ... anything libc exports. Whichever target you build for,
the right symbol resolves -- macOS finds `_strlen` in
`libSystem.B.dylib`, Linux finds bare `strlen` in `libc.so.6`,
Windows reaches `strlen` in `msvcrt.dll` via
`LoadLibraryA` / `GetProcAddress` (`dlopen` and `dlsym` map to
those on Windows).

One caveat to flag honestly: variadic targets (`printf`, `sscanf`,
`fprintf`) need stack-arg layout that's per-target -- macOS AAPCS64
spills variadic args to the native stack, Linux/AArch64 keeps them
in registers, SysV x86_64 needs `AL = 0` for the XMM count.
`Op::Jsri` zeroes `AL` on SysV unconditionally, but doesn't yet
know whether the dlsym'd target is variadic, so the AAPCS64-macOS
case still mishandles spilled args. Non-variadic targets work
everywhere; variadic is a follow-up.

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

### In-process JIT

`--jit` lowers with the same encoder + relocations the AOT path
uses, mmaps the result executable, and calls `main` directly via a
transmuted function pointer. No subprocess, no on-disk binary --
parse, lower, exec all happen in the badc process:

    badc --jit fixtures/c/c4.c hello.c       # JIT'd c4 self-hosts hello.c

Three hosts ship today:

| host          | mapping                                                     |
|---------------|-------------------------------------------------------------|
| Linux/aarch64 | mmap RW -> mprotect RX, manual `dc cvau` / `ic ivau`        |
| Linux/x86_64  | mmap RW -> mprotect RX, hardware-coherent I-cache (no-op)   |
| macOS/aarch64 | mmap RWX + `MAP_JIT`, `pthread_jit_write_protect_np` toggle |

libc is bound at JIT time: a writable "fake GOT" gets
`dlopen(NULL, RTLD_NOW)` + `dlsym` for each intrinsic the program
imports, and the codegen's existing GOT relocations are patched
against this region. macOS uses Apple's `MAP_JIT` + per-thread
W^X toggle for the hardware-enforced W^X on Apple Silicon.

`--dump-asm` produces a textual listing of the lowered code grouped
by the c4 op that produced each region.

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

## Runtime safety (VM mode)

The VM keeps code, stack, and data in three distinct address ranges
and refuses to mix them. Function pointers carry a `CODE_BASE` bias;
loading or storing through one is rejected, and so is calling
through a fabricated integer (`fp = 42; fp();`) -- the call site
refuses an address it didn't originate.

`--track-pointers` opts in to allocation tracking. With it on,
`free` on an unknown or already-freed pointer errors, and any
access into a freed allocation (or past the end of a live one) is
reported with the offending allocation's id. `--trace` opts in to
a per-instruction trace on stdout (off by default -- it's noisy).

Native mode skips this safety net by design. Run under the VM if
you want it.

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
real C sources from `fixtures/c/` and check the exit code. `types`
checks the warning-not-error behaviour. `pointer_tracking`
exercises the opt-in safety net. `optimizer` re-runs every fixture
under `-O` and asserts the exit code didn't change. `native`,
`native_elf`, `native_elf_x64`, `native_pe_x64`, and
`native_pe_arm64` compile each fixture through the matching
backend and exec it under the host kernel.

CI runs the matrix on `ubuntu-latest`, `ubuntu-24.04-arm`,
`macos-latest`, `windows-latest`, and `windows-11-arm`. The Linux
runners additionally exercise the matching Windows PE through wine
as a cross-check against the native Windows runners.
