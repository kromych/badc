# linux demo: kernel translation-unit sweep

Measures how much of a real Linux kernel build badc can compile today and
ranks what it cannot. Unlike the other demos this one is a gap-finding
harness, not a pass/fail smoke: it replays every C compile of a completed
gcc reference build against badc and buckets the failures by normalized
error signature, producing a ranked work list for kernel support.

## Pinned kernel

One pin, 7.1.10, for both architectures and every consumer: the sweep, the
link-and-boot gate, and the package gate. `setup.py` carries the tarball
sha256 and configures the tree with its own `make defconfig`, so the pin alone
reproduces the corpus and a version bump is one edit. CI's `kernel` job and
`scripts/validate_local_boxes.py` both reach it through `setup.py`, so local
and CI move together and neither can drift onto its own tree.

Smaller vendored configurations used to sit beside it for boot bring-up. They
were removed: a `.config` is only meaningful against the release it was
produced for, so each was a second pin to regenerate on every bump, and they
compiled a third to a half of defconfig's units. A mid-end regression that
left a statically dead call in the object -- undefined at the `vmlinux` link
-- reached the branch with four independent runs against them green, because
none of the units carrying it were in those configurations.

The package gate builds the same tree against the distributions' own
configurations instead (`packages.py --config vendor`, below), which is what a
distribution kernel actually is: 21701 to 26223 units on x86_64 and 23446 to
30552 on aarch64, against defconfig's 2953 and 10489.

## Run

```sh
cargo build --release --features full            # build badc
python3 demos/linux/setup.py --build             # fetch + configure + gcc build
python3 demos/linux/sweep.py \
    --kernel-dir demos/linux/.cache/linux-<version>  # replay against badc
```

`setup.py` downloads the pinned release from the vendor-deps mirror (sha256-verified),
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

`--arch` selects the target rather than following the host: kbuild is given
`ARCH`, and `CROSS_COMPILE` plus prefixed `--real-cc` / `--real-ld` defaults
when the target is not the host. A cross target whose `<triple>-` toolchain is
not on PATH is refused, naming the tools it wants, and a configured tree whose
architecture is not the one asked for fails at the configure step rather than
at the missing image target later. Measuring a target on a box of its own
architecture is still preferred: it is what CI and the pre-push gate do.

One tree at a time is written. `setup.py` and a building `verify.py` hold the
tree exclusively (`ktree.py`), and a second run is refused naming the first
rather than queued. Two runs sharing a tree delete each other's inputs -- a
second run's `make clean` removes the generated sources the first is
compiling, and the first reports a compiler that cannot read a source, at
whichever unit the two overlapped on. The gate names one cached tree per box,
so two runs meet there by default; `--kernel-dir` points a run at its own.

Requirements for the reference build: gcc, make, flex, bison, bc, and the
libelf + openssl development headers; for a cross target also the matching
`aarch64-linux-gnu-*` / `x86_64-linux-gnu-*` toolchain.

## How the sweep works

`sweep.py` walks the built tree for Kbuild `.cmd` files, keeps the kernel C
compiles (`-D__KERNEL__`, a `.c` source, `-c`), and rewrites each gcc command
into badc's flag set: the preprocessor surface is kept (`-D`/`-U`/`-I`/
`-iquote`/`-include`, `-isystem` folded into `-I`), the recorded optimization
level is honored (`-O1` and above become badc `-O`; `-O0` units -- e.g. ones
that `#error` under `__OPTIMIZE__` -- stay plain), and everything else is
dropped -- warnings, `-g`/`-std`, and the gcc code-model/hardening set
(`-mcmodel=kernel`, `-mno-red-zone`, `-fno-strict-aliasing`,
`-fpatchable-function-entry=`, ...) have no badc spelling. Each unit runs as
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

## Replaying one unit (`replay.py`)

The sweep rewrites each recorded command, which answers whether badc can
compile a unit at all. `replay.py` runs the recorded command *as recorded*
-- same shim, same flags, same working directory -- and asks a different
question: does the object the build would have produced hold what it
should. Whether a defect appears can turn on any flag in the recorded set,
so the rewrite is the wrong instrument for it.

Its subject is the object's undefined symbols, `--forbid` and `--require`
naming any symbol:

```sh
python3 demos/linux/replay.py --kernel-dir <built tree> \
    --unit fs/proc/array.o --forbid __scoped_seqlock_bug
```

The kernel spells a build-time assertion as a call to a declared-but-never-
defined function (`__compiletime_assert_*`, `__scoped_seqlock_bug`,
`__bad_udelay`) in a branch the compiler is expected to delete. When a fold
stops firing, the symbol reaches the object and nothing reports it until
the final vmlinux link -- a whole kernel build later. Stated as a `--forbid`
against the unit, the same claim takes seconds.

Repeat `--badc` to put several compilers over the same units, which is what
bisecting an emitted-code regression needs; each is a row:

```sh
python3 demos/linux/replay.py --kernel-dir <built tree> \
    --match generic_pt --forbid __compiletime_assert_73 \
    --badc old/badc --badc new/badc
```

`--require` guards a vacuous pass: a unit that failed to compile satisfies
`--forbid` too. With neither, the run reports each object's undefined
symbols and asserts nothing. Selection is `--unit <object>` or `--match
<substring>`, both repeatable.

The tree is never written: the recorded command names its object and its
dependency file inside it, and both are redirected into `--workdir` (a
temporary directory by default, and refused if it sits inside the tree).
That is not housekeeping. Compiling into a tree while a build is using it
swaps one object under that build, and the symptom is a plausible wrong
number rather than an error -- a link reporting failures that belong to the
compiler under test rather than the one being measured.

Prerequisite, as for the sweep: a completed build. A `.cmd` file exists
only for an object the tree has already built.

## Cost of a compile (`timing.py`, `timing_report.py`)

The sweep records whether a unit compiles; `timing.py` records what it cost.
It replays the same corpus and writes a JSON record per unit -- wall time,
user and system CPU and peak RSS from the child's own `wait4` rusage, plus
the input sizes the cost should scale against. `--stride N` samples every
Nth unit of the path-sorted corpus, which spreads the sample across
subsystems rather than truncating it; `-j1` keeps the per-unit numbers free
of contention.

```sh
python3 demos/linux/timing.py --kernel-dir <built tree> \
    --badc target/release/badc --stride 6 --mode both \
    --time-passes --reference gcc -j1 --out /tmp/cost.json
python3 demos/linux/timing_report.py /tmp/cost.json
```

`--mode both` times `-E` and `-c` over the same unit, so their difference
isolates the post-preprocessor cost with no instrumentation at all.

`--time-passes` adds the per-pass breakdown, read from the `pass:` lines a
`--features codegen_test` build writes to stderr under `BADC_TIME_PASSES`.
The timers do not cover every instruction the process executes, so the report
states the uninstrumented remainder as its own line rather than folding it
into a pass. A label marked `[nested]` times a region inside another timed
pass; it is listed among the costliest passes and kept out of the phase
totals, so the columns still add up.

`--reference cc` compiles each unit with a second compiler as well, on the
command kbuild recorded. That line carries work badc's rewritten flag set
does not do (warnings), so the
ratio is build cost against build cost rather than pass for pass; a
per-unit distribution and the units badc is furthest behind on come with it.

`timing_report.py` also fits cost against preprocessed and object bytes by
decile and reports a log-log slope, which is how a superlinear phase shows
itself. `--exclude <substring>` drops units from the aggregate: one
pathological unit can own most of a corpus and make every other share
unreadable.

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

The mitigation flags are forwarded verbatim rather than dropped
(`-mindirect-branch*`, `-mfunction-return=`, `-mharden-sls=`,
`-fcf-protection=`, `-mbranch-protection=`): each changes what the object
guarantees, and the flags are probed with `cc-option`, which the shim
delegates to the reference compiler -- so a flag the shim withheld would
leave the unit unprotected under a configuration that says otherwise.
`arch/arm64/kernel/pi/map_kernel.c` drops the shadow call stack on the
strength of `CONFIG_ARM64_PTR_AUTH_KERNEL`, so the flag behind it has to
reach badc. badc rejects the argument sets it does not implement, so a
spelling it does not cover fails the unit rather than building it
unprotected.

Every other flag on the command line is accounted for too. It is
forwarded, or listed in `UNSUPPORTED_*` -- badc has no equivalent and the
object's difference is measured or not ruled out, so each unit that
carries one reports `<flag> not applied` down the diagnostic channel and
the count lands in the build's summary -- or listed in `IGNORE_*` with the
measurement showing badc's object is the same without it. A flag on no
list fails the unit and names itself in the manifest. Silently discarding
what the shim does not recognize is what let `-fno-jump-tables` reach no
compiler while every `.o.cmd` recorded it: the probe behind it is
delegated to the reference compiler, so nothing in the build's own
artifacts disagreed. On the pinned `defconfig` the unsupported set is
`-fasynchronous-unwind-tables`:
that property is not in the built image whatever the configuration
says. The ftrace patch sites are forwarded:
`-fpatchable-function-entry=N,M` gives every function its NOP area and
its `__patchable_function_entries` record, and on x86_64 `-pg -mfentry
-mrecord-mcount` gives it the `__fentry__` call and the `__mcount_loc`
entry, in the forms gcc emits. `-ftrivial-auto-var-init=zero`
(CONFIG_INIT_STACK_ALL_ZERO) is forwarded and implemented;
`-fzero-init-padding-bits=all` is dropped with the measurement that an
automatic aggregate initializer already zero-fills the whole object,
padding included, before storing the members. `buildcc.py --self-test`
checks the classification and takes no tree; `verify.py --self-test`
runs it, which CI does on every push.

Everything else (probes, `-E`, `-S`, links, the host tools under
`scripts/` and `tools/`) goes to gcc untouched, so the configuration and
object population match the reference corpus. Linking is `ldshim.py`'s,
below, and is badc's throughout.
In particular `scripts/cc-version.sh` classifies the reference
compiler (`-E`), keeping `CONFIG_GCC_VERSION` at the reference
toolchain's value: identification follows the compiler that built the
objects, classification stays with the toolchain whose bug-history gates
the corpus was captured under (badc's claimed `__GNUC__`, 4.3.0, sits
below the kernel's gcc floor, 8.1.0).

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

badc's `--version` prints `GNU ld (badc <version>) 2.33.1`, which
`scripts/ld-version.sh` reads as a BFD-flavour linker at binutils 2.33.1 --
the level at which `arch/arm64/Kconfig` enables `ARM64_PTR_AUTH_KERNEL`, and
deliberately no higher, so nothing gated on a newer linker is claimed.
`CONFIG_LD_VERSION` records 23301 as a result. On the pinned release that is
the only `LD_VERSION` threshold in `(23000, 23301]`; the rest are 23600 and
above, and no x86 Kconfig reads the symbol at all.
`CONFIG_DEBUG_INFO_COMPRESSED_{ZLIB,ZSTD}` still disappear, because badc
rejects `--compress-debug-sections`.

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

## Building on macOS

badc emits `macos-aarch64` and `linux-aarch64` from one binary, so an Apple
Silicon host can build the kernel and kbuild's own host tools without a VM.
arm64 is the architecture this covers: it uses no objtool, the one host tool
with nothing to read a Mach-O toolchain's output.

What the host has to supply:

```sh
brew install make coreutils findutils gnu-sed grep gawk gnu-tar bison flex \
    musl-cross binutils openssl rpm dpkg
```

`/usr/bin/make` is GNU Make 3.81 and the tree refuses anything below 4.0, so
Homebrew's `gnubin` directories go ahead of the system ones; the same PATH
gives GNU `sed`, `find`, `stat`, `cp`, `install`, `readlink` and `tar`, which
`scripts/` and the packaging targets use with GNU-only options. `musl-cross`
provides `aarch64-linux-musl-gcc` 14.2 with its binutils: badc compiles and
links every kernel unit, and that toolchain answers the `cc-option` /
`ld-option` probes `buildcc.py` delegates, assembles the `.S` units badc's
assembler declines, and supplies `CROSS_COMPILE=` for `OBJCOPY`, `NM`, `AR`
and `STRIP`.

Five headers separate the host tools from a macOS SDK, and `hostcompat/`
carries them. `elf.h` is self-contained: the tree's own uapi ELF header cannot
stand in, because it defines `ELF64_ST_BIND` in terms of `ELF_ST_BIND` and
`scripts/mod/modpost.h` defines that back to `ELF64_ST_BIND`. `byteswap.h` and
`endian.h` sit on `<libkern/OSByteOrder.h>`. `gethostuuid.h` shadows the SDK
header of that name and goes with `-D_UUID_T`: `scripts/mod/file2alias.c`
reaches the kernel's `struct uuid_t` through `<linux/mod_devicetable.h>` while
the SDK typedefs `uuid_t` to `unsigned char[16]`, and the SDK's only user of
its own spelling is `gethostuuid()`. `hostcompat.h` is force-included and
supplies `O_LARGEFILE` and `copy_file_range()` for `usr/gen_init_cpio.c`.
`asm-generic/int-ll64.h` is the uapi fixed-width type header that
`tools/include/uapi/linux/types.h` includes by its system name, which
`scripts/sign-file` reaches under `CONFIG_MODULE_SIG`; Linux hosts have it
from their kernel headers, and the tree's own copy includes an
`<asm/bitsperlong.h>` the SDK lacks and nothing in it uses.

```sh
HC=$PWD/demos/linux/hostcompat
make -C <tree> ARCH=arm64 CROSS_COMPILE=aarch64-linux-musl- \
    CC=$PWD/demos/linux/buildcc.py LD=$PWD/demos/linux/ldshim.py \
    HOSTCFLAGS="-I$HC -include $HC/hostcompat.h -D_UUID_T" \
    DEPMOD=true \
    Image modules
```

`DEPMOD=true` covers `modules_install`: macOS has no `depmod`, and without it
`scripts/depmod.sh` warns and continues, so the installed tree carries modules
but no `modules.dep` / `modules.alias`. Both packaging formats build them on
the target instead -- the rpm's `%post` runs `depmod` directly, the deb's
`postinst` reaches it through `/etc/kernel/postinst.d` -- so the missing host
`depmod` costs nothing.

The tree must sit on a case-sensitive filesystem: it carries header pairs
that differ only in case (`netfilter_ipv4/ipt_ECN.h` and `ipt_ecn.h`, the
`xt_DSCP.h` / `xt_dscp.h` family), and a macOS volume in APFS's default
format keeps one of each pair at extraction, after which the build fails on
a missing struct member rather than on the filesystem. `packages.py` probes
its workdir and refuses a case-insensitive one, naming the `hdiutil` sparse
image that provides a case-sensitive volume without repartitioning.

`packages.py` runs here too and sets that environment itself on a macOS
host: `ARCH`, `CROSS_COMPILE` (derived from `--real-cc`, which defaults to
the musl-cross `<arch>-linux-musl-gcc` for `--arch` there, as `--real-ld`
does to its `ld`), `HOSTCFLAGS` with `hostcompat/`, `DEPMOD=true`, the
`gnubin` directories ahead of the system ones and Homebrew's binutils after
them -- so `readelf` is found while Apple's `strip` and `ar` keep shadowing
GNU's -- and `PKG_CONFIG_PATH` pointing at Homebrew's OpenSSL for the
signing host tools `CONFIG_MODULE_SIG` builds. Every `make` it runs is
resolved on that PATH, so the system's GNU Make 3.81 is never the one used.

```sh
python3 demos/linux/packages.py --arch aarch64 [--distro fedora] \
    --linker badc --tarball <linux-7.1.10.tar.xz>
```

It selects `hvf`, which is what makes the gate usable on a Mac: booting the
stock cloud image to ssh takes 20 s under `hvf` against 91 s under `tcg`, and
the install-and-reboot cycle carries the same factor.

## Regression gate

`verify.py` runs the build above with no fallback list and boots the
result, as a pass/fail check rather than a measurement:

```sh
python3 demos/linux/initramfs.py -o initramfs.cpio.gz
python3 demos/linux/verify.py --kernel-dir <writable tree> \
    --initramfs initramfs.cpio.gz --expect-units 2800 --report verify-x86_64.json
```

`initramfs.py` builds the boot image: a single static `/init` that prints the
marker and then requests a reset, which `-no-reboot` turns into an emulator
exit, so a boot ends when userspace is reached rather than when the timeout
expires. It is freestanding -- its own entry and system-call stub, no C
library, no loader -- and badc builds it for the boot's architecture
(`--arch`, the host's by default), so an aarch64 boot from an x86_64 host
needs no cross toolchain. `--cc` builds it with a host or cross C compiler
instead, which keeps the probe outside the compiler under test. Either way
the executable is inspected before it is packed: one for another machine, or
one that asks for a loader, is refused with the reason rather than reported
by the kernel as no working init a boot later.

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
`$(LD)` -- `GNU ld (badc <version>) 2.33.1` under `--linker badc`, the real
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

What badc wrote on the compiles and links that *succeeded* is measured
rather than gated. A warning comes with `rc == 0`, so the shims append it
to `$BADC_WARN_LOG` -- `warnings-<arch>.txt` in the work directory, one
line per diagnostic tagged with the unit -- and the gate reports a count
per cause, the message with its site folded out. A defconfig x86_64 build
writes tens of thousands of lines under about 130 distinct causes; every
cause is listed however rare, so one warning among thousands stays
visible. `diags.py <log>` prints the same summary for a log already
produced, and `packages.py` reports it the same way.

Per-arch differences (target triple, image path, qemu machine and console)
are a table in the script; `--arch` selects the row and defaults to the host.
Run it on the box whose corpus matches, and against a copy: the build writes
into the tree.

Two parameters depend on the corpus rather than the architecture and have to
be passed. `--expect-units` is a floor on the unit count of the configuration
under test: at defconfig the sweep tree measures 2921 (x86_64) and 4434
(aarch64), so set it just under the count of what is being built. `--rdinit`
is whatever the initramfs installs, `/init` by default.

`--qemu` selects the emulator; `--qemu-args` adds arguments to the boot. An
emulator built out of tree has no data directory, so it needs `-nic none`:
the default NIC would look for a boot ROM there and refuse to start without
it. `--no-build` skips the build and boots the image already in the tree,
which is how a boot is repeated without a twenty-minute rebuild.

### The unpack boot

The marker image is 1.4 MB and the kernel unpacks it in about 0.14 s, so a
decompressor whose cost doubled passes those boots unnoticed. After them the
gate boots once more with a large image: the marker archive, uncompressed,
followed by 250 MB of deterministic content (`unpack.py`) compressed with the
method the configuration decompresses -- zstd where `CONFIG_RD_ZSTD=y`, as
defconfig sets it, gzip otherwise -- 47 MB under `zstd -19`. The content is
slices of a pseudo-random pool interleaved with text-like literals, so it
compresses about 5:1, near a distribution initramfs, and exercises both the
match and the literal paths of the decoder. The kernel checks the frame's
content checksum, so a decompressor that produces wrong bytes fails the boot.
The payload archive is built once, in some fifteen seconds, and kept beside
the kernel tree (`--payload-dir`), since compressing it costs more than
booting it.

The boot is held to every check the marker boots are, and to the time the
kernel spends between `Unpacking initramfs...` and `Freeing initrd memory`,
read from the console's printk timestamps and reported in the verdict line
and the report. It fails over `--max-unpack-seconds`, which defaults to the
architecture's entry in `UNPACK_BOUNDS` in `verify.py` for the zstd payload
(aarch64: 7.5 s, between the reference compiler's 5.1 s and the 9.8 s of the
decompressor regression the bound is there to catch, both measured on the
box); `0` reports only, and an architecture without a measured figure is
reported only. `--no-payload` skips the boot.

### The nested KVM boot

`--nested-kvm` boots once more, under the host's KVM with `-cpu host`
(`-M virt,virtualization=on` on aarch64), and the kernel under test is then
the hypervisor. Everything the gate controls in that boot is badc's. The
initramfs carries the badc-built `qemu-system-<arch>` the qemu demo
produces (`--guest-qemu`, the binary CI's kernel job boots under) with the
shared libraries `ldd` lists (13 on the x86_64 box) and its loader at the
path its `PT_INTERP` names, the ROM set the demo's `setup.py --pc-bios`
fetches (`--guest-firmware`; for a `-kernel` boot the emulator opens
`bios-256k.bin`, `linuxboot_dma.bin` and `kvmvapic.bin`, and nothing on
aarch64), the KVM modules this build made under `arch/<arch>/kvm` with the
modules they depend on ahead of them, the kernel image itself and the
marker initramfs (`initramfs.py --guest-emulator`). After its checks
`/init` loads the modules through `finit_module`, mounts devtmpfs, reports
the virtualization extension `/proc/cpuinfo` lists (`BADC-NESTED
cpuinfo=vmx`) and whether `/dev/kvm` opens, and runs the emulator on the
image with the marker initramfs under `-accel kvm`; the guest's console
arrives on the outer one between `BADC-NESTED-GUEST-BEGIN` and
`BADC-NESTED-GUEST-END exit=<n>`, so the log holds both boots and each is
held to the marker checks.

The verdict is one of three. It is skipped, not passed, where the host has
no writable `/dev/kvm`, where the emulator starts no machine because the
host's KVM offers no nesting (the aarch64 box, an Apple M2 under Asahi
Fedora 44 with qemu 10.2, answers `host kernel KVM does not support
providing Virtualization extensions to the guest CPU`), or where the guest
is given nothing to nest on -- `/proc/cpuinfo` lists neither `vmx` nor
`svm` on x86_64, which is what `kvm_intel.nested=0` on the host produces,
or the CPUs started at EL1 on aarch64. It fails where the extension is
offered and `/dev/kvm` still never appears, where the guest never reaches
both markers or its emulator never exits, and where the outer boot fails
any check the other boots are held to. Everything else is a pass, and the
report carries what `/init` reported and the guest's own boot record.

x86_64 `defconfig` builds no KVM at all, so with `--build` the flag sets
`CONFIG_KVM`, `CONFIG_KVM_INTEL` and `CONFIG_KVM_AMD` to `m` before the
build (`CONFIG_VIRTUALIZATION` is already set), adds the `modules` target,
and fails the run if `olddefconfig` does not keep them; arm64's KVM is a
bool symbol, built in at `defconfig`, so nothing rides as a module there.
A `--no-build` run whose tree carries neither `kvm_init` in `System.map`
nor a module under the kvm directory skips with that reason. The step is
off by default and is not in CI: the runners expose no `/dev/kvm`, and
nested KVM under TCG has no VMX to nest on.

Measured on the x86_64 box (i7-8700, Fedora 44) with the distribution's
own kernel as the outer and its KVM modules loaded by `/init` -- the test
vehicle, no badc kernel with KVM having been built there yet -- the demo's
badc-built qemu 11.0.2 carried inside and the box's badc-built 7.1.10
image as the guest: the initramfs is 31.6 MB compressed (36 MB emulator,
7 MB of libraries, 20 MB image) and the whole boot, guest included, takes
6 s.

### Text sizes

The build's `System.map` is measured after the link: the largest text
symbol and the count of functions over 4 KiB, against the architecture's
budgets in `TEXT_BUDGETS` in `verify.py`. An inliner that duplicated a
callee's body at every site moved aggregate text by 8% while single
functions moved 18-34x, so a budget on the total cannot separate the two
and the budget is on the distribution. The map records no sizes, so a
symbol's size is the gap to the next address any symbol holds, one name per
address, with the linker labels of `asm-generic/sections.h` left out and a
gap of a megabyte or more read as a section boundary; weak symbols are
functions and count. `scripts/function_sizes.py` sizes a map the same way
and reports two ratios over an object set; this is the linked image's own
count. aarch64's badc-built defconfig map measures 84530 functions, largest
101612 bytes (`hidinput_configure_usage`, 21192 in the gcc-built
distribution kernel on the same box) and 451 over 4 KiB; the budgets are
131072 and 520. An architecture without a budget is reported only.

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

A tree with `# CONFIG_RANDOMIZE_BASE is not set` boots at its link address,
and the checks above stand down. A machine that supplies no
`/chosen/kaslr-seed` (`-M virt,dtb-randomness=off`) degrades to unpinned boots
with a line saying so.

CI runs this against the pinned release configured with the architecture's
own `defconfig`, and boots the result under the emulator the qemu lane
compiles and links with badc. Both architectures are gated.

## Distro packages (packages.py)

`verify.py` boots a marker initramfs; `packages.py` runs the rest of the road
a kernel travels in a distribution. It builds the pinned release with badc
compiling every kernel C unit (the buildcc.py contract: zero fallbacks),
packages it with the kernel's own targets -- `bindeb-pkg` or `binrpm-pkg`,
following the distribution -- installs the package in a stock cloud image
(Debian stable on x86_64, Fedora on aarch64, or the distribution `--distro`
names: `debian`, `ubuntu`, `fedora`, each on both architectures) under qemu,
and validates the reboot: the package scriptlets (depmod, initramfs
generation via initramfs-tools or dracut, the boot-loader entry), systemd
reaching multi-user, udev-bound devices, on-demand `modprobe` of packaged
modules, an untainted kernel, a clean dmesg, and disk/network I/O. Before
the install the same probes run against the image's stock kernel, so every
measurement has a baseline from the same userspace.

"Clean dmesg" at boot is the `DMESG_SEVERE` vocabulary: the oops shapes, plus
the driver-reported faults -- the SCSI sense keys a working device does not
produce, block I/O errors, filesystem corruption reports and PCI AER. The oops
shapes alone were not enough: a controller answering every command with `Sense
Key : Hardware Error` passed eight patterns, a taint word of 0 and a systemd
that came up.

Everything the boot logged at KERN_ERR or worse is also collected and diffed
against the stock boot of the same image, and the run prints the lines the
stock boot did not produce -- reported, not asserted. The baseline is a
different kernel version, and a version gap introduces error lines of its own:
on the Fedora 44 image a clean 7.1.10 adds three (a driver registered twice, a
platform feature 6.19.10 did not probe for, an SELinux compatibility notice).
Inside the exercise stage the comparison has no such gap -- the same kernel,
seconds apart -- so there each task's own log window fails the task on
*anything* at KERN_ERR, read from `dmesg -x`'s decoded severity rather than
from a pattern. That is the check with no vocabulary in it, and it is why the
storage step runs its I/O inside one task.

The devices are chosen, not assumed. `--vm-disk-bus` attaches the system
disk and the cloud-init seed through `virtio` (the default), an emulated
`nvme` controller, an `ahci` SATA controller, or a `megasas` / `lsi53c895a`
SCSI HBA, and `--vm-nic` selects `virtio-net-pci` (the default), `e1000e`,
`e1000`, `rtl8139` or `igb`. The paravirtual pair exercises two drivers; the
emulated models exercise the controller drivers a distribution kernel ships
for real hardware -- `nvme`, `ahci` plus the SCSI disk layer, `megaraid_sas`,
`sym53c8xx`, `e1000e` -- as compiled by badc. After the reboot the run reads
the driver chain under the root disk's `/sys/class/block/<dev>/device` and the
NIC's driver link, and fails unless the selected models' drivers are the ones
bound; a kernel that fell back to another path, or whose initramfs found no
driver, is reported rather than passed. The system disk carries
`bootindex=0` on the emulated buses, because the firmware otherwise probes
the controllers in its own order and can try the seed image first.

The guest boots under EFI, as the machines these packages are meant for do.
`--vm-firmware auto` (the default) takes the first firmware installed on the
host -- OVMF under `/usr/share/edk2/ovmf` or `/usr/share/OVMF` on x86_64,
AAVMF or `QEMU_EFI.fd` on aarch64 -- and falls back to SeaBIOS on x86_64,
with the reason logged, when none is found; `uefi` and `bios` state the
choice and fail when the host cannot meet it. The code image is mapped
read-only and the variable store is a per-run copy, which the firmware
writes. An x86_64 EFI guest runs on `q35`, the machine OVMF supports; the
SeaBIOS fallback keeps qemu's `i440fx` default and cannot boot an `nvme`
system disk once the guest has 3584 MiB or more -- at qemu's 4 GiB memory
split that firmware writes nothing to the console at all -- so a run asking
for both is refused up front instead of timing out on a silent machine.
A boot image that faults leaves EDK2's exception dump on the console and the
machine stops there; the run reports the dump when it appears rather than
waiting out the ssh timeout.

TODO: the badc-built x86_64 bzImage faults in its own EFI stub when the boot
loader starts it. EDK2's dump identifies the faulting image as that bzImage,
by the PE entry point it reports. The same kernel boots through the BIOS
path and a gcc-built kernel boots the same EFI chain, so under UEFI the badc
kernel reaches userspace only once that is fixed.

Naming a tarball is optional. With neither `--tarball` nor `--tarball-url`,
the pinned release is fetched from the vendor mirror and checked against its
recorded sha256 -- the same verified path `setup.py` uses -- so the shortest
useful invocation is:

```sh
# packages only: fetch, configure defconfig, build, package
python3 demos/linux/packages.py --arch x86_64 \
    --phases config,tree,build,package
```

That leaves the `.deb` or `.rpm` in the work directory. Dropping `--phases`
runs the whole road instead -- install into a stock cloud image, reboot into
the badc kernel, and exercise it -- which additionally needs qemu and the
image, fetched the same verified way.

To build a kernel other than the pinned one, give the URL and its digest;
an unverified download is refused rather than trusted:

```sh
python3 demos/linux/packages.py --arch x86_64 \
    --tarball-url https://.../linux-<version>.tar.xz \
    --tarball-sha256 <sha256>
```

The distribution's own configuration rather than `defconfig`, reported to a
file:

```sh
python3 demos/linux/packages.py --arch x86_64 --distro fedora \
    --tarball <linux-<version>.tar.xz> --config vendor \
    --report packages-x86_64.json
```

### Where the configuration comes from

A distribution kernel is its configuration as much as its source, so the gate
builds the distribution's own rather than `defconfig`. `--config vendor` takes
it off the `vendor-deps` release, held to a pinned sha256 the same way the
cloud image is, and caches it under `.cache/configs`; the asset is named
`kconfig-<distro>-<arch>-<sha8>.config`, the same convention
`scripts/vendor_deps` uses everywhere. Four are published, one per
(distribution, architecture) pair the package matrix builds:

| asset | options set |
|---|---|
| `kconfig-fedora-x86_64` | 8048 |
| `kconfig-fedora-aarch64` | 9197 |
| `kconfig-ubuntu-x86_64` | 10289 |
| `kconfig-ubuntu-aarch64` | 12605 |

`--config from-vm` is where those bytes come from: it boots the pinned stock
image and copies `/boot/config-$(uname -r)` out of it, which is the one source
that cannot drift from the kernel the distribution ships. It is how the asset
is refreshed when an image pin moves -- run it, then add the new digest to
`DISTROS` in `packages.py` and to `scripts/vendor_deps/build_bundle.py`, and
publish. A package build itself no longer boots a VM to read a config.

`--config <path>` names an ad-hoc file, and without `--config` the tree's own
`defconfig` is built.

The build's links are badc's too by default, through `ldshim.py`, and the run
fails on any link the shim could not make; `--linker reference` takes GNU `ld`
instead, which is the contrast run that separates a compiler defect from a
linker one. Boot-loader installation is the one route that runs the 16-bit
`setup.elf` from a disk rather than from qemu's `-kernel`, so it is where a
badc-linked boot image is exercised end to end.

Phases -- `config` (resolve the configuration), `tree` (extract + configure),
`build` (hybrid make), `package`, `vm` -- are idempotent and `--phases`
selects a subset. Defconfig, which is what CI builds, is 2953 units on x86_64
and 10489 on aarch64 at the 7.1.10 pin, kernel plus modules; a distribution
configuration is several times that. A fresh qcow2 overlay keeps the base
image pristine per run. On an rpm host the Debian
packaging tools (dpkg, dpkg-dev, debhelper) are provisioned under
`--deb-tools` from the host's own mirror via `dnf download` + rpm2cpio
extraction; nothing is installed system-wide, and `dpkg-buildpackage` runs
with `-d` plus a scratch admindir because the build host's package database is
not what the produced package depends on. `rpmbuild` runs with
`--without debuginfo` and `INSTALL_MOD_STRIP=1`: the gate packages the kernel,
not its debug info. The provisioned prefix is stamped with a digest of the rpm
file names `dnf` resolves the tool set to, so a prefix built against a package
set the mirror has moved past is rebuilt rather than reused.

### Exercising the booted kernel

Booting proves the kernel reaches userspace over one storage and one network
path. A distribution kernel ships several thousand modules and the boot loads
a few dozen. The stage that runs after the boot probes, inside the badc
kernel, drives the code the boot never reaches. Its steps are data -- a name,
the guest work and the rule that reads the outcome -- so the set extends
without touching the driver; each step lands in the report under
`vm.exercise` and a failing one appends to the run's `failures`.
`--exercise-steps` selects a subset of
`sockets,storage,crypto,modules,kunit,fs,dmesg`.

`sockets,storage,crypto,kunit,dmesg` -- the gate set -- run on every boot; the
boot probes otherwise judge a kernel by what the guest's own init reported
about itself, which is a property of the image. Two defects reached the branch
that way. An AF_VSOCK bind that returned `EINVAL` on every socket surfaced
only because one distribution's systemd generated a unit for the family and
the other's did not. A storage controller that answered every `TEST UNIT
READY` with a hardware error surfaced only as sense data in the console log,
which no pattern matched. In both cases `taint` was 0, systemd came up, and
the boot was recorded as clean. `--exercise` adds `modules` and `fs`, which
cost minutes; `--no-exercise-gate` drops the stage entirely, and a boot that
skips it has no cover on the subsystems the probes never reach.

`storage` writes a known payload to the root filesystem with direct I/O, reads
it back after dropping the caches and compares it against the source digest,
then reads the same blocks off the raw device twice. Each read is direct I/O
first; where `dd` fails or delivers fewer bytes than the payload, the read is
repeated buffered and the verdict notes it with `dd`'s message, since the
buffered read still proves the data reached the device. A digest is compared
only once the byte count matched, so an empty or short read is reported as a
read failure, never as a mismatch. The digests are half of it: the step runs
the I/O inside one task so the kernel log window that I/O produced is read as
part of the verdict, which is where a controller that completes transfers and
reports hardware errors is caught. `--exercise-storage-mb` sizes the payload.

`sockets` creates a socket for every protocol family the configuration builds,
loading the modules that back it first -- `af_vsock.c` declares no `net-pf-40`
alias, so nothing autoloads `vsock` and a family reached only through autoload
would go unprobed. Where a family binds without a peer or a device it is bound
and listened on, and where a local transfer is reachable it carries a payload:
AF_UNIX over a socket file, AF_INET and AF_INET6 over loopback (stream and
datagram), AF_NETLINK through an `RTM_GETLINK` dump read back to the
`NLMSG_DONE`, AF_ALG through a sha256 transform compared against hashlib,
and AF_VSOCK bound on an auto-assigned and on a reserved port, listened on,
and its local CID read from `/dev/vsock` the way `systemd-ssh-generator` reads
it. What a family cannot reach without external state is reported as
`uncovered` rather than counted: AF_PACKET is created and bound to `lo` and no
frame is captured, and AF_VSOCK carries no payload -- on one gcc-built 7.1.10
kernel a loopback round trip completed under a bare initramfs and was reset in
a Fedora guest, so which transport carries a connection is guest module state,
not a property of the kernel under test.
AF_VSOCK is driven through libc rather than through the guest Python's socket
module, since `socket.AF_VSOCK` support varies by build and a probe that
skipped the family on that basis would leave exactly the hole it closes.

`crypto` loads every module under the kernel's `crypto/`, `arch/*/crypto/` and
`lib/crypto/` trees, forces the registration self-tests when the configuration
keeps them (`CONFIG_CRYPTO_SELFTESTS`, plus a `tcrypt` mode sweep -- tcrypt
returns an error on completion by design, so its verdict comes from dmesg),
scans the whole kernel log for testmgr's own verdicts -- a built-in algorithm
is tested when it registers, which is during the boot, before the stage runs --
and then checks the implementations against references. The check reaches each
registered implementation through AF_ALG *by its driver name*, so `sha256-avx2`
and `sha256-generic` are separate subjects rather than whichever the priority
ordering would select. Hashes are compared against hashlib where the standard
library implements the algorithm; the remaining hashes, the skciphers and the
AEADs are compared against the generic implementation registered under the same
algorithm name, with a decrypt round trip on top. This is the step that carries
the coverage on most configurations: `CONFIG_CRYPTO_SELFTESTS` depends on
`CONFIG_EXPERT`, so Ubuntu 26.04 and the tree's own `defconfig` both leave the
in-kernel tests out, and `tcrypt` with them. It is also finer than they are: a
self-test failure names an algorithm, a mismatch here names the implementation
and the reference it disagreed with. A rejected round trip is a mismatch as
well: EBADMSG from the decrypt of an implementation's own ciphertext is its
tag failing to verify, and fails the step. Only a rejection before the
implementation is driven -- the bind, the key length, the tag length -- is
filed as unusable, which is reported and does not fail it.

`modules` loads every module in the kernel's module tree once, one at a time
under a per-module timeout, and classifies each outcome. A module that
declines because the hardware is absent is expected and counted; a module that
faults, hangs, fails on a missing symbol or sets the oops or machine-check
taint bit is a finding. Modules already loaded when the sweep starts are never
unloaded, so the sweep cannot take the network or the root disk down; the test
suites are left to the `kunit` step, since a suite loaded here runs a second
time and collides with its own boot-time registrations; the rest are pruned
every 250 loads, which bounds memory and exercises the module exit
paths. The report carries the counts -- built, attempted, loaded, refused,
failed hard, still resident -- and the taint word on both sides of the sweep,
with the refusals named by errno and the hard failures by module.
`--exercise-modules N` strides evenly over the sorted module list instead of
loading all of it, keeping every subsystem prefix represented.

`kunit` loads the in-kernel suites and reads their KTAP output from debugfs and
dmesg, failing on any `not ok`. It records a skip when the configuration has no
`CONFIG_KUNIT`; the Ubuntu 26.04 configuration does not set it. A kernel that
also sets `CONFIG_KUNIT_FAULT_TEST` oopses on purpose during that suite, which
the dmesg gate then reports; leave it off for a gate run.

`fs` is a stress test over the block stack, not a smoke test. Each instance
puts a filesystem on a loop device over a sparse file -- which also exercises
`loop.ko` -- with the loop's logical block size varied between 512 and 4096
across instances, because the sector-size paths are distinct code. Four
concurrent instances of each job kind then run for `--exercise-fs-seconds`:
rotating-block `dd` writes with `conv=fsync`, small-file
create/rename/hardlink/unlink churn, a tree copy with `find`/`grep` sweeps and
`rm -rf`, sparse writes with `O_DIRECT` reads, and one `fsstress` or `fio` job
when the image has either. The writers hold back above 80% full: a filesystem
the jobs drive to ENOSPC can end the instance unmountable -- ntfs3 cannot
extend `$MFT` once it is full -- and that says nothing about the kernel. Data is verified rather than assumed: a file set is
written from a seed held in tmpfs, its digests are computed from that seed and
never from the filesystem, and
after the workload the caches are dropped, the filesystem is unmounted and
mounted again, and every digest is checked. Silent corruption is what a
codegen defect on a copy or checksum path produces, and no dmesg scan reports
it. Each instance ends with the filesystem's own check-only fsck, where a
non-clean result is a hard failure.

The matrix covers ext4 (4096- and 512-byte logical blocks), xfs, f2fs, vfat,
exfat, ntfs3, udf, and squashfs, erofs and iso9660 as read-only images built
from a staging tree. It deliberately includes the checksum-heavy
configurations, which route file data through the same kernel crypto code the
crypto step tests directly: btrfs with `--csum crc32c`, `--csum xxhash`,
`--csum sha256` and `--csum blake2`, a btrfs instance with
`compress-force=zstd`, and ext4 and xfs with metadata checksums on. dm-crypt
adds two LUKS2 instances (`aes-xts-plain64` and `aes-cbc-essiv:sha256`) and md
adds a raid1 instance
over the stage's two spare disks. An instance the running kernel has no
option for, or whose `mkfs` is missing or refuses, is recorded as a skip with
the reason rather than as a failure; a tool killed by a signal is a failure
instead, since a crashed `mkfs`, `cryptsetup` or `mdadm` is evidence rather
than a missing feature; `--exercise-tools auto` first installs the
missing tools from the guest's own package mirror, and `skip` leaves the image
as it is.

The stage stops at the first kernel fault: once a task's kernel log carries an
oops or a BUG, the tasks after it record a skip naming that fault instead of
running. Nothing the kernel reports afterwards is attributable to the work that
provoked it, and a wedged subsystem turns the remaining tasks into timeouts --
one that faulted here left a `mount` dead with interrupts disabled and the
global `sync` in the next instance blocked behind it. `--exercise-steps` and
`--exercise-fs` are how a run deliberately continues past a known fault.

`dmesg` is one consolidated severity scan over everything the stage produced,
by the `DMESG_SEVERE` vocabulary: the follower holds the boot log as well, and
the boot is what the packages probes judge against the stock baseline.
The stage runs a `dmesg -w -x` follower into a file for its whole duration
(`-x` decodes the severity each per-task window is read by), because
the sweep produces far more lines than the ring buffer holds and a wrapped ring
drops exactly the early fault the sweep is looking for. The existing core-dump
sweep runs after the stage, so a userspace core produced by it is collected
too.

The report carries the wall-clock of every task and every step, so the gate
set is chosen against measurement rather than by feel: the four gate steps
cost 20.1 s together on the x86_64 box against the Fedora 44 image (sockets
1.6, crypto 12.3, kunit 2.1, dmesg 0.6, plus 3.5 s of stage setup -- the
configuration read, the guest scripts, the dmesg follower), against a vm phase
that spends minutes installing the package and booting twice. The two steps
behind `--exercise` cost minutes on their own. Measured on that box (KVM, 2
vCPUs, 4 GiB guest), the `crypto`, `modules`, `kunit`, `fs` and `dmesg` figures
against the Ubuntu 26.04 image and a badc-built kernel installed into it:

| step | cost | what it covered |
|---|---|---|
| `sockets` | 1.6 s | 7 families created, bound and driven. `socket()` alone would not have caught the AF_VSOCK defect: creation succeeded and `bind` returned `EINVAL` |
| `storage` | 3-6 s | 64 MiB written and read back against the source digest, plus two raw-device reads, with the kernel log window read as part of the verdict |
| `crypto` | 2-3 s | 53 to 153 algorithms registered, 39 to 54 implementations checked through AF_ALG; a 10-mode `tcrypt` sweep adds 1.5 s where `CONFIG_CRYPTO_SELFTESTS` is on |
| `modules` | 130 ms per module | ~15 min extrapolated over Ubuntu's ~6800-module tree; `--exercise-modules N` bounds it |
| `kunit` | 1 s | 171 cases from `kunit_test` and `kunit_example_test`; a skip where `CONFIG_KUNIT` is off |
| `fs` | 420-590 s for 18 instances | 2 s (erofs) to 39 s (LUKS aes-cbc-essiv) each at `--exercise-fs-seconds 15`, the upper figure with a kernel build running alongside |
| `dmesg` | 1 s | one scan over the stage's whole kernel log |

The stage attaches `--exercise-spares` thin qcow2 disks (2 by default) after
the system disk and the seed, on the same bus; the system disk keeps its bus
and its `bootindex=0`. It also raises `--vm-mem` to 4096 when it is lower,
since the sweep holds every loaded module resident between prunes.
### Building the kernel on the badc kernel (the `selfhost` phase)

An installed kernel that boots and passes probes has been asked for minutes of
uptime and a handful of syscalls. `--phases ...,vm,selfhost` asks it for a
kernel build: once the guest is running the badc kernel, the phase builds the
kernel again, with badc, inside that VM. The build is the load -- page cache,
filesystem, scheduler, memory pressure and thousands of process spawns -- and
the kernel is what is measured.

The phase runs inside the vm phase rather than after it, because its
precondition is a booted badc kernel and re-reaching that state costs a second
install and reboot. It is off by default, so the gate's runtime is unchanged;
naming it without `vm` is refused.

What it does, in order:

* On the stock kernel, before the install: installs the distribution's build
  and packaging tool set (`build-essential`, `bc`, `bison`, `flex`,
  `libssl-dev`, `libelf-dev`, `debhelper` and the rpm equivalents) from the
  image's own mirror, then pushes in badc, `buildcc.py`, `ldshim.py` and the
  pinned kernel tarball. Nothing the badc kernel then runs needs the network,
  and `badc --version` is required to identify badc from inside the guest
  before anything else starts.
* On the badc kernel: extracts the tarball, configures, and runs make with
  `CC=buildcc.py` under the same environment the host build uses -- the two
  differ in nothing but the machine. `--selfhost-scope` sizes it: `units`
  (the default) builds the built-in objects of `init/ kernel/ mm/ lib/ fs/`
  from the tree's own `defconfig`, `image` builds the kernel and its modules,
  and `package` runs `bindeb-pkg` / `binrpm-pkg` and checks the archive
  listing for a kernel image. `--selfhost-config host` uses the host build's
  configuration instead of `defconfig`.
* The build runs detached and is polled over short ssh connections, so a
  kernel that stops scheduling is reported as a guest that stopped answering
  rather than stalling one connection for the whole build. Each poll records
  the manifest line count, load and used memory; the peaks are in the report.

What it fails on:

* Anything the kernel logged while building. A marker is written to
  `/dev/kmsg` on either side of the build, so the window belongs to the build
  and not to the boot; `BUG:`/`Oops`/`Call Trace`/`UBSAN:` and `WARNING:` in
  that window, an OOM-kill record, or a taint value that moved are each a
  failure. A wrapped ring buffer is a failure too: no window is attributable.
* Units. The in-guest `BADC_MANIFEST` is pulled back to
  `<workdir>/selfhost-manifest-<arch>.txt` and read with the same reader the
  host build's manifest uses. Any `fail`, fewer badc units than the scope's
  floor, and -- the point of the comparison -- any unit badc compiled on the
  build host and could not compile in the guest. The two corpora differ, so
  only units both runs reached are compared; a difference there is the kernel
  under the build, not a corpus difference.
* Output. A sample of the objects badc just produced is deleted and rebuilt,
  and the bytes have to repeat. badc is deterministic for a fixed command
  line, so a difference is the kernel losing or corrupting what the compiler
  wrote.
* Core dumps, swept as `selfhost` with the same collector the other phases
  use.

The VM is sized for the work: with the phase on, the defaults become 4 vCPUs
(bounded by the host's), 6 GiB and a 40 GiB disk instead of 2 vCPUs, 2 GiB and
12 GiB. Every one of those is still an explicit flag.

`packages.py --self-test` checks the phase's pure helpers -- the scope-to-target
mapping, the build script, the kernel-log window split and the unit comparison
-- and takes no tree, host or guest.

#### Measured cost

x86_64 `defconfig`, Ubuntu 26.04 cloud image, kvm on a 12-core host that was
running another kernel build throughout, guest at 4 vCPUs and 6 GiB:

| step | wall |
|---|---|
| tool install and push (stock kernel, once) | 50 s |
| tarball extract in the guest | 25 s |
| `make defconfig` in the guest | 21 s |
| `units` build, 800 units, `-j4` | 919 s |
| rebuild sample, log window, core sweep | 60 s |

That is 17 min on top of the vm phase's own 3 min, for a default that covers
800 of the 2953 units the whole `defconfig` corpus compiles -- `init/`,
`kernel/`, `mm/`, `lib/` and `fs/`, built-in and modular. The same host
compiled all 2953 in 570 s at `-j6`, so the guest runs at roughly a sixth of
the host's rate per job: `image` and `package` scopes cost about an hour of
in-guest build at this shape, which is why they are not the default.

The kernel's side of that run: 0 severe and 0 warning lines in the build's log
window, no OOM record, taint 0 before and after, no core dumps, 21.9 M page
faults and 78 major faults, peak load 4.38 and peak 628 MiB in use. No unit
regressed against the host build, and all 8 rebuilt objects reproduced byte for
byte.

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

Neither architecture builds one yet. Surveyed at the 7.1.10 pin with
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
    --tarball-url https://cdn.kernel.org/pub/linux/kernel/v7.x/linux-7.1.10.tar.xz \
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
Without a pin, a red gate is not attributable to a badc change. An image the
release does not carry yet is fetched from the `upstream` URL its table entry
records and held to the same pinned digest, so adding a distribution needs
only the entry; mirroring the bytes is a separate step and the run says which
source it used.

The bytes are the distributions' own, mirrored rather than fetched from them,
because an upstream URL is not a durable pin: Debian keeps only the last few
dated cloud snapshots, so a URL pinned to one stops resolving within weeks,
and `trixie/latest/` is not a pin at all. The asset table in `packages.py`
records each image's upstream URL and the digest the distribution publishes
for it (sha512 for Debian, sha256 for Fedora), so the mirrored bytes stay
checkable against the source. There is no `actions/cache` layer in front of
this: a release asset downloads from the same CDN as the rest of CI's inputs,
and the cache's eviction window is not shorter than this lane's cadence.

### On real hardware (the `hw` phase)

The vm phase proves a kernel boots under an emulator whose devices badc's
output has never surprised. `--phases hw` runs the same sequence on a physical
machine: the same probes, the same dmesg scanners, the same exercise stage,
with the console read from a serial port on this host instead of a file qemu
writes. Everything downstream of the machine -- `probes()`, the core sweep,
`exercise.py` -- takes a target rather than a VM, and an emulated guest and a
physical box differ only in how they are started, watched and released.

`packages.py` reaches the machine over ssh (`--hw-host [user@]host`, with
`--hw-port` and `--hw-key`) and reads its console from `--hw-serial`, a serial
device on this host: `/dev/cu.usbserial-XXXX` on macOS, `/dev/ttyUSB0` on
Linux, at `--hw-baud` (115200 by default). The line settings are applied to
the descriptor that does the reading, using `termios` from the standard
library rather than a `pyserial` dependency the Linux lanes would not need.
That is not incidental: an `open()` resets a port's termios on macOS, so a
speed set by a separate `stty` call is gone before the first byte arrives and
the port then delivers a few bytes of plausible-looking garbage rather than
silence, which reads like a wiring fault and is not one. Nothing is written to
the port. The capture is byte for byte, so `DMESG_SEVERE`, the
firmware-silence check and the EDK2 exception scan read a hardware console and
a qemu one the same way. Without `--hw-serial` the phase still runs, and a
boot that never reaches ssh then leaves no record of how far it got.

The sequence:

1. Probe the machine on its distribution kernel and record what it is --
   `dmidecode` model and BIOS, CPU, firmware mode, Secure Boot state,
   watchdog -- next to the boot verdict, so a hardware run is diffable against
   a VM run.
2. Read the standing boot default and **refuse to run** unless it is a kernel
   entry that is neither the release under test nor one badc built
   (`CONFIG_CC_VERSION_TEXT` in its `/boot/config-<release>` says which). The
   standing default is the only recovery a machine with no remote power cut
   has.
3. Take the baseline probes and the core sweep, as the vm phase does against
   the stock image.
4. Copy the packages over and install them (`rpm -ivh`, `dpkg -i`).
   `--install-args` adds flags: `--oldpackage` for a pinned kernel older than
   the box's own, which rpm otherwise refuses, and `--replacepkgs` to
   reinstall one the machine already carries.
5. Put the standing default back if the install moved it -- on a BLS
   distribution `kernel-install` makes the kernel it just installed the
   default, which silently removes the fallback the run checked for in
   step 2.
6. Find the new entry with `grubby --info=ALL`, check that it names a root
   device, and select it with `grub2-reboot <index>` -- one boot only, never
   `grub2-set-default`.
7. Reset, and watch the console while waiting for ssh.
8. Run the probes, assert the boot, and run the exercise stage under
   `--exercise`.
9. Reboot back onto the standing default (`--no-hw-restore` leaves the machine
   on the kernel under test) and clear any pending one-shot selection whatever
   happened.

The device assertions differ from the vm phase's, because the hardware is not
chosen: instead of a `--vm-disk-bus` model, the baseline names what has to
bind, and the kernel under test must drive the same disk and network hardware
the distribution kernel drove.

When ssh does not return within `--hw-timeout`, the run reports which stage
the boot reached -- firmware, boot loader, `earlycon`, kernel, initramfs,
userspace, multi-user -- and the first panic or oops on the wire, then waits
`--hw-recover-timeout` for the machine to come back. The watchdog resets a
wedged kernel and the one-shot selection expires with the boot that consumed
it, so a box that is merely wedged returns on the distribution kernel by
itself. A lane that cannot tell a kernel that hung from a box that is gone is
not useful, and that second wait is what separates the two.

The wait does not always have to run out. A boot that ends badly ends in one
of a few named ways -- `emergency` (the initramfs emergency shell: the root
filesystem was not mounted), `panic`, `dracut-shell` -- and each is a
different verdict, not a variant of "ssh never returned". The console says
which, so the run ends the wait on the marker rather than on the timeout and
records the outcome and its verdict in the report. The earliest marker wins,
so a panic is not reported as the emergency shell that followed it.

Recovery is tried twice. First the watchdog and the one-shot expiry, which
between them return a wedged kernel to the standing default on their own.
Then, when the machine is parked where the watchdog was never armed -- an
initramfs emergency shell runs a systemd that never read the watchdog
configuration, because that file lives on the filesystem it failed to mount
-- a SysRq reset over the serial line: a BREAK followed by sync,
remount-read-only, boot. It is best-effort, needing a kernel that still
services interrupts and a `kernel.sysrq` mask that permits the command, and
`--no-hw-sysrq` turns it off; it is also the only remote reset a machine with
a battery has.

Two things follow from a failed boot leaving **no journal** -- emergency mode
never gets far enough to flush one, so the serial console is the only record
that boot has. The reader is started before anything else the phase does and
stays open across the reset, so the capture spans the whole reboot rather
than picking up whatever was still in flight when someone opened the port;
and it writes to the log unbuffered, so the record survives even a run that
is killed. The other consequence is a check made before the reset rather than
after it: the entry selected for the boot must name a root device, in
grubby's own `root=` field or in its arguments. `kernel-install` writes a new
kernel's entry from `/etc/kernel/cmdline`, and an `/etc/kernel/cmdline` built
from `grubby --info`'s `args=` alone has no `root=`, because grubby prints
the root device in a field of its own. The entry then looks healthy and the
boot cannot mount anything; on a machine with no remote power cut that costs
a trip to it, so the run refuses the reset instead.

`--expect-producer any` records the boot banner without asserting badc built
it, which is what a run installing a distribution package uses to exercise the
lane itself; the default asserts badc. The phase needs no kernel tree:
`--release` names what the packages install and `--package` names the files,
so a hardware run consumes an artifact another lane produced.

```sh
python3 demos/linux/packages.py --arch x86_64 --distro fedora --phases hw \
    --release <kernel release> --package <kernel rpm> \
    --hw-host <host> --hw-serial /dev/cu.usbserial-XXXX \
    --workdir <scratch> --report hw-x86_64.json
```

The phase writes `hw` into the report beside `vm`, with the same key names --
`stock`, `badc`, `install_rc`, `boot_select`, `compiler_id`, `modprobe`,
`exercise`, `cores_stock`, `cores_badc` -- plus the machine's identity, the
console log path and stage, the standing default before and after, and whether
a failed boot recovered. Like the vm phase it turns on core capture through
sysctl.d, limits.d and systemd drop-ins, which persist on the machine.

The phase is not in CI: it needs a machine on a bench with a serial line to
the runner. [`micropc-testing.md`](micropc-testing.md) documents the box this
was built against -- what it can and cannot test, which `ttyS*` is the
physical port, and what the boot configuration has to carry.

A machine with no reachable serial port cannot run the phase, because the
phase reads its verdict off the console. It can still be booted by hand, and
[`xps8930-testing.md`](xps8930-testing.md) documents that lane: what a boot
proves without a console, and what it leaves behind when it fails.
`hwprep.py` prepares either kind of machine and undoes the preparation:

```sh
sudo python3 hwprep.py record            # snapshot the state to return to
sudo python3 hwprep.py arm               # pstore and the watchdog
sudo python3 hwprep.py install <package> # add a kernel, replace none
sudo python3 hwprep.py entry --kernel V  # arguments for that entry alone
sudo python3 hwprep.py check             # READY, or why not
sudo python3 hwprep.py boot --kernel V   # one boot, then back to stock
sudo python3 hwprep.py rollback          # replay the record backwards
```

It holds one invariant, checked after every step that could disturb it: the
default boot entry is a stock kernel, so recovery from a kernel that panics or
hangs is a power cycle rather than a rescue disk. It refuses to alter a stock
entry's arguments, refuses to select an entry it did not install, and records
each change so `rollback` replays facts instead of a list of undo commands
written in advance. Machine differences are read rather than assumed: it
routes a module parameter through `modprobe.d` or the kernel command line
depending on whether the module is loadable or builtin, and reports the
watchdog's live timeout from systemd rather than the drop-in that asked for it.

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
package, publish, install, boot -- on `workflow_dispatch` and on a pull
request carrying the `kernel-packages` label. It carries no schedule: the
corpus is a pinned release at a fixed configuration, so a repeat run repeats
the previous run's work unless a commit changed the compiler, and those are
gated per push by `ci.yml`'s `kernel` job. It is deliberately off the push path, and the reason is the
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
on both architectures, which is where GNU ld consuming badc's kernel objects
is gated. A kernel that boots one way and not the other
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

`--stride N` keeps every Nth unit of the path-sorted corpus in `--replay`
mode, a sample spread over the subsystems; CI's `kernel` job runs the replay
at stride 8 over the defconfig tree the gate just built, with `--cross-check
20`, and fails on any differing layout. Both trees must carry debug info
(`CONFIG_DEBUG_INFO_DWARF4`; badc emits DWARF 4) and must hold the same
source and the same configuration. The run
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
  Kbuild arguments plus `-gdwarf-4`, and badc's flag set plus `-g` -- and
  compares per unit. Both sides then run the same preprocessor surface over
  the same sources by construction, and the corpus is every translation
  unit rather than the types that reached `vmlinux`. Objects already in the
  scratch directory are reused, so a re-run costs only the extraction and an
  interrupted run resumes.

  A tree `verify.py` built records `buildcc.py` as `$(CC)` in every `.cmd`
  file, and that shim is not a compiler: replaying it runs badc on both
  legs, or nothing at all when `$BADC` is unset. The reference leg therefore
  substitutes `--real-cc` for the recorded driver, defaulting to
  `$BADC_REAL_CC` or the target's `gcc` -- the compiler the shim itself
  falls back to. The recorded arguments are that compiler's own surface,
  since the shim rewrites for badc internally and leaves the `cc-option`
  probes to the reference compiler. A tree the reference compiler built
  keeps its recorded driver. When the tree records a shim and no reference
  compiler resolves, the run stops before compiling anything and says which
  shim, how many units and which compiler it looked for; it does not report
  an empty comparison. `--report` is written on that path too.

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

`--self-test` checks the DWARF parse and the differ against a synthetic dump,
the recorded-driver split and the reference compiler it resolves, and that a
run stopped by a precondition still writes its `--report`. It needs no
toolchain, tree or kernel, and runs in CI's script harness self-tests.

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
