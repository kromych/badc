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
//! ## Layout we emit (M1.3)
//!
//! ```text
//!   file                                              segment / contents
//!   --------------------------------------------------------------------
//!   0x0000   mach_header_64                           ┐
//!            LC_SEGMENT_64 __PAGEZERO                 │
//!            LC_SEGMENT_64 __TEXT (1 sect: __text)    │
//!            LC_SEGMENT_64 __DATA (1 sect: __got)     │ __TEXT
//!            LC_SEGMENT_64 __LINKEDIT                 │
//!            LC_DYLD_INFO_ONLY                        │
//!            LC_SYMTAB                                │
//!            LC_DYSYMTAB                              │
//!            LC_LOAD_DYLINKER /usr/lib/dyld           │
//!            LC_LOAD_DYLIB   /usr/lib/libSystem...    │
//!            LC_BUILD_VERSION                         │
//!            LC_MAIN entry_off=...                    │
//!            <padding>                                │
//!            <machine code from build.text>           │
//!            <pad to 16 KiB>                          ┘
//!   0x4000   <16 KiB __DATA -- __got at offset 0, rest zero>
//!   0x8000   __LINKEDIT contents:                     bind opcodes,
//!                                                     symbol table,
//!                                                     string table.
//! ```
//!
//! __PAGEZERO is an unmapped 4 GiB segment at vmaddr 0 -- the standard
//! null-pointer-deref catcher. __TEXT carries the header plus the code.
//! __DATA holds the GOT (one pointer-sized slot per imported symbol);
//! dyld fills the slots in at launch via the bind opcode stream in
//! __LINKEDIT. __LINKEDIT also holds the symbol + string tables so
//! tools like `otool -bind` can name what's being bound.
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

/// Library ordinal -> n_desc encoding for two-level bound symbols.
/// libSystem is always our first (and currently only) imported dylib,
/// so it gets ordinal 1.
const LIBSYSTEM_ORDINAL: u16 = 1;

/// Segment indices, in the order they appear as `LC_SEGMENT_64` load
/// commands. Bind opcodes refer to segments by this index.
const SEG_INDEX_DATA: u8 = 2;

// ------------------------------------------------------------------
// Tiny serialization helpers. Mach-O is little-endian on every cpu we
// target; everything funnels through to_le_bytes so a future
// big-endian export would only touch this section.
// ------------------------------------------------------------------

fn put_u32(out: &mut Vec<u8>, v: u32) {
    out.extend_from_slice(&v.to_le_bytes());
}
fn put_u64(out: &mut Vec<u8>, v: u64) {
    out.extend_from_slice(&v.to_le_bytes());
}

/// Write a 16-byte fixed-length name, NUL-padded. Used for segname /
/// sectname fields where the on-disk struct holds `char[16]`.
fn put_name16(out: &mut Vec<u8>, name: &str) {
    debug_assert!(name.len() <= 16, "segment/section name too long: {name:?}");
    let mut buf = [0u8; 16];
    for (i, b) in name.as_bytes().iter().take(16).enumerate() {
        buf[i] = *b;
    }
    out.extend_from_slice(&buf);
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
    let mut out = Vec::with_capacity(72);
    put_u32(&mut out, LC_SEGMENT_64);
    put_u32(&mut out, 72); // cmdsize -- no sections
    put_name16(&mut out, name);
    put_u64(&mut out, vmaddr);
    put_u64(&mut out, vmsize);
    put_u64(&mut out, fileoff);
    put_u64(&mut out, filesize);
    put_u32(&mut out, maxprot);
    put_u32(&mut out, initprot);
    put_u32(&mut out, 0); // nsects
    put_u32(&mut out, 0); // flags
    debug_assert_eq!(out.len(), 72);
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
    let mut out = Vec::with_capacity(72 + 80);
    put_u32(&mut out, LC_SEGMENT_64);
    put_u32(&mut out, 72 + 80);
    put_name16(&mut out, "__TEXT");
    put_u64(&mut out, vmaddr);
    put_u64(&mut out, vmsize);
    put_u64(&mut out, fileoff);
    put_u64(&mut out, filesize);
    put_u32(&mut out, VM_PROT_READ | VM_PROT_EXECUTE); // maxprot
    put_u32(&mut out, VM_PROT_READ | VM_PROT_EXECUTE); // initprot
    put_u32(&mut out, 1); // nsects
    put_u32(&mut out, 0); // flags

    // section_64 (80 bytes) -- one __text section.
    put_name16(&mut out, "__text");
    put_name16(&mut out, "__TEXT");
    put_u64(&mut out, text_addr);
    put_u64(&mut out, text_size);
    put_u32(&mut out, text_offset);
    put_u32(&mut out, 2); // align (log2 -- 4 bytes for arm64 instructions)
    put_u32(&mut out, 0); // reloff
    put_u32(&mut out, 0); // nreloc
    // S_REGULAR (0) | S_ATTR_PURE_INSTRUCTIONS | S_ATTR_SOME_INSTRUCTIONS
    put_u32(&mut out, 0x8000_0400);
    put_u32(&mut out, 0); // reserved1
    put_u32(&mut out, 0); // reserved2
    put_u32(&mut out, 0); // reserved3
    debug_assert_eq!(out.len(), 72 + 80);
    out
}

/// `LC_SEGMENT_64` for `__DATA` containing the `__got` section.
/// dyld's bind opcodes write resolved symbol addresses into __got at
/// load time; the section starts zero-filled. 72 + 80 bytes total.
#[allow(clippy::too_many_arguments)]
fn segment_data(
    vmaddr: u64,
    vmsize: u64,
    fileoff: u64,
    filesize: u64,
    got_addr: u64,
    got_size: u64,
    got_offset: u32,
) -> Vec<u8> {
    let mut out = Vec::with_capacity(72 + 80);
    put_u32(&mut out, LC_SEGMENT_64);
    put_u32(&mut out, 72 + 80);
    put_name16(&mut out, "__DATA");
    put_u64(&mut out, vmaddr);
    put_u64(&mut out, vmsize);
    put_u64(&mut out, fileoff);
    put_u64(&mut out, filesize);
    put_u32(&mut out, VM_PROT_READ | VM_PROT_WRITE); // maxprot
    put_u32(&mut out, VM_PROT_READ | VM_PROT_WRITE); // initprot
    put_u32(&mut out, 1); // nsects
    put_u32(&mut out, 0); // flags

    // __got section. We fill it via bind opcodes, not the indirect
    // symbol table, so the section type stays S_REGULAR (0).
    // Conventionally __got is named that way and otool treats it
    // specially even without any flag bits.
    put_name16(&mut out, "__got");
    put_name16(&mut out, "__DATA");
    put_u64(&mut out, got_addr);
    put_u64(&mut out, got_size);
    put_u32(&mut out, got_offset);
    put_u32(&mut out, 3); // align (log2 -- 8 bytes for u64 pointers)
    put_u32(&mut out, 0); // reloff
    put_u32(&mut out, 0); // nreloc
    put_u32(&mut out, 0); // flags = S_REGULAR
    put_u32(&mut out, 0); // reserved1 (no indirect entries)
    put_u32(&mut out, 0); // reserved2
    put_u32(&mut out, 0); // reserved3
    debug_assert_eq!(out.len(), 72 + 80);
    out
}

/// `LC_LOAD_DYLINKER` -- tells dyld it is the dynamic linker.
fn load_dylinker(path: &str) -> Vec<u8> {
    let mut out = Vec::new();
    put_u32(&mut out, LC_LOAD_DYLINKER);
    let cmdsize_offset = out.len();
    put_u32(&mut out, 0); // placeholder for cmdsize
    put_u32(&mut out, 12); // name offset (right after this field)
    out.extend_from_slice(path.as_bytes());
    out.push(0); // NUL terminator
    pad_to(&mut out, 8);
    let cmdsize = out.len() as u32;
    out[cmdsize_offset..cmdsize_offset + 4].copy_from_slice(&cmdsize.to_le_bytes());
    out
}

/// `LC_LOAD_DYLIB` -- declare a dependency on a shared library that
/// dyld must load before our entry point runs.
fn load_dylib(path: &str) -> Vec<u8> {
    let mut out = Vec::new();
    put_u32(&mut out, LC_LOAD_DYLIB);
    let cmdsize_offset = out.len();
    put_u32(&mut out, 0); // placeholder
    put_u32(&mut out, 24); // name offset
    put_u32(&mut out, 0); // timestamp -- ignored
    put_u32(&mut out, 0x0001_0000); // current_version (1.0.0)
    put_u32(&mut out, 0x0001_0000); // compatibility_version (1.0.0)
    out.extend_from_slice(path.as_bytes());
    out.push(0); // NUL
    pad_to(&mut out, 8);
    let cmdsize = out.len() as u32;
    out[cmdsize_offset..cmdsize_offset + 4].copy_from_slice(&cmdsize.to_le_bytes());
    out
}

/// `LC_BUILD_VERSION` -- platform + min OS + SDK. Modern dyld grumbles
/// without it.
fn build_version() -> Vec<u8> {
    let mut out = Vec::with_capacity(24);
    put_u32(&mut out, LC_BUILD_VERSION);
    put_u32(&mut out, 24); // cmdsize -- no tools entries
    put_u32(&mut out, PLATFORM_MACOS);
    put_u32(&mut out, MIN_MACOS);
    put_u32(&mut out, SDK_MACOS);
    put_u32(&mut out, 0); // ntools
    debug_assert_eq!(out.len(), 24);
    out
}

/// `LC_MAIN` -- file offset of the entry point, plus a stack-size
/// hint (zero = use the kernel default).
fn main_command(entry_file_offset: u64) -> Vec<u8> {
    let mut out = Vec::with_capacity(24);
    put_u32(&mut out, LC_MAIN);
    put_u32(&mut out, 24); // cmdsize
    put_u64(&mut out, entry_file_offset);
    put_u64(&mut out, 0); // stacksize (default)
    debug_assert_eq!(out.len(), 24);
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
    let mut out = Vec::with_capacity(48);
    put_u32(&mut out, LC_DYLD_INFO_ONLY);
    put_u32(&mut out, 48);
    put_u32(&mut out, rebase_off);
    put_u32(&mut out, rebase_size);
    put_u32(&mut out, bind_off);
    put_u32(&mut out, bind_size);
    put_u32(&mut out, weak_bind_off);
    put_u32(&mut out, weak_bind_size);
    put_u32(&mut out, lazy_bind_off);
    put_u32(&mut out, lazy_bind_size);
    put_u32(&mut out, export_off);
    put_u32(&mut out, export_size);
    debug_assert_eq!(out.len(), 48);
    out
}

/// `LC_SYMTAB` -- classic symbol table (nlist entries) + string
/// table. Strictly speaking `LC_DYLD_INFO_ONLY` carries enough info
/// for dyld to bind without this, but `otool`, `nm`, debuggers, and
/// `codesign` all expect it.
fn symtab_command(symoff: u32, nsyms: u32, stroff: u32, strsize: u32) -> Vec<u8> {
    let mut out = Vec::with_capacity(24);
    put_u32(&mut out, LC_SYMTAB);
    put_u32(&mut out, 24);
    put_u32(&mut out, symoff);
    put_u32(&mut out, nsyms);
    put_u32(&mut out, stroff);
    put_u32(&mut out, strsize);
    debug_assert_eq!(out.len(), 24);
    out
}

/// `LC_DYSYMTAB` -- partition the symbol table into local / external-
/// defined / undefined ranges and point at the indirect symbol table.
/// We only have undefined imports right now so the only non-zero
/// counts are `nundefsym` and `iundefsym`.
fn dysymtab_command(nundefsym: u32) -> Vec<u8> {
    let mut out = Vec::with_capacity(80);
    put_u32(&mut out, LC_DYSYMTAB);
    put_u32(&mut out, 80);
    // ilocalsym, nlocalsym, iextdefsym, nextdefsym
    for _ in 0..4 {
        put_u32(&mut out, 0);
    }
    put_u32(&mut out, 0); // iundefsym -- undefined start at index 0
    put_u32(&mut out, nundefsym);
    // tocoff, ntoc, modtaboff, nmodtab, extrefsymoff, nextrefsyms,
    // indirectsymoff, nindirectsyms, extreloff, nextrel,
    // locreloff, nlocrel
    for _ in 0..12 {
        put_u32(&mut out, 0);
    }
    debug_assert_eq!(out.len(), 80);
    out
}

// ------------------------------------------------------------------
// __LINKEDIT contents: bind opcodes, nlist entries, string table.
// ------------------------------------------------------------------

/// Bind opcode stream that resolves one libSystem symbol into the
/// pointer slot at `(__DATA, +offset)`. The format is documented in
/// `<mach-o/loader.h>` -- it's a tiny stack machine that dyld walks
/// at load time, so we just emit the moves it needs.
fn bind_opcodes_for_libsystem(symbol: &str, segment: u8, offset: u64) -> Vec<u8> {
    let mut out = Vec::new();
    out.push(BIND_OPCODE_SET_DYLIB_ORDINAL_IMM | (LIBSYSTEM_ORDINAL as u8 & 0x0F));
    out.push(BIND_OPCODE_SET_TYPE_IMM | BIND_TYPE_POINTER);
    out.push(BIND_OPCODE_SET_SYMBOL_TRAILING_FLAGS_IMM); // flags = 0
    out.extend_from_slice(symbol.as_bytes());
    out.push(0); // NUL terminator on symbol name
    out.push(BIND_OPCODE_SET_SEGMENT_AND_OFFSET_ULEB | (segment & 0x0F));
    put_uleb128(&mut out, offset);
    out.push(BIND_OPCODE_DO_BIND);
    out.push(BIND_OPCODE_DONE);
    pad_to(&mut out, 8);
    out
}

/// One `nlist_64` for an undefined external symbol imported from
/// libSystem. `n_strx` is the byte offset of the symbol's name in the
/// string table.
fn nlist_undef_libsystem(n_strx: u32) -> Vec<u8> {
    let mut out = Vec::with_capacity(16);
    put_u32(&mut out, n_strx);
    out.push(N_EXT | N_UNDF);
    out.push(NO_SECT);
    // n_desc: library ordinal in the high 8 bits.
    let desc: u16 = LIBSYSTEM_ORDINAL << 8;
    out.extend_from_slice(&desc.to_le_bytes());
    put_u64(&mut out, 0); // n_value (undefined)
    debug_assert_eq!(out.len(), 16);
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

    // ---- step 1: pick the imported symbol set ----
    //
    // M1.3 only proves that the bind machinery works. We hard-code one
    // import (`_write`) so otool -bind has something to display. M1.7
    // expands this to the full libc surface badc programs use.
    let imports = ["_write"];

    // ---- step 2: build __LINKEDIT contents ----
    //
    // Bind opcodes go first, then the symbol table, then the string
    // table. Each subsection is 8-byte aligned so file offsets stay
    // nice. We need the sizes of all three to size __LINKEDIT, which
    // in turn sizes the LC stream.
    let bind_ops = bind_opcodes_for_libsystem(imports[0], SEG_INDEX_DATA, 0);
    let (strtab, str_indices) = build_strtab(&imports);
    let mut symtab = Vec::with_capacity(16 * imports.len());
    for n_strx in &str_indices {
        symtab.extend_from_slice(&nlist_undef_libsystem(*n_strx));
    }

    // ---- step 3: size the load-command stream ----
    //
    // Most LC sizes are fixed; the variable-length LCs (DYLINKER,
    // DYLIB) are pre-built so we can read their length back.

    let mh_size = 32u64;
    let pagezero_size = 72u64;
    let text_seg_size = 72u64 + 80;
    let data_seg_size = 72u64 + 80;
    let linkedit_seg_size = 72u64;
    let dyld_info_size = 48u64;
    let symtab_size = 24u64;
    let dysymtab_size = 80u64;
    let main_size = 24u64;

    let dylinker = load_dylinker("/usr/lib/dyld");
    let dylib_libsystem = load_dylib("/usr/lib/libSystem.B.dylib");
    let bv = build_version();

    let sizeofcmds = pagezero_size
        + text_seg_size
        + data_seg_size
        + linkedit_seg_size
        + dyld_info_size
        + symtab_size
        + dysymtab_size
        + dylinker.len() as u64
        + dylib_libsystem.len() as u64
        + bv.len() as u64
        + main_size;

    // ---- step 4: figure out file/vmaddr layout ----

    let header_plus_lcs = mh_size + sizeofcmds;
    let entry_file_offset = header_plus_lcs;
    let code_size = code.len() as u64;
    let text_filesize = round_up(header_plus_lcs + code_size, PAGE_SIZE);
    let text_vmsize = text_filesize;

    // __DATA: one page right after __TEXT, with __got at offset 0.
    // The got_size only counts the bytes dyld will actually write
    // into; the rest of the page is padding. dyld doesn't care.
    let data_fileoff = text_filesize;
    let data_filesize = PAGE_SIZE;
    let data_vmaddr = TEXT_VMADDR_BASE + text_vmsize;
    let data_vmsize = PAGE_SIZE;
    let got_size = (imports.len() * 8) as u64;

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
        data_vmaddr,
        got_size,
        data_fileoff as u32,
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
        imports.len() as u32,
        stroff as u32,
        strtab.len() as u32,
    );
    let dysymtab_lc = dysymtab_command(imports.len() as u32);
    let main_lc = main_command(entry_file_offset);

    debug_assert_eq!(text_segment.len() as u64, text_seg_size);
    debug_assert_eq!(data_segment.len() as u64, data_seg_size);
    debug_assert_eq!(linkedit.len() as u64, linkedit_seg_size);
    debug_assert_eq!(main_lc.len() as u64, main_size);

    // ---- step 6: emit ----

    let total_filesize = linkedit_fileoff + linkedit_filesize;
    let mut out = Vec::with_capacity(total_filesize as usize);

    // mach_header_64. We have undefined symbols now (_write); MH_NOUNDEFS
    // is dropped accordingly.
    put_u32(&mut out, MH_MAGIC_64);
    put_u32(&mut out, CPU_TYPE_ARM64);
    put_u32(&mut out, CPU_SUBTYPE_ARM64_ALL);
    put_u32(&mut out, MH_EXECUTE);
    put_u32(&mut out, 11); // ncmds (4 segments + dyldinfo + symtab + dysymtab + dylinker + dylib + bv + main)
    put_u32(&mut out, sizeofcmds as u32);
    put_u32(&mut out, MH_DYLDLINK | MH_TWOLEVEL | MH_PIE);
    put_u32(&mut out, 0); // reserved
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
    out.extend_from_slice(&dylib_libsystem);
    out.extend_from_slice(&bv);
    out.extend_from_slice(&main_lc);

    debug_assert_eq!(out.len() as u64, header_plus_lcs);

    // __TEXT: code, then page-pad.
    out.extend_from_slice(code);
    while (out.len() as u64) < text_filesize {
        out.push(0);
    }

    // __DATA: a full page of zero bytes. dyld writes the GOT entries
    // at load time using the bind opcodes from __LINKEDIT.
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
    fn tiny_build() -> Build {
        Build {
            // movz x0, #42 ; ret
            text: vec![0x40, 0x05, 0x80, 0xD2, 0xC0, 0x03, 0x5F, 0xD6],
            data: Vec::new(),
            entry_offset: 0,
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
    fn ncmds_grew_to_eleven() {
        let bytes = write(&tiny_build()).unwrap();
        assert_eq!(read_u32(&bytes, 16), 11);
    }

    #[test]
    fn sizeofcmds_matches_distance_to_first_byte_after_lcs() {
        let bytes = write(&tiny_build()).unwrap();
        let sizeofcmds = read_u32(&bytes, 20);
        // The byte at file offset (32 + sizeofcmds) is where the code
        // starts; the first instruction we emitted was 0x40 (the low
        // byte of `movz x0, #42`).
        let code_start = 32 + sizeofcmds as usize;
        assert_eq!(bytes[code_start], 0x40);
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
                // And `_write` should appear right after it.
                assert_eq!(
                    &bytes[stroff + 1..stroff + 7],
                    b"_write",
                    "expected symbol name immediately after leading NUL"
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
