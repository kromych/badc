#!/usr/bin/env python3
"""Fetch the QEMU 11.0.2 source + captured build config from the badc
vendor-deps mirror.

After this runs, ``demos/qemu/.cache/qemu-11.0.2/`` holds the trimmed QEMU
source (``qemu-rm/``) and the meson-generated build config for each captured
target (``qbuild-<arch>/``). QEMU's build is not reproducible off-box without
meson's generated config, so the asset ships it: per target a captured
``compile_commands.json``, the linker response files, and every generated
header/source. The smoke reads those directly; no ``meson``/``ninja`` run is
needed. The source is trimmed of the git history, the test suite, docs, ROM
blobs, firmware, and meson subprojects -- none are compile inputs for the
emulator.

Pulls from the ``kromych/badc`` GitHub release rather than gitlab.com to avoid
network-flake noise in CI. The asset name embeds the upstream version and the
first 8 hex digits of the release commit; ``_fetch`` verifies the full sha256
before extraction. See ``scripts/vendor_deps/README.md`` for the auth model.

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

VERSION = "11.0.2"
# git commit for the v11.0.2 tag (e545d8bb...); sha_kind "git".
UPSTREAM_SHA = "e545d8bb9d63e9dd61542b88463183314cff9482"
ASSET = f"qemu-{VERSION}-{UPSTREAM_SHA[:8]}.tar.xz"
RELEASE_TAG = "vendor-deps-v1"
SHA256 = "63489d195f3d5eb55d46316cc3874e276f7d08944efe008d8dc12dd642a5c2bd"
PREFIX = f"qemu-{VERSION}"

QEMU_DIR = Path(__file__).resolve().parent


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("-v", "--verbose", action="store_true")
    args = ap.parse_args(argv)
    log = (lambda m: print(f"qemu setup: {m}")) if args.verbose else (lambda _m: None)

    cache = QEMU_DIR / ".cache"
    cache.mkdir(exist_ok=True)
    tar_path = cache / ASSET
    _fetch.fetch_and_verify(RELEASE_TAG, ASSET, tar_path, SHA256, log)

    dst_root = cache / PREFIX
    if dst_root.exists():
        shutil.rmtree(dst_root)
    log(f"extracting {ASSET}")
    with tarfile.open(tar_path, "r:xz") as tf:
        _extractall(tf, cache)
    log(f"QEMU {VERSION} source + build config ready at {dst_root}")
    return 0


def _extractall(tf: tarfile.TarFile, dst: Path) -> None:
    """Extract every member of `tf` under `dst`, rejecting any path that would
    escape it. tarfile's ``data`` filter (Python 3.12+) does this, but is not
    available on older interpreters; the explicit check keeps the same guarantee
    everywhere."""
    dst = dst.resolve()
    for member in tf.getmembers():
        target = (dst / member.name).resolve()
        if dst not in target.parents and target != dst:
            sys.exit(f"unsafe path in archive: {member.name!r}")
    tf.extractall(dst)


if __name__ == "__main__":
    raise SystemExit(main())
