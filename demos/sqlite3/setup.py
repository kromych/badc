#!/usr/bin/env python3
"""Fetch the SQLite amalgamation zip from the badc vendor-deps mirror.

After this runs, ``demos/sqlite3/{sqlite3.c, shell.c,
sqlite3.h, sqlite3ext.h}`` exist and are ready for badc to
compile against.

The archive lives on a `kromych/badc` GitHub release rather than
sqlite.org for CI stability. The filename embeds the upstream
version and the upstream Fossil release hash short-prefix
(SQLite uses Fossil rather than git, so the SHA matches
`SQLITE_SOURCE_ID` in `sqlite3.c`); integrity is checked against
a pinned sha256 before extraction.

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

VERSION = "3530000"  # 3.53.0 (April 2026)
UPSTREAM_SHA = "4525003a53a7fc63ca75c59b22c79608659ca12f0131f52c18637f829977f20b"  # SQLite Fossil release hash for 3.53.0
ASSET = f"sqlite-amalgamation-{VERSION}-{UPSTREAM_SHA[:8]}.zip"
RELEASE_TAG = "vendor-deps-v1"
URL = f"https://github.com/kromych/badc/releases/download/{RELEASE_TAG}/{ASSET}"
SHA256 = "bf3733d7c71b3ab0f6fd8a9ea0052ad87fa037d94333e14ce09878ba3492c3b0"
WANTED = ("sqlite3.c", "sqlite3.h", "sqlite3ext.h", "shell.c")


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

    sqlite_dir = Path(__file__).resolve().parent
    cache_dir = sqlite_dir / ".cache"
    zip_path = cache_dir / ASSET
    extract_root = cache_dir / f"sqlite-amalgamation-{VERSION}"

    cache_dir.mkdir(parents=True, exist_ok=True)
    ensure_archive(zip_path, log)

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
