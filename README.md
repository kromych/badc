# `badc`

`badc` compiles a subset of C to a bespoke stack-machine bytecode and runs it
in-process. It also is capable of producing the native code and binaries
under macOS and Linux.

It started as a straight Rust port of Robert Swierczek's
[c4](https://github.com/rswier/c4) -- the internal `c4` module name and
`C4Error` type are kept as a nod to that lineage -- and grew structs,
type warnings, an optimizer, runtime memory protection, and a no_std
mode along the way. The binary is one file (`badc`); the library is
no_std-friendly with `extern crate alloc`.

Anything c4 compiles, badc compiles, too, and with the same exit code.
The original `c4.c` ships as a fixture and self-hosts under badc:

    badc fixtures/c/c4.c hello.c                   # badc -> c4 -> hello
    badc fixtures/c/c4.c fixtures/c/c4.c hello.c   # badc -> c4 -> c4 -> hello

Of the 62 C programs in `fixtures/c/`, 27 run identically under both
compilers; the rest use badc extensions and the original c4 rejects
them at parse.

badc also has a native backend: `--emit-native` lowers the bytecode
straight to machine code wrapped in a Mach-O (macOS arm64) or ELF
(Linux arm64 / Linux x86_64) executable. The same self-host above
works against any of the three targets:

    badc --emit-native fixtures/c/c4.c -o c4-native       # macOS Mach-O
    ./c4-native hello.c

Cross-compile to Linux from any host and run via Docker / qemu / a
real Linux box:

    badc --emit-native --target=linux-aarch64 fixtures/c/c4.c -o c4-arm
    docker run --platform linux/arm64 -v $PWD:/w debian:stable-slim /w/c4-arm /w/hello.c

    badc --emit-native --target=linux-x64 fixtures/c/c4.c -o c4-x64
    docker run --platform linux/amd64 -v $PWD:/w debian:stable-slim /w/c4-x64 /w/hello.c

## Build and run

    cargo build --release
    ./target/release/badc path/to/file.c [program args...]

A quick first run:

    $ cargo run --quiet -- hello.c
    Hello 123
    exit(0)

The first non-flag argument is the source file. Everything after that
is forwarded to the compiled program -- `argv[0]` is the source path,
`argv[1..]` are the rest. Flags (`--track-pointers`, `--trace`,
`--optimize`, `--list-symbols`) can appear anywhere before or after
the source path; badc strips them out before forwarding.

### Shebang

A `.c` file may start with a shebang. The lexer skips it the same way
it skips `#include`. With `badc` on `PATH`:

    #!/usr/bin/env badc
    int main() {
        printf("hi\n");
        return 0;
    }

`chmod +x script.c` and the file is directly executable.

## What it accepts

Same core as c4:

- `int`, `char`, pointers (`*`, `**`, ...), arrays via `p[i]`
- `if` / `else`, `while`, `return`
- enums, function calls, function pointers via `Jsri`
- the library calls c4 already had: `printf`, `malloc`, `free`,
  `memset`, `memcmp`, `open`, `read`, `close`, `exit`

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
- A few more syscalls: `memcpy`, `write`, `getenv`, `setenv`,
  `mprotect`, `dlopen`, `dlsym`, `dlclose`, `dlerror`
- Variadic functions: declare with `int f(int x, ...);`. Arguments
  past the fixed prefix skip type-checking, which is what `printf`
  needs.
- Lax type checking at assignments and call sites. Mismatched
  pointer/integer combos and arity errors print a warning to stderr
  and keep going -- they never fail compilation. A C-style cast
  silences the warning: `p = (int *)5;`,
  `(struct Foo *)malloc(sizeof(struct Foo))`. The cast accepts
  `int`, `char`, any pointer depth, and `struct <Tag> *`.

What it doesn't have: a preprocessor (`#`-prefixed lines and the
shebang are silently skipped), floats, struct values, unions. `void`
is a synonym for `char`, following c4 itself.

### Predefined constants

There's no `#define`, so badc pre-binds the POSIX-conventional
constants you'd otherwise hardcode as magic numbers. They're visible
to any program without `#include`:

    PROT_NONE PROT_READ PROT_WRITE PROT_EXEC
    O_RDONLY O_WRONLY O_RDWR
    STDIN_FILENO STDOUT_FILENO STDERR_FILENO
    NULL EXIT_SUCCESS EXIT_FAILURE

`badc --list-symbols` dumps them along with the keyword and library-
call lists. The values are badc's own, not the host libc's --
`mprotect` honours `PROT_READ = 1` and `PROT_WRITE = 2` as a bitmask
exactly, so you can read and reason about your own programs without
checking what your platform happens to define.

## Runtime safety

The VM keeps code, stack, and data in three distinct address ranges
and refuses to mix them. Two checks are always on; two more are
opt-in.

- **Code is not data.** Function pointers carry a `CODE_BASE` bias.
  Loading or storing through one (`*fp`) is always rejected. So is
  calling through a fabricated integer (`fp = 42; fp();`) -- the call
  site refuses an address it didn't originate.
- **mprotect is honoured.** Every load and store is checked against
  the protection mask of its target page. `prot` uses the POSIX bits:
  `PROT_READ = 1`, `PROT_WRITE = 2`, `PROT_NONE = 0`.
- **`--track-pointers`**: opt in to allocation tracking. With it on,
  `free` on an unknown or already-freed pointer errors, and any
  access into a freed allocation (or past the end of a live one) is
  reported with the offending allocation's id.
- **`--trace`**: opt in to a per-instruction trace on stdout. Useful
  for debugging the VM itself or generated bytecode; off by default
  because it produces thousands of lines per second.

For example:

    $ cat use_after_free.c
    int main() {
        int *p = malloc(8);
        *p = 1;
        free(p);
        return *p;
    }
    $ cargo run --quiet -- --track-pointers use_after_free.c
    Runtime Error: use-after-free: access at 0x50 inside freed allocation #0 (start=0x50, len=8)

## Native compilation

`--emit-native` skips the VM and lowers the bytecode straight to
AArch64 machine code, then wraps it in whatever container the target
OS wants. Two targets ship today:

| `--target=`              | format        | notes                                       |
|--------------------------|---------------|---------------------------------------------|
| `macos-aarch64` (default) | Mach-O       | ad-hoc-signed via `codesign`                |
| `linux-aarch64`           | ELF (ET_EXEC) | links libc.so.6 + libdl.so.2               |
| `linux-x64`               | ELF (ET_EXEC) | x86_64; links libc.so.6 + libdl.so.2       |

All three share the lowering pass, branch-fixup machinery, and
data-segment / function-pointer relocation shape; the encoder and
image writer differ per arch / OS. The Mach-O writer hand-rolls load
commands, the __got/__data sections, and bind opcodes; the ELF writer
hand-rolls program headers, .dynamic, .dynsym, .dynstr, DT_HASH,
.rela.dyn, and DT_BIND_NOW eager binding -- shared between the two
ELF targets via a `Machine::{Aarch64, X86_64}` enum that picks
`e_machine`, the dynamic-linker path, the relocation type
(R_AARCH64_GLOB_DAT vs R_X86_64_GLOB_DAT), and the per-arch
`_start` stub generator.

What the native backend executes faithfully: every fixture in
`fixtures/c/` that runs under the VM and isn't a deliberate
safety-net check (`oob_*`, `mprotect_blocks_*`, `use_after_free`,
`double_free`, ...) -- the VM diagnoses those at runtime, the native
binary just hits SIGSEGV / SIGABRT or silently smashes memory, so
they're excluded by design. 47 fixtures run identically across the
VM and both native targets; the macOS and Linux paths are mirrored
test-for-test.

What the native backend doesn't have: the VM's runtime safety net
(`--track-pointers`, mprotect enforcement, code-vs-data separation
checks). Run under the VM if you want those.

### Runtime dynamic linking

`dlopen` / `dlsym` / `dlclose` / `dlerror` are first-class library
calls just like `printf` / `malloc`. Native binaries resolve them
through libc / libdl; in the VM they delegate to the host's `Host`
trait, which `StdHost` implements via real `extern "C"` libc calls.

    int main() {
        int *h;
        int *atoi_fn;
        h = dlopen(0, 2);                  // RTLD_NOW
        atoi_fn = dlsym(h, "atoi");
        return atoi_fn("123");             // exits 123
    }

Calling the dlsym'd pointer works in native mode (`Op::Jsri` loads
args into x0..x7 in addition to the c4 stack, so the AAPCS64 callee
finds them). VM mode rejects the indirect call -- there's no FFI
from the VM, so the VM diagnoses "non-code address" rather than
jumping to a real libc address.

## Optimizer

`--optimize` (or `-O`) runs a bytecode optimizer between compile and
execute. It decodes the linear text into a typed IR, runs peephole /
branch-threading / dead-code-elimination passes to a fixed point, then
re-encodes. It also fuses common 3-instruction patterns
(`Psh; Imm N; <op>` -> `<op>I N`; `Lea N; Li/Lc` -> `LdLocI/LdLocC N`)
into single-dispatch immediate-form ops, since arithmetic-with-constant
and local-variable reads dominate any non-trivial program.

Typical results on the test corpus: 18-30% smaller bytecode, ~40%
faster wall-clock on the c4 self-host. Off by default -- opt in per
run. The optimizer is a separate module (`src/c4/optimize.rs`); the
compiler itself stays single-pass.

## no_std

The library compiles under `--no-default-features`:

    cargo build --no-default-features --lib

In that mode the `StdHost` adapter (file IO, env vars, real
stdin/stdout) is gone. Consumers supply their own [`Host`] impl and
construct the VM with `Vm::with_host(program, my_host)` instead of
`Vm::new(program)`. Everything else -- lexer, compiler, VM dispatch,
pointer tracking, mprotect -- runs on `extern crate alloc`.

The CLI binary always builds with the default `std` feature.

## Layout

    src/main.rs             CLI: argv parsing + flag wiring
    src/lib.rs              re-exports the public surface
    src/c4/
      mod.rs                public types (Compiler, Program, Vm, Op, ...)
      lexer.rs              tokenizer + symbol table + predefined constants
      compiler.rs           recursive-descent parser, emits bytecode directly
      optimize.rs           opt-in bytecode optimizer (passes + immediate ops)
      op.rs                 opcode enum
      program.rs, symbol.rs, token.rs, error.rs, host.rs
      vm/
        mod.rs              instruction dispatch, memory model, mprotect
        syscalls.rs         libc-shaped syscalls (printf, malloc, ...)
      codegen/
        mod.rs              Target enum + Machine + Build/fixup types
        aarch64.rs          AArch64 encoder + bytecode->aarch64 lowering
        x86_64.rs           x86_64 encoder + bytecode->x86_64 lowering
        mach_o.rs           Mach-O writer (macOS, ad-hoc-signed)
        elf.rs              ELF writer (Linux/aarch64 + Linux/x86_64,
                            ET_EXEC + libc + libdl)
      tests/
        lexer.rs, parser.rs, codegen.rs, vm.rs    phase tests
        programs.rs, syscalls.rs, types.rs        end-to-end tests
        pointer_tracking.rs, optimizer.rs         opt-in feature tests
        native.rs                                 macOS Mach-O end-to-end
        native_elf.rs                             Linux/aarch64 ELF e2e
        native_elf_x64.rs                         Linux/x86_64 ELF e2e
    fixtures/c/             C programs the test suite loads + the
                            original c4.c

The two-line summary:
`Compiler::new(source).compile()` returns a `Program`, and
`Vm::new(program).with_args(...).run()` runs it. `optimize(program)`
sits between them when you want it.

## Tests

    cargo test

Tests are split by what they exercise. `lexer`, `parser`, `codegen`,
`vm` drive each phase directly. `programs` and `syscalls` load real C
sources from `fixtures/c/`, compile, run, and check the exit code.
`types` checks the warning-not-error behaviour and the cast-as-escape
hatch. `pointer_tracking` deliberately reaches into freed memory to
make sure the safety net catches it. `optimizer` re-runs every
fixture under `-O` and asserts the exit code didn't change.
`native` (macOS), `native_elf` (Linux/aarch64), and `native_elf_x64`
(Linux/x86_64) compile each fixture through the matching native
backend, sign / chmod-x the result, and exec it under the host
kernel; they're cfg-gated to their respective triples and skipped on
other CI lanes.

The shared scaffold turns pointer tracking on by default for every
test, so the suite exercises the safety checks even on programs that
weren't written to fail.

CI runs the matrix on `ubuntu-latest`, `ubuntu-24.04-arm`,
`macos-latest`, and `windows-latest`. The macOS runner exercises
Mach-O end-to-end; `ubuntu-24.04-arm` exercises Linux/aarch64 ELF;
`ubuntu-latest` exercises Linux/x86_64 ELF; `windows-latest` builds
the VM-only paths without native bits compiled in.
