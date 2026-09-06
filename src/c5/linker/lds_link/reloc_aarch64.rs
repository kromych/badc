//! Relocation application; the aarch64 arm.

use crate::c5::object::elf_reloc_types as rt;
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;
use hashbrown::HashSet;

use super::inputs::RawReloc;
use super::{LdsEmit, LdsLinker};

impl<'a> LdsLinker<'a> {
    #[allow(clippy::too_many_arguments)]
    pub(super) fn apply_aarch64(
        &self,
        buf: &mut [u8],
        site: usize,
        p: u64,
        sa: u64,
        r: &RawReloc,
        alloc: bool,
        relr_set: &HashSet<u64>,
        errors: &mut Vec<String>,
        oi: usize,
    ) {
        let name = || {
            let sym = &self.objects[oi].symbols[r.sym as usize];
            if sym.name.is_empty() {
                format!("section symbol {}", sym.shndx)
            } else {
                sym.name.clone()
            }
        };
        let rd32 = |buf: &[u8], site: usize| -> u32 {
            u32::from_le_bytes([buf[site], buf[site + 1], buf[site + 2], buf[site + 3]])
        };
        let wr32 = |buf: &mut [u8], site: usize, v: u32| {
            buf[site..site + 4].copy_from_slice(&v.to_le_bytes());
        };
        let page = |v: u64| v & !0xfffu64;
        match r.rtype {
            rt::R_AARCH64_ABS64 => {
                // Write the value in place unless it is a load-address
                // (slide-dependent) fixup deferred to the loader. A
                // slide-invariant absolute constant is always written;
                // an RELR-packed relative keeps its link-time value in
                // place (the RELR format has no explicit addend);
                // `--no-apply-dynamic-relocs` leaves only the RELA
                // relative slots at zero for the kernel to fill.
                let relative = self.opts.emit == LdsEmit::Dyn
                    && alloc
                    && self.reloc_is_relative(oi, r.sym as usize);
                let deferred =
                    relative && !relr_set.contains(&p) && !self.opts.apply_dynamic_relocs;
                if !deferred && site + 8 <= buf.len() {
                    buf[site..site + 8].copy_from_slice(&sa.to_le_bytes());
                }
            }
            rt::R_AARCH64_ABS32 => {
                // AAELF64: the check is `-2^31 <= X < 2^32`, so a
                // value outside 32 bits read either way is an error
                // rather than a narrowed address.
                if !rt::AbsCheck::SignedOrUnsigned.admits(sa as i64, 4) {
                    errors.push(format!(
                        "relocation truncated to fit: R_AARCH64_ABS32 against `{}' (0x{sa:x})",
                        name()
                    ));
                }
                if site + 4 <= buf.len() {
                    buf[site..site + 4].copy_from_slice(&(sa as u32).to_le_bytes());
                }
            }
            rt::R_AARCH64_ABS16 => {
                if !rt::AbsCheck::SignedOrUnsigned.admits(sa as i64, 2) {
                    errors.push(format!(
                        "relocation truncated to fit: R_AARCH64_ABS16 against `{}' (0x{sa:x})",
                        name()
                    ));
                }
                if site + 2 <= buf.len() {
                    buf[site..site + 2].copy_from_slice(&(sa as u16).to_le_bytes());
                }
            }
            rt::R_AARCH64_PREL64 => {
                if site + 8 <= buf.len() {
                    buf[site..site + 8].copy_from_slice(&sa.wrapping_sub(p).to_le_bytes());
                }
            }
            rt::R_AARCH64_PREL32 => {
                let v = sa.wrapping_sub(p) as i64;
                if (v as i32) as i64 != v {
                    errors.push(format!(
                        "relocation truncated: R_AARCH64_PREL32 against `{}'",
                        name()
                    ));
                }
                if site + 4 <= buf.len() {
                    buf[site..site + 4].copy_from_slice(&(v as i32).to_le_bytes());
                }
            }
            262 => {
                // R_AARCH64_PREL16
                let v = sa.wrapping_sub(p);
                if site + 2 <= buf.len() {
                    buf[site..site + 2].copy_from_slice(&(v as u16).to_le_bytes());
                }
            }
            rt::R_AARCH64_CALL26 | rt::R_AARCH64_JUMP26 => {
                let v = sa.wrapping_sub(p) as i64;
                if v % 4 != 0 || !(-(1i64 << 27)..(1i64 << 27)).contains(&v) {
                    errors.push(format!(
                        "branch out of range to `{}' (0x{v:x}); veneers TODO",
                        name()
                    ));
                    return;
                }
                let insn = rd32(buf, site) & 0xfc00_0000;
                wr32(buf, site, insn | (((v >> 2) as u32) & 0x03ff_ffff));
            }
            rt::R_AARCH64_ADR_PREL_PG_HI21 => {
                let v = (page(sa) as i64).wrapping_sub(page(p) as i64);
                if !(-(1i64 << 32)..(1i64 << 32)).contains(&v) {
                    errors.push(format!(
                        "ADR_PREL_PG_HI21 out of range against `{}'",
                        name()
                    ));
                    return;
                }
                let imm = (v >> 12) as u32;
                let insn = rd32(buf, site) & 0x9f00_001f;
                wr32(
                    buf,
                    site,
                    insn | ((imm & 3) << 29) | (((imm >> 2) & 0x7ffff) << 5),
                );
            }
            274 => {
                // R_AARCH64_ADR_PREL_LO21
                let v = sa.wrapping_sub(p) as i64;
                if !(-(1i64 << 20)..(1i64 << 20)).contains(&v) {
                    errors.push(format!("ADR_PREL_LO21 out of range against `{}'", name()));
                    return;
                }
                let imm = v as u32;
                let insn = rd32(buf, site) & 0x9f00_001f;
                wr32(
                    buf,
                    site,
                    insn | ((imm & 3) << 29) | (((imm >> 2) & 0x7ffff) << 5),
                );
            }
            rt::R_AARCH64_ADD_ABS_LO12_NC => {
                let insn = rd32(buf, site) & 0xffc0_03ff;
                wr32(buf, site, insn | (((sa & 0xfff) as u32) << 10));
            }
            rt::R_AARCH64_LDST8_ABS_LO12_NC
            | rt::R_AARCH64_LDST16_ABS_LO12_NC
            | rt::R_AARCH64_LDST32_ABS_LO12_NC
            | rt::R_AARCH64_LDST64_ABS_LO12_NC
            | rt::R_AARCH64_LDST128_ABS_LO12_NC => {
                let scale = rt::aarch64_ldst_lo12_scale(r.rtype).unwrap_or(1);
                let imm = ((sa & 0xfff) / scale as u64) as u32;
                let insn = rd32(buf, site) & 0xffc0_03ff;
                wr32(buf, site, insn | (imm << 10));
            }
            280 => {
                // R_AARCH64_CONDBR19
                let v = sa.wrapping_sub(p) as i64;
                if v % 4 != 0 || !(-(1i64 << 20)..(1i64 << 20)).contains(&v) {
                    errors.push(format!("CONDBR19 out of range against `{}'", name()));
                    return;
                }
                let insn = rd32(buf, site) & 0xff00_001f;
                wr32(buf, site, insn | ((((v >> 2) as u32) & 0x7ffff) << 5));
            }
            279 => {
                // R_AARCH64_TSTBR14
                let v = sa.wrapping_sub(p) as i64;
                if v % 4 != 0 || !(-(1i64 << 15)..(1i64 << 15)).contains(&v) {
                    errors.push(format!("TSTBR14 out of range against `{}'", name()));
                    return;
                }
                let insn = rd32(buf, site) & 0xfff8_001f;
                wr32(buf, site, insn | ((((v >> 2) as u32) & 0x3fff) << 5));
            }
            273 => {
                // R_AARCH64_LD_PREL_LO19
                let v = sa.wrapping_sub(p) as i64;
                if v % 4 != 0 || !(-(1i64 << 20)..(1i64 << 20)).contains(&v) {
                    errors.push(format!("LD_PREL_LO19 out of range against `{}'", name()));
                    return;
                }
                let insn = rd32(buf, site) & 0xff00_001f;
                wr32(buf, site, insn | ((((v >> 2) as u32) & 0x7ffff) << 5));
            }
            _ if rt::aarch64_movw_field(r.rtype).is_some() => {
                // R_AARCH64_MOVW_[SU]ABS_G*: one 16-bit group of the
                // absolute value into a `movz` / `movk` immediate.
                use crate::c5::codegen::aarch64::patch;
                let (group, signed, check) =
                    rt::aarch64_movw_field(r.rtype).expect("guarded by the arm");
                let v = sa as i64;
                if let Some(bits) = check
                    && !patch::movw_fits(v, bits, signed)
                {
                    errors.push(format!(
                        "{} overflow against `{}' (0x{sa:x})",
                        rt::aarch64_reloc_desc(r.rtype),
                        name()
                    ));
                }
                wr32(
                    buf,
                    site,
                    patch::movw_word(rd32(buf, site), group, signed, v),
                );
            }
            rt::R_AARCH64_ADR_GOT_PAGE | rt::R_AARCH64_LD64_GOT_LO12_NC => {
                let slot = self.got_slot_addr(oi, r);
                let Some(slot) = slot else {
                    errors.push(format!("no GOT slot for `{}'", name()));
                    return;
                };
                if r.rtype == rt::R_AARCH64_ADR_GOT_PAGE {
                    let v = (page(slot) as i64).wrapping_sub(page(p) as i64);
                    let imm = (v >> 12) as u32;
                    let insn = rd32(buf, site) & 0x9f00_001f;
                    wr32(
                        buf,
                        site,
                        insn | ((imm & 3) << 29) | (((imm >> 2) & 0x7ffff) << 5),
                    );
                } else {
                    let imm = (((slot & 0xfff) / 8) as u32) & 0xfff;
                    let insn = rd32(buf, site) & 0xffc0_03ff;
                    wr32(buf, site, insn | (imm << 10));
                }
            }
            0 => {}
            other => {
                errors.push(format!(
                    "unsupported relocation {} against `{}'",
                    rt::aarch64_reloc_desc(other),
                    name()
                ));
            }
        }
    }
}
