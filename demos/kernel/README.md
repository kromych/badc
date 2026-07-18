# kernel demo

A small freestanding "kernel" -- a UEFI application that badc compiles for
**x86_64** and **AArch64** and that boots under QEMU through UEFI firmware
(OVMF on x86_64, ArmVirtQemu/AAVMF on AArch64). It runs before any OS, talks
only to the firmware console (which the firmware mirrors to the serial line),
and is a live end-to-end test of badc's **inline assembly**: a correct boot
means the inline asm assembled to the right bytes and executed on real
hardware paths.

What each target exercises:

* **x86_64** -- `cpuid` reads the processor vendor string; a `bswap` lowered
  through the table-driven encoder byte-reverses a known constant (the printed
  `0x0807060504030201` proves it produced the right bytes); a raw-byte `NOP`
  spelled as a `.byte` directive.
* **AArch64** -- `mrs` reads a system register (`CTR_EL0`); a raw-byte `NOP`
  spelled both as a `.byte` directive and as a bare hex-byte run.

## Run

```sh
cargo build --release --features full      # build badc
python3 demos/kernel/smoke.py               # build + boot both targets
```

The smoke compiles `kernel.c` for `windows-x64` and `windows-arm64` (PE32+ EFI
applications) and, when QEMU and UEFI firmware are present, boots each and
checks the serial output for the per-target markers and the final
`BADC-KERNEL-OK`. If QEMU or the firmware is missing the boot is skipped and
the demo is build-only. Override the badc binary with `$BADC`.

## Booting inside badc-built QEMU

By default the smoke uses the system `qemu-system-<arch>`. To run the kernel
inside the **badc-built** emulator from the [`qemu`](../qemu/) demo, point the
per-arch override at its output:

```sh
QEMU_SYSTEM_X64=demos/qemu/qbuild-x86_64/qemu-system-x86_64 \
QEMU_SYSTEM_AARCH64=demos/qemu/qbuild-aarch64/qemu-system-aarch64 \
    python3 demos/kernel/smoke.py
```

so the whole stack -- the kernel, and the emulator it runs in -- is badc-built.

## Preemptive multitasking (`preempt.c`)

`preempt.c` is a second, larger kernel: it installs its own timer interrupt,
runs three hardcoded threads, and context-switches between them on every tick,
with each thread printing to the serial port under a spin lock. It goes beyond
the inline-asm smoke by taking over the interrupt vector table and the timer,
so it is a live test of badc emitting a real interrupt service routine -- a
`__attribute__((naked))` function whose body is the context switch.

It is the target spec for two compiler features it depends on:
`__attribute__((naked))` and inline-asm references to C symbols (the ISR's
`call schedule`). Until those land it is not built by the smoke; the x86_64
path is complete and the AArch64 path (generic timer + GIC + EL1 vectors) is
pending.
