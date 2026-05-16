#!/usr/bin/env python3
"""End-to-end smoke for badc against the TweetNaCl 20140427 source.

Builds tweetnacl.c + a hand-written driver through badc in the
same four flavours the other demos use (amalg / TU x -O / no-O)
plus the archive flavour, and runs each binary. Returns 0 on
success, non-zero with a diagnostic on failure.

TweetNaCl is the auditable NaCl implementation: Salsa20, Poly1305,
X25519, Ed25519, SHA-512 in ~700 lines of portable C99. The smoke
asserts a SHA-512 known-answer test, a secretbox / box / sign
round trip, and the RFC 8032 Ed25519 vector 1 (which pins the
scalar arithmetic + SHA-512 outputs bit-for-bit against a
published vector).

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

TWEETNACL_DIR = Path(__file__).resolve().parent
REPO_ROOT = TWEETNACL_DIR.parent.parent

_tu_spec = importlib.util.spec_from_file_location(
    "_tu_build", TWEETNACL_DIR.parent / "_tu_build.py"
)
_tu_build = importlib.util.module_from_spec(_tu_spec)
_tu_spec.loader.exec_module(_tu_build)
WIN = sys.platform == "win32"
EXE_SUFFIX = ".exe" if WIN else ""

BUILD_DEFINES: tuple[str, ...] = ()

LIB_SOURCES = (
    "tweetnacl.c",
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
    cmd: list[str | os.PathLike[str]] = [str(badc)]
    if optimize:
        cmd.append("-O")
    cmd += [
        "-I",
        str(TWEETNACL_DIR),
        "-",
        "-o",
        str(out_path),
    ]
    cmd += [f"-D{d}" for d in BUILD_DEFINES]
    subprocess.run(cmd, input=combined, check=True)


EXPECTED_PREFIXES = (
    "hash OK [sha512-abc]:",
    "sign OK [ed25519-rfc8032]:",
    "aead OK [secretbox]:",
    "aead OK [box]:",
    "sign OK [ed25519-roundtrip]:",
    "tweetnacl smoke: all scenarios green",
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
    print(f"smoke OK [{label}]: {len(EXPECTED_PREFIXES) - 1} scenarios green")
    return True


def main() -> int:
    badc = resolve_badc()

    subprocess.run(
        [sys.executable, str(TWEETNACL_DIR / "setup.py")],
        check=True,
    )

    with tempfile.TemporaryDirectory(prefix="tweetnacl-smoke-") as work_str:
        work = Path(work_str)
        amalg_script = REPO_ROOT / "scripts" / "amalgamate.py"
        amalg_inputs: list[str] = []
        for name in LIB_SOURCES:
            amalg_inputs.append(str(TWEETNACL_DIR / name))
        amalg_inputs.append(str(TWEETNACL_DIR / "smoke_main.c"))
        amalg_proc = subprocess.run(
            [sys.executable, str(amalg_script), "-o", "-", *amalg_inputs],
            check=True,
            capture_output=True,
        )
        combined = amalg_proc.stdout

        smoke_noopt = work / f"tweetnacl_smoke{EXE_SUFFIX}"
        smoke_opt = work / f"tweetnacl_smoke.opt{EXE_SUFFIX}"
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

        tu_noopt = work / f"tweetnacl_smoke.tu{EXE_SUFFIX}"
        tu_opt = work / f"tweetnacl_smoke.tu.opt{EXE_SUFFIX}"
        srcs = [TWEETNACL_DIR / name for name in LIB_SOURCES] + [
            TWEETNACL_DIR / "smoke_main.c"
        ]
        (work / "tu").mkdir(exist_ok=True)
        try:
            _tu_build.build_tu_separate(
                badc,
                srcs,
                tu_noopt,
                optimize=False,
                defines=BUILD_DEFINES,
                include_paths=(TWEETNACL_DIR,),
                work_dir=work / "tu",
            )
        except subprocess.CalledProcessError:
            print("smoke FAIL: TU build (no -O) failed", file=sys.stderr)
            return 1
        try:
            _tu_build.build_tu_separate(
                badc,
                srcs,
                tu_opt,
                optimize=True,
                defines=BUILD_DEFINES,
                include_paths=(TWEETNACL_DIR,),
                work_dir=work / "tu",
            )
        except subprocess.CalledProcessError:
            print("smoke FAIL: TU build (-O) failed", file=sys.stderr)
            return 1

        ar_noopt = work / f"tweetnacl_smoke.ar{EXE_SUFFIX}"
        ar_opt = work / f"tweetnacl_smoke.ar.opt{EXE_SUFFIX}"
        lib_srcs = [TWEETNACL_DIR / name for name in LIB_SOURCES]
        driver_srcs = [TWEETNACL_DIR / "smoke_main.c"]
        (work / "ar").mkdir(exist_ok=True)
        try:
            _tu_build.build_tu_archive(
                badc,
                lib_srcs,
                driver_srcs,
                "tweetnacl",
                ar_noopt,
                optimize=False,
                defines=BUILD_DEFINES,
                include_paths=(TWEETNACL_DIR,),
                work_dir=work / "ar",
            )
        except subprocess.CalledProcessError:
            print("smoke FAIL: archive build (no -O) failed", file=sys.stderr)
            return 1
        try:
            _tu_build.build_tu_archive(
                badc,
                lib_srcs,
                driver_srcs,
                "tweetnacl",
                ar_opt,
                optimize=True,
                defines=BUILD_DEFINES,
                include_paths=(TWEETNACL_DIR,),
                work_dir=work / "ar",
            )
        except subprocess.CalledProcessError:
            print("smoke FAIL: archive build (-O) failed", file=sys.stderr)
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
