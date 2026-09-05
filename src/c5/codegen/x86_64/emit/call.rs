use super::*;

/// Place every argument into its System V / Win64 slot in an order that
/// survives overlaps: the allocator's caller-saved bank covers the
/// argument registers, so one argument's value can sit in another's
/// target. Stack slots first, then the FP registers, then the integer
/// registers as one parallel copy, then the spilled sources.
fn marshal_args(
    code: &mut Vec<u8>,
    plan: &super::CallPlan,
    args: &[u32],
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
    site: &str,
) -> Emit {
    let m = Marshal {
        plan,
        args,
        alloc,
        frame,
        abi,
        site,
    };
    m.stack_args(code)?;
    m.struct_stack_args(code)?;
    m.fp_args(code)?;
    m.sse_aggs(code)?;
    m.int_args(code)?;
    m.agg_eightbytes(code);
    Ok(())
}

/// One call's argument marshalling: the plan and the operands it reads.
struct Marshal<'a> {
    plan: &'a super::CallPlan,
    args: &'a [u32],
    alloc: &'a Allocation,
    frame: Frame,
    abi: super::Abi,
    site: &'a str,
}

/// First INTEGER eightbyte register of an aggregate, if any: the
/// aggregate's base address is routed there by the parallel move and the
/// eightbyte loads read from it (that register's own eightbyte last).
fn agg_base_reg(regs: &[super::ClassReg; 4], n: u8) -> Option<u8> {
    regs.iter()
        .take(n as usize)
        .find(|c| !c.is_fp)
        .map(|c| c.reg)
}

impl Marshal<'_> {
    fn arg_place(&self, i: usize) -> Place {
        place_of(self.alloc, self.args[i])
    }

    fn fail<T>(&self, m: &str) -> Emit<T> {
        fail(alloc::format!("{}: {m}", self.site))
    }

    /// Read `args[i]` into an integer register: its own when it holds one,
    /// else `scratch`, through the rsp shift the plan's outgoing area
    /// produced.
    fn arg_int(&self, code: &mut Vec<u8>, i: usize, scratch: Reg) -> Option<Reg> {
        materialize_int_shifted(
            code,
            self.arg_place(i),
            scratch,
            self.frame,
            self.plan.scratch_bytes,
        )
    }

    /// Read `args[i]` into `scratch`. A caller that knows the argument's
    /// role reports that in place of the reason given here.
    fn arg_into(&self, code: &mut Vec<u8>, i: usize, scratch: Reg) -> Emit {
        let Some(src) = self.arg_int(code, i, scratch) else {
            return self.fail("arg not in int reg / spill");
        };
        if src.0 != scratch.0 {
            emit_mov_rr(code, scratch, src);
        }
        Ok(())
    }

    fn stack_args(&self, code: &mut Vec<u8>) -> Emit {
        for (i, &placement) in self.plan.placements.iter().enumerate() {
            if let super::ArgPlacement::Stack(off) = placement {
                let Some(src) = self.arg_int(code, i, SCRATCH_R10) else {
                    return self.fail("stack arg not in int reg / spill");
                };
                emit_mov_mem_r(code, Reg::RSP, off as i32, src);
            }
        }
        Ok(())
    }

    /// Aggregates passed on the outgoing stack (System V AMD64 MEMORY class),
    /// copied while their base address, possibly in an argument register the
    /// register moves overwrite, is still live.
    fn struct_stack_args(&self, code: &mut Vec<u8>) -> Emit {
        for (i, &placement) in self.plan.placements.iter().enumerate() {
            let super::ArgPlacement::StructStack { off, size, align } = placement else {
                continue;
            };
            if self.arg_into(code, i, SCRATCH_R10).is_err() {
                return self.fail("by-stack aggregate base not in int reg / spill");
            }
            // The outgoing slot is 8-aligned (System V AMD64 3.2.3); the
            // source is the caller's object, so its alignment bounds the unit.
            let unit = super::super::access_chunk(align, self.abi.strict_align, 8);
            let words = size / unit;
            for w in 0..words {
                let o = (w * unit) as i32;
                emit_load_unit(code, unit, SCRATCH_R11, SCRATCH_R10, o);
                emit_store_unit(code, unit, Reg::RSP, off as i32 + o, SCRATCH_R11);
            }
            for b in (words * unit)..size {
                let o = b as i32;
                super::encode::emit_movzx_r_mem8(code, SCRATCH_R11, SCRATCH_R10, o);
                super::encode::emit_mov_mem8_r(code, Reg::RSP, off as i32 + o, SCRATCH_R11);
            }
        }
        Ok(())
    }

    /// FP register placements: the xmm-to-xmm moves as a parallel copy first,
    /// so every xmm source is consumed before a spilled or integer source
    /// lands in its target xmm; the second FP scratch breaks a cycle.
    fn fp_args(&self, code: &mut Vec<u8>) -> Emit {
        let mut fp_moves: Vec<(u8, u8)> = Vec::new();
        for (i, &placement) in self.plan.placements.iter().enumerate() {
            if let super::ArgPlacement::FpReg(r) = placement
                && let Place::FpReg(s) = self.arg_place(i)
                && s != r
            {
                fp_moves.push((s, r));
            }
        }
        schedule_xmm_reg_moves(code, &mut fp_moves, Reg(self.frame.fp_scratch[1]));
        for (i, &placement) in self.plan.placements.iter().enumerate() {
            if let super::ArgPlacement::FpReg(r) = placement {
                match self.arg_place(i) {
                    Place::FpReg(_) => {}
                    ap @ (Place::Spill(_) | Place::IntReg(_)) => {
                        let Some(src) = materialize_fp_shifted(
                            code,
                            ap,
                            Reg(r),
                            self.frame,
                            self.plan.scratch_bytes,
                        ) else {
                            return self.fail("fp arg not in fp reg / spill / int reg");
                        };
                        if src.0 != r {
                            emit_movapd_xmm_xmm(code, Reg(r), src);
                        }
                    }
                    Place::None => return self.fail("fp arg not in fp reg / spill / int reg"),
                }
            }
        }
        Ok(())
    }

    /// System V aggregates whose eightbytes are all SSE: no integer eightbyte
    /// register can hold the base, so it goes through a scratch GPR. A mixed
    /// aggregate waits for the integer parallel move, since its integer
    /// eightbyte targets may still be another argument's pending source.
    fn sse_aggs(&self, code: &mut Vec<u8>) -> Emit {
        for (i, &placement) in self.plan.placements.iter().enumerate() {
            let super::ArgPlacement::StructRegs { regs, n, align } = placement else {
                continue;
            };
            if n == 0 || !regs.iter().take(n as usize).all(|c| c.is_fp) {
                continue;
            }
            if self.arg_into(code, i, SCRATCH_R10).is_err() {
                return self.fail("fp aggregate base not in int reg / spill");
            }
            for (k, cr) in regs.iter().take(n as usize).enumerate() {
                emit_agg_load_sse(
                    code,
                    Reg(cr.reg),
                    SCRATCH_R10,
                    (k as i32) * 8,
                    align,
                    self.abi.strict_align,
                    SCRATCH_R11,
                );
            }
        }
        Ok(())
    }

    /// Integer register placements and aggregate base addresses as one
    /// parallel register move (System V AMD64 3.2.3): an aggregate routes its
    /// base through its own first integer eightbyte register, so no
    /// aggregate's loads clobber another's pending base. The sources not
    /// register-resident then materialise into their targets.
    fn int_args(&self, code: &mut Vec<u8>) -> Emit {
        let mut int_moves: Vec<(u8, u8)> = Vec::new();
        for (i, &placement) in self.plan.placements.iter().enumerate() {
            match placement {
                super::ArgPlacement::IntReg(r) => {
                    if let Place::IntReg(s) = self.arg_place(i)
                        && s != r
                    {
                        int_moves.push((s, r));
                    }
                }
                // All-SSE aggregates were loaded by `sse_aggs`.
                super::ArgPlacement::StructRegs { regs, n, .. } => {
                    if let Some(dst) = agg_base_reg(&regs, n)
                        && let Place::IntReg(s) = self.arg_place(i)
                        && s != dst
                    {
                        int_moves.push((s, dst));
                    }
                }
                _ => {}
            }
        }
        schedule_int_reg_moves(code, &mut int_moves);
        for (i, &placement) in self.plan.placements.iter().enumerate() {
            if let super::ArgPlacement::IntReg(r) = placement {
                match self.arg_place(i) {
                    Place::IntReg(_) => {}
                    Place::Spill(_) | Place::None => {
                        if self.arg_into(code, i, Reg(r)).is_err() {
                            return self.fail("int arg not in int reg / spill");
                        }
                    }
                    // Win64 mirrors a variadic FP argument into both the
                    // matching xmm and the integer slot, so the plan can
                    // name the integer placement with the value in xmm.
                    Place::FpReg(s) => {
                        super::encode::emit_movq_r_xmm(code, Reg(r), Reg(s));
                    }
                }
            }
        }
        for (i, &placement) in self.plan.placements.iter().enumerate() {
            if let super::ArgPlacement::StructRegs { regs, n, .. } = placement
                && let Some(dst) = agg_base_reg(&regs, n)
                && !matches!(self.arg_place(i), Place::IntReg(_))
                && self.arg_into(code, i, Reg(dst)).is_err()
            {
                return self.fail("aggregate base not in int reg / spill");
            }
        }
        Ok(())
    }

    /// Load each aggregate's eightbytes from its base register: SSE eightbytes
    /// first, then the integer eightbytes high-first, the base register's own
    /// eightbyte last since the load overwrites it.
    fn agg_eightbytes(&self, code: &mut Vec<u8>) {
        let strict = self.abi.strict_align;
        for &placement in self.plan.placements.iter() {
            let super::ArgPlacement::StructRegs { regs, n, align } = placement else {
                continue;
            };
            let Some(base) = agg_base_reg(&regs, n) else {
                continue;
            };
            for (k, cr) in regs.iter().take(n as usize).enumerate() {
                if cr.is_fp {
                    emit_agg_load_sse(
                        code,
                        Reg(cr.reg),
                        Reg(base),
                        (k as i32) * 8,
                        align,
                        strict,
                        SCRATCH_R10,
                    );
                }
            }
            for (k, cr) in regs.iter().take(n as usize).enumerate().rev() {
                if !cr.is_fp && cr.reg != base {
                    emit_agg_load_int(
                        code,
                        Reg(cr.reg),
                        Reg(base),
                        (k as i32) * 8,
                        8,
                        align,
                        strict,
                        SCRATCH_R10,
                    );
                }
            }
            let base_off = regs
                .iter()
                .take(n as usize)
                .position(|c| !c.is_fp && c.reg == base)
                .unwrap_or(0);
            let disp = (base_off as i32) * 8;
            // The base's own eightbyte overwrites the base, so a composed
            // one accumulates in scratch first.
            if super::super::access_unit(disp as u32, 8, align, strict) == 8 {
                emit_mov_r_mem(code, Reg(base), Reg(base), disp);
            } else {
                emit_agg_load_int(
                    code,
                    SCRATCH_R10,
                    Reg(base),
                    disp,
                    8,
                    align,
                    strict,
                    SCRATCH_R11,
                );
                emit_mov_rr(code, Reg(base), SCRATCH_R10);
            }
        }
    }
}

#[allow(clippy::too_many_arguments)]
/// Store a register-classed <= 16-byte aggregate return into the caller's
/// result temp at `[rbp + base]`: INTEGER eightbytes from rax:rdx, SSE from
/// xmm0:xmm1 (System V AMD64 3.2.3); Win64 returns one INTEGER eightbyte.
fn store_agg_return(
    code: &mut Vec<u8>,
    desc: &super::super::ir::AggDesc,
    base: i64,
    abi: super::Abi,
) {
    let eb_classes = match super::abi_classify::classify_aggregate(
        desc.size,
        desc.align,
        &desc.fields,
        abi,
        true,
    ) {
        super::abi_classify::AggClass::Regs(c) => c,
        _ => alloc::vec::Vec::new(),
    };
    let int_ret = [Reg::RAX, Reg::RDX];
    let mut int_i = 0usize;
    let mut sse_i = 0u8;
    for (k, class) in eb_classes.iter().enumerate() {
        let disp = (base + (k as i64) * 8) as i32;
        if matches!(class, super::abi_classify::RegClass::Sse) {
            emit_movsd_mem_xmm(code, Reg::RBP, disp, Reg(Reg::XMM0.0 + sse_i));
            sse_i += 1;
        } else {
            emit_mov_mem_r(code, Reg::RBP, disp, int_ret[int_i]);
            int_i += 1;
        }
    }
}

/// Store a register-classed aggregate return (tagged by `ret_agg`)
/// into the caller's result temp; `true` when the call returned an
/// aggregate and the scalar result routing must be skipped.
#[allow(clippy::too_many_arguments)]
fn store_ret_agg(
    code: &mut Vec<u8>,
    ret_agg: Option<u32>,
    agg_descs: &[super::super::ir::AggDesc],
    ret_slot_local: i64,
    func: &FunctionSsa,
    frame: Frame,
    abi: super::Abi,
) -> bool {
    let Some(ai) = ret_agg else {
        return false;
    };
    let base = local_slot_off(ret_slot_local, func, frame, abi);
    store_agg_return(code, &agg_descs[ai as usize], base, abi);
    true
}

/// Route a call's xmm0 FP result into `dst`: `movapd` into an FP
/// register, a spill store, or `movq` into an integer register.
fn xmm0_result_to_dst(code: &mut Vec<u8>, dst: Place, frame: Frame) {
    match dst {
        Place::FpReg(r) => {
            if r != Reg::XMM0.0 {
                emit_movapd_xmm_xmm(code, Reg(r), Reg::XMM0);
            }
        }
        Place::Spill(_) => fp_spill_dst_to_slot(code, dst, Reg::XMM0, frame),
        Place::IntReg(r) => super::encode::emit_movq_r_xmm(code, Reg(r), Reg::XMM0),
        Place::None => {}
    }
}

/// Mirror an integer result in `src` into an integer-or-spill `dst`
/// through the shared working-register pick; no-op for an FP dst.
pub(super) fn mirror_int_dst(code: &mut Vec<u8>, dst: Place, src: Reg, frame: Frame) {
    if let Some(rd) = int_or_spill_dst(dst) {
        if rd.0 != src.0 {
            emit_mov_rr(code, rd, src);
        }
        spill_dst_to_slot(code, dst, rd, frame);
    }
}

/// Route an integer result in `src` into any `dst` kind: register
/// copy, direct spill store, or `movq` into an FP register.
fn int_result_to_dst(code: &mut Vec<u8>, dst: Place, src: Reg, frame: Frame) {
    match dst {
        Place::IntReg(r) => {
            if r != src.0 {
                emit_mov_rr(code, Reg(r), src);
            }
        }
        Place::Spill(_) => spill_dst_to_slot(code, dst, src, frame),
        Place::FpReg(r) => super::encode::emit_movq_xmm_r(code, Reg(r), src),
        Place::None => {}
    }
}

/// Number of XMM argument registers a call plan uses (System V AMD64
/// 3.2.3: a variadic call reports it in `al`).
fn xmm_arg_count(plan: &super::CallPlan) -> u8 {
    plan.placements
        .iter()
        .filter(|p| matches!(p, super::ArgPlacement::FpReg(_)))
        .count() as u8
}

/// A direct call to `target_pc`: opcode E8 with a rel32 the fixup pass
/// patches once the callee's native offset is known.
fn emit_call_to(code: &mut Vec<u8>, fixups: &mut Vec<Fixup>, target_pc: usize) {
    fixups.push(Fixup {
        native_offset: code.len(),
        target_ent_pc: target_pc,
        kind: super::encode::BranchKind::Call,
    });
    super::encode::emit_call_rel32(code, 0);
}

#[allow(clippy::too_many_arguments)]
pub(super) fn emit_call(
    code: &mut Vec<u8>,
    dst: Place,
    target_pc: usize,
    args: &[u32],
    fixed_args: usize,
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
    fixups: &mut Vec<Fixup>,
    callee_is_variadic: bool,
    fp_return: bool,
    fp_arg_mask: u32,
    arg_aggs: &[Option<u32>],
    agg_descs: &[super::super::ir::AggDesc],
    ret_agg: Option<u32>,
    ret_slot_local: i64,
    func: &FunctionSsa,
) -> Emit {
    // With no tagged aggregate `aggs` is empty and `plan_call_args_aggs`
    // reduces to the scalar placement, so every branch runs the aggregate
    // planner.
    let aggs = build_arg_aggs(arg_aggs, agg_descs, abi);
    // A variadic callee follows the host ABI: Win64 passes every argument on
    // the integer side, by position then on the stack at 8-byte stride (the
    // walker widened the FP arguments to double with `fp_arg_mask` 0); System
    // V AMD64 uses the standard banks and reports the XMM count in `al`. The
    // internal convention uses both banks; `fp_arg_mask` comes from the
    // argument types, since an FP constant rides an integer register.
    let (plan, site, xmm_count) = if callee_is_variadic && abi.position_indexed_args {
        let plan =
            super::plan_call_args_aggs(args.len(), fixed_args, fp_arg_mask, abi, &aggs, false);
        (plan, "Call (Win64 variadic)", None)
    } else if callee_is_variadic && abi.variadic_zero_xmm_count && !abi.position_indexed_args {
        let plan =
            super::plan_call_args_aggs(args.len(), fixed_args, fp_arg_mask, abi, &aggs, false);
        let xmm_used = xmm_arg_count(&plan);
        (plan, "Call (SysV variadic)", Some(xmm_used))
    } else if callee_is_variadic {
        // Outside both host branches a variadic callee would be marshaled
        // without the host variadic register protocol.
        return fail("Call: variadic callee not matched by a host-ABI branch");
    } else {
        let plan =
            super::plan_call_args_aggs(args.len(), args.len(), fp_arg_mask, abi, &aggs, false);
        (plan, "Call", None)
    };
    if plan.scratch_bytes > 0 {
        emit_stack_alloc(code, plan.scratch_bytes, None);
    }
    marshal_args(code, &plan, args, alloc, frame, abi, site)?;
    if let Some(n) = xmm_count {
        super::encode::emit_mov_al_imm8(code, n);
    }
    emit_call_to(code, fixups, target_pc);
    if plan.scratch_bytes > 0 {
        emit_add_rsp_imm32(code, plan.scratch_bytes);
    }
    // A <= 16-byte aggregate return arrives classified; larger ones keep the
    // out-pointer convention and never set `ret_agg`.
    if store_ret_agg(code, ret_agg, agg_descs, ret_slot_local, func, frame, abi) {
        return Ok(());
    }
    // An integer result lives in rax, an FP result in xmm0 (C99 6.2.5p10).
    if fp_return {
        xmm0_result_to_dst(code, dst, frame);
    } else if callee_is_variadic {
        mirror_int_dst(code, dst, Reg::RAX, frame);
    } else {
        int_result_to_dst(code, dst, Reg::RAX, frame);
    }
    Ok(())
}

pub(super) fn emit_call_ext(
    code: &mut Vec<u8>,
    dst: Place,
    binding_idx: i64,
    args: &[u32],
    fp_arg_mask: u32,
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
    target: Target,
    plt_call_fixups: &mut Vec<PltCallFixup>,
    imports: &super::ResolvedImports,
    arg_aggs: &[Option<u32>],
    agg_descs: &[super::super::ir::AggDesc],
    ret_agg: Option<u32>,
    ret_slot_local: i64,
    func: &FunctionSsa,
) -> Emit {
    let Some(import_index) = imports.index_of_binding(binding_idx) else {
        return fail("CallExt: binding index has no resolved import");
    };
    let imp = &imports.imports[import_index];
    let fixed = if imp.is_variadic {
        imp.fixed_args.min(args.len())
    } else {
        args.len()
    };
    // With no by-value struct argument this reduces to the scalar
    // `plan_call_args` placement; a tagged aggregate rides through the
    // host-ABI argument-register packing instead.
    let aggs = build_arg_aggs(arg_aggs, agg_descs, abi);
    let plan = super::plan_call_args_aggs(args.len(), fixed, fp_arg_mask, abi, &aggs, false);
    let xmm_used = xmm_arg_count(&plan);
    if plan.scratch_bytes > 0 {
        emit_stack_alloc(code, plan.scratch_bytes, None);
    }
    marshal_args(code, &plan, args, alloc, frame, abi, "CallExt")?;
    // System V AMD64 3.2.3: a variadic callee reads the XMM argument count
    // from `al`; a non-variadic one ignores it, zeroed for determinism.
    // Win64 clears `variadic_zero_xmm_count`.
    if abi.variadic_zero_xmm_count {
        if imp.is_variadic {
            super::encode::emit_mov_al_imm8(code, xmm_used);
        } else {
            super::encode::emit_xor_eax_eax(code);
        }
    }
    let call_site = code.len();
    plt_call_fixups.push(PltCallFixup {
        instr_offset: call_site,
        import_index,
        is_tail: false,
        is_addr: false,
    });
    super::encode::emit_call_rel32(code, 0);
    if plan.scratch_bytes > 0 {
        emit_add_rsp_imm32(code, plan.scratch_bytes);
    }
    // A register-returned aggregate (System V AMD64 3.2.3) stores into the
    // caller's result temp; > 16-byte returns take the out-pointer path.
    if store_ret_agg(code, ret_agg, agg_descs, ret_slot_local, func, frame, abi) {
        return Ok(());
    }
    // A sub-word integer return is extended into rax; an FP return arrives
    // in xmm0 and routes to the allocated place. A System V long double
    // arrives in st0: `fstp QWORD PTR [rsp]` rounds it to the f64 c5 stores
    // in its 8-byte slot.
    use crate::c5::compiler::types as ty_helpers;
    let return_type_tag = imp.return_type_tag;
    let bare = ty_helpers::strip_unsigned(return_type_tag);
    let returns_long_double = imp.returns_long_double;
    if returns_long_double && matches!(target, Target::LinuxX64) {
        emit_sub_rsp_imm32(code, 16);
        // fstp QWORD PTR [rsp] -- `DD /3`, mod=00, rm=100 (SIB
        // follows), SIB = 0x24 (base = rsp, no index).
        code.extend_from_slice(&[0xDD, 0x1C, 0x24]);
        let scratch = match dst {
            Place::IntReg(r) if r != Reg::RAX.0 => Reg(r),
            _ => SCRATCH_R10,
        };
        emit_mov_r_mem(code, scratch, Reg::RSP, 0);
        emit_add_rsp_imm32(code, 16);
        int_result_to_dst(code, dst, scratch, frame);
        return Ok(());
    }
    if ty_helpers::is_float_ty(bare) || ty_helpers::is_double_ty(bare) {
        // An f32 result is the single in the low 32 bits of xmm0, the form the
        // FP casts and `StoreLocal F32` consume, so it routes without widening.
        xmm0_result_to_dst(code, dst, frame);
        return Ok(());
    }
    let ext = super::return_extension(return_type_tag, target);
    super::encode::emit_extend_rax_for_return(code, ext);
    mirror_int_dst(code, dst, Reg::RAX, frame);
    Ok(())
}

/// The ABI a call site marshals to: the callee's own convention, the
/// target's unless it declares `ms_abi` / `sysv_abi`; never the caller's.
/// The rest of `Abi` describes this compilation and carries over.
pub(super) fn callee_abi(abi: super::Abi, target: Target, conv: super::CallConv) -> super::Abi {
    let row = target.abi_for(conv);
    super::Abi {
        int_arg_regs: row.int_arg_regs,
        shadow_space: row.shadow_space,
        variadic_on_stack: row.variadic_on_stack,
        variadic_int_only: row.variadic_int_only,
        position_indexed_args: row.position_indexed_args,
        variadic_zero_xmm_count: row.variadic_zero_xmm_count,
        ..abi
    }
}

#[allow(clippy::too_many_arguments)]
pub(super) fn emit_call_indirect(
    code: &mut Vec<u8>,
    dst: Place,
    target: u32,
    args: &[u32],
    callee_variadic: bool,
    fixed_args: usize,
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
    fp_return: bool,
    fp_arg_mask: u32,
    arg_aggs: &[Option<u32>],
    agg_descs: &[super::super::ir::AggDesc],
    ret_agg: Option<u32>,
    ret_slot_local: i64,
    func: &super::super::ir::FunctionSsa,
    extern_sites: &mut Vec<super::UserExternCallSite>,
) -> Emit {
    let target_place = place_of(alloc, target);
    // A Win64 variadic indirect call splits the arguments into the named
    // prefix, placed by position, and the variadic tail at 8-byte stride past
    // the home area; every other dialect treats all arguments as fixed.
    let fixed = if callee_variadic && abi.position_indexed_args {
        fixed_args.min(args.len())
    } else {
        args.len()
    };
    // A tagged by-value aggregate rides `plan_call_args_aggs`; with none the
    // plan is the scalar placement.
    let aggs = build_arg_aggs(arg_aggs, agg_descs, abi);
    let plan = super::plan_call_args_aggs(args.len(), fixed, fp_arg_mask, abi, &aggs, false);
    // The staged target must avoid every register the marshal reads (the
    // argument sources) or writes (every integer register the plan fills,
    // and the r10 staging scratch).
    let mut blocked: alloc::vec::Vec<Reg> =
        alloc::vec::Vec::with_capacity(args.len() + abi.int_arg_regs.len() + 2);
    for &a in args {
        if let Some(Place::IntReg(r)) = alloc.places.get(a as usize) {
            blocked.push(Reg(*r));
        }
    }
    for p in &plan.placements {
        match p {
            super::ArgPlacement::IntReg(r) | super::ArgPlacement::StructByRefReg(r) => {
                blocked.push(Reg(*r));
            }
            super::ArgPlacement::StructRegs { regs, n, .. } => {
                for cr in &regs[..*n as usize] {
                    if !cr.is_fp {
                        blocked.push(Reg(cr.reg));
                    }
                }
            }
            _ => {}
        }
    }
    blocked.push(SCRATCH_R10);
    // A System V variadic call sets `al` just before the `call`, so the
    // target must not sit in rax.
    let sysv_variadic_call = callee_variadic && abi.sysv_host_variadic();
    if sysv_variadic_call {
        blocked.push(Reg::RAX);
    }
    // The target pointer moves to a caller-saved scratch before the marshal
    // clobbers it; when every candidate is blocked it spills to the stack.
    let target_scratch = pick_caller_saved_scratch(Reg(0xff), &blocked, abi.fixed_regs);
    // System V AMD64 3.2.3: a variadic call passes the XMM-argument
    // count in `al`. Computed from the plan and emitted after the
    // marshal (which never writes rax, blocked above for the target).
    let xmm_used = xmm_arg_count(&plan);
    if let Some(target_scratch) = target_scratch {
        // A free caller-saved register is available: stage the
        // target there, then marshal. The marshal never writes
        // `target_scratch` (it is neither an arg source nor r10).
        let Some(target_r) = materialize_int(code, target_place, target_scratch, frame) else {
            return fail("CallIndirect: target not int reg / spill");
        };
        if target_r.0 != target_scratch.0 {
            emit_mov_rr(code, target_scratch, target_r);
        }
        if plan.scratch_bytes > 0 {
            emit_stack_alloc(code, plan.scratch_bytes, None);
        }
        marshal_args(code, &plan, args, alloc, frame, abi, "CallIndirect")?;
        if sysv_variadic_call {
            super::encode::emit_mov_al_imm8(code, xmm_used);
        }
        emit_hardened_call_r(code, target_scratch, abi, extern_sites);
        if plan.scratch_bytes > 0 {
            emit_add_rsp_imm32(code, plan.scratch_bytes);
        }
    } else {
        // No register survives the marshal: the target spills to a 16-byte slot
        // above the scratch window (the call site keeps rsp 16-aligned) and
        // reloads into r10 for the `call`.
        let Some(target_r) = materialize_int(code, target_place, SCRATCH_R10, frame) else {
            return fail("CallIndirect: target not int reg / spill");
        };
        let slot_bytes = 16u32;
        emit_sub_rsp_imm32(code, slot_bytes);
        emit_mov_mem_r(code, Reg::RSP, 0, target_r);
        if plan.scratch_bytes > 0 {
            emit_stack_alloc(code, plan.scratch_bytes, None);
        }
        // The slot joins the rsp shift the marshal applies to its spilled-source
        // reloads.
        let mut shifted = plan.clone();
        shifted.scratch_bytes = plan.scratch_bytes + slot_bytes;
        marshal_args(code, &shifted, args, alloc, frame, abi, "CallIndirect")?;
        // The target slot sits just above the marshal's scratch
        // window, at [rsp + scratch_bytes] after the second sub.
        emit_mov_r_mem(code, SCRATCH_R10, Reg::RSP, plan.scratch_bytes as i32);
        if sysv_variadic_call {
            super::encode::emit_mov_al_imm8(code, xmm_used);
        }
        emit_hardened_call_r(code, SCRATCH_R10, abi, extern_sites);
        if plan.scratch_bytes > 0 {
            emit_add_rsp_imm32(code, plan.scratch_bytes);
        }
        emit_add_rsp_imm32(code, slot_bytes);
    }
    // A register-returned aggregate (System V AMD64 3.2.3) stores into the
    // caller's result temp.
    if store_ret_agg(code, ret_agg, agg_descs, ret_slot_local, func, frame, abi) {
        return Ok(());
    }
    // A floating-point return rides xmm0 (C99 6.2.5p10); an integer
    // / pointer return rides rax. `fp_return` selects the source for
    // every dst kind.
    if fp_return {
        xmm0_result_to_dst(code, dst, frame);
    } else {
        int_result_to_dst(code, dst, Reg::RAX, frame);
    }
    Ok(())
}

/// System V AMD64 `va_arg` (ABI 3.5.7). `args[0]` is the `__va_list_tag`
/// pointer, `args[1]` the packed `(kind << 16) | size` descriptor. Returns
/// the address of the slot holding the next argument and advances the
/// matching field: an integer class comes from the register save area at
/// `gp_offset` (< 48, step 8), a floating-point one at `fp_offset` (< 176,
/// step 16), else from `overflow_arg_area` (step 8). Layout: gp_offset at
/// +0, fp_offset at +4, overflow_arg_area at +8, reg_save_area at +16.
pub(super) fn emit_va_arg_sysv(
    code: &mut Vec<u8>,
    args: &[u32],
    dst: Place,
    func: &FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
) -> Emit {
    if args.len() != 2 {
        return fail("VaArg: expected 2 args (ap, descriptor)");
    }
    // Recover the packed descriptor from the `Inst::Imm` the parser
    // folded for the type operand.
    let descriptor = match func.insts.get(args[1] as usize) {
        Some(Inst::Imm(d)) => *d,
        _ => return fail("VaArg: descriptor operand is not a constant"),
    };
    let kind = (descriptor >> 16) & 0xffff;
    let is_fp = kind == 1;
    // Cursor pointer (struct address) held in r11, outside the
    // allocator's banks. The result address is computed in r10; both
    // are disjoint from the allocator-chosen `dst`.
    let Some(ap_place) = alloc.places.get(args[0] as usize).copied() else {
        return fail("VaArg: &ap value id out of range");
    };
    let Some(ap) = materialize_int(code, ap_place, SCRATCH_R11, frame) else {
        return fail("VaArg: &ap not in int reg / spill");
    };
    // r11 must hold the struct pointer across the whole sequence; if
    // `materialize_int` returned an allocator register, move it into r11
    // so the offset writebacks don't clobber a live value.
    let ap = if ap.0 != SCRATCH_R11.0 {
        emit_mov_rr(code, SCRATCH_R11, ap);
        SCRATCH_R11
    } else {
        ap
    };
    // A by-value integer-class aggregate spans `ceil(size/8)` consecutive gp
    // slots and rides the save area only when all of them fit; FP arguments
    // are single doubles (the classifier declines HFAs).
    let aligned = (((descriptor & 0xffff) as i32 + 7) & !7).max(8);
    let (off_disp, bound, step): (i32, i32, i32) = if is_fp {
        (4, 176, 16)
    } else {
        (0, 48 - (aligned - 8), aligned)
    };
    // The sequence touches only r10 / r11 and the in-memory fields, so no
    // allocated value is clobbered.
    super::encode::emit_mov_r32_mem(code, SCRATCH_R10, ap, off_disp);
    // cmp r10d, bound ; jae use_overflow
    super::encode::emit_ri(code, Mnem::Cmp, 8, SCRATCH_R10, bound);
    super::encode::emit_jcc_rel32(code, Cc::Ae, 0);
    let jae_rel32_at = code.len() - 4;
    // --- register-save path ---
    // r10 = offset + reg_save_area (at [ap + 16]) = the argument slot,
    // then bump the offset field in memory by step.
    super::encode::emit_rm(code, Mnem::Add, 8, SCRATCH_R10, ap, 16);
    super::encode::emit_mi(code, Mnem::Add, 4, ap, off_disp, step);
    // jmp done
    super::encode::emit_jmp_rel32(code, 0);
    let jmp_rel32_at = code.len() - 4;
    // --- overflow path ---
    let overflow_start = code.len();
    let rel_to_overflow = (overflow_start - (jae_rel32_at + 4)) as i32;
    code[jae_rel32_at..jae_rel32_at + 4].copy_from_slice(&rel_to_overflow.to_le_bytes());
    // The overflow slot, advanced by the argument's eightbyte span (System V
    // AMD64 3.5.7 rounds each overflow argument to an eightbyte).
    let ov_step = if is_fp { 8 } else { aligned };
    emit_mov_r_mem(code, SCRATCH_R10, ap, 8);
    super::encode::emit_mi(code, Mnem::Add, 8, ap, 8, ov_step);
    // --- done: r10 holds the argument address; deliver it to dst. ---
    let done = code.len();
    let rel_to_done = (done - (jmp_rel32_at + 4)) as i32;
    code[jmp_rel32_at..jmp_rel32_at + 4].copy_from_slice(&rel_to_done.to_le_bytes());
    int_result_to_dst(code, dst, SCRATCH_R10, frame);
    Ok(())
}

/// `Some((call_pc, target_pc, args))` when `block` returns the value of
/// its last instruction, a direct `Inst::Call` the epilogue can replace by
/// a jump: the arguments fit the host argument-register window, this
/// function is not variadic, the callee is on the same convention with a
/// known return extension, no aggregate rides the call, and no
/// `LocalAddr` (user local or c5 cdecl cell) exists that could dangle once
/// the frame is gone. The marshalled arguments ride caller-saved
/// registers, disjoint from the callee-saved ones the epilogue restores.
pub(super) fn detect_tail_call<'a>(
    func: &'a FunctionSsa,
    block: &super::super::ir::Block,
    abi: super::Abi,
    variadic_targets: &alloc::collections::BTreeSet<usize>,
    conv_targets: &alloc::collections::BTreeMap<usize, super::CallConv>,
    ret_tags: &alloc::collections::BTreeMap<usize, i64>,
    target: Target,
) -> Option<(usize, usize, &'a [u32])> {
    let Terminator::Return(v) = block.terminator else {
        return None;
    };
    if v == super::super::ir::NO_VALUE {
        return None;
    }
    // An empty block whose range starts after another block's trailing call
    // also satisfies `v + 1 == end`; that call belongs to its own block.
    if v < block.inst_range.start || v + 1 != block.inst_range.end {
        return None;
    }
    let (target_pc, args, arg_aggs) = match &func.insts[v as usize] {
        Inst::Call {
            target_pc,
            args,
            arg_aggs,
            ..
        } => (*target_pc, args.as_slice(), arg_aggs.as_slice()),
        _ => return None,
    };
    if args.len() > abi.int_arg_regs.len() {
        return None;
    }
    // The tail-call plan is the scalar one, which would pass an aggregate by
    // address rather than in its eightbytes.
    if arg_aggs.iter().any(Option::is_some) {
        return None;
    }
    if func.is_variadic {
        return None;
    }
    // A variadic callee takes the c5-stack argument convention.
    if variadic_targets.contains(&target_pc) {
        return None;
    }
    // A callee on another convention wants a different argument window,
    // shadow space and preserved-register set.
    if conv_targets.get(&target_pc).copied().unwrap_or_default() != func.conv {
        return None;
    }
    // The callee's return extension replaces this function's, so the two
    // contracts must agree; an unknown callee has no recorded contract.
    let &callee_tag = ret_tags.get(&target_pc)?;
    if super::return_extension(callee_tag, target)
        != super::return_extension(func.ret_type_tag, target)
    {
        return None;
    }
    // A taken local or parameter-cell address may be held by an earlier
    // callee; the frame teardown would leave it dangling.
    if func.insts.iter().any(|i| matches!(i, Inst::LocalAddr(_))) {
        return None;
    }
    // An alloca / VLA frame keeps its runtime allocations live until
    // the function returns; a tail jmp would tear them down under the
    // callee (same reason `LocalAddr` disqualifies above).
    if super::ssa::emit_common::uses_dynamic_alloca(func) {
        return None;
    }
    Some((v as usize, target_pc, args))
}

/// A tail call: `marshal_args; epilogue; jmp target`. The epilogue is
/// `emit_return`'s teardown without the return-value staging; the callee's
/// own `ret` returns to this function's caller.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_tail_call(
    code: &mut Vec<u8>,
    target_pc: usize,
    args: &[u32],
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
    fixups: &mut Vec<Fixup>,
    func: &FunctionSsa,
    fp_arg_mask: u32,
    extern_sites: &mut Vec<super::UserExternCallSite>,
    extern_data_refs: &mut Vec<super::UserExternDataRef>,
) -> Emit {
    debug_assert!(
        !frame.dynamic_sp,
        "detect_tail_call rejects dynamic-sp frames"
    );
    // The argument-register window is disjoint from `alloc.gpr_used`, so the
    // restores below cannot clobber the marshalled values.
    let mut plan = super::plan_call_args(args.len(), args.len(), fp_arg_mask, abi);
    // `detect_tail_call` rejects arg counts above `int_arg_regs.len()`,
    // so no `Stack(offset)` placements ever reach here (FP args ride
    // the independent FP bank and never overflow with <= 6 total args).
    if plan
        .placements
        .iter()
        .any(|p| matches!(p, super::ArgPlacement::Stack(_)))
    {
        unreachable!(
            "ICE: tail-call planner returned a Stack arg placement; \
             detect_tail_call should have rejected arg_count > int_arg_regs"
        );
    }
    // No scratch window is allocated here (the callee inherits the slot from
    // this function's caller), so rsp has not moved and the marshal's
    // sp shift must be zero.
    plan.scratch_bytes = 0;
    marshal_args(code, &plan, args, alloc, frame, abi, "TailCall")?;
    // `emit_return`'s epilogue without the return-value staging.
    emit_canary_check(code, frame, abi, extern_sites, extern_data_refs);
    restore_callee_saved(code, alloc, frame);
    if !is_full_leaf(func, frame, alloc, abi) {
        if frame.frame_bytes > 0 {
            emit_add_rsp_imm32(code, frame.frame_bytes);
        }
        emit_pop_r(code, Reg::RBP);
        if frame.param_spill_bytes > 0 {
            emit_add_rsp_imm32(code, frame.param_spill_bytes);
        }
    }
    // A Call-kind fixup resolves the rel32 like an intra-unit call; the
    // opcode is `jmp`.
    let jmp_site = code.len();
    fixups.push(Fixup {
        native_offset: jmp_site,
        target_ent_pc: target_pc,
        kind: super::encode::BranchKind::Jmp,
    });
    super::encode::emit_jmp_rel32(code, 0);
    Ok(())
}
