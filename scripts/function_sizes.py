#!/usr/bin/env python3
"""Per-function code size over a linked image, a `System.map`, or a set
of object files.

The quantity is the *distribution*, not the total. An inliner that
duplicates a callee's transitive body at every site moves aggregate text
by a few per cent while individual functions move by a factor of twenty;
a budget on the total does not separate the two. This reports, per
architecture:

  * `bytes/function` -- text bytes over text symbols. A function pays
    its size in i-cache and in the pages the image touches whatever the
    call frequency, and duplication raises this while removing symbols,
    so it moves where a total does not.
  * `>4 KiB per 1000` -- the tail density: functions past four kilobytes
    per thousand functions. Duplication lands its copies in the tail, so
    this moves several times as far as the mean.

`--check` fails when either is over its committed ceiling.

Inputs:

  * a `System.map` (the kernel build writes one): sizes come from the
    gap to the next symbol, so `--arch` has to name the target.
  * an ELF image, object, or archive: sizes and the machine come from
    the symbol table, read with `nm`.
"""

from __future__ import annotations

import argparse
import struct
import subprocess
import sys
from pathlib import Path

# Per-architecture ceilings over the kernel gate's own object set: every
# C unit of the pinned 7.1.6 `defconfig` tree, compiled on its recorded
# kbuild command line, measured with `nm --print-size`. That is what the
# gate already builds, so the check costs no compile:
#
#   find <tree> -name '*.o' > /tmp/objs
#   scripts/function_sizes.py --check --files-from /tmp/objs
#
# A `System.map` reports the same counters over a linked image, where
# alignment padding and assembly bodies join the population and the
# numbers are lower; a corpus that is not the one below needs its own
# ceilings measured before `--check` means anything on it.
#
# The margin comes from the distribution. Sampling the 385 commits of the
# branch these were written for at 17 points, `bytes/function` stayed
# within 579.5 .. 630.0 and rose by at most 4.2% between adjacent
# samples. One commit broke that band, twice: an inliner size gate that
# measured a callee on the body it holds rather than the body it emits
# raised it 35.6% where it first landed and 15.3% where it landed again
# after a revert, and left individual functions at 19x to 33x their
# former size.
#
# Over the whole object set the culprit's parent measures 572.3 bytes per
# function and 11.05 functions over 4 KiB per 1000, and the culprit 636.6
# and 15.70. The ceilings sit between the two: 600.0 clears the parent by
# 4.8% -- above the largest ordinary rise -- and the current compiler
# (517.9) by 15.8%, and 12.5 clears them by 13% and 96%. The tail counter
# is the looser of the two because it has to pass at the parent; the mean
# is what binds.
#
# `x64` has no committed ceiling: no x86_64 defconfig corpus was measured
# for it. Measure one the same way and add it here.
#
# A ceiling moves only deliberately: measure, read the report, and change
# the number in the commit that spends it.
CEILINGS: dict[str, dict[str, float]] = {
    "aarch64": {"bytes_per_function": 600.0, "over_4k_per_1000": 12.5},
}

# A gap this large is a section boundary or padding, not a function.
MAX_FUNCTION_BYTES = 1 << 20

ELF_MACHINE = {0x3E: "x64", 0xB7: "aarch64"}


def elf_arch(path: Path) -> str | None:
    with path.open("rb") as fh:
        head = fh.read(20)
    if len(head) < 20 or head[:4] != b"\x7fELF":
        return None
    little = head[5] == 1
    machine = struct.unpack("<H" if little else ">H", head[18:20])[0]
    return ELF_MACHINE.get(machine)


def sizes_from_map(path: Path) -> list[tuple[int, str]]:
    """Text symbol sizes from a `System.map`: the gap to the next
    symbol, which is what the map records the size as."""
    rows: list[tuple[int, str]] = []
    for line in path.read_text(errors="replace").splitlines():
        fields = line.split()
        if len(fields) >= 3 and fields[1] in "tT":
            rows.append((int(fields[0], 16), fields[2]))
    rows.sort()
    out = []
    for (addr, name), (nxt, _) in zip(rows, rows[1:]):
        gap = nxt - addr
        if 0 < gap < MAX_FUNCTION_BYTES:
            out.append((gap, name))
    return out


def sizes_from_elf(path: Path) -> list[tuple[int, str]]:
    out = subprocess.run(
        ["nm", "--print-size", "--defined-only", str(path)],
        capture_output=True,
        text=True,
    )
    if out.returncode != 0:
        raise SystemExit(f"[sizes] nm failed on {path}: {out.stderr.strip()}")
    rows = []
    for line in out.stdout.splitlines():
        fields = line.split()
        # `value size type name`; a symbol with no size prints three
        # fields and carries none.
        if len(fields) == 4 and fields[2] in "tT" and not fields[3].startswith("$"):
            rows.append((int(fields[1], 16), fields[3]))
    return [r for r in rows if 0 < r[0] < MAX_FUNCTION_BYTES]


def report(arch: str, sizes: list[tuple[int, str]], check: bool) -> int:
    n = len(sizes)
    if n == 0:
        print(f"[sizes] {arch}: no text symbols")
        return 0
    total = sum(s for s, _ in sizes)
    ordered = sorted(s for s, _ in sizes)
    per_function = total / n
    over_4k = sum(1 for s in ordered if s > 4096) * 1000.0 / n
    p99 = ordered[min(n - 1, int(0.99 * n))]
    biggest = max(sizes)
    print(
        f"[sizes] {arch}: {n} functions, {total} text bytes, "
        f"{per_function:.1f} bytes/function, p99 {p99}, "
        f"{over_4k:.2f} functions over 4 KiB per 1000, "
        f"largest {biggest[0]} ({biggest[1]})"
    )
    if not check:
        return 0
    ceiling = CEILINGS.get(arch)
    if ceiling is None:
        print(f"[sizes] {arch}: no committed ceiling")
        return 0
    rc = 0
    if per_function > ceiling["bytes_per_function"]:
        print(
            f"[sizes] {arch}: {per_function:.1f} bytes per function is over "
            f"the {ceiling['bytes_per_function']:.1f} ceiling. A body pulled "
            f"in and duplicated raises this while removing symbols; find "
            f"what widened the inlining, or raise the ceiling here with the "
            f"reason."
        )
        rc = 1
    if over_4k > ceiling["over_4k_per_1000"]:
        print(
            f"[sizes] {arch}: {over_4k:.2f} functions over 4 KiB per 1000 is "
            f"over the {ceiling['over_4k_per_1000']:.2f} ceiling. Duplication "
            f"lands in the tail; read the largest functions above."
        )
        rc = 1
    return rc


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument(
        "paths", nargs="*", help="System.map, ELF image, object or archive"
    )
    ap.add_argument(
        "--files-from",
        metavar="FILE",
        help="read input paths from FILE, one per line; the counters are "
        "ratios over the whole population, so a corpus has to reach the "
        "script in one run",
    )
    ap.add_argument(
        "--arch",
        choices=sorted(ELF_MACHINE.values()),
        help="target of a System.map input; an ELF names its own",
    )
    ap.add_argument(
        "--check",
        action="store_true",
        help="fail when a counter is over its committed ceiling",
    )
    args = ap.parse_args()
    names = list(args.paths)
    if args.files_from:
        names += [
            ln.strip()
            for ln in Path(args.files_from).read_text().splitlines()
            if ln.strip()
        ]
    if not names:
        raise SystemExit("[sizes] no inputs")

    per_arch: dict[str, list[tuple[int, str]]] = {}
    for name in names:
        path = Path(name)
        if not path.exists():
            raise SystemExit(f"[sizes] no such file: {path}")
        arch = elf_arch(path)
        if arch is None:
            if args.arch is None:
                raise SystemExit(f"[sizes] {path} is not an ELF; pass --arch")
            arch, sizes = args.arch, sizes_from_map(path)
        else:
            sizes = sizes_from_elf(path)
        per_arch.setdefault(arch, []).extend(sizes)

    rc = 0
    for arch in sorted(per_arch):
        rc |= report(arch, per_arch[arch], args.check)
    return rc


if __name__ == "__main__":
    sys.exit(main())
