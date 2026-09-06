//! The function entry sequence: the frame, the return convention and
//! the incoming parameters (C99 6.9.1).

use super::types::is_floating_scalar;
use super::*;
use crate::c5::codegen::{ArgAgg, CallConv, CallPlan, abi_classify};
use crate::c5::compiler::{StructDef, StructReturnAbi};

/// Run a per-function AST through `SsaBuilder`. `n_params` and
/// `is_variadic` come from the declarator and `n_locals` is the
/// post-parse slot count. `ent_pc` is the function's entry identifier,
/// threaded through the SSA emit so the post-link codegen resolves
/// call-site fixups against the identifier the linker rebased.
pub(crate) fn walk_function(
    fun: &FinishedFunction,
    symbols: &[Symbol],
    structs: &[StructDef],
    target: Target,
    optimize: bool,
    jump_tables: bool,
) -> Result<FunctionSsa, WalkError> {
    let ast = &fun.ast;
    let mut b = SsaBuilder::new(fun.ent_pc, fun.n_params, fun.is_variadic);
    b.set_conv(fun.conv);
    b.set_end_pc(fun.end_pc);
    b.set_ssp(fun.ssp);
    // Only at -O, where `passes::divmod_pair` folds the split back when
    // the quotient stays unshared.
    b.set_split_modulo(optimize);
    place_over_aligned_slots(&mut b, &fun.over_aligned_slots, fun.alloca_top_slot)?;
    // C99 6.8: the frame holds the declared locals, alloca and VLA
    // storage being carved from the stack at runtime. With alloca the
    // parser's Ent patch appends one reserved slot.
    let effective_locals = if fun.alloca_top_slot > 0 {
        fun.alloca_top_slot
    } else {
        fun.n_locals
    };
    if effective_locals != 0 {
        b.set_locals(effective_locals);
    }
    // A non-zero `alloca_top_slot` marks the function dynamic-sp for the
    // codegen: spill slots move to fp-based addressing and the epilogue
    // re-establishes sp.
    b.alloca_init(fun.alloca_top_slot);
    let ret = ReturnAbi::classify(&mut b, structs, target, fun.conv, fun.return_ty);
    let entry = ParamEntry::plan(&mut b, fun, structs, target, ret.outptr);
    entry.seed_param_refs(&mut b);
    entry.emit_entry_copies(&mut b);
    let mut ctx = Walker {
        ast,
        symbols,
        structs,
        target,
        loop_ctx: alloc::vec::Vec::new(),
        label_blocks: alloc::vec![None; ast.goto_targets.len()],
        switch_dispatch: alloc::vec::Vec::new(),
        returns_struct: fun.returns_struct,
        return_struct_size: fun.return_struct_size,
        ret_in_regs: ret.in_regs,
        ret_indirect: ret.indirect,
        indirect_result_slot: ret.indirect_result_slot,
        scalar_return_ty: fun.return_ty,
        optimize,
        jump_tables,
    };
    let terminated = match ast.body {
        Some(root) => ctx.walk_stmt(&mut b, root)?,
        None => false,
    };
    // A body that fell off the end leaves the current block open; close it
    // with `return 0` per C99 5.1.2.2.3.
    if !terminated && b.is_block_open() {
        let zero = b.imm(0);
        b.return_(zero);
    }
    // Bind each `&&label` element of this function's static
    // initializers to the label's block, which records the block as
    // address-taken. Runs before the dead-block close, so a block
    // allocated here is closed too.
    for r in &fun.label_data_slots {
        let block = ctx.block_for_label(&mut b, r.label);
        b.label_data_block(r.data_offset, block);
    }
    b.close_dead_blocks();
    Ok(b.finish())
}

/// C11 6.7.5: an automatic object whose alignment exceeds the 8-byte
/// frame slot lives in a packed region, widest alignment first, that
/// every backend addresses as `region_base + region_off`. At
/// `frame_align` 16 the region sits at a static frame offset; above 16
/// the prologue realigns sp, which `alloca` precludes.
fn place_over_aligned_slots(
    b: &mut SsaBuilder,
    slots: &[(i64, i64, i64)],
    alloca_top_slot: i64,
) -> Result<(), WalkError> {
    if slots.is_empty() {
        return Ok(());
    }
    let mut items: alloc::vec::Vec<(i64, i64, i64)> = slots.to_vec();
    items.sort_by_key(|&(_, align, _)| core::cmp::Reverse(align));
    let mut frame_align: i64 = 16;
    let mut cursor: i64 = 0;
    let mut placed: alloc::vec::Vec<(i64, i64)> = alloc::vec::Vec::new();
    for (slot, align, size) in items {
        frame_align = frame_align.max(align);
        cursor = (cursor + align - 1) & -align;
        placed.push((slot, cursor));
        cursor += size;
    }
    if frame_align > 16 && alloca_top_slot != 0 {
        return Err(WalkError::Unsupported(
            "an automatic object aligned above 16 cannot share a function with alloca/VLA",
        ));
    }
    let region_bytes = (cursor + frame_align - 1) & -frame_align;
    b.set_realign(placed, frame_align, region_bytes);
    Ok(())
}

/// How a definition returns its value (C99 6.8.6.4 + the host ABI).
struct ReturnAbi {
    /// The c5 out-pointer convention: the caller passes the result
    /// address in argument cell 2, so declared parameters start at 3.
    outptr: bool,
    /// An aggregate of at most 16 bytes returned in the result registers,
    /// with no hidden argument.
    in_regs: bool,
    /// A larger aggregate returned through the caller-supplied
    /// indirect-result register, also with no hidden argument.
    indirect: bool,
    /// Body-local slot holding the saved indirect-result pointer for the
    /// codegen prologue; zero when the return is not indirect.
    indirect_result_slot: i64,
}

impl ReturnAbi {
    fn classify(
        b: &mut SsaBuilder,
        structs: &[StructDef],
        target: Target,
        conv: CallConv,
        return_ty: i64,
    ) -> Self {
        let abi = crate::c5::compiler::struct_return_abi_conv(structs, target, conv, return_ty);
        if let StructReturnAbi::Regs(desc) | StructReturnAbi::Indirect(desc) = &abi {
            let idx = b.intern_agg_desc(desc.clone());
            b.set_ret_agg(idx);
        }
        b.set_ret_is_fp(is_floating_scalar(return_ty));
        b.set_ret_type_tag(return_ty);
        let indirect = matches!(abi, StructReturnAbi::Indirect(_));
        let indirect_result_slot = if indirect {
            let slot = b.alloc_synthetic_local();
            b.set_indirect_result_slot(slot);
            slot
        } else {
            0
        };
        Self {
            outptr: matches!(abi, StructReturnAbi::OutPtr),
            in_regs: matches!(abi, StructReturnAbi::Regs(_)),
            indirect,
            indirect_result_slot,
        }
    }
}

/// Where each declared parameter arrives and which frame slot the body
/// reads it from (C99 6.5.2.2 + the host ABI).
struct ParamEntry<'a> {
    structs: &'a [StructDef],
    param_tys: &'a [i64],
    param_local_slots: &'a [i64],
    /// True when the definition takes its parameters under the host ABI.
    /// A variadic or out-pointer-returning definition keeps the c5 cdecl
    /// shape instead, its arguments riding the c5 stack or shifted by
    /// the hidden out-pointer.
    host_abi: bool,
    /// Argument cell of the first declared parameter: 2, or 3 when the
    /// hidden out-pointer takes cell 2. The parser assigned each
    /// parameter symbol's `val` from the same base.
    arg_slot_base: i64,
    /// Interned aggregate descriptor per parameter the host ABI passes by
    /// value in registers; empty when none does.
    aggs: alloc::vec::Vec<Option<u32>>,
    /// Where the ABI places each parameter.
    plan: CallPlan,
}

impl<'a> ParamEntry<'a> {
    /// Classify the parameters and record the classification on the
    /// builder, so the callee emit resolves each incoming register through
    /// the same planner the caller uses.
    fn plan(
        b: &mut SsaBuilder,
        fun: &'a FinishedFunction,
        structs: &'a [StructDef],
        target: Target,
        ret_outptr: bool,
    ) -> Self {
        // Every ABI question about this definition is asked of the
        // convention it declares. Layout queries keep the real target,
        // scalar widths being the target's property, not the
        // convention's.
        let abi_target = target.abi_row(fun.conv);
        let param_tys = &fun.param_tys[..];
        let host_abi = !fun.is_variadic && !ret_outptr;
        // A small aggregate parameter arrives in argument registers
        // rather than by the caller's address (AAPCS64 6.8.2), and takes
        // no SSA entry copy: the backend writes the incoming bytes
        // straight into the parser-reserved body local.
        let mut aggs: alloc::vec::Vec<Option<u32>> = alloc::vec::Vec::new();
        // Parallel classification for the argument-register planner, so
        // the seed loop below knows which scalar parameters an aggregate
        // pushed past the argument registers onto the host stack.
        let mut arg_aggs: alloc::vec::Vec<Option<ArgAgg>> = alloc::vec::Vec::new();
        if host_abi {
            aggs = alloc::vec![None; param_tys.len()];
            arg_aggs = alloc::vec![None; param_tys.len()];
            for (i, &pty) in param_tys.iter().enumerate() {
                if let Some(desc) =
                    crate::c5::compiler::host_abi_agg_desc_conv(structs, target, fun.conv, pty)
                {
                    arg_aggs[i] = Some(ArgAgg {
                        class: abi_classify::classify_aggregate(
                            desc.size,
                            desc.align,
                            &desc.fields,
                            target.abi(),
                            false,
                        ),
                        size: desc.size,
                        align: desc.align,
                    });
                    let idx = b.intern_agg_desc(desc);
                    aggs[i] = Some(idx);
                }
            }
        }
        if aggs.iter().any(Option::is_some) {
            b.set_param_aggs(aggs.clone(), fun.param_local_slots.to_vec());
        }
        if host_abi {
            // C99 6.2.5p10 with System V AMD64 3.2.3 / AAPCS64 6.4.1: a
            // floating-point scalar parameter arrives in an FP argument
            // register, the banks being independent.
            for (i, &pty) in param_tys.iter().enumerate() {
                let stripped = strip_unsigned(pty);
                if stripped == Ty::Float as i64 || stripped == Ty::Double as i64 {
                    b.mark_param_fp(i);
                }
            }
            // The c5 cdecl cell layout requires a contiguous register
            // prefix, so a placement interleaving register and
            // host-stack parameters clears the mask and falls back to
            // the all-integer ABI, as the caller's own predicate does.
            let eff = effective_fp_arg_mask(param_tys.len(), b.param_fp_mask(), abi_target.abi());
            b.set_param_fp_mask(eff);
        }
        let plan = plan_param_regs_aggs(
            param_tys.len(),
            b.param_fp_mask(),
            abi_target.abi(),
            &arg_aggs,
        );
        Self {
            structs,
            param_tys,
            param_local_slots: &fun.param_local_slots,
            host_abi,
            arg_slot_base: if ret_outptr { 3 } else { 2 },
            aggs,
            plan,
        }
    }

    /// True when the plan placed parameter `i` in an FP argument register.
    /// One that overflowed to the host stack reads its c5 cdecl cell.
    fn in_fp_reg(&self, i: usize) -> bool {
        matches!(self.plan.placements.get(i), Some(ArgPlacement::FpReg(_)))
    }

    /// Seed each register-passed scalar parameter's c5 argument cell
    /// with a `ParamRef` + `StoreLocal`, giving mem2reg one reaching def
    /// so the body's reads fold onto the incoming register.
    ///
    /// Runs before `emit_entry_copies`, so each `ParamRef` reads its
    /// host argument register while it still holds the caller's value:
    /// an entry mcpy's scratch writes can land on any caller-saved
    /// register, an argument register included.
    fn seed_param_refs(&self, b: &mut SsaBuilder) {
        if !self.host_abi {
            return;
        }
        for i in 0..self.param_tys.len() {
            let pty = self.param_tys[i];
            if self.param_local_slots[i] < 0 {
                continue;
            }
            let stripped = strip_unsigned(pty);
            if is_struct_value_ty(pty) {
                continue;
            }
            // A `double` keeps its positive cell and takes an FP
            // `ParamRef`. The parser repointed a `float` to a negative
            // narrow-storage local, skipped above, which
            // `emit_entry_copies` narrows into.
            if stripped == Ty::Double as i64 {
                if self.in_fp_reg(i) {
                    let arg_slot = (i as i64) + self.arg_slot_base;
                    let pr = b.param_ref(i as u32, LoadKind::F64);
                    b.store_local(arg_slot, pr, StoreKind::F64);
                }
                continue;
            }
            if stripped == Ty::Float as i64 {
                continue;
            }
            // Only where the planner placed an integer argument
            // register: an earlier aggregate can consume several,
            // pushing a later scalar that would fit by position onto the
            // host stack, where it is read through its parameter slot.
            if !matches!(self.plan.placements.get(i), Some(ArgPlacement::IntReg(_))) {
                continue;
            }
            // An unsigned-tagged parameter keeps the full 8-byte access,
            // so the body's zero-extending reads see the caller's
            // extension and not a sign-extended narrow reload.
            let (store_kind, load_kind) = if pty & UNSIGNED_BIT != 0 {
                (StoreKind::I64, LoadKind::I64)
            } else {
                match stripped {
                    s if s == Ty::Char as i64 => (StoreKind::I8, LoadKind::I8),
                    s if s == Ty::Short as i64 => (StoreKind::I16, LoadKind::I16),
                    s if s == Ty::Int as i64 => (StoreKind::I32, LoadKind::I32),
                    _ => (StoreKind::I64, LoadKind::I64),
                }
            };
            let arg_slot = (i as i64) + self.arg_slot_base;
            let pr = b.param_ref(i as u32, load_kind);
            b.store_local(arg_slot, pr, store_kind);
        }
    }

    /// Copy each by-address aggregate parameter into the body local the
    /// parser reserved for it -- the c5 convention passes the source's
    /// address in the parameter's argument cell -- and narrow each
    /// `float` parameter into its narrow-storage local. A negative
    /// `param_local_slots` entry marks both kinds.
    fn emit_entry_copies(&self, b: &mut SsaBuilder) {
        for i in 0..self.param_tys.len() {
            let pty = self.param_tys[i];
            let local_slot = self.param_local_slots[i];
            if local_slot >= 0 {
                continue;
            }
            let stripped = strip_unsigned(pty);
            let arg_slot = (i as i64) + self.arg_slot_base;
            if is_struct_value_ty(pty) {
                // A host-ABI register-passed aggregate takes no entry
                // copy: the backend writes the incoming registers
                // straight into this body local.
                if self.aggs.get(i).copied().flatten().is_some() {
                    continue;
                }
                let id = ((stripped - STRUCT_BASE) / STRUCT_STRIDE) as usize;
                if id >= self.structs.len() {
                    continue;
                }
                let size = self.structs[id].size as i64;
                let align = self.structs[id].align.max(1) as u32;
                let dst = b.local_addr(local_slot);
                let src = b.load_local(arg_slot, LoadKind::I64);
                b.mcpy(dst, src, size, align);
                continue;
            }
            if stripped != Ty::Float as i64 {
                continue;
            }
            if self.host_abi && self.in_fp_reg(i) {
                // The argument arrives at single precision in an FP
                // argument register (C99 6.2.5p10) and never
                // round-trips through the positive c5 cdecl cell, whose
                // spill the prologue then elides.
                let pr = b.param_ref(i as u32, LoadKind::F32);
                b.mark_f32(pr);
                b.store_local(local_slot, pr, StoreKind::F32);
            } else if b.param_fp_mask() != 0 {
                // Host-stack-overflow `float` under the FP-register ABI:
                // the caller pushed it at single precision into the c5
                // cdecl cell. Read the cell as `F32` and narrow back.
                let val = b.load_local(arg_slot, LoadKind::F32);
                b.store_local(local_slot, val, StoreKind::F32);
            } else {
                // The c5 cdecl shape: the caller widened the `float` to an
                // 8-byte double in the integer-passed cell. Read the cell
                // as I64, preserving the bit pattern, and narrow back.
                let val = b.load_local(arg_slot, LoadKind::I64);
                b.store_local(local_slot, val, StoreKind::F32);
            }
        }
    }
}
