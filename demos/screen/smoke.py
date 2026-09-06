#!/usr/bin/env python3
"""Build GNU Screen with badc and run it as both server and client.

Pipeline:
  - ``setup.py`` fetches the pinned upstream tree under ``.cache/``.
  - ``./configure --disable-pam`` and ``make`` produce the generated
    sources (``kmapdef.c``, ``osdef.h``, ``config.h``) and the host-cc
    reference binary.
  - ``make -n -B screen`` yields the compile line for every unit; each
    is replayed through ``badc -c`` with the Makefile's own ``-D`` and
    ``-iquote``, and badc's linker produces ``screen`` against the
    system terminfo and crypt libraries, at both -O0 and -O.
  - Each binary runs in two scenarios, each with its own HOME so the
    session socket directory is private to it:
      * detached: the binary starts a session running ``cat``, then the
        same binary is run again as a client and sends ``stuff``,
        ``hardcopy`` and ``quit`` over the session socket. The hardcopy
        is the window's text, checked line for line; ``-ls`` is checked
        before and after the quit.
      * attached: the binary runs under a pseudo-terminal, a line is
        typed into the window and read back off the terminal, and EOF
        ends the window and with it screen.
    The badc builds' hardcopy and terminal output are compared with the
    reference build's.

Linux only. Upstream 5.0.0's ``socket.c`` selects between
``getspnam`` and BSD's ``getpwnam_shadow`` on ``#ifndef _PWD_H``, the
glibc include guard, so on macOS it reaches for a function the platform
does not have; the host compiler fails there the same way badc does.
Override the badc binary via the ``BADC`` env var (default:
``target/release/badc``).
"""

from __future__ import annotations

import argparse
import fcntl
import importlib.util
import os
import pty
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

SCREEN_DIR = Path(__file__).resolve().parent
REPO_ROOT = SCREEN_DIR.parent.parent
VERSION = "5.0.0"
SRC = SCREEN_DIR / ".cache" / f"screen-{VERSION}"

_tu_spec = importlib.util.spec_from_file_location(
    "_tu_build", SCREEN_DIR.parent / "_tu_build.py"
)
_tu_build = importlib.util.module_from_spec(_tu_spec)
_tu_spec.loader.exec_module(_tu_build)
_setup_spec = importlib.util.spec_from_file_location(
    "screen_setup", SCREEN_DIR / "setup.py"
)
_setup = importlib.util.module_from_spec(_setup_spec)
_setup_spec.loader.exec_module(_setup)
_syslib_spec = importlib.util.spec_from_file_location(
    "_syslib", SCREEN_DIR.parent / "_syslib.py"
)
_syslib = importlib.util.module_from_spec(_syslib_spec)
_syslib_spec.loader.exec_module(_syslib)

# PAM would put the session under the host's authentication stack and
# needs its development headers, neither of which this demo is about.
CONFIGURE_ARGS = ("--disable-pam",)

# Warning, language-level and debug flags of the Makefile's CFLAGS.
# Everything else on the compile line -- the two -D's and -iquote -- is
# what the units need, and is taken from `make -n` rather than repeated
# here.
DROPPED_FLAGS = ("-g", "-O2", "-Wall", "-Wextra", "-std=c17")

# The Makefile stamps -DBUILD_DATE from `date` unless SOURCE_DATE_EPOCH
# is set, which would leave the reference build and the badc builds with
# different defines.
SOURCE_DATE_EPOCH = "1700000000"

ROWS, COLS = 24, 80
RUN_TIMEOUT = 40.0
SESSION = "badc-smoke"

STUFFED = b"line-from-stuff"
TYPED = b"marker-through-screen"
# The window runs `cat` behind a banner. Typing before screen has put
# the terminal into raw mode would have the outer line discipline echo
# it as well, so the banner is what the harness waits for: screen only
# paints it once the display is up.
READY = b"screen-window-ready"
WINDOW_CMD = ["/bin/sh", "-c", f"echo {READY.decode()}; exec cat"]


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


def run(cmd: list[str], **kw) -> subprocess.CompletedProcess:
    return subprocess.run(cmd, capture_output=True, text=True, **kw)


def make_env() -> dict[str, str]:
    return {**os.environ, "SOURCE_DATE_EPOCH": SOURCE_DATE_EPOCH}


def configure_and_make() -> None:
    """Generate the sources and build the reference binary. Both steps
    are skipped when their output is already there, so a second run of
    the smoke starts at the badc build."""
    if not (SRC / "Makefile").is_file():
        r = run(["./configure", *CONFIGURE_ARGS], cwd=SRC)
        if r.returncode != 0:
            fail("configure", r.stdout + r.stderr)
    if not (SRC / "screen").is_file():
        r = run(["make", f"-j{os.cpu_count() or 1}"], cwd=SRC, env=make_env())
        if r.returncode != 0:
            fail("reference build (make)", r.stdout + r.stderr)


def compile_lines() -> tuple[list[str], list[Path]]:
    """The compile flags badc needs and the unit list, taken from the
    Makefile's own commands. Every unit is compiled the same way, so
    the flags come from the first line and the rest must agree."""
    r = run(["make", "-n", "-B", "screen"], cwd=SRC, env=make_env())
    if r.returncode != 0:
        fail("make -n", r.stdout + r.stderr)
    flags: list[str] | None = None
    units: list[Path] = []
    for line in r.stdout.splitlines():
        words = shlex.split(line.strip())
        sources = [w for w in words if w.endswith(".c")]
        if "-c" not in words or len(sources) != 1:
            continue
        keep, skip = [], False
        for w in words[1:]:
            if skip:
                skip = False
            elif w == "-o":
                skip = True
            elif w not in ("-c", sources[0]) and w not in DROPPED_FLAGS:
                keep.append(_tu_build.absolute_include_flag(w, SRC))
        if flags is None:
            flags = keep
        elif keep != flags:
            fail(f"{sources[0]} is compiled with flags the other units are not: {keep}")
        units.append(SRC / sources[0])
    if not units:
        fail("make -n produced no compile lines")
    return flags, units


def link_libraries() -> list[str]:
    """The terminfo and crypt libraries the Makefile's LIBS names, as
    badc's link takes them. The reference build gets its own from
    `make`."""
    args = []
    for what, lib in (("terminfo", _syslib.termcap_library()),
                      ("crypt", _syslib.crypt_library())):
        if lib is None:
            fail(f"no {what} library in the library directories")
        args += lib[0]
    return args


def build_badc(badc: Path, out_bin: Path, work: Path, optimize: bool,
               flags: list[str], units: list[Path], link: list[str]) -> None:
    work.mkdir(parents=True, exist_ok=True)
    _tu_build.build_tu_separate(
        badc, units, out_bin, optimize=optimize,
        compile_args=flags, link_args=link, work_dir=work,
    )


def env_for(home: Path) -> dict[str, str]:
    """screen keeps its session sockets under $HOME, so a per-run HOME
    keeps the two builds' sessions apart. TERM is a terminfo entry every
    database carries."""
    return {
        "TERM": "xterm", "HOME": str(home), "PATH": "/usr/bin:/bin",
        "SHELL": "/bin/sh", "LC_ALL": "C",
    }


def screen(exe: Path, home: Path, args: list[str]) -> subprocess.CompletedProcess:
    return subprocess.run(
        [str(exe), *args], env=env_for(home), cwd=str(home),
        capture_output=True, timeout=RUN_TIMEOUT,
    )


def scenario_detached(label: str, exe: Path, home: Path) -> bytes:
    """A detached session driven by a second run of the same binary
    over the session socket. Returns the hardcopy."""
    step = f"[{label}] detached session"
    rc = home / "rc"
    rc.write_text("startup_message off\n")
    r = screen(exe, home, ["-c", str(rc), "-d", "-m", "-S", SESSION, "/bin/cat"])
    if r.returncode != 0:
        fail(f"{step}: start exited {r.returncode}", (r.stdout + r.stderr).decode("latin-1"))
    if not wait_for(lambda: SESSION.encode() in screen(exe, home, ["-ls"]).stdout):
        fail(f"{step}: the session never appeared in -ls")
    screen(exe, home, ["-S", SESSION, "-X", "stuff", STUFFED.decode() + "\\n"])
    # The window's terminal driver echoes the stuffed line and `cat`
    # writes it back, so the settled window holds it twice above 22
    # blank rows. Both writes are polled for rather than assumed
    # ordered against the hardcopy.
    hardcopy = home / "hardcopy.txt"
    got = b""

    def settled() -> bool:
        nonlocal got
        hardcopy.unlink(missing_ok=True)
        screen(exe, home, ["-S", SESSION, "-X", "hardcopy", str(hardcopy)])
        if not hardcopy.is_file():
            return False
        got = hardcopy.read_bytes()
        lines = got.split(b"\n")
        return lines[:2] == [STUFFED, STUFFED] and set(lines[2:]) == {b""}

    if not wait_for(settled):
        fail(f"{step}: the window settled at {got!r}")
    screen(exe, home, ["-S", SESSION, "-X", "quit"])
    if not wait_for(lambda: SESSION.encode() not in screen(exe, home, ["-ls"]).stdout):
        fail(f"{step}: the session outlived the quit command")
    return got


def wait_for(predicate, timeout: float = 10.0) -> bool:
    deadline = time.monotonic() + timeout
    while time.monotonic() < deadline:
        if predicate():
            return True
        time.sleep(0.1)
    return False


def scenario_attached(label: str, exe: Path, home: Path) -> bytes:
    """screen attached to a pseudo-terminal, running cat in its window:
    a line typed at the terminal comes back through the window, and EOF
    ends the window and with it screen. Returns the terminal output."""
    step = f"[{label}] attached run"
    rc = home / "rc"
    rc.write_text("startup_message off\n")
    args = ["-c", str(rc), "-S", "attached", *WINDOW_CMD]
    pid, master = pty.fork()
    if pid == 0:
        try:
            fcntl.ioctl(0, termios.TIOCSWINSZ, struct.pack("HHHH", ROWS, COLS, 0, 0))
            os.chdir(str(home))
            os.execve(str(exe), [str(exe), *args], env_for(home))
        finally:
            os._exit(127)
    out = bytearray()
    pending = [(READY, TYPED + b"\n"), (TYPED, b"\x04")]
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
                out += chunk
            while pending and pending[0][0] in out:
                _, data = pending.pop(0)
                os.write(master, data)
            if hangup or (status is not None and not ready):
                break
            if time.monotonic() > deadline:
                os.kill(pid, 9)
                os.waitpid(pid, 0)
                fail(f"{step}: did not exit; {len(pending)} script steps left",
                     bytes(out).decode("latin-1"))
    finally:
        os.close(master)
    if status is None:
        _, status = os.waitpid(pid, 0)
    code = os.waitstatus_to_exitcode(status)
    if code != 0:
        fail(f"{step}: exit {code}", bytes(out).decode("latin-1"))
    # Once as the terminal's echo, once as cat's output through screen.
    if bytes(out).count(TYPED) != 2:
        fail(f"{step}: the typed line came back {bytes(out).count(TYPED)} times, expected 2",
             bytes(out).decode("latin-1"))
    if b"[screen is terminating]" not in out:
        fail(f"{step}: screen did not report terminating", bytes(out).decode("latin-1"))
    return bytes(out)


def parse_args() -> argparse.Namespace:
    ap = argparse.ArgumentParser(
        description="Build GNU Screen with badc and run it as server and client."
    )
    ap.add_argument(
        "--out",
        type=Path,
        help="after the smoke passes, copy the -O build of screen to this path",
    )
    return ap.parse_args()


def main() -> int:
    args = parse_args()
    if not sys.platform.startswith("linux"):
        print(f"screen smoke skipped ({sys.platform}: upstream 5.0.0 is glibc-only)")
        return 0
    start = time.monotonic()
    badc = resolve_badc()
    if shutil.which("cc") is None:
        fail("reference build: no host C compiler (cc) on PATH")

    r = subprocess.run([sys.executable, str(SCREEN_DIR / "setup.py")])
    if r.returncode == _setup.MISSING_ASSET:
        print(
            f"screen smoke skipped: {_setup.ASSET} is not on release "
            f"{_setup.RELEASE_TAG} yet"
        )
        return 0
    if r.returncode != 0:
        fail("setup.py")

    configure_and_make()
    flags, units = compile_lines()
    badc_link = link_libraries()

    with tempfile.TemporaryDirectory(prefix="screen-smoke-") as work_str:
        work = Path(work_str)
        builds: list[tuple[str, Path]] = [("reference", SRC / "screen")]
        for label, optimize in (("badc-O0", False), ("badc-O", True)):
            exe = work / f"screen.{label}"
            try:
                build_badc(badc, exe, work / f"obj-{label}", optimize,
                           flags, units, badc_link)
            except subprocess.CalledProcessError as e:
                fail(f"[{label}] build: {e.cmd[0]} exited {e.returncode}")
            builds.append((label, exe))

        results = {}
        for label, exe in builds:
            home = work / f"home-{label}"
            home.mkdir()
            try:
                results[label] = (
                    scenario_detached(label, exe, home),
                    scenario_attached(label, exe, home),
                )
            except SystemExit:
                # The check is differential. A reference build that cannot
                # drive its own sessions leaves nothing to compare badc
                # against, so the environment, not the compiler, is what
                # the run would be reporting on. `fail` printed the detail.
                if label != "reference":
                    raise
                print("screen smoke SKIP: the reference build does not run "
                      "the sessions here", file=sys.stderr)
                return 0
            if label != "reference":
                if results[label] != results["reference"]:
                    fail(f"[{label}] output differs from the reference build's",
                         f"badc: {results[label]!r}\n"
                         f"reference: {results['reference']!r}")
                print(f"smoke OK [{label}]: {len(units)} units, "
                      f"2 sessions match the reference")
        if args.out is not None:
            # The -O build is the last one in `builds`; it goes where asked
            # only once every run above has passed.
            args.out.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(builds[-1][1], args.out)
            args.out.chmod(0o755)
            print(f"wrote {args.out}")
    print(f"screen smoke OK ({time.monotonic() - start:.1f}s)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
