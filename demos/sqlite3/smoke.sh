#!/usr/bin/env bash
# Build the patched sqlite3 amalgamation + shell with badc and
# run a fixed smoke test against in-memory and file-backed
# databases. Returns 0 on success, non-zero with a diagnostic
# message on failure.
#
# Used by the CI workflow + by developers who want a quick
# end-to-end check after a c5 / codegen change. Does not depend
# on any test fixtures -- the queries are baked in here so the
# script is self-contained.
#
# Usage:
#   demos/sqlite3/smoke.sh                     # release-mode badc
#   BADC=target/debug/badc demos/sqlite3/smoke.sh
#
# Falls back to `target/release/badc` if `BADC` is unset.

set -euo pipefail

SELF="${BASH_SOURCE[0]}"
SQLITE_DIR="$(cd "$(dirname "$SELF")" && pwd)"
REPO_ROOT="$(cd "${SQLITE_DIR}/../.." && pwd)"

BADC="${BADC:-${REPO_ROOT}/target/release/badc}"
# On Windows hosts (Git Bash) cargo writes `badc.exe`; accept either.
if [ ! -x "${BADC}" ] && [ -x "${BADC}.exe" ]; then
    BADC="${BADC}.exe"
fi
if [ ! -x "${BADC}" ]; then
    echo "smoke: BADC=${BADC} not found / not executable" >&2
    echo "       hint: cargo build --release --manifest-path=${REPO_ROOT}/Cargo.toml" >&2
    exit 2
fi

# Match the host's executable suffix so badc's auto-extension
# logic (`.exe` on Windows, none elsewhere) and the script's
# explicit pipe-to-shell paths line up. `OSTYPE` is the cheapest
# Git-Bash-aware test that doesn't require external tooling.
EXE_SUFFIX=""
case "${OSTYPE:-}" in
    msys*|cygwin*|win32*) EXE_SUFFIX=".exe" ;;
esac

# Ensure the patched sqlite source is in place. setup.sh is
# idempotent so re-running is cheap on a primed runner.
"${SQLITE_DIR}/setup.sh"

# Concatenate -- badc takes a single translation unit, and we
# want both the library and the CLI in one binary.
WORK="$(mktemp -d)"
trap 'rm -rf "${WORK}"' EXIT
COMBINED="${WORK}/sqlite3shell_combined.c"
cat "${SQLITE_DIR}/sqlite3.c" "${SQLITE_DIR}/shell.c" > "${COMBINED}"

build_shell() {
    local out_path="$1"
    shift
    # SQLITE_DISABLE_INTRINSIC: sqlite uses MSVC's `__umulh` /
    # `_umul128` intrinsics on `_WIN64` (and clang/gcc's
    # `__uint128_t` on those compilers when present). c5 has
    # neither -- the portable C fallback path inside
    # sqlite3Multiply128 / sqlite3Multiply160 works fine for
    # both, so we just turn off the intrinsic shortcut. Defined
    # everywhere for symmetry; on Linux/macOS it's a tiny
    # codesize win (the fallback is slightly bigger than the
    # intrinsic), nothing more.
    # `-include msvc_compat.h` opts this translation unit into
    # the MSVC-shape predefines (`_MSC_VER=1900`, `__MINGW32__=1`,
    # `__int64 -> long long`, the `__declspec(x)` empty-decorator
    # family, etc.). The header internally `#ifdef _WIN32` so the
    # same flag is a no-op on macOS / Linux smoke runs and the
    # command line stays uniform across hosts (gh #34).
    "${BADC}" "$@" -include msvc_compat.h "${COMBINED}" -o "${out_path}" \
        -DSQLITE_OMIT_LOAD_EXTENSION \
        -DSQLITE_THREADSAFE=0 \
        -DSQLITE_DEFAULT_MEMSTATUS=0 \
        -DSQLITE_DEFAULT_WAL_SYNCHRONOUS=1 \
        -DSQLITE_DQS=0 \
        -DSQLITE_OMIT_DEPRECATED \
        -DSQLITE_OMIT_PROGRESS_CALLBACK \
        -DSQLITE_OMIT_SHARED_CACHE \
        -DSQLITE_OMIT_AUTOINIT \
        -DSQLITE_WITHOUT_ZONEMALLOC=1 \
        -DSQLITE_ENABLE_LOCKING_STYLE=0 \
        -DSQLITE_DISABLE_INTRINSIC \
        -DSQLITE_OMIT_SEH
}

run_scenarios() {
    local label="$1"
    local shell_bin="$2"
    local fail=0

    # Diag mode: report the shell binary's own exit code via a
    # direct invocation BEFORE the regular smoke runs. The smoke
    # captures only stdout, so a shell that exits non-zero before
    # writing any data looks the same as one that ran successfully
    # but emitted nothing. Probing here distinguishes the two.
    if [ "${BADC_RUN_DIAG:-}" = "1" ]; then
        echo "=== shell ${label} probe ===" >&2
        ls -la "${shell_bin}" >&2 || true
        set +e
        "${shell_bin}" </dev/null
        local probe_rc=$?
        set -e
        echo "=== shell ${label} direct exit=${probe_rc} ===" >&2
    fi

    # ---- in-memory smoke ----
    # Covers the basic CRUD path plus all five integer aggregates
    # (count / sum / avg / min / max). avg() exercises sqlite's
    # vdbeMemRenderNum / FpDecode digit-pair writer, which depends
    # on real 16-bit `*(u16*)` loads/stores via `Op::Lh` / `Op::Sh`.
    local inmem_out inmem_expect
    inmem_out="$(printf "CREATE TABLE t(x INTEGER, y TEXT);\nINSERT INTO t VALUES(-7,'neg'),(1,'hello'),(2,'world');\nSELECT * FROM t;\nSELECT count(*),sum(x),avg(x),min(x),max(x) FROM t;\n.quit\n" | "${shell_bin}" | tr -d '\r')"
    inmem_expect="-7|neg
1|hello
2|world
3|-4|-1.3333333333333333|-7|2"
    if [ "${inmem_out}" != "${inmem_expect}" ]; then
        echo "smoke FAIL [${label}]: in-memory output mismatch" >&2
        diff <(echo "${inmem_expect}") <(echo "${inmem_out}") >&2 || true
        fail=1
    fi

    # ---- math / aggregate / type-promotion coverage ----
    # Each sub-query exercises a specific path c5 has historically
    # tripped on:
    #   * count + DISTINCT  -- aggregate over a hashed key set
    #   * mixed integer arithmetic + abs / -1 wraparound
    #   * boundary integer literals at INT32_MIN / INT32_MAX so
    #     the parser, the bytecode immediate encoding, and the
    #     OP_Multiply path all see a real edge case
    #   * unsigned shift via `>>` of a high-bit-set value, the
    #     bug that broke avg before Op::Shru landed
    #   * `LENGTH("...")` -- string built-in over a UTF-8 literal
    #   * row-count and a `ORDER BY ... LIMIT` to make sure the
    #     vdbe sort path stays honest
    local math_out math_expect
    math_out="$(printf "CREATE TABLE n(v INTEGER);\nINSERT INTO n VALUES(1),(2),(3),(2),(1),(NULL);\nSELECT count(*),count(v),count(DISTINCT v) FROM n;\nSELECT abs(-9223372036854775807) - 1;\nSELECT 2147483647 + 1, -2147483647 - 1;\nSELECT 0xFFFFFFFF >> 1, 0xFFFFFFFF & 0xF;\nSELECT length('hello world');\nSELECT v FROM n WHERE v IS NOT NULL ORDER BY v DESC LIMIT 2;\n.quit\n" | "${shell_bin}" | tr -d '\r')"
    math_expect="6|5|3
9223372036854775806
2147483648|-2147483648
2147483647|15
11
3
2"
    if [ "${math_out}" != "${math_expect}" ]; then
        echo "smoke FAIL [${label}]: math output mismatch" >&2
        diff <(echo "${math_expect}") <(echo "${math_out}") >&2 || true
        fail=1
    fi

    # ---- REAL column + INTEGER -> REAL promotion aggregates ----
    # Direct REAL storage (no promotion): plain count/sum/avg/min/max
    # over a REAL column. Then the `INTEGER * 1.0` promotion path
    # which goes through sqlite's Kahan-Babuska-Neumaier accumulator
    # -- this used to return 0 because c5's compound assignment
    # (`rB *= rA` etc.) lowered to integer ops on the FP bit
    # patterns. Now a real regression marker.
    local real_out real_expect
    real_out="$(printf "CREATE TABLE r(x REAL);\nINSERT INTO r VALUES(1.5),(2.5),(3.5);\nSELECT count(*),sum(x),avg(x),min(x),max(x) FROM r;\nSELECT round(avg(x), 2) FROM r;\nCREATE TABLE i(x INTEGER);\nINSERT INTO i VALUES(-7),(1),(2);\nSELECT sum(x*1.0),avg(x*1.0),total(x) FROM i;\nSELECT 1.0 + 2.0, 3.5 - 1.5, 2.5 * 4.0, 9.0 / 4.0;\n.quit\n" | "${shell_bin}" | tr -d '\r')"
    real_expect="3|7.5|2.5|1.5|3.5
2.5
-4.0|-1.3333333333333333|-4.0
3.0|2.0|10.0|2.25"
    if [ "${real_out}" != "${real_expect}" ]; then
        echo "smoke FAIL [${label}]: REAL aggregate mismatch" >&2
        diff <(echo "${real_expect}") <(echo "${real_out}") >&2 || true
        fail=1
    fi

    # ---- string built-ins + JOIN coverage ----
    # Exercises:
    #   * string functions: substr / replace / lower / upper / trim /
    #     ltrim / rtrim / printf -- each is a separate codepath in
    #     sqlite's func.c, dispatched via the OP_Function vdbe op.
    #   * INNER JOIN ... ON: query planner picks a nested-loop join
    #     and the row callback path threads result columns from
    #     two cursors.
    #   * LEFT JOIN: NULL-fill for unmatched right-side rows;
    #     proves the type-coercion path for IS NULL ordering.
    #   * group_concat: variable-length string aggregator that
    #     uses sqlite3_str_appendf (and through it the c5-side
    #     vsnprintf via the stdio.h macro).
    #   * UNION ALL: row-set merge; tests the multiple-source
    #     iterator dispatch.
    # Built via printf so trailing whitespace on `  alice  ` rows
    # round-trips exactly -- a HEREDOC-style string literal would
    # leak through editor / VCS auto-trim and silently shift the
    # diff baseline.
    local strjoin_out strjoin_expect
    strjoin_out="$(printf "CREATE TABLE u(id INTEGER, name TEXT);\nINSERT INTO u VALUES(1,'  alice  '),(2,'BOB'),(3,'Carol');\nSELECT id,upper(trim(name)),length(name),substr(name,1,3) FROM u ORDER BY id;\nSELECT replace('hello world','world','sqlite');\nSELECT lower('MiXeD'),ltrim('   pad'),rtrim('pad   ');\nSELECT group_concat(name,'/') FROM u;\nCREATE TABLE p(uid INTEGER, lang TEXT);\nINSERT INTO p VALUES(1,'rust'),(1,'c'),(3,'go');\nSELECT u.name,p.lang FROM u INNER JOIN p ON u.id=p.uid ORDER BY u.id,p.lang;\nSELECT u.name,p.lang FROM u LEFT JOIN p ON u.id=p.uid ORDER BY u.id,p.lang;\nSELECT name FROM u WHERE id=1 UNION ALL SELECT name FROM u WHERE id=3 ORDER BY name;\n.quit\n" | "${shell_bin}" | tr -d '\r')"
    strjoin_expect="$(printf '1|ALICE|9|  a\n2|BOB|3|BOB\n3|CAROL|5|Car\nhello sqlite\nmixed|pad|pad\n  alice  /BOB/Carol\n  alice  |c\n  alice  |rust\nCarol|go\n  alice  |c\n  alice  |rust\nBOB|\nCarol|go\n  alice  \nCarol')"
    if [ "${strjoin_out}" != "${strjoin_expect}" ]; then
        echo "smoke FAIL [${label}]: string/join output mismatch" >&2
        diff <(echo "${strjoin_expect}") <(echo "${strjoin_out}") >&2 || true
        fail=1
    fi

    # ---- WITH RECURSIVE + transaction + introspection ----
    # Exercises:
    #   * WITH RECURSIVE: vdbe builds an internal table and loops
    #     until the recursive arm produces no new rows. Hits the
    #     OP_Yield / OP_NextEphemeral path that the per-row eval
    #     and integer-arith fixes (gh #34, gh #37) underwrote.
    #   * BEGIN / ROLLBACK: full WAL-less rollback restores prior
    #     state from the rollback journal -- relies on file I/O
    #     working end-to-end, which the file-backed smoke also
    #     covers but rollback adds the journal-replay path.
    #   * UPDATE ... WHERE / DELETE ... WHERE multi-row: the
    #     vdbe row-update loop with cursor seek.
    #   * `.tables` and `.schema` dot-commands (via cli_printf
    #     -> sqlite3_vfprintf -> c5 vfprintf): proves the format
    #     specifier handling on tabular output and metadata
    #     queries.
    #
    # Only one WITH RECURSIVE per scenario today: under -O a
    # second WITH RECURSIVE following the first silently drops
    # all subsequent queries. Tracked as gh #30; restore the
    # fib-shape recursion here once that lands.
    local cte_out cte_expect
    cte_out="$(printf "CREATE TABLE k(v INTEGER);\nINSERT INTO k VALUES(10),(20),(30),(40),(50);\nWITH RECURSIVE c(n) AS (SELECT 1 UNION ALL SELECT n+1 FROM c WHERE n<5) SELECT n,n*n FROM c;\nBEGIN;\nUPDATE k SET v=v+100 WHERE v>=30;\nSELECT v FROM k ORDER BY v;\nROLLBACK;\nSELECT v FROM k ORDER BY v;\nDELETE FROM k WHERE v>20;\nSELECT count(*) FROM k;\n.tables\nCREATE TABLE meta(id INTEGER PRIMARY KEY, note TEXT);\n.schema meta\n.quit\n" | "${shell_bin}" | tr -d '\r')"
    cte_expect="1|1
2|4
3|9
4|16
5|25
10
20
130
140
150
10
20
30
40
50
2
k
CREATE TABLE meta(id INTEGER PRIMARY KEY, note TEXT);"
    if [ "${cte_out}" != "${cte_expect}" ]; then
        echo "smoke FAIL [${label}]: CTE / txn / introspection mismatch" >&2
        diff <(echo "${cte_expect}") <(echo "${cte_out}") >&2 || true
        fail=1
    fi

    # ---- file-backed smoke ----
    local db file_out reopen_out reopen_expect
    db="${WORK}/${label}.db"
    rm -f "${db}"
    file_out="$(printf ".open ${db}\nCREATE TABLE t(x INTEGER, y TEXT);\nINSERT INTO t VALUES(-7,'neg'),(1,'hello'),(2,'world');\n.quit\n" | "${shell_bin}" | tr -d '\r')"
    if [ -n "${file_out}" ]; then
        echo "smoke FAIL [${label}]: file-backed write produced unexpected output: ${file_out}" >&2
        fail=1
    fi
    if [ ! -s "${db}" ]; then
        echo "smoke FAIL [${label}]: file-backed write left empty db at ${db}" >&2
        fail=1
    fi

    # Reopen and read back -- proves the rows really persisted.
    reopen_out="$(printf ".open ${db}\nSELECT * FROM t ORDER BY x;\n.quit\n" | "${shell_bin}" | tr -d '\r')"
    reopen_expect="-7|neg
1|hello
2|world"
    if [ "${reopen_out}" != "${reopen_expect}" ]; then
        echo "smoke FAIL [${label}]: file-backed reopen output mismatch" >&2
        diff <(echo "${reopen_expect}") <(echo "${reopen_out}") >&2 || true
        fail=1
    fi

    if [ "${fail}" -eq 0 ]; then
        echo "smoke OK [${label}]: in-memory + file-backed both green"
    fi
    return "${fail}"
}

SHELL_NOOPT="${WORK}/sqlite3shell${EXE_SUFFIX}"
SHELL_OPT="${WORK}/sqlite3shell.opt${EXE_SUFFIX}"

build_shell "${SHELL_NOOPT}"      || { echo "smoke FAIL: build (no -O) failed" >&2; exit 1; }
build_shell "${SHELL_OPT}"     -O || { echo "smoke FAIL: build (-O) failed" >&2; exit 1; }

# `diag.c` is a tiny stderr-tracing shell-shim that exercises the
# sqlite C API against `:memory:` over piped stdin without any of
# shell.c's tty / line-editor / console-mode plumbing. When
# BADC_RUN_DIAG=1 (set by the Windows CI lane), build + run it
# with the in-memory smoke input so the CI log captures
# checkpoint stderr from each sqlite step. If the regular shell
# emits empty stdout but diag prints rows, the bug is shell.c-
# specific; if both are silent, the bug is below shell.c.
if [ "${BADC_RUN_DIAG:-}" = "1" ]; then
    # Tier 0 probe: enumerate which msvcrt + kernel32 symbols
    # GetProcAddress can resolve at runtime. The hello+sqlite IAT
    # references ~85 symbols statically; if the loader rejects
    # the binary with STATUS_ENTRYPOINT_NOT_FOUND (errorlevel
    # -1073741511), it's because ONE of those names isn't
    # exported by the runner's DLLs. This probe loads each DLL
    # via LoadLibraryA + GetProcAddress so we get a per-symbol
    # `OK` / `MISSING` line in the CI log.
    PROBE_BIN="${WORK}/sqlite3probe${EXE_SUFFIX}"
    "${BADC}" -include msvc_compat.h "${SQLITE_DIR}/probe_imports.c" -o "${PROBE_BIN}" \
        || echo "probe: build failed" >&2
    # Tier 0.5: shell-startup probe -- replicates shell.c's first
    # few main() statements (setvbuf / isatty / atexit / fgetc)
    # with stderr checkpoints between each call. shell.exe is
    # SIGSEGVing on real Windows; this isolates which call.
    SSP_BIN="${WORK}/sqlite3sshell_startup${EXE_SUFFIX}"
    "${BADC}" -include msvc_compat.h "${SQLITE_DIR}/shell_startup_probe.c" -o "${SSP_BIN}" \
        || echo "shell-startup-probe: build failed" >&2
    if [ -e "${SSP_BIN}" ]; then
        echo "=== shell-startup-probe run ===" >&2
        set +e
        "${SSP_BIN}" </dev/null
        ssp_rc=$?
        set -e
        echo "=== shell-startup-probe bash exit=${ssp_rc} ===" >&2
        if command -v cmd.exe >/dev/null 2>&1; then
            if command -v cygpath >/dev/null 2>&1; then
                ssp_winpath=$(cygpath -w "${SSP_BIN}")
            else
                ssp_winpath="${SSP_BIN}"
            fi
            cmd.exe //v:on //c "${ssp_winpath} 2>&1 < NUL & echo errorlevel=!errorlevel!" >&2 || true
        fi
        echo "=== /shell-startup-probe ===" >&2
    fi

    if [ -e "${PROBE_BIN}" ]; then
        echo "=== probe imports run ===" >&2
        set +e
        "${PROBE_BIN}" </dev/null
        probe_rc=$?
        set -e
        echo "=== probe imports bash exit=${probe_rc} ===" >&2
        if command -v cmd.exe >/dev/null 2>&1; then
            if command -v cygpath >/dev/null 2>&1; then
                probe_winpath=$(cygpath -w "${PROBE_BIN}")
            else
                probe_winpath="${PROBE_BIN}"
            fi
            echo "=== probe imports cmd.exe (winpath=${probe_winpath}) ===" >&2
            cmd.exe //v:on //c "${probe_winpath} 2>&1 & echo errorlevel=!errorlevel!" >&2 || true
            echo "=== /probe imports cmd.exe ===" >&2
        fi
    fi

    # Tier 1 probe: dead-minimal hello-world (no sqlite, no shell,
    # no fprintf). If THIS exits non-zero, the failure is in the
    # entry stub / loader path itself, not sqlite-imports-related.
    HELLO_BIN="${WORK}/sqlite3hello${EXE_SUFFIX}"
    "${BADC}" -include msvc_compat.h "${SQLITE_DIR}/hello.c" -o "${HELLO_BIN}" \
        || echo "hello: build failed" >&2
    if [ -e "${HELLO_BIN}" ]; then
        echo "=== hello run ===" >&2
        ls -la "${HELLO_BIN}" >&2 || true
        if command -v file >/dev/null 2>&1; then
            file "${HELLO_BIN}" >&2 || true
        fi
        set +e
        "${HELLO_BIN}" </dev/null
        hello_rc=$?
        set -e
        echo "=== hello bash exit=${hello_rc} ===" >&2
    fi

    # Tier 1.5: hello+sqlite -- minimal main + the entire sqlite
    # amalgamation linked in. If hello.c works alone but this
    # tier exits non-zero, the failure is the IAT pulled in by
    # sqlite (some symbol the runner's msvcrt / kernel32 doesn't
    # export), not anything sqlite does at runtime.
    HELLOSQ_BIN="${WORK}/sqlite3hellosq${EXE_SUFFIX}"
    HELLOSQ_COMBINED="${WORK}/sqlite3hellosq_combined.c"
    cat "${SQLITE_DIR}/sqlite3.c" "${SQLITE_DIR}/hello.c" > "${HELLOSQ_COMBINED}"
    "${BADC}" -include msvc_compat.h "${HELLOSQ_COMBINED}" -o "${HELLOSQ_BIN}" \
        -DSQLITE_OMIT_LOAD_EXTENSION \
        -DSQLITE_THREADSAFE=0 \
        -DSQLITE_DEFAULT_MEMSTATUS=0 \
        -DSQLITE_DEFAULT_WAL_SYNCHRONOUS=1 \
        -DSQLITE_DQS=0 \
        -DSQLITE_OMIT_DEPRECATED \
        -DSQLITE_OMIT_PROGRESS_CALLBACK \
        -DSQLITE_OMIT_SHARED_CACHE \
        -DSQLITE_OMIT_AUTOINIT \
        -DSQLITE_WITHOUT_ZONEMALLOC=1 \
        -DSQLITE_ENABLE_LOCKING_STYLE=0 \
        -DSQLITE_DISABLE_INTRINSIC \
        -DSQLITE_OMIT_SEH || echo "hellosq: build failed" >&2
    if [ -e "${HELLOSQ_BIN}" ]; then
        echo "=== hello+sqlite run ===" >&2
        # Run from a tmp directory so the side-channel `hello.proof`
        # file (written by main if main runs at all) lands in a
        # known place we can inspect afterwards regardless of which
        # invocation path actually printed.
        proof_dir="${WORK}/proof_run"
        mkdir -p "${proof_dir}"
        rm -f "${proof_dir}/hello.proof"
        set +e
        ( cd "${proof_dir}" && "${HELLOSQ_BIN}" </dev/null )
        hellosq_rc=$?
        set -e
        echo "=== hello+sqlite bash exit=${hellosq_rc} ===" >&2
        if [ -f "${proof_dir}/hello.proof" ]; then
            echo "=== hello+sqlite proof-file present ===" >&2
            cat "${proof_dir}/hello.proof" >&2
            echo "=== /hello+sqlite proof-file ===" >&2
        else
            echo "=== hello+sqlite proof-file ABSENT (main never ran or fopen failed) ===" >&2
        fi
        if command -v cmd.exe >/dev/null 2>&1; then
            if command -v cygpath >/dev/null 2>&1; then
                winpath=$(cygpath -w "${HELLOSQ_BIN}")
            else
                winpath="${HELLOSQ_BIN}"
            fi
            rm -f "${proof_dir}/hello.proof"
            echo "=== hello+sqlite cmd.exe probe (winpath=${winpath}) ===" >&2
            # `/v:on` enables delayed expansion so `!errorlevel!` is
            # evaluated AFTER the binary runs (without it, cmd.exe
            # substitutes %errorlevel% at parse time -- before the
            # spawn -- giving the meaningless 0 from the outer shell).
            ( cd "${proof_dir}" && cmd.exe //v:on //c "${winpath} 2>&1 & echo errorlevel=!errorlevel!" >&2 ) || true
            if [ -f "${proof_dir}/hello.proof" ]; then
                echo "=== hello+sqlite cmd-proof present ===" >&2
                cat "${proof_dir}/hello.proof" >&2
                echo "=== /hello+sqlite cmd-proof ===" >&2
            else
                echo "=== hello+sqlite cmd-proof ABSENT ===" >&2
            fi
            echo "=== /hello+sqlite cmd.exe probe ===" >&2
        fi
    fi

    DIAG_BIN="${WORK}/sqlite3diag${EXE_SUFFIX}"
    DIAG_COMBINED="${WORK}/sqlite3diag_combined.c"
    cat "${SQLITE_DIR}/sqlite3.c" "${SQLITE_DIR}/diag.c" > "${DIAG_COMBINED}"
    "${BADC}" -include msvc_compat.h "${DIAG_COMBINED}" -o "${DIAG_BIN}" \
        -DSQLITE_OMIT_LOAD_EXTENSION \
        -DSQLITE_THREADSAFE=0 \
        -DSQLITE_DEFAULT_MEMSTATUS=0 \
        -DSQLITE_DEFAULT_WAL_SYNCHRONOUS=1 \
        -DSQLITE_DQS=0 \
        -DSQLITE_OMIT_DEPRECATED \
        -DSQLITE_OMIT_PROGRESS_CALLBACK \
        -DSQLITE_OMIT_SHARED_CACHE \
        -DSQLITE_OMIT_AUTOINIT \
        -DSQLITE_WITHOUT_ZONEMALLOC=1 \
        -DSQLITE_ENABLE_LOCKING_STYLE=0 \
        -DSQLITE_DISABLE_INTRINSIC \
        -DSQLITE_OMIT_SEH || { echo "diag: build failed" >&2; }
    if [ -e "${DIAG_BIN}" ]; then
        echo "=== diag artefact ===" >&2
        ls -la "${DIAG_BIN}" >&2 || true
        if command -v file >/dev/null 2>&1; then
            file "${DIAG_BIN}" >&2 || true
        fi
        echo "=== diag run (in-memory smoke input) ===" >&2
        # Wrap each invocation in a `set +e` block: the smoke
        # script otherwise runs under `set -e -o pipefail`, so a
        # non-zero exit from the diag binary kills the script
        # before the regular shell smoke gets a chance to run --
        # which loses the diff output for the actual lane the
        # CI step is gated on.
        set +e
        # Direct invocation (no pipe) first to probe the loader.
        # /dev/null on stdin so it doesn't hang waiting for input.
        "${DIAG_BIN}" </dev/null
        ddir=$?
        echo "=== diag direct exit=${ddir} ===" >&2
        printf "CREATE TABLE t(x INTEGER, y TEXT);\nINSERT INTO t VALUES(-7,'neg'),(1,'hello'),(2,'world');\nSELECT * FROM t;\n.quit\n" \
            | "${DIAG_BIN}"
        dpip=$?
        echo "=== diag piped exit=${dpip} ===" >&2
        set -e
        echo "=== /diag run ===" >&2
    else
        echo "=== diag binary not produced at ${DIAG_BIN} ===" >&2
    fi
fi

overall=0
run_scenarios "no-O" "${SHELL_NOOPT}" || overall=1
run_scenarios "-O"   "${SHELL_OPT}"   || overall=1
exit "${overall}"
