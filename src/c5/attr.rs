//! The attribute names badc's parser recognizes. The parser and the
//! `__has_attribute` operator read this one table, so the operator reports
//! exactly the GNU attributes the parser applies or accepts.

/// What an attribute name does once parsed.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(crate) enum Attr {
    Packed,
    Unused,
    Noreturn,
    ThreadLocal,
    Dllexport,
    Dllimport,
    Aligned,
    Constructor,
    Destructor,
    AlwaysInline,
    Noinline,
    GnuInline,
    Naked,
    Weak,
    WeakImport,
    Selectany,
    Used,
    NoInstrumentFunction,
    NoStackProtector,
    Uninitialized,
    DesignatedInit,
    TransparentUnion,
    MsAbi,
    SysvAbi,
    VectorSize,
    Mode,
    Cleanup,
    Section,
    Alias,
    Visibility,
    PatchableFunctionEntry,
    /// Parsed with its operands and without effect on the code badc emits.
    Accepted,
}

/// Where a name is an attribute: a GNU `__attribute__` (which
/// `__has_attribute` reports), or only a C23 `[[...]]` or `__declspec` one.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Spelling {
    Gnu,
    Other,
}

use Attr::*;
use Spelling::{Gnu, Other};

const TABLE: &[(&str, Attr, Spelling)] = &[
    ("packed", Packed, Gnu),
    ("unused", Unused, Gnu),
    ("maybe_unused", Unused, Other),
    ("noreturn", Noreturn, Gnu),
    ("thread", ThreadLocal, Other),
    ("dllexport", Dllexport, Gnu),
    ("dllimport", Dllimport, Gnu),
    ("aligned", Aligned, Gnu),
    ("align", Aligned, Other),
    ("constructor", Constructor, Gnu),
    ("destructor", Destructor, Gnu),
    ("always_inline", AlwaysInline, Gnu),
    ("noinline", Noinline, Gnu),
    ("gnu_inline", GnuInline, Gnu),
    ("naked", Naked, Gnu),
    ("weak", Weak, Gnu),
    ("weak_import", WeakImport, Gnu),
    ("selectany", Selectany, Gnu),
    ("used", Used, Gnu),
    ("no_instrument_function", NoInstrumentFunction, Gnu),
    ("no_stack_protector", NoStackProtector, Gnu),
    ("uninitialized", Uninitialized, Gnu),
    ("designated_init", DesignatedInit, Gnu),
    ("transparent_union", TransparentUnion, Gnu),
    ("ms_abi", MsAbi, Gnu),
    ("sysv_abi", SysvAbi, Gnu),
    ("vector_size", VectorSize, Gnu),
    ("mode", Mode, Gnu),
    ("cleanup", Cleanup, Gnu),
    ("section", Section, Gnu),
    ("alias", Alias, Gnu),
    ("visibility", Visibility, Gnu),
    ("patchable_function_entry", PatchableFunctionEntry, Gnu),
    ("deprecated", Accepted, Gnu),
    ("const", Accepted, Gnu),
    ("pure", Accepted, Gnu),
    ("malloc", Accepted, Gnu),
    ("flatten", Accepted, Gnu),
    ("format", Accepted, Gnu),
    ("format_arg", Accepted, Gnu),
    ("sentinel", Accepted, Gnu),
    ("nonnull", Accepted, Gnu),
    ("returns_nonnull", Accepted, Gnu),
    ("warn_unused_result", Accepted, Gnu),
    ("alloc_size", Accepted, Gnu),
    ("alloc_align", Accepted, Gnu),
    ("assume_aligned", Accepted, Gnu),
    ("cold", Accepted, Gnu),
    ("hot", Accepted, Gnu),
    ("may_alias", Accepted, Gnu),
    ("fallthrough", Accepted, Gnu),
    ("nothrow", Accepted, Gnu),
    ("returns_twice", Accepted, Gnu),
    ("noclone", Accepted, Gnu),
    ("error", Accepted, Gnu),
    ("warning", Accepted, Gnu),
    ("unavailable", Accepted, Gnu),
    // Validated for its feature names; badc emits every instruction its
    // intrinsic surface carries on x86-64, so it selects nothing further.
    ("target", Accepted, Gnu),
];

fn lookup(name: &str) -> Option<(Attr, Spelling)> {
    let core = (name.strip_prefix("__").and_then(|n| n.strip_suffix("__")))
        .filter(|n| !n.is_empty())
        .unwrap_or(name);
    TABLE
        .iter()
        .find(|(n, ..)| *n == core)
        .map(|&(_, a, s)| (a, s))
}

/// The attribute `name` names, bare or as `__name__`, in any spelling.
pub(crate) fn attribute(name: &str) -> Option<Attr> {
    lookup(name).map(|(a, _)| a)
}

/// The GNU attribute `name` names, which `__has_attribute` reports.
pub(crate) fn gnu_attribute(name: &str) -> Option<Attr> {
    lookup(name).and_then(|(a, s)| (s == Gnu).then_some(a))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn names_are_unique_and_take_the_reserved_spelling() {
        for (i, (name, ..)) in TABLE.iter().enumerate() {
            assert!(TABLE[..i].iter().all(|(n, ..)| n != name), "{name} twice");
            assert_eq!(attribute(&alloc::format!("__{name}__")), attribute(name));
        }
        assert_eq!(attribute("_packed_"), None);
        assert_eq!(gnu_attribute("maybe_unused"), None);
        assert_eq!(attribute("maybe_unused"), Some(Unused));
    }
}
