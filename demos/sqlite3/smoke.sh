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
    # avg() is intentionally excluded: sqlite's vdbeMemRenderNum
    # uses 16-bit `*(u16*)` digit-pair writes, but c5's pointer-
    # deref of `unsigned short *` lowers to a 32-bit access (no
    # `Op::Sh` / `Op::Lh` in the dialect yet). The buffer ends
    # up empty for any %g formatting of a non-integer double. See
    # fixtures/c/deferred_u16_load_store.c.
    local inmem_out inmem_expect
    inmem_out="$(printf "CREATE TABLE t(x INTEGER, y TEXT);\nINSERT INTO t VALUES(-7,'neg'),(1,'hello'),(2,'world');\nSELECT * FROM t;\nSELECT count(*),sum(x),min(x),max(x) FROM t;\n.quit\n" | "${shell_bin}")"
    inmem_expect="-7|neg
1|hello
2|world
3|-4|-7|2"
    if [ "${inmem_out}" != "${inmem_expect}" ]; then
        echo "smoke FAIL [${label}]: in-memory output mismatch" >&2
        diff <(echo "${inmem_expect}") <(echo "${inmem_out}") >&2 || true
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
