//! `.note.gnu.property` merging, shared by the `ld -r` and final-link
//! paths.
//!
//! Inputs each carry a `.note.gnu.property` section holding one or more
//! `NT_GNU_PROPERTY_TYPE_0` notes; the output carries one note whose
//! properties are the per-type combination of the inputs'. The rule per
//! type comes from the psABI ranges, so a type this linker has no name
//! for still merges correctly as long as it sits in a defined range; a
//! type outside every range survives only where the inputs agree.

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
    /// No defined rule: the property survives only where every input
    /// carries the same payload, which is the result under each of the
    /// rules above and so needs none of them. Inputs that disagree
    /// leave a value this linker cannot compute, and emitting one
    /// input's would claim what the others do not.
    Agree,
}

impl Rule {
    /// Whether the rule reads the payload as a little-endian number.
    fn numeric(self) -> bool {
        !matches!(self, Rule::Agree | Rule::Present)
    }
}

fn rule_for(ty: u32) -> Rule {
    match ty {
        GNU_PROPERTY_STACK_SIZE => Rule::Max,
        GNU_PROPERTY_NO_COPY_ON_PROTECTED => Rule::Present,
        0xb000_0000..=0xb000_7fff | 0xc000_0000..=0xc000_7fff => Rule::And,
        0xb000_8000..=0xb000_ffff | 0xc000_8000..=0xc000_ffff => Rule::Or,
        0xc001_0000..=0xc001_7fff => Rule::OrAnd,
        _ => Rule::Agree,
    }
}

struct Acc {
    rule: Rule,
    data: Vec<u8>,
    seen: usize,
    conflict: bool,
}

impl Acc {
    /// Combine `data` into the accumulator. `within` folds one input's
    /// repeats of the type, which union rather than intersect: bfd
    /// unions them as it parses a note, so an input claims a bit it
    /// states anywhere.
    fn fold(&mut self, data: &[u8], within: bool) {
        let width = self.data.len().max(data.len());
        let (a, b) = (read_le(&self.data), read_le(data));
        self.data = match self.rule {
            Rule::Present => return,
            Rule::Agree => {
                self.conflict |= self.data != data;
                return;
            }
            Rule::Max => le_bytes(a.max(b), width),
            Rule::And if !within => le_bytes(a & b, width),
            Rule::And | Rule::Or | Rule::OrAnd => le_bytes(a | b, width),
        };
    }
}

/// One property in the merged note.
pub struct Property {
    pub ty: u32,
    pub data: Vec<u8>,
}

impl Property {
    /// A property whose payload is a `datasz`-byte little-endian
    /// number.
    #[cfg(test)]
    pub fn number(ty: u32, datasz: usize, value: u64) -> Property {
        Property {
            ty,
            data: le_bytes(value, datasz),
        }
    }
}

/// Merge the `NT_GNU_PROPERTY_TYPE_0` notes of every relocatable input,
/// each given as its `.note.gnu.property` section bodies. `align` is
/// the note alignment: 8 for ELF64, 4 for ELF32. An input with no
/// property section still counts: it withholds every all-input
/// property.
pub fn merge(inputs: &[Vec<&[u8]>], align: usize) -> Vec<Property> {
    let n_inputs = inputs.len();
    let mut accs: BTreeMap<u32, Acc> = BTreeMap::new();
    for notes in inputs {
        // Fold the input's own notes first, so a type it repeats
        // counts once against the all-input rules.
        let mut own: BTreeMap<u32, Acc> = BTreeMap::new();
        for note in notes {
            for (ty, data) in properties(note, align) {
                let rule = rule_for(ty);
                // A numeric rule combines a value of at most eight
                // bytes. A wider payload is malformed for the type, and
                // merging it would emit a `pr_datasz` past what the
                // value holds.
                if rule.numeric() && data.len() > 8 {
                    continue;
                }
                match own.get_mut(&ty) {
                    Some(acc) => acc.fold(data, true),
                    None => {
                        own.insert(
                            ty,
                            Acc {
                                rule,
                                data: data.to_vec(),
                                seen: 1,
                                conflict: false,
                            },
                        );
                    }
                }
            }
        }
        for (ty, o) in own {
            match accs.get_mut(&ty) {
                Some(acc) => {
                    acc.fold(&o.data, false);
                    acc.conflict |= o.conflict;
                    acc.seen += 1;
                }
                None => {
                    accs.insert(ty, o);
                }
            }
        }
    }
    accs.into_iter()
        .filter(|(_, a)| match a.rule {
            // A property every input must claim is withheld by any
            // input that does not, and an all-zero bit set claims
            // nothing.
            Rule::And | Rule::OrAnd => a.seen == n_inputs && read_le(&a.data) != 0,
            Rule::Or => read_le(&a.data) != 0,
            Rule::Max | Rule::Present => true,
            Rule::Agree => a.seen == n_inputs && !a.conflict,
        })
        .map(|(ty, a)| Property { ty, data: a.data })
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

fn le_bytes(value: u64, width: usize) -> Vec<u8> {
    value.to_le_bytes()[..width.min(8)].to_vec()
}

/// Encode merged properties as a `.note.gnu.property` section body.
/// `align` is the note alignment: 8 for ELF64, 4 for ELF32.
pub fn encode(props: &[Property], align: usize) -> Vec<u8> {
    let mut desc: Vec<u8> = Vec::new();
    for p in props {
        desc.extend_from_slice(&p.ty.to_le_bytes());
        desc.extend_from_slice(&(p.data.len() as u32).to_le_bytes());
        desc.extend_from_slice(&p.data);
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
pub fn merge_section(inputs: &[Vec<&[u8]>], align: usize) -> Option<Vec<u8>> {
    let props = merge(inputs, align);
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
                .map(|&(ty, datasz, value)| Property::number(ty, datasz, value))
                .collect::<Vec<_>>(),
            8,
        )
    }

    /// One note section per entry of `notes`, then `n_inputs` total
    /// inputs: the rest carry no property section at all.
    fn merged(notes: &[Vec<u8>], n_inputs: usize) -> Vec<(u32, u64)> {
        let mut inputs: Vec<Vec<&[u8]>> = notes.iter().map(|n| alloc::vec![n.as_slice()]).collect();
        inputs.resize(n_inputs, Vec::new());
        merge(&inputs, 8)
            .into_iter()
            .map(|p| (p.ty, read_le(&p.data)))
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

    /// A type in no defined range has no combination rule, so the
    /// inputs' agreement is the only result that claims nothing an
    /// input withholds.
    #[test]
    fn a_type_outside_every_defined_range_survives_when_every_input_agrees() {
        // The unknown type sits first, so a walk that stopped there
        // would lose the AND property behind it.
        let a = note(&[(0x10, 4, 0xaabb_ccdd), (X86_FEATURE_1_AND, 4, 0x3)]);
        let b = note(&[(0x10, 4, 0xaabb_ccdd), (X86_FEATURE_1_AND, 4, 0x3)]);
        assert_eq!(
            merged(&[a, b], 2),
            [(0x10, 0xaabb_ccdd), (X86_FEATURE_1_AND, 0x3)]
        );
    }

    #[test]
    fn a_type_outside_every_defined_range_is_dropped_when_the_inputs_disagree() {
        let a = note(&[(0x10, 4, 0xaabb_ccdd), (X86_FEATURE_1_AND, 4, 0x3)]);
        let b = note(&[(0x10, 4, 0x1122_3344), (X86_FEATURE_1_AND, 4, 0x3)]);
        assert_eq!(merged(&[a, b], 2), [(X86_FEATURE_1_AND, 0x3)]);
    }

    #[test]
    fn a_type_outside_every_defined_range_is_dropped_when_an_input_omits_it() {
        let a = note(&[(0x10, 4, 0xaabb_ccdd)]);
        let b = note(&[(X86_FEATURE_1_AND, 4, 0x3)]);
        assert_eq!(merged(&[a, b], 2), []);
    }

    /// An unknown type's payload is passed through, not read as a
    /// number: no rule here interprets it.
    #[test]
    fn an_unknown_type_keeps_a_payload_wider_than_a_number() {
        let wide = Property {
            ty: 0x10,
            data: (0u8..16).collect(),
        };
        let a = encode(&[wide], 8);
        let props = merge(&[alloc::vec![a.as_slice()], alloc::vec![a.as_slice()]], 8);
        assert_eq!(props.len(), 1);
        assert_eq!(props[0].data, (0u8..16).collect::<Vec<u8>>());
    }

    #[test]
    fn a_payload_wider_than_the_type_allows_is_dropped() {
        // Emitting it would claim a `pr_datasz` the merged value
        // cannot fill. The property behind it still merges.
        let wide = Property {
            ty: X86_FEATURE_1_AND,
            data: alloc::vec![3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        };
        let mut a = encode(&[wide], 8);
        a.extend_from_slice(&note(&[(X86_ISA_1_USED, 4, 0x1)]));
        let b = note(&[(X86_FEATURE_1_AND, 4, 0x3), (X86_ISA_1_USED, 4, 0x1)]);
        assert_eq!(merged(&[a, b], 2), [(X86_ISA_1_USED, 0x1)]);
    }

    #[test]
    fn an_unknown_proc_specific_type_merges_by_its_range() {
        // No name for it here, but it is in the AND range, so it
        // intersects rather than being passed through.
        let a = note(&[(0xc000_0042, 4, 0x1122_3344)]);
        let b = note(&[(0xc000_0042, 4, 0x5566_7788)]);
        assert_eq!(merged(&[a, b], 2), [(0xc000_0042, 0x1122_3300)]);
    }

    /// One input repeating a type claims it once, not once per note:
    /// the all-input rules count inputs.
    #[test]
    fn a_type_an_input_repeats_counts_once_against_the_all_input_rules() {
        let mut twice = note(&[(X86_FEATURE_1_AND, 4, 0x1)]);
        twice.extend_from_slice(&note(&[(X86_FEATURE_1_AND, 4, 0x2)]));
        let other = note(&[(X86_FEATURE_1_AND, 4, 0x3)]);
        // Within the input the two notes union to IBT|SHSTK, which
        // then intersects with the other input's.
        assert_eq!(
            merge(
                &[alloc::vec![twice.as_slice()], alloc::vec![other.as_slice()]],
                8
            )
            .into_iter()
            .map(|p| (p.ty, read_le(&p.data)))
            .collect::<Vec<_>>(),
            [(X86_FEATURE_1_AND, 0x3)]
        );
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
                Property::number(X86_FEATURE_2_USED, 4, 0x9),
                Property::number(X86_ISA_1_USED, 4, 0x1),
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
