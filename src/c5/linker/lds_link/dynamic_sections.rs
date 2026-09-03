//! Dynamic tables and dynamic relocation sizing for ET_DYN output.

use crate::c5::linker::dynamic::{self, DynSym, VerDef};
use crate::c5::linker::lds::glob_match;
use crate::c5::object::elf_reloc_types as rt;
use alloc::string::String;
use alloc::vec::Vec;
use hashbrown::{HashMap, HashSet};

use super::got::{PLT_ENTRY_SIZE, index_map};
use super::{
    Att, DynReloc, EM_386, EM_AARCH64, LdsEmit, LdsLinker, SHF_ALLOC, SHF_WRITE, SHN_ABS,
    SHN_UNDEF, SHT_REL, SHT_RELA, STB_GLOBAL, STB_LOCAL, STT_NOTYPE, STT_OBJECT, STV_DEFAULT,
    SYNTH_DYNAMIC, SYNTH_DYNSTR, SYNTH_DYNSYM, SYNTH_GNU_HASH, SYNTH_GOT, SYNTH_HASH, SYNTH_PLT,
    SYNTH_REL, SYNTH_RELA, SYNTH_RELR, SYNTH_VERDEF, SYNTH_VERSYM, ScriptSym, SecFate,
    machine_uses_rela,
};

/// Pack sorted 8-aligned addresses into SHT_RELR words: an even
/// entry relocates its own address and rebases the window at
/// `addr + 8`; each following odd entry's bits `1..=63` relocate
/// `base + (bit-1)*8` and advance the base by `63*8`.
pub(super) fn encode_relr(addrs: &[u64], word_size: u64) -> Vec<u64> {
    let span = (word_size * 8 - 1) * word_size;
    let mut out: Vec<u64> = Vec::new();
    let mut i = 0usize;
    while i < addrs.len() {
        out.push(addrs[i]);
        let mut base = addrs[i] + word_size;
        i += 1;
        loop {
            let mut word: u64 = 0;
            while i < addrs.len() {
                let d = addrs[i].wrapping_sub(base);
                if d >= span || !d.is_multiple_of(word_size) {
                    break;
                }
                word |= 1u64 << (d / word_size);
                i += 1;
            }
            if word == 0 {
                break;
            }
            out.push((word << 1) | 1);
            base += span;
        }
    }
    out
}

impl<'a> LdsLinker<'a> {
    /// Version definitions in index order. Index 1 names the object
    /// itself (the soname where one was given), so a user version's
    /// index starts at 2, as `.gnu.version` entries reference them.
    pub(super) fn script_verdefs(&self) -> Vec<VerDef> {
        let nodes = self.script.versions().unwrap_or(&[]);
        let named: Vec<&crate::c5::linker::lds::VersionNode> =
            nodes.iter().filter(|n| !n.name.is_empty()).collect();
        if named.is_empty() {
            return Vec::new();
        }
        let mut out = alloc::vec![VerDef {
            name: self
                .opts
                .soname
                .clone()
                .unwrap_or_else(|| self.opts.output_name.clone()),
            base: true,
        }];
        out.extend(named.iter().map(|n| VerDef {
            name: n.name.clone(),
            base: false,
        }));
        out
    }

    /// Name, section type and entry size of the dynamic relocation
    /// table this target uses. i386 relocations carry implicit
    /// addends, so the table is `.rel.dyn`/`SHT_REL`.
    pub(super) fn dyn_reloc_kind(&self) -> (&'static str, u32, u64) {
        if machine_uses_rela(self.machine) {
            (SYNTH_RELA, SHT_RELA, self.class.rela_size())
        } else {
            (SYNTH_REL, SHT_REL, self.class.rel_size())
        }
    }

    pub(super) fn dyn_reloc_name(&self) -> &'static str {
        self.dyn_reloc_kind().0
    }

    /// Relocation types the dynamic tables are built from: the
    /// address-width absolute form the input uses, and the load-time
    /// forms bfd rewrites it to.
    fn dyn_reloc_types(&self) -> (u32, u32, u32) {
        match self.machine {
            EM_AARCH64 => (
                rt::R_AARCH64_ABS64,
                rt::R_AARCH64_RELATIVE,
                rt::R_AARCH64_GLOB_DAT,
            ),
            EM_386 => (rt::R_386_32, rt::R_386_RELATIVE, rt::R_386_GLOB_DAT),
            _ => (
                rt::R_X86_64_64,
                rt::R_X86_64_RELATIVE,
                rt::R_X86_64_GLOB_DAT,
            ),
        }
    }

    /// Compute the ET_DYN dynamic-relocation payload (RELA + RELR) and
    /// GOT slots from the previous pass's layout, updating the
    /// synthetic input sections' sizes for this pass.
    pub(super) fn size_dynamic_sections(&mut self) {
        if self.opts.emit != LdsEmit::Dyn {
            return;
        }
        self.dyn_relas.clear();
        self.relr_addrs.clear();
        // GOT slot set stays stable across passes (driven by reloc
        // types alone), so compute it once.
        if self.got_slots.is_empty() && self.got_map.is_empty() {
            // Every import loads through a slot the loader fills, so
            // each takes one whether or not an input names the GOT.
            let mut slots: Vec<String> = self.imports.clone();
            let mut map: HashMap<String, usize> = index_map(&slots);
            for i in 0..self.insecs.len() {
                let SecFate::Placed { .. } = self.fates[i] else {
                    continue;
                };
                let id = self.insecs[i];
                for r in &self.objects[id.obj].sections[id.sec].relocs {
                    if matches!(
                        r.rtype,
                        rt::R_AARCH64_ADR_GOT_PAGE | rt::R_AARCH64_LD64_GOT_LO12_NC
                    ) {
                        let name = self.objects[id.obj].symbols[r.sym as usize].name.clone();
                        if name.is_empty() {
                            continue;
                        }
                        map.entry(name.clone()).or_insert_with(|| {
                            slots.push(name);
                            slots.len() - 1
                        });
                    }
                }
            }
            self.got_slots = slots;
            self.got_map = map;
        }
        // Collect absolute-64 sites in allocated output sections; each
        // becomes a RELATIVE entry. bfd packs a site into RELR when
        // its input offset is even and the input section's alignment
        // is above one (the output address parity then follows);
        // other sites keep RELA entries.
        let mut rel_addrs: Vec<(u64, i64, bool)> = Vec::new();
        let mut sym_relas: Vec<DynReloc> = Vec::new();
        let (abs_addr, relative, glob_dat) = self.dyn_reloc_types();
        for i in 0..self.insecs.len() {
            let SecFate::Placed { out } = self.fates[i] else {
                continue;
            };
            if !self.outs[out].alloc || self.outs[out].removed {
                continue;
            }
            let p = self.placements[i];
            if !p.placed {
                continue;
            }
            let id = self.insecs[i];
            let base = self.outs[out].addr + p.off;
            let packable = self.objects[id.obj].sections[id.sec].addralign > 1;
            for r in &self.objects[id.obj].sections[id.sec].relocs {
                if r.rtype != abs_addr {
                    continue;
                }
                // Only a load-address (section-relative) target needs a
                // load-time RELATIVE fixup; an absolute constant does
                // not. An unresolved default-visibility weak reference
                // keeps a symbol-based entry, as bfd leaves its
                // resolution to load time.
                if !self.reloc_is_relative(id.obj, r.sym as usize) {
                    if self.undefweak_dynamic(id.obj, r.sym as usize) {
                        let name = &self.objects[id.obj].symbols[r.sym as usize].name;
                        sym_relas.push(DynReloc {
                            offset: base + r.offset,
                            rtype: abs_addr,
                            addend: r.addend,
                            sym: self.dynsym_index(name),
                        });
                    }
                    continue;
                }
                let target = self.resolve_sym_prevpass(id.obj, r.sym as usize, r.addend);
                let Some(target) = target else { continue };
                rel_addrs.push((
                    base + r.offset,
                    target as i64,
                    packable && r.offset % 2 == 0,
                ));
            }
        }
        // GOT slots are RELATIVE targets too; a slot for an unresolved
        // weak reference gets GLOB_DAT instead.
        let slot_size = self.class.addr_size();
        if let Some(got_base) = self.got_slot_base() {
            for (k, name) in self.got_slots.clone().iter().enumerate() {
                let slot = got_base + k as u64 * slot_size;
                if let Some(v) = self.resolve_name(name) {
                    rel_addrs.push((slot, v as i64, true));
                } else {
                    sym_relas.push(DynReloc {
                        offset: slot,
                        rtype: glob_dat,
                        addend: 0,
                        sym: self.dynsym_index(name),
                    });
                }
            }
        }
        rel_addrs.sort_by_key(|&(a, _, _)| a);
        let mut relas: Vec<DynReloc> = Vec::new();
        let mut relr: Vec<u64> = Vec::new();
        for (addr, addend, packable) in rel_addrs {
            if self.opts.pack_relative_relocs && packable {
                relr.push(addr);
            } else {
                relas.push(DynReloc {
                    offset: addr,
                    rtype: relative,
                    addend,
                    sym: 0,
                });
            }
        }
        relas.extend(sym_relas);
        relas.sort_by_key(|d| d.offset);
        let relr_words = encode_relr(&relr, self.class.addr_size());
        self.dyn_relas = relas;
        self.relr_addrs = relr;
        // Update synthetic section sizes.
        let nones = match self.dyn_nones {
            Some(n) => n,
            None => {
                let n = self.count_reserved_none_slots();
                self.dyn_nones = Some(n);
                n
            }
        };
        self.build_dyn_tables(&|_| 1);
        let dyn_sizes = self.dyn_table_sizes();
        // bfd reserves `_GLOBAL_OFFSET_TABLE_[0]` once the link either
        // needs a GOT slot or creates a `.dynamic` for the header to
        // point at; a link with neither leaves `.got` empty, which
        // scripts assert on. Where the header sits on `.got.plt`,
        // `.got` reserves nothing.
        let got_header = self.got_reserved() != 0
            && (!self.got_slots.is_empty() || self.kept_synth(SYNTH_DYNAMIC).is_some());
        let (rela_name, _, rela_ent) = self.dyn_reloc_kind();
        let slot = self.class.addr_size();
        let synth = self.synth_obj;
        for sec in &mut self.objects[synth].sections {
            if let Some(&size) = dyn_sizes.get(sec.name.as_str()) {
                sec.size = size;
                continue;
            }
            if sec.name == rela_name {
                sec.size = (nones + self.dyn_relas.len() as u64) * rela_ent;
                continue;
            }
            match sec.name.as_str() {
                SYNTH_RELR => sec.size = relr_words.len() as u64 * slot,
                SYNTH_GOT => {
                    let header = if got_header { slot } else { 0 };
                    sec.size = header + self.got_slots.len() as u64 * slot;
                }
                SYNTH_PLT => sec.size = self.plt_syms.len() as u64 * PLT_ENTRY_SIZE,
                _ => {}
            }
        }
    }

    /// Final address of a kept synthetic section.
    pub(super) fn synth_addr(&self, name: &str) -> Option<u64> {
        let out = self.kept_synth(name)?;
        let sec = self.objects[self.synth_obj]
            .sections
            .iter()
            .position(|s| s.name == name)?;
        let i = self.insec_index(self.synth_obj, sec);
        Some(self.outs[out].addr + self.placements[i].off)
    }

    pub(super) fn dyn_section_addr(&self) -> Option<u64> {
        self.synth_addr(SYNTH_DYNAMIC)
    }

    /// Index of the synthetic section `name`, when the script kept it.
    /// A script that routes it to `/DISCARD/` gets no table built.
    pub(super) fn kept_synth(&self, name: &str) -> Option<usize> {
        let synth = self.synth_obj;
        let sec = self.objects[synth]
            .sections
            .iter()
            .position(|s| s.name == name)?;
        let i = self.insec_index(synth, sec);
        match self.fates[i] {
            SecFate::Placed { out } if self.outs[out].name != "/DISCARD/" => Some(out),
            _ => None,
        }
    }

    /// The version index the script assigns `name`, or `None` when the
    /// script makes it local. Exact patterns are consulted before
    /// wildcards, as bfd matches them.
    fn version_of(&self, name: &str) -> Option<u16> {
        let nodes = self.script.versions().unwrap_or(&[]);
        if nodes.is_empty() {
            return Some(dynamic::VER_NDX_GLOBAL);
        }
        let mut ndx: u16 = 1;
        let mut wildcard: Option<Option<u16>> = None;
        for n in nodes {
            if !n.name.is_empty() {
                ndx += 1;
            }
            let here = (!n.name.is_empty()).then_some(ndx);
            for (pats, keep) in [(&n.globals, true), (&n.locals, false)] {
                for p in pats {
                    if p == name {
                        return keep.then_some(here.unwrap_or(dynamic::VER_NDX_GLOBAL));
                    }
                    if !crate::c5::linker::lds::is_literal_pattern(p)
                        && wildcard.is_none()
                        && glob_match(p, name)
                    {
                        wildcard = Some(keep.then_some(here.unwrap_or(dynamic::VER_NDX_GLOBAL)));
                    }
                }
            }
        }
        wildcard.unwrap_or(Some(dynamic::VER_NDX_GLOBAL))
    }

    /// Defined symbols a loader may resolve against, as bfd selects
    /// them: global or weak, not hidden, and kept by the version
    /// script. Each version definition also contributes a symbol
    /// naming itself.
    fn collect_dyn_exports(&self, out_shndx: &dyn Fn(usize) -> u16) -> Vec<DynSym> {
        // Imports come first and in their own order: a dynamic
        // relocation names one by the index that ordering fixes.
        let mut out: Vec<DynSym> = self
            .imports
            .iter()
            .map(|name| DynSym {
                name: name.clone(),
                info: (STB_GLOBAL << 4) | STT_NOTYPE,
                other: STV_DEFAULT,
                shndx: SHN_UNDEF,
                value: 0,
                size: 0,
                version: dynamic::VER_NDX_GLOBAL,
            })
            .collect();
        let mut names: Vec<&String> = self.globals.keys().collect();
        names.sort();
        for name in names {
            if self.script_now.contains_key(name) {
                continue;
            }
            let (obj_i, sym_i) = self.globals[name];
            if self.objects[obj_i].symbols[sym_i].other & 0x3 != STV_DEFAULT {
                continue;
            }
            let Some(v) = self.version_of(name) else {
                continue;
            };
            if let Some(fs) = self.finalize_sym(obj_i, sym_i, out_shndx) {
                out.push(DynSym {
                    name: fs.name,
                    info: fs.info,
                    other: fs.other,
                    shndx: fs.shndx,
                    value: fs.value,
                    size: fs.size,
                    version: v,
                });
            }
        }
        let mut script_syms: Vec<(&String, &ScriptSym)> = self.script_now.iter().collect();
        script_syms.sort_by(|a, b| a.0.cmp(b.0));
        for (name, s) in script_syms {
            if s.hidden {
                continue;
            }
            let Some(v) = self.version_of(name) else {
                continue;
            };
            let shndx = match (s.val.att, s.final_out) {
                (Att::Out(oi), _) => out_shndx(oi),
                (_, Some(oi)) => out_shndx(oi),
                (_, None) => SHN_ABS,
            };
            out.push(DynSym {
                name: name.clone(),
                info: (STB_GLOBAL << 4) | s.kind,
                other: STV_DEFAULT,
                shndx,
                value: s.val.v,
                size: 0,
                version: v,
            });
        }
        // The base node names the image, not a symbol.
        for (k, v) in self.verdefs.iter().enumerate().skip(1) {
            out.push(DynSym {
                name: v.name.clone(),
                info: (STB_GLOBAL << 4) | STT_OBJECT,
                other: STV_DEFAULT,
                shndx: SHN_ABS,
                value: 0,
                size: 0,
                version: (k + 1) as u16,
            });
        }
        out
    }

    pub(super) fn build_dyn_tables(&mut self, out_shndx: &dyn Fn(usize) -> u16) {
        self.dyn_tables = None;
        if self.opts.emit != LdsEmit::Dyn || self.kept_synth(SYNTH_DYNSYM).is_none() {
            return;
        }
        let exports = self.collect_dyn_exports(out_shndx);
        let verdefs = if self.kept_synth(SYNTH_VERDEF).is_some() {
            self.verdefs.clone()
        } else {
            Vec::new()
        };
        let rpath = self.rpath_string();
        let mut extra: Vec<&str> = self.needed_sonames().collect();
        if let Some(p) = &rpath {
            extra.push(p);
        }
        self.dyn_tables = Some(dynamic::build_tables(
            &exports,
            self.opts.soname.as_deref(),
            &verdefs,
            &extra,
            self.opts.hash_style,
            self.class,
        ));
    }

    /// Sonames this image depends on, in link order and once each. A
    /// library the link took nothing from is recorded anyway, as bfd
    /// does without `--as-needed`; one named only under `AS_NEEDED` is
    /// recorded only where an import bound to it.
    fn needed_sonames(&self) -> impl Iterator<Item = &str> {
        let mut seen: HashSet<&str> = HashSet::new();
        self.opts
            .shared_libs
            .iter()
            .filter(|l| !l.as_needed || self.imports.iter().any(|n| l.lib.exports.contains(n)))
            .map(|l| l.lib.soname.as_str())
            .filter(move |s| seen.insert(s))
    }

    /// `-rpath` directories as the colon-separated string the tag holds.
    fn rpath_string(&self) -> Option<String> {
        (!self.opts.rpath.is_empty()).then(|| self.opts.rpath.join(":"))
    }

    /// Sizes of the dynamic tables for this pass, by section name.
    /// `.dynamic` is sized from the tag list the writer will emit.
    fn dyn_table_sizes(&self) -> HashMap<&'static str, u64> {
        let mut m: HashMap<&'static str, u64> = HashMap::new();
        let Some(t) = &self.dyn_tables else {
            return m;
        };
        m.insert(SYNTH_DYNSYM, t.dynsym.len() as u64);
        m.insert(SYNTH_DYNSTR, t.dynstr().len() as u64);
        m.insert(SYNTH_HASH, t.hash.len() as u64);
        m.insert(SYNTH_GNU_HASH, t.gnu_hash.len() as u64);
        m.insert(SYNTH_VERSYM, t.versym.len() as u64);
        m.insert(SYNTH_VERDEF, t.verdef.len() as u64);
        m.insert(
            SYNTH_DYNAMIC,
            dynamic::build_dynamic(&self.dyn_addrs(), self.class).len() as u64,
        );
        m
    }

    /// Addresses and sizes the `.dynamic` tags name. Values come from
    /// the previous pass's layout and settle with it.
    pub(super) fn dyn_addrs(&self) -> dynamic::DynAddrs {
        let addr = |name: &str| self.synth_addr(name);
        // A relocation table the link did not fill gets no tags, as
        // bfd leaves them off an empty section.
        let sized = |name: &str| -> Option<(u64, u64)> {
            let sec = self.objects[self.synth_obj]
                .sections
                .iter()
                .position(|s| s.name == name)?;
            let size = self.objects[self.synth_obj].sections[sec].size;
            (size > 0).then(|| addr(name).map(|a| (a, size))).flatten()
        };
        let t = self.dyn_tables.as_ref();
        dynamic::DynAddrs {
            hash: addr(SYNTH_HASH),
            gnu_hash: addr(SYNTH_GNU_HASH),
            strtab: addr(SYNTH_DYNSTR),
            strsz: t.map(|t| t.dynstr().len() as u64).unwrap_or(0),
            symtab: addr(SYNTH_DYNSYM),
            rela: sized(self.dyn_reloc_name()),
            use_rela: machine_uses_rela(self.machine),
            relr: sized(SYNTH_RELR),
            verdef: addr(SYNTH_VERDEF).map(|a| (a, t.map(|t| t.verdef_count).unwrap_or(0))),
            versym: addr(SYNTH_VERSYM),
            soname: match (t, self.opts.soname.as_deref()) {
                (Some(t), Some(s)) => Some(t.str_offset(s)),
                _ => None,
            },
            needed: t
                .map(|t| self.needed_sonames().map(|s| t.str_offset(s)).collect())
                .unwrap_or_default(),
            rpath: match (t, self.rpath_string()) {
                (Some(t), Some(p)) => Some((t.str_offset(&p), self.opts.new_dtags)),
                _ => None,
            },
            symbolic: self.opts.symbolic,
            textrel: self.has_readonly_dynamic_reloc(),
            preinit_array: self.out_extent(".preinit_array"),
            init_array: self.out_extent(".init_array"),
            fini_array: self.out_extent(".fini_array"),
        }
    }

    /// `(address, size)` of a kept output section.
    fn out_extent(&self, name: &str) -> Option<(u64, u64)> {
        self.outs
            .iter()
            .find(|o| o.name == name && o.alloc && !o.removed)
            .map(|o| (o.addr, o.size))
    }

    /// True when a dynamic relocation applies to a section the loader
    /// maps read-only. `DT_TEXTREL` is what tells it to make the
    /// segment writable first; without the tag the write faults.
    fn has_readonly_dynamic_reloc(&self) -> bool {
        let sites = self
            .dyn_relas
            .iter()
            .map(|d| d.offset)
            .chain(self.relr_addrs.iter().copied());
        let ro: Vec<(u64, u64)> = self
            .outs
            .iter()
            .filter(|o| o.alloc && !o.removed && o.flags & SHF_WRITE == 0)
            .map(|o| (o.addr, o.addr + o.size))
            .collect();
        sites
            .into_iter()
            .any(|a| ro.iter().any(|&(lo, hi)| a >= lo && a < hi))
    }

    /// bfd sizes dynamic reloc sections at check_relocs time: every
    /// 64-bit absolute reloc against a non-local symbol in an
    /// allocated section reserves a slot, with no discard check on the
    /// global-symbol path. A slot whose section the script discards is
    /// never written (the section is not relocated) and never
    /// reclaimed by RELR packing, so it survives as a zeroed
    /// R_*_NONE entry. Reserve the same slots for size parity.
    fn count_reserved_none_slots(&self) -> u64 {
        let abs_addr = self.dyn_reloc_types().0;
        let mut n = 0u64;
        for i in 0..self.insecs.len() {
            if self.fates[i] != SecFate::Discarded {
                continue;
            }
            let id = self.insecs[i];
            // A group the dedup dropped is gone before bfd reaches
            // check_relocs, so it reserves nothing.
            if self.comdat_dropped.contains(&(id.obj, id.sec)) {
                continue;
            }
            let s = &self.objects[id.obj].sections[id.sec];
            if s.flags & SHF_ALLOC == 0 {
                continue;
            }
            for r in &s.relocs {
                if r.rtype != abs_addr {
                    continue;
                }
                let sym = &self.objects[id.obj].symbols[r.sym as usize];
                if sym.binding() != STB_LOCAL {
                    n += 1;
                }
            }
        }
        n
    }
}
