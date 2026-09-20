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

badc -O implies NDEBUG; the clang -O2 and cl /O2 rows pass -DNDEBUG
explicitly to match. The unoptimized entries keep asserts live.

Override the badc binary via $BADC; override the tcc binary via $TCC.
"""

from __future__ import annotations

import argparse
import json
import os
import platform
import re
import shutil
import statistics
import subprocess
import sys
import time
from dataclasses import dataclass
from pathlib import Path

PERF_DIR = Path(__file__).resolve().parent
REPO_ROOT = PERF_DIR.parent.parent

WIN = sys.platform == "win32"
EXE = ".exe" if WIN else ""
RUNS_PER_FIXTURE = 3
TIMING_LINE_RE = re.compile(r"in\s+(\d+(?:\.\d+)?)\s+ms")

# The SQLite amalgamation only parses once the features pulling in
# headers badc does not ship are switched off (load-extension, the
# Apple AFP locking path, deprecated entry points). The same knobs are
# harmless for clang and tcc, so every compiler gets them.
SQLITE_DEFINES = [
    "-DSQLITE_OMIT_LOAD_EXTENSION",
    "-DSQLITE_THREADSAFE=0",
    "-DSQLITE_DEFAULT_MEMSTATUS=0",
    "-DSQLITE_DQS=0",
    "-DSQLITE_OMIT_DEPRECATED",
    "-DSQLITE_OMIT_PROGRESS_CALLBACK",
    "-DSQLITE_OMIT_SHARED_CACHE",
    "-DSQLITE_OMIT_AUTOINIT",
    "-DSQLITE_WITHOUT_ZONEMALLOC=1",
    "-DSQLITE_DEFAULT_WAL_SYNCHRONOUS=1",
    "-DSQLITE_ENABLE_LOCKING_STYLE=0",
    # sqlite reaches for MSVC's __umulh / _umul128 intrinsics and the
    # SEH wrappers; disabling them selects the portable fallbacks. Both
    # are inert for clang and tcc, which never take the MSVC paths.
    "-DSQLITE_DISABLE_INTRINSIC",
    "-DSQLITE_OMIT_SEH",
    # glibc gates `mremap` + `MREMAP_MAYMOVE` behind `_GNU_SOURCE`; the
    # sqlite amalgamation hard-references both on Linux. macOS / BSD
    # headers ignore the macro.
    "-D_GNU_SOURCE",
]

# Extra compile flags per fixture. The `-I` entries put each vendored
# demo directory on the include search path: badc resolves quoted
# includes against the search path rather than the including file's
# directory, and the path is harmless for clang and tcc.
FIXTURE_FLAGS: dict[str, list[str]] = {
    "crypto.c": [f"-I{REPO_ROOT}/demos/tweetnacl"],
    "sqlite.c": [f"-I{REPO_ROOT}/demos/sqlite3", *SQLITE_DEFINES],
    "sqlite_bench.c": [f"-I{REPO_ROOT}/demos/sqlite3", *SQLITE_DEFINES],
    "compress.c": [
        f"-I{REPO_ROOT}/demos/miniz",
        # Keep only the in-memory zlib-style codec; drop the ZIP archive,
        # stdio, and wall-clock paths that reach for headers badc and tcc
        # do not ship (sys/utime.h, struct utimbuf).
        "-DMINIZ_NO_STDIO",
        "-DMINIZ_NO_TIME",
        "-DMINIZ_NO_ARCHIVE_APIS",
    ],
    "stb.c": [f"-I{REPO_ROOT}/demos/stb"],
    # quickjs_bench.c drives the full engine, so its other seven
    # translation units ride along as extra source arguments. qjs.c is
    # excluded -- the bench supplies its own main().
    "quickjs_bench.c": [
        f"-I{REPO_ROOT}/demos/quickjs",
        "-D_GNU_SOURCE",
        '-DCONFIG_VERSION="2024"',
        f"{REPO_ROOT}/demos/quickjs/quickjs.c",
        f"{REPO_ROOT}/demos/quickjs/quickjs-libc.c",
        f"{REPO_ROOT}/demos/quickjs/cutils.c",
        f"{REPO_ROOT}/demos/quickjs/libregexp.c",
        f"{REPO_ROOT}/demos/quickjs/libunicode.c",
        f"{REPO_ROOT}/demos/quickjs/dtoa.c",
        f"{REPO_ROOT}/demos/quickjs/repl_stub.c",
    ],
}

# Flags applied only when the compiler is badc. The bundled msvc_compat.h
# presents the MSVC surface sqlite's Windows paths expect; it is guarded by
# `_WIN32`, so the include changes nothing on other targets. clang and tcc
# use the real system headers and must not see this include.
BADC_FIXTURE_FLAGS: dict[str, list[str]] = {
    "sqlite.c": ["-include", "msvc_compat.h"],
    "sqlite_bench.c": ["-include", "msvc_compat.h"],
}

# Compilers that cannot build a given fixture, skipped rather than counted
# as a build failure. The vendored tcc does not implement the AArch64
# `yield` instruction quickjs uses in a spin loop.
FIXTURE_SKIP_COMPILERS: dict[str, set[str]] = {
    "quickjs_bench.c": {"tcc"},
}


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
    compile_ms: float


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
        # Bootstrap the vendored tinycc on first run so the perf
        # table reports a single-pass non-optimising baseline
        # without the caller having to remember to invoke
        # `build_tcc.sh`. The build script is a no-op when its
        # output already exists.
        if not tcc.is_file():
            build_script = PERF_DIR / "build_tcc.sh"
            if build_script.is_file():
                print(
                    f"info: bootstrapping vendored tinycc via {build_script.name}",
                    file=sys.stderr,
                )
                subprocess.run(["bash", str(build_script)], check=False)
    if tcc.is_file():
        # tcc's macho build needs the macOS SDK include path; the Linux
        # build is happy with the bundled `-B` directory holding
        # tccdefs.h.
        # -B finds tccdefs.h; -L puts the build dir on the library path
        # so tcc resolves its own libtcc1.a there.
        tcc_cmd = [
            str(tcc),
            f"-B{tcc.parent}",
            f"-I{tcc.parent}/include",
            f"-L{tcc.parent}",
        ]
        if sys.platform == "darwin":
            sdk = subprocess.run(
                ["xcrun", "--show-sdk-path"],
                capture_output=True,
                text=True,
                check=False,
            )
            if sdk.returncode == 0 and sdk.stdout.strip():
                tcc_cmd += [f"-I{sdk.stdout.strip()}/usr/include"]
        # The FP fixtures call libm (fabs); on Linux libm is a separate
        # archive that must be named at link time. macOS folds it into
        # libSystem, which tcc links by default.
        tcc_trailing = ("-lm",) if sys.platform == "linux" else ()
        found.append(Compiler("tcc", tcc_cmd, trailing=tcc_trailing))
    else:
        print(f"info: tcc not at {tcc}; skipping tcc rows", file=sys.stderr)

    if shutil.which("clang"):
        # The FP fixtures and quickjs call libm (pow / fmod / ldexp); on
        # Linux libm is a separate archive that must be named at link
        # time, the same reason tcc needs it above. macOS folds it into
        # libSystem. Without `-lm` clang fails to link quickjs_bench.
        clang_trailing = ("-lm",) if sys.platform == "linux" else ()
        found.append(Compiler("clang -O0", ["clang", "-O0"], trailing=clang_trailing))
        found.append(Compiler("clang -O2", ["clang", "-O2", "-DNDEBUG"], trailing=clang_trailing))

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
                ["cl", "/nologo", "/O2", "/DNDEBUG"],
                output_dash_o=False,
            )
        )

    return found


def compile_one(c: Compiler, src: Path, out: Path) -> float | None:
    """Compile `src` with `c`, returning the wall-clock in milliseconds, or
    `None` when the compiler failed or produced nothing."""
    extra = list(FIXTURE_FLAGS.get(src.name, []))
    if c.name.startswith("badc"):
        extra += BADC_FIXTURE_FLAGS.get(src.name, [])
    if c.output_dash_o:
        argv = [*c.cmd, *extra, "-o", str(out), str(src), *c.trailing]
    else:
        argv = [*c.cmd, *extra, f"/Fe:{out}", str(src), *c.trailing]
    t0 = time.monotonic()
    r = subprocess.run(argv, capture_output=True, text=True)
    compile_ms = (time.monotonic() - t0) * 1000.0
    if r.returncode != 0:
        print(
            f"compile fail: {c.name} {src.name} -> exit {r.returncode}",
            file=sys.stderr,
        )
        if r.stderr:
            print(r.stderr, file=sys.stderr)
        return None
    if not out.is_file() or out.stat().st_size == 0:
        print(
            f"compile fail: {c.name} {src.name} -> empty output {out}",
            file=sys.stderr,
        )
        return None
    # macOS sometimes refuses unsigned binaries with SIGKILL; sign with
    # the ad-hoc identity if we just produced an aarch64 binary.
    if sys.platform == "darwin" and platform.machine() == "arm64":
        subprocess.run(["codesign", "-s", "-", str(out)], check=False)
    return compile_ms


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
            ratio = "-"
            if baseline is not None and baseline.median_ms > 0:
                ratio = f"{r.median_ms / baseline.median_ms:.2f}x"
            out.append(
                f"| {r.compiler} | {r.median_ms:.1f} | {r.binary_bytes:,} | {ratio} |"
            )
        out.append("")
    return "\n".join(out)


def cpu_model() -> str:
    """The machine's processor, as the host reports it; empty when it does
    not say. The figures are comparable within one run only, so the page
    that publishes them names the machine each run landed on."""
    try:
        if sys.platform == "darwin":
            out = subprocess.run(["sysctl", "-n", "machdep.cpu.brand_string"],
                                 capture_output=True, text=True)
            return out.stdout.strip()
        if sys.platform.startswith("linux"):
            for line in Path("/proc/cpuinfo").read_text().splitlines():
                for key in ("model name", "Model"):
                    if line.startswith(key):
                        return line.split(":", 1)[1].strip()
    except OSError:
        pass
    return ""


def compiler_version(c: Compiler) -> str:
    """The first line of the compiler's own version output."""
    flag = "--version" if c.output_dash_o else ""
    argv = [*c.cmd[:1], flag] if flag else c.cmd[:1]
    try:
        r = subprocess.run(argv, capture_output=True, text=True)
    except OSError:
        return ""
    text = (r.stdout or r.stderr).strip().splitlines()
    return text[0] if text else ""


def write_json(path: Path, compilers: list[Compiler], fixtures: list[str],
               results: list[Result]) -> None:
    """The run as data, for the page that charts it: what ran where, and one
    record per (fixture, compiler) with the three measurements."""
    doc = {
        "taken": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        "machine": {
            "system": platform.system(),
            "release": platform.release(),
            "arch": platform.machine(),
            "cpu": cpu_model(),
        },
        "runs_per_fixture": RUNS_PER_FIXTURE,
        "compilers": [{"name": c.name, "version": compiler_version(c)}
                      for c in compilers],
        "fixtures": fixtures,
        "results": [
            {
                "fixture": r.fixture,
                "compiler": r.compiler,
                "run_ms": round(r.median_ms, 2),
                "compile_ms": round(r.compile_ms, 1),
                "binary_bytes": r.binary_bytes,
            }
            for r in results
        ],
    }
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(doc, indent=1) + "\n")


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--json", type=Path, metavar="PATH",
                    help="also write the run as JSON, for the performance page")
    ap.add_argument("--only", metavar="A.c,B.c",
                    help="run these fixtures instead of the whole set")
    args = ap.parse_args()

    compilers = probe_compilers()
    if not compilers:
        print("error: no compilers found", file=sys.stderr)
        return 1

    fixtures = [
        "fib.c",
        "qsort.c",
        "sieve.c",
        # Digit loop over a counted range: division and modulo by a
        # constant, a table load, and an early-exit compare.
        "munchausen.c",
        "crypto.c",
        "compress.c",
        "stb.c",
        "sqlite.c",
        # Multi-phase workload (bulk insert, aggregation, sort, index,
        # join, subquery, update / delete; 100k + 50k rows).
        "sqlite_bench.c",
        "quickjs_bench.c",
    ]
    if args.only:
        want = [f.strip() for f in args.only.split(",") if f.strip()]
        missing = [f for f in want if f not in fixtures]
        if missing:
            print(f"error: unknown fixture(s): {', '.join(missing)}", file=sys.stderr)
            return 1
        fixtures = want
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
            if c.name in FIXTURE_SKIP_COMPILERS.get(fix, set()):
                continue
            out = out_dir / f"{src.stem}-{c.name.replace(' ', '_').replace('/', '_')}{EXE}"
            compile_ms = compile_one(c, src, out)
            if compile_ms is None:
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
                    compile_ms=compile_ms,
                )
            )

    print("## perf comparison")
    print()
    print(render_table(fixtures, results))
    if args.json:
        write_json(args.json, compilers, fixtures, results)
        print(f"\nwrote {args.json}")
    return 1 if any_fail else 0


if __name__ == "__main__":
    sys.exit(main())
