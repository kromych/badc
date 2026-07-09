#!/usr/bin/env python3
"""End-to-end smoke for badc against the yasm 1.3.0 assembler.

yasm's build derives several C sources at build time: the C generators
(genstring/genmacro/genperf/genmodule/genversion) and, for the x86
instruction tables, the Python `modules/arch/x86/gen_x86_insn.py`. This smoke
runs that Python step under the **badc-built CPython** (see the python demo),
so a badc-built interpreter generates the tables that a badc-built assembler
is then compiled from -- a self-hosting cross-check.

Flow (POSIX targets) -- no `make`, no `./configure`:
  1. Build CPython with badc (python demo) and stage it in a temp dir.
  2. Install a frozen config, build yasm's generators with badc, run
     `gen_x86_insn.py` under the badc-python, and run the generators to derive
     yasm's C sources (see `generate_sources` / `PIPELINE`).
  3. Recompile yasm's translation units (a frozen manifest) with badc, archive
     the library, and link `yasm` with badc's own linker.
  4. Build a reference `yasm` from the same sources with the host cc, assemble
     a mixed-instruction fixture with both in each object format, and require
     byte-identical output.

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


# The build-time generators badc compiles, with their exact source lists (the
# link inputs the upstream Makefile uses). genperf pulls in libyasm's hash and
# memory helpers; re2c is the specific nine files (the rest of tools/re2c use
# libyasm internals and are not part of the tool).
GENERATORS = {
    "genperf": ["tools/genperf/genperf.c", "tools/genperf/perfect.c",
                "libyasm/phash.c", "libyasm/xmalloc.c", "libyasm/xstrdup.c"],
    "genmacro": ["tools/genmacro/genmacro.c"],
    "genstring": ["genstring.c"],
    "genversion": ["modules/preprocs/nasm/genversion.c"],
    "genmodule": ["libyasm/genmodule.c"],
    "re2c": [f"tools/re2c/{m}.c" for m in
             ("main", "code", "dfa", "parser", "actions", "scanner",
              "mbo_getopt", "substr", "translate")],
}

# The derived-source pipeline (the upstream Makefile's generator invocations,
# in dependency order). gen_x86_insn.py runs first (writes the .gperf tables
# genperf consumes). Paths are relative to SRC, the working directory.
PIPELINE = [
    ("genversion", ["version.mac"]),
    ("genperf", ["x86insn_nasm.gperf", "x86insn_nasm.c"]),
    ("genperf", ["x86insn_gas.gperf", "x86insn_gas.c"]),
    ("genperf", ["modules/arch/x86/x86cpu.gperf", "x86cpu.c"]),
    ("genperf", ["modules/arch/x86/x86regtmod.gperf", "x86regtmod.c"]),
    ("re2c", ["-b", "-o", "gas-token.c", "modules/parsers/gas/gas-token.re"]),
    ("re2c", ["-b", "-o", "nasm-token.c", "modules/parsers/nasm/nasm-token.re"]),
    ("re2c", ["-s", "-o", "lc3bid.c", "modules/arch/lc3b/lc3bid.re"]),
    ("genmacro", ["nasm-macros.c", "nasm_standard_mac",
                  "modules/parsers/nasm/nasm-std.mac"]),
    ("genmacro", ["nasm-version.c", "nasm_version_mac", "version.mac"]),
    ("genmacro", ["win64-nasm.c", "win64_nasm_stdmac",
                  "modules/objfmts/coff/win64-nasm.mac"]),
    ("genmacro", ["win64-gas.c", "win64_gas_stdmac",
                  "modules/objfmts/coff/win64-gas.mac"]),
    ("genstring", ["license_msg", "license.c", "./COPYING"]),
    # genmodule reads the module list from Makefile.am (YASM_MODULES += ...),
    # so no generated Makefile / configure is needed.
    ("genmodule", ["libyasm/module.in", "Makefile.am"]),
]


def generate_sources(badc: Path, python_wrapper: Path, gendir: Path) -> list[str]:
    """Produce yasm's derived C sources without make: install the frozen config,
    build the generators with badc, run gen_x86_insn.py under the badc-python,
    then run the generators. Returns the frozen translation-unit list."""
    # Frozen configure outputs: config.h and libyasm-stdint.h (the latter just
    # includes <stdint.h>, which badc provides, so it is target-independent).
    shutil.copy2(YASM_DEMO / "config" / "config-posix.h", SRC / "config.h")
    shutil.copy2(YASM_DEMO / "config" / "libyasm-stdint.h",
                 SRC / "libyasm-stdint.h")
    gendir.mkdir(parents=True, exist_ok=True)
    inc = ["-I.", "-Ilibyasm", "-Itools/genperf", "-Itools/re2c"]
    log("building yasm's generators with badc")
    tools = {}
    for name, srcs in GENERATORS.items():
        exe = gendir / (name + EXE)
        r = subprocess.run([str(badc), f"--target={badc_target()}", *inc,
                            *[str(SRC / s) for s in srcs], "-o", str(exe)],
                           cwd=SRC, capture_output=True, text=True)
        if r.returncode != 0 or not exe.is_file():
            fail(f"badc failed to build generator {name}:\n{r.stderr.strip()[-800:]}")
        tools[name] = str(exe)
    log("generating the x86 instruction tables (badc-python gen_x86_insn.py)")
    r = subprocess.run([str(python_wrapper),
                        "modules/arch/x86/gen_x86_insn.py"],
                       cwd=SRC, capture_output=True, text=True)
    if r.returncode != 0 or not (SRC / "x86insns.c").is_file():
        fail(f"gen_x86_insn.py (badc-python) failed:\n{r.stdout[-400:]}{r.stderr[-800:]}")
    log("running the derived-source generators")
    for name, args in PIPELINE:
        r = subprocess.run([tools[name], *args], cwd=SRC,
                           capture_output=True, text=True)
        if r.returncode != 0:
            fail(f"generator {name} {args} failed:\n{r.stderr.strip()[-600:]}")
    manifest = (YASM_DEMO / "config" / "tu-list.txt").read_text().split()
    missing = [s for s in manifest if not (SRC / s).is_file()]
    if missing:
        fail(f"generated tree is missing translation units: {missing[:10]}")
    return manifest


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


def make_python_wrapper(badc_python: Path, rundir: Path) -> Path:
    """A wrapper so gen_x86_insn.py runs the badc-built interpreter with its
    stdlib on PYTHONHOME."""
    wrapper = rundir / "python-badc"
    wrapper.write_text(
        "#!/bin/sh\n"
        f'export PYTHONHOME="{rundir}" PYTHONPATH="{rundir}/Lib"\n'
        f'exec "{badc_python}" "$@"\n'
    )
    wrapper.chmod(0o755)
    return wrapper


def build_reference_hostcc(target: str, sources: list[str], workdir: Path) -> Path:
    """Build a reference yasm from the same generated + static sources with the
    host cc (no make), for the byte-parity check."""
    workdir.mkdir(parents=True, exist_ok=True)
    cc = host_cc()
    inc = [f"-I{SRC / d}" for d in INC]
    objs = []
    for rel in sources:
        out = workdir / (rel.replace("/", "_")[:-2] + ".o")
        r = subprocess.run([cc, "-c", "-w", *inc, *DEFS, str(SRC / rel),
                            "-o", str(out)], capture_output=True, text=True)
        if r.returncode != 0 or not out.is_file():
            fail(f"host cc failed to compile {rel} (reference):\n{r.stderr.strip()[-600:]}")
        objs.append(str(out))
    binp = workdir / ("yasm" + EXE)
    r = subprocess.run([cc, *objs, "-o", str(binp)], capture_output=True, text=True)
    if r.returncode != 0 or not binp.is_file():
        fail(f"host cc failed to link the reference yasm:\n{r.stderr.strip()[-600:]}")
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
        # The generators + gen_x86_insn.py run fine on Windows, but the
        # byte-parity reference still uses the host cc; the native-Windows lane
        # needs committed goldens instead (tracked separately).
        fail("POSIX targets only for now (host-cc byte-parity reference)")
    badc = resolve_badc()
    target = badc_target()
    log(f"badc={badc} target={target}")
    if not (SRC / "configure").is_file():
        subprocess.run([sys.executable, str(YASM_DEMO / "setup.py")], check=True)

    with tempfile.TemporaryDirectory(prefix="yasm-py-") as pyd:
        badc_python = stage_badc_python(Path(pyd))
        wrapper = make_python_wrapper(badc_python, Path(pyd))
        with tempfile.TemporaryDirectory(prefix="yasm-gen-") as gend:
            sources = generate_sources(badc, wrapper, Path(gend))
            log(f"yasm translation units: {len(sources)}")
            with tempfile.TemporaryDirectory(prefix="yasm-smoke-") as d:
                yasm = build_with_badc(badc, target, sources, Path(d) / "badc")
                ver = subprocess.run([str(yasm), "--version"],
                                     capture_output=True, text=True)
                if "yasm 1.3.0" not in ver.stdout:
                    fail(f"badc-built yasm did not report its version:\n{ver.stdout}{ver.stderr}")
                log("badc-built yasm --version OK")
                ref = build_reference_hostcc(target, sources, Path(d) / "ref")
                byte_parity(yasm, ref)
    log("all lanes green")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
