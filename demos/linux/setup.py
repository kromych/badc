#!/usr/bin/env python3
"""Fetch and configure a Linux kernel tree for the badc translation-unit sweep.

Downloads a pinned kernel release from cdn.kernel.org, verifies its sha256,
extracts it under ``demos/linux/.cache``, installs a build config, and runs
``make olddefconfig``. With ``--build`` it then runs the gcc reference build;
that build validates the config and writes the per-object ``.<name>.o.cmd``
files Kbuild leaves next to each object, which are the replay corpus
``sweep.py`` consumes.

Two configurations, selected by ``--config``:

``defconfig`` (default)
    The sweep corpus: one release for both architectures, configured by the
    tree's own ``make defconfig``. The tarball hash pins the tree and defconfig
    is a function of the tree, so the configuration is reproducible without a
    vendored copy that would have to be re-generated on every version bump.

``minimal``
    The link-and-boot gate's corpus: a vendored known-booting minimal config
    (``configs/<arch>-<version>.config``). A ``.config`` is only meaningful
    against the tree it was produced for, so each architecture keeps the
    release its config was made for.

Config options the reference toolchain forces or drops during
``olddefconfig`` are recorded in ``config-deviations-<arch>.txt`` next to the
tree.

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

# Sweep corpus: latest stable at the time of pinning, both architectures.
DEFCONFIG_KERNEL = ("7.1.5",
                    "22a0196b3cbcdf34dc27b77561f4d040585fd3447edc9ab3531a1ac79e3041e7")

# Link-and-boot gate: (version, tarball sha256) per architecture, each the
# release its vendored minimal config was produced for.
MINIMAL_KERNELS = {
    "x86_64": ("6.12.8", "2291da065ca04b715c89ee50362aec3f021a7414bc963f1b56736682c8122979"),
    "aarch64": ("6.10.1", "70109dfd1cd1c5f8a58eb1cb37122b9bf93f9c6a6280bf91019263c7339cf76b"),
}

ARCHES = sorted(MINIMAL_KERNELS)
CONFIGS = ("defconfig", "minimal")

CDN = "https://cdn.kernel.org/pub/linux/kernel"


def log(m: str) -> None:
    print(f"linux setup: {m}", flush=True)


def host_arch() -> str:
    m = platform.machine().lower()
    if m in ("arm64", "aarch64"):
        return "aarch64"
    if m in ("x86_64", "amd64"):
        return "x86_64"
    return m


def tarball_url(version: str) -> str:
    return f"{CDN}/v{version.split('.', 1)[0]}.x/linux-{version}.tar.xz"


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
    ap.add_argument("--arch", choices=ARCHES, default=host_arch(),
                    help="kernel architecture (default: host)")
    ap.add_argument("--config", choices=CONFIGS, default="defconfig",
                    help="configuration to build: the tree's own defconfig "
                         "(the sweep corpus) or the vendored minimal config "
                         "(the link-and-boot gate)")
    ap.add_argument("--cache", type=Path, default=LINUX_DIR / ".cache",
                    help="download/extract directory")
    ap.add_argument("--build", action="store_true",
                    help="also run the gcc reference build (produces the .cmd corpus)")
    ap.add_argument("-j", "--jobs", type=int, default=0,
                    help="make parallelism for --build (default: nproc)")
    args = ap.parse_args(argv)

    if args.arch not in MINIMAL_KERNELS:
        sys.exit(f"linux setup: no pinned kernel for arch {args.arch!r}")
    if args.config == "defconfig":
        version, sha = DEFCONFIG_KERNEL
        config = None
    else:
        version, sha = MINIMAL_KERNELS[args.arch]
        config = LINUX_DIR / "configs" / f"{args.arch}-{version}.config"
        if not config.is_file():
            sys.exit(f"linux setup: missing vendored config {config}")

    cache = args.cache
    cache.mkdir(parents=True, exist_ok=True)
    tar_path = cache / f"linux-{version}.tar.xz"
    fetch(tarball_url(version), tar_path, sha)

    tree = cache / f"linux-{version}"
    if not (tree / "Makefile").is_file():
        log(f"extracting {tar_path.name}")
        extract(tar_path, cache)

    if config is None:
        log("make defconfig")
        subprocess.run(["make", "defconfig"], cwd=tree, check=True,
                       stdout=subprocess.DEVNULL)
        base = (tree / ".config").read_bytes()
    else:
        base = config.read_bytes()
    # A config may reference build products from its home tree (an embedded
    # initramfs). The sweep needs the compile commands, not the boot artifacts,
    # so external file references are cleared; the change shows up in the
    # recorded deviations.
    text = re.sub(r'(?m)^CONFIG_INITRAMFS_SOURCE=.*$',
                  'CONFIG_INITRAMFS_SOURCE=""', base.decode())
    (tree / ".config").write_text(text)
    (tree / ".config.orig").write_bytes(base)
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
        # The build exists to emit the .cmd corpus, so it must cover the tree
        # rather than stop at the first object the host gcc rejects: a kernel
        # and a compiler of different vintages disagree over warnings the
        # kernel promotes to errors. -k keeps going, and the corpus size below
        # is what says whether the build was usable.
        r = subprocess.run(["make", f"-j{jobs}", "-k", "KCFLAGS=-Wno-error"],
                           cwd=tree)
        n_cmd = sum(1 for _, _, fs in os.walk(tree)
                    for f in fs if f.startswith(".") and f.endswith(".o.cmd"))
        if n_cmd == 0:
            sys.exit(f"linux setup: reference build produced no .cmd files "
                     f"(rc={r.returncode})")
        log(f"reference build done (rc={r.returncode}); "
            f"{n_cmd} .cmd files in place")
    log(f"kernel tree ready at {tree}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
