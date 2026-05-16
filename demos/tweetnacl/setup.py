#!/usr/bin/env python3
"""Fetch the TweetNaCl 20140427 source snapshot from the badc vendor-deps mirror.

After this runs, ``demos/tweetnacl/{tweetnacl.c, tweetnacl.h}``
exist and are ready for badc to compile against.

TweetNaCl has no upstream tarball release; the canonical source
lives at https://tweetnacl.cr.yp.to/20140427/ as two files
(tweetnacl.c, tweetnacl.h). The vendor-deps mirror wraps the
pair in a single tar.gz so each demo can pull from one URL with
one sha256. The asset filename embeds the first 8 hex digits of
the sha256 of tweetnacl.c (the canonical content identifier),
not a git commit -- TweetNaCl is not under VCS at upstream. See
``scripts/vendor_deps/README.md`` for the auth model.

Idempotent: safe to call from CI before each smoke run. Output is
suppressed unless something fails -- pass ``-v`` to see every step.
"""

from __future__ import annotations

import argparse
import shutil
import sys
import tarfile
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(REPO_ROOT / "scripts" / "vendor_deps"))
import _fetch  # noqa: E402

VERSION = "20140427"
UPSTREAM_SHA = "02e65bc3013ff2168983365e55906bc783c4c7e0a60d8100f17bb303a17175c4"  # sha256(tweetnacl.c)
ASSET = f"tweetnacl-{VERSION}-{UPSTREAM_SHA[:8]}.tar.gz"
RELEASE_TAG = "vendor-deps-v1"
SHA256 = "c46004ab92456943582fbcd949b7b9dc59a5a7f18978801862c1b3a06bde308f"
WANTED = (
    "tweetnacl.c",
    "tweetnacl.h",
)


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args(argv)

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    tweetnacl_dir = Path(__file__).resolve().parent
    cache_dir = tweetnacl_dir / ".cache"
    tar_path = cache_dir / ASSET

    cache_dir.mkdir(parents=True, exist_ok=True)
    _fetch.fetch_and_verify(RELEASE_TAG, ASSET, tar_path, SHA256, log)

    log("extracting tweetnacl")
    prefix = f"tweetnacl-{VERSION}"
    with tarfile.open(tar_path, "r:gz") as tf:
        for name in WANTED:
            member = tf.getmember(f"{prefix}/{name}")
            with tf.extractfile(member) as src, (tweetnacl_dir / name).open("wb") as dst:
                shutil.copyfileobj(src, dst)

    if args.verbose:
        for name in WANTED:
            p = tweetnacl_dir / name
            log(f"done -- {p} {p.stat().st_size}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
