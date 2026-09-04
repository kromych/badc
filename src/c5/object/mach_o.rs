//! Mach-O 64-bit image writer for arm64: the header, the load-command
//! stream, the `__TEXT` / `__DATA_CONST` / `__DATA` / `__DWARF`
//! segments and the `__LINKEDIT` tables dyld binds from. The CLI shim
//! signs the result; macOS refuses to exec an unsigned image.

use crate::c5::diag::Code;
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use super::super::error::C5Error;
use super::super::program::Program;
use super::dwarf;
use super::{AddrPart, Build, DataRegion, data_region_addr, image};
use crate::c5::layout::{pad_to_align as pad_to, round_up, write_struct};

const MH_MAGIC_64: u32 = 0xFEED_FACF;

const CPU_TYPE_ARM64: u32 = 0x0100_000C; // CPU_ARCH_ABI64 | CPU_TYPE_ARM
const CPU_SUBTYPE_ARM64_ALL: u32 = 0;

const MH_EXECUTE: u32 = 0x2;
const MH_DYLIB: u32 = 0x6;

const MH_DYLDLINK: u32 = 0x4;
const MH_TWOLEVEL: u32 = 0x80;
const MH_PIE: u32 = 0x0020_0000;
const MH_HAS_TLV_DESCRIPTORS: u32 = 0x0080_0000;

const LC_REQ_DYLD: u32 = 0x8000_0000;
const LC_SEGMENT_64: u32 = 0x19;
const LC_SYMTAB: u32 = 0x2;
const LC_DYSYMTAB: u32 = 0xB;
const LC_LOAD_DYLINKER: u32 = 0xE;
const LC_LOAD_DYLIB: u32 = 0xC;
const LC_ID_DYLIB: u32 = 0xD;
const LC_DYLD_INFO_ONLY: u32 = 0x22 | LC_REQ_DYLD;
const LC_MAIN: u32 = 0x28 | LC_REQ_DYLD;
const LC_BUILD_VERSION: u32 = 0x32;
const LC_UUID: u32 = 0x1b;
const UUID_COMMAND_SIZE: usize = 24;

const VM_PROT_READ: u32 = 1;
const VM_PROT_WRITE: u32 = 2;
const VM_PROT_EXECUTE: u32 = 4;

const PLATFORM_MACOS: u32 = 1;

const PAGE_SIZE: u64 = 0x4000;

const PAGEZERO_VMSIZE: u64 = 0x1_0000_0000;

const TEXT_VMADDR_BASE: u64 = PAGEZERO_VMSIZE;

const MIN_MACOS: u32 = 11 << 16;
const SDK_MACOS: u32 = 11 << 16;

const BIND_OPCODE_DONE: u8 = 0x00;
const BIND_OPCODE_SET_DYLIB_ORDINAL_IMM: u8 = 0x10;
const BIND_OPCODE_SET_DYLIB_ORDINAL_ULEB: u8 = 0x20;
const BIND_OPCODE_SET_DYLIB_SPECIAL_IMM: u8 = 0x30;
const BIND_SPECIAL_DYLIB_FLAT_LOOKUP_IMM: u8 = 0x0E;
const BIND_OPCODE_SET_SYMBOL_TRAILING_FLAGS_IMM: u8 = 0x40;
const BIND_OPCODE_SET_TYPE_IMM: u8 = 0x50;
const BIND_OPCODE_SET_SEGMENT_AND_OFFSET_ULEB: u8 = 0x70;
const BIND_OPCODE_DO_BIND: u8 = 0x90;

const REBASE_OPCODE_DONE: u8 = 0x00;
const REBASE_OPCODE_SET_TYPE_IMM: u8 = 0x10;
const REBASE_OPCODE_SET_SEGMENT_AND_OFFSET_ULEB: u8 = 0x20;
const REBASE_OPCODE_DO_REBASE_IMM_TIMES: u8 = 0x50;

const REBASE_TYPE_POINTER: u8 = 1;

const BIND_TYPE_POINTER: u8 = 1;

const N_UNDF: u8 = 0x0;
const N_SECT: u8 = 0xE;
const N_EXT: u8 = 0x01;
const NO_SECT: u8 = 0;
const N_WEAK_DEF: u16 = 0x0080;
const EXPORT_SYMBOL_FLAGS_WEAK_DEFINITION: u64 = 0x04;
const DYNAMIC_LOOKUP_ORDINAL: u8 = 0xFE;
const SECT_INDEX_TEXT: u8 = 1;
const SECT_INDEX_CONST: u8 = 2;
/// Family whose region held a named section's bytes, hence the segment it
/// is declared in: `__TEXT` past `__const`, `__DATA_CONST` past its
/// `__const`, `__DATA` past `__data` or past `__bss`.
#[derive(Clone, Copy, PartialEq, Eq)]
enum NamedFamily {
    Const,
    DataConst,
    Data,
    Bss,
}

/// A named section given a section of its own inside its family's segment.
struct NamedOut<'a> {
    name: &'a str,
    family: NamedFamily,
    start: u64,
    size: u64,
    addr: u64,
    fileoff: u32,
    align_log2: u32,
}

/// Named-section counts per family, which shift every global section index
/// past the family they ride in.
#[derive(Clone, Copy, Default)]
struct NamedCounts {
    konst: u8,
    data_const: u8,
    data: u8,
}

const SEG_INDEX_DATA_CONST: u8 = 2;
fn seg_index_data(data_const: bool) -> u8 {
    if data_const { 3 } else { 2 }
}

const SG_READ_ONLY: u32 = 0x10;

const S_ATTR_DEBUG: u32 = 0x0200_0000;

/// Mach-O section type bits used by the TLV layout.
#[allow(dead_code)]
const S_ZEROFILL: u32 = 0x1; // __bss (zero-fill, no file backing)
const S_THREAD_LOCAL_REGULAR: u32 = 0x11; // __thread_data (init data)
const S_THREAD_LOCAL_ZEROFILL: u32 = 0x12; // __thread_bss (zero-fill)
const S_THREAD_LOCAL_VARIABLES: u32 = 0x13; // __thread_vars (descriptors)

const TLV_DESCRIPTOR_SIZE: u64 = 24;

const TLV_BOOTSTRAP_SYMBOL: &str = "__tlv_bootstrap";

// On-disk shapes. Mach-O is little-endian on every CPU we target, so the
// in-memory layout *is* the wire format.

/// `mach_header_64` -- the file header at offset 0.
#[repr(C)]
#[derive(Copy, Clone)]
struct MachHeader64 {
    magic: u32,
    cputype: u32,
    cpusubtype: u32,
    filetype: u32,
    ncmds: u32,
    sizeofcmds: u32,
    flags: u32,
    reserved: u32,
}

const MACH_HEADER_64_SIZE: usize = 32;
const _: () = assert!(core::mem::size_of::<MachHeader64>() == MACH_HEADER_64_SIZE);

/// `segment_command_64` -- one `LC_SEGMENT_64` load command.
#[repr(C)]
#[derive(Copy, Clone)]
struct SegmentCommand64 {
    cmd: u32,
    cmdsize: u32,
    segname: [u8; 16],
    vmaddr: u64,
    vmsize: u64,
    fileoff: u64,
    filesize: u64,
    maxprot: u32,
    initprot: u32,
    nsects: u32,
    flags: u32,
}

const SEGMENT_COMMAND_64_SIZE: usize = 72;
const _: () = assert!(core::mem::size_of::<SegmentCommand64>() == SEGMENT_COMMAND_64_SIZE);

/// `section_64` -- one section header inside a `SegmentCommand64`.
#[repr(C)]
#[derive(Copy, Clone)]
struct Section64 {
    sectname: [u8; 16],
    segname: [u8; 16],
    addr: u64,
    size: u64,
    offset: u32,
    align: u32,
    reloff: u32,
    nreloc: u32,
    flags: u32,
    reserved1: u32,
    reserved2: u32,
    reserved3: u32,
}

const SECTION_64_SIZE: usize = 80;
const _: () = assert!(core::mem::size_of::<Section64>() == SECTION_64_SIZE);

/// `dyld_info_command` -- pointers into __LINKEDIT for dyld's rebase / bind
/// / weak-bind / lazy-bind / export streams.
#[repr(C)]
#[derive(Copy, Clone)]
struct DyldInfoCommand {
    cmd: u32,
    cmdsize: u32,
    rebase_off: u32,
    rebase_size: u32,
    bind_off: u32,
    bind_size: u32,
    weak_bind_off: u32,
    weak_bind_size: u32,
    lazy_bind_off: u32,
    lazy_bind_size: u32,
    export_off: u32,
    export_size: u32,
}

const DYLD_INFO_COMMAND_SIZE: usize = 48;
const _: () = assert!(core::mem::size_of::<DyldInfoCommand>() == DYLD_INFO_COMMAND_SIZE);

/// `symtab_command` -- classic symbol-table + string-table pointers.
#[repr(C)]
#[derive(Copy, Clone)]
struct SymtabCommand {
    cmd: u32,
    cmdsize: u32,
    symoff: u32,
    nsyms: u32,
    stroff: u32,
    strsize: u32,
}

const SYMTAB_COMMAND_SIZE: usize = 24;
const _: () = assert!(core::mem::size_of::<SymtabCommand>() == SYMTAB_COMMAND_SIZE);

/// `dysymtab_command` -- partitions the symbol table into local /
/// external-defined / undefined ranges and points at the indirect symbol
/// table.
#[repr(C)]
#[derive(Copy, Clone)]
struct DysymtabCommand {
    cmd: u32,
    cmdsize: u32,
    ilocalsym: u32,
    nlocalsym: u32,
    iextdefsym: u32,
    nextdefsym: u32,
    iundefsym: u32,
    nundefsym: u32,
    tocoff: u32,
    ntoc: u32,
    modtaboff: u32,
    nmodtab: u32,
    extrefsymoff: u32,
    nextrefsyms: u32,
    indirectsymoff: u32,
    nindirectsyms: u32,
    extreloff: u32,
    nextrel: u32,
    locreloff: u32,
    nlocrel: u32,
}

const DYSYMTAB_COMMAND_SIZE: usize = 80;
const _: () = assert!(core::mem::size_of::<DysymtabCommand>() == DYSYMTAB_COMMAND_SIZE);

/// `entry_point_command` (`LC_MAIN`) -- file offset of the entry point plus
/// a stack-size hint.
#[repr(C)]
#[derive(Copy, Clone)]
struct EntryPointCommand {
    cmd: u32,
    cmdsize: u32,
    entryoff: u64,
    stacksize: u64,
}

const ENTRY_POINT_COMMAND_SIZE: usize = 24;
const _: () = assert!(core::mem::size_of::<EntryPointCommand>() == ENTRY_POINT_COMMAND_SIZE);

/// `build_version_command` (with `ntools = 0`) -- platform / minOS / SDK.
#[repr(C)]
#[derive(Copy, Clone)]
struct BuildVersionCommand {
    cmd: u32,
    cmdsize: u32,
    platform: u32,
    minos: u32,
    sdk: u32,
    ntools: u32,
}

const BUILD_VERSION_COMMAND_SIZE: usize = 24;
const _: () = assert!(core::mem::size_of::<BuildVersionCommand>() == BUILD_VERSION_COMMAND_SIZE);

/// `dylinker_command` header (without the trailing NUL-padded path).
#[repr(C)]
#[derive(Copy, Clone)]
struct DylinkerCommandHead {
    cmd: u32,
    cmdsize: u32,
    name_offset: u32,
}

const DYLINKER_COMMAND_HEAD_SIZE: usize = 12;
const _: () = assert!(core::mem::size_of::<DylinkerCommandHead>() == DYLINKER_COMMAND_HEAD_SIZE);

/// `dylib_command` header (without the trailing NUL-padded name).
#[repr(C)]
#[derive(Copy, Clone)]
struct DylibCommandHead {
    cmd: u32,
    cmdsize: u32,
    name_offset: u32,
    timestamp: u32,
    current_version: u32,
    compatibility_version: u32,
}

const DYLIB_COMMAND_HEAD_SIZE: usize = 24;
const _: () = assert!(core::mem::size_of::<DylibCommandHead>() == DYLIB_COMMAND_HEAD_SIZE);

/// `nlist_64` -- one symbol-table entry.
#[repr(C)]
#[derive(Copy, Clone)]
struct Nlist64 {
    n_strx: u32,
    n_type: u8,
    n_sect: u8,
    n_desc: u16,
    n_value: u64,
}

const NLIST_64_SIZE: usize = 16;
const _: () = assert!(core::mem::size_of::<Nlist64>() == NLIST_64_SIZE);

/// Pack a name into the 16-byte `segname` / `sectname` field, NUL- padded.
fn pack_name16(name: &str) -> [u8; 16] {
    debug_assert!(name.len() <= 16, "segment/section name too long: {name:?}");
    let mut buf = [0u8; 16];
    for (i, b) in name.as_bytes().iter().take(16).enumerate() {
        buf[i] = *b;
    }
    buf
}

/// LEB128 unsigned encoding -- 7-bit groups, low to high, MSB set on every
/// byte except the last.
fn put_uleb128(out: &mut Vec<u8>, mut v: u64) {
    loop {
        let byte = (v & 0x7F) as u8;
        v >>= 7;
        if v == 0 {
            out.push(byte);
            return;
        }
        out.push(byte | 0x80);
    }
}

/// Build the `LC_DYLD_INFO` export trie from `(disk name, address, flags)`
/// triples where `address` is the symbol's offset from the image base. dyld
/// resolves two-level-namespace imports and `dlsym` through this trie, not
/// the classic symbol table, so a shared library without it exports nothing
/// dyld can bind against.
pub(crate) fn build_export_trie(entries: &[(String, u64, u64)]) -> Vec<u8> {
    if entries.is_empty() {
        return Vec::new();
    }
    struct Node {
        /// `(address, export flags)` on a terminal node.
        term: Option<(u64, u64)>,
        edges: Vec<(Vec<u8>, usize)>,
        offset: usize,
    }
    let mut nodes: Vec<Node> = alloc::vec![Node {
        term: None,
        edges: Vec::new(),
        offset: 0,
    }];
    for (name, addr, flags) in entries {
        let bytes = name.as_bytes();
        let mut cur = 0usize;
        let mut pos = 0usize;
        'walk: while pos < bytes.len() {
            for ei in 0..nodes[cur].edges.len() {
                let label = nodes[cur].edges[ei].0.clone();
                let child = nodes[cur].edges[ei].1;
                let mut k = 0;
                while k < label.len() && pos + k < bytes.len() && label[k] == bytes[pos + k] {
                    k += 1;
                }
                if k == 0 {
                    continue;
                }
                if k == label.len() {
                    cur = child;
                    pos += k;
                    continue 'walk;
                }
                let split = nodes.len();
                nodes.push(Node {
                    term: None,
                    edges: alloc::vec![(label[k..].to_vec(), child)],
                    offset: 0,
                });
                nodes[cur].edges[ei] = (label[..k].to_vec(), split);
                cur = split;
                pos += k;
                continue 'walk;
            }
            let leaf = nodes.len();
            nodes.push(Node {
                term: None,
                edges: Vec::new(),
                offset: 0,
            });
            nodes[cur].edges.push((bytes[pos..].to_vec(), leaf));
            cur = leaf;
            pos = bytes.len();
        }
        nodes[cur].term = Some((*addr, *flags));
    }
    let body = |node: &Node, nodes: &[Node]| -> Vec<u8> {
        let mut term = Vec::new();
        if let Some((addr, flags)) = node.term {
            put_uleb128(&mut term, flags);
            put_uleb128(&mut term, addr);
        }
        let mut out = Vec::new();
        put_uleb128(&mut out, term.len() as u64);
        out.extend_from_slice(&term);
        out.push(node.edges.len() as u8);
        for (label, child) in &node.edges {
            out.extend_from_slice(label);
            out.push(0);
            put_uleb128(&mut out, nodes[*child].offset as u64);
        }
        out
    };
    loop {
        let sizes: Vec<usize> = (0..nodes.len())
            .map(|i| body(&nodes[i], &nodes).len())
            .collect();
        let mut off = 0usize;
        let mut changed = false;
        for i in 0..nodes.len() {
            if nodes[i].offset != off {
                nodes[i].offset = off;
                changed = true;
            }
            off += sizes[i];
        }
        if !changed {
            break;
        }
    }
    let mut out = Vec::new();
    for i in 0..nodes.len() {
        out.extend_from_slice(&body(&nodes[i], &nodes));
    }
    while out.len() % 8 != 0 {
        out.push(0);
    }
    out
}

/// A `section_64` header with no relocations.
fn section64(
    sectname: &str,
    segname: &str,
    addr: u64,
    size: u64,
    offset: u32,
    align: u32,
    flags: u32,
) -> Section64 {
    Section64 {
        sectname: pack_name16(sectname),
        segname: pack_name16(segname),
        addr,
        size,
        offset,
        align,
        reloff: 0,
        nreloc: 0,
        flags,
        reserved1: 0,
        reserved2: 0,
        reserved3: 0,
    }
}

/// `Section64` for one named section, declared inside `segname`.
fn named_section64(n: &NamedOut<'_>, segname: &str, zerofill: bool) -> Section64 {
    section64(
        &n.name[..n.name.len().min(16)],
        segname,
        n.addr,
        n.size,
        if zerofill { 0 } else { n.fileoff },
        n.align_log2,
        if zerofill { S_ZEROFILL } else { 0 },
    )
}

/// Where a segment sits in memory and in the file.
#[derive(Clone, Copy)]
struct SegmentPlacement {
    vmaddr: u64,
    vmsize: u64,
    fileoff: u64,
    filesize: u64,
}

/// One section's placement inside its segment.
#[derive(Clone, Copy)]
struct SectionPlacement {
    addr: u64,
    size: u64,
    offset: u32,
}

/// The thread-local sections of `__DATA`: `__thread_vars` (a 24-byte
/// descriptor per variable) and the per-thread storage, file-backed as
/// `__thread_data` once any variable has an initializer, else the zero-fill
/// `__thread_bss`.
#[derive(Clone, Copy)]
struct TlvSections {
    vars: SectionPlacement,
    storage: SectionPlacement,
    initialised: bool,
}

/// `LC_SEGMENT_64` for a segment with no sections (`__PAGEZERO`,
/// `__LINKEDIT`).
fn segment_no_sections(name: &str, place: SegmentPlacement, prot: u32) -> Vec<u8> {
    let mut out = Vec::with_capacity(SEGMENT_COMMAND_64_SIZE);
    write_struct(
        &mut out,
        &SegmentCommand64 {
            cmd: LC_SEGMENT_64,
            cmdsize: SEGMENT_COMMAND_64_SIZE as u32,
            segname: pack_name16(name),
            vmaddr: place.vmaddr,
            vmsize: place.vmsize,
            fileoff: place.fileoff,
            filesize: place.filesize,
            maxprot: prot,
            initprot: prot,
            nsects: 0,
            flags: 0,
        },
    );
    debug_assert_eq!(out.len(), SEGMENT_COMMAND_64_SIZE);
    out
}

/// `LC_SEGMENT_64` header for `name` over `sections`, followed by the
/// section headers.
fn segment(
    name: &str,
    place: SegmentPlacement,
    prot: u32,
    flags: u32,
    sections: &[Section64],
) -> Vec<u8> {
    let total = SEGMENT_COMMAND_64_SIZE + sections.len() * SECTION_64_SIZE;
    let mut out = Vec::with_capacity(total);
    write_struct(
        &mut out,
        &SegmentCommand64 {
            cmd: LC_SEGMENT_64,
            cmdsize: total as u32,
            segname: pack_name16(name),
            vmaddr: place.vmaddr,
            vmsize: place.vmsize,
            fileoff: place.fileoff,
            filesize: place.filesize,
            maxprot: prot,
            initprot: prot,
            nsects: sections.len() as u32,
            flags,
        },
    );
    for s in sections {
        write_struct(&mut out, s);
    }
    debug_assert_eq!(out.len(), total);
    out
}

/// `__TEXT`: `__text`, then `__const` (the read-only data prefix, the
/// producer fingerprint and the switch tables; no relocated slot, so the
/// segment's R+X mapping serves it, and no instruction attribute so tools
/// do not decode it), then the read-only named sections.
fn segment_text(
    place: SegmentPlacement,
    text: SectionPlacement,
    konst: SectionPlacement,
    const_align: u32,
    named: &[&NamedOut<'_>],
) -> Vec<u8> {
    let mut sections = alloc::vec![
        section64(
            "__text",
            "__TEXT",
            text.addr,
            text.size,
            text.offset,
            2,
            0x8000_0400
        ),
        section64(
            "__const",
            "__TEXT",
            konst.addr,
            konst.size,
            konst.offset,
            const_align,
            0
        ),
    ];
    sections.extend(named.iter().map(|n| named_section64(n, "__TEXT", false)));
    segment(
        "__TEXT",
        place,
        VM_PROT_READ | VM_PROT_EXECUTE,
        0,
        &sections,
    )
}

/// `__DATA_CONST`: the relro region, read-only content whose slots dyld
/// writes through the rebase stream; `SG_READ_ONLY` makes dyld drop write
/// permission once the fixups are applied.
fn segment_data_const(
    place: SegmentPlacement,
    const_size: u64,
    align: u32,
    named: &[&NamedOut<'_>],
) -> Vec<u8> {
    let mut sections = alloc::vec![section64(
        "__const",
        "__DATA_CONST",
        place.vmaddr,
        const_size,
        place.fileoff as u32,
        align,
        0
    )];
    sections.extend(
        named
            .iter()
            .map(|n| named_section64(n, "__DATA_CONST", false)),
    );
    segment(
        "__DATA_CONST",
        place,
        VM_PROT_READ | VM_PROT_WRITE,
        SG_READ_ONLY,
        &sections,
    )
}

/// `__DATA`: `__got` (filled by dyld via the bind opcodes, so its type
/// stays `S_REGULAR`), `__data`, the writable named sections, the
/// thread-local sections when present, `__bss` when segregation produced
/// zero-init storage, and the zero-fill named sections.
#[allow(clippy::too_many_arguments)]
fn segment_data(
    place: SegmentPlacement,
    got: SectionPlacement,
    data: SectionPlacement,
    data_align_log2: u32,
    tlv: Option<TlvSections>,
    bss: Option<(u64, u64)>,
    named_data: &[&NamedOut<'_>],
    named_bss: &[&NamedOut<'_>],
) -> Vec<u8> {
    let mut sections = alloc::vec![
        section64("__got", "__DATA", got.addr, got.size, got.offset, 3, 0),
        section64(
            "__data",
            "__DATA",
            data.addr,
            data.size,
            data.offset,
            data_align_log2,
            0
        ),
    ];
    sections.extend(
        named_data
            .iter()
            .map(|n| named_section64(n, "__DATA", false)),
    );
    if let Some(t) = tlv {
        sections.push(section64(
            "__thread_vars",
            "__DATA",
            t.vars.addr,
            t.vars.size,
            t.vars.offset,
            3,
            S_THREAD_LOCAL_VARIABLES,
        ));
        let (name, flags, offset) = if t.initialised {
            ("__thread_data", S_THREAD_LOCAL_REGULAR, t.storage.offset)
        } else {
            ("__thread_bss", S_THREAD_LOCAL_ZEROFILL, 0)
        };
        sections.push(section64(
            name,
            "__DATA",
            t.storage.addr,
            t.storage.size,
            offset,
            3,
            flags,
        ));
    }
    if let Some((addr, size)) = bss {
        sections.push(section64("__bss", "__DATA", addr, size, 0, 3, S_ZEROFILL));
    }
    sections.extend(named_bss.iter().map(|n| named_section64(n, "__DATA", true)));
    segment("__DATA", place, VM_PROT_READ | VM_PROT_WRITE, 0, &sections)
}

/// `__DWARF`: the five debug sections back to back.
fn segment_dwarf(place: SegmentPlacement, sections: [(u32, u64); 5]) -> Vec<u8> {
    const NAMES: [&str; 5] = [
        "__debug_info",
        "__debug_abbrev",
        "__debug_line",
        "__debug_str",
        "__debug_frame",
    ];
    let mut addr = place.vmaddr;
    let mut headers = Vec::with_capacity(5);
    for (name, (offset, size)) in NAMES.iter().zip(sections) {
        headers.push(section64(
            name,
            "__DWARF",
            addr,
            size,
            offset,
            0,
            S_ATTR_DEBUG,
        ));
        addr += size;
    }
    segment("__DWARF", place, 0, 0, &headers)
}

/// Compute the cmdsize for a variable-length load command whose body is a
/// fixed `head_size` followed by a NUL-terminated path padded to 8 bytes.
fn variable_lc_cmdsize(head_size: usize, path: &str) -> u32 {
    let unpadded = head_size + path.len() + 1;
    let padded = unpadded.next_multiple_of(8);
    padded as u32
}

/// `LC_LOAD_DYLINKER` -- tells dyld it is the dynamic linker.
fn load_dylinker(path: &str) -> Vec<u8> {
    let cmdsize = variable_lc_cmdsize(DYLINKER_COMMAND_HEAD_SIZE, path);
    let mut out = Vec::with_capacity(cmdsize as usize);
    write_struct(
        &mut out,
        &DylinkerCommandHead {
            cmd: LC_LOAD_DYLINKER,
            cmdsize,
            name_offset: DYLINKER_COMMAND_HEAD_SIZE as u32,
        },
    );
    out.extend_from_slice(path.as_bytes());
    out.push(0); // NUL terminator
    pad_to(&mut out, 8);
    debug_assert_eq!(out.len() as u32, cmdsize);
    out
}

/// `LC_LOAD_DYLIB` -- declare a dependency on a shared library that dyld
/// must load before our entry point runs.
fn load_dylib(path: &str) -> Vec<u8> {
    dylib_command(LC_LOAD_DYLIB, path)
}

/// `LC_ID_DYLIB` -- this image's install name.
fn id_dylib(path: &str) -> Vec<u8> {
    dylib_command(LC_ID_DYLIB, path)
}

fn dylib_command(cmd: u32, path: &str) -> Vec<u8> {
    let cmdsize = variable_lc_cmdsize(DYLIB_COMMAND_HEAD_SIZE, path);
    let mut out = Vec::with_capacity(cmdsize as usize);
    write_struct(
        &mut out,
        &DylibCommandHead {
            cmd,
            cmdsize,
            name_offset: DYLIB_COMMAND_HEAD_SIZE as u32,
            timestamp: 0,
            current_version: 0x0001_0000,       // 1.0.0
            compatibility_version: 0x0001_0000, // 1.0.0
        },
    );
    out.extend_from_slice(path.as_bytes());
    out.push(0); // NUL
    pad_to(&mut out, 8);
    debug_assert_eq!(out.len() as u32, cmdsize);
    out
}

/// `LC_UUID` -- 16-byte module-identity blob.
fn uuid_command(text: &[u8], data: &[u8], rodata: &crate::c5::codegen::RodataBuild) -> Vec<u8> {
    fn fnv1a128(bytes: &[u8]) -> [u8; 16] {
        let mut h0: u64 = 0xcbf2_9ce4_8422_2325;
        let mut h1: u64 = 0xa5e8_a87b_7de0_b591;
        for (i, &b) in bytes.iter().enumerate() {
            if i & 1 == 0 {
                h0 ^= b as u64;
                h0 = h0.wrapping_mul(0x100_0000_01b3);
            } else {
                h1 ^= b as u64;
                h1 = h1.wrapping_mul(0x100_0000_01b3);
            }
        }
        let mut out = [0u8; 16];
        out[0..8].copy_from_slice(&h0.to_le_bytes());
        out[8..16].copy_from_slice(&h1.to_le_bytes());
        out[6] = (out[6] & 0x0f) | 0x40;
        out[8] = (out[8] & 0x3f) | 0x80;
        out
    }
    let mut hash_input: Vec<u8> = Vec::with_capacity(text.len() + data.len());
    hash_input.extend_from_slice(text);
    hash_input.extend_from_slice(data);
    // Switch-table entries are patched after this runs, so the blob's bytes
    // are still zero; the routing they will carry lives in the entry list.
    for r in &rodata.rel32 {
        hash_input.extend_from_slice(&r.slot_offset.to_le_bytes());
        hash_input.extend_from_slice(&r.text_offset.to_le_bytes());
    }
    let uuid = fnv1a128(&hash_input);
    let mut out = Vec::with_capacity(UUID_COMMAND_SIZE);
    out.extend_from_slice(&LC_UUID.to_le_bytes());
    out.extend_from_slice(&(UUID_COMMAND_SIZE as u32).to_le_bytes());
    out.extend_from_slice(&uuid);
    debug_assert_eq!(out.len(), UUID_COMMAND_SIZE);
    out
}

/// `LC_BUILD_VERSION` -- platform + min OS + SDK.
fn build_version() -> Vec<u8> {
    let mut out = Vec::with_capacity(BUILD_VERSION_COMMAND_SIZE);
    write_struct(
        &mut out,
        &BuildVersionCommand {
            cmd: LC_BUILD_VERSION,
            cmdsize: BUILD_VERSION_COMMAND_SIZE as u32,
            platform: PLATFORM_MACOS,
            minos: MIN_MACOS,
            sdk: SDK_MACOS,
            ntools: 0,
        },
    );
    debug_assert_eq!(out.len(), BUILD_VERSION_COMMAND_SIZE);
    out
}

/// `LC_MAIN` -- file offset of the entry point, plus a stack-size hint
/// (zero = use the kernel default).
fn main_command(entry_file_offset: u64) -> Vec<u8> {
    let mut out = Vec::with_capacity(ENTRY_POINT_COMMAND_SIZE);
    write_struct(
        &mut out,
        &EntryPointCommand {
            cmd: LC_MAIN,
            cmdsize: ENTRY_POINT_COMMAND_SIZE as u32,
            entryoff: entry_file_offset,
            stacksize: 0, // kernel default
        },
    );
    debug_assert_eq!(out.len(), ENTRY_POINT_COMMAND_SIZE);
    out
}

/// Native `.text` offset of `__c5_entry`, the startup-runtime entry that
/// runs `__attribute__((constructor))` functions (via the linker's
/// `.init_array`) before the program entry, when the runtime is linked in.
fn c5_entry_native_offset(build: &Build) -> Option<u64> {
    let idx = build.func_names.iter().position(|n| n == "__c5_entry")?;
    let ent_pc = *build.func_ent_pcs.get(idx)?;
    build
        .pc_to_native
        .get(ent_pc)
        .copied()
        .filter(|&o| o != usize::MAX)
        .map(|o| o as u64)
}

/// `LC_DYLD_INFO_ONLY` -- pointers into __LINKEDIT for dyld's rebase / bind
/// / weak-bind / lazy-bind / export streams.
#[allow(clippy::too_many_arguments)]
fn dyld_info_only(
    rebase_off: u32,
    rebase_size: u32,
    bind_off: u32,
    bind_size: u32,
    weak_bind_off: u32,
    weak_bind_size: u32,
    lazy_bind_off: u32,
    lazy_bind_size: u32,
    export_off: u32,
    export_size: u32,
) -> Vec<u8> {
    let mut out = Vec::with_capacity(DYLD_INFO_COMMAND_SIZE);
    write_struct(
        &mut out,
        &DyldInfoCommand {
            cmd: LC_DYLD_INFO_ONLY,
            cmdsize: DYLD_INFO_COMMAND_SIZE as u32,
            rebase_off,
            rebase_size,
            bind_off,
            bind_size,
            weak_bind_off,
            weak_bind_size,
            lazy_bind_off,
            lazy_bind_size,
            export_off,
            export_size,
        },
    );
    debug_assert_eq!(out.len(), DYLD_INFO_COMMAND_SIZE);
    out
}

/// `LC_SYMTAB` -- classic symbol table (nlist entries) + string table.
fn symtab_command(symoff: u32, nsyms: u32, stroff: u32, strsize: u32) -> Vec<u8> {
    let mut out = Vec::with_capacity(SYMTAB_COMMAND_SIZE);
    write_struct(
        &mut out,
        &SymtabCommand {
            cmd: LC_SYMTAB,
            cmdsize: SYMTAB_COMMAND_SIZE as u32,
            symoff,
            nsyms,
            stroff,
            strsize,
        },
    );
    debug_assert_eq!(out.len(), SYMTAB_COMMAND_SIZE);
    out
}

/// `LC_DYSYMTAB` -- partition the symbol table into local /
/// external-defined / undefined ranges and point at the indirect symbol
/// table.
fn dysymtab_command(nlocalsym: u32, nextdefsym: u32, nundefsym: u32) -> Vec<u8> {
    let mut out = Vec::with_capacity(DYSYMTAB_COMMAND_SIZE);
    write_struct(
        &mut out,
        &DysymtabCommand {
            cmd: LC_DYSYMTAB,
            cmdsize: DYSYMTAB_COMMAND_SIZE as u32,
            ilocalsym: 0,
            nlocalsym,
            iextdefsym: nlocalsym,
            nextdefsym,
            iundefsym: nlocalsym + nextdefsym,
            nundefsym,
            tocoff: 0,
            ntoc: 0,
            modtaboff: 0,
            nmodtab: 0,
            extrefsymoff: 0,
            nextrefsyms: 0,
            indirectsymoff: 0,
            nindirectsyms: 0,
            extreloff: 0,
            nextrel: 0,
            locreloff: 0,
            nlocrel: 0,
        },
    );
    debug_assert_eq!(out.len(), DYSYMTAB_COMMAND_SIZE);
    out
}

/// Patch each adrp/ldr pair the codegen left behind.
fn apply_got_fixups(
    out: &mut [u8],
    code_base_in_file: usize,
    code_vmaddr_base: u64,
    got_base_vmaddr: u64,
    fixups: &[super::GotFixup],
) -> Result<(), C5Error> {
    for fx in fixups {
        let slot_vmaddr = got_base_vmaddr + (fx.import_index as u64) * 8;
        super::aarch64::patch::patch_slot(
            out,
            code_base_in_file + fx.instr_offset,
            (code_vmaddr_base + fx.instr_offset as u64) as i64,
            slot_vmaddr as i64,
            super::aarch64::patch::SlotWidth::W64,
            fx.part,
        )
        .map_err(|e| C5Error::internal(e.describe("Mach-O: GOT")))?;
    }
    Ok(())
}

/// Patch the fields `part` names so the reference computes `target_vmaddr`.
fn patch_adrp_add(
    out: &mut [u8],
    code_base_in_file: usize,
    code_vmaddr_base: u64,
    instr_offset: usize,
    target_vmaddr: u64,
    part: AddrPart,
    label: &str,
) -> Result<(), C5Error> {
    super::aarch64::patch::patch_addr(
        out,
        code_base_in_file + instr_offset,
        (code_vmaddr_base + instr_offset as u64) as i64,
        target_vmaddr as i64,
        part,
    )
    .map_err(|e| C5Error::internal(e.describe(&format!("Mach-O: {label}"))))
}

/// Patch each `Inst::ImmData` lowering site.
fn apply_data_fixups(
    out: &mut [u8],
    code_base_in_file: usize,
    code_vmaddr_base: u64,
    data_off_to_vaddr: &dyn Fn(u64) -> u64,
    fixups: &[super::DataFixup],
) -> Result<(), C5Error> {
    for fx in fixups {
        let target = data_off_to_vaddr(fx.data_offset);
        patch_adrp_add(
            out,
            code_base_in_file,
            code_vmaddr_base,
            fx.instr_offset,
            target,
            fx.part,
            "data fixup",
        )?;
    }
    Ok(())
}

/// Patch each macOS arm64 TLV access site.
fn apply_macho_tlv_fixups(
    out: &mut [u8],
    code_base_in_file: usize,
    code_vmaddr_base: u64,
    thread_vars_vmaddr: u64,
    fixups: &[super::MachoTlvFixup],
) -> Result<(), C5Error> {
    for fx in fixups {
        let descriptor_vmaddr =
            thread_vars_vmaddr + (fx.descriptor_index as u64) * TLV_DESCRIPTOR_SIZE;
        patch_adrp_add(
            out,
            code_base_in_file,
            code_vmaddr_base,
            fx.adrp_offset,
            descriptor_vmaddr,
            AddrPart::Whole,
            "TLV descriptor",
        )?;
    }
    Ok(())
}

/// Patch each function-pointer literal site.
fn apply_func_fixups(
    out: &mut [u8],
    code_base_in_file: usize,
    code_vmaddr_base: u64,
    fixups: &[super::FuncFixup],
) -> Result<(), C5Error> {
    for fx in fixups {
        let target = code_vmaddr_base + fx.target_native_offset as u64;
        patch_adrp_add(
            out,
            code_base_in_file,
            code_vmaddr_base,
            fx.instr_offset,
            target,
            fx.part,
            "func fixup",
        )?;
    }
    Ok(())
}

/// Layout context for the TLV bind ops.
struct TlvBindContext {
    /// Byte offset of the start of `__thread_vars` within the `__DATA`
    /// segment.
    segment_offset: u64,
    /// Number of TLV descriptors that need binding.
    tlv_count: usize,
    /// 1-based LC_LOAD_DYLIB ordinal of libSystem, which defines
    /// `__tlv_bootstrap` (see [`tlv_bootstrap_ordinal`]).
    bootstrap_ordinal: u64,
}

/// 1-based LC_LOAD_DYLIB ordinal of libSystem, the dylib that defines
/// `__tlv_bootstrap`.
fn tlv_bootstrap_ordinal(dylibs: &[crate::c5::codegen::ResolvedDylib]) -> Result<u64, C5Error> {
    dylibs
        .iter()
        .position(|d| d.path.contains("libSystem"))
        .map(|i| (i + 1) as u64)
        .ok_or_else(|| {
            C5Error::internal(
                "Mach-O: `_Thread_local` requires libSystem for `__tlv_bootstrap`, \
                 but no linked dylib matches libSystem",
            )
        })
}

/// Bind opcode stream that resolves the program's imports plus, when TLV is
/// in use, every TLV descriptor's slot 0 (the thunk getter pointer, bound
/// to `__tlv_bootstrap`).
#[allow(clippy::too_many_arguments)]
fn build_rebase_opcodes(
    data_relocs: &[crate::c5::program::DataReloc],
    code_relocs: &[crate::c5::program::CodeReloc],
    label_relocs: &[crate::c5::codegen::LabelReloc],
    data_slot: &dyn Fn(u64) -> (u8, u64),
    tls_segment: u8,
    tls_sites: &[(usize, u64)],
    thread_storage_offset_in_segment: u64,
) -> Vec<u8> {
    if data_relocs.is_empty()
        && code_relocs.is_empty()
        && label_relocs.is_empty()
        && tls_sites.is_empty()
    {
        return Vec::new();
    }
    let mut out = Vec::new();
    out.push(REBASE_OPCODE_SET_TYPE_IMM | REBASE_TYPE_POINTER);
    // Data-pointer, code-pointer and TLS-template slots all need the same
    // pointer-typed rebase opcode -- dyld just adds the slide. Sort the
    // merged list by segment offset so a future contiguous-burst pass can
    // walk it cleanly.
    let mut all: Vec<(u8, u64)> = Vec::with_capacity(
        data_relocs.len() + code_relocs.len() + label_relocs.len() + tls_sites.len(),
    );
    all.extend(data_relocs.iter().map(|r| data_slot(r.data_offset)));
    all.extend(code_relocs.iter().map(|r| data_slot(r.data_offset)));
    all.extend(label_relocs.iter().map(|r| data_slot(r.data_offset)));
    all.extend(
        tls_sites
            .iter()
            .map(|&(off, _)| (tls_segment, thread_storage_offset_in_segment + off as u64)),
    );
    all.sort();
    for &(segment, seg_off) in &all {
        out.push(REBASE_OPCODE_SET_SEGMENT_AND_OFFSET_ULEB | (segment & 0x0F));
        put_uleb128(&mut out, seg_off);
        out.push(REBASE_OPCODE_DO_REBASE_IMM_TIMES | 1);
    }
    out.push(REBASE_OPCODE_DONE);
    pad_to(&mut out, 8);
    out
}

/// Source library a bind opcode selects: the flat-lookup pseudo-dylib or a
/// 1-based LC_LOAD_DYLIB ordinal.
#[derive(PartialEq, Clone, Copy)]
enum BindSource {
    Flat,
    Dylib(u64),
}

/// Emit the dylib-selection opcode for `source`.
fn push_bind_source(out: &mut Vec<u8>, source: BindSource) {
    match source {
        BindSource::Flat => {
            out.push(BIND_OPCODE_SET_DYLIB_SPECIAL_IMM | BIND_SPECIAL_DYLIB_FLAT_LOOKUP_IMM);
        }
        BindSource::Dylib(ord) if ord <= 0x0F => {
            out.push(BIND_OPCODE_SET_DYLIB_ORDINAL_IMM | (ord as u8));
        }
        BindSource::Dylib(ord) => {
            out.push(BIND_OPCODE_SET_DYLIB_ORDINAL_ULEB);
            put_uleb128(out, ord);
        }
    }
}

fn build_bind_opcodes(
    imports: &super::ResolvedImports,
    segment: u8,
    tlv_ctx: Option<TlvBindContext>,
) -> Vec<u8> {
    let mut out = Vec::new();
    out.push(BIND_OPCODE_SET_TYPE_IMM | BIND_TYPE_POINTER);
    let mut current_source: Option<BindSource> = None;
    for (i, imp) in imports.imports.iter().enumerate() {
        let source = if imp.flat_lookup {
            BindSource::Flat
        } else {
            BindSource::Dylib((imp.dylib_index + 1) as u64)
        };
        if current_source != Some(source) {
            push_bind_source(&mut out, source);
            current_source = Some(source);
        }
        out.push(BIND_OPCODE_SET_SYMBOL_TRAILING_FLAGS_IMM); // flags = 0
        out.extend_from_slice(imp.real_symbol.as_bytes());
        out.push(0); // NUL terminator
        out.push(BIND_OPCODE_SET_SEGMENT_AND_OFFSET_ULEB | (segment & 0x0F));
        put_uleb128(&mut out, (i * 8) as u64);
        out.push(BIND_OPCODE_DO_BIND);
    }
    if let Some(ctx) = tlv_ctx {
        let bootstrap_source = BindSource::Dylib(ctx.bootstrap_ordinal);
        if current_source != Some(bootstrap_source) {
            push_bind_source(&mut out, bootstrap_source);
        }
        out.push(BIND_OPCODE_SET_SYMBOL_TRAILING_FLAGS_IMM); // flags = 0
        out.extend_from_slice(TLV_BOOTSTRAP_SYMBOL.as_bytes());
        out.push(0);
        for i in 0..ctx.tlv_count {
            out.push(BIND_OPCODE_SET_SEGMENT_AND_OFFSET_ULEB | (segment & 0x0F));
            put_uleb128(
                &mut out,
                ctx.segment_offset + (i as u64) * TLV_DESCRIPTOR_SIZE,
            );
            out.push(BIND_OPCODE_DO_BIND);
        }
    }
    out.push(BIND_OPCODE_DONE);
    pad_to(&mut out, 8);
    out
}

/// The nlist library ordinal for an import, mirroring the bind stream's
/// flat-lookup branch so the symbol table and the bind opcodes agree on the
/// symbol's provenance: a flat-lookup import carries
/// `DYNAMIC_LOOKUP_ORDINAL`, a two-level import its 1-based dylib ordinal.
fn import_library_ordinal(imp: &super::ResolvedImport) -> u8 {
    if imp.flat_lookup {
        DYNAMIC_LOOKUP_ORDINAL
    } else {
        (imp.dylib_index + 1) as u8
    }
}

/// One `nlist_64` for an undefined external symbol.
fn nlist_undef(n_strx: u32, ordinal: u8) -> Vec<u8> {
    let mut out = Vec::with_capacity(NLIST_64_SIZE);
    write_struct(
        &mut out,
        &Nlist64 {
            n_strx,
            n_type: N_EXT | N_UNDF,
            n_sect: NO_SECT,
            n_desc: (ordinal as u16) << 8, // library ordinal in the high 8 bits
            n_value: 0,                    // undefined
        },
    );
    debug_assert_eq!(out.len(), NLIST_64_SIZE);
    out
}

/// One `nlist_64` for a symbol defined in this image (an exported
/// function).
fn nlist_local(n_strx: u32, n_value: u64, n_sect: u8) -> Vec<u8> {
    let mut out = Vec::with_capacity(NLIST_64_SIZE);
    write_struct(
        &mut out,
        &Nlist64 {
            n_strx,
            n_type: N_SECT,
            n_sect,
            n_desc: 0,
            n_value,
        },
    );
    debug_assert_eq!(out.len(), NLIST_64_SIZE);
    out
}

fn nlist_defined(n_strx: u32, n_value: u64, n_sect: u8, weak: bool) -> Vec<u8> {
    let mut out = Vec::with_capacity(NLIST_64_SIZE);
    write_struct(
        &mut out,
        &Nlist64 {
            n_strx,
            n_type: N_EXT | N_SECT,
            n_sect,
            n_desc: if weak { N_WEAK_DEF } else { 0 },
            n_value,
        },
    );
    debug_assert_eq!(out.len(), NLIST_64_SIZE);
    out
}

/// Build the Mach-O string table (Mach-O strings are NUL-separated and
/// start with a single leading NUL so that `n_strx == 0` can mean "no
/// name").
fn build_strtab(symbols: &[&str]) -> (Vec<u8>, Vec<u32>) {
    let mut strtab = Vec::new();
    strtab.push(0); // leading NUL
    let mut indices = Vec::with_capacity(symbols.len());
    for s in symbols {
        indices.push(strtab.len() as u32);
        strtab.extend_from_slice(s.as_bytes());
        strtab.push(0);
    }
    pad_to(&mut strtab, 8);
    (strtab, indices)
}

const CODESIGN_LC_PAD: u64 = 64;

/// Byte sizes of the load-command stream and the variable-length commands
/// that are built to be measured.
#[derive(Default)]
struct Commands {
    dylinker: Vec<u8>,
    dylib_lcs: Vec<Vec<u8>>,
    build_version: Vec<u8>,
    uuid: Vec<u8>,
    /// `LC_ID_DYLIB` for a shared library; an executable takes `LC_MAIN`
    /// instead.
    id_dylib: Option<Vec<u8>>,
    text_seg_size: u64,
    data_const_seg_size: u64,
    data_seg_size: u64,
    dwarf_seg_size: u64,
    sizeofcmds: u64,
}

/// Where the image's regions land in the file and in memory.
#[derive(Default)]
struct Layout {
    ro_len: u64,
    relro_total: u64,
    relro_size: u64,
    data_const_present: bool,
    provenance: Vec<u8>,
    /// The read-only family head: `__TEXT,__const` covers
    /// `data[..ro_head]`, the named run `data[ro_head..ro_len]`.
    ro_head: u64,
    relro_head_len: u64,
    data_head_len: u64,
    bss_head_len: u64,
    const_marker_off: u64,
    jt_len: u64,
    jt_off: u64,
    const_size: u64,
    named_ro_align: u64,
    /// The `__TEXT` named run follows `__const`'s tail as one block,
    /// shifted by this from its data-stream offset.
    named_ro_shift: u64,
    named_ro_size: u64,
    const_region_size: u64,
    counts: NamedCounts,
    has_bss_section: bool,
    header_plus_lcs: u64,
    text_align: u64,
    entry_file_offset: u64,
    lc_pad_bytes: usize,
    ro_align: u64,
    const_fileoff: u64,
    text_filesize: u64,
    data_const_fileoff: u64,
    data_const_size: u64,
    data_fileoff: u64,
    got_size: u64,
    data_align: u64,
    data_section_offset_in_segment: u64,
    program_data_size: u64,
    writable_data_size: u64,
    thread_vars_size: u64,
    thread_vars_offset_in_segment: u64,
    thread_storage_size: u64,
    thread_storage_offset_in_segment: u64,
    thread_storage_initialised: bool,
    data_filesize: u64,
    data_vmsize: u64,
    bss_base_vmaddr: u64,
    /// Section indices: the read-only named run follows `__const`, the
    /// relro one `__DATA_CONST,__const`, the data one `__data`, the bss one
    /// `__bss`.
    idx_named_const: u8,
    idx_data_const: u8,
    idx_named_data_const: u8,
    idx_got: u8,
    idx_data: u8,
    idx_named_data: u8,
    idx_bss: u8,
    idx_named_bss: u8,
}

impl Layout {
    fn const_vmaddr(&self) -> u64 {
        TEXT_VMADDR_BASE + self.const_fileoff
    }

    fn data_const_vmaddr(&self) -> u64 {
        TEXT_VMADDR_BASE + self.text_filesize
    }

    fn data_vmaddr(&self) -> u64 {
        self.data_const_vmaddr() + self.data_const_size
    }

    fn code_vmaddr_base(&self) -> u64 {
        TEXT_VMADDR_BASE + self.entry_file_offset
    }

    fn data_section_vmaddr(&self) -> u64 {
        self.data_vmaddr() + self.data_section_offset_in_segment
    }

    fn data_section_fileoff(&self) -> u64 {
        self.data_fileoff + self.data_section_offset_in_segment
    }

    fn thread_vars_vmaddr(&self) -> u64 {
        self.data_vmaddr() + self.thread_vars_offset_in_segment
    }

    fn thread_vars_fileoff(&self) -> u64 {
        self.data_fileoff + self.thread_vars_offset_in_segment
    }

    fn thread_storage_vmaddr(&self) -> u64 {
        self.data_vmaddr() + self.thread_storage_offset_in_segment
    }

    fn thread_storage_fileoff(&self) -> u64 {
        self.data_fileoff + self.thread_storage_offset_in_segment
    }

    /// The data stream's regions at their runtime addresses: the read-only
    /// head, the read-only named run past the tables, the relro region,
    /// `__data`, `__bss`.
    fn data_regions(&self) -> [DataRegion; 5] {
        let open = |start, base| DataRegion {
            start,
            base,
            len: u64::MAX,
        };
        [
            open(0, self.const_vmaddr()),
            open(
                self.ro_head,
                self.const_vmaddr() + self.ro_head + self.named_ro_shift,
            ),
            open(self.ro_len, self.data_const_vmaddr()),
            open(self.relro_total, self.data_section_vmaddr()),
            open(self.program_data_size, self.bss_base_vmaddr),
        ]
    }

    fn data_off_to_vaddr(&self, off: u64) -> u64 {
        data_region_addr(&self.data_regions(), off)
    }
}

/// The `__LINKEDIT` contents and the `__DWARF` segment.
#[derive(Default)]
struct LinkEdit {
    bind_ops: Vec<u8>,
    rebase_ops: Vec<u8>,
    symbol_count: usize,
    n_locals: usize,
    n_exports: usize,
    n_undef: usize,
    strtab: Vec<u8>,
    symtab: Vec<u8>,
    export_trie: Vec<u8>,
    dwarf: dwarf::DwarfSections,
    dwarf_fileoff: u64,
    dwarf_info_offset: u64,
    dwarf_abbrev_offset: u64,
    dwarf_line_offset: u64,
    dwarf_str_offset: u64,
    dwarf_frame_offset: u64,
    dwarf_filesize: u64,
    dwarf_tail_pad: usize,
    dwarf_vmaddr: u64,
    dwarf_vmsize: u64,
    linkedit_fileoff: u64,
    rebase_off: u64,
    bind_off: u64,
    export_off: u64,
    symoff: u64,
    stroff: u64,
    linkedit_filesize: u64,
    linkedit_vmaddr: u64,
    linkedit_vmsize: u64,
}

/// One Mach-O image's writer. [`write`] runs the phases in order: the
/// load-command sizes, the segment layout, the `__LINKEDIT` tables, the
/// `__DWARF` and `__LINKEDIT` placement, the load commands, then the
/// emission of each segment.
struct MachOWriter<'a> {
    program: &'a Program,
    build: &'a Build,
    is_dylib: bool,
    tls_present: bool,
    n_tlv: usize,
    emit_dwarf: bool,
    named: Vec<&'a crate::c5::codegen::NamedSection>,
    named_out: Vec<NamedOut<'a>>,
    commands: Commands,
    layout: Layout,
    linkedit: LinkEdit,
    lcs: Vec<Vec<u8>>,
    out: Vec<u8>,
}

pub(super) fn write(program: &Program, build: &Build) -> Result<Vec<u8>, C5Error> {
    let mut w = MachOWriter::new(program, build)?;
    w.size_load_commands();
    w.layout_segments();
    w.build_linkedit_streams()?;
    w.build_symbol_tables()?;
    w.layout_dwarf_and_linkedit()?;
    w.build_load_commands()?;
    w.emit_header_and_commands();
    w.emit_text_segment()?;
    w.emit_data_segments()?;
    w.emit_dwarf_and_linkedit();
    w.finish()
}

impl<'a> MachOWriter<'a> {
    fn new(program: &'a Program, build: &'a Build) -> Result<Self, C5Error> {
        // The pc-relative data-word carriers have no Mach-O placement.
        // TODO
        if !build.data_pcrel_relocs.is_empty()
            || !build.text_pcrel_relocs.is_empty()
            || !build.text_abs_relocs.is_empty()
        {
            return Err(Self::internal(String::from(
                "Mach-O writer: pc-relative data-word slots not implemented",
            )));
        }
        if !build.rodata.abs64.is_empty() {
            return Err(Self::internal(String::from(
                "Mach-O writer: absolute table slots reached an image build",
            )));
        }
        Ok(MachOWriter {
            program,
            build,
            is_dylib: build.output_kind == super::OutputKind::SharedLibrary,
            tls_present: !build.macho_tlv_descriptors.is_empty(),
            n_tlv: build.macho_tlv_descriptors.len(),
            emit_dwarf: build.debug_info,
            named: build.named_sections.iter().collect(),
            named_out: Vec::new(),
            commands: Commands::default(),
            layout: Layout::default(),
            linkedit: LinkEdit::default(),
            lcs: Vec::new(),
            out: Vec::new(),
        })
    }

    fn internal(msg: String) -> C5Error {
        C5Error::internal(&msg)
    }

    /// Family whose region holds a named section's bytes.
    fn named_family(&self, n: &crate::c5::codegen::NamedSection) -> NamedFamily {
        if n.bss {
            NamedFamily::Bss
        } else if n.offset < self.layout.ro_len {
            NamedFamily::Const
        } else if n.offset < self.layout.relro_total {
            NamedFamily::DataConst
        } else {
            NamedFamily::Data
        }
    }

    /// The region a family's own section covers, stopping where its first
    /// named section begins.
    fn head_of(&self, f: NamedFamily, full: u64) -> u64 {
        self.named
            .iter()
            .filter(|n| self.named_family(n) == f)
            .map(|n| n.offset)
            .min()
            .unwrap_or(full)
    }

    fn named_count(&self, f: NamedFamily) -> usize {
        self.named
            .iter()
            .filter(|n| self.named_family(n) == f)
            .count()
    }

    /// Every load command's size, so the header and the code placement past
    /// the stream are known.
    fn size_load_commands(&mut self) {
        let build = self.build;
        let ro_len = build.data_ro_len.min(build.data.len()) as u64;
        let relro_total = build
            .data_relro_len
            .clamp(build.data_ro_len, build.data.len()) as u64;
        self.layout.ro_len = ro_len;
        self.layout.relro_total = relro_total;
        let ro_head = self.head_of(NamedFamily::Const, ro_len);
        let relro_head_len = self.head_of(NamedFamily::DataConst, relro_total) - ro_len;
        let data_head_len = self.head_of(NamedFamily::Data, build.data.len() as u64) - relro_total;
        let bss_head_len = self.head_of(NamedFamily::Bss, build.bss_size as u64);
        let named_ro_align = self
            .named
            .iter()
            .filter(|n| self.named_family(n) == NamedFamily::Const)
            .map(|n| n.align.max(1))
            .max()
            .unwrap_or(1);
        let counts = NamedCounts {
            konst: self.named_count(NamedFamily::Const) as u8,
            data_const: self.named_count(NamedFamily::DataConst) as u8,
            data: self.named_count(NamedFamily::Data) as u8,
        };
        let named_bss_count = self.named_count(NamedFamily::Bss) as u64;
        let l = &mut self.layout;
        l.relro_size = relro_total - ro_len;
        l.data_const_present = l.relro_size > 0;
        l.provenance = super::provenance_comment();
        l.ro_head = ro_head;
        l.relro_head_len = relro_head_len;
        l.data_head_len = data_head_len;
        l.bss_head_len = bss_head_len;
        l.const_marker_off = round_up(l.ro_head, 8);
        l.jt_len = build.rodata.bytes.len() as u64;
        let const_tail = l.const_marker_off + l.provenance.len() as u64;
        l.jt_off = round_up(const_tail, 8);
        l.const_size = if l.jt_len > 0 {
            l.jt_off + l.jt_len
        } else {
            const_tail
        };
        l.named_ro_align = named_ro_align;
        l.named_ro_shift = round_up(l.const_size - l.ro_head, l.named_ro_align);
        l.named_ro_size = ro_len - l.ro_head;
        l.const_region_size = if l.named_ro_size > 0 {
            l.ro_head + l.named_ro_shift + l.named_ro_size
        } else {
            l.const_size
        };
        l.counts = counts;
        let c = &mut self.commands;
        c.text_seg_size =
            (SEGMENT_COMMAND_64_SIZE + (2 + l.counts.konst as usize) * SECTION_64_SIZE) as u64;
        c.data_const_seg_size = if l.data_const_present {
            (SEGMENT_COMMAND_64_SIZE + (1 + l.counts.data_const as usize) * SECTION_64_SIZE) as u64
        } else {
            0
        };
        l.has_bss_section = build.bss_size > 0;
        let data_seg_section_count: u64 = (if self.tls_present { 4 } else { 2 })
            + if l.has_bss_section { 1 } else { 0 }
            + l.counts.data as u64
            + named_bss_count;
        c.data_seg_size =
            SEGMENT_COMMAND_64_SIZE as u64 + data_seg_section_count * SECTION_64_SIZE as u64;
        c.dwarf_seg_size = if self.emit_dwarf {
            (SEGMENT_COMMAND_64_SIZE + 5 * SECTION_64_SIZE) as u64
        } else {
            0
        };
        c.dylinker = load_dylinker("/usr/lib/dyld");
        c.dylib_lcs = build
            .imports
            .dylibs
            .iter()
            .map(|d| load_dylib(&d.path))
            .collect();
        c.build_version = build_version();
        c.uuid = uuid_command(&build.text, &build.data, &build.rodata);
        // The install name is `@rpath/<name>`, so a consumer linking by
        // name resolves it through its rpath at runtime.
        c.id_dylib = self.is_dylib.then(|| {
            let install_name = match build.shared_lib_name.as_deref() {
                Some(name) => alloc::format!("@rpath/{name}"),
                None => alloc::string::String::from("@rpath/c5-output.dylib"),
            };
            id_dylib(&install_name)
        });
        let dylibs_total: u64 = c.dylib_lcs.iter().map(|lc| lc.len() as u64).sum();
        let entry_lc_size = match &c.id_dylib {
            Some(lc) => lc.len() as u64,
            None => ENTRY_POINT_COMMAND_SIZE as u64,
        };
        c.sizeofcmds = SEGMENT_COMMAND_64_SIZE as u64
            + c.text_seg_size
            + c.data_const_seg_size
            + c.data_seg_size
            + SEGMENT_COMMAND_64_SIZE as u64
            + c.dwarf_seg_size
            + DYLD_INFO_COMMAND_SIZE as u64
            + SYMTAB_COMMAND_SIZE as u64
            + DYSYMTAB_COMMAND_SIZE as u64
            + c.dylinker.len() as u64
            + dylibs_total
            + c.build_version.len() as u64
            + c.uuid.len() as u64
            + entry_lc_size;
    }

    /// The file and vmaddr layout.
    fn layout_segments(&mut self) {
        let build = self.build;
        let l = &mut self.layout;
        l.header_plus_lcs = MACH_HEADER_64_SIZE as u64 + self.commands.sizeofcmds;
        l.text_align = build.text_align.max(16) as u64;
        l.entry_file_offset = round_up(l.header_plus_lcs + CODESIGN_LC_PAD, l.text_align);
        l.lc_pad_bytes = (l.entry_file_offset - l.header_plus_lcs) as usize;
        let code_size = build.text.len() as u64;
        l.ro_align =
            (crate::c5::layout::data_image_align(build.data_align) as u64).max(l.named_ro_align);
        l.const_fileoff = round_up(l.entry_file_offset + code_size, l.ro_align);
        l.text_filesize = round_up(l.const_fileoff + l.const_region_size, PAGE_SIZE);
        l.data_const_fileoff = l.text_filesize;
        l.data_const_size = if l.data_const_present {
            round_up(l.relro_size, PAGE_SIZE)
        } else {
            0
        };
        l.data_fileoff = l.data_const_fileoff + l.data_const_size;
        l.got_size = (build.imports.imports.len() * 8) as u64;
        l.data_align = crate::c5::layout::data_image_align(build.data_align) as u64;
        l.data_section_offset_in_segment = round_up(l.got_size, l.data_align);
        l.program_data_size = build.data.len() as u64;
        l.writable_data_size = l.program_data_size - l.relro_total;
        let post_data_offset_in_segment: u64 =
            round_up(l.data_section_offset_in_segment + l.writable_data_size, 8);
        l.thread_vars_size = (self.n_tlv as u64) * TLV_DESCRIPTOR_SIZE;
        l.thread_vars_offset_in_segment = if self.tls_present {
            post_data_offset_in_segment
        } else {
            0
        };
        l.thread_storage_size = build.tls_data.len() as u64;
        l.thread_storage_offset_in_segment = if self.tls_present {
            l.thread_vars_offset_in_segment + l.thread_vars_size
        } else {
            0
        };
        l.thread_storage_initialised = build.tls_init_size > 0;
        let data_segment_file_used: u64 = if self.tls_present {
            if l.thread_storage_initialised {
                l.thread_storage_offset_in_segment + l.thread_storage_size
            } else {
                l.thread_vars_offset_in_segment + l.thread_vars_size
            }
        } else {
            l.data_section_offset_in_segment + l.writable_data_size
        };
        let data_segment_vm_used: u64 = if self.tls_present {
            l.thread_storage_offset_in_segment + l.thread_storage_size + build.bss_size as u64
        } else {
            data_segment_file_used + build.bss_size as u64
        };
        l.data_filesize = round_up(data_segment_file_used.max(PAGE_SIZE), PAGE_SIZE);
        l.data_vmsize = round_up(data_segment_vm_used.max(PAGE_SIZE), PAGE_SIZE);
        l.bss_base_vmaddr = if self.tls_present {
            l.thread_storage_vmaddr() + l.thread_storage_size
        } else {
            l.data_section_vmaddr() + l.writable_data_size
        };
        let named_out: Vec<NamedOut> = self
            .named
            .iter()
            .map(|n| {
                let family = self.named_family(n);
                let (addr, fileoff) = match family {
                    NamedFamily::Bss => (self.layout.bss_base_vmaddr + n.offset, 0),
                    _ => {
                        let a = self.data_off_to_vaddr(n.offset);
                        let l = &self.layout;
                        let f = match family {
                            NamedFamily::Const => l.const_fileoff + (a - l.const_vmaddr()),
                            NamedFamily::DataConst => {
                                l.data_const_fileoff + (a - l.data_const_vmaddr())
                            }
                            _ => l.data_fileoff + (a - l.data_vmaddr()),
                        };
                        (a, f as u32)
                    }
                };
                NamedOut {
                    name: &n.name,
                    family,
                    start: n.offset,
                    size: n.size,
                    addr,
                    fileoff,
                    align_log2: n.align.max(1).trailing_zeros(),
                }
            })
            .collect();
        self.named_out = named_out;
        let l = &mut self.layout;
        l.idx_named_const = SECT_INDEX_CONST + 1;
        l.idx_data_const = l.idx_named_const + l.counts.konst;
        l.idx_named_data_const = l.idx_data_const + 1;
        l.idx_got = if l.data_const_present {
            l.idx_named_data_const + l.counts.data_const
        } else {
            l.idx_data_const
        };
        l.idx_data = l.idx_got + 1;
        l.idx_named_data = l.idx_data + 1;
        l.idx_bss = l.idx_named_data + l.counts.data + if self.tls_present { 2 } else { 0 };
        l.idx_named_bss = l.idx_bss + u8::from(l.has_bss_section);
    }

    fn data_off_to_vaddr(&self, off: u64) -> u64 {
        self.layout.data_off_to_vaddr(off)
    }

    /// The named sections of one family, in address order.
    fn named_in(&self, f: NamedFamily) -> Vec<&NamedOut<'a>> {
        let mut v: Vec<&NamedOut> = self.named_out.iter().filter(|n| n.family == f).collect();
        v.sort_by_key(|n| n.addr);
        v
    }

    /// Section holding a data-stream offset: the named section covering it,
    /// else its family's own.
    fn data_off_sect_index(&self, off: u64) -> u8 {
        let l = &self.layout;
        let runs: [(NamedFamily, u8, u64); 4] = [
            (NamedFamily::Const, l.idx_named_const, 0),
            (NamedFamily::DataConst, l.idx_named_data_const, 0),
            (NamedFamily::Data, l.idx_named_data, 0),
            (NamedFamily::Bss, l.idx_named_bss, l.program_data_size),
        ];
        for (family, base, origin) in runs {
            let rel = off.wrapping_sub(origin);
            if off >= origin
                && let Some(k) = self
                    .named_in(family)
                    .iter()
                    .position(|n| rel >= n.start && rel < n.start + n.size)
            {
                return base + k as u8;
            }
        }
        if off < l.ro_len {
            SECT_INDEX_CONST
        } else if off < l.relro_total {
            l.idx_data_const
        } else if off < l.program_data_size {
            l.idx_data
        } else {
            l.idx_bss
        }
    }

    /// The bind stream (every imported symbol, plus each TLV descriptor's
    /// slot 0 bound to `__tlv_bootstrap`) and the rebase stream (every
    /// absolute pointer in static data and in the TLS template; the file
    /// holds the preferred address and dyld adds the slide).
    fn build_linkedit_streams(&mut self) -> Result<(), C5Error> {
        let build = self.build;
        let l = &self.layout;
        let seg_data = seg_index_data(l.data_const_present);
        self.linkedit.bind_ops = build_bind_opcodes(
            &build.imports,
            seg_data,
            if self.tls_present {
                Some(TlvBindContext {
                    segment_offset: l.thread_vars_offset_in_segment,
                    tlv_count: self.n_tlv,
                    bootstrap_ordinal: tlv_bootstrap_ordinal(&build.imports.dylibs)?,
                })
            } else {
                None
            },
        );
        let data_slot = |off: u64| -> (u8, u64) {
            if off < l.relro_total {
                (SEG_INDEX_DATA_CONST, off.saturating_sub(l.ro_len))
            } else {
                (
                    seg_data,
                    l.data_section_offset_in_segment + (off - l.relro_total),
                )
            }
        };
        self.linkedit.rebase_ops = build_rebase_opcodes(
            &build.data_relocs,
            &build.code_relocs,
            &build.label_relocs,
            &data_slot,
            seg_data,
            &self.tls_reloc_sites()?,
            l.thread_storage_offset_in_segment,
        );
        Ok(())
    }

    fn tls_reloc_sites(&self) -> Result<Vec<(usize, u64)>, C5Error> {
        image::tls_reloc_sites(
            "Mach-O",
            self.build,
            &|off| self.data_off_to_vaddr(off),
            self.layout.code_vmaddr_base(),
        )
    }

    /// The symbol and string tables, laid out `[locals][exports]
    /// [imports][tlv-bootstrap?]` so the `LC_DYSYMTAB` ranges are
    /// contiguous.
    fn build_symbol_tables(&mut self) -> Result<(), C5Error> {
        let build = self.build;
        let code_vmaddr_base = self.layout.code_vmaddr_base();
        let export_disk_names: Vec<String> = build
            .exports
            .iter()
            .map(|e| format!("_{}", e.name))
            .collect();
        let plt_locals: Vec<(&str, usize)> = build
            .imports
            .imports
            .iter()
            .zip(build.plt_trampoline_offsets.iter())
            .filter_map(|(imp, off)| off.map(|o| (imp.local_name.as_str(), o)))
            .collect();
        let mut symbol_names: Vec<&str> = plt_locals.iter().map(|&(name, _)| name).collect();
        let pragma_export_names: alloc::collections::BTreeSet<&str> =
            build.exports.iter().map(|e| e.name.as_str()).collect();
        let dyn_exports_emit: Vec<&crate::c5::codegen::DynamicExport> = build
            .dynamic_exports
            .iter()
            .filter(|d| !pragma_export_names.contains(d.name.as_str()))
            .collect();
        let dyn_export_disk_names: Vec<String> = dyn_exports_emit
            .iter()
            .map(|d| format!("_{}", d.name))
            .collect();
        let n_locals = symbol_names.len();
        symbol_names.extend(export_disk_names.iter().map(|s| s.as_str()));
        symbol_names.extend(dyn_export_disk_names.iter().map(|s| s.as_str()));
        let n_exports = symbol_names.len() - n_locals;
        symbol_names.extend(build.imports.imports.iter().map(|i| i.real_symbol.as_str()));
        if self.tls_present {
            symbol_names.push(TLV_BOOTSTRAP_SYMBOL);
        }
        let (strtab, str_indices) = build_strtab(&symbol_names);
        let mut symtab = Vec::with_capacity(NLIST_64_SIZE * symbol_names.len());
        for (i, &(_, tramp_offset)) in plt_locals.iter().enumerate() {
            let n_value = code_vmaddr_base + tramp_offset as u64;
            symtab.extend_from_slice(&nlist_local(str_indices[i], n_value, SECT_INDEX_TEXT));
        }
        let mut export_trie_entries: Vec<(String, u64, u64)> = Vec::new();
        for (i, exp) in build.exports.iter().enumerate() {
            let n_strx = str_indices[n_locals + i];
            let native_off = build
                .pc_to_native
                .get(exp.ent_pc)
                .copied()
                .unwrap_or(usize::MAX);
            if native_off == usize::MAX {
                return Err(Self::internal(format!(
                    "Mach-O: exported function `{}` (bc PC {}) doesn't \
                 align with any native instruction",
                    exp.name, exp.ent_pc
                )));
            }
            let n_value = code_vmaddr_base + native_off as u64;
            symtab.extend_from_slice(&nlist_defined(n_strx, n_value, SECT_INDEX_TEXT, false));
            export_trie_entries.push((export_disk_names[i].clone(), n_value - TEXT_VMADDR_BASE, 0));
        }
        let dyn_export_str_base = n_locals + export_disk_names.len();
        for (i, d) in dyn_exports_emit.iter().enumerate() {
            let n_strx = str_indices[dyn_export_str_base + i];
            let (n_value, n_sect) = match d.section {
                crate::c5::codegen::DynamicExportSection::Text => {
                    (code_vmaddr_base + d.offset, SECT_INDEX_TEXT)
                }
                crate::c5::codegen::DynamicExportSection::Data => (
                    self.data_off_to_vaddr(d.offset),
                    self.data_off_sect_index(d.offset),
                ),
            };
            symtab.extend_from_slice(&nlist_defined(n_strx, n_value, n_sect, d.weak));
            export_trie_entries.push((
                dyn_export_disk_names[i].clone(),
                n_value - TEXT_VMADDR_BASE,
                if d.weak {
                    EXPORT_SYMBOL_FLAGS_WEAK_DEFINITION
                } else {
                    0
                },
            ));
        }
        for (j, imp) in build.imports.imports.iter().enumerate() {
            let n_strx = str_indices[n_locals + n_exports + j];
            symtab.extend_from_slice(&nlist_undef(n_strx, import_library_ordinal(imp)));
        }
        if self.tls_present {
            let bootstrap_dylib_ordinal = tlv_bootstrap_ordinal(&build.imports.dylibs)? as u8;
            let bootstrap_strx = str_indices[symbol_names.len() - 1];
            symtab.extend_from_slice(&nlist_undef(bootstrap_strx, bootstrap_dylib_ordinal));
        }
        let le = &mut self.linkedit;
        le.symbol_count = symbol_names.len();
        le.n_locals = n_locals;
        le.n_exports = n_exports;
        le.n_undef = symbol_names.len() - n_locals - n_exports;
        le.strtab = strtab;
        le.symtab = symtab;
        le.export_trie = build_export_trie(&export_trie_entries);
        Ok(())
    }

    /// `__DWARF` sits between `__DATA` and `__LINKEDIT` in both LC order
    /// and file order: `__LINKEDIT` has to remain the last file-resident
    /// segment because `codesign` grows it over the signature blob.
    fn layout_dwarf_and_linkedit(&mut self) -> Result<(), C5Error> {
        let (program, build) = (self.program, self.build);
        let l = &self.layout;
        let code_vmaddr_base = l.code_vmaddr_base();
        let le = &mut self.linkedit;
        le.dwarf_fileoff = l.data_fileoff + l.data_filesize;
        if self.emit_dwarf {
            let s = image::image_dwarf(
                program,
                build,
                super::Target::MacOSAarch64,
                code_vmaddr_base,
                None,
                Some(&|off| l.data_off_to_vaddr(off)),
            )?;
            le.dwarf_info_offset = le.dwarf_fileoff;
            le.dwarf_abbrev_offset = le.dwarf_info_offset + s.debug_info.len() as u64;
            le.dwarf_line_offset = le.dwarf_abbrev_offset + s.debug_abbrev.len() as u64;
            le.dwarf_str_offset = le.dwarf_line_offset + s.debug_line.len() as u64;
            le.dwarf_frame_offset = le.dwarf_str_offset + s.debug_str.len() as u64;
            let sections_size =
                le.dwarf_frame_offset + s.debug_frame.len() as u64 - le.dwarf_fileoff;
            le.dwarf_filesize = round_up(sections_size, PAGE_SIZE);
            le.dwarf_tail_pad = (le.dwarf_filesize - sections_size) as usize;
            le.dwarf = s;
        }
        le.linkedit_fileoff = le.dwarf_fileoff + le.dwarf_filesize;
        le.rebase_off = le.linkedit_fileoff;
        le.bind_off = le.rebase_off + le.rebase_ops.len() as u64;
        le.export_off = le.bind_off + le.bind_ops.len() as u64;
        le.symoff = le.export_off + le.export_trie.len() as u64;
        le.stroff = le.symoff + le.symtab.len() as u64;
        le.linkedit_filesize = (le.rebase_ops.len()
            + le.bind_ops.len()
            + le.export_trie.len()
            + le.symtab.len()
            + le.strtab.len()) as u64;
        le.dwarf_vmaddr = l.data_vmaddr() + l.data_vmsize;
        le.dwarf_vmsize = if self.emit_dwarf {
            round_up(le.dwarf_filesize, PAGE_SIZE)
        } else {
            0
        };
        le.linkedit_vmaddr = le.dwarf_vmaddr + le.dwarf_vmsize;
        le.linkedit_vmsize = round_up(le.linkedit_filesize.max(PAGE_SIZE), PAGE_SIZE);
        Ok(())
    }

    /// The segment commands, in file order.
    fn segment_commands(&self) -> Vec<Vec<u8>> {
        let build = self.build;
        let l = &self.layout;
        let le = &self.linkedit;
        let c = &self.commands;
        let named_const_out = self.named_in(NamedFamily::Const);
        let named_data_const_out = self.named_in(NamedFamily::DataConst);
        let named_data_out = self.named_in(NamedFamily::Data);
        let named_bss_out = self.named_in(NamedFamily::Bss);
        let place = |vmaddr, vmsize, fileoff, filesize| SegmentPlacement {
            vmaddr,
            vmsize,
            fileoff,
            filesize,
        };
        let section = |addr, size, offset: u64| SectionPlacement {
            addr,
            size,
            offset: offset as u32,
        };
        let mut lcs: Vec<Vec<u8>> = Vec::new();
        lcs.push(segment_no_sections(
            "__PAGEZERO",
            place(0, PAGEZERO_VMSIZE, 0, 0),
            0,
        ));
        let text_segment = segment_text(
            place(TEXT_VMADDR_BASE, l.text_filesize, 0, l.text_filesize),
            section(
                l.code_vmaddr_base(),
                build.text.len() as u64,
                l.entry_file_offset,
            ),
            section(l.const_vmaddr(), l.const_size, l.const_fileoff),
            l.ro_align.trailing_zeros(),
            &named_const_out,
        );
        debug_assert_eq!(text_segment.len() as u64, c.text_seg_size);
        lcs.push(text_segment);
        if l.data_const_present {
            let s = segment_data_const(
                place(
                    l.data_const_vmaddr(),
                    l.data_const_size,
                    l.data_const_fileoff,
                    l.data_const_size,
                ),
                l.relro_head_len,
                l.data_align.trailing_zeros(),
                &named_data_const_out,
            );
            debug_assert_eq!(s.len() as u64, c.data_const_seg_size);
            lcs.push(s);
        }
        let tlv = self.tls_present.then(|| TlvSections {
            vars: section(
                l.thread_vars_vmaddr(),
                l.thread_vars_size,
                l.thread_vars_fileoff(),
            ),
            storage: section(
                l.thread_storage_vmaddr(),
                l.thread_storage_size,
                l.thread_storage_fileoff(),
            ),
            initialised: l.thread_storage_initialised,
        });
        let data_segment = segment_data(
            place(
                l.data_vmaddr(),
                l.data_vmsize,
                l.data_fileoff,
                l.data_filesize,
            ),
            section(l.data_vmaddr(), l.got_size, l.data_fileoff),
            section(
                l.data_section_vmaddr(),
                l.data_head_len,
                l.data_section_fileoff(),
            ),
            l.data_align.trailing_zeros(),
            tlv,
            l.has_bss_section
                .then_some((l.bss_base_vmaddr, l.bss_head_len)),
            &named_data_out,
            &named_bss_out,
        );
        debug_assert_eq!(data_segment.len() as u64, c.data_seg_size);
        lcs.push(data_segment);
        if self.emit_dwarf {
            let d = &le.dwarf;
            let s = segment_dwarf(
                place(
                    le.dwarf_vmaddr,
                    le.dwarf_vmsize,
                    le.dwarf_fileoff,
                    le.dwarf_filesize,
                ),
                [
                    (le.dwarf_info_offset as u32, d.debug_info.len() as u64),
                    (le.dwarf_abbrev_offset as u32, d.debug_abbrev.len() as u64),
                    (le.dwarf_line_offset as u32, d.debug_line.len() as u64),
                    (le.dwarf_str_offset as u32, d.debug_str.len() as u64),
                    (le.dwarf_frame_offset as u32, d.debug_frame.len() as u64),
                ],
            );
            debug_assert_eq!(s.len() as u64, c.dwarf_seg_size);
            lcs.push(s);
        }
        lcs.push(segment_no_sections(
            "__LINKEDIT",
            place(
                le.linkedit_vmaddr,
                le.linkedit_vmsize,
                le.linkedit_fileoff,
                le.linkedit_filesize,
            ),
            VM_PROT_READ,
        ));
        lcs
    }

    /// The load commands, in Apple's order: segments first, then the
    /// dyld_info family, the symbol tables, the dylinker, the dylibs, the
    /// build version, the UUID, and `LC_MAIN` (or `LC_ID_DYLIB` for a
    /// shared library).
    fn build_load_commands(&mut self) -> Result<(), C5Error> {
        let build = self.build;
        let l = &self.layout;
        let le = &self.linkedit;
        let c = &self.commands;
        let mut lcs = self.segment_commands();
        lcs.push(dyld_info_only(
            le.rebase_off as u32,
            le.rebase_ops.len() as u32,
            le.bind_off as u32,
            le.bind_ops.len() as u32,
            0,
            0,
            0,
            0,
            le.export_off as u32,
            le.export_trie.len() as u32,
        ));
        lcs.push(symtab_command(
            le.symoff as u32,
            le.symbol_count as u32,
            le.stroff as u32,
            le.strtab.len() as u32,
        ));
        lcs.push(dysymtab_command(
            le.n_locals as u32,
            le.n_exports as u32,
            le.n_undef as u32,
        ));
        lcs.push(c.dylinker.clone());
        lcs.extend(c.dylib_lcs.iter().cloned());
        lcs.push(c.build_version.clone());
        lcs.push(c.uuid.clone());
        match &c.id_dylib {
            Some(lc) => lcs.push(lc.clone()),
            None => {
                let entry_native =
                    c5_entry_native_offset(build).unwrap_or(build.entry_offset as u64);
                lcs.push(main_command(l.entry_file_offset + entry_native));
            }
        }
        self.lcs = lcs;
        Ok(())
    }

    /// `mach_header_64` and the load-command stream, padded out to the code
    /// so `codesign` can insert `LC_CODE_SIGNATURE` in place.
    fn emit_header_and_commands(&mut self) {
        let build = self.build;
        let l = &self.layout;
        let le = &self.linkedit;
        let total_filesize = le.linkedit_fileoff + le.linkedit_filesize;
        let mut out: Vec<u8> = Vec::with_capacity(total_filesize as usize);
        let ncmds: u32 = 11
            + (l.data_const_present as u32)
            + (self.emit_dwarf as u32)
            + build.imports.dylibs.len() as u32;
        let mut header_flags = MH_DYLDLINK | MH_TWOLEVEL | MH_PIE;
        if self.tls_present {
            header_flags |= MH_HAS_TLV_DESCRIPTORS;
        }
        write_struct(
            &mut out,
            &MachHeader64 {
                magic: MH_MAGIC_64,
                cputype: CPU_TYPE_ARM64,
                cpusubtype: CPU_SUBTYPE_ARM64_ALL,
                filetype: if self.is_dylib { MH_DYLIB } else { MH_EXECUTE },
                ncmds,
                sizeofcmds: self.commands.sizeofcmds as u32,
                flags: header_flags,
                reserved: 0,
            },
        );
        debug_assert_eq!(out.len(), MACH_HEADER_64_SIZE);
        debug_assert_eq!(self.lcs.len() as u32, ncmds);
        for lc in &self.lcs {
            out.extend_from_slice(lc);
        }
        debug_assert_eq!(out.len() as u64, l.header_plus_lcs);
        out.resize(out.len() + l.lc_pad_bytes, 0);
        debug_assert_eq!(out.len() as u64, l.entry_file_offset);
        self.out = out;
    }

    /// `__TEXT`: the code with its GOT, data, function-pointer, table and
    /// TLV descriptor references patched against the settled addresses,
    /// then `__const` (the read-only prefix verbatim, the fingerprint, the
    /// switch-table blob with each entry as the `target - table_base`
    /// difference) and the read-only named run, page-padded.
    fn emit_text_segment(&mut self) -> Result<(), C5Error> {
        let build = self.build;
        let l = &self.layout;
        let code_file_offset = self.out.len();
        let code_vmaddr_base = l.code_vmaddr_base();
        let const_vmaddr = l.const_vmaddr();
        let out = &mut self.out;
        out.extend_from_slice(&build.text);
        apply_got_fixups(
            out,
            code_file_offset,
            code_vmaddr_base,
            l.data_vmaddr(),
            &build.got_fixups,
        )?;
        if !build.got_base_fixups.is_empty() {
            return Err(C5Error::hard(
                Code::OBJECT_FORMAT,
                "`_GLOBAL_OFFSET_TABLE_` names an ELF construct; a Mach-O image has none",
            ));
        }
        apply_data_fixups(
            out,
            code_file_offset,
            code_vmaddr_base,
            &|off| l.data_off_to_vaddr(off),
            &build.data_fixups,
        )?;
        apply_func_fixups(out, code_file_offset, code_vmaddr_base, &build.func_fixups)?;
        for fx in &build.rodata.addr_fixups {
            patch_adrp_add(
                out,
                code_file_offset,
                code_vmaddr_base,
                fx.code_offset,
                const_vmaddr + l.jt_off + fx.rodata_offset,
                AddrPart::Whole,
                "table fixup",
            )?;
        }
        apply_macho_tlv_fixups(
            out,
            code_file_offset,
            code_vmaddr_base,
            l.thread_vars_vmaddr(),
            &build.macho_tlv_fixups,
        )?;
        out.resize(l.const_fileoff as usize, 0);
        out.extend_from_slice(&build.data[..l.ro_head as usize]);
        out.resize((l.const_fileoff + l.const_marker_off) as usize, 0);
        out.extend_from_slice(&l.provenance);
        if l.jt_len > 0 {
            out.resize((l.const_fileoff + l.jt_off) as usize, 0);
            out.extend_from_slice(&build.rodata.bytes);
            let jt_start = (l.const_fileoff + l.jt_off) as usize;
            image::patch_jump_table(
                "Mach-O",
                "table",
                &mut out[jt_start..],
                code_vmaddr_base,
                const_vmaddr + l.jt_off,
                &build.rodata.rel32,
            )?;
        }
        if l.named_ro_size > 0 {
            out.resize((l.const_fileoff + l.ro_head + l.named_ro_shift) as usize, 0);
            out.extend_from_slice(&build.data[l.ro_head as usize..l.ro_len as usize]);
        }
        out.resize(l.text_filesize as usize, 0);
        Ok(())
    }

    /// The data image with every pointer initializer materialized as its
    /// preferred address (dyld adds the slide through the rebase stream),
    /// split at the relro boundary into `__DATA_CONST,__const` and
    /// `__DATA,__data`; the `__got` slots ahead of it stay zero for the
    /// bind stream.
    fn emit_data_segments(&mut self) -> Result<(), C5Error> {
        let build = self.build;
        let l = &self.layout;
        let code_vmaddr_base = l.code_vmaddr_base();
        let ro_len = l.ro_len;
        let data = image::bake_data_relocs(
            "Mach-O",
            "__data",
            build,
            ro_len,
            code_vmaddr_base,
            &|off| self.data_off_to_vaddr(off),
        )?;
        let tls_sites = if self.tls_present && l.thread_storage_initialised {
            Some(self.tls_reloc_sites()?)
        } else {
            None
        };
        let out = &mut self.out;
        if l.data_const_present {
            out.resize(l.data_const_fileoff as usize, 0);
            out.extend_from_slice(&data[..l.relro_size as usize]);
        }
        out.resize(l.data_section_fileoff() as usize, 0);
        out.extend_from_slice(&data[l.relro_size as usize..]);
        if self.tls_present {
            out.resize(l.thread_vars_fileoff() as usize, 0);
            for desc in &build.macho_tlv_descriptors {
                out.extend_from_slice(&0u64.to_le_bytes());
                out.extend_from_slice(&0u64.to_le_bytes());
                out.extend_from_slice(&desc.offset_in_block.to_le_bytes());
            }
            if let Some(sites) = tls_sites {
                out.resize(l.thread_storage_fileoff() as usize, 0);
                let tls =
                    image::bake_tls_template("Mach-O", "__thread_data", &build.tls_data, &sites)?;
                out.extend_from_slice(&tls);
            }
        }
        out.resize((l.data_fileoff + l.data_filesize) as usize, 0);
        Ok(())
    }

    /// The `__DWARF` contents in the order `segment_dwarf` pointed at, then
    /// `__LINKEDIT` in the order `LC_DYLD_INFO_ONLY` names.
    fn emit_dwarf_and_linkedit(&mut self) {
        let le = &self.linkedit;
        let out = &mut self.out;
        if self.emit_dwarf {
            debug_assert_eq!(out.len() as u64, le.dwarf_fileoff);
            out.extend_from_slice(&le.dwarf.debug_info);
            out.extend_from_slice(&le.dwarf.debug_abbrev);
            out.extend_from_slice(&le.dwarf.debug_line);
            out.extend_from_slice(&le.dwarf.debug_str);
            out.extend_from_slice(&le.dwarf.debug_frame);
            out.resize(out.len() + le.dwarf_tail_pad, 0);
        }
        debug_assert_eq!(out.len() as u64, le.linkedit_fileoff);
        out.extend_from_slice(&le.rebase_ops);
        out.extend_from_slice(&le.bind_ops);
        out.extend_from_slice(&le.export_trie);
        out.extend_from_slice(&le.symtab);
        out.extend_from_slice(&le.strtab);
        debug_assert_eq!(out.len() as u64, le.linkedit_fileoff + le.linkedit_filesize);
    }

    fn finish(self) -> Result<Vec<u8>, C5Error> {
        if self.out.len() > u32::MAX as usize {
            return Err(Self::internal(format!(
                "Mach-O writer: image too large ({} bytes)",
                self.out.len()
            )));
        }
        Ok(self.out)
    }
}

#[cfg(test)]
mod tests {
    //! Verify the structural invariants of the emitted Mach-O.

    use super::*;

    fn tiny_program() -> Program {
        super::super::test_support::empty_program()
    }

    /// One imported function and one dylib, over a `movz x0, #42; ret`.
    fn tiny_build() -> Build {
        use super::super::{ResolvedImport, ResolvedImports};
        use crate::c5::codegen::ResolvedDylib;
        let mut build = super::super::test_support::empty_build();
        build.text = vec![0x40, 0x05, 0x80, 0xD2, 0xC0, 0x03, 0x5F, 0xD6];
        build.imports = ResolvedImports {
            data_bindings: Default::default(),
            imports: vec![ResolvedImport {
                binding_idx: 0,
                local_name: "write".into(),
                real_symbol: "_write".into(),
                dylib_index: 0,
                flat_lookup: false,
                is_object: false,
                is_variadic: false,
                fixed_args: 3,
                return_type_tag: 0,
                returns_long_double: false,
                param_types: Vec::new(),
            }],
            dylibs: vec![ResolvedDylib {
                name: "libc".into(),
                path: "/usr/lib/libSystem.B.dylib".into(),
            }],
        };
        build.abi = super::super::Target::MacOSAarch64.abi();
        build.output_kind = super::super::OutputKind::Executable;
        build.debug_info = true;
        build
    }

    fn read_u32(buf: &[u8], off: usize) -> u32 {
        u32::from_le_bytes(buf[off..off + 4].try_into().unwrap())
    }

    #[test]
    fn writes_mh_magic_64() {
        let bytes = write(&tiny_program(), &tiny_build()).unwrap();
        assert_eq!(read_u32(&bytes, 0), MH_MAGIC_64);
    }

    #[test]
    fn cpu_type_is_arm64() {
        let bytes = write(&tiny_program(), &tiny_build()).unwrap();
        assert_eq!(read_u32(&bytes, 4), CPU_TYPE_ARM64);
    }

    #[test]
    fn filetype_is_mh_execute() {
        let bytes = write(&tiny_program(), &tiny_build()).unwrap();
        assert_eq!(read_u32(&bytes, 12), MH_EXECUTE);
    }

    #[test]
    fn flags_include_pie_and_dyldlink() {
        let bytes = write(&tiny_program(), &tiny_build()).unwrap();
        let flags = read_u32(&bytes, 24);
        assert_ne!(flags & MH_PIE, 0, "MH_PIE not set");
        assert_ne!(flags & MH_DYLDLINK, 0, "MH_DYLDLINK not set");
    }

    #[test]
    fn ncmds_baseline_is_twelve_plus_dylibs() {
        let bytes = write(&tiny_program(), &tiny_build()).unwrap();
        assert_eq!(read_u32(&bytes, 16), 13);
    }

    #[test]
    fn lc_main_entry_lands_on_first_instruction_byte() {
        // Find LC_MAIN, read entryoff, check the byte at that offset is the
        // first instruction byte we passed in (the `movz x0, #42` from
        // tiny_build() starts with 0x40 in little-endian). We have to look
        // up entryoff rather than computing it as (32 + sizeofcmds),
        // because we leave padding between the LC stream and the code so
        // codesign can grow the LCs in place without overwriting the entry
        // point.
        let bytes = write(&tiny_program(), &tiny_build()).unwrap();
        let sizeofcmds = read_u32(&bytes, 20) as usize;
        let mut p = 32usize;
        let lc_end = 32 + sizeofcmds;
        while p < lc_end {
            let cmd = read_u32(&bytes, p);
            let cmdsize = read_u32(&bytes, p + 4) as usize;
            if cmd == LC_MAIN {
                let entryoff =
                    u64::from_le_bytes(bytes[p + 8..p + 16].try_into().unwrap()) as usize;
                assert_eq!(
                    bytes[entryoff], 0x40,
                    "first byte at entry offset {entryoff:#x} != 0x40"
                );
                assert!(
                    entryoff > lc_end,
                    "entry offset {entryoff:#x} should sit past LC stream end {lc_end:#x}"
                );
                return;
            }
            p += cmdsize;
        }
        panic!("LC_MAIN not found");
    }

    #[test]
    fn output_alignment_invariants() {
        let bytes = write(&tiny_program(), &tiny_build()).unwrap();
        // strtab is padded to 8 bytes, so the whole image is too.
        assert_eq!(bytes.len() % 8, 0);
        assert!(
            bytes.len() as u64 > 2 * PAGE_SIZE,
            "image too small: {} bytes",
            bytes.len()
        );
    }

    /// `__tlv_bootstrap` binds against libSystem's real ordinal; an image
    /// whose dylib list lacks libSystem cannot bind the TLV descriptors and
    /// must fail rather than guess ordinal 1.
    #[test]
    fn tlv_bootstrap_ordinal_requires_libsystem() {
        use crate::c5::codegen::ResolvedDylib;
        let dylibs = vec![
            ResolvedDylib {
                name: "libfoo".into(),
                path: "/usr/lib/libfoo.dylib".into(),
            },
            ResolvedDylib {
                name: "libSystem".into(),
                path: "/usr/lib/libSystem.B.dylib".into(),
            },
        ];
        assert_eq!(tlv_bootstrap_ordinal(&dylibs).unwrap(), 2);
        assert!(tlv_bootstrap_ordinal(&dylibs[..1]).is_err());
    }

    #[test]
    fn uleb128_round_trips() {
        let cases: &[(u64, &[u8])] = &[
            (0, &[0x00]),
            (1, &[0x01]),
            (0x7F, &[0x7F]),
            (0x80, &[0x80, 0x01]),
            (0x4000, &[0x80, 0x80, 0x01]),
        ];
        for (value, expected) in cases {
            let mut out = Vec::new();
            put_uleb128(&mut out, *value);
            assert_eq!(&out[..], *expected, "uleb128({value})");
        }
    }

    fn sample_import(dylib_index: usize, flat_lookup: bool) -> super::super::ResolvedImport {
        use super::super::ResolvedImport;
        ResolvedImport {
            binding_idx: dylib_index as i64,
            local_name: format!("s{dylib_index}"),
            real_symbol: format!("_s{dylib_index}"),
            dylib_index,
            flat_lookup,
            is_object: false,
            is_variadic: false,
            fixed_args: 0,
            return_type_tag: 0,
            returns_long_double: false,
            param_types: Vec::new(),
        }
    }

    #[test]
    fn bind_dylib_ordinal_past_15_uses_uleb() {
        use super::super::ResolvedImports;
        use crate::c5::codegen::ResolvedDylib;
        // 20 distinct dylibs: ordinals 16 and 17 (dylib_index 15 / 16)
        // exceed the IMM opcode's 4-bit operand and must switch to the ULEB
        // form instead of wrapping to a wrong library.
        let dylibs: Vec<ResolvedDylib> = (0..20)
            .map(|i| ResolvedDylib {
                name: format!("lib{i}"),
                path: format!("/lib{i}.dylib"),
            })
            .collect();
        let imports = ResolvedImports {
            data_bindings: Default::default(),
            imports: (0..20).map(|i| sample_import(i, false)).collect(),
            dylibs,
        };
        let out = build_bind_opcodes(&imports, 1, None);
        assert!(
            out.windows(2)
                .any(|w| w == [BIND_OPCODE_SET_DYLIB_ORDINAL_ULEB, 0x10]),
            "ordinal 16 must use the ULEB selector"
        );
        assert!(
            out.windows(2)
                .any(|w| w == [BIND_OPCODE_SET_DYLIB_ORDINAL_ULEB, 0x11]),
            "ordinal 17 must use the ULEB selector"
        );
    }

    #[test]
    fn flat_lookup_nlist_carries_dynamic_lookup_ordinal() {
        // A flat-lookup import's nlist library ordinal must match the bind
        // stream's flat-lookup provenance (DYNAMIC_LOOKUP_ORDINAL), not a
        // two-level ordinal pointing at the first dylib.
        let flat = sample_import(0, true);
        assert_eq!(import_library_ordinal(&flat), DYNAMIC_LOOKUP_ORDINAL);
        let bytes = nlist_undef(0, import_library_ordinal(&flat));
        let n_desc = u16::from_le_bytes([bytes[6], bytes[7]]);
        assert_eq!((n_desc >> 8) as u8, DYNAMIC_LOOKUP_ORDINAL);
        let two_level = sample_import(0, false);
        assert_eq!(import_library_ordinal(&two_level), 1);
    }

    #[test]
    fn export_trie_round_trips() {
        let entries = [
            ("_InitWindow".to_string(), 0x1234u64, 0u64),
            ("_InitAudioDevice".to_string(), 0x5678u64, 0u64),
            ("_DrawRectangle".to_string(), 0x9abcu64, 0u64),
        ];
        let trie = build_export_trie(&entries);
        assert!(!trie.is_empty(), "non-empty input must produce a trie");

        fn uleb(buf: &[u8], p: &mut usize) -> u64 {
            let (mut v, mut shift) = (0u64, 0);
            loop {
                let b = buf[*p];
                *p += 1;
                v |= ((b & 0x7F) as u64) << shift;
                if b & 0x80 == 0 {
                    return v;
                }
                shift += 7;
            }
        }
        let lookup = |trie: &[u8], name: &str| -> Option<u64> {
            let bytes = name.as_bytes();
            let (mut node, mut pos) = (0usize, 0usize);
            loop {
                let mut p = node;
                let term_size = uleb(trie, &mut p) as usize;
                if pos == bytes.len() {
                    if term_size == 0 {
                        return None;
                    }
                    let _flags = uleb(trie, &mut p);
                    return Some(uleb(trie, &mut p));
                }
                p += term_size;
                let child_count = trie[p];
                p += 1;
                let mut next = None;
                for _ in 0..child_count {
                    let start = p;
                    while trie[p] != 0 {
                        p += 1;
                    }
                    let label = &trie[start..p];
                    p += 1;
                    let child = uleb(trie, &mut p) as usize;
                    if bytes[pos..].starts_with(label) {
                        next = Some((label.len(), child));
                        break;
                    }
                }
                match next {
                    Some((len, child)) => {
                        pos += len;
                        node = child;
                    }
                    None => return None,
                }
            }
        };
        for (name, addr, _) in &entries {
            assert_eq!(lookup(&trie, name), Some(*addr), "trie lookup {name}");
        }
        assert_eq!(lookup(&trie, "_Nonexistent"), None);
        assert!(
            build_export_trie(&[]).is_empty(),
            "empty input -> empty trie"
        );
    }

    #[test]
    fn bind_stream_contains_symbol_name() {
        let bytes = write(&tiny_program(), &tiny_build()).unwrap();
        let sizeofcmds = read_u32(&bytes, 20) as usize;
        let mut p = 32usize;
        let lc_end = 32 + sizeofcmds;
        while p < lc_end {
            let cmd = read_u32(&bytes, p);
            let cmdsize = read_u32(&bytes, p + 4) as usize;
            if cmd == LC_DYLD_INFO_ONLY {
                let bind_off = read_u32(&bytes, p + 16) as usize;
                let bind_size = read_u32(&bytes, p + 20) as usize;
                let stream = &bytes[bind_off..bind_off + bind_size];
                assert!(
                    stream.windows(7).any(|w| w == b"_write\0"),
                    "bind stream did not contain `_write\\0`: {stream:?}"
                );
                return;
            }
            p += cmdsize;
        }
        panic!("LC_DYLD_INFO_ONLY not found in load commands");
    }

    #[test]
    fn dynamic_exports_emitted_as_external_defined() {
        // A text, a data and a zero-init global carried as dynamic exports
        // must appear in the symbol table as N_EXT | N_SECT entries with
        // the right section index, so a dlopen'd module can bind them.
        let mut build = tiny_build();
        build.data = alloc::vec![0u8; 16];
        build.bss_size = 8;
        build.dynamic_exports = vec![
            crate::c5::codegen::DynamicExport {
                name: "myfunc".into(),
                section: super::super::DynamicExportSection::Text,
                offset: 0,
                size: 0,
                is_object: false,
                weak: false,
            },
            crate::c5::codegen::DynamicExport {
                name: "myglobal".into(),
                section: super::super::DynamicExportSection::Data,
                offset: 8,
                size: 4,
                is_object: true,
                weak: false,
            },
            crate::c5::codegen::DynamicExport {
                name: "myzero".into(),
                section: super::super::DynamicExportSection::Data,
                offset: 16,
                size: 8,
                is_object: true,
                weak: false,
            },
        ];
        let bytes = write(&tiny_program(), &build).unwrap();

        let sizeofcmds = read_u32(&bytes, 20) as usize;
        let mut p = 32usize;
        let lc_end = 32 + sizeofcmds;
        let mut found: Vec<(String, u8, u8)> = Vec::new();
        while p < lc_end {
            let cmd = read_u32(&bytes, p);
            let cmdsize = read_u32(&bytes, p + 4) as usize;
            if cmd == LC_SYMTAB {
                let symoff = read_u32(&bytes, p + 8) as usize;
                let nsyms = read_u32(&bytes, p + 12) as usize;
                let stroff = read_u32(&bytes, p + 16) as usize;
                for k in 0..nsyms {
                    let e = symoff + k * NLIST_64_SIZE;
                    let n_strx = read_u32(&bytes, e) as usize;
                    let n_type = bytes[e + 4];
                    let n_sect = bytes[e + 5];
                    let start = stroff + n_strx;
                    let len = bytes[start..].iter().position(|&b| b == 0).unwrap();
                    let name = String::from_utf8_lossy(&bytes[start..start + len]).into_owned();
                    if matches!(name.as_str(), "_myfunc" | "_myglobal" | "_myzero") {
                        found.push((name, n_type, n_sect));
                    }
                }
                break;
            }
            p += cmdsize;
        }

        let func = found
            .iter()
            .find(|(n, _, _)| n == "_myfunc")
            .expect("_myfunc export");
        assert_eq!(func.1 & N_EXT, N_EXT, "text export must be external");
        assert_eq!(func.1 & N_SECT, N_SECT, "text export must be N_SECT");
        assert_eq!(func.2, SECT_INDEX_TEXT, "text export n_sect");

        let data = found
            .iter()
            .find(|(n, _, _)| n == "_myglobal")
            .expect("_myglobal export");
        assert_eq!(data.1 & N_EXT, N_EXT, "data export must be external");
        assert_eq!(data.1 & N_SECT, N_SECT, "data export must be N_SECT");
        assert_eq!(data.2, 4, "data export n_sect");

        let zero = found
            .iter()
            .find(|(n, _, _)| n == "_myzero")
            .expect("_myzero export");
        assert_eq!(zero.1 & N_EXT, N_EXT, "bss export must be external");
        assert_eq!(
            zero.2, 5,
            "a data offset past build.data must resolve to __DATA,__bss"
        );
    }

    #[test]
    fn strtab_starts_with_leading_nul() {
        let bytes = write(&tiny_program(), &tiny_build()).unwrap();
        let sizeofcmds = read_u32(&bytes, 20) as usize;
        let mut p = 32usize;
        let lc_end = 32 + sizeofcmds;
        while p < lc_end {
            let cmd = read_u32(&bytes, p);
            let cmdsize = read_u32(&bytes, p + 4) as usize;
            if cmd == LC_SYMTAB {
                let stroff = read_u32(&bytes, p + 16) as usize;
                assert_eq!(bytes[stroff], 0, "string table must start with NUL");
                assert_eq!(
                    &bytes[stroff + 1..stroff + 7],
                    b"_write",
                    "expected first import name immediately after leading NUL"
                );
                return;
            }
            p += cmdsize;
        }
        panic!("LC_SYMTAB not found");
    }

    /// Round-trip through `otool -h` on the host to confirm Apple's own
    /// parser is happy with the header.
    #[cfg(target_os = "macos")]
    #[test]
    fn otool_h_parses_the_image() {
        use std::io::Write;
        use std::process::Command;
        let bytes = write(&tiny_program(), &tiny_build()).unwrap();
        let path = crate::c5::tests::unique_temp_path("badc-m1-3", "h", ".bin");
        let mut f = std::fs::File::create(&path).unwrap();
        f.write_all(&bytes).unwrap();
        drop(f);
        let output = Command::new("/usr/bin/otool")
            .args(["-h", "-v"])
            .arg(&path)
            .output()
            .expect("otool not available");
        let _ = std::fs::remove_file(&path);
        let stdout = String::from_utf8_lossy(&output.stdout);
        assert!(output.status.success(), "otool failed: {stdout}");
        for needle in ["MH_MAGIC_64", "ARM64", "EXECUTE", "DYLDLINK", "PIE"] {
            assert!(
                stdout.contains(needle),
                "otool output missing {needle:?}; got:\n{stdout}"
            );
        }
    }

    /// Confirm `dyld_info -imports` sees `_write` bound against libSystem.
    /// dyld_info is Apple's modern Mach-O introspection tool and the
    /// closest analogue to "what dyld would see at load time".
    #[cfg(target_os = "macos")]
    #[test]
    fn dyld_info_imports_lists_write() {
        use std::io::Write;
        use std::process::Command;
        let bytes = write(&tiny_program(), &tiny_build()).unwrap();
        let path = crate::c5::tests::unique_temp_path("badc-m1-3", "bind", ".bin");
        let mut f = std::fs::File::create(&path).unwrap();
        f.write_all(&bytes).unwrap();
        drop(f);
        let output = Command::new("/usr/bin/dyld_info")
            .arg("-imports")
            .arg(&path)
            .output()
            .expect("dyld_info not available");
        let _ = std::fs::remove_file(&path);
        let stdout = String::from_utf8_lossy(&output.stdout);
        let stderr = String::from_utf8_lossy(&output.stderr);
        assert!(
            output.status.success(),
            "dyld_info exited {:?}\nSTDOUT:\n{stdout}\nSTDERR:\n{stderr}",
            output.status
        );
        assert!(
            stdout.contains("_write"),
            "dyld_info -imports didn't list _write.\nSTDOUT:\n{stdout}\nSTDERR:\n{stderr}"
        );
        assert!(
            stdout.contains("libSystem"),
            "dyld_info -imports didn't show libSystem as the source dylib.\nSTDOUT:\n{stdout}"
        );
    }

    /// Structural check for the TLV path.
    #[test]
    fn thread_local_marks_tlv_header_and_sections() {
        use crate::Compiler;
        let src = "_Thread_local int counter; int main() { counter = 1; return counter; }";
        let program = Compiler::with_target(
            super::super::super::tests::with_prelude(src),
            super::super::Target::MacOSAarch64,
        )
        .compile()
        .expect("compile");
        let build = super::super::lower_for(
            &program,
            super::super::Target::MacOSAarch64,
            super::super::NativeOptions::default(),
        )
        .expect("lower");
        let bytes = write(&tiny_program(), &build).expect("write Mach-O");

        let flags = read_u32(&bytes, 24);
        assert_ne!(
            flags & MH_HAS_TLV_DESCRIPTORS,
            0,
            "expected MH_HAS_TLV_DESCRIPTORS in mach header flags, got {flags:#x}"
        );

        let sizeofcmds = read_u32(&bytes, 20) as usize;
        let mut p = 32usize;
        let lc_end = 32 + sizeofcmds;
        let mut saw_thread_vars = false;
        let mut saw_thread_bss = false;
        while p < lc_end {
            let cmd = read_u32(&bytes, p);
            let cmdsize = read_u32(&bytes, p + 4) as usize;
            if cmd == LC_SEGMENT_64 {
                let segname = &bytes[p + 8..p + 24];
                if segname.starts_with(b"__DATA\0") {
                    let nsects = read_u32(&bytes, p + 64) as usize;
                    assert_eq!(nsects, 4, "__DATA must have 4 sections when TLV present");
                    let mut sect_p = p + 72;
                    for _ in 0..nsects {
                        let sect_name = &bytes[sect_p..sect_p + 16];
                        let sect_flags = read_u32(&bytes, sect_p + 64);
                        let sect_type = sect_flags & 0xFF;
                        if sect_name.starts_with(b"__thread_vars\0") {
                            assert_eq!(sect_type, 0x13);
                            saw_thread_vars = true;
                        } else if sect_name.starts_with(b"__thread_bss\0") {
                            assert_eq!(sect_type, 0x12);
                            saw_thread_bss = true;
                        }
                        sect_p += SECTION_64_SIZE;
                    }
                }
            }
            p += cmdsize;
        }
        assert!(saw_thread_vars, "missing __DATA,__thread_vars");
        assert!(saw_thread_bss, "missing __DATA,__thread_bss");

        let mut p = 32usize;
        while p < lc_end {
            let cmd = read_u32(&bytes, p);
            let cmdsize = read_u32(&bytes, p + 4) as usize;
            if cmd == LC_DYLD_INFO_ONLY {
                let bind_off = read_u32(&bytes, p + 16) as usize;
                let bind_size = read_u32(&bytes, p + 20) as usize;
                let stream = &bytes[bind_off..bind_off + bind_size];
                assert!(
                    stream.windows(15).any(|w| w == b"__tlv_bootstrap"),
                    "expected `__tlv_bootstrap` in bind stream"
                );
                break;
            }
            p += cmdsize;
        }
    }

    /// Same `_Thread_local` source compiles cleanly *without* the TLV
    /// mach-header flag when there's no TLS.
    #[test]
    fn no_tls_means_no_tlv_header_flag() {
        use crate::Compiler;
        let src = "int main() { return 0; }";
        let program = Compiler::with_target(
            super::super::super::tests::with_prelude(src),
            super::super::Target::MacOSAarch64,
        )
        .compile()
        .expect("compile");
        let build = super::super::lower_for(
            &program,
            super::super::Target::MacOSAarch64,
            super::super::NativeOptions::default(),
        )
        .expect("lower");
        let bytes = write(&tiny_program(), &build).expect("write Mach-O");
        let flags = read_u32(&bytes, 24);
        assert_eq!(
            flags & MH_HAS_TLV_DESCRIPTORS,
            0,
            "MH_HAS_TLV_DESCRIPTORS set without TLS, got flags {flags:#x}"
        );
    }

    /// `nm` should report `_write` as a U (undefined external) entry,
    /// confirming `LC_SYMTAB` and the string table are readable by classic
    /// Unix tooling.
    #[cfg(target_os = "macos")]
    #[test]
    fn nm_reports_write_undefined() {
        use std::io::Write;
        use std::process::Command;
        let bytes = write(&tiny_program(), &tiny_build()).unwrap();
        let path = crate::c5::tests::unique_temp_path("badc-m1-3", "nm", ".bin");
        let mut f = std::fs::File::create(&path).unwrap();
        f.write_all(&bytes).unwrap();
        drop(f);
        let output = Command::new("/usr/bin/nm")
            .arg(&path)
            .output()
            .expect("nm not available");
        let _ = std::fs::remove_file(&path);
        let stdout = String::from_utf8_lossy(&output.stdout);
        let stderr = String::from_utf8_lossy(&output.stderr);
        assert!(
            output.status.success(),
            "nm exited {:?}\nSTDOUT:\n{stdout}\nSTDERR:\n{stderr}",
            output.status
        );
        assert!(
            stdout.contains("U _write"),
            "nm didn't show `U _write`.\nSTDOUT:\n{stdout}\nSTDERR:\n{stderr}"
        );
    }

    /// A segregated zero global produces a `__DATA,__bss` S_ZEROFILL
    /// section whose size equals `build.bss_size`, so sizers report bss.
    #[test]
    fn segregated_bss_emits_zerofill_section() {
        use crate::Compiler;
        let target = super::super::Target::MacOSAarch64;
        let src = "static long zeros[512]; long *const p = &zeros[3]; \
                   int main() { zeros[3] = 1; return (int)zeros[3] + (p == &zeros[3]); }";
        let program = Compiler::with_target(super::super::super::tests::with_prelude(src), target)
            .compile()
            .expect("compile");
        let compacted =
            crate::c5::codegen::ssa::shadow::compact_program_data(&program, target, true, false)
                .expect("compact");
        let mut build = super::super::lower_for(
            &compacted.program,
            target,
            super::super::NativeOptions::default(),
        )
        .expect("lower");
        build.bss_size = compacted.bss_size;
        assert!(build.bss_size > 0, "the zero array must occupy bss");
        let bytes = write(&tiny_program(), &build).expect("write Mach-O");

        let read_u64 = |o: usize| u64::from_le_bytes(bytes[o..o + 8].try_into().unwrap());
        let lc_end = 32 + read_u32(&bytes, 20) as usize;
        let mut p = 32usize;
        let mut bss = None;
        while p < lc_end {
            let cmdsize = read_u32(&bytes, p + 4) as usize;
            if read_u32(&bytes, p) == LC_SEGMENT_64 && bytes[p + 8..p + 24].starts_with(b"__DATA\0")
            {
                let mut sp = p + 72;
                for _ in 0..read_u32(&bytes, p + 64) {
                    if bytes[sp..sp + 16].starts_with(b"__bss\0") {
                        bss = Some((read_u64(sp + 40), read_u32(&bytes, sp + 64) & 0xFF));
                    }
                    sp += SECTION_64_SIZE;
                }
            }
            p += cmdsize;
        }
        let (size, sect_type) = bss.expect("__DATA,__bss section must be present");
        assert_eq!(sect_type, S_ZEROFILL, "__bss must be S_ZEROFILL");
        assert_eq!(
            size, build.bss_size as u64,
            "__bss size must equal bss_size"
        );
    }
}
