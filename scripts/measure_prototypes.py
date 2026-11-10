#!/usr/bin/env python3
"""Write `libc/prototypes/<target>.txt`, the function declarations of the
bundled headers that the reference toolchain's declarations are compatible
with, which a unit test holds badc's declarations against.

For each header `libc/header-targets.txt` marks as shipped by the target's
reference toolchain, badc lists the functions a unit including it declares,
each with its type as a pointer to the function (`--dump-prototypes`). A
probe built with the reference compiler initializes a pointer of badc's
type with each, `static __typeof__(<badc's type>) p = &name;`, incompatible
pointer types an error: a failed initialization is a declaration that
differs from the C library's, which the run reports and leaves out; a
function the reference does not declare is left out. gcc records a
`noreturn` or `const` attribute as a qualifier of the function type, which
the initialization only drops, so gcc serves as well as clang. A function
is listed under the first header, in registry order, whose unit the
reference declares it in.

TODO(#2024): windows-arm64.

Run on a machine of the target, against a built badc:

    scripts/measure_prototypes.py --target linux-x64 --cc clang
    scripts/measure_prototypes.py --target macos-aarch64 --cc /usr/bin/clang
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

OUT_DIR = REPO / "libc" / "prototypes"
# Incompatible pointer types are the one diagnostic that fails a check.
FLAGS = ["-fsyntax-only", "-w", "-Werror=incompatible-pointer-types"]
# Declarations badc keeps different on purpose, reported as departures.
GNU_ENUM = ("glibc's _GNU_SOURCE declaration takes the resource, priority or "
            "timer selector as an enum compatible with unsigned int; badc keeps "
            "POSIX's int")
SDK = "the Windows SDK's declaration, which mingw-w64 departs from"
OFF_T = "off_t is 64-bit, as mingw-w64 makes it under _FILE_OFFSET_BITS=64"
DEPARTURES = {
    **{("linux", n): GNU_ENUM
       for n in ("getrlimit", "setrlimit", "prlimit", "getpriority", "setpriority",
                 "getitimer", "setitimer")},
    **{("windows", n): SDK
       for n in ("_atoflt", "_atoflt_l", "RtlAddFunctionTable", "RtlDeleteFunctionTable",
                 "RtlLookupFunctionEntry", "RtlVirtualUnwind")},
    **{("windows", n): OFF_T for n in ("ftruncate", "truncate")},
}
# The compilers' intrinsic headers: their vector types are each compiler's
# own, which no declaration of the other's is compatible with.
INTRINSICS = re.compile(r"(intrin\.h|^arm_neon\.h|^arm64_neon\.h|^arm_acle\.h)$")


def badc_prototypes(badc: str, target: str, src: str) -> dict[str, str] | None:
    """Name to badc's spelling of a pointer to the function."""
    with tempfile.TemporaryDirectory() as tmp:
        path = os.path.join(tmp, "unit.c")
        Path(path).write_text(src)
        r = subprocess.run([badc, f"--target={target}", "--dump-prototypes", path],
                           capture_output=True, text=True)
    if r.returncode != 0:
        return None
    return dict(line.split("\t", 1) for line in r.stdout.splitlines() if "\t" in line)


def check(cc: list[str], src: str, protos: dict[str, str]) -> tuple[list[str], list[str]] | None:
    """The names the reference finds compatible and those it finds not."""
    kept = sorted(protos)
    differ: list[str] = []
    for _ in range(256):
        head = "#include <stdarg.h>\n" + src
        first = head.count("\n") + 1
        lines = [f"static __typeof__({protos[n]}) __badc_p{i} = &{n};"
                 for i, n in enumerate(kept)]
        text = head + "\n".join(lines) + "\n"
        with tempfile.TemporaryDirectory() as tmp:
            c = os.path.join(tmp, "probe.c")
            Path(c).write_text(text)
            r = subprocess.run(cc + FLAGS + [c], capture_output=True, text=True)
        if r.returncode == 0:
            return kept, differ
        failed, other = set(), set()
        for m in re.finditer(r"probe\.c:(\d+):\d+: error: (.*)", r.stderr):
            i = int(m.group(1)) - first
            if 0 <= i < len(kept):
                (failed if "incompatible" in m.group(2) else other).add(kept[i])
        # A line with any other error names a function the reference does
        # not declare, or a type it cannot spell: not comparable.
        failed -= other
        if not failed and not other:
            sys.stderr.write(r.stderr)
            return None
        differ += sorted(failed)
        kept = [n for n in kept if n not in failed and n not in other]
    return None


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--target", required=True, choices=TARGETS)
    ap.add_argument("--cc", required=True, help="the reference compiler, run on this machine")
    ap.add_argument("--badc", default=str(REPO / "target" / "release" / "badc"))
    args = ap.parse_args()
    cc = args.cc.split()
    seen: set[str] = set()
    out = [f"# Function declarations the reference finds compatible on {args.target},",
           "# written by scripts/measure_prototypes.py: `<header> y|p` (p: the unit",
           "# includes the base headers first), then `<name>\\t<badc's type>`."]
    count = 0
    for header, cell in shipped_headers(args.target):
        if INTRINSICS.search(header):
            continue
        src = prelude(header, cell, args.target)
        protos = badc_prototypes(args.badc, args.target, src)
        if protos is None:
            print(f"skip {header}: badc rejects the unit", file=sys.stderr)
            continue
        protos = {n: t for n, t in protos.items() if n not in seen}
        if not protos:
            continue
        result = check(cc, src, protos)
        if result is None:
            print(f"skip {header}: the reference probe does not build", file=sys.stderr)
            continue
        kept, differ = result
        seen.update(kept + differ)
        platform = args.target.split("-")[0]
        for n in differ:
            why = DEPARTURES.get((platform, n))
            word = f"departs ({why})" if why else "differs"
            print(f"{word} {header}: {n}: badc {protos[n]}", file=sys.stderr)
        if kept:
            out += ["", f"{header} {cell}"] + [f"{n}\t{protos[n]}" for n in kept]
            count += len(kept)
    OUT_DIR.mkdir(exist_ok=True)
    (OUT_DIR / f"{args.target}.txt").write_text("\n".join(out) + "\n", newline="\n")
    print(f"{OUT_DIR / (args.target + '.txt')}: {count} declarations", file=sys.stderr)
    return 0


if __name__ == "__main__":
    sys.exit(main())
