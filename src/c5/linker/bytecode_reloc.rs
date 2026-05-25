//! Cross-TU relocation kinds. Each [`Reloc`] tells the linker
//! "apply target_value to location, with the kind-specific
//! biasing", where `target_value` is either a defined symbol's
//! resolved position in the merged program or a literal addend
//! when the symbol is `Undefined`-here-but-actually-internal.
//!
//! All relocations are 64-bit; the linker patches whole i64
//! words for the text relocations and whole 8-byte spans for
//! the data relocations, so there's no per-arch encoding
//! variability. Operand-sized fixups are unnecessary because
//! the c5 bytecode model uses one i64 per operand.

/// What to patch and how. Cross-TU references whose target
/// lives in the bytecode text were retired alongside the
/// bytecode-tape resolver; only the data-segment fixups
/// survive here. Walker-tier `Inst::*` references are carried
/// on `FunctionSsa::extern_*_refs` channels and resolved
/// independently of this enum.
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
    /// (`data_offset = location`, `target_bc_pc = symbol.value
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
    /// Constant added to the symbol's resolved value before the
    /// kind-specific biasing. Used for offset-into-array
    /// references like `&arr[3]` where the parser already
    /// materialised the `+3` arithmetic; the addend lets the
    /// linker collapse the trailing `Op::Imm 3 + Op::Add` into
    /// a single relocation site without a temporary.
    pub addend: i64,
}
