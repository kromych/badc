// DEFERRED (#46): per-arch codegen bugs triggered by the
// bytecode optimizer's output on the sqlite3 amalgamation. The
// `:memory:` smoke (CREATE / INSERT / SELECT plain aggregates /
// GROUP BY) all run cleanly at -O; what stays broken is any
// query whose WHERE clause compares against the literal `0`:
//
//   `SELECT * FROM t WHERE x > 0;`
//   `SELECT count(*) FILTER (WHERE x > 0) FROM t;`
//   `SELECT count(*) FROM (VALUES ...) WHERE column1 > 0;`
//
// Equivalent forms (`> 1`, `>= 1`, `!= -1`) work cleanly. The
// trigger is sqlite's special-case handling of the constant
// zero in the WHERE clause -- VDBE codegen routes `> 0` through
// an OP_IfPos / OP_NotNull-shaped opcode whose c5 lowering
// regresses under -O.
//
// ## What we know
//
// The bug is **deterministic on Linux** (5/5 SIGSEGV at -O,
// 5/5 pass without). The flakiness we used to see on macOS arm64
// was cache / address-randomization noise; under Valgrind on
// Linux it reproduces every time at the same native PC.
//
// Valgrind on a Linux x64 build at -O fingerprints the crash:
//
//   ==N== Invalid read of size 8
//   ==N==    at 0x55E17F  (mov r13, [rsp])
//   ==N==  Address 0x8 is not stack'd, malloc'd or (recently) free'd
//
// That's the `mov r13, [rsp]` step inside a callee's epilogue
// reading from rsp == 0x8. rsp is a tiny positive number means
// the SP got corrupted somewhere up the call chain -- not a
// pointer that happens to be NULL+8, but an actually-broken
// stack.
//
// ## Per-arch bisection
//
// The optimizer has seven peephole passes. Disabling them one
// at a time with `BADC_OPT_OFF=<pass>` localises the trigger
// per-arch:
//
//   linux-x64    : disabling `local_load`     -> 10/10 pass.
//   linux-arm64  : disabling `branch_thread`  -> 10/10 pass.
//   macos-arm64  : disabling `imm_arith`      -> 5/10 pass.
//
// Three different passes, three different arches. So this is
// not one optimizer bug -- it's three separate codegen bugs,
// each one tripped by a different optimizer rewrite that
// happens to be safe on the other two arches.
//
// Concretely:
//   * x64 codegen mishandles the `LdLocI`/`LdLocC` op that
//     `peephole_local_load` (Lea+Li/Lc -> LdLocI/LdLocC) emits.
//     Suspect: regalloc analyzer's accounting of pseudo vs real
//     pushes drifts because the fused IR shrinks.
//   * arm64 codegen mishandles the rewritten branch targets
//     `branch_threading` produces.
//   * darwin/arm64 codegen mishandles the `<op>I` immediate-
//     arithmetic forms `peephole_immediate_arith` emits.
//
// ## Reproducing
//
// The bisection-only env hooks (only active in std-feature
// builds) make the per-pass narrow:
//
//   BADC_OPT_OFF=<pass[,pass]>   skip those passes entirely.
//                                 names: constfold, branch_const,
//                                        jump_next, imm_arith,
//                                        local_load, branch_thread,
//                                        dce.
//   BADC_BC_OPT_OFF=1            disable the entire bytecode
//                                 optimizer (native regalloc still
//                                 runs at -O).
//   BADC_OPT_FUNC_RANGE=lo,hi    only let peephole work touch
//                                 the function-index range
//                                 [lo, hi). Useful once you have
//                                 a function-level repro.
//
// And the demo smoke script reproduces the crash at HEAD:
//
//   demos/sqlite3/smoke.sh -O   # or just `demos/sqlite3/smoke.sh`
//                                # which runs both lanes
//
// ## Status
//
// The c5-only repro still hasn't been extracted -- the smallest
// known trigger is the 10 MB sqlite amalgamation. `creduce`
// against a "exit 139 at -O, exit 0 without -O" predicate would
// land an isolated regression test; left for follow-up because
// each predicate run takes ~30 seconds and a full reduction is
// hours.
//
// `demos/sqlite3/smoke.sh` exercises the `-O` lane against the
// in-memory and file-backed scenarios with simpler aggregates
// (which all pass), so when this regression closes the existing
// CI step will confirm the broader path stays green.
#include <stdio.h>

int main() {
    // Placeholder: when the optimizer-on-sqlite3 lane goes green
    // this fixture should be replaced with a minimised repro
    // extracted via creduce.
    return 0;
}
