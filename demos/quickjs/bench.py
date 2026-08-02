#!/usr/bin/env python3
"""Comparative benchmark of the badc-built QuickJS engine.

Builds the `qjs` CLI from one recipe -- the same translation units, defines
and includes the smoke uses -- with each requested compiler at each
optimization level, then runs QuickJS's own `tests/microbench.js` through
every resulting binary. The recipe is held constant so the compiler is the
only variable: the per-benchmark nanoseconds measure codegen quality and
the linked size measures output slimness. Each compiler's own wall-clock
for the build is reported alongside. Neither leg exports its symbols, so
the sizes compare code and data rather than symbol tables.

microbench.js reports nanoseconds per operation, so the numbers are
comparable across machines in shape if not in magnitude. A bounded subset
runs by default (the full list takes tens of seconds per binary);
`--full` runs everything.

    python3 demos/quickjs/bench.py [--cc=badc,clang] [--full] [--bench=a,b]

Output is GitHub-Flavored Markdown on stdout.
"""

from __future__ import annotations

import argparse
import os
import re
import shutil
import subprocess
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import smoke  # noqa: E402  (sibling module: the build recipe)

QJS_DIR = smoke.QJS_DIR
CACHE = smoke.CACHE

# Interpreter paths worth separating: dispatch, calls, shapes/inline caches,
# fast arrays, hashing, bigint, and the number/string conversions in dtoa.
DEFAULT_BENCHES = (
    "empty_loop",
    "int_arith",
    "float_arith",
    "func_call",
    "func_closure_call",
    "prop_read",
    "prop_write",
    "array_read",
    "array_write",
    "typed_array_read",
    "map_set_int",
    "int_to_string",
    "string_to_int",
    "bigint64_arith",
)


def compile_cmd(kind, cc, opt, sources, out):
    defs = []
    for d in smoke.DEFINES:
        defs += ["-D", d]
    if kind == "badc":
        return [cc, *(["-O"] if opt else []), *defs,
                "-I", str(QJS_DIR), *sources, "-o", str(out)]
    if kind == "clang":
        # -fwrapv matches the upstream Makefile: the engine relies on signed
        # overflow wrapping. -w keeps the table readable.
        o = ["-O2", "-DNDEBUG"] if opt else ["-O0"]
        libs = ["-lm"]
        if sys.platform != "darwin":
            libs += ["-ldl", "-lpthread"]
        return [cc, "-fwrapv", "-w", *o, *defs,
                "-I", str(QJS_DIR), *sources, "-o", str(out), *libs]
    raise SystemExit(f"bench: unsupported compiler {kind}")


def build(kind, cc, opt, log):
    """Build the CLI with the REPL stub (the benchmark never enters the
    REPL, so the bytecode blob the smoke generates is not needed here)."""
    tag = f"{kind} {'-O' if opt else 'no-O'}"
    out_dir = CACHE / f"bench-{kind}-{'O2' if opt else 'O0'}"
    out_dir.mkdir(parents=True, exist_ok=True)
    exe = out_dir / "qjs"
    sources = [str(QJS_DIR / t) for t in smoke.LIB_TUS]
    sources += [str(QJS_DIR / "qjs.c"), str(QJS_DIR / "repl_stub.c")]
    t0 = time.perf_counter()
    r = subprocess.run(compile_cmd(kind, cc, opt, sources, exe),
                       capture_output=True, text=True, timeout=1800)
    dt = time.perf_counter() - t0
    if r.returncode != 0 or not exe.is_file():
        log(f"  {tag}: build failed -- {(r.stderr or r.stdout)[-300:]}")
        return None
    log(f"  {tag}: built in {dt:.1f}s")
    return {"exe": exe, "compile_s": dt, "tag": tag}


def measure(exe: Path, benches, timeout: int):
    """Run microbench.js and return {name: ns_per_op}."""
    args = [str(exe), "--std", str(QJS_DIR / "tests" / "microbench.js")]
    args += list(benches)
    r = subprocess.run(args, capture_output=True, text=True,
                       cwd=str(CACHE), timeout=timeout)
    if r.returncode != 0:
        return None
    out = {}
    for line in r.stdout.splitlines():
        f = line.split()
        # "<name> <N> <time_ns>"; the header and the trailing total differ in shape.
        if len(f) >= 3 and re.fullmatch(r"[0-9.]+", f[2]) and f[1].isdigit():
            out[f[0]] = float(f[2])
    return out or None


def main(argv=None) -> int:
    p = argparse.ArgumentParser(description=__doc__,
                                formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("--cc", default="badc,clang", help="comma-separated: badc,clang")
    p.add_argument("--full", action="store_true", help="run every microbench")
    p.add_argument("--bench", default="", help="comma-separated benchmark names")
    args = p.parse_args(argv)

    def log(m):
        print(m, file=sys.stderr)

    if not (QJS_DIR / "tests" / "microbench.js").is_file():
        sys.exit("bench: quickjs source missing -- run demos/quickjs/setup.py")
    CACHE.mkdir(parents=True, exist_ok=True)

    benches = [b for b in args.bench.split(",") if b]
    if not benches and not args.full:
        benches = list(DEFAULT_BENCHES)
    timeout = 1800 if args.full else 600

    resolve = {"badc": lambda: str(smoke.resolve_badc()),
               "clang": lambda: shutil.which("clang")}
    rows = []
    for kind in [c.strip() for c in args.cc.split(",") if c.strip()]:
        cc = resolve.get(kind, lambda: None)()
        if not cc:
            log(f"bench: {kind} not found, skipping")
            continue
        for opt in (False, True):
            log(f"building {kind} {'-O' if opt else 'no-O'} ...")
            b = build(kind, cc, opt, log)
            if not b:
                rows.append((f"{kind} {'-O' if opt else 'no-O'}", None, None, None))
                continue
            t = measure(b["exe"], benches, timeout)
            rows.append((b["tag"], b["compile_s"], b["exe"].stat().st_size, t))
            log(f"  {b['tag']}: {'measured' if t else 'BENCH FAIL'}")

    print(f"## QuickJS engine comparison ({os.uname().sysname} {os.uname().machine})\n")
    print("| compiler | compile (s) | linked size (KiB) |")
    print("|---|--:|--:|")
    for tag, cs, sz, _ in rows:
        if sz is None:
            print(f"| {tag} | FAIL | |")
            continue
        print(f"| {tag} | {cs:.1f} | {sz // 1024} |")

    measured = [(tag, t) for tag, _, _, t in rows if t]
    if not measured:
        print("\n(no benchmark results)")
        return 1
    names = [n for n in measured[0][1] if all(n in t for _, t in measured)]
    print(f"\n### microbench.js -- nanoseconds per operation (lower is better)\n")
    print("| benchmark | " + " | ".join(tag for tag, _ in measured) + " |")
    print("|---" * (len(measured) + 1) + "|")
    for n in names:
        cells = [f"{t[n]:.2f}" for _, t in measured]
        print(f"| {n} | " + " | ".join(cells) + " |")
    totals = [sum(t[n] for n in names) for _, t in measured]
    print("| **total** | " + " | ".join(f"**{v:.2f}**" for v in totals) + " |")
    return 0


if __name__ == "__main__":
    sys.exit(main())
