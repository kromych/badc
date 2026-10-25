//! Imports, PLT and GOT slots, and symbol values taken from the
//! previous pass.

use crate::c5::linker::object::{absolute_in_pie_body, elf_reloc_desc, locate_reloc};
use crate::c5::object::elf_reloc_types as rt;
use alloc::collections::BTreeSet;
use alloc::string::String;
use alloc::vec::Vec;
use hashbrown::{HashMap, HashSet};

use super::inputs::RawReloc;
use super::preempt::Reach;
use super::{
    Att, EM_386, EM_AARCH64, EM_X86_64, LdsEmit, LdsLinker, Piece, SHN_ABS, SHN_COMMON, SHN_UNDEF,
    STB_LOCAL, STB_WEAK, STT_SECTION, STV_DEFAULT, SYNTH_GOT, SYNTH_GOTPLT, SYNTH_PLT, SecFate,
    Stmt,
};

/// A relocation writing a whole load address into a field narrower
/// than an address. `size_dynamic_sections` rewrites the address-width
/// form to `R_*_RELATIVE`; no dynamic form writes a narrower field.
/// The `*_ABS_LO12_NC` group is excluded: it takes only the target's
/// page offset, which a page-aligned load base leaves alone.
fn narrow_absolute(machine: u16, rtype: u32) -> bool {
    match machine {
        EM_386 => matches!(rtype, rt::R_386_16 | rt::R_386_8),
        EM_AARCH64 => {
            matches!(rtype, rt::R_AARCH64_ABS32 | rt::R_AARCH64_ABS16)
                || rt::aarch64_movw_field(rtype).is_some()
        }
        _ => matches!(
            rtype,
            rt::R_X86_64_32 | rt::R_X86_64_32S | rt::R_X86_64_16 | rt::R_X86_64_8
        ),
    }
}

/// One PLT stub, on both targets.
pub(super) const PLT_ENTRY_SIZE: u64 = 16;

/// The symbol a GOT slot holds the address of: a global by name, a named
/// local by its object and symbol index, as two objects' locals may share
/// a name.
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub(super) enum GotKey {
    Global(String),
    Local(usize, u32),
}

/// Name -> position, for a list whose order is its index space.
pub(super) fn index_map(names: &[String]) -> HashMap<String, usize> {
    names
        .iter()
        .enumerate()
        .map(|(i, n)| (n.clone(), i))
        .collect()
}

/// A relocation holding a branch displacement: reaching an imported
/// symbol from one means going through a stub.
fn reloc_needs_plt(machine: u16, rtype: u32) -> bool {
    match machine {
        EM_AARCH64 => matches!(rtype, rt::R_AARCH64_CALL26 | rt::R_AARCH64_JUMP26),
        EM_386 => matches!(rtype, rt::R_386_PC32 | rt::R_386_PLT32),
        _ => matches!(rtype, rt::R_X86_64_PC32 | rt::R_X86_64_PLT32),
    }
}

/// A relocation naming a GOT slot rather than the symbol's own address.
fn reloc_uses_got(machine: u16, rtype: u32) -> bool {
    match machine {
        EM_AARCH64 => matches!(
            rtype,
            rt::R_AARCH64_ADR_GOT_PAGE | rt::R_AARCH64_LD64_GOT_LO12_NC
        ),
        EM_386 => matches!(rtype, rt::R_386_GOT32 | rt::R_386_GOT32X),
        _ => matches!(
            rtype,
            rt::R_X86_64_GOTPCREL | rt::R_X86_64_GOTPCRELX | rt::R_X86_64_REX_GOTPCRELX
        ),
    }
}

/// A stub at `at` jumping through the GOT slot at `slot`. An i386 stub
/// in a position-independent image reaches the slot from the GOT base
/// `%ebx` holds at the call, `got_base` (Intel386 psABI, procedure
/// linkage table), as bfd's `ff a3` entries do; elsewhere it names the
/// slot's address.
fn plt_entry(
    machine: u16,
    at: u64,
    slot: u64,
    got_base: Option<u64>,
) -> [u8; PLT_ENTRY_SIZE as usize] {
    let mut e = [0u8; PLT_ENTRY_SIZE as usize];
    if machine == EM_AARCH64 {
        let page = (slot & !0xfff).wrapping_sub(at & !0xfff) as i64 >> 12;
        let imm = page as u32 & 0x1f_ffff;
        let adrp = 0x9000_0010 | (imm & 3) << 29 | (imm >> 2) << 5;
        let ldr = 0xf940_0211 | ((slot & 0xfff) as u32 / 8) << 10;
        for (k, w) in [adrp, ldr, 0xd61f_0220, 0xd503_201f].iter().enumerate() {
            e[k * 4..k * 4 + 4].copy_from_slice(&w.to_le_bytes());
        }
        return e;
    }
    // jmp *disp32(%rip), *disp32(%ebx) or *addr32, then a pad to the
    // entry size.
    let (modrm, field) = match (machine, got_base) {
        (EM_386, Some(base)) => (0xa3, slot.wrapping_sub(base)),
        (EM_386, None) => (0x25, slot),
        _ => (0x25, slot.wrapping_sub(at + 6)),
    };
    e[0] = 0xff;
    e[1] = modrm;
    e[2..6].copy_from_slice(&(field as u32).to_le_bytes());
    e[6..].fill(0xcc);
    e
}

impl<'a> LdsLinker<'a> {
    /// Bind the references no input defines against the shared
    /// libraries named on the command line. Each binding takes a
    /// `.dynsym` entry and a GOT slot; one a call reaches also takes a
    /// PLT stub, since a call site holds a displacement rather than a
    /// slot to load through. A call to a preemptible definition takes
    /// one as well.
    pub(super) fn build_imports(&mut self) {
        self.prune_preemptible();
        if !self.opts.shared_libs.is_empty() || self.opts.shared {
            self.bind_shared_libraries();
        }
        let reached = self.reached_by(Reach::Plt);
        let called: BTreeSet<String> = (core::mem::take(&mut self.plt_syms).into_iter())
            .chain(reached)
            .collect();
        self.plt_syms = called.into_iter().collect();
        self.plt_of = index_map(&self.plt_syms);
    }

    /// The imports, and the ones a call reaches. A shared object also
    /// imports a default-visibility weak reference nothing defines, as bfd
    /// does: the loader writes 0 or another component's definition.
    fn bind_shared_libraries(&mut self) {
        // The script's own definitions satisfy a reference on their
        // own, whether or not a library exports the same name.
        let assigned = self
            .stmts
            .iter()
            .filter_map(|st| match st {
                Stmt::Assign(a) => Some(a),
                _ => None,
            })
            .chain(self.outs.iter().flat_map(|o| {
                o.pieces.iter().filter_map(|p| match p {
                    Piece::Assign(a) => Some(a),
                    _ => None,
                })
            }));
        let script_defined: HashSet<&str> = assigned
            .map(|a| a.symbol.as_str())
            .filter(|s| *s != ".")
            .collect();
        let mut names: BTreeSet<&str> = BTreeSet::new();
        let mut strong: BTreeSet<&str> = BTreeSet::new();
        for (oi, o) in self.objects.iter().enumerate() {
            for (si, s) in o.symbols.iter().enumerate() {
                if s.binding() != STB_LOCAL
                    && s.shndx as u16 == SHN_UNDEF
                    && !s.name.is_empty()
                    && !self.globals.contains_key(&s.name)
                    && !script_defined.contains(s.name.as_str())
                    && (self.opts.shared_libs.iter()).any(|l| l.lib.exports.contains(&s.name))
                    || self.opts.shared && self.undefweak_dynamic(oi, si)
                {
                    names.insert(&s.name);
                    if s.binding() != STB_WEAK {
                        strong.insert(&s.name);
                    }
                }
            }
        }
        self.weak_imports = (names.iter())
            .filter(|n| !strong.contains(*n))
            .map(|n| String::from(*n))
            .collect();
        let mut called: BTreeSet<&str> = BTreeSet::new();
        for o in &self.objects {
            for sec in &o.sections {
                for r in &sec.relocs {
                    let Some(sym) = o.symbols.get(r.sym as usize) else {
                        continue;
                    };
                    if reloc_needs_plt(self.machine, r.rtype)
                        && names.contains(sym.name.as_str())
                        && !self.is_data_export(&sym.name)
                    {
                        called.insert(&sym.name);
                    }
                }
            }
        }
        self.imports = names.iter().map(|s| String::from(*s)).collect();
        self.plt_syms = called.iter().map(|s| String::from(*s)).collect();
        self.import_of = index_map(&self.imports);
    }

    /// `.dynsym` index of `name`. Imports sit right after the null
    /// entry, in their own order; a definition's index is the table's.
    pub(super) fn dynsym_index(&self, name: &str) -> u32 {
        if let Some(&k) = self.import_of.get(name) {
            return 1 + k as u32;
        }
        (self.dyn_tables.as_ref())
            .and_then(|t| t.index_of(name))
            .unwrap_or(0)
    }

    /// True when a shared library exports `name` as a data object, so a
    /// reference must reach the object itself rather than a PLT stub.
    fn is_data_export(&self, name: &str) -> bool {
        self.opts
            .shared_libs
            .iter()
            .any(|l| l.lib.data_exports.contains(name))
    }

    /// Address a reference to an imported symbol resolves to: its PLT
    /// stub for a call, its GOT slot for a load through one.
    pub(super) fn import_target(&self, name: &str, rtype: u32) -> Option<u64> {
        if !self.import_of.contains_key(name) {
            return None;
        }
        if reloc_needs_plt(self.machine, rtype) {
            return self.stub_or_slot(name, Reach::Plt);
        }
        if reloc_uses_got(self.machine, rtype) {
            return self.stub_or_slot(name, Reach::Got);
        }
        None
    }

    /// PLT stub bytes: each jumps through its symbol's GOT slot, which
    /// the loader fills from the `GLOB_DAT` entry naming the symbol.
    /// Lazy binding would need a `.rela.plt` the loader walks on
    /// demand; these bind at load time.
    pub(super) fn plt_bytes(&self) -> Vec<u8> {
        let (Some(plt), Some(got)) = (self.synth_addr(SYNTH_PLT), self.got_slot_base()) else {
            return Vec::new();
        };
        let slot_size = self.class.addr_size();
        let got_base = (self.opts.emit == LdsEmit::Dyn)
            .then(|| self.got_symbol_addr())
            .flatten();
        let mut out = Vec::with_capacity(self.plt_syms.len() * PLT_ENTRY_SIZE as usize);
        for (k, name) in self.plt_syms.iter().enumerate() {
            let at = plt + k as u64 * PLT_ENTRY_SIZE;
            let key = GotKey::Global(name.clone());
            let slot = got + *self.got_map.get(&key).unwrap_or(&0) as u64 * slot_size;
            out.extend_from_slice(&plt_entry(self.machine, at, slot, got_base));
        }
        out
    }

    /// Resolve a symbol name to a final value through the global table
    /// or a script assignment. Used for GOT slot fills.
    pub(super) fn resolve_name(&self, name: &str) -> Option<u64> {
        if let Some(&(oi, si)) = self.globals.get(name) {
            return self.resolve_sym_prevpass(oi, si, 0);
        }
        self.script_now
            .get(name)
            .or_else(|| self.script_prev.get(name))
            .map(|s| s.val.v)
    }

    /// An undefined default-visibility weak reference that nothing in
    /// the link satisfies. bfd exports it as a dynamic symbol and
    /// keeps a symbol-based reloc for its sites and GOT slot.
    pub(super) fn undefweak_dynamic(&self, oi: usize, si: usize) -> bool {
        let sym = &self.objects[oi].symbols[si];
        sym.shndx as u16 == SHN_UNDEF
            && sym.binding() == STB_WEAK
            && !sym.name.is_empty()
            && self.visibility_of(&sym.name) == STV_DEFAULT
            && !self.globals.contains_key(&sym.name)
            // During sizing the current pass's script table is swapped
            // out; the previous pass's values match at convergence.
            && !self.script_now.contains_key(&sym.name)
            && !self.script_prev.contains_key(&sym.name)
    }

    /// True when an ABS64 site against this symbol names a load
    /// address (a section-relative definition or an Out-attributed
    /// script symbol), so an ET_DYN image needs a RELATIVE fixup for
    /// it. An absolute constant or an undefined symbol does not.
    pub(super) fn reloc_is_relative(&self, oi: usize, si: usize) -> bool {
        let sym = &self.objects[oi].symbols[si];
        match sym.shndx as u16 {
            SHN_ABS | SHN_UNDEF | SHN_COMMON => {
                if sym.binding() != STB_LOCAL {
                    // A global SHN_ABS definition is its own entry in
                    // the global table; following it would not
                    // terminate. Only a reference resolves elsewhere.
                    if let Some(&(doi, dsi)) = self.globals.get(&sym.name)
                        && (doi, dsi) != (oi, si)
                    {
                        return self.reloc_is_relative(doi, dsi);
                    }
                    if let Some(s) = self
                        .script_now
                        .get(&sym.name)
                        .or_else(|| self.script_prev.get(&sym.name))
                    {
                        // A symbol assigned from the top-level location
                        // counter is rebased into its section before
                        // emission (ld's ldexp_finalize_syms), so it is
                        // a load address like an in-section one.
                        return matches!(s.val.att, Att::Out(_)) || s.final_out.is_some();
                    }
                }
                false
            }
            _ => true,
        }
    }

    /// Refusal for a site an `ET_DYN` image has no way to carry, or
    /// `None` when it is representable. Writing a link-time address
    /// into a field no dynamic relocation covers bakes an address the
    /// loader then slides out from under. A non-allocated section,
    /// which the loader never maps, and a value that is not a load
    /// address both keep the link-time value.
    pub(super) fn unrepresentable_in_dyn(
        &self,
        oi: usize,
        si: usize,
        r: &RawReloc,
        alloc: bool,
    ) -> Option<String> {
        if self.opts.emit != LdsEmit::Dyn
            || !alloc
            || !narrow_absolute(self.machine, r.rtype)
            || !self.reloc_is_relative(oi, r.sym as usize)
        {
            return None;
        }
        let obj = &self.objects[oi];
        let sym = &obj.symbols[r.sym as usize];
        let target = if !sym.name.is_empty() {
            sym.name.as_str()
        } else {
            // A section symbol: ld names the section it points at.
            obj.shndx_map
                .get(&sym.shndx)
                .map_or("<section>", |&t| obj.sections[t].name.as_str())
        };
        Some(absolute_in_pie_body(
            &locate_reloc(&obj.source, &obj.sections[si].name, r.offset),
            &elf_reloc_desc(self.machine, r.rtype),
            target,
            self.opts.shared,
        ))
    }

    pub(super) fn resolve_sym_prevpass(&self, oi: usize, si: usize, addend: i64) -> Option<u64> {
        let sym = &self.objects[oi].symbols[si];
        match sym.shndx as u16 {
            SHN_ABS => Some(sym.value.wrapping_add(addend as u64)),
            SHN_UNDEF => {
                if let Some(&(doi, dsi)) = self.globals.get(&sym.name) {
                    return self.resolve_sym_prevpass(doi, dsi, addend);
                }
                // A reference the objects leave undefined can bind to
                // a script-defined symbol; without this the dynamic
                // fixup collection drops the slot entirely. During
                // sizing the current pass's table is already swapped
                // out, so fall back to the previous pass's values,
                // which match at convergence.
                self.script_now
                    .get(&sym.name)
                    .or_else(|| self.script_prev.get(&sym.name))
                    .map(|s| s.val.v.wrapping_add(addend as u64))
            }
            _ => {
                // Prev-pass placement offsets survive the reset; at
                // convergence they equal the current pass's.
                let sec = *self.objects[oi].shndx_map.get(&sym.shndx)?;
                let i = self.insec_index(oi, sec);
                let p = self.placements[i];
                match self.fates[i] {
                    SecFate::Placed { out } => {
                        // In a merge pool a section symbol's addend picks
                        // the entry, so the combined offset is remapped; a
                        // named symbol anchors at its own entry and the
                        // addend applies to the remapped address (matches
                        // bfd -- an addend past the entry, e.g. one past a
                        // string's NUL, must stay relative to that entry).
                        let off = if sym.kind() == STT_SECTION {
                            self.placed_off(i, sym.value.wrapping_add(addend as u64))?
                        } else {
                            self.placed_off(i, sym.value)?.wrapping_add(addend as u64)
                        };
                        let base = if let Some(&pl) = self.merge_of.get(&i) {
                            self.placements[self.pools[pl].rep].off
                        } else {
                            p.off
                        };
                        Some(self.outs[out].addr.wrapping_add(base).wrapping_add(off))
                    }
                    _ => None,
                }
            }
        }
    }

    fn got_addr_prevpass(&self) -> Option<u64> {
        let synth = self.synth_obj;
        let sec = self.objects[synth]
            .sections
            .iter()
            .position(|s| s.name == SYNTH_GOT)?;
        let i = self.insec_index(synth, sec);
        match self.fates[i] {
            SecFate::Placed { out } => Some(self.outs[out].addr + self.placements[i].off),
            _ => None,
        }
    }

    /// Whether the backend's GOT section is `.got.plt`. bfd defines
    /// `_GLOBAL_OFFSET_TABLE_` on the section it creates for the GOT
    /// and reserves that section's first slot for the `.dynamic`
    /// address; the x86 targets set `elf_backend_want_got_plt`, so for
    /// them both live on `.got.plt`.
    pub(super) fn got_on_got_plt(&self) -> bool {
        matches!(self.machine, EM_386 | EM_X86_64)
    }

    /// Slots `.got` reserves ahead of its first entry.
    pub(super) fn got_reserved(&self) -> u64 {
        u64::from(!self.got_on_got_plt())
    }

    /// The address `_GLOBAL_OFFSET_TABLE_` takes and every GOT-base
    /// relative relocation is computed against.
    pub(super) fn got_symbol_addr(&self) -> Option<u64> {
        if self.got_on_got_plt()
            && let Some(addr) = self.synth_addr(SYNTH_GOTPLT)
        {
            return Some(addr);
        }
        self.got_addr_prevpass()
    }

    /// Output section the GOT base sits in, where the script kept it.
    pub(super) fn got_symbol_out(&self) -> Option<usize> {
        if self.got_on_got_plt()
            && let Some(out) = self.kept_synth(SYNTH_GOTPLT)
        {
            return Some(out);
        }
        self.kept_synth(SYNTH_GOT)
    }

    /// Whether the image keeps the section `_GLOBAL_OFFSET_TABLE_` names:
    /// an x86 `.got.plt` sized empty goes, and the symbol with it.
    pub(super) fn got_symbol_kept(&self) -> bool {
        let synth = &self.objects[self.synth_obj];
        !self.got_on_got_plt()
            || (synth.sections.iter()).any(|s| s.name == SYNTH_GOTPLT && s.size != 0)
    }

    /// The address of the first GOT entry, past the reserved header.
    pub(super) fn got_slot_base(&self) -> Option<u64> {
        Some(self.got_addr_prevpass()? + self.got_reserved() * self.class.addr_size())
    }

    pub(super) fn got_slot_addr(&self, oi: usize, r: &RawReloc) -> Option<u64> {
        let idx = *self.got_map.get(&self.got_key(oi, r.sym)?)?;
        Some(self.got_slot_base()? + idx as u64 * self.class.addr_size())
    }

    /// The slot key of symbol `sym` of object `oi`; a section symbol,
    /// which has no name, takes none.
    pub(super) fn got_key(&self, oi: usize, sym: u32) -> Option<GotKey> {
        let s = self.objects[oi].symbols.get(sym as usize)?;
        if s.name.is_empty() {
            return None;
        }
        Some(if s.binding() == STB_LOCAL {
            GotKey::Local(oi, sym)
        } else {
            GotKey::Global(s.name.clone())
        })
    }

    /// True where a relocation names a GOT slot whatever its target
    /// resolves to: an aarch64 GOT reference, and an i386 one that does
    /// not relax. x86-64 relaxes every local one.
    pub(super) fn got_slot_ref(&self, oi: usize, si: usize, r: &RawReloc) -> bool {
        match self.machine {
            EM_AARCH64 => rt::aarch64_got_slot_ref(r.rtype),
            EM_386 => self.i386_got_slot_ref(oi, si, r),
            _ => false,
        }
    }

    /// Whether `key`'s slot holds a load address, which a
    /// position-independent image relocates; an absolute symbol's holds
    /// a number.
    pub(super) fn slot_holds_load_address(&self, key: &GotKey) -> bool {
        match key {
            GotKey::Global(name) => match self.globals.get(name) {
                Some(&(oi, si)) => self.reloc_is_relative(oi, si),
                None => (self
                    .script_now
                    .get(name)
                    .or_else(|| self.script_prev.get(name)))
                .is_some_and(|s| matches!(s.val.att, Att::Out(_)) || s.final_out.is_some()),
            },
            GotKey::Local(oi, si) => self.reloc_is_relative(*oi, *si as usize),
        }
    }

    /// The value `key`'s slot holds, `None` where the loader binds it.
    pub(super) fn slot_value(&self, key: &GotKey) -> Option<u64> {
        match key {
            GotKey::Global(name) if self.preemptible.contains(name) => None,
            GotKey::Global(name) => self.resolve_name(name),
            GotKey::Local(oi, si) => self.resolve_sym_prevpass(*oi, *si as usize, 0),
        }
    }
}
