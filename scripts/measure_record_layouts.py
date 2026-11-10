#!/usr/bin/env python3
"""Write `libc/record-layouts/<target>.txt`, the reference layouts of the
structures and unions the bundled headers define, which a unit test holds
badc's layouts against.

For each header `libc/header-targets.txt` marks as shipped by the target's
reference toolchain, badc lists the tagged records and the typedef names a
unit including it defines (`--dump-records`). A probe built with the
reference compiler holds their size, alignment and member offsets, and a
copy of each record with one bit-field all ones, which give its first bit
and width. A record or member the reference does not define is left out.
A record is listed under the first header whose unit defines it: the base
headers each unit includes, then the registry's order.

Run against a built badc, on a machine of the target, or elsewhere with a
cross reference compiler, the probes compiled only and their values read
from the object file:

    scripts/measure_record_layouts.py --target linux-x64 --cc gcc
    scripts/measure_record_layouts.py --target macos-aarch64 --cc /usr/bin/clang
    scripts/measure_record_layouts.py --target windows-arm64 --objcopy llvm-objcopy \
        --cc "clang --target=aarch64-w64-mingw32 -nostdinc -isystem <clang's include> \
              -isystem <mingw-w64's include>"
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
from measure_header_targets import (  # noqa: E402
    FEATURES, PREREQS, TABLE, TARGETS, registry_names, require_current_badc)

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


def prelude(header: str, cell: str, target: str) -> str:
    """The unit measured for `header`: the feature-test macros, the
    platform's base headers when the header needs them (`p`), and the
    header."""
    platform = "windows" if target.startswith("windows") else "posix"
    base = PREREQS[platform] if cell == "p" else []
    return FEATURES + "".join(f"#include <{h}>\n" for h in base + [header])


# The pseudo-member a typedef of an integer type carries for its signedness.
SIGN = "?signed"


def badc_records(badc: str, target: str, src: str) -> list[tuple[str, str, list[tuple]]] | None:
    """(kind, tag, members) per record, members as (name, offset) or
    (name, unit offset, bit offset, width), and an integer typedef's
    signedness as (SIGN,); None when badc rejects the unit."""
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
            f = line.split()
            records.append((f[0], f[1], [(SIGN,)] if len(f) == 5 else []))
        else:
            records[-1][2].append(tuple(line.split()))
    return records


# The objects a probe holds its measurements in, with the sections a
# compile-only probe places them in.
SECTIONS = {"__badc_v": ".badcv", "__badc_b": ".badcb"}


def placed(obj: str, cross: bool) -> str:
    """The attribute placing `obj` in its section, for a compile-only probe."""
    return f' __attribute__((section("{SECTIONS[obj]}")))' if cross else ""


def probe_bytes(cc: list[str], objcopy: str | None, text: str, objects: list[str],
                flags: tuple[str, ...] = ("-w",)) -> tuple[bytes, ...] | str:
    """The bytes of `objects` in the probe `text`, or the compiler's errors.
    With `objcopy`, the probe is compiled only and the objects' sections
    are read from the object file; otherwise it is run, printing them."""
    with tempfile.TemporaryDirectory() as tmp:
        c = os.path.join(tmp, "probe.c")
        if objcopy:
            Path(c).write_text(text)
            obj = os.path.join(tmp, "probe.o")
            r = subprocess.run(cc + [*flags, "-c", "-o", obj, c], capture_output=True, text=True)
            if r.returncode != 0:
                return r.stderr
            dumps = [os.path.join(tmp, f"{k}.bin") for k in range(len(objects))]
            args = [a for o, d in zip(objects, dumps) for a in ("--dump-section", f"{SECTIONS[o]}={d}")]
            subprocess.run([objcopy, *args, obj, os.path.join(tmp, "copy.o")], check=True)
            return tuple(Path(d).read_bytes() for d in dumps)
        main = "".join(f"  for (size_t k = 0; k < sizeof {o}; k++) "
                       f'printf("%02x", ((const unsigned char *)&{o})[k]);\n  printf("\\n");\n'
                       for o in objects)
        Path(c).write_text(f"{text}int main(void) {{\n{main}  return 0;\n}}\n")
        exe = os.path.join(tmp, "probe")
        r = subprocess.run(cc + [*flags, "-o", exe, c], capture_output=True, text=True)
        if r.returncode != 0:
            return r.stderr
        out = subprocess.run([exe], capture_output=True, text=True, check=True).stdout
        return tuple(bytes.fromhex(line) for line in out.split())


def int64s(data: bytes, count: int) -> list[int]:
    return [int.from_bytes(data[8 * k:8 * k + 8], "little", signed=True) for k in range(count)]


def probe_source(src: str, records, cross: bool) -> tuple[str, dict[int, tuple], list[tuple], list[tuple]]:
    """The probe; per line, the (record index, member name or None) it
    measures; per value of `__badc_v`, its (record index, member name or
    None, size|align|value); per member of `__badc_b`, the (record index,
    bit-field) its copy with the bit-field all ones gives."""
    lines = src.splitlines() + ["#include <stdio.h>", "#include <stddef.h>"]
    where: dict[int, tuple] = {}
    values: list[tuple] = []
    bits: list[tuple] = []

    def emit(text: str, key: tuple) -> None:
        where[len(lines) + 1] = key
        lines.append(text)

    entries = []
    for i, (kind, tag, members) in enumerate(records):
        t = tag if kind == "typedef" else f"{kind} {tag}"
        entries += [(f"sizeof({t})", (i, None, "size")), (f"_Alignof({t})", (i, None, "align"))]
        for m in members:
            name = m[0]
            if name == SIGN:
                entries.append((f"({t})-1 < ({t})0", (i, name, "value")))
            elif len(m) == 2:
                entries.append((f"offsetof({t}, {name})", (i, name, "value")))
            else:
                bits.append((i, name, t))
    if bits:
        lines.append("struct __badc_bits {")
        for k, (i, name, t) in enumerate(bits):
            emit(f"  {t} b{k};", (i, name))
        lines.append("};")
        entries += [(f"offsetof(struct __badc_bits, b{k})", (i, name, "at"))
                    for k, (i, name, _) in enumerate(bits)]
    lines.append(f"const long long __badc_v[]{placed('__badc_v', cross)} = {{")
    for text, key in entries:
        emit(f"  (long long)({text}),", key[:2])
        values.append(key)
    lines.append("};")
    if bits:
        lines.append(f"const struct __badc_bits __badc_b{placed('__badc_b', cross)} = {{")
        for k, (i, name, _) in enumerate(bits):
            emit(f"  .b{k} = {{ .{name} = -1 }},", (i, name))
        lines.append("};")
    return "\n".join(lines) + "\n", where, values, [(i, name) for i, name, _ in bits]


def measure(cc: list[str], objcopy: str | None, src: str, records) -> dict[int, tuple] | None:
    """Per record index: (size, align, {member: value}); records and members
    the reference rejects are dropped and the probe rebuilt."""
    dropped: set[tuple] = set()
    for _ in range(64):
        kept = [(k, t, [m for m in ms if (i, m[0]) not in dropped])
                for i, (k, t, ms) in enumerate(records) if (i, None) not in dropped]
        index = [i for i in range(len(records)) if (i, None) not in dropped]
        if not index:
            return {}
        text, where, values, bits = probe_source(src, kept, objcopy is not None)
        got = probe_bytes(cc, objcopy, text, ["__badc_v", "__badc_b"] if bits else ["__badc_v"])
        if not isinstance(got, str):
            break
        bad = {int(n) for n in re.findall(r"probe\.c:(\d+):\d+: error", got)}
        hits = {where[n] for n in bad if n in where}
        if not hits:
            sys.stderr.write(got)
            return None
        dropped |= {(index[k], name) for k, name in hits}
    else:
        return None
    result: dict[int, tuple] = {}
    at: dict[tuple, int] = {}
    for (k, name, what), v in zip(values, int64s(got[0], len(values))):
        i = index[k]
        if what == "size":
            result[i] = (v, 0, {})
        elif what == "align":
            result[i] = (result[i][0], v, result[i][2])
        elif what == "value":
            result[i][2][name] = (v,)
        else:
            at[(k, name)] = v
    for k, name in bits:
        i = index[k]
        size = result[i][0]
        b = got[1][at[(k, name)]:at[(k, name)] + size]
        on = [n for n in range(8 * size) if b[n // 8] >> (n % 8) & 1]
        result[i][2][name] = (on[0] if on else -1, len(on))
    return result


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--target", required=True, choices=TARGETS)
    ap.add_argument("--cc", required=True, help="the reference compiler")
    ap.add_argument("--objcopy", help="compile the probes only and read their values with this "
                    "llvm-objcopy, for a reference compiler of another machine")
    ap.add_argument("--badc", default=str(REPO / "target" / "release" / "badc"))
    args = ap.parse_args()
    require_current_badc(args.badc)
    cc = args.cc.split()
    seen: set[str] = set()
    out = [f"# Reference record layouts for {args.target}, written by "
           "scripts/measure_record_layouts.py.",
           "# `<header> y|p` (p: the unit includes the base headers first), then",
           "# `struct|union <tag>|typedef <name> <size> <align> [signed|unsigned]`",
           "# and per member",
           "# `<name> <offset>` or, for a bit-field, `<name> bit <first bit> <width>`."]
    for header, cell in shipped_headers(args.target):
        src = prelude(header, cell, args.target)
        records = badc_records(args.badc, args.target, src)
        if records is None:
            print(f"skip {header}: badc rejects the unit", file=sys.stderr)
            continue
        records = [r for r in records if f"{r[0]} {r[1]}" not in seen]
        if not records:
            continue
        measured = measure(cc, args.objcopy, src, records)
        if measured is None:
            print(f"skip {header}: the reference probe does not build", file=sys.stderr)
            continue
        block = []
        for i, (kind, tag, members) in enumerate(records):
            if i not in measured:
                continue
            seen.add(f"{kind} {tag}")
            size, align, values = measured[i]
            sign = {(1,): " signed", (0,): " unsigned"}.get(values.get(SIGN), "")
            block.append(f"{kind} {tag} {size} {align}{sign}")
            for m in members:
                v = values.get(m[0])
                if v is None or m[0] == SIGN:
                    continue
                block.append(f"  {m[0]} {v[0]}" if len(v) == 1 else f"  {m[0]} bit {v[0]} {v[1]}")
        if block:
            out += ["", f"{header} {cell}"] + block
    OUT_DIR.mkdir(exist_ok=True)
    (OUT_DIR / f"{args.target}.txt").write_text("\n".join(out) + "\n", newline="\n")
    print(f"{OUT_DIR / (args.target + '.txt')}: {len(seen)} records", file=sys.stderr)
    return 0


if __name__ == "__main__":
    sys.exit(main())
