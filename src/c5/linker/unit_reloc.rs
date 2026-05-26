//! Cross-TU data-segment relocations. Each [`Reloc`] tells the
//! linker "patch the 8-byte slot at `location` with the
//! resolved address of `sym_index`, plus `addend`".
//!
//! Text-segment references travel through the walker-tier
//! `FunctionSsa::extern_*_refs` channels and resolve
//! independently of this enum; only the data-segment fixups
//! live here.

/// What to patch and how.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
#[repr(u8)]
pub enum RelocKind {
    /// 8-byte little-endian slot in the data segment that
    /// stores the address of a global. The merged program's
    /// `data_relocs` list gains one entry (`data_offset =
    /// location`, `target_offset = symbol.value + addend`)
    /// so the per-target writer applies the dynamic
    /// relocation as it would for an intra-TU initializer
    /// like `int *p = &x;`. Symbol must be `Data`.
    DataDataAbs64 = 4,
    /// 8-byte little-endian slot in the data segment that
    /// stores the runtime code address of a function (the
    /// `static const VTable v = { .xClose = ... };`
    /// dispatch-table shape). The merged program's
    /// `code_relocs` list gains one entry
    /// (`data_offset = location`, `target_ent_pc = symbol.value
    /// + addend`). Symbol must be `Function`.
    DataCodeAbs64 = 5,
}

impl RelocKind {
    /// Decode from the on-disk byte. Returns `None` for unknown
    /// values so a forward-compatible object file (an older
    /// linker reading newer relocation kinds) surfaces a clear
    /// error instead of silently mis-patching.
    pub fn from_u8(v: u8) -> Option<RelocKind> {
        match v {
            4 => Some(RelocKind::DataDataAbs64),
            5 => Some(RelocKind::DataCodeAbs64),
            _ => None,
        }
    }

    pub fn as_u8(self) -> u8 {
        self as u8
    }
}

/// One pending patch from a [`crate::c5::linker::LinkUnit`].
/// Resolved against the unit's local symbol table during link;
/// undefined symbols become unresolved references that the
/// linker tries to satisfy from other units / archives.
#[derive(Debug, Clone, Copy)]
pub struct Reloc {
    /// What to patch and how (see [`RelocKind`]).
    pub kind: RelocKind,
    /// Section-relative byte offset into `LinkUnit::data`,
    /// always 8-byte aligned.
    pub location: u64,
    /// Index into `LinkUnit::symbols`. The linker resolves the
    /// `LinkSymbol` to a merged-program address based on its
    /// `kind` + section base.
    pub sym_index: u32,
    /// Constant added to the symbol's resolved value. Used for
    /// offset-into-array references like `&arr[3]` where the
    /// parser already materialised the `+3` arithmetic.
    pub addend: i64,
}
