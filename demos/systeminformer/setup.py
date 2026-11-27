#!/usr/bin/env python3
"""Fetch the System Informer 4.0.26241.138 source from the badc vendor-deps mirror.

After this runs, ``demos/systeminformer/.cache/systeminformer-4.0.26241.138/``
holds the upstream tree: phnt, phlib, kphlib, the SystemInformer program, the
tools (peview, the third-party libraries, phlib-test) and the CMake lists and
modules that describe their build.

Pulls from the `kromych/badc` vendor-deps GitHub release; ``_fetch``
verifies the pinned sha256 before extraction. The asset is GitHub's archive
of the `v4.0.26241.138` tag. See ``scripts/vendor_deps/README.md``.

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

VERSION = "4.0.26241.138"
# The `v4.0.26241.138` tag's commit.
UPSTREAM_SHA = "99a0d28e091878967a804ac9ea2fe22f2c1fdadb"
SHA256 = "13ec72229a950fcc2bdf8fccd8ad63cf3b3caf8a22800f08fd01a76ce1d53365"
ASSET = f"systeminformer-{VERSION}-{SHA256[:8]}.tar.gz"
RELEASE_TAG = "vendor-deps-v1"
SRC_DIRNAME = f"systeminformer-{VERSION}"


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
    if (extract_root / "CMakeLists.txt").is_file():
        log(f"present -- {extract_root}")
        return 0

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
