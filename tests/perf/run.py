#!/usr/bin/env python3
"""Perf-table harness comparing badc against the vendored tcc and
clang / msvc on a small fixture set.

Each fixture is compiled with every available compiler, the result is
run three times, and the median wall-clock is reported. The table goes
to stdout in GitHub-Flavored-Markdown so the CI job can route it into
$GITHUB_STEP_SUMMARY.

Exit status:
* 0 -- table printed; every binary built and ran successfully.
* 1 -- one or more entries failed to build or run.

Compilers probed (skipped silently when absent):
* badc         -- target/release/badc next to repo root.
* badc -O      -- same with -O.
* tcc          -- built by build_tcc.sh from demos/tinycc sources.
* clang -O0    -- system clang if on PATH.
* clang -O2    -- same.
* cl /Od       -- MSVC cl.exe on Windows.
* cl /O2       -- MSVC cl.exe on Windows.

Override the badc binary via $BADC; override the tcc binary via $TCC.
"""

from __future__ import annotations

import os
import platform
import re
import shutil
import statistics
import subprocess
import sys
from dataclasses import dataclass
from pathlib import Path

PERF_DIR = Path(__file__).resolve().parent
REPO_ROOT = PERF_DIR.parent.parent

WIN = sys.platform == "win32"
EXE = ".exe" if WIN else ""
RUNS_PER_FIXTURE = 3
TIMING_LINE_RE = re.compile(r"in\s+(\d+(?:\.\d+)?)\s+ms")


@dataclass
class Compiler:
    name: str
    cmd: list[str]
    # When True, the compiler invocation expects the output flag as
    # `-o <path>`; when False (MSVC), it expects `/Fe:<path>`.
    output_dash_o: bool = True
    # Extra flags appended after the source path.
    trailing: tuple[str, ...] = ()


@dataclass
class Result:
    compiler: str
    fixture: str
    binary_bytes: int
    median_ms: float


def probe_compilers() -> list[Compiler]:
    found: list[Compiler] = []

    badc_env = os.environ.get("BADC")
    if badc_env:
        badc = Path(badc_env)
    else:
        badc = REPO_ROOT / "target" / "release" / f"badc{EXE}"
    if badc.is_file():
        found.append(Compiler("badc", [str(badc)]))
        found.append(Compiler("badc -O", [str(badc), "-O"]))
    else:
        print(f"info: badc not at {badc}; skipping badc rows", file=sys.stderr)

    tcc_env = os.environ.get("TCC")
    if tcc_env:
        tcc = Path(tcc_env)
    else:
        tcc = PERF_DIR / "build" / f"tcc{EXE}"
    if tcc.is_file():
        # tcc's macho build needs the macOS SDK include path; the Linux
        # build is happy with the bundled `-B` directory holding
        # tccdefs.h.
        tcc_cmd = [str(tcc), f"-B{tcc.parent}", f"-I{tcc.parent}/include"]
        if sys.platform == "darwin":
            sdk = subprocess.run(
                ["xcrun", "--show-sdk-path"],
                capture_output=True,
                text=True,
                check=False,
            )
            if sdk.returncode == 0 and sdk.stdout.strip():
                tcc_cmd += [f"-I{sdk.stdout.strip()}/usr/include"]
        found.append(Compiler("tcc", tcc_cmd))
    else:
        print(f"info: tcc not at {tcc}; skipping tcc rows", file=sys.stderr)

    if shutil.which("clang"):
        found.append(Compiler("clang -O0", ["clang", "-O0"]))
        found.append(Compiler("clang -O2", ["clang", "-O2"]))

    if WIN and shutil.which("cl"):
        found.append(
            Compiler(
                "cl /Od",
                ["cl", "/nologo", "/Od"],
                output_dash_o=False,
            )
        )
        found.append(
            Compiler(
                "cl /O2",
                ["cl", "/nologo", "/O2"],
                output_dash_o=False,
            )
        )

    return found


def compile_one(c: Compiler, src: Path, out: Path) -> bool:
    if c.output_dash_o:
        argv = [*c.cmd, "-o", str(out), str(src), *c.trailing]
    else:
        argv = [*c.cmd, f"/Fe:{out}", str(src), *c.trailing]
    r = subprocess.run(argv, capture_output=True, text=True)
    if r.returncode != 0:
        print(
            f"compile fail: {c.name} {src.name} -> exit {r.returncode}",
            file=sys.stderr,
        )
        if r.stderr:
            print(r.stderr, file=sys.stderr)
        return False
    if not out.is_file() or out.stat().st_size == 0:
        print(
            f"compile fail: {c.name} {src.name} -> empty output {out}",
            file=sys.stderr,
        )
        return False
    # macOS sometimes refuses unsigned binaries with SIGKILL; sign with
    # the ad-hoc identity if we just produced an aarch64 binary.
    if sys.platform == "darwin" and platform.machine() == "arm64":
        subprocess.run(["codesign", "-s", "-", str(out)], check=False)
    return True


def run_one(out: Path) -> float | None:
    times = []
    for _ in range(RUNS_PER_FIXTURE):
        r = subprocess.run([str(out)], capture_output=True, text=True)
        if r.returncode != 0:
            print(
                f"run fail: {out.name} -> exit {r.returncode}",
                file=sys.stderr,
            )
            if r.stderr:
                print(r.stderr, file=sys.stderr)
            return None
        m = TIMING_LINE_RE.search(r.stdout)
        if not m:
            print(f"run: no timing line in output of {out.name}", file=sys.stderr)
            print(r.stdout, file=sys.stderr)
            return None
        times.append(float(m.group(1)))
    return statistics.median(times)


def render_table(fixtures: list[str], results: list[Result]) -> str:
    by_fix: dict[str, dict[str, Result]] = {}
    for r in results:
        by_fix.setdefault(r.fixture, {})[r.compiler] = r
    compilers = sorted({r.compiler for r in results})
    # Pin badc rows to the top so the comparison reads from the
    # project of interest outward.
    pinned = [c for c in ["badc", "badc -O", "tcc"] if c in compilers]
    rest = sorted(c for c in compilers if c not in pinned)
    compilers = pinned + rest

    out: list[str] = []
    for fix in fixtures:
        rows = by_fix.get(fix, {})
        if not rows:
            continue
        out.append(f"### {fix}")
        out.append("")
        out.append("| compiler | median (ms) | binary (bytes) | vs badc -O |")
        out.append("| --- | ---: | ---: | ---: |")
        baseline = rows.get("badc -O")
        for c in compilers:
            r = rows.get(c)
            if r is None:
                continue
            ratio = "—"
            if baseline is not None and baseline.median_ms > 0:
                ratio = f"{r.median_ms / baseline.median_ms:.2f}x"
            out.append(
                f"| {r.compiler} | {r.median_ms:.1f} | {r.binary_bytes:,} | {ratio} |"
            )
        out.append("")
    return "\n".join(out)


def main() -> int:
    compilers = probe_compilers()
    if not compilers:
        print("error: no compilers found", file=sys.stderr)
        return 1

    fixtures = ["fib.c", "qsort.c"]
    results: list[Result] = []
    any_fail = False

    out_dir = PERF_DIR / "build" / "bins"
    out_dir.mkdir(parents=True, exist_ok=True)

    for fix in fixtures:
        src = PERF_DIR / fix
        if not src.is_file():
            print(f"missing fixture: {src}", file=sys.stderr)
            any_fail = True
            continue
        for c in compilers:
            out = out_dir / f"{src.stem}-{c.name.replace(' ', '_').replace('/', '_')}{EXE}"
            if not compile_one(c, src, out):
                any_fail = True
                continue
            t = run_one(out)
            if t is None:
                any_fail = True
                continue
            results.append(
                Result(
                    compiler=c.name,
                    fixture=fix,
                    binary_bytes=out.stat().st_size,
                    median_ms=t,
                )
            )

    print("## perf comparison")
    print()
    print(render_table(fixtures, results))
    return 1 if any_fail else 0


if __name__ == "__main__":
    sys.exit(main())
