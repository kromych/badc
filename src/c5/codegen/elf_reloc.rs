//! ELF64 ET_REL writer -- emits a standard relocatable object
//! from a per-TU [`Build`]. Consumable by `ld` / `lld`:
//! `.text` carries the per-function machine code,
//! `.data` / `.bss` carry the static segment, `.symtab` /
//! `.strtab` list function and global names, and `.rela.text`
//! records cross-TU and libc-import references the linker
//! resolves at link time.
//!
//! Sections emitted: `.text`, `.data`, `.bss`, `.rela.text`,
//! `.symtab`, `.strtab`, `.shstrtab`, `.rela.data`, `.note.badc`
//! (vendor note carrying `#pragma dylib` paths), `.debug_info`,
//! `.rela.debug_info`, `.debug_abbrev`, `.debug_line`,
//! `.rela.debug_line` plus the null section.
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
use super::super::program::{ExportedFunction, Program};
use super::Build;
use super::Machine;
use super::dwarf_reloc::{self, DwarfReloc, DwarfRelocTarget, DwarfRelocWidth};

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
const SHT_NOTE: u32 = 7;
const SHT_NOBITS: u32 = 8;

// Vendor note types under namesz="badc\0". Standard ELF note
// shape (ELF gABI, section 5): each entry is (namesz, descsz,
// type) header + name (4-byte padded) + desc (4-byte padded).
const NT_BADC_DYLIBS: u32 = 1;
// Per-import dylib routing. desc is a sequence of records, each:
//   u32  dylib_index (LE, into the NT_BADC_DYLIBS path list)
//   NUL-terminated import name (the real_symbol stored in `.symtab`).
// Required so the final-image writers (Mach-O / PE / dynamic ELF)
// place each IAT / `LC_LOAD_DYLIB` / `DT_NEEDED` reference under
// the right library; without it every import lands under the
// first dylib and a cross-DLL symbol (`GetCurrentProcess` from
// `kernel32.dll` while `printf` is from `ucrtbase.dll`) is not
// found at process startup.
const NT_BADC_BINDING_MAP: u32 = 2;
// Source-declared exports. desc is a NUL-separated list of the names
// named by `#pragma export(<name>)`. The export name equals the
// defined symbol's name; the final-image writers resolve each to its
// `.symtab` entry when building the export table (PE export directory,
// ELF dynsym, Mach-O export trie). Carried so a shared library links
// the intended export set through the native path rather than every
// `.text`-defined symbol.
const NT_BADC_EXPORTS: u32 = 3;
// Win64 `_tls_index` fixups. desc is a sequence of u64 LE byte offsets
// into `.text`, one per `Inst::TlsAddr` lowering on Windows. The PE
// writer patches each site with the address of the `_tls_index` DWORD
// it places in the TLS directory; carried so a `_Thread_local` Windows
// image links through the native path. Empty (and the record omitted)
// for other targets.
const NT_BADC_TLS_INDEX: u32 = 4;
// Mach-O TLV descriptors. desc is a sequence of u64 LE
// `offset_in_block` values, one per `_Thread_local` variable -- the
// byte offset of the variable inside the per-thread block. The Mach-O
// writer materialises a `__thread_vars` descriptor for each.
const NT_BADC_MACHO_TLV_DESC: u32 = 5;
// Mach-O TLV fixups. desc is a sequence of (u64 adrp_offset, u64
// descriptor_index) pairs: the `.text` offset of the adrp opening the
// descriptor-address materialisation and the index into the
// NT_BADC_MACHO_TLV_DESC list it resolves to.
const NT_BADC_MACHO_TLV_FIXUP: u32 = 6;
const SHF_WRITE: u64 = 0x1;
const SHF_ALLOC: u64 = 0x2;
const SHF_EXECINSTR: u64 = 0x4;
const SHF_INFO_LINK: u64 = 0x40;

// x86_64 reloc types (System V psABI x86_64 supplement, table 4.10).
const R_X86_64_64: u32 = 1;
const R_X86_64_PC32: u32 = 2;
const R_X86_64_PLT32: u32 = 4;
const R_X86_64_32: u32 = 10;

// AArch64 reloc types (ELF for the ARM 64-bit architecture, table 5-1).
const R_AARCH64_ABS64: u32 = 257;
const R_AARCH64_ABS32: u32 = 258;
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

/// Name prefix for the synthetic STB_LOCAL STT_NOTYPE symbols
/// the writer emits at each function's post-prologue native byte
/// offset. The linker's merge pass keys on this prefix to collect
/// the resolved offsets into `MergedNative::prologue_ends`; the
/// suffix is the source function name. Kept in sync with
/// `link.rs::PROLOGUE_END_PREFIX`.
pub(super) const PROLOGUE_END_PREFIX: &str = ".Lc5_prologue_end_";

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
    target: super::Target,
) -> Result<Vec<u8>, C5Error> {
    // `_Thread_local` storage round-trips through ET_REL for a
    // single TLS-bearing unit. `Inst::TlsAddr` lowering on Linux
    // uses the local-exec model: `emit_tls_addr` bakes
    // `tpoff = tls_total_size - offset` straight into the `sub`
    // immediate, so the object needs only its `.tdata` / `.tbss`
    // section bytes (emitted below; object.rs parses them back into
    // `NativeObject::tls_data` / `tls_bss_size`). `link.rs` carries
    // a single unit's TLS block forward unchanged and `synth_build`
    // threads it to the writer's PT_TLS layout, so the baked offset
    // stays valid. A multi-object link where more than one unit
    // contributes `_Thread_local` storage shifts each unit's block
    // and so needs `R_X86_64_TPOFF32` / `R_AARCH64_TLSLE_*`
    // relocations emitted here and resolved in link.rs against the
    // merged layout; that case is rejected in `link_native_objects`
    // (macOS TLV descriptors + Win64 `_tls_index` are the format
    // equivalents). TODO.
    let source_path = program.source_path.as_str();
    // Section layout (indices used in symtab st_shndx):
    //   1 = .text
    //   2 = .rela.text
    //   3 = .data
    //   4 = .bss
    //   5 = .symtab
    //   6 = .strtab
    //   7 = .shstrtab
    //   8 = .rela.data
    //   9 = .note.badc
    //  10 = .debug_info
    //  11 = .rela.debug_info
    //  12 = .debug_abbrev
    //  13 = .debug_line
    //  14 = .rela.debug_line
    //  15 = .tdata   (present only when the unit has TLS storage)
    //  16 = .tbss    (present only when the unit has TLS storage)
    // Plus the null section at index 0. The TLS sections are
    // appended last so adding them leaves every other section
    // index -- and the hardcoded symtab indices below -- stable.
    const SHIDX_TEXT: u16 = 1;
    const SHIDX_DATA: u16 = 3;
    const SHIDX_BSS: u16 = 4;
    const SHIDX_SYMTAB: u16 = 5;
    const SHIDX_STRTAB: u16 = 6;
    const SHIDX_SHSTRTAB: u16 = 7;
    const SHIDX_RELA_DATA: u16 = 8;
    const SHIDX_NOTE_BADC: u16 = 9;
    const SHIDX_DEBUG_INFO: u16 = 10;
    const SHIDX_RELA_DEBUG_INFO: u16 = 11;
    const SHIDX_DEBUG_ABBREV: u16 = 12;
    const SHIDX_DEBUG_LINE: u16 = 13;
    const SHIDX_RELA_DEBUG_LINE: u16 = 14;
    // TLS sections are emitted only when the unit carries
    // `_Thread_local` storage; `has_tls` gates both the section
    // headers and the `.shstrtab` name entries.
    let has_tls = !program.tls_data.is_empty();
    const SHIDX_TDATA: u16 = 15;
    const SHIDX_TBSS: u16 = 16;
    let num_sections: usize = if has_tls { 17 } else { 15 };

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

    // Section symbols (.text, .data, .bss, .debug_line,
    // .debug_abbrev). Each has empty name and SHN of the matching
    // section. The DWARF section symbols let `.rela.debug_info` /
    // `.rela.debug_line` relocations target them: a placeholder
    // slot in `.debug_info` that refers to the unit's
    // `.debug_line` start surfaces as
    // `R_*_32 against .debug_line section sym, addend = 0`, which
    // the linker rebases to the unit's final `.debug_line` offset
    // after concatenation.
    for shndx in [
        SHIDX_TEXT,
        SHIDX_DATA,
        SHIDX_BSS,
        SHIDX_DEBUG_LINE,
        SHIDX_DEBUG_ABBREV,
    ] {
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
    // entry ent_pc in `func_ent_pcs`; the matching native offset
    // lives at `pc_to_native[ent_pc]`. The function name --
    // when available -- comes from `program.source_functions`
    // via the existing DWARF builder's path. Here we synthesise
    // a `fn_<ent_pc>` placeholder; the real name plumbing lands
    // next.
    // Function names come from `program.source_functions`,
    // indexed by ent_pc; empty entries fall back to a
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
    // Synthetic STB_LOCAL STT_NOTYPE symbols anchored at each
    // function's post-prologue native byte offset. The linker's
    // merge pass collects them by name prefix and exposes their
    // resolved offsets through `MergedNative::prologue_ends`; the
    // synth path then populates `pc_to_native[ent_pc + 2]` so
    // `dwarf::build_debug_frame` emits `DW_CFA_advance_loc
    // <prologue_size>` before the post-prologue CFA rule. Without
    // them, multi-TU FDEs install the CFA rule at byte 0 of the
    // function (suboptimal for unwinds caught inside the prologue
    // range). Format: `.Lc5_prologue_end_<funcname>` -- the
    // leading `.L` matches the conventional compiler-local
    // prefix `nm` / `objdump` filter out by default.
    let mut prologue_end_entries: Vec<(usize, usize)> = Vec::new();
    let mut prologue_end_names: Vec<String> = Vec::new();
    for (i, &ent_pc) in build.func_ent_pcs.iter().enumerate() {
        // FunctionSsa::name is the canonical source for the
        // symbol-table name: the walker copies it from
        // `FinishedFunction::name`, sys-trampolines tag
        // themselves `__c5_sys_<binding>`, and archive reload
        // round-trips user names + re-derives the trampoline
        // names from `binding_idx`. An empty entry falls back
        // to a `fn_<ent_pc>` placeholder.
        let name = build
            .func_names
            .get(i)
            .filter(|s| !s.is_empty())
            .cloned()
            .unwrap_or_else(|| format!("fn_{ent_pc}"));
        // Build the synthetic prologue_end entry for this
        // function before consuming `name`. The post-prologue
        // native byte offset is recorded in `func_prologue_native`
        // keyed by `ent_pc`; skip when the SSA emit didn't record
        // one (synthetic CRT trampolines without a standard
        // prologue shape).
        if let Some(&post_native) = build.func_prologue_native.get(&ent_pc) {
            prologue_end_entries.push((i, post_native));
            prologue_end_names.push(alloc::format!("{PROLOGUE_END_PREFIX}{name}"));
        }
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
    // `code_relocs` targeting an extern function (the
    // `extern_function_imports` map; placeholder ent_pcs past
    // `text.len()`) also need a named UNDEF entry in `.symtab`
    // so the `.rela.data` row below can point at it. Fold
    // those names into the same dedup list.
    let extern_fn_by_pc: alloc::collections::BTreeMap<usize, &str> = program
        .extern_function_imports
        .iter()
        .map(|(pc, name)| (*pc, name.as_str()))
        .collect();
    for r in &build.code_relocs {
        if let Some(&name) = extern_fn_by_pc.get(&(r.target_ent_pc as usize))
            && !user_extern_names.contains(&name)
        {
            user_extern_names.push(name);
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
    // Each libc / dylib import surfaces under its
    // target-specific `real_symbol`. The `#pragma binding`
    // declaration is the only source of truth that maps the
    // c5-internal `local_name` (e.g. `errno_location`) to the
    // platform's actual symbol (`___error` on Mach-O,
    // `__errno_location` on Linux, `_errno` on PE/COFF).
    // Storing the real_symbol here lets the synthesizer feed
    // the final-image writer's dylib import table without
    // having to recover the per-OS rename -- the .o is per-
    // target already (it carries arch-specific instruction
    // bytes), so per-target symbol names are no extra coupling.
    for imp in &build.imports.imports {
        all_names.push(imp.real_symbol.as_str());
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
    let prologue_end_names_start = all_names.len();
    for s in &prologue_end_names {
        all_names.push(s.as_str());
    }
    let (strtab_bytes, name_offs) = build_strtab(&all_names);
    // Patch the file symbol's name offset against the final
    // strtab.
    symbols[1].st_name = name_offs[0];

    let func_extent = |i: usize| -> Result<(usize, usize), C5Error> {
        let ent_pc = build.func_ent_pcs[i];
        let lo = build
            .pc_to_native
            .get(ent_pc)
            .copied()
            .unwrap_or(usize::MAX);
        if lo == usize::MAX {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!(
                    "elf_reloc: function ent_pc {ent_pc} has no native offset in pc_to_native",
                ),
            )));
        }
        let hi = build
            .func_ent_pcs
            .get(i + 1)
            .and_then(|&next_ent| build.pc_to_native.get(next_ent).copied())
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
    // Prologue_end synthetic locals (also STB_LOCAL, also
    // pre-first_global). Each one's `st_value` is the native
    // byte offset of the first post-prologue instruction; size
    // stays zero (a marker, not a code region).
    for (j, &(_i, post_native)) in prologue_end_entries.iter().enumerate() {
        symbols.push(Elf64Sym {
            st_name: name_offs[prologue_end_names_start + j],
            st_info: pack_sym_info(STB_LOCAL, STT_NOTYPE),
            st_shndx: SHIDX_TEXT,
            st_value: post_native as u64,
            st_size: 0,
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
    // above: null(0), file(1), then text(2), data(3), bss(4),
    // .debug_line(5), .debug_abbrev(6). Data + function-pointer
    // fixups land against the matching section symbol; the
    // `r_addend` carries the offset within the section.
    let text_sym_idx: u64 = 2;
    let data_sym_idx: u64 = 3;
    let debug_line_sym_idx: u64 = 5;
    let debug_abbrev_sym_idx: u64 = 6;

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
    let mut shstrtab_names: Vec<&str> = alloc::vec![
        ".text",
        ".rela.text",
        ".data",
        ".bss",
        ".symtab",
        ".strtab",
        ".shstrtab",
        ".rela.data",
        ".note.badc",
        ".debug_info",
        ".rela.debug_info",
        ".debug_abbrev",
        ".debug_line",
        ".rela.debug_line",
    ];
    // `.tdata` / `.tbss` names land at offsets [14] / [15] when the
    // unit carries TLS; gated so a TLS-free object's name table is
    // byte-identical to before.
    if has_tls {
        shstrtab_names.push(".tdata");
        shstrtab_names.push(".tbss");
    }
    let (shstrtab_bytes, shstrtab_offs) = build_strtab(&shstrtab_names);

    // Generate the DWARF triple for this TU. Address slots end
    // up as placeholders paired with `DwarfReloc` records that
    // the loop below translates into ELF `.rela.debug_*`
    // entries. Without `-g` the DWARF build is skipped entirely:
    // the `.debug_*` sections stay zero-length, so `link_native_-
    // objects` sees no debug info and the final image carries
    // none, and the type-catalog walk is avoided on a default
    // build. TODO: drop the empty `.debug_*` section headers from
    // the relocatable object as well.
    let dwarf = if build.debug_info {
        dwarf_reloc::emit(program, build, source_path, machine, target)
    } else {
        dwarf_reloc::DwarfRelocatable::default()
    };
    let mut rela_debug_info_bytes: Vec<u8> =
        Vec::with_capacity(dwarf.info_relocs.len() * ELF64_RELA_SIZE);
    for r in &dwarf.info_relocs {
        write_struct(
            &mut rela_debug_info_bytes,
            &dwarf_reloc_to_elf_rela(
                r,
                machine_for_rela,
                debug_line_sym_idx,
                debug_abbrev_sym_idx,
                text_sym_idx,
            ),
        );
    }
    let mut rela_debug_line_bytes: Vec<u8> =
        Vec::with_capacity(dwarf.line_relocs.len() * ELF64_RELA_SIZE);
    for r in &dwarf.line_relocs {
        write_struct(
            &mut rela_debug_line_bytes,
            &dwarf_reloc_to_elf_rela(
                r,
                machine_for_rela,
                debug_line_sym_idx,
                debug_abbrev_sym_idx,
                text_sym_idx,
            ),
        );
    }

    // Section data layout. Each section's offset starts at the
    // running tail of the output, rounded to its alignment.
    let mut out: Vec<u8> = alloc::vec![0u8; ELF64_EHDR_SIZE];

    let mut sh: Vec<Elf64Shdr> = Vec::with_capacity(num_sections);
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

    // .rela.data -- absolute 64-bit relocations for
    // pointer-to-global initializers. `Build::data_relocs` carries
    // `(slot_data_offset, target_data_offset)`; each becomes a
    // `R_X86_64_64` / `R_AARCH64_ABS64` reloc at `slot_data_offset`
    // against the `.data` section symbol with
    // `r_addend = target_data_offset`. The linker resolves to
    // `data_vaddr + target_offset`, the runtime VA of the
    // pointed-at global.
    let rtype_abs64 = match machine_for_rela {
        Machine::X86_64 => R_X86_64_64,
        Machine::Aarch64 => R_AARCH64_ABS64,
    };
    let mut rela_data_bytes: Vec<u8> =
        Vec::with_capacity((build.data_relocs.len() + build.code_relocs.len()) * ELF64_RELA_SIZE);
    for r in &build.data_relocs {
        let rela = Elf64Rela {
            r_offset: r.data_offset,
            r_info: (data_sym_idx << 32) | rtype_abs64 as u64,
            r_addend: r.target_offset as i64,
        };
        write_struct(&mut rela_data_bytes, &rela);
    }
    // Function-pointer initializers: same `R_*_64` shape as
    // pointer-to-global, but the addend is the target
    // function's native byte offset within `.text` (looked up
    // via `pc_to_native`) and the reloc points at the
    // `.text` section symbol. The linker resolves to
    // `text_vaddr + target_offset`.
    for r in &build.code_relocs {
        let ent_pc = r.target_ent_pc as usize;
        // Cross-TU target: emit against the named UNDEF
        // function symbol so the linker resolves it against
        // the sibling unit's defined entry. `r_addend = 0`
        // since the named symbol carries the target's text
        // offset directly.
        if let Some(&name) = extern_fn_by_pc.get(&ent_pc) {
            let pos = user_extern_names
                .iter()
                .position(|n| *n == name)
                .expect("user_extern_names contains every code-reloc extern callee");
            let sym_idx = user_extern_sym_idx[pos] as u64;
            let rela = Elf64Rela {
                r_offset: r.data_offset,
                r_info: (sym_idx << 32) | rtype_abs64 as u64,
                r_addend: 0,
            };
            write_struct(&mut rela_data_bytes, &rela);
            continue;
        }
        let native_off = build
            .pc_to_native
            .get(ent_pc)
            .copied()
            .unwrap_or(usize::MAX);
        if native_off == usize::MAX {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!("elf_reloc: code reloc references missing ent_pc {ent_pc}",),
            )));
        }
        let rela = Elf64Rela {
            r_offset: r.data_offset,
            r_info: (text_sym_idx << 32) | rtype_abs64 as u64,
            r_addend: native_off as i64,
        };
        write_struct(&mut rela_data_bytes, &rela);
    }
    let rela_data_off = round_up(out.len() as u64, 8);
    out.resize(rela_data_off as usize, 0);
    out.extend_from_slice(&rela_data_bytes);
    sh.push(Elf64Shdr {
        sh_name: shstrtab_offs[7],
        sh_type: SHT_RELA,
        sh_flags: SHF_INFO_LINK,
        sh_offset: rela_data_off,
        sh_size: rela_data_bytes.len() as u64,
        sh_link: SHIDX_SYMTAB as u32,
        sh_info: SHIDX_DATA as u32,
        sh_addralign: 8,
        sh_entsize: ELF64_RELA_SIZE as u64,
        ..Default::default()
    });
    let _ = SHIDX_RELA_DATA;

    // .note.badc -- vendor note section. Two records under
    // namesz="badc\0":
    //   NT_BADC_DYLIBS       -- NUL-separated `#pragma dylib`
    //                           paths. Drives DT_NEEDED /
    //                           LC_LOAD_DYLIB / IMAGE_IMPORT_DESCRIPTOR.
    //   NT_BADC_BINDING_MAP  -- (u32 dylib_index, NUL-terminated
    //                           import name)+. Routes each import
    //                           to its owning dylib so a cross-DLL
    //                           reference (kernel32 + ucrtbase in
    //                           the same PE) places its IAT slot
    //                           under the right loader entry.
    // Standard ELF tooling ignores unknown note types; the badc
    // reader picks the entries up by name + type.
    let note_bytes = build_badc_note(
        &build.imports,
        &program.exports,
        &build.tls_index_fixups,
        &build.macho_tlv_descriptors,
        &build.macho_tlv_fixups,
    );
    let note_off = round_up(out.len() as u64, 4);
    out.resize(note_off as usize, 0);
    out.extend_from_slice(&note_bytes);
    sh.push(Elf64Shdr {
        sh_name: shstrtab_offs[8],
        sh_type: SHT_NOTE,
        sh_offset: note_off,
        sh_size: note_bytes.len() as u64,
        sh_addralign: 4,
        ..Default::default()
    });
    let _ = SHIDX_NOTE_BADC;

    // .debug_info -- one CU DIE per `.o`. SHT_PROGBITS without
    // SHF_ALLOC: not loaded at runtime, just consumed by the
    // debugger via its `.shdr` walk.
    let debug_info_off = out.len() as u64;
    out.extend_from_slice(&dwarf.debug_info);
    sh.push(Elf64Shdr {
        sh_name: shstrtab_offs[9],
        sh_type: SHT_PROGBITS,
        sh_offset: debug_info_off,
        sh_size: dwarf.debug_info.len() as u64,
        sh_addralign: 1,
        ..Default::default()
    });

    // .rela.debug_info -- placeholder slots described above.
    let rela_debug_info_off = round_up(out.len() as u64, 8);
    out.resize(rela_debug_info_off as usize, 0);
    out.extend_from_slice(&rela_debug_info_bytes);
    sh.push(Elf64Shdr {
        sh_name: shstrtab_offs[10],
        sh_type: SHT_RELA,
        sh_flags: SHF_INFO_LINK,
        sh_offset: rela_debug_info_off,
        sh_size: rela_debug_info_bytes.len() as u64,
        sh_link: SHIDX_SYMTAB as u32,
        sh_info: SHIDX_DEBUG_INFO as u32,
        sh_addralign: 8,
        sh_entsize: ELF64_RELA_SIZE as u64,
        ..Default::default()
    });

    // .debug_abbrev -- abbreviation table. No relocs; the slot
    // it's referenced from in `.debug_info` already carries the
    // reloc that rebases to its merged-section offset.
    let debug_abbrev_off = out.len() as u64;
    out.extend_from_slice(&dwarf.debug_abbrev);
    sh.push(Elf64Shdr {
        sh_name: shstrtab_offs[11],
        sh_type: SHT_PROGBITS,
        sh_offset: debug_abbrev_off,
        sh_size: dwarf.debug_abbrev.len() as u64,
        sh_addralign: 1,
        ..Default::default()
    });

    // .debug_line -- per-statement line program. Reloc against
    // `.text` rebases each `DW_LNE_set_address` opcode.
    let debug_line_off = out.len() as u64;
    out.extend_from_slice(&dwarf.debug_line);
    sh.push(Elf64Shdr {
        sh_name: shstrtab_offs[12],
        sh_type: SHT_PROGBITS,
        sh_offset: debug_line_off,
        sh_size: dwarf.debug_line.len() as u64,
        sh_addralign: 1,
        ..Default::default()
    });

    // .rela.debug_line -- the placeholder slots above.
    let rela_debug_line_off = round_up(out.len() as u64, 8);
    out.resize(rela_debug_line_off as usize, 0);
    out.extend_from_slice(&rela_debug_line_bytes);
    sh.push(Elf64Shdr {
        sh_name: shstrtab_offs[13],
        sh_type: SHT_RELA,
        sh_flags: SHF_INFO_LINK,
        sh_offset: rela_debug_line_off,
        sh_size: rela_debug_line_bytes.len() as u64,
        sh_link: SHIDX_SYMTAB as u32,
        sh_info: SHIDX_DEBUG_LINE as u32,
        sh_addralign: 8,
        sh_entsize: ELF64_RELA_SIZE as u64,
        ..Default::default()
    });
    // TLS sections (only when the unit carries `_Thread_local`
    // storage). `.tdata` holds the initialised slice
    // `tls_data[..tls_init_size]`; `.tbss` is the zero-fill
    // remainder. Both carry SHF_TLS (0x400) so the linker groups
    // them into the PT_TLS segment. object.rs already detects the
    // section families by name + flag and concatenates the bytes
    // into `NativeObject::tls_data` / `tbss_size`.
    if has_tls {
        const SHF_TLS: u64 = 0x400;
        let tls_init_size = program.tls_init_size.min(program.tls_data.len());
        let tdata_off = round_up(out.len() as u64, 16);
        out.resize(tdata_off as usize, 0);
        out.extend_from_slice(&program.tls_data[..tls_init_size]);
        sh.push(Elf64Shdr {
            sh_name: shstrtab_offs[14],
            sh_type: SHT_PROGBITS,
            sh_flags: SHF_ALLOC | SHF_WRITE | SHF_TLS,
            sh_offset: tdata_off,
            sh_size: tls_init_size as u64,
            sh_addralign: 16,
            ..Default::default()
        });
        // .tbss (no file bytes). Size is the zero-fill remainder.
        sh.push(Elf64Shdr {
            sh_name: shstrtab_offs[15],
            sh_type: SHT_NOBITS,
            sh_flags: SHF_ALLOC | SHF_WRITE | SHF_TLS,
            sh_offset: out.len() as u64,
            sh_size: (program.tls_data.len() - tls_init_size) as u64,
            sh_addralign: 16,
            ..Default::default()
        });
    } else {
        let _ = (SHIDX_TDATA, SHIDX_TBSS);
    }

    let _ = SHIDX_DEBUG_INFO;
    let _ = SHIDX_RELA_DEBUG_INFO;
    let _ = SHIDX_DEBUG_ABBREV;
    let _ = SHIDX_DEBUG_LINE;
    let _ = SHIDX_RELA_DEBUG_LINE;

    debug_assert_eq!(sh.len(), num_sections);

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
        e_shnum: num_sections as u16,
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

/// Build the `.note.badc` section body. Emits up to three records:
///   NT_BADC_DYLIBS       -- NUL-separated dylib paths.
///   NT_BADC_BINDING_MAP  -- per-import (u32 dylib_index, NUL
///                           import name)+.
///   NT_BADC_EXPORTS      -- NUL-separated `#pragma export` names.
/// All records share the namesz="badc\0" namespace; the parser
/// distinguishes by `type`. Each note is independently padded to
/// the 4-byte ELF gABI boundary. The binding-map and exports
/// records are omitted when empty so a TU with neither still
/// round-trips through the older single-record shape.
fn build_badc_note(
    imports: &super::ResolvedImports,
    exports: &[ExportedFunction],
    tls_index_fixups: &[super::TlsIndexFixup],
    macho_tlv_descriptors: &[super::MachoTlvDescriptor],
    macho_tlv_fixups: &[super::MachoTlvFixup],
) -> Vec<u8> {
    let mut out: Vec<u8> = Vec::new();
    let name = b"badc\0";

    // Record 1: dylib paths.
    let mut dylibs_desc: Vec<u8> = Vec::new();
    for d in &imports.dylibs {
        dylibs_desc.extend_from_slice(d.path.as_bytes());
        dylibs_desc.push(0);
    }
    out.extend_from_slice(&(name.len() as u32).to_le_bytes());
    out.extend_from_slice(&(dylibs_desc.len() as u32).to_le_bytes());
    out.extend_from_slice(&NT_BADC_DYLIBS.to_le_bytes());
    out.extend_from_slice(name);
    pad_to_4(&mut out);
    out.extend_from_slice(&dylibs_desc);
    pad_to_4(&mut out);

    // Record 2: per-import dylib map. Skip when there are no
    // imports -- the parser tolerates a missing record so the
    // older shape (dylibs note only) still round-trips.
    if !imports.imports.is_empty() {
        let mut bm_desc: Vec<u8> = Vec::new();
        for imp in &imports.imports {
            let idx = imp.dylib_index as u32;
            bm_desc.extend_from_slice(&idx.to_le_bytes());
            bm_desc.extend_from_slice(imp.real_symbol.as_bytes());
            bm_desc.push(0);
        }
        out.extend_from_slice(&(name.len() as u32).to_le_bytes());
        out.extend_from_slice(&(bm_desc.len() as u32).to_le_bytes());
        out.extend_from_slice(&NT_BADC_BINDING_MAP.to_le_bytes());
        out.extend_from_slice(name);
        pad_to_4(&mut out);
        out.extend_from_slice(&bm_desc);
        pad_to_4(&mut out);
    }

    // Record 3: source-declared export names. Omitted when the TU
    // declared no `#pragma export`, matching the binding map's
    // conditional emit.
    if !exports.is_empty() {
        let mut ex_desc: Vec<u8> = Vec::new();
        for e in exports {
            ex_desc.extend_from_slice(e.name.as_bytes());
            ex_desc.push(0);
        }
        out.extend_from_slice(&(name.len() as u32).to_le_bytes());
        out.extend_from_slice(&(ex_desc.len() as u32).to_le_bytes());
        out.extend_from_slice(&NT_BADC_EXPORTS.to_le_bytes());
        out.extend_from_slice(name);
        pad_to_4(&mut out);
        out.extend_from_slice(&ex_desc);
        pad_to_4(&mut out);
    }

    // Record 4: Win64 `_tls_index` fixup offsets. Omitted when the
    // TU has no `_Thread_local` access (every non-Windows target,
    // and Windows TUs without TLS).
    if !tls_index_fixups.is_empty() {
        let mut tls_desc: Vec<u8> = Vec::new();
        for f in tls_index_fixups {
            tls_desc.extend_from_slice(&(f.instr_offset as u64).to_le_bytes());
        }
        out.extend_from_slice(&(name.len() as u32).to_le_bytes());
        out.extend_from_slice(&(tls_desc.len() as u32).to_le_bytes());
        out.extend_from_slice(&NT_BADC_TLS_INDEX.to_le_bytes());
        out.extend_from_slice(name);
        pad_to_4(&mut out);
        out.extend_from_slice(&tls_desc);
        pad_to_4(&mut out);
    }

    // Record 5: Mach-O TLV descriptor offsets.
    if !macho_tlv_descriptors.is_empty() {
        let mut desc: Vec<u8> = Vec::new();
        for d in macho_tlv_descriptors {
            desc.extend_from_slice(&d.offset_in_block.to_le_bytes());
        }
        out.extend_from_slice(&(name.len() as u32).to_le_bytes());
        out.extend_from_slice(&(desc.len() as u32).to_le_bytes());
        out.extend_from_slice(&NT_BADC_MACHO_TLV_DESC.to_le_bytes());
        out.extend_from_slice(name);
        pad_to_4(&mut out);
        out.extend_from_slice(&desc);
        pad_to_4(&mut out);
    }

    // Record 6: Mach-O TLV fixups -- (adrp_offset, descriptor_index)
    // pairs.
    if !macho_tlv_fixups.is_empty() {
        let mut desc: Vec<u8> = Vec::new();
        for f in macho_tlv_fixups {
            desc.extend_from_slice(&(f.adrp_offset as u64).to_le_bytes());
            desc.extend_from_slice(&(f.descriptor_index as u64).to_le_bytes());
        }
        out.extend_from_slice(&(name.len() as u32).to_le_bytes());
        out.extend_from_slice(&(desc.len() as u32).to_le_bytes());
        out.extend_from_slice(&NT_BADC_MACHO_TLV_FIXUP.to_le_bytes());
        out.extend_from_slice(name);
        pad_to_4(&mut out);
        out.extend_from_slice(&desc);
        pad_to_4(&mut out);
    }
    out
}

fn pad_to_4(out: &mut Vec<u8>) {
    while !out.len().is_multiple_of(4) {
        out.push(0);
    }
}

/// Translate a `DwarfReloc` (target = section kind + width) into
/// an `Elf64Rela`. The reloc type comes from `(width, machine)`:
/// 32-bit slots use `R_X86_64_32` / `R_AARCH64_ABS32`, 64-bit
/// slots use `R_X86_64_64` / `R_AARCH64_ABS64`. The target
/// section's symtab index is looked up from the three indices the
/// caller pre-resolved when laying out the symbol table.
fn dwarf_reloc_to_elf_rela(
    r: &DwarfReloc,
    machine: Machine,
    debug_line_sym_idx: u64,
    debug_abbrev_sym_idx: u64,
    text_sym_idx: u64,
) -> Elf64Rela {
    let sym_idx = match r.target {
        DwarfRelocTarget::Text => text_sym_idx,
        DwarfRelocTarget::DebugLine => debug_line_sym_idx,
        DwarfRelocTarget::DebugAbbrev => debug_abbrev_sym_idx,
    };
    let rtype = match (r.width, machine) {
        (DwarfRelocWidth::W8, Machine::X86_64) => R_X86_64_64,
        (DwarfRelocWidth::W4, Machine::X86_64) => R_X86_64_32,
        (DwarfRelocWidth::W8, Machine::Aarch64) => R_AARCH64_ABS64,
        (DwarfRelocWidth::W4, Machine::Aarch64) => R_AARCH64_ABS32,
    };
    Elf64Rela {
        r_offset: r.offset,
        r_info: (sym_idx << 32) | (rtype as u64),
        r_addend: r.addend,
    }
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
        let bytes = write_relocatable(
            &program,
            &build,
            Machine::X86_64,
            crate::c5::Target::LinuxX64,
        )
        .expect("write");
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
            source_files: Vec::new(),
            source_path: path.into(),
            variables: Vec::new(),
            structs: Vec::new(),
            enums: Vec::new(),
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
            pc_to_native: Vec::new(),
            func_ent_pcs: Vec::new(),
            func_names: Vec::new(),
            func_prologue_native: alloc::collections::BTreeMap::new(),
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
            merged_dwarf: None,
            plt_trampoline_offsets: Vec::new(),
        }
    }
}
