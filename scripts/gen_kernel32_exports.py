#!/usr/bin/env python3
"""Print the contents of `src/c5/linker/kernel32.exports` (`both`) or
`kernel32_x64.exports` (`x64`): the names kernel32.dll exports, which a
Windows image links by default as link.exe and the MinGW driver do.

The inputs are `dumpbin /exports` listings of the System32 image on a
Windows x64 and a Windows arm64 machine, named `kernel32.<arch>.txt` in DIR:

    dumpbin /nologo /exports C:\\Windows\\System32\\kernel32.dll > kernel32.x64.txt

`both` is the names both machines export and `x64` those only x64 does,
sorted, one per line; the script stops if arm64 exports a name x64 does
not, which the lists cannot state.

Usage: gen_kernel32_exports.py DIR {both|x64}
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

ROW = re.compile(r"^\s+\d+\s+[0-9A-F]+\s+(?:[0-9A-F]{8}\s+)?(\S+)")


def exports(path: Path) -> set[str]:
    names = set()
    for line in path.read_text(errors="replace").splitlines():
        m = ROW.match(line)
        if m and m.group(1) != "name":
            names.add(m.group(1))
    return names


def main() -> int:
    if len(sys.argv) != 3 or sys.argv[2] not in ("both", "x64"):
        print(__doc__, file=sys.stderr)
        return 2
    d = Path(sys.argv[1])
    x64 = exports(d / "kernel32.x64.txt")
    arm64 = exports(d / "kernel32.arm64.txt")
    extra = arm64 - x64
    if extra:
        print(f"arm64 alone exports {sorted(extra)}", file=sys.stderr)
        return 1
    names = arm64 if sys.argv[2] == "both" else x64 - arm64
    sys.stdout.write("".join(f"{n}\n" for n in sorted(names)))
    return 0


if __name__ == "__main__":
    sys.exit(main())
