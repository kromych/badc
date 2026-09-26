//! The function entry sequence: the frame, the return convention and
//! the incoming parameters (C99 6.9.1).

use super::access::{load_kind_for, seg_copy_bytes, store_kind_for};
use super::types::{arg_width, is_floating_scalar};
use super::*;
use crate::c5::codegen::{ArgAgg, CallConv, CallPlan};
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
    // the quotient stays unshared and `passes::divmod_const` expands the
    // deferred constant divides.
    b.set_split_modulo(optimize);
    b.set_defer_divmod(optimize);
    for &(slot, align, size) in &fun.over_aligned_slots {
        b.add_region_member(slot, align, size);
    }
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
        scopes: alloc::vec::Vec::new(),
        label_scopes: alloc::vec::Vec::new(),
        label_blocks: alloc::vec![None; ast.goto_targets.len()],
        cleanup_exits: alloc::collections::BTreeMap::new(),
        switch_dispatch: alloc::vec::Vec::new(),
        returns_struct: fun.returns_struct,
        return_struct_size: fun.return_struct_size,
        ret_in_regs: ret.in_regs,
        ret_indirect: ret.indirect,
        indirect_result_slot: ret.indirect_result_slot,
        scalar_return_ty: fun.return_ty,
        returns_no_value: is_void_ty(fun.return_ty) && fun.name != "main",
        optimize,
        jump_tables,
    };
    let terminated = match ast.body {
        Some(root) => {
            ctx.label_scopes = ctx.label_scope_chains(root);
            ctx.walk_stmt(&mut b, root)?
        }
        None => false,
    };
    // A body that fell off the end leaves the current block open.
    if !terminated && b.is_block_open() {
        ctx.return_without_value(&mut b);
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
    // C11 6.7.5: an automatic object whose alignment exceeds the 8-byte
    // frame slot, declared or a temporary, lives in a packed region that
    // every backend addresses as `region_base + region_off`. At
    // `frame_align` 16 the region sits at a static frame offset; above 16
    // the prologue realigns sp, which `alloca` precludes.
    if b.place_region_members() > 16 && fun.alloca_top_slot != 0 {
        return Err(WalkError::Unsupported(
            "an automatic object aligned above 16 cannot share a function with alloca/VLA",
        ));
    }
    Ok(b.finish())
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
        let agg = matches!(abi, StructReturnAbi::Regs(_) | StructReturnAbi::Indirect(_));
        if let StructReturnAbi::Regs(desc) | StructReturnAbi::Indirect(desc) = &abi {
            let idx = b.intern_agg_desc(desc.clone());
            b.set_ret_agg(idx);
        }
        b.set_ret_is_fp(is_floating_scalar(return_ty) && !agg);
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
    /// [`FinishedFunction::param_arrival_tys`].
    arrival_tys: &'a [i64],
    param_local_slots: &'a [i64],
    /// True when the definition takes its parameters under the host ABI.
    /// A variadic or all-integer out-pointer definition keeps the c5 cdecl shape.
    host_abi: bool,
    /// Positions ahead of the first declared parameter: 1 for a hidden result pointer.
    shift: usize,
    /// Argument cell of the first declared parameter: 2, or 3 when the
    /// hidden out-pointer takes cell 2. The parser assigned each
    /// parameter symbol's `val` from the same base.
    arg_slot_base: i64,
    /// Interned aggregate descriptor per parameter the host ABI passes by
    /// value in registers; empty when none does.
    aggs: alloc::vec::Vec<Option<u32>>,
    /// Where the ABI places each parameter.
    plan: CallPlan,
    /// The target whose scalar widths the parameter homes take.
    target: Target,
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
        // System V AMD64 3.2.3 and Win64 pass the result address as integer argument 0.
        let hidden = ret_outptr
            && !fun.is_variadic
            && matches!(abi_target, Target::LinuxX64 | Target::WindowsX64);
        let shift = usize::from(hidden);
        b.set_n_params(shift + fun.n_params);
        let host_abi = !fun.is_variadic && (!ret_outptr || hidden);
        // A small aggregate parameter arrives in argument registers
        // rather than by the caller's address (AAPCS64 6.8.2), and takes
        // no SSA entry copy: the backend writes the incoming bytes
        // straight into the parser-reserved body local.
        let mut aggs: alloc::vec::Vec<Option<u32>> = alloc::vec::Vec::new();
        // Parallel classification for the argument-register planner, so
        // the seed loop below knows which scalar parameters an aggregate
        // pushed past the argument registers onto the host stack.
        let mut arg_aggs: alloc::vec::Vec<Option<ArgAgg>> = alloc::vec::Vec::new();
        if !ret_outptr || hidden {
            aggs = alloc::vec![None; shift + param_tys.len()];
            arg_aggs = alloc::vec![None; shift + param_tys.len()];
            for (i, &pty) in param_tys.iter().enumerate() {
                if let Some(desc) =
                    crate::c5::compiler::host_abi_agg_desc_conv(structs, target, fun.conv, pty)
                {
                    arg_aggs[shift + i] = Some(ArgAgg::new(&desc, abi_target.abi()));
                    let idx = b.intern_agg_desc(desc);
                    aggs[shift + i] = Some(idx);
                }
            }
        }
        if aggs.iter().any(Option::is_some) {
            let mut local_slots = alloc::vec![0; shift];
            local_slots.extend_from_slice(&fun.param_local_slots);
            b.set_param_aggs(aggs.clone(), local_slots);
        }
        // C99 6.2.5p10 with System V AMD64 3.2.3 / AAPCS64 6.4.2: a floating-point
        // parameter, a variadic callee's named one included, takes an FP register
        // unless the call passes every argument in the integer bank.
        let int_only =
            (ret_outptr && !hidden) || (fun.is_variadic && abi_target.abi().variadic_int_only);
        if !int_only {
            for (i, &pty) in param_tys.iter().enumerate() {
                let stripped = strip_unsigned(pty);
                let agg = arg_aggs.get(shift + i).is_some_and(Option::is_some);
                if (stripped == Ty::Float as i64 || stripped == Ty::Double as i64) && !agg {
                    b.mark_param_fp(shift + i);
                }
            }
        }
        let mut widths = crate::c5::ir::ArgWidths::default();
        for (i, &pty) in param_tys.iter().enumerate() {
            let arrives = fun.param_arrival_tys.get(i).copied().unwrap_or(pty);
            widths.set(shift + i, arg_width(arrives, target, false));
        }
        b.set_param_widths(widths);
        let plan = plan_param_regs_aggs(
            shift + param_tys.len(),
            b.param_fp_mask(),
            abi_target.abi(),
            &arg_aggs,
            widths,
        );
        Self {
            structs,
            param_tys,
            arrival_tys: &fun.param_arrival_tys,
            param_local_slots: &fun.param_local_slots,
            host_abi,
            arg_slot_base: if ret_outptr { 3 } else { 2 },
            shift,
            aggs,
            plan,
            target,
        }
    }

    /// True when the plan placed parameter `i` in an FP argument register.
    /// One that overflowed to the host stack reads its c5 cdecl cell.
    fn in_fp_reg(&self, i: usize) -> bool {
        matches!(
            self.plan.placements.get(self.shift + i),
            Some(ArgPlacement::FpReg(_))
        )
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
                    let pr = b.param_ref((self.shift + i) as u32, LoadKind::F64);
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
            if !matches!(
                self.plan.placements.get(self.shift + i),
                Some(ArgPlacement::IntReg(_))
            ) {
                continue;
            }
            // The home is written at the object's width, like the body's
            // own stores of it, so the slot has one store width. The entry
            // lowering sign-extends a narrow signed `ParamRef`; any other
            // takes the whole register, whose low bytes the loads read.
            let ref_kind = match load_kind_for(pty, self.target) {
                k @ (LoadKind::I8 | LoadKind::I16 | LoadKind::I32) => k,
                _ => LoadKind::I64,
            };
            let arg_slot = (i as i64) + self.arg_slot_base;
            let pr = b.param_ref((self.shift + i) as u32, ref_kind);
            b.store_local(arg_slot, pr, store_kind_for(pty, self.target));
        }
    }

    /// Copy each by-address aggregate parameter into the body local the
    /// parser reserved for it -- the c5 convention passes the source's
    /// address in the parameter's argument cell -- narrow each `float`
    /// parameter into its narrow-storage local, and widen each `long
    /// double` passed as binary64 into its local of the platform format. A
    /// negative `param_local_slots` entry marks all three kinds.
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
                if self.aggs.get(self.shift + i).copied().flatten().is_some() {
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
                if is_volatile_ty(pty) {
                    let none = AsmSeg::None;
                    seg_copy_bytes(b, dst, none, src, none, size, align, false, true);
                } else {
                    b.mcpy(dst, src, size, align);
                }
                continue;
            }
            if is_long_double_scalar(pty) {
                // One passed as its image arrives the way an aggregate does.
                if self.aggs.get(self.shift + i).copied().flatten().is_some() {
                    continue;
                }
                let val = if self.host_abi && self.in_fp_reg(i) {
                    b.param_ref((self.shift + i) as u32, LoadKind::F64)
                } else {
                    b.load_local(arg_slot, LoadKind::F64)
                };
                b.store_local(local_slot, val, store_kind_for(pty, self.target));
                continue;
            }
            if stripped != Ty::Float as i64 {
                continue;
            }
            let arrives = self
                .arrival_tys
                .get(i)
                .map_or(stripped, |&t| strip_unsigned(t));
            let kind = if arrives == Ty::Double as i64 {
                LoadKind::F64
            } else {
                LoadKind::F32
            };
            if self.host_abi && self.in_fp_reg(i) {
                // The argument arrives in an FP argument register (C99
                // 6.2.5p10) and never round-trips through the positive c5
                // cdecl cell, whose spill the prologue then elides.
                let pr = b.param_ref((self.shift + i) as u32, kind);
                let val = if kind == LoadKind::F32 {
                    b.mark_f32(pr)
                } else {
                    b.fp_narrow_to_f32(pr)
                };
                b.store_local(local_slot, val, StoreKind::F32);
            } else if !b.param_fp_mask().is_empty() {
                // Host-stack-overflow `float` under the FP-register ABI:
                // the caller pushed it into the c5 cdecl cell at the width
                // it arrives at.
                let val = b.load_local(arg_slot, kind);
                let val = if kind == LoadKind::F32 {
                    val
                } else {
                    b.fp_narrow_to_f32(val)
                };
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
