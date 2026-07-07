#!/usr/bin/env python3
"""Build tclsh 8.6.14 with badc and run the Tcl test suite.

Pipeline:
  - ``setup.py`` fetches + extracts the source under ``.cache/tcl8.6.14``.
  - ``unix/configure`` generates the Makefile; ``make -n binaries`` yields
    the per-translation-unit compile commands, which are replayed through
    badc, plus the bundled zlib the Makefile skips when configured against
    a system libz.
  - badc links the objects into ``tclsh``.
  - ``tests/all.tcl`` runs the suite; the total failure count is checked
    against a pinned baseline so a codegen regression fails the smoke.

POSIX only (the build runs ``configure`` + ``make``). Linux is the
supported host; the CI lane and ``validate_local_boxes`` invoke it there.
"""

from __future__ import annotations

import argparse
import os
import re
import shlex
import subprocess
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
TCL_DIR = Path(__file__).resolve().parent
VERSION = "8.6.14"
SRC = TCL_DIR / ".cache" / f"tcl{VERSION}"

# Bundled zlib units tclZlib references; the Makefile omits them when Tcl
# is configured against a system libz.
ZLIB_UNITS = (
    "adler32 compress crc32 deflate infback inffast inflate inftrees "
    "trees uncompr zutil"
).split()

# Maximum total test failures tolerated. The suite is green with badc; a
# regression that raises the count fails the smoke.
BASELINE_FAILURES = 0


def run(cmd, **kw):
    return subprocess.run(cmd, capture_output=True, text=True, **kw)


def badc_path() -> str:
    p = REPO_ROOT / "target" / "release" / "badc"
    if not p.is_file():
        sys.exit(f"smoke: badc not built at {p} -- run `cargo build --release --features full`")
    return str(p)


def ensure_source(verbose: bool) -> None:
    if (SRC / "unix" / "configure").is_file():
        return
    r = run([sys.executable, str(TCL_DIR / "setup.py")] + (["-v"] if verbose else []))
    if r.returncode != 0:
        sys.stderr.write(r.stdout + r.stderr)
        sys.exit("smoke: setup.py failed")


def configure(unix: Path, log) -> None:
    if (unix / "Makefile").is_file():
        log("configure: Makefile present, skipping")
        return
    args = ["./configure"]
    if sys.platform == "darwin":
        # Build the pure-POSIX interpreter on macOS: the CoreFoundation
        # path pulls in the macOS framework notifier and bundle code,
        # which is outside the C / POSIX surface this demo exercises.
        args.append("--disable-corefoundation")
    log(f"configure ({' '.join(args[1:]) or 'default'})")
    r = run(args, cwd=unix)
    if r.returncode != 0:
        sys.stderr.write(r.stdout + r.stderr)
        sys.exit("smoke: configure failed")


def compile_units(badc: str, unix: Path, generic: Path, out: Path, log) -> list[str]:
    """Replay the Makefile's compile commands through badc."""
    trace = run(["make", "-n", "-B", "binaries"], cwd=unix).stdout.replace("\\\n", " ")
    cmds, seen = [], set()
    for line in trace.splitlines():
        s = line.strip()
        if not (s.startswith("gcc ") and " -c " in s):
            continue
        try:
            toks = shlex.split(s)
        except ValueError:
            continue
        srcs = [t for t in toks if t.endswith(".c")]
        if not srcs:
            continue
        src = srcs[-1]
        flags = [t for t in toks if t[:2] in ("-D", "-I", "-U")]
        obj = Path(src).stem
        if obj in seen:
            obj = f"{obj}_{len(cmds)}"
        seen.add(obj)
        cmds.append((src, obj, flags))
    log(f"compile commands: {len(cmds)}")

    includes = ["-I" + str(p) for p in (unix, generic, SRC / "compat" / "zlib", SRC / "libtommath")]
    # configure detects TCL_LOAD_FROM_MEMORY from the macOS SDK's
    # <mach-o/dyld.h>, which exposes the deprecated NSModule loader.
    # Modern macOS loads extensions via dlopen (TCL_DYLD_USE_DLFCN);
    # undefine the macro so tclLoadDyld.c takes the dlfcn path.
    extra = ["-UTCL_LOAD_FROM_MEMORY"] if sys.platform == "darwin" else []
    if os.environ.get("BADC_TCL_DEBUG"):
        extra.append("-g")
    objs, fails = [], []
    for src, obj, flags in cmds:
        objp = out / f"{obj}.o"
        cmd = [badc, "-O", "-c", "-UHAVE_CPUID", *extra, *flags, *includes, src, "-o", str(objp)]
        r = run(cmd, timeout=180)
        if r.returncode != 0:
            msg = (r.stderr.strip().splitlines() or [f"rc{r.returncode}"])[-1]
            fails.append((Path(src).name, msg[:160]))
        else:
            objs.append(str(objp))

    # Bundled zlib (configured against system libz, so `make` skips it).
    zdir = SRC / "compat" / "zlib"
    zflags = ["-DHAVE_ZLIB=1", "-DBUILD_tcl", "-DSTDC", "-I" + str(zdir)]
    for name in ZLIB_UNITS:
        objp = out / f"Z{name}.o"
        r = run([badc, "-O", "-c", *zflags, str(zdir / f"{name}.c"), "-o", str(objp)], timeout=180)
        if r.returncode != 0:
            fails.append((f"zlib {name}", (r.stderr.strip().splitlines() or ["rc"])[-1][:160]))
        else:
            objs.append(str(objp))

    log(f"compiled {len(objs)} objects, {len(fails)} failures")
    if fails:
        for s, e in fails[:30]:
            print(f"  COMPILE FAIL {s}: {e}", file=sys.stderr)
        sys.exit(f"smoke: {len(fails)} translation unit(s) failed to compile")
    return objs


def link(badc: str, objs: list[str], out: Path, log) -> Path:
    tclsh = out / "tclsh"
    log(f"link {len(objs)} objects -> {tclsh}")
    dbg = ["-g"] if os.environ.get("BADC_TCL_DEBUG") else []
    r = run([badc, *dbg, *objs, "-o", str(tclsh)], timeout=600)
    if r.returncode != 0:
        sys.stderr.write((r.stderr or r.stdout)[-2000:])
        sys.exit("smoke: link failed")
    return tclsh


def run_suite(tclsh: Path, log) -> None:
    tests = SRC / "tests"
    library = SRC / "library"
    env = dict(os.environ, TCL_LIBRARY=str(library))
    log("running tests/all.tcl")
    r = subprocess.run(
        [str(tclsh), str(tests / "all.tcl")],
        cwd=tests,
        capture_output=True,
        text=True,
        env=env,
        timeout=1800,
    )
    out = r.stdout + r.stderr
    # tcltest prints a per-file `Failed N` line and a final aggregate; sum
    # the per-file counts so a single file's regression is caught even when
    # the aggregate line is absent.
    failed = sum(int(m) for m in re.findall(r"Total\s+\d+\s+Passed\s+\d+\s+Skipped\s+\d+\s+Failed\s+(\d+)", out))
    files = len(re.findall(r"Total\s+\d+\s+Passed", out))
    print(f"tcl: {files} test files run, {failed} failures (baseline {BASELINE_FAILURES})")
    if failed > BASELINE_FAILURES:
        # Surface the failing test names for triage.
        for line in out.splitlines():
            if "FAILED" in line:
                print("  " + line)
        sys.exit(f"smoke: {failed} test failures exceed baseline {BASELINE_FAILURES}")
    if files == 0:
        sys.stderr.write(out[-2000:])
        sys.exit("smoke: no test files ran")


def main(argv: list[str] | None = None) -> int:
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("-v", "--verbose", action="store_true")
    args = p.parse_args(argv)

    if os.name != "posix" or sys.platform.startswith("win"):
        print("tcl smoke skipped (POSIX-only build)")
        return 0

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    badc = badc_path()
    ensure_source(args.verbose)
    unix, generic = SRC / "unix", SRC / "generic"
    out = TCL_DIR / ".cache" / "obj"
    out.mkdir(parents=True, exist_ok=True)

    configure(unix, log)
    objs = compile_units(badc, unix, generic, out, log)
    tclsh = link(badc, objs, out, log)
    run_suite(tclsh, log)
    print("tcl smoke OK")
    return 0


if __name__ == "__main__":
    sys.exit(main())
