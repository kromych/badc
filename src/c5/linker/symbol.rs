//! Link-time symbol records. Distinct from
//! [`crate::c5::symbol::Symbol`] -- those describe the parser's
//! view of a name (token class, c5 type tag, frame-slot mapping,
//! ...). A [`LinkSymbol`] is the cross-TU contract: name,
//! external-vs-internal linkage, defined-vs-undefined,
//! containing section, value within that section, and an
//! optional c5 type tag carried for inter-TU diagnostic
//! purposes.

use alloc::string::String;

use crate::c5::symbol::Linkage;

/// Which logical section a defined symbol lives in. Mirrors the
/// shape of the eventual ELF section split inside a `.o` -- the
/// linker re-bases each unit's section into the merged program
/// independently, so a symbol's `kind` selects which base to add
/// to its `value`.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum SymbolKind {
    /// `value` is a bytecode PC inside `LinkUnit::text` (i.e. an
    /// i64 word index, not a byte offset). Used for every
    /// `Token::Fun` defined in the unit.
    Function,
    /// `value` is a byte offset into `LinkUnit::data`. Used for
    /// every non-thread-local file-scope variable defined in the
    /// unit.
    Data,
    /// `value` is a byte offset into `LinkUnit::tls_data`. Used
    /// for every `_Thread_local` file-scope variable.
    TlsData,
    /// The symbol is referenced but not defined in this unit;
    /// `value` is meaningless. The linker scans all units (and
    /// archive members) until either a defining `Function` /
    /// `Data` / `TlsData` entry of the same name is found, or
    /// the link fails with an "undefined reference" diagnostic.
    Undefined,
}

/// One entry in a [`LinkUnit::symbols`] table. Names are
/// interned globally inside the merged program by the linker;
/// each `LinkUnit` stores its own copy of the name string and
/// the linker dedups by string comparison.
#[derive(Debug, Clone)]
pub struct LinkSymbol {
    /// External (link-visible) name. Always non-empty for entries
    /// that the linker will surface -- the parser drops
    /// `Linkage::Internal` symbols out of the table because they
    /// have no cross-TU presence.
    pub name: String,
    /// Whether the symbol is visible to other TUs (`External`),
    /// strictly local to its unit (`Internal`), or has no
    /// linkage at all (`None` -- not stored in the link table;
    /// kept on the enum so a single [`Linkage`] type covers both
    /// the parser and the linker views).
    pub linkage: Linkage,
    /// Section + role. See [`SymbolKind`] for the per-variant
    /// interpretation of `value`.
    pub kind: SymbolKind,
    /// Section-relative offset. For `Function`, the bytecode PC
    /// (i64 word index) of `Op::Ent`; for `Data` / `TlsData`,
    /// the byte offset into the matching segment; for
    /// `Undefined`, ignored (kept at 0).
    pub value: u64,
    /// Informational size: for `Function`, the bytecode-word
    /// count of the function body (computed by the writer if not
    /// supplied); for `Data` / `TlsData`, the byte size of the
    /// storage. Aids debuggers and `nm`-style tooling; the
    /// linker itself doesn't depend on it for correctness.
    pub size: u64,
    /// c5 type tag (matches `Symbol::type_`). Surfaced for
    /// inter-TU diagnostics ("function `foo` declared with
    /// signature X in this TU but Y in the defining TU") and for
    /// the merged DWARF. `0` when the parser didn't have a
    /// signature to record (e.g. an `extern int foo();` form
    /// with no parameter list specified).
    pub type_tag: i64,
}

impl LinkSymbol {
    /// Convenience constructor for a defined function symbol.
    pub fn function(name: String, bc_pc: u64, size: u64, linkage: Linkage, type_tag: i64) -> Self {
        Self {
            name,
            linkage,
            kind: SymbolKind::Function,
            value: bc_pc,
            size,
            type_tag,
        }
    }

    /// Convenience constructor for a defined data symbol.
    pub fn data(name: String, offset: u64, size: u64, linkage: Linkage, type_tag: i64) -> Self {
        Self {
            name,
            linkage,
            kind: SymbolKind::Data,
            value: offset,
            size,
            type_tag,
        }
    }

    /// Convenience constructor for a defined TLS symbol.
    pub fn tls_data(name: String, offset: u64, size: u64, linkage: Linkage, type_tag: i64) -> Self {
        Self {
            name,
            linkage,
            kind: SymbolKind::TlsData,
            value: offset,
            size,
            type_tag,
        }
    }

    /// Convenience constructor for an undefined reference.
    pub fn undefined(name: String, type_tag: i64) -> Self {
        Self {
            name,
            linkage: Linkage::External,
            kind: SymbolKind::Undefined,
            value: 0,
            size: 0,
            type_tag,
        }
    }
}
