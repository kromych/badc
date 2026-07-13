# qemu demo

Builds the [QEMU](https://www.qemu.org/) 11.0.2 system emulator
(`qemu-system-aarch64`) with badc and runs the result.

QEMU is a large, portable C program: this demo compiles **1683 translation
units** with badc -- the 1140 emulator objects plus the 543 objects of its
utility library -- covering device models, the TCG code generator, the block
layer, QAPI-generated marshalling, and the character/network back ends. It is
the widest single exercise of badc's C front end and object emitter in the demo
set.

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

The demo prefers a **pure badc self-link**: badc's own linker over the 100%
badc object set produces `qemu-system-aarch64` directly. Where badc's linker
does not yet support an aarch64 reloc type emitted by this input (TODO), the
demo falls back to linking badc's objects with the system linker (`cc`) so the
emulator is still produced -- every object is badc's, and `cc` only relocates
and lays out. Either way the smoke's gate is the same: badc compiled every unit,
and the linked emulator reports its version.

The emulator resolves its remaining externals (glib, zlib, libfdt, libc) against
the system shared libraries.

## What the smoke checks

- badc compiles all 1683 translation units (a compile failure fails the demo);
- badc archives the utility library with `--ar`;
- the linked `qemu-system-aarch64` reports `QEMU emulator version 11.0.2`.

`$BADC_QEMU_OPT=1` also runs the `-O` lane; `$BADC_QEMU_JOBS` sets the compile
parallelism.

## Boot check

The smoke can boot the emulator it just built on a real kernel and require a
full round trip: the kernel boots, reaches its init process / a busybox shell,
faults nowhere, and the guest powers the machine off on request. The gate is
the serial log showing a boot marker (`Linux version` / `Booting Linux`) and
userspace (`Run /sbin/init`), no fault marker (`Kernel panic`, `Unable to
handle`, `Oops`, ...), and a clean power-down (the smoke sends `poweroff -f`
over the console and the guest exits rc 0). The boot runs with `-smp 4`,
`-nographic`, a 60s timeout, and `-no-reboot`.

`$BADC_QEMU_BOOT` drives it:

- unset -- boot only if a kernel is already available (`$BADC_QEMU_KERNEL`, or a
  bundle already fetched into `.cache`); otherwise skip. A plain smoke run stays
  green; a pre-fetched bundle gates.
- `gate` -- fetch the published kernel bundle for the host arch, boot, and gate
  on the full round trip.
- `best-effort` -- fetch + boot, but a boot failure is logged, not fatal (for a
  host too slow under TCG within the timeout).
- `skip` -- do not boot.

The kernel bundle (arm64 only) is a vendor-deps release asset fetched + sha256-
verified by `setup.py --kernel` the same way the source is; it holds the kernel
`Image`, a busybox `initramfs.cpio.gz`, and the kernel `config`. Point
`$BADC_QEMU_KERNEL` / `$BADC_QEMU_INITRD` at your own images to boot those
instead; `$BADC_QEMU_APPEND` overrides the kernel command line,
`$BADC_QEMU_BOOT_TIMEOUT` the timeout.

## Scope

The vendored build config is per target. The **aarch64 Linux** config is
captured and validated. The x86_64 Linux and macOS configs are not yet vendored
(TODO); on a host without a captured config the smoke skips cleanly.

## Requirements

`python3`, badc, `pkg-config` with the glib-2.0 development package
(Debian/Ubuntu: `libglib2.0-dev`), the zlib and libfdt shared libraries
(`zlib1g-dev`, `libfdt-dev`), and a system `cc` for the hybrid link fallback.
No `meson`, no `make`, no `./configure`.
