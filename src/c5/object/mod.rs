//! Object-file serialization: ELF, Mach-O, and PE containers plus DWARF
//! debug information.

/// The version every `.debug_info` and `.debug_line` unit header the
/// emitters write carries. The driver compares a `-gdwarf-<n>` against
/// it.
///
/// TODO: DWARF 2, 3 and 5 are not emitted. Each is a different unit
/// header, form set and `.debug_line` prologue.
pub const DWARF_VERSION: u16 = 4;

/// The width of a unit length and a section offset in what the
/// emitters write, which is the 32-bit DWARF format. The driver
/// compares `-gdwarf32` / `-gdwarf64` against it.
///
/// TODO: the 64-bit format is not emitted.
pub const DWARF_FORMAT_BITS: u8 = 32;

#[cfg(feature = "native-emit")]
pub(crate) mod dwarf;
#[cfg(feature = "native-emit")]
pub(crate) mod dwarf_reloc;
#[cfg(feature = "native-emit")]
pub(crate) mod eh_frame;
#[cfg(feature = "native-emit")]
pub(crate) mod elf;
pub(crate) mod elf_class;
#[cfg(feature = "native-emit")]
pub(crate) mod elf_reloc;
#[cfg(feature = "native-emit")]
pub(crate) mod elf_reloc_types;
#[cfg(feature = "native-emit")]
pub(crate) mod image;
#[cfg(feature = "native-emit")]
pub(crate) mod mach_o;
#[cfg(feature = "native-emit")]
pub(crate) mod pe;
#[cfg(feature = "native-emit")]
pub(crate) mod relr;
pub(crate) mod section_table;
#[cfg(feature = "native-emit")]
pub(crate) mod sha1;
#[cfg(feature = "std")]
pub(crate) mod so_versions;
#[cfg(feature = "std")]
pub(crate) mod strtab;
#[cfg(feature = "native-emit")]
pub(crate) mod unwind_info;
pub(crate) mod weak_undef;
#[cfg(feature = "native-emit")]
pub(crate) mod xxh3;

#[cfg(feature = "native-emit")]
use crate::c5::diag::Code;
#[cfg(feature = "native-emit")]
use crate::c5::error::C5Error;
#[cfg(feature = "native-emit")]
use crate::c5::program::Program;

// Codegen output-contract types the writers and the emit driver consume,
// re-exported at object level so the moved files' `super::<item>` paths
// resolve.
#[cfg(feature = "native-emit")]
use crate::c5::codegen::asm_fold::{AsmLabelPlacement, bind_label_calls, fold_asm_sections};
#[cfg(all(test, feature = "native-emit"))]
pub(crate) use crate::c5::codegen::lower_for;
#[cfg(feature = "native-emit")]
pub(crate) use crate::c5::codegen::{
    Abi, AddrPart, Build, CopyRelocReq, DataFixup, DwarfTextReloc, DynamicExportSection,
    EarlyReturn, ElfTpoffFixup, ElfTpoffTarget, ExecForm, FnUnwind, FuncFixup, GotFixup, Machine,
    MachoTlvDescriptor, MachoTlvFixup, NativeOptions, OutputKind, ResolvedImport, ResolvedImports,
    Target, TlsIndexFixup, UnitDef, UnitDefs, aarch64, x86_64,
};

/// Write the runtime address of a text-targeting DWARF placeholder over its
/// preserved location in a merged DWARF section.
#[cfg(feature = "native-emit")]
pub(crate) fn apply_merged_dwarf_text_reloc(
    section_bytes: &mut [u8],
    r: &DwarfTextReloc,
    text_vmaddr: u64,
) -> Result<(), C5Error> {
    let off = r.byte_offset as usize;
    let end = off.checked_add(r.width as usize).ok_or_else(|| {
        C5Error::internal(format!(
            "DWARF text reloc offset 0x{off:x} + width {} overflows",
            r.width,
        ))
    })?;
    if end > section_bytes.len() {
        return Err(C5Error::internal(format!(
            "DWARF text reloc past section end (offset 0x{off:x}, width {}, section length {})",
            r.width,
            section_bytes.len(),
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
        C5Error::internal(format!(
            "DWARF data reloc offset 0x{off:x} + width {} overflows",
            r.width,
        ))
    })?;
    if end > section_bytes.len() {
        return Err(C5Error::internal(format!(
            "DWARF data reloc past section end (offset 0x{off:x}, width {}, section length {})",
            r.width,
            section_bytes.len(),
        )));
    }
    let resolved = data_off_to_vaddr(r.merged_data_offset);
    let bytes = &resolved.to_le_bytes()[..r.width as usize];
    section_bytes[off..end].copy_from_slice(bytes);
    Ok(())
}

/// The producer fingerprint every final image carries: the NUL-terminated
/// release version line, `strings(1)`-visible and placed outside the
/// instruction stream (ELF `.comment`, the Mach-O `__TEXT,__const` tail,
/// the PE `.rdata` tail) so decoders never walk into it.
#[cfg(feature = "native-emit")]
fn provenance_comment() -> Vec<u8> {
    let mut v = crate::OUTPUT_MARKER.as_bytes().to_vec();
    v.push(0);
    v
}

/// Index of a relocated 8-byte slot within the writable data payload
/// (`data[data_ro_len..]`).
#[cfg(feature = "native-emit")]
fn reloc_slot_in_data(
    format: &str,
    data_offset: u64,
    ro_len: u64,
    kind: &str,
) -> Result<usize, C5Error> {
    if data_offset < ro_len {
        return Err(C5Error::internal(alloc::format!(
            "{format}: {kind} reloc slot {data_offset:#x} lies in the read-only data prefix \
                 (len {ro_len:#x})"
        )));
    }
    Ok((data_offset - ro_len) as usize)
}

/// A native emit: the image bytes and what the lowering reported.
#[cfg(feature = "native-emit")]
pub struct NativeEmit {
    pub image: Vec<u8>,
    pub diagnostics: Vec<crate::c5::diag::Diagnostic>,
}

#[cfg(feature = "native-emit")]
pub fn emit_native(program: &Program, target: Target) -> Result<Vec<u8>, C5Error> {
    emit_native_with_options(program, target, NativeOptions::default())
}

/// Variant of [`emit_native`] that accepts user-controllable
/// [`NativeOptions`].
#[cfg(feature = "native-emit")]
pub fn emit_native_with_options(
    program: &Program,
    target: Target,
    options: NativeOptions,
) -> Result<Vec<u8>, C5Error> {
    emit_native_with_options_owned(program.clone(), target, options)
}

/// [`emit_native_with_options`] taking the program by value.
#[cfg(feature = "native-emit")]
pub fn emit_native_with_options_owned(
    program: Program,
    target: Target,
    options: NativeOptions,
) -> Result<Vec<u8>, C5Error> {
    emit_native_with_options_named(program, target, options, None)
}

/// Resolve function-body inline-asm symbol-operand sites (aarch64) on a
/// single-TU final image.
#[cfg(feature = "native-emit")]
fn resolve_single_image_asm_sym_fixups(
    program: &Program,
    build: &mut Build,
    asm_labels: &alloc::collections::BTreeMap<String, AsmLabelPlacement>,
    defs: &UnitDefs,
    imports: &mut Option<crate::c5::codegen::DataImportSlots>,
) -> Result<(), C5Error> {
    use crate::c5::asm::{AsmRelocKind, AsmSectionTarget, patch_asm_insn_field};
    if build.output_kind == OutputKind::Relocatable || build.asm_sym_fixups.is_empty() {
        return Ok(());
    }
    let weak_names = program.weak_link_names();
    let err = |code: crate::c5::diag::Code, m: alloc::string::String| C5Error::hard(code, &m);
    enum Loc {
        Def(UnitDef),
        /// The GOT base; the record's addend is a byte offset from it.
        GotBase,
        Import(String),
        WeakUndef,
    }
    let records = core::mem::take(&mut build.asm_sym_fixups);
    let mut resolved: Vec<(crate::c5::codegen::AsmSymFixup, Loc)> = Vec::new();
    for r in records {
        let loc = match &r.target {
            AsmSectionTarget::Data(off) => Loc::Def(UnitDef::Data(*off)),
            AsmSectionTarget::Symbol(name) => match asm_labels
                .get(name.as_str())
                .map(|p| p.as_def())
                .or_else(|| defs.get(name.as_str()).copied())
            {
                Some(def) => Loc::Def(def),
                // Linker-defined, and declared weak-undefined by the C idiom
                // reaching the GOT, so ahead of the weak rule.
                None if name == crate::c5::object::elf_reloc_types::GOT_BASE_SYMBOL => Loc::GotBase,
                None if imports.as_ref().is_some_and(|s| s.binds(name)) => {
                    Loc::Import(name.clone())
                }
                None if weak_names.contains(name.as_str()) => Loc::WeakUndef,
                None => {
                    return Err(err(
                        Code::UNDEFINED_SYMBOL,
                        alloc::format!("undefined reference to `{name}`"),
                    ));
                }
            },
            other => {
                return Err(C5Error::internal(alloc::format!(
                    "asm operand relocation target {other:?} is not a data offset or symbol"
                )));
            }
        };
        resolved.push((r, loc));
    }
    let refuse = |what: &str| {
        err(
            Code::OBJECT_FORMAT,
            alloc::format!(
                "inline asm: {what} needs a load-time relocation and cannot be resolved in a \
             single-file image; compile with `-c` and link"
            ),
        )
    };
    for (r, loc) in resolved {
        let part = match r.kind {
            AsmRelocKind::A64AdrpPage21 => Some(AddrPart::Page),
            AsmRelocKind::A64AddLo12 | AsmRelocKind::A64LdstLo12(_) => Some(AddrPart::InPage),
            _ => None,
        };
        match (part, loc) {
            (_, Loc::Import(name)) => {
                let slots = imports.as_mut().expect("an import was found in the slots");
                slots.route_asm_operand(build, &r, &name)?
            }
            (Some(part), Loc::Def(def)) => def.bind(build, r.instr_offset, part, r.addend),
            // The GOT's address is the writer's to decide, so the site
            // takes the same record the link path parks for it.
            (Some(part), Loc::GotBase) => {
                build
                    .got_base_fixups
                    .push(crate::c5::codegen::GotBaseFixup {
                        instr_offset: r.instr_offset,
                        got_offset: r.addend,
                        part,
                    })
            }
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
            (None, Loc::Def(UnitDef::Text(off))) => {
                if matches!(r.kind, AsmRelocKind::A64MovwAbs { .. }) {
                    return Err(refuse("a `movz`/`movk` symbol operand"));
                }
                let disp = off as i64 + r.addend - r.instr_offset as i64;
                let patched =
                    patch_asm_insn_field(&mut build.text, r.instr_offset, r.kind, true, 4, disp)
                        .map_err(|m| err(Code::OBJECT_FORMAT, m))?;
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
/// single-TU final image.
#[cfg(feature = "native-emit")]
fn resolve_single_tu_extern_refs(
    program: &Program,
    build: &mut Build,
    target: Target,
    asm_labels: &alloc::collections::BTreeMap<String, AsmLabelPlacement>,
    defs: &UnitDefs,
    imports: &mut Option<crate::c5::codegen::DataImportSlots>,
) -> Result<(), C5Error> {
    if build.output_kind == OutputKind::Relocatable
        || (build.user_extern_data_refs.is_empty() && build.user_extern_call_sites.is_empty())
    {
        return Ok(());
    }
    let weak_names = program.weak_link_names();
    let data_bindings: alloc::collections::BTreeSet<String> = build
        .imports
        .data_bindings
        .iter()
        .map(|(local, _host, _dylib)| local.clone())
        .collect();
    let machine = match target {
        Target::LinuxX64 | Target::WindowsX64 => Machine::X86_64,
        Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64 => Machine::Aarch64,
    };
    let undefined = |name: &str| -> C5Error {
        C5Error::hard(
            Code::UNDEFINED_SYMBOL,
            format!("undefined reference to `{name}`",),
        )
    };
    let unsupported = |name: &str| -> C5Error {
        C5Error::hard(
            Code::RELOCATION,
            format!(
                "unresolved weak reference to `{name}`: cannot resolve the referencing instruction to address 0",
            ),
        )
    };

    let mut kept_data = Vec::new();
    for r in core::mem::take(&mut build.user_extern_data_refs) {
        // A `sym(%rip)` addend counts from the field's end, a fixup's from the instruction's.
        if let Some(def) = asm_labels
            .get(r.symbol_name.as_str())
            .map(|p| p.as_def())
            .or_else(|| defs.get(r.symbol_name.as_str()).copied())
        {
            let addend = r.direct_pcrel.map_or(0, |a| a + 4);
            def.bind(build, r.instr_offset, AddrPart::Whole, addend);
            continue;
        }
        if let Some(slots) = imports.as_mut().filter(|s| s.binds(&r.symbol_name)) {
            slots.route_ref(build, &r)?;
            continue;
        }
        if data_bindings.contains(r.symbol_name.as_str()) {
            kept_data.push(r);
            continue;
        }
        // The GOT base is linker-defined: looked up after the unit's own
        // definitions and ahead of the weak rule, since the usual C idiom
        // for reaching it declares the name weak-undefined.
        if r.symbol_name == crate::c5::object::elf_reloc_types::GOT_BASE_SYMBOL
            && let Some(addend) = r.direct_pcrel
        {
            build
                .got_base_fixups
                .push(crate::c5::codegen::GotBaseFixup {
                    instr_offset: r.instr_offset,
                    got_offset: addend + 4,
                    part: AddrPart::Whole,
                });
            continue;
        }
        if !weak_names.contains(r.symbol_name.as_str()) {
            return Err(undefined(&r.symbol_name));
        }
        if !weak_undef::address_to_zero(machine, &mut build.text, r.instr_offset) {
            return Err(unsupported(&r.symbol_name));
        }
    }
    build.user_extern_data_refs = kept_data;

    bind_label_calls(build, asm_labels, machine == Machine::Aarch64);
    for site in core::mem::take(&mut build.user_extern_call_sites) {
        if !weak_names.contains(site.symbol_name.as_str()) {
            return Err(undefined(&site.symbol_name));
        }
        if !weak_undef::branch_to_nop(machine, &mut build.text, site.instr_offset) {
            return Err(unsupported(&site.symbol_name));
        }
    }
    Ok(())
}

/// Whether `BADC_NO_BSS_SEGREGATE` opts a build out of segregating
/// wholly-zero data objects into a no-file-backing `.bss` region.
/// Diagnostic only: read under the `codegen_test` feature so a
/// production build never consults the environment.
#[cfg(feature = "native-emit")]
fn bss_segregation_disabled() -> bool {
    #[cfg(feature = "codegen_test")]
    {
        std::env::var("BADC_NO_BSS_SEGREGATE").is_ok()
    }
    #[cfg(not(feature = "codegen_test"))]
    {
        false
    }
}

/// Variant of [`emit_native_with_options`] that records the shared
/// library's own name in the image (PE export-directory Name, Mach-O
/// `LC_ID_DYLIB` install name) so a consumer linking against it by name
/// references the file it loads at runtime. Discards the lowering's
/// diagnostics; see [`emit_native_reporting`].
#[cfg(feature = "native-emit")]
pub fn emit_native_with_options_named(
    program: Program,
    target: Target,
    options: NativeOptions,
    shared_lib_name: Option<&str>,
) -> Result<Vec<u8>, C5Error> {
    emit_native_reporting(program, target, options, shared_lib_name).map(|e| e.image)
}

/// [`emit_native_with_options_named`] handing the lowering's
/// diagnostics to the caller, which prints them at the level each
/// resolved to. The entries returning the bytes alone drop them: a
/// caller that supplied no `NativeOptions::diag` has nothing to say
/// about them.
#[cfg(feature = "native-emit")]
pub fn emit_native_reporting(
    program: Program,
    target: Target,
    options: NativeOptions,
    shared_lib_name: Option<&str>,
) -> Result<NativeEmit, C5Error> {
    let output_kind = options.output_kind;
    let freed_by_exit = options.freed_by_exit;
    let (compacted, bss_size, mut build) = compact_and_lower(program, target, options)?;
    let program = &compacted;
    build.bss_size = bss_size;
    let defs = crate::c5::codegen::unit_definitions(program, &build);
    let mut imports = target.binds_data_imports().then(|| {
        let flat = target == Target::MacOSAarch64;
        crate::c5::codegen::DataImportSlots::new(&build, flat, "a single-file image")
    });
    let asm_labels = fold_asm_sections(program, &mut build, target, &defs, "a single-file image")?;
    resolve_single_image_asm_sym_fixups(program, &mut build, &asm_labels, &defs, &mut imports)?;
    resolve_single_tu_extern_refs(
        program,
        &mut build,
        target,
        &asm_labels,
        &defs,
        &mut imports,
    )?;
    if output_kind != OutputKind::Relocatable {
        let mut named = defs;
        named.extend(asm_labels.iter().map(|(n, at)| (n.clone(), at.as_def())));
        crate::c5::codegen::bind_named_slots(program, &mut build, &named, &mut |build, r| {
            match imports.as_mut() {
                Some(slots) => Ok(slots.bind_slot(build, r)),
                None => refuse_pe_data_slot(build, r),
            }
        })?;
    }
    if output_kind == OutputKind::SharedLibrary {
        build.shared_lib_name = shared_lib_name.map(alloc::string::String::from);
    }
    let diagnostics = core::mem::take(&mut build.diagnostics);
    let image = write_for(program, &build, target)?;
    if freed_by_exit {
        core::mem::forget(build);
        core::mem::forget(compacted);
    }
    Ok(NativeEmit { image, diagnostics })
}

/// A PE loader writes an imported object's address into the import table alone.
#[cfg(feature = "native-emit")]
fn refuse_pe_data_slot(
    build: &Build,
    r: &crate::c5::program::ExternDataReloc,
) -> Result<bool, C5Error> {
    let name = r.symbol_name.as_str();
    if !(build.imports.data_bindings.iter()).any(|(local, ..)| local == name) {
        return Ok(false);
    }
    Err(C5Error::hard(
        Code::RELOCATION,
        format!(
            "a static initializer takes the address of the imported object `{name}`, which a PE \
             image reaches only through its import address table; take it at run time"
        ),
    ))
}

/// One region of the data stream at its runtime placement.
#[cfg(feature = "native-emit")]
#[derive(Clone, Copy, Debug)]
pub(crate) struct DataRegion {
    pub(crate) start: u64,
    pub(crate) base: u64,
    /// Bytes mapped one to one from `start`; `u64::MAX` leaves the region
    /// open.
    pub(crate) len: u64,
}

/// Runtime address of a data-stream offset.
#[cfg(feature = "native-emit")]
pub(crate) fn data_region_addr(regions: &[DataRegion], off: u64) -> u64 {
    let r = &regions[regions.partition_point(|r| r.start <= off) - 1];
    r.base + (off - r.start).min(r.len)
}

/// C99 6.2.2 / 6.7.8: drop static data no surviving function or relocation
/// references, repacking `.data` and rewriting every offset surface (symbol
/// values, AST data offsets, relocation slots), then lower the result.
/// The lowering probes the program into SSA once and reports the
/// post-inline reachable set; the compaction applies that report, so one
/// SSA build serves both the liveness and the codegen.
#[cfg(feature = "native-emit")]
fn compact_and_lower(
    mut program: Program,
    target: Target,
    options: NativeOptions,
) -> Result<(Program, i64, Build), C5Error> {
    use crate::c5::codegen::LowerMode;
    use crate::c5::codegen::ssa::shadow;
    if let Some(d) = &program.image_align_error {
        return Err(C5Error::of(d.clone()));
    }
    program.bind_trampoline_slots =
        target.binds_data_imports() || options.output_kind == OutputKind::Relocatable;
    program.weak_refs_by_name = options.output_kind == OutputKind::Relocatable;
    let segregate = options.bss_segregate && !bss_segregation_disabled();
    if program.data.is_empty() {
        let mut build = crate::c5::codegen::lower_for_with_prebuilt(
            &program,
            target,
            options,
            None,
            LowerMode::Full,
        )?;
        crate::c5::codegen::emit_ssa_dump(&mut build);
        return Ok((program, 0, build));
    }
    // With no function to probe, or the prune turned off, every object
    // stays and only the placement into regions and zero-fill applies.
    if program.finished_functions.is_empty() || shadow::data_dce_disabled() {
        let sets = shadow::LiveSets::everything(&program);
        let (laid, bss_size, _map) =
            shadow::apply_data_liveness(program, &sets, &sets.func_pcs, segregate, None);
        let mut build = crate::c5::codegen::lower_for_with_prebuilt(
            &laid,
            target,
            options,
            None,
            LowerMode::Full,
        )?;
        crate::c5::codegen::emit_ssa_dump(&mut build);
        return Ok((laid, bss_size, build));
    }
    let probe = crate::c5::codegen::lower_for_with_prebuilt(
        &program,
        target,
        options.clone(),
        None,
        LowerMode::DataLivenessProbe,
    )?;
    let mut report = probe
        .data_liveness
        .expect("the liveness probe always reports");
    if options.freed_by_exit {
        let live = &report.sets.func_pcs;
        let (kept, dead): (alloc::vec::Vec<_>, alloc::vec::Vec<_>) =
            core::mem::take(&mut program.finished_functions)
                .into_iter()
                .partition(|f| live.contains(&f.ent_pc));
        program.finished_functions = kept;
        core::mem::forget(dead);
    }
    debug_assert!(probe.stopped_at_data_liveness);
    // The probe ran the passes that report; the retry lowers the bodies
    // they produced, skipping those passes, so its own sink stays empty.
    let mut diagnostics = probe.diagnostics;
    let identity = shadow::DataMap::identity(&program);
    let (compacted, bss_size, _map) = shadow::apply_data_liveness(
        program,
        &report.sets,
        &report.sets.func_pcs,
        segregate,
        Some((&mut report.ssa.funcs, &identity)),
    );
    let mut build = crate::c5::codegen::lower_for_with_prebuilt(
        &compacted,
        target,
        options,
        Some(report.ssa),
        LowerMode::Full,
    )?;
    diagnostics.append(&mut build.diagnostics);
    build.diagnostics = diagnostics;
    crate::c5::codegen::emit_ssa_dump(&mut build);
    Ok((compacted, bss_size, build))
}

/// Test-only: emit a complete native image for a single program, satisfying
/// the PE entry stub's `__c5_*` runtime-helper references that the bare
/// single-TU path cannot link (production links them from the embedded
/// startup runtime).
#[cfg(all(test, feature = "native-emit"))]
pub(crate) fn emit_native_single_tu_for_test(
    program: &Program,
    target: Target,
    options: NativeOptions,
) -> Result<alloc::vec::Vec<u8>, C5Error> {
    Ok(single_tu_image_for_test(program, target, options)?.0)
}

/// The single-TU image plus the data-region boundaries it was written from
/// and the compacted `.data` offset of every named global: `data[..ro_len]`
/// is the pure read-only prefix, `data[ro_len.. relro_len]` the relro
/// region, the rest writable.
#[cfg(all(test, feature = "native-emit"))]
pub(crate) struct SingleTuRegions {
    pub ro_len: usize,
    pub relro_len: usize,
    pub sym_offsets: alloc::vec::Vec<(alloc::string::String, u64)>,
}

#[cfg(all(test, feature = "native-emit"))]
pub(crate) fn single_tu_image_for_test(
    program: &Program,
    target: Target,
    options: NativeOptions,
) -> Result<(alloc::vec::Vec<u8>, SingleTuRegions), C5Error> {
    use crate::c5::token::Token;
    let (compacted, bss_size, mut build) = compact_and_lower(program.clone(), target, options)?;
    let program = &compacted;
    build.bss_size = bss_size;
    let pc = build.pc_to_native.len();
    build.pc_to_native.push(build.entry_offset);
    build
        .func_names
        .push(alloc::string::String::from("__c5_entry"));
    build.func_ent_pcs.push(pc);
    let regions = SingleTuRegions {
        ro_len: build.data_ro_len,
        relro_len: build.data_relro_len,
        sym_offsets: program
            .symbols
            .iter()
            .filter(|s| s.class == Token::Glo as i64 && s.defined_here && !s.is_alias)
            .map(|s| (s.name.clone(), s.val as u64))
            .collect(),
    };
    Ok((write_for(program, &build, target)?, regions))
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
        let machine = match target {
            Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64 => {
                Machine::Aarch64
            }
            Target::LinuxX64 | Target::WindowsX64 => Machine::X86_64,
        };
        return crate::c5::codegen::ssa::emit_common::time_pass(
            "object::write_relocatable",
            || elf_reloc::write_relocatable(program, build, machine, target),
        );
    }
    // The no-std build can't reach the relocatable writer; the `-c` path
    // lives in the CLI, which itself is std-only. If a no-std caller ever
    // surfaces `Relocatable` it would fall through to the final-image
    // writers below; the unreachable branch keeps the match arms exhaustive
    // without pulling `elf_reloc` into the no-std build.
    #[cfg(not(feature = "std"))]
    if build.output_kind == OutputKind::Relocatable {
        return Err(C5Error::internal(
            "Relocatable output requires the `std` feature",
        ));
    }
    if !build.abs_addr_refs.is_empty() {
        return Err(C5Error::internal(
            "an absolute address field reached an image writer",
        ));
    }
    match target {
        Target::MacOSAarch64 => mach_o::write(program, build),
        Target::LinuxAarch64 => elf::write(program, build, Machine::Aarch64),
        Target::LinuxX64 => elf::write(program, build, Machine::X86_64),
        Target::WindowsX64 => pe::write(program, build, Machine::X86_64, target),
        Target::WindowsAarch64 => pe::write(program, build, Machine::Aarch64, target),
    }
}

/// Empty `Program` and `Build` values for the writers' unit tests; a test
/// sets the fields it exercises.
#[cfg(all(test, feature = "native-emit"))]
pub(crate) mod test_support {
    use alloc::collections::BTreeMap;
    use alloc::string::String;
    use alloc::vec::Vec;

    use super::{Abi, Build, OutputKind, Program, ResolvedImports, Target};

    pub(crate) fn empty_program() -> Program {
        Program {
            target: Target::host(),
            data: Vec::new(),
            file_asm: Vec::new(),
            asm_weak_names: Vec::new(),
            asm_global_names: Vec::new(),
            asm_visibility: Vec::new(),
            asm_unit: false,
            asm_file_names: Vec::new(),
            asm_idents: Vec::new(),
            data_ro_len: 0,
            data_relro_len: 0,
            data_object_starts: Vec::new(),
            const_data_ranges: Vec::new(),
            data_pad_ranges: Vec::new(),
            data_align_marks: Vec::new(),
            entry_pc: 0,
            warnings: Vec::new(),
            notes: Vec::new(),
            tls_data: Vec::new(),
            tls_init_size: 0,
            tls_align: 8,
            data_relocs: Vec::new(),
            extern_data_relocs: Vec::new(),
            code_relocs: Vec::new(),
            sys_trampolines: Vec::new(),
            bind_trampoline_slots: false,
            weak_refs_by_name: false,
            fp_contract_fast: false,
            tls_data_relocs: Vec::new(),
            tls_extern_data_relocs: Vec::new(),
            tls_code_relocs: Vec::new(),
            exports: Vec::new(),
            exported_objects: Vec::new(),
            dylibs: Vec::new(),
            dllmain_pc: None,
            source_files: Vec::new(),
            source_path: String::new(),
            variables: Vec::new(),
            structs: Vec::new(),
            enums: Vec::new(),
            entry_name: None,
            entry_pragma: None,
            auto_includes: Vec::new(),
            data_align: 8,
            image_align_error: None,
            subsystem: None,
            finished_functions: Vec::new(),
            symbols: Vec::new(),
            synthetic_ssa_funcs: Vec::new(),
            user_ssa_funcs: Vec::new(),
            extern_function_imports: Vec::new(),
            init_funcs: Vec::new(),
            function_aliases: Vec::new(),
        }
    }

    pub(crate) fn empty_build() -> Build {
        Build {
            elf: Default::default(),
            diagnostics: Vec::new(),
            text_data_ranges: Vec::new(),
            emitted_relocs: Vec::new(),
            named_sections: Vec::new(),
            compact_unwind: Vec::new(),
            eh_frame: Vec::new(),
            data_import_binds: Vec::new(),
            tls_data_import_binds: Vec::new(),
            canonical_imports: Vec::new(),
            preemptible_imports: Vec::new(),
            got_base_fixups: Vec::new(),
            got_rel_fields: Vec::new(),
            got_pcrel_fixups: Vec::new(),
            text_align: 16,
            data_liveness: None,
            stopped_at_data_liveness: false,
            ssa_dump: String::new(),
            asm_sections: Vec::new(),
            asm_section_text_refs: Vec::new(),
            asm_text_abs_refs: Vec::new(),
            abs_addr_refs: Vec::new(),
            asm_sym_fixups: Vec::new(),
            asm_text_labels: Vec::new(),
            asm_sym_decls: Vec::new(),
            copy_relocs: Default::default(),
            text: Vec::new(),
            data: Vec::new(),
            data_ro_len: 0,
            data_relro_len: 0,
            pic_link: false,
            exec_form: Default::default(),

            code_model: Default::default(),
            elf_class: Default::default(),
            keep_local_labels: false,
            rodata: Default::default(),
            data_pcrel_relocs: Vec::new(),
            text_pcrel_relocs: Vec::new(),
            text_abs_relocs: Vec::new(),
            data_align: 8,
            bss_size: 0,
            init_fini_arrays: Default::default(),
            entry_offset: 0,
            got_fixups: Vec::new(),
            data_fixups: Vec::new(),
            func_fixups: Vec::new(),
            pc_to_native: Vec::new(),
            func_ent_pcs: Vec::new(),
            func_ends: Vec::new(),
            patchable_entries: Vec::new(),
            mcount_sites: Vec::new(),
            early_returns: Vec::new(),
            func_names: Vec::new(),
            func_prologue_native: BTreeMap::new(),
            promoted_local_slots: BTreeMap::new(),
            coalesced_slot_remap: BTreeMap::new(),
            canary_frame_bytes: BTreeMap::new(),
            param_frame_offsets: BTreeMap::new(),
            region_frame_offsets: BTreeMap::new(),
            fn_unwind: Vec::new(),
            reloc_call_sites: Vec::new(),
            user_extern_call_sites: Vec::new(),
            user_extern_data_refs: Vec::new(),
            ssa_line_rows: Vec::new(),
            imports: ResolvedImports::default(),
            abi: Abi::default(),
            tls_data: Vec::new(),
            tls_init_size: 0,
            tls_align: 8,
            tls_index_fixups: Vec::new(),
            elf_tpoff_fixups: Vec::new(),
            data_relocs: Vec::new(),
            extern_data_relocs: Vec::new(),
            code_relocs: Vec::new(),
            tls_data_relocs: Vec::new(),
            tls_extern_data_relocs: Vec::new(),
            tls_code_relocs: Vec::new(),
            label_relocs: Vec::new(),
            exports: Vec::new(),
            dynamic_exports: Vec::new(),
            protected_exports: Default::default(),
            image_symbols: Vec::new(),
            output_kind: OutputKind::Relocatable,
            shared_lib_name: None,
            dllmain_pc: None,
            macho_tlv_fixups: Vec::new(),
            macho_tlv_descriptors: Vec::new(),
            debug_info: false,
            merged_dwarf: None,
            plt_trampoline_offsets: Vec::new(),
        }
    }
}
