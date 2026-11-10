#!/usr/bin/env python3
"""Write `libc/header-constants/<target>.txt`, the reference values of the
integer constants the bundled headers define, which a unit test holds badc's
values against.

For each header `libc/header-targets.txt` marks as shipped by the target's
reference toolchain, badc lists the object-like macros a unit including it
defines (`-dM -E`), less the predefined ones and the names C17 7.1.3
reserves to the implementation. A probe built with the reference compiler
and run on this machine keeps those that are integer constant expressions
there and prints each one's value as a `long long`. A constant is listed
under the first header, in registry order, whose unit defines it.

TODO(#2023): windows-arm64.

Run on a machine of the target, against a built badc:

    scripts/measure_header_constants.py --target linux-x64 --cc gcc
    scripts/measure_header_constants.py --target macos-aarch64 --cc /usr/bin/clang
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
from measure_record_layouts import prelude, shipped_headers  # noqa: E402

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


def measure(cc: list[str], src: str, names: list[str]) -> dict[str, int] | None:
    """The value of each name the reference takes as an integer constant
    expression; the others are dropped and the probe rebuilt."""
    kept = list(names)
    for _ in range(256):
        ice = [f"static char ice_{i}[({n}) ? 1 : 1]; _Static_assert({INTEGER.format(n)}, \"{n}\");"
               for i, n in enumerate(kept)]
        body = [f'  printf("{n} %lld\\n", (long long)({n}));' for n in kept]
        head = src + "#include <stdio.h>\n"
        first = head.count("\n") + 1
        text = head + "\n".join(ice) + "\nint main(void) {\n" + "\n".join(body) + "\n  return 0;\n}\n"
        lines = {first + i: n for i, n in enumerate(kept)}
        lines.update({first + len(kept) + 1 + i: n for i, n in enumerate(kept)})
        with tempfile.TemporaryDirectory() as tmp:
            c, exe = os.path.join(tmp, "probe.c"), os.path.join(tmp, "probe")
            Path(c).write_text(text)
            r = subprocess.run(cc + ["-w", "-o", exe, c], capture_output=True, text=True)
            if r.returncode == 0:
                out = subprocess.run([exe], capture_output=True, text=True, check=True).stdout
                return {n: int(v) for n, v in (line.split() for line in out.splitlines())}
        bad = {int(n) for n in re.findall(r"probe\.c:(\d+):\d+: error", r.stderr)}
        hits = {lines[n] for n in bad if n in lines}
        if not hits:
            sys.stderr.write(r.stderr)
            return None
        kept = [n for n in kept if n not in hits]
    return None


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--target", required=True, choices=TARGETS)
    ap.add_argument("--cc", required=True, help="the reference compiler, run on this machine")
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
        seen.update(macros)
        if not names:
            continue
        values = measure(cc, src, names)
        if values is None:
            print(f"skip {header}: the reference probe does not build", file=sys.stderr)
            continue
        if values:
            out += ["", f"{header} {cell}"] + [f"{n} {v}" for n, v in sorted(values.items())]
            count += len(values)
    OUT_DIR.mkdir(exist_ok=True)
    (OUT_DIR / f"{args.target}.txt").write_text("\n".join(out) + "\n")
    print(f"{OUT_DIR / (args.target + '.txt')}: {count} constants", file=sys.stderr)
    return 0


if __name__ == "__main__":
    sys.exit(main())
