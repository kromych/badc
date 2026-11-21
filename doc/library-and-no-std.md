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
* `jit_load` maps it into the process and runs its constructors without
  running `main`; the `JitModule` it returns gives the address of each
  function and object the program defines with external linkage
  (`symbol`, `symbols`) and its machine code (`code`), and dropping it runs
  the program's destructors and the `atexit` handlers registered on the
  dropping thread, as `dlclose` does. A program without `main` is compiled
  with `CompileOptions::with_no_entry_point(true)`;
* `Vm::new(program).run()` runs it in the interpreter, and
  `with_pointer_tracking`, `with_trace`, `with_args`, and
  `with_sve_vector_bits` (128 bits by default) configure the run.

`NativeOptions::new().with_optimize()` runs the SSA optimizer during
`emit_native_with_options` or `jit_run_with_options`, in a build with the
`optimizer` feature; there is no separate optimization step.

A failed `compile` returns `C5Error::Compile`, which holds the diagnostics of
the phase that failed in the order they were reported, ending with the error
that stopped it. `C5Error::diagnostics()` returns them. A successful compile
leaves its warnings in `Program::warnings`. A `Diagnostic` displays as the
driver prints it, and its `code` names a row of the catalog that
`badc --list-diagnostics` prints.

`examples/jit_symbols.rs` calls into a program loaded with the default
features; `examples/emit_image.rs` writes an executable for any target.

## Features

| feature | adds |
|---|---|
| `std` (default) | the lexer, preprocessor, compiler, interpreter and in-process JIT; the `StdHost` adapter for files, environment and standard streams |
| `headers` | the bundled C library and compiler headers; without it an `#include` searches the include path alone |
| `optimizer` | the SSA optimization passes `NativeOptions::optimize` runs; without it a lowering that asks for them fails |
| `target-aarch64`, `target-x86_64` | the backend of an architecture other than the host's, which is always built; without it a lowering for that architecture fails |
| `inline-asm` | `asm` statements; without it the compiler refuses one |
| `assembler` | file-scope `asm`, with the GNU as directives, sections and macros; requires `inline-asm`; without it the compiler refuses file-scope `asm` |
| `native-emit` | `emit_native` and the Mach-O, ELF and PE writers; requires `std` |
| `linker` | objects, archives, the native object readers and the linker, and the runtime they compile on demand; requires `native-emit` and `headers` |
| `full` | every feature above; the `badc` binary requires it |
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
