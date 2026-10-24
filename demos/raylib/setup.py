#!/usr/bin/env python3
"""Fetch the raylib 6.0 source distribution for the badc demo.

After this runs, ``demos/raylib/src/`` holds the raylib C sources
(modules, the bundled RGFW + glad single-headers, raylib.h) ready for
the smoke harness to compile through badc. The demo builds the desktop
RGFW backend so every translation unit is C -- raylib's default GLFW
backend is Objective-C on macOS, which badc does not compile.

Pulls the GitHub archive of the release tag from the ``kromych/badc``
vendor-deps mirror; ``_fetch`` verifies its sha256 before extraction.
Idempotent: re-running replaces ``src/`` with a clean extraction.
"""

from __future__ import annotations

import argparse
import shutil
import sys
import tarfile
from pathlib import Path

RAYLIB_DIR = Path(__file__).resolve().parent
SRC_DIR = RAYLIB_DIR / "src"
CACHE_DIR = RAYLIB_DIR / ".cache"

REPO_ROOT = RAYLIB_DIR.parents[1]
sys.path.insert(0, str(REPO_ROOT / "scripts" / "vendor_deps"))
import _fetch  # noqa: E402

# TODO(#1643): 6.2's RGFW calls GetUpdateRect, which <windows.h> does
# not declare.
VERSION = "6.0"
# sha256 of the GitHub archive of refs/tags/6.0 (tag commit dbc56a87).
UPSTREAM_SHA = "2b3ee1e2120c7a0796b33062c7e9a694dd8a8caa56a96319ac8c8ecf54a90d0b"
ASSET = f"raylib-{VERSION}-{UPSTREAM_SHA[:8]}.tar.gz"
SHA256 = UPSTREAM_SHA
RELEASE_TAG = "vendor-deps-v1"


def _extract_src(tar_path: Path, log) -> None:
    if SRC_DIR.exists():
        shutil.rmtree(SRC_DIR)
    SRC_DIR.mkdir(parents=True)
    prefix = f"raylib-{VERSION}/src/"
    with tarfile.open(tar_path, "r:gz") as tf:
        for member in tf.getmembers():
            if not member.name.startswith(prefix):
                continue
            rel = member.name[len(prefix):]
            if not rel:
                continue
            target = SRC_DIR / rel
            if member.isdir():
                target.mkdir(parents=True, exist_ok=True)
                continue
            target.parent.mkdir(parents=True, exist_ok=True)
            extracted = tf.extractfile(member)
            if extracted is None:
                continue
            with extracted as inp, target.open("wb") as out:
                shutil.copyfileobj(inp, out)
    log(f"extracted raylib src to {SRC_DIR}")


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args(argv)

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    tarball = CACHE_DIR / ASSET
    _fetch.fetch_and_verify(RELEASE_TAG, ASSET, tarball, SHA256, log)
    _extract_src(tarball, log)
    return 0


if __name__ == "__main__":
    sys.exit(main())
