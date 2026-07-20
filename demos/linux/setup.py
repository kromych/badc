#!/usr/bin/env python3
"""Fetch and configure a Linux kernel tree for the badc translation-unit sweep.

Downloads the pinned kernel release for the requested architecture from
cdn.kernel.org, verifies its sha256, extracts it under ``demos/linux/.cache``,
installs the vendored build config (``configs/<arch>-<version>.config``), and
runs ``make olddefconfig``. With ``--build`` it then runs the gcc reference
build; that build validates the config and writes the per-object
``.<name>.o.cmd`` files Kbuild leaves next to each object, which are the
replay corpus ``sweep.py`` consumes.

The configs are known-booting minimal configs (x86_64 on 6.12.8, aarch64 on
6.10.1). Config options the reference toolchain forces or drops during
``olddefconfig`` are recorded in ``config-deviations.txt`` next to the tree.

Requirements for ``--build``: gcc, make, flex, bison, bc, libelf and openssl
development headers. Idempotent: a verified tarball and an extracted tree are
reused.
"""

from __future__ import annotations

import argparse
import hashlib
import os
import platform
import re
import subprocess
import sys
import tarfile
import urllib.request
from pathlib import Path

LINUX_DIR = Path(__file__).resolve().parent

# Pinned kernel release per architecture: (version, tarball sha256).
KERNELS = {
    "x86_64": ("6.12.8", "2291da065ca04b715c89ee50362aec3f021a7414bc963f1b56736682c8122979"),
    "aarch64": ("6.10.1", "70109dfd1cd1c5f8a58eb1cb37122b9bf93f9c6a6280bf91019263c7339cf76b"),
}

BASE_URL = "https://cdn.kernel.org/pub/linux/kernel/v6.x"


def log(m: str) -> None:
    print(f"linux setup: {m}", flush=True)


def host_arch() -> str:
    m = platform.machine().lower()
    if m in ("arm64", "aarch64"):
        return "aarch64"
    if m in ("x86_64", "amd64"):
        return "x86_64"
    return m


def sha256_of(path: Path) -> str:
    h = hashlib.sha256()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def fetch(url: str, dst: Path, want_sha: str) -> None:
    if dst.is_file() and sha256_of(dst) == want_sha:
        log(f"cached: {dst.name}")
        return
    log(f"fetching {url}")
    tmp = dst.with_suffix(dst.suffix + ".part")
    with urllib.request.urlopen(url) as r, open(tmp, "wb") as f:
        while True:
            chunk = r.read(1 << 20)
            if not chunk:
                break
            f.write(chunk)
    got = sha256_of(tmp)
    if got != want_sha:
        tmp.unlink()
        sys.exit(f"linux setup: sha256 mismatch for {dst.name}: got {got}, want {want_sha}")
    tmp.rename(dst)


def extract(tar_path: Path, dst: Path) -> None:
    dst_r = dst.resolve()
    with tarfile.open(tar_path, "r:xz") as tf:
        for member in tf.getmembers():
            target = (dst_r / member.name).resolve()
            if dst_r not in target.parents and target != dst_r:
                sys.exit(f"linux setup: unsafe path in archive: {member.name!r}")
        tf.extractall(dst_r)


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--arch", choices=sorted(KERNELS), default=host_arch(),
                    help="kernel architecture (default: host)")
    ap.add_argument("--cache", type=Path, default=LINUX_DIR / ".cache",
                    help="download/extract directory")
    ap.add_argument("--build", action="store_true",
                    help="also run the gcc reference build (produces the .cmd corpus)")
    ap.add_argument("-j", "--jobs", type=int, default=0,
                    help="make parallelism for --build (default: nproc)")
    args = ap.parse_args(argv)

    if args.arch not in KERNELS:
        sys.exit(f"linux setup: no pinned kernel for arch {args.arch!r}")
    version, sha = KERNELS[args.arch]
    config = LINUX_DIR / "configs" / f"{args.arch}-{version}.config"
    if not config.is_file():
        sys.exit(f"linux setup: missing vendored config {config}")

    cache = args.cache
    cache.mkdir(parents=True, exist_ok=True)
    tar_path = cache / f"linux-{version}.tar.xz"
    fetch(f"{BASE_URL}/linux-{version}.tar.xz", tar_path, sha)

    tree = cache / f"linux-{version}"
    if not (tree / "Makefile").is_file():
        log(f"extracting {tar_path.name}")
        extract(tar_path, cache)

    # The vendored configs may reference build products from their home tree
    # (an embedded initramfs). The sweep needs the compile commands, not the
    # boot artifacts, so external file references are cleared; the change shows
    # up in the recorded deviations.
    text = re.sub(r'(?m)^CONFIG_INITRAMFS_SOURCE=.*$',
                  'CONFIG_INITRAMFS_SOURCE=""', config.read_text())
    (tree / ".config").write_text(text)
    (tree / ".config.orig").write_bytes(config.read_bytes())
    log("make olddefconfig")
    subprocess.run(["make", "olddefconfig"], cwd=tree, check=True,
                   stdout=subprocess.DEVNULL)
    # Record every option olddefconfig changed relative to the vendored config.
    dev = subprocess.run(["./scripts/diffconfig", ".config.orig", ".config"],
                         cwd=tree, capture_output=True, text=True)
    (cache / f"config-deviations-{args.arch}.txt").write_text(dev.stdout)
    n = len([ln for ln in dev.stdout.splitlines() if ln.strip()])
    log(f"config ready ({n} olddefconfig deviations recorded)")

    if args.build:
        jobs = args.jobs or (os.cpu_count() or 4)
        log(f"gcc reference build: make -j{jobs} (this takes a while)")
        r = subprocess.run(["make", f"-j{jobs}"], cwd=tree)
        if r.returncode != 0:
            sys.exit(f"linux setup: reference build failed (rc={r.returncode})")
        log("reference build done; .cmd corpus is in place")
    log(f"kernel tree ready at {tree}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
