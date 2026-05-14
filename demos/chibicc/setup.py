#!/usr/bin/env python3
"""Fetch the chibicc source snapshot from the badc vendor-deps mirror.

After this runs, ``demos/chibicc/{chibicc.h, codegen.c, hashmap.c,
main.c, parse.c, preprocess.c, strings.c, tokenize.c, type.c,
unicode.c}`` exist alongside the in-tree shims under
``demos/chibicc/include/`` that this demo ships.

Pulls from the `kromych/badc` GitHub release rather than upstream
to avoid CI flakes against the upstream host. Filename embeds the
upstream commit SHA short-prefix from
github.com/rui314/chibicc; `_fetch` verifies a pinned sha256
before extraction. See ``scripts/vendor_deps/README.md`` for the
auth model.

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

VERSION = "20201207"
UPSTREAM_SHA = "90d1f7f199cc55b13c7fdb5839d1409806633fdb"  # github.com/rui314/chibicc HEAD
ASSET = f"chibicc-{VERSION}-{UPSTREAM_SHA[:8]}.zip"
RELEASE_TAG = "vendor-deps-v1"
SHA256 = "67427f0e190e3b641f35eeb007e620d646fa56effa103c10c43c3d017fa23bfb"
WANTED = (
    "chibicc.h",
    "codegen.c",
    "hashmap.c",
    "main.c",
    "parse.c",
    "preprocess.c",
    "strings.c",
    "tokenize.c",
    "type.c",
    "unicode.c",
)


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args(argv)

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    chibicc_dir = Path(__file__).resolve().parent
    cache_dir = chibicc_dir / ".cache"
    zip_path = cache_dir / ASSET

    cache_dir.mkdir(parents=True, exist_ok=True)
    _fetch.fetch_and_verify(RELEASE_TAG, ASSET, zip_path, SHA256, log)

    log("extracting chibicc")
    # The upstream zip lays everything under
    # `chibicc-<UPSTREAM_SHA>/`. We pick just the C source files we
    # want and drop them flat into our demo dir.
    prefix = f"chibicc-{UPSTREAM_SHA}"
    with zipfile.ZipFile(zip_path) as zf:
        for name in WANTED:
            with zf.open(f"{prefix}/{name}") as src, (chibicc_dir / name).open("wb") as dst:
                shutil.copyfileobj(src, dst)

    if args.verbose:
        for name in WANTED:
            p = chibicc_dir / name
            log(f"done -- {p} {p.stat().st_size}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
