#!/usr/bin/env python3
"""Compile-throughput counters over a fixed corpus of translation units.

Absolute compile seconds are not comparable between runs: the hosted
runner class changes underneath them, and the reference compiler on the
same corpus has moved by a factor of six across a fortnight of CI. What
is comparable is a ratio taken *within one run on one machine*, where
the machine cancels. This reports two, both over the whole corpus:

  * `-O0 / -O` -- the cost of the unoptimised build over the optimised
    one. `-O` runs the optimisation passes on top of the same front end,
    so it costs more; a build that is cheaper with them is paying for
    the volume of unoptimised code somewhere in the back end.
  * `slowest / next` -- the slowest unit's cost over the next slowest
    one's at `-O0`. A pass whose cost is super-linear in the size of one
    function moves this and leaves the aggregate nearly where it was:
    the regression this counter was written for multiplied a single unit
    by 7.4x while the corpus mean moved 2.2x. Both terms are large units
    doing real back-end work, so the per-invocation front-end floor --
    which is a property of the host, not of the compiler -- cancels out
    of them rather than setting the scale as it would against a median.

`--check` fails when either is over its committed ceiling.

The corpus defaults to the eight QuickJS units `demos/quickjs/smoke.py`
builds, on the defines it uses. They are gitignored -- `demos/quickjs/
setup.py` fetches them -- so the check belongs in a job that has already
run that fetch. `quickjs.c` carries the computed-goto interpreter
dispatch loop, which is the shape that separates a per-function
super-linear cost from ordinary front-end cost; a corpus without one
holds no signal for the tail counter.
"""

from __future__ import annotations

import argparse
import subprocess
import sys
import time
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
QJS = REPO_ROOT / "demos" / "quickjs"

# The units and defines `demos/quickjs/smoke.py` builds, plus the two
# drivers that link against them.
CORPUS = [
    QJS / n
    for n in (
        "quickjs.c",
        "quickjs-libc.c",
        "cutils.c",
        "libregexp.c",
        "libunicode.c",
        "dtoa.c",
        "qjs.c",
        "qjsc.c",
    )
]
DEFINES = ("_GNU_SOURCE", 'CONFIG_VERSION="0"', "CONFIG_ALL_UNICODE")

# Ceilings over the corpus above. Both counters are ratios over units
# measured in the same run, so one set covers every host.
#
# The margin comes from the distribution, sampled over the commit window
# that carried the regression this was written for and on three hosts:
# macos-aarch64, linux-x64, linux-aarch64. `-O0/-O` reads 0.24 to 0.35
# healthy and 0.62 to 0.70 broken; `slowest / next` reads 7.2 to 12.1
# healthy and 49.8 to 69.3 broken. The step is one commit: a frame-slot
# pass that solved two reachability relations with a worklist re-visiting
# a block once per bit that arrived rather than once per component took
# its parent's 0.35 / 7.3 to 0.70 / 49.9 on one host.
#
# The ceilings sit between the two bands. 0.45 clears the worst healthy
# point by 29% and stops 27% short of the lowest broken one; 25.0 clears
# 12.1 by 107% and stops 50% short of 49.8.
#
# Contending load biases `-O0/-O` towards its ceiling, so a loaded
# runner is stricter than an idle one rather than looser: measured
# against twenty spinners on a twenty-core host it rises from 0.28 to
# 0.34.
#
# A ceiling moves only deliberately: measure, read the report, and
# change the number in the commit that spends it.
CEILINGS = {"o0_over_o": 0.45, "slowest_over_next": 25.0}


def compile_once(badc: Path, src: Path, opt: bool, out: Path) -> float:
    cmd = [
        str(badc),
        "--gnu",
        "-c",
        "-I",
        str(QJS),
        *(f"-D{d}" for d in DEFINES),
        *(["-O"] if opt else []),
        str(src),
        "-o",
        str(out),
    ]
    start = time.perf_counter()
    r = subprocess.run(cmd, capture_output=True, text=True, errors="replace")
    elapsed = time.perf_counter() - start
    if r.returncode != 0:
        tail = (r.stderr or r.stdout).strip().splitlines()[-3:]
        raise SystemExit(f"[throughput] {src.name} failed:\n" + "\n".join(tail))
    return elapsed


def measure(badc: Path, corpus: list[Path], reps: int, out: Path):
    """Minimum of `reps` runs per unit at each level. The minimum, not
    the mean: a run can only be delayed by whatever else the machine is
    doing, so the smallest sample is the one least contaminated by it.
    The two levels are measured back to back on each unit rather than in
    two passes, so a transient load lands on both and cancels out of
    their ratio instead of moving whichever pass it overlapped."""
    best: tuple[dict[str, float], dict[str, float]] = ({}, {})
    for _ in range(reps):
        for src in corpus:
            for i, opt in enumerate((False, True)):
                t = compile_once(badc, src, opt, out)
                best[i][src.name] = min(best[i].get(src.name, t), t)
    return best


def report(o0: dict[str, float], o1: dict[str, float], check: bool) -> int:
    total0, total1 = sum(o0.values()), sum(o1.values())
    order = sorted(o0.items(), key=lambda kv: -kv[1])
    slowest, runner_up = order[0], order[1]
    ratio = total0 / total1 if total1 else float("inf")
    tail = slowest[1] / runner_up[1] if runner_up[1] else float("inf")
    print("| unit | -O0 (ms) | -O (ms) |\n|---|--:|--:|")
    for name in sorted(o0, key=lambda n: -o0[n]):
        print(f"| {name} | {o0[name] * 1000:.1f} | {o1[name] * 1000:.1f} |")
    print(
        f"\n[throughput] {len(o0)} units, -O0 {total0:.3f}s, -O {total1:.3f}s, "
        f"-O0/-O {ratio:.2f}, slowest/next {tail:.1f} "
        f"({slowest[0]} over {runner_up[0]})"
    )
    if not check:
        return 0
    rc = 0
    if ratio > CEILINGS["o0_over_o"]:
        print(
            f"[throughput] -O0/-O {ratio:.2f} is over the "
            f"{CEILINGS['o0_over_o']:.2f} ceiling. The optimised build runs "
            f"strictly more passes over the same front end, so it has to "
            f"cost more; find the back-end cost that scales with the volume "
            f"of unoptimised code, or raise the ceiling here with the reason."
        )
        rc = 1
    if tail > CEILINGS["slowest_over_next"]:
        print(
            f"[throughput] slowest/next {tail:.1f} is over the "
            f"{CEILINGS['slowest_over_next']:.1f} ceiling. One unit costs far "
            f"more than the next largest; look for a pass whose cost is "
            f"super-linear in the size of a single function."
        )
        rc = 1
    return rc


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument(
        "--badc",
        default=str(REPO_ROOT / "target" / "release" / "badc"),
        help="compiler under test",
    )
    ap.add_argument(
        "--files",
        nargs="+",
        metavar="SRC",
        help="corpus to measure instead of the QuickJS units; the counters "
        "are ratios over the population, so it has to reach the script in "
        "one run",
    )
    ap.add_argument(
        "--reps", type=int, default=3, help="runs per unit; the minimum counts"
    )
    ap.add_argument(
        "--check",
        action="store_true",
        help="fail when a counter is over its committed ceiling",
    )
    args = ap.parse_args()

    badc = Path(args.badc)
    if not badc.is_file():
        raise SystemExit(f"[throughput] no compiler at {badc}")
    corpus = [Path(f) for f in args.files] if args.files else CORPUS
    missing = [str(p) for p in corpus if not p.is_file()]
    if missing:
        raise SystemExit(
            "[throughput] missing corpus sources: "
            + ", ".join(missing)
            + "\nrun `python3 demos/quickjs/setup.py` first"
        )
    if len(corpus) < 3:
        raise SystemExit("[throughput] the counters need at least three units")

    import tempfile

    with tempfile.TemporaryDirectory() as tmp:
        out = Path(tmp) / "unit.o"
        o0, o1 = measure(badc, corpus, args.reps, out)
    return report(o0, o1, args.check)


if __name__ == "__main__":
    sys.exit(main())
