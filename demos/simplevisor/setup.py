#!/usr/bin/env python3
"""Fetch the SimpleVisor source snapshot from the badc vendor-deps mirror.

After this runs, ``demos/simplevisor/src/{shv.c, shvutil.c, shvvmx.c,
shvvmxhv.c, shvvp.c, shv.h, shv_x.h, vmx.h, ntint.h}`` exist alongside
the demo-local headers (``include/``), the Windows OS layer
(``shvos_badc.c``), the translated assembly (``shvasm_x64.c``) and the
user-mode harness (``harness/``) that this demo ships.

SimpleVisor is Alex Ionescu's Intel VT-x hypervisor, built upstream as a
Windows kernel driver. The demo compiles its core VMX logic verbatim;
the privileged entry stubs (MASM upstream) are translated to badc naked
functions in shvasm_x64.c, and the WDK-dependent OS glue is replaced by
a demo-local NT layer (shvos_badc.c), since badc bundles no WDK headers.

Pulls from the `kromych/badc` GitHub release rather than upstream to
avoid CI flakes against the upstream host. The filename embeds the
upstream commit SHA short-prefix from github.com/ionescu007/SimpleVisor;
`_fetch` verifies a pinned sha256 before extraction. See
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

VERSION = "20181209"
UPSTREAM_SHA = "989d33b1bc6569965d7aad3bd50a8d35fa4c359e"  # github.com/ionescu007/SimpleVisor HEAD
ASSET = f"simplevisor-{VERSION}-{UPSTREAM_SHA[:8]}.zip"
RELEASE_TAG = "vendor-deps-v1"
SHA256 = "429e11cea3a095ea21936e7c8376f694830b4ed5c9651f38c6d7ac61f749ccdc"
FALLBACK_URL = f"https://github.com/ionescu007/SimpleVisor/archive/{UPSTREAM_SHA}.zip"

# The core VMX logic plus the headers it includes. The OS layer
# (nt/shvos.c) and the MASM modules are not taken: the demo supplies its
# own badc-buildable equivalents.
WANTED = (
    "shv.c",
    "shvutil.c",
    "shvvmx.c",
    "shvvmxhv.c",
    "shvvp.c",
    "shv.h",
    "shv_x.h",
    "vmx.h",
    "ntint.h",
)


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args(argv)

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    demo_dir = Path(__file__).resolve().parent
    cache_dir = demo_dir / ".cache"
    src_dir = demo_dir / "src"
    zip_path = cache_dir / ASSET

    cache_dir.mkdir(parents=True, exist_ok=True)
    src_dir.mkdir(parents=True, exist_ok=True)
    _fetch.fetch_and_verify(RELEASE_TAG, ASSET, zip_path, SHA256, log, FALLBACK_URL)

    log("extracting SimpleVisor")
    # The upstream zip lays everything under `SimpleVisor-<UPSTREAM_SHA>/`.
    # Pick the core sources and drop them flat into src/.
    prefix = f"SimpleVisor-{UPSTREAM_SHA}"
    with zipfile.ZipFile(zip_path) as zf:
        for name in WANTED:
            with zf.open(f"{prefix}/{name}") as fsrc, (src_dir / name).open("wb") as fdst:
                shutil.copyfileobj(fsrc, fdst)

    if args.verbose:
        for name in WANTED:
            p = src_dir / name
            log(f"done -- {p} {p.stat().st_size}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
