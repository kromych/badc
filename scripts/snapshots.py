#!/usr/bin/env python3
"""Regenerate the per-fixture SSA + asm snapshots under tests/snapshots/.

For every `.c` file under `tests/fixtures/c/`, this writes three files:

  tests/snapshots/ssa/<name>.ssa            -- target-independent SSA dump
  tests/snapshots/asm/<name>.x64.asm        -- linux-x64 disassembly
  tests/snapshots/asm/<name>.aarch64.asm    -- linux-aarch64 disassembly

The asm is normalised through `objdump --disassemble --no-show-raw-insn
--no-addresses` so per-emit byte-offset shifts don't churn the snapshot
for cosmetic reasons. Cross-arch ELFs are produced via `badc
--target=linux-{x64,aarch64}` and disassembled with the host objdump
(llvm-objdump on macOS, GNU objdump on Linux, both handle either ELF
class).

Fixtures that fail to compile (missing headers in the stripped fixture
form, etc.) are logged but don't fail the run.
"""

from __future__ import annotations

import argparse
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path


def repo_root() -> Path:
    out = subprocess.run(
        ["git", "rev-parse", "--show-toplevel"],
        check=True,
        capture_output=True,
        text=True,
    )
    return Path(out.stdout.strip())


def ensure_badc(root: Path) -> Path:
    badc = root / "target" / "release" / "badc"
    if not badc.is_file():
        print("[snapshots] building badc release...", flush=True)
        subprocess.run(
            ["cargo", "build", "--release", "--quiet"],
            cwd=root,
            check=True,
        )
    return badc


TARGETS = [("x64", "linux-x64"), ("aarch64", "linux-aarch64")]
OBJDUMP_FLAGS = ["--disassemble", "--no-show-raw-insn", "--no-addresses"]

# badc appends a `BADC\n\tv<version>...` marker to the tail of every
# emitted `.text` section. The bytes after the marker bake in the
# current git commit, so disassembling them would churn the snapshot
# on every push. Truncate the objdump output at the marker.
BUILD_INFO_MARKER = b"BADC\n\tv"

# objdump's disassembly bakes in several forms of absolute addresses
# that shift on any earlier-code reflow even when the local emit is
# unchanged. Each regex below rewrites one form to a stable token so a
# diff line surfaces only when the actual mnemonic / operand mix
# changes.
ASM_NORMALISATION_RULES: tuple[tuple[re.Pattern[str], str], ...] = (
    # `callq 0x4002dc <.text+0xbc>` and similar: branch / call operand
    # followed by an `<symbol+offset>` annotation. Both halves shift in
    # lock-step on any earlier reflow.
    (re.compile(r"0x[0-9a-fA-F]+\s+<[^>]+>"), "<addr>"),
    # `callq *0xfe89(%rip)           # 0x4100c0`: trailing absolute
    # annotation appended after a RIP-relative computation. objdump
    # tab-aligns the `#` past column 40, so 4-plus whitespace before
    # `#` distinguishes the x86_64 comment form from aarch64's
    # `, #0x8` immediate syntax.
    (re.compile(r"\s{4,}#\s*0x[0-9a-fA-F]+\s*$", re.MULTILINE), ""),
    # `0xfe89(%rip)`: x86_64 RIP-relative addressing. The offset is
    # measured from the next instruction's address and shifts whenever
    # any earlier code or .rodata moves.
    (re.compile(r"0x[0-9a-fA-F]+\(%rip\)"), "<rip>"),
    # aarch64 ADRP / load-symbol pairs: `adrp x16, 0x410000` then
    # `ldr x16, [x16, #0xc0]`. The page address + offset together name
    # a fixed symbol; treat the pair as a single placeholder.
    (re.compile(r"adrp(\s+\w+,)\s+0x[0-9a-fA-F]+"), r"adrp\1 <page>"),
)


def normalise_asm(text: str) -> str:
    for pattern, replacement in ASM_NORMALISATION_RULES:
        text = pattern.sub(replacement, text)
    return text


def emit_ssa(badc: Path, src: Path, dst: Path, tmp_bin: Path) -> bool:
    with dst.open("wb") as ssa_out:
        proc = subprocess.run(
            [str(badc), "-q", "-O", "--dump-ssa", "-o", str(tmp_bin), str(src)],
            stdout=subprocess.DEVNULL,
            stderr=ssa_out,
        )
    return proc.returncode == 0


def build_info_stop_address(binary: Path) -> int | None:
    """Return the .text virtual address at which the BUILD_INFO marker
    begins, or None if either ELF parsing fails or the marker is
    absent. The caller passes the result as `--stop-address` to
    objdump so the trailing BUILD_INFO bytes (which embed the current
    git commit and would churn the snapshot every push) don't reach
    the disassembled output.
    """
    import struct

    data = binary.read_bytes()
    if data[:4] != b"\x7fELF":
        return None
    is_64 = data[4] == 2
    is_le = data[5] == 1
    if not is_64 or not is_le:
        return None
    e_shoff = struct.unpack_from("<Q", data, 0x28)[0]
    e_shentsize = struct.unpack_from("<H", data, 0x3a)[0]
    e_shnum = struct.unpack_from("<H", data, 0x3c)[0]
    e_shstrndx = struct.unpack_from("<H", data, 0x3e)[0]
    shstr_off = struct.unpack_from(
        "<Q", data, e_shoff + e_shstrndx * e_shentsize + 0x18
    )[0]
    for i in range(e_shnum):
        base = e_shoff + i * e_shentsize
        sh_name = struct.unpack_from("<I", data, base)[0]
        end = data.index(b"\x00", shstr_off + sh_name)
        name = data[shstr_off + sh_name : end].decode("ascii", errors="replace")
        if name != ".text":
            continue
        sh_addr = struct.unpack_from("<Q", data, base + 0x10)[0]
        sh_offset = struct.unpack_from("<Q", data, base + 0x18)[0]
        sh_size = struct.unpack_from("<Q", data, base + 0x20)[0]
        section = data[sh_offset : sh_offset + sh_size]
        idx = section.find(BUILD_INFO_MARKER)
        if idx < 0:
            return None
        return sh_addr + idx
    return None


def emit_asm(badc: Path, src: Path, dst: Path, tmp_bin: Path, target: str) -> bool:
    proc = subprocess.run(
        [str(badc), "-q", "-O", f"--target={target}", "-o", str(tmp_bin), str(src)],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )
    if proc.returncode != 0:
        return False
    stop = build_info_stop_address(tmp_bin)
    extra: list[str] = []
    if stop is not None:
        extra.append(f"--stop-address=0x{stop:x}")
    # llvm-objdump's output text differs from GNU objdump's enough that
    # snapshots taken with one cannot match the other (mnemonic spelling,
    # operand syntax, header line shape). Prefer llvm-objdump everywhere
    # so the snapshot tree is determined by `badc`'s output rather than
    # the host's binutils choice. Fall back to plain `objdump` for hosts
    # that ship only the GNU form.
    tool = "llvm-objdump" if shutil.which("llvm-objdump") else "objdump"
    proc = subprocess.run(
        [tool, *OBJDUMP_FLAGS, *extra, str(tmp_bin)],
        capture_output=True,
        check=False,
    )
    # objdump's header line bakes in the binary path, which churns the
    # snapshot every run because the temp dir name varies. Replace the
    # path with the snapshot's stable name.
    text = proc.stdout.decode("utf-8", errors="replace")
    text = text.replace(str(tmp_bin), dst.stem)
    text = normalise_asm(text)
    dst.write_text(text)
    return True


def regenerate(root: Path, only: list[str] | None) -> int:
    badc = ensure_badc(root)
    fixtures_dir = root / "tests" / "fixtures" / "c"
    snap_root = root / "tests" / "snapshots"
    (snap_root / "ssa").mkdir(parents=True, exist_ok=True)
    (snap_root / "asm").mkdir(parents=True, exist_ok=True)

    sources = sorted(fixtures_dir.glob("*.c"))
    if only:
        wanted = {n if n.endswith(".c") else n + ".c" for n in only}
        sources = [s for s in sources if s.name in wanted]

    written = 0
    skipped: list[str] = []
    with tempfile.TemporaryDirectory() as td:
        tmp = Path(td) / "bin"
        for src in sources:
            name = src.stem
            ssa_path = snap_root / "ssa" / f"{name}.ssa"
            ok = emit_ssa(badc, src, ssa_path, tmp)
            if not ok:
                ssa_path.unlink(missing_ok=True)
                for suffix, _ in TARGETS:
                    (snap_root / "asm" / f"{name}.{suffix}.asm").unlink(missing_ok=True)
                skipped.append(name)
                continue
            for suffix, target in TARGETS:
                asm_path = snap_root / "asm" / f"{name}.{suffix}.asm"
                if not emit_asm(badc, src, asm_path, tmp, target):
                    asm_path.unlink(missing_ok=True)
            written += 1

    print(f"[snapshots] wrote {written} fixtures, skipped {len(skipped)}")
    if skipped:
        for s in skipped:
            print(f"[snapshots] skip {s}")
    return 0


def main(argv: list[str]) -> int:
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument(
        "--only",
        nargs="*",
        help="restrict to the given fixture names (with or without .c)",
    )
    args = p.parse_args(argv)
    return regenerate(repo_root(), args.only)


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
