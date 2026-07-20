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

## Scope

The sweep gates nothing; it is a measurement. A unit that gcc compiles and
badc rejects is a candidate gap; crashes and timeouts get their own buckets
and are bugs by definition. Passing units prove nothing about runtime
correctness -- linking and booting a badc-built kernel is follow-on work.
