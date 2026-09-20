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

The whole-corpus parity tests build and run their fixtures across worker
threads drawn from one process-wide pool, so the bound is the total in flight
rather than a per-test width -- `cargo test` has several of those tests running
at once. The pool is sized from `available_parallelism()`: half the cores,
clamped to at least the concurrency the serial loops already reached and at
most eight. `BADC_TEST_JOBS=N` sets it explicitly for hosts whose memory does
not track their core count.

## Fixtures worth reading

Each of these under `tests/fixtures/c/` pins a distinct hard feature:

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

## Coverage

```sh
python3 scripts/coverage.py [--release] [--lcov FILE] [--html DIR] [--check PCT] [-- FILTER]
```

`scripts/coverage.py` builds and runs `cargo test --features full` with rustc's
`-C instrument-coverage` in `target/coverage`, merges the raw profile every test
process and every `badc` the CLI suites spawned wrote at exit, and reports line
and function coverage over `src/`: `llvm-cov`'s per-file table, a table per
source directory, and the twenty files with the most uncovered lines.
`src/c5/tests/` and the `tests.rs` modules are left out; test functions inside
an inline `#[cfg(test)]` module count with their file. `--check PCT` fails below
a line-coverage floor, `--clean` drops the profiles and the instrumented build.
`llvm-profdata` and `llvm-cov` come from `rustup component add llvm-tools`.

## Fuzzing

```sh
python3 scripts/csmith_fuzz.py --minutes 5 --badc target/release/badc
```

`scripts/csmith_fuzz.py` generates one C translation unit per recorded seed
with `csmith`, builds it with `badc -O0`, `badc -O` and a reference compiler,
runs all three and compares the checksum the program prints. csmith's output is
free of undefined behaviour, so a disagreement, a crash or a compile failure is
a defect in one of the compilers. Without csmith the script says so and exits 0,
as the assembler fuzz tests do; on Debian and Ubuntu it comes from the `csmith`
and `libcsmith-dev` packages.

The reference (`clang`, else `gcc`, else `cc`) is both the oracle and the gate.
It is the gate because 12.5% of the generated programs do not terminate -- a
loop control variable can be a global that a callee writes, and no generation
knob removes that -- while every terminating one runs in under 5 ms
unoptimised, measured over 120 programs under the bounds the script sets. A
case the reference cannot compile, or cannot finish in a second, is skipped
before badc sees it. The gate build is unoptimised on purpose: a csmith loop
that never ends has no side effects, so `clang -O2` deletes it and that binary
exits at once while every honest build runs forever. It is the oracle because
two badc configurations that agree can both be wrong; a runtime finding is
confirmed by rebuilding the case at `-O2`, and a reference that disagrees with
itself drops the case. With no reference compiler on the host the two badc
configurations are compared against each other, which cannot see a miscompile
they share; the run's summary says which oracle it had.

Findings are keyed by signature -- a panic's site and the shape of its message,
or the verdict with the configuration -- so one defect is reported once rather
than once per case that reaches it. Every badc invocation runs under
`RUST_BACKTRACE=1` and the backtrace is kept. `--case <seed>` reruns one case,
`--publish` files what was found, and without it the plan, the issue body and
every comment are printed and nothing is written.

`.github/workflows/csmith-fuzz.yml` runs five minutes of it daily at 03:41 UTC
on `ubuntu-latest` and `ubuntu-24.04-arm` -- one lane at a time, so the week's
issue is opened once rather than twice. Findings are appended as comments to the
issue `compiler fuzzing, <Monday>...<Sunday>` for the run's ISO week, opened
when it does not exist, and each comment links the offending source, kept
unreduced as an asset of the `fuzz-cases-v1` release. A seed reproduces only
against the same generator, so every report names its csmith version. A run
with no new signature files nothing; the job summary carries the counts either
way.

```sh
python3 scripts/c_reduce.py case.c -o small.c -- \
    badc -O0 -w -I /usr/include/csmith -o /dev/null {}
```

`scripts/c_reduce.py` shrinks a filed case: it deletes a brace-balanced region,
keeps the deletion while the command still fails the way it did on the
original, and repeats to a fixpoint. It took the case the harness files today
from 348 lines to 9. `cvise` and `creduce` do this better where they are
installed; neither is in Homebrew under those names.

`.github/workflows/asm-fuzz.yml` is the other fuzz lane: it runs the
differential encoder tests against the system assembler nightly on macOS.

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
`./scripts/validate_local_boxes.py` runs the pre-push set across the local
boxes, one lane per box plus the macOS host itself, which is a lane rather
than a driver only -- it is the matrix's only Mach-O and only SDK-libc
target. Per lane:

* `cargo test`, then `cargo test --release` over all test targets. Release
  exercises the JIT and native fixture-parity paths a debug build skips.
* the same run again under the register-pressure caps
  (`BADC_MAX_GPR=2 BADC_MAX_FPR=2`, `--features "codegen_test full"`), as CI's
  pressure matrix does -- Linux lanes only, which is all CI covers.
* the gating demos for that lane kind, run concurrently. The roster is
  `GATING_DEMOS` in the script, which records why each demo earns its
  place; `--demo-jobs` bounds how many run at a time, not which ones.
* the snapshot-drift check on every Linux lane: regenerate
  `tests/snapshots/` and fail on drift, as CI's `snapshots clean` job
  does. It needs `llvm-objdump`, since the committed snapshots were
  disassembled with it and GNU objdump's text does not match.
* the kernel step on every Linux lane: `demos/linux/verify.py --linker badc`
  over the pinned `defconfig` release -- compile, link **and** boot. A build
  that links clean and then prints nothing on the console has reached CI before,
  so the boots are part of the gate rather than an extra. A box with no emulator
  for its own architecture keeps the compile and link cover and says so in the
  summary.

The macOS lane skips the kernel step (that corpus is Linux-only), the
pressure rerun and the clippy step. `--no-kernel` and `--no-snapshots`
drop those steps; a push whose local run skipped them has no cover from
them. The script is the contract -- this description follows it.
