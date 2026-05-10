# kissfft demo

Build the upstream [KISS FFT](https://github.com/mborgerding/kissfft)
amalgamation through badc and run a small set of FP scenarios:
an impulse FFT (every output bin must be 1+0i), a forward +
inverse round-trip on a mixed-frequency signal, and a real-only
FFT (`kiss_fftr`) against a single-frequency sine wave. KISS FFT
is the first real FP exerciser on the bring-up path -- before
miniz / sqlite the demos were integer-heavy.

The amalgamation itself is **not committed**: ~30 KB of six
auto-generated files. `setup.py` fetches a pinned release zip
from `github.com/mborgerding/kissfft` and drops the six files
in this directory.

## Files

| File              | Tracked? | Purpose                                                              |
|-------------------|:--------:|----------------------------------------------------------------------|
| `setup.py`        | yes      | Fetch + extract the release zip. Idempotent.                         |
| `smoke.py`        | yes      | Build with badc + run impulse / round-trip / real-sine scenarios.    |
| `smoke_main.c`    | yes      | The hand-written test driver. Pulls only public KISS FFT APIs.       |
| `kiss_fft.c`      | no       | KISS FFT amalgamation. Produced by `setup.py`.                       |
| `kiss_fft.h`      | no       | Same.                                                                |
| `kiss_fftr.c`     | no       | Real-only KISS FFT add-on. Same.                                     |
| `kiss_fftr.h`     | no       | Same.                                                                |
| `_kiss_fft_guts.h`| no       | KISS FFT internal macros (C_MUL, HALF_OF, ...). Same.                |
| `kiss_fft_log.h`  | no       | Compile-time logging macros (no-ops under `-DNDEBUG`). Same.         |
| `.cache/`         | no       | Cached release zip.                                                  |

## Workflow

```sh
python demos/kissfft/setup.py    # fetches into demos/kissfft/
python demos/kissfft/smoke.py    # builds + runs impulse / roundtrip / real-sine
```

`smoke.py` returns 0 with `smoke OK [no-O]: 3 scenarios green`
/ `smoke OK [-O]: 3 scenarios green` when both -O and noO
builds pass all three scenarios within tolerance. Anything
else returns 1 with a diagnostic on stderr.

`smoke.py` honours `BADC=path/to/badc`.

## Build defines

* `NDEBUG` -- stubs the `kiss_fft_log.h` debug macros down to
  no-ops. Without it, the variadic logging spam clutters
  stderr and pulls `fprintf(stderr, ...)` into every TU.

## What this demo exercises

KISS FFT is the first FP-heavy demo. It surfaced these compiler
bugs (now fixed):

* `<math.h>` libm calls were silently dropping their FP return
  value -- the codegen routed `xmm0` / `d0` (the FP return
  register) through the integer accumulator path.
* `phase *= -1;` (FP lvalue, integer rhs) returned NaN
  because the compound-assign path didn't apply the
  usual-arithmetic-conversions int-to-FP lift.
* `.5` (a leading-dot float literal -- C99 6.4.4.2) parsed
  as a struct-field-access dot followed by digits.
* The `-O` optimizer dropped the `call_fp_arg_masks` PC
  remap, so post-opt FP args were routed through int
  registers.
* `<stdio.h>` / `<stdlib.h>` / `<string.h>` didn't expose
  `size_t` (C99 7.19/7.20/7.21).
* The JIT loader on Linux didn't `dlopen` libm.so, so `sqrt`
  / `cos` / etc. weren't reachable via `dlsym(NULL)`.

## CI

Same five runners as sqlite + miniz: `ubuntu-latest`,
`ubuntu-24.04-arm`, `macos-latest`, `windows-latest`,
`windows-11-arm`.

## Bumping kissfft

1. Update `VERSION` in `setup.py` to the new release tag.
2. Run `python setup.py -v` followed by `python smoke.py`.
