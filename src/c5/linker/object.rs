//! ELF-wrapped c5 bytecode object file (`.o`) writer and reader.
//!
//! The wrapper is a real ELF64 file (`ET_REL`, no program
//! headers, section-table only) carrying the per-TU payload
//! split across badc-specific section types:
//!
//!   * `.badc.text`    -- `Vec<i64>` bytecode, little-endian,
//!                        8 bytes per word.
//!   * `.badc.data`    -- raw byte image of `LinkUnit::data`.
//!   * `.badc.tdata`   -- initialised TLS bytes (the leading
//!                        `tls_init_size` bytes of `tls_data`).
//!   * `.badc.tbss`    -- zero-fill TLS bytes (the remainder).
//!   * `.badc.meta`    -- bincode-free, length-prefixed
//!                        serialization of every other field
//!                        (dylibs, structs, exports, source-file
//!                        table, side-channels, ...).
//!   * `.symtab` + `.strtab` -- standard ELF symbol table over
//!                        the external-linkage names of the
//!                        unit. The `st_value` field is the
//!                        symbol's `LinkSymbol::value`; the
//!                        `st_shndx` picks which `.badc.*`
//!                        section the value indexes into.
//!   * `.rela.badc.text` / `.rela.badc.data` -- standard ELF
//!                        relocation tables over the unit's
//!                        `Reloc` list, one per target section.
//!
//! The "ELF as carrier" choice is for tooling: `readelf -h`,
//! `nm`, `objdump -t` all recognise the file, listing symbol
//! names and section headers without any badc-specific
//! plumbing. The section *contents* (bytecode, meta blob,
//! relocation kind bytes) are badc-private and require the
//! linker to interpret.

use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec;
use alloc::vec::Vec;

use crate::c5::error::C5Error;

use super::reloc::{Reloc, RelocKind};
use super::symbol::{LinkSymbol, SymbolKind};
use super::unit::LinkUnit;

/// On-disk magic + version inside `.badc.meta`. Independent of
/// the ELF wrapper -- a future version of the linker that reads
/// older files identifies the meta blob through this magic
/// rather than guessing from the ELF section name. Bumping the
/// version on a backward-incompatible meta change forces a clear
/// "linker too old / object file too new" error.
const META_MAGIC: &[u8; 8] = b"BADCMTA\0";
const META_VERSION: u32 = 1;

/// Sentinel placed by the writer right after the ELF header so
/// the reader can refuse a file that looks like an ELF object
/// but wasn't produced by badc. The bytes sit in
/// `e_ident[EI_OSABI]` + `e_ident[EI_ABIVERSION]`; choosing a
/// non-zero value isolates badc objects from other ELF objects
/// the user might accidentally pass on the command line.
const ELFOSABI_BADC: u8 = 0x42; // 'B'
const ELFABIVERSION_BADC: u8 = 0x01;

/// `e_type` for an ELF object file (relocatable).
const ET_REL: u16 = 1;
/// `e_machine = EM_NONE` -- the bytecode is target-independent
/// so we record no machine type. Tools that key on
/// `e_machine` will see `0` and treat it as "unknown
/// architecture", which is exactly right.
const EM_NONE: u16 = 0;

const ELF_CLASS_64: u8 = 2;
const ELF_DATA_LSB: u8 = 1;
const ELF_VERSION_CURRENT: u8 = 1;

const SHT_NULL: u32 = 0;
const SHT_PROGBITS: u32 = 1;
const SHT_SYMTAB: u32 = 2;
const SHT_STRTAB: u32 = 3;
const SHT_RELA: u32 = 4;
const SHT_NOBITS: u32 = 8;

const SHF_WRITE: u64 = 0x1;
const SHF_ALLOC: u64 = 0x2;
const SHF_EXECINSTR: u64 = 0x4;
const SHF_TLS: u64 = 0x400;
const SHF_INFO_LINK: u64 = 0x40;

const STB_LOCAL: u8 = 0;
const STB_GLOBAL: u8 = 1;
const STT_NOTYPE: u8 = 0;
const STT_OBJECT: u8 = 1;
const STT_FUNC: u8 = 2;
const SHN_UNDEF: u16 = 0;

// ------------------------------------------------------------------
// On-disk shapes. Mirror the same `#[repr(C)]` + `write_struct`
// approach the native ELF emitter in `c5/codegen/elf.rs` uses:
// little-endian fields packed at C-ABI offsets, so a single memcpy
// produces the correct wire bytes. Const-time size asserts catch
// any future field-width drift before we ship malformed objects.
// ------------------------------------------------------------------

const ELF64_EHDR_SIZE: usize = 64;
const ELF64_SHDR_SIZE: usize = 64;
const ELF64_SYM_SIZE: usize = 24;
const ELF64_RELA_SIZE: usize = 24;

/// Elf64_Ehdr -- the file header at offset 0.
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

/// Elf64_Shdr -- one entry in the section header table.
#[repr(C)]
#[derive(Copy, Clone)]
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

/// Elf64_Sym -- one entry in `.symtab`.
#[repr(C)]
#[derive(Copy, Clone)]
struct Elf64Sym {
    st_name: u32,
    st_info: u8,
    st_other: u8,
    st_shndx: u16,
    st_value: u64,
    st_size: u64,
}

const _: () = assert!(core::mem::size_of::<Elf64Sym>() == ELF64_SYM_SIZE);

/// Elf64_Rela -- one entry in `.rela.*`.
#[repr(C)]
#[derive(Copy, Clone)]
struct Elf64Rela {
    r_offset: u64,
    r_info: u64,
    r_addend: i64,
}

const _: () = assert!(core::mem::size_of::<Elf64Rela>() == ELF64_RELA_SIZE);

/// Append a `#[repr(C)]` struct's raw bytes to `out`. Same shape
/// the native ELF / PE writers use; we are little-endian on every
/// supported host so a memcpy hits the right wire format.
fn write_struct<T: Copy>(out: &mut Vec<u8>, value: &T) {
    const _: () = assert!(
        cfg!(target_endian = "little"),
        "object writer assumes a little-endian host"
    );
    let bytes = unsafe {
        core::slice::from_raw_parts((value as *const T) as *const u8, core::mem::size_of::<T>())
    };
    out.extend_from_slice(bytes);
}

/// Section indices we emit. Order is fixed so the symbol table's
/// `st_shndx` values can be set without a second pass.
const SHIDX_NULL: u16 = 0;
const SHIDX_TEXT: u16 = 1;
const SHIDX_DATA: u16 = 2;
const SHIDX_TDATA: u16 = 3;
const SHIDX_TBSS: u16 = 4;
const SHIDX_META: u16 = 5;
const SHIDX_RELA_TEXT: u16 = 6;
const SHIDX_RELA_DATA: u16 = 7;
const SHIDX_SYMTAB: u16 = 8;
const SHIDX_STRTAB: u16 = 9;
const SHIDX_SHSTRTAB: u16 = 10;
const NUM_SECTIONS: usize = 11;

/// Write `unit` as a `.o` file image. Returns the raw bytes; the
/// caller is responsible for writing them to disk or piping to
/// stdout.
pub fn write_object(unit: &LinkUnit) -> Vec<u8> {
    let mut w = Writer::new();
    w.encode(unit);
    w.finish()
}

/// Parse `bytes` as a c5 object file. Returns a `LinkUnit`
/// equivalent to whatever the writer produced; the round-trip is
/// byte-for-byte stable modulo padding bytes the writer inserts
/// for section alignment.
pub fn read_object(bytes: &[u8]) -> Result<LinkUnit, C5Error> {
    Reader::new(bytes).decode()
}

// ---- Writer ----

struct Writer {
    out: Vec<u8>,
}

impl Writer {
    fn new() -> Self {
        Self { out: Vec::new() }
    }

    fn finish(self) -> Vec<u8> {
        self.out
    }

    fn encode(&mut self, unit: &LinkUnit) {
        // ELF64 header is fixed-size and lives at offset 0; we
        // reserve the slot here and patch its `e_shoff` field once
        // the section data is laid out.
        let ehdr_off = self.out.len();
        self.out.resize(ehdr_off + ELF64_EHDR_SIZE, 0);

        // Section data is concatenated immediately after the
        // header; each section is 8-byte aligned for clean
        // viewing in `readelf -x`. We record (offset, size) per
        // section index so the section header table can be
        // emitted last with absolute file offsets.
        let mut sections: [(u64, u64); NUM_SECTIONS] = [(0, 0); NUM_SECTIONS];

        // .text: i64 words, little-endian.
        self.align_to(8);
        let text_off = self.out.len();
        for w in &unit.text {
            self.out.extend_from_slice(&w.to_le_bytes());
        }
        sections[SHIDX_TEXT as usize] = (text_off as u64, (self.out.len() - text_off) as u64);

        // .data: raw bytes.
        self.align_to(8);
        let data_off = self.out.len();
        self.out.extend_from_slice(&unit.data);
        sections[SHIDX_DATA as usize] = (data_off as u64, (self.out.len() - data_off) as u64);

        // .tdata: initialised TLS prefix.
        self.align_to(8);
        let tdata_off = self.out.len();
        let init = unit.tls_init_size.min(unit.tls_data.len());
        self.out.extend_from_slice(&unit.tls_data[..init]);
        sections[SHIDX_TDATA as usize] = (tdata_off as u64, (self.out.len() - tdata_off) as u64);

        // .tbss: zero-fill remainder. SHT_NOBITS so the bytes
        // don't occupy the file; we still record the logical
        // size for the consumer.
        let tbss_size = unit.tls_data.len().saturating_sub(init) as u64;
        // SHT_NOBITS sections set sh_offset to the current
        // file position (per ELF spec, the offset is where the
        // section *would* start) but contribute zero bytes.
        let tbss_off = self.out.len() as u64;
        sections[SHIDX_TBSS as usize] = (tbss_off, tbss_size);

        // .meta: the catch-all metadata blob.
        self.align_to(8);
        let meta_off = self.out.len();
        let meta = encode_meta(unit);
        self.out.extend_from_slice(&meta);
        sections[SHIDX_META as usize] = (meta_off as u64, (self.out.len() - meta_off) as u64);

        // .strtab + .symtab. Build the strtab first (every
        // symbol name needs an offset), then the symtab with
        // strtab-indexed st_name fields.
        let (strtab_bytes, symbol_str_offsets) = build_strtab(unit);
        // .symtab is emitted before .strtab so its sh_link can
        // reference SHIDX_STRTAB.

        // Relocations: split into text-targeting and data-targeting.
        let (rela_text, rela_data) = encode_relocs(unit);

        self.align_to(8);
        let rela_text_off = self.out.len();
        self.out.extend_from_slice(&rela_text);
        sections[SHIDX_RELA_TEXT as usize] = (
            rela_text_off as u64,
            (self.out.len() - rela_text_off) as u64,
        );

        self.align_to(8);
        let rela_data_off = self.out.len();
        self.out.extend_from_slice(&rela_data);
        sections[SHIDX_RELA_DATA as usize] = (
            rela_data_off as u64,
            (self.out.len() - rela_data_off) as u64,
        );

        // .symtab.
        let symtab = encode_symtab(unit, &symbol_str_offsets);
        self.align_to(8);
        let symtab_off = self.out.len();
        self.out.extend_from_slice(&symtab);
        sections[SHIDX_SYMTAB as usize] = (symtab_off as u64, (self.out.len() - symtab_off) as u64);

        // .strtab.
        self.align_to(1);
        let strtab_off = self.out.len();
        self.out.extend_from_slice(&strtab_bytes);
        sections[SHIDX_STRTAB as usize] = (strtab_off as u64, (self.out.len() - strtab_off) as u64);

        // .shstrtab.
        let (shstrtab_bytes, shstr_offsets) = build_shstrtab();
        self.align_to(1);
        let shstrtab_off = self.out.len();
        self.out.extend_from_slice(&shstrtab_bytes);
        sections[SHIDX_SHSTRTAB as usize] =
            (shstrtab_off as u64, (self.out.len() - shstrtab_off) as u64);

        // Section header table.
        self.align_to(8);
        let shoff = self.out.len() as u64;
        // First-local index in .symtab: count locals (STB_LOCAL).
        let symtab_first_global = symtab_first_global_index(unit);
        for shidx in 0..NUM_SECTIONS {
            let (offset, size) = sections[shidx];
            let (sh_type, sh_flags, sh_link, sh_info, sh_entsize, sh_addralign) =
                section_metadata(shidx as u16, symtab_first_global);
            let name_off = shstr_offsets[shidx];
            write_struct(
                &mut self.out,
                &Elf64Shdr {
                    sh_name: name_off as u32,
                    sh_type,
                    sh_flags,
                    sh_addr: 0, // sh_addr = 0 in a relocatable file
                    sh_offset: offset,
                    sh_size: size,
                    sh_link,
                    sh_info,
                    sh_addralign,
                    sh_entsize,
                },
            );
        }

        // Patch the ELF header now that everything is laid out.
        self.write_ehdr(ehdr_off, shoff);
    }

    fn align_to(&mut self, n: usize) {
        while !self.out.len().is_multiple_of(n) {
            self.out.push(0);
        }
    }

    fn write_ehdr(&mut self, ehdr_off: usize, shoff: u64) {
        let mut e_ident = [0u8; 16];
        e_ident[0..4].copy_from_slice(b"\x7fELF");
        e_ident[4] = ELF_CLASS_64;
        e_ident[5] = ELF_DATA_LSB;
        e_ident[6] = ELF_VERSION_CURRENT;
        e_ident[7] = ELFOSABI_BADC;
        e_ident[8] = ELFABIVERSION_BADC;
        // e_ident[9..16] left zero.
        let ehdr = Elf64Ehdr {
            e_ident,
            e_type: ET_REL,
            e_machine: EM_NONE,
            e_version: 1,
            e_entry: 0, // no entry point in a relocatable object
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
        // Write into the reserved slot we sized at encode() time.
        let bytes = unsafe {
            core::slice::from_raw_parts(
                (&ehdr as *const Elf64Ehdr) as *const u8,
                ELF64_EHDR_SIZE,
            )
        };
        self.out[ehdr_off..ehdr_off + ELF64_EHDR_SIZE].copy_from_slice(bytes);
    }
}

fn section_metadata(shidx: u16, symtab_first_global: u32) -> (u32, u64, u32, u32, u64, u64) {
    // (sh_type, sh_flags, sh_link, sh_info, sh_entsize, sh_addralign)
    match shidx {
        SHIDX_NULL => (SHT_NULL, 0, 0, 0, 0, 0),
        SHIDX_TEXT => (SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 0, 0, 0, 8),
        SHIDX_DATA => (SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 0, 0, 0, 8),
        SHIDX_TDATA => (SHT_PROGBITS, SHF_ALLOC | SHF_WRITE | SHF_TLS, 0, 0, 0, 8),
        SHIDX_TBSS => (SHT_NOBITS, SHF_ALLOC | SHF_WRITE | SHF_TLS, 0, 0, 0, 8),
        SHIDX_META => (SHT_PROGBITS, 0, 0, 0, 0, 8),
        SHIDX_RELA_TEXT => (
            SHT_RELA,
            SHF_INFO_LINK,
            SHIDX_SYMTAB as u32,
            SHIDX_TEXT as u32,
            24,
            8,
        ),
        SHIDX_RELA_DATA => (
            SHT_RELA,
            SHF_INFO_LINK,
            SHIDX_SYMTAB as u32,
            SHIDX_DATA as u32,
            24,
            8,
        ),
        SHIDX_SYMTAB => (
            SHT_SYMTAB,
            0,
            SHIDX_STRTAB as u32,
            symtab_first_global,
            24,
            8,
        ),
        SHIDX_STRTAB => (SHT_STRTAB, 0, 0, 0, 0, 1),
        SHIDX_SHSTRTAB => (SHT_STRTAB, 0, 0, 0, 0, 1),
        _ => (0, 0, 0, 0, 0, 0),
    }
}

fn symtab_first_global_index(unit: &LinkUnit) -> u32 {
    // First entry is the standard ELF zero / undefined symbol;
    // then come every internal-linkage symbol; then the
    // externals. ELF requires `sh_info` for the symtab to name
    // the first non-local index.
    let mut locals = 1; // the leading null symbol
    for s in &unit.symbols {
        if matches!(s.linkage, crate::c5::symbol::Linkage::Internal) {
            locals += 1;
        }
    }
    locals
}

fn encode_symtab(unit: &LinkUnit, name_offsets: &[u32]) -> Vec<u8> {
    // Symbols are split: null sentinel + locals (internal
    // linkage) + globals (external linkage, defined + undefined
    // intermixed -- ELF doesn't distinguish externs from defined
    // globals by binding, only by `st_shndx == SHN_UNDEF`).
    let mut out = Vec::new();
    // Null sentinel.
    write_struct(
        &mut out,
        &Elf64Sym {
            st_name: 0,
            st_info: 0,
            st_other: 0,
            st_shndx: 0,
            st_value: 0,
            st_size: 0,
        },
    );
    let mut writer_order: Vec<usize> = (0..unit.symbols.len()).collect();
    writer_order.sort_by_key(|&i| match unit.symbols[i].linkage {
        crate::c5::symbol::Linkage::Internal => 0,
        _ => 1,
    });
    for &i in &writer_order {
        let s = &unit.symbols[i];
        let st_info = (binding_of(s) << 4) | (st_type_of(s) & 0xf);
        let st_shndx: u16 = match s.kind {
            SymbolKind::Function => SHIDX_TEXT,
            SymbolKind::Data => SHIDX_DATA,
            SymbolKind::TlsData => SHIDX_TDATA,
            SymbolKind::Undefined => SHN_UNDEF,
        };
        // For Function symbols, `value` is a bytecode word
        // index; convert to a byte offset so a debugger /
        // tooling that mistakes the section for raw bytes sees
        // a sensible "address". The linker reads the original
        // bytecode index back out by dividing by 8.
        let st_value: u64 = match s.kind {
            SymbolKind::Function => s.value.saturating_mul(8),
            _ => s.value,
        };
        write_struct(
            &mut out,
            &Elf64Sym {
                st_name: name_offsets[i],
                st_info,
                st_other: 0,
                st_shndx,
                st_value,
                st_size: s.size,
            },
        );
    }
    out
}

fn binding_of(s: &LinkSymbol) -> u8 {
    match s.linkage {
        crate::c5::symbol::Linkage::Internal => STB_LOCAL,
        crate::c5::symbol::Linkage::External => STB_GLOBAL,
        crate::c5::symbol::Linkage::None => STB_LOCAL,
    }
}

fn st_type_of(s: &LinkSymbol) -> u8 {
    match s.kind {
        SymbolKind::Function => STT_FUNC,
        SymbolKind::Data | SymbolKind::TlsData => STT_OBJECT,
        SymbolKind::Undefined => STT_NOTYPE,
    }
}

fn build_strtab(unit: &LinkUnit) -> (Vec<u8>, Vec<u32>) {
    // Empty leading byte is the canonical "no name" entry; every
    // real name follows NUL-terminated. Offsets are 1-based for
    // real names, 0 means "unnamed".
    let mut bytes: Vec<u8> = vec![0];
    let mut offsets = Vec::with_capacity(unit.symbols.len());
    for s in &unit.symbols {
        if s.name.is_empty() {
            offsets.push(0);
            continue;
        }
        let off = bytes.len() as u32;
        bytes.extend_from_slice(s.name.as_bytes());
        bytes.push(0);
        offsets.push(off);
    }
    (bytes, offsets)
}

fn build_shstrtab() -> (Vec<u8>, [usize; NUM_SECTIONS]) {
    let names = [
        "", // SHIDX_NULL
        ".badc.text",
        ".badc.data",
        ".badc.tdata",
        ".badc.tbss",
        ".badc.meta",
        ".rela.badc.text",
        ".rela.badc.data",
        ".symtab",
        ".strtab",
        ".shstrtab",
    ];
    let mut bytes = Vec::new();
    let mut offsets = [0usize; NUM_SECTIONS];
    for (i, n) in names.iter().enumerate() {
        offsets[i] = bytes.len();
        bytes.extend_from_slice(n.as_bytes());
        bytes.push(0);
    }
    (bytes, offsets)
}

fn encode_relocs(unit: &LinkUnit) -> (Vec<u8>, Vec<u8>) {
    // Elf64_Rela: r_offset u64, r_info u64, r_addend i64.
    // We encode the badc reloc kind in the low 8 bits of r_info
    // and the symbol index in the high 24+32 bits (ELF spec:
    // ELF64_R_INFO(sym, type) = (sym << 32) | type).
    //
    // The ELF symtab is sorted by binding (locals first, then
    // globals) per the spec, so an `r.sym_index` that names a
    // unit-table position has to be translated to the
    // post-sort .symtab position before going onto disk.
    // Without the remap, a global reloc lands on whatever
    // local happens to share the source position, miscoloring
    // the cross-TU resolution at read time.
    let elf_sym_index = build_elf_sym_index_map(unit);

    let mut rt = Vec::new();
    let mut rd = Vec::new();
    // Stable ordering by location keeps the output deterministic
    // and gives the reader a clean "scan in order" loop.
    let mut sorted: Vec<&Reloc> = unit.relocs.iter().collect();
    sorted.sort_by_key(|r| (r.kind.as_u8(), r.location));
    for r in sorted {
        let r_offset: u64 = match r.kind {
            RelocKind::JsrPc | RelocKind::ImmCodeAddr | RelocKind::ImmDataAddr => {
                // text relocations: r_offset = byte offset of the
                // operand i64 within .badc.text.
                r.location * 8
            }
            RelocKind::DataDataAbs64 | RelocKind::DataCodeAbs64 => r.location,
        };
        let elf_idx = elf_sym_index
            .get(r.sym_index as usize)
            .copied()
            .unwrap_or(0);
        let r_info: u64 = ((elf_idx as u64) << 32) | (r.kind.as_u8() as u64);
        let rela = Elf64Rela {
            r_offset,
            r_info,
            r_addend: r.addend,
        };
        let target = match r.kind {
            RelocKind::JsrPc | RelocKind::ImmCodeAddr | RelocKind::ImmDataAddr => &mut rt,
            RelocKind::DataDataAbs64 | RelocKind::DataCodeAbs64 => &mut rd,
        };
        write_struct(target, &rela);
    }
    (rt, rd)
}

/// For each unit-table symbol index, return the matching ELF
/// symtab index (1-based, accounting for the null sentinel at
/// position 0). Mirrors the sort `encode_symtab` performs, so
/// both halves agree on every symbol's on-disk position.
fn build_elf_sym_index_map(unit: &LinkUnit) -> Vec<u32> {
    let mut writer_order: Vec<usize> = (0..unit.symbols.len()).collect();
    writer_order.sort_by_key(|&i| match unit.symbols[i].linkage {
        crate::c5::symbol::Linkage::Internal => 0,
        _ => 1,
    });
    let mut map = alloc::vec![0u32; unit.symbols.len()];
    for (pos, &orig) in writer_order.iter().enumerate() {
        // +1 to skip the null sentinel at ELF symtab index 0.
        map[orig] = (pos + 1) as u32;
    }
    map
}

// ---- Meta blob encoder / decoder ----
//
// The blob is a sequence of length-prefixed sub-records. Each
// record is identified by a one-byte tag; unknown tags are
// skipped by the reader so a forward-compatible writer can add
// new metadata without breaking older readers. The encoding is
// little-endian throughout. Strings are u32-length + raw bytes.

const TAG_END: u8 = 0;
const TAG_TLS_INIT_SIZE: u8 = 1;
const TAG_DATA_IMM_POSITIONS: u8 = 2;
const TAG_CODE_IMM_POSITIONS: u8 = 3;
const TAG_CALL_FP_ARG_MASKS: u8 = 4;
const TAG_SOURCE_LINES: u8 = 5;
const TAG_SOURCE_FUNCTIONS: u8 = 6;
const TAG_SOURCE_FILES: u8 = 7;
const TAG_SOURCE_FILE_INDICES: u8 = 8;
const TAG_VARIABLES: u8 = 9;
const TAG_DATA_RELOCS: u8 = 10;
const TAG_CODE_RELOCS: u8 = 11;
const TAG_DYLIBS: u8 = 12;
const TAG_STRUCTS: u8 = 13;
const TAG_EXPORTS: u8 = 14;
const TAG_DLLMAIN_PC: u8 = 15;
const TAG_ENTRY_NAME: u8 = 16;
const TAG_SUBSYSTEM: u8 = 17;
const TAG_SOURCE_PATH: u8 = 18;
const TAG_WARNINGS: u8 = 19;

fn encode_meta(unit: &LinkUnit) -> Vec<u8> {
    let mut buf = Vec::new();
    buf.extend_from_slice(META_MAGIC);
    buf.extend_from_slice(&META_VERSION.to_le_bytes());

    write_tag_u64(&mut buf, TAG_TLS_INIT_SIZE, unit.tls_init_size as u64);

    write_tag_vec_u64(
        &mut buf,
        TAG_DATA_IMM_POSITIONS,
        unit.data_imm_positions.iter().map(|&v| v as u64),
        unit.data_imm_positions.len(),
    );
    write_tag_vec_u64(
        &mut buf,
        TAG_CODE_IMM_POSITIONS,
        unit.code_imm_positions.iter().map(|&v| v as u64),
        unit.code_imm_positions.len(),
    );
    {
        let len = unit.call_fp_arg_masks.len();
        let body_len = 4 + (len * 12) as u32;
        write_tag_header(&mut buf, TAG_CALL_FP_ARG_MASKS, body_len);
        write_u32(&mut buf, len as u32);
        for &(pc, mask) in &unit.call_fp_arg_masks {
            write_u64(&mut buf, pc as u64);
            write_u32(&mut buf, mask);
        }
    }
    write_tag_vec_u32(&mut buf, TAG_SOURCE_LINES, &unit.source_lines);

    {
        let body_len = u32_string_vec_len(&unit.source_functions);
        write_tag_header(&mut buf, TAG_SOURCE_FUNCTIONS, body_len);
        write_string_vec(&mut buf, &unit.source_functions);
    }
    {
        let body_len = u32_string_vec_len(&unit.source_files);
        write_tag_header(&mut buf, TAG_SOURCE_FILES, body_len);
        write_string_vec(&mut buf, &unit.source_files);
    }
    write_tag_vec_u16(&mut buf, TAG_SOURCE_FILE_INDICES, &unit.source_file_indices);
    {
        let body_len = variables_vec_len(&unit.variables);
        write_tag_header(&mut buf, TAG_VARIABLES, body_len);
        write_u32(&mut buf, unit.variables.len() as u32);
        for v in &unit.variables {
            write_u64(&mut buf, v.function_bc_pc);
            write_string(&mut buf, &v.name);
            write_i64(&mut buf, v.type_tag);
            write_i64(&mut buf, v.fp_slot);
            buf.push(if v.is_parameter { 1 } else { 0 });
        }
    }
    {
        let body_len = 4 + (unit.data_relocs.len() * 16) as u32;
        write_tag_header(&mut buf, TAG_DATA_RELOCS, body_len);
        write_u32(&mut buf, unit.data_relocs.len() as u32);
        for r in &unit.data_relocs {
            write_u64(&mut buf, r.data_offset);
            write_u64(&mut buf, r.target_offset);
        }
    }
    {
        let body_len = 4 + (unit.code_relocs.len() * 16) as u32;
        write_tag_header(&mut buf, TAG_CODE_RELOCS, body_len);
        write_u32(&mut buf, unit.code_relocs.len() as u32);
        for r in &unit.code_relocs {
            write_u64(&mut buf, r.data_offset);
            write_u64(&mut buf, r.target_bc_pc);
        }
    }
    {
        let body_len = dylibs_len(&unit.dylibs);
        write_tag_header(&mut buf, TAG_DYLIBS, body_len);
        write_u32(&mut buf, unit.dylibs.len() as u32);
        for d in &unit.dylibs {
            write_string(&mut buf, &d.name);
            write_string(&mut buf, &d.path);
            write_u32(&mut buf, d.bindings.len() as u32);
            for b in &d.bindings {
                buf.push(if b.is_variadic { 1 } else { 0 });
                write_u32(&mut buf, b.fixed_args as u32);
                write_i64(&mut buf, b.return_type_tag);
                write_u32(&mut buf, b.param_types.len() as u32);
                for &p in &b.param_types {
                    write_i64(&mut buf, p);
                }
                write_string(&mut buf, &b.local_name);
                write_string(&mut buf, &b.real_symbol);
            }
        }
    }
    {
        let body_len = structs_len(&unit.structs);
        write_tag_header(&mut buf, TAG_STRUCTS, body_len);
        write_u32(&mut buf, unit.structs.len() as u32);
        for s in &unit.structs {
            write_string(&mut buf, &s.name);
            write_u64(&mut buf, s.size as u64);
            write_u64(&mut buf, s.align as u64);
            buf.push(if s.is_union { 1 } else { 0 });
            write_u32(&mut buf, s.fields.len() as u32);
            for f in &s.fields {
                write_string(&mut buf, &f.name);
                write_u64(&mut buf, f.offset as u64);
                write_i64(&mut buf, f.ty);
                write_i64(&mut buf, f.array_size);
                write_i64(&mut buf, f.inner_array_size);
                write_u32(&mut buf, f.array_dims.len() as u32);
                for &d in &f.array_dims {
                    write_i64(&mut buf, d);
                }
                write_u32(&mut buf, f.bit_offset);
                write_u32(&mut buf, f.bit_width);
            }
        }
    }
    {
        let body_len = exports_len(&unit.exports);
        write_tag_header(&mut buf, TAG_EXPORTS, body_len);
        write_u32(&mut buf, unit.exports.len() as u32);
        for e in &unit.exports {
            write_string(&mut buf, &e.name);
            write_u64(&mut buf, e.bytecode_pc as u64);
        }
    }
    {
        let val = unit.dllmain_pc.unwrap_or(u64::MAX as usize) as u64;
        write_tag_u64(&mut buf, TAG_DLLMAIN_PC, val);
    }
    {
        let s = unit.entry_name.as_deref().unwrap_or("");
        let body_len = 4 + s.len() as u32;
        write_tag_header(&mut buf, TAG_ENTRY_NAME, body_len);
        write_string(&mut buf, s);
    }
    {
        let v = subsystem_to_u8(unit.subsystem);
        write_tag_header(&mut buf, TAG_SUBSYSTEM, 1);
        buf.push(v);
    }
    {
        let body_len = 4 + unit.source_path.len() as u32;
        write_tag_header(&mut buf, TAG_SOURCE_PATH, body_len);
        write_string(&mut buf, &unit.source_path);
    }
    {
        let body_len = u32_string_vec_len(&unit.warnings);
        write_tag_header(&mut buf, TAG_WARNINGS, body_len);
        write_string_vec(&mut buf, &unit.warnings);
    }

    write_tag_header(&mut buf, TAG_END, 0);
    buf
}

fn subsystem_to_u8(s: Option<crate::c5::preprocessor::Subsystem>) -> u8 {
    use crate::c5::preprocessor::Subsystem;
    match s {
        None => 0,
        Some(Subsystem::Console) => 1,
        Some(Subsystem::Windows) => 2,
        Some(Subsystem::Native) => 3,
        Some(Subsystem::EfiApplication) => 4,
        Some(Subsystem::EfiBootServiceDriver) => 5,
        Some(Subsystem::EfiRuntimeDriver) => 6,
        Some(Subsystem::EfiRom) => 7,
    }
}

fn subsystem_from_u8(v: u8) -> Option<crate::c5::preprocessor::Subsystem> {
    use crate::c5::preprocessor::Subsystem;
    match v {
        1 => Some(Subsystem::Console),
        2 => Some(Subsystem::Windows),
        3 => Some(Subsystem::Native),
        4 => Some(Subsystem::EfiApplication),
        5 => Some(Subsystem::EfiBootServiceDriver),
        6 => Some(Subsystem::EfiRuntimeDriver),
        7 => Some(Subsystem::EfiRom),
        _ => None,
    }
}

fn write_tag_header(buf: &mut Vec<u8>, tag: u8, body_len: u32) {
    buf.push(tag);
    buf.extend_from_slice(&body_len.to_le_bytes());
}

fn write_tag_u64(buf: &mut Vec<u8>, tag: u8, v: u64) {
    write_tag_header(buf, tag, 8);
    buf.extend_from_slice(&v.to_le_bytes());
}

fn write_tag_vec_u64(buf: &mut Vec<u8>, tag: u8, iter: impl IntoIterator<Item = u64>, len: usize) {
    let body_len = 4 + (len * 8) as u32;
    write_tag_header(buf, tag, body_len);
    write_u32(buf, len as u32);
    for v in iter {
        buf.extend_from_slice(&v.to_le_bytes());
    }
}

fn write_tag_vec_u32(buf: &mut Vec<u8>, tag: u8, src: &[u32]) {
    let body_len = 4 + (src.len() * 4) as u32;
    write_tag_header(buf, tag, body_len);
    write_u32(buf, src.len() as u32);
    for &v in src {
        buf.extend_from_slice(&v.to_le_bytes());
    }
}

fn write_tag_vec_u16(buf: &mut Vec<u8>, tag: u8, src: &[u16]) {
    let body_len = 4 + (src.len() * 2) as u32;
    write_tag_header(buf, tag, body_len);
    write_u32(buf, src.len() as u32);
    for &v in src {
        buf.extend_from_slice(&v.to_le_bytes());
    }
}

fn u32_string_vec_len(v: &[String]) -> u32 {
    let mut total: u32 = 4;
    for s in v {
        total += 4 + s.len() as u32;
    }
    total
}
fn write_string_vec(buf: &mut Vec<u8>, v: &[String]) {
    write_u32(buf, v.len() as u32);
    for s in v {
        write_string(buf, s);
    }
}

fn variables_vec_len(vs: &[crate::c5::program::VariableInfo]) -> u32 {
    let mut total: u32 = 4;
    for v in vs {
        total += 8;
        total += 4 + v.name.len() as u32;
        total += 8 + 8 + 1;
    }
    total
}

fn dylibs_len(ds: &[crate::c5::preprocessor::DylibSpec]) -> u32 {
    let mut total: u32 = 4;
    for d in ds {
        total += 4 + d.name.len() as u32;
        total += 4 + d.path.len() as u32;
        total += 4; // binding count
        for b in &d.bindings {
            total += 1; // is_variadic
            total += 4; // fixed_args
            total += 8; // return_type_tag
            total += 4 + b.param_types.len() as u32 * 8;
            total += 4 + b.local_name.len() as u32;
            total += 4 + b.real_symbol.len() as u32;
        }
    }
    total
}

fn structs_len(ss: &[crate::c5::compiler::StructDef]) -> u32 {
    let mut total: u32 = 4;
    for s in ss {
        total += 4 + s.name.len() as u32;
        total += 8 + 8 + 1 + 4;
        for f in &s.fields {
            total += 4 + f.name.len() as u32;
            total += 8 + 8 + 8 + 8;
            total += 4 + f.array_dims.len() as u32 * 8;
            total += 4 + 4;
        }
    }
    total
}

fn exports_len(es: &[crate::c5::program::ExportedFunction]) -> u32 {
    let mut total: u32 = 4;
    for e in es {
        total += 4 + e.name.len() as u32;
        total += 8;
    }
    total
}

fn write_u32(buf: &mut Vec<u8>, v: u32) {
    buf.extend_from_slice(&v.to_le_bytes());
}

fn write_u64(buf: &mut Vec<u8>, v: u64) {
    buf.extend_from_slice(&v.to_le_bytes());
}

fn write_i64(buf: &mut Vec<u8>, v: i64) {
    buf.extend_from_slice(&v.to_le_bytes());
}

fn write_string(buf: &mut Vec<u8>, s: &str) {
    write_u32(buf, s.len() as u32);
    buf.extend_from_slice(s.as_bytes());
}

// ---- Reader ----

struct Reader<'a> {
    bytes: &'a [u8],
}

impl<'a> Reader<'a> {
    fn new(bytes: &'a [u8]) -> Self {
        Self { bytes }
    }

    fn decode(self) -> Result<LinkUnit, C5Error> {
        let bytes = self.bytes;
        if bytes.len() < 64 {
            return Err(err("input too short for an ELF64 header"));
        }
        if &bytes[0..4] != b"\x7fELF" {
            return Err(err("missing ELF magic"));
        }
        if bytes[4] != ELF_CLASS_64 || bytes[5] != ELF_DATA_LSB {
            return Err(err("not a little-endian ELF64 object"));
        }
        if bytes[7] != ELFOSABI_BADC || bytes[8] != ELFABIVERSION_BADC {
            return Err(err(
                "not a badc-produced object file (EI_OSABI / EI_ABIVERSION mismatch)",
            ));
        }
        let e_type = u16_at(bytes, 16);
        if e_type != ET_REL {
            return Err(err("ELF e_type != ET_REL"));
        }
        let e_shoff = u64_at(bytes, 40) as usize;
        let e_shnum = u16_at(bytes, 60) as usize;
        let e_shstrndx = u16_at(bytes, 62) as usize;
        if e_shnum != NUM_SECTIONS {
            return Err(err(&format!(
                "expected {} sections, got {}",
                NUM_SECTIONS, e_shnum
            )));
        }
        if e_shstrndx >= e_shnum {
            return Err(err("e_shstrndx out of range"));
        }
        // Decode the section headers as ShdrView records --
        // sh_offset and sh_size feed the per-section slice
        // lookups; the rest is captured for forward-looking
        // validation (and so a `readelf`-like consumer that
        // wants to introspect the file can do so without
        // re-parsing).
        for i in 0..NUM_SECTIONS {
            let off = e_shoff + i * 64;
            if off + 64 > bytes.len() {
                return Err(err("section header table truncated"));
            }
        }
        let sec = |i: usize| {
            let off = e_shoff + i * 64;
            ShdrView {
                sh_name: u32_at(bytes, off),
                sh_type: u32_at(bytes, off + 4),
                sh_flags: u64_at(bytes, off + 8),
                sh_offset: u64_at(bytes, off + 24),
                sh_size: u64_at(bytes, off + 32),
                sh_link: u32_at(bytes, off + 40),
                sh_info: u32_at(bytes, off + 44),
            }
        };

        let mut unit = LinkUnit::default();

        let text = sec(SHIDX_TEXT as usize);
        let data = sec(SHIDX_DATA as usize);
        let tdata = sec(SHIDX_TDATA as usize);
        let tbss = sec(SHIDX_TBSS as usize);
        let meta = sec(SHIDX_META as usize);
        let rela_text = sec(SHIDX_RELA_TEXT as usize);
        let rela_data = sec(SHIDX_RELA_DATA as usize);
        let symtab = sec(SHIDX_SYMTAB as usize);
        let strtab = sec(SHIDX_STRTAB as usize);

        // .text
        if text.sh_size % 8 != 0 {
            return Err(err(".badc.text size is not a multiple of 8"));
        }
        let text_bytes = slice_of(
            bytes,
            text.sh_offset as usize,
            text.sh_size as usize,
            ".badc.text",
        )?;
        let mut text_words = Vec::with_capacity(text_bytes.len() / 8);
        for chunk in text_bytes.chunks_exact(8) {
            text_words.push(i64::from_le_bytes(chunk.try_into().unwrap()));
        }
        unit.text = text_words;

        // .data
        unit.data = slice_of(
            bytes,
            data.sh_offset as usize,
            data.sh_size as usize,
            ".badc.data",
        )?
        .to_vec();

        // .tdata + .tbss -> tls_data
        let tdata_bytes = slice_of(
            bytes,
            tdata.sh_offset as usize,
            tdata.sh_size as usize,
            ".badc.tdata",
        )?;
        let mut tls = tdata_bytes.to_vec();
        let tls_init_size = tdata_bytes.len();
        tls.extend(core::iter::repeat_n(0u8, tbss.sh_size as usize));
        unit.tls_data = tls;
        unit.tls_init_size = tls_init_size; // overridden by meta if present.

        // .meta
        let meta_bytes = slice_of(
            bytes,
            meta.sh_offset as usize,
            meta.sh_size as usize,
            ".badc.meta",
        )?;
        decode_meta(meta_bytes, &mut unit)?;

        // .strtab + .symtab
        let strtab_bytes = slice_of(
            bytes,
            strtab.sh_offset as usize,
            strtab.sh_size as usize,
            ".strtab",
        )?;
        decode_symtab(
            slice_of(
                bytes,
                symtab.sh_offset as usize,
                symtab.sh_size as usize,
                ".symtab",
            )?,
            strtab_bytes,
            &mut unit,
        )?;

        // .rela.badc.text + .rela.badc.data
        decode_relocs(
            slice_of(
                bytes,
                rela_text.sh_offset as usize,
                rela_text.sh_size as usize,
                ".rela.badc.text",
            )?,
            true,
            &mut unit,
        )?;
        decode_relocs(
            slice_of(
                bytes,
                rela_data.sh_offset as usize,
                rela_data.sh_size as usize,
                ".rela.badc.data",
            )?,
            false,
            &mut unit,
        )?;

        let _ = e_shstrndx;
        Ok(unit)
    }
}

#[derive(Debug, Clone, Copy)]
#[allow(dead_code)]
struct ShdrView {
    sh_name: u32,
    sh_type: u32,
    sh_flags: u64,
    sh_offset: u64,
    sh_size: u64,
    sh_link: u32,
    sh_info: u32,
}

fn slice_of<'a>(bytes: &'a [u8], off: usize, len: usize, what: &str) -> Result<&'a [u8], C5Error> {
    bytes
        .get(off..off + len)
        .ok_or_else(|| err(&format!("{what} out of bounds (off={off}, len={len})")))
}

fn err(msg: &str) -> C5Error {
    C5Error::Compile(crate::c5::error::fmt_internal_err(msg))
}

fn u16_at(bytes: &[u8], off: usize) -> u16 {
    u16::from_le_bytes(bytes[off..off + 2].try_into().unwrap())
}
fn u32_at(bytes: &[u8], off: usize) -> u32 {
    u32::from_le_bytes(bytes[off..off + 4].try_into().unwrap())
}
fn u64_at(bytes: &[u8], off: usize) -> u64 {
    u64::from_le_bytes(bytes[off..off + 8].try_into().unwrap())
}
fn i64_at(bytes: &[u8], off: usize) -> i64 {
    i64::from_le_bytes(bytes[off..off + 8].try_into().unwrap())
}

fn read_string(bytes: &[u8], cursor: &mut usize) -> Result<String, C5Error> {
    if *cursor + 4 > bytes.len() {
        return Err(err("truncated string length"));
    }
    let len = u32_at(bytes, *cursor) as usize;
    *cursor += 4;
    if *cursor + len > bytes.len() {
        return Err(err("truncated string body"));
    }
    let s = core::str::from_utf8(&bytes[*cursor..*cursor + len])
        .map_err(|_| err("string is not valid UTF-8"))?
        .to_string();
    *cursor += len;
    Ok(s)
}

fn decode_symtab(symtab: &[u8], strtab: &[u8], unit: &mut LinkUnit) -> Result<(), C5Error> {
    if !symtab.len().is_multiple_of(24) {
        return Err(err("symtab size is not a multiple of 24"));
    }
    // The first symbol is the standard ELF null sentinel; skip it.
    for off in (24..symtab.len()).step_by(24) {
        let st_name = u32_at(symtab, off) as usize;
        let st_info = symtab[off + 4];
        let st_shndx = u16_at(symtab, off + 6);
        let st_value = u64_at(symtab, off + 8);
        let st_size = u64_at(symtab, off + 16);
        let binding = st_info >> 4;
        let st_type = st_info & 0xf;
        let name = read_cstring(strtab, st_name)?;
        let linkage = match binding {
            STB_LOCAL => crate::c5::symbol::Linkage::Internal,
            STB_GLOBAL => crate::c5::symbol::Linkage::External,
            _ => crate::c5::symbol::Linkage::None,
        };
        let kind = if st_shndx == SHN_UNDEF {
            SymbolKind::Undefined
        } else if st_shndx == SHIDX_TEXT || st_type == STT_FUNC {
            SymbolKind::Function
        } else if st_shndx == SHIDX_TDATA {
            SymbolKind::TlsData
        } else {
            SymbolKind::Data
        };
        // For Function symbols, value is stored as byte offset
        // in the on-disk file (mirroring the section bytes); the
        // reader divides by 8 to recover the bytecode word index.
        let value = match kind {
            SymbolKind::Function => st_value / 8,
            _ => st_value,
        };
        unit.symbols.push(LinkSymbol {
            name,
            linkage,
            kind,
            value,
            size: st_size,
            type_tag: 0,
        });
    }
    Ok(())
}

fn decode_relocs(table: &[u8], is_text: bool, unit: &mut LinkUnit) -> Result<(), C5Error> {
    if !table.len().is_multiple_of(24) {
        return Err(err(".rela.* size is not a multiple of 24"));
    }
    for off in (0..table.len()).step_by(24) {
        let r_offset = u64_at(table, off);
        let r_info = u64_at(table, off + 8);
        let r_addend = i64_at(table, off + 16);
        let kind_byte = (r_info & 0xff) as u8;
        let sym_index = (r_info >> 32) as u32;
        // The writer stored externals after internals -- but the
        // ELF symtab keeps a single ordered list. Translate the
        // ELF symbol index (which counts the null sentinel and
        // both locals + globals contiguously) to the
        // `LinkUnit::symbols` slot. We rebuild the same writer
        // ordering: locals first, then externals. To match,
        // subtract 1 (null sentinel) and re-index against the
        // sorted view.
        let kind = RelocKind::from_u8(kind_byte)
            .ok_or_else(|| err(&format!("unknown relocation kind {kind_byte}")))?;
        let location = match kind {
            RelocKind::JsrPc | RelocKind::ImmCodeAddr | RelocKind::ImmDataAddr => {
                if !is_text {
                    return Err(err("text-kind reloc in .rela.badc.data"));
                }
                r_offset / 8
            }
            RelocKind::DataDataAbs64 | RelocKind::DataCodeAbs64 => {
                if is_text {
                    return Err(err("data-kind reloc in .rela.badc.text"));
                }
                r_offset
            }
        };
        unit.relocs.push(Reloc {
            kind,
            location,
            sym_index: writer_to_unit_symbol(sym_index, unit),
            addend: r_addend,
        });
    }
    Ok(())
}

fn writer_to_unit_symbol(elf_index: u32, unit: &LinkUnit) -> u32 {
    // The reader pushes symbols into `unit.symbols` in the
    // same order as the ELF symtab walked them (locals first,
    // then globals -- exactly the writer's sort order). So
    // `elf_index == 1` corresponds to `unit.symbols[0]`,
    // `elf_index == 2` to `unit.symbols[1]`, and so on; just
    // subtract the null-sentinel offset and we have the local
    // table index directly.
    let off = (elf_index as usize).saturating_sub(1);
    if off < unit.symbols.len() {
        off as u32
    } else {
        0
    }
}

fn read_cstring(strtab: &[u8], off: usize) -> Result<String, C5Error> {
    if off == 0 {
        return Ok(String::new());
    }
    if off >= strtab.len() {
        return Err(err("strtab offset out of range"));
    }
    let end = strtab[off..]
        .iter()
        .position(|&b| b == 0)
        .ok_or_else(|| err("strtab entry not NUL-terminated"))?;
    let s = core::str::from_utf8(&strtab[off..off + end])
        .map_err(|_| err("strtab entry is not valid UTF-8"))?;
    Ok(s.to_string())
}

fn decode_meta(meta: &[u8], unit: &mut LinkUnit) -> Result<(), C5Error> {
    if meta.len() < 12 {
        return Err(err(".badc.meta too short"));
    }
    if &meta[..8] != META_MAGIC {
        return Err(err(".badc.meta magic mismatch"));
    }
    let version = u32::from_le_bytes(meta[8..12].try_into().unwrap());
    if version != META_VERSION {
        return Err(err(&format!(
            ".badc.meta version {version} unsupported (expected {META_VERSION})"
        )));
    }
    let mut cursor = 12;
    while cursor < meta.len() {
        if cursor + 5 > meta.len() {
            return Err(err("truncated meta tag header"));
        }
        let tag = meta[cursor];
        cursor += 1;
        let body_len = u32_at(meta, cursor) as usize;
        cursor += 4;
        if cursor + body_len > meta.len() {
            return Err(err(&format!("meta tag {tag} body truncated")));
        }
        let body = &meta[cursor..cursor + body_len];
        cursor += body_len;
        match tag {
            TAG_END => break,
            TAG_TLS_INIT_SIZE => {
                if body.len() < 8 {
                    return Err(err("tls_init_size body too short"));
                }
                unit.tls_init_size = u64_at(body, 0) as usize;
            }
            TAG_DATA_IMM_POSITIONS => {
                unit.data_imm_positions = read_vec_u64(body)?
                    .into_iter()
                    .map(|v| v as usize)
                    .collect();
            }
            TAG_CODE_IMM_POSITIONS => {
                unit.code_imm_positions = read_vec_u64(body)?
                    .into_iter()
                    .map(|v| v as usize)
                    .collect();
            }
            TAG_CALL_FP_ARG_MASKS => {
                if body.len() < 4 {
                    return Err(err("call_fp_arg_masks body too short"));
                }
                let n = u32_at(body, 0) as usize;
                let mut local = 4;
                let mut out = Vec::with_capacity(n);
                for _ in 0..n {
                    if local + 12 > body.len() {
                        return Err(err("call_fp_arg_masks truncated"));
                    }
                    let pc = u64_at(body, local) as usize;
                    let mask = u32_at(body, local + 8);
                    out.push((pc, mask));
                    local += 12;
                }
                unit.call_fp_arg_masks = out;
            }
            TAG_SOURCE_LINES => unit.source_lines = read_vec_u32(body)?,
            TAG_SOURCE_FUNCTIONS => unit.source_functions = read_string_vec(body)?,
            TAG_SOURCE_FILES => unit.source_files = read_string_vec(body)?,
            TAG_SOURCE_FILE_INDICES => unit.source_file_indices = read_vec_u16(body)?,
            TAG_VARIABLES => {
                if body.len() < 4 {
                    return Err(err("variables body too short"));
                }
                let n = u32_at(body, 0) as usize;
                let mut local = 4;
                let mut out = Vec::with_capacity(n);
                for _ in 0..n {
                    if local + 8 > body.len() {
                        return Err(err("variables row truncated"));
                    }
                    let function_bc_pc = u64_at(body, local);
                    local += 8;
                    let name = read_string(body, &mut local)?;
                    if local + 8 + 8 + 1 > body.len() {
                        return Err(err("variables row truncated"));
                    }
                    let type_tag = i64_at(body, local);
                    let fp_slot = i64_at(body, local + 8);
                    let is_parameter = body[local + 16] != 0;
                    local += 17;
                    out.push(crate::c5::program::VariableInfo {
                        function_bc_pc,
                        name,
                        type_tag,
                        fp_slot,
                        is_parameter,
                    });
                }
                unit.variables = out;
            }
            TAG_DATA_RELOCS => {
                if body.len() < 4 {
                    return Err(err("data_relocs body too short"));
                }
                let n = u32_at(body, 0) as usize;
                let mut local = 4;
                let mut out = Vec::with_capacity(n);
                for _ in 0..n {
                    if local + 16 > body.len() {
                        return Err(err("data_relocs row truncated"));
                    }
                    out.push(crate::c5::program::DataReloc {
                        data_offset: u64_at(body, local),
                        target_offset: u64_at(body, local + 8),
                    });
                    local += 16;
                }
                unit.data_relocs = out;
            }
            TAG_CODE_RELOCS => {
                if body.len() < 4 {
                    return Err(err("code_relocs body too short"));
                }
                let n = u32_at(body, 0) as usize;
                let mut local = 4;
                let mut out = Vec::with_capacity(n);
                for _ in 0..n {
                    if local + 16 > body.len() {
                        return Err(err("code_relocs row truncated"));
                    }
                    out.push(crate::c5::program::CodeReloc {
                        data_offset: u64_at(body, local),
                        target_bc_pc: u64_at(body, local + 8),
                    });
                    local += 16;
                }
                unit.code_relocs = out;
            }
            TAG_DYLIBS => unit.dylibs = read_dylibs(body)?,
            TAG_STRUCTS => unit.structs = read_structs(body)?,
            TAG_EXPORTS => unit.exports = read_exports(body)?,
            TAG_DLLMAIN_PC => {
                if body.len() < 8 {
                    return Err(err("dllmain_pc body too short"));
                }
                let v = u64_at(body, 0);
                if v == u64::MAX {
                    unit.dllmain_pc = None;
                } else {
                    unit.dllmain_pc = Some(v as usize);
                }
            }
            TAG_ENTRY_NAME => {
                let mut local = 0;
                let s = read_string(body, &mut local)?;
                unit.entry_name = if s.is_empty() { None } else { Some(s) };
            }
            TAG_SUBSYSTEM => {
                if body.is_empty() {
                    return Err(err("subsystem body empty"));
                }
                unit.subsystem = subsystem_from_u8(body[0]);
            }
            TAG_SOURCE_PATH => {
                let mut local = 0;
                unit.source_path = read_string(body, &mut local)?;
            }
            TAG_WARNINGS => unit.warnings = read_string_vec(body)?,
            _ => {
                // Unknown tag -- skip silently to preserve
                // forward compatibility.
            }
        }
    }
    Ok(())
}

fn read_vec_u64(body: &[u8]) -> Result<Vec<u64>, C5Error> {
    if body.len() < 4 {
        return Err(err("vec_u64 body too short"));
    }
    let n = u32_at(body, 0) as usize;
    if body.len() < 4 + n * 8 {
        return Err(err("vec_u64 truncated"));
    }
    let mut out = Vec::with_capacity(n);
    for i in 0..n {
        out.push(u64_at(body, 4 + i * 8));
    }
    Ok(out)
}

fn read_vec_u32(body: &[u8]) -> Result<Vec<u32>, C5Error> {
    if body.len() < 4 {
        return Err(err("vec_u32 body too short"));
    }
    let n = u32_at(body, 0) as usize;
    if body.len() < 4 + n * 4 {
        return Err(err("vec_u32 truncated"));
    }
    let mut out = Vec::with_capacity(n);
    for i in 0..n {
        out.push(u32_at(body, 4 + i * 4));
    }
    Ok(out)
}

fn read_vec_u16(body: &[u8]) -> Result<Vec<u16>, C5Error> {
    if body.len() < 4 {
        return Err(err("vec_u16 body too short"));
    }
    let n = u32_at(body, 0) as usize;
    if body.len() < 4 + n * 2 {
        return Err(err("vec_u16 truncated"));
    }
    let mut out = Vec::with_capacity(n);
    for i in 0..n {
        out.push(u16_at(body, 4 + i * 2));
    }
    Ok(out)
}

fn read_string_vec(body: &[u8]) -> Result<Vec<String>, C5Error> {
    if body.len() < 4 {
        return Err(err("string_vec body too short"));
    }
    let n = u32_at(body, 0) as usize;
    let mut cursor = 4;
    let mut out = Vec::with_capacity(n);
    for _ in 0..n {
        out.push(read_string(body, &mut cursor)?);
    }
    Ok(out)
}

fn read_dylibs(body: &[u8]) -> Result<Vec<crate::c5::preprocessor::DylibSpec>, C5Error> {
    use crate::c5::preprocessor::{Binding, DylibSpec};
    if body.len() < 4 {
        return Err(err("dylibs body too short"));
    }
    let n = u32_at(body, 0) as usize;
    let mut cursor = 4;
    let mut out = Vec::with_capacity(n);
    for _ in 0..n {
        let name = read_string(body, &mut cursor)?;
        let path = read_string(body, &mut cursor)?;
        if cursor + 4 > body.len() {
            return Err(err("dylib bindings count truncated"));
        }
        let bn = u32_at(body, cursor) as usize;
        cursor += 4;
        let mut bindings = Vec::with_capacity(bn);
        for _ in 0..bn {
            if cursor + 1 > body.len() {
                return Err(err("binding flag truncated"));
            }
            let is_variadic = body[cursor] != 0;
            cursor += 1;
            if cursor + 4 > body.len() {
                return Err(err("binding fixed_args truncated"));
            }
            let fixed_args = u32_at(body, cursor) as usize;
            cursor += 4;
            if cursor + 8 > body.len() {
                return Err(err("binding return_type_tag truncated"));
            }
            let return_type_tag = i64_at(body, cursor);
            cursor += 8;
            if cursor + 4 > body.len() {
                return Err(err("binding param_types count truncated"));
            }
            let pn = u32_at(body, cursor) as usize;
            cursor += 4;
            let mut param_types = Vec::with_capacity(pn);
            for _ in 0..pn {
                if cursor + 8 > body.len() {
                    return Err(err("binding param_types row truncated"));
                }
                param_types.push(i64_at(body, cursor));
                cursor += 8;
            }
            let local_name = read_string(body, &mut cursor)?;
            let real_symbol = read_string(body, &mut cursor)?;
            bindings.push(Binding {
                is_variadic,
                fixed_args,
                return_type_tag,
                param_types,
                local_name,
                real_symbol,
            });
        }
        out.push(DylibSpec {
            name,
            path,
            bindings,
        });
    }
    Ok(out)
}

fn read_structs(body: &[u8]) -> Result<Vec<crate::c5::compiler::StructDef>, C5Error> {
    use crate::c5::compiler::{StructDef, StructField};
    if body.len() < 4 {
        return Err(err("structs body too short"));
    }
    let n = u32_at(body, 0) as usize;
    let mut cursor = 4;
    let mut out = Vec::with_capacity(n);
    for _ in 0..n {
        let name = read_string(body, &mut cursor)?;
        if cursor + 8 + 8 + 1 + 4 > body.len() {
            return Err(err("struct row truncated"));
        }
        let size = u64_at(body, cursor) as usize;
        cursor += 8;
        let align = u64_at(body, cursor) as usize;
        cursor += 8;
        let is_union = body[cursor] != 0;
        cursor += 1;
        let fn_count = u32_at(body, cursor) as usize;
        cursor += 4;
        let mut fields = Vec::with_capacity(fn_count);
        for _ in 0..fn_count {
            let fname = read_string(body, &mut cursor)?;
            if cursor + 8 + 8 + 8 + 8 + 4 > body.len() {
                return Err(err("field row truncated"));
            }
            let offset = u64_at(body, cursor) as usize;
            cursor += 8;
            let ty = i64_at(body, cursor);
            cursor += 8;
            let array_size = i64_at(body, cursor);
            cursor += 8;
            let inner_array_size = i64_at(body, cursor);
            cursor += 8;
            let dn = u32_at(body, cursor) as usize;
            cursor += 4;
            let mut array_dims = Vec::with_capacity(dn);
            for _ in 0..dn {
                if cursor + 8 > body.len() {
                    return Err(err("field array_dims truncated"));
                }
                array_dims.push(i64_at(body, cursor));
                cursor += 8;
            }
            if cursor + 8 > body.len() {
                return Err(err("field bit_offset/bit_width truncated"));
            }
            let bit_offset = u32_at(body, cursor);
            cursor += 4;
            let bit_width = u32_at(body, cursor);
            cursor += 4;
            fields.push(StructField {
                name: fname,
                offset,
                ty,
                array_size,
                inner_array_size,
                array_dims,
                bit_offset,
                bit_width,
            });
        }
        out.push(StructDef {
            name,
            size,
            align,
            fields,
            is_union,
        });
    }
    Ok(out)
}

fn read_exports(body: &[u8]) -> Result<Vec<crate::c5::program::ExportedFunction>, C5Error> {
    if body.len() < 4 {
        return Err(err("exports body too short"));
    }
    let n = u32_at(body, 0) as usize;
    let mut cursor = 4;
    let mut out = Vec::with_capacity(n);
    for _ in 0..n {
        let name = read_string(body, &mut cursor)?;
        if cursor + 8 > body.len() {
            return Err(err("export row truncated"));
        }
        let bc = u64_at(body, cursor) as usize;
        cursor += 8;
        out.push(crate::c5::program::ExportedFunction {
            name,
            bytecode_pc: bc,
        });
    }
    Ok(out)
}
