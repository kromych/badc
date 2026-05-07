// DEFERRED (#46): optimizer regression on the sqlite3 WHERE
// path. The `:memory:` smoke (CREATE / INSERT / SELECT plain
// aggregates / GROUP BY) all run cleanly with `-O` on the
// host; what stays broken is any query whose WHERE clause
// compares against the literal `0`:
//
//   `SELECT * FROM t WHERE x > 0;`
//   `SELECT count(*) FILTER (WHERE x > 0) FROM t;`
//   `SELECT count(*) FROM (VALUES ...) WHERE column1 > 0;`
//
// Equivalent forms (`> 1`, `>= 1`, `!= -1`) work cleanly. The
// trigger is sqlite's special-case handling of the constant
// zero in the WHERE clause -- VDBE codegen routes `> 0` through
// an OP_IfPos / OP_NotNull-shaped opcode whose c5 lowering
// regresses under one of the optimizer peephole passes.
//
// Bisected with `BADC_OPT_OFF=<pass>`: disabling
// `peephole_immediate_arith` cuts the deterministic crash rate
// from 5/5 to ~1/5, so the immediate-arith fusion is involved
// but isn't the whole story. The remaining 4/5 fail rate with
// imm_arith off and 0/5 fail rate at non-`-O` together imply a
// downstream interaction (regalloc analyzer? branch-target
// stale-snapshot? cmp+branch fusion?) that flips on once any
// `-O` pass mutates the bytecode shape.
//
// No `-O`                       : 5/5 pass.
// `-O` plus `> 1`               : 5/5 pass.
// `-O` plus `> 0`               : 5/5 SIGSEGV.
// `-O BADC_OPT_OFF=imm_arith`   : ~1/5 pass (flaky).
//
// `demos/sqlite3/smoke.sh` exercises the `-O` lane against the
// full in-memory + file-backed scenarios (which all pass), so
// when this regression closes the existing CI step will confirm
// the broader path stays green. The c5-only repro still hasn't
// been extracted -- the smallest known trigger is a 200KLoC
// sqlite amalgamation; isolated `if (n > 0) ...` patterns
// compile and run correctly under `-O`.
#include <stdio.h>

int main() {
    // Placeholder: when the optimizer-on-sqlite3 lane goes
    // green this fixture should be replaced with a minimised
    // repro.
    return 0;
}
