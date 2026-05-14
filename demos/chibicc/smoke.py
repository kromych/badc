#!/usr/bin/env python3
"""Build-only smoke for the chibicc bringup.

chibicc is the substantial multi-TU exerciser for badc's cross-TU
linker. Bringup is in progress (see ``README.md`` for the per-TU
status). This harness walks each upstream `.c` file in isolation,
running ``badc -c`` on it and recording compile / blocker
status, then attempts the full multi-TU link only when every TU
compiled cleanly.

Exit codes:
  0  -- every TU compiled AND the multi-TU link succeeded
  1  -- a TU that previously compiled now regresses
  2  -- expected-blocker TUs are still blocked (informational)

The ``BADC_CHIBICC_STRICT`` env var, when set to a non-empty
value, escalates the informational-blockers exit (2) to a hard
failure (1). Used to gate the CI lane once bringup catches up.

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
    "tokenize.c": False,    # blocker: strncasecmp
    "strings.c": False,     # blocker: open_memstream
    "preprocess.c": False,  # blocker: strndup
    "main.c": False,        # blocker: dirname
    "unicode.c": False,     # blocker: 0b... binary literals
    "type.c": False,        # blocker: compound literals
    "parse.c": False,       # blocker: compound literals
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
            [str(badc), "-I", str(CHIBICC_DIR), "-o", str(out_path), *src_files],
            capture_output=True,
            text=True,
            check=False,
        )
        if proc.returncode != 0:
            print("  link FAIL:", proc.stderr.strip().splitlines()[:5], file=sys.stderr)
            return 1
        print(f"  link OK   -> {out_path}")
        return 0

    strict = bool(os.environ.get("BADC_CHIBICC_STRICT"))
    return 1 if strict else 2


if __name__ == "__main__":
    sys.exit(main())
