//! ELF object-attribute sections, merged per tag.
//!
//! Layout: the format-version byte `A`, then subsections, each a
//! `uint32` length covering itself, a NUL-terminated vendor name and
//! the vendor data. AArch64 vendor data is a comprehension byte (0
//! required, 1 optional), a value-type byte (0 ULEB128, 1 NTBS), then
//! tag/value pairs with ULEB128 tags. A concatenation of the inputs'
//! sections is not a section: a reader takes the first subsection
//! length and rejects what follows it.

#![cfg(feature = "std")]

use alloc::borrow::ToOwned;
use alloc::collections::{BTreeMap, BTreeSet};
use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

use super::relocatable::EM_AARCH64;

pub const SHT_GNU_ATTRIBUTES: u32 = 0x6fff_fff5;
/// `SHT_ARM_ATTRIBUTES` / `SHT_AARCH64_ATTRIBUTES`, the same value.
pub const SHT_ARCH_ATTRIBUTES: u32 = 0x7000_0003;

const FORMAT_VERSION: u8 = b'A';
const FEATURE_AND_BITS: &str = "aeabi_feature_and_bits";
const PAUTHABI: &str = "aeabi_pauthabi";

pub fn is_attributes_section(sh_type: u32) -> bool {
    matches!(sh_type, SHT_GNU_ATTRIBUTES | SHT_ARCH_ATTRIBUTES)
}

/// One input's section body, `None` where the input has no such
/// section, paired with the input's name for diagnostics.
pub type Input<'a> = (&'a str, Option<&'a [u8]>);

/// The layout of a section body, hence which merge rules apply.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum Format {
    /// AArch64 build attributes: vendor subsections with per-tag rules.
    Aarch64,
    /// A layout with no rules implemented here.
    Opaque,
}

pub fn format_for(machine: u16, sh_type: u32) -> Format {
    if machine == EM_AARCH64 && sh_type == SHT_ARCH_ATTRIBUTES {
        Format::Aarch64
    } else {
        Format::Opaque
    }
}

#[derive(Clone, PartialEq, Eq, Debug)]
enum Value {
    Num(u64),
    Str(String),
}

/// How a subsection's tags combine across inputs.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Rule {
    /// Bitwise AND per tag; an input without the tag contributes zero,
    /// so a feature holds only where every input claims it.
    And,
    /// Every input carries the subsection with the same tags and
    /// values; anything else has no combined result.
    Match,
}

#[derive(Clone, PartialEq, Eq, Debug)]
struct Sub {
    optional: bool,
    ntbs: bool,
    tags: BTreeMap<u64, Value>,
}

/// The rule for a vendor subsection and the phrase naming its source.
/// A vendor with no rule here merges only where the inputs agree:
/// absent one, no combination of differing values is defined, and
/// picking an input's would claim what the others do not.
fn rule_for(vendor: &str) -> (Rule, &'static str) {
    match vendor {
        FEATURE_AND_BITS => (Rule::And, "the subsection AND-s its tags across inputs"),
        PAUTHABI => (
            Rule::Match,
            "the subsection is required and must match across inputs",
        ),
        _ => (Rule::Match, "the subsection has no defined merge rule"),
    }
}

/// The ABI's comprehension and value type for a named subsection.
fn abi_shape(vendor: &str) -> Option<(bool, bool)> {
    match vendor {
        FEATURE_AND_BITS => Some((true, false)),
        PAUTHABI => Some((false, false)),
        _ => None,
    }
}

fn tag_name(vendor: &str, tag: u64) -> String {
    let named = match (vendor, tag) {
        (FEATURE_AND_BITS, 0) => "Tag_Feature_BTI",
        (FEATURE_AND_BITS, 1) => "Tag_Feature_PAC",
        (FEATURE_AND_BITS, 2) => "Tag_Feature_GCS",
        (PAUTHABI, 1) => "Tag_PAuth_Platform",
        (PAUTHABI, 2) => "Tag_PAuth_Schema",
        _ => return format!("tag {tag}"),
    };
    format!("tag {named}")
}

fn shape_name(optional: bool, ntbs: bool) -> String {
    let comprehension = if optional { "optional" } else { "required" };
    let ty = if ntbs { "NTBS" } else { "ULEB128" };
    format!("{comprehension}/{ty}")
}

fn show(v: &Value) -> String {
    match v {
        Value::Num(n) => format!("{n:#x}"),
        Value::Str(s) => format!("`{s}'"),
    }
}

/// Merge one attribute section across every input of the link.
/// `Ok(None)`: no input carries the section.
pub fn merge(name: &str, fmt: Format, inputs: &[Input]) -> Result<Option<Vec<u8>>, String> {
    let present: Vec<(&str, &[u8])> = inputs
        .iter()
        .filter_map(|&(s, b)| b.map(|b| (s, b)))
        .collect();
    let Some(&(first_src, first)) = present.first() else {
        return Ok(None);
    };
    let agree = present.iter().all(|&(_, b)| b == first);
    // Every input carrying the same body needs no rule to combine.
    if agree && present.len() == inputs.len() {
        return Ok(Some(first.to_vec()));
    }
    match fmt {
        Format::Aarch64 => merge_aarch64(name, inputs).map(Some),
        Format::Opaque => match present.iter().find(|&&(_, b)| b != first) {
            Some(&(src, _)) => Err(format!(
                "{src}: `{name}' disagrees with {first_src}'s and this layout has no per-tag merge rule"
            )),
            None => Ok(Some(first.to_vec())),
        },
    }
}

fn merge_aarch64(name: &str, inputs: &[Input]) -> Result<Vec<u8>, String> {
    let mut parsed: Vec<(&str, BTreeMap<String, Sub>)> = Vec::new();
    for &(src, body) in inputs {
        let subs = match body {
            Some(b) => parse(b).map_err(|e| format!("{src}: `{name}': {e}"))?,
            None => BTreeMap::new(),
        };
        parsed.push((src, subs));
    }
    let vendors: BTreeSet<&str> = parsed
        .iter()
        .flat_map(|(_, subs)| subs.keys().map(String::as_str))
        .collect();
    let mut out: BTreeMap<&str, Sub> = BTreeMap::new();
    for vendor in vendors {
        out.insert(vendor, merge_sub(name, vendor, &parsed)?);
    }
    Ok(encode(&out))
}

fn merge_sub(
    name: &str,
    vendor: &str,
    parsed: &[(&str, BTreeMap<String, Sub>)],
) -> Result<Sub, String> {
    let (rule, reason) = rule_for(vendor);
    let mut shape: Option<(&str, bool, bool)> = None;
    for &(src, ref subs) in parsed {
        let Some(sub) = subs.get(vendor) else {
            continue;
        };
        if let Some((want_optional, want_ntbs)) = abi_shape(vendor)
            && (sub.optional, sub.ntbs) != (want_optional, want_ntbs)
        {
            return Err(format!(
                "{src}: `{name}' `{vendor}' is {} where the ABI defines {}",
                shape_name(sub.optional, sub.ntbs),
                shape_name(want_optional, want_ntbs)
            ));
        }
        match shape {
            None => shape = Some((src, sub.optional, sub.ntbs)),
            Some((other, optional, ntbs)) if (optional, ntbs) != (sub.optional, sub.ntbs) => {
                return Err(format!(
                    "{src}: `{name}' `{vendor}' is {} where {other}'s is {}",
                    shape_name(sub.optional, sub.ntbs),
                    shape_name(optional, ntbs)
                ));
            }
            Some(_) => {}
        }
    }
    let (holder_src, optional, ntbs) = shape.expect("the vendor came from an input");
    if rule == Rule::Match
        && let Some((src, _)) = parsed.iter().find(|(_, subs)| !subs.contains_key(vendor))
    {
        return Err(format!(
            "{src}: `{name}' has no `{vendor}' subsection that {holder_src} carries; {reason}"
        ));
    }
    let tags: BTreeSet<u64> = parsed
        .iter()
        .filter_map(|(_, subs)| subs.get(vendor))
        .flat_map(|sub| sub.tags.keys().copied())
        .collect();
    let mut merged: BTreeMap<u64, Value> = BTreeMap::new();
    for tag in tags {
        let held = |subs: &'_ BTreeMap<String, Sub>| {
            subs.get(vendor).and_then(|s| s.tags.get(&tag)).cloned()
        };
        match rule {
            Rule::And => {
                let mut acc = u64::MAX;
                for &(src, ref subs) in parsed {
                    // An input withholding the subsection or the tag
                    // withholds the feature.
                    acc &= match held(subs) {
                        None => 0,
                        Some(Value::Num(n)) => n,
                        Some(Value::Str(_)) => {
                            return Err(format!(
                                "{src}: `{name}' `{vendor}' {} holds a string, which does not AND",
                                tag_name(vendor, tag)
                            ));
                        }
                    };
                }
                merged.insert(tag, Value::Num(acc));
            }
            Rule::Match => {
                let (holder, want) = parsed
                    .iter()
                    .find_map(|(src, subs)| held(subs).map(|v| (*src, v)))
                    .expect("the tag came from an input");
                for &(src, ref subs) in parsed {
                    match held(subs) {
                        Some(v) if v == want => {}
                        Some(v) => {
                            return Err(format!(
                                "{src}: `{name}' `{vendor}' {} is {} where {holder}'s is {}; {reason}",
                                tag_name(vendor, tag),
                                show(&v),
                                show(&want)
                            ));
                        }
                        None => {
                            return Err(format!(
                                "{src}: `{name}' has no `{vendor}' {} that {holder} carries; {reason}",
                                tag_name(vendor, tag)
                            ));
                        }
                    }
                }
                merged.insert(tag, want);
            }
        }
    }
    Ok(Sub {
        optional,
        ntbs,
        tags: merged,
    })
}

fn parse(body: &[u8]) -> Result<BTreeMap<String, Sub>, String> {
    if body.first() != Some(&FORMAT_VERSION) {
        return Err("the format version is not `A'".to_string());
    }
    let mut out: BTreeMap<String, Sub> = BTreeMap::new();
    let mut off = 1usize;
    while off < body.len() {
        let Some(len) = body
            .get(off..off + 4)
            .map(|b| u32::from_le_bytes(b.try_into().unwrap()) as usize)
        else {
            return Err(format!("a subsection length is truncated at offset {off}"));
        };
        if len < 4 || off + len > body.len() {
            return Err(format!(
                "the subsection at offset {off} claims {len} bytes, past the section"
            ));
        }
        let sub = &body[off + 4..off + len];
        let nul = sub
            .iter()
            .position(|&b| b == 0)
            .ok_or_else(|| format!("the vendor name at offset {off} is unterminated"))?;
        let vendor = core::str::from_utf8(&sub[..nul])
            .map_err(|_| format!("the vendor name at offset {off} is not UTF-8"))?
            .to_owned();
        let data = &sub[nul + 1..];
        let (&optional, data) = data
            .split_first()
            .ok_or_else(|| format!("`{vendor}' has no comprehension byte"))?;
        let (&ty, data) = data
            .split_first()
            .ok_or_else(|| format!("`{vendor}' has no value-type byte"))?;
        let ntbs = match ty {
            0 => false,
            1 => true,
            other => return Err(format!("`{vendor}' has value type {other}")),
        };
        let mut tags: BTreeMap<u64, Value> = BTreeMap::new();
        let mut at = 0usize;
        while at < data.len() {
            let tag = read_uleb(data, &mut at)
                .ok_or_else(|| format!("`{vendor}' has a malformed tag"))?;
            let value = if ntbs {
                let end = data[at..]
                    .iter()
                    .position(|&b| b == 0)
                    .ok_or_else(|| format!("`{vendor}' has an unterminated string value"))?;
                let s = core::str::from_utf8(&data[at..at + end])
                    .map_err(|_| format!("`{vendor}' has a string value that is not UTF-8"))?;
                at += end + 1;
                Value::Str(s.to_owned())
            } else {
                Value::Num(
                    read_uleb(data, &mut at)
                        .ok_or_else(|| format!("`{vendor}' has a malformed value"))?,
                )
            };
            tags.insert(tag, value);
        }
        out.insert(
            vendor,
            Sub {
                optional: optional != 0,
                ntbs,
                tags,
            },
        );
        off += len;
    }
    Ok(out)
}

fn encode(subs: &BTreeMap<&str, Sub>) -> Vec<u8> {
    let mut out = alloc::vec![FORMAT_VERSION];
    for (vendor, sub) in subs {
        let mut data: Vec<u8> = Vec::new();
        data.extend_from_slice(vendor.as_bytes());
        data.push(0);
        data.push(u8::from(sub.optional));
        data.push(u8::from(sub.ntbs));
        for (&tag, value) in &sub.tags {
            push_uleb(&mut data, tag);
            match value {
                Value::Num(n) => push_uleb(&mut data, *n),
                Value::Str(s) => {
                    data.extend_from_slice(s.as_bytes());
                    data.push(0);
                }
            }
        }
        out.extend_from_slice(&((data.len() + 4) as u32).to_le_bytes());
        out.extend_from_slice(&data);
    }
    out
}

fn read_uleb(b: &[u8], off: &mut usize) -> Option<u64> {
    let mut v = 0u64;
    let mut shift = 0u32;
    loop {
        let byte = *b.get(*off)?;
        *off += 1;
        v |= u64::from(byte & 0x7f).checked_shl(shift)?;
        if byte & 0x80 == 0 {
            return Some(v);
        }
        shift += 7;
    }
}

fn push_uleb(out: &mut Vec<u8>, mut v: u64) {
    loop {
        let byte = (v & 0x7f) as u8;
        v >>= 7;
        if v == 0 {
            out.push(byte);
            return;
        }
        out.push(byte | 0x80);
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    /// One subsection: vendor, comprehension, tag/value pairs.
    type SubSpec<'a> = (&'a str, bool, &'a [(u64, u64)]);

    /// One AArch64 build-attributes body.
    fn body(subs: &[SubSpec]) -> Vec<u8> {
        let map: BTreeMap<&str, Sub> = subs
            .iter()
            .map(|&(vendor, optional, tags)| {
                (
                    vendor,
                    Sub {
                        optional,
                        ntbs: false,
                        tags: tags.iter().map(|&(t, v)| (t, Value::Num(v))).collect(),
                    },
                )
            })
            .collect();
        encode(&map)
    }

    fn merge_all(bodies: &[Option<Vec<u8>>]) -> Result<Option<Vec<u8>>, String> {
        let names = ["a.o", "b.o", "c.o", "d.o"];
        let inputs: Vec<Input> = bodies
            .iter()
            .enumerate()
            .map(|(i, b)| (names[i], b.as_deref()))
            .collect();
        merge(".ARM.attributes", Format::Aarch64, &inputs)
    }

    /// The bytes `ld -r` produces for two objects claiming BTI|PAC and
    /// BTI|GCS: one subsection, each tag AND-ed.
    #[test]
    fn feature_bits_and_across_inputs() {
        let a = body(&[(FEATURE_AND_BITS, true, &[(0, 1), (1, 1), (2, 0)])]);
        let b = body(&[(FEATURE_AND_BITS, true, &[(0, 1), (1, 0), (2, 1)])]);
        assert_eq!(
            merge_all(&[Some(a), Some(b)]).unwrap().unwrap(),
            [
                b'A', 0x23, 0, 0, 0, //
                b'a', b'e', b'a', b'b', b'i', b'_', b'f', b'e', b'a', b't', b'u', b'r', b'e', b'_',
                b'a', b'n', b'd', b'_', b'b', b'i', b't', b's', 0, //
                0x01, 0x00, 0x00, 0x01, 0x01, 0x00, 0x02, 0x00,
            ]
        );
    }

    #[test]
    fn an_input_without_the_section_withholds_every_feature_bit() {
        let a = body(&[(FEATURE_AND_BITS, true, &[(0, 1), (1, 1)])]);
        assert_eq!(
            merge_all(&[Some(a), None]).unwrap().unwrap(),
            body(&[(FEATURE_AND_BITS, true, &[(0, 0), (1, 0)])])
        );
    }

    #[test]
    fn feature_tags_union_and_a_tag_an_input_omits_lands_at_zero() {
        let a = body(&[(FEATURE_AND_BITS, true, &[(2, 1)])]);
        let b = body(&[(FEATURE_AND_BITS, true, &[(0, 1)])]);
        assert_eq!(
            merge_all(&[Some(a), Some(b)]).unwrap().unwrap(),
            body(&[(FEATURE_AND_BITS, true, &[(0, 0), (2, 0)])])
        );
    }

    /// A tag the ABI has not defined still AND-s: the subsection, not
    /// the tag, carries the rule, and AND cannot claim what no input
    /// claims.
    #[test]
    fn an_undefined_tag_in_the_and_subsection_still_ands() {
        let a = body(&[(FEATURE_AND_BITS, true, &[(9, 0b110)])]);
        let b = body(&[(FEATURE_AND_BITS, true, &[(9, 0b011)])]);
        assert_eq!(
            merge_all(&[Some(a), Some(b)]).unwrap().unwrap(),
            body(&[(FEATURE_AND_BITS, true, &[(9, 0b010)])])
        );
    }

    #[test]
    fn subsections_merge_side_by_side_in_name_order() {
        let a = body(&[
            (PAUTHABI, false, &[(1, 0), (2, 1)]),
            (FEATURE_AND_BITS, true, &[(0, 1), (1, 1)]),
        ]);
        let b = body(&[
            (PAUTHABI, false, &[(1, 0), (2, 1)]),
            (FEATURE_AND_BITS, true, &[(0, 1), (2, 1)]),
        ]);
        assert_eq!(
            merge_all(&[Some(a), Some(b)]).unwrap().unwrap(),
            body(&[
                (FEATURE_AND_BITS, true, &[(0, 1), (1, 0), (2, 0)]),
                (PAUTHABI, false, &[(1, 0), (2, 1)]),
            ])
        );
    }

    #[test]
    fn a_required_subsection_refuses_a_differing_value() {
        let a = body(&[(PAUTHABI, false, &[(1, 0), (2, 5)])]);
        let b = body(&[(PAUTHABI, false, &[(1, 0), (2, 7)])]);
        let e = merge_all(&[Some(a), Some(b)]).unwrap_err();
        assert!(
            e.contains("b.o:") && e.contains("Tag_PAuth_Schema") && e.contains("a.o"),
            "{e}"
        );
    }

    #[test]
    fn a_required_subsection_refuses_an_input_that_omits_it() {
        let a = body(&[(PAUTHABI, false, &[(1, 0), (2, 1)])]);
        let b = body(&[(FEATURE_AND_BITS, true, &[(0, 1)])]);
        let e = merge_all(&[Some(a), Some(b)]).unwrap_err();
        assert!(e.contains("b.o:") && e.contains("aeabi_pauthabi"), "{e}");
    }

    /// No rule covers the vendor, so agreement is the only combination
    /// that claims nothing an input does not.
    #[test]
    fn an_unknown_vendor_survives_when_every_input_agrees() {
        let a = body(&[("vendor_x", true, &[(7, 3)])]);
        assert_eq!(
            merge_all(&[Some(a.clone()), Some(a.clone())])
                .unwrap()
                .unwrap(),
            a
        );
    }

    #[test]
    fn an_unknown_vendor_that_disagrees_is_refused_by_tag() {
        let a = body(&[("vendor_x", true, &[(7, 3)])]);
        let b = body(&[("vendor_x", true, &[(7, 9)])]);
        let e = merge_all(&[Some(a), Some(b)]).unwrap_err();
        assert!(
            e.contains("b.o:")
                && e.contains("vendor_x")
                && e.contains("tag 7")
                && e.contains("0x3"),
            "{e}"
        );
    }

    #[test]
    fn a_comprehension_the_abi_does_not_define_is_refused() {
        let a = body(&[(FEATURE_AND_BITS, true, &[(0, 1)])]);
        let b = body(&[(FEATURE_AND_BITS, false, &[(0, 1)])]);
        let e = merge_all(&[Some(a), Some(b)]).unwrap_err();
        assert!(
            e.contains("required/ULEB128") && e.contains("optional/ULEB128"),
            "{e}"
        );
    }

    #[test]
    fn a_string_valued_subsection_round_trips_through_the_parse() {
        let mut sub = BTreeMap::new();
        sub.insert(
            "vendor_s",
            Sub {
                optional: true,
                ntbs: true,
                tags: BTreeMap::from([(1, Value::Str("v1".to_string()))]),
            },
        );
        let bytes = encode(&sub);
        let parsed = parse(&bytes).unwrap();
        assert_eq!(parsed.len(), 1);
        assert!(parsed["vendor_s"].ntbs);
        assert_eq!(parsed["vendor_s"].tags[&1], Value::Str("v1".to_string()));
    }

    #[test]
    fn a_truncated_subsection_is_reported_not_walked_past() {
        let mut bytes = body(&[(FEATURE_AND_BITS, true, &[(0, 1)])]);
        let n = bytes.len();
        bytes.truncate(n - 2);
        let e = parse(&bytes).unwrap_err();
        assert!(e.contains("past the section"), "{e}");
    }

    #[test]
    fn an_opaque_layout_keeps_one_copy_and_refuses_a_differing_one() {
        let a: &[u8] = b"\x41one";
        let b: &[u8] = b"\x41two";
        assert_eq!(
            merge(
                ".gnu.attributes",
                Format::Opaque,
                &[("a.o", Some(a)), ("b.o", Some(a))]
            )
            .unwrap()
            .unwrap(),
            a
        );
        let e = merge(
            ".gnu.attributes",
            Format::Opaque,
            &[("a.o", Some(a)), ("b.o", Some(b))],
        )
        .unwrap_err();
        assert!(e.contains("b.o:") && e.contains("a.o"), "{e}");
    }
}
