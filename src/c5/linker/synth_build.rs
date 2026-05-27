//! Synthesize a `(Program, Build)` pair from a [`MergedNative`] so
//! the per-format final-image writers (`mach_o::write`, `pe::write`,
//! `elf::write`) can consume native `.o` link output without a
//! separate writer per format.
//!
//! The single-TU compile path produces `(Program, Build)` directly;
//! the multi-TU `.o` link path produces [`MergedNative`] via
//! [`link_native_objects`] + `emit_*_plt`. This module bridges the
//! shapes so a single writer family handles both.
//!
//! Limitations of the baseline. The synthesizer carries enough state
//! for hosted executables that link against libSystem / libc /
//! kernel32 + msvcrt. Not threaded through yet:
//!
//!   * Variadic libc imports -- printf / scanf families lose
//!     `is_variadic` / `fixed_args` / `param_types` across the ELF
//!     ET_REL roundtrip. The C99-motivated fix is a per-binding
//!     metadata note section. TODO.
//!   * `_Thread_local` storage. macOS arm64 TLV descriptors and
//!     Win64 `_tls_index` fixups don't survive the merge yet.
//!     Sources with TLS reach the synthesizer with `tls_data`
//!     empty; the writer skips TLS layout. TODO.
//!   * Shared-library output. Only `OutputKind::Executable` is
//!     handled; exports + dylib-output dispatch stays on the
//!     pre-codegen `LinkUnit` path. TODO.
//!   * DWARF debug info. The merged image has no AST / function
//!     metadata to drive DWARF emit; debug sections are skipped,
//!     matching `write_executable_elf64`'s policy. TODO.

#![cfg(feature = "std")]

use alloc::string::{String, ToString};
use alloc::vec::Vec;

use crate::c5::codegen::{
    Build, DataFixup, FuncFixup, GotFixup, OutputKind, ResolvedDylib, ResolvedImport,
    ResolvedImports, Target, write_native_image,
};
use crate::c5::error::C5Error;
use crate::c5::program::{CodeReloc, DataReloc, ExportedFunction, Program};

use super::link::{MergedNative, PltTrampoline};
use super::object::{NativeMachine, NativeSymSection};

/// Synthesize a Program + Build for `merged` against `target` and
/// produce the per-format native image bytes. `entry_name` resolves
/// through `merged.defined`; `plt` is the trampoline list returned
/// by the matching `emit_*_plt` call (so the writer can surface
/// each trampoline as a local symbol).
pub fn write_native_image_from_merged(
    merged: &MergedNative,
    plt: &[PltTrampoline],
    entry_name: &str,
    target: Target,
) -> Result<Vec<u8>, C5Error> {
    let (program, build) = synth_program_and_build(merged, plt, entry_name, target)?;
    write_native_image(&program, &build, target)
}

fn synth_program_and_build(
    merged: &MergedNative,
    plt: &[PltTrampoline],
    entry_name: &str,
    target: Target,
) -> Result<(Program, Build), C5Error> {
    check_target_machine(target, merged.machine)?;
    let entry_offset = resolve_entry_offset(merged, entry_name)?;
    let imports = synth_imports(merged, target);
    let SynthFixups {
        got: got_fixups,
        data: data_fixups,
        func: func_fixups,
    } = synth_fixups(merged, plt)?;
    let (data_relocs, code_relocs) = synth_relocs(merged);
    let plt_trampoline_offsets = synth_plt_offsets(merged, plt);
    let exports = synth_exports(merged);
    let pc_to_native = synth_pc_to_native(&merged.text, &code_relocs, &exports);

    let program = Program {
        data: Vec::new(),
        entry_pc: 0,
        warnings: Vec::new(),
        tls_data: Vec::new(),
        tls_init_size: 0,
        data_relocs: data_relocs.clone(),
        code_relocs: code_relocs.clone(),
        exports: exports.clone(),
        dylibs: Vec::new(),
        dllmain_pc: None,
        source_files: Vec::new(),
        source_path: String::new(),
        variables: Vec::new(),
        structs: Vec::new(),
        entry_name: Some(entry_name.to_string()),
        subsystem: None,
        finished_functions: Vec::new(),
        symbols: Vec::new(),
        synthetic_ssa_funcs: Vec::new(),
        user_ssa_funcs: Vec::new(),
        extern_function_imports: Vec::new(),
    };

    let build = Build {
        text: merged.text.clone(),
        data: merged.data.clone(),
        entry_offset,
        got_fixups,
        data_fixups,
        func_fixups,
        pc_to_native,
        func_ent_pcs: Vec::new(),
        func_names: Vec::new(),
        reloc_call_sites: Vec::new(),
        user_extern_call_sites: Vec::new(),
        user_extern_data_refs: Vec::new(),
        ssa_line_rows: Vec::new(),
        imports,
        abi: target.abi(),
        tls_data: Vec::new(),
        tls_init_size: 0,
        tls_index_fixups: Vec::new(),
        macho_tlv_fixups: Vec::new(),
        macho_tlv_descriptors: Vec::new(),
        data_relocs,
        code_relocs,
        exports: exports.clone(),
        output_kind: OutputKind::Executable,
        dllmain_pc: None,
        debug_info: false,
        plt_trampoline_offsets,
    };

    Ok((program, build))
}

fn check_target_machine(target: Target, machine: NativeMachine) -> Result<(), C5Error> {
    let expect = match target {
        Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64 => {
            NativeMachine::Aarch64
        }
        Target::LinuxX64 | Target::WindowsX64 => NativeMachine::X86_64,
    };
    if expect != machine {
        return Err(synth_err(&alloc::format!(
            "synthesizer: target {target:?} expects {expect:?}, merged image is {machine:?}"
        )));
    }
    Ok(())
}

fn resolve_entry_offset(merged: &MergedNative, entry_name: &str) -> Result<usize, C5Error> {
    let sym = merged.defined.get(entry_name).ok_or_else(|| {
        synth_err(&alloc::format!(
            "entry symbol `{entry_name}` not defined in any input object"
        ))
    })?;
    if !matches!(sym.section, NativeSymSection::Text) {
        return Err(synth_err(&alloc::format!(
            "entry symbol `{entry_name}` is not in .text (found {:?})",
            sym.section
        )));
    }
    Ok(sym.value as usize)
}

fn synth_imports(merged: &MergedNative, target: Target) -> ResolvedImports {
    // `merged.dylibs` holds each `#pragma dylib` path the input
    // units recorded (in declaration order, deduped). When a
    // unit was produced before the `.badc.dylibs` section landed
    // and the merge surfaces no entries, fall back to the
    // single per-target default so the legacy single-libc link
    // path stays runnable.
    let dylibs: Vec<ResolvedDylib> = if merged.dylibs.is_empty() {
        alloc::vec![default_dylib(target)]
    } else {
        merged
            .dylibs
            .iter()
            .map(|path| ResolvedDylib {
                name: dylib_name_from_path(path),
                path: path.clone(),
            })
            .collect()
    };
    let imports: Vec<ResolvedImport> = merged
        .imports
        .iter()
        .enumerate()
        .map(|(i, name)| ResolvedImport {
            binding_idx: i as i64,
            // The .o writer stores each libc import under its
            // per-target `real_symbol` (the name the dynamic
            // linker actually resolves against). At synth time
            // the name is already in the target's final shape,
            // so both fields here point at the same string. The
            // `local_name` field is preserved as a back-reference
            // for diagnostics; the writer reads `real_symbol`.
            local_name: name.clone(),
            real_symbol: name.clone(),
            dylib_index: 0,
            is_variadic: false,
            fixed_args: 0,
            return_type_tag: 0,
            returns_long_double: false,
            param_types: Vec::new(),
        })
        .collect();
    ResolvedImports { imports, dylibs }
}

fn default_dylib(target: Target) -> ResolvedDylib {
    match target {
        Target::MacOSAarch64 => ResolvedDylib {
            name: "libSystem".to_string(),
            path: "/usr/lib/libSystem.B.dylib".to_string(),
        },
        Target::LinuxAarch64 | Target::LinuxX64 => ResolvedDylib {
            name: "libc".to_string(),
            path: linux_libc_path(target),
        },
        Target::WindowsX64 | Target::WindowsAarch64 => ResolvedDylib {
            name: "msvcrt".to_string(),
            path: "msvcrt.dll".to_string(),
        },
    }
}

fn dylib_name_from_path(path: &str) -> String {
    // The c5 handle is the load path's stem -- "libc.so.6" maps
    // to "libc", "/usr/lib/libSystem.B.dylib" to "libSystem",
    // "msvcrt.dll" to "msvcrt". Used only for diagnostics today.
    let basename = path.rsplit('/').next().unwrap_or(path);
    let stem = basename.split('.').next().unwrap_or(basename);
    let stripped = stem.strip_prefix("lib").unwrap_or(stem);
    stripped.to_string()
}

fn linux_libc_path(target: Target) -> String {
    match target {
        Target::LinuxAarch64 => "/lib/ld-linux-aarch64.so.1".to_string(),
        Target::LinuxX64 => "/lib64/ld-linux-x86-64.so.2".to_string(),
        _ => String::new(),
    }
}

/// Project [`MergedNative::pending_imports`] plus the matching PLT
/// trampoline list into the per-arch fixup streams the writer
/// consumes.
///
/// aarch64 address-of-symbol sequences are two relocations on
/// consecutive instructions: R_AARCH64_ADR_PREL_PG_HI21 at
/// `text_offset` and R_AARCH64_ADD_ABS_LO12_NC at `text_offset + 4`.
/// `patch_adrp_add` patches both halves from a single fixup, so the
/// synthesizer keys on the ADRP entry and drops the ADD entry.
///
/// PLT trampolines emit_*_plt produced are at the tail of
/// `merged.text`. Each is `adrp x16, 0; ldr x16, [x16]; br x16`
/// pointing at GOT slot `import_index`; one GotFixup per trampoline
/// lets the writer patch the adrp+ldr to reach `__got + slot * 8`.
/// Per-arch fixup streams the writer consumes for a single
/// function-pointer / data reference site.
struct SynthFixups {
    got: Vec<GotFixup>,
    data: Vec<DataFixup>,
    func: Vec<FuncFixup>,
}

fn synth_fixups(merged: &MergedNative, plt: &[PltTrampoline]) -> Result<SynthFixups, C5Error> {
    let mut got_fixups: Vec<GotFixup> = Vec::new();
    let mut data_fixups: Vec<DataFixup> = Vec::new();
    let mut func_fixups: Vec<FuncFixup> = Vec::new();

    for tramp in plt {
        got_fixups.push(GotFixup {
            adrp_offset: tramp.text_offset,
            import_index: tramp.import_index,
        });
    }

    for reloc in &merged.pending_imports {
        match merged.machine {
            NativeMachine::Aarch64 => {
                project_aarch64_pending(
                    reloc,
                    &mut got_fixups,
                    &mut data_fixups,
                    &mut func_fixups,
                )?;
            }
            NativeMachine::X86_64 => {
                project_x86_64_pending(reloc, &mut got_fixups, &mut data_fixups, &mut func_fixups)?;
            }
        }
    }

    Ok(SynthFixups {
        got: got_fixups,
        data: data_fixups,
        func: func_fixups,
    })
}

// Reloc kind constants. Match the values link.rs uses (it keeps its
// own private copies); duplicated here so the synthesizer doesn't
// reach across the module boundary for a private constant.
const R_X86_64_PC32: u32 = 2;
const R_X86_64_PLT32: u32 = 4;
const R_AARCH64_ADR_PREL_PG_HI21: u32 = 275;
const R_AARCH64_ADD_ABS_LO12_NC: u32 = 277;
const R_AARCH64_CALL26: u32 = 283;

fn project_aarch64_pending(
    reloc: &super::link::PendingImportReloc,
    got_fixups: &mut Vec<GotFixup>,
    data_fixups: &mut Vec<DataFixup>,
    func_fixups: &mut Vec<FuncFixup>,
) -> Result<(), C5Error> {
    match reloc.rtype {
        R_AARCH64_ADD_ABS_LO12_NC => {
            // The matching ADRP entry owns the fixup; patch_adrp_add
            // writes both halves from one DataFixup / FuncFixup /
            // GotFixup record.
            Ok(())
        }
        R_AARCH64_CALL26 => Err(synth_err(
            "synthesizer: R_AARCH64_CALL26 still pending after PLT pass \
             -- emit_aarch64_plt should have drained it",
        )),
        R_AARCH64_ADR_PREL_PG_HI21 => match reloc.target_section {
            NativeSymSection::Data | NativeSymSection::Bss => {
                data_fixups.push(DataFixup {
                    adrp_offset: reloc.text_offset as usize,
                    data_offset: reloc.addend as u64,
                });
                Ok(())
            }
            NativeSymSection::Text => {
                func_fixups.push(FuncFixup {
                    adrp_offset: reloc.text_offset as usize,
                    target_native_offset: reloc.addend as usize,
                });
                Ok(())
            }
            NativeSymSection::Undef => {
                got_fixups.push(GotFixup {
                    adrp_offset: reloc.text_offset as usize,
                    import_index: reloc.import_index,
                });
                Ok(())
            }
            other => Err(synth_err(&alloc::format!(
                "synthesizer: aarch64 ADR_PREL_PG_HI21 targeting {other:?} not supported"
            ))),
        },
        other => Err(synth_err(&alloc::format!(
            "synthesizer: aarch64 rtype {other} not supported"
        ))),
    }
}

fn project_x86_64_pending(
    reloc: &super::link::PendingImportReloc,
    got_fixups: &mut Vec<GotFixup>,
    data_fixups: &mut Vec<DataFixup>,
    func_fixups: &mut Vec<FuncFixup>,
) -> Result<(), C5Error> {
    if reloc.rtype != R_X86_64_PC32 && reloc.rtype != R_X86_64_PLT32 {
        return Err(synth_err(&alloc::format!(
            "synthesizer: x86_64 rtype {} not supported",
            reloc.rtype
        )));
    }
    match reloc.target_section {
        NativeSymSection::Data | NativeSymSection::Bss => {
            data_fixups.push(DataFixup {
                adrp_offset: reloc.text_offset as usize,
                data_offset: reloc.addend as u64,
            });
            Ok(())
        }
        NativeSymSection::Text => {
            func_fixups.push(FuncFixup {
                adrp_offset: reloc.text_offset as usize,
                target_native_offset: reloc.addend as usize,
            });
            Ok(())
        }
        NativeSymSection::Undef => {
            got_fixups.push(GotFixup {
                adrp_offset: reloc.text_offset as usize,
                import_index: reloc.import_index,
            });
            Ok(())
        }
        other => Err(synth_err(&alloc::format!(
            "synthesizer: x86_64 reloc targeting {other:?} not supported"
        ))),
    }
}

fn synth_relocs(merged: &MergedNative) -> (Vec<DataReloc>, Vec<CodeReloc>) {
    let mut data_relocs: Vec<DataReloc> = Vec::new();
    let mut code_relocs: Vec<CodeReloc> = Vec::new();
    for r in &merged.data_abs_relocs {
        match r.target_section {
            NativeSymSection::Data | NativeSymSection::Bss => {
                data_relocs.push(DataReloc {
                    data_offset: r.slot_offset,
                    target_offset: r.target_offset,
                });
            }
            NativeSymSection::Text => {
                code_relocs.push(CodeReloc {
                    data_offset: r.slot_offset,
                    target_ent_pc: r.target_offset,
                });
            }
            _ => {}
        }
    }
    (data_relocs, code_relocs)
}

/// `code_relocs` and `exports` reference functions by `ent_pc`.
/// The writer indexes `pc_to_native` with that PC to recover the
/// native code offset. For the synthesizer the PC is already the
/// byte offset within merged text, so the table is identity over
/// the entries each consumer references. Builds a Vec keyed by the
/// maximum PC actually referenced; entries outside the referenced
/// set stay `usize::MAX` and surface as a "missing ent_pc" error
/// if the writer reaches them.
fn synth_pc_to_native(
    text: &[u8],
    code_relocs: &[CodeReloc],
    exports: &[ExportedFunction],
) -> Vec<usize> {
    if code_relocs.is_empty() && exports.is_empty() {
        return Vec::new();
    }
    let mut max_pc = 0u64;
    for r in code_relocs {
        if r.target_ent_pc > max_pc {
            max_pc = r.target_ent_pc;
        }
    }
    for e in exports {
        if (e.ent_pc as u64) > max_pc {
            max_pc = e.ent_pc as u64;
        }
    }
    let len = (max_pc as usize).saturating_add(1).max(text.len());
    let mut table = alloc::vec![usize::MAX; len];
    for r in code_relocs {
        let pc = r.target_ent_pc as usize;
        if pc < table.len() {
            table[pc] = pc;
        }
    }
    for e in exports {
        if e.ent_pc < table.len() {
            table[e.ent_pc] = e.ent_pc;
        }
    }
    table
}

/// Surface user-defined Text-section symbols as ExportedFunction
/// entries so the per-format writer emits them into the static
/// symbol table (`nm` / `lldb image lookup`). This is the .o link
/// path's equivalent of the LinkUnit AOT path's func_names; per-
/// function source-position metadata (DWARF .debug_line, variable
/// records) isn't recovered yet -- a follow-up. The synthesizer
/// includes every Text-section merged symbol regardless of whether
/// the program asked for `#pragma export`, so the resulting
/// executable carries the same names the AOT path would dump under
/// `nm -a`.
fn synth_exports(merged: &MergedNative) -> Vec<ExportedFunction> {
    let mut exports: Vec<ExportedFunction> = Vec::new();
    for (name, sym) in &merged.defined {
        if !matches!(sym.section, NativeSymSection::Text) {
            continue;
        }
        exports.push(ExportedFunction {
            name: name.clone(),
            ent_pc: sym.value as usize,
        });
    }
    exports
}

fn synth_plt_offsets(merged: &MergedNative, plt: &[PltTrampoline]) -> Vec<usize> {
    let mut offsets = alloc::vec![0usize; merged.imports.len()];
    for t in plt {
        if t.import_index < offsets.len() {
            offsets[t.import_index] = t.text_offset;
        }
    }
    offsets
}

fn synth_err(msg: &str) -> C5Error {
    C5Error::Compile(crate::c5::error::fmt_internal_err(msg))
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::linker::link::MergedSymbol;

    fn tiny_aarch64_main() -> MergedNative {
        let mut defined = alloc::collections::BTreeMap::new();
        defined.insert(
            "main".to_string(),
            MergedSymbol {
                section: NativeSymSection::Text,
                value: 0,
                size: 8,
            },
        );
        MergedNative {
            // aarch64: `mov w0, #42; ret`.
            text: alloc::vec![0x40, 0x05, 0x80, 0x52, 0xc0, 0x03, 0x5f, 0xd6],
            data: alloc::vec![],
            bss_size: 0,
            defined,
            imports: alloc::vec![],
            pending_imports: alloc::vec![],
            data_abs_relocs: alloc::vec![],
            machine: NativeMachine::Aarch64,
            dylibs: alloc::vec![],
        }
    }

    #[test]
    fn synth_resolves_entry_offset() {
        let merged = tiny_aarch64_main();
        let off = resolve_entry_offset(&merged, "main").expect("entry resolves");
        assert_eq!(off, 0);
    }

    #[test]
    fn synth_rejects_missing_entry() {
        let merged = tiny_aarch64_main();
        let err = resolve_entry_offset(&merged, "no_such").expect_err("rejects");
        let msg = alloc::format!("{}", err);
        assert!(msg.contains("not defined"), "unexpected error: {msg}");
    }

    #[test]
    fn synth_rejects_target_machine_mismatch() {
        let mut merged = tiny_aarch64_main();
        merged.machine = NativeMachine::X86_64;
        let err = check_target_machine(Target::MacOSAarch64, merged.machine)
            .expect_err("mismatch rejected");
        let msg = alloc::format!("{}", err);
        assert!(msg.contains("expects"), "unexpected error: {msg}");
    }

    #[test]
    fn synth_imports_picks_libsystem_for_macos() {
        let mut merged = tiny_aarch64_main();
        // The .o writer stores each libc import under the
        // target's `real_symbol` from `#pragma binding`; the
        // synthesizer passes the name through verbatim.
        merged.imports = alloc::vec!["_malloc".to_string()];
        let imports = synth_imports(&merged, Target::MacOSAarch64);
        assert_eq!(imports.dylibs.len(), 1);
        assert!(
            imports.dylibs[0].path.contains("libSystem"),
            "unexpected dylib path: {}",
            imports.dylibs[0].path
        );
        assert_eq!(imports.imports.len(), 1);
        assert_eq!(imports.imports[0].real_symbol, "_malloc");
    }

    #[test]
    fn synth_imports_no_underscore_for_linux() {
        let mut merged = tiny_aarch64_main();
        merged.imports = alloc::vec!["malloc".to_string()];
        let imports = synth_imports(&merged, Target::LinuxAarch64);
        assert_eq!(imports.imports[0].real_symbol, "malloc");
    }

    #[test]
    fn synth_exports_lists_every_text_defined_symbol() {
        let mut merged = tiny_aarch64_main();
        merged.defined.insert(
            "helper".to_string(),
            MergedSymbol {
                section: NativeSymSection::Text,
                value: 0x40,
                size: 16,
            },
        );
        merged.defined.insert(
            "g_count".to_string(),
            MergedSymbol {
                section: NativeSymSection::Data,
                value: 0,
                size: 4,
            },
        );
        let exports = synth_exports(&merged);
        let names: alloc::vec::Vec<&str> = exports.iter().map(|e| e.name.as_str()).collect();
        assert!(names.contains(&"main"), "main missing from exports");
        assert!(names.contains(&"helper"), "helper missing from exports");
        assert!(
            !names.contains(&"g_count"),
            "data symbol surfaced as text export"
        );
    }
}
