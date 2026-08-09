# `badc`

[![CI](https://github.com/kromych/badc/actions/workflows/ci.yml/badge.svg)](https://github.com/kromych/badc/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/kromych/badc?sort=semver&display_name=tag)](https://github.com/kromych/badc/releases/latest)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)
[![OS](https://img.shields.io/badge/OS-Linux%20%7C%20macOS%20%7C%20Windows-informational)](./doc/native-compilation.md)
[![Arch](https://img.shields.io/badge/arch-x86__64%20%7C%20ARM64-informational)](./doc/native-compilation.md)

`badc` is a small cross-platform optimizing C compiler -- and a
compiler-as-library -- that emits real native binaries for five targets from
any host, with its own linker, its own debug-info emitter, an in-process JIT,
and an SSA interpreter.

It appeared out of a need to quickly tweak how and what a C compiler emits, and
grew into a practical everyday tool rather than a niche hack.

## What it can do

**It compiles the Linux kernel.** Every C translation unit of a Linux 7.1.6
`defconfig` kernel on x86_64 and aarch64 is badc's, with zero fallbacks to
another compiler -- 2921 and 4434 units for the kernel image -- and both
kernels boot, verified with boot markers plus in-kernel self-checks that read
procfs and sysfs. All `defconfig` modules build and load, with per-module
verdicts identical to a gcc-built kernel. `LD=badc` also links the kernel
through kbuild's own `link-vmlinux.sh` on both architectures, and those kernels
boot too; kallsyms converges in two passes, and the x86 KASLR relocation table
built from badc's `--emit-relocs` output is byte-identical to GNU ld's. The
kernel packages as a `.deb` and an `.rpm`, installs into stock Debian 13 and
Fedora 44 images, and reaches systemd multi-user with modules autoloading;
`/proc/version` names badc.

The qualifications, which matter: assembly (`.S`) units still go to gas, and
within kbuild the i386 links, the vDSOs' dynamic metadata and one scriptless
probe link still go to GNU ld. [The full scope statement is
here](./doc/linux-kernel.md).

**It targets five platforms from any host**, emitting Mach-O, ELF, or PE32+
directly:

* macOS (`ARM64`),
* Linux (`ARM64`, `x86_64`),
* Windows ({`ARM64`, `x86_64`} x {`console`, `GUI`, `NT`, `driver`}).

`EFI` is supported as well, and `--freestanding` drops the startup runtime when
you need that.

**It is one binary.** Headers and runtime are embedded (override them, or
`--install` them to a path for tweaking). No `ld` / `lld` / `link.exe`
dependency -- badc ships its own linker, which also stands in for `LD=` in an
existing build. No assembler dependency for C sources: inline asm goes through
badc's own encoder.

**It optimizes.** `-O` runs SSA passes over a graph-coloring register
allocator, and produces code faster than `clang -O0`, especially on ARM64. CI
compares against tcc and clang/MSVC on every push.

**It debugs.** `-g` emits DWARF, so binaries can be stepped in lldb / gdb / rr
and profiled.

**It runs C without writing a binary.** `--jit` lowers in-process and calls
`main` directly; `--interp` runs the SSA IR under a VM that keeps code, stack
and data apart and can track every allocation. A `.c` file with a shebang is
directly executable, so C source becomes a fast script.

**It is a library.** `cargo add badc` gives your project the ability to build C
code or just run it, on `std` or on `alloc` alone.

## Demos

badc builds a wide range of real projects; [`demos/`](./demos/) has each one
wired as a smoke test, and [`demos/README.md`](./demos/README.md) describes
what each exercises.

* **Language runtimes** -- [`Python`](./demos/python/) 3.14 on all five
  targets, [`Lua`](./demos/lua/), [`quickjs`](./demos/quickjs/),
  [`TCL`](./demos/tcl/).
* **Systems software** -- [`sqlite3`](./demos/sqlite3/),
  [`curl`](./demos/curl/), [`qemu`](./demos/qemu/) (over a thousand units per
  target, self-linked, and both `qemu-system-aarch64` and `qemu-system-x86_64`
  boot Linux through UEFI firmware to a shell under TCG).
* **Toolchains** -- [`chibicc`](./demos/chibicc/),
  [`tinycc`](./demos/tinycc/), and the [`nasm`](./demos/nasm/) /
  [`yasm`](./demos/yasm/) assemblers, each run against its own test suite.
* **Firmware and kernels** -- [`edk2`](./demos/edk2/): badc compiles the full
  UEFI firmware from edk2 source into a bootable OVMF / AAVMF image, and the CI
  boots run under that badc-built firmware. [`kernel`](./demos/kernel/) is a
  freestanding preemptive multitasking kernel on both architectures, timer
  interrupts and context switches included.
* **Cryptography and compression** -- [`TweetNaCl`](./demos/tweetnacl/),
  [`Monocypher`](./demos/monocypher/), [`BearSSL`](./demos/bearssl/),
  [`miniz`](./demos/miniz/), [`bzip2`](./demos/bzip2/).
* **Graphics, math, and the rest** -- [`stb`](./demos/stb/),
  [`raylib`](./demos/raylib/) (with a Lode Runner game),
  [`kissfft`](./demos/kissfft/), the GUI demos, the Windows driver and NT
  native binaries, and the cooperative-concurrency libraries
  ([`libmill`](./demos/libmill/), [`libdill`](./demos/libdill/),
  [`coroutines`](./demos/coroutines/)) whose context switches exercise inline
  asm end to end.

## Lineage

It started as a Rust port of Robert Swierczek's teeny-tiny C compiler in four
functions, [c4](https://github.com/rswier/c4), and diverged enough to call the
dialect **c5** -- which is why the source tree spells out a `c5` module and a
`C5Error` type. The venerable `c4.c` ships as a test fixture and self-hosts:

```sh
badc -O -o c4 tests/fixtures/c/c4.c   # compile c4 to a native binary
./c4 hello.c                          # which then runs hello.c
```

It has since grown from a stack IR through a 3-operand IR to SSA with an
optimizing backend. It does not go for the exhaustive optimization passes a
titan toolchain runs, and to stay slim it is unlikely to squeeze the last drop
of performance out of the machine -- that is fine.

> `badc` used to be bad when the project started out, and the name stuck.

## Documentation

* [Getting started](./doc/getting-started.md) -- install, first run, flags,
  debugging, C as a script.
* [Native compilation](./doc/native-compilation.md) -- targets, multiple
  translation units, the linker, headers and bindings, `#pragma`-driven build
  flags, the JIT, optimizations.
* [The Linux kernel](./doc/linux-kernel.md) -- what badc compiles, links and
  boots, and what it does not.
* [Standard conformance](./doc/std-conformance.md) -- the
  implementation-defined choices, the divergences from C99, and the
  C11 / C23 / POSIX / GCC / MSVC extensions implemented.
* [The interpreter](./doc/interpreter.md) -- `--interp` and the pointer-tracking
  safety net.
* [Library and `no_std`](./doc/library-and-no-std.md) -- using badc from Rust.
* [Testing](./doc/testing.md) -- the suites, the fixtures, the snapshots, CI.
* [Tools](./doc/tools.md) -- the core walker and the assembler-surface probe.

## Disclaimer for those legally enlightened

This is a personal educational/research project, it has not been sponsored or
suggested by anyone, i.e. it is a product of my own volition. That said, in no
event I'll be responsible for how you use this project or what happens due to
that. See [LICENSE](./LICENSE) for the exact terms.
