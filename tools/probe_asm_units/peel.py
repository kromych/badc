#!/usr/bin/env python3
"""Probe: layer-peeling measurement of the .S assembler gap.

Applies a cumulative set of source neutralizations (each standing in for one
missing assembler construct), re-runs badc's file-scope asm path, and reports
how many units clear each layer plus the first-error distribution behind it.

The neutralizations are measurement scaffolding, not proposed semantics: they
delete or rewrite constructs so the next blocker becomes visible.
"""
import json, re, subprocess, sys
from collections import Counter
from pathlib import Path

badc, srcdir, target = sys.argv[1], Path(sys.argv[2]), sys.argv[3]
outdir = Path(sys.argv[4])
outdir.mkdir(parents=True, exist_ok=True)
LINEMARK = re.compile(r'^#\s*\d+\s+"')


def cstr(t):
    o = []
    for ch in t:
        o.append({"\\": "\\\\", '"': '\\"', "\n": "\\n", "\t": "\\t"}.get(ch, ch)
                 if (31 < ord(ch) < 127 or ch in "\n\t") else "\\%03o" % ord(ch))
    return "".join(o)


def r_symsize(t):
    # SYM_FUNC_END: `.set .L__sym_size_X, .-X` + `.size X, .L__sym_size_X`
    t = re.sub(r"\.set\s+\.L__sym_size_[\w.$]+\s*,[^;\n]*", " ", t)
    t = re.sub(r"\.size\s+[\w.$]+\s*,\s*\.L__sym_size_[\w.$]+", " ", t)
    return t


def r_typeform(t):
    # `.type X STT_FUNC` (space-separated, no @) -> gas comma/@ form
    return re.sub(r"\.type\s+([\w.$]+)\s+STT_(\w+)", r".type \1,@\2", t)


def r_sizeloc(t):
    # any remaining `.size X, . - Y` / `.set X, . - Y`
    t = re.sub(r"\.size\s+[\w.$]+\s*,[^;\n]*\.\s*-[^;\n]*", " ", t)
    t = re.sub(r"\.set\s+[\w.$]+\s*,[^;\n]*\.\s*-[^;\n]*", " ", t)
    return t


def r_codebits(t):
    return re.sub(r"^\s*\.code(16|32|64)\b.*$", " ", t, flags=re.M)


def r_cfi(t):
    return re.sub(r"^\s*\.cfi_\w+.*$", " ", t, flags=re.M)


def r_misc(t):
    for d in ("reloc", "extern", "ltorg", "altmacro", "noaltmacro", "hidden",
              "arch", "arch_extension", "cpu", "protected", "internal"):
        t = re.sub(r"^\s*\." + d + r"\b.*$", " ", t, flags=re.M)
    return t


def r_req(t):
    t = re.sub(r"^\s*[\w.$\\]+\s+\.req\s+\S+.*$", " ", t, flags=re.M)
    return re.sub(r"^\s*\.unreq\b.*$", " ", t, flags=re.M)


def r_multiglobl(t):
    # `.globl a, b` -> one per line
    def f(m):
        return "\n".join(".globl " + n.strip() for n in m.group(1).split(","))
    return re.sub(r"\.globl\s+([\w.$]+(?:\s*,\s*[\w.$]+)+)", f, t)


def r_incbin(t):
    return re.sub(r"^\s*\.incbin\b.*$", " .byte 0", t, flags=re.M)


def r_subsec(t):
    return re.sub(r"^\s*\.subsection\b.*$", " ", t, flags=re.M)


LAYERS = [
    ("L0 baseline", []),
    ("L1 +SYM_FUNC_END .set/.size (location-relative symbol)", [r_symsize]),
    ("L2 +.type X STT_FUNC space form", [r_typeform]),
    ("L3 +remaining `.` location arith in .size/.set", [r_sizeloc]),
    ("L4 +.incbin path (probe artifact)", [r_incbin]),
    ("L5 +.code16/32/64, .cfi_*, .reloc/.extern/.arch/.ltorg/.altmacro", [r_codebits, r_cfi, r_misc]),
    ("L6 +.req/.unreq register aliases", [r_req]),
    ("L7 +multi-operand .globl", [r_multiglobl]),
    ("L8 +.subsection", [r_subsec]),
]


def classify(err):
    e = err
    e = re.sub(r"^\S+\.c:\d+: error: ", "", e)
    e = re.sub(r"`[^`]*`", "`X`", e)
    e = re.sub(r"\(.*\)", "(...)", e)
    return e.strip()[:110]


files = sorted(srcdir.glob("*.i"))
raw = {}
for p in files:
    raw[p.name] = "\n".join(l for l in p.read_text(errors="replace").split("\n")
                            if not LINEMARK.match(l))

rules = []
report = []
for label, newrules in LAYERS:
    rules = rules + newrules
    ok, errs = 0, Counter()
    detail = {}
    for name, body in raw.items():
        t = body
        for r in rules:
            t = r(t)
        cf = outdir / (name.replace(".i", "") + ".c")
        cf.write_text('__asm__("' + cstr(t) + '");\n')
        pr = subprocess.run([badc, "-c", f"--target={target}", str(cf),
                             "-o", str(outdir / (name.replace(".i", "") + ".o"))],
                            capture_output=True, text=True, timeout=240)
        if pr.returncode == 0:
            ok += 1
            detail[name] = "OK"
        else:
            msg = ""
            for l in (pr.stderr or pr.stdout).split("\n"):
                if "error" in l.lower():
                    msg = l.strip()
                    break
            errs[classify(msg)] += 1
            detail[name] = msg
    report.append({"layer": label, "ok": ok, "n": len(raw),
                   "errors": errs.most_common(), "detail": detail})
    print(f"{label}: {ok}/{len(raw)}")
    for k, v in errs.most_common(8):
        print(f"      {v:3d}  {k}")

(outdir / "_peel.json").write_text(json.dumps(report, indent=1))
