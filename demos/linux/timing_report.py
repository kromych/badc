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


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("json", type=Path, nargs="+")
    ap.add_argument("--top", type=int, default=20)
    args = ap.parse_args()

    for path in args.json:
        d = json.loads(path.read_text())
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
