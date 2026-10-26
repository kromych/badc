#!/usr/bin/env python3
"""Build Claude's C Compiler (ccc) for the perf table from the vendor-deps
mirror.

The archive is upstream's at the commit pinned below; its sha256 is verified
before it is unpacked and built under `build/ccc-src/`. ccc chooses its
target by the name it is run under (`ccc` x86-64, `ccc-arm` AArch64), so the
binary that targets this machine keeps its upstream name. It is installed
with the headers ccc ships, which ccc finds in an `include/` beside its
directory or one above it: `build/ccc-<sha8>/{bin/<name>,include/}`. ccc
emits Linux ELF only, so elsewhere this builds nothing. A no-op when that
binary exists.

    python3 tests/perf/build_ccc.py [-v]
"""

from __future__ import annotations

import argparse
import os
import platform
import shutil
import subprocess
import sys
import tarfile
from pathlib import Path

PERF_DIR = Path(__file__).resolve().parent
REPO_ROOT = PERF_DIR.parent.parent
sys.path.insert(0, str(REPO_ROOT / "scripts" / "vendor_deps"))
import _fetch  # noqa: E402

VERSION = "20260205"  # author date of the pinned commit
UPSTREAM_SHA = "6f1b99acb2f4ec2414592136c2009fe7713deec3"  # github anthropics/claudes-c-compiler main
ASSET = f"claudes-c-compiler-{VERSION}-{UPSTREAM_SHA[:8]}.tar.gz"
RELEASE_TAG = "vendor-deps-v1"
SHA256 = "fa804d00b7e11a5d5f2770eadfe94e64b2eaad4217764fe0b74a8c84a7450a62"

# The binary that targets each host architecture, by `platform.machine()`.
HOST_BINARY = {"x86_64": "ccc", "aarch64": "ccc-arm"}
BUILD_DIR = PERF_DIR / "build"


def binary_path(machine: str = "", system: str = "") -> Path | None:
    """Where the binary that targets this host is installed, or None where
    ccc builds no programs for it."""
    if (system or sys.platform) != "linux":
        return None
    name = HOST_BINARY.get(machine or platform.machine())
    if not name:
        return None
    return BUILD_DIR / f"ccc-{UPSTREAM_SHA[:8]}" / "bin" / name


def unpack(archive: Path, dst: Path) -> Path:
    """Unpack `archive` into an empty `dst` and return the source root."""
    if dst.exists():
        shutil.rmtree(dst)
    dst.mkdir(parents=True)
    with tarfile.open(archive, "r:gz") as tf:
        # The `data` filter refuses absolute paths, links out of the tree
        # and device files.
        tf.extractall(dst, filter="data")
    return dst / f"claudes-c-compiler-{UPSTREAM_SHA}"


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("-v", "--verbose", action="store_true")
    args = ap.parse_args(argv)

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    exe = binary_path()
    if exe is None:
        print(f"build_ccc: ccc builds no programs for {sys.platform} "
              f"{platform.machine()}; nothing to do", file=sys.stderr)
        return 0
    if exe.is_file():
        log(f"build_ccc: {exe} exists")
        return 0

    cache = BUILD_DIR / "cache"
    cache.mkdir(parents=True, exist_ok=True)
    archive = cache / ASSET
    _fetch.fetch_and_verify(RELEASE_TAG, ASSET, archive, SHA256, log)
    work = BUILD_DIR / "ccc-src"
    src = unpack(archive, work)
    # The crate has no dependencies, so the build reads nothing from the
    # network. The upstream code is not held to the warning policy the
    # caller's RUSTFLAGS may carry for badc's own build.
    env = {k: v for k, v in os.environ.items() if k != "RUSTFLAGS"}
    target = src / "target"
    cmd = ["cargo", "build", "--release", "--offline", "--bin", exe.name,
           "--target-dir", str(target)]
    log(f"build_ccc: {' '.join(cmd)} in {src}")
    r = subprocess.run(cmd, cwd=src, env=env)
    if r.returncode != 0:
        print(f"build_ccc: cargo exited {r.returncode}", file=sys.stderr)
        return 1
    root = exe.parent.parent
    if root.exists():
        shutil.rmtree(root)
    shutil.copytree(src / "include", root / "include")
    exe.parent.mkdir(parents=True)
    shutil.copy2(target / "release" / exe.name, exe)
    shutil.rmtree(work)
    print(f"built: {exe}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
