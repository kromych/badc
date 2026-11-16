#!/usr/bin/env python3
"""Build CPython from the same recipe with badc and the platform reference
compiler (clang on POSIX, cl on Windows), at -O and without (every -O leg
defines NDEBUG, as configure's OPT does), and report
per-binary section sizes plus a runtime microbenchmark.

Every leg is built before any is timed, and the timed runs interleave the
legs, rotating their order each round, so drift of a shared machine over the
minutes the builds take falls on every leg alike rather than on the ratio.

The recipe -- the per-TU source list, defines, and includes -- comes from
``build.py`` and is held constant across compilers, so the compiler is the only
variable: section sizes measure output slimness and the microbenchmark measures
codegen quality. badc's own compile wall-clock is reported alongside.

    python3 demos/python/compare_compilers.py [--target=<t>] [--cc=badc,clang]

Output is GitHub-Flavored-Markdown on stdout.
"""

from __future__ import annotations

import argparse
import os
import shutil
import statistics
import subprocess
import sys
import time
from concurrent.futures import ProcessPoolExecutor
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import build  # noqa: E402  (build.py in the same directory)

PY_DIR = build.PY_DIR
SRC = build.SRC
WIN = sys.platform == "win32"

# A CPU-bound pure-Python workload: recursion, integer and float arithmetic,
# list/dict churn, and string building. Its wall-clock reflects the speed of
# the interpreter, hence the codegen of the compiler that built it.
BENCH = r"""
import time
def fib(n):
    return n if n < 2 else fib(n-1) + fib(n-2)
def work():
    s = 0
    d = {}
    for i in range(40000):
        d[i % 997] = d.get(i % 997, 0) + i
        s += (i * i) % 1000
    parts = []
    for i in range(20000):
        parts.append(str(i))
    return s + len("".join(parts)) + sum(d.values())
import sys
t = time.perf_counter()
for _ in range(int(sys.argv[1])):
    fib(28); work()
print("%.3f" % ((time.perf_counter() - t) * 1000.0))
"""
# Workload repetitions in one timed run, and timed runs per leg. One
# repetition takes 25-55 ms under clang -O on the CI runners.
REPEAT = 4
RUNS = 9


def _compile_job(job):
    cmd, cwd, obj = job
    r = subprocess.run(cmd, cwd=cwd, capture_output=True, text=True,
                       errors="replace", timeout=300)
    if r.returncode != 0:
        tail = ((r.stderr or r.stdout).strip().splitlines() or ["rc%d" % r.returncode])[-1]
        return (obj, tail[:200])
    return (obj, None)


def _compile_cmd(cc_kind, cc, target, src, defs, incs, obj, opt, reenable):
    """Translate the recipe's (defines, includes) into a per-compiler command.
    `reenable` are HAVE_* macros that build.py undefines for badc (headers badc
    lacks); the reference compiler has those headers, so re-enable them to give
    it its natural build of the same module set."""
    if cc_kind == "badc":
        o = ["-O", "-DNDEBUG"] if opt else []
        return [cc, "--gnu", "-c", f"--target={target}",
                '-DCOMPILER="[badc]"', *o, *defs, *incs, src, "-o", obj]
    if cc_kind == "clang":
        o = ["-O2", "-DNDEBUG"] if opt else ["-O0"]
        redef = [f"-D{m}=1" for m in reenable]
        return [cc, "-c", '-DCOMPILER="[clang]"', "-w",
                *o, *redef, *defs, *incs, src, "-o", obj]
    raise SystemExit(f"compare: unsupported compiler {cc_kind}")


def _link_cmd(cc_kind, cc, target, objs, py, opt):
    if cc_kind == "badc":
        return [cc, f"--target={target}", *build.EXPORT_FLAGS, *objs, "-o", str(py)]
    if cc_kind == "clang":
        o = ["-O2"] if opt else []
        libs = ["-lm", "-ldl", "-lpthread", "-lutil"]
        if sys.platform == "darwin":
            libs = ["-framework", "CoreFoundation", "-framework", "SystemConfiguration"]
        return [cc, "-rdynamic", *o, *objs, "-o", str(py), *libs]
    raise SystemExit(f"compare: unsupported compiler {cc_kind}")


def _time_once(py: Path, env: dict):
    """One timed run of the workload, in milliseconds, or None on failure."""
    r = subprocess.run([str(py), "-c", BENCH, str(REPEAT)], env=env, capture_output=True,
                       text=True, timeout=600)
    if r.returncode != 0:
        return None
    try:
        return float(r.stdout.strip().splitlines()[-1])
    except (ValueError, IndexError):
        return None


def _bench_interleaved(legs: list, env: dict) -> dict:
    """Per leg tag, its timed runs: RUNS rounds over every leg, each round
    starting one leg further on. A leg that fails a run is dropped."""
    times = {tag: [] for tag, _ in legs}
    live = list(legs)
    for r in range(RUNS):
        k = r % len(live) if live else 0
        for tag, py in live[k:] + live[:k]:
            ms = _time_once(py, env)
            if ms is None:
                times[tag] = None
            elif times[tag] is not None:
                times[tag].append(ms)
        live = [(tag, py) for tag, py in live if times[tag] is not None]
    return times


def build_with(cc_kind: str, cc: str, target: str, entries, opt: bool, out: Path, log):
    out.mkdir(parents=True, exist_ok=True)
    # Re-enable only HAVE_* header-presence macros badc undefines for lack of a
    # header; capability macros like _Py_HACL_CAN_COMPILE_VEC* gate SIMD TUs
    # excluded from this module set, so they stay undefined for both compilers.
    reenable = [m for m in build.TARGETS[target].get("undef_haves", []) if m.startswith("HAVE_")]
    jobs = []
    for src, defs, incs in entries:
        obj = str(out / (src.replace("/", "_")[:-2] + ".o"))
        jobs.append((_compile_cmd(cc_kind, cc, target, src, defs, incs, obj, opt, reenable),
                     str(SRC), obj))
    workers = int(os.environ.get("BADC_PY_JOBS") or (os.cpu_count() or 4))
    t0 = time.perf_counter()
    objs, fails = [], []
    with ProcessPoolExecutor(max_workers=workers) as ex:
        for obj, err in ex.map(_compile_job, jobs):
            (fails if err else objs).append((obj, err) if err else obj)
    compile_s = time.perf_counter() - t0
    if fails:
        log(f"  {cc_kind} {'O2' if opt else 'O0'}: {len(fails)} TU(s) failed to compile")
        for obj, err in fails[:5]:
            log(f"    {Path(obj).name}: {err}")
        return None
    tobj, terr = build.compile_trampoline_obj(target, cc_kind, cc, out)
    if terr:
        log(f"  {cc_kind} {'O2' if opt else 'O0'}: trampoline compile failed: {terr[-200:]}")
        return None
    if tobj:
        objs.append(tobj)
    py = out / ("python.exe" if WIN else "python")
    lr = subprocess.run(_link_cmd(cc_kind, cc, target, objs, py, opt),
                        capture_output=True, text=True, timeout=900)
    if lr.returncode != 0:
        log(f"  {cc_kind} {'O2' if opt else 'O0'}: link failed: {(lr.stderr or lr.stdout)[-300:]}")
        return None
    return {"py": py, "compile_s": compile_s}


def main(argv=None) -> int:
    p = argparse.ArgumentParser(description=__doc__,
                                formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("--target", default=os.environ.get("BADC_PY_TARGET") or build._host_target())
    p.add_argument("--cc", default="badc,clang", help="comma-separated: badc,clang,cl")
    args = p.parse_args(argv)

    def log(m): print(m, file=sys.stderr)

    if args.target not in build.TARGETS:
        sys.exit(f"compare: unknown target {args.target}")
    build.ensure_inputs(args.target, log)
    entries = build._entries(args.target)

    resolve = {"badc": build.badc_path,
               "clang": lambda: shutil.which("clang"),
               "cl": lambda: shutil.which("cl")}
    rows = []
    env = dict(os.environ, PYTHONHOME=str(SRC), PYTHONPATH=str(SRC / "Lib"))
    for kind in [c.strip() for c in args.cc.split(",") if c.strip()]:
        cc = resolve.get(kind, lambda: None)()
        if not cc:
            log(f"compare: {kind} not found, skipping"); continue
        for opt in (False, True):
            tag = f"{kind} {'-O' if opt else 'no-O'}"
            log(f"building {tag} ...")
            out = PY_DIR / ".cache" / f"cmp-{args.target}-{kind}-{'O2' if opt else 'O0'}"
            res = build_with(kind, cc, args.target, entries, opt, out, log)
            if not res:
                rows.append((tag, None, None, None)); continue
            # Each leg's interpreter sits beside the library it runs, under a
            # name of its own, so every leg can be timed after the last build.
            py = SRC / f"{res['py'].stem}-{kind}-{'O2' if opt else 'O0'}{res['py'].suffix}"
            shutil.copy2(res["py"], py)
            sizes = build.section_sizes(res["py"])
            rows.append((tag, res["compile_s"], sizes, py))
            log(f"  {tag}: compile {res['compile_s']:.1f}s  text {sizes['text']//1024}K")

    legs = [(tag, py) for tag, _, sz, py in rows if sz is not None]
    log(f"timing {len(legs)} legs, {RUNS} interleaved rounds of {REPEAT} repetitions ...")
    times = _bench_interleaved(legs, env)
    medians = {tag: (statistics.median(t) if t else None) for tag, t in times.items()}

    print(f"## CPython build comparison ({args.target})\n")
    print("| compiler | compile (s) | .text (KiB) | .data (KiB) | .bss (KiB) | file (KiB) | bench (ms) |")
    print("|---|--:|--:|--:|--:|--:|--:|")
    for tag, cs, sz, _ in rows:
        if sz is None:
            print(f"| {tag} | FAIL | | | | | |"); continue
        k = lambda b: b // 1024
        ms = medians.get(tag)
        print(f"| {tag} | {cs:.1f} | {k(sz['text'])} | {k(sz['data'])} | {k(sz['bss'])} | "
              f"{k(sz['file'])} | {f'{ms:.3f}' if ms else 'FAIL'} |")
    print(f"\n### Timed runs: {RUNS} interleaved rounds of {REPEAT} repetitions\n")
    print("| compiler | median (ms) | min (ms) | max (ms) | spread |")
    print("|---|--:|--:|--:|--:|")
    for tag, t in times.items():
        if not t:
            print(f"| {tag} | FAIL | | | |"); continue
        med = statistics.median(t)
        print(f"| {tag} | {med:.3f} | {min(t):.3f} | {max(t):.3f} | "
              f"{(max(t) - min(t)) / med:.1%} |")
    for opt in ("no-O", "-O"):
        b, c = medians.get(f"badc {opt}"), medians.get(f"clang {opt}")
        if b and c:
            print(f"\nbadc {opt} / clang {opt}: {b / c:.3f}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
