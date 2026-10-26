#!/usr/bin/env python3
"""Fetch the SQLite amalgamation zip from the badc vendor-deps mirror.

After this runs, ``demos/sqlite3/{sqlite3.c, shell.c,
sqlite3.h, sqlite3ext.h}`` exist and are ready for badc to
compile against.

Pulls from the `kromych/badc` GitHub release rather than
sqlite.org to avoid CI flakes. Filename embeds the upstream
version + Fossil release hash short-prefix (SQLite uses Fossil
rather than git, so the SHA matches `SQLITE_SOURCE_ID` in
`sqlite3.c`); `_fetch` verifies a pinned sha256 before
extraction. See ``scripts/vendor_deps/README.md`` for the auth
model.

Idempotent: safe to call from CI before each smoke run. Output is
suppressed unless something fails -- pass ``-v`` to see every step.
"""

from __future__ import annotations

import argparse
import shutil
import sys
import zipfile
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(REPO_ROOT / "scripts" / "vendor_deps"))
import _fetch  # noqa: E402

VERSION = "3540100"  # 3.54.1 (October 2026)
UPSTREAM_SHA = "555e07ef33f69a0957d24d8e555b702464a131d6f1607f4c3c1e4551e8e6ca76"  # SQLite Fossil release hash for 3.54.1
ASSET = f"sqlite-amalgamation-{VERSION}-{UPSTREAM_SHA[:8]}.zip"
RELEASE_TAG = "vendor-deps-v1"
SHA256 = "0a9c8e34352dad46006aa82836d5383bff9dc6bc9ce5a60553c05aa30e6ad1f9"
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
    zip_path = cache_dir / ASSET
    extract_root = cache_dir / f"sqlite-amalgamation-{VERSION}"

    cache_dir.mkdir(parents=True, exist_ok=True)
    _fetch.fetch_and_verify(RELEASE_TAG, ASSET, zip_path, SHA256, log)

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
