# screen demo

Build [GNU Screen](https://www.gnu.org/software/screen/) 5.0.0 with badc
and run it as both halves of its own client/server pair. screen is the
terminal multiplexer: it allocates a pseudo-terminal per window, paints
through terminfo, and a second copy of the binary reaches the running
session over a UNIX socket to send commands into it. Both roles are the
badc-built binary here.

The source tree is **not committed**: `setup.py` fetches the upstream
`ftp.gnu.org` tarball from the `kromych/badc` vendor-deps release
(mirrored as `screen-5.0.0-f04a39d0.tar.gz`), verifies a sha256, and
extracts it under `demos/screen/.cache/`. The tree is built as upstream
ships it; no patches.  While the release lacks the asset, `setup.py`
exits with status 3 and the smoke reports a skip naming it.

## Files

| File         | Tracked? | Purpose                                                                 |
|--------------|:--------:|-------------------------------------------------------------------------|
| `setup.py`   | yes      | Fetch + extract the pinned release. Idempotent.                         |
| `smoke.py`   | yes      | configure, build with badc and with `make`, run both, compare.          |
| `.cache/`    | no       | Cached archive, the extracted tree, and its configured build.           |

## Workflow

```sh
python demos/screen/setup.py     # fetches into demos/screen/.cache/
python demos/screen/smoke.py     # builds + runs screen at -O0 and -O
```

`smoke.py` returns 0 with `smoke OK [badc-O0]` / `smoke OK [badc-O]` when
every step passes, and 1 with a line naming the failed step otherwise. It
honours `BADC=path/to/badc`. `--out <path>` copies the `-O` build to that
path once every run has passed.

## What the smoke does

1. Runs `./configure --disable-pam` and `make` in the cached tree. That
   generates `config.h`, `osdef.h` and `kmapdef.c`, and produces the
   host-`cc` reference binary. `SOURCE_DATE_EPOCH` is pinned so the
   Makefile's `-DBUILD_DATE` is the same for every build.
2. Takes the compile line for each of the 38 units out of
   `make -n -B screen` and replays it through `badc -c`, keeping the
   Makefile's `-D`s and `-iquote` and dropping only its warning, `-std`
   and optimisation flags. badc's linker produces `screen` against the
   system terminfo and crypt libraries, at -O0 and at -O.
3. Runs each binary in two scenarios, each under its own `HOME` so the
   session sockets stay separate:
   * **detached**: the binary starts a session running `cat`, then the
     same binary runs again as a client and sends `stuff`, `hardcopy`
     and `quit` over the session socket. The hardcopy -- the window's
     text -- is checked line for line, and `screen -ls` is checked
     before and after the quit.
   * **attached**: the binary runs under a pseudo-terminal
     (`TERM=xterm`, 24x80); a line typed at the terminal goes through
     screen into `cat` and comes back through the window, and EOF ends
     the window and with it screen.
4. Compares the badc builds' hardcopy and terminal output with the
   reference build's.

## Platforms

Linux only. Upstream 5.0.0's `socket.c` picks between `<shadow.h>`'s
`getspnam` and BSD's `getpwnam_shadow` on `#ifndef _PWD_H` -- glibc's
include guard -- so on macOS, whose `<pwd.h>` spells its guard `_PWD_H_`,
it reaches for a function the platform does not have. `clang` on macOS
fails on that line exactly as badc does, so this is upstream's, not
badc's. The smoke prints a skip anywhere but Linux.

## Libraries

The link needs the terminfo entry points and `crypt`. Both are located
by `demos/_syslib.py`, which finds the runtime shared library rather
than passing a bare `-l` name: that spelling needs the development
package's symlink, which a runner may not carry.

## Bumping screen

1. Update the `screen` entry in `scripts/vendor_deps/build_bundle.py`
   (URL, version, tarball sha256), run it, and upload the new asset to
   the release as its output says.
2. Update `VERSION` and `SHA256` in `setup.py` and `VERSION` in
   `smoke.py`.
3. Run `python setup.py -v` followed by `python smoke.py`.
