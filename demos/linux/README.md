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
| `defconfig` (default) | 7.1.5, both arches | the tree's own `make defconfig` | the sweep |
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
preprocess-only version queries (`-E`) are delegated to the reference
compiler: badc has no standalone assembler driver and `.S` units are out of
scope, and the version gates encode a toolchain's bug history rather than a
capability. Those two delegations are the limits of the mode, and both are
reported in the probe log.

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

`buildcc.py` is a kbuild CC shim that turns the sweep's compile-only claim
into a linked, bootable kernel before coverage reaches 100%: badc compiles
every unit it can, gcc fills the known gaps, and the kernel's own link and
boot become the correctness test for the badc objects.

Named as `CC=`, the shim classifies each invocation. A kernel C compile
(`-c`, `-D__KERNEL__`, a `.c` source, not `-m16`/`-m32`) runs the real gcc
first with the original argv -- kbuild's object and `.d` bookkeeping stay
authoritative -- then, unless the source is on the fallback list, badc
recompiles the unit with the sweep's flag rewrite and replaces the object.
Everything else (probes, `-E`, `-S`, `.S` units, links, 16/32-bit units)
goes to gcc untouched, so the configuration and object population match
the reference corpus. A badc failure leaves gcc's object standing and is
recorded; since the fallback list is exactly the sweep's fail set, every
recorded failure is a compiler bug candidate.

```sh
cp <reference>/.config <tree>/ && make -C <tree> olddefconfig CC=$PWD/demos/linux/buildcc.py
BADC=<badc> BADC_FALLBACK=fails.txt BADC_MANIFEST=manifest.txt \
    make -C <tree> -j12 CC=$PWD/demos/linux/buildcc.py vmlinux bzImage
```

`fails.txt` holds one kernel-relative source or object path per line (the
`ok: false` entries of a sweep JSON report). Object entries discriminate a
compile context: a source also built into an isolated-link environment
(the EFI stub's `lib-%.o`) is listed by the object it becomes there,
leaving its other compiles to badc. The manifest gets one line per kernel
unit: `badc`, `fallback`, or `fail` plus the source and first diagnostic.
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

Objects must survive more than the link: with `CONFIG_OBJTOOL=y` kbuild
runs objtool (`--orc`, jump-label and static-call rewriting) over every
object, the vmlinux script asserts an empty `.got` (badc's GOTPCRELX
relocs must relax), and the boot exercises the asm-emitted metadata
sections (`__jump_table`, `.altinstructions`, `__ex_table`, `.smp_locks`).
A minimal initramfs whose `/init` prints a marker and powers off makes the
boot a pass/fail check under `qemu-system-x86_64 -nographic`.

## Regression gate

`verify.py` runs the hybrid build above with no fallback list and boots the
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

It fails on any unit badc cannot compile, any unit that fell back to the
reference compiler, any undefined reference at link, any boot that does not
reach the marker, and on a build that compiled fewer units than
`--expect-units` -- make skips units whose objects are current, so without a
floor a tree that rebuilt nothing would pass while testing nothing. For the
same reason the tree is rebuilt from clean by default.

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

## Scope

The sweep gates nothing; it is a measurement. A unit that gcc compiles and
badc rejects is a candidate gap; crashes and timeouts get their own buckets
and are bugs by definition. Passing units prove nothing about runtime
correctness; the hybrid build above is the link-and-boot check, and
`verify.py` is that check wired as a gate.
