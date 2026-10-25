//! What an executable's own code reaches of a shared library directly,
//! by an address the link fixes: a copy of a data object, filled by
//! `R_*_COPY`, and for a function its PLT entry as the function's
//! address (System V gABI, dynamic linking; GNU ld's copy relocations
//! and canonical PLT entries).

use crate::c5::object::elf_reloc_types as rt;
use alloc::string::String;
use alloc::vec::Vec;
use hashbrown::HashMap;

use super::got::{reloc_needs_plt, reloc_uses_got};
use super::inputs::RawReloc;
use super::{
    EM_386, EM_AARCH64, LdsEmit, LdsLinker, R_NONE, SHF_ALLOC, SHF_EXECINSTR, SHF_WRITE, SHN_UNDEF,
    STB_LOCAL, SYNTH_DYNBSS, SYNTH_DYNRELRO,
};

/// An imported object an executable holds a copy of.
#[derive(Debug, Clone)]
pub(super) struct ObjectCopy {
    pub(super) name: String,
    pub(super) size: u64,
    /// In `.data.rel.ro` where the library keeps the object read-only, in
    /// `.dynbss` otherwise.
    pub(super) readonly: bool,
    /// Offset in its section.
    pub(super) off: u64,
}

impl<'a> LdsLinker<'a> {
    /// Whether `r`, in a section with `flags`, needs its target's address
    /// at link time: not a call, not a load through the GOT, and not an
    /// address-width word in writable data, which a dynamic relocation
    /// carries. x86 reads a PC-relative field in code naming a function as
    /// a call, as bfd does.
    pub(super) fn direct_reference(&self, r: &RawReloc, flags: u64, function: bool) -> bool {
        let pc_call = function && flags & SHF_EXECINSTR != 0;
        let call = match self.machine {
            EM_AARCH64 => reloc_needs_plt(self.machine, r.rtype),
            EM_386 => r.rtype == rt::R_386_PLT32 || r.rtype == rt::R_386_PC32 && pc_call,
            _ => r.rtype == rt::R_X86_64_PLT32 || r.rtype == rt::R_X86_64_PC32 && pc_call,
        };
        let word = r.rtype == self.dyn_reloc_types().0 && flags & SHF_WRITE != 0;
        flags & SHF_ALLOC != 0
            && r.rtype != R_NONE
            && !call
            && !word
            && !reloc_uses_got(self.machine, r.rtype)
            && !rt::aarch64_got_slot_ref(r.rtype)
    }

    /// The data imports an executable's references need a copy of, laid
    /// out in name order at bfd's alignment; their sections' sizes and
    /// alignments.
    pub(super) fn plan_copies(&mut self) -> [(u64, u64); 2] {
        let mut wanted: alloc::collections::BTreeMap<&str, (u64, u64, bool)> = Default::default();
        if self.opts.shared || self.opts.shared_libs.is_empty() {
            return [(0, 1); 2];
        }
        for o in &self.objects {
            for sec in &o.sections {
                for r in &sec.relocs {
                    let Some(s) = o.symbols.get(r.sym as usize) else {
                        continue;
                    };
                    if s.binding() == STB_LOCAL
                        || s.shndx as u16 != SHN_UNDEF
                        || self.globals.contains_key(&s.name)
                        || !self.direct_reference(r, sec.flags, false)
                    {
                        continue;
                    }
                    let layout =
                        (self.opts.shared_libs.iter()).find_map(|l| l.lib.copy_layout.get(&s.name));
                    if let Some(&l) = layout {
                        wanted.insert(&s.name, l);
                    }
                }
            }
        }
        let mut copies = Vec::new();
        let mut extent = [(0u64, 1u64); 2];
        for (name, (size, align, readonly)) in wanted {
            let (end, max) = &mut extent[readonly as usize];
            let off = end.next_multiple_of(align);
            *end = off + size;
            *max = (*max).max(align);
            copies.push(ObjectCopy {
                name: String::from(name),
                size,
                readonly,
                off,
            });
        }
        self.copy_of = (copies.iter().enumerate())
            .map(|(k, c)| (c.name.clone(), k))
            .collect::<HashMap<_, _>>();
        self.copies = copies;
        extent
    }

    /// The address of `name`'s copy, if the image holds one.
    pub(super) fn copy_addr(&self, name: &str) -> Option<u64> {
        let c = &self.copies[*self.copy_of.get(name)?];
        let sec = if c.readonly {
            SYNTH_DYNRELRO
        } else {
            SYNTH_DYNBSS
        };
        Some(self.synth_addr(sec)? + c.off)
    }

    /// The output section `name`'s copy is in.
    pub(super) fn copy_out(&self, name: &str) -> Option<usize> {
        let c = &self.copies[*self.copy_of.get(name)?];
        self.kept_synth(if c.readonly {
            SYNTH_DYNRELRO
        } else {
            SYNTH_DYNBSS
        })
    }

    /// Whether an address-width word naming the import `name` binds at
    /// link time: a position-dependent executable's word naming a copy.
    /// A PIE leaves it to a relocation against the symbol, as bfd does.
    pub(super) fn word_binds_copy(&self, name: &str) -> bool {
        self.opts.emit == LdsEmit::Exec && self.copy_of.contains_key(name)
    }

    /// `R_*_COPY` for this target.
    pub(super) fn copy_reloc_type(&self) -> u32 {
        match self.machine {
            EM_AARCH64 => rt::R_AARCH64_COPY,
            EM_386 => rt::R_386_COPY,
            _ => rt::R_X86_64_COPY,
        }
    }
}
