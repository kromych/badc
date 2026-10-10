---
name: pre-push-validation
description: badc's pre-push gate -- scripts/validate_local_boxes.py over the local validation boxes (Linux x86_64, Linux aarch64, Windows x64, Windows arm64) and the macOS host -- what each lane runs, how to invoke it from the host repo's box remotes, box capacity, and the traps that have produced wrong pass/fail conclusions. Use before any git push, when asked whether it is time to push, when validating commits on the boxes, and when reading a gate or lane result.
---

# Pre-push validation

CI may hang due to miscompiles and SIGSEGVs, and costs money. Be frugal: validate
locally, push about every 25 commits, never a small fix on its own (the release PR
runs CI on every push). Before any `git push`, the gate below must pass on all five
lanes. Configure the Git hooks with `./scripts/install_hooks.py`.

The script is the contract; this skill describes it and has to be updated with it.

## What the gate runs

There are local boxes available via ssh, plus the macOS host itself, which is a lane
(`--box NAME=macos`) rather than a driver only: macOS is the matrix's only Mach-O and
only SDK-libc target. `./scripts/validate_local_boxes.py` runs:

  * `cargo test`
  * `cargo test --release` over all test targets (release exercises the JIT + native
    fixture-parity paths that debug builds skip; the integration suites under
    `tests/` are part of the gate)
  * the same run again under the register-pressure caps
    (`BADC_MAX_GPR=2 BADC_MAX_FPR=2`, `--features "codegen_test full"`), as CI's
    pressure matrix does -- on the Linux lanes, the only ones CI's matrix covers.
    Each of these suites runs through `scripts/cargo_test.py`, which fails a test
    binary that ends without reporting every test it announced: cargo judges a
    binary by its exit status alone.
  * the gating demos, enumerated in `GATING_DEMOS` in the script -- sqlite3, lua,
    miniz, monocypher, stb, tweetnacl, quickjs, raylib, curl, libmill, libdill,
    coroutines, nasm, qemu at -O0 and at -O (`qemu@O`), edk2, bearssl, bzip2,
    kissfft, gui_hello, nt_loader, kernel, tinycc, chibicc, uemacs, picocom,
    tcl. Each entry names the lane kinds it runs on, and `scripts/run_demos.py`
    runs the lane's set concurrently. An entry `path@config` runs a smoke in a
    configuration the runner's `DEMO_ENV` defines; the configurations of one
    smoke share its cache, so they run back to back in one slot, each with its
    own verdict. `--demo-jobs` bounds how many run at a time, never which ones
    run; the runner prints its roster and its width.
  * the compile-throughput check over the QuickJS corpus the demos just
    fetched: `-O0` cost over `-O` cost, and the slowest unit over the
    median one. Both are ratios taken within the run, so the lane's own
    speed cancels and one set of ceilings covers every box; CI's perf job
    runs the same check.
  * the snapshot-drift check on every Linux lane: regenerate
    `tests/snapshots/` and fail on drift, as CI's `snapshots clean` job does.
    It needs `llvm-objdump` -- the committed snapshots were disassembled with
    it and GNU objdump's text does not match -- and fails the step when it is
    absent rather than downgrading the check. The macOS host regenerates after
    every commit through the post-commit hook, so it carries no lane step.
    Skip with `--no-snapshots`.
  * the kernel step: `demos/linux/verify.py --linker badc` over the pinned
    `defconfig` release, on each Linux lane -- compile, link and boot. The
    boots are the ones CI runs, four plus a displacement probe per distinct
    displacement, under the box's own `qemu-system-<arch>`; nothing else is
    needed to reach them, since both machines take the emulator's `-kernel`
    loader and no firmware from elsewhere. Without them the step covers only
    what is decided at the vmlinux link, and an image that compiles and links
    clean and then prints nothing on the console has reached CI while this
    board was green on all five lanes. A box with no emulator for its own
    architecture keeps the compile + link cover and reports it as a note in
    the closing summary, so a lane that did not boot does not read as one
    that did. `--nested-kvm` adds one boot under the box's KVM in which the
    badc kernel runs the qemu demo's badc-built emulator on its own image,
    so its KVM runs a guest; off by default, and reported skipped where the
    box offers no nesting (the aarch64 box does not).

The macOS lane runs in the working tree with no transport, and runs the build,
the release test suite and the POSIX demo set. It skips the kernel step (that
corpus is Linux-only), the pressure rerun and the clippy step (CI runs both on
Linux only, and the pre-push hook lints on this host already).

Out of `GATING_DEMOS` by measurement, and covered by CI instead: `demos/yasm`
and `demos/python`; the script records the measurement behind each.

`demos/qemu` runs on the Linux lanes at the two levels CI's qemu job builds:
`qemu` at -O0 and `qemu@O` at -O with every unit compiled under `--verify-ssa`,
which CI does not run. Each build self-links, runs, boots the published kernel
bundle to a shell and powers off, through the box's own UEFI firmware (the
system OVMF or AAVMF, where CI boots the `ovmf` lane's badc-built images); an
entry fails on a box without that firmware. While the gate built -O0 alone and
booted nothing, an -O pass defect whose qemu-system-aarch64 faulted in CI's
boot passed all five lanes. Built with that commit's compiler, `qemu@O` now
fails at compile time naming the pass, the function and the value, and the same
build without the verifier faults in its boot. The two configurations share
the demo's cache, so they run in one slot: 67 s on the idle aarch64 box and
85 s on the x86_64 one, against 24 s and 27 s for the -O0 build alone. The
phase stays tcl-bound: 138 to 140 s and 155 to 164 s per lane.

`demos/kernel` runs both its architectures on the Linux lanes. Neither kernel
exits once it has printed -- preempt.c ends in a halt loop and kernel.c returns
to the firmware -- so the harness waited out a 60 s budget on every boot,
passing or not, and the ten boots cost 601 s on an idle box. Stopping the
emulator at the markers took the same ten to 61 s there, which is why the
smoke's `--arch` filter is not used on the lanes: it would drop four of the ten
boots to save about twenty seconds. That demo is the only cover for a
naked-function ISR and the context switch it performs, and a prologue
regression reached CI while the board was green on all five lanes without it.

The kernel step's corpus is `defconfig` on the pinned release -- the tree CI's
`kernel` job builds. The vendored minimal configs it once carried were removed:
they compiled a third to a half as many units and had passed while
defconfig-only regressions reached the branch. The package matrix takes each
distribution's own configuration instead, fetched sha256-verified from the
vendor mirror. The build costs 4.5-11 min per Linux lane and the boots 12 s
(aarch64, eight emulator starts) to 26 s (x86_64, five) on top of it, measured on
the boxes over an image that boots; an image that does not boot ends each boot at
the 90 s cap instead. `--no-kernel` skips the step; a push whose local run skipped
it has no kernel cover. The gate builds the kernel with `KCFLAGS=-Wno-error`
because x86-64 `defconfig` sets `CONFIG_WERROR=y` and the boxes' reference
compiler is newer than the release's.

## The lanes

| Lane | What it covers | Notes |
|---|---|---|
| Linux x86_64 box | ELF x86-64, CI's ubuntu-x64 lanes | its host cc does not default to PIE |
| Linux aarch64 box | ELF aarch64, CI's ubuntu-arm64 lanes | 7 GB RAM: one kernel build or test suite at a time |
| Windows x64 box | PE x64, CI's windows-latest lanes | OpenSSH runs cmd.exe |
| Windows arm64 box | PE arm64, CI's windows-11-arm lanes | a VM on the macOS host: its timings move with the host's load |
| macOS host | Mach-O arm64 and the SDK libc | runs in the working tree |

Each box is an ssh git remote of the host repo, named after its lane (`git remote
-v`); setting one up is the local-boxes skill. Run the gate through
`scripts/gate.sh` in this skill: it builds one `--box NAME=HOST:PATH:KIND` per box
remote (a drive-letter path marks Windows) plus `--box mac=macos`, and passes any
extra arguments (`--no-kernel`, `--nested-kvm`, a single lane's `--box`) through.

Writing the `--box` arguments by hand: single-quote each one. bash expands `~` after
`:` in a `name=...` word; the lane then fails at sync and the script rewrites the
remote's URL to the expanded path (restore it with `git remote set-url`).

Sync is by git: a lane pushes the gated commit to `refs/validate/lane` on the box
with `--no-verify` and checks it out detached, keeping ignored build outputs and
demo caches. Never `rsync --delete-excluded` from the Mac (its openrsync fails
against the boxes' rsync).

A lane that fails with OOM or `echo: write error` (the 7 GB box) is rerun alone with
only its `--box`. When agent queues share the boxes, take their locks first: the
queue-coordinator skill's `scripts/run_gate.sh`.

## Traps that produced wrong conclusions

- `cargo build --release` without `--features full` does not rebuild the `badc`
  binary, so demos silently use a stale compiler. Bundled headers (libc/include)
  are compiled into the binary: an edit is invisible until that rebuild.
- The programs tests and the PE layout fixtures compile for the host target, so
  PE-only and Mach-O-only failures surface only on those hosts. Run such tests over
  explicit targets (`run_fixture_for`), and never push without the Windows lanes.
- A host cc that does not default to PIE needs `-fPIE` for objects linked into a
  PIE.
- The macOS lane runs in the working tree: do not edit, commit or rebase there
  while it runs.
- Run the Mac demos in the working tree, not in a copy under a longer path: tcl's
  smoke compares errorInfo text, which truncates file names over 150 characters.
- A test binary that ends early with status 0 reads as a pass to cargo; the gate
  catches it through `scripts/cargo_test.py`, an ad-hoc `cargo test` does not.
  Compare `running N tests` with the `test result:` line.
- A green gate needs the debug suite too: CI runs `cargo test --features full` on
  every platform, and `debug_assert!`s hold only there.
- In shell loops whose exit status matters use `/usr/bin/grep`; the Bash tool's
  `grep` is a wrapper that can miss.

## After the push

Watch CI for the pushed SHA. Close each issue whose `Fixes: #N` commit is now on the
branch, with a "Fixed by <sha>" comment, unless it was closed when the commit landed.
