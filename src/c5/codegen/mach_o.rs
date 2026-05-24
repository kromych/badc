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
use alloc::string::String;
use alloc::vec::Vec;

use super::super::error::C5Error;
use super::super::program::Program;
use super::Build;
use super::dwarf;

// ------------------------------------------------------------------
// Mach-O constants. Names mirror `<mach-o/loader.h>` and `<mach-o/nlist.h>`
// so cross-checking against system headers is mechanical.
// ------------------------------------------------------------------

const MH_MAGIC_64: u32 = 0xFEED_FACF;

const CPU_TYPE_ARM64: u32 = 0x0100_000C; // CPU_ARCH_ABI64 | CPU_TYPE_ARM
const CPU_SUBTYPE_ARM64_ALL: u32 = 0;

const MH_EXECUTE: u32 = 0x2;
/// `MH_DYLIB` filetype -- shared library (`.dylib`). Picked
/// when `OutputKind::SharedLibrary` is in effect; the writer
/// drops `LC_MAIN`, emits an `LC_ID_DYLIB` describing this
/// image's install name, and promotes each
/// `Program::exports` entry to an externally visible symbol.
const MH_DYLIB: u32 = 0x6;

const MH_DYLDLINK: u32 = 0x4;
const MH_TWOLEVEL: u32 = 0x80;
const MH_PIE: u32 = 0x0020_0000;
/// `MH_HAS_TLV_DESCRIPTORS` -- tells dyld the image carries
/// `__DATA,__thread_vars` descriptors that need their slot-0
/// thunk getters replaced with the real `tlv_get_addr`. Without
/// this flag dyld skips that pass and the descriptors stay
/// pointing at `_tlv_bootstrap_error`, which aborts on first
/// call. Set only when the program declares any
/// `_Thread_local` global.
const MH_HAS_TLV_DESCRIPTORS: u32 = 0x0080_0000;

const LC_REQ_DYLD: u32 = 0x8000_0000;
const LC_SEGMENT_64: u32 = 0x19;
const LC_SYMTAB: u32 = 0x2;
const LC_DYSYMTAB: u32 = 0xB;
const LC_LOAD_DYLINKER: u32 = 0xE;
const LC_LOAD_DYLIB: u32 = 0xC;
/// `LC_ID_DYLIB` -- this image's own install name. Same wire
/// shape as `LC_LOAD_DYLIB` (a `dylib_command` header
/// followed by the path bytes); dyld reads this to resolve
/// the dylib's filename when another image references it via
/// `LC_LOAD_DYLIB`. Required for `MH_DYLIB`.
const LC_ID_DYLIB: u32 = 0xD;
const LC_DYLD_INFO_ONLY: u32 = 0x22 | LC_REQ_DYLD;
const LC_MAIN: u32 = 0x28 | LC_REQ_DYLD;
const LC_BUILD_VERSION: u32 = 0x32;
/// `LC_UUID` -- 16-byte image identity. dyld uses it to dedup
/// modules in process-image lists; without it lldb's
/// `DynamicLoaderDarwin` re-registers our image after launch
/// against the static target image, triggering "address ...
/// maps to more than one section" warnings on every launch.
const LC_UUID: u32 = 0x1b;
/// Total bytes of `LC_UUID` on disk: 4 (cmd) + 4 (cmdsize) +
/// 16 (uuid) = 24.
const UUID_COMMAND_SIZE: usize = 24;

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

// ---- Rebase opcode stream. Used for in-image absolute
//      pointers (e.g., `int *p = &x;` initializers): the
//      file holds the preferred VA, dyld walks the rebase
//      stream and adds the slide delta to each named slot
//      after mapping the image. Same shape as the bind
//      stream -- top nibble = opcode, bottom nibble = imm. ----

const REBASE_OPCODE_DONE: u8 = 0x00;
const REBASE_OPCODE_SET_TYPE_IMM: u8 = 0x10;
const REBASE_OPCODE_SET_SEGMENT_AND_OFFSET_ULEB: u8 = 0x20;
/// `REBASE_OPCODE_DO_REBASE_IMM_TIMES` -- rebase N entries
/// where N is encoded in the low 4 bits of the opcode byte.
/// We use this for the per-DataReloc emission (one entry at
/// a time -- imm=1) rather than the ULEB form, since a
/// 4-bit count is always enough for a single bump and the
/// shorter encoding shaves a byte per reloc.
const REBASE_OPCODE_DO_REBASE_IMM_TIMES: u8 = 0x50;

const REBASE_TYPE_POINTER: u8 = 1;

const BIND_TYPE_POINTER: u8 = 1;

/// nlist_64 type bits.
const N_UNDF: u8 = 0x0;
/// `N_SECT` (in `n_type` field): symbol is defined in
/// section number `n_sect` of this image. Used for the
/// shared-library export entries -- each `#pragma export`
/// function shows up in the symbol table as
/// `N_EXT | N_SECT` with `n_sect` pointing at `__text`.
const N_SECT: u8 = 0xE;
const N_EXT: u8 = 0x01;
const NO_SECT: u8 = 0;
/// 1-based index of `__TEXT,__text` within the per-image
/// section table. Mach-O numbers sections globally across
/// all segments in declaration order; `__text` is the first
/// section we emit (`__TEXT`'s sole section), hence index 1.
const SECT_INDEX_TEXT: u8 = 1;

/// Segment indices, in the order they appear as `LC_SEGMENT_64` load
/// commands. Bind opcodes refer to segments by this index.
const SEG_INDEX_DATA: u8 = 2;

/// `S_ATTR_DEBUG` -- set on every section inside `__DWARF`.
/// Tells `nm`, `lldb`, `dyld_info`, and the Apple symbolicator
/// that this section is debug-only metadata: no code, no data,
/// don't try to install breakpoints into its vmaddr range, and
/// don't fold its symbols into the executable's lookup table.
/// Without this flag, lldb sees the section's `addr+size` as a
/// loaded range that overlaps `__TEXT` / `__DATA`, prints
/// "address ... maps to more than one section" warnings, and
/// refuses to resolve breakpoints set inside what it (wrongly)
/// thinks is a debug-overlapping region.
const S_ATTR_DEBUG: u32 = 0x0200_0000;

/// Mach-O section type bits used by the TLV layout. See
/// `<mach-o/loader.h>` for the full set; we only need
/// `__thread_bss` (zero-fill, the only flavour the c5 frontend
/// generates today since `_Thread_local` initialisers aren't
/// supported) and `__thread_vars` (descriptors). The matching
/// `__thread_data` (S_THREAD_LOCAL_REGULAR = 0x11) would be
/// emitted alongside if we ever support TLS initialisers.
#[allow(dead_code)]
const S_THREAD_LOCAL_REGULAR: u32 = 0x11; // __thread_data (init data)
const S_THREAD_LOCAL_ZEROFILL: u32 = 0x12; // __thread_bss (zero-fill)
const S_THREAD_LOCAL_VARIABLES: u32 = 0x13; // __thread_vars (descriptors)

/// Each TLV descriptor in `__thread_vars` is three pointer-sized
/// words: thunk getter (bound to `__tlv_bootstrap`), key (set by
/// dyld), and per-thread offset.
const TLV_DESCRIPTOR_SIZE: u64 = 24;

/// Symbol name dyld looks up to bootstrap each Thread-Local
/// Variable on first access. Lives in `libSystem.B.dylib`
/// (re-exported from `libdyld.dylib`); we bind it via the
/// regular bind-opcode stream just like any other libc import.
const TLV_BOOTSTRAP_SYMBOL: &str = "__tlv_bootstrap";

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

/// `LC_SEGMENT_64` for `__DATA` containing the
/// thread-local-variable scaffolding (`__thread_vars` +
/// `__thread_bss`) on top of the existing `__got` and `__data`.
/// Used when the program declares `_Thread_local` globals on a
/// macOS arm64 target. Layout (4 sections):
///
/// ```text
///   __DATA,__got           filled by dyld via bind opcodes
///   __DATA,__data          program's static data segment
///   __DATA,__thread_vars   24-byte descriptor per TLS variable
///   __DATA,__thread_bss    zero-fill TLS image (per-thread)
/// ```
///
/// 72 + 4 * 80 = 392 bytes total.
#[allow(clippy::too_many_arguments)]
fn segment_data_with_tlv(
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
    thread_vars_addr: u64,
    thread_vars_size: u64,
    thread_vars_offset: u32,
    thread_storage_addr: u64,
    thread_storage_size: u64,
    thread_storage_offset: u32,
    thread_storage_initialised: bool,
) -> Vec<u8> {
    const TOTAL: usize = SEGMENT_COMMAND_64_SIZE + 4 * SECTION_64_SIZE;
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
            nsects: 4,
            flags: 0,
        },
    );
    // __got
    write_struct(
        &mut out,
        &Section64 {
            sectname: pack_name16("__got"),
            segname: pack_name16("__DATA"),
            addr: got_addr,
            size: got_size,
            offset: got_offset,
            align: 3,
            reloff: 0,
            nreloc: 0,
            flags: 0,
            reserved1: 0,
            reserved2: 0,
            reserved3: 0,
        },
    );
    // __data
    write_struct(
        &mut out,
        &Section64 {
            sectname: pack_name16("__data"),
            segname: pack_name16("__DATA"),
            addr: data_addr,
            size: data_size,
            offset: data_offset,
            align: 3,
            reloff: 0,
            nreloc: 0,
            flags: 0,
            reserved1: 0,
            reserved2: 0,
            reserved3: 0,
        },
    );
    // __thread_vars -- 24-byte descriptor per TLS variable.
    // Section type S_THREAD_LOCAL_VARIABLES (0x13) tells dyld
    // these are descriptor records.
    write_struct(
        &mut out,
        &Section64 {
            sectname: pack_name16("__thread_vars"),
            segname: pack_name16("__DATA"),
            addr: thread_vars_addr,
            size: thread_vars_size,
            offset: thread_vars_offset,
            align: 3,
            reloff: 0,
            nreloc: 0,
            flags: S_THREAD_LOCAL_VARIABLES,
            reserved1: 0,
            reserved2: 0,
            reserved3: 0,
        },
    );
    // Per-thread storage area. Two flavours: when *any* TLS
    // variable has a static initializer, we emit
    // `__thread_data` (S_THREAD_LOCAL_REGULAR = 0x11) -- a
    // file-backed init template the loader copies into each
    // thread's per-thread block. Otherwise we emit
    // `__thread_bss` (S_THREAD_LOCAL_ZEROFILL = 0x12) -- no
    // file backing, the loader just zero-fills the per-thread
    // bytes.
    //
    // We don't try to split the byte range into "init prefix"
    // and "zero-fill suffix" sections; the c5 frontend lays
    // out TLS vars in declaration order and any uninit byte
    // inside the init prefix is already zero (the parser
    // pushes zero bytes per slot before optionally
    // overwriting), so emitting the full block as
    // `__thread_data` produces byte-for-byte the same
    // per-thread result as the split layout.
    let (storage_name, storage_flags, storage_file_offset) = if thread_storage_initialised {
        (
            *b"__thread_data\0\0\0",
            S_THREAD_LOCAL_REGULAR,
            thread_storage_offset,
        )
    } else {
        (*b"__thread_bss\0\0\0\0", S_THREAD_LOCAL_ZEROFILL, 0)
    };
    write_struct(
        &mut out,
        &Section64 {
            sectname: storage_name,
            segname: pack_name16("__DATA"),
            addr: thread_storage_addr,
            size: thread_storage_size,
            offset: storage_file_offset,
            align: 3,
            reloff: 0,
            nreloc: 0,
            flags: storage_flags,
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

/// `LC_SEGMENT_64` for `__DWARF` containing the five debug
/// sections we emit (`__debug_info`, `__debug_abbrev`,
/// `__debug_line`, `__debug_str`, `__debug_frame`).
///
/// Mach-O conventions for "DWARF embedded in a final-linked
/// executable" -- the form lldb expects when it cracks the
/// image directly rather than via a `.dSYM` bundle:
///
/// * `vmsize` rounds the debug filesize up to a page. Newer
///   `dyld_info` (Xcode 15+) rejects any `vmsize < filesize`
///   with "segment '...' filesize exceeds vmsize" -- which
///   then aborts `dyld_info -imports` before it prints any
///   bindings, breaking the structural Mach-O tests that pipe
///   through it. Older Apple tools tolerated `vmsize = 0`,
///   but we now mirror what ld64 emits when it keeps
///   `__DWARF` in-binary: a real, page-sized vmsize.
/// * `vmaddr` sits in its own page-aligned slot between
///   `__DATA.vmaddr + __DATA.vmsize` and `__LINKEDIT.vmaddr`
///   so the kernel's segment-overlap check stays clean.
/// * `initprot = maxprot = 0`. The bytes get mapped (because
///   vmsize > 0) but never accessed at runtime -- code only
///   reads __TEXT and writes __DATA, lldb / dsymutil read the
///   debug sections via the file image, and the kernel
///   accepts `prot = 0` as "reserved address space, no
///   permissions".
/// * Each section's `addr` mirrors `vmaddr` so `nm`'s
///   `addr >= segment.vmaddr` invariant holds; the
///   `S_ATTR_DEBUG` flag tells lldb / dyld_info / the Apple
///   symbolicator that the section is debug-only metadata so
///   address-based breakpoints aren't shadowed by it.
///
/// The four section file offsets and sizes are passed in by
/// the caller, which has just laid out the slot for `__DWARF`
/// between `__DATA` and `__LINKEDIT` in the order the sections
/// appear here.
#[allow(clippy::too_many_arguments)]
fn segment_dwarf(
    vmaddr: u64,
    vmsize: u64,
    fileoff: u64,
    filesize: u64,
    info_offset: u32,
    info_size: u64,
    abbrev_offset: u32,
    abbrev_size: u64,
    line_offset: u32,
    line_size: u64,
    str_offset: u32,
    str_size: u64,
    frame_offset: u32,
    frame_size: u64,
) -> Vec<u8> {
    const TOTAL: usize = SEGMENT_COMMAND_64_SIZE + 5 * SECTION_64_SIZE;
    let mut out = Vec::with_capacity(TOTAL);
    write_struct(
        &mut out,
        &SegmentCommand64 {
            cmd: LC_SEGMENT_64,
            cmdsize: TOTAL as u32,
            segname: pack_name16("__DWARF"),
            vmaddr,
            vmsize,
            fileoff,
            filesize,
            maxprot: 0,
            initprot: 0,
            nsects: 5,
            flags: 0,
        },
    );
    let dwarf_section = |sectname: &str, addr: u64, offset: u32, size: u64| Section64 {
        sectname: pack_name16(sectname),
        segname: pack_name16("__DWARF"),
        // Section addresses go ascending across the segment so
        // each `__debug_*` claims a distinct vmaddr range. With
        // every section's addr pinned at `segment.vmaddr` lldb
        // emits "address ... maps to more than one section"
        // warnings on every launch (it sees N sections starting
        // at the same vmaddr). The `S_ATTR_DEBUG` flag still
        // marks the section as debug-only so dyld doesn't try
        // to load these bytes; the unique addrs are purely for
        // lldb's section-resolution disambiguator.
        addr,
        size,
        offset,
        align: 0,
        reloff: 0,
        nreloc: 0,
        flags: S_ATTR_DEBUG,
        reserved1: 0,
        reserved2: 0,
        reserved3: 0,
    };
    let info_addr = vmaddr;
    let abbrev_addr = info_addr + info_size;
    let line_addr = abbrev_addr + abbrev_size;
    let str_addr = line_addr + line_size;
    let frame_addr = str_addr + str_size;
    let _ = vmaddr;
    write_struct(
        &mut out,
        &dwarf_section("__debug_info", info_addr, info_offset, info_size),
    );
    write_struct(
        &mut out,
        &dwarf_section("__debug_abbrev", abbrev_addr, abbrev_offset, abbrev_size),
    );
    write_struct(
        &mut out,
        &dwarf_section("__debug_line", line_addr, line_offset, line_size),
    );
    write_struct(
        &mut out,
        &dwarf_section("__debug_str", str_addr, str_offset, str_size),
    );
    write_struct(
        &mut out,
        &dwarf_section("__debug_frame", frame_addr, frame_offset, frame_size),
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
    dylib_command(LC_LOAD_DYLIB, path)
}

/// `LC_ID_DYLIB` -- this image's install name. Same wire
/// shape as `LC_LOAD_DYLIB`; differs only in the `cmd`
/// field. Used in shared-library output (MH_DYLIB).
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

/// `LC_UUID` -- 16-byte module-identity blob. Computed as a
/// FNV-1a hash of the build's text + data so that two
/// byte-identical compilations share a UUID (useful for cache
/// keying, dSYM matching). Doesn't have to be cryptographic;
/// lldb only uses it to deduplicate modules.
fn uuid_command(text: &[u8], data: &[u8]) -> Vec<u8> {
    fn fnv1a128(bytes: &[u8]) -> [u8; 16] {
        // Two interleaved 64-bit FNV-1a hashes give a 128-bit
        // result without needing a real cryptographic primitive.
        // Sufficient identity for lldb's dedup keying.
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
        // Mark as "version 4 / variant DCE" so consumers that
        // care about the RFC 4122 type bits (rarely; most just
        // treat it as opaque bytes) see something sensible.
        out[6] = (out[6] & 0x0f) | 0x40;
        out[8] = (out[8] & 0x3f) | 0x80;
        out
    }
    let mut hash_input: Vec<u8> = Vec::with_capacity(text.len() + data.len());
    hash_input.extend_from_slice(text);
    hash_input.extend_from_slice(data);
    let uuid = fnv1a128(&hash_input);
    let mut out = Vec::with_capacity(UUID_COMMAND_SIZE);
    out.extend_from_slice(&LC_UUID.to_le_bytes());
    out.extend_from_slice(&(UUID_COMMAND_SIZE as u32).to_le_bytes());
    out.extend_from_slice(&uuid);
    debug_assert_eq!(out.len(), UUID_COMMAND_SIZE);
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

/// `LC_DYSYMTAB` -- partition the symbol table into local /
/// external-defined / undefined ranges and point at the
/// indirect symbol table. We split the table as
/// `[exports..imports]`: the first `nextdefsym` entries are
/// `N_EXT | N_SECT` exports (one per `Program::exports`
/// entry, only present in shared-library output); the
/// remaining `nundefsym` are `N_EXT | N_UNDF` imports (one
/// per resolved libc binding).
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
) -> Result<(), C5Error> {
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
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!("Mach-O: GOT page diff {page_diff} not 4 KiB aligned"),
            )));
        }
        let imm21 = (page_diff >> 12) as i32;

        // ldr xN, [xN, #imm12] uses a 12-bit unsigned offset scaled
        // by 8 for 64-bit loads. The in-page byte offset must be
        // 8-aligned.
        let in_page = (target_vmaddr & 0xFFF) as u32;
        if !in_page.is_multiple_of(8) {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!("Mach-O: GOT slot offset {in_page:#x} not 8-aligned"),
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
) -> Result<(), C5Error> {
    let adrp_file_off = code_base_in_file + adrp_offset;
    let add_file_off = adrp_file_off + 4;
    let adrp_vmaddr = code_vmaddr_base + adrp_offset as u64;

    let adrp_page = adrp_vmaddr & !0xFFF;
    let target_page = target_vmaddr & !0xFFF;
    let page_diff = target_page as i64 - adrp_page as i64;
    if page_diff & 0xFFF != 0 {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
            &format!("Mach-O: {label} page diff {page_diff} not 4 KiB aligned"),
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
) -> Result<(), C5Error> {
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

/// Patch each macOS arm64 TLV access site. Each fixup's
/// `descriptor_index` selects a descriptor inside `__thread_vars`
/// (24 bytes per entry); the codegen left an `adrp + add x0, x0,
/// #_` pair to materialize the descriptor's vmaddr into x0
/// before the indirect call to slot 0.
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
        // The codegen emitted the adrp/add with rd = x0, but
        // `patch_adrp_add` writes x19. Patch the words directly
        // so the encoded rd field stays as the codegen wrote it.
        let adrp_file_off = code_base_in_file + fx.adrp_offset;
        let add_file_off = adrp_file_off + 4;
        let adrp_vmaddr = code_vmaddr_base + fx.adrp_offset as u64;

        let adrp_page = adrp_vmaddr & !0xFFF;
        let target_page = descriptor_vmaddr & !0xFFF;
        let page_diff = target_page as i64 - adrp_page as i64;
        if page_diff & 0xFFF != 0 {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!("Mach-O: TLV adrp page diff {page_diff} not 4 KiB aligned"),
            )));
        }
        let imm21 = (page_diff >> 12) as i32;
        let in_page = (descriptor_vmaddr & 0xFFF) as u32;

        // Preserve rd from the original adrp (codegen emitted rd=x0)
        // by reading the existing word; rd shouldn't change here, but
        // mirrors `patch_adrp_add`'s shape so future per-fixup rd
        // changes are easy.
        let adrp_word = u32::from_le_bytes([
            out[adrp_file_off],
            out[adrp_file_off + 1],
            out[adrp_file_off + 2],
            out[adrp_file_off + 3],
        ]);
        let rd = (adrp_word & 0x1F) as u8;
        let new_adrp = super::aarch64::enc_adrp(super::aarch64::Reg(rd), imm21);
        let new_add =
            super::aarch64::enc_add_imm(super::aarch64::Reg(rd), super::aarch64::Reg(rd), in_page);
        out[adrp_file_off..adrp_file_off + 4].copy_from_slice(&new_adrp.to_le_bytes());
        out[add_file_off..add_file_off + 4].copy_from_slice(&new_add.to_le_bytes());
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
) -> Result<(), C5Error> {
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

/// Layout context for the TLV bind ops. The thread_vars
/// descriptors live at `(__DATA, segment_offset + 24*i)`; their
/// slot 0 (the thunk getter pointer) is what dyld binds to
/// `__tlv_bootstrap`.
struct TlvBindContext {
    /// Byte offset of the start of `__thread_vars` within the
    /// `__DATA` segment.
    segment_offset: u64,
    /// Number of TLV descriptors that need binding.
    tlv_count: usize,
}

/// Bind opcode stream that resolves the program's imports plus,
/// when TLV is in use, every TLV descriptor's slot 0 (the thunk
/// getter pointer, bound to `__tlv_bootstrap`).
///
/// Each regular import lands at GOT slot `i` (offset `i*8` into
/// __DATA). Each TLV descriptor's slot 0 lands at offset
/// `tlv_ctx.segment_offset + i*24` into __DATA (slots 1 and 2
/// of each descriptor are not bound; dyld fills slot 1 and we
/// fill slot 2 statically).
/// Build the rebase opcode stream for in-image absolute
/// pointers. Each `data_relocs` entry corresponds to one
/// 8-byte slot inside `__DATA,__data` whose initial bytes
/// hold a preferred-load-address VA; dyld walks this stream
/// after mapping the image and adds the slide delta to each
/// listed slot.
///
/// `data_section_offset_in_segment` is the byte offset of
/// `__data` inside the `__DATA` segment. Each reloc's
/// `data_offset` is the byte offset within `build.data`, so
/// the segment-relative offset we feed to dyld is
/// `data_section_offset_in_segment + data_offset`.
fn build_rebase_opcodes(
    data_relocs: &[crate::c5::program::DataReloc],
    code_relocs: &[crate::c5::program::CodeReloc],
    segment: u8,
    data_section_offset_in_segment: u64,
) -> Vec<u8> {
    if data_relocs.is_empty() && code_relocs.is_empty() {
        return Vec::new();
    }
    let mut out = Vec::new();
    out.push(REBASE_OPCODE_SET_TYPE_IMM | REBASE_TYPE_POINTER);
    // Both data-pointer and code-pointer slots need the same
    // pointer-typed rebase opcode -- dyld just adds the slide. Sort
    // the merged list by data_offset so a future contiguous-burst
    // pass can walk it cleanly.
    let mut all: Vec<u64> = Vec::with_capacity(data_relocs.len() + code_relocs.len());
    all.extend(data_relocs.iter().map(|r| r.data_offset));
    all.extend(code_relocs.iter().map(|r| r.data_offset));
    all.sort();
    for &off in &all {
        let seg_off = data_section_offset_in_segment + off;
        out.push(REBASE_OPCODE_SET_SEGMENT_AND_OFFSET_ULEB | (segment & 0x0F));
        put_uleb128(&mut out, seg_off);
        // `REBASE_OPCODE_DO_REBASE_IMM_TIMES | 1` -- one entry,
        // count packed into the low 4 bits of the opcode byte.
        out.push(REBASE_OPCODE_DO_REBASE_IMM_TIMES | 1);
    }
    out.push(REBASE_OPCODE_DONE);
    pad_to(&mut out, 8);
    out
}

fn build_bind_opcodes(
    imports: &super::ResolvedImports,
    segment: u8,
    tlv_ctx: Option<TlvBindContext>,
) -> Vec<u8> {
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
    if let Some(ctx) = tlv_ctx {
        // `__tlv_bootstrap` always lives in libSystem; its
        // dylib ordinal is the position of libSystem in the
        // per-image dylib list, +1. We reuse the first dylib
        // (libSystem is always present on macOS targets) for
        // simplicity; if the order ever changes, the
        // matching nlist entry's ordinal is computed the same
        // way.
        let bootstrap_ordinal = imports
            .dylibs
            .iter()
            .position(|d| d.path.contains("libSystem"))
            .map(|i| (i + 1) as u8)
            .unwrap_or(1);
        if current_ordinal != Some(bootstrap_ordinal) {
            out.push(BIND_OPCODE_SET_DYLIB_ORDINAL_IMM | (bootstrap_ordinal & 0x0F));
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

/// One `nlist_64` for a symbol defined in this image (an
/// exported function). `n_value` is the runtime VA of the
/// symbol; `n_sect` is the 1-based section index it lives
/// in. The shared-library writer emits one of these per
/// `Program::exports` entry, with `N_EXT | N_SECT` so dyld /
/// `dlsym` will surface the symbol to other images.
/// One `nlist_64` for a file-local symbol -- `N_SECT` *without*
/// `N_EXT`, so dyld leaves it out of dlsym lookups but the host's
/// debugger and `nm` still see the name. Used to label
/// each PLT trampoline with its libc import name.
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

fn nlist_defined(n_strx: u32, n_value: u64, n_sect: u8) -> Vec<u8> {
    let mut out = Vec::with_capacity(NLIST_64_SIZE);
    write_struct(
        &mut out,
        &Nlist64 {
            n_strx,
            n_type: N_EXT | N_SECT,
            n_sect,
            n_desc: 0,
            n_value,
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

pub(super) fn write(program: &Program, build: &Build) -> Result<Vec<u8>, C5Error> {
    let code = &build.text;
    let tls_present = !build.macho_tlv_descriptors.is_empty();
    let n_tlv = build.macho_tlv_descriptors.len();

    // ---- step 1: build __LINKEDIT contents ----
    //
    // The lowering already resolved program.dylibs against the used
    // libc ops -- index N in `build.imports.imports` is GOT slot N
    // in __DATA, and the codegen's adrp+ldr placeholders refer to
    // those slots by index.
    //
    // When the program declares `_Thread_local` globals on macOS,
    // each TLV descriptor's slot 0 also needs to be bound -- to
    // `__tlv_bootstrap` from libSystem. We fold those into the
    // bind opcode stream here. The bootstrap symbol gets one
    // entry in the symbol table regardless of the descriptor
    // count (dyld looks up symbols by name, not by index).
    //
    // Bind opcodes go first, then the symbol table, then the string
    // table. Each subsection is 8-byte aligned so file offsets stay
    // nice. We need the sizes of all three to size __LINKEDIT, which
    // in turn sizes the LC stream.

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
    // __DATA carries 2 sections normally (__got, __data) and 4
    // when the program has `_Thread_local` globals (+__thread_vars,
    // __thread_bss).
    let data_seg_section_count: u64 = if tls_present { 4 } else { 2 };
    let data_seg_size: u64 =
        SEGMENT_COMMAND_64_SIZE as u64 + data_seg_section_count * SECTION_64_SIZE as u64;
    let linkedit_seg_size = SEGMENT_COMMAND_64_SIZE as u64;
    let is_dylib = build.output_kind == super::OutputKind::SharedLibrary;
    // __DWARF holds the four phase-1 debug sections
    // (__debug_info, __debug_abbrev, __debug_line, __debug_str)
    // -- 72 + 4*80 = 392 bytes of LC. Emitted for both
    // executables and dylibs The dylib coverage gate
    // dropped after the layout reshuffle that gave __DWARF its
    // own page-aligned vmaddr slot between __DATA and
    // __LINKEDIT (commit "give __DWARF a real vmsize..."). With
    // distinct vmaddrs, dyld's `vmsize > filesize` check passes
    // and dyld 4's dlsym-by-symbol-table fallback no longer
    // shadows the strtab against __DWARF.
    let emit_dwarf = build.debug_info;
    let _ = is_dylib;
    let dwarf_seg_size = if emit_dwarf {
        (SEGMENT_COMMAND_64_SIZE + 5 * SECTION_64_SIZE) as u64
    } else {
        0
    };
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
    let uuid_lc = uuid_command(&build.text, &build.data);
    // Shared libraries replace `LC_MAIN` (24 bytes) with
    // `LC_ID_DYLIB` (carries this image's install name --
    // hard-coded to `@rpath/c5-output.dylib`; programs that
    // dlopen this image by absolute path don't depend on the
    // install name's contents). Same shape as
    // `LC_LOAD_DYLIB`.
    let id_dylib_lc = if is_dylib {
        Some(id_dylib("@rpath/c5-output.dylib"))
    } else {
        None
    };

    let dylibs_total: u64 = dylib_lcs.iter().map(|lc| lc.len() as u64).sum();
    let entry_lc_size = if is_dylib {
        id_dylib_lc.as_ref().map(|lc| lc.len() as u64).unwrap_or(0)
    } else {
        main_size
    };
    let sizeofcmds = pagezero_size
        + text_seg_size
        + data_seg_size
        + linkedit_seg_size
        + dwarf_seg_size
        + dyld_info_size
        + symtab_size
        + dysymtab_size
        + dylinker.len() as u64
        + dylibs_total
        + bv.len() as u64
        + uuid_lc.len() as u64
        + entry_lc_size;

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

    // __DATA layout:
    //   __got           pointer per import; dyld fills via bind opcodes
    //   __data          program's static data segment
    //   __thread_vars   24-byte TLV descriptors (one per `_Thread_local`)
    //   __thread_bss    per-thread zero-fill storage (no file backing)
    // The first three contribute to the file image. Both __thread_bss
    // and the trailing zero-pad to a page boundary do not.
    let data_fileoff = text_filesize;
    let data_vmaddr = TEXT_VMADDR_BASE + text_vmsize;
    let got_size = (build.imports.imports.len() * 8) as u64;
    let got_section_offset_in_segment: u64 = 0;
    let data_section_offset_in_segment: u64 = round_up(got_size, 8);
    let program_data_size = build.data.len() as u64;
    let post_data_offset_in_segment: u64 =
        round_up(data_section_offset_in_segment + program_data_size, 8);
    let thread_vars_size: u64 = (n_tlv as u64) * TLV_DESCRIPTOR_SIZE;
    let thread_vars_offset_in_segment: u64 = if tls_present {
        post_data_offset_in_segment
    } else {
        0
    };
    let thread_storage_size: u64 = build.tls_data.len() as u64;
    let thread_storage_offset_in_segment: u64 = if tls_present {
        thread_vars_offset_in_segment + thread_vars_size
    } else {
        0
    };
    // The "per-thread storage" section is either:
    //   * `__thread_data` (file-backed, init template) when
    //     any TLS variable has a `_Thread_local int x = 5;`
    //     style initializer -- the loader copies these bytes
    //     into each thread's region. Bytes for uninit
    //     variables are zero from the parser, so emitting
    //     the whole tls_data as init template is byte-equivalent.
    //   * `__thread_bss` (no file backing) when there are
    //     no TLS initializers -- the loader zero-fills the
    //     per-thread region.
    let thread_storage_initialised = build.tls_init_size > 0;
    // File image needs got + data + thread_vars (always) and
    // thread_data when initialised (file-backed). vm image
    // covers everything plus thread_bss zero-fill.
    let data_segment_file_used: u64 = if tls_present {
        if thread_storage_initialised {
            thread_storage_offset_in_segment + thread_storage_size
        } else {
            thread_vars_offset_in_segment + thread_vars_size
        }
    } else {
        data_section_offset_in_segment + program_data_size
    };
    let data_segment_vm_used: u64 = if tls_present {
        thread_storage_offset_in_segment + thread_storage_size
    } else {
        data_segment_file_used
    };
    let data_filesize = round_up(data_segment_file_used.max(PAGE_SIZE), PAGE_SIZE);
    let data_vmsize = round_up(data_segment_vm_used.max(PAGE_SIZE), PAGE_SIZE);
    let data_section_vmaddr = data_vmaddr + data_section_offset_in_segment;
    let data_section_fileoff = data_fileoff + data_section_offset_in_segment;
    let thread_vars_vmaddr = data_vmaddr + thread_vars_offset_in_segment;
    let thread_vars_fileoff = data_fileoff + thread_vars_offset_in_segment;
    let thread_storage_vmaddr = data_vmaddr + thread_storage_offset_in_segment;
    let thread_storage_fileoff = data_fileoff + thread_storage_offset_in_segment;

    // ---- bind + rebase opcode streams ----
    //
    // Bind: every imported symbol (libc + the optional
    // `__tlv_bootstrap` for TLV) gets one entry, and dyld
    // resolves them at module-init time.
    //
    // Rebase: every `int *p = &x;`-style absolute pointer in
    // the file gets one entry. The data bytes hold the
    // preferred VA (image-base + RVA); dyld walks the rebase
    // stream after sliding the image and adds the slide
    // delta, so the runtime values are correct under ASLR
    // (`MH_PIE` is set, so dyld always slides).
    let bind_ops = build_bind_opcodes(
        &build.imports,
        SEG_INDEX_DATA,
        if tls_present {
            Some(TlvBindContext {
                segment_offset: thread_vars_offset_in_segment,
                tlv_count: n_tlv,
            })
        } else {
            None
        },
    );
    let rebase_ops = build_rebase_opcodes(
        &build.data_relocs,
        &build.code_relocs,
        SEG_INDEX_DATA,
        data_section_offset_in_segment,
    );

    // ---- symbol + string tables ----
    //
    // Layout: [exports][imports][tlv-bootstrap?]. dyld scans
    // by name through the string table, so order is mostly
    // cosmetic, but we keep extdef contiguous (LC_DYSYMTAB
    // tells dyld how many of each kind there are).
    //
    // Mach-O conventionally prefixes C exports with a leading
    // underscore (`int answer()` is `_answer` on disk). The
    // user's `#pragma export(name)` takes the c5-side name;
    // we add the underscore here so dlsym lookups by the
    // same C-side name resolve correctly.
    let export_disk_names: Vec<String> = build
        .exports
        .iter()
        .map(|e| format!("_{}", e.name))
        .collect();
    // per-PLT-trampoline local names go first in the
    // symtab so the LC_DYSYMTAB ranges stay in canonical order
    // (locals, then defined externals, then undefined). The
    // bind opcodes carry symbol *names* inline, so re-ordering
    // doesn't disturb dyld's binding logic.
    //
    // Use the c5-side `local_name` (e.g. "malloc") rather than
    // `real_symbol` ("_malloc") so `nm`/`lldb` show the name
    // the C source uses.
    //
    // Test fixtures sometimes hand us a `Build` with imports but
    // no trampoline offsets (no per-arch lower() ran); in that
    // case we skip the local section.
    let emit_plt_locals = !build.plt_trampoline_offsets.is_empty();
    let mut symbol_names: Vec<&str> = if emit_plt_locals {
        build
            .imports
            .imports
            .iter()
            .map(|imp| imp.local_name.as_str())
            .collect()
    } else {
        Vec::new()
    };
    let n_locals = symbol_names.len();
    for s in export_disk_names.iter() {
        symbol_names.push(s.as_str());
    }
    let n_exports = symbol_names.len() - n_locals;
    for imp in &build.imports.imports {
        symbol_names.push(imp.real_symbol.as_str());
    }
    if tls_present {
        symbol_names.push(TLV_BOOTSTRAP_SYMBOL);
    }
    let (strtab, str_indices) = build_strtab(&symbol_names);
    let mut symtab = Vec::with_capacity(NLIST_64_SIZE * symbol_names.len());

    let code_vmaddr_base = TEXT_VMADDR_BASE + entry_file_offset;

    // [Locals] one entry per PLT trampoline.
    if emit_plt_locals {
        debug_assert_eq!(
            build.plt_trampoline_offsets.len(),
            build.imports.imports.len(),
            "trampoline-offset count must match import count"
        );
        for (i, _imp) in build.imports.imports.iter().enumerate() {
            let n_strx = str_indices[i];
            let n_value = code_vmaddr_base + build.plt_trampoline_offsets[i] as u64;
            symtab.extend_from_slice(&nlist_local(n_strx, n_value, SECT_INDEX_TEXT));
        }
    }

    // [Defined exports] (N_EXT | N_SECT). Each one's `n_value`
    // is the runtime VA of the function: the code segment's
    // vmaddr base plus the function's native-byte offset within
    // `build.text`.
    for (i, exp) in build.exports.iter().enumerate() {
        let n_strx = str_indices[n_locals + i];
        let native_off = build
            .bytecode_to_native
            .get(exp.bytecode_pc)
            .copied()
            .unwrap_or(usize::MAX);
        if native_off == usize::MAX {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!(
                    "Mach-O: exported function `{}` (bc PC {}) doesn't \
                 align with any native instruction",
                    exp.name, exp.bytecode_pc
                ),
            )));
        }
        let n_value = code_vmaddr_base + native_off as u64;
        symtab.extend_from_slice(&nlist_defined(n_strx, n_value, SECT_INDEX_TEXT));
    }
    // [Undefined imports] (N_EXT | N_UNDF). Indices in
    // `str_indices` are shifted past the locals + exports.
    for (j, imp) in build.imports.imports.iter().enumerate() {
        let n_strx = str_indices[n_locals + n_exports + j];
        let ordinal = (imp.dylib_index + 1) as u8;
        symtab.extend_from_slice(&nlist_undef(n_strx, ordinal));
    }
    if tls_present {
        // `__tlv_bootstrap` comes from libSystem.B.dylib (which is
        // already in the dylib list because every macOS Mach-O
        // we emit links libSystem). Find its ordinal.
        let bootstrap_dylib_ordinal = build
            .imports
            .dylibs
            .iter()
            .position(|d| d.path.contains("libSystem"))
            .map(|i| (i + 1) as u8)
            .unwrap_or(1);
        let bootstrap_strx = str_indices[symbol_names.len() - 1];
        symtab.extend_from_slice(&nlist_undef(bootstrap_strx, bootstrap_dylib_ordinal));
    }
    let n_undef = symbol_names.len() - n_locals - n_exports;

    // __LINKEDIT: rebase opcodes, then bind opcodes, then
    // symtab, then strtab. Rebase comes first because dyld
    // walks them in that order and the LC_DYLD_INFO_ONLY
    // command's `rebase_off`/`bind_off` fields can name them
    // independently.
    // ---- __DWARF layout ----
    //
    // Phase 1 DWARF sits between __DATA and
    // __LINKEDIT in *both* LC order and file order. __LINKEDIT
    // has to remain the last file-resident segment because
    // `codesign --sign -` appends `LC_CODE_SIGNATURE` and grows
    // __LINKEDIT's filesize to cover the signature blob; any
    // bytes past __LINKEDIT would get clobbered. The segment
    // declares `vmsize = 0` so dyld skips the mmap -- the bytes
    // are file-only metadata that lldb / gdb pick up via the
    // LC_SEGMENT_64. Sections are packed back-to-back -- DWARF
    // readers don't require any alignment between them, and
    // the per-section `size` field stops them at the last real
    // byte regardless of the segment's tail pad.
    let (
        dwarf_sections,
        dwarf_fileoff,
        dwarf_info_offset,
        dwarf_abbrev_offset,
        dwarf_line_offset,
        dwarf_str_offset,
        dwarf_frame_offset,
        dwarf_filesize,
        dwarf_tail_pad,
    ) = if emit_dwarf {
        // Mach-O routes argc/argv through `LC_MAIN`,
        // not an emitted stub, so there's no entry-stub range to
        // describe.
        let s = dwarf::emit(
            program,
            build,
            super::Target::MacOSAarch64,
            code_vmaddr_base,
            &program.source_path,
            None,
        );
        let fileoff = data_fileoff + data_filesize;
        let info = fileoff;
        let abbrev = info + s.debug_info.len() as u64;
        let line = abbrev + s.debug_abbrev.len() as u64;
        let strs = line + s.debug_line.len() as u64;
        let frame = strs + s.debug_str.len() as u64;
        let sections_size = s.debug_info.len() as u64
            + s.debug_abbrev.len() as u64
            + s.debug_line.len() as u64
            + s.debug_str.len() as u64
            + s.debug_frame.len() as u64;
        // Pad up to a page so __LINKEDIT's fileoff lands on a
        // page boundary. dyld checks that every segment's
        // `fileoff % PAGE_SIZE == vmaddr % PAGE_SIZE`, and
        // __LINKEDIT sits on a page-aligned vmaddr.
        let filesize = round_up(sections_size, PAGE_SIZE);
        let pad = (filesize - sections_size) as usize;
        (s, fileoff, info, abbrev, line, strs, frame, filesize, pad)
    } else {
        (
            dwarf::DwarfSections {
                debug_info: Vec::new(),
                debug_abbrev: Vec::new(),
                debug_line: Vec::new(),
                debug_str: Vec::new(),
                debug_frame: Vec::new(),
            },
            data_fileoff + data_filesize,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
        )
    };

    let linkedit_fileoff = dwarf_fileoff + dwarf_filesize;
    let rebase_off = linkedit_fileoff;
    let bind_off = rebase_off + rebase_ops.len() as u64;
    let symoff = bind_off + bind_ops.len() as u64;
    let stroff = symoff + symtab.len() as u64;
    let linkedit_payload = rebase_ops.len() + bind_ops.len() + symtab.len() + strtab.len();
    let linkedit_filesize = linkedit_payload as u64;
    // __DWARF claims its own page-aligned vmaddr range between
    // __DATA and __LINKEDIT (when emit_dwarf), so the
    // segment-vmaddr ordering stays monotonic and dyld_info's
    // "filesize <= vmsize" check holds. When emit_dwarf=false
    // the slot collapses to zero and __LINKEDIT abuts __DATA
    // directly, matching the pre-DWARF layout.
    let dwarf_vmaddr = data_vmaddr + data_vmsize;
    let dwarf_vmsize = if emit_dwarf {
        round_up(dwarf_filesize, PAGE_SIZE)
    } else {
        0
    };
    let linkedit_vmaddr = dwarf_vmaddr + dwarf_vmsize;
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
    let data_segment = if tls_present {
        segment_data_with_tlv(
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
            thread_vars_vmaddr,
            thread_vars_size,
            thread_vars_fileoff as u32,
            thread_storage_vmaddr,
            thread_storage_size,
            thread_storage_fileoff as u32,
            thread_storage_initialised,
        )
    } else {
        segment_data(
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
        )
    };
    let linkedit = segment_no_sections(
        "__LINKEDIT",
        linkedit_vmaddr,
        linkedit_vmsize,
        linkedit_fileoff,
        linkedit_filesize,
        VM_PROT_READ,
        VM_PROT_READ,
    );
    let dwarf_segment = if emit_dwarf {
        segment_dwarf(
            dwarf_vmaddr,
            dwarf_vmsize,
            dwarf_fileoff,
            dwarf_filesize,
            dwarf_info_offset as u32,
            dwarf_sections.debug_info.len() as u64,
            dwarf_abbrev_offset as u32,
            dwarf_sections.debug_abbrev.len() as u64,
            dwarf_line_offset as u32,
            dwarf_sections.debug_line.len() as u64,
            dwarf_str_offset as u32,
            dwarf_sections.debug_str.len() as u64,
            dwarf_frame_offset as u32,
            dwarf_sections.debug_frame.len() as u64,
        )
    } else {
        Vec::new()
    };
    let dyld_info = dyld_info_only(
        rebase_off as u32,
        rebase_ops.len() as u32,
        bind_off as u32,
        bind_ops.len() as u32,
        0,
        0,
        0,
        0,
        0,
        0,
    );
    let nsyms_total = symbol_names.len() as u32;
    let symtab_lc = symtab_command(
        symoff as u32,
        nsyms_total,
        stroff as u32,
        strtab.len() as u32,
    );
    let dysymtab_lc = dysymtab_command(n_locals as u32, n_exports as u32, n_undef as u32);
    // For executables: LC_MAIN with the entry-point file
    // offset. For dylibs: no entry; LC_ID_DYLIB takes its
    // place (already constructed above).
    let main_lc = if is_dylib {
        Vec::new()
    } else {
        main_command(entry_file_offset + build.entry_offset as u64)
    };

    debug_assert_eq!(text_segment.len() as u64, text_seg_size);
    debug_assert_eq!(data_segment.len() as u64, data_seg_size);
    debug_assert_eq!(linkedit.len() as u64, linkedit_seg_size);
    debug_assert_eq!(dwarf_segment.len() as u64, dwarf_seg_size);
    if !is_dylib {
        debug_assert_eq!(main_lc.len() as u64, main_size);
    }

    // ---- step 6: emit ----

    let total_filesize = linkedit_fileoff + linkedit_filesize;
    let mut out = Vec::with_capacity(total_filesize as usize);

    // mach_header_64. We have undefined symbols now (_write); MH_NOUNDEFS
    // is dropped accordingly.
    // ncmds: 4 segments (5 with __DWARF) + dyldinfo + symtab +
    //        dysymtab + dylinker + N dylibs + build_version
    //        + main (or LC_ID_DYLIB for dylibs).
    let ncmds: u32 = 11 + (emit_dwarf as u32) + build.imports.dylibs.len() as u32;
    let mut header_flags = MH_DYLDLINK | MH_TWOLEVEL | MH_PIE;
    if tls_present {
        header_flags |= MH_HAS_TLV_DESCRIPTORS;
    }
    let filetype = if is_dylib { MH_DYLIB } else { MH_EXECUTE };
    write_struct(
        &mut out,
        &MachHeader64 {
            magic: MH_MAGIC_64,
            cputype: CPU_TYPE_ARM64,
            cpusubtype: CPU_SUBTYPE_ARM64_ALL,
            filetype,
            ncmds,
            sizeofcmds: sizeofcmds as u32,
            flags: header_flags,
            reserved: 0,
        },
    );
    debug_assert_eq!(out.len() as u64, mh_size);

    // Load commands, ordered by Apple's convention: segments first,
    // then dyld_info family, then symbol tables, then dylinker /
    // dylib / build_version / main (or LC_ID_DYLIB for shared libs).
    // Segment LC order: __PAGEZERO, __TEXT, __DATA, __DWARF
    // (executables only), __LINKEDIT -- the layout
    // `go build` produces for executables. __DWARF reuses
    // __LINKEDIT's vmaddr with vmsize=0, so the loaded image's
    // address space stays monotonic non-decreasing.
    // File-resident order matches LC order.
    out.extend_from_slice(&pagezero);
    out.extend_from_slice(&text_segment);
    out.extend_from_slice(&data_segment);
    if emit_dwarf {
        out.extend_from_slice(&dwarf_segment);
    }
    out.extend_from_slice(&linkedit);
    out.extend_from_slice(&dyld_info);
    out.extend_from_slice(&symtab_lc);
    out.extend_from_slice(&dysymtab_lc);
    out.extend_from_slice(&dylinker);
    for lc in &dylib_lcs {
        out.extend_from_slice(lc);
    }
    out.extend_from_slice(&bv);
    out.extend_from_slice(&uuid_lc);
    if let Some(lc) = &id_dylib_lc {
        out.extend_from_slice(lc);
    } else {
        out.extend_from_slice(&main_lc);
    }

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
    // Patch TLV adrp+add fixups now that we know the
    // __thread_vars vmaddr layout. Each fixup's
    // `descriptor_index` selects a 24-byte descriptor inside
    // __thread_vars; the codegen left an `adrp + add x0, x0, #_`
    // pair to materialize that descriptor's address into x0
    // before the indirect call.
    apply_macho_tlv_fixups(
        &mut out,
        code_file_offset,
        code_vmaddr_base,
        thread_vars_vmaddr,
        &build.macho_tlv_fixups,
    )?;
    while (out.len() as u64) < text_filesize {
        out.push(0);
    }

    // __DATA: zero-pad up to where __data starts, then copy the
    // program's static data segment with pointer-to-global
    // initializers materialized as preferred-VA bytes. dyld
    // walks the rebase opcode stream after sliding the image
    // and adds the slide delta to each named slot, so the
    // runtime values land at the right address under ASLR.
    // The GOT entries (in __got, ahead of __data) come from
    // the bind opcode stream; we leave those zero here.
    out.resize(data_section_fileoff as usize, 0);
    let mut data_with_relocs = build.data.clone();
    for r in &build.data_relocs {
        let preferred_va = data_section_vmaddr + r.target_offset;
        let off = r.data_offset as usize;
        if off + 8 > data_with_relocs.len() {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!(
                    "Mach-O: data reloc offset {off:#x} past end of __data ({})",
                    data_with_relocs.len()
                ),
            )));
        }
        data_with_relocs[off..off + 8].copy_from_slice(&preferred_va.to_le_bytes());
    }
    // Function-pointer initializers in the data segment: pre-fill
    // each slot with the function's preferred-load-address VA
    // (text vmaddr + native code offset). dyld adds the slide
    // delta when it walks the rebase opcode stream below.
    for r in &build.code_relocs {
        let bc_pc = r.target_bc_pc as usize;
        let native_off = build
            .bytecode_to_native
            .get(bc_pc)
            .copied()
            .unwrap_or(usize::MAX);
        if native_off == usize::MAX {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!("Mach-O: code reloc references missing bytecode pc {bc_pc}"),
            )));
        }
        let preferred_va = code_vmaddr_base + native_off as u64;
        let off = r.data_offset as usize;
        if off + 8 > data_with_relocs.len() {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!(
                    "Mach-O: code reloc offset {off:#x} past end of __data ({})",
                    data_with_relocs.len()
                ),
            )));
        }
        data_with_relocs[off..off + 8].copy_from_slice(&preferred_va.to_le_bytes());
    }
    out.extend_from_slice(&data_with_relocs);
    if tls_present {
        // __thread_vars: one 24-byte descriptor per TLS variable.
        // Slot 0 (thunk getter) stays zero -- dyld writes
        // `__tlv_bootstrap`'s address there at load time via the
        // bind opcodes we emitted. Slot 1 (key) stays zero --
        // dyld populates it. Slot 2 holds the variable's offset
        // within the per-thread storage block (this is what the
        // bootstrap-replaced fast getter eventually adds to its
        // pthread-keyed base pointer).
        out.resize(thread_vars_fileoff as usize, 0);
        for desc in &build.macho_tlv_descriptors {
            // [0..8]: thunk function pointer -- dyld fills via bind.
            out.extend_from_slice(&0u64.to_le_bytes());
            // [8..16]: key -- dyld fills.
            out.extend_from_slice(&0u64.to_le_bytes());
            // [16..24]: per-thread offset.
            out.extend_from_slice(&desc.offset_in_block.to_le_bytes());
        }
        // When at least one TLS variable has a static
        // initializer, the per-thread storage section is
        // `__thread_data` (file-backed) rather than
        // `__thread_bss` (zero-fill). Emit the full tls_data
        // bytes as the init template; dyld copies them into
        // each thread's region at thread creation. Bytes for
        // uninitialised TLS variables are already zero (the
        // parser zero-fills before optionally overwriting),
        // so the per-thread effect matches the split
        // .tdata/.tbss layout.
        if thread_storage_initialised {
            out.resize(thread_storage_fileoff as usize, 0);
            out.extend_from_slice(&build.tls_data);
        }
    }
    out.resize((data_fileoff + data_filesize) as usize, 0);

    // __DWARF contents (executables only -- dylibs skip phase
    // 1 DWARF, see `emit_dwarf`). Order matches what
    // `segment_dwarf` pointed each section at: info, abbrev,
    // line, str. Sits ahead of __LINKEDIT so codesign can grow
    // __LINKEDIT at the file tail without trampling debug
    // bytes.
    if emit_dwarf {
        debug_assert_eq!(out.len() as u64, dwarf_fileoff);
        out.extend_from_slice(&dwarf_sections.debug_info);
        out.extend_from_slice(&dwarf_sections.debug_abbrev);
        out.extend_from_slice(&dwarf_sections.debug_line);
        out.extend_from_slice(&dwarf_sections.debug_str);
        out.extend_from_slice(&dwarf_sections.debug_frame);
        out.resize(out.len() + dwarf_tail_pad, 0);
    }

    // __LINKEDIT contents. Order matches what
    // LC_DYLD_INFO_ONLY's offsets name: rebase_off first, then
    // bind_off, then symtab, then strtab.
    debug_assert_eq!(out.len() as u64, linkedit_fileoff);
    out.extend_from_slice(&rebase_ops);
    out.extend_from_slice(&bind_ops);
    out.extend_from_slice(&symtab);
    out.extend_from_slice(&strtab);

    debug_assert_eq!(out.len() as u64, total_filesize);

    if out.len() > u32::MAX as usize {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
            &format!("Mach-O writer: image too large ({} bytes)", out.len()),
        )));
    }
    Ok(out)
}

#[cfg(test)]
mod tests {
    //! Verify the structural invariants of the emitted Mach-O. The
    //! end-to-end "does it run" check lives in `tests/native.rs`,
    //! which builds the binary and execs it.

    use super::*;

    /// Smallest Build that exercises the layout end to end.
    ///
    /// Carries a single fake import (`_write` from libSystem) so
    /// the bind-opcode / symtab / dylib paths produce non-empty
    /// output worth asserting on. Real lowering populates this
    /// from the program's `#pragma binding`s.
    /// Empty `Program` paired with `tiny_build`. The DWARF
    /// emitter needs *a* program to walk for `Op::Ent`s --
    /// passing the matching empty `text` + `source_*` keeps
    /// the debug-segment payload trivial without changing
    /// the structural invariants the tests check.
    fn tiny_program() -> Program {
        Program {
            text: Vec::new(),
            data: Vec::new(),
            entry_pc: 0,
            warnings: Vec::new(),
            data_imm_positions: Vec::new(),
            code_imm_positions: Vec::new(),
            call_fp_arg_masks: Vec::new(),
            variadic_functions: alloc::collections::BTreeSet::new(),
            tls_data: Vec::new(),
            tls_init_size: 0,
            data_relocs: Vec::new(),
            code_relocs: Vec::new(),
            exports: Vec::new(),
            dylibs: Vec::new(),
            dllmain_pc: None,
            source_lines: Vec::new(),
            source_functions: Vec::new(),
            source_files: Vec::new(),
            source_file_indices: Vec::new(),
            source_path: String::new(),
            variables: Vec::new(),
            structs: Vec::new(),
            entry_name: None,
            subsystem: None,
            optimized: false,
            finished_functions: alloc::vec::Vec::new(),
            symbols: alloc::vec::Vec::new(),
            synthetic_ssa_funcs: alloc::vec::Vec::new(),
            user_ssa_funcs: alloc::vec::Vec::new(),
            extern_function_imports: alloc::vec::Vec::new(),
        }
    }

    fn tiny_build() -> Build {
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
            func_ent_pcs: Vec::new(),
            reloc_call_sites: Vec::new(),
            user_extern_call_sites: Vec::new(),
            ssa_line_rows: Vec::new(),
            imports: ResolvedImports {
                imports: vec![ResolvedImport {
                    binding_idx: 0,
                    local_name: "write".into(),
                    real_symbol: "_write".into(),
                    dylib_index: 0,
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
            },
            abi: super::super::Target::MacOSAarch64.abi(),
            tls_data: Vec::new(),
            tls_init_size: 0,
            tls_index_fixups: Vec::new(),
            data_relocs: Vec::new(),
            code_relocs: Vec::new(),
            exports: Vec::new(),
            output_kind: super::super::OutputKind::Executable,
            dllmain_pc: None,
            macho_tlv_fixups: Vec::new(),
            macho_tlv_descriptors: Vec::new(),
            debug_info: true,
            plt_trampoline_offsets: Vec::new(),
        }
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
        // tiny_build has 1 dylib (libSystem) -> baseline 12 LCs
        // (5 segments incl. __DWARF + dyld_info + symtab +
        // dysymtab + dylinker + build_version + uuid + main)
        // plus 1 LC_LOAD_DYLIB.
        let bytes = write(&tiny_program(), &tiny_build()).unwrap();
        assert_eq!(read_u32(&bytes, 16), 13);
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
        let bytes = write(&tiny_program(), &tiny_build()).unwrap();
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
        let bytes = write(&tiny_program(), &tiny_build()).unwrap();
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
        let bytes = write(&tiny_program(), &tiny_build()).unwrap();
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

    /// Structural check for the TLV path. Compiles a program
    /// declaring a single `_Thread_local` global, writes the
    /// Mach-O, and verifies:
    ///   * `MH_HAS_TLV_DESCRIPTORS` is set in the mach header
    ///     flags (otherwise dyld doesn't replace descriptor
    ///     slot 0 with the real getter, and `__tlv_bootstrap`
    ///     resolves to the abort-on-call error stub),
    ///   * `__DATA` carries 4 sections including
    ///     `__thread_vars` (S_THREAD_LOCAL_VARIABLES = 0x13)
    ///     and `__thread_bss` (S_THREAD_LOCAL_ZEROFILL = 0x12),
    ///   * the bind opcode stream contains the
    ///     `__tlv_bootstrap` symbol name.
    ///
    /// End-to-end execution is covered by
    /// `c5::tests::native::fixture_parity`'s
    /// `thread_local_basic.c` entry; this test runs even on
    /// machines that can't `codesign` (e.g., a CI runner with
    /// macOS but a stripped-down keychain).
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

        // mach_header_64.flags carries MH_HAS_TLV_DESCRIPTORS.
        let flags = read_u32(&bytes, 24);
        assert_ne!(
            flags & MH_HAS_TLV_DESCRIPTORS,
            0,
            "expected MH_HAS_TLV_DESCRIPTORS in mach header flags, got {flags:#x}"
        );

        // Walk the LCs and find __DATA segment; confirm it has
        // 4 sections including __thread_vars and __thread_bss
        // with the right type bits.
        let sizeofcmds = read_u32(&bytes, 20) as usize;
        let mut p = 32usize;
        let lc_end = 32 + sizeofcmds;
        let mut saw_thread_vars = false;
        let mut saw_thread_bss = false;
        while p < lc_end {
            let cmd = read_u32(&bytes, p);
            let cmdsize = read_u32(&bytes, p + 4) as usize;
            if cmd == LC_SEGMENT_64 {
                // segname at p + 8 (16 bytes).
                let segname = &bytes[p + 8..p + 24];
                if segname.starts_with(b"__DATA\0") {
                    let nsects = read_u32(&bytes, p + 64) as usize;
                    assert_eq!(nsects, 4, "__DATA must have 4 sections when TLV present");
                    let mut sect_p = p + 72;
                    for _ in 0..nsects {
                        let sect_name = &bytes[sect_p..sect_p + 16];
                        // section flags at offset 64 within Section64.
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

        // Bind stream names `__tlv_bootstrap` so dyld knows
        // which TLV initialiser to replace each descriptor's
        // slot 0 with.
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

    /// Same `_Thread_local` source compiles cleanly *without*
    /// the TLV mach-header flag when there's no TLS. Sanity
    /// check that we don't accidentally set the flag for
    /// non-TLS programs (which would mislead dyld into
    /// scanning a non-existent `__thread_vars`).
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
    /// confirming `LC_SYMTAB` and the string table are readable by
    /// classic Unix tooling.
    #[cfg(target_os = "macos")]
    #[test]
    fn nm_reports_write_undefined() {
        use std::io::Write;
        use std::process::Command;
        let bytes = write(&tiny_program(), &tiny_build()).unwrap();
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
