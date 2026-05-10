#!/usr/bin/env python3
"""End-to-end smoke for badc against the bzip2 1.0.8 source.

Builds the seven library .c files + a hand-written driver
through badc (both at -O and noO) and runs a buffer-to-buffer
compress + decompress round-trip at blockSize = 1 and 9. Returns
0 on success, non-zero with a diagnostic on failure.

bzip2 is the third non-trivial demo. Integer + bit-twiddle
heavy (BWT, MTF, RLE, Huffman); a different code shape from
miniz's deflate / inflate. Aligns with gh #11 ("add building
some archive libraries like 7z, lzma, bzip").

Override the badc binary via the ``BADC`` env var (default:
``target/release/badc[.exe]`` next to the repo root).
"""

from __future__ import annotations

import os
import subprocess
import sys
import tempfile
from pathlib import Path

BZIP2_DIR = Path(__file__).resolve().parent
REPO_ROOT = BZIP2_DIR.parent.parent
WIN = sys.platform == "win32"
EXE_SUFFIX = ".exe" if WIN else ""

# Build defines:
#   * BZ_NO_STDIO drops the FILE-based API (BZ2_bzReadOpen /
#     BZ2_bzWriteOpen) which pulls `<sys/stat.h>` flavours c5
#     doesn't ship; we only need the buffer-to-buffer entry
#     points, which don't touch stdio.
BUILD_DEFINES = (
    "BZ_NO_STDIO",
)

# bzip2's library ships split across these seven .c files; they
# all compile together into a single object archive in upstream.
# We feed them in this order to scripts/amalgamate.py so the
# combined source carries a `#line 1 "<file>.c"` marker at
# every TU boundary -- DWARF then attributes each PC to its
# real source file.
LIB_SOURCES = (
    "blocksort.c",
    "huffman.c",
    "crctable.c",
    "randtable.c",
    "compress.c",
    "decompress.c",
    "bzlib.c",
)


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


def build_smoke(badc: Path, combined: bytes, out_path: Path, optimize: bool) -> None:
    """Compile the amalgamated bzip2 library + driver via badc."""
    cmd: list[str | os.PathLike[str]] = [str(badc)]
    if optimize:
        cmd.append("-O")
    cmd += [
        "-I",
        str(BZIP2_DIR),
        "-include",
        "msvc_compat.h",
        "-",
        "-o",
        str(out_path),
    ]
    cmd += [f"-D{d}" for d in BUILD_DEFINES]
    subprocess.run(cmd, input=combined, check=True)


# Scenario output -- exact lines for the prefix-match check;
# the round-trip line embeds the cmp_len which can shift across
# bzip2 releases, so we check only the leading prefix.
EXPECTED_PREFIXES = (
    "roundtrip OK [block=1]:",
    "roundtrip OK [block=9]:",
    "bzip2 smoke: all scenarios green",
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
    print(f"smoke OK [{label}]: {lines[0]} ; {lines[1]}")
    return True


def main() -> int:
    badc = resolve_badc()

    subprocess.run(
        [sys.executable, str(BZIP2_DIR / "setup.py")],
        check=True,
    )

    with tempfile.TemporaryDirectory(prefix="bzip2-smoke-") as work_str:
        work = Path(work_str)
        amalg_script = REPO_ROOT / "scripts" / "amalgamate.py"
        amalg_inputs: list[str] = []
        for name in LIB_SOURCES:
            amalg_inputs.append(str(BZIP2_DIR / name))
        amalg_inputs.append(str(BZIP2_DIR / "smoke_main.c"))
        amalg_proc = subprocess.run(
            [sys.executable, str(amalg_script), "-o", "-", *amalg_inputs],
            check=True,
            capture_output=True,
        )
        combined = amalg_proc.stdout

        smoke_noopt = work / f"bzip2_smoke{EXE_SUFFIX}"
        smoke_opt = work / f"bzip2_smoke.opt{EXE_SUFFIX}"
        try:
            build_smoke(badc, combined, smoke_noopt, optimize=False)
        except subprocess.CalledProcessError:
            print("smoke FAIL: build (no -O) failed", file=sys.stderr)
            return 1
        try:
            build_smoke(badc, combined, smoke_opt, optimize=True)
        except subprocess.CalledProcessError:
            print("smoke FAIL: build (-O) failed", file=sys.stderr)
            return 1

        ok = True
        ok &= run_and_check("no-O", smoke_noopt)
        ok &= run_and_check("-O", smoke_opt)
        return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
