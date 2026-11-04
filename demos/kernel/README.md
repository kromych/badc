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
python3 demos/kernel/smoke.py --arch native # boot this host's arch only
python3 demos/kernel/smoke.py --self-test   # check the arch filter, no boot
```

The smoke compiles `kernel.c` for `windows-x64` and `windows-arm64` (PE32+ EFI
applications) and, when QEMU and UEFI firmware are present, boots each and
checks the serial output for the per-target markers and the final
`BADC-KERNEL-OK`. If QEMU or the firmware is missing the boot is skipped, the
demo is build-only for that target, and the closing summary says how many
boots ran. Override the badc binary with `$BADC`.

The emulator is stopped as soon as the expected markers reach the serial line,
so a boot costs what the firmware and the kernel take to print them. Neither
kernel exits on its own -- `preempt.c` ends in a halt loop and `kernel.c`
returns to the firmware -- so a boot spends the whole 60 s budget only when its
markers do not appear.

`--arch <x64|aarch64|native>` narrows the run to one architecture's boots;
every kernel is still built for both, each build costing a fraction of a
second.
The local gate runs both architectures on each Linux lane and does not use the
filter.

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

Both targets are complete and the smoke boots them: the serial output shows the
three threads round-robin under the timer, then `efi_main` resumes after the
scheduler stops and prints `BADC-PREEMPT-OK`.

* **x86_64** reprograms the 8259 PIC + 8254 PIT and installs an IDT; the naked
  ISR saves the registers, `call`s the C scheduler, restores, and `iretq`s. It
  exercises naked prologue suppression, explicit-register operands, `push`/`pop`,
  immediate port I/O, and a direct `call` to a C symbol.
* **AArch64** programs the GICv2 + the virtual generic timer and installs an EL1
  vector table. UEFI maps loaded data execute-never, so the table lives in a
  page of `EfiLoaderCode` obtained from `BootServices->AllocatePages`; the naked
  ISR reaches the scheduler through `TPIDR_EL1` and a `blr` (AArch64 inline asm
  has no symbol references), saves the full integer context with `stp`, and
  returns through `eret`.

On x86_64 every vector the demo does not install gets a diagnostic gate: a
16-byte stub pushes its vector number and jumps to a common handler that prints
the vector, the error code where the CPU pushed one, and the faulting RIP, then
halts. Without them an unexpected exception escalates to a triple fault, which
resets the guest with nothing on the serial line. Building with
`-DPREEMPT_FAULT_INJECT` raises `#GP` right after the IDT is installed, which is
how the smoke checks the diagnostic.

Both `arch_start_scheduler` implementations mask interrupts before they touch
the vector table. UEFI enters an application with interrupts enabled and the
firmware's own timer running -- on x86_64 that is IRQ0 through the 8259, whose
initialization sequence clears the master's vector base and mask until ICW2
arrives, so an IRQ0 taken in that six-instruction window arrives at vector 0
and lands on the demo's unhandled-fault gate. Building with
`-DPREEMPT_PIC_WINDOW_STRESS` holds the window open past a firmware timer
period, which turns that race into a certainty; the smoke boots it and
requires the normal markers.

On AArch64 the mask follows the `AllocatePages` call for the vector page:
the boot service returns with IRQ unmasked, so a mask taken before it does
not hold. The firmware's tick is the virtual timer's own interrupt, every
10 ms under QEMU's edk2, and one taken between the `VBAR_EL1` and
`TPIDR_EL1` writes enters the ISR before the scheduler pointer it loads is
set; the ISR faults with IRQ masked and the guest prints nothing after its
first line. `-DPREEMPT_VBAR_WINDOW_STRESS` holds that window open for 40 ms,
and the smoke boots it the same way.

### Atomics under preemption

The threads exercise C11 atomics, and `efi_main` checks them once the
scheduler has stopped every thread:

* **A shared counter.** Each thread increments an `_Atomic unsigned` with `++`
  in its busy loop: `lock xadd` on x86_64, `ldaddal` on AArch64. Each thread
  also stores its own count in a slot. Around the increment and that store it
  raises an in-flight flag. A thread the last tick stops inside that bracket
  may count in the total but not yet in its slot. So, with S the total, C the
  sum of the slots and F the raised flags, `C <= S <= C + F` holds however the
  ticks fell. The line `BADC-PREEMPT: shared=S counted=C inflight=F` reports the
  three, and `BADC-PREEMPT: atomic counter ok` follows when the bracket holds.
  A lost update leaves S below C.
* **A record with a lock word.** Every sixteenth iteration a thread stores an
  `_Atomic struct { unsigned turn, id, check; }` whole, with `check` computed
  from the other two fields, and reads it back. On these PE targets the 12-byte
  object carries the 4-byte lock word MSVC lays out, and badc spins on it:
  `xchg` on x86_64, `swpa` on AArch64. A thread preempted while holding the
  lock makes the others spin until it runs again. `BADC-PREEMPT: snapshot
  reads=R torn=T` reports the reads, and `BADC-PREEMPT: atomic snapshot ok`
  follows when no read was torn. The timer ISR never touches the record,
  because it cannot wait for a lock held by the thread it interrupted.
  `efi_main` never touches it either, because a thread stopped while holding
  the lock never releases it.
* **The C11 spellings.** The print lock is an `atomic_flag`, taken with
  `atomic_flag_test_and_set_explicit(..., memory_order_acquire)` and released
  with `atomic_flag_clear_explicit(..., memory_order_release)`. The tick count
  and the done flag are `_Atomic`: the ISR stores them with release order, and
  `efi_main` loads the flag with acquire order.

The smoke requires both `ok` markers in every lane that boots to the end.
`-DPREEMPT_PLAIN_COUNTER` makes the increment a plain load, call and store.
That build reports S far below C. QEMU's TCG, which the smoke runs, takes an
interrupt only between translation blocks, and the call ends one; a plain `++`
compiled to a straight load, add and store is never split under TCG.

All addresses and saved stack pointers use the pointer-width `UINTN`
(`unsigned long long`), not `unsigned long`, because the EFI targets are LLP64
(`long` is 32-bit); a 32-bit IDT base or saved SP would fault on the first
tick.
