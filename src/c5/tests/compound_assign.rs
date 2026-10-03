//! Compound assignment (C99 6.5.16.2): the lvalue evaluated once and the
//! operation performed in the type of `E1 op E2`, read off the SSA the
//! walker builds.

use crate::c5::ir::{BinOp, FpCastKind, FunctionSsa, Inst};
use crate::{CompileOptions, Compiler, Target};

const TARGETS: [Target; 5] = [
    Target::LinuxX64,
    Target::LinuxAarch64,
    Target::MacOSAarch64,
    Target::WindowsX64,
    Target::WindowsAarch64,
];

/// The walker's SSA for `name`, before any pass.
fn walked(src: &str, name: &str, target: Target) -> FunctionSsa {
    use crate::c5::codegen::ssa::shadow::produce_ssa_funcs;
    let opts = CompileOptions::default().with_no_entry_point(true);
    let program = Compiler::with_options(src.to_string(), target, opts)
        .compile()
        .unwrap_or_else(|e| panic!("compile ({target:?}): {e}"));
    produce_ssa_funcs(&program, target, false, true)
        .unwrap_or_else(|e| panic!("walk ({target:?}): {e}"))
        .into_iter()
        .find(|f| f.name == name)
        .unwrap_or_else(|| panic!("{target:?}: no function `{name}`"))
}

fn count(f: &FunctionSsa, p: impl Fn(&Inst) -> bool) -> usize {
    f.insts.iter().filter(|i| p(i)).count()
}

fn has_binop(f: &FunctionSsa, want: BinOp) -> bool {
    count(
        f,
        |i| matches!(i, Inst::Binop { op, .. } | Inst::BinopI { op, .. } if *op == want),
    ) > 0
}

/// C99 6.5.16.2p3: the object expression of a bit-field `op=` is
/// evaluated once, spelled with or without parentheses, as for any other
/// member; so is that of `++`.
#[test]
fn a_bitfield_compound_assignment_evaluates_its_object_once() {
    const SRC: &str = "struct S { int f; int c : 7; unsigned b : 5; };\n\
        static struct S s;\n\
        static struct S *get(void) { return &s; }\n\
        void plain(void) { get()->c += 1; }\n\
        void paren(void) { (get()->b) *= 3; }\n\
        void member(void) { get()->f -= 2; }\n\
        int pre(void) { return ++get()->c; }\n";
    for target in TARGETS {
        for name in ["plain", "paren", "member", "pre"] {
            let f = walked(SRC, name, target);
            let calls = count(&f, |i| matches!(i, Inst::Call { .. }));
            assert_eq!(calls, 1, "{target:?} {name}: {:?}", f.insts);
        }
    }
}

/// C99 6.3.1.8: `E1 op E2` takes the common type of both operands, so a
/// signed bit-field divided by an `unsigned` operand divides unsigned; a
/// `float` operand of an integer lvalue keeps the operation in `float`
/// (FLT_EVAL_METHOD 0); a `double` result converts to `_Bool` by a
/// comparison and to `unsigned long long` by the unsigned conversion.
#[test]
fn a_compound_assignment_computes_in_the_common_type() {
    const SRC: &str = "struct S { int c : 7; _Bool t : 1; };\n\
        void div(struct S *s, unsigned d) { s->c /= d; }\n\
        void rem(struct S *s, unsigned d) { s->c %= d; }\n\
        void fl(int *p, float x) { *p += x; }\n\
        void flag(_Bool *p, double x) { *p += x; }\n\
        void field_flag(struct S *s, double x) { s->t += x; }\n\
        void wide(unsigned long long *p, double x) { *p += x; }\n";
    for target in TARGETS {
        let f = walked(SRC, "div", target);
        assert!(has_binop(&f, BinOp::Divu), "{target:?} div: {:?}", f.insts);
        let f = walked(SRC, "rem", target);
        assert!(has_binop(&f, BinOp::Modu), "{target:?} rem: {:?}", f.insts);
        let f = walked(SRC, "fl", target);
        let widen = count(&f, |i| {
            matches!(
                i,
                Inst::FpCast {
                    kind: FpCastKind::F32ToF64,
                    ..
                }
            )
        });
        assert!(
            has_binop(&f, BinOp::Fadd) && widen == 0,
            "{target:?} fl: {:?}",
            f.insts
        );
        for name in ["flag", "field_flag"] {
            let f = walked(SRC, name, target);
            assert!(
                has_binop(&f, BinOp::Fne),
                "{target:?} {name}: {:?}",
                f.insts
            );
        }
        let f = walked(SRC, "wide", target);
        let kinds = [FpCastKind::UIntToFp, FpCastKind::UFpToInt];
        for kind in kinds {
            let n = count(
                &f,
                |i| matches!(i, Inst::FpCast { kind: k, .. } if *k == kind),
            );
            assert_eq!(n, 1, "{target:?} wide {kind:?}: {:?}", f.insts);
        }
    }
}

/// C99 6.5.16.2p3 with 6.3.1.8: an `__int128` lvalue with a floating
/// operand converts to the floating type and back rather than truncating
/// the operand to an integer.
#[test]
fn an_int128_lvalue_with_a_floating_operand_computes_in_floating_point() {
    const SRC: &str = "void f(__int128 *p, double x) { *p -= x; }\n";
    for target in TARGETS {
        let f = walked(SRC, "f", target);
        assert!(has_binop(&f, BinOp::Fsub), "{target:?}: {:?}", f.insts);
    }
}
