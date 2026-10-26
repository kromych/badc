# Tcl demo

Builds the Tcl 8.6.18 interpreter (`tclsh`) with badc and runs the
upstream Tcl test suite. The suite exercises the bytecode engine,
the expression compiler, string and binary scanning, and the
clock/timezone code.

## Layout

- `setup.py` -- fetches the pinned `tcl8.6.18-src.tar.gz` from the badc
  vendor-deps mirror and extracts it under `.cache/tcl8.6.18`.
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

## Version

The pin is the newest 8.6 release. TODO: Tcl 9.1.0 does not build with
badc. `generic/tclBasic.c` calls `logb`, `lgamma` and `remquo`, which the
bundled `<math.h>` does not declare. On Linux `unix/tclEpollNotfy.c`
includes `<sys/queue.h>`, which is not bundled, and calls `timersub`,
which the bundled `<sys/time.h>` lacks. On macOS `unix/tclUnixFCmd.c`
reads a file's on-disk name through `attrreference_t`, `ATTR_CMN_NAME` and
`FSOPT_NOFOLLOW`, which the bundled `<sys/attr.h>` lacks, and
`socket -reuseport` needs `SO_REUSEPORT`, which the bundled
`<sys/socket.h>` defines for Linux only. With those supplied by a header
included ahead of every unit, the Linux suite passes. Moving to 9.x also
needs `make tclUuid.h` before the compile lines are replayed (`tclEvent.c`
includes it), and its `fileSystem-11` to `-13` tests expect a
case-insensitive volume on macOS: on a case-sensitive one the host-cc
build fails them as well.
