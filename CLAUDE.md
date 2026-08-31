# How to work on `badc`

## General notes

You are an assistant to the systems engineer. The goal is to build a cross-platform compiler
that is quick and slim still providing a rich and cohesive feature set. There are no oddities:
every oddity or anomaly is a bug and it must be fixed. For each bug, look at the large picture
and decide based on evidence whether this is a narrow bug from an edge case or a design gap
that requires a structural fix.

Fix any crashes and hangs before doing feature work.

Using words "classic", "known", "provably", "latent", "flake", "glitch", "unreliable", and any
confident label in general requires providing facts and analysis. No loose speech is allowed.

Using labels "delicate", "fragile" and similar ones warrants audit of the architecture and fixing
the parts that are not bearing the load in the robust way.

Before committing changes, check no stray files are being added. Use a git-ignored or the
system-provided temporary directory for one-off tests, binaries and archives you create.

## Pre-push validation

Configure Git hooks using `./scripts/install_hooks.py`.

There are local boxes available via ssh, plus the macOS host itself, which is a lane
(`--box NAME=macos`) rather than a driver only: macOS is the matrix's only Mach-O and
only SDK-libc target. CI may hang due to miscompiles and SIGSEGV's, and costs money.
Be frugal. Before any `git push`, the following must pass on the local
boxes using `./scripts/validate_local_boxes.py`:

  * `cargo test`
  * `cargo test --release` over all test targets (release exercises the JIT + native
    fixture-parity paths that debug builds skip; the integration suites under
    `tests/` are part of the gate)
  * the same run again under the register-pressure caps (`BADC_MAX_GPR=2
    BADC_MAX_FPR=2`, `--features "codegen_test full"`), as CI's pressure matrix
    does -- on the Linux lanes, the only ones CI's matrix covers
  * the gating demos, enumerated in `GATING_DEMOS` in the script -- sqlite3, lua,
    miniz, monocypher, stb, tweetnacl, quickjs, raylib, curl, libmill, libdill,
    coroutines, nasm, qemu, edk2, bearssl, bzip2, kissfft, gui_hello, nt_loader,
    tinycc, chibicc, tcl. Each entry names the lane kinds it runs on, and
    `scripts/run_demos.py` runs the lane's set concurrently. `--demo-jobs`
    bounds how many run at a time, never which ones run; the runner prints
    its roster and its width.
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
    that did.

The macOS lane runs in the working tree with no transport, and runs the build,
the release test suite and the POSIX demo set. It skips the kernel step (that
corpus is Linux-only), the pressure rerun and the clippy step (CI runs both on
Linux only, and the pre-push hook lints on this host already).

Out of `GATING_DEMOS` by measurement, and covered by CI instead: `demos/kernel`,
`demos/yasm` and `demos/python`; the script records the measurement behind each.
`demos/qemu` gates its build, self-link and run, not its boot: the boot consumes
the firmware CI's `ovmf` lane publishes as an artifact.

The script is the contract; this list describes it and has to be updated with it.

The kernel step's corpus is `defconfig` on the pinned release -- the tree CI's
`kernel` job builds. The vendored minimal configs it once carried were removed:
they compiled a third to a half as many units and had passed while
defconfig-only regressions reached the branch. The package matrix takes each
distribution's own configuration instead, fetched sha256-verified from the
vendor mirror. The build costs 4.5-11 min
per Linux lane and the boots 12 s (aarch64, eight emulator starts) to 26 s
(x86_64, five) on top of it, measured on the boxes over an image that boots; an
image that does not boot ends each boot at the 90 s cap instead. `--no-kernel`
skips the step; a push whose local run skipped it has no kernel cover.

## Debugging

* Instead of tweaking and guessing, collect evidence that would you let 
  catch the issue and analyze it for bad patterns.
* To emit debug info pass `-g` and then run the emitted binary under `lldb` / `gdb` / `rr` / `valgrind`
  `msys2` (`msys64\usr\bin\gdb.exe`, `msys64\usr\bin\objdump.exe`, ...).
* Instrument the source code, the repro code, or the emitted code.
* Contrast with the compilers producing known good results.
* Contrast `badc` vs `badc` `-O` in the miscompiled function under the debugger.
* Use hardware breakpoints to discover who/where the memory gets corrupted.
* Capture live core/memory dumps to contrast

## Implementation choices

Solutions must be generic and motivated by C99 or by the existing practice where
the standards leave gaps. Look for ways to build a generic infrastructure rather
than for wedging in quick hacks to get something compiling. Don't write lore,
refer to unresolved issues and milestones with the TODO marker, no mentioning of
milestones and issue numbers otherwise.

## Comment style and conversational style

The audience is adult professionals. Hence, comments must not read like editorials
or tutorials, no coinage, no metaphors, no internal jargon. That's not only is not
needed but also takes time to get through without any benefit to the reader. Save
your time and the reader's time - be concise and precise. Make sure the same style
applies throughout.

Maintain the ratio of comment lines to line of code under 1:10. Requiring more means
that the architecture has to be audited. For one-line changes use no more than
3 lines of comments iff the change cannot be expressed in the self-explanatory way.

Keep the tool output terse to slow context growth.

## Planning

* File issues
* Implement solutions
* Add a regression test for each bug or feature to lock the behaviors in
* Analyze SSA and assembler delta's under `./tests/snapshots` for improvements.
