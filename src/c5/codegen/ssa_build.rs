//! Direct construction of [`FunctionSsa`] from a syntactic walk.
//!
//! The builder feeds the AST walker (`ast::walk::walk_function`) and
//! parser-side synthesis (`emit_sys_trampolines`, the synthetic CRT
//! entry); anything constructed here is consumed by the allocator
//! and per-arch emit unchanged.
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

use super::super::ir::{
    BinOp, Block, BlockId, FpCastKind, FunctionSsa, Inst, LoadKind, NO_VALUE, StoreKind,
    Terminator, ValueId,
};

/// Cached `(off, kind, value)` for a previously-pushed
/// `Inst::LoadLocal` or `Inst::StoreLocal`. A subsequent
/// `load_local` with the same `(off, kind)` returns the cached
/// `value` without emitting a new instruction, matching standard
/// in-block common-subexpression elimination for stack slots.
/// Entries clear on stores / calls / address-of-local / block
/// transitions -- anything that could write the slot through
/// aliasing.
#[derive(Clone, Copy)]
struct LocalCacheEntry {
    off: i64,
    kind: LoadKind,
    value: ValueId,
}

/// Discriminant for the pure-value CSE cache. Imm / ImmData /
/// ImmCode produce no side effects and read no memory, so the
/// cache only needs `switch_to` invalidation. The intra-block
/// dominance an SSA function requires holds for repeats inside
/// the same block. `LocalAddr` is deliberately excluded -- the
/// per-arch emit pattern-matches `LocalAddr` immediately
/// followed by `Load` / `Store` and fuses the pair into a
/// single-instruction addressing mode; CSE'ing the LocalAddr
/// breaks that adjacency and falls into the "op outside the
/// implemented subset" branch.
#[derive(Clone, Copy, PartialEq, Eq, Hash)]
enum PureKey {
    Imm(i64),
    ImmData(i64),
    ImmCode(usize),
    TlsAddr(i64),
    Binop {
        op: BinOp,
        lhs: ValueId,
        rhs: ValueId,
    },
    BinopI {
        op: BinOp,
        lhs: ValueId,
        rhs_imm: i64,
    },
    Fneg(ValueId),
    FpCast {
        kind: FpCastKind,
        value: ValueId,
    },
}

/// Builder over a [`FunctionSsa`]. Each method that defines a value
/// returns its [`ValueId`]; terminators close the current block.
pub(crate) struct SsaBuilder {
    func: FunctionSsa,
    /// Block currently receiving inst pushes. `None` after a
    /// terminator closes the block until [`Self::switch_to`] picks
    /// another one.
    current: Option<BlockId>,
    /// Per-block CSE cache for `load_local` / `store_local`. The
    /// list stays short in practice (typical block touches a
    /// handful of slots), so a linear scan beats a BTreeMap. The
    /// cache invalidates entirely on calls / generic stores /
    /// address-of-local / block transitions; individual entries
    /// invalidate when their slot is `store_local`-overwritten.
    local_cache: Vec<LocalCacheEntry>,
    /// Per-block CSE cache for pure values (`Inst::Imm`,
    /// `Inst::ImmData`, `Inst::ImmCode`, the SSA binops, ...). Keyed
    /// by the value's identity so a repeat lands in O(1); resets on
    /// `switch_to`. Every insert is guarded by a prior `lookup_pure`,
    /// so each key maps to exactly one ValueId.
    pure_cache: hashbrown::HashMap<PureKey, ValueId>,
    /// Per-block start indices in `func.insts`. Index is `BlockId`
    /// as `usize`. Set on [`Self::new_block`] and re-anchored by
    /// [`Self::switch_to`] -- the latter is what guarantees the
    /// start matches the actual first inst of the block when
    /// nested control flow (`if` inside `do { ... } while (0)`)
    /// inserts blocks out of ID order.
    block_starts: Vec<u32>,
    /// Per-block end indices in `func.insts`. Recorded on
    /// [`Self::close`] so `finish()` knows the exact half-open
    /// range `start..end` regardless of the surrounding control
    /// flow's allocation order.
    block_ends: Vec<u32>,
    /// Per-block terminator. Mirrors [`Block::terminator`] until
    /// [`Self::finish`] folds it into the final block list.
    block_terminators: Vec<Option<Terminator>>,
    /// Per-block exit accumulator. Mirrors [`Block::exit_acc`].
    block_exit_accs: Vec<ValueId>,
    /// Last value defined in the current block. Used as the default
    /// `exit_acc` if the block's terminator doesn't specify one.
    last_def: ValueId,
    /// Current `(line, file_idx)` source position. Stamped onto
    /// every inst pushed into the function so the DWARF emitter
    /// can recover a per-statement line table for walker-produced
    /// SSA. `(0, 0)` means "no source information"; the DWARF
    /// builder skips those rows.
    cur_src: (u32, u32),
}

impl SsaBuilder {
    /// Create a builder for a function with the given identity and
    /// initial entry block (block 0). The entry block is the
    /// builder's initial focus; the first push lands there.
    pub(crate) fn new(ent_pc: usize, n_params: usize, is_variadic: bool) -> Self {
        let func = FunctionSsa {
            name: alloc::string::String::new(),
            ent_pc,
            end_pc: ent_pc,
            locals: 0,
            n_params,
            is_variadic,
            insts: Vec::new(),
            inst_src: Vec::new(),
            blocks: Vec::new(),
            extern_call_refs: Vec::new(),
            extern_imm_code_refs: Vec::new(),
            extern_imm_data_refs: Vec::new(),
            extern_tls_refs: Vec::new(),
        };
        let mut b = Self {
            func,
            current: None,
            local_cache: Vec::new(),
            pure_cache: hashbrown::HashMap::new(),
            block_starts: Vec::new(),
            block_ends: Vec::new(),
            block_terminators: Vec::new(),
            block_exit_accs: Vec::new(),
            last_def: NO_VALUE,
            cur_src: (0, 0),
        };
        let entry = b.new_block();
        b.switch_to(entry);
        b
    }

    /// Record that the function reserves `n` natural-width local
    /// bytes. Consumed by the per-arch emit's frame layout.
    pub(crate) fn set_locals(&mut self, n: i64) {
        self.func.locals = n;
    }

    /// One-past-the-last ent_pc the source function spans.
    /// Callers driving `walk_function` from the parser-side
    /// `FinishedFunction::end_pc` set this so the SSA tier knows
    /// the function's PC range without consulting a parser-side
    /// counter post-walk.
    pub(crate) fn set_end_pc(&mut self, end_pc: usize) {
        self.func.end_pc = end_pc;
    }

    /// Set the source-level function name. Codegen consumers use
    /// it for symbol-table and DWARF emission; the builder's
    /// default is an empty string, which the consumers replace
    /// with a `fn_<ent_pc>` placeholder.
    pub(crate) fn set_name(&mut self, name: alloc::string::String) {
        self.func.name = name;
    }

    /// Reserve a new basic block and return its id. The new block
    /// is not made current; the caller drives that via
    /// [`Self::switch_to`].
    pub(crate) fn new_block(&mut self) -> BlockId {
        let id = self.block_starts.len() as BlockId;
        self.block_starts.push(self.func.insts.len() as u32);
        self.block_ends.push(self.func.insts.len() as u32);
        self.block_terminators.push(None);
        self.block_exit_accs.push(NO_VALUE);
        id
    }

    /// Make `block` the current insertion point. Subsequent pushes
    /// land in this block until a terminator closes it.
    pub(crate) fn switch_to(&mut self, block: BlockId) {
        // Re-anchor the block's inst-start to the current end of
        // the inst list. This handles the natural construction
        // order where new_block reserves an id before the prior
        // block has finished emitting.
        let idx = block as usize;
        self.block_starts[idx] = self.func.insts.len() as u32;
        self.current = Some(block);
        self.last_def = NO_VALUE;
        // Entering a new block starts a fresh CSE region. Stale
        // entries from the prior block don't dominate the new
        // block's first uses (would need phi to merge them).
        self.local_cache.clear();
        self.pure_cache.clear();
    }

    /// The implicit entry block (block 0). Always exists.
    pub(crate) fn entry_block(&self) -> BlockId {
        0
    }

    /// Scan the in-block pure-value cache for a previously-built
    /// entry with the same key; return its ValueId on a hit.
    fn lookup_pure(&self, key: PureKey) -> Option<ValueId> {
        self.pure_cache.get(&key).copied()
    }

    fn push(&mut self, inst: Inst) -> ValueId {
        debug_assert!(
            self.current.is_some(),
            "SsaBuilder: push into a closed block (no current focus)",
        );
        let id = self.func.insts.len() as ValueId;
        self.func.insts.push(inst);
        self.func.inst_src.push(self.cur_src);
        self.last_def = id;
        id
    }

    /// Set the `(line, file_idx)` source position stamped on every
    /// subsequent [`Self::push`] until the next call. Used by the
    /// walker to drive per-statement DWARF rows.
    pub(crate) fn set_src(&mut self, line: u32, file_idx: u32) {
        self.cur_src = (line, file_idx);
    }

    /// `Inst::Imm`. In-block CSE: a prior `imm(v)` returns the
    /// same ValueId. Pure value, no aliasing concerns; the
    /// `switch_to` block-boundary clear is the only invalidation.
    pub(crate) fn imm(&mut self, v: i64) -> ValueId {
        if let Some(cached) = self.lookup_pure(PureKey::Imm(v)) {
            return cached;
        }
        let id = self.push(Inst::Imm(v));
        self.pure_cache.insert(PureKey::Imm(v), id);
        id
    }

    /// `Inst::ImmData` (data-segment offset). Same CSE shape as
    /// `imm`. Externally-resolved data offsets use
    /// `imm_data_extern`, which records a per-site reloc entry
    /// and must NOT be CSE'd.
    pub(crate) fn imm_data(&mut self, off: i64) -> ValueId {
        if let Some(cached) = self.lookup_pure(PureKey::ImmData(off)) {
            return cached;
        }
        let id = self.push(Inst::ImmData(off));
        self.pure_cache.insert(PureKey::ImmData(off), id);
        id
    }

    /// `Inst::ImmData(0)` whose target lives in another TU.
    /// Records the parser-symbol index for later linker
    /// resolution.
    pub(crate) fn imm_data_extern(&mut self, sym_idx: u32) -> ValueId {
        let v = self.push(Inst::ImmData(0));
        self.func.extern_imm_data_refs.push((v, sym_idx));
        v
    }

    /// `Inst::ImmCode` (function-pointer literal). Same CSE shape
    /// as `imm`; the extern variant `imm_code_extern` skips the
    /// cache for per-site reloc accounting.
    pub(crate) fn imm_code(&mut self, target_pc: usize) -> ValueId {
        if let Some(cached) = self.lookup_pure(PureKey::ImmCode(target_pc)) {
            return cached;
        }
        let id = self.push(Inst::ImmCode(target_pc));
        self.pure_cache.insert(PureKey::ImmCode(target_pc), id);
        id
    }

    /// `Inst::ImmCode(0)` whose target lives in another TU.
    /// Records the parser-symbol index for later linker
    /// resolution.
    pub(crate) fn imm_code_extern(&mut self, sym_idx: u32) -> ValueId {
        let v = self.push(Inst::ImmCode(0));
        self.func.extern_imm_code_refs.push((v, sym_idx));
        v
    }

    /// `Inst::AllocaInit` -- per-function alloca bookkeeping
    /// slot. Slot 0 means "no alloca in this function"; the
    /// per-arch emit short-circuits and writes nothing for the
    /// zero case. The walker emits one per function so the
    /// codegen's per-function state (`current_alloca_top`)
    /// initialises consistently across SSA producers.
    pub(crate) fn alloca_init(&mut self, slot: i64) -> ValueId {
        self.push(Inst::AllocaInit(slot))
    }

    /// `Inst::LocalAddr`. The address of a local escapes; any
    /// subsequent generic store could write through it, so drop
    /// every load-local CSE entry. The address materialization
    /// itself is pure but is deliberately NOT CSE'd -- see the
    /// `PureKey` comment for why.
    pub(crate) fn local_addr(&mut self, off: i64) -> ValueId {
        self.local_cache.clear();
        self.push(Inst::LocalAddr(off))
    }

    /// `Inst::TlsAddr`. Same alias-escape rationale as
    /// `local_addr` for the load-local cache. TlsAddr itself is
    /// pure (a per-thread block + offset materialization with no
    /// per-arch fusion against subsequent Load / Store), so the
    /// address ValueId is CSE-eligible.
    pub(crate) fn tls_addr(&mut self, off: i64) -> ValueId {
        if let Some(cached) = self.lookup_pure(PureKey::TlsAddr(off)) {
            return cached;
        }
        self.local_cache.clear();
        let id = self.push(Inst::TlsAddr(off));
        self.pure_cache.insert(PureKey::TlsAddr(off), id);
        id
    }

    /// `Inst::TlsAddr(0)` whose target lives in another TU.
    /// Records the parser-symbol index for later linker
    /// resolution.
    pub(crate) fn tls_addr_extern(&mut self, sym_idx: u32) -> ValueId {
        let v = self.push(Inst::TlsAddr(0));
        self.func.extern_tls_refs.push((v, sym_idx));
        v
    }

    /// `Inst::Load` through a precomputed address.
    pub(crate) fn load(&mut self, addr: ValueId, kind: LoadKind) -> ValueId {
        self.push(Inst::Load { addr, kind })
    }

    /// `Inst::Store` through a precomputed address. Returns the
    /// stored value's id (matches c5 semantics: a scalar store
    /// leaves the stored value in the accumulator). The address
    /// may
    /// alias a local whose address escaped earlier; drop every
    /// CSE entry so a later `load_local` re-reads the slot.
    pub(crate) fn store(&mut self, addr: ValueId, value: ValueId, kind: StoreKind) -> ValueId {
        self.local_cache.clear();
        self.push(Inst::Store { addr, value, kind })
    }

    /// `Inst::LoadLocal` -- fused [`Inst::LocalAddr`] + [`Inst::Load`].
    /// In-block CSE: a prior `load_local` / `store_local` of the
    /// same `(off, kind)` whose cache entry hasn't been invalidated
    /// returns its `ValueId` directly. The downstream passes
    /// (allocator, per-arch emit) see fewer redundant load
    /// instructions; the codegen drops one local-slot load per
    /// match.
    pub(crate) fn load_local(&mut self, off: i64, kind: LoadKind) -> ValueId {
        for entry in &self.local_cache {
            if entry.off == off && entry.kind == kind {
                return entry.value;
            }
        }
        let v = self.push(Inst::LoadLocal { off, kind });
        self.local_cache.push(LocalCacheEntry {
            off,
            kind,
            value: v,
        });
        v
    }

    /// `Inst::StoreLocal` -- fused [`Inst::LocalAddr`] + [`Inst::Store`].
    /// Invalidates every CSE entry for the same slot. Does NOT
    /// re-seed the cache with the just-stored value: narrowing
    /// stores (I8 / I16 / I32 / F32) followed by a widening load
    /// of the same width truncate-then-extend the value, so the
    /// load result is not bit-identical to the source register
    /// for inputs outside the narrow range. I64-store-then-I64-
    /// load would be safe, but special-casing it isn't worth the
    /// surface area; the next `load_local` simply re-emits.
    pub(crate) fn store_local(&mut self, off: i64, value: ValueId, kind: StoreKind) -> ValueId {
        self.local_cache.retain(|e| e.off != off);
        self.push(Inst::StoreLocal { off, value, kind })
    }

    /// `Inst::Binop`. In-block CSE: a prior `binop(op, lhs, rhs)`
    /// with the same operands returns the same ValueId. Inputs are
    /// already SSA values whose definitions dominate this site, so
    /// the cached result is bit-identical (including IEEE-754 NaN
    /// payloads: same inputs to same FP op produce the same NaN).
    pub(crate) fn binop(&mut self, op: BinOp, lhs: ValueId, rhs: ValueId) -> ValueId {
        let key = PureKey::Binop { op, lhs, rhs };
        if let Some(cached) = self.lookup_pure(key) {
            return cached;
        }
        let id = self.push(Inst::Binop { op, lhs, rhs });
        self.pure_cache.insert(key, id);
        id
    }

    /// If `v` names an `Inst::Imm` in the current function, return
    /// its constant value. Callers in the walker use this to fold
    /// `Binop(op, X, Imm_value)` into `BinopI` when the rhs walked
    /// out to a constant -- which catches recursive constant
    /// expressions (e.g. `arr[K]` lowers to `arr + (K * sizeof)`,
    /// and the inner `K * sizeof` walks down to an `Imm`).
    pub(crate) fn peek_imm(&self, v: ValueId) -> Option<i64> {
        match self.func.insts.get(v as usize) {
            Some(Inst::Imm(k)) => Some(*k),
            _ => None,
        }
    }

    /// `Inst::BinopI` with on-the-fly algebraic peepholes.
    ///
    /// * Identity rhs (no-op on `lhs`, returns the lhs unchanged):
    ///   `Add/Sub/Or/Xor/Shl/Shr/Shru` with 0, `Mul` with 1,
    ///   `And` with -1.
    /// * Zero-collapse rhs (the result is the constant 0
    ///   regardless of `lhs`): `Mul/And` with 0. C99 6.5
    ///   requires no side effects from the elided `lhs`
    ///   evaluation, but `lhs` is already an SSA value at this
    ///   point so the evaluation is complete and its discardable.
    pub(crate) fn binop_imm(&mut self, op: BinOp, lhs: ValueId, rhs_imm: i64) -> ValueId {
        let identity = match op {
            BinOp::Add | BinOp::Sub | BinOp::Or | BinOp::Xor => rhs_imm == 0,
            BinOp::Shl | BinOp::Shr | BinOp::Shru => rhs_imm == 0,
            BinOp::Mul => rhs_imm == 1,
            BinOp::And => rhs_imm == -1,
            _ => false,
        };
        if identity {
            return lhs;
        }
        let zero_collapses = matches!(op, BinOp::Mul | BinOp::And) && rhs_imm == 0;
        if zero_collapses {
            return self.imm(0);
        }
        let key = PureKey::BinopI { op, lhs, rhs_imm };
        if let Some(cached) = self.lookup_pure(key) {
            return cached;
        }
        let id = self.push(Inst::BinopI { op, lhs, rhs_imm });
        self.pure_cache.insert(key, id);
        id
    }

    /// `Inst::Fneg`. Pure value; same input -> same output bit
    /// pattern. CSE-eligible.
    pub(crate) fn fneg(&mut self, v: ValueId) -> ValueId {
        let key = PureKey::Fneg(v);
        if let Some(cached) = self.lookup_pure(key) {
            return cached;
        }
        let id = self.push(Inst::Fneg(v));
        self.pure_cache.insert(key, id);
        id
    }

    /// `Inst::FpCast`. Pure value; same input + same kind ->
    /// same output. CSE-eligible.
    pub(crate) fn fp_cast(&mut self, kind: FpCastKind, value: ValueId) -> ValueId {
        let key = PureKey::FpCast { kind, value };
        if let Some(cached) = self.lookup_pure(key) {
            return cached;
        }
        let id = self.push(Inst::FpCast { kind, value });
        self.pure_cache.insert(key, id);
        id
    }

    /// `Inst::Call` -- direct user-function call. Callees may
    /// write through any pointer they receive (including ones
    /// derived from local addresses that escaped earlier in the
    /// caller), so every CSE entry invalidates.
    pub(crate) fn call(&mut self, target_pc: usize, args: Vec<ValueId>) -> ValueId {
        self.local_cache.clear();
        self.push(Inst::Call { target_pc, args })
    }

    /// `Inst::Call` whose `target_pc` is 0 because the callee
    /// lives in another translation unit. Records the parser-
    /// symbol index in `extern_call_refs` so the linker can
    /// resolve to the merged ent_pc after symbol unification.
    pub(crate) fn call_extern(&mut self, sym_idx: u32, args: Vec<ValueId>) -> ValueId {
        self.local_cache.clear();
        let v = self.push(Inst::Call { target_pc: 0, args });
        self.func.extern_call_refs.push((v, sym_idx));
        v
    }

    /// `Inst::CallIndirect` -- function-pointer call.
    pub(crate) fn call_indirect(&mut self, target: ValueId, args: Vec<ValueId>) -> ValueId {
        self.local_cache.clear();
        self.push(Inst::CallIndirect { target, args })
    }

    /// `Inst::Mcpy` -- whole-struct / aggregate memory copy of
    /// `size` bytes from `src` to `dst`. Used by the AST walker's
    /// `LocalInit::Aggregate` lowering when a brace-list
    /// initializer's bytes were staged in `.data`. dst may alias
    /// any escaped local; invalidate the CSE cache.
    pub(crate) fn mcpy(&mut self, dst: ValueId, src: ValueId, size: i64) {
        self.local_cache.clear();
        self.push(Inst::Mcpy { dst, src, size });
    }

    /// `Inst::Intrinsic` -- compiler-builtin (alloca / setjmp /
    /// longjmp / va_*). The `kind` is the discriminant from
    /// `crate::c5::op::Intrinsic`; the per-arch SSA emit reads it
    /// to pick the right lowering. Conservative: invalidate the
    /// CSE cache -- setjmp / longjmp move control across the
    /// block, va_start / va_arg may write through caller buffers.
    pub(crate) fn intrinsic(&mut self, kind: i64, args: Vec<ValueId>) -> ValueId {
        self.local_cache.clear();
        self.push(Inst::Intrinsic { kind, args })
    }

    /// Reserve a fresh per-function 8-byte stack slot for the
    /// walker (short-circuit merge, ternary spill, etc.) and
    /// return its c5-style negative offset (`-N` for the Nth
    /// slot). Used as a phi substitute since the SSA model
    /// carries values through a single accumulator + block-
    /// exit-acc rather than explicit phi instructions.
    pub(crate) fn alloc_synthetic_local(&mut self) -> i64 {
        self.func.locals += 1;
        -self.func.locals
    }

    /// `Inst::CallExt` -- libc / external call. libc body may
    /// write through caller-supplied pointers, including ones
    /// derived from escaped local addresses; invalidate the
    /// CSE cache.
    pub(crate) fn call_ext(
        &mut self,
        binding_idx: i64,
        args: Vec<ValueId>,
        fp_arg_mask: u32,
    ) -> ValueId {
        self.local_cache.clear();
        self.push(Inst::CallExt {
            binding_idx,
            args,
            fp_arg_mask,
        })
    }

    /// Close the current block with `Terminator::Jmp`.
    pub(crate) fn jmp(&mut self, target: BlockId) {
        self.close(Terminator::Jmp(target), self.last_def);
    }

    /// Close the current block with `Terminator::Bz`. `cond` is the
    /// value tested; control transfers to `target` when zero, else
    /// falls through to `fall_through`.
    pub(crate) fn branch_zero(&mut self, cond: ValueId, target: BlockId, fall_through: BlockId) {
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
    pub(crate) fn branch_nonzero(&mut self, cond: ValueId, target: BlockId, fall_through: BlockId) {
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
    pub(crate) fn return_(&mut self, value: ValueId) {
        self.close(Terminator::Return(value), value);
    }

    /// Close the current block with `Terminator::TailExt`. Used
    /// by parser-emitted sys-trampolines whose body is a single
    /// `jmp [iat]` host instruction. The caller's own argument
    /// setup owns the host ABI; the trampoline itself doesn't
    /// touch the stack.
    pub(crate) fn tail_ext(&mut self, binding_idx: i64) {
        self.close(Terminator::TailExt(binding_idx), NO_VALUE);
    }

    /// True if a block is currently open (the caller can still
    /// emit instructions or close it). False between a
    /// terminator and the next `switch_to`. Used by the AST
    /// walker to decide whether to synthesize a fallthrough
    /// terminator at function-end.
    pub(crate) fn is_block_open(&self) -> bool {
        self.current.is_some()
    }

    /// Close every block that's still open with a synthetic
    /// `return 0` terminator. Called by the AST walker at
    /// function-end to absorb dead blocks left behind by
    /// pre-allocated branch / loop targets that no flow ever
    /// reached. Without this, `finish()` would panic on an open
    /// block; the synthetic return is unreachable in practice
    /// but keeps the SSA well-formed.
    pub(crate) fn close_dead_blocks(&mut self) {
        let n = self.block_terminators.len();
        for i in 0..n {
            if self.block_terminators[i].is_none() {
                self.switch_to(i as BlockId);
                let zero = self.imm(0);
                self.return_(zero);
            }
        }
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
        self.block_ends[idx] = self.func.insts.len() as u32;
        self.current = None;
        self.last_def = NO_VALUE;
    }

    /// Finalise the builder and return the populated [`FunctionSsa`].
    /// Panics if any block was opened but not terminated.
    ///
    /// Block ranges come from the `block_starts` / `block_ends`
    /// pair recorded by `switch_to` / `close` respectively. The
    /// previous derived-from-next-start scheme produced overlapping
    /// or negative ranges when a nested control structure (`if`
    /// inside `do { ... } while (0)`) caused blocks to be filled
    /// out of ID order: an early-allocated block id finishes
    /// after a later-allocated block's `switch_to` re-anchors its
    /// own start, so the ID-pair-walk loses track of where each
    /// block actually lives in the flat inst vector.
    pub(crate) fn finish(mut self) -> FunctionSsa {
        let n = self.block_starts.len();
        let mut blocks: Vec<Block> = Vec::with_capacity(n);
        for i in 0..n {
            let start = self.block_starts[i];
            let end = self.block_ends[i];
            debug_assert!(
                end >= start,
                "SsaBuilder: block {i} has end {end} < start {start}",
            );
            let terminator = self.block_terminators[i]
                .unwrap_or_else(|| panic!("SsaBuilder: block {i} finished without a terminator"));
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
        // the test result is discarded -- the return value is the
        // loaded n.
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
        assert!(matches!(func.blocks[0].terminator, Terminator::Bz { .. },));
        assert!(matches!(func.blocks[1].terminator, Terminator::Return(_),));
        assert!(matches!(func.blocks[2].terminator, Terminator::Return(_),));

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
        for target in [
            super::super::Target::LinuxX64,
            super::super::Target::LinuxAarch64,
        ] {
            let alloc = super::super::ssa_alloc::allocate(&func, target);
            assert_eq!(
                alloc.places.len(),
                func.insts.len(),
                "allocator placed every value (target {target:?})",
            );
        }
    }

    /// Hand-build a counted loop with a back-edge into the loop
    /// header:
    ///
    /// ```c
    /// long count_to(long limit) {
    ///     long i = 0;
    ///     while (i < limit) i += 1;
    ///     return i;
    /// }
    /// ```
    ///
    /// Validates that the builder produces a CFG with a back-edge
    /// (loop-body -> loop-header) and that the linear-scan
    /// allocator computes live ranges across the back-edge
    /// without diagnostics. Loop-header reads of `i` reach via
    /// the local slot rather than a phi for `address_escaped`-
    /// style locals; mem2reg promotion is tracked separately
    /// (TODO).
    #[test]
    fn loop_back_edge_round_trip() {
        let mut b = SsaBuilder::new(0, 1, false);
        // Local layout: `i` is the only true local; reserve one
        // 8-byte slot. c5 ABI: `limit` is the declared parameter
        // at slot 2 (caller pushed an 8-byte value).
        b.set_locals(8);
        let i_off: i64 = -1; // c5 slot index; codegen multiplies by 8.

        let _entry = b.entry_block();
        let header = b.new_block();
        let body = b.new_block();
        let exit = b.new_block();

        // Entry: i = 0; jmp header.
        let v_zero = b.imm(0);
        let _ = b.store_local(i_off, v_zero, StoreKind::I64);
        b.jmp(header);

        // Header: cond = i < limit; if zero (false) -> exit, else
        // fall through to body.
        b.switch_to(header);
        let v_i = b.load_local(i_off, LoadKind::I64);
        let v_limit = b.load_local(2, LoadKind::I64);
        let v_cond = b.binop(BinOp::Lt, v_i, v_limit);
        b.branch_zero(v_cond, exit, body);

        // Body: i = i + 1; jmp header (back-edge).
        b.switch_to(body);
        let v_i_body = b.load_local(i_off, LoadKind::I64);
        let v_i_plus_1 = b.binop_imm(BinOp::Add, v_i_body, 1);
        let _ = b.store_local(i_off, v_i_plus_1, StoreKind::I64);
        b.jmp(header);

        // Exit: return i.
        b.switch_to(exit);
        let v_i_exit = b.load_local(i_off, LoadKind::I64);
        b.return_(v_i_exit);

        let func = b.finish();

        // Structural assertions.
        assert_eq!(func.blocks.len(), 4);
        for i in 1..func.blocks.len() {
            assert_eq!(
                func.blocks[i - 1].inst_range.end,
                func.blocks[i].inst_range.start,
            );
        }
        // Header terminator targets exit (zero branch) and body
        // (fall-through); body terminator jumps back to header.
        match func.blocks[1].terminator {
            Terminator::Bz {
                target,
                fall_through,
                ..
            } => {
                assert_eq!(target, exit);
                assert_eq!(fall_through, body);
            }
            t => panic!("header terminator must be Bz, got {t:?}"),
        }
        match func.blocks[2].terminator {
            Terminator::Jmp(t) => assert_eq!(t, header),
            t => panic!("body terminator must be Jmp(header), got {t:?}"),
        }

        // Allocator: the back-edge extends the live range of `v_i`
        // and `v_limit` across the loop body. Linear scan must
        // place every value.
        for target in [
            super::super::Target::LinuxX64,
            super::super::Target::LinuxAarch64,
        ] {
            let alloc = super::super::ssa_alloc::allocate(&func, target);
            assert_eq!(alloc.places.len(), func.insts.len());
        }
    }

    /// Back-to-back `load_local` of the same slot inside a block
    /// returns the same ValueId without emitting a second
    /// `Inst::LoadLocal`. Implements the in-block CSE described in
    /// `load_local`'s doc-comment.
    #[test]
    fn load_local_cse_collapses_repeats() {
        let mut b = SsaBuilder::new(0, 1, false);
        let v_first = b.load_local(2, LoadKind::I32);
        let v_second = b.load_local(2, LoadKind::I32);
        assert_eq!(v_first, v_second, "repeat load_local must reuse ValueId");
        // Different kind on same slot is a fresh load -- the byte
        // pattern read differs (sign / zero extension width).
        let v_third = b.load_local(2, LoadKind::I64);
        assert_ne!(v_first, v_third, "different kind must emit a new load");
        b.return_(v_first);
        let func = b.finish();
        let load_count = func
            .insts
            .iter()
            .filter(|i| matches!(i, Inst::LoadLocal { .. }))
            .count();
        assert_eq!(load_count, 2, "two distinct LoadLocal insts (I32 + I64)");
    }

    /// `store_local` to the same slot invalidates the CSE cache:
    /// the next `load_local` re-emits rather than returning the
    /// stale pre-store value.
    #[test]
    fn store_local_invalidates_cse_entry() {
        let mut b = SsaBuilder::new(0, 1, false);
        let v_first = b.load_local(2, LoadKind::I64);
        let v_imm = b.imm(7);
        let _ = b.store_local(2, v_imm, StoreKind::I64);
        let v_second = b.load_local(2, LoadKind::I64);
        assert_ne!(
            v_first, v_second,
            "load after store must re-emit, not reuse pre-store value",
        );
        b.return_(v_second);
        let func = b.finish();
        let load_count = func
            .insts
            .iter()
            .filter(|i| matches!(i, Inst::LoadLocal { .. }))
            .count();
        assert_eq!(load_count, 2, "two loads of slot 2 separated by a store");
    }

    /// Block transitions clear the CSE cache: a `load_local` in
    /// the entry block doesn't reach into the body. Without this,
    /// a value defined in the entry block would surface as a use
    /// in another block with no phi node to merge it.
    #[test]
    fn block_transition_clears_cse() {
        let mut b = SsaBuilder::new(0, 1, false);
        let v_entry = b.load_local(2, LoadKind::I32);
        let body = b.new_block();
        b.jmp(body);
        b.switch_to(body);
        let v_body = b.load_local(2, LoadKind::I32);
        assert_ne!(
            v_entry, v_body,
            "load across block boundary must emit a fresh inst",
        );
        b.return_(v_body);
        let func = b.finish();
        let load_count = func
            .insts
            .iter()
            .filter(|i| matches!(i, Inst::LoadLocal { .. }))
            .count();
        assert_eq!(
            load_count, 2,
            "entry-block load + body-block load are distinct"
        );
    }

    /// `call` invalidates the CSE cache: a callee may write
    /// through any pointer derived from an escaped local address,
    /// so the next `load_local` re-reads even when no local
    /// escaped in this caller. The pessimisation is intentional
    /// -- escape analysis would shrink it.
    #[test]
    fn call_invalidates_cse() {
        let mut b = SsaBuilder::new(0, 1, false);
        let v_pre = b.load_local(2, LoadKind::I32);
        let _ = b.call(0, alloc::vec![]);
        let v_post = b.load_local(2, LoadKind::I32);
        assert_ne!(
            v_pre, v_post,
            "load across a call must re-emit (conservative alias model)",
        );
        b.return_(v_post);
    }

    /// Repeat `imm(v)` of the same value returns the same
    /// ValueId. Pure value, no side effects.
    #[test]
    fn imm_cse_collapses_repeats() {
        let mut b = SsaBuilder::new(0, 0, false);
        let v_a = b.imm(7);
        let v_b = b.imm(7);
        let v_c = b.imm(7);
        assert_eq!(v_a, v_b);
        assert_eq!(v_a, v_c);
        b.return_(v_a);
        let func = b.finish();
        let imm_count = func
            .insts
            .iter()
            .filter(|i| matches!(i, Inst::Imm(7)))
            .count();
        assert_eq!(imm_count, 1, "three `imm(7)` calls collapse to one Inst");
    }

    /// Different Imm values stay distinct.
    #[test]
    fn imm_cse_keeps_distinct_values_apart() {
        let mut b = SsaBuilder::new(0, 0, false);
        let v_a = b.imm(7);
        let v_b = b.imm(8);
        assert_ne!(v_a, v_b);
        b.return_(v_a);
    }

    /// Repeat `binop_imm(op, lhs, k)` returns the cached ValueId.
    #[test]
    fn binop_imm_cse_collapses_repeats() {
        let mut b = SsaBuilder::new(0, 1, false);
        let v_x = b.load_local(2, LoadKind::I32);
        let v_a = b.binop_imm(BinOp::Mul, v_x, 4);
        let v_b = b.binop_imm(BinOp::Mul, v_x, 4);
        assert_eq!(v_a, v_b);
        b.return_(v_a);
    }

    /// Repeat `binop(op, lhs, rhs)` returns the cached ValueId.
    #[test]
    fn binop_cse_collapses_repeats() {
        let mut b = SsaBuilder::new(0, 2, false);
        let v_x = b.load_local(2, LoadKind::I32);
        let v_y = b.load_local(3, LoadKind::I32);
        let v_a = b.binop(BinOp::Add, v_x, v_y);
        let v_b = b.binop(BinOp::Add, v_x, v_y);
        assert_eq!(v_a, v_b);
        b.return_(v_a);
        let func = b.finish();
        let add_count = func
            .insts
            .iter()
            .filter(|i| matches!(i, Inst::Binop { op: BinOp::Add, .. }))
            .count();
        assert_eq!(add_count, 1, "two identical Binop adds collapse to one");
    }

    /// Block transitions clear the pure cache: an `imm(v)` in the
    /// entry block doesn't reach into the body. SSA dominance
    /// would need a phi to bridge the value across blocks.
    #[test]
    fn imm_cse_clears_across_blocks() {
        let mut b = SsaBuilder::new(0, 0, false);
        let v_entry = b.imm(7);
        let body = b.new_block();
        b.jmp(body);
        b.switch_to(body);
        let v_body = b.imm(7);
        assert_ne!(v_entry, v_body, "imm across block boundary must emit fresh",);
        b.return_(v_body);
    }
}
