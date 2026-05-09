#!/usr/bin/env python3
"""End-to-end smoke for badc against the SQLite amalgamation.

Builds ``sqlite3.c + shell.c`` with badc (both at -O and noO)
and runs a fixed set of in-memory + file-backed scenarios
against each shell binary. Returns 0 on success, non-zero with
a diagnostic message on failure.

Used by the CI workflow + by developers who want a quick
end-to-end check after a c5 / codegen change. Does not depend
on any test fixtures -- the queries are baked in here so the
script is self-contained.

Override the badc binary via the ``BADC`` env var
(default: ``target/release/badc[.exe]`` next to the repo root).
"""

from __future__ import annotations

import difflib
import os
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

SQLITE_DIR = Path(__file__).resolve().parent
REPO_ROOT = SQLITE_DIR.parent.parent
WIN = sys.platform == "win32"
EXE_SUFFIX = ".exe" if WIN else ""

BUILD_DEFINES = (
    # SQLITE_DISABLE_INTRINSIC: sqlite uses MSVC's `__umulh` /
    # `_umul128` intrinsics on `_WIN64` (and clang/gcc's
    # `__uint128_t` on those compilers when present). c5 has
    # neither; the portable C fallback in sqlite3Multiply128 /
    # sqlite3Multiply160 handles both. Defined everywhere for
    # symmetry; on Linux/macOS it's a tiny codesize win.
    "SQLITE_OMIT_LOAD_EXTENSION",
    "SQLITE_THREADSAFE=0",
    "SQLITE_DEFAULT_MEMSTATUS=0",
    "SQLITE_DEFAULT_WAL_SYNCHRONOUS=1",
    "SQLITE_DQS=0",
    "SQLITE_OMIT_DEPRECATED",
    "SQLITE_OMIT_PROGRESS_CALLBACK",
    "SQLITE_OMIT_SHARED_CACHE",
    "SQLITE_OMIT_AUTOINIT",
    "SQLITE_WITHOUT_ZONEMALLOC=1",
    "SQLITE_ENABLE_LOCKING_STYLE=0",
    "SQLITE_DISABLE_INTRINSIC",
    "SQLITE_OMIT_SEH",
)


def resolve_badc() -> Path:
    """Locate the badc binary, honouring `$BADC` then falling
    back to ``target/release/badc[.exe]``."""
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


def build_shell(badc: Path, combined: Path, out_path: Path, optimize: bool) -> None:
    """Compile sqlite3.c+shell.c via badc, with or without -O.

    `-include msvc_compat.h` opts the TU into the MSVC-shape
    predefines (`_MSC_VER=1900`, `__MINGW32__=1`, `__int64 ->
    long long`, the `__declspec(x)` empty-decorator family,
    ...). The header is internally `#ifdef _WIN32` so the same
    flag is a no-op on macOS / Linux smoke runs.
    """
    cmd: list[str | os.PathLike[str]] = [str(badc)]
    if optimize:
        cmd.append("-O")
    cmd += ["-include", "msvc_compat.h", str(combined), "-o", str(out_path)]
    cmd += [f"-D{d}" for d in BUILD_DEFINES]
    subprocess.run(cmd, check=True)


def run_shell(shell_bin: Path, script: str) -> str:
    """Pipe `script` into shell_bin's stdin and return stdout
    with CR stripped (Windows / msys path)."""
    proc = subprocess.run(
        [str(shell_bin)],
        input=script,
        capture_output=True,
        text=True,
        check=True,
    )
    return proc.stdout.replace("\r", "")


def diff_msg(expect: str, actual: str) -> str:
    return "\n".join(
        difflib.unified_diff(
            expect.splitlines(),
            actual.splitlines(),
            fromfile="expect",
            tofile="actual",
            lineterm="",
        )
    )


# ---- in-memory scenarios -----------------------------------
# Each (name, sql, expect) tuple exercises a distinct sqlite +
# c5 codepath; comments live next to each block.

# basic CRUD + all five integer aggregates (count / sum / avg /
# min / max). avg() exercises sqlite's vdbeMemRenderNum /
# FpDecode digit-pair writer, which depends on real 16-bit
# `*(u16*)` loads/stores via Op::Lh / Op::Sh.
INMEM_SQL = (
    "CREATE TABLE t(x INTEGER, y TEXT);\n"
    "INSERT INTO t VALUES(-7,'neg'),(1,'hello'),(2,'world');\n"
    "SELECT * FROM t;\n"
    "SELECT count(*),sum(x),avg(x),min(x),max(x) FROM t;\n"
    ".quit\n"
)
INMEM_EXPECT = (
    "-7|neg\n"
    "1|hello\n"
    "2|world\n"
    "3|-4|-1.3333333333333333|-7|2\n"
)

# math / aggregate / type-promotion coverage:
#   * count + DISTINCT (aggregate over a hashed key set)
#   * mixed integer arithmetic + abs / -1 wraparound
#   * boundary integer literals at INT32_MIN / INT32_MAX
#   * unsigned shift `>>` of high-bit-set value (Op::Shru)
#   * length() over a UTF-8 literal
#   * row-count + ORDER BY ... LIMIT (vdbe sort path)
MATH_SQL = (
    "CREATE TABLE n(v INTEGER);\n"
    "INSERT INTO n VALUES(1),(2),(3),(2),(1),(NULL);\n"
    "SELECT count(*),count(v),count(DISTINCT v) FROM n;\n"
    "SELECT abs(-9223372036854775807) - 1;\n"
    "SELECT 2147483647 + 1, -2147483647 - 1;\n"
    "SELECT 0xFFFFFFFF >> 1, 0xFFFFFFFF & 0xF;\n"
    "SELECT length('hello world');\n"
    "SELECT v FROM n WHERE v IS NOT NULL ORDER BY v DESC LIMIT 2;\n"
    ".quit\n"
)
MATH_EXPECT = (
    "6|5|3\n"
    "9223372036854775806\n"
    "2147483648|-2147483648\n"
    "2147483647|15\n"
    "11\n"
    "3\n"
    "2\n"
)

# REAL column + INTEGER -> REAL promotion aggregates. The
# `INTEGER * 1.0` path goes through sqlite's Kahan-Babuska-
# Neumaier accumulator -- this used to return 0 because c5's
# compound assignment lowered to integer ops on the FP bit
# patterns. Regression marker.
REAL_SQL = (
    "CREATE TABLE r(x REAL);\n"
    "INSERT INTO r VALUES(1.5),(2.5),(3.5);\n"
    "SELECT count(*),sum(x),avg(x),min(x),max(x) FROM r;\n"
    "SELECT round(avg(x), 2) FROM r;\n"
    "CREATE TABLE i(x INTEGER);\n"
    "INSERT INTO i VALUES(-7),(1),(2);\n"
    "SELECT sum(x*1.0),avg(x*1.0),total(x) FROM i;\n"
    "SELECT 1.0 + 2.0, 3.5 - 1.5, 2.5 * 4.0, 9.0 / 4.0;\n"
    ".quit\n"
)
REAL_EXPECT = (
    "3|7.5|2.5|1.5|3.5\n"
    "2.5\n"
    "-4.0|-1.3333333333333333|-4.0\n"
    "3.0|2.0|10.0|2.25\n"
)

# String built-ins + JOIN coverage:
#   * substr / replace / lower / upper / trim / ltrim / rtrim
#     (each a separate codepath in sqlite's func.c via OP_Function)
#   * INNER JOIN / LEFT JOIN (nested-loop join + NULL-fill)
#   * group_concat (variable-length string aggregator)
#   * UNION ALL (multi-source iterator dispatch)
# Trailing whitespace on `  alice  ` rows must round-trip
# exactly -- a literal HEREDOC could leak through editor /
# VCS auto-trim and silently shift the diff baseline; using a
# Python triple-quoted string with explicit `\n` keeps the
# bytes deterministic.
STRJOIN_SQL = (
    "CREATE TABLE u(id INTEGER, name TEXT);\n"
    "INSERT INTO u VALUES(1,'  alice  '),(2,'BOB'),(3,'Carol');\n"
    "SELECT id,upper(trim(name)),length(name),substr(name,1,3) FROM u ORDER BY id;\n"
    "SELECT replace('hello world','world','sqlite');\n"
    "SELECT lower('MiXeD'),ltrim('   pad'),rtrim('pad   ');\n"
    "SELECT group_concat(name,'/') FROM u;\n"
    "CREATE TABLE p(uid INTEGER, lang TEXT);\n"
    "INSERT INTO p VALUES(1,'rust'),(1,'c'),(3,'go');\n"
    "SELECT u.name,p.lang FROM u INNER JOIN p ON u.id=p.uid ORDER BY u.id,p.lang;\n"
    "SELECT u.name,p.lang FROM u LEFT JOIN p ON u.id=p.uid ORDER BY u.id,p.lang;\n"
    "SELECT name FROM u WHERE id=1 UNION ALL SELECT name FROM u WHERE id=3 ORDER BY name;\n"
    ".quit\n"
)
STRJOIN_EXPECT = (
    "1|ALICE|9|  a\n"
    "2|BOB|3|BOB\n"
    "3|CAROL|5|Car\n"
    "hello sqlite\n"
    "mixed|pad|pad\n"
    "  alice  /BOB/Carol\n"
    "  alice  |c\n"
    "  alice  |rust\n"
    "Carol|go\n"
    "  alice  |c\n"
    "  alice  |rust\n"
    "BOB|\n"
    "Carol|go\n"
    "  alice  \n"
    "Carol\n"
)

# WITH RECURSIVE + transaction + introspection:
#   * WITH RECURSIVE: vdbe builds an internal table and loops
#     until the recursive arm produces no new rows.
#   * BEGIN / ROLLBACK: full WAL-less rollback restores prior
#     state from the rollback journal.
#   * UPDATE/DELETE ... WHERE multi-row: vdbe row-update loop
#     with cursor seek.
#   * `.tables` / `.schema`: cli_printf -> sqlite3_vfprintf
#     -> c5 vfprintf format-specifier handling.
#
# gh #30 regression: a follow-on `WITH RECURSIVE fib(a,b)`
# exercises the integer-literal path that misclassified
# `EP_IsFalse = 0x20000000` (= `CODE_BASE`) as a func-ptr at
# -O. Keep both shapes -- the c(n) one and the two-column fib
# one -- so future regressions on either side fail loudly.
CTE_SQL = (
    "CREATE TABLE k(v INTEGER);\n"
    "INSERT INTO k VALUES(10),(20),(30),(40),(50);\n"
    "WITH RECURSIVE c(n) AS (SELECT 1 UNION ALL SELECT n+1 FROM c WHERE n<5) "
    "SELECT n,n*n FROM c;\n"
    "BEGIN;\n"
    "UPDATE k SET v=v+100 WHERE v>=30;\n"
    "SELECT v FROM k ORDER BY v;\n"
    "ROLLBACK;\n"
    "SELECT v FROM k ORDER BY v;\n"
    "DELETE FROM k WHERE v>20;\n"
    "SELECT count(*) FROM k;\n"
    ".tables\n"
    "CREATE TABLE meta(id INTEGER PRIMARY KEY, note TEXT);\n"
    ".schema meta\n"
    "WITH RECURSIVE fib(a,b) AS "
    "(SELECT 0,1 UNION ALL SELECT b,a+b FROM fib WHERE b<100) "
    "SELECT a FROM fib;\n"
    ".quit\n"
)
CTE_EXPECT = (
    "1|1\n"
    "2|4\n"
    "3|9\n"
    "4|16\n"
    "5|25\n"
    "10\n"
    "20\n"
    "130\n"
    "140\n"
    "150\n"
    "10\n"
    "20\n"
    "30\n"
    "40\n"
    "50\n"
    "2\n"
    "k\n"
    "CREATE TABLE meta(id INTEGER PRIMARY KEY, note TEXT);\n"
    "0\n"
    "1\n"
    "1\n"
    "2\n"
    "3\n"
    "5\n"
    "8\n"
    "13\n"
    "21\n"
    "34\n"
    "55\n"
    "89\n"
)

INMEM_SCENARIOS = (
    ("in-memory CRUD + integer aggregates", INMEM_SQL, INMEM_EXPECT),
    ("math / aggregate / type-promotion", MATH_SQL, MATH_EXPECT),
    ("REAL aggregates + int->real promotion", REAL_SQL, REAL_EXPECT),
    ("string built-ins + JOIN", STRJOIN_SQL, STRJOIN_EXPECT),
    ("WITH RECURSIVE + txn + introspection", CTE_SQL, CTE_EXPECT),
)


def run_scenarios(label: str, shell_bin: Path, work: Path) -> bool:
    """Run all scenarios against `shell_bin`. Returns True on
    full success, False (and prints to stderr) on any mismatch."""
    fail = False
    for name, sql, expect in INMEM_SCENARIOS:
        actual = run_shell(shell_bin, sql)
        if actual != expect:
            print(
                f"smoke FAIL [{label}]: {name} mismatch\n{diff_msg(expect, actual)}",
                file=sys.stderr,
            )
            fail = True

    # ---- file-backed smoke ---------------------------------
    # The shell binary is a native Win32 process on the windows
    # CI lanes (Python hosts the script, but `shell_bin` is a
    # real PE that only understands Windows paths). `work`
    # lands wherever Python's tempfile picked, which on
    # MSYS-style Python could be a mixed-form path; on native
    # Python for Windows it's already a drive-letter path. Use
    # forward slashes either way so the .open string round-trips
    # cleanly through any quoting layer.
    db = work / f"{label}.db"
    if db.exists():
        db.unlink()
    db_for_shell = str(db).replace("\\", "/")
    write_sql = (
        f".open {db_for_shell}\n"
        "CREATE TABLE t(x INTEGER, y TEXT);\n"
        "INSERT INTO t VALUES(-7,'neg'),(1,'hello'),(2,'world');\n"
        ".quit\n"
    )
    file_out = run_shell(shell_bin, write_sql)
    if file_out:
        print(
            f"smoke FAIL [{label}]: file-backed write produced unexpected output: {file_out!r}",
            file=sys.stderr,
        )
        fail = True
    if not db.is_file() or db.stat().st_size == 0:
        print(
            f"smoke FAIL [{label}]: file-backed write left empty db at {db}",
            file=sys.stderr,
        )
        fail = True

    reopen_sql = f".open {db_for_shell}\nSELECT * FROM t ORDER BY x;\n.quit\n"
    reopen_expect = "-7|neg\n1|hello\n2|world\n"
    reopen_out = run_shell(shell_bin, reopen_sql)
    if reopen_out != reopen_expect:
        print(
            f"smoke FAIL [{label}]: file-backed reopen mismatch\n{diff_msg(reopen_expect, reopen_out)}",
            file=sys.stderr,
        )
        fail = True

    if not fail:
        print(f"smoke OK [{label}]: in-memory + file-backed both green")
    return not fail


def main() -> int:
    badc = resolve_badc()

    # Ensure the sqlite source is in place. setup is idempotent
    # so re-running is cheap on a primed runner.
    subprocess.run(
        [sys.executable, str(SQLITE_DIR / "setup.py")],
        check=True,
    )

    with tempfile.TemporaryDirectory(prefix="sqlite3-smoke-") as work_str:
        work = Path(work_str)
        # Concatenate -- badc takes a single translation unit,
        # and we want both the library and the CLI in one binary.
        combined = work / "sqlite3shell_combined.c"
        with combined.open("wb") as out:
            for src in ("sqlite3.c", "shell.c"):
                with (SQLITE_DIR / src).open("rb") as f:
                    shutil.copyfileobj(f, out)

        shell_noopt = work / f"sqlite3shell{EXE_SUFFIX}"
        shell_opt = work / f"sqlite3shell.opt{EXE_SUFFIX}"
        try:
            build_shell(badc, combined, shell_noopt, optimize=False)
        except subprocess.CalledProcessError:
            print("smoke FAIL: build (no -O) failed", file=sys.stderr)
            return 1
        try:
            build_shell(badc, combined, shell_opt, optimize=True)
        except subprocess.CalledProcessError:
            print("smoke FAIL: build (-O) failed", file=sys.stderr)
            return 1

        ok = True
        ok &= run_scenarios("no-O", shell_noopt, work)
        ok &= run_scenarios("-O", shell_opt, work)
        return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
