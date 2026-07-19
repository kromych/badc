#!/usr/bin/env python3
"""Build libdill's coroutine core with badc and run its own tests.

Pipeline:
  - ``setup.py`` fetches the pinned upstream tree under ``.cache/``
    and applies the badc patches described there.
  - The ten core translation units (chan, cr, handle, libdill, now,
    pollset, rbtree, stack, ctx, utils -- the no-DILL_SOCKETS set
    from upstream's Makefile.am) are archived into libdill.a via
    ``badc --ar``.
  - The upstream tests exercising the switch core -- go1/go2 (spawn,
    yield, hclose), chan and choose (rendezvous through suspend /
    resume), bundle (structured concurrency groups) -- are compiled,
    linked against the archive, and run. Each is assert-based and
    must exit 0.

Both -O0 and -O are exercised (with -UNDEBUG at -O so the predefined
NDEBUG does not strip the tests' asserts). On x86-64 context switching
runs upstream's native asm dill_setjmp/dill_longjmp; elsewhere it runs
sigsetjmp/siglongjmp (upstream's DILL_ARCH_FALLBACK). Both use the
one-instruction inline-asm stack-pointer move; see setup.py for why
the alloca stack switches are patched out under badc.

The socket/tls suites and the timing-sensitive sleep test stay out:
the smoke targets the context-switch core and must stay deterministic
on loaded CI runners.

POSIX only. Override the badc binary via the ``BADC`` env var
(default: ``target/release/badc``).
"""

from __future__ import annotations

import os
import platform
import subprocess
import sys
from pathlib import Path

DILL_DIR = Path(__file__).resolve().parent
REPO_ROOT = DILL_DIR.parent.parent
UPSTREAM_SHA = "32d0e8b733416208e0412a56490332772bc5c6e1"
SRC = DILL_DIR / ".cache" / f"libdill-{UPSTREAM_SHA}"

LIB_UNITS = ("chan", "cr", "handle", "libdill", "now", "pollset", "rbtree", "stack", "ctx", "utils")
TESTS = ("go1", "go2", "chan", "choose", "bundle")


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
    # x86-64 builds upstream's native asm context switch; other
    # architectures use DILL_ARCH_FALLBACK, upstream's own sigsetjmp
    # knob. DILL_BADC_SETSP selects the asm sp move added by setup.py.
    # The x86intrin.h shim next to this script satisfies now.c's
    # __rdtsc include on x86 targets. --gnu satisfies the visibility
    # and __builtin_expect surface.
    flags = [
        "--gnu",
        "-I",
        str(DILL_DIR),
        "-DDILL_BADC_SETSP",
    ]
    if platform.machine().lower() not in ("x86_64", "amd64"):
        flags.append("-DDILL_ARCH_FALLBACK")
    if sys.platform == "darwin":
        # TODO(badc): no bundled <sys/event.h>, so the default kqueue
        # pollset cannot build; DILL_POLL is the library's poll(2)
        # knob. BSD gates utils.c's OPEN_MAX fallback for macOS's
        # unlimited RLIMIT_NOFILE (upstream gets it from
        # <sys/param.h>; badc's headers do not define it).
        flags += ["-DDILL_POLL", "-DBSD=199506"]
    return flags


def build_and_run(badc: str, out: Path, optimize: bool) -> bool:
    label = "-O" if optimize else "-O0"
    opt = ["-O", "-UNDEBUG"] if optimize else []
    flags = opt + base_flags()

    lib = out / "libdill.a"
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
        r = run([str(exe)])
        if r.returncode != 0:
            print(
                f"smoke FAIL [{label}] {t}: exit {r.returncode}\n{r.stdout[-800:]}{r.stderr[-800:]}",
                file=sys.stderr,
            )
            ok = False
        else:
            print(f"smoke OK [{label}] libdill test {t}")
    return ok


def main() -> int:
    if os.name != "posix" or sys.platform.startswith("win"):
        print("libdill smoke skipped (POSIX-only library)")
        return 0

    badc = badc_path()
    r = subprocess.run([sys.executable, str(DILL_DIR / "setup.py")])
    if r.returncode != 0:
        sys.exit("smoke: setup.py failed")

    out = DILL_DIR / ".cache" / "build"
    out.mkdir(parents=True, exist_ok=True)

    ok = build_and_run(badc, out, optimize=False)
    ok &= build_and_run(badc, out, optimize=True)
    if not ok:
        return 1
    print("libdill smoke OK")
    return 0


if __name__ == "__main__":
    sys.exit(main())
