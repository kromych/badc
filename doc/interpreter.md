# `--interp` and `--jit`

Both modes run a program without writing an image, and both exit with the
program's status. `--jit` compiles for the host in memory and calls `main`.
`--interp` compiles for the target and runs the SSA IR in badc's interpreter,
which checks how the program uses pointers.

```sh
$ badc --interp hello.c; echo "status $?"
Hello 123
status 0
```

## `--jit`

The JIT runs on Linux x86-64 and ARM64, macOS ARM64, and Windows x64 and
ARM64. It runs host code only: `--jit` with another `--target` is an error.
Library calls go to the host's C library, as from a native image. `-O`
applies as it does to an image.

The JIT refuses two constructs, each with B4001 `unsupported`:

* an access to a `_Thread_local` object;
* a structured exception handling region (`__try`) on Windows.

## `--interp`

`--interp` compiles for `--target`, by default the host, with that target's
type sizes, predefined macros and headers. Any host can interpret a program
for any target.

The interpreter keeps the program's data, a 256 KiB stack and the heap in one
byte-addressed memory. Code is outside that memory: a function pointer is a
tagged value, not an address. Loading or storing through a function pointer
is an error, and so is calling through an integer that is not one:

```c
int (*fp)(void) = (int (*)(void))42;
fp();   /* error: runtime: vm_ssa: CallIndirect: target raw=0x000000000000002a is not a code pointer */
```

### Pointer tracking

`--track-pointers` checks every heap access and every `free`:

| program does | report |
|---|---|
| reads or writes a freed allocation | `use-after-free`, with the allocation's id |
| reads or writes outside every live allocation | `out-of-bounds` |
| frees an allocation twice | `double free`, with the allocation's id |
| frees a pointer `malloc` did not return | `free of unknown pointer` |

The program stops at the first report. Native images and `--jit` make none of
these checks.

`--trace` prints each SSA instruction the interpreter executes to stderr, one
line each: the function, the block, the value number and the instruction
(`main b0 v1 Imm(0)`). The program's own output stays on stdout.

### Library

The interpreter has its own C library. It provides `malloc`, `calloc`,
`realloc`, `free`, `memcpy`, `memmove`, `memset`, `memcmp`, `printf`,
`fprintf`, `fputs`, `puts`, `fputc`, `putc`, `putchar`, `fwrite`, `fflush`,
`fileno`, `stdin`, `stdout`, `stderr`, `open`, `read`, `write`, `close`,
`getenv`, `setenv`, `_putenv_s`, `exit`, and the `dlopen` family. Calls that
badc compiles to instructions, such as `sqrt`, `fabs`, `floor` and `labs`,
also work.

The `<string.h>` functions are there: `strlen`, `strnlen`, `strcmp`,
`strncmp`, `strcoll`, `strxfrm`, `strcpy`, `strncpy`, `stpcpy`, `stpncpy`,
`strcat`, `strncat`, `strchr`, `strrchr`, `strchrnul`, `memchr`, `memrchr`,
`strstr`, `strcasestr`, `memmem`, `strspn`, `strcspn`, `strpbrk`, `strdup`,
`strndup`, `strtok` and `strtok_r`, with `strcasecmp`, `strncasecmp`,
`bzero`, `bcopy`, `bcmp`, `index` and `rindex` from `<strings.h>` and the
msvcrt spellings `_strdup`, `_stricmp` and `_strnicmp`. So are the
`<ctype.h>` classification functions and `tolower` and `toupper`, in the
"C" locale. A comparison returns what the target's C library returns: the
byte difference from glibc and Apple's libc, -1 or 1 from msvcrt's
`strcmp`. A true classification is glibc's table bit, 1 on macOS, and
msvcrt's `_ctype` bits on Windows.

The numeric conversions `atoi`, `atol`, `atoll`, `atof`, `strtol`,
`strtoul`, `strtoll`, `strtoull`, `strtoimax`, `strtoumax`, `strtod`,
`strtof` and `strtold`, and `abs`, `labs`, `llabs` and `imaxabs`, convert
as the target's C library does. `long` is 32 bits on Windows, where `atoi`
clamps to `int`. A decimal or hexadecimal subject rounds correctly to the
type in the current rounding direction, `strtold` to the target's `long
double`: x87 extended on linux-x64, binary128 on linux-aarch64, `double`
elsewhere. Out of range, `errno` is `ERANGE`; for a base outside 0 and 2
to 36 it is `EINVAL`, and on macOS also when the string holds no number.

The formatted output functions share one engine: `printf`, `fprintf`,
`dprintf`, `sprintf`, `snprintf`, `asprintf` and their `va_list` forms,
and msvcrt's `_snprintf`, `_vsnprintf` and `_vscprintf`. It reads a `long
double` in the target's format and writes `%a` and `%La` as the target's C
library does: `0xcp-3` for 1.5L on linux-x64, `0x1.8p+0` on the AArch64
targets, `0x1.8000000000000p+0` on Windows. `%p` writes a null pointer as
`(nil)` on Linux, `0x0` on macOS and `0000000000000000` on Windows.

Any other library call stops the program when it is reached:

```console
error: runtime: vm_ssa: library call `sscanf` is not implemented under --interp
```

Among the calls not implemented are the `scanf` family, `fopen` and
`fgets`, `strerror`, `qsort`, `time`, `setjmp`, `signal` and
`pthread_create`.

### Other limits

* Inline asm runs for x86-64 and AArch64 instructions on general registers.
  Memory operands, `asm goto`, vector registers, condition-flag outputs and
  system registers are refused at the `asm` statement.
* A structured exception handling region (`__try`) is refused with B4001
  `unsupported`.

The `programs` test suite runs its fixtures in the interpreter with pointer
tracking on. The native backends are checked against exit codes measured
with gcc and clang, not against the interpreter; see [testing](testing.md).
