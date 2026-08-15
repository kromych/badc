#!/usr/bin/env python3
"""Regenerate `tests/snapshots/` and fail if it differs from the tree.

The same check as CI's `snapshots clean` job, without a git working
copy: the lane's tree is an rsync/tar export with no `.git`, so the
committed copy is compared by taking it aside before the regeneration
and diffing afterwards. The tree is restored either way.

`scripts/snapshots.py` prefers llvm-objdump and its disassembly text
does not match GNU objdump's, so a run without llvm-objdump would
report drift against snapshots that are current. Its absence fails
here rather than downgrading the check.
"""

from __future__ import annotations

import filecmp
import pathlib
import shutil
import subprocess
import sys
import tempfile
import time

REPO_ROOT = pathlib.Path(__file__).resolve().parents[1]
SNAPSHOTS = REPO_ROOT / "tests" / "snapshots"
DIFF_LINES = 200


def report(base: pathlib.Path) -> int:
    """Print the paths that differ and a bounded unified diff."""
    changed: list[tuple[pathlib.Path, pathlib.Path]] = []
    for cur in sorted(SNAPSHOTS.rglob("*")):
        if cur.is_dir():
            continue
        old = base / cur.relative_to(SNAPSHOTS)
        if not old.exists() or not filecmp.cmp(old, cur, shallow=False):
            changed.append((old, cur))
    for old in sorted(base.rglob("*")):
        if old.is_file() and not (SNAPSHOTS / old.relative_to(base)).exists():
            changed.append((old, SNAPSHOTS / old.relative_to(base)))
    print(f"snapshot drift: {len(changed)} file(s) differ from the committed copy")
    for old, cur in changed[:40]:
        print(f"  {cur.relative_to(REPO_ROOT)}")
    printed = 0
    for old, cur in changed:
        if printed >= DIFF_LINES:
            break
        diff = subprocess.run(
            ["diff", "-u", str(old), str(cur)], capture_output=True, text=True
        ).stdout.splitlines()
        for line in diff[: DIFF_LINES - printed]:
            print(line)
        printed += len(diff)
    return 1


def main() -> int:
    if shutil.which("llvm-objdump") is None:
        print(
            "snapshot drift: llvm-objdump not found; the committed snapshots "
            "were disassembled with it and GNU objdump's text does not match. "
            "Install it (Debian/Ubuntu: apt-get install llvm) and rerun."
        )
        return 1
    if not SNAPSHOTS.is_dir():
        print(f"snapshot drift: {SNAPSHOTS} is missing")
        return 1

    start = time.time()
    with tempfile.TemporaryDirectory(prefix="snapshot-base-") as tmp:
        base = pathlib.Path(tmp) / "snapshots"
        shutil.copytree(SNAPSHOTS, base)
        rc = subprocess.call(
            [sys.executable, str(REPO_ROOT / "scripts" / "snapshots.py")],
            cwd=REPO_ROOT,
        )
        if rc != 0:
            print(f"snapshot drift: scripts/snapshots.py failed (rc={rc})")
        elif not _same(base):
            rc = report(base)
        shutil.rmtree(SNAPSHOTS)
        shutil.copytree(base, SNAPSHOTS)
    print(f"snapshot drift: {'clean' if rc == 0 else 'DRIFTED'} in {time.time() - start:.0f}s")
    return rc


def _same(base: pathlib.Path) -> bool:
    old = {p.relative_to(base) for p in base.rglob("*") if p.is_file()}
    new = {p.relative_to(SNAPSHOTS) for p in SNAPSHOTS.rglob("*") if p.is_file()}
    if old != new:
        return False
    return all(filecmp.cmp(base / p, SNAPSHOTS / p, shallow=False) for p in old)


if __name__ == "__main__":
    raise SystemExit(main())
