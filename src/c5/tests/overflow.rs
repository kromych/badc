//! Signed overflow in the `-O` SSA: the `nsw` mark on the renormalization
//! of a signed `+ - *` and unary `-`, whose overflow C99 6.5p5 leaves
//! undefined and `-fwrapv` defines to wrap.

use super::codegen::optimized_function_with;
use crate::{CompileOptions, Target};
use alloc::collections::BTreeSet;
use alloc::string::String;
use alloc::vec::Vec;

fn dump(src: &str, name: &str, wrapv: bool) -> (String, Vec<(u32, String)>) {
    crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(usize::MAX, usize::MAX, || {
        optimized_function_with(
            src,
            name,
            Target::LinuxX64,
            CompileOptions::default().with_wrapv(wrapv),
        )
    })
}

fn refs(text: &str) -> impl Iterator<Item = u32> + '_ {
    text.split(|c: char| !c.is_ascii_alphanumeric())
        .filter_map(|w| w.strip_prefix('v')?.parse().ok())
}

/// The text of the instruction the function returns.
fn returned<'a>(body: &str, insts: &'a [(u32, String)]) -> &'a str {
    let id = body
        .split("terminator Return(")
        .nth(1)
        .and_then(|r| refs(r).next())
        .unwrap_or_else(|| panic!("no value returned: {body}"));
    insts
        .iter()
        .find(|(i, _)| *i == id)
        .map(|(_, t)| t.as_str())
        .unwrap_or_else(|| panic!("no v{id}: {body}"))
}

/// The extensions the terminators reach through operands, marked or not.
fn live_extends(body: &str, insts: &[(u32, String)]) -> Vec<bool> {
    let mut work: Vec<u32> = body
        .lines()
        .filter(|l| l.trim_start().starts_with("terminator"))
        .flat_map(refs)
        .collect();
    let mut seen = BTreeSet::new();
    while let Some(v) = work.pop() {
        if seen.insert(v)
            && let Some((_, t)) = insts.iter().find(|(i, _)| *i == v)
        {
            work.extend(refs(t));
        }
    }
    insts
        .iter()
        .filter(|(i, t)| seen.contains(i) && t.starts_with("Extend {"))
        .map(|(_, t)| t.ends_with(", nsw }"))
        .collect()
}

#[test]
fn signed_arithmetic_renormalization_is_marked_unless_wrapping() {
    for (name, src) in [
        ("add", "long add(int a, int b) { return a + b; }"),
        ("sub", "long sub(int a, int b) { return a - b; }"),
        ("mul", "long mul(int a, int b) { return a * b; }"),
        ("neg", "long neg(int a) { return -a; }"),
    ] {
        for wrapv in [false, true] {
            let (body, insts) = dump(src, name, wrapv);
            let ret = returned(&body, &insts);
            assert!(ret.starts_with("Extend {"), "{name}: {body}");
            assert_eq!(
                ret.ends_with(", nsw }"),
                !wrapv,
                "{name}, -fwrapv {wrapv}: {body}"
            );
        }
    }
}

/// A conversion is implementation-defined (C99 6.3.1.3p3) and gcc defines a
/// signed `<<` to wrap, so neither renormalization is marked.
#[test]
fn conversion_and_shift_renormalize_unmarked() {
    for (name, src) in [
        ("shl", "long shl(int a) { return a << 3; }"),
        ("conv", "long conv(long a) { return (int)a; }"),
    ] {
        let (body, insts) = dump(src, name, false);
        assert_eq!(live_extends(&body, &insts), [false], "{name}: {body}");
    }
}

/// An overflowing constant folds to the wrapped value.
#[test]
fn marked_constant_folds_by_wrapping() {
    let src = "long fold(void) { int b = 0x7fffffff; return b + 1; }";
    let (body, insts) = dump(src, "fold", false);
    assert_eq!(returned(&body, &insts), "Imm(-2147483648)", "{body}");
}

#[test]
fn inlined_renormalization_keeps_the_mark() {
    let src = "static int add(int a, int b) { return a + b; }\n\
               long f(int a, int b) { return add(a, b); }";
    let (body, insts) = dump(src, "f", false);
    assert!(!insts.iter().any(|(_, t)| t.starts_with("Call")), "{body}");
    assert!(returned(&body, &insts).ends_with(", nsw }"), "{body}");
}

#[test]
fn unrolled_renormalizations_keep_the_mark() {
    let src = "long g(int *p) {\n\
               long s = 0;\n\
               for (int i = 0; i < 4; i++) s += (long)(p[i] * 3);\n\
               return s;\n\
               }";
    let (body, insts) = dump(src, "g", false);
    assert!(!body.contains("Phi"), "the loop stays: {body}");
    assert_eq!(live_extends(&body, &insts), [true; 4], "{body}");
}

/// One extension remains of two, marked only when both copies were: in one
/// block the builder merges them, across a dominating block `cse` does.
#[test]
fn merged_copies_keep_the_conjunction_of_the_marks() {
    let tail = "; return x; }";
    for (head, marked) in [
        ("long x = a + b; if (c) x += (long)(a + b) << 1", true),
        (
            "long x = a + b; if (c) x += (long)(int)((long)a + b) << 1",
            false,
        ),
        (
            "long x = (int)((long)a + b); if (c) x += (long)(a + b) << 1",
            false,
        ),
        ("long x = a + b; x += (long)(int)((long)a + b) << 1", false),
    ] {
        let src = alloc::format!("long h(int a, int b, int c) {{ {head}{tail}");
        let (body, insts) = dump(&src, "h", false);
        assert_eq!(live_extends(&body, &insts), [marked], "{head}: {body}");
    }
}

/// `name`'s x86-64 code at `-O`, with or without `-fwrapv`.
fn x64_code(src: &str, name: &str, wrapv: bool) -> Vec<super::perf_codegen::X64Insn> {
    use crate::{Compiler, NativeOptions, OutputKind, emit_native_with_options};
    let program = Compiler::with_options(
        String::from(src),
        Target::LinuxX64,
        CompileOptions::default()
            .with_no_entry_point(true)
            .with_optimize(true)
            .with_wrapv(wrapv),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..NativeOptions::new().with_optimize()
    };
    let object =
        crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(usize::MAX, usize::MAX, || {
            emit_native_with_options(&program, Target::LinuxX64, opts)
        })
        .expect("emit");
    super::perf_codegen::x64_insns(&super::codegen::function_bytes(&object, name))
}

/// Scans and strides of an `int` counter hold no register `movslq` in the
/// loop, and under `-fwrapv` one.
#[test]
fn induction_steps_hold_no_extension_unless_wrapping() {
    const SRCS: [&str; 5] = [
        "int f(const int *a, int p) { int i = 0; while (a[i] < p) i++; return i; }",
        "int f(const int *a, int p, int j) { while (a[j] > p) j--; return j; }",
        "long f(const int *a, int n) { long s = 0; for (int i = 0; i < n; i += 2) s += a[i]; return s; }",
        "long f(const int *a, int n) { long s = 0;\n\
         for (int i = 0, j = 0; i < n; i++, j += i) s += a[j]; return s; }",
        "long f(const unsigned char *c, int n) { long s = 0; int pc = 0;\n\
         while (pc < n) { s += c[pc++]; s -= c[pc++]; } return s; }",
    ];
    for src in SRCS {
        for wrapv in [false, true] {
            let insns = x64_code(src, "f", wrapv);
            let extends = super::perf_codegen::x64_in_loop(
                &insns,
                super::perf_codegen::X64Insn::is_movsxd_rr,
            );
            assert_eq!(extends, wrapv, "-fwrapv {wrapv}: `{src}`: {insns:x?}");
        }
    }
}

/// A `long` return of an `int` accumulator keeps its extension, stepped
/// like an induction variable (`s += i`, `s += k`) or not.
#[test]
fn accumulator_read_at_full_width_keeps_its_extension() {
    for src in [
        "long g(int n) { int s = 0; for (int i = 0; i < n; i++) s += i; return s; }",
        "long g(int n, int k) { int s = 0; for (int i = 0; i < n; i++) s += k; return s; }",
        "long g(const int *a, int n) { int s = 0;\n\
         for (int i = 0; i < n; i++) s += a[i]; return s; }",
    ] {
        let (body, insts) = dump(src, "g", false);
        assert!(
            returned(&body, &insts).starts_with("Extend {"),
            "{src}: {body}"
        );
    }
    let src = "long g(const unsigned char *c, int n, int m) { int h = 7;\n\
               for (int i = 0; i < n; i++) h = h * 31 + c[i]; return h % m; }";
    let (body, insts) = dump(src, "g", false);
    assert!(!live_extends(&body, &insts).is_empty(), "{src}: {body}");
}

/// Past `INT_MAX` such a reader sees the sum wrapped to `int`, at `-O` as
/// unoptimized.
#[cfg(any(
    all(
        target_os = "linux",
        any(target_arch = "aarch64", target_arch = "x86_64")
    ),
    all(target_os = "macos", target_arch = "aarch64"),
))]
#[test]
fn accumulator_past_int_max_reads_back_wrapped() {
    let src = "__attribute__((noinline)) long sum_iv(int n) {\n\
               int s = 0; for (int i = 0; i < n; i++) s += i; return s; }\n\
               __attribute__((noinline)) long sum_k(int n, int k) {\n\
               int s = 0; for (int i = 0; i < n; i++) s += k; return s; }\n\
               int main(void) { volatile int n = 100000, k = 30000;\n\
               return (sum_iv(n) == 704982704L) + 2 * (sum_k(n, k) == -1294967296L); }";
    for (optimize, level) in [
        (false, crate::NativeOptions::new()),
        (true, crate::NativeOptions::new().with_optimize()),
    ] {
        let program = crate::Compiler::with_options(
            super::with_prelude(src),
            Target::default_target(),
            CompileOptions::default(),
        )
        .compile()
        .expect("compile");
        let code = crate::jit_run_with_options(&program, &[], level, &mut |_| {}).expect("jit");
        assert_eq!(code, 3, "optimize {optimize}: exit {code}");
    }
}

/// Under `-fwrapv` every overflowing check wraps, unoptimized and at `-O`.
#[cfg(any(
    all(
        target_os = "linux",
        any(target_arch = "aarch64", target_arch = "x86_64")
    ),
    all(target_os = "macos", target_arch = "aarch64"),
))]
#[test]
fn wrapped_results_under_wrapv() {
    let src = super::with_prelude(&super::load_fixture("wrap_signed.c"));
    for level in [
        crate::NativeOptions::new(),
        crate::NativeOptions::new().with_optimize(),
    ] {
        let program = crate::Compiler::with_options(
            src.clone(),
            Target::default_target(),
            CompileOptions::default().with_wrapv(true),
        )
        .compile()
        .expect("compile");
        let code = crate::jit_run_with_options(&program, &[], level, &mut |_| {}).expect("jit");
        assert_eq!(code, 0, "wrap_signed.c exits {code}");
    }
}
