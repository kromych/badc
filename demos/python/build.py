#!/usr/bin/env python3
"""Build CPython 3.14.6 with badc for a target, with no make/configure at build
time. The per-target derived sources a host configure/make would generate --
pyconfig.h, Modules/config.c (the builtin inittab), and the translation-unit
manifest -- are committed under ``targets/<target>/``; the frozen-module headers
come from ``setup.py``. One command for every target.

    python3 demos/python/build.py --target=macos-aarch64 --test

Replaces the configure+make host build (smoke.py) and win_build.py as targets
are ported; pass --target or set BADC_PY_TARGET.
"""

from __future__ import annotations

import argparse
import os
import shutil
import subprocess
import sys
from concurrent.futures import ProcessPoolExecutor
from pathlib import Path

PY_DIR = Path(__file__).resolve().parent
REPO_ROOT = PY_DIR.parents[1]
VERSION = "3.14.6"
SRC = PY_DIR / ".cache" / f"Python-{VERSION}"

# Tier 1: a fast module slice every lane must clear. Tier 2 (a broader set + a
# pyperformance subset) runs only if tier 1 passes. TODO: add tier 2.
TEST_SLICE = [
    "test_grammar", "test_builtin", "test_int", "test_float",
    "test_list", "test_dict", "test_string", "test_exceptions",
]

POSIX_INCLUDES = ["Include", "Include/internal", "."]
EXPORT_FLAGS = ["--export-all", "--export-data"]


def _posix_defines(platform: str, multiarch: str, soabi: str) -> dict:
    # The macros a host configure bakes into these specific TUs: the platform
    # identity, the install layout getpath resolves, and the build-info strings.
    return {
        "Python/getplatform.c": [f'PLATFORM="{platform}"'],
        "Python/sysmodule.c": ['ABIFLAGS=""', f'MULTIARCH="{multiarch}"'],
        "Python/dynload_shlib.c": [f'SOABI="{soabi}"'],
        "Modules/getpath.c": [
            'PREFIX="/usr/local"', 'EXEC_PREFIX="/usr/local"', 'PLATLIBDIR="lib"',
            'VERSION="3.14"', 'VPATH=""', 'PYTHONPATH=""', 'PYTHONFRAMEWORK=""',
        ],
        "Modules/getbuildinfo.c": ['GITVERSION=""', 'GITTAG=""', 'GITBRANCH=""'],
    }


# Per-target build configuration. The manifest's per-TU core/builtin class
# selects Py_BUILD_CORE vs Py_BUILD_CORE_BUILTIN; extra_defines carries the few
# target-specific macros a host build injects; asm_trampoline substitutes the
# portable trampoline for the hand-written .S a host build assembles.
TARGETS = {
    "macos-aarch64": {
        "includes": POSIX_INCLUDES,
        "extra_defines": _posix_defines("darwin", "darwin", "cpython-314-darwin"),
        "link_flags": EXPORT_FLAGS,
    },
    "linux-x64": {
        "includes": POSIX_INCLUDES,
        "extra_defines": _posix_defines("linux", "x86_64-linux-gnu", "cpython-314-x86_64-linux-gnu"),
        "asm_trampoline": True,
        "link_flags": EXPORT_FLAGS,
    },
    "linux-aarch64": {
        "includes": POSIX_INCLUDES,
        "extra_defines": _posix_defines("linux", "aarch64-linux-gnu", "cpython-314-aarch64-linux-gnu"),
        "asm_trampoline": True,
        "link_flags": EXPORT_FLAGS,
    },
}


def run(cmd, **kw):
    return subprocess.run(cmd, capture_output=True, text=True, **kw)


def _compile_one(job):
    """Compile one TU. Runs in a worker process, so the args are plain and
    picklable. Returns (src, obj-path-or-None, error-or-None)."""
    badc, target, src, cls, inc, extra, dbg, opt, out_dir, src_root = job
    obj = os.path.join(out_dir, src.replace("/", "_")[:-2] + ".o")
    core = "Py_BUILD_CORE_BUILTIN" if cls == "builtin" else "Py_BUILD_CORE"
    defs = [f"-D{core}"] + [f"-D{d}" for d in extra]
    cmd = [badc, "--gnu", "-c", f"--target={target}", "-UHAVE_GCC_UINT128_T",
           *dbg, *opt, *defs, *inc, src, "-o", obj]
    r = subprocess.run(cmd, cwd=src_root, capture_output=True, text=True, timeout=240)
    if r.returncode != 0:
        msg = ((r.stderr or r.stdout).strip().splitlines() or [f"rc{r.returncode}"])[-1]
        return (src, None, msg[:160])
    return (src, obj, None)


def badc_path() -> str:
    name = "badc.exe" if os.name == "nt" else "badc"
    p = REPO_ROOT / "target" / "release" / name
    if not p.is_file():
        sys.exit(f"build: badc not built at {p} -- run `cargo build --release --features full`")
    return str(p)


def ensure_inputs(target: str, log) -> None:
    # setup.py fetches the source tarball and the vendored frozen-module headers
    # (no make). The remaining derived sources are committed per target.
    r = run([sys.executable, str(PY_DIR / "setup.py")])
    if r.returncode != 0:
        sys.stderr.write(r.stdout + r.stderr)
        sys.exit("build: setup.py failed")
    tdir = PY_DIR / "targets" / target
    if not tdir.is_dir():
        sys.exit(f"build: no committed inputs for target {target} at {tdir}")
    shutil.copy2(tdir / "pyconfig.h", SRC / "pyconfig.h")
    shutil.copy2(tdir / "config.c", SRC / "Modules" / "config.c")
    log(f"inputs ready for {target}")


def manifest(target: str) -> list[tuple[str, str]]:
    rows = []
    for line in (PY_DIR / "targets" / target / "manifest.txt").read_text().splitlines():
        if line.strip():
            src, cls = line.split()
            rows.append((src, cls))
    return rows


def build(target: str, do_link: bool, log) -> Path | None:
    cfg = TARGETS[target]
    badc = badc_path()
    out = PY_DIR / ".cache" / f"obj-{target}"
    out.mkdir(parents=True, exist_ok=True)
    inc = [a for d in cfg["includes"] for a in ("-I", d)]
    dbg = ["-g"] if os.environ.get("BADC_PY_G") else []
    opt = ["-O"] if os.environ.get("BADC_PY_O") else []

    jobs = [
        (badc, target, src, cls, inc, cfg["extra_defines"].get(src, []), dbg, opt, str(out), str(SRC))
        for src, cls in manifest(target)
    ]
    objs, fails = [], []
    workers = int(os.environ.get("BADC_PY_JOBS") or (os.cpu_count() or 4))
    # ex.map preserves input order, so the object (link) order is deterministic.
    with ProcessPoolExecutor(max_workers=workers) as ex:
        for src, obj, err in ex.map(_compile_one, jobs):
            if err:
                fails.append((src, err))
            else:
                objs.append(obj)

    log(f"compiled {len(objs)}/{len(objs) + len(fails)} TUs, {len(fails)} failed")
    if fails:
        for s, e in fails[:40]:
            print(f"  COMPILE FAIL {s}: {e}", file=sys.stderr)
        sys.exit(f"build: {len(fails)} translation unit(s) failed")
    if not do_link:
        return None

    if cfg.get("asm_trampoline"):
        tobj = out / "asm_trampoline.o"
        r = run([badc, "-c", f"--target={target}", str(PY_DIR / "asm_trampoline.c"), "-o", str(tobj)], timeout=120)
        if r.returncode != 0:
            sys.stderr.write(r.stderr or r.stdout)
            sys.exit("build: asm_trampoline compile failed")
        objs.append(str(tobj))

    py = out / ("python.exe" if "windows" in target else "python")
    log(f"link -> {py}")
    r = run([badc, f"--target={target}", *cfg["link_flags"], *dbg, *objs, "-o", str(py)], timeout=900)
    if r.returncode != 0:
        sys.stderr.write((r.stderr or r.stdout)[-3000:])
        sys.exit("build: link failed")
    return py


def run_tests(py: Path, log) -> int:
    # The suite spawns isolated child interpreters (-I) that ignore PYTHONHOME;
    # getpath then locates Lib relative to the executable, so run from a copy
    # co-located with the source tree's Lib (a prefix layout).
    exe = SRC / py.name
    shutil.copy2(py, exe)
    env = dict(os.environ, PYTHONHOME=str(SRC), PYTHONPATH=str(SRC / "Lib"))
    r = run([str(exe), "-c", "print(2 + 2)"], env=env, timeout=120)
    if r.returncode != 0 or r.stdout.strip() != "4":
        sys.stderr.write(r.stdout + r.stderr)
        print("build: interpreter failed the `print(2 + 2)` check")
        return 1
    print("build: interpreter runs `print(2 + 2)`")
    r = run([str(exe), "-m", "test", "-q", *TEST_SLICE], cwd=SRC, env=env, timeout=1800)
    print(f"build: test slice {' '.join(TEST_SLICE)} exit={r.returncode}")
    if r.returncode != 0:
        sys.stderr.write((r.stdout + r.stderr)[-3000:])
        return 1
    return 0


def main(argv: list[str] | None = None) -> int:
    p = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("--target", default=os.environ.get("BADC_PY_TARGET", "macos-aarch64"))
    p.add_argument("--link", action="store_true", help="link the interpreter")
    p.add_argument("--test", action="store_true", help="link + run the tier-1 slice")
    p.add_argument("-v", "--verbose", action="store_true")
    args = p.parse_args(argv)

    def log(msg: str) -> None:
        print(msg, file=sys.stderr if args.verbose else sys.stdout)

    if args.target not in TARGETS:
        sys.exit(f"build: unknown target {args.target}; known: {', '.join(TARGETS)}")
    ensure_inputs(args.target, log)
    py = build(args.target, args.link or args.test, log)
    if args.test:
        return run_tests(py, log)
    return 0


if __name__ == "__main__":
    sys.exit(main())
