//! The lazy procedure linkage table, as each psABI lays it out and GNU ld
//! encodes it: a header (bfd's PLT0) that hands the loader its resolver
//! slots, then one entry per called symbol jumping through a `.got.plt`
//! slot that an `R_*_JUMP_SLOT` in `.rel(a).plt` names.

use crate::c5::object::elf_reloc_types as rt;
use alloc::vec::Vec;

use super::{EM_386, EM_AARCH64, LdsEmit, LdsLinker, SYNTH_GOTPLT, SYNTH_PLT};

/// One PLT entry after the header, on every target.
pub(super) const PLT_ENTRY_SIZE: u64 = 16;

/// The `.got.plt` slots ahead of the entries': the `.dynamic` address on
/// x86, then the two the loader fills for its resolver.
pub(super) const GOTPLT_RESERVED: u64 = 3;

pub(super) fn plt_header_size(machine: u16) -> u64 {
    if machine == EM_AARCH64 { 32 } else { 16 }
}

fn put(out: &mut Vec<u8>, words: &[u32]) {
    for w in words {
        out.extend_from_slice(&w.to_le_bytes());
    }
}

/// aarch64 `adrp x16, target`, `ldr x17, [x16, :lo12:target]`, `add x16,
/// x16, :lo12:target` from `at`.
fn aarch64_page_load(at: u64, target: u64) -> [u32; 3] {
    let page = (target & !0xfff).wrapping_sub(at & !0xfff) as i64 >> 12;
    let imm = page as u32 & 0x1f_ffff;
    let lo = (target & 0xfff) as u32;
    [
        0x9000_0010 | (imm & 3) << 29 | (imm >> 2) << 5,
        0xf940_0211 | (lo / 8) << 10,
        0x9100_0210 | lo << 10,
    ]
}

/// x86 `ff /n` with a disp32 operand: `%rip`-relative from the end of the
/// six-byte instruction at `at` on x86-64; off `%ebx`, the GOT base
/// `ebx` names, in an i386 position-independent image; absolute otherwise.
fn x86_indirect(out: &mut Vec<u8>, machine: u16, op: u8, at: u64, target: u64, ebx: Option<u64>) {
    let (modrm, field) = match (machine, ebx) {
        (EM_386, Some(base)) => (op | 0x83, target.wrapping_sub(base)),
        (EM_386, None) => (op | 0x05, target),
        _ => (op | 0x05, target.wrapping_sub(at + 6)),
    };
    out.extend_from_slice(&[0xff, modrm]);
    out.extend_from_slice(&(field as u32).to_le_bytes());
}

impl<'a> LdsLinker<'a> {
    /// The address of the `.got.plt` slot entry `k` jumps through.
    pub(super) fn gotplt_slot(&self, k: usize) -> Option<u64> {
        let base = self.synth_addr(SYNTH_GOTPLT)?;
        Some(base + (GOTPLT_RESERVED + k as u64) * self.class.addr_size())
    }

    pub(super) fn plt_entry_addr(&self, k: usize) -> Option<u64> {
        let plt = self.synth_addr(SYNTH_PLT)?;
        Some(plt + plt_header_size(self.machine) + k as u64 * PLT_ENTRY_SIZE)
    }

    /// The GOT base an i386 position-independent PLT reaches its slots
    /// from, which its callers hold in `%ebx` (Intel386 psABI).
    fn plt_ebx(&self) -> Option<u64> {
        (self.machine == EM_386 && self.opts.emit == LdsEmit::Dyn)
            .then(|| self.synth_addr(SYNTH_GOTPLT))
            .flatten()
    }

    /// `.plt`: the header, then an entry per called symbol that jumps
    /// through its slot, which holds the address of the entry's lazy path
    /// until the loader binds it. On x86 that path pushes the entry's
    /// relocation, by index on x86-64 and by byte offset on i386, and
    /// jumps to the header; aarch64's header finds the relocation from
    /// the slot address the entry leaves in x16.
    pub(super) fn plt_bytes(&self) -> Vec<u8> {
        let (Some(plt), Some(gotplt)) = (self.synth_addr(SYNTH_PLT), self.synth_addr(SYNTH_GOTPLT))
        else {
            return Vec::new();
        };
        if self.plt_syms.is_empty() {
            return Vec::new();
        }
        let m = self.machine;
        let aw = self.class.addr_size();
        let ebx = self.plt_ebx();
        let mut out = Vec::new();
        if m == EM_AARCH64 {
            let [adrp, ldr, add] = aarch64_page_load(plt + 4, gotplt + 2 * aw);
            put(&mut out, &[0xa9bf_7bf0, adrp, ldr, add, 0xd61f_0220]);
            put(&mut out, &[0xd503_201f; 3]);
        } else {
            x86_indirect(&mut out, m, 0x30, plt, gotplt + aw, ebx);
            x86_indirect(&mut out, m, 0x20, plt + 6, gotplt + 2 * aw, ebx);
            let pad: &[u8] = if m == EM_386 {
                &[0; 4]
            } else {
                &[0x0f, 0x1f, 0x40, 0x00]
            };
            out.extend_from_slice(pad);
        }
        for k in 0..self.plt_syms.len() {
            let (at, slot) = (
                self.plt_entry_addr(k).unwrap_or(0),
                self.gotplt_slot(k).unwrap_or(0),
            );
            if m == EM_AARCH64 {
                put(&mut out, &aarch64_page_load(at, slot));
                put(&mut out, &[0xd61f_0220]);
                continue;
            }
            x86_indirect(&mut out, m, 0x20, at, slot, ebx);
            let reloc = if m == EM_386 { 8 * k } else { k };
            out.push(0x68);
            out.extend_from_slice(&(reloc as u32).to_le_bytes());
            out.push(0xe9);
            out.extend_from_slice(&(plt.wrapping_sub(at + 16) as u32).to_le_bytes());
        }
        out
    }

    /// The link-time value of entry `k`'s `.got.plt` slot: the entry's lazy
    /// path on x86, the header on aarch64. The loader adds the load base.
    pub(super) fn gotplt_initial(&self, k: usize) -> u64 {
        if self.machine == EM_AARCH64 {
            return self.synth_addr(SYNTH_PLT).unwrap_or(0);
        }
        self.plt_entry_addr(k).unwrap_or(0) + 6
    }

    /// `R_*_JUMP_SLOT` for this target.
    pub(super) fn jump_slot_type(&self) -> u32 {
        match self.machine {
            EM_AARCH64 => rt::R_AARCH64_JUMP_SLOT,
            EM_386 => rt::R_386_JUMP_SLOT,
            _ => rt::R_X86_64_JUMP_SLOT,
        }
    }
}
