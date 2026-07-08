#!/usr/bin/env python3
"""End-to-end smoke for badc against the yasm 1.3.0 assembler.

yasm's build derives several C sources at build time: the C generators
(genstring/genmacro/genperf/genmodule/genversion) and, for the x86
instruction tables, the Python `modules/arch/x86/gen_x86_insn.py`. This smoke
runs that Python step under the **badc-built CPython** (see the python demo),
so a badc-built interpreter generates the tables that a badc-built assembler
is then compiled from -- a self-hosting cross-check.

Flow (POSIX targets):
  1. Build CPython with badc (python demo) and stage it in a temp dir.
  2. `./configure PYTHON=<badc-python>` and `make` -- the C generators build
     and run under the host cc, `gen_x86_insn.py` runs under the badc-python,
     and a reference `yasm` is produced whose object list drives step 3.
  3. Recompile each of yasm's translation units with badc, archive the
     library, and link `yasm` with badc's own linker.
  4. Assemble a mixed-instruction fixture with the badc-built `yasm` and the
     reference `yasm` in each object format and require byte-identical output.

Override the badc binary via `$BADC` (default: `target/release/badc[.exe]`).
"""

from __future__ import annotations

import os
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

YASM_DEMO = Path(__file__).resolve().parent
REPO_ROOT = YASM_DEMO.parents[1]
PYDEMO = REPO_ROOT / "demos" / "python"
SRC = YASM_DEMO / "src"

INC = [".", "libyasm", "modules"]
DEFS = ["-DHAVE_CONFIG_H", "-DYASM_LIB_SOURCE"]

FIXTURE = """\
bits 64
section .text
global f
f:
    mov rax, 60
    mov rdi, 42
    add rdi, 1
    movzx rbx, byte [rdi]
    lea rcx, [rax+rbx*4+16]
    imul rdx, rcx, 100
    xor r8, r8
    shl r9, 13
    ret
section .data
d: dq 0x1122334455667788
    dw 1, 2, 3, 4
"""

IS_WIN = sys.platform == "win32"
EXE = ".exe" if IS_WIN else ""


def log(m: str) -> None:
    print(f"yasm smoke: {m}", flush=True)


def fail(m: str) -> "None":
    print(f"yasm smoke FAIL: {m}", file=sys.stderr, flush=True)
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
    import platform

    mach = platform.machine().lower()
    aarch = mach in ("arm64", "aarch64")
    if sys.platform == "darwin":
        return "macos-aarch64" if aarch else "macos-x64"
    if IS_WIN:
        return "windows-arm64" if aarch else "windows-x64"
    return "linux-aarch64" if aarch else "linux-x64"


def host_cc() -> str:
    return os.environ.get("CC") or next(
        (c for c in ("cc", "clang", "gcc") if shutil.which(c)), "cc"
    )


def stage_badc_python(rundir: Path) -> Path:
    """Build CPython with badc and stage it beside its stdlib in `rundir`
    (executed from a temp dir; the hosted macOS runner refuses to exec
    binaries from the workspace). Returns the interpreter path."""
    log("building CPython with badc for the table generator")
    subprocess.run([sys.executable, str(PYDEMO / "setup.py")], check=True)
    subprocess.run(
        [sys.executable, str(PYDEMO / "build.py"), f"--target={badc_target()}", "--link"],
        check=True,
    )
    pybin = PYDEMO / ".cache" / f"obj-{badc_target()}" / "python"
    srcs = sorted((PYDEMO / ".cache").glob("Python-*"))
    if not pybin.is_file() or not srcs:
        fail("badc-built python or its source tree not found")
    pysrc = srcs[-1]
    exe = rundir / "python"
    shutil.copy2(pybin, exe)
    os.chmod(exe, 0o755)
    (rundir / "Lib").symlink_to(pysrc / "Lib")
    return exe


def configure_and_generate(badc_python: Path, rundir: Path) -> list[str]:
    """Configure + make yasm with the C generators (host cc) and the x86
    table generator (badc-python), producing the derived sources and a
    reference binary. Returns yasm's translation-unit list."""
    # A wrapper so make's `$(PYTHON) gen_x86_insn.py` runs the badc-built
    # interpreter with its stdlib on PYTHONHOME.
    wrapper = rundir / "python-badc"
    wrapper.write_text(
        "#!/bin/sh\n"
        f'export PYTHONHOME="{rundir}" PYTHONPATH="{rundir}/Lib"\n'
        f'exec "{badc_python}" "$@"\n'
    )
    wrapper.chmod(0o755)
    log("configure (badc-python for the x86 tables)")
    subprocess.run(
        ["sh", "./configure", f"CC={host_cc()}", f"PYTHON={wrapper}"],
        cwd=SRC, check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
    )
    log("make (generate derived sources + reference yasm)")
    r = subprocess.run(["make", "-j", str(os.cpu_count() or 4)], cwd=SRC,
                       capture_output=True, text=True)
    if r.returncode != 0 or not (SRC / ("yasm" + EXE)).is_file():
        fail(f"reference make failed:\n{r.stderr.strip()[-1200:]}")
    # Object list from the built tree: yasm's own TUs, excluding the
    # build-time generators, the alternate frontends, and the CPython
    # bindings.
    objs = []
    for o in SRC.rglob("*.o"):
        rel = o.relative_to(SRC).as_posix()
        base = o.name
        if base.startswith(("gen", "re2c")) and "/" not in rel:
            continue
        if rel.startswith(("frontends/tasm/", "frontends/vsyasm/", "tools/")):
            continue
        c = o.with_suffix(".c")
        if c.is_file():
            objs.append(c.relative_to(SRC).as_posix())
    return sorted(set(objs))


def build_with_badc(badc: Path, target: str, sources: list[str], workdir: Path) -> Path:
    workdir.mkdir(parents=True, exist_ok=True)
    inc = [f"-I{SRC / d}" for d in INC]
    main_rel = "frontends/yasm/yasm.c"
    objs = []
    for rel in sources:
        out = workdir / (rel.replace("/", "_")[:-2] + ".o")
        cmd = [str(badc), f"--target={target}", "-c", *inc, *DEFS,
               str(SRC / rel), "-o", str(out)]
        r = subprocess.run(cmd, capture_output=True, text=True)
        if r.returncode != 0 or not out.is_file():
            fail(f"badc failed to compile {rel}:\n{r.stderr.strip()[-800:]}")
        objs.append((rel, out))
    lib = workdir / "libyasm_all.a"
    rest = [str(o) for rel, o in objs if rel != main_rel]
    main_o = next((str(o) for rel, o in objs if rel == main_rel), None)
    if main_o is None:
        fail(f"yasm frontend main {main_rel} not in the object list")
    subprocess.run([str(badc), "--ar", "-o", str(lib), *rest], check=True,
                   capture_output=True)
    binp = workdir / ("yasm" + EXE)
    r = subprocess.run([str(badc), f"--target={target}", main_o, str(lib),
                        "-o", str(binp)], capture_output=True, text=True)
    if r.returncode != 0 or not binp.is_file():
        fail(f"badc failed to link yasm:\n{r.stderr.strip()[-1000:]}")
    if not IS_WIN:
        binp.chmod(0o755)
    return binp


def byte_parity(a: Path, b: Path) -> None:
    with tempfile.TemporaryDirectory(prefix="yasm-parity-") as d:
        dp = Path(d)
        asm = dp / "fixture.asm"
        asm.write_text(FIXTURE)
        for fmt in ("elf64", "elf32", "bin", "win64", "macho64"):
            oa, ob = dp / f"a_{fmt}", dp / f"b_{fmt}"
            subprocess.run([str(a), "-f", fmt, "-o", str(oa), str(asm)], capture_output=True)
            subprocess.run([str(b), "-f", fmt, "-o", str(ob), str(asm)], capture_output=True)
            if not oa.is_file() or not ob.is_file() or oa.read_bytes() != ob.read_bytes():
                fail(f"byte parity mismatch in -f {fmt}")
        log("byte parity OK across 5 object formats")


def main() -> int:
    if IS_WIN:
        fail("POSIX targets only (yasm's build generators assume a Unix shell)")
    badc = resolve_badc()
    target = badc_target()
    log(f"badc={badc} target={target}")
    if not (SRC / "configure").is_file():
        subprocess.run([sys.executable, str(YASM_DEMO / "setup.py")], check=True)

    with tempfile.TemporaryDirectory(prefix="yasm-py-") as pyd:
        badc_python = stage_badc_python(Path(pyd))
        sources = configure_and_generate(badc_python, Path(pyd))
        log(f"yasm translation units: {len(sources)}")
        with tempfile.TemporaryDirectory(prefix="yasm-smoke-") as d:
            yasm = build_with_badc(badc, target, sources, Path(d))
            ver = subprocess.run([str(yasm), "--version"], capture_output=True, text=True)
            if "yasm 1.3.0" not in ver.stdout:
                fail(f"badc-built yasm did not report its version:\n{ver.stdout}{ver.stderr}")
            log("badc-built yasm --version OK")
            byte_parity(yasm, SRC / ("yasm" + EXE))
    log("all lanes green")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
