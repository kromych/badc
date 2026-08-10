//! `.note.gnu.property` merging, shared by the `ld -r` and final-link
//! paths.
//!
//! Inputs each carry a `.note.gnu.property` section holding one or more
//! `NT_GNU_PROPERTY_TYPE_0` notes; the output carries one note whose
//! properties are the per-type combination of the inputs'. The rule per
//! type comes from the psABI ranges, so a type this linker has no name
//! for still merges correctly as long as it sits in a defined range.

#![cfg(feature = "std")]

use alloc::collections::BTreeMap;
use alloc::vec::Vec;

pub const NT_GNU_PROPERTY_TYPE_0: u32 = 5;

const GNU_PROPERTY_STACK_SIZE: u32 = 1;
const GNU_PROPERTY_NO_COPY_ON_PROTECTED: u32 = 2;

/// How a property type combines across inputs. The generic
/// `0xb000_....` ranges and the processor-specific `0xc000_....` ranges
/// are laid out the same way by the x86-64 and AArch64 psABIs.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Rule {
    /// Bitwise AND; the property survives only if every input has it.
    And,
    /// Bitwise OR; the property survives if any input has it.
    Or,
    /// Bitwise OR, but only if every input has it.
    OrAnd,
    /// Numeric maximum; survives if any input has it.
    Max,
    /// Valueless; survives if any input has it.
    Present,
}

fn rule_for(ty: u32) -> Option<Rule> {
    match ty {
        GNU_PROPERTY_STACK_SIZE => Some(Rule::Max),
        GNU_PROPERTY_NO_COPY_ON_PROTECTED => Some(Rule::Present),
        0xb000_0000..=0xb000_7fff | 0xc000_0000..=0xc000_7fff => Some(Rule::And),
        0xb000_8000..=0xb000_ffff | 0xc000_8000..=0xc000_ffff => Some(Rule::Or),
        0xc001_0000..=0xc001_7fff => Some(Rule::OrAnd),
        // No defined range: GNU ld warns and drops rather than passing
        // a value it cannot combine.
        _ => None,
    }
}

struct Acc {
    rule: Rule,
    value: u64,
    datasz: usize,
    seen: usize,
}

/// One property in the merged note.
pub struct Property {
    pub ty: u32,
    pub datasz: usize,
    pub value: u64,
}

/// Merge the `NT_GNU_PROPERTY_TYPE_0` notes of `notes` (one entry per
/// input section) over a link of `n_inputs` relocatable inputs.
/// `align` is the note alignment: 8 for ELF64, 4 for ELF32. An input
/// with no property section still counts: it withholds every all-input
/// property.
pub fn merge(notes: &[&[u8]], n_inputs: usize, align: usize) -> Vec<Property> {
    let mut accs: BTreeMap<u32, Acc> = BTreeMap::new();
    for note in notes {
        for (ty, data) in properties(note, align) {
            let Some(rule) = rule_for(ty) else { continue };
            let value = match rule {
                Rule::Present => 0,
                _ => read_le(data),
            };
            let e = accs.entry(ty).or_insert(Acc {
                rule,
                value: if rule == Rule::And { u64::MAX } else { 0 },
                datasz: data.len(),
                seen: 0,
            });
            match rule {
                Rule::And => e.value &= value,
                Rule::Or | Rule::OrAnd => e.value |= value,
                Rule::Max => e.value = e.value.max(value),
                Rule::Present => {}
            }
            e.datasz = e.datasz.max(data.len());
            e.seen += 1;
        }
    }
    accs.into_iter()
        .filter(|(_, a)| match a.rule {
            // A property every input must claim is withheld by any
            // input that does not, and an all-zero bit set claims
            // nothing.
            Rule::And | Rule::OrAnd => a.seen == n_inputs && a.value != 0,
            Rule::Or => a.value != 0,
            Rule::Max | Rule::Present => true,
        })
        .map(|(ty, a)| Property {
            ty,
            datasz: a.datasz,
            value: a.value,
        })
        .collect()
}

/// Walk the properties of every `NT_GNU_PROPERTY_TYPE_0` note in one
/// `.note.gnu.property` section.
fn properties(note: &[u8], align: usize) -> Vec<(u32, &[u8])> {
    let mut out = Vec::new();
    let mut off = 0usize;
    while off + 12 <= note.len() {
        let namesz = u32::from_le_bytes(note[off..off + 4].try_into().unwrap()) as usize;
        let descsz = u32::from_le_bytes(note[off + 4..off + 8].try_into().unwrap()) as usize;
        let ntype = u32::from_le_bytes(note[off + 8..off + 12].try_into().unwrap());
        let name_end = off + 12 + namesz.next_multiple_of(4);
        let Some(desc_end) = name_end.checked_add(descsz).filter(|e| *e <= note.len()) else {
            break;
        };
        if ntype == NT_GNU_PROPERTY_TYPE_0 && namesz >= 4 && &note[off + 12..off + 15] == b"GNU" {
            let mut d = name_end;
            while d + 8 <= desc_end {
                let ty = u32::from_le_bytes(note[d..d + 4].try_into().unwrap());
                let dsz = u32::from_le_bytes(note[d + 4..d + 8].try_into().unwrap()) as usize;
                if d + 8 + dsz > desc_end {
                    break;
                }
                out.push((ty, &note[d + 8..d + 8 + dsz]));
                d += 8 + dsz.next_multiple_of(align);
            }
        }
        off = desc_end.next_multiple_of(4);
    }
    out
}

fn read_le(data: &[u8]) -> u64 {
    let mut v = 0u64;
    for (i, b) in data.iter().take(8).enumerate() {
        v |= u64::from(*b) << (8 * i);
    }
    v
}

/// Encode merged properties as a `.note.gnu.property` section body.
/// `align` is the note alignment: 8 for ELF64, 4 for ELF32.
pub fn encode(props: &[Property], align: usize) -> Vec<u8> {
    let mut desc: Vec<u8> = Vec::new();
    for p in props {
        desc.extend_from_slice(&p.ty.to_le_bytes());
        desc.extend_from_slice(&(p.datasz as u32).to_le_bytes());
        desc.extend_from_slice(&p.value.to_le_bytes()[..p.datasz.min(8)]);
        while !desc.len().is_multiple_of(align) {
            desc.push(0);
        }
    }
    let mut body: Vec<u8> = Vec::new();
    body.extend_from_slice(&4u32.to_le_bytes());
    body.extend_from_slice(&(desc.len() as u32).to_le_bytes());
    body.extend_from_slice(&NT_GNU_PROPERTY_TYPE_0.to_le_bytes());
    body.extend_from_slice(b"GNU\0");
    body.extend_from_slice(&desc);
    body
}

/// Merged section body for the inputs, or `None` when nothing survives.
pub fn merge_section(notes: &[&[u8]], n_inputs: usize, align: usize) -> Option<Vec<u8>> {
    let props = merge(notes, n_inputs, align);
    (!props.is_empty()).then(|| encode(&props, align))
}

#[cfg(test)]
mod tests {
    use super::*;

    const X86_FEATURE_1_AND: u32 = 0xc000_0002;
    const AARCH64_FEATURE_1_AND: u32 = 0xc000_0000;
    const X86_ISA_1_USED: u32 = 0xc001_0002;
    const X86_FEATURE_2_USED: u32 = 0xc001_0001;

    /// One note holding `props` as `(type, datasz, value)`.
    fn note(props: &[(u32, usize, u64)]) -> Vec<u8> {
        encode(
            &props
                .iter()
                .map(|&(ty, datasz, value)| Property { ty, datasz, value })
                .collect::<Vec<_>>(),
            8,
        )
    }

    fn merged(notes: &[Vec<u8>], n_inputs: usize) -> Vec<(u32, u64)> {
        let refs: Vec<&[u8]> = notes.iter().map(|n| n.as_slice()).collect();
        merge(&refs, n_inputs, 8)
            .into_iter()
            .map(|p| (p.ty, p.value))
            .collect()
    }

    #[test]
    fn feature_and_properties_intersect_across_inputs() {
        // IBT|SHSTK against IBT leaves IBT: an image is only as
        // protected as its least protected input.
        let a = note(&[(X86_FEATURE_1_AND, 4, 0x3)]);
        let b = note(&[(X86_FEATURE_1_AND, 4, 0x1)]);
        assert_eq!(merged(&[a, b], 2), [(X86_FEATURE_1_AND, 0x1)]);
    }

    #[test]
    fn feature_and_property_is_dropped_when_an_input_omits_it() {
        let a = note(&[(AARCH64_FEATURE_1_AND, 4, 0x3)]);
        // Two inputs, one note: the silent input withholds the claim.
        assert_eq!(merged(&[a], 2), []);
    }

    #[test]
    fn feature_and_property_is_dropped_when_the_intersection_is_empty() {
        let a = note(&[(X86_FEATURE_1_AND, 4, 0x1)]);
        let b = note(&[(X86_FEATURE_1_AND, 4, 0x2)]);
        assert_eq!(merged(&[a, b], 2), []);
    }

    #[test]
    fn used_properties_union_across_inputs() {
        // The x86_64 vDSO link: ISA_1_USED disagrees (0 against 1) and
        // FEATURE_2_USED disagrees (1 against 9); both are OR_AND, so
        // both survive with the union.
        let a = note(&[(X86_FEATURE_2_USED, 4, 0x1), (X86_ISA_1_USED, 4, 0x0)]);
        let b = note(&[(X86_FEATURE_2_USED, 4, 0x9), (X86_ISA_1_USED, 4, 0x1)]);
        assert_eq!(
            merged(&[a, b], 2),
            [(X86_FEATURE_2_USED, 0x9), (X86_ISA_1_USED, 0x1)]
        );
    }

    #[test]
    fn or_properties_survive_an_input_that_omits_them() {
        let a = note(&[(0xb000_8001, 4, 0x1)]);
        let b = note(&[(X86_FEATURE_1_AND, 4, 0x3)]);
        assert_eq!(merged(&[a, b], 2), [(0xb000_8001, 0x1)]);
    }

    #[test]
    fn stack_size_takes_the_maximum_and_no_copy_on_protected_is_sticky() {
        let a = note(&[
            (GNU_PROPERTY_STACK_SIZE, 8, 0x1000),
            (GNU_PROPERTY_NO_COPY_ON_PROTECTED, 0, 0),
        ]);
        let b = note(&[(GNU_PROPERTY_STACK_SIZE, 8, 0x2000)]);
        assert_eq!(
            merged(&[a, b], 2),
            [
                (GNU_PROPERTY_STACK_SIZE, 0x2000),
                (GNU_PROPERTY_NO_COPY_ON_PROTECTED, 0)
            ]
        );
    }

    #[test]
    fn a_type_outside_every_defined_range_is_dropped_without_ending_the_walk() {
        // The unknown type sits first, so a walk that stopped there
        // would lose the AND property behind it.
        let a = note(&[(0x10, 4, 0xaabb_ccdd), (X86_FEATURE_1_AND, 4, 0x3)]);
        let b = note(&[(0x10, 4, 0xaabb_ccdd), (X86_FEATURE_1_AND, 4, 0x3)]);
        assert_eq!(merged(&[a, b], 2), [(X86_FEATURE_1_AND, 0x3)]);
    }

    #[test]
    fn an_unknown_proc_specific_type_merges_by_its_range() {
        // No name for it here, but it is in the AND range, so it
        // intersects rather than being passed through.
        let a = note(&[(0xc000_0042, 4, 0x1122_3344)]);
        let b = note(&[(0xc000_0042, 4, 0x5566_7788)]);
        assert_eq!(merged(&[a, b], 2), [(0xc000_0042, 0x1122_3300)]);
    }

    #[test]
    fn several_notes_in_one_section_are_all_walked() {
        let mut a = note(&[(X86_FEATURE_2_USED, 4, 0x1)]);
        a.extend_from_slice(&note(&[(X86_ISA_1_USED, 4, 0x2)]));
        let b = note(&[(X86_FEATURE_2_USED, 4, 0x8), (X86_ISA_1_USED, 4, 0x1)]);
        assert_eq!(
            merged(&[a, b], 2),
            [(X86_FEATURE_2_USED, 0x9), (X86_ISA_1_USED, 0x3)]
        );
    }

    #[test]
    fn the_encoding_matches_what_ld_emits() {
        // The merged x86_64 vDSO note, byte for byte.
        let body = encode(
            &[
                Property {
                    ty: X86_FEATURE_2_USED,
                    datasz: 4,
                    value: 0x9,
                },
                Property {
                    ty: X86_ISA_1_USED,
                    datasz: 4,
                    value: 0x1,
                },
            ],
            8,
        );
        assert_eq!(
            body,
            [
                4, 0, 0, 0, 0x20, 0, 0, 0, 5, 0, 0, 0, b'G', b'N', b'U', 0, //
                0x01, 0x00, 0x01, 0xc0, 4, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, //
                0x02, 0x00, 0x01, 0xc0, 4, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,
            ]
        );
    }
}
