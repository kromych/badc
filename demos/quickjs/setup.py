#!/usr/bin/env python3
"""Fetch the QuickJS source from the badc vendor-deps mirror.

After this runs, ``demos/quickjs/{quickjs.c, quickjs-libc.c, cutils.c,
libregexp.c, libunicode.c, dtoa.c, qjs.c, ...}`` and ``demos/quickjs/tests/*.js``
exist and are ready for badc to compile + run.

Pulls from the `kromych/badc` GitHub release mirror rather than
github.com/bellard/quickjs directly: the release asset is a pinned copy of
the upstream archive at the commit below, so the sha256 stays stable even
when GitHub regenerates its source archives. See
``scripts/vendor_deps/README.md`` for the auth model.

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

VERSION = "20260604"  # bellard/quickjs release dated 2026-06-04
UPSTREAM_SHA = "3d5e064e9dd67c70f7962836505a7fa067bf0a4e"  # github bellard/quickjs commit
ASSET = f"quickjs-{VERSION}-{UPSTREAM_SHA[:8]}.tar.gz"
RELEASE_TAG = "vendor-deps-v1"
SHA256 = "afccd11533e21a4e49af43e6909fc7236ed0b92f25e01e1061ceb0b47e15e05d"

# Source files badc compiles, plus the headers they include.
SOURCES = (
    "quickjs.c",
    "quickjs.h",
    "quickjs-libc.c",
    "quickjs-libc.h",
    "cutils.c",
    "cutils.h",
    "libregexp.c",
    "libregexp.h",
    "libregexp-opcode.h",
    "libunicode.c",
    "libunicode.h",
    "libunicode-table.h",
    "dtoa.c",
    "dtoa.h",
    "qjs.c",
    "list.h",
    "quickjs-atom.h",
    "quickjs-opcode.h",
)
# The pure-JS test suite the smoke runs, plus the assert helper and the
# module test_worker / test_cyclic_import import.
TESTS = (
    "assert.js",
    "fixture_cyclic_import.js",
    "test_bigint.js",
    "test_builtin.js",
    "test_closure.js",
    "test_cyclic_import.js",
    "test_language.js",
    "test_loop.js",
    "test_rw_handler.js",
    "test_std.js",
    "test_worker.js",
    "test_worker_module.js",
)
# Native extension modules and their test scripts, exercised by a runtime
# dlopen of a badc-built shared object (POSIX only; the smoke skips them on
# Windows). Each keeps its upstream subdirectory under `demos/quickjs/`.
MODULE_FILES = (
    "tests/bjson.c",
    "tests/test_bjson.js",
    "examples/point.c",
    "examples/test_point.js",
)


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args(argv)

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    qjs_dir = Path(__file__).resolve().parent
    cache_dir = qjs_dir / ".cache"
    tar_path = cache_dir / ASSET

    cache_dir.mkdir(parents=True, exist_ok=True)
    _fetch.fetch_and_verify(RELEASE_TAG, ASSET, tar_path, SHA256, log)

    log("extracting quickjs")
    # The GitHub archive lays everything under `quickjs-<commit-sha>/`.
    # Pick the source files and tests we want and write them flat under
    # `demos/quickjs/` (sources) and `demos/quickjs/tests/` (tests),
    # rather than reproducing the upstream tree.
    prefix = f"quickjs-{UPSTREAM_SHA}"
    tests_dir = qjs_dir / "tests"
    tests_dir.mkdir(exist_ok=True)
    with tarfile.open(tar_path, "r:gz") as tf:
        for name in SOURCES:
            member = tf.getmember(f"{prefix}/{name}")
            with tf.extractfile(member) as src, (qjs_dir / name).open("wb") as dst:
                shutil.copyfileobj(src, dst)
        for name in TESTS:
            member = tf.getmember(f"{prefix}/tests/{name}")
            with tf.extractfile(member) as src, (tests_dir / name).open("wb") as dst:
                shutil.copyfileobj(src, dst)
        for rel in MODULE_FILES:
            member = tf.getmember(f"{prefix}/{rel}")
            out = qjs_dir / rel
            out.parent.mkdir(parents=True, exist_ok=True)
            with tf.extractfile(member) as src, out.open("wb") as dst:
                shutil.copyfileobj(src, dst)

    if args.verbose:
        for name in SOURCES:
            p = qjs_dir / name
            log(f"done -- {p} {p.stat().st_size}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
