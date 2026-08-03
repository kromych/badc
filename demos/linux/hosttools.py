#!/usr/bin/env python3
"""Host-tool translation-unit sweep for badc.

The kernel build produces a set of ordinary hosted C programs (dependency
scanner, module post-processor, table sorters, object validator, config
front-ends) before it compiles any kernel code. They are plain POSIX
programs, so unlike the kernel units they can also be linked and run.

This replays the reference build's host compile commands against badc, one
unit at a time, and with --link relinks each fully-compiled tool using the
reference build's own link command so the result can be exercised against
its reference-built twin.

The kernel sweep (sweep.py) skips these directories; this is the other
half. Prerequisite: a completed reference build in the tree.
"""

from __future__ import annotations

import argparse
import json
import os
import subprocess
import sys
from concurrent.futures import ThreadPoolExecutor
from dataclasses import dataclass, field
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from sweep import (  # noqa: E402
    TARGETS,
    host_arch,
    parse_cmd_file,
    resolve_badc,
    rewrite,
    signature,
)

LINUX_DIR = Path(__file__).resolve().parent

# Dependency-file generation on the link line would write into the source
# tree, which the sweep treats as read-only.
DEPFILE_ARG = {"-MF", "-MT", "-MQ"}


def log(m: str) -> None:
    print(f"host tools: {m}", flush=True)


@dataclass
class Unit:
    key: str          # unique per badc invocation
    tool: str         # recorded output the unit contributes to
    cwd: str          # directory the recorded command ran in
    src: str          # source path, relative to cwd
    argv: list[str]   # the recorded compiler command
    one_step: bool    # compile and link in a single command


@dataclass
class Tool:
    out: str
    cwd: str
    link: list[str] | None = None
    units: list[Unit] = field(default_factory=list)


def is_cc(argv: list[str]) -> bool:
    """True when the recorded command drives a C compiler. Generated
    sources are recorded the same way (`sed`, `bison`, a just-built
    generator) with a .c file on the command line, so the tool name is
    what separates a compile from a code generator."""
    if not argv:
        return False
    name = Path(argv[0]).name
    stem = name.split("-")[-1].split(".")[0]
    return stem.rstrip("0123456789") in ("gcc", "cc", "clang", "g", "")


def host_sources(argv: list[str]) -> list[str]:
    """The C sources of a host compile, or []. Kernel units carry
    -D__KERNEL__, host programs never do."""
    if "-D__KERNEL__" in argv or not is_cc(argv):
        return []
    return [a for a in argv[1:] if a.endswith(".c") and not a.startswith("-")]


def build_dir(kdir: Path, objdir: Path, src: str) -> Path | None:
    """The directory the recorded command ran in. Kbuild descends into a
    tool's own Makefile (objtool, libsubcmd), so its sources and -I paths
    are relative to that subtree root rather than the kernel root: take
    the deepest ancestor of the output's directory in which the recorded
    source path resolves."""
    d = objdir
    while True:
        if (d / src).is_file():
            return d
        if d == kdir:
            return None
        d = d.parent


def collect(kdir: Path) -> tuple[list[Unit], dict[str, Tool]]:
    units: list[Unit] = []
    links: dict[str, list[str]] = {}
    for root, _dirs, files in os.walk(kdir):
        for f in files:
            if not (f.startswith(".") and f.endswith(".cmd")):
                continue
            argv = parse_cmd_file(Path(root) / f)
            if argv is None:
                continue
            out = os.path.relpath(Path(root) / f[1:-4], kdir)
            srcs = host_sources(argv)
            if not srcs:
                # A link or partial-link step of a multi-object host tool:
                # keep the command so the badc objects can be relinked
                # with it, and record which objects it consumes.
                if any(a.endswith(".o") for a in argv):
                    links[out] = argv
                continue
            one_step = "-c" not in argv
            if not one_step and len(srcs) != 1:
                continue
            for src in srcs:
                cwd = build_dir(kdir, Path(root), src)
                if cwd is None:
                    continue
                key = out + (":" + src if one_step else "")
                units.append(Unit(key, out, str(cwd), src, argv, one_step))
    units.sort(key=lambda u: u.key)

    # object path -> the step that consumes it. Kbuild records absolute
    # paths in some sub-builds, kernel-root-relative ones elsewhere, so
    # take whichever spelling names a file that exists.
    owner: dict[str, str] = {}
    for out, argv in links.items():
        base = (kdir / out).parent
        for a in argv:
            if not a.endswith(".o"):
                continue
            for cand in (Path(a), kdir / a, base / a):
                p = os.path.normpath(str(cand))
                if os.path.exists(p):
                    owner.setdefault(p, out)
                    break

    tools: dict[str, Tool] = {}
    for u in units:
        if u.one_step:
            t = tools.setdefault(u.tool, Tool(u.tool, u.cwd, u.argv))
        else:
            step = owner.get(os.path.normpath(str(kdir / u.tool)))
            if step is None:
                continue
            t = tools.setdefault(step, Tool(step, u.cwd, links[step]))
        t.units.append(u)
    return units, tools


def link_line(tool: Tool, objs: dict[str, str], out: str) -> list[str]:
    """The recorded link command with the reference inputs replaced by the
    badc-built objects and the output redirected."""
    new: list[str] = []
    skip = False
    for i, a in enumerate(tool.link or []):
        if skip:
            skip = False
            continue
        if a == "-o":
            new += ["-o", out]
            skip = True
        elif a in DEPFILE_ARG:
            skip = True
        elif a.startswith("-Wp,-MMD") or a.startswith("-Wp,-MD") or a in ("-MD", "-MMD"):
            continue
        elif a in objs:
            new.append(objs[a])
        elif a.endswith(".o") and Path(a).name in objs:
            new.append(objs[Path(a).name])
        else:
            new.append(a)
    return new


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--kernel-dir", type=Path, required=True)
    ap.add_argument("--arch", choices=sorted(TARGETS), default=host_arch())
    ap.add_argument("--badc")
    ap.add_argument("-j", "--jobs", type=int, default=os.cpu_count() or 4)
    ap.add_argument("--timeout", type=float, default=180.0)
    ap.add_argument("--json", type=Path, help="write the per-unit results here")
    ap.add_argument("--link", action="store_true",
                    help="relink every tool whose units all compiled")
    args = ap.parse_args(argv)

    badc = resolve_badc(args.badc)
    kdir = args.kernel_dir.resolve()
    if not (kdir / "Makefile").is_file():
        sys.exit(f"host tools: {kdir} is not a kernel tree")
    target = TARGETS[args.arch]
    units, tools = collect(kdir)
    if not units:
        sys.exit("host tools: no host compile commands found")

    scratch = LINUX_DIR / ".work" / f"hosttools-{args.arch}"
    scratch.mkdir(parents=True, exist_ok=True)
    log(f"badc={badc} target={target} units={len(units)} "
        f"tools={len(tools)} jobs={args.jobs}")

    def run_one(u: Unit) -> dict:
        out = scratch / (u.key.replace(os.sep, "_").replace(":", "__"))
        if not out.name.endswith(".o"):
            out = out.with_suffix(out.suffix + ".o")
        cmd = [str(badc), "--gnu", "-q", "-c", f"--target={target}",
               "-o", str(out), *rewrite(u.argv), u.src]
        try:
            r = subprocess.run(cmd, cwd=u.cwd, capture_output=True, text=True,
                               timeout=args.timeout)
            rc, err = r.returncode, r.stderr
        except subprocess.TimeoutExpired:
            rc, err = 900, f"timeout after {args.timeout:.0f}s"
        return {"key": u.key, "tool": u.tool, "src": u.src, "cwd": u.cwd,
                "ok": rc == 0, "obj": str(out),
                "sig": "" if rc == 0 else signature(rc, err),
                "err": "" if rc == 0 else err[:2000]}

    with ThreadPoolExecutor(max_workers=args.jobs) as pool:
        results = list(pool.map(run_one, units))
    by_key = {r["key"]: r for r in results}

    ok = [r for r in results if r["ok"]]
    log(f"compiled {len(ok)}/{len(results)} units")
    buckets: dict[str, list[str]] = {}
    for r in results:
        if not r["ok"]:
            buckets.setdefault(r["sig"], []).append(r["src"])
    for sig, srcs in sorted(buckets.items(), key=lambda kv: -len(kv[1])):
        log(f"  {len(srcs):3d}  {sig}")
        for s in sorted(srcs)[:8]:
            log(f"         {s}")

    whole = [t for t in tools.values()
             if t.units and all(by_key[u.key]["ok"] for u in t.units)]
    log(f"tools fully compiled: {len(whole)}/{len(tools)}")
    for t in sorted(tools.values(), key=lambda t: t.out):
        if t not in whole:
            log(f"  incomplete {t.out}")

    links: list[dict] = []
    if args.link:
        for t in sorted(whole, key=lambda t: t.out):
            if not t.link:
                continue
            objs = {}
            for u in t.units:
                objs[u.src] = by_key[u.key]["obj"]
                objs[Path(u.tool).name] = by_key[u.key]["obj"]
            out = str(scratch / Path(t.out).name)
            cmd = link_line(t, objs, out)
            r = subprocess.run(cmd, cwd=t.cwd, capture_output=True, text=True)
            links.append({"tool": t.out, "path": out, "ok": r.returncode == 0,
                          "ref": str(kdir / t.out), "err": r.stderr[:2000]})
            log(f"  link {'ok  ' if r.returncode == 0 else 'FAIL'} {t.out}")
            if r.returncode != 0:
                log(f"       {r.stderr.strip().splitlines()[:2]}")

    if args.json:
        args.json.write_text(json.dumps(
            {"arch": args.arch, "compiled": len(ok), "total": len(results),
             "tools": len(tools), "tools_complete": len(whole),
             "units": results, "links": links}, indent=1))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
