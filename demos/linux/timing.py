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


def run_measured(cmd: list[str], cwd: Path, out_path: Path | None,
                 timeout: float) -> dict:
    """Run one child and return its wall time, CPU split, peak RSS, status.

    ``wait4`` supplies the child's own rusage, so the numbers are per
    invocation. ``Popen.returncode`` is set from the wait status to mark the
    child reaped; without it ``subprocess`` would try to reap it again.
    """
    errf = tempfile.TemporaryFile()
    outf = open(out_path, "wb") if out_path else subprocess.DEVNULL
    t0 = time.monotonic()
    p = subprocess.Popen(cmd, cwd=cwd, stdout=outf, stderr=errf)
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
    err = errf.read(4096).decode(errors="replace")
    errf.close()
    return {
        "wall": wall,
        "utime": ru.ru_utime,
        "stime": ru.ru_stime,
        "maxrss_kb": ru.ru_maxrss,
        "rc": rc,
        "err": err[:400],
    }


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--kernel-dir", type=Path, required=True)
    ap.add_argument("--arch", choices=sorted(sweep.TARGETS),
                    default=sweep.host_arch())
    ap.add_argument("--badc")
    ap.add_argument("-j", "--jobs", type=int, default=1)
    ap.add_argument("--limit", type=int, default=0)
    ap.add_argument("--timeout", type=float, default=300.0)
    ap.add_argument("--mode", choices=("full", "pp", "both"), default="both")
    ap.add_argument("--opt", choices=("recorded", "O0", "O"), default="recorded",
                    help="optimization level: as the reference build recorded "
                         "it, or forced for every unit")
    ap.add_argument("--out", type=Path, required=True, help="JSON result file")
    ap.add_argument("--scratch", type=Path)
    ap.add_argument("--keep-objects", action="store_true")
    ap.add_argument("--only", help="substring filter on the source path")
    args = ap.parse_args(argv)

    badc = sweep.resolve_badc(args.badc)
    kdir = args.kernel_dir.resolve()
    target = sweep.TARGETS[args.arch]
    units = collect_units(kdir)
    if args.only:
        units = [u for u in units if args.only in u[0]]
    if args.limit:
        units = units[: args.limit]
    if not units:
        sys.exit("linux timing: no compile commands found")

    scratch = (args.scratch or (sweep.LINUX_DIR / ".work" / f"timing-{args.arch}"))
    scratch.mkdir(parents=True, exist_ok=True)
    log(f"badc={badc} target={target} units={len(units)} jobs={args.jobs} "
        f"mode={args.mode} opt={args.opt}")

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
        if args.mode in ("pp", "both"):
            pp_out = scratch / (stem + ".i")
            r = run_measured(base[:-1] + ["-E", src], kdir, pp_out, args.timeout)
            rec["pp"] = r
            rec["pp_bytes"] = pp_out.stat().st_size if pp_out.is_file() else 0
            if not args.keep_objects and pp_out.is_file():
                pp_out.unlink()
        if args.mode in ("full", "both"):
            obj = scratch / (stem + ".o")
            r = run_measured(base[:-1] + ["-c", "-o", str(obj), src], kdir,
                             None, args.timeout)
            rec["full"] = r
            rec["obj_bytes"] = obj.stat().st_size if obj.is_file() else 0
            if not args.keep_objects and obj.is_file():
                obj.unlink()
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
        "mode": args.mode,
        "opt": args.opt,
        "jobs": args.jobs,
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
