//! What the three final-image writers share: the pointer initializers baked
//! into the data image, the TLS template's address constants, the
//! switch-table entries, and the DWARF sections of an image.

use crate::c5::diag::Code;
use alloc::format;
use alloc::vec::Vec;

use super::super::error::C5Error;
use super::super::program::Program;
use super::{Build, Target, dwarf};

fn internal(msg: alloc::string::String) -> C5Error {
    C5Error::Compile(crate::c5::error::fmt_internal_diag(Code::INTERNAL, &msg))
}

/// The data image past the read-only prefix with every pointer initializer
/// resolved to its link-time address (the writer's load-time relocation
/// slides it) and every object-linked pc-relative slot holding `target -
/// slot` at its width, which slides on its own.
pub(crate) fn bake_data_relocs(
    format: &str,
    span: &str,
    build: &Build,
    ro_len: u64,
    text_vmaddr: u64,
    data_off_to_vaddr: &dyn Fn(u64) -> u64,
) -> Result<Vec<u8>, C5Error> {
    let mut data = build.data[ro_len as usize..].to_vec();
    let slot =
        |data: &[u8], data_offset: u64, kind: &str, width: usize| -> Result<usize, C5Error> {
            let off = super::reloc_slot_in_data(format, data_offset, ro_len, kind)?;
            if off + width > data.len() {
                return Err(internal(format!(
                    "{format}: {kind} reloc offset {off:#x} past end of {span} ({})",
                    data.len()
                )));
            }
            Ok(off)
        };
    for r in &build.data_relocs {
        let absolute = data_off_to_vaddr(r.target_anchor)
            .wrapping_add(r.target_offset.wrapping_sub(r.target_anchor));
        let off = slot(&data, r.data_offset, "data", 8)?;
        data[off..off + 8].copy_from_slice(&absolute.to_le_bytes());
    }
    for r in &build.code_relocs {
        let ent_pc = r.target_ent_pc as usize;
        let native_off = build
            .pc_to_native
            .get(ent_pc)
            .copied()
            .unwrap_or(usize::MAX);
        if native_off == usize::MAX {
            return Err(internal(format!(
                "{format}: code reloc references missing ent_pc {ent_pc}"
            )));
        }
        let absolute = text_vmaddr + native_off as u64;
        let off = slot(&data, r.data_offset, "code", 8)?;
        #[cfg(feature = "codegen_test")]
        if std::env::var("BADC_DEBUG_CODE_RELOCS").is_ok() {
            std::eprintln!(
                "[code_reloc] data_off={:#x} target_ent_pc={} native_off={:#x} preferred_va={:#x}",
                r.data_offset,
                ent_pc,
                native_off,
                absolute,
            );
        }
        data[off..off + 8].copy_from_slice(&absolute.to_le_bytes());
    }
    for r in &build.label_relocs {
        let absolute = text_vmaddr + r.text_offset;
        let off = slot(&data, r.data_offset, "label", 8)?;
        data[off..off + 8].copy_from_slice(&absolute.to_le_bytes());
    }
    for r in &build.data_pcrel_relocs {
        let target = if r.target_in_data {
            data_off_to_vaddr(r.target_anchor)
                .wrapping_add(r.target_offset.wrapping_sub(r.target_anchor))
        } else {
            text_vmaddr + r.target_offset
        };
        let slot_vaddr = data_off_to_vaddr(r.slot_data_offset);
        let width = r.width as usize;
        let off = super::reloc_slot_in_data(format, r.slot_data_offset, ro_len, "pcrel")?;
        if off + width > data.len() {
            return Err(internal(format!(
                "{format}: data pcrel slot {off:#x} past end of {span} ({})",
                data.len()
            )));
        }
        let value = target as i64 - slot_vaddr as i64;
        if width == 8 {
            data[off..off + 8].copy_from_slice(&value.to_le_bytes());
            continue;
        }
        let Ok(v) = i32::try_from(value) else {
            return Err(internal(format!(
                "{format}: data pcrel slot {off:#x}: displacement {value:#x} exceeds 32 bits"
            )));
        };
        data[off..off + 4].copy_from_slice(&v.to_le_bytes());
    }
    Ok(data)
}

/// Address-constant initializers of `_Thread_local` objects, as `(offset
/// within the TLS template, link-time absolute target)`.
pub(crate) fn tls_reloc_sites(
    format: &str,
    build: &Build,
    data_off_to_vaddr: &dyn Fn(u64) -> u64,
    text_vmaddr: u64,
) -> Result<Vec<(usize, u64)>, C5Error> {
    if let Some(r) = build.tls_extern_data_relocs.first() {
        return Err(C5Error::Compile(crate::c5::error::fmt_link_diag(
            Code::UNDEFINED_SYMBOL,
            &format!(
                "undefined reference to `{}` in a `_Thread_local` initializer: \
             the template's address constant must resolve within the image",
                r.symbol_name,
            ),
        )));
    }
    let mut sites = Vec::with_capacity(build.tls_data_relocs.len() + build.tls_code_relocs.len());
    for r in &build.tls_data_relocs {
        let absolute = data_off_to_vaddr(r.target_anchor)
            .wrapping_add(r.target_offset.wrapping_sub(r.target_anchor));
        sites.push((r.data_offset as usize, absolute));
    }
    for r in &build.tls_code_relocs {
        let ent_pc = r.target_ent_pc as usize;
        let Some(&native_off) = build.pc_to_native.get(ent_pc) else {
            return Err(internal(format!(
                "{format}: TLS code reloc references missing ent_pc {ent_pc}"
            )));
        };
        sites.push((r.data_offset as usize, text_vmaddr + native_off as u64));
    }
    sites.sort_unstable();
    Ok(sites)
}

/// The TLS template with its address constants resolved.
pub(crate) fn bake_tls_template(
    format: &str,
    span: &str,
    template: &[u8],
    sites: &[(usize, u64)],
) -> Result<Vec<u8>, C5Error> {
    let mut out = template.to_vec();
    for &(off, absolute) in sites {
        if off + 8 > out.len() {
            return Err(internal(format!(
                "{format}: TLS reloc offset {off:#x} past end of {span} ({})",
                out.len()
            )));
        }
        out[off..off + 8].copy_from_slice(&absolute.to_le_bytes());
    }
    Ok(out)
}

/// Each switch-table entry as `target - table_base`, a difference that
/// slides with the image.
pub(crate) fn patch_jump_table(
    format: &str,
    slot: &str,
    table: &mut [u8],
    text_vmaddr: u64,
    jt_vmaddr: u64,
    rel32: &[crate::c5::codegen::RodataRel32],
) -> Result<(), C5Error> {
    for r in rel32 {
        let value = (text_vmaddr + r.text_offset) as i64 - (jt_vmaddr + r.base_offset) as i64;
        let Ok(v) = i32::try_from(value) else {
            return Err(internal(format!(
                "{format}: {slot} slot {:#x}: displacement {value:#x} exceeds 32 bits",
                r.slot_offset,
            )));
        };
        let at = r.slot_offset as usize;
        table[at..at + 4].copy_from_slice(&v.to_le_bytes());
    }
    Ok(())
}

/// The DWARF sections of an image.
pub(crate) fn image_dwarf(
    program: &Program,
    build: &Build,
    target: Target,
    text_vmaddr: u64,
    start_stub_range: Option<(u64, u64)>,
    data: Option<&dyn Fn(u64) -> u64>,
) -> Result<dwarf::DwarfSections, C5Error> {
    let fresh = || {
        dwarf::emit(
            program,
            build,
            target,
            text_vmaddr,
            &program.source_path,
            start_stub_range,
        )
    };
    if let Some(md) = &build.merged_dwarf {
        let mut debug_info = md.debug_info.clone();
        let mut debug_line = md.debug_line.clone();
        for r in &md.debug_info_text_relocs {
            super::apply_merged_dwarf_text_reloc(&mut debug_info, r, text_vmaddr)?;
        }
        for r in &md.debug_line_text_relocs {
            super::apply_merged_dwarf_text_reloc(&mut debug_line, r, text_vmaddr)?;
        }
        if let Some(data) = data {
            for r in &md.debug_info_data_relocs {
                super::apply_merged_dwarf_data_reloc(&mut debug_info, r, data)?;
            }
        }
        return Ok(dwarf::DwarfSections {
            debug_info,
            debug_abbrev: md.debug_abbrev.clone(),
            debug_line,
            debug_str: md.debug_str.clone(),
            debug_frame: fresh().debug_frame,
        });
    }
    Ok(if build.debug_info {
        fresh()
    } else {
        dwarf::DwarfSections::default()
    })
}
