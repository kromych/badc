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
  libraries. It runs on macOS (Cocoa via objc_msgSend), Linux (X11 / GLX)
  and Windows (win32 / WGL); the platform headers ship as demo-local
  embedded headers under `include/`. The windowed run needs a display
  server: macOS uses the login session, Linux uses `Xvfb` when present;
  the Windows runners are headless, so there the build + link is the
  coverage. A run is skipped, not failed, when no display is available.

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
        modules = ("rcore", "rshapes", "rtextures", "rtext", "rmodels", "raudio")
        rcore_extra = ["-include", "rgfw_macos_link.h"]
        defines.append("-DGAME_AUDIO")
    elif WIN:
        # No audio backend yet (WASAPI not authored), so raudio is left
        # out as on Linux. The win32 / WGL surface ships as demo-local
        # headers; rgfw_win32_link.h binds the opengl32 / gdi32 / user32 /
        # shell32 imports.
        modules = ("rcore", "rshapes", "rtextures", "rtext", "rmodels")
        rcore_extra = ["-include", "rgfw_win32_link.h"]
    else:
        modules = ("rcore", "rshapes", "rtextures", "rtext", "rmodels")
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

    logic_obj = work / "loderunner_logic.o"
    if run([str(badc), "-c", "-I", str(RAYLIB_DIR),
            "-o", str(logic_obj), str(RAYLIB_DIR / "loderunner_logic.c")]).returncode != 0:
        return False

    game = work / f"loderunner{EXE}"
    # Compile loderunner.c in the link invocation so its
    # `#pragma subsystem(windows)` drives the PE subsystem (a pragma in a
    # separately-compiled object is not visible at link). loderunner_logic.c
    # is still separately compiled to exercise the multi-object link.
    if run([str(badc), *defines, "-I", str(inc), "-I", str(src),
            str(RAYLIB_DIR / "loderunner.c"), str(logic_obj),
            str(archive), "-o", str(game)]).returncode != 0:
        print("smoke FAIL: standalone link", file=sys.stderr)
        return False
    print(f"smoke OK: standalone build -> {game.name} ({game.stat().st_size} bytes)")
    if MAC:
        app = _make_macos_app(game, RAYLIB_DIR / "assets", work)
        print(f"smoke OK: macOS bundle -> {app.name} (Finder-launch is windowed, "
              "logs beside the binary)")

    return windowed_run(badc, game, work)


def _pe_imports(path: Path) -> list[tuple[str, str]]:
    """Parse a PE32+ image's import directory into (dll, symbol) pairs.
    Ordinal-only imports carry an empty symbol. Pure stdlib so it runs on
    every box without objdump/dumpbin."""
    import struct

    data = path.read_bytes()
    pe = struct.unpack_from("<I", data, 0x3C)[0]
    if data[pe : pe + 4] != b"PE\0\0":
        return []
    n_sec = struct.unpack_from("<H", data, pe + 6)[0]
    opt = pe + 24
    if struct.unpack_from("<H", data, opt)[0] != 0x20B:  # PE32+ only
        return []
    imp_rva = struct.unpack_from("<I", data, opt + 112 + 8)[0]
    if imp_rva == 0:
        return []
    sec = pe + 24 + struct.unpack_from("<H", data, pe + 20)[0]
    spans = []
    for i in range(n_sec):
        vsize, vaddr, rawsize, rawptr = struct.unpack_from("<IIII", data, sec + i * 40 + 8)
        spans.append((vaddr, max(vsize, rawsize), rawptr))

    def off(rva: int):
        for vaddr, vsize, rawptr in spans:
            if vaddr <= rva < vaddr + vsize:
                return rawptr + (rva - vaddr)
        return None

    def cstr(o: int) -> str:
        return data[o : data.index(b"\0", o)].decode("ascii", "replace")

    out: list[tuple[str, str]] = []
    d = off(imp_rva)
    while True:
        oft, _, _, name_rva, ft = struct.unpack_from("<IIIII", data, d)
        if oft == 0 and name_rva == 0 and ft == 0:
            break
        dll = cstr(off(name_rva))
        t = off(oft or ft)
        while True:
            val = struct.unpack_from("<Q", data, t)[0]
            if val == 0:
                break
            out.append((dll, "" if val & (1 << 63) else cstr(off(val & 0x7FFFFFFF) + 2)))
            t += 8
        d += 20
    return out


def _pe_subsystem(path: Path) -> int:
    """The PE optional-header Subsystem (2 = GUI, 3 = console)."""
    import struct

    data = path.read_bytes()
    pe = struct.unpack_from("<I", data, 0x3C)[0]
    return struct.unpack_from("<H", data, pe + 24 + 68)[0]


def _validate_win_imports(badc: Path, game: Path, work: Path) -> bool:
    """Confirm every (DLL, symbol) the built exe imports resolves via
    GetProcAddress. A binding to a DLL that does not export the symbol
    fails the loader at process start (STATUS_ENTRYPOINT_NOT_FOUND), which
    a build-only smoke misses; this runs without a display."""
    pairs = [(d, s) for d, s in _pe_imports(game) if s]
    src = work / "import_probe.c"
    lines = ["#include <windows.h>", "#include <stdio.h>", "int main(void){int miss=0;"]
    for dll, sym in pairs:
        lines.append(
            f'{{HMODULE h=LoadLibraryA("{dll}");'
            f'if(!h||!GetProcAddress(h,"{sym}"))'
            f'{{printf("UNRESOLVED %s in %s\\n","{sym}","{dll}");miss++;}}}}'
        )
    lines.append(f'printf("checked {len(pairs)} imports, %d unresolved\\n",miss);')
    lines.append("return miss?1:0;}")
    src.write_text("\n".join(lines) + "\n")
    exe = work / f"import_probe{EXE}"
    if run([str(badc), str(src), "-o", str(exe)]).returncode != 0:
        print("smoke FAIL: could not build the import probe", file=sys.stderr)
        return False
    p = run([str(exe)], capture_output=True, text=True)
    if p.returncode != 0:
        print(f"smoke FAIL: standalone exe has unresolved imports\n{p.stdout}", file=sys.stderr)
        return False
    print(f"smoke OK: {p.stdout.strip()}")
    return True


def _make_macos_app(binary: Path, assets: Path, work: Path) -> Path:
    """Wrap the standalone binary in a minimal .app bundle so Finder
    launches it as a windowed app with no Terminal. Assets sit beside the
    binary in Contents/MacOS, where the game finds them via
    GetApplicationDirectory; without them it renders procedurally."""
    app = work / "loderunner.app"
    macos = app / "Contents" / "MacOS"
    macos.mkdir(parents=True, exist_ok=True)
    shutil.copy2(binary, macos / "loderunner")
    os.chmod(macos / "loderunner", 0o755)
    # Resources go in Contents/Resources, not Contents/MacOS: the bundle
    # signature seals code and resources separately, and a non-code file
    # under MacOS/ makes codesign reject the bundle.
    if assets.is_dir():
        res = app / "Contents" / "Resources"
        res.mkdir(parents=True, exist_ok=True)
        shutil.copytree(assets, res / "assets", dirs_exist_ok=True)
    (app / "Contents" / "Info.plist").write_text(
        '<?xml version="1.0" encoding="UTF-8"?>\n'
        '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" '
        '"http://www.apple.com/DTDs/PropertyList-1.0.dtd">\n'
        '<plist version="1.0"><dict>\n'
        "  <key>CFBundleName</key><string>Lode Runner</string>\n"
        "  <key>CFBundleExecutable</key><string>loderunner</string>\n"
        "  <key>CFBundleIdentifier</key><string>org.badc.loderunner</string>\n"
        "  <key>CFBundleVersion</key><string>1.0</string>\n"
        "  <key>CFBundleShortVersionString</key><string>1.0</string>\n"
        "  <key>CFBundlePackageType</key><string>APPL</string>\n"
        "  <key>NSHighResolutionCapable</key><true/>\n"
        "  <key>LSMinimumSystemVersion</key><string>11.0</string>\n"
        "</dict></plist>\n"
    )
    # Ad-hoc sign: Apple Silicon kills an unsigned binary at exec, so the
    # signature is required for the standalone binary to run. It does not make
    # the bundle double-clickable on macOS 15+, where the kernel security
    # policy refuses to launch a binary located inside a .app unless the app is
    # notarized (ad-hoc and un-notarized Developer-ID alike); the standalone
    # binary runs regardless. Sign last to seal the Info.plist and resources.
    if shutil.which("codesign"):
        run(["codesign", "--force", "--sign", "-", str(app)])
    return app


def windowed_run(badc: Path, game: Path, work: Path) -> bool:
    """Auto-play a few frames and assert the rendered frame is not blank.
    A windowing session is required; on Linux it is provided by Xvfb when
    installed. Without one the run is skipped, not failed."""
    if WIN:
        # No headless display server in the Windows session the runners use,
        # so the render is not exercised here; validate instead that every
        # import the PE records resolves against its DLL (the load gate).
        if not _validate_win_imports(badc, game, work):
            return False
        sub = _pe_subsystem(game)
        if sub != 2:
            print(f"smoke FAIL: Windows game subsystem is {sub}, expected 2 (GUI / no "
                  "console)", file=sys.stderr)
            return False
        print("smoke OK: GUI subsystem (no console window)")
        print("smoke SKIP: render needs a desktop session (Windows)")
        return True
    ppm = work / "frame.ppm"
    # `--log -` keeps raylib's console log (the game otherwise defaults to a
    # file beside the binary) so the no-display detection below still sees it.
    argv = [str(game), "--assets", str(RAYLIB_DIR / "assets"),
            "--dump-frame", str(ppm), "--log", "-"]
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
    w, h, px = _parse_ppm(ppm)
    colors = _distinct_colors(px)
    if colors < 6:
        print(f"smoke FAIL: rendered frame has only {colors} distinct colors "
              "(blank / clear-only render)", file=sys.stderr)
        return False
    # The content must reach the frame edges. The RGFW backend runs
    # SetupFramebuffer() unconditionally at window creation and derives a
    # nonzero renderOffset whenever the window is smaller than the monitor
    # with a different aspect ratio, which offsets the viewport and clips a
    # band off one edge (horizontal on a wider display, vertical on a taller
    # one); the game pins the viewport to the full render target to cancel it.
    xr, yr = _content_span(w, h, px)
    if xr < 0.93 or yr < 0.93:
        print(f"smoke FAIL: rendered content spans {xr:.2f}x{yr:.2f} of the "
              "frame (viewport offset clips an edge)", file=sys.stderr)
        return False
    print(f"smoke OK: standalone game rendered a frame ({colors} distinct "
          f"colors, content spans {xr:.2f}x{yr:.2f})")
    return True


def _parse_ppm(ppm: Path):
    """Return (width, height, pixel bytes) for a binary P6 PPM."""
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
    w, h = int(w), int(h)
    return w, h, data[i:i + w * h * 3]


def _distinct_colors(px: bytes) -> int:
    """Count distinct RGB triples in P6 pixel bytes."""
    return len({px[k:k + 3] for k in range(0, len(px), 3)})


# Renderer clear color (loderunner.c level_draw); pixels differing from it are
# drawn content.
_CLEAR_RGB = (0x10, 0x14, 0x18)


def _content_span(w: int, h: int, px: bytes):
    """Fraction of the frame width and height covered by the content bounding
    box (non-clear pixels). An offset viewport clips one edge, shrinking one
    fraction below the rest."""
    minx, maxx, miny, maxy = w, -1, h, -1
    for y in range(h):
        row = y * w * 3
        for x in range(w):
            o = row + x * 3
            if (px[o], px[o + 1], px[o + 2]) != _CLEAR_RGB:
                if x < minx:
                    minx = x
                if x > maxx:
                    maxx = x
                if y < miny:
                    miny = y
                if y > maxy:
                    maxy = y
    if maxx < 0:
        return 0.0, 0.0
    return (maxx - minx + 1) / w, (maxy - miny + 1) / h


def oracle_diff(badc: Path, work: Path) -> bool:
    """Differential check of raylib's pure math (raymath.h): build oracle_diff.c
    with badc and with the reference C compiler, run both, and assert the
    results agree. raymath is header-only, so this links no library and needs
    no platform headers; it exercises badc's float and by-value
    aggregate-return code on Matrix/Quaternion/Vector3 returns the 2D game does
    not reach. A system libraylib, when installed, is an additional oracle for
    the same API; absent one, the reference compiler stands in."""
    ref = None
    for c in ("clang", "cc", "gcc"):
        ref = shutil.which(c)
        if ref:
            break
    if ref is None:
        print("smoke SKIP: no reference C compiler for the raymath oracle")
        return True
    src = RAYLIB_DIR / "oracle_diff.c"
    inc = RAYLIB_DIR / "src"
    if not (inc / "raymath.h").is_file():
        print("smoke SKIP: raymath oracle needs the vendored source (run setup.py)")
        return True
    bad_out = work / f"oracle_badc{EXE}"
    ref_out = work / f"oracle_ref{EXE}"
    if run([str(badc), "--gnu", "-I", str(inc), str(src), "-o", str(bad_out)]).returncode != 0:
        print("smoke FAIL: oracle_diff badc build", file=sys.stderr)
        return False
    ref_cmd = [ref, "-O0", "-I", str(inc), str(src), "-o", str(ref_out)]
    if not WIN:
        ref_cmd.append("-lm")
    if run(ref_cmd).returncode != 0:
        print("smoke FAIL: oracle_diff reference build", file=sys.stderr)
        return False
    a = run([str(bad_out)], capture_output=True, text=True)
    b = run([str(ref_out)], capture_output=True, text=True)
    if a.returncode != 0 or b.returncode != 0:
        print("smoke FAIL: oracle_diff run", file=sys.stderr)
        return False
    if not _raymath_results_agree(a.stdout, b.stdout):
        return False
    print(f"smoke OK: raymath matches {Path(ref).name} (badc vs reference)")
    return True


def _raymath_results_agree(a: str, b: str, tol: float = 1e-4) -> bool:
    """Compare two oracle_diff outputs field by field. Float rounding order
    differs between compilers, so each numeric field must agree within a
    relative tolerance; a codegen error is gross, not in the last digits."""
    la = [ln.split() for ln in a.splitlines() if ln.strip()]
    lb = [ln.split() for ln in b.splitlines() if ln.strip()]
    if len(la) != len(lb):
        print(f"smoke FAIL: raymath line count {len(la)} vs {len(lb)}", file=sys.stderr)
        return False
    for ta, tb in zip(la, lb):
        if ta[0] != tb[0]:
            print(f"smoke FAIL: raymath tag {ta[0]} vs {tb[0]}", file=sys.stderr)
            return False
        for x, y in zip(ta[1:], tb[1:]):
            fx, fy = float(x), float(y)
            rel = abs(fx - fy) / (max(abs(fx), abs(fy)) or 1.0)
            if rel > tol:
                print(f"smoke FAIL: raymath {ta[0]} {fx} vs {fy} (rel {rel:.1e})",
                      file=sys.stderr)
                return False
    return True


def _out_dir_arg(argv) -> str | None:
    """`--out-dir <path>` keeps the build output (objects, the standalone
    binary, the dumped frame) in <path> instead of a temporary directory
    that is deleted on exit. Returns the path, or None for the default."""
    for i, a in enumerate(argv):
        if a == "--out-dir" and i + 1 < len(argv):
            return argv[i + 1]
        if a.startswith("--out-dir="):
            return a.split("=", 1)[1]
    return None


def _run(badc: Path, work: Path) -> int:
    ok = logic_self_test(badc, work)
    # platform_build runs setup.py, which fetches raymath.h into src/; the
    # raymath differential below needs it, so it runs after the build.
    if MAC or LINUX or WIN:
        ok &= platform_build(badc, work)
    ok &= oracle_diff(badc, work)
    return 0 if ok else 1


def main() -> int:
    badc = resolve_badc()

    out_dir = _out_dir_arg(sys.argv[1:])
    if out_dir is not None:
        work = Path(out_dir)
        work.mkdir(parents=True, exist_ok=True)
        rc = _run(badc, work)
        print(f"smoke: output preserved in {work}")
        return rc
    with tempfile.TemporaryDirectory(prefix="raylib-smoke-") as work_str:
        return _run(badc, Path(work_str))


if __name__ == "__main__":
    sys.exit(main())
