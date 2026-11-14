# The Linux kernel

badc compiles every C translation unit of a Linux 7.2.9 `defconfig` kernel on
x86_64 and aarch64, links the kernel, and the result boots. The harness is
[`demos/linux/`](../demos/linux/). Its [README](../demos/linux/README.md)
documents every script, flag, and pin, and records the measurements this page
does not repeat.

## Contents

- [What holds today](#what-holds-today)
  - [Compile](#compile)
  - [Boot](#boot)
  - [Nested KVM](#nested-kvm)
  - [Relocated output](#relocated-output)
  - [Link](#link)
  - [Assembly](#assembly)
  - [Distribution packages](#distribution-packages)
  - [Real hardware](#real-hardware)
  - [Exercising the booted kernel](#exercising-the-booted-kernel)
  - [Self-host](#self-host)
- [What is not badc's](#what-is-not-badcs)
- [What the objects have to survive](#what-the-objects-have-to-survive)
- [Where the numbers come from](#where-the-numbers-come-from)

## What holds today

The pre-push gate (`scripts/validate_local_boxes.py`) and CI's `kernel` job
build, link, and boot `defconfig` on both architectures with
`demos/linux/verify.py`. The gate's log at d5a973207 reads:

| | x86_64 | aarch64 |
|---|---|---|
| C units compiled by badc | 2942 | 4283 |
| units left to another compiler | 0 | 0 |
| links made by badc / left to GNU ld | 11 / 0 | 9 / 0 |
| boots passing every check | 4 of 4, at displacements the machine drew | 4 of 4, at 4 displacements the gate chose |
| 250 MB zstd initramfs unpack | 2.74 s, reported only | 2.05 s, bound 7.5 s |

### Compile

Every kernel C unit of the architecture's own `defconfig` is compiled by badc.
`buildcc.py`, the `CC=` shim, sends each one to badc and to nothing else. When
badc cannot compile a unit, the shim removes the partial object and exits
nonzero, so the build stops there. The one route to another compiler is
`$BADC_FALLBACK`, which names units explicitly and records each as `fallback`
in the manifest. `verify.py` fails when that count is nonzero. The manifest has
one line per kernel unit, and the gate fails a build that compiled fewer badc
units than the floor: 2920 on x86_64 and 4250 on aarch64.

### Boot

Both kernels boot under qemu, and the check goes past reaching userspace. The
initramfs `/init` prints a marker, then mounts procfs and sysfs and checks the
contents of a fixed set of files. It reads each in 64-byte requests and once
more from a non-zero offset, which catches a seq_file that replays records
instead of continuing. It then resolves `clock_gettime` in the vDSO the way a
loader does, through `PT_DYNAMIC`, the hash tables, and the symbol versions,
and calls it. Only when every check passes does it print the second marker.

Each boot's `Linux version` banner, the text `/proc/version` serves, must name
badc as the compiler, and the linker identification that follows must match
the linker the run chose.

One more boot carries the marker archive followed by 250 MB compressed with
the method the configuration decompresses, zstd at `defconfig`. The time the
kernel spends unpacking it is read from the console's timestamps. On aarch64
it is held to a bound, 7.5 s; x86_64 has no measured bound yet and is
reported only. The marker image alone unpacks in a fraction of a second, too
little for a decompressor regression to show.

### Nested KVM

`verify.py --nested-kvm`, or `scripts/validate_local_boxes.py --nested-kvm`,
adds one boot under the host's KVM with the host's CPU model. The badc kernel
is then the hypervisor. Its initramfs carries:

- the badc-built qemu the qemu demo produces, with its libraries and ROM set;
- the KVM modules of this build;
- the kernel image itself and the marker initramfs.

`/init` loads the modules, reports the virtualization extension
`/proc/cpuinfo` lists and whether `/dev/kvm` opened, and runs the emulator on
the same image under the kernel's own KVM. The guest's console arrives between
bracket lines on the outer one, and both boots are held to the marker checks.
The step is skipped, not passed, where the host, the emulator, or the CPU model
offers no nesting; the aarch64 validation host's KVM offers none. x86_64
`defconfig` builds no KVM, so with `--nested-kvm` the build makes it as
modules.

### Relocated output

The aarch64 gate boots at displacements it chooses. It writes a KASLR seed
into the machine's own device tree and boots against the result: three fixed
seeds and one drawn per run. x86_64 derives its displacement from RDRAND, the
TSC, and the i8254 counter, so nothing there can be pinned, and those boots run
at the displacement the machine draws. A displacement probe runs first, and the
gate fails if a randomizing configuration produced no displaced boot.

### Link

With `LD=` set to `ldshim.py`, badc links the kernel through kbuild's own
`link-vmlinux.sh` on both architectures, and those kernels boot. Nothing is
left to GNU ld:

- the `-r` merges and every `vmlinux` kallsyms pass;
- the x86 boot decompressor;
- all three vDSOs;
- the `-m elf_i386` boot links (`arch/x86/boot/setup.elf`,
  `arch/x86/realmode/rm/realmode.elf`, `vdso32`);
- kbuild's scriptless probes.

badc's `--version` prints `GNU ld (badc <version>) 2.33.1`.
`scripts/ld-version.sh` reads that as a BFD linker at binutils 2.33.1, the
level at which `arch/arm64/Kconfig` enables `ARM64_PTR_AUTH_KERNEL`. It is no
higher, so nothing gated on a newer linker is claimed.

The i386 links read ELF32 `EM_386` objects, whose `SHT_REL` relocations keep
the addend in the field being relocated. The reader takes each implicit addend
from the input bytes at the field's width, so one relocation engine covers both
formats. The writer emits the ELF32 records: `Elf32_Ehdr`/`Phdr`/`Shdr`,
16-byte `Elf32_Sym`, 8-byte `.dynamic` entries, and 32-bit `.gnu.hash` Bloom
words. `--emit-relocs` writes the target's own format, so `realmode.elf`
carries the `.rel.<section>` tables `arch/x86/tools/relocs` reads.

The vDSOs are shared objects, so badc writes the metadata a loader searches:
`.dynsym` / `.dynstr`, `.hash`, and `.gnu.hash` per `--hash-style`,
`.gnu.version` / `.gnu.version_d` for the version the symbols are exported
under, a `.dynamic` with `DT_SONAME`, the table addresses, and the relocation
tags, and `PT_DYNAMIC`. A link with no `-T` runs under a built-in default
script per output kind, as GNU ld falls back on its internal one.
`scripts/tools-support-relr.sh` is such a link.

### Assembly

`badc -c foo.S -o foo.o` assembles a unit. kbuild compiles `.S` through
`$(CC)`, so `buildcc.py` sends each kernel assembly unit to badc as well. A
unit badc cannot assemble goes to gas and is recorded as `gas` in the
manifest, with badc's diagnostic. `verify.py` reports the badc and gas counts
and gates neither.

An assembly unit built `-m16` or `-m32` becomes an ELFCLASS32 / `EM_386`
object: `Elf32_Ehdr` / `Shdr` / `Sym` widths, `SHT_REL` tables named
`.rel<section>` whose addends sit in the patched field, and the `R_386_*`
numbering. The class also sets the starting code mode, as `as --32` does for
either spelling; `.code16` and `.code32` change it from there. badc generates
no i386 code, so a C source under either flag is refused.

The assembler tests compare badc's encodings with GNU as 2.46.1's for the same
source. On x86-64 a branch to a label takes the 8-bit displacement where it
reaches, as GNU as relaxes it.

### Distribution packages

`packages.py` packages the kernel as a `.deb` or `.rpm` with the kernel's own
`bindeb-pkg` / `binrpm-pkg` targets. It installs the package into a stock
Debian 13, Ubuntu 26.04 or Fedora 44 cloud image under qemu and reboots into
systemd multi-user, with udev-bound devices and modules loading on demand.
`/proc/version` must name badc. The run checks for an untainted kernel, a
clean dmesg, and disk and network I/O, against a baseline taken from the
image's stock kernel in the same userspace.

The system disk and the NIC use the models the run selects: the paravirtual
pair by default, or an emulated NVMe, AHCI, or SCSI controller and an e1000e or
rtl8139-class NIC. The run fails unless the booted kernel drives the root disk
and the NIC with those models' drivers. The guest boots under EFI firmware
where the host has it, OVMF on x86_64 `q35` and AAVMF on aarch64 `virt`.
`--vm-firmware` selects it; without EFI firmware, x86_64 falls back to SeaBIOS.

The configuration is the distribution's, not `defconfig`: each pinned cloud
image's own `/boot/config-$(uname -r)`, mirrored on the `vendor-deps` release
under a pinned sha256 (`packages.py --config vendor`). A package build reads it
without booting anything. Such a configuration compiles several times
`defconfig`'s units. `.github/workflows/kernel-packages.yml` builds the
Ubuntu and Fedora configurations on both architectures, with every unit and
link badc's.

### Real hardware

`packages.py --phases hw` runs the same install, one-shot boot selection,
boot, probes, and exercise stage on a physical machine instead of a guest. The
run reaches the machine over ssh and reads its console from a serial port on
the host, byte for byte, so the same scanners judge both. The drivers that
must bind come from the machine's own baseline rather than from an emulated
model. The machine's identity (board, BIOS, CPU, firmware mode) is recorded
next to the verdict, so a hardware run can be compared with a VM run.

A machine with no remote power cut recovers only through its standing boot
default and its watchdog. The run therefore refuses to start unless that
default is a distribution kernel, selects the kernel under test for exactly
one boot, and after a boot that does not answer reports the stage the console
reached and waits for the machine to fall back. It is not in CI: it needs a
bench machine.

Two bench setups are documented, and they differ in what a failure leaves
behind:

- With a serial port, a kernel that dies before userspace is still readable,
  and `earlycon` covers the window from firmware handoff onward:
  [../demos/linux/micropc-testing.md](../demos/linux/micropc-testing.md).
- Without a serial port or a display, nothing is observable until the network
  driver probes. The console is netconsole over UDP, the post-mortem is
  `efi_pstore` read back on the next boot, and recovery rests on the one-shot
  boot selection and a bounded `panic=`. That setup and its four rollback
  layers are in
  [../demos/linux/xps8930-testing.md](../demos/linux/xps8930-testing.md).

### Exercising the booted kernel

A boot reaches a few dozen of the thousands of modules a distribution kernel
ships. Reaching userspace also says little about whether the kernel computes
correct results: a cipher that returns wrong ciphertext leaves the taint word
at 0, logs nothing, and lets systemd come up. A stage inside the booted badc
kernel therefore drives the rest. Its cheap part runs on every boot:

- socket families, each created, bound and, where a local transfer is
  possible, carrying data;
- a storage write and read-back against the source digest;
- the crypto check described below;
- the kunit suites, where the configuration builds them;
- a dmesg scan that fails on anything a driver reports at `KERN_ERR` or worse.

`--exercise` adds the two expensive steps, loading every module one by one and
the filesystem matrix. `--no-exercise-gate` drops the stage.

The socket step binds, listens, and reads back, because `socket()` succeeding
is not enough. A kernel whose `bind(AF_VSOCK, ...)` always failed passed every
passive check on a distribution whose init does not use that family.

Every crypto implementation the kernel registers is checked through AF_ALG by
its driver name, so an architecture-optimized path is checked on its own. The
reference is Python's `hashlib` where it implements the algorithm, and
otherwise the generic implementation registered under the same name. Where the
configuration keeps `CONFIG_CRYPTO_SELFTESTS`, the registration self-tests and
a `tcrypt` mode sweep run as well.

The module step loads every built module once and classifies the outcome.
Absent hardware is counted apart from a fault, a hang, a missing symbol, or an
oops taint bit.

The filesystem step builds filesystems on loop devices over sparse files, at
512- and 4096-byte logical block sizes, and runs parallel write, churn,
tree-copy, and `O_DIRECT` jobs on them. File contents are then checked against
digests computed from a seed held in tmpfs, after dropping the caches and
remounting, and each instance ends with its own check-only fsck. The matrix
includes checksum-heavy configurations: btrfs with crc32c, xxhash, sha256, and
blake2, btrfs with zstd compression, ext4 and xfs with metadata checksums,
LUKS2 dm-crypt, and md raid1. They route file data through the kernel's crypto
and compression code, where a miscompile shows up as corrupted data rather
than as a dmesg line.

### Self-host

The optional `selfhost` phase makes the installed kernel a build host: inside
the VM running the badc kernel, badc builds the kernel again. Everything the
build needs is staged before the reboot, so it runs with no network. The phase
measures the kernel, not the compiler:

- the kernel log window between `/dev/kmsg` markers, taint, OOM records, and
  core dumps;
- the in-guest unit outcomes against the host build's, for the units both
  reached;
- a sample of the objects, rebuilt and required to repeat byte for byte.

It is off by default; `--selfhost-scope` sizes it.

## What is not badc's

The shim sends only kernel compiles to badc. Configuration probes
(`cc-option` and the like), `-E`, `-S`, and the host tools under `scripts/`
and `tools/` go to the reference compiler, so the configuration and the object
population match the gcc build the corpus was captured from.

The build records badc's identification in `CONFIG_CC_VERSION_TEXT`, which the
boot banner prints. `scripts/cc-version.sh` still classifies the reference
compiler, so `CONFIG_GCC_VERSION` keeps the reference toolchain's value. badc
claims `__GNUC__` 4.3.0, below the kernel's gcc floor (8.1.0).

## What the objects have to survive

Compiling is not the test; the kernel's own build and boot are. On x86_64,
with `CONFIG_OBJTOOL=y`, kbuild runs objtool (`--orc`, jump-label and
static-call rewriting) over every object. The vmlinux linker script asserts an
empty `.got`, so badc's `GOTPCRELX` relocations must relax. The boot exercises
the metadata sections the kernel's asm emits (`__jump_table`,
`.altinstructions`, `__ex_table`, `.smp_locks`).

Kernel objects also constrain code generation, and the shim forwards the flags
that express it:

- `-mno-sse` and `-mgeneral-regs-only`: a kernel object must keep off the
  FP/SIMD registers, which the kernel runs with trapped and whose callers do
  not maintain the System V `al` convention.
- `-mstrict-align`, for early-boot units that run with the MMU off.
- `-fPIC` / `-fpic` / `-fPIE` / `-fpie`, for the EFI stub and the boot
  decompressor, which reject absolute relocations. Those units take badc's
  position-independent object form. Every other unit keeps the absolute form
  whose relocations the ORC pass reads.
- The ftrace patch sites. `-fpatchable-function-entry=N,M` gives every function
  its NOP area, aligned as the function is, and a `__patchable_function_entries`
  record linked to the function's text section. On x86_64,
  `-pg -mfentry -mrecord-mcount` gives it the `call __fentry__` at the symbol
  and the `__mcount_loc` entry, as gcc emits them.
- Every `-ffixed-REG` as written: `-ffixed-x18` for the aarch64 shadow call
  stack, and `-ffixed-q16` .. `-ffixed-q31` for a NEON unit that keeps state in
  those registers. badc keeps the register out of its allocator and its own
  scratch choices, and fails the unit on a name it cannot honor.
- `-Wframe-larger-than=`, the bound `CONFIG_FRAME_WARN` sets, so a function
  whose frame threatens the kernel stack is reported at the unit that defines
  it.

A flag badc does not implement is reported as `not applied` on each unit that
carries it; on the pinned `defconfig` that is `-fasynchronous-unwind-tables`.
A flag the shim has not classified fails the unit.

## Where the numbers come from

`sweep.py` is the measurement. It replays every C compile of a completed gcc
reference build against badc and groups the failures by normalized error
signature, producing a ranked work list. It gates nothing.

`verify.py` is the gate. It builds with no fallback list, links and boots, and
fails on:

- any unit badc could not compile, any unit that fell back, and any source
  missing when its compile ran;
- fewer badc units than `--expect-units` (make skips current objects, so
  without a floor a tree that rebuilt nothing would pass);
- any undefined reference;
- with `--linker badc`, any link left to GNU ld, failed or fallen back;
- on x86_64, any objtool report that the frame state it derived is
  inconsistent;
- a linked image whose largest function, or count of functions over 4 KiB,
  exceeds the architecture's budget;
- any boot that misses either marker, any banner that does not name badc, and
  an unpack boot over its bound.

The kernel decides what its code may use by probing the compiler at configure
time, so a corpus captured from a gcc build carries gcc's answers.
`probecfg.py` re-runs the kernel's configuration step with badc as the probe
compiler, so a replayed measurement can reflect badc instead.

CI runs `verify.py` on every pull request and every push to `master`, for both
architectures, under the emulator the qemu job compiled and linked with badc.
`.github/workflows/kernel-packages.yml` runs the packaging and install path on
demand and on a pull request labeled `kernel-packages`. It is off the push
path because a distribution configuration is a full kernel and GitHub-hosted
runners expose no `/dev/kvm`, so the VM runs under TCG. It has no schedule:
the corpus is pinned, and a repeat run repeats the previous run's work.
