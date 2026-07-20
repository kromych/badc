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
// SHT_INIT_ARRAY / SHT_FINI_ARRAY (ELF gABI): arrays of function
// pointers a C library runs before / after `main`. Entries are
// resolved by a paired `.rela.init_array` / `.rela.fini_array`.
const SHT_INIT_ARRAY: u32 = 14;
const SHT_FINI_ARRAY: u32 = 15;

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
// Data-import copy relocations from `#pragma binding(data <lib>::<local>,
// "<host>")`. desc is a sequence of (NUL local_name, NUL host_symbol)
// string pairs. The final-image writer binds each local data symbol to
// the host's data object with an `R_*_COPY` relocation.
const NT_BADC_COPY_RELOC: u32 = 7;
// Defined `_Thread_local` symbols. desc is a sequence of (u64 tls_offset,
// u64 size, NUL name) entries -- one per thread-local variable this unit
// defines, with the byte offset inside the unit's TLS block. The linker
// builds the merged TLS symbol table from these to resolve cross-unit
// extern accesses.
const NT_BADC_TLS_SYM: u32 = 8;
// Mach-O TLV descriptors keyed by a cross-unit symbol. desc is a sequence
// of (u64 descriptor_index, NUL name) entries: the index into the
// NT_BADC_MACHO_TLV_DESC list and the referenced `extern _Thread_local`
// variable. The linker overwrites that descriptor's offset with the
// variable's offset in the merged TLS block.
const NT_BADC_MACHO_TLV_DESC_SYM: u32 = 9;
// Linux/x86_64 TLS access fixups. desc is a sequence of entries, each:
//   u64 imm_offset (byte offset of the `sub` imm32 in `.text`)
//   u8  kind (0 = same-unit local, 1 = cross-unit extern)
//   kind 0: u64 local_offset (byte offset in this unit's TLS block)
//   kind 1: NUL name (the referenced `extern _Thread_local` symbol)
// The linker patches each imm32 with the variable's TPOFF once the
// units' TLS blocks are merged.
const NT_BADC_ELF_TPOFF: u32 = 10;
const SHF_WRITE: u64 = 0x1;
const SHF_ALLOC: u64 = 0x2;
const SHF_EXECINSTR: u64 = 0x4;
const SHF_INFO_LINK: u64 = 0x40;

// x86_64 reloc types (System V psABI x86_64 supplement, table 4.10).
const R_X86_64_64: u32 = 1;
const R_X86_64_PC32: u32 = 2;
const R_X86_64_PLT32: u32 = 4;
const R_X86_64_32: u32 = 10;
const R_X86_64_PC64: u32 = 24;
// Relaxable GOT load (psABI B.2): marks a `REX mov reg, [rip+disp32]`
// whose disp32 is the GOT-entry offset. A linker resolving the symbol
// within the image relaxes the load to `lea` and drops the GOT entry,
// so fully static links need no GOT; otherwise it behaves exactly like
// `R_X86_64_GOTPCREL`, which linkers never relax.
const R_X86_64_REX_GOTPCRELX: u32 = 42;
// Local-exec TLS: the linker writes the (negative, variant-2) TP-relative
// offset of the symbol into the `add r64, imm32` immediate.
const R_X86_64_TPOFF32: u32 = 23;

// AArch64 reloc types (ELF for the ARM 64-bit architecture, table 5-1).
const R_AARCH64_ABS64: u32 = 257;
const R_AARCH64_ABS32: u32 = 258;
const R_AARCH64_PREL64: u32 = 260;
const R_AARCH64_PREL32: u32 = 261;
const R_AARCH64_ADR_PREL_PG_HI21: u32 = 275;
const R_AARCH64_ADD_ABS_LO12_NC: u32 = 277;
const R_AARCH64_CALL26: u32 = 283;
// GOT-indirect page + offset: address-taking a dylib-routed import goes
// through the GOT because the symbol binds against a shared object at
// load time (a direct ADR_PREL page relocation would force a copy
// relocation / canonical PLT entry for a symbol that always lives in a
// shared library).
const R_AARCH64_ADR_GOT_PAGE: u32 = 311;
const R_AARCH64_LD64_GOT_LO12_NC: u32 = 312;
// Local-exec TLS pair over the two-`add` sequence: the linker splits the
// TP-relative offset (variant-1, 16-byte TCB bias included) into the
// shifted high and low 12-bit immediates.
const R_AARCH64_TLSLE_ADD_TPREL_HI12: u32 = 549;
const R_AARCH64_TLSLE_ADD_TPREL_LO12_NC: u32 = 551;
const STB_LOCAL: u8 = 0;
const STB_GLOBAL: u8 = 1;
const STB_WEAK: u8 = 2;
const STT_NOTYPE: u8 = 0;
const STT_OBJECT: u8 = 1;
const STT_FUNC: u8 = 2;
const STT_FILE: u8 = 4;
const STT_SECTION: u8 = 3;
const STT_TLS: u8 = 6;
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

/// One `.init_array` / `.fini_array` section plus its companion
/// `.rela.*`: a group of constructor / destructor pointers sharing a
/// priority. The writer appends the pair after the fixed sections.
struct InitArraySection {
    name: String,
    rela_name: String,
    sh_type: u32,
    /// Entry count -- each is an 8-byte function pointer, so the
    /// section's byte size is `count * 8`.
    count: usize,
    rela: Vec<u8>,
}

/// Group `init_funcs` by (destructor?, priority) into `.init_array` /
/// `.fini_array` sections, building each group's `.rela` payload that
/// binds slot `i` to its function symbol. Prioritized groups get the
/// GNU `.init_array.NNNNN` name; the bare form carries the rest.
fn build_init_array_sections(
    init_funcs: &[crate::c5::program::InitFunc],
    func_symidx_by_name: &alloc::collections::BTreeMap<String, u32>,
    rtype_abs64: u32,
) -> Result<Vec<InitArraySection>, C5Error> {
    if init_funcs.is_empty() {
        return Ok(Vec::new());
    }
    // Deterministic group order: constructors before destructors,
    // prioritized (ascending) before unprioritized. Section names
    // carry the ordering a linker actually sorts on; this is only for
    // reproducible output. Within a group, source order is preserved.
    let mut groups: alloc::collections::BTreeMap<(bool, bool, u32), Vec<u32>> =
        alloc::collections::BTreeMap::new();
    for f in init_funcs {
        let sym_idx = *func_symidx_by_name.get(&f.name).ok_or_else(|| {
            C5Error::Compile(crate::c5::error::fmt_internal_err(&format!(
                "elf_reloc: init/fini function `{}` has no .symtab entry",
                f.name
            )))
        })?;
        let key = (
            f.is_destructor,
            f.priority.is_none(),
            f.priority.unwrap_or(0),
        );
        groups.entry(key).or_default().push(sym_idx);
    }
    let mut out = Vec::with_capacity(groups.len());
    for ((is_dtor, no_prio, prio), sym_idxs) in groups {
        let base = if is_dtor {
            ".fini_array"
        } else {
            ".init_array"
        };
        let name = if no_prio {
            base.to_string()
        } else {
            format!("{base}.{prio:05}")
        };
        let rela_name = format!(".rela{name}");
        let mut rela = Vec::with_capacity(sym_idxs.len() * ELF64_RELA_SIZE);
        for (i, sym_idx) in sym_idxs.iter().enumerate() {
            write_struct(
                &mut rela,
                &Elf64Rela {
                    r_offset: (i * 8) as u64,
                    r_info: ((*sym_idx as u64) << 32) | rtype_abs64 as u64,
                    r_addend: 0,
                },
            );
        }
        out.push(InitArraySection {
            name,
            rela_name,
            sh_type: if is_dtor {
                SHT_FINI_ARRAY
            } else {
                SHT_INIT_ARRAY
            },
            count: sym_idxs.len(),
            rela,
        });
    }
    Ok(out)
}

/// Byte size of a defined data global, for the symbol table's
/// `st_size`. Pointers and scalars resolve by width (ELF targets are
/// LP64, so `long` is 8); an array multiplies by its element count. A
/// struct / union global returns 0 -- its storage size needs the type
/// layout machinery the object writer doesn't carry, and a zero
/// `st_size` matches the prior behavior. A correct size matters for a
/// COPY-relocated data import (`environ`), whose `st_size` the loader
/// compares against the host symbol's.
fn data_global_byte_size(sym: &crate::c5::symbol::Symbol) -> u64 {
    use crate::c5::compiler::types::{is_pointer_ty, strip_unsigned};
    use crate::c5::token::Ty;
    let ty = sym.type_;
    let elem: u64 = if is_pointer_ty(ty) {
        8
    } else {
        let stripped = strip_unsigned(ty);
        if stripped == Ty::Char as i64 || stripped == Ty::Bool as i64 {
            1
        } else if stripped == Ty::Short as i64 {
            2
        } else if stripped == Ty::Int as i64 || stripped == Ty::Float as i64 {
            4
        } else if stripped == Ty::Long as i64
            || stripped == Ty::LongLong as i64
            || stripped == Ty::Double as i64
        {
            8
        } else {
            return 0;
        }
    };
    let count = if sym.array_size > 0 {
        sym.array_size as u64
    } else {
        1
    };
    elem * count
}

/// Emit a relocatable ELF64 object holding the contents of
/// `build`. The result is a standard `.o` that `ld` / `lld` can
/// link: the writer emits `.rela.text` (SHT_RELA, `sh_info` = the
/// `.text` section index) with one entry per call site, so a TU with
/// cross-TU calls resolves at link time.
/// One byte range moving from `.text` / `.data` / `.bss` into a named
/// section: `[old_lo, old_hi)` in the pre-carve offset space lands at
/// `new_base` within `table.entries[entry]`.
#[derive(Debug, Clone, Copy)]
struct CarveRange {
    old_lo: u64,
    old_hi: u64,
    new_base: u64,
    entry: usize,
}

/// The `__attribute__((section("name")))` placement plan: the named
/// sections plus the maps that retarget symbols and relocations from
/// the default sections into them.
#[derive(Debug, Clone, Default)]
struct CarvePlan {
    table: super::section_table::SectionTable,
    /// Sorted by `old_lo`; a contiguous tail run of `.text`.
    text_ranges: Vec<CarveRange>,
    /// Sorted by `old_lo`; absolute offsets in the unified
    /// `.data`-then-`.bss` space.
    data_ranges: Vec<CarveRange>,
    /// `.text` prefix length that stays in place.
    text_keep_len: usize,
    /// Per-entry section index / STT_SECTION symbol index.
    shndx: Vec<u16>,
    sym_idx: Vec<u64>,
}

impl CarvePlan {
    fn is_empty(&self) -> bool {
        self.table.is_empty()
    }

    fn map_in(ranges: &[CarveRange], off: u64) -> Option<(usize, u64)> {
        let i = ranges.partition_point(|r| r.old_lo <= off);
        if i == 0 {
            return None;
        }
        let r = &ranges[i - 1];
        if off < r.old_hi {
            Some((r.entry, r.new_base + (off - r.old_lo)))
        } else {
            None
        }
    }

    /// New (entry, offset) for a pre-carve `.text` offset, when moved.
    fn map_text(&self, off: u64) -> Option<(usize, u64)> {
        Self::map_in(&self.text_ranges, off)
    }

    /// New (entry, offset) for a pre-carve unified data offset, when
    /// moved.
    fn map_data(&self, off: u64) -> Option<(usize, u64)> {
        Self::map_in(&self.data_ranges, off)
    }

    /// Rewrite one relocation row: a reference through a default
    /// section symbol whose addend falls in a moved range switches to
    /// the named section's symbol and rebased addend.
    fn retarget(
        &self,
        info: &mut u64,
        addend: &mut i64,
        text_sym: u64,
        data_sym: u64,
        bss_sym: u64,
        data_file_len: u64,
    ) {
        let sym = *info >> 32;
        let rtype = *info & 0xffff_ffff;
        // `R_X86_64_PC32` rows store the target offset skewed by the
        // pc-relative correction; every other section-relative row
        // stores it directly. (The aarch64 types all sit above 0x100,
        // so the numeric check cannot misfire.)
        let skew: i64 = if rtype == R_X86_64_PC32 as u64 { -4 } else { 0 };
        let real = (*addend - skew) as u64;
        let mapped = if sym == text_sym {
            self.map_text(real)
        } else if sym == data_sym {
            self.map_data(real)
        } else if sym == bss_sym {
            self.map_data(real + data_file_len)
        } else {
            None
        };
        if let Some((e, new_off)) = mapped {
            *info = (self.sym_idx[e] << 32) | rtype;
            *addend = new_off as i64 + skew;
        }
    }
}

/// Partition a serialized `.rela` payload against the carve plan:
/// every row is retargeted (section-symbol + addend rewrite), and a
/// row whose `r_offset` sits in a moved range is drained into the
/// owning named section's relocation list with a rebased offset.
/// `applies_to_text` selects which offset space `r_offset` lives in.
fn carve_partition_relas(
    bytes: &mut Vec<u8>,
    plan: &mut CarvePlan,
    applies_to_text: bool,
    text_sym: u64,
    data_sym: u64,
    bss_sym: u64,
    data_file_len: u64,
) {
    if plan.is_empty() || bytes.is_empty() {
        return;
    }
    let mut kept: Vec<u8> = Vec::with_capacity(bytes.len());
    for row in bytes.chunks_exact(ELF64_RELA_SIZE) {
        let r_offset = u64::from_le_bytes(row[0..8].try_into().unwrap());
        let mut r_info = u64::from_le_bytes(row[8..16].try_into().unwrap());
        let mut r_addend = i64::from_le_bytes(row[16..24].try_into().unwrap());
        plan.retarget(
            &mut r_info,
            &mut r_addend,
            text_sym,
            data_sym,
            bss_sym,
            data_file_len,
        );
        let home = if applies_to_text {
            plan.map_text(r_offset)
        } else {
            plan.map_data(r_offset)
        };
        if let Some((e, new_off)) = home {
            plan.table.entries[e]
                .relas
                .push(super::section_table::SectionRela {
                    offset: new_off,
                    sym: r_info >> 32,
                    rtype: (r_info & 0xffff_ffff) as u32,
                    addend: r_addend,
                });
            continue;
        }
        kept.extend_from_slice(&r_offset.to_le_bytes());
        kept.extend_from_slice(&r_info.to_le_bytes());
        kept.extend_from_slice(&r_addend.to_le_bytes());
    }
    *bytes = kept;
}

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
    // Base section count (null + the fixed sections, plus the two TLS
    // sections when present). Each `.init_array` / `.fini_array` group
    // adds two more (the array + its `.rela`), counted once the groups
    // are known below.
    let base_sections: usize = if has_tls { 17 } else { 15 };

    // ---- `__attribute__((section("name")))` placement plan ----
    //
    // Functions with a section attribute were grouped at the `.text`
    // tail by the emission-order pass; each group's byte range moves
    // into its named section, and `.text` keeps only the default
    // prefix (plus the trailing version marker). Data objects with a
    // section attribute move their `.data` / `.bss` byte range into
    // the named section; the vacated file bytes are zeroed in place so
    // no other data offset shifts. Symbols and relocations touching a
    // moved range are retargeted below. Named sections take one index
    // each right after the fixed set; `.rela` companions and
    // `.init_array` groups follow.
    // TODO: `.debug_info` / `.debug_line` still describe carved
    // functions at their pre-carve `.text` offsets.
    let mut carve = CarvePlan::default();
    // Planned content length per table entry; asm payloads append past
    // the attribute content recorded here.
    let mut sizes: Vec<u64> = Vec::new();
    {
        use crate::c5::symbol::Linkage;
        use crate::c5::token::Token;
        let fn_section: alloc::collections::BTreeMap<&str, &str> = program
            .symbols
            .iter()
            .filter(|s| s.class == Token::Fun as i64 && s.defined_here && s.section_name.is_some())
            .map(|s| (s.name.as_str(), s.section_name.as_deref().unwrap_or("")))
            .collect();
        // The emitted code ends at the last recorded native offset;
        // the version marker sits past it and stays in `.text`.
        let code_end = build
            .pc_to_native
            .last()
            .copied()
            .unwrap_or(build.text.len());
        // (group_lo, group_hi) accumulated per section name.
        let mut text_groups: alloc::collections::BTreeMap<&str, (usize, usize)> =
            alloc::collections::BTreeMap::new();
        for (i, &ent_pc) in build.func_ent_pcs.iter().enumerate() {
            let Some(name) = build.func_names.get(i) else {
                continue;
            };
            let Some(sec) = fn_section.get(name.as_str()) else {
                continue;
            };
            let lo = build.pc_to_native.get(ent_pc).copied().unwrap_or(usize::MAX);
            let hi = build
                .func_ent_pcs
                .get(i + 1)
                .and_then(|&next| build.pc_to_native.get(next).copied())
                .unwrap_or(code_end)
                .min(code_end);
            if lo == usize::MAX || lo >= hi {
                continue;
            }
            let g = text_groups.entry(sec).or_insert((lo, hi));
            g.0 = g.0.min(lo);
            g.1 = g.1.max(hi);
        }
        let internal = |msg: String| -> C5Error {
            C5Error::Compile(crate::c5::error::fmt_internal_err(&msg))
        };
        for (sec, (lo, hi)) in &text_groups {
            let e = carve
                .table
                .get_or_insert(sec, SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 16)
                .map_err(internal)?;
            carve.text_ranges.push(CarveRange {
                old_lo: *lo as u64,
                old_hi: *hi as u64,
                new_base: 0,
                entry: e,
            });
        }
        carve.text_ranges.sort_by_key(|r| r.old_lo);
        // The groups must tile the `.text` tail: every carved byte
        // sits past every default-section function, and no two groups
        // interleave. The emission-order pass guarantees this; a
        // violation is an internal error, not a silent miscompile.
        if let Some(first) = carve.text_ranges.first() {
            carve.text_keep_len = first.old_lo as usize;
            let mut prev_hi = first.old_lo;
            for r in &carve.text_ranges {
                if r.old_lo != prev_hi {
                    return Err(internal(format!(
                        "named-section text groups are not contiguous at offset {}",
                        r.old_lo
                    )));
                }
                prev_hi = r.old_hi;
            }
            if prev_hi as usize != code_end {
                return Err(internal(format!(
                    "named-section text groups do not end at the code tail ({prev_hi} vs {code_end})"
                )));
            }
        } else {
            carve.text_keep_len = build.text.len();
        }
        // Data objects. Zero-sized records are skipped -- there is
        // nothing to place.
        for sym in &program.symbols {
            if sym.class != Token::Glo as i64
                || !sym.defined_here
                || sym.is_alias
                || sym.is_thread_local
                || sym.section_name.is_none()
                || !matches!(sym.linkage, Linkage::External | Linkage::Internal)
            {
                continue;
            }
            let size = (sym.reserved_data_bytes as u64).max(data_global_byte_size(sym));
            if size == 0 {
                continue;
            }
            let sec = sym.section_name.as_deref().unwrap_or("");
            let e = carve
                .table
                .get_or_insert(sec, SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8)
                .map_err(internal)?;
            carve.data_ranges.push(CarveRange {
                old_lo: sym.val as u64,
                old_hi: sym.val as u64 + size,
                new_base: 0,
                entry: e,
            });
        }
        carve.data_ranges.sort_by_key(|r| r.old_lo);
        // Assign packed in-section bases: text groups keep their
        // internal layout wholesale; data objects pack 8-aligned.
        sizes.resize(carve.table.entries.len(), 0);
        for r in carve.text_ranges.iter_mut().chain(carve.data_ranges.iter_mut()) {
            let base = (sizes[r.entry] + 7) & !7;
            r.new_base = base;
            sizes[r.entry] = base + (r.old_hi - r.old_lo);
        }
        for w in carve.data_ranges.windows(2) {
            if w[0].old_hi > w[1].old_lo {
                return Err(internal(format!(
                    "named-section data ranges overlap at offset {}",
                    w[1].old_lo
                )));
            }
        }
    }
    // Inline-asm `.pushsection` payloads join the same table. Letter
    // flags and the `@type` argument map to sh_flags / sh_type; a
    // block sharing a name with an attribute placement merges into the
    // existing entry, its bytes placed past the attribute content at
    // the block's alignment. `asm_placements[i]` is the (entry, base)
    // of `build.asm_sections[i]`.
    let mut asm_placements: Vec<(usize, u64)> = Vec::with_capacity(build.asm_sections.len());
    for s in &build.asm_sections {
        let mut flags: u64 = 0;
        for c in s.flags.bytes() {
            match c {
                b'a' => flags |= SHF_ALLOC,
                b'w' => flags |= SHF_WRITE,
                b'x' => flags |= SHF_EXECINSTR,
                // Merge / strings / group flags are layout hints a
                // relocatable object can omit without changing meaning.
                _ => {}
            }
        }
        let sh_type = match s.sh_type.as_deref() {
            Some("nobits") => SHT_NOBITS,
            Some("note") => SHT_NOTE,
            _ => SHT_PROGBITS,
        };
        let align = s.align.max(1) as u64;
        let e = carve
            .table
            .get_or_insert(&s.name, sh_type, flags, align)
            .map_err(|msg| C5Error::Compile(crate::c5::error::fmt_internal_err(&msg)))?;
        if sizes.len() <= e {
            sizes.resize(e + 1, 0);
        }
        let base = round_up(sizes[e], align);
        sizes[e] = base + s.bytes.len() as u64;
        asm_placements.push((e, base));
    }
    for k in 0..carve.table.entries.len() {
        carve.shndx.push((base_sections + k) as u16);
        carve.sym_idx.push(0);
    }
    let named_section_count = carve.table.entries.len();

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
    // Local STT_TLS anchors at each TLS section's start carry the
    // local-exec relocations of `static _Thread_local` accesses
    // (anchor + addend). STT_SECTION anchors would work for the
    // arithmetic but linkers require a TLS-typed symbol on TLS
    // relocations; named globals get their own entries below.
    let (tdata_sec_sym, tbss_sec_sym) = if has_tls {
        let td = symbols.len() as u64;
        symbols.push(Elf64Sym {
            st_info: pack_sym_info(STB_LOCAL, STT_TLS),
            st_shndx: SHIDX_TDATA,
            ..Default::default()
        });
        let tb = symbols.len() as u64;
        symbols.push(Elf64Sym {
            st_info: pack_sym_info(STB_LOCAL, STT_TLS),
            st_shndx: SHIDX_TBSS,
            ..Default::default()
        });
        (td, tb)
    } else {
        (0, 0)
    };
    // One STT_SECTION symbol per named section so relocations into a
    // carved range can reference the section + offset.
    for k in 0..named_section_count {
        carve.sym_idx[k] = symbols.len() as u64;
        symbols.push(Elf64Sym {
            st_info: pack_sym_info(STB_LOCAL, STT_SECTION),
            st_shndx: carve.shndx[k],
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
            .filter(|s| s.class == Token::Fun as i64 && s.defined_here && !s.is_alias)
            .map(|s| (s.val as usize, s.linkage))
            .collect()
    };
    // `__attribute__((weak))` symbols bind STB_WEAK wherever the name
    // surfaces: as a definition or as an UNDEF reference.
    let weak_names: alloc::collections::BTreeSet<&str> = {
        use crate::c5::token::Token;
        program
            .symbols
            .iter()
            .filter(|s| {
                s.is_weak
                    && (s.class == Token::Fun as i64 || s.class == Token::Glo as i64)
                    && !s.name.is_empty()
            })
            .map(|s| s.name.as_str())
            .collect()
    };
    let bind_for = |name: &str| -> u8 {
        if weak_names.contains(name) {
            STB_WEAK
        } else {
            STB_GLOBAL
        }
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
        // Synthetic `__c5_sys_*` libc-address trampolines (one per
        // distinct `&libc_fn` taken in a `.data` function-pointer
        // table) are per-TU helpers: each is referenced only within
        // its defining unit through a `.text`-section-relative reloc
        // (the addend carries the trampoline's byte offset, so no
        // by-name `.symtab` reference exists). Two units that both
        // take `&exp` each emit their own `__c5_sys_exp`; binding
        // them STB_GLOBAL collides at link time. STB_LOCAL keeps the
        // copies private and the merge pass tolerates the duplicate.
        let is_sys_trampoline = name.starts_with("__c5_sys_");
        func_strs.push(name);
        match func_linkage_by_pc.get(&ent_pc) {
            _ if is_sys_trampoline => local_func_idxs.push(i),
            Some(crate::c5::symbol::Linkage::Internal) => local_func_idxs.push(i),
            _ => global_func_idxs.push(i),
        }
    }
    // Unique cross-TU user-function names referenced by
    // `user_extern_call_sites`. Each gets exactly one
    // undefined symbol entry; multiple call sites against the
    // same callee share it. Sites whose callee is defined in
    // this unit (cross-named-section calls) resolve against the
    // defined symbol instead and need no UNDEF entry.
    let defined_fn_names: alloc::collections::BTreeSet<&str> =
        build.func_names.iter().map(|s| s.as_str()).collect();
    let mut user_extern_names: Vec<&str> = Vec::new();
    for site in &build.user_extern_call_sites {
        let s = site.symbol_name.as_str();
        if !defined_fn_names.contains(s) && !user_extern_names.contains(&s) {
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
    // offset within `.data`; the size comes from the symbol's type
    // (struct / union globals stay unsized).
    let mut defined_data_globals: Vec<(&str, i64, u64)> = Vec::new();
    // Defined `_Thread_local` symbols: name, offset within this unit's
    // TLS block, byte size. Exported through NT_BADC_TLS_SYM (not the
    // `.data` symbol table -- their value is a TLS-block offset, not a
    // `.data` offset, and merging them as `.data` symbols would collide).
    let mut defined_tls_globals: Vec<(&str, i64, u64)> = Vec::new();
    {
        use crate::c5::symbol::Linkage;
        use crate::c5::token::Token;
        for sym in &program.symbols {
            if sym.class == Token::Glo as i64
                && sym.defined_here
                && sym.linkage == Linkage::External
                && !sym.name.is_empty()
            {
                if sym.is_thread_local {
                    defined_tls_globals.push((
                        sym.name.as_str(),
                        sym.val,
                        data_global_byte_size(sym),
                    ));
                } else {
                    defined_data_globals.push((
                        sym.name.as_str(),
                        sym.val,
                        data_global_byte_size(sym),
                    ));
                }
            }
        }
    }

    // Unique cross-TU user-data names referenced by
    // `user_extern_data_refs` (code references) and
    // `extern_data_relocs` (pointer-to-extern-data initializers in the
    // data segment). Both resolve against the same undefined-data
    // symbols.
    let mut user_extern_data_names: Vec<&str> = Vec::new();
    for r in &build.user_extern_data_refs {
        let s = r.symbol_name.as_str();
        if !user_extern_data_names.contains(&s) {
            user_extern_data_names.push(s);
        }
    }
    for r in &build.extern_data_relocs {
        let s = r.symbol_name.as_str();
        if !user_extern_data_names.contains(&s) {
            user_extern_data_names.push(s);
        }
    }

    // Data objects defined in this unit, by name and unified data
    // offset; an inline-asm section reloc naming one resolves
    // section-relative like the attribute path.
    let defined_data_by_name: alloc::collections::BTreeMap<&str, i64> = {
        use crate::c5::symbol::Linkage;
        use crate::c5::token::Token;
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
            .map(|s| (s.name.as_str(), s.val))
            .collect()
    };
    // Inline-asm section reloc names with neither a definition in this
    // unit nor an existing UNDEF entry get their own undefined symbols.
    let mut asm_extern_names: Vec<&str> = Vec::new();
    for s in &build.asm_sections {
        for r in &s.relocs {
            use crate::c5::codegen::ssa::emit_common::AsmSectionTarget;
            let AsmSectionTarget::Symbol(name) = &r.target else {
                continue;
            };
            let n = name.as_str();
            if !defined_fn_names.contains(n)
                && !program.function_aliases.iter().any(|a| a.name == n)
                && !defined_data_by_name.contains_key(n)
                && !user_extern_names.contains(&n)
                && !user_extern_data_names.contains(&n)
                && !asm_extern_names.contains(&n)
            {
                asm_extern_names.push(n);
            }
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
    for (name, _, _) in &defined_data_globals {
        all_names.push(*name);
    }
    let user_extern_data_names_start = all_names.len();
    for name in &user_extern_data_names {
        all_names.push(*name);
    }
    let asm_extern_names_start = all_names.len();
    for name in &asm_extern_names {
        all_names.push(*name);
    }
    // Standard TLS symbols + local-exec relocations are the ELF interop
    // surface for an external linker; they describe the variant-1/2
    // `tp`-relative access models, which only the Linux targets use. A
    // Windows-target unit reuses this container but its TLS surface is
    // the PE model (TEB + `_tls_index`), carried by the note channel.
    let elf_tls_interop = matches!(
        target,
        super::Target::LinuxX64 | super::Target::LinuxAarch64
    );
    // Cross-unit `extern _Thread_local` names referenced by TLS access
    // fixups, deduplicated; each surfaces as an undefined STT_TLS symbol
    // the local-exec relocations bind against.
    let mut extern_tls_names: Vec<&str> = Vec::new();
    if elf_tls_interop {
        for f in &build.elf_tpoff_fixups {
            if let super::ElfTpoffTarget::Extern(name) = &f.target
                && !extern_tls_names.contains(&name.as_str())
            {
                extern_tls_names.push(name.as_str());
            }
        }
    }
    let defined_tls_globals_start = all_names.len();
    if elf_tls_interop {
        for (name, _, _) in &defined_tls_globals {
            all_names.push(*name);
        }
    }
    let extern_tls_names_start = all_names.len();
    for name in &extern_tls_names {
        all_names.push(*name);
    }
    let prologue_end_names_start = all_names.len();
    for s in &prologue_end_names {
        all_names.push(s.as_str());
    }
    let fn_alias_names_start = all_names.len();
    for a in &program.function_aliases {
        all_names.push(a.name.as_str());
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
    // Function name -> `.symtab` index, for the `.init_array` /
    // `.fini_array` relocations to reference each constructor /
    // destructor function symbol. Covers both static (STB_LOCAL) and
    // external (STB_GLOBAL) functions.
    let mut func_symidx_by_name: alloc::collections::BTreeMap<String, u32> =
        alloc::collections::BTreeMap::new();
    // Where a `.text` offset ends up: the named section's index and
    // rebased offset for a carved range, `.text` itself otherwise.
    let text_place = |off: u64| -> (u16, u64) {
        match carve.map_text(off) {
            Some((e, new_off)) => (carve.shndx[e], new_off),
            None => (SHIDX_TEXT, off),
        }
    };
    // STB_LOCAL function symbols. Emitted before `first_global`
    // so the LOCAL block is contiguous as ELF requires.
    for &i in &local_func_idxs {
        let (lo, hi) = func_extent(i)?;
        let (shndx, value) = text_place(lo as u64);
        func_symidx_by_name.insert(func_strs[i].clone(), symbols.len() as u32);
        symbols.push(Elf64Sym {
            st_name: name_offs[1 + i],
            st_info: pack_sym_info(STB_LOCAL, STT_FUNC),
            st_shndx: shndx,
            st_value: value,
            st_size: hi.saturating_sub(lo) as u64,
            ..Default::default()
        });
    }
    // Prologue_end synthetic locals (also STB_LOCAL, also
    // pre-first_global). Each one's `st_value` is the native
    // byte offset of the first post-prologue instruction; size
    // stays zero (a marker, not a code region).
    for (j, &(_i, post_native)) in prologue_end_entries.iter().enumerate() {
        let (shndx, value) = text_place(post_native as u64);
        symbols.push(Elf64Sym {
            st_name: name_offs[prologue_end_names_start + j],
            st_info: pack_sym_info(STB_LOCAL, STT_NOTYPE),
            st_shndx: shndx,
            st_value: value,
            st_size: 0,
            ..Default::default()
        });
    }
    let first_global = symbols.len() as u32;
    // STB_GLOBAL (or, for `__attribute__((weak))` definitions,
    // STB_WEAK) function symbols.
    for &i in &global_func_idxs {
        let (lo, hi) = func_extent(i)?;
        let (shndx, value) = text_place(lo as u64);
        func_symidx_by_name.insert(func_strs[i].clone(), symbols.len() as u32);
        symbols.push(Elf64Sym {
            st_name: name_offs[1 + i],
            st_info: pack_sym_info(bind_for(&func_strs[i]), STT_FUNC),
            st_shndx: shndx,
            st_value: value,
            st_size: hi.saturating_sub(lo) as u64,
            ..Default::default()
        });
    }

    // `alias("target")` function symbols: an additional name at the
    // target's extent.
    for (i, a) in program.function_aliases.iter().enumerate() {
        let Some(ti) = func_strs.iter().position(|n| n == &a.target) else {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!("alias `{}`: target `{}` has no emitted body", a.name, a.target),
            )));
        };
        let (lo, hi) = func_extent(ti)?;
        let (shndx, value) = text_place(lo as u64);
        func_symidx_by_name.insert(a.name.clone(), symbols.len() as u32);
        symbols.push(Elf64Sym {
            st_name: name_offs[fn_alias_names_start + i],
            st_info: pack_sym_info(if a.weak { STB_WEAK } else { STB_GLOBAL }, STT_FUNC),
            st_shndx: shndx,
            st_value: value,
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
    for (i, name) in user_extern_names.iter().enumerate() {
        user_extern_sym_idx.push(symbols.len());
        symbols.push(Elf64Sym {
            st_name: name_offs[user_extern_names_start + i],
            st_info: pack_sym_info(bind_for(name), STT_NOTYPE),
            st_shndx: SHN_UNDEF,
            ..Default::default()
        });
    }

    // Section symbol indices follow the order they are pushed:
    // null(0), file(1), text(2), data(3), bss(4), .debug_line(5),
    // .debug_abbrev(6). Data + function-pointer fixups land against the
    // matching section symbol; the `r_addend` carries the offset within
    // the section.
    let text_sym_idx: u64 = 2;
    let data_sym_idx: u64 = 3;
    let bss_sym_idx: u64 = 4;
    let debug_line_sym_idx: u64 = 5;
    let debug_abbrev_sym_idx: u64 = 6;

    // A data offset at or past the file image names a byte in the
    // zero-fill `.bss` section; map it to that section symbol and the
    // offset within it. `build.data` holds only the file-backed bytes
    // after zero-object segregation.
    let data_file_len = build.data.len() as i64;
    let data_section_ref = |off: i64| -> (u64, i64) {
        if off >= data_file_len {
            (bss_sym_idx, off - data_file_len)
        } else {
            (data_sym_idx, off)
        }
    };

    // Defined data globals: STB_GLOBAL + STT_OBJECT, in `.data` or, for
    // a wholly-zero object, `.bss`. C99 6.2.2: external-linkage objects
    // surface by name so sibling TUs can resolve `extern T x;`.
    for (i, (name, val, size)) in defined_data_globals.iter().enumerate() {
        let (shndx, value) = match carve.map_data(*val as u64) {
            Some((e, new_off)) => (carve.shndx[e], new_off),
            None => {
                let (sym_sec, value) = data_section_ref(*val);
                (sym_sec as u16, value as u64)
            }
        };
        symbols.push(Elf64Sym {
            st_name: name_offs[defined_data_globals_start + i],
            st_info: pack_sym_info(bind_for(name), STT_OBJECT),
            st_shndx: shndx,
            st_value: value,
            st_size: *size,
            ..Default::default()
        });
    }

    // Cross-TU user-data imports: STB_GLOBAL + STT_OBJECT +
    // SHN_UNDEF. The linker resolves these against the matching
    // defined-data globals emitted by sibling units (above).
    let mut user_extern_data_sym_idx: Vec<usize> = Vec::with_capacity(user_extern_data_names.len());
    for (i, name) in user_extern_data_names.iter().enumerate() {
        user_extern_data_sym_idx.push(symbols.len());
        symbols.push(Elf64Sym {
            st_name: name_offs[user_extern_data_names_start + i],
            st_info: pack_sym_info(bind_for(name), STT_OBJECT),
            st_shndx: SHN_UNDEF,
            ..Default::default()
        });
    }

    // Undefined symbols for inline-asm section reloc targets no other
    // table covers; the linker resolves them against sibling units.
    let mut asm_extern_sym_idx: Vec<usize> = Vec::with_capacity(asm_extern_names.len());
    for (i, name) in asm_extern_names.iter().enumerate() {
        asm_extern_sym_idx.push(symbols.len());
        symbols.push(Elf64Sym {
            st_name: name_offs[asm_extern_names_start + i],
            st_info: pack_sym_info(bind_for(name), STT_NOTYPE),
            st_shndx: SHN_UNDEF,
            ..Default::default()
        });
    }

    // Defined `_Thread_local` globals: STB_GLOBAL + STT_TLS against
    // `.tdata` / `.tbss` with a section-relative value, so sibling
    // units' local-exec relocations resolve through the merged TLS
    // block. The unit's block is `.tdata` bytes then `.tbss` zero
    // fill; an offset past the initialized bytes is `.tbss`-relative.
    let tls_init_len = program.tls_init_size.min(program.tls_data.len()) as i64;
    for (i, (_, off, size)) in defined_tls_globals
        .iter()
        .enumerate()
        .take_while(|_| elf_tls_interop)
    {
        let (shndx, value) = if *off >= tls_init_len {
            (SHIDX_TBSS, off - tls_init_len)
        } else {
            (SHIDX_TDATA, *off)
        };
        symbols.push(Elf64Sym {
            st_name: name_offs[defined_tls_globals_start + i],
            st_info: pack_sym_info(STB_GLOBAL, STT_TLS),
            st_shndx: shndx,
            st_value: value as u64,
            st_size: *size,
            ..Default::default()
        });
    }

    // Cross-unit `extern _Thread_local` imports: STB_GLOBAL + STT_TLS +
    // SHN_UNDEF.
    let mut extern_tls_sym_idx: Vec<usize> = Vec::with_capacity(extern_tls_names.len());
    for (i, _name) in extern_tls_names.iter().enumerate() {
        extern_tls_sym_idx.push(symbols.len());
        symbols.push(Elf64Sym {
            st_name: name_offs[extern_tls_names_start + i],
            st_info: pack_sym_info(STB_GLOBAL, STT_TLS),
            st_shndx: SHN_UNDEF,
            ..Default::default()
        });
    }

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
        // A callee defined in this unit (a cross-named-section call)
        // resolves against its defined symbol; otherwise the UNDEF.
        let sym_idx = match func_symidx_by_name.get(site.symbol_name.as_str()) {
            Some(&i) => i as u64,
            None => {
                let pos = user_extern_names
                    .iter()
                    .position(|n| *n == site.symbol_name.as_str())
                    .expect("user_extern_names contains every site's symbol name");
                user_extern_sym_idx[pos] as u64
            }
        };
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
        // An address-of site (`&strcmp`, `Inst::ImmExtCode`) is a
        // page-relative address materialization, not a control
        // transfer: `lea reg, [rip+disp32]` on x86_64, `adrp + add`
        // on aarch64. The import binds externally, so take its address
        // through the GOT (`adrp :got: + ldr`); an external linker resolves
        // it against the shared library and badc's own linker relaxes it to
        // the import's PLT stub. The `add` half is rewritten to `ldr` below.
        if site.is_addr {
            emit_got_ref_relocs(
                machine_for_rela,
                &mut rela_bytes,
                site.instr_offset as u64,
                sym_idx,
            );
            continue;
        }
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

    // TLS access sites. Local-exec relocations let an external linker
    // rebase each unit's baked single-unit offset against the merged
    // TLS block: `static _Thread_local` accesses anchor on the TLS
    // section symbol plus the section-relative addend, named externs on
    // their undefined STT_TLS symbol. aarch64 patches the two-`add`
    // pair (`tprel_hi12` at the fixup, `tprel_lo12_nc` on the following
    // word); x86_64 patches the `add` imm32 with the negative TPOFF.
    for f in build
        .elf_tpoff_fixups
        .iter()
        .take_while(|_| elf_tls_interop)
    {
        let (sym_idx, r_addend) = match &f.target {
            super::ElfTpoffTarget::Extern(name) => {
                let pos = extern_tls_names
                    .iter()
                    .position(|n| *n == name.as_str())
                    .expect("extern_tls_names contains every fixup's symbol name");
                (extern_tls_sym_idx[pos] as u64, 0i64)
            }
            super::ElfTpoffTarget::Local(off) => {
                let off = *off as i64;
                if off >= tls_init_len {
                    (tbss_sec_sym, off - tls_init_len)
                } else {
                    (tdata_sec_sym, off)
                }
            }
        };
        match machine_for_rela {
            Machine::X86_64 => {
                write_struct(
                    &mut rela_bytes,
                    &Elf64Rela {
                        r_offset: f.imm_offset as u64,
                        r_info: (sym_idx << 32) | (R_X86_64_TPOFF32 as u64),
                        r_addend,
                    },
                );
            }
            Machine::Aarch64 => {
                write_struct(
                    &mut rela_bytes,
                    &Elf64Rela {
                        r_offset: f.imm_offset as u64,
                        r_info: (sym_idx << 32) | (R_AARCH64_TLSLE_ADD_TPREL_HI12 as u64),
                        r_addend,
                    },
                );
                write_struct(
                    &mut rela_bytes,
                    &Elf64Rela {
                        r_offset: f.imm_offset as u64 + 4,
                        r_info: (sym_idx << 32) | (R_AARCH64_TLSLE_ADD_TPREL_LO12_NC as u64),
                        r_addend,
                    },
                );
            }
        }
    }

    // Data-segment references (string literals / globals). The
    // codegen emits a 2-instruction page-relative pair on
    // aarch64 (`adrp` + `add`) and a `lea rip-rel disp32` on
    // x86_64; each becomes one or two ELF relocs against the
    // `.data` section symbol with `r_addend = data_offset`.
    for fx in &build.data_fixups {
        let (sym, addend) = data_section_ref(fx.data_offset as i64);
        emit_addr_fixup_relocs(
            machine_for_rela,
            &mut rela_bytes,
            fx.adrp_offset as u64,
            sym,
            addend,
        );
    }

    // Cross-TU data references. The reloc targets the named
    // undefined-data symbol with addend zero so the linker resolves
    // it against the defining TU's storage. Per-arch addressing:
    // * x86_64 -- GOT load with the relaxable marking. The linker
    //   relaxes an in-image resolution back to `lea` (a fully static
    //   link ends with an empty GOT) and keeps the indirection for a
    //   shared-library resolution.
    // * aarch64 -- direct `adrp + add`, the same pair local data uses.
    //   No linker relaxes the aarch64 GOT forms, so a GOT reference
    //   cannot serve images whose layout forbids a GOT; the direct
    //   pair resolves within any image, including a PIE, and a
    //   definition only a shared library supplies binds through the
    //   copy relocation / canonical PLT the system linker creates for
    //   direct references from executables.
    for r in &build.user_extern_data_refs {
        let pos = user_extern_data_names
            .iter()
            .position(|n| *n == r.symbol_name.as_str())
            .expect("user_extern_data_names contains every ref's name");
        let sym_idx = user_extern_data_sym_idx[pos] as u64;
        match machine_for_rela {
            Machine::X86_64 => emit_got_ref_relocs(
                machine_for_rela,
                &mut rela_bytes,
                r.instr_offset as u64,
                sym_idx,
            ),
            Machine::Aarch64 => emit_addr_fixup_relocs(
                machine_for_rela,
                &mut rela_bytes,
                r.instr_offset as u64,
                sym_idx,
                0,
            ),
        }
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

    // Route `.rela.text` rows applying within a carved range into the
    // owning named section, and retarget rows whose section-symbol
    // addend points into one.
    carve_partition_relas(
        &mut rela_bytes,
        &mut carve,
        true,
        text_sym_idx,
        data_sym_idx,
        bss_sym_idx,
        data_file_len as u64,
    );

    // Inline-asm section relocations join the owning table entry,
    // offset by the block's placement base. A text-offset target in a
    // carved range retargets to the named section's symbol; a name
    // resolves to a defined function, section-relative defined data,
    // or an undefined symbol.
    {
        use crate::c5::codegen::ssa::emit_common::AsmSectionTarget;
        for (&(e, base), s) in asm_placements.iter().zip(build.asm_sections.iter()) {
            for r in &s.relocs {
                let (sym_idx, addend) = match &r.target {
                    AsmSectionTarget::Text(off) => match carve.map_text(*off as u64) {
                        Some((te, new_off)) => (carve.sym_idx[te], new_off as i64 + r.addend),
                        None => (text_sym_idx, *off as i64 + r.addend),
                    },
                    AsmSectionTarget::Symbol(name) => {
                        if let Some(&idx) = func_symidx_by_name.get(name.as_str()) {
                            (idx as u64, r.addend)
                        } else if let Some(&val) = defined_data_by_name.get(name.as_str()) {
                            match carve.map_data(val as u64) {
                                Some((de, new_off)) => {
                                    (carve.sym_idx[de], new_off as i64 + r.addend)
                                }
                                None => {
                                    let (sym, off) = data_section_ref(val);
                                    (sym, off + r.addend)
                                }
                            }
                        } else if let Some(pos) =
                            user_extern_names.iter().position(|n| *n == name.as_str())
                        {
                            (user_extern_sym_idx[pos] as u64, r.addend)
                        } else if let Some(pos) = user_extern_data_names
                            .iter()
                            .position(|n| *n == name.as_str())
                        {
                            (user_extern_data_sym_idx[pos] as u64, r.addend)
                        } else {
                            let pos = asm_extern_names
                                .iter()
                                .position(|n| *n == name.as_str())
                                .expect("asm_extern_names covers every unresolved asm reloc name");
                            (asm_extern_sym_idx[pos] as u64, r.addend)
                        }
                    }
                };
                let rtype = match (machine_for_rela, r.pcrel, r.width) {
                    (Machine::X86_64, false, 8) => R_X86_64_64,
                    (Machine::X86_64, false, _) => R_X86_64_32,
                    (Machine::X86_64, true, 8) => R_X86_64_PC64,
                    (Machine::X86_64, true, _) => R_X86_64_PC32,
                    (Machine::Aarch64, false, 8) => R_AARCH64_ABS64,
                    (Machine::Aarch64, false, _) => R_AARCH64_ABS32,
                    (Machine::Aarch64, true, 8) => R_AARCH64_PREL64,
                    (Machine::Aarch64, true, _) => R_AARCH64_PREL32,
                };
                carve.table.entries[e]
                    .relas
                    .push(super::section_table::SectionRela {
                        offset: base + r.offset as u64,
                        sym: sym_idx,
                        rtype,
                        addend,
                    });
            }
        }
    }

    // `.rela.data` -- absolute 64-bit relocations for
    // pointer-to-global initializers. `Build::data_relocs` carries
    // `(slot_data_offset, target_data_offset)`; each becomes a
    // `R_X86_64_64` / `R_AARCH64_ABS64` reloc at `slot_data_offset`
    // against the `.data` section symbol with
    // `r_addend = target_data_offset`. The linker resolves to
    // `data_vaddr + target_offset`, the runtime VA of the
    // pointed-at global. Built ahead of the section-count planning so
    // the carve partition below settles every named section's
    // relocation list first.
    let rtype_abs64 = match machine_for_rela {
        Machine::X86_64 => R_X86_64_64,
        Machine::Aarch64 => R_AARCH64_ABS64,
    };
    let mut rela_data_bytes: Vec<u8> =
        Vec::with_capacity((build.data_relocs.len() + build.code_relocs.len()) * ELF64_RELA_SIZE);
    for r in &build.data_relocs {
        let (sym, addend) = data_section_ref(r.target_offset as i64);
        let rela = Elf64Rela {
            r_offset: r.data_offset,
            r_info: (sym << 32) | rtype_abs64 as u64,
            r_addend: addend,
        };
        write_struct(&mut rela_data_bytes, &rela);
    }
    // Pointer-to-extern-data initializers: the reloc targets the named
    // undefined-data symbol so the linker resolves it against the
    // defining unit's storage. The addend carries the byte offset added
    // to the symbol (`&extern_arr[N]`).
    for r in &build.extern_data_relocs {
        let pos = user_extern_data_names
            .iter()
            .position(|n| *n == r.symbol_name.as_str())
            .expect("user_extern_data_names contains every extern_data_reloc name");
        let sym_idx = user_extern_data_sym_idx[pos] as u64;
        let rela = Elf64Rela {
            r_offset: r.data_offset,
            r_info: (sym_idx << 32) | rtype_abs64 as u64,
            r_addend: r.addend,
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
    // Rows applying within a carved data range move to the owning
    // named section; section-symbol targets into carved ranges are
    // retargeted (both directions already handled for `.rela.text`).
    carve_partition_relas(
        &mut rela_data_bytes,
        &mut carve,
        false,
        text_sym_idx,
        data_sym_idx,
        bss_sym_idx,
        data_file_len as u64,
    );

    // `.init_array` / `.fini_array` groups. C99 has no such attribute;
    // GNU practice (matched by every mainstream toolchain) lowers each
    // `__attribute__((constructor))` into an `SHT_INIT_ARRAY` pointer
    // and each `((destructor))` into `SHT_FINI_ARRAY`. An explicit
    // priority rides in the section name (`.init_array.NNNNN`, 5-digit
    // per GNU) so a system linker's `SORT_BY_INIT_PRIORITY` orders
    // across units; unprioritized entries land in the bare
    // `.init_array` the script places last. Entries sharing a group
    // keep source order.
    let init_sections =
        build_init_array_sections(&program.init_funcs, &func_symidx_by_name, rtype_abs64)?;
    // Every named section's relocation list is settled; a `.rela`
    // companion exists exactly for the entries that carry relocations.
    let named_rela_count = carve
        .table
        .entries
        .iter()
        .filter(|e| !e.relas.is_empty())
        .count();
    let num_sections: usize =
        base_sections + named_section_count + named_rela_count + 2 * init_sections.len();

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
    // Named sections (attribute placements + inline-asm payloads) take
    // the indices right after the fixed set; the on-demand `.rela`
    // companions follow the block.
    let named_names_start = shstrtab_names.len();
    for e in &carve.table.entries {
        shstrtab_names.push(e.name.as_str());
    }
    // `named_rela_pos[k]` is entry k's position among the rela-bearing
    // entries; only those contribute a `.rela<name>` string.
    let named_rela_names_start = shstrtab_names.len();
    let mut named_rela_pos: Vec<usize> = Vec::with_capacity(carve.table.entries.len());
    for e in &carve.table.entries {
        named_rela_pos.push(shstrtab_names.len() - named_rela_names_start);
        if !e.relas.is_empty() {
            shstrtab_names.push(e.rela_name.as_str());
        }
    }
    // `.init_array*` / `.fini_array*` names and their `.rela.*`
    // companions, appended last so the fixed and TLS indices stay put.
    let init_names_start = shstrtab_names.len();
    for s in &init_sections {
        shstrtab_names.push(s.name.as_str());
        shstrtab_names.push(s.rela_name.as_str());
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

    // .text -- GOT-addressed extern materializations become GOT loads
    // (see `rewrite_extern_addr_loads_to_got`): import address-of sites
    // (`reloc_call_sites` with `is_addr`) on both arches, and cross-TU
    // data references (`user_extern_data_refs`) on x86_64 only --
    // aarch64 keeps those direct (see the reloc loop above). Same
    // length as `build.text`.
    let mut got_site_offsets: alloc::vec::Vec<usize> = match machine_for_rela {
        Machine::X86_64 => build
            .user_extern_data_refs
            .iter()
            .map(|r| r.instr_offset)
            .collect(),
        Machine::Aarch64 => alloc::vec::Vec::new(),
    };
    got_site_offsets.extend(
        build
            .reloc_call_sites
            .iter()
            .filter(|s| s.is_addr)
            .map(|s| s.instr_offset),
    );
    let mut text_body =
        rewrite_extern_addr_loads_to_got(machine_for_rela, &build.text, &got_site_offsets);
    // Carve the named-section function groups out of the `.text` tail;
    // the default prefix and the trailing version marker stay.
    if !carve.text_ranges.is_empty() {
        for r in &carve.text_ranges {
            let ent = &mut carve.table.entries[r.entry];
            if (ent.bytes.len() as u64) < r.new_base {
                ent.bytes.resize(r.new_base as usize, 0);
            }
            ent.bytes
                .extend_from_slice(&text_body[r.old_lo as usize..r.old_hi as usize]);
        }
        let carve_hi = carve.text_ranges.last().map(|r| r.old_hi as usize).unwrap_or(0);
        text_body.drain(carve.text_keep_len..carve_hi);
    }
    let text_off = round_up(out.len() as u64, 16);
    out.resize(text_off as usize, 0);
    out.extend_from_slice(&text_body);
    sh.push(Elf64Shdr {
        sh_name: shstrtab_offs[0],
        sh_type: SHT_PROGBITS,
        sh_flags: SHF_ALLOC | SHF_EXECINSTR,
        sh_offset: text_off,
        sh_size: text_body.len() as u64,
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

    // .data -- `sh_addralign` carries the unit's base data alignment
    // so the linker places this unit's data at a multiple of it.
    // Objects moved into a named section copy their bytes there and
    // leave zeroed file bytes behind, so no other offset shifts.
    let mut data_body = build.data.clone();
    for r in &carve.data_ranges {
        let ent = &mut carve.table.entries[r.entry];
        if (ent.bytes.len() as u64) < r.new_base {
            ent.bytes.resize(r.new_base as usize, 0);
        }
        let size = (r.old_hi - r.old_lo) as usize;
        let file_lo = (r.old_lo as usize).min(data_body.len());
        let file_hi = (r.old_hi as usize).min(data_body.len());
        ent.bytes.extend_from_slice(&data_body[file_lo..file_hi]);
        // A `.bss`-resident (wholly zero) object contributes zeros.
        ent.bytes.resize(ent.bytes.len() + (size - (file_hi - file_lo)), 0);
        data_body[file_lo..file_hi].fill(0);
    }
    // Inline-asm payloads follow the attribute content of their entry
    // at the placement bases planned above.
    for (&(e, base), s) in asm_placements.iter().zip(build.asm_sections.iter()) {
        let ent = &mut carve.table.entries[e];
        if (ent.bytes.len() as u64) < base {
            ent.bytes.resize(base as usize, 0);
        }
        ent.bytes.extend_from_slice(&s.bytes);
    }
    let data_align = build.data_align.max(8) as u64;
    let data_off = round_up(out.len() as u64, data_align);
    out.resize(data_off as usize, 0);
    out.extend_from_slice(&data_body);
    sh.push(Elf64Shdr {
        sh_name: shstrtab_offs[2],
        sh_type: SHT_PROGBITS,
        sh_flags: SHF_ALLOC | SHF_WRITE,
        sh_offset: data_off,
        sh_size: data_body.len() as u64,
        sh_addralign: data_align,
        ..Default::default()
    });

    // .bss (no file bytes) -- zero-init data segregated past the file
    // image; the linker zero-fills it. `sh_addralign` 16 matches the
    // segregation's alignment.
    sh.push(Elf64Shdr {
        sh_name: shstrtab_offs[3],
        sh_type: SHT_NOBITS,
        sh_flags: SHF_ALLOC | SHF_WRITE,
        sh_offset: out.len() as u64,
        sh_size: build.bss_size as u64,
        sh_addralign: 16,
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

    // .rela.data -- built and carve-partitioned above, before the
    // section-count planning.
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
        &defined_tls_globals,
        &build.elf_tpoff_fixups,
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

    // Named sections (attribute placements + inline-asm payloads) at
    // the indices planned right after the fixed set (`carve.shndx`).
    // `SHT_NOBITS` entries keep their size but contribute no file
    // bytes.
    for (k, e) in carve.table.entries.iter().enumerate() {
        debug_assert_eq!(sh.len(), carve.shndx[k] as usize);
        let sec_off = round_up(out.len() as u64, e.align);
        out.resize(sec_off as usize, 0);
        if e.sh_type != SHT_NOBITS {
            out.extend_from_slice(&e.bytes);
        }
        sh.push(Elf64Shdr {
            sh_name: shstrtab_offs[named_names_start + k],
            sh_type: e.sh_type,
            sh_flags: e.flags,
            sh_offset: sec_off,
            sh_size: e.bytes.len() as u64,
            sh_addralign: e.align,
            ..Default::default()
        });
    }
    // Their `.rela` companions, only for entries carrying relocations.
    for (k, e) in carve.table.entries.iter().enumerate() {
        if e.relas.is_empty() {
            continue;
        }
        let mut rb: Vec<u8> = Vec::with_capacity(e.relas.len() * ELF64_RELA_SIZE);
        for r in &e.relas {
            let rela = Elf64Rela {
                r_offset: r.offset,
                r_info: (r.sym << 32) | r.rtype as u64,
                r_addend: r.addend,
            };
            write_struct(&mut rb, &rela);
        }
        let rela_off = round_up(out.len() as u64, 8);
        out.resize(rela_off as usize, 0);
        out.extend_from_slice(&rb);
        sh.push(Elf64Shdr {
            sh_name: shstrtab_offs[named_rela_names_start + named_rela_pos[k]],
            sh_type: SHT_RELA,
            sh_flags: SHF_INFO_LINK,
            sh_offset: rela_off,
            sh_size: rb.len() as u64,
            sh_link: SHIDX_SYMTAB as u32,
            sh_info: carve.shndx[k] as u32,
            sh_addralign: 8,
            sh_entsize: ELF64_RELA_SIZE as u64,
            ..Default::default()
        });
    }

    // `.init_array` / `.fini_array` groups. Each is a zero-filled array
    // of 8-byte pointers (the paired `.rela.*` binds each slot to its
    // function) followed immediately by that `.rela.*` section, whose
    // `sh_info` names the array it patches. Appended last so every
    // fixed and TLS section index is unchanged.
    for (k, s) in init_sections.iter().enumerate() {
        let array_shndx = sh.len() as u32;
        let arr_off = round_up(out.len() as u64, 8);
        out.resize(arr_off as usize, 0);
        out.resize(arr_off as usize + s.count * 8, 0);
        sh.push(Elf64Shdr {
            sh_name: shstrtab_offs[init_names_start + 2 * k],
            sh_type: s.sh_type,
            sh_flags: SHF_ALLOC | SHF_WRITE,
            sh_offset: arr_off,
            sh_size: (s.count * 8) as u64,
            sh_addralign: 8,
            sh_entsize: 8,
            ..Default::default()
        });
        let rela_off = round_up(out.len() as u64, 8);
        out.resize(rela_off as usize, 0);
        out.extend_from_slice(&s.rela);
        sh.push(Elf64Shdr {
            sh_name: shstrtab_offs[init_names_start + 2 * k + 1],
            sh_type: SHT_RELA,
            sh_flags: SHF_INFO_LINK,
            sh_offset: rela_off,
            sh_size: s.rela.len() as u64,
            sh_link: SHIDX_SYMTAB as u32,
            sh_info: array_shndx,
            sh_addralign: 8,
            sh_entsize: ELF64_RELA_SIZE as u64,
            ..Default::default()
        });
    }

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
    tls_symbols: &[(&str, i64, u64)],
    elf_tpoff_fixups: &[super::ElfTpoffFixup],
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
    if !imports.imports.is_empty() || !imports.data_bindings.is_empty() {
        let mut bm_desc: Vec<u8> = Vec::new();
        for imp in &imports.imports {
            let idx = imp.dylib_index as u32;
            bm_desc.extend_from_slice(&idx.to_le_bytes());
            bm_desc.extend_from_slice(imp.real_symbol.as_bytes());
            bm_desc.push(0);
        }
        // Data bindings route through the same map, keyed by the
        // local name: that is the UNDEF symbol the linker records as
        // the import when no unit defines the local (PE / Mach-O).
        // Without an entry the import falls back to dylib 0.
        for (local, _host, dylib_index) in &imports.data_bindings {
            let idx = *dylib_index as u32;
            bm_desc.extend_from_slice(&idx.to_le_bytes());
            bm_desc.extend_from_slice(local.as_bytes());
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

    // Record 8: defined `_Thread_local` symbols -- (tls_offset, size,
    // NUL name) per variable this unit defines.
    if !tls_symbols.is_empty() {
        let mut desc: Vec<u8> = Vec::new();
        for (sym_name, off, size) in tls_symbols {
            desc.extend_from_slice(&(*off as u64).to_le_bytes());
            desc.extend_from_slice(&size.to_le_bytes());
            desc.extend_from_slice(sym_name.as_bytes());
            desc.push(0);
        }
        out.extend_from_slice(&(name.len() as u32).to_le_bytes());
        out.extend_from_slice(&(desc.len() as u32).to_le_bytes());
        out.extend_from_slice(&NT_BADC_TLS_SYM.to_le_bytes());
        out.extend_from_slice(name);
        pad_to_4(&mut out);
        out.extend_from_slice(&desc);
        pad_to_4(&mut out);
    }

    // Record 9: Mach-O TLV descriptors keyed by a cross-unit symbol --
    // (descriptor_index, NUL name) per extern `_Thread_local` access.
    let tlv_desc_syms: Vec<(usize, &str)> = macho_tlv_descriptors
        .iter()
        .enumerate()
        .filter_map(|(i, d)| d.symbol.as_deref().map(|s| (i, s)))
        .collect();
    if !tlv_desc_syms.is_empty() {
        let mut desc: Vec<u8> = Vec::new();
        for (idx, sym_name) in &tlv_desc_syms {
            desc.extend_from_slice(&(*idx as u64).to_le_bytes());
            desc.extend_from_slice(sym_name.as_bytes());
            desc.push(0);
        }
        out.extend_from_slice(&(name.len() as u32).to_le_bytes());
        out.extend_from_slice(&(desc.len() as u32).to_le_bytes());
        out.extend_from_slice(&NT_BADC_MACHO_TLV_DESC_SYM.to_le_bytes());
        out.extend_from_slice(name);
        pad_to_4(&mut out);
        out.extend_from_slice(&desc);
        pad_to_4(&mut out);
    }

    // Record 10: Linux/x86_64 TLS access fixups -- (imm_offset, kind,
    // local_offset | NUL name) per `Inst::TlsAddr` site.
    if !elf_tpoff_fixups.is_empty() {
        let mut desc: Vec<u8> = Vec::new();
        for f in elf_tpoff_fixups {
            desc.extend_from_slice(&(f.imm_offset as u64).to_le_bytes());
            match &f.target {
                super::ElfTpoffTarget::Local(off) => {
                    desc.push(0);
                    desc.extend_from_slice(&off.to_le_bytes());
                }
                super::ElfTpoffTarget::Extern(sym_name) => {
                    desc.push(1);
                    desc.extend_from_slice(sym_name.as_bytes());
                    desc.push(0);
                }
            }
        }
        out.extend_from_slice(&(name.len() as u32).to_le_bytes());
        out.extend_from_slice(&(desc.len() as u32).to_le_bytes());
        out.extend_from_slice(&NT_BADC_ELF_TPOFF.to_le_bytes());
        out.extend_from_slice(name);
        pad_to_4(&mut out);
        out.extend_from_slice(&desc);
        pad_to_4(&mut out);
    }

    // Record 7: data-import copy relocations -- (local_name, host_symbol)
    // NUL-terminated string pairs from `#pragma binding(data ...)`.
    if !imports.data_bindings.is_empty() {
        let mut desc: Vec<u8> = Vec::new();
        for (local, host, _dylib_index) in &imports.data_bindings {
            desc.extend_from_slice(local.as_bytes());
            desc.push(0);
            desc.extend_from_slice(host.as_bytes());
            desc.push(0);
        }
        out.extend_from_slice(&(name.len() as u32).to_le_bytes());
        out.extend_from_slice(&(desc.len() as u32).to_le_bytes());
        out.extend_from_slice(&NT_BADC_COPY_RELOC.to_le_bytes());
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

/// Emit the GOT-indirect relocs for address-taking a dylib-routed import:
/// `R_AARCH64_ADR_GOT_PAGE` at the `adrp` and
/// `R_AARCH64_LD64_GOT_LO12_NC` at the paired `ldr` on aarch64;
/// `R_X86_64_REX_GOTPCRELX` at the disp32 of the rewritten `mov` on x86_64.
/// The direct-address instruction the codegen left is rewritten to the
/// GOT load by [`rewrite_extern_addr_loads_to_got`].
fn emit_got_ref_relocs(machine: Machine, out: &mut Vec<u8>, instr_offset: u64, sym_idx: u64) {
    match machine {
        Machine::Aarch64 => {
            let page = Elf64Rela {
                r_offset: instr_offset,
                r_info: (sym_idx << 32) | R_AARCH64_ADR_GOT_PAGE as u64,
                r_addend: 0,
            };
            let lo12 = Elf64Rela {
                r_offset: instr_offset + 4,
                r_info: (sym_idx << 32) | R_AARCH64_LD64_GOT_LO12_NC as u64,
                r_addend: 0,
            };
            write_struct(out, &page);
            write_struct(out, &lo12);
        }
        Machine::X86_64 => {
            // `REX mov reg, [rip + disp32]` (rewritten from the codegen's
            // `lea`): the disp32 sits after REX + opcode + modrm, and
            // resolves as `G + GOT + A - P` with the end-of-field `-4`.
            // The REX form is exactly what the relaxable marking covers.
            let rela = Elf64Rela {
                r_offset: instr_offset + 3,
                r_info: (sym_idx << 32) | R_X86_64_REX_GOTPCRELX as u64,
                r_addend: -4,
            };
            write_struct(out, &rela);
        }
    }
}

/// Rewrite each external-address materialization into the GOT-load form
/// (paired with the relocs from [`emit_got_ref_relocs`]): the `add` half
/// of an aarch64 `adrp + add` becomes `ldr`, and an x86_64 rip-relative
/// `lea` becomes `mov` (opcode 0x8d -> 0x8b, same REX/modrm/disp32).
/// Returns a copy of `.text` with the rewrites applied; the shared
/// `build.text` is untouched so the JIT / direct-image paths keep the
/// direct form.
fn rewrite_extern_addr_loads_to_got(
    machine: Machine,
    text: &[u8],
    instr_offsets: &[usize],
) -> alloc::vec::Vec<u8> {
    let mut body = text.to_vec();
    match machine {
        Machine::Aarch64 => {
            for &adrp_offset in instr_offsets {
                let off = adrp_offset + 4; // the `add` following the `adrp`
                if off + 4 > body.len() {
                    continue;
                }
                let add =
                    u32::from_le_bytes([body[off], body[off + 1], body[off + 2], body[off + 3]]);
                let rd = add & 0x1f;
                let rn = (add >> 5) & 0x1f;
                // `ldr Xrd, [Xrn, #0]` (0xF9400000 | Rn<<5 | Rt); the
                // :got_lo12: reloc fills the scaled imm12.
                let ldr = 0xF940_0000u32 | (rn << 5) | rd;
                body[off..off + 4].copy_from_slice(&ldr.to_le_bytes());
            }
        }
        Machine::X86_64 => {
            for &lea_offset in instr_offsets {
                let op = lea_offset + 1; // REX prefix, then the opcode byte
                if op < body.len() && body[op] == 0x8d {
                    body[op] = 0x8b;
                }
            }
        }
    }
    body
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
            data_object_starts: Vec::new(),
            entry_pc: 0,
            warnings: Vec::new(),
            tls_data: Vec::new(),
            tls_init_size: 0,
            data_relocs: Vec::new(),
            extern_data_relocs: Vec::new(),
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
            entry_pragma: None,
            auto_includes: Vec::new(),
            data_align: 8,
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

    fn empty_build_for(_machine: Machine) -> Build {
        use super::super::{Abi, OutputKind, ResolvedImports};
        Build {
            asm_sections: Vec::new(),
            copy_relocs: Default::default(),
            text: Vec::new(),
            data: Vec::new(),
            data_align: 8,
            bss_size: 0,
            init_fini_arrays: Default::default(),
            entry_offset: 0,
            got_fixups: Vec::new(),
            data_fixups: Vec::new(),
            func_fixups: Vec::new(),
            pc_to_native: Vec::new(),
            func_ent_pcs: Vec::new(),
            func_names: Vec::new(),
            func_prologue_native: alloc::collections::BTreeMap::new(),
            promoted_local_slots: alloc::collections::BTreeMap::new(),
            coalesced_slot_remap: alloc::collections::BTreeMap::new(),
            fn_unwind: Vec::new(),
            reloc_call_sites: Vec::new(),
            user_extern_call_sites: Vec::new(),
            user_extern_data_refs: Vec::new(),
            ssa_line_rows: Vec::new(),
            imports: ResolvedImports::default(),
            abi: Abi::default(),
            tls_data: Vec::new(),
            tls_init_size: 0,
            tls_index_fixups: Vec::new(),
            elf_tpoff_fixups: Vec::new(),
            data_relocs: Vec::new(),
            extern_data_relocs: Vec::new(),
            code_relocs: Vec::new(),
            exports: Vec::new(),
            dynamic_exports: Vec::new(),
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
