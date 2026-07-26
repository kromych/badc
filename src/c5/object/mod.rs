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
#[cfg(feature = "native-emit")]
pub(crate) mod elf_reloc;
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
#[cfg(feature = "native-emit")]
pub(crate) use crate::c5::codegen::{
    Abi, Build, CopyRelocReq, DataFixup, DwarfTextReloc, DynamicExportSection, ElfTpoffFixup,
    ElfTpoffTarget, FnUnwind, FuncFixup, GotFixup, Machine, MachoTlvDescriptor, MachoTlvFixup,
    NativeOptions, OutputKind, ResolvedImport, ResolvedImports, Target, TlsIndexFixup, aarch64,
    lower_for, x86_64,
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
                is_variadic: false,
                fixed_args: 0,
                return_type_tag: 0,
                returns_long_double: false,
                param_types: Vec::new(),
            });
            i
        });
        build.got_fixups.push(GotFixup {
            adrp_offset: r.instr_offset,
            import_index: idx,
            is_data_load: false,
        });
    }
    build.user_extern_data_refs = remaining;
}

/// Place the executable inline-asm sections a single-TU final image
/// references into its text stream. The relocatable path emits every
/// section for a real link to place; a final image has no link step, so
/// an `"x"` section defining a label the C code calls is appended to
/// the text, its relocations resolved, and its labels returned so the
/// call sites bind to them -- what the linker does for the object
/// path's undefined symbols. Unreferenced sections keep the established
/// final-image behavior (assembled and dropped).
#[cfg(feature = "native-emit")]
fn fold_exec_asm_sections(
    build: &mut Build,
    target: Target,
) -> Result<alloc::collections::BTreeMap<String, usize>, C5Error> {
    use crate::c5::codegen::ssa::emit_common::{AsmSectionTarget, align_fill_pattern};
    let mut label_at: alloc::collections::BTreeMap<String, usize> =
        alloc::collections::BTreeMap::new();
    if build.output_kind == OutputKind::Relocatable || build.asm_sections.is_empty() {
        return Ok(label_at);
    }
    // Names the image needs: the C code's extern call sites. (An extern
    // DATA reference to a section label keeps its undefined-reference
    // diagnostic; TODO fold those through the writers' address-load
    // patching.) Folding a section can add needs of its own (its
    // relocations), so iterate to a fixpoint.
    let mut needed: alloc::collections::BTreeSet<String> = build
        .user_extern_call_sites
        .iter()
        .map(|s| s.symbol_name.clone())
        .collect();
    let is_a64 = matches!(
        target,
        Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64
    );
    let err = |m: alloc::string::String| C5Error::Compile(crate::c5::error::fmt_link_err(&m));
    let mut folded: Vec<usize> = Vec::new();
    let mut bases: Vec<Option<usize>> = alloc::vec![None; build.asm_sections.len()];
    loop {
        let mut grew = false;
        for (i, s) in build.asm_sections.iter().enumerate() {
            if bases[i].is_some()
                || !s.flags.contains('x')
                || !s.labels.iter().any(|l| needed.contains(&l.name))
            {
                continue;
            }
            let align = s.align.max(1) as usize;
            let (pat, plen) = align_fill_pattern(None, true, is_a64);
            while !build.text.len().is_multiple_of(align) {
                build.text.push(pat[build.text.len() % plen]);
            }
            let base = build.text.len();
            build.text.extend_from_slice(&s.bytes);
            bases[i] = Some(base);
            folded.push(i);
            for l in &s.labels {
                label_at.insert(l.name.clone(), base + l.offset as usize);
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
        let base = bases[i].expect("folded section has a base");
        for r in &s.relocs {
            let at = base + r.offset as usize;
            let target_off = match &r.target {
                AsmSectionTarget::Text(off) => *off,
                AsmSectionTarget::Symbol(name) => match label_at
                    .get(name.as_str())
                    .copied()
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
            // PC-relative field folds to a constant: S + A - P.
            if !(r.pcrel && r.width == 4) {
                return Err(err(alloc::format!(
                    "inline-asm section `{}`: only 4-byte PC-relative relocations are \
                     supported in a single-file image; compile with `-c` and link",
                    s.name
                )));
            }
            let val = target_off as i64 + r.addend - at as i64;
            build.text[at..at + 4].copy_from_slice(&(val as i32).to_le_bytes());
        }
    }
    // The folded sections are placed; remove them so no writer emits a copy.
    let mut keep = bases.iter().map(|b| b.is_none());
    build.asm_sections.retain(|_| keep.next().unwrap());
    Ok(label_at)
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
    asm_labels: &alloc::collections::BTreeMap<String, usize>,
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
        .filter(|s| s.is_weak && (s.class == Token::Fun as i64 || s.class == Token::Glo as i64))
        .map(|s| s.name.as_str())
        .collect();
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
        // A callee defined as a label in a folded executable asm section:
        // bind the call directly, as the linker binds the object path's
        // undefined symbol against the section's label.
        if let Some(&target_off) = asm_labels.get(site.symbol_name.as_str()) {
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
    // C99 6.2.2 / 6.7.8: drop static data no surviving function or
    // relocation references, repacking `.data` and rewriting every offset
    // surface (symbol values, AST data offsets, relocation slots). The one
    // compaction feeds both the backend lowering (which bakes data-relative
    // fixups) and the container writer (which emits the symbol table), so
    // the emitted `.data` and its symbols stay consistent.
    let (compacted, bss_size) = crate::c5::codegen::ssa::shadow::compact_program_data(
        program,
        target,
        options.bss_segregate && !bss_segregation_disabled(),
        options.optimize,
    )?;
    let program = &compacted;
    let mut build = lower_for(program, target, options)?;
    build.bss_size = bss_size;
    route_single_tu_data_imports(&mut build, target);
    let asm_labels = fold_exec_asm_sections(&mut build, target)?;
    resolve_single_tu_extern_refs(program, &mut build, target, &asm_labels)?;
    if options.output_kind == OutputKind::SharedLibrary {
        build.shared_lib_name = shared_lib_name.map(alloc::string::String::from);
    }
    write_for(program, &build, target)
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
    let (compacted, bss_size) = crate::c5::codegen::ssa::shadow::compact_program_data(
        program,
        target,
        options.bss_segregate && !bss_segregation_disabled(),
        options.optimize,
    )?;
    let program = &compacted;
    let mut build = lower_for(program, target, options)?;
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
