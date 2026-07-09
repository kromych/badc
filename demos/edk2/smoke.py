#!/usr/bin/env python3
"""End-to-end smoke for badc against TianoCore EDK II (UEFI).

Builds a UEFI application from real EDK II MdePkg sources with badc's own
linker -- no external ld/lld, no GenFw -- into a PE32+ EFI application, then
(if QEMU + OVMF are available) boots it under OVMF and checks the serial
output. The app (`MyApp.c`) formats through real BasePrintLib `UnicodeSPrint`
and writes to `ConOut`, so a correct boot exercises the MdePkg library closure
end to end.

Build shape (the badc EDK II toolchain, MSVC compiler identity on X64):
  badc --freestanding --target=windows-x64 -I MdePkg/Include -I MdePkg/Include/X64
       -D_MSC_EXTENSIONS -D_MSC_VER=1900 -Dstatic_assert=_Static_assert
       -include MiniAutoGen.h  <app + AutoGen glue + MdePkg closure>  -o app.efi

The library closure was resolved iteratively (link, read the first undefined
symbol, add the MdePkg C file that defines it, repeat) and is fixed here.

Override the badc binary via `$BADC` (default: `target/release/badc[.exe]`).
"""

from __future__ import annotations

import os
import shutil
import struct
import subprocess
import sys
import tempfile
from pathlib import Path

EDK2_DEMO = Path(__file__).resolve().parent
REPO_ROOT = EDK2_DEMO.parents[1]
SRC = EDK2_DEMO / "src"
MDE = SRC / "MdePkg"

# MdePkg library closure (relative to MdePkg/Library). BaseMemoryLib is a
# directory glob; the rest are the specific files the app pulls in.
CLOSURE = [
    "UefiApplicationEntryPoint/ApplicationEntryPoint.c",
    "UefiBootServicesTableLib/UefiBootServicesTableLib.c",
    "UefiRuntimeServicesTableLib/UefiRuntimeServicesTableLib.c",
    "BasePrintLib/PrintLib.c",
    "BasePrintLib/PrintLibInternal.c",
    "BaseDebugLibNull/DebugLib.c",
    "BaseLib/DivU64x32Remainder.c",
    "BaseLib/SafeString.c",
    "BaseLib/Unaligned.c",
    "BaseLib/LShiftU64.c",
    "BaseLib/Math64.c",
    "BaseLib/String.c",
    "BaseLib/DivU64x32.c",
    "BaseLib/MultU64x32.c",
    "BaseLib/RShiftU64.c",
    "BaseLib/SwapBytes32.c",
    "BaseLib/SwapBytes16.c",
]

# PE32+ subsystem 10 = EFI application.
IMAGE_SUBSYSTEM_EFI_APPLICATION = 10

# The app is portable C over the MdePkg API, so one closure + one source build
# for both targets; only the badc target, the arch include dir, the PE machine
# id, and the QEMU arch differ. EFIAPI is the MS ABI, which badc's windows-*
# targets emit (MS x64 on X64, AAPCS64 on AArch64).
ARCHES = [
    {"label": "X64", "target": "windows-x64", "inc": "X64",
     "machine": 0x8664, "qemu_arch": "x64", "qemu": "qemu-system-x86_64"},
    {"label": "AArch64", "target": "windows-arm64", "inc": "AArch64",
     "machine": 0xAA64, "qemu_arch": "aarch64", "qemu": "qemu-system-aarch64"},
]


def log(m: str) -> None:
    print(f"edk2 smoke: {m}", flush=True)


def fail(m: str) -> "None":
    print(f"edk2 smoke FAIL: {m}", file=sys.stderr, flush=True)
    sys.exit(1)


def resolve_badc() -> Path:
    env = os.environ.get("BADC")
    cands = [Path(env)] if env else []
    default = REPO_ROOT / "target" / "release" / "badc"
    cands += [default, default.with_suffix(".exe")]
    for c in cands:
        if c.is_file() and os.access(c, os.X_OK):
            return c
    fail("BADC binary not found; hint: cargo build --release --features full")
    raise SystemExit(2)


def ensure_source() -> None:
    if (MDE / "Include" / "Uefi.h").is_file():
        return
    log("fetching the MdePkg subset via setup.py")
    subprocess.run([sys.executable, str(EDK2_DEMO / "setup.py")], check=True)


def build_efi(badc: Path, arch: dict, out: Path) -> None:
    lib = MDE / "Library"
    sources = [str(EDK2_DEMO / "AutoGenGlue.c"), str(EDK2_DEMO / "MyApp.c")]
    for rel in CLOSURE:
        sources.append(str(lib / rel))
    sources += [
        str(p)
        for p in sorted((lib / "BaseMemoryLib").glob("*.c"))
        if not p.name.startswith("._")
    ]
    cmd = [
        str(badc), "--freestanding", f"--target={arch['target']}",
        "-I", str(MDE / "Include"), "-I", str(MDE / "Include" / arch["inc"]),
        "-D_MSC_EXTENSIONS", "-D_MSC_VER=1900", "-Dstatic_assert=_Static_assert",
        "-include", str(EDK2_DEMO / "MiniAutoGen.h"),
        *sources, "-o", str(out),
    ]
    r = subprocess.run(cmd, capture_output=True, text=True)
    if r.returncode != 0 or not out.is_file():
        fail(f"badc failed to build the {arch['label']} EFI application:\n"
             f"{r.stderr.strip()[-1500:]}")


def check_pe_efi_application(efi: Path, arch: dict) -> None:
    """Verify the output is a PE32+ EFI application for the expected machine."""
    data = efi.read_bytes()
    if data[:2] != b"MZ":
        fail("output is not a PE image (missing MZ)")
    pe_off = struct.unpack_from("<I", data, 0x3C)[0]
    if data[pe_off:pe_off + 4] != b"PE\0\0":
        fail("output is not a PE image (missing PE signature)")
    magic = struct.unpack_from("<H", data, pe_off + 24)[0]
    if magic != 0x20B:
        fail(f"expected PE32+ optional header magic 0x20B, got {magic:#x}")
    machine = struct.unpack_from("<H", data, pe_off + 4)[0]
    subsystem = struct.unpack_from("<H", data, pe_off + 24 + 68)[0]
    if machine != arch["machine"]:
        fail(f"expected machine {arch['machine']:#x}, got {machine:#x}")
    if subsystem != IMAGE_SUBSYSTEM_EFI_APPLICATION:
        fail(f"expected EFI-application subsystem {IMAGE_SUBSYSTEM_EFI_APPLICATION}, "
             f"got {subsystem}")
    log(f"[{arch['label']}] PE32+ EFI application OK "
        f"(machine={arch['machine']:#x}, subsystem=10, {len(data)} bytes)")


def try_boot(efi: Path, arch: dict) -> None:
    """Boot under QEMU/OVMF if both are available; otherwise skip."""
    if not shutil.which(arch["qemu"]):
        log(f"[{arch['label']}] {arch['qemu']} not found; skipping the boot check")
        return
    harness = EDK2_DEMO / "qemu_efi.py"
    r = subprocess.run(
        [sys.executable, str(harness), str(efi), "--expect", "badc+EDK2",
         "--arch", arch["qemu_arch"]],
        capture_output=True, text=True)
    out = r.stdout + r.stderr
    if "no OVMF" in out.lower():
        log(f"[{arch['label']}] OVMF firmware not found; skipping the boot check")
        return
    if r.returncode != 0 or "PASS" not in out:
        # `$BADC_EDK2_BOOT_OPTIONAL` downgrades a boot failure to a warning so
        # an environment with unstable QEMU/firmware still gates on the build.
        msg = (f"[{arch['label']}] boot under OVMF/QEMU did not produce the "
               f"expected output:\n{out[-1200:]}")
        if os.environ.get("BADC_EDK2_BOOT_OPTIONAL"):
            log(f"WARNING (boot optional): {msg}")
            return
        fail(msg)
    log(f"[{arch['label']}] booted under OVMF/QEMU; MyApp printed via BasePrintLib")


def main() -> int:
    badc = resolve_badc()
    log(f"badc={badc}")
    ensure_source()
    with tempfile.TemporaryDirectory(prefix="edk2-smoke-") as d:
        for arch in ARCHES:
            efi = Path(d) / f"app_{arch['label']}.efi"
            log(f"[{arch['label']}] building the UEFI application with badc "
                f"(own-linker, no GenFw)")
            build_efi(badc, arch, efi)
            check_pe_efi_application(efi, arch)
            try_boot(efi, arch)
    log("all lanes green")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
