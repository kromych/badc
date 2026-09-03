//! The ELF image and the link map.

use crate::c5::error::C5Error;
use crate::c5::linker::object::Elf64Shdr;
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;
use hashbrown::HashMap;

use super::synth::sha1;
use super::{
    ChunkSrc, ET_DYN, ET_EXEC, Elf64Phdr, FinalSym, LdsEmit, LdsLinker, PT_LOAD, PT_PHDR, Piece,
    SHF_LINK_ORDER, SHT_NOBITS, SHT_REL, SHT_RELA, SHT_STRTAB, SHT_SYMTAB, STB_LOCAL,
    SYNTH_DYNAMIC, SYNTH_DYNSTR, SYNTH_DYNSYM, SYNTH_GNU_HASH, SYNTH_HASH, SYNTH_VERDEF,
    SYNTH_VERSYM, SecFate, align_up, machine_uses_rela,
};

impl<'a> LdsLinker<'a> {
    /// `sh_link` of an `SHF_LINK_ORDER` output section: the output
    /// section holding what its inputs are ordered against, as bfd
    /// records in `assign_section_numbers`. Zero when the target went
    /// away with its section.
    fn link_order_target(&self, oi: usize, shndx_of_out: &HashMap<usize, u16>) -> u32 {
        let Some(i) = self.first_input(oi) else {
            return 0;
        };
        let id = self.insecs[i];
        let sec = &self.objects[id.obj].sections[id.sec];
        let Some(&target) = self.objects[id.obj].shndx_map.get(&sec.link) else {
            return 0;
        };
        match self.fates[self.insec_index(id.obj, target)] {
            SecFate::Placed { out } => shndx_of_out.get(&out).copied().unwrap_or(0) as u32,
            _ => 0,
        }
    }

    /// First input section placed into an output section.
    pub(super) fn first_input(&self, oi: usize) -> Option<usize> {
        self.outs[oi].pieces.iter().find_map(|p| match p {
            Piece::Inputs(v) => v.first().copied(),
            _ => None,
        })
    }

    pub(super) fn write_image(
        &mut self,
        emit_order: &[usize],
        shndx_of_out: &HashMap<usize, u16>,
        contents: HashMap<usize, Vec<u8>>,
        mut phdrs: Vec<(Elf64Phdr, Vec<usize>)>,
        syms: Vec<FinalSym>,
        entry: u64,
    ) -> Result<Vec<u8>, C5Error> {
        let class = self.class;
        let phnum = phdrs.len();
        let headers_end = class.ehdr_size() + phnum as u64 * class.phdr_size();

        // File offsets. PT_LOAD members get congruent placement;
        // everything else follows section order.
        let mut file_off: HashMap<usize, u64> = HashMap::new();
        let mut pos = headers_end;
        // Which PT_LOAD each section belongs to (first membership).
        let mut load_of: HashMap<usize, usize> = HashMap::new();
        for (k, (ph, members)) in phdrs.iter().enumerate() {
            if ph.p_type != PT_LOAD {
                continue;
            }
            for &oi in members {
                load_of.entry(oi).or_insert(k);
            }
        }
        let mut load_positions: HashMap<usize, (u64, u64)> = HashMap::new(); // seg -> (off, vaddr)
        for &oi in emit_order {
            let (alloc, addr, size, nobits, salign) = {
                let o = &self.outs[oi];
                (o.alloc, o.addr, o.size, o.shtype == SHT_NOBITS, o.align)
            };
            if !alloc {
                continue;
            }
            match load_of.get(&oi) {
                Some(&seg) => {
                    if !load_positions.contains_key(&seg) {
                        // Smallest offset at or past the cursor
                        // congruent to the segment's vaddr modulo its
                        // alignment.
                        let a = phdrs[seg].0.p_align.max(1);
                        let want = addr % a;
                        let have = pos % a;
                        let off = if want >= have {
                            pos - have + want
                        } else {
                            pos - have + a + want
                        };
                        load_positions.insert(seg, (off, addr));
                    }
                    let (seg_off, seg_vaddr) = load_positions[&seg];
                    if nobits {
                        file_off.insert(oi, pos);
                    } else {
                        let off = seg_off + (addr - seg_vaddr);
                        file_off.insert(oi, off);
                        pos = pos.max(off + size);
                    }
                }
                None => {
                    let off = align_up(pos, salign.min(self.opts.max_page_size).max(1));
                    file_off.insert(oi, off);
                    if !nobits {
                        pos = off + size;
                    }
                }
            }
        }
        // Non-alloc sections after the load image.
        for &oi in emit_order {
            let o = &self.outs[oi];
            if o.alloc {
                continue;
            }
            let off = align_up(pos, o.align.max(1));
            file_off.insert(oi, off);
            if o.shtype != SHT_NOBITS {
                pos = off + o.size;
            }
        }

        // Program header extents. A segment the script declared
        // `FILEHDR`/`PHDRS` reaches back over those headers, so the
        // image a loader maps starts at the ELF header -- which is
        // what lets a consumer derive the load bias from the first
        // PT_LOAD.
        let defs = self.script.phdrs().unwrap_or(&[]).to_owned();
        // Absent a `PHDRS` command the first PT_LOAD covers them, which
        // is what bfd's default segment map does and what leaves the
        // headers mapped for a loader to read.
        let default_first_load = defs.is_empty().then(|| {
            phdrs
                .iter()
                .position(|(p, m)| p.p_type == PT_LOAD && !m.is_empty())
        });
        for (k, (ph, members)) in phdrs.iter_mut().enumerate() {
            if members.is_empty() {
                continue;
            }
            let first = members[0];
            ph.p_vaddr = self.outs[first].addr;
            ph.p_paddr = self.outs[first].lma;
            ph.p_offset = file_off[&first];
            if default_first_load == Some(Some(k)) && ph.p_offset <= ph.p_vaddr {
                let back = ph.p_offset;
                ph.p_offset = 0;
                ph.p_vaddr -= back;
                ph.p_paddr = ph.p_paddr.saturating_sub(back);
            }
            if let Some(d) = defs.get(k) {
                let cover = match (d.filehdr, d.phdrs) {
                    (true, _) => Some(0),
                    (false, true) => Some(class.ehdr_size()),
                    _ => None,
                };
                if let Some(want) = cover.filter(|&w| w < ph.p_offset) {
                    let back = ph.p_offset - want;
                    ph.p_offset = want;
                    ph.p_vaddr = ph.p_vaddr.saturating_sub(back);
                    ph.p_paddr = ph.p_paddr.saturating_sub(back);
                }
            }
            let mut file_end = ph.p_offset;
            let mut mem_end = ph.p_vaddr;
            for &oi in members.iter() {
                let o = &self.outs[oi];
                mem_end = mem_end.max(o.addr + o.size);
                if o.shtype != SHT_NOBITS {
                    file_end = file_end.max(file_off[&oi] + o.size);
                }
            }
            ph.p_filesz = file_end - ph.p_offset;
            ph.p_memsz = mem_end - ph.p_vaddr;
        }
        // PT_PHDR covers the header table, inside the segment that
        // reaches back over it.
        if let Some(load) = phdrs
            .iter()
            .find(|(p, m)| p.p_type == PT_LOAD && !m.is_empty())
            .map(|(p, _)| (p.p_offset, p.p_vaddr))
            && let Some((ph, _)) = phdrs.iter_mut().find(|(p, _)| p.p_type == PT_PHDR)
        {
            ph.p_offset = class.ehdr_size();
            ph.p_vaddr = load.1 + (class.ehdr_size() - load.0);
            ph.p_paddr = ph.p_vaddr;
            ph.p_filesz = phnum as u64 * class.phdr_size();
            ph.p_memsz = ph.p_filesz;
        }

        // Symbol/string tables.
        let mut strtab: Vec<u8> = alloc::vec![0];
        let mut sym_bytes: Vec<u8> = Vec::new();
        let mut locals = 1u32;
        let mut final_of: Vec<u32> = alloc::vec![0; syms.len()];
        {
            let push = |s: &FinalSym, strtab: &mut Vec<u8>, sym_bytes: &mut Vec<u8>| {
                let name_off = if s.name.is_empty() {
                    0
                } else {
                    let off = strtab.len() as u32;
                    strtab.extend_from_slice(s.name.as_bytes());
                    strtab.push(0);
                    off
                };
                sym_bytes.extend_from_slice(&name_off.to_le_bytes());
                // Elf32_Sym puts value and size ahead of st_info.
                if class.is32() {
                    sym_bytes.extend_from_slice(&(s.value as u32).to_le_bytes());
                    sym_bytes.extend_from_slice(&(s.size as u32).to_le_bytes());
                    sym_bytes.push(s.info);
                    sym_bytes.push(s.other);
                    sym_bytes.extend_from_slice(&s.shndx.to_le_bytes());
                } else {
                    sym_bytes.push(s.info);
                    sym_bytes.push(s.other);
                    sym_bytes.extend_from_slice(&s.shndx.to_le_bytes());
                    sym_bytes.extend_from_slice(&s.value.to_le_bytes());
                    sym_bytes.extend_from_slice(&s.size.to_le_bytes());
                }
            };
            // Null entry.
            sym_bytes.resize(class.sym_size() as usize, 0);
            let mut next = 1u32;
            for (i, s) in syms.iter().enumerate() {
                if s.info >> 4 == STB_LOCAL {
                    push(s, &mut strtab, &mut sym_bytes);
                    final_of[i] = next;
                    next += 1;
                    locals += 1;
                }
            }
            for (i, s) in syms.iter().enumerate() {
                if s.info >> 4 != STB_LOCAL {
                    push(s, &mut strtab, &mut sym_bytes);
                    final_of[i] = next;
                    next += 1;
                }
            }
        }

        let rela: Vec<(usize, Vec<u8>)> = self.emitted_rela_sections(&final_of, &syms)?;

        // Section header string table.
        let mut shstrtab: Vec<u8> = alloc::vec![0];
        let mut shname: HashMap<String, u32> = HashMap::new();
        let intern = |name: &str, shstrtab: &mut Vec<u8>, shname: &mut HashMap<String, u32>| {
            if let Some(&off) = shname.get(name) {
                return off;
            }
            let off = shstrtab.len() as u32;
            shstrtab.extend_from_slice(name.as_bytes());
            shstrtab.push(0);
            shname.insert(name.to_string(), off);
            off
        };

        let talign = class.addr_size();
        let symtab_off = align_up(pos, talign);
        let strtab_off = symtab_off + sym_bytes.len() as u64;
        let shstr_names: Vec<u32> = emit_order
            .iter()
            .map(|&oi| intern(&self.outs[oi].name.clone(), &mut shstrtab, &mut shname))
            .collect();
        let n_symtab = intern(".symtab", &mut shstrtab, &mut shname);
        let n_strtab = intern(".strtab", &mut shstrtab, &mut shname);
        let n_shstrtab = intern(".shstrtab", &mut shstrtab, &mut shname);
        // `--emit-relocs` writes the target's own relocation format:
        // `.rel.<sec>` where inputs carry implicit addends.
        let use_rela = machine_uses_rela(self.machine);
        let rela_names: Vec<u32> = rela
            .iter()
            .map(|(oi, _)| {
                let n = if use_rela {
                    format!(".rela{}", self.outs[*oi].name)
                } else {
                    format!(".rel{}", self.outs[*oi].name)
                };
                intern(&n, &mut shstrtab, &mut shname)
            })
            .collect();
        let shstr_off = strtab_off + strtab.len() as u64;
        let mut rela_off: Vec<u64> = Vec::with_capacity(rela.len());
        let mut pos_after = shstr_off + shstrtab.len() as u64;
        for (_, body) in &rela {
            let at = align_up(pos_after, talign);
            rela_off.push(at);
            pos_after = at + body.len() as u64;
        }
        let shoff = align_up(pos_after, talign);
        // null + sections + symtab + strtab + shstrtab + one per rela
        let shnum = emit_order.len() + 4 + rela.len();

        let mut image: Vec<u8> =
            alloc::vec![0u8; shoff as usize + shnum * class.shdr_size() as usize];

        // ELF header.
        let e_type = match self.opts.emit {
            LdsEmit::Exec => ET_EXEC,
            LdsEmit::Dyn => ET_DYN,
        };
        image[0..4].copy_from_slice(b"\x7fELF");
        image[4] = class.ei_class();
        image[5] = 1;
        image[6] = 1;
        image[16..18].copy_from_slice(&e_type.to_le_bytes());
        image[18..20].copy_from_slice(&self.machine.to_le_bytes());
        image[20..24].copy_from_slice(&1u32.to_le_bytes());
        let aw = class.addr_size() as usize;
        let put = |image: &mut Vec<u8>, at: usize, v: u64| {
            image[at..at + aw].copy_from_slice(&class.addr_bytes(v)[..aw]);
        };
        put(&mut image, 24, entry);
        put(&mut image, 24 + aw, class.ehdr_size());
        put(&mut image, 24 + 2 * aw, shoff);
        let hdr_tail = 24 + 3 * aw + 4;
        image[hdr_tail..hdr_tail + 2].copy_from_slice(&(class.ehdr_size() as u16).to_le_bytes());
        image[hdr_tail + 2..hdr_tail + 4]
            .copy_from_slice(&(class.phdr_size() as u16).to_le_bytes());
        image[hdr_tail + 4..hdr_tail + 6].copy_from_slice(&(phnum as u16).to_le_bytes());
        image[hdr_tail + 6..hdr_tail + 8]
            .copy_from_slice(&(class.shdr_size() as u16).to_le_bytes());
        image[hdr_tail + 8..hdr_tail + 10].copy_from_slice(&(shnum as u16).to_le_bytes());
        // `.shstrtab` keeps its index whether or not `--emit-relocs`
        // appended tables after it.
        image[hdr_tail + 10..hdr_tail + 12]
            .copy_from_slice(&((emit_order.len() + 3) as u16).to_le_bytes());

        // Program headers. Elf32_Phdr puts p_flags after the sizes.
        for (k, (ph, _)) in phdrs.iter().enumerate() {
            let at = class.ehdr_size() as usize + k * class.phdr_size() as usize;
            image[at..at + 4].copy_from_slice(&ph.p_type.to_le_bytes());
            let (word, flags_at) = if class.is32() {
                (at + 4, at + 24)
            } else {
                (at + 8, at + 4)
            };
            image[flags_at..flags_at + 4].copy_from_slice(&ph.p_flags.to_le_bytes());
            for (f, v) in [
                ph.p_offset,
                ph.p_vaddr,
                ph.p_paddr,
                ph.p_filesz,
                ph.p_memsz,
                ph.p_align,
            ]
            .into_iter()
            .enumerate()
            {
                // p_flags splits the ELF32 sequence before p_align.
                let skip = usize::from(class.is32() && f == 5) * 4;
                put(&mut image, word + f * aw + skip, v);
            }
        }

        // Section bodies.
        for &oi in emit_order {
            let o = &self.outs[oi];
            if o.shtype == SHT_NOBITS {
                continue;
            }
            if let Some(body) = contents.get(&oi) {
                let off = file_off[&oi] as usize;
                image[off..off + body.len()].copy_from_slice(body);
            }
        }
        image[symtab_off as usize..symtab_off as usize + sym_bytes.len()]
            .copy_from_slice(&sym_bytes);
        image[strtab_off as usize..strtab_off as usize + strtab.len()].copy_from_slice(&strtab);
        image[shstr_off as usize..shstr_off as usize + shstrtab.len()].copy_from_slice(&shstrtab);
        for (k, (_, body)) in rela.iter().enumerate() {
            let at = rela_off[k] as usize;
            image[at..at + body.len()].copy_from_slice(body);
        }

        // Section headers.
        let wr_shdr = |idx: usize, sh: Elf64Shdr, image: &mut Vec<u8>| {
            let at = shoff as usize + idx * class.shdr_size() as usize;
            image[at..at + 4].copy_from_slice(&sh.sh_name.to_le_bytes());
            image[at + 4..at + 8].copy_from_slice(&sh.sh_type.to_le_bytes());
            for (f, v) in [sh.sh_flags, sh.sh_addr, sh.sh_offset, sh.sh_size]
                .into_iter()
                .enumerate()
            {
                let o = at + 8 + f * aw;
                image[o..o + aw].copy_from_slice(&class.addr_bytes(v)[..aw]);
            }
            let o = at + 8 + 4 * aw;
            image[o..o + 4].copy_from_slice(&sh.sh_link.to_le_bytes());
            image[o + 4..o + 8].copy_from_slice(&sh.sh_info.to_le_bytes());
            for (f, v) in [sh.sh_addralign, sh.sh_entsize].into_iter().enumerate() {
                let o = o + 8 + f * aw;
                image[o..o + aw].copy_from_slice(&class.addr_bytes(v)[..aw]);
            }
        };
        // `sh_link`/`sh_info` for the dynamic tables: each names the
        // table a consumer must read alongside it.
        let out_index = |name: &str| -> u32 {
            emit_order
                .iter()
                .position(|&oi| self.outs[oi].name == name)
                .map(|k| k as u32 + 1)
                .unwrap_or(0)
        };
        let (dynsym_ndx, dynstr_ndx) = (out_index(SYNTH_DYNSYM), out_index(SYNTH_DYNSTR));
        let dyn_rel_name = self.dyn_reloc_name();
        for (k, &oi) in emit_order.iter().enumerate() {
            let o = &self.outs[oi];
            if o.name == dyn_rel_name {
                wr_shdr(
                    k + 1,
                    Elf64Shdr {
                        sh_name: shstr_names[k],
                        sh_type: o.shtype,
                        sh_flags: o.flags,
                        sh_addr: o.addr,
                        sh_offset: file_off[&oi],
                        sh_size: o.size,
                        sh_link: dynsym_ndx,
                        sh_info: 0,
                        sh_addralign: o.align,
                        sh_entsize: o.entsize,
                    },
                    &mut image,
                );
                continue;
            }
            let (sh_link, sh_info) = match o.name.as_str() {
                SYNTH_DYNSYM => (
                    dynstr_ndx,
                    self.dyn_tables
                        .as_ref()
                        .map(|t| t.first_global)
                        .unwrap_or(0),
                ),
                SYNTH_HASH | SYNTH_GNU_HASH | SYNTH_VERSYM => (dynsym_ndx, 0),
                SYNTH_VERDEF => (
                    dynstr_ndx,
                    self.dyn_tables
                        .as_ref()
                        .map(|t| t.verdef_count as u32)
                        .unwrap_or(0),
                ),
                SYNTH_DYNAMIC => (dynstr_ndx, 0),
                _ if o.flags & SHF_LINK_ORDER != 0 => (self.link_order_target(oi, shndx_of_out), 0),
                _ => (0, 0),
            };
            wr_shdr(
                k + 1,
                Elf64Shdr {
                    sh_name: shstr_names[k],
                    sh_type: o.shtype,
                    sh_flags: o.flags,
                    sh_addr: o.addr,
                    sh_offset: file_off[&oi],
                    sh_size: o.size,
                    sh_link,
                    sh_info,
                    sh_addralign: o.align,
                    sh_entsize: o.entsize,
                },
                &mut image,
            );
        }
        let symtab_idx = emit_order.len() + 1;
        wr_shdr(
            symtab_idx,
            Elf64Shdr {
                sh_name: n_symtab,
                sh_type: SHT_SYMTAB,
                sh_flags: 0,
                sh_addr: 0,
                sh_offset: symtab_off,
                sh_size: sym_bytes.len() as u64,
                sh_link: (symtab_idx + 1) as u32,
                sh_info: locals,
                sh_addralign: talign,
                sh_entsize: class.sym_size(),
            },
            &mut image,
        );
        wr_shdr(
            symtab_idx + 1,
            Elf64Shdr {
                sh_name: n_strtab,
                sh_type: SHT_STRTAB,
                sh_flags: 0,
                sh_addr: 0,
                sh_offset: strtab_off,
                sh_size: strtab.len() as u64,
                sh_link: 0,
                sh_info: 0,
                sh_addralign: 1,
                sh_entsize: 0,
            },
            &mut image,
        );
        wr_shdr(
            symtab_idx + 2,
            Elf64Shdr {
                sh_name: n_shstrtab,
                sh_type: SHT_STRTAB,
                sh_flags: 0,
                sh_addr: 0,
                sh_offset: shstr_off,
                sh_size: shstrtab.len() as u64,
                sh_link: 0,
                sh_info: 0,
                sh_addralign: 1,
                sh_entsize: 0,
            },
            &mut image,
        );
        for (k, (oi, body)) in rela.iter().enumerate() {
            wr_shdr(
                symtab_idx + 3 + k,
                Elf64Shdr {
                    sh_name: rela_names[k],
                    sh_type: if use_rela { SHT_RELA } else { SHT_REL },
                    sh_flags: 0,
                    sh_addr: 0,
                    sh_offset: rela_off[k],
                    sh_size: body.len() as u64,
                    sh_link: symtab_idx as u32,
                    sh_info: shndx_of_out[oi] as u32,
                    sh_addralign: talign,
                    sh_entsize: if use_rela {
                        class.rela_size()
                    } else {
                        class.rel_size()
                    },
                },
                &mut image,
            );
        }

        // Build-id digest over the whole image with the digest field
        // zeroed (it already is), then patched in place.
        if self.opts.build_id_sha1
            && let Some((out, off)) = self.build_id_location()
            && !self.outs[out].removed
            && self.outs[out].shtype != SHT_NOBITS
        {
            let file_at = file_off[&out] + off + 16;
            let digest = sha1(&image);
            let at = file_at as usize;
            if at + 20 <= image.len() {
                image[at..at + 20].copy_from_slice(&digest);
            }
        }
        Ok(image)
    }

    pub(super) fn render_map(&self, emit_order: &[usize]) -> String {
        use core::fmt::Write as _;
        // bfd prints a vma at the target's address width.
        let w = self.class.addr_size() as usize * 2;
        let mut s = String::new();
        let _ = writeln!(s, "Memory Configuration\n");
        let _ = writeln!(
            s,
            "Name             Origin             Length             Attributes"
        );
        let _ = writeln!(
            s,
            "*default*        0x{:0w$x} 0x{:0w$x}\n",
            0,
            u64::MAX >> (64 - w * 4)
        );
        let _ = writeln!(s, "Linker script and memory map\n");
        for &oi in emit_order {
            let o = &self.outs[oi];
            let _ = writeln!(
                s,
                "{:<15} 0x{:0w$x} 0x{:x}{}",
                o.name,
                o.addr,
                o.size,
                if o.lma != o.addr {
                    format!(" load address 0x{:0w$x}", o.lma)
                } else {
                    String::new()
                }
            );
            for (off, len, src) in &o.chunks {
                if let ChunkSrc::Input(i) = src {
                    let id = self.insecs[*i];
                    let _ = writeln!(
                        s,
                        " {:<14} 0x{:0w$x} 0x{:x} {}",
                        self.insec(*i).name,
                        o.addr + off,
                        len,
                        self.objects[id.obj].source
                    );
                }
            }
        }
        s
    }
}
