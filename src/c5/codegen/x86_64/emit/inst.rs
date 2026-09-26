use super::*;

#[derive(Debug, Clone, Copy)]
pub(super) struct BranchFixup {
    /// Byte offset of the displacement field in `code` (rel8 for a
    /// short branch, rel32 otherwise).
    pub(super) site: usize,
    pub(super) target: super::super::ir::BlockId,
    pub(super) kind: LocalBranchKind,
    /// `true` when the branch was emitted in the 2-byte rel8 form.
    pub(super) short: bool,
    /// `true` when the branch sits in an inline-asm template, whose bytes
    /// are emitted before relaxation runs and may not change length.
    pub(super) pinned_long: bool,
}

/// Emit a fused terminator's branch shape: the single `jcc`, or the
/// parity pair an FP `==` / `!=` needs (`JpOr` sends the unordered
/// case to `target`, `JnpAnd` to `fall_through`). The caller emits
/// the trailing `jmp fall_through` when the layout needs one.
pub(super) fn emit_fused_branch(
    code: &mut alloc::vec::Vec<u8>,
    branch_fixups: &mut alloc::vec::Vec<BranchFixup>,
    branch_short: &[bool],
    fused: FusedBranch,
    target: super::super::ir::BlockId,
    fall_through: super::super::ir::BlockId,
) {
    match fused {
        FusedBranch::Jcc(cc) => {
            emit_local_branch(
                code,
                branch_fixups,
                branch_short,
                LocalBranchKind::Jcc(cc),
                target,
            );
        }
        FusedBranch::JpOr(cc) => {
            emit_local_branch(
                code,
                branch_fixups,
                branch_short,
                LocalBranchKind::Jcc(Cc::P),
                target,
            );
            emit_local_branch(
                code,
                branch_fixups,
                branch_short,
                LocalBranchKind::Jcc(cc),
                target,
            );
        }
        FusedBranch::JnpAnd(cc) => {
            emit_local_branch(
                code,
                branch_fixups,
                branch_short,
                LocalBranchKind::Jcc(Cc::P),
                fall_through,
            );
            emit_local_branch(
                code,
                branch_fixups,
                branch_short,
                LocalBranchKind::Jcc(cc),
                target,
            );
        }
    }
}

/// Emit a local branch to `target`, choosing the 2-byte rel8 short form
/// when `branch_short[idx]` is set (idx = this branch's emission index),
/// and record the fixup. `branch_short` is empty on the first all-long
/// emission pass and is populated by `relax_branches` for the second.
pub(super) fn emit_local_branch(
    code: &mut alloc::vec::Vec<u8>,
    branch_fixups: &mut alloc::vec::Vec<BranchFixup>,
    branch_short: &[bool],
    kind: LocalBranchKind,
    target: super::super::ir::BlockId,
) {
    let idx = branch_fixups.len();
    let short = branch_short.get(idx).copied().unwrap_or(false);
    match kind {
        LocalBranchKind::Jmp => {
            // EB cb (rel8) / E9 cd (rel32): displacement follows the
            // 1-byte opcode in both forms.
            branch_fixups.push(BranchFixup {
                site: code.len() + 1,
                target,
                kind,
                short,
                pinned_long: false,
            });
            if short {
                super::encode::emit_jmp_rel8(code, 0);
            } else {
                super::encode::emit_jmp_rel32(code, 0);
            }
        }
        LocalBranchKind::Jcc(cc) => {
            // 7x cb (rel8): displacement at +1. 0F 8x cd (rel32): at +2.
            let site = if short {
                code.len() + 1
            } else {
                code.len() + 2
            };
            branch_fixups.push(BranchFixup {
                site,
                target,
                kind,
                short,
                pinned_long: false,
            });
            if short {
                super::encode::emit_jcc_rel8(code, cc, 0);
            } else {
                super::encode::emit_jcc_rel32(code, cc, 0);
            }
        }
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(super) enum LocalBranchKind {
    Jmp,
    Jcc(Cc),
}

impl LocalBranchKind {
    /// Bytes preceding the displacement field in the rel32 form: `E9` for
    /// `jmp`, `0F 8x` for `jcc`.
    pub(super) fn opcode_len(self) -> usize {
        match self {
            LocalBranchKind::Jmp => 1,
            LocalBranchKind::Jcc(_) => 2,
        }
    }
}

/// Branch shape for a fused compare's terminator. An integer compare
/// and the parity-clean FP compares take one `jcc`; `ucomisd` raises
/// PF on an unordered (NaN) compare, so `==` / `!=` need it tested by
/// a second branch (C99 6.5.9p3: `==` yields 0 on NaN, `!=` yields 1).
pub(super) enum FusedBranch {
    /// `jcc target`.
    Jcc(Cc),
    /// Taken when PF=1 or `cc` holds: `jp target ; jcc target`.
    JpOr(Cc),
    /// Taken when PF=0 and `cc` holds: `jp fall_through ; jcc target`.
    JnpAnd(Cc),
}

/// Whether a fused `Flt` / `Fle` compare emits `ucomisd rhs, lhs`: the swap
/// turns them into the `>` / `>=` shapes whose `A` / `Ae` (and `Be` / `B`)
/// codes are exact under the unordered flag state, so the branch needs no
/// parity test. The compare and [`fused_branch_cc`] derive it alike.
pub(super) fn fused_fp_swaps_operands(op: BinOp) -> bool {
    matches!(op, BinOp::Flt | BinOp::Fle)
}

/// Return the branch shape to use when the terminator's cond was
/// flagged as branch-fused by the allocator. `negate` is true for
/// `Bz` (branch when comparison failed).
pub(super) fn fused_branch_cc(
    func: &super::super::ir::FunctionSsa,
    alloc: &Allocation,
    cond: super::super::ir::ValueId,
    negate: bool,
) -> Option<FusedBranch> {
    if !alloc
        .branch_fused
        .get(cond as usize)
        .copied()
        .unwrap_or(false)
    {
        return None;
    }
    let op = match func.insts.get(cond as usize)? {
        // `emit_binop_imm` tested the mask: `bt` leaves the bit in CF,
        // `test` the zero test in ZF.
        Inst::BinopI {
            op: BinOp::And,
            rhs_imm,
            ..
        } => {
            let cc = match (
                crate::c5::codegen::ssa::reg_alloc::x86_mask_takes_bt(*rhs_imm),
                negate,
            ) {
                (true, true) => Cc::Ae,
                (true, false) => Cc::B,
                (false, true) => Cc::E,
                (false, false) => Cc::Ne,
            };
            return Some(FusedBranch::Jcc(cc));
        }
        Inst::Binop { op, .. } | Inst::BinopI { op, .. } => *op,
        // `emit_zero_test_of_load` compared the memory operand with zero.
        Inst::Load { .. } | Inst::LoadLocal { .. } | Inst::LoadIndexed { .. } => {
            return Some(FusedBranch::Jcc(if negate { Cc::E } else { Cc::Ne }));
        }
        _ => return None,
    };
    if let Some(positive) = int_cmp_cc(op) {
        // A `cmp`-set flag state is never "unordered": inverting the
        // cc is the exact negation.
        let cc = if negate {
            invert_cc(positive)?
        } else {
            positive
        };
        return Some(FusedBranch::Jcc(cc));
    }
    // FP compares: `ucomisd` leaves ZF=PF=CF=1 on NaN, so `A` / `Ae` and
    // their inversions match C99 6.5.8p6 for the operand-swapped `Flt` /
    // `Fle`; `==` / `!=` carry the parity test in the branch shape.
    Some(match op {
        BinOp::Fgt | BinOp::Flt => FusedBranch::Jcc(if negate { Cc::Be } else { Cc::A }),
        BinOp::Fge | BinOp::Fle => FusedBranch::Jcc(if negate { Cc::B } else { Cc::Ae }),
        BinOp::Feq => {
            if negate {
                FusedBranch::JpOr(Cc::Ne)
            } else {
                FusedBranch::JnpAnd(Cc::E)
            }
        }
        BinOp::Fne => {
            if negate {
                FusedBranch::JnpAnd(Cc::E)
            } else {
                FusedBranch::JpOr(Cc::Ne)
            }
        }
        _ => return None,
    })
}

/// Logical complement of an integer-compare condition code.
fn invert_cc(cc: Cc) -> Option<Cc> {
    Some(match cc {
        Cc::E => Cc::Ne,
        Cc::Ne => Cc::E,
        Cc::L => Cc::Ge,
        Cc::G => Cc::Le,
        Cc::Le => Cc::G,
        Cc::Ge => Cc::L,
        Cc::B => Cc::Ae,
        Cc::A => Cc::Be,
        Cc::Be => Cc::A,
        Cc::Ae => Cc::B,
        _ => return None,
    })
}

/// An `ImmData` naming a cross-TU symbol: its `.data` fixup becomes a named reference.
pub(super) fn name_extern_data_ref(
    cx: &mut super::ssa::emit_common::EmitCtx,
    v: super::super::ir::ValueId,
    inst: &Inst,
    extern_data_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    fixups_before: usize,
) {
    if let Inst::ImmData(_) = inst
        && let Some(name) = extern_data_names.get(&v)
        && cx.data_fixups.len() > fixups_before
    {
        let popped = cx.data_fixups.pop().unwrap();
        cx.user_extern_data_refs.push(super::UserExternDataRef {
            instr_offset: popped.instr_offset,
            symbol_name: name.clone(),
            direct_pcrel: None,
        });
    }
}

pub(super) fn emit_inst(
    out: &mut Out,
    inst: &Inst,
    v: super::super::ir::ValueId,
    dst: Place,
    fcx: &FnCtx,
) -> Emit {
    let FnCtx {
        func,
        alloc,
        frame,
        abi,
        target,
        imports,
        extern_tls_names,
        tls_total_size,
        ..
    } = *fcx;
    let cx = &mut *out.cx;
    let code = &mut *cx.code;
    let plt_call_fixups = &mut *cx.plt_call_fixups;
    let data_fixups = &mut *cx.data_fixups;
    let pending_func_fixups = &mut *cx.pending_func_fixups;
    let tls_index_fixups = &mut *cx.tls_index_fixups;
    let elf_tpoff_fixups = &mut *cx.elf_tpoff_fixups;
    match inst {
        Inst::AllocaInit(slot) => {
            // Slot 0: this function doesn't use alloca. Non-zero:
            // the function moves rsp at runtime; `Frame::dynamic_sp`
            // carries the fact to the spill addressing, the alloca
            // intrinsics, and the epilogue. No code either way.
            let _ = slot;
            Ok(())
        }
        // A lifetime marker states a fact about storage the frame
        // already holds; `ssa::slot_coalesce` reads it and no code
        // follows from it. The return moves the parts of an `AggParts`,
        // and an inline asm statement places its `AsmOut`s.
        Inst::LifetimeEnd(_) | Inst::AggParts { .. } | Inst::AsmOut { .. } => Ok(()),
        Inst::ParamRef { .. } | Inst::ParamPart { .. } | Inst::RetPart { .. } => {
            emit_incoming(code, inst, dst, v, fcx)
        }
        Inst::Imm(value) => {
            let Some(rd) = int_or_spill_dst(dst) else {
                return fail("Imm: dst not int reg / spill");
            };
            emit_mov_r_imm64(code, rd, *value);
            spill_dst_to_slot(code, dst, rd, frame);
            Ok(())
        }
        Inst::LocalAddr(off) => {
            let Some(rd) = int_or_spill_dst(dst) else {
                return fail("LocalAddr: dst not int reg / spill");
            };
            // `local_slot_base_disp` places parameter cells, locals, an over-aligned
            // object and a System V variadic callee's named parameters; the signed
            // disp32 covers any frame this compiler emits.
            let (base, bytes) = local_slot_base_disp(*off, func, frame, abi);
            let Ok(disp) = i32::try_from(bytes) else {
                return fail("LocalAddr: offset doesn't fit in disp32");
            };
            emit_lea_r_mem(code, rd, base, disp);
            spill_dst_to_slot(code, dst, rd, frame);
            Ok(())
        }
        Inst::LoadIndexed { abs_base: true, .. } | Inst::StoreIndexed { abs_base: true, .. } => {
            emit_abs_indexed(code, &mut *out.abs_addr_refs, inst, v, dst, fcx)
        }
        Inst::Load { .. }
        | Inst::Store { .. }
        | Inst::SegLoad { .. }
        | Inst::SegStore { .. }
        | Inst::LoadLocal { .. }
        | Inst::StoreLocal { .. }
        | Inst::LoadIndexed { .. }
        | Inst::StoreIndexed { .. } => emit_mem_inst(code, inst, v, dst, fcx),
        Inst::Binop { op, lhs, rhs } => emit_binop(code, *op, v, dst, *lhs, *rhs, alloc, frame),
        Inst::BinopI { op, lhs, rhs_imm } => {
            emit_binop_imm(code, *op, v, dst, *lhs, *rhs_imm, alloc, frame)
        }
        Inst::Call { .. } | Inst::CallExt { .. } | Inst::CallIndirect { .. } => {
            emit_call_inst(out, inst, v, dst, fcx)
        }
        Inst::ImmData(offset) => emit_imm_data(code, dst, *offset, data_fixups, frame),
        Inst::ImmCode(target_ent_pc) => {
            emit_imm_code(code, dst, *target_ent_pc, pending_func_fixups, frame)
        }
        Inst::ImmExtCode(binding_idx) => {
            emit_imm_ext_code(code, dst, *binding_idx, plt_call_fixups, imports, frame)
        }
        // Inst::BlockAddr is handled in emit_function's block loop
        // (it needs the local block_offsets table for its PC-relative
        // lea fixup), so it never reaches emit_inst.
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
            fcx.bulk_xmm,
            abi.strict_align,
            alloc,
            frame,
            abi,
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
            fcx.bulk_xmm,
            abi.strict_align,
            alloc,
            frame,
        ),
        Inst::AtomicRmw {
            op,
            addr,
            value,
            width,
            ..
        } => emit_atomic_rmw(code, v, dst, *op, *addr, *value, *width, alloc, frame, abi),
        Inst::AtomicCas {
            addr,
            expected,
            desired,
            width,
            ..
        } => emit_atomic_cas(
            code, v, dst, *addr, *expected, *desired, *width, alloc, frame,
        ),
        Inst::AtomicLoad { addr, width, .. } => {
            emit_atomic_load(code, dst, *addr, *width, alloc, frame)
        }
        Inst::AtomicStore {
            addr,
            value,
            width,
            order,
        } => emit_atomic_store(code, *addr, *value, *width, *order, alloc, frame),
        Inst::Intrinsic { kind, args } => {
            emit_intrinsic(code, *kind, args, dst, v, func, alloc, frame, abi)
        }
        Inst::X86Simd { op, imm, args } => emit_x86_simd(code, *op, *imm, args, alloc, frame),
        Inst::InlineAsm { asm, args } => emit_inline_asm(out, asm, args, v, fcx, None),
        Inst::Neg(value) => emit_neg(code, dst, *value, alloc, frame),
        Inst::Fneg(value) => emit_fneg(code, dst, v, *value, alloc, frame),
        Inst::Fma {
            a,
            b,
            c,
            neg_product,
            neg_addend,
        } => emit_fma(
            code,
            dst,
            v,
            *a,
            *b,
            *c,
            *neg_product,
            *neg_addend,
            alloc,
            frame,
        ),
        Inst::MulAdd {
            a,
            b,
            c,
            neg_product,
        } => emit_mul_add(code, dst, v, *a, *b, *c, *neg_product, alloc, frame),
        Inst::Udiv128 { hi, lo, divisor } => {
            emit_udiv128(code, v, dst, *hi, *lo, *divisor, alloc, frame)
        }
        Inst::Extend { value, kind, .. } => emit_extend(code, dst, v, *value, *kind, alloc, frame),
        Inst::Bswap { value, width } => emit_bswap(code, dst, *value, *width, alloc, frame),
        Inst::BitCount { op, value, width } => emit_bit_count(
            code,
            dst,
            *op,
            *value,
            *width,
            alloc.count_nonzero(v),
            alloc,
            frame,
        ),
        Inst::Copy { value, is_fp } => emit_copy(code, dst, *value, *is_fp, alloc, frame),
        Inst::FpCast { kind, value } => emit_fp_cast(code, dst, v, *kind, *value, alloc, frame),
        Inst::TlsAddr(offset) => emit_tls_addr(
            code,
            dst,
            *offset,
            v,
            target,
            tls_index_fixups,
            elf_tpoff_fixups,
            extern_tls_names,
            tls_total_size,
            frame,
        ),
        Inst::Phi { .. } => {
            // The predecessor-exit moves before each branch into this block leave
            // the merged value in the allocated place.
            Ok(())
        }
        other => {
            let _ = frame;
            fail(alloc::format!(
                "inst variant not yet covered: {}",
                other.variant_name()
            ))
        }
    }
}

/// The load / store instructions.
fn emit_mem_inst(
    code: &mut Vec<u8>,
    inst: &Inst,
    v: super::super::ir::ValueId,
    dst: Place,
    fcx: &FnCtx,
) -> Emit {
    let FnCtx {
        func,
        alloc,
        frame,
        abi,
        ..
    } = *fcx;
    if alloc.branch_fused.get(v as usize).copied().unwrap_or(false) {
        return emit_zero_test_of_load(code, inst, fcx);
    }
    if alloc.imm_store.get(v as usize).copied().unwrap_or(false) {
        return emit_store_of_imm(code, inst, func, alloc, frame, abi);
    }
    match inst {
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
            None,
            alloc.is_f32(v),
            alloc,
            frame,
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
            v,
            *addr,
            *disp,
            *value,
            *kind,
            None,
            alloc,
            frame,
            narrow_bound(*align, abi),
        ),
        Inst::SegLoad {
            addr, kind, seg, ..
        } => emit_load(
            code,
            dst,
            *addr,
            0,
            *kind,
            seg_prefix(*seg),
            alloc.is_f32(v),
            alloc,
            frame,
            None,
        ),
        Inst::SegStore {
            addr,
            value,
            kind,
            seg,
            ..
        } => emit_store(
            code,
            dst,
            v,
            *addr,
            0,
            *value,
            *kind,
            seg_prefix(*seg),
            alloc,
            frame,
            None,
        ),
        Inst::LoadLocal { off, kind, .. } => {
            emit_load_local(code, dst, *off, *kind, alloc.is_f32(v), frame, func, abi)
        }
        Inst::StoreLocal {
            off, value, kind, ..
        } => emit_store_local(code, dst, v, *off, *value, *kind, alloc, frame, func, abi),
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
            dst,
            *base,
            (*index, *index_ext),
            *scale,
            *value,
            *kind,
            alloc,
            frame,
        ),
        _ => unreachable!(),
    }
}

/// The call instructions.
fn emit_call_inst(
    out: &mut Out,
    inst: &Inst,
    v: super::super::ir::ValueId,
    dst: Place,
    fcx: &FnCtx,
) -> Emit {
    let FnCtx {
        func,
        alloc,
        frame,
        abi,
        target,
        imports,
        variadic_targets,
        conv_targets,
        ..
    } = *fcx;
    let cx = &mut *out.cx;
    let fixups = &mut *out.fixups;
    let code = &mut *cx.code;
    let plt_call_fixups = &mut *cx.plt_call_fixups;
    let asm_extern_call_sites = &mut *cx.asm_extern_call_sites;
    match inst {
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
            callee_abi(
                abi,
                target,
                conv_targets.get(target_pc).copied().unwrap_or_default(),
            ),
            fixups,
            variadic_targets.contains(target_pc),
            *fp_return,
            fp_arg_mask,
            arg_aggs,
            &func.agg_descs,
            *ret_agg,
            *ret_slot_local,
            func,
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
            v,
            *binding_idx,
            args,
            fp_arg_mask,
            alloc,
            frame,
            // A libc import follows the target's convention, never the
            // caller's.
            callee_abi(abi, target, super::CallConv::Target),
            target,
            plt_call_fixups,
            imports,
            arg_aggs,
            &func.agg_descs,
            *ret_agg,
            *ret_slot_local,
            func,
        ),
        Inst::CallIndirect {
            target: callee,
            args,
            callee_variadic,
            fixed_args,
            fp_return,
            fp_arg_mask,
            callee_conv,
            arg_aggs,
            ret_agg,
            ret_slot_local,
            ..
        } => emit_call_indirect(
            code,
            dst,
            *callee,
            args,
            *callee_variadic,
            *fixed_args,
            alloc,
            frame,
            callee_abi(abi, target, *callee_conv),
            *fp_return,
            fp_arg_mask,
            arg_aggs,
            &func.agg_descs,
            *ret_agg,
            *ret_slot_local,
            func,
            asm_extern_call_sites,
        ),
        _ => unreachable!(),
    }
}

/// `Inst::ParamRef` / `Inst::ParamPart`: the incoming register the plan
/// names into the value's place, an integer one converted from the low
/// `kind` bytes per C99 6.3.1.3. An earlier `ParamRef` may have
/// overwritten a parameter's argument register (the allocator packs
/// sequentially-live parameters into one register), so `param_from_home`
/// marks the parameters that read the home the prologue stored
/// (`param_home_off`); a stack-passed parameter always reads its home.
fn emit_incoming(
    code: &mut Vec<u8>,
    inst: &Inst,
    dst: Place,
    v: super::super::ir::ValueId,
    fcx: &FnCtx,
) -> Emit {
    let FnCtx {
        func,
        alloc,
        frame,
        abi,
        target,
        param_from_home,
        param_plan,
        ..
    } = *fcx;
    let (kind, home) = match inst {
        Inst::ParamRef { idx, kind } => (*kind, Some(*idx as usize)),
        Inst::ParamPart { kind, .. } | Inst::RetPart { kind, .. } => (*kind, None),
        _ => return fail("incoming: not a register read"),
    };
    let name = inst.variant_name();
    let from_home = home.is_some_and(|i| param_from_home.get(i).copied().unwrap_or(false));
    let home_off = home.map_or(0, |i| param_home_off(i, func, frame, abi) as i32);
    let incoming = super::ssa::reg_alloc::incoming_reg(param_plan, inst)
        .or_else(|| super::ssa::reg_alloc::ret_part_reg(target, inst));
    if matches!(kind, LoadKind::F32 | LoadKind::F64) {
        // A `float` occupies the low 32 bits of the xmm; the body re-narrows
        // it through the f32 store the walker seeded, so a scalar copy
        // serves either width.
        let load_home = |code: &mut Vec<u8>, r: Reg| {
            if matches!(kind, LoadKind::F32) {
                emit_movss_xmm_mem(code, r, Reg::RBP, home_off);
            } else {
                emit_movsd_xmm_mem(code, r, Reg::RBP, home_off);
            }
        };
        if from_home {
            match dst {
                Place::FpReg(r) => load_home(code, Reg(r)),
                Place::Spill(_) => {
                    load_home(code, Reg(frame.fp_scratch[0]));
                    fp_spill_dst_to_slot(code, dst, Reg(frame.fp_scratch[0]), frame);
                }
                _ => return fail(alloc::format!("{name}: FP dst not fp reg / spill")),
            }
            return Ok(());
        }
        let Some((true, x)) = incoming else {
            return fail(alloc::format!(
                "{name}: FP value not in an FP argument register"
            ));
        };
        let xmm = Reg(x);
        match dst {
            Place::FpReg(r) => {
                if r != x {
                    emit_movapd_xmm_xmm(code, Reg(r), xmm);
                }
            }
            Place::Spill(_) => fp_spill_dst_to_slot(code, dst, xmm, frame),
            _ => return fail(alloc::format!("{name}: FP dst not fp reg / spill")),
        }
        return Ok(());
    }
    let arg_reg = match incoming {
        Some((false, r)) => Reg(r),
        _ if from_home => Reg(0),
        _ => {
            return fail(alloc::format!(
                "{name}: integer value has no incoming register"
            ));
        }
    };
    let ext = param_entry_ext(kind, v, alloc);
    let materialize = |code: &mut Vec<u8>, rd: Reg| {
        if from_home {
            match ext {
                Some(LoadKind::I8) => {
                    super::encode::emit_movsx_r_mem8(code, rd, Reg::RBP, home_off)
                }
                Some(LoadKind::I16) => {
                    super::encode::emit_movsx_r_mem16(code, rd, Reg::RBP, home_off)
                }
                Some(LoadKind::I32) => {
                    super::encode::emit_movsxd_r_mem(code, rd, Reg::RBP, home_off)
                }
                _ => emit_mov_r_mem(code, rd, Reg::RBP, home_off),
            }
        } else {
            emit_sign_extend(code, rd, arg_reg, ext.unwrap_or(LoadKind::I64));
        }
    };
    match dst {
        Place::IntReg(r) => materialize(code, Reg(r)),
        Place::Spill(_) => {
            materialize(code, SCRATCH_R10);
            spill_dst_to_slot(code, dst, SCRATCH_R10, frame);
        }
        _ => return fail(alloc::format!("{name}: dst not int reg / spill")),
    }
    Ok(())
}
