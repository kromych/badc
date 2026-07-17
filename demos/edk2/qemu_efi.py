#!/usr/bin/env python3
"""Boot a UEFI application under QEMU/OVMF and check its serial output.

The image is placed at EFI/BOOT/BOOTX64.EFI (or BOOTAA64.EFI) on a virtual
FAT volume that OVMF auto-boots as removable media, so no UEFI Shell, no
mtools, and no on-disk FAT image are required. OVMF's ConSplitter mirrors
ConOut to the serial line, which QEMU routes to stdout.
"""
import argparse
import os
import shutil
import subprocess
import sys
import tempfile

# OVMF firmware locations, in priority order. `$OVMF_CODE`/`$OVMF_VARS` (x64)
# and `$AAVMF_CODE`/`$AAVMF_VARS` (aarch64) override; then the common macOS
# (Homebrew) and Linux distro install paths. An empty env value never matches
# (`os.path.exists("")` is false).
FIRMWARE = {
    "x64": {
        "code": [
            os.environ.get("OVMF_CODE", ""),
            "/opt/homebrew/share/qemu/edk2-x86_64-code.fd",
            "/usr/share/OVMF/OVMF_CODE.fd",
            "/usr/share/edk2/x64/OVMF_CODE.fd",
            "/usr/share/edk2-ovmf/OVMF_CODE.fd",
            "/usr/share/qemu/edk2-x86_64-code.fd",
        ],
        "vars": [
            os.environ.get("OVMF_VARS", ""),
            "/opt/homebrew/share/qemu/edk2-i386-vars.fd",
            "/usr/share/OVMF/OVMF_VARS.fd",
            "/usr/share/edk2/x64/OVMF_VARS.fd",
            "/usr/share/edk2-ovmf/OVMF_VARS.fd",
            "/usr/share/qemu/edk2-i386-vars.fd",
        ],
        "qemu": "qemu-system-x86_64",
        "boot": "BOOTX64.EFI",
        "machine": "q35",
    },
    "aarch64": {
        "code": [
            os.environ.get("AAVMF_CODE", ""),
            "/opt/homebrew/share/qemu/edk2-aarch64-code.fd",
            "/usr/share/AAVMF/AAVMF_CODE.fd",
            "/usr/share/edk2/aarch64/QEMU_EFI-silent-pflash.raw",
        ],
        "vars": [
            os.environ.get("AAVMF_VARS", ""),
            "/opt/homebrew/share/qemu/edk2-arm-vars.fd",
            "/usr/share/AAVMF/AAVMF_VARS.fd",
        ],
        "qemu": "qemu-system-aarch64",
        "boot": "BOOTAA64.EFI",
        "machine": "virt",
    },
}


def first_existing(paths):
    for p in paths:
        if os.path.exists(p):
            return p
    return None


def run(efi, expect, arch="x64", timeout=30, extra_files=None, startup=None):
    fw = FIRMWARE[arch]
    # A badc-built emulator (demos/qemu) can stand in for the system QEMU:
    # `$QEMU_SYSTEM_X64` / `$QEMU_SYSTEM_AARCH64` override the binary.
    qemu = os.environ.get(f"QEMU_SYSTEM_{arch.upper()}", fw["qemu"])
    code = first_existing(fw["code"])
    vars_tmpl = first_existing(fw["vars"])
    if not code:
        sys.exit(f"no OVMF code firmware for {arch}: tried {fw['code']}")
    work = tempfile.mkdtemp(prefix="qemu_efi_")
    esp = os.path.join(work, "esp", "EFI", "BOOT")
    os.makedirs(esp)
    shutil.copy(efi, os.path.join(esp, fw["boot"]))
    for name, path in (extra_files or {}).items():
        shutil.copy(path, os.path.join(work, "esp", name))
    if startup is not None:
        with open(os.path.join(work, "esp", "startup.nsh"), "w") as f:
            f.write(startup)
    vars_rw = os.path.join(work, "vars.fd")
    if vars_tmpl:
        shutil.copy(vars_tmpl, vars_rw)
    else:
        with open(vars_rw, "wb") as f:
            f.write(b"\xff" * os.path.getsize(code))

    cmd = [
        qemu, "-machine", fw["machine"], "-m", "256", "-display", "none",
        "-drive", f"if=pflash,format=raw,unit=0,file={code},readonly=on",
        "-drive", f"if=pflash,format=raw,unit=1,file={vars_rw}",
        "-drive", f"format=raw,file=fat:rw:{os.path.join(work, 'esp')}",
        "-serial", "stdio", "-no-reboot",
    ]
    if arch == "aarch64":
        cmd[1:1] = []  # machine set above; virt needs no extra here for OVMF
        cmd += ["-cpu", "cortex-a57"]
    try:
        out = subprocess.run(cmd, capture_output=True, timeout=timeout).stdout
    except subprocess.TimeoutExpired as e:
        out = e.stdout or b""
    text = out.decode("latin-1").replace("\r", "")
    shutil.rmtree(work, ignore_errors=True)
    wants = [expect] if isinstance(expect, str) else list(expect)
    missing = [w for w in wants if w not in text]
    return (not missing), text, missing


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("efi")
    ap.add_argument("--expect", action="append", required=True,
                    help="substring that must appear on serial (repeatable)")
    ap.add_argument("--arch", default="x64", choices=list(FIRMWARE))
    ap.add_argument("--timeout", type=int, default=30)
    ap.add_argument("--show", action="store_true", help="print captured serial")
    args = ap.parse_args()
    ok, text, missing = run(args.efi, args.expect, args.arch, args.timeout)
    if args.show or not ok:
        sys.stderr.write(text[-4000:] + "\n")
    if ok:
        print(f"PASS: {args.efi} produced {args.expect}")
        return 0
    print(f"FAIL: {args.efi} missing {missing}", file=sys.stderr)
    return 1


if __name__ == "__main__":
    sys.exit(main())
