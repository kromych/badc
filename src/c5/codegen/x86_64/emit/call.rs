use super::*;

/// Place every argument into its System V / Win64 slot in an order that
/// survives source / target overlaps: the allocator's caller-saved bank
/// covers the argument registers, so an argument's value can sit in
/// another argument's target register. Stack slots first (their sources
/// are read into `SCRATCH_R10`, preserving every register a later pass
/// touches), then the FP register placements, then the integer register
/// placements as one parallel copy, then the spill sources materialised
/// straight into their targets.
fn marshal_args(
    code: &mut Vec<u8>,
    plan: &super::CallPlan,
    args: &[u32],
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
    site: &str,
) -> bool {
    let m = Marshal {
        plan,
        args,
        alloc,
        frame,
        abi,
        site,
    };
    if !m.stack_args(code)
        || !m.struct_stack_args(code)
        || !m.fp_args(code)
        || !m.sse_aggs(code)
        || !m.int_args(code)
    {
        return false;
    }
    m.agg_eightbytes(code);
    true
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

    fn fail(&self, m: &str) -> bool {
        fail(&alloc::format!("{}: {m}", self.site))
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

    /// Read `args[i]` into `scratch`.
    fn arg_into(&self, code: &mut Vec<u8>, i: usize, scratch: Reg) -> bool {
        let Some(src) = self.arg_int(code, i, scratch) else {
            return false;
        };
        if src.0 != scratch.0 {
            emit_mov_rr(code, scratch, src);
        }
        true
    }

    fn stack_args(&self, code: &mut Vec<u8>) -> bool {
        for (i, &placement) in self.plan.placements.iter().enumerate() {
            if let super::ArgPlacement::Stack(off) = placement {
                let Some(src) = self.arg_int(code, i, SCRATCH_R10) else {
                    return self.fail("stack arg not in int reg / spill");
                };
                emit_mov_mem_r(code, Reg::RSP, off as i32, src);
            }
        }
        true
    }

    /// Aggregates passed on the outgoing stack (System V AMD64 MEMORY
    /// class): the struct is copied to [rsp + off] while its base address,
    /// which may sit in an argument register the register moves overwrite,
    /// is still live. The address rides SCRATCH_R10, the per-word temp
    /// SCRATCH_R11; both lie outside the allocator pools.
    fn struct_stack_args(&self, code: &mut Vec<u8>) -> bool {
        for (i, &placement) in self.plan.placements.iter().enumerate() {
            let super::ArgPlacement::StructStack { off, size, align } = placement else {
                continue;
            };
            if !self.arg_into(code, i, SCRATCH_R10) {
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
        true
    }

    /// FP register placements. The xmm-to-xmm moves form a parallel copy
    /// (System V passes successive FP args in xmm0, xmm1, ...), scheduled
    /// first so every xmm source is consumed before a spill or integer
    /// source materialises into its target xmm. The second FP scratch
    /// breaks a cycle and lies outside the allocator's xmm pool.
    fn fp_args(&self, code: &mut Vec<u8>) -> bool {
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
        true
    }

    /// System V aggregates whose eightbytes are all SSE: no integer
    /// eightbyte register can hold the base, so the source address goes
    /// through a scratch GPR and each eightbyte's xmm loads from it. Runs
    /// after the scalar-FP moves (their xmm sources consumed); the loads
    /// touch only SCRATCH_R10 and the aggregate's own xmm targets, so they
    /// cannot disturb the integer parallel move. Mixed aggregates are
    /// deferred to it: their integer eightbyte targets may still be
    /// another argument's pending source.
    fn sse_aggs(&self, code: &mut Vec<u8>) -> bool {
        for (i, &placement) in self.plan.placements.iter().enumerate() {
            let super::ArgPlacement::StructRegs { regs, n, align } = placement else {
                continue;
            };
            if n == 0 || !regs.iter().take(n as usize).all(|c| c.is_fp) {
                continue;
            }
            if !self.arg_into(code, i, SCRATCH_R10) {
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
        true
    }

    /// Integer register placements plus aggregate base addresses as one
    /// parallel register move (System V AMD64 3.2.3): a scalar argument
    /// moves source to target; an aggregate positions its base address
    /// into its own first integer eightbyte register, from which the
    /// eightbytes load (that register's own eightbyte last). Routing each
    /// base through its own register keeps one aggregate's loads from
    /// clobbering another's pending base. The sources not already
    /// register-resident then materialise into their targets.
    fn int_args(&self, code: &mut Vec<u8>) -> bool {
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
                        if !self.arg_into(code, i, Reg(r)) {
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
                && !self.arg_into(code, i, Reg(dst))
            {
                return self.fail("aggregate base not in int reg / spill");
            }
        }
        true
    }

    /// Load each aggregate's eightbytes from the base now in its first
    /// integer eightbyte register: SSE eightbytes first (they leave the
    /// base intact), then the remaining integer eightbytes high-first, the
    /// base register's own eightbyte last since the load overwrites it.
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
/// Store a register-classed <= 16-byte aggregate return into the
/// caller's result temp at `[rbp + base]`. Eightbytes are classified
/// (System V AMD64 3.2.3): INTEGER arrive in rax:rdx, SSE in
/// xmm0:xmm1; Win64 register returns classify as one INTEGER
/// eightbyte in rax. Variadic and non-variadic callees return
/// identically, so every call shape shares this store.
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
) -> bool {
    // With no tagged aggregate `aggs` is empty and `plan_call_args_aggs`
    // reduces to the scalar placement, so every branch runs the aggregate
    // planner.
    let aggs = build_arg_aggs(arg_aggs, agg_descs, abi);
    // A variadic callee follows the host ABI. Win64 (`position_indexed_args`)
    // passes the first four arguments by position in rcx/rdx/r8/r9 and the
    // rest on the stack at 8-byte stride above the home area; the walker
    // widened the variadic FP arguments to double with `fp_arg_mask` 0, so
    // every argument rides the integer side. System V AMD64 places the
    // arguments in the standard register banks (3.2.3) and reports the
    // number of XMM argument registers in `al`, so the callee prologue's
    // guarded XMM save runs only when needed. The c5-internal convention
    // passes integer / pointer arguments in the integer bank and FP scalars
    // in the FP bank; the callee prologue spills each incoming register into
    // its c5 cdecl cell using the same placement. `fp_arg_mask` comes from
    // the argument types, since an FP constant rides an integer register as
    // its `Imm` bit pattern.
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
    if !marshal_args(code, &plan, args, alloc, frame, abi, site) {
        return false;
    }
    if let Some(n) = xmm_count {
        super::encode::emit_mov_al_imm8(code, n);
    }
    emit_call_to(code, fixups, target_pc);
    if plan.scratch_bytes > 0 {
        emit_add_rsp_imm32(code, plan.scratch_bytes);
    }
    // A <= 16-byte aggregate return arrives classified (System V AMD64
    // 3.2.3: INTEGER eightbytes in rax:rdx, SSE in xmm0:xmm1), for a
    // variadic callee as for any other; larger returns keep the out-pointer
    // convention and never set `ret_agg`.
    if store_ret_agg(code, ret_agg, agg_descs, ret_slot_local, func, frame, abi) {
        return true;
    }
    // An integer / pointer result lives in rax, an FP result in xmm0 (C99
    // 6.2.5p10). The host variadic branches mirror the integer result
    // through the working-register pick; the internal convention routes it
    // into any destination kind.
    if fp_return {
        xmm0_result_to_dst(code, dst, frame);
    } else if callee_is_variadic {
        mirror_int_dst(code, dst, Reg::RAX, frame);
    } else {
        int_result_to_dst(code, dst, Reg::RAX, frame);
    }
    true
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
) -> bool {
    let Some(import_index) = imports.index_of_binding(binding_idx) else {
        return false;
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
    if !marshal_args(code, &plan, args, alloc, frame, abi, "CallExt") {
        return false;
    }
    // System V AMD64 ABI 3.2.3: when the callee is variadic, `al`
    // must hold the number of XMM argument registers used (printf
    // and friends consult `al` in their prologue to decide whether
    // to spill xmm0..xmm7 into the va-save area). Non-variadic
    // SysV callees treat `al` as don't-care; zero it for
    // determinism. Win64 has no such requirement and clears
    // `variadic_zero_xmm_count` in its `Abi`.
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
    // Host-ABI aggregate return (System V AMD64 3.2.3): a <= 16-byte
    // aggregate arrives in rax:rdx (INTEGER) / xmm0:xmm1 (SSE); store each
    // eightbyte into the caller's result temp. The walker tags `ret_agg`
    // for the register-returned class; > 16-byte returns use the OutPtr
    // hidden-argument path and do not reach here.
    if store_ret_agg(code, ret_agg, agg_descs, ret_slot_local, func, frame, abi) {
        return true;
    }
    // Sub-word integer returns get the standard sign / zero
    // extension into rax. FP returns arrive in xmm0 (SysV 3.2.3,
    // Win64 returns scalars/SSE in xmm0); route into the
    // allocator's chosen Place, which may be an FpReg, an IntReg
    // (holding the f64 bit pattern -- c5's accumulator is one big
    // 8-byte slot), or a spill slot.
    //
    // SysV long-double sits in x87 st0 (binary128 mantissa
    // truncated to the x87 80-bit format). c5 stores long double
    // in an 8-byte slot, so emit `fstp QWORD PTR [rsp]` to round
    // st0 to f64 and route the f64 bit pattern through the same
    // dst dispatch.
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
        return true;
    }
    if ty_helpers::is_float_ty(bare) || ty_helpers::is_double_ty(bare) {
        // A float / double result is FP-classed (`Inst::CallExt::fp_return`).
        // An f32 result is the single in the low 32 bits of xmm0 -- the same
        // form `FpCast(F64ToF32)` produces and `StoreLocal F32` /
        // `FpCast(F32ToF64)` consume -- so route it without widening. (The
        // prior GPR-bridged path widened via cvtss2sd because the
        // integer-class convention carried the f64-widened bits.)
        xmm0_result_to_dst(code, dst, frame);
        return true;
    }
    let ext = super::return_extension(return_type_tag, target);
    super::encode::emit_extend_rax_for_return(code, ext);
    mirror_int_dst(code, dst, Reg::RAX, frame);
    true
}

/// The ABI a call site marshals to: the callee's own convention, which
/// is the target's unless the callee declares `ms_abi` / `sysv_abi`.
/// It is never the caller's -- a `ms_abi` function calling an ordinary
/// one has to marshal into the ordinary one's argument window. The rest
/// of `Abi` describes this compilation rather than any convention, so
/// it carries over from the caller unchanged.
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
) -> bool {
    let target_place = place_of(alloc, target);
    // Collect every register `marshal_args` reads or writes for
    // this call; the staged target must avoid all of them.
    //
    //   * Arg SOURCES: the marshal reads each argument from its
    //     allocator placement. Staging the target over an arg
    //     source corrupts that arg before the marshal copies it.
    //   * Arg DESTINATIONS (`abi.int_arg_regs[0..n]`, e.g.
    //     rcx/rdx/r8/r9 on Win64, rdi/rsi/rdx/rcx/r8/r9 on SysV):
    //     the marshal writes each argument into its target arg
    //     register. Staging the target into an arg-destination
    //     register lets the marshal overwrite it before the
    //     `call`, sending control to the first argument's value.
    //   * SCRATCH_R10: the marshal's parallel-register-move scratch
    //     (`schedule_int_reg_moves`) and spill/stack staging
    //     register; it is clobbered mid-marshal.
    // A Win64 variadic indirect call (the pointed-to prototype is
    // variadic and the target is Win64) splits the arguments into the
    // named prefix and the variadic tail: the planner places the named
    // prefix per Win64 position-indexing and the variadic tail at
    // 8-byte stride past the home area (Microsoft x64 calling
    // convention). The walker widened the variadic floating-point
    // arguments to double and passed `fp_arg_mask` 0, so every argument
    // rides the integer side. Every other dialect (SysV, or a
    // non-variadic Win64 callee) treats all arguments as fixed, which
    // leaves `fixed = args.len()` and the placement unchanged.
    let fixed = if callee_variadic && abi.position_indexed_args {
        fixed_args.min(args.len())
    } else {
        args.len()
    };
    // A by-value aggregate argument the classifier tagged rides through
    // `plan_call_args_aggs`, which lays its eightbytes into the argument
    // registers / stack (System V AMD64 3.2.3); with no tagged aggregate
    // this reduces to the scalar placement.
    let aggs = build_arg_aggs(arg_aggs, agg_descs, abi);
    let plan = super::plan_call_args_aggs(args.len(), fixed, fp_arg_mask, abi, &aggs, false);
    // Collect every register `marshal_args` reads or writes for this
    // call; the staged target pointer must avoid all of them.
    //   * Arg SOURCES: each argument is read from its allocator
    //     placement; staging the target over a source corrupts it.
    //   * Arg DESTINATIONS: every integer register the plan writes -- a
    //     scalar `IntReg`, a by-reference base, or an aggregate's
    //     integer eightbytes -- is overwritten before the `call`.
    //   * SCRATCH_R10: the marshal's parallel-move / staging scratch.
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
    // A System V variadic indirect call sets `al` to the XMM-argument
    // count just before the `call` (System V AMD64 3.2.3). The target
    // pointer must not be staged in rax, or the `mov al, imm8` would
    // corrupt its low byte; block rax for the target scratch.
    let sysv_variadic_call = callee_variadic && abi.sysv_host_variadic();
    if sysv_variadic_call {
        blocked.push(Reg::RAX);
    }
    // Capture the target pointer into a caller-saved scratch before arg
    // marshalling can clobber it. rax is the usual pick: no ABI assigns
    // it to an argument slot, so it is blocked only on a System V
    // variadic call (where it carries the XMM count). The pool excludes
    // the marshal's reserved scratch r10 / r11, so a pick never aliases
    // it. When everything is blocked the `else` branch below spills the
    // target to the stack.
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
        if !marshal_args(code, &plan, args, alloc, frame, abi, "CallIndirect") {
            return false;
        }
        if sysv_variadic_call {
            super::encode::emit_mov_al_imm8(code, xmm_used);
        }
        emit_hardened_call_r(code, target_scratch, abi, extern_sites);
        if plan.scratch_bytes > 0 {
            emit_add_rsp_imm32(code, plan.scratch_bytes);
        }
    } else {
        // Every caller-saved register is an arg source (and r10 is
        // reserved for the marshal). No register survives the
        // marshal, so spill the target to a fresh 16-byte stack
        // slot above the marshal's scratch window, marshal, then
        // reload into SCRATCH_R10 for the `call`. The 16-byte slot
        // keeps the call-site sp 16-aligned (SysV / Win64 require
        // 16-byte alignment at `call`).
        let Some(target_r) = materialize_int(code, target_place, SCRATCH_R10, frame) else {
            return fail("CallIndirect: target not int reg / spill");
        };
        let slot_bytes = 16u32;
        emit_sub_rsp_imm32(code, slot_bytes);
        emit_mov_mem_r(code, Reg::RSP, 0, target_r);
        if plan.scratch_bytes > 0 {
            emit_stack_alloc(code, plan.scratch_bytes, None);
        }
        // rsp is now slot_bytes + scratch_bytes below the frame baseline.
        // marshal_args reloads spilled argument sources at
        // `spill_offset + plan.scratch_bytes`; the target slot must be
        // folded into that shift, or every spilled-source reload reads
        // slot_bytes too low (a spilled arg loads garbage and the call
        // jumps through a corrupt register).
        let mut shifted = plan.clone();
        shifted.scratch_bytes = plan.scratch_bytes + slot_bytes;
        if !marshal_args(code, &shifted, args, alloc, frame, abi, "CallIndirect") {
            return false;
        }
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
    // Host-ABI aggregate return through a function pointer (System V
    // AMD64 3.2.3): a <= 16-byte aggregate arrives in rax:rdx; store it
    // into the caller's result temp. The walker tags `ret_agg` only for
    // the register-returned class, so > 16-byte (out-pointer) returns do
    // not reach here.
    if store_ret_agg(code, ret_agg, agg_descs, ret_slot_local, func, frame, abi) {
        return true;
    }
    // A floating-point return rides xmm0 (C99 6.2.5p10); an integer
    // / pointer return rides rax. `fp_return` selects the source for
    // every dst kind.
    if fp_return {
        xmm0_result_to_dst(code, dst, frame);
    } else {
        int_result_to_dst(code, dst, Reg::RAX, frame);
    }
    true
}

/// System V AMD64 `va_arg` (ABI 3.5.7). `args[0]` is the
/// `__va_list_tag` pointer; `args[1]` is the packed
/// `(kind << 16) | size` descriptor the parser folded as an
/// `Inst::Imm`. The intrinsic returns the address of the slot holding
/// the next argument (the `<stdarg.h>` macro dereferences it as the
/// requested type) and advances the matching offset / pointer in the
/// struct.
///
/// Integer / pointer (kind 0): if `gp_offset < 48` the value sits in
/// the register save area at `reg_save_area + gp_offset` and
/// `gp_offset` advances by 8; otherwise it sits in the overflow area
/// at `overflow_arg_area`, which advances by 8.
///
/// Floating-point (kind 1): if `fp_offset < 176` the value sits at
/// `reg_save_area + fp_offset` and `fp_offset` advances by 16;
/// otherwise it sits at `overflow_arg_area`, which advances by 8.
///
/// Struct layout (matching `<stdarg.h>` / libc): gp_offset at +0,
/// fp_offset at +4, overflow_arg_area at +8, reg_save_area at +16.
pub(super) fn emit_va_arg_sysv(
    code: &mut Vec<u8>,
    args: &[u32],
    dst: Place,
    func: &FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
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
    // A by-value integer-class aggregate spans `ceil(size/8)` eightbytes
    // in consecutive gp save-area slots (System V AMD64 3.5.7); it rides
    // the register save area only if all its eightbytes fit
    // (`gp_offset + aligned <= 48`), else the whole aggregate sits in the
    // overflow area. A scalar's aligned size is 8, leaving the bound and
    // step at their single-eightbyte values. Floating-point arguments are
    // single doubles (the classifier declines HFAs), so they keep the
    // 16-byte fp-slot step and 176-byte bound.
    let aligned = (((descriptor & 0xffff) as i32 + 7) & !7).max(8);
    let (off_disp, bound, step): (i32, i32, i32) = if is_fp {
        (4, 176, 16)
    } else {
        (0, 48 - (aligned - 8), aligned)
    };
    // r10 = current offset (gp_offset or fp_offset, a u32 field; the
    // 32-bit load zero-extends into r10). The whole sequence touches
    // only r10 and r11 -- both reserved outside the allocator's banks --
    // plus the in-memory va_list fields, so it never clobbers a live
    // allocator value (the consuming `t += va_arg(...)` keeps `t` in an
    // allocator register that an earlier draft overwrote via rcx).
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
    // r10 = overflow_arg_area (at [ap + 8]) = the argument slot, then
    // bump it in memory by the argument's eightbyte span. System V AMD64
    // 3.5.7 rounds each overflow argument to an eightbyte; a scalar or a
    // `double` occupies one, a by-value aggregate `ceil(size/8)`.
    let ov_step = if is_fp { 8 } else { aligned };
    emit_mov_r_mem(code, SCRATCH_R10, ap, 8);
    super::encode::emit_mi(code, Mnem::Add, 8, ap, 8, ov_step);
    // --- done: r10 holds the argument address; deliver it to dst. ---
    let done = code.len();
    let rel_to_done = (done - (jmp_rel32_at + 4)) as i32;
    code[jmp_rel32_at..jmp_rel32_at + 4].copy_from_slice(&rel_to_done.to_le_bytes());
    int_result_to_dst(code, dst, SCRATCH_R10, frame);
    true
}

/// Decide whether `block` ends in a tail-call shape: the block's
/// `Terminator::Return` value is the same block's last instruction,
/// and that instruction is a direct `Inst::Call` whose arguments
/// fit in the host integer-arg-register window. Returns
/// `Some((call_pc, target_pc, args))` when the shape matches and
/// every safety precondition holds.
///
/// Preconditions (in order):
///   * The terminator is `Return(v)` and `v` is the PC of the last
///     instruction in the block.
///   * That instruction is `Inst::Call { target_pc, args }`. Indirect
///     and external calls are out of scope for this pass.
///   * `args.len() <= abi.int_arg_regs.len()` -- no host-stack-overflow
///     argument; the epilogue would otherwise have to negotiate the
///     overflow stripe and the caller's stack at the same time.
///   * The callee isn't this function's variadic-marker call: c5's
///     internal cdecl-vs-variadic split is encoded by the callee's
///     own prologue, but the tail call site can't tell from here, so
///     keep the tail conversion off when *this* function is variadic
///     (its arg slots stay on the c5 stack rather than reg cells).
///   * The function takes no `LocalAddr`, whether to a user local
///     (negative `off`) or a c5 cdecl param cell (`off >= 2`): such an
///     address could have been passed to an earlier callee, and the
///     param cells are overwritten by the tail-callee's own prologue,
///     so tearing down the frame before the jmp would make it dangle.
///
/// Callee-saved register use is allowed: the marshalled arguments ride
/// the caller-saved arg-register window, which is disjoint from
/// `alloc.gpr_used` (only callee-saved regs land there), so the
/// epilogue's per-reg restores cannot clobber them (see
/// `emit_tail_call`).
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
    // The returned value must be this block's last instruction. `v + 1 ==
    // end` alone also holds for an empty block whose range starts right
    // after another block's trailing call: that call is emitted with its own
    // block, so converting here would call the callee and then jump into it
    // again with whatever the intervening code left in the argument
    // registers.
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
    // A by-value aggregate argument is marshalled into one or two
    // argument registers loaded from its source address (System V AMD64
    // 3.2.3); the tail-call path plans with the scalar `plan_call_args`,
    // which would instead pass the address as a single pointer. Fall
    // back to the regular call-and-return path, which honours the
    // aggregate placement.
    if arg_aggs.iter().any(Option::is_some) {
        return None;
    }
    if func.is_variadic {
        return None;
    }
    // Variadic callees use a different call ABI (c5-stack 16-byte
    // pushes rather than the host int-arg-register window), so the
    // tail conversion's `marshal_args` would deliver garbage. The
    // regular `emit_call` path branches on this same flag.
    if variadic_targets.contains(&target_pc) {
        return None;
    }
    // The tail conversion reuses this frame and this function's entry
    // contract; a callee on another calling convention wants a different
    // argument window, a different shadow-space reservation and a
    // different set of preserved registers. Keep the regular
    // call-then-return path.
    if conv_targets.get(&target_pc).copied().unwrap_or_default() != func.conv {
        return None;
    }
    // The callee's epilogue extends a sub-word integer return per its
    // own declared type, and the jmp skips this function's return
    // staging, so the two extension recipes must agree (an `int`
    // callee leaves a sign-extended accumulator that an `unsigned`
    // caller's contract does not allow). An unknown callee -- a
    // cross-unit placeholder pc -- has no recorded contract; keep the
    // regular call-then-return path.
    let &callee_tag = ret_tags.get(&target_pc)?;
    if super::return_extension(callee_tag, target)
        != super::return_extension(func.ret_type_tag, target)
    {
        return None;
    }
    // Any `LocalAddr` -- whether to a user-local (negative `off`) or
    // a c5 cdecl param cell (positive `off >= 2`) -- could have been
    // passed as an argument to an earlier call or stored where the
    // callee will read it. Tearing down our frame before the `jmp`
    // would make that address dangle; the param cells in particular
    // get overwritten by the tail-callee's own prologue.
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

/// Emit a tail call as `marshal_args; epilogue; jmp target`.
/// `args` are placed into the host integer arg-register window using
/// the same planner the regular `Inst::Call` path uses; the epilogue
/// mirrors `emit_return`'s frame teardown (callee-saved restores +
/// `add rsp` + `pop rbp` + cdecl-cell drop) but skips the return
/// value staging and ends in `jmp rel32` instead of `ret`. The
/// callee's own `ret` instruction returns control to *our* caller.
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
) -> bool {
    debug_assert!(
        !frame.dynamic_sp,
        "detect_tail_call rejects dynamic-sp frames"
    );
    // Marshal arguments into their ABI-prescribed registers. The
    // caller-saved arg-reg window is disjoint from `alloc.gpr_used`
    // (only callee-saved regs land there), so the epilogue's
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
    // marshal_args adds plan.scratch_bytes to every spill-slot rsp
    // offset because regular call sites do `sub rsp, scratch_bytes`
    // ahead of the marshal to set up the Win64 shadow-space window.
    // The tail-call path doesn't allocate that window (the callee
    // inherits the slot from our caller's frame), so rsp has not
    // moved -- any spill load must use the natural slot offset.
    // Clear scratch_bytes to suppress the marshal's sp_shift add.
    plan.scratch_bytes = 0;
    if !marshal_args(code, &plan, args, alloc, frame, abi, "TailCall") {
        return false;
    }
    // Mirror emit_return's epilogue, omitting the return-value
    // staging (the callee's own `ret` carries the value back). The
    // marshalled args ride caller-saved arg registers, disjoint from the
    // callee-saved GPRs and the non-volatile xmm scratch restored here.
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
    // Record a Call-kind fixup at the rel32 byte; the post-link pass
    // resolves `target_ent_pc` to its native byte offset like a
    // regular intra-unit call. The opcode emitted here is `jmp`
    // (E9 rel32), not `call`, so the callee's own `ret` returns to
    // our caller rather than to this instruction.
    let jmp_site = code.len();
    fixups.push(Fixup {
        native_offset: jmp_site,
        target_ent_pc: target_pc,
        kind: super::encode::BranchKind::Jmp,
    });
    super::encode::emit_jmp_rel32(code, 0);
    true
}
