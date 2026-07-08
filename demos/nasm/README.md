# nasm demo

Builds the [NASM](https://www.nasm.us/) 2.16.03 assembler with badc and runs
NASM's own test suite against it.

NASM is a substantial, portable C program (84 translation units: the
assembler core, the x86 instruction encoder and its generated tables, the
preprocessor, and every object-format back end). It exercises badc across a
wide surface -- 64-bit bit-flag tables, variadic formatting, hash tables,
computed dispatch -- and its golden test suite makes it a precise,
self-validating correctness oracle for codegen bugs.

## Run

```sh
cargo build --release --features full          # build badc
python3 demos/nasm/setup.py                     # fetch the NASM source
python3 demos/nasm/smoke.py                      # build with badc + test
```

## How it builds (no `make`)

Like the python demo, the smoke compiles a fixed translation-unit list
directly -- there is no `make`. The NASM release tarball ships the generated
instruction tables, `version.h`, and `version.mac`; the only file a pristine
tree lacks is `config/config.h`, produced by `./configure`. Any GNU-shaped
host compiler (`cc`/`clang`/`gcc`, including clang on Windows) drives the
probes; badc accepts GNU `__attribute__`, so the config must advertise it.

The demo runs on the POSIX targets. NASM's in-tree `config/msvc.h` is
MSVC-*compiler*-specific (no `__attribute__`), so it does not match badc; a
native-Windows path needs a badc-tailored config (TODO).

## What the smoke checks

For both `-O0` and `-O`, it builds `nasm` with badc and runs NASM's own
`travis/nasm-t.py` golden suite (258 checks). Each case assembles a fixture
with the produced `nasm` and compares the emitted object bytes / listings /
diagnostics against committed golden files, so no reference build is needed:
a codegen defect shows up as a byte mismatch. `_version` is skipped (its
golden embeds the assembler's compile date, which a fresh build does not
match); every other check must pass.

## Self-hosting cross-check

```sh
python3 demos/nasm/selfhost.py            # POSIX targets
```

`selfhost.py` builds the CPython interpreter (via the python demo) *and* nasm
with badc, then runs the golden suite with the badc-built Python driving the
badc-built assembler: the interpreter runs the suite harness (`nasm-t.py`,
which spawns processes through `subprocess`) and the assembler it spawns is
also badc's. A codegen defect in either shows up as a failed golden
comparison. POSIX only -- the harness needs `subprocess`, whose process-spawn
extension the badc-built interpreter provides there (`_posixsubprocess`).

The plain `smoke.py` also accepts `$NASM_TEST_PYTHON` (and
`$NASM_TEST_PYTHONHOME` for that interpreter's stdlib) to run the suite under
a chosen interpreter directly.

## Requirements

`python3`, badc, and -- for `./configure`'s feature probes -- a POSIX shell
and a GNU-shaped host C compiler (`cc`/`clang`/`gcc`).
