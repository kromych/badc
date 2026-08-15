//! Duplicate-definition elimination shared by the relocatable
//! (`ld -r`) and script-driven final-link paths, which GNU ld 2.46.1
//! applies identically to both.
//!
//! A `GRP_COMDAT` group is keyed on its signature symbol's name and
//! nothing else; the first group seen for a signature wins and later
//! ones lose every member. A group without `GRP_COMDAT` is never
//! deduplicated. A `.gnu.linkonce.*` section is keyed on its own
//! section name, in a key space that does not meet the signatures'.

#![cfg(feature = "std")]

use alloc::vec::Vec;
use hashbrown::HashSet;

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
