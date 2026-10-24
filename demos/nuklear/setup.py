#!/usr/bin/env python3
"""Fetch Nuklear from the badc vendor-deps mirror.

Pins tag v4.13.3 of `Immediate-Mode-UI/Nuklear`. The asset on the
`kromych/badc` release is the upstream GitHub archive of that tag, named
after the release and the first 8 hex digits of the tarball's sha256;
``_fetch`` verifies the full digest before extraction, and the tree lands
under ``demos/nuklear/.cache/Nuklear-4.13.3/``, used as upstream ships it.
See ``scripts/vendor_deps/README.md`` for the auth model.

Idempotent: safe to call from CI before each smoke run. Re-extracts only
when the tree is absent. Output is suppressed unless something fails --
pass ``-v`` to see every step.
"""

from __future__ import annotations

import argparse
import sys
import tarfile
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(REPO_ROOT / "scripts" / "vendor_deps"))
import _fetch  # noqa: E402

VERSION = "4.13.3"
SHA256 = "834bf30974a294e996f7b1222aa59f1eb4ee259bd8d7d7967e8a2fb213d82dde"
ASSET = f"nuklear-{VERSION}-{SHA256[:8]}.tar.gz"
RELEASE_TAG = "vendor-deps-v1"
SRC_DIRNAME = f"Nuklear-{VERSION}"


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
    src = cache / SRC_DIRNAME

    cached = tar_path.is_file() and _fetch.sha256_of(tar_path) == SHA256
    if cached and (src / "nuklear.h").is_file():
        log(f"done -- {src}")
        return 0
    _fetch.fetch_and_verify(RELEASE_TAG, ASSET, tar_path, SHA256, log)

    log("extracting")
    with tarfile.open(tar_path, "r:gz") as tf:
        tf.extractall(cache)
    for name in ("nuklear.h", "src/build.py", "demo/rawfb/nuklear_rawfb.h",
                 "demo/common/overview.c", "demo/gdi/main.c"):
        if not (src / name).is_file():
            sys.exit(f"setup: expected {src}/{name} after extraction")
    log(f"done -- {src}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
