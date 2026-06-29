#!/usr/bin/env python3
"""Smoke test for the raylib demo: badc compiles raylib 5.5 (RGFW
desktop backend) from source and links the Lode Runner game into a
standalone binary.

Two layers:

* The pure game-logic self-test (`test_loderunner.c` +
  `loderunner_logic.c`) references no raylib symbol, so it builds and
  runs through badc on any host and under register pressure. It is the
  regression for the game code itself.

* The full standalone build compiles every raylib module + the renderer
  + game through badc and links against the platform's windowing / GL
  libraries. It runs on macOS today (the RGFW Cocoa backend reached via
  objc_msgSend is pure C, and the macOS platform headers ship under
  `include/`). The X11 / Win32 header surface for the Linux and Windows
  standalone builds is not yet authored, so those hosts run the
  logic self-test only.

Override the badc binary via `BADC` (default
`target/release/badc[.exe]`).
"""

from __future__ import annotations

import os
import subprocess
import sys
import tempfile
from pathlib import Path

RAYLIB_DIR = Path(__file__).resolve().parent
REPO_ROOT = RAYLIB_DIR.parent.parent
WIN = sys.platform == "win32"
MAC = sys.platform == "darwin"
EXE = ".exe" if WIN else ""

RAYLIB_MODULES = ("rcore", "rshapes", "rtextures", "rtext", "utils")
DEFINES = (
    "-DPLATFORM_DESKTOP_RGFW",
    "-DGRAPHICS_API_OPENGL_33",
    "-DSTBIR_NO_SIMD",
    "-DRGFW_NO_THREADS",
)


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
        "smoke: BADC binary not found / not executable\n"
        f"       hint: cargo build --release --manifest-path={REPO_ROOT}/Cargo.toml",
        file=sys.stderr,
    )
    sys.exit(2)


def run(cmd, **kw):
    return subprocess.run(cmd, check=False, **kw)


def logic_self_test(badc: Path, work: Path) -> bool:
    """Build + run the pure game-logic self-test at -O0 and -O."""
    ok = True
    for opt in ("", "-O"):
        out = work / f"test_loderunner{'_O' if opt else ''}{EXE}"
        cmd = [str(badc)]
        if opt:
            cmd.append(opt)
        cmd += [
            "-I", str(RAYLIB_DIR),
            str(RAYLIB_DIR / "test_loderunner.c"),
            str(RAYLIB_DIR / "loderunner_logic.c"),
            "-o", str(out),
        ]
        if run(cmd).returncode != 0:
            print(f"smoke FAIL: logic self-test build ({opt or '-O0'})", file=sys.stderr)
            ok = False
            continue
        if run([str(out)]).returncode != 0:
            print(f"smoke FAIL: logic self-test run ({opt or '-O0'})", file=sys.stderr)
            ok = False
    if ok:
        print("smoke OK: game-logic self-test (-O0 and -O)")
    return ok


def build_standalone(badc: Path, work: Path) -> bool:
    """Compile raylib + the game through badc, link a standalone binary,
    and auto-play it headless for a few frames. macOS only for now."""
    src = RAYLIB_DIR / "src"
    inc = RAYLIB_DIR / "include"
    objs = []
    for mod in RAYLIB_MODULES:
        obj = work / f"{mod}.o"
        cmd = [str(badc), "-c", *DEFINES]
        if mod == "rcore":
            cmd += ["-include", "rgfw_macos_link.h"]
        cmd += ["-I", str(inc), "-I", str(src), "-o", str(obj), str(src / f"{mod}.c")]
        if run(cmd).returncode != 0:
            print(f"smoke FAIL: raylib module {mod} did not compile", file=sys.stderr)
            return False
        objs.append(obj)

    archive = work / "libraylib.a"
    if run([str(badc), "--ar", "-o", str(archive), *map(str, objs)]).returncode != 0:
        print("smoke FAIL: libraylib.a archive", file=sys.stderr)
        return False

    game_obj = work / "loderunner.o"
    logic_obj = work / "loderunner_logic.o"
    if run([str(badc), "-c", *DEFINES, "-I", str(inc), "-I", str(src),
            "-o", str(game_obj), str(RAYLIB_DIR / "loderunner.c")]).returncode != 0:
        print("smoke FAIL: loderunner.c did not compile", file=sys.stderr)
        return False
    if run([str(badc), "-c", "-I", str(RAYLIB_DIR),
            "-o", str(logic_obj), str(RAYLIB_DIR / "loderunner_logic.c")]).returncode != 0:
        return False

    game = work / f"loderunner{EXE}"
    if run([str(badc), *DEFINES, str(game_obj), str(logic_obj), str(archive),
            "-o", str(game)]).returncode != 0:
        print("smoke FAIL: standalone link", file=sys.stderr)
        return False
    print(f"smoke OK: standalone build -> {game.name} ({game.stat().st_size} bytes)")

    # Auto-play a few frames. A windowing session is required; if the run
    # cannot reach the display server it is skipped, not failed.
    proc = run([str(game), "--selftest", "--frames", "30"],
               capture_output=True, text=True, timeout=30)
    if proc.returncode == 0:
        print("smoke OK: standalone game ran 30 frames")
        return True
    if "DISPLAY" in proc.stderr or "WindowServer" in proc.stderr or proc.returncode is None:
        print("smoke SKIP: no windowing session to run the game")
        return True
    print(f"smoke FAIL: standalone run exit {proc.returncode}\n{proc.stderr[-400:]}",
          file=sys.stderr)
    return False


def main() -> int:
    badc = resolve_badc()
    subprocess.run([sys.executable, str(RAYLIB_DIR / "setup.py")], check=True)

    with tempfile.TemporaryDirectory(prefix="raylib-smoke-") as work_str:
        work = Path(work_str)
        ok = logic_self_test(badc, work)
        if MAC:
            ok &= build_standalone(badc, work)
        else:
            print("smoke SKIP: standalone build (X11 / Win32 header surface pending); "
                  "logic self-test only on this host")
        return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
