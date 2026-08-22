#!/usr/bin/env python3
"""Per-translation-unit cost measurement for a whole-kernel badc build.

Replays the same corpus and the same badc command line as ``sweep.py``, but
records cost rather than success: per unit wall time, user and system CPU,
peak RSS, and the input sizes the cost should scale against. The output is a
JSON record per unit, for distribution and scaling analysis.

Three modes select what is timed:

  full  ``badc -c``            -- the whole compile
  pp    ``badc -E``            -- preprocessing only
  both  both, same unit        -- the difference isolates the post-
                                 preprocessor cost without instrumenting
                                 the compiler

``--time-passes`` adds the per-pass breakdown of the ``-c`` run, read from
the ``pass:`` lines a ``codegen_test`` build writes under
``BADC_TIME_PASSES``. ``--reference cc`` adds a second compiler over the same
units, for absolute standing.

Per-child CPU and peak RSS come from ``wait4``, so they are exact per
invocation rather than a sum over the run. Wall time under ``-j`` includes
contention; run ``-j1`` for per-unit numbers that can be compared to each
other.

The kernel tree is read only. Objects and preprocessed output go to the
scratch directory and are discarded unless ``--keep-objects`` is given.
"""

from __future__ import annotations

import argparse
import json
import os
import re
import subprocess
import sys
import tempfile
import time
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import sweep  # noqa: E402


def log(m: str) -> None:
    print(f"linux timing: {m}", flush=True)


def collect_units(kdir: Path) -> list[tuple[str, list[str]]]:
    units: list[tuple[str, list[str]]] = []
    for root, dirs, files in os.walk(kdir):
        rel_top = os.path.relpath(root, kdir).split(os.sep, 1)[0]
        if rel_top in sweep.SKIP_DIRS:
            dirs[:] = []
            continue
        for f in files:
            if not (f.startswith(".") and f.endswith(".o.cmd")):
                continue
            cmd = sweep.parse_cmd_file(Path(root) / f)
            if cmd is None:
                continue
            kind, src = sweep.classify(cmd)
            if kind == "c":
                units.append((src, cmd))
    units.sort()
    return units


def perf_wrap(cmd: list[str], counters: str, stat_path: Path) -> list[str]:
    """Prefix a command with `perf stat`. Retired-instruction counts are a
    property of the work done, not of who else is on the machine, so they
    stay comparable across runs taken under different load; wall and CPU
    time do not."""
    return ["perf", "stat", "-x,", "-e", counters, "-o", str(stat_path),
            "--", *cmd]


def read_perf_stat(path: Path) -> dict:
    out: dict = {}
    try:
        for line in path.read_text().splitlines():
            f = line.split(",")
            if len(f) >= 3 and f[0].strip() and f[0][0].isdigit():
                try:
                    out[f[2]] = int(f[0])
                except ValueError:
                    pass
    except OSError:
        pass
    return out


PASS_LINE = re.compile(r"^pass: (.+?) -- (\d+)us$")


def parse_passes(err: str) -> dict[str, float]:
    """Sum the `pass: <label> -- <us>us` lines a BADC_TIME_PASSES build
    writes to stderr. A per-function pass emits one line per function, so
    labels repeat and are accumulated."""
    out: dict[str, float] = {}
    for line in err.splitlines():
        m = PASS_LINE.match(line.strip())
        if m:
            out[m.group(1)] = out.get(m.group(1), 0.0) + int(m.group(2)) / 1e6
    return out


def reference_recorded(gcc_argv: list[str], cc: str, obj: Path) -> list[str]:
    """The command kbuild recorded, run by `cc`: every flag as recorded, with
    the compiler and the two output destinations replaced so the tree is not
    written. This is the cost the reference build itself pays for the unit."""
    argv = [cc, *gcc_argv[1:]]
    dep = str(obj) + ".d"
    for i, a in enumerate(argv):
        if a == "-o" and i + 1 < len(argv):
            argv[i + 1] = str(obj)
        elif a.startswith(("-Wp,-MMD,", "-Wp,-MD,")):
            argv[i] = a[: a.index(",", 4) + 1] + dep
        elif a == "-MF" and i + 1 < len(argv):
            argv[i + 1] = dep
    if "-o" not in argv:
        argv += ["-o", str(obj)]
    return argv


def run_measured(cmd: list[str], cwd: Path, out_path: Path | None,
                 timeout: float, env: dict | None = None,
                 full_err: bool = False) -> dict:
    """Run one child and return its wall time, CPU split, peak RSS, status.

    ``wait4`` supplies the child's own rusage, so the numbers are per
    invocation. ``Popen.returncode`` is set from the wait status to mark the
    child reaped; without it ``subprocess`` would try to reap it again.

    ``full_err`` keeps the whole stderr rather than its first 400 bytes; the
    pass timer writes one line per pass per function, which does not fit.
    """
    errf = tempfile.TemporaryFile()
    outf = open(out_path, "wb") if out_path else subprocess.DEVNULL
    t0 = time.monotonic()
    p = subprocess.Popen(cmd, cwd=cwd, stdout=outf, stderr=errf, env=env)
    try:
        deadline = t0 + timeout
        while True:
            pid, status, ru = os.wait4(p.pid, os.WNOHANG)
            if pid != 0:
                break
            if time.monotonic() > deadline:
                p.kill()
                pid, status, ru = os.wait4(p.pid, 0)
                status = -1
                break
            time.sleep(0.002)
    finally:
        wall = time.monotonic() - t0
        if out_path:
            outf.close()
    rc = -1 if status == -1 else os.waitstatus_to_exitcode(status)
    p.returncode = rc
    errf.seek(0)
    err = errf.read().decode(errors="replace") if full_err \
        else errf.read(4096).decode(errors="replace")
    errf.close()
    rec = {
        "wall": wall,
        "utime": ru.ru_utime,
        "stime": ru.ru_stime,
        "maxrss_kb": ru.ru_maxrss,
        "rc": rc,
        "err": err[:400],
    }
    if full_err:
        rec["passes"] = parse_passes(err)
    return rec


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--kernel-dir", type=Path, required=True)
    ap.add_argument("--arch", choices=sorted(sweep.TARGETS),
                    default=sweep.host_arch())
    ap.add_argument("--badc")
    ap.add_argument("-j", "--jobs", type=int, default=1)
    ap.add_argument("--limit", type=int, default=0)
    ap.add_argument("--stride", type=int, default=1,
                    help="measure every Nth unit of the sorted corpus; the "
                         "corpus is ordered by path, so a stride samples "
                         "across subsystems rather than truncating")
    ap.add_argument("--timeout", type=float, default=300.0)
    ap.add_argument("--mode", choices=("full", "pp", "both"), default="both")
    ap.add_argument("--opt", choices=("recorded", "O0", "O"), default="recorded",
                    help="optimization level: as the reference build recorded "
                         "it, or forced for every unit")
    ap.add_argument("--out", type=Path, required=True, help="JSON result file")
    ap.add_argument("--scratch", type=Path)
    ap.add_argument("--keep-objects", action="store_true")
    ap.add_argument("--only", help="substring filter on the source path")
    ap.add_argument("--reps", type=int, default=1,
                    help="repeat each unit N times and keep the cheapest "
                         "observation; the minimum is the least-contended "
                         "sample, which is what a quiet machine would give")
    ap.add_argument("--counters",
                    help="perf stat event list to record per unit, e.g. "
                         "instructions,cycles; costs one perf exec per unit")
    ap.add_argument("--time-passes", action="store_true",
                    help="set BADC_TIME_PASSES for the -c run and record the "
                         "per-pass wall it reports; needs a badc built with "
                         "--features codegen_test. The reported passes do not "
                         "cover the whole process, so the report states the "
                         "uninstrumented residual as its own line.")
    ap.add_argument("--reference",
                    help="also compile each unit with this reference compiler "
                         "on the command kbuild recorded, for an absolute "
                         "wall-clock standing. The recorded line carries work "
                         "badc's reduced flag set does not do (warnings, "
                         "stack protector, patchable entries), so the ratio "
                         "is build cost against build cost, not pass for pass.")
    args = ap.parse_args(argv)

    badc = sweep.resolve_badc(args.badc)
    kdir = args.kernel_dir.resolve()
    target = sweep.TARGETS[args.arch]
    units = collect_units(kdir)
    n_all = len(units)
    if args.only:
        units = [u for u in units if args.only in u[0]]
    if args.stride > 1:
        units = units[:: args.stride]
    if args.limit:
        units = units[: args.limit]
    if not units:
        sys.exit("linux timing: no compile commands found")

    scratch = (args.scratch or (sweep.LINUX_DIR / ".work" / f"timing-{args.arch}"))
    scratch.mkdir(parents=True, exist_ok=True)
    log(f"badc={badc} target={target} units={len(units)}/{n_all} "
        f"stride={args.stride} jobs={args.jobs} mode={args.mode} "
        f"opt={args.opt}")

    pass_env = None
    if args.time_passes:
        pass_env = dict(os.environ, BADC_TIME_PASSES="1")

    def flags_for(gcc_argv: list[str]) -> list[str]:
        f = sweep.rewrite(gcc_argv)
        if args.opt == "O0":
            f = [x for x in f if x != "-O"]
        elif args.opt == "O" and "-O" not in f:
            f = f + ["-O"]
        return f

    def run_one(item: tuple[str, list[str]]) -> dict:
        src, gcc_argv = item
        stem = src.replace(os.sep, "_")
        flags = flags_for(gcc_argv)
        base = [str(badc), "--gnu", "-q", f"--target={target}", *flags, src]
        rec: dict = {
            "src": src,
            "src_bytes": (kdir / src).stat().st_size if (kdir / src).is_file() else 0,
            "opt": "-O" if "-O" in flags else "-O0",
        }
        statf = scratch / (stem + ".stat")

        def wrap(c: list[str]) -> list[str]:
            return perf_wrap(c, args.counters, statf) if args.counters else c

        def cheapest(cmd: list[str], out: Path | None, env: dict | None = None,
                     full_err: bool = False) -> dict:
            best = None
            for _ in range(args.reps):
                r = run_measured(cmd, kdir, out, args.timeout, env, full_err)
                if args.counters:
                    r["counters"] = read_perf_stat(statf)
                if r["rc"] != 0:
                    return r
                if best is None or r["utime"] + r["stime"] < best["utime"] + best["stime"]:
                    best = r
            return best if best is not None else r

        if args.mode in ("pp", "both"):
            pp_out = scratch / (stem + ".i")
            r = cheapest(wrap(base[:-1] + ["-E", src]), pp_out)
            rec["pp"] = r
            rec["pp_bytes"] = pp_out.stat().st_size if pp_out.is_file() else 0
            if not args.keep_objects and pp_out.is_file():
                pp_out.unlink()
        if args.mode in ("full", "both"):
            obj = scratch / (stem + ".o")
            r = cheapest(wrap(base[:-1] + ["-c", "-o", str(obj), src]), None,
                         pass_env, args.time_passes)
            rec["full"] = r
            rec["obj_bytes"] = obj.stat().st_size if obj.is_file() else 0
            if not args.keep_objects and obj.is_file():
                obj.unlink()
        if args.reference:
            ref = scratch / (stem + ".ref.o")
            rec["ref"] = cheapest(
                reference_recorded(gcc_argv, args.reference, ref), None)
            rec["ref_obj_bytes"] = ref.stat().st_size if ref.is_file() else 0
            if not args.keep_objects and ref.is_file():
                ref.unlink()
        if statf.is_file():
            statf.unlink()
        return rec

    t0 = time.monotonic()
    results: list[dict] = []
    done = 0
    with ThreadPoolExecutor(max_workers=args.jobs) as ex:
        for rec in ex.map(run_one, units):
            results.append(rec)
            done += 1
            if done % 200 == 0:
                log(f"{done}/{len(units)} ({time.monotonic() - t0:.0f}s)")
    wall = time.monotonic() - t0

    ok = sum(1 for r in results if r.get("full", {}).get("rc") == 0)
    cpu = sum(r.get("full", {}).get("utime", 0.0) + r.get("full", {}).get("stime", 0.0)
              for r in results)
    ppcpu = sum(r.get("pp", {}).get("utime", 0.0) + r.get("pp", {}).get("stime", 0.0)
                for r in results)
    args.out.parent.mkdir(parents=True, exist_ok=True)
    args.out.write_text(json.dumps({
        "arch": args.arch,
        "corpus_units": n_all,
        "stride": args.stride,
        "mode": args.mode,
        "opt": args.opt,
        "jobs": args.jobs,
        "time_passes": bool(args.time_passes),
        "reference": args.reference or "",
        "badc": str(badc),
        "kernel_dir": str(kdir),
        "wall_total": wall,
        "units": results,
    }))
    log(f"done: {len(results)} units, {ok} compiled, wall {wall:.1f}s, "
        f"full CPU {cpu:.1f}s, pp CPU {ppcpu:.1f}s -> {args.out}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
