#!/usr/bin/env python3
"""Fetch the scc source snapshot from the badc vendor-deps mirror.

After this runs, ``demos/scc/src/`` exists with the upstream scc
tree (the simple c99 compiler by k0ga, mirrored from
git.simple-cc.org/scc). The execute test suite lives at
``demos/scc/src/tests/cc/execute/``; ``smoke.py`` builds each
script through badc and tallies the pass rate.

Pulls from the ``kromych/badc`` GitHub vendor-deps release
because git.simple-cc.org speaks only the bare git protocol; CI
that hits unencrypted git:// from a github-hosted runner is slow
and unreliable. Filename embeds the upstream commit SHA short-
prefix from git.simple-cc.org/scc HEAD; ``_fetch`` verifies a
pinned sha256 before extraction.

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

VERSION = "20260529"
UPSTREAM_SHA = "cd2e378821e5e5f86215643e87a6b806a8b54492"  # git.simple-cc.org/scc HEAD
ASSET = f"scc-{VERSION}-{UPSTREAM_SHA[:8]}.tar.gz"
RELEASE_TAG = "vendor-deps-v1"
SHA256 = "1fcfbde219ba9864394a75fbd1685c00ced093dab91d2c739c86e6f73de8c899"


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args(argv)

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    scc_dir = Path(__file__).resolve().parent
    cache_dir = scc_dir / ".cache"
    tar_path = cache_dir / ASSET
    src_dir = scc_dir / "src"

    cache_dir.mkdir(parents=True, exist_ok=True)
    _fetch.fetch_and_verify(RELEASE_TAG, ASSET, tar_path, SHA256, log)

    log("extracting scc")
    # The upstream tarball lays everything under
    # `scc-<VERSION>-<SHA_SHORT>/`. Rename to `src/` for a stable
    # in-tree path the smoke harness can walk.
    if src_dir.exists():
        shutil.rmtree(src_dir)
    prefix = ASSET[: -len(".tar.gz")]
    tmp_root = scc_dir / ".extract"
    if tmp_root.exists():
        shutil.rmtree(tmp_root)
    tmp_root.mkdir()
    with tarfile.open(tar_path) as tf:
        tf.extractall(tmp_root)
    shutil.move(str(tmp_root / prefix), str(src_dir))
    shutil.rmtree(tmp_root)

    if args.verbose:
        log(f"done -- {src_dir}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
