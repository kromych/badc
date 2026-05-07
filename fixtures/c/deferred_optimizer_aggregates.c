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
// Bisected with `BADC_OPT_OFF=<pass>`: the culprit is
// `peephole_immediate_arith` (the Psh/Imm/op -> opI fusion).
// Disabling just that pass makes every `> 0` query correct;
// every other peephole pass is innocent. So the bug is in how
// one of the immediate-form lowerings (likely `GtI 0`) feeds
// into a downstream branch -- presumably the cmp+branch fusion
// gate (writes_x19_first / fusion_candidate) is wrong for one
// of these compare-immediate ops in some control-flow shape.
//
// No `-O`                       : pass.
// `-O` plus `> 1`               : pass.
// `-O` plus `> 0`               : SIGSEGV.
// `-O BADC_OPT_OFF=imm_arith`   : pass.
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
