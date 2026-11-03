#!/usr/bin/env python3
"""Regenerate the export lists in `src/c5/object/nt_crt.rs`: the C runtime
names ntoskrnl.exe and ntdll.dll export, which a native-subsystem PE image
imports in place of msvcrt.dll and ucrtbase.dll.

The inputs are `dumpbin /exports` listings of the System32 images on a
Windows x64 and a Windows arm64 machine, one file per module and machine,
named `<module>.<arch>.txt` in DIR:

    dumpbin /nologo /exports C:\\Windows\\System32\\ntdll.dll > ntdll.x64.txt

for `ntdll`, `ntoskrnl`, `msvcrt` and `ucrtbase` (`ntoskrnl.exe`, the
others `.dll`), with `<arch>` `x64` and `arm64`. A module's list is its
exports that msvcrt.dll or ucrtbase.dll export too, split into the names
both machines export and those only x64 does; the script stops if arm64
exports a name x64 does not, which the lists cannot state.

Usage: gen_nt_crt_exports.py DIR  (prints the Rust constants)
"""

from __future__ import annotations

import re
import sys
import textwrap
from pathlib import Path

ROW = re.compile(r"^\s+\d+\s+[0-9A-F]+\s+(?:[0-9A-F]{8}\s+)?(\S+)")


def exports(path: Path) -> set[str]:
    names = set()
    for line in path.read_text(errors="replace").splitlines():
        m = ROW.match(line)
        if m and m.group(1) != "name":
            names.add(m.group(1))
    return names


def constant(name: str, items: set[str], skip: bool) -> str:
    body = ", ".join(f'"{s}"' for s in sorted(items))
    if not skip:
        return f"const {name}: &[&str] = &[{body}];"
    lines = textwrap.wrap(body + ",", 92, break_on_hyphens=False, break_long_words=False)
    return "\n".join(
        ["#[rustfmt::skip]", f"const {name}: &[&str] = &["] + ["    " + l for l in lines] + ["];"]
    )


def main() -> int:
    if len(sys.argv) != 2:
        print(__doc__, file=sys.stderr)
        return 2
    d = Path(sys.argv[1])
    out = []
    for module in ("ntdll", "ntoskrnl"):
        lists = {}
        for arch in ("x64", "arm64"):
            crt = exports(d / f"msvcrt.{arch}.txt") | exports(d / f"ucrtbase.{arch}.txt")
            lists[arch] = exports(d / f"{module}.{arch}.txt") & crt
        extra = lists["arm64"] - lists["x64"]
        if extra:
            print(f"{module}: arm64 alone exports {sorted(extra)}", file=sys.stderr)
            return 1
        out.append(constant(module.upper(), lists["arm64"], True))
        out.append(constant(f"{module.upper()}_X64", lists["x64"] - lists["arm64"], False))
    print("\n\n".join(out))
    return 0


if __name__ == "__main__":
    sys.exit(main())
