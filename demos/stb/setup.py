#!/usr/bin/env python3
"""Fetch the stb header collection from the badc vendor-deps mirror.

After this runs, ``demos/stb/<header>.h`` exists for each header
in ``WANTED`` and is ready for badc to compile against.

Pulls from the `kromych/badc` GitHub release rather than upstream
to avoid CI flakes against the upstream host. stb does not cut
versioned releases -- the asset is pinned to a specific commit
on `nothings/stb@master`; the filename embeds the commit author
date as a synthetic version + the commit SHA short-prefix.
`_fetch` verifies a pinned sha256 before extraction. See
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

VERSION = "20260415"
UPSTREAM_SHA = "31c1ad37456438565541f4919958214b6e762fb4"  # github nothings/stb @ master
ASSET = f"stb-{VERSION}-{UPSTREAM_SHA[:8]}.zip"
RELEASE_TAG = "vendor-deps-v1"
SHA256 = "617266695cf191a45bec2405427207011a09b057133134594b0db6ccbf9ee0b2"

# Curated subset of stb headers the smoke compiles against. Kept
# in lock-step with smoke_main.c -- each entry here is a header
# the driver `#include`s. Other stb headers (stb_vorbis,
# stb_truetype, stb_image_resize2, stb_voxel_render,
# stb_tilemap_editor, ...) hit c5 dialect gaps tracked in gh #77
# and friends; this list is grown deliberately as fixes land.
WANTED = (
    "stb_sprintf.h",
    "stb_perlin.h",
    "stb_image_write.h",
    "stb_image.h",
    "stb_ds.h",
    "stb_rect_pack.h",
)


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args(argv)

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    stb_dir = Path(__file__).resolve().parent
    cache_dir = stb_dir / ".cache"
    zip_path = cache_dir / ASSET

    cache_dir.mkdir(parents=True, exist_ok=True)
    _fetch.fetch_and_verify(RELEASE_TAG, ASSET, zip_path, SHA256, log)

    log("extracting stb")
    # The github archive zip lays everything under
    # `stb-<full-sha>/`. Hard-code the prefix; if upstream
    # changes the layout, bump it here alongside the SHA.
    prefix = f"stb-{UPSTREAM_SHA}"
    with zipfile.ZipFile(zip_path) as zf:
        for name in WANTED:
            with zf.open(f"{prefix}/{name}") as src, (stb_dir / name).open("wb") as dst:
                shutil.copyfileobj(src, dst)

    if args.verbose:
        for name in WANTED:
            p = stb_dir / name
            log(f"done -- {p} {p.stat().st_size}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
