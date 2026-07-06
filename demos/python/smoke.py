#!/usr/bin/env python3
"""Build CPython 3.14.6 with badc and run a slice of its test suite.

Pipeline:
  - ``setup.py`` fetches + extracts the source under ``.cache/Python-3.14.6``.
  - ``./configure`` + ``make`` (host compiler) generate the derived sources
    (the pegen tables, the frozen-module headers, ``Modules/config.c``) and
    a reference ``python`` used only during the build. The per-translation-
    unit compile commands and the final link command are captured from the
    build trace.
  - Each core translation unit is recompiled through badc; the objects are
    linked into ``python`` by badc.
  - The badc-built interpreter runs a baselined slice of the standard
    library test suite.

CPython's object allocator embeds mimalloc, whose per-thread heap tables
use a thread-local pointer initialized with the address of a global -- a
relocation against the TLS template badc does not yet emit. The build is
configured ``--without-mimalloc`` so ``Objects/obmalloc.c`` uses the
pymalloc allocator instead.

POSIX only. macOS is the first supported host; this is not wired into CI
yet.
"""

from __future__ import annotations

import argparse
import os
import re
import shlex
import shutil
import subprocess
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
PY_DIR = Path(__file__).resolve().parent
VERSION = "3.14.6"
SRC = PY_DIR / ".cache" / f"Python-{VERSION}"

# Maximum tolerated test failures. Tightened as the interpreter stabilizes.
BASELINE_FAILURES = 0

# Test-suite slice to run once the interpreter is up. Kept small and
# allocation/codegen-revealing; expanded as the build matures.
TEST_SLICE = [
    "test_grammar",
    "test_builtin",
    "test_int",
    "test_float",
    "test_list",
    "test_dict",
    "test_string",
    "test_exceptions",
]


def run(cmd, **kw):
    # `errors="replace"` keeps the test suite's occasional non-UTF-8
    # output (raised tracebacks, byte strings) from aborting the harness.
    return subprocess.run(
        cmd, capture_output=True, text=True, errors="replace", **kw
    )


def badc_path() -> str:
    p = REPO_ROOT / "target" / "release" / "badc"
    if not p.is_file():
        sys.exit(f"smoke: badc not built at {p} -- run `cargo build --release --features full`")
    return str(p)


def ensure_source(verbose: bool) -> None:
    if (SRC / "configure").is_file():
        return
    r = run([sys.executable, str(PY_DIR / "setup.py")] + (["-v"] if verbose else []))
    if r.returncode != 0:
        sys.stderr.write(r.stdout + r.stderr)
        sys.exit("smoke: setup.py failed")


def host_build(log) -> Path:
    """Configure --without-mimalloc and build with the host compiler.

    Returns the path to the build trace (the per-TU compile + link
    commands). Idempotent: a completed build is reused.
    """
    marker = SRC / ".badc_pymalloc_built"
    trace = SRC / ".badc_build_trace.txt"
    ref_python = SRC / "python"
    if marker.is_file() and ref_python.is_file() and trace.is_file():
        log("host build present, reusing")
        return trace

    # `--without-remote-debug` drops the PEP 768 remote-debugging code,
    # whose macOS path pulls in the Mach-O / mach_vm introspection
    # surface; the configured-out stub satisfies the interpreter's calls.
    args = [
        "./configure",
        "--without-mimalloc",
        "--with-ensurepip=no",
        "--without-remote-debug",
    ]
    if sys.platform == "darwin":
        args.append("--disable-test-modules")
    log(f"configure ({' '.join(args[1:])})")
    r = run(args, cwd=SRC)
    if r.returncode != 0:
        sys.stderr.write(r.stdout + r.stderr)
        sys.exit("smoke: configure failed")

    log("make (host) -- generates derived sources + reference python")
    with trace.open("w") as tf:
        proc = subprocess.run(
            ["make", "-j", str(os.cpu_count() or 4)],
            cwd=SRC,
            stdout=tf,
            stderr=subprocess.STDOUT,
            text=True,
        )
    if proc.returncode != 0 or not ref_python.is_file():
        sys.stderr.write(trace.read_text()[-3000:])
        sys.exit("smoke: host make failed")
    marker.write_text("ok\n")
    return trace


def parse_commands(trace: Path):
    """Return (compile-commands, link-command) from the build trace."""
    text = trace.read_text(errors="replace").replace("\\\n", " ")
    compiles, link = {}, None
    for line in text.splitlines():
        s = line.strip()
        if " -o python " in f" {s} " and s.startswith(("gcc", "clang", "cc")):
            link = s
        if not (s.startswith(("gcc", "clang", "cc")) and " -c " in s):
            continue
        toks = shlex.split(s)
        srcs = [t for t in toks if t.endswith(".c")]
        objs = [toks[i + 1] for i, t in enumerate(toks) if t == "-o" and i + 1 < len(toks)]
        if not srcs or not objs:
            continue
        flags = [t for t in toks if t[:2] in ("-D", "-I", "-U")]
        compiles[objs[0]] = (srcs[-1], flags)
    return compiles, link


def compile_and_link(badc: str, trace: Path, out: Path, log) -> Path:
    compiles, link = parse_commands(trace)
    if link is None:
        sys.exit("smoke: could not find the python link command in the build trace")
    # The link rule lists exactly the objects the interpreter needs.
    link_toks = shlex.split(link)
    link_objs = [t for t in link_toks if t.endswith(".o")]
    log(f"interpreter links {len(link_objs)} objects")

    # BADC_PY_O_ONLY restricts the optimizer to a comma-separated set of
    # source basenames (the rest compile without -O). Used to bisect which
    # translation unit a -O miscompile lives in.
    opt_only = os.environ.get("BADC_PY_O_ONLY")
    opt_only = {n for n in opt_only.split(",") if n} if opt_only else None

    objs, fails = [], []
    for obj in link_objs:
        if obj not in compiles:
            # CPython's perf trampoline ships as a hand-written `.S` the
            # host assembles, so the trace has no C compile command for it.
            # Substitute a position-independent C trampoline badc compiles.
            if obj.endswith("asm_trampoline.o"):
                dst = out / (obj.replace("/", "_"))
                r = run(
                    [badc, "-c", str(PY_DIR / "asm_trampoline.c"), "-o", str(dst)],
                    timeout=120,
                )
                if r.returncode != 0:
                    fails.append((obj, ((r.stderr or r.stdout).strip() or "rc")[:160]))
                else:
                    objs.append(str(dst))
                continue
            fails.append((obj, "no compile command in trace"))
            continue
        src, flags = compiles[obj]
        dst = out / (obj.replace("/", "_"))
        dbg = ["-g"] if os.environ.get("BADC_PY_G") else []
        # Each TU builds with the optimizer (badc -O also implies NDEBUG).
        # The host build trace's own -O flags are dropped by
        # parse_commands, so this is the only optimization control.
        do_opt = opt_only is None or os.path.basename(src) in opt_only
        opt = ["-O"] if do_opt else []
        # `--gnu` mirrors the reference clang build: __GNUC__ makes the
        # struct layouts (packed tracemalloc) match the clang-built
        # extension modules, and the __STRICT_ANSI__ it implies routes
        # Py_ARRAY_LENGTH off __builtin_types_compatible_p.
        cmd = [
            badc, "--gnu", "-c", "-UHAVE_GCC_UINT128_T",
            *dbg, *opt, *flags, str(SRC / src), "-o", str(dst),
        ]
        r = run(cmd, cwd=SRC, timeout=240)
        if r.returncode != 0:
            msg = ((r.stderr or r.stdout).strip().splitlines() or [f"rc{r.returncode}"])[-1]
            fails.append((src, msg[:160]))
        else:
            objs.append(str(dst))

    log(f"compiled {len(objs)} objects, {len(fails)} failures")
    if fails:
        for s, e in fails[:40]:
            print(f"  COMPILE FAIL {s}: {e}", file=sys.stderr)
        sys.exit(f"smoke: {len(fails)} translation unit(s) failed to compile")

    py = out / "python"
    log(f"link -> {py}")
    dbg = ["-g"] if os.environ.get("BADC_PY_G") else []
    # `--export-all` (functions) + `--export-data` (data globals) make
    # the interpreter's C-API resolvable from a dlopen'd extension
    # module, reproducing the reference build's `-Xlinker -export-dynamic`.
    r = run(
        [badc, "--export-all", "--export-data", *dbg, *objs, "-o", str(py)],
        timeout=900,
    )
    if r.returncode != 0:
        sys.stderr.write((r.stderr or r.stdout)[-3000:])
        sys.exit("smoke: link failed")
    return py


def module_search_path() -> str:
    # The standard library lives under the source tree's `Lib/`; the
    # interpreter needs it on the path to import `encodings` (required
    # for stdio). The C extension modules (math, _random, ...) are built
    # as shared objects under the directory named in `pybuilddir.txt`;
    # the reference `python` finds them via that build landmark because it
    # runs from the source tree, but the badc-built interpreter runs from
    # a separate output directory, so the extension directory is added
    # explicitly. The test harness (libregrtest) imports `math` at start.
    parts = [str(SRC / "Lib")]
    builddir = SRC / "pybuilddir.txt"
    if builddir.is_file():
        parts.append(str(SRC / builddir.read_text().strip()))
    return os.pathsep.join(parts)


def smoke_run(py: Path, log) -> None:
    env = dict(os.environ, PYTHONHOME=str(SRC), PYTHONPATH=module_search_path())
    r = run([str(py), "-c", "print(2 + 2)"], env=env, timeout=120)
    if r.returncode != 0 or r.stdout.strip() != "4":
        sys.stderr.write(r.stdout + r.stderr)
        sys.exit("smoke: interpreter failed the `print(2 + 2)` check")
    log("interpreter runs `print(2 + 2)`")

    cmd = [str(py), "-m", "test", "-q", *TEST_SLICE]
    r = run(cmd, cwd=SRC, env=env, timeout=1800)
    out = r.stdout + r.stderr
    failed = len(re.findall(r"^FAILED", out, re.M)) + len(re.findall(r" failures=\d+", out))
    print(f"python: test slice exit={r.returncode} (baseline failures {BASELINE_FAILURES})")
    if r.returncode != 0:
        sys.stderr.write(out[-3000:])
        sys.exit("smoke: test slice failed")


def main(argv: list[str] | None = None) -> int:
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("-v", "--verbose", action="store_true")
    p.add_argument("--compile-only", action="store_true", help="stop after compile + link")
    args = p.parse_args(argv)

    if os.name != "posix" or sys.platform.startswith("win"):
        print("python smoke skipped (POSIX-only build)")
        return 0

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    badc = badc_path()
    ensure_source(args.verbose)
    trace = host_build(log)
    out = PY_DIR / ".cache" / "obj"
    if out.exists():
        shutil.rmtree(out)
    out.mkdir(parents=True, exist_ok=True)

    py = compile_and_link(badc, trace, out, log)
    if args.compile_only:
        print("python smoke OK (compile + link)")
        return 0
    smoke_run(py, log)
    print("python smoke OK")
    return 0


if __name__ == "__main__":
    sys.exit(main())
