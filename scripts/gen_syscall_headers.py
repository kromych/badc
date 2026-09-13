#!/usr/bin/env python3
"""Regenerate the bundled Linux system call headers from the tree `demos/linux/setup.py` pins.

`libc/include/asm/unistd.h` gets, per Linux target, the numbers of the kernel's
user-space `asm/unistd_64.h` as `__NR_<name>` and the macros the architecture's
uapi `asm/unistd.h` defines itself; `libc/include/sys/syscall.h` includes it and
defines `SYS_<name>` for each number. The table and its ABI set are read from the
tree: `scripts/Makefile.asm-headers` and the `arch/arm64/kernel/Makefile.syscalls`
it includes for aarch64, the `unistd_64.h` rule of `arch/x86/entry/syscalls/Makefile`
for x86_64.

    python3 demos/linux/setup.py --fetch-only
    tar -xJf "$(python3 demos/linux/setup.py --print-tarball)" -C "$TMPDIR"
    scripts/gen_syscall_headers.py "$TMPDIR/linux-<version>"
"""

from __future__ import annotations

import argparse
import re
import sys
from collections import Counter
from pathlib import Path
from typing import NamedTuple

REPO = Path(__file__).resolve().parent.parent
ASM_UNISTD = REPO / "libc" / "include" / "asm" / "unistd.h"
SYS_SYSCALL = REPO / "libc" / "include" / "sys" / "syscall.h"
sys.path.insert(0, str(REPO / "demos" / "linux"))
import setup  # noqa: E402

ASSIGN = re.compile(r"^(?:(\S+)\s*:\s*)?([A-Za-z0-9_-]+)\s*(\+=|:=|\?=|=)\s*(.*)$")
MAKE_INCLUDE = re.compile(r"^-?include\s+(.+)$")
VAR = re.compile(r"\$\(([A-Za-z0-9_-]+)\)")
DIRECTIVE = re.compile(r"^\s*#\s*(\w+)\s*(.*?)\s*$")
DEFINE = re.compile(r"^(\w+)(\(?)\s*(.*)$")


class Arch(NamedTuple):
    name: str
    table: str
    abis: list[str]
    entries: list[tuple[int, str]]
    macros: list[tuple[str, str]]


def die(msg: str) -> None:
    sys.exit(f"gen_syscall_headers: {msg}")


def read(tree: Path, path: str) -> str:
    if not (tree / path).is_file():
        die(f"{tree} has no {path}")
    return (tree / path).read_text()


def logical_lines(text: str) -> list[str]:
    """Continuations joined, comments and recipe lines dropped."""
    out = []
    for line in text.replace("\\\n", " ").splitlines():
        line = "" if line.startswith("\t") else line.split("#", 1)[0].strip()
        if line:
            out.append(line)
    return out


def expand(text: str, env: dict[str, str]) -> str:
    prev = None
    while prev != text:
        prev, text = text, VAR.sub(lambda m: env.get(m.group(1), m.group(0)), text)
    return text


def resolved(text: str, env: dict[str, str], what: str) -> str:
    """`text` expanded; a function or an unknown variable left in it is refused."""
    out = expand(text, env)
    if not out.strip() or "$(" in out:
        die(f"{what} does not evaluate: {text!r}")
    return out


def assign(env: dict[str, str], name: str, op: str, value: str) -> None:
    if op == "+=" and name in env:
        env[name] = f"{env[name]} {value}".strip()
    elif op != "?=" or name not in env:
        env[name] = value


def evaluate(tree: Path, path: str, env: dict[str, str], names: set[str]) -> None:
    """Apply the global assignments to `names` in `path` and, in reading order,
    in each included file of the tree."""
    for line in logical_lines(read(tree, path)):
        m = MAKE_INCLUDE.match(line)
        if m:
            for word in expand(m.group(1), env).split():
                if "$(" not in word and (tree / word).is_file():
                    evaluate(tree, str(Path(word)), env, names)
            continue
        m = ASSIGN.match(line)
        if m and m.group(1) is None and m.group(2) in names:
            assign(env, m.group(2), m.group(3), m.group(4))


def require(text: str, path: str, *needles: str) -> None:
    for needle in needles:
        if needle not in text:
            die(f"{path} no longer contains {needle!r}; the derivation needs review")


def arm64(tree: Path) -> tuple[str, list[str]]:
    path, kbuild = "scripts/Makefile.asm-headers", "arch/arm64/include/uapi/asm/Kbuild"
    require(read(tree, path), path, "$(obj)/unistd_%.h: $(syscalltbl)",
            "--abis $(subst $(space),$(comma),$(strip $(syscall_abis_$*)))")
    # The top-level Makefile runs `path` with obj=arch/arm64/include/generated/uapi/asm.
    env = {"srctree": ".", "SRCARCH": "arm64", "kbuild-file": kbuild}
    evaluate(tree, path, env, {"syscalltbl", "syscall_abis_64"})
    generated: dict[str, str] = {}
    evaluate(tree, kbuild, generated, {"syscall-y"})
    if "unistd_64.h" not in generated.get("syscall-y", "").split():
        die(f"{kbuild} does not generate unistd_64.h")
    table = resolved(env.get("syscalltbl", ""), env, f"{path}: syscalltbl")
    abis = resolved(env.get("syscall_abis_64", ""), env, f"{path}: syscall_abis_64")
    return table.replace("%", "64"), abis.replace(",", " ").split()


def x86_64(tree: Path) -> tuple[str, list[str]]:
    path, target = "arch/x86/entry/syscalls/Makefile", "$(uapi)/unistd_64.h"
    text = read(tree, path)
    require(text, path, "--abis $(abis)")
    env = {"srctree": ".", "SRCARCH": "x86", "src": "arch/x86/entry/syscalls"}
    local: dict[str, str] = {}
    prereq = ""
    for line in logical_lines(text):
        m = ASSIGN.match(line)
        if m and m.group(1) in (None, target):
            assign(env if m.group(1) is None else local, *m.group(2, 3, 4))
        elif not m and not prereq and line.startswith(f"{target}:"):
            prereq = line[len(target) + 1:].split()[0]
    table = resolved(prereq, env, f"{path}: {target} table")
    abis = resolved(local.get("abis", ""), env, f"{path}: {target} abis")
    return table, abis.replace(",", " ").split()


def rows(tree: Path, table: str, abis: list[str]) -> list[tuple[int, str]]:
    out, used = [], set()
    for n, line in enumerate(read(tree, table).splitlines(), 1):
        f = line.split("#", 1)[0].split()
        if f and (len(f) < 3 or not f[0].isdigit()):
            die(f"{table}:{n}: not a table row: {line!r}")
        if f and f[1] in abis:
            out.append((int(f[0]), f[2]))
            used.add(f[1])
    if set(abis) - used:
        die(f"{table}: ABIs {sorted(set(abis) - used)} select no row")
    for i, what in ((0, "number"), (1, "name")):
        dup = sorted(k for k, c in Counter(r[i] for r in out).items() if c > 1)
        if dup:
            die(f"{table}: ABIs {abis} select one {what} twice: {dup}")
    return out


def uapi_macros(tree: Path, srcarch: str) -> list[tuple[str, str]]:
    """The object-like macros the architecture's uapi `asm/unistd.h` defines
    outside every conditional but its include guard."""
    path = f"arch/{srcarch}/include/uapi/asm/unistd.h"
    text = re.sub(r"/\*.*?\*/", " ", read(tree, path), flags=re.S)
    lines = [m.groups() for m in map(DIRECTIVE.match, text.splitlines()) if m]
    guard = lines[0][1] if lines[:1] and lines[0][0] == "ifndef" else None
    guard = guard if ("define", guard) in lines[1:2] else None
    out, depth = [], 0
    for kind, rest in lines:
        if kind in ("if", "ifdef", "ifndef"):
            depth += 1
        elif kind == "endif":
            depth -= 1
        elif kind == "define" and rest != guard:
            m = DEFINE.match(rest)
            if not m or m.group(2) or depth != int(guard is not None):
                die(f"{path}: `#define {rest}` is not an unconditional object-like macro")
            out.append((m.group(1), m.group(3)))
    return out


def render_asm(version: str, arches: list[Arch]) -> str:
    out = [
        "#pragma once",
        "",
        "// Linux system call numbers, __NR_<name>, and the other macros of the kernel's",
        "// user-space <asm/unistd.h>, one table per architecture. Generated by",
        f"// scripts/gen_syscall_headers.py from Linux {version}.",
    ]
    out += [f"//   {a.name}: {a.table}, ABIs {' '.join(a.abis)}" for a in arches]
    out += ["", "#ifdef __linux__"]
    for i, a in enumerate(arches):
        defs = a.macros + [(f"__NR_{name}", str(nr)) for nr, name in a.entries]
        w = max(len(name) for name, _ in defs)
        out.append(f"#{'elif' if i else 'if'} defined(__{a.name}__)")
        out += [f"#define {name:<{w}} {value}".rstrip() for name, value in defs]
    out += ["#endif", "#endif", ""]
    return "\n".join(out)


def render_syscall(version: str, arches: list[Arch]) -> str:
    out = [
        "#pragma once",
        "",
        "// SYS_<name> for each system call number <asm/unistd.h> defines. Generated by",
        f"// scripts/gen_syscall_headers.py from Linux {version}.",
        "",
        "#ifdef __linux__",
        "#include <asm/unistd.h>",
        '#pragma dylib(libc, "libc.so.6")',
        '#pragma binding(libc::syscall, "syscall")',
        "",
    ]
    for name in sorted({name for a in arches for _, name in a.entries}):
        out += [f"#ifdef __NR_{name}", f"#define SYS_{name} __NR_{name}", "#endif"]
    out += ["", "long syscall(long number, ...);", "#endif", ""]
    return "\n".join(out)


def tree_version(tree: Path) -> str:
    head: dict[str, str] = {}
    for key, value in re.findall(r"(?m)^(VERSION|PATCHLEVEL|SUBLEVEL|EXTRAVERSION) =[ \t]*(.*)$",
                                 read(tree, "Makefile")):
        head.setdefault(key, value.strip())
    sub = f".{head['SUBLEVEL']}" if head.get("SUBLEVEL", "0") != "0" else ""
    return f"{head['VERSION']}.{head['PATCHLEVEL']}{sub}{head.get('EXTRAVERSION', '')}"


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("tree", type=Path, help="extracted kernel source tree")
    ap.add_argument("--check", action="store_true",
                    help="compare with the committed headers instead of writing them")
    args = ap.parse_args(argv)
    version, pinned = tree_version(args.tree), setup.DEFCONFIG_KERNEL[0]
    if version != pinned:
        die(f"{args.tree} is Linux {version}; demos/linux/setup.py pins {pinned}")
    arches = []
    for name, srcarch, derive in (("aarch64", "arm64", arm64), ("x86_64", "x86", x86_64)):
        table, abis = derive(args.tree)
        entries = rows(args.tree, table, abis)
        macros = uapi_macros(args.tree, srcarch)
        clash = sorted({m for m, _ in macros} & {f"__NR_{e}" for _, e in entries})
        if clash:
            die(f"arch/{srcarch}/include/uapi/asm/unistd.h defines table names: {clash}")
        real = str((args.tree / table).resolve().relative_to(args.tree.resolve()))
        via = f" via {table}" if real != table else ""
        print(f"{name}: {real}{via}, ABIs {','.join(abis)}: {len(entries)} names, "
              f"uapi macros {[m for m, _ in macros]}")
        arches.append(Arch(name, real, abis, entries, macros))
    outputs = {ASM_UNISTD: render_asm(version, arches), SYS_SYSCALL: render_syscall(version, arches)}
    if args.check:
        stale = [str(p.relative_to(REPO)) for p, text in outputs.items()
                 if not p.is_file() or p.read_text() != text]
        if stale:
            die(f"{', '.join(stale)} differ from the tables of Linux {version}")
        return 0
    for path, text in outputs.items():
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(text)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
