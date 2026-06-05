//! End-to-end JIT tests. The lowering and relocation paths are the
//! same as the AOT ELF backend (see [`super::native_elf`] /
//! [`super::native_elf_x64`]); the only thing that's different is
//! how the produced code is loaded -- mmap + mprotect + a transmuted
//! function pointer, instead of an ELF on disk + exec.
//!
//! Gated to the OS / arch combinations where `jit_run` is
//! implemented: Linux (aarch64 + x86_64) and macOS arm64. The
//! `host_target()` helper inside `jit.rs` picks the right backend
//! at runtime, so the test body is platform-agnostic.
//!
//! Output from the JIT'd program (printf, etc.) goes to the test
//! process's stdout. Tests assert only on the exit code, so the
//! interleaving with `cargo test`'s output is cosmetic.

#![cfg(any(
    all(
        target_os = "linux",
        any(target_arch = "aarch64", target_arch = "x86_64")
    ),
    all(target_os = "macos", target_arch = "aarch64"),
))]

use crate::{Compiler, NativeOptions, jit_run, jit_run_with_options};

/// Compile `src` and run it through the JIT with `args` as argv.
/// Panics on compile or JIT-load failure -- the call sites here
/// expect both phases to succeed.
fn jit_exit(src: &str, args: &[&str]) -> i32 {
    let program = Compiler::new(super::with_prelude(src))
        .compile()
        .expect("compile failed");
    let argv: Vec<String> = args.iter().map(|s| s.to_string()).collect();
    jit_run(&program, &argv).expect("jit_run failed")
}

/// JIT-run with the native optimizer on (the same pipeline that
/// `--optimize` / `-O` triggers from the CLI). Used to guard parity
/// between the default and optimized lowerings.
fn jit_exit_native_optimized(src: &str, args: &[&str]) -> i32 {
    let program = Compiler::new(super::with_prelude(src))
        .compile()
        .expect("compile failed");
    let argv: Vec<String> = args.iter().map(|s| s.to_string()).collect();
    let opts = NativeOptions::new().with_optimize();
    jit_run_with_options(&program, &argv, opts).expect("jit_run_with_options failed")
}

// ---- Smoke tests, same shapes as src/c5/tests/native_elf.rs but
//      driven through the JIT loader. ----

#[test]
fn return_42() {
    assert_eq!(jit_exit("int main() { return 42; }", &["jit-ret42"]), 42);
}

#[test]
fn return_zero() {
    assert_eq!(jit_exit("int main() { return 0; }", &["jit-ret0"]), 0);
}

#[test]
fn arithmetic_and_locals() {
    let src = r#"
        int main() {
            int x;
            x = 41;
            x = x + 1;
            return x;
        }
    "#;
    assert_eq!(jit_exit(src, &["jit-locals"]), 42);
}

#[test]
fn while_loop_terminates() {
    let src = r#"
        int main() {
            int i;
            int s;
            i = 0;
            s = 0;
            while (i < 10) {
                s = s + i;
                i = i + 1;
            }
            return s;
        }
    "#;
    assert_eq!(jit_exit(src, &["jit-while"]), 45);
}

/// Cross-block reassigned loop counter: `i` is stored at the for-
/// init block and re-stored in the post (step) block; its load in
/// the head block sees two reaching defs and would otherwise stay
/// in the frame slot. With phi promotion the slot promotes
/// through an `Inst::Phi` at the head block; the per-arch emit
/// places the predecessor-exit moves before each branch so the
/// counter survives in a register.
///
/// Locks three things at once:
/// 1. With the gate off, the SSA IR for `main` contains no
///    `Inst::Phi` for the counter slot (the slot stays in memory).
/// 2. With the gate on, the same source produces at least one
///    `Inst::Phi` in `main`'s IR -- proving the rename actually
///    inserted the merge rather than falling back to the
///    in-memory slot.
/// 3. The compiled-and-run program returns the expected sum
///    (0 + 1 + ... + 9 = 45) under both modes -- proving the
///    per-arch lowering of `Inst::Phi` plus the predecessor-exit
///    moves still evaluates the loop correctly.
#[test]
#[cfg(feature = "std")]
fn while_loop_promotes_counter_through_phi_under_phi_promote() {
    use crate::Target;
    use crate::c5::codegen::ssa_shadow::produce_ssa_funcs;
    let src = r#"
        int main() {
            int i;
            int s;
            i = 0;
            s = 0;
            while (i < 10) {
                s = s + i;
                i = i + 1;
            }
            return s;
        }
    "#;
    let count_phis_in_main = || -> usize {
        let program = Compiler::new(super::with_prelude(src))
            .compile()
            .expect("compile failed");
        let mut funcs = produce_ssa_funcs(&program, Target::host()).expect("produce_ssa_funcs");
        for f in &mut funcs {
            crate::c5::codegen::ssa_mem2reg::run(f);
        }
        let main = funcs
            .iter()
            .find(|f| f.name == "main")
            .expect("main not found");
        main.insts
            .iter()
            .filter(|i| matches!(i, crate::c5::ir::Inst::Phi { .. }))
            .count()
    };
    // Scope the promotion flag to the current test thread so a
    // concurrent test on a different thread is not affected.
    let phis_off =
        crate::c5::codegen::ssa_mem2reg::with_phi_promote_override(false, count_phis_in_main);
    let (phis_on, result) =
        crate::c5::codegen::ssa_mem2reg::with_phi_promote_override(true, || {
            (
                count_phis_in_main(),
                jit_exit_native_optimized(src, &["jit-phi-promote"]),
            )
        });
    assert_eq!(
        phis_off, 0,
        "no Inst::Phi expected in main's IR with phi promotion forced off"
    );
    // The loop has two cross-block reassigned scalars (`i` and
    // `s`); the IDF places exactly one phi per slot at the loop
    // header, so the post-rename count is two.
    assert_eq!(
        phis_on, 2,
        "phi promotion expected exactly 2 Inst::Phi in main \
         (one each for `i` and `s` at the loop header); got {phis_on}",
    );
    assert_eq!(result, 45);
}

#[test]
fn function_call_returns_value() {
    let src = r#"
        int square(int n) { return n * n; }
        int main() { return square(6) + square(2); }
    "#;
    assert_eq!(jit_exit(src, &["jit-fncall"]), 40);
}

#[test]
fn recursion_factorial() {
    let src = r#"
        int fact(int n) {
            if (n < 2) return 1;
            return n * fact(n - 1);
        }
        int main() { return fact(5); }
    "#;
    assert_eq!(jit_exit(src, &["jit-fact"]), 120);
}

/// Regression for the dead-phi predecessor-exit move collision under
/// phi promotion. This is the reduced shape of sqlite's
/// `local_getline`: a loop with several loop-carried scalars (`zLine`
/// pointer, `nLine`, `n`) and multiple exit edges, so the
/// function-exit block is a join carrying a phi for every scalar.
/// Only `zLine` is returned; the phis for `nLine` and `n` at the join
/// are dead. A naive allocator reuses one register across those dead
/// phis and the live `zLine` phi (the dead ranges are empty), so their
/// predecessor-exit moves clobber the return register -- the function
/// returns `nLine` (100) instead of `zLine`. The interference-checked
/// phi congruence coalesces each dead phi into its own operand class
/// (a dead phi interferes with nothing), turning its exit-moves into
/// dropped self-moves, so the return register is never clobbered.
/// Without the fix the returned pointer is the small integer 100 and
/// the guard below returns 2; with it the round-trip returns 0.
#[test]
#[cfg(feature = "std")]
fn dead_phi_exit_move_does_not_clobber_return_under_phi_promote() {
    let src = r#"
        char *getline_like(char *zLine, char *src) {
            int nLine = zLine == 0 ? 0 : 100;
            int n = 0;
            int slen = 0;
            while (src[slen]) slen++;
            while (1) {
                if (n + 100 > nLine) {
                    nLine = nLine * 2 + 100;
                    zLine = realloc(zLine, nLine);
                    if (zLine == 0) return 0;
                }
                int k = 0;
                while (src[n + k] && k < 99) { zLine[n + k] = src[n + k]; k++; }
                zLine[n + k] = 0;
                if (n + k >= slen) { n += k; break; }
                n += k;
            }
            return zLine;
        }
        int main() {
            char *r = getline_like(0, "abcdefghij");
            if (r == 0) return 1;
            if (((long)r) < 4096) return 2;
            if (r[0] != 'a') return 3;
            if (r[9] != 'j') return 4;
            return 0;
        }
    "#;
    let result = crate::c5::codegen::ssa_mem2reg::with_phi_promote_override(true, || {
        jit_exit_native_optimized(src, &["jit-dead-phi"])
    });
    assert_eq!(result, 0, "dead-phi exit-move clobbered the return value");
}

#[test]
fn phi_predecessor_parallel_copy_handles_reg_spill_conflict() {
    // The phi predecessor-exit copy must schedule register and
    // spill-slot operands as one parallel copy. A phi whose
    // destination is a spill slot and whose source is a register can
    // otherwise have that source register clobbered by a sibling phi's
    // reg-to-reg move emitted in a separate pass. The SHA-512-shaped
    // loop in ssa_call_result_spill.c, compiled with the integer bank
    // capped to three registers per class, forces eight loop-carried
    // u64 phis to span both registers and spill slots and reproduces
    // the conflict on both backends.
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push("ssa_call_result_spill.c");
    let src =
        std::fs::read_to_string(&path).unwrap_or_else(|e| panic!("read {}: {e}", path.display()));
    let result = crate::c5::codegen::ssa_alloc::with_pool_size_override(3, 2, || {
        jit_exit(&src, &["phi-parallel-copy"])
    });
    assert_eq!(
        result, 0,
        "phi parallel copy clobbered a spilled loop-carried value under register pressure"
    );
}

#[test]
fn modulo_with_spilled_divisor_under_pressure() {
    // The modulo lowering computes `rem = n - (n / d) * d`. The
    // quotient must occupy a register distinct from the divisor; when
    // the divisor spills and is reloaded into a scratch register, the
    // divide must not reuse that same register for the quotient, or the
    // multiply reads the quotient as the divisor and computes
    // `n - (n/d) * (n/d)`. With the integer bank capped to one register
    // per class the constant divisor spills, reproducing the conflict.
    let src = r#"
        int main() {
            int s = 0;
            int i;
            for (i = 0; i < 6; i++) {
                if (i % 2 == 1) s = s + i;
            }
            return s; // 1 + 3 + 5 = 9
        }
    "#;
    let result = crate::c5::codegen::ssa_alloc::with_pool_size_override(1, 1, || {
        jit_exit(src, &["mod-spill"])
    });
    assert_eq!(
        result, 9,
        "modulo lowering reused the divisor's reload register for the quotient under pressure"
    );
}

#[test]
fn division_with_spilled_dividend_under_pressure() {
    // On x86_64 the divmod lowering stages the dividend into the
    // destination register; when the allocator reuses the divisor's
    // register for the result and the dividend spills, that store
    // overwrites the divisor before IDIV reads it -- computing
    // `dividend / dividend`. With the integer bank capped to one
    // register per class the operands spill and the destination
    // reuses an operand register, reproducing the conflict.
    let src = r#"
        int main() {
            int s = 0;
            int i;
            for (i = 1; i <= 6; i++) {
                s = s + 100 / i;
            }
            return s; // 100+50+33+25+20+16 = 244
        }
    "#;
    let result = crate::c5::codegen::ssa_alloc::with_pool_size_override(1, 1, || {
        jit_exit(src, &["div-spill"])
    });
    assert_eq!(
        result, 244,
        "division lowering took the dividend register as the divisor under pressure"
    );
}

#[test]
fn paramref_pointer_arg_survives_shared_register_packing() {
    // A `ParamRef` materialises its parameter from the incoming host
    // argument register. When the allocator packs several
    // sequentially-live parameters into one register -- each consumed
    // by an intervening store before the next is produced -- the
    // destination register it picks for an earlier parameter can be a
    // later parameter's incoming argument register. The earlier
    // `ParamRef`'s write then clobbers the later parameter's argument
    // value before it is read; on System V the fourth integer argument
    // is rcx, which the allocator readily reuses for earlier params.
    // This mirrors sqlite3's codeApplyAffinity(Parse*, int base, int n,
    // char *zAff): base and n are stored, then zAff is dereferenced,
    // and the corrupted zAff (a small integer) faulted on deref. The
    // first parameter is kept live so the allocator packs parameters
    // 1, 2 and 3 into the second integer register, which on System V
    // is rcx -- the incoming register of the fourth argument. The
    // non-elidable parameters must be read from their prologue home
    // cells, which survive the clobber, not from the live argument
    // register. The -O pipeline produces the packing on its own.
    // The trailing `while` loop over `zAff` is load-bearing: it is the
    // register pressure that drives the allocator to pack the three
    // stored parameters into the second integer register (rcx) instead
    // of leaving them in distinct registers. Without it the allocator
    // colours them apart and the entry parallel-copy batch -- which is
    // always correct -- handles the placement, hiding the per-inst bug.
    let src = r#"
        static int g[8];
        static int apply(int *keep, int base, int n, int *zAff) {
            g[5] = keep[0];
            g[0] = base;
            g[1] = n;
            if (zAff == 0) return -1;
            g[2] = keep[1];
            while (n > 0 && zAff[0] <= 64) { n--; base++; zAff++; }
            return base * 100 + n + keep[2];
        }
        int main() {
            int keep[3];
            int z[4];
            keep[0] = 11; keep[1] = 22; keep[2] = 33;
            z[0] = 100; z[1] = 100; z[2] = 100; z[3] = 0;
            // zAff[0]=100 > 64 so the loop never runs; the result is
            // base*100 + n + keep[2] = 5*100 + 1 + 33 = 534. A clobbered
            // `zAff` dereferences a small integer in the loop guard and
            // faults or yields nonsense.
            return apply(keep, 5, 1, z);
        }
    "#;
    let result = jit_exit_native_optimized(src, &["paramref-pack"]);
    assert_eq!(
        result, 534,
        "a pointer parameter was clobbered by an earlier ParamRef sharing its argument register"
    );
}

#[test]
fn division_with_call_result_divisor_and_spilled_dst_under_pressure() {
    // The x86_64 divmod lowering must marshal a divisor that the
    // allocator placed in rax or rdx out of those registers before the
    // dividend setup overwrites them. The copy target was always
    // SCRATCH_R10; when the destination is itself a spill, rd resolves
    // to SCRATCH_R10 and the spilled dividend is staged there, so the
    // divisor copy and the dividend collide and the function bailed out
    // of the implemented subset (sqlite3_db_status64). The divisor must
    // go to a second reserved scratch (r13) in that case.
    //
    // Reproducing the exact place triple (dividend Spill, divisor in the
    // rax result register, dst Spill) needs: a non-inlinable callee so
    // the divisor stays a live call result in rax; a loop-carried
    // (phi'd) quotient so the allocator spills the destination; and the
    // capped bank so the dividend spills too. 1000 / 3 six times is 1.
    let src = r#"
        long dv(long x) { if (x > 1000000) return x; return x + 1; }
        long g[8];
        int main() {
            g[0] = 1000; g[1] = 0; g[2] = 2; g[3] = 0;
            long acc = g[0];
            int i;
            for (i = 0; i < 6; i++) {
                long t = acc + g[1];
                acc = t / dv(g[2]);
            }
            return (int)(acc + g[3]); // 1000/3/3/3/3/3/3 = 1
        }
    "#;
    let result = crate::c5::codegen::ssa_alloc::with_pool_size_override(1, 1, || {
        jit_exit_native_optimized(src, &["div-call-spill"])
    });
    assert_eq!(
        result, 1,
        "divmod lowering failed to marshal a call-result divisor away from a spilled dividend/dst"
    );
}

#[test]
fn multiply_by_immediate_with_spilled_result_under_pressure() {
    // `BinopI { op: Mul }` by a non-power-of-two constant. The x86_64
    // lowering must not depend on a free caller-saved scratch to
    // materialise the immediate: with the bank capped to one register
    // the product spills and no scratch is free, so the three-operand
    // `imul rd, rn, imm32` form is required. The earlier scratch path
    // bailed the whole function out of the implemented subset here.
    let src = r#"
        int main() {
            int s = 0;
            int i;
            for (i = 0; i < 6; i++) {
                s = s + i * 7;
            }
            return s; // 7 * (0+1+2+3+4+5) = 105
        }
    "#;
    let result = crate::c5::codegen::ssa_alloc::with_pool_size_override(1, 1, || {
        jit_exit(src, &["mul-imm-spill"])
    });
    assert_eq!(
        result, 105,
        "multiply by an immediate with a spilled result was not lowered under pressure"
    );
}

#[test]
fn fp_diamond_phi_under_pressure() {
    // A double-valued local assigned on both arms of an if/else: the
    // slot merges two FP definitions at the join, so mem2reg promotes
    // it through an FP-classed `Phi { kind: F64 }`. The predecessor-exit
    // move runs over the FP register / spill file. Capping the FP bank
    // to one register forces the merged value across registers and spill
    // slots, exercising the spilled-FP-phi edge.
    let src = r#"
        double pick(int c, double a, double b) {
            double x;
            if (c) { x = a * 2.0; }
            else   { x = b + 1.0; }
            return x * 3.0;
        }
        int main() {
            // c=1: (2.5*2)*3 = 15.0 ; c=0: (4.0+1)*3 = 15.0
            double t = pick(1, 2.5, 99.0) + pick(0, 99.0, 4.0);
            return (int)t; // 15 + 15 = 30
        }
    "#;
    let result = crate::c5::codegen::ssa_alloc::with_pool_size_override(8, 1, || {
        jit_exit(src, &["fp-diamond"])
    });
    assert_eq!(
        result, 30,
        "FP diamond phi miscomputed under FP register pressure"
    );
}

#[test]
fn fp_loop_carried_phi_under_pressure() {
    // A double accumulator carried across a loop back-edge: the slot's
    // reaching value at the head block merges the entry seed with the
    // body's update, so mem2reg promotes it through an FP-classed phi
    // whose operand on the back edge is the in-body sum. With the FP
    // bank capped to one register the accumulator and the per-iteration
    // operands compete for registers and spill, exercising the FP-phi
    // predecessor move on a back edge.
    let src = r#"
        int main() {
            double a[5];
            a[0] = 1.5; a[1] = 2.5; a[2] = 3.0; a[3] = 4.0; a[4] = 9.0;
            double sum = 0.0;
            int i;
            for (i = 0; i < 5; i++) {
                sum = sum + a[i];
            }
            return (int)sum; // 1.5+2.5+3+4+9 = 20
        }
    "#;
    let result = crate::c5::codegen::ssa_alloc::with_pool_size_override(8, 1, || {
        jit_exit(src, &["fp-loop-acc"])
    });
    assert_eq!(
        result, 20,
        "FP loop-carried accumulator phi miscomputed under FP register pressure"
    );
}

#[test]
fn printf_through_libc_got() {
    // printf's libc address is dlsym'd at JIT time and patched into
    // the fake GOT region; the codegen's adrp+ldr+blr (aarch64) or
    // call qword [rip+disp32] (x86_64) reads through it.
    let src = r#"int main() { printf("%d\n", 42); return 0; }"#;
    assert_eq!(jit_exit(src, &["jit-printf"]), 0);
}

#[test]
fn malloc_memset_memcmp_roundtrip() {
    let src = r#"
        int main() {
            int *a;
            int *b;
            a = malloc(16);
            b = malloc(16);
            memset(a, 7, 16);
            memset(b, 7, 16);
            if (memcmp(a, b, 16) == 0) {
                free(a);
                free(b);
                return 1;
            }
            return 0;
        }
    "#;
    assert_eq!(jit_exit(src, &["jit-malloc"]), 1);
}

// ---- Fixture parity. Same fixture set as `super::native_elf`'s
//      NATIVE_ELF_FIXTURES; if either backend drifts, the failure
//      pinpoints which loader path broke. ----

fn jit_fixture(name: &str) -> i32 {
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push(name);
    let src =
        std::fs::read_to_string(&path).unwrap_or_else(|e| panic!("read {}: {e}", path.display()));
    jit_exit(&src, &[name])
}

const JIT_FIXTURES: &[(&str, i32)] = &[
    ("mem2reg_cross_block.c", 42),
    ("mem2reg_addr_taken_neighbor.c", 42),
    ("mem2reg_i64_local.c", 84),
    ("mem2reg_narrow_store_trunc.c", 0),
    ("mem2reg_unsigned_narrow.c", 0),
    ("mem2reg_value_across_call.c", 33),
    ("mem2reg_param_promoted.c", 0),
    ("natural_width_local.c", 0),
    ("arithmetic.c", 60),
    ("goto.c", 5),
    ("switch_statement.c", 25),
    ("switch_default_routing.c", 100),
    ("control_flow.c", 1),
    ("do_while.c", 5),
    ("break_continue.c", 4),
    ("for_loop.c", 10),
    ("recursion_factorial.c", 120),
    ("return_value_in_callee_saved.c", 7),
    ("divmod_preserves_rdx.c", 0),
    ("commutative_imm_lhs_swap.c", 0),
    ("comparison_imm_lhs_swap.c", 0),
    ("binop_imm_chain_fold.c", 0),
    ("binop_spill_lhs_rhs_in_dst.c", 59),
    // Entry ParamRef placement must be a parallel copy when the
    // allocator's chosen home registers cycle with the incoming
    // argument registers (a parameter swap). The independent per-inst
    // `mov dst, arg_reg` order clobbered a source before it was read.
    ("param_reg_swap.c", 77),
    ("mul_pow2_to_shift.c", 0),
    ("pointers.c", 200),
    ("pointer_arithmetic_scaling.c", 104), // sizeof(int) = 4
    ("expression_precedence.c", 1),
    ("variable_shadowing.c", 10),
    ("pointer_arithmetic.c", 3),
    ("predefined_constants.c", 0),
    ("c99_qualifiers.c", 0),
    ("integer_suffixes.c", 0),
    ("predefined_macros.c", 0),
    ("macro_operators.c", 0),
    ("typedef_basic.c", 0),
    ("local_init_and_block_scope.c", 0),
    ("arrays_basic.c", 0),
    ("function_pointer_typedefs.c", 0),
    ("unions_basic.c", 0),
    ("array_initializers.c", 0),
    ("local_array_partial_init_zero.c", 0),
    ("ssa_call_result_spill.c", 0),
    ("struct_field_assign_from_call.c", 0),
    ("struct_byval_param_followed_by_ptr.c", 0),
    ("tail_call_no_address_escape.c", 0),
    ("fib.c", 0),
    ("queens.c", 0),
    ("inline_keyword_uncaps.c", 0),
    ("ssa_bail_fixup_rollback.c", 0),
    ("ssa_fp_routing.c", 0),
    ("ssa_callee_saved_x19.c", 0),
    ("ssa_va_arg_loop.c", 0),
    ("ssa_variadic_fp_arg.c", 0),
    ("ssa_fp_compare_nan.c", 0),
    ("ssa_c5_internal_fp_arg.c", 0),
    ("struct_initializers.c", 0),
    ("enum_tag_types.c", 0),
    ("bitfields.c", 0),
    ("struct_layout.c", 0),
    ("const_expr_conditional.c", 27),
    ("comma_operator_in_loops.c", 3),
    ("size_t_via_stdio.c", 3),
    ("leading_dot_float_literal.c", 7),
    ("libc_fp_return_value.c", 11),
    ("pragma_entrypoint.c", 23),
    ("struct_field_enum_type.c", 13),
    ("compound_assign_fp_int_rhs.c", 17),
    ("optimizer_fp_arg_mask_remap.c", 19),
    ("many_args_host_stack_overflow.c", 0),
    ("variadic_optimizer_survives.c", 0),
    ("struct_2d_array_field.c", 27),
    ("anonymous_aggregates.c", 0),
    ("static_locals.c", 0),
    ("large_stack_frame.c", 42),
    ("octal_literal.c", 42),
    ("short_types.c", 42),
    ("long_long_distinct.c", 0),
    ("signed_cast_extends.c", 0),
    ("fn_ptr_struct_return.c", 0),
    ("static_init_cast_funcptr.c", 0),
    ("static_init_struct_fp_call.c", 0),
    ("libc_data_globals.c", 0),
    ("stdint_widths.c", 0),
    ("fd_set_macros.c", 0),
    ("fn_ptr_explicit_deref.c", 42),
    ("fn_ptr_decay_inside_block.c", 0),
    ("switch_nested_case_in_compound.c", 0),
    ("ternary_middle_comma.c", 0),
    ("local_init_int_to_float.c", 0),
    ("sys_addr_in_static_init.c", 42),
    ("sys_addr_zero_arg.c", 42),
    ("libc_struct_buf_size.c", 42),
    ("libc_basic.c", 0),
    ("memset_mcmp.c", 42),
    ("memcpy_basic.c", 'A' as i32),
    ("struct_basic.c", 25),
    ("struct_linked_list.c", 10),
    ("global_initializer_int.c", 141),
    ("global_initializer_pointer.c", 0),
    ("static_linked_list.c", 0),
    ("struct_sizeof.c", 0),
    ("memory_ops.c", 0),
    ("linked_list.c", 10),
    ("double_pointers.c", 0),
    ("printf.c", 0),
    ("shebang.c", 7),
    ("adjacent_strings.c", 'f' as i32),
    ("sizeof_with_write.c", 16), // 4 + 4 + 8
    ("function_pointers.c", 150),
    ("nested_function_calls.c", 100),
    ("quicksort.c", 0),
    ("binary_search_tree.c", 0),
    ("bst_free.c", 0),
    ("cast_to_struct_pointer.c", 42),
    ("argc.c", 1),
    ("argv_first_char.c", 0),
    ("sizeof_basic.c", 0),
    ("sizeof_expr.c", 0),
    ("write_stdout.c", 0),
    ("ir_translation_simple.c", 42),
    ("ir_translation_if.c", 2),
    ("ir_translation_while.c", 0),
    ("type_warning_int_to_ptr.c", 0),
    ("type_warning_silenced_by_cast.c", 0),
    ("type_warning_arity.c", 0),
    // dlopen+dlsym+blr finds libc atoi and the indirect call passes
    // "123" in the System V argument register.
    ("dlopen_atoi.c", 123),
    ("dlopen_strlen.c", 13),
    // Multi-arg dlsym call path: pthread_create + pthread_join.
    // POSIX-only fixture; the JIT is gated to POSIX hosts already.
    ("pthread_create.c", 11),
    // sprintf 2-fixed + 4-variadic; the JIT shares the lowering
    // with the AOT backends so this guards both at once.
    ("variadic_sprintf.c", 0),
    // c5-side vprintf walking the c5 va_list -- exercises a
    // user-defined `my_printf` clone forwarding to <c5io.h>.
    // No libc vprintf bridge involved; the format pipeline runs
    // entirely in c5.
    ("c5_vprintf.c", 0),
    // Float / double scalars parse, sizeof reports 8, pointer
    // arithmetic and indexed loads/stores work.
    ("float_pointer_basics.c", 0),
    // Full FP arithmetic: add/sub/mul/div, comparisons, casts,
    // unary negation. Routes through Fadd/.../Fcvtfi opcodes the
    // VM and both codegens implement.
    ("float_arithmetic.c", 0),
    // Struct-value locals + `.` field access.
    ("struct_value_basics.c", 0),
    // Whole-struct copy via Inst::Mcpy. The walker emits it
    // for `a = b` where both are struct values; the VM and both
    // codegens unroll the byte-level copy at compile time.
    ("struct_value_copy.c", 0),
    // Struct passed by value: callee's prologue copies the
    // struct out of the caller's slot into a local so callee
    // mutations don't leak.
    ("struct_by_value_param.c", 0),
    // Struct returned by value via the hidden out-pointer ABI.
    ("struct_by_value_return.c", 0),
    // Unsigned-integer comparisons: pin that comparing a u32 / u64 /
    // u8 against a value with the high bit set uses unsigned
    // semantics (the dialect emits BinOp::Ult/Ugt/Ule/Uge for
    // those operands and reaches them through every backend).
    ("unsigned_compare.c", 0),
    // `static const unsigned char arr[]` with 1-byte stride. The
    // size_of_type / pointee scaling helpers strip the unsigned bit
    // before classifying, so indexing scales by 1 not 8.
    ("unsigned_char_array.c", 0),
    // Compound assignment (`+=`, `-=`) on unsigned int / long /
    // char: must NOT scale the RHS by element size (the
    // `lhs_ty > Ty::Ptr` heuristic tripped on the unsigned bit).
    ("unsigned_compound_assign.c", 0),
    // Exhaustive coverage of integer ops across char/int/long
    // widths and signed/unsigned. Catches regressions in the
    // type-tag plumbing at one fixture.
    ("integer_ops_exhaustive.c", 0),
    // VaArg rd/ap register-aliasing fix: the dst register and the
    // `&ap` source register can land on the same physical reg;
    // without the fix the second and later va_arg reads return the
    // same garbage. `show` prints `first n=3 v[0]=11 v[1]=22
    // v[2]=33`, which the fixture's main does not check directly --
    // pin via the exit status (0).
    ("va_arg_int_seq.c", 0),
    // VaStart + VaCopy emit shapes where the allocator places
    // `&last` (VaStart) or `&src` / `&dst` (VaCopy) on r10. The
    // prior emit used SCRATCH_R10 as the staging register and
    // produced a load through a stale operand when r10 aliased
    // an operand; the fix routes through r13 (outside both
    // `caller_gprs` and `callee_gprs`).
    ("ssa_va_start_va_copy_aliasing.c", 0),
    // `thread_local_*.c` aren't here -- the JIT path's host is
    // macOS arm64 in this repo, where TLS lowering isn't
    // implemented yet (Mach-O __thread_data + dyld
    // __tlv_bootstrap is future work). The native_elf and
    // native_elf_x64 runners validate the Linux paths once the
    // built ELF lands on the orb VMs.
];

#[test]
fn fixture_parity() {
    let mut failures: Vec<String> = Vec::new();
    for (name, expected) in JIT_FIXTURES {
        let got = jit_fixture(name);
        if got != *expected {
            failures.push(format!("{name}: expected {expected}, got {got}"));
        }
    }
    assert!(
        failures.is_empty(),
        "{} of {} JIT fixtures regressed:\n  {}",
        failures.len(),
        JIT_FIXTURES.len(),
        failures.join("\n  ")
    );
}

/// Parity for the native optimizer (the pipeline that `--optimize`
/// turns on): every fixture in the same table must produce the same
/// exit code with the optimizer enabled as without. Catches lowering
/// regressions in the register-eligible Psh path, the prologue /
/// epilogue save shape, the cmp+branch fusion peephole, or any
/// per-arch helper (binop_with_pop, cmp_with_pop, etc).
#[test]
fn fixture_parity_native_optimized() {
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    let mut failures: Vec<String> = Vec::new();
    for (name, expected) in JIT_FIXTURES {
        let mut p = path.clone();
        p.push(name);
        let src =
            std::fs::read_to_string(&p).unwrap_or_else(|e| panic!("read {}: {e}", p.display()));
        let got = jit_exit_native_optimized(&src, &[name]);
        if got != *expected {
            failures.push(format!(
                "{name} (native optimizer on): expected {expected}, got {got}"
            ));
        }
    }
    assert!(
        failures.is_empty(),
        "{} of {} JIT fixtures regressed under the native optimizer:\n  {}",
        failures.len(),
        JIT_FIXTURES.len(),
        failures.join("\n  ")
    );
}

// ---- Standalone tests for fixtures that need argv setup the
//      parity harness can't provide. setenv / file_io are skipped:
//      they touch process-global state (env vars / cwd) and would
//      be flaky against parallel `cargo test` threads -- the
//      AOT-ELF suite covers them via per-test subprocesses. ----

#[test]
fn original_c4_compiles_and_runs_hello_jit() {
    // c4.c reads its first user argv entry as the source file to
    // compile-and-run; we hand it hello.c via JIT argv and expect
    // the resulting c4-VM run to print "Hello 123" and exit 0.
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push("c4.c");
    let src = std::fs::read_to_string(&path).expect("read c4.c");
    let hello = concat!(env!("CARGO_MANIFEST_DIR"), "/hello.c");
    let exit = jit_exit(&src, &["c4", hello]);
    assert_eq!(exit, 0, "c4 self-host JIT exited {exit}");
}

#[test]
fn original_c4_compiles_and_runs_hello_jit_native_optimized() {
    // Same as above but with the native optimizer on. c4.c is the
    // most complex program in the fixture set; if anything in the
    // register-pool lowering or cmp+branch fusion breaks under
    // heavy code-emit load, this is the test that catches it first.
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push("c4.c");
    let src = std::fs::read_to_string(&path).expect("read c4.c");
    let hello = concat!(env!("CARGO_MANIFEST_DIR"), "/hello.c");
    let exit = jit_exit_native_optimized(&src, &["c4", hello]);
    assert_eq!(
        exit, 0,
        "c4 self-host JIT (native optimizer on) exited {exit}"
    );
}
