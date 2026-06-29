# raylib

badc compiles [raylib](https://github.com/raysan5/raylib) 5.5 from
source and links a small game (Lode Runner) into a standalone binary.
Unlike `gui_hello`, which binds the platform window APIs directly, this
demo builds the whole graphics library through badc: the only external
dependencies are the OS-level windowing / GL libraries every program
must reach.

## Backend

raylib's default desktop backend is GLFW, whose macOS layer is
Objective-C. badc compiles no Objective-C, so the demo selects raylib's
**RGFW** backend (`PLATFORM_DESKTOP_RGFW`), a single-header C windowing
library that drives Cocoa through `objc_msgSend` from C, Win32 on
Windows, and X11 on Linux. OpenGL 3.3 entry points come from raylib's
bundled `glad`, loaded at runtime; the OS frameworks (Cocoa / CoreVideo
/ CoreGraphics / OpenGL on macOS) are recorded as `LC_LOAD_DYLIB`
commands so their Objective-C classes register at launch.

The build is asset-free: rectangles and text only (the embedded default
font), so no image or audio file loaders are compiled.

## Layout

| File | Role |
|------|------|
| `setup.py` | Fetch + sha-verify raylib 5.5; patch `config.h` to the asset-free profile. |
| `loderunner.h` / `loderunner_logic.c` | Game state + the pure `level_step` logic (references no raylib symbol). |
| `loderunner.c` | The renderer (`level_draw`) and frame loop; the only raylib caller. |
| `test_loderunner.c` | Headless logic self-test; links the pure logic, runs on any host. |
| `include/` | Hand-authored macOS platform headers (objc, CoreGraphics, CoreFoundation, CoreVideo, OpenGL CGL) + the framework-binding header. |
| `smoke.py` | Build + run harness. |

## Workflow

```sh
python demos/raylib/smoke.py        # logic self-test on any host;
                                    # full standalone build + headless
                                    # run on macOS.

# Play it (macOS, with a display):
./demos/raylib/.build/loderunner    # arrows / WASD move; Q / E dig;
                                    # R restarts. Collect the gold, then
                                    # climb the exit ladders.
```

`otool -L` on the produced binary shows only OS frameworks -- no
`libraylib`. The game is built entirely by badc.

## Platform status

macOS is the standalone target today. The Linux (X11 / GLX) and Windows
(Win32 / WGL) header surfaces RGFW needs are not yet authored as badc
headers, so on those hosts `smoke.py` runs the logic self-test only.
