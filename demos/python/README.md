# CPython demo

Builds the CPython 3.14.6 interpreter with badc and runs a slice of the
standard library test suite. The interpreter exercises the bytecode
evaluator, the object and memory model, Unicode, and the parser.

## Layout

- `setup.py` -- fetches the pinned `Python-3.14.6.tgz` and the vendored
  frozen-module headers from the badc vendor-deps mirror and extracts them
  under `.cache/Python-3.14.6`. No make.
- `build.py` -- the build command for every target (macOS, Linux x64/arm64,
  Windows x64/arm64): compiles CPython's all-builtin link set with badc and
  runs the tier-1 test slice, with no make. POSIX targets use a committed
  per-target `manifest.json` + `config.c` + `pyconfig.h`; Windows targets parse
  the link set from `PCbuild/pythoncore.vcxproj` and wire the `PC/config.c`
  inittab.
- `smoke.py` -- the reference build: `./configure --without-mimalloc` + `make`
  with the host compiler, producing a reference `python` for `bench.py`.
- `bench.py` + `benchmarks/` -- runs the dependency-free pure-Python benchmarks
  on the badc-built interpreter and the `smoke.py` reference, asserts
  per-benchmark output parity (a differential correctness check over a workload
  broader than the test slice), and reports timings relative to the reference.

CPython's object allocator embeds mimalloc, whose per-thread heap tables use a
thread-local pointer initialized with the address of a global -- a relocation
against the TLS template badc does not yet emit. The build disables mimalloc so
`Objects/obmalloc.c` uses the pymalloc allocator.

CI builds and tests every target with `build.py` -- a matrix over macOS, Linux
x64/arm64, and Windows x64/arm64; each lane builds and runs natively. `smoke.py`
and `bench.py` cover the differential benchmark, which still needs a make-built
reference.

## Running

```
python3 demos/python/setup.py                                # once, to fetch the source
python3 demos/python/build.py --target=macos-aarch64 --test  # build + run the test slice
python3 demos/python/build.py --target=windows-x64 --link    # build + link only
python3 demos/python/bench.py                                # parity + timings vs the reference
```

`cargo build --release --features full` must have produced
`target/release/badc` first. `bench.py` reuses the reference interpreter built
by `smoke.py` under `.cache/`.
