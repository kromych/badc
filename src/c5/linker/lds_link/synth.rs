//! Synthetic sections: their creation and their contents.

use crate::c5::linker::dynamic::{self};
use crate::c5::linker::eh_frame;
use crate::c5::object::elf_reloc_types::GOT_BASE_SYMBOL as GOT_SYMBOL;
use alloc::format;
use alloc::vec::Vec;
use hashbrown::{HashMap, HashSet};

use super::dynamic_sections::encode_relr;
use super::got::PLT_ENTRY_SIZE;
use super::inputs::RawSection;
use super::{
    LdsEmit, LdsLinker, OUT_EH_FRAME, SHF_ALLOC, SHF_EXECINSTR, SHF_WRITE, SHT_NOTE, SHT_PROGBITS,
    SHT_RELR, SHT_STRTAB, SYNTH_BUILD_ID, SYNTH_DYNAMIC, SYNTH_DYNSTR, SYNTH_DYNSYM,
    SYNTH_EH_FRAME_HDR, SYNTH_GNU_HASH, SYNTH_GNU_PROPERTY, SYNTH_GOT, SYNTH_GOTPLT, SYNTH_HASH,
    SYNTH_INTERP, SYNTH_PLT, SYNTH_RELR, SYNTH_VERDEF, SYNTH_VERSYM, SecFate, machine_uses_rela,
};

/// SHA-1 (FIPS 180-4), for `--build-id=sha1`.
pub(super) fn sha1(data: &[u8]) -> [u8; 20] {
    let mut h: [u32; 5] = [0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476, 0xC3D2E1F0];
    let ml = (data.len() as u64).wrapping_mul(8);
    let mut block = [0u8; 64];
    let process = |h: &mut [u32; 5], chunk: &[u8]| {
        let mut w = [0u32; 80];
        for i in 0..16 {
            w[i] = u32::from_be_bytes([
                chunk[i * 4],
                chunk[i * 4 + 1],
                chunk[i * 4 + 2],
                chunk[i * 4 + 3],
            ]);
        }
        for i in 16..80 {
            w[i] = (w[i - 3] ^ w[i - 8] ^ w[i - 14] ^ w[i - 16]).rotate_left(1);
        }
        let (mut a, mut b, mut c, mut d, mut e) = (h[0], h[1], h[2], h[3], h[4]);
        for (i, &wi) in w.iter().enumerate() {
            let (f, k) = match i {
                0..=19 => ((b & c) | ((!b) & d), 0x5A827999u32),
                20..=39 => (b ^ c ^ d, 0x6ED9EBA1),
                40..=59 => ((b & c) | (b & d) | (c & d), 0x8F1BBCDC),
                _ => (b ^ c ^ d, 0xCA62C1D6),
            };
            let tmp = a
                .rotate_left(5)
                .wrapping_add(f)
                .wrapping_add(e)
                .wrapping_add(k)
                .wrapping_add(wi);
            e = d;
            d = c;
            c = b.rotate_left(30);
            b = a;
            a = tmp;
        }
        h[0] = h[0].wrapping_add(a);
        h[1] = h[1].wrapping_add(b);
        h[2] = h[2].wrapping_add(c);
        h[3] = h[3].wrapping_add(d);
        h[4] = h[4].wrapping_add(e);
    };
    let mut i = 0;
    while i + 64 <= data.len() {
        process(&mut h, &data[i..i + 64]);
        i += 64;
    }
    let rest = data.len() - i;
    block[..rest].copy_from_slice(&data[i..]);
    block[rest] = 0x80;
    if rest + 1 > 56 {
        for b in block[rest + 1..].iter_mut() {
            *b = 0;
        }
        process(&mut h, &block.clone());
        block = [0u8; 64];
    }
    block[56..64].copy_from_slice(&ml.to_be_bytes());
    process(&mut h, &block.clone());
    let mut out = [0u8; 20];
    for (k, hv) in h.iter().enumerate() {
        out[k * 4..k * 4 + 4].copy_from_slice(&hv.to_be_bytes());
    }
    out
}

impl<'a> LdsLinker<'a> {
    pub(super) fn push_synth_section(&mut self, name: &str, shtype: u32, flags: u64) -> usize {
        let align = self.class.addr_size();
        let synth = self.synth_obj;
        let obj = &mut self.objects[synth];
        let idx = obj.sections.len();
        let orig_shndx = idx as u32 + 1;
        obj.sections.push(RawSection {
            name: name.to_string(),
            shtype,
            flags,
            addralign: align,
            entsize: 0,
            data_off: 0,
            size: 0,
            relocs: Vec::new(),
            orig_shndx,
            link: 0,
        });
        obj.shndx_map.insert(orig_shndx, idx);
        idx
    }

    pub(super) fn synthesize_sections(&mut self) {
        if let Some(path) = self.opts.interp.clone() {
            let idx = self.push_synth_section(SYNTH_INTERP, SHT_PROGBITS, SHF_ALLOC);
            let synth = self.synth_obj;
            let sec = &mut self.objects[synth].sections[idx];
            sec.addralign = 1;
            sec.size = path.len() as u64 + 1;
        }
        if !self.gnu_property.is_empty() {
            let idx = self.push_synth_section(SYNTH_GNU_PROPERTY, SHT_NOTE, SHF_ALLOC);
            let synth = self.synth_obj;
            let sec = &mut self.objects[synth].sections[idx];
            sec.addralign = self.class.addr_size();
            sec.size = self.gnu_property.len() as u64;
        }
        if self.opts.eh_frame_hdr {
            let idx = self.push_synth_section(SYNTH_EH_FRAME_HDR, SHT_PROGBITS, SHF_ALLOC);
            let synth = self.synth_obj;
            self.objects[synth].sections[idx].addralign = 4;
        }
        if self.opts.build_id_sha1 {
            let idx = self.push_synth_section(SYNTH_BUILD_ID, SHT_NOTE, SHF_ALLOC);
            let synth = self.synth_obj;
            let sec = &mut self.objects[synth].sections[idx];
            sec.addralign = 4;
            sec.size = 36; // 12-byte header + "GNU\0" + 20-byte sha1
        }
        if !self.opts.shared_libs.is_empty() {
            let idx = self.push_synth_section(SYNTH_PLT, SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR);
            let synth = self.synth_obj;
            self.objects[synth].sections[idx].addralign = PLT_ENTRY_SIZE;
        }
        if self.opts.emit == LdsEmit::Dyn {
            let (rela_name, rela_type, rela_ent) = self.dyn_reloc_kind();
            let rela = self.push_synth_section(rela_name, rela_type, SHF_ALLOC);
            // `.relr.dyn` exists only where RELR packing was asked for.
            // Creating it unconditionally leaves an empty section no
            // script names, which `--orphan-handling=error` rejects.
            let relr = self
                .opts
                .pack_relative_relocs
                .then(|| self.push_synth_section(SYNTH_RELR, SHT_RELR, SHF_ALLOC));
            let synth = self.synth_obj;
            let slot = self.class.addr_size();
            self.objects[synth].sections[rela].entsize = rela_ent;
            if let Some(relr) = relr {
                self.objects[synth].sections[relr].entsize = slot;
            }
        }
        // bfd builds the GOT for every dynamic image, and on demand
        // wherever an input names its base, so a static link reading
        // `_GLOBAL_OFFSET_TABLE_` still has an address to give it.
        if self.opts.emit == LdsEmit::Dyn || self.referenced.contains(GOT_SYMBOL) {
            let got = self.push_synth_section(SYNTH_GOT, SHT_PROGBITS, SHF_ALLOC | SHF_WRITE);
            let gotplt = self.push_synth_section(SYNTH_GOTPLT, SHT_PROGBITS, SHF_ALLOC | SHF_WRITE);
            let synth = self.synth_obj;
            let slot = self.class.addr_size();
            let reserved = self.got_reserved();
            self.objects[synth].sections[got].entsize = slot;
            // .got: the reserved header, where this target keeps it;
            // GOT slots append per use.
            self.objects[synth].sections[got].size = reserved * slot;
            // .got.plt: three reserved slots, no PLT entries.
            self.objects[synth].sections[gotplt].entsize = slot;
            self.objects[synth].sections[gotplt].size = 3 * slot;
        }
        if self.opts.emit == LdsEmit::Dyn {
            self.synthesize_dynamic_sections();
        }
    }

    /// The dynamic-linking tables. bfd builds these for every ET_DYN
    /// image; a script that does not want them discards them, which is
    /// what the kernel's own scripts do.
    fn synthesize_dynamic_sections(&mut self) {
        self.verdefs = self.script_verdefs();
        let mut secs: Vec<(&str, u32, u64, u64)> = Vec::new();
        if self.opts.hash_style.sysv() {
            secs.push((SYNTH_HASH, dynamic::SHT_HASH, SHF_ALLOC, 4));
        }
        if self.opts.hash_style.gnu() {
            // bfd gives `.gnu.hash` a 4-byte entsize on ELF32 only:
            // the ELF64 table's Bloom words are wider than its words.
            let ent = if self.class.is32() { 4 } else { 0 };
            secs.push((SYNTH_GNU_HASH, dynamic::SHT_GNU_HASH, SHF_ALLOC, ent));
        }
        secs.push((
            SYNTH_DYNSYM,
            dynamic::SHT_DYNSYM,
            SHF_ALLOC,
            self.class.sym_size(),
        ));
        secs.push((SYNTH_DYNSTR, SHT_STRTAB, SHF_ALLOC, 0));
        if !self.verdefs.is_empty() {
            secs.push((SYNTH_VERSYM, dynamic::SHT_GNU_VERSYM, SHF_ALLOC, 2));
            secs.push((SYNTH_VERDEF, dynamic::SHT_GNU_VERDEF, SHF_ALLOC, 0));
        }
        secs.push((
            SYNTH_DYNAMIC,
            dynamic::SHT_DYNAMIC,
            SHF_ALLOC | SHF_WRITE,
            self.class.dyn_size(),
        ));
        let default_align = self.class.addr_size();
        for (name, shtype, flags, entsize) in secs {
            let idx = self.push_synth_section(name, shtype, flags);
            let synth = self.synth_obj;
            let sec = &mut self.objects[synth].sections[idx];
            sec.entsize = entsize;
            sec.addralign = match name {
                SYNTH_DYNSTR => 1,
                SYNTH_VERSYM => 2,
                _ => default_align,
            };
        }
    }

    /// `.eh_frame_hdr` holds one table entry per FDE that reached the
    /// output. The count comes from the input bytes, so it is settled
    /// before any address is.
    pub(super) fn size_eh_frame_hdr(&mut self) {
        if !self.opts.eh_frame_hdr {
            return;
        }
        // Count over every input the `.eh_frame` output gathers, not
        // just those named `.eh_frame`: the writer scans that whole
        // output, and a script pulling `.eh_frame.*` into it would
        // otherwise size the table short of what it then writes.
        let mut fdes = 0usize;
        for i in 0..self.insecs.len() {
            let SecFate::Placed { out } = self.fates[i] else {
                continue;
            };
            if self.outs[out].name != OUT_EH_FRAME {
                continue;
            }
            fdes += eh_frame::count_fdes(self.chunk_input_bytes(i));
        }
        let size = if fdes == 0 {
            0
        } else {
            eh_frame::HEADER_SIZE + fdes as u64 * eh_frame::ENTRY_SIZE
        };
        let synth = self.synth_obj;
        if let Some(sec) = self.objects[synth]
            .sections
            .iter_mut()
            .find(|s| s.name == SYNTH_EH_FRAME_HDR)
        {
            sec.size = size;
        }
    }

    /// Write the synthesized sections' content: dynamic relocation
    /// tables, GOT slots, and the build-id note body (digest patched
    /// after the image is assembled).
    pub(super) fn fill_synth_contents(
        &mut self,
        contents: &mut HashMap<usize, Vec<u8>>,
        relr_set: &HashSet<u64>,
        out_shndx: &dyn Fn(usize) -> u16,
    ) {
        // Rebuild with the final section indices; the tables the sizing
        // pass produced carry placeholder ones.
        self.build_dyn_tables(out_shndx);
        let addrs = self.dyn_addrs();
        let dyn_section_addr = self.dyn_section_addr();
        let class = self.class;
        let dynamic_bytes = dynamic::build_dynamic(&addrs, class);
        let (rela_name, _, rela_ent) = self.dyn_reloc_kind();
        let slot = class.addr_size();
        let aw = slot as usize;
        let use_rela = machine_uses_rela(self.machine);
        let synth = self.synth_obj;
        for sec_idx in 0..self.objects[synth].sections.len() {
            let name = self.objects[synth].sections[sec_idx].name.clone();
            let i = self.insec_index(synth, sec_idx);
            let SecFate::Placed { out } = self.fates[i] else {
                continue;
            };
            if self.outs[out].removed {
                continue;
            }
            let off = self.placements[i].off as usize;
            let mut bytes: Vec<u8> = Vec::new();
            if name == rela_name {
                // Reserved slots stay zeroed (R_*_NONE) ahead of the
                // live entries, as bfd leaves them.
                bytes.resize(self.dyn_nones.unwrap_or(0) as usize * rela_ent as usize, 0);
                for d in &self.dyn_relas {
                    bytes.extend_from_slice(&class.addr_bytes(d.offset)[..aw]);
                    bytes.extend_from_slice(
                        &class.addr_bytes(class.reloc_info(d.sym, d.rtype))[..aw],
                    );
                    if use_rela {
                        bytes.extend_from_slice(&class.addr_bytes(d.addend as u64)[..aw]);
                    }
                }
            } else {
                match name.as_str() {
                    SYNTH_RELR => {
                        for wdd in encode_relr(&self.relr_addrs, slot) {
                            bytes.extend_from_slice(&class.addr_bytes(wdd)[..slot as usize]);
                        }
                    }
                    SYNTH_GOT if self.objects[synth].sections[sec_idx].size == 0 => {}
                    SYNTH_GOT => {
                        // The header slot holds the `.dynamic` address, as
                        // bfd writes `_GLOBAL_OFFSET_TABLE_[0]`.
                        if self.got_reserved() != 0 {
                            bytes.extend_from_slice(
                                &class.addr_bytes(dyn_section_addr.unwrap_or(0))[..aw],
                            );
                        }
                        let base = self.got_slot_base().unwrap_or(0);
                        for (k, gname) in self.got_slots.clone().iter().enumerate() {
                            let v = self.resolve_name(gname).unwrap_or(0);
                            let slot_addr = base + k as u64 * slot;
                            let write =
                                relr_set.contains(&slot_addr) || self.opts.apply_dynamic_relocs;
                            bytes.extend_from_slice(
                                &class.addr_bytes(if write { v } else { 0 })[..aw],
                            );
                        }
                    }
                    SYNTH_GOTPLT => {
                        bytes.resize(3 * aw, 0);
                        // Where `_GLOBAL_OFFSET_TABLE_` names this
                        // section, its first slot is the header the
                        // psABI points at `.dynamic`; the next two are
                        // the dynamic linker's.
                        if self.got_on_got_plt() {
                            bytes[..aw].copy_from_slice(
                                &class.addr_bytes(dyn_section_addr.unwrap_or(0))[..aw],
                            );
                        }
                    }
                    SYNTH_BUILD_ID => {
                        bytes.extend_from_slice(&4u32.to_le_bytes()); // namesz
                        bytes.extend_from_slice(&20u32.to_le_bytes()); // descsz
                        bytes.extend_from_slice(&3u32.to_le_bytes()); // NT_GNU_BUILD_ID
                        bytes.extend_from_slice(b"GNU\0");
                        bytes.extend_from_slice(&[0u8; 20]);
                    }
                    SYNTH_GNU_PROPERTY => bytes = self.gnu_property.clone(),
                    SYNTH_INTERP => {
                        bytes = self.opts.interp.clone().unwrap_or_default().into_bytes();
                        bytes.push(0);
                    }
                    SYNTH_PLT => bytes = self.plt_bytes(),
                    SYNTH_DYNAMIC => bytes = dynamic_bytes.clone(),
                    SYNTH_EH_FRAME_HDR => {
                        let Some(hdr_addr) = self.synth_addr(SYNTH_EH_FRAME_HDR) else {
                            continue;
                        };
                        let Some((eh_out, eh_addr)) = self
                            .outs
                            .iter()
                            .position(|o| o.name == OUT_EH_FRAME && !o.removed)
                            .map(|k| (k, self.outs[k].addr))
                        else {
                            continue;
                        };
                        // The linked `.eh_frame` is relocated by now, so
                        // its FDE pointers name final addresses.
                        let Some(body) = contents.get(&eh_out) else {
                            continue;
                        };
                        match eh_frame::scan(body, eh_addr)
                            .and_then(|e| eh_frame::build(hdr_addr, eh_addr, &e))
                        {
                            Ok(b) => bytes = b,
                            Err(e) => {
                                self.errors.push(e);
                                continue;
                            }
                        }
                    }
                    SYNTH_DYNSYM | SYNTH_DYNSTR | SYNTH_HASH | SYNTH_GNU_HASH | SYNTH_VERSYM
                    | SYNTH_VERDEF => {
                        let Some(t) = &self.dyn_tables else {
                            continue;
                        };
                        bytes = match name.as_str() {
                            SYNTH_DYNSYM => t.dynsym.clone(),
                            SYNTH_DYNSTR => t.dynstr().to_vec(),
                            SYNTH_HASH => t.hash.clone(),
                            SYNTH_GNU_HASH => t.gnu_hash.clone(),
                            SYNTH_VERSYM => t.versym.clone(),
                            _ => t.verdef.clone(),
                        };
                    }
                    _ => continue,
                }
            }
            // Content longer than the section sized for it means the
            // sizing pass and the writer disagreed. Truncating leaves a
            // table a consumer indexes past the end of, so it is a link
            // failure rather than a silent short write.
            if bytes.len() > self.objects[synth].sections[sec_idx].size as usize {
                self.errors.push(format!(
                    "internal: `{name}' holds {} bytes in a section sized {}",
                    bytes.len(),
                    self.objects[synth].sections[sec_idx].size
                ));
                continue;
            }
            if let Some(buf) = contents.get_mut(&out) {
                let n = bytes.len().min(buf.len().saturating_sub(off));
                buf[off..off + n].copy_from_slice(&bytes[..n]);
            }
        }
    }

    pub(super) fn build_id_location(&self) -> Option<(usize, u64)> {
        let synth = self.synth_obj;
        let sec = self.objects[synth]
            .sections
            .iter()
            .position(|s| s.name == SYNTH_BUILD_ID)?;
        let i = self.insec_index(synth, sec);
        match self.fates[i] {
            SecFate::Placed { out } => Some((out, self.placements[i].off)),
            _ => None,
        }
    }
}
