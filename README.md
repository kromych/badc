# c4rs

A Rust port of [c4](https://github.com/rswier/c4), Robert Swierczek's small
self-hosting C compiler. The compiler accepts a subset of C and targets a
stack-machine bytecode that runs in an in-process VM.

## Build and run

    cargo build --release
    ./target/release/c4rs path/to/file.c [program args...]

Running the included example:

    $ cargo run --quiet -- hello.c
    Hello 123
    exit(0)

The first argument after the binary is the source file; everything after that
is forwarded to the compiled program as `argv[1..]`. The source file's path
becomes `argv[0]`.

## Shebang

A `.c` file may start with a shebang line; the lexer skips it the same way it
skips `#include`. With `c4rs` on `PATH`:

    #!/usr/bin/env c4rs
    int main() {
        printf("hi\n");
        return 0;
    }

After `chmod +x script.c`, the file is directly executable.

## Supported C dialect

Roughly what the original c4 accepts:

- `int`, `char`, pointers (`*`, `**`, ...), arrays via `p[i]`
- `if` / `else`, `while`, `do`/`while`, `for`, `switch`/`case`/`default`,
  `break`, `continue`, `goto` + labels, `return`
- enums, function pointers
- function-style library calls: `printf`, `malloc`, `free`, `memset`, `memcmp`,
  `memcpy`, `open`, `read`, `write`, `close`, `getenv`, `setenv`, `mprotect`,
  `exit`

No preprocessor — `#`-prefixed lines (and the shebang) are silently skipped.
No structs, no floats, no `sizeof(struct ...)`. `void` is a synonym for `char`,
following c4 itself.

## Runtime safety

The VM keeps code, stack, and data in distinct address ranges and refuses to
mix them:

- Function pointers carry a `CODE_BASE` bias. Loading or storing through one
  (`*fp`) is always rejected as `code is not data`. Calling through a
  fabricated integer (`fp = 42; fp();`) is rejected at the call site.
- `mprotect(addr, len, prot)` is honoured on every load/store. `prot` uses
  the POSIX bits — `1 = read`, `2 = write`, `0 = none`.
- Pass `--track-pointers` to enable allocation tracking. With it on, `free`
  on an unknown or already-freed pointer errors, and any access into a freed
  allocation, or past the end of a live one, is reported with the offending
  allocation's id.

The first two are always on. Tracking is opt-in because it walks the
allocations list on every heap access.

Example:

    $ cat use_after_free.c
    int main() {
        int *p = malloc(8);
        *p = 1;
        free(p);
        return *p;
    }
    $ cargo run --quiet -- --track-pointers use_after_free.c
    Runtime Error: use-after-free: access at 0x50 inside freed allocation #0 (start=0x50, len=8)

## Layout

    src/main.rs          binary entry
    src/c4/mod.rs        public surface (Compiler, Program, Vm, Op, C4Error)
    src/c4/lexer.rs      tokenizer + symbol table
    src/c4/compiler.rs   recursive-descent parser; emits bytecode directly
    src/c4/vm.rs         instruction dispatch + memory model
    src/c4/op.rs         opcode enum
    fixtures/c/          C programs used by the test suite

`Compiler::new(source).compile()` returns a `Program`; `Vm::new(program,
debug).with_args(...).run()` runs it.

## Tests

    cargo test

Tests are split by phase under `src/c4/tests/`: `lexer`, `parser`, `codegen`,
`vm`, `programs`, `syscalls`, `pointer_tracking`. Programs that exercise the
full pipeline load their C source from `fixtures/c/`. The test scaffold turns
pointer tracking on by default, so the suite exercises the safety checks even
on programs that aren't meant to fail.
