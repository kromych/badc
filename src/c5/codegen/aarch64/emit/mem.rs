use super::*;

/// SP-relative byte offset of allocator spill `slot` in the
/// current function's frame. Thin wrapper over the cross-target
/// math helper so the per-call sites read as `spill_off(frame,
/// slot)` rather than the four-argument call.
pub(super) fn spill_off(frame: Frame, slot: u32) -> u32 {
    super::ssa::emit_common::spill_slot_sp_offset(frame.frame_bytes, frame.alloc_spill_base, slot)
}

/// Largest byte displacement reachable by the scaled-imm12 unsigned-
/// offset form of `LDR`/`STR` for a given access size, per the
/// Arm Architecture Reference Manual C6.2 (load/store unsigned
/// immediate): the imm12 field holds `off / size` and is 12 bits, so
/// `off` ranges over `[0, 4095 * size]`. Beyond this the base address
/// must be materialised into a register. The frame's allocator spill
/// region can exceed this reach when a function spills heavily (one
/// 8-byte slot per spilled value), so every SP-relative spill access
/// routes through the helpers below rather than the raw encoders.
fn sp_imm12_in_range(off: u32, access_size: u32) -> bool {
    off.is_multiple_of(access_size) && (off / access_size) < 4096
}

/// Materialise `sp + off` into `dst`. Uses the shift-12 + remainder
/// split of `ADD (immediate)` (24-bit reach); past that the offset is
/// built into `dst` and applied with the extended-register form (the
/// only register add that accepts SP as the source).
fn emit_sp_plus_off(code: &mut Vec<u8>, dst: Reg, off: u32) {
    if !super::encode::add_sub_imm24_in_range(off) {
        super::encode::load_imm64(code, dst, off as u64);
        emit(code, super::encode::enc_add_ext_reg(dst, Reg(31), dst));
        return;
    }
    let hi = off & !0xfff;
    let lo = off & 0xfff;
    if hi != 0 {
        emit(
            code,
            super::encode::enc_add_imm_lsl12(dst, Reg(31), hi >> 12),
        );
        if lo != 0 {
            emit(code, enc_add_imm(dst, dst, lo));
        }
    } else {
        emit(code, enc_add_imm(dst, Reg(31), lo));
    }
}

/// Materialise `fp + off` into `dst` using the same shift-12 +
/// remainder split as `emit_sp_plus_off`, but based on fp (x29).
/// Used by the host-ABI variadic `va_start` to compute the
/// frame-relative address of the first variadic argument: the macOS
/// arm64 incoming-stack slot, or the Windows arm64 gr-save slot.
pub(super) fn emit_sp_plus_off_from_fp(code: &mut Vec<u8>, dst: Reg, off: u32) {
    if !super::encode::add_sub_imm24_in_range(off) {
        super::encode::load_imm64(code, dst, off as u64);
        emit(code, super::encode::enc_add_reg(dst, Reg(29), dst));
        return;
    }
    let hi = off & !0xfff;
    let lo = off & 0xfff;
    if hi != 0 {
        emit(
            code,
            super::encode::enc_add_imm_lsl12(dst, Reg(29), hi >> 12),
        );
        if lo != 0 {
            emit(code, enc_add_imm(dst, dst, lo));
        }
    } else {
        emit(code, enc_add_imm(dst, Reg(29), lo));
    }
}

/// SP-relative 8-byte load into `rt` with automatic out-of-reach
/// handling. When `off` exceeds the scaled-imm12 reach the address is
/// built into `rt` itself (the loaded value overwrites it), so no
/// extra scratch is consumed.
pub(super) fn emit_sp_ldr_x(code: &mut Vec<u8>, rt: Reg, off: u32) {
    if sp_imm12_in_range(off, 8) {
        emit(code, enc_ldr_imm(rt, Reg(31), off));
    } else {
        emit_sp_plus_off(code, rt, off);
        emit(code, enc_ldr_imm(rt, rt, 0));
    }
}

/// SP-relative 8-byte store of `rt`. A store needs the data and the
/// computed address in distinct registers, so `addr_scratch` (which
/// must differ from `rt`) carries the base when `off` is out of reach.
fn emit_sp_str_x(code: &mut Vec<u8>, rt: Reg, off: u32, addr_scratch: Reg) {
    if sp_imm12_in_range(off, 8) {
        emit(code, enc_str_imm(rt, Reg(31), off));
    } else {
        debug_assert_ne!(rt.0, addr_scratch.0, "sp str: addr scratch aliases data");
        emit_sp_plus_off(code, addr_scratch, off);
        emit(code, enc_str_imm(rt, addr_scratch, 0));
    }
}

/// SP-relative 8-byte store of `rt`, picking an address scratch from
/// the IP pool that differs from the data register. Use at sites where
/// neither scratch is otherwise live across the store.
pub(super) fn emit_sp_str_x_auto(code: &mut Vec<u8>, rt: Reg, off: u32) {
    let addr_scratch = if rt.0 == 16 { Reg(17) } else { Reg(16) };
    emit_sp_str_x(code, rt, off, addr_scratch);
}

/// SP-relative 8-byte store of `rt` at a site where no register other
/// than `rt` is free to carry the base. The borrowed register is saved
/// to the stack with a pre-index push, which shifts SP by 16; the
/// stored displacement is compensated so it still targets the original
/// slot. Used by the parallel-copy spill-to-spill path, where both IP
/// scratches may hold live cycle values.
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

/// SP-relative 8-byte FP load into d-reg `dt`. The base address is
/// built into `addr_scratch` (a GPR) when out of reach.
fn emit_sp_ldr_d(code: &mut Vec<u8>, dt: u8, off: u32, addr_scratch: Reg) {
    if sp_imm12_in_range(off, 8) {
        emit(code, enc_ldr_d_imm(dt, Reg(31), off));
    } else {
        emit_sp_plus_off(code, addr_scratch, off);
        emit(code, enc_ldr_d_imm(dt, addr_scratch, 0));
    }
}

/// SP-relative 8-byte FP store of d-reg `dt`. `addr_scratch` carries
/// the base when out of reach.
fn emit_sp_str_d(code: &mut Vec<u8>, dt: u8, off: u32, addr_scratch: Reg) {
    if sp_imm12_in_range(off, 8) {
        emit(code, enc_str_d_imm(dt, Reg(31), off));
    } else {
        emit_sp_plus_off(code, addr_scratch, off);
        emit(code, enc_str_d_imm(dt, addr_scratch, 0));
    }
}

/// SP-relative 8-byte FP store using x16 as the address scratch. Use
/// at sites lowering an FP value, where the GPR scratch holds no live
/// int operand.
pub(super) fn emit_sp_str_d_auto(code: &mut Vec<u8>, dt: u8, off: u32) {
    emit_sp_str_d(code, dt, off, Reg(16));
}

/// SP-relative 8-byte FP load using x16 as the address scratch.
pub(super) fn emit_sp_ldr_d_auto(code: &mut Vec<u8>, dt: u8, off: u32) {
    emit_sp_ldr_d(code, dt, off, Reg(16));
}

/// Allocator-spill accessors. A static frame reads the slot at
/// `[sp + sp_off]`; a dynamic-sp frame (alloca / VLA,
/// `Frame::dynamic_sp`) reads the same byte at
/// `[fp - (frame_bytes - sp_off)]`, since sp moves at runtime while fp
/// stays put. The fp displacement uses the unscaled-signed `ldur` /
/// `stur` form in reach, else builds the address with the imm12 +
/// shift-12 split.
fn fp_spill_delta(frame: Frame, sp_off: u32) -> u32 {
    frame.frame_bytes - sp_off
}

/// Materialise `fp - delta` into `dst` (imm12 + shift-12 split, then
/// the register form past the 24-bit reach).
pub(super) fn emit_fp_minus_off(code: &mut Vec<u8>, dst: Reg, delta: u32) {
    if !super::encode::add_sub_imm24_in_range(delta) {
        super::encode::load_imm64(code, dst, delta as u64);
        emit(code, super::encode::enc_sub_reg(dst, Reg(29), dst));
        return;
    }
    let hi = delta & !0xfff;
    let lo = delta & 0xfff;
    if hi != 0 {
        emit(
            code,
            super::encode::enc_sub_imm_lsl12(dst, Reg(29), hi >> 12),
        );
        if lo != 0 {
            emit(code, enc_sub_imm(dst, dst, lo));
        }
    } else {
        emit(code, enc_sub_imm(dst, Reg(29), lo));
    }
}

/// Spill-slot 8-byte load into `rt`. The fp-based out-of-reach form
/// builds the address into `rt` itself, mirroring [`emit_sp_ldr_x`].
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

/// Spill-slot 8-byte store picking an IP-pool address scratch that
/// differs from the data register.
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
fn fp_or_spill_dst(dst: Place, frame: Frame) -> Option<u8> {
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

/// `Inst::TlsAddr` lowering. Routes through the per-target TLS
/// access shape -- Linux variant 1 (TPIDR_EL0 + tcb + offset),
/// Windows TEB->TLS slot via `_tls_index` and the per-thread
/// pointer table at `[x18, #0x58]`, or Apple's TLV descriptor
/// table with the bootstrap getter. The 12-bit add immediate
/// limit on the per-variable offset matches the pool path; any
/// `_Thread_local` larger than 4080 bytes from `.tdata` falls
/// back to the pool path through the false return.
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
    // Set for a cross-unit `extern _Thread_local` access: the variable's
    // name. The descriptor is keyed by symbol (the linker resolves the
    // offset) rather than by the placeholder `offset`.
    tls_extern_sym: Option<&str>,
) -> bool {
    use super::encode::{enc_add_imm_lsl12, enc_blr, enc_ldr_reg_lsl3, enc_mrs_tpidr_el0};
    // A spilled destination materialises in the scratch every other
    // address-producing lowering uses, then stores to the slot; x17 stays
    // free for the store's base, and the three sequences below only read
    // `rd` after their last use of x16.
    let rd = match dst {
        Place::IntReg(r) => Reg(r),
        Place::Spill(_) => Reg(16),
        _ => {
            bail_msg("TlsAddr: dst not int reg / spill");
            return false;
        }
    };
    let emitted = match target {
        Target::LinuxAarch64 => {
            // AAPCS64 variant-1: the static TLS block sits above the thread
            // pointer after a 16-byte TCB reserve, so a variable at
            // `offset` in its unit's block reads `tp + 16 + offset`. The
            // local-exec form is the standard two-add sequence
            // (`tprel_hi12` + `tprel_lo12`), which covers a 24-bit TPOFF
            // and gives the linker two patchable immediates. A unit-local
            // access bakes the single-unit TPOFF; a cross-unit extern
            // bakes the 16-byte reserve as a placeholder. Both record an
            // `elf_tpoff_fixups` entry (at the first add) so the linker
            // rebases the pair against the merged TLS layout.
            let tpoff = if tls_extern_sym.is_some() {
                16u32
            } else {
                (offset + 16) as u32
            };
            if tpoff >= (1 << 24) {
                bail_msg("TlsAddr: tpoff exceeds the hi12/lo12 range");
                return false;
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
            true
        }
        Target::WindowsAarch64 => {
            // Windows/aarch64 TLS: x18 is the TEB pointer per the
            // platform ABI; TEB+0x58 holds the per-thread TLS
            // array. Index by `_tls_index` (loaded into x17) and
            // pick the slot for this module; x16 then holds the
            // module's TLS block base. x16 and x17 are AAPCS64
            // scratches outside the SSA allocator pool
            // (callee=[20..27], caller=[9..15]). A unit-local
            // access bakes the variable's offset within its own
            // block into the final `add`. A cross-unit `extern
            // _Thread_local` offset is unknown until the link
            // merges the TLS blocks, so emit a 0 placeholder and
            // record an `elf_tpoff_fixups` entry keyed by symbol;
            // the linker resolves it against the merged TLS layout
            // and rewrites the `add` imm12. The TEB path indexes a
            // module-relative block, so the offset baked in is the
            // raw block offset with no thread-pointer bias -- the
            // linker tells this path apart from the variant-1 ELF
            // path by the `_tls_index` fixup the TEB sequence
            // always records.
            if tls_extern_sym.is_none() && offset >= 4096 {
                bail_msg("TlsAddr: offset exceeds 12-bit add immediate");
                return false;
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
            // Both forms record a fixup so the linker rebases the imm12 to
            // the variable's offset in the merged TLS block: a unit-local
            // access is correct only when its defining unit sits at block
            // base 0, and the same variable read `extern` from another unit
            // must resolve to the identical offset.
            elf_tpoff_fixups.push(super::ElfTpoffFixup {
                imm_offset: add_off,
                target: match tls_extern_sym {
                    Some(name) => super::ElfTpoffTarget::Extern(name.into()),
                    None => super::ElfTpoffTarget::Local(offset as u64),
                },
            });
            true
        }
        Target::MacOSAarch64 => {
            // A unit-local access dedups by offset (one descriptor per
            // variable). A cross-unit extern access dedups by symbol --
            // its `offset_in_block` is a placeholder the linker fills, so
            // distinct externs must not collapse onto one offset-0 slot.
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
            true
        }
        _ => {
            bail_msg("TlsAddr: target not aarch64");
            false
        }
    };
    if emitted {
        spill_local_addr_to_dst(code, dst, rd, frame);
    }
    emitted
}

/// Compile-time-unrolled struct copy. `size` bytes from [src] to
/// [dst]; emits 8-byte ldr/str pairs for whole words and a
/// ldrb/strb tail for any sub-word remainder. The defined value
/// is `dst` -- mirrors C's `memcpy(dst, src, size)` return.
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

/// Load `width` bytes at `[base + off]` into the integer register
/// `dst`, using no access wider than `align` proves at that address
/// (see [`super::super::access_pieces`]). `tmp` holds each narrow
/// piece; it must differ from `base` and `dst`, and stays untouched
/// when one access suffices -- the only case in which `dst` may alias
/// `base`.
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

/// As [`emit_agg_load_int`] with an FP register destination (`width`
/// 8 for a d-register, 4 for an s-register). The value composes in the
/// vector register itself, so `tmp` is the only register needed beyond
/// `base`: the first piece arrives through `fmov` (which clears the
/// element bits above it), the rest through element inserts.
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

/// Alignment a scalar access must respect, or `None` when it may keep
/// its natural width: an access carries a bound only where the walker
/// proved one, and only `-mstrict-align` acts on it.
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
/// piece temp. They sit in the allocator's pool, so each is saved and
/// restored across the sequence; nothing between the save and the
/// restore addresses `sp`. Mirrors the reservation `emit_mcpy` makes.
pub(crate) const NARROW_BORROW: [u8; 7] = [9, 10, 11, 12, 13, 14, 15];

/// The first `N` borrow registers distinct from every register in
/// `avoid`. The pool is larger than any caller's avoid set, so the
/// pick always succeeds.
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

/// Translate a c5-stack slot index (the operand of an
/// address-of-local emit) into a byte offset relative to fp.
/// Mirror of the pool path's
use super::ssa::emit_common::c5_slot_to_fp_offset;

/// fp-relative byte offset of a c5 slot. Locals (`off < 0`) and the
/// ordinary parameter cells go through `c5_slot_to_fp_offset` at the
/// frame's cell stride. For an AAPCS64 host variadic callee (Linux
/// aarch64) the named parameters are not pushed as cdecl cells -- they
/// arrive in the argument registers and the prologue spills them into
/// the register save area above the saved fp/lr. A named-parameter
/// access (`off >= 2`, parameter index `off - 2`) is therefore
/// redirected to that parameter's slot in the save area: an integer /
/// pointer parameter to `[fp + 16 + int_rank*8]` within the 64-byte
/// general area, a floating-point parameter to
/// `[fp + 16 + 64 + fp_rank*16]` within the 128-byte vector area, where
/// the rank is the parameter's position within its argument-register
/// bank (the independent int / FP banks of AAPCS64 6.4.1). Locals are
/// unaffected.
fn local_slot_off(off: i64, frame: Frame) -> i64 {
    if off >= 2 && frame.va_named_redirect {
        let p = (off - 2) as usize;
        // Named parameters arrive per AAPCS64 6.4.1: the first eight integer
        // and eight floating-point parameters in the argument-register banks
        // (the prologue spills them into the general / vector save area), the
        // rest on the incoming stack. Use the shared planner so the redirect
        // lands on the same placement the caller produced. The save area sits
        // at `[fp + 16 .. fp + 208)`: general area (x0..x7) at
        // `[fp + 16 .. fp + 80)`, vector area (q0..q7) at `[fp + 80 ..
        // fp + 208)`; the incoming stack overflow begins at `[fp + 208 ..)`.
        let plan = super::plan_param_regs(frame.va_n_params, frame.va_param_fp_mask, frame.va_abi);
        match plan.placements.get(p) {
            Some(super::ArgPlacement::Stack(soff)) => {
                // Overflow named parameter: read from the incoming stack at
                // [fp + 208 + soff], past the register save area.
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

/// Region byte offset of an over-aligned automatic object's storage in the
/// frame's over-aligned region (C11 6.7.5), or None for an ordinary slot. The
/// region base is sp when the prologue realigned (`realign_align` > 0) and
/// `fp + align_region_off` for the static 16-aligned placement.
fn over_aligned_region_off(off: i64, func: &FunctionSsa, frame: Frame) -> Option<i64> {
    if off >= 0 || (frame.realign_align == 0 && frame.align_region_off == 0) {
        return None;
    }
    func.over_aligned
        .iter()
        .find(|&&(s, _)| s == off)
        .map(|&(_, region_off)| region_off)
}

/// Address of a local slot, redirecting an over-aligned automatic object to its
/// storage in the over-aligned region (C11 6.7.5). Callers that only
/// address synthetic / parameter slots (never over-aligned) use
/// [`emit_local_addr_fp`] directly and need no `func`.
pub(super) fn emit_local_addr(
    code: &mut Vec<u8>,
    dst: Place,
    off: i64,
    func: &FunctionSsa,
    frame: Frame,
) -> bool {
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
            bail_msg("LocalAddr: dst not int reg / spill");
            return false;
        }
    };
    // `rd = sp + region_off`, through the shared sp-relative helper so an
    // offset past the immediate reach materialises rather than truncating.
    emit_sp_plus_off(code, rd, region_off.max(0) as u32);
    spill_local_addr_to_dst(code, dst, rd, frame);
    true
}

pub(super) fn emit_local_addr_fp(code: &mut Vec<u8>, dst: Place, off: i64, frame: Frame) -> bool {
    emit_fp_addr_bytes(code, dst, local_slot_off(off, frame), frame)
}

/// Materialise `fp + bytes` into `dst` for any signed byte displacement.
fn emit_fp_addr_bytes(code: &mut Vec<u8>, dst: Place, bytes: i64, frame: Frame) -> bool {
    // Materialise the address through scratch.primary when the
    // allocator chose a spill slot for this LocalAddr, then store
    // the computed value into the spill slot. Register places
    // address straight into the chosen reg.
    let rd = match dst {
        Place::IntReg(r) => Reg(r),
        Place::Spill(_) => Reg(16),
        _ => {
            bail_msg("LocalAddr: dst not int reg / spill");
            return false;
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
        spill_local_addr_to_dst(code, dst, rd, frame);
        return true;
    }
    // 24-bit reach via two add/sub-imm: shift-12 hi half + plain
    // lo half.
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
        spill_local_addr_to_dst(code, dst, rd, frame);
        return true;
    }
    // Past the 24-bit immediate reach: build the displacement and apply
    // it with the register form.
    super::encode::load_imm64(code, rd, abs);
    if bytes >= 0 {
        emit(code, super::encode::enc_add_reg(rd, Reg(29), rd));
    } else {
        emit(code, super::encode::enc_sub_reg(rd, Reg(29), rd));
    }
    spill_local_addr_to_dst(code, dst, rd, frame);
    true
}

/// Pick the working register for a single-result int inst:
/// the allocator's chosen reg when it picked one, or
/// `scratch.primary` when the result will land in a spill slot.
/// FpReg / None destinations return `None` so the caller can
/// bail.
pub(super) fn int_or_spill_scratch(dst: Place, scratch: &ScratchPool) -> Option<Reg> {
    match dst {
        Place::IntReg(r) => Some(Reg(r)),
        Place::Spill(_) => Some(scratch.primary),
        Place::FpReg(_) | Place::None => None,
    }
}

/// Persist the just-computed LocalAddr value into its spill slot
/// when the allocator placed it there. No-op for register places
/// (the address already landed in the chosen reg).
pub(super) fn spill_local_addr_to_dst(code: &mut Vec<u8>, dst: Place, src: Reg, frame: Frame) {
    if let Place::Spill(slot) = dst {
        let sp_off = spill_off(frame, slot);
        // `emit_local_addr` already chose `src` from the scratch pool;
        // the other scratch carries the base when the slot is beyond
        // the scaled-imm12 reach.
        let addr_scratch = if src.0 == 16 { Reg(17) } else { Reg(16) };
        emit_spill_str_x(code, frame, src, sp_off, addr_scratch);
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
) -> bool {
    // `disp` is a byte offset folded from a constant pointer addition.
    // index_fold only emits a displacement that is a multiple of the
    // access width and within the scaled-immediate range, so it passes
    // straight to the immediate-offset encoders below. That multiple
    // also lets `bound` -- recorded for the accessed address -- be read
    // as an alignment of the base that `disp` then advances.
    let disp = disp as u32;
    let addr_place = alloc
        .places
        .get(addr as usize)
        .copied()
        .unwrap_or(Place::None);
    let rn = match materialize_int(code, addr_place, scratch.primary, frame) {
        Some(r) => r,
        None => return false,
    };
    // F32 loads read into the s-view of a v-register. When the value is
    // single-precision (C99 6.3.1.8), it stays f32 (no widen). The
    // archive-reload path (lift_program) leaves the value untagged and
    // consumes it as f64, so widen via `fcvt Dd, Sn` there.
    if let LoadKind::F32 = kind {
        let dd = match dst {
            Place::FpReg(r) => r,
            // A spilled f32 / f64 stages through a reserved scratch
            // d-reg outside the allocator's banks; d0 may hold a
            // live value the caller still needs.
            Place::Spill(_) => frame.fp_scratch[0],
            _ => {
                bail_msg("Load F32: dst not fp reg / spill");
                return false;
            }
        };
        match bound {
            Some(a) => emit_agg_load_fp(code, dd, rn, disp, 4, a, true, scratch.secondary),
            None => emit(code, enc_ldr_s_imm(dd, rn, disp)),
        }
        if !keep_f32 {
            emit(code, enc_fcvt_d_s(dd, dd));
        }
        if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit_spill_str_d_auto(code, frame, dd, sp_off);
        }
        return true;
    }
    if let LoadKind::F128 = kind {
        let Some(dd) = fp_or_spill_dst(dst, frame) else {
            bail_msg("Load F128: dst not fp reg / spill");
            return false;
        };
        let base = addr_outside_borrows(code, rn, scratch);
        super::binary128::emit_narrow_load(code, dd, base, disp, bound);
        if let Place::Spill(slot) = dst {
            emit_spill_str_d_auto(code, frame, dd, spill_off(frame, slot));
        }
        return true;
    }
    if let LoadKind::F64 = kind {
        // `double` lvalue: a single 8-byte FP load into a d-reg.
        let dd = match dst {
            Place::FpReg(r) => r,
            Place::Spill(_) => frame.fp_scratch[0],
            _ => {
                bail_msg("Load F64: dst not fp reg / spill");
                return false;
            }
        };
        match bound {
            Some(a) => emit_agg_load_fp(code, dd, rn, disp, 8, a, true, scratch.secondary),
            None => emit(code, enc_ldr_d_imm(dd, rn, disp)),
        }
        if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit_spill_str_d_auto(code, frame, dd, sp_off);
        }
        return true;
    }
    let rd = match dst {
        Place::IntReg(r) => Reg(r),
        Place::Spill(_) => scratch.secondary,
        Place::FpReg(_) | Place::None => return false,
    };
    if let Some(a) = bound {
        emit_narrow_load(code, rd, rn, disp, kind, a);
        if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit_spill_str_x_auto(code, frame, rd, sp_off);
        }
        return true;
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
    if let Place::Spill(slot) = dst {
        let sp_off = spill_off(frame, slot);
        emit_spill_str_x_auto(code, frame, rd, sp_off);
    }
    true
}

/// Single-instruction fp-relative load for `Inst::LoadLocal`.
/// The c5 slot offset converts to a signed byte displacement;
/// `ldur` covers the unscaled 9-bit field `[-256, 255]`
/// directly. Falls back to the general path when the
/// displacement doesn't fit.
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
) -> bool {
    // An over-aligned automatic object lives sp-relative in the realigned
    // region, not fp-relative; route it through `emit_local_addr` and load
    // through the materialised address (C11 6.7.5).
    let is_over = over_aligned_region_off(off, func, frame).is_some();
    // F32 reads into the s-view of a v-register. A single-precision
    // value (C99 6.3.1.8) stays f32; the archive-reload path leaves it
    // untagged and widens to f64 via `fcvt Dd, Sn`.
    if matches!(kind, LoadKind::F32) {
        let dd = match dst {
            Place::FpReg(r) => r,
            // Stage a spilled load through a reserved scratch d-reg
            // outside the allocator's banks; d0 may hold a
            // live value the caller still needs.
            Place::Spill(_) => frame.fp_scratch[0],
            _ => {
                bail_msg("LoadLocal F32: dst not fp reg / spill");
                return false;
            }
        };
        let bytes = local_slot_off(off, frame);
        if let Ok(disp) = i32::try_from(bytes)
            && !is_over
            && disp >= 0
            && (disp as u32).is_multiple_of(4)
            && (disp as u32) <= 16380
        {
            emit(code, super::encode::enc_ldr_s_imm(dd, Reg(29), disp as u32));
        } else if !emit_local_addr(code, Place::IntReg(scratch.primary.0), off, func, frame) {
            return false;
        } else {
            emit(code, super::encode::enc_ldr_s_imm(dd, scratch.primary, 0));
        }
        if !keep_f32 {
            emit(code, super::encode::enc_fcvt_d_s(dd, dd));
        }
        if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit_spill_str_d_auto(code, frame, dd, sp_off);
        }
        return true;
    }
    if matches!(kind, LoadKind::F128) {
        let Some(dd) = fp_or_spill_dst(dst, frame) else {
            bail_msg("LoadLocal F128: dst not fp reg / spill");
            return false;
        };
        if !emit_local_addr(code, Place::IntReg(scratch.primary.0), off, func, frame) {
            return false;
        }
        super::binary128::emit_narrow_load(code, dd, scratch.primary, 0, None);
        if let Place::Spill(slot) = dst {
            emit_spill_str_d_auto(code, frame, dd, spill_off(frame, slot));
        }
        return true;
    }
    if matches!(kind, LoadKind::F64) {
        // `double` local: a single 8-byte FP load; no widen.
        let dd = match dst {
            Place::FpReg(r) => r,
            Place::Spill(_) => frame.fp_scratch[0],
            _ => {
                bail_msg("LoadLocal F64: dst not fp reg / spill");
                return false;
            }
        };
        let bytes = local_slot_off(off, frame);
        if let Ok(disp) = i32::try_from(bytes)
            && !is_over
            && disp >= 0
            && (disp as u32).is_multiple_of(8)
            && (disp as u32) < 32760
        {
            emit(code, super::encode::enc_ldr_d_imm(dd, Reg(29), disp as u32));
        } else if !emit_local_addr(code, Place::IntReg(scratch.primary.0), off, func, frame) {
            return false;
        } else {
            emit(code, super::encode::enc_ldr_d_imm(dd, scratch.primary, 0));
        }
        if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit_spill_str_d_auto(code, frame, dd, sp_off);
        }
        return true;
    }
    let rd = match dst {
        Place::IntReg(r) => Reg(r),
        Place::Spill(_) => scratch.secondary,
        Place::FpReg(_) | Place::None => return false,
    };
    let bytes = local_slot_off(off, frame);
    if let Ok(disp) = i32::try_from(bytes)
        && !is_over
        && (-256..256).contains(&disp)
    {
        // Fits the unscaled 9-bit signed field; load directly
        // with the kind-specific unscaled encoder.
        let word = match kind {
            LoadKind::I64 => super::encode::enc_ldur(rd, Reg(29), disp),
            LoadKind::I32 => super::encode::enc_ldursw(rd, Reg(29), disp),
            LoadKind::U32 => super::encode::enc_ldur32(rd, Reg(29), disp),
            LoadKind::I16 => super::encode::enc_ldursh(rd, Reg(29), disp),
            LoadKind::U16 => super::encode::enc_ldurh(rd, Reg(29), disp),
            LoadKind::I8 => super::encode::enc_ldursb(rd, Reg(29), disp),
            LoadKind::U8 => super::encode::enc_ldurb(rd, Reg(29), disp),
            LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 => unreachable!(),
        };
        emit(code, word);
        if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit_spill_str_x_auto(code, frame, rd, sp_off);
        }
        return true;
    }
    // Large displacement (or an over-aligned sp-relative object): materialise
    // the address into a scratch through the standard `LocalAddr` lowering,
    // then load through it. Same byte cost as the unfused path.
    if !emit_local_addr(code, Place::IntReg(scratch.primary.0), off, func, frame) {
        return false;
    }
    let word = match kind {
        LoadKind::I64 => super::encode::enc_ldr_imm(rd, scratch.primary, 0),
        LoadKind::I32 => super::encode::enc_ldrsw_imm(rd, scratch.primary, 0),
        LoadKind::U32 => super::encode::enc_ldr32_imm(rd, scratch.primary, 0),
        LoadKind::I16 => super::encode::enc_ldrsh_imm(rd, scratch.primary, 0),
        LoadKind::U16 => super::encode::enc_ldrh_imm(rd, scratch.primary, 0),
        LoadKind::I8 => super::encode::enc_ldrsb_imm(rd, scratch.primary, 0),
        LoadKind::U8 => super::encode::enc_ldrb_imm(rd, scratch.primary, 0),
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 => unreachable!(),
    };
    emit(code, word);
    if let Place::Spill(slot) = dst {
        let sp_off = spill_off(frame, slot);
        emit_spill_str_x_auto(code, frame, rd, sp_off);
    }
    true
}

/// Single-instruction fp-relative store for `Inst::StoreLocal`.
/// Mirrors [`emit_load_local`].
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
) -> bool {
    // An over-aligned automatic object lives sp-relative in the realigned
    // region; route it through `emit_local_addr` and store through the
    // materialised address (C11 6.7.5).
    let is_over = over_aligned_region_off(off, func, frame).is_some();
    if matches!(kind, StoreKind::F32) {
        // `float` local store. A single-precision value (C99 6.3.1.8)
        // is already an f32 in the s-view (`str s`, no narrow); a wider
        // f64 value narrows via `fcvt Sd, Dn` first. Mirrors the
        // `Store` F32 path so a mem2reg-promoted slot round-trips
        // identically to the prior address-taken `LocalAddr + Store`.
        let value_place = alloc
            .places
            .get(value as usize)
            .copied()
            .unwrap_or(Place::None);
        // `str s` takes the byte offset scaled by 4; the slot offset is
        // 4-aligned. A displacement past the unsigned-offset range falls
        // back to materialising the address in a scratch register.
        let store_to_slot = |code: &mut Vec<u8>, sn: u8| -> bool {
            let bytes = local_slot_off(off, frame);
            if let Ok(disp) = i32::try_from(bytes)
                && !is_over
                && disp >= 0
                && (disp as u32).is_multiple_of(4)
                && (disp as u32) < 16380
            {
                emit(code, super::encode::enc_str_s_imm(sn, Reg(29), disp as u32));
                true
            } else if !emit_local_addr(code, Place::IntReg(scratch.secondary.0), off, func, frame) {
                false
            } else {
                emit(code, super::encode::enc_str_s_imm(sn, scratch.secondary, 0));
                true
            }
        };
        if alloc.is_f32(value) {
            let sn = match materialize_fp_f32(code, value_place, frame.fp_scratch[0], frame) {
                Some(r) => r,
                None => {
                    bail_msg("StoreLocal F32: value not fp reg / spill");
                    return false;
                }
            };
            if !store_to_slot(code, sn) {
                return false;
            }
            if let Some(rd) = fp_reg(dst) {
                if rd != sn {
                    emit(code, super::encode::enc_fmov_s_s(rd, sn));
                }
            } else if let Place::Spill(slot) = dst {
                emit_spill_str_d_auto(code, frame, sn, spill_off(frame, slot));
            }
            return true;
        }
        // Wider f64 value: narrow into the second FP scratch (outside the
        // allocator's banks) so an allocator-held source d-reg whose f64 value is
        // still live is not clobbered by the S-view write.
        let dn = match value_place {
            Place::FpReg(r) => r,
            Place::IntReg(_) | Place::Spill(_) => {
                let rs = match materialize_int(code, value_place, scratch.secondary, frame) {
                    Some(r) => r,
                    None => return false,
                };
                emit(code, enc_fmov_x_to_d(frame.fp_scratch[0], rs));
                frame.fp_scratch[0]
            }
            Place::None => {
                bail_msg("StoreLocal F32: value None");
                return false;
            }
        };
        emit(code, super::encode::enc_fcvt_s_d(frame.fp_scratch[1], dn));
        if !store_to_slot(code, frame.fp_scratch[1]) {
            return false;
        }
        if let Some(rd) = fp_reg(dst) {
            if rd != dn {
                emit(code, enc_fmov_d_to_x(scratch.primary, dn));
                emit(code, enc_fmov_x_to_d(rd, scratch.primary));
            }
        } else if let Place::Spill(slot) = dst {
            emit_spill_str_d_auto(code, frame, dn, spill_off(frame, slot));
        }
        return true;
    }
    if matches!(kind, StoreKind::F128) {
        let value_place = alloc
            .places
            .get(value as usize)
            .copied()
            .unwrap_or(Place::None);
        let Some(dn) = materialize_fp(code, value_place, frame.fp_scratch[0], frame) else {
            bail_msg("StoreLocal F128: value not fp reg / spill / int reg");
            return false;
        };
        if !emit_local_addr(code, Place::IntReg(scratch.secondary.0), off, func, frame) {
            return false;
        }
        super::binary128::emit_widen_store(code, dn, scratch.secondary, 0, None);
        match dst {
            Place::FpReg(r) if r != dn => emit(code, super::encode::enc_fmov_d_d(r, dn)),
            Place::Spill(slot) => {
                emit_spill_str_d_auto(code, frame, dn, spill_off(frame, slot));
            }
            _ => {}
        }
        return true;
    }
    if matches!(kind, StoreKind::F64) {
        // `double` local store: a single 8-byte FP store; no narrow.
        let value_place = alloc
            .places
            .get(value as usize)
            .copied()
            .unwrap_or(Place::None);
        let Some(dn) = materialize_fp(code, value_place, frame.fp_scratch[0], frame) else {
            bail_msg("StoreLocal F64: value not fp reg / spill / int reg");
            return false;
        };
        let bytes = local_slot_off(off, frame);
        if let Ok(disp) = i32::try_from(bytes)
            && !is_over
            && disp >= 0
            && (disp as u32).is_multiple_of(8)
            && (disp as u32) < 32760
        {
            emit(code, super::encode::enc_str_d_imm(dn, Reg(29), disp as u32));
        } else if !emit_local_addr(code, Place::IntReg(scratch.secondary.0), off, func, frame) {
            return false;
        } else {
            emit(code, super::encode::enc_str_d_imm(dn, scratch.secondary, 0));
        }
        // c5 store-op leaves the value in the accumulator; propagate
        // to dst if the allocator parked it elsewhere.
        match dst {
            Place::FpReg(r) if r != dn => {
                emit(code, super::encode::enc_fmov_d_d(r, dn));
            }
            Place::Spill(slot) => {
                let sp_off = spill_off(frame, slot);
                emit_spill_str_d_auto(code, frame, dn, sp_off);
            }
            _ => {}
        }
        return true;
    }
    let value_place = alloc
        .places
        .get(value as usize)
        .copied()
        .unwrap_or(Place::None);
    // Materialise the value first; the address path below picks a
    // scratch register based on whether the displacement fits the
    // unscaled 9-bit field. c5 spills an FP-typed accumulator into
    // a local temp through the store-local path (the bit pattern
    // fits 8 bytes
    // regardless of type), so an FpReg value bridges through
    // `fmov d -> x` into a GPR before the store; otherwise it
    // routes through the normal int materialisation.
    let rv = if let Place::FpReg(dr) = value_place {
        emit(code, super::encode::enc_fmov_d_to_x(scratch.primary, dr));
        scratch.primary
    } else {
        match materialize_int(code, value_place, scratch.primary, frame) {
            Some(r) => r,
            None => return false,
        }
    };
    let bytes = local_slot_off(off, frame);
    if let Ok(disp) = i32::try_from(bytes) {
        if (-256..256).contains(&disp) && !is_over {
            // Store the low `kind`-width bytes; the accumulator below
            // keeps the full source value, matching the c5 rule that
            // an assignment expression yields the stored value before
            // any re-narrowing on read-back (C99 6.5.16p3).
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
        } else if !emit_store_local_large_disp(code, off, rv, kind, func, scratch, frame) {
            return false;
        }
    } else if !emit_store_local_large_disp(code, off, rv, kind, func, scratch, frame) {
        return false;
    }
    // c5 store ops leave the stored value in the accumulator;
    // propagate to dst if the allocator parked it elsewhere.
    match dst {
        Place::IntReg(r) => {
            let rd = Reg(r);
            if rd.0 != rv.0 {
                emit_mov_reg(code, rd, rv);
            }
        }
        Place::Spill(slot) => {
            let sp_off = spill_off(frame, slot);
            emit_spill_str_x_auto(code, frame, rv, sp_off);
        }
        Place::None => {}
        Place::FpReg(_) => return false,
    }
    true
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
) -> bool {
    if !emit_local_addr(code, Place::IntReg(scratch.secondary.0), off, func, frame) {
        return false;
    }
    let enc = match kind {
        StoreKind::I64 => super::encode::enc_str_imm(rv, scratch.secondary, 0),
        StoreKind::I32 => super::encode::enc_str32_imm(rv, scratch.secondary, 0),
        StoreKind::I16 => super::encode::enc_strh_imm(rv, scratch.secondary, 0),
        StoreKind::I8 => super::encode::enc_strb_imm(rv, scratch.secondary, 0),
        StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128 => unreachable!(),
    };
    emit(code, enc);
    true
}

/// Lower `Inst::LoadIndexed`: `dst = *(kind*)(base + index * scale)`.
/// Emitted as one scaled-indexed load (`ldr Xt, [Xn, Xm, lsl #N]`)
/// when `scale` matches the natural width of `kind`. F32 indexed
/// loads aren't a shape the walker produces today (no `float arr[]`
/// access path goes through the indexed fold yet); the FP variant
/// would need a separate `ldr St, [Xn, Xm, lsl #2]` + `fcvt d, s`.
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
) -> bool {
    if matches!(
        kind,
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128
    ) {
        bail_msg("LoadIndexed: FP not implemented");
        return false;
    }
    let base_place = alloc
        .places
        .get(base as usize)
        .copied()
        .unwrap_or(Place::None);
    let index_place = alloc
        .places
        .get(index as usize)
        .copied()
        .unwrap_or(Place::None);
    let rn = match materialize_int(code, base_place, scratch.primary, frame) {
        Some(r) => r,
        None => return false,
    };
    let rm = match materialize_int(code, index_place, scratch.secondary, frame) {
        Some(r) => r,
        None => return false,
    };
    let rd = match dst {
        Place::IntReg(r) => Reg(r),
        Place::Spill(_) => scratch.secondary,
        Place::FpReg(_) | Place::None => return false,
    };
    let expected_scale: u8 = match kind {
        LoadKind::I64 => 8,
        LoadKind::I32 | LoadKind::U32 => 4,
        LoadKind::I16 | LoadKind::U16 => 2,
        LoadKind::I8 | LoadKind::U8 => 1,
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 => unreachable!(),
    };
    if scale != expected_scale {
        bail_msg("LoadIndexed: scale doesn't match access width");
        return false;
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
    if let Place::Spill(slot) = dst {
        let sp_off = spill_off(frame, slot);
        emit_spill_str_x_auto(code, frame, rd, sp_off);
    }
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
    scratch: &ScratchPool,
) -> bool {
    if matches!(
        kind,
        StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128
    ) {
        bail_msg("StoreIndexed: FP not implemented");
        return false;
    }
    let base_place = alloc
        .places
        .get(base as usize)
        .copied()
        .unwrap_or(Place::None);
    let index_place = alloc
        .places
        .get(index as usize)
        .copied()
        .unwrap_or(Place::None);
    let value_place = alloc
        .places
        .get(value as usize)
        .copied()
        .unwrap_or(Place::None);
    let rn = match materialize_int(code, base_place, scratch.primary, frame) {
        Some(r) => r,
        None => return false,
    };
    let rm = match materialize_int(code, index_place, scratch.secondary, frame) {
        Some(r) => r,
        None => return false,
    };
    let expected_scale: u8 = match kind {
        StoreKind::I64 => 8,
        StoreKind::I32 => 4,
        StoreKind::I16 => 2,
        StoreKind::I8 => 1,
        StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128 => unreachable!(),
    };
    if scale != expected_scale {
        bail_msg("StoreIndexed: scale doesn't match access width");
        return false;
    }
    // The store needs three registers -- base, index, value -- but only
    // two scratch registers exist. Pick a scratch for the value that
    // collides with neither base nor index; when a spilled base and
    // index occupy both, fold the index into the base so the
    // register-offset form is no longer needed and a scratch frees up.
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
    // Reuse the FP-bridge path from `emit_store_local` for the
    // I64-store-of-FpReg shape.
    let rv = if let StoreKind::I64 = kind
        && let Place::FpReg(dr) = value_place
    {
        emit(code, super::encode::enc_fmov_d_to_x(vscratch, dr));
        vscratch
    } else {
        match materialize_int(code, value_place, vscratch, frame) {
            Some(r) => r,
            None => return false,
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
    // c5 store-op leaves the stored value in the accumulator.
    match dst {
        Place::IntReg(r) => {
            let rd = Reg(r);
            if rd.0 != rv.0 {
                emit_mov_reg(code, rd, rv);
            }
        }
        Place::Spill(slot) => {
            let sp_off = spill_off(frame, slot);
            emit_spill_str_x_auto(code, frame, rv, sp_off);
        }
        Place::None => {}
        Place::FpReg(_) => return false,
    }
    true
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
) -> bool {
    // `disp` is a width-aligned, in-range byte offset folded from a
    // constant pointer addition; it passes straight to the immediate-
    // offset store encoders, and lets `bound` be read as an alignment
    // of the base that `disp` then advances.
    let disp = disp as u32;
    // The c5 store ops leave the stored value in the accumulator
    // afterward, so `dst` may be a register or spill slot the
    // allocator wants the value parked in. We compute the value
    // in a register, store it through the address, then copy to
    // dst if it isn't already there.
    let addr_place = alloc
        .places
        .get(addr as usize)
        .copied()
        .unwrap_or(Place::None);
    let value_place = alloc
        .places
        .get(value as usize)
        .copied()
        .unwrap_or(Place::None);
    let rn = match materialize_int(code, addr_place, scratch.primary, frame) {
        Some(r) => r,
        None => return false,
    };
    if let StoreKind::F32 = kind {
        // C99 6.3.1.8 / 6.3.1.5: a single-precision value is already an
        // f32 in the s-view, so store it directly (`str s`, no narrow).
        // A double value (the archive-reload boundary, or a `double`
        // assigned to a `float` lvalue the walker didn't pre-narrow) is
        // narrowed via `fcvt Sd, Dn` first.
        if alloc.is_f32(value) {
            let sn = match materialize_fp_f32(code, value_place, frame.fp_scratch[0], frame) {
                Some(r) => r,
                None => return false,
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
            } else if let Place::Spill(slot) = dst {
                let sp_off = spill_off(frame, slot);
                emit_spill_str_d_auto(code, frame, sn, sp_off);
            }
            return true;
        }
        // Stage the value as a d-reg holding the f64 pattern.
        // For an FpReg source the materialise already gives us
        // that; for an IntReg / Spill the source register holds
        // the int-encoded f64 bit pattern (c5's Imm path), so
        // an fmov x->d reinterprets the bits as f64.
        let dn = match value_place {
            Place::FpReg(r) => r,
            Place::IntReg(_) | Place::Spill(_) => {
                let rs = match materialize_int(code, value_place, scratch.secondary, frame) {
                    Some(r) => r,
                    None => return false,
                };
                emit(code, enc_fmov_x_to_d(frame.fp_scratch[0], rs));
                frame.fp_scratch[0]
            }
            Place::None => return false,
        };
        // Narrow into the second FP scratch (outside the allocator's
        // banks) so dn -- which may be an allocator-held d-reg whose f64
        // value is still live across this store -- is not clobbered.
        // `fcvt Sd, Dn` writes the S view and zeroes the rest of the
        // V register, so narrowing in place over a pooled register
        // would destroy a value the surrounding code still reads.
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
        } else if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit_spill_str_d_auto(code, frame, dn, sp_off);
        }
        return true;
    }
    if let StoreKind::F128 = kind {
        let Some(dn) = materialize_fp(code, value_place, frame.fp_scratch[0], frame) else {
            bail_msg("Store F128: value not fp reg / spill / int reg");
            return false;
        };
        let base = addr_outside_borrows(code, rn, scratch);
        super::binary128::emit_widen_store(code, dn, base, disp, bound);
        if let Some(rd) = fp_reg(dst) {
            if rd != dn {
                emit(code, super::encode::enc_fmov_d_d(rd, dn));
            }
        } else if let Place::Spill(slot) = dst {
            emit_spill_str_d_auto(code, frame, dn, spill_off(frame, slot));
        }
        return true;
    }
    if let StoreKind::F64 = kind {
        // `double` lvalue store: a single 8-byte FP store; no narrow.
        let Some(dn) = materialize_fp(code, value_place, frame.fp_scratch[0], frame) else {
            return false;
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
        } else if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit_spill_str_d_auto(code, frame, dn, sp_off);
        }
        return true;
    }
    // For an I64 store whose value lives in an FpReg (c5's f64
    // store path uses StoreKind::I64 to write 8 raw bytes), bridge
    // d-reg -> GPR via fmov. Lower-width stores from an FpReg
    // aren't a shape c5 emits.
    let rs = if let StoreKind::I64 = kind
        && let Place::FpReg(dr) = value_place
    {
        emit(code, enc_fmov_d_to_x(scratch.secondary, dr));
        scratch.secondary
    } else {
        match materialize_int(code, value_place, scratch.secondary, frame) {
            Some(r) => r,
            None => return false,
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
    } else if let Place::Spill(slot) = dst {
        let sp_off = spill_off(frame, slot);
        emit_spill_str_x_auto(code, frame, rs, sp_off);
    }
    true
}

/// Materialise a value's `Place` into a register the lowering
/// can name in an instruction operand. Spills get loaded into
/// `scratch`; register places are returned as-is. Spill slots
/// are addressed through sp with the 12-bit scaled immediate;
/// fp-relative addressing through `ldur` would silently
/// truncate the 9-bit immediate for frames > 256 bytes and read
/// from the wrong slot. `sp_shift` is any amount the caller has
/// temporarily pushed sp down by (e.g. emit_call's outgoing-arg
/// scratch region) -- it gets added to the in-frame offset so the
/// load still hits the correct spill slot.
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

/// Materialise a floating-point value's `Place` into a d-reg.
/// Spilled FP values land in the 8-byte spill region as 64-bit
/// patterns (the SSA model's only FP width is f64 since c5
/// widens every load through `fcvt`).
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
            // FP spill reloads need a GPR base when the slot is beyond
            // the scaled-imm12 reach; x16 is the primary scratch and
            // holds no int operand during an FP-value lowering.
            emit_spill_ldr_d(code, frame, scratch_d, sp_off, Reg(16));
            Some(scratch_d)
        }
        // c5's constant-folder emits FP values as `Imm` of the
        // int-encoded f64 bit pattern; the allocator places those
        // in IntRegs. Reinterpret the bit pattern as an f64 via
        // `fmov d, x` and return the scratch d-reg.
        Place::IntReg(r) => {
            emit(code, enc_fmov_x_to_d(scratch_d, Reg(r)));
            Some(scratch_d)
        }
        Place::None => None,
    }
}

/// Materialise a single-precision (`f32`) value's `Place` into the
/// low 32 bits of a v-register. A `Place::FpReg` already holds the
/// f32 in its s-view; a `Place::Spill` reloads the 64-bit slot (a
/// single-precision write zeroes the upper half, so the low 32 bits
/// carry the f32). A `Place::IntReg` holds an f32 constant's int-
/// encoded bit pattern in the low 32 bits; reinterpret it through
/// `fmov s, w` (not the 64-bit `fmov d, x`, which would read garbage
/// upper bits and misalign the single value).
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

/// Materialise an FP operand, choosing the single- vs double-
/// precision reinterpret of an int-register constant by the value's
/// f32 marker.
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

/// Extract the d-reg number from a `Place::FpReg`, or `None` for
/// any other place. The d-reg index is the same as the s-reg
/// index (single-precision uses the low 32 bits of the same
/// physical register).
fn fp_reg(place: Place) -> Option<u8> {
    place.fp_reg_u8()
}

/// Extract the int reg from a `Place`, or None if it's not an
/// int placement.
pub(super) fn int_reg(p: Place) -> Option<Reg> {
    p.int_reg_u8().map(Reg)
}
