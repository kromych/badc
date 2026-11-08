//! A PE image imports through one descriptor per DLL, so two units may take
//! one name from two DLLs. The first unit to route a name keeps it; a later
//! unit routing it to another DLL refers to it under a key naming that DLL,
//! which the import table spells as the name. A definition in the link
//! outranks every route, so a name some unit defines keeps its spelling.

use super::object::{NativeObject, NativeSymSection};
use alloc::collections::{BTreeMap, BTreeSet};
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

/// Joins a routed name to its DLL in a key; no symbol name or DLL path holds
/// it ([`crate::c5::mach_o_name::RAW`] leads a name).
const SEP: char = '\u{1f}';

/// The name a key this pass made imports.
pub(crate) fn routed_name(key: &str) -> Option<&str> {
    key.split_once(SEP).map(|(name, _)| name)
}

/// The inputs with each second route keyed by its DLL; `None` when every
/// name routes to one DLL.
pub(crate) fn split_routes(objs: &[NativeObject]) -> Option<Vec<NativeObject>> {
    let defined: BTreeSet<&str> = (objs.iter())
        .flat_map(|o| &o.symbols)
        .filter(|s| s.binding != 0 && s.section != NativeSymSection::Undef)
        .map(|s| s.name.as_str())
        .collect();
    let dll_of = |o: &NativeObject, idx: u32| o.dylibs.get(idx as usize).cloned();
    let mut first: BTreeMap<String, String> = BTreeMap::new();
    let mut split = false;
    for o in objs {
        for (name, idx) in &o.import_dylib_map {
            let Some(dll) = dll_of(o, *idx) else { continue };
            if defined.contains(name.as_str()) {
                continue;
            }
            let kept = first.entry(name.clone()).or_insert_with(|| dll.clone());
            split |= !kept.eq_ignore_ascii_case(&dll);
        }
    }
    if !split {
        return None;
    }
    let mut out = objs.to_vec();
    for o in &mut out {
        let keys: Vec<(String, String)> = (o.import_dylib_map.iter())
            .filter_map(|(name, idx)| {
                let dll = dll_of(o, *idx)?;
                let kept = first.get(name)?;
                (!kept.eq_ignore_ascii_case(&dll))
                    .then(|| (name.clone(), format!("{name}{SEP}{dll}")))
            })
            .collect();
        for (name, key) in keys {
            for (n, _) in o.import_dylib_map.iter_mut().filter(|(n, _)| *n == name) {
                n.clone_from(&key);
            }
            let undefined = |s: &&mut super::object::NativeSymbol| {
                s.name == name && s.section == NativeSymSection::Undef
            };
            for s in o.symbols.iter_mut().filter(undefined) {
                s.name.clone_from(&key);
            }
        }
    }
    Some(out)
}
