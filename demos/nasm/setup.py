#!/usr/bin/env python3
"""Fetch the NASM 2.16.03 release tarball from the badc vendor-deps mirror.

After this runs, ``demos/nasm/src/`` holds the upstream NASM source
distribution -- the C sources, the pre-generated x86 instruction tables
(``x86/insns*.c`` and friends, shipped in the release so no Perl generator
step is needed), the ``configure`` script, and the ``travis/`` Python test
suite with its golden outputs. The tree is ready for the smoke harness to
configure and compile through badc.

Pulls from the ``kromych/badc`` GitHub release rather than www.nasm.us to
avoid network-flake noise in CI. The asset name embeds the upstream version
and the first 8 hex digits of the release tarball's sha256; ``_fetch``
verifies the full sha256 before extraction. See
``scripts/vendor_deps/README.md`` for the auth model.

Idempotent: safe to call before each smoke run. Output is suppressed unless
something fails -- pass ``-v`` to see every step.
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

VERSION = "2.16.03"

# sha256 of the upstream www.nasm.us release tarball nasm-2.16.03.tar.xz.
SRC_UPSTREAM_SHA = "1412a1c760bbd05db026b6c0d1657affd6631cd0a63cddb6f73cc6d4aa616148"
SRC_ASSET = f"nasm-{VERSION}-{SRC_UPSTREAM_SHA[:8]}.tar.xz"
SRC_SHA256 = SRC_UPSTREAM_SHA
RELEASE_TAG = "vendor-deps-v1"

NASM_DIR = Path(__file__).resolve().parent
SRC_ROOT = NASM_DIR / "src"


def _extract(tar_path: Path, prefix: str, dst_root: Path) -> None:
    """Replace ``dst_root`` with the ``prefix/`` subtree of ``tar_path``.

    The tarball lays members out as ``<prefix>/<member>``; the destination
    holds them rooted at ``dst_root``. A pre-existing destination is removed
    so a re-fetch does not leave stale files behind.
    """
    if dst_root.exists():
        shutil.rmtree(dst_root)
    dst_root.mkdir(parents=True)
    with tarfile.open(tar_path, "r:xz") as tf:
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
            elif member.issym():
                target.parent.mkdir(parents=True, exist_ok=True)
                if target.exists() or target.is_symlink():
                    target.unlink()
                target.symlink_to(member.linkname)


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("-v", "--verbose", action="store_true")
    args = ap.parse_args(argv)
    log = (lambda m: print(f"nasm setup: {m}")) if args.verbose else (lambda _m: None)

    cache = NASM_DIR / ".cache"
    cache.mkdir(exist_ok=True)
    src_tar = cache / SRC_ASSET
    _fetch.fetch_and_verify(RELEASE_TAG, SRC_ASSET, src_tar, SRC_SHA256, log)
    _extract(src_tar, f"nasm-{VERSION}", SRC_ROOT)
    log(f"NASM {VERSION} source ready at {SRC_ROOT}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
