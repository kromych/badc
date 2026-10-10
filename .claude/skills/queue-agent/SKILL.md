---
name: queue-agent
description: Working rules for a badc queue agent -- one item at a time in its own git worktree, commit format and trailers, the checks before each commit, how to reach the local validation boxes (push forms, locks, shared hosts), what each lane must run, the known traps, and the report format. Load at the start of every queue session, before touching code, together with the round's .claude/queues/PROTOCOL.md.
---

# Queue agent

Read CLAUDE.md first and follow it. The round's specifics -- the branch, the base sha,
the box remotes by name, the scratch and note paths -- are in
`.claude/queues/PROTOCOL.md`; your orders are in `.claude/queues/queue-<x>.md`.

## Base

- Before touching anything, check that `git rev-parse HEAD` in your worktree prints
  the round's base; if not, `git reset --hard <base>` and check again. Report the
  base you verified.
- When the coordinator names a newer head, rebuild your unlanded commits on it
  before the next lane run: check it out detached, re-apply each commit
  (`git cherry-pick -n <sha> && git commit -F <message>` when a message changes).
- Never run anything in the main repo's working tree: the coordinator's gate and
  its macOS lane use it. Work only in your worktree.

## Rules

- Never push to origin. No PRs. No GitHub writes; `gh issue view` is fine.
  Findings for the coordinator to file go in your report with evidence: hash,
  target, program, observed vs expected, what gcc and clang do.
- One issue at a time. When it is done and validated, update your note and end the
  turn with the report. The coordinator lands it and sends the next item.
- Commits: one per logical change, in the style of `git log -30`. A subject naming
  the behavior; a body with the C99 or ABI citation, the evidence before and after,
  the tests and the snapshot delta. No issue numbers in the subject or body (TODO
  markers only). Trailers, in this order: `Fixes: #N` when the commit completes the
  fix of a filed issue, then `Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>`.
- Code, comments and test names describe the construct and the rule, never a
  project badc builds (CLAUDE.md, Implementation choices).
- Before every commit: `cargo fmt`, `cargo clippy --all-targets --features full`
  (and `--target x86_64-pc-windows-gnu` when Windows code changed),
  `cargo build --locked --no-default-features --lib` (write `alloc::vec::Vec`,
  `alloc::format!`, `alloc::string::String` as the file's existing code does).
- Snapshots: regenerate `tests/snapshots/` for each commit
  (`python3 scripts/snapshots.py`, `--only <name>` while iterating); review the
  asm and SSA deltas and cite them.
- Tests assert on emitted SSA/asm or on program behavior; no host-compiler parity
  fixtures.
- In any polling loop, or anything whose exit status matters, use `/usr/bin/grep`.
- Your note (`.claude/queues/queue-<x>.md`) is what survives a session cut-off: keep
  the base, commits, validation per lane, findings and what is next in it. If a
  write there is refused, put the log text in your report.

## Boxes

The boxes are the main repo's ssh git remotes, one per lane (`git remote -v`; the
local-boxes skill describes them): a Linux x86_64 box, a Linux aarch64 box with 7 GB
of RAM, a Windows x64 box and a Windows arm64 VM, both Windows boxes with an `R:`
drive and cmd.exe as the ssh shell. Your tree on a box is `~/src/agent-queue-<x>`
(`R:\src\agent-queue-<x>`). The only allowed route:

```
git push -f --no-verify <remote> HEAD:refs/agents/queue-<x>
ssh <host> 'git -C ~/src/agent-queue-<x> checkout -q -f --detach refs/agents/queue-<x>'
```

Push `HEAD` only (check out the commit to test in your worktree first), only to your
own ref. No scp, rsync, tar over ssh or other refs. If your box tree is missing:
`git -C ~/src/compilers/badc worktree prune; git -C ~/src/compilers/badc worktree add
--detach ~/src/agent-queue-<x> refs/agents/queue-<x>` (Windows: through `cmd /c`).

- Never touch a box's `~/src/compilers/badc` checkout or `~/.cache/badc-kernel-gate`:
  the gate uses them. Kernel work uses `~/.cache/badc-kernel-agent-<x>`
  (`setup.py --cache`, `verify.py --workdir`).
- Run each lane step as its own ssh command in your box tree
  (`ssh <host> 'cd ~/src/agent-queue-<x> && ... < /dev/null'`), logging on the Mac;
  `ssh <host> 'bash -s' < script` lets a demo swallow the rest of the script.
- Never pipe `gh auth token` or any credential to a box; demos run from the boxes'
  caches.

## Box capacity

Wrap every test suite, demo run and kernel build on the 7 GB box in
`flock ~/.badc-heavy.lock <cmd>`, and every kernel build on the x86_64 box in
`flock ~/.badc-kernel.lock <cmd>`; the coordinator's gate takes the same locks. A
lane that fails with OOM or `echo: write error` is rerun alone.

## Validation per commit (before reporting)

Build with `--features full`: without it `cargo build --release` does not rebuild
the badc binary, and demos silently use a stale one (bundled headers are compiled
into it). Run the suites through `scripts/cargo_test.py`, and check that every
binary's announced test count equals its reported count.
- Mac (your worktree): fmt, clippy, the no_std lib build, the release and debug
  suites, the demos (`scripts/run_demos.py`, in the worktree).
- Linux boxes: release and debug suites; the pressure rerun
  (`BADC_MAX_GPR=2 BADC_MAX_FPR=2`, `--lib --features "codegen_test full"`); demos;
  the throughput check; the snapshot-drift check; the kernel step
  (`demos/linux/verify.py`, boots included) when the change touches codegen, types,
  the ABI, the front end, the linker or the libc headers.
- Windows boxes: build, the release and debug suites, the Windows demo set, for
  anything touching codegen, types, the front end, the linker or the headers.
  Tests that compile for the host target need explicit targets (`run_fixture_for`)
  to cover the other formats.

- A commit that adds an -O pass or changes what a pass transforms passes a
  differential fuzz run before it is reported: `scripts/csmith_fuzz.py` (badc -O
  against -O0 and the reference compiler, under `--verify-ssa`) for at least 30
  minutes on aarch64 and on x86-64 with no findings, plus a generator aimed at the
  pass's own shapes, which csmith seldom emits, whose programs are UB-free and are
  checked the same way. The commit body gives both runs' case counts. The driver
  exits 2 when csmith or its headers are missing; `--skip-without-csmith`, which
  an acceptance run never passes, is its only way to skip. It finds the
  distributions' headers itself: no `--csmith-include` names a system directory.

Report counts (passed/failed/ignored) per lane, demo tallies, kernel units and boots
and the kernel diagnostic rows. When a rerun covers only some targets, say which
targets the earlier full run covered at which hash.

## Shared hosts

The Mac, the boxes and the Windows arm64 VM (on the Mac: its timings move with the
Mac's load) are shared by every queue and the gate. Never kill by pattern
(`pkill -f`, `killall`); stop only processes whose pid you started, after checking
the command line. A step that ended rc=255 or was cut mid-run is rerun alone and
reported as a rerun.

## Traps

- A test binary that ends early with status 0 reads as a pass to cargo: compare
  `running N tests` with the `test result:` line.
- Run the Mac demos in the worktree, not in a copy under a longer path: tcl's smoke
  compares errorInfo text, which truncates file names over 150 characters.
- A host cc that does not default to PIE needs `-fPIE` for objects linked into a PIE.
- Linux 7.1's clocksource watchdog can stop an x86-64 boot after "hpet0: 3
  comparators" (verify.py passes tsc=nowatchdog); rerun and say so.
- The permission classifier refuses some git operations (e.g. `git reset --hard`
  over unlanded commits). Do not look for another route to the same effect; report
  it and let the coordinator take it to the user.

## Report (the final message of each turn)

Item, commit subjects and shas, base, a lane table with counts, kernel units, boots
and diagnostic rows, the snapshot delta, findings with evidence, the next item.
