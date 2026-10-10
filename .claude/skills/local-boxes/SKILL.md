---
name: local-boxes
description: Setting up, checking and repairing badc's local validation boxes (Linux x86_64, Linux aarch64, Windows x64, Windows arm64) and the ssh git remotes the macOS host repo reaches them through. Use when adding or re-provisioning a box, when a gate lane fails at sync or for a missing tool, when a box remote's URL is wrong, or when the Rust toolchain on the boxes has to follow CI's.
---

# Local validation boxes

The gate (pre-push-validation skill) runs on four boxes plus the macOS host. The host
repo reaches each box through an ssh git remote named after its lane; `git remote -v`
is the list of boxes, and the gate scripts derive the lanes from it. No box name
belongs in CLAUDE.md or a skill: refer to a box by its OS and role.

## The host side

One remote per box, URL `HOST:PATH` (scp form):

```
git remote add <lane> <host>:~/src/compilers/badc/          # Linux
git remote add <lane> <host>:R:/src/compilers/badc/         # Windows
git config remote.<lane>.uploadpack  'powershell -NoProfile -Command git upload-pack'
git config remote.<lane>.receivepack 'powershell -NoProfile -Command git receive-pack'
```

The two `pack` settings are for Windows boxes only: their OpenSSH runs commands in
cmd.exe, which does not resolve git's pack programs the way a POSIX shell does. Log-in
is by key with no prompt (the scripts run ssh with stdin closed).

A lane pushes the commit under test to `refs/validate/lane` with `--no-verify` (the
pre-push hook would otherwise lint once per box) and checks it out detached in the
box's checkout. Queue agents push to `refs/agents/queue-<x>` and check out in their
own trees, `~/src/agent-queue-<x>` (Windows `R:\src\agent-queue-<x>`). Pushing to
refs that are not checked out needs no `receive.denyCurrentBranch` change.

## A Linux box

- A clone of the repo at `~/src/compilers/badc` (the remote's PATH).
- git, python3, util-linux `flock`, the Rust toolchain CI uses (`rustup`; CI takes
  `stable` through `dtolnay/rust-toolchain`, so update every machine when CI's
  runners move: a newer clippy on CI has failed a push the boxes had passed).
- A host C compiler (gcc and clang) for the interoperability tests. Note whether it
  defaults to PIE: objects from one that does not need `-fPIE` in PIE links.
- `llvm-objdump` for the snapshot-drift step; the step fails without it.
- `qemu-system-<arch>` for the box's own architecture: the kernel step's boots and
  the kernel demo's. Without it the lane keeps compile + link cover only.
- UEFI firmware for the box's architecture, OVMF (`edk2-ovmf`; Debian/Ubuntu
  `ovmf`) or AAVMF (`edk2-aarch64`; `qemu-efi-aarch64`): the qemu demo boots both
  of its builds through it, and its entries fail without it.
- The kernel build's prerequisites: make, flex, bison, bc, the libelf and OpenSSL
  development packages, cpio, zstd.
- Optional, for fuzz triage: csmith with its headers, cvise or creduce, gdb (the
  miscompile-triage skill).
- Caches it keeps: `~/.cache/badc-kernel-gate` (the gate's kernel tree; nothing else
  touches it) and `~/.cache/badc-kernel-agent-<x>` (one per queue).
- Memory decides concurrency: a box with 7 GB runs one kernel build or test suite at
  a time. Queue agents and the gate serialize through `flock ~/.badc-heavy.lock`
  (any heavy job) and `flock ~/.badc-kernel.lock` (kernel builds).

## A Windows box

- OpenSSH server (default shell cmd.exe). Lane commands run under `cmd /c`.
- Git for Windows with `core.autocrlf false`, and a clone at `R:\src\compilers\badc`.
- Python 3 for the box's native architecture, ahead of the Store alias in PATH.
- Visual Studio Build Tools with the native VC tools and the Windows SDK (the MSVC
  Rust toolchain links with `link.exe`).
- rustup with the MSVC host toolchain. An interrupted `rustup self update` has left
  a 0-byte `rustup.exe`; copying `rustup-init.exe` over it restores it.
- msys2 for debugging (`msys64\usr\bin\gdb.exe`, `objdump.exe`).
- A box whose cmd output is localized: no lane step may parse English messages.
- Antivirus scanning of the checkout slows builds and test runs; account for it when
  a lane is slower than its peers.

## Checking a box

```
git push --no-verify <lane> HEAD:refs/validate/lane
ssh <host> 'git -C ~/src/compilers/badc checkout -q -f --detach refs/validate/lane'
```

then run the gate on that lane alone (pre-push-validation `scripts/gate.sh --box ...`
with only its argument, or `validate_local_boxes.py` directly). For a Windows box run
the git command through `cmd /c` with the `R:` path.

Updating Rust everywhere: `rustup update stable` on each box (Windows under
`cmd /c`), then compare `rustc --version` with CI's job log.
