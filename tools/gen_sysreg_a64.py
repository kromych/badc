#!/usr/bin/env python3
"""Generate the badc AArch64 system-register and system-operation tables.

`mrs`/`msr` name a register by a 16-bit `op0:op1:CRn:CRm:op2` selector, and
`dc`/`ic`/`at`/`tlbi` name a system operation by a 14-bit `op1:CRn:CRm:op2`
one. Both name spaces are enumerable: every selector has an encoding, so
disassembling the whole space with a reference assembler yields the complete
name-to-selector map, with the encodings themselves as ground truth rather
than a transcription.

The generator builds every `mrs Xt, S<sel>` / `msr S<sel>, Xt` word (op0 2 and
3; op0 0/1 have no architectural names and reach the generic spelling) and
every `sys` word, disassembles them, and keeps the rows the assembler prints
with a name rather than the generic `S<op0>_<op1>_c<n>_c<m>_<op2>` form.

Usage:
    tools/gen_sysreg_a64.py [--llvm-mc llvm-mc] \
        --out src/c5/codegen/aarch64/sysreg_a64_table.rs
"""
import argparse
import re
import subprocess
import sys

GENERIC = re.compile(r"^[Ss]\d_\d_[Cc]\d+_[Cc]\d+_\d$")
CHUNK = 2048


def disassemble(mc: str, words: list[int]) -> list[str]:
    """Disassembled text of each word, one line per word. Words the assembler
    rejects yield no line, so a short result falls back to one word at a
    time."""
    out: list[str] = []
    for i in range(0, len(words), CHUNK):
        part = words[i : i + CHUNK]
        lines = _run(mc, part)
        if len(lines) == len(part):
            out += lines
            continue
        for w in part:
            one = _run(mc, [w])
            out.append(one[0] if one else "")
    return out


def _run(mc: str, words: list[int]) -> list[str]:
    text = "\n".join(
        "0x%02x 0x%02x 0x%02x 0x%02x"
        % (w & 0xFF, (w >> 8) & 0xFF, (w >> 16) & 0xFF, (w >> 24) & 0xFF)
        for w in words
    )
    r = subprocess.run(
        [mc, "-triple=aarch64", "-mattr=+all", "-disassemble"],
        input=text,
        capture_output=True,
        text=True,
    )
    return [l.strip() for l in r.stdout.splitlines() if l.strip() and not l.startswith(".")]


def sysregs(mc: str) -> dict[str, int]:
    """name -> op0<<14 | op1<<11 | CRn<<7 | CRm<<3 | op2."""
    words, keys = [], []
    for op0 in (2, 3):
        for op1 in range(8):
            for crn in range(16):
                for crm in range(16):
                    for op2 in range(8):
                        base = (
                            ((op0 & 1) << 19) | (op1 << 16) | (crn << 12) | (crm << 8) | (op2 << 5)
                        )
                        words.append(base)
                        keys.append((op0 << 14) | (op1 << 11) | (crn << 7) | (crm << 3) | op2)
    out: dict[str, int] = {}
    for form, pat in (
        (0xD5300000, re.compile(r"^mrs\s+x0,\s*(\S+)$")),
        (0xD5100000, re.compile(r"^msr\s+(\S+),\s*x0$")),
    ):
        lines = disassemble(mc, [form | w for w in words])
        for key, line in zip(keys, lines):
            m = pat.match(line)
            if not m or GENERIC.match(m.group(1)):
                continue
            name = m.group(1).lower()
            if out.setdefault(name, key) != key:
                sys.exit(f"gen_sysreg_a64: `{name}` names two selectors")
    return out


def sysops(mc: str) -> dict[str, dict[str, int]]:
    """mnemonic -> op name -> op1<<11 | CRn<<7 | CRm<<3 | op2. Both the
    register-taking and the register-less spellings are swept, since which one
    the assembler prints depends on the operation."""
    words, keys = [], []
    for op1 in range(8):
        for crn in range(16):
            for crm in range(16):
                for op2 in range(8):
                    words.append((op1 << 16) | (crn << 12) | (crm << 8) | (op2 << 5))
                    keys.append((op1 << 11) | (crn << 7) | (crm << 3) | op2)
    pat = re.compile(r"^(dc|ic|at|tlbi)\s+([A-Za-z0-9]+)\s*(,.*)?$")
    out: dict[str, dict[str, int]] = {"dc": {}, "ic": {}, "at": {}, "tlbi": {}}
    for rt in (0, 31):
        lines = disassemble(mc, [0xD5080000 | w | rt for w in words])
        for key, line in zip(keys, lines):
            m = pat.match(line)
            if not m:
                continue
            fam = out[m.group(1)]
            name = m.group(2).lower()
            if fam.setdefault(name, key) != key:
                sys.exit(f"gen_sysreg_a64: `{m.group(1)} {name}` names two selectors")
    return out


def rows(table: dict[str, int], per_line: int) -> str:
    items = sorted(table.items())
    out = []
    for i in range(0, len(items), per_line):
        out.append(
            "    " + " ".join('("%s", 0x%04X),' % (n, v) for n, v in items[i : i + per_line])
        )
    return "\n".join(out)


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--llvm-mc", default="llvm-mc", help="reference assembler driver")
    ap.add_argument("--out", required=True)
    args = ap.parse_args()

    regs = sysregs(args.llvm_mc)
    ops = sysops(args.llvm_mc)
    if len(regs) < 1000 or len(ops["tlbi"]) < 100:
        sys.exit("gen_sysreg_a64: the sweep decoded too few names; check --llvm-mc")

    text = [
        "// @generated by tools/gen_sysreg_a64.py from the reference assembler's",
        "// disassembly of the encoding space. Do not edit by hand; re-run the",
        "// generator to update.",
        "//",
        "// Names are lowercase; the architecture matches them case-insensitively.",
        "// Each table is sorted by name for binary search.",
        "",
        "/// `mrs` / `msr` register selectors, packed as",
        "/// `op0<<14 | op1<<11 | CRn<<7 | CRm<<3 | op2`.",
        "#[rustfmt::skip]",
        "pub(crate) static SYSREGS: &[(&str, u16)] = &[",
        rows(regs, 4),
        "];",
        "",
        "/// `dc` / `ic` / `at` / `tlbi` operation selectors, packed as",
        "/// `op1<<11 | CRn<<7 | CRm<<3 | op2`.",
        "#[rustfmt::skip]",
        "pub(crate) static DC_OPS: &[(&str, u16)] = &[",
        rows(ops["dc"], 6),
        "];",
        "",
        "#[rustfmt::skip]",
        "pub(crate) static IC_OPS: &[(&str, u16)] = &[",
        rows(ops["ic"], 6),
        "];",
        "",
        "#[rustfmt::skip]",
        "pub(crate) static AT_OPS: &[(&str, u16)] = &[",
        rows(ops["at"], 6),
        "];",
        "",
        "#[rustfmt::skip]",
        "pub(crate) static TLBI_OPS: &[(&str, u16)] = &[",
        rows(ops["tlbi"], 6),
        "];",
        "",
    ]
    with open(args.out, "w") as f:
        f.write("\n".join(text))
    print(
        f"gen_sysreg_a64: {len(regs)} registers, "
        + ", ".join(f"{len(v)} {k}" for k, v in ops.items())
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
