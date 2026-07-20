//! Named-section table for relocatable output.
//!
//! Carries every section that is not part of the writer's fixed set:
//! `__attribute__((section("name")))` placements today, assembler
//! `.pushsection` payloads next. Entries are keyed by name; the writer
//! assigns section indices, emits one STT_SECTION symbol per entry,
//! and appends each entry's bytes plus a companion `.rela<name>` when
//! it carries relocations.

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
    /// `.rela<name>`, kept alongside so the section-header string
    /// table can reference it by slice.
    pub rela_name: String,
    /// SHT_* value, SHT_PROGBITS for both code and data placements.
    pub sh_type: u32,
    /// SHF_* mask; SHF_ALLOC|SHF_EXECINSTR for text-like entries,
    /// SHF_ALLOC|SHF_WRITE for data-like ones.
    pub flags: u64,
    pub align: u64,
    pub bytes: Vec<u8>,
    pub relas: Vec<SectionRela>,
}

/// The table itself: ordered, deduplicated by (name, type, flags).
#[derive(Debug, Clone, Default)]
pub(crate) struct SectionTable {
    pub entries: Vec<SectionSpec>,
}

impl SectionTable {
    /// Index of the entry for `name`, creating it when absent. An
    /// existing entry keeps its type/flags; asking for the same name
    /// with a different identity is an error surfaced to the caller.
    pub(crate) fn get_or_insert(
        &mut self,
        name: &str,
        sh_type: u32,
        flags: u64,
        align: u64,
    ) -> Result<usize, String> {
        if let Some(i) = self.entries.iter().position(|e| e.name == name) {
            let e = &self.entries[i];
            if e.sh_type != sh_type || e.flags != flags {
                return Err(alloc::format!(
                    "section `{name}` requested with conflicting type/flags"
                ));
            }
            return Ok(i);
        }
        let mut rela_name = String::with_capacity(name.len() + 5);
        rela_name.push_str(".rela");
        rela_name.push_str(name);
        self.entries.push(SectionSpec {
            name: name.into(),
            rela_name,
            sh_type,
            flags,
            align,
            bytes: Vec::new(),
            relas: Vec::new(),
        });
        Ok(self.entries.len() - 1)
    }

    pub(crate) fn is_empty(&self) -> bool {
        self.entries.is_empty()
    }
}
