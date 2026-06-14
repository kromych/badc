#!/usr/bin/env python3
"""Fetch the Tcl 8.6.14 source distribution from the badc vendor-deps mirror.

After this runs, ``demos/tcl/.cache/tcl8.6.14/`` holds the upstream source
tree (interpreter sources under ``generic`` / ``unix`` plus the ``tests``
directory the smoke test runs).

Pulls from the `kromych/badc` vendor-deps GitHub release rather than
SourceForge to avoid CI flakes; ``_fetch`` verifies a pinned sha256
before extraction. See ``scripts/vendor_deps/README.md`` for the auth
model.

Idempotent: safe to call from CI before each smoke run. Output is
suppressed unless something fails -- pass ``-v`` to see every step.
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

VERSION = "8.6.14"
# Tcl is published as a standalone tarball with no public commit id, so
# the pin is the sha256 of the upstream `tcl8.6.14-src.tar.gz`.
SHA256 = "5880225babf7954c58d4fb0f5cf6279104ce1cd6aa9b71e9a6322540e1c4de66"
ASSET = f"tcl-{VERSION}-{SHA256[:8]}.tar.gz"
RELEASE_TAG = "vendor-deps-v1"
# Directory the tarball unpacks into.
SRC_DIRNAME = f"tcl{VERSION}"


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args(argv)

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    tcl_dir = Path(__file__).resolve().parent
    cache_dir = tcl_dir / ".cache"
    tar_path = cache_dir / ASSET
    extract_root = cache_dir / SRC_DIRNAME

    cache_dir.mkdir(parents=True, exist_ok=True)
    _fetch.fetch_and_verify(RELEASE_TAG, ASSET, tar_path, SHA256, log)

    log("extracting source")
    if extract_root.exists():
        shutil.rmtree(extract_root)
    with tarfile.open(tar_path, "r:gz") as tf:
        tf.extractall(cache_dir)

    configure = extract_root / "unix" / "configure"
    if not configure.is_file():
        print(f"setup: expected {configure} after extraction", file=sys.stderr)
        return 1
    log(f"done -- {extract_root}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
