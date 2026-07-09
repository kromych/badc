#!/usr/bin/env python3
"""Fetch the yasm 1.3.0 release tarball from the badc vendor-deps mirror.

After this runs, ``demos/yasm/src/`` holds the upstream yasm source
distribution -- the C sources, the ``configure`` script, the C table
generators (genstring/genmacro/genperf/genmodule/...), the Python x86
instruction-table generator (``modules/arch/x86/gen_x86_insn.py``), and the
per-module test suites. The tree is ready for the smoke harness to configure,
generate its derived sources, and compile through badc.

Pulls from the ``kromych/badc`` GitHub release rather than www.tortall.net to
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

VERSION = "1.3.0"

# sha256 of the upstream www.tortall.net release tarball yasm-1.3.0.tar.gz.
SRC_UPSTREAM_SHA = "3dce6601b495f5b3d45b59f7d2492a340ee7e84b5beca17e48f862502bd5603f"
SRC_ASSET = f"yasm-{VERSION}-{SRC_UPSTREAM_SHA[:8]}.tar.gz"
SRC_SHA256 = SRC_UPSTREAM_SHA
RELEASE_TAG = "vendor-deps-v1"

YASM_DIR = Path(__file__).resolve().parent
SRC_ROOT = YASM_DIR / "src"


def _extract(tar_path: Path, prefix: str, dst_root: Path) -> None:
    """Replace ``dst_root`` with the ``prefix/`` subtree of ``tar_path``."""
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
            elif member.issym():
                target.parent.mkdir(parents=True, exist_ok=True)
                if target.exists() or target.is_symlink():
                    target.unlink()
                target.symlink_to(member.linkname)


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("-v", "--verbose", action="store_true")
    args = ap.parse_args(argv)
    log = (lambda m: print(f"yasm setup: {m}")) if args.verbose else (lambda _m: None)

    cache = YASM_DIR / ".cache"
    cache.mkdir(exist_ok=True)
    src_tar = cache / SRC_ASSET
    _fetch.fetch_and_verify(RELEASE_TAG, SRC_ASSET, src_tar, SRC_SHA256, log)
    _extract(src_tar, f"yasm-{VERSION}", SRC_ROOT)
    log(f"yasm {VERSION} source ready at {SRC_ROOT}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
