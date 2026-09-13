#!/usr/bin/env python3
"""Regenerate `libc/include/sys/syscall.h` from the Linux tree `demos/linux/setup.py` pins.

Each Linux target gets the numbers of the kernel's user-space `asm/unistd_64.h`
as `__NR_<name>` and `SYS_<name>`. The table and its ABI set are read from the
tree: `scripts/Makefile.asm-headers` and the `arch/arm64/kernel/Makefile.syscalls`
it includes for aarch64, the `unistd_64.h` rule of `arch/x86/entry/syscalls/Makefile`
for x86_64.

    python3 demos/linux/setup.py --fetch-only
    tar -xJf "$(python3 demos/linux/setup.py --print-tarball)" -C "$TMPDIR"
    scripts/gen_syscall_header.py "$TMPDIR/linux-<version>"
"""

from __future__ import annotations

import argparse
import re
import sys
from collections import Counter
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
HEADER = REPO / "libc" / "include" / "sys" / "syscall.h"
sys.path.insert(0, str(REPO / "demos" / "linux"))
import setup  # noqa: E402

ASSIGN = re.compile(r"^(?:(\S+)\s*:\s*)?([A-Za-z0-9_-]+)\s*(\+=|:=|\?=|=)\s*(.*)$")
INCLUDE = re.compile(r"^-?include\s+(.+)$")
VAR = re.compile(r"\$\(([A-Za-z0-9_-]+)\)")


def die(msg: str) -> None:
    sys.exit(f"gen_syscall_header: {msg}")


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
        m = INCLUDE.match(line)
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


def tree_version(tree: Path) -> str:
    head: dict[str, str] = {}
    for key, value in re.findall(r"(?m)^(VERSION|PATCHLEVEL|SUBLEVEL|EXTRAVERSION) =[ \t]*(.*)$",
                                 read(tree, "Makefile")):
        head.setdefault(key, value.strip())
    sub = f".{head['SUBLEVEL']}" if head.get("SUBLEVEL", "0") != "0" else ""
    return f"{head['VERSION']}.{head['PATCHLEVEL']}{sub}{head.get('EXTRAVERSION', '')}"


def render(version: str, arches: list[tuple[str, str, list[str], list[tuple[int, str]]]]) -> str:
    out = [
        "#pragma once",
        "",
        "// Linux system call numbers as __NR_<name> and SYS_<name>, one table per",
        f"// architecture. Generated by scripts/gen_syscall_header.py from Linux {version}.",
    ]
    out += [f"//   {arch}: {table}, ABIs {' '.join(abis)}" for arch, table, abis, _ in arches]
    out += ["", "#ifdef __linux__", '#pragma dylib(libc, "libc.so.6")',
            '#pragma binding(libc::syscall, "syscall")']
    for i, (arch, _, _, entries) in enumerate(arches):
        w = max(len(name) for _, name in entries)
        out += ["", f"#{'elif' if i else 'if'} defined(__{arch}__)"]
        out += [f"#define __NR_{name:<{w}} {nr}" for nr, name in entries]
        out += [f"#define SYS_{name:<{w + 1}} __NR_{name}" for _, name in entries]
    out += ["#endif", "", "long syscall(long number, ...);", "#endif", ""]
    return "\n".join(out)


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("tree", type=Path, help="extracted kernel source tree")
    ap.add_argument("--check", action="store_true",
                    help="compare with the committed header instead of writing it")
    args = ap.parse_args(argv)
    version, pinned = tree_version(args.tree), setup.DEFCONFIG_KERNEL[0]
    if version != pinned:
        die(f"{args.tree} is Linux {version}; demos/linux/setup.py pins {pinned}")
    arches = []
    for arch, derive in (("aarch64", arm64), ("x86_64", x86_64)):
        table, abis = derive(args.tree)
        entries = rows(args.tree, table, abis)
        real = (args.tree / table).resolve().relative_to(args.tree.resolve())
        arches.append((arch, str(real), abis, entries))
        via = f" via {table}" if str(real) != table else ""
        print(f"{arch}: {real}{via}, ABIs {','.join(abis)}: {len(entries)} names")
    text = render(version, arches)
    if args.check:
        if HEADER.read_text() != text:
            die(f"{HEADER.relative_to(REPO)} differs from the tables of Linux {version}")
        return 0
    HEADER.write_text(text)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
