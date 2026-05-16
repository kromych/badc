#!/usr/bin/env python3
"""End-to-end smoke for badc against the Lua 5.5.0 interpreter and
official test suite.

Builds every ``demos/lua/src/*.c`` translation unit through badc at
both ``-O0`` and ``-O``, links into a ``lua`` binary, and runs a
curated subset of the upstream test suite from
``www.lua.org/tests/`` against each lane. Returns 0 on success,
non-zero with a diagnostic message on failure.

The selected tests are the ones that pass against an upstream-built
Lua under ``_port=true; _nomsg=true``: scripts that exercise only
the C99-shaped subset of the standard library (no ``T`` internal
testing primitives, no ``loadlib`` of compiled-C extension
modules). Coverage spans the integer / float / string / table /
coroutine / error / sort / utf8 / pack-string / pattern-match /
vararg paths; the ``T``-dependent corners (GC heuristics, raw
stack-byte inspection, ``api.lua``) are out of scope until the
demo grows a ``ltests.c`` companion build.

Override the badc binary via the ``BADC`` env var
(default: ``target/release/badc[.exe]`` next to the repo root).
"""

from __future__ import annotations

import os
import subprocess
import sys
import tempfile
from pathlib import Path

LUA_DIR = Path(__file__).resolve().parent
REPO_ROOT = LUA_DIR.parent.parent
WIN = sys.platform == "win32"
EXE_SUFFIX = ".exe" if WIN else ""

# Tests that exit 0 against an upstream-built Lua under
# `_port=true; _nomsg=true`, take well under a second each on a
# laptop, and only touch the C99 surface c5 already implements.
# Each one prints its own progress to stdout and asserts via
# `assert(...)`; a non-zero exit code means a regression. The list
# is the durable subset -- timing-driven (`heavy.lua`,
# `verybig.lua`), `T`-internal (`api.lua`, `gc.lua`,
# `tracegc.lua`, `memerr.lua`), `loadlib`-driven (`attrib.lua`),
# `main.lua`-style spawn drivers, and `db.lua` debug-library
# excursions are deliberately omitted.
SUITE = (
    "bitwise.lua",
    "calls.lua",
    "closure.lua",
    "constructs.lua",
    "coroutine.lua",
    "cstack.lua",
    "errors.lua",
    "events.lua",
    "goto.lua",
    "literals.lua",
    "locals.lua",
    "math.lua",
    "nextvar.lua",
    "pm.lua",
    "sort.lua",
    "strings.lua",
    "tpack.lua",
    "utf8.lua",
    "vararg.lua",
)

# Translation units that compose the interpreter binary. Lua's
# upstream src/Makefile splits these into CORE_O (VM + parser),
# LIB_O (stdlib modules), and LUA_O (the standalone driver);
# bundle them together so the multi-TU linker sees the full
# library + driver in one badc invocation.
LUA_TUS = (
    # CORE_O
    "lapi.c",
    "lcode.c",
    "lctype.c",
    "ldebug.c",
    "ldo.c",
    "ldump.c",
    "lfunc.c",
    "lgc.c",
    "llex.c",
    "lmem.c",
    "lobject.c",
    "lopcodes.c",
    "lparser.c",
    "lstate.c",
    "lstring.c",
    "ltable.c",
    "ltm.c",
    "lundump.c",
    "lvm.c",
    "lzio.c",
    # LIB_O
    "lauxlib.c",
    "lbaselib.c",
    "lcorolib.c",
    "ldblib.c",
    "liolib.c",
    "lmathlib.c",
    "loadlib.c",
    "loslib.c",
    "lstrlib.c",
    "ltablib.c",
    "lutf8lib.c",
    "linit.c",
    # LUA_O
    "lua.c",
)


def resolve_badc() -> Path:
    """Locate the badc binary, honouring `$BADC` then falling back
    to ``target/release/badc[.exe]``."""
    env = os.environ.get("BADC")
    candidates = []
    if env:
        candidates.append(Path(env))
    default = REPO_ROOT / "target" / "release" / "badc"
    candidates.extend([default, default.with_suffix(".exe")])
    for cand in candidates:
        if cand.is_file() and os.access(cand, os.X_OK):
            return cand
    print(
        f"smoke: BADC binary not found / not executable\n"
        f"       hint: cargo build --release --manifest-path={REPO_ROOT}/Cargo.toml",
        file=sys.stderr,
    )
    sys.exit(2)


def build_lua(badc: Path, out_path: Path, optimize: bool) -> None:
    """Compile + link the Lua sources through badc, producing an
    interpreter binary at `out_path`. `-I` points at the vendored
    `src/` so quoted `#include` directives resolve to the same
    tree the source ships with."""
    src_dir = LUA_DIR / "src"
    cmd: list[str | os.PathLike[str]] = [str(badc), "-q", "-I", str(src_dir)]
    if optimize:
        cmd.append("-O")
    cmd += ["-o", str(out_path)]
    cmd += [str(src_dir / name) for name in LUA_TUS]
    subprocess.run(cmd, check=True)


def run_one(lua_bin: Path, script: str, tests_dir: Path) -> tuple[bool, str]:
    """Run `script` through `lua_bin` from the tests directory.
    `_port=true; _nomsg=true` matches the upstream README's recipe
    for a deterministic non-platform-coupled run -- silences "test
    skipped" notes and avoids `os.execute` shape probes that
    differ between hosts. Returns (success, captured_tail)."""
    cmd = [
        str(lua_bin),
        "-e",
        "_port=true; _nomsg=true",
        script,
    ]
    proc = subprocess.run(
        cmd,
        cwd=str(tests_dir),
        capture_output=True,
        text=True,
        check=False,
    )
    tail = (proc.stdout + proc.stderr).strip().splitlines()
    return proc.returncode == 0, "\n".join(tail[-5:]) if tail else ""


def run_suite(label: str, lua_bin: Path) -> bool:
    """Walk SUITE against `lua_bin`. Returns True on full success.
    A failed test prints the script name and the last few output
    lines so a regression is identifiable without re-running the
    binary by hand."""
    tests_dir = LUA_DIR / "tests"
    fail = False
    for script in SUITE:
        ok, tail = run_one(lua_bin, script, tests_dir)
        if not ok:
            print(
                f"smoke FAIL [{label}]: {script} exited non-zero\n{tail}",
                file=sys.stderr,
            )
            fail = True
    if not fail:
        print(
            f"smoke OK [{label}]: {len(SUITE)} scripts green"
        )
    return not fail


def main() -> int:
    badc = resolve_badc()

    # Ensure the source + test suite are unpacked. `setup.py` is
    # idempotent so re-running it on every smoke is cheap.
    subprocess.run(
        [sys.executable, str(LUA_DIR / "setup.py")],
        check=True,
    )

    with tempfile.TemporaryDirectory(prefix="lua-smoke-") as work_str:
        work = Path(work_str)

        lua_noopt = work / f"lua{EXE_SUFFIX}"
        lua_opt = work / f"lua.opt{EXE_SUFFIX}"
        try:
            build_lua(badc, lua_noopt, optimize=False)
        except subprocess.CalledProcessError:
            print("smoke FAIL: build (no -O) failed", file=sys.stderr)
            return 1
        try:
            build_lua(badc, lua_opt, optimize=True)
        except subprocess.CalledProcessError:
            print("smoke FAIL: build (-O) failed", file=sys.stderr)
            return 1

        ok = True
        ok &= run_suite("no-O", lua_noopt)
        ok &= run_suite("-O", lua_opt)
        return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
