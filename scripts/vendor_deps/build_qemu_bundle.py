#!/usr/bin/env python3
"""Assemble the vendor-deps QEMU bundle for demos/qemu.

Unlike the other vendored libraries, QEMU's bundle is not a plain upstream
archive: the build is driven by meson, which generates a large tree of headers
and sources that is not reproducible off-box. The demo needs that generated
config, so this tool captures it from a configured QEMU build directory
alongside a trimmed copy of the source.

Run it on a box where QEMU has been configured and built for the target
(``meson setup`` + ``ninja``). For each target it captures the meson-generated
build inputs; the source tree is captured once and shared across targets.

  # one target per configured build directory (a target's build dir has its
  # qemu-system-<arch>.rsp + libqemuutil.a.rsp + compile_commands.json):
  build_qemu_bundle.py --qemu-src ~/qemu-rm --qemu-build ~/qbuild-rm \
      --arch aarch64 --out /tmp/qbundle

  # add another target's build inputs (rsync its build dir here first if it was
  # produced on another box), reusing the shared source:
  build_qemu_bundle.py --qemu-src ~/qemu-rm --qemu-build ~/qbuild-x64 \
      --arch x86_64 --out /tmp/qbundle

  # pack + hash + print the upload command:
  build_qemu_bundle.py --out /tmp/qbundle --pack

The packed asset is ``qemu-<version>-<commit8>.tar.xz`` with layout
``qemu-<version>/{qemu-rm, qbuild-<arch>...}``. Pin its sha256 in
``demos/qemu/setup.py`` and upload it to the ``vendor-deps-v1`` release.

The x86 run-time ROM set is a separate, independent asset, packed straight from
an upstream release tarball (no build directory needed):

  build_qemu_bundle.py --pack-pc-bios ~/qemu-11.0.2.tar.xz --out /tmp/roms
"""

from __future__ import annotations

import argparse
import hashlib
import shutil
import subprocess
import sys
import tarfile
from pathlib import Path

# Source subtrees that are not compile inputs for the emulator. subprojects is
# kept (libvhost-user / libvduse headers are included by the build) minus the
# large berkeley reference/test float data, which the build does not use (QEMU
# compiles its in-tree fpu/softfloat.c).
SRC_EXCLUDE = {".git", ".github", ".gitlab", ".gitlab-ci.d", "tests", "docs",
               "roms", "pc-bios"}
NESTED_EXCLUDE = SRC_EXCLUDE | {"berkeley-softfloat-3", "berkeley-testfloat-3"}

# Run-time ROM set for QEMU's x86 machines: the machine firmware plus the option
# ROMs a `pc` / `q35` boot loads (the APIC helper, the -kernel loader, the VGA
# BIOS). Prebuilt blobs that upstream ships in pc-bios/; not compile inputs, so
# SRC_EXCLUDE drops them from the source capture, but an emulator linked without
# a data directory needs -L pointed at them. --pack-pc-bios packs this set.
PC_BIOS_X86 = ("bios-256k.bin", "kvmvapic.bin", "linuxboot_dma.bin",
               "vgabios-stdvga.bin")

# Build-directory files that are compile inputs (meson-generated headers and
# sources, the compile database, and the linker response files). Everything else
# in the build dir is a build output (objects, archives, ninja state) and is not
# captured.
BUILD_SUFFIXES = (".h", ".c", ".inc", ".def", ".rsp")
BUILD_NAMES = ("compile_commands.json",)


def sh(cmd: list[str], cwd: Path | None = None) -> str:
    return subprocess.run(cmd, cwd=cwd, check=True, capture_output=True, text=True).stdout.strip()


def qemu_version(src: Path) -> tuple[str, str]:
    """(version, commit) from the source tree's git metadata."""
    desc = sh(["git", "-C", str(src), "describe", "--tags", "--always"])
    commit = sh(["git", "-C", str(src), "rev-parse", "HEAD"])
    return desc.lstrip("v"), commit


def copy_source(src: Path, dst: Path) -> None:
    if dst.exists():
        return
    dst.mkdir(parents=True)
    for entry in sorted(src.iterdir()):
        if entry.name in SRC_EXCLUDE:
            continue
        target = dst / entry.name
        if entry.is_dir():
            shutil.copytree(entry, target, symlinks=True,
                            ignore=shutil.ignore_patterns(*NESTED_EXCLUDE))
        else:
            shutil.copy2(entry, target, follow_symlinks=False)


def copy_build_inputs(build: Path, dst: Path) -> int:
    if dst.exists():
        shutil.rmtree(dst)
    n = 0
    for f in build.rglob("*"):
        if not f.is_file():
            continue
        if f.suffix in BUILD_SUFFIXES or f.name in BUILD_NAMES:
            rel = f.relative_to(build)
            out = dst / rel
            out.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(f, out)
            n += 1
    return n


def sha256_of(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as fh:
        for chunk in iter(lambda: fh.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def pack_pc_bios(tarball: Path, out: Path) -> Path:
    """Pack PC_BIOS_X86 out of an upstream QEMU release tarball into a flat
    asset. The name carries the release version and the first 8 hex digits of
    that tarball's sha256, so the asset states which release the blobs are
    from."""
    staged = out / "pc-bios-x86"
    if staged.exists():
        shutil.rmtree(staged)
    staged.mkdir(parents=True)
    version, found = "", set()
    with tarfile.open(tarball, "r:*") as tf:
        for m in tf:
            head, _, rel = m.name.partition("/")
            name = rel[len("pc-bios/"):] if rel.startswith("pc-bios/") else ""
            if not m.isfile() or name not in PC_BIOS_X86:
                continue
            version = head.split("qemu-", 1)[-1]
            with tf.extractfile(m) as src, (staged / name).open("wb") as dst:
                shutil.copyfileobj(src, dst)
            found.add(name)
    missing = [n for n in PC_BIOS_X86 if n not in found]
    if missing:
        raise SystemExit(f"{tarball}: no pc-bios/{{{','.join(missing)}}}")
    asset = out / f"pc-bios-x86-{version}-{sha256_of(tarball)[:8]}.tar.xz"
    print(f"packing {len(found)} ROMs from {tarball.name} -> {asset}")
    subprocess.run(["tar", "-C", str(staged), "-cJf", str(asset), *PC_BIOS_X86],
                   check=True)
    return asset


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--qemu-src", type=Path, help="QEMU source tree (for a capture step)")
    ap.add_argument("--qemu-build", type=Path, help="a configured+built QEMU build dir")
    ap.add_argument("--arch", help="target arch of --qemu-build (e.g. aarch64, x86_64)")
    ap.add_argument("--out", type=Path, required=True, help="bundle working directory")
    ap.add_argument("--version", help="override the version (default: from git)")
    ap.add_argument("--pack", action="store_true", help="tar.xz + sha256 + upload hint")
    ap.add_argument("--pack-pc-bios", type=Path, metavar="TARBALL",
                    help="pack the x86 ROM set from an upstream QEMU release "
                         "tarball (independent of the bundle steps)")
    args = ap.parse_args(argv)

    if args.pack_pc_bios:
        asset = pack_pc_bios(args.pack_pc_bios, args.out)
        print(f"\n{asset.name}\n  sha256 = {sha256_of(asset)}"
              f"\n  size   = {asset.stat().st_size}")
        print("\nPin in demos/qemu/setup.py (PC_BIOS_SHA256) and upload with:\n"
              f"  gh release upload vendor-deps-v1 --repo kromych/badc {asset}")
        return 0

    if args.qemu_build or args.arch or args.qemu_src:
        if not (args.qemu_src and args.qemu_build and args.arch):
            ap.error("a capture step needs --qemu-src, --qemu-build and --arch together")
        version, commit = (args.version, "") if args.version else qemu_version(args.qemu_src)
        root = args.out / f"qemu-{version}"
        copy_source(args.qemu_src, root / "qemu-rm")
        n = copy_build_inputs(args.qemu_build, root / f"qbuild-{args.arch}")
        (root / ".commit").write_text(commit + "\n") if commit else None
        print(f"captured {args.arch}: {n} build-input files; source at {root / 'qemu-rm'}")

    if args.pack:
        roots = sorted(args.out.glob("qemu-*"))
        roots = [r for r in roots if r.is_dir()]
        if len(roots) != 1:
            ap.error(f"expected exactly one qemu-<version> dir in {args.out}, found {len(roots)}")
        root = roots[0]
        version = root.name.split("qemu-", 1)[1]
        commit = (root / ".commit").read_text().strip() if (root / ".commit").is_file() else ""
        (root / ".commit").unlink(missing_ok=True)
        if not commit:
            ap.error("no .commit recorded; run a capture step with --qemu-src first")
        asset = args.out / f"qemu-{version}-{commit[:8]}.tar.xz"
        print(f"packing {root} -> {asset}")
        with subprocess.Popen(["tar", "-C", str(args.out), "-cf", "-", root.name],
                              stdout=subprocess.PIPE) as tar:
            with open(asset, "wb") as out, subprocess.Popen(
                    ["xz", "-6", "-T0"], stdin=tar.stdout, stdout=out) as xz:
                xz.wait()
        digest = sha256_of(asset)
        print(f"\n{asset.name}\n  sha256 = {digest}\n  size   = {asset.stat().st_size}")
        print("\nPin in demos/qemu/setup.py (SHA256) and upload with:\n"
              f"  gh release upload vendor-deps-v1 --repo kromych/badc {asset}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
