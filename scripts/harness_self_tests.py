#!/usr/bin/env python3
"""Run the self-checks of the demo and script harnesses: pure functions
(command lines, case plans, log parsers) each harness verifies without a
box, an emulator or a build. CI's `fmt + clippy` job runs this, and so do
the local gate's Linux lanes, so a harness whose own check broke is caught
before a push.

    python3 scripts/harness_self_tests.py

Every check runs; the exit status is 1 when any failed.
"""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]

CHECKS = [
    ["demos/linux/kaslr.py"],
    ["demos/linux/initramfs.py", "--self-test"],
    ["demos/linux/verify.py", "--self-test"],
    ["demos/linux/packages.py", "--self-test"],
    ["demos/linux/layout.py", "--self-test"],
    ["demos/linux/exercise.py", "--self-test"],
    ["demos/linux/hwprep.py", "--self-test"],
    ["demos/edk2/qemu_efi.py", "--self-test"],
    ["demos/kernel/smoke.py", "--self-test"],
    ["scripts/snapshots.py", "--self-test"],
    ["scripts/validate_local_boxes.py", "--self-test"],
    ["scripts/cargo_test.py", "--self-test"],
    ["tests/perf/run.py", "--self-test"],
    ["scripts/perf_publish.py", "--self-test"],
    ["scripts/perf_backfill.py", "--self-test"],
    ["scripts/csmith_fuzz.py", "--self-test"],
    ["scripts/c_reduce.py", "--self-test"],
]


def main() -> int:
    failed = []
    for check in CHECKS:
        rc = subprocess.run([sys.executable, *check], cwd=REPO_ROOT).returncode
        if rc != 0:
            failed.append(f"{' '.join(check)} (rc={rc})")
    for f in failed:
        print(f"harness self-test failed: {f}", file=sys.stderr)
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
