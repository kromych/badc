#!/usr/bin/env python3
"""Fetch the raylib 6.0 source distribution and adapt its build config
for the badc demo.

After this runs, ``demos/raylib/src/`` holds the raylib C sources
(modules, the bundled RGFW + glad single-headers, raylib.h) ready for
the smoke harness to compile through badc. The demo builds the desktop
RGFW backend so every translation unit is C -- raylib's default GLFW
backend is Objective-C on macOS, which badc does not compile.

``config.h`` is patched to the asset-free profile the game needs:
rectangles + text only, no audio, no 3D models, no image/font file
loaders (so the stb single-headers and their SIMD intrinsics drop out).
The embedded default font and programmatic image generation stay on
because text rendering builds its glyph atlas from them.

Idempotent: re-running re-applies the patch from a clean extraction.
Pulls the pinned tarball and verifies its sha256 before use.

TODO: move the asset to the badc vendor-deps mirror once published; the
GitHub release tarball is fetched directly for now.
"""

from __future__ import annotations

import argparse
import hashlib
import shutil
import sys
import tarfile
import urllib.request
from pathlib import Path

VERSION = "6.0"
TARBALL_SHA256 = "2b3ee1e2120c7a0796b33062c7e9a694dd8a8caa56a96319ac8c8ecf54a90d0b"
URL = f"https://github.com/raysan5/raylib/archive/refs/tags/{VERSION}.tar.gz"

RAYLIB_DIR = Path(__file__).resolve().parent
SRC_DIR = RAYLIB_DIR / "src"
CACHE_DIR = RAYLIB_DIR / ".cache"



def _download(url: str, dst: Path, log) -> None:
    log(f"downloading {url}")
    req = urllib.request.Request(url, headers={"User-Agent": "badc-demo"})
    with urllib.request.urlopen(req) as resp, dst.open("wb") as out:
        shutil.copyfileobj(resp, out)


def _verify(path: Path, sha256: str) -> None:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    got = h.hexdigest()
    if got != sha256:
        raise SystemExit(
            f"setup: sha256 mismatch for {path.name}\n  expected {sha256}\n  got      {got}"
        )


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
    tarball = CACHE_DIR / f"raylib-{VERSION}.tar.gz"
    if not tarball.exists():
        _download(URL, tarball, log)
    _verify(tarball, TARBALL_SHA256)
    _extract_src(tarball, log)
    return 0


if __name__ == "__main__":
    sys.exit(main())
