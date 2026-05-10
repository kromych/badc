#!/usr/bin/env python3
"""Fetch the bzip2 1.0.8 release tarball.

After this runs, ``demos/bzip2/{blocksort.c, huffman.c,
crctable.c, randtable.c, compress.c, decompress.c, bzlib.c,
bzlib.h, bzlib_private.h}`` exist and are ready for badc to
compile against.

Idempotent: re-running re-extracts the vanilla files. Safe to
call from CI before each smoke run. Output is suppressed
unless something fails -- pass ``-v`` to see every step.
"""

from __future__ import annotations

import argparse
import shutil
import sys
import tarfile
import urllib.request
from pathlib import Path

VERSION = "1.0.8"
URL = f"https://sourceware.org/pub/bzip2/bzip2-{VERSION}.tar.gz"
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


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args(argv)

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    bzip2_dir = Path(__file__).resolve().parent
    cache_dir = bzip2_dir / ".cache"
    tar_path = cache_dir / f"bzip2-{VERSION}.tar.gz"

    cache_dir.mkdir(parents=True, exist_ok=True)

    if not tar_path.is_file():
        log(f"fetching {URL}")
        with urllib.request.urlopen(URL) as resp, tar_path.open("wb") as out:
            shutil.copyfileobj(resp, out)

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
