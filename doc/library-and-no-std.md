# Using badc as a library, and `no_std`

```rust
use badc::{Compiler, NativeOptions, Target, Vm, emit_native_with_options, jit_run};

let program = Compiler::new(source).compile()?;
let image = emit_native_with_options(&program, Target::LinuxX64, NativeOptions::new().with_optimize())?;
let status = jit_run(&program, &[String::from("prog")])?;
let status = Vm::new(program).with_pointer_tracking().run()?;
```

`Compiler::new(source).compile()` returns a `Program`;
`Compiler::with_options(source, target, options)` compiles for another target
with `CompileOptions`. From a `Program`:

* `emit_native` and `emit_native_with_options` return the image as bytes;
* `jit_run` and `jit_run_with_options` run it in-process on the host;
* `Vm::new(program).run()` runs it in the interpreter, and
  `with_pointer_tracking` and `with_args` configure the run.

`NativeOptions::new().with_optimize()` runs the SSA optimizer during
`emit_native_with_options` or `jit_run_with_options`; there is no separate
optimization step.

A failed `compile` returns `C5Error::Compile`, which holds the diagnostics of
the phase that failed in the order they were reported, ending with the error
that stopped it. `C5Error::diagnostics()` returns them. A successful compile
leaves its warnings in `Program::warnings`. A `Diagnostic` displays as the
driver prints it, and its `code` names a row of the catalog that
`badc --list-diagnostics` prints.

## Features

| feature | adds |
|---|---|
| `std` (default) | the lexer, preprocessor, compiler, optimizer, interpreter and in-process JIT; the `StdHost` adapter for files, environment and standard streams |
| `native-emit` | `emit_native` and the Mach-O, ELF and PE writers; requires `std` |
| `full` | `native-emit`, plus objects, archives and the linker; the `badc` binary requires it |
| `codegen_test` | register-allocator limits for tests (`BADC_MAX_GPR`, `BADC_MAX_FPR`) |

## `no_std`

The library builds without `std`:

```sh
cargo build --no-default-features --lib
```

Without `std` there is no `StdHost` and no image writer, and `jit_run`
returns an error. The lexer, preprocessor, compiler, optimizer, and
interpreter run on `alloc`. A caller
supplies its own `Host` implementation and creates the interpreter with
`Vm::with_host(program, host)`.

The command-line compiler needs `std` and `full`; see
[getting started](getting-started.md).
