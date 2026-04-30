//! Mach-O (64-bit) writer for arm64 executables.
//!
//! Mach-O is a fixed `mach_header_64` followed by a sequence of "load
//! commands". Each load command tells dyld to do something on launch:
//! map a segment, load a shared library, set the entry point, fill in
//! the GOT, and so on. The header carries the total size of the command
//! stream so dyld knows where the segment data starts.
//!
//! We hand-roll all of it. The format is well-documented in
//! `<mach-o/loader.h>` and Apple's open-source `dyld`, and a hand-rolled
//! writer keeps us free of any binary-writer dependency.
//!
//! ## Layout we emit
//!
//! ```text
//!   file                                                  segment / contents
//!   ------------------------------------------------------------------------
//!   0x0000   mach_header_64                                \
//!            LC_SEGMENT_64 __PAGEZERO                      |
//!            LC_SEGMENT_64 __TEXT (1 sect: __text)         |
//!            LC_SEGMENT_64 __DATA (2 sects: __got, __data) | __TEXT
//!            LC_SEGMENT_64 __LINKEDIT                      |
//!            LC_DYLD_INFO_ONLY                             |
//!            LC_SYMTAB                                     |
//!            LC_DYSYMTAB                                   |
//!            LC_LOAD_DYLINKER /usr/lib/dyld                |
//!            LC_LOAD_DYLIB   /usr/lib/libSystem...         |
//!            LC_BUILD_VERSION                              |
//!            LC_MAIN entry_off=...                         |
//!            <padding>                                     |
//!            <machine code from build.text>                |
//!            <pad to 16 KiB>                               /
//!   0x4000   __DATA: __got at section start, __data after  - __DATA
//!            (page-aligned, may span more than one page if
//!             build.data is large)
//!   0x8000+  __LINKEDIT contents:                          bind opcodes,
//!                                                          symbol table,
//!                                                          string table.
//! ```
//!
//! __PAGEZERO is an unmapped 4 GiB segment at vmaddr 0 -- the standard
//! null-pointer-deref catcher. __TEXT carries the header plus the code.
//! __DATA holds two sections: __got (one pointer-sized slot per imported
//! symbol; dyld fills the slots in at launch via the bind opcode stream
//! in __LINKEDIT) and __data (the program's static data segment, copied
//! into the file by the writer and patched into the code via the
//! `DataFixup` adrp+add pairs). __LINKEDIT also holds the symbol +
//! string tables so tools like `otool -bind` can name what's being
//! bound.
//!
//! Apple Silicon mandates 16 KiB pages for arm64 (`vm_page_size`).
//!
//! ## What dyld checks at load time
//!
//! Plenty -- but only some of it bites here:
//! * Magic / cpu type / file type must match.
//! * `MH_PIE` must be set (modern macOS rejects non-PIE executables).
//! * Segment file ranges must fit inside the file.
//! * `LC_MAIN` entry must land inside an executable segment.
//! * Every undefined symbol in `LC_DYLD_INFO_ONLY` must resolve in
//!   one of the loaded dylibs.
//! * The binary must be code-signed -- shelled out to `codesign --sign -`
//!   from the CLI shim. Without it, `exec()` fails with `killed: 9`
//!   even on an otherwise valid Mach-O.

use alloc::format;
use alloc::vec::Vec;

use super::super::error::C4Error;
use super::Build;

// ------------------------------------------------------------------
// Mach-O constants. Names mirror `<mach-o/loader.h>` and `<mach-o/nlist.h>`
// so cross-checking against system headers is mechanical.
// ------------------------------------------------------------------

const MH_MAGIC_64: u32 = 0xFEED_FACF;

const CPU_TYPE_ARM64: u32 = 0x0100_000C; // CPU_ARCH_ABI64 | CPU_TYPE_ARM
const CPU_SUBTYPE_ARM64_ALL: u32 = 0;

const MH_EXECUTE: u32 = 0x2;

const MH_DYLDLINK: u32 = 0x4;
const MH_TWOLEVEL: u32 = 0x80;
const MH_PIE: u32 = 0x0020_0000;

const LC_REQ_DYLD: u32 = 0x8000_0000;
const LC_SEGMENT_64: u32 = 0x19;
const LC_SYMTAB: u32 = 0x2;
const LC_DYSYMTAB: u32 = 0xB;
const LC_LOAD_DYLINKER: u32 = 0xE;
const LC_LOAD_DYLIB: u32 = 0xC;
const LC_DYLD_INFO_ONLY: u32 = 0x22 | LC_REQ_DYLD;
const LC_MAIN: u32 = 0x28 | LC_REQ_DYLD;
const LC_BUILD_VERSION: u32 = 0x32;

const VM_PROT_READ: u32 = 1;
const VM_PROT_WRITE: u32 = 2;
const VM_PROT_EXECUTE: u32 = 4;

const PLATFORM_MACOS: u32 = 1;

// 16 KiB pages on Apple Silicon arm64.
const PAGE_SIZE: u64 = 0x4000;

/// Standard 4 GiB __PAGEZERO -- catches null-pointer derefs cheaply
/// because the segment has no readable, writable, or executable
/// permission bits set.
const PAGEZERO_VMSIZE: u64 = 0x1_0000_0000;

/// Default __TEXT base. Sits right above __PAGEZERO. dyld slides this
/// to a random offset on launch (PIE), so the value is mostly cosmetic.
const TEXT_VMADDR_BASE: u64 = PAGEZERO_VMSIZE;

/// macOS 11.0.0 -- the floor for the Apple Silicon era. Apple docs
/// suggest setting this to the lowest version you actually test on.
/// Encoded as `(major << 16) | (minor << 8) | patch`, all bytes packed.
const MIN_MACOS: u32 = 11 << 16;
const SDK_MACOS: u32 = 11 << 16;

// ---- Bind opcode stream constants (low nibble carries an immediate
//      operand; high nibble selects the opcode). Mirror of
//      `<mach-o/loader.h>` `BIND_OPCODE_*`. ----

const BIND_OPCODE_DONE: u8 = 0x00;
const BIND_OPCODE_SET_DYLIB_ORDINAL_IMM: u8 = 0x10;
const BIND_OPCODE_SET_SYMBOL_TRAILING_FLAGS_IMM: u8 = 0x40;
const BIND_OPCODE_SET_TYPE_IMM: u8 = 0x50;
const BIND_OPCODE_SET_SEGMENT_AND_OFFSET_ULEB: u8 = 0x70;
const BIND_OPCODE_DO_BIND: u8 = 0x90;

const BIND_TYPE_POINTER: u8 = 1;

/// nlist_64 type bits.
const N_UNDF: u8 = 0x0;
const N_EXT: u8 = 0x01;
const NO_SECT: u8 = 0;

/// Segment indices, in the order they appear as `LC_SEGMENT_64` load
/// commands. Bind opcodes refer to segments by this index.
const SEG_INDEX_DATA: u8 = 2;

// ------------------------------------------------------------------
// On-disk shapes. `#[repr(C)]` with explicit fields, const-asserted
// sizes against `<mach-o/loader.h>` / `<mach-o/nlist.h>`, written via
// the same memcpy helper the PE writer uses. Mach-O is little-endian
// on every CPU we target, so the in-memory layout *is* the wire
// format. The variable-length load commands (`LC_LOAD_DYLINKER`,
// `LC_LOAD_DYLIB`) carry a fixed-size header followed by a NUL-
// terminated, 8-byte-padded path -- only the header is a struct.
// ------------------------------------------------------------------

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

/// `segment_command_64` -- one `LC_SEGMENT_64` load command. Followed
/// by `nsects` `Section64` entries, all counted in `cmdsize`.
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

/// `dyld_info_command` -- pointers into __LINKEDIT for dyld's
/// rebase / bind / weak-bind / lazy-bind / export streams.
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
/// external-defined / undefined ranges and points at the indirect
/// symbol table. We currently only fill in the undefined-range count.
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

/// `entry_point_command` (`LC_MAIN`) -- file offset of the entry
/// point plus a stack-size hint.
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
/// `cmdsize` is the total command size including the path bytes.
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

/// Append a `#[repr(C)]` struct's raw bytes to `out`.
///
/// Mach-O is little-endian on every CPU we target, so a memcpy of the
/// in-memory struct produces the right wire format. The structs above
/// have explicit field order and const-asserted sizes; the only
/// remaining surprise would be host endianness, and a const-time
/// check rules that out.
fn write_struct<T: Copy>(out: &mut Vec<u8>, value: &T) {
    const _: () = assert!(
        cfg!(target_endian = "little"),
        "Mach-O writer assumes a little-endian host; emit bytes manually if you ever need a big-endian build host"
    );
    let bytes = unsafe {
        core::slice::from_raw_parts((value as *const T) as *const u8, core::mem::size_of::<T>())
    };
    out.extend_from_slice(bytes);
}

/// Pack a name into the 16-byte `segname` / `sectname` field, NUL-
/// padded. `<mach-o/loader.h>` only requires NUL-termination when the
/// name is shorter than 16 bytes, so a name that exactly fills the
/// buffer is legal but we don't emit any.
fn pack_name16(name: &str) -> [u8; 16] {
    debug_assert!(name.len() <= 16, "segment/section name too long: {name:?}");
    let mut buf = [0u8; 16];
    for (i, b) in name.as_bytes().iter().take(16).enumerate() {
        buf[i] = *b;
    }
    buf
}

/// LEB128 unsigned encoding -- 7-bit groups, low to high, MSB set on
/// every byte except the last. Used inside bind opcode streams.
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

/// Pad a Vec to the next multiple of `align`. Used for keeping load-
/// command bodies (LC_LOAD_DYLIB strings etc.) at their required
/// 8-byte alignment.
fn pad_to(out: &mut Vec<u8>, align: usize) {
    while !out.len().is_multiple_of(align) {
        out.push(0);
    }
}

/// Round `n` up to the next multiple of `align`.
fn round_up(n: u64, align: u64) -> u64 {
    (n + align - 1) & !(align - 1)
}

// ------------------------------------------------------------------
// Load-command writers. Each returns the bytes for one LC; the caller
// concatenates them in the order it wants dyld to see them.
// ------------------------------------------------------------------

/// `LC_SEGMENT_64` for a segment with no sections (used for
/// __PAGEZERO and __LINKEDIT). The on-disk struct is 72 bytes.
fn segment_no_sections(
    name: &str,
    vmaddr: u64,
    vmsize: u64,
    fileoff: u64,
    filesize: u64,
    maxprot: u32,
    initprot: u32,
) -> Vec<u8> {
    let mut out = Vec::with_capacity(SEGMENT_COMMAND_64_SIZE);
    write_struct(
        &mut out,
        &SegmentCommand64 {
            cmd: LC_SEGMENT_64,
            cmdsize: SEGMENT_COMMAND_64_SIZE as u32,
            segname: pack_name16(name),
            vmaddr,
            vmsize,
            fileoff,
            filesize,
            maxprot,
            initprot,
            nsects: 0,
            flags: 0,
        },
    );
    debug_assert_eq!(out.len(), SEGMENT_COMMAND_64_SIZE);
    out
}

/// `LC_SEGMENT_64` for `__TEXT` containing a single `__text` section.
/// 72 bytes for the segment header + 80 bytes for the section header.
#[allow(clippy::too_many_arguments)]
fn segment_text(
    vmaddr: u64,
    vmsize: u64,
    fileoff: u64,
    filesize: u64,
    text_addr: u64,
    text_size: u64,
    text_offset: u32,
) -> Vec<u8> {
    const TOTAL: usize = SEGMENT_COMMAND_64_SIZE + SECTION_64_SIZE;
    let mut out = Vec::with_capacity(TOTAL);
    write_struct(
        &mut out,
        &SegmentCommand64 {
            cmd: LC_SEGMENT_64,
            cmdsize: TOTAL as u32,
            segname: pack_name16("__TEXT"),
            vmaddr,
            vmsize,
            fileoff,
            filesize,
            maxprot: VM_PROT_READ | VM_PROT_EXECUTE,
            initprot: VM_PROT_READ | VM_PROT_EXECUTE,
            nsects: 1,
            flags: 0,
        },
    );
    write_struct(
        &mut out,
        &Section64 {
            sectname: pack_name16("__text"),
            segname: pack_name16("__TEXT"),
            addr: text_addr,
            size: text_size,
            offset: text_offset,
            align: 2, // log2 -- 4-byte arm64 instruction alignment
            reloff: 0,
            nreloc: 0,
            // S_REGULAR (0) | S_ATTR_PURE_INSTRUCTIONS | S_ATTR_SOME_INSTRUCTIONS
            flags: 0x8000_0400,
            reserved1: 0,
            reserved2: 0,
            reserved3: 0,
        },
    );
    debug_assert_eq!(out.len(), TOTAL);
    out
}

/// `LC_SEGMENT_64` for `__DATA` containing two sections: `__got`
/// (filled by dyld via bind opcodes) and `__data` (the program's
/// initialised data segment, copied into the image at write time).
/// Both sections live within a single page; the writer guarantees
/// that __data ends before the page boundary by sizing __DATA up.
/// 72 + 80 + 80 bytes total.
#[allow(clippy::too_many_arguments)]
fn segment_data(
    vmaddr: u64,
    vmsize: u64,
    fileoff: u64,
    filesize: u64,
    got_addr: u64,
    got_size: u64,
    got_offset: u32,
    data_addr: u64,
    data_size: u64,
    data_offset: u32,
) -> Vec<u8> {
    const TOTAL: usize = SEGMENT_COMMAND_64_SIZE + 2 * SECTION_64_SIZE;
    let mut out = Vec::with_capacity(TOTAL);
    write_struct(
        &mut out,
        &SegmentCommand64 {
            cmd: LC_SEGMENT_64,
            cmdsize: TOTAL as u32,
            segname: pack_name16("__DATA"),
            vmaddr,
            vmsize,
            fileoff,
            filesize,
            maxprot: VM_PROT_READ | VM_PROT_WRITE,
            initprot: VM_PROT_READ | VM_PROT_WRITE,
            nsects: 2,
            flags: 0,
        },
    );
    // __got section. We fill it via bind opcodes, not the indirect
    // symbol table, so the section type stays S_REGULAR (0).
    // Conventionally __got is named that way and otool treats it
    // specially even without any flag bits.
    write_struct(
        &mut out,
        &Section64 {
            sectname: pack_name16("__got"),
            segname: pack_name16("__DATA"),
            addr: got_addr,
            size: got_size,
            offset: got_offset,
            align: 3, // log2 -- 8 bytes for u64 pointers
            reloff: 0,
            nreloc: 0,
            flags: 0, // S_REGULAR
            reserved1: 0,
            reserved2: 0,
            reserved3: 0,
        },
    );
    // __data section. Holds the program's static data segment --
    // string literals + zero-initialised globals. Copied into the
    // file at write time; dyld maps it RW alongside __got.
    write_struct(
        &mut out,
        &Section64 {
            sectname: pack_name16("__data"),
            segname: pack_name16("__DATA"),
            addr: data_addr,
            size: data_size,
            offset: data_offset,
            align: 3, // log2 -- 8 bytes is enough for any c4 access
            reloff: 0,
            nreloc: 0,
            flags: 0, // S_REGULAR
            reserved1: 0,
            reserved2: 0,
            reserved3: 0,
        },
    );
    debug_assert_eq!(out.len(), TOTAL);
    out
}

/// Compute the cmdsize for a variable-length load command whose body
/// is a fixed `head_size` followed by a NUL-terminated path padded to
/// 8 bytes.
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

/// `LC_LOAD_DYLIB` -- declare a dependency on a shared library that
/// dyld must load before our entry point runs.
fn load_dylib(path: &str) -> Vec<u8> {
    let cmdsize = variable_lc_cmdsize(DYLIB_COMMAND_HEAD_SIZE, path);
    let mut out = Vec::with_capacity(cmdsize as usize);
    write_struct(
        &mut out,
        &DylibCommandHead {
            cmd: LC_LOAD_DYLIB,
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

/// `LC_BUILD_VERSION` -- platform + min OS + SDK. Modern dyld grumbles
/// without it.
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

/// `LC_MAIN` -- file offset of the entry point, plus a stack-size
/// hint (zero = use the kernel default).
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

/// `LC_DYLD_INFO_ONLY` -- pointers into __LINKEDIT for dyld's
/// rebase / bind / weak-bind / lazy-bind / export streams. Phase 1
/// only uses eager bind; the rest are zero.
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

/// `LC_SYMTAB` -- classic symbol table (nlist entries) + string
/// table. Strictly speaking `LC_DYLD_INFO_ONLY` carries enough info
/// for dyld to bind without this, but `otool`, `nm`, debuggers, and
/// `codesign` all expect it.
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

/// `LC_DYSYMTAB` -- partition the symbol table into local / external-
/// defined / undefined ranges and point at the indirect symbol table.
/// We only have undefined imports right now so the only non-zero
/// counts are `nundefsym` and `iundefsym`.
fn dysymtab_command(nundefsym: u32) -> Vec<u8> {
    let mut out = Vec::with_capacity(DYSYMTAB_COMMAND_SIZE);
    write_struct(
        &mut out,
        &DysymtabCommand {
            cmd: LC_DYSYMTAB,
            cmdsize: DYSYMTAB_COMMAND_SIZE as u32,
            ilocalsym: 0,
            nlocalsym: 0,
            iextdefsym: 0,
            nextdefsym: 0,
            iundefsym: 0, // undefined start at index 0
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

// ------------------------------------------------------------------
// GOT fixup patching. Each codegen-emitted `adrp + ldr` pair points
// at a __got slot; we now know the data vmaddr so we can fill in
// the page-relative offset and the in-page byte offset.
// ------------------------------------------------------------------

/// Patch each adrp/ldr pair the codegen left behind. `code_base_in_file`
/// is the file offset where the code blob starts; `code_vmaddr_base`
/// is the matching vmaddr; `got_base_vmaddr` is the vmaddr of GOT
/// slot 0 in __DATA.
fn apply_got_fixups(
    out: &mut [u8],
    code_base_in_file: usize,
    code_vmaddr_base: u64,
    got_base_vmaddr: u64,
    fixups: &[super::GotFixup],
) -> Result<(), C4Error> {
    for fx in fixups {
        let adrp_file_off = code_base_in_file + fx.adrp_offset;
        let ldr_file_off = adrp_file_off + 4;

        let adrp_vmaddr = code_vmaddr_base + fx.adrp_offset as u64;
        let target_vmaddr = got_base_vmaddr + (fx.import_index as u64) * 8;

        // adrp computes (PC & ~0xFFF) + (imm21 << 12). Solve for imm21.
        let adrp_page = adrp_vmaddr & !0xFFF;
        let target_page = target_vmaddr & !0xFFF;
        let page_diff = target_page as i64 - adrp_page as i64;
        if page_diff & 0xFFF != 0 {
            return Err(C4Error::Compile(format!(
                "Mach-O: GOT page diff {page_diff} not 4 KiB aligned"
            )));
        }
        let imm21 = (page_diff >> 12) as i32;

        // ldr xN, [xN, #imm12] uses a 12-bit unsigned offset scaled
        // by 8 for 64-bit loads. The in-page byte offset must be
        // 8-aligned.
        let in_page = (target_vmaddr & 0xFFF) as u32;
        if !in_page.is_multiple_of(8) {
            return Err(C4Error::Compile(format!(
                "Mach-O: GOT slot offset {in_page:#x} not 8-aligned"
            )));
        }

        let adrp_word = super::aarch64::enc_adrp(super::aarch64::Reg::X16, imm21);
        let ldr_word = super::aarch64::enc_ldr_imm(
            super::aarch64::Reg::X16,
            super::aarch64::Reg::X16,
            in_page,
        );
        out[adrp_file_off..adrp_file_off + 4].copy_from_slice(&adrp_word.to_le_bytes());
        out[ldr_file_off..ldr_file_off + 4].copy_from_slice(&ldr_word.to_le_bytes());
    }
    Ok(())
}

/// Patch the `adrp + add` pair the codegen emitted for an absolute-
/// address materialization. `target_vmaddr` is the runtime address
/// the pair should compute into x19. The codegen uses the same shape
/// for both data-segment references and function-pointer literals;
/// the only difference between callers is how they compute the target.
fn patch_adrp_add(
    out: &mut [u8],
    code_base_in_file: usize,
    code_vmaddr_base: u64,
    adrp_offset: usize,
    target_vmaddr: u64,
    label: &str,
) -> Result<(), C4Error> {
    let adrp_file_off = code_base_in_file + adrp_offset;
    let add_file_off = adrp_file_off + 4;
    let adrp_vmaddr = code_vmaddr_base + adrp_offset as u64;

    let adrp_page = adrp_vmaddr & !0xFFF;
    let target_page = target_vmaddr & !0xFFF;
    let page_diff = target_page as i64 - adrp_page as i64;
    if page_diff & 0xFFF != 0 {
        return Err(C4Error::Compile(format!(
            "Mach-O: {label} page diff {page_diff} not 4 KiB aligned"
        )));
    }
    let imm21 = (page_diff >> 12) as i32;
    let in_page = (target_vmaddr & 0xFFF) as u32;

    let adrp_word = super::aarch64::enc_adrp(super::aarch64::Reg::X19, imm21);
    let add_word =
        super::aarch64::enc_add_imm(super::aarch64::Reg::X19, super::aarch64::Reg::X19, in_page);
    out[adrp_file_off..adrp_file_off + 4].copy_from_slice(&adrp_word.to_le_bytes());
    out[add_file_off..add_file_off + 4].copy_from_slice(&add_word.to_le_bytes());
    Ok(())
}

/// Patch each `Op::Imm <data_offset>` site. The target is
/// `data_section_vmaddr + data_offset`.
fn apply_data_fixups(
    out: &mut [u8],
    code_base_in_file: usize,
    code_vmaddr_base: u64,
    data_section_vmaddr: u64,
    fixups: &[super::DataFixup],
) -> Result<(), C4Error> {
    for fx in fixups {
        let target = data_section_vmaddr + fx.data_offset;
        patch_adrp_add(
            out,
            code_base_in_file,
            code_vmaddr_base,
            fx.adrp_offset,
            target,
            "data fixup",
        )?;
    }
    Ok(())
}

/// Patch each function-pointer literal site. The target is the
/// vmaddr of the called function's first instruction.
fn apply_func_fixups(
    out: &mut [u8],
    code_base_in_file: usize,
    code_vmaddr_base: u64,
    fixups: &[super::FuncFixup],
) -> Result<(), C4Error> {
    for fx in fixups {
        let target = code_vmaddr_base + fx.target_native_offset as u64;
        patch_adrp_add(
            out,
            code_base_in_file,
            code_vmaddr_base,
            fx.adrp_offset,
            target,
            "func fixup",
        )?;
    }
    Ok(())
}

// ------------------------------------------------------------------
// __LINKEDIT contents: bind opcodes, nlist entries, string table.
// ------------------------------------------------------------------

/// Bind opcode stream that resolves the program's imports into
/// consecutive 8-byte slots starting at `(__DATA, +0)`. The opcode
/// stream is a tiny dyld-side state machine: we set the bind type
/// once, then for each symbol set its dylib ordinal (when it
/// changes), set its name, set the absolute offset, and DO_BIND.
///
/// `imports` is taken from the resolved `Build.imports`: position
/// `i` is GOT slot `i` in `__DATA`. Each entry's `dylib_index`
/// indexes into the per-image dylib list; the loader-visible
/// ordinal is `dylib_index + 1` (Mach-O reserves ordinal 0 for
/// "self").
fn bind_opcodes_for_imports(imports: &super::ResolvedImports, segment: u8) -> Vec<u8> {
    let mut out = Vec::new();
    out.push(BIND_OPCODE_SET_TYPE_IMM | BIND_TYPE_POINTER);
    let mut current_ordinal: Option<u8> = None;
    for (i, imp) in imports.imports.iter().enumerate() {
        let ordinal = (imp.dylib_index + 1) as u8;
        if current_ordinal != Some(ordinal) {
            out.push(BIND_OPCODE_SET_DYLIB_ORDINAL_IMM | (ordinal & 0x0F));
            current_ordinal = Some(ordinal);
        }
        out.push(BIND_OPCODE_SET_SYMBOL_TRAILING_FLAGS_IMM); // flags = 0
        out.extend_from_slice(imp.real_symbol.as_bytes());
        out.push(0); // NUL terminator
        out.push(BIND_OPCODE_SET_SEGMENT_AND_OFFSET_ULEB | (segment & 0x0F));
        put_uleb128(&mut out, (i * 8) as u64);
        out.push(BIND_OPCODE_DO_BIND);
    }
    out.push(BIND_OPCODE_DONE);
    pad_to(&mut out, 8);
    out
}

/// One `nlist_64` for an undefined external symbol. `n_strx` is the
/// byte offset of the symbol's name in the string table; `ordinal`
/// is the 1-based dylib ordinal (which library exports the symbol).
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

/// Build the Mach-O string table (Mach-O strings are NUL-separated
/// and start with a single leading NUL so that `n_strx == 0` can mean
/// "no name"). Returns `(strtab_bytes, [n_strx_for_each_input])`.
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

// ------------------------------------------------------------------
// Top-level writer. Three-stage: build the parts (so we know their
// sizes), build the LC stream (which depends on those sizes), then
// emit the whole image.
// ------------------------------------------------------------------

pub(super) fn write(build: &Build) -> Result<Vec<u8>, C4Error> {
    let code = &build.text;

    // ---- step 1: build __LINKEDIT contents ----
    //
    // The lowering already resolved program.dylibs against the used
    // libc ops -- index N in `build.imports.imports` is GOT slot N
    // in __DATA, and the codegen's adrp+ldr placeholders refer to
    // those slots by index.
    //
    // Bind opcodes go first, then the symbol table, then the string
    // table. Each subsection is 8-byte aligned so file offsets stay
    // nice. We need the sizes of all three to size __LINKEDIT, which
    // in turn sizes the LC stream.
    let bind_ops = bind_opcodes_for_imports(&build.imports, SEG_INDEX_DATA);
    let symbol_names: Vec<&str> = build
        .imports
        .imports
        .iter()
        .map(|i| i.real_symbol.as_str())
        .collect();
    let (strtab, str_indices) = build_strtab(&symbol_names);
    let mut symtab = Vec::with_capacity(NLIST_64_SIZE * build.imports.imports.len());
    for (n_strx, imp) in str_indices.iter().zip(build.imports.imports.iter()) {
        let ordinal = (imp.dylib_index + 1) as u8;
        symtab.extend_from_slice(&nlist_undef(*n_strx, ordinal));
    }

    // ---- step 2: size the load-command stream ----
    //
    // Most LC sizes are fixed; the variable-length LCs (DYLINKER,
    // DYLIB) are pre-built so we can read their length back.
    //
    // One LC_LOAD_DYLIB per resolved dylib, in declaration order;
    // dyld assigns ordinal `i+1` to the i-th LC_LOAD_DYLIB and we
    // use that ordinal in both the bind opcodes and the nlist
    // n_desc fields.

    let mh_size = MACH_HEADER_64_SIZE as u64;
    let pagezero_size = SEGMENT_COMMAND_64_SIZE as u64;
    let text_seg_size = (SEGMENT_COMMAND_64_SIZE + SECTION_64_SIZE) as u64;
    let data_seg_size = (SEGMENT_COMMAND_64_SIZE + 2 * SECTION_64_SIZE) as u64;
    let linkedit_seg_size = SEGMENT_COMMAND_64_SIZE as u64;
    let dyld_info_size = DYLD_INFO_COMMAND_SIZE as u64;
    let symtab_size = SYMTAB_COMMAND_SIZE as u64;
    let dysymtab_size = DYSYMTAB_COMMAND_SIZE as u64;
    let main_size = ENTRY_POINT_COMMAND_SIZE as u64;

    let dylinker = load_dylinker("/usr/lib/dyld");
    let dylib_lcs: Vec<Vec<u8>> = build
        .imports
        .dylibs
        .iter()
        .map(|d| load_dylib(&d.path))
        .collect();
    let bv = build_version();

    let dylibs_total: u64 = dylib_lcs.iter().map(|lc| lc.len() as u64).sum();
    let sizeofcmds = pagezero_size
        + text_seg_size
        + data_seg_size
        + linkedit_seg_size
        + dyld_info_size
        + symtab_size
        + dysymtab_size
        + dylinker.len() as u64
        + dylibs_total
        + bv.len() as u64
        + main_size;

    // ---- step 4: figure out file/vmaddr layout ----
    //
    // Apple's `codesign --sign -` runs after we write the binary and
    // edits it in-place. To register the signature it appends a new
    // `LC_CODE_SIGNATURE` (16 bytes) to the load-command stream --
    // overwriting whatever bytes immediately followed our LCs. If our
    // code starts there, dyld will jump into bytes that are now LC
    // metadata and SIGILL on the cmd word.
    //
    // The fix is the same one Apple's own linker uses: pad between the
    // end of the LC stream and the start of the code, leaving room for
    // codesign to grow into. 64 bytes is more than codesign needs for
    // LC_CODE_SIGNATURE alone, but cheap insurance against future
    // load commands and keeps the start of code 16-byte aligned.
    const CODESIGN_LC_PAD: u64 = 64;

    let header_plus_lcs = mh_size + sizeofcmds;
    let entry_file_offset = round_up(header_plus_lcs + CODESIGN_LC_PAD, 16);
    let lc_pad_bytes = (entry_file_offset - header_plus_lcs) as usize;
    let code_size = code.len() as u64;
    let text_filesize = round_up(entry_file_offset + code_size, PAGE_SIZE);
    let text_vmsize = text_filesize;

    // __DATA holds two sections back to back: __got (filled in by
    // dyld via the bind opcode stream) followed by __data (the
    // program's static data segment, which we copy into the file).
    // Both are 8-byte aligned; we pick __data's offset as the
    // 8-byte ceiling of __got's end. __DATA is page-aligned and
    // sized to fit both, paying for an extra page only if __data
    // overflows the first.
    let data_fileoff = text_filesize;
    let data_vmaddr = TEXT_VMADDR_BASE + text_vmsize;
    let got_size = (build.imports.imports.len() * 8) as u64;
    let got_section_offset_in_segment: u64 = 0;
    let data_section_offset_in_segment: u64 = round_up(got_size, 8);
    let program_data_size = build.data.len() as u64;
    let data_segment_used = data_section_offset_in_segment + program_data_size;
    let data_filesize = round_up(data_segment_used.max(PAGE_SIZE), PAGE_SIZE);
    let data_vmsize = data_filesize;
    let data_section_vmaddr = data_vmaddr + data_section_offset_in_segment;
    let data_section_fileoff = data_fileoff + data_section_offset_in_segment;

    // __LINKEDIT: bind opcodes, then symtab, then strtab.
    let linkedit_fileoff = data_fileoff + data_filesize;
    let bind_off = linkedit_fileoff;
    let symoff = bind_off + bind_ops.len() as u64;
    let stroff = symoff + symtab.len() as u64;
    let linkedit_payload = bind_ops.len() + symtab.len() + strtab.len();
    let linkedit_filesize = linkedit_payload as u64;
    let linkedit_vmaddr = data_vmaddr + data_vmsize;
    let linkedit_vmsize = round_up(linkedit_filesize.max(PAGE_SIZE), PAGE_SIZE);

    // ---- step 5: build the load commands ----

    let pagezero = segment_no_sections("__PAGEZERO", 0, PAGEZERO_VMSIZE, 0, 0, 0, 0);
    let text_segment = segment_text(
        TEXT_VMADDR_BASE,
        text_vmsize,
        0,
        text_filesize,
        TEXT_VMADDR_BASE + entry_file_offset,
        code_size,
        entry_file_offset as u32,
    );
    let data_segment = segment_data(
        data_vmaddr,
        data_vmsize,
        data_fileoff,
        data_filesize,
        data_vmaddr + got_section_offset_in_segment,
        got_size,
        (data_fileoff + got_section_offset_in_segment) as u32,
        data_section_vmaddr,
        program_data_size,
        data_section_fileoff as u32,
    );
    let linkedit = segment_no_sections(
        "__LINKEDIT",
        linkedit_vmaddr,
        linkedit_vmsize,
        linkedit_fileoff,
        linkedit_filesize,
        VM_PROT_READ,
        VM_PROT_READ,
    );
    let dyld_info = dyld_info_only(
        0,
        0,
        bind_off as u32,
        bind_ops.len() as u32,
        0,
        0,
        0,
        0,
        0,
        0,
    );
    let symtab_lc = symtab_command(
        symoff as u32,
        build.imports.imports.len() as u32,
        stroff as u32,
        strtab.len() as u32,
    );
    let dysymtab_lc = dysymtab_command(build.imports.imports.len() as u32);
    // LC_MAIN's entryoff is a *file* offset, but `main` may live partway
    // through the emitted code if the compiler placed helper functions
    // first. `build.entry_offset` carries that intra-code offset.
    let main_lc = main_command(entry_file_offset + build.entry_offset as u64);

    debug_assert_eq!(text_segment.len() as u64, text_seg_size);
    debug_assert_eq!(data_segment.len() as u64, data_seg_size);
    debug_assert_eq!(linkedit.len() as u64, linkedit_seg_size);
    debug_assert_eq!(main_lc.len() as u64, main_size);

    // ---- step 6: emit ----

    let total_filesize = linkedit_fileoff + linkedit_filesize;
    let mut out = Vec::with_capacity(total_filesize as usize);

    // mach_header_64. We have undefined symbols now (_write); MH_NOUNDEFS
    // is dropped accordingly.
    // ncmds: 4 segments + dyldinfo + symtab + dysymtab + dylinker
    //        + N dylibs + build_version + main
    let ncmds: u32 = (10 + build.imports.dylibs.len()) as u32;
    write_struct(
        &mut out,
        &MachHeader64 {
            magic: MH_MAGIC_64,
            cputype: CPU_TYPE_ARM64,
            cpusubtype: CPU_SUBTYPE_ARM64_ALL,
            filetype: MH_EXECUTE,
            ncmds,
            sizeofcmds: sizeofcmds as u32,
            flags: MH_DYLDLINK | MH_TWOLEVEL | MH_PIE,
            reserved: 0,
        },
    );
    debug_assert_eq!(out.len() as u64, mh_size);

    // Load commands, ordered by Apple's convention: segments first,
    // then dyld_info family, then symbol tables, then dylinker /
    // dylib / build_version / main.
    out.extend_from_slice(&pagezero);
    out.extend_from_slice(&text_segment);
    out.extend_from_slice(&data_segment);
    out.extend_from_slice(&linkedit);
    out.extend_from_slice(&dyld_info);
    out.extend_from_slice(&symtab_lc);
    out.extend_from_slice(&dysymtab_lc);
    out.extend_from_slice(&dylinker);
    for lc in &dylib_lcs {
        out.extend_from_slice(lc);
    }
    out.extend_from_slice(&bv);
    out.extend_from_slice(&main_lc);

    debug_assert_eq!(out.len() as u64, header_plus_lcs);

    // Pad LCs out to entry_file_offset so codesign has room to insert
    // LC_CODE_SIGNATURE without trampling the code.
    out.resize(out.len() + lc_pad_bytes, 0);
    debug_assert_eq!(out.len() as u64, entry_file_offset);

    // __TEXT: copy code in, patch GOT / data / function-pointer
    // placeholders against the now-known segment vmaddrs, then
    // page-pad.
    let code_file_offset = out.len();
    let code_vmaddr_base = TEXT_VMADDR_BASE + entry_file_offset;
    out.extend_from_slice(code);
    apply_got_fixups(
        &mut out,
        code_file_offset,
        code_vmaddr_base,
        data_vmaddr + got_section_offset_in_segment,
        &build.got_fixups,
    )?;
    apply_data_fixups(
        &mut out,
        code_file_offset,
        code_vmaddr_base,
        data_section_vmaddr,
        &build.data_fixups,
    )?;
    apply_func_fixups(
        &mut out,
        code_file_offset,
        code_vmaddr_base,
        &build.func_fixups,
    )?;
    while (out.len() as u64) < text_filesize {
        out.push(0);
    }

    // __DATA: zero-pad up to where __data starts, then copy the
    // program's static data segment, then zero-pad to the next page.
    // dyld writes the GOT entries (which live in __got at the front
    // of __DATA) at load time using the bind opcodes from __LINKEDIT.
    out.resize(data_section_fileoff as usize, 0);
    out.extend_from_slice(&build.data);
    out.resize((data_fileoff + data_filesize) as usize, 0);

    // __LINKEDIT contents.
    out.extend_from_slice(&bind_ops);
    out.extend_from_slice(&symtab);
    out.extend_from_slice(&strtab);

    debug_assert_eq!(out.len() as u64, total_filesize);

    if out.len() > u32::MAX as usize {
        return Err(C4Error::Compile(format!(
            "Mach-O writer: image too large ({} bytes)",
            out.len()
        )));
    }
    Ok(out)
}

#[cfg(test)]
mod tests {
    //! Verify the structural invariants of the emitted Mach-O. The
    //! end-to-end "does it run" check happens after M1.4 lands codesign.

    use super::*;

    /// Smallest Build that exercises the layout end to end.
    ///
    /// Carries a single fake import (`_write` from libSystem) so
    /// the bind-opcode / symtab / dylib paths produce non-empty
    /// output worth asserting on. Real lowering populates this
    /// from the program's `#pragma binding`s.
    fn tiny_build() -> Build {
        use super::super::super::op::Op;
        use super::super::{ResolvedDylib, ResolvedImport, ResolvedImports};
        Build {
            // movz x0, #42 ; ret
            text: vec![0x40, 0x05, 0x80, 0xD2, 0xC0, 0x03, 0x5F, 0xD6],
            data: Vec::new(),
            entry_offset: 0,
            got_fixups: Vec::new(),
            data_fixups: Vec::new(),
            func_fixups: Vec::new(),
            bytecode_to_native: Vec::new(),
            imports: ResolvedImports {
                imports: vec![ResolvedImport {
                    op: Op::Write,
                    c4_name: "write".into(),
                    real_symbol: "_write".into(),
                    dylib_index: 0,
                }],
                dylibs: vec![ResolvedDylib {
                    name: "libc".into(),
                    path: "/usr/lib/libSystem.B.dylib".into(),
                }],
            },
        }
    }

    fn read_u32(buf: &[u8], off: usize) -> u32 {
        u32::from_le_bytes(buf[off..off + 4].try_into().unwrap())
    }

    #[test]
    fn writes_mh_magic_64() {
        let bytes = write(&tiny_build()).unwrap();
        assert_eq!(read_u32(&bytes, 0), MH_MAGIC_64);
    }

    #[test]
    fn cpu_type_is_arm64() {
        let bytes = write(&tiny_build()).unwrap();
        assert_eq!(read_u32(&bytes, 4), CPU_TYPE_ARM64);
    }

    #[test]
    fn filetype_is_mh_execute() {
        let bytes = write(&tiny_build()).unwrap();
        assert_eq!(read_u32(&bytes, 12), MH_EXECUTE);
    }

    #[test]
    fn flags_include_pie_and_dyldlink() {
        let bytes = write(&tiny_build()).unwrap();
        let flags = read_u32(&bytes, 24);
        assert_ne!(flags & MH_PIE, 0, "MH_PIE not set");
        assert_ne!(flags & MH_DYLDLINK, 0, "MH_DYLDLINK not set");
    }

    #[test]
    fn ncmds_baseline_is_ten_plus_dylibs() {
        // tiny_build has 1 dylib (libSystem) -> baseline 10 LCs
        // (4 segments + dyld_info + symtab + dysymtab + dylinker
        // + build_version + main) plus 1 LC_LOAD_DYLIB.
        let bytes = write(&tiny_build()).unwrap();
        assert_eq!(read_u32(&bytes, 16), 11);
    }

    #[test]
    fn lc_main_entry_lands_on_first_instruction_byte() {
        // Find LC_MAIN, read entryoff, check the byte at that offset
        // is the first instruction byte we passed in (the `movz x0,
        // #42` from tiny_build() starts with 0x40 in little-endian).
        // We have to look up entryoff rather than computing it as
        // (32 + sizeofcmds), because we leave padding between the LC
        // stream and the code so codesign can grow the LCs in place
        // without overwriting the entry point.
        let bytes = write(&tiny_build()).unwrap();
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
        let bytes = write(&tiny_build()).unwrap();
        // strtab is padded to 8 bytes, so the whole image is too.
        assert_eq!(bytes.len() % 8, 0);
        // Two full segments worth of file-resident data (__TEXT, __DATA)
        // plus some __LINKEDIT trailer.
        assert!(
            bytes.len() as u64 > 2 * PAGE_SIZE,
            "image too small: {} bytes",
            bytes.len()
        );
    }

    #[test]
    fn uleb128_round_trips() {
        // Spot-check the encoder against a few known values from
        // <mach-o/loader.h>'s ULEB references.
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

    #[test]
    fn bind_stream_contains_symbol_name() {
        let bytes = write(&tiny_build()).unwrap();
        // Walk the LCs to find LC_DYLD_INFO_ONLY, read bind_off+size,
        // confirm the symbol "_write" appears in there as a NUL-
        // terminated string.
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
    fn strtab_starts_with_leading_nul() {
        let bytes = write(&tiny_build()).unwrap();
        let sizeofcmds = read_u32(&bytes, 20) as usize;
        let mut p = 32usize;
        let lc_end = 32 + sizeofcmds;
        while p < lc_end {
            let cmd = read_u32(&bytes, p);
            let cmdsize = read_u32(&bytes, p + 4) as usize;
            if cmd == LC_SYMTAB {
                let stroff = read_u32(&bytes, p + 16) as usize;
                assert_eq!(bytes[stroff], 0, "string table must start with NUL");
                // tiny_build's only import is `_write`; it lands
                // immediately after the leading NUL.
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

    /// Round-trip through `otool -h` on the host to confirm Apple's
    /// own parser is happy with the header. A separate test below
    /// (`otool_l_lists_dyld_info`) checks the dyld_info LC.
    #[cfg(target_os = "macos")]
    #[test]
    fn otool_h_parses_the_image() {
        use std::io::Write;
        use std::process::Command;
        let bytes = write(&tiny_build()).unwrap();
        let path = std::env::temp_dir().join("badc-m1-3-h.bin");
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

    /// Confirm `dyld_info -imports` sees `_write` bound against
    /// libSystem. dyld_info is Apple's modern Mach-O introspection tool
    /// and the closest analogue to "what dyld would see at load time".
    /// If the bind stream is malformed, dyld_info says so.
    #[cfg(target_os = "macos")]
    #[test]
    fn dyld_info_imports_lists_write() {
        use std::io::Write;
        use std::process::Command;
        let bytes = write(&tiny_build()).unwrap();
        let path = std::env::temp_dir().join("badc-m1-3-bind.bin");
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

    /// `nm` should report `_write` as a U (undefined external) entry,
    /// confirming `LC_SYMTAB` and the string table are readable by
    /// classic Unix tooling.
    #[cfg(target_os = "macos")]
    #[test]
    fn nm_reports_write_undefined() {
        use std::io::Write;
        use std::process::Command;
        let bytes = write(&tiny_build()).unwrap();
        let path = std::env::temp_dir().join("badc-m1-3-nm.bin");
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
}
