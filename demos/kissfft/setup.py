#!/usr/bin/env python3
"""Fetch the KISS FFT release zip from the badc vendor-deps mirror.

After this runs, ``demos/kissfft/{kiss_fft.c, kiss_fft.h,
kiss_fftr.c, kiss_fftr.h, _kiss_fft_guts.h, kiss_fft_log.h}``
exist and are ready for badc to compile against.

Pulls from the `kromych/badc` GitHub release rather than upstream
to avoid CI flakes against the upstream host. Filename embeds the
upstream version + commit SHA short-prefix; `_fetch` verifies a
pinned sha256 before extraction. See
``scripts/vendor_deps/README.md`` for the auth model.

Idempotent: safe to call from CI before each smoke run. Output is
suppressed unless something fails -- pass ``-v`` to see every step.
"""

from __future__ import annotations

import argparse
import shutil
import sys
import zipfile
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(REPO_ROOT / "scripts" / "vendor_deps"))
import _fetch  # noqa: E402

VERSION = "131.2.0"
UPSTREAM_SHA = "7bce4153c6bc8aba2db0e889e576f9d00505cbe1"  # github mborgerding/kissfft tag 131.2.0
ASSET = f"kissfft-{VERSION}-{UPSTREAM_SHA[:8]}.zip"
RELEASE_TAG = "vendor-deps-v1"
SHA256 = "0fd8757f845acfdf178470be3435e6e5a65e8bfa2564bf2e5d3163be166121c1"
WANTED = (
    "kiss_fft.c",
    "kiss_fft.h",
    "kiss_fftr.c",
    "kiss_fftr.h",
    "_kiss_fft_guts.h",
    "kiss_fft_log.h",
)


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args(argv)

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    kissfft_dir = Path(__file__).resolve().parent
    cache_dir = kissfft_dir / ".cache"
    zip_path = cache_dir / ASSET

    cache_dir.mkdir(parents=True, exist_ok=True)
    _fetch.fetch_and_verify(RELEASE_TAG, ASSET, zip_path, SHA256, log)

    log("extracting kissfft")
    # The github auto-generated source zip extracts under
    # `kissfft-<VERSION>/`, so each wanted file lives under
    # that prefix. Hard-coding the prefix keeps the script
    # simple; if upstream ever changes the layout, bump the
    # path here alongside the version.
    prefix = f"kissfft-{VERSION}"
    with zipfile.ZipFile(zip_path) as zf:
        for name in WANTED:
            with zf.open(f"{prefix}/{name}") as src, (kissfft_dir / name).open("wb") as dst:
                shutil.copyfileobj(src, dst)

    if args.verbose:
        for name in WANTED:
            p = kissfft_dir / name
            log(f"done -- {p} {p.stat().st_size}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
