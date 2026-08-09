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

A unit badc cannot compile fails the build rather than being handed to gcc:
`buildcc.py`, the `CC=` shim, removes the partial object and exits nonzero. The
one route to another compiler is `$BADC_FALLBACK`, which names units explicitly
and marks the build impure in the manifest; the gate fails when that count is
nonzero.

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
kernel's own `bindeb-pkg` / `binrpm-pkg` targets, installs into stock Debian 13
and Fedora 44 cloud images under qemu, and reboots into systemd multi-user with
udev-bound virtio devices and modules autoloading on demand. `/proc/version`
names badc. The run also checks an untainted kernel, a clean dmesg, and
disk/network I/O, against a baseline taken from the image's stock kernel in the
same userspace.

## What is not badc's

**Assembly.** Every `.S` unit goes to gas: badc has no standalone assembler
driver, so `.S` units are out of scope for the build. `tools/probe_asm_units/`
measures the surface separately, feeding each preprocessed `.S` through badc's
file-scope `asm` path; badc's own assembler currently takes 46 of 68 x86_64
units and 62 of 77 aarch64 units that way. That is a probe, not a build path.

**Some links.** Under `LD=badc` the shim routes by facts of the command line,
and one class goes to the real linker:

* i386 links (`-m elf_i386`) -- the x86 boot setup, the realmode blob and the
  32-bit vDSO. badc emits ELF64 x86-64 and aarch64 only, so these need the
  i386 target, not a linker fix.

Everything else is badc's and only badc's: the `-r` merges, every `vmlinux`
kallsyms pass, the x86 boot decompressor, both 64-bit vDSOs, and the
scriptless probes.

The vDSOs are shared objects, so badc emits the dynamic-linking metadata a
loader searches -- `.dynsym`/`.dynstr`, `.hash` and `.gnu.hash` per
`--hash-style`, `.gnu.version`/`.gnu.version_d` for the version the symbols are
exported under, and a `.dynamic` with `DT_SONAME`, the table addresses and the
RELA/RELR tags -- plus `PT_DYNAMIC`. A link with no `-T` runs under a built-in
default script per output kind, as GNU ld falls back on its internal one, which
is what `scripts/tools-support-relr.sh` probes with.

**Configuration classification.** `scripts/cc-version.sh` still classifies the
reference compiler, so `CONFIG_GCC_VERSION` keeps the reference toolchain's
value. Identification follows the compiler that built the objects;
classification stays with the toolchain whose bug-history gates the corpus was
captured under. badc's claimed `__GNUC__` is 4.2.1, below the kernel's gcc
floor.

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
