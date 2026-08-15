//! Object-file serialization: ELF, Mach-O, and PE containers plus DWARF debug
//! information. Consumes the codegen `Build` (machine code, relocations, and
//! debug/unwind metadata) and writes the target's container bytes. This module
//! depends on `c5::codegen`; codegen does not depend on it.

#[cfg(feature = "native-emit")]
pub(crate) mod dwarf;
#[cfg(feature = "native-emit")]
pub(crate) mod dwarf_reloc;
#[cfg(feature = "native-emit")]
pub(crate) mod elf;
pub(crate) mod elf_class;
#[cfg(feature = "native-emit")]
pub(crate) mod elf_reloc;
#[cfg(feature = "native-emit")]
pub(crate) mod elf_reloc_types;
#[cfg(feature = "native-emit")]
pub(crate) mod mach_o;
#[cfg(feature = "native-emit")]
pub(crate) mod pe;
pub(crate) mod section_table;
#[cfg(feature = "std")]
pub(crate) mod so_versions;
pub(crate) mod weak_undef;

#[cfg(feature = "native-emit")]
use crate::c5::error::C5Error;
#[cfg(feature = "native-emit")]
use crate::c5::program::Program;

// Codegen output-contract types the writers and the emit driver consume,
// re-exported at object level so the moved files' `super::<item>` paths resolve.
#[cfg(all(test, feature = "native-emit"))]
pub(crate) use crate::c5::codegen::lower_for;
#[cfg(feature = "native-emit")]
pub(crate) use crate::c5::codegen::{
    Abi, AddrPart, Build, CopyRelocReq, DataFixup, DwarfTextReloc, DynamicExportSection,
    ElfTpoffFixup, ElfTpoffTarget, FnUnwind, FuncFixup, GotFixup, Machine, MachoTlvDescriptor,
    MachoTlvFixup, NativeOptions, OutputKind, ResolvedImport, ResolvedImports, Target,
    TlsIndexFixup, aarch64, x86_64,
};

/// Write the runtime address of a text-targeting DWARF
/// placeholder over its preserved location in a merged DWARF
/// section. The linker leaves `r.byte_offset` cleared; the
/// writer adds `text_vmaddr` to `r.merged_text_offset` and writes
/// the matching `r.width` bytes (4 or 8) little-endian.
#[cfg(feature = "native-emit")]
pub(crate) fn apply_merged_dwarf_text_reloc(
    section_bytes: &mut [u8],
    r: &DwarfTextReloc,
    text_vmaddr: u64,
) -> Result<(), C5Error> {
    let off = r.byte_offset as usize;
    let end = off.checked_add(r.width as usize).ok_or_else(|| {
        C5Error::Compile(crate::c5::error::fmt_internal_err(&format!(
            "DWARF text reloc offset 0x{off:x} + width {} overflows",
            r.width,
        )))
    })?;
    if end > section_bytes.len() {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
            &format!(
                "DWARF text reloc past section end (offset 0x{off:x}, width {}, section length {})",
                r.width,
                section_bytes.len(),
            ),
        )));
    }
    let resolved = text_vmaddr.wrapping_add(r.merged_text_offset);
    let bytes = &resolved.to_le_bytes()[..r.width as usize];
    section_bytes[off..end].copy_from_slice(bytes);
    Ok(())
}

/// Apply a data-targeting DWARF placeholder once the writer can map a
/// merged data offset to its runtime address.
#[cfg(feature = "native-emit")]
pub(crate) fn apply_merged_dwarf_data_reloc(
    section_bytes: &mut [u8],
    r: &crate::c5::codegen::DwarfDataReloc,
    data_off_to_vaddr: &dyn Fn(u64) -> u64,
) -> Result<(), C5Error> {
    let off = r.byte_offset as usize;
    let end = off.checked_add(r.width as usize).ok_or_else(|| {
        C5Error::Compile(crate::c5::error::fmt_internal_err(&format!(
            "DWARF data reloc offset 0x{off:x} + width {} overflows",
            r.width,
        )))
    })?;
    if end > section_bytes.len() {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
            &format!(
                "DWARF data reloc past section end (offset 0x{off:x}, width {}, section length {})",
                r.width,
                section_bytes.len(),
            ),
        )));
    }
    let resolved = data_off_to_vaddr(r.merged_data_offset);
    let bytes = &resolved.to_le_bytes()[..r.width as usize];
    section_bytes[off..end].copy_from_slice(bytes);
    Ok(())
}

#[cfg(feature = "native-emit")]
pub fn emit_native(program: &Program, target: Target) -> Result<Vec<u8>, C5Error> {
    emit_native_with_options(program, target, NativeOptions::default())
}

/// Variant of [`emit_native`] that accepts user-controllable
/// [`NativeOptions`]. `options.optimize` gates the SSA optimization
/// passes (see [`NativeOptions::optimize`]).
#[cfg(feature = "native-emit")]
pub fn emit_native_with_options(
    program: &Program,
    target: Target,
    options: NativeOptions,
) -> Result<Vec<u8>, C5Error> {
    emit_native_with_options_named(program, target, options, None)
}

/// Route a single-TU final image's `#pragma binding(data ...)`
/// references through the GOT, the same way the multi-TU linker does.
///
/// The walker lowers a data-binding reference to an `Inst::ImmData` that
/// the emitter records as a [`UserExternDataRef`] -- a named undefined
/// data reference. The relocatable (`.o`) writer turns that into an
/// undefined symbol the linker later binds through the GOT; a single-TU
/// final image has no link step, so resolve it here instead: register
/// the host data symbol as a flat-namespace import and load its address
/// from the dyld-filled GOT slot, leaving an `adrp + ldr` pair for
/// [`mach_o`] to patch. Without this the reference stays an unresolved
/// `.data`-relative address and faults at runtime.
///
/// Mach-O only: ELF binds the local copy through an `R_*_COPY`
/// relocation; PE routes the reference through a loader-filled IAT
/// slot on the regular import path (`is_data_load` GOT fixups).
#[cfg(feature = "native-emit")]
fn route_single_tu_data_imports(build: &mut Build, target: Target) {
    if target != Target::MacOSAarch64 || build.output_kind == OutputKind::Relocatable {
        return;
    }
    if build.imports.data_bindings.is_empty() || build.user_extern_data_refs.is_empty() {
        return;
    }
    // (local name -> host symbol) for every data binding in scope.
    let hosts: alloc::collections::BTreeMap<String, String> = build
        .imports
        .data_bindings
        .iter()
        .map(|(l, h, _dylib)| (l.clone(), h.clone()))
        .collect();
    let mut import_for: alloc::collections::BTreeMap<String, usize> =
        alloc::collections::BTreeMap::new();
    let mut remaining = Vec::with_capacity(build.user_extern_data_refs.len());
    for r in core::mem::take(&mut build.user_extern_data_refs) {
        let Some(host) = hosts.get(&r.symbol_name) else {
            remaining.push(r);
            continue;
        };
        let idx = *import_for.entry(r.symbol_name.clone()).or_insert_with(|| {
            let i = build.imports.imports.len();
            build.imports.imports.push(ResolvedImport {
                binding_idx: i as i64,
                local_name: r.symbol_name.clone(),
                real_symbol: host.clone(),
                dylib_index: 0,
                flat_lookup: true,
                is_object: false,
                is_variadic: false,
                fixed_args: 0,
                return_type_tag: 0,
                returns_long_double: false,
                param_types: Vec::new(),
            });
            i
        });
        build.got_fixups.push(GotFixup {
            instr_offset: r.instr_offset,
            part: AddrPart::Whole,
            import_index: idx,
            is_data_load: false,
        });
    }
    build.user_extern_data_refs = remaining;
}

/// Where a label an inline-asm template defines ended up in a single-TU
/// final image: a byte offset within `Build::text` or within the data
/// image (`Build::data` plus its zero-fill tail).
#[cfg(feature = "native-emit")]
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum AsmLabelPlacement {
    Text(usize),
    Data(usize),
}

#[cfg(feature = "native-emit")]
impl AsmLabelPlacement {
    fn plus(self, delta: usize) -> Self {
        match self {
            Self::Text(o) => Self::Text(o + delta),
            Self::Data(o) => Self::Data(o + delta),
        }
    }
}

/// Place the inline-asm sections a single-TU final image references into
/// its text stream, and bind the image's references to every label the
/// templates define. The relocatable path emits each section for a real
/// link to place; a final image has no link step, so a referenced
/// section is appended to the text, its relocations resolved, and its
/// labels returned so the referring sites bind to them -- what the
/// linker does for the object path's undefined symbols.
///
/// Placement is by section flags, matching the ELF rule that maps a
/// section into a segment by its access rights. `SHF_WRITE` selects the
/// data image; every other section goes to the text stream, whose region
/// is readable as well as executable, so a code section's instructions
/// and a read-only section's payload are both valid at their label
/// addresses. Unreferenced sections keep the established final-image
/// behavior (assembled and dropped).
///
/// TODO: give the final-image writers real named-section placement, so
/// the payload lands under its own access rights instead of the
/// enclosing region's and a reference needing a load-time relocation
/// stops being a diagnostic here.
#[cfg(feature = "native-emit")]
fn fold_asm_sections(
    build: &mut Build,
    target: Target,
) -> Result<alloc::collections::BTreeMap<String, AsmLabelPlacement>, C5Error> {
    use crate::c5::codegen::ssa::emit_common::{AsmSectionTarget, align_fill_pattern};
    if build.output_kind == OutputKind::Relocatable {
        return Ok(alloc::collections::BTreeMap::new());
    }
    // A named label the template defined in the main stream is already
    // placed; it binds a same-name C reference exactly as the object
    // path's local `.text` symbol does.
    let mut label_at: alloc::collections::BTreeMap<String, AsmLabelPlacement> = build
        .asm_text_labels
        .iter()
        .map(|l| (l.name.clone(), AsmLabelPlacement::Text(l.text_offset)))
        .collect();
    let err = |m: alloc::string::String| C5Error::Compile(crate::c5::error::fmt_link_err(&m));
    // A `$LABEL` address immediate needs the link-time address of a text
    // byte. The image is position-independent, so no emit-time value is
    // correct; refuse rather than leave the encoder's placeholder.
    if let Some(r) = build.asm_text_abs_refs.first() {
        return Err(err(alloc::format!(
            "inline asm: a `$label` address immediate (text offset {}) needs a load-time \
             relocation and cannot be resolved in a single-file image; compile with `-c` and link",
            r.field_offset,
        )));
    }
    if build.asm_sections.is_empty() {
        return Ok(label_at);
    }
    // Names the image needs: the C code's extern call sites and address-of
    // / data references. Folding a section can add needs of its own (its
    // relocations), so iterate to a fixpoint.
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
        .collect();
    // A main-stream branch into a pushed section names it by index, not by
    // symbol, so seed the fold set with those sections directly.
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
                if !s.relocs.is_empty() {
                    return Err(err(alloc::format!(
                        "inline-asm section `{}`: a writable section's relocations need a \
                         load-time relocation and cannot be resolved in a single-file image; \
                         compile with `-c` and link",
                        s.name
                    )));
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
                AsmLabelPlacement::Data(at)
            } else {
                let align = s.align.max(1) as usize;
                let (pat, plen) = align_fill_pattern(None, true, is_a64);
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
    // A defined function's text offset, for a section's call into the C code.
    let func_off = |name: &str| -> Option<usize> {
        let i = build.func_names.iter().position(|n| n == name)?;
        build.pc_to_native.get(*build.func_ent_pcs.get(i)?).copied()
    };
    for &i in &folded {
        let s = &build.asm_sections[i];
        // Only a text placement reaches here: a writable section carrying
        // relocations was refused above.
        let AsmLabelPlacement::Text(base) = bases[i].expect("folded section has a base") else {
            continue;
        };
        for r in &s.relocs {
            let at = base + r.offset as usize;
            let target_off = match &r.target {
                AsmSectionTarget::Text(off) => *off,
                AsmSectionTarget::OwnSection(off) => base + *off as usize,
                AsmSectionTarget::Symbol(name) => match label_at
                    .get(name.as_str())
                    .and_then(|p| match p {
                        AsmLabelPlacement::Text(o) => Some(*o),
                        AsmLabelPlacement::Data(_) => None,
                    })
                    .or_else(|| func_off(name))
                {
                    Some(o) => o,
                    None => {
                        return Err(err(alloc::format!(
                            "undefined reference to `{name}` (inline-asm section `{}`)",
                            s.name
                        )));
                    }
                },
                other => {
                    return Err(err(alloc::format!(
                        "inline-asm section `{}`: relocation target {other:?} is not \
                         supported in a single-file image; compile with `-c` and link",
                        s.name
                    )));
                }
            };
            // The folded code and its targets share the text stream, so a
            // PC-relative field folds to a constant: S + A - P. The shared
            // patcher covers the rel32 data field and the AArch64
            // PC-relative instruction kinds; a kind it declines (an
            // absolute field, a page / lo12 form) needs a load-time
            // relocation this image cannot carry.
            let disp = target_off as i64 + r.addend - at as i64;
            let patched = crate::c5::codegen::ssa::emit_common::patch_asm_insn_field(
                &mut build.text,
                at,
                r.kind,
                r.pcrel,
                r.width,
                disp,
            )
            .map_err(|m| err(alloc::format!("inline-asm section `{}`: {m}", s.name)))?;
            if !patched {
                return Err(err(alloc::format!(
                    "inline-asm section `{}`: this relocation is not supported in a \
                     single-file image; compile with `-c` and link",
                    s.name
                )));
            }
        }
    }
    // Main-stream references to a label placed in one of those sections.
    // A PC-relative field whose target also landed in the text stream
    // folds to a constant; anything else needs a load-time relocation.
    for r in core::mem::take(&mut build.asm_section_text_refs) {
        let s = &build.asm_sections[r.section_index];
        let text_base = match (r.absolute, bases[r.section_index]) {
            (false, Some(AsmLabelPlacement::Text(b))) => b,
            _ => {
                return Err(err(alloc::format!(
                    "inline-asm section `{}`: this reference to a section label needs a \
                     load-time relocation and cannot be resolved in a single-file image; \
                     compile with `-c` and link",
                    s.name
                )));
            }
        };
        let at = r.instr_offset;
        let val = (text_base + r.section_offset as usize) as i64 + r.addend - at as i64;
        build.text[at..at + 4].copy_from_slice(&(val as i32).to_le_bytes());
    }
    // The folded sections are placed; remove them so no writer emits a copy.
    let mut keep = bases.iter().map(|b| b.is_none());
    build.asm_sections.retain(|_| keep.next().unwrap());
    Ok(label_at)
}

/// Resolve function-body inline-asm symbol-operand sites (aarch64) on a
/// single-TU final image. A page / low-12 field against a resolved target
/// becomes the writers' per-site address fixup; a PC-relative field whose
/// target landed in the text stream is patched in place. A `movw` group
/// needs the image base, and a PC-relative field cannot reach the data
/// segment before layout; both are refused toward the `-c` + link path,
/// as is a name the image does not define.
#[cfg(feature = "native-emit")]
fn resolve_single_image_asm_sym_fixups(
    program: &Program,
    build: &mut Build,
    asm_labels: &alloc::collections::BTreeMap<String, AsmLabelPlacement>,
) -> Result<(), C5Error> {
    use crate::c5::codegen::AddrPart;
    use crate::c5::codegen::ssa::emit_common::{
        AsmRelocKind, AsmSectionTarget, patch_asm_insn_field,
    };
    if build.output_kind == OutputKind::Relocatable || build.asm_sym_fixups.is_empty() {
        return Ok(());
    }
    use crate::c5::token::Token;
    let weak_names: alloc::collections::BTreeSet<&str> = program
        .symbols
        .iter()
        .filter(|s| s.is_weak && (s.is_fun_entity() || s.class == Token::Glo as i64))
        .map(|s| s.link_name())
        .collect();
    let defined_data_by_name: alloc::collections::BTreeMap<&str, i64> = {
        use crate::c5::symbol::Linkage;
        program
            .symbols
            .iter()
            .filter(|s| {
                s.class == Token::Glo as i64
                    && s.defined_here
                    && !s.is_alias
                    && !s.is_thread_local
                    && !s.name.is_empty()
                    && matches!(s.linkage, Linkage::External | Linkage::Internal)
            })
            .map(|s| (s.link_name(), s.val))
            .collect()
    };
    let err = |m: alloc::string::String| C5Error::Compile(crate::c5::error::fmt_link_err(&m));
    // Where a record's target landed; the addend is already applied.
    enum Loc {
        Text(usize),
        Data(u64),
        WeakUndef,
    }
    let records = core::mem::take(&mut build.asm_sym_fixups);
    let mut resolved: Vec<(crate::c5::codegen::AsmSymFixup, Loc)> = Vec::new();
    {
        let func_off = |name: &str| -> Option<usize> {
            let i = build.func_names.iter().position(|n| n == name)?;
            build.pc_to_native.get(*build.func_ent_pcs.get(i)?).copied()
        };
        for r in records {
            let loc = match &r.target {
                AsmSectionTarget::Data(off) => Loc::Data(off.wrapping_add_signed(r.addend)),
                AsmSectionTarget::Symbol(name) => match asm_labels.get(name.as_str()) {
                    Some(AsmLabelPlacement::Text(off)) => {
                        Loc::Text(off.wrapping_add_signed(r.addend as isize))
                    }
                    Some(AsmLabelPlacement::Data(off)) => {
                        Loc::Data((*off as u64).wrapping_add_signed(r.addend))
                    }
                    None => {
                        if let Some(off) = func_off(name.as_str()) {
                            Loc::Text(off.wrapping_add_signed(r.addend as isize))
                        } else if let Some(&val) = defined_data_by_name.get(name.as_str()) {
                            Loc::Data((val.max(0) as u64).wrapping_add_signed(r.addend))
                        } else if weak_names.contains(name.as_str()) {
                            Loc::WeakUndef
                        } else {
                            return Err(err(alloc::format!("undefined reference to `{name}`")));
                        }
                    }
                },
                other => {
                    return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                        &alloc::format!(
                            "asm operand relocation target {other:?} is not a data offset or symbol"
                        ),
                    )));
                }
            };
            resolved.push((r, loc));
        }
    }
    let refuse = |what: &str| {
        err(alloc::format!(
            "inline asm: {what} needs a load-time relocation and cannot be resolved in a \
             single-file image; compile with `-c` and link"
        ))
    };
    for (r, loc) in resolved {
        let part = match r.kind {
            AsmRelocKind::A64AdrpPage21 => Some(AddrPart::Page),
            AsmRelocKind::A64AddLo12 | AsmRelocKind::A64LdstLo12(_) => Some(AddrPart::InPage),
            _ => None,
        };
        match (part, loc) {
            (Some(part), Loc::Data(off)) => build.data_fixups.push(crate::c5::codegen::DataFixup {
                instr_offset: r.instr_offset,
                data_offset: off,
                part,
            }),
            (Some(part), Loc::Text(off)) => build.func_fixups.push(crate::c5::codegen::FuncFixup {
                instr_offset: r.instr_offset,
                target_native_offset: off,
                part,
            }),
            // An undefined weak name resolves to address 0, as the linkers
            // resolve it: the `adrp` becomes `movz rd, #0`, the `add` keeps
            // the zero base, and a load/store keeps its zero immediate over
            // the zero base.
            (Some(AddrPart::Page), Loc::WeakUndef) => {
                if !weak_undef::aarch64_adrp_to_zero(&mut build.text, r.instr_offset) {
                    return Err(refuse("a weak symbol operand"));
                }
            }
            (Some(AddrPart::InPage), Loc::WeakUndef) => {
                if matches!(r.kind, AsmRelocKind::A64AddLo12)
                    && !weak_undef::aarch64_add_lo12_to_zero(&mut build.text, r.instr_offset)
                {
                    return Err(refuse("a weak symbol operand"));
                }
            }
            (None, Loc::Text(off)) => {
                if matches!(r.kind, AsmRelocKind::A64MovwAbs { .. }) {
                    return Err(refuse("a `movz`/`movk` symbol operand"));
                }
                let disp = off as i64 - r.instr_offset as i64;
                let patched =
                    patch_asm_insn_field(&mut build.text, r.instr_offset, r.kind, true, 4, disp)
                        .map_err(|m| err(m))?;
                if !patched {
                    return Err(refuse("a symbol operand"));
                }
            }
            (None, Loc::WeakUndef)
                if matches!(r.kind, AsmRelocKind::A64Branch26 { .. })
                    && weak_undef::aarch64_branch_to_nop(&mut build.text, r.instr_offset) => {}
            (None, _) | (Some(AddrPart::Whole), _) => {
                return Err(refuse("a symbol operand"));
            }
        }
    }
    Ok(())
}

/// Resolve or diagnose the external references still recorded on a
/// single-TU final image. Such an image has no link step to bind them,
/// so leaving them as the codegen's zero-displacement placeholders
/// yields a rip-relative `lea` that materializes the address of the
/// next instruction -- a non-null pointer that faults when called.
///
/// An undefined weak reference resolves to address 0, matching the
/// linker's ELF behavior, so the `if (fn) fn();` guard idiom reads a
/// null pointer. Everything else is an undefined-reference diagnostic.
/// `#pragma binding(data ...)` locals are excluded: the per-format
/// writer binds those through the GOT / a copy relocation.
#[cfg(feature = "native-emit")]
fn resolve_single_tu_extern_refs(
    program: &Program,
    build: &mut Build,
    target: Target,
    asm_labels: &alloc::collections::BTreeMap<String, AsmLabelPlacement>,
) -> Result<(), C5Error> {
    if build.output_kind == OutputKind::Relocatable
        || (build.user_extern_data_refs.is_empty() && build.user_extern_call_sites.is_empty())
    {
        return Ok(());
    }
    use crate::c5::token::Token;
    let weak_names: alloc::collections::BTreeSet<&str> = program
        .symbols
        .iter()
        .filter(|s| s.is_weak && (s.is_fun_entity() || s.class == Token::Glo as i64))
        .map(|s| s.link_name())
        .collect();
    // Data objects this unit defines, by name and unified data offset --
    // the set the object writer binds named relocations against. An
    // inline-asm `sym(%rip)` reference records the symbol by name, so the
    // image finalizer needs the same lookup.
    let defined_data_by_name: alloc::collections::BTreeMap<&str, i64> = {
        use crate::c5::symbol::Linkage;
        program
            .symbols
            .iter()
            .filter(|s| {
                s.class == Token::Glo as i64
                    && s.defined_here
                    && !s.is_alias
                    && !s.is_thread_local
                    && !s.name.is_empty()
                    && matches!(s.linkage, Linkage::External | Linkage::Internal)
            })
            .map(|s| (s.link_name(), s.val))
            .collect()
    };
    let data_bindings: alloc::collections::BTreeSet<&str> = build
        .imports
        .data_bindings
        .iter()
        .map(|(local, _host, _dylib)| local.as_str())
        .collect();
    let machine = match target {
        Target::LinuxX64 | Target::WindowsX64 => Machine::X86_64,
        Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64 => Machine::Aarch64,
    };
    let undefined = |name: &str| -> C5Error {
        C5Error::Compile(crate::c5::error::fmt_link_err(&format!(
            "undefined reference to `{name}`",
        )))
    };
    let unsupported = |name: &str| -> C5Error {
        C5Error::Compile(crate::c5::error::fmt_link_err(&format!(
            "unresolved weak reference to `{name}`: cannot resolve the referencing instruction to address 0",
        )))
    };

    let mut kept_data = Vec::new();
    for r in core::mem::take(&mut build.user_extern_data_refs) {
        if data_bindings.contains(r.symbol_name.as_str()) {
            kept_data.push(r);
            continue;
        }
        // A label an inline-asm template defines: the reference takes the
        // address-load patch of the region the label landed in, as the
        // linker binds the object path's reference against the label. The
        // `direct_pcrel` addend folded the 4-byte end skew; a fixup targets
        // the effective byte, so restore it.
        if let Some(&placement) = asm_labels.get(r.symbol_name.as_str()) {
            let delta = r.direct_pcrel.map_or(0, |a| a + 4);
            match placement {
                AsmLabelPlacement::Text(off) => {
                    build.func_fixups.push(crate::c5::codegen::FuncFixup {
                        instr_offset: r.instr_offset,
                        target_native_offset: (off as i64 + delta) as usize,
                        part: AddrPart::Whole,
                    })
                }
                AsmLabelPlacement::Data(off) => {
                    build.data_fixups.push(crate::c5::codegen::DataFixup {
                        instr_offset: r.instr_offset,
                        data_offset: (off as i64 + delta) as u64,
                        part: AddrPart::Whole,
                    })
                }
            }
            continue;
        }
        // A data object this unit defines (weak included): the reference
        // binds to the definition, as the linker binds the object path's
        // named relocation. The PC-relative addend folded the -4 end skew;
        // the data fixup targets the effective byte, so restore it.
        if let (Some(&off), Some(addend)) = (
            defined_data_by_name.get(r.symbol_name.as_str()),
            r.direct_pcrel,
        ) {
            build.data_fixups.push(crate::c5::codegen::DataFixup {
                instr_offset: r.instr_offset,
                data_offset: (off + addend + 4) as u64,
                part: AddrPart::Whole,
            });
            continue;
        }
        if !weak_names.contains(r.symbol_name.as_str()) {
            return Err(undefined(&r.symbol_name));
        }
        let ok = match machine {
            Machine::X86_64 => weak_undef::x86_64_lea_to_zero(&mut build.text, r.instr_offset),
            Machine::Aarch64 => {
                weak_undef::aarch64_adrp_to_zero(&mut build.text, r.instr_offset)
                    && weak_undef::aarch64_add_lo12_to_zero(&mut build.text, r.instr_offset + 4)
            }
        };
        if !ok {
            return Err(unsupported(&r.symbol_name));
        }
    }
    build.user_extern_data_refs = kept_data;

    for site in core::mem::take(&mut build.user_extern_call_sites) {
        // A callee defined as a label in the text stream (the main stream
        // or a folded asm section): bind the call directly, as the linker
        // binds the object path's undefined symbol against the label.
        if let Some(&AsmLabelPlacement::Text(target_off)) =
            asm_labels.get(site.symbol_name.as_str())
        {
            let at = site.instr_offset;
            match machine {
                // `call`/`jmp` rel32: the displacement field is at +1.
                Machine::X86_64 => {
                    let rel = target_off as i64 - (at as i64 + 5);
                    build.text[at + 1..at + 5].copy_from_slice(&(rel as i32).to_le_bytes());
                }
                // `bl`/`b` imm26, word-aligned.
                Machine::Aarch64 => {
                    let word = u32::from_le_bytes(build.text[at..at + 4].try_into().unwrap());
                    let imm = (((target_off as i64 - at as i64) >> 2) as u32) & 0x03FF_FFFF;
                    let patched = (word & 0xFC00_0000) | imm;
                    build.text[at..at + 4].copy_from_slice(&patched.to_le_bytes());
                }
            }
            continue;
        }
        if !weak_names.contains(site.symbol_name.as_str()) {
            return Err(undefined(&site.symbol_name));
        }
        let ok = match machine {
            Machine::X86_64 => weak_undef::x86_64_branch_to_nop(&mut build.text, site.instr_offset),
            Machine::Aarch64 => {
                weak_undef::aarch64_branch_to_nop(&mut build.text, site.instr_offset)
            }
        };
        if !ok {
            return Err(unsupported(&site.symbol_name));
        }
    }
    Ok(())
}

/// Whether `BADC_NO_BSS_SEGREGATE` opts a build out of segregating
/// wholly-zero data objects into a no-file-backing `.bss` region. The
/// opt-out exists for debugging and for diffing against the pre-`.bss`
/// file image; segregation is otherwise on by default.
#[cfg(feature = "native-emit")]
fn bss_segregation_disabled() -> bool {
    std::env::var("BADC_NO_BSS_SEGREGATE").is_ok()
}

/// Variant of [`emit_native_with_options`] that records the shared
/// library's own name in the image (PE export-directory Name, Mach-O
/// `LC_ID_DYLIB` install name) so a consumer linking against it by name
/// references the file it loads at runtime. `shared_lib_name` is the
/// `-o` basename for `--shared`; `None` falls back to the per-format
/// default and is ignored for non-shared output.
#[cfg(feature = "native-emit")]
pub fn emit_native_with_options_named(
    program: &Program,
    target: Target,
    options: NativeOptions,
    shared_lib_name: Option<&str>,
) -> Result<Vec<u8>, C5Error> {
    let (compacted, bss_size, mut build) = compact_and_lower(program, target, options)?;
    let program = &compacted;
    build.bss_size = bss_size;
    route_single_tu_data_imports(&mut build, target);
    let asm_labels = fold_asm_sections(&mut build, target)?;
    resolve_single_image_asm_sym_fixups(program, &mut build, &asm_labels)?;
    resolve_single_tu_extern_refs(program, &mut build, target, &asm_labels)?;
    if options.output_kind == OutputKind::SharedLibrary {
        build.shared_lib_name = shared_lib_name.map(alloc::string::String::from);
    }
    write_for(program, &build, target)
}

/// C99 6.2.2 / 6.7.8: drop static data no surviving function or
/// relocation references, repacking `.data` and rewriting every offset
/// surface (symbol values, AST data offsets, relocation slots), then
/// lower the result. The one compaction feeds both the backend lowering
/// (which bakes data-relative fixups) and the container writer (which
/// emits the symbol table), so the emitted `.data` and its symbols stay
/// consistent.
///
/// The compaction runs before lowering, so its call graph is the
/// pre-inline one. At -O the pipeline can orphan an object -- an address
/// materialised only to pass to a callee that ignores the parameter dies
/// with the call the inliner removed -- and the lowering reports it. The
/// program is then compacted once more, from the original, with the
/// sharper set, and the reported post-inline bodies lower against it, so
/// the object, its relocations, and any symbol only they referenced stay
/// out of the image. The second pass is the fixed point: the report is a
/// joint function + data reachability result and the repack maps every
/// reference one-to-one. The assertion below checks that.
///
/// Only the report survives that first lowering -- the code it emits is
/// against the `.data` the recompaction replaces -- so the first pass
/// runs as a probe and stops there, leaving one backend run either way.
/// It probes only when the compaction produced a plan to replay the
/// report against. A compaction that declined (a unit with no function
/// to walk, an empty `.data`) has nothing to narrow, and a probe that
/// stopped anyway would leave the writer a `Build` with no image.
#[cfg(feature = "native-emit")]
fn compact_and_lower(
    program: &Program,
    target: Target,
    options: NativeOptions,
) -> Result<(Program, i64, Build), C5Error> {
    use crate::c5::codegen::LowerMode;
    use crate::c5::codegen::ssa::shadow;
    let segregate = options.bss_segregate && !bss_segregation_disabled();
    let first = shadow::compact_program_data(program, target, segregate, options.optimize)?;
    let mode = match first.plan {
        Some(_) => LowerMode::DataLivenessProbe,
        None => LowerMode::Full,
    };
    let mut build =
        crate::c5::codegen::lower_for_with_prebuilt(&first.program, target, options, None, mode)?;
    let (Some(mut orphaned), Some(plan)) = (build.orphaned_data.take(), first.plan.as_ref()) else {
        assert!(
            !build.stopped_at_data_liveness,
            "a stopped probe carries no image and cannot be the emitted build",
        );
        crate::c5::codegen::emit_ssa_dump(&mut build);
        return Ok((first.program, first.bss_size, build));
    };
    let (recompacted, bss_size) =
        shadow::recompact_after_inlining(program, plan, &mut orphaned, segregate);
    let mut build = crate::c5::codegen::lower_for_with_prebuilt(
        &recompacted,
        target,
        options,
        Some(orphaned.ssa),
        crate::c5::codegen::LowerMode::Full,
    )?;
    crate::c5::codegen::emit_ssa_dump(&mut build);
    debug_assert!(
        build.orphaned_data.is_none(),
        "data liveness did not converge after recompaction",
    );
    Ok((recompacted, bss_size, build))
}

/// Test-only: emit a complete native image for a single program,
/// satisfying the PE entry stub's `__c5_*` runtime-helper references
/// that the bare single-TU path cannot link (production links them
/// from the embedded startup runtime). The injected symbols point at
/// the program entry; the image is inspected for structure, not run.
/// ELF / Mach-O ignore the extra names.
#[cfg(all(test, feature = "native-emit"))]
pub(crate) fn emit_native_single_tu_for_test(
    program: &Program,
    target: Target,
    options: NativeOptions,
) -> Result<alloc::vec::Vec<u8>, C5Error> {
    let (compacted, bss_size, mut build) = compact_and_lower(program, target, options)?;
    let program = &compacted;
    build.bss_size = bss_size;
    let pc = build.pc_to_native.len();
    build.pc_to_native.push(build.entry_offset);
    // The entry adapter targets `__c5_entry`; the real link path
    // supplies it from the startup runtime.
    build
        .func_names
        .push(alloc::string::String::from("__c5_entry"));
    build.func_ent_pcs.push(pc);
    write_for(program, &build, target)
}

#[cfg(all(feature = "full", feature = "std"))]
pub(crate) fn write_native_image(
    program: &Program,
    build: &Build,
    target: Target,
) -> Result<Vec<u8>, C5Error> {
    write_for(program, build, target)
}

#[cfg(feature = "native-emit")]
fn write_for(program: &Program, build: &Build, target: Target) -> Result<Vec<u8>, C5Error> {
    #[cfg(feature = "std")]
    if build.output_kind == OutputKind::Relocatable {
        // ELF64 ET_REL is the badc-internal relocatable format on
        // every target -- single writer, single reloc table. The
        // final executable still comes out in the target's native
        // container (Mach-O / ELF / PE) at link time.
        let machine = match target {
            Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64 => {
                Machine::Aarch64
            }
            Target::LinuxX64 | Target::WindowsX64 => Machine::X86_64,
        };
        return elf_reloc::write_relocatable(program, build, machine, target);
    }
    // The no-std build can't reach the relocatable writer; the
    // `-c` path lives in the CLI, which itself is std-only. If
    // a no-std caller ever surfaces `Relocatable` it would
    // fall through to the final-image writers below; the
    // unreachable branch keeps the match arms exhaustive
    // without pulling `elf_reloc` into the no-std build.
    #[cfg(not(feature = "std"))]
    if build.output_kind == OutputKind::Relocatable {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
            "Relocatable output requires the `std` feature",
        )));
    }
    match target {
        Target::MacOSAarch64 => mach_o::write(program, build),
        Target::LinuxAarch64 => elf::write(program, build, Machine::Aarch64),
        Target::LinuxX64 => elf::write(program, build, Machine::X86_64),
        Target::WindowsX64 => pe::write(program, build, Machine::X86_64, target),
        Target::WindowsAarch64 => pe::write(program, build, Machine::Aarch64, target),
    }
}
