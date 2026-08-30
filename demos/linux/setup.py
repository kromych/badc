#!/usr/bin/env python3
"""Fetch and configure a Linux kernel tree for the badc translation-unit sweep.

Downloads a pinned kernel release from the vendor-deps mirror, verifies its sha256,
extracts it under ``demos/linux/.cache``, configures it with ``make defconfig``
and ``make olddefconfig``. With ``--build`` it then runs the gcc reference
build; that build validates the config and writes the per-object ``.<name>.o.cmd``
files Kbuild leaves next to each object, which are the replay corpus
``sweep.py`` consumes. The tree is held exclusively while it is written
(ktree.py): reconfiguring under a build in progress rewrites what that build
is reading.

One release and one configuration for both architectures: the pinned tarball,
configured by the tree's own ``make defconfig``. The tarball hash pins the tree
and defconfig is a function of the tree, so the configuration is reproducible
from the pin alone. A vendored ``.config`` is only meaningful against the
release it was produced for, so it would add a second pin to bump.

Config options the reference toolchain forces or drops during
``olddefconfig`` are recorded in ``config-deviations-<arch>.txt`` next to the
tree.

``--arch`` names the target: kbuild is given ``ARCH``, and ``CROSS_COMPILE``
when the target is not the host. A cross target whose toolchain is not on
PATH is refused before anything is downloaded, and the configured tree is
checked against ``--arch`` before it is reported ready.

Requirements for ``--build``: gcc, make, flex, bison, bc, libelf and openssl
development headers, and for a cross target the matching prefixed toolchain
(``aarch64-linux-gnu-*`` / ``x86_64-linux-gnu-*``). Idempotent: a verified
tarball and an extracted tree are reused.
"""

from __future__ import annotations

import argparse
import hashlib
import os
import re
import subprocess
import sys
import tarfile
import urllib.error
import urllib.request
from pathlib import Path

import karch
import ktree

LINUX_DIR = Path(__file__).resolve().parent

# The corpus: latest stable at the time of pinning, both architectures.
DEFCONFIG_KERNEL = ("7.1.10",
                    "67d2f4697a02f3bec98e744b1bdc307e920c24bb4e88b5ee97dc9a34e9aa9999")

# The architectures kbuild can be driven for from either host.
ARCHES = sorted(karch.ARCHES)

MIRROR = "https://github.com/kromych/badc/releases/download/vendor-deps-v1"


def log(m: str) -> None:
    print(f"linux setup: {m}", flush=True)


def tarball_urls(version: str, sha: str) -> list[str]:
    """The vendor-deps mirror, and only that: the asset name embeds the
    sha256 prefix, per the scripts/vendor_deps convention.

    cdn.kernel.org is deliberately not a fallback. It is the download CI
    lost most often, and a fallback turns a missing mirror asset into an
    intermittent failure on a host nobody controls rather than a clear
    one. A pin bump therefore has to publish the tarball first --
    scripts/vendor_deps/build_bundle.py carries the upstream URL for
    that.
    """
    return [f"{MIRROR}/linux-{version}-{sha[:8]}.tar.xz"]


def sha256_of(path: Path) -> str:
    h = hashlib.sha256()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def fetch(urls: list[str], dst: Path, want_sha: str) -> None:
    """Download dst from the first reachable URL. An unreachable source
    falls through to the next one; a sha256 mismatch is fatal on any."""
    if dst.is_file() and sha256_of(dst) == want_sha:
        log(f"cached: {dst.name}")
        return
    for url in urls:
        log(f"fetching {url}")
        tmp = dst.with_suffix(dst.suffix + ".part")
        try:
            with urllib.request.urlopen(url) as r, open(tmp, "wb") as f:
                while True:
                    chunk = r.read(1 << 20)
                    if not chunk:
                        break
                    f.write(chunk)
        except urllib.error.URLError as e:
            tmp.unlink(missing_ok=True)
            log(f"unavailable ({e}), trying next source")
            continue
        got = sha256_of(tmp)
        if got != want_sha:
            tmp.unlink()
            sys.exit(f"linux setup: sha256 mismatch for {dst.name}: got {got}, want {want_sha}")
        tmp.rename(dst)
        return
    sys.exit(f"linux setup: no source could provide {dst.name}")


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
    ap.add_argument("--arch", choices=ARCHES, default=karch.host_arch(),
                    help="kernel architecture (default: host)")
    ap.add_argument("--cache", type=Path, default=LINUX_DIR / ".cache",
                    help="download/extract directory")
    ap.add_argument("--build", action="store_true",
                    help="also run the gcc reference build (produces the .cmd corpus)")
    ap.add_argument("--fetch-only", action="store_true",
                    help="download and verify the tarball, then stop; for "
                         "consumers that extract and configure themselves")
    ap.add_argument("-j", "--jobs", type=int, default=0,
                    help="make parallelism for --build (default: nproc)")
    args = ap.parse_args(argv)

    # Before anything is downloaded: a cross build that cannot be run here
    # must say so rather than produce a host-architecture tree.
    gap = karch.cross_gap(args.arch)
    if gap and not args.fetch_only:
        sys.exit(f"linux setup: {gap}")
    version, sha = DEFCONFIG_KERNEL

    cache = args.cache
    cache.mkdir(parents=True, exist_ok=True)
    tar_path = cache / f"linux-{version}.tar.xz"
    fetch(tarball_urls(version, sha), tar_path, sha)
    if args.fetch_only:
        log(f"tarball ready at {tar_path}")
        return 0

    tree = cache / f"linux-{version}"
    # Held for the rest of the run: extraction and the configuration steps
    # write the tree, and a build running in it reads what they write.
    tree.mkdir(parents=True, exist_ok=True)
    ktree.exclusive(tree, "setup.py")
    if not (tree / "Makefile").is_file():
        log(f"extracting {tar_path.name}")
        extract(tar_path, cache)

    env = karch.make_env(args.arch)
    log(f"make defconfig (ARCH={env['ARCH']})")
    subprocess.run(["make", "defconfig"], cwd=tree, check=True,
                   env=env, stdout=subprocess.DEVNULL)
    base = (tree / ".config").read_bytes()
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
                   env=env, stdout=subprocess.DEVNULL)
    # The tree is only ready if it configured the architecture that was asked
    # for; kbuild falls back to the host silently, and the mismatch would
    # otherwise surface as a missing make target at build time.
    mismatch = karch.config_mismatch(tree / ".config", args.arch)
    if mismatch:
        sys.exit(f"linux setup: {mismatch}")
    # Record every option olddefconfig changed relative to defconfig.
    dev = subprocess.run(["./scripts/diffconfig", ".config.orig", ".config"],
                         cwd=tree, capture_output=True, text=True)
    (cache / f"config-deviations-{args.arch}.txt").write_text(dev.stdout)
    n = len([ln for ln in dev.stdout.splitlines() if ln.strip()])
    log(f"config ready for {args.arch} "
        f"({n} olddefconfig deviations recorded)")

    if args.build:
        jobs = args.jobs or (os.cpu_count() or 4)
        log(f"gcc reference build: make -j{jobs} (this takes a while)")
        # The build exists to emit the .cmd corpus, so it must cover the tree
        # rather than stop at the first object the host gcc rejects: a kernel
        # and a compiler of different vintages disagree over warnings the
        # kernel promotes to errors. -k keeps going, and the corpus size below
        # is what says whether the build was usable.
        r = subprocess.run(["make", f"-j{jobs}", "-k", "KCFLAGS=-Wno-error"],
                           cwd=tree, env=env)
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
