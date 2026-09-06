#!/usr/bin/env python3
"""End-to-end smoke for the demos/kernel UEFI kernels.

Compiles each kernel with badc for x86_64 and AArch64 (as PE32+ EFI
applications) and, when QEMU and UEFI firmware are available, boots each under
QEMU/OVMF and checks the serial output.

kernel.c exercises inline assembly on the boot path: `cpuid` + a table-encoder
`bswap` on x86_64, `mrs` on AArch64, and raw-byte templates on both. preempt.c
goes further on both arches: it installs its own timer interrupt, then round-
robins three threads through a naked-function interrupt service routine that
performs the context switch, so a correct boot proves badc emits a working ISR
end to end. x86_64 uses the 8259 PIC + 8254 PIT + an IDT (exercising naked
prologue suppression, explicit-register operands, push/pop, immediate port I/O,
and a direct `call` to a C symbol); AArch64 uses the GICv2 + the virtual generic
timer + an EL1 vector table, reaching the scheduler through TPIDR_EL1 and a
`blr`. A third lane rebuilds preempt.c with its fault injection enabled and
requires the unhandled-vector diagnostic on the serial line. A fourth holds
the 8259's ICW1..ICW2 window open past a firmware timer period, where an
IRQ0 taken with interrupts still enabled arrives as vector 0, and requires
the normal boot.

Override the badc binary via `$BADC` (default: `target/release/badc[.exe]`).
The boot check is skipped (build-only) when QEMU or the firmware is missing.

`--arch <x64|aarch64|native>` narrows the run to one architecture's boots;
every kernel is still built for both, each build costing cents of a second.
qemu_efi requests no accelerator, so both architectures run under TCG on any
host and the two cost the same to within a few tenths of a second: on the
x86_64 box the aarch64 boots came in at 5.8-6.1 s against 6.1-6.3 s for x64.
The local gate therefore runs both and does not use the filter.
"""
from __future__ import annotations

import os
import platform
import shutil
import subprocess
import sys
import tempfile
import time
from pathlib import Path
from typing import NamedTuple

HERE = Path(__file__).resolve().parent
REPO_ROOT = HERE.parents[1]
EDK2_DEMO = REPO_ROOT / "demos" / "edk2"
sys.path.insert(0, str(EDK2_DEMO))
import qemu_efi  # noqa: E402  (path set above)

# Seconds a boot may take before it is abandoned. qemu_efi stops the emulator
# at the markers, so a passing boot no longer spends this and the budget is
# set above the slowest boot measured -- 10.9 s, on a box carrying a load
# average of 8 -- rather than against the cost of a green run.
BOOT_TIMEOUT = 120

# (badc target, qemu-efi arch, qemu binary).
TARGETS = [
    ("windows-x64", "x64", "qemu-system-x86_64"),
    ("windows-arm64", "aarch64", "qemu-system-aarch64"),
]

# (label, kernel source, extra badc flags, {arch: expected serial markers}).
# An arch missing from the marker map is not built for that lane.
KERNELS = [
    (
        "kernel",
        "kernel.c",
        [],
        {
            "x64": ["badc kernel: hello", "cpuid vendor:",
                    "bswap: 0x0807060504030201", "rawbyte: ok", "BADC-KERNEL-OK"],
            "aarch64": ["badc kernel: hello", "ctr_el0: 0x", "rawbyte: ok",
                        "BADC-KERNEL-OK"],
        },
    ),
    (
        "preempt",
        "preempt.c",
        [],
        # Both arches now round-robin three threads under a timer ISR.
        {
            arch: ["BADC-PREEMPT: start", "[thread 0]", "[thread 1]",
                   "[thread 2]", "BADC-PREEMPT: scheduler done",
                   "BADC-PREEMPT-OK"]
            for arch in ("x64", "aarch64")
        },
    ),
    (
        # The unhandled-vector diagnostic: the guest raises #GP once its IDT is
        # installed and must name the vector and the error code instead of
        # triple-faulting. x86_64 only; the AArch64 path has no IDT.
        "preempt-fault",
        "preempt.c",
        ["-DPREEMPT_FAULT_INJECT"],
        {"x64": ["BADC-PREEMPT: unhandled vector 13 error 0x1234 rip 0x"]},
    ),
    (
        # The interrupt hand-over. UEFI enters an application with interrupts
        # enabled and the firmware's timer on IRQ0, and the 8259 init sequence
        # clears the master's vector base and mask until ICW2, so an IRQ0 taken
        # in that window arrives at vector 0 -- the demo's own unhandled-fault
        # gate, which halts. The window is normally six instructions wide and
        # the failure was seen once on a loaded box; this build holds it open
        # past a tick, so a setup that does not mask fails every boot.
        # x86_64 only; the AArch64 path has no 8259.
        "preempt-pic",
        "preempt.c",
        ["-DPREEMPT_PIC_WINDOW_STRESS"],
        {"x64": ["BADC-PREEMPT: start", "[thread 0]", "[thread 1]",
                 "[thread 2]", "BADC-PREEMPT: scheduler done",
                 "BADC-PREEMPT-OK"]},
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


def native_arch() -> str | None:
    """The `qemu_efi` arch this host runs without emulation, or None."""
    m = platform.machine().lower()
    if m in ("x86_64", "amd64"):
        return "x64"
    if m in ("aarch64", "arm64"):
        return "aarch64"
    return None


def arch_filter(argv) -> str | None:
    """`--arch <name>`, or `--arch native` for this host's own."""
    for i, a in enumerate(argv):
        name = None
        if a == "--arch" and i + 1 < len(argv):
            name = argv[i + 1]
        elif a.startswith("--arch="):
            name = a.split("=", 1)[1]
        if name is None:
            continue
        if name == "native":
            got = native_arch()
            if got is None:
                log(f"--arch native: {platform.machine()} is neither lane, running both")
            return got
        return name
    return None


class Case(NamedTuple):
    label: str
    source: str
    defines: list
    target: str
    arch: str
    opt: str
    flags: list
    markers: list
    qemu: str
    boots: bool


def plan(only: str | None = None) -> list[Case]:
    """Every build the run covers. `only` clears `boots` on the other
    architecture's cases; the builds stay, each costing cents of a second.

    Both optimization levels are built: -O runs the SSA/inliner pipeline the
    default build skips, which the naked ISR and the exact context frame must
    survive unchanged.
    """
    cases = []
    for label, source, defines, markers in KERNELS:
        for target, arch, qemu in TARGETS:
            if arch not in markers:
                continue
            for opt, flags in (("O0", []), ("O", ["-O"])):
                cases.append(Case(label, source, defines, target, arch, opt,
                                  flags, markers[arch], qemu,
                                  only is None or arch == only))
    return cases


def main() -> int:
    badc = resolve_badc()
    log(f"badc={badc}")
    only = arch_filter(sys.argv[1:])
    if only:
        log(f"arch filter: {only}")
    failures = 0
    booted = skipped = 0
    with tempfile.TemporaryDirectory(prefix="badc-kernel-") as work:
        for case in plan(only):
            tag = f"{case.label}/{case.arch}/{case.opt}"
            efi = Path(work) / f"{tag.replace('/', '-')}.efi"
            cmd = [str(badc), *case.flags, *case.defines,
                   f"--target={case.target}", str(HERE / case.source),
                   "-o", str(efi)]
            r = subprocess.run(cmd, capture_output=True, text=True)
            if r.returncode != 0 or not efi.is_file():
                log(f"[{tag}] FAIL: compile\n{r.stderr.strip()}")
                failures += 1
                continue
            log(f"[{tag}] compiled {efi.name} ({efi.stat().st_size} bytes)")
            if not case.boots:
                continue

            # A badc-built emulator (demos/qemu) may stand in for the system
            # QEMU via $QEMU_SYSTEM_X64 / $QEMU_SYSTEM_AARCH64.
            qemu_bin = os.environ.get(f"QEMU_SYSTEM_{case.arch.upper()}",
                                      case.qemu)
            resolved = shutil.which(qemu_bin) or (
                qemu_bin if os.path.isfile(qemu_bin) else None)
            if not resolved:
                log(f"[{tag}] skip boot: {qemu_bin} not found")
                skipped += 1
                continue
            if not firmware_present(case.arch):
                log(f"[{tag}] skip boot: UEFI firmware not found")
                skipped += 1
                continue

            t0 = time.monotonic()
            ok, text, missing = qemu_efi.run(str(efi), case.markers,
                                             arch=case.arch,
                                             timeout=BOOT_TIMEOUT)
            elapsed = time.monotonic() - t0
            if ok:
                booted += 1
                log(f"[{tag}] boot OK in {elapsed:.1f}s under "
                    f"{os.path.basename(resolved)}: {case.markers}")
                continue
            # qemu_efi stops the emulator at the markers, so a failed boot is
            # the only one that reaches its budget. An earlier end means the
            # guest stopped on its own: under `-no-reboot` a guest reset (on
            # x86_64, a fault with no handler in the kernel's own IDT) does
            # that. Report it apart from a run that never printed the markers,
            # and carry the serial text -- without it the only record of a
            # failed boot is the list of markers that did not appear.
            why = (f"guest exited after {elapsed:.1f}s of a {BOOT_TIMEOUT}s "
                   f"budget" if elapsed < BOOT_TIMEOUT - 5 else
                   f"ran the full {BOOT_TIMEOUT}s")
            detail = f"{why}; missing {missing}\n--- serial ---\n{text[-2000:]}"
            if os.environ.get("BADC_KERNEL_BOOT_OPTIONAL"):
                # Build is the hard gate; the boot is best-effort until
                # observed green on a runner, then the flag is dropped.
                log(f"[{tag}] boot best-effort: {detail} "
                    f"(BADC_KERNEL_BOOT_OPTIONAL)")
            else:
                log(f"[{tag}] FAIL: boot {detail}")
                failures += 1

    if skipped:
        log(f"NOTE: {skipped} boot(s) skipped for a missing emulator or "
            f"firmware; those targets have build cover only")
    if failures:
        log(f"FAIL: {failures} kernel/target combination(s) failed")
        return 1
    log(f"PASS: {len(plan(only))} kernels built, {booted} booted, "
        f"{skipped} boots skipped")
    return 0


def self_test() -> int:
    """The arch filter drops the other architecture's boots, not its builds."""
    assert arch_filter([]) is None
    assert arch_filter(["--arch", "x64"]) == "x64"
    assert arch_filter(["--arch=aarch64"]) == "aarch64"
    assert arch_filter(["--arch", "native"]) == native_arch()

    full = plan()
    assert all(c.boots for c in full)
    # The boot count is the gate's budget: a kernel added here costs every
    # Linux lane another emulator start.
    assert (len(full), sum(c.arch == "x64" for c in full)) == (12, 8), full
    for arch in ("x64", "aarch64"):
        kept = plan(arch)
        assert [c[:-1] for c in kept] == [c[:-1] for c in full]
        assert [c for c in kept if c.boots] == [
            c for c in full if c.arch == arch]

    print("kernel smoke: self-test ok", flush=True)
    return 0


if __name__ == "__main__":
    if "--self-test" in sys.argv[1:]:
        sys.exit(self_test())
    sys.exit(main())
