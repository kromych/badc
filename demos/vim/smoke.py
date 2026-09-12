#!/usr/bin/env python3
"""Build Vim with badc and drive the editor under a pty.

Pipeline:
  - ``setup.py`` fetches the pinned upstream tree under ``.cache/``.
  - ``./configure`` with every optional interpreter and GUI off, then
    ``make``, produce the generated sources and the host-cc reference
    binary. The commands ``make`` ran are kept, and the compile line of
    every object the link consumed is replayed through ``badc -c``;
    badc's linker produces ``vim`` against the same libraries, at both
    -O0 and -O.
  - Each binary runs in two scenarios:
      * ex mode (``-es``), which needs no terminal: a script opens a
        file, edits it, writes it and quits.
      * a pseudo-terminal, where the same edit arrives as keystrokes and
        the terminal output is read back.
    The file each scenario writes is checked byte for byte, and the
    badc builds' files and terminal output are compared with the
    reference build's.

Linux only. The macOS build reaches SDK headers badc's own set does not
carry -- ``<libc.h>`` and ``<dispatch/dispatch.h>`` -- and badc's macOS
include search does not reach the SDK, so the build stops at the first
of them. Override the badc binary via the ``BADC`` env var (default:
``target/release/badc``).
"""

from __future__ import annotations

import argparse
import fcntl
import importlib.util
import os
import pty
import re
import select
import shlex
import shutil
import struct
import subprocess
import sys
import tempfile
import termios
import time
from pathlib import Path

VIM_DIR = Path(__file__).resolve().parent
REPO_ROOT = VIM_DIR.parent.parent
VERSION = "9.1.0800"
CACHE = VIM_DIR / ".cache"
SRC = CACHE / f"vim-{VERSION}" / "src"
BUILD_LOG = CACHE / "build.log"

_tu_spec = importlib.util.spec_from_file_location(
    "_tu_build", VIM_DIR.parent / "_tu_build.py"
)
_tu_build = importlib.util.module_from_spec(_tu_spec)
_tu_spec.loader.exec_module(_tu_build)
_setup_spec = importlib.util.spec_from_file_location("vim_setup", VIM_DIR / "setup.py")
_setup = importlib.util.module_from_spec(_setup_spec)
_setup_spec.loader.exec_module(_setup)
_syslib_spec = importlib.util.spec_from_file_location(
    "_syslib", VIM_DIR.parent / "_syslib.py"
)
_syslib = importlib.util.module_from_spec(_syslib_spec)
_syslib_spec.loader.exec_module(_syslib)

# The embedded interpreters, the GUI and the desktop integrations are
# all off: each pulls a third-party development package, and none is
# part of the editor's own C surface. What is left is the terminfo
# terminal layer and the editor itself.
CONFIGURE_ARGS = (
    "--with-features=normal",
    "--disable-gui",
    "--without-x",
    "--disable-luainterp",
    "--disable-perlinterp",
    "--disable-pythoninterp",
    "--disable-python3interp",
    "--disable-rubyinterp",
    "--disable-tclinterp",
    "--disable-mzschemeinterp",
    "--disable-netbeans",
    "--disable-channel",
    "--disable-terminal",
    "--disable-canberra",
    "--disable-libsodium",
    "--disable-selinux",
    "--disable-smack",
    "--disable-acl",
    "--disable-gpm",
    "--disable-sysmouse",
    "--disable-nls",
)

# Warning, language-level and debug flags of the Makefile's CFLAGS. The
# hardening pair is dropped as a pair: -U_FORTIFY_SOURCE undoes the
# distribution's default and -D_FORTIFY_SOURCE=1 sets vim's own, neither
# of which badc reads.
DROPPED_FLAGS = (
    "-g", "-O2", "-Wall", "-Wextra",
    "-U_FORTIFY_SOURCE", "-D_FORTIFY_SOURCE=1",
)

ROWS, COLS = 24, 80
RUN_TIMEOUT = 60.0

SEED = b"first line\nsecond line\n"

# Ex mode: no terminal, no keystrokes. The script appends a line, edits
# the first one, writes and quits.
EX_SCRIPT = """\
$
put ='appended in ex mode'
1s/first/FIRST/
wq
"""
EX_EXPECTED = b"FIRST line\nsecond line\nappended in ex mode\n"

# The same edit as keystrokes: open the last line, append, go to the
# first, substitute, write and quit.
KEYS = b"Go" + b"appended through the pty" + b"\x1b" + b"gg" + b":1s/first/FIRST/\r" + b":wq\r"
KEYS_EXPECTED = b"FIRST line\nsecond line\nappended through the pty\n"

# The last thing the initial paint writes: the status line naming the
# file the editor opened.
PAINTED = b"scratch.txt"


def resolve_badc() -> Path:
    env = os.environ.get("BADC")
    if env:
        return Path(env)
    p = REPO_ROOT / "target" / "release" / "badc"
    if not p.is_file():
        sys.exit(
            f"smoke: badc not built at {p} -- run `cargo build --release --features full`"
        )
    return p


def fail(step: str, detail: str = "") -> None:
    tail = f"\n{detail[-1500:]}" if detail else ""
    print(f"smoke FAIL: {step}{tail}", file=sys.stderr)
    sys.exit(1)


def make_parallel_args() -> list[str]:
    """The build is read back out of what `make` echoed, so a recipe
    line must not interleave with another's. GNU Make 4.0's
    --output-sync guarantees that; where make is older -- macOS ships
    3.81 -- the build runs serially instead."""
    version = subprocess.run(["make", "--version"], capture_output=True,
                             text=True).stdout.split("\n", 1)[0]
    m = re.search(r"(\d+)\.(\d+)", version)
    if m and (int(m.group(1)), int(m.group(2))) >= (4, 0):
        return ["--output-sync=line", f"-j{os.cpu_count() or 1}"]
    return ["-j1"]


def configure_and_make() -> str:
    """Configure and build the reference binary, returning what `make`
    ran. The log is kept beside the tree, so a second run of the smoke
    reuses the build rather than repeating it."""
    if BUILD_LOG.is_file() and (SRC / "vim").is_file():
        return BUILD_LOG.read_text()
    if not (SRC / "auto" / "config.mk").is_file():
        r = subprocess.run(["./configure", *CONFIGURE_ARGS], cwd=SRC,
                           capture_output=True, text=True)
        if r.returncode != 0:
            fail("configure", r.stdout + r.stderr)
    # The build plan is what `make` echoes, so every object has to be
    # out of date when it runs.
    (SRC / "vim").unlink(missing_ok=True)
    for obj in (SRC / "objects").glob("*.o"):
        obj.unlink()
    r = subprocess.run(["make", *make_parallel_args()], cwd=SRC,
                       capture_output=True, text=True)
    if r.returncode != 0:
        fail("reference build (make)", r.stdout + r.stderr)
    if not re.search(r"-o\s+vim\s", r.stdout):
        fail("reference build (make) linked nothing", r.stdout + r.stderr)
    BUILD_LOG.write_text(r.stdout)
    return r.stdout


def build_plan(log: str) -> tuple[list[Path], dict[Path, list[str]], list[str]]:
    """The units the link consumed, each unit's compile flags, and the
    libraries, all taken from the commands `make` ran."""
    by_object: dict[str, tuple[Path, list[str]]] = {}
    link: list[str] | None = None
    for line in log.splitlines():
        try:
            words = shlex.split(line.strip())
        except ValueError:
            continue
        if not words:
            continue
        objects = [w for w in words if w.endswith(".o")]
        sources = [w for w in words if w.endswith(".c")]
        if "-c" in words and len(sources) == 1 and len(objects) == 1:
            keep, skip = [], False
            for w in words[1:]:
                if skip:
                    skip = False
                elif w == "-o":
                    skip = True
                elif w not in ("-c", sources[0]) and w not in DROPPED_FLAGS:
                    keep.append(_tu_build.absolute_include_flag(w, SRC))
            by_object[objects[0]] = (SRC / sources[0], keep)
        elif "-o" in words and words[words.index("-o") + 1] == "vim" and objects:
            link = words
    if link is None:
        fail("the build log carries no link line")
    units, flags = [], {}
    for obj in (w for w in link if w.endswith(".o")):
        if obj not in by_object:
            fail(f"the link consumes {obj}, which no compile line produced")
        src, keep = by_object[obj]
        units.append(src)
        flags[src] = keep
    libs = [w for w in link if w.startswith("-l")]
    return units, flags, libs


def build_badc(badc: Path, out_bin: Path, work: Path, optimize: bool,
               units: list[Path], flags: dict[Path, list[str]],
               libs: list[str]) -> None:
    work.mkdir(parents=True, exist_ok=True)
    # The host is the sysroot: badc reads no system directory the
    # command line does not declare.
    sysroot = _syslib.sysroot_args()
    _tu_build.build_tu_separate(
        badc, units, out_bin, optimize=optimize,
        compile_args={u: [*sysroot, *f] for u, f in flags.items()},
        link_args=[*sysroot, *libs], work_dir=work,
    )


def run_vim(exe: Path, cwd: Path, args: list[str], keys: bytes) -> tuple[int, bytes]:
    """Run the editor under a fresh pty and return (exit code, output).
    `keys` are written once the editor has named the file on its status
    line, which ends the initial paint: typing before the editor has put
    the terminal into raw mode would have the line discipline echo it as
    well. HOME and the vim variables point nowhere so no user
    configuration is read."""
    env = {
        "TERM": "xterm", "HOME": "/nonexistent", "PATH": "/usr/bin:/bin",
        "VIMINIT": "", "VIMRUNTIME": str(SRC.parent / "runtime"), "LC_ALL": "C",
    }
    pid, master = pty.fork()
    if pid == 0:
        try:
            fcntl.ioctl(0, termios.TIOCSWINSZ, struct.pack("HHHH", ROWS, COLS, 0, 0))
            os.chdir(cwd)
            os.execve(str(exe), [str(exe), *args], env)
        finally:
            os._exit(127)
    output = bytearray()
    pending = keys
    status: int | None = None
    deadline = time.monotonic() + RUN_TIMEOUT
    try:
        while True:
            if status is None:
                wpid, st = os.waitpid(pid, os.WNOHANG)
                if wpid == pid:
                    status = st
            ready, _, _ = select.select([master], [], [], 0.05)
            hangup = False
            if ready:
                try:
                    chunk = os.read(master, 65536)
                except OSError:
                    chunk = b""  # EIO: the slave side is gone
                if not chunk:
                    hangup = True
                output += chunk
                if pending and PAINTED in output:
                    os.write(master, pending)
                    pending = b""
            if hangup or (status is not None and not ready):
                break
            if time.monotonic() > deadline:
                os.kill(pid, 9)
                os.waitpid(pid, 0)
                raise TimeoutError(f"{exe.name} {' '.join(args)} did not exit")
    finally:
        os.close(master)
    if status is None:
        _, status = os.waitpid(pid, 0)
    return os.waitstatus_to_exitcode(status), bytes(output)


def run_scenario(label: str, exe: Path, work: Path, kind: str) -> bytes:
    """One editor run in its own directory; returns the terminal
    output. Exits the smoke on a failure."""
    run_dir = work / f"{label}-{kind}"
    run_dir.mkdir()
    (run_dir / "scratch.txt").write_bytes(SEED)
    step = f"[{label}] {kind} run"
    base = ["-u", "NONE", "-i", "NONE", "-n"]
    if kind == "ex":
        (run_dir / "edit.vim").write_text(EX_SCRIPT)
        args = [*base, "-es", "-S", "edit.vim", "scratch.txt"]
        keys, expected = b"", EX_EXPECTED
    else:
        args = [*base, "scratch.txt"]
        keys, expected = KEYS, KEYS_EXPECTED
    try:
        code, out = run_vim(exe, run_dir, args, keys)
    except TimeoutError as e:
        fail(f"{step}: {e}")
    if code != 0:
        fail(f"{step}: exit {code}", out.decode("latin-1"))
    got = (run_dir / "scratch.txt").read_bytes()
    if got != expected:
        fail(f"{step}: scratch.txt is {got!r}, expected {expected!r}",
             out.decode("latin-1"))
    return out


def parse_args() -> argparse.Namespace:
    ap = argparse.ArgumentParser(
        description="Build Vim with badc and drive the editor under a pty."
    )
    ap.add_argument(
        "--out",
        type=Path,
        help="after the smoke passes, copy the -O build of the editor to this path",
    )
    return ap.parse_args()


def main() -> int:
    args = parse_args()
    if not sys.platform.startswith("linux"):
        print(f"vim smoke skipped ({sys.platform}: the build reaches SDK headers)")
        return 0
    start = time.monotonic()
    badc = resolve_badc()
    if shutil.which("cc") is None:
        fail("reference build: no host C compiler (cc) on PATH")

    r = subprocess.run([sys.executable, str(VIM_DIR / "setup.py")])
    if r.returncode == _setup.MISSING_ASSET:
        print(
            f"vim smoke skipped: {_setup.ASSET} is not on release "
            f"{_setup.RELEASE_TAG} yet"
        )
        return 0
    if r.returncode != 0:
        fail("setup.py")

    units, flags, libs = build_plan(configure_and_make())

    with tempfile.TemporaryDirectory(prefix="vim-smoke-") as work_str:
        work = Path(work_str)
        builds: list[tuple[str, Path]] = []
        for label, optimize in (("badc-O0", False), ("badc-O", True)):
            exe = work / f"vim.{label}"
            try:
                build_badc(badc, exe, work / f"obj-{label}", optimize,
                           units, flags, libs)
            except subprocess.CalledProcessError as e:
                fail(f"[{label}] build: {e.cmd[0]} exited {e.returncode}")
            builds.append((label, exe))

        ref = SRC / "vim"
        ref_ex = run_scenario("reference", ref, work, "ex")
        ref_keys = run_scenario("reference", ref, work, "keys")
        for label, exe in builds:
            for kind, ref_out in (("ex", ref_ex), ("keys", ref_keys)):
                out = run_scenario(label, exe, work, kind)
                if out != ref_out:
                    fail(f"[{label}] {kind} run: terminal output differs from the "
                         f"reference build's",
                         f"badc: {out!r}\nreference: {ref_out!r}")
            print(f"smoke OK [{label}]: {len(units)} units, "
                  f"2 editor runs match the reference")
        if args.out is not None:
            # The -O build is the last one in `builds`; it goes where asked
            # only once every run above has passed.
            args.out.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(builds[-1][1], args.out)
            args.out.chmod(0o755)
            print(f"wrote {args.out}")
    print(f"vim smoke OK ({time.monotonic() - start:.1f}s)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
