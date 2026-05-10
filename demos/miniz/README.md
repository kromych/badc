# miniz demo

Build the upstream [miniz](https://github.com/richgel999/miniz)
amalgamation through badc and run a deflate round-trip + a
CRC32 / Adler32 checksum probe. Smaller and integer-heavier
than sqlite; the second non-trivial demo on the bring-up path.

The amalgamation itself is **not committed**: ~430 KB of two
auto-generated files. `setup.py` fetches a pinned release zip
from `github.com/richgel999/miniz/releases` and drops `miniz.c`
+ `miniz.h` in this directory.

## Files

| File             | Tracked? | Purpose                                                                 |
|------------------|:--------:|-------------------------------------------------------------------------|
| `setup.py`       | yes      | Fetch + extract the release zip. Idempotent.                            |
| `smoke.py`       | yes      | Build with badc + run the round-trip + checksum scenarios.              |
| `smoke_main.c`   | yes      | The hand-written test driver. Pulls only public miniz APIs.             |
| `miniz.c`        | no       | Amalgamation. Produced by `setup.py`.                                   |
| `miniz.h`        | no       | Same.                                                                   |
| `.cache/`        | no       | Cached release zip.                                                     |

## Workflow

```sh
python demos/miniz/setup.py    # fetches into demos/miniz/
python demos/miniz/smoke.py    # builds + runs deflate round-trip + checksums
```

`smoke.py` returns 0 with `smoke OK [no-O]: ...` / `smoke OK
[-O]: ...` when both -O and noO builds round-trip the input
buffer and the CRC32 / Adler32 of `"123456789"` match RFC 1950 /
3309 reference values. Anything else returns 1 with a diagnostic
on stderr.

`smoke.py` honours `BADC=path/to/badc`.

## Build defines

The smoke script disables three pieces of miniz that the c5
header set doesn't cover:

* `MINIZ_NO_ARCHIVE_APIS` -- the zip surface (needs
  `<sys/stat.h>` / `<utime.h>` / `<windows.h>` for file
  metadata).
* `MINIZ_NO_TIME` -- the zip code's `<time.h>` use.
* `MINIZ_NO_STDIO` -- `fopen`/`fread`/`fwrite` wrappers; the
  smoke driver runs entirely in-memory.

The remaining surface (`compress`, `uncompress`, `compressBound`,
`mz_crc32`, `mz_adler32`, the underlying `tdefl_*` / `tinfl_*`
state machines) is the deflate / inflate / checksum core that
the smoke exercises.

## CI

Same five runners as sqlite: `ubuntu-latest`, `ubuntu-24.04-arm`,
`macos-latest`, `windows-latest`, `windows-11-arm`. The
workflow's `actions/setup-python@v5` step gives `python` the
same 3.x interpreter on every lane.

## Bumping miniz

1. Update `VERSION` in `setup.py` to the new release.
2. Run `python setup.py -v` followed by `python smoke.py`.
