# Shared demo headers

Hand-authored header declarations for libraries and platform interfaces that
real-world C programs `#include` but that are not part of the C standard
library and so are not in badc's embedded header set (`libc/include/`).
badc's include search is hermetic -- it consults its embedded headers plus
explicit `-I` paths, never the host's default system include directories -- so
a program that uses one of these cannot find its header unless it is provided
explicitly.

Point badc at this directory to build such programs:

    badc -I demos/include prog.c ...

Each header declares only the types, constants, and entry points that the
programs here use; unused API, documentation, and host-platform machinery are
omitted. Where a header mirrors a real library, the ABI (type sizes, struct
layout, constant values, signatures) matches that library, whose
implementation is linked in as usual.

## Contents

- **Third-party libraries**: `zlib.h` (zlib compression), `libfdt.h` (flattened
  device tree; self-contained, folds in the upstream `fdt.h` and
  `libfdt_env.h`), and `cbor.h` (libcbor decode accessors + encode/build API).
- **Platform / windowing / graphics**: the objc runtime and Cocoa, Core*,
  OpenGL/CGL frameworks (macOS); win32 / WGL surfaces (Windows); X11 / GLX
  (Linux); plus `GL/`, `dirent.h`, and the RGFW framework-binding headers.
  These back the windowed demos (e.g. `demos/raylib`).
