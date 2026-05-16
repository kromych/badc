#!/usr/bin/env python3
"""Fetch the Monocypher 4.0.2 source snapshot from the badc vendor-deps mirror.

After this runs, ``demos/monocypher/{monocypher.c, monocypher.h,
monocypher-ed25519.c, monocypher-ed25519.h}`` exist and are
ready for badc to compile against.

Pulls from the `kromych/badc` GitHub release rather than upstream
to avoid CI flakes against the upstream host. Filename embeds the
upstream version + the commit SHA short-prefix from the
github.com/LoupVaillant/Monocypher 4.0.2 tag commit; `_fetch`
verifies a pinned sha256 before extraction. See
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

VERSION = "4.0.2"
UPSTREAM_SHA = "bc1ca30b1b2654e4e7daf2492c0d204200e55137f23fda6b7142fd7d523bd6b4"  # tarball sha256
ASSET = f"monocypher-{VERSION}-{UPSTREAM_SHA[:8]}.tar.gz"
RELEASE_TAG = "vendor-deps-v1"
SHA256 = "bc1ca30b1b2654e4e7daf2492c0d204200e55137f23fda6b7142fd7d523bd6b4"
# Core + optional Ed25519 (RFC 8032 with SHA-512). The smoke
# harness wants the RFC 8032 vector to verify, which the
# default `crypto_eddsa_*` API (BLAKE2b-based) doesn't satisfy
# -- the optional `crypto_ed25519_*` family uses SHA-512 and
# matches RFC 8032 byte-for-byte.
WANTED = (
    ("src/monocypher.c", "monocypher.c"),
    ("src/monocypher.h", "monocypher.h"),
    ("src/optional/monocypher-ed25519.c", "monocypher-ed25519.c"),
    ("src/optional/monocypher-ed25519.h", "monocypher-ed25519.h"),
)


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args(argv)

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    mono_dir = Path(__file__).resolve().parent
    cache_dir = mono_dir / ".cache"
    tar_path = cache_dir / ASSET

    cache_dir.mkdir(parents=True, exist_ok=True)
    _fetch.fetch_and_verify(RELEASE_TAG, ASSET, tar_path, SHA256, log)

    log("extracting monocypher")
    prefix = f"Monocypher-{VERSION}"
    with tarfile.open(tar_path, "r:gz") as tf:
        for src_rel, dst_name in WANTED:
            member = tf.getmember(f"{prefix}/{src_rel}")
            with tf.extractfile(member) as src, (mono_dir / dst_name).open("wb") as dst:
                shutil.copyfileobj(src, dst)

    if args.verbose:
        for _, dst_name in WANTED:
            p = mono_dir / dst_name
            log(f"done -- {p} {p.stat().st_size}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
