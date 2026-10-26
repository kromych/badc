# Nuklear demo

Builds [Nuklear](https://github.com/Immediate-Mode-UI/Nuklear) at commit
`a7353204d0` (four past 4.13.3, whose `demo/gdi/main.c` does not compile), the
single-header immediate-mode GUI library, with badc, checks what upstream's
CI checks, and runs the upstream demo windows headlessly against a
host-compiler build.

Nuklear has no unit tests. Its CI (`.github/workflows/ccpp.yml`)
regenerates `nuklear.h` from `src/` and requires it to match the committed
header, builds every demo and the example against its GPU or windowing
library, and compiles each `src/*.c` on its own
(`.github/ci_compile_sources.sh`).

The source tree is **not committed**: `setup.py` fetches the GitHub archive
of that commit from the `kromych/badc` vendor-deps release (as
`nuklear-a7353204d0-fc259d26.tar.gz`) or, while the release lacks it, from
GitHub, verifies its sha256, and extracts it under `demos/nuklear/.cache/`.
No patches.

## Files

| File         | Tracked? | Purpose                                                       |
|--------------|:--------:|---------------------------------------------------------------|
| `setup.py`   | yes      | Fetch + extract the pinned tag archive. Idempotent.           |
| `smoke.py`   | yes      | The checks below.                                             |
| `headless.c` | yes      | Drives the demo windows into a memory framebuffer.            |
| `.cache/`    | no       | Cached archive and the extracted tree.                        |

## Workflow

```sh
python demos/nuklear/setup.py     # fetches into demos/nuklear/.cache/
python demos/nuklear/smoke.py     # the checks, at -O0 and -O
```

`smoke.py` prints `nuklear smoke OK` and returns 0 when every check passes,
and 1 with a line naming the failed step otherwise. It honours
`BADC=path/to/badc`.

## What the smoke does

1. **Header.** Runs `src/build.py` with the file lists of the Makefile's
   `nuke` recipe and compares the output with the shipped `nuklear.h`.
2. **Sources.** Compiles each of the 42 `src/*.c` with badc and the flags of
   `ci_compile_sources.sh` (`-std=c89 -Wall -Wextra -Wpedantic` and the
   `NK_INCLUDE_*` set), at -O0 and -O. The script's `-x c` is left out (the
   `.c` suffix selects the same language; the driver refuses `-x`,
   [#1326](https://github.com/kromych/badc/issues/1326)) and its `-pedantic`
   is spelled `-Wpedantic`.
3. **Demos.** Builds, at -O0 and -O, the demos whose library the host has
   without a GPU: `demo/x11` and `demo/rawfb/x11` against the host's libX11
   (and libXext) on Linux, when the X11 development headers are installed,
   and `demo/gdi` on Windows. Build-only, as upstream's CI. The demos that need
   OpenGL, Vulkan, Direct3D, SDL, GLFW, Allegro, Wayland or cairo, and the
   GLFW example, are out of reach on a runner without those libraries.
4. **Headless frames.** `headless.c` includes the library, the rawfb software
   renderer and the shared demo windows (`calculator`, `overview`,
   `node_editor`, `canvas`, `style_configurator` with every theme of
   `style.c`) and runs 90 frames of scripted input: clicks on widgets found
   by their text in the previous frame, typing and editing keys in the
   calculator's display, scrolling, window and node drags, theme switches.
   Each frame's command queue goes through `nk_convert` into a vertex and
   index buffer and through the rawfb renderer into an 800x600 framebuffer
   in memory, and one line per frame gives the FNV-1a digests of the
   commands, the draw batches, the vertices, the indices and the pixels. The
   smoke builds it with badc -O0, badc -O and the host's `cc`, and requires
   the outputs to be identical and the calculator to show `57.00` after the
   scripted clicks `1 2 + 7 * 3 =`. On Windows badc -O0 is compared with
   badc -O only: badc binds msvcrt.dll's math functions, where MSVC and
   the runners' clang link the UCRT's.

Every build passes `-ffp-contract=off`: a compiler may otherwise fuse a
multiply and an add into one rounding (C99 6.5p8), which moves vertex
positions legitimately between compilers. The digests differ between the
Linux, macOS and Windows lanes (between Linux and macOS from the font atlas
stb_truetype bakes on), so they are compared within a lane, not across
lanes.
