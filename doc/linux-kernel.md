# The Linux kernel

badc compiles every C translation unit of a Linux 7.1.6 `defconfig` kernel on
x86_64 and aarch64, links it, and the result boots. The harness is
[`demos/linux/`](../demos/linux/), whose
[README](../demos/linux/README.md) documents every script, flag and pin.

## What holds today

**Compile.** Every kernel C unit of the architecture's own `defconfig` is
badc's, with zero fallbacks to another compiler. Two unit counts circulate at
the 7.1.6 pin, and they differ only in which make targets were built:

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
nonzero. An assembly unit is the one exception, and is covered below.

**Boot.** Both kernels boot under qemu, checked by more than reaching
userspace. The initramfs `/init` prints a marker, then mounts procfs and sysfs
and asserts the contents of a fixed set of files, reading them in 64-byte
requests and once more from a non-zero offset, so a seq_file that replays
records rather than continuing is caught. Only then does it print the second
marker. Each boot's `Linux version` banner -- the text `/proc/version` serves
-- must name badc, which pins the claim in the booted kernel rather than in the
configuration.

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

**Distribution.** The kernel packages as a `.deb` and an `.rpm` with the
kernel's own `bindeb-pkg` / `binrpm-pkg` targets, installs into stock Debian
13, Ubuntu 26.04 and Fedora 44 cloud images under qemu, and reboots into
systemd multi-user with udev-bound devices and modules autoloading on demand.
The system disk and the NIC ride on the storage controller and NIC model the
run selects -- the paravirtual pair by default, or an emulated NVMe, AHCI or
SCSI controller with an e1000e / rtl8139-class NIC, whose drivers the booted
kernel then has to bring up -- and the run asserts the booted kernel drives
the root disk and the NIC with those models' drivers. `/proc/version` names
badc. The run also checks an untainted kernel, a clean dmesg, and
disk/network I/O, against a baseline taken from the image's stock kernel in the
same userspace.

**Exercised.** Booting reaches a few dozen of the several thousand modules a
distribution kernel ships. `packages.py --exercise` runs a stage inside the
booted badc kernel that drives the rest. Every crypto implementation the
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

## What is not badc's

**Assembly.** Partly badc's. `badc -c foo.S -o foo.o` assembles a unit
directly, and kbuild routes `.S` through `$(CC)`, so `buildcc.py` decides each
assembly unit the same way it decides a C one. badc takes what its assembler
implements and gas takes the rest; unlike the C path a fallback here is
expected, so it is measured rather than fatal. At the 7.1.6 `defconfig` pin:

| | assembly units | badc | gas |
|---|---|---|---|
| x86_64 | 71 | 71 | 0 |
| aarch64 | 77 | 71 | 6 |

The x86_64 row moved from 45 of 71 once `-m16` / `-m32` units stopped
being refused: the writer emits ELFCLASS32 / EM_386 objects, so the nine
of those fourteen units the assembler can encode are badc's. It moved
again from 54 with the direct far branch (`ljmp` / `lcall $seg, $off`,
the `ptr16:16` and `ptr16:32` forms), which takes two of the four
real-mode units it was keeping on gas, and from 56 once an operand took
an expression over symbols rather than a name: `la57toggle.S`,
`wakeup_64.S`, `trampoline_64.S` and `head_64.S` are badc's, and both
AArch64 `hyp-entry.S` units are what took that row from 69. The row is
71 of 71 as measured by `verify.py --linker badc` on Fedora 44 (GNU as
2.46.1 behind the fallback): the eleven units the earlier measurement
left with gas -- AVX `vmovd`, `lsl r64, r64`, `ud1 r64, m`, `ud2a`, the
high-byte registers `%ah` / `%ch` / `%dh` / `%bh`, the `.hidden` and
`.reloc` directives, the `ANNOTATE` macros and a malformed
operand-reference spelling -- assemble, on this tree and on master
alike. The AVX forms the non-defconfig RAID-6 units spell
(`lib/raid6/avx2.c`, `avx512.c` and the recovery pair, C units of the
Fedora configuration) are encoded as well: the non-temporal `vmovntdq`
in its VEX.256 and EVEX.512 forms, and the upper-case register spelling
`%Zmm14`.

What keeps an aarch64 unit with gas, ranked by incidence (the earlier
measurement; the aarch64 row was not re-taken with the x86_64 one):

| units | class |
|---|---|
| 3 | Instruction encodings the tables do not carry: the NEON `str q` / `orr v.2s, #imm` post-index and immediate forms, `sha1c`. |
| 2 | Directives: `.hidden`, `.reloc`, `.endr` reached without its `.rept`. |
| 1 | `:abs_g2_s:` over a label: a symbol in a `movz` / `movk` group needs a MOVW relocation the writer does not emit. |

These figures supersede `tools/probe_asm_units/`'s 46 of 68 and 62 of 77. The
probe feeds each preprocessed unit through the file-scope `asm` path in
isolation, with no code model to honor. The numbers above are what the build
achieves.

An assembly unit built `-m16` or `-m32` gets an ELFCLASS32 / EM_386 object:
`Elf32_Ehdr` / `Shdr` / `Sym` widths, `SHT_REL` tables named `.rel<section>`
whose addends ride in the field each relocation patches, and the `R_386_*`
numbering. The class also picks the assembler's starting code mode, the way
`as --32` does for either spelling; `.code16` / `.code32` move it from there.
badc generates no i386 machine code, so a C source under either is refused by
name and only the assembler reaches the 32-bit container.

Against GNU as 2.46.1's object for the same source, byte for byte over every
allocatable section plus the symbol table and the relocations: 18 of the
x86_64 units that were already badc's and, setting aside the DWARF badc emits
none of for an assembled unit and the AArch64 `$x` / `$d` mapping symbols, 62
of 69 aarch64 units are identical. Of the nine the 32-bit container first
added, three are identical and the rest differ only in that DWARF and in one
class -- a branch to a named label in the same section always takes the wide
displacement, where GNU as relaxes it to `rel8`. The two the direct far branch
adds carry every far branch byte for byte and differ in that class and in one
more: a reference to a `.L` label is relocated against the label, where GNU as
folds it to the section symbol plus an addend. The bytes execute the same; the
sections are longer.

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
not name badc, and on a build that compiled fewer units than `--expect-units`
(make skips current objects, so without a floor a tree that rebuilt nothing
would pass while testing nothing).

Because the kernel decides what its code may use by probing the compiler at
configure time, a corpus captured from a gcc build carries gcc's answers.
`probecfg.py` re-runs the kernel's own configuration step with badc as the
probe compiler, so a replayed measurement can reflect badc instead.

CI runs `verify.py` on every push for both architectures, under an emulator
that the qemu lane itself compiled and linked with badc. The packaging and
install path runs in `.github/workflows/kernel-packages.yml` nightly, on
demand, and on a pull request carrying the `kernel-packages` label -- it is off
the push path because GitHub-hosted runners expose no `/dev/kvm` and the VM
would run under TCG.
