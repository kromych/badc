#!/usr/bin/env python3
"""Probe: feed each preprocessed .S through badc's file-scope asm path.

Wraps the whole unit in a single file-scope asm("...") and compiles with -c.
Records the first diagnostic per unit. This measures the assembler surface
only; it is not a proposed driver design.
"""
import json, re, subprocess, sys, os
from pathlib import Path

badc = sys.argv[1]
src = Path(sys.argv[2])
target = sys.argv[3]
outdir = Path(sys.argv[4])
outdir.mkdir(parents=True, exist_ok=True)

LINEMARK = re.compile(r'^#\s*\d+\s+"')


def cstr(text):
    out = []
    for ch in text:
        if ch == "\\":
            out.append("\\\\")
        elif ch == '"':
            out.append('\\"')
        elif ch == "\n":
            out.append("\\n")
        elif ch == "\t":
            out.append("\\t")
        elif ord(ch) < 32 or ord(ch) > 126:
            out.append("\\%03o" % ord(ch))
        else:
            out.append(ch)
    return "".join(out)


results = {}
for p in sorted(src.glob("*.i")):
    lines = [l for l in p.read_text(errors="replace").split("\n")
             if not LINEMARK.match(l)]
    body = "\n".join(lines)
    cfile = outdir / (p.stem + ".c")
    cfile.write_text('__asm__("' + cstr(body) + '");\n')
    ofile = outdir / (p.stem + ".o")
    r = subprocess.run([badc, "-c", f"--target={target}", str(cfile), "-o", str(ofile)],
                       capture_output=True, text=True, timeout=180)
    err = (r.stderr or r.stdout).strip()
    first = ""
    for l in err.split("\n"):
        if "error" in l.lower() or "unsupported" in l.lower() or "panic" in l.lower():
            first = l.strip()
            break
    if not first and err:
        first = err.split("\n")[0].strip()
    results[p.name] = {"rc": r.returncode, "err": first, "nerr": len(err.split("\n")) if err else 0}

ok = sum(1 for v in results.values() if v["rc"] == 0)
print(f"assembled ok: {ok}/{len(results)}", file=sys.stderr)
(outdir / "_probe.json").write_text(json.dumps(results, indent=1))
for k, v in sorted(results.items()):
    if v["rc"] != 0:
        print(f"{k}\t{v['err'][:200]}")
