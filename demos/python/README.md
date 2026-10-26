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

`smoke.py` configures `--without-mimalloc --without-remote-debug`; its docstring
carries the first error each knob produces today. In short: mimalloc's
per-thread heap table is a thread-local pointer initialized with the address of
a global, which badc rejects, and the remote-debugging code needs
`process_vm_readv` on Linux and `libproc.h` on macOS. `--with-ensurepip` has no
effect on what badc compiles.

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

## Capturing the target inputs

`targets/<target>/{pyconfig.h,config.c,manifest.json}` are what `configure` and
`make` derive on a host of the target's OS and architecture, from an
all-builtin build of the release tarball that leaves out every module linking a
library beyond the C library and the OS (on macOS `_uuid` comes off the list:
libSystem provides it):

```sh
tar -xzf Python-<version>.tgz && cd Python-<version>
printf '%s\n' '*disabled*' _bz2 _lzma _zstd zlib _dbm _gdbm readline _ctypes \
    _curses _curses_panel _sqlite3 _ssl _hashlib _uuid _tkinter > Modules/Setup.local
./configure --without-mimalloc --without-remote-debug --with-ensurepip=no \
    --disable-test-modules --without-system-libmpdec --without-system-expat \
    MODULE_BUILDTYPE=static
make -j8 > ../trace.txt 2> ../make-stderr.txt
grep -E '^(gcc|cc|clang) .* -o python(\.exe)?( |$)' ../trace.txt > ../pylink.txt
python3 <repo>/demos/python/gen_manifest.py ../trace.txt ../pylink.txt ../manifest.json
```

`pyconfig.h` and `Modules/config.c` are then copied as they are. The trace takes
stdout alone: a compiler warning interleaved into a parallel compile line drops
that unit from the manifest. A bump keeps the host-dependent answers of the
previous capture, so `pyconfig.h` changes only where upstream did:
`diff3 -m <committed> <old version on this host> <new version on this host>`.
For 3.14.6 the recipe gives the committed `manifest.json` (as a set of units
with their defines and includes) and `config.c` on the Linux x86_64, Linux
aarch64 and macOS arm64 hosts, except that the macOS `config.c` lists
`binascii` last; `pyconfig.h` differs only where the hosts changed since:
`HAVE_UUID_H` and `HAVE_UUID_GENERATE_TIME_SAFE` (libuuid-devel installed) on
Linux, `HAVE_DUP3` and `HAVE_PIPE2` (the macOS 27 SDK) on macOS.

The frozen-module asset is `Python/frozen_modules/` of any such build -- the
headers `make` generates plus the tarball's `README.txt` -- packed with
`COPYFILE_DISABLE=1 tar --no-xattrs -czf python-frozen.tar.gz Python/frozen_modules`
and named `python-frozen-<version>-<sha8>.tar.gz` after its own sha256. The
headers are marshalled bytecode, the same on every host: the 3.14.6 asset's 25
files equal those of a Linux x86_64 build.
