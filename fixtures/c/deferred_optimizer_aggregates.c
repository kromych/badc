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
//   ==N==    at 0x172FBD  (mov r13, [r13])  <-- Op::Li
//   ==N==  Address 0x8 is not stack'd, malloc'd or (recently) free'd
//
// (file offsets, ELF base 0x400000.) The faulting instruction is
// not in any prologue/epilogue -- it's the bytecode-level `Op::Li`
// dereference, with r13 = 8. The native instruction stream right
// before the crash is:
//
//   imul r13, r12         ; Op::Mul -- r13 = 40 * r12
//   add  r13, rbx         ; Op::Add -- r13 += rbx
//   mov  r13, [r13]       ; Op::Li  -- CRASH here
//
// Walking the surrounding bytecode shows the c5 source is doing
// `*(p + 8)` where `p = *(local2 + 32)`. With rbx == (8 + p) and
// r12 == 0 (a literal constant index), the imul-then-add yields
// `8 + p`, then Li reads `*(8 + p)`. If p is NULL the read lands
// at address 8 -- which matches valgrind's report exactly.
//
// So the *direct* faulting condition is "C source dereferences a
// NULL struct-pointer field." Sqlite's own source is well-tested,
// so the more likely story is: under -O some upstream control flow
// or value tracking goes wrong and we reach the deref with the
// pointer field still NULL when in the no-O lane the same path
// either branches around it or the field has been initialised by
// then. With BADC_RSP_CHECK=1 (the new prologue/epilogue runtime
// stack-pointer guard) I confirmed rsp and rbp stay sane all the
// way up the call chain -- the corruption is *value*-level, not
// stack-level.
//
// The c5-emitted bytecode for this sequence is identical with and
// without `peephole_local_load` (the only difference is the fused
// LdLocI 2 vs the unfused Lea 2 + Li, both of which compile to
// the same load `mov r13, [rbp+16]`). The regalloc plan dump
// (BADC_DUMP_PLAN=1) also matches across the two configurations,
// modulo the expected `ent_pc` shift. So whatever the optimizer
// changes that flips this query from "works" to "crashes" is
// subtle -- not a wrong instruction encoding, not a wrong pool
// depth.
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
//   BADC_DUMP_PLAN=1             dump per-function regalloc plan
//                                 (ent_pc, callee_depth,
//                                 caller_depth, use_pool) to
//                                 stderr. Diff with/without an
//                                 optimizer pass to see if the
//                                 plan drifts.
//   BADC_RSP_CHECK=1             instrument every prologue/
//                                 epilogue with a runtime guard
//                                 that traps (`ud2`) if rsp or
//                                 rbp drops below 0x1000.
//                                 Useful for catching stack
//                                 corruption upstream of where
//                                 it visibly faults.
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
// hours. The predicate skeleton is in `/tmp/reduce/check.sh` (see
// the deferred-#46 development branch).
//
// Likely next steps to actually fix:
//   1. Extract a c5-only repro via `creduce` (multi-hour run).
//   2. Once the repro is small (<200 lines), bisect via
//      `BADC_OPT_FUNC_RANGE` until the buggy function is named.
//   3. Inspect the codegen difference between fused and unfused
//      forms for that function -- the visible IR/regalloc is
//      already known to match, so look at side-channels: data
//      relocs, code relocs, pending_func_fixups, code_imm_positions.
//   4. The optimizer drops `code_imm_positions` and falls back to
//      the [CODE_BASE, CODE_BASE + text.len()) heuristic for
//      function-pointer literals. If a regular int constant lands
//      in that range it gets misclassified -- and the range shrinks
//      by exactly the bytes the optimizer removes, which means the
//      misclassification window is sensitive to which passes ran.
//      Worth checking first.
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
