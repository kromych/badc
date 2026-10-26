#!/usr/bin/env python3
"""Fetch the OpenSSL 4.1.0 source distribution from the badc vendor-deps mirror.

Pins release 4.1.0. The asset on the `kromych/badc` release is the
upstream release tarball (published on openssl-library.org and on the
openssl/openssl GitHub release), named after the release and the first 8
hex digits of its sha256; ``_fetch`` verifies the full digest before
extraction, and the tree lands under ``demos/openssl/.cache/openssl-4.1.0/``,
with the one patch below. The smoke configures and builds out of tree, so
the build never writes to the extracted tree. See
``scripts/vendor_deps/README.md`` for the auth model.

Idempotent: safe to call from CI before each smoke run. Re-extracts only
when the tree is absent or unpatched. Output is suppressed unless something
fails -- pass ``-v`` to see every step.
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

VERSION = "4.1.0"
# Published as a release tarball with its own `.sha256`, so the pin is the
# sha256 of `openssl-4.1.0.tar.gz`.
SHA256 = "50c17baf54cb008f6ce42d50deb4b28050a1aad711636cabd4b241c7e90cc2fd"
ASSET = f"openssl-{VERSION}-{SHA256[:8]}.tar.gz"
RELEASE_TAG = "vendor-deps-v1"
SRC_DIRNAME = f"openssl-{VERSION}"

# (file, old, new) exact-match replacements; setup fails loudly if upstream
# drifts from the pinned text. test/rsa_complex.c includes <complex.h> for
# any C99-or-later compiler. badc reports C11 with __STDC_NO_COMPLEX__, under
# which C11 6.10.8.3 does not require the header, so the include is guarded
# by that macro as C11 provides.
PATCHES = (
    (
        "test/rsa_complex.c",
        "#if __STDC_VERSION__ >= 199901L\n#include <complex.h>\n#endif",
        "#if __STDC_VERSION__ >= 199901L && !defined(__STDC_NO_COMPLEX__)\n"
        "#include <complex.h>\n#endif",
    ),
)


def patched(src: Path) -> bool:
    return all(new in (src / name).read_text() for name, _, new in PATCHES)


def apply_patches(src: Path, log) -> None:
    for name, old, new in PATCHES:
        p = src / name
        text = p.read_text()
        if old not in text:
            sys.exit(f"setup: patch anchor not found in {p}:\n{old[:120]}")
        p.write_text(text.replace(old, new, 1))
        log(f"patched {name}")


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
    if cached and (src / "Configure").is_file() and patched(src):
        log(f"done -- {src}")
        return 0
    _fetch.fetch_and_verify(RELEASE_TAG, ASSET, tar_path, SHA256, log)

    if src.exists():
        shutil.rmtree(src)
    log("extracting")
    with tarfile.open(tar_path, "r:gz") as tf:
        tf.extractall(cache)
    for name in ("Configure", "crypto/cryptlib.c", "test/run_tests.pl", "apps/openssl.c"):
        if not (src / name).is_file():
            sys.exit(f"setup: expected {src}/{name} after extraction")
    apply_patches(src, log)
    log(f"done -- {src}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
