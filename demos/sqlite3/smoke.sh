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
if [ ! -x "${BADC}" ]; then
    echo "smoke: BADC=${BADC} not found / not executable" >&2
    echo "       hint: cargo build --release --manifest-path=${REPO_ROOT}/Cargo.toml" >&2
    exit 2
fi

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
    "${BADC}" "$@" "${COMBINED}" -o "${out_path}" \
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
        -DSQLITE_ENABLE_LOCKING_STYLE=0
}

run_scenarios() {
    local label="$1"
    local shell_bin="$2"
    local fail=0

    # ---- in-memory smoke ----
    # Covers the basic CRUD path plus all five integer aggregates
    # (count / sum / avg / min / max). avg() exercises sqlite's
    # vdbeMemRenderNum / FpDecode digit-pair writer, which depends
    # on real 16-bit `*(u16*)` loads/stores via `Op::Lh` / `Op::Sh`.
    local inmem_out inmem_expect
    inmem_out="$(printf "CREATE TABLE t(x INTEGER, y TEXT);\nINSERT INTO t VALUES(-7,'neg'),(1,'hello'),(2,'world');\nSELECT * FROM t;\nSELECT count(*),sum(x),avg(x),min(x),max(x) FROM t;\n.quit\n" | "${shell_bin}")"
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
    math_out="$(printf "CREATE TABLE n(v INTEGER);\nINSERT INTO n VALUES(1),(2),(3),(2),(1),(NULL);\nSELECT count(*),count(v),count(DISTINCT v) FROM n;\nSELECT abs(-9223372036854775807) - 1;\nSELECT 2147483647 + 1, -2147483647 - 1;\nSELECT 0xFFFFFFFF >> 1, 0xFFFFFFFF & 0xF;\nSELECT length('hello world');\nSELECT v FROM n WHERE v IS NOT NULL ORDER BY v DESC LIMIT 2;\n.quit\n" | "${shell_bin}")"
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
    real_out="$(printf "CREATE TABLE r(x REAL);\nINSERT INTO r VALUES(1.5),(2.5),(3.5);\nSELECT count(*),sum(x),avg(x),min(x),max(x) FROM r;\nSELECT round(avg(x), 2) FROM r;\nCREATE TABLE i(x INTEGER);\nINSERT INTO i VALUES(-7),(1),(2);\nSELECT sum(x*1.0),avg(x*1.0),total(x) FROM i;\nSELECT 1.0 + 2.0, 3.5 - 1.5, 2.5 * 4.0, 9.0 / 4.0;\n.quit\n" | "${shell_bin}")"
    real_expect="3|7.5|2.5|1.5|3.5
2.5
-4.0|-1.3333333333333333|-4.0
3.0|2.0|10.0|2.25"
    if [ "${real_out}" != "${real_expect}" ]; then
        echo "smoke FAIL [${label}]: REAL aggregate mismatch" >&2
        diff <(echo "${real_expect}") <(echo "${real_out}") >&2 || true
        fail=1
    fi

    # ---- file-backed smoke ----
    local db file_out reopen_out reopen_expect
    db="${WORK}/${label}.db"
    rm -f "${db}"
    file_out="$(printf ".open ${db}\nCREATE TABLE t(x INTEGER, y TEXT);\nINSERT INTO t VALUES(-7,'neg'),(1,'hello'),(2,'world');\n.quit\n" | "${shell_bin}")"
    if [ -n "${file_out}" ]; then
        echo "smoke FAIL [${label}]: file-backed write produced unexpected output: ${file_out}" >&2
        fail=1
    fi
    if [ ! -s "${db}" ]; then
        echo "smoke FAIL [${label}]: file-backed write left empty db at ${db}" >&2
        fail=1
    fi

    # Reopen and read back -- proves the rows really persisted.
    reopen_out="$(printf ".open ${db}\nSELECT * FROM t ORDER BY x;\n.quit\n" | "${shell_bin}")"
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

build_shell "${WORK}/sqlite3shell"      || { echo "smoke FAIL: build (no -O) failed" >&2; exit 1; }
build_shell "${WORK}/sqlite3shell.opt" -O || { echo "smoke FAIL: build (-O) failed" >&2; exit 1; }

overall=0
run_scenarios "no-O" "${WORK}/sqlite3shell" || overall=1
run_scenarios "-O"   "${WORK}/sqlite3shell.opt" || overall=1
exit "${overall}"
