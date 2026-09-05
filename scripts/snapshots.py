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

A fixture may pin extra badc flags for its snapshots with a leading
`// snapshot-flags: ...` comment (e.g. `-c -mcmodel=kernel` for a form
only a relocatable object shows). The flags apply to the SSA and every
asm emission; a target that rejects them drops that snapshot. With `-c`
the object is disassembled with relocations shown (`-r`), which is where
the addressing form of an unresolved reference is visible.

Fixtures that fail to compile (missing headers in the stripped fixture
form, etc.) are logged but don't fail the run.

`--check` follows the regeneration with a git comparison against the
commit, failing on added, removed and modified snapshots alike.

`--frame-sizes` reports the static stack bytes the corpus reserves, and
with `--against REV` diffs that against the snapshots committed at REV.

`--budget` reports the corpus access ratios and fails when the
callee-saved entry/exit traffic per function is over its ceiling; a
`--check` run ends with the same test.
"""

from __future__ import annotations

import argparse
import os
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path


def repo_root() -> Path:
    out = subprocess.run(
        ["git", "rev-parse", "--show-toplevel"],
        capture_output=True,
        text=True,
    )
    if out.returncode == 0:
        return Path(out.stdout.strip())
    # An rsync/tar export of the tree carries no .git; the script's own
    # location fixes the root.
    return Path(__file__).resolve().parents[1]


def ensure_badc(root: Path, given: Path | None) -> Path:
    # A binary the caller names is taken as is: CI builds one per runner
    # from the same commit and shares it. Otherwise always rebuild: a
    # stale binary compiles a fixture it does not understand as a skip,
    # and a skip unlinks that fixture's snapshots, so the run reports no
    # drift while removing content. The CLI needs `full`; without it the
    # build leaves whatever binary was there.
    if given is not None:
        if not given.is_file():
            raise SystemExit(f"[snapshots] --badc {given}: not a file")
        return given.resolve()
    badc = root / "target" / "release" / "badc"
    print("[snapshots] building badc release...", flush=True)
    subprocess.run(
        ["cargo", "build", "--release", "--quiet", "--features", "full"],
        cwd=root,
        check=True,
    )
    return badc


TARGETS = [("x64", "linux-x64"), ("aarch64", "linux-aarch64")]
OBJDUMP_FLAGS = ["--disassemble", "--no-show-raw-insn", "--no-addresses"]


# objdump's disassembly bakes in several forms of absolute addresses
# that shift on any earlier-code reflow even when the local emit is
# unchanged. Each regex below rewrites one form to a stable token so a
# diff line surfaces only when the actual mnemonic / operand mix
# changes.
ASM_NORMALISATION_RULES: tuple[tuple[re.Pattern[str], str], ...] = (
    # `callq 0x4002dc <.text+0xbc>` and similar: branch / call operand
    # followed by an `<symbol+offset>` annotation. Both halves shift in
    # lock-step on any earlier reflow. Both halves sit on one line: the
    # separator must not cross a newline, or an immediate at the end of
    # one instruction plus the `<symbol>:` label opening the next
    # function match as a pair and the label is dropped.
    (re.compile(r"0x[0-9a-fA-F]+[ \t]+<[^>\n]+>"), "<addr>"),
    # `callq *0xfe89(%rip)           # 0x4100c0`: trailing absolute
    # annotation appended after a RIP-relative computation. objdump
    # writes a space after the `#` of a comment and none after the `#`
    # of an aarch64 immediate, which separates the two forms whatever
    # column the operands leave the comment in.
    (re.compile(r"\s+#\s+0x[0-9a-fA-F]+\s*$", re.MULTILINE), ""),
    # `0xfe89(%rip)`: x86_64 RIP-relative addressing. The offset is
    # measured from the next instruction's address and shifts whenever
    # any earlier code or .rodata moves.
    (re.compile(r"0x[0-9a-fA-F]+\(%rip\)"), "<rip>"),
    # aarch64 ADRP / load-symbol pairs: `adrp x16, 0x410000` then
    # `ldr x16, [x16, #0xc0]`. The page address + offset together name
    # a fixed symbol; treat the pair as a single placeholder.
    (re.compile(r"adrp(\s+\w+,)\s+0x[0-9a-fA-F]+"), r"adrp\1 <page>"),
    # aarch64 ADRP / ADD address materialization: `adrp x0, <page>`
    # then `add x0, x0, #0x958`. The `add` immediate is the low 12
    # bits of the same materialized address the (already-normalized)
    # ADRP names, so it is layout-dependent in lock-step with the
    # page. An `add` that reuses the ADRP's destination register on
    # the next line is always this pattern, never arithmetic, so the
    # immediate carries no codegen signal and is normalized to keep
    # the snapshot stable against any earlier reflow.
    #
    # The ADRP operand reads `<addr>` rather than `<page>` when the
    # disassembler resolved the page to a symbol, since the `<addr>`
    # rule above consumes the address and its `<symbol>` comment
    # together. Both spellings introduce the same pair.
    (
        re.compile(
            r"(adrp\s+(\w+),\s+<(?:page|addr)>\n\s*add\s+\2,\s+\2,\s+)"
            r"#0x[0-9a-fA-F]+"
        ),
        r"\1<lo12>",
    ),
    # aarch64 ADRP / LDR slot load: `adrp x0, <page>` then
    # `ldr x0, [x0, #0xd0]`. Same argument as the `add` form -- the
    # offset is the low 12 bits of the address the ADRP names, so it
    # shifts with any earlier reflow and carries no codegen signal.
    (
        re.compile(
            r"(adrp\s+(\w+),\s+<(?:page|addr)>\n\s*ldr\s+\2,\s+\[\2,\s+)"
            r"#0x[0-9a-fA-F]+(\])"
        ),
        r"\1<lo12>\3",
    ),
    # The x86_64 runtime entry stub passes the image-base-relative offset
    # of `__c5_entry` to the startup helper through `movl $off, %esi`,
    # right after `movq %rsp, %rdi`. That offset is a whole-image layout
    # value: it shifts whenever anything ahead of .text changes size,
    # including the host-dependent `.gnu.version_r` (a macOS cross-build
    # omits the glibc Verneed a native Linux build reads from the host
    # libc and emits). Anchored on the stub's `rdi`/`esi` pair so it never
    # matches an ordinary `%esi` load, it carries no codegen signal.
    (
        re.compile(r"(movq\s+%rsp,\s+%rdi\n\s+movl\s+)\$0x[0-9a-fA-F]+(,\s+%esi).*"),
        r"\1$<entry_off>\2",
    ),
    # The aarch64 stub passes the same offset in `x1`, right after `mov
    # x0, sp`, as a `mov`/`movk` pair. Same layout value, same absence of
    # codegen signal. `mov x0, sp` alone also starts ordinary sequences
    # that load `x1` with a real constant, so the trailing `movk` is part
    # of the anchor.
    (
        re.compile(
            r"(mov\s+x0,\s+sp\n\s+mov\s+x1,\s+)#0x[0-9a-fA-F]+.*"
            r"(\n\s+movk\s+x1,\s+#0x0,\s+lsl\s+#16)"
        ),
        r"\1<entry_off>\2",
    ),
)


def normalise_asm(text: str) -> str:
    for pattern, replacement in ASM_NORMALISATION_RULES:
        text = pattern.sub(replacement, text)
    return text


SNAPSHOT_FLAGS_RE = re.compile(r"^//\s*snapshot-flags:\s*(.+?)\s*$", re.MULTILINE)


def fixture_flags(src: Path) -> list[str]:
    m = SNAPSHOT_FLAGS_RE.search(src.read_text(errors="replace"))
    return m.group(1).split() if m else []


def emit_ssa(badc: Path, src: Path, dst: Path, tmp_bin: Path, root: Path) -> bool:
    # Pin the cross-target so the SSA dump's register allocation is
    # host-independent (the docstring at the top of this file calls
    # the dump target-independent; without --target the host's
    # default arch leaks into the snapshot register names, which
    # then diff between macOS aarch64 hosts and Linux x86_64 CI).
    # Pass the source path relative to the repo root (with cwd=root)
    # so `__FILE__` in an `assert` embeds a checkout-independent path
    # into `.data`; an absolute path bakes the checkout prefix into
    # the segment and drifts the snapshot across differently-named
    # trees.
    rel = src.relative_to(root)
    proc = subprocess.run(
        [
            str(badc),
            "-q",
            "-O",
            "--target=linux-x64",
            "--dump-ssa",
            *fixture_flags(src),
            "-o",
            str(tmp_bin),
            str(rel),
        ],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.PIPE,
        cwd=root,
    )
    # `--target=<arch>` emits a cross-host advisory on stderr only
    # when the target arch differs from the host arch. The line is
    # host-conditional and would split snapshots by host; drop it.
    # Diagnostic lines also embed the absolute fixture path
    # (`/Volumes/src/...` on macOS, `/home/runner/work/...` on
    # CI). Rewrite any reference to the fixture itself down to
    # the bare filename so the snapshot is stable.
    text = proc.stderr.decode("utf-8", errors="replace")
    text = "\n".join(
        line for line in text.splitlines()
        if not line.startswith("info: produced a Linux/")
    )
    text = text.replace(str(src.relative_to(root)), src.name).replace(str(src), src.name)
    if text and not text.endswith("\n"):
        text += "\n"
    dst.write_text(text)
    return proc.returncode == 0


def fixture_text_stop_address(map_path: Path, source: str) -> int | None:
    """Return the virtual address one past the last `.text` contribution
    the badc link map attributes to `source`, the path the fixture was
    compiled from. The caller's `--stop-address` keeps the snapshot to the
    fixture's own code: the trailing fill and the identical runtime tail
    every image shares would otherwise churn the whole tree on any runtime
    edit.

    The fixture's rows are selected by name rather than the other inputs
    excluded by theirs. An input's label is its path when it has one, so
    the runtime carries `<runtime/...>` only while it comes from the
    embedded copy; an installed `$BADC_HOME/lib/runtime.c` labels the same
    rows with an absolute path, which no exclusion rule can anticipate.
    None when the map is missing or names no contribution from `source`.
    """
    try:
        text = map_path.read_text()
    except OSError:
        return None
    in_text = False
    last_end = None
    for line in text.splitlines():
        if re.match(r"\.text\s+0x", line):
            in_text = True
            continue
        if not in_text:
            continue
        if not line.strip() or not line.startswith(" "):
            break
        # A contribution is `[name] 0xaddr 0xsize input`, with the name
        # wrapped onto its own line when long; symbol and `*fill*` rows
        # carry no input token and don't match.
        m = re.match(r"\s+(?:\S+\s+)?0x([0-9a-fA-F]+)\s+0x([0-9a-fA-F]+)\s+(\S+)\s*$", line)
        if not m or m.group(3) != source:
            continue
        end = int(m.group(1), 16) + int(m.group(2), 16)
        last_end = end if last_end is None else max(last_end, end)
    return last_end


def emit_asm(badc: Path, src: Path, dst: Path, tmp_bin: Path, target: str, root: Path) -> bool:
    # Relative source path + cwd=root: keep `__FILE__` checkout-independent
    # (see emit_ssa).
    flags = fixture_flags(src)
    # `-Map` records where the embedded runtime's .text begins; `-c`
    # produces no link and takes no map (an object carries no runtime).
    map_path = tmp_bin.with_suffix(".map")
    map_flags = [] if "-c" in flags else [f"-Map={map_path}"]
    rel = str(src.relative_to(root))
    proc = subprocess.run(
        [str(badc), "-q", "-O", f"--target={target}", *flags, *map_flags,
         "-o", str(tmp_bin), rel],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
        cwd=root,
    )
    if proc.returncode != 0:
        return False
    stop = None if "-c" in flags else fixture_text_stop_address(map_path, rel)
    extra: list[str] = []
    if stop is not None:
        extra.append(f"--stop-address=0x{stop:x}")
    if "-c" in flags:
        extra.append("-r")
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


def regenerate(root: Path, only: list[str] | None, given: Path | None) -> int:
    badc = ensure_badc(root, given)
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
    regressed: list[str] = []
    with tempfile.TemporaryDirectory() as td:
        tmp = Path(td) / "bin"
        for src in sources:
            name = src.stem
            ssa_path = snap_root / "ssa" / f"{name}.ssa"
            asm_paths = [snap_root / "asm" / f"{name}.{suffix}.asm" for suffix, _ in TARGETS]
            had_snapshots = ssa_path.exists() or any(p.exists() for p in asm_paths)
            ok = emit_ssa(badc, src, ssa_path, tmp, root)
            if not ok:
                # A fixture that never had snapshots cannot build here --
                # a negative test, or asm for another architecture. One
                # that HAD them and now fails is a regression, and
                # unlinking would report it as no drift at all.
                if had_snapshots:
                    regressed.append(name)
                    continue
                ssa_path.unlink(missing_ok=True)
                for p in asm_paths:
                    p.unlink(missing_ok=True)
                skipped.append(name)
                continue
            for suffix, target in TARGETS:
                asm_path = snap_root / "asm" / f"{name}.{suffix}.asm"
                if not emit_asm(badc, src, asm_path, tmp, target, root):
                    asm_path.unlink(missing_ok=True)
            written += 1

    print(f"[snapshots] wrote {written} fixtures, skipped {len(skipped)}")
    if skipped:
        for s in skipped:
            print(f"[snapshots] skip {s}")
    if regressed:
        for r in regressed:
            print(f"[snapshots] ERROR {r}: had snapshots and no longer compiles")
        raise SystemExit(1)
    return 0


CHECK_DIFF_LINES = 200


def check_clean(root: Path) -> int:
    """Fail when the regeneration left `tests/snapshots/` differing from
    the commit.

    `git diff` reports tracked files only, so a fixture added without its
    snapshots -- whose regeneration writes untracked files -- reads as
    clean. `git status --porcelain` reports both, and the three cases get
    separate messages because they take different actions. Fixtures that
    produce no code take no snapshots and are skipped by design, so the
    rule is on the generator's output rather than on a fixture count.
    """
    out = subprocess.run(
        ["git", "status", "--porcelain", "-uall", "--", "tests/snapshots"],
        cwd=root,
        capture_output=True,
        text=True,
        check=True,
    ).stdout
    added: list[str] = []
    removed: list[str] = []
    modified: list[str] = []
    for line in out.splitlines():
        status, path = line[:2], line[3:]
        if status == "??":
            added.append(path)
        elif "D" in status:
            removed.append(path)
        else:
            modified.append(path)
    for label, paths in (
        ("produced but not committed (a fixture was added without its "
         "snapshots; commit them)", added),
        ("committed but no longer produced (the fixture is gone or no "
         "longer compiles; remove them)", removed),
        ("differ from the committed copy (compiler output changed)", modified),
    ):
        if not paths:
            continue
        print(f"[snapshots] {len(paths)} snapshot(s) {label}:")
        for p in paths[:40]:
            print(f"  {p}")
    if modified:
        diff = subprocess.run(
            ["git", "--no-pager", "diff", "--", "tests/snapshots"],
            cwd=root,
            capture_output=True,
            text=True,
        ).stdout.splitlines()
        for line in diff[:CHECK_DIFF_LINES]:
            print(line)
    if added or removed or modified:
        return 1
    print("[snapshots] tests/snapshots/ is clean")
    return 0


# The static SP decrements a function emits: the explicit subtraction of
# a prologue or a call-site adjustment, and the stores that reserve as
# they save -- the aarch64 pre-indexed `[sp, #-N]!` writeback, the
# x86-64 push. The aarch64 immediate is 12 bits with an optional
# `lsl #12`, so a reservation over 4095 bytes is a shifted instruction
# plus a remainder and a reader that drops the shift undercounts it
# 4096-fold. A variable adjustment (alloca, over-alignment) has no
# static size and matches no form; a release (`add sp`, the
# post-indexed `[sp], #N` load, pop) returns bytes and is not read.
FRAME_DECREMENTS: dict[str, re.Pattern[str]] = {
    "aarch64": re.compile(
        r"\bsub\s+sp,\s*sp,\s*#(?P<imm>0x[0-9a-fA-F]+|\d+)"
        r"(?:\s*,\s*lsl\s*#(?P<shift>\d+))?"
        r"|\[sp,\s*#-(?P<pre>0x[0-9a-fA-F]+|\d+)\]!"
    ),
    "x64": re.compile(
        r"\bsubq?\s+\$(?P<imm>0x[0-9a-fA-F]+|\d+),\s*%rsp\b|\b(?P<push>pushq?)\s"
    ),
}

PUSH_BYTES = 8


def snapshot_arch(name: str) -> str:
    for suffix, _ in TARGETS:
        if name.endswith(f".{suffix}.asm"):
            return suffix
    raise ValueError(f"not an asm snapshot name: {name}")


def frame_bytes(text: str, arch: str) -> int:
    """Total static stack bytes reserved across a snapshot's functions."""
    total = 0
    for m in FRAME_DECREMENTS[arch].finditer(text):
        form = m.groupdict()
        if form.get("push"):
            total += PUSH_BYTES
            continue
        imm = form.get("imm") or form.get("pre")
        value = int(imm, 16) if imm.startswith("0x") else int(imm)
        if form.get("shift"):
            value <<= int(form["shift"])
        total += value
    return total


def tree_frames(root: Path) -> dict[str, int]:
    asm = root / "tests" / "snapshots" / "asm"
    return {
        p.name: frame_bytes(p.read_text(errors="replace"), snapshot_arch(p.name))
        for p in sorted(asm.glob("*.asm"))
    }


def revision_frames(root: Path, rev: str) -> dict[str, int]:
    """The same accounting over the snapshots committed at `rev`."""
    listing = subprocess.run(
        ["git", "ls-tree", "-r", "-z", rev, "--", "tests/snapshots/asm"],
        cwd=root,
        capture_output=True,
        check=True,
    ).stdout.split(b"\0")
    entries = []
    for row in listing:
        if not row:
            continue
        meta, _, path = row.partition(b"\t")
        entries.append((meta.split()[2], Path(path.decode()).name))
    blobs = subprocess.run(
        ["git", "cat-file", "--batch"],
        cwd=root,
        input=b"".join(sha + b"\n" for sha, _ in entries),
        capture_output=True,
        check=True,
    ).stdout
    out: dict[str, int] = {}
    pos = 0
    for _, name in entries:
        head = blobs.index(b"\n", pos)
        size = int(blobs[pos:head].split()[-1])
        body = blobs[head + 1 : head + 1 + size].decode("utf-8", errors="replace")
        pos = head + 1 + size + 1
        out[name] = frame_bytes(body, snapshot_arch(name))
    return out


FRAME_MOVERS_SHOWN = 40


def frame_report(root: Path, against: str | None) -> int:
    """Print the corpus frame total, and against a revision the movers.

    The comparison covers the snapshots both sides carry: a fixture added
    since `against` has no earlier size and would otherwise read as growth.
    """
    cur = tree_frames(root)
    per_arch = {
        suffix: sum(v for k, v in cur.items() if snapshot_arch(k) == suffix)
        for suffix, _ in TARGETS
    }
    parts = " ".join(f"{a}={b}" for a, b in sorted(per_arch.items()))
    print(f"[frames] {len(cur)} snapshots, {sum(cur.values())} bytes ({parts})")
    if against is None:
        return 0
    old = revision_frames(root, against)
    shared = sorted(set(cur) & set(old))
    was, now = sum(old[k] for k in shared), sum(cur[k] for k in shared)

    # Growth first, then the largest shrinks: the cap trims the small
    # middle rather than either extreme.
    def rank(entry: tuple[str, int, int]) -> tuple[int, int, str]:
        delta = entry[2] - entry[1]
        return (0, -delta, entry[0]) if delta > 0 else (1, delta, entry[0])

    moved = sorted(
        ((k, old[k], cur[k]) for k in shared if old[k] != cur[k]), key=rank
    )
    grew = sum(1 for _, a, b in moved if b > a)
    pct = (now - was) / was * 100 if was else 0.0
    print(
        f"[frames] against {against}: {was} -> {now} ({now - was:+d}, {pct:+.1f}%), "
        f"{len(moved) - grew} shrink, {grew} grow, {len(shared) - len(moved)} same"
    )
    for name, a, b in moved[:FRAME_MOVERS_SHOWN]:
        print(f"  {b - a:+8d}  {name}  {a} -> {b}")
    if len(moved) > FRAME_MOVERS_SHOWN:
        print(f"  ... {len(moved) - FRAME_MOVERS_SHOWN} more")
    return 0


# A disassembly line's mnemonic is its first field, its operands the
# rest; a function opens with its `<name>:` label on a line of its own.
MNEMONIC_RE = re.compile(r"^\s+([a-z][a-z0-9._]*)\s*(.*)$")
FUNCTION_LABEL_RE = re.compile(r"^<[^>]+>:")

# What counts as a memory access, and which of those accesses are the
# entry/exit traffic a function pays for the callee-saved registers it
# touches. The saved sets exclude the frame record (aarch64 x29/x30,
# x86_64 %rbp), which any frame carries whatever the allocator does with
# the rest of the bank.
ARCH_ACCESS: dict[str, dict[str, re.Pattern[str]]] = {
    "aarch64": {
        "mem": re.compile(r"^(ld|st|prfm)"),
        "saved": re.compile(r"\b(x19|x2[0-8]|d[89]|d1[0-5])\b"),
        "stack": re.compile(r"\bsp\b"),
    },
    "x64": {
        # A memory operand is a base/index form or a RIP-relative one.
        # `lea` writes the address itself and touches nothing.
        "mem": re.compile(r"\((?:%[a-z0-9]+)?[,%]|<rip>"),
        "saved": re.compile(r"%(rbx|ebx|bx|bl|r1[2-5][dwb]?)\b"),
        "stack": re.compile(r"\((%rsp|%rbp)\)|\(%rsp,|0x[0-9a-f]+\(%(rsp|rbp)\)"),
    },
}


def access_counts(text: str, arch: str) -> tuple[int, int, int, int]:
    """Functions, instructions, memory accesses and callee-saved
    entry/exit accesses in one disassembly."""
    rules = ARCH_ACCESS[arch]
    funcs = insts = mem = saved = 0
    for line in text.splitlines():
        if FUNCTION_LABEL_RE.match(line):
            funcs += 1
            continue
        m = MNEMONIC_RE.match(line)
        if not m:
            continue
        mnemonic, operands = m.group(1), m.group(2)
        insts += 1
        if arch == "x64":
            # push / pop name no operand but access the stack.
            if mnemonic.startswith(("push", "pop")):
                mem += 1
                saved += 1 if rules["saved"].search(operands) else 0
                continue
            if mnemonic.startswith(("lea", "nop")) or not rules["mem"].search(operands):
                continue
        elif not rules["mem"].match(mnemonic):
            continue
        mem += 1
        if rules["stack"].search(operands) and rules["saved"].search(operands):
            saved += 1
    return funcs, insts, mem, saved


# Corpus ceiling per architecture: callee-saved entry/exit accesses per
# function. A function pays these on every call it receives, whatever
# path the call takes, so they are the part of the memory traffic that
# scales with call frequency rather than with the work done.
#
# Per function rather than per instruction: a change that removes
# instructions raises a per-instruction ratio without adding any traffic,
# and this budget must not read an optimization as a regression. Adding
# fixtures adds functions, so the corpus can grow without moving it.
#
# The margin comes from the distribution. Over the 386 commits of the
# branch this budget was written for, the ratio rose by more than 0.024
# on no commit but one: a cross-block CSE that let a merged value's range
# span a call, which raised it 0.594 (+49%) and cost a kernel boot 3.5x
# its time. The headroom below is 0.10 -- four times the largest ordinary
# rise, a sixth of that regression.
#
# A ceiling moves only deliberately: regenerate, read `--budget`, and
# change the number in the commit that spends it.
SAVED_PER_FUNCTION: dict[str, float] = {
    "aarch64": 1.57,
    "x64": 2.06,
}


def corpus_access(root: Path) -> dict[str, tuple[int, int, int, int]]:
    """Per-architecture totals over the committed asm snapshots."""
    asm = root / "tests" / "snapshots" / "asm"
    out: dict[str, list[int]] = {suffix: [0, 0, 0, 0] for suffix, _ in TARGETS}
    for path in sorted(asm.glob("*.asm")):
        arch = snapshot_arch(path.name)
        for i, v in enumerate(access_counts(path.read_text(errors="replace"), arch)):
            out[arch][i] += v
    return {k: tuple(v) for k, v in out.items()}


def budget_report(root: Path) -> int:
    """Report the corpus access ratios and fail on a ceiling."""
    rc = 0
    for arch, (funcs, insts, mem, saved) in sorted(corpus_access(root).items()):
        if funcs == 0 or insts == 0:
            continue
        ratio = saved / funcs
        print(f"[budget] {arch}: {funcs} functions, {insts} instructions, "
              f"{mem * 100.0 / insts:.2f} memory accesses/100 instructions, "
              f"{ratio:.4f} callee-saved entry/exit accesses/function")
        ceiling = SAVED_PER_FUNCTION[arch]
        if ratio > ceiling:
            print(f"[budget] {arch}: {ratio:.4f} callee-saved entry/exit "
                  f"accesses per function is over the {ceiling:.4f} ceiling. "
                  f"A value whose range now spans a call costs its function a "
                  f"save and a restore on every call; find what widened the "
                  f"ranges, or raise the ceiling here with the reason.")
            rc = 1
    return rc


def self_test() -> int:
    """Exercise `check_clean` over the three states it separates, in a
    throwaway repository: the added case is the one `git diff` misses."""
    env = dict(
        os.environ,
        GIT_AUTHOR_NAME="t",
        GIT_AUTHOR_EMAIL="t@t",
        GIT_COMMITTER_NAME="t",
        GIT_COMMITTER_EMAIL="t@t",
    )
    with tempfile.TemporaryDirectory() as td:
        root = Path(td)
        snap = root / "tests" / "snapshots" / "ssa"
        snap.mkdir(parents=True)
        (snap / "a.ssa").write_text("a\n")
        for cmd in (["init", "-q"], ["add", "-A"], ["commit", "-qm", "s"]):
            subprocess.run(["git", *cmd], cwd=root, check=True, env=env)

        def state() -> int:
            return check_clean(root)

        assert state() == 0, "a committed corpus must read clean"
        (snap / "b.ssa").write_text("b\n")
        assert state() == 1, "an untracked snapshot must fail"
        (snap / "b.ssa").unlink()
        (snap / "a.ssa").unlink()
        assert state() == 1, "a removed snapshot must fail"
        (snap / "a.ssa").write_text("changed\n")
        assert state() == 1, "a modified snapshot must fail"
        (snap / "a.ssa").write_text("a\n")
        assert state() == 0, "the restored corpus must read clean again"

    # A frame past the aarch64 12-bit immediate is a shifted instruction
    # plus a remainder, and the page-wise probe splits it further; the
    # shift carries the bulk of the size. A save that reserves as it
    # stores counts its bytes in either disassembler's spelling of the
    # immediate; the release that undoes it, a store with no writeback
    # and a writeback on another base count nothing.
    cases = [
        ("aarch64", "\tsub\tsp, sp, #0x1, lsl #12\n\tstr\txzr, [sp]\n"
                    "\tsub\tsp, sp, #0x700\n", 5888),
        ("aarch64", "\tsub\tsp, sp, #0xf10\n", 3856),
        ("aarch64", "\tsub\tx0, x29, #0x1, lsl #12\n", 0),
        ("aarch64", "\tstp\tx20, x21, [sp, #-0x30]!\n\tstr\tx19, [sp, #0x10]\n"
                    "\tstp\tx29, x30, [sp, #0x20]\n\tadd\tx29, sp, #0x20\n"
                    "\tsub\tsp, sp, #0x40\n\tadd\tsp, sp, #0x40\n"
                    "\tldp\tx29, x30, [sp, #0x20]\n\tldr\tx19, [sp, #0x10]\n"
                    "\tldp\tx20, x21, [sp], #0x30\n\tret\n", 112),
        ("aarch64", "\tstr\tx19, [sp, #-32]!\n\tldr\tx19, [sp], #32\n", 32),
        ("aarch64", "\tstur\tx0, [sp, #-0x10]\n\tstrb\tw1, [x0, #-0x1]!\n", 0),
        ("x64", "\tsubq\t$0x1000, %rsp\n\tsubq\t$0x750, %rsp\n", 5968),
        ("x64", "\tsubq\t0x38(%rsp), %rdx\n", 0),
        ("x64", "\tpushq\t%rbp\n\tpushq\t%rbx\n\tsubq\t$0x20, %rsp\n"
                "\taddq\t$0x20, %rsp\n\tpopq\t%rbx\n\tpopq\t%rbp\n", 48),
        ("x64", "\tpush\t%rbx\n\tpop\t%rbx\n", 8),
    ]
    for arch, text, want in cases:
        got = frame_bytes(text, arch)
        assert got == want, f"{arch} frame decode: {got} != {want}"
    assert snapshot_arch("f.aarch64.asm") == "aarch64"
    assert snapshot_arch("f.x64.asm") == "x64"

    # The access counters, over the forms that decide each field: a
    # callee-saved pair on the stack, an ordinary data access, an
    # address computation that reads nothing, and the frame record,
    # which is not the allocator's traffic.
    access_cases = [
        ("aarch64",
         "<f>:\n\tstp\tx20, x21, [sp, #-0x20]!\n\tstp\tx29, x30, [sp, #0x10]\n"
         "\tldr\tx0, [x1, #0x8]\n\tadd\tx0, x0, #0x1\n"
         "\tldp\tx20, x21, [sp], #0x20\n\tret\n",
         (1, 6, 4, 2)),
        ("x64",
         "<f>:\n\tpushq\t%rbp\n\tpushq\t%rbx\n\tmovq\t%r12, 0x8(%rsp)\n"
         "\tleaq\t(%rdi,%rcx), %rax\n\tmovq\t(%rax), %rdx\n"
         "\tpopq\t%rbx\n\tretq\n",
         (1, 7, 5, 3)),
    ]
    for arch, text, want in access_cases:
        got = access_counts(text, arch)
        assert got == want, f"{arch} access counts: {got} != {want}"
    print("[snapshots] self-test OK")
    return 0


def main(argv: list[str]) -> int:
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument(
        "--only",
        nargs="*",
        help="restrict to the given fixture names (with or without .c)",
    )
    p.add_argument(
        "--check",
        action="store_true",
        help="after regenerating, fail if tests/snapshots/ differs from the "
        "commit -- added, removed or modified files alike",
    )
    p.add_argument(
        "--self-test",
        action="store_true",
        help="check the --check comparison itself and exit; no regeneration",
    )
    p.add_argument(
        "--frame-sizes",
        action="store_true",
        help="report the static stack bytes the committed corpus reserves "
        "and exit; no regeneration",
    )
    p.add_argument(
        "--budget",
        action="store_true",
        help="report the corpus access ratios, and fail when the "
        "callee-saved entry/exit traffic is over its ceiling; no "
        "regeneration",
    )
    p.add_argument(
        "--against",
        metavar="REV",
        help="with --frame-sizes, diff the totals against the snapshots "
        "committed at REV",
    )
    p.add_argument(
        "--badc",
        type=Path,
        metavar="PATH",
        help="regenerate with this badc binary instead of building one",
    )
    args = p.parse_args(argv)
    if args.self_test:
        return self_test()
    root = repo_root()
    if args.frame_sizes:
        return frame_report(root, args.against)
    if args.budget:
        return budget_report(root)
    rc = regenerate(root, args.only, args.badc)
    if rc != 0 or not args.check:
        return rc
    return check_clean(root) or budget_report(root)


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
