#!/usr/bin/env python3
"""End-to-end smoke for badc against the miniz amalgamation.

Builds ``miniz.c + smoke_main.c`` with badc (both at -O and noO)
and runs the round-trip + checksum scenarios. Returns 0 on
success, non-zero with a diagnostic message on failure.

miniz is the second non-trivial demo after sqlite. It's a single-
file deflate / inflate / CRC32 / Adler32 / zip implementation in
~9k LOC of C99 -- integer- and bit-twiddle-heavy, no FP, so it's
the smaller incremental step before kissfft / bzip2 / stb_vorbis.

Override the badc binary via the ``BADC`` env var (default:
``target/release/badc[.exe]`` next to the repo root).
"""

from __future__ import annotations

import importlib.util
import os
import subprocess
import sys
import tempfile
from pathlib import Path

MINIZ_DIR = Path(__file__).resolve().parent
REPO_ROOT = MINIZ_DIR.parent.parent

# Import the shared TU-build helpers from `demos/_tu_build.py`.
_tu_spec = importlib.util.spec_from_file_location(
    "_tu_build", MINIZ_DIR.parent / "_tu_build.py"
)
_tu_build = importlib.util.module_from_spec(_tu_spec)
_tu_spec.loader.exec_module(_tu_build)
WIN = sys.platform == "win32"
EXE_SUFFIX = ".exe" if WIN else ""

# Build-time defines that strip the parts of miniz a c5-only
# build can't satisfy:
#   * MINIZ_NO_ARCHIVE_APIS removes the zip surface (relies on
#     <sys/stat.h> / <utime.h> / <windows.h> for file metadata
#     -- not in the c5 header set).
#   * MINIZ_NO_TIME drops <time.h> usage inside the archive code
#     path. Redundant with NO_ARCHIVE_APIS today; kept for
#     symmetry with miniz's own example builds.
#   * MINIZ_NO_STDIO drops fopen/fread/fwrite wrappers. We don't
#     use any of those from smoke_main.c (everything is
#     in-memory), so dropping them shrinks the TU and avoids
#     `FILE *`-shape issues with the host stdio.
BUILD_DEFINES = (
    "MINIZ_NO_ARCHIVE_APIS",
    "MINIZ_NO_TIME",
    "MINIZ_NO_STDIO",
)


def resolve_badc() -> Path:
    """Locate the badc binary, honouring `$BADC` then falling
    back to ``target/release/badc[.exe]``."""
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
    """Compile the amalgamated miniz+smoke_main source via badc.

    Mirrors demos/sqlite3/smoke.py: stream the source on stdin
    so the same pipeline that a developer types
    (`amalgamate.py | badc -`) is what CI runs. `-include
    msvc_compat.h` opts the TU into the MSVC predefines on
    Windows targets and is a no-op elsewhere.
    """
    cmd: list[str | os.PathLike[str]] = [str(badc)]
    if optimize:
        cmd.append("-O")
    cmd += ["-I", str(MINIZ_DIR), "-include", "msvc_compat.h", "-", "-o", str(out_path)]
    cmd += [f"-D{d}" for d in BUILD_DEFINES]
    subprocess.run(cmd, input=combined, check=True)


# Expected stdout of the smoke_main binary -- two scenario lines
# plus a final summary. The middle of the round-trip line shows
# the compressor output size (`134 -> 60 -> 134` shape); we don't
# pin that number because deflate output can shift if miniz bumps
# its lazy-match heuristics on a release. Instead we check that
# the line begins with `roundtrip OK:` and the others match
# byte-for-byte.
EXPECTED_PREFIXES = (
    "roundtrip OK:",
    "checksums OK: crc=0xcbf43926 adler=0x091e01de",
    "miniz smoke: all scenarios green",
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

    # Ensure the miniz source is in place. setup is idempotent so
    # re-running is cheap on a primed runner.
    subprocess.run(
        [sys.executable, str(MINIZ_DIR / "setup.py")],
        check=True,
    )

    with tempfile.TemporaryDirectory(prefix="miniz-smoke-") as work_str:
        work = Path(work_str)
        # Combine miniz.c + smoke_main.c through scripts/amalgamate.py
        # exactly like the sqlite demo does -- preserves per-file
        # attribution in DWARF so a debugger can resolve symbols
        # back to the right source file even though c5 ingests a
        # single TU.
        amalg_script = REPO_ROOT / "scripts" / "amalgamate.py"
        amalg_proc = subprocess.run(
            [
                sys.executable,
                str(amalg_script),
                "-o",
                "-",
                str(MINIZ_DIR / "miniz.c"),
                str(MINIZ_DIR / "smoke_main.c"),
            ],
            check=True,
            capture_output=True,
        )
        combined = amalg_proc.stdout

        smoke_noopt = work / f"miniz_smoke{EXE_SUFFIX}"
        smoke_opt = work / f"miniz_smoke.opt{EXE_SUFFIX}"
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

        # Separate-compilation flavour: each .c through `-c`,
        # then link the two objects.
        tu_dir = work / "tu"
        tu_dir.mkdir()
        srcs = [MINIZ_DIR / "miniz.c", MINIZ_DIR / "smoke_main.c"]
        tu_noopt = work / f"miniz_smoke.tu{EXE_SUFFIX}"
        tu_opt = work / f"miniz_smoke.tu.opt{EXE_SUFFIX}"
        for (out, opt) in [(tu_noopt, False), (tu_opt, True)]:
            try:
                _tu_build.build_tu_separate(
                    badc,
                    srcs,
                    out,
                    optimize=opt,
                    defines=BUILD_DEFINES,
                    include_paths=(MINIZ_DIR,),
                    force_includes=("msvc_compat.h",),
                    work_dir=tu_dir,
                )
            except subprocess.CalledProcessError:
                tag = "-O" if opt else "no-O"
                print(f"smoke FAIL: TU build ({tag}) failed", file=sys.stderr)
                return 1

        # Archive flavour: bundle miniz.c into libminiz.a, link
        # the driver against it via -l.
        ar_dir = work / "ar"
        ar_dir.mkdir()
        ar_noopt = work / f"miniz_smoke.ar{EXE_SUFFIX}"
        ar_opt = work / f"miniz_smoke.ar.opt{EXE_SUFFIX}"
        for (out, opt) in [(ar_noopt, False), (ar_opt, True)]:
            try:
                _tu_build.build_tu_archive(
                    badc,
                    [MINIZ_DIR / "miniz.c"],
                    [MINIZ_DIR / "smoke_main.c"],
                    "miniz",
                    out,
                    optimize=opt,
                    defines=BUILD_DEFINES,
                    include_paths=(MINIZ_DIR,),
                    force_includes=("msvc_compat.h",),
                    work_dir=ar_dir,
                )
            except subprocess.CalledProcessError:
                tag = "-O" if opt else "no-O"
                print(f"smoke FAIL: archive build ({tag}) failed", file=sys.stderr)
                return 1

        ok = True
        ok &= run_and_check("amalg-no-O", smoke_noopt)
        ok &= run_and_check("amalg--O", smoke_opt)
        ok &= run_and_check("tu-no-O", tu_noopt)
        ok &= run_and_check("tu--O", tu_opt)
        ok &= run_and_check("ar-no-O", ar_noopt)
        ok &= run_and_check("ar--O", ar_opt)
        return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
