# qemu demo

Builds the [QEMU](https://www.qemu.org/) 11.0.2 system emulator with badc and
runs the result -- with badc's own linker, no system linker in the chain. badc
self-compiles and self-links both `qemu-system-aarch64` and `qemu-system-x86_64`,
end to end: it compiles every unit, its own linker lays out the emulator, and
each boots a Linux kernel plus a busybox initramfs to an interactive userspace
shell that powers off cleanly under TCG. Both boot the EFI-stub kernel *through*
UEFI firmware -- OVMF on x86_64, ArmVirtQemu/AAVMF on aarch64 (with `acpi=off` so
the kernel probes the PL011 as `ttyAMA0`, plus `earlycon` for early-boot output).
CI builds that firmware with badc too -- the `edk2` demo's
`build_badc_selfhost.py`, assembling the x86 firmware with a badc-built nasm --
so the gated boot runs a badc-built emulator on badc-built firmware end to end.

QEMU is a large, portable C program: this demo compiles well over a thousand
translation units per target with badc -- for aarch64, **1683 units** (1140
emulator objects plus the 543 objects of its utility library); the x86_64
emulator is a comparable **1466 units** -- covering device models, the TCG code
generator, the block layer, QAPI-generated marshalling, and the
character/network back ends. It is the widest single exercise of badc's C front
end and object emitter in the demo set.

## Run

```sh
cargo build --release --features full          # build badc
python3 demos/qemu/setup.py                     # fetch the source + build config
python3 demos/qemu/smoke.py                      # build with badc + run
```

## How it builds (no `meson`, no `make`)

QEMU's build is driven by meson, which detects host capabilities and generates
a large tree of headers and sources (QAPI marshallers, trace points, the
decodetree output, config headers). That tree is not reproducible off-box
without re-running meson, so the vendored asset captures it: for each target a
`compile_commands.json`, the linker response files (`qemu-system-<arch>.rsp`,
`libqemuutil.a.rsp`), and every generated header/source. The vendored QEMU
source is trimmed of the git history, test suite, docs, ROM/firmware blobs, and
meson subprojects -- none are compile inputs for the emulator.

The smoke reads the response files for the object list and
`compile_commands.json` for each unit's flags, rewrites the gcc flag set to
badc's, and substitutes the host glib include path via `pkg-config`. It then
compiles every unit with badc and archives the utility library with badc's
`--ar`.

badc has no `<arm_neon.h>`, so the handful of crypto units that would use it are
retried with QEMU's portable scalar path selected instead of the
host-accelerated one (QEMU ships both; the choice is an include-order matter).
The result is a fully badc-compiled object set.

## Linking

The demo does a **pure badc self-link**: badc's own linker lays out the final
image over the 100%-badc object set, producing `qemu-system-<arch>` directly --
no system linker anywhere in the chain. A self-link failure fails the demo, so
full self-containment is a hard gate.

The emulator resolves its remaining externals (glib, zlib, libfdt, libc) against
the system shared libraries.

## What the smoke checks

- badc compiles every translation unit of the target (a compile failure fails
  the demo);
- badc archives the utility library with `--ar`;
- badc's own linker self-links the emulator and it reports `QEMU emulator
  version 11.0.2`.

`$BADC_QEMU_OPT=1` also runs the `-O` lane; `$BADC_QEMU_JOBS` sets the compile
parallelism.

## Boot check

The smoke can boot the emulator it just built on a real kernel and require a
full round trip: the kernel boots, reaches its init process / a busybox shell,
faults nowhere, and the guest powers the machine off on request. The gate is
the serial log showing a boot marker (`Linux version` / `Booting Linux`) and
userspace (`Run /sbin/init`), no fault marker (`Kernel panic`, `Unable to
handle`, `Oops`, ...), and a clean power-down (the smoke sends `poweroff -f`
over the console and the guest exits rc 0). The boot runs with `-smp 16`,
`-nographic`, a 60s timeout, and `-no-reboot`. aarch64 `-M virt` and x86_64
`-M q35` boot the EFI-stub kernel through UEFI firmware when one is configured --
AAVMF (aarch64, with `acpi=off` so the PL011 probes as `ttyAMA0`) and OVMF
(x86_64) -- matching a real UEFI system; without a configured firmware aarch64
falls back to `-M virt`'s legacy `-kernel` loader.

`$BADC_QEMU_BOOT` drives it:

- unset -- boot only if a kernel is already available (`$BADC_QEMU_KERNEL`, or a
  bundle already fetched into `.cache`); otherwise skip. A plain smoke run stays
  green; a pre-fetched bundle gates.
- `gate` -- fetch the published kernel bundle for the host arch, boot, and gate
  on the full round trip.
- `best-effort` -- fetch + boot, but a boot failure is logged, not fatal (for a
  host too slow under TCG within the timeout).
- `skip` -- do not boot.

Each per-arch kernel bundle is a vendor-deps release asset fetched + sha256-
verified by `setup.py --kernel` the same way the source is. The arm64 bundle
holds a raw `Image`, a busybox `initramfs.cpio.gz`, and the kernel `config`; the
x86_64 bundle holds an EFI-stub `bzImage` with the initramfs embedded, plus its
`config`. Point `$BADC_QEMU_KERNEL` / `$BADC_QEMU_INITRD` at your own images to
boot those instead; `$BADC_QEMU_APPEND` overrides the kernel command line,
`$BADC_QEMU_BOOT_TIMEOUT` the timeout. `$BADC_QEMU_OVMF_CODE` /
`$BADC_QEMU_OVMF_VARS` (x86_64) and `$BADC_QEMU_AAVMF_CODE` /
`$BADC_QEMU_AAVMF_VARS` (aarch64) point at the firmware images -- set in CI to
the ovmf lane's badc-built firmware.

## Scope

The vendored build config is per target; both the **aarch64 Linux** and
**x86_64 Linux** configs are captured in-repo and validated end to end -- build,
self-link, and boot. The config carries the lean feature set badc's toolchain
supports (host SIMD intrinsics, native `__int128` and its 128-bit CAS, and
elfutils are off, matching what a badc-configured meson would emit; see
`adapt_config` in `smoke.py`). The x86_64 emulator additionally links its
vhost-user / vduse subproject libraries, compiled from source, and boots through
OVMF with the q35 option ROMs shipped in the kernel bundle. The macOS config is
not yet vendored (TODO). On a host without a captured config the smoke skips
cleanly.

## Requirements

`python3`, badc, `pkg-config` with the glib-2.0 development package
(Debian/Ubuntu: `libglib2.0-dev`), and the zlib and libfdt shared libraries
(`zlib1g-dev`, `libfdt-dev`). The x86_64 boot check also needs system OVMF
(Debian/Ubuntu: `ovmf`; Fedora: `edk2-ovmf`). No `meson`, no `make`, no
`./configure`, and no system linker.
