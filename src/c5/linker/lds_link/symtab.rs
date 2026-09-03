//! The output symbol table.

use crate::c5::error::C5Error;
use crate::c5::linker::link_err;
use crate::c5::object::elf_reloc_types::GOT_BASE_SYMBOL as GOT_SYMBOL;
use alloc::collections::{BTreeMap, BTreeSet};
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;
use hashbrown::HashMap;

use super::{
    Att, EM_AARCH64, EmittedReloc, FinalSym, LdsEmit, LdsLinker, MODULE, Piece, SHF_EXECINSTR,
    SHF_MERGE, SHN_ABS, SHN_COMMON, SHN_UNDEF, STB_GLOBAL, STB_LOCAL, STB_WEAK, STT_FILE, STT_FUNC,
    STT_NOTYPE, STT_OBJECT, STT_SECTION, STV_DEFAULT, STV_HIDDEN, ScriptSym, SecFate, SymIndex,
    machine_uses_rela,
};

/// Name bfd gives a synthesized file symbol: the input's base name,
/// which for an archive member is the member name.
fn file_sym_name(source: &str) -> String {
    let base = source.rsplit(['/', '\\']).next().unwrap_or(source);
    base.split_once('(')
        .map(|(_, m)| m.trim_end_matches(')'))
        .unwrap_or(base)
        .to_string()
}

impl<'a> LdsLinker<'a> {
    pub(super) fn default_entry(&self, emit_order: &[usize]) -> u64 {
        for &oi in emit_order {
            let o = &self.outs[oi];
            if o.alloc && o.flags & SHF_EXECINSTR != 0 {
                return o.addr;
            }
        }
        0
    }

    pub(super) fn final_sym_value(&self, name: &str) -> Option<u64> {
        if let Some(s) = self.script_now.get(name) {
            return Some(s.val.v);
        }
        let &(oi, si) = self.globals.get(name)?;
        self.resolve_sym_prevpass(oi, si, 0)
    }

    /// Section flags of the input section a symbol is defined in, zero
    /// for a symbol that names no section.
    fn sym_input_flags(&self, obj_i: usize, sym_i: usize) -> u64 {
        let sym = &self.objects[obj_i].symbols[sym_i];
        match self.objects[obj_i].shndx_map.get(&sym.shndx) {
            Some(&sec) => self.objects[obj_i].sections[sec].flags,
            None => 0,
        }
    }

    /// Object order for local symbols: bfd walks the output sections
    /// and takes each object the first time one of its input sections
    /// is reached, then sweeps the objects no output section took.
    fn local_symbol_object_order(&self, emit_order: &[usize]) -> Vec<usize> {
        let mut seen = alloc::vec![false; self.objects.len()];
        let mut order: Vec<usize> = Vec::new();
        if self.synth_obj < seen.len() {
            seen[self.synth_obj] = true;
        }
        for &oi in emit_order {
            for p in &self.outs[oi].pieces {
                let Piece::Inputs(v) = p else { continue };
                for &i in v {
                    let obj = self.insecs[i].obj;
                    if !seen[obj] {
                        seen[obj] = true;
                        order.push(obj);
                    }
                }
            }
        }
        for (obj, taken) in seen.iter().enumerate() {
            if !taken {
                order.push(obj);
            }
        }
        order
    }

    pub(super) fn build_symtab(
        &self,
        emit_order: &[usize],
        out_shndx: &dyn Fn(usize) -> u16,
        index: &mut SymIndex,
    ) -> Vec<FinalSym> {
        let track = self.opts.emit_relocs;
        let mut syms: Vec<FinalSym> = Vec::new();
        // Section symbols exist for relocations to name, so bfd emits
        // them only when the output carries relocations
        // (`bfd_link_relocatable(info) || info->emitrelocations`). This
        // engine writes no relocatable output; `-r` is a separate path.
        if track {
            for &oi in emit_order {
                index.sec.insert(oi, syms.len());
                syms.push(FinalSym {
                    name: String::new(),
                    info: STT_SECTION,
                    other: 0,
                    shndx: out_shndx(oi),
                    value: self.outs[oi].addr,
                    size: 0,
                });
            }
        }
        // Local symbols per input object, in the order bfd reaches the
        // objects.
        for obj_i in self.local_symbol_object_order(emit_order) {
            let o = &self.objects[obj_i];
            // bfd carries the file symbol of the object whose locals
            // follow, synthesizing one from the input's name when the
            // object has none, so a local is never read as belonging
            // to the preceding file.
            let mut have_file = false;
            for (sym_i, sym) in o.symbols.iter().enumerate() {
                if sym.binding() != STB_LOCAL || sym.kind() == STT_SECTION {
                    continue;
                }
                if sym.kind() == STT_FILE {
                    have_file = true;
                    if track {
                        index.local.insert((obj_i, sym_i as u32), syms.len());
                    }
                    syms.push(FinalSym {
                        name: sym.name.clone(),
                        info: sym.info,
                        other: sym.other,
                        shndx: SHN_ABS,
                        value: 0,
                        size: 0,
                    });
                    continue;
                }
                // `-X` drops every compiler temporary; bfd's default
                // policy drops the ones a merged section holds, whose
                // offsets deduplication moves, unless the link emits
                // relocations that can name them.
                if !self.opts.discard_none
                    && crate::c5::asm::is_local_label(&sym.name)
                    && (self.opts.discard_locals
                        || (!track && self.sym_input_flags(obj_i, sym_i) & SHF_MERGE != 0))
                {
                    continue;
                }
                if let Some(fs) = self.finalize_sym(obj_i, sym_i, out_shndx) {
                    if !have_file {
                        have_file = true;
                        syms.push(FinalSym {
                            name: file_sym_name(&o.source),
                            info: (STB_LOCAL << 4) | STT_FILE,
                            other: 0,
                            shndx: SHN_ABS,
                            value: 0,
                            size: 0,
                        });
                    }
                    if track {
                        index.local.insert((obj_i, sym_i as u32), syms.len());
                    }
                    syms.push(fs);
                }
            }
        }
        for (name, oi, addr) in &self.veneer_syms {
            syms.push(FinalSym {
                name: name.clone(),
                info: (STB_LOCAL << 4) | STT_FUNC,
                other: 0,
                shndx: out_shndx(*oi),
                value: *addr,
                size: 8,
            });
        }
        // A symbol's visibility aggregates over every reference and
        // definition; hidden or internal globals cannot be preempted
        // and are emitted with local binding. bfd applies the forcing
        // from the dynamic-symbol adjustment, so only links with
        // dynamic sections see it.
        let mut forced_vis: HashMap<&str, u8> = HashMap::new();
        if self.opts.emit == LdsEmit::Dyn {
            for o in &self.objects {
                for sym in &o.symbols {
                    let vis = sym.other & 0x3;
                    if sym.binding() == STB_LOCAL || sym.name.is_empty() || vis == 0 || vis == 3 {
                        continue;
                    }
                    let e = forced_vis.entry(sym.name.as_str()).or_insert(vis);
                    // INTERNAL(1) constrains more than HIDDEN(2).
                    *e = (*e).min(vis);
                }
            }
        }
        // Resolved global definitions, name order (the table order is
        // not part of the contract; nm sorts).
        let mut global_defs: Vec<(&String, (usize, usize))> =
            self.globals.iter().map(|(n, &d)| (n, d)).collect();
        global_defs.sort_by(|a, b| a.0.cmp(b.0));
        for (name, (obj_i, sym_i)) in global_defs {
            if self.script_now.contains_key(name) {
                continue; // script assignment overrides
            }
            if let Some(mut fs) = self.finalize_sym(obj_i, sym_i, out_shndx) {
                if let Some(&vis) = forced_vis.get(name.as_str()) {
                    fs.info = (STB_LOCAL << 4) | (fs.info & 0xf);
                    fs.other = vis;
                }
                if track {
                    index.by_name.insert(name.clone(), syms.len());
                }
                syms.push(fs);
            }
        }
        // Script-defined symbols.
        let mut script_syms: Vec<(&String, &ScriptSym)> = self.script_now.iter().collect();
        script_syms.sort_by(|a, b| a.0.cmp(b.0));
        for (name, s) in script_syms {
            let shndx = match (s.val.att, s.final_out) {
                (Att::Out(oi), _) => out_shndx(oi),
                (_, Some(oi)) => out_shndx(oi),
                (_, None) => SHN_ABS,
            };
            let vis = forced_vis
                .get(name.as_str())
                .copied()
                .or(s.hidden.then_some(STV_HIDDEN));
            if track {
                index.by_name.insert(name.clone(), syms.len());
            }
            syms.push(FinalSym {
                name: name.clone(),
                info: (if vis.is_some() { STB_LOCAL } else { STB_GLOBAL } << 4) | s.kind,
                other: vis.or(s.vis).unwrap_or(STV_DEFAULT),
                shndx,
                value: s.val.v,
                size: 0,
            });
        }
        // An undefined weak symbol reaches the table only where the
        // output still names it: bfd keeps the ones its relocations
        // reference and drops the rest, so a final link that emits no
        // relocations carries none of them.
        let mut weak_undefs: BTreeSet<&String> = BTreeSet::new();
        for r in &self.emitted {
            let sym = &self.objects[r.obj].symbols[r.sym as usize];
            if sym.shndx as u16 == SHN_UNDEF
                && sym.binding() == STB_WEAK
                && !sym.name.is_empty()
                && !self.globals.contains_key(&sym.name)
                && !self.script_now.contains_key(&sym.name)
            {
                weak_undefs.insert(&sym.name);
            }
        }
        for name in weak_undefs {
            if track {
                index.by_name.insert(name.clone(), syms.len());
            }
            syms.push(FinalSym {
                name: name.clone(),
                info: (STB_WEAK << 4) | STT_NOTYPE,
                other: 0,
                shndx: SHN_UNDEF,
                value: 0,
                size: 0,
            });
        }
        // bfd defines `_GLOBAL_OFFSET_TABLE_` on the section it built
        // the GOT in, as a sizeless local OBJECT, and emits no entry
        // where the link built no GOT. Measured against GNU ld 2.46.1:
        // on x86 the entry names `.got.plt` in every mode, on aarch64
        // it names `.got` for non-PIC output and is absolute for PIE
        // and shared objects.
        if let (Some(value), Some(out)) = (self.got_symbol_addr(), self.got_symbol_out()) {
            let abs = self.machine == EM_AARCH64 && self.opts.emit == LdsEmit::Dyn;
            if track {
                index.by_name.insert(GOT_SYMBOL.to_string(), syms.len());
            }
            syms.push(FinalSym {
                name: GOT_SYMBOL.to_string(),
                info: (STB_LOCAL << 4) | STT_OBJECT,
                other: STV_DEFAULT,
                shndx: if abs { SHN_ABS } else { out_shndx(out) },
                value,
                size: 0,
            });
        }
        syms
    }

    pub(super) fn finalize_sym(
        &self,
        obj_i: usize,
        sym_i: usize,
        out_shndx: &dyn Fn(usize) -> u16,
    ) -> Option<FinalSym> {
        let sym = &self.objects[obj_i].symbols[sym_i];
        match sym.shndx as u16 {
            SHN_ABS => Some(FinalSym {
                name: sym.name.clone(),
                info: sym.info,
                other: sym.other,
                shndx: SHN_ABS,
                value: sym.value,
                size: sym.size,
            }),
            SHN_UNDEF | SHN_COMMON => None,
            _ => {
                let sec = *self.objects[obj_i].shndx_map.get(&sym.shndx)?;
                let i = self.insec_index(obj_i, sec);
                match self.fates[i] {
                    SecFate::Placed { out } => {
                        let value = self.resolve_sym_prevpass(obj_i, sym_i, 0)?;
                        let shndx = if self.outs[out].removed {
                            SHN_ABS
                        } else {
                            out_shndx(out)
                        };
                        Some(FinalSym {
                            name: sym.name.clone(),
                            info: sym.info,
                            other: sym.other,
                            shndx,
                            value,
                            size: sym.size,
                        })
                    }
                    _ => None,
                }
            }
        }
    }

    /// `--emit-relocs` payloads: one `.rela.<outsec>` per output
    /// section that took relocations, entries in address order,
    /// `r_offset` the final address.
    pub(super) fn emitted_rela_sections(
        &self,
        final_of: &[u32],
        syms: &[FinalSym],
    ) -> Result<Vec<(usize, Vec<u8>)>, C5Error> {
        let index = &self.sym_index;
        let class = self.class;
        let aw = class.addr_size() as usize;
        let use_rela = machine_uses_rela(self.machine);
        let ent = if use_rela {
            class.rela_size()
        } else {
            class.rel_size()
        };
        if self.emitted.is_empty() {
            return Ok(Vec::new());
        }
        let mut by_out: BTreeMap<usize, Vec<&EmittedReloc>> = BTreeMap::new();
        for r in &self.emitted {
            by_out.entry(r.out).or_default().push(r);
        }
        let mut unresolved: Vec<String> = Vec::new();
        let mut out: Vec<(usize, Vec<u8>)> = Vec::new();
        for (oi, mut recs) in by_out {
            recs.sort_by_key(|r| r.addr);
            let mut body: Vec<u8> = Vec::with_capacity(recs.len() * ent as usize);
            for r in recs {
                let slot = self.emitted_sym_slot(r, index);
                let sym = match slot {
                    Some(pos) => final_of[pos],
                    None => {
                        if unresolved.len() < 10 {
                            let s = &self.objects[r.obj].symbols[r.sym as usize];
                            unresolved.push(format!(
                                "  {}: --emit-relocs: symbol `{}' referenced at {:#x} is not \
                                 in the output symbol table",
                                self.objects[r.obj].source, s.name, r.addr
                            ));
                        }
                        0
                    }
                };
                // `S + A` reconstructs from the entry, so the addend
                // is the resolved target less the named symbol's value.
                let base = slot.map_or(0, |pos| syms[pos].value);
                let addend = r.target.wrapping_sub(base) as i64;
                let info = class.reloc_info(sym, r.rtype);
                body.extend_from_slice(&class.addr_bytes(r.addr)[..aw]);
                body.extend_from_slice(&class.addr_bytes(info)[..aw]);
                // SHT_REL keeps the addend in the relocated field, which
                // already holds it after the relocation was applied.
                if use_rela {
                    body.extend_from_slice(&class.addr_bytes(addend as u64)[..aw]);
                }
            }
            out.push((oi, body));
        }
        if !unresolved.is_empty() {
            return Err(link_err(MODULE, &unresolved.join("\n")));
        }
        Ok(out)
    }

    /// The `build_symtab` slot an emitted relocation's symbol maps to:
    /// a global by name, a section reference through the output
    /// section's symbol, otherwise the surviving local.
    fn emitted_sym_slot(&self, r: &EmittedReloc, index: &SymIndex) -> Option<usize> {
        let sym = self.objects[r.obj].symbols.get(r.sym as usize)?;
        if sym.binding() != STB_LOCAL && !sym.name.is_empty() {
            return index.by_name.get(&sym.name).copied();
        }
        if sym.kind() == STT_SECTION {
            let sec = *self.objects[r.obj].shndx_map.get(&sym.shndx)?;
            let i = self.insec_index(r.obj, sec);
            let SecFate::Placed { out } = self.fates[i] else {
                return None;
            };
            return index.sec.get(&out).copied();
        }
        index.local.get(&(r.obj, r.sym)).copied()
    }
}
