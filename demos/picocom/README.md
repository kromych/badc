# picocom demo

Build [picocom](https://github.com/npat-efault/picocom) 3.1 with badc and
drive it between two pseudo-terminals. picocom is a serial terminal
emulator: it opens a tty device, drives it through termios and the
modem-line ioctls, puts its own terminal into raw mode, and relays bytes
both ways until the escape sequence ends the session. It needs nothing
beyond libc, so this is the terminal demo with no library link at all.

The source tree is **not committed**: `setup.py` fetches the upstream
release archive from the `kromych/badc` vendor-deps release (mirrored as
`picocom-3.1-e6761ca9.tar.gz`), verifies a sha256, and extracts it under
`demos/picocom/.cache/`. The tree is built as upstream ships it, with the
Makefile's own defines; no patches. While the release lacks the asset,
`setup.py` exits with status 3 and the smoke reports a skip naming it.

## Files

| File         | Tracked? | Purpose                                                                  |
|--------------|:--------:|--------------------------------------------------------------------------|
| `setup.py`   | yes      | Fetch + extract the pinned release. Idempotent.                          |
| `smoke.py`   | yes      | Build with badc and with the host `cc`, drive both under ptys, compare.  |
| `.cache/`    | no       | Cached archive and the extracted tree.                                   |

## Workflow

```sh
python demos/picocom/setup.py     # fetches into demos/picocom/.cache/
python demos/picocom/smoke.py     # builds + runs picocom at -O0 and -O
```

`smoke.py` returns 0 with `smoke OK [badc-O0]` / `smoke OK [badc-O]` when
every step passes, and 1 with a line naming the failed step otherwise. It
honours `BADC=path/to/badc`. `--out <path>` copies the `-O` build to that
path once every run has passed.

## What the smoke does

1. Compiles the 7 units of the Makefile's `OBJS` list (`picocom.c`,
   `term.c`, `fdio.c`, `split.c`, `termios2.c`, `custbaud_bsd.c`,
   `linenoise-1.0/linenoise.c`) with `badc -c` under the Makefile's
   defines, and links with badc's linker, at -O0 and at -O.
2. Builds the same tree with the host `cc` as the reference.
3. Runs each binary with a pty pair standing in for the serial port --
   picocom opens the slave by its `/dev/` name while the harness holds
   the master -- and a second pty for picocom's own terminal
   (`TERM=vt100`, 24x80), in two scenarios:
   * **initstring**: `--exit-after 300 --initstring <text>`, so picocom
     initialises the port, writes the text to it and exits on its own
     timer with no keystrokes. The bytes the port received are checked
     against the text.
   * **interactive**: the harness writes a line to the port and waits for
     picocom to paint it on the terminal, types a line at the terminal
     and waits for it at the port (with `--omap crcrlf`, so the expected
     bytes carry the expansion), then sends `C-a C-x`. `--logfile`
     records what arrived from the port and the file is checked too.
4. Compares the badc builds' terminal output of the initstring scenario
   with the reference build's, with the port's device name normalised out
   of picocom's banner.

## Terminal ioctls

picocom is the demo that reaches the modem-control lines: `TIOCMGET`,
`TIOCMBIS` / `TIOCMBIC` to raise and lower DTR and RTS, `TCSBRK` to send
a break, and on Linux/x86 the `TCGETS2` / `TCSETS2` pair, which carries a
`c_ispeed` / `c_ospeed` word and so accepts a baud rate outside the `B*`
list. `libc/include/termios.h` and `libc/include/sys/ioctl.h` carry those
requests; `tests/fixtures/c/termios_ioctl_requests.c` locks their values
against the target's own headers.

## CI

`ubuntu-latest`, `ubuntu-24.04-arm`, and `macos-latest`, from
`.github/workflows/ci.yml`. The terminal layer is POSIX-only upstream, so
the smoke prints a skip on Windows.

## Bumping picocom

1. Update the `picocom` entry in `scripts/vendor_deps/build_bundle.py`
   (URL, version, tarball sha256), run it, and upload the new asset to
   the release as its output says.
2. Update `VERSION` and `SHA256` in `setup.py` and `VERSION` in
   `smoke.py`.
3. Run `python setup.py -v` followed by `python smoke.py`.
