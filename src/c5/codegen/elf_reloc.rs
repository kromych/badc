//! ELF64 ET_REL writer -- emits a standard relocatable object
//! file from a per-TU [`Build`]. The result is consumable by
//! `ld` / `lld`: `.text` carries the per-function machine code,
//! `.data` / `.bss` carry the static segment, `.symtab` /
//! `.strtab` list the function names, and `.rela.text` records
//! cross-TU references the linker resolves at link time.
//!
//! Distinct from `codegen/elf.rs`, which writes ET_EXEC /
//! ET_DYN load-time images. The relocatable writer is the
//! produces-`.o` side of the planned native-object pipeline;
//! the linker concats one or more `.o` files into a final image.
//!
//! Scope today (intentionally narrow):
//!   * Single-section `.text`, `.data`, `.bss`.
//!   * `.symtab` entries: a file symbol + one `STT_FUNC` per
//!     emitted function (from `Build::func_ent_pcs`).
//!   * No `.rela.text` entries yet; cross-TU references error.
//!     The reloc encoding land next iteration.

#![cfg(feature = "std")]
// The relocatable writer is the entry point for the new native
// `.o` pipeline; until the CLI / compile path is wired to call
// it, every helper and constant in this file is dead-code-only
// from the surrounding codegen. Tagged module-wide so the
// dead-code lint doesn't fire while the wiring lands in the
// next commit.
#![allow(dead_code)]

use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use super::super::error::C5Error;
use super::Build;
use super::Machine;

// ELF64 constants (Elf.h subset).
const ELF_CLASS_64: u8 = 2;
const ELF_DATA_LSB: u8 = 1;
const ELF_VERSION_CURRENT: u8 = 1;
const ET_REL: u16 = 1;
const EM_X86_64: u16 = 62;
const EM_AARCH64: u16 = 183;
const SHT_NULL: u32 = 0;
const SHT_PROGBITS: u32 = 1;
const SHT_SYMTAB: u32 = 2;
const SHT_STRTAB: u32 = 3;
const SHT_NOBITS: u32 = 8;
const SHF_WRITE: u64 = 0x1;
const SHF_ALLOC: u64 = 0x2;
const SHF_EXECINSTR: u64 = 0x4;
const STB_LOCAL: u8 = 0;
const STB_GLOBAL: u8 = 1;
const STT_NOTYPE: u8 = 0;
const STT_OBJECT: u8 = 1;
const STT_FUNC: u8 = 2;
const STT_FILE: u8 = 4;
const STT_SECTION: u8 = 3;
const SHN_UNDEF: u16 = 0;
const SHN_ABS: u16 = 0xfff1;

const ELF64_EHDR_SIZE: usize = 64;
const ELF64_SHDR_SIZE: usize = 64;
const ELF64_SYM_SIZE: usize = 24;

#[repr(C)]
#[derive(Copy, Clone)]
struct Elf64Ehdr {
    e_ident: [u8; 16],
    e_type: u16,
    e_machine: u16,
    e_version: u32,
    e_entry: u64,
    e_phoff: u64,
    e_shoff: u64,
    e_flags: u32,
    e_ehsize: u16,
    e_phentsize: u16,
    e_phnum: u16,
    e_shentsize: u16,
    e_shnum: u16,
    e_shstrndx: u16,
}
const _: () = assert!(core::mem::size_of::<Elf64Ehdr>() == ELF64_EHDR_SIZE);

#[repr(C)]
#[derive(Copy, Clone, Default)]
struct Elf64Shdr {
    sh_name: u32,
    sh_type: u32,
    sh_flags: u64,
    sh_addr: u64,
    sh_offset: u64,
    sh_size: u64,
    sh_link: u32,
    sh_info: u32,
    sh_addralign: u64,
    sh_entsize: u64,
}
const _: () = assert!(core::mem::size_of::<Elf64Shdr>() == ELF64_SHDR_SIZE);

#[repr(C)]
#[derive(Copy, Clone, Default)]
struct Elf64Sym {
    st_name: u32,
    st_info: u8,
    st_other: u8,
    st_shndx: u16,
    st_value: u64,
    st_size: u64,
}
const _: () = assert!(core::mem::size_of::<Elf64Sym>() == ELF64_SYM_SIZE);

fn write_struct<T: Copy>(out: &mut Vec<u8>, value: &T) {
    let bytes = unsafe {
        core::slice::from_raw_parts((value as *const T) as *const u8, core::mem::size_of::<T>())
    };
    out.extend_from_slice(bytes);
}

fn round_up(n: u64, align: u64) -> u64 {
    if align == 0 {
        return n;
    }
    n.div_ceil(align) * align
}

/// Build a NUL-separated string blob. Returns (`bytes`, `offsets`)
/// where `offsets[i]` is the offset of `names[i]` in `bytes`.
/// `bytes[0]` is the leading NUL so offset 0 indexes the empty
/// string per the ELF convention.
fn build_strtab(names: &[&str]) -> (Vec<u8>, Vec<u32>) {
    let mut bytes = Vec::new();
    bytes.push(0);
    let mut offsets = Vec::with_capacity(names.len());
    for name in names {
        offsets.push(bytes.len() as u32);
        bytes.extend_from_slice(name.as_bytes());
        bytes.push(0);
    }
    (bytes, offsets)
}

fn e_machine_for(machine: Machine) -> u16 {
    match machine {
        Machine::X86_64 => EM_X86_64,
        Machine::Aarch64 => EM_AARCH64,
    }
}

/// Emit a relocatable ELF64 object holding the contents of
/// `build`. The result is a standard `.o` that `ld` / `lld` can
/// link (modulo missing relocations -- the writer doesn't yet
/// emit `.rela.text`, so a TU with cross-TU calls produces a
/// link error today).
pub(super) fn write_relocatable(
    build: &Build,
    machine: Machine,
    source_path: &str,
) -> Result<Vec<u8>, C5Error> {
    // Section layout (indices used in symtab st_shndx):
    //   1 = .text
    //   2 = .data
    //   3 = .bss
    //   4 = .symtab
    //   5 = .strtab
    //   6 = .shstrtab
    // Plus the null section at index 0.
    const SHIDX_TEXT: u16 = 1;
    const SHIDX_DATA: u16 = 2;
    const SHIDX_BSS: u16 = 3;
    const SHIDX_SYMTAB: u16 = 4;
    const SHIDX_STRTAB: u16 = 5;
    const SHIDX_SHSTRTAB: u16 = 6;
    const NUM_SECTIONS: usize = 7;

    // Strtab + symtab construction. The file symbol leads
    // (binding LOCAL, type FILE); per-function symbols follow
    // (binding GLOBAL, type FUNC). ELF requires every LOCAL
    // symbol to precede every GLOBAL one, with sh_info pointing
    // at the first GLOBAL entry.
    let file_basename = source_path.rsplit('/').next().unwrap_or("<unknown>");

    // Section symbols come first after the file symbol; we
    // emit one for each progbits section so relocations can
    // address them by section index.
    let mut symbols: Vec<Elf64Sym> = Vec::new();
    // Index 0 in symtab is the conventional all-zero null
    // entry.
    symbols.push(Elf64Sym::default());

    // File symbol -> shndx = SHN_ABS by convention. Name offset
    // gets backfilled below once the final strtab is built.
    symbols.push(Elf64Sym {
        st_name: 0,
        st_info: pack_sym_info(STB_LOCAL, STT_FILE),
        st_shndx: SHN_ABS,
        ..Default::default()
    });

    // Section symbols (.text, .data, .bss). Each has empty name
    // and SHN of the matching section.
    for shndx in [SHIDX_TEXT, SHIDX_DATA, SHIDX_BSS] {
        symbols.push(Elf64Sym {
            st_info: pack_sym_info(STB_LOCAL, STT_SECTION),
            st_shndx: shndx,
            ..Default::default()
        });
    }
    let first_global = symbols.len() as u32;

    // Function symbols. The build records each emitted function's
    // entry bc_pc in `func_ent_pcs`; the matching native offset
    // lives at `bytecode_to_native[ent_pc]`. The function name --
    // when available -- comes from `program.source_functions`
    // via the existing DWARF builder's path. Here we synthesise
    // a `fn_<ent_pc>` placeholder; the real name plumbing lands
    // next.
    let mut func_strs: Vec<String> = Vec::with_capacity(build.func_ent_pcs.len());
    for ent_pc in &build.func_ent_pcs {
        func_strs.push(format!("fn_{ent_pc}"));
    }
    // Rebuild strtab now that all names are known.
    let mut all_names: Vec<&str> = Vec::with_capacity(1 + func_strs.len());
    all_names.push(file_basename);
    for s in &func_strs {
        all_names.push(s.as_str());
    }
    let (strtab_bytes, name_offs) = build_strtab(&all_names);
    // Patch the file symbol's name offset against the final
    // strtab.
    symbols[1].st_name = name_offs[0];

    // Function symbols. Each gets the native offset within
    // `.text` and a placeholder size of (end_native - start_native).
    for (i, &ent_pc) in build.func_ent_pcs.iter().enumerate() {
        let lo = build
            .bytecode_to_native
            .get(ent_pc)
            .copied()
            .unwrap_or(usize::MAX);
        if lo == usize::MAX {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!(
                    "elf_reloc: function ent_pc {ent_pc} has no native offset in bytecode_to_native",
                ),
            )));
        }
        // Function size: from `lo` to the next function's
        // native offset (or end of .text for the last).
        let hi = build
            .func_ent_pcs
            .get(i + 1)
            .and_then(|&next_ent| build.bytecode_to_native.get(next_ent).copied())
            .unwrap_or(build.text.len());
        symbols.push(Elf64Sym {
            st_name: name_offs[1 + i],
            st_info: pack_sym_info(STB_GLOBAL, STT_FUNC),
            st_shndx: SHIDX_TEXT,
            st_value: lo as u64,
            st_size: hi.saturating_sub(lo) as u64,
            ..Default::default()
        });
    }

    let symtab_bytes: Vec<u8> = symbols
        .iter()
        .flat_map(|s| {
            let mut v = Vec::with_capacity(ELF64_SYM_SIZE);
            write_struct(&mut v, s);
            v
        })
        .collect();

    // Section name table.
    let (shstrtab_bytes, shstrtab_offs) =
        build_strtab(&[".text", ".data", ".bss", ".symtab", ".strtab", ".shstrtab"]);

    // Section data layout. Each section's offset starts at the
    // running tail of the output, rounded to its alignment.
    let mut out: Vec<u8> = alloc::vec![0u8; ELF64_EHDR_SIZE];

    let mut sh: Vec<Elf64Shdr> = Vec::with_capacity(NUM_SECTIONS);
    sh.push(Elf64Shdr::default()); // SHN_UNDEF

    // .text
    let text_off = round_up(out.len() as u64, 16);
    out.resize(text_off as usize, 0);
    out.extend_from_slice(&build.text);
    sh.push(Elf64Shdr {
        sh_name: shstrtab_offs[0],
        sh_type: SHT_PROGBITS,
        sh_flags: SHF_ALLOC | SHF_EXECINSTR,
        sh_offset: text_off,
        sh_size: build.text.len() as u64,
        sh_addralign: 16,
        ..Default::default()
    });

    // .data
    let data_off = round_up(out.len() as u64, 8);
    out.resize(data_off as usize, 0);
    out.extend_from_slice(&build.data);
    sh.push(Elf64Shdr {
        sh_name: shstrtab_offs[1],
        sh_type: SHT_PROGBITS,
        sh_flags: SHF_ALLOC | SHF_WRITE,
        sh_offset: data_off,
        sh_size: build.data.len() as u64,
        sh_addralign: 8,
        ..Default::default()
    });

    // .bss (no file bytes)
    sh.push(Elf64Shdr {
        sh_name: shstrtab_offs[2],
        sh_type: SHT_NOBITS,
        sh_flags: SHF_ALLOC | SHF_WRITE,
        sh_offset: out.len() as u64,
        sh_size: 0,
        sh_addralign: 8,
        ..Default::default()
    });

    // .symtab
    let symtab_off = round_up(out.len() as u64, 8);
    out.resize(symtab_off as usize, 0);
    out.extend_from_slice(&symtab_bytes);
    sh.push(Elf64Shdr {
        sh_name: shstrtab_offs[3],
        sh_type: SHT_SYMTAB,
        sh_offset: symtab_off,
        sh_size: symtab_bytes.len() as u64,
        sh_link: SHIDX_STRTAB as u32,
        sh_info: first_global,
        sh_addralign: 8,
        sh_entsize: ELF64_SYM_SIZE as u64,
        ..Default::default()
    });

    // .strtab
    let strtab_off = out.len() as u64;
    out.extend_from_slice(&strtab_bytes);
    sh.push(Elf64Shdr {
        sh_name: shstrtab_offs[4],
        sh_type: SHT_STRTAB,
        sh_offset: strtab_off,
        sh_size: strtab_bytes.len() as u64,
        sh_addralign: 1,
        ..Default::default()
    });

    // .shstrtab
    let shstrtab_off = out.len() as u64;
    out.extend_from_slice(&shstrtab_bytes);
    sh.push(Elf64Shdr {
        sh_name: shstrtab_offs[5],
        sh_type: SHT_STRTAB,
        sh_offset: shstrtab_off,
        sh_size: shstrtab_bytes.len() as u64,
        sh_addralign: 1,
        ..Default::default()
    });

    debug_assert_eq!(sh.len(), NUM_SECTIONS);

    // Section header table at the tail. Rounded to 8 so the
    // headers' u64 fields read cleanly.
    let shoff = round_up(out.len() as u64, 8);
    out.resize(shoff as usize, 0);
    for entry in &sh {
        write_struct(&mut out, entry);
    }

    // Patch the file header now that all offsets are known.
    let mut e_ident = [0u8; 16];
    e_ident[0..4].copy_from_slice(b"\x7fELF");
    e_ident[4] = ELF_CLASS_64;
    e_ident[5] = ELF_DATA_LSB;
    e_ident[6] = ELF_VERSION_CURRENT;
    let ehdr = Elf64Ehdr {
        e_ident,
        e_type: ET_REL,
        e_machine: e_machine_for(machine),
        e_version: ELF_VERSION_CURRENT as u32,
        e_entry: 0,
        e_phoff: 0,
        e_shoff: shoff,
        e_flags: 0,
        e_ehsize: ELF64_EHDR_SIZE as u16,
        e_phentsize: 0,
        e_phnum: 0,
        e_shentsize: ELF64_SHDR_SIZE as u16,
        e_shnum: NUM_SECTIONS as u16,
        e_shstrndx: SHIDX_SHSTRTAB,
    };
    let mut hdr_bytes: Vec<u8> = Vec::with_capacity(ELF64_EHDR_SIZE);
    write_struct(&mut hdr_bytes, &ehdr);
    out[..ELF64_EHDR_SIZE].copy_from_slice(&hdr_bytes);

    Ok(out)
}

fn pack_sym_info(bind: u8, ty: u8) -> u8 {
    (bind << 4) | (ty & 0xf)
}

#[cfg(test)]
mod tests {
    use super::*;

    /// Sanity: an empty Build produces a valid ELF header that
    /// `readelf -h` would accept.
    #[test]
    fn empty_build_produces_valid_header() {
        let build = empty_build_for(Machine::X86_64);
        let bytes = write_relocatable(&build, Machine::X86_64, "test.c").expect("write");
        assert!(bytes.len() >= ELF64_EHDR_SIZE);
        assert_eq!(&bytes[0..4], b"\x7fELF");
        assert_eq!(bytes[4], ELF_CLASS_64);
        assert_eq!(bytes[5], ELF_DATA_LSB);
        let e_type = u16::from_le_bytes([bytes[16], bytes[17]]);
        assert_eq!(e_type, ET_REL);
        let e_machine = u16::from_le_bytes([bytes[18], bytes[19]]);
        assert_eq!(e_machine, EM_X86_64);
    }

    fn empty_build_for(_machine: Machine) -> Build {
        use super::super::{Abi, OutputKind, ResolvedImports};
        Build {
            text: Vec::new(),
            data: Vec::new(),
            entry_offset: 0,
            got_fixups: Vec::new(),
            data_fixups: Vec::new(),
            func_fixups: Vec::new(),
            bytecode_to_native: Vec::new(),
            func_ent_pcs: Vec::new(),
            ssa_line_rows: Vec::new(),
            imports: ResolvedImports::default(),
            abi: Abi::default(),
            tls_data: Vec::new(),
            tls_init_size: 0,
            tls_index_fixups: Vec::new(),
            data_relocs: Vec::new(),
            code_relocs: Vec::new(),
            exports: Vec::new(),
            output_kind: OutputKind::Relocatable,
            dllmain_pc: None,
            macho_tlv_fixups: Vec::new(),
            macho_tlv_descriptors: Vec::new(),
            debug_info: false,
            plt_trampoline_offsets: Vec::new(),
        }
    }
}
