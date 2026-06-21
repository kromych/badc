#!/usr/bin/env python3
"""Fetch the CPython 3.14.6 source distribution from the badc vendor-deps mirror.

After this runs, ``demos/python/.cache/Python-3.14.6/`` holds the upstream
source tree (the interpreter, the standard library, and the test suite
the smoke test runs).

Pulls from the ``kromych/badc`` vendor-deps GitHub release rather than
python.org to avoid CI flakes; ``_fetch`` verifies a pinned sha256 before
extraction. See ``scripts/vendor_deps/README.md`` for the auth model.

Idempotent: safe to call before each smoke run. Output is suppressed
unless something fails -- pass ``-v`` to see every step.
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

VERSION = "3.14.6"
# sha256 of the upstream `Python-3.14.6.tgz`.
SHA256 = "74d0d71d0600e477651a077101d6e62d1e2e69b8e992ba18c993dd643b7ba222"
ASSET = f"python-{VERSION}-{SHA256[:8]}.tar.gz"
RELEASE_TAG = "vendor-deps-v1"
# Directory the tarball unpacks into.
SRC_DIRNAME = f"Python-{VERSION}"
# The release source tarball omits the derived frozen-module headers
# (Python/frozen_modules/*.h) a POSIX configure/make would generate. They are
# platform-independent marshalled bytecode, so vendor them once and fetch here;
# the build then needs no make on any target.
FROZEN_SHA256 = "c04d5878dc61149e743eed163e867da65a508c64db4fe6b8e08bd4a6fe930ea3"
FROZEN_ASSET = f"python-frozen-{VERSION}-{FROZEN_SHA256[:8]}.tar.gz"


def ensure_frozen(src: Path, cache_dir: Path, log) -> None:
    landmark = src / "Python" / "frozen_modules" / "importlib._bootstrap.h"
    if landmark.is_file():
        log("frozen headers already present")
        return
    tar_path = cache_dir / FROZEN_ASSET
    _fetch.fetch_and_verify(RELEASE_TAG, FROZEN_ASSET, tar_path, FROZEN_SHA256, log)
    log("extracting frozen headers")
    with tarfile.open(tar_path, "r:gz") as tf:
        tf.extractall(src)
    if not landmark.is_file():
        sys.exit(f"setup: frozen extract missing {landmark}")


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args(argv)

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    py_dir = Path(__file__).resolve().parent
    cache_dir = py_dir / ".cache"
    tar_path = cache_dir / ASSET
    extract_root = cache_dir / SRC_DIRNAME

    cache_dir.mkdir(parents=True, exist_ok=True)
    if (extract_root / "configure").is_file():
        log("source already extracted")
    else:
        _fetch.fetch_and_verify(RELEASE_TAG, ASSET, tar_path, SHA256, log)
        log("extracting source")
        if extract_root.exists():
            shutil.rmtree(extract_root)
        with tarfile.open(tar_path, "r:gz") as tf:
            tf.extractall(cache_dir)
        if not (extract_root / "configure").is_file():
            sys.exit(f"setup: extracted tree missing configure at {extract_root}")
        log(f"source ready at {extract_root}")

    ensure_frozen(extract_root, cache_dir, log)
    return 0


if __name__ == "__main__":
    sys.exit(main())
