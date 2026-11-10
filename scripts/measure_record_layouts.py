#!/usr/bin/env python3
"""Write `libc/record-layouts/<target>.txt`, the reference layouts of the
structures and unions the bundled headers define, which a unit test holds
badc's layouts against.

For each header `libc/header-targets.txt` marks as shipped by the target's
reference toolchain, badc lists the tagged records and the typedef names a
unit including it defines (`--dump-records`); a probe built with the reference compiler and
run on this machine prints their size, alignment and member offsets, and
each bit-field's first bit and width. A record or member the reference
does not define is left out. A record is listed under the first header
whose unit defines it: the base headers each unit includes, then the
registry's order.

TODO(#2018): the Windows targets.

Run on a machine of the target, against a built badc:

    scripts/measure_record_layouts.py --target linux-x64 --cc gcc
    scripts/measure_record_layouts.py --target macos-aarch64 --cc /usr/bin/clang
"""

from __future__ import annotations

import argparse
import os
import re
import subprocess
import sys
import tempfile
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(REPO / "scripts"))
from measure_header_targets import FEATURES, PREREQS, TABLE, TARGETS, registry_names  # noqa: E402

OUT_DIR = REPO / "libc" / "record-layouts"


def shipped_headers(target: str) -> list[tuple[str, str]]:
    """The registry's headers the reference toolchain ships for `target`,
    with their `header-targets.txt` cells."""
    col = TARGETS.index(target) + 1
    cells = {}
    for line in TABLE.read_text().splitlines():
        if line.startswith("#") or not line.strip():
            continue
        row = line.split("\t")
        cells[row[0]] = row[col]
    return [(h, cells[h]) for h in registry_names() if cells.get(h) in ("y", "p")]


def prelude(header: str, cell: str) -> str:
    """The unit measured for `header`: the feature-test macros, the base
    headers when the header needs them (`p`), and the header."""
    base = PREREQS["posix"] if cell == "p" else []
    return FEATURES + "".join(f"#include <{h}>\n" for h in base + [header])


def badc_records(badc: str, target: str, src: str) -> list[tuple[str, str, list[tuple]]] | None:
    """(kind, tag, members) per record, members as (name, offset) or
    (name, unit offset, bit offset, width); None when badc rejects the unit."""
    with tempfile.TemporaryDirectory() as tmp:
        path = os.path.join(tmp, "unit.c")
        Path(path).write_text(src)
        r = subprocess.run([badc, f"--target={target}", "--dump-records", path],
                           capture_output=True, text=True)
    if r.returncode != 0:
        return None
    records = []
    for line in r.stdout.splitlines():
        if not line.strip():
            continue
        if not line.startswith(" "):
            kind, tag = line.split()[:2]
            records.append((kind, tag, []))
        else:
            records[-1][2].append(tuple(line.split()))
    return records


def probe_source(src: str, records) -> tuple[str, dict[int, tuple]]:
    """The probe and, per line, the (record index, member name or None) it
    measures."""
    lines = [src, "#include <stdio.h>", "#include <string.h>", "#include <stddef.h>",
             "int main(void) {"]
    where: dict[int, tuple] = {}

    def emit(text: str, key: tuple) -> None:
        where[len("\n".join(lines).splitlines()) + 1] = key
        lines.append(text)

    for i, (kind, tag, members) in enumerate(records):
        t = tag if kind == "typedef" else f"{kind} {tag}"
        emit(f'  printf("R {i} %zu %zu\\n", sizeof({t}), _Alignof({t}));', (i, None))
        for m in members:
            name = m[0]
            if len(m) == 2:
                emit(f'  printf("M {i} {name} %zu\\n", offsetof({t}, {name}));', (i, name))
            else:
                emit(f"  {{ {t} v; unsigned char b[sizeof v]; memset(&v, 0, sizeof v); "
                     f"v.{name} = -1; memcpy(b, &v, sizeof v); int f = -1, w = 0; "
                     f"for (int k = 0; k < (int)(8 * sizeof v); k++) "
                     f"if (b[k / 8] >> (k % 8) & 1) {{ if (f < 0) f = k; w++; }} "
                     f'printf("B {i} {name} %d %d\\n", f, w); }}', (i, name))
    lines.append("  return 0;\n}\n")
    return "\n".join(lines), where


def measure(cc: list[str], src: str, records) -> dict[int, tuple] | None:
    """Per record index: (size, align, {member: value}); records and members
    the reference rejects are dropped and the probe rebuilt."""
    dropped: set[tuple] = set()
    for _ in range(64):
        kept = [(k, t, [m for m in ms if (i, m[0]) not in dropped])
                for i, (k, t, ms) in enumerate(records) if (i, None) not in dropped]
        index = [i for i in range(len(records)) if (i, None) not in dropped]
        text, where = probe_source(src, kept)
        with tempfile.TemporaryDirectory() as tmp:
            c, exe = os.path.join(tmp, "probe.c"), os.path.join(tmp, "probe")
            Path(c).write_text(text)
            r = subprocess.run(cc + ["-w", "-o", exe, c], capture_output=True, text=True)
            if r.returncode == 0:
                out = subprocess.run([exe], capture_output=True, text=True, check=True).stdout
                break
        bad = {int(n) for n in re.findall(r"probe\.c:(\d+):\d+: error", r.stderr)}
        hits = {where[n] for n in bad if n in where}
        if not hits:
            sys.stderr.write(r.stderr)
            return None
        dropped |= {(index[k], name) for k, name in hits}
    else:
        return None
    result: dict[int, tuple] = {}
    for line in out.splitlines():
        f = line.split()
        i = index[int(f[1])]
        if f[0] == "R":
            result[i] = (int(f[2]), int(f[3]), {})
        elif f[0] == "M":
            result[i][2][f[2]] = (int(f[3]),)
        else:
            result[i][2][f[2]] = (int(f[3]), int(f[4]))
    return result


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--target", required=True, choices=TARGETS)
    ap.add_argument("--cc", required=True, help="the reference compiler, run on this machine")
    ap.add_argument("--badc", default=str(REPO / "target" / "release" / "badc"))
    args = ap.parse_args()
    cc = args.cc.split()
    seen: set[str] = set()
    out = [f"# Reference record layouts for {args.target}, written by "
           "scripts/measure_record_layouts.py.",
           "# `<header> y|p` (p: the unit includes the base headers first), then",
           "# `struct|union <tag>|typedef <name> <size> <align>` and per member",
           "# `<name> <offset>` or, for a bit-field, `<name> bit <first bit> <width>`."]
    for header, cell in shipped_headers(args.target):
        src = prelude(header, cell)
        records = badc_records(args.badc, args.target, src)
        if records is None:
            print(f"skip {header}: badc rejects the unit", file=sys.stderr)
            continue
        records = [r for r in records if f"{r[0]} {r[1]}" not in seen]
        if not records:
            continue
        measured = measure(cc, src, records)
        if measured is None:
            print(f"skip {header}: the reference probe does not build", file=sys.stderr)
            continue
        block = []
        for i, (kind, tag, members) in enumerate(records):
            if i not in measured:
                continue
            seen.add(f"{kind} {tag}")
            size, align, values = measured[i]
            block.append(f"{kind} {tag} {size} {align}")
            for m in members:
                v = values.get(m[0])
                if v is None:
                    continue
                block.append(f"  {m[0]} {v[0]}" if len(v) == 1 else f"  {m[0]} bit {v[0]} {v[1]}")
        if block:
            out += ["", f"{header} {cell}"] + block
    OUT_DIR.mkdir(exist_ok=True)
    (OUT_DIR / f"{args.target}.txt").write_text("\n".join(out) + "\n")
    print(f"{OUT_DIR / (args.target + '.txt')}: {len(seen)} records", file=sys.stderr)
    return 0


if __name__ == "__main__":
    sys.exit(main())
