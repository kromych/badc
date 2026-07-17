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
"""

from __future__ import annotations

import argparse
import hashlib
import shutil
import subprocess
import sys
from pathlib import Path

# Source subtrees that are not compile inputs for the emulator. subprojects is
# kept (libvhost-user / libvduse headers are included by the build) minus the
# large berkeley reference/test float data, which the build does not use (QEMU
# compiles its in-tree fpu/softfloat.c).
SRC_EXCLUDE = {".git", ".github", ".gitlab", ".gitlab-ci.d", "tests", "docs",
               "roms", "pc-bios"}
NESTED_EXCLUDE = SRC_EXCLUDE | {"berkeley-softfloat-3", "berkeley-testfloat-3"}

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


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--qemu-src", type=Path, help="QEMU source tree (for a capture step)")
    ap.add_argument("--qemu-build", type=Path, help="a configured+built QEMU build dir")
    ap.add_argument("--arch", help="target arch of --qemu-build (e.g. aarch64, x86_64)")
    ap.add_argument("--out", type=Path, required=True, help="bundle working directory")
    ap.add_argument("--version", help="override the version (default: from git)")
    ap.add_argument("--pack", action="store_true", help="tar.xz + sha256 + upload hint")
    args = ap.parse_args(argv)

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
