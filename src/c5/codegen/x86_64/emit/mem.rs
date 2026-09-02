use super::*;

/// `Inst::TlsAddr` lowering. Routes through the per-target TLS
/// access shape. Linux variant-2 layout: `var = fs:[0] - (tls_total
/// - offset)`. The Windows path emits a TEB `gs:[0x58]` table
/// lookup indexed by `_tls_index` plus a final `lea`, and pushes
/// the writer fixup so the linker can patch the `_tls_index`
/// slot's RVA.
pub(super) fn emit_tls_addr(
    code: &mut Vec<u8>,
    dst: Place,
    offset: i64,
    v: super::super::ir::ValueId,
    target: Target,
    tls_index_fixups: &mut Vec<super::TlsIndexFixup>,
    elf_tpoff_fixups: &mut Vec<super::ElfTpoffFixup>,
    extern_tls_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    tls_total_size: usize,
    frame: Frame,
) -> bool {
    let Some(rd) = int_or_spill_dst(dst) else {
        return fail("TlsAddr: dst not int reg / spill");
    };
    match target {
        Target::LinuxX64 => {
            // A cross-unit `extern _Thread_local` carries the referenced
            // symbol in `extern_tls_names`; its TPOFF is unknown until
            // the link merges the TLS blocks, so emit a 0 placeholder and
            // record an extern fixup. A same-unit access bakes the
            // single-unit TPOFF (`tls_total_size - offset`, correct for an
            // in-memory or single-object emit) and also records a fixup so
            // the linker re-patches it against the merged layout when more
            // than one unit contributes TLS storage.
            let extern_sym = extern_tls_names.get(&v).cloned();
            // Variant-2 TPOFF is negative: the block sits below the
            // thread pointer, `var = fs:[0] + (offset - tls_total)`.
            // Emitting an `add` with the signed immediate (rather than
            // a `sub` of the magnitude) keeps the field patchable with
            // the standard negative TPOFF value.
            let tpoff = if extern_sym.is_some() {
                0
            } else {
                let t = offset - (tls_total_size as i64);
                if !(i32::MIN as i64..=0).contains(&t) {
                    return fail("TlsAddr: tpoff out of i32 range");
                }
                t
            };
            // mov rd, qword ptr fs:[0]
            //   FS prefix 64; REX.W=1, REX.R = (rd >= 8);
            //   opcode 8B; ModR/M mod=00 reg=rd.lo rm=100 (SIB);
            //   SIB scale=00 index=100 (none) base=101 (disp32);
            //   disp32 = 0.
            let rex = 0x48 | (((rd.0 >> 3) & 1) << 2);
            code.push(0x64);
            code.push(rex);
            code.push(0x8B);
            code.push(0x04 | ((rd.0 & 7) << 3));
            code.push(0x25);
            code.extend_from_slice(&0u32.to_le_bytes());
            // add rd, imm32
            //   REX.W=1, REX.B = (rd >= 8);
            //   opcode 81 /0;
            //   ModR/M mod=11 reg=0 rm=rd.lo;
            //   imm32 = tpoff (patched by the linker per the fixup).
            let rex_add = 0x48 | ((rd.0 >> 3) & 1);
            code.push(rex_add);
            code.push(0x81);
            code.push(0xC0 | (rd.0 & 7));
            let imm_offset = code.len();
            code.extend_from_slice(&(tpoff as i32).to_le_bytes());
            elf_tpoff_fixups.push(super::ElfTpoffFixup {
                imm_offset,
                target: match extern_sym {
                    Some(name) => super::ElfTpoffTarget::Extern(name),
                    None => super::ElfTpoffTarget::Local(offset as u64),
                },
            });
            spill_dst_to_slot(code, dst, rd, frame);
            true
        }
        Target::WindowsX64 => {
            if !(i32::MIN as i64..=i32::MAX as i64).contains(&offset) {
                return fail("TlsAddr: offset out of i32 range");
            }
            // PE/x86_64 TLS reads gs:[0x58] (the TEB) for the TLS
            // array, indexes it by `_tls_index`, and adds the
            // per-variable offset. The SSA allocator covers rax /
            // r11 / etc.; use SCRATCH_R10 (r10, outside the
            // allocator's pool) for the TEB pointer and `rd`
            // itself for the index load -- the index is only live
            // across one mov so reusing the destination is safe.
            //
            // mov r10, gs:[0x58]           ; TEB
            // mov rd_w, [rip+disp32]       ; _tls_index slot
            //                              ;   (zero-extends to rd)
            // mov r10, [r10 + rd*8]        ; tls_array[idx]
            // lea rd, [r10 + offset]
            code.extend_from_slice(&[0x65, 0x4C, 0x8B, 0x14, 0x25, 0x58, 0, 0, 0]);
            // mov rd.lo_dword, [rip+disp32]:
            //   REX.R = (rd >= 8); opcode 8B;
            //   ModR/M mod=00 reg=rd.lo rm=101 (rip-relative);
            //   disp32 = 0 (patched).
            let rex_idx = if rd.0 >= 8 { 0x44 } else { 0x00 };
            if rex_idx != 0 {
                code.push(rex_idx);
            }
            // The writer's TLS-index fixup patches the 4-byte
            // displacement at `instr_offset + 2`. With a REX
            // prefix the disp32 lives at `instr_offset + 3` if
            // we anchor to the REX, so anchor to the opcode byte
            // instead -- `instr_offset + 2` then lands on the
            // disp32 regardless of whether a REX was emitted.
            let mov_idx_offset = code.len();
            code.push(0x8B);
            code.push(0x05 | ((rd.0 & 7) << 3));
            code.extend_from_slice(&0i32.to_le_bytes());
            tls_index_fixups.push(super::TlsIndexFixup {
                instr_offset: mov_idx_offset,
            });
            // mov r10, [r10 + rd*8]:
            //   REX = 0x4D | (rd.high ? 0x02 : 0)  (W=1, R=1 to
            //                                       reach r10 dest,
            //                                       X = rd>=8,
            //                                       B=1 for r10 base)
            //   opcode 8B; ModR/M mod=00 reg=010 (r10.lo)
            //                       rm=100 (SIB);
            //   SIB scale=11 (*8), index=rd.lo, base=010 (r10.lo).
            let rex_idx_sib = 0x4D | (if rd.0 >= 8 { 0x02 } else { 0 });
            code.push(rex_idx_sib);
            code.push(0x8B);
            code.push(0x14);
            code.push(0xC2 | ((rd.0 & 7) << 3));
            // lea rd, [r10 + disp32]: r10 already holds the module's TLS
            // block base, so disp32 is the variable's offset within the
            // merged block with no thread-pointer bias. A cross-unit
            // `extern _Thread_local` offset is unknown until the link merges
            // the TLS blocks, so emit a 0 placeholder; a same-unit access
            // bakes its raw block offset. Both record an `elf_tpoff_fixups`
            // entry so the linker rebases the disp32 to the merged offset
            // (Local) or resolves it by symbol (Extern).
            //   REX.W=1, REX.R = (rd >= 8), REX.B=1 (r10 base);
            //   opcode 8D;
            //   ModR/M mod=10 (disp32), reg=rd.lo, rm=010 (r10).
            let extern_sym = extern_tls_names.get(&v).cloned();
            let disp: i64 = if extern_sym.is_some() { 0 } else { offset };
            let rex_lea = 0x49 | (if rd.0 >= 8 { 0x04 } else { 0 });
            code.push(rex_lea);
            code.push(0x8D);
            code.push(0x82 | ((rd.0 & 7) << 3));
            let imm_offset = code.len();
            code.extend_from_slice(&(disp as i32).to_le_bytes());
            elf_tpoff_fixups.push(super::ElfTpoffFixup {
                imm_offset,
                target: match extern_sym {
                    Some(name) => super::ElfTpoffTarget::Extern(name),
                    None => super::ElfTpoffTarget::Local(offset as u64),
                },
            });
            spill_dst_to_slot(code, dst, rd, frame);
            true
        }
        _ => fail("TlsAddr: target not x86_64"),
    }
}

/// rbp-relative byte offset of the c5 cdecl slot `off` for the
/// current callee, accounting for the System V variadic register
/// save area.
///
/// For a non-variadic callee (and every non-SysV target) this is the
/// plain `c5_slot_to_fp_offset`: positive c5 cdecl parameter cells at
/// `[rbp + 16 + (off-2)*stride]`, negative locals at `[rbp + off*8]`.
///
/// For a System V variadic callee (System V AMD64 3.5.7) the named
/// parameters are not pushed as positive cells -- they arrive in the
/// argument registers and the prologue spills them into the register
/// save area at the bottom of the frame. A named-parameter access
/// (`off >= 2`, parameter index `off - 2`) is therefore redirected to
/// that parameter's slot in the save area: an integer / pointer
/// parameter to `[reg_save + int_rank*8]` within the 48-byte gp area,
/// a floating-point parameter to `[reg_save + 48 + fp_rank*16]` within
/// the 128-byte fp area, where `reg_save = rbp - frame_bytes` and the
/// rank is the parameter's position within its argument-register bank
/// (the independent int / FP banks of System V AMD64 3.2.3). Locals
/// (`off < 0`) are unaffected.
pub(super) fn local_slot_off(off: i64, func: &FunctionSsa, frame: Frame, abi: super::Abi) -> i64 {
    if off >= 2 && sysv_variadic_callee(func, abi) {
        let reg_save = frame.va_reg_save_off as i64;
        let p = (off - 2) as usize;
        // Named parameters arrive per the host ABI: the first six integer
        // and eight floating-point parameters in argument registers (the
        // prologue spills them into the register save area), the rest on
        // the incoming stack just above the return address. Use the shared
        // planner so the redirect lands on the same placement the caller
        // produced; the parameter's bank rank is the count of same-bank
        // register placements before it (an overflow parameter consumes no
        // register slot).
        let plan = super::plan_param_regs(func.n_params, func.param_fp_mask, abi);
        match plan.placements.get(p) {
            Some(super::ArgPlacement::Stack(soff)) => {
                // Overflow named parameter: the register save area does not
                // cover it. Read from the incoming stack at [rbp + 16 + soff],
                // matching the caller's stack-argument placement.
                16 + *soff as i64
            }
            Some(super::ArgPlacement::FpReg(_)) => {
                let fp_rank = plan.placements[..p]
                    .iter()
                    .filter(|q| matches!(q, super::ArgPlacement::FpReg(_)))
                    .count() as i64;
                reg_save + SYSV_GP_SAVE_BYTES as i64 + fp_rank * 16
            }
            _ => {
                let int_rank = plan.placements[..p]
                    .iter()
                    .filter(|q| matches!(q, super::ArgPlacement::IntReg(_)))
                    .count() as i64;
                reg_save + int_rank * 8
            }
        }
    } else {
        c5_slot_to_fp_offset(off, frame.param_cell_stride, frame.canary_bytes)
    }
}

/// Segment-override prefix byte for an x86 named address space:
/// `%gs:` is 0x65, `%fs:` is 0x64. `None` carries no override.
pub(super) fn seg_prefix(seg: AsmSeg) -> Option<u8> {
    match seg {
        AsmSeg::Gs => Some(0x65),
        AsmSeg::Fs => Some(0x64),
        AsmSeg::None => None,
    }
}

/// Width-dispatched integer load `rd = *(kind*)[base + disp]`
/// (MOV / MOVSXD / MOVSX / MOVZX per C99 6.3.1.3).
fn emit_load_kind_mem(
    code: &mut Vec<u8>,
    kind: LoadKind,
    rd: Reg,
    base: Reg,
    disp: i32,
    seg: Option<u8>,
) {
    // A segment override is a legacy prefix preceding the opcode (and REX).
    if let Some(p) = seg {
        code.push(p);
    }
    match kind {
        LoadKind::I64 => emit_mov_r_mem(code, rd, base, disp),
        LoadKind::I32 => emit_movsxd_r_mem(code, rd, base, disp),
        LoadKind::U32 => super::encode::emit_mov_r32_mem(code, rd, base, disp),
        LoadKind::I16 => emit_movsx_r_mem16(code, rd, base, disp),
        LoadKind::U16 => emit_movzx_r_mem16(code, rd, base, disp),
        LoadKind::I8 => super::encode::emit_movsx_r_mem8(code, rd, base, disp),
        LoadKind::U8 => super::encode::emit_movzx_r_mem8(code, rd, base, disp),
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 => unreachable!(),
    }
}

/// Width-dispatched integer store `*(kind*)[base + disp] = src`.
fn emit_store_kind_mem(
    code: &mut Vec<u8>,
    kind: StoreKind,
    base: Reg,
    disp: i32,
    src: Reg,
    seg: Option<u8>,
) {
    if let Some(p) = seg {
        code.push(p);
    }
    match kind {
        StoreKind::I64 => emit_mov_mem_r(code, base, disp, src),
        StoreKind::I32 => super::encode::emit_mov_mem32_r(code, base, disp, src),
        StoreKind::I16 => super::encode::emit_mov_mem16_r(code, base, disp, src),
        StoreKind::I8 => super::encode::emit_mov_mem8_r(code, base, disp, src),
        StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128 => unreachable!(),
    }
}

/// Mirror a just-stored FP value into `dst` (movapd into a distinct
/// FP register, or a spill store).
fn mirror_fp_dst(code: &mut Vec<u8>, dst: Place, dn: Reg, frame: Frame) {
    match dst {
        Place::FpReg(r) if r != dn.0 => emit_movapd_xmm_xmm(code, Reg(r), dn),
        Place::Spill(_) => fp_spill_dst_to_slot(code, dst, dn, frame),
        _ => {}
    }
}

/// FP load `dst = *(f32/f64*)[base + disp]`. `movss` reads the 4-byte
/// storage into the low dword; a single-precision value (C99 6.3.1.8)
/// stays f32 unless the consumer needs the `cvtss2sd` widening.
/// `movsd` covers the 8-byte `double` lvalue.
#[allow(clippy::too_many_arguments)]
fn emit_load_fp_mem(
    code: &mut Vec<u8>,
    dst: Place,
    kind: LoadKind,
    keep_f32: bool,
    base: Reg,
    disp: i32,
    seg: Option<u8>,
    frame: Frame,
    bound: Option<u32>,
    site: &str,
) -> bool {
    let Some(dd) = fp_or_spill_dst(dst, frame) else {
        return fail(&alloc::format!("{site}: dst not fp reg / spill"));
    };
    if matches!(kind, LoadKind::F80 | LoadKind::F128) {
        if !matches!(kind, LoadKind::F80) {
            return fail(&alloc::format!("{site}: binary128 load on x86-64"));
        }
        // `fld m80` + `fstp m64` narrows the stored x87 value to the
        // f64 the compute path carries, through the red zone (no call
        // intervenes; x87 accesses carry no alignment requirement, so
        // the strict-align compose path does not apply).
        if let Some(p) = seg {
            code.push(p);
        }
        super::encode::emit_fld_m80(code, base, disp);
        super::encode::emit_fstp_m64(code, Reg::RSP, -8);
        emit_movsd_xmm_mem(code, dd, Reg::RSP, -8);
        fp_spill_dst_to_slot(code, dst, dd, frame);
        return true;
    }
    // A bounded access composes in a GPR and crosses via `movq`, which
    // zeroes the register above the composed bytes exactly as the
    // `movss` / `movsd` it replaces does.
    if let Some(a) = bound {
        let width = if matches!(kind, LoadKind::F32) { 4 } else { 8 };
        let acc = emit_narrow_compose(code, base, disp, width, a, &[]);
        super::encode::emit_movq_xmm_r(code, dd, acc);
        if matches!(kind, LoadKind::F32) && !keep_f32 {
            emit_cvtss2sd(code, dd, dd);
        }
        fp_spill_dst_to_slot(code, dst, dd, frame);
        return true;
    }
    // Segment override precedes the mandatory SSE prefix and the opcode.
    if let Some(p) = seg {
        code.push(p);
    }
    if matches!(kind, LoadKind::F32) {
        emit_movss_xmm_mem(code, dd, base, disp);
        if !keep_f32 {
            emit_cvtss2sd(code, dd, dd);
        }
    } else {
        emit_movsd_xmm_mem(code, dd, base, disp);
    }
    fp_spill_dst_to_slot(code, dst, dd, frame);
    true
}

/// FP store `*(f32/f64*)[base + disp] = value`. A single-precision
/// value (C99 6.3.1.8) writes directly via `movss`; a wider f64 value
/// (a `double` assigned to a `float` the walker didn't pre-narrow)
/// narrows via `cvtsd2ss` into the second FP scratch first so `dn` (which may
/// be an allocator-held xmm the result Place expects) survives.
/// `movsd` covers the 8-byte `double` store. The stored value also
/// feeds `dst` per the c5 store-leaves-value rule (C99 6.5.16p3).
#[allow(clippy::too_many_arguments)]
fn emit_store_fp_mem(
    code: &mut Vec<u8>,
    dst: Place,
    value_place: Place,
    value_is_f32: bool,
    kind: StoreKind,
    base: Reg,
    disp: i32,
    seg: Option<u8>,
    frame: Frame,
    bound: Option<u32>,
    site: &str,
) -> bool {
    let Some(dn) = materialize_fp(code, value_place, Reg(frame.fp_scratch[0]), frame) else {
        return fail(&alloc::format!(
            "{site}: value not fp reg / spill / int reg"
        ));
    };
    if matches!(kind, StoreKind::F80 | StoreKind::F128) {
        if !matches!(kind, StoreKind::F80) {
            return fail(&alloc::format!("{site}: binary128 store on x86-64"));
        }
        // `fld m64` widens the f64 exactly; `fstp m80` writes the 10
        // significant bytes and leaves the object's padding untouched,
        // as gcc's stores do. The round trip rides the red zone.
        emit_movsd_mem_xmm(code, Reg::RSP, -8, dn);
        super::encode::emit_fld_m64(code, Reg::RSP, -8);
        if let Some(p) = seg {
            code.push(p);
        }
        super::encode::emit_fstp_m80(code, base, disp);
        mirror_fp_dst(code, dst, dn, frame);
        return true;
    }
    // Emit the segment override immediately before the store opcode, past any
    // value materialisation / narrowing the branches do first.
    let push_seg = |code: &mut Vec<u8>| {
        if let Some(p) = seg {
            code.push(p);
        }
    };
    let narrowed = |code: &mut Vec<u8>, src: Reg, width: u32, a: u32| {
        super::encode::emit_movq_r_xmm(code, SCRATCH_R11, src);
        emit_narrow_store(code, SCRATCH_R11, base, disp, width, a);
    };
    if matches!(kind, StoreKind::F32) {
        let src = if value_is_f32 {
            dn
        } else {
            emit_cvtsd2ss(code, Reg(frame.fp_scratch[1]), dn);
            Reg(frame.fp_scratch[1])
        };
        match bound {
            Some(a) => narrowed(code, src, 4, a),
            None => {
                push_seg(code);
                emit_movss_mem_xmm(code, base, disp, src);
            }
        }
    } else {
        match bound {
            Some(a) => narrowed(code, dn, 8, a),
            None => {
                push_seg(code);
                emit_movsd_mem_xmm(code, base, disp, dn);
            }
        }
    }
    mirror_fp_dst(code, dst, dn, frame);
    true
}

/// Single-instruction rbp-relative load for `Inst::LoadLocal`.
/// The c5 slot offset folds into the load's ModR/M disp
/// directly, skipping the `LocalAddr` materialisation the
/// `LocalAddr` + `Load` pair would have required.
/// Base register and byte displacement for addressing a local slot. An
/// over-aligned automatic object lives in the over-aligned region: at
/// `[rsp + region_off]` when the prologue realigned rsp (alignment above 16),
/// at `[rbp + align_region_off + region_off]` for the static 16-aligned
/// placement; every other slot is `[rbp + local_slot_off]` (C11 6.7.5).
pub(super) fn local_slot_base_disp(
    off: i64,
    func: &FunctionSsa,
    frame: Frame,
    abi: super::Abi,
) -> (Reg, i64) {
    if off < 0
        && (frame.align_region_off != 0 || frame.realign_align > 0)
        && let Some(&(_, region_off)) = func.over_aligned.iter().find(|&&(s, _)| s == off)
    {
        if frame.align_region_off != 0 {
            (Reg::RBP, frame.align_region_off + region_off)
        } else {
            (Reg::RSP, region_off)
        }
    } else {
        (Reg::RBP, local_slot_off(off, func, frame, abi))
    }
}

pub(super) fn emit_load_local(
    code: &mut Vec<u8>,
    dst: Place,
    off: i64,
    kind: LoadKind,
    keep_f32: bool,
    frame: Frame,
    func: &FunctionSsa,
    abi: super::Abi,
) -> bool {
    let (base, bytes) = local_slot_base_disp(off, func, frame, abi);
    let Ok(disp) = i32::try_from(bytes) else {
        return fail("LoadLocal: offset doesn't fit in disp32");
    };
    if matches!(
        kind,
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128
    ) {
        return emit_load_fp_mem(
            code,
            dst,
            kind,
            keep_f32,
            base,
            disp,
            None,
            frame,
            None,
            "LoadLocal",
        );
    }
    let Some(rd) = int_or_spill_dst(dst) else {
        return fail("LoadLocal: dst not int reg / spill");
    };
    emit_load_kind_mem(code, kind, rd, base, disp, None);
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

/// Single-instruction rbp-relative store for `Inst::StoreLocal`.
/// Mirrors [`emit_load_local`]; the c5 store ops leave the
/// stored value in the accumulator, so the destination `Place`
/// receives a copy after the store lands.
pub(super) fn emit_store_local(
    code: &mut Vec<u8>,
    dst: Place,
    _v: super::super::ir::ValueId,
    off: i64,
    value: u32,
    kind: StoreKind,
    alloc: &Allocation,
    frame: Frame,
    func: &FunctionSsa,
    abi: super::Abi,
) -> bool {
    let (base, bytes) = local_slot_base_disp(off, func, frame, abi);
    let Ok(disp) = i32::try_from(bytes) else {
        return fail("StoreLocal: offset doesn't fit in disp32");
    };
    let value_place = place_of(alloc, value);
    if matches!(
        kind,
        StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128
    ) {
        // Mirrors the `Store` FP path so a mem2reg-promoted slot
        // round-trips identically to the prior address-taken
        // `LocalAddr + Store` form.
        return emit_store_fp_mem(
            code,
            dst,
            value_place,
            alloc.is_f32(value),
            kind,
            base,
            disp,
            None,
            frame,
            None,
            "StoreLocal",
        );
    }
    // c5 spills an FP-typed accumulator into a local temp through
    // the store-local path (the bit pattern fits 8 bytes either
    // way), so an FpReg value bridges through `movq r, xmm` into
    // a GPR before the store; otherwise it routes through the
    // normal int materialisation.
    let rv = if let Place::FpReg(xr) = value_place {
        // The FP value bridges through a GPR for the integer store. r10
        // is reserved outside both allocator banks and holds nothing
        // live on this path (the store reads only `value`), so it is
        // always available -- a caller-saved pick can come up empty
        // under saturation.
        let scratch = SCRATCH_R10;
        super::encode::emit_movq_r_xmm(code, scratch, Reg(xr));
        scratch
    } else {
        match materialize_int(code, value_place, SCRATCH_R10, frame) {
            Some(r) => r,
            None => return fail("StoreLocal: value not int reg / spill"),
        }
    };
    // Store the low `kind`-width bytes; the accumulator below keeps
    // the full source value, matching the c5 rule that an
    // assignment expression yields the stored value before any
    // re-narrowing on read-back (C99 6.5.16p3).
    emit_store_kind_mem(code, kind, base, disp, rv, None);
    // Mirror the store value into the destination Place.
    mirror_int_dst(code, dst, rv, frame);
    true
}

/// Lower `Inst::LoadIndexed`: `dst = *(kind*)(base + index * scale)`.
/// Emitted as a single MOVSXD/MOV/MOVSX/MOVZX with SIB-byte
/// addressing (`[base + index * scale]`). F32 indexed loads aren't
/// a shape the walker produces today.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_load_indexed(
    code: &mut Vec<u8>,
    dst: Place,
    base: u32,
    index: u32,
    scale: u8,
    kind: LoadKind,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    if matches!(
        kind,
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128
    ) {
        return fail("LoadIndexed: FP not implemented");
    }
    let expected_scale: u8 = match kind {
        LoadKind::I64 => 8,
        LoadKind::I32 | LoadKind::U32 => 4,
        LoadKind::I16 | LoadKind::U16 => 2,
        LoadKind::I8 | LoadKind::U8 => 1,
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 => unreachable!(),
    };
    if scale != expected_scale {
        return fail("LoadIndexed: scale doesn't match access width");
    }
    let base_place = place_of(alloc, base);
    let index_place = place_of(alloc, index);
    let Some(regs) = materialize_int_operands_distinct(code, &[base_place, index_place], frame)
    else {
        return fail("LoadIndexed: base / index not int reg / spill");
    };
    let (rbase, rindex) = (regs[0], regs[1]);
    let Some(rd) = int_or_spill_dst(dst) else {
        return fail("LoadIndexed: dst not int reg / spill");
    };
    match kind {
        LoadKind::I64 => super::encode::emit_mov_r_sib(code, rd, rbase, rindex, scale),
        LoadKind::I32 => super::encode::emit_movsxd_r_sib(code, rd, rbase, rindex, scale),
        LoadKind::U32 => super::encode::emit_mov_r32_sib(code, rd, rbase, rindex, scale),
        LoadKind::I16 => super::encode::emit_movsx_r_sib16(code, rd, rbase, rindex, scale),
        LoadKind::U16 => super::encode::emit_movzx_r_sib16(code, rd, rbase, rindex, scale),
        LoadKind::I8 => super::encode::emit_movsx_r_sib8(code, rd, rbase, rindex, scale),
        LoadKind::U8 => super::encode::emit_movzx_r_sib8(code, rd, rbase, rindex, scale),
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 => unreachable!(),
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

/// Lower `Inst::StoreIndexed`: `*(kind*)(base + index * scale) = value`.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_store_indexed(
    code: &mut Vec<u8>,
    dst: Place,
    base: u32,
    index: u32,
    scale: u8,
    value: u32,
    kind: StoreKind,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    if matches!(
        kind,
        StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128
    ) {
        return fail("StoreIndexed: FP not implemented");
    }
    let expected_scale: u8 = match kind {
        StoreKind::I64 => 8,
        StoreKind::I32 => 4,
        StoreKind::I16 => 2,
        StoreKind::I8 => 1,
        StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128 => unreachable!(),
    };
    if scale != expected_scale {
        return fail("StoreIndexed: scale doesn't match access width");
    }
    let base_place = place_of(alloc, base);
    let index_place = place_of(alloc, index);
    let value_place = place_of(alloc, value);
    let Some(regs) = materialize_int_operands_distinct(code, &[base_place, index_place], frame)
    else {
        return fail("StoreIndexed: base / index not int reg / spill");
    };
    let (rbase, rindex) = (regs[0], regs[1]);
    // The store also needs the value in a register distinct from the
    // base and index. r10 / r11 are the only reserved scratch; when both
    // already hold the spilled base and index there is none left, so the
    // effective address is precomputed into r10 (consuming the base and
    // index registers) and the freed r11 receives the value.
    let fp_value = matches!(value_place, Place::FpReg(_)) && matches!(kind, StoreKind::I64);
    let free = [SCRATCH_R10, SCRATCH_R11]
        .into_iter()
        .find(|s| s.0 != rbase.0 && s.0 != rindex.0);
    let mut precomputed_addr: Option<Reg> = None;
    let rv = if fp_value {
        let Place::FpReg(xr) = value_place else {
            unreachable!()
        };
        let target = match free {
            Some(s) => s,
            None => {
                super::encode::emit_lea_r_sib(code, SCRATCH_R10, rbase, rindex, scale);
                precomputed_addr = Some(SCRATCH_R10);
                SCRATCH_R11
            }
        };
        super::encode::emit_movq_r_xmm(code, target, Reg(xr));
        target
    } else if let Place::IntReg(r) = value_place {
        Reg(r)
    } else {
        match free {
            Some(s) => match materialize_int(code, value_place, s, frame) {
                Some(r) => r,
                None => return fail("StoreIndexed: value not int reg / spill"),
            },
            None => {
                super::encode::emit_lea_r_sib(code, SCRATCH_R10, rbase, rindex, scale);
                precomputed_addr = Some(SCRATCH_R10);
                match materialize_int(code, value_place, SCRATCH_R11, frame) {
                    Some(r) => r,
                    None => return fail("StoreIndexed: value not int reg / spill"),
                }
            }
        }
    };
    match precomputed_addr {
        Some(addr) => match kind {
            StoreKind::I64 => super::encode::emit_mov_mem_r(code, addr, 0, rv),
            StoreKind::I32 => super::encode::emit_mov_mem_r32(code, addr, 0, rv),
            StoreKind::I16 => super::encode::emit_mov_mem_r16(code, addr, 0, rv),
            StoreKind::I8 => super::encode::emit_mov_mem_r8(code, addr, 0, rv),
            StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128 => unreachable!(),
        },
        None => match kind {
            StoreKind::I64 => super::encode::emit_mov_sib_r(code, rbase, rindex, scale, rv),
            StoreKind::I32 => super::encode::emit_mov_sib_r32(code, rbase, rindex, scale, rv),
            StoreKind::I16 => super::encode::emit_mov_sib_r16(code, rbase, rindex, scale, rv),
            StoreKind::I8 => super::encode::emit_mov_sib_r8(code, rbase, rindex, scale, rv),
            StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128 => unreachable!(),
        },
    }
    // c5 store-op leaves the value in the accumulator.
    mirror_int_dst(code, dst, rv, frame);
    true
}

pub(super) fn emit_load(
    code: &mut Vec<u8>,
    dst: Place,
    addr: u32,
    disp: i32,
    kind: LoadKind,
    seg: Option<u8>,
    keep_f32: bool,
    alloc: &Allocation,
    frame: Frame,
    bound: Option<u32>,
) -> bool {
    let addr_place = place_of(alloc, addr);
    // Spill-tolerant base materialisation: load a spilled address
    // into r10 first, write into rd next, then spill rd to its
    // slot if the allocator wants it parked there. Matches the
    // aarch64 module's primary-scratch shape.
    let Some(base) = materialize_int(code, addr_place, SCRATCH_R10, frame) else {
        return fail("Load: addr Place not int reg / spill");
    };
    if matches!(
        kind,
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128
    ) {
        return emit_load_fp_mem(
            code, dst, kind, keep_f32, base, disp, seg, frame, bound, "Load",
        );
    }
    let Some(rd) = int_or_spill_dst(dst) else {
        return fail("Load: dst not int reg / spill");
    };
    match bound {
        Some(a) => emit_narrow_load(code, rd, base, disp, kind, a),
        None => emit_load_kind_mem(code, kind, rd, base, disp, seg),
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

pub(super) fn emit_store(
    code: &mut Vec<u8>,
    dst: Place,
    _v: super::super::ir::ValueId,
    addr: u32,
    disp: i32,
    value: u32,
    kind: StoreKind,
    seg: Option<u8>,
    alloc: &Allocation,
    frame: Frame,
    bound: Option<u32>,
) -> bool {
    let addr_place = place_of(alloc, addr);
    let value_place = place_of(alloc, value);
    // Scratch for the addr-Place spill load (the materialise helper
    // only writes to it when addr_place is a Spill; an IntReg place
    // returns the underlying reg directly). r10 is reserved outside
    // both allocator banks, so it never aliases the value's
    // allocator-chosen register and never holds a live SSA value the
    // spill load could clobber -- a caller-saved pick can come up
    // empty under saturation. The value-Place uses the separate
    // reserved r11 scratch below, disjoint from r10.
    let addr_scratch = SCRATCH_R10;
    let Some(base) = materialize_int(code, addr_place, addr_scratch, frame) else {
        return fail("Store: addr Place not int reg / spill");
    };
    if matches!(
        kind,
        StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128
    ) {
        return emit_store_fp_mem(
            code,
            dst,
            value_place,
            alloc.is_f32(value),
            kind,
            base,
            disp,
            seg,
            frame,
            bound,
            "Store",
        );
    }
    // The value scratch must be disjoint from `base` and must not be a
    // register the allocator parked a value live across this Store in.
    // The earlier fixed `RCX` fallback (used when `base` landed in
    // SCRATCH_R10) clobbered a long-lived value the allocator had
    // placed in rcx -- e.g. a base pointer read by a later indexed
    // load -- because rcx carries SSA values once the bank flattening
    // lets the allocator use it. A spilled value materialised into rcx
    // then overwrote that live value before its last use. `base` is
    // either the addr register place or the live-aware addr scratch,
    // both inside the allocator's caller-saved bank; r11 is reserved
    // outside both allocator banks (see the `SCRATCH_R10` note) so it
    // can never be `base` and never holds a live allocator value, which
    // makes it a safe value scratch under any register pressure. A
    // value-Place already in an int register needs no scratch and
    // `materialize_int` returns it directly.
    let value_scratch = match value_place {
        Place::IntReg(r) => Reg(r),
        _ => SCRATCH_R11,
    };
    let Some(rs) = materialize_int(code, value_place, value_scratch, frame) else {
        return fail("Store: value Place not int reg / spill");
    };
    match bound {
        Some(a) => emit_narrow_store(code, rs, base, disp, int_store_width(kind), a),
        None => emit_store_kind_mem(code, kind, base, disp, rs, seg),
    }
    // Stored value also feeds dst when the allocator wants it
    // parked (Store ops leave the written value in the
    // accumulator per the c5 stack-machine semantics).
    match dst {
        Place::IntReg(r) if r != rs.0 => emit_mov_rr(code, Reg(r), rs),
        Place::Spill(_) => spill_dst_to_slot(code, dst, rs, frame),
        _ => {}
    }
    true
}

pub(super) fn emit_imm_data(
    code: &mut Vec<u8>,
    dst: Place,
    offset: i64,
    data_fixups: &mut Vec<DataFixup>,
    frame: Frame,
) -> bool {
    let Some(rd) = int_or_spill_dst(dst) else {
        return fail("ImmData: dst not int reg / spill");
    };
    let instr_offset = code.len();
    data_fixups.push(DataFixup {
        instr_offset,
        data_offset: offset as u64,
        part: AddrPart::Whole,
    });
    // `lea rd, [rip + 0]` placeholder; the writer patches the
    // disp32 once the data segment's runtime address is known.
    super::encode::emit_lea_r_rip32(code, rd, 0);
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

pub(super) fn emit_imm_code(
    code: &mut Vec<u8>,
    dst: Place,
    target_ent_pc: usize,
    pending_func_fixups: &mut Vec<(usize, usize)>,
    frame: Frame,
) -> bool {
    let Some(rd) = int_or_spill_dst(dst) else {
        return fail("ImmCode: dst not int reg / spill");
    };
    let instr_offset = code.len();
    pending_func_fixups.push((instr_offset, target_ent_pc));
    super::encode::emit_lea_r_rip32(code, rd, 0);
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

/// `Inst::ImmExtCode` -- `lea rd, [rip+disp32]` taking the
/// address of a dynamically-imported function. The disp32 resolves
/// to the import's shared stub (the same `jmp [GOT]` a call to the
/// import reaches), so `&strcmp` yields the stub address. Records an
/// `is_addr` PLT-call fixup at the `lea`'s instruction offset; the
/// disp32 sits three bytes in (REX + opcode + modrm).
pub(super) fn emit_imm_ext_code(
    code: &mut Vec<u8>,
    dst: Place,
    binding_idx: i64,
    plt_call_fixups: &mut Vec<PltCallFixup>,
    imports: &super::ResolvedImports,
    frame: Frame,
) -> bool {
    let Some(rd) = int_or_spill_dst(dst) else {
        return fail("ImmExtCode: dst not int reg / spill");
    };
    let Some(import_index) = imports.index_of_binding(binding_idx) else {
        return fail("ImmExtCode: binding index has no resolved import");
    };
    plt_call_fixups.push(PltCallFixup {
        instr_offset: code.len(),
        import_index,
        is_tail: false,
        is_addr: true,
    });
    super::encode::emit_lea_r_rip32(code, rd, 0);
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

/// One load / store pair of `width` bytes (8, 4, 2 or 1) moving
/// `[src + disp]` to `[dst + disp]` through `temp`.
pub(super) fn emit_copy_unit(
    code: &mut Vec<u8>,
    width: u32,
    temp: Reg,
    src: Reg,
    dst: Reg,
    disp: i32,
) {
    emit_load_unit(code, width, temp, src, disp);
    emit_store_unit(code, width, dst, disp, temp);
}

/// Store the low `width` bytes (8, 4, 2 or 1) of `src` to
/// `[base + disp]`.
pub(super) fn emit_store_unit(code: &mut Vec<u8>, width: u32, base: Reg, disp: i32, src: Reg) {
    match width {
        8 => emit_mov_mem_r(code, base, disp, src),
        4 => super::encode::emit_mov_mem32_r(code, base, disp, src),
        2 => super::encode::emit_mov_mem16_r(code, base, disp, src),
        _ => super::encode::emit_mov_mem8_r(code, base, disp, src),
    }
}

/// Zero-extending load of `width` bytes (8, 4, 2 or 1) from
/// `[base + disp]` into `dst`.
pub(super) fn emit_load_unit(code: &mut Vec<u8>, width: u32, dst: Reg, base: Reg, disp: i32) {
    match width {
        8 => emit_mov_r_mem(code, dst, base, disp),
        4 => super::encode::emit_mov_r32_mem(code, dst, base, disp),
        2 => super::encode::emit_movzx_r_mem16(code, dst, base, disp),
        _ => super::encode::emit_movzx_r_mem8(code, dst, base, disp),
    }
}

/// Load `width` bytes at `[base + disp]` into the integer register
/// `dst`, using no access wider than `align` proves at that address
/// (see [`super::super::access_pieces`]). `tmp` holds each narrow
/// piece; it must differ from `base` and `dst`, and stays untouched
/// when one access suffices -- the only case in which `dst` may alias
/// `base`.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_agg_load_int(
    code: &mut Vec<u8>,
    dst: Reg,
    base: Reg,
    disp: i32,
    width: u32,
    align: u32,
    strict_align: bool,
    tmp: Reg,
) {
    let off = disp.max(0) as u32;
    for (i, (o, w)) in super::super::access_pieces(off, width, align, strict_align).enumerate() {
        let at = disp + (o - off) as i32;
        if i == 0 {
            emit_load_unit(code, w, dst, base, at);
            continue;
        }
        debug_assert!(dst.0 != base.0 && tmp.0 != base.0 && tmp.0 != dst.0);
        emit_load_unit(code, w, tmp, base, at);
        emit_shift_ri(code, Mnem::Shl, 8, tmp, ((o - off) * 8) as u8);
        emit_rr(code, Mnem::Or, 8, dst, tmp);
    }
}

/// As [`emit_agg_load_int`] with an SSE register destination: the
/// eightbyte composes in `tmp` and moves across with `movq`. The
/// composition's second register is borrowed from the stack, the
/// marshal having no third free scratch; nothing between the push and
/// the pop addresses `rsp`. `base` and `tmp` are the marshal's
/// reserved scratches or argument registers, never `rax`.
pub(super) fn emit_agg_load_sse(
    code: &mut Vec<u8>,
    dst: Reg,
    base: Reg,
    disp: i32,
    align: u32,
    strict_align: bool,
    tmp: Reg,
) {
    if super::super::access_unit(disp.max(0) as u32, 8, align, strict_align) == 8 {
        emit_movsd_xmm_mem(code, dst, base, disp);
        return;
    }
    debug_assert!(base.0 != Reg::RAX.0 && tmp.0 != Reg::RAX.0);
    emit_push_r(code, Reg::RAX);
    emit_agg_load_int(code, tmp, base, disp, 8, align, strict_align, Reg::RAX);
    super::encode::emit_movq_xmm_r(code, dst, tmp);
    emit_pop_r(code, Reg::RAX);
}

/// Alignment a scalar access must respect, or `None` when it may keep
/// its natural width: an access carries a bound only where the walker
/// proved one, and only `-mstrict-align` acts on it.
pub(super) fn narrow_bound(align: u8, abi: super::Abi) -> Option<u32> {
    (abi.strict_align && align != 0).then_some(align as u32)
}

/// Register a narrowed scalar access borrows for its piece temp. Each
/// candidate is in the allocator's caller-saved bank, so it is pushed
/// and popped across the sequence; nothing in between addresses `rsp`.
/// Mirrors the reservation `emit_mcpy` makes.
fn narrow_borrow(avoid: &[u8]) -> Reg {
    for cand in [Reg::RAX, Reg::RCX, Reg::RDX, Reg::RSI, Reg::RDI] {
        if !avoid.contains(&cand.0) {
            return cand;
        }
    }
    unreachable!("narrow access: no free borrow register")
}

/// Byte width of an integer load kind, and whether it sign-extends.
fn int_load_shape(kind: LoadKind) -> (u32, bool) {
    match kind {
        LoadKind::I64 => (8, false),
        LoadKind::I32 => (4, true),
        LoadKind::U32 => (4, false),
        LoadKind::I16 => (2, true),
        LoadKind::U16 => (2, false),
        LoadKind::I8 => (1, true),
        LoadKind::U8 => (1, false),
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 => (0, false),
    }
}

/// Byte width of an integer store kind.
fn int_store_width(kind: StoreKind) -> u32 {
    match kind {
        StoreKind::I64 => 8,
        StoreKind::I32 => 4,
        StoreKind::I16 => 2,
        StoreKind::I8 => 1,
        StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128 => 0,
    }
}

/// Compose `width` bytes at `[base + disp]`, whose address is proven
/// only `align`-aligned, into SCRATCH_R11 and return it. The caller
/// must not have `base` in r11.
fn emit_narrow_compose(
    code: &mut Vec<u8>,
    base: Reg,
    disp: i32,
    width: u32,
    align: u32,
    avoid: &[u8],
) -> Reg {
    let acc = SCRATCH_R11;
    let mut blocked = alloc::vec![base.0, acc.0];
    blocked.extend_from_slice(avoid);
    let tmp = narrow_borrow(&blocked);
    emit_push_r(code, tmp);
    emit_agg_load_int(code, acc, base, disp, width, align, true, tmp);
    emit_pop_r(code, tmp);
    acc
}

/// Lower an integer load bounded by `align` into `rd`, sign-extending
/// the composed value when the kind is signed.
fn emit_narrow_load(code: &mut Vec<u8>, rd: Reg, base: Reg, disp: i32, kind: LoadKind, align: u32) {
    let (width, signed) = int_load_shape(kind);
    let acc = emit_narrow_compose(code, base, disp, width, align, &[rd.0]);
    match (signed, width) {
        (true, 4) => super::encode::emit_movsxd_r_r(code, rd, acc),
        (true, 2) => super::encode::emit_movsx_r_r16(code, rd, acc),
        (true, 1) => super::encode::emit_movsx_r_r8(code, rd, acc),
        _ if rd.0 != acc.0 => emit_mov_rr(code, rd, acc),
        _ => {}
    }
}

/// Store companion to [`emit_narrow_load`]: write the low `width`
/// bytes of `rs` to `[base + disp]` in `align`-wide pieces.
fn emit_narrow_store(code: &mut Vec<u8>, rs: Reg, base: Reg, disp: i32, width: u32, align: u32) {
    let tmp = narrow_borrow(&[base.0, rs.0]);
    emit_push_r(code, tmp);
    let off = disp.max(0) as u32;
    for (i, (o, w)) in super::super::access_pieces(off, width, align, true).enumerate() {
        let at = disp + (o - off) as i32;
        let src = if i == 0 {
            rs
        } else {
            emit_mov_rr(code, tmp, rs);
            emit_shift_ri(code, Mnem::Shr, 8, tmp, ((o - off) * 8) as u8);
            tmp
        };
        emit_store_unit(code, w, base, at, src);
    }
    emit_pop_r(code, tmp);
}
