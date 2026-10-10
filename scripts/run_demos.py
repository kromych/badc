#!/usr/bin/env python3
"""Run demo smokes concurrently and report one line per demo.

The lane step of `scripts/validate_local_boxes.py` invokes this with the
lane's roster on the command line; the roster lives there. Each smoke is
an independent process fetching into its own `demos/<name>/.cache`, so
they run in a pool. `--jobs` bounds the pool width only -- every demo on
the command line runs, and the closing lines print the roster and the
width.

An entry `path@config` runs the smoke under that configuration's
environment in `DEMO_ENV`. The configurations of one smoke share its
cache, so they run one after another in one pool slot, each with its own
verdict.

Exit status is non-zero if any demo failed.
"""

from __future__ import annotations

import argparse
import concurrent.futures
import os
import pathlib
import subprocess
import sys
import threading
import time

REPO_ROOT = pathlib.Path(__file__).resolve().parents[1]

# A failing smoke's own diagnostics precede its final error line, so the
# tail has to be deep enough to carry both.
FAIL_TAIL_LINES = 60


def script(entry: str) -> str:
    return entry.partition("@")[0]


def name(entry: str) -> str:
    """`qemu` for demos/qemu/smoke.py, `qemu@O` for its `O` configuration."""
    path, _, config = entry.partition("@")
    demo = pathlib.PurePosixPath(path).parent.name
    return f"{demo}@{config}" if config else demo


def slots(entries: list[str]) -> list[list[str]]:
    """The roster as pool tasks: one per smoke, holding its entries in
    roster order."""
    by_script: dict[str, list[str]] = {}
    for e in entries:
        by_script.setdefault(script(e), []).append(e)
    return list(by_script.values())


def run_one(entry: str) -> tuple[str, int, float, str]:
    start = time.time()
    proc = subprocess.run(
        [sys.executable, script(entry)],
        cwd=REPO_ROOT,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
        errors="replace",
        env={**os.environ, **DEMO_ENV.get(entry, {})},
    )
    return entry, proc.returncode, time.time() - start, proc.stdout


# The emulator demo at the two levels CI's qemu job builds: -O0, and -O,
# here with the SSA checks after every pass. Each build self-links, starts,
# and boots the published kernel bundle to a shell through the box's UEFI
# firmware, then powers off; the per-boot cap is CI's. Both name every
# knob, so the caller's environment cannot change what an entry builds.
QEMU_BOOT = {
    "BADC_QEMU_REQUIRE_RUN": "1",
    "BADC_QEMU_BOOT": "gate",
    "BADC_QEMU_BOOT_TIMEOUT": "90",
    "BADC_QEMU_REQUIRE_FIRMWARE": "1",
}
DEMO_ENV = {
    "demos/qemu/smoke.py": {**QEMU_BOOT, "BADC_QEMU_OPT": "0", "BADC_QEMU_VERIFY_SSA": "0"},
    "demos/qemu/smoke.py@O": {**QEMU_BOOT, "BADC_QEMU_OPT": "1", "BADC_QEMU_VERIFY_SSA": "1"},
}


def main() -> int:
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--jobs", type=int, default=4, help="concurrent demos")
    p.add_argument("demos", nargs="+", help="paths to smoke.py scripts, or path@config")
    args = p.parse_args()

    unknown = [e for e in args.demos if "@" in e and e not in DEMO_ENV]
    if unknown:
        p.error(f"no configuration in DEMO_ENV for {' '.join(unknown)}")
    tasks = slots(args.demos)
    jobs = max(1, min(args.jobs, len(tasks)))

    failures: list[tuple[str, int, str]] = []
    costs: list[tuple[float, str]] = []
    lock = threading.Lock()

    def run_slot(entries: list[str]) -> None:
        for entry in entries:
            _, rc, secs, out = run_one(entry)
            with lock:
                mark = "ok" if rc == 0 else f"FAILED (rc={rc})"
                print(f"demo {entry}: {mark} in {secs:.0f}s", flush=True)
                costs.append((secs, name(entry)))
                if rc != 0:
                    failures.append((entry, rc, out))

    phase_start = time.time()
    with concurrent.futures.ThreadPoolExecutor(max_workers=jobs) as pool:
        for fut in [pool.submit(run_slot, t) for t in tasks]:
            fut.result()

    for entry, rc, out in failures:
        print(f"--- {entry} FAILED (rc={rc}), last {FAIL_TAIL_LINES} lines:")
        print("\n".join(out.splitlines()[-FAIL_TAIL_LINES:]), flush=True)

    # The last three lines are the whole report a green step shows.
    slowest = ", ".join(f"{n} {s:.0f}s" for s, n in sorted(costs, reverse=True)[:4])
    print(f"demo phase: roster {' '.join(name(e) for e in args.demos)}")
    print(f"demo phase: slowest {slowest}")
    print(
        f"demo phase: {len(args.demos) - len(failures)}/{len(args.demos)} ok in "
        f"{time.time() - phase_start:.0f}s wall, {jobs} at a time",
        flush=True,
    )
    return 1 if failures else 0


if __name__ == "__main__":
    raise SystemExit(main())
