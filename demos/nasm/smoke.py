#!/usr/bin/env python3
"""End-to-end smoke for badc against the NASM 3.02 assembler.

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

import json
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
    "asm/getbool.c", "asm/labels.c", "asm/listing.c", "asm/parser.c",
    "asm/pptok.c", "asm/pragma.c", "asm/preproc.c", "asm/quote.c",
    "asm/rdstrnum.c", "asm/segalloc.c", "asm/srcfile.c", "asm/stdscan.c",
    "asm/strfunc.c", "asm/tokhash.c", "asm/uncompress.c", "asm/warnings.c",
    "common/common.c", "common/errstubs.c", "disasm/disasm.c",
    "disasm/diserror.c", "disasm/prefix.c", "disasm/sync.c",
    "macros/macros.c", "nasmlib/alloc.c", "nasmlib/asprintf.c",
    "nasmlib/badenum.c", "nasmlib/bsi.c", "nasmlib/crc32b.c",
    "nasmlib/crc64.c", "nasmlib/file.c", "nasmlib/fileio.c",
    "nasmlib/hashtbl.c", "nasmlib/ilog2.c", "nasmlib/md5c.c", "nasmlib/mmap.c",
    "nasmlib/nctype.c", "nasmlib/numstr.c", "nasmlib/path.c",
    "nasmlib/perfhash.c", "nasmlib/raa.c", "nasmlib/rbtree.c",
    "nasmlib/readnum.c", "nasmlib/realpath.c", "nasmlib/rlimit.c",
    "nasmlib/saa.c", "nasmlib/string.c", "nasmlib/strlist.c", "nasmlib/ver.c",
    "nasmlib/zerobuf.c", "output/codeview.c", "output/nulldbg.c",
    "output/nullout.c", "output/outaout.c", "output/outas86.c",
    "output/outbin.c", "output/outcoff.c", "output/outdbg.c",
    "output/outelf.c", "output/outform.c", "output/outieee.c",
    "output/outlib.c", "output/outmacho.c", "output/outobj.c",
    "stdlib/snprintf.c", "stdlib/strlcpy.c", "stdlib/strnlen.c",
    "stdlib/vsnprintf.c", "x86/iflag.c", "x86/insnsa.c", "x86/insnsb.c",
    "x86/insnsd.c", "x86/insnsn.c", "x86/regdis.c", "x86/regflags.c",
    "x86/regs.c", "x86/regvals.c", "zlib/adler32.c", "zlib/crc32.c",
    "zlib/infback.c", "zlib/inffast.c", "zlib/inflate.c", "zlib/inftrees.c",
    "zlib/zutil.c",
]
MAIN = "asm/nasm.c"
INC_DIRS = [".", "include", "config", "x86", "asm", "disasm", "output", "zlib"]

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


def pinned_version() -> str:
    """The NASM release setup.py pins."""
    text = (NASM_DEMO / "setup.py").read_text(encoding="utf-8")
    return re.search(r'^VERSION = "([^"]+)"', text, re.M).group(1)


def ensure_source() -> None:
    # A tree extracted for an earlier pin is replaced, not built.
    stamp = SRC / "version"
    if (
        (SRC / "x86" / "insnsa.c").is_file()
        and (SRC / "version.mac").is_file()
        and stamp.is_file()
        and stamp.read_text(encoding="utf-8").strip() == pinned_version()
    ):
        return
    log("fetching NASM source via setup.py")
    subprocess.run([sys.executable, str(NASM_DEMO / "setup.py")], check=True)


# Output-file extensions nasm writes NF_TEXT (so CRLF on Windows): `-E`
# preprocessed (`.i`), `-l` listings (`.lst`), and the OFMT_TEXT object formats
# (Intel-hex, S-records, debug, ieee). Object output (bin/obj/elf/...) is
# NF_BINARY -- LF on every host -- and must not be touched. Their golden is
# `<output>.t`; stderr/stdout diagnostics are always text (`<name>.stderr/.stdout`).
TEXT_OUTPUT_EXTS = ("i", "lst", "ith", "srec", "dbg", "ieee")


def preprocessed_goldens(tdir: Path) -> list[Path]:
    """The goldens of `-E` / `-e` cases, whose output nasm writes as text
    whatever its extension. A case naming `ref` takes that case's fields, as
    nasm-t.py expands it."""
    goldens = []
    for path in tdir.glob("*.json"):
        cases = json.loads(path.read_text())
        cases = cases if isinstance(cases, list) else [cases]
        ids = {c["id"]: c for c in cases if "id" in c}
        for case in cases:
            case = {**ids.get(case.get("ref"), {}), **case}
            opts = case.get("option", "").split()
            for t in case.get("target", []):
                if "output" in t and {"-E", "-e"} & {*opts, *t.get("option", "").split()}:
                    goldens.append(tdir / t.get("match", t["output"] + ".t"))
    return goldens


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
    goldens += preprocessed_goldens(tdir)
    for p in set(goldens):
        data = p.read_bytes()
        crlf = data.replace(b"\r\n", b"\n").replace(b"\n", b"\r\n")
        if crlf != data:
            p.write_bytes(crlf)


def write_version_golden() -> None:
    """Write the `_version` golden, which the release does not ship, as
    Makefile.in's `travis_version` rule does: the version, and `?` for the
    compile date the case's filter replaces. It stays LF on Windows, where the
    filter's `\\S.*$` also takes the CR."""
    ver = (SRC / "version").read_text().strip()
    golden = SRC / "travis" / "test" / "_version.stdout"
    golden.write_bytes(f"NASM version {ver} compiled on ?\n".encode())


def ensure_config(target: str) -> None:
    """Install src/config/config.h from a frozen per-target config -- no
    `./configure`, so no POSIX shell and no host cc are needed (native Windows
    included). `./configure`'s job is capability detection, but badc's profile
    is fixed, so the answer is a committed constant: `./configure CC=badc`
    output. Two forms cover the five targets: the POSIX form (macOS / Linux,
    each naming the byte-order headers its C library ships) and the Windows
    form, which is the POSIX form minus the headers mingw-w64 does not ship
    (<arpa/inet.h>, the byte-order ones and the htole/htobe functions they
    declare, <sys/mman.h>, <sys/resource.h>) and the five POSIX-only libc
    entries badc's msvcrt binding does not provide (fseeko, ftruncate,
    getpagesize, mmap, realpath); NASM falls back to its portable paths for
    those."""
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
    # configure.ac adds -fwrapv, which the frozen config states as
    # CFLAGS_FWRAPV.
    opt = ["-fwrapv", *(["-O"] if optimize else [])]
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


def run_golden_suite(nasm: Path,
                     wrapper: "str | None" = None) -> tuple[int, list[str]]:
    """Run NASM's golden suite against `nasm`. The `./travis/test` base-dir
    matches the source-path prefix the goldens were recorded with. When `wrapper` is
    given (native Windows), the harness invokes it instead of nasm and it is
    pointed at the real nasm via $NASM_REAL; see `build_nasm_wrapper`. Returns
    the pass count; a failed case or a harness error fails the smoke.

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
            [runner, "travis/nasm-t.py", "--nasm", harness_nasm,
             "-d", "./travis/test", "run"],
            cwd=SRC, env=env, capture_output=True, text=True, timeout=300)
    except subprocess.TimeoutExpired as e:
        partial = (e.stdout or "") + (e.stderr or "")
        fail(f"golden suite timed out after 300s (harness hang):\n{partial[-2000:]}")
    out = r.stdout + r.stderr
    passes = len(re.findall(r"=== Test \S+ PASS ===", out))
    # nasm-t.py prints the test path with the host separator (`\` on Windows).
    failed = re.findall(r"=== Test \./travis[\\/]test[\\/](\S+) (?:FAIL|ABORT) ===", out)
    if failed:
        fail(f"golden suite: {len(failed)} failure(s): {sorted(set(failed))[:20]}\n"
             f"{out[-3000:]}")
    # The harness exits non-zero on a failed case and on its own error, such as
    # a missing golden; zero passes means it ran no case.
    if r.returncode != 0 or passes == 0:
        fail(f"golden suite exited {r.returncode} after {passes} passing "
             f"checks:\n{out[-3000:]}")
    return passes


def main() -> int:
    badc = resolve_badc()
    target = badc_target()
    log(f"badc={badc} target={target}")
    ensure_source()
    adapt_fixtures(target)
    write_version_golden()
    ensure_config(target)
    with tempfile.TemporaryDirectory(prefix="nasm-smoke-") as d:
        work = Path(d)
        wrapper = build_nasm_wrapper(badc, work / "nasmw") if IS_WIN else None
        for optimize in (False, True):
            lane = "-O" if optimize else "-O0"
            log(f"building nasm with badc [{lane}]")
            nasm = build_nasm(badc, target, optimize, work / lane.strip("-"))
            ver = subprocess.run([str(nasm), "-v"], capture_output=True, text=True)
            if "NASM version" not in ver.stdout:
                fail(f"badc-built nasm [{lane}] does not report a version")
            log(f"running NASM's golden test suite [{lane}]")
            passes = run_golden_suite(nasm, wrapper)
            log(f"golden suite [{lane}]: {passes} checks pass")
            log(f"smoke OK [{lane}]")
    log("all lanes green")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
