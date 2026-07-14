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
import platform
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
SHA256 = "ebacb1a7da38e3414c5d0a089a6c7e2ff5bcf184f9c0b23f745bac09e40bd5f8"
PREFIX = f"qemu-{VERSION}"

# Boot kernel bundle, used by smoke.py's boot check. Each per-arch bundle is a
# tar.xz under a top-level `kernel-<arch>` directory. arm64 ships a raw `Image`
# plus a separate `initramfs.cpio.gz`; x86_64 ships an EFI-stub `bzImage` with
# the initramfs embedded (no separate initrd), booted through OVMF. The version
# is the kernel release; the sha suffix is the build tree commit that produced
# the assets. A host without a bundle fetches nothing and the boot check skips.
# The debug symbols (vmlinux) are a separate, larger asset fetched only when a
# boot needs symbolizing.
KERNEL_VERSION = "7.1.3"
KERNEL_ARM64_BUILD_SHA = "2ab297f3"
KERNEL_X64_BUILD_SHA = "95f49161"
KERNEL_BUNDLES = {
    "aarch64": {
        "asset": f"kernel-arm64-{KERNEL_VERSION}-{KERNEL_ARM64_BUILD_SHA}.tar.xz",
        "sha256": "7988443ca45c8b440110458451c124f342f6615be2da3956787e74553f74e9e9",
        "dir": "kernel-arm64", "image": "Image", "initrd": "initramfs.cpio.gz",
        "vmlinux_asset": f"vmlinux-arm64-{KERNEL_VERSION}-{KERNEL_ARM64_BUILD_SHA}.xz",
        "vmlinux_sha256": "0971b79f2b9620653fe66399681f80c23da0fb6a1d6ec0476e55efa2b996cd79",
    },
    "x86_64": {
        "asset": f"kernel-x64-{KERNEL_VERSION}-{KERNEL_X64_BUILD_SHA}.tar.xz",
        "sha256": "212ca72855ab0de5fcf390777d0fa5d90d667accf58979a845ca8c829cd48a1a",
        "dir": "kernel-x64", "image": "bzImage", "initrd": None,
    },
}

QEMU_DIR = Path(__file__).resolve().parent


def host_arch() -> str:
    m = platform.machine().lower()
    if m in ("arm64", "aarch64"):
        return "aarch64"
    if m in ("x86_64", "amd64"):
        return "x86_64"
    return m


def fetch_kernel(cache: Path, arch: str, log=lambda _m: None) -> tuple[Path, Path | None] | None:
    """Fetch + verify + extract the boot kernel bundle for `arch` into `cache`.
    Returns (image, initrd) where initrd is None for a bundle with an embedded
    initramfs, or None when no bundle is published for the arch. Idempotent: a
    cached bundle matching the pinned sha256 is reused."""
    spec = KERNEL_BUNDLES.get(arch)
    if spec is None:
        return None
    cache.mkdir(parents=True, exist_ok=True)
    tar_path = cache / spec["asset"]
    _fetch.fetch_and_verify(RELEASE_TAG, spec["asset"], tar_path, spec["sha256"], log)
    dst = cache / spec["dir"]
    image = dst / spec["image"]
    initrd = dst / spec["initrd"] if spec.get("initrd") else None
    # Re-extract when the required files are missing or the extracted tree
    # predates the current asset: a rotated asset can keep the same name while
    # its contents change, and a partial tree (e.g. missing ROMs) must not be
    # reused just because the image file happens to exist.
    marker = dst / ".asset-sha256"
    need = [image] + ([initrd] if initrd else [])
    fresh = all(p.is_file() for p in need) and marker.is_file() \
        and marker.read_text().strip() == spec["sha256"]
    if not fresh:
        if dst.exists():
            shutil.rmtree(dst)
        log(f"extracting {spec['asset']}")
        with tarfile.open(tar_path, "r:xz") as tf:
            _extractall(tf, cache)
        marker.write_text(spec["sha256"])
    return (image, initrd)


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("-v", "--verbose", action="store_true")
    ap.add_argument("--kernel", action="store_true",
                    help="also fetch the boot kernel bundle for the host arch")
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

    if args.kernel:
        arch = host_arch()
        if fetch_kernel(cache, arch, log) is None:
            log(f"no kernel bundle published for {arch}; boot check will skip")
        else:
            log(f"kernel bundle ready for {arch}")
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
