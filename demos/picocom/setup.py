#!/usr/bin/env python3
"""Fetch picocom from the badc vendor-deps mirror.

Pins release 3.1 of `npat-efault/picocom`. The asset on the
`kromych/badc` release is the upstream GitHub archive of that tag,
named after the release and the first 8 hex digits of the tarball's
sha256; ``_fetch`` verifies the full digest before extraction, and the
tree lands under ``demos/picocom/.cache/picocom-3.1/``, used as
upstream ships it. See ``scripts/vendor_deps/README.md`` for the auth
model.

Exits with status ``MISSING_ASSET``, naming the asset, when the release
does not carry it; the smoke reports that as a skip.

Idempotent: safe to call from CI before each smoke run. Output is
suppressed unless something fails -- pass ``-v`` to see every step.
"""

from __future__ import annotations

import argparse
import shutil
import sys
import tarfile
import urllib.error
import urllib.request
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(REPO_ROOT / "scripts" / "vendor_deps"))
import _fetch  # noqa: E402

VERSION = "3.1"
SHA256 = "e6761ca932ffc6d09bd6b11ff018bdaf70b287ce518b3282d29e0270e88420bb"
ASSET = f"picocom-{VERSION}-{SHA256[:8]}.tar.gz"
RELEASE_TAG = "vendor-deps-v1"
SRC_DIRNAME = f"picocom-{VERSION}"

MISSING_ASSET = 3


def asset_is_published() -> bool:
    """Whether the release carries ASSET: asked of the API with a token,
    else of the public download URL, where a 404 also stands for a
    private repository reached without one."""
    if _fetch._token():
        return _fetch._api_asset_url(RELEASE_TAG, ASSET, required=False) is not None
    url = f"https://github.com/{_fetch.REPO}/releases/download/{RELEASE_TAG}/{ASSET}"
    try:
        with _fetch._urlopen_retry(
            lambda: urllib.request.urlopen(urllib.request.Request(url, method="HEAD"))
        ):
            return True
    except urllib.error.HTTPError as e:
        if e.code == 404:
            return False
        raise


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args(argv)

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    cache = Path(__file__).resolve().parent / ".cache"
    cache.mkdir(parents=True, exist_ok=True)
    tar_path = cache / ASSET

    cached = tar_path.is_file() and _fetch.sha256_of(tar_path) == SHA256
    if not cached and not asset_is_published():
        print(
            f"setup: asset {ASSET} is not on release {RELEASE_TAG} of {_fetch.REPO}",
            file=sys.stderr,
        )
        return MISSING_ASSET
    _fetch.fetch_and_verify(RELEASE_TAG, ASSET, tar_path, SHA256, log)

    src = cache / SRC_DIRNAME
    if src.exists():
        shutil.rmtree(src)
    log("extracting")
    with tarfile.open(tar_path, "r:gz") as tf:
        tf.extractall(cache)
    for name in ("Makefile", "picocom.c", "term.c", "linenoise-1.0/linenoise.c"):
        if not (src / name).is_file():
            sys.exit(f"setup: expected {src}/{name} after extraction")
    log(f"done -- {src}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
