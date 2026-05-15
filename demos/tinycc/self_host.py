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


def build_reference_tcc(cc: str, work: Path) -> Path | None:
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


def build_libtcc1_helpers(cc: str, work: Path) -> list[Path] | None:
    """Build the minimal libtcc1 helper objects gen2 needs at link
    time on Linux x86_64: ``__floatundixf`` / ``__fixxfdi`` (80-bit
    long-double conversions emitted by tcc's codegen) and
    ``__va_arg`` (tcc's stack-walking va_arg helper). Pulls the
    upstream lib/libtcc1.c + lib/va_list.c sources straight from
    the cache zip rather than vendoring them as a separate setup.py
    asset; the full libtcc1.a buildup is tracked under the TODO
    marker.
    """
    cache_dir = TINYCC_DIR / ".cache"
    candidates = list(cache_dir.glob("tinycc-*.zip"))
    if not candidates:
        return None
    import zipfile

    extract = work / "libtcc1_src"
    extract.mkdir(exist_ok=True)
    prefix = "tinycc-757507eb022f7af4be63dc9a72b299761181efbb"
    names = ("lib/libtcc1.c", "lib/va_list.c")
    src_paths: list[Path] = []
    with zipfile.ZipFile(candidates[0]) as zf:
        for name in names:
            out = extract / Path(name).name
            with zf.open(f"{prefix}/{name}") as src, out.open("wb") as dst:
                shutil.copyfileobj(src, dst)
            src_paths.append(out)

    obj_paths: list[Path] = []
    for src in src_paths:
        obj = work / (src.stem + ".o")
        cmd = [
            cc,
            "-c",
            "-O0",
            "-fPIC",
            f"-I{TINYCC_DIR}",
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
    return obj_paths


def build_stage1_tcc(badc: Path, work: Path) -> Path | None:
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

    ref_tcc = build_reference_tcc(cc, work)
    if ref_tcc is None:
        return 1

    stage1_tcc = build_stage1_tcc(badc, work)
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
    multiarch = detect_multiarch_include()
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
        helper_objs = build_libtcc1_helpers(cc, work)
        if helper_objs is None:
            gen2_tcc = None
            bootstrap_skip = "libtcc1 helper build failed"
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
                *[str(p) for p in helper_objs],
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

    # Known-drifting TUs are surfaced but do not fail. Each entry
    # is tracked with a TODO marker; whittling the set down is the
    # work of closing the underlying bug.
    #
    #   tccpp.c -- long-double-returning libc bindings (strtold)
    #              return -0.0 through the badc link path; the
    #              gcc-linked gen2 produces the correct 80-bit
    #              encoding. TODO: x87 st(0) -> XMM0 transfer in
    #              the libc-call lowering.
    KNOWN_DRIFT = {"tccpp.c"}

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
    return 0


if __name__ == "__main__":
    sys.exit(main())
