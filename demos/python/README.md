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

CPython's object allocator embeds mimalloc, whose per-thread heap tables
use a thread-local pointer initialized with the address of a global -- a
relocation against the TLS template badc does not yet emit. The build is
configured `--without-mimalloc` so `Objects/obmalloc.c` uses the pymalloc
allocator.

POSIX only: the build runs `configure` and `make`. macOS is the first
supported host. This demo is not wired into CI yet.

## Running

```
python3 demos/python/setup.py        # once, to fetch the source
python3 demos/python/smoke.py -v     # build + run the test slice
python3 demos/python/smoke.py --compile-only -v   # stop after link
```

`cargo build --release --features full` must have produced
`target/release/badc` first.
