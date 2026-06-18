#!/usr/bin/env python3
"""Differential micro-benchmark harness for the badc-built CPython.

Runs the dependency-free pure-Python benchmarks under ``benchmarks/`` on
one or more interpreters. The first interpreter is the correctness
oracle; every other interpreter must reproduce its per-benchmark stdout
exactly, so the suite is also a differential correctness check over a
workload far broader than the import-time test slice. Per-benchmark wall
time (minimum of N fresh-process runs) is reported for each interpreter,
with the ratio to the oracle.

The benchmarks use only the standard library, so the oracle defaults to
the version-matched reference interpreter built during the smoke
(``.cache/Python-<ver>/python``) rather than the host ``python3``, whose
version may format floats or pickle data differently and trip parity.

Usage:
    python3 demos/python/bench.py [--python LABEL=PATH ...]
        [--reference PATH] [--reps N] [--scale F] [--only NAME,...] [-v]

With no ``--python`` the candidate defaults to the badc-built interpreter
at ``.cache/obj/python``. Exit status is non-zero if any candidate
diverges from the oracle on any benchmark.
"""

from __future__ import annotations

import argparse
import os
import subprocess
import sys
import time
from pathlib import Path

import smoke  # sibling module: reuse SRC + the interpreter search path

PY_DIR = Path(__file__).resolve().parent
BENCH_DIR = PY_DIR / "benchmarks"


def interp_env() -> dict:
    # The reference and the badc-built interpreter are builds of the same
    # source tree: the standard library is under Lib/ and the C extension
    # modules are under the directory named in pybuilddir.txt.
    return dict(
        os.environ,
        PYTHONHOME=str(smoke.SRC),
        PYTHONPATH=smoke.module_search_path(),
    )


def discover(only):
    names = sorted(p.stem[3:] for p in BENCH_DIR.glob("bm_*.py"))
    if only:
        keep = set(only)
        names = [n for n in names if n in keep]
    return names


def measure(interp, script, scale, reps, env):
    """Return (rc, stdout, stderr, best_time). best_time is the minimum
    wall time over `reps` fresh-process runs; NaN on failure."""
    best = None
    out = err = ""
    for _ in range(reps):
        e = dict(env, BENCH_SCALE=repr(scale))
        t0 = time.perf_counter()
        proc = subprocess.run(
            [interp, str(script)],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            env=e,
        )
        dt = time.perf_counter() - t0
        out = proc.stdout.decode("utf-8", "replace").strip()
        err = proc.stderr.decode("utf-8", "replace").strip()
        if proc.returncode != 0:
            return proc.returncode, out, err, float("nan")
        best = dt if best is None else min(best, dt)
    return 0, out, err, (best if best is not None else float("nan"))


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument(
        "--python",
        action="append",
        default=[],
        help="LABEL=PATH of a candidate interpreter (repeatable)",
    )
    ap.add_argument("--reference", default="", help="oracle interpreter path")
    ap.add_argument("--reps", type=int, default=3)
    ap.add_argument("--scale", type=float, default=1.0)
    ap.add_argument("--only", default="")
    ap.add_argument("-v", "--verbose", action="store_true")
    args = ap.parse_args(argv)

    ref = args.reference or str(smoke.SRC / "python")
    if not Path(ref).is_file():
        sys.exit(
            f"bench: oracle interpreter not found at {ref} -- run "
            f"demos/python/smoke.py first, or pass --reference"
        )
    interps = [("ref", ref)]
    if args.python:
        for spec in args.python:
            label, _, path = spec.partition("=")
            interps.append((label, path or label))
    else:
        cand = PY_DIR / ".cache" / "obj" / "python"
        if cand.is_file():
            interps.append(("badc", str(cand)))
    if len(interps) == 1:
        sys.exit(
            "bench: no candidate interpreter -- build one via smoke.py or "
            "pass --python LABEL=PATH"
        )

    only = [n for n in args.only.split(",") if n]
    names = discover(only)
    if not names:
        sys.exit("bench: no benchmarks found under benchmarks/")

    env = interp_env()
    labels = [lbl for lbl, _ in interps]
    width = max(len(n) for n in names)
    header = f"{'benchmark':<{width}}  " + "  ".join(f"{l:>14}" for l in labels)
    print(header)
    print("-" * len(header))

    diverged = []
    for name in names:
        script = BENCH_DIR / f"bm_{name}.py"
        row = {}
        for lbl, interp in interps:
            row[lbl] = measure(interp, script, args.scale, args.reps, env)
        oracle_out, oracle_t = row["ref"][1], row["ref"][3]

        cells = []
        for lbl, _ in interps:
            rc, out, err, dt = row[lbl]
            if rc != 0:
                cells.append(f"{'ERR':>14}")
            elif lbl == "ref":
                cells.append(f"{dt:>13.3f}s")
            else:
                ratio = dt / oracle_t if oracle_t else float("nan")
                cells.append(f"{dt:>8.3f}s x{ratio:>4.2f}")
        bad = ""
        for lbl, _ in interps:
            if lbl == "ref":
                continue
            rc, out, err, dt = row[lbl]
            if rc != 0:
                bad = f"  {lbl}:rc{rc}"
                tail = err.splitlines()[-1] if err else ""
                diverged.append((name, lbl, f"rc={rc} {tail}"))
            elif out != oracle_out:
                bad = f"  {lbl}:DIFF"
                diverged.append((name, lbl, "output differs from oracle"))
        print(f"{name:<{width}}  " + "  ".join(cells) + bad)
        if args.verbose and bad:
            print(f"    ref  = {oracle_out!r}", file=sys.stderr)
            for lbl, _ in interps:
                if lbl == "ref":
                    continue
                rc, out, err, dt = row[lbl]
                print(f"    {lbl} = {out!r}", file=sys.stderr)
                if rc != 0 and err:
                    print(f"    {lbl} stderr: {err[-400:]}", file=sys.stderr)

    print()
    if diverged:
        print(f"DIVERGENCE: {len(diverged)} benchmark/interpreter pair(s) differ from the oracle:")
        for name, lbl, why in diverged:
            print(f"  {name} [{lbl}]: {why}")
        return 1
    print(f"all {len(names)} benchmarks: output parity OK across {len(interps)} interpreter(s)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
