//! `-ffixed-REG`: a reserved register receives no allocator value and no
//! emitter scratch pick, while the ABI and inline asm still name it.

use crate::c5::codegen::ssa::reg_alloc::{
    self, Allocation, FP_SCRATCH_COUNT, NO_FP_SCRATCH, Place, RegBanks,
};
use crate::c5::codegen::ssa::shadow::produce_ssa_funcs;
use crate::{Compiler, FixedReg, FixedRegs, NativeOptions, Target, fixed_register};

/// Sixteen integers and twenty doubles live across calls, more than
/// either callee-saved bank holds, so every register of both banks and
/// the FP scratch see use.
const PRESSURE_SRC: &str = "\
long sink(long a, long b, long c, long d);
double fsink(double a, double b);
long gpr_pressure(long *p) {
    long v0 = p[0], v1 = p[1], v2 = p[2], v3 = p[3], v4 = p[4], v5 = p[5];
    long v6 = p[6], v7 = p[7], v8 = p[8], v9 = p[9], v10 = p[10], v11 = p[11];
    long v12 = p[12], v13 = p[13], v14 = p[14], v15 = p[15];
    long r = sink(v0, v1, v2, v3);
    r += sink(v4, v5, v6, v7);
    return r + v0 * 3 + v1 * 5 + v2 * 7 + v3 * 11 + v4 * 13 + v5 * 17 + v6 * 19 + v7 * 23
        + v8 * 29 + v9 * 31 + v10 * 37 + v11 * 41 + v12 * 43 + v13 * 47 + v14 * 53 + v15 * 59;
}
double fpr_pressure(double *p) {
    double v0 = p[0], v1 = p[1], v2 = p[2], v3 = p[3], v4 = p[4], v5 = p[5];
    double v6 = p[6], v7 = p[7], v8 = p[8], v9 = p[9], v10 = p[10], v11 = p[11];
    double v12 = p[12], v13 = p[13], v14 = p[14], v15 = p[15], v16 = p[16], v17 = p[17];
    double v18 = p[18], v19 = p[19];
    double r = fsink(v0, v1);
    r += fsink(v2, v3);
    return r + v0 * 3 + v1 * 5 + v2 * 7 + v3 * 11 + v4 * 13 + v5 * 17 + v6 * 19 + v7 * 23
        + v8 * 29 + v9 * 31 + v10 * 37 + v11 * 41 + v12 * 43 + v13 * 47 + v14 * 53 + v15 * 59
        + v16 * 61 + v17 * 67 + v18 * 71 + v19 * 73;
}
double fpr_leaf(double *p) {
    double v0 = p[0], v1 = p[1], v2 = p[2], v3 = p[3], v4 = p[4], v5 = p[5];
    double v6 = p[6], v7 = p[7];
    return v0 * v1 + v2 * v3 + v4 * v5 + v6 * v7 + v0 * v7 + v1 * v6 + v2 * v5 + v3 * v4;
}
int main(void) { return 0; }
";

fn reserve(target: Target, names: &[&str]) -> FixedRegs {
    let mut out = FixedRegs::NONE;
    for name in names {
        out.insert(fixed_register(target, name).unwrap_or_else(|e| panic!("{e}")));
    }
    out
}

/// The allocation of the named function of `src`, with its locals
/// promoted to SSA values the way `-O` promotes them. The banks are the
/// target's full ones: the pressure caps of a `codegen_test` run would
/// otherwise keep the control build off the register under test.
fn allocation(src: &str, target: Target, name: &str, fixed: FixedRegs) -> Allocation {
    let program = Compiler::with_target(src.to_string(), target)
        .compile()
        .unwrap_or_else(|e| panic!("compile: {e}"));
    let mut funcs = produce_ssa_funcs(&program, target, true, true).expect("produce_ssa_funcs");
    let f = funcs
        .iter_mut()
        .find(|f| f.name == name)
        .unwrap_or_else(|| panic!("function `{name}` not found"));
    crate::c5::codegen::ssa::mem2reg::run(f);
    reg_alloc::with_pool_size_override(usize::MAX, usize::MAX, || {
        reg_alloc::allocate(f, target, fixed)
    })
}

/// Values the allocation places in `reg`.
fn placed_in(alloc: &Allocation, reg: FixedReg) -> usize {
    alloc
        .places
        .iter()
        .filter(|p| match (reg, p) {
            (FixedReg::Gpr(r), Place::IntReg(n)) => *n == r,
            (FixedReg::Fpr(r), Place::FpReg(n)) => *n == r,
            _ => false,
        })
        .count()
}

/// Every architectural spelling names the register; the stack and frame
/// pointers, the link register and the emitters' scratch are refused by
/// role, and an unknown name is reported by name.
#[test]
fn every_spelling_names_the_register() {
    use FixedReg::{Fpr, Gpr};
    let a64 = Target::LinuxAarch64;
    let x64 = Target::LinuxX64;
    for name in ["q16", "v16", "d16", "s16", "h16", "b16"] {
        assert_eq!(fixed_register(a64, name), Ok(Fpr(16)), "{name}");
    }
    for name in ["x9", "w9", "r9"] {
        assert_eq!(fixed_register(a64, name), Ok(Gpr(9)), "{name}");
    }
    assert_eq!(fixed_register(a64, "x18"), Ok(Gpr(18)));
    assert_eq!(fixed_register(a64, "x28"), Ok(Gpr(28)));
    for name in ["rax", "eax", "ax", "al", "ah"] {
        assert_eq!(fixed_register(x64, name), Ok(Gpr(0)), "{name}");
    }
    for name in ["r8", "r8d", "r8w", "r8b"] {
        assert_eq!(fixed_register(x64, name), Ok(Gpr(8)), "{name}");
    }
    assert_eq!(fixed_register(x64, "bh"), Ok(Gpr(3)));
    assert_eq!(fixed_register(x64, "xmm5"), Ok(Fpr(5)));
    assert_eq!(fixed_register(x64, "ymm5"), Ok(Fpr(5)));
    assert_eq!(fixed_register(x64, "xmm14"), Ok(Fpr(14)));

    let refused = |target, name: &str, role: &str| {
        let err = fixed_register(target, name).expect_err(name);
        assert!(err.contains(role) && err.contains(name), "{name}: {err}");
    };
    for name in ["sp", "wsp"] {
        refused(a64, name, "stack pointer");
    }
    for name in ["fp", "x29", "w29", "r29"] {
        refused(a64, name, "frame pointer");
    }
    for name in ["lr", "x30"] {
        refused(a64, name, "link register");
    }
    for name in ["x16", "w17", "x19"] {
        refused(a64, name, "scratch register");
    }
    for name in ["rsp", "esp", "sp", "spl"] {
        refused(x64, name, "stack pointer");
    }
    for name in ["rbp", "ebp", "bp", "bpl"] {
        refused(x64, name, "frame pointer");
    }
    for name in ["r10", "r11", "r10d", "r11b"] {
        refused(x64, name, "scratch register");
    }
    for (target, name) in [
        (a64, "xzr"),
        (a64, "wzr"),
        (a64, "x31"),
        (a64, "rax"),
        (a64, "bogus"),
        (x64, "rip"),
        (x64, "mm0"),
        (x64, "x9"),
        (x64, "bogus"),
    ] {
        refused(target, name, "unknown register name");
    }
}

/// A reserved register leaves its bank; a reserved FP scratch moves to
/// the next candidate outside the banks, then to the callee-saved bank's
/// tail, and what is still missing is marked for the emit to refuse.
#[test]
fn a_reserved_register_leaves_the_banks_and_the_scratch_moves() {
    let a64 = Target::LinuxAarch64;
    let x64 = Target::LinuxX64;
    let win = Target::WindowsX64;
    let default = RegBanks::for_target(a64);
    assert!(default.callee_gprs.contains(&20) && default.callee_fprs.contains(&10));
    assert_eq!(default.fp_scratch, [16, 17, 18]);

    let banks = RegBanks::new(a64, reserve(a64, &["x20", "d10", "x18"]));
    assert!(!banks.callee_gprs.contains(&20) && !banks.callee_fprs.contains(&10));
    assert_eq!(banks.callee_gprs.len(), default.callee_gprs.len() - 1);
    assert_eq!(banks.caller_gprs, default.caller_gprs);
    assert_eq!(banks.fp_scratch, default.fp_scratch);

    let banks = RegBanks::new(a64, reserve(a64, &["q16"]));
    assert_eq!(banks.fp_scratch, [17, 18, 19]);
    let all_upper: Vec<String> = (16..32).map(|n| format!("q{n}")).collect();
    let names: Vec<&str> = all_upper.iter().map(String::as_str).collect();
    let banks = RegBanks::new(a64, reserve(a64, &names));
    assert_eq!(banks.fp_scratch, [15, 14, 13]);
    assert_eq!(banks.callee_fprs, [8, 9, 10, 11, 12]);
    assert_eq!(banks.caller_fprs, default.caller_fprs);
    let from_13: Vec<String> = (13..32).map(|n| format!("q{n}")).collect();
    let names: Vec<&str> = from_13.iter().map(String::as_str).collect();
    let banks = RegBanks::new(a64, reserve(a64, &names));
    assert_eq!(banks.fp_scratch, [12, 11, 10]);
    assert_eq!(banks.callee_fprs, [8, 9]);

    assert_eq!(RegBanks::for_target(x64).fp_scratch, [14, 15, 13]);
    let banks = RegBanks::new(x64, reserve(x64, &["xmm14", "r12"]));
    assert_eq!(banks.fp_scratch, [15, 13, 8]);
    assert!(!banks.callee_gprs.contains(&12));
    let upper: Vec<String> = (8..16).map(|n| format!("xmm{n}")).collect();
    let names: Vec<&str> = upper.iter().map(String::as_str).collect();
    let banks = RegBanks::new(x64, reserve(x64, &names));
    assert_eq!(banks.fp_scratch, [NO_FP_SCRATCH; FP_SCRATCH_COUNT]);
    assert_eq!(banks.caller_fprs, RegBanks::for_target(x64).caller_fprs);

    let banks = RegBanks::new(win, reserve(win, &["xmm13", "xmm14", "xmm15"]));
    assert_eq!(banks.fp_scratch, [6, 7, 8]);
}

/// Under register pressure the allocator uses every register of both
/// banks; a reserved one receives no value and reaches no save list,
/// and a reserved FP scratch is not the emit pass's scratch either.
#[test]
fn a_pressure_function_keeps_a_reserved_register_unused() {
    use FixedReg::{Fpr, Gpr};
    // x86-64 has no callee-saved FP bank, so a value live across a call
    // is spilled there; its FP bank fills in the leaf instead.
    for (target, gpr, gpr_name, fp_fn, fpr, fpr_name, scratch, scratch_name) in [
        (
            Target::LinuxAarch64,
            20,
            "x20",
            "fpr_pressure",
            10,
            "d10",
            16,
            "q16",
        ),
        (
            Target::LinuxX64,
            12,
            "r12",
            "fpr_leaf",
            5,
            "xmm5",
            14,
            "xmm14",
        ),
    ] {
        let g = allocation(PRESSURE_SRC, target, "gpr_pressure", FixedRegs::NONE);
        assert!(
            placed_in(&g, Gpr(gpr)) > 0,
            "{target:?}: {gpr_name} unused without the flag"
        );
        assert!(
            g.gpr_used.contains(&gpr),
            "{target:?}: {gpr_name} not saved without the flag"
        );
        let g = allocation(
            PRESSURE_SRC,
            target,
            "gpr_pressure",
            reserve(target, &[gpr_name]),
        );
        assert_eq!(
            placed_in(&g, Gpr(gpr)),
            0,
            "{target:?}: {gpr_name} placed under -ffixed-"
        );
        assert!(
            !g.gpr_used.contains(&gpr),
            "{target:?}: {gpr_name} saved under -ffixed-"
        );
        assert!(g.spill_count > 0, "{target:?}: the pressure did not spill");

        let f = allocation(PRESSURE_SRC, target, fp_fn, FixedRegs::NONE);
        assert!(
            placed_in(&f, Fpr(fpr)) > 0,
            "{target:?}: {fpr_name} unused without the flag"
        );
        assert_eq!(f.fp_scratch[0], scratch);
        let f = allocation(
            PRESSURE_SRC,
            target,
            fp_fn,
            reserve(target, &[fpr_name, scratch_name]),
        );
        assert_eq!(
            placed_in(&f, Fpr(fpr)),
            0,
            "{target:?}: {fpr_name} placed under -ffixed-"
        );
        assert!(
            !f.fp_used.contains(&fpr),
            "{target:?}: {fpr_name} saved under -ffixed-"
        );
        assert!(
            !f.fp_scratch.contains(&scratch),
            "{target:?}: {scratch_name} stays scratch"
        );
        assert_eq!(placed_in(&f, Fpr(scratch)), 0);
    }
}

/// A reserved callee-saved register taken as FP scratch is saved by the
/// prologue of a function with FP work, and by no other.
#[test]
fn a_callee_saved_scratch_reaches_the_save_list_of_fp_work_only() {
    let a64 = Target::LinuxAarch64;
    let upper: Vec<String> = (16..32).map(|n| format!("q{n}")).collect();
    let names: Vec<&str> = upper.iter().map(String::as_str).collect();
    let fixed = reserve(a64, &names);
    let f = allocation(PRESSURE_SRC, a64, "fpr_pressure", fixed);
    assert_eq!(f.fp_scratch, [15, 14, 13]);
    assert!(f.fp_used.contains(&15) && f.fp_used.contains(&14));
    assert!(
        !f.fp_used.contains(&13),
        "the third scratch serves the fused multiply-add only"
    );
    let g = allocation(PRESSURE_SRC, a64, "gpr_pressure", fixed);
    assert!(
        g.fp_used.is_empty(),
        "no FP work, nothing to save: {:?}",
        g.fp_used
    );
}

/// Compile `src` at `-O` under `fixed` and return the emitted text.
fn text_under(src: &str, target: Target, fixed: FixedRegs) -> Result<Vec<u8>, String> {
    let program = Compiler::with_target(src.to_string(), target)
        .compile()
        .map_err(|e| e.to_string())?;
    let opts = NativeOptions {
        optimize: true,
        fixed_regs: fixed,
        ..NativeOptions::default()
    };
    crate::c5::codegen::lower_for(&program, target, opts)
        .map(|b| b.text)
        .map_err(|e| e.to_string())
}

/// A `register` variable bound to a reserved register still pins its
/// inline-asm operand there, and a clobber may still name one.
#[test]
fn inline_asm_still_names_a_reserved_register() {
    let a64 = "long f(long x) { register long a asm(\"x20\") = x; long out; \
               __asm__(\"add %0, %1, %1\" : \"=r\"(out) : \"r\"(a) : \"x21\", \"v16\"); \
               return out; }\nint main(void) { return f(21) - 42; }\n";
    let text = text_under(
        a64,
        Target::LinuxAarch64,
        reserve(Target::LinuxAarch64, &["x20", "x21", "q16"]),
    )
    .unwrap_or_else(|e| panic!("{e}"));
    // `add x0, x20, x20`: the operand rides the bound register.
    let word = 0x8B14_0280u32.to_le_bytes();
    assert!(
        text.windows(4).any(|w| w == word),
        "expected `add x0, x20, x20`"
    );

    let x64 = "long f(long x) { register long a asm(\"r12\") = x; long out; \
               __asm__(\"movq %1, %0; addq %1, %0\" : \"=r\"(out) : \"r\"(a) : \"r13\", \"xmm14\"); \
               return out; }\nint main(void) { return f(21) - 42; }\n";
    let text = text_under(
        x64,
        Target::LinuxX64,
        reserve(Target::LinuxX64, &["r12", "r13", "xmm14"]),
    )
    .unwrap_or_else(|e| panic!("{e}"));
    // `movq %r12, %rax` (4C 89 E0) then `addq %r12, %rax` (4C 01 E0).
    assert!(
        text.windows(3).any(|w| w == [0x4C, 0x89, 0xE0]),
        "expected `movq %r12, %rax`"
    );
    assert!(
        text.windows(3).any(|w| w == [0x4C, 0x01, 0xE0]),
        "expected `addq %r12, %rax`"
    );
}

/// When the reservations leave no FP scratch, a function with FP work is
/// refused by name rather than emitted through a reserved register; one
/// without FP work still compiles.
#[test]
fn no_fp_scratch_left_is_a_diagnostic() {
    let src = "double scale(double *p) { return p[0] * 3.0 + p[1]; }\n\
               long count(long *p) { return p[0] * 3 + p[1]; }\n\
               int main(void) { return 0; }\n";
    let int_only =
        "long count(long *p) { return p[0] * 3 + p[1]; }\nint main(void) { return 0; }\n";
    // AAPCS64's callee-saved d8..d15 back the scratch up, so every
    // register outside the argument bank has to go.
    let a64 = Target::LinuxAarch64;
    let from_8: Vec<String> = (8..32).map(|n| format!("q{n}")).collect();
    let names: Vec<&str> = from_8.iter().map(String::as_str).collect();
    let err = text_under(src, a64, reserve(a64, &names)).expect_err("no FP scratch on aarch64");
    assert!(
        err.contains("no floating-point scratch register") && err.contains("scale"),
        "{err}"
    );
    text_under(int_only, a64, reserve(a64, &names)).unwrap_or_else(|e| panic!("{e}"));

    let x64 = Target::LinuxX64;
    let upper: Vec<String> = (8..16).map(|n| format!("xmm{n}")).collect();
    let names: Vec<&str> = upper.iter().map(String::as_str).collect();
    let err = text_under(src, x64, reserve(x64, &names)).expect_err("no FP scratch on x86-64");
    assert!(
        err.contains("no floating-point scratch register") && err.contains("scale"),
        "{err}"
    );
    text_under(int_only, x64, reserve(x64, &names)).unwrap_or_else(|e| panic!("{e}"));
}
