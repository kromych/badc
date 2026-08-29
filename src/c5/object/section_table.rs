//! Named-section table for relocatable output.
//!
//! Carries every section that is not part of the writer's fixed set:
//! `__attribute__((section("name")))` placements and assembler
//! `.pushsection` payloads. Entries are keyed by name; the writer
//! assigns section indices, emits one STT_SECTION symbol per entry,
//! and appends each entry's bytes plus a companion relocation
//! section when it carries relocations.

use alloc::string::String;
use alloc::vec::Vec;

/// One relocation within a named section. Offsets and addends are
/// relative to the owning section's start.
#[derive(Debug, Clone, Copy)]
pub(crate) struct SectionRela {
    /// Byte offset within the section the relocation applies at.
    pub offset: u64,
    /// `.symtab` index of the referenced symbol.
    pub sym: u64,
    /// Machine-specific relocation type.
    pub rtype: u32,
    pub addend: i64,
}

/// A named section: identity (name + type + flags), content, and
/// relocations.
#[derive(Debug, Clone)]
pub(crate) struct SectionSpec {
    pub name: String,
    /// SHT_* value, SHT_PROGBITS for both code and data placements.
    pub sh_type: u32,
    /// SHF_* mask; SHF_ALLOC|SHF_EXECINSTR for text-like entries,
    /// SHF_ALLOC|SHF_WRITE for data-like ones.
    pub flags: u64,
    pub align: u64,
    /// `sh_entsize`, the `M` flag's entry size; 0 when none was given.
    pub entsize: u64,
    /// The section `sh_link` names under `SHF_LINK_ORDER`.
    pub link: Option<String>,
    pub bytes: Vec<u8>,
    pub relas: Vec<SectionRela>,
}

/// The table itself: ordered, deduplicated by (name, type, flags).
/// Entries are appended only through [`SectionTable::get_or_insert`],
/// which keeps `by_name` in step: a unit's asm can push a section per
/// exported symbol, so a scan for the name would make the writer
/// quadratic in the sections it holds.
#[derive(Debug, Clone, Default)]
pub(crate) struct SectionTable {
    pub entries: Vec<SectionSpec>,
    by_name: hashbrown::HashMap<String, usize>,
}

impl SectionTable {
    /// Index of the entry for `name`, creating it when absent. The
    /// entry's alignment grows to the largest request and its flags to
    /// the union of every request: one writable member makes the whole
    /// section writable, one executable member makes it executable.
    /// Asking for the same name with a different `sh_type` is an error
    /// surfaced to the caller -- content shape, unlike permission, has
    /// no meaningful union.
    pub(crate) fn get_or_insert(
        &mut self,
        name: &str,
        sh_type: u32,
        flags: u64,
        align: u64,
    ) -> Result<usize, String> {
        debug_assert_eq!(self.by_name.len(), self.entries.len());
        if let Some(&i) = self.by_name.get(name) {
            let e = &mut self.entries[i];
            if e.sh_type != sh_type {
                return Err(alloc::format!(
                    "section `{name}` requested with conflicting type \
                     ({} then {sh_type})",
                    e.sh_type,
                ));
            }
            e.flags |= flags;
            e.align = e.align.max(align);
            return Ok(i);
        }
        self.entries.push(SectionSpec {
            name: name.into(),
            sh_type,
            flags,
            align,
            entsize: 0,
            link: None,
            bytes: Vec::new(),
            relas: Vec::new(),
        });
        self.by_name.insert(name.into(), self.entries.len() - 1);
        Ok(self.entries.len() - 1)
    }

    pub(crate) fn is_empty(&self) -> bool {
        self.entries.is_empty()
    }
}
