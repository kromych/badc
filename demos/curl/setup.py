#!/usr/bin/env python3
"""Fetch the curl 8.11.1 source distribution for the badc demo.

After this runs, ``demos/curl/src/`` holds curl's ``lib/`` tree (the
library sources compiled by badc) and ``demos/curl/include/curl/``
holds the public API headers. The hand-written ``curl_config.h`` and
the driver/binding sources live beside this script and are not
touched.

Pulls the pinned tarball from the ``kromych/badc`` vendor-deps mirror
first (verified against a sha256), falling back to ``curl.se`` when
the asset is not yet on the mirror. Idempotent: safe to call from CI
before each smoke run; ``-v`` prints every step.
"""

from __future__ import annotations

import argparse
import shutil
import sys
import tarfile
import urllib.request
from pathlib import Path

CURL_DIR = Path(__file__).resolve().parent
SRC_DIR = CURL_DIR / "src"
INC_DIR = CURL_DIR / "include" / "curl"
CACHE_DIR = CURL_DIR / ".cache"

REPO_ROOT = CURL_DIR.parents[1]
sys.path.insert(0, str(REPO_ROOT / "scripts" / "vendor_deps"))
import _fetch  # noqa: E402

VERSION = "8.11.1"
UPSTREAM_SHA = "a889ac9dbba3644271bd9d1302b5c22a088893719b72be3487bc3d401e5c4e80"  # tarball sha256
ASSET = f"curl-{VERSION}-{UPSTREAM_SHA[:8]}.tar.gz"
RELEASE_TAG = "vendor-deps-v1"
SHA256 = UPSTREAM_SHA
# TODO: drop the direct fallback once the asset is uploaded to the
# vendor-deps mirror (see scripts/vendor_deps/README.md).
URL_FALLBACK = f"https://curl.se/download/curl-{VERSION}.tar.gz"

PREFIX = f"curl-{VERSION}/"


def _fetch_tarball(tar_path: Path, log) -> None:
    try:
        _fetch.fetch_and_verify(RELEASE_TAG, ASSET, tar_path, SHA256, log)
        return
    except SystemExit:
        log(f"vendor-deps mirror miss, falling back to {URL_FALLBACK}")
    req = urllib.request.Request(URL_FALLBACK, headers={"User-Agent": "badc-demo"})
    with urllib.request.urlopen(req) as resp, tar_path.open("wb") as out:
        shutil.copyfileobj(resp, out)
    got = _fetch.sha256_of(tar_path)
    if got != SHA256:
        tar_path.unlink(missing_ok=True)
        raise SystemExit(f"setup: sha256 mismatch for {ASSET}\n  expected {SHA256}\n  got      {got}")


def _extract(tar_path: Path, log) -> None:
    for d in (SRC_DIR, INC_DIR):
        if d.exists():
            shutil.rmtree(d)
    SRC_DIR.mkdir(parents=True)
    INC_DIR.mkdir(parents=True)
    lib_prefix = f"{PREFIX}lib/"
    inc_prefix = f"{PREFIX}include/curl/"
    with tarfile.open(tar_path, "r:gz") as tf:
        for member in tf.getmembers():
            if member.name.startswith(lib_prefix):
                rel = member.name[len(lib_prefix):]
                dest = SRC_DIR / rel
            elif member.name.startswith(inc_prefix) and member.name.endswith(".h"):
                rel = member.name[len(inc_prefix):]
                dest = INC_DIR / rel
            else:
                continue
            if not rel:
                continue
            if member.isdir():
                dest.mkdir(parents=True, exist_ok=True)
                continue
            src = tf.extractfile(member)
            if src is None:
                continue
            dest.parent.mkdir(parents=True, exist_ok=True)
            with src as inp, dest.open("wb") as out:
                shutil.copyfileobj(inp, out)
    log(f"extracted curl {VERSION} lib -> {SRC_DIR}, headers -> {INC_DIR}")


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args(argv)

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    tar_path = CACHE_DIR / ASSET
    _fetch_tarball(tar_path, log)
    _extract(tar_path, log)
    return 0


if __name__ == "__main__":
    sys.exit(main())
