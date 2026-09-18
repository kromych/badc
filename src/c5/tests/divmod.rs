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
