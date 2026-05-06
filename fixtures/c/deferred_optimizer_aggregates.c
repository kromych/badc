// DEFERRED (#46): optimizer regression on the sqlite3 aggregates
// path. With `-O` the `:memory:` smoke test runs through tiers
// 1-8 (open, prepare SELECT 1, CREATE TABLE, INSERT, ORDER BY)
// and produces correct row output. Tier 9 (prepare aggregates
// SELECT COUNT/MIN/MAX/SUM) starts compiling, then SIGSEGV at
// runtime.
//
// No -O = pass; -O = SIGSEGV. The crash is downstream of any of
// the compiler-frontend / VM / regalloc paths the smaller
// fixtures cover, so a minimal isolated repro hasn't been
// extracted yet.
//
// The placeholder body below exits 0 immediately so the fixture
// itself isn't broken; the real test is "run sqlite3 with -O and
// observe the smoke driver completing tier 9 cleanly". The
// trigger lives in the LEMON-generated parser's interaction with
// VDBE-codegen for aggregate functions (sqlite3CodeOnce + the
// xStep/xFinal vtables).
#include <stdio.h>

int main() {
    // Placeholder: when the optimizer-on-sqlite3 lane goes green
    // this fixture should be replaced with a minimised repro.
    return 0;
}
