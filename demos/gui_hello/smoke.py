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

`--sdk` builds `hello_win32_sdk.c` instead, against the installed Windows
SDK's <windows.h> and import libraries, for both Windows targets; on a
Windows host it runs the build of the host's architecture with `--smoke`.
A target whose SDK is not installed is reported and skipped.
"""

from __future__ import annotations

import importlib.util
import os
import platform
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


def _win_kits():
    spec = importlib.util.spec_from_file_location("_win_kits", GUI_DIR.parent / "_win_kits.py")
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


def host_windows_target() -> str | None:
    if sys.platform != "win32":
        return None
    return {"AMD64": "windows-x64", "ARM64": "windows-arm64"}.get(platform.machine().upper())


def sdk_main() -> int:
    """Build the SDK form for each Windows target and run the host's."""
    kits = _win_kits()
    badc = resolve_badc()
    work = GUI_DIR / ".build"
    work.mkdir(parents=True, exist_ok=True)
    built, failures = 0, []
    for target in ("windows-x64", "windows-arm64"):
        found = kits.sdk_flags(target, ["user32", "gdi32", "kernel32"])
        if found is None:
            print(f"skip [{target}]: no Windows SDK with um headers and {target} libraries")
            continue
        version, flags = found
        out = work / f"hello-sdk-{target}.exe"
        out.unlink(missing_ok=True)
        cmd = [str(badc), "-O", f"--target={target}", *flags, str(GUI_DIR / "hello_win32_sdk.c")]
        proc = subprocess.run([*cmd, "-o", str(out)], capture_output=True, text=True)
        if proc.returncode != 0 or not out.is_file():
            failures.append(f"[{target}] SDK {version}: exit {proc.returncode}\n{proc.stderr.strip()}")
            continue
        built += 1
        print(f"build OK [{target}]: SDK {version} -> {out.name} ({out.stat().st_size} bytes)")
        if target == host_windows_target():
            run = subprocess.run([str(out), "--smoke"], capture_output=True, timeout=60)
            if run.returncode != 0:
                failures.append(f"[{target}] {out.name} --smoke: exit {run.returncode}")
            else:
                print(f"run OK [{target}]: {out.name} --smoke created and closed its window")
    if failures:
        print("\nsmoke FAIL:", file=sys.stderr)
        for f in failures:
            print(f"  {f}", file=sys.stderr)
        return 1
    print(f"\ngui_hello SDK smoke: {built} target(s) built")
    return 0


def main() -> int:
    if "--sdk" in sys.argv[1:]:
        return sdk_main()
    badc = resolve_badc()
    work = GUI_DIR / ".build"
    work.mkdir(parents=True, exist_ok=True)

    failures: list[str] = []
    for target, source, suffix in BUILDS:
        src = GUI_DIR / source
        out = work / f"hello-{target}{suffix}"
        cmd = [str(badc), "-O", f"--target={target}", str(src), "-o", str(out)]
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
