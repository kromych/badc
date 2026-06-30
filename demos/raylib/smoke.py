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
  libraries. It runs on macOS (Cocoa via objc_msgSend) and Linux (X11 /
  GLX); the platform headers ship as demo-local embedded headers under
  `include/`. The windowed run needs a display server: macOS uses the
  login session, Linux uses `Xvfb` when present (otherwise the run is
  skipped, not failed). The Windows standalone surface is pending.

Override the badc binary via `BADC` (default
`target/release/badc[.exe]`).
"""

from __future__ import annotations

import os
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

RAYLIB_DIR = Path(__file__).resolve().parent
REPO_ROOT = RAYLIB_DIR.parent.parent
WIN = sys.platform == "win32"
MAC = sys.platform == "darwin"
LINUX = sys.platform.startswith("linux")
EXE = ".exe" if WIN else ""


# Defines common to every platform, then the per-platform additions. The
# Linux lane forces the scalar stb_image decoder (x86_64 otherwise pulls
# __m128i) and trims the RGFW surface to the parts the game needs.
BASE_DEFINES = (
    "-DPLATFORM_DESKTOP_RGFW",
    "-DGRAPHICS_API_OPENGL_33",
    "-DSTBIR_NO_SIMD",
    "-DRGFW_NO_THREADS",
)
LINUX_DEFINES = (
    "-DSTBI_NO_SIMD",
    "-DRGFW_NO_X11_CURSOR",
    "-DRGFW_NO_DPI",
    "-DRGFW_NO_X11_XI_PRELOAD",
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


def _config_defines(config_h: Path) -> list[str]:
    """Externalize raylib's config.h as `-D` flags. EXTERNAL_CONFIG_FLAGS
    makes raylib skip config.h entirely, so every single-token define (not
    just the SUPPORT_* set -- the render-batch sizes and cull distances
    otherwise default to zero and the frame draws blank) is re-passed,
    minus MP3 (its decoder is NEON-only and badc has no vector intrinsics)."""
    import re

    seen: dict[str, str] = {}
    for m in re.finditer(
        r"^\s*#define\s+([A-Za-z_]\w*)\s+([^/\n]+?)\s*(?://.*)?$",
        config_h.read_text(),
        re.M,
    ):
        name, val = m.group(1), m.group(2).strip()
        if name == "SUPPORT_FILEFORMAT_MP3" or " " in val or "(" in val:
            continue
        seen[name] = val
    return [f"-D{k}={v}" for k, v in seen.items()]


def platform_build(badc: Path, work: Path) -> bool:
    """Compile the full raylib (every module + fileformat) + the game
    through badc, link a standalone binary, and auto-play it headless.
    macOS links the CoreAudio backend for real playback; the Linux audio
    backend (ALSA) is not yet authored, so raudio is left out there and
    the game's audio is compiled out -- sprites and textures still load."""
    subprocess.run([sys.executable, str(RAYLIB_DIR / "setup.py")], check=True)
    src = RAYLIB_DIR / "src"
    inc = RAYLIB_DIR / "include"
    # `--gnu` so raylib's GCC-gated correct paths compile (sinfl_bsr's
    # __builtin_clz, miniaudio's atomics). The decoders' SIMD is off (no
    # vector intrinsics in badc); empty-template asm barriers and GCC
    # pragmas are handled by badc. raymath's RMAPI is plain `inline` in
    # every module but the one that sets RAYMATH_IMPLEMENTATION (`extern
    # inline`); badc gives the inline-only copies internal linkage per
    # C99 6.7.4p7, so they do not collide across modules.
    defines = ["--gnu", *BASE_DEFINES, "-DSTBI_NO_SIMD",
               "-DMA_NO_NEON", "-DMA_NO_SSE2", "-DMA_NO_AVX2",
               "-DDRFLAC_NO_NEON", "-DDRFLAC_NO_SIMD",
               "-DEXTERNAL_CONFIG_FLAGS", *_config_defines(src / "config.h")]

    if MAC:
        modules = ("rcore", "rshapes", "rtextures", "rtext", "rmodels", "raudio", "utils")
        rcore_extra = ["-include", "rgfw_macos_link.h"]
        defines.append("-DGAME_AUDIO")
    else:
        modules = ("rcore", "rshapes", "rtextures", "rtext", "rmodels", "utils")
        defines += list(LINUX_DEFINES)
        rcore_extra = ["-include", "rgfw_x11_link.h",
                       "-include", "X11/extensions/Xrandr.h"]

    objs = []
    for mod in modules:
        obj = work / f"{mod}.o"
        cmd = [str(badc), "-c", *defines]
        if mod == "rcore":
            cmd += rcore_extra
        if mod == "raudio":
            cmd += ["-include", "audio_macos_link.h"]
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
    if run([str(badc), "-c", *defines, "-I", str(inc), "-I", str(src),
            "-o", str(game_obj), str(RAYLIB_DIR / "loderunner.c")]).returncode != 0:
        print("smoke FAIL: loderunner.c did not compile", file=sys.stderr)
        return False
    if run([str(badc), "-c", "-I", str(RAYLIB_DIR),
            "-o", str(logic_obj), str(RAYLIB_DIR / "loderunner_logic.c")]).returncode != 0:
        return False

    game = work / f"loderunner{EXE}"
    if run([str(badc), *defines, str(game_obj), str(logic_obj), str(archive),
            "-o", str(game)]).returncode != 0:
        print("smoke FAIL: standalone link", file=sys.stderr)
        return False
    print(f"smoke OK: standalone build -> {game.name} ({game.stat().st_size} bytes)")

    return windowed_run(game, work)


def windowed_run(game: Path, work: Path) -> bool:
    """Auto-play a few frames and assert the rendered frame is not blank.
    A windowing session is required; on Linux it is provided by Xvfb when
    installed. Without one the run is skipped, not failed."""
    ppm = work / "frame.ppm"
    argv = [str(game), "--assets", str(RAYLIB_DIR / "assets"), "--dump-frame", str(ppm)]
    xvfb = shutil.which("xvfb-run") if LINUX else None
    if LINUX and not xvfb:
        print("smoke SKIP: Xvfb not installed (dnf install xorg-x11-server-Xvfb); "
              "standalone built + linked but not run")
        return True
    if xvfb:
        argv = [xvfb, "-a", "-s", "-screen 0 1024x768x24"] + argv

    proc = run(argv, capture_output=True, text=True, timeout=60)
    if proc.returncode != 0:
        if any(s in proc.stderr for s in ("DISPLAY", "WindowServer", "display")):
            print("smoke SKIP: no windowing session to run the game")
            return True
        print(f"smoke FAIL: standalone run exit {proc.returncode}\n{proc.stderr[-400:]}",
              file=sys.stderr)
        return False

    if not ppm.is_file():
        print("smoke SKIP: no windowing session to run the game")
        return True
    colors = _distinct_colors(ppm)
    if colors < 6:
        print(f"smoke FAIL: rendered frame has only {colors} distinct colors "
              "(blank / clear-only render)", file=sys.stderr)
        return False
    print(f"smoke OK: standalone game rendered a frame ({colors} distinct colors)")
    return True


def _distinct_colors(ppm: Path) -> int:
    """Count distinct RGB triples in a binary P6 PPM."""
    data = ppm.read_bytes()
    i = 0

    def tok(buf, j):
        while buf[j] in b" \t\n\r":
            j += 1
        s = j
        while buf[j] not in b" \t\n\r":
            j += 1
        return buf[s:j], j

    _, i = tok(data, i)  # magic
    w, i = tok(data, i)
    h, i = tok(data, i)
    _, i = tok(data, i)  # maxval
    i += 1
    px = data[i:i + int(w) * int(h) * 3]
    return len({px[k:k + 3] for k in range(0, len(px), 3)})


def main() -> int:
    badc = resolve_badc()

    with tempfile.TemporaryDirectory(prefix="raylib-smoke-") as work_str:
        work = Path(work_str)
        ok = logic_self_test(badc, work)
        if MAC or LINUX:
            ok &= platform_build(badc, work)
        else:
            print("smoke SKIP: standalone build (Win32 surface pending); "
                  "logic self-test only on this host")
        return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
