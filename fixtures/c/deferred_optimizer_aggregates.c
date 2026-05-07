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
// ## The actual cause: saved-rbp corruption
//
// Walking a Linux x64 core dump with `tools/core-walker.py`:
//
//   #            rbp        ret_addr   resolved
//   0   7ffffffbb240               0   (rip=0 -- jumped to NULL)
//   1   7ffffffbb2f0      0x53a310   bc=325923 Jsr 318133
//   2         7ff618      0x524385   bc=302727 Jsr 304465
//                ↑
//                rbp is a *data-segment* address, not a stack
//                address. Frame 1's saved-rbp slot at
//                [0x7ffffffbb2f0+0] has been overwritten with
//                a 64-bit value that lives in the c5 binary's
//                RW data segment (file_offset 0x3ff618).
//
// Frame 1's [rbp+8] is also wrong: it holds 0x524385 = post-Jsr
// PC for `bc=302727 Jsr 304465`, but the function that owns
// frame 1 (= `bc=325765 Ent 5`) was actually called via one of
// nine different `Jsr 325765` sites in `bc=302522`'s body, none
// of which is bc=302727. So *both* the saved rbp and the saved
// return address in frame 1's prologue slots have been clobbered
// after the prologue ran but before the next call.
//
// The corruption mechanism is now concrete: somewhere up the
// call chain, function H's body wrote past its local frame and
// landed on the saved-rbp slot. H's epilogue then `pop rbp`
// loaded the garbage into rbp, restoring caller G with rbp
// pointing into the data segment. G eventually called F (frame
// 1 here), and F's prologue dutifully `push rbp` saved that
// garbage into F's [rbp+0] -- which is what we see in the core.
//
// `BADC_RSP_CHECK=1` doesn't fire because rsp stays valid the
// whole time (the corruption is to a *saved* rbp, not the live
// one), and at every epilogue the live rbp matches the live rsp
// just fine -- the wrong value gets picked up only at the next
// `pop rbp`, well after the guard has cleared.
//
// `BADC_SAVED_RBP_CHECK=1` -- a more targeted check that traps
// at every prologue / epilogue / `Jsr` / `Jsri` if [rbp+0] (or,
// at the 1-up level, the *caller's* saved-rbp slot value) is
// below 0x10000000 (= "definitely not a stack address"). The
// trap writes the function's bc PC to stderr via `SYS_write`
// then `SYS_exit(99)` -- needed because orbstack/Rosetta strips
// the program rip from SIGSEGV/SIGILL core dumps so a memory-
// fault trap can't be located. Empirically, even with the 1-up
// walk in place at all four sites, *none* of them fire on the
// trigger query.
//
// What that "no fire" rules out:
//   * The corrupting Si is not followed by any further `Jsr`,
//     `Jsri`, or `Lev` op -- so the function never gets to a
//     point where the canary would observe its own (or its
//     caller's) saved-rbp slot post-corruption.
// What that leaves:
//   * The corruption happens during the very `call NULL` that
//     produces the rip=0 crash -- e.g. a stack push at a
//     misaligned rsp lands on F's saved-rbp slot.
//   * Or it happens in Rosetta's signal-delivery path on
//     orbstack-emulated x64 (the kernel switches to an alt
//     stack at SIGSEGV time, which on emulated x64 might
//     interact badly with our stack layout).
//   * Or the corruption is to a *different* slot than the one
//     in F's frame, and the F's-saved-rbp value we see in the
//     core is itself a side-effect of the rip=0 fault rather
//     than the original bug.
//
// Next concrete step: instrument every Si/Sc/Sw with the same
// syscall trap, gated on the destination address falling within
// `[rbp_caller_n + 0 .. rbp_caller_n + 8]` for any active
// frame. That catches the bad write at the moment it happens.
// The infrastructure is all in place -- only the per-store gate
// needs writing. Alternatively, run the same trigger query on a
// *native* Linux x64 box (not orbstack-emulated) -- if the bug
// shows the same saved-rbp clobber there, it's a c5 codegen
// bug; if not, it's a Rosetta-on-orbstack interaction we'd
// document and skip on that environment.
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
//   BADC_SAVED_RBP_CHECK=1        instrument every prologue,
//                                 epilogue, and `Op::Jsr` site
//                                 with a runtime check that the
//                                 saved-rbp slot at [rbp+0]
//                                 looks like a stack address
//                                 (i.e., > 0x10000000). On a
//                                 trip, write the failing
//                                 function's bc PC to stderr
//                                 (8 raw bytes via SYS_write)
//                                 and SYS_exit(99). The bc PC
//                                 maps directly to a `[bc=N]`
//                                 line in `--dump-asm`.
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
//   1. Add a runtime saved-rbp canary: at every prologue stamp a
//      magic word at [rbp - K] for some out-of-frame K; at every
//      epilogue check it. Or simpler: wrap every Si/Sc/Sw store
//      in a runtime guard that traps if the destination overlaps
//      [rbp+0..rbp+16] of any active frame. Either reproduces
//      the corruption AT the corrupting site -- the function H
//      that wrote past its local frame.
//   2. Once H is named, look for an off-by-one in its frame-size
//      computation: `Op::Ent N` reserves N 8-byte slots, but the
//      regalloc analyzer's pool-save lives *below* those, so a
//      Si to a Lea N where N happens to land at +0 from rbp
//      would clobber the saved rbp. The optimizer's `local_load`
//      pass shouldn't change frame sizes on its own, but it does
//      shift PCs, and the codegen looks up per-function metadata
//      by PC -- so a stale PC index could route a Si to the
//      wrong frame slot.
//   3. Cross-check by extracting a c5-only repro via `creduce`
//      (multi-hour run). The predicate skeleton is in
//      `/tmp/reduce/check.sh`. Use `tools/core-walker.py` to
//      verify each reduction step keeps the saved-rbp clobber.
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
