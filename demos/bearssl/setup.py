#!/usr/bin/env python3
"""Fetch the BearSSL 0.6 source snapshot from the badc vendor-deps mirror.

After this runs, ``demos/bearssl/{inc/*, src/**}`` exist and
are ready for badc to compile against. The vendored set is the
entire upstream `src/` tree plus `inc/` headers -- every .c and
.h file BearSSL ships. Files gated on host-specific intrinsic
macros (`BR_AES_X86NI`, `BR_POWER8`, `BR_SSE2`) expand to empty
TUs under badc since those macros stay undefined; the
constant-time portable variants carry the runtime path.

The smoke harness picks the focused subset of TUs the driver
exercises; the rest stay on disk so the bringup can extend
gradually without re-running setup.

Pulls from the `kromych/badc` GitHub release rather than upstream
to avoid CI flakes against the upstream host. Filename embeds the
upstream version + the sha256-prefix of the BearSSL tarball
(BearSSL doesn't publish per-release commit SHAs); `_fetch`
verifies a pinned sha256 before extraction.

Idempotent: safe to call from CI before each smoke run.
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

VERSION = "0.6"
UPSTREAM_SHA = "6705bba1714961b41a728dfc5debbe348d2966c117649392f8c8139efc83ff14"
ASSET = f"bearssl-{VERSION}-{UPSTREAM_SHA[:8]}.tar.gz"
RELEASE_TAG = "vendor-deps-v1"
SHA256 = "6705bba1714961b41a728dfc5debbe348d2966c117649392f8c8139efc83ff14"


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args(argv)

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    bear_dir = Path(__file__).resolve().parent
    cache_dir = bear_dir / ".cache"
    tar_path = cache_dir / ASSET

    cache_dir.mkdir(parents=True, exist_ok=True)
    _fetch.fetch_and_verify(RELEASE_TAG, ASSET, tar_path, SHA256, log)

    log("extracting bearssl")
    prefix = f"bearssl-{VERSION}"
    inc_prefix = f"{prefix}/inc/"
    src_prefix = f"{prefix}/src/"
    test_prefix = f"{prefix}/test/"
    extracted = 0
    with tarfile.open(tar_path, "r:gz") as tf:
        for m in tf.getmembers():
            if not m.isfile():
                continue
            if (
                m.name.startswith(inc_prefix)
                or m.name.startswith(src_prefix)
                or m.name.startswith(test_prefix)
            ):
                rel = m.name[len(prefix) + 1 :]
            else:
                continue
            if not (rel.endswith(".c") or rel.endswith(".h")):
                continue
            dst = bear_dir / rel
            dst.parent.mkdir(parents=True, exist_ok=True)
            with tf.extractfile(m) as src, dst.open("wb") as out:
                shutil.copyfileobj(src, out)
            extracted += 1

    if args.verbose:
        log(f"extracted {extracted} files")
    return 0


if __name__ == "__main__":
    sys.exit(main())
