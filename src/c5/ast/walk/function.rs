//! The function entry sequence: the frame, the return convention and
//! the incoming parameters (C99 6.9.1).

use super::types::is_floating_scalar;
use super::*;

/// Run a per-function AST through `SsaBuilder` and return the
/// resulting `FunctionSsa`. `n_params` and `is_variadic` come from
/// the function's declarator; `n_locals` is the post-parse local
/// slot count (`max_loc_offs`). `ent_pc` is the function's entry
/// identifier -- the SSA emit threads it through so the
/// post-link codegen can resolve call-site fixups against the
/// same identifier the linker rebased.
pub(crate) fn walk_function(
    fun: &FinishedFunction,
    symbols: &[Symbol],
    structs: &[crate::c5::compiler::StructDef],
    target: Target,
    optimize: bool,
    jump_tables: bool,
) -> Result<FunctionSsa, WalkError> {
    let FinishedFunction {
        ast,
        ent_pc,
        end_pc,
        n_params,
        is_variadic,
        n_locals,
        param_tys,
        param_local_slots,
        returns_struct,
        return_struct_size,
        return_ty,
        alloca_top_slot,
        over_aligned_slots,
        ssp,
        conv,
        ..
    } = fun;
    let (ent_pc, end_pc, n_params) = (*ent_pc, *end_pc, *n_params);
    let (is_variadic, n_locals) = (*is_variadic, *n_locals);
    let (returns_struct, return_struct_size) = (*returns_struct, *return_struct_size);
    let (return_ty, alloca_top_slot) = (*return_ty, *alloca_top_slot);
    let mut b = SsaBuilder::new(ent_pc, n_params, is_variadic);
    b.set_conv(*conv);
    b.set_end_pc(end_pc);
    b.set_ssp(*ssp);
    // Only at -O, where `passes::divmod_pair` folds the split back when
    // the quotient stays unshared.
    b.set_split_modulo(optimize);
    // C11 6.7.5: automatic objects whose alignment exceeds the 8-byte frame
    // slot live in the over-aligned region. Pack them (widest alignment
    // first); every backend addresses these slots as `region_base +
    // region_off`. At `frame_align` 16 the region sits at a static frame
    // offset; above 16 the prologue realigns sp, which `alloca` precludes.
    if !over_aligned_slots.is_empty() {
        let mut items: alloc::vec::Vec<(i64, i64, i64)> = over_aligned_slots.to_vec();
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
    }
    // C99 6.8: the frame holds the declared locals; alloca / VLA
    // storage is carved from the stack at runtime (the per-arch
    // emit moves sp), so no extra slots are reserved for it. With
    // alloca the parser's Ent patch appends one reserved slot
    // (`alloca_top_slot = regular locals + 1`), which also covers
    // every regular slot.
    let effective_locals = if alloca_top_slot > 0 {
        alloca_top_slot
    } else {
        n_locals
    };
    if effective_locals != 0 {
        b.set_locals(effective_locals);
    }
    // `alloca_top_slot == 0` means the body has no `alloca` call.
    // A non-zero slot marks the function dynamic-sp for the
    // codegen: spill slots move to fp-based addressing and the
    // epilogue re-establishes sp.
    b.alloca_init(alloca_top_slot);
    // C99 6.8.6.4 + AAPCS64 6.9: classify the return convention. An
    // integer aggregate of at most 16 bytes returns in x0/x1; a larger
    // one returns through the caller-supplied x8 indirect-result
    // register. Both carry no hidden argument, so their parameters
    // start at slot 2. Every other aggregate keeps the c5 out-pointer
    // convention (hidden pointer at slot 2, parameters start at 3).
    use crate::c5::compiler::StructReturnAbi;
    // Every ABI question about this definition -- where its arguments
    // arrive, how an aggregate parameter or return is classified -- is
    // asked of the convention it declares, which is the target's own
    // unless `__attribute__((ms_abi))` / `((sysv_abi))` says otherwise.
    // `abi_target` carries that convention to the argument planner;
    // layout-shaped queries keep the real target, since scalar widths
    // are the target's property and not the convention's.
    let abi_target = target.abi_row(*conv);
    let ret_abi = crate::c5::compiler::struct_return_abi_conv(structs, target, *conv, return_ty);
    let ret_outptr = matches!(ret_abi, StructReturnAbi::OutPtr);
    let ret_in_regs = matches!(ret_abi, StructReturnAbi::Regs(_));
    let ret_indirect = matches!(ret_abi, StructReturnAbi::Indirect(_));
    if let StructReturnAbi::Regs(desc) | StructReturnAbi::Indirect(desc) = &ret_abi {
        let idx = b.intern_agg_desc(desc.clone());
        b.set_ret_agg(idx);
    }
    b.set_ret_is_fp(is_floating_scalar(return_ty));
    b.set_ret_type_tag(return_ty);
    // A function returning > 16 bytes saves the incoming x8 result
    // pointer into a dedicated local for the codegen prologue; the
    // `return` lowering writes the value through it.
    let indirect_result_slot: i64 = if ret_indirect {
        let slot = b.alloc_synthetic_local();
        b.set_indirect_result_slot(slot);
        slot
    } else {
        0
    };
    // C99 6.5.2.2 + the host ABI (AAPCS64 6.8.2): a small aggregate
    // parameter arrives in argument registers rather than by the
    // caller's address. Classify each by-value struct parameter; a
    // tagged parameter gets no SSA entry-copy below -- the callee
    // prologue (native) and `run_func` (VM) write the incoming bytes
    // straight into the parser-reserved body local recorded in
    // `param_local_slots[i]`. Variadic and out-pointer-returning
    // callees keep the c5 by-address shape (the hidden out-pointer
    // shifts every parameter cell), so they are excluded; host-ABI
    // returns (registers / x8) leave the parameter slots unshifted.
    let mut param_aggs: alloc::vec::Vec<Option<u32>> = alloc::vec::Vec::new();
    // Parallel per-parameter aggregate classification, consumed below by
    // the argument-register planner so the `ParamRef` seed loop knows
    // which scalar parameters an aggregate pushed past the argument
    // registers onto the host stack.
    let mut param_arg_aggs: alloc::vec::Vec<Option<crate::c5::codegen::ArgAgg>> =
        alloc::vec::Vec::new();
    if !is_variadic && !ret_outptr {
        param_aggs = alloc::vec![None; param_tys.len()];
        param_arg_aggs = alloc::vec![None; param_tys.len()];
        for (i, &pty) in param_tys.iter().enumerate() {
            if let Some(desc) =
                crate::c5::compiler::host_abi_agg_desc_conv(structs, target, *conv, pty)
            {
                param_arg_aggs[i] = Some(crate::c5::codegen::ArgAgg {
                    class: crate::c5::codegen::abi_classify::classify_aggregate(
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
                param_aggs[i] = Some(idx);
            }
        }
    }
    let has_struct_params = param_aggs.iter().any(Option::is_some);
    if has_struct_params {
        b.set_param_aggs(param_aggs.clone(), param_local_slots.to_vec());
    }
    // C99 6.5.2.2 + the c5 calling convention: for each
    // struct-by-value parameter, the caller passes the
    // source's address in slot `i + base` (base = 2, or 3
    // when a struct-returning callee uses slot 2 as the
    // hidden out-pointer). The callee's prologue copies the
    // struct into a fresh local; the parser allocated the
    // local and recorded its offset in `param_local_slots[i]`,
    // and shifted the symbol's `val` to point at it. The walker
    // emits the matching `Inst::Mcpy` here so the SSA carries the
    // entry-copy semantics.
    // Argument-slot base: 2 for ordinary callees, 3 when the
    // function returns a struct value (slot 2 holds the hidden
    // out-pointer the caller pushed in front of the declared
    // args). The parser's symbol-table assignment uses the same
    // base, so this index matches the `val` the parser stored
    // for each declared param.
    let arg_slot_base: i64 = if ret_outptr { 3 } else { 2 };
    // C99 6.2.5p10 + the host ABI (System V AMD64 3.2.3 / AAPCS64
    // 6.4.1): a floating-point scalar parameter passed in an FP
    // argument register. Record the per-parameter FP mask so the
    // callee emit resolves each parameter's incoming register
    // through `plan_call_args`, the same ABI planner the caller
    // uses. Independent int / FP register banks mean an int
    // parameter after an FP parameter does not lose an int arg
    // register to the FP one. Variadic and struct-returning callees
    // keep the c5 cdecl shape (their args ride the c5 stack / a
    // hidden out-pointer shifts every cell), so they are excluded
    // here exactly as they are from the seed loop below.
    if !is_variadic && !ret_outptr {
        for (i, &pty) in param_tys.iter().enumerate() {
            let stripped = strip_unsigned(pty);
            if stripped == crate::c5::token::Ty::Float as i64
                || stripped == crate::c5::token::Ty::Double as i64
            {
                b.mark_param_fp(i);
            }
        }
        // Clear the mask when the placement would interleave register
        // and host-stack parameters: the c5 cdecl cell layout requires a
        // contiguous register prefix, so such a function falls back to
        // the all-integer ABI. The caller applies the same predicate to
        // its `fp_arg_mask`, so the two ends stay in agreement.
        let eff = effective_fp_arg_mask(param_tys.len(), b.param_fp_mask(), abi_target.abi());
        b.set_param_fp_mask(eff);
    }
    // Per-parameter incoming-register plan, resolved once for both the
    // integer/double seed loop and the float-narrow loop below. A
    // floating-point parameter is seeded with an FP `ParamRef` only
    // when the plan placed it in an FP register; one that overflowed to
    // the host stack reads its c5 cdecl cell instead.
    let param_plan = plan_param_regs_aggs(
        param_tys.len(),
        b.param_fp_mask(),
        abi_target.abi(),
        &param_arg_aggs,
    );
    let param_in_fp_reg =
        |i: usize| -> bool { matches!(param_plan.placements.get(i), Some(ArgPlacement::FpReg(_))) };
    // Parameter-slot promotion seed: for each non-relocated,
    // non-struct, non-float-narrowed parameter, emit a `ParamRef`
    // + `StoreLocal` to the c5 cdecl arg slot. The store gives
    // mem2reg a single reaching def for the slot so per-use
    // `LoadLocal` reads in the body can be folded onto the
    // `ParamRef` value, eliminating the per-use ldursw / mov rN
    // reloads. Variadic functions skip this -- their args ride
    // the c5 stack, not host arg regs, and the prologue does
    // not spill into the host-arg-reg slots. Struct-returning
    // callees skip this -- the hidden out-pointer shifts every
    // declared param's incoming arg reg up by one, which
    // `Inst::ParamRef(i)`'s direct `int_arg_regs[i]` index does
    // not handle. This loop runs before the struct / float
    // entry-copy loop below so `Inst::ParamRef` reads the host
    // arg register while it still holds the caller-supplied
    // value: the struct mcpy emits scratch writes (its result
    // place can land on any caller-saved reg, including a host
    // arg reg) and any reordering would let those writes clobber
    // the incoming argument before its `ParamRef` materialised.
    if !is_variadic && !ret_outptr {
        for i in 0..param_tys.len() {
            let pty = param_tys[i];
            let local_slot = param_local_slots[i];
            if local_slot < 0 {
                continue;
            }
            let stripped = strip_unsigned(pty);
            let is_struct_value =
                stripped >= STRUCT_BASE && ((stripped - STRUCT_BASE) % STRUCT_STRIDE) / 2 == 0;
            if is_struct_value {
                continue;
            }
            // Floating-point params arrive in an FP argument register
            // (C99 6.2.5p10). A `double` keeps its original positive
            // cell (`param_local_slots[i] == 0`); seed it with an FP
            // `ParamRef { F64 }` + `StoreLocal { F64 }` so mem2reg has
            // a reaching def in the FP register file and the body's
            // `LoadLocal { F64 }` reads can fold onto it -- exactly the
            // promotion the integer path below performs. A `float`
            // param was repointed by the parser to a negative narrow-
            // storage local (`param_local_slots[i] < 0`, skipped at the
            // top of the loop); its entry narrow stays on the parser's
            // dance, fed by the prologue's widen-to-f64 spill of the
            // incoming s-register.
            let is_float = stripped == crate::c5::token::Ty::Float as i64;
            let is_double = stripped == crate::c5::token::Ty::Double as i64;
            if is_double {
                if param_in_fp_reg(i) {
                    let arg_slot = (i as i64) + arg_slot_base;
                    let pr = b.param_ref(i as u32, LoadKind::F64);
                    b.store_local(arg_slot, pr, StoreKind::F64);
                }
                continue;
            }
            if is_float {
                continue;
            }
            // Seed an integer `ParamRef` only when the planner placed this
            // parameter in an integer argument register. An aggregate
            // earlier in the list can consume several registers (or one
            // by-reference pointer register), pushing a later scalar that
            // would fit by position onto the host stack; such a parameter
            // has no incoming register and reads its c5 cdecl cell, which
            // the prologue restripes from the incoming stack.
            if !matches!(param_plan.placements.get(i), Some(ArgPlacement::IntReg(_))) {
                continue;
            }
            // An unsigned-tagged parameter keeps the full 8-byte
            // store/load so the body's zero-extending reads see the
            // caller's extension rather than a sign-extended narrow
            // reload. Pointer tags land in the I64 default arm by
            // band value.
            use crate::c5::token::Ty;
            let unsigned = pty & UNSIGNED_BIT != 0;
            let (store_kind, load_kind) = if unsigned {
                (StoreKind::I64, LoadKind::I64)
            } else {
                match stripped {
                    s if s == Ty::Char as i64 => (StoreKind::I8, LoadKind::I8),
                    s if s == Ty::Short as i64 => (StoreKind::I16, LoadKind::I16),
                    s if s == Ty::Int as i64 => (StoreKind::I32, LoadKind::I32),
                    _ => (StoreKind::I64, LoadKind::I64),
                }
            };
            let arg_slot = (i as i64) + arg_slot_base;
            let pr = b.param_ref(i as u32, load_kind);
            b.store_local(arg_slot, pr, store_kind);
        }
    }
    for i in 0..param_tys.len() {
        let pty = param_tys[i];
        let local_slot = param_local_slots[i];
        if local_slot >= 0 {
            continue;
        }
        let stripped = strip_unsigned(pty);
        let is_struct_value =
            stripped >= STRUCT_BASE && ((stripped - STRUCT_BASE) % STRUCT_STRIDE) / 2 == 0;
        if is_struct_value {
            // Host-ABI register-passed parameter: no entry copy. The
            // backend scatters the incoming argument registers (native)
            // or copies the argument bytes (VM) straight into this
            // body local.
            if param_aggs.get(i).copied().flatten().is_some() {
                continue;
            }
            let id = ((stripped - STRUCT_BASE) / STRUCT_STRIDE) as usize;
            if id >= structs.len() {
                continue;
            }
            let size = structs[id].size as i64;
            let align = structs[id].align.max(1) as u32;
            let arg_slot = (i as i64) + arg_slot_base;
            let dst = b.local_addr(local_slot);
            let src = b.load_local(arg_slot, LoadKind::I64);
            b.mcpy(dst, src, size, align);
            continue;
        }
        // `float`-by-value param. The parser repointed the symbol to a
        // 4-byte narrow-storage local (`local_slot < 0`).
        let is_float = stripped == crate::c5::token::Ty::Float as i64;
        if is_float {
            if !is_variadic && !ret_outptr && param_in_fp_reg(i) {
                // The argument arrives at single precision in an FP
                // argument register (C99 6.2.5p10). Seed an FP
                // `ParamRef { F32 }` (the s-register view) and store it
                // into the local with `StoreKind::F32`. The value never
                // round-trips through the positive c5 cdecl cell, so
                // that cell stays unobserved and the prologue's spill of
                // it is elided. A direct `StoreLocal` (not the
                // address-taken form) keeps the slot mem2reg-promotable.
                let pr = b.param_ref(i as u32, LoadKind::F32);
                b.mark_f32(pr);
                b.store_local(local_slot, pr, StoreKind::F32);
            } else if b.param_fp_mask() != 0 {
                // Host-stack-overflow `float` parameter (more than eight
                // preceding FP parameters) under the FP-register ABI: the
                // caller pushed it at single precision into the c5 cdecl
                // cell. Read the cell as `F32` (widening to f64) and
                // narrow back into the local.
                let arg_slot = (i as i64) + arg_slot_base;
                let val = b.load_local(arg_slot, LoadKind::F32);
                b.store_local(local_slot, val, StoreKind::F32);
            } else {
                // Variadic / struct-returning callees keep the c5 cdecl
                // shape: the caller widened the `float` to an 8-byte
                // double in the integer-passed cell. Read the cell as
                // I64 (preserving the bit pattern) and narrow back via a
                // `StoreKind::F32` into the local.
                let arg_slot = (i as i64) + arg_slot_base;
                let val = b.load_local(arg_slot, LoadKind::I64);
                b.store_local(local_slot, val, StoreKind::F32);
            }
        }
    }
    let mut ctx = Walker {
        ast,
        symbols,
        structs,
        target,
        loop_ctx: alloc::vec::Vec::new(),
        label_blocks: alloc::vec![None; ast.goto_targets.len()],
        switch_dispatch: alloc::vec::Vec::new(),
        returns_struct,
        return_struct_size,
        ret_in_regs,
        ret_indirect,
        indirect_result_slot,
        scalar_return_ty: return_ty,
        optimize,
        jump_tables,
    };
    // Walk the function body's root statement (a Compound built
    // at function-end by the parser's `parse_block_stmt` /
    // function-body loop). If absent (no body was parsed),
    // synthesize a `return 0` for a well-formed FunctionSsa.
    let terminated = match ast.body {
        Some(root) => ctx.walk_stmt(&mut b, root)?,
        None => false,
    };
    // If the body fell off the end (no Return reached), the
    // current block is still open; close it with `return 0`
    // per C99 5.1.2.2.3 (main returning 0 by default) and the
    // general "well-formed FunctionSsa" guarantee.
    if !terminated && b.is_block_open() {
        let zero = b.imm(0);
        b.return_(zero);
    }
    // `&&label` elements of this function's static initializers: bind
    // each staged data slot to the label's block. `label_data_block`
    // also records the block as address-taken, which keeps it reachable
    // and its id remapped by the block-renumbering passes. Runs before
    // the dead-block close so a block allocated here is closed too.
    for r in &fun.label_data_slots {
        let block = ctx.block_for_label(&mut b, r.label);
        b.label_data_block(r.data_offset, block);
    }
    // Pre-allocated branch / loop targets (after-If with both
    // arms terminating, dead post-Break tails, label blocks
    // that nothing ever reached) close with a synthetic
    // `return 0` so `finish()` doesn't panic on an open block.
    // Unreachable in practice; the SSA DCE folds the dead arm
    // away.
    b.close_dead_blocks();
    Ok(b.finish())
}
