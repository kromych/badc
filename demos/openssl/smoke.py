#!/usr/bin/env python3
"""Build OpenSSL 4.1.0 with badc and run OpenSSL's own test suite.

Pipeline, once per optimization level (-O0, then -O):
  - ``setup.py`` fetches + extracts the release under ``.cache/openssl-4.1.0``.
  - ``Configure`` runs out of tree in ``.cache/build-<level>`` with a target
    from ``badc.conf``, which inherits the stock target of the host and
    names badc as the compiler, so every object and executable --
    libcrypto, libssl, the ``openssl`` application and the test programs --
    comes out of badc's compiler and linker. The host's ``ar`` archives
    the objects.
  - ``make build_sw`` builds it; ``make test`` runs ``test/run_tests.pl``
    over every recipe but ``SERIAL_RECIPES``, ``HARNESS_JOBS`` at a time,
    then over those alone; the harness's summaries decide the verdict.

The build directory is removed first: make does not track the compiler
binary, so objects from an earlier badc would otherwise survive.

Override the badc binary via the ``BADC`` env var (default:
``target/release/badc``).
"""

from __future__ import annotations

import argparse
import os
import platform
import re
import shutil
import subprocess
import sys
import time
from pathlib import Path

DEMO_DIR = Path(__file__).resolve().parent
REPO_ROOT = DEMO_DIR.parent.parent
VERSION = "4.1.0"
CACHE = DEMO_DIR / ".cache"
SRC = CACHE / f"openssl-{VERSION}"

# The badc.conf target for each host.
TARGETS = {
    ("darwin", "arm64"): "badc-darwin64-arm64",
    ("linux", "x86_64"): "badc-linux-x86_64",
    ("linux", "aarch64"): "badc-linux-aarch64",
}

# no-asm: the subject is badc's C compilation; the perlasm modules are
# assembler sources and their C implementations are what this builds
# instead. no-shared: libcrypto and libssl are archives the programs link
# statically. no-module: the legacy provider is linked into libcrypto
# rather than loaded as a module.
CONFIGURE_OPTIONS = ("no-asm", "no-shared", "no-module")

LEVELS = {"O0": "-O0", "O": "-O"}

# Recipes run on their own after the rest. test_quicapi's blocking-mode
# cases run the server in a thread that advances the test's clock 1 ms per
# pass while the client handshakes in real time, so a client slowed by a
# loaded machine lets the server's idle timeout end the connection. Measured
# on x86-64 with 12 recipes at a time: the gcc -O0 build of this
# configuration fails test_quic_write_read as the badc -O0 and -O builds
# do; run alone, 6 of 6 runs of each of the three pass.
SERIAL_RECIPES = ("test_quicapi",)

BUILD_TIMEOUT = 3600
TEST_TIMEOUT = 3600


def resolve_badc() -> Path:
    env = os.environ.get("BADC")
    if env:
        return Path(env).resolve()
    exe = "badc.exe" if os.name == "nt" else "badc"
    p = REPO_ROOT / "target" / "release" / exe
    if not p.is_file():
        sys.exit(f"smoke: badc not built at {p} -- run `cargo build --release --features full`")
    return p


def fail(step: str, detail: str = "") -> None:
    tail = f"\n{detail[-3000:]}" if detail else ""
    print(f"smoke FAIL: {step}{tail}", file=sys.stderr)
    sys.exit(1)


def host_target() -> str | None:
    return TARGETS.get((sys.platform, platform.machine()))


def run_logged(cmd: list[str], cwd: Path, log: Path, timeout: int, env=None) -> int:
    """Run `cmd` with its output in `log`. Standard input is /dev/null: the
    applications ask the console for a passphrase when a decoder needs one,
    and tcgetattr on an inherited socket fails with an errno they treat as
    an error (EOPNOTSUPP on macOS), where a terminal or /dev/null is not."""
    with open(log, "w") as fh:
        try:
            r = subprocess.run(cmd, cwd=cwd, stdin=subprocess.DEVNULL, stdout=fh,
                               stderr=subprocess.STDOUT, timeout=timeout, env=env)
        except subprocess.TimeoutExpired:
            return -1
    return r.returncode


def build(badc: Path, target: str, level: str, jobs: int, keep_going: bool, log) -> Path:
    bld = CACHE / f"build-{level}"
    if bld.exists():
        shutil.rmtree(bld)
    bld.mkdir(parents=True)
    cmd = ["perl", str(SRC / "Configure"), f"--config={DEMO_DIR / 'badc.conf'}", target,
           f"CC={badc}", f"CFLAGS={LEVELS[level]}", *CONFIGURE_OPTIONS]
    log(f"[{level}] configure: {' '.join(cmd[3:])}")
    rc = run_logged(cmd, bld, bld / "configure.log", 600)
    if rc != 0:
        fail(f"[{level}] Configure exited {rc}", (bld / "configure.log").read_text())
    t0 = time.monotonic()
    make = ["make", f"-j{jobs}", *(["-k"] if keep_going else []), "build_sw"]
    rc = run_logged(make, bld, bld / "build.log", BUILD_TIMEOUT)
    text = (bld / "build.log").read_text(errors="replace")
    if rc != 0:
        errs = [l for l in text.splitlines() if ": error: " in l]
        fail(f"[{level}] make build_sw exited {rc}", "\n".join(errs[:40]) or text)
    print(f"[{level}] built in {time.monotonic() - t0:.0f}s", flush=True)
    return bld


def run_pass(bld: Path, level: str, name: str, tests: str | None, jobs: int) -> None:
    """One `make test` run; exits the smoke on a failure."""
    env = dict(os.environ, HARNESS_JOBS=str(jobs))
    cmd = ["make", "test"] + ([f"TESTS={tests}"] if tests else [])
    log = bld / f"test-{name}.log"
    t0 = time.monotonic()
    rc = run_logged(cmd, bld, log, TEST_TIMEOUT, env=env)
    text = log.read_text(errors="replace")
    # `make test` runs the harness more than once (a nested run over no
    # recipes comes first); the suite's summary is the last one.
    files = re.findall(r"^Files=(\d+), Tests=(\d+)", text, re.M)
    result = re.findall(r"^Result: (\w+)", text, re.M)
    summary = f"{files[-1][0]} files, {files[-1][1]} tests" if files else "no summary"
    elapsed = time.monotonic() - t0
    if rc != 0 or not result or result[-1] != "PASS":
        failed = [l for l in text.splitlines() if re.match(r"^\S+\.t\s+\(Wstat", l)
                  or l.startswith("  Failed test") or re.search(r"\.\.\s+Dubious|\bnot ok\b", l)]
        fail(f"[{level}] make test ({name}) exited {rc} ({summary}, {elapsed:.0f}s; {log})",
             "\n".join(failed[:60]) or text)
    print(f"[{level}] make test ({name}): {summary}, Result: PASS ({elapsed:.0f}s)", flush=True)


def run_tests(bld: Path, level: str, jobs: int, tests: str | None) -> None:
    if tests:
        run_pass(bld, level, "selected", tests, jobs)
        return
    run_pass(bld, level, "parallel", " ".join(f"-{t}" for t in SERIAL_RECIPES), jobs)
    run_pass(bld, level, "serial", " ".join(SERIAL_RECIPES), 1)


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("-v", "--verbose", action="store_true")
    ap.add_argument("--level", choices=("O0", "O", "both"), default="both")
    ap.add_argument("--tests", help="the TESTS= selection passed to `make test`")
    ap.add_argument("--jobs", type=int, default=os.cpu_count() or 1)
    ap.add_argument("--keep-going", action="store_true",
                    help="pass -k to make, so every unit that fails is reported")
    args = ap.parse_args(argv)

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    target = host_target()
    if target is None:
        print(f"openssl smoke skipped ({sys.platform} {platform.machine()}: no badc.conf target)")
        return 0
    start = time.monotonic()
    badc = resolve_badc()
    r = subprocess.run([sys.executable, str(DEMO_DIR / "setup.py")] + (["-v"] if args.verbose else []))
    if r.returncode != 0:
        fail("setup.py")
    levels = ("O0", "O") if args.level == "both" else (args.level,)
    for level in levels:
        bld = build(badc, target, level, args.jobs, args.keep_going, log)
        run_tests(bld, level, args.jobs, args.tests)
    print(f"openssl smoke OK ({time.monotonic() - start:.0f}s)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
