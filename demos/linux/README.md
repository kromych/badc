# linux demo: kernel translation-unit sweep

Measures how much of a real Linux kernel build badc can compile today and
ranks what it cannot. Unlike the other demos this one is a gap-finding
harness, not a pass/fail smoke: it replays every C compile of a completed
gcc reference build against badc and buckets the failures by normalized
error signature, producing a ranked work list for kernel support.

Pinned kernels (known-booting minimal configs, vendored under `configs/`):

- x86_64: linux 6.12.8, `configs/x86_64-6.12.8.config`
- aarch64: linux 6.10.1, `configs/aarch64-6.10.1.config`

## Run

```sh
cargo build --release --features full            # build badc
python3 demos/linux/setup.py --build             # fetch + configure + gcc build
python3 demos/linux/sweep.py \
    --kernel-dir demos/linux/.cache/linux-<version>  # replay against badc
```

`setup.py` downloads the pinned release from cdn.kernel.org (sha256-verified),
installs the vendored config, runs `make olddefconfig`, and records every
option the host toolchain forced or dropped in
`.cache/config-deviations-<arch>.txt`. `CONFIG_INITRAMFS_SOURCE` is cleared:
the sweep needs compile commands, not boot artifacts. `--build` then runs the
gcc reference build (`make -jN`); that build validates the config and writes
the per-object `.<name>.o.cmd` files Kbuild leaves next to each object, which
are the replay corpus.

Requirements for the reference build: gcc, make, flex, bison, bc, and the
libelf + openssl development headers.

## How the sweep works

`sweep.py` walks the built tree for Kbuild `.cmd` files, keeps the kernel C
compiles (`-D__KERNEL__`, a `.c` source, `-c`), and rewrites each gcc command
into badc's flag set: the preprocessor surface is kept (`-D`/`-U`/`-I`/
`-iquote`/`-include`, `-isystem` folded into `-I`) and everything else is
dropped -- warnings, `-O`/`-g`/`-std`, and the gcc code-model/hardening set
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
asserted once. Each file states the evidence for its own existence -- the
`CC_HAS_NAMED_AS` one records that badc accepts `int __seg_fs fs;`, reading
the qualifier as the declarator name, while rejecting the qualifier-leading
form the percpu headers use.

## Scope

The sweep gates nothing; it is a measurement. A unit that gcc compiles and
badc rejects is a candidate gap; crashes and timeouts get their own buckets
and are bugs by definition. Passing units prove nothing about runtime
correctness -- linking and booting a badc-built kernel is follow-on work.
