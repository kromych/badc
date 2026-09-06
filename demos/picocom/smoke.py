#!/usr/bin/env python3
"""Build picocom with badc and drive it between two pseudo-terminals.

Pipeline:
  - ``setup.py`` fetches the pinned upstream tree under ``.cache/``.
  - Every unit of the Makefile's ``OBJS`` list (7 files) is compiled
    with ``badc -c`` under the Makefile's defines, and badc's linker
    produces ``picocom``, at both -O0 and -O. picocom needs no library
    beyond libc: its terminal layer is termios plus the modem-line
    ioctls, so the link has no ``-l``.
  - The same tree is built once with the host C compiler as the
    reference.
  - Each binary runs with a pty pair standing in for the serial port
    (picocom opens the slave by its ``/dev/`` name and the harness
    holds the master) and a second pty for picocom's own terminal, in
    two scenarios:
      * ``--exit-after`` with an ``--initstring``: picocom initialises
        the port, writes the string to it and exits on its own timer,
        with no keystrokes;
      * interactive: the harness sends a line to the port and waits for
        picocom to paint it on the terminal, types a line at the
        terminal and waits for it at the port, then exits picocom with
        ``C-a C-x``. ``--logfile`` records what arrived from the port,
        and the file is checked too.
    The bytes each direction carried are checked against the expected
    text, and the badc builds' terminal output of the keystroke-free
    scenario is compared with the reference build's.

POSIX only: the terminal layer is termios. Override the badc binary via
the ``BADC`` env var (default: ``target/release/badc``).
"""

from __future__ import annotations

import argparse
import fcntl
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

PICOCOM_DIR = Path(__file__).resolve().parent
REPO_ROOT = PICOCOM_DIR.parent.parent
VERSION = "3.1"
SRC = PICOCOM_DIR / ".cache" / f"picocom-{VERSION}"

_tu_spec = importlib.util.spec_from_file_location(
    "_tu_build", PICOCOM_DIR.parent / "_tu_build.py"
)
_tu_build = importlib.util.module_from_spec(_tu_spec)
_tu_spec.loader.exec_module(_tu_build)
_setup_spec = importlib.util.spec_from_file_location(
    "picocom_setup", PICOCOM_DIR / "setup.py"
)
_setup = importlib.util.module_from_spec(_setup_spec)
_setup_spec.loader.exec_module(_setup)

# The Makefile's OBJS list. termios2.c is the Linux custom-baudrate
# path and custbaud_bsd.c the macOS one; each is empty on the other
# platform and both are in OBJS unconditionally.
UNITS = (
    "picocom", "term", "fdio", "split", "termios2", "custbaud_bsd",
    "linenoise-1.0/linenoise",
)

# The Makefile's CPPFLAGS with its defaults left as they ship.
DEFINES = (
    f'VERSION_STR="{VERSION}"',
    "TTY_Q_SZ=0",
    "HIGH_BAUD",
    "USE_FLOCK",
    'HISTFILE=".picocom_history"',
    "LINENOISE",
)

ROWS, COLS = 24, 80
RUN_TIMEOUT = 30.0

# picocom's default escape character, and the exit command after it.
EXIT_KEYS = b"\x01\x18"

INIT_STRING = "picocom-initstring-to-the-port"
PORT_LINE = b"a line arriving from the port\r\n"
TYPED_LINE = b"a line typed at the terminal\r"


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


def build_badc(badc: Path, out_bin: Path, work: Path, optimize: bool) -> None:
    work.mkdir(parents=True, exist_ok=True)
    _tu_build.build_tu_separate(
        badc,
        [SRC / f"{u}.c" for u in UNITS],
        out_bin,
        optimize=optimize,
        defines=DEFINES,
        work_dir=work,
    )


def build_reference(cc: str, out_bin: Path) -> None:
    cmd = [cc, "-O2", "-w", *[f"-D{d}" for d in DEFINES], "-o", str(out_bin)]
    cmd += [str(SRC / f"{u}.c") for u in UNITS]
    subprocess.run(cmd, check=True)


def run_picocom(
    exe: Path, cwd: Path, args: list[str], script: list[tuple[bytes, str, bytes, str]]
) -> tuple[int, bytes, bytes]:
    """Run picocom against a fresh pty pair and return (exit code,
    terminal output, bytes the port received).

    `script` is a list of (trigger, watch, data, target) steps taken in
    order: once `trigger` has appeared in the stream named by `watch`
    (`tty` for picocom's own terminal, `port` for the serial side),
    `data` is written to `target`. HOME and PATH point nowhere: the
    linenoise history file and the send/receive commands are looked up
    there, and nothing else reads them."""
    port_master, port_slave = pty.openpty()
    port_name = os.ttyname(port_slave)
    env = {"TERM": "vt100", "HOME": "/nonexistent", "PATH": "/nonexistent"}
    pid, tty_master = pty.fork()
    if pid == 0:
        try:
            fcntl.ioctl(0, termios.TIOCSWINSZ, struct.pack("HHHH", ROWS, COLS, 0, 0))
            os.chdir(cwd)
            os.execve(str(exe), [str(exe), *args, port_name], env)
        finally:
            os._exit(127)
    streams = {"tty": bytearray(), "port": bytearray()}
    fds = {tty_master: "tty", port_master: "port"}
    pending = list(script)
    status: int | None = None
    deadline = time.monotonic() + RUN_TIMEOUT
    try:
        while True:
            if status is None:
                wpid, st = os.waitpid(pid, os.WNOHANG)
                if wpid == pid:
                    status = st
            ready, _, _ = select.select(list(fds), [], [], 0.05)
            hangup = False
            for fd in ready:
                try:
                    chunk = os.read(fd, 4096)
                except OSError:
                    chunk = b""  # EIO: the slave side is gone (Linux)
                if not chunk and fd is tty_master:
                    hangup = True
                streams[fds[fd]] += chunk
            while pending and pending[0][0] in streams[pending[0][1]]:
                _, _, data, target = pending.pop(0)
                os.write(tty_master if target == "tty" else port_master, data)
            if hangup or (status is not None and not ready):
                break
            if time.monotonic() > deadline:
                os.kill(pid, 9)
                os.waitpid(pid, 0)
                raise TimeoutError(
                    f"{exe.name} {' '.join(args)} did not exit; "
                    f"{len(pending)} script steps left"
                )
    finally:
        os.close(tty_master)
        os.close(port_master)
        os.close(port_slave)
    if status is None:
        _, status = os.waitpid(pid, 0)
    return os.waitstatus_to_exitcode(status), bytes(streams["tty"]), bytes(
        streams["port"]
    )


def normalise(out: bytes) -> bytes:
    """The banner names the port device, whose number differs per run."""
    return b"".join(
        line.split(b":")[0] + b": <port>" if line.startswith(b"port is") else line
        for line in out.splitlines(keepends=True)
    )


def scenario_oneshot(label: str, exe: Path, work: Path) -> bytes:
    """picocom sends --initstring to the port and exits on its own
    timer. Returns the terminal output."""
    run_dir = work / f"{label}-oneshot"
    run_dir.mkdir()
    step = f"[{label}] initstring run"
    args = ["--baud", "9600", "--exit-after", "300", "--initstring", INIT_STRING]
    try:
        code, out, port = run_picocom(exe, run_dir, args, [])
    except TimeoutError as e:
        fail(f"{step}: {e}")
    if code != 0:
        fail(f"{step}: exit {code}", out.decode("latin-1"))
    if port != INIT_STRING.encode():
        fail(
            f"{step}: the port received {port!r}, expected "
            f"{INIT_STRING.encode()!r}",
            out.decode("latin-1"),
        )
    return out


def scenario_interactive(label: str, exe: Path, work: Path) -> None:
    """A line each way through picocom, then C-a C-x."""
    run_dir = work / f"{label}-interactive"
    run_dir.mkdir()
    log = run_dir / "picocom.log"
    step = f"[{label}] interactive run"
    args = ["--baud", "9600", "--omap", "crcrlf", "--logfile", str(log)]
    script = [
        (b"Terminal ready", "tty", PORT_LINE, "port"),
        (PORT_LINE.strip(), "tty", TYPED_LINE, "tty"),
        (TYPED_LINE.strip(), "port", EXIT_KEYS, "tty"),
    ]
    try:
        code, out, port = run_picocom(exe, run_dir, args, script)
    except TimeoutError as e:
        fail(f"{step}: {e}")
    if code != 0:
        fail(f"{step}: exit {code}", out.decode("latin-1"))
    # --omap crcrlf expands the terminal's CR into CR LF on the way out.
    expected_port = TYPED_LINE.replace(b"\r", b"\r\n")
    if port != expected_port:
        fail(
            f"{step}: the port received {port!r}, expected {expected_port!r}",
            out.decode("latin-1"),
        )
    if PORT_LINE.strip() not in out:
        fail(f"{step}: the port's line never reached the terminal", out.decode("latin-1"))
    if b"Terminating..." not in out:
        fail(f"{step}: C-a C-x did not end the session", out.decode("latin-1"))
    logged = log.read_bytes()
    if logged != PORT_LINE:
        fail(f"{step}: the logfile holds {logged!r}, expected {PORT_LINE!r}")


def parse_args() -> argparse.Namespace:
    ap = argparse.ArgumentParser(
        description="Build picocom with badc and drive it between two ptys."
    )
    ap.add_argument(
        "--out",
        type=Path,
        help="after the smoke passes, copy the -O build of picocom to this path",
    )
    return ap.parse_args()


def main() -> int:
    args = parse_args()
    if os.name != "posix" or sys.platform.startswith("win"):
        print("picocom smoke skipped (POSIX-only terminal layer)")
        return 0
    start = time.monotonic()
    badc = resolve_badc()
    cc = shutil.which("cc")
    if cc is None:
        fail("reference build: no host C compiler (cc) on PATH")

    r = subprocess.run([sys.executable, str(PICOCOM_DIR / "setup.py")])
    if r.returncode == _setup.MISSING_ASSET:
        print(
            f"picocom smoke skipped: {_setup.ASSET} is not on release "
            f"{_setup.RELEASE_TAG} yet"
        )
        return 0
    if r.returncode != 0:
        fail("setup.py")

    with tempfile.TemporaryDirectory(prefix="picocom-smoke-") as work_str:
        work = Path(work_str)
        builds: list[tuple[str, Path]] = []
        for label, optimize in (("badc-O0", False), ("badc-O", True)):
            exe = work / f"picocom.{label}"
            try:
                build_badc(badc, exe, work / f"obj-{label}", optimize)
            except subprocess.CalledProcessError as e:
                fail(f"[{label}] build: {e.cmd[0]} exited {e.returncode}")
            builds.append((label, exe))
        ref = work / "picocom.ref"
        try:
            build_reference(cc, ref)
        except subprocess.CalledProcessError as e:
            fail(f"[reference] build: {cc} exited {e.returncode}")

        ref_out = normalise(scenario_oneshot("reference", ref, work))
        scenario_interactive("reference", ref, work)
        for label, exe in builds:
            out = normalise(scenario_oneshot(label, exe, work))
            if out != ref_out:
                fail(
                    f"[{label}] initstring run: terminal output differs from the "
                    f"reference build's",
                    f"badc: {out!r}\nreference: {ref_out!r}",
                )
            scenario_interactive(label, exe, work)
            print(f"smoke OK [{label}]: {len(UNITS)} units, 2 runs match the reference")
        if args.out is not None:
            # The -O build is the last one in `builds`; it goes where asked
            # only once every run above has passed.
            args.out.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(builds[-1][1], args.out)
            args.out.chmod(0o755)
            print(f"wrote {args.out}")
    print(f"picocom smoke OK ({time.monotonic() - start:.1f}s)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
