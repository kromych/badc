#!/usr/bin/env python3
"""Fetch the SymCrypt 103.13.0 release source from the badc vendor-deps mirror.

After this runs, ``demos/symcrypt/.cache/SymCrypt-103.13.0/`` holds the
upstream tree: the library under ``lib``, its CMake build, and the unit
test under ``unittest``.

Pulls from the `kromych/badc` vendor-deps GitHub release; ``_fetch``
verifies the pinned sha256 before extraction. The asset is GitHub's archive
of the `v103.13.0` tag, which carries no submodules (the FIPS build's
jitterentropy is one). See ``scripts/vendor_deps/README.md``.

Idempotent. Output is suppressed unless something fails -- pass ``-v``.
"""

from __future__ import annotations

import argparse
import shutil
import sys
import tarfile
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(REPO_ROOT / "scripts" / "vendor_deps"))
import _fetch  # noqa: E402

VERSION = "103.13.0"
# The `v103.13.0` tag's commit and its date, which the release's version
# script reads from git and takes from the environment in a tarball build.
UPSTREAM_SHA = "286762b7730e2b780678f5ab11fef2b1bad639e0"
COMMIT_TIMESTAMP = "2026-08-05T21:48:57Z"
SHA256 = "cbbe6f67b8a4ddb228be79b442daba8d298d743582c32d8233d190fdf7545473"
ASSET = f"symcrypt-{VERSION}-{SHA256[:8]}.tar.gz"
RELEASE_TAG = "vendor-deps-v1"
SRC_DIRNAME = f"SymCrypt-{VERSION}"


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args(argv)

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    cache_dir = Path(__file__).resolve().parent / ".cache"
    tar_path = cache_dir / ASSET
    extract_root = cache_dir / SRC_DIRNAME
    cache_dir.mkdir(parents=True, exist_ok=True)
    _fetch.fetch_and_verify(RELEASE_TAG, ASSET, tar_path, SHA256, log)

    log("extracting source")
    if extract_root.exists():
        shutil.rmtree(extract_root)
    with tarfile.open(tar_path, "r:gz") as tf:
        tf.extractall(cache_dir, filter="data")
    if not (extract_root / "CMakeLists.txt").is_file():
        print(f"setup: expected {extract_root}/CMakeLists.txt after extraction", file=sys.stderr)
        return 1
    log(f"done -- {extract_root}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
