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

Each run gets its own working directory and its own process group, so a
run that times out is killed whole rather than leaving an interpreter
behind, and no two runs share the scratch space tcltest writes into.

POSIX only (the build runs ``configure`` + ``make``). Linux is the
supported host; the CI lane and ``validate_local_boxes`` invoke it there.
On darwin the tests in ``DARWIN_SKIP`` are skipped for the reason
recorded there.
"""

from __future__ import annotations

import argparse
import os
import re
import shlex
import shutil
import signal
import subprocess
import sys
import tempfile
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

SUITE_TIMEOUT = 1800

# unixFCmd-2.4 copies a FIFO, and Tcl then hands the pair to macOS's
# copyfile(3) in TclMacOSXCopyFileAttributes. copyfile_set_dst_permissions
# opens the destination, and open() on a FIFO blocks until the other end is
# opened, which nothing does -- so the suite stops there at 0% CPU. The
# same block occurs in a tclsh built by the system compiler, and in a C
# program that calls copyfile() over two FIFOs with the flags
# tclMacOSXFCmd.c passes, so no badc-generated code is involved.
DARWIN_SKIP = ("unixFCmd-2.4",)


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
        cmd = [badc, "-O", "-c", *extra, *flags, *includes, src, "-o", str(objp)]
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


def kill_group(proc: subprocess.Popen) -> None:
    """Kill the interpreter and everything it started."""
    try:
        os.killpg(os.getpgid(proc.pid), signal.SIGKILL)
    except (ProcessLookupError, PermissionError):
        proc.kill()
    try:
        proc.wait(timeout=30)
    except subprocess.TimeoutExpired:
        pass


def run_suite(tclsh: Path, log) -> None:
    tests = SRC / "tests"
    library = SRC / "library"
    env = dict(os.environ, TCL_LIBRARY=str(library))
    # tcltest puts its scratch files in the working directory under fixed
    # names (tf1, tf2, ...) and deletes them between files, so two runs
    # sharing one delete each other's and report failures belonging to
    # neither. A directory a previous run may still hold is therefore not
    # reused: a timed-out run can leave an interpreter behind. all.tcl
    # takes its test files from its own location, so the working directory
    # is free to be a fresh one. It stays beside the sources: fCmd.test
    # sets its `xdev` constraint from the working directory's device
    # against /tmp's, so a working directory on /tmp skips six tests.
    runs = TCL_DIR / ".cache" / "runs"
    runs.mkdir(parents=True, exist_ok=True)
    work = Path(tempfile.mkdtemp(prefix=f"{os.getpid()}-", dir=runs))
    cmd = [str(tclsh), str(tests / "all.tcl")]
    if sys.platform == "darwin":
        cmd += ["-skip", " ".join(DARWIN_SKIP)]
        log(f"skipping on darwin: {' '.join(DARWIN_SKIP)}")
    log(f"running tests/all.tcl in {work}")
    # Its own process group. tcltest runs each test file in a child
    # interpreter, so killing the process this starts leaves that child
    # orphaned and still holding the working directory; the group is what
    # has to be killed.
    proc = subprocess.Popen(
        cmd,
        cwd=work,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
        env=env,
        start_new_session=True,
    )
    try:
        out, _ = proc.communicate(timeout=SUITE_TIMEOUT)
    except subprocess.TimeoutExpired:
        kill_group(proc)
        out, _ = proc.communicate()
        sys.stderr.write((out or "")[-2000:])
        sys.exit(f"smoke: test suite did not finish in {SUITE_TIMEOUT}s "
                 f"(working directory {work})")
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
        sys.exit(f"smoke: {failed} test failures exceed baseline "
                 f"{BASELINE_FAILURES} (working directory {work})")
    if files == 0:
        sys.stderr.write(out[-2000:])
        sys.exit(f"smoke: no test files ran (working directory {work})")
    # Kept on every failure above, for triage.
    shutil.rmtree(work, ignore_errors=True)


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
