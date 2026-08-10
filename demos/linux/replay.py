#!/usr/bin/env python3
"""Replay one kernel translation unit's recorded compile against a badc build.

Kbuild records the exact command it ran for every object in a ``.<name>.o.cmd``
file next to it. This replays those commands as recorded -- same shim, same
flags, same working directory -- against one or more badc binaries, and states
what the resulting object's undefined symbols must be.

As recorded is the point. sweep.py rewrites each command into badc's own flag
set, which answers "can badc compile this unit at all"; this answers "does the
object the build would have produced hold what it should", and whether a defect
appears at all can turn on any flag in the recorded set. Only the two output
destinations move, and only so the tree is not written (below).

The shape it exists for is a statically dead call to a declared-but-undefined
symbol -- how the kernel spells a build-time assertion (``__compiletime_assert_*``,
``__scoped_seqlock_bug``, ``__bad_udelay``). The compiler is meant to delete the
call; when a fold stops firing the symbol reaches the object, and nothing says so
until the final vmlinux link ten minutes later. ``--forbid`` states it directly,
against any symbol -- the assertion is the tool's subject, not a fixed list of
units:

    python3 demos/linux/replay.py --kernel-dir <tree> \\
        --unit fs/proc/array.o --forbid __scoped_seqlock_bug

Repeat ``--badc`` to put several compilers over the same unit, which is what
bisecting an emitted-code regression needs; each is a row of the report:

    python3 demos/linux/replay.py --kernel-dir <tree> --match generic_pt \\
        --forbid __compiletime_assert_73 --badc a/badc --badc b/badc

``--require`` guards against a vacuous pass: a unit that failed to compile, or
one whose call went away because everything around it did, satisfies ``--forbid``
for the wrong reason. With neither, the run reports each object's undefined
symbols and asserts nothing.

The tree is not written. The recorded command names its object and its
dependency file inside the tree; both are redirected into --workdir, and every
other argument reaches the compiler as recorded. That isolation is not
housekeeping: compiling into a tree a build is using swaps one object under that
build, and the result is a plausible wrong number rather than an error -- a link
reporting failures that belong to the compiler under test rather than the one
being measured.

Prerequisite: a completed build in the tree. A .cmd file exists only for an
object the tree has already built.
"""

from __future__ import annotations

import argparse
import os
import subprocess
import sys
import tempfile
from pathlib import Path

import sweep

LINUX_DIR = Path(__file__).resolve().parent
DEP_PREFIX = ("-Wp,-MMD,", "-Wp,-MD,")


def log(m: str) -> None:
    print(f"linux replay: {m}", flush=True)


def cmd_file(tree: Path, obj: str) -> Path:
    """The .cmd file kbuild wrote next to `obj`."""
    p = Path(obj)
    return tree / p.parent / f".{p.name}.cmd"


def select(tree: Path, units: list[str], match: list[str]) -> list[str]:
    """Kernel-relative object paths: those named outright, plus every
    recorded object whose path contains one of the `match` substrings."""
    out = list(units)
    if match:
        for root, dirs, files in os.walk(tree):
            if os.path.relpath(root, tree).split(os.sep, 1)[0] in sweep.SKIP_DIRS:
                dirs[:] = []
                continue
            for f in files:
                if not (f.startswith(".") and f.endswith(".o.cmd")):
                    continue
                rel = os.path.relpath(os.path.join(root, f[1:-4]), tree)
                if any(m in rel for m in match):
                    out.append(rel)
    return sorted(dict.fromkeys(out))


def redirect(argv: list[str], workdir: Path, obj: str) -> tuple[list[str], Path]:
    """`argv` with its object and dependency file moved into `workdir`, and
    the shim replaced by this checkout's. Every other argument is left as
    recorded. The shim is the harness rather than part of the unit's flags,
    and the recorded path names whichever checkout ran the build."""
    argv = list(argv)
    out_obj = workdir / Path(obj).name
    dep = str(workdir / (Path(obj).name + ".d"))
    try:
        argv[argv.index("-o") + 1] = str(out_obj)
    except (ValueError, IndexError):
        return [], out_obj
    argv[0] = str(LINUX_DIR / "buildcc.py")
    for i, a in enumerate(argv):
        if a.startswith(DEP_PREFIX):
            argv[i] = a[: a.index(",", 4) + 1] + dep
        elif a == "-MF" and i + 1 < len(argv):
            argv[i + 1] = dep
    return argv, out_obj


def undefined(nm: str, obj: Path) -> set[str]:
    """Undefined symbol names in `obj`, weak references included."""
    r = subprocess.run([nm, "--undefined-only", str(obj)],
                       capture_output=True, text=True)
    return {ln.split()[-1] for ln in r.stdout.splitlines() if ln.split()}


def replay(tree: Path, badc: Path, argv: list[str], workdir: Path, obj: str,
           target: str, real_cc: str, timeout: float) -> tuple[Path | None, str]:
    """Run one recorded command with `badc` behind the shim. Returns the
    object it produced, or None and a diagnostic."""
    argv, out_obj = redirect(argv, workdir, obj)
    if not argv:
        return None, "recorded command names no object"
    out_obj.unlink(missing_ok=True)
    env = dict(os.environ)
    env.update(BADC=str(badc), BADC_TARGET=target, BADC_REAL_CC=real_cc,
               BADC_MANIFEST=str(workdir / "manifest.txt"),
               BADC_TIMEOUT=str(int(timeout)))
    env.pop("BADC_FALLBACK", None)
    try:
        r = subprocess.run(argv, cwd=tree, env=env, capture_output=True,
                           text=True, timeout=timeout)
    except subprocess.TimeoutExpired:
        return None, f"timeout after {timeout:.0f}s"
    if not out_obj.is_file():
        lines = [ln for ln in r.stderr.splitlines() if ln.strip()]
        return None, next((ln for ln in lines if "error" in ln),
                          lines[-1] if lines else f"exit {r.returncode}")
    return out_obj, ""


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--kernel-dir", type=Path, required=True,
                    help="kernel tree with a completed build")
    ap.add_argument("--unit", action="append", default=[], metavar="OBJ",
                    help="kernel-relative object path (repeatable)")
    ap.add_argument("--match", action="append", default=[], metavar="SUBSTR",
                    help="replay every recorded object whose path contains "
                         "this (repeatable)")
    ap.add_argument("--badc", action="append", default=[], metavar="PATH",
                    help="badc binary (repeatable; default: $BADC or "
                         "target/release/badc)")
    ap.add_argument("--forbid", action="append", default=[], metavar="SYM",
                    help="fail if the object references SYM (repeatable)")
    ap.add_argument("--require", action="append", default=[], metavar="SYM",
                    help="fail if it does not (repeatable); guards against a "
                         "unit that satisfies --forbid by not compiling")
    ap.add_argument("--arch", choices=sorted(sweep.TARGETS),
                    default=sweep.host_arch())
    ap.add_argument("--real-cc", default=os.environ.get("BADC_REAL_CC", "gcc"))
    ap.add_argument("--nm", default="nm", help="nm for reading the object")
    ap.add_argument("--timeout", type=float, default=600.0,
                    help="seconds per unit")
    ap.add_argument("--workdir", type=Path,
                    help="where the objects go (default: a temporary "
                         "directory); never the kernel tree")
    args = ap.parse_args(argv)

    tree = args.kernel_dir.resolve()
    if not (tree / "Makefile").is_file():
        sys.exit(f"linux replay: {tree} is not a kernel tree")
    if not args.unit and not args.match:
        sys.exit("linux replay: name a unit with --unit or --match")
    badcs = [sweep.resolve_badc(b) for b in (args.badc or [None])]
    units = select(tree, args.unit, args.match)
    if not units:
        sys.exit("linux replay: no unit matched")

    with tempfile.TemporaryDirectory() as td:
        workdir = args.workdir.resolve() if args.workdir else Path(td)
        # Checked before it is created: the point of the directory is that
        # the run writes nothing into the tree.
        if workdir == tree or tree in workdir.parents:
            sys.exit(f"linux replay: --workdir {workdir} is inside the tree")
        workdir.mkdir(parents=True, exist_ok=True)
        failures = 0
        for obj in units:
            recorded = sweep.parse_cmd_file(cmd_file(tree, obj))
            if recorded is None:
                log(f"{obj}: no recorded command (was it built?)")
                failures += 1
                continue
            for badc in badcs:
                out, why = replay(tree, badc, recorded, workdir, obj,
                                  sweep.TARGETS[args.arch], args.real_cc,
                                  args.timeout)
                tag = f"{obj} [{badc.name}]" if len(badcs) > 1 else obj
                if out is None:
                    log(f"{tag}: FAIL did not compile: {why}")
                    failures += 1
                    continue
                syms = undefined(args.nm, out)
                bad = [s for s in args.forbid if s in syms]
                missing = [s for s in args.require if s not in syms]
                if bad or missing:
                    failures += 1
                    detail = ", ".join(
                        [f"references {s}" for s in bad]
                        + [f"does not reference {s}" for s in missing])
                    log(f"{tag}: FAIL {detail}")
                elif args.forbid or args.require:
                    log(f"{tag}: ok")
                else:
                    log(f"{tag}: {len(syms)} undefined: "
                        f"{' '.join(sorted(syms))}")
    if failures:
        log(f"FAIL: {failures} of {len(units) * len(badcs)} replays")
    return 1 if failures else 0


if __name__ == "__main__":
    raise SystemExit(main())
