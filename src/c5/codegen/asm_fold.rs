//! Inline-asm sections and labels placed in a unit's own image: the
//! single-file image and the JIT, which have no link step.

use alloc::string::String;
use alloc::vec::Vec;

use super::{
    AddrPart, Build, DataFixup, DataPcRelReloc, OutputKind, Target, TextPcRelReloc, UnitDef,
    UnitDefs,
};
use crate::c5::diag::Code;
use crate::c5::error::C5Error;

/// Where a label an inline-asm template defines ended up in the unit's own
/// image: a byte offset within `Build::text` or within the data image
/// (`Build::data` plus its zero-fill tail).
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum AsmLabelPlacement {
    Text(usize),
    Data(usize),
}

impl AsmLabelPlacement {
    fn plus(self, delta: usize) -> Self {
        match self {
            Self::Text(o) => Self::Text(o + delta),
            Self::Data(o) => Self::Data(o + delta),
        }
    }

    pub(crate) fn as_def(self) -> UnitDef {
        match self {
            Self::Text(o) => UnitDef::Text(o),
            Self::Data(o) => UnitDef::Data(o as u64),
        }
    }
}

/// A 4- or 8-byte pc-relative word (`.long sym - .`), which needs no
/// load-time relocation within one image.
fn is_pcrel_word(r: &crate::c5::asm::AsmSectionReloc) -> bool {
    r.kind == crate::c5::asm::AsmRelocKind::Data && r.pcrel && matches!(r.width, 4 | 8)
}

/// The anchor, part and addend of the fixup a folded field takes when the
/// writer must place its target: an aarch64 page or in-page half.
fn image_field_fixup(
    r: &crate::c5::asm::AsmSectionReloc,
    at: usize,
) -> Option<(usize, AddrPart, i64)> {
    use crate::c5::asm::AsmRelocKind;
    match r.kind {
        AsmRelocKind::A64AdrpPage21 => Some((at, AddrPart::Page, r.addend)),
        AsmRelocKind::A64AddLo12 | AsmRelocKind::A64LdstLo12(_) => {
            Some((at, AddrPart::InPage, r.addend))
        }
        _ => None,
    }
}

/// Place the inline-asm sections the unit's own image (a single-file image,
/// the JIT) references into its text stream, and bind the image's
/// references to every label the templates define. With no link step, a referenced
/// section is appended, resolved and its labels returned. Placement
/// follows the section flags: `SHF_WRITE` selects the data image, every
/// other section the text stream, whose region is readable as well as
/// executable. An unreferenced section is assembled and dropped.
///
/// TODO: give the final-image writers real named-section placement, so
/// the payload lands under its own access rights instead of the
/// enclosing region's and a reference needing a load-time relocation
/// stops being a diagnostic here.
pub(crate) fn fold_asm_sections(
    program: &crate::c5::program::Program,
    build: &mut Build,
    target: Target,
    defs: &UnitDefs,
    path: &str,
) -> Result<alloc::collections::BTreeMap<String, AsmLabelPlacement>, C5Error> {
    use crate::c5::asm::align_fill_pattern;
    use crate::c5::asm::{AsmRelocKind, AsmSectionTarget};
    if build.output_kind == OutputKind::Relocatable {
        return Ok(alloc::collections::BTreeMap::new());
    }
    let mut label_at: alloc::collections::BTreeMap<String, AsmLabelPlacement> = build
        .asm_text_labels
        .iter()
        .map(|l| (l.name.clone(), AsmLabelPlacement::Text(l.text_offset)))
        .collect();
    let err = |code: crate::c5::diag::Code, m: alloc::string::String| C5Error::hard(code, &m);
    // A `$LABEL` address immediate needs the link-time address of a text
    // byte. The image is position-independent, so no emit-time value is
    // correct; refuse rather than leave the encoder's placeholder.
    if let Some(r) = build.asm_text_abs_refs.first() {
        return Err(err(
            Code::OBJECT_FORMAT,
            alloc::format!(
                "inline asm: a `$label` address immediate (text offset {}) needs a load-time \
             relocation and cannot be resolved in {path}; compile with `-c` and link",
                r.field_offset,
            ),
        ));
    }
    if build.asm_sections.is_empty() {
        return Ok(label_at);
    }
    // A function-pointer slot names a function no C body defines by its
    // import placeholder.
    let slot_names = (build.code_relocs.iter().chain(&build.tls_code_relocs)).filter_map(|r| {
        let at = |&&(pc, _): &&(usize, String)| pc as u64 == r.target_ent_pc;
        program
            .extern_function_imports
            .iter()
            .find(at)
            .map(|(_, n)| n.clone())
    });
    let mut needed: alloc::collections::BTreeSet<String> = build
        .user_extern_call_sites
        .iter()
        .map(|s| s.symbol_name.clone())
        .chain(
            build
                .user_extern_data_refs
                .iter()
                .map(|r| r.symbol_name.clone()),
        )
        .chain(
            build
                .extern_data_relocs
                .iter()
                .map(|r| r.symbol_name.clone()),
        )
        .chain(slot_names)
        .collect();
    let mut wanted: alloc::collections::BTreeSet<usize> = build
        .asm_section_text_refs
        .iter()
        .map(|r| r.section_index)
        .collect();
    let is_a64 = matches!(
        target,
        Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64
    );
    let mut folded: Vec<usize> = Vec::new();
    let mut bases: Vec<Option<AsmLabelPlacement>> = alloc::vec![None; build.asm_sections.len()];
    loop {
        let mut grew = false;
        for (i, s) in build.asm_sections.iter().enumerate() {
            if bases[i].is_some()
                || !(wanted.contains(&i) || s.labels.iter().any(|l| needed.contains(&l.name)))
            {
                continue;
            }
            let base = if s.flags.contains('w') {
                // The data image ends where the zero-fill range begins, so
                // its tail is the only writable byte range left to grow.
                // Materialize the zero-fill so appending cannot move a bss
                // object; the payload needs file backing regardless.
                if !s.relocs.iter().all(is_pcrel_word) {
                    return Err(err(
                        Code::OBJECT_FORMAT,
                        alloc::format!(
                            "inline-asm section `{}`: a writable section's relocations need a \
                         load-time relocation and cannot be resolved in {path}; \
                         compile with `-c` and link",
                            s.name
                        ),
                    ));
                }
                if build.bss_size > 0 {
                    let zeros = build.data.len() + build.bss_size as usize;
                    build.data.resize(zeros, 0);
                    build.bss_size = 0;
                }
                let align = s.align.max(1) as usize;
                build.data_align = build.data_align.max(align);
                while !build.data.len().is_multiple_of(align) {
                    build.data.push(0);
                }
                let at = build.data.len();
                build.data.extend_from_slice(&s.bytes);
                // A label at the section's end names a byte of the data
                // image, not the zero-fill region the writers place apart.
                if s.labels.iter().any(|l| l.offset as usize == s.bytes.len()) {
                    build.data.push(0);
                }
                AsmLabelPlacement::Data(at)
            } else {
                let align = s.align.max(1) as usize;
                let (pat, plen) =
                    align_fill_pattern(None, true, crate::c5::asm::AlignNops::of_target(is_a64));
                while !build.text.len().is_multiple_of(align) {
                    build.text.push(pat[build.text.len() % plen]);
                }
                let at = build.text.len();
                build.text.extend_from_slice(&s.bytes);
                AsmLabelPlacement::Text(at)
            };
            bases[i] = Some(base);
            folded.push(i);
            wanted.remove(&i);
            for l in &s.labels {
                label_at.insert(l.name.clone(), base.plus(l.offset as usize));
            }
            for r in &s.relocs {
                if let AsmSectionTarget::Symbol(name) = &r.target {
                    needed.insert(name.clone());
                }
            }
            grew = true;
        }
        if !grew {
            break;
        }
    }
    let mut image_fields: Vec<(UnitDef, usize, AddrPart, i64)> = Vec::new();
    for &i in &folded {
        let s = &build.asm_sections[i];
        let placed = bases[i].expect("folded section has a base");
        for r in &s.relocs {
            let def = match &r.target {
                AsmSectionTarget::Text(off) => UnitDef::Text(*off),
                AsmSectionTarget::OwnSection(off) => placed.plus(*off as usize).as_def(),
                AsmSectionTarget::Symbol(name) => match label_at
                    .get(name.as_str())
                    .map(|p| p.as_def())
                    .or_else(|| defs.get(name.as_str()).copied())
                {
                    Some(def) => def,
                    None => {
                        return Err(err(
                            Code::UNDEFINED_SYMBOL,
                            alloc::format!(
                                "undefined reference to `{name}` (inline-asm section `{}`)",
                                s.name
                            ),
                        ));
                    }
                },
                other => {
                    return Err(err(
                        Code::OBJECT_FORMAT,
                        alloc::format!(
                            "inline-asm section `{}`: relocation target {other:?} is not \
                         supported in {path}; compile with `-c` and link",
                            s.name
                        ),
                    ));
                }
            };
            // A pc-relative word in the data image holds the distance, which
            // the image writer computes once both ends have an address.
            let base = match placed {
                AsmLabelPlacement::Text(base) => base,
                AsmLabelPlacement::Data(base) => {
                    let (target_offset, target_in_data) = match def {
                        UnitDef::Text(off) => (off as u64, false),
                        UnitDef::Data(off) => (off, true),
                    };
                    build.data_pcrel_relocs.push(DataPcRelReloc {
                        slot_data_offset: (base + r.offset as usize) as u64,
                        target_offset: target_offset.wrapping_add_signed(r.addend),
                        target_anchor: target_offset,
                        target_in_data,
                        width: r.width,
                        image_relative: false,
                    });
                    continue;
                }
            };
            let at = base + r.offset as usize;
            let page_pair = matches!(
                r.kind,
                AsmRelocKind::A64AdrpPage21
                    | AsmRelocKind::A64AddLo12
                    | AsmRelocKind::A64LdstLo12(_)
            );
            let target_off = match def {
                UnitDef::Text(off) if !page_pair => off,
                // A pc-relative word naming data holds the distance, which the
                // image writer computes once the data has an address.
                UnitDef::Data(off) if is_pcrel_word(r) => {
                    build.text_pcrel_relocs.push(TextPcRelReloc {
                        site_text_offset: at as u64,
                        target_data_offset: off.wrapping_add_signed(r.addend),
                        target_anchor: off,
                        width: r.width,
                    });
                    continue;
                }
                def => {
                    let Some((instr_offset, part, addend)) = image_field_fixup(r, at) else {
                        return Err(err(
                            Code::OBJECT_FORMAT,
                            alloc::format!(
                                "inline-asm section `{}`: this reference to data needs a \
                             load-time relocation and cannot be resolved in {path}; compile \
                             with `-c` and link",
                                s.name
                            ),
                        ));
                    };
                    image_fields.push((def, instr_offset, part, addend));
                    continue;
                }
            };
            // The folded code and its targets share the text stream, so a
            // PC-relative field folds to a constant: S + A - P.
            let disp = target_off as i64 + r.addend - at as i64;
            let patched = crate::c5::asm::patch_asm_insn_field(
                &mut build.text,
                at,
                r.kind,
                r.pcrel,
                r.width,
                disp,
            )
            .map_err(|m| {
                err(
                    Code::OBJECT_FORMAT,
                    alloc::format!("inline-asm section `{}`: {m}", s.name),
                )
            })?;
            if !patched {
                return Err(err(
                    Code::OBJECT_FORMAT,
                    alloc::format!(
                        "inline-asm section `{}`: this relocation is not supported in \
                     {path}; compile with `-c` and link",
                        s.name
                    ),
                ));
            }
        }
    }
    for (def, instr_offset, part, addend) in image_fields {
        def.bind(build, instr_offset, part, addend);
    }
    for r in core::mem::take(&mut build.asm_section_text_refs) {
        let s = &build.asm_sections[r.section_index];
        let text_base = match (r.absolute, bases[r.section_index]) {
            (false, Some(AsmLabelPlacement::Text(b))) => b,
            // An x86_64 rel32 over a label the data image holds: a data
            // fixup, anchored three bytes ahead of the field it patches.
            (false, Some(AsmLabelPlacement::Data(b)))
                if r.kind == AsmRelocKind::Data && r.instr_offset >= 3 =>
            {
                build.data_fixups.push(DataFixup {
                    instr_offset: r.instr_offset - 3,
                    data_offset: (b + r.section_offset as usize) as u64,
                    addend: r.addend + 4,
                    part: AddrPart::Whole,
                });
                continue;
            }
            _ => {
                return Err(err(
                    Code::OBJECT_FORMAT,
                    alloc::format!(
                        "inline-asm section `{}`: this reference to a section label needs a \
                     load-time relocation and cannot be resolved in {path}; \
                     compile with `-c` and link",
                        s.name
                    ),
                ));
            }
        };
        let at = r.instr_offset;
        let val = (text_base + r.section_offset as usize) as i64 + r.addend - at as i64;
        // The shared patcher covers the rel32 data field and the aarch64
        // PC-relative instruction kinds; both sides landed in the text
        // stream, so the displacement is final.
        let patched =
            crate::c5::asm::patch_asm_insn_field(&mut build.text, at, r.kind, true, 4, val)
                .map_err(|m| {
                    err(
                        Code::OBJECT_FORMAT,
                        alloc::format!("inline-asm section `{}`: {m}", s.name),
                    )
                })?;
        if !patched {
            return Err(err(
                Code::OBJECT_FORMAT,
                alloc::format!(
                    "inline-asm section `{}`: this reference to a section label is not \
                 supported in {path}; compile with `-c` and link",
                    s.name
                ),
            ));
        }
    }
    // The folded sections are placed; remove them so no writer emits a
    // copy.
    let mut keep = bases.iter().map(|b| b.is_none());
    build.asm_sections.retain(|_| keep.next().unwrap());
    Ok(label_at)
}

/// Bind each extern call site naming a text label of `labels` to it; a
/// site naming no such label stays for the caller.
pub(crate) fn bind_label_calls(
    build: &mut Build,
    labels: &alloc::collections::BTreeMap<String, AsmLabelPlacement>,
    is_a64: bool,
) {
    for site in core::mem::take(&mut build.user_extern_call_sites) {
        let Some(&AsmLabelPlacement::Text(target_off)) = labels.get(site.symbol_name.as_str())
        else {
            build.user_extern_call_sites.push(site);
            continue;
        };
        let at = site.instr_offset;
        if is_a64 {
            let word = u32::from_le_bytes(build.text[at..at + 4].try_into().unwrap());
            let imm = (((target_off as i64 - at as i64) >> 2) as u32) & 0x03FF_FFFF;
            let patched = (word & 0xFC00_0000) | imm;
            build.text[at..at + 4].copy_from_slice(&patched.to_le_bytes());
        } else {
            let rel = target_off as i64 - (at as i64 + 5);
            build.text[at + 1..at + 5].copy_from_slice(&(rel as i32).to_le_bytes());
        }
    }
}
