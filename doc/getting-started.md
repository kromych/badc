# Getting started

This page installs badc, builds a first program, and lists the options most
builds need. `badc --help` describes the rest.

## Contents

* [Install](#install)
* [First run](#first-run)
* [Output modes](#output-modes)
* [Options](#options)
* [Diagnostics](#diagnostics)
* [Debugging](#debugging)
* [C as a script](#c-as-a-script)
* [Headers on disk](#headers-on-disk)

## Install

Each [release](https://github.com/kromych/badc/releases/latest) has an
archive for Linux x86-64, Linux ARM64, macOS ARM64, Windows x64 and Windows
ARM64. The archive holds the `badc` binary, `README.md` and `LICENSE`. The
headers and the C runtime are built into the binary.

With Rust installed, build from a clone or from crates.io:

```sh
cargo install --path . --features full   # from a clone of this repository
cargo install badc --features full       # from crates.io
```

The `badc` binary requires the `full` feature. The default feature set builds
only the library: the compiler, the optimizer, the interpreter and the JIT,
without the object writers and the linker.

## First run

`hello.c`:

```c
#include <stdio.h>
#include <stdlib.h>

int main() {
    int a = 123;
    printf("Hello %d\n", a);
    return 0;
}
```

Compile it in memory and run it:

```sh
badc --jit hello.c
```

```console
Hello 123
```

Or write an optimized executable:

```sh
badc -O hello.c
./hello
```

```console
info: wrote file hello for target macos-aarch64
Hello 123
```

The executable goes next to the source and takes its name: `hello` for the
macOS and Linux targets, `hello.exe` for the Windows targets. `-o <path>`
names another file, and `-q` drops the `info: wrote file` line.

A call to a standard library function that no header declared makes badc
include the header that declares it, so this `hello.c` builds as well:

```c
int main() {
    puts("Hello");
    return 0;
}
```

```console
info: auto-including <stdio.h> for undeclared `puts`
info: wrote file hello for target macos-aarch64
```

`-fno-builtin` turns this off.

## Output modes

| option | result |
|---|---|
| (none) | an executable: Mach-O, ELF or PE32+ |
| `-c` | an object file per source; badc writes ELF64 relocatable objects for every target |
| `--shared` | a shared library: `.dylib`, `.so` or `.dll` |
| `--ar -o <lib>.a <inputs>` | an archive of the compiled sources and the objects |
| `-E` | the preprocessed source, on stdout or to `-o` |
| `-fsyntax-only` | nothing; the source is only checked |
| `--jit` | compiles for the host in memory and calls `main` |
| `--interp` | runs the program in badc's SSA interpreter |

Two or more inputs, or any of `-c`, `-l` and `-L`, go through badc's linker.
An input may be a `.c`, `.i`, `.s` or `.S` source, a `.o` object or a `.a`
archive. [`--interp` and `--jit`](interpreter.md) describes the two modes
that run the program.

## Options

| option | effect |
|---|---|
| `--target=<target>` | `macos-aarch64`, `linux-aarch64`, `linux-x64`, `windows-x64` or `windows-arm64`; the default is the host |
| `-O` | run the SSA optimizer and define `NDEBUG` and `__OPTIMIZE__`; `-O1` to `-O3`, `-Os`, `-Oz`, `-Ofast` and `-Og` mean the same, `-O0` turns it off |
| `-g` | write DWARF debug information |
| `-o <path>` | the output file |
| `-D NAME[=VALUE]`, `-U NAME` | define or undefine a macro |
| `-I <dir>`, `-iquote <dir>`, `-isystem <dir>`, `-include <file>` | header search and forced includes |
| `-L <dir>`, `-l <name>` | library search path and library |
| `-M`, `-MM`, `-MD`, `-MMD`, `-MF`, `-MT`, `-MQ`, `-MP` | make dependency rules; also `-Wp,-MD,<file>` and `-Wp,-MMD,<file>` |
| `-H`, `--show-includes` | print the path of every included header to stderr |
| `--gnu` | define the GNU C identity macros (`__GNUC__` and the rest); off by default |
| `--msvc` | Windows targets: define the MSVC identity macros (`_MSC_VER` and the rest) and leave `__STDC__` undefined; off by default |
| `-ffreestanding` | compile for a freestanding implementation: `__STDC_HOSTED__` is 0 and `-fno-builtin` applies |
| `--freestanding` | link without badc's startup runtime; the program supplies its entry point |
| `--list-symbols` | print the built-in keywords, library calls and constants |
| `-q` | drop the `info: compiling` and `info: wrote file` lines |
| `--track-pointers`, `--trace` | interpreter options; `--interp` only |

Options may come before or after the inputs. Under `--jit` and `--interp`,
every argument after the source goes to the program, as for `tcc -run`:
`badc --jit prog.c -v` passes `-v` to `prog.c`, and a script whose first line
is `#!/usr/bin/env -S badc --interp` receives its own options. `--` ends
badc's arguments: `badc --jit -- prog.c -v` does the same.

An option badc does not implement is an error, not a warning. Some build
settings that other compilers take as options come from `#pragma`s in the
source instead; see [headers and bindings](native-compilation.md#headers-and-bindings).

## Diagnostics

Every warning and error ends with its code and its name:

```sh
badc -Wall -c unit.c
```

```console
unit.c:3: warning: unused variable `x` [B2001] [-Wunused-variable]
    int x;
unit.c:8: error: bad expression: got `;` (in f) [B2020] [syntax]
    return 1 +;
```

`-W<name>`, `-Wno-<name>`, `-Werror=<name>` and `-Wno-error=<name>` select a
diagnostic by its name or its code. `-Wall`, `-Wextra`, `-Wpedantic`,
`-Werror` and `-w` select groups and severities. `#pragma GCC diagnostic`,
`#pragma clang diagnostic` and MSVC's `#pragma warning(...)` apply from their
position in the source. `badc --explain <name>` describes one diagnostic, and
`badc --list-diagnostics` prints the catalogue that
[diagnostics](diagnostics.md) also holds.

## Debugging

`-g` writes DWARF 4, which lldb, gdb and the profilers read:

```sh
badc -g hello.c
lldb ./hello
```

```console
(lldb) b main
Breakpoint 1: where = hello`main + 12 at hello.c:5, address = 0x00000001000007bc
(lldb) run
Process 52314 stopped
* thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
    frame #0: 0x00000001000007bc hello`main at hello.c:5
   2    #include <stdlib.h>
   3
   4    int main() {
-> 5        int a = 123;
   6        printf("Hello %d\n", a);
   7        return 0;
   8    }
(lldb) n
Process 52314 stopped
* thread #1, queue = 'com.apple.main-thread', stop reason = step over
    frame #0: 0x00000001000007c4 hello`main at hello.c:6
-> 6        printf("Hello %d\n", a);
(lldb) v
(int) a = 123
```

On the Windows targets the DWARF sections are in the PE image, and a `-g` link
also writes the program database beside it (`hello.exe` gets `hello.pdb`),
which the image's debug directory names by its absolute path. The PDB holds
the CodeView types, the procedures with their frame-pointer-relative locals,
the line tables, and the global and public symbols of every unit the image
carries DWARF for. `-S` drops both.

Two options help when badc itself is the suspect:

* `--dump-ssa` prints each function's SSA IR and the register allocator's
  placement of each value to stderr before lowering.
* `--verify-ssa` checks the SSA form after each pass and stops at the first
  pass that breaks it. A debug build of badc always checks.

`badc --help` does not list these two.

## C as a script

badc skips a `#!` line at the start of a source file. With `badc` on `PATH`
and the file executable (`chmod +x script.c`), the line selects the mode:

| first line | `./script.c` |
|---|---|
| `#!/usr/bin/env -S badc --interp` | runs the program in the interpreter |
| `#!/usr/bin/env -S badc --jit` | runs the program as native code |
| `#!/usr/bin/env badc` | writes the executable `./script` without running it |

Under `--interp` and `--jit`, the arguments after `./script.c` go to the
program. `env -S` splits the rest of the line into arguments. Linux passes
everything after the interpreter path as a single argument (execve(2)), so
`#!/usr/bin/env badc --interp` works on macOS and fails on Linux.

## Headers on disk

The bundled headers and the C runtime source are built into the binary.
`badc --install [<dir>]` writes them under `<dir>`: by default
`$BADC_HOME`, else `~/.badc`.

A build reads the installed copies only when `--badc-home=<dir>` or
`$BADC_HOME` names the tree. An edit to an installed header or to
`lib/runtime.c` then takes effect without rebuilding badc. badc reads no
other location on its own, neither `~/.badc` nor the directory of the
executable, so the output depends only on the command line and the
environment. `--badc-home=` with an empty value ignores `$BADC_HOME`.

`badc --dump-headers` prints the embedded headers to stdout.
