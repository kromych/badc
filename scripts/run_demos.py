#!/usr/bin/env python3
"""Run demo smokes concurrently and report one line per demo.

The lane step of `scripts/validate_local_boxes.py` invokes this with the
lane's roster on the command line; the roster lives there. Each smoke is
an independent process fetching into its own `demos/<name>/.cache`, so
they run in a pool. `--jobs` bounds the pool width only -- every demo on
the command line runs, and the header prints the roster and the width.

Exit status is non-zero if any demo failed.
"""

from __future__ import annotations

import argparse
import concurrent.futures
import os
import pathlib
import subprocess
import sys
import time

REPO_ROOT = pathlib.Path(__file__).resolve().parents[1]

# A failing smoke's own diagnostics precede its final error line, so the
# tail has to be deep enough to carry both.
FAIL_TAIL_LINES = 60


def run_one(demo: str, env: dict[str, str]) -> tuple[str, int, float, str]:
    start = time.time()
    proc = subprocess.run(
        [sys.executable, demo],
        cwd=REPO_ROOT,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
        errors="replace",
        env={**os.environ, **env},
    )
    return demo, proc.returncode, time.time() - start, proc.stdout


# Compile + self-link the emulator and require the linked binary to start;
# the boot phase consumes the firmware CI's ovmf lane publishes as an
# artifact, which a local lane has no producer for.
DEMO_ENV = {
    "demos/qemu/smoke.py": {"BADC_QEMU_BOOT": "skip", "BADC_QEMU_REQUIRE_RUN": "1"},
}


def main() -> int:
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--jobs", type=int, default=4, help="concurrent demos")
    p.add_argument("demos", nargs="+", help="paths to smoke.py scripts")
    args = p.parse_args()

    jobs = max(1, min(args.jobs, len(args.demos)))
    names = [pathlib.PurePosixPath(d).parent.name for d in args.demos]

    failures: list[tuple[str, int, str]] = []
    costs: list[tuple[float, str]] = []
    phase_start = time.time()
    with concurrent.futures.ThreadPoolExecutor(max_workers=jobs) as pool:
        futures = [pool.submit(run_one, d, DEMO_ENV.get(d, {})) for d in args.demos]
        for fut in concurrent.futures.as_completed(futures):
            demo, rc, secs, out = fut.result()
            mark = "ok" if rc == 0 else f"FAILED (rc={rc})"
            print(f"demo {demo}: {mark} in {secs:.0f}s", flush=True)
            costs.append((secs, pathlib.PurePosixPath(demo).parent.name))
            if rc != 0:
                failures.append((demo, rc, out))

    for demo, rc, out in failures:
        print(f"--- {demo} FAILED (rc={rc}), last {FAIL_TAIL_LINES} lines:")
        print("\n".join(out.splitlines()[-FAIL_TAIL_LINES:]), flush=True)

    # The last three lines are the whole report a green step shows.
    slowest = ", ".join(f"{n} {s:.0f}s" for s, n in sorted(costs, reverse=True)[:4])
    print(f"demo phase: roster {' '.join(names)}")
    print(f"demo phase: slowest {slowest}")
    print(
        f"demo phase: {len(args.demos) - len(failures)}/{len(args.demos)} ok in "
        f"{time.time() - phase_start:.0f}s wall, {jobs} at a time",
        flush=True,
    )
    return 1 if failures else 0


if __name__ == "__main__":
    raise SystemExit(main())
