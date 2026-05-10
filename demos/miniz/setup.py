#!/usr/bin/env python3
"""Fetch the miniz release zip from the badc vendor-deps mirror.

After this runs, ``demos/miniz/{miniz.c, miniz.h}`` exist and
are ready for badc to compile against.

Pulls from the `kromych/badc` GitHub release rather than upstream
to avoid CI flakes against the upstream host. Filename embeds the
upstream version + commit SHA short-prefix; `_fetch` verifies a
pinned sha256 before extraction. See
``scripts/vendor_deps/README.md`` for the auth model.

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

VERSION = "3.1.1"
UPSTREAM_SHA = "d10b03cc73475af673df40f06e5cefd1d5f940d9"  # github richgel999/miniz tag 3.1.1
ASSET = f"miniz-{VERSION}-{UPSTREAM_SHA[:8]}.zip"
RELEASE_TAG = "vendor-deps-v1"
SHA256 = "cb28402bb2af93bdc331b60d16807e89727d1712a2d0a7ba0cac79a3e406fe40"
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
    zip_path = cache_dir / ASSET

    cache_dir.mkdir(parents=True, exist_ok=True)
    _fetch.fetch_and_verify(RELEASE_TAG, ASSET, zip_path, SHA256, log)

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
