# Tcl demo

Builds the Tcl 8.6.14 interpreter (`tclsh`) with badc and runs the
upstream Tcl test suite. The suite exercises the bytecode engine,
the expression compiler, string and binary scanning, and the
clock/timezone code.

## Layout

- `setup.py` -- fetches the pinned `tcl8.6.14-src.tar.gz` from the badc
  vendor-deps mirror and extracts it under `.cache/tcl8.6.14`.
- `smoke.py` -- runs `unix/configure`, replays the Makefile's
  per-translation-unit compile commands through badc (plus the bundled
  zlib units the system-libz build omits), links `tclsh`, and runs
  `tests/all.tcl`, failing if the total failure count exceeds the pinned
  baseline.

POSIX only: the build runs `configure` and `make`. Linux is the
supported host.

## Running

```
python3 demos/tcl/setup.py     # once, to fetch the source
python3 demos/tcl/smoke.py -v  # build + run the suite
```

`cargo build --release --features full` must have produced
`target/release/badc` first.
