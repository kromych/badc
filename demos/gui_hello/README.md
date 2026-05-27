# gui_hello

Three minimal "show a window with a label" demos -- one per
OS family. Each is a single C source file; the smoke runner
asks badc to cross-compile every source to every supported
target so the build verifies on any host.

| File             | Target families                    | What it links against        |
|------------------|------------------------------------|------------------------------|
| `hello_win32.c`  | `windows-x64`, `windows-arm64`     | user32.dll, gdi32.dll, kernel32.dll |
| `hello_x11.c`    | `linux-x64`, `linux-aarch64`       | libX11.so.6                  |
| `hello_macos.c`  | `macos-aarch64`                    | libobjc.A.dylib + AppKit.framework |

## Workflow

```sh
python demos/gui_hello/smoke.py    # builds all five targets via badc
                                   # and exits 0 on a clean build.
                                   # Runs build-only -- no display
                                   # server is required.

# Local run (matches your host):
./demos/gui_hello/.build/hello-<your-target>
```

## What each demo exercises

* **`hello_win32.c`** -- Pins the GUI subsystem via
  `#pragma subsystem(windows)` so the PE optional header
  carries `IMAGE_SUBSYSTEM_WINDOWS_GUI = 2` instead of the
  default console value, and `#pragma entrypoint(WinMain)` so
  the loader resolves `WinMain` rather than `main`.
  Drives the standard `WNDCLASSA` / `RegisterClassA` /
  `CreateWindowExA` / `GetMessageA` / `DispatchMessageA` loop;
  paints "Hello from badc!" via `BeginPaint` / `TextOutA` /
  `EndPaint`. Closing the window posts `WM_DESTROY` and the
  loop exits.
* **`hello_x11.c`** -- Connects to `$DISPLAY`, opens an
  `XCreateSimpleWindow`, registers for Expose / KeyPress, and
  draws "Hello from badc!" on every Expose. Any keypress
  closes the connection. The X11 surface is C-only, no
  Objective-C / GLib / Wayland involvement.
* **`hello_macos.c`** -- Drives the Cocoa runtime through
  `libobjc.A.dylib`'s `objc_getClass` / `sel_registerName` /
  `objc_msgSend`. NSApplication / NSWindow / NSString are all
  reached by message-send rather than ObjC syntax; the c5
  compiler doesn't speak Objective-C, but the runtime ABI is
  pure C so the demo composes cleanly. Opens a 480x240
  NSWindow titled "badc Cocoa hello" and runs `[NSApp run]`
  until the window closes.

## CI

The smoke step is build-only -- runners don't have display
servers, X servers, or Window Stations. Each runner runs
`python demos/gui_hello/smoke.py`, which loops over the five
(target, source) combinations and asks badc to produce a
binary; a non-zero exit on any combination fails CI. Local
developers can run the matching binary directly to see the
actual window.

## Why one demo per OS

A single cross-platform GUI source is possible (SDL2 / GLFW /
raylib all cover the three OSes), but bundling those would
make the demo a vendored-third-party-deps test rather than a
GUI test. Hand-writing the per-OS minimum keeps the demo
self-contained and surfaces any OS-specific c5 codegen / ABI
gaps directly. Future GUI demos (raylib, ...) can sit
alongside this one without overlap.
