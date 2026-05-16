#!/usr/bin/env python3
"""Self-host parity check for the tinycc bringup.

Validates that the tcc binary produced by badc behaves identically
to a reference tcc built with the host's native cc, for a curated
set of self-contained C programs.

The check is deliberately scoped to compile-to-object (`tcc -c`),
not full link, so it does not depend on a freshly-built libtcc1.a
runtime archive (that bringup is tracked separately, with the
TODO marker in this file).

Runs on Linux only (x86_64 + aarch64):
* tcc-the-binary defaults to ELF for `-c` output on every host;
  Mach-O / PE output paths need the explicit format flag the
  bringup is not exercising yet.
* The host gcc toolchain has to be able to build the reference
  tcc -- that requires libc / libdl headers + linkers which the
  cross-compile lanes (Windows, macOS-aarch64) do not surface.
* Per-host TU set and target-selection macros are looked up in
  HOST_PROFILES; the x86_64 lane uses x86_64-gen.c / x86_64-link.c
  + i386-asm.c, the aarch64 lane uses arm64-gen.c / arm64-link.c
  + arm64-asm.c.

Exit codes:
  0 -- byte-identical object output on every sample
  1 -- mismatch detected
  2 -- environment unsuitable (wrong arch, missing gcc, tinycc
       sources absent) -- treated as skip rather than fail
"""

from __future__ import annotations

import os
import platform
import shutil
import subprocess
import sys
from pathlib import Path

TINYCC_DIR = Path(__file__).resolve().parent
REPO_ROOT = TINYCC_DIR.parent.parent


# C99-conforming, include-free samples. The bringup test treats
# `tcc -c` as the unit of comparison so the samples never reach
# the linker; declared but unused symbols are fine. Each sample
# exercises a different corner of the front end:
SAMPLES: dict[str, str] = {
    "arithmetic.c": """
int main(void) {
    int a = 10, b = 3;
    return a / b + a % b;
}
""",
    "recursion.c": """
int fact(int n) { return n <= 1 ? 1 : n * fact(n - 1); }
int main(void) { return fact(6); }
""",
    "structs.c": """
struct Pt { int x; int y; };
int sum_pt(struct Pt *p) { return p->x + p->y; }
int main(void) {
    struct Pt p; p.x = 3; p.y = 4;
    return sum_pt(&p);
}
""",
    "globals.c": """
int g_arr[8] = { 1, 2, 3, 4, 5, 6, 7, 8 };
int g_count = 8;
int sum(void) {
    int s = 0;
    for (int i = 0; i < g_count; i++) s += g_arr[i];
    return s;
}
int main(void) { return sum(); }
""",
    "ptr_walk.c": """
int my_strlen(const char *s) {
    int n = 0;
    while (s[n]) n++;
    return n;
}
int main(void) { return my_strlen("self-host"); }
""",
    "bitops.c": """
int main(void) {
    unsigned x = 0xCAFEBABEu;
    unsigned y = (x >> 16) ^ (x & 0xFFFFu);
    return (int)(y & 0xFFu);
}
""",
    "bitfields.c": """
struct flags {
    unsigned a : 3;
    unsigned b : 5;
    unsigned c : 8;
};
int main(void) {
    struct flags f;
    f.a = 5; f.b = 17; f.c = 200;
    return (int)(f.a + f.b + f.c);
}
""",
    "enum_switch.c": """
enum color { RED = 1, GREEN = 2, BLUE = 4 };
static int score(enum color c) {
    switch (c) {
    case RED:   return 10;
    case GREEN: return 20;
    case BLUE:  return 40;
    default:    return -1;
    }
}
int main(void) { return score(GREEN) + score(BLUE); }
""",
    "typedef_array.c": """
typedef int row_t[8];
static int row_sum(row_t r) {
    int s = 0;
    for (int i = 0; i < 8; i++) s += r[i];
    return s;
}
int main(void) {
    row_t r = { 1, 2, 3, 4, 5, 6, 7, 8 };
    return row_sum(r);
}
""",
    "fn_pointers.c": """
static int add(int a, int b) { return a + b; }
static int mul(int a, int b) { return a * b; }
typedef int (*binop_t)(int, int);
int main(void) {
    binop_t ops[2] = { add, mul };
    return ops[0](3, 4) + ops[1](3, 4);
}
""",
    "static_locals.c": """
static int next_id(void) {
    static int counter = 0;
    counter = counter + 1;
    return counter;
}
int main(void) {
    int a = next_id();
    int b = next_id();
    int c = next_id();
    return a * 100 + b * 10 + c;
}
""",
    "two_d_array.c": """
int main(void) {
    int m[3][4] = {
        { 1,  2,  3,  4 },
        { 5,  6,  7,  8 },
        { 9, 10, 11, 12 },
    };
    int s = 0;
    for (int i = 0; i < 3; i++)
        for (int j = 0; j < 4; j++)
            s += m[i][j];
    return s;
}
""",
    "compound_assign.c": """
int main(void) {
    int x = 100;
    x += 5;  x -= 2;  x *= 3;  x /= 4;
    x &= 0xFF; x |= 0x100; x ^= 0x55; x <<= 1; x >>= 2;
    return x;
}
""",
    "sizeof_exprs.c": """
struct P { int x; int y; int z; };
int main(void) {
    int arr[16];
    struct P p;
    int s = 0;
    s += (int)sizeof(int);
    s += (int)sizeof(arr);
    s += (int)sizeof(arr) / (int)sizeof(arr[0]);
    s += (int)sizeof(p);
    s += (int)sizeof(p.y);
    s += (int)sizeof("hello");
    return s;
}
""",
    "conditional.c": """
static int max3(int a, int b, int c) {
    int m = a > b ? a : b;
    return m > c ? m : c;
}
int main(void) {
    return max3(7, 12, 9) + (1 < 2 ? 10 : 20) - (0 ? 5 : 3);
}
""",
    "comma_op.c": """
int main(void) {
    int i, j, k;
    for (i = 0, j = 10; i < j; i++, j--)
        ;
    k = (i = 1, j = 2, i + j);
    return i * 100 + j * 10 + k;
}
""",
    "signed_unsigned.c": """
int main(void) {
    int s = -1;
    unsigned u = 1;
    long long sl = (long long)s + (long long)u;
    if (s < (int)u) sl += 100;
    unsigned mask = 0xFFFFFFFFu;
    if ((mask >> 1) == 0x7FFFFFFFu) sl += 1000;
    return (int)sl;
}
""",
    "string_concat.c": """
static int strlen_local(const char *s) {
    int n = 0;
    while (s[n]) n++;
    return n;
}
int main(void) {
    const char *s = "abc" "def" "ghi";
    return strlen_local(s);
}
""",
    "char_arith.c": """
int main(void) {
    char c = 'A';
    int upper = (int)c;
    c = c + 32;
    int lower = (int)c;
    return lower - upper;
}
""",
    "global_struct_init.c": """
struct Pt { int x; int y; };
struct Pt g_origin = { 0, 0 };
struct Pt g_pts[3] = { { 1, 2 }, { 3, 4 }, { 5, 6 } };
int main(void) {
    int s = g_origin.x + g_origin.y;
    for (int i = 0; i < 3; i++) s += g_pts[i].x + g_pts[i].y;
    return s;
}
""",
    "nested_struct.c": """
struct inner { int a; int b; };
struct outer { struct inner head; struct inner tail; int n; };
int main(void) {
    struct outer o;
    o.head.a = 1; o.head.b = 2;
    o.tail.a = 3; o.tail.b = 4;
    o.n = 10;
    return o.head.a + o.head.b + o.tail.a + o.tail.b + o.n;
}
""",
    "array_param_decay.c": """
static int sum(int *p, int n) {
    int s = 0;
    for (int i = 0; i < n; i++) s += p[i];
    return s;
}
int main(void) {
    int xs[5] = { 2, 4, 6, 8, 10 };
    return sum(xs, 5);
}
""",
    "early_returns.c": """
static int classify(int x) {
    if (x < 0) return -1;
    if (x == 0) return 0;
    if (x < 100) return 1;
    return 2;
}
int main(void) {
    int s = 0;
    s += classify(-5);
    s += classify(0);
    s += classify(42);
    s += classify(1000);
    return s + 10;
}
""",
    "do_while_once.c": """
int main(void) {
    int n = 0;
    int v = 0;
    do {
        v += 1;
        n++;
    } while (n < 1 && v > 100);
    return v;
}
""",
    "ternary_chain.c": """
static int sign(int x) {
    return x < 0 ? -1 : x > 0 ? 1 : 0;
}
int main(void) {
    return sign(-7) * 100 + sign(0) * 10 + sign(42);
}
""",
}


def env_unsuitable(reason: str) -> int:
    print(f"self_host: skip -- {reason}", file=sys.stderr)
    return 2


def resolve_badc() -> Path | None:
    env = os.environ.get("BADC")
    candidates: list[Path] = []
    if env:
        candidates.append(Path(env))
    default = REPO_ROOT / "target" / "release" / "badc"
    candidates.extend([default, default.with_suffix(".exe")])
    for cand in candidates:
        if cand.is_file() and os.access(cand, os.X_OK):
            return cand
    return None


def tcc_build_defines(
    multiarch: Path | None, host: tuple[str, str], sdk: Path | None
) -> tuple[str, ...]:
    """Per-target compile-time macros baked into both the
    reference and stage1 tcc binaries. The CRT / library paths
    are compile-time constants on tinycc; pointing them at the
    host's library and include directories lets the produced
    binary find `crt1.o` / `crti.o` / `libc.so` (Linux) or
    `libSystem` (macOS) without runtime `-L` flags. The
    sysinclude path keeps `{B}/include` first so `tccdefs.h`
    (under the demo tree) still resolves through tcc's own
    `-B` lookup; only the trailing system path is host-shaped.
    """
    if host[0] == "Darwin" and sdk is not None:
        sdk_lib = sdk / "usr" / "lib"
        sdk_include = sdk / "usr" / "include"
        return (
            f'-DCONFIG_TCC_CRTPREFIX="{sdk_lib}"',
            f'-DCONFIG_TCC_LIBPATHS="{{B}}:{sdk_lib}:/usr/lib"',
            f'-DCONFIG_TCC_SYSINCLUDEPATHS="{{B}}/include:{sdk_include}:/usr/include"',
        )
    if host[0] == "Windows":
        # tinycc resolves `<stdio.h>` / `<windows.h>` etc. through
        # its own sysinclude list. The upstream win32 build installs
        # the mingw-style headers under `<install>/include` plus the
        # Win32 API headers under `<install>/include/winapi`. Mirror
        # the same two-entry layout against the in-tree
        # `demos/tinycc/win32/include/` so `tccpe.c` / `tccrun.c`
        # (which `#include <windows.h>`) and the broader corpus
        # resolve without an install step. `{B}/include` keeps
        # `tccdefs.h` reachable. PATHSEP is `;` on Windows per
        # `tcc.h:PATHSEP`.
        #
        # `CONFIG_TCC_LIBPATHS` defaults to `{B}/lib` on PE; the
        # libtcc1 archive sits there. Add `{B}/win32/lib` so
        # `-lkernel32` / `-lmsvcrt` find the upstream `.def`
        # files that describe the DLL exports.
        return (
            '-DCONFIG_TCC_SYSINCLUDEPATHS='
            '"{B}/win32/include;{B}/win32/include/winapi;{B}/include"',
            '-DCONFIG_TCC_LIBPATHS="{B}/lib;{B}/win32/lib"',
        )
    if multiarch is None:
        return ()
    triplet = multiarch.name
    return (
        f'-DCONFIG_TCC_CRTPREFIX="/usr/lib/{triplet}"',
        f'-DCONFIG_TCC_LIBPATHS="{{B}}:/usr/lib/{triplet}:/usr/lib"',
        f'-DCONFIG_TCC_SYSINCLUDEPATHS="{{B}}/include:/usr/include/{triplet}:/usr/include"',
    )


def host_link_libs(host: tuple[str, str]) -> tuple[str, ...]:
    """Platform-specific link libraries the reference and gen2 tcc
    binaries need to resolve their dependencies. Linux pulls in
    `libdl` and `libpthread` separately; macOS bundles both into
    `libSystem`, which clang autolinks, so the list is empty.
    Windows ships its libc / threading surface in the C runtime
    DLL the toolchain autolinks (msvcrt for mingw, ucrt for the
    UCRT variant), so the list is also empty there.
    """
    if host[0] == "Linux":
        return ("-ldl", "-lpthread")
    return ()


def host_link_flags(host: tuple[str, str]) -> tuple[str, ...]:
    """Linker flags only valid on a given host. The
    `--no-eh-frame-hdr` workaround addresses GNU ld's
    overlapping-FDE diagnostic on multi-TU tcc objects produced
    for ELF output; macOS's ld64 and the PE / COFF linkers have
    no equivalent flag.
    """
    if host[0] == "Linux":
        return ("-Wl,--no-eh-frame-hdr",)
    return ()


def codesign_if_macos(host: tuple[str, str], path: Path) -> None:
    """Apply an ad-hoc code signature to a Mach-O binary on
    macOS. Apple Silicon refuses to execute unsigned Mach-O
    files; tcc emits Mach-O without an LC_CODE_SIGNATURE load
    command, so the produced binaries die with SIGKILL before
    main() unless something else stamps a signature on them.
    `codesign --sign -` is the standard ad-hoc spelling.
    """
    if host[0] != "Darwin":
        return
    subprocess.run(
        ["codesign", "--sign", "-", "--force", str(path)],
        capture_output=True,
        text=True,
    )


def build_reference_tcc(
    cc: str,
    work: Path,
    multiarch: Path | None,
    profile: dict[str, tuple[str, ...]],
    host: tuple[str, str],
    sdk: Path | None,
) -> Path | None:
    """Build a reference tcc via host gcc/cc.

    Mirrors the upstream Makefile's `tcc` link step but invoked
    directly so this script does not depend on autoconf / make
    being on PATH. The TU list and `TCC_TARGET_*` macros come from
    ``profile`` so the function works for any supported host.
    """
    sources = [TINYCC_DIR / name for name in profile["tus"]]
    out = work / "tcc-ref"
    cmd = [
        cc,
        "-O0",
        "-g",
        *target_macro_flags(profile["target_macros"]),
        "-DONE_SOURCE=0",
        "-DCONFIG_TCC_PREDEFS=0",
        "-DCONFIG_TCC_SEMLOCK=0",
        "-DCONFIG_TCC_BACKTRACE=0",
        "-D_GNU_SOURCE",
        *tcc_build_defines(multiarch, host, sdk),
        f"-I{TINYCC_DIR}",
        "-o",
        str(out),
        *[str(s) for s in sources],
        *host_link_libs(host),
    ]
    proc = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8", errors="replace")
    if proc.returncode != 0:
        print(f"self_host: reference tcc build failed via {cc}:", file=sys.stderr)
        print(proc.stderr, file=sys.stderr)
        return None
    return out


def build_libtcc1_archive(
    stage1_tcc: Path, work: Path, host: tuple[str, str]
) -> Path | None:
    """Compile the vendored ``lib/libtcc1.c`` + ``lib/va_list.c``
    with the stage1 tcc binary and bundle the resulting objects
    into a ``libtcc1.a`` archive. The archive exposes
    ``__floatundixf`` / ``__fixxfdi`` (80-bit long-double
    conversion helpers tcc's codegen emits as undefined
    references) and ``__va_arg`` (tcc's stack-walking va_arg
    helper). On AArch64 the archive also picks up
    ``lib/lib-arm64.c``, which carries the binary128 long-double
    softfloat helper set tcc emits references to (``__multf3``,
    ``__addtf3``, ``__divtf3``, ``__floatsitf``, ...). The host
    gcc autolinks libgcc_s.so.1 for the same surface; the
    libtcc1.a route keeps the badc-built link self-contained.

    The archive sits at ``<work>/libtcc1.a`` and at
    ``<TINYCC_DIR>/libtcc1.a`` so a later step that invokes tcc
    with ``-B <TINYCC_DIR>`` can pick it up via tcc's standard
    library-path search. The full upstream libtcc1.a covers
    coverage / backtrace / bcheck helpers (tcov, runmain,
    bcheck); those are needed only for ``-bt`` / ``-run`` /
    ``-fbounds-checking`` and stay outside this subset.
    """
    sources: list[Path] = [
        TINYCC_DIR / "lib" / "libtcc1.c",
    ]
    if host[0] != "Windows":
        # `va_list.c` provides the `__va_arg` helper for the SysV
        # x86_64 / Linux + macOS aarch64 va_list ABI. tinycc's
        # tccdefs.h redefines `__builtin_va_list` as `char *` on
        # `_WIN32`, which collides with va_list.c's struct typedef;
        # upstream tinycc's win32 Makefile already excludes it
        # because the Win64 va_arg lowering is the inline macro at
        # `tccdefs.h:__builtin_va_arg` -- no `__va_arg` reference
        # is emitted.
        sources.append(TINYCC_DIR / "lib" / "va_list.c")
    if host[0] == "Windows":
        # PE startup + alloca on Windows:
        #
        # * `crt1.c` -- supplies `_start`, the PE entry point for
        #   console apps. (`wincrt1.c` is the GUI-app variant and
        #   defines `_winstart` instead, so it does not satisfy
        #   `_start`.)
        # * `alloca.S` -- supplies the `alloca` symbol tcc emits
        #   for variable-length array / `alloca()` lowering.
        # * `chkstk.S` -- supplies `__chkstk`, the stack-probe
        #   helper tcc emits for prologues larger than one page.
        sources.append(TINYCC_DIR / "win32" / "lib" / "crt1.c")
        sources.append(TINYCC_DIR / "lib" / "alloca.S")
        sources.append(TINYCC_DIR / "win32" / "lib" / "chkstk.S")
    if host[1] == "aarch64":
        # `lib-arm64.c` -- binary128 long-double softfloat helpers.
        # `armflush.c` -- `__clear_cache` wrapper that lowers to
        # tinycc's `__arm64_clear_cache` intrinsic (the inline
        # `dc cvau` / `ic ivau` cacheflush sequence). Both are
        # autolinked from libgcc_s.so.1 on a gcc-driven host build,
        # so the stage1-driven link needs them in libtcc1.a.
        sources.append(TINYCC_DIR / "lib" / "lib-arm64.c")
        sources.append(TINYCC_DIR / "lib" / "armflush.c")
    obj_paths: list[Path] = []
    for src in sources:
        obj = work / (src.stem + ".lib.o")
        cmd = [
            str(stage1_tcc),
            "-B",
            str(TINYCC_DIR),
            "-c",
            str(src),
            "-o",
            str(obj),
        ]
        proc = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8", errors="replace")
        if proc.returncode != 0:
            print(f"self_host: libtcc1 helper {src.name} build failed:", file=sys.stderr)
            print(proc.stderr, file=sys.stderr)
            return None
        obj_paths.append(obj)

    archive = work / "libtcc1.a"
    if archive.exists():
        archive.unlink()
    cmd = [
        shutil.which("ar") or "ar",
        "rcs",
        str(archive),
        *[str(p) for p in obj_paths],
    ]
    proc = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8", errors="replace")
    if proc.returncode != 0:
        print("self_host: libtcc1.a archive build failed:", file=sys.stderr)
        print(proc.stderr, file=sys.stderr)
        return None
    # Mirror to the tcc lib path so `-B <TINYCC_DIR>` resolves it.
    # `CONFIG_TCC_LIBPATHS` is `{B}` on POSIX targets and `{B}/lib`
    # on PE / `_WIN32` per tcc.h, so place a copy at both locations
    # rather than branch on host. Existing `lib/` ships the libtcc1
    # source files; adding the archive alongside is harmless.
    for mirror in (TINYCC_DIR / "libtcc1.a", TINYCC_DIR / "lib" / "libtcc1.a"):
        shutil.copyfile(archive, mirror)
    return archive


def libtcc1_objects_for_gen2_link(archive: Path) -> list[Path]:
    """Return the path list to splice into the host-gcc link of
    `tcc-gen2`. Passing the archive directly is enough: ld pulls
    only the members that satisfy undefined symbols, so the
    minimal-archive contents land in `tcc-gen2` and nothing else.
    """
    return [archive]


def build_stage1_tcc(
    badc: Path,
    work: Path,
    multiarch: Path | None,
    profile: dict[str, tuple[str, ...]],
    host: tuple[str, str],
    sdk: Path | None,
) -> Path | None:
    """Build a stage1 tcc through badc -- the same TU set the smoke
    step links. ``cwd`` is pinned to the repo root so badc's
    `./include` auto-add picks up c5's bundled headers. TU list and
    target macros come from ``profile``.
    """
    sources = [str(TINYCC_DIR / name) for name in profile["tus"]]
    out = work / "tcc-stage1"
    cmd = [
        str(badc),
        "-I",
        str(TINYCC_DIR),
        "-DONE_SOURCE=0",
        *target_macro_flags(profile["target_macros"]),
        "-D_GNU_SOURCE",
        *tcc_build_defines(multiarch, host, sdk),
        "-o",
        str(out),
        *sources,
    ]
    proc = subprocess.run(
        cmd,
        capture_output=True,
        text=True,
        encoding="utf-8",
        errors="replace",
        cwd=str(REPO_ROOT),
    )
    if proc.returncode != 0:
        print("self_host: stage1 tcc build failed via badc:", file=sys.stderr)
        print(proc.stderr, file=sys.stderr)
        return None
    return out


def compile_with(
    tcc: Path,
    src: Path,
    out: Path,
    extra: tuple[str, ...] = (),
) -> tuple[bool, str]:
    """Run ``tcc -c src -o out``. Returns (ok, captured_stderr).

    The ``-B`` flag points at the vendored ``include/`` directory
    so tcc finds ``tccdefs.h`` -- needed because the demo runs with
    ``CONFIG_TCC_PREDEFS=0``, which makes the predefines header a
    runtime lookup rather than a baked string literal. ``extra``
    carries any per-source flags (``-D`` defines, ``-I`` paths) the
    caller needs the compiler to see.
    """
    cmd = [str(tcc), "-B", str(TINYCC_DIR), *extra, "-c", str(src), "-o", str(out)]
    # `errors="replace"` so a stray non-UTF8 byte (the Windows runner
    # locale defaults to cp1252) does not crash the harness or
    # produce mojibake-decorated diagnostics.
    proc = subprocess.run(
        cmd, capture_output=True, text=True, encoding="utf-8", errors="replace"
    )
    if proc.returncode != 0:
        # Surface the returncode alongside stderr so silent crashes
        # (Windows access violation 0xC0000005 = -1073741819, SIGSEGV
        # = -11 on POSIX) are distinguishable from a clean nonzero
        # exit. An empty stderr with a crash-shaped returncode tells
        # the reader the process died before it could write a
        # diagnostic.
        err = proc.stderr.strip()
        rc = proc.returncode
        return False, f"exit {rc}{': ' + err if err else ''}"
    return True, ""


# Per-host (system, machine) -> tinycc TU set + target macros.
# The TU set is the same shape smoke.py uses for the matching
# lane: architecture-neutral front end plus the arch-specific
# `<arch>-gen.c` / `<arch>-link.c` / `<arch>-asm.c` triad. The
# target macros are the `TCC_TARGET_*` defines tinycc uses to
# pick its backend and output format.
HOST_PROFILES: dict[tuple[str, str], dict[str, tuple[str, ...]]] = {
    ("Linux", "x86_64"): {
        "tus": (
            "tcc.c",
            "libtcc.c",
            "tccpp.c",
            "tccgen.c",
            "tccelf.c",
            "tccasm.c",
            "tccdbg.c",
            "tccrun.c",
            "x86_64-gen.c",
            "x86_64-link.c",
            "i386-asm.c",
        ),
        "target_macros": ("TCC_TARGET_X86_64",),
    },
    ("Linux", "aarch64"): {
        "tus": (
            "tcc.c",
            "libtcc.c",
            "tccpp.c",
            "tccgen.c",
            "tccelf.c",
            "tccasm.c",
            "tccdbg.c",
            "tccrun.c",
            "arm64-gen.c",
            "arm64-link.c",
            "arm64-asm.c",
        ),
        "target_macros": ("TCC_TARGET_ARM64",),
    },
    ("Darwin", "arm64"): {
        "tus": (
            "tcc.c",
            "libtcc.c",
            "tccpp.c",
            "tccgen.c",
            "tccelf.c",
            "tccasm.c",
            "tccdbg.c",
            "tccrun.c",
            "arm64-gen.c",
            "arm64-link.c",
            "arm64-asm.c",
            "tccmacho.c",
        ),
        "target_macros": ("TCC_TARGET_ARM64", "TCC_TARGET_MACHO"),
    },
    ("Windows", "x86_64"): {
        "tus": (
            "tcc.c",
            "libtcc.c",
            "tccpp.c",
            "tccgen.c",
            "tccelf.c",
            "tccasm.c",
            "tccdbg.c",
            "tccrun.c",
            "x86_64-gen.c",
            "x86_64-link.c",
            "i386-asm.c",
            "tccpe.c",
        ),
        "target_macros": ("TCC_TARGET_X86_64", "TCC_TARGET_PE"),
    },
    ("Windows", "ARM64"): {
        "tus": (
            "tcc.c",
            "libtcc.c",
            "tccpp.c",
            "tccgen.c",
            "tccelf.c",
            "tccasm.c",
            "tccdbg.c",
            "tccrun.c",
            "arm64-gen.c",
            "arm64-link.c",
            "arm64-asm.c",
            "tccpe.c",
        ),
        "target_macros": ("TCC_TARGET_ARM64", "TCC_TARGET_PE"),
    },
}


def describe_byte_diff(
    ref_path: Path, s1_path: Path, max_runs: int = 4, max_run_bytes: int = 32
) -> str:
    """Summarize the byte-level differences between two object files.

    Walks both byte arrays, groups contiguous diffs into runs, and
    returns up to ``max_runs`` of them in the shape:

      @0x1234 (6 bytes) ref=<hex> s1=<hex>

    Run hex content is truncated to ``max_run_bytes`` per side so the
    log stays readable on a long diff. Size mismatches are reported
    separately ahead of the per-run dump.
    """
    a = ref_path.read_bytes()
    b = s1_path.read_bytes()
    out: list[str] = []
    if len(a) != len(b):
        out.append(f"size ref={len(a)} s1={len(b)} (delta {len(b) - len(a):+})")
    common = min(len(a), len(b))
    runs: list[tuple[int, int]] = []
    i = 0
    while i < common:
        if a[i] != b[i]:
            start = i
            while i < common and a[i] != b[i]:
                i += 1
            runs.append((start, i))
        else:
            i += 1
    if len(a) != len(b) and not runs:
        # tail-only divergence
        tail = common
        runs.append((tail, max(len(a), len(b))))
    out.append(f"{len(runs)} run(s)")
    for start, end in runs[:max_runs]:
        length = end - start
        ref_slice = a[start : min(end, len(a))][:max_run_bytes].hex()
        s1_slice = b[start : min(end, len(b))][:max_run_bytes].hex()
        ellipsis = "..." if length > max_run_bytes else ""
        out.append(
            f"  @0x{start:x} ({length} bytes) ref={ref_slice}{ellipsis} s1={s1_slice}{ellipsis}"
        )
    if len(runs) > max_runs:
        out.append(f"  ... {len(runs) - max_runs} more run(s)")
    return "\n".join(out)


def host_key() -> tuple[str, str]:
    """Match ``platform.machine()`` against the host-profile key set.
    ``x86_64`` and ``amd64`` (and Windows-style ``AMD64``) are aliased
    to ``x86_64``. Windows ``ARM64`` keeps its casing so the
    HOST_PROFILES key matches what `platform.machine()` returns there.
    """
    system = platform.system()
    machine = platform.machine()
    if machine.lower() == "amd64":
        machine = "x86_64"
    return (system, machine)


def target_macro_flags(target_macros: tuple[str, ...]) -> tuple[str, ...]:
    """`-D<MACRO>=1` for every entry in ``target_macros``. Used to
    pass the same macro set to both the host gcc build of the
    reference tcc and the badc build of the stage1 tcc.
    """
    return tuple(f"-D{m}=1" for m in target_macros)


def tu_flags_for(profile: dict[str, tuple[str, ...]]) -> tuple[str, ...]:
    """Flags every tinycc TU needs to see. ``-D_GNU_SOURCE`` is
    dropped even though smoke.py passes it through to badc -- tcc.h
    already defines it at the top of the file, and tcc's own
    preprocessor warns on the redefinition.
    """
    return (
        *target_macro_flags(profile["target_macros"]),
        "-DONE_SOURCE=0",
        "-I",
        str(TINYCC_DIR),
    )


def detect_multiarch_include() -> Path | None:
    """Return the host's `/usr/include/<multiarch>` directory if it
    exists. On modern Debian / Ubuntu, glibc headers like stdlib.h
    pull in `<bits/libc-header-start.h>` which lives under this
    multiarch directory; tcc has to be told about it explicitly.
    Returns ``None`` on non-multiarch hosts (e.g. RHEL-like)."""
    try:
        out = subprocess.run(
            ["gcc", "-print-multiarch"],
            capture_output=True,
            text=True,
            check=True,
        ).stdout.strip()
    except (FileNotFoundError, subprocess.CalledProcessError):
        return None
    if not out:
        return None
    cand = Path("/usr/include") / out
    return cand if cand.is_dir() else None


def detect_macos_sdk() -> Path | None:
    """Return the active macOS SDK root via `xcrun --show-sdk-path`.
    `/usr/include` is not directly populated on modern macOS; the
    headers live under `$SDK/usr/include`. Returns ``None`` if
    `xcrun` is missing or returns nothing."""
    try:
        out = subprocess.run(
            ["xcrun", "--show-sdk-path"],
            capture_output=True,
            text=True,
            check=True,
        ).stdout.strip()
    except (FileNotFoundError, subprocess.CalledProcessError):
        return None
    if not out:
        return None
    cand = Path(out)
    return cand if cand.is_dir() else None


def main() -> int:
    host = host_key()
    profile = HOST_PROFILES.get(host)
    if profile is None:
        return env_unsuitable(
            f"unsupported host {host[0]}/{host[1]}; the harness only "
            f"knows how to build the host reference + stage1 tcc on "
            f"Linux x86_64 / aarch64, Darwin arm64, and Windows "
            f"x86_64 / ARM64"
        )

    # GitHub-hosted Windows runners ship mingw-w64; the binary is
    # spelled `gcc.exe`. Linux / macOS go through the regular
    # `gcc` / `cc` lookup. The reference tcc must be built by a
    # C99 compiler whose driver understands `-c`, `-o`, and the
    # standard `-D` / `-I` flags -- gcc, clang, and mingw-gcc all
    # qualify; MSVC (`cl.exe`) needs a different driver shape and
    # is not handled by this harness.
    cc = shutil.which("gcc") or shutil.which("clang") or shutil.which("cc")
    if not cc:
        return env_unsuitable("gcc / clang / cc not on PATH")

    badc = resolve_badc()
    if not badc:
        return env_unsuitable(
            f"BADC binary not found; build with "
            f"`cargo build --release --manifest-path={REPO_ROOT}/Cargo.toml`"
        )

    if not (TINYCC_DIR / "tcc.h").is_file():
        subprocess.run(
            [sys.executable, str(TINYCC_DIR / "setup.py")],
            check=True,
        )

    work = TINYCC_DIR / ".self_host"
    if work.exists():
        shutil.rmtree(work)
    work.mkdir()
    samples_dir = work / "samples"
    samples_dir.mkdir()
    for name, body in SAMPLES.items():
        (samples_dir / name).write_text(body)

    # Both compiler builds and every subsequent `tcc -c` need the
    # same target-selection macros baked in. Write the synthesized
    # config.h up front; smoke.py may have left a different lane's
    # macros from a previous run.
    config_lines = [
        "/* synthesized by self_host.py -- mirrors smoke.py per-host row */",
        '#define TCC_VERSION "0.9.28-badc"',
        "#define CC_NAME CC_clang",
        "#define GCC_MAJOR 0",
        "#define GCC_MINOR 0",
    ]
    for m in profile["target_macros"]:
        config_lines.append(f"#define {m} 1")
    config_lines.append("#define CONFIG_TCC_PREDEFS 0")
    config_lines.append("#define CONFIG_TCC_SEMLOCK 0")
    config_lines.append("#define CONFIG_TCC_BACKTRACE 0")
    (TINYCC_DIR / "config.h").write_text("\n".join(config_lines) + "\n")

    multiarch_dir = detect_multiarch_include()
    sdk_dir = detect_macos_sdk() if host[0] == "Darwin" else None

    ref_tcc = build_reference_tcc(cc, work, multiarch_dir, profile, host, sdk_dir)
    if ref_tcc is None:
        return 1

    stage1_tcc = build_stage1_tcc(badc, work, multiarch_dir, profile, host, sdk_dir)
    if stage1_tcc is None:
        return 1

    # Windows lanes only -- probe whether the badc-built tcc-stage1
    # binary starts at all before any compile is attempted. Running
    # `tcc-stage1.exe -v` exercises CRT init + the version-print
    # path; the exit code distinguishes a PE loader / startup
    # failure (AV during dispatch) from a per-sample compile bug.
    if host[0] == "Windows":
        probe = subprocess.run(
            [str(stage1_tcc), "-v"],
            capture_output=True,
            text=True,
            encoding="utf-8",
            errors="replace",
        )
        print(
            f"tinycc self-host -- probe (-v): exit={probe.returncode} "
            f"stdout={probe.stdout.strip()!r} stderr={probe.stderr.strip()!r}"
        )

    matches = 0
    mismatches: list[str] = []
    failures: list[tuple[str, str, str]] = []

    for sample in sorted(samples_dir.glob("*.c")):
        name = sample.name
        ref_o = work / f"{name}.ref.o"
        s1_o = work / f"{name}.s1.o"

        ok_ref, err_ref = compile_with(ref_tcc, sample, ref_o)
        if not ok_ref:
            failures.append((name, "ref", err_ref))
            continue
        ok_s1, err_s1 = compile_with(stage1_tcc, sample, s1_o)
        if not ok_s1:
            failures.append((name, "stage1", err_s1))
            continue

        if ref_o.read_bytes() == s1_o.read_bytes():
            matches += 1
        else:
            mismatches.append(name)

    total = len(SAMPLES)
    print(
        f"tinycc self-host -- samples byte-identical: "
        f"{matches}/{total} (mismatches: {len(mismatches)}, "
        f"failures: {len(failures)})"
    )
    for name, side, err in failures:
        print(f"  FAIL  ({side}) {name}: {err}", file=sys.stderr)
    for name in mismatches:
        print(f"  DIFF  {name}", file=sys.stderr)

    # Parity on the real tinycc corpus -- the same TUs the smoke
    # step links. Strictly larger surface than the curated samples.
    # The multiarch `-D` flags from `tcc_build_defines` are passed
    # through to every TU compile so the gen2 binary (linked from
    # the resulting objects) carries the same baked-in
    # `CONFIG_TCC_*` paths as the reference; without that, gen2's
    # runtime library search misses `/usr/lib/<triplet>/`.
    multiarch = multiarch_dir
    host_tus: tuple[str, ...] = profile["tus"]
    tu_flags: tuple[str, ...] = tu_flags_for(profile)
    if multiarch is not None:
        tu_flags = tu_flags + ("-I", str(multiarch))
    tu_flags = tu_flags + tcc_build_defines(multiarch, host, sdk_dir)
    tu_matches = 0
    tu_mismatches: list[str] = []
    tu_failures: list[tuple[str, str, str]] = []

    for name in host_tus:
        src = TINYCC_DIR / name
        ref_o = work / f"corpus.{name}.ref.o"
        s1_o = work / f"corpus.{name}.s1.o"

        ok_ref, err_ref = compile_with(ref_tcc, src, ref_o, tu_flags)
        if not ok_ref:
            tu_failures.append((name, "ref", err_ref))
            continue
        ok_s1, err_s1 = compile_with(stage1_tcc, src, s1_o, tu_flags)
        if not ok_s1:
            tu_failures.append((name, "stage1", err_s1))
            continue

        if ref_o.read_bytes() == s1_o.read_bytes():
            tu_matches += 1
        else:
            tu_mismatches.append(name)
            print(
                f"tinycc self-host -- corpus diff [{name}]:\n"
                f"{describe_byte_diff(ref_o, s1_o)}",
                file=sys.stderr,
            )

    print(
        f"tinycc self-host -- corpus byte-identical: "
        f"{tu_matches}/{len(host_tus)} (mismatches: {len(tu_mismatches)}, "
        f"failures: {len(tu_failures)})"
    )
    for name, side, err in tu_failures:
        print(f"  TU FAIL  ({side}) {name}: {err}", file=sys.stderr)
    for name in tu_mismatches:
        print(f"  TU DIFF  {name}", file=sys.stderr)

    # Bootstrap fixed point: link the stage1-compiled tinycc
    # objects into a runnable `tcc-gen2` with host gcc, run
    # gen2 to compile every TU into a fresh set of objects, and
    # assert each gen2 object byte-equals its gen3 sibling.
    # libtcc1.a is not on disk yet (TODO marker), so the link
    # uses the host toolchain rather than gen2 itself; the
    # comparison still asserts the compile path is bootstrap-
    # stable: a compiler built from gen2-objs produces the same
    # objects gen2-objs were.
    gen2_tcc: Path | None = None
    gen2_objs = [work / f"corpus.{name}.s1.o" for name in host_tus]
    if tu_failures:
        bootstrap_skip = "corpus pass had failures"
    elif not all(p.is_file() for p in gen2_objs):
        bootstrap_skip = "missing one or more gen2 objects"
    else:
        gen2_tcc = work / "tcc-gen2"
        libtcc1 = build_libtcc1_archive(stage1_tcc, work, host)
        if libtcc1 is None:
            gen2_tcc = None
            bootstrap_skip = "libtcc1.a build failed"
        else:
            if host[0] in ("Darwin", "Windows"):
                # `tcc -c` always writes ELF intermediates regardless
                # of the target format (libtcc.c sets
                # `output_format = ELF` on `TCC_OUTPUT_OBJ`); the
                # PE / Mach-O conversion only happens at link. ld64
                # cannot consume ELF; mingw ld on Windows accepts an
                # x86_64 ELF object but mishandles tinycc's PE-side
                # relocations (`.uw_base` against `.pdata` overflows
                # the 32-bit displacement) and rejects an AArch64
                # ELF object outright with the wrong-format
                # diagnostic. Both shapes link cleanly through
                # ref_tcc itself, which reads its own ELF
                # intermediates and emits Mach-O / PE through the
                # in-process linker.
                link_cmd = [
                    str(ref_tcc),
                    "-B",
                    str(TINYCC_DIR),
                    "-o",
                    str(gen2_tcc),
                    *[str(p) for p in gen2_objs],
                    *[str(p) for p in libtcc1_objects_for_gen2_link(libtcc1)],
                ]
            else:
                link_cmd = [
                    cc,
                    "-O0",
                    "-g",
                    # tcc's `.eh_frame` records can overlap on
                    # multi-TU output; passing `--no-eh-frame-hdr`
                    # matches the workaround upstream's Makefile
                    # uses when host ld objects.
                    *host_link_flags(host),
                    "-o",
                    str(gen2_tcc),
                    *[str(p) for p in gen2_objs],
                    *[str(p) for p in libtcc1_objects_for_gen2_link(libtcc1)],
                    *host_link_libs(host),
                ]
            link_proc = subprocess.run(link_cmd, capture_output=True, text=True, encoding="utf-8", errors="replace")
            if link_proc.returncode != 0:
                print("self_host: gen2 link failed:", file=sys.stderr)
                print(link_proc.stderr, file=sys.stderr)
                gen2_tcc = None
                bootstrap_skip = "gen2 link failed"
            else:
                codesign_if_macos(host, gen2_tcc)
                bootstrap_skip = ""

    # Stage1 self-link of the gen2 binary -- drops the host gcc /
    # clang dependency on the link step. On Linux the recipe pulls
    # in the host's CRT trio + `libc.so.6` directly (the GNU `ld`
    # linker script under `libc.so` pulls in `libc_nonshared.a`;
    # the static archive's contents -- `atexit` /
    # `__stack_chk_fail_local` / `pthread_atfork` -- are not
    # referenced by tinycc itself). On macOS, stage1 is invoked
    # without `-nostdlib` so it auto-resolves libSystem through
    # the SDK lib path baked into `CONFIG_TCC_LIBPATHS`.
    gen2_self_tcc: Path | None = None
    gen2_self_skip = ""
    if gen2_tcc is None:
        gen2_self_skip = "no gen2 to mirror"
    elif host[0] in ("Darwin", "Windows"):
        # macOS / Windows: stage1 self-links the gen2 objects
        # against `libtcc1.a`. No host CRT is spliced in -- tcc's
        # PE linker pulls `_start` from libtcc1.a's crt1 member and
        # auto-binds the msvcrt / libSystem surface through the
        # import-lib search rooted at `-B`.
        libtcc1 = work / "libtcc1.a"
        gen2_self_tcc = work / "tcc-gen2-self"
        link_cmd = [
            str(stage1_tcc),
            "-B",
            str(TINYCC_DIR),
            "-o",
            str(gen2_self_tcc),
            *[str(p) for p in gen2_objs],
            str(libtcc1),
        ]
        link_proc = subprocess.run(link_cmd, capture_output=True, text=True, encoding="utf-8", errors="replace")
        if link_proc.returncode != 0:
            print("self_host: gen2-self link failed:", file=sys.stderr)
            print(link_proc.stderr, file=sys.stderr)
            gen2_self_tcc = None
            gen2_self_skip = "stage1 link failed"
        elif host[0] == "Darwin":
            codesign_if_macos(host, gen2_self_tcc)
    elif multiarch is not None:
        triplet = multiarch.name
        crt_dir = Path(f"/usr/lib/{triplet}")
        crt1 = crt_dir / "crt1.o"
        crti = crt_dir / "crti.o"
        crtn = crt_dir / "crtn.o"
        libc = Path(f"/lib/{triplet}/libc.so.6")
        if not libc.is_file():
            libc = crt_dir / "libc.so.6"
        if all(p.is_file() for p in (crt1, crti, crtn, libc)):
            libtcc1 = work / "libtcc1.a"
            gen2_self_tcc = work / "tcc-gen2-self"
            link_cmd = [
                str(stage1_tcc),
                "-B",
                str(TINYCC_DIR),
                "-nostdlib",
                str(crt1),
                str(crti),
                *[str(p) for p in gen2_objs],
                str(libtcc1),
                str(libc),
                str(crtn),
                "-o",
                str(gen2_self_tcc),
            ]
            link_proc = subprocess.run(link_cmd, capture_output=True, text=True, encoding="utf-8", errors="replace")
            if link_proc.returncode != 0:
                print("self_host: gen2-self link failed:", file=sys.stderr)
                print(link_proc.stderr, file=sys.stderr)
                gen2_self_tcc = None
                gen2_self_skip = "stage1 link failed"
        else:
            gen2_self_skip = "host CRT / libc.so.6 not at expected multiarch path"
    else:
        gen2_self_skip = "non-multiarch host"

    boot_matches = 0
    boot_mismatches: list[str] = []
    boot_failures: list[tuple[str, str, str]] = []

    if gen2_tcc is not None:
        for name in host_tus:
            src = TINYCC_DIR / name
            gen2_o = work / f"corpus.{name}.s1.o"
            gen3_o = work / f"corpus.{name}.gen3.o"
            ok, err = compile_with(gen2_tcc, src, gen3_o, tu_flags)
            if not ok:
                boot_failures.append((name, "gen3", err))
                continue
            if gen2_o.read_bytes() == gen3_o.read_bytes():
                boot_matches += 1
            else:
                boot_mismatches.append(name)
                print(
                    f"tinycc self-host -- bootstrap diff [{name}]:\n"
                    f"{describe_byte_diff(gen2_o, gen3_o)}",
                    file=sys.stderr,
                )
        print(
            f"tinycc self-host -- gen2 == gen3 byte-identical: "
            f"{boot_matches}/{len(host_tus)} "
            f"(mismatches: {len(boot_mismatches)}, "
            f"failures: {len(boot_failures)})"
        )
        for name, side, err in boot_failures:
            print(f"  BOOT FAIL  ({side}) {name}: {err}", file=sys.stderr)
        for name in boot_mismatches:
            print(f"  BOOT DIFF  {name}", file=sys.stderr)
    else:
        print(f"tinycc self-host -- bootstrap skipped: {bootstrap_skip}")

    # gen2-self compile gate -- have stage1 link gen2 itself
    # (no host gcc), then run that binary to recompile every TU
    # and assert the resulting objects match the gen3 set
    # produced by the gcc-linked gen2 binary. Proves the
    # stage1-linker output is functionally equivalent to the host
    # linker's for the full tinycc corpus.
    gen2_self_matches = 0
    gen2_self_mismatches: list[str] = []
    gen2_self_failures: list[tuple[str, str, str]] = []
    if gen2_self_tcc is not None:
        for name in host_tus:
            src = TINYCC_DIR / name
            gen3_o = work / f"corpus.{name}.gen3.o"
            gen3_self_o = work / f"corpus.{name}.gen3-self.o"
            ok, err = compile_with(gen2_self_tcc, src, gen3_self_o, tu_flags)
            if not ok:
                gen2_self_failures.append((name, "gen3-self", err))
                continue
            if gen3_o.read_bytes() == gen3_self_o.read_bytes():
                gen2_self_matches += 1
            else:
                gen2_self_mismatches.append(name)
                print(
                    f"tinycc self-host -- gen2-self diff [{name}]:\n"
                    f"{describe_byte_diff(gen3_o, gen3_self_o)}",
                    file=sys.stderr,
                )
        print(
            f"tinycc self-host -- gen2-self compile == gen3: "
            f"{gen2_self_matches}/{len(host_tus)} "
            f"(mismatches: {len(gen2_self_mismatches)}, "
            f"failures: {len(gen2_self_failures)})"
        )
        for name, side, err in gen2_self_failures:
            print(f"  SELF FAIL  ({side}) {name}: {err}", file=sys.stderr)
        for name in gen2_self_mismatches:
            print(f"  SELF DIFF  {name}", file=sys.stderr)
    else:
        print(f"tinycc self-host -- gen2-self skipped: {gen2_self_skip}")

    # Functional check: stage1 and gen2 must produce code that
    # actually runs, not just code that's byte-equivalent to the
    # gcc-built reference. Byte equality catches codegen drift;
    # this run-test catches a class of bugs where badc produces
    # technically-correct-looking objects that crash on entry.
    hello_src = work / "hello.c"
    hello_src.write_text(
        '#include <stdio.h>\n'
        'int main(int argc, char **argv) {\n'
        '    (void)argv;\n'
        '    printf("hello-from-tcc\\n");\n'
        '    return argc + 40;\n'
        '}\n'
    )
    functional_failures: list[str] = []
    hello_extra: tuple[str, ...] = ()
    if multiarch is not None:
        hello_extra = ("-I", str(multiarch))
    # When the host has a multiarch directory, link via the host's
    # CRT objects + `libc.so.6` (the shared library) directly.
    # Passing `libc.so` would land on a GNU `ld` linker script
    # whose `GROUP` clause pulls in `libc_nonshared.a` alongside
    # `libc.so.6`. The badc-linked stage1 binary fails to load
    # that archive (TODO marker for the badc-link-path bug --
    # gcc-linked tcc binaries built from identical objects load
    # it without complaint, so the regression is the linker, not
    # tcc's reader). `libc.so.6` carries the symbols this
    # `hello.c` resolves (`printf`, `puts`, `__libc_start_main`);
    # the static archive's contents (`atexit`,
    # `__stack_chk_fail_local`, `pthread_atfork`) are not
    # referenced by a stack-protector-off, no-atexit program.
    self_link_lib = None
    if multiarch is not None:
        triplet = multiarch.name
        crt_dir = Path(f"/usr/lib/{triplet}")
        crt1 = crt_dir / "crt1.o"
        crti = crt_dir / "crti.o"
        crtn = crt_dir / "crtn.o"
        libc = Path(f"/lib/{triplet}/libc.so.6")
        if not libc.is_file():
            libc = crt_dir / "libc.so.6"
        if all(p.is_file() for p in (crt1, crti, crtn, libc)):
            self_link_lib = (crt1, crti, libc, crtn)
    for name, tcc_bin in (("stage1", stage1_tcc), ("gen2", gen2_tcc)):
        if tcc_bin is None:
            continue
        hello_o = work / f"hello.{name}.o"
        hello_bin = work / f"hello.{name}.bin"
        ok, err = compile_with(tcc_bin, hello_src, hello_o, hello_extra)
        if not ok:
            functional_failures.append(f"{name} compile: {err}")
            continue
        if self_link_lib is not None:
            link_cmd = [
                str(tcc_bin),
                "-B",
                str(TINYCC_DIR),
                "-nostdlib",
                str(self_link_lib[0]),
                str(self_link_lib[1]),
                str(hello_o),
                str(self_link_lib[2]),
                str(self_link_lib[3]),
                "-o",
                str(hello_bin),
            ]
        elif host[0] in ("Darwin", "Windows"):
            # `tcc -c` emits ELF on every host; ld64 on macOS and
            # mingw ld on Windows both mishandle tinycc's ELF
            # intermediate (the PE side overflows the `.pdata`
            # `.uw_base` relocation, AArch64 ELF is outright
            # rejected). Link through `tcc_bin` itself -- it reads
            # its own ELF intermediate and produces a Mach-O / PE
            # executable through the in-process linker.
            link_cmd = [
                str(tcc_bin),
                "-B",
                str(TINYCC_DIR),
                "-o",
                str(hello_bin),
                str(hello_o),
            ]
        else:
            link_cmd = [cc, "-o", str(hello_bin), str(hello_o)]
        link_proc = subprocess.run(link_cmd, capture_output=True, text=True, encoding="utf-8", errors="replace")
        if link_proc.returncode != 0:
            functional_failures.append(f"{name} link: {link_proc.stderr.strip()}")
            continue
        codesign_if_macos(host, hello_bin)
        run_proc = subprocess.run(
            [str(hello_bin)], capture_output=True, text=True
        )
        if run_proc.returncode != 41:
            functional_failures.append(
                f"{name} run: exit {run_proc.returncode}, want 41"
            )
            continue
        if run_proc.stdout != "hello-from-tcc\n":
            functional_failures.append(
                f"{name} run: stdout {run_proc.stdout!r}, want 'hello-from-tcc\\n'"
            )
    if self_link_lib is not None:
        linker_label = "stage1 self-link"
    elif host[0] == "Darwin":
        linker_label = "tcc-driven Mach-O link"
    else:
        linker_label = "host gcc link"
    print(
        f"tinycc self-host -- functional ({linker_label}): "
        f"{2 - len(functional_failures)}/2 hello-world round trips"
    )
    for f in functional_failures:
        print(f"  FUNC FAIL  {f}", file=sys.stderr)

    # Known-drifting TUs are surfaced but do not fail. Each entry
    # is tracked with a TODO marker; whittling the set down is
    # the work of closing the underlying bug. Empty on every
    # POSIX lane today.
    KNOWN_DRIFT: set[str] = set()

    unexpected_corpus = [n for n in tu_mismatches if n not in KNOWN_DRIFT]
    unexpected_boot = [n for n in boot_mismatches if n not in KNOWN_DRIFT]

    # Windows lanes (PE x86_64 / arm64): samples + corpus +
    # bootstrap are strict-gated -- every Windows lane reaches
    # byte-identical gen2 == gen3 against the host-gcc-built
    # reference tcc, so a regression there fails CI. gen2-self
    # and functional stay in soft bringup on the arm64 lane: the
    # stage1 binary's self-link path AVs at runtime (the gen3
    # objects are emitted correctly, but the binary linked by
    # stage1 itself crashes on entry -- a c5 codegen issue in
    # tccpe.c's link-time runtime, not in any compile-side
    # output). TODO: localize the stage1-self-link AV on
    # Windows arm64 and promote gen2-self / functional to
    # strict-gate.
    if host[0] == "Windows":
        if failures or mismatches:
            return 1
        if tu_failures or unexpected_corpus:
            return 1
        if boot_failures or unexpected_boot:
            return 1
        return 0

    # Sample failures + mismatches gate the build. Corpus and
    # bootstrap *failures* (running the binary at all) gate. So do
    # mismatches outside KNOWN_DRIFT -- those are regressions.
    if failures or mismatches:
        return 1
    if tu_failures:
        return 1
    if boot_failures:
        return 1
    if unexpected_corpus:
        print("self_host: unexpected corpus diff -- regression:", file=sys.stderr)
        for name in unexpected_corpus:
            print(f"  {name}", file=sys.stderr)
        return 1
    if unexpected_boot:
        print("self_host: unexpected bootstrap diff -- regression:", file=sys.stderr)
        for name in unexpected_boot:
            print(f"  {name}", file=sys.stderr)
        return 1
    if functional_failures:
        return 1
    # gen2-self: the gen2 binary is linked by stage1 (not host gcc)
    # and then asked to compile every tinycc TU. Both the linker
    # and the compile output must succeed; the per-TU object must
    # match gen3 byte-for-byte (gen3 was the same TU compiled by
    # the host-linked gen2).
    if gen2_self_failures or gen2_self_mismatches:
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
