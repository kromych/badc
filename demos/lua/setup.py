#!/usr/bin/env python3
"""Fetch the Lua 5.5.0 source distribution + official test suite from the badc vendor-deps mirror.

After this runs, ``demos/lua/src/`` holds the Lua C sources and
``demos/lua/tests/`` holds the upstream `.lua` test scripts. Both
trees are ready for the smoke harness to compile / run against.

Pulls from the `kromych/badc` GitHub release rather than
www.lua.org to avoid network-flake noise in CI. Filenames embed
the upstream version and the first 8 hex digits of the tarball
sha256 (Lua is published as standalone tarballs with no public
VCS or commit identifier). ``_fetch`` verifies a pinned sha256
before extraction. See ``scripts/vendor_deps/README.md`` for the
auth model.

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

VERSION = "5.5.0"

SRC_UPSTREAM_SHA = "57ccc32bbbd005cab75bcc52444052535af691789dba2b9016d5c50640d68b3d"
SRC_ASSET = f"lua-{VERSION}-{SRC_UPSTREAM_SHA[:8]}.tar.gz"
SRC_SHA256 = SRC_UPSTREAM_SHA

TESTS_UPSTREAM_SHA = "5e47bbfad7db2965d69580e918ee64edeb8d8d32de404b8dae9ce5c6d76a1472"
TESTS_ASSET = f"lua-tests-{VERSION}-{TESTS_UPSTREAM_SHA[:8]}.tar.gz"
TESTS_SHA256 = TESTS_UPSTREAM_SHA

RELEASE_TAG = "vendor-deps-v1"


def _extract_subtree(tar_path: Path, prefix: str, dst_root: Path) -> None:
    """Replace `dst_root` with the contents of `tar_path` under `prefix/`.

    The tarball layout is `<prefix>/<member>`; the destination
    holds members rooted at `dst_root`. A pre-existing destination
    is removed so a downgrade does not leave stale files behind.
    """
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
                continue
            target.parent.mkdir(parents=True, exist_ok=True)
            extracted = tf.extractfile(member)
            if extracted is None:
                continue
            with extracted as src, target.open("wb") as out:
                shutil.copyfileobj(src, out)


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args(argv)

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    lua_dir = Path(__file__).resolve().parent
    cache_dir = lua_dir / ".cache"
    cache_dir.mkdir(parents=True, exist_ok=True)

    src_tar = cache_dir / SRC_ASSET
    tests_tar = cache_dir / TESTS_ASSET

    _fetch.fetch_and_verify(RELEASE_TAG, SRC_ASSET, src_tar, SRC_SHA256, log)
    _fetch.fetch_and_verify(
        RELEASE_TAG, TESTS_ASSET, tests_tar, TESTS_SHA256, log
    )

    log("extracting interpreter sources")
    src_root = lua_dir / "src"
    if src_root.exists():
        shutil.rmtree(src_root)
    src_root.mkdir()
    # Pull only the upstream `src/` subtree; the rest of the
    # release tarball (Makefile, doc/) is not needed by the smoke
    # harness, and dropping it keeps the vendored tree small.
    with tarfile.open(src_tar, "r:gz") as tf:
        prefix = f"lua-{VERSION}/src/"
        for member in tf.getmembers():
            if not member.name.startswith(prefix):
                continue
            rel = member.name[len(prefix):]
            if not rel:
                continue
            target = src_root / rel
            if member.isdir():
                target.mkdir(parents=True, exist_ok=True)
                continue
            target.parent.mkdir(parents=True, exist_ok=True)
            extracted = tf.extractfile(member)
            if extracted is None:
                continue
            with extracted as inp, target.open("wb") as out:
                shutil.copyfileobj(inp, out)

    log("extracting test suite")
    _extract_subtree(tests_tar, f"lua-{VERSION}-tests", lua_dir / "tests")

    if args.verbose:
        for name in sorted(p.name for p in src_root.glob("*.c")):
            p = src_root / name
            log(f"done -- {p} {p.stat().st_size}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
