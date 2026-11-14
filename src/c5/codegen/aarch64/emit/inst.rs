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
    pub(super) extern_tls_names:
        &'a alloc::collections::BTreeMap<u32, crate::c5::codegen::TlsSymbolRef>,
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
    /// Per value: an `ImmData` that holds its page alone ([`page_only_data`]).
    pub(super) page_only: &'a [bool],
    /// Per value: a call after which nothing runs
    /// (`emit_common::calls_ending_paths`).
    pub(super) ends_path: &'a [bool],
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
        ..
    } = *fcx;
    let code = &mut *cx.code;
    match inst {
        // `Frame::dynamic_sp` carries the alloca fact; no code. A
        // lifetime marker states a fact about storage the frame already
        // holds, so it emits nothing either, the return moves the parts
        // of an `AggParts`, and an inline asm statement places its
        // `AsmOut`s. An indeterminate value is whatever its place holds.
        Inst::AllocaInit(_)
        | Inst::LifetimeEnd(_)
        | Inst::AggParts { .. }
        | Inst::AsmOut { .. }
        | Inst::Undef => Ok(()),
        Inst::ParamRef { .. } | Inst::ParamPart { .. } | Inst::RetPart { .. } => {
            let src = super::ssa::reg_alloc::incoming_reg(param_plan, inst)
                .or_else(|| super::ssa::reg_alloc::ret_part_reg(target, inst));
            emit_incoming(code, inst, v, dst, src, alloc, frame, scratch)
        }
        Inst::Imm(_) if alloc.imm_held.get(v as usize).copied().unwrap_or(false) => Ok(()),
        Inst::Imm(value) => {
            let Some(rd) = int_or_spill_scratch(dst, scratch) else {
                return fail("Imm: dst not int reg / spill");
            };
            load_imm64(code, rd, *value as u64);
            store_spilled_int(code, frame, dst, rd);
            Ok(())
        }
        // The language handler leaves the code in x0.
        Inst::ExceptionCode => {
            let Some(rd) = int_or_spill_scratch(dst, scratch) else {
                return fail("ExceptionCode: dst not int reg / spill");
            };
            emit_mov_reg(code, rd, Reg(0));
            store_spilled_int(code, frame, dst, rd);
            Ok(())
        }
        Inst::ImmData(offset) => {
            let Some(rd) = int_or_spill_scratch(dst, scratch) else {
                return fail("ImmData: dst not int reg / spill");
            };
            // The writer's `patch_adrp_add` reads rd back from the placeholder.
            let instr_offset = code.len();
            let page_only = fcx.page_only.get(v as usize).copied().unwrap_or(false);
            if page_only {
                emit(code, enc_adrp(rd, 0));
            } else {
                emit_adrp_add(code, rd);
            }
            cx.data_fixups.push(DataFixup {
                instr_offset,
                data_offset: *offset as u64,
                addend: 0,
                part: if page_only {
                    AddrPart::Page
                } else {
                    AddrPart::Whole
                },
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
        Inst::ParentLocalAddr {
            establisher,
            parent,
            index,
        } => {
            let Some(&disp) =
                (cx.funclet_frames.get(parent)).and_then(|offsets| offsets.get(*index as usize))
            else {
                return fail("ParentLocalAddr: the filtered function's frame is not laid out");
            };
            let place = place_of(alloc, *establisher);
            let Some(rn) = materialize_int(code, place, scratch.primary, frame) else {
                return fail("ParentLocalAddr: frame value not int reg / spill");
            };
            let Some(rd) = int_or_spill_scratch(dst, scratch) else {
                return fail("ParentLocalAddr: dst not int reg / spill");
            };
            emit_reg_disp(code, rd, rn, disp);
            store_spilled_int(code, frame, dst, rd);
            Ok(())
        }
        Inst::Load {
            addr,
            disp,
            kind,
            align,
            ..
        } => {
            let start = code.len();
            emit_load(
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
            )?;
            note_in_page(cx, fcx, *addr, start)
        }
        Inst::Store {
            addr,
            disp,
            value,
            kind,
            align,
            ..
        } => {
            let start = code.len();
            emit_store(
                code,
                v,
                dst,
                *addr,
                *disp,
                *value,
                *kind,
                alloc,
                frame,
                scratch,
                narrow_bound(*align, abi),
            )?;
            note_in_page(cx, fcx, *addr, start)
        }
        Inst::LoadLocal {
            off, disp, kind, ..
        } => emit_load_local(
            code,
            dst,
            *off,
            *disp,
            *kind,
            alloc.is_f32(v),
            func,
            frame,
            scratch,
        ),
        Inst::StoreLocal {
            off,
            disp,
            value,
            kind,
            ..
        } => emit_store_local(
            code, v, dst, *off, *disp, *value, *kind, alloc, func, frame, scratch,
        ),
        Inst::LoadIndexed {
            base,
            index,
            index_ext,
            scale,
            kind,
            ..
        } => emit_load_indexed(
            code,
            dst,
            *base,
            (*index, *index_ext),
            *scale,
            *kind,
            alloc,
            frame,
            scratch,
        ),
        Inst::StoreIndexed {
            base,
            index,
            index_ext,
            scale,
            value,
            kind,
            ..
        } => emit_store_indexed(
            code,
            v,
            dst,
            *base,
            (*index, *index_ext),
            *scale,
            *value,
            *kind,
            alloc,
            frame,
            scratch,
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
        Inst::ShiftOp {
            op,
            lhs,
            rhs,
            shift,
            amount,
        } => emit_shift_op(
            code, dst, *op, *lhs, *rhs, *shift, *amount, alloc, frame, scratch,
        ),
        Inst::BitField {
            value,
            lsb,
            width,
            signed,
        } => emit_bit_field(
            code, dst, *value, *lsb, *width, *signed, alloc, frame, scratch,
        ),
        Inst::BinopI { op, lhs, rhs_imm } => {
            emit_binop_imm(code, *op, v, dst, *lhs, *rhs_imm, alloc, frame, scratch)
        }
        Inst::Call {
            target_pc,
            args,
            fixed_args,
            fp_return,
            fp_arg_mask,
            arg_widths,
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
                fp_arg_mask,
                arg_widths: *arg_widths,
                arg_aggs,
                ret_agg: *ret_agg,
                ret_slot_off: *ret_slot_local,
                ends_path: fcx.ends_path[v as usize],
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
            arg_widths,
            arg_aggs,
            ret_agg,
            ret_slot_local,
            ..
        } => emit_call_ext(
            code,
            dst,
            v,
            fcx,
            CallOperands {
                args,
                fp_arg_mask,
                arg_widths: *arg_widths,
                arg_aggs,
                ret_agg: *ret_agg,
                ret_slot_off: *ret_slot_local,
                ends_path: fcx.ends_path[v as usize],
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
            arg_widths,
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
                fp_arg_mask,
                arg_widths: *arg_widths,
                arg_aggs,
                ret_agg: *ret_agg,
                ret_slot_off: *ret_slot_local,
                ends_path: fcx.ends_path[v as usize],
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
            v,
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
        Inst::Mzero {
            dst: d,
            size,
            align,
        } => emit_mzero(
            code,
            *d,
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
            order,
        } => emit_atomic_rmw(
            code, v, dst, *op, *addr, *value, *width, *order, alloc, frame, scratch,
        ),
        Inst::AtomicCas {
            addr,
            expected,
            desired,
            width,
            order,
        } => emit_atomic_cas(
            code, v, dst, *addr, *expected, *desired, *width, *order, alloc, frame, scratch,
        ),
        Inst::AtomicCas16 {
            addr,
            expected,
            desired,
            order,
        } => emit_atomic_cas16(
            code, dst, *addr, *expected, *desired, *order, alloc, frame, scratch,
        ),
        Inst::AtomicLoad { addr, width, order } => {
            emit_atomic_load(code, dst, *addr, *width, *order, alloc, frame, scratch)
        }
        Inst::AtomicStore {
            addr,
            value,
            width,
            order,
        } => emit_atomic_store(code, *addr, *value, *width, *order, alloc, frame, scratch),
        Inst::Intrinsic { kind, args } => {
            emit_intrinsic(code, func, abi, *kind, args, dst, v, alloc, frame, scratch)
        }
        Inst::Neg(value) => emit_neg(code, dst, *value, alloc, frame, scratch),
        Inst::Select { cond, a, b, kind } => super::arith::emit_select(
            code,
            dst,
            (v, *cond, *a, *b, *kind),
            func,
            alloc,
            frame,
            scratch,
        ),
        Inst::Fneg(src) => emit_fneg(code, *src, v, dst, alloc, frame),
        Inst::Simd { op, imm, args } => {
            emit_a64_simd(code, (*op, *imm), args, alloc, frame, scratch)
        }
        Inst::SimdVal { op, imm, args } => {
            emit_a64_simd_val(code, (*op, *imm), args, dst, alloc, frame, scratch)
        }
        Inst::VecBinop {
            op,
            lane,
            bytes,
            lhs,
            rhs,
        } => emit_vec_binop(
            code,
            (*op, *lane, *bytes),
            (*lhs, *rhs),
            dst,
            alloc,
            frame,
            scratch,
        ),
        Inst::VecExtract {
            vec,
            off,
            kind,
            bytes,
        } => emit_vec_extract(
            code,
            (*vec, *off, *kind, *bytes),
            dst,
            alloc,
            frame,
            scratch,
        ),
        Inst::VecInsert {
            vec,
            value,
            off,
            kind,
            bytes,
        } => emit_vec_insert(
            code,
            (*vec, *value, *off, *kind, *bytes),
            match func.insts[*vec as usize] {
                Inst::Undef => Some(true),
                Inst::Imm(0) => Some(false),
                _ => None,
            },
            (dst, alloc, frame, scratch),
        ),
        Inst::VecSplat { value, kind, bytes } => {
            emit_vec_splat(code, (*value, *kind, *bytes), (dst, alloc, frame, scratch))
        }
        Inst::VecConst { imm, kind, bytes } => {
            emit_vec_const(code, (*imm, *kind, *bytes), (dst, frame, scratch))
        }
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
        Inst::Extend { value, kind, .. } => {
            emit_extend(code, dst, v, *value, *kind, alloc, frame, scratch)
        }
        Inst::Bswap { value, width } => {
            emit_bswap(code, dst, *value, *width, alloc, frame, scratch)
        }
        Inst::BitCount { op, value, width } => {
            emit_bit_count(code, dst, *op, *value, *width, alloc, frame, scratch)
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
            (target, func.tls_dynamic),
            cx.tls_index_fixups,
            macho_tlv_fixups,
            macho_tlv_descriptors,
            cx.elf_tpoff_fixups,
            extern_tls_names.get(&v),
            tls_align,
        ),
        // The predecessor-exit moves placed the value; nothing at the phi
        // position.
        Inst::Phi { .. } => Ok(()),
        Inst::InlineAsm { asm, args } => emit_inline_asm_aarch64(
            code,
            asm,
            args,
            v,
            func,
            alloc,
            frame,
            fixups,
            name2entpc,
            extern_data_names,
            data_sym_offsets,
            target.binary_format(),
            cx.asm_sections,
            cx.asm_extern_call_sites,
            cx.asm_sym_fixups,
            deferred_regions,
            cx.text_data_ranges,
            cx.text_align,
            cx.data_fixups,
            cx.pending_func_fixups,
            cx.user_extern_data_refs,
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
/// Record the access emitted from `start` through a page-only `addr` as the
/// in-page half of its reference: the one unsigned-offset load or store
/// whose base is the register holding the page.
fn note_in_page(
    cx: &mut super::ssa::emit_common::EmitCtx,
    fcx: &FnCtx,
    addr: super::super::ir::ValueId,
    start: usize,
) -> Emit {
    if !fcx.page_only.get(addr as usize).copied().unwrap_or(false) {
        return Ok(());
    }
    let Inst::ImmData(off) = fcx.func.insts[addr as usize] else {
        return fail("page-only access: address not a data address");
    };
    let page = match place_of(fcx.alloc, addr) {
        Place::IntReg(r) => u32::from(r),
        _ => u32::from(fcx.scratch.primary.0),
    };
    let code = &*cx.code;
    let sites: Vec<usize> = (start..code.len())
        .step_by(4)
        .filter(|&at| {
            let w = u32::from_le_bytes([code[at], code[at + 1], code[at + 2], code[at + 3]]);
            crate::c5::codegen::aarch64::patch::lo12_access_size(w).is_some()
                && (w >> 5) & 31 == page
                && (w >> 10) & 0xFFF == 0
        })
        .collect();
    let [at] = sites[..] else {
        return fail("page-only access: no single in-page load / store");
    };
    cx.data_fixups.push(DataFixup {
        instr_offset: at,
        data_offset: off as u64,
        addend: 0,
        part: AddrPart::InPage,
    });
    Ok(())
}

pub(super) fn emit_adrp_add(code: &mut Vec<u8>, rd: Reg) {
    emit(code, enc_adrp(rd, 0));
    emit(code, enc_add_imm(rd, rd, 0));
}

/// `Inst::ParamRef` / `Inst::ParamPart` / `Inst::RetPart`: the argument
/// or result register `src` names into the value's place, an integer one
/// converted from the low `kind` bytes per C99 6.3.1.3.
#[allow(clippy::too_many_arguments)]
fn emit_incoming(
    code: &mut Vec<u8>,
    inst: &Inst,
    v: super::super::ir::ValueId,
    dst: Place,
    src: Option<(bool, u8)>,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> Emit {
    let (Inst::ParamRef { kind, .. } | Inst::ParamPart { kind, .. } | Inst::RetPart { kind, .. }) =
        inst
    else {
        return fail("incoming: not a register read");
    };
    let name = inst.variant_name();
    let Some((is_fp, src)) = src else {
        return fail(alloc::format!("{name}: no incoming register"));
    };
    if *kind == LoadKind::V128 {
        if !is_fp {
            return fail(alloc::format!("{name}: vector from an integer register"));
        }
        match dst {
            Place::FpReg(r) => {
                if r != src {
                    emit(code, super::encode::enc_mov_v16b(r, src));
                }
            }
            Place::Spill(slot) => {
                emit_spill_str_q(code, frame, src, v128_spill_off(frame, slot), Reg(16));
            }
            _ => return fail(alloc::format!("{name}: vector dst not fp reg / spill")),
        }
        return Ok(());
    }
    if matches!(kind, LoadKind::F32 | LoadKind::F64) {
        if !is_fp {
            return fail(alloc::format!("{name}: FP value from an integer register"));
        }
        match dst {
            Place::FpReg(r) => {
                if r != src {
                    emit(code, super::encode::enc_fmov_d_d(r, src));
                }
            }
            Place::Spill(slot) => {
                let sp_off = spill_off(frame, slot);
                emit_spill_str_d_auto(code, frame, src, sp_off);
            }
            _ => return fail(alloc::format!("{name}: FP dst not fp reg / spill")),
        }
        return Ok(());
    }
    if is_fp {
        return fail(alloc::format!("{name}: integer value from an FP register"));
    }
    let ext = param_entry_ext(*kind, v, alloc);
    let sign_extend = |code: &mut Vec<u8>, rd: Reg| {
        emit_sign_extend(code, rd, Reg(src), ext.unwrap_or(LoadKind::I64));
    };
    match dst {
        Place::IntReg(r) => sign_extend(code, Reg(r)),
        Place::Spill(slot) => {
            sign_extend(code, scratch.primary);
            let sp_off = spill_off(frame, slot);
            emit_spill_str_x(code, frame, scratch.primary, sp_off, scratch.secondary);
        }
        _ => return fail(alloc::format!("{name}: dst not int reg / spill")),
    }
    Ok(())
}

/// `Inst::VecBinop`: the AdvSIMD instruction on the operands' v registers,
/// a spilled one reloaded into an FP scratch, the result spilled from one.
/// An 8-byte vector takes the 64-bit form on the d registers.
fn emit_vec_binop(
    code: &mut CodeBuf,
    (op, lane, bytes): (super::super::ir::BinOp, super::super::ir::VecLane, u8),
    (lhs, rhs): (super::super::ir::ValueId, super::super::ir::ValueId),
    dst: Place,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> Emit {
    let Some(qd) = fp_or_spill_dst(dst, frame) else {
        return fail("VecBinop: dst not fp reg / spill");
    };
    if bytes == 8 {
        let Some(dn) = materialize_fp(code, place_of(alloc, lhs), frame.fp_scratch[0], frame)
        else {
            return fail("VecBinop: lhs not fp reg / spill");
        };
        let Some(dm) = materialize_fp(code, place_of(alloc, rhs), frame.fp_scratch[1], frame)
        else {
            return fail("VecBinop: rhs not fp reg / spill");
        };
        let Some(word) = super::encode::enc_vec_binop(op, lane, qd, dn, u32::from(dm)) else {
            return fail(alloc::format!(
                "VecBinop: no instruction for {op:?} on {lane:?}"
            ));
        };
        // The 64-bit form: Q clear.
        emit(code, word & !0x4000_0000);
        store_spilled_fp(code, frame, dst, qd);
        return Ok(());
    }
    let Some(qn) = materialize_v128(
        code,
        place_of(alloc, lhs),
        frame.fp_scratch[0],
        frame,
        scratch.primary,
    ) else {
        return fail("VecBinop: lhs not fp reg / spill");
    };
    let Some(qm) = materialize_v128(
        code,
        place_of(alloc, rhs),
        frame.fp_scratch[1],
        frame,
        scratch.primary,
    ) else {
        return fail("VecBinop: rhs not fp reg / spill");
    };
    let Some(word) = super::encode::enc_vec_binop(op, lane, qd, qn, u32::from(qm)) else {
        return fail(alloc::format!(
            "VecBinop: no instruction for {op:?} on {lane:?}"
        ));
    };
    emit(code, word);
    propagate_v128(code, frame, dst, qd, scratch.primary);
    Ok(())
}

/// `Inst::VecExtract`: `umov` / `smov` of the lane into an integer register,
/// extended as `kind` reads it, or `dup` of it into a scalar FP one.
fn emit_vec_extract(
    code: &mut CodeBuf,
    (vec, off, kind, bytes): (super::super::ir::ValueId, u8, LoadKind, u8),
    dst: Place,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> Emit {
    use super::encode::{enc_dup_elem_scalar, enc_smov_gen, enc_umov_gen};
    // An 8-byte vector's lanes are the low ones of its D register's.
    let place = place_of(alloc, vec);
    let qn = match bytes {
        16 => materialize_v128(code, place, frame.fp_scratch[0], frame, scratch.primary),
        8 => materialize_fp(code, place, frame.fp_scratch[0], frame),
        _ => return fail("VecExtract: only 8- and 16-byte vectors"),
    };
    let Some(qn) = qn else {
        return fail("VecExtract: vector has no place");
    };
    let esize = match kind {
        LoadKind::F64 | LoadKind::I64 => 8,
        LoadKind::F32 | LoadKind::I32 | LoadKind::U32 => 4,
        LoadKind::I16 | LoadKind::U16 => 2,
        LoadKind::I8 | LoadKind::U8 => 1,
        _ => return fail("VecExtract: not a lane kind"),
    };
    let index = u32::from(off) / esize;
    if matches!(kind, LoadKind::F32 | LoadKind::F64) {
        let Some(dd) = fp_or_spill_dst(dst, frame) else {
            return fail("VecExtract: dst not fp reg / spill");
        };
        // A scalar reads only its low bits: the low lane in place is it.
        if index == 0 && dd == qn && matches!(dst, Place::FpReg(_)) {
            return Ok(());
        }
        emit(code, enc_dup_elem_scalar(dd, qn, esize, index));
        store_spilled_fp(code, frame, dst, dd);
        return Ok(());
    }
    let Some(rd) = int_or_spill_scratch(dst, scratch) else {
        return fail("VecExtract: dst not int reg / spill");
    };
    let word = match kind {
        LoadKind::I32 | LoadKind::I16 | LoadKind::I8 => enc_smov_gen(rd, qn, esize, index),
        _ => enc_umov_gen(rd, qn, esize, index),
    };
    emit(code, word);
    store_spilled_int(code, frame, dst, rd);
    Ok(())
}

/// The bytes of a lane of `kind`, for the widths a lane access moves.
fn lane_bytes(kind: StoreKind) -> Option<u8> {
    match kind {
        StoreKind::I8 => Some(1),
        StoreKind::I16 => Some(2),
        StoreKind::I32 | StoreKind::F32 => Some(4),
        StoreKind::I64 | StoreKind::F64 => Some(8),
        _ => None,
    }
}

/// The loads and lane reads each fused into the one lane insert or store
/// that reads it: a non-volatile access through its address alone, of the
/// lane's width and naturally aligned, with nothing emitted between the
/// two, so `ld1` / `st1` of the lane performs both and the address and
/// vector registers still hold their values there.
pub(super) fn lane_memory(func: &FunctionSsa, alloc: &Allocation) -> Vec<bool> {
    let mut fused = alloc::vec![false; func.insts.len()];
    let single = |v: super::super::ir::ValueId| alloc.use_counts.get(v as usize) == Some(&1);
    let quiet = |from: super::super::ir::ValueId, to: usize| {
        (from as usize + 1..to).all(|u| {
            super::ssa::emit_common::inst_emits_nothing(
                &func.insts[u],
                u as super::super::ir::ValueId,
                alloc,
            )
        })
    };
    let aligned = |align: u8, w: u8| align == 0 || align >= w;
    for block in &func.blocks {
        for v in block.inst_range.clone() {
            let i = v as usize;
            let (value, w) = match func.insts[i] {
                Inst::VecInsert {
                    vec,
                    value,
                    kind,
                    bytes: 8 | 16,
                    ..
                } if !matches!(func.insts[vec as usize], Inst::Imm(0)) => (value, lane_bytes(kind)),
                Inst::Store {
                    disp: 0,
                    value,
                    kind,
                    volatile: false,
                    pc_rel: false,
                    align,
                    ..
                } => (value, lane_bytes(kind).filter(|&w| aligned(align, w))),
                _ => continue,
            };
            let Some(w) = w else { continue };
            if !block.inst_range.contains(&value)
                || value >= v
                || !single(value)
                || !quiet(value, i)
            {
                continue;
            }
            let f32_ok = |k: LoadKind| k != LoadKind::F32 || alloc.is_f32(value);
            fused[value as usize] = match (&func.insts[i], &func.insts[value as usize]) {
                (
                    Inst::VecInsert { .. },
                    &Inst::Load {
                        disp: 0,
                        kind,
                        volatile: false,
                        pc_rel: false,
                        align,
                        ..
                    },
                ) => kind.bytes() == w && aligned(align, w) && f32_ok(kind),
                (
                    Inst::Store { .. },
                    &Inst::VecExtract {
                        kind,
                        bytes: 8 | 16,
                        ..
                    },
                ) => kind.bytes() == w && f32_ok(kind),
                _ => false,
            };
        }
    }
    fused
}

/// A pointer step and the access through the stepped pointer that one
/// post-indexed load or store performs.
#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum PostIndex {
    /// The step `q = p + k`, which the access performs.
    Step,
    /// The access at `[q - k]`, emitted as `[p], #k`.
    Access(i32),
}

/// The register a post-indexed access moves data through, and its form:
/// an integer access with its value in a general register, or a `float` or
/// `double` load into a floating register.
fn post_indexed_op(func: &FunctionSsa, alloc: &Allocation, a: usize) -> Option<(MemOp, u8, i32)> {
    let reg = |v: super::super::ir::ValueId| match place_of(alloc, v) {
        Place::IntReg(r) if r != 31 => Some((r, false)),
        Place::FpReg(r) => Some((r, true)),
        _ => None,
    };
    match func.insts[a] {
        Inst::Load {
            disp,
            kind,
            pc_rel: false,
            align: 0,
            ..
        } => {
            let (rt, fp) = reg(a as super::super::ir::ValueId)?;
            let op = match kind {
                LoadKind::F64 => LDR_D,
                LoadKind::F32 if alloc.is_f32(a as super::super::ir::ValueId) => LDR_S,
                k => int_load_op(k)?,
            };
            (fp == matches!(kind, LoadKind::F32 | LoadKind::F64)).then_some((op, rt, disp))
        }
        Inst::Store {
            disp,
            value,
            kind,
            pc_rel: false,
            align: 0,
            ..
        } if place_of(alloc, a as super::super::ir::ValueId) == Place::None => {
            // A stored zero comes out of the zero register; the constant
            // has no register of its own (`Allocation::imm_store`).
            let rt = if alloc.imm_store.get(a) == Some(&true) {
                31
            } else {
                let (r, false) = reg(value)? else {
                    return None;
                };
                r
            };
            Some((int_store_op(kind)?, rt, disp))
        }
        _ => None,
    }
}

/// Steps `q = p + k` that keep `p`'s register, each with the access through
/// `[q - k]` emitted next, which one post-indexed access performs.
pub(super) fn post_indexed(func: &FunctionSsa, alloc: &Allocation) -> Vec<Option<PostIndex>> {
    let mut out = alloc::vec![None; func.insts.len()];
    for block in &func.blocks {
        for v in block.inst_range.clone() {
            let (p, k) = match func.insts[v as usize] {
                Inst::BinopI {
                    op: BinOp::Add,
                    lhs,
                    rhs_imm,
                } => (lhs, rhs_imm),
                Inst::BinopI {
                    op: BinOp::Sub,
                    lhs,
                    rhs_imm,
                } => (lhs, rhs_imm.wrapping_neg()),
                _ => continue,
            };
            let r = place_of(alloc, v);
            if !(-256..256).contains(&k)
                || k == 0
                || !matches!(r, Place::IntReg(x) if x != 31)
                || place_of(alloc, p) != r
                || alloc.high_dead(v)
                || super::ssa::emit_common::inst_emits_nothing(&func.insts[v as usize], v, alloc)
            {
                continue;
            }
            let next = (v + 1..block.inst_range.end).find(|&u| {
                !super::ssa::emit_common::inst_emits_nothing(&func.insts[u as usize], u, alloc)
            });
            let Some(a) = next else { continue };
            let addr = match func.insts[a as usize] {
                Inst::Load { addr, .. } | Inst::Store { addr, .. } => addr,
                _ => continue,
            };
            let Place::IntReg(rn) = r else { continue };
            if let Some((_, rt, disp)) = post_indexed_op(func, alloc, a as usize)
                && addr == v
                && i64::from(disp) == -k
                && (rt != rn || matches!(place_of(alloc, a), Place::FpReg(_)))
                && alloc
                    .call_saves
                    .binary_search_by_key(&a, |&(site, _)| site)
                    .is_err()
            {
                out[v as usize] = Some(PostIndex::Step);
                out[a as usize] = Some(PostIndex::Access(k as i32));
            }
        }
    }
    out
}

/// The post-indexed access [`post_indexed`] paired with the step ahead of
/// it; `None` for any other instruction.
pub(super) fn emit_post_indexed(
    code: &mut Vec<u8>,
    v: super::super::ir::ValueId,
    paired: &[Option<PostIndex>],
    fcx: &FnCtx,
) -> Option<Emit> {
    let Some(PostIndex::Access(k)) = paired.get(v as usize).copied().flatten() else {
        return None;
    };
    let (func, alloc) = (fcx.func, fcx.alloc);
    let (op, rt, _) = post_indexed_op(func, alloc, v as usize)?;
    let (Inst::Load { addr, .. } | Inst::Store { addr, .. }) = func.insts[v as usize] else {
        return None;
    };
    let Place::IntReg(rn) = place_of(alloc, addr) else {
        return Some(fail("post-indexed access: base not in a register"));
    };
    let off = op.post_indexed(k.into())?;
    emit(code, enc_mem(op, rt, Reg(rn), off));
    Some(Ok(()))
}

/// An add or subtract of an immediate whose flags the branch ending its
/// block reads ([`flag_steps`]), and the comparison those flags answer.
#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum FlagStep {
    /// `adds` / `subs`, of the low words when `w32`.
    Sets { w32: bool },
    /// A comparison the step's flags answer with the condition: no code.
    Answered(Cond),
}

/// Steps `y = x + k` whose flags answer the branch ending their block: a
/// zero test of `y` -- the branch condition itself or a fused `==` / `!=`
/// with 0 -- reads Z, and `y != -1` of `y = x - 1` reads C, set exactly
/// when `x != 0`. Nothing is emitted between the step and its comparison,
/// and nothing after the step sets the flags. A low-word test takes the
/// 32-bit form, which only a step whose upper half nothing reads may.
pub(super) fn flag_steps(func: &FunctionSsa, alloc: &Allocation) -> Vec<Option<FlagStep>> {
    use super::super::ir::ValueId;
    let mut out = alloc::vec![None; func.insts.len()];
    let step = |y: ValueId| match func.insts[y as usize] {
        Inst::BinopI {
            op: BinOp::Add,
            lhs,
            rhs_imm,
        } => Some((lhs, rhs_imm)),
        Inst::BinopI {
            op: BinOp::Sub,
            lhs,
            rhs_imm,
        } => rhs_imm.checked_neg().map(|k| (lhs, k)),
        _ => None,
    };
    let silent =
        |u: ValueId| super::ssa::emit_common::inst_emits_nothing(&func.insts[u as usize], u, alloc);
    let in_reg = |v: ValueId| matches!(place_of(alloc, v), Place::IntReg(r) if r != 31);
    for (b, block) in func.blocks.iter().enumerate().skip(1) {
        let (Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. }) = block.terminator else {
            continue;
        };
        if !block.inst_range.contains(&cond) {
            continue;
        }
        let (y, answer, w32) = if alloc.branch_fused.get(cond as usize) == Some(&true) {
            let Inst::BinopI {
                op: op @ (BinOp::Eq | BinOp::Ne),
                lhs: y,
                rhs_imm,
            } = func.insts[cond as usize]
            else {
                continue;
            };
            if !block.inst_range.contains(&y) || y >= cond || !(y + 1..cond).all(silent) {
                continue;
            }
            let decrement = step(y).is_some_and(|(_, k)| k == -1);
            let cc = match (rhs_imm, op) {
                (0, BinOp::Eq) => Cond::Eq,
                (0, _) => Cond::Ne,
                (-1, BinOp::Eq) if decrement => Cond::Lo,
                (-1, _) if decrement => Cond::Hs,
                _ => continue,
            };
            (y, Some(cc), narrow_cmp(alloc, cond))
        } else {
            let keeps = |u: ValueId| {
                silent(u) || super::ssa::reg_alloc::flags_survive(&func.insts[u as usize], false)
            };
            if !(cond + 1..block.inst_range.end).all(keeps) {
                continue;
            }
            let low_word = func.low_word_tests.get(b).copied().unwrap_or(false);
            (cond, None, low_word)
        };
        let Some((x, k)) = step(y) else { continue };
        if k.unsigned_abs() >= 4096 || !in_reg(y) || !in_reg(x) || (w32 && !alloc.high_dead(y)) {
            continue;
        }
        out[y as usize] = Some(FlagStep::Sets { w32 });
        if let Some(cc) = answer {
            out[cond as usize] = Some(FlagStep::Answered(cc));
        }
    }
    out
}

/// The step or comparison [`flag_steps`] marked; `None` for any other
/// instruction.
pub(super) fn emit_flag_step(
    code: &mut Vec<u8>,
    v: super::super::ir::ValueId,
    steps: &[Option<FlagStep>],
    fcx: &FnCtx,
) -> Option<Emit> {
    let (lhs, k) = match (
        steps.get(v as usize).copied().flatten()?,
        &fcx.func.insts[v as usize],
    ) {
        (FlagStep::Answered(_), _) => return Some(Ok(())),
        (FlagStep::Sets { .. }, &Inst::BinopI { op, lhs, rhs_imm }) => match op {
            BinOp::Sub => (lhs, rhs_imm.checked_neg()?),
            _ => (lhs, rhs_imm),
        },
        _ => return None,
    };
    let Some(FlagStep::Sets { w32 }) = steps[v as usize] else {
        return None;
    };
    let (Place::IntReg(rd), Place::IntReg(rn)) = (place_of(fcx.alloc, v), place_of(fcx.alloc, lhs))
    else {
        return Some(fail("flag step: operand not in a register"));
    };
    let (rd, rn, m) = (Reg(rd), Reg(rn), k.unsigned_abs() as u32);
    emit(
        code,
        match (k >= 0, w32) {
            (true, false) => super::encode::enc_adds_imm(rd, rn, m),
            (true, true) => super::encode::enc_adds_imm_w(rd, rn, m),
            (false, false) => enc_subs_imm(rd, rn, m),
            (false, true) => super::encode::enc_subs_imm_w(rd, rn, m),
        },
    );
    Some(Ok(()))
}

/// The condition a branch on `cond` takes off a [`flag_steps`] step's
/// flags: the comparison's answer, or the step's own zero test.
pub(super) fn flag_step_cond(
    steps: &[Option<FlagStep>],
    cond: super::super::ir::ValueId,
    negate: bool,
) -> Option<Cond> {
    let cc = match steps.get(cond as usize).copied().flatten()? {
        FlagStep::Answered(cc) => cc,
        FlagStep::Sets { .. } => Cond::Ne,
    };
    Some(if negate { cc.flip() } else { cc })
}

/// `ld1` or `st1` of one lane for a lane insert or store whose value
/// [`lane_memory`] fused into it; `None` for any other instruction.
pub(super) fn emit_lane_memory(
    code: &mut CodeBuf,
    inst: &Inst,
    fused: &[bool],
    dst: Place,
    fcx: &FnCtx,
) -> Option<Emit> {
    let FnCtx {
        func,
        alloc,
        frame,
        scratch,
        ..
    } = *fcx;
    let is_fused = |v: super::super::ir::ValueId| fused.get(v as usize).copied().unwrap_or(false);
    let (vec, off, w, bytes, addr, load) = match *inst {
        Inst::VecInsert {
            vec,
            value,
            off,
            kind,
            bytes,
        } if is_fused(value) => {
            let Inst::Load { addr, .. } = func.insts[value as usize] else {
                return None;
            };
            (vec, off, lane_bytes(kind)?, bytes, addr, true)
        }
        Inst::Store { addr, value, .. } if is_fused(value) => {
            let Inst::VecExtract {
                vec,
                off,
                kind,
                bytes,
            } = func.insts[value as usize]
            else {
                return None;
            };
            (vec, off, kind.bytes(), bytes, addr, false)
        }
        _ => return None,
    };
    let Some(rn) = materialize_int(code, place_of(alloc, addr), scratch.primary, frame) else {
        return Some(fail("lane access: address has no place"));
    };
    let qd = match (load, dst) {
        (true, Place::FpReg(r)) => r,
        _ => frame.fp_scratch[0],
    };
    // A lane loaded over an undefined vector forms in the result's register.
    let qn = match bytes {
        _ if load && matches!(func.insts[vec as usize], Inst::Undef) => Some(qd),
        16 => materialize_v128(code, place_of(alloc, vec), qd, frame, scratch.secondary),
        _ => materialize_fp(code, place_of(alloc, vec), qd, frame),
    };
    let Some(qn) = qn else {
        return Some(fail("lane access: vector has no place"));
    };
    let esize = u32::from(w);
    let index = u32::from(off) / esize;
    // Lane 0 is the low bytes a scalar store of the width writes.
    if !load {
        use super::encode::{STR_B, STR_D, STR_H, STR_S, enc_ld1_st1_lane, enc_mem};
        let op = [STR_B, STR_H, STR_S, STR_D][esize.trailing_zeros() as usize];
        emit(
            code,
            match index {
                0 => enc_mem(op, qn, rn, op.scaled(0)),
                _ => enc_ld1_st1_lane(false, qn, esize, index, rn),
            },
        );
        return Some(Ok(()));
    }
    if qn != qd {
        emit(code, super::encode::enc_mov_v16b(qd, qn));
    }
    emit(
        code,
        super::encode::enc_ld1_st1_lane(true, qd, esize, index, rn),
    );
    if bytes == 16 {
        propagate_v128(code, frame, dst, qd, scratch.primary);
    } else {
        store_spilled_fp(code, frame, dst, qd);
    }
    Some(Ok(()))
}

/// `Inst::VecInsert`: `ins` of the value into the lane of a copy of the
/// vector, from a general register or from the low element of an FP one.
/// `blank` is `Some(undefined)` for a vector of no value or of zero.
fn emit_vec_insert(
    code: &mut CodeBuf,
    (vec, value, off, kind, bytes): (
        super::super::ir::ValueId,
        super::super::ir::ValueId,
        u8,
        StoreKind,
        u8,
    ),
    blank: Option<bool>,
    (dst, alloc, frame, scratch): (Place, &Allocation, Frame, &ScratchPool),
) -> Emit {
    use super::encode::{enc_ins_elem, enc_ins_gen};
    if bytes != 16 && bytes != 8 {
        return fail("VecInsert: only 8- and 16-byte vectors");
    }
    // The result at the vector's width: an 8-byte one is its D register,
    // moved there when it formed in the scratch.
    let propagate = |code: &mut CodeBuf, qd: u8| {
        if bytes == 16 {
            propagate_v128(code, frame, dst, qd, scratch.primary);
            return;
        }
        if let Place::FpReg(r) = dst
            && r != qd
        {
            emit(code, super::encode::enc_fmov_d_d(r, qd));
        }
        store_spilled_fp(code, frame, dst, qd);
    };
    let esize = match kind {
        StoreKind::F64 | StoreKind::I64 => 8,
        StoreKind::F32 | StoreKind::I32 => 4,
        StoreKind::I16 => 2,
        StoreKind::I8 => 1,
        _ => return fail("VecInsert: not a lane kind"),
    };
    let index = u32::from(off) / esize;
    let float = matches!(kind, StoreKind::F32 | StoreKind::F64);
    // The value first, as the result may take its register.
    let src = if float {
        let Some(f) = materialize_fp(code, place_of(alloc, value), frame.fp_scratch[1], frame)
        else {
            return fail("VecInsert: value has no place");
        };
        f
    } else {
        let Some(r) = materialize_int(code, place_of(alloc, value), scratch.primary, frame) else {
            return fail("VecInsert: value has no place");
        };
        r.0
    };
    // A 64-bit lane between two registers: `zip1` pairs the low lanes
    // into any register, and a result over the value keeps its low lane.
    if float
        && esize == 8
        && bytes == 16
        && let (Place::FpReg(d), Place::FpReg(n)) = (dst, place_of(alloc, vec))
        && d != n
    {
        if off == 8 {
            emit(code, super::encode::enc_zip1_2d(d, n, src));
            return Ok(());
        }
        if d == src {
            emit(code, super::encode::enc_ins_elem_from(d, 8, 1, n, 1));
            return Ok(());
        }
    }
    let qd = match dst {
        Place::FpReg(r) if !(float && r == src) => r,
        _ => frame.fp_scratch[0],
    };
    // The low lane over a zero or undefined vector: a scalar `fmov` clears
    // the bits above it, and over an undefined one the value's register
    // already is the result.
    if let Some(undefined) = blank
        && off == 0
        && esize >= 4
    {
        let qd = match dst {
            Place::FpReg(r) => r,
            _ => frame.fp_scratch[0],
        };
        if !(undefined && float && qd == src) {
            emit(
                code,
                match (float, esize) {
                    (true, 8) => super::encode::enc_fmov_d_d(qd, src),
                    (true, _) => super::encode::enc_fmov_s_s(qd, src),
                    (false, 8) => super::encode::enc_fmov_x_to_d(qd, Reg(src)),
                    (false, _) => super::encode::enc_fmov_w_to_s(qd, Reg(src)),
                },
            );
        }
        propagate(code, qd);
        return Ok(());
    }
    // An undefined vector leaves the register as it is.
    let base = place_of(alloc, vec);
    if blank != Some(true) && !matches!(base, Place::None) {
        let qn = match bytes {
            16 => materialize_v128(code, base, qd, frame, scratch.secondary),
            _ => materialize_fp(code, base, qd, frame),
        };
        let Some(qn) = qn else {
            return fail("VecInsert: vector has no place");
        };
        if qn != qd {
            emit(code, super::encode::enc_mov_v16b(qd, qn));
        }
    }
    emit(
        code,
        if float {
            enc_ins_elem(qd, esize, index, src)
        } else {
            enc_ins_gen(qd, esize, index, Reg(src))
        },
    );
    propagate(code, qd);
    Ok(())
}

/// `Inst::VecSplat`: `dup` of a general register, or of an FP register's
/// low element, into every lane; one 64-bit lane is the value's `fmov`.
fn emit_vec_splat(
    code: &mut CodeBuf,
    (value, kind, bytes): (super::super::ir::ValueId, StoreKind, u8),
    (dst, alloc, frame, scratch): (Place, &Allocation, Frame, &ScratchPool),
) -> Emit {
    use super::encode::{enc_dup_elem, enc_dup_gen, enc_fmov_d_d, enc_fmov_x_to_d};
    if bytes != 16 && bytes != 8 {
        return fail("VecSplat: only 8- and 16-byte vectors");
    }
    let esize = match kind {
        StoreKind::F64 | StoreKind::I64 => 8,
        StoreKind::F32 | StoreKind::I32 => 4,
        StoreKind::I16 => 2,
        StoreKind::I8 => 1,
        _ => return fail("VecSplat: not a lane kind"),
    };
    let float = matches!(kind, StoreKind::F32 | StoreKind::F64);
    let src = if float {
        materialize_fp(code, place_of(alloc, value), frame.fp_scratch[1], frame)
    } else {
        materialize_int(code, place_of(alloc, value), scratch.primary, frame).map(|r| r.0)
    };
    let Some(src) = src else {
        return fail("VecSplat: value has no place");
    };
    let qd = match dst {
        Place::FpReg(r) => r,
        _ => frame.fp_scratch[0],
    };
    let q = bytes == 16;
    match (float, esize, q) {
        (true, 8, false) if qd == src => {}
        (true, 8, false) => emit(code, enc_fmov_d_d(qd, src)),
        (false, 8, false) => emit(code, enc_fmov_x_to_d(qd, Reg(src))),
        (true, ..) => emit(code, enc_dup_elem(qd, esize, q, src)),
        (false, ..) => emit(code, enc_dup_gen(qd, esize, q, Reg(src))),
    }
    if q {
        propagate_v128(code, frame, dst, qd, scratch.primary);
    } else {
        store_spilled_fp(code, frame, dst, qd);
    }
    Ok(())
}

/// `Inst::VecConst`: one `movi` or `mvni` where the lanes have the modified
/// immediate form -- zero, all ones, bytes of either, a byte shifted within
/// its lane -- else the lane built in a general register and `dup`ed.
fn emit_vec_const(
    code: &mut CodeBuf,
    (imm, kind, bytes): (i64, StoreKind, u8),
    (dst, frame, scratch): (Place, Frame, &ScratchPool),
) -> Emit {
    use super::table::{self, Opnd};
    if bytes != 16 && bytes != 8 {
        return fail("VecConst: only 8- and 16-byte vectors");
    }
    let esize: u32 = match kind {
        StoreKind::I64 => 8,
        StoreKind::I32 => 4,
        StoreKind::I16 => 2,
        StoreKind::I8 => 1,
        _ => return fail("VecConst: not an integer lane kind"),
    };
    let (q, bits) = (bytes == 16, 8 * esize);
    let mask = u64::MAX >> (64 - bits);
    let lane = imm as u64 & mask;
    let pattern = (0..64 / bits).fold(0u64, |p, i| p | lane << (i * bits));
    let qd = match dst {
        Place::FpReg(r) => r,
        _ => frame.fp_scratch[0],
    };
    let vreg = |size: u32| Opnd::VecReg {
        num: qd,
        size: size as u8,
        q,
    };
    let modified = |m: &str, v: u64, shift: u32| {
        (v >> 8 == 0)
            .then(|| {
                table::encode(
                    m,
                    &[
                        vreg(esize.trailing_zeros()),
                        Opnd::Imm(v as i64),
                        Opnd::Lsl(shift),
                    ],
                )
            })
            .and_then(Result::ok)
    };
    let bytewise = pattern.to_le_bytes().iter().all(|&b| b == 0 || b == 0xFF);
    let word = if bytewise {
        table::encode("movi", &[vreg(3), Opnd::Imm(pattern as i64)]).ok()
    } else if esize == 1 {
        table::encode("movi", &[vreg(0), Opnd::Imm(lane as i64)]).ok()
    } else if esize <= 4 {
        (0..bits).step_by(8).find_map(|s| {
            let (v, n) = (lane >> s, !lane & mask);
            (v << s == lane)
                .then(|| modified("movi", v, s))
                .flatten()
                .or_else(|| {
                    ((n >> s) << s == n)
                        .then(|| modified("mvni", n >> s, s))
                        .flatten()
                })
        })
    } else {
        None
    };
    match word {
        Some(w) => emit(code, w),
        None => {
            super::encode::load_imm64(code, scratch.primary, lane);
            emit(
                code,
                if esize == 8 && !q {
                    super::encode::enc_fmov_x_to_d(qd, scratch.primary)
                } else {
                    super::encode::enc_dup_gen(qd, esize, q, scratch.primary)
                },
            );
        }
    }
    if q {
        propagate_v128(code, frame, dst, qd, scratch.primary);
    } else {
        store_spilled_fp(code, frame, dst, qd);
    }
    Ok(())
}

/// `Inst::Fneg`. C99 6.3.1.8: negation of a `float` is single-precision;
/// the result's f32 marker mirrors the operand's. A spilled result stages
/// through the second FP scratch, since the source may occupy the first.
fn emit_fneg(
    code: &mut CodeBuf,
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
    code: &mut CodeBuf,
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
    code: &mut CodeBuf,
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
        FpCastKind::FpBits => {
            let Some(dn) = materialize_fp(code, src_place, frame.fp_scratch[0], frame) else {
                return fail("FpCast FpBits: value not fp reg / spill");
            };
            let Some(rd) = int_or_spill_scratch(dst, scratch) else {
                return fail("FpCast FpBits: dst not int reg / spill");
            };
            emit(code, super::encode::enc_fmov_d_to_x(rd, dn));
            store_spilled_int(code, frame, dst, rd);
            Ok(())
        }
        FpCastKind::BitsFp => {
            let Some(rn) = materialize_int(code, src_place, scratch.primary, frame) else {
                return fail("FpCast BitsFp: value not int reg / spill");
            };
            let Some(dd) = fp_or_spill_dst(dst, frame) else {
                return fail("FpCast BitsFp: dst not fp reg / spill");
            };
            emit(code, super::encode::enc_fmov_x_to_d(dd, rn));
            store_spilled_fp(code, frame, dst, dd);
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
/// A constant rebuilt from a literal adds its load to `fp_literals`.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_phi_predecessor_moves(
    code: &mut Vec<u8>,
    self_block: super::super::ir::BlockId,
    func: &super::super::ir::FunctionSsa,
    alloc: &Allocation,
    scratch: &ScratchPool,
    frame: Frame,
    fp_literals: &mut Vec<(usize, u64, bool)>,
) -> Emit {
    let mut backend = super::ssa::emit_common::Aarch64Backend::default();
    let moved = super::ssa::emit_common::emit_phi_predecessor_moves(
        &backend,
        code,
        self_block,
        func,
        alloc,
        frame,
        scratch.primary.0,
        scratch.secondary.0,
        frame.fp_scratch[1],
        frame.fp_scratch[0],
    );
    fp_literals.append(backend.fp_literals.get_mut());
    moved
}

/// Write the pattern `bits` (`single`: a float's) to `d`: `load_fp_imm` within
/// two instructions, else an `adrp` + `ldr` of a read-only literal, whose
/// `(site, bits, single)` joins `literals`. `stage` is free.
pub(super) fn emit_fp_imm(
    code: &mut Vec<u8>,
    d: u8,
    bits: u64,
    single: bool,
    stage: Reg,
    literals: &mut Vec<(usize, u64, bool)>,
) {
    use super::encode::{LDR_D, LDR_S, enc_mem, fp_imm8, imm64_insts, load_fp_imm};
    let bits = if single { bits & 0xFFFF_FFFF } else { bits };
    if bits == 0 || fp_imm8(bits, single).is_some() || imm64_insts(bits) == 1 {
        load_fp_imm(code, d, bits, single, stage);
        return;
    }
    literals.push((code.len(), bits, single));
    let op = if single { LDR_S } else { LDR_D };
    emit(code, enc_adrp(stage, 0));
    emit(code, enc_mem(op, d, stage, op.scaled(0)));
}

/// Sequentialize a parallel copy over integer registers and spill
/// slots: leaves first; when only cycles remain one cycle source is
/// saved into `hold` and every move reading it redirected, exposing a
/// new leaf. `hold` and `stage` lie outside the allocator's bank.
/// `Err` for an FP or `None` location.
pub(super) fn schedule_place_moves(
    code: &mut Vec<u8>,
    moves: &mut Vec<PlaceMove>,
    frame: Frame,
    hold: Reg,
    stage: Reg,
) -> Emit {
    super::ssa::emit_common::schedule_place_moves(
        &super::ssa::emit_common::Aarch64Backend::default(),
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
    fn v128_reg_mov(&self, code: &mut Vec<u8>, dst: u8, src: u8) {
        emit(code, super::encode::enc_mov_v16b(dst, src));
    }
    fn v128_spill_store(&self, code: &mut Vec<u8>, frame: Frame, slot: u32, src: u8) {
        emit_spill_str_q(code, frame, src, v128_spill_off(frame, slot), Reg(16));
    }
    fn v128_spill_load(&self, code: &mut Vec<u8>, frame: Frame, slot: u32, dst: u8) {
        emit_spill_ldr_q(code, frame, dst, v128_spill_off(frame, slot), Reg(16));
    }
    fn int_reg_mov(&self, code: &mut Vec<u8>, dst: u8, src: u8) {
        emit_mov_reg(code, Reg(dst), Reg(src));
    }
    fn int_reg_ext(&self, code: &mut Vec<u8>, dst: u8, src: u8, kind: LoadKind) {
        emit_sign_extend(code, Reg(dst), Reg(src), kind);
    }
    fn int_reg_xchg(&self, _code: &mut Vec<u8>, _a: u8, _b: u8) -> bool {
        false
    }
    fn int_spill_store(&self, code: &mut Vec<u8>, frame: Frame, slot: u32, src: u8, base: u8) {
        emit_spill_str_x(code, frame, Reg(src), spill_off(frame, slot), Reg(base));
    }
    fn int_spill_load(&self, code: &mut Vec<u8>, frame: Frame, slot: u32, dst: u8) {
        emit_spill_ldr_x(code, frame, Reg(dst), spill_off(frame, slot));
    }
    fn int_spill_store_staged(
        &self,
        code: &mut Vec<u8>,
        frame: Frame,
        slot: u32,
        stage: u8,
        hold: u8,
    ) {
        emit_spill_str_x_borrow(code, frame, Reg(stage), spill_off(frame, slot), Reg(hold));
    }
    fn int_spill_store_auto(&self, code: &mut Vec<u8>, frame: Frame, slot: u32, src: u8) {
        emit_spill_str_x_auto(code, frame, Reg(src), spill_off(frame, slot));
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
    fn fp_reg_load_const(&self, code: &mut Vec<u8>, dst: u8, stage: u8, bits: i64, is_f64: bool) {
        let mut literals = self.fp_literals.borrow_mut();
        emit_fp_imm(code, dst, bits as u64, !is_f64, Reg(stage), &mut literals);
    }
}
