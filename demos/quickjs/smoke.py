#!/usr/bin/env python3
"""End-to-end smoke for badc against QuickJS.

Fetches the QuickJS source (via setup.py) and builds two programs from it
with badc: the `qjsc` bytecode compiler and the `qjs` CLI. `qjsc` turns
`repl.js` into the REPL bytecode blob that `qjs` links and evaluates in
interactive mode, so the bytecode writer and reader are both exercised on
real input rather than stubbed out. The CLI then runs QuickJS's own
pure-JS test suite, the two native-module tests (each a badc-built shared
object the CLI dlopens), and a bytecode-compiled standalone program.

`CONFIG_ALL_UNICODE` is enabled: it compiles libunicode's normalization
tables and the Unicode-aware `String.prototype.normalize` /
`localeCompare`, which the upstream default build leaves out.

Windows is skipped: quickjs-libc's OS layer needs CRT entry points badc
does not bind (the first is `_putenv`).

Override the badc binary via the `BADC` env var (default:
`target/release/badc[.exe]` next to the repo root).
"""

from __future__ import annotations

import os
import shutil
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import setup as qjs_setup  # noqa: E402  (sibling module: the pinned version)

QJS_DIR = Path(__file__).resolve().parent
CACHE = QJS_DIR / ".cache"
REPO_ROOT = QJS_DIR.parent.parent
WIN = sys.platform == "win32"
EXE_SUFFIX = ".exe" if WIN else ""

# The engine proper. `qjs.c` (CLI) and `qjsc.c` (bytecode compiler) each
# link against these six.
LIB_TUS = (
    "quickjs.c",
    "quickjs-libc.c",
    "cutils.c",
    "libregexp.c",
    "libunicode.c",
    "dtoa.c",
)
DEFINES = (
    "_GNU_SOURCE",
    f'CONFIG_VERSION="{qjs_setup.UPSTREAM_VERSION}"',
    "CONFIG_ALL_UNICODE",
)
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

# Normalization forms reachable only under CONFIG_ALL_UNICODE. Each case is
# (expression, expected stdout); the decomposed inputs are spelled with
# escapes so the file stays ASCII.
UNICODE_CHECK = (
    'var d = "A\\u030A";'
    'print(d.normalize("NFC").length, d.normalize("NFC").codePointAt(0).toString(16));'
    'print("\\u00E9".normalize("NFD").length);'
    'print("\\uFB01".normalize("NFKC"));'
    'print("a".localeCompare("b"), "b".localeCompare("a"), "a".localeCompare("a"));'
)
UNICODE_EXPECT = "1 c5\n2\nfi\n-1 1 0"

# Compiled to bytecode by qjsc and linked as a standalone program, so the
# bytecode round-trip is checked on output rather than on exit status alone.
STANDALONE_SRC = """
var acc = 0;
for (var i = 0; i < 1000; i++) acc += i * i;
print("standalone", acc, [3, 1, 2].sort().join(""), JSON.stringify({a: 1}));
"""
STANDALONE_EXPECT = 'standalone 332833500 123 {"a":1}'


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


def badc_build(badc: Path, sources, out: Path, extra=()) -> None:
    cmd = [str(badc), "-O", "--export-all", *extra]
    for d in DEFINES:
        cmd += ["-D", d]
    cmd += ["-I", str(QJS_DIR)]
    cmd += [str(s) for s in sources]
    cmd += ["-o", str(out)]
    r = subprocess.run(cmd, capture_output=True, text=True)
    if r.returncode != 0 or not out.is_file():
        fail(f"{out.name} build failed (exit {r.returncode})\n{r.stderr[-2000:]}")


def run_js(qjs: Path, args, cwd: Path, timeout: int = 300):
    """Run the CLI with a stdin the child can block on.

    test_std.js's os.exec case spawns `cat`, signals it, then expects a
    signal exit status. With an EOF stdin -- a CI runner's closed stdin --
    cat reads EOF and exits 0 before the signal arrives, so the test reads
    exit code 0. Hand the child a pipe whose write end this process holds
    open for the run's duration.
    """
    stdin_r = stdin_w = None
    if not WIN:
        stdin_r, stdin_w = os.pipe()
    try:
        return subprocess.run(
            [str(qjs), *args],
            stdin=stdin_r,
            capture_output=True,
            text=True,
            cwd=cwd,
            timeout=timeout,
        )
    finally:
        if stdin_r is not None:
            os.close(stdin_r)
            os.close(stdin_w)


def main() -> int:
    if WIN:
        print("smoke OK [skipped on Windows -- quickjs-libc needs unbound CRT entry points]")
        return 0

    # Fetch the source if it is not already extracted.
    if not (QJS_DIR / "qjsc.c").is_file():
        rc = subprocess.run(
            [sys.executable, str(QJS_DIR / "setup.py")], cwd=QJS_DIR
        ).returncode
        if rc != 0:
            fail("setup.py could not fetch the quickjs source")

    badc = resolve_badc()
    CACHE.mkdir(parents=True, exist_ok=True)
    lib = [QJS_DIR / tu for tu in LIB_TUS]

    # 1. The bytecode compiler, then the REPL blob it produces. Upstream
    #    generates repl.c the same way; badc builds the generator too.
    qjsc = CACHE / f"qjsc{EXE_SUFFIX}"
    badc_build(badc, lib + [QJS_DIR / "qjsc.c"], qjsc)
    repl_c = CACHE / "repl.c"
    r = subprocess.run(
        [str(qjsc), "-s", "-c", "-o", str(repl_c), "-m", str(QJS_DIR / "repl.js")],
        capture_output=True, text=True, timeout=300,
    )
    if r.returncode != 0 or not repl_c.is_file():
        fail(f"qjsc could not compile repl.js (exit {r.returncode})\n{r.stderr[-2000:]}")

    # 2. The CLI, linking the generated blob. `--export-all` puts the
    #    engine's API in the dynamic symbol table so a dlopen'd native
    #    module resolves JS_NewObject, JS_ToIndex, ... from the host.
    qjs = QJS_DIR / f"qjs{EXE_SUFFIX}"
    badc_build(badc, lib + [QJS_DIR / "qjs.c", repl_c], qjs)

    tests_dir = QJS_DIR / "tests"
    passed = 0
    for name, extra in [(t, []) for t in PLAIN_TESTS] + [
        (t, ["--std"]) for t in STD_TESTS
    ]:
        run = run_js(qjs, [*extra, str(tests_dir / name)], tests_dir, timeout=120)
        if run.returncode != 0:
            fail(
                f"{name}{' --std' if extra else ''} exit {run.returncode}\n"
                f"{(run.stdout + run.stderr)[-1500:]}"
            )
        passed += 1

    # 3. Native extension modules: build each as a badc shared object and
    #    run its test through the CLI, which dlopens the module.
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
        badc_build(badc, [src], so, extra=["--shared", "-D", "JS_SHARED_LIBRARY"])
        rt = run_js(qjs, ["--std", str(test)], cwd, timeout=120)
        if rt.returncode != 0:
            fail(f"{test.name} exit {rt.returncode}\n{(rt.stdout + rt.stderr)[-1500:]}")
        module_passed += 1

    # 4. The REPL blob: interactive mode reads it back with JS_ReadObject.
    #    The line editor drives a raw tty, so assert on the banner and a
    #    clean exit after `\q` rather than on edited output.
    rr = subprocess.run(
        [str(qjs), "-i"], input="\\q\n", capture_output=True, text=True, timeout=120
    )
    if rr.returncode != 0 or "QuickJS - Type" not in rr.stdout:
        fail(f"REPL blob did not run (exit {rr.returncode})\n{(rr.stdout + rr.stderr)[-1500:]}")

    # 5. Bytecode round-trip on a standalone program: qjsc emits a C file
    #    with main() plus the blob, badc links it against the engine.
    prog_js = CACHE / "standalone.js"
    prog_js.write_text(STANDALONE_SRC)
    prog_c = CACHE / "standalone.c"
    r = subprocess.run(
        [str(qjsc), "-e", "-o", str(prog_c), str(prog_js)],
        capture_output=True, text=True, timeout=300,
    )
    if r.returncode != 0 or not prog_c.is_file():
        fail(f"qjsc -e failed (exit {r.returncode})\n{r.stderr[-2000:]}")
    prog = CACHE / f"standalone{EXE_SUFFIX}"
    badc_build(badc, lib + [prog_c], prog)
    rp = run_js(prog, [], CACHE, timeout=120)
    if rp.returncode != 0 or rp.stdout.strip() != STANDALONE_EXPECT:
        fail(
            f"bytecode-compiled program mismatch (exit {rp.returncode})\n"
            f"  expected: {STANDALONE_EXPECT!r}\n  actual:   {rp.stdout.strip()!r}"
        )

    # 6. CONFIG_ALL_UNICODE: normalization and the Unicode-aware collation
    #    the default build compiles out.
    ru = run_js(qjs, ["-e", UNICODE_CHECK], QJS_DIR, timeout=120)
    if ru.returncode != 0 or ru.stdout.strip() != UNICODE_EXPECT:
        fail(
            f"CONFIG_ALL_UNICODE check mismatch (exit {ru.returncode})\n"
            f"  expected: {UNICODE_EXPECT!r}\n  actual:   {ru.stdout.strip()!r}"
        )

    print(
        f"smoke OK: qjsc + qjs built; {passed} pure-JS + {module_passed} native-module "
        "quickjs tests green; REPL blob, bytecode round-trip and Unicode "
        "normalization checked"
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
