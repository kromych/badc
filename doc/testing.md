# Tests

```sh
cargo test --features full
```

`--features full` runs the full suite. A bare `cargo test` exercises only the
host-only JIT library (the default feature set), gating out the `native*`,
`linker`, and `dwarf` modules that emit on-disk images.

Tests are split by what they exercise. `lexer`, `parser`, and `codegen` drive
each phase directly. `programs` and `intrinsics` load real C sources from
`tests/fixtures/c/` and check the exit code under the SSA interpreter. `types`
checks the warning-not-error behaviour. `pointer_tracking` exercises the opt-in
safety net. `native`, `native_elf`, `native_elf_x64`, `native_pe_x64`, and
`native_pe_arm64` compile each fixture through the matching backend and exec it
under the host kernel, including an `-O` rerun that asserts the exit code is
unchanged. `jit` covers the in-process path the same way. `linker` exercises the
multi-TU object / archive path, `dwarf` the debug-info emit, and `deferred` the
lazy-symbol resolution.

Release builds add the JIT and native fixture-parity paths that debug builds
skip:

```sh
cargo test --release --lib
```

## Fixtures worth reading

A few sources under `tests/fixtures/c/` each pin a distinct hard feature:

* `c4.c` -- the original c4 compiler; self-hosts.
* `fma_numeric_kernels.c` -- Horner polynomial evaluation, a dense
  matrix-product inner loop, and a fourth-order Runge-Kutta step, all
  multiply-add heavy; checks that the `-O` fused multiply-add contraction keeps
  single-rounding parity with the VM.
* `fma_contraction.c` -- the `a*b+c` / `a*b-c` / `c-a*b` contraction shapes plus
  explicit C99 `fma` / `fmaf`.
* `aapcs64_variadic_host_abi.c`, `sysv_variadic_host_abi.c` -- the per-target
  variadic calling conventions on the host ABI.
* `setjmp_longjmp_roundtrip.c` -- non-local control flow, including the CRT-free
  AArch64 `setjmp` / `longjmp` intrinsic on Windows.
* `struct_by_value_param.c`, `struct_by_value_return.c` -- aggregate pass /
  return through the hidden out-pointer ABI.
* `bitfield_storage_unit.c` -- C99 6.7.2.1 bitfield packing across storage
  units.

## Snapshots

`tests/snapshots/` holds assembly and SSA snapshots of the fixtures, regenerated
by `scripts/snapshots.py`. A codegen change shows up there as a reviewable diff.

## CI

CI runs the matrix on `ubuntu-latest`, `ubuntu-24.04-arm`, `macos-latest`,
`windows-latest`, and `windows-11-arm`. Every runner additionally runs the demo
smokes -- sqlite3, miniz, kissfft, bzip2, tweetnacl, monocypher, bearssl, lua,
stb, chibicc, tinycc, nasm, yasm, edk2, gui_hello, nt_loader -- end to end (or
build-only for the GUI demos, which need a display; edk2 additionally boots its
`.efi` under OVMF). The cooperative-concurrency demos (libmill, libdill,
coroutines) run on the POSIX lanes and skip on Windows. The Linux kernel gate
builds, links and boots a `defconfig` kernel on both architectures; see
[the kernel page](linux-kernel.md). See [`demos/`](../demos/) for what each
demo exercises.

The PE-via-WINE lane is gated on `BADC_RUN_WINE=1`; a bare `cargo test` on a
developer machine skips it, and CI does not set it (the native Windows runners
cover the same surface directly).

CI also runs a performance comparison against tcc and clang/MSVC on every push;
the Linux x86-64 and ARM64 tables, plus the CPython build comparison, appear in
the **Summary** of the latest
[`CI` run on `master`](https://github.com/kromych/badc/actions/workflows/ci.yml?query=branch%3Amaster+is%3Asuccess).

## Pre-push validation

`./scripts/install_hooks.py` configures the git hooks.
`./scripts/validate_local_boxes.py` runs the pre-push set on the local boxes:
`cargo test`, `cargo test --release --lib`, and the sqlite3, lua, miniz,
monocypher, stb and tweetnacl demo smokes, with varying register pressure and
`--features codegen_test` as CI does.
