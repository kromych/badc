//! `__imp_X` names the import-address slot of `X` (PE/COFF; MSVC, mingw-w64
//! gcc and clang read it for a dllimport entity). A reference to such a name
//! no input defines becomes a reference to `X` through its GOT slot, which
//! keeps the slot the loader fills -- the import's address, not its thunk.
//! When the link defines `X` the reference resolves to the definition, with
//! the warning lld and MSVC's link give (LNK4217).

use super::link_err;
use super::object::{NativeMachine, NativeObject, NativeSymSection, NativeSymbol};
use crate::c5::diag::Code;
use crate::c5::error::C5Error;
use crate::c5::object::elf_reloc_types::{
    R_AARCH64_ADR_GOT_PAGE, R_AARCH64_ADR_PREL_PG_HI21, R_AARCH64_LD64_GOT_LO12_NC,
    R_AARCH64_LDST64_ABS_LO12_NC, R_X86_64_GOTPCREL, R_X86_64_PC32, aarch64_reloc_desc,
    x86_64_reloc_desc,
};
use alloc::collections::{BTreeMap, BTreeSet};
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

pub(crate) const PREFIX: &str = "__imp_";

/// The inputs with each slot reference rewritten, and the `(unit, text
/// offset)` of every rewritten site.
pub(crate) struct SlotReads {
    pub objs: Vec<NativeObject>,
    pub sites: BTreeSet<(usize, u64)>,
    pub warnings: Vec<(Code, String)>,
}

/// The GOT form of a slot read: x86-64 `mov` / `call` / `jmp` through
/// `[rip + __imp_X]`, the aarch64 `adrp` + `ldr` pair.
fn slot_form(machine: NativeMachine, rtype: u32) -> Option<u32> {
    match (machine, rtype) {
        (NativeMachine::X86_64, R_X86_64_PC32) => Some(R_X86_64_GOTPCREL),
        (NativeMachine::Aarch64, R_AARCH64_ADR_PREL_PG_HI21) => Some(R_AARCH64_ADR_GOT_PAGE),
        (NativeMachine::Aarch64, R_AARCH64_LDST64_ABS_LO12_NC) => Some(R_AARCH64_LD64_GOT_LO12_NC),
        _ => None,
    }
}

/// `None` when no input names an undefined import slot.
pub(crate) fn bind_slot_reads(objs: &[NativeObject]) -> Result<Option<SlotReads>, C5Error> {
    let definer: BTreeMap<&str, &str> = (objs.iter())
        .flat_map(|o| o.symbols.iter().map(move |s| (s, o.source.as_str())))
        .filter(|(s, _)| s.binding != 0 && s.section != NativeSymSection::Undef)
        .map(|(s, src)| (s.name.as_str(), src))
        .collect();
    let slot_of = |s: &NativeSymbol| -> Option<String> {
        let target = s.name.strip_prefix(PREFIX)?;
        (s.section == NativeSymSection::Undef
            && s.binding != 0
            && !target.is_empty()
            && !definer.contains_key(s.name.as_str()))
        .then(|| target.into())
    };
    if !objs
        .iter()
        .any(|o| o.symbols.iter().any(|s| slot_of(s).is_some()))
    {
        return Ok(None);
    }
    let mut out = objs.to_vec();
    let mut sites = BTreeSet::new();
    let mut warned = BTreeSet::new();
    let mut warnings = Vec::new();
    for (unit, obj) in out.iter_mut().enumerate() {
        let slots: Vec<(usize, String)> = (obj.symbols.iter().enumerate())
            .filter_map(|(i, s)| Some((i, slot_of(s)?)))
            .collect();
        let mut target_of = BTreeMap::new();
        for (i, target) in slots {
            let existing = (obj.symbols.iter()).position(|s| s.binding != 0 && s.name == target);
            let at = existing.unwrap_or_else(|| {
                obj.symbols.push(NativeSymbol {
                    name: target.clone(),
                    section: NativeSymSection::Undef,
                    value: 0,
                    size: 0,
                    binding: obj.symbols[i].binding,
                    kind: obj.symbols[i].kind,
                    visibility: 0,
                    input_section: None,
                });
                obj.symbols.len() - 1
            });
            target_of.insert(i, at);
            if let Some(src) = definer.get(target.as_str())
                && warned.insert(target.clone())
            {
                let text = format!(
                    "`{PREFIX}{target}` in {} imports `{target}`, which {src} defines; \
                     the reference takes the definition",
                    obj.source
                );
                warnings.push((Code::LOCAL_IMPORT, text));
            }
        }
        for r in obj.text_relocs.iter_mut() {
            let Some(&at) = target_of.get(&r.sym_idx) else {
                continue;
            };
            let Some(rtype) = slot_form(obj.machine, r.rtype) else {
                let desc = match obj.machine {
                    NativeMachine::X86_64 => x86_64_reloc_desc(r.rtype),
                    NativeMachine::Aarch64 => aarch64_reloc_desc(r.rtype),
                };
                let text = format!(
                    "`{PREFIX}{}` names an import-address slot, which only a load reads; \
                     {} references it through {desc}",
                    obj.symbols[at].name, obj.source
                );
                return Err(link_err(Code::RELOCATION, "", &text));
            };
            (r.rtype, r.sym_idx) = (rtype, at);
            sites.insert((unit, r.offset));
        }
        // A slot name no other relocation references leaves the link's
        // undefined names; one that is stays, and is reported undefined.
        let elsewhere: BTreeSet<usize> = (obj.relro_relocs.iter())
            .chain(&obj.data_relocs)
            .chain(&obj.tls_relocs)
            .map(|r| r.sym_idx)
            .collect();
        for &i in target_of.keys() {
            if !elsewhere.contains(&i) {
                obj.symbols[i].binding = 0;
            }
        }
    }
    Ok(Some(SlotReads {
        objs: out,
        sites,
        warnings,
    }))
}
