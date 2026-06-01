#!/usr/bin/env python3
"""End-to-end smoke for badc against the scc execute test suite.

scc -- the Simple C Compiler by k0ga -- ships a numbered
``tests/cc/execute/`` corpus of small standalone C programs that
each exit 0 on success. badc compiles every one through
``-q -O0`` and ``-q -O``, runs the resulting binary, and tallies
the pass rate. The corpus exercises C99 corners that the
hand-rolled badc fixtures don't (bitfield-layout edge cases,
designated initialisers, anonymous unions, compound literals,
const-folding shapes), so the demo is the closest thing badc has
to an external conformance suite.

Pass criterion is a stable pass / fail count that does not
regress. The expected baseline is recorded in ``BASELINE`` below;
``smoke FAIL`` when the actual pass count drops, and ``smoke OK``
when it stays at or above. A pass-count increase is welcome -- it
means a newly-supported C99 corner just lit up. Update
``BASELINE`` in the same commit when that happens.

Override the badc binary via ``BADC`` (default:
``target/release/badc[.exe]`` next to the repo root).
"""

from __future__ import annotations

import os
import subprocess
import sys
import tempfile
from pathlib import Path

SCC_DIR = Path(__file__).resolve().parent
REPO_ROOT = SCC_DIR.parent.parent
WIN = sys.platform == "win32"
EXE_SUFFIX = ".exe" if WIN else ""

# scc's `tests/cc/execute/` -- numbered `.c` programs that each
# exit 0 on success and a non-zero status on a parse / codegen /
# runtime regression. Most are tiny (one function, < 20 lines)
# but the corpus collectively exercises C99 corners outside the
# hand-rolled badc fixture suite.
EXECUTE_SUBDIR = Path("tests") / "cc" / "execute"

# Lower bound on the pass count. Today's badc compiles + runs 227
# of the 275 execute tests at both `-q -O0` and `-q -O` on macOS
# aarch64; the Linux x86_64 lane historically drops one extra
# test at -O (the parameter-shadow `0120-funpar.c` shape) which
# is tracked separately. Set the gate at the cross-platform
# minimum so a lane-specific regression doesn't gate the others;
# raise it as each remaining C99 gap closes.
BASELINE = 234


def resolve_badc() -> Path:
    """Locate the badc binary, honouring ``$BADC`` then falling
    back to ``target/release/badc[.exe]``."""
    env = os.environ.get("BADC")
    candidates = []
    if env:
        candidates.append(Path(env))
    default = REPO_ROOT / "target" / "release" / "badc"
    candidates.extend([default, default.with_suffix(".exe")])
    for cand in candidates:
        if cand.is_file() and os.access(cand, os.X_OK):
            return cand
    print(
        f"smoke: BADC binary not found / not executable\n"
        f"       hint: cargo build --release --manifest-path={REPO_ROOT}/Cargo.toml",
        file=sys.stderr,
    )
    sys.exit(2)


def run_one(badc: Path, src: Path, out_dir: Path, optimize: bool) -> tuple[bool, str]:
    """Compile + run one execute test. Returns (passed, tail) where
    ``tail`` is empty on success and the last few error lines on
    failure (useful for triage in the smoke output)."""
    bin_path = out_dir / (src.stem + EXE_SUFFIX)
    cmd: list[str | os.PathLike[str]] = [str(badc), "-q"]
    if optimize:
        cmd.append("-O")
    # scc's harness passes the suite root and the two named
    # subdirs on the compile command line. Mirror that here so the
    # tests can reach their dependencies:
    #   * suite_root         -- `0062-include.c` has
    #                           `#include "include/0062-include.h"`
    #                           which resolves under the suite root.
    #   * suite_root/include -- `0062-include.h` itself has a
    #                           bare `#include "0062-include2.h"`.
    #   * suite_root/sysinclude -- `0064-sysinclude.c` has
    #                           `#include <0064-sysinclude.h>`.
    suite_root = src.parent
    cmd += [
        "-I",
        str(suite_root),
        "-I",
        str(suite_root / "include"),
        "-I",
        str(suite_root / "sysinclude"),
    ]
    cmd += ["-o", str(bin_path), str(src)]
    build = subprocess.run(cmd, capture_output=True, text=True)
    if build.returncode != 0:
        tail = (build.stderr or build.stdout).strip().splitlines()
        return False, "\n".join(tail[-3:])
    run = subprocess.run([str(bin_path)], capture_output=True, text=True)
    if run.returncode != 0:
        tail = (run.stdout + run.stderr).strip().splitlines()
        return False, f"exit={run.returncode}\n" + "\n".join(tail[-3:])
    return True, ""


def run_suite(badc: Path, optimize: bool, label: str) -> tuple[int, int]:
    """Compile + run every execute test, return ``(passed, total)``."""
    suite = sorted((SCC_DIR / "src" / EXECUTE_SUBDIR).glob("*.c"))
    total = len(suite)
    passed = 0
    with tempfile.TemporaryDirectory(prefix=f"scc-smoke-{label}-") as work_str:
        work = Path(work_str)
        for src in suite:
            ok, _ = run_one(badc, src, work, optimize)
            if ok:
                passed += 1
    return passed, total


def main() -> int:
    badc = resolve_badc()

    # `setup.py` is idempotent; re-run it so a fresh CI checkout
    # has the source tree before the suite walks.
    subprocess.run(
        [sys.executable, str(SCC_DIR / "setup.py")],
        check=True,
    )

    ok = True
    for label, optimize in (("no-O", False), ("-O", True)):
        passed, total = run_suite(badc, optimize, label)
        if passed < BASELINE:
            print(
                f"smoke FAIL [{label}]: {passed} / {total} green "
                f"(baseline {BASELINE}, dropped {BASELINE - passed})",
                file=sys.stderr,
            )
            ok = False
        else:
            extra = passed - BASELINE
            extra_note = f" (+{extra} over baseline)" if extra > 0 else ""
            print(f"smoke OK [{label}]: {passed} / {total} green{extra_note}")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
