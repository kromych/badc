#!/usr/bin/env python3
"""Probe: tally directives / mnemonics / gas-macro use across preprocessed .S.

Emits JSON: {directives: {name: [nfiles, nuses]}, mnemonics: {...},
gas_macros_defined: {...}, gas_macro_calls: {...}, features: {...}}
"""
import json, re, sys
from pathlib import Path
from collections import defaultdict

src = Path(sys.argv[1])
comment_line = sys.argv[2] if len(sys.argv) > 2 else "#"

dir_f, dir_n = defaultdict(set), defaultdict(int)
mn_f, mn_n = defaultdict(set), defaultdict(int)
mac_def, mac_call_f, mac_call_n = defaultdict(set), defaultdict(set), defaultdict(int)
feat_f = defaultdict(set)
per_file = {}

LINEMARK = re.compile(r'^#\s*\d+\s+"')


def strip_block_comments(t):
    return re.sub(r"/\*.*?\*/", " ", t, flags=re.S)


for p in sorted(src.glob("*.i")):
    txt = strip_block_comments(p.read_text(errors="replace"))
    lines = []
    for ln in txt.split("\n"):
        if LINEMARK.match(ln):
            continue
        lines.append(ln)
    # local macro name set for this file
    local_macros = set()
    for ln in lines:
        m = re.match(r"\s*\.macro\s+([A-Za-z_.$][\w.$]*)", ln)
        if m:
            local_macros.add(m.group(1))
            mac_def[m.group(1)].add(p.name)
    fdirs, fmns = set(), set()
    for ln in lines:
        # strip line comments
        ln = re.sub(r"//.*$", "", ln)
        if comment_line == "#":
            ln = re.sub(r"(?<![\w$])#(?![\w$]).*$", "", ln)
            ln = re.sub(r"^\s*#.*$", "", ln)
        ln = ln.strip()
        if not ln:
            continue
        for stmt in re.split(r";(?![^\"']*\")", ln):
            stmt = stmt.strip()
            while True:
                m = re.match(r"^([A-Za-z_.$0-9][\w.$]*)\s*:(?!:)\s*(.*)$", stmt)
                if not m:
                    break
                stmt = m.group(2).strip()
            if not stmt:
                continue
            tok = re.match(r"^([A-Za-z_.$][\w.$]*)", stmt)
            if not tok:
                feat_f["<unparsed-stmt-start>"].add(p.name)
                continue
            name = tok.group(1)
            if name.startswith("."):
                dir_f[name].add(p.name)
                dir_n[name] += 1
                fdirs.add(name)
            elif name in local_macros:
                mac_call_f[name].add(p.name)
                mac_call_n[name] += 1
            else:
                mn_f[name].add(p.name)
                mn_n[name] += 1
                fmns.add(name)
    # feature probes
    whole = "\n".join(lines)
    probes = {
        "gas .macro definition": r"^\s*\.macro\b",
        "gas .rept/.irp/.irpc": r"^\s*\.(rept|irp|irpc)\b",
        "gas .if/.else/.endif": r"^\s*\.if\w*\b",
        "gas .altmacro": r"^\s*\.altmacro\b",
        "numeric local labels (N:)": r"^\s*\d+:",
        "numeric refs (Nb/Nf)": r"\b\d+[bf]\b",
        "symbol arithmetic (a - b)": r"\.(quad|long|word|byte|short|int)\s+[\w.$]+\s*-\s*[\w.$]+",
        "dot (.) current-location": r"[,\s(]\.\s*[-+)]",
        "pushsection/popsection": r"\.(push|pop)section\b",
        "subsection": r"^\s*\.subsection\b",
        "org": r"^\s*\.org\b",
        "equ/set": r"^\s*\.(equ|set)\b",
        "type/size": r"^\s*\.(type|size)\b",
        "cfi": r"^\s*\.cfi_",
        "x86 .code16/.code32/.code64": r"^\s*\.code(16|32|64)\b",
        "arm .arch/.arch_extension/.cpu": r"^\s*\.(arch|arch_extension|cpu)\b",
        "arm .inst": r"^\s*\.inst\b",
        "arm .req/.unreq": r"^\s*\.(req|unreq)\b",
        "expression: \\@ or \\() macro escapes": r"\\[@()]",
        "backslash macro params": r"\\\w+",
    }
    for k, rx in probes.items():
        if re.search(rx, whole, re.M):
            feat_f[k].add(p.name)
    per_file[p.name] = {"dirs": sorted(fdirs), "mns": sorted(fmns)}

out = {
    "nfiles": len(per_file),
    "directives": {k: [len(dir_f[k]), dir_n[k]] for k in sorted(dir_f, key=lambda x: -len(dir_f[x]))},
    "mnemonics": {k: [len(mn_f[k]), mn_n[k]] for k in sorted(mn_f, key=lambda x: -len(mn_f[x]))},
    "gas_macros_defined": {k: len(v) for k, v in sorted(mac_def.items(), key=lambda x: -len(x[1]))},
    "gas_macro_calls": {k: [len(mac_call_f[k]), mac_call_n[k]] for k in sorted(mac_call_f, key=lambda x: -len(mac_call_f[x]))},
    "features": {k: len(v) for k, v in sorted(feat_f.items(), key=lambda x: -len(x[1]))},
    "per_file": per_file,
}
print(json.dumps(out, indent=1))
