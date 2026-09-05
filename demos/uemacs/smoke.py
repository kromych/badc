#!/usr/bin/env python3
"""Build MicroEMACS (uemacs) with badc and drive the editor under a pty.

Pipeline:
  - ``setup.py`` fetches the pinned upstream tree under ``.cache/``.
  - Every unit of the Makefile's ``SRC`` list (35 files) is compiled
    with ``badc -c`` under the Makefile's defines for the host OS, and
    badc's linker produces ``em`` against the system terminfo library,
    at both -O0 and -O.
  - The same tree is built once with the host C compiler as the
    reference.
  - Each binary runs under a pseudo-terminal (the editor drives the
    terminal through termios and termcap) with ``TERM=vt100`` and a
    24x80 window, in two scenarios:
      * a startup file (``@file``, the editor's own command language)
        opens a scratch file, appends text, saves and exits, with no
        keystrokes;
      * a startup file leaves the editor at its command loop, and the
        text, the save (``C-x C-s``) and the exit (``C-x C-c``) arrive
        as keystrokes through the pty.
    The file each scenario writes is checked byte for byte against the
    expected text; the badc builds' files, and the terminal output of
    the keystroke-free scenario, are compared with the reference
    build's.

POSIX only: the terminal layer is termios + termcap. Override the badc
binary via the ``BADC`` env var (default: ``target/release/badc``).
"""

from __future__ import annotations

import fcntl
import glob
import importlib.util
import os
import pty
import select
import shutil
import struct
import subprocess
import sys
import tempfile
import termios
import time
from pathlib import Path

UEMACS_DIR = Path(__file__).resolve().parent
REPO_ROOT = UEMACS_DIR.parent.parent
UPSTREAM_SHA = "1c1b25ef723c952ca557cb5ff6d8db159ef1d4bc"
SRC = UEMACS_DIR / ".cache" / f"uemacs-{UPSTREAM_SHA}"
INCLUDE_DIR = UEMACS_DIR.parent / "include"

_tu_spec = importlib.util.spec_from_file_location(
    "_tu_build", UEMACS_DIR.parent / "_tu_build.py"
)
_tu_build = importlib.util.module_from_spec(_tu_spec)
_tu_spec.loader.exec_module(_tu_build)
_setup_spec = importlib.util.spec_from_file_location(
    "uemacs_setup", UEMACS_DIR / "setup.py"
)
_setup = importlib.util.module_from_spec(_setup_spec)
_setup_spec.loader.exec_module(_setup)

# The Makefile's SRC list.
UNITS = (
    "ansi", "basic", "bind", "buffer", "crypt", "display", "eval", "exec",
    "file", "fileio", "ibmpc", "input", "isearch", "line", "lock", "main",
    "pklock", "posix", "random", "region", "search", "spawn", "tcap",
    "termio", "vmsvt", "vt52", "window", "word", "names", "globals",
    "version", "usage", "wrapper", "utf8", "util",
)

# The Makefile's DEFINES per `uname -s`.
DEFINES = {
    "darwin": (
        "AUTOCONF", "POSIX", "SYSV", "_DARWIN_C_SOURCE", "_BSD_SOURCE",
        "_SVID_SOURCE", "_XOPEN_SOURCE=600",
    ),
    "linux": ("AUTOCONF", "POSIX", "USG", "_XOPEN_SOURCE=600", "_GNU_SOURCE"),
}

# Where the Linux distributions keep the shared libraries.
LIB_DIRS = (
    "/usr/lib64", "/lib64", "/usr/lib", "/lib",
    "/usr/lib/x86_64-linux-gnu", "/usr/lib/aarch64-linux-gnu",
)

ROWS, COLS = 24, 80
RUN_TIMEOUT = 30.0

SEED = b"seed line\n"

# Appends two lines to the scratch file, saves it, and exits: the
# editor never reaches its command loop.
SCRIPT_RC = """\
; uemacs smoke: append to the scratch file, save, exit.
find-file "scratch.txt"
end-of-file
insert-string "appended by the startup script"
newline
insert-string "line two"
save-file
exit-emacs
"""
SCRIPT_EXPECTED = SEED + b"appended by the startup script\nline two\n"

# Opens the scratch file and returns to the command loop; the text, the
# save and the exit are keystrokes. The save is `C-x C-d`, the second
# binding of `save-file`: the editor keeps XON/XOFF flow control on, so
# `C-s` would stop the terminal's output instead of reaching it.
KEYS_RC = """\
; uemacs smoke: open the scratch file; the rest arrives as keystrokes.
find-file "scratch.txt"
end-of-file
"""
KEYS = b"typed through the pty" + b"\x18\x04" + b"\x18\x03"
KEYS_EXPECTED = SEED + b"typed through the pty\n"


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


def host_defines() -> tuple[str, ...]:
    if sys.platform == "darwin":
        return DEFINES["darwin"]
    if sys.platform.startswith("linux"):
        return DEFINES["linux"]
    fail(f"no build configuration for {sys.platform}")
    return ()


def termcap_library() -> tuple[list[str], list[str]]:
    """The link inputs, for badc and for the host compiler, that supply
    the termcap entry points tcap.c calls. macOS: the SDK's libcurses
    stub, as the Makefile links. Linux: the runtime library located
    here -- libtinfo where ncurses is split, else libncurses -- since the
    `-l` names need the dev package's symlinks and linker scripts, which
    a runner may not carry; badc's `-l` lookup accepts the versioned
    name, and the host compiler is handed the path."""
    if sys.platform == "darwin":
        return ["-lcurses"], ["-lcurses"]
    for name in ("tinfo", "ncursesw", "ncurses"):
        for d in LIB_DIRS:
            found = sorted(glob.glob(f"{d}/lib{name}.so*"), key=len)
            if found:
                return [f"-l{name}"], [found[0]]
    fail("no terminfo library (libtinfo / libncurses) in the library directories")
    return [], []


def build_badc(badc: Path, out_bin: Path, work: Path, optimize: bool, link: list[str]) -> None:
    work.mkdir(parents=True, exist_ok=True)
    _tu_build.build_tu_separate(
        badc,
        [SRC / f"{u}.c" for u in UNITS],
        out_bin,
        optimize=optimize,
        defines=host_defines(),
        include_paths=(INCLUDE_DIR,),
        link_args=link,
        work_dir=work,
    )


def build_reference(cc: str, out_bin: Path, link: list[str]) -> None:
    cmd = [cc, "-O2", "-w", *[f"-D{d}" for d in host_defines()], "-o", str(out_bin)]
    cmd += [str(SRC / f"{u}.c") for u in UNITS]
    cmd += link
    subprocess.run(cmd, check=True)


def run_editor(exe: Path, cwd: Path, args: list[str], keys: bytes) -> tuple[int, bytes]:
    """Run the editor under a fresh pty and return (exit code, output).
    `keys` are written once the editor has produced output, which it
    does only after `ttopen` has put the terminal into raw mode, so the
    line discipline neither echoes nor line-buffers them. HOME and PATH
    point nowhere: the startup file is looked up there before the
    working directory, and nothing else reads them."""
    env = {"TERM": "vt100", "HOME": "/nonexistent", "PATH": "/nonexistent"}
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
            if ready:
                try:
                    chunk = os.read(master, 4096)
                except OSError:
                    chunk = b""  # EIO: the slave side is gone (Linux)
                if not chunk:
                    break
                output += chunk
                if pending:
                    os.write(master, pending)
                    pending = b""
            elif status is not None:
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


def run_scenario(
    label: str, exe: Path, work: Path, rc: str, keys: bytes, expected: bytes
) -> bytes:
    """One editor run in its own directory; returns the terminal
    output. Exits the smoke on a failure."""
    run_dir = work / f"{label}-{'keys' if keys else 'script'}"
    run_dir.mkdir()
    (run_dir / "scratch.txt").write_bytes(SEED)
    (run_dir / "start.rc").write_text(rc)
    step = f"[{label}] {'keystroke' if keys else 'startup-file'} run"
    try:
        code, out = run_editor(exe, run_dir, ["@start.rc"], keys)
    except TimeoutError as e:
        fail(f"{step}: {e}")
    if code != 0:
        fail(f"{step}: exit {code}", out.decode("latin-1"))
    got = (run_dir / "scratch.txt").read_bytes()
    if got != expected:
        fail(f"{step}: scratch.txt is {got!r}, expected {expected!r}", out.decode("latin-1"))
    return out


def main() -> int:
    if os.name != "posix" or sys.platform.startswith("win"):
        print("uemacs smoke skipped (POSIX-only terminal layer)")
        return 0
    start = time.monotonic()
    badc = resolve_badc()
    cc = shutil.which("cc")
    if cc is None:
        fail("reference build: no host C compiler (cc) on PATH")

    r = subprocess.run([sys.executable, str(UEMACS_DIR / "setup.py")])
    if r.returncode == _setup.MISSING_ASSET:
        print(
            f"uemacs smoke skipped: {_setup.ASSET} is not on release "
            f"{_setup.RELEASE_TAG} yet"
        )
        return 0
    if r.returncode != 0:
        fail("setup.py")
    badc_link, cc_link = termcap_library()

    with tempfile.TemporaryDirectory(prefix="uemacs-smoke-") as work_str:
        work = Path(work_str)
        builds: list[tuple[str, Path]] = []
        for label, optimize in (("badc-O0", False), ("badc-O", True)):
            exe = work / f"em.{label}"
            try:
                build_badc(badc, exe, work / f"obj-{label}", optimize, badc_link)
            except subprocess.CalledProcessError as e:
                fail(f"[{label}] build: {e.cmd[0]} exited {e.returncode}")
            builds.append((label, exe))
        ref = work / "em.ref"
        try:
            build_reference(cc, ref, cc_link)
        except subprocess.CalledProcessError as e:
            fail(f"[reference] build: {cc} exited {e.returncode}")

        ref_out = run_scenario("reference", ref, work, SCRIPT_RC, b"", SCRIPT_EXPECTED)
        run_scenario("reference", ref, work, KEYS_RC, KEYS, KEYS_EXPECTED)
        for label, exe in builds:
            out = run_scenario(label, exe, work, SCRIPT_RC, b"", SCRIPT_EXPECTED)
            if out != ref_out:
                fail(
                    f"[{label}] startup-file run: terminal output differs from the "
                    f"reference build's",
                    f"badc: {out!r}\nreference: {ref_out!r}",
                )
            run_scenario(label, exe, work, KEYS_RC, KEYS, KEYS_EXPECTED)
            print(f"smoke OK [{label}]: {len(UNITS)} units, 2 editor runs match the reference")
    print(f"uemacs smoke OK ({time.monotonic() - start:.1f}s)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
