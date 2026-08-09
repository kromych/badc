# `badc`

[![CI](https://github.com/kromych/badc/actions/workflows/ci.yml/badge.svg)](https://github.com/kromych/badc/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/kromych/badc?sort=semver&display_name=tag)](https://github.com/kromych/badc/releases/latest)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)
[![OS](https://img.shields.io/badge/OS-Linux%20%7C%20macOS%20%7C%20Windows-informational)](./doc/native-compilation.md)
[![Arch](https://img.shields.io/badge/arch-x86__64%20%7C%20ARM64-informational)](./doc/native-compilation.md)

`badc` is a small cross-platform optimizing C compiler, and a
compiler-as-library, that emits native binaries for five targets from any host.
It carries its own linker, DWARF emitter, inline-asm encoder, in-process JIT,
and SSA interpreter.

## What it can do

### Compile the Linux kernel

Every C translation unit of a Linux 7.1.6
`defconfig` kernel on x86_64 and aarch64 is built by `badc` in the CI, this is 2921 and
4434 units for the kernel image, 2953 and 10489
with the modules. Both kernels boot, checked by boot markers plus in-kernel
procfs/sysfs self-checks. All
`defconfig` modules build and load, with per-module verdicts identical to a
gcc-built kernel. `badc` links the kernel, too, and those kernels boot too as well.
The kernel packages as a `.deb` and an `.rpm`, installs into stock Debian 13 and
Fedora 44 images, and reaches systemd multi-user with modules autoloading,
`/proc/version` names `badc`.

`badc -c foo.S -o foo.o` assembles too, and the kernel build uses it: of the
`defconfig` assembly units `badc` takes 42 of 68 on x86_64 and 69 of 77 on
aarch64, `gas` the rest. `ld` links nothing: `badc` makes every link, the 32-bit
i386 ones (boot setup, realmode blob, 32-bit vDSO) included, and all three vDSOs
are `badc`-linked, dynamic metadata and symbol versions included. See for
more [here](./doc/linux-kernel.md).

### Target five platforms from any host

`badc` emits Mach-O, ELF, or PE32+ directly:

* macOS (`ARM64`),
* Linux (`ARM64`, `x86_64`),
* Windows ({`ARM64`, `x86_64`} x {`console`, `GUI`, `NT`, `driver`}).

EFI images are supported as well. `--freestanding` drops the startup runtime.

### Ship as one binary

Headers and runtime are embedded; `--install` writes
them to a path to override. There is no `ld` / `lld` / `link.exe` dependency as badc's
linker also can stand in for `LD=` in an existing build. Assembly is supported
in standalone files and inline.

### Optimize

`-O` runs SSA passes over a graph-coloring register allocator and
produces code faster than `clang -O0`, especially on ARM64. CI compares against
tcc and clang/MSVC on every push.

### Emit debug info

`-g` writes DWARF for lldb / gdb / rr and the profilers. You can set breakpoints,
watchpoints, dump the structure layout, all the usual debugging repertoire.

### Run C without writing a binary

`--jit` lowers in-process and calls `main`
directly; `--interp` runs the SSA IR under a VM that keeps code, stack and data
apart and can track every allocation. A `.c` file with a shebang is directly
executable.

## Be a library

`cargo add badc` builds or runs C from your project, on `std` or on `alloc` alone.

## Demos

[`demos/`](./demos/) wires each project below as a smoke test;
[`demos/README.md`](./demos/README.md) says what each exercises.

* _Language interpreters_: [`Python`](./demos/python/) 3.14 on all five
  targets, [`Lua`](./demos/lua/), [`quickjs`](./demos/quickjs/),
  [`TCL`](./demos/tcl/).
* _Systems software_: [`sqlite3`](./demos/sqlite3/),
  [`curl`](./demos/curl/), [`qemu`](./demos/qemu/): over a thousand units per
  target, self-linked, and both `qemu-system-aarch64` and `qemu-system-x86_64`
  boot Linux through UEFI firmware to a shell under TCG.
* _Toolchains_: [`chibicc`](./demos/chibicc/),
  [`tinycc`](./demos/tinycc/), and the [`nasm`](./demos/nasm/) /
  [`yasm`](./demos/yasm/) assemblers, each run against its own test suite.
* _Firmware and kernels_: [`edk2`](./demos/edk2/): badc compiles the full
  UEFI firmware from edk2 source into a bootable OVMF / AAVMF image, and the CI
  boots run under it. [`kernel`](./demos/kernel/) is a freestanding preemptive
  multitasking kernel on both architectures, timer interrupts and context
  switches included.
* _Cryptography and compression_: [`TweetNaCl`](./demos/tweetnacl/),
  [`Monocypher`](./demos/monocypher/), [`BearSSL`](./demos/bearssl/),
  [`miniz`](./demos/miniz/), [`bzip2`](./demos/bzip2/).
* _Graphics, math, and the rest_: [`stb`](./demos/stb/),
  [`raylib`](./demos/raylib/) with a Lode Runner game,
  [`kissfft`](./demos/kissfft/), the GUI demos, the Windows driver and NT
  native binaries, and the cooperative-concurrency libraries
  ([`libmill`](./demos/libmill/), [`libdill`](./demos/libdill/),
  [`coroutines`](./demos/coroutines/)), whose context switches run through
  inline asm.

## Lineage

It started as a Rust port of Robert Swierczek's C compiler in four functions,
[c4](https://github.com/rswier/c4), and diverged enough to call the dialect
**c5**. Hence the `c5` module and the `C5Error` type. `c4.c` ships as a test
fixture and self-hosts:

```sh
badc -O -o c4 tests/fixtures/c/c4.c   # compile c4 to a native binary
./c4 hello.c                          # which then runs hello.c
```

And you can really crank the fun up with something like

```sh
badc -O --jit tests/fixtures/c/c4.c tests/fixtures/c/c4.c tests/fixtures/c/c4.c tests/fixtures/c/c4.c
```

to run it quadro-nested :)

It has since grown from a stack IR through a 3-operand IR to SSA with an
optimizing backend, without taking on the pass count of a titan toolchain.

> `badc` used to be bad when the project started out, and the name stuck.
> There is some compiler-building jargon in this document here and there. You can safely skip it, and jump to the usage section right away.
> For _the true compiler heads_ there is the `--dump-ssa` option which prints each function's SSA IR plus the register allocator's per-value placement to stderr before lowering.

## Documentation

* [Getting started](./doc/getting-started.md) -- install, first run, flags,
  debugging, C as a script.
* [Native compilation](./doc/native-compilation.md) -- targets, multiple
  translation units, the linker, headers and bindings, `#pragma`-driven build
  flags, the JIT, optimizations.
* [The Linux kernel](./doc/linux-kernel.md) -- what badc compiles, links and
  boots, and what it does not.
* [Standard conformance](./doc/std-conformance.md) -- implementation-defined
  choices, divergences from C99, and the C11 / C23 / POSIX / GCC / MSVC
  extensions implemented.
* [The interpreter](./doc/interpreter.md) -- `--interp` and the
  pointer-tracking safety net.
* [Library and `no_std`](./doc/library-and-no-std.md) -- using badc from Rust.
* [Testing](./doc/testing.md) -- the suites, the fixtures, the snapshots, CI.
* [Tools](./doc/tools.md) -- the core walker and the assembler-surface probe.

## Disclaimer for those legally enlightened

This is a personal educational/research project, it has not been sponsored or
suggested by anyone, i.e. it is a product of my own volition. That said, in no
event I'll be responsible for how you use this project or what happens due to
that. See [LICENSE](./LICENSE) for the exact terms.
