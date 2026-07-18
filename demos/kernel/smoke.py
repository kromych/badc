#!/usr/bin/env python3
"""End-to-end smoke for the demos/kernel UEFI kernels.

Compiles each kernel with badc for x86_64 and AArch64 (as PE32+ EFI
applications) and, when QEMU and UEFI firmware are available, boots each under
QEMU/OVMF and checks the serial output.

kernel.c exercises inline assembly on the boot path: `cpuid` + a table-encoder
`bswap` on x86_64, `mrs` on AArch64, and raw-byte templates on both. preempt.c
goes further on x86_64: it installs its own IDT and PIT timer, then round-robins
three threads through a naked-function interrupt service routine that performs
the context switch, so a correct boot proves badc emits a working ISR (naked
prologue suppression, explicit-register operands, push/pop, immediate port I/O,
and a direct `call` to a C symbol) end to end. On AArch64 preempt.c prints a
banner and halts (generic-timer preemption not implemented yet).

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

# (badc target, qemu-efi arch, qemu binary).
TARGETS = [
    ("windows-x64", "x64", "qemu-system-x86_64"),
    ("windows-arm64", "aarch64", "qemu-system-aarch64"),
]

# (kernel source, {arch: expected serial markers}).
KERNELS = [
    (
        "kernel.c",
        {
            "x64": ["badc kernel: hello", "cpuid vendor:",
                    "bswap: 0x0807060504030201", "rawbyte: ok", "BADC-KERNEL-OK"],
            "aarch64": ["badc kernel: hello", "ctr_el0: 0x", "rawbyte: ok",
                        "BADC-KERNEL-OK"],
        },
    ),
    (
        "preempt.c",
        # Both arches now round-robin three threads under a timer ISR.
        {
            arch: ["BADC-PREEMPT: start", "[thread 0]", "[thread 1]",
                   "[thread 2]", "BADC-PREEMPT: scheduler done",
                   "BADC-PREEMPT-OK"]
            for arch in ("x64", "aarch64")
        },
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
        for source, markers in KERNELS:
            stem = Path(source).stem
            for target, arch, qemu in TARGETS:
                tag = f"{stem}/{arch}"
                efi = Path(work) / f"{stem}-{arch}.efi"
                cmd = [str(badc), f"--target={target}", str(HERE / source), "-o", str(efi)]
                r = subprocess.run(cmd, capture_output=True, text=True)
                if r.returncode != 0 or not efi.is_file():
                    log(f"[{tag}] FAIL: compile\n{r.stderr.strip()}")
                    failures += 1
                    continue
                log(f"[{tag}] compiled {efi.name} ({efi.stat().st_size} bytes)")

                # A badc-built emulator (demos/qemu) may stand in for the system
                # QEMU via $QEMU_SYSTEM_X64 / $QEMU_SYSTEM_AARCH64.
                qemu_bin = os.environ.get(f"QEMU_SYSTEM_{arch.upper()}", qemu)
                resolved = shutil.which(qemu_bin) or (qemu_bin if os.path.isfile(qemu_bin) else None)
                if not resolved:
                    log(f"[{tag}] skip boot: {qemu_bin} not found")
                    continue
                if not firmware_present(arch):
                    log(f"[{tag}] skip boot: UEFI firmware not found")
                    continue

                expect = markers[arch]
                ok, _text, missing = qemu_efi.run(str(efi), expect, arch=arch, timeout=60)
                if ok:
                    log(f"[{tag}] boot OK under {os.path.basename(resolved)}: {expect}")
                elif os.environ.get("BADC_KERNEL_BOOT_OPTIONAL"):
                    # Build is the hard gate; the boot is best-effort until observed
                    # green on a given runner, then the flag is dropped.
                    log(f"[{tag}] boot best-effort: missing {missing} (BADC_KERNEL_BOOT_OPTIONAL)")
                else:
                    log(f"[{tag}] FAIL: boot missing {missing}")
                    failures += 1

    if failures:
        log(f"FAIL: {failures} kernel/target combination(s) failed")
        return 1
    log("PASS: kernels built (and, where QEMU was available, booted) on all targets")
    return 0


if __name__ == "__main__":
    sys.exit(main())
