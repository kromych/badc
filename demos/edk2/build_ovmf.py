#!/usr/bin/env python3
"""Build QEMU virt UEFI firmware from a pinned edk2 release.

`--platform ovmf` builds the x86_64 OVMF firmware (OVMF_CODE.fd /
OVMF_VARS.fd); `--platform aavmf` builds the AArch64 ArmVirtQemu
firmware and pads it to the 64 MiB pflash images QEMU's `virt`
machine expects (QEMU_EFI-pflash.raw / QEMU_VARS-pflash.raw). The
images land in --out (default: <work>/fv); the qemu / edk2 demos boot
through them via the BADC_QEMU_OVMF_* / AAVMF_* overrides.

Host requirements: git, gcc, make, nasm, iasl, python3, uuid headers
(Debian/Ubuntu: nasm acpica-tools uuid-dev; Fedora: nasm acpica-tools
libuuid-devel). The aarch64 build runs natively on an AArch64 host;
cross-building needs gcc-aarch64-linux-gnu with GCC5_AARCH64_PREFIX
set.
"""

import argparse
import os
import shutil
import subprocess
import sys
from pathlib import Path

EDK2_URL = "https://github.com/tianocore/edk2.git"
# A recent stable tag (quarterly cadence). The latest at the time of
# writing is edk2-stable202605; this pin trails it by two quarters for
# shakeout and is the version distros package.
EDK2_TAG = "edk2-stable202508"
# Submodules the firmware DSCs need; absent names (older/newer tags)
# are skipped.
SUBMODULES = (
    "CryptoPkg/Library/OpensslLib/openssl",
    "CryptoPkg/Library/MbedTlsLib/mbedtls",
    "MdeModulePkg/Library/BrotliCustomDecompressLib/brotli",
    "BaseTools/Source/C/BrotliCompress/brotli",
    "MdePkg/Library/MipiSysTLib/mipisyst",
    "MdePkg/Library/BaseFdtLib/libfdt",
    "SecurityPkg/DeviceSecurity/SpdmLib/libspdm",
)

# platform -> (edk2 build -a, DSC, Build/<dir>, {output image: is-pflash-padded})
PFLASH_BYTES = 64 * 1024 * 1024
PLATFORMS = {
    "ovmf": {
        "arch": "X64",
        "dsc": "OvmfPkg/OvmfPkgX64.dsc",
        "build_dir": "OvmfX64",
        # Split CODE/VARS; no padding needed.
        "images": {"OVMF_CODE.fd": False, "OVMF_VARS.fd": False, "OVMF.fd": False},
    },
    "aavmf": {
        "arch": "AARCH64",
        "dsc": "ArmVirtPkg/ArmVirtQemu.dsc",
        "build_dir": "ArmVirtQemu-AARCH64",
        # QEMU `virt` pflash wants both images padded to 64 MiB.
        "images": {"QEMU_EFI.fd": True, "QEMU_VARS.fd": True},
    },
}


def run(cmd, cwd=None, env=None):
    print(f"+ {' '.join(map(str, cmd))}", flush=True)
    subprocess.run(cmd, cwd=cwd, env=env, check=True)


def pad_to(src: Path, dst: Path, size: int) -> None:
    data = src.read_bytes()
    if len(data) > size:
        raise SystemExit(f"{src} is {len(data)} bytes, larger than the {size}-byte pflash")
    dst.write_bytes(data + b"\0" * (size - len(data)))


def main() -> int:
    here = Path(__file__).resolve().parent
    ap = argparse.ArgumentParser()
    ap.add_argument("--platform", choices=sorted(PLATFORMS), default="ovmf")
    ap.add_argument("--work", type=Path, default=here / ".ovmf-build")
    ap.add_argument("--out", type=Path, default=None)
    ap.add_argument("--jobs", type=int, default=os.cpu_count() or 4)
    args = ap.parse_args()
    plat = PLATFORMS[args.platform]
    work: Path = args.work
    out: Path = args.out or (work / "fv")
    src = work / "edk2"

    for tool in ("git", "gcc", "make", "nasm", "iasl"):
        if shutil.which(tool) is None:
            print(f"error: `{tool}` not on PATH", file=sys.stderr)
            return 1

    work.mkdir(parents=True, exist_ok=True)
    if not (src / ".git").exists():
        run(["git", "clone", "--depth", "1", "--branch", EDK2_TAG,
             EDK2_URL, str(src)])
    for sub in SUBMODULES:
        if (src / sub).exists():
            run(["git", "submodule", "update", "--init", "--depth", "1",
                 sub], cwd=src)

    run(["make", "-C", "BaseTools", f"-j{args.jobs}"], cwd=src)

    env = os.environ.copy()
    env["WORKSPACE"] = str(src)
    env["EDK_TOOLS_PATH"] = str(src / "BaseTools")
    # `build` is a BaseTools wrapper reachable after edksetup.sh; run the
    # whole sequence through bash so the setup's exports apply.
    build = (f". ./edksetup.sh && build -a {plat['arch']} -t GCC5 -b RELEASE "
             f"-n {args.jobs} -p {plat['dsc']}")
    run(["bash", "-ec", build], cwd=src, env=env)

    fv = src / "Build" / plat["build_dir"] / "RELEASE_GCC5" / "FV"
    out.mkdir(parents=True, exist_ok=True)
    for name, padded in plat["images"].items():
        img = fv / name
        if not img.is_file():
            print(f"error: {img} missing after build", file=sys.stderr)
            return 1
        if padded:
            dst = out / (Path(name).stem + "-pflash.raw")
            pad_to(img, dst, PFLASH_BYTES)
            print(f"wrote {dst} ({PFLASH_BYTES} bytes, padded)")
        else:
            shutil.copyfile(img, out / name)
            print(f"wrote {out / name}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
