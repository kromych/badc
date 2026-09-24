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
