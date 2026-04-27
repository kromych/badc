//! Register-pool analyzer for the native lowering pass.
//!
//! The c4 bytecode is stack-shaped: every binary operator's left
//! operand is materialised by an `Op::Psh` and consumed implicitly
//! by the operator. Lowered straight, that becomes a `str/ldr`
//! pair around every `+`, `-`, `<`, etc., even though the c4
//! compiler emits expressions that rarely nest more than a handful
//! deep. Most of those pushes can live in a callee-saved register
//! instead -- which is what `--native-optimize` enables.
//!
//! This module is the analysis half. Given a [`Program::text`] and
//! a per-arch register-pool size, it returns a [`RegStackPlan`]
//! that the per-arch lowering consults at each `Op::Ent` /
//! `Op::Psh` / pop-shaped op:
//!
//! * Each `Op::Psh` is classified `Pseudo { slot }` (matching pop
//!   is a binary op / `Si` / `Sc` -> goes to the register pool) or
//!   `Real` (matching pop is an `Adj N` -> stays on the real stack
//!   so the libc / user-call sees args at expected `bp + offset`).
//! * Each `Op::Ent` records the function's max pseudo-stack depth
//!   so the prologue knows how many `xN` slots to save.
//! * If a function's depth exceeds the pool size, we forcibly mark
//!   its plan `use_pool = false`. The lowering then treats every
//!   Psh in that function as Real (the existing real-stack
//!   behaviour) -- correct fallback rather than spilling.
//!
//! See `aarch64.rs` / `x86_64.rs` for the consumers.

// Most of this module's surface is used by the per-arch lowering
// passes once N4/N5 land. Keep the dead-code lint quiet while we
// build out the analyzer first.
#![allow(dead_code)]

use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use super::super::error::C4Error;
use super::super::op::Op;

/// Where a single `Op::Psh` lives at runtime.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum PushKind {
    /// Slot in the register pool (0..pool_size). The lowering maps
    /// slot N to a per-arch callee-saved register (e.g. x20 + N on
    /// aarch64, or one of rbx/r12/r14/r15 on x86_64).
    Pseudo { slot: u8 },
    /// The push lands on the real stack, exactly as in the no-options
    /// lowering. Used for call argument pushes (consumed by `Op::Adj`)
    /// and for any push in a function that overflows the pool.
    Real,
}

/// Per-function metadata produced by the analyzer. Indexed via
/// [`RegStackPlan::function_at`] keyed on the function's `Op::Ent`
/// PC.
#[derive(Debug, Clone, Copy)]
pub(crate) struct FunctionPlan {
    /// Bytecode PC of the function's `Op::Ent`. Stored mostly for
    /// debugging -- the lookup table is keyed on it already.
    pub ent_pc: usize,
    /// Maximum simultaneous register-eligible push depth in this
    /// function. `0` means "no register-pool pushes at all"; the
    /// prologue saves zero scratch regs.
    pub max_depth: u8,
    /// Whether the lowering should consult `push_kind` at all for
    /// this function. `false` means a depth overflow forced us to
    /// fall back to real-stack pushes everywhere -- treat every
    /// `Op::Psh` as Real regardless of its classification.
    pub use_pool: bool,
}

/// Output of the register-pool analyzer. Lookup-by-PC for both
/// `Op::Psh` classification and per-function entry metadata.
#[derive(Debug)]
pub(crate) struct RegStackPlan {
    /// PC -> classification. `None` for non-Psh PCs.
    push_kind: Vec<Option<PushKind>>,
    /// Per-function plan storage; lookup via `func_at_pc`.
    funcs: Vec<FunctionPlan>,
    /// PC -> index into `funcs` for `Op::Ent` PCs, else `None`.
    func_at_pc: Vec<Option<u32>>,
}

impl RegStackPlan {
    /// If `pc` is an `Op::Psh`, return its classification.
    pub fn push_kind(&self, pc: usize) -> Option<PushKind> {
        self.push_kind.get(pc).copied().flatten()
    }

    /// If `pc` is an `Op::Ent`, return its function plan.
    pub fn function_at(&self, pc: usize) -> Option<FunctionPlan> {
        self.func_at_pc
            .get(pc)
            .copied()
            .flatten()
            .map(|i| self.funcs[i as usize])
    }
}

/// Bytecode-op width: 2 for ops with an inline operand word, 1
/// otherwise. Mirrors the dispatch in `vm/mod.rs` and
/// `aarch64.rs::lower_op`.
fn op_width(op: Op) -> usize {
    use Op::*;
    match op {
        // PC + 1 word of operand.
        Lea | Imm | Jmp | Jsr | Jsri | Bz | Bnz | Ent | Adj | AddI | SubI | MulI | AndI | OrI
        | XorI | ShlI | ShrI | EqI | NeI | LtI | GtI | LeI | GeI | LdLocI | LdLocC => 2,
        _ => 1,
    }
}

/// Run the analyzer on `text`. `pool_size` caps register-pool
/// depth; functions that would push deeper get `use_pool = false`
/// and fall back to real-stack pushes.
pub(crate) fn analyze(text: &[i64], pool_size: u8) -> Result<RegStackPlan, C4Error> {
    // Pass 1: classify each Psh as Pseudo vs Real by walking forward
    // and matching pops. Slot indices come from pass 2.
    let mut push_kind: Vec<Option<PushKind>> = vec![None; text.len()];

    // Pending pushes at this point in the walk: PCs whose matching
    // consumer hasn't been seen yet. LIFO.
    let mut pending: Vec<usize> = Vec::new();

    let mut pc = 0usize;
    while pc < text.len() {
        let raw = text[pc];
        let op = Op::from_i64(raw)
            .ok_or_else(|| C4Error::Compile(format!("regalloc: bad opcode at pc {pc}: {raw}")))?;
        match op {
            Op::Ent if !pending.is_empty() => {
                // Function boundary -- c4 emits well-balanced
                // bodies, so a pending Psh here is a bug in the
                // producer.
                return Err(C4Error::Compile(format!(
                    "regalloc: {n} pending Psh(es) at function entry pc {pc}",
                    n = pending.len(),
                )));
            }
            Op::Ent => {}
            Op::Psh => {
                pending.push(pc);
            }
            Op::Adj => {
                let n = text[pc + 1] as usize;
                for _ in 0..n {
                    let psh_pc = pending.pop().ok_or_else(|| {
                        C4Error::Compile(format!("regalloc: Adj at pc {pc} pops past empty stack"))
                    })?;
                    push_kind[psh_pc] = Some(PushKind::Real);
                }
            }
            Op::Or
            | Op::Xor
            | Op::And
            | Op::Eq
            | Op::Ne
            | Op::Lt
            | Op::Gt
            | Op::Le
            | Op::Ge
            | Op::Shl
            | Op::Shr
            | Op::Add
            | Op::Sub
            | Op::Mul
            | Op::Div
            | Op::Mod
            | Op::Si
            | Op::Sc => {
                let psh_pc = pending.pop().ok_or_else(|| {
                    C4Error::Compile(format!("regalloc: pop op {op:?} at pc {pc} on empty stack"))
                })?;
                // Slot is filled in pass 2.
                push_kind[psh_pc] = Some(PushKind::Pseudo { slot: 0 });
            }
            _ => {} // no stack effect we care about
        }
        pc += op_width(op);
    }

    if !pending.is_empty() {
        return Err(C4Error::Compile(format!(
            "regalloc: {n} unconsumed Psh(es) at end of bytecode",
            n = pending.len(),
        )));
    }

    // Pass 2: walk again, this time assigning slot numbers to
    // Pseudo pushes and tracking per-function max_depth. Functions
    // whose depth exceeds `pool_size` get `use_pool = false`.
    let mut funcs: Vec<FunctionPlan> = Vec::new();
    let mut func_at_pc: Vec<Option<u32>> = vec![None; text.len()];
    let mut current_ent: Option<usize> = None;
    let mut pseudo_depth: u32 = 0;
    let mut max_pseudo: u32 = 0;

    let close_function = |funcs: &mut Vec<FunctionPlan>,
                          func_at_pc: &mut [Option<u32>],
                          ent_pc: usize,
                          max_depth: u32| {
        let saturated = max_depth.min(u8::MAX as u32) as u8;
        let use_pool = saturated <= pool_size;
        let idx = funcs.len() as u32;
        funcs.push(FunctionPlan {
            ent_pc,
            max_depth: saturated,
            use_pool,
        });
        func_at_pc[ent_pc] = Some(idx);
    };

    let mut pc = 0usize;
    while pc < text.len() {
        let op = Op::from_i64(text[pc]).expect("validated in pass 1");
        match op {
            Op::Ent => {
                if let Some(prev) = current_ent {
                    close_function(&mut funcs, &mut func_at_pc, prev, max_pseudo);
                }
                current_ent = Some(pc);
                pseudo_depth = 0;
                max_pseudo = 0;
            }
            Op::Psh => {
                if let Some(PushKind::Pseudo { .. }) = push_kind[pc] {
                    if pseudo_depth >= u8::MAX as u32 {
                        return Err(C4Error::Compile(
                            "regalloc: pseudo-stack depth overflowed u8".into(),
                        ));
                    }
                    push_kind[pc] = Some(PushKind::Pseudo {
                        slot: pseudo_depth as u8,
                    });
                    pseudo_depth += 1;
                    if pseudo_depth > max_pseudo {
                        max_pseudo = pseudo_depth;
                    }
                }
            }
            Op::Or
            | Op::Xor
            | Op::And
            | Op::Eq
            | Op::Ne
            | Op::Lt
            | Op::Gt
            | Op::Le
            | Op::Ge
            | Op::Shl
            | Op::Shr
            | Op::Add
            | Op::Sub
            | Op::Mul
            | Op::Div
            | Op::Mod
            | Op::Si
            | Op::Sc => {
                pseudo_depth -= 1;
            }
            _ => {}
        }
        pc += op_width(op);
    }
    if let Some(prev) = current_ent {
        close_function(&mut funcs, &mut func_at_pc, prev, max_pseudo);
    }

    Ok(RegStackPlan {
        push_kind,
        funcs,
        func_at_pc,
    })
}

#[cfg(test)]
mod tests {
    use super::*;

    /// Inline bytecode literal for tests. Avoids the cost of
    /// running the full compiler for each tiny pattern.
    fn build(text: Vec<i64>) -> Vec<i64> {
        text
    }

    fn op(o: Op) -> i64 {
        o as i64
    }

    #[test]
    fn binary_op_classifies_psh_as_pseudo() {
        // Ent 0; Imm 1; Psh; Imm 2; Add; Lev
        let text = build(vec![
            op(Op::Ent),
            0,
            op(Op::Imm),
            1,
            op(Op::Psh),
            op(Op::Imm),
            2,
            op(Op::Add),
            op(Op::Lev),
        ]);
        let plan = analyze(&text, 8).unwrap();
        assert_eq!(plan.push_kind(4), Some(PushKind::Pseudo { slot: 0 }));
        let f = plan.function_at(0).unwrap();
        assert_eq!(f.max_depth, 1);
        assert!(f.use_pool);
    }

    #[test]
    fn call_args_classify_psh_as_real() {
        // Ent 0; Imm 1; Psh; Imm 2; Psh; Jsr 99; Adj 2; Lev
        let text = build(vec![
            op(Op::Ent),
            0,
            op(Op::Imm),
            1,
            op(Op::Psh),
            op(Op::Imm),
            2,
            op(Op::Psh),
            op(Op::Jsr),
            99,
            op(Op::Adj),
            2,
            op(Op::Lev),
        ]);
        let plan = analyze(&text, 8).unwrap();
        assert_eq!(plan.push_kind(4), Some(PushKind::Real));
        assert_eq!(plan.push_kind(7), Some(PushKind::Real));
        let f = plan.function_at(0).unwrap();
        assert_eq!(f.max_depth, 0);
        assert!(f.use_pool);
    }

    #[test]
    fn mixed_pseudo_and_real_within_one_expr() {
        // a + foo(b)  -- Psh(a) consumed by Add (Pseudo);
        // Psh(b) consumed by Adj (Real)
        // Ent 0; Imm 10; Psh; Imm 20; Psh; Jsr 99; Adj 1; Add; Lev
        let text = build(vec![
            op(Op::Ent),
            0,
            op(Op::Imm),
            10,
            op(Op::Psh),
            op(Op::Imm),
            20,
            op(Op::Psh),
            op(Op::Jsr),
            99,
            op(Op::Adj),
            1,
            op(Op::Add),
            op(Op::Lev),
        ]);
        let plan = analyze(&text, 8).unwrap();
        // Outer Psh (the `a`) -- Pseudo at slot 0 (only Pseudo push live there).
        assert_eq!(plan.push_kind(4), Some(PushKind::Pseudo { slot: 0 }));
        // Inner Psh (the `b`, call arg) -- Real.
        assert_eq!(plan.push_kind(7), Some(PushKind::Real));
        let f = plan.function_at(0).unwrap();
        assert_eq!(f.max_depth, 1);
    }

    #[test]
    fn nested_binary_uses_separate_slots() {
        // (a + b) + c -- Psh(a+b's left), Psh(a)
        // Ent 0; Imm 1; Psh; Imm 2; Psh; Imm 3; Add; Add; Lev
        let text = build(vec![
            op(Op::Ent),
            0,
            op(Op::Imm),
            1,
            op(Op::Psh),
            op(Op::Imm),
            2,
            op(Op::Psh),
            op(Op::Imm),
            3,
            op(Op::Add),
            op(Op::Add),
            op(Op::Lev),
        ]);
        let plan = analyze(&text, 8).unwrap();
        assert_eq!(plan.push_kind(4), Some(PushKind::Pseudo { slot: 0 }));
        assert_eq!(plan.push_kind(7), Some(PushKind::Pseudo { slot: 1 }));
        let f = plan.function_at(0).unwrap();
        assert_eq!(f.max_depth, 2);
    }

    #[test]
    fn function_overflow_falls_back_to_real_stack() {
        // Stack 9 deep with pool_size=8 -> use_pool=false.
        let mut text = vec![op(Op::Ent), 0];
        for _ in 0..9 {
            text.push(op(Op::Imm));
            text.push(0);
            text.push(op(Op::Psh));
        }
        for _ in 0..9 {
            text.push(op(Op::Imm));
            text.push(0);
            text.push(op(Op::Add));
        }
        text.push(op(Op::Lev));

        let plan = analyze(&text, 8).unwrap();
        let f = plan.function_at(0).unwrap();
        assert_eq!(f.max_depth, 9);
        assert!(
            !f.use_pool,
            "depth 9 with pool_size=8 should disable the pool"
        );
    }

    /// Smoke test against a real compiled program. Catches any
    /// bytecode shape the synthetic tests above missed -- if the
    /// analyzer's stack-balance walk ever desyncs from what the
    /// compiler emits, this is the cheapest place to notice.
    #[test]
    fn analyzer_runs_clean_on_quicksort_fixture() {
        use crate::Compiler;
        let path =
            std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("fixtures/c/quicksort.c");
        let src = std::fs::read_to_string(&path).expect("read quicksort.c");
        let program = Compiler::new(src).compile().expect("compile");
        let plan = analyze(&program.text, 8).expect("analyze");
        // Shouldn't throw, and should classify at least some pushes
        // as Pseudo (binary ops in the body).
        let any_pseudo = (0..program.text.len())
            .any(|pc| matches!(plan.push_kind(pc), Some(PushKind::Pseudo { .. })));
        assert!(any_pseudo, "quicksort should produce some Pseudo pushes");
    }

    /// Same idea against c4.c -- the most complex program in the
    /// fixture set. Catches anything that might break only on
    /// large bodies / many functions.
    #[test]
    fn analyzer_runs_clean_on_c4_self_host() {
        use crate::Compiler;
        let path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("fixtures/c/c4.c");
        let src = std::fs::read_to_string(&path).expect("read c4.c");
        let program = Compiler::new(src).compile().expect("compile");
        let plan = analyze(&program.text, 8).expect("analyze");
        // c4.c is literally "C in four functions" -- it actually
        // has 4. The assertion just protects against the analyzer
        // dropping function entries.
        let mut funcs = Vec::new();
        for pc in 0..program.text.len() {
            if let Some(f) = plan.function_at(pc) {
                funcs.push(f);
            }
        }
        assert!(
            funcs.len() >= 4,
            "c4.c should have >= 4 functions; got {}",
            funcs.len()
        );
        // Validate that pool=8 is enough for the c4 self-host's
        // expression nesting -- if any function's max_depth exceeds
        // 8 we'd silently fall back to real-stack and lose the win.
        let max = funcs.iter().map(|f| f.max_depth).max().unwrap_or(0);
        assert!(
            max <= 8,
            "c4.c hit pseudo-stack depth {max}; pool_size 8 not enough"
        );
    }

    #[test]
    fn multiple_functions_have_independent_max_depth() {
        // Function 1: depth 1. Function 2: depth 2.
        let text = build(vec![
            // Function 1 at pc 0:
            op(Op::Ent),
            0,
            op(Op::Imm),
            1,
            op(Op::Psh),
            op(Op::Imm),
            2,
            op(Op::Add),
            op(Op::Lev),
            // Function 2 at pc 9:
            op(Op::Ent),
            0,
            op(Op::Imm),
            1,
            op(Op::Psh),
            op(Op::Imm),
            2,
            op(Op::Psh),
            op(Op::Imm),
            3,
            op(Op::Add),
            op(Op::Add),
            op(Op::Lev),
        ]);
        let plan = analyze(&text, 8).unwrap();
        let f1 = plan.function_at(0).unwrap();
        let f2 = plan.function_at(9).unwrap();
        assert_eq!(f1.max_depth, 1);
        assert_eq!(f2.max_depth, 2);
    }
}
