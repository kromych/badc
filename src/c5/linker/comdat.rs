//! Duplicate-definition elimination shared by the relocatable
//! (`ld -r`) and script-driven final-link paths, which GNU ld 2.46.1
//! applies identically to both, and the COFF COMDAT selection of the
//! native link.
//!
//! A `GRP_COMDAT` group is keyed on its signature symbol's name and
//! nothing else; the first group seen for a signature wins and later
//! ones lose every member. A group without `GRP_COMDAT` is never
//! deduplicated. A `.gnu.linkonce.*` section is keyed on its own
//! section name, in a key space that does not meet the signatures'.

#![cfg(feature = "std")]

use alloc::format;
use alloc::vec::Vec;
use hashbrown::{HashMap, HashSet};

use super::link_err;
use super::object::NativeObject;
use crate::c5::diag::Code;
use crate::c5::error::C5Error;

const IMAGE_COMDAT_SELECT_NODUPLICATES: u8 = 1;
pub(crate) const IMAGE_COMDAT_SELECT_ANY: u8 = 2;
const IMAGE_COMDAT_SELECT_SAME_SIZE: u8 = 3;
const IMAGE_COMDAT_SELECT_EXACT_MATCH: u8 = 4;
const IMAGE_COMDAT_SELECT_LARGEST: u8 = 6;

pub const GRP_COMDAT: u32 = 1;

/// `(object index, section index within that object)`.
pub type SecId = (usize, usize);

pub struct GroupView<'a> {
    pub flags: u32,
    pub signature: &'a str,
    /// Member section indices within the owning object.
    pub members: &'a [usize],
}

pub struct ObjView<'a> {
    pub groups: Vec<GroupView<'a>>,
    /// Every section's name, indexed as the members are.
    pub section_names: Vec<&'a str>,
}

#[derive(Default)]
pub struct Dedup {
    /// Groups that survive, as `(object, group index)`.
    pub kept: Vec<(usize, usize)>,
    /// Sections a losing group or a later `.gnu.linkonce` copy owns.
    pub dropped: HashSet<SecId>,
}

/// The COFF COMDAT groups of a link, as `(object, section record)` pairs.
#[derive(Default)]
pub struct CoffSelection {
    /// Every group's sections.
    pub members: HashSet<(usize, u32)>,
    /// The sections of the groups another group of their key displaced.
    pub dropped: HashSet<(usize, u32)>,
}

/// Select one COFF COMDAT group per key over `objs` in link order (PE/COFF
/// specification 5.5.6): the first, or under `LARGEST` the largest; a second is a
/// duplicate under `NODUPLICATES`, or `SAME_SIZE` / `EXACT_MATCH` on a mismatch;
/// `NEWEST` is refused.
pub fn select_coff(objs: &[NativeObject]) -> Result<CoffSelection, C5Error> {
    let mut out = CoffSelection::default();
    let mut kept: HashMap<&str, (usize, usize)> = HashMap::new();
    for (oi, o) in objs.iter().enumerate() {
        for (gi, g) in o.comdats.iter().enumerate() {
            out.members.extend(g.sections.iter().map(|&s| (oi, s)));
            let rule = g.selection;
            if !matches!(
                rule,
                IMAGE_COMDAT_SELECT_NODUPLICATES
                    | IMAGE_COMDAT_SELECT_ANY
                    | IMAGE_COMDAT_SELECT_SAME_SIZE
                    | IMAGE_COMDAT_SELECT_EXACT_MATCH
                    | IMAGE_COMDAT_SELECT_LARGEST
            ) {
                return Err(link_err(
                    Code::UNSUPPORTED,
                    "",
                    &format!(
                        "{}: COMDAT `{}` has selection {rule}, which the linker does not apply",
                        o.source, g.key
                    ),
                ));
            }
            let Some(&(pi, pg)) = kept.get(g.key.as_str()) else {
                kept.insert(&g.key, (oi, gi));
                continue;
            };
            let p = &objs[pi].comdats[pg];
            let clash = match (p.selection, rule) {
                (IMAGE_COMDAT_SELECT_NODUPLICATES, _) | (_, IMAGE_COMDAT_SELECT_NODUPLICATES) => {
                    true
                }
                (IMAGE_COMDAT_SELECT_SAME_SIZE, _) => p.size != g.size,
                (IMAGE_COMDAT_SELECT_EXACT_MATCH, _) => {
                    p.checksum != g.checksum || p.size != g.size
                }
                _ => false,
            };
            if clash {
                return Err(link_err(
                    Code::DUPLICATE_SYMBOL,
                    "",
                    &format!(
                        "multiple definition of `{}`: a COMDAT in {} and one in {}",
                        g.key, objs[pi].source, o.source
                    ),
                ));
            }
            let replaces = p.selection == IMAGE_COMDAT_SELECT_LARGEST && g.size > p.size;
            let (lose, lose_group) = if replaces { (pi, pg) } else { (oi, gi) };
            let lost = &objs[lose].comdats[lose_group];
            out.dropped.extend(lost.sections.iter().map(|&s| (lose, s)));
            if replaces {
                kept.insert(&g.key, (oi, gi));
            }
        }
    }
    Ok(out)
}

/// Deduplicate over `objs`, which are in link order: that ordering is
/// what makes the first copy the surviving one.
pub fn dedup(objs: &[ObjView<'_>]) -> Dedup {
    let mut out = Dedup::default();
    let mut signatures: HashSet<&str> = HashSet::new();
    for (oi, o) in objs.iter().enumerate() {
        for (gi, g) in o.groups.iter().enumerate() {
            if g.flags & GRP_COMDAT == 0 || signatures.insert(g.signature) {
                out.kept.push((oi, gi));
                continue;
            }
            out.dropped.extend(g.members.iter().map(|&m| (oi, m)));
        }
    }
    let mut linkonce: HashSet<&str> = HashSet::new();
    for (oi, o) in objs.iter().enumerate() {
        for (si, name) in o.section_names.iter().enumerate() {
            if !name.starts_with(".gnu.linkonce.") || out.dropped.contains(&(oi, si)) {
                continue;
            }
            if !linkonce.insert(name) {
                out.dropped.insert((oi, si));
            }
        }
    }
    out
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::linker::object::Comdat;

    fn unit(source: &str, groups: &[(&str, u8, u64, u32)]) -> NativeObject {
        let mut o = crate::c5::linker::coff_object::parse_native_coff(
            &crate::c5::linker::coff_object::build::object(0x8664, &[], &[]),
        )
        .unwrap();
        o.source = source.into();
        o.comdats = (groups.iter().enumerate())
            .map(|(k, &(key, selection, size, checksum))| Comdat {
                key: key.into(),
                selection,
                size,
                checksum,
                sections: alloc::vec![k as u32],
            })
            .collect();
        o
    }

    /// The first group of a key stays, or under `LARGEST` the largest.
    #[test]
    fn one_group_of_each_key_stays() {
        let objs = [
            unit("a", &[("any", 2, 8, 0), ("big", 6, 4, 0)]),
            unit("b", &[("any", 2, 8, 1), ("big", 6, 16, 0)]),
        ];
        let sel = select_coff(&objs).unwrap();
        let mut dropped: Vec<_> = sel.dropped.into_iter().collect();
        dropped.sort();
        assert_eq!(dropped, [(0, 1), (1, 0)]);
        assert_eq!(sel.members.len(), 4);
    }

    /// `NODUPLICATES` and a mismatch the rule compares make a duplicate definition.
    #[test]
    fn a_group_the_rule_rejects_is_a_duplicate_definition() {
        for (rule, a, b) in [
            (1, (4, 0), (4, 0)),
            (3, (4, 0), (8, 0)),
            (4, (4, 1), (4, 2)),
        ] {
            let objs = [
                unit("a.obj", &[("k", rule, a.0, a.1)]),
                unit("b.obj", &[("k", rule, b.0, b.1)]),
            ];
            let err = select_coff(&objs).err().expect("a duplicate").to_string();
            assert!(
                err.contains("multiple definition of `k`: a COMDAT in a.obj and one in b.obj"),
                "{rule}: {err}"
            );
        }
        let same = [unit("a", &[("k", 4, 4, 7)]), unit("b", &[("k", 4, 4, 7)])];
        assert!(select_coff(&same).is_ok());
    }
}
