#!/usr/bin/env python3
"""End-to-end smoke for badc against QuickJS.

Fetches the QuickJS source (via setup.py), compiles the eight translation
units of the `qjs` CLI with badc, and runs QuickJS's own pure-JS test
suite through it. Returns 0 on success, non-zero with a diagnostic on
failure.

The two native-module tests (test_bjson / test_point) need a runtime
`dlopen` of a badc-built shared object, which is not yet supported, so they
are not part of this set. Windows is skipped: QuickJS's OS layer
(quickjs-libc) targets a POSIX host and badc does not yet provide the
Windows equivalents.

Override the badc binary via the `BADC` env var (default:
`target/release/badc[.exe]` next to the repo root).
"""

from __future__ import annotations

import os
import subprocess
import sys
from pathlib import Path

QJS_DIR = Path(__file__).resolve().parent
REPO_ROOT = QJS_DIR.parent.parent
WIN = sys.platform == "win32"
EXE_SUFFIX = ".exe" if WIN else ""

# The eight translation units of the qjs CLI plus the REPL-blob stub.
TUS = (
    "quickjs.c",
    "quickjs-libc.c",
    "cutils.c",
    "libregexp.c",
    "libunicode.c",
    "dtoa.c",
    "qjs.c",
    "repl_stub.c",
)
DEFINES = ("_GNU_SOURCE", 'CONFIG_VERSION="2024"')
# Pure-JS tests. test_builtin needs the full standard library exposed
# with --std; the rest run with the default global set.
PLAIN_TESTS = (
    "test_closure.js",
    "test_language.js",
    "test_loop.js",
    "test_bigint.js",
    "test_cyclic_import.js",
    "test_std.js",
    "test_worker.js",
    "test_rw_handler.js",
)
STD_TESTS = ("test_builtin.js",)


def resolve_badc() -> Path:
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


def fail(msg: str) -> None:
    print(f"smoke FAIL: {msg}", file=sys.stderr)
    sys.exit(1)


def main() -> int:
    if WIN:
        print("smoke OK [skipped on Windows -- POSIX-only quickjs-libc]")
        return 0

    # Fetch the source if it is not already extracted.
    if not (QJS_DIR / "quickjs.c").is_file():
        rc = subprocess.run(
            [sys.executable, str(QJS_DIR / "setup.py")], cwd=QJS_DIR
        ).returncode
        if rc != 0:
            fail("setup.py could not fetch the quickjs source")

    badc = resolve_badc()
    qjs = QJS_DIR / f"qjs{EXE_SUFFIX}"

    # `--export-all` puts the engine's API in the executable's dynamic
    # symbol table so a dlopen'd native module resolves its references to
    # the host (JS_NewObject, JS_ToIndex, ...) from the global scope.
    cmd = [str(badc), "--export-all"]
    for d in DEFINES:
        cmd += ["-D", d]
    cmd += ["-I", str(QJS_DIR)]
    cmd += [str(QJS_DIR / tu) for tu in TUS]
    cmd += ["-o", str(qjs)]
    r = subprocess.run(cmd, capture_output=True, text=True)
    if r.returncode != 0 or not qjs.is_file():
        fail(f"qjs build failed (exit {r.returncode})\n{r.stderr[-2000:]}")

    tests_dir = QJS_DIR / "tests"
    passed = 0
    for name, extra in [(t, []) for t in PLAIN_TESTS] + [
        (t, ["--std"]) for t in STD_TESTS
    ]:
        path = tests_dir / name
        # test_std.js's os.exec case spawns `cat`, signals it, then
        # expects a signal exit status. With an EOF stdin -- a CI
        # runner's closed stdin -- cat reads EOF and exits 0 before the
        # signal arrives, so the test reads exit code 0. Hand the child
        # a stdin that blocks: a pipe whose write end the parent holds
        # open for the run's duration. Skipped on Windows, where the
        # POSIX os.exec path does not apply.
        stdin_r = stdin_w = None
        if not WIN:
            stdin_r, stdin_w = os.pipe()
        try:
            run = subprocess.run(
                [str(qjs), *extra, str(path)],
                stdin=stdin_r,
                capture_output=True,
                text=True,
                cwd=tests_dir,
                timeout=120,
            )
        finally:
            if stdin_r is not None:
                os.close(stdin_r)
                os.close(stdin_w)
        if run.returncode != 0:
            fail(
                f"{name}{' --std' if extra else ''} exit {run.returncode}\n"
                f"{(run.stdout + run.stderr)[-1500:]}"
            )
        passed += 1

    # Native extension modules: build each as a badc shared object and run
    # its test through the qjs CLI, which dlopens the module and resolves
    # the module's host references against the executable's exported API.
    examples_dir = QJS_DIR / "examples"
    modules = (
        (tests_dir / "bjson.c", tests_dir / "bjson.so", tests_dir / "test_bjson.js", tests_dir),
        (
            examples_dir / "point.c",
            examples_dir / "point.so",
            examples_dir / "test_point.js",
            examples_dir,
        ),
    )
    module_passed = 0
    for src, so, test, cwd in modules:
        build = [str(badc), "--export-all", "--shared"]
        for d in DEFINES:
            build += ["-D", d]
        build += ["-D", "JS_SHARED_LIBRARY", "-I", str(QJS_DIR), str(src), "-o", str(so)]
        rb = subprocess.run(build, capture_output=True, text=True)
        if rb.returncode != 0 or not so.is_file():
            fail(f"module {src.name} build failed (exit {rb.returncode})\n{rb.stderr[-2000:]}")
        rt = subprocess.run(
            [str(qjs), "--std", str(test)],
            capture_output=True,
            text=True,
            cwd=cwd,
            timeout=120,
        )
        if rt.returncode != 0:
            fail(f"{test.name} exit {rt.returncode}\n{(rt.stdout + rt.stderr)[-1500:]}")
        module_passed += 1

    print(
        f"smoke OK: qjs built; {passed} pure-JS + {module_passed} native-module "
        "quickjs tests green"
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
