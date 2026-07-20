#!/usr/bin/env python3
"""Build tsoding/coroutines with badc and run its examples.

The library's context switch is hand-written SysV AMD64 asm inside
four `__attribute__((naked))` functions (register pushes, `movq
%rsp/%rdi` swaps, `jmp` into the scheduler, bare `ret`), which makes
it a direct regression guard for badc's naked-function emission and
x86-64 inline-asm surface. badc compiles the library as written -- no
patches, no fallback.

Every POSIX host cross-compiles and links the linux-x64 binaries at
-O0 and -O (exercising the asm encoding paths); the examples then RUN
where the host actually is linux-x86_64 -- upstream supports only
that platform (SysV asm + MAP_STACK|MAP_GROWSDOWN mmap). Two
deterministic examples are pinned byte-for-byte:

  - counter: two coroutines count round-robin; the scheduler is a
    deterministic rotation, so the full 15-line interleave is fixed.
  - lexer: a coroutine lexer yields tokens for "1+2" to the main
    coroutine; 4 fixed output lines.

Override the badc binary via the ``BADC`` env var (default:
``target/release/badc``).
"""

from __future__ import annotations

import os
import platform
import subprocess
import sys
from pathlib import Path

CORO_DIR = Path(__file__).resolve().parent
REPO_ROOT = CORO_DIR.parent.parent
UPSTREAM_SHA = "7d50b7162a58a1d7f136145de0cc9d46fb82a7f8"
SRC = CORO_DIR / ".cache" / f"coroutines-{UPSTREAM_SHA}"

# counter's scheduler rotation: ids 1 (n=5) and 2 (n=10) alternate
# until 1 dies, then 2 runs out alone.
COUNTER_EXPECTED = (
    "".join(f"[1] {k}\n[2] {k}\n" for k in range(5))
    + "".join(f"[2] {k}\n" for k in range(5, 10))
)
LEXER_INPUT = "1+2"
LEXER_EXPECTED = "TK_INT: 1\nTK_OP:  +\nTK_INT: 2\nDone!\n"


def badc_path() -> str:
    env = os.environ.get("BADC")
    if env:
        return env
    p = REPO_ROOT / "target" / "release" / "badc"
    if not p.is_file():
        sys.exit(f"smoke: badc not built at {p} -- run `cargo build --release --features full`")
    return str(p)


def run(cmd, **kw):
    return subprocess.run(cmd, capture_output=True, text=True, timeout=120, **kw)


def check_output(label: str, exe: Path, args: list[str], expected: str) -> bool:
    r = run([str(exe), *args])
    if r.returncode != 0:
        print(f"smoke FAIL [{label}] {exe.name}: exit {r.returncode}\n{r.stderr[-800:]}", file=sys.stderr)
        return False
    if r.stdout != expected:
        print(
            f"smoke FAIL [{label}] {exe.name}: output mismatch\n"
            f"--- expected ---\n{expected}--- got ---\n{r.stdout}",
            file=sys.stderr,
        )
        return False
    print(f"smoke OK [{label}] coroutines {exe.name}: exact output")
    return True


def main() -> int:
    if os.name != "posix" or sys.platform.startswith("win"):
        print("coroutines smoke skipped (POSIX-only library)")
        return 0

    badc = badc_path()
    r = subprocess.run([sys.executable, str(CORO_DIR / "setup.py")])
    if r.returncode != 0:
        sys.exit("smoke: setup.py failed")

    out = CORO_DIR / ".cache" / "build"
    out.mkdir(parents=True, exist_ok=True)

    native = sys.platform == "linux" and platform.machine() == "x86_64"
    ok = True
    for optimize in (False, True):
        label = "-O" if optimize else "-O0"
        opt = ["-O", "-UNDEBUG"] if optimize else []
        flags = [*opt, "--target=linux-x64", "-I", str(SRC)]

        libobj = out / f"coroutine{'O' if optimize else ''}.o"
        r = run([badc, *flags, "-c", str(SRC / "coroutine.c"), "-o", str(libobj)])
        if r.returncode != 0:
            print(f"smoke FAIL [{label}]: coroutine.c\n{r.stderr[-2000:]}", file=sys.stderr)
            ok = False
            continue
        for ex in ("counter", "lexer"):
            exe = out / f"{ex}{'O' if optimize else ''}"
            r = run([badc, *flags, str(SRC / "examples" / f"{ex}.c"), str(libobj), "-o", str(exe)])
            if r.returncode != 0:
                print(f"smoke FAIL [{label}] {ex}: build\n{r.stderr[-2000:]}", file=sys.stderr)
                ok = False
                continue
            if not native:
                print(f"smoke OK [{label}] coroutines {ex}: linux-x64 build (run needs linux-x86_64 host)")
                continue
            if ex == "counter":
                ok &= check_output(label, exe, [], COUNTER_EXPECTED)
            else:
                ok &= check_output(label, exe, [LEXER_INPUT], LEXER_EXPECTED)

    if not ok:
        return 1
    print("coroutines smoke OK" + ("" if native else " (build-only host)"))
    return 0


if __name__ == "__main__":
    sys.exit(main())
