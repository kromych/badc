#!/usr/bin/env python3
"""Fetch tsoding/coroutines (minimal coroutine library) from upstream github.

Pins the head of `tsoding/coroutines@main` by full commit SHA and
verifies a sha256 before extraction; the tree lands under
``demos/coroutines/.cache/coroutines-<sha>/``.

The library is linux-x86_64 only by design: the context switch is
four `__attribute__((naked))` functions whose bodies are hand-written
SysV AMD64 asm (push callee-saved registers, swap %rsp, pop, ret /
jmp into the scheduler), and coroutine stacks come from mmap with
MAP_STACK|MAP_GROWSDOWN. No patches are applied -- badc compiles the
asm as written.

Idempotent: safe to call from CI before each smoke run. Output is
suppressed unless something fails -- pass ``-v`` to see every step.
"""

from __future__ import annotations

import argparse
import shutil
import sys
import tarfile
import urllib.request
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(REPO_ROOT / "scripts" / "vendor_deps"))
import _fetch  # noqa: E402

UPSTREAM_SHA = "7d50b7162a58a1d7f136145de0cc9d46fb82a7f8"  # tsoding/coroutines @ main
URL = f"https://github.com/tsoding/coroutines/archive/{UPSTREAM_SHA}.tar.gz"
SHA256 = "066b1f66a5d17a5daa982657df4328a019b693564dce68e69ef841f838a50d52"
SRC_DIRNAME = f"coroutines-{UPSTREAM_SHA}"


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args(argv)

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    cache = Path(__file__).resolve().parent / ".cache"
    cache.mkdir(parents=True, exist_ok=True)
    tar_path = cache / f"coroutines-{UPSTREAM_SHA[:8]}.tar.gz"

    if not (tar_path.is_file() and _fetch.sha256_of(tar_path) == SHA256):
        log(f"fetching {URL}")
        with _fetch._urlopen_retry(
            lambda: urllib.request.urlopen(URL)
        ) as resp, tar_path.open("wb") as out:
            shutil.copyfileobj(resp, out)
        actual = _fetch.sha256_of(tar_path)
        if actual != SHA256:
            tar_path.unlink(missing_ok=True)
            sys.exit(f"sha256 mismatch on {URL}: expected {SHA256}, got {actual}")

    src = cache / SRC_DIRNAME
    if src.exists():
        shutil.rmtree(src)
    log("extracting")
    with tarfile.open(tar_path, "r:gz") as tf:
        tf.extractall(cache)
    if not (src / "coroutine.c").is_file():
        sys.exit(f"setup: expected {src}/coroutine.c after extraction")
    log(f"done -- {src}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
