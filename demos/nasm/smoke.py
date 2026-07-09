#!/usr/bin/env python3
"""End-to-end smoke for badc against the NASM 2.16.03 assembler.

Builds the `nasm` program by compiling a fixed translation-unit list directly
with badc -- no `make`, matching the python demo -- then runs NASM's own
golden test suite (`travis/nasm-t.py`, 258 checks) against the badc-built
assembler. The suite compiles each fixture with the produced nasm and compares
the emitted object bytes / listings / diagnostics against committed golden
files, so it is a self-validating correctness oracle: no reference build is
needed.

The NASM release tarball ships the generated instruction tables, `version.h`,
and `version.mac`; the only file a pristine tree lacks is `config/config.h`,
installed here from a frozen per-target config committed under `config/` (no
`./configure`, so no POSIX shell and no host cc -- native Windows included).
badc's capability profile is fixed, so the config is a constant: a POSIX form
and a Windows form (see `ensure_config`).

Runs on both `-O0` and `-O`, on all five supported targets. Override the badc
binary via `$BADC` (default: `target/release/badc[.exe]`).
"""

from __future__ import annotations

import os
import platform
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

NASM_DEMO = Path(__file__).resolve().parent
REPO_ROOT = NASM_DEMO.parents[1]
SRC = NASM_DEMO / "src"

# The `nasm` program's translation units, minus the `asm/nasm.c` main (linked
# separately). The conditional `stdlib/*` fallbacks guard their bodies on the
# matching HAVE_* macro, so compiling them always is harmless.
SOURCES = [
    "asm/assemble.c", "asm/directbl.c", "asm/directiv.c", "asm/error.c",
    "asm/eval.c", "asm/exprdump.c", "asm/exprlib.c", "asm/floats.c",
    "asm/labels.c", "asm/listing.c", "asm/parser.c", "asm/pptok.c",
    "asm/pragma.c", "asm/preproc.c", "asm/quote.c", "asm/rdstrnum.c",
    "asm/segalloc.c", "asm/srcfile.c", "asm/stdscan.c", "asm/strfunc.c",
    "asm/tokhash.c", "asm/warnings.c", "common/common.c", "disasm/disasm.c",
    "disasm/sync.c", "macros/macros.c", "nasmlib/alloc.c", "nasmlib/asprintf.c",
    "nasmlib/badenum.c", "nasmlib/bsi.c", "nasmlib/crc32.c", "nasmlib/crc64.c",
    "nasmlib/errfile.c", "nasmlib/file.c", "nasmlib/filename.c",
    "nasmlib/hashtbl.c", "nasmlib/ilog2.c", "nasmlib/md5c.c", "nasmlib/mmap.c",
    "nasmlib/nctype.c", "nasmlib/numstr.c", "nasmlib/path.c",
    "nasmlib/perfhash.c", "nasmlib/raa.c", "nasmlib/rbtree.c",
    "nasmlib/readnum.c", "nasmlib/realpath.c", "nasmlib/rlimit.c",
    "nasmlib/saa.c", "nasmlib/string.c", "nasmlib/strlist.c", "nasmlib/ver.c",
    "nasmlib/zerobuf.c", "output/codeview.c", "output/legacy.c",
    "output/nulldbg.c", "output/nullout.c", "output/outaout.c",
    "output/outas86.c", "output/outbin.c", "output/outcoff.c",
    "output/outdbg.c", "output/outelf.c", "output/outform.c",
    "output/outieee.c", "output/outlib.c", "output/outmacho.c",
    "output/outobj.c", "stdlib/snprintf.c", "stdlib/strlcpy.c",
    "stdlib/strnlen.c", "stdlib/strrchrnul.c", "stdlib/vsnprintf.c",
    "x86/disp8.c", "x86/iflag.c", "x86/insnsa.c", "x86/insnsb.c",
    "x86/insnsd.c", "x86/insnsn.c", "x86/regdis.c", "x86/regflags.c",
    "x86/regs.c", "x86/regvals.c",
]
MAIN = "asm/nasm.c"
INC_DIRS = [".", "include", "config", "x86", "asm", "disasm", "output"]

# `_version` embeds the assembler's compile date in its output, which a fresh
# build here does not match the golden of; it is not a codegen signal. Other
# platform-specific cases (e.g. `_file_` on Windows) are removed from the fetched
# suite by `curate_fixtures` so the harness runs unmodified. Every remaining
# golden case is deterministic once nasm is invoked with the base-dir prefix the
# goldens were recorded with (`./travis/test/...`).
SKIP_TESTS = {"_version"}

IS_WIN = sys.platform == "win32"
EXE = ".exe" if IS_WIN else ""


def log(m: str) -> None:
    print(f"nasm smoke: {m}", flush=True)


def fail(m: str) -> "None":
    print(f"nasm smoke FAIL: {m}", file=sys.stderr, flush=True)
    sys.exit(1)


def resolve_badc() -> Path:
    env = os.environ.get("BADC")
    cands = [Path(env)] if env else []
    default = REPO_ROOT / "target" / "release" / "badc"
    cands += [default, default.with_suffix(".exe")]
    for c in cands:
        if c.is_file() and os.access(c, os.X_OK):
            return c
    fail("BADC binary not found; hint: cargo build --release --features full")
    raise SystemExit(2)


def badc_target() -> str:
    mach = platform.machine().lower()
    aarch = mach in ("arm64", "aarch64")
    if sys.platform == "darwin":
        return "macos-aarch64" if aarch else "macos-x64"
    if IS_WIN:
        return "windows-arm64" if aarch else "windows-x64"
    return "linux-aarch64" if aarch else "linux-x64"


def ensure_source() -> None:
    if (SRC / "x86" / "insnsa.c").is_file() and (SRC / "version.mac").is_file():
        return
    log("fetching NASM source via setup.py")
    subprocess.run([sys.executable, str(NASM_DEMO / "setup.py")], check=True)


def curate_fixtures(target: str) -> None:
    """Remove test cases that cannot apply on the target from the fetched suite,
    so nasm-t.py runs unmodified and its abort-on-failure still gates real bugs.
    `_file_` emits `__FILE__` (the source path as passed to nasm), whose golden
    bytes carry the recording host's path separator and cannot match on Windows
    (`\\` vs `/`)."""
    inapplicable = ["_file_"] if target.startswith("windows") else []
    tdir = SRC / "travis" / "test"
    for stem in inapplicable:
        for p in tdir.glob(stem + ".*"):
            p.unlink()


def ensure_config(target: str) -> None:
    """Install src/config/config.h from a frozen per-target config -- no
    `./configure`, so no POSIX shell and no host cc are needed (native Windows
    included). `./configure`'s job is capability detection, but badc's profile
    is fixed, so the answer is a committed constant. Two forms cover the five
    targets: the POSIX form (macOS / Linux) and the Windows form, which is the
    POSIX form minus the five POSIX-only libc entries badc's msvcrt binding
    does not provide (fseeko, ftruncate, getpagesize, mmap, realpath); NASM
    falls back to its portable paths for those. Both forms also disable
    `HAVE_FUNC_ATTRIBUTE_ERROR`: badc accepts but ignores attribute(error), so
    NASM's `-O` compile-time-assert tripwire would otherwise leave a dead call
    to an undefined symbol."""
    kind = "windows" if target.startswith("windows") else "posix"
    frozen = NASM_DEMO / "config" / f"config-{kind}.h"
    if not frozen.is_file():
        fail(f"frozen config missing: {frozen}")
    dst = SRC / "config" / "config.h"
    dst.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(frozen, dst)
    log(f"config: frozen {kind} ({target})")


def build_nasm(badc: Path, target: str, optimize: bool, workdir: Path) -> Path:
    """Compile SOURCES + MAIN with badc and link `nasm` with badc's own linker
    (archive the library objects, link the main against them)."""
    workdir.mkdir(parents=True, exist_ok=True)
    inc = [f"-I{SRC / d}" for d in INC_DIRS] + ["-DHAVE_CONFIG_H"]
    objs = []
    for rel in SOURCES + [MAIN]:
        out = workdir / (rel.replace("/", "_")[:-2] + ".o")
        cmd = [str(badc), f"--target={target}", "-c", *inc] + \
            (["-O"] if optimize else []) + [str(SRC / rel), "-o", str(out)]
        r = subprocess.run(cmd, capture_output=True, text=True)
        if r.returncode != 0 or not out.is_file():
            fail(f"badc failed to compile {rel}:\n{r.stderr.strip()[-800:]}")
        objs.append(out)
    main_o = str(workdir / (MAIN.replace("/", "_")[:-2] + ".o"))
    lib = workdir / "libnasm.a"
    subprocess.run([str(badc), "--ar", "-o", str(lib),
                    *[str(o) for o in objs if str(o) != main_o]],
                   check=True, capture_output=True)
    binp = workdir / ("nasm" + EXE)
    r = subprocess.run([str(badc), f"--target={target}", main_o, str(lib),
                        "-o", str(binp)], capture_output=True, text=True)
    if r.returncode != 0 or not binp.is_file():
        fail(f"badc failed to link nasm:\n{r.stderr.strip()[-800:]}")
    if not IS_WIN:
        binp.chmod(0o755)
    return binp


def build_hexdump(badc: Path, workdir: Path) -> str:
    """Build the `hexdump -C` shim with badc. nasm-t.py `Popen`s the hexdump to
    render byte diffs on a failing test; native Windows ships no hexdump, and a
    batch wrapper is not directly `Popen`-able, so compile a real executable."""
    workdir.mkdir(parents=True, exist_ok=True)
    exe = workdir / ("hexdump" + EXE)
    subprocess.run([str(badc), str(NASM_DEMO / "hexdump.c"), "-o", str(exe)],
                   check=True, capture_output=True)
    return str(exe)


def run_golden_suite(nasm: Path, hexdump: str) -> tuple[int, list[str]]:
    """Run NASM's golden suite against `nasm`. The `./travis/test` base-dir
    matches the source-path prefix the goldens were recorded with. `hexdump` is
    the `hexdump -C` program nasm-t.py uses to render diffs. Returns
    (pass count, failures outside SKIP_TESTS).

    `$NASM_TEST_PYTHON` selects the interpreter that runs the suite harness;
    pointing it at a badc-built CPython drives a badc-built assembler with a
    badc-built interpreter (self-hosting cross-check). Defaults to the host
    python. `$NASM_TEST_PYTHONHOME`, if set, supplies that interpreter's
    stdlib (PYTHONHOME + PYTHONPATH=<home>/Lib) -- scoped to this subprocess
    so the outer host python is unaffected."""
    runner = os.environ.get("NASM_TEST_PYTHON") or sys.executable
    env = dict(os.environ)
    home = os.environ.get("NASM_TEST_PYTHONHOME")
    if home:
        env["PYTHONHOME"] = home
        env["PYTHONPATH"] = str(Path(home) / "Lib")
    # A defensive timeout so a harness hang fails in minutes with its captured
    # output, never running out the CI job's wall clock. A full run (~280 cases,
    # each spawning nasm) is well under this even on Windows; the suite runs
    # twice (-O0, -O), so 2x300 s + builds stays inside the 12-min job backstop.
    try:
        r = subprocess.run(
            [runner, "travis/nasm-t.py", "--nasm", str(nasm), "--hexdump", hexdump,
             "-d", "./travis/test", "run"],
            cwd=SRC, env=env, capture_output=True, text=True, timeout=300)
    except subprocess.TimeoutExpired as e:
        partial = (e.stdout or "") + (e.stderr or "")
        fail(f"golden suite timed out after 300s (harness hang):\n{partial[-2000:]}")
    out = r.stdout + r.stderr
    passes = len(re.findall(r"=== Test \S+ PASS ===", out))
    # nasm-t.py prints the test path with the host separator (`\` on Windows).
    failed = re.findall(r"=== Test \./travis[\\/]test[\\/](\S+) (?:FAIL|ABORT) ===", out)
    unexpected = sorted(f for f in set(failed) if f not in SKIP_TESTS)
    # A valid run passes hundreds of cases; zero means the harness did not run
    # them (not a clean sweep). Surface its output so the cause is visible.
    if passes == 0:
        fail(f"golden suite produced no passing checks:\n{out[-3000:]}")
    return passes, unexpected


def main() -> int:
    badc = resolve_badc()
    target = badc_target()
    log(f"badc={badc} target={target}")
    ensure_source()
    curate_fixtures(target)
    ensure_config(target)
    with tempfile.TemporaryDirectory(prefix="nasm-smoke-") as d:
        work = Path(d)
        hexdump = build_hexdump(badc, work / "hexdump")
        for optimize in (False, True):
            lane = "-O" if optimize else "-O0"
            log(f"building nasm with badc [{lane}]")
            nasm = build_nasm(badc, target, optimize, work / lane.strip("-"))
            ver = subprocess.run([str(nasm), "-v"], capture_output=True, text=True)
            if "NASM version" not in ver.stdout:
                fail(f"badc-built nasm [{lane}] does not report a version")
            log(f"running NASM's golden test suite [{lane}]")
            passes, unexpected = run_golden_suite(nasm, hexdump)
            if unexpected:
                fail(f"golden suite [{lane}]: {len(unexpected)} unexpected "
                     f"failure(s): {unexpected[:20]}")
            log(f"golden suite [{lane}]: {passes} checks pass "
                f"(skipped {sorted(SKIP_TESTS)})")
            log(f"smoke OK [{lane}]")
    log("all lanes green")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
