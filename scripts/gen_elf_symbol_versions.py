#!/usr/bin/env python3
"""Regenerate `libc/versions/elf-<arch>.txt`, the symbol-version manifest
the ELF writer stamps into `.gnu.version_r`.

The manifest states, for every name the bundled headers bind to a Linux
shared library, the version requirement badc records for it. It is
committed data: the link reads it instead of a library on the build
machine, so the same command emits the same image on every host.

Two inputs decide an entry:

  * the version definitions a reference glibc carries for the symbol,
    read from a library on the machine running this script;
  * the ABI floor, the oldest glibc release the images are meant to load
    against.

A symbol takes the newest version at or below the floor -- the
definition a link against a sysroot holding that release would bind --
and, when the floor predates the symbol, the oldest version it has.
glibc never withdraws a version definition, so a recent reference
library still carries everything an older release defined and the two
inputs reproduce that release's default set. Version namespaces other
than `GLIBC_` (libgcc's `GCC_x.y`) carry no release ordering the floor
can be compared against; those take the reference library's default.

The floor cannot decide a symbol whose newer version implements a
different interface rather than the same one. Every symbol whose floor
pick and the library's current default are distinct implementations --
different addresses -- must be listed in `libc/versions/minimums.txt`,
which states either the minimum version the bundled headers' interface
needs or that the two implement the same interface, and why. An
unreviewed one stops the run.

The names come from `badc --dump-bindings`, so the manifest and the
headers cannot drift apart on a preprocessing subtlety; a unit test
holds the two in step.

Run once per architecture on a machine of that architecture, against a
built badc:

    scripts/gen_elf_symbol_versions.py --arch x86_64
    scripts/gen_elf_symbol_versions.py --arch aarch64

`readelf` from binutils or llvm supplies the symbol table.
"""

from __future__ import annotations

import argparse
import os
import re
import subprocess
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
HEADERS = REPO / "libc" / "include"

# Where a soname is looked for, ordered as the loader prefers.
LIB_DIRS = [
    "/lib/{arch}-linux-gnu",
    "/usr/lib/{arch}-linux-gnu",
    "/lib64",
    "/usr/lib64",
    "/lib",
    "/usr/lib",
]


def header_bindings(badc: str, arch: str) -> dict[str, set[str]]:
    """Map each soname to the symbols the bundled headers bind to it, as
    badc's own preprocessor resolves them for the target."""
    r = subprocess.run(
        [badc, "--dump-bindings", f"--target=linux-{'x64' if arch == 'x86_64' else arch}"], capture_output=True, text=True
    )
    if r.returncode != 0:
        sys.exit(f"{badc} --dump-bindings failed: {r.stderr.strip()}")
    out: dict[str, set[str]] = {}
    for line in r.stdout.splitlines():
        soname, symbol = line.split()
        out.setdefault(soname, set()).add(symbol)
    return out


def locate(soname: str, arch: str) -> str | None:
    for pattern in LIB_DIRS:
        path = os.path.join(pattern.format(arch=arch), soname)
        if os.path.exists(path):
            return path
    return None


def readelf(path: str) -> str:
    for tool in ("readelf", "llvm-readelf", "eu-readelf"):
        try:
            r = subprocess.run([tool, "-sDW", path], capture_output=True, text=True)
        except FileNotFoundError:
            continue
        if r.returncode == 0:
            return r.stdout
    sys.exit(f"no readelf could read {path}")


def library_versions(
    path: str,
) -> tuple[dict[str, dict[str, str]], dict[str, str]]:
    """`(symbol -> {version: address}, symbol -> default version)` for one
    library. The address separates a compatibility definition that is a
    second name for the current one from a distinct implementation."""
    versions: dict[str, dict[str, str]] = {}
    default: dict[str, str] = {}
    for line in readelf(path).splitlines():
        fields = line.split()
        if len(fields) < 8 or not fields[0].endswith(":"):
            continue
        if fields[6] == "UND":
            continue
        token = fields[7]
        if "@@" in token:
            name, version = token.split("@@", 1)
            default[name] = version
        elif "@" in token:
            name, version = token.split("@", 1)
        else:
            continue
        versions.setdefault(name, {})[version] = fields[1]
    return versions, default


GLIBC = re.compile(r"^GLIBC_(\d+(?:\.\d+)*)$")


def release(version: str) -> tuple[int, ...] | None:
    m = GLIBC.match(version)
    return tuple(int(p) for p in m.group(1).split(".")) if m else None


MINIMUMS = REPO / "libc" / "versions" / "minimums.txt"


def read_minimums() -> dict[tuple[str, str], tuple[str | None, str]]:
    """`(soname, symbol) -> (minimum version or None, reason)` from
    `libc/versions/minimums.txt`. A `[version]` or `[-]` head opens a
    section and states its reason, continued on indented lines; the
    rows under it are `<soname> <symbol>` at column zero."""
    out: dict[tuple[str, str], tuple[str | None, str]] = {}
    minimum: str | None = None
    reason: list[str] = []
    for raw in MINIMUMS.read_text().splitlines():
        line = raw.strip()
        if not line or line.startswith("#"):
            continue
        if line.startswith("["):
            head, close, rest = line[1:].partition("]")
            if not close:
                sys.exit(f"{MINIMUMS}: malformed section `{line}`")
            minimum = None if head == "-" else head
            if minimum is not None and not GLIBC.match(minimum):
                sys.exit(f"{MINIMUMS}: `{minimum}` is not a glibc version")
            reason = [rest.strip()] if rest.strip() else []
            continue
        if raw[:1].isspace():
            if not reason:
                sys.exit(f"{MINIMUMS}: `{line}` continues no reason")
            reason.append(line)
            continue
        fields = line.split()
        if len(fields) != 2:
            sys.exit(f"{MINIMUMS}: malformed row `{line}`")
        if not reason:
            sys.exit(f"{MINIMUMS}: `{line}` is under no section")
        out[(fields[0], fields[1])] = (minimum, " ".join(reason))
    return out


def required(
    versions: dict[str, str], default: str | None, floor: tuple[int, ...]
) -> str | None:
    """The version to require, per the floor rule in the module header."""
    releases = {v: release(v) for v in versions}
    numbered = {v: r for v, r in releases.items() if r is not None}
    if not numbered:
        return default
    at_or_below = [v for v, r in numbered.items() if r <= floor]
    if at_or_below:
        return max(at_or_below, key=lambda v: numbered[v])
    return min(numbered, key=lambda v: numbered[v])


def needs_review(
    versions: dict[str, str], chosen: str | None, default: str | None
) -> bool:
    """Whether the floor's pick and the library's current default are
    distinct implementations. Two names for one address cannot differ in
    behaviour; two addresses can, and which one the bundled headers
    describe is not something the floor decides."""
    if chosen is None or default is None or chosen == default:
        return False
    return versions.get(chosen) != versions.get(default)


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--arch", required=True, choices=("x86_64", "aarch64"))
    ap.add_argument("--floor", default="2.17", help="oldest glibc release to bind against")
    ap.add_argument("--out", default=None)
    ap.add_argument("--badc", default=str(REPO / "target" / "release" / "badc"))
    args = ap.parse_args()
    floor = tuple(int(p) for p in args.floor.split("."))

    bindings = header_bindings(args.badc, args.arch)
    reference = subprocess.run(
        ["sh", "-c", "ldd --version 2>/dev/null | head -1"], capture_output=True, text=True
    ).stdout.strip()

    minimums = read_minimums()
    unreviewed: list[str] = []
    body: list[str] = []
    for soname in sorted(bindings):
        path = locate(soname, args.arch)
        if path is None:
            sys.exit(f"{soname}: not found for {args.arch}")
        versions, default = library_versions(path)
        body.append(f"[{soname}]")
        width = max(len(s) for s in bindings[soname])
        for symbol in sorted(bindings[soname]):
            raised = False
            if symbol in versions:
                # A version the reference library defines, chosen by the
                # floor rule, then by the review where it recorded one.
                version = required(versions[symbol], default.get(symbol), floor)
                reviewed = minimums.get((soname, symbol))
                if reviewed is None and needs_review(
                    versions[symbol], version, default.get(symbol)
                ):
                    unreviewed.append(f"{soname} {symbol}")
                minimum, reason = reviewed or (None, "")
                if minimum is not None:
                    if minimum not in versions[symbol]:
                        sys.exit(f"{soname}: {symbol} has no {minimum} to raise to")
                    # A namespace with no release ordering sorts
                    # below any recorded glibc minimum.
                    raised = release(minimum) > (release(version) or ())
                    if raised:
                        version = minimum
                        print(f"{soname}: {symbol} raised to {minimum}: {reason}")
            else:
                # Not exported by the reference library, so the floor rule
                # has nothing to apply; the manifest records no requirement
                # rather than one this library cannot be checked against.
                version = None
            entry = f"{symbol:<{width}} {version or '-'}"
            if raised:
                entry += "  # minimum from libc/versions/minimums.txt"
            body.append(entry)
        body.append("")
    if unreviewed:
        sys.exit(
            "libc/versions/minimums.txt states nothing for a symbol whose "
            "floor pick is a different implementation from the library's "
            "current default:\n  " + "\n  ".join(unreviewed)
        )

    text = [
        f"# ELF symbol-version manifest for {args.arch}, generated by",
        "# scripts/gen_elf_symbol_versions.py. Committed data: the link reads",
        "# this instead of a shared object on the build machine.",
        "#",
        f"# ABI floor: glibc {args.floor}. Each symbol takes the newest version",
        "# at or below the floor, else the oldest version it has, unless",
        "# libc/versions/minimums.txt raises it -- which it does only where",
        "# the older definition implements a different interface, and says so.",
        f"# Reference library: {reference or 'unknown'}.",
        "#",
        "# `[soname]` opens a library; each line under it names a symbol the",
        "# bundled headers bind to it and the version the image requires. `-`",
        "# is a symbol the reference library does not export, which the floor",
        "# rule cannot answer for: no requirement is recorded, so a link that",
        "# resolves the name elsewhere is not held to this library's ABI.",
        "# Every binding is listed, which is what holds the manifest and the",
        "# headers in step.",
        "",
    ] + body
    out = Path(args.out) if args.out else REPO / "libc" / "versions" / f"elf-{args.arch}.txt"
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text("\n".join(text).rstrip("\n") + "\n")
    print(f"{out}: {sum(1 for l in body if l and not l.startswith('['))} symbols")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
