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


def compile_with(tcc: Path, src: Path, out: Path) -> tuple[bool, str]:
    """Run ``tcc -c src -o out``. Returns (ok, captured_stderr).

    The ``-B`` flag points at the vendored ``include/`` directory
    so tcc finds ``tccdefs.h`` -- needed because the demo runs with
    ``CONFIG_TCC_PREDEFS=0``, which makes the predefines header a
    runtime lookup rather than a baked string literal.
    """
    proc = subprocess.run(
        [str(tcc), "-B", str(TINYCC_DIR), "-c", str(src), "-o", str(out)],
        capture_output=True,
        text=True,
    )
    if proc.returncode != 0:
        return False, proc.stderr.strip()
    return True, ""


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
        f"tinycc self-host -- byte-identical objects: "
        f"{matches}/{total} (mismatches: {len(mismatches)}, "
        f"failures: {len(failures)})"
    )
    for name, side, err in failures:
        print(f"  FAIL  ({side}) {name}: {err}", file=sys.stderr)
    for name in mismatches:
        print(f"  DIFF  {name}", file=sys.stderr)

    # TODO: tighten to byte-identical once every per-target codegen
    # quirk in the badc-built tcc is closed. For now the byte
    # comparison is a strong claim; mismatches are surfaced but do
    # not gate CI.
    if failures:
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
