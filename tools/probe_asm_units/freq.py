#!/usr/bin/env python3
"""Probe: per-construct file incidence across the preprocessed .S corpus.

Counts how many of the N units contain each construct badc's assembler does
not currently accept. A unit must have every construct it uses supported, so
incidence (not first-error) is the ranking that matters.
"""
import re, sys
from pathlib import Path

src = Path(sys.argv[1])
LINEMARK = re.compile(r'^#\s*\d+\s+"')

CONSTRUCTS = [
    ("`.set S, .-X` then `.size X, S` (SYM_FUNC_END)",
     r"\.set\s+\.L__sym_size_[\w.$]+\s*,\s*\.\s*-"),
    ("`.size X, <symbolic expr>` (any non-literal)",
     r"\.size\s+[\w.$]+\s*,\s*(?!\d+\s*$)[^\n;]*[A-Za-z._$]"),
    ("`.type NAME STT_xxx` (space-separated form)",
     r"\.type\s+[\w.$\\]+\s+STT_"),
    ("`.rept` (unsupported at file scope on x86; broken inside `.macro`)",
     r"^\s*\.rept\b"),
    ("`.if` cond with && / || / comparison operators",
     r"^\s*\.if\b[^\n]*(&&|\|\||[<>]=?|==|!=)"),
    ("`.macro` parameter with `=default`",
     r"^\s*\.macro\s+[\w.$]+[^\n]*\w=[^\n]*"),
    ("`\\@` macro-instance counter used in a label/section item",
     r"\.L[\w.$]*\\@"),
    ("`.octa` (16-byte data)", r"^\s*\.octa\b"),
    ("`.code16` / `.code32` / `.code64`", r"^\s*\.code(16|32|64)\b"),
    ("`.cfi_*` inside a pushed section", r"^\s*\.cfi_"),
    ("`SYM = expr` gas assignment (no `.set`)",
     r"^\s*[A-Za-z_.$][\w.$]*\s*=\s*[^=\n]"),
    ("`.reloc`", r"^\s*\.reloc\b"),
    ("`.extern`", r"^\s*\.extern\b"),
    ("`.req` / `.unreq` register aliases", r"(^\s*[\w$\\]+\s+\.req\s)|(^\s*\.unreq\b)"),
    ("`.subsection`", r"^\s*\.subsection\b"),
    ("`.altmacro` / `.noaltmacro`", r"^\s*\.(no)?altmacro\b"),
    ("`.irpc`", r"^\s*\.irpc\b"),
    ("`.arch` / `.arch_extension` / `.cpu`", r"^\s*\.(arch|arch_extension|cpu)\b"),
    ("numeric label as an instruction operand (e.g. `3f`)",
     r"^\s*[a-z][a-z0-9.]*\s+[^\n;]*[,\s]\d[bf]\b"),
    ("`.globl a, b` multi-operand", r"^\s*\.globl\s+[\w.$]+\s*,"),
    ("`.ltorg`", r"^\s*\.ltorg\b"),
    ("`.incbin`", r"^\s*\.incbin\b"),
    ("`.fill` with 3 operands", r"^\s*\.fill\s+[^\n,]+,[^\n,]+,"),
    ("`.org` with symbolic operand", r"^\s*\.org\s+[^\n]*[A-Za-z_.$]"),
    ("branch/adr to a NAMED symbol in code (a64: no reloc path at all)",
     r"^\s*(b|bl|b\.\w+|cbz|cbnz|tbz|tbnz|adr|adrp)\s+[^\n;]*[A-Za-z_][\w.$]*\s*$"),
    ("`:lo12:` / `:pg_hi21:` relocation specifiers", r":(lo12|pg_hi21|abs_g\d|got|got_lo12):"),
    ("`ldr Xn, =symbol` literal pool", r"^\s*ldr\s+[wx]\d+\s*,\s*=[A-Za-z_.]"),
]

files = sorted(src.glob("*.i"))
texts = {}
for p in files:
    t = "\n".join(l for l in p.read_text(errors="replace").split("\n")
                  if not LINEMARK.match(l))
    t = re.sub(r"/\*.*?\*/", " ", t, flags=re.S)
    texts[p.name] = t

rows = []
for label, rx in CONSTRUCTS:
    c = re.compile(rx, re.M)
    n = sum(1 for t in texts.values() if c.search(t))
    rows.append((n, label))
rows.sort(reverse=True)
print(f"corpus: {len(files)} units")
for n, label in rows:
    if n:
        print(f"{n:4d} /{len(files)}  {label}")
print("--- zero incidence ---")
for n, label in rows:
    if not n:
        print(f"   0        {label}")
