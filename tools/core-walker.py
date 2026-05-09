#!/usr/bin/env python3
"""Walk the saved-rbp chain in a Linux ELF core dump and print each
return address as both a runtime PC and a dump-asm offset.

Usage:
  core-walker.py CORE [--asm DUMP_ASM] [--load-base 0x400000] [--code-start 0x1777]

  CORE          path to the core file (Linux ELF core dump)
  --asm         optional: path to a `--dump-asm` listing. If given, every
                return address is annotated with the matching `[bc=N] OP`
                line from the dump.
  --load-base   ELF load base of the original executable (default 0x400000;
                the c5-emitted x64 binary is non-PIE so this is fixed).
  --code-start  file offset where the c5-emitted code begins (default
                0x1777). The runtime stub before that is libc startup.

Background: c5's optimized -O builds drop the source-line debug map.
After a SIGSEGV at -O the only artifact is the in-memory call stack.
This tool resolves each saved return address to a dump-asm position so
the crashing function (and its callers) can be named.

Credit: the "walk the rbp chain after a crash, subtract the ELF load
base, look up in the dump-asm" approach was suggested by @kromych.
"""
from __future__ import annotations

import argparse
import struct
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Iterator


# ---- ELF reading ----

ELFCLASS64 = 2
ET_CORE = 4
PT_LOAD = 1
PT_NOTE = 4
NT_PRSTATUS = 1


@dataclass
class LoadSegment:
    vaddr: int
    file_off: int
    size: int


@dataclass
class PrStatus:
    """Subset of `struct elf_prstatus` we care about. The fields are
    named after x86_64 (rip / rsp / rbp) but populated from whatever
    the core's ELF machine type is -- on aarch64 the same slots hold
    pc / sp / fp (= x29). The walker treats them as "instruction
    pointer / stack pointer / frame pointer" abstractly."""

    pid: int
    rip: int
    rsp: int
    rbp: int


# ELF e_machine values. The core's machine field identifies the arch
# of the *crashed program*, which dictates the NT_PRSTATUS register
# layout we need to parse.
EM_X86_64 = 62
EM_AARCH64 = 183


def parse_core(path: Path) -> tuple[list[LoadSegment], list[PrStatus], bytes, int]:
    """Read the core file. Returns (load_segments, prstatuses,
    raw_bytes, e_machine). `e_machine` selects the PRSTATUS register
    layout (EM_X86_64 vs EM_AARCH64)."""
    raw = path.read_bytes()

    if raw[:4] != b"\x7fELF":
        raise SystemExit(f"{path}: not an ELF file")
    if raw[4] != ELFCLASS64:
        raise SystemExit(f"{path}: not ELF64")

    e_type, e_machine, _, _, e_phoff = struct.unpack_from("<HHIQQ", raw, 16)
    if e_type != ET_CORE:
        raise SystemExit(f"{path}: not a core dump (e_type={e_type})")

    e_phentsize, e_phnum = struct.unpack_from("<HH", raw, 54)

    loads: list[LoadSegment] = []
    notes: list[bytes] = []
    for i in range(e_phnum):
        off = e_phoff + i * e_phentsize
        p_type, _, p_offset, p_vaddr, _, p_filesz, _, _ = struct.unpack_from(
            "<IIQQQQQQ", raw, off
        )
        if p_type == PT_LOAD and p_filesz > 0:
            loads.append(LoadSegment(p_vaddr, p_offset, p_filesz))
        elif p_type == PT_NOTE:
            notes.append(raw[p_offset : p_offset + p_filesz])

    prstatuses = [_parse_prstatus(n, e_machine) for n in notes]
    prstatuses = [p for p in prstatuses if p is not None]
    return loads, prstatuses, raw, e_machine


def _parse_prstatus(note_segment: bytes, e_machine: int) -> PrStatus | None:
    """Walk one PT_NOTE segment for the first NT_PRSTATUS entry. The
    register slot offsets depend on `e_machine`:

    * x86_64: pr_reg holds `struct user_regs_struct` -- rip at index
      16, rsp at 19, rbp at 4 (counting 8-byte slots from offset 112
      in the desc).
    * aarch64: pr_reg holds 33 u64 registers (x0..x30, sp, pc) plus
      pstate. fp = x29 (index 29), lr = x30 (index 30), sp at 31,
      pc at 32. We treat fp as "rbp" and pc as "rip" for the
      walker's purposes.
    """
    pos = 0
    while pos + 12 <= len(note_segment):
        n_namesz, n_descsz, n_type = struct.unpack_from("<III", note_segment, pos)
        pos += 12
        # Names are 4-byte aligned, then desc is 4-byte aligned.
        name_pad = (n_namesz + 3) & ~3
        desc_off = pos + name_pad
        desc_pad = (n_descsz + 3) & ~3
        next_pos = desc_off + desc_pad
        if n_type == NT_PRSTATUS:
            pr_reg_off = desc_off + 112
            pid_off = desc_off + 32
            (pid,) = struct.unpack_from("<I", note_segment, pid_off)
            if e_machine == EM_X86_64:
                regs = struct.unpack_from("<27Q", note_segment, pr_reg_off)
                rbp = regs[4]
                rip = regs[16]
                rsp = regs[19]
            elif e_machine == EM_AARCH64:
                regs = struct.unpack_from("<34Q", note_segment, pr_reg_off)
                rbp = regs[29]  # fp = x29
                rsp = regs[31]
                rip = regs[32]
            else:
                raise SystemExit(f"unsupported e_machine {e_machine}")
            return PrStatus(pid=pid, rip=rip, rsp=rsp, rbp=rbp)
        pos = next_pos
    return None


def read_at(loads: list[LoadSegment], raw: bytes, vaddr: int, n: int) -> bytes | None:
    """Read `n` bytes from process virtual address `vaddr` out of the core."""
    for seg in loads:
        if seg.vaddr <= vaddr < seg.vaddr + seg.size and vaddr + n <= seg.vaddr + seg.size:
            off = seg.file_off + (vaddr - seg.vaddr)
            return raw[off : off + n]
    return None


# ---- dump-asm matching ----

@dataclass
class AsmLine:
    dump_off: int
    bc_pc: int | None
    op: str | None


def parse_dump_asm(path: Path) -> list[AsmLine]:
    """Return a list of (dump_off, bc_pc, op) for every native-code line.

    `bc_pc` and `op` are filled in from the most recent `[bc=N] OPNAME ...`
    header above each native-byte block; consecutive bytes lines for the
    same block share the same bc/op.
    """
    out: list[AsmLine] = []
    last_bc: int | None = None
    last_op: str | None = None
    for line in path.read_text(errors="replace").splitlines():
        s = line.strip()
        if s.startswith("[bc="):
            # `[bc=  290206] Lea 2`
            bracket_end = s.index("]")
            try:
                last_bc = int(s[4:bracket_end].strip())
            except ValueError:
                last_bc = None
            last_op = s[bracket_end + 1 :].strip()
        elif s.startswith("0x"):
            # `0x117314: 49 bd 00 00 00 00 00 00 00 00`
            colon = s.find(":")
            if colon < 0:
                continue
            try:
                dump_off = int(s[:colon], 16)
            except ValueError:
                continue
            out.append(AsmLine(dump_off, last_bc, last_op))
    out.sort(key=lambda a: a.dump_off)
    return out


def find_asm_for(asm: list[AsmLine], dump_off: int) -> AsmLine | None:
    """Largest dump_off <= the given offset. Native instruction may
    span multiple bytes; the line that *starts* the instruction is the
    largest dump_off not exceeding the query."""
    lo, hi = 0, len(asm)
    while lo < hi:
        mid = (lo + hi) // 2
        if asm[mid].dump_off <= dump_off:
            lo = mid + 1
        else:
            hi = mid
    return asm[lo - 1] if lo > 0 else None


# ---- frame-pointer walk ----

def walk(
    loads: list[LoadSegment],
    raw: bytes,
    rbp: int,
    rip: int,
    *,
    max_depth: int = 64,
) -> Iterator[tuple[int, int]]:
    """Yield (rbp, return_address) for every frame.

    Frame 0 is the leaf (the actual crash site, return address is `rip`).
    Each subsequent frame reads the saved-rbp chain at `[rbp]` (= prev
    rbp) and `[rbp + 8]` (= return address into caller).
    """
    yield rbp, rip
    for _ in range(max_depth):
        if rbp == 0:
            return
        slot = read_at(loads, raw, rbp, 16)
        if slot is None:
            return
        prev_rbp, ret = struct.unpack("<QQ", slot)
        if ret == 0:
            return
        yield prev_rbp, ret
        if prev_rbp == 0 or prev_rbp == rbp:
            return
        rbp = prev_rbp


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n", 1)[0])
    ap.add_argument("core", type=Path)
    ap.add_argument("--asm", type=Path, help="dump-asm listing for symbol resolution")
    ap.add_argument(
        "--load-base",
        type=lambda x: int(x, 0),
        default=0x400000,
        help="ELF load base (default 0x400000)",
    )
    ap.add_argument(
        "--code-start",
        type=lambda x: int(x, 0),
        default=0x1777,
        help="file offset where c5-emitted code begins (default 0x1777)",
    )
    ap.add_argument(
        "--code-end",
        type=lambda x: int(x, 0),
        default=0x3c6e0c,
        help="file offset where the code segment ends. Values past this are data, not code, so the dump-asm lookup returns spurious last-line matches if we don't gate on it. Default matches the sqlite3 build's R+E LOAD range; check `readelf -l <bin>` for your binary.",
    )
    ap.add_argument("--max-depth", type=int, default=64)
    ap.add_argument(
        "--dump-around-rbp",
        action="store_true",
        help="dump 16 8-byte slots around rbp (-32..+96) and stop. Useful when you want to inspect the saved-rbp / saved-ret pair manually.",
    )
    ap.add_argument(
        "--list-segments",
        action="store_true",
        help="list every PT_LOAD segment in the core file with its vaddr range and exit. Useful for understanding where the stack and heap landed after a corruption.",
    )
    ap.add_argument(
        "--dump-at",
        type=lambda x: int(x, 0),
        help="dump 16 8-byte slots starting at the given vaddr and exit. Useful for inspecting a specific frame's saved-rbp/saved-ret pair when the walker bailed out.",
    )
    ap.add_argument(
        "--scan-stack",
        action="store_true",
        help="instead of walking the rbp chain, scan from rsp upward and print every 8-byte slot that looks like a code address. Use when the rbp chain dies early.",
    )
    ap.add_argument(
        "--scan-from",
        type=lambda x: int(x, 0),
        help="override the scan start address (defaults to rsp). Useful when rsp is in the emulator's alt-stack and the actual program stack is elsewhere -- e.g. point this at rbp to scan the real stack.",
    )
    ap.add_argument(
        "--scan-bytes",
        type=lambda x: int(x, 0),
        default=0x10000,
        help="how many bytes to scan above rsp (default 64KiB)",
    )
    ap.add_argument(
        "--scan-max",
        type=int,
        default=128,
        help="cap on the number of code addresses to print (default 128)",
    )
    args = ap.parse_args()

    loads, prstatuses, raw, e_machine = parse_core(args.core)
    if not prstatuses:
        print("no NT_PRSTATUS in core; can't read rip/rsp/rbp", file=sys.stderr)
        return 2
    pr = prstatuses[0]
    arch = {EM_X86_64: "x86_64", EM_AARCH64: "aarch64"}.get(e_machine, f"machine={e_machine}")
    print(f"# core: arch={arch} pid={pr.pid} ip={pr.rip:#x} sp={pr.rsp:#x} fp={pr.rbp:#x}")
    print(f"# load_base={args.load_base:#x} code_start={args.code_start:#x} code_end={args.code_end:#x}")

    asm: list[AsmLine] | None = None
    if args.asm and args.asm.exists():
        asm = parse_dump_asm(args.asm)
        print(f"# parsed {len(asm)} asm lines from {args.asm}")

    if args.dump_at is not None:
        print()
        print(f"# memory at {args.dump_at:#x}")
        for d in range(0, 128, 8):
            addr = args.dump_at + d
            slot = read_at(loads, raw, addr, 8)
            if slot is None:
                print(f"  {addr:>16x}: <unmapped>")
                continue
            (val,) = struct.unpack("<Q", slot)
            tag = ""
            file_off = val - args.load_base
            if args.code_start <= file_off < args.code_end:
                dump_off = file_off - args.code_start
                if asm is not None and dump_off >= 0:
                    entry = find_asm_for(asm, dump_off)
                    if entry is not None:
                        tag = f"  -> bc={entry.bc_pc} {entry.op}"
            print(f"  {addr:>16x}: {val:#018x}{tag}")
        return 0

    if args.list_segments:
        print()
        print(f"# core segments")
        for seg in loads:
            print(
                f"  vaddr={seg.vaddr:#018x}  size={seg.size:#10x}  end={seg.vaddr + seg.size:#018x}"
            )
        return 0

    if args.dump_around_rbp:
        # Dump the 64 bytes around rbp to inspect saved-rbp + ret_addr
        # by hand. Useful when the rbp chain dies after one or two frames.
        print()
        print(f"# memory around rbp={pr.rbp:#x}")
        for d in range(-32, 96, 8):
            addr = pr.rbp + d
            slot = read_at(loads, raw, addr, 8)
            if slot is None:
                print(f"  {addr:>16x}: <unmapped>")
                continue
            (val,) = struct.unpack("<Q", slot)
            tag = ""
            file_off = val - args.load_base
            if args.code_start <= file_off < args.code_end:
                dump_off = file_off - args.code_start
                if asm is not None and dump_off >= 0:
                    entry = find_asm_for(asm, dump_off)
                    if entry is not None:
                        tag = f"  -> bc={entry.bc_pc} {entry.op}"
                else:
                    tag = f"  -> file={file_off:#x}"
            print(f"  {addr:>16x}: {val:#018x}{tag}")
        return 0

    if args.scan_stack:
        # Backup mode: ignore the rbp chain entirely and walk every
        # 8-byte slot, reporting any value that looks like a code
        # address. Useful when the rbp chain is broken (the crashing
        # function smashed its saved frame pointer, or the codegen
        # never set rbp). Bounds the scan so we don't walk an entire
        # 8MB stack.
        scan_from = args.scan_from if args.scan_from is not None else pr.rsp
        print()
        print(f"# scanning {args.scan_bytes} bytes from {scan_from:#x} for code addresses")
        scanned = 0
        printed = 0
        addr = scan_from
        while scanned < args.scan_bytes and printed < args.scan_max:
            slot = read_at(loads, raw, addr, 8)
            if slot is None:
                break
            (val,) = struct.unpack("<Q", slot)
            file_off = val - args.load_base
            if args.code_start <= file_off < args.code_end:
                dump_off = file_off - args.code_start
                line = ""
                if asm is not None and dump_off >= 0:
                    entry = find_asm_for(asm, dump_off)
                    if entry is not None:
                        line = f"  bc={entry.bc_pc} {entry.op}"
                print(f"  {addr:>16x}  -> {val:#16x}  file={file_off:#10x}  dump={dump_off:#10x}{line}")
                printed += 1
            addr += 8
            scanned += 8
        print(f"# scan: {scanned} bytes, {printed} candidates")
        return 0

    print()
    print(f"{'#':>3}  {'rbp':>16}  {'ret_addr':>16}  {'file_off':>10}  {'dump_off':>10}  resolved")
    for i, (rbp, ret) in enumerate(walk(loads, raw, pr.rbp, pr.rip, max_depth=args.max_depth)):
        file_off = ret - args.load_base
        if file_off < 0:
            line = f"  (return address {ret:#x} below load base; libc / vDSO?)"
            dump_off = None
        else:
            dump_off = file_off - args.code_start
            line = ""
        if asm is not None and dump_off is not None and dump_off >= 0:
            entry = find_asm_for(asm, dump_off)
            if entry is not None:
                line = f"  bc={entry.bc_pc} {entry.op}"
        d_str = f"{dump_off:#10x}" if dump_off is not None and dump_off >= 0 else "        --"
        print(f"{i:>3}  {rbp:>16x}  {ret:>16x}  {file_off:>#10x}  {d_str}{line}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
