# linux demo: kernel translation-unit sweep

Measures how much of a real Linux kernel build badc can compile today and
ranks what it cannot. Unlike the other demos this one is a gap-finding
harness, not a pass/fail smoke: it replays every C compile of a completed
gcc reference build against badc and buckets the failures by normalized
error signature, producing a ranked work list for kernel support.

## Pinned kernels

Two pins, with distinct jobs and no shared version:

| `--config` | kernel | configuration | used by |
|---|---|---|---|
| `defconfig` (default) | 7.1.6, both arches | the tree's own `make defconfig` | the sweep |
| `minimal` | 6.12.8 (x86_64), 6.10.1 (aarch64) | vendored `configs/<arch>-<version>.config` | the link-and-boot gate |

The sweep corpus is defconfig on the latest stable release: it is what a
distribution builds, and it moves forward with the kernel, which is what makes
it a gap finder. The configuration is not vendored. The tarball sha256 pins the
tree and `make defconfig` is a function of the tree, so the configuration is
already reproducible; a vendored copy would be a second artifact to regenerate
on every version bump, and one that can silently disagree with the tree.

The minimal configs are the opposite case and stay vendored. They are
known-booting configurations that cannot be derived from the tree, and the
link-and-boot gate's `--expect-units` floors are counts of exactly those
configurations. A `.config` is only meaningful against the tree it was produced
for, so each keeps its own release rather than being carried forward.

## Run

```sh
cargo build --release --features full            # build badc
python3 demos/linux/setup.py --build             # fetch + configure + gcc build
python3 demos/linux/sweep.py \
    --kernel-dir demos/linux/.cache/linux-<version>  # replay against badc
```

`setup.py` downloads the pinned release from cdn.kernel.org (sha256-verified),
installs the configuration `--config` selects, runs `make olddefconfig`, and
records every option the host toolchain forced or dropped in
`.cache/config-deviations-<arch>.txt`. `CONFIG_INITRAMFS_SOURCE` is cleared:
the sweep needs compile commands, not boot artifacts. `--build` then runs the
gcc reference build; that build validates the config and writes the per-object
`.<name>.o.cmd` files Kbuild leaves next to each object, which are the replay
corpus. It runs `make -jN -k KCFLAGS=-Wno-error`, because the corpus has to
cover the tree rather than stop at the first object the host gcc rejects: a
kernel and a compiler of different vintages disagree over warnings the kernel
promotes to errors. The `.cmd` file count is reported and is what says whether
the build was usable.

The build is native per architecture: run it on a box of the architecture being
measured.

Requirements for the reference build: gcc, make, flex, bison, bc, and the
libelf + openssl development headers.

## How the sweep works

`sweep.py` walks the built tree for Kbuild `.cmd` files, keeps the kernel C
compiles (`-D__KERNEL__`, a `.c` source, `-c`), and rewrites each gcc command
into badc's flag set: the preprocessor surface is kept (`-D`/`-U`/`-I`/
`-iquote`/`-include`, `-isystem` folded into `-I`), the recorded optimization
level is honored (`-O1` and above become badc `-O`; `-O0` units -- e.g. ones
that `#error` under `__OPTIMIZE__` -- stay plain), and everything else is
dropped -- warnings, `-g`/`-std`, and the gcc code-model/hardening set
(`-mcmodel=kernel`, `-mno-red-zone`, `-fno-strict-aliasing`,
`-fstack-protector*`, ...) have no badc spelling. Each unit runs as
`badc --gnu -q -c --target=<triple>` from the kernel tree (Kbuild paths are
relative). Assembly units (`.S`) are out of scope and counted separately, as
are `.cmd` files that hold no kernel C compile (host tools, linker steps).

Failures are bucketed by a normalized first-error signature (locations,
quoted identifiers, and numbers stripped), so one diagnostic shape is one
bucket, and additionally ranked by first-error site: a single header can
gate hundreds of units, and the site table names it. The output is a totals
line plus both tables, printed to stdout and written as markdown via
`--report`; the full per-unit result set lands next to it as JSON for
drill-down.

Options: `--arch x86_64|aarch64` (default: host), `--badc`/`$BADC`,
`-j`, `--limit N` (debug), `--timeout` per unit, `--keep-objects`.

Because badc stops at the first error, a construct in a widely included
header masks everything behind it. Two levers expose the masked tail
without touching the tree:

- `--pre-include <header>` forces a header in front of every unit, to
  supply a macro or type badc lacks and measure what sits behind it (e.g.
  `#define __SIZEOF_INT128__ 16`, which the kernel uses to gate its
  `__u128` typedef). Compile-only: not ABI-audited.
- `--pre-I <overlay-dir>` puts an include dir in front of the recorded
  ones; drop a patched copy of a gating header there (e.g. one that stubs
  the single construct badc rejects) and the failures behind it become
  measurable. Overlays hold copied kernel code, so they are built on the
  measurement box, not vendored here.

## badc-probed configuration (opt-in)

The kernel decides what its code may use by probing the compiler at configure
time, and Kconfig bakes the answers into `include/generated/autoconf.h`. A
corpus captured from a gcc reference build therefore carries gcc's answers, and
replaying it asks badc to compile code gated on capabilities it was never
asked about. The measured consequence on x86_64 is `CONFIG_CC_HAS_NAMED_AS=1`,
which turns on the `__seg_gs` named address space in the percpu headers and
masks 84% of the tree behind one construct badc does not implement.

`probecfg.py` re-runs the kernel's own configuration step with badc as the
probe compiler, so the replayed configuration reflects badc:

```sh
python3 demos/linux/setup.py --cache ~/probecfg      # fresh tree, no --build
python3 demos/linux/probecfg.py --kernel-dir ~/probecfg/linux-<version>
python3 demos/linux/sweep.py --kernel-dir <reference tree> \
    --probed-autoconf ~/probecfg/linux-<version>/include/generated/autoconf.h
```

`--probed-autoconf` substitutes the probed header for the reference one that
every unit force-includes, and the substitution and its unit count are printed
and recorded in the report header, so a number is always attributable to the
configuration it came from. Without the flag nothing changes.

The probe tree must be fresh and separate from the reference tree: configuring
rewrites `.config` and the generated headers, and the corpus has to stay as it
was captured. The unit population stays the reference build's -- a
badc-probed config would compile a slightly different object set, and holding
the population fixed is what makes the two numbers comparable. Only the
capability symbols change, and `probe-deviations-<arch>.txt` lists every one.

### Why re-configuring rather than editing the generated header

Post-processing `autoconf.h` needs a list of symbols to clear, and any such
list is a standing claim about badc that decays as badc changes. Re-running
Kconfig has no list: the probes are the kernel's, and their verdicts are
whatever badc answers on the day it runs.

The cost is that badc cannot be named as `$(CC)` directly -- the probes use
driver spellings (`-x c`, `-`, `-S`, `-E -P`) badc has no equivalent for -- so
`ccshim.py` presents the gcc driver surface the probes use and routes each
probe class to one answerer. C capability probes go to badc with their flags
passed through unchanged, so a flag badc does not accept fails the probe;
that is the truthful answer and it matches the sweep, which drops exactly
those flags when it replays a compile. Assembler probes (`-x assembler*`) and
preprocess-only classification queries (`-E`, `scripts/cc-version.sh`) are
delegated to the reference compiler: badc has no standalone assembler driver
and `.S` units are out of scope, and the version gates encode a toolchain's
bug history rather than a capability. Those two delegations are the limits of
the mode, and both are reported in the probe log. `--version` is answered by
badc itself: its first line becomes `CONFIG_CC_VERSION_TEXT`, the
identification the boot banner and `/proc/version` report, which must name
the compiler that probed the tree.

### Corroborated probes

A kernel probe can be non-discriminating for badc: badc accepts the probe
snippet but rejects every form the kernel actually emits, so the probe reports
a capability badc does not have. `probes/*.c` holds a corroborating use of
such a feature, selected by a `// trigger: <substring>` line matched against
the probe source; a matching probe is answered by compiling the probe and the
corroboration together. This strengthens the kernel's probe instead of
overriding its verdict, and it is re-verified on every run rather than
asserted once.

Each file must state the evidence for its own existence, because that
evidence is a claim about badc and decays as badc changes. When the claim
stops holding the file has to go: the directory is empty whenever badc
handles every form the corresponding feature is spelled with, and an empty
directory is the normal state, not a missing one. The `CC_HAS_NAMED_AS`
corroboration was removed once badc emitted the segment override for both
the qualifier-leading declaration and the dereference of a segment-qualified
pointer, which is the form the percpu headers read through.

## Hybrid build (link + boot)

`buildcc.py` is a kbuild CC shim that builds a linked, bootable kernel
whose every C object is badc's, and the kernel's own link and boot become
the correctness test for those objects.

Named as `CC=`, the shim classifies each invocation. A kernel C compile
(`-c`, `-D__KERNEL__`, a `.c` source, not `-m16`/`-m32`) goes to badc and
only to badc: no other compiler runs on it, so no other compiler's object
can reach the image. The rewritten flag set forwards kbuild's
`-Wp,-MMD,<path>`, so badc writes the `.d` file `fixdep` turns into the
`.cmd` file and incremental rebuilds trigger on the right headers. A badc
failure is the shim's failure -- it removes any partial object, puts
badc's diagnostic on stderr and exits nonzero, so `make` stops at the
defect instead of carrying on with something else's object.
`--version` is answered with badc's identification (`$BADC --version`): its
first line becomes `CONFIG_CC_VERSION_TEXT`, the compiler text in the boot
banner and `/proc/version`, and Kconfig re-records that text whenever it
disagrees with what the build's `$(CC)` reports, so only the shim's own
answer can survive the build.

A kernel assembly unit (`-c`, `-D__KERNEL__`, a `.S` / `.s` source) goes
to badc too: kbuild compiles `.S` through `$(CC)`, not `$(AS)`, so this
shim is where an assembly unit is decided. Unlike a C unit, a failure is
not the build's: badc's diagnostic goes to the manifest as a `gas` line
and gas assembles the unit. gas taking what badc's assembler does not yet
implement is the expected state, so the counts are the measurement rather
than a gate. A unit badc assembles is recorded `badc-asm`.

Everything else (probes, `-E`, `-S`, links, the host tools under
`scripts/` and `tools/`) goes to gcc untouched, so the configuration and
object population match the reference corpus. Linking is `ldshim.py`'s,
below, and is badc's throughout.
In particular `scripts/cc-version.sh` classifies the reference
compiler (`-E`), keeping `CONFIG_GCC_VERSION` at the reference
toolchain's value: identification follows the compiler that built the
objects, classification stays with the toolchain whose bug-history gates
the corpus was captured under (badc's claimed `__GNUC__`, 4.2.1, sits
below the kernel's gcc floor).

The one way a kernel C unit reaches another compiler is `$BADC_FALLBACK`,
which names units explicitly. It exists to bisect a suspected miscompile:
each listed unit is recorded as `fallback` in the manifest, so a build
that used it cannot be mistaken for a pure one, and `verify.py` fails when
the count is nonzero.

```sh
cp <reference>/.config <tree>/ && make -C <tree> olddefconfig CC=$PWD/demos/linux/buildcc.py
BADC=<badc> BADC_FALLBACK=fails.txt BADC_MANIFEST=manifest.txt \
    make -C <tree> -j12 CC=$PWD/demos/linux/buildcc.py vmlinux bzImage
```

`fails.txt` holds one kernel-relative source or object path per line.
Object entries discriminate a compile context: a source also built into an
isolated-link environment (the EFI stub's `lib-%.o`) is listed by the
object it becomes there, leaving its other compiles to badc. Leave the
variable unset for a pure build; both defconfigs compile with an empty
list. The manifest gets one line per kernel unit: `badc`, `fallback` or
`fail` for a C unit, `badc-asm` or `gas` for an assembly one, plus the
source and first diagnostic. A `fail` line is also a build failure -- the
shim exits nonzero -- so the manifest records what stopped the build
rather than what it hid.
Unlike the sweep, the shim forwards `-mno-sse` and
`-mgeneral-regs-only`: a linked kernel object must keep off the
floating-point / SIMD register file, which the kernel runs with trapped
(no CR4.OSFXSR on x86_64, CPACR_EL1.FPEN on aarch64) and whose callers do
not maintain the System V `al` convention. badc's variadic prologue
honors both spellings. It also forwards `-mstrict-align` (early-boot
units running with the MMU off) and `-fPIC`/`-fpic`/`-fPIE`/`-fpie`: the
EFI-stub island copies its objects wholesale and rejects any absolute
relocation, and the boot decompressor links into a segment that may carry
none, so those units take badc's position-independent object form
(label-difference switch tables) while every other unit keeps the
absolute form whose relocations the ORC pass reads.
Environment: `BADC` (required), `BADC_REAL_CC` (default `gcc`),
`BADC_TARGET` (default `linux-x64`), `BADC_TIMEOUT` (default 300s).

### Linking with badc (`ldshim.py`)

`ldshim.py` is the same idea for `LD=`. Named as the kernel's linker, it
records every decision in `$BADC_LD_MANIFEST`. Nothing reaches GNU ld
except what `$BADC_LD_FALLBACK` names:

* Every link is badc's and only badc's: the `-r` merges (`vmlinux.o`,
  `arch/arm64/kvm/hyp/nvhe/*`), every `vmlinux` kallsyms pass, the x86 boot
  decompressor, all three vDSOs, the `-m elf_i386` boot links
  (`arch/x86/boot/setup.elf`, `arch/x86/realmode/rm/realmode.elf`, `vdso32`),
  and kbuild's scriptless probes. A badc failure is the shim's failure, as
  with the CC shim.

  The i386 links are ELF32 `EM_386`: their inputs carry `SHT_REL` relocations,
  which keep the addend in the field being relocated rather than in the
  relocation record. The reader materializes each implicit addend from the
  input bytes at the field's own width (1, 2 or 4), so one relocation engine
  covers both formats, and the writer emits the ELF32 records -- `Elf32_Ehdr`/
  `Phdr`/`Shdr`, 16-byte `Elf32_Sym`, 8-byte `.dynamic` entries, 32-bit
  `.gnu.hash` Bloom words. `--emit-relocs` writes the target's own format, so
  `realmode.elf` gets `.rel.<section>` tables, which is what
  `arch/x86/tools/relocs --realmode` reads.

  The vDSOs are shared objects, so badc builds the dynamic-linking metadata a
  loader searches: `.dynsym`/`.dynstr` from the symbols the script's `VERSION`
  block exports, `.hash` and `.gnu.hash` per `--hash-style`, `.gnu.version` /
  `.gnu.version_d` for the version the kernel's own loader and glibc look the
  symbols up under, and a `.dynamic` carrying `DT_SONAME`, the table
  addresses, and the RELA/RELR tags where relocations exist. bfd builds these
  for every `-shared` link and the kernel's own scripts discard the ones it
  does not want (`vmlinux.lds.S` sends `.dynsym`/`.dynstr`/`.hash`/`.gnu.hash`/
  `.dynamic` to `/DISCARD/`), so badc does the same and those links are
  unchanged.

  A scriptless final link runs under badc's built-in default script, one per
  output kind, the way GNU ld falls back on its internal one. The only such
  call in a kernel build is `scripts/tools-support-relr.sh`, which is what
  decides `CONFIG_TOOLS_SUPPORT_RELR`.
* Version and capability probes (`-v`/`--version` with no output file) are
  answered by badc, so what the configuration records about the linker comes
  from the linker that will do the linking. `$(call ld-option,...)` runs the
  option past the linker with `-v`; badc rejects options it does not
  implement, so kbuild drops them rather than passing options that would be
  accepted and ignored.

badc's `--version` prints `GNU ld (badc <version>) 2.30`, which
`scripts/ld-version.sh` reads as a BFD-flavour linker at binutils 2.30 --
the kernel's own floor, and deliberately no higher, so nothing gated on a
newer linker is claimed. Two configuration symbols move as a result:
`CONFIG_LD_VERSION` records 23000, and `CONFIG_ARM64_PTR_AUTH_KERNEL` turns
off (`arch/arm64/Kconfig` gates it on `LD_VERSION >= 23301`). The latter
costs nothing here: `buildcc.py` already withholds `-mbranch-protection=`
specs naming `pac-ret`, because badc emits no pointer-authentication
prologue. `CONFIG_DEBUG_INFO_COMPRESSED_{ZLIB,ZSTD}` also disappear, because
badc rejects `--compress-debug-sections`.

`BADC_LD_FALLBACK` names output paths to leave to the real linker, the
bisect tool for a suspected bad link; each is recorded as `fallback`, so a
build that used the list cannot be mistaken for a pure one.

Objects must survive more than the link: with `CONFIG_OBJTOOL=y` kbuild
runs objtool (`--orc`, jump-label and static-call rewriting) over every
object, the vmlinux script asserts an empty `.got` (badc's GOTPCRELX
relocs must relax), and the boot exercises the asm-emitted metadata
sections (`__jump_table`, `.altinstructions`, `__ex_table`, `.smp_locks`).
A minimal initramfs whose `/init` prints a marker and powers off makes the
boot a pass/fail check under `qemu-system-x86_64 -nographic`.

## Regression gate

`verify.py` runs the build above with no fallback list and boots the
result, as a pass/fail check rather than a measurement:

```sh
python3 demos/linux/initramfs.py -o initramfs.cpio.gz
python3 demos/linux/verify.py --kernel-dir <writable tree> \
    --initramfs initramfs.cpio.gz --expect-units 2800 --report verify-x86_64.json
```

`initramfs.py` builds the boot image: a single static `/init`, compiled with
the reference compiler, that prints the marker and then requests a reset,
which `-no-reboot` turns into an emulator exit, so a boot ends when userspace
is reached rather than when the timeout expires. It is the probe, not part of
what is under test.

Reaching userspace is a claim about the boot path and nothing else, so `/init`
then exercises the kernel it booted and reports that separately. It mounts
procfs and sysfs and reads a fixed set of files from each, asserting their
contents, in 64-byte requests so a file spans several `read()` calls, and once
more from a non-zero offset -- a seq_file reaches one by replaying records
rather than by continuing. Only if every check passes does it print the second
marker, `BADC-SELFTEST-OK`. Each file is named on the console before it is
opened (`BADC-SELFTEST-STEP`), so a boot that stops reports which file it
stopped on, and the gate quotes that line in the failure. A kernel whose
procfs reads never return prints the boot marker and hangs, which the boot
marker alone cannot distinguish from a pass.

The checks end at the vDSO, the one image in the build a loader has to search
rather than just map. `/init` resolves it the way a loader does --
`AT_SYSINFO_EHDR`, `PT_DYNAMIC`, `DT_SONAME`, the `.gnu.hash` Bloom filter and
chain or, when the vDSO's `--hash-style` produced no `.gnu.hash`, the `.hash`
bucket and chain, then `DT_VERSYM`/`DT_VERDEF` for the version the symbol is
exported under -- and calls the function those tables hand back, requiring
`CLOCK_MONOTONIC` to be non-zero and non-decreasing (`BADC-VDSO-OK`). Every
table the linker builds is on the path to that call, so a vDSO that links and
cannot be searched fails here rather than passing unnoticed.

Before building, the gate re-runs `make olddefconfig` with the shim as CC, so
the tree's `CONFIG_CC_VERSION_TEXT` records badc's identification; the diff
is logged, and only that symbol moves (the capability probes still go to the
reference compiler). Each boot's `Linux version` banner -- the same text
`/proc/version` serves -- must then contain `badc`, which pins the claim in
the booted kernel, not just the configuration.

`--linker badc` (the default) makes every link badc's, through `ldshim.py`
above; `--linker reference` leaves them all to `--real-ld` and is the contrast
run. Under `--linker badc` the gate names each link the shim left to the real
linker, and fails on a link badc could not make, a link that used
`BADC_LD_FALLBACK`, or a run where badc made no link at all. badc links the
kernel on both architectures, so the default is the run that asserts it; the
contrast is then a stated choice rather than the one a caller gets by
omission.

Which linker ran is not left to be inferred: the run names it before it builds
and again in its verdict, and the report records it, so neither a console log
nor a report can be read as the other lane's. A `--no-build` run linked
nothing and names no linker at all.

The booted image carries the same statement, so it is checked there too. The
banner's compiler identification is followed by the one the build probed from
`$(LD)` -- `GNU ld (badc <version>) 2.30` under `--linker badc`, the real
linker's version string under `--linker reference` -- and each boot must
agree with the run's choice. A stale image from the other lane therefore
fails rather than passing as this one's.

It fails on any unit badc cannot compile, any unit that fell back to the
reference compiler, any undefined reference at link, any boot that does not
reach either marker, any banner that does not identify badc, and on a build
that compiled fewer units than `--expect-units` -- make skips units whose
objects are current, so without a floor a tree that rebuilt nothing would
pass while testing nothing. For the same reason the tree is rebuilt from
clean by default.

Per-arch differences (target triple, image path, qemu machine and console)
are a table in the script; `--arch` selects the row and defaults to the host.
Run it on the box whose corpus matches, and against a copy: the build writes
into the tree.

Two parameters depend on the corpus rather than the architecture and have to
be passed. `--expect-units` is a floor on the unit count of the configuration
under test: at defconfig the sweep tree measures 2921 (x86_64) and 4434
(aarch64), and the vendored minimal configs 1912 and 1346, so set it just
under whichever one is being built. `--rdinit` is whatever the initramfs
installs, `/init` by default.

`--qemu` selects the emulator; `--qemu-args` adds arguments to the boot. An
emulator built out of tree has no data directory, so it needs `-nic none`:
the default NIC would look for a boot ROM there and refuse to start without
it. `--no-build` skips the build and boots the image already in the tree,
which is how a boot is repeated without a twenty-minute rebuild.

### KASLR displacements

A kernel configured with `CONFIG_RANDOMIZE_BASE` applies its relocations
against a displacement drawn at boot, and a defect in relocated output can
present at one displacement and not at another -- a flexible-array
initializer that emitted two relocations for one slot had the displacement
applied twice, and showed up on some draws only. Boots at whatever the
machine happens to draw catch that by luck, so the gate picks the
displacements instead:

* aarch64 -- the early boot code takes the displacement from
  `/chosen/kaslr-seed` in the device tree, and `-M virt` honours a tree
  passed with `-dtb`. The gate dumps the machine's own tree
  (`-M virt,dumpdtb=`), writes the seed into it (`kaslr.py`, no external
  device-tree tools), and boots against the result. The default plan is the
  fixed seeds in `kaslr.py` plus one drawn for the run, so every run covers
  the same displacements as the last one and one more besides. Every seed is
  reported, and `--kaslr-seed <64-bit value>` replays a boot exactly.
* x86_64 -- the boot path mixes RDRAND, the TSC and the i8254 counter with a
  hash of `boot_params` (`arch/x86/lib/kaslr.c`). Nothing there takes a value
  from the boot loader, the command line or the firmware, so a displacement
  cannot be pinned. Those boots run unpinned and `--kaslr-seed` is rejected.

Before the boots, one boot per distinct displacement runs with `rdinit=`
naming nothing: the kernel panics and its panic notifier prints
`Kernel Offset:`, which is the only report either architecture makes of the
displacement it ran at. The gate fails if a configuration that randomizes the
base produced no displaced boot, or if distinct seeds all produced one
displacement -- either means it stopped covering relocated output.

A tree with `# CONFIG_RANDOMIZE_BASE is not set` (both vendored minimal
configs) boots at its link address, and the checks above stand down. A
machine that supplies no `/chosen/kaslr-seed` (`-M virt,dtb-randomness=off`)
degrades to unpinned boots with a line saying so.

CI runs this against the pinned release configured with the architecture's
own `defconfig`, and boots the result under the emulator the qemu lane
compiles and links with badc. Both architectures are gated.

## Distro packages (packages.py)

`verify.py` boots a marker initramfs; `packages.py` runs the rest of the road
a kernel travels in a distribution. It builds the pinned release with badc
compiling every kernel C unit (the buildcc.py contract: zero fallbacks),
packages it with the kernel's own targets -- `bindeb-pkg` on x86_64,
`binrpm-pkg` on aarch64 -- installs the package in a stock cloud image
(Debian stable on x86_64, Fedora on aarch64) under qemu, and validates the
reboot: the package scriptlets (depmod, initramfs generation via
initramfs-tools or dracut, the boot-loader entry), systemd reaching
multi-user, udev-bound virtio devices, on-demand `modprobe` of packaged
modules, an untainted kernel, a clean dmesg, and disk/network I/O. Before
the install the same probes run against the image's stock kernel, so every
measurement has a baseline from the same userspace.

```sh
python3 demos/linux/packages.py --arch x86_64 \
    --tarball <linux-<version>.tar.xz> \
    --report packages-x86_64.json
```

`--linker badc` makes the build's links badc's too, through `ldshim.py`, and
the run then fails on any link the shim could not make; the default keeps the
reference `ld` so the packaging gate measures the compiler alone. Boot-loader
installation is the one route that runs the 16-bit `setup.elf` from a disk
rather than from qemu's `-kernel`, so it is where a badc-linked boot image is
exercised end to end.

Phases -- `config` (take a configuration out of the stock image), `tree`
(extract + configure), `build` (hybrid make), `package`, `vm` -- are idempotent
and `--phases` selects a subset. Without `--config` the
tree's own `defconfig` is the corpus, which is what CI builds: 2953 units on
x86_64 and 10489 on aarch64 at the 7.1.6 pin, kernel plus modules. A fresh
qcow2 overlay keeps the base image pristine per run. On an rpm host the Debian
packaging tools (dpkg, dpkg-dev, debhelper) are provisioned under
`--deb-tools` from the host's own mirror via `dnf download` + rpm2cpio
extraction; nothing is installed system-wide, and `dpkg-buildpackage` runs
with `-d` plus a scratch admindir because the build host's package database is
not what the produced package depends on. `rpmbuild` runs with
`--without debuginfo` and `INSTALL_MOD_STRIP=1`: the gate packages the kernel,
not its debug info. The provisioned prefix is stamped with a digest of the rpm
file names `dnf` resolves the tool set to, so a prefix built against a package
set the mirror has moved past is rebuilt rather than reused.

### The distribution's own configuration (`--config from-vm`)

`defconfig` is the tree's answer to what a kernel should contain; a
distribution's is its own, and the two differ in size and in shape. `--config
from-vm` boots the pinned cloud image before anything is built, reads
`/boot/config-$(uname -r)` -- the configuration the distribution's kernel
package ships -- and uses it as the corpus. The source cannot drift from the
kernel the image actually runs, and it is the same image the gate installs
into, so the configuration and the system under test agree by construction.
The extraction lands in `<workdir>/config-vm-<arch>.config` with a
`config-vm-<arch>.json` recording the release it came from, its sha256 and its
option count; a later run reuses it instead of booting again.

Measured at the current pins:

| | source kernel | `=y` | `=m` |
|---|---|---|---|
| Debian 13 cloud amd64 | 6.12.100+deb13-cloud-amd64 | 1804 | 1137 |
| Fedora 44 aarch64 | 6.19.10-300.fc44.aarch64 | 3484 | 5522 |

The distribution's kernel is not the pinned one, so the configuration is
carried forward with `make olddefconfig` and every option that moved is
recorded in `<workdir>/config-deviations-<arch>.txt` (538 on x86_64, 312 on
aarch64 at these pins). The deviations are part of the measurement, not noise:
they name what the version gap and the build host together made of the
distribution's answers. Two sources of deviation are worth separating when
reading the file -- symbols the version difference added or removed, and
symbols the build host cannot satisfy (`DEBUG_INFO_BTF` needs `pahole`,
`CONFIG_RUST` needs `bindgen`; without them Kconfig turns the option off and
the deviation records it).

Options whose value names a file in the originating packaging tree are cleared
before `olddefconfig`, because none of those paths exist here and the artifacts
they name are ones this build produces itself: `CONFIG_INITRAMFS_SOURCE`,
`CONFIG_SYSTEM_TRUSTED_KEYS`, `CONFIG_SYSTEM_REVOCATION_KEYS` and
`CONFIG_MODULE_SIG_KEY`. Each clearing appears in the deviations.

#### What a distribution configuration compiles today

Neither architecture builds one yet. Surveyed at the 7.1.6 pin with
`--keep-going`, so the counts are the whole corpus rather than the first
defect:

| | `badc` | `fail` | `badc-asm` | `gas` | image | wall |
|---|---|---|---|---|---|---|
| x86_64, Debian 13 | 5100 | 54 | 64 | 40 | none | 8m19s (12 jobs) |
| aarch64, Fedora 44 | 17682 | 45 | 89 | 7 | none | 18m28s (8 jobs) |

Two constructs the distribution configuration reaches and the defconfig one
does not accounted for nearly the whole corpus until recently: the GNU
asm-label symbol rename and the fortified `strlen` macro, both in
`include/linux/fortify-string.h`, which `linux/string.h` includes and which is
compiled only under `CONFIG_FORTIFY_SOURCE`. That option has no `default y`
and no arch defconfig sets it, while both distributions enable it -- that
single difference is what separates the defconfig corpus from a distribution
one.

Ranked by normalized signature, what is left is:

| units | signature | arch |
|---|---|---|
| 36 | `.global` in an inline-asm template (#722) | x86_64 |
| 31 | `.size sym, .-sym` across asm statements (#724) | aarch64 |
| 5 | inline asm: non-constant section data value | x86_64 |
| 4 | inline asm: unsupported instruction `encls` | x86_64 |
| 3 | `unknown function printk` | aarch64 |
| 2 | `expected , or ; after declarator` | aarch64 |
| 18 | 16 further signatures, one unit each | both |

The `arch` column records where a configuration reaches the construct, not a
target restriction: both inline-asm classes are rejected on either
architecture, and each distribution's configuration selects a different set of
subsystems that emit them.

#715 (aarch64, a `.bss` allocation the vDSO's linker script discards) stops
the arm64 build at `vdso_prepare`, which is a hard prerequisite, so measuring
past it needs `--fallback` on `arch/arm64/kernel/vdso/vgetrandom.c`; that is
the one `fallback` unit in the aarch64 row.

No `vmlinux` is produced on either architecture, so the package and vm phases
are unreachable and nothing is said here about installing or booting a
distribution-configured kernel.

### Surveying a kernel and configuration from a URL

The same script is the local survey tool: `--tarball-url` fetches a kernel
tarball and `--tarball-sha256` verifies it. The digest is required rather than
optional -- a survey has to be reproducible, and a truncated or substituted
download must not be able to present itself as a compiler defect. `--config`
takes any `.config`, for any kernel version, and carries it forward exactly as
above. `--pkg` selects the packaging formats, so one run can produce both the
`.deb` and the `.rpm`; the default is the format the architecture's image
installs.

```sh
python3 demos/linux/packages.py --arch x86_64 \
    --tarball-url https://cdn.kernel.org/pub/linux/kernel/v7.x/linux-7.1.6.tar.xz \
    --tarball-sha256 <sha256> \
    --config /boot/config-$(uname -r) --pkg deb,rpm \
    --phases tree,build,package --keep-going \
    --workdir survey-out --report survey-x86_64.json
```

`--keep-going` is what makes it a survey rather than a gate. The buildcc.py
contract stops the build at the first C unit badc rejects, which names one
defect; `-k` carries make past it, so the manifest ranks every unit that failed
instead. The failing exit status is still reported and the manifest counts are
what the run is judged on. It is not for the gate: a build that continued past
a failure has no complete image to install.

`--fallback` and `--ld-fallback` name the `BADC_FALLBACK` /
`BADC_LD_FALLBACK` lists for bisecting a suspected miscompile. The gate drops
an inherited list because its contract is zero fallbacks; stating one
explicitly puts it in the manifest, where a build that used it cannot be
mistaken for a pure one.

The report and the manifest are the same shape the gate produces, so a survey
result and a CI result are comparable rather than two formats.

### Cloud images

Each architecture's image is a `vendor-deps-v1` release asset pinned by
sha256, fetched through the same helper as every other vendored archive and
rejected on mismatch -- in all paths, including a `--image` pointing at a local
file (`--image-sha256` states the digest of a deliberately different one).
Without a pin, a red gate is not attributable to a badc change.

The bytes are the distributions' own, mirrored rather than fetched from them,
because an upstream URL is not a durable pin: Debian keeps only the last few
dated cloud snapshots, so a URL pinned to one stops resolving within weeks,
and `trixie/latest/` is not a pin at all. The asset table in `packages.py`
records each image's upstream URL and the digest the distribution publishes
for it (sha512 for Debian, sha256 for Fedora), so the mirrored bytes stay
checkable against the source. There is no `actions/cache` layer in front of
this: a release asset downloads from the same CDN as the rest of CI's inputs,
and the cache's eviction window is not shorter than this lane's cadence.

### Concurrency and the accelerator

Two runs on one host do not collide: the ssh forward takes a free port per run
and the workdir is held under an exclusive lock, so a second run against the
same workdir fails immediately and names the holder. `--accel` selects the
qemu accelerator -- `kvm` fails when `/dev/kvm` is unusable rather than
substituting an emulator an order of magnitude slower, `tcg` states that
choice, and the default reports whichever it took. `--vm-cpu` overrides the
model (`host` under kvm, `max` under tcg).

### In CI

`.github/workflows/kernel-packages.yml` runs the whole harness -- build,
package, publish, install, boot -- on a nightly schedule, on
`workflow_dispatch`, and on a pull request carrying the `kernel-packages`
label. It is deliberately off the push path, and the reason is the
accelerator: GitHub-hosted runners expose no `/dev/kvm`, so the VM runs under
TCG. Measured on the boxes against the same packages and images with the VM's
host cores capped at 4, the vm phase costs 40 s under KVM and 3 min under TCG
on x86_64, and 2.5 min under KVM and 40 min under TCG on aarch64 -- of which
28 min is `rpm -ivh` regenerating the initramfs with dracut -- on top of a
5 min and 11 min build and package. The per-push gate stays `verify.py` in
ci.yml's `kernel` job: the same "badc compiles every unit, zero fallbacks"
contract, booted with a marker initramfs. Self-hosted KVM runners would buy
back the time, but this is a public repository, and a self-hosted runner would
execute pull-request code from any fork on the machine that runs it.

The push-path lane runs `--linker badc`, so what it gates is the whole claim:
badc compiles every unit and links the kernel, and that image boots. It does
not also run the contrast, because the two runs differ only in the links and
share the compile, which is the whole cost -- one clean run end to end
(build, displacement probe, four boots) measured on the boxes at defconfig:

| box | `--linker badc` | `--linker reference` |
|---|---|---|
| aarch64, 8 cores | 250 s (build 225 s) | 249 s (build 224 s) |
| x86_64, 12 cores | 319 s (build 220 s) | 320 s (build 220 s) |

The two are within run-to-run noise of each other, x86_64's badc-linked run
coming out the faster of the pair. A second matrix dimension would therefore
buy the link steps at the price of a second full compile per architecture on
every push. `kernel-packages.yml` carries the contrast instead: it builds the
same pinned release at the same `make defconfig` with kbuild's default `LD`,
nightly and on both architectures, which is where GNU ld consuming badc's
kernel objects is gated. A kernel that boots one way and not the other
separates a compiler defect from a linker one.

Each lane publishes two artifacts: the packages (deb or rpm, plus headers,
`SHA256SUMS`, the run's report and the per-unit manifest), named
`linux-badc-<arch>-<kernel release>-badc<version>-<commit>` and kept 30 days,
uploaded before the VM step so a failed boot still leaves an installable
package on the run page; and the validation record (report JSON, the qemu
serial console log, any core dumps). Tagged releases carry no packages: these
are gate evidence for one pinned kernel configuration, not a distribution
channel, and publishing them as release assets would imply support for
installing them on real machines.

The x86_64 lane runs its guest as `-cpu max`, which exposes LA57, so the
kernel boots under 5-level paging; `verify.py` takes the emulator's default
CPU model, which does not. That is one of the two dimensions this lane adds,
and each caught one of the defects it found on its first run: an oops in
`pgd_alloc` reachable only under 5-level paging, and
`WARN_ON_ONCE(!on_thread_stack())` at irqentry exit, which a marker boot
cannot see because it asserts on markers alone and reads neither dmesg nor
the taint word. The loader is not the difference -- `-kernel` runs the
decompressor's 4-to-5 level switch too.

Core dumps are captured throughout. Before validation the vm phase sets
`kernel.core_pattern`, a core size limit (limits.d) and systemd's
`DefaultLimitCORE` on the stock system, via sysctl.d / systemd drop-ins that
persist into the badc kernel's boot, so a crash of any service, udev worker
or `modprobe` dumps rather than vanishing. After each phase the run sweeps
`/var/crash` (and `coredumpctl` where present), pulls each core, its binary
and `/proc/version` into the box scratch, and takes a first-pass `gdb` back
trace; a core from a badc-compiled binary is a reported finding. A kernel
oops or panic leaves no userspace core -- the qemu serial console log is that
record and is kept per boot regardless.

## Struct layouts (`layout.py`)

A struct-layout difference between the two compilers is an ABI defect that
produces memory corruption rather than a diagnostic: the kernel boots, the
modules load, and a wrong member offset shows up later as a corrupted field
somewhere unrelated. Neither the sweep nor the boot gate can see one.
`layout.py` reads the DWARF both compilers emit and compares the layouts.

```sh
python3 demos/linux/layout.py --arch x86_64 \
    --ref-tree ~/k/ref --badc-tree ~/k/badc \
    --cross-check 40 --report layout-x86_64.json
```

Both trees must carry debug info (`CONFIG_DEBUG_INFO_DWARF4`; badc emits
DWARF 4) and must hold the same source and the same configuration. The run
enforces the second part rather than assuming it: it refuses to compare
unless the two `.config` files agree once the toolchain identification
symbols -- `CONFIG_CC_VERSION_TEXT`, the `*_VERSION` strings -- are removed,
and unless the kernel releases match. Everything else, including the
`CONFIG_CC_HAS_*` capability answers, has to be identical, because a
difference there can move a member on its own and the comparison would then
measure the configuration instead of the compiler.

Three input modes:

* `--ref-elf` / `--badc-elf` compares two ELF files (a `vmlinux`, a `.ko` or
  a single `.o`).
* `--ref-tree` / `--badc-tree` compares `vmlinux` plus every `.ko` both
  trees built, paired by tree-relative path.
* `--replay --tree` compiles each unit of one tree twice -- the recorded
  Kbuild command plus `-gdwarf-4`, and badc's flag set plus `-g` -- and
  compares per unit. Both sides then run the same preprocessor surface over
  the same sources by construction, and the corpus is every translation
  unit rather than the types that reached `vmlinux`. Objects already in the
  scratch directory are reused, so a re-run costs only the extraction and an
  interrupted run resumes.

Reported per aggregate: total size, and per member the byte offset, size,
bit offset and bit width. Comparison is on those facts only; member type
spellings are recorded in the JSON but not compared, because the two
compilers name types differently and that is not an ABI difference. The
summary counts structs compared, identical, differing, and present on only
one side, and ranks differences by incidence -- the number of units defining
the type -- so a defect in a widely used struct sorts to the top. A name
that carries more than one layout within a single build (the kernel does
define distinct types under one tag name in different units) is counted
separately as ambiguous rather than reported as a difference.

`--report` writes the full result set as JSON; the summary is a ranked
excerpt of it. Exit status is 1 when any layout differs.

### Extraction

Layouts come from `llvm-dwarfdump --debug-info`, parsed directly. Its
one-attribute-per-line DIE dump keeps the DIE offsets, so a member's type,
its size and the anonymous aggregates the C11 member syntax produces can be
resolved exactly, and both DWARF bitfield encodings -- `DW_AT_data_bit_offset`
and the pre-4 `DW_AT_bit_offset` plus `DW_AT_byte_size`, which counts from
the other end of the storage unit on a little-endian target -- normalize to
one absolute bit offset. The parse holds one compile unit at a time, which
is what makes a 500 MB `vmlinux` tractable.

`pahole` and `gdb`'s `ptype /o` were the alternatives. Both render C rather
than DWARF: nested aggregates are expanded inline, so attributing an offset
to a member means re-parsing C, and neither can name an anonymous aggregate
at all. `pahole` is also absent from the x86_64 box and cannot be installed
there without root, so it cannot be the primary reader for a two-architecture
check.

`gdb` is used for what it is good for: `--cross-check N` re-reads N
aggregates with `ptype /o` and asserts the offsets agree with the parse.
That validates the reader and demonstrates that a debugger consumes badc's
DWARF at all. It costs about 2 ms per type, which is why it samples rather
than extracts.

`--self-test` checks the DWARF parse and the differ against a synthetic dump
and needs no toolchain, tree or kernel.

### What badc's DWARF carries

badc emits `DW_TAG_structure_type` / `DW_TAG_union_type` with
`DW_AT_byte_size`, `DW_TAG_member` with `DW_AT_data_member_location`, and
bitfield members with `DW_AT_data_bit_offset` + `DW_AT_bit_size`, which is
what the comparison needs.

What it does emit agrees: on the defconfig kernel every member both
compilers describe lands at the same byte offset, bit offset and bit width.
What bounds the check is coverage, and these are the gaps (TODO):

* Objects with static storage duration get no `DW_TAG_variable`, so an
  aggregate reachable only through a global gets no DIE and appears on the
  reference side only. That is why one-sided names are counted separately:
  a struct missing from badc's DWARF is a debug-info gap, not a match.
* A member whose type DIE the emitter did not write is dropped, leaving an
  aggregate that presents itself as a complete definition with members
  missing. This is the largest of the gaps.
* A forward-declared aggregate is emitted as a complete definition of size
  zero rather than carrying `DW_AT_declaration`.
* An array-of-aggregate member is described by its element type, and a
  function-pointer member by a pointer to the return type.
* Anonymous aggregates get synthesized `__anon_struct_<n>` names whose
  serial numbers are per-unit, so they match nothing across compilers or
  units; `layout.py` treats those names as unnamed on both sides.

The middle three move no member, so `layout.py` keeps them out of the
layout bucket: a member-size difference with every offset intact is counted
as a member type difference, and a member only one side describes is
counted as a coverage gap.

`buildcc.py` forwards the debug-info request: `-gdwarf-4`, `-gdwarf-5` and
the `-g<level>` spellings all map to badc's `-g`. A configuration that asks
for debug info and silently gets a kernel without it would leave `layout.py`
and any debugger with nothing to read. `CONFIG_DEBUG_INFO_NONE` passes no
such flag, so configurations that ask for none are unaffected.

## Scope

The sweep gates nothing; it is a measurement. A unit that gcc compiles and
badc rejects is a candidate gap; crashes and timeouts get their own buckets
and are bugs by definition. Passing units prove nothing about runtime
correctness; the hybrid build above is the link-and-boot check, and
`verify.py` is that check wired as a gate.
