#!/usr/bin/env python3
"""Build CPython 3.14.6 with badc for a target, with no make/configure at build
time. Each target's all-builtin link set is committed under ``targets/<target>/``
as a self-describing ``manifest.json`` (per-TU class, defines, extra includes)
plus the matching ``config.c`` (the builtin inittab) and ``pyconfig.h``; the
frozen-module headers come from ``setup.py``. One command for every target.

    python3 demos/python/build.py --target=macos-aarch64 --test

The manifest is produced offline once per target by gen_manifest.py from a host
all-static build; replaces the configure+make host build (smoke.py) and
win_build.py as targets are ported. Pass --target or set BADC_PY_TARGET.
"""

from __future__ import annotations

import argparse
import json
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

# Includes common to every TU; the manifest carries any per-TU extras.
POSIX_INCLUDES = ["Include", "Include/internal", "."]
EXPORT_FLAGS = ["--export-all", "--export-data"]

# Per-target options not encoded in the manifest. asm_trampoline substitutes the
# portable trampoline for the hand-written .S a host build assembles (POSIX with
# the perf trampoline; macOS does not link it).
TARGETS = {
    "macos-aarch64": {
        "asm_trampoline": False,
        # The captured pyconfig.h claims headers badc's bundled set does not
        # fully provide; undefine them so the module takes a supported path
        # (kqueue -> select/poll; no AF_SYSTEM kernel-control socket).
        "undef_haves": ["HAVE_KQUEUE", "HAVE_SYS_EVENT_H", "HAVE_SYS_KERN_CONTROL_H"],
        # Niche modules badc does not compile: Mach-O internals (remote
        # debugging), libuuid (_uuid), and CoreFoundation (_scproxy).
        "exclude": [
            ("_remote_debugging_module.c", "_remote_debugging"),
            ("_uuidmodule.c", "_uuid"),
            ("_scproxy.c", "_scproxy"),
        ],
    },
    "linux-x64": {"asm_trampoline": True},
    "linux-aarch64": {"asm_trampoline": True},
}


def run(cmd, **kw):
    return subprocess.run(cmd, capture_output=True, text=True, **kw)


def _compile_one(job):
    """Compile one TU. Runs in a worker process, so the args are plain and
    picklable. Returns (src, obj-path-or-None, error-or-None)."""
    badc, target, entry, common_inc, dbg, opt, out_dir, src_root = job
    src = entry["src"]
    obj = os.path.join(out_dir, src.replace("/", "_")[:-2] + ".o")
    core = "Py_BUILD_CORE_BUILTIN" if entry["class"] == "builtin" else "Py_BUILD_CORE"
    defs = [f"-D{core}"] + [f"-D{d}" for d in entry.get("defines", [])]
    inc = common_inc + [a for d in entry.get("includes", []) for a in ("-I", d)]
    cmd = [badc, "--gnu", "-c", f"--target={target}", "-UHAVE_GCC_UINT128_T",
           *dbg, *opt, *defs, *inc, src, "-o", obj]
    r = subprocess.run(cmd, cwd=src_root, capture_output=True, text=True, timeout=240)
    if r.returncode != 0:
        msg = ((r.stderr or r.stdout).strip().splitlines() or [f"rc{r.returncode}"])[-1]
        return (src, None, msg[:200])
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
    cfg = TARGETS[target]
    shutil.copy2(tdir / "pyconfig.h", SRC / "pyconfig.h")
    # Undefine HAVE_ macros for headers badc's bundled set does not provide, so
    # the dependent modules take a supported path rather than failing to compile.
    undefs = cfg.get("undef_haves", [])
    if undefs:
        pc = SRC / "pyconfig.h"
        text = pc.read_text()
        for m in undefs:
            text = text.replace(f"#define {m} 1\n", f"/* badc: {m} unsupported, undefined */\n")
        pc.write_text(text)
    shutil.copy2(tdir / "config.c", SRC / "Modules" / "config.c")
    # Drop the inittab entry and extern for each excluded module so the static
    # link has no unresolved PyInit reference.
    excl_inits = [init for _, init in cfg.get("exclude", [])]
    if excl_inits:
        cc = SRC / "Modules" / "config.c"
        keep = [
            line
            for line in cc.read_text().splitlines(keepends=True)
            if not any(
                f'"{init}", PyInit_{init}' in line or f"PyInit_{init}(void)" in line
                for init in excl_inits
            )
        ]
        cc.write_text("".join(keep))
    # Place any committed generated stdlib modules (e.g. _sysconfigdata, which a
    # host build generates and the tarball omits) onto the path.
    for f in tdir.glob("_sysconfigdata*.py"):
        shutil.copy2(f, SRC / "Lib" / f.name)
    log(f"inputs ready for {target}")


def manifest(target: str) -> list[dict]:
    p = PY_DIR / "targets" / target / "manifest.json"
    if not p.is_file():
        sys.exit(f"build: {target} has no manifest.json -- capture it with gen_manifest.py "
                 "from a host all-static build (only macos-aarch64 is captured so far)")
    return json.loads(p.read_text())


def build(target: str, do_link: bool, log) -> Path | None:
    cfg = TARGETS[target]
    badc = badc_path()
    out = PY_DIR / ".cache" / f"obj-{target}"
    out.mkdir(parents=True, exist_ok=True)
    common_inc = [a for d in POSIX_INCLUDES for a in ("-I", d)]
    dbg = ["-g"] if os.environ.get("BADC_PY_G") else []
    opt = ["-O"] if os.environ.get("BADC_PY_O") else []

    excl_srcs = [s for s, _ in cfg.get("exclude", [])]
    entries = [e for e in manifest(target) if not any(s in e["src"] for s in excl_srcs)]
    jobs = [(badc, target, e, common_inc, dbg, opt, str(out), str(SRC)) for e in entries]
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
    r = run([badc, f"--target={target}", *EXPORT_FLAGS, *dbg, *objs, "-o", str(py)], timeout=900)
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
