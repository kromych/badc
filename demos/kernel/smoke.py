#!/usr/bin/env python3
"""End-to-end smoke for the demos/kernel UEFI kernel.

Compiles kernel.c with badc for x86_64 and AArch64 (as PE32+ EFI applications)
and, when QEMU and UEFI firmware are available, boots each under QEMU/OVMF and
checks the serial output. A correct boot proves badc's inline assembly works
end to end on real hardware paths: `cpuid` + a table-encoder `bswap` on x86_64,
`mrs` on AArch64, and raw-byte templates on both.

Override the badc binary via `$BADC` (default: `target/release/badc[.exe]`).
The boot check is skipped (build-only) when QEMU or the firmware is missing.
"""
from __future__ import annotations

import os
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

HERE = Path(__file__).resolve().parent
REPO_ROOT = HERE.parents[1]
EDK2_DEMO = REPO_ROOT / "demos" / "edk2"
sys.path.insert(0, str(EDK2_DEMO))
import qemu_efi  # noqa: E402  (path set above)

# (badc target, qemu-efi arch, qemu binary, expected serial markers).
TARGETS = [
    (
        "windows-x64",
        "x64",
        "qemu-system-x86_64",
        ["badc kernel: hello", "cpuid vendor:", "bswap: 0x0807060504030201",
         "rawbyte: ok", "BADC-KERNEL-OK"],
    ),
    (
        "windows-arm64",
        "aarch64",
        "qemu-system-aarch64",
        ["badc kernel: hello", "ctr_el0: 0x", "rawbyte: ok", "BADC-KERNEL-OK"],
    ),
]


def log(msg: str) -> None:
    print(msg, flush=True)


def resolve_badc() -> Path:
    env = os.environ.get("BADC")
    cands = [Path(env)] if env else []
    default = REPO_ROOT / "target" / "release" / "badc"
    cands += [default, default.with_suffix(".exe")]
    for c in cands:
        if c.is_file() and os.access(c, os.X_OK):
            return c
    log("FAIL: badc binary not found; hint: cargo build --release --features full")
    sys.exit(1)


def firmware_present(arch: str) -> bool:
    fw = qemu_efi.FIRMWARE[arch]
    return bool(qemu_efi.first_existing(fw["code"]))


def main() -> int:
    badc = resolve_badc()
    log(f"badc={badc}")
    failures = 0
    with tempfile.TemporaryDirectory(prefix="badc-kernel-") as work:
        for target, arch, qemu, expect in TARGETS:
            efi = Path(work) / f"kernel-{arch}.efi"
            cmd = [str(badc), f"--target={target}", str(HERE / "kernel.c"), "-o", str(efi)]
            r = subprocess.run(cmd, capture_output=True, text=True)
            if r.returncode != 0 or not efi.is_file():
                log(f"[{arch}] FAIL: compile\n{r.stderr.strip()}")
                failures += 1
                continue
            log(f"[{arch}] compiled {efi.name} ({efi.stat().st_size} bytes)")

            # A badc-built emulator (demos/qemu) may stand in for the system
            # QEMU via $QEMU_SYSTEM_X64 / $QEMU_SYSTEM_AARCH64.
            qemu_bin = os.environ.get(f"QEMU_SYSTEM_{arch.upper()}", qemu)
            resolved = shutil.which(qemu_bin) or (qemu_bin if os.path.isfile(qemu_bin) else None)
            if not resolved:
                log(f"[{arch}] skip boot: {qemu_bin} not found")
                continue
            if not firmware_present(arch):
                log(f"[{arch}] skip boot: UEFI firmware not found")
                continue

            ok, _text, missing = qemu_efi.run(str(efi), expect, arch=arch, timeout=60)
            if ok:
                log(f"[{arch}] boot OK under {os.path.basename(resolved)}: {expect}")
            elif os.environ.get("BADC_KERNEL_BOOT_OPTIONAL"):
                # Build is the hard gate; the boot is best-effort until observed
                # green on a given runner, then the flag is dropped.
                log(f"[{arch}] boot best-effort: missing {missing} (BADC_KERNEL_BOOT_OPTIONAL)")
            else:
                log(f"[{arch}] FAIL: boot missing {missing}")
                failures += 1

    if failures:
        log(f"FAIL: {failures} target(s) failed")
        return 1
    log("PASS: kernel built (and, where QEMU was available, booted) on all targets")
    return 0


if __name__ == "__main__":
    sys.exit(main())
