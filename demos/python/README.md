# CPython demo

Builds the CPython 3.14.6 interpreter with badc and runs a slice of the
standard library test suite. The interpreter exercises the bytecode
evaluator, the object and memory model, Unicode, and the parser.

## Layout

- `setup.py` -- fetches the pinned `Python-3.14.6.tgz` from the badc
  vendor-deps mirror and extracts it under `.cache/Python-3.14.6`.
- `smoke.py` -- runs `./configure --without-mimalloc` and `make` with the
  host compiler to generate the derived sources (the pegen tables, the
  frozen-module headers, `Modules/config.c`) and a reference `python` used
  during the build, then recompiles each core translation unit through
  badc, links the interpreter, and runs a baselined test slice.
- `bench.py` + `benchmarks/` -- runs the dependency-free pure-Python
  benchmarks on the badc-built interpreter and a reference interpreter,
  asserts per-benchmark output parity (a differential correctness check
  over a workload broader than the test slice), and reports wall-clock
  timings relative to the reference.
- `win_build.py` -- cross-compiles a static Windows `python.exe`
  (`BADC_PY_TARGET=windows-x64` or `windows-arm64`) from any host; see the
  module docstring.

CPython's object allocator embeds mimalloc, whose per-thread heap tables
use a thread-local pointer initialized with the address of a global -- a
relocation against the TLS template badc does not yet emit. The build is
configured `--without-mimalloc` so `Objects/obmalloc.c` uses the pymalloc
allocator.

The `smoke.py` build runs `configure` and `make`, so it is POSIX-only;
it is exercised on macOS and Linux. `win_build.py` constructs the
translation-unit list directly and cross-compiles from any host. The
POSIX smoke, the benchmark parity check, and the Windows-x64 cross-compile
run in CI.

## Running

```
python3 demos/python/setup.py        # once, to fetch the source
python3 demos/python/smoke.py -v     # build + run the test slice
python3 demos/python/smoke.py --compile-only -v   # stop after link
python3 demos/python/bench.py        # parity + timings vs the reference
```

`cargo build --release --features full` must have produced
`target/release/badc` first. `bench.py` reuses the interpreters built by
`smoke.py` under `.cache/`.
