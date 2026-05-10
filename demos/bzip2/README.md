# bzip2 demo

Build the upstream [bzip2](https://sourceware.org/bzip2/)
1.0.8 library through badc and run a buffer-to-buffer
compress + decompress round-trip at blockSize 1 (smallest)
and blockSize 9 (largest). Aligns with gh #11 ("add building
some archive libraries like 7z, lzma, bzip").

bzip2 is integer + bit-twiddle heavy: Burrows-Wheeler
transform, move-to-front, run-length encoding, and Huffman
coding through a 128-bit bitstream packer. Different shape
from miniz's deflate -- no LZ77 window, so a regression here
usually pinpoints something miniz didn't notice.

The library source isn't committed: `setup.py` fetches the
1.0.8 release tarball from sourceware.org and drops the seven
.c files + two headers into this directory.

## Files

| File                | Tracked? | Purpose                                                           |
|---------------------|:--------:|-------------------------------------------------------------------|
| `setup.py`          | yes      | Fetch + extract the release tarball. Idempotent.                  |
| `smoke.py`          | yes      | Build with badc + run the buffer-to-buffer round-trip.            |
| `smoke_main.c`      | yes      | The hand-written test driver. Pulls only public bzlib APIs.       |
| `blocksort.c`       | no       | BWT + main sort. Produced by `setup.py`.                          |
| `huffman.c`         | no       | Huffman coding pass. Same.                                        |
| `crctable.c`        | no       | Static CRC32 table. Same.                                         |
| `randtable.c`       | no       | Static randomisation table. Same.                                 |
| `compress.c`        | no       | Compression driver. Same.                                         |
| `decompress.c`      | no       | Decompression driver. Same.                                       |
| `bzlib.c`           | no       | Public API surface. Same.                                         |
| `bzlib.h`           | no       | Public API header. Same.                                          |
| `bzlib_private.h`   | no       | Internal header. Same.                                            |
| `.cache/`           | no       | Cached release tarball.                                           |

## Workflow

```sh
python demos/bzip2/setup.py    # fetches into demos/bzip2/
python demos/bzip2/smoke.py    # builds + runs four scenarios at -O and noO
```

`smoke.py` returns 0 with `smoke OK [no-O]: 4 scenarios green`
/ `smoke OK [-O]: 4 scenarios green` when both -O and noO
builds pass every scenario:

* **mixed (64 KiB)**     -- text + binary sweep, modest ratio.
* **zeros (64 KiB)**     -- low entropy; cmp_len must crush to < 2%.
* **random (64 KiB)**    -- xorshift64 stream; cmp_len ~= src_len.
* **reference**          -- decompress a hand-baked bzip2 stream
                            (Python `bz2.compress` of a fixed
                            plaintext, base64 in the driver) and
                            verify byte-equality. Catches any
                            decompress-side regression independent
                            of the encoder path.

Anything else returns 1 with a diagnostic on stderr.

`smoke.py` honours `BADC=path/to/badc`.

## Build defines

* `BZ_NO_STDIO` -- drops the `FILE *`-shape API
  (`BZ2_bzReadOpen` / `BZ2_bzWriteOpen` / `bzdopen` / etc.).
  We only use the buffer-to-buffer entry points
  (`BZ2_bzBuffToBuffCompress` / `BZ2_bzBuffToBuffDecompress`),
  which don't touch stdio. Avoids a `<sys/stat.h>` clash with
  the c5 header set on Windows.

## CI

Same five runners as the other demos: `ubuntu-latest`,
`ubuntu-24.04-arm`, `macos-latest`, `windows-latest`,
`windows-11-arm`.

## Bumping bzip2

1. Update `VERSION` in `setup.py` to the new release.
2. Run `python setup.py -v` followed by `python smoke.py`.
