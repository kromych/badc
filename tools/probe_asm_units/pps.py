#!/usr/bin/env python3
"""Probe: preprocess every .S unit of a built source tree using the compile
command recorded alongside each object.

Reads .o.cmd files, keeps those whose source_ line names a .S, rewrites the
recorded command to -E, and writes the preprocessed text to OUT/<flat>.i.
"""
import os, re, shlex, subprocess, sys, json
from pathlib import Path

tree = Path(sys.argv[1]).resolve()
out = Path(sys.argv[2]).resolve()
out.mkdir(parents=True, exist_ok=True)

units = []
for cmdf in tree.rglob("*.o.cmd"):
    try:
        txt = cmdf.read_text(errors="replace")
    except OSError:
        continue
    m = re.search(r"^source_\S+ := (.+)$", txt, re.M)
    if not m or not m.group(1).strip().endswith(".S"):
        continue
    src = m.group(1).strip()
    c = re.search(r"^(?:saved)?cmd_(\S+) := (.+?)$", txt, re.M)
    if not c:
        continue
    obj = c.group(1)
    cmd = c.group(2)
    # command may span escaped newlines
    cmd = cmd.split("\nsource_")[0].split("\ndeps_")[0]
    units.append((src, obj, cmd, cmdf))

print(f"units: {len(units)}", file=sys.stderr)
ok = fail = 0
results = {}
for src, obj, cmd, cmdf in sorted(units):
    flat = src.replace("../", "").replace("/", "__").replace(".S", ".i")
    try:
        argv = shlex.split(cmd)
    except ValueError:
        fail += 1
        results[src] = {"status": "parse-error"}
        continue
    # Drop a chained post-step (`; ./tools/objtool/objtool ... obj.o`).
    if ";" in argv:
        argv = argv[: argv.index(";")]
    if argv and (argv[0].endswith(".py") or "buildcc" in argv[0]):
        argv[0] = os.environ.get("REALCC", "gcc")
    new = []
    i = 0
    skip_next = False
    while i < len(argv):
        a = argv[i]
        if skip_next:
            skip_next = False
            i += 1
            continue
        if a == "-c":
            new.append("-E")
        elif a == "-o":
            skip_next = True
        elif a.startswith("-Wp,-MMD") or a.startswith("-MD") or a == "-MMD":
            pass
        else:
            new.append(a)
        i += 1
    new += ["-o", str(out / flat)]
    r = subprocess.run(new, cwd=tree, capture_output=True, text=True)
    if r.returncode == 0:
        ok += 1
        results[src] = {"status": "ok", "out": flat}
    else:
        fail += 1
        results[src] = {"status": "fail", "err": r.stderr[-400:]}
print(f"pp ok={ok} fail={fail}", file=sys.stderr)
(out / "_results.json").write_text(json.dumps(results, indent=1))
