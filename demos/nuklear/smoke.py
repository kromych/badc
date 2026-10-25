#!/usr/bin/env python3
"""Build Nuklear (setup.py's pin, past 4.13.3) with badc the way upstream's CI does, and run its
demo windows headlessly against a host-compiler build.

Upstream's CI (``.github/workflows/ccpp.yml``) regenerates ``nuklear.h``
from ``src/`` and checks it matches the committed header, builds every
demo and the example against its GPU or windowing library, and compiles
each ``src/*.c`` on its own (``.github/ci_compile_sources.sh``). Nuklear
has no unit tests. This smoke:

  - regenerates the header with ``src/build.py`` and the ``nuke`` recipe's
    file lists, and compares it with the shipped ``nuklear.h``;
  - compiles each ``src/*.c`` with badc and the script's flags, at -O0
    and -O;
  - builds the demos the host can link without a GPU -- ``demo/x11`` and
    ``demo/rawfb/x11`` on Linux when the X11 development files are
    installed, ``demo/gdi`` on Windows -- except those ``BLOCKED_DEMOS``
    names. Build-only, as upstream's CI;
  - builds ``headless.c`` -- the upstream demo windows driven by scripted
    input, rendered by the rawfb software renderer into memory and by
    ``nk_convert`` into a vertex buffer -- with badc -O0, badc -O and, but
    on Windows, the host's cc, runs each, and requires the per-frame
    digests of the command queue, the vertex and index buffers and the
    framebuffer to agree, and the calculator to show the result of the
    scripted clicks.

Every build passes -ffp-contract=off: a compiler may otherwise fuse a
multiply and an add into one rounding (C99 6.5p8), which changes vertex
positions legitimately between compilers.

Override the badc binary via the ``BADC`` env var (default:
``target/release/badc``).
"""

from __future__ import annotations

import argparse
import hashlib
import importlib.util
import os
import shutil
import subprocess
import sys
import tempfile
import time
from pathlib import Path

DEMO_DIR = Path(__file__).resolve().parent
REPO_ROOT = DEMO_DIR.parent.parent
COMMIT = "a7353204d0f76fa38df9e9a2c02247b52c3bc878"
SRC = DEMO_DIR / ".cache" / f"Nuklear-{COMMIT}"
WIN = sys.platform == "win32"
EXE = ".exe" if WIN else ""

_syslib_spec = importlib.util.spec_from_file_location("_syslib", DEMO_DIR.parent / "_syslib.py")
_syslib = importlib.util.module_from_spec(_syslib_spec)
_syslib_spec.loader.exec_module(_syslib)

# The Makefile's `nuke` recipe: the file lists build.py packs, in order.
NUKE_PRIV1 = ("nuklear_internal.h nuklear_math.c nuklear_util.c nuklear_color.c "
              "nuklear_utf8.c nuklear_buffer.c nuklear_string.c nuklear_draw.c "
              "nuklear_vertex.c").split()
NUKE_EXTERN = "stb_rect_pack.h stb_truetype.h".split()
NUKE_PRIV2 = ("nuklear_font.c nuklear_input.c nuklear_style.c nuklear_context.c "
              "nuklear_pool.c nuklear_page_element.c nuklear_table.c nuklear_panel.c "
              "nuklear_window.c nuklear_popup.c nuklear_contextual.c nuklear_menu.c "
              "nuklear_layout.c nuklear_tree.c nuklear_group.c nuklear_list_view.c "
              "nuklear_widget.c nuklear_text.c nuklear_image.c nuklear_9slice.c "
              "nuklear_button.c nuklear_toggle.c nuklear_selectable.c nuklear_slider.c "
              "nuklear_knob.c nuklear_progress.c nuklear_scrollbar.c "
              "nuklear_text_editor.c nuklear_edit.c nuklear_property.c nuklear_chart.c "
              "nuklear_color_picker.c nuklear_combo.c nuklear_tooltip.c").split()
NUKE_OUTRO = "LICENSE CHANGELOG CREDITS".split()

# .github/ci_compile_sources.sh's CFLAGS and CPPFLAGS. Its `-x c` is left
# out (the .c suffix selects the same language) and its `-pedantic` is
# spelled -Wpedantic, gcc's other name for it.
# TODO: pass upstream's `-x c` once the driver takes it
# (https://github.com/kromych/badc/issues/1326).
COMPILE_SOURCES_FLAGS = (
    "-std=c89", "-Wall", "-Wextra", "-Wpedantic",
    "-DNK_INCLUDE_FIXED_TYPES", "-DNK_INCLUDE_DEFAULT_ALLOCATOR",
    "-DNK_INCLUDE_STANDARD_IO", "-DNK_INCLUDE_STANDARD_VARARGS",
    "-DNK_INCLUDE_STANDARD_BOOL", "-DNK_INCLUDE_VERTEX_BUFFER_OUTPUT",
    "-DNK_INCLUDE_DEFAULT_FONT", "-DNK_INCLUDE_COMMAND_USERDATA",
)

LEVELS = (("badc-O0", []), ("badc-O", ["-O"]))

# What the scripted clicks leave on the calculator: (12 + 7) * 3.
CALCULATOR = "calculator shows 57.00"
RUN_TIMEOUT = 300


def resolve_badc() -> Path:
    env = os.environ.get("BADC")
    if env:
        return Path(env)
    p = REPO_ROOT / "target" / "release" / f"badc{EXE}"
    if not p.is_file():
        sys.exit(f"smoke: badc not built at {p} -- run `cargo build --release --features full`")
    return p


def fail(step: str, detail: str = "") -> None:
    tail = f"\n{detail[-3000:]}" if detail else ""
    print(f"smoke FAIL: {step}{tail}", file=sys.stderr)
    sys.exit(1)


def run(cmd: list[str], **kw) -> subprocess.CompletedProcess:
    return subprocess.run([str(c) for c in cmd], capture_output=True, text=True, **kw)


def check_header() -> None:
    """Upstream's first CI step: nuklear.h is what src/ packs into."""
    def files(names: list[str]) -> str:
        return " ".join(f"src/{n}" for n in names)
    r = run([sys.executable, "-I", "src/build.py", "--macro", "NK",
             "--intro", "src/HEADER.md", "--pub", "src/nuklear.h",
             "--priv1", files(NUKE_PRIV1), "--extern", files(NUKE_EXTERN),
             "--priv2", files(NUKE_PRIV2), "--outro", files(NUKE_OUTRO)],
            cwd=SRC, encoding="utf-8")
    if r.returncode != 0:
        fail("src/build.py", r.stdout + r.stderr)
    shipped = (SRC / "nuklear.h").read_text(encoding="utf-8")
    if r.stdout != shipped:
        fail("nuklear.h does not match the header src/build.py packs from src/")
    print("header: nuklear.h matches src/")


def compile_sources(badc: Path, work: Path) -> None:
    """Upstream's ci_compile_sources.sh with badc as CC."""
    units = sorted((SRC / "src").glob("*.c"))
    for label, opt in LEVELS:
        out = work / f"src-{label}"
        out.mkdir()
        for unit in units:
            r = run([badc, "-q", *opt, "-c", unit, "-o", out / f"{unit.stem}.o",
                     *COMPILE_SOURCES_FLAGS])
            if r.returncode != 0:
                fail(f"[{label}] compile {unit.name}", r.stdout + r.stderr)
    print(f"sources: {len(units)} units compile at -O0 and -O")


# Demos that do not build, with the reason.
BLOCKED_DEMOS: dict[str, str] = {}


def x11_demos(badc: Path, work: Path) -> None:
    """demo/x11 and demo/rawfb/x11 with their Makefiles' flags, linked
    against the host's libX11 (and libXext for the shared-memory
    framebuffer)."""
    if not Path("/usr/include/X11/Xlib.h").is_file():
        print("demos: skipped X11 (no X11 development headers)")
        return
    sysroot = _syslib.sysroot_args()
    demos = (
        ("x11", SRC / "demo" / "x11" / "main.c",
         ["-std=c89", "-Wall", "-Wextra", "-Wpedantic", "-Wno-unused-function",
          "-D_POSIX_C_SOURCE=200809L"], ("X11",), ()),
        ("rawfb-x11", SRC / "demo" / "rawfb" / "x11" / "main.c",
         ["-std=c89", "-Wall", "-Wextra", "-Wpedantic", "-Wno-unused-function",
          "-D_GNU_SOURCE", "-D_POSIX_C_SOURCE=200809L"], ("X11", "Xext"),
         ("X11/extensions/XShm.h",)),
    )
    for name, main, flags, libs, headers in demos:
        if name in BLOCKED_DEMOS:
            print(f"demos: {name} skipped: {BLOCKED_DEMOS[name]}")
            continue
        absent = [h for h in headers if not (Path("/usr/include") / h).is_file()]
        if absent:
            print(f"demos: {name} skipped (no {', '.join(absent)})")
            continue
        missing = [lib for lib in libs if _syslib.shared_library((lib,), lib) is None]
        if missing:
            print(f"demos: {name} skipped (no {', '.join('lib' + m for m in missing)})")
            continue
        for label, opt in LEVELS:
            exe = work / f"demo-{name}-{label}"
            r = run([badc, "-q", *opt, *sysroot, *flags, main, "-o", exe,
                     *(f"-l{lib}" for lib in libs)])
            if r.returncode != 0:
                fail(f"[{label}] demo {name}", r.stdout + r.stderr)
        print(f"demos: {name} builds at -O0 and -O")


def gdi_demo(badc: Path, work: Path) -> None:
    """demo/gdi as its build.bat builds it, with badc for cl."""
    if "gdi" in BLOCKED_DEMOS:
        print(f"demos: gdi skipped: {BLOCKED_DEMOS['gdi']}")
        return
    main = SRC / "demo" / "gdi" / "main.c"
    for label, opt in LEVELS:
        exe = work / f"demo-gdi-{label}.exe"
        r = run([badc, "-q", *opt, main, "-o", exe])
        if r.returncode != 0:
            fail(f"[{label}] demo gdi", r.stdout + r.stderr)
    print("demos: gdi builds at -O0 and -O")


def host_cc() -> list[str] | None:
    """The host C compiler, or None. Not on Windows: the digests differ
    between the Linux and macOS lanes from the font atlas on, so the
    reference has to call the math functions badc's build calls, and
    badc binds msvcrt.dll's where MSVC and the runners' clang link the
    UCRT's."""
    if WIN:
        return None
    path = shutil.which("cc")
    return [path, "-O2", "-w"] if path else None


def headless(badc: Path, work: Path) -> None:
    src = DEMO_DIR / "headless.c"
    builds: list[tuple[str, list[str]]] = [
        (label, [str(badc), "-q", *opt]) for label, opt in LEVELS]
    cc = host_cc()
    if cc is not None:
        builds.insert(0, ("host-cc", cc))
    outputs: dict[str, str] = {}
    for label, cmd in builds:
        exe = work / f"headless-{label}{EXE}"
        libs = ["-lm"] if label == "host-cc" else []
        r = run([*cmd, "-ffp-contract=off", f"-I{SRC}", src, "-o", exe, *libs])
        if r.returncode != 0:
            if label == "host-cc":
                # The reference is an oracle, not the subject: a host
                # compiler that cannot build here leaves badc's two levels.
                print(f"headless: the host compiler failed ({cmd[0]}): "
                      f"{(r.stdout + r.stderr).strip().splitlines()[-1:]}")
                continue
            fail(f"[{label}] build headless.c", r.stdout + r.stderr)
        try:
            r = run([exe], timeout=RUN_TIMEOUT)
        except subprocess.TimeoutExpired:
            fail(f"[{label}] headless did not finish in {RUN_TIMEOUT}s")
        if r.returncode != 0:
            fail(f"[{label}] headless exited {r.returncode}", r.stdout + r.stderr)
        if CALCULATOR not in r.stdout or "button pressed" not in r.stdout:
            fail(f"[{label}] the scripted input did not take effect", r.stdout)
        outputs[label] = r.stdout
    if "host-cc" not in outputs:
        print("headless: no host reference, so badc -O0 and -O are compared "
              "with each other only")
    ref_label = next(iter(outputs))
    ref = outputs[ref_label]
    for label, out in outputs.items():
        if out == ref:
            continue
        a, b = ref.splitlines(), out.splitlines()
        first = next((i for i in range(min(len(a), len(b))) if a[i] != b[i]), min(len(a), len(b)))
        fail(f"[{label}] headless frames differ from {ref_label}'s",
             f"{ref_label}: {a[first] if first < len(a) else '<end>'}\n"
             f"{label}: {b[first] if first < len(b) else '<end>'}")
    frames = ref.strip().splitlines()[-1]
    digest = hashlib.sha256(ref.encode()).hexdigest()[:16]
    print(f"headless: {frames} agree across {', '.join(outputs)} (output sha256 {digest})")


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("-v", "--verbose", action="store_true")
    args = ap.parse_args(argv)
    start = time.monotonic()
    badc = resolve_badc()
    r = subprocess.run([sys.executable, str(DEMO_DIR / "setup.py")] + (["-v"] if args.verbose else []))
    if r.returncode != 0:
        fail("setup.py")
    check_header()
    with tempfile.TemporaryDirectory(prefix="nuklear-smoke-") as tmp:
        work = Path(tmp)
        compile_sources(badc, work)
        if sys.platform.startswith("linux"):
            x11_demos(badc, work)
        elif WIN:
            gdi_demo(badc, work)
        headless(badc, work)
    print(f"nuklear smoke OK ({time.monotonic() - start:.1f}s)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
