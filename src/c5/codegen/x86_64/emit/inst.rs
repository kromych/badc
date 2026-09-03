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

/// Whether a fused `Flt` / `Fle` compare emits `ucomisd rhs, lhs`.
/// The swap turns them into the `>` / `>=` shapes whose `A` / `Ae`
/// (and inverted `Be` / `B`) condition codes are exact under the
/// unordered flag state, so the branch needs no parity test. The
/// compare emit and [`fused_branch_cc`] both derive the swap from the
/// inst so they agree.
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
        Inst::Binop { op, .. } | Inst::BinopI { op, .. } => *op,
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
    // FP compares. `ucomisd` leaves ZF=PF=CF=1 on NaN: `A` / `Ae` are
    // false there and their inversions `Be` / `B` true, matching C99
    // 6.5.8p6 for the ordered compares (`Flt` / `Fle` were emitted
    // operand-swapped into those shapes); `==` / `!=` carry the
    // parity test in the branch shape.
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

pub(super) fn emit_inst(
    out: &mut Out,
    inst: &Inst,
    v: super::super::ir::ValueId,
    dst: Place,
    fcx: &FnCtx,
) -> bool {
    let FnCtx {
        func,
        alloc,
        frame,
        abi,
        target,
        imports,
        variadic_targets,
        conv_targets,
        extern_tls_names,
        tls_total_size,
        ..
    } = *fcx;
    let cx = &mut *out.cx;
    let fixups = &mut *out.fixups;
    let code = &mut *cx.code;
    let plt_call_fixups = &mut *cx.plt_call_fixups;
    let data_fixups = &mut *cx.data_fixups;
    let pending_func_fixups = &mut *cx.pending_func_fixups;
    let tls_index_fixups = &mut *cx.tls_index_fixups;
    let elf_tpoff_fixups = &mut *cx.elf_tpoff_fixups;
    let asm_extern_call_sites = &mut *cx.asm_extern_call_sites;
    match inst {
        Inst::AllocaInit(slot) => {
            // Slot 0: this function doesn't use alloca. Non-zero:
            // the function moves rsp at runtime; `Frame::dynamic_sp`
            // carries the fact to the spill addressing, the alloca
            // intrinsics, and the epilogue. No code either way.
            let _ = slot;
            true
        }
        Inst::ParamRef { idx, kind } => emit_param_ref(code, *idx, *kind, dst, v, fcx),
        Inst::Imm(value) => {
            let Some(rd) = int_or_spill_dst(dst) else {
                return fail("Imm: dst not int reg / spill");
            };
            emit_mov_r_imm64(code, rd, *value);
            spill_dst_to_slot(code, dst, rd, frame);
            true
        }
        Inst::LocalAddr(off) => {
            let Some(rd) = int_or_spill_dst(dst) else {
                return fail("LocalAddr: dst not int reg / spill");
            };
            // c5 cdecl: param i (i >= 2) sits at [rbp + 16*(i-1)]; locals
            // (i < 0) sit at [rbp + 8*i]. An over-aligned automatic object is
            // addressed sp-relative in the realigned region; a System V
            // variadic callee redirects named-parameter slots into the
            // register save area (see `local_slot_base_disp`). The 32-bit
            // signed `disp` covers any frame our compiler emits; larger bail.
            let (base, bytes) = local_slot_base_disp(*off, func, frame, abi);
            let Ok(disp) = i32::try_from(bytes) else {
                return fail("LocalAddr: offset doesn't fit in disp32");
            };
            emit_lea_r_mem(code, rd, base, disp);
            spill_dst_to_slot(code, dst, rd, frame);
            true
        }
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
            scale,
            kind,
        } => emit_load_indexed(code, dst, *base, *index, *scale, *kind, alloc, frame),
        Inst::StoreIndexed {
            base,
            index,
            scale,
            value,
            kind,
        } => emit_store_indexed(
            code, dst, *base, *index, *scale, *value, *kind, alloc, frame,
        ),
        Inst::Binop { op, lhs, rhs } => emit_binop(code, *op, v, dst, *lhs, *rhs, alloc, frame),
        Inst::BinopI { op, lhs, rhs_imm } => {
            emit_binop_imm(code, *op, v, dst, *lhs, *rhs_imm, alloc, frame)
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
            callee_abi(
                abi,
                target,
                conv_targets.get(target_pc).copied().unwrap_or_default(),
            ),
            fixups,
            variadic_targets.contains(target_pc),
            *fp_return,
            *fp_arg_mask,
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
            *binding_idx,
            args,
            *fp_arg_mask,
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
            dst,
            *d,
            *s,
            *size,
            *align,
            abi.strict_align,
            alloc,
            frame,
        ),
        Inst::AtomicRmw {
            op,
            addr,
            value,
            width,
        } => emit_atomic_rmw(code, dst, *op, *addr, *value, *width, alloc, frame),
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
            *fp_arg_mask,
            arg_aggs,
            &func.agg_descs,
            *ret_agg,
            *ret_slot_local,
            func,
            asm_extern_call_sites,
        ),
        Inst::Intrinsic { kind, args } => {
            emit_intrinsic(code, *kind, args, dst, v, func, alloc, frame, abi)
        }
        Inst::X86Simd { op, imm, args } => emit_x86_simd(code, *op, *imm, args, alloc, frame),
        Inst::InlineAsm { asm, args } => emit_inline_asm(out, asm, args, fcx, None),
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
        Inst::Extend { value, kind } => emit_extend(code, dst, *value, *kind, alloc, frame),
        Inst::Bswap { value, width } => emit_bswap(code, dst, *value, *width, alloc, frame),
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
            // The value is materialised by the predecessor-exit
            // moves emitted just before each branch terminator
            // that targets this block; at the IR position the
            // phi's allocated Place already holds the merged
            // value.
            true
        }
        other => {
            bail_msg(&alloc::format!(
                "inst variant not yet covered: {}",
                other.variant_name()
            ));
            let _ = frame;
            false
        }
    }
}

/// Materialise the i-th host-ABI parameter into its `Place`, converting the
/// low `kind` bytes per C99 6.3.1.3 so the register holds the canonical
/// 64-bit sign-extended value. The incoming argument register is not always
/// pristine at this position: an earlier `ParamRef` may have overwritten it
/// (the allocator packs sequentially-live parameters into one register), so
/// `param_from_home` marks the parameters that read the c5 cdecl home cell
/// the prologue spilled at `[rbp + (idx+1)*16]` instead. The plan names the
/// incoming register: an earlier FP parameter does not shift the integer
/// bank, and a stack-passed parameter always reads its home cell.
fn emit_param_ref(
    code: &mut Vec<u8>,
    idx: u32,
    kind: LoadKind,
    dst: Place,
    v: super::super::ir::ValueId,
    fcx: &FnCtx,
) -> bool {
    let FnCtx {
        alloc,
        frame,
        param_from_home,
        param_plan,
        ..
    } = *fcx;
    let i = idx as usize;
    let from_home = param_from_home.get(i).copied().unwrap_or(false);
    let home_off =
        c5_slot_to_fp_offset(idx as i64 + 2, frame.param_cell_stride, frame.canary_bytes) as i32;
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
                _ => return fail("ParamRef: FP param dst not fp reg / spill"),
            }
            return true;
        }
        let Some(super::ArgPlacement::FpReg(x)) = param_plan.get(i).copied() else {
            return fail("ParamRef: FP param not in an FP argument register");
        };
        let xmm = Reg(x);
        match dst {
            Place::FpReg(r) => {
                if r != x {
                    emit_movapd_xmm_xmm(code, Reg(r), xmm);
                }
            }
            Place::Spill(_) => fp_spill_dst_to_slot(code, dst, xmm, frame),
            _ => return fail("ParamRef: FP param dst not fp reg / spill"),
        }
        return true;
    }
    let arg_reg = match param_plan.get(i).copied() {
        Some(super::ArgPlacement::IntReg(r)) => Reg(r),
        _ if from_home => Reg(0),
        _ => return fail("ParamRef: int param has no incoming integer register"),
    };
    // The caller passes the raw 64-bit value, so an I8/I16 conversion
    // always runs; an I32 extend touches only bits 32..63 and is skipped
    // when no consumer reads them.
    let high_dead = !alloc.high_observed.get(v as usize).copied().unwrap_or(true);
    let materialize = |code: &mut Vec<u8>, rd: Reg| {
        if from_home {
            match kind {
                LoadKind::I8 => super::encode::emit_movsx_r_mem8(code, rd, Reg::RBP, home_off),
                LoadKind::I16 => super::encode::emit_movsx_r_mem16(code, rd, Reg::RBP, home_off),
                LoadKind::I32 if !high_dead => {
                    super::encode::emit_movsxd_r_mem(code, rd, Reg::RBP, home_off)
                }
                _ => emit_mov_r_mem(code, rd, Reg::RBP, home_off),
            }
        } else {
            match kind {
                LoadKind::I8 => super::encode::emit_movsx_r_r8(code, rd, arg_reg),
                LoadKind::I16 => super::encode::emit_movsx_r_r16(code, rd, arg_reg),
                LoadKind::I32 if !high_dead => super::encode::emit_movsxd_r_r(code, rd, arg_reg),
                _ => emit_mov_rr(code, rd, arg_reg),
            }
        }
    };
    match dst {
        Place::IntReg(r) => materialize(code, Reg(r)),
        Place::Spill(_) => {
            materialize(code, SCRATCH_R10);
            spill_dst_to_slot(code, dst, SCRATCH_R10, frame);
        }
        _ => return fail("ParamRef: dst not int reg / spill"),
    }
    true
}
