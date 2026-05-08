#!/usr/bin/env bash
# Fetch the SQLite amalgamation tarball and apply the badc/c5
# patches. After this runs, `demos/sqlite3/{sqlite3.c, shell.c,
# sqlite3.h, sqlite3ext.h}` exist and are ready for badc to
# compile against.
#
# Idempotent: re-running re-extracts the vanilla files and
# re-applies the patches. Safe to call from CI before each smoke
# run. Output is suppressed unless something fails -- pass
# `-v` to see every step.
#
# Versioned to a single SQLite release to keep the patch
# offsets stable; bump when upstream SQLite changes any of the
# patched lines.

set -euo pipefail

VERBOSE=0
if [ "${1:-}" = "-v" ]; then VERBOSE=1; shift; fi
log() { [ "$VERBOSE" -eq 1 ] && echo "$@" >&2 || true; }

VERSION="3530000"        # 3.53.0 (April 2026)
URL="https://www.sqlite.org/2026/sqlite-amalgamation-${VERSION}.zip"

# Resolve script dir (`demos/sqlite3/`) regardless of CWD.
SELF="${BASH_SOURCE[0]}"
SQLITE_DIR="$(cd "$(dirname "$SELF")" && pwd)"
PATCHES_DIR="${SQLITE_DIR}/patches"
CACHE_DIR="${SQLITE_DIR}/.cache"
ZIP="${CACHE_DIR}/sqlite-amalgamation-${VERSION}.zip"
EXTRACTED="${CACHE_DIR}/sqlite-amalgamation-${VERSION}"

mkdir -p "${CACHE_DIR}"

# Fetch the zip if we don't have a cached copy.
if [ ! -f "${ZIP}" ]; then
    log "fetching ${URL}"
    curl -fsSL -o "${ZIP}" "${URL}"
fi

# Re-extract the four files we care about (overwriting any
# previous patch state). `unzip -o` overwrites without prompting.
log "extracting amalgamation"
rm -rf "${EXTRACTED}"
unzip -q -o "${ZIP}" -d "${CACHE_DIR}"

# Drop the four upstream files into the sqlite dir.
for f in sqlite3.c sqlite3.h sqlite3ext.h shell.c; do
    cp "${EXTRACTED}/${f}" "${SQLITE_DIR}/${f}"
done

# Apply each patch. `-p1` strips the `a/` / `b/` prefixes the
# patches were generated with. `-d` runs the patch in the sqlite
# dir so the relative filenames inside the patch resolve. The
# `compgen -G` guard makes the empty-patches-directory case a
# clean no-op rather than a "file not found" error from the
# shell glob expanding to itself.
if compgen -G "${PATCHES_DIR}/*.patch" > /dev/null; then
    for p in "${PATCHES_DIR}"/*.patch; do
        log "applying $(basename "$p")"
        patch -d "${SQLITE_DIR}" -p1 -s -i "$p"
    done
else
    log "no patches to apply (clean upstream)"
fi

log "done -- $(ls -l "${SQLITE_DIR}"/{sqlite3.c,shell.c} | awk '{print $9, $5}')"
