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


# Output-file extensions nasm writes NF_TEXT (so CRLF on Windows): `-E`
# preprocessed (`.i`), `-l` listings (`.lst`), and the OFMT_TEXT object formats
# (Intel-hex, S-records, debug, ieee). Object output (bin/obj/elf/...) is
# NF_BINARY -- LF on every host -- and must not be touched. Their golden is
# `<output>.t`; stderr/stdout diagnostics are always text (`<name>.stderr/.stdout`).
TEXT_OUTPUT_EXTS = ("i", "lst", "ith", "srec", "dbg", "ieee")


def adapt_fixtures(target: str) -> None:
    """Adapt the fetched golden suite to the target so nasm-t.py runs unmodified
    and its abort-on-failure still gates real bugs. On native Windows the
    badc-built nasm emits CRLF in its text outputs (the Windows CRT opens
    text-mode files that way, as for any Windows C program), so a byte comparison
    against an LF golden fails on line endings alone. This is not a codegen
    difference, so rewrite the text goldens to CRLF rather than dropping the
    cases, which keeps full coverage: a real diagnostic or listing regression
    (wrong message, line, byte, or count) still fails the comparison.

    The other POSIX/Windows divergence, the `/` vs `\\` path separator nasm
    echoes into both its text and its binary outputs, is corrected upstream of
    nasm by the `nasmw` launcher (see `build_nasm_wrapper`), so it needs no
    golden rewrite and needs no per-case removal.

    Idempotent: normalizing CRLF to LF before converting makes a second pass over
    an already-adapted tree a no-op."""
    if not target.startswith("windows"):
        return
    tdir = SRC / "travis" / "test"
    goldens = list(tdir.glob("*.stderr")) + list(tdir.glob("*.stdout"))
    for ext in TEXT_OUTPUT_EXTS:
        goldens += tdir.glob(f"*.{ext}.t")
    for p in goldens:
        data = p.read_bytes()
        crlf = data.replace(b"\r\n", b"\n").replace(b"\n", b"\r\n")
        if crlf != data:
            p.write_bytes(crlf)


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
    opt = ["-O"] if optimize else []
    # The library TUs share one flag set, so archive them in a single
    # invocation: badc compiles them concurrently (see `--jobs`) and
    # bundles the objects into libnasm.a.
    lib = workdir / "libnasm.a"
    r = subprocess.run([str(badc), f"--target={target}", "--ar", "-o", str(lib),
                        *inc, *opt, *[str(SRC / rel) for rel in SOURCES]],
                       capture_output=True, text=True)
    if r.returncode != 0 or not lib.is_file():
        fail(f"badc failed to archive libnasm:\n{r.stderr.strip()[-800:]}")
    # Compile MAIN in the link invocation and resolve it against the archive.
    binp = workdir / ("nasm" + EXE)
    r = subprocess.run([str(badc), f"--target={target}", *inc, *opt,
                        str(SRC / MAIN), str(lib), "-o", str(binp)],
                       capture_output=True, text=True)
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


def build_nasm_wrapper(badc: Path, workdir: Path) -> str:
    """Build the `nasmw` launcher with badc (Windows only). nasm-t.py joins the
    source and output paths with `os.sep`; on native Windows that `\\` is echoed
    into nasm's text and object output and breaks the POSIX-recorded goldens. The
    launcher rewrites it to `/` before invoking the real nasm (named by
    $NASM_REAL), so the vendored harness and goldens stay unmodified."""
    workdir.mkdir(parents=True, exist_ok=True)
    exe = workdir / ("nasmw" + EXE)
    r = subprocess.run([str(badc), str(NASM_DEMO / "nasmw.c"), "-o", str(exe)],
                       capture_output=True, text=True)
    if r.returncode != 0 or not exe.is_file():
        fail(f"badc failed to build nasmw:\n{r.stderr.strip()[-800:]}")
    return str(exe)


def run_golden_suite(nasm: Path, hexdump: str,
                     wrapper: "str | None" = None) -> tuple[int, list[str]]:
    """Run NASM's golden suite against `nasm`. The `./travis/test` base-dir
    matches the source-path prefix the goldens were recorded with. `hexdump` is
    the `hexdump -C` program nasm-t.py uses to render diffs. When `wrapper` is
    given (native Windows), the harness invokes it instead of nasm and it is
    pointed at the real nasm via $NASM_REAL; see `build_nasm_wrapper`. Returns
    (pass count, failures outside SKIP_TESTS).

    `$NASM_TEST_PYTHON` selects the interpreter that runs the suite harness;
    pointing it at a badc-built CPython drives a badc-built assembler with a
    badc-built interpreter (self-hosting cross-check). Defaults to the host
    python. `$NASM_TEST_PYTHONHOME`, if set, supplies that interpreter's
    stdlib (PYTHONHOME + PYTHONPATH=<home>/Lib) -- scoped to this subprocess
    so the outer host python is unaffected."""
    runner = os.environ.get("NASM_TEST_PYTHON") or sys.executable
    env = dict(os.environ)
    harness_nasm = str(nasm)
    if wrapper:
        harness_nasm = wrapper
        env["NASM_REAL"] = str(nasm)
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
            [runner, "travis/nasm-t.py", "--nasm", harness_nasm, "--hexdump", hexdump,
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
    adapt_fixtures(target)
    ensure_config(target)
    with tempfile.TemporaryDirectory(prefix="nasm-smoke-") as d:
        work = Path(d)
        hexdump = build_hexdump(badc, work / "hexdump")
        wrapper = build_nasm_wrapper(badc, work / "nasmw") if IS_WIN else None
        for optimize in (False, True):
            lane = "-O" if optimize else "-O0"
            log(f"building nasm with badc [{lane}]")
            nasm = build_nasm(badc, target, optimize, work / lane.strip("-"))
            ver = subprocess.run([str(nasm), "-v"], capture_output=True, text=True)
            if "NASM version" not in ver.stdout:
                fail(f"badc-built nasm [{lane}] does not report a version")
            log(f"running NASM's golden test suite [{lane}]")
            passes, unexpected = run_golden_suite(nasm, hexdump, wrapper)
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
