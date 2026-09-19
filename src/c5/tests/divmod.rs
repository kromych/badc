//! Integer division and remainder: the operand width and conversions the
//! walker gives them, read off the SSA it builds.

use crate::c5::ir::{BinOp, FunctionSsa, Inst};
use crate::{CompileOptions, Compiler, Target};

const TARGETS: [Target; 5] = [
    Target::LinuxX64,
    Target::LinuxAarch64,
    Target::MacOSAarch64,
    Target::WindowsX64,
    Target::WindowsAarch64,
];

/// The walker's SSA for `name`, before any pass.
fn walked(src: &str, name: &str, target: Target, optimize: bool) -> FunctionSsa {
    use crate::c5::codegen::ssa::shadow::produce_ssa_funcs;
    let opts = CompileOptions::default()
        .with_no_entry_point(true)
        .with_optimize(optimize);
    let program = Compiler::with_options(src.to_string(), target, opts)
        .compile()
        .unwrap_or_else(|e| panic!("compile ({target:?}): {e}"));
    produce_ssa_funcs(&program, target, optimize, true)
        .unwrap_or_else(|e| panic!("walk ({target:?}): {e}"))
        .into_iter()
        .find(|f| f.name == name)
        .unwrap_or_else(|| panic!("{target:?}: no function `{name}`"))
}

fn has_binop(f: &FunctionSsa, want: BinOp) -> bool {
    f.insts
        .iter()
        .any(|i| matches!(i, Inst::Binop { op, .. } | Inst::BinopI { op, .. } if *op == want))
}

/// C99 6.5.6p9: the byte distance of two pointers is divided at the width
/// of `ptrdiff_t`. The 64-bit reciprocal is a high multiply; the 32-bit one
/// a plain multiply, exact only below 2^31.
#[test]
fn pointer_difference_divides_at_pointer_width() {
    const SRC: &str = "struct T { int a, b, c; };\n\
        long long d(struct T *p, struct T *q) { return p - q; }\n";
    for target in TARGETS {
        let f = walked(SRC, "d", target, false);
        assert!(
            has_binop(&f, BinOp::Mulh) && !has_binop(&f, BinOp::Mul),
            "{target:?}: {:?}",
            f.insts
        );
    }
}

fn divides(f: &FunctionSsa) -> bool {
    [BinOp::Div, BinOp::Divu, BinOp::Mod, BinOp::Modu]
        .into_iter()
        .any(|op| has_binop(f, op))
}

/// `(loads, stores)` whose `volatile` mark is set.
fn volatile_accesses(f: &FunctionSsa) -> (usize, usize) {
    let count = |p: fn(&Inst) -> bool| f.insts.iter().filter(|i| p(i)).count();
    (
        count(|i| {
            matches!(
                i,
                Inst::Load { volatile: true, .. } | Inst::LoadLocal { volatile: true, .. }
            )
        }),
        count(|i| {
            matches!(
                i,
                Inst::Store { volatile: true, .. } | Inst::StoreLocal { volatile: true, .. }
            )
        }),
    )
}

/// C99 6.5.16.2p3: `E1 op= E2` computes `E1 op E2`, so a constant divisor
/// is reduced there as under the binary operator, whatever the lvalue.
#[test]
fn compound_division_by_a_constant_is_reduced_for_every_lvalue() {
    const SRC: &str = "struct S { int f; unsigned char c; short h; };\n\
        int local(int a) { a /= 10; return a; }\n\
        unsigned ulocal(unsigned a) { a %= 7; return a; }\n\
        long long wide(long long a) { a /= -1000; return a; }\n\
        unsigned long long uwide(unsigned long long a) { a %= 10; return a; }\n\
        unsigned char narrow(unsigned char a) { a /= 3; return a; }\n\
        short half(short a) { a %= -5; return a; }\n\
        int mixed(int a) { a /= 3u; return a; }\n\
        void field(struct S *s) { s->f /= 10; s->c %= 3; s->h /= 7; }\n\
        void element(int *p, int i) { p[i] %= 10; }\n\
        int value(int a) { return (a /= 10) + 1; }\n";
    for target in TARGETS {
        for name in [
            "local", "ulocal", "wide", "uwide", "narrow", "half", "mixed", "field", "element",
            "value",
        ] {
            let f = walked(SRC, name, target, false);
            assert!(!divides(&f), "{target:?} {name}: {:?}", f.insts);
        }
    }
}

/// What the reduction must leave alone: a divisor that is no constant, a
/// zero divisor (C99 6.5.5p5; the divide instruction is the behavior), and
/// a floating operation.
#[test]
fn compound_division_keeps_the_divide_where_no_reduction_applies() {
    const SRC: &str = "int var(int a, int d) { a /= d; return a; }\n\
        int zero(int a) { a /= 0; return a; }\n\
        unsigned uzero(unsigned a) { a %= 0; return a; }\n\
        double fp(double x) { x /= 10; return x; }\n\
        int fp_rhs(int a) { a /= 2.5; return a; }\n";
    for target in TARGETS {
        for (name, op) in [
            ("var", BinOp::Div),
            ("zero", BinOp::Div),
            ("uzero", BinOp::Modu),
            ("fp", BinOp::Fdiv),
            ("fp_rhs", BinOp::Fdiv),
        ] {
            let f = walked(SRC, name, target, false);
            assert!(has_binop(&f, op), "{target:?} {name}: {:?}", f.insts);
        }
    }
}

/// C99 6.7.3p6: a volatile lvalue of a compound division is read once and
/// written once, the reduction's several uses of the old value included.
#[test]
fn compound_division_reads_a_volatile_lvalue_once() {
    const SRC: &str = "void local(int n) { volatile int v = n; v %= 10; }\n\
        void global(volatile unsigned *p) { *p /= 7; }\n";
    for target in TARGETS {
        let f = walked(SRC, "local", target, false);
        // The initialization is the second volatile store.
        assert_eq!(volatile_accesses(&f), (1, 2), "{target:?}: {:?}", f.insts);
        assert!(!divides(&f), "{target:?}: {:?}", f.insts);
        let f = walked(SRC, "global", target, false);
        assert_eq!(volatile_accesses(&f), (1, 1), "{target:?}: {:?}", f.insts);
        assert!(!divides(&f), "{target:?}: {:?}", f.insts);
    }
}

/// C99 6.3.1.8: an unsigned division at a 32-bit common type reads each
/// operand converted to it. LLP64 `unsigned long` is such a type; a signed
/// operand carries its sign in the register's high half until masked.
#[test]
fn narrow_unsigned_division_masks_both_operands() {
    const SRC: &str = "unsigned long var(unsigned long a, int b) { return a / b; }\n\
        unsigned long lit(int a) { return a / 7ul; }\n\
        unsigned long rem(int a, unsigned long d) { a %= d; return a; }\n";
    let is_mask = |f: &FunctionSsa, v: u32| {
        matches!(
            f.insts[v as usize],
            Inst::BinopI {
                op: BinOp::And,
                rhs_imm: 0xffff_ffff,
                ..
            }
        )
    };
    let masks = |f: &FunctionSsa| (0..f.insts.len() as u32).filter(|&v| is_mask(f, v)).count();
    for target in [Target::WindowsX64, Target::WindowsAarch64] {
        // The signed operand is the divisor of `var` and the dividend of
        // `rem`; the other one is a 32-bit unsigned load.
        let f = walked(SRC, "var", target, false);
        let masked = f
            .insts
            .iter()
            .any(|i| matches!(i, Inst::Binop { op: BinOp::Divu, rhs, .. } if is_mask(&f, *rhs)));
        assert!(masked, "{target:?}: {:?}", f.insts);
        let f = walked(SRC, "rem", target, false);
        let masked = f
            .insts
            .iter()
            .any(|i| matches!(i, Inst::Binop { op: BinOp::Modu, lhs, .. } if is_mask(&f, *lhs)));
        assert!(masked, "{target:?}: {:?}", f.insts);
        // The reciprocal multiply reads the masked dividend.
        let f = walked(SRC, "lit", target, false);
        let masked = f
            .insts
            .iter()
            .any(|i| matches!(i, Inst::BinopI { op: BinOp::Mul, lhs, .. } if is_mask(&f, *lhs)));
        assert!(masked, "{target:?}: {:?}", f.insts);
    }
    // LP64 `unsigned long` fills the register: no mask, 64-bit reciprocal.
    let f = walked(SRC, "lit", Target::LinuxX64, false);
    assert!(
        masks(&f) == 0 && has_binop(&f, BinOp::Mulhu),
        "{:?}",
        f.insts
    );
}
