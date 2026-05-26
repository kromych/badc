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
use crate::c5::program::{CodeReloc, DataReloc, Program};

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
    let (got_fixups, data_fixups, func_fixups) = synth_fixups(merged)?;
    let (data_relocs, code_relocs) = synth_relocs(merged);
    let plt_trampoline_offsets = synth_plt_offsets(merged, plt);

    let program = Program {
        data: Vec::new(),
        entry_pc: 0,
        warnings: Vec::new(),
        tls_data: Vec::new(),
        tls_init_size: 0,
        data_relocs: data_relocs.clone(),
        code_relocs: code_relocs.clone(),
        exports: Vec::new(),
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
        pc_to_native: Vec::new(),
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
        exports: Vec::new(),
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
    let dylib = match target {
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
    };
    let imports: Vec<ResolvedImport> = merged
        .imports
        .iter()
        .enumerate()
        .map(|(i, name)| ResolvedImport {
            binding_idx: i as i64,
            local_name: name.clone(),
            real_symbol: target_real_symbol(target, name),
            dylib_index: 0,
            is_variadic: false,
            fixed_args: 0,
            return_type_tag: 0,
            returns_long_double: false,
            param_types: Vec::new(),
        })
        .collect();
    ResolvedImports {
        imports,
        dylibs: alloc::vec![dylib],
    }
}

fn linux_libc_path(target: Target) -> String {
    match target {
        Target::LinuxAarch64 => "/lib/ld-linux-aarch64.so.1".to_string(),
        Target::LinuxX64 => "/lib64/ld-linux-x86-64.so.2".to_string(),
        _ => String::new(),
    }
}

fn target_real_symbol(target: Target, local: &str) -> String {
    match target {
        Target::MacOSAarch64 => alloc::format!("_{local}"),
        _ => local.to_string(),
    }
}

/// Project [`MergedNative::pending_imports`] into the per-arch
/// `(adrp, ldr/add)` paired fixup streams the writer consumes.
///
/// MergedNative carries one entry per ELF relocation. aarch64
/// address-of-symbol sequences are two relocations on consecutive
/// instructions (ADRP at `text_offset`, ADD/LDR at
/// `text_offset + 4`). The synthesizer pairs them by `adrp_offset`
/// and emits one fixup per pair.
fn synth_fixups(
    merged: &MergedNative,
) -> Result<(Vec<GotFixup>, Vec<DataFixup>, Vec<FuncFixup>), C5Error> {
    let mut got_fixups: Vec<GotFixup> = Vec::new();
    let mut data_fixups: Vec<DataFixup> = Vec::new();
    let mut func_fixups: Vec<FuncFixup> = Vec::new();
    let _ = (&mut got_fixups, &mut data_fixups, &mut func_fixups, merged);
    // TODO: pair pending_imports by (adrp_offset, ldr/add at adrp+4)
    // and classify by target_section. Requires per-kind matching
    // against R_AARCH64_ADR_PREL_PG_HI21 / ADD_ABS_LO12_NC plus
    // detecting the GOT-load variant introduced by the per-format
    // PLT lowering. Tracked as a baseline blocker; the empty
    // streams here let the rest of the synthesizer compile so the
    // wire-up + smoke test land before the per-arch fixup work.
    Ok((got_fixups, data_fixups, func_fixups))
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
        merged.imports = alloc::vec!["malloc".to_string()];
        let imports = synth_imports(&merged, Target::MacOSAarch64);
        assert_eq!(imports.dylibs.len(), 1);
        assert!(
            imports.dylibs[0].path.contains("libSystem"),
            "unexpected dylib path: {}",
            imports.dylibs[0].path
        );
        assert_eq!(imports.imports.len(), 1);
        assert_eq!(imports.imports[0].local_name, "malloc");
        assert_eq!(imports.imports[0].real_symbol, "_malloc");
    }

    #[test]
    fn synth_imports_no_underscore_for_linux() {
        let mut merged = tiny_aarch64_main();
        merged.imports = alloc::vec!["malloc".to_string()];
        let imports = synth_imports(&merged, Target::LinuxAarch64);
        assert_eq!(imports.imports[0].real_symbol, "malloc");
    }
}

