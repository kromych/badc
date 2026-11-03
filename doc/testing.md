# Testing

This page covers the test suites, the fixtures and snapshots, coverage,
fuzzing, the benchmarks, CI, and the checks to run before a push.

## Contents

* [Running the tests](#running-the-tests)
* [Suites](#suites)
* [Fixtures worth reading](#fixtures-worth-reading)
* [Snapshots](#snapshots)
* [Coverage](#coverage)
* [Fuzzing](#fuzzing)
  * [csmith](#csmith)
  * [Reducing a case](#reducing-a-case)
  * [Assembler encodings](#assembler-encodings)
* [Benchmarks](#benchmarks)
* [CI](#ci)
* [Before a push](#before-a-push)
  * [Git hooks](#git-hooks)
  * [The local gate](#the-local-gate)

## Running the tests

```sh
cargo test --features full
```

`--features full` builds every suite. Without it, `cargo test` builds the
default feature set and leaves out the suites that write native images: the
backends, the linker, DWARF, and the `tests/cli_*.rs` suites that run the
`badc` binary.

`python3 scripts/cargo_test.py --features full` runs the same tests and also
fails a test binary that exits 0 before reporting every test it announced,
which `cargo test` lets pass. CI and the local gate run the tests this way.

A release build, `cargo test --release --features full`, adds a few tests that
are too slow in a debug build: calls with large stack-argument areas, and the
checks that the front end's cost grows linearly with input size. A debug build
checks the `debug_assert!` invariants, which a release build skips, so run
both.

The fixture suites build and run their fixtures on one pool of worker threads
shared by every suite running at the same time. The pool has half as many
threads as the host has cores, at least min(cores, 4) and at most 8.
`BADC_TEST_JOBS=N` sets the size, for hosts with little memory per core.

The tests that run Windows images under Wine on Linux or macOS run only with
`BADC_RUN_WINE=1`. CI does not set it; its Windows runners run the images
directly.

## Suites

Unit tests sit beside the code, in `tests.rs` modules and `#[cfg(test)]`
blocks, and in `src/c5/tests/`, one module per subject. The main modules:

| module | what it checks |
|---|---|
| `lexer`, `parser` | tokens; the diagnostics for malformed source |
| `types` | type checking, diagnostic levels and diagnostic pragmas |
| `programs` | fixtures from `tests/fixtures/c/` run in the interpreter with pointer tracking on, checked by exit code |
| `intrinsics` | `argv`, environment variables and writes to the standard streams, in the interpreter |
| `pointer_tracking` | the interpreter's allocation checks |
| `native`, `native_elf`, `native_elf_x64`, `native_pe_x64`, `native_pe_arm64` | fixtures compiled for one target, run at `-O0` and at `-O`, checked by exit code |
| `jit` | the same fixtures through the in-process JIT |
| `linker`, `relocatable` | linking objects, and merging them with `-r` |
| `reloc_golden` | the bytes and relocations of each fixture's object, pinned by digest |
| `dwarf` | debug information, read back with `lldb` |
| `deferred` | the `deferred_*.c` fixtures, for behavior not yet right; those that fail are marked `#[ignore]`, and `cargo test -- --ignored` runs them |

A backend module runs only where its images can run: `native` and `dwarf` on
macOS, `native_elf` on Linux ARM64, `native_elf_x64` on Linux x86-64,
`native_pe_x64` on Windows x64, `native_pe_arm64` on Windows ARM64, and `jit`
on Linux and on macOS ARM64. The two PE modules also run under Wine with
`BADC_RUN_WINE=1`. The expected exit codes are in
`src/c5/tests/fixture_tables.rs`; each was measured from gcc and clang builds
of the fixture.

The `tests/cli_*.rs` suites run the `badc` binary: fixtures built through the
driver, the assembler, the linker, `-M` dependency output, `-g` options and
DWARF, frame layout, and reproducible output.

## Fixtures worth reading

Each of these files under `tests/fixtures/c/` covers one feature that is hard
to get right:

* `c4.c`: the original c4 compiler, which badc compiles and which runs itself.
* `fma_numeric_kernels.c`: Horner polynomial evaluation, a dense matrix
  product and a fourth-order Runge-Kutta step, checked within a tolerance at
  `-O`, where badc fuses multiply-adds, and at `-O0`, where it does not.
* `fma_contraction.c`: the `a*b+c`, `a*b-c` and `c-a*b` contraction shapes,
  and C99 `fma` and `fmaf`.
* `aapcs64_variadic_host_abi.c`, `sysv_variadic_host_abi.c`: variadic calls
  under the AArch64 and x86-64 calling conventions.
* `setjmp_longjmp_roundtrip.c`: C99 7.13 non-local jumps out of a deep call
  chain. On Windows they go through msvcrt's `_setjmp` or `_setjmpex`.
* `struct_by_value_param.c`, `struct_by_value_return.c`: structures passed
  and returned by value.
* `bitfield_storage_unit.c`: C99 6.7.2.1 bit-field packing across storage
  units.

## Snapshots

`tests/snapshots/` holds three files per fixture: the SSA dump
(`ssa/<name>.ssa`) and the disassembly for linux-x64 and linux-aarch64
(`asm/<name>.x64.asm`, `asm/<name>.aarch64.asm`). A code generation change
shows up there as a diff to review.

```sh
python3 scripts/snapshots.py                  # regenerate every snapshot
python3 scripts/snapshots.py --only c4        # regenerate one fixture's
python3 scripts/snapshots.py --check          # regenerate, fail on any difference
```

The script prefers `llvm-objdump`, and the committed snapshots were written
with it; GNU objdump's text differs. The `post-commit` hook regenerates the
snapshots after each commit, and CI's `snapshots clean` job fails on any
difference.

## Coverage

```sh
python3 scripts/coverage.py [--release] [--lcov FILE] [--html DIR] [--check PCT] [-- FILTER]
```

`scripts/coverage.py` builds and runs `cargo test --features full` with
rustc's `-C instrument-coverage` in `target/coverage`. It merges the profile
of every test process and of every `badc` the CLI suites start, and reports
line and function coverage over `src/`: a table per file, a table per
directory, and the twenty files with the most uncovered lines.
`src/c5/tests/` and the `tests.rs` modules are left out; a `#[cfg(test)]`
block counts with its file. `--check PCT` fails below a line-coverage floor,
and `--clean` deletes the profiles and the instrumented build. The tools come
from `rustup component add llvm-tools`.

## Fuzzing

### csmith

```sh
python3 scripts/csmith_fuzz.py --minutes 5 --badc target/release/badc
```

`scripts/csmith_fuzz.py` generates C programs with csmith. It builds each
with a reference compiler (`clang`, else `gcc`, else `cc`), with `badc -O0`
and with `badc -O`, runs the three binaries and compares the checksums they
print. csmith's programs have no undefined behavior, so a disagreement, a
crash or a failed build is a compiler defect. Every badc build runs with
`--verify-ssa`.

The reference compiler decides which cases count:

* A case is skipped unless the reference, without optimization, builds it,
  finishes within a second and prints a checksum. Some csmith programs never
  terminate, and this drops them.
* A runtime finding is confirmed by rebuilding the case with the reference at
  `-O2`. A case on which the two reference builds disagree is dropped.
* Without a reference compiler, the two badc builds are compared with each
  other. That cannot catch a miscompile both share; the summary says which
  comparison ran.

Without csmith or its headers the script exits 2, or 0 under
`--skip-without-csmith`. Debian and Ubuntu package csmith as `csmith` and
`libcsmith-dev`, Fedora as `csmith` and `csmith-devel`. Fedora puts the
headers directly in `/usr/include`; the script copies them into its scratch
directory, so that badc's own C library headers stay ahead of the system's.

Findings are grouped by signature: the panic site and the shape of its
message, or the verdict and the build. Each badc run keeps its
`RUST_BACKTRACE=1` backtrace. Other options:

| option | effect |
|---|---|
| `--case <seed>` | rerun one case |
| `--leg <leg>` | `default`; `inline-cap-4096`, badc with `--inline-cap=4096`; `pressure`, two registers per bank, which needs a `codegen_test` build; `gnu`, csmith 2.4.0's GNU C extensions |
| `--reduce-minutes N` | spend up to N minutes shrinking new findings with `cvise` or `creduce` from `PATH`, else with `scripts/c_reduce.py` |
| `--publish` | file the findings; without it the script prints what it would file |

`.github/workflows/csmith-fuzz.yml` runs all four legs, five minutes each,
daily at 03:41 UTC on Linux x86-64 and then on Linux ARM64. Each new finding
becomes a comment on the issue `compiler fuzzing, <Monday>...<Sunday>` for
the ISO week, which the run opens if needed. The comment links the source,
kept as an asset of the `fuzz-cases-v1` release with its reduction beside it,
and names the csmith version, since a seed reproduces only with the same
generator. A run with no new signature files nothing; the job summary has the
counts either way.

### Reducing a case

```sh
python3 scripts/c_reduce.py case.c -o small.c -- \
    badc -O0 -w -I /usr/include/csmith -o /dev/null {}
```

`scripts/c_reduce.py` deletes a brace-balanced region and keeps the deletion
while the command still fails the way it failed on the original. It repeats
until no deletion keeps the failure. `{}` stands for the candidate file.

For a wrong answer rather than a crash, make the command reject a candidate
with undefined behavior: a deleted `return` or initializer lets two compilers
disagree legitimately. Build the reference inside the command with
`-Werror=return-type -Werror=uninitialized` and treat its failure as
uninteresting. `cvise` and `creduce` reduce better where they are installed;
Homebrew packages `creduce` and `csmith` but not `cvise`.

### Assembler encodings

`.github/workflows/asm-fuzz.yml` runs daily on macOS. It compares badc's
x86-64 and AArch64 instruction encodings with the system assembler's.

## Benchmarks

`tests/perf/` holds ten benchmark programs, each of which prints its own
run time. `tests/perf/run.py` builds each with every compiler it finds, runs
each binary three times, and prints a Markdown table per program: the median
run time, the binary size and the ratio to `badc -O`.

```sh
cargo build --release --features full     # run.py takes target/release/badc, or $BADC
python3 demos/tinycc/setup.py             # sources for the tcc rows
python3 tests/perf/run.py --only fib.c,qsort.c,sieve.c,munchausen.c
```

The compilers it looks for:

| compiler | where |
|---|---|
| `badc`, `badc -O` | `target/release/badc` or `$BADC` |
| `tcc` | POSIX hosts; built from `demos/tinycc/` by `tests/perf/build_tcc.sh` on first use, or `$TCC` |
| `clang`, `gcc` at `-O0`, `-O2`, and `-O2 -march=` badc's baseline | `PATH`, except on Windows; `gcc` is skipped when it reports clang's version |
| `cl` at `/Od`, `/O2`, and `/O2 /arch:` badc's baseline | Windows, from a Visual Studio developer environment |
| `ccc -O2` | Linux, after `python3 tests/perf/build_ccc.py`, or `$CCC` |

A compiler it does not find is skipped with an `info:` line. The other six
programs need sources that the demos fetch: run `python3 demos/<name>/setup.py`
for `tweetnacl`, `miniz`, `stb`, `sqlite3` and `quickjs`. Binaries go to
`tests/perf/build/`, which git ignores. `--json PATH` also writes the run as
JSON. The script exits 1 if any build or run fails.

CI runs the benchmarks on Linux x86-64 and ARM64 and on Windows x64 and ARM64,
and publishes each run to
[badc-perf-data](https://github.com/kromych/badc-perf-data).
[badc.dev/performance](https://badc.dev/performance/) charts the latest runs
and compares any two. The CI job summary also carries the CPython and QuickJS
build comparisons from the Linux runners.

## CI

`.github/workflows/ci.yml` runs on every pull request and every push to
`master`:

| job | runners | what it runs |
|---|---|---|
| `fmt + clippy` | Linux x86-64 | rustfmt, clippy with and without `full`, the scripts' self-tests, the ASCII-only check |
| `build badc` | all five, and `ubuntu-24.04` | the release binary that later jobs use |
| `test` | all five | the test suites in a debug build, the `--no-default-features` build, and most demo smokes |
| `pressure` | Linux x86-64 and ARM64 | the library tests and twelve demos with the register allocator limited to N registers per bank, N in 2, 3, 5, 7, 8, 9 and 16 |
| `feature combos` | Linux x86-64 | builds with the default features, with `--no-default-features --lib`, and with `--all-features` |
| `snapshots clean` | Linux x86-64 | `scripts/snapshots.py --check` |
| `perf comparison` | Linux x86-64 and ARM64, Windows x64 and ARM64 | the benchmarks and the compile-throughput check |
| demo suites | per demo | Tcl, OpenSSL (C and assembly), libmill, libdill, coroutines, uemacs, picocom, GNU Screen, Vim, CPython, nasm, yasm, edk2 |
| `ovmf` | Linux x86-64 and ARM64 | OVMF and AAVMF firmware built with badc |
| `qemu` | Linux x86-64 and ARM64, at `-O0` and `-O` | QEMU built and linked by badc, booting Linux through that firmware |
| `kernel` | Linux x86-64 and ARM64 | a Linux `defconfig` kernel compiled and linked by badc and booted on the badc-built QEMU; see [the kernel page](linux-kernel.md) |

"All five" are `ubuntu-latest`, `ubuntu-24.04-arm`, `macos-latest`,
`windows-latest` and `windows-11-arm`. The runners have no display, so the
GUI demos only build their programs. [`demos/`](../demos/) says what each
demo exercises.

## Before a push

### Git hooks

`python3 scripts/install_hooks.py` links the hooks in `scripts/git-hooks/`
into `.git/hooks/`:

* `pre-push` rejects non-ASCII bytes in source files, then runs
  `cargo fmt --check`, clippy with `-D warnings` with and without
  `--features full` and for each other Rust target installed,
  `cargo build --no-default-features --lib` and
  `cargo check --all-features --lib`.
* `post-commit` regenerates `tests/snapshots/` and prints what changed, to
  be folded into the commit.

### The local gate

`scripts/validate_local_boxes.py` runs the pre-push checks on several
machines at once and fails if any of them fails. The project requires it to
pass before every push.

```sh
python3 scripts/validate_local_boxes.py \
    --box NAME=HOST:PATH:linux --box NAME=HOST:PATH:windows --box NAME=macos
```

`NAME=HOST:PATH:KIND` names a checkout reached over ssh, where `KIND` is
`linux` or `windows`. The script adds a git remote called `NAME`, pushes the
commit to it and checks it out there. `NAME=macos` runs in the host's own
working tree; macOS is the only Mach-O target. By default the script gates
the committed `HEAD` and refuses a tree with uncommitted changes;
`--allow-dirty` gates the working tree instead.

| step | Linux | Windows | macOS |
|---|---|---|---|
| `cargo clippy --all-targets --features full -- -D warnings` | yes | | |
| release build, then `scripts/cargo_test.py` in release and in debug | yes | yes | yes |
| the library tests in release with `BADC_MAX_GPR=2 BADC_MAX_FPR=2` and `--features "codegen_test full"`, as CI's `pressure` jobs | yes | | |
| the gating demos, run concurrently by `scripts/run_demos.py` | yes | yes | yes |
| `scripts/compile_throughput.py --check` | yes | | yes |
| `scripts/snapshot_drift.py`, as CI's `snapshots clean`; needs `llvm-objdump` | yes | | |
| `demos/linux/verify.py --linker badc` over the pinned `defconfig` kernel: compile, link and boot | yes | | |

The gating demos are `GATING_DEMOS` in the script, with the reason for each.
At this commit they are Tcl, edk2, QEMU at `-O0` and at `-O`, BearSSL,
SQLite, Lua, miniz, Monocypher, stb, TweetNaCl, QuickJS, raylib, curl,
libmill, libdill, coroutines, nasm, bzip2, kissfft, gui_hello, nt_loader,
the demo kernel, TinyCC, chibicc, uemacs and picocom; each runs on the
systems it supports. A machine without `qemu-system-<arch>` compiles and links
the kernel without booting it, and says so in its summary.

| option | effect |
|---|---|
| `--no-kernel` | skip the kernel step |
| `--no-snapshots` | skip the snapshot check |
| `--no-demos` | skip the demos |
| `--demo-jobs N` | run at most N demos at a time (default 4); every demo still runs |
| `--nested-kvm` | add a kernel boot under KVM in which the badc-built kernel runs a guest on the badc-built QEMU |

A push whose gate skipped a step has no coverage from that step.
