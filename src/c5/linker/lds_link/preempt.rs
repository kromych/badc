//! A shared object's exported default-visibility definitions bind at load
//! time, so one the loader finds first preempts them (System V gABI, symbol
//! visibility). GNU ld reaches such a definition through the PLT, the GOT or
//! a dynamic relocation naming it, unless `-Bsymbolic` (or, for all but
//! objects, `-Bsymbolic-functions`) binds it to the object's own.

use crate::c5::codegen::aarch64::patch;
use crate::c5::linker::object::{
    badc_note_extern_data, elf_reloc_desc, locate_reloc, preemptible_in_shared_body,
};
use crate::c5::object::elf_reloc_types as rt;
use alloc::string::String;
use alloc::vec::Vec;
use hashbrown::{HashMap, HashSet};

use super::got::GotKey;
use super::inputs::RawReloc;
use super::{
    EM_386, EM_AARCH64, LdsEmit, LdsLinker, SHF_ALLOC, SHF_WRITE, SHN_ABS, SHT_NOTE, STB_LOCAL,
    STT_COMMON, STT_GNU_IFUNC, STT_OBJECT, STT_TLS, STV_DEFAULT, SYNTH_DYNSYM, SecFate,
};

/// `R_AARCH64_ADR_PREL_PG_HI21_NC`, which `elf_reloc_types` does not name.
const R_AARCH64_ADR_PREL_PG_HI21_NC: u32 = 276;

/// How a reference reaches a preemptible definition.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(super) enum Reach {
    Direct,
    Plt,
    Got,
    /// An aarch64 `adrp` / `add` pair badc's note lists, rewritten to
    /// load the GOT slot.
    NotedPair,
    /// A dynamic relocation of the field's own type naming the symbol.
    Dynamic,
    Refused,
}

/// How a field of `rtype` reaches a preemptible definition, as GNU ld
/// 2.46 links one; `writable` is the referring section's `SHF_WRITE`.
pub(super) fn reach(machine: u16, rtype: u32, writable: bool, noted: bool, addend: i64) -> Reach {
    // i386 takes a dynamic relocation for a PC-relative field in any
    // section, and binds a GOT-relative or narrower one directly.
    if machine == EM_386 {
        return match rtype {
            rt::R_386_PLT32 => Reach::Plt,
            rt::R_386_GOT32 | rt::R_386_GOT32X => Reach::Got,
            rt::R_386_32 | rt::R_386_PC32 => Reach::Dynamic,
            _ => Reach::Direct,
        };
    }
    if machine == EM_AARCH64 {
        return match rtype {
            rt::R_AARCH64_CALL26 | rt::R_AARCH64_JUMP26 => Reach::Plt,
            rt::R_AARCH64_ADR_GOT_PAGE | rt::R_AARCH64_LD64_GOT_LO12_NC => Reach::Got,
            rt::R_AARCH64_ABS64 => Reach::Dynamic,
            rt::R_AARCH64_ADR_PREL_PG_HI21 | rt::R_AARCH64_ADD_ABS_LO12_NC
                if noted && addend == 0 =>
            {
                Reach::NotedPair
            }
            // The noted `adrp` addresses the slot's page.
            _ if noted && rt::aarch64_ldst_lo12_scale(rtype).is_some() => Reach::Refused,
            rt::R_AARCH64_ADR_PREL_PG_HI21
            | R_AARCH64_ADR_PREL_PG_HI21_NC
            | rt::R_AARCH64_ADR_PREL_LO21
            | rt::R_AARCH64_LD_PREL_LO19
            | rt::R_AARCH64_ABS32
            | rt::R_AARCH64_ABS16 => Reach::Refused,
            _ if rt::aarch64_movw_field(rtype).is_some() => Reach::Refused,
            _ => Reach::Direct,
        };
    }
    match rtype {
        rt::R_X86_64_PLT32 => Reach::Plt,
        rt::R_X86_64_GOTPCREL | rt::R_X86_64_GOTPCRELX | rt::R_X86_64_REX_GOTPCRELX => Reach::Got,
        rt::R_X86_64_64 => Reach::Dynamic,
        rt::R_X86_64_PC8 | rt::R_X86_64_PC16 | rt::R_X86_64_PC32 | rt::R_X86_64_PC64
            if writable =>
        {
            Reach::Dynamic
        }
        rt::R_X86_64_PC8
        | rt::R_X86_64_PC16
        | rt::R_X86_64_PC32
        | rt::R_X86_64_PC64
        | rt::R_X86_64_32
        | rt::R_X86_64_32S
        | rt::R_X86_64_16
        | rt::R_X86_64_8 => Reach::Refused,
        _ => Reach::Direct,
    }
}

/// Whether a script assignment that runs defines a name, whether one
/// hides it, and the type the first gives it.
#[derive(Clone, Copy)]
struct ScriptDef {
    defines: bool,
    hidden: bool,
    kind: u8,
}

impl<'a> LdsLinker<'a> {
    /// The exported default-visibility definitions, before sections are
    /// claimed; [`Self::prune_preemptible`] drops the discarded ones.
    pub(super) fn collect_preemptible(&mut self) {
        self.noted_data = (self.objects.iter())
            .map(|o| {
                (o.sections.iter())
                    .filter(|s| s.name == ".note.badc" && s.shtype == SHT_NOTE)
                    .flat_map(|s| badc_note_extern_data(o.section_data(s)))
                    .collect()
            })
            .collect();
        if self.opts.emit != LdsEmit::Dyn || !self.opts.shared || self.opts.symbolic {
            return;
        }
        self.preemptible = self.preemptible_definitions();
    }

    fn preemptible_definitions(&self) -> HashSet<String> {
        let mut script: HashMap<&str, ScriptDef> = HashMap::new();
        for a in self.script_assignments().filter(|a| a.symbol != ".") {
            let runs = !a.provide || !self.globals.contains_key(&a.symbol);
            let kind = self.assigned_sym_type(a);
            let def = script.entry(a.symbol.as_str()).or_insert(ScriptDef {
                defines: false,
                hidden: false,
                kind,
            });
            def.defines |= runs;
            def.hidden |= runs && a.hidden;
        }
        let names = (self.globals.keys().map(String::as_str))
            .chain(script.iter().filter(|(_, d)| d.defines).map(|(n, _)| *n));
        let mut out: HashSet<String> = HashSet::new();
        for name in names {
            let kind = match script.get(name).filter(|d| d.defines) {
                Some(d) if d.hidden => continue,
                Some(d) => d.kind,
                None => {
                    let (oi, si) = self.globals[name];
                    self.objects[oi].symbols[si].kind()
                }
            };
            if matches!(kind, STT_TLS | STT_GNU_IFUNC)
                || (self.opts.symbolic_functions && !matches!(kind, STT_OBJECT | STT_COMMON))
                || self.visibility_of(name) != STV_DEFAULT
                || self.version_of(name).is_none()
            {
                continue;
            }
            out.insert(String::from(name));
        }
        out
    }

    /// Drop the definitions in discarded sections, and every one where the
    /// script discards `.dynsym`.
    pub(super) fn prune_preemptible(&mut self) {
        if self.kept_synth(SYNTH_DYNSYM).is_none() {
            self.preemptible.clear();
            return;
        }
        let dropped: Vec<String> = (self.preemptible.iter())
            .filter(|name| {
                !self.script_assigned.contains(*name)
                    && self
                        .globals
                        .get(*name)
                        .is_some_and(|&(oi, si)| !self.definition_kept(oi, si))
            })
            .cloned()
            .collect();
        for name in dropped {
            self.preemptible.remove(&name);
        }
    }

    fn definition_kept(&self, oi: usize, si: usize) -> bool {
        let sym = &self.objects[oi].symbols[si];
        if sym.shndx as u16 == SHN_ABS {
            return true;
        }
        let Some(&sec) = self.objects[oi].shndx_map.get(&sym.shndx) else {
            return false;
        };
        match self.fates[self.insec_index(oi, sec)] {
            SecFate::Placed { out } => self.outs[out].name != "/DISCARD/",
            _ => false,
        }
    }

    fn dynamic_target(&self, oi: usize, r: &RawReloc) -> Option<&str> {
        let sym = self.objects[oi].symbols.get(r.sym as usize)?;
        let name = sym.name.as_str();
        (sym.binding() != STB_LOCAL
            && (self.preemptible.contains(name) || self.import_of.contains_key(name)))
        .then_some(name)
    }

    /// How `r` in section `si` of object `oi` reaches its target. An
    /// import takes only the noted pair and a PC-relative field's dynamic
    /// relocation here; [`Self::import_target`] routes the rest.
    pub(super) fn reach_at(&self, oi: usize, si: usize, r: &RawReloc) -> Reach {
        if self.preemptible.is_empty() && self.import_of.is_empty() {
            return Reach::Direct;
        }
        let Some(name) = self.dynamic_target(oi, r) else {
            return Reach::Direct;
        };
        let sec = &self.objects[oi].sections[si];
        if sec.flags & SHF_ALLOC == 0 {
            return Reach::Direct;
        }
        let noted = self.noted_data.get(oi).is_some_and(|n| n.contains(name));
        let how = reach(
            self.machine,
            r.rtype,
            sec.flags & SHF_WRITE != 0,
            noted,
            r.addend,
        );
        let pc_dynamic = how == Reach::Dynamic && self.import_pc_dynamic(name, r.rtype);
        if self.preemptible.contains(name) || how == Reach::NotedPair || pc_dynamic {
            how
        } else {
            Reach::Direct
        }
    }

    /// The targets references in kept sections reach by `how`.
    pub(super) fn reached_by(&self, how: Reach) -> Vec<String> {
        let mut out: Vec<String> = Vec::new();
        for i in 0..self.insecs.len() {
            let SecFate::Placed { .. } = self.fates[i] else {
                continue;
            };
            let id = self.insecs[i];
            for r in &self.objects[id.obj].sections[id.sec].relocs {
                if self.reach_at(id.obj, id.sec, r) != how {
                    continue;
                }
                let name = self.objects[id.obj].symbols[r.sym as usize].name.clone();
                if !out.contains(&name) {
                    out.push(name);
                }
            }
        }
        out
    }

    /// Whether a branch reaches a preemptible definition, so the link
    /// needs a PLT.
    pub(super) fn calls_preemptible(&self) -> bool {
        (self.objects.iter().enumerate()).any(|(oi, o)| {
            (o.sections.iter().enumerate())
                .filter(|(si, _)| !self.comdat_dropped.contains(&(oi, *si)))
                .any(|(si, s)| (s.relocs.iter()).any(|r| self.reach_at(oi, si, r) == Reach::Plt))
        })
    }

    pub(super) fn stub_or_slot(&self, name: &str, how: Reach) -> Option<u64> {
        if how == Reach::Plt {
            let k = *self.plt_of.get(name)?;
            return self.plt_entry_addr(k);
        }
        let k = *self.got_map.get(&GotKey::Global(String::from(name)))?;
        Some(self.got_slot_base()? + k as u64 * self.class.addr_size())
    }

    pub(super) fn preempted_refusal(&self, oi: usize, si: usize, r: &RawReloc) -> String {
        let obj = &self.objects[oi];
        preemptible_in_shared_body(
            &locate_reloc(&obj.source, &obj.sections[si].name, r.offset),
            &elf_reloc_desc(self.machine, r.rtype),
            &obj.symbols[r.sym as usize].name,
        )
    }

    /// Rewrite the noted half at `site` (address `p`) to reach `slot`.
    pub(super) fn apply_noted_pair(
        &self,
        buf: &mut [u8],
        site: usize,
        p: u64,
        slot: u64,
        (oi, si, r): (usize, usize, &RawReloc),
    ) -> Result<(), String> {
        let obj = &self.objects[oi];
        let at = locate_reloc(&obj.source, &obj.sections[si].name, r.offset);
        if site + 4 > buf.len() {
            return Err(alloc::format!("{at}: relocation outside its section"));
        }
        if r.rtype == rt::R_AARCH64_ADR_PREL_PG_HI21 {
            patch::patch_adrp(buf, site, p as i64, slot as i64)
        } else {
            patch::patch_lo12_slot_load(buf, site, slot as i64, patch::SlotWidth::W64)
        }
        .map_err(|e| e.describe(&at))
    }
}
