#!/usr/bin/env python3
"""End-to-end smoke for badc against the stb header collection.

Builds ``smoke_main.c`` (which #includes a curated set of stb_*.h
headers with their respective ``STB_*_IMPLEMENTATION`` macros
defined) with badc at both -O and noO, then runs the resulting
binary and pins per-scenario stdout.

stb is the densest demo in this directory: every header is its
own tiny library, so a single TU exercises sprintf, FP / Perlin
noise, PNG encode + decode, the stretchy-array macros, and the
skyline rect packer. The intent is regression coverage for c5
codegen, not for stb itself.

Override the badc binary via the ``BADC`` env var (default:
``target/release/badc[.exe]`` next to the repo root).
"""

from __future__ import annotations

import os
import subprocess
import sys
import tempfile
from pathlib import Path

STB_DIR = Path(__file__).resolve().parent
REPO_ROOT = STB_DIR.parent.parent
WIN = sys.platform == "win32"
EXE_SUFFIX = ".exe" if WIN else ""


def resolve_badc() -> Path:
    env = os.environ.get("BADC")
    candidates = []
    if env:
        candidates.append(Path(env))
    default = REPO_ROOT / "target" / "release" / "badc"
    candidates.extend([default, default.with_suffix(".exe")])
    for cand in candidates:
        if cand.is_file() and os.access(cand, os.X_OK):
            return cand
    print(
        f"smoke: BADC binary not found / not executable\n"
        f"       hint: cargo build --release --manifest-path={REPO_ROOT}/Cargo.toml",
        file=sys.stderr,
    )
    sys.exit(2)


def build_smoke(badc: Path, out_path: Path, optimize: bool) -> None:
    """Compile demos/stb/smoke_main.c via badc. Source is piped on
    stdin via the repo's amalgamation script so per-file DWARF
    attribution survives even though c5 ingests a single TU --
    mirrors miniz / bzip2 / kissfft.
    """
    amalg_script = REPO_ROOT / "scripts" / "amalgamate.py"
    amalg_proc = subprocess.run(
        [
            sys.executable,
            str(amalg_script),
            "-o",
            "-",
            str(STB_DIR / "smoke_main.c"),
        ],
        check=True,
        capture_output=True,
    )
    combined = amalg_proc.stdout

    cmd: list[str | os.PathLike[str]] = [str(badc)]
    if optimize:
        cmd.append("-O")
    cmd += ["-I", str(STB_DIR), "-include", "msvc_compat.h", "-", "-o", str(out_path)]
    subprocess.run(cmd, input=combined, check=True)


# Per-scenario expected prefixes -- the order matches smoke_main.c
# and the trailing summary line is matched in full.
EXPECTED_PREFIXES = (
    "sprintf OK:",
    "perlin OK:",
    "image OK:",
    "jpg OK:",
    "bmp OK:",
    "ds OK:",
    "rect_pack OK:",
    "c_lexer OK:",
    "connected_components OK:",
    "divide OK:",
    "dxt OK:",
    "easy_font OK:",
    "hexwave OK:",
    "leakcheck OK:",
    "truetype OK:",
    "herringbone_wang OK:",
    "vorbis OK:",
    "voxel_render OK:",
    "textedit OK:",
    "include OK:",
    "stb smoke: all scenarios green",
)


def run_and_check(label: str, smoke_bin: Path) -> bool:
    proc = subprocess.run(
        [str(smoke_bin)],
        capture_output=True,
        text=True,
        check=False,
    )
    out = proc.stdout.replace("\r", "")
    err = proc.stderr.replace("\r", "")
    if proc.returncode != 0:
        print(
            f"smoke FAIL [{label}]: exit {proc.returncode}\n--- stdout ---\n{out}\n--- stderr ---\n{err}",
            file=sys.stderr,
        )
        return False
    lines = out.splitlines()
    if len(lines) != len(EXPECTED_PREFIXES):
        print(
            f"smoke FAIL [{label}]: expected {len(EXPECTED_PREFIXES)} output lines, got {len(lines)}\n{out}",
            file=sys.stderr,
        )
        return False
    for i, prefix in enumerate(EXPECTED_PREFIXES):
        if not lines[i].startswith(prefix):
            print(
                f"smoke FAIL [{label}]: line {i+1}: {lines[i]!r} does not start with {prefix!r}",
                file=sys.stderr,
            )
            return False
    print(f"smoke OK [{label}]: stb scenarios green")
    return True


def main() -> int:
    badc = resolve_badc()

    subprocess.run(
        [sys.executable, str(STB_DIR / "setup.py")],
        check=True,
    )

    with tempfile.TemporaryDirectory(prefix="stb-smoke-") as work_str:
        work = Path(work_str)
        smoke_noopt = work / f"stb_smoke{EXE_SUFFIX}"
        smoke_opt = work / f"stb_smoke.opt{EXE_SUFFIX}"
        try:
            build_smoke(badc, smoke_noopt, optimize=False)
        except subprocess.CalledProcessError:
            print("smoke FAIL: build (no -O) failed", file=sys.stderr)
            return 1
        try:
            build_smoke(badc, smoke_opt, optimize=True)
        except subprocess.CalledProcessError:
            print("smoke FAIL: build (-O) failed", file=sys.stderr)
            return 1

        ok = True
        ok &= run_and_check("no-O", smoke_noopt)
        ok &= run_and_check("-O", smoke_opt)
        return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
