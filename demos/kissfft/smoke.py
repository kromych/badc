#!/usr/bin/env python3
"""End-to-end smoke for badc against the KISS FFT amalgamation.

Builds ``kiss_fft.c + kiss_fftr.c + smoke_main.c`` with badc
(both at -O and noO) and runs three scenarios that exercise
the FP arithmetic surface end-to-end: an impulse FFT (every
output bin must be 1+0i), a forward+inverse round-trip on a
mixed-frequency signal, and a real-only kiss_fftr against a
single-frequency sine wave.

kissfft is the first FP-heavy demo on the bring-up path. Each
scenario lives in `smoke_main.c` next to its expected values;
this runner just builds, invokes, and checks the exit code +
the per-scenario "OK" lines on stdout.

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

KISSFFT_DIR = Path(__file__).resolve().parent
REPO_ROOT = KISSFFT_DIR.parent.parent

# Import the shared TU-build helpers from `demos/_tu_build.py`.
_tu_spec = importlib.util.spec_from_file_location(
    "_tu_build", KISSFFT_DIR.parent / "_tu_build.py"
)
_tu_build = importlib.util.module_from_spec(_tu_spec)
_tu_spec.loader.exec_module(_tu_build)
WIN = sys.platform == "win32"
EXE_SUFFIX = ".exe" if WIN else ""

# Build defines:
#   * NDEBUG drops the kiss_fft_log.h debug-print macros down to
#     no-ops. Without it, the variadic logging spam clutters
#     stderr and pulls `fprintf(stderr, ...)` into every TU.
BUILD_DEFINES = (
    "NDEBUG",
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
    """Compile the amalgamated kissfft+driver via badc, with or
    without -O. Source comes in on stdin (`badc -`); -include
    msvc_compat.h opts the TU into the MSVC predefines on
    Windows targets and is a no-op elsewhere."""
    cmd: list[str | os.PathLike[str]] = [str(badc)]
    if optimize:
        cmd.append("-O")
    cmd += [
        "-I",
        str(KISSFFT_DIR),
        "-include",
        "msvc_compat.h",
        "-",
        "-o",
        str(out_path),
    ]
    cmd += [f"-D{d}" for d in BUILD_DEFINES]
    subprocess.run(cmd, input=combined, check=True)


# Each scenario in smoke_main.c prints exactly one OK line on
# success; the final summary line marks the green path. A
# missing line or any change in order means a regression.
EXPECTED_LINES = (
    "impulse OK",
    "roundtrip OK",
    "real-sine OK",
    "kissfft smoke: all scenarios green",
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
    if lines != list(EXPECTED_LINES):
        print(
            f"smoke FAIL [{label}]: stdout mismatch\nexpected:\n{chr(10).join(EXPECTED_LINES)}\ngot:\n{out}",
            file=sys.stderr,
        )
        return False
    print(f"smoke OK [{label}]: 3 scenarios green")
    return True


def main() -> int:
    badc = resolve_badc()

    subprocess.run(
        [sys.executable, str(KISSFFT_DIR / "setup.py")],
        check=True,
    )

    with tempfile.TemporaryDirectory(prefix="kissfft-smoke-") as work_str:
        work = Path(work_str)
        amalg_script = REPO_ROOT / "scripts" / "amalgamate.py"
        amalg_proc = subprocess.run(
            [
                sys.executable,
                str(amalg_script),
                "-o",
                "-",
                str(KISSFFT_DIR / "kiss_fft.c"),
                str(KISSFFT_DIR / "kiss_fftr.c"),
                str(KISSFFT_DIR / "smoke_main.c"),
            ],
            check=True,
            capture_output=True,
        )
        combined = amalg_proc.stdout

        smoke_noopt = work / f"kissfft_smoke{EXE_SUFFIX}"
        smoke_opt = work / f"kissfft_smoke.opt{EXE_SUFFIX}"
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

        # Separate-compilation flavour: each .c through `-c`
        # to its own .o, link the three pieces. No amalgamation.
        tu_dir = work / "tu"
        tu_dir.mkdir()
        srcs = [
            KISSFFT_DIR / "kiss_fft.c",
            KISSFFT_DIR / "kiss_fftr.c",
            KISSFFT_DIR / "smoke_main.c",
        ]
        tu_noopt = work / f"kissfft_smoke.tu{EXE_SUFFIX}"
        tu_opt = work / f"kissfft_smoke.tu.opt{EXE_SUFFIX}"
        for (out, opt) in [(tu_noopt, False), (tu_opt, True)]:
            try:
                _tu_build.build_tu_separate(
                    badc,
                    srcs,
                    out,
                    optimize=opt,
                    defines=BUILD_DEFINES,
                    include_paths=(KISSFFT_DIR,),
                    force_includes=("msvc_compat.h",),
                    work_dir=tu_dir,
                )
            except subprocess.CalledProcessError:
                tag = "-O" if opt else "no-O"
                print(f"smoke FAIL: TU build ({tag}) failed", file=sys.stderr)
                return 1

        # Archive flavour: bundle the two library sources into
        # libkissfft.a, link smoke_main.c against it via -l.
        ar_dir = work / "ar"
        ar_dir.mkdir()
        lib_srcs = [KISSFFT_DIR / "kiss_fft.c", KISSFFT_DIR / "kiss_fftr.c"]
        driver_srcs = [KISSFFT_DIR / "smoke_main.c"]
        ar_noopt = work / f"kissfft_smoke.ar{EXE_SUFFIX}"
        ar_opt = work / f"kissfft_smoke.ar.opt{EXE_SUFFIX}"
        for (out, opt) in [(ar_noopt, False), (ar_opt, True)]:
            try:
                _tu_build.build_tu_archive(
                    badc,
                    lib_srcs,
                    driver_srcs,
                    "kissfft",
                    out,
                    optimize=opt,
                    defines=BUILD_DEFINES,
                    include_paths=(KISSFFT_DIR,),
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
