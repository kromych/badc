# uemacs demo

Build MicroEMACS ([torvalds/uemacs](https://github.com/torvalds/uemacs),
the uEmacs/PK 4.0 line) with badc and drive the editor under a
pseudo-terminal. The editor is a termios + termcap program: it puts the
terminal into raw mode itself, reads keystrokes byte by byte, paints
through termcap capabilities, and interprets its own startup-file
language, so the smoke exercises a terminal program end to end rather
than a batch one.

The source tree is **not committed**: `setup.py` fetches the pinned
commit from the `kromych/badc` vendor-deps release (the upstream GitHub
archive of commit `1c1b25e`, mirrored as `uemacs-20210330-1c1b25ef.tar.gz`),
verifies a sha256, and extracts it under `demos/uemacs/.cache/`. The
tree is built as upstream ships it, with the Makefile's own defines for
the host OS; no patches. While the release lacks the asset, `setup.py`
exits with status 3 and the smoke reports a skip naming it.

## Files

| File         | Tracked? | Purpose                                                                   |
|--------------|:--------:|---------------------------------------------------------------------------|
| `setup.py`   | yes      | Fetch + extract the pinned commit. Idempotent.                            |
| `smoke.py`   | yes      | Build with badc and with the host `cc`, drive both under a pty, compare.  |
| `.cache/`    | no       | Cached archive and the extracted tree.                                    |

The termcap declarations badc compiles `tcap.c` against are
`demos/include/term.h` and `demos/include/curses.h`; the implementation
is the system terminfo library (the SDK's `libcurses` on macOS,
`libtinfo` on Linux).

## Workflow

```sh
python demos/uemacs/setup.py     # fetches into demos/uemacs/.cache/
python demos/uemacs/smoke.py     # builds + runs the editor at -O0 and -O
```

`smoke.py` returns 0 with `smoke OK [badc-O0]` / `smoke OK [badc-O]`
when every step passes, and 1 with a line naming the failed step
otherwise. It honours `BADC=path/to/badc`. `--out <path>` copies the
`-O` build of the editor to that path once every run has passed, so
`python demos/uemacs/smoke.py --out ~/bin/em` leaves a badc-built
MicroEMACS on your `PATH`.

## What the smoke does

1. Compiles the 35 units of the Makefile's `SRC` list with `badc -c` and
   links `em` with badc's linker against the system terminfo library, at
   -O0 and at -O.
2. Builds the same tree with the host `cc` as the reference.
3. Runs each binary under a pty (`TERM=vt100`, 24x80) in two scenarios,
   each in a fresh directory holding a one-line `scratch.txt`:
   * **startup file**: `em @start.rc`, where the file is written in the
     editor's command language -- `find-file`, `end-of-file`,
     `insert-string`, `newline`, `save-file`, `exit-emacs` -- so the
     editor writes the file and exits before reaching its command loop.
   * **keystrokes**: the startup file opens the scratch file and returns
     to the command loop; the text, `C-x C-s` (save) and `C-x C-c` (exit)
     are written to the pty once the editor has produced output, which
     it does only after switching the terminal to raw mode.
4. Checks each written file byte for byte against the expected text, and
   the badc builds' terminal output of the startup-file scenario against
   the reference build's.

## CI

`ubuntu-latest`, `ubuntu-24.04-arm`, and `macos-latest`, from
`.github/workflows/ci.yml`. The terminal layer is POSIX-only upstream,
so the smoke prints a skip on Windows; the local-box roster lists the
demo for the POSIX lanes.

## Bumping uemacs

1. Update the `uemacs` entry in `scripts/vendor_deps/build_bundle.py`
   (commit, author date), run it, and upload the new asset to the
   release as its output says.
2. Update `VERSION`, `UPSTREAM_SHA`, and `SHA256` in `setup.py` (and
   `UPSTREAM_SHA` in `smoke.py`).
3. Run `python setup.py -v` followed by `python smoke.py`.
