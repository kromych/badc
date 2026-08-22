#!/usr/bin/env python3
"""Analysis of the per-unit records timing.py writes.

Reports the totals, the cost distribution across translation units, the
slowest units, peak RSS, and a scaling check: cost per preprocessed byte
across size deciles, which is flat for a linear phase and rising for a
superlinear one. A log-log slope is fitted alongside, since a slope near 1
and a flat cost-per-byte curve are the same statement made two ways.
"""

from __future__ import annotations

import argparse
import json
import math
import re
import statistics
from pathlib import Path


def cpu(rec: dict, key: str) -> float:
    r = rec.get(key)
    if not r:
        return 0.0
    return r["utime"] + r["stime"]


def pct(vals: list[float], p: float) -> float:
    if not vals:
        return 0.0
    s = sorted(vals)
    i = min(len(s) - 1, int(round(p / 100.0 * (len(s) - 1))))
    return s[i]


def loglog_slope(xs: list[float], ys: list[float]) -> float:
    pts = [(math.log(x), math.log(y)) for x, y in zip(xs, ys) if x > 0 and y > 0]
    if len(pts) < 3:
        return float("nan")
    mx = sum(p[0] for p in pts) / len(pts)
    my = sum(p[1] for p in pts) / len(pts)
    num = sum((p[0] - mx) * (p[1] - my) for p in pts)
    den = sum((p[0] - mx) ** 2 for p in pts)
    return num / den if den else float("nan")


def deciles(recs: list[dict], size_key: str, cost) -> list[tuple]:
    good = [r for r in recs if r.get(size_key, 0) > 0 and cost(r) > 0]
    good.sort(key=lambda r: r[size_key])
    n = len(good)
    out = []
    for d in range(10):
        lo, hi = n * d // 10, n * (d + 1) // 10
        chunk = good[lo:hi]
        if not chunk:
            continue
        msz = statistics.median(r[size_key] for r in chunk)
        mc = statistics.median(cost(r) for r in chunk)
        out.append((d + 1, len(chunk), msz, mc, mc / msz * 1e6))
    return out


ARCH_TAG = re.compile(r"\s*\((x86_64|aarch64|riscv64)\)$")

# Ordered: the first pattern matching a pass label decides its phase.
PHASES: list[tuple[str, str]] = [
    ("preprocess", r"^preprocess"),
    ("parse + AST", r"^run_compile"),
    ("post-parse", r"^compiler post-parse"),
    ("ssa build", r"^ssa::(produce_ssa_funcs|mem2reg|slot_coalesce)"),
    ("regalloc", r"^ssa::(reg_alloc|liveness)"),
    ("native emit", r"^ssa_emit_"),
    ("mid-end", r"^passes::"),
    ("object", r"^object::"),
]
PHASE_RX = [(n, re.compile(p)) for n, p in PHASES]


def phase_of(label: str) -> str:
    for name, rx in PHASE_RX:
        if rx.search(label):
            return name
    return "other"


def pass_totals(recs: list[dict]) -> dict[str, float]:
    """Per-pass CPU summed over units, arch suffix folded away."""
    out: dict[str, float] = {}
    for r in recs:
        for label, secs in r.get("full", {}).get("passes", {}).items():
            k = ARCH_TAG.sub("", label)
            out[k] = out.get(k, 0.0) + secs
    return out


def report_passes(recs: list[dict], top: int) -> None:
    tot_cpu = sum(cpu(r, "full") for r in recs)
    all_passes = pass_totals(recs)
    if not all_passes:
        print("\n-- no pass timings recorded (needs a codegen_test build)")
        return
    # A `[nested]` label times a region inside another timed pass. It is a
    # breakdown of its parent, not an addition to it, so it stays out of the
    # phase totals and out of the instrumented sum.
    passes = {k: v for k, v in all_passes.items() if "[nested]" not in k}
    inst = sum(passes.values())
    print(f"\n-- per-pass wall over {len(recs)} compiled units "
          f"(instrumented {inst:.1f}s of {tot_cpu:.1f}s CPU)")
    byphase: dict[str, float] = {}
    for label, secs in passes.items():
        byphase[phase_of(label)] = byphase.get(phase_of(label), 0.0) + secs
    byphase["uninstrumented"] = tot_cpu - inst
    print("   phase              seconds   %total   %instrumented")
    for name, secs in sorted(byphase.items(), key=lambda kv: -kv[1]):
        inst_share = "" if name == "uninstrumented" \
            else f"{100.0 * secs / inst:>10.1f}"
        print(f"   {name:<18} {secs:>8.2f} {100.0 * secs / tot_cpu:>8.1f}"
              f"{inst_share}")
    print(f"\n-- {top} costliest individual passes")
    print("   seconds   %total  pass")
    for label, secs in sorted(all_passes.items(), key=lambda kv: -kv[1])[:top]:
        print(f"   {secs:>7.2f} {100.0 * secs / tot_cpu:>8.2f}  {label}")


def report_reference(recs: list[dict], cc: str, top: int) -> None:
    """badc against the reference compiler over the units both compiled."""
    both = [r for r in recs if r.get("ref", {}).get("rc") == 0]
    if not both:
        print(f"\n-- {cc}: no unit compiled")
        return
    b = sum(cpu(r, "full") for r in both)
    g = sum(cpu(r, "ref") for r in both)
    ratios = sorted(cpu(r, "full") / cpu(r, "ref") for r in both
                    if cpu(r, "ref") > 0)
    print(f"\n-- badc vs {cc} on the recorded command line, "
          f"{len(both)}/{len(recs)} units {cc} also compiled")
    print(f"   badc {b:.1f}s CPU   {cc} {g:.1f}s CPU   ratio {b / g:.2f}x")
    print(f"   per-unit badc/{cc}: p10 {pct(ratios, 10):.2f}  "
          f"p50 {pct(ratios, 50):.2f}  p90 {pct(ratios, 90):.2f}  "
          f"max {ratios[-1]:.2f}")
    print(f"   {top} units where badc is furthest behind")
    for r in sorted(both, key=lambda r: -(cpu(r, "full") / max(1e-6, cpu(r, "ref"))))[:top]:
        print(f"   {cpu(r, 'full') / max(1e-6, cpu(r, 'ref')):>6.1f}x  "
              f"badc {cpu(r, 'full'):6.2f}s  {cc} {cpu(r, 'ref'):5.2f}s  "
              f"{r['src']}")


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("json", type=Path, nargs="+")
    ap.add_argument("--top", type=int, default=20)
    ap.add_argument("--exclude", action="append", default=[],
                    help="drop units whose source path contains this "
                         "substring; repeatable. A single outlier unit can "
                         "own most of the corpus cost, and the shares the "
                         "rest of the corpus shows are then unreadable.")
    args = ap.parse_args()

    for path in args.json:
        d = json.loads(path.read_text())
        if args.exclude:
            d["units"] = [u for u in d["units"]
                          if not any(x in u["src"] for x in args.exclude)]
        recs = [r for r in d["units"] if r.get("full", {}).get("rc") == 0
                or r.get("pp", {}).get("rc") == 0]
        okfull = [r for r in d["units"] if r.get("full", {}).get("rc") == 0]
        print(f"\n===== {path.name}  arch={d['arch']} mode={d['mode']} "
              f"opt={d['opt']} jobs={d['jobs']}")
        print(f"units={len(d['units'])} compiled-ok={len(okfull)} "
              f"harness-wall={d['wall_total']:.1f}s")

        has_full = d["mode"] in ("full", "both")
        has_pp = d["mode"] in ("pp", "both")
        tot_full = sum(cpu(r, "full") for r in d["units"])
        tot_pp = sum(cpu(r, "pp") for r in d["units"])
        if has_full:
            print(f"total full-compile CPU: {tot_full:.1f}s")
        if has_pp:
            print(f"total preprocess-only CPU: {tot_pp:.1f}s")
        if has_full and has_pp:
            print(f"preprocess share of full-compile CPU: "
                  f"{100.0 * tot_pp / tot_full:.1f}%  "
                  f"(post-preprocess {100.0 * (tot_full - tot_pp) / tot_full:.1f}%)")

        # Only units that compiled clean carry a full-pipeline cost; a unit
        # that errors out stops early and would bias every share downward.
        base = okfull if has_full else recs
        key = "full" if has_full else "pp"
        costs = [cpu(r, key) for r in base]
        if costs:
            tot = sum(costs)
            print(f"\n-- distribution over {len(costs)} compiled units "
                  f"({key} CPU, total {tot:.1f}s)")
            print(f"   mean {tot / len(costs) * 1000:.0f}ms  "
                  f"p50 {pct(costs, 50) * 1000:.0f}ms  "
                  f"p90 {pct(costs, 90) * 1000:.0f}ms  "
                  f"p99 {pct(costs, 99) * 1000:.0f}ms  "
                  f"max {max(costs) * 1000:.0f}ms")
            s = sorted(costs, reverse=True)
            for frac in (0.01, 0.05, 0.10, 0.25, 0.50):
                k = max(1, int(len(s) * frac))
                print(f"   top {frac * 100:4.0f}% of units ({k:5d}) = "
                      f"{100.0 * sum(s[:k]) / tot:5.1f}% of CPU")

            if has_full and d.get("time_passes"):
                report_passes(okfull, args.top)
            if has_full and d.get("reference"):
                report_reference(okfull, d["reference"], args.top)

            rss = [r[key]["maxrss_kb"] / 1024.0 for r in base]
            print(f"\n-- peak RSS per invocation (MB): "
                  f"p50 {pct(rss, 50):.0f}  p90 {pct(rss, 90):.0f}  "
                  f"p99 {pct(rss, 99):.0f}  max {max(rss):.0f}")

            print(f"\n-- {args.top} slowest units ({key} CPU)")
            for r in sorted(base, key=lambda r: -cpu(r, key))[: args.top]:
                pp = cpu(r, "pp")
                fu = cpu(r, "full")
                print(f"   {fu:7.2f}s full  {pp:6.2f}s pp  "
                      f"{r[key]['maxrss_kb'] / 1024:6.0f}MB  "
                      f"pp={r.get('pp_bytes', 0) / 1e6:6.2f}MB "
                      f"src={r.get('src_bytes', 0) / 1e3:7.1f}KB  "
                      f"{r['opt']:4s} {r['src']}")

        if has_pp:
            print("\n-- scaling: preprocess CPU vs preprocessed bytes")
            print("   decile   n   median-pp-bytes  median-cpu  us/KB")
            for d_, n, msz, mc, uspb in deciles(base, "pp_bytes",
                                                lambda r: cpu(r, "pp")):
                print(f"   {d_:>6} {n:>4}   {msz:>13,.0f}  "
                      f"{mc * 1000:>8.1f}ms  {uspb * 1000:>7.2f}")
            print(f"   log-log slope (pp CPU vs pp bytes): "
                  f"{loglog_slope([r.get('pp_bytes', 0) for r in base], [cpu(r, 'pp') for r in base]):.3f}")

        if has_full and has_pp:
            print("\n-- scaling: post-preprocess CPU vs preprocessed bytes")
            print("   decile   n   median-pp-bytes  median-cpu  us/KB")
            for d_, n, msz, mc, uspb in deciles(
                    base, "pp_bytes", lambda r: cpu(r, "full") - cpu(r, "pp")):
                print(f"   {d_:>6} {n:>4}   {msz:>13,.0f}  "
                      f"{mc * 1000:>8.1f}ms  {uspb * 1000:>7.2f}")
            print(f"   log-log slope (post-pp CPU vs pp bytes): "
                  f"{loglog_slope([r.get('pp_bytes', 0) for r in base], [max(1e-6, cpu(r, 'full') - cpu(r, 'pp')) for r in base]):.3f}")
            print("\n-- scaling: post-preprocess CPU vs object bytes")
            print("   decile   n   median-obj-bytes  median-cpu  us/KB")
            for d_, n, msz, mc, uspb in deciles(
                    base, "obj_bytes", lambda r: cpu(r, "full") - cpu(r, "pp")):
                print(f"   {d_:>6} {n:>4}   {msz:>14,.0f}  "
                      f"{mc * 1000:>8.1f}ms  {uspb * 1000:>7.2f}")
            print(f"   log-log slope (post-pp CPU vs obj bytes): "
                  f"{loglog_slope([r.get('obj_bytes', 0) for r in base], [max(1e-6, cpu(r, 'full') - cpu(r, 'pp')) for r in base]):.3f}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
