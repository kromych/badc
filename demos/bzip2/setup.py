#!/usr/bin/env python3
"""Fetch the bzip2 1.0.8 release tarball from the badc vendor-deps mirror.

After this runs, ``demos/bzip2/{blocksort.c, huffman.c,
crctable.c, randtable.c, compress.c, decompress.c, bzlib.c,
bzlib.h, bzlib_private.h}`` exist and are ready for badc to
compile against.

The archive lives on a `kromych/badc` GitHub release rather than
sourceware.org for CI stability. The filename embeds the upstream
version and the upstream commit SHA short-prefix from
gitlab.com/bzip2-org/bzip2; integrity is checked against a
pinned sha256 before extraction.

Idempotent: re-running re-extracts the vanilla files. Safe to
call from CI before each smoke run. Output is suppressed
unless something fails -- pass ``-v`` to see every step.
"""

from __future__ import annotations

import argparse
import hashlib
import shutil
import sys
import tarfile
import urllib.request
from pathlib import Path

VERSION = "1.0.8"
UPSTREAM_SHA = "6a8690fc8d26c815e798c588f796eabe9d684cf0"  # gitlab bzip2-org/bzip2 tag bzip2-1.0.8
ASSET = f"bzip2-{VERSION}-{UPSTREAM_SHA[:8]}.tar.gz"
RELEASE_TAG = "vendor-deps-v1"
URL = f"https://github.com/kromych/badc/releases/download/{RELEASE_TAG}/{ASSET}"
SHA256 = "ab5a03176ee106d3f0fa90e381da478ddae405918153cca248e682cd0c4a2269"
WANTED = (
    "blocksort.c",
    "huffman.c",
    "crctable.c",
    "randtable.c",
    "compress.c",
    "decompress.c",
    "bzlib.c",
    "bzlib.h",
    "bzlib_private.h",
)


def sha256_of(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def ensure_archive(dst: Path, log) -> None:
    if dst.is_file() and sha256_of(dst) == SHA256:
        return
    if dst.is_file():
        log(f"stale archive at {dst}, refetching")
        dst.unlink()
    log(f"fetching {URL}")
    with urllib.request.urlopen(URL) as resp, dst.open("wb") as out:
        shutil.copyfileobj(resp, out)
    actual = sha256_of(dst)
    if actual != SHA256:
        dst.unlink(missing_ok=True)
        sys.exit(
            f"sha256 mismatch on {ASSET}: expected {SHA256}, got {actual}"
        )


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args(argv)

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    bzip2_dir = Path(__file__).resolve().parent
    cache_dir = bzip2_dir / ".cache"
    tar_path = cache_dir / ASSET

    cache_dir.mkdir(parents=True, exist_ok=True)
    ensure_archive(tar_path, log)

    log("extracting bzip2")
    # The upstream tarball lays everything under `bzip2-<VERSION>/`.
    # `tarfile.extract` is path-traversal-safe per stdlib docs as
    # long as we don't follow absolute / symlink members; the
    # explicit per-member loop below picks just the source files
    # we want and writes them under our own directory rather
    # than reproducing the directory structure.
    prefix = f"bzip2-{VERSION}"
    with tarfile.open(tar_path, "r:gz") as tf:
        for name in WANTED:
            member = tf.getmember(f"{prefix}/{name}")
            with tf.extractfile(member) as src, (bzip2_dir / name).open("wb") as dst:
                shutil.copyfileobj(src, dst)

    if args.verbose:
        for name in WANTED:
            p = bzip2_dir / name
            log(f"done -- {p} {p.stat().st_size}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
