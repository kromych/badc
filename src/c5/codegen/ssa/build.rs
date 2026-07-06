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
    AtomicRmwOp, BinOp, Block, BlockId, FpCastKind, FunctionSsa, Inst, LoadKind, NO_VALUE,
    StoreKind, Terminator, ValueId,
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
    /// `Inst::Imm` holding an f32 bit pattern, tagged f32. Kept apart
    /// from [`PureKey::Imm`]: the f32 mark changes the value's
    /// materialisation, so an integer imm with an equal payload must
    /// not unify with it.
    ImmF32(i64),
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
    Extend {
        value: ValueId,
        kind: LoadKind,
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
            is_inline: false,
            insts: Vec::new(),
            inst_src: Vec::new(),
            blocks: Vec::new(),
            extern_call_refs: Vec::new(),
            extern_imm_code_refs: Vec::new(),
            extern_imm_data_refs: Vec::new(),
            extern_tls_refs: Vec::new(),
            f32_values: Vec::new(),
            param_fp_mask: 0,
            agg_descs: alloc::vec::Vec::new(),
            param_aggs: alloc::vec::Vec::new(),
            param_local_slots: alloc::vec::Vec::new(),
            ret_agg: None,
            ret_is_fp: false,
            indirect_result_slot: 0,
            computed_goto_targets: Vec::new(),
            synthetic_base: 0,
            multi_cell_slots: Vec::new(),
            has_returns_twice_call: false,
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
        // Slots reserved after this point are synthetic; `ssa_slot_coalesce`
        // reuses only those, leaving the declared range untouched.
        self.func.synthetic_base = n;
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
        self.func.f32_values.push(false);
        self.last_def = id;
        id
    }

    /// Mark value `v` as single-precision (`f32`). See
    /// [`FunctionSsa::f32_values`]. The walker calls this whenever a
    /// value's C type is `float` (C99 6.3.1.8) so the per-arch emit
    /// keeps it in the low 32 bits of an FP register and selects the
    /// single-precision encoder. Idempotent.
    pub(crate) fn mark_f32(&mut self, v: ValueId) -> ValueId {
        if let Some(slot) = self.func.f32_values.get_mut(v as usize) {
            *slot = true;
        }
        v
    }

    /// Record that declared parameter `i` is a floating-point scalar
    /// passed in an FP argument register. See
    /// [`FunctionSsa::param_fp_mask`]. The callee emit consumes the
    /// mask to resolve each parameter's incoming register through the
    /// same `plan_call_args` the caller runs. Only the low 32
    /// parameters are tracked; a higher index is ignored (those ride
    /// the stack where the class no longer selects a register).
    pub(crate) fn mark_param_fp(&mut self, i: usize) {
        if i < 32 {
            self.func.param_fp_mask |= 1u32 << i;
        }
    }

    /// Record that the function returns a floating-point scalar. See
    /// [`FunctionSsa::ret_is_fp`].
    pub(crate) fn set_ret_is_fp(&mut self, is_fp: bool) {
        self.func.ret_is_fp = is_fp;
    }

    /// The accumulated per-parameter FP mask. See
    /// [`FunctionSsa::param_fp_mask`].
    pub(crate) fn param_fp_mask(&self) -> u32 {
        self.func.param_fp_mask
    }

    /// Overwrite the per-parameter FP mask. Used to clear it when the
    /// resulting register/stack placement would interleave and the
    /// function falls back to the all-integer c5 cdecl ABI. See
    /// [`FunctionSsa::param_fp_mask`].
    pub(crate) fn set_param_fp_mask(&mut self, mask: u32) {
        self.func.param_fp_mask = mask;
    }

    /// Intern an aggregate layout into the function's `agg_descs`,
    /// returning its index for a call's `arg_aggs` or the function's
    /// `param_aggs`.
    pub(crate) fn intern_agg_desc(&mut self, desc: crate::c5::ir::AggDesc) -> u32 {
        let idx = self.func.agg_descs.len() as u32;
        self.func.agg_descs.push(desc);
        idx
    }

    /// Record the per-parameter aggregate map and the matching
    /// body-local slots (host-ABI struct parameters). Both vectors
    /// are parallel to the declared parameter list.
    pub(crate) fn set_param_aggs(&mut self, param_aggs: Vec<Option<u32>>, local_slots: Vec<i64>) {
        self.func.param_aggs = param_aggs;
        self.func.param_local_slots = local_slots;
    }

    /// Record that this function returns `agg_descs[idx]` by value
    /// through the host ABI (registers or x8).
    pub(crate) fn set_ret_agg(&mut self, idx: u32) {
        self.func.ret_agg = Some(idx);
    }

    /// Record the body-local slot holding the incoming x8 indirect-
    /// result pointer for a function returning an aggregate larger
    /// than 16 bytes.
    pub(crate) fn set_indirect_result_slot(&mut self, slot: i64) {
        self.func.indirect_result_slot = slot;
    }

    /// Mark the call instruction whose result is `v` as returning the
    /// aggregate `agg_descs[ret_agg]` into the result temporary at
    /// frame slot `ret_slot_local`.
    pub(crate) fn set_call_ret_agg(&mut self, v: ValueId, ret_agg: u32, ret_slot_local: i64) {
        if let Inst::Call {
            ret_agg: ra,
            ret_slot_local: rs,
            ..
        }
        | Inst::CallIndirect {
            ret_agg: ra,
            ret_slot_local: rs,
            ..
        }
        | Inst::CallExt {
            ret_agg: ra,
            ret_slot_local: rs,
            ..
        } = &mut self.func.insts[v as usize]
        {
            *ra = Some(ret_agg);
            *rs = ret_slot_local;
        }
    }

    /// Attach the per-argument aggregate map to the call instruction
    /// whose result is `v` (its index in `insts`). The metadata
    /// travels with the instruction through the optimizer.
    pub(crate) fn set_call_arg_aggs(&mut self, v: ValueId, arg_aggs: Vec<Option<u32>>) {
        match &mut self.func.insts[v as usize] {
            Inst::Call { arg_aggs: a, .. }
            | Inst::CallIndirect { arg_aggs: a, .. }
            | Inst::CallExt { arg_aggs: a, .. } => {
                *a = arg_aggs;
            }
            _ => {}
        }
    }

    /// True when value `v` was previously marked single-precision.
    pub(crate) fn is_f32(&self, v: ValueId) -> bool {
        self.func
            .f32_values
            .get(v as usize)
            .copied()
            .unwrap_or(false)
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

    /// `Inst::Imm` carrying an f32 bit pattern, tagged f32 (a `float`
    /// constant, C99 6.4.4.2p4). Cached under its own key so it never
    /// unifies with an integer imm of equal payload.
    pub(crate) fn imm_f32(&mut self, f32_bits: u32) -> ValueId {
        let v = f32_bits as i64;
        if let Some(cached) = self.lookup_pure(PureKey::ImmF32(v)) {
            return cached;
        }
        let id = self.push(Inst::Imm(v));
        self.pure_cache.insert(PureKey::ImmF32(v), id);
        self.mark_f32(id)
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

    /// `Inst::BlockAddr` -- the code address of a basic block in
    /// this function (GCC `&&label`). Records `block` as a computed-
    /// goto successor so the CFG treats every `goto *` as branching
    /// to it. Not CSE'd: distinct `&&label` sites must stay separate
    /// defs so the allocator keeps each live as needed.
    pub(crate) fn block_addr(&mut self, block: BlockId) -> ValueId {
        if !self.func.computed_goto_targets.contains(&block) {
            self.func.computed_goto_targets.push(block);
        }
        self.push(Inst::BlockAddr(block))
    }

    /// Close the current block with `Terminator::GotoIndirect`
    /// (GCC `goto *expr`); `target` holds the destination code
    /// address.
    pub(crate) fn goto_indirect(&mut self, target: ValueId) {
        self.close(Terminator::GotoIndirect { target }, target);
    }

    /// `Inst::ImmCode(0)` whose target lives in another TU.
    /// Records the parser-symbol index for later linker
    /// resolution.
    pub(crate) fn imm_code_extern(&mut self, sym_idx: u32) -> ValueId {
        let v = self.push(Inst::ImmCode(0));
        self.func.extern_imm_code_refs.push((v, sym_idx));
        v
    }

    /// `Inst::ImmExtCode` -- the address of a dynamically-imported
    /// function (`&strcmp`, `fp = strcmp`). Not CSE'd: every site
    /// materializes its own address with its own PLT-call fixup, the
    /// same way each call to an import records its own call site.
    pub(crate) fn imm_ext_code(&mut self, binding_idx: i64) -> ValueId {
        self.push(Inst::ImmExtCode(binding_idx))
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

    /// `Inst::ParamRef`. The value is the i-th declared parameter
    /// as it sits in the host-ABI argument register at function
    /// entry, sign-extended from its declared width to 64 bits.
    /// Walker emits one per non-relocated integer parameter and
    /// pairs it with a `StoreLocal` to the c5 cdecl arg slot so
    /// mem2reg can fold per-use `LoadLocal` reads onto a single
    /// SSA value. `kind` records the parameter's natural load
    /// width so mem2reg's narrow-load rewrite skips the redundant
    /// `Inst::Extend` when the LoadLocal kind matches.
    pub(crate) fn param_ref(&mut self, idx: u32, kind: LoadKind) -> ValueId {
        self.push(Inst::ParamRef { idx, kind })
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

    /// `Inst::Load` through a precomputed address. A `float`-typed
    /// load (`LoadKind::F32`) yields a single-precision value (C99
    /// 6.3.1.8); tag it f32 so the codegen keeps it in the s-view of an
    /// FP register without a widening conversion.
    pub(crate) fn load(&mut self, addr: ValueId, kind: LoadKind) -> ValueId {
        self.load_vol(addr, kind, false)
    }

    /// [`Self::load`] with an explicit volatile mark (C99 6.7.3p6).
    pub(crate) fn load_vol(&mut self, addr: ValueId, kind: LoadKind, volatile: bool) -> ValueId {
        let v = self.push(Inst::Load {
            addr,
            disp: 0,
            kind,
            volatile,
        });
        if matches!(kind, LoadKind::F32) {
            self.mark_f32(v);
        }
        v
    }

    /// `Inst::Store` through a precomputed address. Returns the
    /// stored value's id (matches c5 semantics: a scalar store
    /// leaves the stored value in the accumulator). The address
    /// may
    /// alias a local whose address escaped earlier; drop every
    /// CSE entry so a later `load_local` re-reads the slot.
    pub(crate) fn store(&mut self, addr: ValueId, value: ValueId, kind: StoreKind) -> ValueId {
        self.store_vol(addr, value, kind, false)
    }

    /// [`Self::store`] with an explicit volatile mark (C99 6.7.3p6).
    pub(crate) fn store_vol(
        &mut self,
        addr: ValueId,
        value: ValueId,
        kind: StoreKind,
        volatile: bool,
    ) -> ValueId {
        self.local_cache.clear();
        self.push(Inst::Store {
            addr,
            disp: 0,
            value,
            kind,
            volatile,
        })
    }

    /// `Inst::LoadLocal` -- fused [`Inst::LocalAddr`] + [`Inst::Load`].
    /// In-block CSE: a prior `load_local` / `store_local` of the
    /// same `(off, kind)` whose cache entry hasn't been invalidated
    /// returns its `ValueId` directly. The downstream passes
    /// (allocator, per-arch emit) see fewer redundant load
    /// instructions; the codegen drops one local-slot load per
    /// match.
    pub(crate) fn load_local(&mut self, off: i64, kind: LoadKind) -> ValueId {
        self.load_local_vol(off, kind, false)
    }

    /// [`Self::load_local`] with an explicit volatile mark. A volatile
    /// load bypasses the CSE cache both ways: it never reuses a cached
    /// value and never seeds one, so every source-level read performs
    /// a memory access (C99 5.1.2.3p2).
    pub(crate) fn load_local_vol(&mut self, off: i64, kind: LoadKind, volatile: bool) -> ValueId {
        if !volatile {
            for entry in &self.local_cache {
                if entry.off == off && entry.kind == kind {
                    return entry.value;
                }
            }
        }
        let v = self.push(Inst::LoadLocal {
            off,
            kind,
            volatile,
        });
        // A `float`-typed local load is single precision (C99 6.3.1.8);
        // tag it f32 so the codegen keeps it in the s-view of an FP
        // register without a widening conversion.
        if matches!(kind, LoadKind::F32) {
            self.mark_f32(v);
        }
        if !volatile {
            self.local_cache.push(LocalCacheEntry {
                off,
                kind,
                value: v,
            });
        }
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
        self.store_local_vol(off, value, kind, false)
    }

    /// [`Self::store_local`] with an explicit volatile mark.
    pub(crate) fn store_local_vol(
        &mut self,
        off: i64,
        value: ValueId,
        kind: StoreKind,
        volatile: bool,
    ) -> ValueId {
        self.local_cache.retain(|e| e.off != off);
        self.push(Inst::StoreLocal {
            off,
            value,
            kind,
            volatile,
        })
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

    /// Strength-reduce `Div` / `Divu` / `Mod` / `Modu` by a constant
    /// positive power of two to shifts / masks; the hardware divide is
    /// multi-cycle. Returns `None` when `op` is not a divide / modulo
    /// or `rhs` is not a power-of-two immediate, leaving the caller on
    /// the register-rhs divide path (the per-arch `BinopI` emit does
    /// not lower Div / Mod). The divmod emit divides the 64-bit operand
    /// -- narrow types are sign/zero-extended first -- so the rewrites
    /// are evaluated at the same width.
    pub(crate) fn divmod_pow2(&mut self, op: BinOp, lhs: ValueId, rhs: ValueId) -> Option<ValueId> {
        let d = self.peek_imm(rhs)?;
        if d <= 0 || !(d as u64).is_power_of_two() {
            return None;
        }
        let k = d.trailing_zeros() as i64; // 0..=62 (d > 0 fits i64)
        let mask = d - 1; // 2^k - 1
        Some(match op {
            // Unsigned: `x / 2^k == x >>u k`, `x % 2^k == x & (2^k-1)`.
            // The k == 0 (divisor 1) forms fold to the shift / mask
            // identities in `binop_imm`.
            BinOp::Divu => self.binop_imm(BinOp::Shru, lhs, k),
            BinOp::Modu => self.binop_imm(BinOp::And, lhs, mask),
            // Signed division truncates toward zero (C99 6.5.5p6), so a
            // negative dividend takes a bias of 2^k - 1 before the
            // arithmetic shift. `bias = (x >>s 63) >>u (64 - k)`: all
            // ones masked to 2^k - 1 when x < 0, else 0.
            BinOp::Div if k >= 1 => {
                let sign = self.binop_imm(BinOp::Shr, lhs, 63);
                let bias = self.binop_imm(BinOp::Shru, sign, 64 - k);
                let adj = self.binop(BinOp::Add, lhs, bias);
                self.binop_imm(BinOp::Shr, adj, k)
            }
            // Signed `x % 2^k == ((x + bias) & (2^k-1)) - bias` with the
            // same bias, giving a remainder with the sign of x.
            BinOp::Mod if k >= 1 => {
                let sign = self.binop_imm(BinOp::Shr, lhs, 63);
                let bias = self.binop_imm(BinOp::Shru, sign, 64 - k);
                let adj = self.binop(BinOp::Add, lhs, bias);
                let masked = self.binop_imm(BinOp::And, adj, mask);
                self.binop(BinOp::Sub, masked, bias)
            }
            // Divisor 1 (k == 0): division is identity, modulo is 0.
            BinOp::Div => lhs,
            BinOp::Mod => self.imm(0),
            _ => return None,
        })
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
    /// * Chained-imm reassociation when `lhs` is itself a
    ///   `BinopI` whose op is compatible:
    ///     `(x + K1) + K2  ->  x + (K1+K2)`
    ///     `(x + K1) - K2  ->  x + (K1-K2)`
    ///     `(x - K1) + K2  ->  x + (K2-K1)`
    ///     `(x - K1) - K2  ->  x - (K1+K2)`
    ///     `(x & K1) & K2  ->  x & (K1&K2)`
    ///     `(x | K1) | K2  ->  x | (K1|K2)`
    ///     `(x ^ K1) ^ K2  ->  x ^ (K1^K2)`
    ///   The folds use `wrapping_add` / `wrapping_sub` to mirror
    ///   the SSA value model (a 64-bit bit pattern; per-type
    ///   narrowing happens at materialisation). The original
    ///   `lhs` BinopI may become dead and the existing DCE pass
    ///   skips it.
    pub(crate) fn binop_imm(&mut self, op: BinOp, lhs: ValueId, rhs_imm: i64) -> ValueId {
        // Constant-fold `(Imm k1) op k2` directly to `Imm(k1 op k2)`.
        // The 64-bit SSA value model uses wrapping arithmetic for
        // Add/Sub/Mul and discards out-of-range Imm operands for
        // Div / Mod (lhs's runtime evaluation can't be skipped, but
        // for a known constant lhs the operation has a value too).
        // Comparison ops collapse to the 0 / 1 boolean.
        if let Some(k1) = self.peek_imm(lhs)
            && let Some(folded) = fold_int_binop_imm(op, k1, rhs_imm)
        {
            return self.imm(folded);
        }
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
        // Canonicalize the signed sign-narrow idiom `Shl K; Shr K`
        // (arithmetic right shift) into one `Inst::Extend`. The pair
        // truncates to `64 - K` bits and sign-extends back; for the
        // load-kind widths it is exactly `sxtw`/`sxth`/`sxtb`. A typed
        // node lets the redundant-extend pass and the per-arch emit
        // reason about width directly instead of pattern-matching the
        // shift pair at allocation time.
        if op == BinOp::Shr
            && let Some(kind) = sign_narrow_kind(rhs_imm)
            && let Some(&Inst::BinopI {
                op: BinOp::Shl,
                lhs: inner,
                rhs_imm: shl_k,
            }) = self.func.insts.get(lhs as usize)
            && shl_k == rhs_imm
        {
            return self.extend(inner, kind);
        }
        // Mul by a positive power of two collapses to a left shift.
        // Two's-complement arithmetic makes `x * 2^K` and `x << K`
        // produce the same 64-bit bit pattern for signed and
        // unsigned operands alike. The shift form lowers to a
        // single-cycle instruction on every target (`lsl` on
        // AArch64, `shl` on x86_64) instead of the multi-cycle
        // `mul` / `imul`. K is bounded by 62 so the i64 stays
        // positive and the shift amount stays inside the 6-bit
        // encoding the per-arch BinopI emit accepts.
        if op == BinOp::Mul && rhs_imm > 0 && (rhs_imm as u64).is_power_of_two() {
            let k = rhs_imm.trailing_zeros() as i64;
            if k < 64 {
                return self.binop_imm(BinOp::Shl, lhs, k);
            }
        }
        // `And` with a mask whose low N bits are all set is a
        // no-op when the lhs is an unsigned-narrow load that
        // already zero-extended to 64 bits: a U8/U16/U32 load
        // clears the top 64-N bits, so ANDing back through a
        // mask that covers those low bits preserves the value.
        // Surfaces from `(u8/u16/u32) == 0` after the C99
        // 6.3.1.1 integer promotion's implicit cast.
        if op == BinOp::And {
            let load_width = match self.func.insts.get(lhs as usize) {
                Some(Inst::Load {
                    kind: LoadKind::U8, ..
                })
                | Some(Inst::LoadLocal {
                    kind: LoadKind::U8, ..
                })
                | Some(Inst::LoadIndexed {
                    kind: LoadKind::U8, ..
                }) => Some(8u32),
                Some(Inst::Load {
                    kind: LoadKind::U16,
                    ..
                })
                | Some(Inst::LoadLocal {
                    kind: LoadKind::U16,
                    ..
                })
                | Some(Inst::LoadIndexed {
                    kind: LoadKind::U16,
                    ..
                }) => Some(16u32),
                Some(Inst::Load {
                    kind: LoadKind::U32,
                    ..
                })
                | Some(Inst::LoadLocal {
                    kind: LoadKind::U32,
                    ..
                })
                | Some(Inst::LoadIndexed {
                    kind: LoadKind::U32,
                    ..
                }) => Some(32u32),
                _ => None,
            };
            if let Some(width) = load_width {
                let coverage_mask: u64 = if width >= 64 { !0 } else { (1u64 << width) - 1 };
                if (rhs_imm as u64) & coverage_mask == coverage_mask {
                    return lhs;
                }
            }
        }
        if let Some(&Inst::BinopI {
            op: inner_op,
            lhs: inner_lhs,
            rhs_imm: inner_imm,
        }) = self.func.insts.get(lhs as usize)
        {
            let folded: Option<(BinOp, i64)> = match (inner_op, op) {
                (BinOp::Add, BinOp::Add) => Some((BinOp::Add, inner_imm.wrapping_add(rhs_imm))),
                (BinOp::Add, BinOp::Sub) => Some((BinOp::Add, inner_imm.wrapping_sub(rhs_imm))),
                (BinOp::Sub, BinOp::Add) => Some((BinOp::Add, rhs_imm.wrapping_sub(inner_imm))),
                (BinOp::Sub, BinOp::Sub) => Some((BinOp::Sub, inner_imm.wrapping_add(rhs_imm))),
                (BinOp::And, BinOp::And) => Some((BinOp::And, inner_imm & rhs_imm)),
                (BinOp::Or, BinOp::Or) => Some((BinOp::Or, inner_imm | rhs_imm)),
                (BinOp::Xor, BinOp::Xor) => Some((BinOp::Xor, inner_imm ^ rhs_imm)),
                _ => None,
            };
            if let Some((folded_op, folded_imm)) = folded {
                return self.binop_imm(folded_op, inner_lhs, folded_imm);
            }
        }
        let key = PureKey::BinopI { op, lhs, rhs_imm };
        if let Some(cached) = self.lookup_pure(key) {
            return cached;
        }
        let id = self.push(Inst::BinopI { op, lhs, rhs_imm });
        self.pure_cache.insert(key, id);
        id
    }

    /// `Inst::Fma` -- fused multiply-add `(neg_product ? -(a*b) : a*b)
    /// + (neg_addend ? -c : c)`, rounded once. Emitted for an explicit
    /// `fma` / `fmaf` intrinsic call; the optimizer's contraction pass
    /// produces the same node directly from a multiply feeding an
    /// add/sub. The caller marks the result f32 for `fmaf`.
    pub(crate) fn fma(
        &mut self,
        a: ValueId,
        b: ValueId,
        c: ValueId,
        neg_product: bool,
        neg_addend: bool,
    ) -> ValueId {
        self.push(Inst::Fma {
            a,
            b,
            c,
            neg_product,
            neg_addend,
        })
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

    /// `Inst::Extend` -- sign-extend the low `kind`-width bits of
    /// `value` to 64 bits. `kind` is a signed narrow load kind
    /// (`I8`, `I16`, `I32`). A constant operand folds to the
    /// sign-extended constant. See [`Inst::Extend`].
    pub(crate) fn extend(&mut self, value: ValueId, kind: LoadKind) -> ValueId {
        let bits = match kind {
            LoadKind::I8 => 8,
            LoadKind::I16 => 16,
            LoadKind::I32 => 32,
            _ => 64,
        };
        if bits < 64
            && let Some(k) = self.peek_imm(value)
        {
            let shift = 64 - bits;
            return self.imm((k << shift) >> shift);
        }
        let key = PureKey::Extend { value, kind };
        if let Some(cached) = self.lookup_pure(key) {
            return cached;
        }
        let id = self.push(Inst::Extend { value, kind });
        self.pure_cache.insert(key, id);
        id
    }

    /// `Inst::FpCast`. Pure value; same input + same kind ->
    /// same output. CSE-eligible. The f32-ness of the result is set
    /// from `kind`: `F64ToF32` and `IntToFp`-to-float callers mark via
    /// the dedicated [`Self::fp_narrow`] / [`Self::mark_f32`] helpers;
    /// `F32ToF64` clears it.
    pub(crate) fn fp_cast(&mut self, kind: FpCastKind, value: ValueId) -> ValueId {
        let key = PureKey::FpCast { kind, value };
        if let Some(cached) = self.lookup_pure(key) {
            return cached;
        }
        let id = self.push(Inst::FpCast { kind, value });
        self.pure_cache.insert(key, id);
        id
    }

    /// Widen a single-precision value to double (C99 6.3.1.5). If
    /// `value` is not actually f32 (already double), returns it
    /// unchanged. The result is double (not f32-marked).
    pub(crate) fn fp_widen_to_f64(&mut self, value: ValueId) -> ValueId {
        if !self.is_f32(value) {
            return value;
        }
        self.fp_cast(FpCastKind::F32ToF64, value)
    }

    /// Narrow a double-precision value to single (C99 6.3.1.5). If
    /// `value` is already f32, returns it unchanged. The result is
    /// f32-marked.
    pub(crate) fn fp_narrow_to_f32(&mut self, value: ValueId) -> ValueId {
        if self.is_f32(value) {
            return value;
        }
        let id = self.fp_cast(FpCastKind::F64ToF32, value);
        self.mark_f32(id)
    }

    /// `Inst::Call` -- direct user-function call. Callees may
    /// write through any pointer they receive (including ones
    /// derived from local addresses that escaped earlier in the
    /// caller), so every CSE entry invalidates.
    pub(crate) fn call(
        &mut self,
        target_pc: usize,
        args: Vec<ValueId>,
        fixed_args: usize,
        fp_return: bool,
        fp_arg_mask: u32,
    ) -> ValueId {
        self.local_cache.clear();
        self.push(Inst::Call {
            target_pc,
            args,
            fixed_args,
            fp_return,
            fp_arg_mask,
            arg_aggs: alloc::vec::Vec::new(),
            ret_agg: None,
            ret_slot_local: 0,
        })
    }

    /// `Inst::Call` whose `target_pc` is 0 because the callee
    /// lives in another translation unit. Records the parser-
    /// symbol index in `extern_call_refs` so the linker can
    /// resolve to the merged ent_pc after symbol unification.
    pub(crate) fn call_extern(
        &mut self,
        sym_idx: u32,
        args: Vec<ValueId>,
        fixed_args: usize,
        fp_return: bool,
        fp_arg_mask: u32,
    ) -> ValueId {
        self.local_cache.clear();
        let v = self.push(Inst::Call {
            target_pc: 0,
            args,
            fixed_args,
            fp_return,
            fp_arg_mask,
            arg_aggs: alloc::vec::Vec::new(),
            ret_agg: None,
            ret_slot_local: 0,
        });
        self.func.extern_call_refs.push((v, sym_idx));
        v
    }

    /// `Inst::CallIndirect` -- function-pointer call.
    pub(crate) fn call_indirect(
        &mut self,
        target: ValueId,
        args: Vec<ValueId>,
        callee_variadic: bool,
        fixed_args: usize,
        fp_return: bool,
        fp_arg_mask: u32,
    ) -> ValueId {
        self.local_cache.clear();
        self.push(Inst::CallIndirect {
            target,
            args,
            callee_variadic,
            fixed_args,
            fp_return,
            fp_arg_mask,
            arg_aggs: alloc::vec::Vec::new(),
            ret_agg: None,
            ret_slot_local: 0,
        })
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

    /// `Inst::AtomicRmw` -- atomic read-modify-write on the `width`-byte
    /// object at `addr` (C11 7.17.7). Returns the inst's id; its value
    /// is the object's prior contents. Atomics are not pure and must
    /// not be CSE'd, and they write through `addr` (which may alias an
    /// escaped local), so the CSE cache is invalidated.
    pub(crate) fn atomic_rmw(
        &mut self,
        op: AtomicRmwOp,
        addr: ValueId,
        value: ValueId,
        width: u8,
    ) -> ValueId {
        self.local_cache.clear();
        self.push(Inst::AtomicRmw {
            op,
            addr,
            value,
            width,
        })
    }

    /// `Inst::AtomicCas` -- atomic compare-and-exchange on the
    /// `width`-byte object at `addr` (C11 7.17.7.4). Returns the inst's
    /// id; its value is 1 on success and 0 on failure, where a failure
    /// stores the current `*addr` into `*expected_addr`. Writes through
    /// both pointers, so the CSE cache is invalidated.
    pub(crate) fn atomic_cas(
        &mut self,
        addr: ValueId,
        expected_addr: ValueId,
        desired: ValueId,
        width: u8,
    ) -> ValueId {
        self.local_cache.clear();
        self.push(Inst::AtomicCas {
            addr,
            expected_addr,
            desired,
            width,
        })
    }

    /// `Inst::Intrinsic` -- compiler-builtin (alloca / setjmp /
    /// longjmp / va_*). The `kind` is the discriminant from
    /// `crate::c5::op::Intrinsic`; the per-arch SSA emit reads it
    /// to pick the right lowering. Conservative: invalidate the
    /// CSE cache -- setjmp / longjmp move control across the
    /// block, va_start / va_arg may write through caller buffers.
    pub(crate) fn intrinsic(&mut self, kind: i64, args: Vec<ValueId>) -> ValueId {
        self.local_cache.clear();
        let id = self.push(Inst::Intrinsic { kind, args });
        if super::reg_alloc::is_setjmp_barrier(&self.func.insts[id as usize]) {
            self.func.has_returns_twice_call = true;
        }
        id
    }

    /// Record that the function calls a returns-twice function (the
    /// setjmp family / vfork). See
    /// [`FunctionSsa::has_returns_twice_call`].
    pub(crate) fn mark_returns_twice(&mut self) {
        self.func.has_returns_twice_call = true;
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

    /// Reserve `ceil(size/8)` contiguous 8-byte slots and return the
    /// base (most-negative) slot, whose address is the lowest of the
    /// group. A whole-struct `Mcpy` from that address covers the
    /// reserved bytes. Used for an aggregate result temporary.
    pub(crate) fn alloc_synthetic_struct(&mut self, size: i64) -> i64 {
        let nslots = (size + 7) / 8;
        let mut base = 0;
        for k in 0..nslots {
            let s = self.alloc_synthetic_local();
            if k == nslots - 1 {
                base = s;
            }
        }
        // Record the multi-cell range so slot coalescing reserves the
        // interior cells, which carry no instruction reference.
        if nslots >= 1 {
            self.func.multi_cell_slots.push((base, nslots));
        }
        base
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
        fp_return: bool,
    ) -> ValueId {
        self.local_cache.clear();
        self.push(Inst::CallExt {
            binding_idx,
            args,
            fp_arg_mask,
            fp_return,
            arg_aggs: alloc::vec::Vec::new(),
            ret_agg: None,
            ret_slot_local: 0,
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

/// Map the right-shift amount `K` of a signed sign-narrow `Shl K;
/// Shr K` pair to the equivalent `Inst::Extend` kind: `K = 64 -
/// width_bits`, so 32 -> I32, 48 -> I16, 56 -> I8. Other amounts are
/// genuine shifts (or sub-word bitfield extractions) and are left
/// alone.
fn sign_narrow_kind(k: i64) -> Option<LoadKind> {
    match k {
        32 => Some(LoadKind::I32),
        48 => Some(LoadKind::I16),
        56 => Some(LoadKind::I8),
        _ => None,
    }
}

/// Evaluate `(k1 op k2)` when both operands are known constants.
/// Returns `Some(value)` for an integer-result op, or `None` for
/// undefined / floating-point cases the caller must keep as a
/// runtime instruction. Integer arithmetic wraps in 64 bits to
/// mirror the SSA value model.
fn fold_int_binop_imm(op: BinOp, k1: i64, k2: i64) -> Option<i64> {
    use BinOp::*;
    match op {
        Add => Some(k1.wrapping_add(k2)),
        Sub => Some(k1.wrapping_sub(k2)),
        Mul => Some(k1.wrapping_mul(k2)),
        And => Some(k1 & k2),
        Or => Some(k1 | k2),
        Xor => Some(k1 ^ k2),
        Shl if (0..64).contains(&k2) => Some(((k1 as u64).wrapping_shl(k2 as u32)) as i64),
        Shr if (0..64).contains(&k2) => Some(k1 >> k2),
        Shru if (0..64).contains(&k2) => Some(((k1 as u64) >> k2) as i64),
        Ror if (0..64).contains(&k2) => Some((k1 as u64).rotate_right(k2 as u32) as i64),
        Eq => Some(if k1 == k2 { 1 } else { 0 }),
        Ne => Some(if k1 != k2 { 1 } else { 0 }),
        Lt => Some(if k1 < k2 { 1 } else { 0 }),
        Gt => Some(if k1 > k2 { 1 } else { 0 }),
        Le => Some(if k1 <= k2 { 1 } else { 0 }),
        Ge => Some(if k1 >= k2 { 1 } else { 0 }),
        Ult => Some(if (k1 as u64) < (k2 as u64) { 1 } else { 0 }),
        Ugt => Some(if (k1 as u64) > (k2 as u64) { 1 } else { 0 }),
        Ule => Some(if (k1 as u64) <= (k2 as u64) { 1 } else { 0 }),
        Uge => Some(if (k1 as u64) >= (k2 as u64) { 1 } else { 0 }),
        Div if k2 != 0 && !(k1 == i64::MIN && k2 == -1) => Some(k1 / k2),
        Mod if k2 != 0 && !(k1 == i64::MIN && k2 == -1) => Some(k1 % k2),
        Divu if k2 != 0 => Some(((k1 as u64) / (k2 as u64)) as i64),
        Modu if k2 != 0 => Some(((k1 as u64) % (k2 as u64)) as i64),
        _ => None,
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
        let v_call1 = b.call(fake_ent_pc, alloc::vec![v_n_minus_1], 1, false, 0);
        let v_n2 = b.load_local(2, LoadKind::I32);
        let v_n_minus_2 = b.binop_imm(BinOp::Sub, v_n2, 2);
        let v_call2 = b.call(fake_ent_pc, alloc::vec![v_n_minus_2], 1, false, 0);
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
            let alloc = super::super::reg_alloc::allocate(&func, target);
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
            let alloc = super::super::reg_alloc::allocate(&func, target);
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
        let _ = b.call(0, alloc::vec![], 0, false, 0);
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

    /// The signed sign-narrow idiom `Shl K; Shr K` (arithmetic right
    /// shift) canonicalizes to one `Inst::Extend` for the load-kind
    /// widths (K = 32 / 48 / 56). The inner `Shl` survives as a dead
    /// pure inst the allocator's DCE drops.
    #[test]
    fn shl_shr_pair_canonicalizes_to_extend() {
        for (k, kind) in [(32, LoadKind::I32), (48, LoadKind::I16), (56, LoadKind::I8)] {
            let mut b = SsaBuilder::new(0, 1, false);
            let v = b.load_local(2, LoadKind::I64);
            let shl = b.binop_imm(BinOp::Shl, v, k);
            let res = b.binop_imm(BinOp::Shr, shl, k);
            b.return_(res);
            let func = b.finish();
            assert!(
                matches!(func.insts[res as usize], Inst::Extend { value, kind: rk }
                    if value == v && rk == kind),
                "Shr(Shl(v,{k}),{k}) must become Extend{{v, {kind:?}}}, got {:?}",
                func.insts[res as usize],
            );
        }
    }

    /// A logical right shift (`Shru`) is a zero-extend, not the signed
    /// sign-narrow, and stays a shift; an unequal shift amount (a
    /// sub-word bitfield extraction) also stays a shift.
    #[test]
    fn non_signed_narrow_shifts_stay_shifts() {
        let mut b = SsaBuilder::new(0, 1, false);
        let v = b.load_local(2, LoadKind::I64);
        let shl32 = b.binop_imm(BinOp::Shl, v, 32);
        let shru = b.binop_imm(BinOp::Shru, shl32, 32);
        let shl40 = b.binop_imm(BinOp::Shl, v, 40);
        let uneven = b.binop_imm(BinOp::Shr, shl40, 40);
        let both = b.binop(BinOp::Add, shru, uneven);
        b.return_(both);
        let func = b.finish();
        assert!(matches!(
            func.insts[shru as usize],
            Inst::BinopI {
                op: BinOp::Shru,
                ..
            }
        ));
        assert!(matches!(
            func.insts[uneven as usize],
            Inst::BinopI { op: BinOp::Shr, .. }
        ));
    }
}
