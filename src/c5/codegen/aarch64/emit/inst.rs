use super::*;

/// Read-only per-function context threaded through the per-instruction
/// lowering: the loop-invariant inputs, so `emit_inst`'s signature stays
/// short. Copy (references and small scalars).
#[derive(Clone, Copy)]
pub(super) struct FnCtx<'a> {
    pub(super) func: &'a FunctionSsa,
    pub(super) alloc: &'a Allocation,
    pub(super) frame: Frame,
    pub(super) scratch: &'a ScratchPool,
    pub(super) abi: super::Abi,
    pub(super) target: Target,
    pub(super) imports: &'a super::ResolvedImports,
    pub(super) variadic_targets: &'a alloc::collections::BTreeSet<usize>,
    pub(super) extern_tls_names: &'a alloc::collections::BTreeMap<u32, alloc::string::String>,
    /// `Inst::ImmData` value-id -> cross-TU data symbol name, for an `i`-class
    /// inline-asm operand that names an external address in a section field.
    pub(super) extern_data_names: &'a alloc::collections::BTreeMap<u32, alloc::string::String>,
    pub(super) param_plan: &'a [super::ArgPlacement],
    /// Function name -> entry PC, for resolving an inline-asm `bl` / `b` to a
    /// named symbol.
    pub(super) name2entpc: &'a alloc::collections::BTreeMap<alloc::string::String, usize>,
    /// Internal-linkage data object name -> unified data offset, for a
    /// function-body inline-asm symbol operand naming a static.
    pub(super) data_sym_offsets: &'a alloc::collections::BTreeMap<alloc::string::String, i64>,
}

/// Emit one SSA instruction. Returns `false` for an op with no lowering, so
/// the caller can roll the function back.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_inst(
    cx: &mut super::ssa::emit_common::EmitCtx,
    inst: &Inst,
    v: super::super::ir::ValueId,
    dst: Place,
    fcx: &FnCtx,
    fixups: &mut Vec<Fixup>,
    macho_tlv_fixups: &mut Vec<super::MachoTlvFixup>,
    macho_tlv_descriptors: &mut Vec<super::MachoTlvDescriptor>,
    deferred_regions: &mut Vec<DeferredAsmRegion>,
    text_map_state: &mut Option<super::super::map_syms::MapClass>,
    asm_text_labels: &mut Vec<super::AsmTextLabel>,
    asm_section_text_refs: &mut Vec<super::AsmSectionTextRef>,
) -> bool {
    let FnCtx {
        func,
        alloc,
        frame,
        scratch,
        abi,
        target,
        imports,
        variadic_targets,
        extern_tls_names,
        extern_data_names,
        param_plan,
        name2entpc,
        data_sym_offsets,
    } = *fcx;
    let code = &mut *cx.code;
    match inst {
        // Slot 0: this function doesn't use alloca. Non-zero: the function
        // moves sp at runtime; `Frame::dynamic_sp` carries the fact to the
        // spill addressing, the alloca intrinsics, and the epilogue. No code
        // either way.
        Inst::AllocaInit(_) => true,
        Inst::ParamRef { idx, kind } => {
            emit_param_ref(code, *idx, *kind, v, dst, param_plan, alloc, frame, scratch)
        }
        Inst::Imm(value) => {
            let Some(rd) = int_or_spill_scratch(dst, scratch) else {
                return false;
            };
            load_imm64(code, rd, *value as u64);
            store_spilled_int(code, frame, dst, rd);
            true
        }
        Inst::ImmData(offset) => {
            let Some(rd) = int_or_spill_scratch(dst, scratch) else {
                return false;
            };
            // Encode `rd` in the adrp/add placeholder; the per-writer
            // `patch_adrp_add` reads rd back from the placeholder, so the
            // materialised address lands directly in the allocator's register.
            let instr_offset = code.len();
            emit_adrp_add(code, rd);
            cx.data_fixups.push(DataFixup {
                instr_offset,
                data_offset: *offset as u64,
                part: AddrPart::Whole,
            });
            store_spilled_int(code, frame, dst, rd);
            true
        }
        Inst::ImmCode(target_ent_pc) => {
            let Some(rd) = int_or_spill_scratch(dst, scratch) else {
                return false;
            };
            let instr_offset = code.len();
            emit_adrp_add(code, rd);
            cx.pending_func_fixups.push((instr_offset, *target_ent_pc));
            store_spilled_int(code, frame, dst, rd);
            true
        }
        // The address of a dynamically-imported function: the pair resolves
        // to the import's shared stub via an `is_addr` PLT-call fixup, so
        // `&strcmp` yields the stub address.
        Inst::ImmExtCode(binding_idx) => {
            let Some(rd) = int_or_spill_scratch(dst, scratch) else {
                return false;
            };
            let Some(import_index) = imports.index_of_binding(*binding_idx) else {
                bail_msg("ImmExtCode: binding index has no resolved import");
                return false;
            };
            cx.plt_call_fixups.push(super::encode::PltCallFixup {
                instr_offset: code.len(),
                import_index,
                is_tail: false,
                is_addr: true,
            });
            emit_adrp_add(code, rd);
            store_spilled_int(code, frame, dst, rd);
            true
        }
        Inst::LocalAddr(off) => emit_local_addr(code, dst, *off, func, frame),
        Inst::Load {
            addr,
            disp,
            kind,
            align,
            ..
        } => emit_load(
            code,
            dst,
            *addr,
            *disp,
            *kind,
            alloc.is_f32(v),
            alloc,
            frame,
            scratch,
            narrow_bound(*align, abi),
        ),
        Inst::Store {
            addr,
            disp,
            value,
            kind,
            align,
            ..
        } => emit_store(
            code,
            dst,
            *addr,
            *disp,
            *value,
            *kind,
            alloc,
            frame,
            scratch,
            narrow_bound(*align, abi),
        ),
        Inst::LoadLocal { off, kind, .. } => emit_load_local(
            code,
            dst,
            *off,
            *kind,
            alloc.is_f32(v),
            func,
            frame,
            scratch,
        ),
        Inst::StoreLocal {
            off, value, kind, ..
        } => emit_store_local(code, dst, *off, *value, *kind, alloc, func, frame, scratch),
        Inst::LoadIndexed {
            base,
            index,
            scale,
            kind,
        } => emit_load_indexed(
            code, dst, *base, *index, *scale, *kind, alloc, frame, scratch,
        ),
        Inst::StoreIndexed {
            base,
            index,
            scale,
            value,
            kind,
        } => emit_store_indexed(
            code, dst, *base, *index, *scale, *value, *kind, alloc, frame, scratch,
        ),
        Inst::Binop { op, lhs, rhs } => {
            emit_binop(code, *op, v, dst, *lhs, *rhs, alloc, frame, scratch)
        }
        Inst::MulAdd {
            a,
            b,
            c,
            neg_product,
        } => emit_mul_add(code, dst, *a, *b, *c, *neg_product, alloc, frame, scratch),
        Inst::BinopI { op, lhs, rhs_imm } => {
            emit_binop_imm(code, *op, v, dst, *lhs, *rhs_imm, alloc, frame, scratch)
        }
        Inst::Call {
            target_pc,
            args,
            fixed_args,
            fp_return,
            fp_arg_mask,
            arg_aggs,
            ret_agg,
            ret_slot_local,
            ..
        } => emit_call(
            code,
            dst,
            *target_pc,
            args,
            *fixed_args,
            alloc,
            frame,
            scratch,
            abi,
            fixups,
            variadic_targets.contains(target_pc),
            *fp_return,
            *fp_arg_mask,
            arg_aggs,
            &func.agg_descs,
            *ret_agg,
            *ret_slot_local,
        ),
        Inst::CallExt {
            binding_idx,
            args,
            fp_arg_mask,
            arg_aggs,
            ret_agg,
            ret_slot_local,
            ..
        } => emit_call_ext(
            code,
            dst,
            *binding_idx,
            args,
            *fp_arg_mask,
            alloc,
            frame,
            scratch,
            abi,
            target,
            cx.plt_call_fixups,
            imports,
            arg_aggs,
            &func.agg_descs,
            *ret_agg,
            *ret_slot_local,
        ),
        Inst::CallIndirect {
            target,
            args,
            callee_variadic,
            fixed_args,
            fp_return,
            fp_arg_mask,
            arg_aggs,
            ret_agg,
            ret_slot_local,
            ..
        } => emit_call_indirect(
            code,
            dst,
            *target,
            args,
            *callee_variadic,
            *fixed_args,
            alloc,
            frame,
            scratch,
            abi,
            *fp_return,
            *fp_arg_mask,
            arg_aggs,
            &func.agg_descs,
            *ret_agg,
            *ret_slot_local,
        ),
        Inst::Mcpy {
            dst: d,
            src: s,
            size,
            align,
        } => emit_mcpy(
            code,
            dst,
            *d,
            *s,
            *size,
            *align,
            abi.strict_align,
            alloc,
            frame,
            scratch,
        ),
        Inst::AtomicRmw {
            op,
            addr,
            value,
            width,
        } => emit_atomic_rmw(code, dst, *op, *addr, *value, *width, alloc, frame, scratch),
        Inst::AtomicCas {
            addr,
            expected_addr,
            desired,
            width,
        } => emit_atomic_cas(
            code,
            dst,
            *addr,
            *expected_addr,
            *desired,
            *width,
            alloc,
            frame,
            scratch,
        ),
        Inst::Intrinsic { kind, args } => {
            emit_intrinsic(code, func, abi, *kind, args, dst, v, alloc, frame, scratch)
        }
        Inst::Fneg(src) => emit_fneg(code, *src, v, dst, alloc, frame),
        Inst::Fma {
            a,
            b,
            c,
            neg_product,
            neg_addend,
        } => emit_fma(
            code,
            [*a, *b, *c],
            *neg_product,
            *neg_addend,
            v,
            dst,
            alloc,
            frame,
        ),
        Inst::Extend { value, kind } => {
            emit_extend(code, dst, *value, *kind, alloc, frame, scratch)
        }
        Inst::Bswap { value, width } => {
            emit_bswap(code, dst, *value, *width, alloc, frame, scratch)
        }
        Inst::Copy { value, is_fp } => emit_copy(code, dst, *value, *is_fp, alloc, frame, scratch),
        Inst::FpCast { kind, value } => {
            emit_fp_cast(code, *kind, *value, v, dst, alloc, frame, scratch)
        }
        Inst::TlsAddr(offset) => emit_tls_addr(
            code,
            dst,
            frame,
            *offset,
            target,
            cx.tls_index_fixups,
            macho_tlv_fixups,
            macho_tlv_descriptors,
            cx.elf_tpoff_fixups,
            extern_tls_names.get(&v).map(|s| s.as_str()),
        ),
        // The value is materialised by the predecessor-exit moves emitted
        // before each branch terminator that targets this block; at the IR
        // position the phi's allocated Place already holds the merged value.
        Inst::Phi { .. } => true,
        Inst::InlineAsm { asm, args } => emit_inline_asm_aarch64(
            code,
            asm,
            args,
            func,
            alloc,
            frame,
            fixups,
            name2entpc,
            extern_data_names,
            data_sym_offsets,
            cx.asm_sections,
            cx.asm_extern_call_sites,
            cx.asm_sym_fixups,
            deferred_regions,
            cx.text_data_ranges,
            cx.text_align,
            text_map_state,
            asm_text_labels,
            asm_section_text_refs,
            None,
        ),
        // `BlockAddr` is materialized in `emit_function`'s block loop and
        // `TailExt` is a terminator, so neither reaches here; the segment
        // accesses are x86-only. Reaching this arm means a variant has no
        // aarch64 lowering, which is a compile failure, not silent output.
        other => {
            bail_msg(&alloc::format!(
                "inst variant not yet covered: {}",
                other.variant_name()
            ));
            false
        }
    }
}

/// The `adrp rd, page; add rd, rd, lo12` placeholder pair an address fixup
/// patches.
fn emit_adrp_add(code: &mut Vec<u8>, rd: Reg) {
    emit(code, enc_adrp(rd, 0));
    emit(code, enc_add_imm(rd, rd, 0));
}

/// Materialise the i-th argument register into the allocator's `Place`.
/// The prologue does not modify x0..x7 / d0..d7, so the value is still in
/// its incoming register at this IR position. An integer parameter is
/// sign-extended from its `kind` width (C99 6.3.1.3) so the register holds
/// the canonical 64-bit value; the caller passes the raw value, so an
/// I8/I16 conversion always runs, while an I32 extend touches only bits
/// 32..63 and is skipped when no consumer reads them. A floating-point
/// parameter (C99 6.2.5p10) arrives in the d-register the plan names; a
/// `float` occupies the s-register view, which the body re-narrows through
/// the f32 store the walker seeded.
#[allow(clippy::too_many_arguments)]
fn emit_param_ref(
    code: &mut Vec<u8>,
    idx: u32,
    kind: LoadKind,
    v: super::super::ir::ValueId,
    dst: Place,
    param_plan: &[super::ArgPlacement],
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    let i = idx as usize;
    if matches!(kind, LoadKind::F32 | LoadKind::F64) {
        let Some(super::ArgPlacement::FpReg(d)) = param_plan.get(i).copied() else {
            bail_msg("ParamRef: FP param not in an FP argument register");
            return false;
        };
        match dst {
            Place::FpReg(r) => {
                if r != d {
                    emit(code, super::encode::enc_fmov_d_d(r, d));
                }
            }
            Place::Spill(slot) => {
                let sp_off = spill_off(frame, slot);
                emit_spill_str_d_auto(code, frame, d, sp_off);
            }
            _ => {
                bail_msg("ParamRef: FP param dst not fp reg / spill");
                return false;
            }
        }
        return true;
    }
    let Some(super::ArgPlacement::IntReg(arg_reg)) = param_plan.get(i).copied() else {
        bail_msg("ParamRef: int param not in an integer argument register");
        return false;
    };
    let high_dead = !alloc.high_observed.get(v as usize).copied().unwrap_or(true);
    let sign_extend = |code: &mut Vec<u8>, rd: Reg| {
        let rn = Reg(arg_reg);
        match kind {
            LoadKind::I8 => emit(code, super::encode::enc_sxtb(rd, rn)),
            LoadKind::I16 => emit(code, super::encode::enc_sxth(rd, rn)),
            LoadKind::I32 if !high_dead => emit(code, super::encode::enc_sxtw(rd, rn)),
            _ => emit_mov_reg(code, rd, rn),
        }
    };
    match dst {
        Place::IntReg(r) => sign_extend(code, Reg(r)),
        Place::Spill(slot) => {
            sign_extend(code, scratch.primary);
            let sp_off = spill_off(frame, slot);
            emit_spill_str_x(code, frame, scratch.primary, sp_off, scratch.secondary);
        }
        _ => {
            bail_msg("ParamRef: dst not int reg / spill");
            return false;
        }
    }
    true
}

/// `Inst::Fneg`. C99 6.3.1.8: negation of a `float` is single-precision;
/// the result's f32 marker mirrors the operand's. A spilled result stages
/// through the second FP scratch, since the source may occupy the first.
fn emit_fneg(
    code: &mut Vec<u8>,
    src: u32,
    v: super::super::ir::ValueId,
    dst: Place,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let is_f32 = alloc.is_f32(v);
    let Some(dn) = materialize_fp_for(
        code,
        src,
        place_of(alloc, src),
        frame.fp_scratch[0],
        frame,
        alloc,
    ) else {
        return false;
    };
    let dd = match dst {
        Place::FpReg(r) => r,
        Place::Spill(_) => frame.fp_scratch[1],
        _ => return false,
    };
    if is_f32 {
        emit(code, super::encode::enc_fneg_s(dd, dn));
    } else {
        emit(code, enc_fneg_d(dd, dn));
    }
    store_spilled_fp(code, frame, dst, dd);
    true
}

/// `Inst::Fma`: C99 6.5p8 / FP_CONTRACT, the fused form rounds once. The
/// result width follows the operands; the marker mirrors `a`. Each operand
/// resolves to its own d-reg or, when spilled, a dedicated scratch outside
/// the allocator's banks. A spilled result writes into the third FP
/// scratch: that scratch is free unless `c` was itself spilled into it, in
/// which case the FMADD reads Da before writing Dd. It must not reuse `dc`
/// directly, since an allocated `c` register may hold a value a later
/// instruction still needs (a loop-carried addend across several fused
/// ops).
#[allow(clippy::too_many_arguments)]
fn emit_fma(
    code: &mut Vec<u8>,
    [a, b, c]: [u32; 3],
    neg_product: bool,
    neg_addend: bool,
    v: super::super::ir::ValueId,
    dst: Place,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let is_f32 = alloc.is_f32(v);
    let mut regs = [0u8; 3];
    for (k, &src) in [a, b, c].iter().enumerate() {
        let Some(d) = materialize_fp_for(
            code,
            src,
            place_of(alloc, src),
            frame.fp_scratch[k],
            frame,
            alloc,
        ) else {
            return false;
        };
        regs[k] = d;
    }
    let [da, dm, dc] = regs;
    let dd = match dst {
        Place::FpReg(r) => r,
        Place::Spill(_) => frame.fp_scratch[2],
        _ => return false,
    };
    emit(
        code,
        super::encode::enc_fma(dd, da, dm, dc, is_f32, neg_product, neg_addend),
    );
    store_spilled_fp(code, frame, dst, dd);
    true
}

/// `Inst::FpCast`. C99 6.3.1.4: an integer converts directly to the result
/// precision (one rounding) and a `float` source truncates directly to the
/// integer; 6.3.1.5: the single-precision view occupies the low 32 bits of
/// the same V register, so a widening or narrowing `fcvt` reads and writes
/// the two views with no separate move.
#[allow(clippy::too_many_arguments)]
fn emit_fp_cast(
    code: &mut Vec<u8>,
    kind: super::super::ir::FpCastKind,
    value: u32,
    v: super::super::ir::ValueId,
    dst: Place,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    use super::super::ir::FpCastKind;
    let src_place = place_of(alloc, value);
    match kind {
        FpCastKind::IntToFp | FpCastKind::UIntToFp => {
            let Some(rn) = materialize_int(code, src_place, scratch.primary, frame) else {
                return false;
            };
            let Some(dd) = fp_or_spill_dst(dst, frame) else {
                return false;
            };
            let res_f32 = alloc.is_f32(v);
            let enc = match (matches!(kind, FpCastKind::UIntToFp), res_f32) {
                (true, true) => enc_ucvtf_s_x(dd, rn),
                (true, false) => enc_ucvtf_d_x(dd, rn),
                (false, true) => enc_scvtf_s_x(dd, rn),
                (false, false) => enc_scvtf_d_x(dd, rn),
            };
            emit(code, enc);
            store_spilled_fp(code, frame, dst, dd);
            true
        }
        FpCastKind::FpToInt | FpCastKind::UFpToInt => {
            let src_f32 = alloc.is_f32(value);
            let dn = if src_f32 {
                materialize_fp_f32(code, src_place, frame.fp_scratch[0], frame)
            } else {
                materialize_fp(code, src_place, frame.fp_scratch[0], frame)
            };
            let Some(dn) = dn else {
                return false;
            };
            let Some(rd) = int_or_spill_scratch(dst, scratch) else {
                return false;
            };
            let enc = match (matches!(kind, FpCastKind::UFpToInt), src_f32) {
                (true, true) => enc_fcvtzu_x_s(rd, dn),
                (true, false) => enc_fcvtzu_x_d(rd, dn),
                (false, true) => enc_fcvtzs_x_s(rd, dn),
                (false, false) => enc_fcvtzs_x_d(rd, dn),
            };
            emit(code, enc);
            store_spilled_int(code, frame, dst, rd);
            true
        }
        FpCastKind::F32ToF64 | FpCastKind::F64ToF32 => {
            let widen = matches!(kind, FpCastKind::F32ToF64);
            let dn = if widen {
                materialize_fp_f32(code, src_place, frame.fp_scratch[0], frame)
            } else {
                materialize_fp(code, src_place, frame.fp_scratch[0], frame)
            };
            let Some(dn) = dn else {
                return false;
            };
            let Some(dd) = fp_or_spill_dst(dst, frame) else {
                return false;
            };
            emit(
                code,
                if widen {
                    enc_fcvt_d_s(dd, dn)
                } else {
                    enc_fcvt_s_d(dd, dn)
                },
            );
            store_spilled_fp(code, frame, dst, dd);
            true
        }
    }
}

/// Resolve a set of register-to-register copies `(src, tgt)` so
/// that no copy writes to a register still needed as the source
/// of another pending copy. Processed leaf-first (target not in
/// any source) until the worklist drains; cycles are broken by
/// routing one source through `scratch`. The caller must pass a
/// `scratch` that lives outside the allocator's bank so it cannot
/// collide with any pending source or target.
pub(super) fn schedule_int_reg_moves(code: &mut Vec<u8>, moves: &mut Vec<(u8, u8)>, scratch: Reg) {
    super::ssa::emit_common::schedule_reg_moves_via_scratch(
        code,
        moves,
        scratch.0,
        |code, t, s| emit_mov_reg(code, Reg(t), Reg(s)),
    );
}

/// Sequentialize a parallel copy over d-registers. Mirrors
/// [`schedule_int_reg_moves`] with `fmov d, d` for the register
/// copies. `scratch_d` must lie outside the allocator's d-register
/// pool so it collides with no pending source or target.
pub(super) fn schedule_dreg_moves(code: &mut Vec<u8>, moves: &mut Vec<(u8, u8)>, scratch_d: u8) {
    super::ssa::emit_common::schedule_reg_moves_via_scratch(
        code,
        moves,
        scratch_d,
        |code, t, s| emit(code, super::encode::enc_fmov_d_d(t, s)),
    );
}

/// Emit the predecessor-exit moves for each `Inst::Phi` at the head
/// of every CFG successor of `self_block`. The phi's incoming entry
/// for `self_block` names the reaching value at this block's exit;
/// the move places it in the phi's allocated `Place` so the phi
/// position itself is a no-op in the inst stream. Cycles in the
/// IntReg -> IntReg move set are broken via the schedule helper
/// (one scratch-mediated copy per cycle); Spill destinations route
/// through the materialise helper.
///
/// TODO: extend to FpReg dst / src once a real fixture demands it;
/// the current promotion path admits only int-store slots
/// (`slot_stores_only_int`) so the FP case never arises today.
pub(super) fn emit_phi_predecessor_moves(
    code: &mut Vec<u8>,
    self_block: super::super::ir::BlockId,
    func: &super::super::ir::FunctionSsa,
    alloc: &Allocation,
    scratch: &ScratchPool,
    frame: Frame,
) -> bool {
    // The FP scratch pair sits outside the allocator's banks;
    // `scratch.primary` / `secondary` are the reserved integer scratch.
    super::ssa::emit_common::emit_phi_predecessor_moves(
        &super::ssa::emit_common::Aarch64Backend,
        code,
        self_block,
        func,
        alloc,
        frame,
        scratch.primary.0,
        scratch.secondary.0,
        frame.fp_scratch[1],
        frame.fp_scratch[0],
    )
}

/// Compare two `Place`s by physical location identity. Distinct
/// `Place` variants never alias; same-variant places alias when their
/// register number or spill slot matches.
/// Emit a single resolved location-to-location move. `stage` is a
/// scratch register used only for the spill-to-spill case (load then
/// store); `hold` is borrowed (saved/restored on the stack) to carry
/// the base when a spill-to-spill destination slot lies beyond the
/// scaled-imm12 reach. Both must lie outside the allocator's bank.
/// Sequentialize a parallel copy over physical locations (integer
/// registers and stack spill slots). Leaves -- destinations that are
/// not the source of any other pending move -- are emitted first;
/// when only cycles remain, one cycle source is saved into the
/// persistent `hold` register and every move reading that location is
/// redirected to read `hold`, exposing a new leaf. `hold` and `stage`
/// must both lie outside the allocator's bank so they cannot collide
/// with any pending source or destination. Returns false if any
/// operand is an FP or `None` location, which this path does not lower.
pub(super) fn schedule_place_moves(
    code: &mut Vec<u8>,
    moves: &mut Vec<(Place, Place)>,
    frame: Frame,
    hold: Reg,
    stage: Reg,
) -> bool {
    super::ssa::emit_common::schedule_place_moves(
        &super::ssa::emit_common::Aarch64Backend,
        code,
        moves,
        frame,
        hold.0,
        stage.0,
    )
}

/// Emit a single resolved FP location-to-location move over `FpReg`
/// and `Spill` places. `stage_d` is the scratch d-reg for the
/// spill-to-spill case (load then store); it must lie outside the
/// allocator's FP pool. `IntReg` and `None` places never reach here
/// (an FP phi's home and its operands are FP-classed).
impl super::ssa::emit_common::EmitBackend for super::ssa::emit_common::Aarch64Backend {
    type Frame = Frame;
    fn fp_reg_mov(&self, code: &mut Vec<u8>, dst: u8, src: u8) {
        emit(code, super::encode::enc_fmov_d_d(dst, src));
    }
    fn fp_spill_store(&self, code: &mut Vec<u8>, frame: Frame, slot: u32, src: u8) {
        // FP phi moves keep all values in d-regs, so the GPR scratch x16 is
        // free to carry the base for out-of-reach slots.
        emit_spill_str_d_auto(code, frame, src, spill_off(frame, slot));
    }
    fn fp_spill_load(&self, code: &mut Vec<u8>, frame: Frame, slot: u32, dst: u8) {
        emit_spill_ldr_d_auto(code, frame, dst, spill_off(frame, slot));
    }
    fn int_reg_mov(&self, code: &mut Vec<u8>, dst: u8, src: u8) {
        emit_mov_reg(code, Reg(dst), Reg(src));
    }
    fn int_spill_store(&self, code: &mut Vec<u8>, frame: Frame, slot: u32, src: u8, base: u8) {
        emit_spill_str_x(code, frame, Reg(src), spill_off(frame, slot), Reg(base));
    }
    fn int_spill_load(&self, code: &mut Vec<u8>, frame: Frame, slot: u32, dst: u8) {
        emit_spill_ldr_x(code, frame, Reg(dst), spill_off(frame, slot));
    }
    fn int_spill_to_spill(
        &self,
        code: &mut Vec<u8>,
        frame: Frame,
        src: u32,
        dst: u32,
        stage: u8,
        hold: u8,
    ) {
        emit_spill_ldr_x(code, frame, Reg(stage), spill_off(frame, src));
        // The value occupies `stage` and `hold` may carry a live cycle
        // source, so the store borrows `hold` via a stack save/restore when
        // the destination slot is out of reach.
        emit_spill_str_x_borrow(code, frame, Reg(stage), spill_off(frame, dst), Reg(hold));
    }
    fn int_spill_store_auto(&self, code: &mut Vec<u8>, frame: Frame, slot: u32, src: u8) {
        emit_spill_str_x_auto(code, frame, Reg(src), spill_off(frame, slot));
    }
    fn break_place_cycle(
        &self,
        code: &mut Vec<u8>,
        moves: &mut Vec<(Place, Place)>,
        frame: Frame,
        hold: u8,
        stage: u8,
    ) {
        // Stage one cycle source into `hold` and redirect every move that
        // reads it. A single cycle drains completely before the next break.
        let cyc = moves
            .iter()
            .map(|(s, _)| *s)
            .find(|s| !place_same_loc(*s, Place::IntReg(hold)))
            .unwrap_or(moves[0].0);
        super::ssa::emit_common::emit_place_move(
            self,
            code,
            cyc,
            Place::IntReg(hold),
            frame,
            stage,
            hold,
        );
        for m in moves.iter_mut() {
            if place_same_loc(m.0, cyc) {
                m.0 = Place::IntReg(hold);
            }
        }
    }
    fn int_reg_load_imm(&self, code: &mut Vec<u8>, dst: u8, bits: i64) {
        super::encode::load_imm64(code, Reg(dst), bits as u64);
    }
    fn fp_reg_from_int_reg(&self, code: &mut Vec<u8>, dst: u8, src: u8, is_f64: bool) {
        if is_f64 {
            emit(code, super::encode::enc_fmov_x_to_d(dst, Reg(src)));
        } else {
            emit(code, super::encode::enc_fmov_w_to_s(dst, Reg(src)));
        }
    }
}
