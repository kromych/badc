#!/usr/bin/env python3
"""Build libmill's coroutine core with badc and run its own tests.

Pipeline:
  - ``setup.py`` fetches the pinned upstream tree under ``.cache/``
    and applies the badc patches described there.
  - The nine coroutine-core translation units (cr, chan, debug, list,
    mfork, poller, slist, stack, timer) are archived into libmill.a
    via ``badc --ar``.
  - The upstream tests exercising the switch core -- go (spawn /
    yield / stack reuse / mfork), cls (coroutine-local storage),
    chan and choose (channel rendezvous through suspend / resume) --
    are compiled, linked against the archive, and run. Each test is
    assert-based and must exit 0.

Both -O0 and -O are exercised (with -UNDEBUG at -O so the predefined
NDEBUG does not strip the tests' asserts). Context switching runs
sigsetjmp/siglongjmp plus a one-instruction inline-asm stack-pointer
move on every platform; see setup.py for why the upstream x86-64 asm
path and the VLA stack switch are patched out under badc.

The network/fs/timing suites (tcp, udp, unix, file, ssl, dns, sleep)
stay out: the smoke targets the context-switch core and must stay
deterministic on loaded CI runners.

POSIX only. Override the badc binary via the ``BADC`` env var
(default: ``target/release/badc``).
"""

from __future__ import annotations

import os
import subprocess
import sys
from pathlib import Path

MILL_DIR = Path(__file__).resolve().parent
REPO_ROOT = MILL_DIR.parent.parent
UPSTREAM_SHA = "e8937e624757663f5379018cae3f2b3e916afb6c"
SRC = MILL_DIR / ".cache" / f"libmill-{UPSTREAM_SHA}"

LIB_UNITS = ("cr", "chan", "debug", "list", "mfork", "poller", "slist", "stack", "timer")
TESTS = ("go", "cls", "chan", "choose")


def badc_path() -> str:
    env = os.environ.get("BADC")
    if env:
        return env
    p = REPO_ROOT / "target" / "release" / "badc"
    if not p.is_file():
        sys.exit(f"smoke: badc not built at {p} -- run `cargo build --release --features full`")
    return str(p)


def run(cmd, **kw):
    return subprocess.run(cmd, capture_output=True, text=True, timeout=180, **kw)


def base_flags() -> list[str]:
    # MILL_ARCH_FALLBACK selects the sigsetjmp context switch (the
    # x86-64 asm path does not compile under badc; see setup.py) and
    # MILL_BADC_SETSP the asm sp move. --gnu satisfies libmill's
    # __GNUC__/__clang__ compiler check.
    flags = ["--gnu", "-DMILL_ARCH_FALLBACK", "-DMILL_BADC_SETSP"]
    if sys.platform == "darwin":
        # TODO(badc): no bundled <sys/event.h>, so the default kqueue
        # poller cannot build; MILL_POLL is the library's poll(2) knob.
        flags.append("-DMILL_POLL")
    return flags


def build_and_run(badc: str, out: Path, optimize: bool) -> bool:
    label = "-O" if optimize else "-O0"
    opt = ["-O", "-UNDEBUG"] if optimize else []
    flags = opt + base_flags()

    lib = out / "libmill.a"
    srcs = [str(SRC / f"{u}.c") for u in LIB_UNITS]
    r = run([badc, *flags, "--ar", *srcs, "-o", str(lib)])
    if r.returncode != 0:
        print(f"smoke FAIL [{label}]: library build\n{r.stderr[-2000:]}", file=sys.stderr)
        return False

    ok = True
    for t in TESTS:
        exe = out / f"t_{t}"
        r = run([badc, *flags, str(SRC / "tests" / f"{t}.c"), str(lib), "-o", str(exe)])
        if r.returncode != 0:
            print(f"smoke FAIL [{label}] {t}: build\n{r.stderr[-2000:]}", file=sys.stderr)
            ok = False
            continue
        # The tests are assert-based and silent on success (choose
        # emits its own gotrace on stderr); exit 0 is the contract.
        r = run([str(exe)])
        if r.returncode != 0:
            print(
                f"smoke FAIL [{label}] {t}: exit {r.returncode}\n{r.stdout[-800:]}{r.stderr[-800:]}",
                file=sys.stderr,
            )
            ok = False
        else:
            print(f"smoke OK [{label}] libmill test {t}")
    return ok


def main() -> int:
    if os.name != "posix" or sys.platform.startswith("win"):
        print("libmill smoke skipped (POSIX-only library)")
        return 0

    badc = badc_path()
    r = subprocess.run([sys.executable, str(MILL_DIR / "setup.py")])
    if r.returncode != 0:
        sys.exit("smoke: setup.py failed")

    out = MILL_DIR / ".cache" / "build"
    out.mkdir(parents=True, exist_ok=True)

    ok = build_and_run(badc, out, optimize=False)
    ok &= build_and_run(badc, out, optimize=True)
    if not ok:
        return 1
    print("libmill smoke OK")
    return 0


if __name__ == "__main__":
    sys.exit(main())
