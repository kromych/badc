#!/usr/bin/env python3
"""Write `libc/header-targets.txt`, the measurement `src/c5/headers.rs` is
held against: `probe` rows one reference compiler's cells (the table's
legend), `merge` joins them. The Windows arm64 column is the x86-64 cell,
or clang's aarch64 resource-header cell where that differs from x86-64's.

    probe --cc gcc --owner "rpm -qf --qf %{NAME}" --platform "glibc|kernel-headers|gcc"
    probe --cc /usr/bin/clang --describe "SDK $(xcrun --show-sdk-version)"
    probe --cc gcc --owner "pacman -Qoq" --platform "mingw-w64-x86_64-(headers|crt|winpthreads|gcc)$"
    probe --resource-only --cc "clang --target=aarch64-w64-mingw32"    (and x86_64)
    merge MAC LINUX_A64 LINUX_X64 WIN_X64 CLANG_X64 CLANG_A64
"""

from __future__ import annotations

import argparse
import os
import re
import shlex
import subprocess
import sys
import tempfile
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
REGISTRY = REPO / "src" / "c5" / "headers.rs"
TABLE = REPO / "libc" / "header-targets.txt"
TARGETS = ["macos-aarch64", "linux-aarch64", "linux-x64", "windows-x64", "windows-arm64"]

# The feature-test macros that open every interface, and the headers a
# platform's other headers assume are already included.
FEATURES = "#define _GNU_SOURCE 1\n#define _XOPEN_SOURCE 700\n#define _DARWIN_C_SOURCE 1\n"
PREREQS = {
    "posix": ["sys/types.h", "sys/socket.h", "netinet/in.h", "stdint.h", "stddef.h"],
    "windows": ["winsock2.h", "windows.h"],
}


def registry_names() -> list[str]:
    text = REGISTRY.read_text()
    start = text.index("static EMBEDDED_HEADERS")
    body = text[start : text.index("];", start)]
    return re.findall(r'header!\(\s*"([^"]+)"', body)


def run(cmd: list[str], src: str) -> subprocess.CompletedProcess:
    with tempfile.TemporaryDirectory() as tmp:
        path = os.path.join(tmp, "probe.c")
        with open(path, "w") as f:
            f.write(src)
        return subprocess.run(cmd + [path], capture_output=True, text=True)


def first_include(stderr: str, name: str) -> str | None:
    """The file `-H` reports for the unit's own `#include <name>`."""
    tail = os.path.normcase("/" + name)
    for line in stderr.splitlines():
        path = line[2:].strip()
        if line.startswith(". ") and os.path.normcase(path.replace("\\", "/")).endswith(tail):
            return path
    return None


def first_error(stderr: str) -> str:
    lines = [line.strip() for line in stderr.splitlines() if "error" in line]
    return lines[0] if lines else ""


def probe(args: argparse.Namespace) -> int:
    cc = shlex.split(args.cc)
    if args.resource_only:
        cc += ["-ffreestanding", "-nostdlibinc"]
    names = registry_names()
    src = "".join(f"#if __has_include(<{n}>)\nHAS {i}\n#endif\n" for i, n in enumerate(names))
    pre = run(cc + ["-E", "-P"], src)
    if pre.returncode != 0:
        sys.stderr.write(pre.stderr)
        return 1
    found = {int(m) for m in re.findall(r"^HAS (\d+)$", pre.stdout, re.M)}
    windows = re.search(r"^#define _WIN32 ", run(cc + ["-E", "-dM"], "").stdout, re.M)
    lead = FEATURES + "".join(f"#include <{p}>\n" for p in PREREQS["windows" if windows else "posix"])
    syntax = cc + ["-fsyntax-only", "-w", "-H", "-x", "c"]
    version = subprocess.run(cc + ["--version"], capture_output=True, text=True).stdout
    print(f"# {version.splitlines()[0]}" + (f", {args.describe}" if args.describe else ""))
    for i, name in enumerate(names):
        if i not in found:
            print(f"{name}\t-\t-")
            continue
        alone = run(syntax, f"#include <{name}>\n")
        path = first_include(alone.stderr, name)
        owner = "?" if args.owner else "-"
        if args.owner and path:
            q = subprocess.run(shlex.split(args.owner) + [path], capture_output=True, text=True)
            owner = q.stdout.strip() or "?"
        if alone.returncode == 0:
            cell = "y"
        else:
            after = run(syntax, f"{lead}#include <{name}>\n")
            cell = "p" if after.returncode == 0 else "f"
            sys.stderr.write(f"{name}: {cell}: {first_error(alone.stderr)}\n")
        if args.platform and not re.match(args.platform, owner):
            cell = "o"
        print(f"{name}\t{cell}\t{owner}")
    return 0


def read_probe(path: str) -> tuple[str, dict[str, tuple[str, str]]]:
    lines = Path(path).read_text().splitlines()
    rows = {}
    for line in lines[1:]:
        name, cell, owner = line.split("\t")
        rows[name] = (cell, owner)
    return lines[0].lstrip("# "), rows


def merge(args: argparse.Namespace) -> int:
    (mac, la64, lx64, wx64, rx64, ra64) = (read_probe(p) for p in args.probes)
    cols = [mac, la64, lx64, wx64]
    names = registry_names()
    for name in names:
        cell, owner = wx64[1][name]
        if owner.endswith("-gcc") and rx64[1][name][0] == "-":
            sys.exit(f"{name}: gcc's own header on windows-x64, absent from clang's")
    lines = [
        "# Which bundled headers each target's reference toolchain ships, written",
        "# by scripts/measure_header_targets.py. src/c5/headers.rs holds every",
        "# registry entry's target set against this table.",
        "#",
        "# y  found by `__has_include`; `#include` alone compiles",
        "# p  found; compiles after the feature-test macros and base headers",
        "# f  found; does not compile (an architecture `#error`)",
        "# o  found in a package outside the C library, SDK and compiler",
        "# -  not found",
        "#",
    ]
    for target, (desc, _) in zip(TARGETS, cols):
        lines.append(f"# {target}: {desc.strip()}")
    lines.append(f"# {TARGETS[4]}: the {TARGETS[3]} cell (mingw-w64 installs one header tree for")
    lines.append(f"#   every architecture), or the cell of {ra64[0]}'s resource headers for")
    lines.append("#   aarch64-w64-mingw32 where it differs from x86_64-w64-mingw32's")
    lines += ["#", "# name\t" + "\t".join(TARGETS)]
    for name in names:
        cells = [col[1][name][0] for col in cols]
        x, a = rx64[1][name][0], ra64[1][name][0]
        cells.append(a if x != a else cells[3])
        lines.append(name + "\t" + "\t".join(cells))
    TABLE.write_text("\n".join(lines) + "\n")
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    sub = ap.add_subparsers(dest="cmd", required=True)
    p = sub.add_parser("probe")
    p.add_argument("--cc", required=True, help="the reference compiler command")
    p.add_argument("--resource-only", action="store_true", help="the compiler's own headers only")
    p.add_argument("--owner", help="a command printing the package that owns a file")
    p.add_argument("--platform", help="a regex matching the packages of the platform")
    p.add_argument("--describe", help="text appended to the compiler's version line")
    m = sub.add_parser("merge")
    m.add_argument("probes", nargs=6, help="the probes, in the order of the example")
    args = ap.parse_args()
    return probe(args) if args.cmd == "probe" else merge(args)


if __name__ == "__main__":
    sys.exit(main())
