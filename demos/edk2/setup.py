#!/usr/bin/env python3
"""Fetch the MdePkg subset the EDK II demo builds against.

The badc EDK II demo builds a UEFI application from real TianoCore EDK II
MdePkg sources -- the application entry-point library, the boot/runtime
services table libraries, BasePrintLib, BaseMemoryLib, and the BaseLib
math/string/unaligned helpers the app's library closure pulls in -- plus the
full ``MdePkg/Include`` header tree. Vendoring EDK II wholesale is ~200 MB; the
committed subset (headers + the closure's C files) is ~11 MB, ~1.8 MB packed.

After this runs, ``demos/edk2/src/`` holds the ``MdePkg/`` subtree. EDK II is
BSD-2-Clause-Patent licensed; ``License.txt`` travels in the archive.

Pulls from the ``kromych/badc`` vendor-deps mirror. Idempotent. ``-v`` traces.
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

VERSION = "202502"
SRC_UPSTREAM_SHA = "9339354d6f5714f4bda85441577221f1e804b3643e3919d23a4366c021b9bc46"
SRC_ASSET = f"edk2-mdepkg-{VERSION}-{SRC_UPSTREAM_SHA[:8]}.tar.gz"
SRC_SHA256 = SRC_UPSTREAM_SHA
RELEASE_TAG = "vendor-deps-v1"

EDK2_DIR = Path(__file__).resolve().parent
SRC_ROOT = EDK2_DIR / "src"


def _extract(tar_path: Path, prefix: str, dst_root: Path) -> None:
    if dst_root.exists():
        shutil.rmtree(dst_root)
    dst_root.mkdir(parents=True)
    with tarfile.open(tar_path, "r:gz") as tf:
        for member in tf.getmembers():
            name = member.name
            if not name.startswith(prefix + "/"):
                continue
            rel = name[len(prefix) + 1 :]
            if not rel:
                continue
            target = dst_root / rel
            if member.isdir():
                target.mkdir(parents=True, exist_ok=True)
            elif member.isreg():
                target.parent.mkdir(parents=True, exist_ok=True)
                with tf.extractfile(member) as fsrc, open(target, "wb") as fdst:
                    shutil.copyfileobj(fsrc, fdst)
                target.chmod(member.mode)


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("-v", "--verbose", action="store_true")
    args = ap.parse_args(argv)
    log = (lambda m: print(f"edk2 setup: {m}")) if args.verbose else (lambda _m: None)

    cache = EDK2_DIR / ".cache"
    cache.mkdir(exist_ok=True)
    src_tar = cache / SRC_ASSET
    _fetch.fetch_and_verify(RELEASE_TAG, SRC_ASSET, src_tar, SRC_SHA256, log)
    _extract(src_tar, "edk2-subset", SRC_ROOT)
    log(f"MdePkg subset ready at {SRC_ROOT}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
