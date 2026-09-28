//! AArch64 conditional branches whose target lies past their field's reach.
//!
//! `B.cond` / `CBZ` / `CBNZ` carry a 19-bit word displacement (+-1 MiB). A
//! function body longer than that is made here with an inline-asm hole: a
//! `b` over a `.space`, which costs the assembler nothing to emit.

use super::codegen::function_words;
use super::perf_codegen::a64_branch;
use crate::Target;

/// One MiB of text the surrounding code branches over.
const HOLE: &str = "__asm__ volatile(\"b 1f\\n.space 0x100000\\n1:\");";

/// Largest byte displacement a 19-bit word field reaches forward.
const MAX_FWD: i64 = ((1 << 18) - 1) * 4;

fn try_object(src: &str, optimize: bool) -> Result<Vec<u8>, String> {
    use crate::{CompileOptions, Compiler, NativeOptions, OutputKind, emit_native_with_options};
    let target = Target::LinuxAarch64;
    let program = Compiler::with_options(
        src.to_string(),
        target,
        CompileOptions::default()
            .with_no_entry_point(true)
            .with_optimize(optimize),
    )
    .compile()
    .unwrap_or_else(|e| panic!("compile: {e}"));
    let base = if optimize {
        NativeOptions::new().with_optimize()
    } else {
        NativeOptions::new()
    };
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..base
    };
    emit_native_with_options(&program, target, opts).map_err(|e| e.to_string())
}

fn words(src: &str, name: &str, optimize: bool) -> Vec<u32> {
    let obj = try_object(src, optimize).unwrap_or_else(|e| panic!("emit `{name}`: {e}"));
    function_words(&obj, name)
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
enum CondForm {
    BCond,
    Cbz,
    Cbnz,
    Tbz,
    Tbnz,
}

fn cond_form(w: u32) -> Option<CondForm> {
    if w & 0xFF00_0010 == 0x5400_0000 {
        Some(CondForm::BCond)
    } else if w & 0x7F00_0000 == 0x3400_0000 {
        Some(CondForm::Cbz)
    } else if w & 0x7F00_0000 == 0x3500_0000 {
        Some(CondForm::Cbnz)
    } else if w & 0x7F00_0000 == 0x3600_0000 {
        Some(CondForm::Tbz)
    } else if w & 0x7F00_0000 == 0x3700_0000 {
        Some(CondForm::Tbnz)
    } else {
        None
    }
}

/// `(word index, form, displacement of the B in words)` of every
/// conditional branch that skips exactly the unconditional `B` after it,
/// where that `B` goes past a conditional field's reach. A nearer `B` behind
/// such a test is ordinary code: a fall-through arm placed elsewhere.
fn far_pairs(ws: &[u32]) -> Vec<(usize, CondForm, i64)> {
    let mut out = Vec::new();
    for (i, &w) in ws.iter().enumerate() {
        let (Some(form), Some((t, false))) = (cond_form(w), a64_branch(w, i)) else {
            continue;
        };
        if t != i as i64 + 2 {
            continue;
        }
        if let Some(&next) = ws.get(i + 1)
            && let Some((bt, true)) = a64_branch(next, i + 1)
            && (bt - (i as i64 + 1)).abs() >= 1 << 18
        {
            out.push((i, form, bt - (i as i64 + 1)));
        }
    }
    out
}

/// Every conditional branch of `ws` lands inside the function.
fn conditional_branches_land_inside(ws: &[u32]) -> bool {
    ws.iter().enumerate().all(|(i, &w)| {
        if cond_form(w).is_none() {
            return true;
        }
        let Some((t, _)) = a64_branch(w, i) else {
            return true;
        };
        t >= 0 && (t as usize) < ws.len()
    })
}

/// The five loop and `if` shapes: each holds the hole between a conditional
/// branch and its target.
fn far_sources() -> [(&'static str, String, bool); 5] {
    [
        (
            "fwd_gt",
            format!(
                "int fwd_gt(int n) {{ int s = 0; while (n-- > 0) {{ s += 3; {HOLE} }} return s; }}"
            ),
            true,
        ),
        (
            "fwd_zero",
            format!(
                "int fwd_zero(int n) {{ int s = 0; while (n) {{ s += 5; n--; {HOLE} }} return s; }}"
            ),
            true,
        ),
        (
            "fwd_if",
            format!("int fwd_if(int n) {{ int s = 1; if (!n) {{ s = 13; {HOLE} }} return s; }}"),
            true,
        ),
        (
            "back_gt",
            format!(
                "int back_gt(int n) {{ int s = 0; do {{ s += 7; {HOLE} }} while (--n > 0); return s; }}"
            ),
            false,
        ),
        (
            "back_nonzero",
            format!(
                "int back_nonzero(int n) {{ int s = 0; do {{ s += 11; n--; {HOLE} }} while (n); return s; }}"
            ),
            false,
        ),
    ]
}

/// A conditional branch over the hole is the inverted test over a `B`, in
/// both directions and for each of the three forms. At `-O` the layout
/// decides the direction (a rotated loop tests at its bottom), so the
/// direction is checked at `-O0` only.
#[test]
fn far_conditional_branch_is_the_inverted_test_over_b() {
    let mut forms = alloc::collections::BTreeSet::new();
    for optimize in [false, true] {
        for (name, src, forward) in far_sources() {
            let ws = words(&src, name, optimize);
            assert!(
                conditional_branches_land_inside(&ws),
                "{name} (-O {optimize}): a conditional branch leaves the function"
            );
            let far = far_pairs(&ws);
            assert!(
                far.iter().any(|&(_, _, d)| optimize || (d > 0) == forward),
                "{name} (-O {optimize}): no far pair in the expected direction: {far:?}"
            );
            forms.extend(far.iter().map(|&(_, f, _)| f));
        }
    }
    assert_eq!(
        forms.into_iter().collect::<Vec<_>>(),
        [CondForm::BCond, CondForm::Cbz, CondForm::Cbnz],
        "the far pairs do not cover every conditional form"
    );
}

/// At `-O` the test of a return taken ahead of the frame branches over the
/// body to that return, the function's last instruction here; with the hole
/// in the body it is the inverted test over a `B`.
#[test]
fn far_early_return_is_the_inverted_test_over_b() {
    let src = format!(
        "long g(long);\nlong far_early(long n) {{ if (n < 2) return n; {HOLE} return g(n) + 1; }}"
    );
    let ws = words(&src, "far_early", true);
    assert!(conditional_branches_land_inside(&ws));
    let test = ws
        .iter()
        .position(|&w| cond_form(w).is_some())
        .expect("the test");
    let far = far_pairs(&ws);
    let &(_, _, d) = far
        .iter()
        .find(|&&(i, _, _)| i == test)
        .unwrap_or_else(|| panic!("the test is not a far pair: {far:?}"));
    assert_eq!(
        test as i64 + 1 + d,
        ws.len() as i64 - 1,
        "`B` to the return"
    );
    assert_eq!(ws.last(), Some(&0xD65F_03C0), "`ret`");
}

/// `tbz` / `tbnz` carry a 14-bit word displacement (+-32 KiB). A bit test
/// over a hole past that is the inverted test over a `B`; over a short
/// one it stays one instruction. Either way it tests bit 2.
#[test]
fn far_bit_test_is_the_inverted_test_over_b() {
    let src = |space: u32| {
        format!(
            "int bit(long k) {{ int s = 1; if (k & 4) {{ s = 13; \
             __asm__ volatile(\"b 1f\\n.space {space:#x}\\n1:\"); }} return s; }}"
        )
    };
    let bit_tests = |ws: &[u32]| -> Vec<usize> {
        (0..ws.len())
            .filter(|&i| matches!(cond_form(ws[i]), Some(CondForm::Tbz | CondForm::Tbnz)))
            .collect()
    };
    let tested_bit = |w: u32| ((w >> 31) << 5) | ((w >> 19) & 31);
    for optimize in [false, true] {
        let ws = words(&src(0x100), "bit", optimize);
        let near = bit_tests(&ws);
        assert!(
            near.len() == 1 && tested_bit(ws[near[0]]) == 2,
            "-O {optimize}: no single test of bit 2: {ws:08x?}"
        );
        let ws = words(&src(0x10000), "bit", optimize);
        assert!(conditional_branches_land_inside(&ws), "-O {optimize}");
        let far = bit_tests(&ws).into_iter().any(|i| {
            a64_branch(ws[i], i) == Some((i as i64 + 2, false))
                && a64_branch(ws[i + 1], i + 1)
                    .is_some_and(|(t, uncond)| uncond && (t - i as i64 - 1).abs() >= 1 << 13)
                && tested_bit(ws[i]) == 2
        });
        assert!(far, "-O {optimize}: no bit test over a far B: {ws:08x?}");
    }
}

/// `for` at `-O0` lays its blocks out as header, step, body, exit, then the
/// body's `if` arm and the statement after it: the `if`'s branch sits inside
/// the span of the header's exit branch and targets a block past it. With the hole in the arm the
/// `if`'s branch is far on its own; its second instruction then lengthens
/// the header's span. `pad` sizes the header's span.
fn cascade_src(name: &str, pad: i64) -> String {
    format!(
        "int {name}(int n, int c) {{\n\
         int s = 0;\n\
         for (int i = 0; i < n; i++) {{\n\
         __asm__ volatile(\"b 1f\\n.space {pad}\\n1:\");\n\
         if (c) {{ s += 2; {HOLE} }}\n\
         s += 1;\n\
         }}\n\
         return s;\n}}\n"
    )
}

/// Lengthening one branch can put another out of reach, and only the pass
/// after it sees that. The header's branch is sized to reach exactly the
/// last displacement its field encodes while the `if`'s branch is short.
#[test]
fn growth_that_puts_another_branch_out_of_reach_is_followed() {
    const PROBE_PAD: i64 = 0x40;
    let ws = words(&cascade_src("casc", PROBE_PAD), "casc", false);
    let (at, to) = ws
        .iter()
        .enumerate()
        .find_map(|(i, &w)| {
            cond_form(w)
                .and_then(|_| a64_branch(w, i))
                .map(|(t, _)| (i as i64, t))
        })
        .expect("the header's exit branch");
    let inner = far_pairs(&ws);
    let &[(inner_at, _, inner_d)] = inner.as_slice() else {
        panic!("one far pair expected in the probe: {inner:?}");
    };
    let (inner_at, inner_to) = (inner_at as i64, inner_at as i64 + 1 + inner_d);
    assert!(
        at < inner_at && inner_at < to && to < inner_to,
        "the spans no longer overlap: header {at}->{to}, if {inner_at}->{inner_to}"
    );
    // The probe's span holds the `if`'s second instruction; the first pass
    // measures the span without it.
    let span_without_pad = (to - at) * 4 - 4 - PROBE_PAD;
    let pad = MAX_FWD - span_without_pad;

    let ws = words(&cascade_src("casc", pad), "casc", false);
    let far = far_pairs(&ws);
    assert!(
        far.iter().any(|&(i, _, _)| i as i64 == at) && far.len() == 2,
        "the header's branch did not follow the `if`'s growth: {far:?}"
    );
    assert!(conditional_branches_land_inside(&ws));

    // Four bytes less and the header's branch still reaches once the `if`'s
    // has grown: it stays short, at the last displacement of the field.
    let ws = words(&cascade_src("casc", pad - 4), "casc", false);
    assert_eq!(far_pairs(&ws).len(), 1, "only the `if`'s branch is far");
    assert_eq!(
        a64_branch(ws[at as usize], at as usize),
        Some((at + MAX_FWD / 4, false))
    );
}

/// A template branch with no operand frame names its label's block and
/// keeps the reach of the instruction the template wrote: `cbnz` fails as
/// it does under an assembler, `b` reaches.
#[test]
fn template_branch_keeps_its_own_reach() {
    let src = |insn: &str| {
        format!(
            "int far_goto(int v) {{\n\
             int s = 1;\n\
             __asm__ goto(\"{insn} %l[taken]\" : : : : taken);\n\
             s += 100;\n\
             {HOLE}\n\
             taken:\n\
             return s;\n}}\n"
        )
    };
    for optimize in [false, true] {
        let err = try_object(&src("cbnz x0,"), optimize).expect_err("cbnz over 1 MiB");
        assert!(
            err.contains("aarch64 inline asm: branch target out of range"),
            "{err}"
        );
        try_object(&src("b"), optimize).unwrap_or_else(|e| panic!("b over 1 MiB: {e}"));
    }
}

/// A template branch in a function that is emitted again lands on its
/// label. The `if` ahead of it is far, so the second emission places the
/// template four bytes later; the label's block opens with a `b` over a
/// page, which no other instruction of the function is.
#[test]
fn template_branch_follows_the_emitted_layout() {
    let src = format!(
        "int near_goto(int n) {{\n\
         int s = 0;\n\
         if (!n) {{ s = 13; {HOLE} }}\n\
         __asm__ goto(\"cbnz x0, %l[taken]\" : : : : taken);\n\
         s += 100;\n\
         taken:\n\
         __asm__ volatile(\"b 1f\\n.space 0x1000\\n1:\");\n\
         return s;\n}}\n"
    );
    let ws = words(&src, "near_goto", false);
    assert!(!far_pairs(&ws).is_empty(), "the `if`'s branch is far");
    let opens_label = |t: i64| {
        ws.get(t as usize)
            .is_some_and(|&tw| a64_branch(tw, t as usize) == Some((t + 0x1000 / 4 + 1, true)))
    };
    let lands = ws.iter().enumerate().any(|(i, &w)| {
        cond_form(w) == Some(CondForm::Cbnz)
            && a64_branch(w, i).is_some_and(|(t, _)| opens_label(t))
    });
    assert!(lands, "the template's cbnz does not land on its label");
}

/// The reproducer's shape: a loop body of plain statements that exceeds
/// the reach at `-O0`.
#[test]
fn generated_loop_body_over_the_reach_compiles() {
    use core::fmt::Write;
    let mut src = String::from("int big(int *a, int n) {\n  int s = 0;\n  while (n-- > 0) {\n");
    for k in 0..20_000 {
        writeln!(src, "    s += a[{}] ^ {k};", k % 64).unwrap();
    }
    src.push_str("  }\n  return s;\n}\n");
    let ws = words(&src, "big", false);
    assert!(ws.len() * 4 > 1 << 20, "the body is {} bytes", ws.len() * 4);
    assert!(
        far_pairs(&ws).iter().any(|&(_, _, d)| d >= 1 << 18),
        "the loop's exit branch is not the far form"
    );
    assert!(conditional_branches_land_inside(&ws));
}

/// A function emitted more than once leaves one copy of its rows behind:
/// the line rows and the data runs of the text stream stay ascending.
#[test]
fn reemission_leaves_no_rows_of_the_discarded_pass() {
    use crate::c5::codegen::{LowerMode, ResolvedImports, aarch64};
    use crate::{CompileOptions, Compiler, NativeOptions};
    let (_, src, _) = far_sources().into_iter().next().unwrap();
    let src = format!("{src}\nint after(int x) {{ return x + 1; }}\n");
    let target = Target::LinuxAarch64;
    let program = Compiler::with_options(
        src,
        target,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile");
    let imports = ResolvedImports::resolve(&program).expect("imports");
    let build = aarch64::lower(
        &program,
        target,
        NativeOptions::new(),
        &imports,
        None,
        LowerMode::Full,
    )
    .expect("lower");
    assert!(
        build.ssa_line_rows.windows(2).all(|w| w[0].0 <= w[1].0),
        "line rows: {:?}",
        build.ssa_line_rows
    );
    assert!(
        build
            .text_data_ranges
            .windows(2)
            .all(|w| w[0].0 + w[0].1 <= w[1].0),
        "data runs: {:?}",
        build.text_data_ranges
    );
    let holes: usize = build.text_data_ranges.iter().map(|r| r.1).sum();
    assert_eq!(holes, 1 << 20, "one hole in the stream");
}

/// The far forms run: each function iterates or branches across its hole.
#[cfg(all(target_arch = "aarch64", any(target_os = "linux", target_os = "macos")))]
#[test]
fn far_branches_run_under_the_jit() {
    use crate::{Compiler, NativeOptions, jit_run_with_options};
    let mut src = String::new();
    for (_, f, _) in far_sources() {
        src.push_str(&f);
        src.push('\n');
    }
    // Header spans on both sides of the reach, whatever the host's frame
    // code adds to them.
    let pads = [-4, 0, 4].map(|d| MAX_FWD - 40 + d);
    for (k, pad) in pads.iter().enumerate() {
        src.push_str(&cascade_src(&format!("casc{k}"), *pad));
    }
    src.push_str(
        "int main(void) {\n\
         if (fwd_gt(4) != 12 || fwd_gt(0) != 0) return 1;\n\
         if (fwd_zero(3) != 15 || fwd_zero(0) != 0) return 2;\n\
         if (fwd_if(0) != 13 || fwd_if(9) != 1) return 3;\n\
         if (back_gt(3) != 21 || back_gt(1) != 7) return 4;\n\
         if (back_nonzero(2) != 22) return 5;\n",
    );
    for k in 0..pads.len() {
        src.push_str(&format!(
            "if (casc{k}(3, 1) != 9 || casc{k}(2, 0) != 2 || casc{k}(0, 1) != 0) return 6;\n"
        ));
    }
    src.push_str("return 42;\n}\n");
    for optimize in [false, true] {
        let program = Compiler::new(super::with_prelude(&src))
            .compile()
            .expect("compile");
        let opts = if optimize {
            NativeOptions::new().with_optimize()
        } else {
            NativeOptions::new()
        };
        let rc = jit_run_with_options(&program, &[], opts, &mut |_| {}).expect("jit");
        assert_eq!(rc, 42, "-O {optimize}");
    }
}
