#!/usr/bin/env python3
"""Fetch the miniz release zip from the badc vendor-deps mirror.

After this runs, ``demos/miniz/{miniz.c, miniz.h}`` exist and
are ready for badc to compile against.

The archive lives on a `kromych/badc` GitHub release rather than
upstream's `richgel999/miniz` because hitting upstream from CI was
flaky (transient `RemoteDisconnected`s on macos runners). The
filename embeds the upstream version and the upstream commit SHA
short-prefix so we can retrace where it came from; integrity is
checked against a pinned sha256 before extraction.

Idempotent: re-running re-extracts the vanilla files. Safe to
call from CI before each smoke run. Output is suppressed
unless something fails -- pass ``-v`` to see every step.
"""

from __future__ import annotations

import argparse
import hashlib
import shutil
import sys
import urllib.request
import zipfile
from pathlib import Path

VERSION = "3.1.1"
UPSTREAM_SHA = "d10b03cc73475af673df40f06e5cefd1d5f940d9"  # github richgel999/miniz tag 3.1.1
ASSET = f"miniz-{VERSION}-{UPSTREAM_SHA[:8]}.zip"
RELEASE_TAG = "vendor-deps-v1"
URL = f"https://github.com/kromych/badc/releases/download/{RELEASE_TAG}/{ASSET}"
SHA256 = "cb28402bb2af93bdc331b60d16807e89727d1712a2d0a7ba0cac79a3e406fe40"
WANTED = ("miniz.c", "miniz.h")


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

    miniz_dir = Path(__file__).resolve().parent
    cache_dir = miniz_dir / ".cache"
    zip_path = cache_dir / ASSET

    cache_dir.mkdir(parents=True, exist_ok=True)
    ensure_archive(zip_path, log)

    log("extracting miniz")
    with zipfile.ZipFile(zip_path) as zf:
        for name in WANTED:
            with zf.open(name) as src, (miniz_dir / name).open("wb") as dst:
                shutil.copyfileobj(src, dst)

    if args.verbose:
        for name in WANTED:
            p = miniz_dir / name
            log(f"done -- {p} {p.stat().st_size}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
