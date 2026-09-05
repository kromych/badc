# Using badc as a library, and `no_std`

`Compiler::new(source).compile()` returns a `Program`. From there:

* `emit_native` / `emit_native_with_options` lower it to bytes you can write to
  disk;
* `jit_run` / `jit_run_with_options` load and execute it in-process;
* `Vm::new(program).run` interprets the pre-lifted SSA functions under a
  pointer-tracking runtime;
* `optimize` sits between compile and any of those.

A failed `compile` returns `C5Error::Compile`, which carries every
diagnostic the failed phase reported, the error that ended it last; a
successful one leaves its warnings in `Program::warnings`. A
`Diagnostic` prints itself as the driver would, and its `code` names a
row of the catalogue `badc --list-diagnostics` prints.

The default feature set is the host-architecture JIT library alone, so
`cargo add badc` pulls in a slim dependency. The native object writers and the
cross-translation-unit linker come with the `full` feature, which the `badc`
binary requires.

## `no_std`

The library compiles under `--no-default-features`:

```sh
cargo build --no-default-features --lib
```

In that mode the `StdHost` adapter (file IO, env vars, real stdin/stdout) is
gone. Consumers supply their own `Host` impl and construct the VM with
`Vm::with_host(program, my_host)`. Everything else -- lexer, parser,
preprocessor, VM dispatch, pointer tracking, native backends, optimizer -- runs
on `extern crate alloc`.

The CLI binary requires the `std` and `full` features; see
[getting started](getting-started.md).
