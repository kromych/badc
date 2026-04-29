# `badc`

`badc` compiles a subset of C to a bespoke stack-machine bytecode and
then either runs it in-process or lowers it to a real native binary
for macOS / Linux / Windows. It started as a Rust port of Robert
Swierczek's [c4](https://github.com/rswier/c4) -- the internal `c4`
module name and `C4Error` type are kept as a nod to that lineage --
and grew structs, type warnings, an optimizer, an in-process JIT, a
rudimentary preprocessor, and per-target headers along the way.

The headline today is the native side. `--emit-native` wraps the
lowered code in a Mach-O / ELF / PE32+ container that calls into
whatever's available on the target system's dynamic libraries:
`libSystem.B.dylib` on macOS, `libc.so.6` + `libdl.so.2` on Linux,
`msvcrt.dll` + `kernel32.dll` on Windows. Per-target header files
under `headers/badc-{target}.h` describe each binding declaratively
(`#pragma dylib(...)` + `#pragma binding(...)` + a function
prototype), and the c4 source picks them up automatically -- so
swapping target gives a binary that's bound against a different set
of dylibs without touching the source.

Anything c4 itself compiles, badc compiles too, with the same exit
code. The original `c4.c` ships as a fixture and self-hosts under
badc:

    badc fixtures/c/c4.c hello.c                   # badc -> c4 -> hello
    badc fixtures/c/c4.c fixtures/c/c4.c hello.c   # badc -> c4 -> c4 -> hello

## Build and run

    cargo build --release
    ./target/release/badc path/to/file.c [program args...]

A quick first run:

    $ cargo run --quiet -- hello.c
    Hello 123
    exit(0)

The first non-flag argument is the source file. Everything after it
is forwarded to the compiled program -- `argv[0]` is the source path,
`argv[1..]` are the rest. Flags (`--track-pointers`, `--trace`,
`--optimize`, `--emit-native`, `--target`, `--jit`) can appear
anywhere before the source path.

A `.c` file may start with a shebang (`#!/usr/bin/env badc`) -- the
preprocessor recognises it and strips it from the source.

## What it accepts

Same core as c4:

- `int`, `char`, pointers (`*`, `**`, ...), arrays via `p[i]`
- `if` / `else`, `while`, `return`
- enums, function calls, function pointers via `Jsri`
- libc shapes: `printf`, `malloc`, `free`, `memset`, `memcmp`,
  `memcpy`, `open`, `read`, `write`, `close`, `exit`, `getenv`,
  `setenv`, `dlopen`, `dlsym`, `dlclose`, `dlerror`

What badc adds on top:

- More control flow: `do`/`while`, `for`, `switch`/`case`/`default`,
  `break`, `continue`, `goto` + labels
- Block-scoped local declarations (c4 only allowed locals at function
  top)
- Bare function references -- `fp = add;` instead of `fp = &add;` --
  so function pointers actually feel ergonomic
- `sizeof(<expr>)`, not just `sizeof(<type>)`
- Structs through pointers: `struct Foo *p`, `p->field`,
  `sizeof(struct Foo)`. Self-referential pointer fields are fine.
  Struct-value locals and parameters are not -- pass a pointer.
- Variadic functions: declare with `int f(int x, ...);`. Arguments
  past the fixed prefix skip type-checking, which is what `printf`
  needs.
- A rudimentary preprocessor: `#define` (single-token replacement,
  macro-to-macro chains), `#ifdef` / `#ifndef`, `#if` / `#else` /
  `#endif` (with `==` / `!=` / `defined(NAME)` / bare-name truthiness),
  `#pragma dylib(...)` and `#pragma binding(...)`.
- Lax type checking: pointer/integer mismatches and arity errors print
  a warning to stderr and keep going. A C-style cast silences the
  warning: `p = (int *)5;`,
  `(struct Foo *)malloc(sizeof(struct Foo))`. The cast accepts `int`,
  `char`, any pointer depth, and `struct <Tag> *`.

What it doesn't have: floats, struct values, unions. `void` is a
synonym for `char`, following c4 itself.

### Predefined macros and constants

The preprocessor pre-defines a small standard set, plus per-target
identification macros that follow the gcc / clang / msvc convention
of double-underscore wrapping:

    __BADC_VERSION__   "0.1.0"        crate version (string literal)
    __BADC_TARGET__    "macos-aarch64" canonical target id
    __aarch64__        1              \ AArch64 targets
    __arm64__          1              /
    __x86_64__         1              \ x86_64 targets
    __amd64__          1              /
    __BADC_WINDOWS__   1              Windows targets only

Source can use these to gate target-specific code without conditional
compilation at the build-system level:

    #ifndef __BADC_WINDOWS__
        // POSIX-only path
    #endif

POSIX-conventional integer constants come from each per-target
header's `#define` block, so things like `PROT_READ` and `O_RDONLY`
are visible to any source without `#include`:

    PROT_NONE PROT_READ PROT_WRITE PROT_EXEC
    O_RDONLY O_WRONLY O_RDWR
    STDIN_FILENO STDOUT_FILENO STDERR_FILENO
    NULL EXIT_SUCCESS EXIT_FAILURE

`badc --list-symbols` dumps the keyword and library-call lists.

## Native compilation

`--emit-native` skips the VM and lowers the bytecode straight to
machine code, then wraps it in whatever container the target OS
wants. Five targets ship today:

| `--target=`               | format        | notes                                       |
|---------------------------|---------------|---------------------------------------------|
| `macos-aarch64` (default) | Mach-O        | ad-hoc-signed via `codesign`                |
| `linux-aarch64`           | ELF (ET_EXEC) | links libc.so.6 + libdl.so.2                |
| `linux-x64`               | ELF (ET_EXEC) | x86_64; links libc.so.6 + libdl.so.2        |
| `windows-x64`             | PE32+         | x86_64; links msvcrt.dll + kernel32.dll     |
| `windows-arm64`           | PE32+         | AArch64; same DLL set as `windows-x64`      |

Cross-compile from any host:

    badc --emit-native fixtures/c/c4.c -o c4-native       # macOS Mach-O
    ./c4-native hello.c

    badc --emit-native --target=linux-aarch64 fixtures/c/c4.c -o c4-arm
    docker run --platform linux/arm64 -v $PWD:/w debian:stable-slim /w/c4-arm /w/hello.c

    badc --emit-native --target=windows-x64 fixtures/c/c4.c -o c4.exe
    wine c4.exe hello.c

The same flow targeting AArch64 Windows produces a PE that runs on
Windows-on-ARM (or on Linux/aarch64 via wine 10's aarch64-windows
DLL set).

What the native backend executes faithfully: every fixture in
`fixtures/c/` that runs under the VM and isn't a deliberate
safety-net check. The Mach-O, ELF, and PE paths are mirrored
test-for-test.

What it doesn't have: the VM's runtime safety net
(`--track-pointers`, code-vs-data separation checks). Run under the
VM if you want those.

### Per-target headers and bindings

Every `--emit-native` build auto-prepends `headers/badc-{target}.h`
to the source before the lexer sees it. The header tells the
preprocessor which dylibs the target offers and which c4-side names
resolve to which exported symbols:

    #pragma dylib(libsystem, "/usr/lib/libSystem.B.dylib")
    #pragma binding(libsystem::printf, "_printf")
    #pragma binding(libsystem::malloc, "_malloc")
    int printf(char *fmt, ...);
    char *malloc(int size);

The codegen drives its IAT / .got / DT_NEEDED records from these
declarations. When the source calls `printf`, the parser uses the
prototype to type-check the call site; the codegen looks up the
binding to learn that the symbol the loader should resolve is
`_printf` from `/usr/lib/libSystem.B.dylib`. Switching target swaps
the header and the bindings change with it -- on Linux the same
`printf` lands on plain `printf` from `libc.so.6`; on Windows it
lands on `printf` from `msvcrt.dll`.

Validation runs at codegen entry: every libc op the program
*references* must have a `#pragma binding` for the chosen target.
Unused bindings cost nothing -- they just describe the surface.

### Reaching beyond the predefined set

`dlopen` / `dlsym` / `dlclose` / `dlerror` are first-class library
calls. Any function exported by any dylib the program can find on
the target is reachable from c4 source -- you load the library,
look up the symbol, and call the result as a function pointer.
Native binaries resolve them through libc / libdl on POSIX or
through `LoadLibraryA` / `GetProcAddress` on Windows; the source
never has to care which.

The pattern looks the same across targets:

    int main() {
        int *handle;
        int *fn;
        handle = dlopen(0, 2);          // RTLD_NOW; 0 = current process
        fn = dlsym(handle, "atoi");
        return fn("123");                // exits 123
    }

### Fun bytes-on-disk recipes

A handful of tiny programs that double as smoke tests -- they each
exercise a different bit of the surface and run identically across
all five native targets and the VM.

**dlopen + sscanf** -- the system's `sscanf` is one `dlsym` away.
This program parses two integers from a string and returns their
sum:

    int main() {
        int *h, *parse;
        int a, b;
        h = dlopen(0, 2);
        parse = dlsym(h, "sscanf");
        parse("42 7", "%d %d", &a, &b);
        return a + b;                    // exits 49
    }

The same shape works for `sprintf`, `strtol`, `strchr`, `qsort`, ...
anything libc exports. Run with `--jit` for an in-process try-out
or `--emit-native` for a real binary.

**dlopen + getaddrinfo** -- yes, networking. Reach into the host's
resolver from c4:

    int main() {
        int *h, *resolve, *freelist;
        int *result;
        int rc;
        h = dlopen(0, 2);
        resolve = dlsym(h, "getaddrinfo");
        freelist = dlsym(h, "freeaddrinfo");
        rc = resolve("example.com", 0, 0, &result);
        if (rc) { printf("resolve failed\n"); return 1; }
        printf("ok\n");
        freelist(result);
        return 0;
    }

**Per-system flavour**:

* macOS -- the Objective-C runtime is in libobjc.A.dylib and `dlopen`'s
  default handle finds it. `dlsym(0, "objc_msgSend")` returns a
  callable pointer.
* Linux -- `clock_gettime`, `nanosleep`, `pipe2`, ...; `pthread_*`
  via libpthread. The default `dlopen(0, 2)` searches everything
  already mapped into the process.
* Windows -- `dlopen(...)` resolves to `LoadLibraryA`, so
  `dlopen("user32.dll", 2)` and then `dlsym(h, "MessageBoxA")` give
  you a callable Win32 API entry point. `dlsym` resolves to
  `GetProcAddress`.

**Variadic printf with stack args** -- six-arg `printf` exercises the
calling-convention split between register-args and stack-args (Win64
spills past 4, SysV past 6):

    int main() {
        return printf("%d %d %d %d %d\n", 1, 2, 3, 4, 5);  // exits 10
    }

### In-process JIT

`--jit` lowers the program with the same encoder + relocations the
AOT path uses, mmaps the result into an executable page, and calls
`main` directly via a transmuted function pointer. No subprocess,
no on-disk binary -- arg-parsing, compile, lower, and exec all
happen in the badc process:

    badc --jit fixtures/c/c4.c hello.c       # JIT'd c4 self-hosts hello.c

The host OS / arch picks the backend automatically (there's no
cross-arch JIT). Three hosts ship today:

| host             | mapping                                                     | I-cache                  |
|------------------|-------------------------------------------------------------|--------------------------|
| Linux/aarch64    | mmap RW -> mprotect RX                                      | manual dc cvau / ic ivau |
| Linux/x86_64     | mmap RW -> mprotect RX                                      | hardware-coherent (no-op) |
| macOS/aarch64    | mmap RWX + `MAP_JIT`, `pthread_jit_write_protect_np` toggle | `sys_icache_invalidate`  |

libc binding is done at JIT time: a writable "fake GOT" region is
allocated, `dlopen(NULL, RTLD_NOW)` + `dlsym` resolves each libc
symbol the program imports, and the codegen's existing GOT-call
relocations are patched against this region. macOS uses Apple's
`MAP_JIT` + per-thread W^X toggle to satisfy the hardware-enforced
W^X on Apple Silicon.

`--dump-asm` produces a textual listing of the lowered code grouped
by the c4 op that produced each region.

### Native optimization

A couple of cheap rewrites the native lowering does on its own,
plus one heavier pass behind `--optimize`.

The encoder helpers drop self-`mov` instructions instead of emitting
them. The bigger always-on rewrite is compare-and-branch fusion:
c4's `Lt`, `Eq`, etc. normally materialize a 0/1 boolean (`cset` on
aarch64, `setcc + movzx` on x86_64) which the following `Op::Bz`
or `Op::Bnz` then tests against zero. When the compare feeds
directly into the branch we skip that round-trip: the compare emits
just `cmp`, and the branch emits `b.cond` / `jcc` reading the flags.
That saves one uop per pattern on aarch64 and three on x86_64.

`--optimize` (or `-O`) adds a per-function register allocator that
routes pushes through a small register pool (callee-saved bank for
values live across a call, caller-saved bank for short-lived
values), plus the bytecode optimizer (peephole, branch threading,
dead-code, immediate-form ops).

Bench on macos/aarch64 (Apple M-series, `--release`, 10 iters; see
`examples/bench.rs`):

    workload          jit      jit-O
    fib32          18.05ms  10.65ms
    quicksort-50k  10.93ms   5.89ms
    matmul-50       1.31ms 345.12us

`-O` is roughly 1.7x on fib, 1.86x on quicksort, and 3.8x on matmul.
On Linux/x86_64 the cmp+branch fusion alone is worth 6-10% across
the same workloads.

## Runtime safety (VM mode)

The VM keeps code, stack, and data in three distinct address ranges
and refuses to mix them.

- **Code is not data.** Function pointers carry a `CODE_BASE` bias.
  Loading or storing through one is always rejected. So is calling
  through a fabricated integer (`fp = 42; fp();`) -- the call site
  refuses an address it didn't originate.
- **`--track-pointers`**: opt in to allocation tracking. With it on,
  `free` on an unknown or already-freed pointer errors, and any
  access into a freed allocation (or past the end of a live one) is
  reported with the offending allocation's id.
- **`--trace`**: opt in to a per-instruction trace on stdout.

Native mode skips this safety net -- run under the VM if you want
it, or under `--track-pointers` for the strictest checking.

## Optimizer

`--optimize` (or `-O`) runs a bytecode optimizer between compile and
execute. It decodes the linear text into a typed IR, runs peephole,
branch-threading, and dead-code passes to a fixed point, then
re-encodes. It also fuses common 3-instruction patterns
(`Psh; Imm N; <op>` -> `<op>I N`; `Lea N; Li/Lc` -> `LdLocI/LdLocC N`)
into single-dispatch immediate-form ops.

Typical results on the test corpus: 18-30% smaller bytecode, ~40%
faster wall-clock on the c4 self-host. Off by default. The same flag
also enables the native register allocator described above, so a
single `-O` covers both halves of the pipeline.

## no_std

The library compiles under `--no-default-features`:

    cargo build --no-default-features --lib

In that mode the `StdHost` adapter (file IO, env vars, real
stdin/stdout) is gone. Consumers supply their own `Host` impl and
construct the VM with `Vm::with_host(program, my_host)` instead of
`Vm::new(program)`. Everything else -- lexer, compiler, preprocessor,
VM dispatch, pointer tracking, native backends -- runs on
`extern crate alloc`.

The CLI binary always builds with the default `std` feature.

## Tests

    cargo test

Tests are split by what they exercise. `lexer`, `parser`, `codegen`,
`vm` drive each phase directly. `programs` and `syscalls` load real
C sources from `fixtures/c/` and check the exit code. `types` checks
the warning-not-error behaviour. `pointer_tracking` exercises the
opt-in safety net. `optimizer` re-runs every fixture under `-O` and
asserts the exit code didn't change. `native` (macOS), `native_elf`
(Linux/aarch64), `native_elf_x64` (Linux/x86_64), `native_pe_x64`
(Windows/x86_64 -- run natively or through wine on macOS / Linux),
and `native_pe_arm64` (Windows/AArch64) compile each fixture through
the matching backend and exec it under the host kernel.

CI runs the matrix on `ubuntu-latest`, `ubuntu-24.04-arm`,
`macos-latest`, `windows-latest`, and `windows-11-arm`. Each Linux
runner additionally exercises the matching Windows PE through wine
as a cross-check against the native Windows runners.
