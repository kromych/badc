//! Direct construction of [`FunctionSsa`] from a syntactic walk.
//!
//! Companion to [`super::ssa::lift_program`], which derives the same
//! SSA from c5 stack-machine bytecode. The lift exists because the
//! current parser emits bytecode; this builder exists so a future
//! parser can produce SSA without that intermediate.
//!
//! The shape is intentionally identical to what the lift produces:
//! same [`Inst`] enum, same [`Block`] layout, same [`Terminator`]
//! semantics. Anything constructed here is consumed by the existing
//! allocator and per-arch emit unchanged.
//!
//! Ergonomic API:
//!
//! ```text
//! let mut b = SsaBuilder::new(ent_pc, n_params, is_variadic);
//! let entry = b.entry_block();
//! let v_n = b.load_local(2, LoadKind::I32);
//! let v_test = b.binop_imm(BinOp::Lt, v_n, 2);
//! let then_b = b.new_block();
//! let else_b = b.new_block();
//! b.branch_zero(v_test, else_b, then_b);
//! b.switch_to(then_b);
//! b.return_(v_n);
//! ...
//! let func = b.finish();
//! ```
//!
//! Callers are responsible for the structural invariants the
//! downstream passes rely on: every block has exactly one
//! terminator; values referenced by an inst are defined earlier in
//! the same block or reach via the virtual stack (`VstackSpill` /
//! `VstackReload`); the entry block is block 0.

#![allow(dead_code)]

use alloc::vec::Vec;

use super::ssa::{
    BinOp, Block, BlockId, FpCastKind, FunctionSsa, Inst, LoadKind, NO_VALUE, StoreKind,
    Terminator, ValueId,
};

/// Builder over a [`FunctionSsa`]. Each method that defines a value
/// returns its [`ValueId`]; terminators close the current block.
pub(super) struct SsaBuilder {
    func: FunctionSsa,
    /// Block currently receiving inst pushes. `None` after a
    /// terminator closes the block until [`Self::switch_to`] picks
    /// another one.
    current: Option<BlockId>,
    /// Per-block start indices in `func.insts`. Index is `BlockId`
    /// as `usize`. Updated on [`Self::new_block`] and consumed by
    /// [`Self::finish`].
    block_starts: Vec<u32>,
    /// Per-block terminator. Mirrors [`Block::terminator`] until
    /// [`Self::finish`] folds it into the final block list.
    block_terminators: Vec<Option<Terminator>>,
    /// Per-block exit accumulator. Mirrors [`Block::exit_acc`].
    block_exit_accs: Vec<ValueId>,
    /// Last value defined in the current block. Used as the default
    /// `exit_acc` if the block's terminator doesn't specify one.
    last_def: ValueId,
}

impl SsaBuilder {
    /// Create a builder for a function with the given identity and
    /// initial entry block (block 0). The entry block is the
    /// builder's initial focus; the first push lands there.
    pub(super) fn new(ent_pc: usize, n_params: usize, is_variadic: bool) -> Self {
        let func = FunctionSsa {
            ent_pc,
            end_pc: ent_pc,
            locals: 0,
            n_params,
            is_variadic,
            insts: Vec::new(),
            blocks: Vec::new(),
            vstack_slots: 0,
        };
        let mut b = Self {
            func,
            current: None,
            block_starts: Vec::new(),
            block_terminators: Vec::new(),
            block_exit_accs: Vec::new(),
            last_def: NO_VALUE,
        };
        let entry = b.new_block();
        b.switch_to(entry);
        b
    }

    /// Record that the function reserves `n` natural-width local
    /// bytes (the value Op::Ent's operand would carry under the c5
    /// path). Consumed by the per-arch emit's frame layout.
    pub(super) fn set_locals(&mut self, n: i64) {
        self.func.locals = n;
    }

    /// Reserve a new basic block and return its id. The new block
    /// is not made current; the caller drives that via
    /// [`Self::switch_to`].
    pub(super) fn new_block(&mut self) -> BlockId {
        let id = self.block_starts.len() as BlockId;
        self.block_starts
            .push(self.func.insts.len() as u32);
        self.block_terminators.push(None);
        self.block_exit_accs.push(NO_VALUE);
        id
    }

    /// Make `block` the current insertion point. Subsequent pushes
    /// land in this block until a terminator closes it.
    pub(super) fn switch_to(&mut self, block: BlockId) {
        // Re-anchor the block's inst-start to the current end of
        // the inst list. This handles the natural construction
        // order where new_block reserves an id before the prior
        // block has finished emitting.
        let idx = block as usize;
        self.block_starts[idx] = self.func.insts.len() as u32;
        self.current = Some(block);
        self.last_def = NO_VALUE;
    }

    /// The implicit entry block (block 0). Always exists.
    pub(super) fn entry_block(&self) -> BlockId {
        0
    }

    fn push(&mut self, inst: Inst) -> ValueId {
        debug_assert!(
            self.current.is_some(),
            "SsaBuilder: push into a closed block (no current focus)",
        );
        let id = self.func.insts.len() as ValueId;
        self.func.insts.push(inst);
        self.last_def = id;
        id
    }

    /// `Inst::Imm`.
    pub(super) fn imm(&mut self, v: i64) -> ValueId {
        self.push(Inst::Imm(v))
    }

    /// `Inst::ImmData` (data-segment offset).
    pub(super) fn imm_data(&mut self, off: i64) -> ValueId {
        self.push(Inst::ImmData(off))
    }

    /// `Inst::ImmCode` (function-pointer literal).
    pub(super) fn imm_code(&mut self, target_pc: usize) -> ValueId {
        self.push(Inst::ImmCode(target_pc))
    }

    /// `Inst::LocalAddr`.
    pub(super) fn local_addr(&mut self, off: i64) -> ValueId {
        self.push(Inst::LocalAddr(off))
    }

    /// `Inst::TlsAddr`.
    pub(super) fn tls_addr(&mut self, off: i64) -> ValueId {
        self.push(Inst::TlsAddr(off))
    }

    /// `Inst::Load` through a precomputed address.
    pub(super) fn load(&mut self, addr: ValueId, kind: LoadKind) -> ValueId {
        self.push(Inst::Load { addr, kind })
    }

    /// `Inst::Store` through a precomputed address. Returns the
    /// stored value's id (matches c5 semantics: a `Op::Si` leaves
    /// the stored value in the accumulator).
    pub(super) fn store(&mut self, addr: ValueId, value: ValueId, kind: StoreKind) -> ValueId {
        self.push(Inst::Store { addr, value, kind })
    }

    /// `Inst::LoadLocal` -- fused [`Inst::LocalAddr`] + [`Inst::Load`].
    pub(super) fn load_local(&mut self, off: i64, kind: LoadKind) -> ValueId {
        self.push(Inst::LoadLocal { off, kind })
    }

    /// `Inst::StoreLocal` -- fused [`Inst::LocalAddr`] + [`Inst::Store`].
    pub(super) fn store_local(&mut self, off: i64, value: ValueId, kind: StoreKind) -> ValueId {
        self.push(Inst::StoreLocal { off, value, kind })
    }

    /// `Inst::Binop`.
    pub(super) fn binop(&mut self, op: BinOp, lhs: ValueId, rhs: ValueId) -> ValueId {
        self.push(Inst::Binop { op, lhs, rhs })
    }

    /// `Inst::BinopI`.
    pub(super) fn binop_imm(&mut self, op: BinOp, lhs: ValueId, rhs_imm: i64) -> ValueId {
        self.push(Inst::BinopI {
            op,
            lhs,
            rhs_imm,
        })
    }

    /// `Inst::Fneg`.
    pub(super) fn fneg(&mut self, v: ValueId) -> ValueId {
        self.push(Inst::Fneg(v))
    }

    /// `Inst::FpCast`.
    pub(super) fn fp_cast(&mut self, kind: FpCastKind, value: ValueId) -> ValueId {
        self.push(Inst::FpCast { kind, value })
    }

    /// `Inst::Call` -- direct user-function call.
    pub(super) fn call(&mut self, target_pc: usize, args: Vec<ValueId>) -> ValueId {
        self.push(Inst::Call { target_pc, args })
    }

    /// `Inst::CallIndirect` -- function-pointer call.
    pub(super) fn call_indirect(&mut self, target: ValueId, args: Vec<ValueId>) -> ValueId {
        self.push(Inst::CallIndirect { target, args })
    }

    /// `Inst::CallExt` -- libc / external call.
    pub(super) fn call_ext(
        &mut self,
        binding_idx: i64,
        args: Vec<ValueId>,
        fp_arg_mask: u32,
    ) -> ValueId {
        self.push(Inst::CallExt {
            binding_idx,
            args,
            fp_arg_mask,
        })
    }

    /// Close the current block with `Terminator::Jmp`.
    pub(super) fn jmp(&mut self, target: BlockId) {
        self.close(Terminator::Jmp(target), self.last_def);
    }

    /// Close the current block with `Terminator::Bz`. `cond` is the
    /// value tested; control transfers to `target` when zero, else
    /// falls through to `fall_through`.
    pub(super) fn branch_zero(
        &mut self,
        cond: ValueId,
        target: BlockId,
        fall_through: BlockId,
    ) {
        self.close(
            Terminator::Bz {
                cond,
                target,
                fall_through,
            },
            cond,
        );
    }

    /// Close the current block with `Terminator::Bnz`.
    pub(super) fn branch_nonzero(
        &mut self,
        cond: ValueId,
        target: BlockId,
        fall_through: BlockId,
    ) {
        self.close(
            Terminator::Bnz {
                cond,
                target,
                fall_through,
            },
            cond,
        );
    }

    /// Close the current block with `Terminator::Return`.
    pub(super) fn return_(&mut self, value: ValueId) {
        self.close(Terminator::Return(value), value);
    }

    fn close(&mut self, term: Terminator, exit_acc: ValueId) {
        let id = self
            .current
            .expect("SsaBuilder: close called with no active block");
        let idx = id as usize;
        debug_assert!(
            self.block_terminators[idx].is_none(),
            "SsaBuilder: block {idx} already terminated",
        );
        self.block_terminators[idx] = Some(term);
        self.block_exit_accs[idx] = exit_acc;
        self.current = None;
        self.last_def = NO_VALUE;
    }

    /// Finalise the builder and return the populated [`FunctionSsa`].
    /// Panics if any block was opened but not terminated.
    pub(super) fn finish(mut self) -> FunctionSsa {
        let n = self.block_starts.len();
        let mut blocks: Vec<Block> = Vec::with_capacity(n);
        for i in 0..n {
            let start = self.block_starts[i];
            let end = if i + 1 < n {
                self.block_starts[i + 1]
            } else {
                self.func.insts.len() as u32
            };
            let terminator = self.block_terminators[i].unwrap_or_else(|| {
                panic!("SsaBuilder: block {i} finished without a terminator")
            });
            blocks.push(Block {
                start_pc: 0,
                inst_range: start..end,
                terminator,
                exit_acc: self.block_exit_accs[i],
            });
        }
        self.func.blocks = blocks;
        self.func
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    /// Hand-build the SSA shape for:
    ///
    /// ```c
    /// static long fib(int n) {
    ///     if (n < 2) return (long)n;
    ///     return fib(n - 1) + fib(n - 2);
    /// }
    /// ```
    ///
    /// Verifies (a) the builder produces a well-formed
    /// [`FunctionSsa`] -- block list contiguous, every block
    /// terminated, every value id well-defined -- and (b) the
    /// existing allocator accepts the result without panicking.
    #[test]
    fn fib_round_trip() {
        // c5 ABI: declared int parameter `n` sits at param-slot 2
        // (caller pushed 8 bytes at [fp + 16]); a sign-extending
        // `LoadLocal(2, I32)` reads the low 4 bytes.
        let fake_ent_pc = 0;
        let mut b = SsaBuilder::new(fake_ent_pc, 1, false);

        // Block 0 (entry): n_test = (n < 2).
        let v_n = b.load_local(2, LoadKind::I32);
        let v_test = b.binop_imm(BinOp::Lt, v_n, 2);
        let base = b.new_block();
        let recurse = b.new_block();
        // Bz: jump to `recurse` when the test is false, fall
        // through to `base` when true.
        b.branch_zero(v_test, recurse, base);

        // Base case: return n widened to long. Lt/etc produce 0/1;
        // we want the value of n itself, not the test.
        b.switch_to(base);
        let v_n_again = b.load_local(2, LoadKind::I32);
        b.return_(v_n_again);

        // Recursive case: fib(n-1) + fib(n-2).
        b.switch_to(recurse);
        let v_n1 = b.load_local(2, LoadKind::I32);
        let v_n_minus_1 = b.binop_imm(BinOp::Sub, v_n1, 1);
        let v_call1 = b.call(fake_ent_pc, alloc::vec![v_n_minus_1]);
        let v_n2 = b.load_local(2, LoadKind::I32);
        let v_n_minus_2 = b.binop_imm(BinOp::Sub, v_n2, 2);
        let v_call2 = b.call(fake_ent_pc, alloc::vec![v_n_minus_2]);
        let v_sum = b.binop(BinOp::Add, v_call1, v_call2);
        b.return_(v_sum);

        let func = b.finish();

        // Structural assertions.
        assert_eq!(func.blocks.len(), 3, "fib has three blocks");
        assert_eq!(func.blocks[0].inst_range, 0..2);
        // Each subsequent inst_range starts where the prior ended.
        for i in 1..func.blocks.len() {
            assert_eq!(
                func.blocks[i - 1].inst_range.end,
                func.blocks[i].inst_range.start,
                "blocks must cover insts contiguously",
            );
        }
        assert_eq!(
            func.blocks.last().unwrap().inst_range.end as usize,
            func.insts.len(),
            "last block runs to end of inst list",
        );
        assert!(matches!(
            func.blocks[0].terminator,
            Terminator::Bz { .. },
        ));
        assert!(matches!(
            func.blocks[1].terminator,
            Terminator::Return(_),
        ));
        assert!(matches!(
            func.blocks[2].terminator,
            Terminator::Return(_),
        ));

        // Verify the recursive block's calls reference the same
        // ent_pc (self-recursion). target_pc check is a sanity guard
        // against a future builder refactor that drops the field.
        let mut calls = 0;
        for inst in &func.insts {
            if let Inst::Call { target_pc, .. } = inst {
                assert_eq!(*target_pc, fake_ent_pc);
                calls += 1;
            }
        }
        assert_eq!(calls, 2, "fib has two recursive calls");

        // Allocator acceptance: the linear-scan pass walks the
        // FunctionSsa shape; a malformed CFG would panic. Run it on
        // both supported targets so any per-arch divergence in the
        // bank pools surfaces here.
        for target in [super::super::Target::LinuxX64, super::super::Target::LinuxAarch64] {
            let alloc = super::super::ssa_alloc::allocate(&func, target);
            assert_eq!(
                alloc.places.len(),
                func.insts.len(),
                "allocator placed every value (target {target:?})",
            );
        }
    }
}
