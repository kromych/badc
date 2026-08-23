# What `badc` can do

## Compile the Linux kernel

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
`defconfig` assembly units `badc` takes 60 of 71 on x86_64 -- the real-mode
boot units among them, written out as ELFCLASS32 / EM_386 objects under `-m16`
/ `-m32` -- and 71 of 77 on aarch64, `gas` the rest. `ld` links nothing:
`badc` makes every link, the 32-bit
i386 ones (boot setup, realmode blob, 32-bit vDSO) included, and all three vDSOs
are `badc`-linked, dynamic metadata and symbol versions included. See for
more [here](./doc/linux-kernel.md).

## Target five platforms from any host

`badc` emits Mach-O, ELF, or PE32+ directly:

* macOS (`ARM64`),
* Linux (`ARM64`, `x86_64`),
* Windows ({`ARM64`, `x86_64`} x {`console`, `GUI`, `NT`, `driver`}).

EFI images are supported as well. `--freestanding` drops the startup runtime.

## Ship as one binary

Headers and runtime are embedded; `--install` writes
them to a path to override. There is no `ld` / `lld` / `link.exe` dependency as badc's
linker also can stand in for `LD=` in an existing build. Assembly is supported
in standalone files and inline.

## Optimize

`-O` runs SSA passes over a graph-coloring register allocator and
produces code faster than `clang -O0`, especially on ARM64. CI compares against
tcc and clang/MSVC on every push.

## Emit debug info

`-g` writes DWARF for lldb / gdb / rr and the profilers. You can set breakpoints,
watchpoints, dump the structure layout, all the usual debugging repertoire.

## Run C without writing a binary

`--jit` lowers in-process and calls `main`
directly; `--interp` runs the SSA IR under a VM that keeps code, stack and data
apart and can track every allocation. A `.c` file with a shebang is directly
executable.

## Be a library

`cargo add badc` builds or runs C from your project, on `std` or on `alloc` alone.
