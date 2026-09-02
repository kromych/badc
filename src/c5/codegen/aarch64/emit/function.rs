use super::*;

/// Branch placeholder recorded mid-walk; resolved once every
/// block's start offset is known.
#[derive(Debug, Clone, Copy)]
pub(super) struct BranchFixup {
    /// Byte offset in `code` of the placeholder instruction.
    pub(super) site: usize,
    /// Target block in the function's `blocks` table.
    pub(super) target: BlockId,
    pub(super) kind: LocalBranchKind,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(super) enum LocalBranchKind {
    /// Unconditional B; `imm26` field, +/-128 MiB reach.
    B,
    /// CBZ Xt, label.
    Cbz(Reg),
    /// CBNZ Xt, label.
    Cbnz(Reg),
    /// B.cond label.
    Bcc(Cond),
}

/// Public entry point. Returns `true` when every block + inst +
/// terminator was lowered. Returns `false` (and leaves `code`
/// unchanged) when the function contains an op outside the
/// implemented subset; the caller falls back or aborts per
/// policy.
///
/// `fixups` is the function-pointer / direct-call fixup table the
/// surrounding writer already maintains. The SSA emit appends one
/// `Fixup::Bl` per `Inst::Call`; the `apply_fixups` post-pass
/// resolves them once `pc_to_native` is final.
#[allow(clippy::too_many_arguments)]
pub(crate) fn emit_function(
    func: &FunctionSsa,
    alloc: &Allocation,
    target: Target,
    cx: &mut super::ssa::emit_common::EmitCtx,
    fixups: &mut Vec<Fixup>,
    extern_data_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    extern_tls_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    imports: &super::ResolvedImports,
    variadic_targets: &alloc::collections::BTreeSet<usize>,
    macho_tlv_fixups: &mut Vec<super::MachoTlvFixup>,
    macho_tlv_descriptors: &mut Vec<super::MachoTlvDescriptor>,
    name2entpc: &alloc::collections::BTreeMap<alloc::string::String, usize>,
    data_sym_offsets: &alloc::collections::BTreeMap<alloc::string::String, i64>,
    asm_text_labels: &mut Vec<super::AsmTextLabel>,
    asm_section_text_refs: &mut Vec<super::AsmSectionTextRef>,
    // The text stream's mapping state spans the section, not the function: a
    // body ending in data leaves the counter off the instruction boundary and
    // the next function's first instruction pays the padding, as under GNU as.
    text_map_state: &mut Option<super::super::map_syms::MapClass>,
    no_fp_regs: bool,
    strict_align: bool,
    rodata: &mut super::RodataBuild,
    abs_jump_tables: bool,
    hardening: super::Hardening,
    stack_protect: super::StackProtect,
    entry: super::FunctionEntry,
    fixed_regs: super::FixedRegs,
) -> bool {
    // The bundled emit output arrives in `cx`; recreate the per-field names as
    // disjoint reborrows so the body below (including the per-`Inst` `cx` it
    // rebuilds for `emit_inst`) is unchanged.
    let code = &mut *cx.code;
    let plt_call_fixups = &mut *cx.plt_call_fixups;
    let data_fixups = &mut *cx.data_fixups;
    let user_extern_data_refs = &mut *cx.user_extern_data_refs;
    let pending_func_fixups = &mut *cx.pending_func_fixups;
    let tls_index_fixups = &mut *cx.tls_index_fixups;
    let elf_tpoff_fixups = &mut *cx.elf_tpoff_fixups;
    let ssa_line_rows = &mut *cx.ssa_line_rows;
    let pc_to_native = &mut *cx.pc_to_native;
    let prologue_native = &mut *cx.prologue_native;
    let asm_sections = &mut *cx.asm_sections;
    let asm_extern_call_sites = &mut *cx.asm_extern_call_sites;
    let asm_sym_fixups = &mut *cx.asm_sym_fixups;
    let text_align = &mut *cx.text_align;
    let label_relocs = &mut *cx.label_relocs;
    let text_data_ranges = &mut *cx.text_data_ranges;
    let canary_frame_bytes = &mut *cx.canary_frame_bytes;
    let mcount_sites = &mut *cx.mcount_sites;
    let abi = {
        let mut a = target.abi();
        a.no_fp_varargs = no_fp_regs;
        a.strict_align = strict_align;
        a.hardening = hardening;
        a.stack_protect = stack_protect;
        a.fixed_regs = fixed_regs;
        a
    };
    if let Some(bytes) = super::ssa::emit_common::locals_bytes_over_limit(func) {
        bail_msg(&super::ssa::emit_common::frame_too_large_msg(bytes));
        return false;
    }
    let frame = compute_frame(func, alloc, abi, target);
    if let Some(why) = super::ssa::reg_alloc::fp_scratch_shortfall(func, frame.fp_scratch) {
        bail_msg(why);
        return false;
    }
    if frame.canary_bytes > 0 {
        canary_frame_bytes.insert(func.ent_pc, frame.canary_bytes);
    }
    if frame.frame_bytes > super::ssa::emit_common::MAX_FRAME_BYTES {
        bail_msg(&super::ssa::emit_common::frame_too_large_msg(
            frame.frame_bytes as i64,
        ));
        return false;
    }
    let scratch = ScratchPool::new();
    let snapshot = code.len();
    // Snapshot every fixup vector at function entry so a partial
    // emit can be rolled back cleanly. Without this, a bailed SSA
    // emit leaves queued fixups pointing into the truncated code
    // region and the caller's surrounding pass would patch later
    // code with the wrong offsets.
    let fixups_snapshot = fixups.len();
    let plt_call_fixups_snapshot = plt_call_fixups.len();
    let data_fixups_snapshot = data_fixups.len();
    let user_extern_data_refs_snapshot = user_extern_data_refs.len();
    let asm_extern_call_sites_snapshot = asm_extern_call_sites.len();
    let asm_sym_fixups_snapshot = asm_sym_fixups.len();
    // The section sink merges by name, so a rollback restores its full
    // per-section state rather than a length (see [`AsmSectionSink::restore`]).
    let asm_sections_snapshot = asm_sections.snapshot();
    let pending_func_fixups_snapshot = pending_func_fixups.len();
    let tls_index_fixups_snapshot = tls_index_fixups.len();
    let macho_tlv_fixups_snapshot = macho_tlv_fixups.len();
    let macho_tlv_descriptors_snapshot = macho_tlv_descriptors.len();
    let elf_tpoff_snapshot = elf_tpoff_fixups.len();

    let signs = signs_return_address(func, frame, alloc, abi);
    // A `__attribute__((naked))` function emits no prologue/epilogue; its
    // inline-asm body is the entire function (an interrupt vector or ISR
    // returning via `eret`). The matching `Terminator::Return` emits nothing.
    if !func.is_naked {
        // The entry is this function's first instruction, so it pays any
        // realignment a preceding body left owing. The symbol keeps the
        // offset it was placed at, as a label does under GNU as.
        a64_align_asm_stream(code, text_data_ranges, text_map_state);
        // Branch protection: a function entry is reachable by `BLR` and
        // by a `BR` through x16/x17 (a PLT trampoline's), so it takes a
        // `BTI C` ahead of the prologue. A naked function is excluded --
        // its body is the whole function, and prefixing an instruction
        // would displace a hand-built entry sequence. `PACIASP` accepts
        // both of those BTYPEs itself, so it stands in for the pad only
        // where it is the entry's first instruction.
        if abi.hardening.bti && (entry.nops_after > 0 || !signs) {
            emit(code, super::encode::BTI_C);
        }
    }
    // The `-fpatchable-function-entry` NOPs follow the landing pad and
    // precede the rest of the entry, as gcc orders them: a tracer
    // rewrites the area's first two words to `mov x9, x30` and a call,
    // which run before the return address is signed.
    for _ in 0..entry.nops_after {
        emit(code, super::encode::NOP);
    }
    if !func.is_naked {
        if signs {
            emit(code, super::encode::PACIASP);
        }
        emit_prologue(code, func, alloc, frame, abi, user_extern_data_refs);
    }
    super::ssa::emit_common::record_post_prologue_pc(func, prologue_native, code.len());

    // Per-parameter incoming-register plan; consumed by the per-inst
    // `Inst::ParamRef` lowering to source each parameter from its
    // integer / FP argument register.
    let emit_param_plan = param_placements(func, abi);

    // Place the entry `Inst::ParamRef` values from their AAPCS64
    // argument registers into the allocator's chosen locations. The
    // per-inst `mov dst, arg_reg` is unsound when one parameter's
    // destination register is a later parameter's source argument
    // register: the move clobbers that source before it is read. The
    // placement is a parallel copy from the (distinct) argument
    // registers to the parameter homes exactly when those homes are
    // distinct -- then `schedule_place_moves` sequentializes it and
    // breaks any cycle through a scratch register. When two ParamRef
    // values share a home (sequentially-live parameters the allocator
    // packed into one register) the move set is not a permutation, so
    // the batch is skipped and each ParamRef is placed in program order.
    // That per-inst path is safe only while no parameter's home is a
    // later parameter's incoming register; the allocator's ParamRef
    // self-home hint keeps it so (each integer parameter prefers its own
    // incoming register, and those are distinct). The
    // `param-shuffle-clobber` check in `verify_allocation` guards the
    // invariant under the `codegen_test` feature.
    let mut param_prebatched: Vec<bool> = alloc::vec![false; func.insts.len()];
    {
        // Each integer parameter's incoming register comes from the
        // plan, not `int_arg_regs[i]`: an FP parameter earlier in the
        // list consumes a d-register and does not shift the integer
        // bank, so the i-th declared parameter is not the i-th integer
        // register.
        let param_plan = param_placements(func, abi);
        let mut moves: Vec<(Place, Place)> = Vec::new();
        let mut exts: Vec<(Place, LoadKind)> = Vec::new();
        let mut vids: Vec<usize> = Vec::new();
        let mut homes: Vec<Place> = Vec::new();
        for (vid, inst) in func.insts.iter().enumerate() {
            let Inst::ParamRef { idx, kind } = inst else {
                continue;
            };
            let i = *idx as usize;
            // A ParamRef with no consumers is dropped by the per-inst
            // dead-code skip; placing it here would only risk bailing
            // the batch on an unused FP parameter. Only integer / spill
            // homes are scheduled as a parallel copy; an FP-register
            // home (a floating-point parameter) stays on the per-inst
            // path.
            if super::ssa::emit_common::is_dead_pure(inst, vid as super::super::ir::ValueId, alloc)
            {
                continue;
            }
            let dst = alloc.places.get(vid).copied().unwrap_or(Place::None);
            if !matches!(dst, Place::IntReg(_) | Place::Spill(_)) {
                continue;
            }
            // An integer-dst ParamRef is always an integer parameter;
            // read its source integer register from the plan. A
            // stack-passed integer parameter has no register source and
            // stays on the per-inst home-cell path.
            let Some(super::ArgPlacement::IntReg(src)) = param_plan.get(i).copied() else {
                continue;
            };
            moves.push((Place::IntReg(src), dst));
            vids.push(vid);
            homes.push(dst);
            // The caller passes the raw 64-bit value; the callee
            // performs the C99 6.5.2.2p4 conversion. An I8/I16 extend
            // rewrites bits 8..63 / 16..63 and is always required; an
            // I32 extend touches only bits 32..63 and is skipped when
            // no consumer reads them (`high_observed` tracks exactly
            // that range).
            if matches!(kind, LoadKind::I8 | LoadKind::I16)
                || (matches!(kind, LoadKind::I32)
                    && alloc.high_observed.get(vid).copied().unwrap_or(true))
            {
                exts.push((dst, *kind));
            }
        }
        let homes_distinct = (0..homes.len())
            .all(|a| ((a + 1)..homes.len()).all(|b| !place_same_loc(homes[a], homes[b])));
        if !moves.is_empty() && homes_distinct {
            if !schedule_place_moves(code, &mut moves, frame, scratch.primary, scratch.secondary) {
                return false;
            }
            for (dst, kind) in exts {
                let ext = |code: &mut Vec<u8>, r: Reg| match kind {
                    LoadKind::I8 => emit(code, super::encode::enc_sxtb(r, r)),
                    LoadKind::I16 => emit(code, super::encode::enc_sxth(r, r)),
                    LoadKind::I32 => emit(code, super::encode::enc_sxtw(r, r)),
                    _ => {}
                };
                match dst {
                    Place::IntReg(r) => ext(code, Reg(r)),
                    Place::Spill(slot) => {
                        let sp_off = spill_off(frame, slot);
                        emit_spill_ldr_x(code, frame, scratch.primary, sp_off);
                        ext(code, scratch.primary);
                        emit_spill_str_x(code, frame, scratch.primary, sp_off, scratch.secondary);
                    }
                    Place::None | Place::FpReg(_) => {}
                }
            }
            for vid in vids {
                param_prebatched[vid] = true;
            }
        }
    }

    // Floating-point parameters: the same parallel-copy hazard applies in
    // the FP bank when one parameter's home d-register is a later
    // parameter's incoming argument register -- the per-inst `fmov dst,
    // arg` then clobbers that source before it is read. Schedule the FP
    // parameters as an FP parallel copy with the FP scratch breaking cycles
    // (mirroring the integer batch); the per-inst path handles any not
    // placed here (stack-passed, dead, or a non-permutation home set).
    {
        let param_plan = param_placements(func, abi);
        let mut fp_moves: Vec<(Place, Place)> = Vec::new();
        let mut fp_vids: Vec<usize> = Vec::new();
        let mut fp_homes: Vec<Place> = Vec::new();
        for (vid, inst) in func.insts.iter().enumerate() {
            let Inst::ParamRef { idx, kind } = inst else {
                continue;
            };
            if !matches!(kind, LoadKind::F32 | LoadKind::F64) {
                continue;
            }
            if super::ssa::emit_common::is_dead_pure(inst, vid as super::super::ir::ValueId, alloc)
            {
                continue;
            }
            let dst = alloc.places.get(vid).copied().unwrap_or(Place::None);
            if !matches!(dst, Place::FpReg(_) | Place::Spill(_)) {
                continue;
            }
            let i = *idx as usize;
            let Some(super::ArgPlacement::FpReg(src)) = param_plan.get(i).copied() else {
                continue;
            };
            fp_moves.push((Place::FpReg(src), dst));
            fp_vids.push(vid);
            fp_homes.push(dst);
        }
        let homes_distinct = (0..fp_homes.len())
            .all(|a| ((a + 1)..fp_homes.len()).all(|b| !place_same_loc(fp_homes[a], fp_homes[b])));
        if !fp_moves.is_empty() && homes_distinct {
            super::ssa::emit_common::schedule_fp_place_moves(
                &super::ssa::emit_common::Aarch64Backend,
                code,
                &mut fp_moves,
                frame,
                17,
                16,
            );
            for vid in fp_vids {
                param_prebatched[vid] = true;
            }
        }
    }

    let mut block_offsets: Vec<usize> = alloc::vec![0; func.blocks.len()];
    let mut branch_fixups: Vec<BranchFixup> = Vec::new();
    // Template `%lK` branches that reach their label's block with no operand
    // frame in the way; encoded against `block_offsets` once it is final.
    let mut direct_goto_branches: Vec<AsmGotoDirectBranch> = Vec::new();
    // GCC `&&label`: each `Inst::BlockAddr` emits an `ADR rd, .`
    // placeholder; `(site, target_block, rd)` is resolved against the
    // final `block_offsets` once every block has been laid out.
    let mut block_addr_fixups: Vec<(usize, BlockId, Reg)> = Vec::new();
    // Text-embedded jump tables: `(table_start, table_idx)` per
    // `Terminator::JumpTable`. Each 32-bit entry is patched to
    // `block_offset - table_start` once every block is laid out.
    let mut jump_table_fixups: Vec<(usize, u32)> = Vec::new();
    // ALTERNATIVE `.subsection` replacements, appended after the body once it
    // is laid out; the section relocs that point at their labels are then
    // rewritten to the region's final text offset. A bailed emit returns
    // false and drops this, so no snapshot is needed.
    let mut deferred_regions: Vec<DeferredAsmRegion> = Vec::new();
    // Blocks a `BR` can reach: switch-table successors and the blocks
    // whose address `&&label` took. Each needs a `BTI J` landing pad at
    // its head, recorded before the block loop so the pad lands at the
    // offset every branch fixup resolves to.
    let bti_targets = if abi.hardening.bti {
        super::super::indirect_branch_target_blocks(func)
    } else {
        alloc::collections::BTreeSet::new()
    };
    for (block_idx, block) in func.blocks.iter().enumerate() {
        // The landing pad is the block's first byte, so a realignment due
        // ahead of it comes before the offset every branch resolves to.
        let bti = bti_targets.contains(&(block_idx as BlockId));
        if bti {
            a64_align_asm_stream(code, text_data_ranges, text_map_state);
        }
        block_offsets[block_idx] = code.len();
        super::ssa::emit_common::record_block_start_pc(
            block_idx,
            block.start_pc,
            pc_to_native,
            code.len(),
        );
        if bti {
            emit(code, super::encode::BTI_J);
        }
        for v in block.inst_range.clone() {
            let inst = &func.insts[v as usize];
            let place = alloc.places.get(v as usize).copied().unwrap_or(Place::None);
            // A naked function's machine code is exactly its inline asm; the
            // compiler-inserted alloca/return-value scaffolding is dropped.
            if func.is_naked && !matches!(inst, Inst::InlineAsm { .. }) {
                continue;
            }
            // Skip pure insts whose value isn't consumed by any
            // other inst or terminator. Walker-side pattern folds
            // (LoadLocal, indexed-load) sometimes leave the
            // upstream `Add` / `BinopI` dead; the result
            // computation produces no machine code if no one
            // will read it.
            if super::ssa::emit_common::is_dead_pure(inst, v, alloc) {
                continue;
            }
            // ParamRef already placed by the entry parallel copy.
            if param_prebatched[v as usize] {
                continue;
            }
            // An inline-asm block takes the mapping state itself.
            if !matches!(inst, Inst::InlineAsm { .. }) {
                a64_align_asm_stream(code, text_data_ranges, text_map_state);
            }
            super::ssa::emit_common::record_inst_src(func, v, code.len(), ssa_line_rows);
            // GCC `&&label`: materialize the block's address with a
            // PC-relative ADR. Handled here (not emit_inst) because the
            // fixup resolves against this function's local block_offsets
            // once every block is laid out -- walker IR leaves
            // block.start_pc at 0, so the pc_to_native path can't be used.
            if let Inst::BlockAddr(tb) = inst {
                let rd = match int_or_spill_scratch(place, &scratch) {
                    Some(r) => r,
                    None => {
                        bail("BlockAddr: dst not int reg / spill", v, place);
                        code.truncate(snapshot);
                        fixups.truncate(fixups_snapshot);
                        plt_call_fixups.truncate(plt_call_fixups_snapshot);
                        data_fixups.truncate(data_fixups_snapshot);
                        user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                        asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
                        asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
                        asm_sections.restore(&asm_sections_snapshot);
                        pending_func_fixups.truncate(pending_func_fixups_snapshot);
                        tls_index_fixups.truncate(tls_index_fixups_snapshot);
                        elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                        macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                        macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                        return false;
                    }
                };
                let adr_site = code.len();
                emit(code, enc_adr(rd, 0));
                block_addr_fixups.push((adr_site, *tb, rd));
                if let Place::Spill(slot) = place {
                    let sp_off = spill_off(frame, slot);
                    emit_spill_str_x_auto(code, frame, rd, sp_off);
                }
                continue;
            }
            // `asm goto`: the label branches patch against block
            // offsets via the enclosing `branch_fixups`, which
            // `emit_inst` has no access to; lower it here (same
            // pattern as `Inst::BlockAddr` above).
            if let Inst::InlineAsm { asm, args } = inst
                && let Terminator::AsmGoto { table } = block.terminator
            {
                if !emit_inline_asm_aarch64(
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
                    asm_sections,
                    asm_extern_call_sites,
                    asm_sym_fixups,
                    &mut deferred_regions,
                    text_data_ranges,
                    text_align,
                    text_map_state,
                    asm_text_labels,
                    asm_section_text_refs,
                    Some(AsmGotoCtxA64 {
                        row: &func.jump_tables[table as usize],
                        branch_fixups: &mut branch_fixups,
                        direct_goto: &mut direct_goto_branches,
                    }),
                ) {
                    code.truncate(snapshot);
                    fixups.truncate(fixups_snapshot);
                    plt_call_fixups.truncate(plt_call_fixups_snapshot);
                    data_fixups.truncate(data_fixups_snapshot);
                    user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                    asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
                    asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
                    asm_sections.restore(&asm_sections_snapshot);
                    pending_func_fixups.truncate(pending_func_fixups_snapshot);
                    tls_index_fixups.truncate(tls_index_fixups_snapshot);
                    elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                    macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                    macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                    return false;
                }
                continue;
            }
            let data_fixups_pre_inst = data_fixups.len();
            let inst_ok = {
                let mut cx = super::ssa::emit_common::EmitCtx {
                    code: &mut *code,
                    plt_call_fixups: &mut *plt_call_fixups,
                    data_fixups: &mut *data_fixups,
                    user_extern_data_refs: &mut *user_extern_data_refs,
                    pending_func_fixups: &mut *pending_func_fixups,
                    tls_index_fixups: &mut *tls_index_fixups,
                    elf_tpoff_fixups: &mut *elf_tpoff_fixups,
                    ssa_line_rows: &mut *ssa_line_rows,
                    pc_to_native: &mut *pc_to_native,
                    prologue_native: &mut *prologue_native,
                    asm_sections: &mut *asm_sections,
                    asm_extern_call_sites: &mut *asm_extern_call_sites,
                    asm_sym_fixups: &mut *asm_sym_fixups,
                    text_align: &mut *text_align,
                    label_relocs: &mut *label_relocs,
                    text_data_ranges: &mut *text_data_ranges,
                    canary_frame_bytes: &mut *canary_frame_bytes,
                    mcount_sites: &mut *mcount_sites,
                };
                let fcx = FnCtx {
                    func,
                    alloc,
                    frame,
                    scratch: &scratch,
                    abi,
                    target,
                    imports,
                    variadic_targets,
                    extern_tls_names,
                    extern_data_names,
                    param_plan: &emit_param_plan,
                    name2entpc,
                    data_sym_offsets,
                };
                emit_inst(
                    &mut cx,
                    inst,
                    v,
                    place,
                    &fcx,
                    fixups,
                    macho_tlv_fixups,
                    macho_tlv_descriptors,
                    &mut deferred_regions,
                    text_map_state,
                    asm_text_labels,
                    asm_section_text_refs,
                )
            };
            if !inst_ok {
                #[cfg(feature = "codegen_test")]
                if std::env::var("BADC_DUMP_SSA").is_ok() {
                    eprintln!(
                        "ssa emit: bailed on inst v{v}: {:?} (place {:?})",
                        inst, place,
                    );
                }
                code.truncate(snapshot);
                fixups.truncate(fixups_snapshot);
                plt_call_fixups.truncate(plt_call_fixups_snapshot);
                data_fixups.truncate(data_fixups_snapshot);
                user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
                asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
                asm_sections.restore(&asm_sections_snapshot);
                pending_func_fixups.truncate(pending_func_fixups_snapshot);
                tls_index_fixups.truncate(tls_index_fixups_snapshot);
                elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                return false;
            }
            // Convert the just-emitted ImmData's local `.data`
            // fixup into a named cross-TU reference when the
            // value-id appears in `extern_data_names`. The walker
            // emits `Inst::ImmData(0)` for every
            // `imm_data_extern`; this hop replaces the unit-local
            // `DataFixup` (which would lower to `.data section
            // symbol + 0`) with a `UserExternDataRef` carrying
            // the symbol name, so the ET_REL writer emits a
            // named undefined-data symbol + a reloc against it.
            if let Inst::ImmData(_) = inst
                && let Some(name) = extern_data_names.get(&v)
                && data_fixups.len() > data_fixups_pre_inst
            {
                let popped = data_fixups.pop().unwrap();
                user_extern_data_refs.push(super::UserExternDataRef {
                    instr_offset: popped.instr_offset,
                    symbol_name: name.clone(),
                    direct_pcrel: None,
                });
            }
        }
        // The phi moves and the terminator below are instructions, except
        // for a naked function's synthetic return, which emits nothing.
        if !(func.is_naked && matches!(block.terminator, Terminator::Return(_))) {
            a64_align_asm_stream(code, text_data_ranges, text_map_state);
        }
        // Predecessor-exit moves for any phi at every CFG
        // successor's head. A Return / TailExt block has no
        // successor; the helper is a no-op there.
        if !emit_phi_predecessor_moves(
            code,
            block_idx as super::super::ir::BlockId,
            func,
            alloc,
            &scratch,
            frame,
        ) {
            code.truncate(snapshot);
            fixups.truncate(fixups_snapshot);
            plt_call_fixups.truncate(plt_call_fixups_snapshot);
            data_fixups.truncate(data_fixups_snapshot);
            user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
            asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
            asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
            asm_sections.restore(&asm_sections_snapshot);
            pending_func_fixups.truncate(pending_func_fixups_snapshot);
            tls_index_fixups.truncate(tls_index_fixups_snapshot);
            elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
            macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
            macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
            return false;
        }
        match block.terminator {
            // A naked function's inline-asm body provides its own return (eret);
            // emit no epilogue for the synthetic return.
            Terminator::Return(_) if func.is_naked => {}
            Terminator::Return(v) => emit_return(
                code,
                v,
                alloc,
                frame,
                &scratch,
                func,
                abi,
                asm_extern_call_sites,
                user_extern_data_refs,
            ),
            Terminator::Jmp(t) => {
                // Fall through when the target is the next block in
                // layout rather than emitting a branch to it.
                if t as usize != block_idx + 1 {
                    branch_fixups.push(BranchFixup {
                        site: code.len(),
                        target: t,
                        kind: LocalBranchKind::B,
                    });
                    emit(code, enc_b(0));
                }
            }
            Terminator::Bz {
                cond,
                target,
                fall_through,
            } => {
                if let Some(bcc) = fused_branch_cond(func, alloc, cond, /* negate */ true) {
                    branch_fixups.push(BranchFixup {
                        site: code.len(),
                        target,
                        kind: LocalBranchKind::Bcc(bcc),
                    });
                    emit(code, enc_b_cond(bcc, 0));
                    if fall_through as usize != block_idx + 1 {
                        branch_fixups.push(BranchFixup {
                            site: code.len(),
                            target: fall_through,
                            kind: LocalBranchKind::B,
                        });
                        emit(code, enc_b(0));
                    }
                    continue;
                }
                let cond_place = alloc
                    .places
                    .get(cond as usize)
                    .copied()
                    .unwrap_or(Place::None);
                // The c5 conditional-branch ops treat the
                // accumulator as a 64-bit bit pattern: zero
                // branches Bz, anything else branches Bnz. An
                // FpReg-placed cond carries an f64 in d-reg
                // form; bridge it through `fmov x, d` so the
                // CBZ/CBNZ has an integer to compare on the
                // raw bit pattern.
                let rt = if let Place::FpReg(dr) = cond_place {
                    emit(code, enc_fmov_d_to_x(scratch.primary, dr));
                    scratch.primary
                } else {
                    match materialize_int(code, cond_place, scratch.primary, frame) {
                        Some(r) => r,
                        None => {
                            bail("Bz/Bnz: cond Place not int", cond, cond_place);
                            code.truncate(snapshot);
                            fixups.truncate(fixups_snapshot);
                            plt_call_fixups.truncate(plt_call_fixups_snapshot);
                            data_fixups.truncate(data_fixups_snapshot);
                            user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                            asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
                            asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
                            asm_sections.restore(&asm_sections_snapshot);
                            pending_func_fixups.truncate(pending_func_fixups_snapshot);
                            tls_index_fixups.truncate(tls_index_fixups_snapshot);
                            elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                            macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                            macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                            return false;
                        }
                    }
                };
                branch_fixups.push(BranchFixup {
                    site: code.len(),
                    target,
                    kind: LocalBranchKind::Cbz(rt),
                });
                emit(code, enc_cbz(rt, 0));
                if fall_through as usize != block_idx + 1 {
                    branch_fixups.push(BranchFixup {
                        site: code.len(),
                        target: fall_through,
                        kind: LocalBranchKind::B,
                    });
                    emit(code, enc_b(0));
                }
            }
            Terminator::Bnz {
                cond,
                target,
                fall_through,
            } => {
                if let Some(bcc) = fused_branch_cond(func, alloc, cond, /* negate */ false) {
                    branch_fixups.push(BranchFixup {
                        site: code.len(),
                        target,
                        kind: LocalBranchKind::Bcc(bcc),
                    });
                    emit(code, enc_b_cond(bcc, 0));
                    if fall_through as usize != block_idx + 1 {
                        branch_fixups.push(BranchFixup {
                            site: code.len(),
                            target: fall_through,
                            kind: LocalBranchKind::B,
                        });
                        emit(code, enc_b(0));
                    }
                    continue;
                }
                let cond_place = alloc
                    .places
                    .get(cond as usize)
                    .copied()
                    .unwrap_or(Place::None);
                // The c5 conditional-branch ops treat the
                // accumulator as a 64-bit bit pattern: zero
                // branches Bz, anything else branches Bnz. An
                // FpReg-placed cond carries an f64 in d-reg
                // form; bridge it through `fmov x, d` so the
                // CBZ/CBNZ has an integer to compare on the
                // raw bit pattern.
                let rt = if let Place::FpReg(dr) = cond_place {
                    emit(code, enc_fmov_d_to_x(scratch.primary, dr));
                    scratch.primary
                } else {
                    match materialize_int(code, cond_place, scratch.primary, frame) {
                        Some(r) => r,
                        None => {
                            bail("Bz/Bnz: cond Place not int", cond, cond_place);
                            code.truncate(snapshot);
                            fixups.truncate(fixups_snapshot);
                            plt_call_fixups.truncate(plt_call_fixups_snapshot);
                            data_fixups.truncate(data_fixups_snapshot);
                            user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                            asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
                            asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
                            asm_sections.restore(&asm_sections_snapshot);
                            pending_func_fixups.truncate(pending_func_fixups_snapshot);
                            tls_index_fixups.truncate(tls_index_fixups_snapshot);
                            elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                            macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                            macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                            return false;
                        }
                    }
                };
                branch_fixups.push(BranchFixup {
                    site: code.len(),
                    target,
                    kind: LocalBranchKind::Cbnz(rt),
                });
                emit(code, enc_cbnz(rt, 0));
                if fall_through as usize != block_idx + 1 {
                    branch_fixups.push(BranchFixup {
                        site: code.len(),
                        target: fall_through,
                        kind: LocalBranchKind::B,
                    });
                    emit(code, enc_b(0));
                }
            }
            Terminator::FallThrough(t) => {
                if t as usize != block_idx + 1 {
                    branch_fixups.push(BranchFixup {
                        site: code.len(),
                        target: t,
                        kind: LocalBranchKind::B,
                    });
                    emit(code, enc_b(0));
                }
            }
            Terminator::GotoIndirect { target } => {
                // GCC computed goto: branch to the code address in
                // `target` (materialized by Inst::BlockAddr). Move it
                // into a register and `br`.
                let tplace = alloc
                    .places
                    .get(target as usize)
                    .copied()
                    .unwrap_or(Place::None);
                let rt = match materialize_int(code, tplace, scratch.primary, frame) {
                    Some(r) => r,
                    None => {
                        bail("GotoIndirect: target Place not int", target, tplace);
                        code.truncate(snapshot);
                        fixups.truncate(fixups_snapshot);
                        plt_call_fixups.truncate(plt_call_fixups_snapshot);
                        data_fixups.truncate(data_fixups_snapshot);
                        user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                        asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
                        asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
                        asm_sections.restore(&asm_sections_snapshot);
                        pending_func_fixups.truncate(pending_func_fixups_snapshot);
                        tls_index_fixups.truncate(tls_index_fixups_snapshot);
                        elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                        macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                        macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                        return false;
                    }
                };
                emit(code, enc_br(rt));
            }
            Terminator::JumpTable { idx, table } => {
                // Table dispatch through the read-only blob (kept out
                // of the code section so it never decodes as
                // instructions). The bounds check preceding this
                // terminator proves the index in range. Image output
                // reads a 32-bit table-relative entry and adds the
                // base back (no load-time relocation); relocatable
                // output loads an 8-byte absolute entry, the form
                // whose relocations name the targets directly.
                let iplace = alloc
                    .places
                    .get(idx as usize)
                    .copied()
                    .unwrap_or(Place::None);
                let rt = match materialize_int(code, iplace, scratch.primary, frame) {
                    Some(r) => r,
                    None => {
                        bail("JumpTable: idx Place not int", idx, iplace);
                        code.truncate(snapshot);
                        fixups.truncate(fixups_snapshot);
                        plt_call_fixups.truncate(plt_call_fixups_snapshot);
                        data_fixups.truncate(data_fixups_snapshot);
                        user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                        asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
                        asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
                        asm_sections.restore(&asm_sections_snapshot);
                        pending_func_fixups.truncate(pending_func_fixups_snapshot);
                        tls_index_fixups.truncate(tls_index_fixups_snapshot);
                        elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                        macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                        macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                        return false;
                    }
                };
                // rt is an allocated register or scratch.primary, never
                // scratch.secondary, so the table base cannot alias it.
                // The adrp+add pair reaches into the read-only blob, so
                // the writer patches it (RodataAddrFixup).
                let tbl = scratch.secondary;
                let addr_site = code.len();
                emit(code, enc_adrp(tbl, 0));
                emit(code, enc_add_imm(tbl, tbl, 0));
                if abs_jump_tables {
                    emit(code, enc_ldr_reg_lsl3(tbl, tbl, rt));
                } else {
                    emit(code, enc_ldrsw_reg_lsl2(scratch.primary, tbl, rt));
                    emit(code, enc_add_reg(tbl, tbl, scratch.primary));
                }
                emit(code, enc_br(tbl));
                jump_table_fixups.push((addr_site, table));
            }
            Terminator::AsmGoto { table } => {
                // The label branches were lowered inside the
                // `Inst::InlineAsm`; only the fall-through edge (row
                // entry 0) is emitted here.
                let fall = func.jump_tables[table as usize][0];
                if fall as usize != block_idx + 1 {
                    branch_fixups.push(BranchFixup {
                        site: code.len(),
                        target: fall,
                        kind: LocalBranchKind::B,
                    });
                    emit(code, enc_b(0));
                }
            }
            Terminator::TailExt(binding_idx) => {
                // Tail-jump through the GOT-patched trampoline:
                // `adrp x16, _ ; ldr x16, [x16, _] ; br x16`.
                // The writer fills the adrp / ldr immediates once
                // the trampoline target's RVA is final.
                let import_index = match imports.index_of_binding(binding_idx) {
                    Some(i) => i,
                    None => {
                        bail_msg("TailExt: no import slot for binding");
                        code.truncate(snapshot);
                        fixups.truncate(fixups_snapshot);
                        plt_call_fixups.truncate(plt_call_fixups_snapshot);
                        data_fixups.truncate(data_fixups_snapshot);
                        user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                        asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
                        asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
                        asm_sections.restore(&asm_sections_snapshot);
                        pending_func_fixups.truncate(pending_func_fixups_snapshot);
                        tls_index_fixups.truncate(tls_index_fixups_snapshot);
                        elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                        macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                        macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                        return false;
                    }
                };
                super::encode::emit_got_tail_jump(code, plt_call_fixups, import_index);
            }
            // Sealed after a noreturn call (C11 6.7.4p8): control cannot
            // reach here. Emit a trap so a mis-marked returning call
            // faults rather than falling into the next block.
            Terminator::Unreachable => emit(code, 0xD420_0020), // brk #1
        }
    }
    // Patch each `&&label` ADR against its block's final offset.
    for (site, target_block, rd) in &block_addr_fixups {
        let target_off = block_offsets[*target_block as usize] as i64;
        let rel = target_off - *site as i64;
        // ADR has a signed 21-bit byte immediate (+/-1 MiB).
        if !(-(1 << 20)..(1 << 20)).contains(&rel) {
            bail_msg("BlockAddr: ADR target out of +/-1MiB range");
            code.truncate(snapshot);
            fixups.truncate(fixups_snapshot);
            plt_call_fixups.truncate(plt_call_fixups_snapshot);
            data_fixups.truncate(data_fixups_snapshot);
            user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
            asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
            asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
            asm_sections.restore(&asm_sections_snapshot);
            pending_func_fixups.truncate(pending_func_fixups_snapshot);
            tls_index_fixups.truncate(tls_index_fixups_snapshot);
            elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
            macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
            macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
            return false;
        }
        let word = enc_adr(*rd, rel as i32);
        code[*site..*site + 4].copy_from_slice(&word.to_le_bytes());
    }
    // Static-initializer slots holding one of this function's label
    // addresses: record the block's now-final text offset for the
    // object writers to relocate against.
    for r in &func.label_data_relocs {
        label_relocs.push(super::LabelReloc {
            data_offset: r.data_offset,
            text_offset: block_offsets[r.block as usize] as u64,
        });
    }
    // Rewrite `asm goto` section fields (`.long %l0 - .`) to the label
    // block's now-final text offset. Scoped to this function's contribution
    // via the entry snapshot; only this pass's relocs survived the loop.
    crate::c5::asm::resolve_asm_goto_relocs(
        asm_sections.relocs_mut(),
        &asm_sections_snapshot,
        &|bid| block_offsets[bid as usize],
    );
    // Append each ALTERNATIVE replacement after the function body, out of the
    // main sequence's fall-through path (GNU as puts it at the end of the
    // section), and rewrite the `.altinstructions` fields that point at its
    // labels to the region's final text offset.
    let mut deferred_bases: Vec<usize> = Vec::with_capacity(deferred_regions.len());
    if !deferred_regions.is_empty() {
        a64_align_asm_stream(code, text_data_ranges, text_map_state);
    }
    for region in &deferred_regions {
        let base = code.len();
        deferred_bases.push(base);
        code.extend_from_slice(&region.bytes);
        text_data_ranges.extend(region.data_ranges.iter().map(|&(o, n)| (base + o, n)));
        // A replacement branch to a symbol becomes a call fixup (same unit) or
        // a relocation (link-time), as a main-stream one does.
        for sb in &region.sym_branches {
            let native_offset = base + sb.region_off;
            match name2entpc.get(sb.name.as_str()) {
                Some(&ent_pc) => fixups.push(Fixup {
                    native_offset,
                    target_ent_pc: ent_pc,
                    kind: if sb.is_call {
                        BranchKind::Bl
                    } else {
                        BranchKind::B
                    },
                }),
                None => asm_extern_call_sites.push(super::UserExternCallSite {
                    instr_offset: native_offset,
                    symbol_name: sb.name.clone(),
                    is_tail: !sb.is_call,
                }),
            }
        }
    }
    crate::c5::asm::resolve_asm_deferred_relocs(
        asm_sections.relocs_mut(),
        &asm_sections_snapshot,
        &|idx| deferred_bases[idx as usize],
    );
    // Resolve replacement `%l[...]` asm-goto branches that leave an out-of-line
    // region: encode each against its target's final offset, now that both the
    // region base and the block layout are known.
    for (idx, region) in deferred_regions.iter().enumerate() {
        let base = deferred_bases[idx];
        for gb in &region.goto_branches {
            let target = match gb.target {
                DeferredGotoTarget::Code(off) => off,
                DeferredGotoTarget::Block(b) => block_offsets[b as usize],
            };
            let site = base + gb.region_off;
            let delta = target as i64 - site as i64;
            let word = match gb.kind {
                LabelBranch::Adr { rd } if (-(1 << 20)..(1 << 20)).contains(&delta) => {
                    Ok(enc_adr(Reg(rd), delta as i32))
                }
                LabelBranch::Adr { .. } => Err(()),
                ref kind => label_branch_word(kind, delta).map_err(|_| ()),
            };
            match word {
                Ok(w) => code[site..site + 4].copy_from_slice(&w.to_le_bytes()),
                Err(()) => {
                    bail_msg("aarch64 inline asm: replacement goto branch target out of range");
                    code.truncate(snapshot);
                    fixups.truncate(fixups_snapshot);
                    plt_call_fixups.truncate(plt_call_fixups_snapshot);
                    data_fixups.truncate(data_fixups_snapshot);
                    user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                    asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
                    asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
                    asm_sections.restore(&asm_sections_snapshot);
                    pending_func_fixups.truncate(pending_func_fixups_snapshot);
                    tls_index_fixups.truncate(tls_index_fixups_snapshot);
                    elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                    macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                    macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                    return false;
                }
            }
        }
    }
    // Encode each template `%l[...]` branch that reaches its label's block
    // with no operand frame in the way, now that the layout is final.
    for gb in &direct_goto_branches {
        let delta = block_offsets[gb.target as usize] as i64 - gb.site as i64;
        match label_branch_word(&gb.kind, delta) {
            Ok(w) => code[gb.site..gb.site + 4].copy_from_slice(&w.to_le_bytes()),
            Err(m) => {
                bail_msg(&m);
                code.truncate(snapshot);
                fixups.truncate(fixups_snapshot);
                plt_call_fixups.truncate(plt_call_fixups_snapshot);
                data_fixups.truncate(data_fixups_snapshot);
                user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
                asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
                asm_sections.restore(&asm_sections_snapshot);
                pending_func_fixups.truncate(pending_func_fixups_snapshot);
                tls_index_fixups.truncate(tls_index_fixups_snapshot);
                elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                return false;
            }
        }
    }
    // Patch the recorded branches.
    for fx in &branch_fixups {
        let target_off = block_offsets[fx.target as usize];
        let rel = (target_off as i64) - (fx.site as i64);
        if rel % 4 != 0 {
            bail_msg("branch fixup: rel not 4-aligned");
            code.truncate(snapshot);
            fixups.truncate(fixups_snapshot);
            plt_call_fixups.truncate(plt_call_fixups_snapshot);
            data_fixups.truncate(data_fixups_snapshot);
            user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
            asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
            asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
            asm_sections.restore(&asm_sections_snapshot);
            pending_func_fixups.truncate(pending_func_fixups_snapshot);
            tls_index_fixups.truncate(tls_index_fixups_snapshot);
            elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
            macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
            macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
            return false;
        }
        let imm = (rel / 4) as i32;
        let word = match fx.kind {
            LocalBranchKind::B => {
                if !(-(1 << 25)..(1 << 25)).contains(&imm) {
                    code.truncate(snapshot);
                    fixups.truncate(fixups_snapshot);
                    plt_call_fixups.truncate(plt_call_fixups_snapshot);
                    data_fixups.truncate(data_fixups_snapshot);
                    user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                    asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
                    asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
                    asm_sections.restore(&asm_sections_snapshot);
                    pending_func_fixups.truncate(pending_func_fixups_snapshot);
                    tls_index_fixups.truncate(tls_index_fixups_snapshot);
                    elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                    macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                    macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                    return false;
                }
                enc_b(imm)
            }
            LocalBranchKind::Cbz(rt) => {
                if !(-(1 << 18)..(1 << 18)).contains(&imm) {
                    bail_msg("branch fixup: imm19 out of range");
                    code.truncate(snapshot);
                    fixups.truncate(fixups_snapshot);
                    plt_call_fixups.truncate(plt_call_fixups_snapshot);
                    data_fixups.truncate(data_fixups_snapshot);
                    user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                    asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
                    asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
                    asm_sections.restore(&asm_sections_snapshot);
                    pending_func_fixups.truncate(pending_func_fixups_snapshot);
                    tls_index_fixups.truncate(tls_index_fixups_snapshot);
                    elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                    macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                    macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                    return false;
                }
                enc_cbz(rt, imm)
            }
            LocalBranchKind::Cbnz(rt) => {
                if !(-(1 << 18)..(1 << 18)).contains(&imm) {
                    bail_msg("branch fixup: imm19 out of range");
                    code.truncate(snapshot);
                    fixups.truncate(fixups_snapshot);
                    plt_call_fixups.truncate(plt_call_fixups_snapshot);
                    data_fixups.truncate(data_fixups_snapshot);
                    user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                    asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
                    asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
                    asm_sections.restore(&asm_sections_snapshot);
                    pending_func_fixups.truncate(pending_func_fixups_snapshot);
                    tls_index_fixups.truncate(tls_index_fixups_snapshot);
                    elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                    macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                    macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                    return false;
                }
                enc_cbnz(rt, imm)
            }
            LocalBranchKind::Bcc(cond) => {
                if !(-(1 << 18)..(1 << 18)).contains(&imm) {
                    bail_msg("branch fixup: imm19 out of range");
                    code.truncate(snapshot);
                    fixups.truncate(fixups_snapshot);
                    plt_call_fixups.truncate(plt_call_fixups_snapshot);
                    data_fixups.truncate(data_fixups_snapshot);
                    user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                    asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
                    asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
                    asm_sections.restore(&asm_sections_snapshot);
                    pending_func_fixups.truncate(pending_func_fixups_snapshot);
                    tls_index_fixups.truncate(tls_index_fixups_snapshot);
                    elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                    macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                    macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                    return false;
                }
                enc_b_cond(cond, imm)
            }
        };
        let bytes = word.to_le_bytes();
        code[fx.site..fx.site + 4].copy_from_slice(&bytes);
    }

    // Materialize each jump table into the read-only blob: one
    // address fixup for the adrp+add site, one slot per entry (a
    // 4-byte `target - table_base` difference, or the relocatable
    // form's 8-byte absolute address left for the object's
    // relocations). Runs past the last bail site so a bailed function
    // leaves the blob untouched.
    for (addr_site, table) in &jump_table_fixups {
        let width: usize = if abs_jump_tables { 8 } else { 4 };
        while !rodata.bytes.len().is_multiple_of(width) {
            rodata.bytes.push(0);
        }
        let base = rodata.bytes.len() as u64;
        rodata.addr_fixups.push(super::RodataAddrFixup {
            code_offset: *addr_site,
            rodata_offset: base,
        });
        for (i, &t) in func.jump_tables[*table as usize].iter().enumerate() {
            let slot_offset = base + (i * width) as u64;
            let text_offset = block_offsets[t as usize] as u64;
            if abs_jump_tables {
                rodata.abs64.push(super::RodataAbs64 {
                    slot_offset,
                    text_offset,
                });
            } else {
                rodata.rel32.push(super::RodataRel32 {
                    slot_offset,
                    base_offset: base,
                    text_offset,
                });
            }
            rodata.bytes.resize(rodata.bytes.len() + width, 0);
        }
    }
    true
}

/// Store a word through sp to take the fault, if the stack ends here, on
/// the page the allocation just entered. `xzr` is always readable and the
/// store sets no flags, so the probe is usable at any point in the
/// lowering without holding a register.
pub(super) fn emit_stack_probe(code: &mut Vec<u8>) {
    emit(code, super::encode::enc_str_imm(Reg(31), Reg::SP, 0));
}

/// Reserve the realigned region and align sp down to `realign_align`
/// (C11 6.7.5). The reservation descends in probed steps; the AND then
/// descends by up to `realign_align - 1` further bytes, which the probe
/// schedule cannot see. When the two together can outrun the unprobed
/// margin, a probe on each side of the AND keeps every step from a touched
/// address within one page, so a stack overflow still faults in the guard.
/// x16 is the emitter's reserved prologue scratch; AND-immediate cannot read
/// sp, so the alignment stages through it.
fn emit_realign_sp(code: &mut Vec<u8>, frame: Frame) {
    let slack = frame.realign_align - 1;
    let probe = frame.realign_region_bytes.saturating_add(slack) > MAX_UNPROBED_STACK_STEP;
    emit_stack_alloc(code, frame.realign_region_bytes, Some(Reg(16)));
    if probe {
        emit_stack_probe(code);
    }
    emit(code, enc_add_imm(Reg(16), Reg(31), 0));
    emit(
        code,
        super::encode::enc_and_sp_pow2(Reg(16), frame.realign_align.trailing_zeros()),
    );
    if probe {
        emit_stack_probe(code);
    }
}

/// Lower `sp -= bytes`, descending in probed steps when the amount is
/// larger than one step can safely cover.
///
/// A decrement of at most [`MAX_UNPROBED_STACK_STEP`] cannot place sp
/// below the guard region, so it needs no probe. Past that the
/// allocation walks down one page at a time and stores through sp after
/// each step, so an overflow faults inside the guard region instead of
/// writing into whatever mapping lies below it. `scratch` is a register
/// the caller does not need across the allocation; given one, a step
/// count above [`STACK_PROBE_UNROLL_MAX`] becomes a counted loop instead
/// of straight-line steps.
pub(super) fn emit_stack_alloc(code: &mut Vec<u8>, bytes: u32, scratch: Option<Reg>) {
    if bytes <= MAX_UNPROBED_STACK_STEP {
        emit_sub_sp_imm(code, bytes);
        return;
    }
    let steps = bytes / STACK_PROBE_PAGE;
    let residual = bytes % STACK_PROBE_PAGE;
    let page_step = super::encode::enc_sub_imm_lsl12(Reg::SP, Reg::SP, 1);
    match scratch {
        Some(counter) if steps > STACK_PROBE_UNROLL_MAX => {
            super::encode::load_imm64(code, counter, steps as u64);
            let loop_start = code.len();
            emit(code, page_step);
            emit_stack_probe(code);
            emit(code, super::encode::enc_subs_imm(counter, counter, 1));
            let off = ((loop_start as i64) - (code.len() as i64)) / 4;
            emit(
                code,
                super::encode::enc_b_cond(super::encode::Cond::Ne, off as i32),
            );
        }
        _ => {
            for _ in 0..steps {
                emit(code, page_step);
                emit_stack_probe(code);
            }
        }
    }
    if residual > 0 {
        emit(code, super::encode::enc_sub_imm(Reg::SP, Reg::SP, residual));
        if residual > MAX_UNPROBED_STACK_STEP {
            emit_stack_probe(code);
        }
    }
}

/// Emit the function prologue.
fn emit_prologue(
    code: &mut Vec<u8>,
    func: &FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
    extern_data_refs: &mut Vec<super::UserExternDataRef>,
) {
    // Windows-on-ARM64 variadic gr-save area (Microsoft ARM64 calling
    // convention). The caller passes the first eight arguments (named
    // and variadic) in x0..x7 by position and the rest on the incoming
    // stack just above the call-site sp, with no shadow / home area
    // reserved. The callee allocates its own 64-byte gr-save area
    // directly above the saved fp/lr and spills all eight argument
    // registers into it, so the named parameters and the
    // register-resident variadic arguments form one contiguous
    // 8-byte-stride region whose top edge meets the incoming stack
    // overflow: `va_arg` walks the gr-save slots then crosses into the
    // stack arguments with no gap. The body reads its named parameters
    // through the same cells (`Frame::param_cell_stride` == 8).
    //
    // Spill ALL eight argument registers, not just the named ones: a
    // variadic argument that landed in a register (x{fixed}..x7) must
    // reach the gr-save area for `va_arg` to read it. The caller passes
    // every argument through the integer registers as a raw 8-byte
    // value (the walker widens variadic floating-point arguments to
    // double and passes `fp_arg_mask = 0` under `variadic_int_only`),
    // so the spill is uniformly integer; the body reads only the named
    // slots and the surplus stores feed `va_arg`.
    if win_arm64_variadic_callee(func, abi) {
        debug_assert_eq!(
            frame.param_spill_bytes, WIN_ARM64_GR_SAVE_BYTES,
            "win-arm64 variadic prologue must reserve the full gr-save area"
        );
        emit_sub_sp_imm(code, WIN_ARM64_GR_SAVE_BYTES);
        for (i, &r) in abi.int_arg_regs.iter().enumerate() {
            let off = (i as u32) * 8;
            emit(code, enc_str_imm(Reg(r), Reg(31), off));
        }
        // Standard frame below the gr-save area. A variadic callee is
        // never a full leaf (`param_spill_bytes != 0`), so the frame
        // record always follows.
        emit_frame_and_saves(code, alloc, frame);
        emit_canary_store(code, frame, abi, extern_data_refs);
        return;
    }
    // AAPCS64 variadic register save area (AAPCS64 Appendix B). Reserve
    // 192 bytes above the saved fp/lr: the general register save area
    // (x0..x7) at `[fp + 16 .. fp + 80)` and the vector register save
    // area (q0..q7, low eightbyte used) at `[fp + 80 .. fp + 208)`. The
    // named parameters read their values from this area (`local_slot_off`
    // redirects positive c5 cdecl slots here) and `va_start` / `va_arg`
    // walk it for the variadic tail. The incoming stack overflow begins
    // immediately above the area at `[fp + 208 .. )` -- the value
    // `va_start` records as `__stack`.
    //
    // Spill ALL eight integer and eight vector argument registers, not
    // just the named ones: a variadic argument that landed in a register
    // (x{named_int}..x7 / d{named_fp}..d7) must reach the save area for
    // `va_arg` to read it. AAPCS64 has no caller-passed vector-count
    // (unlike System V's `al`), so the vector spill is unconditional.
    if aarch64_host_variadic_callee(func, abi) {
        debug_assert_eq!(
            frame.param_spill_bytes, AARCH64_VA_SAVE_BYTES,
            "aapcs64 variadic prologue must reserve the full register save area"
        );
        emit_sub_sp_imm(code, AARCH64_VA_SAVE_BYTES);
        for (i, &r) in abi.int_arg_regs.iter().enumerate() {
            emit(code, enc_str_imm(Reg(r), Reg(31), (i as u32) * 8));
        }
        // The vector half is skipped when the FP/SIMD file is off limits
        // (`no_fp_varargs`): the store itself would fault. The area stays
        // reserved so every offset above it is unchanged, and `va_start`
        // marks it exhausted.
        if !abi.no_fp_varargs {
            for i in 0..8u32 {
                // `str dN, [sp, #gr_save + i*16]` -- the d-register view
                // stores the low eightbyte of vN into the slot start; a
                // `va_arg(double)` reads it back from the same offset.
                emit(
                    code,
                    enc_str_d_imm(i as u8, Reg(31), AARCH64_GR_SAVE_BYTES + i * 16),
                );
            }
        }
        emit_frame_and_saves(code, alloc, frame);
        emit_canary_store(code, frame, abi, extern_data_refs);
        return;
    }
    // Host-arg-reg spill for non-variadic functions: spill each
    // declared int param into a 16-byte c5 cdecl slot above fp,
    // restripe any host-stack overflow into 16-byte slots.
    //
    // The total bytes this block allocates is computed once by
    // `prologue_param_spill_bytes` and stored on `frame`; the
    // epilogue reads it directly. Per-slot store-elision when
    // `Inst::ParamRef` seeded the slot saves the explicit store
    // but still allocates the 16-byte cell (replaced by a coalesced
    // `sub sp`) so the surrounding `LocalAddr` offsets stay stable.
    // When every register-passed parameter is ParamRef-seeded, has
    // no address taken, and has no surviving slot access, the
    // entire register stripe drops out (`frame.param_spill_bytes`
    // already reflects 0) and no instructions are emitted here.
    let entry_spill = if spills_named_params_on_entry(func, abi) {
        func.n_params
    } else {
        0
    };
    if entry_spill > 0 && frame.param_spill_bytes > 0 {
        if params_interleaved(func, abi) {
            emit_interleaved_param_cells(code, func, abi);
        } else {
            let (n_reg, n_stack) = param_reg_stack_split(func, abi);
            let placements = param_placements(func, abi);
            if n_stack > 0 {
                let overflow_bytes = (n_stack as u32) * 16;
                emit_stack_alloc(code, overflow_bytes, None);
                // Each scalar stack parameter's incoming offset is the
                // planner's placement offset, which accounts for any by-value
                // aggregate stack parameter (StructStack) that precedes it. A
                // plain index assumes an 8-byte stride and would read an
                // aggregate's bytes instead of the scalar.
                let mut slot_i = 0u32;
                for p in &placements {
                    if let super::ArgPlacement::Stack(off) = p {
                        let host_off = *off + overflow_bytes;
                        let c5_off = slot_i * 16;
                        emit(code, enc_ldr_imm(Reg(16), Reg(31), host_off));
                        emit(code, enc_str_imm(Reg(16), Reg(31), c5_off));
                        slot_i += 1;
                    }
                }
            }
            let (seeded_params, addr_taken_slots, needed_slots) =
                super::ssa::emit_common::scan_param_slot_usage(func, alloc);
            let mut pending_sub: u32 = 0;
            for i in (0..n_reg).rev() {
                let slot = (i as i64) + 2;
                let skip = seeded_params.contains(&(i as u32))
                    && !addr_taken_slots.contains(&slot)
                    && !needed_slots.contains(&slot);
                if skip {
                    pending_sub += 16;
                } else {
                    if pending_sub > 0 {
                        emit_stack_alloc(code, pending_sub, None);
                        pending_sub = 0;
                    }
                    // Source the incoming value from the parameter's
                    // argument register per the plan. An integer parameter's
                    // register is `plan.IntReg`, not `int_arg_regs[i]`: a
                    // floating-point parameter earlier in the list consumes
                    // a d-register and does not shift the integer bank. A
                    // floating-point parameter (always a `double` here -- a
                    // `float` parameter's positive cell is unobserved and
                    // elided) arrives in a d-register; move its bits into
                    // x16 and store them through the same 16-byte pre-
                    // decrement cell push the integer path uses.
                    match placements.get(i).copied() {
                        Some(super::ArgPlacement::FpReg(d)) => {
                            emit(code, enc_fmov_d_to_x(Reg(16), d));
                            emit(code, enc_str_pre(Reg(16), Reg(31), -16));
                        }
                        Some(super::ArgPlacement::IntReg(r)) => {
                            emit(code, enc_str_pre(Reg(r), Reg(31), -16))
                        }
                        // Aggregate parameter passed in registers: reserve
                        // its 16-byte cell here but leave the incoming
                        // argument registers untouched. The body reads the
                        // aggregate from a parser-reserved body local, not
                        // from this cell; `emit_struct_param_scatter` (run
                        // after the frame is established) stores the
                        // argument registers straight into that local. The
                        // cell is reserved only so the surrounding
                        // `LocalAddr` slot offsets stay stable.
                        Some(super::ArgPlacement::StructRegs { .. }) => {
                            emit_sub_sp_imm(code, 16);
                        }
                        // No register source (stack-passed or out of range):
                        // the overflow restripe above already filled the
                        // cell; reserve its 16 bytes without a store.
                        _ => emit_sub_sp_imm(code, 16),
                    }
                }
            }
            if pending_sub > 0 {
                emit_stack_alloc(code, pending_sub, None);
            }
        }
    }
    // Leaf-function elision: a function that makes no calls
    // (lr stays preserved), allocates no frame, spills no params,
    // saves no callee-regs, and never sets x19 has no work in the
    // standard prologue. AAPCS64 lets it skip the stp / mov-fp
    // pair entirely and ret directly off the caller's lr.
    if is_full_leaf(func, frame, alloc) {
        return;
    }
    // Standard frame: frame record, fp, frame allocation, callee
    // saves (folded into one pre-indexed group when the frame fits).
    emit_frame_and_saves(code, alloc, frame);
    emit_struct_param_scatter(code, func, abi, frame);
    if func.indirect_result_slot != 0 {
        // AAPCS64 6.9: save the caller-supplied x8 indirect-result
        // pointer into its body local; `return s;` writes the
        // aggregate result through it.
        emit_local_addr_fp(code, Place::IntReg(16), func.indirect_result_slot, frame);
        emit(code, enc_str_imm(Reg(8), Reg(16), 0));
    }
    // C11 6.7.5: reserve the over-aligned objects' region below the static
    // frame and align sp down into it. Done last, after all fp-relative setup;
    // the objects live at [sp + region_off]. Reserving before aligning keeps
    // the AND's descent inside bytes the reservation already claimed, so the
    // region cannot overlap the frame.
    // Before the realign: the slot is fp-relative, so the sp move that
    // follows does not reach it.
    emit_canary_store(code, frame, abi, extern_data_refs);
    if frame.realign_align > 0 {
        emit_realign_sp(code, frame);
    }
}

/// Position-indexed parameter cell spill for an interleaved register /
/// stack placement (`params_interleaved`). Allocates one 16-byte cell
/// per declared parameter in a single block, then writes each scalar
/// parameter into the cell for its own position: an integer register
/// stores directly, an FP register routes its bits through x16, a
/// stack-passed scalar copies from the incoming overflow slot just
/// above the cell block. Aggregate parameters get a reserved cell and
/// are filled from their argument registers / incoming stack slot by
/// `emit_struct_param_scatter` once the frame is established; x16 is the
/// only scratch, so no argument register that scatter still needs is
/// disturbed. The single up-front allocation keeps every parameter's
/// cell at `[fp + 16 + position*16]`, matching `local_slot_off`, which
/// the two-phase contiguous-prefix layout cannot do for an interleaved
/// order.
fn emit_interleaved_param_cells(code: &mut Vec<u8>, func: &FunctionSsa, abi: super::Abi) {
    let placements = param_placements(func, abi);
    let cells = func.n_params as u32 * 16;
    // The argument registers hold the incoming values, so the walk takes
    // no scratch register.
    emit_stack_alloc(code, cells, None);
    for (i, p) in placements.iter().enumerate() {
        let c5_off = (i as u32) * 16;
        match p {
            super::ArgPlacement::IntReg(r) => {
                emit(code, enc_str_imm(Reg(*r), Reg(31), c5_off));
            }
            super::ArgPlacement::FpReg(d) => {
                emit(code, enc_fmov_d_to_x(Reg(16), *d));
                emit(code, enc_str_imm(Reg(16), Reg(31), c5_off));
            }
            super::ArgPlacement::Stack(off) => {
                // The incoming overflow argument sits just above the
                // freshly allocated cell block.
                let host_off = cells + *off;
                emit(code, enc_ldr_imm(Reg(16), Reg(31), host_off));
                emit(code, enc_str_imm(Reg(16), Reg(31), c5_off));
            }
            // StructRegs / StructStack reserve their cell here and are
            // filled by `emit_struct_param_scatter`. By-reference
            // aggregate parameters are rejected upstream on AAPCS64, so
            // they do not reach this path.
            _ => {}
        }
    }
}

/// Store each register-passed aggregate parameter's incoming argument
/// registers into its parser-reserved body local. Runs after the
/// frame is established (fp set, frame allocated, callee saves done)
/// so the body local's fp-relative address is valid; the argument
/// registers (x0..x7 / d0..d7) still hold the caller-supplied values
/// at this point, as nothing between the entry and here clobbers
/// them. The body reads the aggregate from this local, so the entry
/// 16-byte argument cell stays unused (the walker emits no entry copy
/// for a tagged aggregate parameter).
fn emit_struct_param_scatter(
    code: &mut Vec<u8>,
    func: &FunctionSsa,
    abi: super::Abi,
    frame: Frame,
) {
    if func.param_aggs.iter().all(Option::is_none) {
        return;
    }
    let placements = param_placements(func, abi);
    for (i, agg) in func.param_aggs.iter().enumerate() {
        let Some(agg_idx) = agg else {
            continue;
        };
        let slot = func.param_local_slots.get(i).copied().unwrap_or(0);
        if slot >= 0 {
            continue;
        }
        match placements.get(i) {
            Some(super::ArgPlacement::StructRegs { regs, n, .. }) => {
                // Materialise the body local's address into x16, then store
                // each unit from its argument register. An integer
                // eightbyte stores at offset 8k; an HFA member stores at
                // its own offset with its natural size (d-register for 8
                // bytes, s-register for 4). x16/x17 are never argument
                // registers, so the source `regs` are untouched.
                let hfa = super::abi_classify::hfa_member_layout(
                    &func.agg_descs[*agg_idx as usize].fields,
                );
                emit_local_addr_fp(code, Place::IntReg(16), slot, frame);
                for (k, cr) in regs.iter().take(*n as usize).enumerate() {
                    if cr.is_fp {
                        let (off, msize) = hfa
                            .as_ref()
                            .and_then(|m| m.get(k).copied())
                            .unwrap_or(((k as u32) * 8, 8));
                        if msize == 8 {
                            emit(code, super::encode::enc_str_d_imm(cr.reg, Reg(16), off));
                        } else {
                            emit(code, super::encode::enc_str_s_imm(cr.reg, Reg(16), off));
                        }
                    } else {
                        emit(code, enc_str_imm(Reg(cr.reg), Reg(16), (k as u32) * 8));
                    }
                }
            }
            Some(super::ArgPlacement::StructStack { off, size, .. }) => {
                // The aggregate spilled to the caller's stack argument
                // area, which sits above the saved fp/lr (16 bytes) and
                // the callee's c5 parameter cells (`param_spill_bytes`).
                // Copy its bytes from there into the body local the
                // parameter is read from; the cell reserved for this
                // parameter (param_reg_stack_split counts a StructStack as
                // a register slot, so a 16-byte cell is reserved) stays
                // unused. AAPCS64 5.4.2 rounds the stack slot up to 8
                // bytes; copy each whole eightbyte then a sub-eightbyte
                // tail. x17 is the value temp, fp the source base; x16 the
                // destination base, so no argument register is disturbed.
                let src = 16 + frame.param_spill_bytes + *off;
                let size = *size;
                debug_assert!(
                    src + size <= 4096 * 8,
                    "stack-arg offset beyond ldr imm12 reach"
                );
                emit_local_addr_fp(code, Place::IntReg(16), slot, frame);
                let mut o = 0u32;
                while o + 8 <= size {
                    emit(code, enc_ldr_imm(Reg(17), Reg(29), src + o));
                    emit(code, enc_str_imm(Reg(17), Reg(16), o));
                    o += 8;
                }
                if o + 4 <= size {
                    emit(
                        code,
                        super::encode::enc_ldr32_imm(Reg(17), Reg(29), src + o),
                    );
                    emit(code, super::encode::enc_str32_imm(Reg(17), Reg(16), o));
                    o += 4;
                }
                if o + 2 <= size {
                    emit(code, super::encode::enc_ldrh_imm(Reg(17), Reg(29), src + o));
                    emit(code, super::encode::enc_strh_imm(Reg(17), Reg(16), o));
                    o += 2;
                }
                if o < size {
                    emit(code, super::encode::enc_ldrb_imm(Reg(17), Reg(29), src + o));
                    emit(code, super::encode::enc_strb_imm(Reg(17), Reg(16), o));
                }
            }
            _ => continue,
        }
    }
}

/// Save the allocator-reported callee-saved GPRs + FP regs at the
/// bottom of the frame. The saved-reg region sits just above sp; its
/// offsets are one slot per saved register, so the pair imm7 (scaled by
/// 8, range -512..504) and the 12-bit scaled immediate always cover
/// them. The allocator spill region, by contrast, can exceed that reach
/// and is addressed through the range-checked SP helpers. x19 is saved
/// just past the allocator-saved gprs, but only when the function
/// clobbers it; the slot is reserved either way so the surrounding
/// offsets stay fixed. Adjacent slots within each region save as
/// stp / ldp pairs; a region's odd tail saves alone.
///
/// When `fold != 0` (see [`frame_fold_bytes`]) the first save carries
/// the whole allocation -- frame plus the fp/lr slot pair -- as a
/// pre-indexed store of `-fold` bytes, replacing the prologue's
/// `stp x29, x30, [sp, #-16]!` / `sub sp` pair; the first save always
/// targets offset 0, so every other offset is unchanged.
fn emit_prologue_saved_regs(code: &mut Vec<u8>, alloc: &Allocation, frame: Frame, fold: u32) {
    let mut alloc_pending = fold != 0;
    let fp = &alloc.fp_used;
    let mut i = 0usize;
    while i + 1 < fp.len() {
        if core::mem::take(&mut alloc_pending) {
            emit(
                code,
                enc_stp_d_pre(fp[i], fp[i + 1], Reg(31), -(fold as i32)),
            );
        } else {
            emit(
                code,
                enc_stp_d_off(fp[i], fp[i + 1], Reg(31), (i as i32) * 8),
            );
        }
        i += 2;
    }
    if i < fp.len() {
        if core::mem::take(&mut alloc_pending) {
            emit(code, enc_str_d_pre(fp[i], Reg(31), -(fold as i32)));
        } else {
            emit(code, enc_str_d_imm(fp[i], Reg(31), (i as u32) * 8));
        }
    }
    let saved_fpr_bytes = super::ssa::emit_common::slots16(fp.len() as u32);
    let gpr = &alloc.gpr_used;
    let mut i = 0usize;
    while i + 1 < gpr.len() {
        let off = (saved_fpr_bytes + (i as u32) * 8) as i32;
        if core::mem::take(&mut alloc_pending) {
            emit(
                code,
                enc_stp_pre(Reg(gpr[i]), Reg(gpr[i + 1]), Reg(31), -(fold as i32)),
            );
        } else {
            emit(
                code,
                enc_stp_off(Reg(gpr[i]), Reg(gpr[i + 1]), Reg(31), off),
            );
        }
        i += 2;
    }
    if i < gpr.len() {
        if core::mem::take(&mut alloc_pending) {
            emit(code, enc_str_pre(Reg(gpr[i]), Reg(31), -(fold as i32)));
        } else {
            let off = saved_fpr_bytes + (i as u32) * 8;
            emit(code, enc_str_imm(Reg(gpr[i]), Reg(31), off));
        }
    }
    if frame.uses_x19 {
        if core::mem::take(&mut alloc_pending) {
            emit(code, enc_str_pre(Reg(19), Reg(31), -(fold as i32)));
        } else {
            let saved_gpr_bytes = super::ssa::emit_common::slots16(gpr.len() as u32);
            emit(
                code,
                enc_str_imm(Reg(19), Reg(31), saved_fpr_bytes + saved_gpr_bytes),
            );
        }
    }
    debug_assert!(!alloc_pending, "frame fold requested with no callee save");
}

/// Scratch pair for the stack-protector sequences. x16 / x17 are the
/// emitter's reserved scratch, outside the allocator's pool and never an
/// argument or result register, so they are free at the end of the
/// prologue and on every return path.
const CANARY_SCRATCH: Reg = Reg(16);

const CANARY_SCRATCH2: Reg = Reg(17);

/// Leave the guard value in `rd`. `-mstack-protector-guard=sysreg` reads
/// it at a byte offset above a system register's value; the `global` form
/// reads the object the target's C library exports, whose address the
/// writer resolves directly or through the GOT.
fn emit_load_stack_guard(
    code: &mut Vec<u8>,
    rd: Reg,
    abi: super::Abi,
    extern_data_refs: &mut Vec<super::UserExternDataRef>,
) {
    let ssp = abi.stack_protect;
    if let super::StackGuard::Sysreg { sysreg, offset } = ssp.guard {
        emit(code, super::encode::enc_mrs(rd, sysreg));
        emit_guard_load_at_offset(code, rd, rd, offset);
        return;
    }
    let symbol = ssp.guard_symbol.as_str();
    let name = if symbol.is_empty() {
        super::STACK_GUARD_SYMBOL
    } else {
        symbol
    };
    extern_data_refs.push(super::UserExternDataRef {
        instr_offset: code.len(),
        symbol_name: name.into(),
        direct_pcrel: None,
    });
    emit(code, enc_adrp(rd, 0));
    emit(code, enc_add_imm(rd, rd, 0));
    emit(code, enc_ldr_imm(rd, rd, 0));
}

/// `ldr rd, [rn, #off]` for a guard offset of either sign: the scaled
/// unsigned-offset form when it fits, the unscaled signed form otherwise,
/// and an explicit address computation past both ranges, which takes
/// [`CANARY_SCRATCH2`].
fn emit_guard_load_at_offset(code: &mut Vec<u8>, rd: Reg, rn: Reg, off: i32) {
    if (0..=32760).contains(&off) && off % 8 == 0 {
        emit(code, enc_ldr_imm(rd, rn, off as u32));
    } else if (-256..256).contains(&off) {
        emit(code, super::encode::enc_ldur(rd, rn, off));
    } else {
        super::encode::load_imm64(code, CANARY_SCRATCH2, off as i64 as u64);
        emit(
            code,
            super::encode::enc_add_reg(CANARY_SCRATCH2, rn, CANARY_SCRATCH2),
        );
        emit(code, enc_ldr_imm(rd, CANARY_SCRATCH2, 0));
    }
}

/// Prologue half of the stack protector: store the guard into the canary
/// slot at `[fp - 8]`, above every local and below the saved fp/lr, then
/// clear the scratch so the guard value does not outlive the store.
fn emit_canary_store(
    code: &mut Vec<u8>,
    frame: Frame,
    abi: super::Abi,
    extern_data_refs: &mut Vec<super::UserExternDataRef>,
) {
    if frame.canary_bytes == 0 {
        return;
    }
    emit_load_stack_guard(code, CANARY_SCRATCH, abi, extern_data_refs);
    emit(
        code,
        super::encode::enc_stur(
            CANARY_SCRATCH,
            Reg(29),
            super::ssa::emit_common::CANARY_SLOT_OFF,
        ),
    );
    emit(code, enc_movz(CANARY_SCRATCH, 0, 0));
}

/// Epilogue half: compare the canary slot against the guard and call
/// `__stack_chk_fail` when they differ. Emitted on every path that leaves
/// the frame, ahead of the teardown, while fp still addresses the slot.
fn emit_canary_check(
    code: &mut Vec<u8>,
    frame: Frame,
    abi: super::Abi,
    extern_sites: &mut Vec<super::UserExternCallSite>,
    extern_data_refs: &mut Vec<super::UserExternDataRef>,
) {
    if frame.canary_bytes == 0 {
        return;
    }
    emit_load_stack_guard(code, CANARY_SCRATCH, abi, extern_data_refs);
    emit(
        code,
        super::encode::enc_ldur(
            CANARY_SCRATCH2,
            Reg(29),
            super::ssa::emit_common::CANARY_SLOT_OFF,
        ),
    );
    emit(
        code,
        super::encode::enc_cmp_reg(CANARY_SCRATCH, CANARY_SCRATCH2),
    );
    // Two instructions ahead: over the `bl` to the handler.
    emit(code, super::encode::enc_b_cond(super::encode::Cond::Eq, 2));
    extern_sites.push(super::UserExternCallSite {
        instr_offset: code.len(),
        symbol_name: super::STACK_CHK_FAIL_SYMBOL.into(),
        is_tail: false,
    });
    emit(code, super::encode::enc_bl(0));
    // Both scratch registers held the guard value; neither may reach the
    // caller with it.
    emit(code, enc_movz(CANARY_SCRATCH, 0, 0));
    emit(code, enc_movz(CANARY_SCRATCH2, 0, 0));
}

/// Re-establish `sp = fp - frame_bytes` in a dynamic-sp frame before
/// the epilogue's sp-relative restores. No-op for static frames. A
/// split displacement is computed into x16 and committed with one
/// write, so sp never rests above still-unrestored frame bytes (a
/// signal delivered mid-sequence pushes its frame below sp).
fn restore_dynamic_sp(code: &mut Vec<u8>, frame: Frame) {
    if !frame.dynamic_sp {
        return;
    }
    let bytes = frame.frame_bytes;
    if bytes < 4096 {
        emit(code, enc_sub_imm(Reg(31), Reg(29), bytes));
    } else {
        emit_fp_minus_off(code, Reg(16), bytes);
        emit(code, enc_add_imm(Reg(31), Reg(16), 0));
    }
}

/// Restore what [`emit_prologue_saved_regs`] saved, in mirror order
/// (x19, gprs descending, fp regs descending) so the offset-0 access
/// comes last and, when `fold != 0`, tears the frame down as a
/// post-indexed load of `fold` bytes, replacing the epilogue's
/// `add sp` and the fp/lr `ldp`. `fold` is the total writeback
/// (frame plus the fp/lr pair), or 0 for the unfolded shape.
fn emit_epilogue_restore_regs(code: &mut Vec<u8>, alloc: &Allocation, frame: Frame, fold: u32) {
    let saved_fpr_bytes = super::ssa::emit_common::slots16(alloc.fp_used.len() as u32);
    let gpr = &alloc.gpr_used;
    if frame.uses_x19 {
        let saved_gpr_bytes = super::ssa::emit_common::slots16(gpr.len() as u32);
        let off = saved_fpr_bytes + saved_gpr_bytes;
        if off == 0 && fold != 0 {
            emit(code, enc_ldr_post(Reg(19), Reg(31), fold as i32));
        } else {
            emit(code, enc_ldr_imm(Reg(19), Reg(31), off));
        }
    }
    let mut i = gpr.len();
    if i % 2 == 1 {
        i -= 1;
        let off = saved_fpr_bytes + (i as u32) * 8;
        if off == 0 && fold != 0 {
            emit(code, enc_ldr_post(Reg(gpr[i]), Reg(31), fold as i32));
        } else {
            emit(code, enc_ldr_imm(Reg(gpr[i]), Reg(31), off));
        }
    }
    while i >= 2 {
        i -= 2;
        let off = (saved_fpr_bytes + (i as u32) * 8) as i32;
        if off == 0 && fold != 0 {
            emit(
                code,
                enc_ldp_post(Reg(gpr[i]), Reg(gpr[i + 1]), Reg(31), fold as i32),
            );
        } else {
            emit(
                code,
                enc_ldp_off(Reg(gpr[i]), Reg(gpr[i + 1]), Reg(31), off),
            );
        }
    }
    let fp = &alloc.fp_used;
    let mut i = fp.len();
    if i % 2 == 1 {
        i -= 1;
        if i == 0 && fold != 0 {
            emit(code, enc_ldr_d_post(fp[i], Reg(31), fold as i32));
        } else {
            emit(code, enc_ldr_d_imm(fp[i], Reg(31), (i as u32) * 8));
        }
    }
    while i >= 2 {
        i -= 2;
        if i == 0 && fold != 0 {
            emit(code, enc_ldp_d_post(fp[i], fp[i + 1], Reg(31), fold as i32));
        } else {
            emit(
                code,
                enc_ldp_d_off(fp[i], fp[i + 1], Reg(31), (i as i32) * 8),
            );
        }
    }
}

/// Frame bytes the folded prologue / epilogue shape can carry, or 0
/// when the fold does not apply. The folded shape extends the frame by
/// the 16-byte fp/lr slot pair at its top: the first callee save
/// pre-indexes `-(frame_bytes + 16)`, fp/lr store / load through the
/// signed-offset pair form at `[sp, #frame_bytes]`, and the last
/// restore post-indexes the whole amount back. All three must fit
/// their immediates: the scaled imm7 pair forms reach +-504/512, so a
/// pair-first frame folds up to 488 (16-aligned: 480); a single-register
/// bottom save uses the unscaled imm9 (+-255) and folds up to 224.
/// Both sides compute the fold from the same inputs so they agree.
fn frame_fold_bytes(alloc: &Allocation, frame: Frame) -> u32 {
    // A realigning function uses the unfolded shape so the epilogue's
    // `restore_dynamic_sp` (sub sp, fp, #frame_bytes) cleanly returns sp to the
    // static frame bottom before the sp-relative restores (C11 6.7.5).
    if frame.realign_align != 0 {
        return 0;
    }
    let n_bottom = if !alloc.fp_used.is_empty() {
        alloc.fp_used.len()
    } else if !alloc.gpr_used.is_empty() {
        alloc.gpr_used.len()
    } else if frame.uses_x19 {
        1
    } else {
        return 0;
    };
    debug_assert!(frame.frame_bytes >= 16, "saves imply a non-empty frame");
    let limit = if n_bottom >= 2 { 480 } else { 224 };
    if frame.frame_bytes <= limit {
        frame.frame_bytes
    } else {
        0
    }
}

/// Establish the frame record and fp, allocate the frame, and save the
/// callee-saved registers. The folded shape allocates everything with
/// the first callee save's pre-index and keeps fp and every offset
/// identical to the unfolded `stp fp/lr; mov fp, sp; sub sp` shape;
/// fp/lr restore first in the epilogue, so the `ret`-feeding lr load
/// issues off an address that depends on no other restore.
fn emit_frame_and_saves(code: &mut Vec<u8>, alloc: &Allocation, frame: Frame) {
    let fold = frame_fold_bytes(alloc, frame);
    if fold != 0 {
        emit_prologue_saved_regs(code, alloc, frame, fold + 16);
        emit(code, enc_stp_off(Reg(29), Reg(30), Reg(31), fold as i32));
        emit(code, enc_add_imm(Reg(29), Reg(31), fold));
        return;
    }
    emit(code, enc_stp_pre(Reg(29), Reg(30), Reg(31), -16));
    emit(code, enc_add_imm(Reg(29), Reg(31), 0));
    if frame.frame_bytes > 0 {
        // x16 is the emitter's reserved prologue scratch.
        emit_stack_alloc(code, frame.frame_bytes, Some(Reg(16)));
    }
    emit_prologue_saved_regs(code, alloc, frame, 0);
}

/// Byte offset (positive) from fp to the start of the saved-reg
/// region. The region is the lowest portion of the frame.
fn alloc_save_base(frame: Frame, alloc: &Allocation) -> u32 {
    let saved_gpr_bytes = super::ssa::emit_common::slots16(alloc.gpr_used.len() as u32);
    let saved_fpr_bytes = super::ssa::emit_common::slots16(alloc.fp_used.len() as u32);
    // fp is at frame top; the saved-reg region sits at the
    // bottom. Distance from fp = frame_bytes - saved-region size.
    frame
        .frame_bytes
        .saturating_sub(saved_gpr_bytes + saved_fpr_bytes)
}

/// Return the aarch64 condition code to use for a `B.cond` when
/// `cond` was flagged as branch-fused by the allocator. `negate`
/// is true for `Bz` (branch when comparison failed); false for
/// `Bnz`. Returns `None` when fusion doesn't apply (caller falls
/// back to the unfused `cbz` / `cbnz` path). The FP conditions map
/// as the `fcmp` + `cset` pair does, and `Cond::flip` is an exact
/// NZCV complement, so an inverted FP branch is taken on the
/// unordered (NaN) state exactly when C99 6.5.8p6 / 6.5.9p3
/// require the negated comparison to hold.
fn fused_branch_cond(
    func: &super::super::ir::FunctionSsa,
    alloc: &Allocation,
    cond: super::super::ir::ValueId,
    negate: bool,
) -> Option<super::encode::Cond> {
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
    let positive = compare_cond(op).or_else(|| fp_compare_cond(op))?;
    Some(if negate { positive.flip() } else { positive })
}

/// Emit the function epilogue + `ret` for a Return terminator.
#[allow(clippy::too_many_arguments)]
fn emit_return(
    code: &mut Vec<u8>,
    value: u32,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
    func: &FunctionSsa,
    abi: super::Abi,
    extern_sites: &mut Vec<super::UserExternCallSite>,
    extern_data_refs: &mut Vec<super::UserExternDataRef>,
) {
    // Host-ABI aggregate return (AAPCS64 6.9). `value` is the
    // struct's address. An aggregate of at most 16 bytes returns its
    // eightbytes in x0/x1; a larger one is copied through the caller-
    // supplied x8 pointer (saved to `indirect_result_slot` by the
    // prologue) and that pointer is returned in x0.
    if let Some(ai) = func.ret_agg {
        let desc = &func.agg_descs[ai as usize];
        let size = desc.size;
        let place = alloc
            .places
            .get(value as usize)
            .copied()
            .unwrap_or(Place::None);
        let saddr = materialize_int(code, place, scratch.primary, frame).unwrap_or(scratch.primary);
        if saddr.0 != scratch.primary.0 {
            emit_mov_reg(code, scratch.primary, saddr);
        }
        let base = scratch.primary;
        if let Some(members) = super::abi_classify::hfa_member_layout(&desc.fields) {
            // AAPCS64 6.9: a homogeneous floating-point aggregate returns
            // member k in v[k] (d-register for an F64 member, s-register
            // for an F32). Load each from its byte offset in the source.
            for (k, (off, msize)) in members.iter().enumerate() {
                emit_agg_load_fp(
                    code,
                    k as u8,
                    base,
                    *off,
                    *msize,
                    desc.align,
                    abi.strict_align,
                    scratch.secondary,
                );
            }
        } else if size <= 16 {
            if size > 8 {
                emit_agg_load_int(
                    code,
                    Reg(1),
                    base,
                    8,
                    8,
                    desc.align,
                    abi.strict_align,
                    scratch.secondary,
                );
            }
            emit_agg_load_int(
                code,
                Reg(0),
                base,
                0,
                8,
                desc.align,
                abi.strict_align,
                scratch.secondary,
            );
        } else {
            let dst = scratch.secondary;
            emit_local_addr_fp(code, Place::IntReg(dst.0), func.indirect_result_slot, frame);
            emit(code, enc_ldr_imm(dst, dst, 0));
            // Both endpoints are the caller's object, so its alignment
            // bounds the transfer unit.
            let unit = super::super::access_chunk(desc.align, abi.strict_align, 8);
            // The byte form's scaled immediate reaches 4095, so a copy
            // past that advances both bases; `WINDOW` is 8-aligned and
            // below 4096, keeping every unit and tail offset in range.
            const WINDOW: u32 = 4088;
            let mut pos = 0u32;
            while pos < size {
                let run = (size - pos).min(WINDOW);
                let mut copied = 0u32;
                while copied + unit <= run {
                    emit_copy_unit(code, unit, Reg(0), base, copied, dst, copied);
                    copied += unit;
                }
                while copied < run {
                    emit(code, enc_ldrb_imm(Reg(0), base, copied));
                    emit(code, enc_strb_imm(Reg(0), dst, copied));
                    copied += 1;
                }
                pos += run;
                if pos < size {
                    emit(code, super::encode::enc_add_imm(base, base, run));
                    emit(code, super::encode::enc_add_imm(dst, dst, run));
                }
            }
            if size > WINDOW {
                // The advanced `dst` no longer names the caller's buffer;
                // re-read the saved indirect-result pointer to return it.
                emit_local_addr_fp(code, Place::IntReg(dst.0), func.indirect_result_slot, frame);
                emit(code, enc_ldr_imm(dst, dst, 0));
            }
            emit_mov_reg(code, Reg(0), dst);
        }
    } else if value != super::super::ir::NO_VALUE {
        // Move the return value into x0. c5's calling convention
        // ferries every return value (including f64 bit patterns)
        // through the int return register, matching the pool path's
        // `mov x0, x19` epilogue. FpReg-placed values reach x0 via
        // `fmov x, d`; int values flow through the standard
        // materialise + mov. NO_VALUE marks an implicit return with
        // no live accumulator -- harmless because c5 calls never
        // read the result of a void-returning function.
        let place = alloc
            .places
            .get(value as usize)
            .copied()
            .unwrap_or(Place::None);
        // A floating-point scalar result is returned in d0 (C99
        // 6.2.5p10 / AAPCS64 6.4.2). A `float` result occupies s0, the
        // low 32 bits of d0, which a d-register copy / 8-byte FP load
        // preserves. The value's producing instruction determines the
        // register file even when the allocator spilled it.
        let returns_fp = func.ret_is_fp
            || ((value as usize) < func.insts.len()
                && super::ssa::reg_alloc::produces_fp_result(&func.insts[value as usize]));
        if let Place::FpReg(r) = place {
            if r != 0 {
                emit(code, super::encode::enc_fmov_d_d(0, r));
            }
        } else if returns_fp {
            // The function returns a floating-point scalar in d0 but the
            // value is GPR / spill resident -- a bare FP constant
            // materializes as an integer immediate, and any value whose
            // producing instruction is integer-classed lands in a GPR.
            // The 8 bytes hold the f64 bit pattern (the low 32 are an
            // f32's s0); reinterpret them into d0.
            match place {
                Place::Spill(slot) => {
                    let sp_off = spill_off(frame, slot);
                    emit_spill_ldr_d_auto(code, frame, 0, sp_off);
                }
                _ => {
                    let src = materialize_int(code, place, scratch.primary, frame)
                        .unwrap_or(scratch.primary);
                    emit(code, enc_fmov_x_to_d(0, src));
                }
            }
        } else if let Some(src) = materialize_int(code, place, scratch.primary, frame)
            && src.0 != 0
        {
            emit_mov_reg(code, Reg(0), src);
        }
    }
    // Leaf-function elision: prologue emitted no save, so the
    // epilogue emits no matching restore -- the function body is
    // bracketed only by the return-value materialization and the
    // ret. Keep the symmetry tight so any reader can pair the
    // two halves at a glance.
    if is_full_leaf(func, frame, alloc) {
        emit(code, enc_ret(Reg(30)));
        return;
    }
    emit_canary_check(code, frame, abi, extern_sites, extern_data_refs);
    // A dynamic-sp frame re-establishes `sp = fp - frame_bytes` first,
    // so the sp-relative restores below read the prologue-time
    // addresses regardless of the body's alloca moves.
    restore_dynamic_sp(code, frame);
    // Restore fp/lr first in the folded shape (the lr load feeds `ret`,
    // so it issues off sp before the writeback chain), then x19 and the
    // callee-saved GPRs / FP regs in mirror order of the prologue's
    // saves; the final restore's post-index tears the frame down. The
    // unfolded shape keeps the restore / `add sp` / fp-lr `ldp` order.
    let fold = frame_fold_bytes(alloc, frame);
    if fold != 0 {
        emit(code, enc_ldp_off(Reg(29), Reg(30), Reg(31), fold as i32));
        emit_epilogue_restore_regs(code, alloc, frame, fold + 16);
    } else {
        emit_epilogue_restore_regs(code, alloc, frame, 0);
        if frame.frame_bytes > 0 {
            // x16 is call-clobbered and carries no result, so it is free
            // to hold a frame size past the immediate reach.
            super::encode::emit_add_sp_imm_scratch(code, frame.frame_bytes, Reg(16));
        }
        emit(code, enc_ldp_post(Reg(29), Reg(30), Reg(31), 16));
    }
    // Drop whatever bytes the prologue allocated above the saved
    // fp/lr for c5 cdecl parameter slots. The single source of
    // truth is `prologue_param_spill_bytes`, recorded on
    // `frame.param_spill_bytes`; both prologue and epilogue read
    // from there so the two sides agree across every branch the
    // prologue takes (variadic, host-stack overflow,
    // ParamRef-elided, per-slot pending_sub flush).
    if frame.param_spill_bytes > 0 {
        emit_add_sp_imm(code, frame.param_spill_bytes);
    }
    // Every teardown above has completed, so sp holds the value
    // `paciasp` signed against.
    if signs_return_address(func, frame, alloc, abi) {
        emit(code, super::encode::AUTIASP);
    }
    emit(code, enc_ret(Reg(30)));
}
