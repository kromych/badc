#!/usr/bin/env python3
"""Fetch the KISS FFT release tarball.

After this runs, ``demos/kissfft/{kiss_fft.c, kiss_fft.h,
kiss_fftr.c, kiss_fftr.h, _kiss_fft_guts.h, kiss_fft_log.h}``
exist and are ready for badc to compile against.

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

VERSION = "131.2.0"
URL = f"https://github.com/mborgerding/kissfft/archive/refs/tags/{VERSION}.zip"
WANTED = (
    "kiss_fft.c",
    "kiss_fft.h",
    "kiss_fftr.c",
    "kiss_fftr.h",
    "_kiss_fft_guts.h",
    "kiss_fft_log.h",
)


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args(argv)

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    kissfft_dir = Path(__file__).resolve().parent
    cache_dir = kissfft_dir / ".cache"
    zip_path = cache_dir / f"kissfft-{VERSION}.zip"

    cache_dir.mkdir(parents=True, exist_ok=True)

    if not zip_path.is_file():
        log(f"fetching {URL}")
        with urllib.request.urlopen(URL) as resp, zip_path.open("wb") as out:
            shutil.copyfileobj(resp, out)

    log("extracting kissfft")
    # The github auto-generated source zip extracts under
    # `kissfft-<VERSION>/`, so each wanted file lives under
    # that prefix. Hard-coding the prefix keeps the script
    # simple; if upstream ever changes the layout, bump the
    # path here alongside the version.
    prefix = f"kissfft-{VERSION}"
    with zipfile.ZipFile(zip_path) as zf:
        for name in WANTED:
            with zf.open(f"{prefix}/{name}") as src, (kissfft_dir / name).open("wb") as dst:
                shutil.copyfileobj(src, dst)

    if args.verbose:
        for name in WANTED:
            p = kissfft_dir / name
            log(f"done -- {p} {p.stat().st_size}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
