//! Register-pool analyzer for the native lowering pass.
//!
//! The c4 bytecode is stack-shaped: every binary operator's left
//! operand is materialised by an `Op::Psh` and consumed implicitly
//! by the operator. Lowered straight, that becomes a `str/ldr`
//! pair around every `+`, `-`, `<`, etc., even though the c4
//! compiler emits expressions that rarely nest more than a handful
//! deep. Most of those pushes can live in a register instead --
//! which is what `--optimize` (via [`NativeOptions::optimize`])
//! enables.
//!
//! This module is the analysis half. Given a [`Program::text`] and
//! a per-arch register-pool size, it returns a [`RegStackPlan`]
//! that the per-arch lowering consults at each `Op::Ent` /
//! `Op::Psh` / pop-shaped op:
//!
//! * Each `Op::Psh` is classified `Pseudo { slot, bank }` (matching
//!   pop is a binary op / `Si` / `Sc` -> goes to the register pool)
//!   or `Real` (matching pop is an `Adj N` -> stays on the real
//!   stack so the libc / user-call sees args at expected
//!   `bp + offset`).
//! * Each `Op::Ent` records the function's per-bank pool depth so
//!   the prologue knows how many `xN` slots to save.
//! * If a function's depth exceeds the pool size, we forcibly mark
//!   its plan `use_pool = false`. The lowering then treats every
//!   Psh in that function as Real (the existing real-stack
//!   behaviour) -- correct fallback rather than spilling.
//!
//! ## Pool banks
//!
//! The pool is split across two register banks so the prologue
//! cost lines up with how long each value lives. The callee-saved
//! bank (e.g. x20..x27 on aarch64) is for slots that are live
//! across at least one call op; the prologue saves them once and
//! the epilogue restores them, so a `bl` in between is fine. The
//! caller-saved bank (e.g. x9..x15 on aarch64) is for short-lived
//! slots whose `Psh` and matching pop straddle no call op -- since
//! nothing between them can clobber the register, we don't need
//! to save anything in the prologue at all.
//!
//! The classification is a per-`Psh` decision in pass 1, and pass 2
//! only has to assign a slot index within the chosen bank. See
//! `aarch64.rs` / `x86_64.rs` for the consumers.

// Most of this module's surface is used by the per-arch lowering
// passes once N4/N5 land. Keep the dead-code lint quiet while we
// build out the analyzer first.
#![allow(dead_code)]

use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use super::super::error::C4Error;
use super::super::op::Op;

/// Which bank a [`PushKind::Pseudo`] slot lives in.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum PoolBank {
    /// Callee-saved register (e.g. x20..x27 on aarch64). Saved
    /// once in the prologue, restored in the epilogue. Used when
    /// the slot is live across at least one call op -- a
    /// caller-saved register would have to be spilled at every
    /// such crossing, which is more expensive than the single
    /// prologue/epilogue pair.
    Callee,
    /// Caller-saved register (e.g. x9..x15 on aarch64). Free at
    /// function entry: no prologue / epilogue cost. Used when the
    /// slot's `Op::Psh` and its matching pop straddle no call op,
    /// so there's nothing for a `bl` / `blr` / libc thunk to
    /// trample.
    Caller,
}

/// Where a single `Op::Psh` lives at runtime.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum PushKind {
    /// Slot in the register pool. `bank` says whether it's the
    /// callee-saved or caller-saved bank; `slot` is the index
    /// within that bank. The lowering picks the matching arch
    /// register from the bank/slot pair.
    Pseudo { slot: u8, bank: PoolBank },
    /// The push lands on the real stack, exactly as in the no-options
    /// lowering. Used for call argument pushes (consumed by `Op::Adj`)
    /// and for any push in a function that overflows the pool.
    Real,
}

/// Pool-size budget for the analyzer.
#[derive(Debug, Clone, Copy)]
pub(crate) struct PoolSizes {
    /// Maximum simultaneous callee-saved bank slots. Slots are
    /// indexed 0..callee on the [`PoolBank::Callee`] bank.
    pub callee: u8,
    /// Maximum simultaneous caller-saved bank slots. `0` disables
    /// the caller bank entirely (every Pseudo push then routes
    /// through the callee bank); used by x86_64 today since its
    /// caller-saved registers (r10, r11) are already claimed by
    /// the lowering as scratch.
    pub caller: u8,
}

/// Per-function metadata produced by the analyzer. Indexed via
/// [`RegStackPlan::function_at`] keyed on the function's `Op::Ent`
/// PC.
#[derive(Debug, Clone, Copy)]
pub(crate) struct FunctionPlan {
    /// Bytecode PC of the function's `Op::Ent`. Stored mostly for
    /// debugging -- the lookup table is keyed on it already.
    pub ent_pc: usize,
    /// Maximum simultaneous callee-saved-bank slots used. The
    /// prologue saves exactly this many `xN` registers.
    pub callee_depth: u8,
    /// Maximum simultaneous caller-saved-bank slots used. The
    /// prologue saves zero of these (caller-saved means *the
    /// caller* is responsible for any save it wants -- and there's
    /// nothing to save here because they're allocated only when
    /// not live across any call).
    pub caller_depth: u8,
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
/// `aarch64.rs::lower_op`. Notably `Op::Jsri` is **1-word** -- the
/// indirect-call target lives in the VM accumulator, not in the
/// instruction stream; the lowering just peeks at the *next* op
/// for an Adj N to figure out arg count.
fn op_width(op: Op) -> usize {
    use Op::*;
    match op {
        // PC + 1 word of operand.
        Lea | Imm | Jmp | Jsr | Bz | Bnz | Ent | Adj | JsrExt | AddI | SubI | MulI | AndI | OrI
        | XorI | ShlI | ShrI | EqI | NeI | LtI | GtI | LeI | GeI | LdLocI | LdLocC => 2,
        _ => 1,
    }
}

/// True if `op` lowers to something that tramples caller-saved
/// registers -- direct call (`Jsr`), indirect call (`Jsri`), or
/// external library call (`JsrExt`, lowers to `bl` / `call`
/// through the GOT). The analyzer uses this to decide whether a
/// Pseudo push that's live across `op` must use the callee-saved
/// bank.
fn is_call_op(op: Op) -> bool {
    use Op::*;
    matches!(op, Jsr | Jsri | JsrExt)
}

/// Run the analyzer on `text`. `pool` caps callee-saved and
/// caller-saved bank depth; functions that would overflow either
/// get `use_pool = false` and fall back to real-stack pushes
/// everywhere.
pub(crate) fn analyze(text: &[i64], pool: PoolSizes) -> Result<RegStackPlan, C4Error> {
    // Pass 1: classify each Psh as Pseudo vs Real by walking forward
    // and matching pops. Bank choice and slot index come from pass 2.
    //
    // While walking, also track which Pseudo pushes are "live across
    // a call op" (Jsr / Jsri / libc thunk) -- those must land in the
    // callee-saved bank since the call would clobber a caller-saved
    // register. We mark each entry of `pending` with its
    // across-call flag, set when any call op is observed while it's
    // pending; the flag transfers to the matching Psh's classification
    // at pop time.
    let mut push_kind: Vec<Option<PushKind>> = vec![None; text.len()];
    let mut across_call: Vec<bool> = vec![false; text.len()];

    // Pending pushes: (psh_pc, across_call). LIFO.
    let mut pending: Vec<(usize, bool)> = Vec::new();

    let mut pc = 0usize;
    while pc < text.len() {
        let raw = text[pc];
        let op = Op::from_i64(raw)
            .ok_or_else(|| C4Error::Compile(format!("regalloc: bad opcode at pc {pc}: {raw}")))?;
        // Any call-shaped op observed while pushes are pending
        // taints them: they're live across a call. The taint sticks
        // even if subsequent pops happen before the eventual matching
        // pop, since the analyzer's job is to mark a *worst-case*
        // need for callee-save semantics.
        if is_call_op(op) {
            for entry in pending.iter_mut() {
                entry.1 = true;
            }
        }
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
                pending.push((pc, false));
            }
            Op::Adj => {
                let n = text[pc + 1] as usize;
                for _ in 0..n {
                    let (psh_pc, _) = pending.pop().ok_or_else(|| {
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
                let (psh_pc, ac) = pending.pop().ok_or_else(|| {
                    C4Error::Compile(format!("regalloc: pop op {op:?} at pc {pc} on empty stack"))
                })?;
                // Bank + slot are filled in pass 2; placeholder for now.
                push_kind[psh_pc] = Some(PushKind::Pseudo {
                    slot: 0,
                    bank: PoolBank::Callee,
                });
                across_call[psh_pc] = ac;
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

    // Pass 2: walk again, this time assigning bank + slot to each
    // Pseudo push and tracking per-function callee/caller depths.
    // Functions whose depth exceeds the pool size get
    // `use_pool = false`.
    //
    // Bank assignment policy:
    //   * across_call=true  -> Callee bank (must survive a call).
    //   * across_call=false -> Caller bank if there's room, else
    //                          Callee (graceful overflow).
    // If either bank's depth would exceed the matching pool size,
    // mark the function `use_pool = false` and let the lowering
    // route everything through the real stack -- correct fallback.
    let mut funcs: Vec<FunctionPlan> = Vec::new();
    let mut func_at_pc: Vec<Option<u32>> = vec![None; text.len()];
    let mut current_ent: Option<usize> = None;
    let mut callee_depth: u32 = 0;
    let mut caller_depth: u32 = 0;
    let mut max_callee: u32 = 0;
    let mut max_caller: u32 = 0;
    let mut overflow: bool = false;
    // Per-function pseudo-pop trail: each entry is the bank chosen
    // at push time, so the matching pop knows which counter to
    // decrement.
    let mut pseudo_trail: Vec<PoolBank> = Vec::new();

    let close_function = |funcs: &mut Vec<FunctionPlan>,
                          func_at_pc: &mut [Option<u32>],
                          ent_pc: usize,
                          max_callee: u32,
                          max_caller: u32,
                          overflow: bool| {
        let cs = max_callee.min(u8::MAX as u32) as u8;
        let cr = max_caller.min(u8::MAX as u32) as u8;
        let use_pool = !overflow && cs <= pool.callee && cr <= pool.caller;
        let idx = funcs.len() as u32;
        funcs.push(FunctionPlan {
            ent_pc,
            callee_depth: if use_pool { cs } else { 0 },
            caller_depth: if use_pool { cr } else { 0 },
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
                    close_function(
                        &mut funcs,
                        &mut func_at_pc,
                        prev,
                        max_callee,
                        max_caller,
                        overflow,
                    );
                }
                current_ent = Some(pc);
                callee_depth = 0;
                caller_depth = 0;
                max_callee = 0;
                max_caller = 0;
                overflow = false;
                pseudo_trail.clear();
            }
            Op::Psh => {
                if let Some(PushKind::Pseudo { .. }) = push_kind[pc] {
                    let prefer_caller = !across_call[pc] && pool.caller > 0;
                    let bank = if prefer_caller && caller_depth < pool.caller as u32 {
                        PoolBank::Caller
                    } else {
                        PoolBank::Callee
                    };
                    let slot_index = match bank {
                        PoolBank::Callee => callee_depth,
                        PoolBank::Caller => caller_depth,
                    };
                    if slot_index >= u8::MAX as u32 {
                        return Err(C4Error::Compile(
                            "regalloc: pseudo-stack depth overflowed u8".into(),
                        ));
                    }
                    push_kind[pc] = Some(PushKind::Pseudo {
                        slot: slot_index as u8,
                        bank,
                    });
                    match bank {
                        PoolBank::Callee => {
                            callee_depth += 1;
                            if callee_depth > max_callee {
                                max_callee = callee_depth;
                            }
                            if callee_depth > pool.callee as u32 {
                                overflow = true;
                            }
                        }
                        PoolBank::Caller => {
                            caller_depth += 1;
                            if caller_depth > max_caller {
                                max_caller = caller_depth;
                            }
                        }
                    }
                    pseudo_trail.push(bank);
                }
            }
            Op::Adj => {
                // Real-stack pops don't perturb pool counters.
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
                if let Some(bank) = pseudo_trail.pop() {
                    match bank {
                        PoolBank::Callee => callee_depth -= 1,
                        PoolBank::Caller => caller_depth -= 1,
                    }
                }
            }
            _ => {}
        }
        pc += op_width(op);
    }
    if let Some(prev) = current_ent {
        close_function(
            &mut funcs,
            &mut func_at_pc,
            prev,
            max_callee,
            max_caller,
            overflow,
        );
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

    /// Default-shape pool sizes for tests: 8 callee + 7 caller, the
    /// aarch64 layout. Tests that want to disable the caller bank
    /// (mirroring x86_64's policy) build their own [`PoolSizes`].
    const POOL: PoolSizes = PoolSizes {
        callee: 8,
        caller: 7,
    };

    /// Pool sizes with the caller bank turned off -- mirrors the
    /// pre-N6 behaviour where all Pseudo pushes went to the
    /// callee-saved bank.
    const CALLEE_ONLY: PoolSizes = PoolSizes {
        callee: 8,
        caller: 0,
    };

    #[test]
    fn binary_op_classifies_psh_as_pseudo() {
        // Ent 0; Imm 1; Psh; Imm 2; Add; Lev
        // No call between Psh and Add -> caller-bank slot 0.
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
        let plan = analyze(&text, POOL).unwrap();
        assert_eq!(
            plan.push_kind(4),
            Some(PushKind::Pseudo {
                slot: 0,
                bank: PoolBank::Caller,
            })
        );
        let f = plan.function_at(0).unwrap();
        assert_eq!(f.callee_depth, 0);
        assert_eq!(f.caller_depth, 1);
        assert!(f.use_pool);
    }

    #[test]
    fn callee_only_routes_pseudo_to_callee_bank() {
        // Same shape, but with caller=0 -> Pseudo lands in Callee.
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
        let plan = analyze(&text, CALLEE_ONLY).unwrap();
        assert_eq!(
            plan.push_kind(4),
            Some(PushKind::Pseudo {
                slot: 0,
                bank: PoolBank::Callee,
            })
        );
        let f = plan.function_at(0).unwrap();
        assert_eq!(f.callee_depth, 1);
        assert_eq!(f.caller_depth, 0);
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
        let plan = analyze(&text, POOL).unwrap();
        assert_eq!(plan.push_kind(4), Some(PushKind::Real));
        assert_eq!(plan.push_kind(7), Some(PushKind::Real));
        let f = plan.function_at(0).unwrap();
        assert_eq!(f.callee_depth, 0);
        assert_eq!(f.caller_depth, 0);
        assert!(f.use_pool);
    }

    #[test]
    fn pseudo_live_across_call_uses_callee_bank() {
        // a + foo(b): Psh(a), then Jsr touches caller-saved regs,
        // so a must end up in the Callee bank to survive the call.
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
        let plan = analyze(&text, POOL).unwrap();
        // Outer Psh (the `a`) -- Pseudo, callee bank because Jsr
        // is between Psh and Add.
        assert_eq!(
            plan.push_kind(4),
            Some(PushKind::Pseudo {
                slot: 0,
                bank: PoolBank::Callee,
            })
        );
        // Inner Psh (the `b`, call arg) -- Real.
        assert_eq!(plan.push_kind(7), Some(PushKind::Real));
        let f = plan.function_at(0).unwrap();
        assert_eq!(f.callee_depth, 1);
        assert_eq!(f.caller_depth, 0);
    }

    #[test]
    fn libc_op_taints_pending_pseudo() {
        // a + printf("hi"): Psh(a), then `JsrExt printf` is a
        // libc thunk (call-shaped), so a needs the callee bank.
        // Ent 0; Imm 10; Psh; Imm "hi"; Psh; JsrExt 0; Adj 1; Add; Lev
        let text = build(vec![
            op(Op::Ent),
            0,
            op(Op::Imm),
            10,
            op(Op::Psh),
            op(Op::Imm),
            0xDEAD,
            op(Op::Psh),
            op(Op::JsrExt),
            0,
            op(Op::Adj),
            1,
            op(Op::Add),
            op(Op::Lev),
        ]);
        let plan = analyze(&text, POOL).unwrap();
        assert_eq!(
            plan.push_kind(4),
            Some(PushKind::Pseudo {
                slot: 0,
                bank: PoolBank::Callee,
            })
        );
    }

    #[test]
    fn nested_binary_uses_separate_slots_in_caller_bank() {
        // (a + b) + c -- two Pseudo pushes alive simultaneously,
        // no call between them or their pops, so both ride in the
        // caller bank.
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
        let plan = analyze(&text, POOL).unwrap();
        assert_eq!(
            plan.push_kind(4),
            Some(PushKind::Pseudo {
                slot: 0,
                bank: PoolBank::Caller,
            })
        );
        assert_eq!(
            plan.push_kind(7),
            Some(PushKind::Pseudo {
                slot: 1,
                bank: PoolBank::Caller,
            })
        );
        let f = plan.function_at(0).unwrap();
        assert_eq!(f.callee_depth, 0);
        assert_eq!(f.caller_depth, 2);
    }

    #[test]
    fn caller_bank_overflow_spills_to_callee() {
        // Three concurrent within-expr pushes with caller_size=2:
        // first two go to the caller bank, the third spills onto
        // the callee bank.
        // Ent 0; Imm 1; Psh; Imm 2; Psh; Imm 3; Psh; Imm 4; Add; Add; Add; Lev
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
            op(Op::Psh),
            op(Op::Imm),
            4,
            op(Op::Add),
            op(Op::Add),
            op(Op::Add),
            op(Op::Lev),
        ]);
        let pool = PoolSizes {
            callee: 4,
            caller: 2,
        };
        let plan = analyze(&text, pool).unwrap();
        assert_eq!(
            plan.push_kind(4),
            Some(PushKind::Pseudo {
                slot: 0,
                bank: PoolBank::Caller,
            })
        );
        assert_eq!(
            plan.push_kind(7),
            Some(PushKind::Pseudo {
                slot: 1,
                bank: PoolBank::Caller,
            })
        );
        // Third push: caller bank full, falls back to callee.
        assert_eq!(
            plan.push_kind(10),
            Some(PushKind::Pseudo {
                slot: 0,
                bank: PoolBank::Callee,
            })
        );
        let f = plan.function_at(0).unwrap();
        assert_eq!(f.callee_depth, 1);
        assert_eq!(f.caller_depth, 2);
    }

    #[test]
    fn function_overflow_falls_back_to_real_stack() {
        // Stack 9 deep with callee=8 caller=0 -> use_pool=false.
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

        let plan = analyze(&text, CALLEE_ONLY).unwrap();
        let f = plan.function_at(0).unwrap();
        assert!(
            !f.use_pool,
            "depth 9 with callee=8 caller=0 should disable the pool"
        );
        assert_eq!(f.callee_depth, 0);
        assert_eq!(f.caller_depth, 0);
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
        let plan = analyze(&program.text, POOL).expect("analyze");
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
        let plan = analyze(&program.text, POOL).expect("analyze");
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
        // Validate that the combined pool depth fits -- if any
        // function would need more than what we offer, we'd fall
        // back to real-stack pushes.
        for f in &funcs {
            assert!(
                f.callee_depth <= POOL.callee,
                "c4.c hit callee_depth {} (limit {})",
                f.callee_depth,
                POOL.callee
            );
            assert!(
                f.caller_depth <= POOL.caller,
                "c4.c hit caller_depth {} (limit {})",
                f.caller_depth,
                POOL.caller
            );
        }
    }

    #[test]
    fn multiple_functions_have_independent_depths() {
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
        let plan = analyze(&text, POOL).unwrap();
        let f1 = plan.function_at(0).unwrap();
        let f2 = plan.function_at(9).unwrap();
        assert_eq!(f1.caller_depth, 1);
        assert_eq!(f2.caller_depth, 2);
    }
}
