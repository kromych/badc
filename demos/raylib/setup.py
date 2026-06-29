#!/usr/bin/env python3
"""Fetch the raylib 5.5 source distribution and adapt its build config
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

VERSION = "5.5"
TARBALL_SHA256 = "aea98ecf5bc5c5e0b789a76de0083a21a70457050ea4cc2aec7566935f5e258e"
URL = f"https://github.com/raysan5/raylib/archive/refs/tags/{VERSION}.tar.gz"

RAYLIB_DIR = Path(__file__).resolve().parent
SRC_DIR = RAYLIB_DIR / "src"
CACHE_DIR = RAYLIB_DIR / ".cache"

# config.h flags flipped to 0 for the asset-free build. Everything else
# in raylib's config.h (render-batch sizes, default font, image
# generation) is left at its upstream value.
DISABLE_FLAGS = (
    "SUPPORT_MODULE_RAUDIO",
    "SUPPORT_MODULE_RMODELS",
    "SUPPORT_FILEFORMAT_PNG",
    "SUPPORT_FILEFORMAT_BMP",
    "SUPPORT_FILEFORMAT_TGA",
    "SUPPORT_FILEFORMAT_JPG",
    "SUPPORT_FILEFORMAT_GIF",
    "SUPPORT_FILEFORMAT_QOI",
    "SUPPORT_FILEFORMAT_PSD",
    "SUPPORT_FILEFORMAT_DDS",
    "SUPPORT_FILEFORMAT_HDR",
    "SUPPORT_FILEFORMAT_PIC",
    "SUPPORT_FILEFORMAT_PNM",
    "SUPPORT_FILEFORMAT_KTX",
    "SUPPORT_FILEFORMAT_ASTC",
    "SUPPORT_FILEFORMAT_PKM",
    "SUPPORT_FILEFORMAT_PVR",
    "SUPPORT_FILEFORMAT_TTF",
    "SUPPORT_FILEFORMAT_FNT",
    "SUPPORT_FILEFORMAT_BDF",
    "SUPPORT_IMAGE_MANIPULATION",
    "SUPPORT_IMAGE_EXPORT",
)


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


def _patch_config(log) -> None:
    config = SRC_DIR / "config.h"
    text = config.read_text()
    for flag in DISABLE_FLAGS:
        # Match the upstream `#define <FLAG>  1` (any spacing) and set 0.
        import re

        text, n = re.subn(
            rf"(#define\s+{flag}\s+)1\b", r"\g<1>0", text, count=1
        )
        if n == 0:
            log(f"  note: flag {flag} not found (skipped)")
    config.write_text(text)
    log("patched config.h to the asset-free profile")


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
    _patch_config(log)
    return 0


if __name__ == "__main__":
    sys.exit(main())
