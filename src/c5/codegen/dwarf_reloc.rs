//! Relocatable DWARF emitter for `OutputKind::Relocatable` output.
//!
//! Produces a minimal but standards-compliant slice of DWARF 4
//! sections suitable for placement in an ELF ET_REL object:
//!
//!   * `.debug_info`   -- one compilation-unit DIE per `.o`.
//!   * `.debug_abbrev` -- the matching abbreviation table.
//!   * `.debug_line`   -- one line-number program covering the unit's
//!                        `.text`.
//!
//! Every address slot is emitted as a placeholder paired with an
//! [`DwarfReloc`] record so the linker can rebase the section once
//! the per-unit `.text` / `.debug_line` / `.debug_abbrev` bases are
//! known. This is the standard ELF DWARF emission shape (matching
//! gcc / clang `-c -g` output for c5's subset).
//!
//! Subprogram DIEs, type DIEs, variable / parameter locations and
//! `.debug_frame` are deliberately out of scope for the relocatable
//! path -- lldb / gdb resolve function names through the static
//! symbol table, and the line program is enough to drive source
//! display at breakpoints. The richer DIE tree the amalg path
//! emits remains available there; it can be added to the
//! relocatable path under the same reloc machinery in a follow-up.

#![allow(dead_code)]

use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use super::super::program::Program;
use super::Build;

/// Section that an emitted reloc lives in. Used to route the
/// reloc into the matching `.rela.<section>` table in the ELF
/// writer.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum DwarfSectionKind {
    Info,
    Line,
}

/// Section symbol the reloc resolves against. The linker
/// translates this into the section's runtime base; the addend
/// the reloc carries is added on top.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum DwarfRelocTarget {
    Text,
    DebugLine,
    DebugAbbrev,
}

/// Width of the reloc's value field. Maps to R_*_64 / R_*_32 in
/// the ELF reloc table.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum DwarfRelocWidth {
    W4,
    W8,
}

/// One placeholder slot the linker has to patch once the merged
/// section bases are known.
#[derive(Debug, Clone)]
pub(crate) struct DwarfReloc {
    pub section: DwarfSectionKind,
    /// Byte offset of the slot within its section.
    pub offset: u64,
    pub width: DwarfRelocWidth,
    pub target: DwarfRelocTarget,
    /// Pre-relocation value of the slot. The linker computes the
    /// final value as `section_base(target) + addend`.
    pub addend: i64,
}

/// Output of [`emit`]: the DWARF byte streams plus the relocs
/// that describe every placeholder address slot inside them.
pub(crate) struct DwarfRelocatable {
    pub debug_info: Vec<u8>,
    pub debug_abbrev: Vec<u8>,
    pub debug_line: Vec<u8>,
    pub info_relocs: Vec<DwarfReloc>,
    pub line_relocs: Vec<DwarfReloc>,
}

const DW_TAG_COMPILE_UNIT: u8 = 0x11;

const DW_AT_NAME: u8 = 0x03;
const DW_AT_STMT_LIST: u8 = 0x10;
const DW_AT_LOW_PC: u8 = 0x11;
const DW_AT_HIGH_PC: u8 = 0x12;
const DW_AT_LANGUAGE: u8 = 0x13;
const DW_AT_COMP_DIR: u8 = 0x1b;
const DW_AT_PRODUCER: u8 = 0x25;

const DW_FORM_ADDR: u8 = 0x01;
const DW_FORM_DATA8: u8 = 0x07;
const DW_FORM_STRING: u8 = 0x08;
const DW_FORM_DATA1: u8 = 0x0b;
const DW_FORM_SEC_OFFSET: u8 = 0x17;

const DW_CHILDREN_NO: u8 = 0x00;

const DW_LANG_C99: u8 = 0x0c;

const DW_LNS_COPY: u8 = 0x01;
const DW_LNS_ADVANCE_PC: u8 = 0x02;
const DW_LNS_ADVANCE_LINE: u8 = 0x03;
const DW_LNS_SET_FILE: u8 = 0x04;
const DW_LNE_END_SEQUENCE: u8 = 0x01;
const DW_LNE_SET_ADDRESS: u8 = 0x02;

const LINE_BASE: i8 = -1;
const LINE_RANGE: u8 = 14;
const OPCODE_BASE: u8 = 13;

const ABBREV_CU: u64 = 1;

/// Emit the relocatable DWARF triple plus the address-reloc list.
/// `source_path` becomes the CU's `DW_AT_name`; the line table's
/// file numbering reuses [`Program::source_files`].
pub(crate) fn emit(program: &Program, build: &Build, source_path: &str) -> DwarfRelocatable {
    let debug_abbrev = build_debug_abbrev();
    let (debug_line, line_relocs) = build_debug_line(program, build);
    let text_size = build.text.len() as u64;
    let (debug_info, info_relocs) = build_debug_info(source_path, text_size);
    DwarfRelocatable {
        debug_info,
        debug_abbrev,
        debug_line,
        info_relocs,
        line_relocs,
    }
}

// ---- .debug_abbrev ----

fn build_debug_abbrev() -> Vec<u8> {
    // One abbrev entry describing a leaf compile_unit DIE.
    let mut out = Vec::new();
    write_uleb128(&mut out, ABBREV_CU);
    out.push(DW_TAG_COMPILE_UNIT);
    out.push(DW_CHILDREN_NO);
    push_attr(&mut out, DW_AT_PRODUCER, DW_FORM_STRING);
    push_attr(&mut out, DW_AT_LANGUAGE, DW_FORM_DATA1);
    push_attr(&mut out, DW_AT_NAME, DW_FORM_STRING);
    push_attr(&mut out, DW_AT_COMP_DIR, DW_FORM_STRING);
    push_attr(&mut out, DW_AT_LOW_PC, DW_FORM_ADDR);
    push_attr(&mut out, DW_AT_HIGH_PC, DW_FORM_DATA8);
    push_attr(&mut out, DW_AT_STMT_LIST, DW_FORM_SEC_OFFSET);
    // Terminator: two zero ULEB128s.
    out.push(0);
    out.push(0);
    // End of abbrev table.
    out.push(0);
    out
}

fn push_attr(out: &mut Vec<u8>, name: u8, form: u8) {
    write_uleb128(out, name as u64);
    write_uleb128(out, form as u64);
}

// ---- .debug_info ----

fn build_debug_info(source_path: &str, text_size: u64) -> (Vec<u8>, Vec<DwarfReloc>) {
    let mut body: Vec<u8> = Vec::new();
    let mut relocs: Vec<DwarfReloc> = Vec::new();

    // Body content first; the unit header's `unit_length` field
    // covers everything after itself, which the prefix below
    // backfills once the body is sized.
    write_uleb128(&mut body, ABBREV_CU);
    push_string(&mut body, &format!("badc {}", env!("CARGO_PKG_VERSION")));
    body.push(DW_LANG_C99);
    push_string(&mut body, source_path);
    push_string(&mut body, ""); // DW_AT_comp_dir
    // DW_AT_low_pc -- 8-byte placeholder, reloc against .text.
    // Section offset = (unit header length) + body so far. The
    // header is 4 (unit_length) + 2 (version) + 4 (abbrev_off) +
    // 1 (addr_size) = 11 bytes.
    let header_size: u64 = 11;
    let low_pc_off_in_body = body.len() as u64;
    body.extend_from_slice(&[0u8; 8]);
    relocs.push(DwarfReloc {
        section: DwarfSectionKind::Info,
        offset: header_size + low_pc_off_in_body,
        width: DwarfRelocWidth::W8,
        target: DwarfRelocTarget::Text,
        addend: 0,
    });
    // DW_AT_high_pc as DATA8 (size in bytes from low_pc). No reloc
    // needed; the linker keeps low_pc + size pointing at the same
    // span because the per-unit `.text` slice is contiguous.
    body.extend_from_slice(&text_size.to_le_bytes());
    // DW_AT_stmt_list -- 4-byte section offset into .debug_line.
    // Each `.o` has exactly one CU and its line program lands at
    // offset 0 inside `.debug_line`; the linker rebases the slot
    // when concatenating per-unit `.debug_line` blobs.
    let stmt_list_off_in_body = body.len() as u64;
    body.extend_from_slice(&[0u8; 4]);
    relocs.push(DwarfReloc {
        section: DwarfSectionKind::Info,
        offset: header_size + stmt_list_off_in_body,
        width: DwarfRelocWidth::W4,
        target: DwarfRelocTarget::DebugLine,
        addend: 0,
    });

    // Final null DIE -- terminates the CU's child list (we emit
    // no children; the abbrev's `DW_CHILDREN_NO` is what
    // documents that, but DWARF still tolerates a closing null).
    body.push(0);

    // Unit header. `unit_length` covers everything after itself:
    // version(2) + debug_abbrev_offset(4) + address_size(1) + body.
    let unit_length: u32 = (2 + 4 + 1 + body.len()) as u32;
    let mut out: Vec<u8> = Vec::with_capacity(4 + unit_length as usize);
    out.extend_from_slice(&unit_length.to_le_bytes());
    out.extend_from_slice(&4u16.to_le_bytes()); // version
    // debug_abbrev_offset -- 4-byte placeholder, reloc against
    // .debug_abbrev (each `.o`'s abbrev table starts at offset 0).
    let abbrev_off_pos = out.len() as u64;
    out.extend_from_slice(&[0u8; 4]);
    relocs.push(DwarfReloc {
        section: DwarfSectionKind::Info,
        offset: abbrev_off_pos,
        width: DwarfRelocWidth::W4,
        target: DwarfRelocTarget::DebugAbbrev,
        addend: 0,
    });
    out.push(8); // address_size
    out.extend_from_slice(&body);

    (out, relocs)
}

// ---- .debug_line ----

fn build_debug_line(program: &Program, build: &Build) -> (Vec<u8>, Vec<DwarfReloc>) {
    // File table: DWARF 4 uses 1-based file indices. The CU's
    // primary file is index 1; every other entry the lexer
    // recorded follows. The `<source>` placeholder is the lexer's
    // pre-marker default and gets folded into entry 1.
    let mut hdr: Vec<u8> = Vec::new();
    // Header byte budget (post-length): version(2) + header_length(4)
    // + minimum_instruction_length(1) + maximum_operations_per_instruction(1)
    // + default_is_stmt(1) + line_base(1) + line_range(1) +
    // opcode_base(1) + standard_opcode_lengths(opcode_base-1) +
    // include_directories(null) + file_names(...) + terminator.
    hdr.push(1); // minimum_instruction_length
    hdr.push(1); // maximum_operations_per_instruction
    hdr.push(1); // default_is_stmt
    hdr.push(LINE_BASE as u8);
    hdr.push(LINE_RANGE);
    hdr.push(OPCODE_BASE);
    for &n in &[0u8, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 1] {
        hdr.push(n);
    }
    hdr.push(0); // include_directories terminator
    push_file_entry(&mut hdr, default_file_name(program));
    let mut next_dwarf_idx: u64 = 2;
    let mut dwarf_file_for_lex_idx: Vec<u64> = Vec::with_capacity(program.source_files.len());
    for src in &program.source_files {
        if src == "<source>" {
            dwarf_file_for_lex_idx.push(1);
            continue;
        }
        push_file_entry(&mut hdr, src);
        dwarf_file_for_lex_idx.push(next_dwarf_idx);
        next_dwarf_idx += 1;
    }
    hdr.push(0); // file_names terminator

    // Program body. Reloc offsets are recorded against the byte
    // position within the final output (`prefix + body`), so the
    // header-prefix length has to be known to convert body-local
    // offsets to section-local ones.
    let header_length: u32 = hdr.len() as u32;
    // unit_length covers everything after itself:
    // version(2) + header_length(4) + header_length bytes + prog.
    let prefix_size: u64 = 4 + 2 + 4 + header_length as u64;

    let mut prog: Vec<u8> = Vec::new();
    let mut relocs: Vec<DwarfReloc> = Vec::new();

    // Anchor address at 0 (codegen-relative); the linker rebases
    // through the recorded reloc.
    write_set_address_reloc(&mut prog, &mut relocs, prefix_size, 0);

    let mut state_addr: u64 = 0;
    let mut state_line: i64 = 1;
    let mut state_file: u64 = 1;

    let mut func_starts: Vec<usize> = build
        .func_ent_pcs
        .iter()
        .filter_map(|&pc| build.pc_to_native.get(pc).copied())
        .filter(|&n| n != usize::MAX)
        .collect();
    func_starts.sort_unstable();
    func_starts.dedup();
    let mut func_start_iter = func_starts.iter().copied().peekable();
    let mut row_emitted_at_state = false;

    for &(native, line, file_idx) in &build.ssa_line_rows {
        if line == 0 {
            continue;
        }
        let file = dwarf_file_for_lex_idx
            .get(file_idx as usize)
            .copied()
            .unwrap_or(1);
        let target_addr = native as u64;
        while let Some(&fn_start) = func_start_iter.peek() {
            let entry_addr = fn_start as u64;
            if entry_addr > target_addr {
                break;
            }
            emit_row(
                &mut prog,
                &mut state_addr,
                &mut state_line,
                &mut state_file,
                &mut row_emitted_at_state,
                entry_addr,
                line as i64,
                file,
            );
            func_start_iter.next();
        }
        emit_row(
            &mut prog,
            &mut state_addr,
            &mut state_line,
            &mut state_file,
            &mut row_emitted_at_state,
            target_addr,
            line as i64,
            file,
        );
    }

    // Close the sequence at one past the last byte of `.text`.
    let end_addr = build.text.len() as u64;
    if end_addr > state_addr {
        advance_pc(&mut prog, end_addr - state_addr);
    }
    write_extended(&mut prog, DW_LNE_END_SEQUENCE, &[]);

    // Stitch: 4-byte unit_length + 2-byte version + 4-byte
    // header_length + header bytes + program bytes.
    let unit_length: u32 = (2 + 4 + hdr.len() + prog.len()) as u32;
    let mut out: Vec<u8> = Vec::with_capacity(4 + unit_length as usize);
    out.extend_from_slice(&unit_length.to_le_bytes());
    out.extend_from_slice(&4u16.to_le_bytes()); // version
    out.extend_from_slice(&header_length.to_le_bytes());
    out.extend_from_slice(&hdr);
    out.extend_from_slice(&prog);

    (out, relocs)
}

fn default_file_name(program: &Program) -> &str {
    if program.source_path.is_empty() {
        "<unknown>"
    } else {
        program.source_path.as_str()
    }
}

fn push_file_entry(out: &mut Vec<u8>, name: &str) {
    out.extend_from_slice(name.as_bytes());
    out.push(0);
    write_uleb128(out, 0); // dir_idx
    write_uleb128(out, 0); // mtime
    write_uleb128(out, 0); // file size
}

fn write_set_address_reloc(
    prog: &mut Vec<u8>,
    relocs: &mut Vec<DwarfReloc>,
    prefix_size: u64,
    addend: i64,
) {
    // Extended opcode: 0x00, ULEB128 length (1 + addr_size = 9), opcode (DW_LNE_SET_ADDRESS), addr.
    prog.push(0);
    write_uleb128(prog, 9);
    prog.push(DW_LNE_SET_ADDRESS);
    let addr_pos_in_prog = prog.len() as u64;
    prog.extend_from_slice(&[0u8; 8]);
    relocs.push(DwarfReloc {
        section: DwarfSectionKind::Line,
        // The body starts at `prefix_size` bytes from the section
        // start; the addr field sits at `addr_pos_in_prog` within
        // the body.
        offset: prefix_size + addr_pos_in_prog,
        width: DwarfRelocWidth::W8,
        target: DwarfRelocTarget::Text,
        addend,
    });
}

#[allow(clippy::too_many_arguments)]
fn emit_row(
    buf: &mut Vec<u8>,
    state_addr: &mut u64,
    state_line: &mut i64,
    state_file: &mut u64,
    row_emitted: &mut bool,
    target_addr: u64,
    line: i64,
    file: u64,
) {
    if target_addr > *state_addr {
        advance_pc(buf, target_addr - *state_addr);
        *state_addr = target_addr;
        *row_emitted = false;
    }
    if file != *state_file {
        buf.push(DW_LNS_SET_FILE);
        write_uleb128(buf, file);
        *state_file = file;
        *row_emitted = false;
    }
    if line != *state_line {
        advance_line(buf, line - *state_line);
        *state_line = line;
        *row_emitted = false;
    }
    if !*row_emitted {
        buf.push(DW_LNS_COPY);
        *row_emitted = true;
    }
}

fn advance_pc(buf: &mut Vec<u8>, delta: u64) {
    buf.push(DW_LNS_ADVANCE_PC);
    write_uleb128(buf, delta);
}

fn advance_line(buf: &mut Vec<u8>, delta: i64) {
    buf.push(DW_LNS_ADVANCE_LINE);
    write_sleb128(buf, delta);
}

fn write_extended(buf: &mut Vec<u8>, opcode: u8, operand: &[u8]) {
    buf.push(0);
    write_uleb128(buf, (operand.len() + 1) as u64);
    buf.push(opcode);
    buf.extend_from_slice(operand);
}

fn push_string(out: &mut Vec<u8>, s: &str) {
    out.extend_from_slice(s.as_bytes());
    out.push(0);
}

fn write_uleb128(out: &mut Vec<u8>, mut value: u64) {
    loop {
        let byte = (value & 0x7f) as u8;
        value >>= 7;
        if value == 0 {
            out.push(byte);
            return;
        }
        out.push(byte | 0x80);
    }
}

fn write_sleb128(out: &mut Vec<u8>, mut value: i64) {
    loop {
        let byte = (value & 0x7f) as u8;
        let sign_bit = byte & 0x40;
        value >>= 7;
        let done = (value == 0 && sign_bit == 0) || (value == -1 && sign_bit != 0);
        if done {
            out.push(byte);
            return;
        }
        out.push(byte | 0x80);
    }
}

/// Wide-format string for callers needing a writable view of
/// `source_path`. Keeps the lifetime away from the call sites
/// that mutate `program`.
#[allow(dead_code)]
pub(crate) fn source_path_or_default(p: &Program) -> String {
    if p.source_path.is_empty() {
        String::from("<unknown>")
    } else {
        p.source_path.clone()
    }
}
