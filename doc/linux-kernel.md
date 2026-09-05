# The Linux kernel

badc compiles every C translation unit of a Linux 7.1.10 `defconfig` kernel on
x86_64 and aarch64, links it, and the result boots. The harness is
[`demos/linux/`](../demos/linux/), whose
[README](../demos/linux/README.md) documents every script, flag and pin.

## What holds today

**Compile.** Every kernel C unit of the architecture's own `defconfig` is
badc's, with zero fallbacks to another compiler. Two unit counts circulate at
the 7.1.10 pin, and they differ only in which make targets were built:

| build | x86_64 | aarch64 | measured by |
|---|---|---|---|
| kernel image (`bzImage` / `Image`, vmlinux included, no modules) | 2921 | 4434 | `verify.py` |
| kernel plus modules (` ... modules`) | 2953 | 10489 | `packages.py` |

Both come from the same counter -- one manifest line per successful badc
compile of a kernel C unit -- so the deltas are exactly the module corpus.
x86_64 `defconfig` builds virtio, ext4 and most of the rest `=y` and aarch64
builds them `=m`, which is why the aarch64 count more than doubles while the
x86_64 count moves by 32.

A C unit badc cannot compile fails the build rather than being handed to gcc:
`buildcc.py`, the `CC=` shim, removes the partial object and exits nonzero. The
one route to another compiler is `$BADC_FALLBACK`, which names units explicitly
and marks the build impure in the manifest; the gate fails when that count is
nonzero. Assembly units take the same route and no longer use it either.

**Boot.** Both kernels boot under qemu, checked by more than reaching
userspace. The initramfs `/init` prints a marker, then mounts procfs and sysfs
and asserts the contents of a fixed set of files, reading them in 64-byte
requests and once more from a non-zero offset, so a seq_file that replays
records rather than continuing is caught. Only then does it print the second
marker. Each boot's `Linux version` banner -- the text `/proc/version` serves
-- must name badc, which pins the claim in the booted kernel rather than in the
configuration. One more boot carries the marker archive followed by 250 MB
compressed with the method the configuration decompresses -- zstd at
defconfig -- and the time the kernel spends unpacking it, read from the
console's timestamps, is held to a bound: the marker image unpacks in a
fraction of a second, too little for a decompressor regression to show.

**Relocated output.** The aarch64 gate boots at pinned KASLR displacements: it
writes seeds into the machine's own device tree and boots against the result,
covering a fixed set of displacements plus one drawn per run. x86_64 derives
its displacement from RDRAND, the TSC and the i8254 counter, so nothing there
can be pinned and those boots run unpinned. A displacement probe runs first
and the gate fails if a randomizing configuration produced no displaced boot.

**Modules.** All `defconfig` modules build and load, with per-module verdicts
identical to a gcc-built kernel.

**Link.** `LD=badc` links the kernel through kbuild's own `link-vmlinux.sh` on
both architectures, and those kernels boot. kallsyms converges in two passes.
On x86 the KASLR relocation table built from badc's `--emit-relocs` output is
byte-identical to GNU ld's. badc's `--version` reports
`GNU ld (badc <version>) 2.30`, which `scripts/ld-version.sh` reads as a BFD
linker at the kernel's own floor and deliberately no higher.

Every link is badc's and only badc's: the `-r` merges, every `vmlinux` kallsyms
pass, the x86 boot decompressor, all three vDSOs, the `-m elf_i386` boot links
(`arch/x86/boot/setup.elf`, `arch/x86/realmode/rm/realmode.elf`, `vdso32`) and
the scriptless probes. `LD=badc` leaves nothing to GNU ld.

The i386 links read ELF32 `EM_386` relocatables whose relocations are `SHT_REL`
-- the addend lives in the field being relocated rather than in the relocation
record -- and write an ELF32 image. The reader materializes each implicit
addend from the input bytes at the field's own width, so the same relocation
engine covers both formats; the writer emits `Elf32_Ehdr`/`Phdr`/`Shdr`,
16-byte `Elf32_Sym`, 8-byte `.dynamic` entries and 32-bit `.gnu.hash` Bloom
words. `--emit-relocs` writes back in the target's own format, so
`realmode.elf` carries `.rel.<section>` for `arch/x86/tools/relocs` to read.

The vDSOs are shared objects, so badc emits the dynamic-linking metadata a
loader searches -- `.dynsym`/`.dynstr`, `.hash` and `.gnu.hash` per
`--hash-style`, `.gnu.version`/`.gnu.version_d` for the version the symbols are
exported under, and a `.dynamic` with `DT_SONAME`, the table addresses and the
REL/RELA/RELR tags -- plus `PT_DYNAMIC`. A link with no `-T` runs under a
built-in default script per output kind, as GNU ld falls back on its internal
one, which is what `scripts/tools-support-relr.sh` probes with.

**Assembly.** All of it, now. `badc -c foo.S -o foo.o` assembles a unit
directly, and kbuild routes `.S` through `$(CC)`, so `buildcc.py` decides each
assembly unit the same way it decides a C one. Over the four 7.1.10
distribution configurations gas assembles nothing:

| package | configuration | assembly units | badc | gas |
|---|---|---|---|---|
| rpm, x86_64 | Fedora 44 | 141 | 141 | 0 |
| rpm, aarch64 | Fedora 44 | 103 | 103 | 0 |
| deb, x86_64 | Ubuntu 26.04 | 129 | 129 | 0 |
| deb, aarch64 | Ubuntu 26.04 | 94 | 94 | 0 |

measured with the fallback lists empty, so no unit was permitted to fall back.
The last two holdouts were the GFNI affine instructions the three ARIA ciphers
spell, and on aarch64 a lane-indexed register list, the widening multiply by
element and the narrowing shift right, which one crypto unit needed together.

An assembly unit built `-m16` or `-m32` gets an ELFCLASS32 / EM_386 object:
`Elf32_Ehdr` / `Shdr` / `Sym` widths, `SHT_REL` tables named `.rel<section>`
whose addends ride in the field each relocation patches, and the `R_386_*`
numbering. The class also picks the assembler's starting code mode, the way
`as --32` does for either spelling; `.code16` / `.code32` move it from there.
badc generates no i386 machine code, so a C source under either is refused by
name and only the assembler reaches the 32-bit container.

Assembling is not only accepted but agreed on. Against GNU as 2.46.1's object
for the same source, byte for byte over every allocatable section plus the
symbol table and the relocations, **all 72** of the `.S`-derived objects the
7.1.10 `defconfig` builds under `arch/arm64/` and `lib/crypto/arm64/` are
identical, setting aside the DWARF badc emits none of for an assembled unit
and the AArch64 `$x` / `$d` mapping symbols. The last object to differ did so
by a single padding word, because a literal pool was keyed by section where
GNU as keys it by section and subsection.

One class of difference remains on x86_64: a branch to a named label in the
same section always takes the wide displacement, where GNU as relaxes it to
`rel8`. The bytes execute the same; the sections are longer.

**Distribution.** The kernel packages as a `.deb` and an `.rpm` with the
kernel's own `bindeb-pkg` / `binrpm-pkg` targets, installs into stock Debian
13, Ubuntu 26.04 and Fedora 44 cloud images under qemu, and reboots into
systemd multi-user with udev-bound devices and modules autoloading on demand.
The system disk and the NIC ride on the storage controller and NIC model the
run selects -- the paravirtual pair by default, or an emulated NVMe, AHCI or
SCSI controller with an e1000e / rtl8139-class NIC, whose drivers the booted
kernel then has to bring up -- and the run asserts the booted kernel drives
the root disk and the NIC with those models' drivers. The guests boot under
EFI firmware -- OVMF on x86_64 q35, AAVMF on aarch64 virt -- which is what
the machines these packages target boot with; `--vm-firmware` selects it and
falls back to SeaBIOS on x86_64 where no firmware is installed.
`/proc/version` names badc. The run also checks an untainted kernel, a clean
dmesg, and disk/network I/O, against a baseline taken from the image's stock
kernel in the same userspace.

The configuration is the distribution's, not `defconfig`: each pinned cloud
image's own `/boot/config-$(uname -r)`, mirrored on the `vendor-deps` release
under a pinned sha256, so a package build resolves it without booting anything
(`packages.py --config vendor`). That corpus is what a distribution kernel is,
and it is several times defconfig's:

| package | configuration | C units | assembly units | links |
|---|---|---|---|---|
| rpm, x86_64 | Fedora 44 | 21701 | 141 | 11535 |
| rpm, aarch64 | Fedora 44 | 23446 | 103 | 13076 |
| deb, x86_64 | Ubuntu 26.04 | 26227 | 129 | 15677 |
| deb, aarch64 | Ubuntu 26.04 | 30555 | 94 | 19136 |

Every count is badc's, with no fallback to another compiler, assembler or
linker, and every one is measured with the fallback lists empty -- nothing was
permitted to fall back, so these are results rather than allowances. All four
packages are complete. The Ubuntu configurations set
`CONFIG_BUILTIN_MODULE_RANGES`, which reads the map a relocatable link writes;
that path wrote none until the linker was taught to, which is what had held
those two lanes short of a package.

**Real hardware.** `packages.py --phases hw` runs the same install, one-shot
selection, boot, probes and exercise stage on a physical machine instead of a
guest: the machine is reached over ssh and its console is read from a serial
port on the host, byte for byte, so the same scanners judge both. What a
driver has to bind to comes from the machine's own baseline rather than from
an emulated model, and the machine's identity -- board, BIOS, CPU, firmware
mode -- is recorded next to the verdict, so a hardware run is diffable against
a VM run. A box with no remote power cut can only be recovered by its standing
boot default and its watchdog, so the run refuses to start unless that default
is a distribution kernel, selects the kernel under test for exactly one boot,
and after a boot that never answers reports the stage the console reached and
then waits for the machine to fall back. It is not in CI: it needs a bench
machine.

Two bench machines exist and they differ in what a failure leaves behind. One
has a physical serial port, so a kernel that dies before userspace is still
readable and `earlycon` covers the window from firmware handoff onward; that
lane is written up in [../demos/linux/micropc-testing.md](../demos/linux/micropc-testing.md).
The other has neither a serial port nor a display, so nothing is observable
until the network driver probes: there the console is netconsole over UDP,
the post-mortem is `efi_pstore` read back on the next boot, and the early
window is simply dark -- recovery rests entirely on the one-shot boot
selection and a bounded `panic=`. That lane, and the four rollback layers it
needs, are in
[../demos/linux/xps8930-testing.md](../demos/linux/xps8930-testing.md).

**Exercised.** Booting reaches a few dozen of the several thousand modules a
distribution kernel ships, and reaching userspace says little about whether
the kernel computes correct answers: a cipher that returns wrong ciphertext
leaves taint at 0, logs nothing, and lets systemd come up. So a stage inside
the booted badc kernel drives the rest, and the cheap part of it runs on
**every** boot rather than on request -- socket families, a storage
write-and-read-back, the crypto known-answer sweep, the kunit suites, and a
dmesg scan that fails on anything a driver reports at KERN_ERR or worse. That
set costs about ten seconds against a phase that installs a package and boots
twice. `--exercise` adds the two expensive steps, module-by-module loading and
the filesystem matrix; `--no-exercise-gate` opts out of the default set.

The socket-family step is there because of what it caught: a kernel whose
`bind(AF_VSOCK, ...)` always failed passed every passive check on a
distribution whose init happens not to use that family. `socket()` succeeding
is not the test -- the step binds, listens and reads back.

Every crypto implementation the
kernel registers is checked through AF_ALG by its driver name -- so an
arch-optimized path is a subject on its own -- against hashlib where the
standard library implements the algorithm and against the generic
implementation registered under the same name otherwise; where the
configuration keeps `CONFIG_CRYPTO_SELFTESTS`, the registration self-tests and
a `tcrypt` mode sweep run as well. Every built module is loaded once and
classified, with absent hardware counted apart from a fault, a hang, a missing
symbol or an oops taint bit. Filesystems are built on loop devices over sparse
files at both 512- and 4096-byte logical block sizes, stressed by parallel
write, churn, tree-copy and `O_DIRECT` jobs, then verified: file content is
checked against digests taken from a tmpfs seed rather than from the
filesystem, after dropping the caches and remounting, and each instance ends
with its own check-only fsck. The matrix includes the checksum-heavy
configurations on purpose -- btrfs with crc32c, xxhash, sha256 and blake2,
btrfs with zstd compression, ext4 and xfs with metadata checksums, LUKS2
dm-crypt and md raid1 -- because they route file data through the same kernel
crypto and compression code, where a miscompile shows up as corrupted data
rather than as a message in dmesg. The kunit suites run where the
configuration builds them.
**Self-host.** The optional `selfhost` phase turns the installed kernel into a
build host: inside the VM running the badc kernel, badc builds the kernel
again. Everything the build needs is staged before the reboot, so the badc
kernel carries the build with no network. What is measured is the kernel, not
the compiler -- the kernel log window bracketed by `/dev/kmsg` markers, taint,
OOM records and core dumps -- plus two results only a second build can give:
the in-guest unit outcomes against the host build's for the units both reached,
and a sample of the objects rebuilt and required to repeat byte for byte. It is
off by default and `--selfhost-scope` sizes it.

## What is not badc's

**Configuration classification.** `scripts/cc-version.sh` still classifies the
reference compiler, so `CONFIG_GCC_VERSION` keeps the reference toolchain's
value. Identification follows the compiler that built the objects;
classification stays with the toolchain whose bug-history gates the corpus was
captured under. badc's claimed `__GNUC__` is 4.3.0, below the kernel's gcc
floor (8.1.0).

## What the objects have to survive

Compiling is not the test; the kernel's own build and boot are. With
`CONFIG_OBJTOOL=y` kbuild runs objtool (`--orc`, jump-label and static-call
rewriting) over every object, the vmlinux linker script asserts an empty
`.got`, so badc's GOTPCRELX relocations must relax, and the boot exercises the
asm-emitted metadata sections (`__jump_table`, `.altinstructions`,
`__ex_table`, `.smp_locks`).

Kernel objects also constrain codegen directly. The shim forwards `-mno-sse`
and `-mgeneral-regs-only`, because a linked kernel object must keep off the
FP/SIMD register file, which the kernel runs with trapped and whose callers do
not maintain the System V `al` convention. It forwards `-mstrict-align` for
early-boot units running with the MMU off, and `-fPIC`/`-fpic`/`-fPIE`/`-fpie`
for the EFI-stub island and the boot decompressor, which reject absolute
relocations; those units take badc's position-independent object form while
every other unit keeps the absolute form whose relocations the ORC pass reads.
It forwards the ftrace patch sites: `-fpatchable-function-entry=N,M` gives
every function its NOP area, aligned as the function is, and a
`__patchable_function_entries` record linked to the function's text section;
on x86_64 `-pg -mfentry -mrecord-mcount` gives it the `call __fentry__` at
the symbol and the `__mcount_loc` entry, the forms gcc emits.
Every `-ffixed-REG` reaches badc as written: the shadow-call-stack register
`-ffixed-x18` of the aarch64 build, and the `-ffixed-q16` .. `-ffixed-q31`
set a NEON unit passes to keep the compiler off the registers it holds state
in. badc keeps the register out of its allocator and its own scratch picks,
and fails the unit on a name it cannot honour.

## Where the numbers come from

`sweep.py` is the measurement: it replays every C compile of a completed gcc
reference build against badc and buckets what fails by normalized error
signature, producing a ranked work list. It gates nothing.

`verify.py` is the gate: it builds with no fallback list, links, and boots,
and fails on any unit badc could not compile, any unit that fell back, any
undefined reference, any boot that misses either marker, any banner that does
not name badc, an unpack boot slower than its bound, a linked image whose
largest function or count of functions over 4 KiB exceeds the
architecture's budget, and on a build that compiled fewer units than
`--expect-units`
(make skips current objects, so without a floor a tree that rebuilt nothing
would pass while testing nothing).

Because the kernel decides what its code may use by probing the compiler at
configure time, a corpus captured from a gcc build carries gcc's answers.
`probecfg.py` re-runs the kernel's own configuration step with badc as the
probe compiler, so a replayed measurement can reflect badc instead.

CI runs `verify.py` on every push for both architectures, under an emulator
that the qemu lane itself compiled and linked with badc. The packaging and
install path runs in `.github/workflows/kernel-packages.yml` on demand and on
a pull request carrying the `kernel-packages` label -- it is off the push path
because GitHub-hosted runners expose no `/dev/kvm` and the VM would run under
TCG, and it carries no schedule because the corpus is pinned and a repeat run
repeats the previous run's work.
