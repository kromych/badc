//! ELF64 ET_REL writer -- emits a standard relocatable object
//! from a per-TU [`Build`]. Consumable by `ld` / `lld`:
//! `.text` carries the per-function machine code,
//! `.data` / `.bss` carry the static segment, `.symtab` /
//! `.strtab` list function and global names, and `.rela.text`
//! records cross-TU and libc-import references the linker
//! resolves at link time.
//!
//! Sections emitted: `.text`, `.data`, `.bss`, `.rela.text`,
//! `.symtab`, `.strtab`, `.shstrtab` plus the null section.
//! `.symtab` carries: file symbol, the three section symbols,
//! one `STT_FUNC STB_LOCAL` per `static`-linkage function and
//! one `STT_FUNC STB_GLOBAL` per externally-linked function,
//! libc imports as `STT_NOTYPE STB_WEAK` (the dynamic linker
//! resolves them at load time), cross-TU function and data
//! UNDEFs as `STB_GLOBAL` (the linker rejects unresolved
//! `STB_GLOBAL` UNDEF as `undefined reference to <name>`),
//! and defined data globals as `STT_OBJECT STB_GLOBAL`.
//!
//! Distinct from `codegen/elf.rs`, which writes ET_EXEC /
//! ET_DYN load-time images.

#![cfg(feature = "std")]

use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use super::super::error::C5Error;
use super::super::program::Program;
use super::Build;
use super::Machine;

// ELF64 constants (Elf.h subset).
const ELF_CLASS_64: u8 = 2;
const ELF_DATA_LSB: u8 = 1;
const ELF_VERSION_CURRENT: u8 = 1;
const ET_REL: u16 = 1;
const EM_X86_64: u16 = 62;
const EM_AARCH64: u16 = 183;
const SHT_PROGBITS: u32 = 1;
const SHT_SYMTAB: u32 = 2;
const SHT_STRTAB: u32 = 3;
const SHT_RELA: u32 = 4;
const SHT_NOBITS: u32 = 8;
const SHF_WRITE: u64 = 0x1;
const SHF_ALLOC: u64 = 0x2;
const SHF_EXECINSTR: u64 = 0x4;
const SHF_INFO_LINK: u64 = 0x40;

// x86_64 reloc types (System V psABI x86_64 supplement, table 4.10).
const R_X86_64_PC32: u32 = 2;
const R_X86_64_PLT32: u32 = 4;

// AArch64 reloc types (ELF for the ARM 64-bit architecture, table 5-1).
const R_AARCH64_ADR_PREL_PG_HI21: u32 = 275;
const R_AARCH64_ADD_ABS_LO12_NC: u32 = 277;
const R_AARCH64_CALL26: u32 = 283;
const STB_LOCAL: u8 = 0;
const STB_GLOBAL: u8 = 1;
const STB_WEAK: u8 = 2;
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
const ELF64_RELA_SIZE: usize = 24;

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
struct Elf64Rela {
    r_offset: u64,
    r_info: u64,
    r_addend: i64,
}
const _: () = assert!(core::mem::size_of::<Elf64Rela>() == ELF64_RELA_SIZE);

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
    program: &Program,
    build: &Build,
    machine: Machine,
) -> Result<Vec<u8>, C5Error> {
    let source_path = program.source_path.as_str();
    // Section layout (indices used in symtab st_shndx):
    //   1 = .text
    //   2 = .rela.text
    //   3 = .data
    //   4 = .bss
    //   5 = .symtab
    //   6 = .strtab
    //   7 = .shstrtab
    // Plus the null section at index 0.
    const SHIDX_TEXT: u16 = 1;
    const SHIDX_DATA: u16 = 3;
    const SHIDX_BSS: u16 = 4;
    const SHIDX_SYMTAB: u16 = 5;
    const SHIDX_STRTAB: u16 = 6;
    const SHIDX_SHSTRTAB: u16 = 7;
    const NUM_SECTIONS: usize = 8;

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
    // `first_global` is set after the static-linkage function
    // symbols are pushed below; ELF requires every LOCAL symbol
    // to precede every GLOBAL one and `.symtab`'s `sh_info`
    // points at the first GLOBAL entry.

    // Function symbols. The build records each emitted function's
    // entry bc_pc in `func_ent_pcs`; the matching native offset
    // lives at `bytecode_to_native[ent_pc]`. The function name --
    // when available -- comes from `program.source_functions`
    // via the existing DWARF builder's path. Here we synthesise
    // a `fn_<ent_pc>` placeholder; the real name plumbing lands
    // next.
    // Function names come from `program.source_functions`,
    // indexed by bc_pc; empty entries fall back to a
    // `fn_<ent_pc>` placeholder so every symbol has a non-zero
    // name regardless of whether the parser tracked it.
    //
    // C99 6.2.2 + 6.7.1: a `static` function has internal
    // linkage and must not surface to sibling TUs. The ET_REL
    // writer maps `Linkage::Internal` to `STB_LOCAL`;
    // everything else (`Linkage::External` and the default
    // `None` used for the synthetic CRT entry) maps to
    // `STB_GLOBAL`. ELF requires LOCAL symbols to precede
    // GLOBAL ones in `.symtab`, so split the function list now
    // and merge the emit order below.
    let func_linkage_by_pc: alloc::collections::BTreeMap<usize, crate::c5::symbol::Linkage> = {
        use crate::c5::token::Token;
        program
            .symbols
            .iter()
            .filter(|s| s.class == Token::Fun as i64 && s.defined_here)
            .map(|s| (s.val as usize, s.linkage))
            .collect()
    };
    let mut local_func_idxs: Vec<usize> = Vec::new();
    let mut global_func_idxs: Vec<usize> = Vec::new();
    let mut func_strs: Vec<String> = Vec::with_capacity(build.func_ent_pcs.len());
    for (i, &ent_pc) in build.func_ent_pcs.iter().enumerate() {
        let name = program
            .source_functions
            .get(ent_pc)
            .filter(|s| !s.is_empty())
            .cloned()
            .unwrap_or_else(|| format!("fn_{ent_pc}"));
        func_strs.push(name);
        match func_linkage_by_pc.get(&ent_pc) {
            Some(crate::c5::symbol::Linkage::Internal) => local_func_idxs.push(i),
            _ => global_func_idxs.push(i),
        }
    }
    // Unique cross-TU user-function names referenced by
    // `user_extern_call_sites`. Each gets exactly one
    // undefined symbol entry; multiple call sites against the
    // same callee share it.
    let mut user_extern_names: Vec<&str> = Vec::new();
    for site in &build.user_extern_call_sites {
        let s = site.symbol_name.as_str();
        if !user_extern_names.contains(&s) {
            user_extern_names.push(s);
        }
    }

    // Defined data globals visible to other TUs. C99 6.2.2 +
    // 6.9.2: every file-scope object with external linkage
    // surfaces as a named STT_OBJECT symbol. The cross-TU
    // linker needs the name to resolve `extern T x;`
    // references in sibling units. `Symbol::val` is the byte
    // offset within `.data`; size is left at zero (the parser
    // doesn't track per-symbol storage size yet; tools that
    // need it consult DWARF).
    let mut defined_data_globals: Vec<(&str, i64)> = Vec::new();
    {
        use crate::c5::symbol::Linkage;
        use crate::c5::token::Token;
        for sym in &program.symbols {
            if sym.class == Token::Glo as i64
                && sym.defined_here
                && sym.linkage == Linkage::External
                && !sym.name.is_empty()
            {
                defined_data_globals.push((sym.name.as_str(), sym.val));
            }
        }
    }

    // Unique cross-TU user-data names referenced by
    // `user_extern_data_refs`. Same dedup shape as the function
    // case above.
    let mut user_extern_data_names: Vec<&str> = Vec::new();
    for r in &build.user_extern_data_refs {
        let s = r.symbol_name.as_str();
        if !user_extern_data_names.contains(&s) {
            user_extern_data_names.push(s);
        }
    }

    // Rebuild strtab now that all names are known: file
    // basename + function names + libc-import symbol names +
    // cross-TU user-function names + defined data globals +
    // cross-TU user-data names.
    let mut all_names: Vec<&str> = Vec::with_capacity(
        1 + func_strs.len()
            + build.imports.imports.len()
            + user_extern_names.len()
            + defined_data_globals.len()
            + user_extern_data_names.len(),
    );
    all_names.push(file_basename);
    for s in &func_strs {
        all_names.push(s.as_str());
    }
    let func_strs_end = all_names.len();
    // Use the portable `local_name` for the .o-level symbol --
    // the relocatable is the badc-internal format on every
    // target. Per-OS decoration (the leading underscore on
    // Mach-O, no decoration on ELF, etc.) belongs to the
    // final-image writer that converts the .o into the target
    // container.
    for imp in &build.imports.imports {
        all_names.push(imp.local_name.as_str());
    }
    let user_extern_names_start = all_names.len();
    for name in &user_extern_names {
        all_names.push(*name);
    }
    let defined_data_globals_start = all_names.len();
    for (name, _) in &defined_data_globals {
        all_names.push(*name);
    }
    let user_extern_data_names_start = all_names.len();
    for name in &user_extern_data_names {
        all_names.push(*name);
    }
    let (strtab_bytes, name_offs) = build_strtab(&all_names);
    // Patch the file symbol's name offset against the final
    // strtab.
    symbols[1].st_name = name_offs[0];

    let func_extent = |i: usize| -> Result<(usize, usize), C5Error> {
        let ent_pc = build.func_ent_pcs[i];
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
        let hi = build
            .func_ent_pcs
            .get(i + 1)
            .and_then(|&next_ent| build.bytecode_to_native.get(next_ent).copied())
            .unwrap_or(build.text.len());
        Ok((lo, hi))
    };
    // STB_LOCAL function symbols. Emitted before `first_global`
    // so the LOCAL block is contiguous as ELF requires.
    for &i in &local_func_idxs {
        let (lo, hi) = func_extent(i)?;
        symbols.push(Elf64Sym {
            st_name: name_offs[1 + i],
            st_info: pack_sym_info(STB_LOCAL, STT_FUNC),
            st_shndx: SHIDX_TEXT,
            st_value: lo as u64,
            st_size: hi.saturating_sub(lo) as u64,
            ..Default::default()
        });
    }
    let first_global = symbols.len() as u32;
    // STB_GLOBAL function symbols.
    for &i in &global_func_idxs {
        let (lo, hi) = func_extent(i)?;
        symbols.push(Elf64Sym {
            st_name: name_offs[1 + i],
            st_info: pack_sym_info(STB_GLOBAL, STT_FUNC),
            st_shndx: SHIDX_TEXT,
            st_value: lo as u64,
            st_size: hi.saturating_sub(lo) as u64,
            ..Default::default()
        });
    }

    // Import symbols: STB_WEAK + STT_NOTYPE, SHN_UNDEF. The
    // dynamic linker resolves these against libc (or whichever
    // dylib `#pragma binding` named) at runtime, so an
    // unresolved entry at static-link time isn't a fatal
    // error. Marking them weak distinguishes them from
    // user-extern UNDEF references (kept STB_GLOBAL below),
    // which must resolve against a sibling TU's defined symbol
    // or the link fails.
    let mut import_sym_indices: Vec<usize> = Vec::with_capacity(build.imports.imports.len());
    for (i, _imp) in build.imports.imports.iter().enumerate() {
        import_sym_indices.push(symbols.len());
        symbols.push(Elf64Sym {
            st_name: name_offs[func_strs_end + i],
            st_info: pack_sym_info(STB_WEAK, STT_NOTYPE),
            st_shndx: SHN_UNDEF,
            ..Default::default()
        });
    }

    // Cross-TU user-function imports: same STB_GLOBAL +
    // STT_NOTYPE + SHN_UNDEF shape as the libc imports. The
    // linker resolves these against the matching defined
    // symbols in sibling units. `user_extern_sym_idx` maps a
    // name's position in `user_extern_names` to its symbol-table
    // index for the reloc loop below.
    let mut user_extern_sym_idx: Vec<usize> = Vec::with_capacity(user_extern_names.len());
    for (i, _name) in user_extern_names.iter().enumerate() {
        user_extern_sym_idx.push(symbols.len());
        symbols.push(Elf64Sym {
            st_name: name_offs[user_extern_names_start + i],
            st_info: pack_sym_info(STB_GLOBAL, STT_NOTYPE),
            st_shndx: SHN_UNDEF,
            ..Default::default()
        });
    }

    // Defined data globals: STB_GLOBAL + STT_OBJECT, shndx
    // points at `.data`. C99 6.2.2: external-linkage objects
    // surface by name so sibling TUs can resolve `extern T x;`.
    for (i, (_, val)) in defined_data_globals.iter().enumerate() {
        symbols.push(Elf64Sym {
            st_name: name_offs[defined_data_globals_start + i],
            st_info: pack_sym_info(STB_GLOBAL, STT_OBJECT),
            st_shndx: SHIDX_DATA,
            st_value: *val as u64,
            ..Default::default()
        });
    }

    // Cross-TU user-data imports: STB_GLOBAL + STT_OBJECT +
    // SHN_UNDEF. The linker resolves these against the matching
    // defined-data globals emitted by sibling units (above).
    let mut user_extern_data_sym_idx: Vec<usize> = Vec::with_capacity(user_extern_data_names.len());
    for (i, _name) in user_extern_data_names.iter().enumerate() {
        user_extern_data_sym_idx.push(symbols.len());
        symbols.push(Elf64Sym {
            st_name: name_offs[user_extern_data_names_start + i],
            st_info: pack_sym_info(STB_GLOBAL, STT_OBJECT),
            st_shndx: SHN_UNDEF,
            ..Default::default()
        });
    }

    // Section symbol indices follow the order we pushed them in
    // above: null(0), file(1), then text(2), data(3), bss(4).
    // Data + function-pointer fixups land against the matching
    // section symbol; the `r_addend` carries the offset within
    // the section.
    let text_sym_idx: u64 = 2;
    let data_sym_idx: u64 = 3;

    // Build the `.rela.text` payload now that import symbols
    // have their final indices.
    let machine_for_rela = machine;
    let mut rela_bytes: Vec<u8> = Vec::with_capacity(
        (build.reloc_call_sites.len()
            + build.user_extern_call_sites.len()
            + build.data_fixups.len() * 2
            + build.func_fixups.len() * 2)
            * ELF64_RELA_SIZE,
    );
    for site in &build.user_extern_call_sites {
        let pos = user_extern_names
            .iter()
            .position(|n| *n == site.symbol_name.as_str())
            .expect("user_extern_names contains every site's symbol name");
        let sym_idx = user_extern_sym_idx[pos] as u64;
        let (rtype, r_offset, r_addend) = match machine_for_rela {
            Machine::X86_64 => (R_X86_64_PLT32, site.instr_offset as u64 + 1, -4i64),
            Machine::Aarch64 => (R_AARCH64_CALL26, site.instr_offset as u64, 0),
        };
        let r_info = (sym_idx << 32) | (rtype as u64);
        let rela = Elf64Rela {
            r_offset,
            r_info,
            r_addend,
        };
        write_struct(&mut rela_bytes, &rela);
    }
    for site in &build.reloc_call_sites {
        let sym_idx = match import_sym_indices.get(site.import_index) {
            Some(&i) => i as u64,
            None => {
                return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                    &format!(
                        "elf_reloc: reloc_call_sites[..].import_index {} out of range",
                        site.import_index,
                    ),
                )));
            }
        };
        // x86_64 CALL/JMP rel32 is 5 bytes: opcode + 4-byte
        // disp32. The relocation applies to the disp32 field at
        // `instr_offset + 1`. ELF spec for `R_X86_64_PLT32`
        // wants `addend = -4` so the resolved value equals
        // (S + A) - P where P points at the disp32 itself
        // (S is the symbol value, A the addend).
        //
        // aarch64 BL/B is 4 bytes with the imm26 in the low
        // bits; `R_AARCH64_CALL26` applies at the instruction
        // start with addend 0.
        let (rtype, r_offset, r_addend) = match machine_for_rela {
            Machine::X86_64 => (R_X86_64_PLT32, site.instr_offset as u64 + 1, -4i64),
            Machine::Aarch64 => (R_AARCH64_CALL26, site.instr_offset as u64, 0),
        };
        let r_info = (sym_idx << 32) | (rtype as u64);
        let rela = Elf64Rela {
            r_offset,
            r_info,
            r_addend,
        };
        write_struct(&mut rela_bytes, &rela);
    }

    // Data-segment references (string literals / globals). The
    // codegen emits a 2-instruction page-relative pair on
    // aarch64 (`adrp` + `add`) and a `lea rip-rel disp32` on
    // x86_64; each becomes one or two ELF relocs against the
    // `.data` section symbol with `r_addend = data_offset`.
    for fx in &build.data_fixups {
        emit_addr_fixup_relocs(
            machine_for_rela,
            &mut rela_bytes,
            fx.adrp_offset as u64,
            data_sym_idx,
            fx.data_offset as i64,
        );
    }

    // Cross-TU data references. Same encoding shape as the
    // local data_fixups, but the reloc targets the named
    // undefined-data symbol so the linker resolves it against
    // the defining TU's storage. The addend is zero -- the
    // base of the symbol is the location to reach.
    for r in &build.user_extern_data_refs {
        let pos = user_extern_data_names
            .iter()
            .position(|n| *n == r.symbol_name.as_str())
            .expect("user_extern_data_names contains every ref's name");
        let sym_idx = user_extern_data_sym_idx[pos] as u64;
        emit_addr_fixup_relocs(
            machine_for_rela,
            &mut rela_bytes,
            r.instr_offset as u64,
            sym_idx,
            0,
        );
    }

    // Function-pointer literals. Same shape as data fixups but
    // the target is another position inside `.text`, so the
    // section symbol is `.text` and the addend is the target's
    // native offset within the section.
    for fx in &build.func_fixups {
        emit_addr_fixup_relocs(
            machine_for_rela,
            &mut rela_bytes,
            fx.adrp_offset as u64,
            text_sym_idx,
            fx.target_native_offset as i64,
        );
    }

    let symtab_bytes: Vec<u8> = symbols
        .iter()
        .flat_map(|s| {
            let mut v = Vec::with_capacity(ELF64_SYM_SIZE);
            write_struct(&mut v, s);
            v
        })
        .collect();

    // Section name table. Index map below mirrors the SHIDX_*
    // constants above (one entry per non-null section).
    let (shstrtab_bytes, shstrtab_offs) = build_strtab(&[
        ".text",
        ".rela.text",
        ".data",
        ".bss",
        ".symtab",
        ".strtab",
        ".shstrtab",
    ]);

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

    // .rela.text -- one entry per `RelocCallSite`. `sh_link`
    // points at the symbol table; `sh_info` at the section the
    // relocations apply to (`.text`). The `SHF_INFO_LINK` flag
    // signals the latter usage of `sh_info`.
    let rela_off = round_up(out.len() as u64, 8);
    out.resize(rela_off as usize, 0);
    out.extend_from_slice(&rela_bytes);
    sh.push(Elf64Shdr {
        sh_name: shstrtab_offs[1],
        sh_type: SHT_RELA,
        sh_flags: SHF_INFO_LINK,
        sh_offset: rela_off,
        sh_size: rela_bytes.len() as u64,
        sh_link: SHIDX_SYMTAB as u32,
        sh_info: SHIDX_TEXT as u32,
        sh_addralign: 8,
        sh_entsize: ELF64_RELA_SIZE as u64,
        ..Default::default()
    });

    // .data
    let data_off = round_up(out.len() as u64, 8);
    out.resize(data_off as usize, 0);
    out.extend_from_slice(&build.data);
    sh.push(Elf64Shdr {
        sh_name: shstrtab_offs[2],
        sh_type: SHT_PROGBITS,
        sh_flags: SHF_ALLOC | SHF_WRITE,
        sh_offset: data_off,
        sh_size: build.data.len() as u64,
        sh_addralign: 8,
        ..Default::default()
    });

    // .bss (no file bytes)
    sh.push(Elf64Shdr {
        sh_name: shstrtab_offs[3],
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
        sh_name: shstrtab_offs[4],
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
        sh_name: shstrtab_offs[5],
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
        sh_name: shstrtab_offs[6],
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

/// Emit the relocs the per-arch lowering left behind for an
/// address-load pair (`adrp + add` on aarch64, `lea rip-rel
/// disp32` on x86_64). The two halves share a single symbol +
/// addend so the linker reconstructs the final address as
/// `S + A`:
/// * aarch64 -- two relocs: `R_AARCH64_ADR_PREL_PG_HI21` at the
///   instruction start (encodes bits 32..12 of the page offset
///   into the `immhi:immlo` field) and
///   `R_AARCH64_ADD_ABS_LO12_NC` at the next instruction
///   (encodes bits 11..0 into the `add` imm12).
/// * x86_64 -- one reloc: `R_X86_64_PC32` at the disp32 slot of
///   the `lea`, with the addend pre-adjusted by `-4` so the
///   resolved value is `(S + A) - P`.
///
/// `instr_offset` is the byte offset within `.text` of the
/// first instruction of the pair (or the lea's opcode byte on
/// x86_64). The codegen's existing `DataFixup` / `FuncFixup`
/// already record this position.
fn emit_addr_fixup_relocs(
    machine: Machine,
    out: &mut Vec<u8>,
    instr_offset: u64,
    sym_idx: u64,
    addend: i64,
) {
    match machine {
        Machine::Aarch64 => {
            let hi21 = Elf64Rela {
                r_offset: instr_offset,
                r_info: (sym_idx << 32) | R_AARCH64_ADR_PREL_PG_HI21 as u64,
                r_addend: addend,
            };
            let lo12 = Elf64Rela {
                r_offset: instr_offset + 4,
                r_info: (sym_idx << 32) | R_AARCH64_ADD_ABS_LO12_NC as u64,
                r_addend: addend,
            };
            write_struct(out, &hi21);
            write_struct(out, &lo12);
        }
        Machine::X86_64 => {
            // The x86_64 codegen emits `lea reg, [rip + 0]`
            // where the disp32 occupies the last 4 bytes of
            // the instruction. For a typical REX-prefixed
            // 7-byte LEA (`48 8d 05 + disp32`), the disp32
            // starts at `instr_offset + 3`. The codegen
            // currently positions the disp32 slot at
            // `instr_offset + 3` for both LEA shapes used by
            // data refs.
            let rela = Elf64Rela {
                r_offset: instr_offset + 3,
                r_info: (sym_idx << 32) | R_X86_64_PC32 as u64,
                r_addend: addend - 4,
            };
            write_struct(out, &rela);
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    /// Sanity: an empty Build produces a valid ELF header that
    /// `readelf -h` would accept.
    #[test]
    fn empty_build_produces_valid_header() {
        let build = empty_build_for(Machine::X86_64);
        let program = empty_program("test.c");
        let bytes = write_relocatable(&program, &build, Machine::X86_64).expect("write");
        assert!(bytes.len() >= ELF64_EHDR_SIZE);
        assert_eq!(&bytes[0..4], b"\x7fELF");
        assert_eq!(bytes[4], ELF_CLASS_64);
        assert_eq!(bytes[5], ELF_DATA_LSB);
        let e_type = u16::from_le_bytes([bytes[16], bytes[17]]);
        assert_eq!(e_type, ET_REL);
        let e_machine = u16::from_le_bytes([bytes[18], bytes[19]]);
        assert_eq!(e_machine, EM_X86_64);
    }

    fn empty_program(path: &str) -> Program {
        Program {
            text: Vec::new(),
            data: Vec::new(),
            entry_pc: 0,
            warnings: Vec::new(),
            tls_data: Vec::new(),
            tls_init_size: 0,
            data_relocs: Vec::new(),
            code_relocs: Vec::new(),
            exports: Vec::new(),
            dylibs: Vec::new(),
            dllmain_pc: None,
            source_functions: Vec::new(),
            source_files: Vec::new(),
            source_path: path.into(),
            variables: Vec::new(),
            structs: Vec::new(),
            entry_name: None,
            subsystem: None,
            finished_functions: Vec::new(),
            symbols: Vec::new(),
            synthetic_ssa_funcs: Vec::new(),
            user_ssa_funcs: Vec::new(),
            extern_function_imports: Vec::new(),
        }
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
            reloc_call_sites: Vec::new(),
            user_extern_call_sites: Vec::new(),
            user_extern_data_refs: Vec::new(),
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
