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
fn spill_slot_beyond_imm12_reach() {
    // aarch64 LDR/STR (unsigned offset) reaches a byte displacement of
    // `4095 * size`; for 8-byte spill slots that caps SP-relative
    // access at 0x7FF8. A function that spills more than ~4096 values
    // pushes its lowest-numbered (deepest) spill slots past that reach.
    // The encoders only `debug_assert` the bound, so in release the
    // scaled imm12 overflowed into the opcode's load/store bit and a
    // spill store silently became a load (and vice versa), leaving the
    // slot uninitialised. The SP-relative spill helpers now materialise
    // the base into a scratch register for out-of-reach offsets.
    //
    // With the integer bank capped to one register, every local spills,
    // producing well over 4096 slots. The function stores each local to
    // its slot, then reloads all of them in a sum -- exercising the
    // store-to-slot and reload-from-slot paths at out-of-reach offsets.
    const N: u64 = 5000;
    let mut src = String::from("long f() {\n");
    for i in 0..N {
        src.push_str(&format!("  long a{i} = {};\n", i + 1));
    }
    src.push_str("  long s = 0;\n");
    for i in 0..N {
        src.push_str(&format!("  s = s + a{i};\n"));
    }
    // Sum of 1..=N. Return a small sentinel so the value survives the
    // exit-code byte truncation while still depending on every slot.
    let expected: u64 = N * (N + 1) / 2;
    src.push_str(&format!("  return s == {expected} ? 7 : 0;\n"));
    src.push_str("}\n");
    src.push_str("int main() { return (int)f(); }\n");
    let result = crate::c5::codegen::ssa_alloc::with_pool_size_override(1, 1, || {
        jit_exit_native_optimized(&src, &["spill-imm12-reach"])
    });
    assert_eq!(
        result, 7,
        "an out-of-reach spill slot was accessed with a corrupt LDR/STR encoding"
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
fn fp_param_incoming_reg_clobber_under_pressure() {
    // Each Inst::ParamRef reads its incoming FP argument register, which
    // stays live from function entry until that ParamRef materializes.
    // Under FP register pressure the hint that homes each parameter in
    // its own incoming register is rejected (the register lies beyond the
    // truncated bank), so the colorer could park an earlier ParamRef on a
    // later ParamRef's incoming register; the earlier parameter's
    // materialization then overwrote the later parameter's argument before
    // it was read. sum4 mixes float and double parameters: the double in
    // d3 is routed through d0, the float parameter a's incoming register,
    // clobbering a before its spill. The allocator now forbids placing a
    // ParamRef on a later same-bank ParamRef's incoming register.
    let src = r#"
        static double sum4(float a, double b, float c, double d) {
            return a + b + c + d;
        }
        int main(void) {
            return sum4(1.0f, 2.0, 3.0f, 4.0) == 10.0 ? 0 : 5;
        }
    "#;
    let result = crate::c5::codegen::ssa_alloc::with_pool_size_override(2, 2, || {
        jit_exit(src, &["fp-param-incoming-clobber"])
    });
    assert_eq!(
        result, 0,
        "a float parameter in an earlier FP argument register was clobbered \
         by a later double routed through it under register pressure"
    );
}

#[test]
fn indirect_call_spilled_target_under_pressure() {
    // A six-argument indirect call. Under register pressure the target
    // pointer is spilled to a stack slot above the marshal's scratch
    // window; the marshaller reloads spilled argument sources relative to
    // the adjusted stack pointer, and that shift must include the target
    // slot. Without it a reloaded pointer argument reads the wrong stack
    // offset and the callee dereferences a corrupt pointer (x86_64 only;
    // surfaces under the low-GPR pressure CI exercises).
    let src = r#"
        typedef long (*cmp)(void *, int *, long *, long, long *, long);
        struct task { cmp fn; };
        static long do_cmp(void *t, int *cached, long *k1, long n1, long *k2, long n2) {
            (void)t; *cached = 1;
            return *k1 * 1000 + *k2 * 10 + n1 + n2;
        }
        static long run(struct task *pt, long *p1, long n1, long *p2, long n2) {
            int cached = 0;
            long r = pt->fn(pt, &cached, p1 + 2, n1, p2 + 2, n2);
            return r + cached;
        }
        int main(void) {
            struct task t; t.fn = do_cmp;
            long a[4]; long b[4];
            a[2] = 3; b[2] = 7;
            return run(&t, a, 5, b, 9) == 3085 ? 0 : 1;
        }
    "#;
    let result = crate::c5::codegen::ssa_alloc::with_pool_size_override(3, 3, || {
        jit_exit_native_optimized(src, &["indirect-spill-target"])
    });
    assert_eq!(
        result, 0,
        "indirect-call target-slot spill desynced a spilled argument reload under pressure"
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
fn variadic_va_list_survives_spilled_operands_under_pressure() {
    // VaStart / VaArg / VaCopy each take their `va_list` pointer
    // operands -- and VaArg its result -- from the allocator. With
    // the integer bank capped to one register per class the cursor
    // pointer (`&ap`), the source / destination pointers (VaCopy),
    // the `&last` pointer (VaStart) and the VaArg result all land in
    // spill slots. The x86_64 emit previously required each to be a
    // register and bailed the whole function to an ICE otherwise.
    // The handlers must instead materialize a spilled operand into a
    // reserved scratch (r10 / r13, outside both pools) and store a
    // spilled result back to its slot. `sum` walks three ints twice
    // (once through the original list, once through a va_copy) and
    // returns 2 * (11 + 22 + 33) = 132.
    let src = r#"
        #include <stdarg.h>
        static int sum(int n, ...) {
            va_list ap;
            va_list bp;
            int total = 0;
            int i;
            va_start(ap, n);
            va_copy(bp, ap);
            for (i = 0; i < n; i++) {
                total = total + va_arg(ap, int);
            }
            for (i = 0; i < n; i++) {
                total = total + va_arg(bp, int);
            }
            va_end(ap);
            va_end(bp);
            return total;
        }
        int main() {
            return sum(3, 11, 22, 33); // 2 * 66 = 132
        }
    "#;
    let result = crate::c5::codegen::ssa_alloc::with_pool_size_override(1, 1, || {
        jit_exit(src, &["va-spill"])
    });
    assert_eq!(
        result, 132,
        "variadic emit bailed or miscompiled when va_list operands / result spilled under pressure"
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
fn and_with_low_32_bit_mask_lowers_without_scratch() {
    // `x & 0xffffffff` is a 32-bit zero-extension. The immediate does
    // not fit a signed i32 (the `and r64, imm32` form sign-extends, so
    // 0xffffffff would mask nothing), and the rcx-scratch fallback for a
    // 64-bit immediate bailed the whole function out of the implemented
    // subset when no caller-saved register was free under pressure. The
    // lowering must emit a 32-bit `mov rd, rn`, which clears the upper
    // half with no scratch. Capping the integer bank to one register
    // spills the masked result and removes any free scratch, reproducing
    // the bail (this is the shape monocypher's little-endian load
    // helpers hit at -O on x86_64).
    let src = r#"
        unsigned long g[8];
        int main() {
            g[0] = 0x1122334455667788UL;
            g[1] = 0xaabbccddeeff0011UL;
            unsigned long s = 0;
            int i;
            for (i = 0; i < 2; i++) {
                s = s + (g[i] & 0xffffffffUL);
            }
            // 0x55667788 + 0xeeff0011 = 0x144657799
            return (int)(s & 0xffffffffUL); // 0x44657799
        }
    "#;
    let result = crate::c5::codegen::ssa_alloc::with_pool_size_override(1, 1, || {
        jit_exit(src, &["and-lo32-mask"])
    });
    assert_eq!(
        result, 0x4465_7799,
        "x & 0xffffffff was not lowered as a 32-bit zero-extension under pressure"
    );
}

#[test]
fn long_lived_base_pointer_survives_shift_count_and_store_scratch() {
    // A base pointer kept live across many indexed loads while the body
    // also runs 64-bit rotations and stores under register pressure. On
    // x86_64 a shift reads its count from cl (rcx). When the destination
    // is a spill the shift's spilled count was materialised straight into
    // rcx through the rhs scratch -- before the shift arm's push / pop
    // could preserve a long-lived SSA value the allocator had parked in
    // rcx -- so the base pointer was overwritten by a shift count and the
    // next indexed load faulted. The shift now stages a spilled count
    // through r13 (reserved outside both allocator banks) instead of rcx,
    // so the rcx-preserving push / pop in the shift arm covers the move.
    // This is the BLAKE2b compress shape (a 16-word work vector plus the
    // `input` pointer, all live across an unrolled mixing round) that
    // monocypher hits at -O once the rotate helper is inlined.
    let src = r#"
        static unsigned long rotr64(unsigned long x, unsigned long n) {
            return (x >> n) ^ (x << (64 - n));
        }
        unsigned long out[8];
        unsigned long in[16];
        static void mix(unsigned long *h, unsigned long *m) {
            unsigned long v0=h[0],v1=h[1],v2=h[2],v3=h[3];
            unsigned long v4=h[4],v5=h[5],v6=h[6],v7=h[7];
            unsigned long a=v0,b=v4,c=v0^v4,d=v0+v4;
            a += b + m[0];  d = rotr64(d ^ a, 32);
            c += d;         b = rotr64(b ^ c, 24);
            a += b + m[1];  d = rotr64(d ^ a, 16);
            c += d;         b = rotr64(b ^ c, 63);
            a += b + m[2];  d = rotr64(d ^ a, 32);
            c += d;         b = rotr64(b ^ c, 24);
            a += b + m[3];  d = rotr64(d ^ a, 16);
            c += d;         b = rotr64(b ^ c, 63);
            h[0] = a ^ v1; h[1] = b ^ v2; h[2] = c ^ v3; h[3] = d ^ v5;
            h[4] = a ^ m[4]; h[5] = b ^ m[5]; h[6] = c ^ m[6]; h[7] = d ^ m[7];
        }
        int main() {
            int i;
            for (i = 0; i < 8; i++) out[i] = 0x0101010101010101UL * (i + 1);
            for (i = 0; i < 16; i++) in[i] = 0xfedcba9876543210UL * (i + 3);
            mix(out, in);
            unsigned long acc = 0;
            for (i = 0; i < 8; i++) acc ^= out[i] + i;
            return (int)(acc & 0xffffffffUL);
        }
    "#;
    // The -O path inlines `rotr64`, which raises register pressure to the
    // level that forces the clobber; the interpreter and the unoptimised
    // path both compute the reference value.
    let expected = jit_exit(src, &["mix-ref"]);
    let optimized = jit_exit_native_optimized(src, &["mix-opt"]);
    assert_eq!(
        optimized, expected,
        "a long-lived base pointer was clobbered by a shift-count or store scratch under pressure"
    );
}

#[test]
fn large_stack_frame_is_page_probed() {
    // A function whose frame exceeds one 4 KiB page. On Win64 the
    // prologue must touch every page it allocates, in descending order,
    // so the OS guard-page mechanism commits the next page before the
    // frame reaches it; a single `sub rsp, bytes` that jumps past the
    // guard page faults on the first access into an uncommitted page.
    // System V Linux grows the stack on demand. The large local arrays
    // force a multi-page frame; the loops touch the high and low ends so
    // an unprobed frame faults on the first write. (Heavily-spilled -O
    // functions reach this frame size on their own -- monocypher's
    // BLAKE2b compress allocates tens of kilobytes after the rotate
    // helper inlines.)
    let src = r#"
        int main() {
            volatile int a[3000];
            volatile int b[3000];
            int i;
            for (i = 0; i < 3000; i++) { a[i] = i; b[i] = 3000 - i; }
            long sum = 0;
            for (i = 0; i < 3000; i++) sum += a[i] + b[i];
            return (int)(sum % 100000); // 3000 * 3000 = 9000000 -> 0
        }
    "#;
    assert_eq!(
        jit_exit(src, &["large-frame"]),
        0,
        "a multi-page stack frame was not page-probed; the prologue skipped a guard page"
    );
    assert_eq!(
        jit_exit_native_optimized(src, &["large-frame-opt"]),
        0,
        "a multi-page stack frame was not page-probed under -O"
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
fn fp_store_f32_preserves_live_numerator() {
    // A single `float` numerator reused as the dividend of two
    // consecutive `float` stores: `1.0f` is computed once and divided
    // by two different denominators, each result stored to a `float`
    // lvalue. The aarch64 `float` store narrows the f64 result with
    // `fcvt Sd, Dn`; writing the S view zeroes the rest of the V
    // register per AAPCS64, so narrowing over a pooled d-register
    // would destroy the still-live numerator before the second store.
    // The narrow must land in a scratch register outside the allocator
    // pool (mirrors the stb_image_write JPEG quantization-table build,
    // where the second `1 / (table[..] * a * a)` came out zero).
    let src = r#"
        int main() {
            float a[2];
            float b[2];
            float t[2];
            t[0] = 4.0f; t[1] = 8.0f;
            int k;
            for (k = 0; k < 2; ++k) {
                // The `1` is an int divided by a float: the dividend is an
                // IntToFp cast (scvtf) materialised once and reused for both
                // stores. The first store's narrow must not clobber it.
                a[k] = 1 / (t[k] * 2.0f);
                b[k] = 1 / (t[k] * 4.0f);
            }
            // a[0]=1/8=0.125, a[1]=1/16=0.0625, b[0]=1/16=0.0625, b[1]=1/32=0.03125
            // *10000: 1250 + 625 + 625 + 312 = 2812
            return (int)(a[0]*10000.0f) + (int)(a[1]*10000.0f)
                 + (int)(b[0]*10000.0f) + (int)(b[1]*10000.0f);
        }
    "#;
    assert_eq!(
        jit_exit(src, &["fp-f32-store-numerator"]),
        2812,
        "float store narrowing clobbered a live FP numerator"
    );
    assert_eq!(
        jit_exit_native_optimized(src, &["fp-f32-store-numerator-opt"]),
        2812,
        "float store narrowing clobbered a live FP numerator (-O)"
    );
}

#[test]
fn fp_load_into_spill_preserves_live_operand_under_pressure() {
    // `a*b - c*d`: the first product is live in a pooled d-register
    // across the loads of the second multiply's operands. On aarch64 a
    // `float`/`double` load whose allocator destination is a spill slot
    // stages through a d-register before storing to the slot; staging
    // through d0 (inside the allocator's d0..d15 pool) overwrites the
    // still-live first product. The staging register must be a reserved
    // scratch (d16/d17) outside the pool. With the FP bank capped to one
    // register the second operand spills, reproducing the clobber (this
    // is the kissfft C_MUL butterfly `(a).r*(b).r - (a).i*(b).i`).
    let src = r#"
        float mul_sub(float a, float b, float c, float d) {
            return a * b - c * d;
        }
        int main() {
            // 10*3 - 2*4 = 30 - 8 = 22
            float r = mul_sub(10.0f, 3.0f, 2.0f, 4.0f);
            return (int)r;
        }
    "#;
    let result = crate::c5::codegen::ssa_alloc::with_pool_size_override(1, 1, || {
        jit_exit(src, &["fp-load-spill-operand"])
    });
    assert_eq!(
        result, 22,
        "an FP load into a spill slot staged through a pooled d-register and clobbered a live operand"
    );
    let result_opt = crate::c5::codegen::ssa_alloc::with_pool_size_override(1, 1, || {
        jit_exit_native_optimized(src, &["fp-load-spill-operand-opt"])
    });
    assert_eq!(
        result_opt, 22,
        "FP load-into-spill clobbered a live operand under pressure (-O)"
    );
}

#[test]
fn mcpy_src_scratch_preserves_live_pointer_under_pressure() {
    // A zero-initialised local aggregate (`swc s = {0}`) lowers to an
    // `Inst::Mcpy` from a zero-filled `ImmData` blob. On x86_64 the Mcpy
    // emit materialises its destination base into SCRATCH_R10 and, when
    // the destination spilled (so its base already occupies r10), needs a
    // second scratch for the source base. rcx is in the LinuxX64
    // `caller_gprs` pool, so under raised register pressure the allocator
    // parks SSA values there; here it holds the `context` pointer (the
    // second parameter) that is live across the copy and threaded into a
    // later call argument. Using rcx as the source scratch overwrote that
    // pointer, so the callee saw the `ImmData` blob address instead.
    // The source scratch must be SCRATCH_R13, outside both pools. This is
    // the stb_image_write `stbi_write_jpg_to_func` shape: the `context`
    // passed to `stbi__start_write_callbacks` came out as the quant-table
    // blob address, so every JPEG byte was written to the wrong buffer.
    let src = r#"
        struct ctx { long *buf; int len; int cap; };
        typedef struct { void *func; void *context; unsigned char buf[64]; int used; } swc;
        struct ctx *g_seen;
        void start_cb(swc *s, void *f, void *c) { s->func = f; s->context = c; }
        int core(swc *s, int w, int h, int comp, int q) {
            g_seen = (struct ctx *)s->context;
            return w + h + comp + q;
        }
        int run(void *f, struct ctx *c, int w, int h, int comp, int q) {
            swc s = {0};
            start_cb(&s, f, c);
            return core(&s, w, h, comp, q);
        }
        int main() {
            struct ctx ctx;
            ctx.buf = 0; ctx.len = 0; ctx.cap = 0;
            g_seen = 0;
            run((void *)0x1234, &ctx, 8, 8, 3, 90);
            // 42 when the callee saw the real context pointer; a clobbered
            // context yields the blob address and a mismatch.
            return (g_seen == &ctx) ? 42 : 7;
        }
    "#;
    let result = crate::c5::codegen::ssa_alloc::with_pool_size_override(2, 8, || {
        jit_exit(src, &["mcpy-src-scratch"])
    });
    assert_eq!(
        result, 42,
        "Mcpy source scratch clobbered a live pointer the allocator parked in rcx"
    );
    let result_opt = crate::c5::codegen::ssa_alloc::with_pool_size_override(2, 8, || {
        jit_exit_native_optimized(src, &["mcpy-src-scratch-opt"])
    });
    assert_eq!(
        result_opt, 42,
        "Mcpy source scratch clobbered a live pointer parked in rcx (-O)"
    );
}

#[test]
fn fp_load_f64_into_spill_preserves_live_operand_under_pressure() {
    // Same shape as the f32 case but with `double`, exercising the
    // F64 (no-widen) branch of the spill-staging load.
    let src = r#"
        double mul_sub(double a, double b, double c, double d) {
            return a * b - c * d;
        }
        int main() {
            double r = mul_sub(10.0, 3.0, 2.0, 4.0); // 22
            return (int)r;
        }
    "#;
    let result = crate::c5::codegen::ssa_alloc::with_pool_size_override(1, 1, || {
        jit_exit(src, &["fp-load-f64-spill-operand"])
    });
    assert_eq!(
        result, 22,
        "an F64 load into a spill slot staged through a pooled d-register and clobbered a live operand"
    );
}

#[test]
fn fp_inttofp_cast_into_spill_preserves_live_operand_under_pressure() {
    // `-PI * ((double)(i+1)/n + 0.5)`: the negated constant is live in
    // a pooled d-register while the `(double)(i+1)` and `(double)n`
    // IntToFp casts run. On aarch64 an `scvtf` whose allocator
    // destination is a spill slot stages through a d-register; staging
    // through d0 (inside the allocator's d0..d15 pool) overwrites the
    // negated constant before the final multiply. The staging register
    // must be a reserved scratch (d16) outside the pool. With the FP
    // bank capped to one register the second cast spills, reproducing
    // the clobber (this is the kissfft super-twiddle phase build
    // `-PI * ((double)(i+1)/nfft + .5)`).
    let src = r#"
        double g_phase[4];
        void build(int n) {
            int i;
            for (i = 0; i < n / 2; ++i) {
                g_phase[i] = -3.141592653589793 * ((double)(i + 1) / n + 0.5);
            }
        }
        int main() {
            build(8);
            // phase[2] = -PI * (3/8 + 0.5) = -PI * 0.875 = -2.74889...
            // *(-1000) truncated = 2748
            return (int)(g_phase[2] * -1000.0);
        }
    "#;
    let result = crate::c5::codegen::ssa_alloc::with_pool_size_override(1, 1, || {
        jit_exit(src, &["fp-inttofp-spill-operand"])
    });
    assert_eq!(
        result, 2748,
        "an IntToFp cast into a spill slot staged through a pooled d-register and clobbered a live operand"
    );
    let result_opt = crate::c5::codegen::ssa_alloc::with_pool_size_override(1, 1, || {
        jit_exit_native_optimized(src, &["fp-inttofp-spill-operand-opt"])
    });
    assert_eq!(
        result_opt, 2748,
        "IntToFp cast into spill clobbered a live operand under pressure (-O)"
    );
}

#[test]
fn float_struct_field_const_init() {
    // C99 6.7.9: a `float`-typed struct member initialized from a
    // floating constant stores the narrowed f32 pattern. Writing the
    // f64 pattern's low four bytes instead yields +0.0f for any
    // non-tiny value. Covers positional, designated, nested-struct,
    // and array-of-struct field writes (all route through
    // write_init_value).
    let src = r#"
        typedef struct { float r; float i; } cpx;
        typedef struct { cpx a; int n; } box;
        typedef struct { float v; } w;
        int main() {
            cpx p = {3.0f, 4.0f};
            cpx d = {.r = 1.0f, .i = 2.0f};
            box b = {{1.5f, 2.5f}, 7};
            w a[2] = {{6.0f}, {0.5f}};
            return (int)(p.r * 10 + p.i)        /* 34 */
                 + (int)(d.r * 10 + d.i)        /* 12 */
                 + (int)(b.a.r * 10 + b.a.i)    /* 17 */
                 + b.n                          /* 7  */
                 + (int)(a[0].v + a[1].v * 10); /* 11 */
            /* 34 + 12 + 17 + 7 + 11 = 81 */
        }
    "#;
    assert_eq!(jit_exit(src, &["fstruct-const"]), 81);
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
    ("inline_forward_ref_value.c", 0),
    ("inline_phi_caller_leaf_helper.c", 0),
    ("inline_phi_narrow_param_return.c", 0),
    ("natural_width_local.c", 0),
    ("arithmetic.c", 60),
    ("goto.c", 5),
    ("switch_statement.c", 25),
    ("switch_binary_search.c", 0),
    ("branch_relaxation.c", 21),
    ("float_register_resident.c", 45),
    ("variadic_struct_arg.c", 18),
    ("variadic_struct_arg_16b.c", 51),
    ("libc_div.c", 0),
    ("strength_reduce_pow2_divmod.c", 0),
    ("return_callee_saved_value.c", 0),
    ("spill_slot_reuse_disjoint_calls.c", 0),
    ("rotate_variable_count.c", 0),
    ("bitwise_not_mvn.c", 0),
    ("add_three_operand_lea.c", 0),
    ("add_sub_negative_imm.c", 0),
    ("assign_expr_value_narrowed.c", 0),
    ("struct_copy_comma_side_effect.c", 0),
    ("inline_two_reg_struct_param.c", 0),
    ("struct_param_stack_spill.c", 0),
    ("wide_string_literal_alignment.c", 0),
    ("va_arg_through_pointer.c", 0),
    ("pthread_key_once_width.c", 0),
    ("dev_t_width.c", 0),
    ("libc_int_arith.c", 0),
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
    ("int32_sign_extend_elision.c", 0),
    ("arg_register_cycle.c", 0),
    ("indirect_call_six_args_spilled_target.c", 0),
    ("predefined_macros.c", 0),
    ("macro_multiline_comment_body.c", 0),
    ("compound_literal_paren_init.c", 0),
    ("alignof_operator.c", 0),
    ("return_void_expression.c", 0),
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
    ("sysv_variadic_host_abi.c", 0),
    ("aapcs64_variadic_host_abi.c", 0),
    ("param_fp_before_int_pressure.c", 0),
    ("ssa_fp_compare_nan.c", 0),
    ("ssa_c5_internal_fp_arg.c", 0),
    ("struct_initializers.c", 0),
    ("enum_tag_types.c", 0),
    ("bitfields.c", 0),
    ("bound_import_arg_narrowing.c", 0),
    ("block_extern_shadows_local.c", 0),
    ("win64_xmm_scratch_callee_save.c", 0),
    ("variadic_fnptr_proto_erased.c", 0),
    ("union_bitfield_layout.c", 0),
    ("init_float_to_int.c", 0),
    ("global_init_midexpr_cast_narrow.c", 0),
    ("ternary_arith_conversion.c", 0),
    ("struct_layout.c", 0),
    ("const_expr_conditional.c", 27),
    ("comma_operator_in_loops.c", 3),
    ("size_t_via_stdio.c", 3),
    ("leading_dot_float_literal.c", 7),
    ("libc_fp_return_value.c", 11),
    ("libc_fp_classify.c", 0),
    ("libc_math_fdim_scalbn.c", 0),
    ("libc_fileno_isblank.c", 0),
    ("libc_math_minmax.c", 0),
    ("libc_math_round.c", 0),
    ("libc_math_libm.c", 0),
    ("libc_math_hyperbolic.c", 0),
    ("libc_math_special.c", 0),
    ("libc_math_nextafter.c", 0),
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
    ("type_warning_return.c", 0),
    ("type_warning_silenced_by_cast.c", 0),
    ("type_warning_arity.c", 0),
    // dlopen+dlsym+blr finds libc atoi and the indirect call passes
    // "123" in the System V argument register.
    ("dlopen_atoi.c", 123),
    ("dlopen_strlen.c", 13),
    // Multi-arg dlsym call path: pthread_create + pthread_join.
    // POSIX-only fixture; the JIT is gated to POSIX hosts already.
    ("pthread_create.c", 11),
    ("pthread_cond_timedwait.c", 0),
    ("posix_os_headers.c", 0),
    ("dirent_readdir.c", 0),
    ("ftw_walk.c", 0),
    ("stat_timespec.c", 0),
    ("malloc_size.c", 0),
    // sprintf 2-fixed + 4-variadic; the JIT shares the lowering
    // with the AOT backends so this guards both at once.
    ("variadic_sprintf.c", 0),
    // Float / double scalars parse, sizeof reports 8, pointer
    // arithmetic and indexed loads/stores work.
    ("float_pointer_basics.c", 0),
    // Full FP arithmetic: add/sub/mul/div, comparisons, casts,
    // unary negation. Routes through Fadd/.../Fcvtfi opcodes the
    // VM and both codegens implement.
    ("float_arithmetic.c", 0),
    ("float_single_precision.c", 0),
    ("fp_arg_passed_in_fp_reg.c", 0),
    ("fp_param_float_before_double.c", 0),
    ("float_arg_single_precision.c", 0),
    ("fp_return_value.c", 0),
    ("global_addr_multidim_index.c", 0),
    ("global_addr_struct_member.c", 0),
    ("local_array_runtime_nested_init.c", 0),
    ("many_fp_args.c", 0),
    ("fp_param_after_int_overflow.c", 0),
    ("float_double_mix.c", 0),
    ("fma_contraction.c", 0),
    ("hex_float_literal.c", 0),
    ("bool_normalize_c99.c", 0),
    ("compound_literal_block.c", 0),
    ("struct_arg_in_registers.c", 0),
    ("struct_arg_by_stack.c", 0),
    ("wide_char_utf8.c", 0),
    ("local_aggregate_runtime_init.c", 0),
    ("aggregate_init_struct_member_copy.c", 0),
    ("computed_goto.c", 0),
    ("label_addr_array_init.c", 0),
    ("sieve_of_eratosthenes.c", 0),
    ("static_neg_infinity_init.c", 0),
    ("sub_word_return_narrow.c", 0),
    ("fp_const_return.c", 0),
    ("struct_array_init_from_lvalue.c", 0),
    ("shift_result_type_signedness.c", 0),
    ("integer_negate_shift_overflow.c", 0),
    ("case_label_declaration.c", 0),
    ("char_constant_signedness.c", 0),
    ("func_name_in_initializer.c", 0),
    ("anon_union_braced_init.c", 0),
    ("array_2d_struct_init.c", 0),
    ("cast_abstract_fn_ptr.c", 0),
    ("decl_trailing_attribute.c", 0),
    ("winsock_netdb_protoent.c", 0),
    ("slot_coalesce_disjoint_temps.c", 0),
    ("alloca_alignment.c", 0),
    ("alloca_arena_in_bounds.c", 0),
    ("slot_coalesce_declared.c", 0),
    ("slot_coalesce_alloca.c", 0),
    ("fn_arg_decay_then_deref_assign.c", 0),
    ("array_range_designator.c", 0),
    ("bitfield_mixed_base_packing.c", 0),
    ("flex_array_member_sizing.c", 0),
    ("variadic_struct_return.c", 0),
    ("variadic_union_struct_return.c", 0),
    ("union_fp_member_regs_return.c", 0),
    ("fn_ptr_float_return.c", 0),
    ("fn_ptr_float_arg.c", 0),
    ("variadic_fn_ptr_init.c", 0),
    ("flexible_array_member.c", 0),
    ("wmem_functions.c", 0),
    ("posix_module_headers.c", 0),
    ("mmap_anonymous.c", 0),
    ("struct_tm_tm_zone_offset.c", 0),
    ("for_init_multiple_declarators.c", 0),
    ("compound_literal_member_operand.c", 0),
    ("signal_nsig.c", 0),
    ("flex_array_member_static_init.c", 0),
    ("array_compound_literal_static_init.c", 0),
    ("const_address_cast_and_arith.c", 0),
    ("const_conditional_address_init.c", 0),
    ("sizeof_array_type_and_binding.c", 0),
    ("sizeof_abstract_fn_ptr.c", 0),
    ("pragma_operator.c", 0),
    ("variadic_macro_named_rest.c", 0),
    ("stdatomic_c11.c", 0),
    ("atomic_rmw_ops.c", 0),
    ("fn_ptr_typedef_multi_declarator.c", 0),
    ("hfa_struct_return.c", 0),
    ("bitfield_assign_value.c", 0),
    ("struct_arg_indirect_subscript.c", 0),
    ("out_pointer_return_float_args.c", 0),
    ("compound_literal_tagged_address.c", 0),
    ("function_typed_parameter.c", 0),
    ("static_init_braced_scalar.c", 0),
    ("paren_string_char_array_init.c", 0),
    ("static_init_paren_relocation.c", 0),
    ("do_while_zero_returns.c", 0),
    ("self_referential_macro.c", 0),
    ("logical_not_float.c", 0),
    ("designator_override_and_braced_string.c", 0),
    ("multidim_array_init.c", 0),
    ("macro_paste_stringize_unexpanded.c", 0),
    ("line_directive.c", 0),
    ("float_global_init.c", 0),
    ("func_name_array.c", 0),
    ("unary_plus_init_and_param_shadow.c", 0),
    ("fn_ptr_multi_deref.c", 0),
    ("stringize_whitespace.c", 0),
    ("kr_old_style_def.c", 0),
    ("fn_ptr_return_type.c", 0),
    ("fn_returning_fn_ptr.c", 0),
    ("duff_switch_into_loop.c", 0),
    ("empty_macro_arg_and_string_rows.c", 0),
    ("inline_arg_count_mismatch.c", 0),
    ("inline_into_computed_goto.c", 0),
    ("inline_one_word_struct.c", 0),
    ("inline_one_word_struct_return.c", 0),
    ("inline_struct_return_reg.c", 0),
    ("inline_two_word_struct_return.c", 0),
    ("struct_return_reg_computed_goto.c", 0),
    ("inline_struct_return_escape.c", 0),
    ("inline_struct_param_mutated.c", 0),
    ("block_scope_extern.c", 0),
    ("extern_incomplete_struct_completion.c", 0),
    ("const_member_address_init.c", 0),
    ("const_float_div_zero.c", 0),
    ("array_of_struct_brace_elision.c", 0),
    ("local_struct_array_runtime_init.c", 0),
    ("scanf_fscanf_binding.c", 0),
    ("builtin_bit_count.c", 0),
    ("typeof_operator.c", 0),
    ("attribute_packed.c", 0),
    ("attribute_positions.c", 0),
    ("attribute_declspec.c", 0),
    ("attribute_c23.c", 0),
    ("static_assert_in_struct.c", 0),
    ("gnu_extension_keyword.c", 0),
    ("variadic_struct_by_value_arg.c", 0),
    ("fn_ptr_ternary_call_return.c", 0),
    ("float_condition_negative_zero.c", 0),
    ("tentative_array_definition.c", 0),
    ("tentative_array_use_before_init.c", 0),
    ("tentative_deferred_array_grows.c", 0),
    ("directive_in_macro_argument.c", 0),
    ("builtin_bswap_expect.c", 0),
    ("builtin_frame_address.c", 0),
    ("zero_length_array.c", 0),
    ("nested_compound_literal.c", 0),
    ("indirect_struct_return.c", 0),
    ("indirect_struct_return_outptr.c", 0),
    ("bitfield_incdec.c", 0),
    ("c11_atomic_specifier.c", 0),
    ("c11_atomic_ops.c", 0),
    ("inline_asm_hint.c", 0),
    ("compound_assign_int_fp.c", 0),
    ("signal_sig_t.c", 0),
    ("math_classify.c", 0),
    ("switch_unsigned_negative_case.c", 0),
    ("enum_bitfield_unsigned.c", 0),
    ("addr_of_intrinsic_math.c", 0),
    ("libc_struct_arg_by_value.c", 0),
    ("posix_unix_headers.c", 0),
    ("socket_headers_abi.c", 0),
    ("posix_utime_errno_headers.c", 0),
    ("cast_fn_typedef_ptr_in_initializer.c", 0),
    ("global_init_paren_operand.c", 0),
    ("function_type_typedef_declaration.c", 0),
    ("float_increment_decrement.c", 0),
    ("addr_of_libm_import.c", 0),
    ("addr_of_libc_strcmp.c", 0),
    ("libc_pread64_pwrite64.c", 0),
    ("struct_stat_abi_size.c", 0),
    ("block_scope_extern_forward_ref.c", 0),
    ("uint64_to_float.c", 0),
    ("double_to_uint64.c", 0),
    ("sysconf_pagesize.c", 0),
    ("strtoul_64bit_return.c", 0),
    ("libc_time_widths.c", 0),
    ("errno_socket_constants.c", 0),
    ("fts_and_fd_set_headers.c", 0),
    ("addr_of_intrinsic_math_float.c", 0),
    ("fn_ptr_float_arg_narrow.c", 0),
    ("struct_array_elided_runtime.c", 0),
    ("fn_type_typedef_field.c", 0),
    ("fn_type_typedef_local.c", 0),
    ("fn_type_typedef_cast.c", 0),
    ("nested_runtime_init.c", 0),
    ("anon_union_init.c", 0),
    ("builtin_trap.c", 0),
    ("struct_multi_byval.c", 0),
    ("struct_arg_two_eightbyte.c", 0),
    ("struct_return_by_value.c", 0),
    ("struct_return_to_global.c", 0),
    ("cast_fn_ptr_call.c", 0),
    ("fma_numeric_kernels.c", 0),
    ("fp_unary_intrinsic.c", 0),
    ("param_incoming_reg_clobber.c", 0),
    ("indexed_load_store.c", 0),
    ("struct_field_displacement.c", 0),
    ("indexed_swap_shared_addr.c", 0),
    ("store_to_load_forward.c", 0),
    ("inc_dec_step_one.c", 0),
    ("logical_op_normalize.c", 0),
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
    // Plain `char` follows the target's implementation-defined
    // signedness (C99 6.2.5p15) and the widening load agrees with the
    // `__CHAR_UNSIGNED__` predefine.
    ("plain_char_signedness.c", 0),
    // <limits.h> CHAR_MIN/CHAR_MAX agree with that signedness (C99 5.2.4.2.1).
    ("char_limits_consistency.c", 0),
    // Brace-wrapped string literal initializing a char-array struct
    // member (C99 6.7.9p14): copy the bytes, not the pointer.
    ("struct_member_brace_wrapped_string.c", 0),
    // `&`/`^`/`|` result type is the common type (C99 6.5.10-12) so a
    // cast of `unsigned | int` to signed sign-extends on widening.
    ("bitop_common_type_sign_extend.c", 0),
    // `~` result keeps the promoted operand type (C99 6.5.3.3p4):
    // `~(unsigned long)` stays unsigned so a following `>>` is logical.
    ("complement_preserves_type.c", 0),
    // A decimal constant past the widest signed type takes the
    // unsigned type at that rank (C99 6.4.4.1p5 + gcc/clang practice).
    ("decimal_literal_over_signed_max.c", 0),
    // Block-scope function declaration resolves to the file-scope
    // definition (C99 6.7p1 / 6.2.2p5).
    ("block_scope_function_declaration.c", 0),
    // A struct tag in a function body has block scope (C99 6.2.1).
    ("block_scope_struct_tag.c", 0),
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
    // compile-and-run; we hand it the c4-subset self-host fixture
    // via JIT argv and expect the resulting c4-VM run to print
    // "Hello 123" and exit 0.
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push("c4.c");
    let src = std::fs::read_to_string(&path).expect("read c4.c");
    let hello = concat!(
        env!("CARGO_MANIFEST_DIR"),
        "/tests/fixtures/c/c4_selfhost_hello.c"
    );
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
    let hello = concat!(
        env!("CARGO_MANIFEST_DIR"),
        "/tests/fixtures/c/c4_selfhost_hello.c"
    );
    let exit = jit_exit_native_optimized(&src, &["c4", hello]);
    assert_eq!(
        exit, 0,
        "c4 self-host JIT (native optimizer on) exited {exit}"
    );
}

#[test]
fn des_ct_fconf_wide_imm_scratch_native_optimized() {
    // BearSSL's DES round function (des_ct.c `Fconf`), extracted as
    // tests/fixtures/c/des_ct_fconf_wide_imm_scratch.c. At -O the
    // optimizer folds each `y = const ^ (x & mask)` line into a
    // `BinopI{Xor}` against a 32-bit constant outside i32 range; the
    // ~30 `y` temporaries are all live at once, saturating the
    // caller-saved registers so the wide-immediate Xor lowering finds
    // no free scratch and previously bailed with "op outside the
    // implemented subset" at ent_pc 113 on x86_64. The reserved r13
    // scratch closes that hole. The fixture self-folds its result into
    // one byte; 24 is the known answer (verified against the
    // non-optimized lowering, which agrees).
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push("des_ct_fconf_wide_imm_scratch.c");
    let src =
        std::fs::read_to_string(&path).unwrap_or_else(|e| panic!("read {}: {e}", path.display()));
    let opt = jit_exit_native_optimized(&src, &["fconf-O"]);
    assert_eq!(opt, 24, "des_ct Fconf miscompiled at -O (wide-imm scratch)");
    let noopt = jit_exit(&src, &["fconf-noO"]);
    assert_eq!(noopt, 24, "des_ct Fconf diverged between -O and default");
}

#[test]
fn variable_shift_to_spill_under_pressure() {
    // A variable-count shift whose value-to-shift and result spill, and
    // whose destination can land in rcx (the shift-count register). The
    // x86_64 lowering previously bailed when rd was rcx and no
    // caller-saved scratch was free; it now stages through the reserved
    // r13 scratch. The eight live accumulators saturate the registers
    // so the shift's working register is contended.
    let src = r#"
        unsigned do_shifts(unsigned a, unsigned b, unsigned c, unsigned d,
                           unsigned e, unsigned f, unsigned g, unsigned h) {
            unsigned s = (b ^ 0xAC74D1D4u) & 31u;
            unsigned x0 = (a << s) >> s;
            unsigned x1 = c + d + e + f + g + h;
            return x0 + (x1 & 0u);
        }
        int main() {
            // (a << s) >> s with a's high bits clear is a.
            unsigned r = do_shifts(200u, 3u, 7u, 8u, 9u, 10u, 11u, 12u);
            return (int)(r & 0xffu); // 200
        }
    "#;
    let cap = crate::c5::codegen::ssa_alloc::with_pool_size_override(3, 2, || {
        jit_exit(src, &["shift-spill-cap"])
    });
    assert_eq!(
        cap, 200,
        "variable shift miscompiled under register-pool cap"
    );
    let opt = jit_exit_native_optimized(src, &["shift-spill-O"]);
    assert_eq!(opt, 200, "variable shift miscompiled at -O");
}

#[test]
fn dead_strip_drops_unused_static_function() {
    // C99 6.2.2: an internal-linkage function that no reachable code or data
    // references is dropped before codegen. The entry, a called static, and
    // an external function all survive; only the unreferenced static is gone.
    use crate::Target;
    use crate::c5::codegen::ssa_shadow::produce_ssa_funcs;
    let src = "static int never_called(int x){return x+100;}\n\
               static int helper(int x){return x*2;}\n\
               int used_export(int x){return x-1;}\n\
               int main(void){return helper(3);}";
    let program = Compiler::new(src.to_string())
        .compile()
        .expect("compile failed");
    let funcs = produce_ssa_funcs(&program, Target::host()).expect("produce_ssa_funcs");
    let names: Vec<&str> = funcs.iter().map(|f| f.name.as_str()).collect();
    assert!(names.contains(&"main"), "entry must survive: {names:?}");
    assert!(
        names.contains(&"helper"),
        "called static must survive: {names:?}"
    );
    assert!(
        names.contains(&"used_export"),
        "external fn must survive: {names:?}"
    );
    assert!(
        !names.contains(&"never_called"),
        "unused static must be dead-stripped: {names:?}"
    );
}

// A pointer-to-extern-data initializer (`&extern_g`) must resolve to the
// symbol's runtime address under --jit, not be left NULL. `environ` is a
// libc data export reachable via dlsym in the host process. POSIX-only:
// the Windows resolver is best-effort and msvcrt's environ export is not
// uniform.
#[cfg(unix)]
#[test]
fn jit_resolves_pointer_to_extern_data() {
    let src = "extern char **environ;\n\
               char ***p = &environ;\n\
               int main(void) { return (*p == 0) ? 1 : 0; }\n";
    assert_eq!(jit_exit(src, &[]), 0);
}
