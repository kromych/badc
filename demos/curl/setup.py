#!/usr/bin/env python3
"""Fetch the curl 8.23.0 and Mbed TLS 3.6.7 source distributions for the
badc demo.

After this runs, ``demos/curl/src/`` holds curl's ``lib/`` tree (the
library sources compiled by badc), ``demos/curl/include/curl/`` holds
the public API headers, and ``demos/curl/mbedtls/`` holds Mbed TLS's
``library/`` and ``include/`` trees, the TLS backend of the HTTPS lane.
The hand-written configuration headers and the driver/binding sources
live beside this script and are not touched.

Pulls the pinned tarballs from the ``kromych/badc`` vendor-deps mirror,
verified against their sha256. Idempotent: safe to call from CI before
each smoke run; ``-v`` prints every step.
"""

from __future__ import annotations

import argparse
import shutil
import sys
import tarfile
from pathlib import Path

CURL_DIR = Path(__file__).resolve().parent
SRC_DIR = CURL_DIR / "src"
INC_DIR = CURL_DIR / "include" / "curl"
MBEDTLS_DIR = CURL_DIR / "mbedtls"
CACHE_DIR = CURL_DIR / ".cache"

REPO_ROOT = CURL_DIR.parents[1]
sys.path.insert(0, str(REPO_ROOT / "scripts" / "vendor_deps"))
import _fetch  # noqa: E402

RELEASE_TAG = "vendor-deps-v1"

VERSION = "8.23.0"
UPSTREAM_SHA = "e3de77cfa6367083c776a26647fc9f633b538c06c3baa73d931a252ac8f72b49"  # tarball sha256
ASSET = f"curl-{VERSION}-{UPSTREAM_SHA[:8]}.tar.gz"
SHA256 = UPSTREAM_SHA

# Mbed TLS 3.6 (LTS): the release archive builds without a configure step.
MBEDTLS_VERSION = "3.6.7"
MBEDTLS_UPSTREAM_SHA = "a7e8bcbec0e6f761b4af24f25677626b35f762f68eef79c08677a363212d11f6"
MBEDTLS_ASSET = f"mbedtls-{MBEDTLS_VERSION}-{MBEDTLS_UPSTREAM_SHA[:8]}.tar.bz2"


def _extract(tar_path: Path, routes: dict[str, Path], log) -> None:
    """Extract the members under each `routes` prefix into its directory,
    replacing the directory."""
    for d in routes.values():
        if d.exists():
            shutil.rmtree(d)
        d.mkdir(parents=True)
    with tarfile.open(tar_path) as tf:
        for member in tf.getmembers():
            for prefix, root in routes.items():
                if member.name.startswith(prefix):
                    rel = member.name[len(prefix):]
                    break
            else:
                continue
            if not rel:
                continue
            dest = root / rel
            if member.isdir():
                dest.mkdir(parents=True, exist_ok=True)
                continue
            src = tf.extractfile(member)
            if src is None:
                continue
            dest.parent.mkdir(parents=True, exist_ok=True)
            with src as inp, dest.open("wb") as out:
                shutil.copyfileobj(inp, out)
    log(f"extracted {tar_path.name} -> {', '.join(str(d) for d in routes.values())}")


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args(argv)

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    tar_path = CACHE_DIR / ASSET
    _fetch.fetch_and_verify(RELEASE_TAG, ASSET, tar_path, SHA256, log)
    _extract(tar_path, {f"curl-{VERSION}/lib/": SRC_DIR,
                        f"curl-{VERSION}/include/curl/": INC_DIR}, log)

    tls_path = CACHE_DIR / MBEDTLS_ASSET
    _fetch.fetch_and_verify(RELEASE_TAG, MBEDTLS_ASSET, tls_path, MBEDTLS_UPSTREAM_SHA, log)
    prefix = f"mbedtls-{MBEDTLS_VERSION}/"
    _extract(tls_path, {f"{prefix}library/": MBEDTLS_DIR / "library",
                        f"{prefix}include/": MBEDTLS_DIR / "include"}, log)
    return 0


if __name__ == "__main__":
    sys.exit(main())
