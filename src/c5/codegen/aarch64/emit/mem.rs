use super::encode::{
    LDR_D, LDR_Q, LDR_S, LDR_W, LDR_X, LDRB, LDRH, LDRSB, LDRSH, LDRSW, MemOff, MemOp, STR_D,
    STR_Q, STR_S, STR_W, STR_X, STRB, STRH, enc_mem,
};
use super::*;

/// SP-relative byte offset of allocator spill `slot`.
pub(super) fn spill_off(frame: Frame, slot: u32) -> u32 {
    super::ssa::emit_common::spill_slot_sp_offset(frame.frame_bytes, frame.alloc_spill_base, slot)
}

/// A 128-bit spill occupies its slot and the one below, addressed at the lower.
pub(super) fn v128_spill_off(frame: Frame, slot: u32) -> u32 {
    spill_off(frame, slot + 1)
}

/// An `ADD` / `SUB` (immediate) encoder: `(rd, rn, imm)`.
type AddSubImm = fn(Reg, Reg, u32) -> u32;

/// `dst = base + disp`; past 24 bits `dst` must differ from `base`.
fn emit_reg_disp(code: &mut Vec<u8>, dst: Reg, base: Reg, disp: i64) {
    let (off, sub) = (disp.unsigned_abs(), disp < 0);
    if off >= 1 << 24 {
        assert_ne!(dst, base, "address scratch aliases its base");
        super::encode::load_imm64(code, dst, off);
        let word = match (sub, base.0 == 31) {
            (false, false) => super::encode::enc_add_reg(dst, base, dst),
            (false, true) => super::encode::enc_add_ext_reg(dst, base, dst),
            (true, false) => super::encode::enc_sub_reg(dst, base, dst),
            (true, true) => super::encode::enc_sub_ext_reg(dst, base, dst),
        };
        emit(code, word);
        return;
    }
    let (imm, imm_lsl12): (AddSubImm, AddSubImm) = if sub {
        (enc_sub_imm, super::encode::enc_sub_imm_lsl12)
    } else {
        (enc_add_imm, super::encode::enc_add_imm_lsl12)
    };
    let (hi, lo) = ((off >> 12) as u32, (off & 0xfff) as u32);
    if hi == 0 {
        emit(code, imm(dst, base, lo));
        return;
    }
    emit(code, imm_lsl12(dst, base, hi));
    if lo != 0 {
        emit(code, imm(dst, dst, lo));
    }
}

/// Materialise `sp + off` into `dst`.
pub(super) fn emit_sp_plus_off(code: &mut Vec<u8>, dst: Reg, off: u32) {
    emit_reg_disp(code, dst, Reg(31), off.into());
}

/// Materialise `fp + off` into `dst`.
pub(super) fn emit_fp_plus_off(code: &mut Vec<u8>, dst: Reg, off: u32) {
    emit_reg_disp(code, dst, Reg(29), off.into());
}

/// Materialise `fp - delta` into `dst`.
pub(super) fn emit_fp_minus_off(code: &mut Vec<u8>, dst: Reg, delta: u32) {
    emit_reg_disp(code, dst, Reg(29), -i64::from(delta));
}

/// Base and offset of an `op` access at `[base + disp]`; `t` differs from `base`.
fn mem_base(code: &mut Vec<u8>, op: MemOp, base: Reg, disp: i64, t: Reg) -> (Reg, MemOff) {
    if let Some(off) = op.offset(disp) {
        return (base, off);
    }
    emit_reg_disp(code, t, base, disp);
    (t, op.scaled(0))
}

/// `op` between `rt` and `[base + disp]`; a store's `t` also differs from `rt`.
pub(crate) fn emit_mem(code: &mut Vec<u8>, op: MemOp, rt: u8, base: Reg, disp: i64, t: Reg) {
    let (base, off) = mem_base(code, op, base, disp, t);
    emit(code, enc_mem(op, rt, base, off));
}

/// Base and offset of a strict-alignment transfer at `[base + disp]`: a
/// rebase moves by a multiple of `align`, which keeps each piece's width.
pub(crate) fn bound_base(
    code: &mut Vec<u8>,
    base: Reg,
    disp: i64,
    width: u32,
    word: u32,
    align: u32,
    t: Reg,
) -> (Reg, u32) {
    let scaled = |off: u32| {
        (0..width).step_by(word as usize).all(|k| {
            super::super::access_pieces(off + k, word, align, true).all(|(o, w)| o / w < 4096)
        })
    };
    if let Ok(off) = u32::try_from(disp)
        && scaled(off)
    {
        return (base, off);
    }
    let low = disp.rem_euclid(i64::from(super::super::offset_align(align, 0)));
    emit_reg_disp(code, t, base, disp - low);
    (t, low as u32)
}

fn other_ip(r: Reg) -> Reg {
    if r.0 == 16 { Reg(17) } else { Reg(16) }
}

/// SP-relative 8-byte load, addressing through `rt` past the offset forms.
pub(super) fn emit_sp_ldr_x(code: &mut Vec<u8>, rt: Reg, off: u32) {
    emit_mem(code, LDR_X, rt.0, Reg(31), off.into(), rt);
}

/// SP-relative 8-byte store where neither IP scratch is live.
pub(super) fn emit_sp_str_x_auto(code: &mut Vec<u8>, rt: Reg, off: u32) {
    emit_mem(code, STR_X, rt.0, Reg(31), off.into(), other_ip(rt));
}

/// Base and displacement of the spill byte `sp_off` bytes above the static sp.
fn spill_base(frame: Frame, sp_off: u32) -> (Reg, i64) {
    if frame.dynamic_sp {
        (Reg(29), i64::from(sp_off) - i64::from(frame.frame_bytes))
    } else {
        (Reg(31), sp_off.into())
    }
}

pub(super) fn emit_spill_ldr_x(code: &mut Vec<u8>, frame: Frame, rt: Reg, sp_off: u32) {
    let (base, disp) = spill_base(frame, sp_off);
    emit_mem(code, LDR_X, rt.0, base, disp, rt);
}

/// Spill-slot 8-byte store of `rt`; `addr_scratch` differs from `rt`.
pub(super) fn emit_spill_str_x(
    code: &mut Vec<u8>,
    frame: Frame,
    rt: Reg,
    sp_off: u32,
    addr_scratch: Reg,
) {
    let (base, disp) = spill_base(frame, sp_off);
    emit_mem(code, STR_X, rt.0, base, disp, addr_scratch);
}

/// `emit_spill_str_x` with the IP-pool scratch that differs from `rt`.
pub(super) fn emit_spill_str_x_auto(code: &mut Vec<u8>, frame: Frame, rt: Reg, sp_off: u32) {
    emit_spill_str_x(code, frame, rt, sp_off, other_ip(rt));
}

/// Spill-slot 8-byte store where only `borrow`, a live register pushed around
/// the store, can carry the address (both IP scratches hold cycle values).
pub(super) fn emit_spill_str_x_borrow(
    code: &mut Vec<u8>,
    frame: Frame,
    rt: Reg,
    sp_off: u32,
    borrow: Reg,
) {
    let (base, disp) = spill_base(frame, sp_off);
    if let Some(off) = STR_X.offset(disp) {
        emit(code, enc_mem(STR_X, rt.0, base, off));
        return;
    }
    debug_assert_ne!(rt, borrow, "spill str borrow: borrow aliases data");
    emit(code, super::encode::enc_str_pre(borrow, Reg(31), -16));
    let shift = if base.0 == 31 { 16 } else { 0 };
    emit_mem(code, STR_X, rt.0, base, disp + shift, borrow);
    emit(code, super::encode::enc_ldr_post(borrow, Reg(31), 16));
}

/// Spill-slot 8-byte FP load into d-reg `dt`; `addr_scratch` is a GPR.
fn emit_spill_ldr_d(code: &mut Vec<u8>, frame: Frame, dt: u8, sp_off: u32, addr_scratch: Reg) {
    let (base, disp) = spill_base(frame, sp_off);
    emit_mem(code, LDR_D, dt, base, disp, addr_scratch);
}

/// Spill-slot FP store / load with x16 as the address scratch.
pub(super) fn emit_spill_str_d_auto(code: &mut Vec<u8>, frame: Frame, dt: u8, sp_off: u32) {
    let (base, disp) = spill_base(frame, sp_off);
    emit_mem(code, STR_D, dt, base, disp, Reg(16));
}

pub(super) fn emit_spill_ldr_d_auto(code: &mut Vec<u8>, frame: Frame, dt: u8, sp_off: u32) {
    emit_spill_ldr_d(code, frame, dt, sp_off, Reg(16));
}

pub(super) fn emit_spill_ldr_q(
    code: &mut Vec<u8>,
    frame: Frame,
    qt: u8,
    sp_off: u32,
    addr_scratch: Reg,
) {
    let (base, disp) = spill_base(frame, sp_off);
    emit_mem(code, LDR_Q, qt, base, disp, addr_scratch);
}

pub(super) fn emit_spill_str_q(
    code: &mut Vec<u8>,
    frame: Frame,
    qt: u8,
    sp_off: u32,
    addr_scratch: Reg,
) {
    let (base, disp) = spill_base(frame, sp_off);
    emit_mem(code, STR_Q, qt, base, disp, addr_scratch);
}

/// The d-register an FP result lands in: the allocator's, or a scratch
/// outside its pool when the value spills.
pub(super) fn fp_or_spill_dst(dst: Place, frame: Frame) -> Option<u8> {
    match dst {
        Place::FpReg(r) => Some(r),
        Place::Spill(_) => Some(frame.fp_scratch[0]),
        _ => None,
    }
}

/// An address register the binary128 sequences can hold across their
/// borrow of the narrow-access pool.
fn addr_outside_borrows(code: &mut Vec<u8>, rn: Reg, scratch: &ScratchPool) -> Reg {
    if !NARROW_BORROW.contains(&rn.0) {
        return rn;
    }
    emit_mov_reg(code, scratch.primary, rn);
    scratch.primary
}

/// `Inst::TlsAddr`: the per-target TLS access -- Linux variant 1
/// (TPIDR_EL0 + TCB + offset), Windows through the TEB's TLS array and
/// `_tls_index`, macOS through the TLV descriptor and its getter. The
/// 12-bit add immediate bounds the per-variable offset as on the pool
/// path; a `_Thread_local` beyond it is rejected.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_tls_addr(
    code: &mut Vec<u8>,
    dst: Place,
    frame: Frame,
    offset: i64,
    target: Target,
    tls_index_fixups: &mut Vec<super::TlsIndexFixup>,
    macho_tlv_fixups: &mut Vec<super::MachoTlvFixup>,
    macho_tlv_descriptors: &mut Vec<super::MachoTlvDescriptor>,
    elf_tpoff_fixups: &mut Vec<super::ElfTpoffFixup>,
    // A cross-unit `extern _Thread_local` access carries the variable's
    // name; its descriptor is keyed by symbol, not by the placeholder
    // offset.
    tls_extern_sym: Option<&str>,
    tls_align: usize,
) -> Emit {
    use super::encode::{enc_add_imm_lsl12, enc_blr, enc_ldr_reg_lsl3, enc_mrs_tpidr_el0};
    // A spilled destination materialises in x16; the sequences read `rd`
    // only after their last use of x16, and x17 stays free for the store.
    let rd = match dst {
        Place::IntReg(r) => Reg(r),
        Place::Spill(_) => Reg(16),
        _ => {
            return fail("TlsAddr: dst not int reg / spill");
        }
    };
    let emitted = match target {
        Target::LinuxAarch64 => {
            // Variant 1: the static TLS block sits above the thread pointer past
            // the 16-byte TCB rounded up to the block's alignment, so the
            // local-exec form is `tp + tprel_hi12 + tprel_lo12` (24-bit TPOFF,
            // two linker-patchable immediates). A unit-local access bakes its
            // TPOFF, a cross-unit one the reserve alone; both record an
            // `elf_tpoff_fixups` entry at the first add for the linker to rebase
            // against the merged TLS layout.
            let tcb_reserve = 16usize.next_multiple_of(tls_align.max(1)) as i64;
            let tpoff = if tls_extern_sym.is_some() {
                tcb_reserve as u32
            } else {
                (offset + tcb_reserve) as u32
            };
            if tpoff >= (1 << 24) {
                return fail("TlsAddr: tpoff exceeds the hi12/lo12 range");
            }
            emit(code, enc_mrs_tpidr_el0(rd));
            let add_off = code.len();
            emit(code, enc_add_imm_lsl12(rd, rd, tpoff >> 12));
            emit(code, enc_add_imm(rd, rd, tpoff & 0xFFF));
            elf_tpoff_fixups.push(super::ElfTpoffFixup {
                imm_offset: add_off,
                target: match tls_extern_sym {
                    Some(name) => super::ElfTpoffTarget::Extern(name.into()),
                    None => super::ElfTpoffTarget::Local(offset as u64),
                },
            });
            Ok(())
        }
        Target::WindowsAarch64 => {
            // x18 is the TEB pointer; TEB+0x58 holds the per-thread TLS array,
            // indexed by `_tls_index` (loaded into x17) to the module's block base
            // in x16. A unit-local access bakes the variable's offset within its
            // own block into the final `add`, a cross-unit one a 0 placeholder; the
            // linker resolves both against the merged layout through the
            // `elf_tpoff_fixups` entry, telling this module-relative form from the
            // variant-1 one by the `_tls_index` fixup.
            if tls_extern_sym.is_none() && offset >= 4096 {
                return fail("TlsAddr: offset exceeds 12-bit add immediate");
            }
            emit(code, enc_ldr_imm(Reg(16), Reg(18), 0x58));
            let pair_off = code.len();
            tls_index_fixups.push(super::TlsIndexFixup {
                instr_offset: pair_off,
            });
            emit(code, enc_adrp(Reg(17), 0));
            emit(code, enc_ldr32_imm(Reg(17), Reg(17), 0));
            emit(
                code,
                enc_ldr_reg_lsl3(Reg(16), Reg(16), Reg(17), IndexExt::None),
            );
            let add_off = code.len();
            let imm = if tls_extern_sym.is_some() {
                0
            } else {
                offset as u32
            };
            emit(code, enc_add_imm(rd, Reg(16), imm));
            elf_tpoff_fixups.push(super::ElfTpoffFixup {
                imm_offset: add_off,
                target: match tls_extern_sym {
                    Some(name) => super::ElfTpoffTarget::Extern(name.into()),
                    None => super::ElfTpoffTarget::Local(offset as u64),
                },
            });
            Ok(())
        }
        Target::MacOSAarch64 => {
            // One descriptor per variable: a unit-local access dedups by offset, a
            // cross-unit one by symbol (its offset is a linker placeholder).
            let descriptor_index = match tls_extern_sym {
                Some(name) => match macho_tlv_descriptors
                    .iter()
                    .position(|d| d.symbol.as_deref() == Some(name))
                {
                    Some(i) => i,
                    None => {
                        macho_tlv_descriptors.push(super::MachoTlvDescriptor {
                            offset_in_block: 0,
                            symbol: Some(name.into()),
                        });
                        macho_tlv_descriptors.len() - 1
                    }
                },
                None => match macho_tlv_descriptors
                    .iter()
                    .position(|d| d.symbol.is_none() && d.offset_in_block == offset as u64)
                {
                    Some(i) => i,
                    None => {
                        macho_tlv_descriptors.push(super::MachoTlvDescriptor {
                            offset_in_block: offset as u64,
                            symbol: None,
                        });
                        macho_tlv_descriptors.len() - 1
                    }
                },
            };
            let adrp_off = code.len();
            macho_tlv_fixups.push(super::MachoTlvFixup {
                adrp_offset: adrp_off,
                descriptor_index,
            });
            emit(code, enc_adrp(Reg(0), 0));
            emit(code, enc_add_imm(Reg(0), Reg(0), 0));
            emit(code, enc_ldr_imm(Reg(16), Reg(0), 0));
            emit(code, enc_blr(Reg(16)));
            if rd.0 != 0 {
                emit_mov_reg(code, rd, Reg(0));
            }
            Ok(())
        }
        _ => fail("TlsAddr: target not aarch64"),
    };
    emitted?;
    store_spilled_int(code, frame, dst, rd);
    Ok(())
}

/// The zero-extending load and the store of a `width`-byte integer access.
pub(super) fn int_unit_ops(width: u32) -> (MemOp, MemOp) {
    match width {
        8 => (LDR_X, STR_X),
        4 => (LDR_W, STR_W),
        2 => (LDRH, STRH),
        _ => (LDRB, STRB),
    }
}

/// One load / store pair of `width` bytes (8, 4, 2 or 1) moving
/// `[sbase + soff]` to `[dbase + doff]` through `temp`.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_copy_unit(
    code: &mut Vec<u8>,
    width: u32,
    temp: Reg,
    sbase: Reg,
    soff: u32,
    dbase: Reg,
    doff: u32,
) {
    let (ld, st) = int_unit_ops(width);
    emit(code, enc_mem(ld, temp.0, sbase, ld.scaled(soff)));
    emit(code, enc_mem(st, temp.0, dbase, st.scaled(doff)));
}

/// Bytes one window of [`emit_block_copy`] spans: 8-aligned and below 4096.
pub(super) const COPY_WINDOW: u32 = 4088;

/// Copy `size` bytes from `[sbase]` to `[dbase]` through `temp`; both
/// bases advance past every window but the last.
pub(super) fn emit_block_copy(
    code: &mut Vec<u8>,
    unit: u32,
    temp: Reg,
    sbase: Reg,
    dbase: Reg,
    size: u32,
) {
    let mut pos = 0u32;
    while pos < size {
        let run = (size - pos).min(COPY_WINDOW);
        let whole = run - run % unit;
        for off in (0..whole).step_by(unit as usize) {
            emit_copy_unit(code, unit, temp, sbase, off, dbase, off);
        }
        for off in whole..run {
            emit_copy_unit(code, 1, temp, sbase, off, dbase, off);
        }
        pos += run;
        if pos < size {
            emit(code, enc_add_imm(sbase, sbase, run));
            emit(code, enc_add_imm(dbase, dbase, run));
        }
    }
}

fn enc_load_unit(width: u32, rt: Reg, base: Reg, off: u32) -> u32 {
    let (ld, _) = int_unit_ops(width);
    enc_mem(ld, rt.0, base, ld.scaled(off))
}

/// Load `width` bytes at `[base + off]` into `dst` with no access wider
/// than `align` proves at that address (`access_pieces`). `tmp` holds
/// each narrow piece and must differ from `base` and `dst`; it stays
/// untouched when one access suffices, the only case in which `dst` may
/// alias `base`.
#[allow(clippy::too_many_arguments)]
pub(crate) fn emit_agg_load_int(
    code: &mut Vec<u8>,
    dst: Reg,
    base: Reg,
    off: u32,
    width: u32,
    align: u32,
    strict_align: bool,
    tmp: Reg,
) {
    for (i, (o, w)) in super::super::access_pieces(off, width, align, strict_align).enumerate() {
        if i == 0 {
            emit(code, enc_load_unit(w, dst, base, o));
            continue;
        }
        debug_assert!(dst.0 != base.0 && tmp.0 != base.0 && tmp.0 != dst.0);
        emit(code, enc_load_unit(w, tmp, base, o));
        emit(
            code,
            super::encode::enc_lsl_imm(tmp, tmp, ((o - off) * 8) as u8),
        );
        emit(code, super::encode::enc_orr_reg(dst, dst, tmp));
    }
}

/// `emit_agg_load_int` for an FP destination: `width` 16 for a whole
/// `q` register (a Short Vector), 8 for a `d`, 4 for an `s`. Below the
/// natural access the first piece arrives through `fmov` and the rest
/// through element inserts, so `tmp` is the only extra register.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_agg_load_fp(
    code: &mut Vec<u8>,
    dst: u8,
    base: Reg,
    off: u32,
    width: u32,
    align: u32,
    strict_align: bool,
    tmp: Reg,
) {
    if super::super::access_unit(off, width, align, strict_align) == width {
        emit(
            code,
            match width {
                16 => super::encode::enc_ldr_q_imm(dst, base, off),
                8 => super::encode::enc_ldr_d_imm(dst, base, off),
                _ => super::encode::enc_ldr_s_imm(dst, base, off),
            },
        );
        return;
    }
    for (i, (o, w)) in super::super::access_pieces(off, width, align, strict_align).enumerate() {
        emit(code, enc_load_unit(w, tmp, base, o));
        if i == 0 {
            emit(
                code,
                if width == 4 {
                    super::encode::enc_fmov_w_to_s(dst, tmp)
                } else {
                    super::encode::enc_fmov_x_to_d(dst, tmp)
                },
            );
        } else {
            emit(code, super::encode::enc_ins_gen(dst, w, i as u32, tmp));
        }
    }
}

/// The partner of [`emit_agg_load_fp`]: store an FP register's low
/// `width` bytes to `[base + off]`, narrowing to element extracts when
/// the destination's alignment does not admit the whole access.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_agg_store_fp(
    code: &mut Vec<u8>,
    src: u8,
    base: Reg,
    off: u32,
    width: u32,
    align: u32,
    strict_align: bool,
    tmp: Reg,
) {
    if super::super::access_unit(off, width, align, strict_align) == width {
        emit(
            code,
            match width {
                16 => super::encode::enc_str_q_imm(src, base, off),
                8 => super::encode::enc_str_d_imm(src, base, off),
                _ => super::encode::enc_str_s_imm(src, base, off),
            },
        );
        return;
    }
    for (i, (o, w)) in super::super::access_pieces(off, width, align, strict_align).enumerate() {
        emit(code, super::encode::enc_umov_gen(tmp, src, w, i as u32));
        emit(code, enc_store_unit(w, tmp, base, o));
    }
}

/// The alignment a scalar access must respect, or `None` for its
/// natural width: only a bound the walker proved, and only under
/// `-mstrict-align`.
pub(super) fn narrow_bound(align: u8, abi: super::Abi) -> Option<u32> {
    (abi.strict_align && align != 0).then_some(align as u32)
}

/// Zero-extending store of the low `width` bytes (8, 4, 2 or 1) of
/// `rt` to `[base + off]`.
pub(crate) fn enc_store_unit(width: u32, rt: Reg, base: Reg, off: u32) -> u32 {
    let (_, st) = int_unit_ops(width);
    enc_mem(st, rt.0, base, st.scaled(off))
}

/// Registers a narrowed scalar access borrows for its accumulator and
/// piece temp, saved and restored across the sequence; nothing between
/// the save and the restore addresses sp.
pub(crate) const NARROW_BORROW: [u8; 7] = [9, 10, 11, 12, 13, 14, 15];

/// The first `N` borrow registers not in `avoid`.
fn narrow_borrows<const N: usize>(avoid: &[u8]) -> [Reg; N] {
    let mut out = [Reg(0); N];
    let mut n = 0;
    for cand in NARROW_BORROW {
        if n == N {
            break;
        }
        if !avoid.contains(&cand) {
            out[n] = Reg(cand);
            n += 1;
        }
    }
    debug_assert_eq!(n, N, "narrow access: no free borrow register");
    out
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
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 | LoadKind::V128 => {
            (0, false)
        }
    }
}

/// Lower an integer load at `[rn + disp]` whose address is proven only
/// `align`-aligned into accesses no wider than that, into `rd`. The
/// pieces compose zero-extended; a signed kind is sign-extended after.
fn emit_narrow_load(code: &mut Vec<u8>, rd: Reg, rn: Reg, disp: u32, kind: LoadKind, align: u32) {
    let (width, signed) = int_load_shape(kind);
    let [acc, tmp] = narrow_borrows::<2>(&[rn.0, rd.0]);
    emit(code, enc_str_pre(acc, Reg(31), -16));
    emit(code, enc_str_pre(tmp, Reg(31), -16));
    emit_agg_load_int(code, acc, rn, disp, width, align, true, tmp);
    match (signed, width) {
        (true, 4) => emit(code, super::encode::enc_sxtw(rd, acc)),
        (true, 2) => emit(code, super::encode::enc_sxth(rd, acc)),
        (true, 1) => emit(code, super::encode::enc_sxtb(rd, acc)),
        _ => emit_mov_reg(code, rd, acc),
    }
    emit(code, enc_ldr_post(tmp, Reg(31), 16));
    emit(code, enc_ldr_post(acc, Reg(31), 16));
}

/// Store companion to [`emit_narrow_load`]: write the low `width`
/// bytes of `rs` to `[rn + disp]` in `align`-wide pieces, most
/// significant last.
fn emit_narrow_store(code: &mut Vec<u8>, rs: Reg, rn: Reg, disp: u32, width: u32, align: u32) {
    let [tmp] = narrow_borrows::<1>(&[rn.0, rs.0]);
    emit(code, enc_str_pre(tmp, Reg(31), -16));
    for (i, (o, w)) in super::super::access_pieces(disp, width, align, true).enumerate() {
        let src = if i == 0 {
            rs
        } else {
            emit(
                code,
                super::encode::enc_lsr_imm(tmp, rs, ((o - disp) * 8) as u8),
            );
            tmp
        };
        emit(code, enc_store_unit(w, src, rn, o));
    }
    emit(code, enc_ldr_post(tmp, Reg(31), 16));
}

use super::ssa::emit_common::c5_slot_to_fp_offset;

/// fp-relative byte offset of c5 slot `off`: parameter `off - 2`'s home
/// ([`param_home_off`]) for `off >= 2`, the local at `[fp + off*8]` below
/// the canary region otherwise.
pub(super) fn local_slot_off(off: i64, func: &FunctionSsa, frame: Frame) -> i64 {
    if off >= 2 {
        param_home_off((off - 2) as usize, func, frame)
    } else {
        c5_slot_to_fp_offset(off, 16, frame.canary_bytes)
    }
}

/// Region offset of an over-aligned automatic object's storage (C11
/// 6.7.5), or None for an ordinary slot. The region base is sp after a
/// realignment and `fp + align_region_off` for the static 16-aligned
/// placement.
fn over_aligned_region_off(off: i64, func: &FunctionSsa, frame: Frame) -> Option<i64> {
    if off >= 0 || (frame.realign_align == 0 && frame.align_region_off == 0) {
        return None;
    }
    func.over_aligned
        .iter()
        .find(|&&(s, _)| s == off)
        .map(|&(_, region_off)| region_off)
}

pub(super) fn fp_store_op(width: u32) -> MemOp {
    match width {
        16 => STR_Q,
        8 => STR_D,
        _ => STR_S,
    }
}

/// Base and displacement of the object at `base + disp`: `t` loaded with its
/// address unless every `(op, offset)` access encodes in one instruction.
pub(crate) fn object_base(
    code: &mut Vec<u8>,
    base: Reg,
    disp: i64,
    mut accesses: impl Iterator<Item = (MemOp, u32)>,
    t: Reg,
) -> (Reg, i64) {
    if accesses.all(|(op, off)| op.offset(disp + i64::from(off)).is_some()) {
        return (base, disp);
    }
    emit_reg_disp(code, t, base, disp);
    (t, 0)
}

/// [`emit_agg_store_fp`] into the object at `base + disp`.
pub(super) fn emit_agg_store_fp_at(
    code: &mut Vec<u8>,
    src: u8,
    (base, disp): (Reg, i64),
    off: u32,
    width: u32,
    align: u32,
    strict_align: bool,
    t: Reg,
    tmp: Reg,
) {
    if super::super::access_unit(off, width, align, strict_align) == width {
        emit_mem(
            code,
            fp_store_op(width),
            src,
            base,
            disp + i64::from(off),
            t,
        );
        return;
    }
    let base = if disp == 0 {
        base
    } else {
        emit_reg_disp(code, t, base, disp);
        t
    };
    emit_agg_store_fp(code, src, base, off, width, align, strict_align, tmp);
}

/// Base and displacement of local slot `off`; sp only for an object past a
/// realignment (C11 6.7.5).
pub(super) fn local_slot_base(off: i64, func: &FunctionSsa, frame: Frame) -> (Reg, i64) {
    match over_aligned_region_off(off, func, frame) {
        None => (Reg(29), local_slot_off(off, func, frame)),
        Some(region_off) if frame.align_region_off != 0 => {
            (Reg(29), frame.align_region_off + region_off)
        }
        Some(region_off) => (Reg(31), region_off.max(0)),
    }
}

/// The address of a local slot, an over-aligned object redirected to its
/// region (C11 6.7.5). Callers addressing only synthetic / parameter
/// slots use `emit_local_addr_fp`.
pub(super) fn emit_local_addr(
    code: &mut Vec<u8>,
    dst: Place,
    off: i64,
    func: &FunctionSsa,
    frame: Frame,
) -> Emit {
    let (base, disp) = local_slot_base(off, func, frame);
    emit_addr_into(code, dst, base, disp, frame)
}

pub(super) fn emit_local_addr_fp(
    code: &mut Vec<u8>,
    dst: Place,
    off: i64,
    func: &FunctionSsa,
    frame: Frame,
) -> Emit {
    emit_addr_into(code, dst, Reg(29), local_slot_off(off, func, frame), frame)
}

fn emit_addr_into(code: &mut Vec<u8>, dst: Place, base: Reg, disp: i64, frame: Frame) -> Emit {
    let rd = match dst {
        Place::IntReg(r) => Reg(r),
        Place::Spill(_) => Reg(16),
        _ => {
            return fail("LocalAddr: dst not int reg / spill");
        }
    };
    emit_reg_disp(code, rd, base, disp);
    store_spilled_int(code, frame, dst, rd);
    Ok(())
}

/// The working register of a single-result integer lowering: the
/// allocator's, or `scratch.primary` for a spilled result; `None` for an
/// FP or absent destination.
pub(super) fn int_or_spill_scratch(dst: Place, scratch: &ScratchPool) -> Option<Reg> {
    match dst {
        Place::IntReg(r) => Some(Reg(r)),
        Place::Spill(_) => Some(scratch.primary),
        Place::FpReg(_) | Place::None => None,
    }
}

/// Store an integer result into its spill slot when the allocator placed
/// the value there; a register place already holds it.
pub(super) fn store_spilled_int(code: &mut Vec<u8>, frame: Frame, dst: Place, src: Reg) {
    if let Place::Spill(slot) = dst {
        emit_spill_str_x_auto(code, frame, src, spill_off(frame, slot));
    }
}

/// The floating-point counterpart of [`store_spilled_int`].
pub(super) fn store_spilled_fp(code: &mut Vec<u8>, frame: Frame, dst: Place, src: u8) {
    if let Place::Spill(slot) = dst {
        emit_spill_str_d_auto(code, frame, src, spill_off(frame, slot));
    }
}

/// An `IntReg` source is the zero a fill stores; `fmov d, x` clears the upper
/// half with it.
pub(super) fn materialize_v128(
    code: &mut Vec<u8>,
    place: Place,
    scratch_q: u8,
    frame: Frame,
    addr_scratch: Reg,
) -> Option<u8> {
    match place {
        Place::FpReg(r) => Some(r),
        Place::Spill(slot) => {
            let off = v128_spill_off(frame, slot);
            emit_spill_ldr_q(code, frame, scratch_q, off, addr_scratch);
            Some(scratch_q)
        }
        Place::IntReg(r) => {
            emit(code, enc_fmov_x_to_d(scratch_q, Reg(r)));
            Some(scratch_q)
        }
        Place::None => None,
    }
}

pub(super) fn propagate_v128(
    code: &mut Vec<u8>,
    frame: Frame,
    dst: Place,
    src: u8,
    addr_scratch: Reg,
) {
    match dst {
        Place::FpReg(r) if r != src => emit(code, super::encode::enc_mov_v16b(r, src)),
        Place::Spill(slot) => {
            emit_spill_str_q(code, frame, src, v128_spill_off(frame, slot), addr_scratch)
        }
        _ => {}
    }
}

fn scratch_other(scratch: &ScratchPool, r: Reg) -> Reg {
    if r == scratch.secondary {
        scratch.primary
    } else {
        scratch.secondary
    }
}

fn int_load_op(kind: LoadKind) -> Option<MemOp> {
    Some(match kind {
        LoadKind::I64 => LDR_X,
        LoadKind::I32 => LDRSW,
        LoadKind::U32 => LDR_W,
        LoadKind::I16 => LDRSH,
        LoadKind::U16 => LDRH,
        LoadKind::I8 => LDRSB,
        LoadKind::U8 => LDRB,
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 | LoadKind::V128 => {
            return None;
        }
    })
}

fn int_store_op(kind: StoreKind) -> Option<MemOp> {
    Some(match kind {
        StoreKind::I64 => STR_X,
        StoreKind::I32 => STR_W,
        StoreKind::I16 => STRH,
        StoreKind::I8 => STRB,
        StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128 | StoreKind::V128 => {
            return None;
        }
    })
}

/// `Inst::Load`; `bound` is the address alignment proven under `-mstrict-align`.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_load(
    code: &mut Vec<u8>,
    dst: Place,
    addr: u32,
    disp: i32,
    kind: LoadKind,
    keep_f32: bool,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
    bound: Option<u32>,
) -> Emit {
    let disp = i64::from(disp);
    let Some(rn) = materialize_int(code, place_of(alloc, addr), scratch.primary, frame) else {
        return fail("Load: addr not int reg / spill");
    };
    let t = scratch_other(scratch, rn);
    // F32 loads read the s-view; a single-precision value (C99 6.3.1.8)
    // stays f32, the untagged archive-reload value widens through
    // `fcvt Dd, Sn`.
    if let LoadKind::F32 | LoadKind::F64 = kind {
        let (op, what) = if let LoadKind::F32 = kind {
            (LDR_S, "Load F32: dst not fp reg / spill")
        } else {
            (LDR_D, "Load F64: dst not fp reg / spill")
        };
        let Some(dd) = fp_or_spill_dst(dst, frame) else {
            return fail(what);
        };
        match bound {
            Some(a) => {
                let (base, off) = bound_base(code, rn, disp, op.size(), op.size(), a, t);
                let tmp = scratch_other(scratch, base);
                emit_agg_load_fp(code, dd, base, off, op.size(), a, true, tmp);
            }
            None => emit_mem(code, op, dd, rn, disp, t),
        }
        if let LoadKind::F32 = kind
            && !keep_f32
        {
            emit(code, enc_fcvt_d_s(dd, dd));
        }
        store_spilled_fp(code, frame, dst, dd);
        return Ok(());
    }
    if let LoadKind::F128 = kind {
        let Some(dd) = fp_or_spill_dst(dst, frame) else {
            return fail("Load F128: dst not fp reg / spill");
        };
        let base = addr_outside_borrows(code, rn, scratch);
        super::binary128::emit_narrow_load(code, dd, base, disp, bound);
        store_spilled_fp(code, frame, dst, dd);
        return Ok(());
    }
    if let LoadKind::V128 = kind {
        let Some(qd) = fp_or_spill_dst(dst, frame) else {
            return fail("Load V128: dst not fp reg / spill");
        };
        emit_mem(code, LDR_Q, qd, rn, disp, t);
        propagate_v128(code, frame, dst, qd, scratch.primary);
        return Ok(());
    }
    let rd = match dst {
        Place::IntReg(r) => Reg(r),
        Place::Spill(_) => scratch.secondary,
        Place::FpReg(_) | Place::None => return fail("Load: dst not int reg / spill"),
    };
    let Some(op) = int_load_op(kind) else {
        return fail("Load: no aarch64 access for the kind");
    };
    match bound {
        Some(a) => {
            let (base, off) = bound_base(code, rn, disp, op.size(), op.size(), a, t);
            emit_narrow_load(code, rd, base, off, kind, a);
        }
        None => emit_mem(code, op, rd.0, rn, disp, t),
    }
    store_spilled_int(code, frame, dst, rd);
    Ok(())
}

/// A base the binary128 sequences, which move sp, may address.
fn binary128_base(code: &mut Vec<u8>, base: Reg, disp: i64, t: Reg) -> (Reg, i64) {
    if base.0 != 31 {
        return (base, disp);
    }
    emit_reg_disp(code, t, base, disp);
    (t, 0)
}

/// `Inst::LoadLocal`. A single-precision value stays f32 (C99 6.3.1.8); the
/// untagged archive-reload value widens.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_load_local(
    code: &mut Vec<u8>,
    dst: Place,
    off: i64,
    kind: LoadKind,
    keep_f32: bool,
    func: &FunctionSsa,
    frame: Frame,
    scratch: &ScratchPool,
) -> Emit {
    let (base, disp) = local_slot_base(off, func, frame);
    let t = scratch.primary;
    if let LoadKind::F32 | LoadKind::F64 | LoadKind::V128 = kind {
        let (op, what) = match kind {
            LoadKind::F32 => (LDR_S, "LoadLocal F32: dst not fp reg / spill"),
            LoadKind::F64 => (LDR_D, "LoadLocal F64: dst not fp reg / spill"),
            _ => (LDR_Q, "LoadLocal V128: dst not fp reg / spill"),
        };
        let Some(dd) = fp_or_spill_dst(dst, frame) else {
            return fail(what);
        };
        emit_mem(code, op, dd, base, disp, t);
        if let LoadKind::V128 = kind {
            propagate_v128(code, frame, dst, dd, scratch.primary);
            return Ok(());
        }
        if let LoadKind::F32 = kind
            && !keep_f32
        {
            emit(code, super::encode::enc_fcvt_d_s(dd, dd));
        }
        store_spilled_fp(code, frame, dst, dd);
        return Ok(());
    }
    if let LoadKind::F128 = kind {
        let Some(dd) = fp_or_spill_dst(dst, frame) else {
            return fail("LoadLocal F128: dst not fp reg / spill");
        };
        let (base, disp) = binary128_base(code, base, disp, t);
        super::binary128::emit_narrow_load(code, dd, base, disp, None);
        store_spilled_fp(code, frame, dst, dd);
        return Ok(());
    }
    let rd = match dst {
        Place::IntReg(r) => Reg(r),
        Place::Spill(_) => scratch.secondary,
        Place::FpReg(_) | Place::None => return fail("LoadLocal: dst not int reg / spill"),
    };
    let Some(op) = int_load_op(kind) else {
        return fail("LoadLocal: no aarch64 access for the kind");
    };
    emit_mem(code, op, rd.0, base, disp, t);
    store_spilled_int(code, frame, dst, rd);
    Ok(())
}

/// `Inst::StoreLocal`; mirrors [`emit_load_local`]. The c5 store ops leave
/// the stored value in the accumulator, so the value is propagated to `dst`
/// when the allocator parked it elsewhere.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_store_local(
    code: &mut Vec<u8>,
    dst: Place,
    off: i64,
    value: u32,
    kind: StoreKind,
    alloc: &Allocation,
    func: &FunctionSsa,
    frame: Frame,
    scratch: &ScratchPool,
) -> Emit {
    let (base, disp) = local_slot_base(off, func, frame);
    let t = scratch.secondary;
    let value_place = place_of(alloc, value);
    if matches!(kind, StoreKind::F32) {
        return emit_store_local_f32(
            code,
            dst,
            (base, disp),
            value,
            value_place,
            alloc,
            frame,
            scratch,
        );
    }
    if matches!(kind, StoreKind::V128) {
        let Some(qn) = materialize_v128(
            code,
            value_place,
            frame.fp_scratch[0],
            frame,
            scratch.primary,
        ) else {
            return fail("StoreLocal V128: value not fp reg / spill / int reg");
        };
        emit_mem(code, STR_Q, qn, base, disp, t);
        propagate_v128(code, frame, dst, qn, scratch.primary);
        return Ok(());
    }
    if let StoreKind::F64 | StoreKind::F128 = kind {
        let Some(dn) = materialize_fp(code, value_place, frame.fp_scratch[0], frame) else {
            return fail(if let StoreKind::F64 = kind {
                "StoreLocal F64: value not fp reg / spill / int reg"
            } else {
                "StoreLocal F128: value not fp reg / spill / int reg"
            });
        };
        if let StoreKind::F64 = kind {
            emit_mem(code, STR_D, dn, base, disp, t);
        } else {
            let (base, disp) = binary128_base(code, base, disp, t);
            super::binary128::emit_widen_store(code, dn, base, disp, None);
        }
        propagate_fp(code, frame, dst, dn);
        return Ok(());
    }
    let Some(op) = int_store_op(kind) else {
        return fail("StoreLocal: no aarch64 access for the kind");
    };
    // An FpReg value (an FP-typed accumulator spilled to a local temp)
    // bridges through `fmov x, d`.
    let rv = if let Place::FpReg(dr) = value_place {
        emit(code, super::encode::enc_fmov_d_to_x(scratch.primary, dr));
        scratch.primary
    } else {
        match materialize_int(code, value_place, scratch.primary, frame) {
            Some(r) => r,
            None => return fail("StoreLocal: value not int reg / spill"),
        }
    };
    // The accumulator keeps the full source value: an assignment yields
    // the stored value before any re-narrowing on read-back (C99 6.5.16p3).
    emit_mem(code, op, rv.0, base, disp, t);
    propagate_int(code, frame, dst, rv)
}

/// The `float` half of `emit_store_local`. A single-precision value (C99
/// 6.3.1.8) stores as is; a wider value narrows through `fcvt Sd, Dn`
/// into the second FP scratch, since the S-view write zeroes the rest of
/// a V register the allocator may still hold live. Mirrors the `Store`
/// F32 path so a promoted slot round-trips like the address-taken one.
#[allow(clippy::too_many_arguments)]
fn emit_store_local_f32(
    code: &mut Vec<u8>,
    dst: Place,
    (base, disp): (Reg, i64),
    value: u32,
    value_place: Place,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> Emit {
    let t = scratch.secondary;
    if alloc.is_f32(value) {
        let Some(sn) = materialize_fp_f32(code, value_place, frame.fp_scratch[0], frame) else {
            return fail("StoreLocal F32: value not fp reg / spill");
        };
        emit_mem(code, STR_S, sn, base, disp, t);
        if let Some(rd) = fp_reg(dst) {
            if rd != sn {
                emit(code, super::encode::enc_fmov_s_s(rd, sn));
            }
        } else {
            store_spilled_fp(code, frame, dst, sn);
        }
        return Ok(());
    }
    let dn = match value_place {
        Place::FpReg(r) => r,
        Place::IntReg(_) | Place::Spill(_) => {
            let Some(rs) = materialize_int(code, value_place, scratch.secondary, frame) else {
                return fail("StoreLocal F32: value not int reg / spill");
            };
            emit(code, enc_fmov_x_to_d(frame.fp_scratch[0], rs));
            frame.fp_scratch[0]
        }
        Place::None => {
            return fail("StoreLocal F32: value None");
        }
    };
    emit(code, super::encode::enc_fcvt_s_d(frame.fp_scratch[1], dn));
    emit_mem(code, STR_S, frame.fp_scratch[1], base, disp, t);
    if let Some(rd) = fp_reg(dst) {
        if rd != dn {
            emit(code, enc_fmov_d_to_x(scratch.primary, dn));
            emit(code, enc_fmov_x_to_d(rd, scratch.primary));
        }
    } else {
        store_spilled_fp(code, frame, dst, dn);
    }
    Ok(())
}

/// Propagate a stored integer value, the c5 accumulator, to `dst` when the
/// allocator parked it elsewhere; `Err` for an FP destination.
fn propagate_int(code: &mut Vec<u8>, frame: Frame, dst: Place, rv: Reg) -> Emit {
    match dst {
        Place::IntReg(r) if r != rv.0 => emit_mov_reg(code, Reg(r), rv),
        Place::IntReg(_) | Place::None => {}
        Place::Spill(slot) => emit_spill_str_x_auto(code, frame, rv, spill_off(frame, slot)),
        Place::FpReg(_) => return fail("Store / StoreLocal: dst not int reg / spill"),
    }
    Ok(())
}

/// Propagate a stored d-register value to `dst` when the allocator parked
/// the accumulator elsewhere.
fn propagate_fp(code: &mut Vec<u8>, frame: Frame, dst: Place, dn: u8) {
    match dst {
        Place::FpReg(r) if r != dn => emit(code, super::encode::enc_fmov_d_d(r, dn)),
        Place::Spill(slot) => emit_spill_str_d_auto(code, frame, dn, spill_off(frame, slot)),
        _ => {}
    }
}

/// `Inst::LoadIndexed`: one scaled-indexed load
/// (`ldr Xt, [Xn, Rm, <ext> #N]`) when `scale` is the natural width of
/// `kind`; `index` carries the value and how much of it is read. TODO:
/// the FP forms; the walker's indexed fold does not produce them.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_load_indexed(
    code: &mut Vec<u8>,
    dst: Place,
    base: u32,
    (index, ext): (u32, IndexExt),
    scale: u8,
    kind: LoadKind,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> Emit {
    if matches!(
        kind,
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 | LoadKind::V128
    ) {
        return fail("LoadIndexed: FP not implemented");
    }
    let base_place = place_of(alloc, base);
    let index_place = place_of(alloc, index);
    let rn = match materialize_int(code, base_place, scratch.primary, frame) {
        Some(r) => r,
        None => return fail("LoadIndexed: base not int reg / spill"),
    };
    let rm = match materialize_int(code, index_place, scratch.secondary, frame) {
        Some(r) => r,
        None => return fail("LoadIndexed: index not int reg / spill"),
    };
    let rd = match dst {
        Place::IntReg(r) => Reg(r),
        Place::Spill(_) => scratch.secondary,
        Place::FpReg(_) | Place::None => return fail("LoadIndexed: dst not int reg / spill"),
    };
    let expected_scale: u8 = match kind {
        LoadKind::I64 => 8,
        LoadKind::I32 | LoadKind::U32 => 4,
        LoadKind::I16 | LoadKind::U16 => 2,
        LoadKind::I8 | LoadKind::U8 => 1,
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 | LoadKind::V128 => {
            unreachable!()
        }
    };
    if scale != expected_scale {
        return fail("LoadIndexed: scale doesn't match access width");
    }
    let word = match kind {
        LoadKind::I64 => super::encode::enc_ldr_reg_lsl3(rd, rn, rm, ext),
        LoadKind::I32 => super::encode::enc_ldrsw_reg_lsl2(rd, rn, rm, ext),
        LoadKind::U32 => super::encode::enc_ldr32_reg_lsl2(rd, rn, rm, ext),
        LoadKind::I16 => super::encode::enc_ldrsh_reg_lsl1(rd, rn, rm, ext),
        LoadKind::U16 => super::encode::enc_ldrh_reg_lsl1(rd, rn, rm, ext),
        LoadKind::I8 => super::encode::enc_ldrsb_reg(rd, rn, rm, ext),
        LoadKind::U8 => super::encode::enc_ldrb_reg(rd, rn, rm, ext),
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 | LoadKind::V128 => {
            unreachable!()
        }
    };
    emit(code, word);
    store_spilled_int(code, frame, dst, rd);
    Ok(())
}

/// Lower `Inst::StoreIndexed`: `*(kind*)(base + index * scale) = value`.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_store_indexed(
    code: &mut Vec<u8>,
    dst: Place,
    base: u32,
    (index, ext): (u32, IndexExt),
    scale: u8,
    value: u32,
    kind: StoreKind,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> Emit {
    if matches!(
        kind,
        StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128 | StoreKind::V128
    ) {
        return fail("StoreIndexed: FP not implemented");
    }
    let base_place = place_of(alloc, base);
    let index_place = place_of(alloc, index);
    let value_place = place_of(alloc, value);
    let rn = match materialize_int(code, base_place, scratch.primary, frame) {
        Some(r) => r,
        None => return fail("StoreIndexed: base not int reg / spill"),
    };
    let rm = match materialize_int(code, index_place, scratch.secondary, frame) {
        Some(r) => r,
        None => return fail("StoreIndexed: index not int reg / spill"),
    };
    let expected_scale: u8 = match kind {
        StoreKind::I64 => 8,
        StoreKind::I32 => 4,
        StoreKind::I16 => 2,
        StoreKind::I8 => 1,
        StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128 | StoreKind::V128 => {
            unreachable!()
        }
    };
    if scale != expected_scale {
        return fail("StoreIndexed: scale doesn't match access width");
    }
    // The store needs base, index and value in three registers with two
    // scratches: when a spilled base and index take both, the index folds
    // into the base and the plain `[addr]` form frees a scratch.
    let vscratch;
    let addr_reg; // Some(addr) selects the plain `[addr]` store.
    if scratch.primary != rn && scratch.primary != rm {
        vscratch = scratch.primary;
        addr_reg = None;
    } else if scratch.secondary != rn && scratch.secondary != rm {
        vscratch = scratch.secondary;
        addr_reg = None;
    } else {
        let shift = scale.trailing_zeros();
        emit(
            code,
            super::encode::enc_add_index(scratch.primary, rn, rm, ext, shift),
        );
        addr_reg = Some(scratch.primary);
        vscratch = scratch.secondary;
    }
    let rv = if let StoreKind::I64 = kind
        && let Place::FpReg(dr) = value_place
    {
        emit(code, super::encode::enc_fmov_d_to_x(vscratch, dr));
        vscratch
    } else {
        match materialize_int(code, value_place, vscratch, frame) {
            Some(r) => r,
            None => return fail("StoreIndexed: value not int reg / spill"),
        }
    };
    let word = match (kind, addr_reg) {
        (StoreKind::I64, None) => super::encode::enc_str_reg_lsl3(rv, rn, rm, ext),
        (StoreKind::I32, None) => super::encode::enc_str32_reg_lsl2(rv, rn, rm, ext),
        (StoreKind::I16, None) => super::encode::enc_strh_reg_lsl1(rv, rn, rm, ext),
        (StoreKind::I8, None) => super::encode::enc_strb_reg(rv, rn, rm, ext),
        (StoreKind::I64, Some(a)) => super::encode::enc_str_imm(rv, a, 0),
        (StoreKind::I32, Some(a)) => super::encode::enc_str32_imm(rv, a, 0),
        (StoreKind::I16, Some(a)) => super::encode::enc_strh_imm(rv, a, 0),
        (StoreKind::I8, Some(a)) => super::encode::enc_strb_imm(rv, a, 0),
        (
            StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128 | StoreKind::V128,
            _,
        ) => unreachable!(),
    };
    emit(code, word);
    propagate_int(code, frame, dst, rv)
}

/// `Inst::Store`, `bound` as for [`emit_load`]. The address reloads into x16
/// first, so a spilled FP value reloads through x17.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_store(
    code: &mut Vec<u8>,
    dst: Place,
    addr: u32,
    disp: i32,
    value: u32,
    kind: StoreKind,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
    bound: Option<u32>,
) -> Emit {
    let disp = i64::from(disp);
    // The c5 store ops leave the stored value in the accumulator, which
    // `dst` may want in a register or spill slot.
    let value_place = place_of(alloc, value);
    let Some(rn) = materialize_int(code, place_of(alloc, addr), scratch.primary, frame) else {
        return fail("Store: addr not int reg / spill");
    };
    let fp_value = |code: &mut Vec<u8>, single: bool| {
        reload_fp(
            code,
            value_place,
            frame.fp_scratch[0],
            frame,
            0,
            single,
            scratch.secondary,
        )
    };
    if let StoreKind::F32 = kind {
        // A single-precision value stores as is (C99 6.3.1.8); a double (the
        // archive-reload boundary, or an un-narrowed `double` assigned to a
        // `float` lvalue) narrows through `fcvt Sd, Dn`.
        if alloc.is_f32(value) {
            let Some(sn) = fp_value(code, true) else {
                return fail("Store F32: value not fp reg / spill");
            };
            emit_fp_store(code, STR_S, sn, rn, disp, bound, scratch);
            // Propagate the f32 accumulator to `dst` if parked elsewhere.
            if let Some(rd) = fp_reg(dst) {
                if rd != sn {
                    emit(code, super::encode::enc_fmov_s_s(rd, sn));
                }
            } else {
                store_spilled_fp(code, frame, dst, sn);
            }
            return Ok(());
        }
        // An IntReg / Spill source holds the f64 bit pattern (c5's `Imm`);
        // `fmov d, x` reinterprets it.
        let dn = match value_place {
            Place::FpReg(r) => r,
            Place::IntReg(_) | Place::Spill(_) => {
                let Some(rs) = materialize_int(code, value_place, scratch.secondary, frame) else {
                    return fail("Store F32: value not int reg / spill");
                };
                emit(code, enc_fmov_x_to_d(frame.fp_scratch[0], rs));
                frame.fp_scratch[0]
            }
            Place::None => return fail("Store F32: value None"),
        };
        // The narrowing writes the S view and zeroes the rest of the V
        // register, so it targets the second FP scratch, not an allocator-held
        // `dn`.
        emit(code, enc_fcvt_s_d(frame.fp_scratch[1], dn));
        emit_fp_store(code, STR_S, frame.fp_scratch[1], rn, disp, bound, scratch);
        if let Some(rd) = fp_reg(dst) {
            if rd != dn {
                emit(code, enc_fmov_d_to_x(scratch.primary, dn));
                emit(code, enc_fmov_x_to_d(rd, scratch.primary));
            }
        } else {
            store_spilled_fp(code, frame, dst, dn);
        }
        return Ok(());
    }
    if let StoreKind::V128 = kind {
        let Some(qn) = materialize_v128(
            code,
            value_place,
            frame.fp_scratch[0],
            frame,
            scratch.secondary,
        ) else {
            return fail("Store V128: value not fp reg / spill / int reg");
        };
        emit_mem(code, STR_Q, qn, rn, disp, scratch_other(scratch, rn));
        propagate_v128(code, frame, dst, qn, scratch.secondary);
        return Ok(());
    }
    if let StoreKind::F64 | StoreKind::F128 = kind {
        let Some(dn) = fp_value(code, false) else {
            return fail(if let StoreKind::F64 = kind {
                "Store F64: value not fp reg / spill"
            } else {
                "Store F128: value not fp reg / spill / int reg"
            });
        };
        if let StoreKind::F64 = kind {
            emit_fp_store(code, STR_D, dn, rn, disp, bound, scratch);
        } else {
            let base = addr_outside_borrows(code, rn, scratch);
            super::binary128::emit_widen_store(code, dn, base, disp, bound);
        }
        if let Some(rd) = fp_reg(dst) {
            if rd != dn {
                emit(code, super::encode::enc_fmov_d_d(rd, dn));
            }
        } else {
            store_spilled_fp(code, frame, dst, dn);
        }
        return Ok(());
    }
    let Some(op) = int_store_op(kind) else {
        return fail("Store: no aarch64 access for the kind");
    };
    // The address settles before the value reloads.
    let t = scratch_other(scratch, rn);
    let rs = match bound {
        Some(a) => {
            let (base, off) = bound_base(code, rn, disp, op.size(), op.size(), a, t);
            let vs = scratch_other(scratch, base);
            let Some(rs) = int_store_value(code, kind, value_place, vs, frame) else {
                return fail("Store: value not int reg / spill");
            };
            emit_narrow_store(code, rs, base, off, op.size(), a);
            rs
        }
        None => {
            let (base, off) = mem_base(code, op, rn, disp, t);
            let vs = scratch_other(scratch, base);
            let Some(rs) = int_store_value(code, kind, value_place, vs, frame) else {
                return fail("Store: value not int reg / spill");
            };
            emit(code, enc_mem(op, rs.0, base, off));
            rs
        }
    };
    if let Some(rd) = int_reg(dst) {
        if rd.0 != rs.0 {
            emit_mov_reg(code, rd, rs);
        }
    } else {
        store_spilled_int(code, frame, dst, rs);
    }
    Ok(())
}

/// An integer store's value register. c5's f64 store path writes 8 raw bytes
/// as `StoreKind::I64`, so an FpReg value bridges through `fmov x, d`.
fn int_store_value(
    code: &mut Vec<u8>,
    kind: StoreKind,
    place: Place,
    vs: Reg,
    frame: Frame,
) -> Option<Reg> {
    if let (StoreKind::I64, Place::FpReg(dr)) = (kind, place) {
        emit(code, enc_fmov_d_to_x(vs, dr));
        return Some(vs);
    }
    materialize_int(code, place, vs, frame)
}

/// Store FP register `vt`; under `bound` its bit pattern goes in GPR pieces.
fn emit_fp_store(
    code: &mut Vec<u8>,
    op: MemOp,
    vt: u8,
    rn: Reg,
    disp: i64,
    bound: Option<u32>,
    scratch: &ScratchPool,
) {
    let t = scratch_other(scratch, rn);
    let Some(a) = bound else {
        emit_mem(code, op, vt, rn, disp, t);
        return;
    };
    let (base, off) = bound_base(code, rn, disp, op.size(), op.size(), a, t);
    let vs = scratch_other(scratch, base);
    emit(code, enc_fmov_d_to_x(vs, vt));
    emit_narrow_store(code, vs, base, off, op.size(), a);
}

/// A value's `Place` as a register operand: a spill reloads into
/// `scratch`. `sp_shift` is an amount the caller has temporarily moved
/// sp down by (an outgoing-argument area), added to the slot offset.
pub(super) fn materialize_int(
    code: &mut Vec<u8>,
    place: Place,
    scratch: Reg,
    frame: Frame,
) -> Option<Reg> {
    materialize_int_shifted(code, place, scratch, frame, 0)
}

pub(super) fn materialize_int_shifted(
    code: &mut Vec<u8>,
    place: Place,
    scratch: Reg,
    frame: Frame,
    sp_shift: u32,
) -> Option<Reg> {
    let reg = int_operand_reg(place, scratch)?;
    if let Place::Spill(slot) = place {
        // The shift compensates a temporary sp move; the fp-based
        // dynamic-sp form is immune to it.
        let shift = if frame.dynamic_sp { 0 } else { sp_shift };
        let sp_off = spill_off(frame, slot) + shift;
        emit_spill_ldr_x(code, frame, scratch, sp_off);
    }
    Some(reg)
}

/// The register [`materialize_int`] leaves `place` in: its own, or `scratch`
/// for a spill.
pub(super) fn int_operand_reg(place: Place, scratch: Reg) -> Option<Reg> {
    match place {
        Place::IntReg(r) => Some(Reg(r)),
        Place::Spill(_) => Some(scratch),
        Place::FpReg(_) | Place::None => None,
    }
}

/// A floating-point value's `Place` as a d-register: a spill reloads
/// the 64-bit slot, an IntReg (a folded constant's bit pattern)
/// reinterprets through `fmov d, x`.
pub(super) fn materialize_fp(
    code: &mut Vec<u8>,
    place: Place,
    scratch_d: u8,
    frame: Frame,
) -> Option<u8> {
    reload_fp(code, place, scratch_d, frame, 0, false, Reg(16))
}

/// [`materialize_fp`] at a site that moved sp down by `sp_shift`. x16 holds
/// no operand during an FP lowering.
pub(super) fn materialize_fp_shifted(
    code: &mut Vec<u8>,
    place: Place,
    scratch_d: u8,
    frame: Frame,
    sp_shift: u32,
) -> Option<u8> {
    reload_fp(code, place, scratch_d, frame, sp_shift, false, Reg(16))
}

/// A single-precision value's `Place` as the s-view of a V register: an
/// IntReg holds the f32 bit pattern in its low 32 bits and reinterprets
/// through `fmov s, w`.
pub(super) fn materialize_fp_f32(
    code: &mut Vec<u8>,
    place: Place,
    scratch_d: u8,
    frame: Frame,
) -> Option<u8> {
    reload_fp(code, place, scratch_d, frame, 0, true, Reg(16))
}

/// The `materialize_fp*` reload; `single` moves an f32 bit pattern.
fn reload_fp(
    code: &mut Vec<u8>,
    place: Place,
    scratch_d: u8,
    frame: Frame,
    sp_shift: u32,
    single: bool,
    addr_scratch: Reg,
) -> Option<u8> {
    match place {
        Place::FpReg(r) => Some(r),
        Place::Spill(slot) => {
            let shift = if frame.dynamic_sp { 0 } else { sp_shift };
            let sp_off = spill_off(frame, slot) + shift;
            emit_spill_ldr_d(code, frame, scratch_d, sp_off, addr_scratch);
            Some(scratch_d)
        }
        Place::IntReg(r) => {
            let word = if single {
                enc_fmov_w_to_s(scratch_d, Reg(r))
            } else {
                enc_fmov_x_to_d(scratch_d, Reg(r))
            };
            emit(code, word);
            Some(scratch_d)
        }
        Place::None => None,
    }
}

/// `materialize_fp_f32` or `materialize_fp` by the value's f32 marker.
pub(super) fn materialize_fp_for(
    code: &mut Vec<u8>,
    v: super::super::ir::ValueId,
    place: Place,
    scratch_d: u8,
    frame: Frame,
    alloc: &Allocation,
) -> Option<u8> {
    if alloc.is_f32(v) {
        materialize_fp_f32(code, place, scratch_d, frame)
    } else {
        materialize_fp(code, place, scratch_d, frame)
    }
}

/// The register of a `Place::FpReg`; the s-view shares its index.
fn fp_reg(place: Place) -> Option<u8> {
    place.fp_reg_u8()
}

/// The register of a `Place::IntReg`.
pub(super) fn int_reg(p: Place) -> Option<Reg> {
    p.int_reg_u8().map(Reg)
}
