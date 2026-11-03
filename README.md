# `badc` ([performance](https://badc.dev/performance/))

[![CI](https://github.com/kromych/badc/actions/workflows/ci.yml/badge.svg)](https://github.com/kromych/badc/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/kromych/badc?sort=semver&display_name=tag)](https://github.com/kromych/badc/releases/latest)
[![crates.io](https://img.shields.io/crates/v/badc.svg)](https://crates.io/crates/badc)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)
[![OS](https://img.shields.io/badge/OS-Linux%20%7C%20macOS%20%7C%20Windows-informational)](./doc/native-compilation.md)
[![Arch](https://img.shields.io/badge/arch-x86__64%20%7C%20ARM64-informational)](./doc/native-compilation.md)

`badc` is a cross-platform optimizing C compiler, also usable as a Rust
library. From any host it builds native executables, shared libraries and
objects for five targets: macOS on ARM64, Linux on ARM64 and x86-64, and
Windows on ARM64 and x86-64. It has its own preprocessor, assembler, linker,
archiver and DWARF writer, an in-process JIT and an SSA interpreter. CI runs
over 80 jobs and over 5,000 tests on every pull request and every push to
`master`, and fuzzing jobs run daily.

> * `badc` was bad when the project started, and the name stuck.
> * `--dump-ssa` prints each function's SSA IR and the register allocator's
>   placement of each value to stderr before lowering.

## Contents

* [Demos](#demos)
* [Lineage](#lineage)
* [Documentation](#documentation)
* [Disclaimer](#disclaimer)

## Demos

[`demos/`](./demos/) builds each project below with badc and runs it as a
smoke test. [`demos/README.md`](./demos/README.md) says what each one
exercises.

* _Language interpreters_: [Python](./demos/python/) 3.14 on all five
  targets, [Lua](./demos/lua/), [QuickJS](./demos/quickjs/),
  [Tcl](./demos/tcl/).
* _Systems software_: [SQLite](./demos/sqlite3/), [curl](./demos/curl/),
  [QEMU](./demos/qemu/). QEMU is over a thousand units per target, linked by
  badc's own linker. The badc-built `qemu-system-aarch64` and
  `qemu-system-x86_64` boot Linux through UEFI firmware to a shell under TCG.
* _Toolchains_: [chibicc](./demos/chibicc/), [TinyCC](./demos/tinycc/), and
  the [nasm](./demos/nasm/) and [yasm](./demos/yasm/) assemblers, each run
  against its own test suite.
* _Firmware and kernels_:
  * [edk2](./demos/edk2/): badc builds the OVMF and AAVMF UEFI firmware from
    source, and the CI boots run under that firmware.
  * [efi_hello](./demos/README.md#efi_hello): a single-source EFI
    application; `#pragma subsystem` selects its PE subsystem.
  * [kernel](./demos/kernel/): a freestanding preemptive multitasking kernel
    for both architectures, with timer interrupts and context switches.
  * [Linux](./demos/linux/): the Linux 7.2.9 kernel; see
    [the kernel page](./doc/linux-kernel.md).
* _Cryptography and compression_: [TweetNaCl](./demos/tweetnacl/),
  [Monocypher](./demos/monocypher/), [BearSSL](./demos/bearssl/),
  [miniz](./demos/miniz/), [bzip2](./demos/bzip2/), and
  [OpenSSL](./demos/openssl/) with its `make test`.
* _Graphics and math_: [stb](./demos/README.md#stb),
  [raylib](./demos/raylib/) with a Lode Runner game,
  [Nuklear](./demos/nuklear/), [kissfft](./demos/kissfft/), and the
  [GUI](./demos/gui_hello/) demos: one windowed program per OS family, each
  cross-compiled to every target. Nuklear's demo windows, rendered without a
  display, give the same frames under badc `-O0`, badc `-O` and the host
  compiler.
* _Windows system code_: the [WDM](./demos/README.md#wdm_driver) kernel
  driver; [SimpleVisor](./demos/simplevisor/), an Intel VT-x hypervisor built
  as a native-subsystem driver; [nt_hello](./demos/README.md#nt_hello), an
  `IMAGE_SUBSYSTEM_NATIVE` program that runs on `ntdll` alone; and
  [nt_loader](./demos/README.md#nt_loader), which starts one through
  `NtCreateUserProcess`.
* _Coroutines_: [libmill](./demos/README.md#libmill-libdill-coroutines),
  [libdill](./demos/README.md#libmill-libdill-coroutines) and
  [coroutines](./demos/README.md#libmill-libdill-coroutines), whose context
  switches run through inline asm.
* _Editors and terminal tools_: [uemacs](./demos/uemacs/), MicroEMACS from
  Linus Torvalds' tree; [picocom](./demos/picocom/), a serial terminal
  emulator, tested between two pseudo-terminals;
  [GNU Screen](./demos/screen/), tested as both halves of its client/server
  pair; and [Vim](./demos/vim/), tested in ex mode and with keystrokes at a
  pseudo-terminal.

## Lineage

badc started as a Rust port of Robert Swierczek's
[c4](https://github.com/rswier/c4), a C compiler in four functions. The
dialect diverged enough to get its own name, **c5**, hence the `c5` module and
the `C5Error` type. It has since moved from a stack IR through a three-operand
IR to SSA with an optimizing backend.

`c4.c` is a test fixture, and badc compiles it:

```sh
badc -O -o c4 tests/fixtures/c/c4.c           # compile c4 to a native binary
./c4 tests/fixtures/c/c4_selfhost_hello.c     # c4 compiles and runs a program
```

c4 also runs itself. This runs the hello program under c4, under c4, under
c4 compiled by badc's JIT:

```sh
badc -O --jit tests/fixtures/c/c4.c tests/fixtures/c/c4.c tests/fixtures/c/c4.c \
    tests/fixtures/c/c4_selfhost_hello.c
```

```console
Hello 123
exit(0) cycle = 11
exit(0) cycle = 37229
exit(0) cycle = 11152710
```

c4 accepts a subset of C. For example, it rejects a local declaration with an
initializer.

## Documentation

* [What `badc` can do](./doc/what-badc-can-do.md): a short survey of the
  features.
* [Getting started](./doc/getting-started.md): install, first run, flags,
  debugging, C as a script.
* [Native compilation](./doc/native-compilation.md): targets, the
  instruction-set baseline (x86-64-v3, the Apple M1's ARMv8.4-A), multiple
  translation units, the linker, headers and bindings, `#pragma` build flags,
  the JIT, optimizations.
* [Diagnostics](./doc/diagnostics.md): every warning and error with its code
  and name, and the `-W` options and pragmas that select them.
* [Standard conformance](./doc/std-conformance.md): implementation-defined
  choices, divergences from C99, and the C11, C23, POSIX, GCC and MSVC
  extensions badc implements.
* [The Linux kernel](./doc/linux-kernel.md): what badc compiles, links and
  boots of the kernel, and how it is checked.
* [`--interp` and `--jit`](./doc/interpreter.md): running C without writing
  an image, and the interpreter's pointer checks.
* [Library and `no_std`](./doc/library-and-no-std.md): using badc from Rust.
* [Testing](./doc/testing.md): the suites, fixtures, snapshots, fuzzing,
  benchmarks and CI.
* [Tools](./doc/tools.md): the helper programs under `tools/` and `scripts/`.
* [Performance](https://badc.dev/performance/): CI's benchmark results.

## Disclaimer

This is a personal educational and research project. Nobody sponsored or
suggested it. I am not responsible for how you use it or for what follows
from that use. See [LICENSE](./LICENSE) for the exact terms.
