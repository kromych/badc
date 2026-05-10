#!/usr/bin/env python3
"""Fetch the miniz release zip.

After this runs, ``demos/miniz/{miniz.c, miniz.h}`` exist and
are ready for badc to compile against.

Idempotent: re-running re-extracts the vanilla files. Safe to
call from CI before each smoke run. Output is suppressed
unless something fails -- pass ``-v`` to see every step.
"""

from __future__ import annotations

import argparse
import shutil
import sys
import urllib.request
import zipfile
from pathlib import Path

VERSION = "3.1.1"
URL = f"https://github.com/richgel999/miniz/releases/download/{VERSION}/miniz-{VERSION}.zip"
WANTED = ("miniz.c", "miniz.h")


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args(argv)

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    miniz_dir = Path(__file__).resolve().parent
    cache_dir = miniz_dir / ".cache"
    zip_path = cache_dir / f"miniz-{VERSION}.zip"

    cache_dir.mkdir(parents=True, exist_ok=True)

    if not zip_path.is_file():
        log(f"fetching {URL}")
        # urllib follows the github -> release-assets CDN redirect
        # automatically. The release zip is < 200 KB so streaming
        # vs in-memory makes no difference; copyfileobj keeps the
        # peak RSS predictable.
        with urllib.request.urlopen(URL) as resp, zip_path.open("wb") as out:
            shutil.copyfileobj(resp, out)

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
