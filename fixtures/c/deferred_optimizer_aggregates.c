// DEFERRED (#46): optimizer regression on the sqlite3 aggregates
// path. The `:memory:` smoke (CREATE / INSERT / SELECT plain
// aggregates / GROUP BY) all run cleanly with `-O` on the
// host; what stays broken is one specific shape:
//
//   `SELECT count(*) FILTER (WHERE x op 0) FROM ...`
//
// where `op` is `>`, `!=` (or any comparison-against-the-
// literal-`0`). Equivalent forms (`>= 1`, `> 1`) work cleanly,
// so the trigger is sqlite's special-case handling of the
// constant zero in the WHERE clause -- VDBE codegen probably
// emits an op that c5/badc's optimizer mishandles. The crash
// is a SIGSEGV the moment the prepared statement runs, not a
// compile-time mismatch.
//
// No `-O`             : pass.
// `-O` plus `> 1`     : pass.
// `-O` plus `> 0`     : SIGSEGV.
//
// Reproducer is "build sqlite3 with -O and run the trigger
// query"; a minimal isolated c5 repro hasn't been extracted
// yet because the bug needs sqlite's VDBE-emit path to land on
// the specific opcode.
//
// `demos/sqlite3/smoke.sh` exercises the `-O` lane against the
// full in-memory + file-backed scenarios (which all pass), so
// when this regression closes the existing CI step will
// confirm the broader path stays green; the test below is a
// structural placeholder until a c5-only repro lands.
#include <stdio.h>

int main() {
    // Placeholder: when the optimizer-on-sqlite3 lane goes
    // green this fixture should be replaced with a minimised
    // repro.
    return 0;
}
