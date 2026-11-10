#!/usr/bin/env python3
"""Write `libc/header-constants/<target>.txt`, the reference values of the
integer constants the bundled headers define, which a unit test holds badc's
values against.

For each header `libc/header-targets.txt` marks as shipped by the target's
reference toolchain, badc lists the object-like macros a unit including it
defines (`-dM -E`), less the predefined ones, the names C17 7.1.3 reserves
to the implementation, and those an earlier unit measured. A probe built
with the reference compiler keeps those that are integer constant
expressions there and stores each one's value as a `long long`. A constant
is listed under the first header, in registry order, whose unit the
reference measures it in.

Run against a built badc, on a machine of the target, or elsewhere with a
cross reference compiler, the probes compiled only and their values read
from the object file:

    scripts/measure_header_constants.py --target linux-x64 --cc gcc
    scripts/measure_header_constants.py --target macos-aarch64 --cc /usr/bin/clang
    scripts/measure_header_constants.py --target windows-arm64 --objcopy llvm-objcopy \
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
from measure_header_targets import TARGETS  # noqa: E402
from measure_record_layouts import int64s, placed, prelude, probe_bytes, shipped_headers  # noqa: E402

OUT_DIR = REPO / "libc" / "header-constants"
DEFINE = re.compile(r"#define ([A-Za-z_][A-Za-z0-9_]*) (.+)")
RESERVED = re.compile(r"_[A-Z_]")
# Whether an expression has an integer type; a string, pointer or floating
# constant a compiler folds in an array bound as an extension fails it.
INTEGER = ("_Generic(({}), _Bool: 1, char: 1, signed char: 1, unsigned char: 1, "
           "short: 1, unsigned short: 1, int: 1, unsigned: 1, long: 1, unsigned long: 1, "
           "long long: 1, unsigned long long: 1, default: 0)")


def badc_macros(badc: str, target: str, src: str) -> dict[str, str] | None:
    """The object-like macros badc defines for `src`, name to expansion."""
    with tempfile.TemporaryDirectory() as tmp:
        path = os.path.join(tmp, "unit.c")
        Path(path).write_text(src)
        r = subprocess.run([badc, f"--target={target}", "-dM", "-E", path],
                           capture_output=True, text=True)
    if r.returncode != 0:
        return None
    return {m.group(1): m.group(2) for m in map(DEFINE.fullmatch, r.stdout.splitlines()) if m}


def measure(cc: list[str], objcopy: str | None, src: str, names: list[str]) -> dict[str, int] | None:
    """The value of each name the reference takes as an integer constant
    expression; the others are dropped and the probe rebuilt."""
    kept = list(names)
    for _ in range(256):
        if not kept:
            return {}
        ice = [f"static char ice_{i}[({n}) ? 1 : 1]; _Static_assert({INTEGER.format(n)}, \"{n}\");"
               for i, n in enumerate(kept)]
        head = src + "#include <stdio.h>\n"
        first = head.count("\n") + 1
        array = f"const long long __badc_v[]{placed('__badc_v', objcopy is not None)} = {{\n"
        text = (head + "\n".join(ice) + "\n" + array
                + "".join(f"  (long long)({n}),\n" for n in kept) + "};\n")
        lines = {first + i: n for i, n in enumerate(kept)}
        lines.update({first + len(kept) + 1 + i: n for i, n in enumerate(kept)})
        got = probe_bytes(cc, objcopy, text, ["__badc_v"])
        if not isinstance(got, str):
            return dict(zip(kept, int64s(got[0], len(kept))))
        bad = {int(n) for n in re.findall(r"probe\.c:(\d+):\d+: error", got)}
        hits = {lines[n] for n in bad if n in lines}
        if not hits:
            sys.stderr.write(got)
            return None
        kept = [n for n in kept if n not in hits]
    return None


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--target", required=True, choices=TARGETS)
    ap.add_argument("--cc", required=True, help="the reference compiler")
    ap.add_argument("--objcopy", help="compile the probes only and read their values with this "
                    "llvm-objcopy, for a reference compiler of another machine")
    ap.add_argument("--badc", default=str(REPO / "target" / "release" / "badc"))
    args = ap.parse_args()
    cc = args.cc.split()
    predefined = badc_macros(args.badc, args.target, "") or {}
    seen: set[str] = set(predefined)
    out = [f"# Reference integer constants for {args.target}, written by "
           "scripts/measure_header_constants.py.",
           "# `<header> y|p` (p: the unit includes the base headers first), then",
           "# `<name> <value>`, the value as a long long."]
    count = 0
    for header, cell in shipped_headers(args.target):
        src = prelude(header, cell, args.target)
        macros = badc_macros(args.badc, args.target, src)
        if macros is None:
            print(f"skip {header}: badc rejects the unit", file=sys.stderr)
            continue
        names = sorted(n for n, v in macros.items()
                       if n not in seen and not RESERVED.match(n) and v.strip())
        if not names:
            continue
        values = measure(cc, args.objcopy, src, names)
        if values is None:
            print(f"skip {header}: the reference probe does not build", file=sys.stderr)
            continue
        seen.update(values)
        if values:
            out += ["", f"{header} {cell}"] + [f"{n} {v}" for n, v in sorted(values.items())]
            count += len(values)
    OUT_DIR.mkdir(exist_ok=True)
    (OUT_DIR / f"{args.target}.txt").write_text("\n".join(out) + "\n", newline="\n")
    print(f"{OUT_DIR / (args.target + '.txt')}: {count} constants", file=sys.stderr)
    return 0


if __name__ == "__main__":
    sys.exit(main())
