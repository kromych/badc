#!/usr/bin/env python3
"""Build the gui_hello demos against badc -- one platform-
specific source file per OS, all behind the same `badc
--target=<spec>` invocation.

CI runs this build-only -- the runners don't have a display
server, X server, or Window Station -- so we just verify each
host's matching source compiles cleanly to its native binary
format. A developer can then run the produced binary locally
to see the actual window.

Three sources:

* `hello_win32.c`  -- Win32 GUI app. Uses the new
   `#pragma subsystem(windows)` + `#pragma entrypoint(WinMain)`
   shape (gh #32 / gh #55) so the loader resolves `WinMain`
   instead of `main` and skips the auto-attach to a console
   window.
* `hello_x11.c`    -- libX11.so.6 client for Linux.
* `hello_macos.c`  -- Cocoa app on macOS, driven via raw
   `objc_msgSend` against `libobjc.A.dylib`.

The runner picks the matching source for the host -- the
other two are still verified to build via the cross-target
column (each runner builds for its own target). Override the
badc binary via `BADC=path/to/badc`.
"""

from __future__ import annotations

import os
import subprocess
import sys
from pathlib import Path

GUI_DIR = Path(__file__).resolve().parent
REPO_ROOT = GUI_DIR.parent.parent
WIN = sys.platform == "win32"


def resolve_badc() -> Path:
    env = os.environ.get("BADC")
    candidates = []
    if env:
        candidates.append(Path(env))
    default = REPO_ROOT / "target" / "release" / "badc"
    candidates.extend([default, default.with_suffix(".exe")])
    for cand in candidates:
        if cand.is_file() and os.access(cand, os.X_OK):
            return cand
    print(
        f"smoke: BADC binary not found / not executable\n"
        f"       hint: cargo build --release --manifest-path={REPO_ROOT}/Cargo.toml",
        file=sys.stderr,
    )
    sys.exit(2)


# (target spec, source file, output suffix). The CLI's `--target`
# is the build's source of truth; the runner-script build step
# loops over this table and asks badc to produce one binary
# per row.
BUILDS = (
    ("windows-x64",    "hello_win32.c", ".exe"),
    ("windows-arm64",  "hello_win32.c", ".exe"),
    ("linux-x64",      "hello_x11.c",   ""),
    ("linux-aarch64",  "hello_x11.c",   ""),
    ("macos-aarch64",  "hello_macos.c", ""),
)


def main() -> int:
    badc = resolve_badc()
    work = GUI_DIR / ".build"
    work.mkdir(parents=True, exist_ok=True)

    failures: list[str] = []
    for target, source, suffix in BUILDS:
        src = GUI_DIR / source
        out = work / f"hello-{target}{suffix}"
        cmd = [str(badc), f"--target={target}", str(src), "-o", str(out)]
        if target.startswith("windows"):
            cmd.extend(["-include", "msvc_compat.h"])
        proc = subprocess.run(cmd, capture_output=True, text=True)
        # The driver prints a warning about cross-host execution
        # ("badc: produced a Foo binary on a non-Foo host"); a
        # successful build still exits 0. Anything non-zero is a
        # real failure.
        if proc.returncode != 0:
            failures.append(
                f"[{target}] {source}: exit {proc.returncode}\n"
                f"  stdout: {proc.stdout.strip()}\n"
                f"  stderr: {proc.stderr.strip()}"
            )
            continue
        if not out.exists() or out.stat().st_size == 0:
            failures.append(f"[{target}] {source}: produced no output")
            continue
        print(f"build OK [{target}]: {source} -> {out.name} ({out.stat().st_size} bytes)")

    if failures:
        print("\nsmoke FAIL:", file=sys.stderr)
        for f in failures:
            print(f"  {f}", file=sys.stderr)
        return 1
    print("\ngui_hello smoke: all 5 targets built cleanly")
    return 0


if __name__ == "__main__":
    sys.exit(main())
