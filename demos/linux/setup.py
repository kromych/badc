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

The cache holds one release: the pin. Anything left there from an earlier
pin is removed once the pinned tarball is verified, and ``--print-tree``
resolves the tree by the pin for callers that would otherwise glob.

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
import shutil
import subprocess
import sys
import tarfile
import tempfile
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


def pinned_tree(cache: Path) -> Path:
    """Where the pinned release is extracted under `cache`."""
    return cache / f"linux-{DEFCONFIG_KERNEL[0]}"


def pinned_tarball(cache: Path) -> Path:
    """Where the pinned release's tarball is downloaded under `cache`."""
    return cache / f"linux-{DEFCONFIG_KERNEL[0]}.tar.xz"


def superseded(cache: Path) -> list[Path]:
    """Cached trees and tarballs of releases the pin has replaced."""
    keep = {pinned_tree(cache), pinned_tarball(cache)}
    return sorted(p for p in cache.glob("linux-*") if p not in keep)


def resolve_tree(cache: Path) -> Path:
    """The pinned tree under `cache`, or exit naming what is there instead.

    A glob of the cache takes directory order, so a superseded release
    left there can win it; two boxes then gate on two corpora and both
    report success. An absent pin and an ambiguous cache are refused
    rather than resolved to whatever else is present."""
    version = DEFCONFIG_KERNEL[0]
    tree = pinned_tree(cache)
    others = ", ".join(d.name for d in superseded(cache) if d.is_dir())
    if not (tree / "Makefile").is_file():
        sys.exit(f"linux setup: no extracted tree for the pinned release "
                 f"{version} under {cache}"
                 + (f" (it holds {others})" if others else "")
                 + "; run setup.py")
    if others:
        sys.exit(f"linux setup: {cache} holds {others} besides the pinned "
                 f"linux-{version}; run setup.py, which reduces the cache to "
                 f"the pin")
    return tree


def resolve_tarball(cache: Path) -> Path:
    """The pinned release's tarball under `cache`, or exit."""
    tar = pinned_tarball(cache)
    if not tar.is_file():
        version = DEFCONFIG_KERNEL[0]
        sys.exit(f"linux setup: no tarball for the pinned release {version} "
                 f"under {cache}; run setup.py --fetch-only")
    return tar


def prune(cache: Path) -> None:
    """Drop what `superseded` names, so the cache holds one release.

    A tree another run holds is not removed: that run is reading it."""
    for path in superseded(cache):
        if path.is_dir():
            held = ktree.holder(path)
            if held:
                sys.exit(f"linux setup: superseded tree {path.name} is held by "
                         f"{held}; the cache cannot be reduced to the pin "
                         f"while that run is in it")
            log(f"removing superseded tree {path.name}")
            shutil.rmtree(path)
        else:
            log(f"removing superseded download {path.name}")
            path.unlink()


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
    # For callers that need the path and would otherwise glob the cache.
    what = ap.add_mutually_exclusive_group()
    what.add_argument("--print-tree", action="store_true",
                      help="print the pinned release's tree under --cache and "
                           "stop; fails when the cache does not hold exactly "
                           "that release")
    what.add_argument("--print-tarball", action="store_true",
                      help="print the pinned release's tarball under --cache "
                           "and stop")
    ap.add_argument("--fetch-only", action="store_true",
                    help="download and verify the tarball, then stop; for "
                         "consumers that extract and configure themselves")
    ap.add_argument("-j", "--jobs", type=int, default=0,
                    help="make parallelism for --build (default: nproc)")
    args = ap.parse_args(argv)

    if args.print_tree or args.print_tarball:
        r = resolve_tree if args.print_tree else resolve_tarball
        print(r(args.cache))
        return 0

    # Before anything is downloaded: a cross build that cannot be run here
    # must say so rather than produce a host-architecture tree.
    gap = karch.cross_gap(args.arch)
    if gap and not args.fetch_only:
        sys.exit(f"linux setup: {gap}")
    version, sha = DEFCONFIG_KERNEL

    cache = args.cache
    cache.mkdir(parents=True, exist_ok=True)
    tar_path = pinned_tarball(cache)
    fetch(tarball_urls(version, sha), tar_path, sha)
    # The pin is in hand, so what the cache still holds of other releases
    # can go: consumers glob this directory, and a second release there is
    # what let two lanes gate on different corpora.
    prune(cache)
    if args.fetch_only:
        log(f"tarball ready at {tar_path}")
        return 0

    tree = pinned_tree(cache)
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


def self_test() -> None:
    """The cache resolves to the pin and to nothing else, and a cache
    holding two releases is refused rather than resolved."""
    version = DEFCONFIG_KERNEL[0]
    with tempfile.TemporaryDirectory() as d:
        cache = Path(d)
        pin, old_tree = pinned_tree(cache), cache / "linux-0.0.1"
        for t in (pin, old_tree):
            t.mkdir()
            (t / "Makefile").touch()
        pinned_tarball(cache).touch()
        (cache / "linux-0.0.1.tar.xz").touch()
        assert [p.name for p in superseded(cache)] == [
            "linux-0.0.1", "linux-0.0.1.tar.xz"], superseded(cache)
        try:
            resolve_tree(cache)
        except SystemExit as e:
            assert "linux-0.0.1" in str(e) and version in str(e), e
        else:
            raise AssertionError("a second release did not refuse the cache")
        # A run holding the superseded tree keeps it; nothing is removed.
        held = ktree.exclusive(old_tree, "a build")
        try:
            prune(cache)
        except SystemExit as e:
            assert "held by" in str(e), e
        else:
            raise AssertionError("a held tree was pruned")
        ktree.release(held)
        prune(cache)
        assert not old_tree.exists() and pin.is_dir()
        assert resolve_tree(cache) == pin
        assert resolve_tarball(cache) == pinned_tarball(cache)
        # The pin absent is a failure, not a fallback to what is there.
        shutil.rmtree(pin)
        try:
            resolve_tree(cache)
        except SystemExit as e:
            assert version in str(e), e
        else:
            raise AssertionError("an absent pin did not fail the resolution")


if __name__ == "__main__":
    if sys.argv[1:] == ["--self-test"]:
        self_test()
        print("linux setup: self-test ok", flush=True)
        raise SystemExit(0)
    raise SystemExit(main())
