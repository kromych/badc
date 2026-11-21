# System Informer

System Informer 4.0.26241.138 -- the process, service and system monitor,
its PE viewer, and phlib's self-test -- built with badc for windows-x64 and
windows-arm64 from its own CMake lists, and run.

```bat
cargo build --release --features full
python demos\systeminformer\smoke.py
```

`setup.py` fetches GitHub's archive of the `v4.0.26241.138` tag from the
vendor-deps mirror (sha256-pinned). `build.py` builds one optimization level
under `.cache\build-<arch>[-O0]`; `smoke.py` builds -O0 and -O and runs:

- `phlib-test.exe`, phlib's self-test: 278 `assert()`s over the string
  routines, the AVL tree, number formatting and the utilities;
- `SystemInformer.exe -nosettings -nokph -noplugins -newinstance` and
  `peview.exe` on a system DLL, each of which must still run after 10 s.

The build runs on a Windows host with the Windows SDK and MSVC installed;
`BADC_WINDOWS_KITS` and `BADC_MSVC_TOOLS` name others (`demos/_win_kits.py`).

## How the build follows SI's

SI describes its build twice: MSBuild projects, from which its releases are
built, and CMake lists with an MSVC and a clang-cl configuration. `build.py`
evaluates the CMake lists and SI's `cmake/` modules -- `set`, `list`, `if`,
`include`, `add_subdirectory`, the target commands and their PUBLIC and
INTERFACE usage requirements, and the custom command running mc.exe -- as
the clang-cl toolchain files configure them (`MSVC` with a `Clang` C
compiler, so `MSVC_CLANG`): the configuration for a GNU-compatible C
compiler. A command outside that subset stops the evaluation, so a new
version's lists that need more say so.

| step | tool |
|---|---|
| C units (456) | badc `--msvc -nostdlibinc`, against MSVC's include directory and the SDK's ucrt, um, shared and winrt |
| C++ units (19) | cl `/O2 /MT /EHsc /std:c++latest`: SI's MSVC release flags but `/W3 /WX` |
| SymCrypt assembly | ml64 (x64, 9 files) or armasm64 (arm64, 3 files) |
| kphlib's message table | mc.exe, the CMake custom command |
| resource scripts and manifests | rc.exe; a manifest becomes RT_MANIFEST resource 1, as link.exe embeds it |
| archives and images | badc `--ar` and badc's linker, with the static VC runtime and the UCRT DLL (`-llibvcruntime -llibcmt -lucrt`) |

What the CMake lists alone do not give:

- `cmake/tools.cmake` is not read: it stops unless SI's C# CustomBuildTool is
  built, and serves only the plugin SDK (`si_sdkbuild`) and driver signing
  (`si_kphsign`), neither of which this build produces.
- kphlib's generated `sistatus.rc` joins both programs, as their MSBuild
  projects compile it; the CMake lists name it as a custom command's output
  only.
- `delayimp` is not linked: badc's `--delayload` supplies the delay-load
  helper link.exe takes from it.
- phlib-test has only an MSBuild project; `build.py` reads its Release
  sources, definitions and libraries, links phlib's CMake target with what
  that links, and leaves out `NDEBUG`, which would compile its checks out.
- The clang-cl toolchain file's global `-mavx`..`-mavx512vl` are not passed:
  under them code testing those macros may use AVX-512 on a CPU without it.
  The target lists' own clang options are: SymCrypt's `-m` extensions and
  SI's `-Wno-` list.

## Locale

phlib formats numbers with the user locale's separators. phlib-test's
formatting checks expect `.` and `,`; under a locale with another decimal
separator the first of them fails whatever compiler built the test. The
smoke then requires exactly that failure, after which the string and tree
checks before it have passed.

## Measured

On the Windows x64 box (Ryzen, VC 14.52, SDK 10.0.28000.0) and the Windows
arm64 box (VC 14.44): all 456 C units, 19 C++ units and the assembly build at
both levels. The smoke takes 65 and 70 s on x64 and 108 and 109 s on arm64 for
-O0 and -O. phlib-test passes on x64 at both levels; on the arm64 box, whose
user locale is `es-ES`, it stops at its first formatting check, as above.

Found and fixed while bringing it up:

- the x86-64 emitter took a counted loop's decrement flags for a second
  branch on the same value in a later block, so phlib formatted 1234 as
  `1234` at -O (`a_step_read_by_a_later_branch.c`);
- `--msvc` did not search a quoted include in the directories of the
  including files, as cl does; all of peview's units stopped there;
- `-mcx16`, which SymCrypt's clang options pass, was refused, though badc
  emits CMPXCHG16B; and `-march=native` failed on every x86-64 host.

TODO: the plugins (`SI_WITH_PLUGINS`), which need the plugin SDK headers
CustomBuildTool generates and an import library of SystemInformer.exe.
