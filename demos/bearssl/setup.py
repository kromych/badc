#!/usr/bin/env python3
"""Fetch the BearSSL 0.6 source snapshot from the badc vendor-deps mirror.

After this runs, ``demos/bearssl/{inc/*, src/**}`` exist and
are ready for badc to compile against. The vendored set is a
curated subset of upstream BearSSL: the public headers under
``inc/``, the ``src/inner.h`` private header, and the
constant-time / non-SIMD primitives that the smoke driver
exercises (SHA-256, HMAC, HKDF, ChaCha20-Poly1305).

The full upstream tree carries ~300 .c files including AES
hardware-accelerated variants (`aes_x86ni`, `aes_pwr8`), TLS
record-layer state machines, and an X.509 minimal validator.
Those are tracked as later milestones; the focused subset
keeps the first-cut smoke compile time bounded and exercises
the constant-time bignum / AEAD path that BearSSL is known
for.

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

# Public headers (`<bearssl_*.h>`).
HEADERS = (
    "inc/bearssl.h",
    "inc/bearssl_aead.h",
    "inc/bearssl_block.h",
    "inc/bearssl_ec.h",
    "inc/bearssl_hash.h",
    "inc/bearssl_hmac.h",
    "inc/bearssl_kdf.h",
    "inc/bearssl_pem.h",
    "inc/bearssl_prf.h",
    "inc/bearssl_rand.h",
    "inc/bearssl_rsa.h",
    "inc/bearssl_ssl.h",
    "inc/bearssl_x509.h",
    "src/inner.h",
    "src/config.h",
)

# Hash + MAC + KDF + AEAD primitives. Upstream's Makefile pulls
# the entire src/ tree into one libbearssl.a; the focused
# subset here is the C99-portable, no-SIMD, constant-time
# variant set the smoke exercises through the public API.
SRC = (
    # SHA-256.
    "src/hash/sha2small.c",
    "src/hash/dig_size.c",
    "src/hash/dig_oid.c",
    "src/hash/multihash.c",
    # HMAC.
    "src/mac/hmac.c",
    "src/mac/hmac_ct.c",
    # HKDF.
    "src/kdf/hkdf.c",
    # `br_divrem` -- the small 32-bit integer divide-with-
    # remainder helper. The MAC + KDF size accounting drags it
    # in even though there's no big-integer arithmetic in the
    # focused subset.
    "src/int/i32_div32.c",
    # ChaCha20 + Poly1305 (constant-time path; SSE2 + ctmulq
    # variants are skipped -- the runtime picks ctmul through
    # `br_poly1305_ctmul_get`).
    "src/symcipher/chacha20_ct.c",
    "src/symcipher/poly1305_ctmul.c",
    # Codec helpers (the .c side of inner.h's enc/dec inlines
    # has constant-time externs the linker drags in).
    "src/codec/ccopy.c",
    "src/codec/enc32be.c",
    "src/codec/enc32le.c",
    "src/codec/enc64be.c",
    "src/codec/dec32be.c",
    "src/codec/dec32le.c",
    "src/codec/dec64be.c",
    # Settings -- runtime version + cpuid table.
    "src/settings.c",
)


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
    wanted = HEADERS + SRC
    with tarfile.open(tar_path, "r:gz") as tf:
        for rel in wanted:
            member = tf.getmember(f"{prefix}/{rel}")
            dst = bear_dir / rel
            dst.parent.mkdir(parents=True, exist_ok=True)
            with tf.extractfile(member) as src, dst.open("wb") as out:
                shutil.copyfileobj(src, out)

    if args.verbose:
        for rel in wanted:
            p = bear_dir / rel
            log(f"done -- {p} {p.stat().st_size}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
