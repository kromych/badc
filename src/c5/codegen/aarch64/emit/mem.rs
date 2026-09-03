use super::*;

/// SP-relative byte offset of allocator spill `slot`.
pub(super) fn spill_off(frame: Frame, slot: u32) -> u32 {
    super::ssa::emit_common::spill_slot_sp_offset(frame.frame_bytes, frame.alloc_spill_base, slot)
}

/// Whether `off` fits the scaled unsigned-offset form of `LDR` / `STR`
/// for `access_size` (ARM ARM C6.2: imm12 holds `off / size`). The spill
/// region of a heavily spilling function exceeds it, so every
/// sp-relative spill access goes through the helpers below.
fn sp_imm12_in_range(off: u32, access_size: u32) -> bool {
    off.is_multiple_of(access_size) && (off / access_size) < 4096
}

/// An `ADD` / `SUB` (immediate) encoder: `(rd, rn, imm)`.
type AddSubImm = fn(Reg, Reg, u32) -> u32;

/// `dst = base + off` (`base - off` with `sub`) for any 32-bit
/// displacement: the shift-12 + remainder split of the immediate forms
/// (24-bit reach), past that the displacement built into `dst` and
/// applied with the register form, the extended one when the base is sp.
fn emit_reg_disp(code: &mut Vec<u8>, dst: Reg, base: Reg, off: u32, sub: bool) {
    if !super::encode::add_sub_imm24_in_range(off) {
        super::encode::load_imm64(code, dst, off as u64);
        let word = if sub {
            super::encode::enc_sub_reg(dst, base, dst)
        } else if base.0 == 31 {
            super::encode::enc_add_ext_reg(dst, base, dst)
        } else {
            super::encode::enc_add_reg(dst, base, dst)
        };
        emit(code, word);
        return;
    }
    let (imm, imm_lsl12): (AddSubImm, AddSubImm) = if sub {
        (enc_sub_imm, super::encode::enc_sub_imm_lsl12)
    } else {
        (enc_add_imm, super::encode::enc_add_imm_lsl12)
    };
    let hi = off & !0xfff;
    let lo = off & 0xfff;
    if hi != 0 {
        emit(code, imm_lsl12(dst, base, hi >> 12));
        if lo != 0 {
            emit(code, imm(dst, dst, lo));
        }
    } else {
        emit(code, imm(dst, base, lo));
    }
}

/// Materialise `sp + off` into `dst`.
pub(super) fn emit_sp_plus_off(code: &mut Vec<u8>, dst: Reg, off: u32) {
    emit_reg_disp(code, dst, Reg(31), off, false);
}

/// Materialise `fp + off` into `dst`.
pub(super) fn emit_fp_plus_off(code: &mut Vec<u8>, dst: Reg, off: u32) {
    emit_reg_disp(code, dst, Reg(29), off, false);
}

/// Materialise `fp - delta` into `dst`.
pub(super) fn emit_fp_minus_off(code: &mut Vec<u8>, dst: Reg, delta: u32) {
    emit_reg_disp(code, dst, Reg(29), delta, true);
}

/// SP-relative 8-byte load; past the imm12 reach the address is built
/// into `rt` itself.
pub(super) fn emit_sp_ldr_x(code: &mut Vec<u8>, rt: Reg, off: u32) {
    if sp_imm12_in_range(off, 8) {
        emit(code, enc_ldr_imm(rt, Reg(31), off));
    } else {
        emit_sp_plus_off(code, rt, off);
        emit(code, enc_ldr_imm(rt, rt, 0));
    }
}

/// SP-relative 8-byte store; `addr_scratch` (distinct from `rt`) carries
/// the base past the imm12 reach.
fn emit_sp_str_x(code: &mut Vec<u8>, rt: Reg, off: u32, addr_scratch: Reg) {
    if sp_imm12_in_range(off, 8) {
        emit(code, enc_str_imm(rt, Reg(31), off));
    } else {
        debug_assert_ne!(rt.0, addr_scratch.0, "sp str: addr scratch aliases data");
        emit_sp_plus_off(code, addr_scratch, off);
        emit(code, enc_str_imm(rt, addr_scratch, 0));
    }
}

/// `emit_sp_str_x` with the IP-pool scratch that differs from `rt`, for
/// sites where neither scratch is live.
pub(super) fn emit_sp_str_x_auto(code: &mut Vec<u8>, rt: Reg, off: u32) {
    let addr_scratch = if rt.0 == 16 { Reg(17) } else { Reg(16) };
    emit_sp_str_x(code, rt, off, addr_scratch);
}

/// SP-relative 8-byte store where only `borrow`, a live register, can
/// carry the base: it is pushed around the store and the displacement
/// compensates the 16-byte sp shift. The parallel-copy spill-to-spill
/// path, where both IP scratches hold cycle values.
fn emit_sp_str_x_borrow(code: &mut Vec<u8>, rt: Reg, off: u32, borrow: Reg) {
    if sp_imm12_in_range(off, 8) {
        emit(code, enc_str_imm(rt, Reg(31), off));
        return;
    }
    debug_assert_ne!(rt.0, borrow.0, "sp str borrow: borrow aliases data");
    emit(code, super::encode::enc_str_pre(borrow, Reg(31), -16));
    emit_sp_plus_off(code, borrow, off + 16);
    emit(code, enc_str_imm(rt, borrow, 0));
    emit(code, super::encode::enc_ldr_post(borrow, Reg(31), 16));
}

/// SP-relative 8-byte FP load; `addr_scratch` (a GPR) carries the base
/// past the reach.
fn emit_sp_ldr_d(code: &mut Vec<u8>, dt: u8, off: u32, addr_scratch: Reg) {
    if sp_imm12_in_range(off, 8) {
        emit(code, enc_ldr_d_imm(dt, Reg(31), off));
    } else {
        emit_sp_plus_off(code, addr_scratch, off);
        emit(code, enc_ldr_d_imm(dt, addr_scratch, 0));
    }
}

/// SP-relative 8-byte FP store.
fn emit_sp_str_d(code: &mut Vec<u8>, dt: u8, off: u32, addr_scratch: Reg) {
    if sp_imm12_in_range(off, 8) {
        emit(code, enc_str_d_imm(dt, Reg(31), off));
    } else {
        emit_sp_plus_off(code, addr_scratch, off);
        emit(code, enc_str_d_imm(dt, addr_scratch, 0));
    }
}

/// `emit_sp_str_d` with x16 as the address scratch, for FP lowerings
/// where x16 holds no operand.
pub(super) fn emit_sp_str_d_auto(code: &mut Vec<u8>, dt: u8, off: u32) {
    emit_sp_str_d(code, dt, off, Reg(16));
}

/// SP-relative 8-byte FP load using x16 as the address scratch.
pub(super) fn emit_sp_ldr_d_auto(code: &mut Vec<u8>, dt: u8, off: u32) {
    emit_sp_ldr_d(code, dt, off, Reg(16));
}

/// Allocator-spill accessors: a static frame reads `[sp + sp_off]`, a
/// dynamic-sp frame the same byte at `[fp - (frame_bytes - sp_off)]`
/// through `ldur` / `stur` in reach, else through the split displacement.
fn fp_spill_delta(frame: Frame, sp_off: u32) -> u32 {
    frame.frame_bytes - sp_off
}

/// Spill-slot 8-byte load; the fp-based out-of-reach form builds the
/// address into `rt`.
pub(super) fn emit_spill_ldr_x(code: &mut Vec<u8>, frame: Frame, rt: Reg, sp_off: u32) {
    if !frame.dynamic_sp {
        emit_sp_ldr_x(code, rt, sp_off);
        return;
    }
    let delta = fp_spill_delta(frame, sp_off);
    if delta <= 255 {
        emit(code, super::encode::enc_ldur(rt, Reg(29), -(delta as i32)));
    } else {
        emit_fp_minus_off(code, rt, delta);
        emit(code, enc_ldr_imm(rt, rt, 0));
    }
}

/// Spill-slot 8-byte store of `rt`; `addr_scratch` (distinct from
/// `rt`) carries the base when the displacement is out of reach.
pub(super) fn emit_spill_str_x(
    code: &mut Vec<u8>,
    frame: Frame,
    rt: Reg,
    sp_off: u32,
    addr_scratch: Reg,
) {
    if !frame.dynamic_sp {
        emit_sp_str_x(code, rt, sp_off, addr_scratch);
        return;
    }
    let delta = fp_spill_delta(frame, sp_off);
    if delta <= 255 {
        emit(code, super::encode::enc_stur(rt, Reg(29), -(delta as i32)));
    } else {
        debug_assert_ne!(rt.0, addr_scratch.0, "spill str: addr scratch aliases data");
        emit_fp_minus_off(code, addr_scratch, delta);
        emit(code, enc_str_imm(rt, addr_scratch, 0));
    }
}

/// `emit_spill_str_x` with the IP-pool scratch that differs from `rt`.
pub(super) fn emit_spill_str_x_auto(code: &mut Vec<u8>, frame: Frame, rt: Reg, sp_off: u32) {
    let addr_scratch = if rt.0 == 16 { Reg(17) } else { Reg(16) };
    emit_spill_str_x(code, frame, rt, sp_off, addr_scratch);
}

/// Spill-slot 8-byte store at a site where only `borrow` (a live
/// register, stack-saved around the store) can carry the base.
pub(super) fn emit_spill_str_x_borrow(
    code: &mut Vec<u8>,
    frame: Frame,
    rt: Reg,
    sp_off: u32,
    borrow: Reg,
) {
    if !frame.dynamic_sp {
        emit_sp_str_x_borrow(code, rt, sp_off, borrow);
        return;
    }
    let delta = fp_spill_delta(frame, sp_off);
    if delta <= 255 {
        emit(code, super::encode::enc_stur(rt, Reg(29), -(delta as i32)));
        return;
    }
    debug_assert_ne!(rt.0, borrow.0, "spill str borrow: borrow aliases data");
    emit(code, super::encode::enc_str_pre(borrow, Reg(31), -16));
    emit_fp_minus_off(code, borrow, delta);
    emit(code, enc_str_imm(rt, borrow, 0));
    emit(code, super::encode::enc_ldr_post(borrow, Reg(31), 16));
}

/// Spill-slot 8-byte FP load into d-reg `dt`; `addr_scratch` is a GPR.
fn emit_spill_ldr_d(code: &mut Vec<u8>, frame: Frame, dt: u8, sp_off: u32, addr_scratch: Reg) {
    if !frame.dynamic_sp {
        emit_sp_ldr_d(code, dt, sp_off, addr_scratch);
        return;
    }
    emit_fp_minus_off(code, addr_scratch, fp_spill_delta(frame, sp_off));
    emit(code, enc_ldr_d_imm(dt, addr_scratch, 0));
}

/// Spill-slot 8-byte FP store of d-reg `dt`; `addr_scratch` is a GPR.
fn emit_spill_str_d(code: &mut Vec<u8>, frame: Frame, dt: u8, sp_off: u32, addr_scratch: Reg) {
    if !frame.dynamic_sp {
        emit_sp_str_d(code, dt, sp_off, addr_scratch);
        return;
    }
    emit_fp_minus_off(code, addr_scratch, fp_spill_delta(frame, sp_off));
    emit(code, enc_str_d_imm(dt, addr_scratch, 0));
}

/// Spill-slot FP store / load with x16 as the address scratch.
pub(super) fn emit_spill_str_d_auto(code: &mut Vec<u8>, frame: Frame, dt: u8, sp_off: u32) {
    emit_spill_str_d(code, frame, dt, sp_off, Reg(16));
}

pub(super) fn emit_spill_ldr_d_auto(code: &mut Vec<u8>, frame: Frame, dt: u8, sp_off: u32) {
    emit_spill_ldr_d(code, frame, dt, sp_off, Reg(16));
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
            // Variant 1: the static TLS block sits 16 bytes (the TCB) above the
            // thread pointer, so the local-exec form is
            // `tp + tprel_hi12 + tprel_lo12` (24-bit TPOFF, two linker-patchable
            // immediates). A unit-local access bakes its TPOFF, a cross-unit one
            // the 16-byte reserve; both record an `elf_tpoff_fixups` entry at the
            // first add for the linker to rebase against the merged TLS layout.
            let tpoff = if tls_extern_sym.is_some() {
                16u32
            } else {
                (offset + 16) as u32
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
            emit(code, enc_ldr_reg_lsl3(Reg(16), Reg(16), Reg(17)));
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
    let (ld, st) = match width {
        8 => (
            enc_ldr_imm(temp, sbase, soff),
            enc_str_imm(temp, dbase, doff),
        ),
        4 => (
            super::encode::enc_ldr32_imm(temp, sbase, soff),
            super::encode::enc_str32_imm(temp, dbase, doff),
        ),
        2 => (
            enc_ldrh_imm(temp, sbase, soff),
            enc_strh_imm(temp, dbase, doff),
        ),
        _ => (
            enc_ldrb_imm(temp, sbase, soff),
            enc_strb_imm(temp, dbase, doff),
        ),
    };
    emit(code, ld);
    emit(code, st);
}

/// Zero-extending load of `width` bytes (8, 4, 2 or 1) from
/// `[base + off]` into `rt`.
fn enc_load_unit(width: u32, rt: Reg, base: Reg, off: u32) -> u32 {
    match width {
        8 => enc_ldr_imm(rt, base, off),
        4 => super::encode::enc_ldr32_imm(rt, base, off),
        2 => enc_ldrh_imm(rt, base, off),
        _ => enc_ldrb_imm(rt, base, off),
    }
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

/// `emit_agg_load_int` for an FP destination (`width` 8 for a
/// d-register, 4 for an s-register): the first piece arrives through
/// `fmov`, the rest through element inserts, so `tmp` is the only extra
/// register.
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
            if width == 8 {
                super::encode::enc_ldr_d_imm(dst, base, off)
            } else {
                super::encode::enc_ldr_s_imm(dst, base, off)
            },
        );
        return;
    }
    for (i, (o, w)) in super::super::access_pieces(off, width, align, strict_align).enumerate() {
        emit(code, enc_load_unit(w, tmp, base, o));
        if i == 0 {
            emit(
                code,
                if width == 8 {
                    super::encode::enc_fmov_x_to_d(dst, tmp)
                } else {
                    super::encode::enc_fmov_w_to_s(dst, tmp)
                },
            );
        } else {
            emit(code, super::encode::enc_ins_gen(dst, w, i as u32, tmp));
        }
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
    match width {
        8 => enc_str_imm(rt, base, off),
        4 => super::encode::enc_str32_imm(rt, base, off),
        2 => enc_strh_imm(rt, base, off),
        _ => enc_strb_imm(rt, base, off),
    }
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

/// fp-relative byte offset of c5 slot `off`. Locals and ordinary
/// parameter cells go through `c5_slot_to_fp_offset` at the frame's cell
/// stride. An AAPCS64 host variadic callee's named parameter (`off >= 2`)
/// is redirected to its slot in the register save area:
/// `[fp + 16 + int_rank*8]` in the general area, `[fp + 80 + fp_rank*16]`
/// in the vector area, the rank being its position within its
/// argument-register bank.
fn local_slot_off(off: i64, frame: Frame) -> i64 {
    if off >= 2 && frame.va_named_redirect {
        let p = (off - 2) as usize;
        // The shared planner puts the redirect on the placement the caller
        // produced; a parameter past the registers is on the incoming stack at
        // [fp + 208 + soff].
        let plan = super::plan_param_regs(frame.va_n_params, frame.va_param_fp_mask, frame.va_abi);
        match plan.placements.get(p) {
            Some(super::ArgPlacement::Stack(soff)) => {
                16 + AARCH64_VA_SAVE_BYTES as i64 + *soff as i64
            }
            Some(super::ArgPlacement::FpReg(_)) => {
                let fp_rank = plan.placements[..p]
                    .iter()
                    .filter(|q| matches!(q, super::ArgPlacement::FpReg(_)))
                    .count() as i64;
                16 + AARCH64_GR_SAVE_BYTES as i64 + fp_rank * 16
            }
            _ => {
                let int_rank = plan.placements[..p]
                    .iter()
                    .filter(|q| matches!(q, super::ArgPlacement::IntReg(_)))
                    .count() as i64;
                16 + int_rank * 8
            }
        }
    } else {
        c5_slot_to_fp_offset(off, frame.param_cell_stride, frame.canary_bytes)
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
    let Some(region_off) = over_aligned_region_off(off, func, frame) else {
        return emit_local_addr_fp(code, dst, off, frame);
    };
    if frame.align_region_off != 0 {
        return emit_fp_addr_bytes(code, dst, frame.align_region_off + region_off, frame);
    }
    let rd = match dst {
        Place::IntReg(r) => Reg(r),
        Place::Spill(_) => Reg(16),
        _ => {
            return fail("LocalAddr: dst not int reg / spill");
        }
    };
    emit_sp_plus_off(code, rd, region_off.max(0) as u32);
    store_spilled_int(code, frame, dst, rd);
    Ok(())
}

pub(super) fn emit_local_addr_fp(code: &mut Vec<u8>, dst: Place, off: i64, frame: Frame) -> Emit {
    emit_fp_addr_bytes(code, dst, local_slot_off(off, frame), frame)
}

/// Materialise `fp + bytes` into `dst` for any signed byte displacement.
fn emit_fp_addr_bytes(code: &mut Vec<u8>, dst: Place, bytes: i64, frame: Frame) -> Emit {
    let rd = match dst {
        Place::IntReg(r) => Reg(r),
        Place::Spill(_) => Reg(16),
        _ => {
            return fail("LocalAddr: dst not int reg / spill");
        }
    };
    let abs = bytes.unsigned_abs();
    // Up to imm12 fits in a single add/sub-imm.
    if abs < 4096 {
        let imm = abs as u32;
        if bytes >= 0 {
            emit(code, enc_add_imm(rd, Reg(29), imm));
        } else {
            emit(code, enc_sub_imm(rd, Reg(29), imm));
        }
        store_spilled_int(code, frame, dst, rd);
        return Ok(());
    }
    // The shift-12 + remainder split covers 24 bits.
    if abs < (1u64 << 24) {
        let hi = abs & !0xfff;
        let lo = abs & 0xfff;
        if bytes >= 0 {
            if hi != 0 {
                emit(
                    code,
                    super::encode::enc_add_imm_lsl12(rd, Reg(29), (hi >> 12) as u32),
                );
            }
            if lo != 0 {
                let base = if hi != 0 { rd } else { Reg(29) };
                emit(code, enc_add_imm(rd, base, lo as u32));
            }
        } else {
            if hi != 0 {
                emit(
                    code,
                    super::encode::enc_sub_imm_lsl12(rd, Reg(29), (hi >> 12) as u32),
                );
            }
            if lo != 0 {
                let base = if hi != 0 { rd } else { Reg(29) };
                emit(code, enc_sub_imm(rd, base, lo as u32));
            }
        }
        store_spilled_int(code, frame, dst, rd);
        return Ok(());
    }
    super::encode::load_imm64(code, rd, abs);
    if bytes >= 0 {
        emit(code, super::encode::enc_add_reg(rd, Reg(29), rd));
    } else {
        emit(code, super::encode::enc_sub_reg(rd, Reg(29), rd));
    }
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
    // `disp` is a width-aligned, in-range byte offset the index fold
    // produced, so it passes to the immediate-offset encoders and `bound`
    // reads as the base's alignment.
    let disp = disp as u32;
    let addr_place = place_of(alloc, addr);
    let rn = match materialize_int(code, addr_place, scratch.primary, frame) {
        Some(r) => r,
        None => return Err(Unsupported::unspecified()),
    };
    // F32 loads read the s-view; a single-precision value (C99 6.3.1.8)
    // stays f32, the untagged archive-reload value widens through
    // `fcvt Dd, Sn`.
    if let LoadKind::F32 = kind {
        let dd = match dst {
            Place::FpReg(r) => r,
            Place::Spill(_) => frame.fp_scratch[0],
            _ => {
                return fail("Load F32: dst not fp reg / spill");
            }
        };
        match bound {
            Some(a) => emit_agg_load_fp(code, dd, rn, disp, 4, a, true, scratch.secondary),
            None => emit(code, enc_ldr_s_imm(dd, rn, disp)),
        }
        if !keep_f32 {
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
    if let LoadKind::F64 = kind {
        // `double` lvalue: a single 8-byte FP load into a d-reg.
        let dd = match dst {
            Place::FpReg(r) => r,
            Place::Spill(_) => frame.fp_scratch[0],
            _ => {
                return fail("Load F64: dst not fp reg / spill");
            }
        };
        match bound {
            Some(a) => emit_agg_load_fp(code, dd, rn, disp, 8, a, true, scratch.secondary),
            None => emit(code, enc_ldr_d_imm(dd, rn, disp)),
        }
        store_spilled_fp(code, frame, dst, dd);
        return Ok(());
    }
    let rd = match dst {
        Place::IntReg(r) => Reg(r),
        Place::Spill(_) => scratch.secondary,
        Place::FpReg(_) | Place::None => return Err(Unsupported::unspecified()),
    };
    if let Some(a) = bound {
        emit_narrow_load(code, rd, rn, disp, kind, a);
        store_spilled_int(code, frame, dst, rd);
        return Ok(());
    }
    match kind {
        LoadKind::I64 => emit(code, enc_ldr_imm(rd, rn, disp)),
        LoadKind::I32 => emit(code, enc_ldrsw_imm(rd, rn, disp)),
        LoadKind::U32 => emit(code, enc_ldr32_imm(rd, rn, disp)),
        LoadKind::I16 => emit(code, enc_ldrsh_imm(rd, rn, disp)),
        LoadKind::U16 => emit(code, enc_ldrh_imm(rd, rn, disp)),
        LoadKind::I8 => emit(code, enc_ldrsb_imm(rd, rn, disp)),
        LoadKind::U8 => emit(code, enc_ldrb_imm(rd, rn, disp)),
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 => unreachable!(),
    }
    store_spilled_int(code, frame, dst, rd);
    Ok(())
}

/// The scaled unsigned displacement of an fp-relative FP access of
/// `size` bytes to local slot `off`, when the slot is an ordinary one and
/// the displacement is non-negative, a multiple of `size` and at most
/// `max`.
fn fp_scaled_disp(off: i64, frame: Frame, is_over: bool, size: u32, max: u32) -> Option<u32> {
    let disp = i32::try_from(local_slot_off(off, frame)).ok()?;
    if is_over || disp < 0 {
        return None;
    }
    let disp = disp as u32;
    (disp.is_multiple_of(size) && disp <= max).then_some(disp)
}

/// `Inst::LoadLocal`: one fp-relative instruction when the displacement
/// fits (the unscaled 9-bit field for an integer load, the scaled offset
/// for an FP one); otherwise, and for an over-aligned object (C11
/// 6.7.5), through the materialised address. A single-precision value
/// stays f32 (C99 6.3.1.8); the untagged archive-reload value widens.
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
    let is_over = over_aligned_region_off(off, func, frame).is_some();
    if matches!(kind, LoadKind::F32 | LoadKind::F64) {
        let Some(dd) = fp_or_spill_dst(dst, frame) else {
            return fail(if matches!(kind, LoadKind::F32) {
                "LoadLocal F32: dst not fp reg / spill"
            } else {
                "LoadLocal F64: dst not fp reg / spill"
            });
        };
        let (size, max) = if matches!(kind, LoadKind::F32) {
            (4, 16380)
        } else {
            (8, 32752)
        };
        let (base, disp) = match fp_scaled_disp(off, frame, is_over, size, max) {
            Some(disp) => (Reg(29), disp),
            None => {
                emit_local_addr(code, Place::IntReg(scratch.primary.0), off, func, frame)?;
                (scratch.primary, 0)
            }
        };
        if size == 4 {
            emit(code, super::encode::enc_ldr_s_imm(dd, base, disp));
            if !keep_f32 {
                emit(code, super::encode::enc_fcvt_d_s(dd, dd));
            }
        } else {
            emit(code, super::encode::enc_ldr_d_imm(dd, base, disp));
        }
        store_spilled_fp(code, frame, dst, dd);
        return Ok(());
    }
    if matches!(kind, LoadKind::F128) {
        let Some(dd) = fp_or_spill_dst(dst, frame) else {
            return fail("LoadLocal F128: dst not fp reg / spill");
        };
        emit_local_addr(code, Place::IntReg(scratch.primary.0), off, func, frame)?;
        super::binary128::emit_narrow_load(code, dd, scratch.primary, 0, None);
        store_spilled_fp(code, frame, dst, dd);
        return Ok(());
    }
    let rd = match dst {
        Place::IntReg(r) => Reg(r),
        Place::Spill(_) => scratch.secondary,
        Place::FpReg(_) | Place::None => return Err(Unsupported::unspecified()),
    };
    let bytes = local_slot_off(off, frame);
    let word = if let Ok(disp) = i32::try_from(bytes)
        && !is_over
        && (-256..256).contains(&disp)
    {
        match kind {
            LoadKind::I64 => super::encode::enc_ldur(rd, Reg(29), disp),
            LoadKind::I32 => super::encode::enc_ldursw(rd, Reg(29), disp),
            LoadKind::U32 => super::encode::enc_ldur32(rd, Reg(29), disp),
            LoadKind::I16 => super::encode::enc_ldursh(rd, Reg(29), disp),
            LoadKind::U16 => super::encode::enc_ldurh(rd, Reg(29), disp),
            LoadKind::I8 => super::encode::enc_ldursb(rd, Reg(29), disp),
            LoadKind::U8 => super::encode::enc_ldurb(rd, Reg(29), disp),
            LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 => unreachable!(),
        }
    } else {
        emit_local_addr(code, Place::IntReg(scratch.primary.0), off, func, frame)?;
        match kind {
            LoadKind::I64 => super::encode::enc_ldr_imm(rd, scratch.primary, 0),
            LoadKind::I32 => super::encode::enc_ldrsw_imm(rd, scratch.primary, 0),
            LoadKind::U32 => super::encode::enc_ldr32_imm(rd, scratch.primary, 0),
            LoadKind::I16 => super::encode::enc_ldrsh_imm(rd, scratch.primary, 0),
            LoadKind::U16 => super::encode::enc_ldrh_imm(rd, scratch.primary, 0),
            LoadKind::I8 => super::encode::enc_ldrsb_imm(rd, scratch.primary, 0),
            LoadKind::U8 => super::encode::enc_ldrb_imm(rd, scratch.primary, 0),
            LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 => unreachable!(),
        }
    };
    emit(code, word);
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
    let is_over = over_aligned_region_off(off, func, frame).is_some();
    let value_place = place_of(alloc, value);
    if matches!(kind, StoreKind::F32) {
        return emit_store_local_f32(
            code,
            dst,
            off,
            value,
            value_place,
            alloc,
            func,
            frame,
            scratch,
        );
    }
    if matches!(kind, StoreKind::F128) {
        let Some(dn) = materialize_fp(code, value_place, frame.fp_scratch[0], frame) else {
            return fail("StoreLocal F128: value not fp reg / spill / int reg");
        };
        emit_local_addr(code, Place::IntReg(scratch.secondary.0), off, func, frame)?;
        super::binary128::emit_widen_store(code, dn, scratch.secondary, 0, None);
        propagate_fp(code, frame, dst, dn);
        return Ok(());
    }
    if matches!(kind, StoreKind::F64) {
        let Some(dn) = materialize_fp(code, value_place, frame.fp_scratch[0], frame) else {
            return fail("StoreLocal F64: value not fp reg / spill / int reg");
        };
        let (base, disp) = match fp_scaled_disp(off, frame, is_over, 8, 32752) {
            Some(disp) => (Reg(29), disp),
            None => {
                emit_local_addr(code, Place::IntReg(scratch.secondary.0), off, func, frame)?;
                (scratch.secondary, 0)
            }
        };
        emit(code, super::encode::enc_str_d_imm(dn, base, disp));
        propagate_fp(code, frame, dst, dn);
        return Ok(());
    }
    // An FpReg value (an FP-typed accumulator spilled to a local temp)
    // bridges through `fmov x, d`.
    let rv = if let Place::FpReg(dr) = value_place {
        emit(code, super::encode::enc_fmov_d_to_x(scratch.primary, dr));
        scratch.primary
    } else {
        match materialize_int(code, value_place, scratch.primary, frame) {
            Some(r) => r,
            None => return Err(Unsupported::unspecified()),
        }
    };
    let bytes = local_slot_off(off, frame);
    if let Ok(disp) = i32::try_from(bytes)
        && (-256..256).contains(&disp)
        && !is_over
    {
        // The accumulator keeps the full source value: an assignment yields
        // the stored value before any re-narrowing on read-back (C99 6.5.16p3).
        let enc = match kind {
            StoreKind::I64 => super::encode::enc_stur(rv, Reg(29), disp),
            StoreKind::I32 => super::encode::enc_stur32(rv, Reg(29), disp),
            StoreKind::I16 => super::encode::enc_sturh(rv, Reg(29), disp),
            StoreKind::I8 => super::encode::enc_sturb(rv, Reg(29), disp),
            StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128 => {
                unreachable!()
            }
        };
        emit(code, enc);
    } else {
        emit_store_local_large_disp(code, off, rv, kind, func, scratch, frame)?;
    }
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
    off: i64,
    value: u32,
    value_place: Place,
    alloc: &Allocation,
    func: &FunctionSsa,
    frame: Frame,
    scratch: &ScratchPool,
) -> Emit {
    let is_over = over_aligned_region_off(off, func, frame).is_some();
    let store_to_slot = |code: &mut Vec<u8>, sn: u8| -> Emit {
        match fp_scaled_disp(off, frame, is_over, 4, 16376) {
            Some(disp) => emit(code, super::encode::enc_str_s_imm(sn, Reg(29), disp)),
            None => {
                emit_local_addr(code, Place::IntReg(scratch.secondary.0), off, func, frame)?;
                emit(code, super::encode::enc_str_s_imm(sn, scratch.secondary, 0));
            }
        }
        Ok(())
    };
    if alloc.is_f32(value) {
        let Some(sn) = materialize_fp_f32(code, value_place, frame.fp_scratch[0], frame) else {
            return fail("StoreLocal F32: value not fp reg / spill");
        };
        store_to_slot(code, sn)?;
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
                return Err(Unsupported::unspecified());
            };
            emit(code, enc_fmov_x_to_d(frame.fp_scratch[0], rs));
            frame.fp_scratch[0]
        }
        Place::None => {
            return fail("StoreLocal F32: value None");
        }
    };
    emit(code, super::encode::enc_fcvt_s_d(frame.fp_scratch[1], dn));
    store_to_slot(code, frame.fp_scratch[1])?;
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
        Place::FpReg(_) => return Err(Unsupported::unspecified()),
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

/// Address-via-scratch fallback for [`emit_store_local`] when the
/// fp displacement exceeds the unscaled 9-bit field.
fn emit_store_local_large_disp(
    code: &mut Vec<u8>,
    off: i64,
    rv: Reg,
    kind: StoreKind,
    func: &FunctionSsa,
    scratch: &ScratchPool,
    frame: Frame,
) -> Emit {
    emit_local_addr(code, Place::IntReg(scratch.secondary.0), off, func, frame)?;
    let enc = match kind {
        StoreKind::I64 => super::encode::enc_str_imm(rv, scratch.secondary, 0),
        StoreKind::I32 => super::encode::enc_str32_imm(rv, scratch.secondary, 0),
        StoreKind::I16 => super::encode::enc_strh_imm(rv, scratch.secondary, 0),
        StoreKind::I8 => super::encode::enc_strb_imm(rv, scratch.secondary, 0),
        StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128 => unreachable!(),
    };
    emit(code, enc);
    Ok(())
}

/// `Inst::LoadIndexed`: one scaled-indexed load
/// (`ldr Xt, [Xn, Xm, lsl #N]`) when `scale` is the natural width of
/// `kind`. TODO: the FP forms; the walker's indexed fold does not
/// produce them.
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
    scratch: &ScratchPool,
) -> Emit {
    if matches!(
        kind,
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128
    ) {
        return fail("LoadIndexed: FP not implemented");
    }
    let base_place = place_of(alloc, base);
    let index_place = place_of(alloc, index);
    let rn = match materialize_int(code, base_place, scratch.primary, frame) {
        Some(r) => r,
        None => return Err(Unsupported::unspecified()),
    };
    let rm = match materialize_int(code, index_place, scratch.secondary, frame) {
        Some(r) => r,
        None => return Err(Unsupported::unspecified()),
    };
    let rd = match dst {
        Place::IntReg(r) => Reg(r),
        Place::Spill(_) => scratch.secondary,
        Place::FpReg(_) | Place::None => return Err(Unsupported::unspecified()),
    };
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
    let word = match kind {
        LoadKind::I64 => super::encode::enc_ldr_reg_lsl3(rd, rn, rm),
        LoadKind::I32 => super::encode::enc_ldrsw_reg_lsl2(rd, rn, rm),
        LoadKind::U32 => super::encode::enc_ldr32_reg_lsl2(rd, rn, rm),
        LoadKind::I16 => super::encode::enc_ldrsh_reg_lsl1(rd, rn, rm),
        LoadKind::U16 => super::encode::enc_ldrh_reg_lsl1(rd, rn, rm),
        LoadKind::I8 => super::encode::enc_ldrsb_reg(rd, rn, rm),
        LoadKind::U8 => super::encode::enc_ldrb_reg(rd, rn, rm),
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 => unreachable!(),
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
    index: u32,
    scale: u8,
    value: u32,
    kind: StoreKind,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> Emit {
    if matches!(
        kind,
        StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128
    ) {
        return fail("StoreIndexed: FP not implemented");
    }
    let base_place = place_of(alloc, base);
    let index_place = place_of(alloc, index);
    let value_place = place_of(alloc, value);
    let rn = match materialize_int(code, base_place, scratch.primary, frame) {
        Some(r) => r,
        None => return Err(Unsupported::unspecified()),
    };
    let rm = match materialize_int(code, index_place, scratch.secondary, frame) {
        Some(r) => r,
        None => return Err(Unsupported::unspecified()),
    };
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
            super::encode::enc_add_reg_lsl(scratch.primary, rn, rm, shift),
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
            None => return Err(Unsupported::unspecified()),
        }
    };
    let word = match (kind, addr_reg) {
        (StoreKind::I64, None) => super::encode::enc_str_reg_lsl3(rv, rn, rm),
        (StoreKind::I32, None) => super::encode::enc_str32_reg_lsl2(rv, rn, rm),
        (StoreKind::I16, None) => super::encode::enc_strh_reg_lsl1(rv, rn, rm),
        (StoreKind::I8, None) => super::encode::enc_strb_reg(rv, rn, rm),
        (StoreKind::I64, Some(a)) => super::encode::enc_str_imm(rv, a, 0),
        (StoreKind::I32, Some(a)) => super::encode::enc_str32_imm(rv, a, 0),
        (StoreKind::I16, Some(a)) => super::encode::enc_strh_imm(rv, a, 0),
        (StoreKind::I8, Some(a)) => super::encode::enc_strb_imm(rv, a, 0),
        (StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128, _) => unreachable!(),
    };
    emit(code, word);
    propagate_int(code, frame, dst, rv)
}

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
    let disp = disp as u32;
    // The c5 store ops leave the stored value in the accumulator, which
    // `dst` may want in a register or spill slot.
    let addr_place = place_of(alloc, addr);
    let value_place = place_of(alloc, value);
    let rn = match materialize_int(code, addr_place, scratch.primary, frame) {
        Some(r) => r,
        None => return Err(Unsupported::unspecified()),
    };
    if let StoreKind::F32 = kind {
        // A single-precision value stores as is (C99 6.3.1.8); a double (the
        // archive-reload boundary, or an un-narrowed `double` assigned to a
        // `float` lvalue) narrows through `fcvt Sd, Dn`.
        if alloc.is_f32(value) {
            let sn = match materialize_fp_f32(code, value_place, frame.fp_scratch[0], frame) {
                Some(r) => r,
                None => return Err(Unsupported::unspecified()),
            };
            match bound {
                Some(a) => {
                    emit(code, enc_fmov_d_to_x(scratch.secondary, sn));
                    emit_narrow_store(code, scratch.secondary, rn, disp, 4, a);
                }
                None => emit(code, enc_str_s_imm(sn, rn, disp)),
            }
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
                let rs = match materialize_int(code, value_place, scratch.secondary, frame) {
                    Some(r) => r,
                    None => return Err(Unsupported::unspecified()),
                };
                emit(code, enc_fmov_x_to_d(frame.fp_scratch[0], rs));
                frame.fp_scratch[0]
            }
            Place::None => return Err(Unsupported::unspecified()),
        };
        // The narrowing writes the S view and zeroes the rest of the V
        // register, so it targets the second FP scratch, not an allocator-held
        // `dn`.
        emit(code, enc_fcvt_s_d(frame.fp_scratch[1], dn));
        match bound {
            Some(a) => {
                emit(
                    code,
                    enc_fmov_d_to_x(scratch.secondary, frame.fp_scratch[1]),
                );
                emit_narrow_store(code, scratch.secondary, rn, disp, 4, a);
            }
            None => emit(code, enc_str_s_imm(frame.fp_scratch[1], rn, disp)),
        }
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
    if let StoreKind::F128 = kind {
        let Some(dn) = materialize_fp(code, value_place, frame.fp_scratch[0], frame) else {
            return fail("Store F128: value not fp reg / spill / int reg");
        };
        let base = addr_outside_borrows(code, rn, scratch);
        super::binary128::emit_widen_store(code, dn, base, disp, bound);
        if let Some(rd) = fp_reg(dst) {
            if rd != dn {
                emit(code, super::encode::enc_fmov_d_d(rd, dn));
            }
        } else {
            store_spilled_fp(code, frame, dst, dn);
        }
        return Ok(());
    }
    if let StoreKind::F64 = kind {
        // `double` lvalue store: a single 8-byte FP store; no narrow.
        let Some(dn) = materialize_fp(code, value_place, frame.fp_scratch[0], frame) else {
            return Err(Unsupported::unspecified());
        };
        match bound {
            Some(a) => {
                emit(code, enc_fmov_d_to_x(scratch.secondary, dn));
                emit_narrow_store(code, scratch.secondary, rn, disp, 8, a);
            }
            None => emit(code, super::encode::enc_str_d_imm(dn, rn, disp)),
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
    // c5's f64 store path writes 8 raw bytes as `StoreKind::I64`, so an
    // FpReg value bridges through `fmov x, d`.
    let rs = if let StoreKind::I64 = kind
        && let Place::FpReg(dr) = value_place
    {
        emit(code, enc_fmov_d_to_x(scratch.secondary, dr));
        scratch.secondary
    } else {
        match materialize_int(code, value_place, scratch.secondary, frame) {
            Some(r) => r,
            None => return Err(Unsupported::unspecified()),
        }
    };
    match bound {
        Some(a) => emit_narrow_store(code, rs, rn, disp, int_store_width(kind), a),
        None => match kind {
            StoreKind::I64 => emit(code, enc_str_imm(rs, rn, disp)),
            StoreKind::I32 => emit(code, enc_str32_imm(rs, rn, disp)),
            StoreKind::I16 => emit(code, enc_strh_imm(rs, rn, disp)),
            StoreKind::I8 => emit(code, enc_strb_imm(rs, rn, disp)),
            StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128 => {
                unreachable!("FP store handled in the FP branch above")
            }
        },
    }
    if let Some(rd) = int_reg(dst) {
        if rd.0 != rs.0 {
            emit_mov_reg(code, rd, rs);
        }
    } else {
        store_spilled_int(code, frame, dst, rs);
    }
    Ok(())
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
    match place {
        Place::IntReg(r) => Some(Reg(r)),
        Place::Spill(slot) => {
            // The shift compensates a temporary sp move; the fp-based
            // dynamic-sp form is immune to it.
            let shift = if frame.dynamic_sp { 0 } else { sp_shift };
            let sp_off = spill_off(frame, slot) + shift;
            emit_spill_ldr_x(code, frame, scratch, sp_off);
            Some(scratch)
        }
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
    materialize_fp_shifted(code, place, scratch_d, frame, 0)
}

pub(super) fn materialize_fp_shifted(
    code: &mut Vec<u8>,
    place: Place,
    scratch_d: u8,
    frame: Frame,
    sp_shift: u32,
) -> Option<u8> {
    match place {
        Place::FpReg(r) => Some(r),
        Place::Spill(slot) => {
            // The shift compensates a temporary sp move; the fp-based
            // dynamic-sp form is immune to it.
            let shift = if frame.dynamic_sp { 0 } else { sp_shift };
            let sp_off = spill_off(frame, slot) + shift;
            // x16 carries the base past the imm12 reach; it holds no operand
            // during an FP lowering.
            emit_spill_ldr_d(code, frame, scratch_d, sp_off, Reg(16));
            Some(scratch_d)
        }
        // A constant-folded FP value is an `Imm` bit pattern in an IntReg.
        Place::IntReg(r) => {
            emit(code, enc_fmov_x_to_d(scratch_d, Reg(r)));
            Some(scratch_d)
        }
        Place::None => None,
    }
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
    match place {
        Place::FpReg(r) => Some(r),
        Place::Spill(slot) => {
            let sp_off = spill_off(frame, slot);
            emit_spill_ldr_d(code, frame, scratch_d, sp_off, Reg(16));
            Some(scratch_d)
        }
        Place::IntReg(r) => {
            emit(code, enc_fmov_w_to_s(scratch_d, Reg(r)));
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
