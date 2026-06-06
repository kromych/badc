#!/usr/bin/env python3
"""Build-only smoke for the tinycc bringup.

tinycc is badc's next multi-TU exerciser after chibicc. The
vendored set is the multi-TU build of tcc-the-binary against badc's
targets (x86_64 + aarch64 across ELF / Mach-O / PE). This harness
synthesizes a host-specific ``config.h``, walks each upstream
``.c`` file in isolation through ``badc -c``, and records compile
state; once every TU is green the multi-TU link will follow.

Exit codes:
  0  -- every TU compiled AND (when expected) the multi-TU link
        succeeded
  1  -- a TU that previously compiled now regresses, OR the
        link failed
  2  -- skipped (host triple not in the supported matrix)

The matching parity check (``self_host.py``, follow-up once the
binary builds) will compare the badc-built tcc against a system
cc-built reference on a curated sample suite.

Override the badc binary via ``BADC`` (default:
``target/release/badc[.exe]`` next to the repo root).
"""

from __future__ import annotations

import argparse
import os
import platform
import subprocess
import sys
from pathlib import Path

TINYCC_DIR = Path(__file__).resolve().parent
REPO_ROOT = TINYCC_DIR.parent.parent

WIN = sys.platform == "win32"
DARWIN = sys.platform == "darwin"

# Host triple -> (target macros, TU set, build macros).
#
# ``target_macros`` is the set of ``TCC_TARGET_*`` defines that the
# synthesized ``config.h`` activates. ``tus`` is the list of upstream
# ``.c`` files that are valid TUs for this host -- backends and
# output-format units that don't match the target are dropped to
# avoid duplicate-symbol pile-ups in the eventual link. ``cpp_defs``
# carries any ``-D`` flags ``badc -c`` needs in addition to what
# ``config.h`` already supplies (e.g. ``_GNU_SOURCE`` on Linux so
# tinycc's libc calls pick up the right prototypes).
HOST_MATRIX = {
    ("Linux", "x86_64"): {
        "target_macros": ("TCC_TARGET_X86_64",),
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
        "cpp_defs": ("_GNU_SOURCE", "ONE_SOURCE=0"),
    },
    ("Linux", "aarch64"): {
        "target_macros": ("TCC_TARGET_ARM64",),
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
        "cpp_defs": ("_GNU_SOURCE", "ONE_SOURCE=0"),
    },
    ("Darwin", "arm64"): {
        "target_macros": ("TCC_TARGET_ARM64", "TCC_TARGET_MACHO"),
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
        "cpp_defs": ("ONE_SOURCE=0",),
    },
    ("Windows", "AMD64"): {
        "target_macros": ("TCC_TARGET_X86_64", "TCC_TARGET_PE"),
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
        "cpp_defs": ("ONE_SOURCE=0",),
    },
    ("Windows", "ARM64"): {
        "target_macros": ("TCC_TARGET_ARM64", "TCC_TARGET_PE"),
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
        "cpp_defs": ("ONE_SOURCE=0",),
    },
}

# Per-TU bringup state. Same convention as chibicc/smoke.py:
# ``True`` means the TU is expected to round-trip through
# ``badc -c`` today; a regression flips that expectation and the
# smoke returns 1. ``False`` means the TU is a known blocker and
# the smoke records it without failing.
#
# Every TU starts at ``False`` -- entries flip to ``True`` as the
# corresponding c5 gap closes.
TU_STATE = {
    "tcc.c": True,
    "libtcc.c": True,
    "tccpp.c": True,
    "tccgen.c": True,
    "tccelf.c": True,
    "tccasm.c": True,
    "tccdbg.c": True,
    "tccrun.c": True,
    # tcctools.c is `#include`'d unconditionally by `tcc.c`, so it
    # is exercised through the main TU rather than as a standalone
    # link unit; tracking it separately would duplicate the
    # ar / makedeps symbols at link.
    # "tcctools.c": True,
    "x86_64-gen.c": True,
    "x86_64-link.c": True,
    "i386-asm.c": True,
    "arm64-gen.c": True,
    "arm64-link.c": True,
    "arm64-asm.c": True,
    "tccpe.c": True,
    "tccmacho.c": True,
}


def host_key() -> tuple[str, str]:
    return (platform.system(), platform.machine())


def synthesize_config_h(target_macros: tuple[str, ...]) -> str:
    """Produce the minimal ``config.h`` tinycc expects from ``./configure``.

    Only TCC_VERSION and the target-selection macros are populated.
    Search-path macros (CONFIG_TCC_SYSINCLUDEPATHS etc.) are left
    undefined: the produced tcc binary will need them at runtime,
    not at compile time, and the bringup smoke does not exercise the
    runtime yet.
    """
    lines = [
        "/* Synthesized by demos/tinycc/smoke.py -- do not edit by hand. */",
        '#define TCC_VERSION "0.9.28-badc"',
        "#define CC_NAME CC_clang",
        "#define GCC_MAJOR 0",
        "#define GCC_MINOR 0",
    ]
    for m in target_macros:
        lines.append(f"#define {m} 1")
    # tcc.h sources `ssize_t` from <unistd.h> (skipped under `_WIN32`)
    # or `#define ssize_t intptr_t` (only under `_MSC_VER`). badc's
    # Windows targets define `_WIN32` but not `_MSC_VER`, so neither
    # path fires; provide the type here for the PE targets, mirroring
    # tcc's own MSVC fallback. `long long` is pointer-width on Win64
    # and Windows arm64 (LLP64).
    if "TCC_TARGET_PE" in target_macros:
        lines.append("#define ssize_t long long")
    # CONFIG_TCC_PREDEFS controls whether the predefs header is
    # baked into the binary as a generated string (`tccdefs_.h`,
    # emitted by an upstream support script the demo does not
    # ship) or loaded from `<tccdefs.h>` at runtime via -isystem.
    # The runtime path keeps the demo self-contained.
    lines.append("#define CONFIG_TCC_PREDEFS 0")
    # Disable the threading semaphore. CONFIG_TCC_SEMLOCK=1 pulls in
    # `<dispatch/dispatch.h>` on macOS, `<semaphore.h>` on Linux, and
    # `CRITICAL_SECTION` on Windows -- none of which c5 ships today.
    # tinycc uses the lock to serialize libtcc state across threads;
    # the bringup compile + self-host fixed point is single-threaded
    # so the lock is dead weight here. Re-enabling is the natural
    # follow-up once c5 has a portable mutex surface.
    lines.append("#define CONFIG_TCC_SEMLOCK 0")
    # Disable the built-in stack-backtrace handler. tinycc's signal
    # handler walks the host's ucontext_t mcontext shape, which c5
    # does not have type definitions for; the resulting
    # `uc->uc_mcontext->__ss.__pc` chain would otherwise fail at
    # parse time. The tcc binary still runs without backtraces.
    lines.append("#define CONFIG_TCC_BACKTRACE 0")
    lines.append("")
    return "\n".join(lines)


def resolve_badc() -> Path:
    env = os.environ.get("BADC")
    candidates: list[Path] = []
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


def compile_one(
    badc: Path,
    src: Path,
    out: Path,
    cpp_defs: tuple[str, ...],
    target: str | None,
) -> tuple[bool, str]:
    """Run badc -c against `src`. Returns (ok, captured_stderr_head)."""
    cmd = [str(badc), "-q", "-I", str(TINYCC_DIR)]
    if target is not None:
        cmd.append(f"--target={target}")
    for d in cpp_defs:
        cmd.extend(["-D", d])
    cmd.extend(["-c", str(src), "-o", str(out)])
    # Pin cwd to the repo root so badc's auto-add of `./include`
    # picks up the bundled c5 headers under `./headers/include`
    # instead of tinycc's vendored `demos/tinycc/include/` (which
    # uses gcc-only `__builtin_va_list` and friends).
    proc = subprocess.run(
        cmd, capture_output=True, text=True, check=False, cwd=str(REPO_ROOT)
    )
    if proc.returncode == 0:
        return True, ""
    err = proc.stderr.strip().splitlines()
    return False, err[0] if err else f"exit {proc.returncode}"


# Host triple -> badc `--target=<spec>` value. Used when the
# smoke is asked to cross-probe a non-native lane from a
# developer workstation; CI lanes pass through `None` so the
# host detection picks up automatically.
TARGET_FOR_HOST: dict[tuple[str, str], str] = {
    ("Linux", "x86_64"): "linux-x64",
    ("Linux", "aarch64"): "linux-aarch64",
    ("Darwin", "arm64"): "macos-aarch64",
    ("Windows", "AMD64"): "windows-x64",
    ("Windows", "ARM64"): "windows-arm64",
}


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--host",
        choices=sorted(f"{a}-{b}" for (a, b) in HOST_MATRIX),
        help=(
            "Cross-probe a non-native lane. Passes the matching "
            "--target=<spec> through to badc and selects the named "
            "lane's HOST_MATRIX entry. The link step is still "
            "attempted so the cross-compile object set can be exercised "
            "end-to-end."
        ),
    )
    args = parser.parse_args()

    if args.host:
        key = tuple(args.host.split("-", 1))
        target = TARGET_FOR_HOST[key]
    else:
        key = host_key()
        target = None
    if key not in HOST_MATRIX:
        print(f"smoke: skip -- host {key} not in supported matrix")
        return 2
    host_cfg = HOST_MATRIX[key]

    badc = resolve_badc()

    # Pull the source down if it isn't already on disk. The marker
    # is the top-level header so a partial extract triggers a re-run.
    if not (TINYCC_DIR / "tcc.h").is_file():
        subprocess.run(
            [sys.executable, str(TINYCC_DIR / "setup.py")],
            check=True,
        )

    # Synthesize config.h for this host every run -- the macro set
    # depends on the matrix entry, so a stale config.h from a prior
    # run on a different host would silently miscompile.
    (TINYCC_DIR / "config.h").write_text(synthesize_config_h(host_cfg["target_macros"]))

    work = TINYCC_DIR / ".work"
    work.mkdir(exist_ok=True)

    active = host_cfg["tus"]
    cpp_defs = host_cfg["cpp_defs"]

    regressions: list[str] = []
    still_blocked: list[tuple[str, str]] = []
    newly_green: list[str] = []
    green: list[str] = []

    for name in active:
        expected_green = TU_STATE[name]
        src = TINYCC_DIR / name
        if not src.is_file():
            print(f"smoke: source missing: {name}", file=sys.stderr)
            return 2
        out = work / (name + ".o")
        ok, err = compile_one(badc, src, out, cpp_defs, target)
        if ok:
            green.append(name)
            if not expected_green:
                newly_green.append(name)
        else:
            if expected_green:
                regressions.append(f"{name}: {err}")
            else:
                still_blocked.append((name, err))

    # Report.
    print(f"tinycc smoke -- host={key[0]}/{key[1]}  {len(green)}/{len(active)} TUs compile")
    for name in green:
        print(f"  ok        {name}")
    for name, err in still_blocked:
        print(f"  blocked   {name}: {err}")
    for name in newly_green:
        print(f"  NEW-GREEN {name} -- update TU_STATE[\"{name}\"] = True")
    for line in regressions:
        print(f"  REGRESS   {line}", file=sys.stderr)

    if regressions:
        return 1

    if len(green) == len(active):
        # Every TU compiled -- try the multi-TU link.
        src_files = [str(TINYCC_DIR / name) for name in active]
        link_target_is_win = key[0] == "Windows"
        out_path = work / ("tcc.exe" if link_target_is_win else "tcc")
        cmd = [str(badc), "-q", "-I", str(TINYCC_DIR)]
        if target is not None:
            cmd.append(f"--target={target}")
        for d in cpp_defs:
            cmd.extend(["-D", d])
        cmd.extend(["-o", str(out_path), *src_files])
        # Same cwd reasoning as compile_one: keep badc's `./include`
        # auto-add pointing at c5's bundled headers, not tinycc's.
        proc = subprocess.run(
            cmd, capture_output=True, text=True, check=False, cwd=str(REPO_ROOT)
        )
        if proc.returncode != 0:
            # The driver prints per-source `info: compiling <path>`
            # progress lines on stderr in multi-TU mode. `-q`
            # already silences those plus the `info: wrote file
            # <path>` chatter from successful writes, so anything
            # left on stderr is a real diagnostic.
            err_lines = proc.stderr.strip().splitlines()
            print("  link FAIL:", err_lines[-5:], file=sys.stderr)
            return 1
        print(f"  link OK   -> {out_path}")
        return 0

    # Some TUs are still blocked. Not a regression (they were already
    # expected to be blocked), so return 0 and let CI report the
    # bringup state without gating on it.
    return 0


if __name__ == "__main__":
    sys.exit(main())
