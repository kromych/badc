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

# The defines mirror what shell.c expects when compiled standalone.
SHELL_BIN="${WORK}/sqlite3shell"
"${BADC}" "${COMBINED}" -o "${SHELL_BIN}" \
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

fail=0

# ---- in-memory smoke ----
INMEM_OUT="$(printf "CREATE TABLE t(x INTEGER, y TEXT);\nINSERT INTO t VALUES(-7,'neg'),(1,'hello'),(2,'world');\nSELECT * FROM t;\nSELECT count(*),sum(x),avg(x),min(x),max(x) FROM t;\n.quit\n" | "${SHELL_BIN}")"
INMEM_EXPECT="-7|neg
1|hello
2|world
3|-4|0.2|-7|2"
if [ "${INMEM_OUT}" != "${INMEM_EXPECT}" ]; then
    echo "smoke FAIL: in-memory output mismatch" >&2
    diff <(echo "${INMEM_EXPECT}") <(echo "${INMEM_OUT}") >&2 || true
    fail=1
fi

# ---- file-backed smoke ----
DB="${WORK}/test.db"
FILE_OUT="$(printf ".open ${DB}\nCREATE TABLE t(x INTEGER, y TEXT);\nINSERT INTO t VALUES(-7,'neg'),(1,'hello'),(2,'world');\n.quit\n" | "${SHELL_BIN}")"
if [ -n "${FILE_OUT}" ]; then
    echo "smoke FAIL: file-backed write produced unexpected output: ${FILE_OUT}" >&2
    fail=1
fi
if [ ! -s "${DB}" ]; then
    echo "smoke FAIL: file-backed write left empty db at ${DB}" >&2
    fail=1
fi

# Reopen and read back -- proves the rows really persisted.
REOPEN_OUT="$(printf ".open ${DB}\nSELECT * FROM t ORDER BY x;\n.quit\n" | "${SHELL_BIN}")"
REOPEN_EXPECT="-7|neg
1|hello
2|world"
if [ "${REOPEN_OUT}" != "${REOPEN_EXPECT}" ]; then
    echo "smoke FAIL: file-backed reopen output mismatch" >&2
    diff <(echo "${REOPEN_EXPECT}") <(echo "${REOPEN_OUT}") >&2 || true
    fail=1
fi

if [ "${fail}" -eq 0 ]; then
    echo "smoke OK: in-memory + file-backed both green"
fi
exit "${fail}"
