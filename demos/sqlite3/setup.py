#!/usr/bin/env python3
"""Fetch the SQLite amalgamation tarball.

After this runs, ``demos/sqlite3/{sqlite3.c, shell.c,
sqlite3.h, sqlite3ext.h}`` exist and are ready for badc to
compile against.

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

VERSION = "3530000"  # 3.53.0 (April 2026)
URL = f"https://www.sqlite.org/2026/sqlite-amalgamation-{VERSION}.zip"
WANTED = ("sqlite3.c", "sqlite3.h", "sqlite3ext.h", "shell.c")


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args(argv)

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    sqlite_dir = Path(__file__).resolve().parent
    cache_dir = sqlite_dir / ".cache"
    zip_path = cache_dir / f"sqlite-amalgamation-{VERSION}.zip"
    extract_root = cache_dir / f"sqlite-amalgamation-{VERSION}"

    cache_dir.mkdir(parents=True, exist_ok=True)

    if not zip_path.is_file():
        log(f"fetching {URL}")
        with urllib.request.urlopen(URL) as resp, zip_path.open("wb") as out:
            shutil.copyfileobj(resp, out)

    log("extracting amalgamation")
    if extract_root.exists():
        shutil.rmtree(extract_root)
    with zipfile.ZipFile(zip_path) as zf:
        zf.extractall(cache_dir)

    for name in WANTED:
        src = extract_root / name
        dst = sqlite_dir / name
        shutil.copyfile(src, dst)

    if args.verbose:
        for name in ("sqlite3.c", "shell.c"):
            p = sqlite_dir / name
            log(f"done -- {p} {p.stat().st_size}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
