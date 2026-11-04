# OpenSSL demo

Builds [OpenSSL](https://openssl-library.org/) 4.1.0 -- libcrypto, libssl,
the `openssl` application and the test programs -- with badc, and runs
OpenSSL's own test suite (`make test`, every recipe) against the badc build
at -O0 and at -O.

The source tree is **not committed**: `setup.py` fetches the release
tarball from the `kromych/badc` vendor-deps release (mirrored as
`openssl-4.1.0-50c17baf.tar.gz`; the digest is the one the release
publishes), verifies its sha256, and extracts it under
`demos/openssl/.cache/`.

## Files

| File        | Tracked? | Purpose                                                            |
|-------------|:--------:|--------------------------------------------------------------------|
| `setup.py`  | yes      | Fetch + extract the pinned release, apply the one patch. Idempotent. |
| `smoke.py`  | yes      | Configure, build and run the suite at each level.                  |
| `badc.conf` | yes      | The Configure targets that name badc as the compiler.              |
| `.cache/`   | no       | Cached archive, the extracted tree, and a build directory (about 2 GB) per level and configuration until its suite passes. |

## Workflow

```sh
python demos/openssl/setup.py              # fetches into demos/openssl/.cache/
python demos/openssl/smoke.py              # -O0 then -O, every recipe
python demos/openssl/smoke.py --level O --tests 'test_evp test_ssl_new'
python demos/openssl/smoke.py --asm        # with the assembler modules
```

`smoke.py` prints one line per build and per suite pass and returns 0 when
every recipe passes, 1 with the failing recipes and subtests otherwise. It
honours `BADC=path/to/badc`; `--jobs N` sets both `make -j` and
`HARNESS_JOBS` (default: the CPU count); `--keep-going` passes `-k` to
`make` so every unit that fails is listed. `BADC_OPENSSL_TESTS=untimed`
builds and runs every recipe but the timer-bound ones (step 3), and
`=timed` runs only those over the builds an untimed run left from the same
badc binary; the local gate runs the untimed set in its demo pool and the
timed set after it, with the host to itself (`scripts/run_demos.py`).

## What the smoke does

1. `Configure --config=badc.conf badc-<os>-<arch> CC=badc CFLAGS=-O0|-O
   no-asm no-shared no-module`, out of tree in `.cache/build-<level>`, which
   is removed first: make does not track the compiler binary.
   * `no-asm`: the perlasm modules are assembler sources; the C
     implementations they replace are what this compiles. `--asm` drops
     it: Configure generates the modules for the host (the `elf` scheme
     on Linux, `ios64` on macOS) and badc assembles them, in
     `.cache/build-<level>-asm`, and the CPU-feature dispatch selects them
     at run time.
   * `no-shared`: libcrypto and libssl are static archives and every
     program links them statically.
   * `no-module`: the legacy provider is linked into libcrypto rather than
     loaded as a module.
2. `make build_sw`: every object compiled by badc, every program linked by
   badc's linker. The host's `ar` makes the archives: `badc --ar` writes a
   new archive per call, and the Makefile archives libcrypto in three
   calls.
3. `make test` over every recipe but `test_quicapi` and
   `test_quic_multistream`, `HARNESS_JOBS` at a time, then those two alone.
   `test_quicapi`'s blocking-mode cases run the server
   in a thread that advances the test's clock 1 ms per pass while the
   client handshakes in real time, so a loaded machine can let the
   server's idle timeout end the connection: with 12 recipes at a time on
   the x86-64 box the gcc -O0 build of this configuration failed
   `test_quic_write_read` exactly as the badc builds did, and alone every
   run of either passed. Standard input is `/dev/null`: the applications
   ask the console for a passphrase, and `tcgetattr` on an inherited
   socket fails with `EOPNOTSUPP` on macOS, which they report as an error.

`badc.conf` inherits each stock target and replaces a few fields: on Linux
it spells gcc's `-pthread` as `-D_REENTRANT` and `-lpthread` and names the
host as `--sysroot`; on macOS it drops the stock `-arch arm64` and
`-Wl,-search_paths_first`. On macOS `smoke.py` also passes badc's own
archiver (`AR="badc --ar"`, `RANLIB="badc --ar s"`): the host's `ranlib`
rewrites an archive of badc's ELF objects with an index and no members. `setup.py` guards
`test/rsa_complex.c`'s `#include <complex.h>` with `__STDC_NO_COMPLEX__`,
which badc defines: C11 6.10.8.3 does not require the header then, and
badc has no complex types.

## Status

The smoke passes end to end on the three POSIX lanes, and CI's `openssl`
job runs it on the Linux runners (x86-64 and aarch64). Measured at the
commit that enabled the job; the suite columns are the parallel pass plus
the serial one (`test_quicapi` and `test_quic_multistream`, whose
wall-clock timeouts a loaded host decides).

| Lane (jobs)         | -O0 build | -O0 suite  | -O build | -O suite   | total |
|---------------------|----------:|-----------:|---------:|-----------:|------:|
| Linux x86_64 (12)   | 22 s      | 276 + 38 s | 24 s     | 118 + 21 s | 517 s |
| Linux aarch64 (8)   | 18 s      | 247 + 41 s | 19 s     | 88 + 19 s  | 442 s |
| macOS arm64 (12)    | 10 s      | 192 + 38 s | 10 s     | 62 + 19 s  | 346 s |

402 recipe files, 3294 tests on Linux and 3260 on macOS (the suite skips
some per platform).

With `--asm`, measured at 7ef8d1da94 (the same columns; the x86-64 box
has AVX2 and no AVX-512, so the dispatch runs the AVX2 paths there):

| Lane (jobs)         | -O0 build | -O0 suite  | -O build | -O suite   | total |
|---------------------|----------:|-----------:|---------:|-----------:|------:|
| Linux x86_64 (12)   | 23 s      | 76 + 18 s  | 27 s     | 65 + 15 s  | 243 s |
| Linux aarch64 (8)   | 18 s      | 67 + 20 s  | 20 s     | 52 + 15 s  | 204 s |
| macOS arm64 (12)    | 21 s      | 66 + 19 s  | 15 s     | 46 + 16 s  | 206 s |

The same 402 recipe files and test counts. CI's `openssl`
job runs both configurations on both Linux runners. The host compilers' builds of the same configuration
take 22 s (clang -O0, macOS), 32 s (gcc -O0, x86_64) and their suites
264 s (clang -O0) and 300 s (gcc -O0); gcc -O3's suite takes 79 s.

Windows is out of reach for now: OpenSSL's Windows targets are the `VC-*`
ones (cl's command line, nmake, a native perl) and the `mingw*` ones (GNU
make and an MSYS shell). badc does not take cl's options, and the Windows
x64 validation box has neither nmake nor GNU make on PATH, and perl only
as the MSYS perl Git for Windows carries, off PATH.
