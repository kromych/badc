#!/usr/bin/env python3
"""Build-only smoke for the chibicc bringup.

chibicc is the substantial multi-TU exerciser for badc's cross-TU
linker. This harness walks each upstream `.c` file in isolation,
running ``badc -c`` on it and recording compile state, then runs
the multi-TU link to produce a working chibicc binary.

Exit codes:
  0  -- every TU compiled AND the multi-TU link succeeded
  1  -- a TU that previously compiled now regresses, OR the
        link failed

The matching parity check (``self_host.py``) compares the badc-
built chibicc against a gcc-built reference on a curated sample
suite, asserting byte-identical assembly and matching exit
codes. Linux x86_64 only.

Override the badc binary via ``BADC`` (default:
``target/release/badc[.exe]`` next to the repo root).
"""

from __future__ import annotations

import os
import subprocess
import sys
from pathlib import Path

CHIBICC_DIR = Path(__file__).resolve().parent
REPO_ROOT = CHIBICC_DIR.parent.parent

WIN = sys.platform == "win32"

# Per-TU bringup state. ``compiles=True`` means the TU is
# expected to round-trip through ``badc -c`` today. When that
# expectation regresses (a green TU starts failing), this
# script returns 1. When an expected-blocker TU still fails,
# the harness reports it without failing (return 2).
TU_STATE = {
    "hashmap.c": True,
    "codegen.c": True,
    "tokenize.c": True,
    "strings.c": True,
    "preprocess.c": True,
    "main.c": True,
    "unicode.c": True,
    "type.c": True,
    "parse.c": True,
}


def resolve_badc() -> Path:
    env = os.environ.get("BADC")
    candidates: list[Path] = []
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


def compile_one(badc: Path, src: Path, out: Path) -> tuple[bool, str]:
    """Run badc -c against `src`. Returns (ok, captured_stderr_head)."""
    proc = subprocess.run(
        [
            str(badc),
            "-O",
            "-I",
            str(CHIBICC_DIR),
            "-c",
            str(src),
            "-o",
            str(out),
        ],
        capture_output=True,
        text=True,
        check=False,
    )
    if proc.returncode == 0:
        return True, ""
    # Capture only the first stderr line -- enough to identify
    # the blocker without flooding the smoke report.
    err = proc.stderr.strip().splitlines()
    return False, err[0] if err else f"exit {proc.returncode}"


def main() -> int:
    # chibicc's body is POSIX-shaped: it calls `fork`/`execvp`/
    # `waitpid`, walks paths via `glob`/`dirname`, allocates with
    # `strndup` / `open_memstream`, and parses long-double via
    # `strtold`. None of those surface through msvcrt without a
    # substantial emulation layer, so the bringup currently
    # targets macOS / Linux only. Skip cleanly on Windows so the
    # CI lane reports the smoke as "not applicable here" rather
    # than as a hard regression.
    if WIN:
        print("smoke: skip -- chibicc bringup targets POSIX hosts (macOS / Linux)")
        return 2

    badc = resolve_badc()

    # Pull the source down if it isn't already on disk. We
    # check for a marker file (chibicc.h) rather than always
    # re-running setup so the smoke is fast on warm checkouts.
    if not (CHIBICC_DIR / "chibicc.h").is_file():
        subprocess.run(
            [sys.executable, str(CHIBICC_DIR / "setup.py")],
            check=True,
        )

    work = CHIBICC_DIR / ".work"
    work.mkdir(exist_ok=True)

    regressions: list[str] = []
    still_blocked: list[tuple[str, str]] = []
    newly_green: list[str] = []
    green: list[str] = []

    for name, expected_green in TU_STATE.items():
        src = CHIBICC_DIR / name
        if not src.is_file():
            print(f"smoke: source missing: {name}", file=sys.stderr)
            return 2
        out = work / (name + ".o")
        ok, err = compile_one(badc, src, out)
        if ok:
            green.append(name)
            if not expected_green:
                newly_green.append(name)
        else:
            if expected_green:
                regressions.append(f"{name}: {err}")
            else:
                still_blocked.append((name, err))

    # Report.
    print(f"chibicc smoke -- {len(green)}/{len(TU_STATE)} TUs compile")
    for name in green:
        print(f"  ok        {name}")
    for name, err in still_blocked:
        print(f"  blocked   {name}: {err}")
    for name in newly_green:
        print(f"  NEW-GREEN {name} -- update TU_STATE[\"{name}\"] = True")
    for line in regressions:
        print(f"  REGRESS   {line}", file=sys.stderr)

    if regressions:
        return 1

    if len(green) == len(TU_STATE):
        # Every TU compiled -- try the multi-TU link too.
        src_files = [str(CHIBICC_DIR / name) for name in TU_STATE]
        out_path = work / ("chibicc.exe" if WIN else "chibicc")
        proc = subprocess.run(
            [str(badc), "-O", "-I", str(CHIBICC_DIR), "-o", str(out_path), *src_files],
            capture_output=True,
            text=True,
            check=False,
        )
        if proc.returncode != 0:
            print("  link FAIL:", proc.stderr.strip().splitlines()[:5], file=sys.stderr)
            return 1
        print(f"  link OK   -> {out_path}")
        return 0

    # An expected-green TU has gone red. The block above already
    # surfaced the regression details via `regressions`; reaching
    # here means a previously-blocked TU is still blocked, which
    # is the final guard before the link step.
    return 1


if __name__ == "__main__":
    sys.exit(main())
