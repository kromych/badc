//! Mach-O (64-bit) writer for arm64 executables.
//!
//! Mach-O is a fixed `mach_header_64` followed by a sequence of "load
//! commands". Each load command tells dyld to do something on launch:
//! map a segment, load a shared library, set the entry point, and so
//! on. The header carries the total size of the command stream so dyld
//! knows where the segment data starts.
//!
//! We hand-roll all of it. The format is well-documented in
//! `<mach-o/loader.h>` and Apple's open-source `dyld`, and a hand-rolled
//! writer keeps us free of any binary-writer dependency.
//!
//! ## Layout we emit (M1.2)
//!
//! ```text
//!   file offset                                         segment / contents
//!   --------------------------------------------------------------------
//!   0x0000   mach_header_64                             ┐
//!            LC_SEGMENT_64 __PAGEZERO                   │
//!            LC_SEGMENT_64 __TEXT (one section: __text) │ __TEXT
//!            LC_SEGMENT_64 __LINKEDIT                   │
//!            LC_LOAD_DYLINKER /usr/lib/dyld             │
//!            LC_LOAD_DYLIB   /usr/lib/libSystem.B.dylib │
//!            LC_BUILD_VERSION                           │
//!            LC_MAIN entry_off=...                      │
//!            <padding to align to code start>           │
//!            <machine code from build.text>             │
//!            <padding to 16 KiB page boundary>          ┘
//!   0x4000   <empty __LINKEDIT placeholder, M1.3 fills>
//! ```
//!
//! __PAGEZERO is an unmapped 4 GiB segment at vmaddr 0 -- the standard
//! null-pointer-deref catcher. __TEXT carries the header plus the code
//! itself. __LINKEDIT is a trailing scratch segment that holds dynamic-
//! linking metadata (binds, strings, symbol tables); empty in M1.2,
//! populated in M1.3+.
//!
//! Apple Silicon mandates 16 KiB pages for arm64 (`vm_page_size`).
//!
//! ## What dyld checks at load time
//!
//! Plenty -- but only some of it bites in M1.2:
//! * Magic / cpu type / file type must match.
//! * `MH_PIE` must be set (modern macOS rejects non-PIE executables).
//! * Segment file ranges must fit inside the file.
//! * `LC_MAIN` entry must land inside an executable segment.
//! * The binary must be code-signed -- but that's wired in M1.3+M1.4
//!   via shelling out to `codesign --sign -`. M1.2 produces a binary
//!   that `otool -h` can parse but that won't yet `exec()`.

use alloc::format;
use alloc::vec::Vec;

use super::super::error::C4Error;
use super::Build;

// ------------------------------------------------------------------
// Mach-O constants. Names mirror `<mach-o/loader.h>` so cross-checking
// against system headers is mechanical.
// ------------------------------------------------------------------

const MH_MAGIC_64: u32 = 0xFEED_FACF;

const CPU_TYPE_ARM64: u32 = 0x0100_000C; // CPU_ARCH_ABI64 | CPU_TYPE_ARM
const CPU_SUBTYPE_ARM64_ALL: u32 = 0;

const MH_EXECUTE: u32 = 0x2;

const MH_NOUNDEFS: u32 = 0x1;
const MH_DYLDLINK: u32 = 0x4;
const MH_TWOLEVEL: u32 = 0x80;
const MH_PIE: u32 = 0x0020_0000;

const LC_REQ_DYLD: u32 = 0x8000_0000;
const LC_SEGMENT_64: u32 = 0x19;
const LC_LOAD_DYLINKER: u32 = 0xE;
const LC_LOAD_DYLIB: u32 = 0xC;
const LC_MAIN: u32 = 0x28 | LC_REQ_DYLD;
const LC_BUILD_VERSION: u32 = 0x32;

const VM_PROT_READ: u32 = 1;
#[allow(dead_code)] // wired in when __DATA segment lands in M1.6+
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

// ------------------------------------------------------------------
// Tiny serialization helpers. Mach-O is little-endian on every cpu we
// target; the macros below funnel through to_le_bytes so a future
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

// ------------------------------------------------------------------
// Top-level writer. Two passes: size the load commands first (we need
// the total size in the header AND the file offset of the code, which
// lives just after the load commands), then materialise the bytes.
// ------------------------------------------------------------------

pub(super) fn write(build: &Build) -> Result<Vec<u8>, C4Error> {
    let code = &build.text;

    // ---- pass 1: size the load commands ----
    //
    // We need to know `sizeofcmds` before we can place the code in the
    // file (the code starts immediately after the LC stream), and the
    // segment metadata in turn needs to know the code's file offset.
    // So: build each LC to a Vec, sum the lengths, then emit.

    let mh_size = 32u64;
    let pagezero = segment_no_sections("__PAGEZERO", 0, PAGEZERO_VMSIZE, 0, 0, 0, 0);
    let dylinker = load_dylinker("/usr/lib/dyld");
    let dylib_libsystem = load_dylib("/usr/lib/libSystem.B.dylib");
    let bv = build_version();

    // The __TEXT and LC_MAIN sizes depend on the code's offset, which
    // depends on the size of the LC stream. To break the loop we
    // hardcode the sizes here -- they're all fixed for our M1.2 layout.
    let text_seg_size = 72u64 + 80; // segment header + one section
    let linkedit_seg_size = 72u64;
    let main_size = 24u64;

    let sizeofcmds = pagezero.len() as u64
        + text_seg_size
        + linkedit_seg_size
        + dylinker.len() as u64
        + dylib_libsystem.len() as u64
        + bv.len() as u64
        + main_size;

    let header_plus_lcs = mh_size + sizeofcmds;
    let entry_file_offset = header_plus_lcs;
    let code_size = code.len() as u64;
    let text_filesize = round_up(header_plus_lcs + code_size, PAGE_SIZE);
    let text_vmsize = text_filesize;

    let linkedit_fileoff = text_filesize;
    let linkedit_filesize = 0u64; // M1.3 will populate
    let linkedit_vmaddr = TEXT_VMADDR_BASE + text_vmsize;
    let linkedit_vmsize = PAGE_SIZE; // dyld wants at least one page

    let text_segment = segment_text(
        TEXT_VMADDR_BASE,
        text_vmsize,
        0,
        text_filesize,
        TEXT_VMADDR_BASE + entry_file_offset,
        code_size,
        entry_file_offset as u32,
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
    let main_lc = main_command(entry_file_offset);

    debug_assert_eq!(text_segment.len() as u64, text_seg_size);
    debug_assert_eq!(linkedit.len() as u64, linkedit_seg_size);
    debug_assert_eq!(main_lc.len() as u64, main_size);

    // ---- pass 2: emit ----

    let mut out = Vec::with_capacity(text_filesize as usize);

    // mach_header_64
    put_u32(&mut out, MH_MAGIC_64);
    put_u32(&mut out, CPU_TYPE_ARM64);
    put_u32(&mut out, CPU_SUBTYPE_ARM64_ALL);
    put_u32(&mut out, MH_EXECUTE);
    put_u32(&mut out, 7); // ncmds: pagezero, text, linkedit, dylinker, dylib, bv, main
    put_u32(&mut out, sizeofcmds as u32);
    put_u32(&mut out, MH_NOUNDEFS | MH_DYLDLINK | MH_TWOLEVEL | MH_PIE);
    put_u32(&mut out, 0); // reserved
    debug_assert_eq!(out.len() as u64, mh_size);

    // Load commands -- order matters for some tools but not dyld.
    out.extend_from_slice(&pagezero);
    out.extend_from_slice(&text_segment);
    out.extend_from_slice(&linkedit);
    out.extend_from_slice(&dylinker);
    out.extend_from_slice(&dylib_libsystem);
    out.extend_from_slice(&bv);
    out.extend_from_slice(&main_lc);

    debug_assert_eq!(out.len() as u64, header_plus_lcs);

    // Code, then page-pad.
    out.extend_from_slice(code);
    while (out.len() as u64) < text_filesize {
        out.push(0);
    }

    // __LINKEDIT is empty in M1.2 -- no bytes appended.
    debug_assert_eq!(out.len() as u64, text_filesize);

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
    //! end-to-end "does it run" check happens after M1.4 lands codesign
    //! + a real entry point; M1.2 just makes sure the bytes parse.

    use super::*;

    /// Smallest possible Build -- one instruction, marked as the entry.
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
    fn ncmds_matches_emitted_lc_count() {
        let bytes = write(&tiny_build()).unwrap();
        // 7 LCs in the M1.2 layout: pagezero, text, linkedit, dylinker,
        // dylib, build_version, main.
        assert_eq!(read_u32(&bytes, 16), 7);
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
    fn lc_main_entry_points_at_code() {
        let bytes = write(&tiny_build()).unwrap();
        let sizeofcmds = read_u32(&bytes, 20) as usize;
        // LC_MAIN is the last LC in our layout, so its entryoff field
        // sits 16 bytes before the end of the LC stream (cmd 4 + size
        // 4 + entryoff 8).
        let lc_main_start = 32 + sizeofcmds - 24;
        let cmd = read_u32(&bytes, lc_main_start);
        assert_eq!(cmd, LC_MAIN);
        let entryoff = u64::from_le_bytes(
            bytes[lc_main_start + 8..lc_main_start + 16]
                .try_into()
                .unwrap(),
        );
        assert_eq!(entryoff, 32 + sizeofcmds as u64);
    }

    #[test]
    fn output_is_page_aligned() {
        let bytes = write(&tiny_build()).unwrap();
        assert_eq!(bytes.len() as u64 % PAGE_SIZE, 0);
    }

    /// Round-trip through `otool -h` on the host. Confirms the bytes
    /// are valid enough that Apple's own parser is happy with the
    /// header. Doesn't try to launch the binary -- that's M1.4.
    #[cfg(target_os = "macos")]
    #[test]
    fn otool_h_parses_the_image() {
        use std::io::Write;
        use std::process::Command;
        let bytes = write(&tiny_build()).unwrap();
        let path = std::env::temp_dir().join("badc-m1-2-smoke.bin");
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
        assert!(
            stdout.contains("MH_MAGIC_64"),
            "otool didn't see MH_MAGIC_64; got:\n{stdout}"
        );
        assert!(
            stdout.contains("ARM64"),
            "otool didn't see ARM64; got:\n{stdout}"
        );
        assert!(
            stdout.contains("EXECUTE"),
            "otool didn't see EXECUTE; got:\n{stdout}"
        );
    }
}
