# CPython demo

Builds the CPython 3.15.1 interpreter with badc and runs a slice of the
standard library test suite. The interpreter exercises the bytecode
evaluator, the object and memory model, Unicode, and the parser.

## Layout

- `setup.py` -- fetches the pinned `Python-3.15.1.tgz` and the vendored
  frozen-module headers from the badc vendor-deps mirror and extracts them
  under `.cache/Python-3.15.1`. No make.
- `build.py` -- the build command for every target (macOS, Linux x64/arm64,
  Windows x64/arm64): compiles CPython's all-builtin link set with badc and
  runs the tier-1 test slice, with no make. POSIX targets use a committed
  per-target `manifest.json` + `config.c` + `pyconfig.h`; Windows targets parse
  the link set from `PCbuild/pythoncore.vcxproj` and wire the `PC/config.c`
  inittab.
- `build_sdk.py` -- the Windows distribution as PCbuild builds it: evaluates
  `pcbuild.proj` and each `.vcxproj` for the Release configuration and runs
  badc with `--msvc` where MSBuild runs cl, link and lib, against the MSVC
  headers and the Windows SDK (not badc's bundled C library), linking the SDK
  and UCRT import libraries. It builds `python315.dll`, `python3.dll`,
  `python.exe`, `pythonw.exe`, the launchers and the C extension modules,
  with the external libraries from source; OpenSSL and Tcl/Tk are not built
  yet, so `_ssl`, `_hashlib` and `_tkinter` are left out, as are the C++
  `_wmi` and `pyshellext`. `--test` runs the whole regrtest suite: on
  Windows x64 and arm64 every test module passes or is skipped except
  `test_wmi`, which requires `_wmi` on Windows and fails at its import.
  `BADC_WINDOWS_KITS` / `BADC_MSVC_TOOLS` point it at a copied kit for a
  cross build from macOS or Linux.
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
python3 demos/python/build_sdk.py --target=windows-x64 --test # PCbuild's distribution + regrtest
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
The 3.15.1 inputs were taken that way on the Linux x86_64 and Linux aarch64
hosts (gcc 16.2.1, glibc 2.43) and the macOS arm64 host (Apple clang 21, SDK
27.0): `manifest.json` and `config.c` are the 3.15.1 output (290 units on macOS
and Linux x86_64, 288 on Linux aarch64), and `pyconfig.h` the 3.14.6 capture
plus each host's 3.14.6 to 3.15.1 difference. On the same hosts the recipe for
3.14.6 gave the committed 3.14.6 `manifest.json` (as a set of units with their
defines and includes) and `config.c`, except that the macOS `config.c` listed
`binascii` last, and a `pyconfig.h` that differed only where the hosts had
changed: `HAVE_UUID_H` and `HAVE_UUID_GENERATE_TIME_SAFE` (libuuid-devel
installed) on Linux, `HAVE_DUP3` and `HAVE_PIPE2` (the macOS 27 SDK) on macOS.

The frozen-module asset is `Python/frozen_modules/` of any such build -- the
headers `make` generates plus the tarball's `README.txt` -- packed with
`COPYFILE_DISABLE=1 tar --no-xattrs -czf python-frozen.tar.gz Python/frozen_modules`
and named `python-frozen-<version>-<sha8>.tar.gz` after its own sha256. The
headers are marshalled bytecode, the same on every host: the 3.15.1 asset's 26
files, from the macOS build, equal those of the Linux x86_64 build.
