#!/usr/bin/env python3
"""Build CPython from the same recipe with badc and the platform reference
compiler (clang on POSIX, cl on Windows), at -O and without, and report
per-binary section sizes plus a runtime microbenchmark.

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
t = time.perf_counter()
fib(28); work()
print("%.3f" % ((time.perf_counter() - t) * 1000.0))
"""


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
        o = ["-O"] if opt else []
        return [cc, "--gnu", "-c", f"--target={target}", "-UHAVE_GCC_UINT128_T",
                '-DCOMPILER="[badc]"', *o, *defs, *incs, src, "-o", obj]
    if cc_kind == "clang":
        o = ["-O2"] if opt else ["-O0"]
        redef = [f"-D{m}=1" for m in reenable]
        # Force the same no-__int128 path badc takes, so the bigint code is
        # identical and the comparison isolates the compiler, not the dialect.
        return [cc, "-c", "-UHAVE_GCC_UINT128_T", '-DCOMPILER="[clang]"', "-fPIC", "-w",
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


def _section_sizes(py: Path) -> dict:
    """text / data / bss in bytes via llvm-size --format=sysv (uniform across
    ELF / Mach-O / PE), falling back to the file size."""
    sizer = shutil.which("llvm-size") or _xcrun("llvm-size")
    out = {"text": 0, "data": 0, "bss": 0, "file": py.stat().st_size}
    if not sizer:
        return out
    r = subprocess.run([sizer, "--format=sysv", str(py)], capture_output=True, text=True)
    if r.returncode != 0:
        return out
    for line in r.stdout.splitlines():
        f = line.split()
        if len(f) < 2 or not f[-1].lstrip("-").isdigit():
            continue
        name, val = f[0], int(f[1])
        low = name.lower()
        if low in ("__text", ".text") or low.endswith("text"):
            out["text"] += val
        elif "bss" in low:
            out["bss"] += val
        elif low in ("__data", ".data", ".rodata", "__const") or "data" in low or "const" in low:
            out["data"] += val
    return out


def _xcrun(tool: str):
    if sys.platform != "darwin":
        return None
    r = subprocess.run(["xcrun", "--find", tool], capture_output=True, text=True)
    return r.stdout.strip() or None


def _bench(py: Path, env: dict, runs: int = 5):
    times = []
    for _ in range(runs):
        r = subprocess.run([str(py), "-c", BENCH], env=env, capture_output=True,
                           text=True, timeout=120)
        if r.returncode != 0:
            return None
        try:
            times.append(float(r.stdout.strip().splitlines()[-1]))
        except (ValueError, IndexError):
            return None
    return statistics.median(times)


def build_with(cc_kind: str, cc: str, target: str, entries, opt: bool, out: Path, log):
    out.mkdir(parents=True, exist_ok=True)
    reenable = build.TARGETS[target].get("undef_haves", [])
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
            shutil.copy2(res["py"], SRC / res["py"].name)
            sizes = _section_sizes(res["py"])
            ms = _bench(SRC / res["py"].name, env)
            rows.append((tag, res["compile_s"], sizes, ms))
            log(f"  {tag}: compile {res['compile_s']:.1f}s  text {sizes['text']//1024}K  "
                f"bench {ms if ms else 'FAIL'} ms")

    print(f"## CPython build comparison ({args.target})\n")
    print("| compiler | compile (s) | .text (KiB) | .data (KiB) | .bss (KiB) | file (KiB) | bench (ms) |")
    print("|---|--:|--:|--:|--:|--:|--:|")
    for tag, cs, sz, ms in rows:
        if sz is None:
            print(f"| {tag} | FAIL | | | | | |"); continue
        k = lambda b: b // 1024
        print(f"| {tag} | {cs:.1f} | {k(sz['text'])} | {k(sz['data'])} | {k(sz['bss'])} | "
              f"{k(sz['file'])} | {ms if ms else 'FAIL'} |")
    return 0


if __name__ == "__main__":
    sys.exit(main())
