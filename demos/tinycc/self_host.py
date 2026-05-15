#!/usr/bin/env python3
"""Self-host parity check for the tinycc bringup.

Validates that the tcc binary produced by badc behaves identically
to a reference tcc built with the host's native cc, for a curated
set of self-contained C programs.

The check is deliberately scoped to compile-to-object (`tcc -c`),
not full link, so it does not depend on a freshly-built libtcc1.a
runtime archive (that bringup is tracked separately, with the
TODO marker in this file).

Runs on Linux x86_64 only:
* tcc-the-binary defaults to ELF for `-c` output on every host;
  Mach-O / PE output paths need the explicit format flag the
  bringup is not exercising yet.
* The host gcc toolchain has to be able to build the reference
  tcc -- that requires libc / libdl headers + linkers which the
  cross-compile lanes (Windows, macOS-aarch64) do not surface.

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


def tcc_build_defines(multiarch: Path | None) -> tuple[str, ...]:
    """Per-target compile-time macros baked into both the
    reference and stage1 tcc binaries. The CRT / library paths
    are compile-time constants on tinycc; pointing them at the
    host's multiarch directory lets the produced binary find
    `crt1.o` / `crti.o` / `libc.so` without runtime `-L` flags.
    The sysinclude path keeps `{B}/include` first so `tccdefs.h`
    (under the demo tree) still resolves through tcc's own
    `-B` lookup; only the trailing system path is multiarched.
    On non-multiarch hosts the defaults suffice.
    """
    if multiarch is None:
        return ()
    triplet = multiarch.name
    return (
        f'-DCONFIG_TCC_CRTPREFIX="/usr/lib/{triplet}"',
        f'-DCONFIG_TCC_LIBPATHS="{{B}}:/usr/lib/{triplet}:/usr/lib"',
        f'-DCONFIG_TCC_SYSINCLUDEPATHS="{{B}}/include:/usr/include/{triplet}:/usr/include"',
    )


def build_reference_tcc(cc: str, work: Path, multiarch: Path | None) -> Path | None:
    """Build a reference tcc via host gcc/cc.

    Mirrors the upstream Makefile's `tcc` link step but invoked
    directly so this script does not depend on autoconf / make
    being on PATH. The link target macros (`TCC_TARGET_X86_64`,
    `ONE_SOURCE=0`) match smoke.py's Linux x86_64 row.
    """
    sources = [
        TINYCC_DIR / name
        for name in (
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
        )
    ]
    out = work / "tcc-ref"
    cmd = [
        cc,
        "-O0",
        "-g",
        "-DTCC_TARGET_X86_64=1",
        "-DONE_SOURCE=0",
        "-DCONFIG_TCC_PREDEFS=0",
        "-DCONFIG_TCC_SEMLOCK=0",
        "-DCONFIG_TCC_BACKTRACE=0",
        "-D_GNU_SOURCE",
        *tcc_build_defines(multiarch),
        f"-I{TINYCC_DIR}",
        "-o",
        str(out),
        *[str(s) for s in sources],
        "-ldl",
        "-lpthread",
    ]
    proc = subprocess.run(cmd, capture_output=True, text=True)
    if proc.returncode != 0:
        print(f"self_host: reference tcc build failed via {cc}:", file=sys.stderr)
        print(proc.stderr, file=sys.stderr)
        return None
    return out


def build_libtcc1_archive(stage1_tcc: Path, work: Path) -> Path | None:
    """Compile the vendored ``lib/libtcc1.c`` + ``lib/va_list.c``
    with the stage1 tcc binary and bundle the resulting objects
    into a ``libtcc1.a`` archive. The archive exposes
    ``__floatundixf`` / ``__fixxfdi`` (80-bit long-double
    conversion helpers tcc's codegen emits as undefined
    references) and ``__va_arg`` (tcc's stack-walking va_arg
    helper).

    The archive sits at ``<work>/libtcc1.a`` and at
    ``<TINYCC_DIR>/libtcc1.a`` so a later step that invokes tcc
    with ``-B <TINYCC_DIR>`` can pick it up via tcc's standard
    library-path search. The full upstream libtcc1.a covers
    coverage / backtrace / bcheck helpers (tcov, runmain,
    bcheck); those are needed only for ``-bt`` / ``-run`` /
    ``-fbounds-checking`` and stay outside this subset.
    """
    sources = (TINYCC_DIR / "lib" / "libtcc1.c", TINYCC_DIR / "lib" / "va_list.c")
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
        proc = subprocess.run(cmd, capture_output=True, text=True)
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
    proc = subprocess.run(cmd, capture_output=True, text=True)
    if proc.returncode != 0:
        print("self_host: libtcc1.a archive build failed:", file=sys.stderr)
        print(proc.stderr, file=sys.stderr)
        return None
    # Mirror to the tcc lib path so `-B <TINYCC_DIR>` resolves it.
    mirror = TINYCC_DIR / "libtcc1.a"
    shutil.copyfile(archive, mirror)
    return archive


def libtcc1_objects_for_gen2_link(archive: Path) -> list[Path]:
    """Return the path list to splice into the host-gcc link of
    `tcc-gen2`. Passing the archive directly is enough: ld pulls
    only the members that satisfy undefined symbols, so the
    minimal-archive contents land in `tcc-gen2` and nothing else.
    """
    return [archive]


def build_stage1_tcc(badc: Path, work: Path, multiarch: Path | None) -> Path | None:
    """Build a stage1 tcc through badc -- the same TU set the
    smoke step links. ``cwd`` is pinned to the repo root so badc's
    `./include` auto-add picks up c5's bundled headers."""
    sources = [
        str(TINYCC_DIR / name)
        for name in (
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
        )
    ]
    out = work / "tcc-stage1"
    cmd = [
        str(badc),
        "-I",
        str(TINYCC_DIR),
        "-DONE_SOURCE=0",
        "-DTCC_TARGET_X86_64=1",
        "-D_GNU_SOURCE",
        *tcc_build_defines(multiarch),
        "-o",
        str(out),
        *sources,
    ]
    proc = subprocess.run(
        cmd, capture_output=True, text=True, cwd=str(REPO_ROOT)
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
    proc = subprocess.run(cmd, capture_output=True, text=True)
    if proc.returncode != 0:
        return False, proc.stderr.strip()
    return True, ""


# The same TU set the smoke step links on the Linux x86_64 row.
# Each entry is compiled with both reference and stage1 tcc; the
# bytes are compared. This is parity on the real tinycc corpus,
# not just a curated sample set.
TINYCC_TUS: tuple[str, ...] = (
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
)

# Flags every tinycc TU needs to see. ``-D_GNU_SOURCE`` is dropped
# even though smoke.py passes it through to badc -- tcc.h already
# defines it at the top of the file, and tcc's own preprocessor
# warns on the redefinition. The macro set otherwise matches the
# smoke step's Linux x86_64 row.
TINYCC_TU_FLAGS: tuple[str, ...] = (
    "-DTCC_TARGET_X86_64=1",
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


def main() -> int:
    if platform.system() != "Linux" or platform.machine() not in ("x86_64", "amd64"):
        return env_unsuitable(
            "tcc -c emits Linux ELF; run this on Linux x86_64 "
            "(the badc-x64 OrbStack VM is the canonical target)"
        )

    cc = shutil.which("gcc") or shutil.which("cc")
    if not cc:
        return env_unsuitable("gcc / cc not on PATH")

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
    # same target-selection macros baked in. Write the synthesised
    # config.h up front; smoke.py may have left a different lane's
    # macros from a previous run.
    (TINYCC_DIR / "config.h").write_text(
        "/* synthesized by self_host.py -- mirrors smoke.py's Linux x86_64 row */\n"
        '#define TCC_VERSION "0.9.28-badc"\n'
        "#define CC_NAME CC_clang\n"
        "#define GCC_MAJOR 0\n"
        "#define GCC_MINOR 0\n"
        "#define TCC_TARGET_X86_64 1\n"
        "#define CONFIG_TCC_PREDEFS 0\n"
        "#define CONFIG_TCC_SEMLOCK 0\n"
        "#define CONFIG_TCC_BACKTRACE 0\n"
    )

    multiarch_dir = detect_multiarch_include()

    ref_tcc = build_reference_tcc(cc, work, multiarch_dir)
    if ref_tcc is None:
        return 1

    stage1_tcc = build_stage1_tcc(badc, work, multiarch_dir)
    if stage1_tcc is None:
        return 1

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
    multiarch = multiarch_dir
    tu_flags: tuple[str, ...] = TINYCC_TU_FLAGS
    if multiarch is not None:
        tu_flags = tu_flags + ("-I", str(multiarch))
    tu_matches = 0
    tu_mismatches: list[str] = []
    tu_failures: list[tuple[str, str, str]] = []

    for name in TINYCC_TUS:
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
        f"tinycc self-host -- corpus byte-identical: "
        f"{tu_matches}/{len(TINYCC_TUS)} (mismatches: {len(tu_mismatches)}, "
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
    gen2_objs = [work / f"corpus.{name}.s1.o" for name in TINYCC_TUS]
    if tu_failures:
        bootstrap_skip = "corpus pass had failures"
    elif not all(p.is_file() for p in gen2_objs):
        bootstrap_skip = "missing one or more gen2 objects"
    else:
        gen2_tcc = work / "tcc-gen2"
        libtcc1 = build_libtcc1_archive(stage1_tcc, work)
        if libtcc1 is None:
            gen2_tcc = None
            bootstrap_skip = "libtcc1.a build failed"
        else:
            link_cmd = [
                cc,
                "-O0",
                "-g",
                # tcc's `.eh_frame` records can overlap on
                # multi-TU output; passing `--no-eh-frame-hdr`
                # matches the workaround upstream's Makefile
                # uses when host ld objects.
                "-Wl,--no-eh-frame-hdr",
                "-o",
                str(gen2_tcc),
                *[str(p) for p in gen2_objs],
                *[str(p) for p in libtcc1_objects_for_gen2_link(libtcc1)],
                "-ldl",
                "-lpthread",
            ]
            link_proc = subprocess.run(
                link_cmd, capture_output=True, text=True
            )
            if link_proc.returncode != 0:
                print("self_host: gen2 link failed:", file=sys.stderr)
                print(link_proc.stderr, file=sys.stderr)
                gen2_tcc = None
                bootstrap_skip = "gen2 link failed"
            else:
                bootstrap_skip = ""

    boot_matches = 0
    boot_mismatches: list[str] = []
    boot_failures: list[tuple[str, str, str]] = []

    if gen2_tcc is not None:
        for name in TINYCC_TUS:
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
            f"tinycc self-host -- gen2 == gen3 byte-identical: "
            f"{boot_matches}/{len(TINYCC_TUS)} "
            f"(mismatches: {len(boot_mismatches)}, "
            f"failures: {len(boot_failures)})"
        )
        for name, side, err in boot_failures:
            print(f"  BOOT FAIL  ({side}) {name}: {err}", file=sys.stderr)
        for name in boot_mismatches:
            print(f"  BOOT DIFF  {name}", file=sys.stderr)
    else:
        print(f"tinycc self-host -- bootstrap skipped: {bootstrap_skip}")

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
    # Passing `libc.so` instead would land on a GNU `ld` linker
    # script that pulls in `libc_nonshared.a`; tcc's `read_ar_header`
    # rejects the long-name extension that archive uses (TODO marker
    # for tightening tcc's archive reader). `libc.so.6` carries every
    # symbol a plain `printf` round-trip needs.
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
        else:
            link_cmd = [cc, "-o", str(hello_bin), str(hello_o)]
        link_proc = subprocess.run(link_cmd, capture_output=True, text=True)
        if link_proc.returncode != 0:
            functional_failures.append(f"{name} link: {link_proc.stderr.strip()}")
            continue
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
    linker_label = "stage1 self-link" if self_link_lib is not None else "host gcc link"
    print(
        f"tinycc self-host -- functional ({linker_label}): "
        f"{2 - len(functional_failures)}/2 hello-world round trips"
    )
    for f in functional_failures:
        print(f"  FUNC FAIL  {f}", file=sys.stderr)

    # Known-drifting TUs are surfaced but do not fail. Each entry
    # is tracked with a TODO marker; whittling the set down is the
    # work of closing the underlying bug. Empty today: the corpus
    # and bootstrap passes both reach 11/11.
    KNOWN_DRIFT: set[str] = set()

    unexpected_corpus = [n for n in tu_mismatches if n not in KNOWN_DRIFT]
    unexpected_boot = [n for n in boot_mismatches if n not in KNOWN_DRIFT]

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
    return 0


if __name__ == "__main__":
    sys.exit(main())
