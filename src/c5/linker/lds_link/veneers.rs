//! Cortex-A53 erratum 843419 veneers: reservation and the fix pass.

use crate::c5::linker::erratum;
use alloc::collections::BTreeMap;
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;
use hashbrown::HashMap;

use super::{
    ChunkSrc, EM_AARCH64, LdsLinker, SHF_EXECINSTR, SHT_NOBITS, SHT_PROGBITS, STB_LOCAL, align_up,
};

impl<'a> LdsLinker<'a> {
    fn a53_active(&self) -> bool {
        self.machine == EM_AARCH64 && self.opts.fix_cortex_a53_843419
    }

    /// Code ranges from `$x`/`$d` mapping symbols. Bytes before the
    /// first mapping symbol count as code, as does a section carrying
    /// none (LLD's reading; ld skips unmapped sections entirely).
    pub(super) fn build_code_spans(&mut self) {
        if !self.a53_active() {
            return;
        }
        let mapping = |name: &str, tag: &str| {
            name == tag || (name.starts_with(tag) && name[tag.len()..].starts_with('.'))
        };
        for obj_i in 0..self.objects.len() {
            let o = &self.objects[obj_i];
            let mut per_sec: HashMap<usize, Vec<(u64, bool)>> = HashMap::new();
            for sym in &o.symbols {
                if sym.binding() != STB_LOCAL {
                    continue;
                }
                let code = mapping(&sym.name, "$x");
                if !code && !mapping(&sym.name, "$d") {
                    continue;
                }
                if let Some(&sec) = o.shndx_map.get(&sym.shndx) {
                    per_sec.entry(sec).or_default().push((sym.value, code));
                }
            }
            for (sec, mut marks) in per_sec {
                let size = o.sections[sec].size;
                marks.sort_unstable();
                let mut spans: Vec<(u64, u64)> = Vec::new();
                let (mut code, mut start) = (true, 0u64);
                for (off, c) in marks {
                    if c == code {
                        continue;
                    }
                    if code && off > start {
                        spans.push((start, off));
                    }
                    (code, start) = (c, off);
                }
                if code && size > start {
                    spans.push((start, size));
                }
                let i = self.insec_index(obj_i, sec);
                self.code_spans.insert(i, spans);
            }
        }
    }

    /// Erratum sites of one placed input chunk, as offsets into the
    /// input section. The scan reads the input bytes: relocations only
    /// rewrite immediate fields, so sizing and the fix pass, before
    /// and after they apply, see one site set.
    fn a53_sites(&self, i: usize, vaddr: u64, len: u64) -> Vec<erratum::Site> {
        let id = self.insecs[i];
        if id.obj == self.synth_obj {
            return Vec::new();
        }
        let s = &self.objects[id.obj].sections[id.sec];
        if s.shtype != SHT_PROGBITS || s.flags & SHF_EXECINSTR == 0 {
            return Vec::new();
        }
        let bytes = self.chunk_input_bytes(i);
        let limit = (len as usize).min(bytes.len()) as u64;
        let whole = [(0u64, limit)];
        let spans = match self.code_spans.get(&i) {
            Some(v) => &v[..],
            None => &whole[..],
        };
        let mut sites = Vec::new();
        for &(s, e) in spans {
            let (s, e) = (s.min(limit), e.min(limit));
            if e <= s {
                continue;
            }
            for site in erratum::scan(&bytes[s as usize..e as usize], vaddr + s) {
                sites.push(erratum::Site {
                    adrp_off: site.adrp_off + s,
                    ldst_off: site.ldst_off + s,
                });
            }
        }
        sites
    }

    /// Between passes: size each executable output section's veneer
    /// area from the sites its current addresses expose. Every site
    /// takes a slot, as under ld, since whether ADR reach spares the
    /// veneer is known only once relocations are applied.
    pub(super) fn a53_size_reserve(&mut self) {
        if !self.a53_active() {
            return;
        }
        let mut reserve: BTreeMap<usize, u64> = BTreeMap::new();
        for oi in 0..self.outs.len() {
            let o = &self.outs[oi];
            if !o.alloc || o.flags & SHF_EXECINSTR == 0 || o.shtype == SHT_NOBITS {
                continue;
            }
            let mut n = 0u64;
            for (off, len, src) in &o.chunks {
                if let ChunkSrc::Input(i) = src {
                    n += self.a53_sites(*i, o.addr + off, *len).len() as u64;
                }
            }
            if n > 0 {
                reserve.insert(oi, align_up(8 * n, 0x1000));
            }
        }
        self.veneer_reserve = reserve;
    }

    /// Final pass over the relocated bytes: rewrite each site's ADRP as
    /// ADR when its page is in ADR range, otherwise move the dependent
    /// load/store into a veneer slot ending in a branch back and put a
    /// branch to the slot in its place, as ld's workaround does.
    pub(super) fn a53_apply_fix(&mut self, contents: &mut HashMap<usize, Vec<u8>>) {
        if !self.a53_active() {
            return;
        }
        let rd32 = |b: &[u8], o: usize| u32::from_le_bytes([b[o], b[o + 1], b[o + 2], b[o + 3]]);
        let wr32 = |b: &mut [u8], o: usize, v: u32| b[o..o + 4].copy_from_slice(&v.to_le_bytes());
        let branch = |from: u64, to: u64| {
            let d = to.wrapping_sub(from) as i64;
            (-(1i64 << 27)..(1i64 << 27))
                .contains(&d)
                .then_some(0x1400_0000u32 | (((d >> 2) as u32) & 0x03ff_ffff))
        };
        for oi in 0..self.outs.len() {
            let area = self.outs[oi]
                .chunks
                .iter()
                .find_map(|(o, l, s)| matches!(s, ChunkSrc::Veneers).then_some((*o, *l)));
            let Some((area_off, area_len)) = area else {
                continue;
            };
            let sec_addr = self.outs[oi].addr;
            let mut fixes: Vec<(u64, u64, String)> = Vec::new();
            for (off, len, src) in &self.outs[oi].chunks {
                let ChunkSrc::Input(i) = src else { continue };
                let id = self.insecs[*i];
                for s in self.a53_sites(*i, sec_addr + off, *len) {
                    // ld names each veneer after the input section
                    // identity and the dependent load/store's offset.
                    let name = format!("e843419@{:04x}_{:08x}_{:x}", id.obj, id.sec, s.ldst_off);
                    fixes.push((off + s.adrp_off, off + s.ldst_off, name));
                }
            }
            let Some(buf) = contents.get_mut(&oi) else {
                continue;
            };
            let mut slot = 0u64;
            for (adrp_off, ldst_off, name) in fixes {
                let insn = rd32(buf, adrp_off as usize);
                if !erratum::is_adrp(insn) {
                    self.errors.push(format!(
                        "erratum 843419 site at {:#x} lost its ADRP",
                        sec_addr + adrp_off
                    ));
                    continue;
                }
                let place = sec_addr + adrp_off;
                let imm = erratum::adrp_page_delta(insn) - (place & 0xfff) as i64;
                if (erratum::ADR_MIN..=erratum::ADR_MAX).contains(&imm) {
                    wr32(
                        buf,
                        adrp_off as usize,
                        erratum::encode_adr(insn & 0x1f, imm),
                    );
                    continue;
                }
                if (slot + 1) * 8 > area_len {
                    self.errors
                        .push("erratum 843419 veneer area smaller than its site count".to_string());
                    break;
                }
                let slot_off = area_off + 8 * slot;
                slot += 1;
                let ldst_addr = sec_addr + ldst_off;
                let slot_addr = sec_addr + slot_off;
                let (Some(to), Some(back)) = (
                    branch(ldst_addr, slot_addr),
                    branch(slot_addr + 4, ldst_addr + 4),
                ) else {
                    self.errors.push(format!(
                        "erratum 843419 veneer out of branch range at {ldst_addr:#x}"
                    ));
                    continue;
                };
                let ldst = rd32(buf, ldst_off as usize);
                wr32(buf, slot_off as usize, ldst);
                wr32(buf, slot_off as usize + 4, back);
                wr32(buf, ldst_off as usize, to);
                self.veneer_syms.push((name, oi, slot_addr));
            }
        }
    }
}
