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

/// At `-O` the walker leaves a division by a constant as one instruction
/// for the optimizer to fold, bound and expand; without the optimizer it
/// expands the division itself. A zero divisor is a register divide in
/// both modes.
#[test]
fn constant_division_stays_whole_only_for_the_optimizer() {
    const SRC: &str = "int q(int a) { return a / 10; }\n\
        unsigned r(unsigned a) { a %= 7; return a; }\n\
        int z(int a) { return a / 0; }\n";
    let whole = |f: &FunctionSsa, want: BinOp, k: i64| {
        f.insts
            .iter()
            .any(|i| matches!(i, Inst::BinopI { op, rhs_imm, .. } if *op == want && *rhs_imm == k))
    };
    for target in TARGETS {
        let f = walked(SRC, "q", target, true);
        assert!(whole(&f, BinOp::Div, 10), "{target:?}: {:?}", f.insts);
        let f = walked(SRC, "r", target, true);
        assert!(whole(&f, BinOp::Modu, 7), "{target:?}: {:?}", f.insts);
        for name in ["q", "r"] {
            let f = walked(SRC, name, target, false);
            assert!(!divides(&f), "{target:?} {name}: {:?}", f.insts);
        }
        for optimize in [false, true] {
            let f = walked(SRC, "z", target, optimize);
            let register_form = f
                .insts
                .iter()
                .any(|i| matches!(i, Inst::Binop { op: BinOp::Div, .. }));
            assert!(register_form, "{target:?}: {:?}", f.insts);
        }
    }
}

/// An expansion of at most one instruction is not left whole: a mask, a
/// shift or the operand bounds the result as the division would, and the
/// passes ahead of the expansion read its shape.
#[test]
fn single_instruction_expansions_are_built_at_once() {
    const SRC: &str = "unsigned mask(unsigned a) { return a % 8u; }\n\
        unsigned shift(unsigned a) { return a / 16u; }\n\
        int same(int a) { return a / 1; }\n\
        unsigned top(unsigned a) { return a / 0x80000001u; }\n\
        int biased(int a) { return a / 8; }\n";
    for target in TARGETS {
        for (name, op) in [
            ("mask", Some(BinOp::And)),
            ("shift", Some(BinOp::Shru)),
            ("same", None),
            ("top", Some(BinOp::Uge)),
        ] {
            let f = walked(SRC, name, target, true);
            assert!(!divides(&f), "{target:?} {name}: {:?}", f.insts);
            assert!(
                op.is_none_or(|op| has_binop(&f, op)),
                "{target:?} {name}: {:?}",
                f.insts
            );
        }
        // Three instructions: left to the optimizer.
        let f = walked(SRC, "biased", target, true);
        assert!(has_binop(&f, BinOp::Div), "{target:?}: {:?}", f.insts);
    }
}

/// The `-O` pipeline's output for `name`: the dump body and instructions.
#[cfg(feature = "full")]
fn optimized(src: &str, name: &str, target: Target) -> (String, Vec<(u32, String)>) {
    super::codegen::optimized_function_full_pool(src, name, target)
}

#[cfg(feature = "full")]
fn divide_texts(insts: &[(u32, String)]) -> Vec<&str> {
    insts
        .iter()
        .map(|(_, i)| i.as_str())
        .filter(|i| {
            ["op=div,", "op=divu,", "op=mod,", "op=modu,"]
                .iter()
                .any(|d| i.contains(d))
        })
        .collect()
}

/// A divisor the optimizer makes constant -- the argument of an inlined
/// helper, the parameter every call agrees on -- takes no divide, and the
/// immediate form the walker defers reaches no emitter.
#[cfg(feature = "full")]
#[test]
fn divisor_made_constant_by_the_optimizer_is_reduced() {
    const SRC: &str = "static int dv(int a, int d) { return a / d; }\n\
        static unsigned long long md(unsigned long long a, unsigned long long d) { return a % d; }\n\
        int inlined(int a) { return dv(a, 10); }\n\
        unsigned long long inlined_wide(unsigned long long a) { return md(a, 1000); }\n\
        __attribute__((noinline)) static int fixed(int a, int d) { return a / d; }\n\
        int calls(int a, int b) { return fixed(a, 7) + fixed(b, 7); }\n\
        int literal(int a) { return a / 10 + a % 10; }\n";
    for target in TARGETS {
        for name in ["inlined", "inlined_wide", "fixed", "literal"] {
            let (body, insts) = optimized(SRC, name, target);
            assert!(divide_texts(&insts).is_empty(), "{target:?} {name}: {body}");
        }
    }
}

/// What the expansion must not take: a divisor that inlining made zero
/// keeps the hardware divide (C99 6.5.5p5), and a divisor that stays a
/// variable keeps its own.
#[cfg(feature = "full")]
#[test]
fn zero_and_variable_divisors_keep_the_divide_through_the_optimizer() {
    const SRC: &str = "static int dv(int a, int d) { return a / d; }\n\
        int by_zero(int a) { return dv(a, 0); }\n\
        int literal_zero(int a) { return a % 0; }\n\
        int variable(int a, int d) { return dv(a, d); }\n";
    for target in TARGETS {
        for name in ["by_zero", "literal_zero", "variable"] {
            let (body, insts) = optimized(SRC, name, target);
            let left = divide_texts(&insts);
            assert!(
                !left.is_empty() && left.iter().all(|i| i.starts_with("Binop {")),
                "{target:?} {name}: {body}"
            );
        }
    }
}

/// A dividend the optimizer bounds below by zero divides as unsigned: a
/// byte promoted to `int`, and an `int` under a guard, whose power-of-two
/// division is one shift or mask with no bias. Without the bound the
/// bias stays.
#[cfg(feature = "full")]
#[test]
fn non_negative_dividend_divides_as_unsigned() {
    const SRC: &str = "int byte(unsigned char c) { return c / 10 + c % 10; }\n\
        int guarded(int n) { int t = 0; while (n > 0) { t += n % 2; n /= 2; } return t; }\n\
        int plain(int n) { return n / 2; }\n";
    let has = |insts: &[(u32, String)], text: &str| insts.iter().any(|(_, i)| i.contains(text));
    for target in TARGETS {
        let (body, insts) = optimized(SRC, "byte", target);
        assert!(divide_texts(&insts).is_empty(), "{target:?}: {body}");
        // No arithmetic shift and no sign fix-up (`shru 63`).
        assert!(
            !has(&insts, "op=shr,") && !has(&insts, "rhs_imm=63"),
            "{target:?}: {body}"
        );
        let (body, insts) = optimized(SRC, "guarded", target);
        assert!(
            has(&insts, "op=and,") && has(&insts, "op=shru,") && !has(&insts, "rhs_imm=63"),
            "{target:?}: {body}"
        );
        let (body, insts) = optimized(SRC, "plain", target);
        assert!(
            has(&insts, "op=shru, ") && has(&insts, "rhs_imm=63") && has(&insts, "op=shr,"),
            "{target:?}: {body}"
        );
    }
}

/// The operation's signedness and width are the C types' (C99 6.3.1.8),
/// not the constant's: -3 converted to `unsigned` is a divisor above 2^31,
/// whose quotient is a comparison, and `long` divides at 32 bits on LLP64
/// and at 64 on LP64.
#[cfg(feature = "full")]
#[test]
fn reduction_follows_the_operand_types() {
    const SRC: &str = "static unsigned ud(unsigned a, unsigned d) { return a / d; }\n\
        unsigned negative_constant(unsigned a) { return ud(a, -3); }\n\
        long tenth(long a) { return a / 10; }\n";
    let has = |insts: &[(u32, String)], text: &str| insts.iter().any(|(_, i)| i.contains(text));
    for target in TARGETS {
        let (body, insts) = optimized(SRC, "negative_constant", target);
        assert!(
            has(&insts, "op=uge,") && has(&insts, "rhs_imm=4294967293"),
            "{target:?}: {body}"
        );
        let (body, insts) = optimized(SRC, "tenth", target);
        let llp64 = matches!(target, Target::WindowsX64 | Target::WindowsAarch64);
        assert_eq!(has(&insts, "op=mulh,"), !llp64, "{target:?}: {body}");
        assert_eq!(
            has(&insts, "rhs_imm=1717986919"),
            llp64,
            "{target:?}: {body}"
        );
    }
}
