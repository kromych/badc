//! PE32+ image writer for Windows x86_64 and aarch64: the headers, the
//! section table and the directories the loader reads -- imports,
//! exports, base relocations, exception data and the TLS directory.

use crate::c5::diag::Code;
use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use super::super::error::C5Error;
use super::aarch64;
use super::elf_reloc_types::AbsCheck;
use super::x86_64;
use super::{AddrPart, Build, DataRegion, Machine, data_region_addr, image};
use crate::c5::layout::{round_up, write_struct};
use crate::c5::program::Program;

const IMAGE_BASE: u64 = 0x1_4000_0000;
const SECTION_ALIGNMENT: u32 = 0x1000;
const FILE_ALIGNMENT: u32 = 0x200;

const IMAGE_FILE_MACHINE_AMD64: u16 = 0x8664;
const IMAGE_FILE_MACHINE_ARM64: u16 = 0xAA64;
const IMAGE_FILE_EXECUTABLE_IMAGE: u16 = 0x0002;
const IMAGE_FILE_DLL: u16 = 0x2000;
const IMAGE_FILE_LARGE_ADDRESS_AWARE: u16 = 0x0020;

const PE32_PLUS_MAGIC: u16 = 0x20B;
const IMAGE_SUBSYSTEM_NATIVE: u16 = 1;
const IMAGE_SUBSYSTEM_WINDOWS_GUI: u16 = 2;
const IMAGE_SUBSYSTEM_WINDOWS_CUI: u16 = 3;
const IMAGE_SUBSYSTEM_EFI_APPLICATION: u16 = 10;
const IMAGE_SUBSYSTEM_EFI_BOOT_SERVICE_DRIVER: u16 = 11;
const IMAGE_SUBSYSTEM_EFI_RUNTIME_DRIVER: u16 = 12;
const IMAGE_SUBSYSTEM_EFI_ROM: u16 = 13;

/// Subsystems whose loader invokes the entry point directly: NT hands
/// `NtProcessStartup` a PEB pointer; UEFI hands the entry `(EFI_HANDLE,
/// EFI_SYSTEM_TABLE *)`.
fn subsystem_uses_passthrough_entry(subsystem: u16) -> bool {
    matches!(
        subsystem,
        IMAGE_SUBSYSTEM_NATIVE
            | IMAGE_SUBSYSTEM_EFI_APPLICATION
            | IMAGE_SUBSYSTEM_EFI_BOOT_SERVICE_DRIVER
            | IMAGE_SUBSYSTEM_EFI_RUNTIME_DRIVER
            | IMAGE_SUBSYSTEM_EFI_ROM
    )
}
const IMAGE_DLLCHARACTERISTICS_HIGH_ENTROPY_VA: u16 = 0x0020;
const IMAGE_DLLCHARACTERISTICS_DYNAMIC_BASE: u16 = 0x0040;
const IMAGE_DLLCHARACTERISTICS_NX_COMPAT: u16 = 0x0100;
const IMAGE_DLLCHARACTERISTICS_NO_SEH: u16 = 0x0400;

const IMAGE_SYM_CLASS_EXTERNAL: u8 = 2;
const IMAGE_SYM_TYPE_FUNCTION: u16 = 0x20;
const IMAGE_SYMBOL_SIZE: u32 = 18;

const IMAGE_SCN_CNT_CODE: u32 = 0x0000_0020;
const IMAGE_SCN_CNT_INITIALIZED_DATA: u32 = 0x0000_0040;
const IMAGE_SCN_CNT_UNINITIALIZED_DATA: u32 = 0x0000_0080;
const IMAGE_SCN_MEM_DISCARDABLE: u32 = 0x0200_0000;
const IMAGE_SCN_MEM_EXECUTE: u32 = 0x2000_0000;
const IMAGE_SCN_MEM_READ: u32 = 0x4000_0000;
const IMAGE_SCN_MEM_WRITE: u32 = 0x8000_0000;

const IMAGE_REL_BASED_DIR64: u16 = 10 << 12;
const IMAGE_REL_BASED_HIGHLOW: u16 = 3 << 12;
const IMAGE_REL_BASED_ABSOLUTE: u16 = 0;

const NUM_DATA_DIRS: u32 = 16;

/// Section layout: every emitted PE carries `.text`, `.pdata`, `.idata`,
/// and `.rdata` (read-only data prefix + switch tables + producer
/// fingerprint; the fingerprint keeps it non-empty).
#[derive(Default)]
struct SectionPlan {
    rdata: bool,
    data: bool,
    reloc: bool,
    edata: bool,
    dwarf: usize,
    named: usize,
}

impl SectionPlan {
    /// Headers the image carries: `.text`, `.pdata` and `.idata`
    /// unconditionally, plus each optional section this plan names.
    fn count(&self) -> usize {
        3 + self.rdata as usize
            + self.data as usize
            + self.reloc as usize
            + self.edata as usize
            + self.dwarf
            + self.named
    }
}

/// Family whose region held a named section's bytes, hence the
/// characteristics it takes and the offset space its extent is in.
#[derive(Clone, Copy, PartialEq, Eq)]
enum NamedFamily {
    RoData,
    RelRo,
    Data,
    Bss,
}

/// A named section given a header of its own: it leaves its family's region
/// and takes a SectionAlignment-aligned slot past `.data`.
struct NamedOut<'a> {
    name: &'a str,
    family: NamedFamily,
    start: u32,
    size: u32,
    rva: u32,
    file_off: u32,
    raw_size: u32,
}

const DOS_HEADER_AND_STUB: usize = 128; // 64 byte DOS header + 64 byte stub
const PE_SIG_SIZE: usize = 4;
const COFF_HEADER_SIZE: usize = 20;
const OPTIONAL64_HEADER_SIZE: usize = 240;
const SECTION_HEADER_SIZE: usize = 40;

/// Raw on-disk size of the PE headers (DOS + PE sig + COFF + Optional +
/// section table), rounded up to FILE_ALIGNMENT.
fn headers_raw_size(plan: &SectionPlan) -> usize {
    let unaligned = DOS_HEADER_AND_STUB
        + PE_SIG_SIZE
        + COFF_HEADER_SIZE
        + OPTIONAL64_HEADER_SIZE
        + SECTION_HEADER_SIZE * plan.count();
    (unaligned + FILE_ALIGNMENT as usize - 1) & !(FILE_ALIGNMENT as usize - 1)
}

const IMAGE_IMPORT_DESCRIPTOR_SIZE: usize = 20;
const IAT_ENTRY_SIZE: usize = 8;

const DATA_DIRECTORY_EXPORT: usize = 0;
const DATA_DIRECTORY_IMPORT: usize = 1;
const DATA_DIRECTORY_EXCEPTION: usize = 3;
const DATA_DIRECTORY_BASERELOC: usize = 5;
const DATA_DIRECTORY_TLS: usize = 9;
const DATA_DIRECTORY_IAT: usize = 12;

const IMAGE_TLS_DIRECTORY64_SIZE: u32 = 40;

const ARM64_PACKED_FUNCTION_MAX_BYTES: u32 = 2047 * 4;

// Entry
// adapter. `__c5_entry` runs process startup (argc/argv via the CRT, then
// the entry, then `exit`), so the writer references only this one name; the
// CRT / kernel32 imports ride the runtime TU's `#pragma binding`.

const RT_ENTRY: &str = "__c5_entry";

/// One entry of the PE DWARF layout: the section name (`/<offset>` into the
/// COFF string table for the full `.debug_*` name), the section's RVA and
/// file offset, and the payload.
struct DwarfPeSlot {
    name: [u8; 8],
    rva: u32,
    file_off: u32,
    bytes: Vec<u8>,
}

/// RVAs, file offsets and payloads of every section, settled before any
/// byte is written.
#[derive(Default)]
struct PeLayout<'a> {
    ro_len: u32,
    relro_total: u32,
    relro_size: u32,
    file_data_len: u32,
    ro_head: u32,
    relro_head_len: u32,
    data_head_len: u32,
    bss_head: u32,
    /// What `.rdata` keeps of the two read-only families once their named
    /// runs move out.
    rdata_prefix_len: u32,
    jt_base_in_rdata: u32,
    provenance: Vec<u8>,
    marker_base_in_rdata: u32,
    rdata_size: u32,
    rdata_present: bool,
    data_present: bool,
    reloc_present: bool,
    edata_present: bool,
    dwarf_present: bool,
    text_rva: u32,
    dwarf_blobs: Vec<(&'static str, Vec<u8>)>,
    plan: SectionPlan,
    headers_size: u32,
    text_file_off: u32,
    text_size: u32,
    text_raw_size: u32,
    pdata_rva: u32,
    pdata_file_off: u32,
    pdata_bytes: Vec<u8>,
    pdata_directory_size: u32,
    pdata_raw_size: u32,
    idata_rva: u32,
    idata_file_off: u32,
    idata: IDataLayout,
    idata_raw_size: u32,
    rdata_rva: u32,
    rdata_file_off: u32,
    rdata_raw_size: u32,
    tls: TlsLayout,
    data_size: u32,
    data_vsize: u32,
    data_rva: u32,
    data_file_off: u32,
    data_raw_size: u32,
    named_out: Vec<NamedOut<'a>>,
    named_file_end: u32,
    named_rva_end: u32,
    text_abs_fields: Vec<AbsTextField>,
    reloc_rva: u32,
    reloc_file_off: u32,
    tls_sites: Vec<(usize, u64)>,
    reloc_bytes: Vec<u8>,
    reloc_raw_size: u32,
    edata_rva: u32,
    edata_file_off: u32,
    edata_bytes: Vec<u8>,
    edata_raw_size: u32,
    pre_dwarf_end_file_off: u32,
    pre_dwarf_end_rva: u32,
    coff_strtab: Vec<u8>,
    dwarf_sections: Vec<DwarfPeSlot>,
    dwarf_end_file_off: u32,
    dwarf_end_rva: u32,
    coff_symbols: Vec<u8>,
    coff_symtab_file_off: u32,
    coff_strtab_file_off: u32,
    total_file_size: usize,
    image_size: u32,
}

/// One PE image's writer. [`write`] runs the phases in order: the entry
/// stub and the import list, the section layout, the `.text` bytes with
/// every fixup applied, then the headers and each section body.
struct PeWriter<'a> {
    program: &'a Program,
    build: &'a Build,
    machine: Machine,
    target: super::Target,
    is_dll: bool,
    subsystem: u16,
    passthrough_entry: bool,
    stub: EntryStub,
    imports: Vec<(String, String)>,
    dlls: Vec<DllGroup>,
    /// The stub occupies a span rounded up to the alignment `build.text`'s
    /// own input sections claim; the section starts at SECTION_ALIGNMENT,
    /// so the span places `build.text[0]` on that alignment absolutely.
    text_prologue_len: u32,
    layout: PeLayout<'a>,
    text_bytes: Vec<u8>,
    jt_bytes: Vec<u8>,
    out: Vec<u8>,
}

pub(super) fn write(
    program: &Program,
    build: &Build,
    machine: Machine,
    target: super::Target,
) -> Result<Vec<u8>, C5Error> {
    let mut w = PeWriter::new(program, build, machine, target);
    w.layout_code_sections()?;
    w.layout_data_sections()?;
    w.layout_reloc_and_export_sections()?;
    w.layout_dwarf_and_coff();
    w.build_text()?;
    w.emit_headers()?;
    w.emit_sections()
}

impl<'a> PeWriter<'a> {
    fn new(
        program: &'a Program,
        build: &'a Build,
        machine: Machine,
        target: super::Target,
    ) -> Self {
        use crate::c5::preprocessor::Subsystem;
        let is_dll = build.output_kind == super::OutputKind::SharedLibrary;
        let subsystem = match program.subsystem {
            Some(Subsystem::Windows) => IMAGE_SUBSYSTEM_WINDOWS_GUI,
            Some(Subsystem::Native) => IMAGE_SUBSYSTEM_NATIVE,
            Some(Subsystem::EfiApplication) => IMAGE_SUBSYSTEM_EFI_APPLICATION,
            Some(Subsystem::EfiBootServiceDriver) => IMAGE_SUBSYSTEM_EFI_BOOT_SERVICE_DRIVER,
            Some(Subsystem::EfiRuntimeDriver) => IMAGE_SUBSYSTEM_EFI_RUNTIME_DRIVER,
            Some(Subsystem::EfiRom) => IMAGE_SUBSYSTEM_EFI_ROM,
            Some(Subsystem::Console) | None => IMAGE_SUBSYSTEM_WINDOWS_CUI,
        };
        let user_dllmain = is_dll && build.dllmain_pc.is_some();
        let passthrough_entry = subsystem_uses_passthrough_entry(subsystem) && !is_dll;
        let stub = if user_dllmain || passthrough_entry {
            EntryStub::empty()
        } else {
            build_entry_stub(machine, is_dll)
        };
        // Index N becomes IAT slot N. The CRT / kernel32 entries the stub
        // relies on ride the embedded runtime TU's `#pragma binding`, so
        // they already sit in `build.imports`.
        let imports: Vec<(String, String)> = build
            .imports
            .imports
            .iter()
            .map(|imp| {
                (
                    imp.real_symbol.clone(),
                    build.imports.dylibs[imp.dylib_index].path.clone(),
                )
            })
            .collect();
        let dlls = group_imports_by_dll(&imports);
        let text_align = build.text_align.max(16) as u32;
        let text_prologue_len = round_up(stub.bytes.len() as u32, text_align);
        PeWriter {
            program,
            build,
            machine,
            target,
            is_dll,
            subsystem,
            passthrough_entry,
            stub,
            imports,
            dlls,
            text_prologue_len,
            layout: PeLayout::default(),
            text_bytes: Vec::new(),
            jt_bytes: Vec::new(),
            out: Vec::new(),
        }
    }

    fn internal(msg: String) -> C5Error {
        C5Error::Compile(crate::c5::error::fmt_internal_diag(Code::INTERNAL, &msg))
    }

    /// Family whose region holds a named section's bytes.
    fn named_family(&self, n: &crate::c5::codegen::NamedSection) -> NamedFamily {
        if n.bss {
            NamedFamily::Bss
        } else if n.offset < self.layout.ro_len as u64 {
            NamedFamily::RoData
        } else if n.offset < self.layout.relro_total as u64 {
            NamedFamily::RelRo
        } else {
            NamedFamily::Data
        }
    }

    fn head_of(&self, f: NamedFamily, full: u32) -> u32 {
        self.build
            .named_sections
            .iter()
            .filter(|n| self.named_family(n) == f)
            .map(|n| n.offset as u32)
            .min()
            .unwrap_or(full)
    }

    /// RVA of the code body, past the entry stub.
    fn text_body_rva(&self) -> u32 {
        self.layout.text_rva + self.text_prologue_len
    }

    /// The data families and which sections the image carries, the DWARF
    /// payloads (built first so the section-header count is known before
    /// the layout; empty blobs are dropped, since the loader rejects two
    /// `SizeOfRawData == 0` sections sharing an RVA), then `.text`,
    /// `.pdata` and `.idata`.
    fn layout_code_sections(&mut self) -> Result<(), C5Error> {
        let (program, build) = (self.program, self.build);
        let l = &mut self.layout;
        l.ro_len = build.data_ro_len.min(build.data.len()) as u32;
        l.relro_total = build
            .data_relro_len
            .clamp(build.data_ro_len, build.data.len()) as u32;
        l.relro_size = l.relro_total - l.ro_len;
        l.file_data_len = build.data.len() as u32;
        let (ro_len, relro_total, file_data_len) = (l.ro_len, l.relro_total, l.file_data_len);
        let ro_head = self.head_of(NamedFamily::RoData, ro_len);
        let relro_head_len = self.head_of(NamedFamily::RelRo, relro_total) - ro_len;
        let data_head_len = self.head_of(NamedFamily::Data, file_data_len) - relro_total;
        let bss_head = self.head_of(NamedFamily::Bss, build.bss_size as u32);
        let l = &mut self.layout;
        l.ro_head = ro_head;
        l.relro_head_len = relro_head_len;
        l.data_head_len = data_head_len;
        l.bss_head = bss_head;
        l.rdata_prefix_len = ro_head + relro_head_len;
        l.jt_base_in_rdata = if build.rodata.bytes.is_empty() {
            l.rdata_prefix_len
        } else {
            round_up(l.rdata_prefix_len, 8)
        };
        l.provenance = super::provenance_comment();
        l.marker_base_in_rdata = round_up(l.jt_base_in_rdata + build.rodata.bytes.len() as u32, 8);
        l.rdata_size = l.marker_base_in_rdata + l.provenance.len() as u32;
        l.rdata_present = l.rdata_size > 0;
        l.data_present = data_head_len > 0 || !build.tls_data.is_empty() || bss_head > 0;
        l.reloc_present = !build.tls_data.is_empty()
            || !build.data_relocs.is_empty()
            || !build.code_relocs.is_empty()
            || !build.label_relocs.is_empty()
            || !build.text_abs_relocs.is_empty();
        l.edata_present = !build.exports.is_empty() || !build.dynamic_exports.is_empty();
        l.dwarf_present = build.debug_info;
        l.text_rva = SECTION_ALIGNMENT;
        let text_vmaddr = IMAGE_BASE + (l.text_rva + self.text_prologue_len) as u64;
        let raw = image::image_dwarf(program, build, self.target, text_vmaddr, None, None)?;
        l.dwarf_blobs = alloc::vec![
            (".debug_info", raw.debug_info),
            (".debug_abbrev", raw.debug_abbrev),
            (".debug_line", raw.debug_line),
            (".debug_str", raw.debug_str),
            (".debug_frame", raw.debug_frame),
        ];
        let dwarf_section_count = if l.dwarf_present {
            l.dwarf_blobs.iter().filter(|(_, b)| !b.is_empty()).count()
        } else {
            0
        };
        l.plan = SectionPlan {
            rdata: l.rdata_present,
            data: l.data_present,
            reloc: l.reloc_present,
            edata: l.edata_present,
            dwarf: dwarf_section_count,
            named: build.named_sections.len(),
        };
        l.headers_size = headers_raw_size(&l.plan) as u32;
        l.text_file_off = l.headers_size;
        l.text_size = self.text_prologue_len + build.text.len() as u32;
        l.text_raw_size = round_up(l.text_size, FILE_ALIGNMENT);
        l.pdata_rva = round_up(l.text_rva + l.text_size, SECTION_ALIGNMENT);
        l.pdata_file_off = l.text_file_off + l.text_raw_size;
        let pdata = build_pdata(
            self.machine,
            l.text_rva,
            l.text_size,
            l.pdata_rva,
            self.text_prologue_len,
            &build.fn_unwind,
        );
        l.pdata_directory_size = pdata.directory_size;
        l.pdata_raw_size = round_up(pdata.bytes.len() as u32, FILE_ALIGNMENT);
        l.idata_rva = round_up(l.pdata_rva + pdata.bytes.len() as u32, SECTION_ALIGNMENT);
        l.pdata_bytes = pdata.bytes;
        l.idata_file_off = l.pdata_file_off + l.pdata_raw_size;
        l.idata = plan_idata(&self.dlls, &self.imports, l.idata_rva);
        l.idata_raw_size = round_up(l.idata.bytes.len() as u32, FILE_ALIGNMENT);
        Ok(())
    }

    /// `.rdata`, `.data` (the writable head, then under TLS the 4-byte
    /// `_tls_index` slot, the 40-byte `IMAGE_TLS_DIRECTORY64` and the TLS
    /// template) and the named sections, each on its own RVA page past
    /// `.data` since a PE section RVA is SectionAlignment-aligned and
    /// cannot sit inside its family's range.
    fn layout_data_sections(&mut self) -> Result<(), C5Error> {
        let build = self.build;
        let l = &mut self.layout;
        l.rdata_rva = round_up(l.idata_rva + l.idata.bytes.len() as u32, SECTION_ALIGNMENT);
        l.rdata_file_off = l.idata_file_off + l.idata_raw_size;
        l.rdata_raw_size = if l.rdata_present {
            round_up(l.rdata_size, FILE_ALIGNMENT)
        } else {
            0
        };
        l.tls = compute_tls_layout(build, l.data_head_len);
        l.data_size = l.data_head_len + l.tls.tls_blob_size;
        l.data_vsize = l.data_size + l.bss_head;
        l.data_rva = if l.rdata_present {
            round_up(l.rdata_rva + l.rdata_size, SECTION_ALIGNMENT)
        } else {
            l.rdata_rva
        };
        l.data_file_off = l.rdata_file_off + l.rdata_raw_size;
        l.data_raw_size = if l.data_present {
            round_up(l.data_size, FILE_ALIGNMENT)
        } else {
            0
        };
        let mut rva = if l.data_present {
            round_up(l.data_rva + l.data_vsize, SECTION_ALIGNMENT)
        } else {
            l.data_rva
        };
        let mut file_off = l.data_file_off + l.data_raw_size;
        let (ro_len, relro_total) = (l.ro_len as u64, l.relro_total as u64);
        let named_out: Vec<NamedOut<'a>> = build
            .named_sections
            .iter()
            .map(|n| {
                let family = if n.bss {
                    NamedFamily::Bss
                } else if n.offset < ro_len {
                    NamedFamily::RoData
                } else if n.offset < relro_total {
                    NamedFamily::RelRo
                } else {
                    NamedFamily::Data
                };
                let size = n.size as u32;
                let raw_size = if family == NamedFamily::Bss {
                    0
                } else {
                    round_up(size, FILE_ALIGNMENT)
                };
                let out = NamedOut {
                    name: &n.name,
                    family,
                    start: n.offset as u32,
                    size,
                    rva,
                    file_off: if raw_size > 0 { file_off } else { 0 },
                    raw_size,
                };
                rva = round_up(rva + size.max(1), SECTION_ALIGNMENT);
                file_off += raw_size;
                out
            })
            .collect();
        l.named_file_end =
            l.data_file_off + l.data_raw_size + named_out.iter().map(|n| n.raw_size).sum::<u32>();
        l.named_rva_end = match named_out.last() {
            Some(n) => round_up(n.rva + n.size.max(1), SECTION_ALIGNMENT),
            None => l.data_rva + l.data_vsize,
        };
        l.named_out = named_out;
        if let Some(md) = &build.merged_dwarf {
            let mut info = core::mem::take(&mut self.layout.dwarf_blobs[0].1);
            for r in &md.debug_info_data_relocs {
                super::apply_merged_dwarf_data_reloc(&mut info, r, &|off| {
                    IMAGE_BASE + self.data_off_to_rva(off as u32) as u64
                })?;
            }
            self.layout.dwarf_blobs[0].1 = info;
        }
        Ok(())
    }

    /// RVA of a data-stream offset: the named section covering it, else its
    /// family's region.
    fn data_off_to_rva(&self, off: u32) -> u32 {
        let l = &self.layout;
        let named_base = |n: &NamedOut| -> u32 {
            n.start
                + if n.family == NamedFamily::Bss {
                    l.file_data_len
                } else {
                    0
                }
        };
        if let Some(n) = l
            .named_out
            .iter()
            .find(|n| off >= named_base(n) && off <= named_base(n) + n.size)
        {
            return n.rva + (off - named_base(n));
        }
        data_region_addr(&self.data_regions(), off as u64) as u32
    }

    /// The data stream's family regions at their RVAs, each closed at its
    /// family's head: a group's extent is closed at both ends, so an offset
    /// at one group's end names that group, and the padding a moved run
    /// left behind resolves to the family's end.
    fn data_regions(&self) -> [DataRegion; 4] {
        let l = &self.layout;
        let region = |start: u32, base: u32, len: u32| DataRegion {
            start: start as u64,
            base: base as u64,
            len: len as u64,
        };
        [
            region(0, l.rdata_rva, l.ro_head),
            region(l.ro_len, l.rdata_rva + l.ro_head, l.relro_head_len),
            region(l.relro_total, l.data_rva, l.data_head_len),
            region(l.file_data_len, l.data_rva + l.data_size, l.bss_head),
        ]
    }

    /// `.reloc` (one `IMAGE_BASE_RELOCATION` block per page holding an
    /// absolute pointer: the TLS directory's three VAs, the template's
    /// address constants, every pointer initializer, and the absolute
    /// fields in `.text`) and `.edata`, the export directory with every
    /// export resolved to its RVA.
    fn layout_reloc_and_export_sections(&mut self) -> Result<(), C5Error> {
        let build = self.build;
        let machine = self.machine;
        let text_body_rva = self.text_body_rva();
        let text_abs_fields: Vec<AbsTextField> = build
            .text_abs_relocs
            .iter()
            .map(|r| {
                let site_off = r.site_text_offset as usize + self.text_prologue_len as usize;
                let (width, check) = abs_field(machine, r.rtype).ok_or_else(|| {
                    Self::internal(format!(
                        "PE: text absolute field {site_off:#x} carries relocation type {} with no \
                         field width",
                        r.rtype
                    ))
                })?;
                let target_rva = if r.target_in_text {
                    text_body_rva + r.target_offset as u32
                } else {
                    self.data_off_to_rva(r.target_offset as u32)
                };
                Ok(AbsTextField {
                    site_off,
                    site_rva: self.layout.text_rva + site_off as u32,
                    width,
                    check,
                    target_rva,
                })
            })
            .collect::<Result<_, C5Error>>()?;
        let tls_sites = image::tls_reloc_sites(
            "PE",
            build,
            &|off| IMAGE_BASE + self.data_off_to_rva(off as u32) as u64,
            IMAGE_BASE + text_body_rva as u64,
        )?;
        let l = &self.layout;
        let reloc_present = l.reloc_present;
        let (reloc_rva, reloc_file_off) = if reloc_present {
            (
                round_up(l.named_rva_end, SECTION_ALIGNMENT),
                l.named_file_end,
            )
        } else {
            (0, 0)
        };
        let reloc_bytes: Vec<u8> = if reloc_present {
            build_reloc_section(
                l.data_rva,
                &|off| self.data_off_to_rva(off),
                &l.tls,
                !build.tls_data.is_empty(),
                &build.data_relocs,
                &build.code_relocs,
                &build.label_relocs,
                &text_abs_fields,
                &tls_sites,
            )
        } else {
            Vec::new()
        };
        let reloc_size = reloc_bytes.len() as u32;
        let reloc_raw_size = if reloc_present {
            round_up(reloc_size, FILE_ALIGNMENT)
        } else {
            0
        };
        let edata_present = l.edata_present;
        let edata_rva: u32 = if edata_present {
            round_up(
                if reloc_present {
                    reloc_rva + reloc_size
                } else if l.data_present || !l.named_out.is_empty() {
                    l.named_rva_end
                } else if l.rdata_present {
                    l.rdata_rva + l.rdata_size
                } else {
                    l.idata_rva + l.idata.bytes.len() as u32
                },
                SECTION_ALIGNMENT,
            )
        } else {
            0
        };
        let edata_file_off: u32 = if edata_present {
            if reloc_present {
                reloc_file_off + reloc_raw_size
            } else if l.data_present || !l.named_out.is_empty() {
                l.named_file_end
            } else {
                l.rdata_file_off + l.rdata_raw_size
            }
        } else {
            0
        };
        let edata_bytes: Vec<u8> = if edata_present {
            let mut entries: Vec<(String, u32)> = Vec::new();
            for exp in &build.exports {
                let native_off = build
                    .pc_to_native
                    .get(exp.ent_pc)
                    .copied()
                    .unwrap_or(usize::MAX);
                if native_off == usize::MAX {
                    return Err(Self::internal(format!(
                        "PE: exported function `{}` (bc PC {}) doesn't \
                     align with any native instruction",
                        exp.name, exp.ent_pc
                    )));
                }
                entries.push((exp.name.clone(), text_body_rva + native_off as u32));
            }
            for d in &build.dynamic_exports {
                if entries.iter().any(|(n, _)| n == &d.name) {
                    continue;
                }
                let rva = match d.section {
                    super::DynamicExportSection::Text => text_body_rva + d.offset as u32,
                    super::DynamicExportSection::Data => {
                        if !l.data_present {
                            return Err(Self::internal(format!(
                                "PE: data export `{}` without a .data section",
                                d.name
                            )));
                        }
                        self.data_off_to_rva(d.offset as u32)
                    }
                };
                entries.push((d.name.clone(), rva));
            }
            build_export_directory(edata_rva, entries, build.shared_lib_name.as_deref())?
        } else {
            Vec::new()
        };
        let edata_raw_size = if edata_present {
            round_up(edata_bytes.len() as u32, FILE_ALIGNMENT)
        } else {
            0
        };
        let l = &mut self.layout;
        l.text_abs_fields = text_abs_fields;
        l.tls_sites = tls_sites;
        l.reloc_rva = reloc_rva;
        l.reloc_file_off = reloc_file_off;
        l.reloc_bytes = reloc_bytes;
        l.reloc_raw_size = reloc_raw_size;
        l.edata_rva = edata_rva;
        l.edata_file_off = edata_file_off;
        l.edata_bytes = edata_bytes;
        l.edata_raw_size = edata_raw_size;
        Ok(())
    }

    /// The DWARF sections past the last loaded one, each named through the
    /// COFF string table (`/<offset>`, the mingw-w64 convention for names
    /// over 8 bytes, with `number_of_symbols = 0` unless the trampoline
    /// symbols below are present) and `MEM_DISCARDABLE`; then the COFF
    /// symbol table naming each PLT trampoline, which a debugger's `b
    /// malloc` resolves to, and its string table at the file tail, each
    /// with the sizes the headers read.
    fn layout_dwarf_and_coff(&mut self) {
        let build = self.build;
        let text_body_rva = self.text_body_rva();
        let l = &mut self.layout;
        l.pre_dwarf_end_file_off = if l.edata_present {
            l.edata_file_off + l.edata_raw_size
        } else if l.reloc_present {
            l.reloc_file_off + l.reloc_raw_size
        } else if l.data_present || !l.named_out.is_empty() {
            l.named_file_end
        } else {
            l.rdata_file_off + l.rdata_raw_size
        };
        l.pre_dwarf_end_rva = if l.edata_present {
            l.edata_rva + l.edata_bytes.len() as u32
        } else if l.reloc_present {
            l.reloc_rva + l.reloc_bytes.len() as u32
        } else if l.data_present || !l.named_out.is_empty() {
            l.named_rva_end
        } else if l.rdata_present {
            l.rdata_rva + l.rdata_size
        } else {
            l.idata_rva + l.idata.bytes.len() as u32
        };
        let emit_plt_coff_symbols = !build.plt_trampoline_offsets.is_empty();
        let need_coff_strtab = l.dwarf_present || emit_plt_coff_symbols;
        let mut coff_strtab: Vec<u8> = Vec::new();
        if need_coff_strtab {
            coff_strtab.extend_from_slice(&0u32.to_le_bytes());
        }
        let mut dwarf_sections: Vec<DwarfPeSlot> = Vec::new();
        if l.dwarf_present {
            let mut next_rva = round_up(l.pre_dwarf_end_rva, SECTION_ALIGNMENT);
            let mut next_file_off = l.pre_dwarf_end_file_off;
            for (long_name, bytes) in l.dwarf_blobs.iter() {
                if bytes.is_empty() {
                    continue;
                }
                let strtab_offset = coff_strtab.len() as u32;
                coff_strtab.extend_from_slice(long_name.as_bytes());
                coff_strtab.push(0);
                let mut name_field = [0u8; 8];
                let formatted = format!("/{strtab_offset}");
                let n = formatted.len().min(8);
                name_field[..n].copy_from_slice(&formatted.as_bytes()[..n]);
                let raw_size = round_up(bytes.len() as u32, FILE_ALIGNMENT);
                dwarf_sections.push(DwarfPeSlot {
                    name: name_field,
                    rva: next_rva,
                    file_off: next_file_off,
                    bytes: bytes.clone(),
                });
                next_rva = round_up(next_rva + raw_size, SECTION_ALIGNMENT);
                next_file_off += raw_size;
            }
        }
        l.dwarf_end_file_off = dwarf_sections
            .last()
            .map(|s| s.file_off + round_up(s.bytes.len() as u32, FILE_ALIGNMENT))
            .unwrap_or(l.pre_dwarf_end_file_off);
        l.dwarf_end_rva = dwarf_sections
            .last()
            .map(|s| round_up(s.rva + s.bytes.len() as u32, SECTION_ALIGNMENT))
            .unwrap_or(l.pre_dwarf_end_rva);
        l.dwarf_sections = dwarf_sections;
        // One `IMAGE_SYMBOL` per trampoline, `IMAGE_SYM_CLASS_EXTERNAL` so
        // name lookups keep it (some tool versions filter STATIC out of `b
        // malloc`).
        let mut coff_symbols: Vec<u8> = Vec::new();
        if emit_plt_coff_symbols {
            for (imp, off) in build
                .imports
                .imports
                .iter()
                .zip(build.plt_trampoline_offsets.iter())
            {
                let Some(tramp_offset) = *off else {
                    continue;
                };
                let trampoline_rva = text_body_rva + tramp_offset as u32;
                let mut name_field = [0u8; 8];
                let name_bytes = imp.local_name.as_bytes();
                if name_bytes.len() <= 8 {
                    name_field[..name_bytes.len()].copy_from_slice(name_bytes);
                } else {
                    let strtab_offset = coff_strtab.len() as u32;
                    coff_strtab.extend_from_slice(name_bytes);
                    coff_strtab.push(0);
                    name_field[0..4].copy_from_slice(&0u32.to_le_bytes());
                    name_field[4..8].copy_from_slice(&strtab_offset.to_le_bytes());
                }
                coff_symbols.extend_from_slice(&name_field);
                coff_symbols.extend_from_slice(&trampoline_rva.to_le_bytes());
                coff_symbols.extend_from_slice(&1u16.to_le_bytes()); // .text = section 1
                coff_symbols.extend_from_slice(&IMAGE_SYM_TYPE_FUNCTION.to_le_bytes());
                coff_symbols.push(IMAGE_SYM_CLASS_EXTERNAL);
                coff_symbols.push(0); // no aux entries
            }
        }
        if need_coff_strtab {
            let strtab_size = coff_strtab.len() as u32;
            coff_strtab[..4].copy_from_slice(&strtab_size.to_le_bytes());
        }
        l.coff_symtab_file_off = if need_coff_strtab {
            l.dwarf_end_file_off
        } else {
            0
        };
        l.coff_strtab_file_off = if need_coff_strtab {
            l.coff_symtab_file_off + coff_symbols.len() as u32
        } else {
            0
        };
        l.total_file_size =
            (l.dwarf_end_file_off + coff_symbols.len() as u32 + coff_strtab.len() as u32) as usize;
        l.image_size = if l.dwarf_present {
            l.dwarf_end_rva
        } else if l.edata_present {
            round_up(l.edata_rva + l.edata_bytes.len() as u32, SECTION_ALIGNMENT)
        } else if l.reloc_present {
            round_up(l.reloc_rva + l.reloc_bytes.len() as u32, SECTION_ALIGNMENT)
        } else if l.data_present || !l.named_out.is_empty() {
            round_up(l.named_rva_end, SECTION_ALIGNMENT)
        } else if l.rdata_present {
            round_up(l.rdata_rva + l.rdata_size, SECTION_ALIGNMENT)
        } else {
            round_up(l.idata_rva + l.idata.bytes.len() as u32, SECTION_ALIGNMENT)
        };
        l.coff_strtab = coff_strtab;
        l.coff_symbols = coff_symbols;
    }

    /// `.text`: the entry stub, an `int3` pad, `build.text`, with every
    /// fixup applied.
    fn build_text(&mut self) -> Result<(), C5Error> {
        let build = self.build;
        let machine = self.machine;
        let l = &self.layout;
        let text_rva = l.text_rva;
        let prologue = self.text_prologue_len;
        let mut text: Vec<u8> = Vec::with_capacity(l.text_size as usize);
        text.extend_from_slice(&self.stub.bytes);
        text.resize(prologue as usize, 0xCC);
        text.extend_from_slice(&build.text);
        if !build.rodata.abs64.is_empty() {
            return Err(Self::internal(String::from(
                "PE: absolute table slots reached a final-image build",
            )));
        }
        if let Some(call_off) = self.stub.direct_call_main_offset {
            patch_direct_call(
                machine,
                &mut text,
                call_off,
                prologue + build.entry_offset as u32,
            )?;
        }
        for &(call_off, name) in &self.stub.direct_call_runtime {
            let target = runtime_symbol_offset(build, name)?;
            patch_direct_call(machine, &mut text, call_off, prologue + target)?;
        }
        for f in &build.got_fixups {
            let instr_off = (f.instr_offset as u32) + prologue;
            let target_rva = l.idata.iat_rva_for_import[f.import_index];
            if f.is_data_load && machine == Machine::X86_64 {
                crate::c5::codegen::require_whole_addr(f.part, "PE: IAT data load")?;
                patch_iat_data_load(machine, &mut text, instr_off, text_rva, target_rva)?;
            } else {
                patch_iat_lookup(machine, &mut text, instr_off, text_rva, target_rva, f.part)?;
            }
        }
        if !build.got_base_fixups.is_empty() {
            return Err(C5Error::Compile(crate::c5::error::fmt_link_diag(
                Code::OBJECT_FORMAT,
                "`_GLOBAL_OFFSET_TABLE_` names an ELF construct; a PE image has no GOT",
            )));
        }
        for f in &build.data_fixups {
            let instr_off = (f.instr_offset as u32) + prologue;
            let target_rva = self.data_off_to_rva(f.data_offset as u32);
            patch_addr_load(machine, &mut text, instr_off, text_rva, target_rva, f.part)?;
        }
        for f in &build.func_fixups {
            let instr_off = (f.instr_offset as u32) + prologue;
            let target_rva = text_rva + prologue + f.target_native_offset as u32;
            patch_addr_load(machine, &mut text, instr_off, text_rva, target_rva, f.part)?;
        }
        for r in &build.text_pcrel_relocs {
            let site = r.site_text_offset as usize + prologue as usize;
            let width = r.width as usize;
            if site + width > text.len() {
                return Err(Self::internal(format!(
                    "PE: text pcrel field {site:#x} past end of .text ({})",
                    text.len()
                )));
            }
            let site_rva = text_rva as i64 + site as i64;
            let value = self.data_off_to_rva(r.target_data_offset as u32) as i64 - site_rva;
            if width == 8 {
                text[site..site + 8].copy_from_slice(&value.to_le_bytes());
            } else {
                let Ok(v) = i32::try_from(value) else {
                    return Err(Self::internal(format!(
                        "PE: text pcrel field {site:#x}: displacement {value:#x} exceeds 32 bits"
                    )));
                };
                text[site..site + 4].copy_from_slice(&v.to_le_bytes());
            }
        }
        for f in &l.text_abs_fields {
            let width = f.width as usize;
            if f.site_off + width > text.len() {
                return Err(Self::internal(format!(
                    "PE: text absolute field {:#x} past end of .text ({})",
                    f.site_off,
                    text.len()
                )));
            }
            let value = IMAGE_BASE as i64 + f.target_rva as i64;
            if !f.check.admits(value, f.width) {
                return Err(C5Error::Compile(crate::c5::error::fmt_link_diag(
                    Code::RELOCATION,
                    &format!(
                        "relocation truncated to fit: .text+{:#x} needs the absolute address {value:#x}, \
                     which does not fit a {width}-byte field",
                        f.site_off,
                    ),
                )));
            }
            text[f.site_off..f.site_off + width].copy_from_slice(&value.to_le_bytes()[..width]);
        }
        let jt_rva = l.rdata_rva + l.jt_base_in_rdata;
        for f in &build.rodata.addr_fixups {
            let instr_off = (f.code_offset as u32) + prologue;
            let target_rva = jt_rva + f.rodata_offset as u32;
            patch_addr_load(
                machine,
                &mut text,
                instr_off,
                text_rva,
                target_rva,
                AddrPart::Whole,
            )?;
        }
        let mut jt_bytes = build.rodata.bytes.clone();
        image::patch_jump_table(
            "PE",
            "rodata rel32",
            &mut jt_bytes,
            IMAGE_BASE + (text_rva + prologue) as u64,
            IMAGE_BASE + jt_rva as u64,
            &build.rodata.rel32,
        )?;
        if !build.tls_index_fixups.is_empty() {
            let tls_index_rva = l.data_rva + l.tls.tls_index_offset_in_data;
            for f in &build.tls_index_fixups {
                let instr_off = (f.instr_offset as u32) + prologue;
                patch_tls_index_lookup(machine, &mut text, instr_off, text_rva, tls_index_rva)?;
            }
        }
        self.text_bytes = text;
        self.jt_bytes = jt_bytes;
        Ok(())
    }

    /// `AddressOfEntryPoint`: the stub at the start of `.text`, or the
    /// user's body when `--shared` output defines `DllMain` or a
    /// passthrough subsystem invokes the entry directly.
    fn entry_rva(&self) -> Result<u32, C5Error> {
        let build = self.build;
        let l = &self.layout;
        if let Some(pc) = build.dllmain_pc.filter(|_| self.is_dll) {
            let off = build.pc_to_native.get(pc).copied().ok_or_else(|| {
                Self::internal(format!(
                    "PE writer: user-defined DllMain at ent_pc {pc} \
                     has no entry in pc_to_native -- the lowering \
                     dropped the function?"
                ))
            })?;
            Ok(l.text_rva + self.text_prologue_len + off as u32)
        } else if self.passthrough_entry {
            Ok(l.text_rva + self.text_prologue_len + build.entry_offset as u32)
        } else {
            Ok(l.text_rva)
        }
    }

    /// The DOS header and stub, the PE signature, the COFF and optional
    /// headers, and the section table, whose length is checked against the
    /// plan the header size and the COFF count were computed from.
    fn emit_headers(&mut self) -> Result<(), C5Error> {
        let build = self.build;
        let l = &self.layout;
        let entry_rva = self.entry_rva()?;
        let mut out: Vec<u8> = Vec::with_capacity(l.total_file_size);
        write_dos_header_and_stub(&mut out);
        write_pe_signature(&mut out);
        write_coff_header(
            &mut out,
            OPTIONAL64_HEADER_SIZE,
            self.machine,
            l.plan.count(),
            l.coff_symtab_file_off,
            (l.coff_symbols.len() as u32) / IMAGE_SYMBOL_SIZE,
            l.coff_strtab_file_off,
            self.is_dll,
        );
        let (tls_table_rva, tls_table_size) = if !build.tls_data.is_empty() {
            (
                l.data_rva + l.tls.directory_offset_in_data,
                IMAGE_TLS_DIRECTORY64_SIZE,
            )
        } else {
            (0, 0)
        };
        let reloc_size = l.reloc_bytes.len() as u32;
        write_optional_header(
            &mut out,
            OptionalHeaderInputs {
                entry_rva,
                base_of_code: l.text_rva,
                size_of_code: l.text_size,
                size_of_initialized_data: l.idata.bytes.len() as u32
                    + l.rdata_size
                    + l.data_size
                    + reloc_size,
                size_of_image: l.image_size,
                size_of_headers: l.headers_size,
                import_table_rva: l.idata.import_directory_rva,
                import_table_size: l.idata.import_directory_size,
                exception_table_rva: l.pdata_rva,
                exception_table_size: l.pdata_directory_size,
                base_reloc_rva: l.reloc_rva,
                base_reloc_size: reloc_size,
                iat_rva: l.idata.iat_rva_base,
                iat_size: l.idata.iat_size,
                tls_table_rva,
                tls_table_size,
                export_table_rva: l.edata_rva,
                export_table_size: l.edata_bytes.len() as u32,
                subsystem: self.subsystem,
            },
        );
        write_section_headers(&mut out, &self.section_headers()?);
        self.out = out;
        Ok(())
    }

    /// One header per section, in the plan's order.
    fn section_headers(&self) -> Result<Vec<SectionHeader>, C5Error> {
        let l = &self.layout;
        let reloc_size = l.reloc_bytes.len() as u32;
        let mut sections: Vec<SectionHeader> = Vec::with_capacity(l.plan.count());
        sections.push(SectionHeader {
            name: *b".text\0\0\0",
            virtual_size: l.text_size,
            virtual_address: l.text_rva,
            size_of_raw_data: l.text_raw_size,
            pointer_to_raw_data: l.text_file_off,
            characteristics: IMAGE_SCN_CNT_CODE | IMAGE_SCN_MEM_EXECUTE | IMAGE_SCN_MEM_READ,
        });
        sections.push(SectionHeader {
            name: *b".pdata\0\0",
            virtual_size: l.pdata_bytes.len() as u32,
            virtual_address: l.pdata_rva,
            size_of_raw_data: l.pdata_raw_size,
            pointer_to_raw_data: l.pdata_file_off,
            characteristics: IMAGE_SCN_CNT_INITIALIZED_DATA | IMAGE_SCN_MEM_READ,
        });
        sections.push(SectionHeader {
            name: *b".idata\0\0",
            virtual_size: l.idata.bytes.len() as u32,
            virtual_address: l.idata_rva,
            size_of_raw_data: l.idata_raw_size,
            pointer_to_raw_data: l.idata_file_off,
            characteristics: IMAGE_SCN_CNT_INITIALIZED_DATA
                | IMAGE_SCN_MEM_READ
                | IMAGE_SCN_MEM_WRITE,
        });
        if l.rdata_present {
            sections.push(SectionHeader {
                name: *b".rdata\0\0",
                virtual_size: l.rdata_size,
                virtual_address: l.rdata_rva,
                size_of_raw_data: l.rdata_raw_size,
                pointer_to_raw_data: l.rdata_file_off,
                characteristics: IMAGE_SCN_CNT_INITIALIZED_DATA | IMAGE_SCN_MEM_READ,
            });
        }
        if l.data_present {
            sections.push(SectionHeader {
                name: *b".data\0\0\0",
                virtual_size: l.data_vsize,
                virtual_address: l.data_rva,
                size_of_raw_data: l.data_raw_size,
                pointer_to_raw_data: l.data_file_off,
                characteristics: IMAGE_SCN_CNT_INITIALIZED_DATA
                    | IMAGE_SCN_MEM_READ
                    | IMAGE_SCN_MEM_WRITE,
            });
        }
        // Read-only families keep `.rdata`'s protection, the writable ones
        // `.data`'s.
        for n in &l.named_out {
            let mut name = [0u8; 8];
            let bytes = n.name.as_bytes();
            name[..bytes.len().min(8)].copy_from_slice(&bytes[..bytes.len().min(8)]);
            let writable = matches!(n.family, NamedFamily::Data | NamedFamily::Bss);
            let zerofill = n.family == NamedFamily::Bss;
            sections.push(SectionHeader {
                name,
                virtual_size: n.size,
                virtual_address: n.rva,
                size_of_raw_data: n.raw_size,
                pointer_to_raw_data: n.file_off,
                characteristics: if zerofill {
                    IMAGE_SCN_CNT_UNINITIALIZED_DATA
                } else {
                    IMAGE_SCN_CNT_INITIALIZED_DATA
                } | IMAGE_SCN_MEM_READ
                    | if writable { IMAGE_SCN_MEM_WRITE } else { 0 },
            });
        }
        if l.reloc_present {
            sections.push(SectionHeader {
                name: *b".reloc\0\0",
                virtual_size: reloc_size,
                virtual_address: l.reloc_rva,
                size_of_raw_data: l.reloc_raw_size,
                pointer_to_raw_data: l.reloc_file_off,
                characteristics: IMAGE_SCN_CNT_INITIALIZED_DATA
                    | IMAGE_SCN_MEM_READ
                    | IMAGE_SCN_MEM_DISCARDABLE,
            });
        }
        if l.edata_present {
            sections.push(SectionHeader {
                name: *b".edata\0\0",
                virtual_size: l.edata_bytes.len() as u32,
                virtual_address: l.edata_rva,
                size_of_raw_data: l.edata_raw_size,
                pointer_to_raw_data: l.edata_file_off,
                characteristics: IMAGE_SCN_CNT_INITIALIZED_DATA | IMAGE_SCN_MEM_READ,
            });
        }
        for slot in &l.dwarf_sections {
            sections.push(SectionHeader {
                name: slot.name,
                virtual_size: slot.bytes.len() as u32,
                virtual_address: slot.rva,
                size_of_raw_data: round_up(slot.bytes.len() as u32, FILE_ALIGNMENT),
                pointer_to_raw_data: slot.file_off,
                characteristics: IMAGE_SCN_CNT_INITIALIZED_DATA
                    | IMAGE_SCN_MEM_READ
                    | IMAGE_SCN_MEM_DISCARDABLE,
            });
        }
        if sections.len() != l.plan.count() {
            return Err(Self::internal(format!(
                "PE: emitted {} section headers, layout reserved {}",
                sections.len(),
                l.plan.count()
            )));
        }
        Ok(sections)
    }

    /// Every section body at its file offset.
    fn bake_data_image(&self) -> Result<Vec<u8>, C5Error> {
        image::bake_data_relocs(
            "PE",
            "the relocated data span",
            self.build,
            self.layout.ro_len as u64,
            IMAGE_BASE + self.text_body_rva() as u64,
            &|off| IMAGE_BASE + self.data_off_to_rva(off as u32) as u64,
        )
    }

    fn emit_sections(mut self) -> Result<Vec<u8>, C5Error> {
        let build = self.build;
        let data = self.bake_data_image()?;
        let l = &self.layout;
        let ro_len = l.ro_len;
        let mut out = core::mem::take(&mut self.out);
        pad_to(&mut out, l.text_file_off as usize)?;
        out.extend_from_slice(&self.text_bytes);
        pad_to(&mut out, (l.text_file_off + l.text_raw_size) as usize)?;
        out.extend_from_slice(&l.pdata_bytes);
        pad_to(&mut out, (l.pdata_file_off + l.pdata_raw_size) as usize)?;
        out.extend_from_slice(&l.idata.bytes);
        pad_to(&mut out, (l.idata_file_off + l.idata_raw_size) as usize)?;
        if l.rdata_present {
            out.extend_from_slice(&build.data[..l.ro_head as usize]);
            out.extend_from_slice(&data[..l.relro_head_len as usize]);
            pad_to(&mut out, (l.rdata_file_off + l.jt_base_in_rdata) as usize)?;
            out.extend_from_slice(&self.jt_bytes);
            pad_to(
                &mut out,
                (l.rdata_file_off + l.marker_base_in_rdata) as usize,
            )?;
            out.extend_from_slice(&l.provenance);
            pad_to(&mut out, (l.rdata_file_off + l.rdata_raw_size) as usize)?;
        }
        if l.data_present {
            let head = (l.relro_size + l.data_head_len) as usize;
            out.extend_from_slice(&data[l.relro_size as usize..head]);
            if !build.tls_data.is_empty() {
                pad_to(
                    &mut out,
                    (l.data_file_off + l.tls.tls_index_offset_in_data) as usize,
                )?;
                out.extend_from_slice(&[0u8; 4]);
                pad_to(
                    &mut out,
                    (l.data_file_off + l.tls.directory_offset_in_data) as usize,
                )?;
                let tls_init_start_va =
                    IMAGE_BASE + (l.data_rva + l.tls.tls_init_offset_in_data) as u64;
                let tls_init_end_va = tls_init_start_va + build.tls_data.len() as u64;
                let tls_index_va =
                    IMAGE_BASE + (l.data_rva + l.tls.tls_index_offset_in_data) as u64;
                out.extend_from_slice(&tls_init_start_va.to_le_bytes());
                out.extend_from_slice(&tls_init_end_va.to_le_bytes());
                out.extend_from_slice(&tls_index_va.to_le_bytes());
                out.extend_from_slice(&0u64.to_le_bytes()); // AddressOfCallBacks
                out.extend_from_slice(&0u32.to_le_bytes()); // SizeOfZeroFill
                out.extend_from_slice(&0u32.to_le_bytes()); // Characteristics
                let tls = image::bake_tls_template(
                    "PE",
                    "the TLS template",
                    &build.tls_data,
                    &l.tls_sites,
                )?;
                out.extend_from_slice(&tls);
            }
        }
        for n in &l.named_out {
            if n.raw_size == 0 {
                continue;
            }
            pad_to(&mut out, n.file_off as usize)?;
            let (start, end) = (n.start as usize, (n.start + n.size) as usize);
            if n.family == NamedFamily::RoData {
                out.extend_from_slice(&build.data[start..end]);
            } else {
                let base = ro_len as usize;
                out.extend_from_slice(&data[start - base..end - base]);
            }
            pad_to(&mut out, (n.file_off + n.raw_size) as usize)?;
        }
        if l.reloc_present {
            pad_to(&mut out, l.reloc_file_off as usize)?;
            out.extend_from_slice(&l.reloc_bytes);
        }
        if l.edata_present {
            pad_to(&mut out, l.edata_file_off as usize)?;
            out.extend_from_slice(&l.edata_bytes);
        }
        for slot in &l.dwarf_sections {
            pad_to(&mut out, slot.file_off as usize)?;
            out.extend_from_slice(&slot.bytes);
        }
        if !l.coff_symbols.is_empty() {
            pad_to(&mut out, l.coff_symtab_file_off as usize)?;
            out.extend_from_slice(&l.coff_symbols);
        }
        if !l.coff_strtab.is_empty() {
            pad_to(&mut out, l.coff_strtab_file_off as usize)?;
            out.extend_from_slice(&l.coff_strtab);
        }
        pad_to(&mut out, l.total_file_size)?;
        if out.len() != l.total_file_size {
            return Err(Self::internal(format!(
                "PE layout drift: emitted {:#x} bytes, layout computed {:#x}",
                out.len(),
                l.total_file_size,
            )));
        }
        Ok(out)
    }
}

/// Build the `.reloc` section bytes.
#[repr(C)]
#[derive(Copy, Clone)]
struct ImageExportDirectory {
    characteristics: u32,
    time_date_stamp: u32,
    major_version: u16,
    minor_version: u16,
    name_rva: u32,
    ordinal_base: u32,
    number_of_functions: u32,
    number_of_names: u32,
    address_of_functions: u32,
    address_of_names: u32,
    address_of_name_ordinals: u32,
}

const IMAGE_EXPORT_DIRECTORY_SIZE: usize = 40;
const _: () = assert!(core::mem::size_of::<ImageExportDirectory>() == IMAGE_EXPORT_DIRECTORY_SIZE);

/// Build the `.edata` section bytes for an image with exports.
fn build_export_directory(
    edata_rva: u32,
    exports: Vec<(String, u32)>,
    image_name: Option<&str>,
) -> Result<Vec<u8>, C5Error> {
    let n = exports.len() as u32;
    let header_size = IMAGE_EXPORT_DIRECTORY_SIZE as u32;
    let funcs_off = header_size;
    let names_off = funcs_off + 4 * n;
    let ordinals_off = names_off + 4 * n;
    let strings_off = ordinals_off + 2 * n;

    // The image-name string heads the string blob; per-export names follow,
    // each NUL-terminated. We compute their RVAs as we go so the
    // AddressOfNames entries match.
    let dll_name = image_name.unwrap_or("c5-output.dll");
    let strings_rva = edata_rva + strings_off;
    let dll_name_rva = strings_rva;

    let mut out = Vec::with_capacity(strings_off as usize + dll_name.len() + 1);

    write_struct(
        &mut out,
        &ImageExportDirectory {
            characteristics: 0,
            time_date_stamp: 0,
            major_version: 0,
            minor_version: 0,
            name_rva: dll_name_rva,
            ordinal_base: 1,
            number_of_functions: n,
            number_of_names: n,
            address_of_functions: edata_rva + funcs_off,
            address_of_names: edata_rva + names_off,
            address_of_name_ordinals: edata_rva + ordinals_off,
        },
    );

    for (_, rva) in &exports {
        out.extend_from_slice(&rva.to_le_bytes());
    }

    // The name pointer table must be lexically ordered; the parallel
    // ordinal table maps each name back to its AddressOfFunctions slot.
    let mut by_name: Vec<usize> = (0..exports.len()).collect();
    by_name.sort_by(|&a, &b| exports[a].0.as_bytes().cmp(exports[b].0.as_bytes()));

    let mut cur = strings_rva + dll_name.len() as u32 + 1;
    for &i in &by_name {
        out.extend_from_slice(&cur.to_le_bytes());
        cur += exports[i].0.len() as u32 + 1;
    }

    for &i in &by_name {
        out.extend_from_slice(&(i as u16).to_le_bytes());
    }

    out.extend_from_slice(dll_name.as_bytes());
    out.push(0);
    for &i in &by_name {
        out.extend_from_slice(exports[i].0.as_bytes());
        out.push(0);
    }

    Ok(out)
}

/// `ro_len` is the `.rdata`-resident prefix of the data-byte space; slot
/// offsets are `.data`-relative past it.
struct AbsTextField {
    site_off: usize,
    site_rva: u32,
    width: u32,
    check: AbsCheck,
    target_rva: u32,
}

/// Width and overflow rule of the field a relocation type writes `S + A`
/// into. badc's relocatable format is ELF ET_REL on every target, so a PE
/// image's inputs carry ELF relocation numbers.
fn abs_field(machine: Machine, rtype: u32) -> Option<(u32, AbsCheck)> {
    use super::elf_reloc_types::{aarch64_abs_field, x86_64_abs_field};
    match machine {
        Machine::X86_64 => x86_64_abs_field(rtype),
        Machine::Aarch64 => aarch64_abs_field(rtype),
    }
}

#[allow(clippy::too_many_arguments)]
fn build_reloc_section(
    data_rva: u32,
    data_off_to_rva: &dyn Fn(u32) -> u32,
    tls_layout: &TlsLayout,
    tls_present: bool,
    data_relocs: &[crate::c5::program::DataReloc],
    code_relocs: &[crate::c5::program::CodeReloc],
    label_relocs: &[crate::c5::codegen::LabelReloc],
    text_abs_fields: &[AbsTextField],
    tls_sites: &[(usize, u64)],
) -> Vec<u8> {
    use alloc::collections::BTreeMap;
    let mut by_page: BTreeMap<u32, Vec<(u32, u16)>> = BTreeMap::new();
    let mut add = |rva: u32, kind: u16| {
        by_page
            .entry(rva & !0xFFF)
            .or_default()
            .push((rva & 0xFFF, kind));
    };
    if tls_present {
        let dir_rva = data_rva + tls_layout.directory_offset_in_data;
        // Sanity: the directory's three pointer fields must share a page.
        debug_assert_eq!(dir_rva & !0xFFF, (dir_rva + 16) & !0xFFF);
        add(dir_rva, IMAGE_REL_BASED_DIR64); // StartAddressOfRawData
        add(dir_rva + 8, IMAGE_REL_BASED_DIR64); // EndAddressOfRawData
        add(dir_rva + 16, IMAGE_REL_BASED_DIR64); // AddressOfIndex
        let template_rva = data_rva + tls_layout.tls_init_offset_in_data;
        for &(off, _) in tls_sites {
            add(template_rva + off as u32, IMAGE_REL_BASED_DIR64);
        }
    }
    for r in data_relocs {
        add(data_off_to_rva(r.data_offset as u32), IMAGE_REL_BASED_DIR64);
    }
    for r in code_relocs {
        add(data_off_to_rva(r.data_offset as u32), IMAGE_REL_BASED_DIR64);
    }
    // `&&label` initializers hold a code pointer in the data stream, so
    // they take the same DIR64 entry.
    for r in label_relocs {
        add(data_off_to_rva(r.data_offset as u32), IMAGE_REL_BASED_DIR64);
    }
    // Absolute fields in the code section. `.reloc` covers every section,
    // so the loader rebases these like a data pointer; the entry type
    // follows the field's width.
    for f in text_abs_fields {
        let kind = if f.width == 8 {
            IMAGE_REL_BASED_DIR64
        } else {
            IMAGE_REL_BASED_HIGHLOW
        };
        add(f.site_rva, kind);
    }

    let mut out = Vec::new();
    for (page_rva, mut entries) in by_page {
        entries.sort_unstable();
        // Each entry is u16; SizeOfBlock must be 4-byte aligned.
        let needs_pad = !entries.len().is_multiple_of(2);
        let total_entries = entries.len() + if needs_pad { 1 } else { 0 };
        let size_of_block = 8 + total_entries as u32 * 2;
        out.extend_from_slice(&page_rva.to_le_bytes());
        out.extend_from_slice(&size_of_block.to_le_bytes());
        for (off, kind) in entries {
            let entry = kind | off as u16;
            out.extend_from_slice(&entry.to_le_bytes());
        }
        if needs_pad {
            out.extend_from_slice(&IMAGE_REL_BASED_ABSOLUTE.to_le_bytes());
        }
    }
    out
}

/// Per-`.data` offsets for the trio of TLS support structures (the
/// `_tls_index` slot, the `IMAGE_TLS_DIRECTORY64`, and the initialised TLS
/// image).
#[derive(Default)]
struct TlsLayout {
    tls_blob_size: u32,
    tls_index_offset_in_data: u32,
    directory_offset_in_data: u32,
    tls_init_offset_in_data: u32,
}

fn compute_tls_layout(build: &Build, writable_data_size: u32) -> TlsLayout {
    if build.tls_data.is_empty() {
        return TlsLayout {
            tls_blob_size: 0,
            tls_index_offset_in_data: 0,
            directory_offset_in_data: 0,
            tls_init_offset_in_data: 0,
        };
    }
    let user_data_end = writable_data_size;
    let tls_index_offset = round_up(user_data_end, 4);
    let directory_offset = round_up(tls_index_offset + 4, 8);
    let tls_init_offset = directory_offset + IMAGE_TLS_DIRECTORY64_SIZE;
    // We emit the entire `tls_data` as the template (see the long comment
    // in `write` next to the IMAGE_TLS_DIRECTORY64 emission), so the .data
    // tail contributed by TLS is `tls_data.len()` bytes regardless of
    // `tls_init_size`.
    let total = tls_init_offset + build.tls_data.len() as u32;
    TlsLayout {
        tls_blob_size: total - user_data_end,
        tls_index_offset_in_data: tls_index_offset,
        directory_offset_in_data: directory_offset,
        tls_init_offset_in_data: tls_init_offset,
    }
}

/// Patch the TLS-index lookup at `instr_offset`.
fn patch_tls_index_lookup(
    machine: Machine,
    text: &mut [u8],
    instr_offset_in_text: u32,
    text_section_rva: u32,
    target_rva: u32,
) -> Result<(), C5Error> {
    let instr_rva = text_section_rva + instr_offset_in_text;
    match machine {
        Machine::X86_64 => {
            let after_rva = instr_rva + 6;
            patch_x86_64_disp32(
                text,
                (instr_offset_in_text + 2) as usize,
                after_rva,
                target_rva,
            )
        }
        Machine::Aarch64 => {
            patch_aarch64_adrp_ldr32(text, instr_offset_in_text, instr_rva, target_rva)
        }
    }
}

/// AArch64 `adrp xd, _; ldr wd, [xd, #_]` patcher -- mirrors
/// [`patch_aarch64_adrp_ldr`] but for the 32-bit (`ldr w`) load form used
/// by the TLS-index lookup.
fn patch_aarch64_adrp_ldr32(
    text: &mut [u8],
    adrp_offset_in_text: u32,
    adrp_rva: u32,
    target_rva: u32,
) -> Result<(), C5Error> {
    aarch64::patch::patch_slot_load(
        text,
        adrp_offset_in_text as usize,
        adrp_rva as i64,
        target_rva as i64,
        aarch64::patch::SlotWidth::W32,
    )
    .map_err(|e| {
        C5Error::Compile(crate::c5::error::fmt_internal_diag(
            Code::INTERNAL,
            &e.describe("PE: aarch64 TLS index"),
        ))
    })
}

/// On-disk shape of the DOS header + 64-byte stub.
#[repr(C)]
#[derive(Copy, Clone)]
struct DosHeader {
    e_magic: [u8; 2],             // "MZ"
    _padding_to_lfanew: [u8; 58], // bytes 2..60 left zero
    e_lfanew: u32,                // file offset of the PE signature (== 128)
    _stub: [u8; 64],              // 64-byte real-mode stub, all zeros
}

const _: () = assert!(core::mem::size_of::<DosHeader>() == DOS_HEADER_AND_STUB);

/// COFF File Header (NT-style).
#[repr(C)]
#[derive(Copy, Clone)]
struct CoffHeader {
    machine: u16,
    number_of_sections: u16,
    time_date_stamp: u32,
    pointer_to_symbol_table: u32,
    number_of_symbols: u32,
    size_of_optional_header: u16,
    characteristics: u16,
}

const _: () = assert!(core::mem::size_of::<CoffHeader>() == COFF_HEADER_SIZE);

/// One slot of the Optional Header's Data Directories array (16 fixed
/// slots: Export, Import, Resource, Exception, ..., IAT, ...).
#[repr(C)]
#[derive(Copy, Clone)]
struct DataDirectoryEntry {
    rva: u32,
    size: u32,
}

/// PE32+ Optional Header (240 bytes).
#[repr(C)]
#[derive(Copy, Clone)]
struct OptionalHeader64 {
    magic: u16,
    major_linker_version: u8,
    minor_linker_version: u8,
    size_of_code: u32,
    size_of_initialized_data: u32,
    size_of_uninitialized_data: u32,
    address_of_entry_point: u32,
    base_of_code: u32,
    image_base: u64,
    section_alignment: u32,
    file_alignment: u32,
    major_operating_system_version: u16,
    minor_operating_system_version: u16,
    major_image_version: u16,
    minor_image_version: u16,
    major_subsystem_version: u16,
    minor_subsystem_version: u16,
    win32_version_value: u32,
    size_of_image: u32,
    size_of_headers: u32,
    checksum: u32,
    subsystem: u16,
    dll_characteristics: u16,
    size_of_stack_reserve: u64,
    size_of_stack_commit: u64,
    size_of_heap_reserve: u64,
    size_of_heap_commit: u64,
    loader_flags: u32,
    number_of_rva_and_sizes: u32,
    data_directory: [DataDirectoryEntry; NUM_DATA_DIRS as usize],
}

const _: () = assert!(core::mem::size_of::<OptionalHeader64>() == OPTIONAL64_HEADER_SIZE);

/// One section table entry (40 bytes).
#[repr(C)]
#[derive(Copy, Clone)]
struct SectionHeaderRaw {
    name: [u8; 8],
    virtual_size: u32,
    virtual_address: u32,
    size_of_raw_data: u32,
    pointer_to_raw_data: u32,
    pointer_to_relocations: u32,
    pointer_to_line_numbers: u32,
    number_of_relocations: u16,
    number_of_line_numbers: u16,
    characteristics: u32,
}

const _: () = assert!(core::mem::size_of::<SectionHeaderRaw>() == SECTION_HEADER_SIZE);

fn write_dos_header_and_stub(out: &mut Vec<u8>) {
    write_struct(
        out,
        &DosHeader {
            e_magic: *b"MZ",
            _padding_to_lfanew: [0; 58],
            e_lfanew: DOS_HEADER_AND_STUB as u32,
            _stub: [0; 64],
        },
    );
}

fn write_pe_signature(out: &mut Vec<u8>) {
    out.extend_from_slice(b"PE\0\0");
}

#[allow(clippy::too_many_arguments)]
fn write_coff_header(
    out: &mut Vec<u8>,
    optional_header_size: usize,
    machine: Machine,
    n_sections: usize,
    coff_symtab_file_off: u32,
    n_coff_symbols: u32,
    coff_strtab_file_off: u32,
    is_dll: bool,
) {
    let _ = coff_strtab_file_off;
    let machine_id = match machine {
        Machine::X86_64 => IMAGE_FILE_MACHINE_AMD64,
        Machine::Aarch64 => IMAGE_FILE_MACHINE_ARM64,
    };
    let mut characteristics = IMAGE_FILE_EXECUTABLE_IMAGE | IMAGE_FILE_LARGE_ADDRESS_AWARE;
    if is_dll {
        characteristics |= IMAGE_FILE_DLL;
    }
    write_struct(
        out,
        &CoffHeader {
            machine: machine_id,
            number_of_sections: n_sections as u16,
            time_date_stamp: 0,
            // PE images carry a COFF strtab at the file tail so the long
            // DWARF section names ("/<offset>") resolve.
            pointer_to_symbol_table: coff_symtab_file_off,
            number_of_symbols: n_coff_symbols,
            size_of_optional_header: optional_header_size as u16,
            characteristics,
        },
    );
}

struct OptionalHeaderInputs {
    entry_rva: u32,
    base_of_code: u32,
    size_of_code: u32,
    size_of_initialized_data: u32,
    size_of_image: u32,
    size_of_headers: u32,
    import_table_rva: u32,
    import_table_size: u32,
    exception_table_rva: u32,
    exception_table_size: u32,
    base_reloc_rva: u32,
    base_reloc_size: u32,
    iat_rva: u32,
    iat_size: u32,
    tls_table_rva: u32,
    tls_table_size: u32,
    export_table_rva: u32,
    export_table_size: u32,
    subsystem: u16,
}

fn write_optional_header(out: &mut Vec<u8>, inp: OptionalHeaderInputs) {
    // OS version 4.0, Subsystem 5.2: copied from mingw's minimal exe.
    // Bumping to 10.0 (which we tried first) caused CreateProcess to reject
    // our images with ERROR_BAD_EXE_FORMAT on real Windows, even though
    // wine on Linux tolerated it.
    let dll_chars = IMAGE_DLLCHARACTERISTICS_DYNAMIC_BASE
        | IMAGE_DLLCHARACTERISTICS_HIGH_ENTROPY_VA
        | IMAGE_DLLCHARACTERISTICS_NX_COMPAT
        | IMAGE_DLLCHARACTERISTICS_NO_SEH;

    let mut data_directory = [DataDirectoryEntry { rva: 0, size: 0 }; NUM_DATA_DIRS as usize];
    data_directory[DATA_DIRECTORY_IMPORT] = DataDirectoryEntry {
        rva: inp.import_table_rva,
        size: inp.import_table_size,
    };
    data_directory[DATA_DIRECTORY_EXPORT] = DataDirectoryEntry {
        rva: inp.export_table_rva,
        size: inp.export_table_size,
    };
    data_directory[DATA_DIRECTORY_EXCEPTION] = DataDirectoryEntry {
        rva: inp.exception_table_rva,
        size: inp.exception_table_size,
    };
    data_directory[DATA_DIRECTORY_BASERELOC] = DataDirectoryEntry {
        rva: inp.base_reloc_rva,
        size: inp.base_reloc_size,
    };
    data_directory[DATA_DIRECTORY_TLS] = DataDirectoryEntry {
        rva: inp.tls_table_rva,
        size: inp.tls_table_size,
    };
    data_directory[DATA_DIRECTORY_IAT] = DataDirectoryEntry {
        rva: inp.iat_rva,
        size: inp.iat_size,
    };

    write_struct(
        out,
        &OptionalHeader64 {
            magic: PE32_PLUS_MAGIC,
            major_linker_version: 14,
            minor_linker_version: 0,
            size_of_code: inp.size_of_code,
            size_of_initialized_data: inp.size_of_initialized_data,
            size_of_uninitialized_data: 0,
            address_of_entry_point: inp.entry_rva,
            base_of_code: inp.base_of_code,
            image_base: IMAGE_BASE,
            section_alignment: SECTION_ALIGNMENT,
            file_alignment: FILE_ALIGNMENT,
            // Windows 6.0 (Vista) is the earliest version that supports the
            // modern PE security characteristics this image opts into
            // (DYNAMIC_BASE + NX_COMPAT + HIGH_ENTROPY_VA). The previous
            // 4.0 / 5.2 values (NT 4.0 + Windows Server 2003) leave the
            // loader in a legacy code path that refuses to dispatch
            // HIGH_ENTROPY_VA images on real Windows 10+; wine ignored the
            // field and ran the binary anyway.
            major_operating_system_version: 6,
            minor_operating_system_version: 0,
            major_image_version: 0,
            minor_image_version: 0,
            major_subsystem_version: 6,
            minor_subsystem_version: 0,
            win32_version_value: 0,
            size_of_image: inp.size_of_image,
            size_of_headers: inp.size_of_headers,
            checksum: 0,
            subsystem: inp.subsystem,
            dll_characteristics: dll_chars,
            // PE/COFF specifies `SizeOfStackReserve` as the
            // committed-on-demand virtual range reserved for the initial
            // thread's stack (cleared by the loader; no physical backing
            // until each page faults in). MSVC's link.exe defaults to 1
            // MiB; mingw's ld defaults to 8 MiB, matching glibc / Apple
            // libc thread defaults. c5 uses the mingw default so portable
            // programs that exercise recursion to a depth tuned for the
            // Linux / macOS C stack budget don't fault the guard page on
            // Windows before whatever in-program counter would otherwise
            // enforce the recursion limit.
            size_of_stack_reserve: 0x80_0000, // 8 MiB
            size_of_stack_commit: 0x1000,
            size_of_heap_reserve: 0x10_0000,
            size_of_heap_commit: 0x1000,
            loader_flags: 0,
            number_of_rva_and_sizes: NUM_DATA_DIRS,
            data_directory,
        },
    );
}

/// Caller-side view of a section the writer is about to emit.
struct SectionHeader {
    name: [u8; 8],
    virtual_size: u32,
    virtual_address: u32,
    size_of_raw_data: u32,
    pointer_to_raw_data: u32,
    characteristics: u32,
}

fn write_section_headers(out: &mut Vec<u8>, sections: &[SectionHeader]) {
    for sec in sections {
        write_struct(
            out,
            &SectionHeaderRaw {
                name: sec.name,
                virtual_size: sec.virtual_size,
                virtual_address: sec.virtual_address,
                size_of_raw_data: sec.size_of_raw_data,
                pointer_to_raw_data: sec.pointer_to_raw_data,
                pointer_to_relocations: 0,
                pointer_to_line_numbers: 0,
                number_of_relocations: 0,
                number_of_line_numbers: 0,
                characteristics: sec.characteristics,
            },
        );
    }
}

struct DllGroup {
    dll_name: String,
    members: Vec<usize>,
}

fn group_imports_by_dll(imports: &[(String, String)]) -> Vec<DllGroup> {
    let mut groups: Vec<DllGroup> = Vec::new();
    for (idx, (_, dll)) in imports.iter().enumerate() {
        if let Some(g) = groups.iter_mut().find(|g| g.dll_name == *dll) {
            g.members.push(idx);
        } else {
            groups.push(DllGroup {
                dll_name: dll.clone(),
                members: vec![idx],
            });
        }
    }
    groups
}

#[derive(Default)]
struct IDataLayout {
    bytes: Vec<u8>,
    import_directory_rva: u32,
    import_directory_size: u32,
    iat_rva_base: u32,
    iat_size: u32,
    iat_rva_for_import: Vec<u32>,
}

fn plan_idata(dlls: &[DllGroup], imports: &[(String, String)], base_rva: u32) -> IDataLayout {
    let n_dlls = dlls.len();
    let n_imports = imports.len();

    let import_dir_off: usize = 0;
    let import_dir_size = (n_dlls + 1) * IMAGE_IMPORT_DESCRIPTOR_SIZE;

    // The IAT entries are 8-byte u64s, and the aarch64 LDR immediate is
    // scaled by 8 (so the in-page byte offset must be 8-aligned).
    let iat_off = round_up(import_dir_off + import_dir_size, 8);
    let iat_size = dlls
        .iter()
        .map(|g| (g.members.len() + 1) * IAT_ENTRY_SIZE)
        .sum::<usize>();

    let ilt_off = iat_off + iat_size;
    let ilt_size = iat_size; // mirror of IAT

    let hint_table_off = ilt_off + ilt_size;
    let mut hint_table_size = 0usize;
    let mut hint_offsets: Vec<usize> = Vec::with_capacity(n_imports);
    for (sym, _) in imports {
        hint_offsets.push(hint_table_off + hint_table_size);
        hint_table_size += 2 + sym.len() + 1;
        if hint_table_size & 1 != 0 {
            hint_table_size += 1; // align to 2
        }
    }

    let dll_strings_off = hint_table_off + hint_table_size;
    let mut dll_strings_size = 0usize;
    let mut dll_name_offsets: Vec<usize> = Vec::with_capacity(n_dlls);
    for g in dlls {
        dll_name_offsets.push(dll_strings_off + dll_strings_size);
        dll_strings_size += g.dll_name.len() + 1;
    }

    let total = dll_strings_off + dll_strings_size;
    let mut bytes = vec![0u8; total];

    let mut group_iat_offsets: Vec<usize> = Vec::with_capacity(n_dlls);
    let mut group_ilt_offsets: Vec<usize> = Vec::with_capacity(n_dlls);
    {
        let mut iat_cur = 0usize;
        let mut ilt_cur = 0usize;
        for g in dlls {
            group_iat_offsets.push(iat_cur);
            group_ilt_offsets.push(ilt_cur);
            iat_cur += (g.members.len() + 1) * IAT_ENTRY_SIZE;
            ilt_cur += (g.members.len() + 1) * IAT_ENTRY_SIZE;
        }
    }

    for (g_idx, group) in dlls.iter().enumerate() {
        let _ = group; // descriptor just needs the indexed offsets below
        let off = import_dir_off + g_idx * IMAGE_IMPORT_DESCRIPTOR_SIZE;
        let ilt_rva = base_rva + (ilt_off + group_ilt_offsets[g_idx]) as u32;
        let iat_rva = base_rva + (iat_off + group_iat_offsets[g_idx]) as u32;
        let name_rva = base_rva + dll_name_offsets[g_idx] as u32;
        bytes[off..off + 4].copy_from_slice(&ilt_rva.to_le_bytes()); // OriginalFirstThunk
        bytes[off + 4..off + 8].copy_from_slice(&0u32.to_le_bytes()); // TimeDateStamp
        bytes[off + 8..off + 12].copy_from_slice(&0u32.to_le_bytes()); // ForwarderChain
        bytes[off + 12..off + 16].copy_from_slice(&name_rva.to_le_bytes()); // Name
        bytes[off + 16..off + 20].copy_from_slice(&iat_rva.to_le_bytes()); // FirstThunk
    }

    // Write IAT and ILT entries. We layout the IAT so that
    // import_index N (in the global list) lives in slot [iat_off +
    // offset_to_global_index(N)], where the offset is chosen so the global
    // ordering is preserved (program imports first, then stub-only
    // imports).
    let mut iat_slot_for_global_index: Vec<usize> = vec![0; n_imports];
    for (g_idx, g) in dlls.iter().enumerate() {
        for (member_pos, &global_idx) in g.members.iter().enumerate() {
            iat_slot_for_global_index[global_idx] =
                iat_off + group_iat_offsets[g_idx] + member_pos * IAT_ENTRY_SIZE;
        }
    }
    for (g_idx, group) in dlls.iter().enumerate() {
        for (member_pos, &global_idx) in group.members.iter().enumerate() {
            let entry_value = base_rva + hint_offsets[global_idx] as u32; // RVA -> hint/name
            let entry = entry_value as u64; // high bit clear -> name import
            let iat_slot = iat_off + group_iat_offsets[g_idx] + member_pos * IAT_ENTRY_SIZE;
            let ilt_slot = ilt_off + group_ilt_offsets[g_idx] + member_pos * IAT_ENTRY_SIZE;
            bytes[iat_slot..iat_slot + IAT_ENTRY_SIZE].copy_from_slice(&entry.to_le_bytes());
            bytes[ilt_slot..ilt_slot + IAT_ENTRY_SIZE].copy_from_slice(&entry.to_le_bytes());
        }
    }

    for (i, (sym, _)) in imports.iter().enumerate() {
        let off = hint_offsets[i];
        bytes[off..off + 2].copy_from_slice(&0u16.to_le_bytes());
        bytes[off + 2..off + 2 + sym.len()].copy_from_slice(sym.as_bytes());
    }

    for (g_idx, g) in dlls.iter().enumerate() {
        let off = dll_name_offsets[g_idx];
        bytes[off..off + g.dll_name.len()].copy_from_slice(g.dll_name.as_bytes());
    }

    let iat_rva_for_import: Vec<u32> = iat_slot_for_global_index
        .iter()
        .map(|off| base_rva + *off as u32)
        .collect();

    // With no imported DLLs the descriptor block is a lone zero terminator
    // and the IAT is empty. Pointing the Import data directory at that
    // descriptor with a zero-size IAT directory is rejected by the Windows
    // loader (ERROR_INVALID_PARAMETER) even though wine accepts it, so
    // leave both directories empty (RVA = 0, size = 0) in that case.
    let (import_directory_rva, import_directory_size, iat_rva_base, iat_size) = if n_dlls == 0 {
        (0, 0, 0, 0)
    } else {
        (
            base_rva + import_dir_off as u32,
            import_dir_size as u32,
            base_rva + iat_off as u32,
            iat_size as u32,
        )
    };

    IDataLayout {
        bytes,
        import_directory_rva,
        import_directory_size,
        iat_rva_base,
        iat_size,
        iat_rva_for_import,
    }
}

struct EntryStub {
    bytes: Vec<u8>,
    direct_call_runtime: Vec<(u32, &'static str)>,
    direct_call_main_offset: Option<u32>,
}

impl EntryStub {
    fn empty() -> Self {
        Self {
            bytes: Vec::new(),
            direct_call_runtime: Vec::new(),
            direct_call_main_offset: None,
        }
    }
}

/// Native offset within `build.text` of a runtime helper the entry stub
/// direct-calls.
fn runtime_symbol_offset(build: &Build, name: &str) -> Result<u32, C5Error> {
    let idx = build
        .func_names
        .iter()
        .position(|n| n == name)
        .ok_or_else(|| {
            C5Error::Compile(crate::c5::error::fmt_link_diag(
                Code::UNDEFINED_SYMBOL,
                &format!(
                    "PE entry stub references `{name}`, which the linked runtime does not define"
                ),
            ))
        })?;
    let ent_pc = build.func_ent_pcs[idx];
    Ok(build.pc_to_native[ent_pc] as u32)
}

fn build_entry_stub(machine: Machine, is_dll: bool) -> EntryStub {
    if is_dll {
        return build_dllmain_stub(machine);
    }
    // The main / wmain / WinMain / wWinMain distinction lives in
    // `__c5_entry` (gated by `__BADC_WIN_WINMAIN__` / `__BADC_WIN_WIDE__`
    // in the runtime TU, following the entry symbol), so the adapter is
    // uniform across subsystems.
    build_entry_adapter(machine)
}

/// Minimal `DllMain` for shared-library output.
fn build_dllmain_stub(machine: Machine) -> EntryStub {
    let bytes = match machine {
        Machine::X86_64 => vec![0xB8, 0x01, 0x00, 0x00, 0x00, 0xC3],
        Machine::Aarch64 => {
            let mov = aarch64::enc_movz(aarch64::Reg::X0, 1, 0);
            let ret_word = aarch64::enc_ret(aarch64::Reg::X30);
            let mut b = Vec::with_capacity(8);
            b.extend_from_slice(&mov.to_le_bytes());
            b.extend_from_slice(&ret_word.to_le_bytes());
            b
        }
    };
    EntryStub {
        bytes,
        direct_call_runtime: Vec::new(),
        direct_call_main_offset: None,
    }
}

/// The executable entry adapter -- a minimal per-arch shim that loads the
/// initial stack pointer and the image-base offset into the first two
/// argument registers and calls `__c5_entry`.
fn build_entry_adapter(machine: Machine) -> EntryStub {
    match machine {
        Machine::X86_64 => {
            let mut bytes: Vec<u8> = Vec::with_capacity(16);
            bytes.extend_from_slice(&[0x48, 0x89, 0xE1]); // mov rcx, rsp
            bytes.extend_from_slice(&[0x48, 0x83, 0xEC, 0x28]); // sub rsp, 0x28
            bytes.extend_from_slice(&[0x31, 0xD2]); // xor edx, edx
            let call_off = bytes.len() as u32;
            bytes.extend_from_slice(&[0xE8, 0, 0, 0, 0]); // call __c5_entry
            bytes.extend_from_slice(&[0x0F, 0x0B]); // ud2
            EntryStub {
                bytes,
                direct_call_runtime: vec![(call_off, RT_ENTRY)],
                direct_call_main_offset: None,
            }
        }
        Machine::Aarch64 => {
            use super::aarch64 as a;
            let mut bytes: Vec<u8> = Vec::with_capacity(16);
            a::emit(&mut bytes, a::enc_add_imm(a::Reg::X0, a::Reg::SP, 0));
            a::emit(&mut bytes, a::enc_movz(a::Reg::X1, 0, 0));
            let bl_off = bytes.len() as u32;
            a::emit(&mut bytes, a::enc_bl(0)); // patched to __c5_entry
            a::emit(&mut bytes, 0xD420_0020); // brk #1
            EntryStub {
                bytes,
                direct_call_runtime: vec![(bl_off, RT_ENTRY)],
                direct_call_main_offset: None,
            }
        }
    }
}

/// `.pdata` builder result.
struct Pdata {
    bytes: Vec<u8>,
    directory_size: u32,
}

/// `.pdata` Exception Directory dispatcher.
fn build_pdata(
    machine: Machine,
    text_rva: u32,
    text_size: u32,
    pdata_rva: u32,
    text_prologue_len: u32,
    fn_unwind: &[super::FnUnwind],
) -> Pdata {
    match machine {
        Machine::X86_64 => {
            build_x86_64_pdata(text_rva, text_size, pdata_rva, text_prologue_len, fn_unwind)
        }
        Machine::Aarch64 => build_aarch64_pdata(text_rva, text_size),
    }
}

const UWOP_PUSH_NONVOL: u8 = 0;
const UWOP_ALLOC_LARGE: u8 = 1;
const UWOP_ALLOC_SMALL: u8 = 2;
const UWOP_SET_FPREG: u8 = 3;
/// Non-volatile GPR save at a scaled RSP offset.
#[cfg(test)]
const UWOP_SAVE_NONVOL: u8 = 4;
const UNWIND_REG_RBP: u8 = 5;

/// Append one `UWOP_ALLOC_SMALL` / `UWOP_ALLOC_LARGE` to a reversed
/// (descending-`CodeOffset`) `UNWIND_CODE` list for a `sub rsp,size` at
/// prolog offset `code_offset`.
fn push_alloc_code(codes: &mut Vec<u8>, code_offset: u8, size: u32) {
    debug_assert!(size != 0 && size.is_multiple_of(8));
    if (8..=128).contains(&size) {
        codes.push(code_offset);
        codes.push((UWOP_ALLOC_SMALL & 0x0F) | (((size / 8 - 1) as u8) << 4));
    } else if size < 512 * 1024 {
        codes.push(code_offset);
        codes.push(UWOP_ALLOC_LARGE & 0x0F);
        codes.extend_from_slice(&((size / 8) as u16).to_le_bytes());
    } else {
        codes.push(code_offset);
        codes.push((UWOP_ALLOC_LARGE & 0x0F) | (1 << 4));
        codes.extend_from_slice(&size.to_le_bytes());
    }
}

/// Build the `UNWIND_CODE` byte stream for one function, in the
/// ABI-required descending-`CodeOffset` order. Returns `(codes,
/// size_of_prolog, frame_register)`; `frame_register` is 0 for a
/// frameless leaf and `UNWIND_REG_RBP` otherwise.
///
/// The c5 prologue is `[arg-spill group] push rbp; mov rbp,rsp;
/// [sub rsp,N]`, so the codes are, highest offset first:
/// `UWOP_ALLOC N` (frame), `UWOP_SET_FPREG` (rbp, offset 0),
/// `UWOP_PUSH_NONVOL rbp`, then `UWOP_ALLOC M` for the arg-spill
/// group whose net stack effect is `-M`. `RtlVirtualUnwind`
/// processes them in array order: the alloc for `N` runs first but
/// is immediately overwritten by `UWOP_SET_FPREG` (`RSP = RBP -
/// 0`), which makes the recovery exact even though the body moves
/// RSP for outgoing-call scratch; the push then restores rbp and
/// the final alloc reverses the arg-spill so RSP and the return
/// address land at the caller's frame.
///
/// The callee-saved GPRs this backend stores with `mov [rsp+off],reg`
/// at the frame bottom (after the frame allocation) are not described.
/// RIP/RSP/RBP recover exactly at any body fault through the frame
/// pointer, but a debugger / profiler / SEH / C++ unwind crossing this
/// frame does not recover those GPR values. `UWOP_SAVE_NONVOL` cannot
/// describe the current saves: (a) unwind codes must be listed in
/// descending prologue offset, so the GPR saves (last in the prologue)
/// are always processed before `UWOP_SET_FPREG` and thus resolve against
/// the running `context->Rsp` rather than the reconstructed frame RSP;
/// (b) the body lowers each call as `sub rsp,scratch; call; add
/// rsp,scratch` with per-site scratch, so at a call return address
/// `context->Rsp` is `frame_rsp - scratch` and no fixed save offset is
/// correct at every sample point. A faithful description requires saving
/// the GPRs with `push` before the frame pointer is established so each
/// recovers via `UWOP_PUSH_NONVOL` (processed after `UWOP_SET_FPREG`
/// resets RSP to rbp). TODO: that push-before-setframe prologue
/// restructure (prologue + epilogue + the decoder in lockstep, plus an
/// 8*count shift of every rbp-relative local/spill offset). badc emits
/// no exception-using code today, so execution is unaffected until then.
fn build_unwind_codes(uw: &super::FnUnwind) -> (Vec<u8>, u8, u8) {
    if uw.leaf {
        return (Vec::new(), 0, 0);
    }
    let mut codes = Vec::new();
    // The `*_end` offsets are already relative to the function's first byte
    // (the CodeOffset domain). A Win64 frame of a page or more lowers to a
    // stack-probe loop with no single `sub`; it is left undescribed because
    // the probe runs after the frame pointer is established, so
    // `UWOP_SET_FPREG` recovers RSP exactly at any fault past it.
    if uw.frame_alloc_end != 0 {
        push_alloc_code(&mut codes, uw.frame_alloc_end as u8, uw.frame_bytes);
    }
    codes.push(uw.set_fpreg_end as u8);
    codes.push(UWOP_SET_FPREG & 0x0F);
    codes.push(uw.push_rbp_end as u8);
    codes.push((UWOP_PUSH_NONVOL & 0x0F) | (UNWIND_REG_RBP << 4));
    if uw.param_spill_bytes > 0 {
        push_alloc_code(&mut codes, uw.arg_spill_end as u8, uw.param_spill_bytes);
    }
    // SizeOfProlog need only reach past `mov rbp,rsp` so the unwinder
    // classifies the pre-frame-pointer region (arg-spill, push rbp) as
    // prolog and the rest as body; PCs past `mov rbp,rsp` unwind correctly
    // through the frame pointer whether labelled prolog or body.
    let size_of_prolog = if uw.frame_alloc_end != 0 {
        uw.frame_alloc_end
    } else {
        uw.set_fpreg_end
    } as u8;
    (codes, size_of_prolog, UNWIND_REG_RBP)
}

/// x86_64 `.pdata` builder.
fn build_x86_64_pdata(
    text_rva: u32,
    text_size: u32,
    pdata_rva: u32,
    text_prologue_len: u32,
    fn_unwind: &[super::FnUnwind],
) -> Pdata {
    const RUNTIME_FUNCTION_SIZE: u32 = 12;
    if fn_unwind.is_empty() {
        let mut bytes = Vec::with_capacity(16);
        let unwind_info_rva = pdata_rva + RUNTIME_FUNCTION_SIZE;
        bytes.extend_from_slice(&text_rva.to_le_bytes());
        bytes.extend_from_slice(&(text_rva + text_size).to_le_bytes());
        bytes.extend_from_slice(&unwind_info_rva.to_le_bytes());
        bytes.extend_from_slice(&[0x01, 0x00, 0x00, 0x00]);
        return Pdata {
            bytes,
            directory_size: RUNTIME_FUNCTION_SIZE,
        };
    }

    // Sort by begin so the RUNTIME_FUNCTION array is ascending (the loader
    // binary-searches it); the emitter already produces them in order, but
    // the link path collects from a name-keyed map.
    let mut entries: Vec<&super::FnUnwind> = fn_unwind.iter().collect();
    entries.sort_by_key(|u| u.begin);

    let array_size = entries.len() as u32 * RUNTIME_FUNCTION_SIZE;
    let blobs_rva = round_up(pdata_rva + array_size, 4);
    let mut blobs: Vec<u8> = Vec::new();
    let mut info_rvas: Vec<u32> = Vec::with_capacity(entries.len());
    for uw in &entries {
        info_rvas.push(blobs_rva + blobs.len() as u32);
        let (codes, size_of_prolog, frame_reg) = build_unwind_codes(uw);
        let count_of_codes = (codes.len() / 2) as u8;
        blobs.push(0x01); // Version 1, Flags 0.
        blobs.push(size_of_prolog);
        blobs.push(count_of_codes);
        blobs.push(frame_reg & 0x0F);
        blobs.extend_from_slice(&codes);
        // The codes array holds an even number of slots; each slot is 2
        // bytes, so the blob is already u16-aligned.
        while !blobs.len().is_multiple_of(4) {
            blobs.push(0);
        }
    }

    let mut bytes = Vec::with_capacity((array_size + blobs.len() as u32) as usize);
    for (i, uw) in entries.iter().enumerate() {
        let begin = text_rva + text_prologue_len + uw.begin;
        let end = text_rva + text_prologue_len + uw.end;
        bytes.extend_from_slice(&begin.to_le_bytes());
        bytes.extend_from_slice(&end.to_le_bytes());
        bytes.extend_from_slice(&info_rvas[i].to_le_bytes());
    }
    while pdata_rva + bytes.len() as u32 != blobs_rva {
        bytes.push(0);
    }
    bytes.extend_from_slice(&blobs);
    Pdata {
        bytes,
        directory_size: array_size,
    }
}

/// AArch64 `.pdata` builder.
fn build_aarch64_pdata(text_rva: u32, text_size: u32) -> Pdata {
    let mut bytes = Vec::new();
    let mut covered = 0u32;
    while covered < text_size {
        let remaining = text_size - covered;
        let chunk = remaining.min(ARM64_PACKED_FUNCTION_MAX_BYTES);
        let chunk_words = chunk / 4;
        let function_length = chunk_words & 0x7FF; // 11 bits
        let unwind_data: u32 = (function_length << 2) | 0b01; // Flag=1
        let begin_address = text_rva + covered;
        bytes.extend_from_slice(&begin_address.to_le_bytes());
        bytes.extend_from_slice(&unwind_data.to_le_bytes());
        covered += chunk;
    }
    let directory_size = bytes.len() as u32;
    Pdata {
        bytes,
        directory_size,
    }
}

/// Patch an IAT-lookup sequence: `call qword [rip+disp32]` on x86_64, or
/// `adrp x16, _; ldr x16, [x16, #_]` on aarch64.
fn patch_iat_lookup(
    machine: Machine,
    text: &mut [u8],
    instr_offset_in_text: u32,
    text_section_rva: u32,
    target_rva: u32,
    part: AddrPart,
) -> Result<(), C5Error> {
    let instr_rva = text_section_rva + instr_offset_in_text;
    match machine {
        Machine::X86_64 => {
            crate::c5::codegen::require_whole_addr(part, "PE: IAT lookup")?;
            let after_rva = instr_rva + 6;
            patch_x86_64_disp32(
                text,
                (instr_offset_in_text + 2) as usize,
                after_rva,
                target_rva,
            )
        }
        Machine::Aarch64 => {
            patch_aarch64_adrp_ldr(text, instr_offset_in_text, instr_rva, target_rva, part)
        }
    }
}

/// Patch a data-import reference so it loads the value of the IAT slot
/// rather than taking the address of a call thunk.
fn patch_iat_data_load(
    machine: Machine,
    text: &mut [u8],
    instr_offset_in_text: u32,
    text_section_rva: u32,
    target_rva: u32,
) -> Result<(), C5Error> {
    match machine {
        Machine::X86_64 => {
            let opcode_off = (instr_offset_in_text + 1) as usize;
            if text[opcode_off] != 0x8D && text[opcode_off] != 0x8B {
                return Err(C5Error::Compile(crate::c5::error::fmt_internal_diag(
                    Code::INTERNAL,
                    &format!(
                        "PE: data-import load expected lea 0x8D or mov 0x8B at \
                         text+{opcode_off:#x}, found {:#04x}",
                        text[opcode_off],
                    ),
                )));
            }
            text[opcode_off] = 0x8B;
            let instr_rva = text_section_rva + instr_offset_in_text;
            let after_rva = instr_rva + (x86_64::LEA_RIP32_LEN as u32);
            patch_x86_64_disp32(
                text,
                (instr_offset_in_text + 3) as usize,
                after_rva,
                target_rva,
            )
        }
        Machine::Aarch64 => Err(C5Error::Compile(crate::c5::error::fmt_internal_diag(
            Code::INTERNAL,
            "PE: patch_iat_data_load is x86_64-only; aarch64 uses patch_iat_lookup",
        ))),
    }
}

/// Patch an absolute-address materialization: `lea rd, [rip+disp32]` on
/// x86_64 or `adrp xd, _; add xd, xd, #_` on aarch64.
fn patch_addr_load(
    machine: Machine,
    text: &mut [u8],
    instr_offset_in_text: u32,
    text_section_rva: u32,
    target_rva: u32,
    part: AddrPart,
) -> Result<(), C5Error> {
    let instr_rva = text_section_rva + instr_offset_in_text;
    match machine {
        Machine::X86_64 => {
            crate::c5::codegen::require_whole_addr(part, "PE: address load")?;
            let after_rva = instr_rva + (x86_64::LEA_RIP32_LEN as u32);
            patch_x86_64_disp32(
                text,
                (instr_offset_in_text + 3) as usize,
                after_rva,
                target_rva,
            )
        }
        Machine::Aarch64 => {
            patch_aarch64_adrp_add(text, instr_offset_in_text, instr_rva, target_rva, part)
        }
    }
}

/// Patch a direct call to a target within the same `.text`: `call rel32` on
/// x86_64 (5 bytes) or `bl rel26` on aarch64 (4 bytes).
fn patch_direct_call(
    machine: Machine,
    text: &mut [u8],
    call_offset_in_text: u32,
    target_offset_in_text: u32,
) -> Result<(), C5Error> {
    match machine {
        Machine::X86_64 => {
            let after = call_offset_in_text + 5;
            let delta = target_offset_in_text as i64 - after as i64;
            if !(i32::MIN as i64..=i32::MAX as i64).contains(&delta) {
                return Err(C5Error::Compile(crate::c5::error::fmt_internal_diag(
                    Code::INTERNAL,
                    &format!("PE: rel32 displacement {delta} doesn't fit in 32 bits"),
                )));
            }
            let disp32 = delta as i32;
            let off = (call_offset_in_text + 1) as usize;
            text[off..off + 4].copy_from_slice(&disp32.to_le_bytes());
            Ok(())
        }
        Machine::Aarch64 => {
            let delta_bytes = target_offset_in_text as i64 - call_offset_in_text as i64;
            if delta_bytes & 3 != 0 {
                return Err(C5Error::Compile(crate::c5::error::fmt_internal_diag(
                    Code::INTERNAL,
                    &format!("PE: aarch64 bl delta {delta_bytes} not 4-byte aligned"),
                )));
            }
            let delta_insns = delta_bytes / 4;
            if !(-(1i64 << 25)..(1i64 << 25)).contains(&delta_insns) {
                return Err(C5Error::Compile(crate::c5::error::fmt_internal_diag(
                    Code::INTERNAL,
                    &format!("PE: aarch64 bl delta {delta_insns} insns out of 26-bit range"),
                )));
            }
            let word = aarch64::enc_bl(delta_insns as i32);
            let off = call_offset_in_text as usize;
            text[off..off + 4].copy_from_slice(&word.to_le_bytes());
            Ok(())
        }
    }
}

/// Write a 32-bit signed displacement at `disp32_off` so that `target_rva =
/// after_rva + disp32`.
fn patch_x86_64_disp32(
    text: &mut [u8],
    disp32_off: usize,
    after_rva: u32,
    target_rva: u32,
) -> Result<(), C5Error> {
    let delta = target_rva as i64 - after_rva as i64;
    if !(i32::MIN as i64..=i32::MAX as i64).contains(&delta) {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_diag(
            Code::INTERNAL,
            &format!("PE: disp32 {delta} doesn't fit in 32 bits"),
        )));
    }
    let disp32 = delta as i32;
    text[disp32_off..disp32_off + 4].copy_from_slice(&disp32.to_le_bytes());
    Ok(())
}

/// Patch an aarch64 reference to load the 64-bit value at `target_rva` into
/// `xd`.
fn patch_aarch64_adrp_ldr(
    text: &mut [u8],
    instr_offset_in_text: u32,
    instr_rva: u32,
    target_rva: u32,
    part: AddrPart,
) -> Result<(), C5Error> {
    aarch64::patch::patch_slot(
        text,
        instr_offset_in_text as usize,
        instr_rva as i64,
        target_rva as i64,
        aarch64::patch::SlotWidth::W64,
        part,
    )
    .map_err(|e| {
        C5Error::Compile(crate::c5::error::fmt_internal_diag(
            Code::INTERNAL,
            &e.describe("PE: aarch64"),
        ))
    })
}

/// Patch an aarch64 `adrp xd, _` / `add xd, xd, #_` reference to point at
/// `target_rva`.
fn patch_aarch64_adrp_add(
    text: &mut [u8],
    instr_offset_in_text: u32,
    instr_rva: u32,
    target_rva: u32,
    part: AddrPart,
) -> Result<(), C5Error> {
    aarch64::patch::patch_addr(
        text,
        instr_offset_in_text as usize,
        instr_rva as i64,
        target_rva as i64,
        part,
    )
    .map_err(|e| {
        C5Error::Compile(crate::c5::error::fmt_internal_diag(
            Code::INTERNAL,
            &e.describe("PE: aarch64"),
        ))
    })
}

/// Zero-pad `out` to the precomputed file offset of the next section.
fn pad_to(out: &mut Vec<u8>, target_len: usize) -> Result<(), C5Error> {
    if out.len() > target_len {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_diag(
            Code::INTERNAL,
            &format!(
                "PE layout drift: write cursor {:#x} past computed file offset {target_len:#x}",
                out.len(),
            ),
        )));
    }
    out.resize(target_len, 0);
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;
    use alloc::string::ToString;

    /// Append the entry-stub runtime helpers to `build` so the writer's
    /// executable stub direct-call patches resolve.
    fn inject_runtime_stub_symbols(build: &mut Build) {
        let pc = build.pc_to_native.len();
        build.pc_to_native.push(build.entry_offset);
        build.func_names.push(RT_ENTRY.to_string());
        build.func_ent_pcs.push(pc);
    }

    /// `codegen::lower_for` plus the runtime-stub symbol injection, so
    /// every writer-level test resolves the entry stub's direct calls.
    fn lower_for(
        program: &Program,
        target: super::super::Target,
        options: super::super::NativeOptions,
    ) -> Result<Build, C5Error> {
        let mut build = super::super::lower_for(program, target, options)?;
        inject_runtime_stub_symbols(&mut build);
        Ok(build)
    }

    /// `pad_to` rejects a write cursor already past the layout's computed
    /// file offset instead of silently overlapping sections.
    #[test]
    fn pad_to_rejects_cursor_past_target() {
        let mut out = alloc::vec![0u8; 16];
        assert!(pad_to(&mut out, 8).is_err());
        assert!(pad_to(&mut out, 16).is_ok());
        pad_to(&mut out, 32).expect("grow");
        assert_eq!(out.len(), 32);
    }

    /// The export name pointer table is binary-searched by GetProcAddress,
    /// so `build_export_directory` orders the entries lexically with the
    /// ordinal table pointing back at each name's AddressOfFunctions slot.
    #[test]
    fn export_directory_sorts_names_lexically() {
        let bytes = build_export_directory(
            0x5000,
            alloc::vec![
                ("zeta".to_string(), 0x1000u32),
                ("alpha".to_string(), 0x2000u32),
            ],
            Some("t.dll"),
        )
        .expect("build export directory");
        let name_pos = |needle: &[u8]| {
            bytes
                .windows(needle.len())
                .position(|w| w == needle)
                .expect("name present")
        };
        assert!(name_pos(b"alpha\0") < name_pos(b"zeta\0"));
        // AddressOfFunctions stays in declaration order.
        let funcs_off = IMAGE_EXPORT_DIRECTORY_SIZE;
        let rva0 = u32::from_le_bytes(bytes[funcs_off..funcs_off + 4].try_into().unwrap());
        let rva1 = u32::from_le_bytes(bytes[funcs_off + 4..funcs_off + 8].try_into().unwrap());
        assert_eq!((rva0, rva1), (0x1000, 0x2000));
        let ordinals_off = funcs_off + 4 * 2 + 4 * 2;
        let ord0 = u16::from_le_bytes(bytes[ordinals_off..ordinals_off + 2].try_into().unwrap());
        let ord1 = u16::from_le_bytes(
            bytes[ordinals_off + 2..ordinals_off + 4]
                .try_into()
                .unwrap(),
        );
        assert_eq!((ord0, ord1), (1, 0));
    }

    /// The packed AArch64 RUNTIME_FUNCTION encodes `FunctionLength` in 11
    /// bits (units = 4-byte instructions).
    #[test]
    fn aarch64_pdata_packs_chunks_under_function_length_limit() {
        let text_size = 2047 * 4 + 4 + 4;
        let p = build_aarch64_pdata(0x1000, text_size);
        assert_eq!(p.bytes.len() % 8, 0);
        for entry in p.bytes.as_chunks::<8>().0.iter() {
            let unwind_data = u32::from_le_bytes([entry[4], entry[5], entry[6], entry[7]]);
            let function_length = (unwind_data >> 2) & 0x7FF;
            let flag = unwind_data & 0b11;
            assert_eq!(flag, 0b01, "expected Flag=1 (packed canonical)");
            assert_ne!(function_length, 0, "FunctionLength field truncated to zero");
        }
    }

    /// The executable entry is the uniform adapter that calls `__c5_entry`;
    /// the console / GUI / wide distinction lives in the runtime, so the
    /// adapter is identical regardless of subsystem.
    #[test]
    fn entry_adapter_calls_c5_entry_x86_64() {
        let s = build_entry_stub(Machine::X86_64, false);
        assert_eq!(s.bytes.len(), 16);
        assert_eq!(s.direct_call_runtime, vec![(9, RT_ENTRY)]);
        assert_eq!(s.direct_call_main_offset, None);
        assert_eq!(&s.bytes[14..16], &[0x0F, 0x0B], "adapter must end in ud2");
    }

    #[test]
    fn entry_adapter_calls_c5_entry_aarch64() {
        let s = build_entry_stub(Machine::Aarch64, false);
        assert_eq!(s.bytes.len(), 16);
        assert_eq!(s.direct_call_runtime, vec![(8, RT_ENTRY)]);
        assert_eq!(s.direct_call_main_offset, None);
    }

    /// Offset within the Optional Header at which DataDirectory[i] begins.
    fn data_directory_offset(optional_off: usize, idx: usize) -> usize {
        optional_off + 112 + idx * core::mem::size_of::<DataDirectoryEntry>()
    }

    /// Walk the Optional Header and read DataDirectory[idx]'s (rva, size)
    /// tuple.
    fn read_data_directory(bytes: &[u8], idx: usize) -> (u32, u32) {
        let pe_off = u32::from_le_bytes(bytes[60..64].try_into().unwrap()) as usize;
        let optional_off = pe_off + 4 + COFF_HEADER_SIZE;
        let entry_off = data_directory_offset(optional_off, idx);
        let rva = u32::from_le_bytes(bytes[entry_off..entry_off + 4].try_into().unwrap());
        let size = u32::from_le_bytes(bytes[entry_off + 4..entry_off + 8].try_into().unwrap());
        (rva, size)
    }

    /// PE without `_Thread_local`: TLS directory entry must be zero so the
    /// loader knows there's nothing to allocate per-thread.
    #[test]
    fn no_tls_means_zero_tls_data_directory() {
        use crate::Compiler;
        let program = Compiler::new("int main() { return 0; }".to_string())
            .compile()
            .expect("compile");
        let build = lower_for(
            &program,
            super::super::Target::WindowsX64,
            super::super::NativeOptions::default(),
        )
        .expect("lower");
        let bytes = write(
            &program,
            &build,
            Machine::X86_64,
            super::super::Target::WindowsX64,
        )
        .expect("write PE");
        let (rva, size) = read_data_directory(&bytes, DATA_DIRECTORY_TLS);
        assert_eq!(rva, 0, "TLS RVA must be 0 when no TLS present");
        assert_eq!(size, 0, "TLS size must be 0 when no TLS present");
    }

    /// A PE executable may legally carry an export directory (a plugin host
    /// publishing its API for GetProcAddress).
    #[test]
    fn executable_dynamic_exports_emit_export_directory() {
        use crate::Compiler;
        let program = Compiler::new("int main() { return 0; }".to_string())
            .compile()
            .expect("compile");
        let mut build = lower_for(
            &program,
            super::super::Target::WindowsX64,
            super::super::NativeOptions::default(),
        )
        .expect("lower");
        build.data = alloc::vec![0u8; 16];
        build.bss_size = 8;
        build.dynamic_exports = alloc::vec![
            crate::c5::codegen::DynamicExport {
                name: "bump".to_string(),
                section: super::super::DynamicExportSection::Text,
                offset: 0,
                size: 0,
                is_object: false,
                weak: false,
            },
            crate::c5::codegen::DynamicExport {
                name: "zero_global".to_string(),
                section: super::super::DynamicExportSection::Data,
                offset: 16,
                size: 8,
                is_object: true,
                weak: false,
            },
        ];
        let bytes = write(
            &program,
            &build,
            Machine::X86_64,
            super::super::Target::WindowsX64,
        )
        .expect("write PE");
        let (rva, size) = read_data_directory(&bytes, DATA_DIRECTORY_EXPORT);
        assert_ne!(rva, 0, "export directory RVA must be set");
        assert_ne!(size, 0, "export directory size must be set");
        assert!(
            bytes.windows(5).any(|w| w == b"bump\0"),
            "the export name must appear in the image"
        );
        assert!(
            bytes.windows(12).any(|w| w == b"zero_global\0"),
            "a zero-init global must reach the export directory"
        );

        let plain = write(
            &program,
            &lower_for(
                &program,
                super::super::Target::WindowsX64,
                super::super::NativeOptions::default(),
            )
            .expect("lower"),
            Machine::X86_64,
            super::super::Target::WindowsX64,
        )
        .expect("write PE");
        assert_eq!(
            read_data_directory(&plain, DATA_DIRECTORY_EXPORT),
            (0, 0),
            "a plain executable must carry no export directory"
        );
    }

    /// PE with `_Thread_local`: TLS directory entry must point at a
    /// non-empty IMAGE_TLS_DIRECTORY64 of size 40, and the directory's
    /// contents must reference plausible RVAs (well past the header, inside
    /// the .data section).
    #[test]
    fn thread_local_emits_well_formed_tls_directory_x64() {
        use crate::Compiler;
        let src = "_Thread_local int counter; int main() { counter = 42; return counter; }";
        let program = Compiler::new(super::super::super::tests::with_prelude(src))
            .compile()
            .expect("compile");
        let build = lower_for(
            &program,
            super::super::Target::WindowsX64,
            super::super::NativeOptions::default(),
        )
        .expect("lower");
        let bytes = write(
            &program,
            &build,
            Machine::X86_64,
            super::super::Target::WindowsX64,
        )
        .expect("write PE");
        let (tls_rva, tls_size) = read_data_directory(&bytes, DATA_DIRECTORY_TLS);
        assert_ne!(tls_rva, 0, "expected non-zero TLS directory RVA");
        assert_eq!(
            tls_size, IMAGE_TLS_DIRECTORY64_SIZE,
            "TLS directory size must equal IMAGE_TLS_DIRECTORY64 size"
        );

        let pe_off = u32::from_le_bytes(bytes[60..64].try_into().unwrap()) as usize;
        let coff_off = pe_off + 4;
        let n_sections = u16::from_le_bytes([bytes[coff_off + 2], bytes[coff_off + 3]]) as usize;
        let optional_off = coff_off + COFF_HEADER_SIZE;
        let optional_size =
            u16::from_le_bytes([bytes[coff_off + 16], bytes[coff_off + 17]]) as usize;
        let sections_off = optional_off + optional_size;
        let mut tls_file_off: Option<usize> = None;
        for i in 0..n_sections {
            let h = sections_off + i * SECTION_HEADER_SIZE;
            let v_addr = u32::from_le_bytes(bytes[h + 12..h + 16].try_into().unwrap());
            let v_size = u32::from_le_bytes(bytes[h + 8..h + 12].try_into().unwrap());
            let p_off = u32::from_le_bytes(bytes[h + 20..h + 24].try_into().unwrap());
            if tls_rva >= v_addr && tls_rva < v_addr + v_size {
                tls_file_off = Some((p_off + (tls_rva - v_addr)) as usize);
                break;
            }
        }
        let tls_file_off = tls_file_off.expect("TLS directory must lie inside a section");

        // Read the four VAs + two u32s. They must be monotonic (Start <=
        // End), Start/End within the image's address range (>= ImageBase),
        // and SizeOfZeroFill non-negative.
        let start_va =
            u64::from_le_bytes(bytes[tls_file_off..tls_file_off + 8].try_into().unwrap());
        let end_va = u64::from_le_bytes(
            bytes[tls_file_off + 8..tls_file_off + 16]
                .try_into()
                .unwrap(),
        );
        let index_va = u64::from_le_bytes(
            bytes[tls_file_off + 16..tls_file_off + 24]
                .try_into()
                .unwrap(),
        );
        let cb_va = u64::from_le_bytes(
            bytes[tls_file_off + 24..tls_file_off + 32]
                .try_into()
                .unwrap(),
        );
        let zero_fill = u32::from_le_bytes(
            bytes[tls_file_off + 32..tls_file_off + 36]
                .try_into()
                .unwrap(),
        );
        let characteristics = u32::from_le_bytes(
            bytes[tls_file_off + 36..tls_file_off + 40]
                .try_into()
                .unwrap(),
        );
        assert!(start_va >= IMAGE_BASE, "Start VA below ImageBase");
        assert!(end_va >= start_va, "End VA before Start VA");
        assert!(index_va >= IMAGE_BASE, "AddressOfIndex below ImageBase");
        assert_eq!(cb_va, 0, "AddressOfCallBacks should be NULL");
        assert_eq!(characteristics, 0, "Characteristics must be 0");
        // The single `_Thread_local int counter` is 8 bytes (c5 globals are
        // word-sized). We emit the whole TLS block as init template (zeros)
        // rather than as SizeOfZeroFill, so a Windows ARM64 loader path
        // that skips empty-template directories still processes us.
        assert_eq!(
            end_va - start_va,
            8,
            "expected 8 bytes of init template (one TLS int slot)"
        );
        assert_eq!(
            zero_fill, 0,
            "expected SizeOfZeroFill = 0 (whole-data template)"
        );
    }

    /// AArch64 mirror of the x64 TLS-directory check.
    #[test]
    fn thread_local_emits_well_formed_tls_directory_arm64() {
        use crate::Compiler;
        let src = "_Thread_local int counter; int main() { counter = 42; return counter; }";
        let program = Compiler::new(super::super::super::tests::with_prelude(src))
            .compile()
            .expect("compile");
        let build = lower_for(
            &program,
            super::super::Target::WindowsAarch64,
            super::super::NativeOptions::default(),
        )
        .expect("lower");
        let bytes = write(
            &program,
            &build,
            Machine::Aarch64,
            super::super::Target::WindowsAarch64,
        )
        .expect("write PE");
        let (tls_rva, tls_size) = read_data_directory(&bytes, DATA_DIRECTORY_TLS);
        assert_ne!(tls_rva, 0, "expected non-zero TLS directory RVA");
        assert_eq!(tls_size, IMAGE_TLS_DIRECTORY64_SIZE);
    }

    /// Read OptionalHeader.DllCharacteristics.
    fn read_dll_characteristics(bytes: &[u8]) -> u16 {
        let pe_off = u32::from_le_bytes(bytes[60..64].try_into().unwrap()) as usize;
        let optional_off = pe_off + 4 + COFF_HEADER_SIZE;
        u16::from_le_bytes(
            bytes[optional_off + 70..optional_off + 72]
                .try_into()
                .unwrap(),
        )
    }

    /// Resolve an RVA to a file offset through the section table.
    fn rva_to_file_off(bytes: &[u8], rva: u32) -> Option<usize> {
        let pe_off = u32::from_le_bytes(bytes[60..64].try_into().unwrap()) as usize;
        let coff_off = pe_off + 4;
        let n_sections = u16::from_le_bytes([bytes[coff_off + 2], bytes[coff_off + 3]]) as usize;
        let optional_size =
            u16::from_le_bytes([bytes[coff_off + 16], bytes[coff_off + 17]]) as usize;
        let sections_off = coff_off + COFF_HEADER_SIZE + optional_size;
        for i in 0..n_sections {
            let h = sections_off + i * SECTION_HEADER_SIZE;
            let v_addr = u32::from_le_bytes(bytes[h + 12..h + 16].try_into().unwrap());
            let v_size = u32::from_le_bytes(bytes[h + 8..h + 12].try_into().unwrap());
            let p_off = u32::from_le_bytes(bytes[h + 20..h + 24].try_into().unwrap());
            let span = v_size.max(u32::from_le_bytes(
                bytes[h + 16..h + 20].try_into().unwrap(),
            ));
            if rva >= v_addr && rva < v_addr + span {
                return Some((p_off + (rva - v_addr)) as usize);
            }
        }
        None
    }

    /// A multi-function Windows-x64 PE must carry one `RUNTIME_FUNCTION`
    /// per emitted function -- sorted by `BeginAddress`, non-overlapping,
    /// each pointing at a well-formed `UNWIND_INFO` (version 1) inside the
    /// `.pdata` section.
    #[test]
    fn pdata_has_one_runtime_function_per_function_x64() {
        use crate::Compiler;
        let src = "
            int add(int a, int b) { return a + b; }
            int mul3(int a, int b, int c) { return a * b * c; }
            long sumloop(int n) { long s = 0; for (int i = 0; i < n; i++) s += i; return s; }
            int main(int argc, char **argv) {
                (void)argv;
                return add(argc, mul3(1, 2, 3)) + (int)sumloop(argc);
            }
        ";
        let program = Compiler::new(super::super::super::tests::with_prelude(src))
            .compile()
            .expect("compile");
        let build = lower_for(
            &program,
            super::super::Target::WindowsX64,
            super::super::NativeOptions::default(),
        )
        .expect("lower");
        let n_funcs = build.fn_unwind.len();
        assert!(
            n_funcs >= 4,
            "expected at least the 4 user functions, got {n_funcs}"
        );
        let bytes = write(
            &program,
            &build,
            Machine::X86_64,
            super::super::Target::WindowsX64,
        )
        .expect("write PE");

        let (exc_rva, exc_size) = read_data_directory(&bytes, DATA_DIRECTORY_EXCEPTION);
        assert_ne!(exc_rva, 0, "Exception directory RVA must be non-zero");
        assert_eq!(
            exc_size % 12,
            0,
            "Exception directory size must be a whole number of RUNTIME_FUNCTIONs"
        );
        assert_eq!(
            exc_size as usize / 12,
            n_funcs,
            "one RUNTIME_FUNCTION per emitted function (not a single coarse entry)"
        );

        // The `.pdata` section must hold both the array and the trailing
        // UNWIND_INFO blobs, so its virtual size exceeds the directory
        // (array-only) size.
        let pdata_off = rva_to_file_off(&bytes, exc_rva).expect("Exception dir inside a section");

        let (text_lo, text_hi) = {
            let pe_off = u32::from_le_bytes(bytes[60..64].try_into().unwrap()) as usize;
            let coff_off = pe_off + 4;
            let n_sections =
                u16::from_le_bytes([bytes[coff_off + 2], bytes[coff_off + 3]]) as usize;
            let optional_size =
                u16::from_le_bytes([bytes[coff_off + 16], bytes[coff_off + 17]]) as usize;
            let sections_off = coff_off + COFF_HEADER_SIZE + optional_size;
            let mut span = (0u32, 0u32);
            for i in 0..n_sections {
                let h = sections_off + i * SECTION_HEADER_SIZE;
                if &bytes[h..h + 5] == b".text" {
                    let v_addr = u32::from_le_bytes(bytes[h + 12..h + 16].try_into().unwrap());
                    let v_size = u32::from_le_bytes(bytes[h + 8..h + 12].try_into().unwrap());
                    span = (v_addr, v_addr + v_size);
                }
            }
            span
        };
        assert_ne!(text_hi, 0, ".text section not found");

        let n = exc_size as usize / 12;
        let mut prev_end = 0u32;
        for i in 0..n {
            let e = pdata_off + i * 12;
            let begin = u32::from_le_bytes(bytes[e..e + 4].try_into().unwrap());
            let end = u32::from_le_bytes(bytes[e + 4..e + 8].try_into().unwrap());
            let info_rva = u32::from_le_bytes(bytes[e + 8..e + 12].try_into().unwrap());
            assert!(begin < end, "entry {i}: begin {begin:#x} >= end {end:#x}");
            assert!(
                begin >= prev_end,
                "entry {i}: not sorted / overlaps (begin {begin:#x} < prev_end {prev_end:#x})"
            );
            assert!(
                begin >= text_lo && end <= text_hi,
                "entry {i}: [{begin:#x},{end:#x}) outside .text [{text_lo:#x},{text_hi:#x})"
            );
            let info_off =
                rva_to_file_off(&bytes, info_rva).expect("UNWIND_INFO RVA inside a section");
            let ver_flags = bytes[info_off];
            assert_eq!(ver_flags & 0x07, 1, "entry {i}: UNWIND_INFO version != 1");
            // The codes array length must match CountOfCodes, and the
            // FrameRegister, when present, must name rbp (5).
            let count_of_codes = bytes[info_off + 2];
            let frame_reg = bytes[info_off + 3] & 0x0F;
            if count_of_codes > 0 {
                assert_eq!(frame_reg, 5, "entry {i}: frame register must be rbp");
            }
            prev_end = end;
        }
    }

    /// The two `FnUnwind` producers -- the structured single-TU path
    /// (`emit_prologue`) and the link path's prologue-grammar decoder
    /// (`decode_x86_64_prologue_unwind`) -- must agree, so a function
    /// unwinds identically whether it is compiled in one unit or linked
    /// from objects.
    #[test]
    fn structured_and_decoded_unwind_agree_x64() {
        use crate::Compiler;
        let src = "
            int add(int a, int b) { return a + b; }
            int mul3(int a, int b, int c) { return a * b * c; }
            long sumloop(int n) { long s = 0; for (int i = 0; i < n; i++) s += i; return s; }
            int main(int argc, char **argv) {
                (void)argv;
                return add(argc, mul3(1, 2, 3)) + (int)sumloop(argc);
            }
        ";
        let program = Compiler::new(super::super::super::tests::with_prelude(src))
            .compile()
            .expect("compile");
        let build = lower_for(
            &program,
            super::super::Target::WindowsX64,
            super::super::NativeOptions::default(),
        )
        .expect("lower");
        for uw in &build.fn_unwind {
            let prologue_end = if uw.leaf {
                uw.begin
            } else if uw.frame_alloc_end != 0 {
                uw.begin + uw.frame_alloc_end
            } else {
                uw.begin + uw.set_fpreg_end
            };
            let decoded = super::super::x86_64::decode_x86_64_prologue_unwind(
                &build.text,
                uw.begin,
                uw.end,
                prologue_end,
            );
            assert_eq!(
                build_unwind_codes(uw),
                build_unwind_codes(&decoded),
                "structured vs decoded unwind codes differ for function at {:#x}",
                uw.begin
            );
        }
    }

    /// Locks the documented unwind-metadata limitation: a non-leaf x64
    /// Windows function that spills callee-saved GPRs describes only the
    /// frame-pointer prologue (SET_FPREG + PUSH_NONVOL rbp), never a
    /// `UWOP_SAVE_NONVOL` for the GPR spills.
    #[test]
    fn win64_gpr_spill_unwind_omits_save_nonvol() {
        use crate::Compiler;
        let src = "
            long g(long);
            long f(long a, long b, long c, long d, long e, long h, long i) {
                long r = g(a) + g(b);
                return r + a * b + c * d + e * h + i * a + b * c + d * e;
            }
            int main(void) { return (int)f(1, 2, 3, 4, 5, 6, 7); }
        ";
        let program = Compiler::new(super::super::super::tests::with_prelude(src))
            .compile()
            .expect("compile");
        let build = lower_for(
            &program,
            super::super::Target::WindowsX64,
            super::super::NativeOptions::default(),
        )
        .expect("lower");
        fn ops_of(codes: &[u8]) -> Vec<u8> {
            let mut ops = Vec::new();
            let mut i = 0;
            while i + 1 < codes.len() {
                let op = codes[i + 1] & 0x0F;
                let opinfo = codes[i + 1] >> 4;
                ops.push(op);
                let slots = match op {
                    1 => {
                        if opinfo == 0 {
                            2
                        } else {
                            3
                        }
                    } // ALLOC_LARGE
                    _ => 1,
                };
                i += slots * 2;
            }
            ops
        }
        let mut saw_non_leaf = false;
        for uw in &build.fn_unwind {
            if uw.leaf {
                continue;
            }
            saw_non_leaf = true;
            let (codes, _size_of_prolog, frame_reg) = build_unwind_codes(uw);
            assert_eq!(frame_reg, UNWIND_REG_RBP);
            let ops = ops_of(&codes);
            assert!(
                ops.contains(&UWOP_SET_FPREG),
                "non-leaf must set the frame register"
            );
            assert!(ops.contains(&UWOP_PUSH_NONVOL), "non-leaf must save rbp");
            assert!(
                !ops.contains(&UWOP_SAVE_NONVOL),
                "GPR spills are not (yet) described by UWOP_SAVE_NONVOL"
            );
        }
        assert!(saw_non_leaf, "expected at least one non-leaf frame");
    }

    /// `DYNAMIC_BASE` / `HIGH_ENTROPY_VA` stay on for every image we emit,
    /// including TLS-using ones.
    #[test]
    fn dll_characteristics_keep_aslr_flags_with_and_without_tls() {
        use crate::Compiler;
        for src in [
            "int main() { return 0; }",
            "_Thread_local int counter; int main() { counter = 1; return counter; }",
        ] {
            for target in [
                super::super::Target::WindowsX64,
                super::super::Target::WindowsAarch64,
            ] {
                let program = Compiler::new(super::super::super::tests::with_prelude(src))
                    .compile()
                    .expect("compile");
                let build = lower_for(&program, target, super::super::NativeOptions::default())
                    .expect("lower");
                let machine = match target {
                    super::super::Target::WindowsX64 => Machine::X86_64,
                    super::super::Target::WindowsAarch64 => Machine::Aarch64,
                    _ => unreachable!(),
                };
                let bytes = write(&program, &build, machine, target).expect("write PE");
                let dll_chars = read_dll_characteristics(&bytes);
                assert_ne!(
                    dll_chars & IMAGE_DLLCHARACTERISTICS_DYNAMIC_BASE,
                    0,
                    "{target:?}: DYNAMIC_BASE must always be set"
                );
                assert_ne!(
                    dll_chars & IMAGE_DLLCHARACTERISTICS_HIGH_ENTROPY_VA,
                    0,
                    "{target:?}: HIGH_ENTROPY_VA must always be set"
                );
                assert_ne!(
                    dll_chars & IMAGE_DLLCHARACTERISTICS_NX_COMPAT,
                    0,
                    "{target:?}: NX_COMPAT must always be set"
                );
            }
        }
    }

    /// TLS-using images must carry a `.reloc` section covering the three
    /// absolute VAs inside the TLS directory; otherwise the ASLR-aware
    /// loader would write the chosen `_tls_index` to a stale address and
    /// the process would crash with STATUS_ACCESS_VIOLATION on real
    /// Windows.
    #[test]
    fn thread_local_emits_reloc_section() {
        use crate::Compiler;
        let src = "_Thread_local int counter; int main() { counter = 1; return counter; }";
        for target in [
            super::super::Target::WindowsX64,
            super::super::Target::WindowsAarch64,
        ] {
            let program = Compiler::new(super::super::super::tests::with_prelude(src))
                .compile()
                .expect("compile");
            let build =
                lower_for(&program, target, super::super::NativeOptions::default()).expect("lower");
            let machine = match target {
                super::super::Target::WindowsX64 => Machine::X86_64,
                super::super::Target::WindowsAarch64 => Machine::Aarch64,
                _ => unreachable!(),
            };
            let bytes = write(&program, &build, machine, target).expect("write PE");

            // DataDirectory[5] (BaseRelocation) must point at a non-empty
            // block.
            let (reloc_rva, reloc_dir_size) = read_data_directory(&bytes, DATA_DIRECTORY_BASERELOC);
            assert_ne!(reloc_rva, 0, "{target:?}: missing .reloc directory");
            assert_eq!(
                reloc_dir_size, 16,
                "{target:?}: expected 16-byte .reloc block"
            );

            let pe_off = u32::from_le_bytes(bytes[60..64].try_into().unwrap()) as usize;
            let coff_off = pe_off + 4;
            let n_sections =
                u16::from_le_bytes([bytes[coff_off + 2], bytes[coff_off + 3]]) as usize;
            let optional_off = coff_off + COFF_HEADER_SIZE;
            let optional_size =
                u16::from_le_bytes([bytes[coff_off + 16], bytes[coff_off + 17]]) as usize;
            let sections_off = optional_off + optional_size;
            let mut reloc_file_off: Option<usize> = None;
            for i in 0..n_sections {
                let h = sections_off + i * SECTION_HEADER_SIZE;
                let v_addr = u32::from_le_bytes(bytes[h + 12..h + 16].try_into().unwrap());
                let v_size = u32::from_le_bytes(bytes[h + 8..h + 12].try_into().unwrap());
                let p_off = u32::from_le_bytes(bytes[h + 20..h + 24].try_into().unwrap());
                if reloc_rva >= v_addr && reloc_rva < v_addr + v_size {
                    reloc_file_off = Some((p_off + (reloc_rva - v_addr)) as usize);
                    break;
                }
            }
            let reloc_file_off = reloc_file_off.expect(".reloc must lie inside a section");

            let size_of_block = u32::from_le_bytes(
                bytes[reloc_file_off + 4..reloc_file_off + 8]
                    .try_into()
                    .unwrap(),
            );
            assert_eq!(size_of_block, 16, "{target:?}: SizeOfBlock should be 16");
            for slot in 0..3 {
                let off = reloc_file_off + 8 + slot * 2;
                let entry = u16::from_le_bytes([bytes[off], bytes[off + 1]]);
                let entry_type = (entry >> 12) & 0xF;
                assert_eq!(
                    entry_type, 10,
                    "{target:?}: entry {slot} must be IMAGE_REL_BASED_DIR64"
                );
            }
            let pad_off = reloc_file_off + 8 + 3 * 2;
            let pad = u16::from_le_bytes([bytes[pad_off], bytes[pad_off + 1]]);
            assert_eq!(pad, 0, "{target:?}: trailing pad entry must be ABSOLUTE");
        }
    }

    /// TLS-free images must NOT carry a `.reloc` section -- they have no
    /// absolute pointers, so a `.reloc` would be dead weight.
    #[test]
    fn no_tls_means_no_reloc_section() {
        use crate::Compiler;
        let program = Compiler::new("int main() { return 0; }".to_string())
            .compile()
            .expect("compile");
        let build = lower_for(
            &program,
            super::super::Target::WindowsX64,
            super::super::NativeOptions::default(),
        )
        .expect("lower");
        let bytes = write(
            &program,
            &build,
            Machine::X86_64,
            super::super::Target::WindowsX64,
        )
        .expect("write PE");
        let (rva, size) = read_data_directory(&bytes, DATA_DIRECTORY_BASERELOC);
        assert_eq!(rva, 0, "TLS-free image must not advertise .reloc RVA");
        assert_eq!(size, 0, "TLS-free image must not advertise .reloc size");
    }

    /// Read COFF Characteristics from the binary.
    fn read_coff_characteristics(bytes: &[u8]) -> u16 {
        let pe_off = u32::from_le_bytes(bytes[60..64].try_into().unwrap()) as usize;
        u16::from_le_bytes(bytes[pe_off + 22..pe_off + 24].try_into().unwrap())
    }

    /// Shared-library output (`OutputKind::SharedLibrary`) flips the
    /// `IMAGE_FILE_DLL` characteristic and adds an `IMAGE_EXPORT_DIRECTORY`
    /// for each `#pragma export` symbol.
    #[test]
    fn dll_output_emits_export_directory_and_dll_flag() {
        use crate::Compiler;
        let src = "
            int answer() { return 42; }
            #pragma export(answer)
            int main() { return 0; }
        ";
        for (machine, target) in [
            (Machine::X86_64, super::super::Target::WindowsX64),
            (Machine::Aarch64, super::super::Target::WindowsAarch64),
        ] {
            let program =
                Compiler::with_target(super::super::super::tests::with_prelude(src), target)
                    .compile()
                    .expect("compile");
            let build = lower_for(
                &program,
                target,
                super::super::NativeOptions::new().with_shared_library(),
            )
            .expect("lower");
            let bytes = write(&program, &build, machine, target).expect("write PE");

            let chars = read_coff_characteristics(&bytes);
            assert_ne!(
                chars & IMAGE_FILE_DLL,
                0,
                "{machine:?}: IMAGE_FILE_DLL must be set for shared-library output"
            );

            let (export_rva, export_size) = read_data_directory(&bytes, DATA_DIRECTORY_EXPORT);
            assert_ne!(export_rva, 0, "{machine:?}: missing Export Directory");
            assert!(
                export_size >= 40,
                "{machine:?}: Export Directory must be at least 40 bytes (the IMAGE_EXPORT_DIRECTORY header)"
            );

            let pe_off = u32::from_le_bytes(bytes[60..64].try_into().unwrap()) as usize;
            let coff_off = pe_off + 4;
            let n_sections =
                u16::from_le_bytes([bytes[coff_off + 2], bytes[coff_off + 3]]) as usize;
            let optional_off = coff_off + COFF_HEADER_SIZE;
            let optional_size =
                u16::from_le_bytes([bytes[coff_off + 16], bytes[coff_off + 17]]) as usize;
            let sections_off = optional_off + optional_size;
            let mut edata_file_off: Option<usize> = None;
            for i in 0..n_sections {
                let h = sections_off + i * SECTION_HEADER_SIZE;
                let v_addr = u32::from_le_bytes(bytes[h + 12..h + 16].try_into().unwrap());
                let v_size = u32::from_le_bytes(bytes[h + 8..h + 12].try_into().unwrap());
                let p_off = u32::from_le_bytes(bytes[h + 20..h + 24].try_into().unwrap());
                if export_rva >= v_addr && export_rva < v_addr + v_size {
                    edata_file_off = Some((p_off + (export_rva - v_addr)) as usize);
                    break;
                }
            }
            let edata_file_off = edata_file_off.expect(".edata must lie inside a section");
            let n_funcs = u32::from_le_bytes(
                bytes[edata_file_off + 20..edata_file_off + 24]
                    .try_into()
                    .unwrap(),
            );
            let n_names = u32::from_le_bytes(
                bytes[edata_file_off + 24..edata_file_off + 28]
                    .try_into()
                    .unwrap(),
            );
            assert_eq!(
                n_funcs, 1,
                "{machine:?}: NumberOfFunctions must equal the export count"
            );
            assert_eq!(
                n_names, 1,
                "{machine:?}: NumberOfNames must equal the export count"
            );
        }
    }

    /// DllMain stubs returning TRUE: x86_64 is `mov eax, 1; ret` (`B8 01 00
    /// 00 00 C3`); aarch64 is `mov w0, #1; ret` (4-byte `enc_movz` + 4-byte
    /// `enc_ret(x30)`).
    #[test]
    fn dllmain_stub_returns_true() {
        let s_x64 = build_entry_stub(Machine::X86_64, true);
        assert_eq!(
            s_x64.bytes,
            vec![0xB8, 0x01, 0x00, 0x00, 0x00, 0xC3],
            "x64 DllMain must be `mov eax, 1; ret`"
        );
        assert!(s_x64.direct_call_runtime.is_empty());
        assert!(s_x64.direct_call_main_offset.is_none());

        let s_arm = build_entry_stub(Machine::Aarch64, true);
        assert_eq!(s_arm.bytes.len(), 8);
        // First word: movz w0, #1 => 0x52800020 (movz is the 32-bit form
        // because Rd is x0 / w0 with sf=0; we emit the 64-bit movz with
        // imm=1, low lane, which also clears the upper lanes --
        // semantically the same single bit).
        let first = u32::from_le_bytes([
            s_arm.bytes[0],
            s_arm.bytes[1],
            s_arm.bytes[2],
            s_arm.bytes[3],
        ]);
        let second = u32::from_le_bytes([
            s_arm.bytes[4],
            s_arm.bytes[5],
            s_arm.bytes[6],
            s_arm.bytes[7],
        ]);
        assert_eq!(first, 0xD280_0020, "expected `movz x0, #1`");
        assert_eq!(second, 0xD65F_03C0, "expected `ret` against x30");
    }

    /// `AddressOfEntryPoint` lives at Optional Header offset 16;
    /// `BaseOfCode` at offset 20.
    fn read_entry_point_and_base_of_code(bytes: &[u8]) -> (u32, u32) {
        let pe_off = u32::from_le_bytes(bytes[60..64].try_into().unwrap()) as usize;
        let optional_off = pe_off + 4 + COFF_HEADER_SIZE;
        let entry = u32::from_le_bytes(
            bytes[optional_off + 16..optional_off + 20]
                .try_into()
                .unwrap(),
        );
        let base = u32::from_le_bytes(
            bytes[optional_off + 20..optional_off + 24]
                .try_into()
                .unwrap(),
        );
        (entry, base)
    }

    /// Default `--shared` build (no user `DllMain`): `AddressOfEntryPoint`
    /// must equal `BaseOfCode` because the boilerplate `mov eax, 1; ret`
    /// stub sits at the start of `.text` and is what the loader calls on
    /// `DLL_PROCESS_ATTACH`.
    #[test]
    fn dll_without_user_dllmain_uses_stub_at_base_of_code() {
        use crate::Compiler;
        let src = "
            int answer() { return 42; }
            #pragma export(answer)
        ";
        let program = Compiler::new(src.to_string()).compile().expect("compile");
        let build = lower_for(
            &program,
            super::super::Target::WindowsX64,
            super::super::NativeOptions::new().with_shared_library(),
        )
        .expect("lower");
        let bytes = write(
            &program,
            &build,
            Machine::X86_64,
            super::super::Target::WindowsX64,
        )
        .expect("write PE");
        let (entry, base) = read_entry_point_and_base_of_code(&bytes);
        assert_eq!(
            entry, base,
            "without a user DllMain the stub sits at the start of .text \
             and AddressOfEntryPoint == BaseOfCode"
        );
    }

    /// User-defined `DllMain` overrides the stub: the writer must point
    /// `AddressOfEntryPoint` at the user's body inside `build.text` rather
    /// than at the start of `.text`.
    #[test]
    fn dll_with_user_dllmain_skips_stub() {
        use crate::Compiler;
        let src = "
            int dummy(int x) { return x; }
            int DllMain(int hinst, int reason, int reserved) {
                return dummy(1);
            }
        ";
        let program = Compiler::new(src.to_string()).compile().expect("compile");
        let dllmain_pc = program
            .dllmain_pc
            .expect("compiler must record dllmain_pc when source defines DllMain");
        let build = lower_for(
            &program,
            super::super::Target::WindowsX64,
            super::super::NativeOptions::new().with_shared_library(),
        )
        .expect("lower");
        let dllmain_native_off = build.pc_to_native[dllmain_pc] as u32;
        assert!(
            dllmain_native_off > 0,
            "with `dummy` defined before DllMain, the lowering \
             should leave DllMain past offset 0 in build.text \
             (got {dllmain_native_off:#x})"
        );
        let bytes = write(
            &program,
            &build,
            Machine::X86_64,
            super::super::Target::WindowsX64,
        )
        .expect("write PE");
        let (entry, base) = read_entry_point_and_base_of_code(&bytes);
        assert_eq!(
            entry,
            base + dllmain_native_off,
            "AddressOfEntryPoint must target the user's DllMain at \
             BaseOfCode + pc_to_native[dllmain_pc]"
        );
    }

    /// `#pragma subsystem(windows)` sets Subsystem to
    /// `IMAGE_SUBSYSTEM_WINDOWS_GUI` and selects the WinMain-shaped stub.
    #[test]
    fn gui_subsystem_sets_gui_and_hardcodes_no_imports() {
        use crate::Compiler;
        let src = "
            #pragma subsystem(windows)
            #pragma entrypoint(WinMain)
            int WinMain(long hinst, long prev, char *cmd, int show) {
                (void)hinst; (void)prev; (void)cmd;
                return show;
            }
        ";
        let program = Compiler::new(src.to_string()).compile().expect("compile");
        let build = lower_for(
            &program,
            super::super::Target::WindowsX64,
            super::super::NativeOptions::default(),
        )
        .expect("lower");
        let bytes = write(
            &program,
            &build,
            Machine::X86_64,
            super::super::Target::WindowsX64,
        )
        .expect("write PE");

        let pe_off = u32::from_le_bytes(bytes[60..64].try_into().unwrap()) as usize;
        let optional_off = pe_off + 4 + COFF_HEADER_SIZE;
        let subsystem = u16::from_le_bytes([bytes[optional_off + 68], bytes[optional_off + 69]]);
        assert_eq!(
            subsystem, IMAGE_SUBSYSTEM_WINDOWS_GUI,
            "`#pragma subsystem(windows)` must set Subsystem to WINDOWS_GUI"
        );

        let contains =
            |needle: &str| -> bool { bytes.windows(needle.len()).any(|w| w == needle.as_bytes()) };
        assert!(
            !contains("GetModuleHandleA"),
            "writer must not hardcode kernel32!GetModuleHandleA"
        );
        assert!(
            !contains("GetCommandLineA"),
            "writer must not hardcode kernel32!GetCommandLineA"
        );
        assert!(
            !contains("__getmainargs"),
            "writer must not hardcode msvcrt!__getmainargs"
        );
    }

    /// Passthrough subsystems (NT-native, UEFI) skip the entry stub.
    fn passthrough_subsystem_skips_stub(pragma: &str, expected_subsystem: u16) {
        use crate::Compiler;
        let src = format!(
            "
            #pragma subsystem({pragma})
            #pragma entrypoint(Entry)
            long Entry(long a, long b) {{ (void)a; (void)b; return 0; }}
            "
        );
        let program = Compiler::new(src).compile().expect("compile");
        let build = lower_for(
            &program,
            super::super::Target::WindowsX64,
            super::super::NativeOptions::default(),
        )
        .expect("lower");
        let entry_native_off = build.entry_offset as u32;
        let bytes = write(
            &program,
            &build,
            Machine::X86_64,
            super::super::Target::WindowsX64,
        )
        .expect("write PE");

        let pe_off = u32::from_le_bytes(bytes[60..64].try_into().unwrap()) as usize;
        let optional_off = pe_off + 4 + COFF_HEADER_SIZE;
        let subsystem = u16::from_le_bytes([bytes[optional_off + 68], bytes[optional_off + 69]]);
        assert_eq!(
            subsystem, expected_subsystem,
            "`#pragma subsystem({pragma})` must set Subsystem to {expected_subsystem}"
        );

        // 2) AddressOfEntryPoint must target the user's `Entry`
        let (entry_rva, base) = read_entry_point_and_base_of_code(&bytes);
        assert_eq!(
            entry_rva,
            base + entry_native_off,
            "passthrough subsystem must point AddressOfEntryPoint at the user's entry \
             (BaseOfCode {base:#x} + entry_offset {entry_native_off:#x}) -- got {entry_rva:#x}"
        );

        for needle in &[
            "__getmainargs",
            "exit",
            "GetModuleHandleA",
            "GetCommandLineA",
        ] {
            assert!(
                !bytes.windows(needle.len()).any(|w| w == needle.as_bytes()),
                "passthrough subsystem `{pragma}` must NOT import {needle}"
            );
        }
    }

    #[test]
    fn native_subsystem_skips_stub() {
        passthrough_subsystem_skips_stub("native", IMAGE_SUBSYSTEM_NATIVE);
    }

    #[test]
    fn driver_pragma_aliases_native_subsystem() {
        passthrough_subsystem_skips_stub("driver", IMAGE_SUBSYSTEM_NATIVE);
    }

    #[test]
    fn efi_application_subsystem_skips_stub() {
        passthrough_subsystem_skips_stub("efi_application", IMAGE_SUBSYSTEM_EFI_APPLICATION);
    }

    #[test]
    fn efi_boot_service_driver_subsystem_skips_stub() {
        passthrough_subsystem_skips_stub(
            "efi_boot_service_driver",
            IMAGE_SUBSYSTEM_EFI_BOOT_SERVICE_DRIVER,
        );
    }

    #[test]
    fn efi_runtime_driver_subsystem_skips_stub() {
        passthrough_subsystem_skips_stub("efi_runtime_driver", IMAGE_SUBSYSTEM_EFI_RUNTIME_DRIVER);
    }

    #[test]
    fn efi_rom_subsystem_skips_stub() {
        passthrough_subsystem_skips_stub("efi_rom", IMAGE_SUBSYSTEM_EFI_ROM);
    }

    /// AArch64 cover for the NT-native passthrough case.
    #[test]
    fn native_subsystem_skips_stub_on_aarch64() {
        use crate::Compiler;
        let src = "
            #pragma subsystem(native)
            #pragma entrypoint(NtProcessStartup)
            long NtProcessStartup(long peb) { (void)peb; return 0; }
        ";
        let program = Compiler::new(src.to_string()).compile().expect("compile");
        let build = lower_for(
            &program,
            super::super::Target::WindowsAarch64,
            super::super::NativeOptions::default(),
        )
        .expect("lower");
        let entry_native_off = build.entry_offset as u32;
        let bytes = write(
            &program,
            &build,
            Machine::Aarch64,
            super::super::Target::WindowsAarch64,
        )
        .expect("write PE");
        let (entry_rva, base) = read_entry_point_and_base_of_code(&bytes);
        assert_eq!(
            entry_rva,
            base + entry_native_off,
            "AArch64 native passthrough must direct-target the user's entry"
        );
    }

    /// Executables keep `IMAGE_FILE_DLL` cleared and have no Export
    /// Directory.
    #[test]
    fn executable_output_keeps_dll_flag_clear() {
        use crate::Compiler;
        let program = Compiler::new("int main() { return 0; }".to_string())
            .compile()
            .expect("compile");
        let build = lower_for(
            &program,
            super::super::Target::WindowsX64,
            super::super::NativeOptions::default(),
        )
        .expect("lower");
        let bytes = write(
            &program,
            &build,
            Machine::X86_64,
            super::super::Target::WindowsX64,
        )
        .expect("write PE");
        let chars = read_coff_characteristics(&bytes);
        assert_eq!(
            chars & IMAGE_FILE_DLL,
            0,
            "executables must not advertise IMAGE_FILE_DLL"
        );
        let (rva, size) = read_data_directory(&bytes, DATA_DIRECTORY_EXPORT);
        assert_eq!(rva, 0, "executables must not advertise an Export Directory");
        assert_eq!(size, 0);
    }

    /// End-to-end format check: build an aarch64 Windows PE for a trivial
    /// program and verify the on-disk byte layout claims the right
    /// architecture.
    #[test]
    fn aarch64_pe_format_is_well_formed() {
        use crate::Compiler;
        let program = Compiler::new("int main() { return 42; }".to_string())
            .compile()
            .expect("compile");
        let build = lower_for(
            &program,
            super::super::Target::WindowsAarch64,
            super::super::NativeOptions::default(),
        )
        .expect("lower");
        let bytes = write(
            &program,
            &build,
            Machine::Aarch64,
            super::super::Target::WindowsAarch64,
        )
        .expect("write PE");

        assert_eq!(&bytes[0..2], b"MZ");
        let pe_off = u32::from_le_bytes([bytes[60], bytes[61], bytes[62], bytes[63]]) as usize;
        assert_eq!(&bytes[pe_off..pe_off + 4], b"PE\0\0");
        let machine_field = u16::from_le_bytes([bytes[pe_off + 4], bytes[pe_off + 5]]);
        assert_eq!(machine_field, IMAGE_FILE_MACHINE_ARM64);
        let optional_off = pe_off + 4 + COFF_HEADER_SIZE;
        let optional_magic = u16::from_le_bytes([bytes[optional_off], bytes[optional_off + 1]]);
        assert_eq!(optional_magic, PE32_PLUS_MAGIC);
    }
}
