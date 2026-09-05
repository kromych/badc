use super::*;

/// Read-only per-function context threaded through the per-instruction
/// lowering.
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
    /// Alignment of the unit's thread-local image; variant I places the
    /// block past the TCB rounded up to it.
    pub(super) tls_align: usize,
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

/// Emit one SSA instruction. An op with no lowering is an `Err`, so the
/// caller can roll the function back.
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
) -> Emit {
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
        tls_align,
        extern_data_names,
        param_plan,
        name2entpc,
        data_sym_offsets,
    } = *fcx;
    let code = &mut *cx.code;
    match inst {
        // `Frame::dynamic_sp` carries the alloca fact; no code.
        Inst::AllocaInit(_) => Ok(()),
        Inst::ParamRef { idx, kind } => {
            emit_param_ref(code, *idx, *kind, v, dst, param_plan, alloc, frame, scratch)
        }
        Inst::Imm(value) => {
            let Some(rd) = int_or_spill_scratch(dst, scratch) else {
                return fail("Imm: dst not int reg / spill");
            };
            load_imm64(code, rd, *value as u64);
            store_spilled_int(code, frame, dst, rd);
            Ok(())
        }
        Inst::ImmData(offset) => {
            let Some(rd) = int_or_spill_scratch(dst, scratch) else {
                return fail("ImmData: dst not int reg / spill");
            };
            // The writer's `patch_adrp_add` reads rd back from the placeholder.
            let instr_offset = code.len();
            emit_adrp_add(code, rd);
            cx.data_fixups.push(DataFixup {
                instr_offset,
                data_offset: *offset as u64,
                part: AddrPart::Whole,
            });
            store_spilled_int(code, frame, dst, rd);
            Ok(())
        }
        Inst::ImmCode(target_ent_pc) => {
            let Some(rd) = int_or_spill_scratch(dst, scratch) else {
                return fail("ImmCode: dst not int reg / spill");
            };
            let instr_offset = code.len();
            emit_adrp_add(code, rd);
            cx.pending_func_fixups.push((instr_offset, *target_ent_pc));
            store_spilled_int(code, frame, dst, rd);
            Ok(())
        }
        // The address of an import resolves to its stub through an `is_addr`
        // PLT-call fixup.
        Inst::ImmExtCode(binding_idx) => {
            let Some(rd) = int_or_spill_scratch(dst, scratch) else {
                return fail("ImmExtCode: dst not int reg / spill");
            };
            let Some(import_index) = imports.index_of_binding(*binding_idx) else {
                return fail("ImmExtCode: binding index has no resolved import");
            };
            cx.plt_call_fixups.push(super::encode::PltCallFixup {
                instr_offset: code.len(),
                import_index,
                is_tail: false,
                is_addr: true,
            });
            emit_adrp_add(code, rd);
            store_spilled_int(code, frame, dst, rd);
            Ok(())
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
            fcx,
            CallOperands {
                args,
                fp_arg_mask: *fp_arg_mask,
                arg_aggs,
                ret_agg: *ret_agg,
                ret_slot_off: *ret_slot_local,
            },
            *target_pc,
            *fixed_args,
            fixups,
            variadic_targets.contains(target_pc),
            *fp_return,
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
            fcx,
            CallOperands {
                args,
                fp_arg_mask: *fp_arg_mask,
                arg_aggs,
                ret_agg: *ret_agg,
                ret_slot_off: *ret_slot_local,
            },
            *binding_idx,
            cx.plt_call_fixups,
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
            fcx,
            CallOperands {
                args,
                fp_arg_mask: *fp_arg_mask,
                arg_aggs,
                ret_agg: *ret_agg,
                ret_slot_off: *ret_slot_local,
            },
            *target,
            *callee_variadic,
            *fixed_args,
            *fp_return,
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
            tls_align,
        ),
        // The predecessor-exit moves placed the value; nothing at the phi
        // position.
        Inst::Phi { .. } => Ok(()),
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
        // `BlockAddr` is lowered in the block walk and `TailExt` is a
        // terminator; the segment accesses are x86-only.
        other => fail(alloc::format!(
            "inst variant not yet covered: {}",
            other.variant_name()
        )),
    }
}

/// The `adrp rd, page; add rd, rd, lo12` placeholder pair an address fixup
/// patches.
fn emit_adrp_add(code: &mut Vec<u8>, rd: Reg) {
    emit(code, enc_adrp(rd, 0));
    emit(code, enc_add_imm(rd, rd, 0));
}

/// Materialise the i-th argument register into the allocator's `Place`;
/// the prologue leaves x0..x7 / d0..d7 intact. An integer parameter is
/// sign-extended from its `kind` width (C99 6.3.1.3): an I8 / I16
/// conversion always runs, an I32 one only when a consumer reads bits
/// 32..63. A `float` (C99 6.2.5p10) occupies the s-view of its
/// d-register.
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
) -> Emit {
    let i = idx as usize;
    if matches!(kind, LoadKind::F32 | LoadKind::F64) {
        let Some(super::ArgPlacement::FpReg(d)) = param_plan.get(i).copied() else {
            return fail("ParamRef: FP param not in an FP argument register");
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
                return fail("ParamRef: FP param dst not fp reg / spill");
            }
        }
        return Ok(());
    }
    let Some(super::ArgPlacement::IntReg(arg_reg)) = param_plan.get(i).copied() else {
        return fail("ParamRef: int param not in an integer argument register");
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
            return fail("ParamRef: dst not int reg / spill");
        }
    }
    Ok(())
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
) -> Emit {
    let is_f32 = alloc.is_f32(v);
    let Some(dn) = materialize_fp_for(
        code,
        src,
        place_of(alloc, src),
        frame.fp_scratch[0],
        frame,
        alloc,
    ) else {
        return fail("Fneg: value not fp reg / spill");
    };
    let dd = match dst {
        Place::FpReg(r) => r,
        Place::Spill(_) => frame.fp_scratch[1],
        _ => return fail("Fneg: dst not fp reg / spill"),
    };
    if is_f32 {
        emit(code, super::encode::enc_fneg_s(dd, dn));
    } else {
        emit(code, enc_fneg_d(dd, dn));
    }
    store_spilled_fp(code, frame, dst, dd);
    Ok(())
}

/// `Inst::Fma`: C99 6.5p8 / FP_CONTRACT, one rounding. A spilled result
/// writes the third FP scratch, free unless `c` was spilled into it, in
/// which case the FMADD reads it before writing. An allocated `c`
/// register may hold a loop-carried addend, so `dc` is never reused.
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
) -> Emit {
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
            return fail("Fma: operand not fp reg / spill");
        };
        regs[k] = d;
    }
    let [da, dm, dc] = regs;
    let dd = match dst {
        Place::FpReg(r) => r,
        Place::Spill(_) => frame.fp_scratch[2],
        _ => return fail("Fma: dst not fp reg / spill"),
    };
    emit(
        code,
        super::encode::enc_fma(dd, da, dm, dc, is_f32, neg_product, neg_addend),
    );
    store_spilled_fp(code, frame, dst, dd);
    Ok(())
}

/// `Inst::FpCast`. C99 6.3.1.4: an integer converts directly to the
/// result precision and a `float` truncates directly to the integer;
/// 6.3.1.5: the s-view is the low 32 bits of the same V register, so a
/// widening or narrowing `fcvt` needs no separate move.
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
) -> Emit {
    use super::super::ir::FpCastKind;
    let src_place = place_of(alloc, value);
    match kind {
        FpCastKind::IntToFp | FpCastKind::UIntToFp => {
            let Some(rn) = materialize_int(code, src_place, scratch.primary, frame) else {
                return fail("FpCast IntToFp / UIntToFp: value not int reg / spill");
            };
            let Some(dd) = fp_or_spill_dst(dst, frame) else {
                return fail("FpCast IntToFp / UIntToFp: dst not fp reg / spill");
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
            Ok(())
        }
        FpCastKind::FpToInt | FpCastKind::UFpToInt => {
            let src_f32 = alloc.is_f32(value);
            let dn = if src_f32 {
                materialize_fp_f32(code, src_place, frame.fp_scratch[0], frame)
            } else {
                materialize_fp(code, src_place, frame.fp_scratch[0], frame)
            };
            let Some(dn) = dn else {
                return fail("FpCast FpToInt / UFpToInt: value not fp reg / spill");
            };
            let Some(rd) = int_or_spill_scratch(dst, scratch) else {
                return fail("FpCast FpToInt / UFpToInt: dst not int reg / spill");
            };
            let enc = match (matches!(kind, FpCastKind::UFpToInt), src_f32) {
                (true, true) => enc_fcvtzu_x_s(rd, dn),
                (true, false) => enc_fcvtzu_x_d(rd, dn),
                (false, true) => enc_fcvtzs_x_s(rd, dn),
                (false, false) => enc_fcvtzs_x_d(rd, dn),
            };
            emit(code, enc);
            store_spilled_int(code, frame, dst, rd);
            Ok(())
        }
        FpCastKind::F32ToF64 | FpCastKind::F64ToF32 => {
            let widen = matches!(kind, FpCastKind::F32ToF64);
            let dn = if widen {
                materialize_fp_f32(code, src_place, frame.fp_scratch[0], frame)
            } else {
                materialize_fp(code, src_place, frame.fp_scratch[0], frame)
            };
            let Some(dn) = dn else {
                return fail("FpCast F32ToF64 / F64ToF32: value not fp reg / spill");
            };
            let Some(dd) = fp_or_spill_dst(dst, frame) else {
                return fail("FpCast F32ToF64 / F64ToF32: dst not fp reg / spill");
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
            Ok(())
        }
    }
}

/// Sequentialize register-to-register copies `(src, tgt)`: leaves first,
/// cycles broken through `scratch`, which lies outside the allocator's
/// bank.
pub(super) fn schedule_int_reg_moves(code: &mut Vec<u8>, moves: &mut Vec<(u8, u8)>, scratch: Reg) {
    super::ssa::emit_common::schedule_reg_moves_via_scratch(
        code,
        moves,
        scratch.0,
        |code, t, s| emit_mov_reg(code, Reg(t), Reg(s)),
    );
}

/// `schedule_int_reg_moves` over d-registers with `fmov d, d`.
pub(super) fn schedule_dreg_moves(code: &mut Vec<u8>, moves: &mut Vec<(u8, u8)>, scratch_d: u8) {
    super::ssa::emit_common::schedule_reg_moves_via_scratch(
        code,
        moves,
        scratch_d,
        |code, t, s| emit(code, super::encode::enc_fmov_d_d(t, s)),
    );
}

/// The predecessor-exit moves for each `Inst::Phi` of every CFG
/// successor of `self_block`: the phi's incoming value for this block
/// moves into the phi's `Place`, so the phi position itself emits
/// nothing.
///
/// TODO: FpReg sources and destinations; the promotion path admits only
/// int-store slots (`slot_stores_only_int`).
pub(super) fn emit_phi_predecessor_moves(
    code: &mut Vec<u8>,
    self_block: super::super::ir::BlockId,
    func: &super::super::ir::FunctionSsa,
    alloc: &Allocation,
    scratch: &ScratchPool,
    frame: Frame,
) -> Emit {
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

/// Sequentialize a parallel copy over integer registers and spill
/// slots: leaves first; when only cycles remain one cycle source is
/// saved into `hold` and every move reading it redirected, exposing a
/// new leaf. `hold` and `stage` lie outside the allocator's bank.
/// `Err` for an FP or `None` location.
pub(super) fn schedule_place_moves(
    code: &mut Vec<u8>,
    moves: &mut Vec<(Place, Place)>,
    frame: Frame,
    hold: Reg,
    stage: Reg,
) -> Emit {
    super::ssa::emit_common::schedule_place_moves(
        &super::ssa::emit_common::Aarch64Backend,
        code,
        moves,
        frame,
        hold.0,
        stage.0,
    )
}

/// The aarch64 side of the shared phi and place-move scheduling.
impl super::ssa::emit_common::EmitBackend for super::ssa::emit_common::Aarch64Backend {
    const ARCH: &'static str = "aarch64";
    type Frame = Frame;
    fn fp_reg_mov(&self, code: &mut Vec<u8>, dst: u8, src: u8) {
        emit(code, super::encode::enc_fmov_d_d(dst, src));
    }
    fn fp_spill_store(&self, code: &mut Vec<u8>, frame: Frame, slot: u32, src: u8) {
        // FP phi moves hold no integer value, so x16 is free for the base.
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
        // `stage` holds the value and `hold` may carry a cycle source, so the
        // store borrows `hold` around an out-of-reach destination.
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
