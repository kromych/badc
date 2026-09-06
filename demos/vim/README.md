# vim demo

Build [Vim](https://www.vim.org/) 9.1.0800 with badc and drive the editor
under a pseudo-terminal. At 123 translation units and roughly half a
million lines it is the largest hosted program in the demo set, and its
terminal layer is terminfo plus termios -- no window library.

The source tree is **not committed**: `setup.py` fetches the upstream
GitHub archive of the `v9.1.0800` tag from the `kromych/badc`
vendor-deps release (mirrored as `vim-9.1.0800-3bc15301.tar.gz`),
verifies a sha256, and extracts it under `demos/vim/.cache/`. The tree is
built as upstream ships it; no patches. While the release lacks the
asset, `setup.py` exits with status 3 and the smoke reports a skip
naming it.

## Files

| File         | Tracked? | Purpose                                                                |
|--------------|:--------:|------------------------------------------------------------------------|
| `setup.py`   | yes      | Fetch + extract the pinned release. Idempotent.                        |
| `smoke.py`   | yes      | configure, build with badc and with `make`, drive both, compare.       |
| `.cache/`    | no       | Cached archive, the extracted tree, its build, and the build log.      |

## Workflow

```sh
python demos/vim/setup.py     # fetches into demos/vim/.cache/
python demos/vim/smoke.py     # builds + runs the editor at -O0 and -O
```

`smoke.py` returns 0 with `smoke OK [badc-O0]` / `smoke OK [badc-O]` when
every step passes, and 1 with a line naming the failed step otherwise. It
honours `BADC=path/to/badc`. `--out <path>` copies the `-O` build of the
editor to that path once every run has passed, so
`python demos/vim/smoke.py --out ~/bin/vim` leaves a badc-built Vim on
your `PATH`.

## What the smoke does

1. Runs `./configure` with every embedded interpreter, the GUI and the
   desktop integrations off -- each pulls a third-party development
   package and none is part of the editor's own C surface -- then
   `make`, which generates the derived sources and produces the
   host-`cc` reference binary. What `make` ran is kept in
   `.cache/build.log`, so a second run of the smoke starts at the badc
   build.
2. Reads the build log for the compile line of every object the link
   consumed and replays each through `badc -c`, keeping the Makefile's
   own `-I` and `-D` and dropping only its warning, debug and
   optimisation flags. badc's linker produces `vim` against the same
   libraries the reference link named, at -O0 and at -O.
3. Runs each binary in two scenarios, each in a fresh directory holding
   a two-line `scratch.txt`:
   * **ex mode**: `vim -es -S edit.vim scratch.txt`, which needs no
     terminal. The script appends a line, substitutes in the first one,
     writes and quits.
   * **keystrokes**: the same edit typed at a pseudo-terminal
     (`TERM=xterm`, 24x80) -- `G o ... Esc gg :1s/... :wq`.
4. Checks each written file byte for byte against the expected text, and
   both badc builds' terminal output against the reference build's.

## Headers this reaches

Vim is the demo that reaches the POSIX surface past C99: the
per-process timers (`timer_create` / `timer_settime`, `struct sigevent`)
of `<time.h>` and `<signal.h>`, `strptime`, `mblen` / `mbtowc` /
`wctomb`, `<iconv.h>`, and Linux's `<sys/sysinfo.h>`.
`tests/fixtures/c/posix_timers_and_conversion.c` calls each of them.

## Platforms

Linux only. On macOS the build reaches two SDK headers badc's own set
does not carry -- `<libc.h>`, a NeXT-era umbrella, and
`<dispatch/dispatch.h>` -- and badc's include search does not reach the
SDK there, so the build stops at the first of them. The smoke prints a
skip anywhere but Linux.

## CI

`ubuntu-latest` and `ubuntu-24.04-arm`, from `.github/workflows/ci.yml`.

## Bumping vim

1. Update the `vim` entry in `scripts/vendor_deps/build_bundle.py`
   (URL, version, tarball sha256), run it, and upload the new asset to
   the release as its output says.
2. Update `VERSION` and `SHA256` in `setup.py` and `VERSION` in
   `smoke.py`.
3. Run `python setup.py -v` followed by `python smoke.py`.
