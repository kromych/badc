//! Phase 1 DWARF emitter (gh #39 / gh #40 / gh #41 / gh #42).
//!
//! Produces four byte vectors that the per-target writers can drop
//! into their container's debug-section equivalents:
//!
//! * `.debug_str` -- deduplicated null-terminated strings
//!   (function names + the source filename).
//! * `.debug_abbrev` -- two abbreviation entries: one for the
//!   compilation-unit DIE, one for each subprogram DIE.
//! * `.debug_info` -- a single CU DIE with one subprogram-DIE
//!   child per c5 user function. No types, no locals, no inlined
//!   subroutines. That's enough for `lldb` / `gdb` to resolve
//!   function names in backtraces, accept breakpoints by name,
//!   and -- the part that unblocks gh #30 -- install hardware
//!   watchpoints.
//! * `.debug_line` -- a line-number program mapping every emitted
//!   native byte range to the C source line that produced it.
//!   Read from `program.source_lines`, which the optimizer
//!   preserves through PC remapping.
//!
//! Format choice: DWARF version 4, 32-bit DWARF (4-byte length
//! prefixes), little-endian, 8-byte addresses. DWARF 4 because
//! every consumer we care about handles it without surprises;
//! DWARF 5 adds split-unit / `.debug_loclists` machinery we
//! don't need yet.
//!
//! Phase 2 work (separate issues) extends with `.debug_frame` /
//! `__eh_frame` (call-stack unwinding without prologue heuristics),
//! type DIEs, variable DIEs, and inlined-subroutine DIEs.

use alloc::format;
use alloc::vec::Vec;

use super::Build;
use crate::c5::op::Op;
use crate::c5::program::Program;

// ---- DWARF spec constants we use ----
//
// Names mirror the DWARF 4 standard's `DW_*` identifiers so
// readers cross-referencing the spec or another emitter can
// match them at a glance.

const DW_TAG_COMPILE_UNIT: u8 = 0x11;
const DW_TAG_SUBPROGRAM: u8 = 0x2e;
const DW_TAG_BASE_TYPE: u8 = 0x24;
const DW_TAG_FORMAL_PARAMETER: u8 = 0x05;
const DW_TAG_VARIABLE: u32 = 0x34;

const DW_CHILDREN_NO: u8 = 0x00;
const DW_CHILDREN_YES: u8 = 0x01;

const DW_AT_NAME: u32 = 0x03;
const DW_AT_STMT_LIST: u32 = 0x10;
const DW_AT_LOW_PC: u32 = 0x11;
const DW_AT_HIGH_PC: u32 = 0x12;
const DW_AT_LANGUAGE: u32 = 0x13;
const DW_AT_COMP_DIR: u32 = 0x1b;
const DW_AT_EXTERNAL: u32 = 0x3f;
const DW_AT_PRODUCER: u32 = 0x25;
const DW_AT_BYTE_SIZE: u32 = 0x0b;
const DW_AT_ENCODING: u32 = 0x3e;
const DW_AT_TYPE: u32 = 0x49;
const DW_AT_LOCATION: u32 = 0x02;
const DW_AT_FRAME_BASE: u32 = 0x40;

// DW_ATE_* encodings for DW_TAG_base_type DW_AT_encoding.
const DW_ATE_SIGNED: u8 = 0x05;
const DW_ATE_ADDRESS: u8 = 0x01;

const DW_FORM_ADDR: u32 = 0x01;
const DW_FORM_DATA1: u32 = 0x0b;
const DW_FORM_DATA8: u32 = 0x07;
const DW_FORM_STRP: u32 = 0x0e;
const DW_FORM_FLAG_PRESENT: u32 = 0x19;
const DW_FORM_SEC_OFFSET: u32 = 0x17;
const DW_FORM_REF4: u32 = 0x13;
const DW_FORM_EXPRLOC: u32 = 0x18;

// DW_OP_* opcodes used in location / frame-base expressions.
const DW_OP_FBREG: u8 = 0x91;
/// `DW_OP_breg29 <sleb128>` (= 0x70 + 29) -- "frame base is the
/// value of register x29 plus N". Used in DW_AT_frame_base so
/// `DW_OP_fbreg` location expressions resolve against $x29.
/// `DW_OP_reg29` (0x6d) is "the variable IS in register x29",
/// which lldb interprets differently from "the frame base is
/// stored at x29's address" -- breg gets the right semantics
/// for c5's stack-frame layout.
const DW_OP_BREG29: u8 = 0x8d;

const DW_LANG_C99: u8 = 0x0c;

// Standard line-program opcodes we emit.
const DW_LNS_COPY: u8 = 0x01;
const DW_LNS_ADVANCE_PC: u8 = 0x02;
const DW_LNS_ADVANCE_LINE: u8 = 0x03;

// Extended-opcode prefix is `0x00`; the byte after the length
// names the extended op.
const DW_LNE_END_SEQUENCE: u8 = 0x01;
const DW_LNE_SET_ADDRESS: u8 = 0x02;

// ---- Emitter entry point ----

/// The four byte vectors phase 1 produces. Per-target writers
/// (Mach-O / ELF / PE) wrap these into their format-specific
/// debug-section containers.
pub(crate) struct DwarfSections {
    pub debug_info: Vec<u8>,
    pub debug_abbrev: Vec<u8>,
    pub debug_line: Vec<u8>,
    pub debug_str: Vec<u8>,
}

/// Produce DWARF for `program` / `build`.
///
/// `code_vmaddr` is the runtime virtual address that
/// `Build::text[0]` will load at; we add it to every
/// codegen-relative offset before writing it as a DWARF
/// `DW_FORM_addr`. `source_path` becomes the CU's
/// `DW_AT_name` and the line program's only file entry --
/// best supplied as the original `.c` path the user passed
/// to `badc`, falling back to `<unknown>` when no path is
/// available (stdin pipe, etc.).
pub(crate) fn emit(
    program: &Program,
    build: &Build,
    code_vmaddr: u64,
    source_path: &str,
) -> DwarfSections {
    let mut strs = StrTable::new();
    let producer_off = strs.intern(&format!("badc {}", env!("CARGO_PKG_VERSION")));
    let comp_dir_off = strs.intern("");
    let cu_name_off = strs.intern(if source_path.is_empty() {
        "<unknown>"
    } else {
        source_path
    });
    // Names for the two phase-2 base type DIEs (gh #46).
    let int_type_name_off = strs.intern("int");
    let ptr_type_name_off = strs.intern("void *");

    // Walk the bytecode, collect one `Subprog` per `Op::Ent`.
    let subs = collect_subprograms(program, build, code_vmaddr, &mut strs);

    let debug_str = strs.into_bytes();
    let debug_abbrev = build_debug_abbrev();
    let (debug_line, line_unit_off) = build_debug_line(program, build, code_vmaddr, source_path);
    let debug_info = build_debug_info(
        cu_name_off,
        comp_dir_off,
        producer_off,
        line_unit_off,
        code_vmaddr,
        build.text.len() as u64,
        int_type_name_off,
        ptr_type_name_off,
        &subs,
    );

    DwarfSections {
        debug_info,
        debug_abbrev,
        debug_line,
        debug_str,
    }
}

// ---- Subprogram discovery ----

struct Subprog {
    name_off: u32,
    low_pc: u64,
    high_pc: u64,
    /// Locals + formal-parameters that c5 captured for this
    /// subprogram (see `Compiler::variables`). The DWARF emitter
    /// turns each into a `DW_TAG_variable` /
    /// `DW_TAG_formal_parameter` child of the subprogram DIE.
    variables: Vec<SubprogVar>,
}

struct SubprogVar {
    name_off: u32,
    is_parameter: bool,
    is_pointer: bool,
    /// Frame-pointer-relative byte offset (c5's `fp_slot * 8`).
    fp_byte_offset: i64,
}

fn collect_subprograms(
    program: &Program,
    build: &Build,
    code_vmaddr: u64,
    strs: &mut StrTable,
) -> Vec<Subprog> {
    let mut out: Vec<Subprog> = Vec::new();

    // Walk every Ent in bc-pc order. The native start is
    // `bytecode_to_native[bc_pc]`; the native end is the start of
    // the *next* Ent (or the total code length for the last
    // function). A function's name lives at
    // `program.source_functions[bc_pc]` -- empty when the
    // optimizer dropped the map (pre-#39) or for functions
    // emitted before any user code (e.g. trampolines).
    let mut ent_pcs: Vec<usize> = Vec::new();
    let mut bc_pc = 0usize;
    while bc_pc < program.text.len() {
        let raw = program.text[bc_pc];
        let Some(op) = Op::from_i64(raw) else {
            break;
        };
        if matches!(op, Op::Ent) {
            ent_pcs.push(bc_pc);
        }
        bc_pc += op.word_size();
    }
    // Sentinel for end-of-last-function range.
    let total_native = build.text.len();

    // c5's source-function tracking attributes some `Op::Ent`s to
    // the wrong containing C function -- in sqlite's amalgamation
    // there are 15 Ents that c5 calls "yy_reduce" but whose source
    // lines + actual code belong to setupLookaside,
    // sqlite3_db_release_memory, etc. (gh #48). Without
    // disambiguation, lldb's `b yy_reduce` returns 15 matches and
    // the user can't tell which is the real one. Suffix duplicates
    // with `.<N>` so the legitimate first-occurrence keeps the
    // bare name and `b yy_reduce` resolves to one location. The
    // upstream c5 tracking is a separate fix (the suffixed names
    // still point at real bytecode, so backtraces inside the
    // mis-attributed regions are no worse than they were).
    let mut name_seen: alloc::collections::BTreeMap<alloc::string::String, u32> =
        alloc::collections::BTreeMap::new();
    for (i, &ent_pc) in ent_pcs.iter().enumerate() {
        let raw_name = program
            .source_functions
            .get(ent_pc)
            .filter(|s| !s.is_empty())
            .cloned()
            .unwrap_or_else(|| format!("fn_bc_{ent_pc}"));
        let count = name_seen.entry(raw_name.clone()).or_insert(0);
        let name = if *count == 0 {
            raw_name
        } else {
            format!("{raw_name}.{}", *count)
        };
        *count += 1;
        let name_off = strs.intern(&name);

        let lo = build
            .bytecode_to_native
            .get(ent_pc)
            .copied()
            .unwrap_or(usize::MAX);
        if lo == usize::MAX {
            continue;
        }
        let hi = if let Some(&next_ent) = ent_pcs.get(i + 1) {
            build
                .bytecode_to_native
                .get(next_ent)
                .copied()
                .unwrap_or(total_native)
        } else {
            total_native
        };
        if hi <= lo {
            continue;
        }

        // Pull this subprogram's locals + parameters from
        // `program.variables` (gh #46). Captured by the c5
        // frontend at function-body close, indexed by the Ent's
        // bytecode pc so a simple equality check groups them.
        let function_bc_pc = ent_pc as u64;
        let variables = program
            .variables
            .iter()
            .filter(|v| v.function_bc_pc == function_bc_pc)
            .map(|v| SubprogVar {
                name_off: strs.intern(&v.name),
                is_parameter: v.is_parameter,
                is_pointer: crate::c5::compiler::types::is_pointer_ty(v.type_tag),
                // c5's slot -> byte conversion: positive (args)
                // use 16-byte AAPCS64 slot stride starting at
                // `(slot - 1) * 16` (so slot 2 -> +16, slot 3 ->
                // +32). Negative (locals) use 8-byte stride. Mirror
                // of `aarch64::lea_offset_bytes`. The x86_64 backend
                // matches; both arches share this layout.
                fp_byte_offset: if v.fp_slot >= 2 {
                    (v.fp_slot - 1) * 16
                } else {
                    v.fp_slot * 8
                },
            })
            .collect();

        out.push(Subprog {
            name_off,
            low_pc: code_vmaddr + lo as u64,
            high_pc: code_vmaddr + hi as u64,
            variables,
        });
    }

    out
}

// ---- .debug_abbrev ----

fn build_debug_abbrev() -> Vec<u8> {
    let mut buf = Vec::with_capacity(64);

    // Abbrev 1: DW_TAG_compile_unit, has children.
    write_uleb128(&mut buf, 1);
    write_uleb128(&mut buf, DW_TAG_COMPILE_UNIT as u64);
    buf.push(DW_CHILDREN_YES);
    write_attr(&mut buf, DW_AT_PRODUCER, DW_FORM_STRP);
    write_attr(&mut buf, DW_AT_LANGUAGE, DW_FORM_DATA1);
    write_attr(&mut buf, DW_AT_NAME, DW_FORM_STRP);
    write_attr(&mut buf, DW_AT_COMP_DIR, DW_FORM_STRP);
    write_attr(&mut buf, DW_AT_LOW_PC, DW_FORM_ADDR);
    write_attr(&mut buf, DW_AT_HIGH_PC, DW_FORM_DATA8);
    write_attr(&mut buf, DW_AT_STMT_LIST, DW_FORM_SEC_OFFSET);
    write_uleb128(&mut buf, 0);
    write_uleb128(&mut buf, 0);

    // Abbrev 2: DW_TAG_subprogram, has children (formal_param,
    // variable). Phase 2 (gh #46) added DW_AT_frame_base so
    // `DW_OP_fbreg` location expressions in the children resolve
    // against `$x29` (c5's frame pointer).
    write_uleb128(&mut buf, 2);
    write_uleb128(&mut buf, DW_TAG_SUBPROGRAM as u64);
    buf.push(DW_CHILDREN_YES);
    write_attr(&mut buf, DW_AT_NAME, DW_FORM_STRP);
    write_attr(&mut buf, DW_AT_LOW_PC, DW_FORM_ADDR);
    // High PC as DATA8 means "size in bytes from low_pc". Cheaper
    // than DW_FORM_addr and matches gcc / clang's DWARF 4 output.
    write_attr(&mut buf, DW_AT_HIGH_PC, DW_FORM_DATA8);
    write_attr(&mut buf, DW_AT_EXTERNAL, DW_FORM_FLAG_PRESENT);
    write_attr(&mut buf, DW_AT_FRAME_BASE, DW_FORM_EXPRLOC);
    write_uleb128(&mut buf, 0);
    write_uleb128(&mut buf, 0);

    // Abbrev 3: DW_TAG_base_type. Two instances are emitted in
    // .debug_info: a 4-byte signed `int` and an 8-byte `void *`.
    // Variable / parameter DIEs reference whichever matches their
    // c5 type tag (pointer => the address-encoded entry, all
    // others => the int entry). Phase 3 will replace this with
    // per-c5-type-tag base / pointer / struct DIEs.
    write_uleb128(&mut buf, 3);
    write_uleb128(&mut buf, DW_TAG_BASE_TYPE as u64);
    buf.push(DW_CHILDREN_NO);
    write_attr(&mut buf, DW_AT_NAME, DW_FORM_STRP);
    write_attr(&mut buf, DW_AT_BYTE_SIZE, DW_FORM_DATA1);
    write_attr(&mut buf, DW_AT_ENCODING, DW_FORM_DATA1);
    write_uleb128(&mut buf, 0);
    write_uleb128(&mut buf, 0);

    // Abbrev 4: DW_TAG_variable (local). DW_AT_location is a
    // DWARF expression -- for c5 locals it's
    // `DW_OP_fbreg <sleb128 byte-offset>`, with the frame base
    // resolved via the subprogram's DW_AT_frame_base.
    write_uleb128(&mut buf, 4);
    write_uleb128(&mut buf, DW_TAG_VARIABLE as u64);
    buf.push(DW_CHILDREN_NO);
    write_attr(&mut buf, DW_AT_NAME, DW_FORM_STRP);
    write_attr(&mut buf, DW_AT_TYPE, DW_FORM_REF4);
    write_attr(&mut buf, DW_AT_LOCATION, DW_FORM_EXPRLOC);
    write_uleb128(&mut buf, 0);
    write_uleb128(&mut buf, 0);

    // Abbrev 5: DW_TAG_formal_parameter. Same shape as the local
    // variable abbrev; the tag itself is what tells lldb /
    // gdb to render the entry as a parameter rather than a local.
    write_uleb128(&mut buf, 5);
    write_uleb128(&mut buf, DW_TAG_FORMAL_PARAMETER as u64);
    buf.push(DW_CHILDREN_NO);
    write_attr(&mut buf, DW_AT_NAME, DW_FORM_STRP);
    write_attr(&mut buf, DW_AT_TYPE, DW_FORM_REF4);
    write_attr(&mut buf, DW_AT_LOCATION, DW_FORM_EXPRLOC);
    write_uleb128(&mut buf, 0);
    write_uleb128(&mut buf, 0);

    // End of abbreviation table.
    write_uleb128(&mut buf, 0);
    buf
}

fn write_attr(buf: &mut Vec<u8>, attr: u32, form: u32) {
    write_uleb128(buf, attr as u64);
    write_uleb128(buf, form as u64);
}

// ---- .debug_info ----

#[allow(clippy::too_many_arguments)]
fn build_debug_info(
    cu_name_off: u32,
    comp_dir_off: u32,
    producer_off: u32,
    line_unit_off: u32,
    cu_low_pc: u64,
    cu_size: u64,
    int_type_name_off: u32,
    ptr_type_name_off: u32,
    subs: &[Subprog],
) -> Vec<u8> {
    // DWARF 4 32-bit unit header is 11 bytes:
    //   unit_length (4)  -- length of the unit *not counting* this field
    //   version     (2)  -- 4
    //   debug_abbrev_offset (4) -- offset into .debug_abbrev (we put
    //                              everything in one CU, so 0)
    //   address_size (1) -- 8 (every supported target is 64-bit)
    //
    // We can't write `unit_length` until we know the body size, so
    // build the body first, then prepend the header.
    //
    // DW_FORM_ref4 references in this CU encode a CU-relative
    // byte offset; the unit starts at .debug_info offset 0, so
    // CU-relative == .debug_info-absolute. We track the
    // `header_len`-shifted position of each type DIE so child
    // DIEs can refer back to it.
    const HEADER_LEN: usize = 11;
    let mut body: Vec<u8> = Vec::with_capacity(64 + subs.len() * 48);

    // CU DIE: abbrev 1.
    write_uleb128(&mut body, 1);
    body.extend_from_slice(&producer_off.to_le_bytes());
    body.push(DW_LANG_C99);
    body.extend_from_slice(&cu_name_off.to_le_bytes());
    body.extend_from_slice(&comp_dir_off.to_le_bytes());
    body.extend_from_slice(&cu_low_pc.to_le_bytes());
    body.extend_from_slice(&cu_size.to_le_bytes());
    body.extend_from_slice(&line_unit_off.to_le_bytes());

    // Type DIEs (CU children, abbrev 3). Two entries cover phase
    // 2's variable / parameter shapes: a 4-byte signed `int` and
    // an 8-byte address-encoded `void *`. Variables / parameters
    // pick whichever matches their c5 pointer-or-not status.
    let int_type_off = (body.len() + HEADER_LEN) as u32;
    write_uleb128(&mut body, 3);
    body.extend_from_slice(&int_type_name_off.to_le_bytes());
    body.push(4);
    body.push(DW_ATE_SIGNED);

    let ptr_type_off = (body.len() + HEADER_LEN) as u32;
    write_uleb128(&mut body, 3);
    body.extend_from_slice(&ptr_type_name_off.to_le_bytes());
    body.push(8);
    body.push(DW_ATE_ADDRESS);

    // Subprogram children, each with its own variable /
    // formal_parameter children.
    for s in subs {
        write_uleb128(&mut body, 2);
        body.extend_from_slice(&s.name_off.to_le_bytes());
        body.extend_from_slice(&s.low_pc.to_le_bytes());
        body.extend_from_slice(&(s.high_pc - s.low_pc).to_le_bytes());
        // DW_AT_external is DW_FORM_flag_present -- no bytes.
        // DW_AT_frame_base (DW_FORM_exprloc): "frame base is
        // x29 + 0", encoded as `DW_OP_breg29 0`. Two bytes:
        // opcode + sleb128(0).
        write_uleb128(&mut body, 2);
        body.push(DW_OP_BREG29);
        body.push(0);

        // Variable / formal_parameter children. Order: parameters
        // first (lldb's frame-variable ordering matches the
        // declaration order; we keep it close enough for c5's
        // single-pass capture by sorting here).
        let mut sorted: Vec<&SubprogVar> = s.variables.iter().collect();
        sorted.sort_by_key(|v| (!v.is_parameter, v.fp_byte_offset));
        for v in sorted {
            let abbrev = if v.is_parameter { 5 } else { 4 };
            write_uleb128(&mut body, abbrev);
            body.extend_from_slice(&v.name_off.to_le_bytes());
            let type_off = if v.is_pointer {
                ptr_type_off
            } else {
                int_type_off
            };
            body.extend_from_slice(&type_off.to_le_bytes());
            // Location: DW_OP_fbreg <sleb128 offset-from-frame-base>.
            let mut loc: Vec<u8> = Vec::with_capacity(8);
            loc.push(DW_OP_FBREG);
            write_sleb128(&mut loc, v.fp_byte_offset);
            write_uleb128(&mut body, loc.len() as u64);
            body.extend_from_slice(&loc);
        }
        // Children-list terminator for this subprogram.
        body.push(0);
    }

    // CU children list terminator.
    body.push(0);

    // Header.
    let mut out = Vec::with_capacity(HEADER_LEN + body.len());
    let unit_length = (body.len() + 7) as u32; // version(2) + abbrev_off(4) + addr_size(1)
    out.extend_from_slice(&unit_length.to_le_bytes());
    out.extend_from_slice(&4u16.to_le_bytes()); // DWARF version 4
    out.extend_from_slice(&0u32.to_le_bytes()); // debug_abbrev_offset
    out.push(8); // address_size
    out.extend_from_slice(&body);
    out
}

// ---- .debug_line ----

/// Build the line-number program for the whole binary in one
/// statement-program unit, plus the unit header.
///
/// Returns `(bytes, header_offset)` -- the second is always 0
/// here because we only emit a single line-program; callers pass
/// it as the CU's `DW_AT_stmt_list`.
fn build_debug_line(
    program: &Program,
    build: &Build,
    code_vmaddr: u64,
    source_path: &str,
) -> (Vec<u8>, u32) {
    // Header layout (DWARF 4, 32-bit):
    //   unit_length              (4)
    //   version                  (2) = 4
    //   header_length            (4) -- bytes from end of this field to
    //                                   the start of the program
    //   minimum_instruction_length (1)
    //   maximum_operations_per_instruction (1)
    //   default_is_stmt          (1)
    //   line_base                (1, signed)
    //   line_range               (1)
    //   opcode_base              (1)
    //   standard_opcode_lengths  (opcode_base - 1 bytes)
    //   include_directories      ([NUL] terminated path list, ends with NUL)
    //   file_names               ([NUL] terminated entries; each:
    //                              name<NUL> dir_idx<ULEB> mtime<ULEB> length<ULEB>;
    //                              list ends with empty name <NUL>)
    let mut prog = Vec::with_capacity(256);
    write_line_program(&mut prog, program, build, code_vmaddr);

    // Build the file/dir table sections separately so we can compute
    // `header_length`.
    let mut hdr_after_len_field = Vec::with_capacity(32);
    hdr_after_len_field.push(1); // minimum_instruction_length
    hdr_after_len_field.push(1); // maximum_operations_per_instruction
    hdr_after_len_field.push(1); // default_is_stmt = true
    hdr_after_len_field.push(LINE_BASE as u8); // line_base = -1 (signed byte)
    hdr_after_len_field.push(LINE_RANGE); // line_range = 14
    hdr_after_len_field.push(OPCODE_BASE); // opcode_base = 13
    // Standard-opcode lengths, indexed 1..opcode_base-1. Defaults
    // from the DWARF 4 spec table.
    for &n in &[0u8, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 1] {
        hdr_after_len_field.push(n);
    }
    // include_directories: empty list (just the terminator).
    hdr_after_len_field.push(0);
    // file_names: one entry naming the source.
    let name = if source_path.is_empty() {
        "<unknown>"
    } else {
        source_path
    };
    hdr_after_len_field.extend_from_slice(name.as_bytes());
    hdr_after_len_field.push(0);
    write_uleb128(&mut hdr_after_len_field, 0); // dir_idx (0 = comp_dir)
    write_uleb128(&mut hdr_after_len_field, 0); // mtime
    write_uleb128(&mut hdr_after_len_field, 0); // file size
    hdr_after_len_field.push(0); // file_names terminator

    // header_length = bytes from end of header_length field to
    // start of program (i.e., minimum_instruction_length onward).
    let header_length = hdr_after_len_field.len() as u32;

    let mut hdr = Vec::with_capacity(11 + hdr_after_len_field.len());
    hdr.extend_from_slice(&4u16.to_le_bytes()); // version 4
    hdr.extend_from_slice(&header_length.to_le_bytes());
    hdr.extend_from_slice(&hdr_after_len_field);

    // unit_length covers everything after itself: version(2) +
    // header_length(4) + header_length-bytes + program.
    let unit_length = (hdr.len() + prog.len()) as u32;
    let mut out = Vec::with_capacity(4 + hdr.len() + prog.len());
    out.extend_from_slice(&unit_length.to_le_bytes());
    out.extend_from_slice(&hdr);
    out.extend_from_slice(&prog);

    (out, 0)
}

// Standard line-program tuning. Match DWARF 4's recommended
// defaults: a special-opcode encodes
// `(line += line_base + ((adj) % line_range);
//   address += min_inst_len * (adj / line_range))`
// where `adj = opcode - opcode_base`. With `line_base = -1`,
// `line_range = 14`, an opcode covers line deltas in `[-1..12]`
// before falling back to standard ops.
const LINE_BASE: i8 = -1;
const LINE_RANGE: u8 = 14;
const OPCODE_BASE: u8 = 13;

/// Walk the bytecode, emit one row per (live) op whose source line
/// is known. The DWARF state machine starts at `(address=0,
/// line=1, file=1, is_stmt=true)`; we open with a
/// `DW_LNE_set_address` to anchor at `code_vmaddr` and end with a
/// `DW_LNE_end_sequence` row past the last byte.
fn write_line_program(buf: &mut Vec<u8>, program: &Program, build: &Build, code_vmaddr: u64) {
    // Anchor address at the start of code.
    write_set_address(buf, code_vmaddr);

    let mut state_addr: u64 = code_vmaddr;
    let mut state_line: i64 = 1;
    let mut emitted_any = false;

    let mut bc_pc = 0usize;
    while bc_pc < program.text.len() {
        let raw = program.text[bc_pc];
        let Some(op) = Op::from_i64(raw) else {
            break;
        };
        let native = build
            .bytecode_to_native
            .get(bc_pc)
            .copied()
            .unwrap_or(usize::MAX);
        if native == usize::MAX {
            bc_pc += op.word_size();
            continue;
        }
        let line = program.source_lines.get(bc_pc).copied().unwrap_or(0) as i64;
        if line == 0 {
            bc_pc += op.word_size();
            continue;
        }
        let target_addr = code_vmaddr + native as u64;
        if target_addr > state_addr {
            advance_pc(buf, target_addr - state_addr);
            state_addr = target_addr;
        }
        if line != state_line {
            advance_line(buf, line - state_line);
            state_line = line;
        }
        // DW_LNS_copy emits the row. (We can't use special opcodes
        // here because the address+line deltas aren't bounded by
        // line_base / line_range in general.)
        buf.push(DW_LNS_COPY);
        emitted_any = true;
        bc_pc += op.word_size();
    }

    // Close the sequence with end_sequence at one past the last
    // byte.
    let end_addr = code_vmaddr + build.text.len() as u64;
    if end_addr > state_addr {
        advance_pc(buf, end_addr - state_addr);
    }
    write_extended(buf, DW_LNE_END_SEQUENCE, &[]);

    let _ = emitted_any;
}

fn write_set_address(buf: &mut Vec<u8>, addr: u64) {
    // Extended opcode: 0, len(ULEB), DW_LNE_set_address, addr (8 bytes).
    write_extended(buf, DW_LNE_SET_ADDRESS, &addr.to_le_bytes());
}

fn write_extended(buf: &mut Vec<u8>, op: u8, data: &[u8]) {
    buf.push(0);
    // length covers op + data
    write_uleb128(buf, (1 + data.len()) as u64);
    buf.push(op);
    buf.extend_from_slice(data);
}

fn advance_pc(buf: &mut Vec<u8>, delta: u64) {
    buf.push(DW_LNS_ADVANCE_PC);
    write_uleb128(buf, delta);
}

fn advance_line(buf: &mut Vec<u8>, delta: i64) {
    buf.push(DW_LNS_ADVANCE_LINE);
    write_sleb128(buf, delta);
}

// ---- ULEB / SLEB / strtab ----

struct StrTable {
    bytes: Vec<u8>,
    // We don't bother deduplicating string contents in phase 1 --
    // the table is small (one entry per user function, plus the
    // CU name and producer) and the writer reads it sequentially.
    // Phase 2 can add a hashmap-based dedup pass if it ever
    // matters.
}

impl StrTable {
    fn new() -> Self {
        // DWARF .debug_str must start with a string at offset 0;
        // a single NUL works as the empty-string root entry. Some
        // consumers don't tolerate the table starting at a
        // non-NUL byte.
        StrTable {
            bytes: Vec::from(&[0u8][..]),
        }
    }
    fn intern(&mut self, s: &str) -> u32 {
        let off = self.bytes.len() as u32;
        self.bytes.extend_from_slice(s.as_bytes());
        self.bytes.push(0);
        off
    }
    fn into_bytes(self) -> Vec<u8> {
        self.bytes
    }
}

fn write_uleb128(buf: &mut Vec<u8>, mut value: u64) {
    loop {
        let mut byte = (value & 0x7f) as u8;
        value >>= 7;
        if value != 0 {
            byte |= 0x80;
            buf.push(byte);
        } else {
            buf.push(byte);
            return;
        }
    }
}

fn write_sleb128(buf: &mut Vec<u8>, mut value: i64) {
    loop {
        let byte = (value & 0x7f) as u8;
        let cont = !((value == 0 && (byte & 0x40) == 0) || (value == -1 && (byte & 0x40) != 0));
        value >>= 7;
        if cont {
            buf.push(byte | 0x80);
        } else {
            buf.push(byte);
            return;
        }
    }
}

// ---- tests ----

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn uleb128_round_trips_small_and_large() {
        for v in [0u64, 1, 127, 128, 0xffff_ffff, 0xffff_ffff_ffff_ffff] {
            let mut buf = Vec::new();
            write_uleb128(&mut buf, v);
            let (decoded, _) = decode_uleb128(&buf);
            assert_eq!(decoded, v, "round trip failed for {v}");
        }
    }

    #[test]
    fn sleb128_handles_negative() {
        for v in [0i64, 1, -1, 63, -64, 64, -65, i64::MIN, i64::MAX] {
            let mut buf = Vec::new();
            write_sleb128(&mut buf, v);
            let (decoded, _) = decode_sleb128(&buf);
            assert_eq!(decoded, v, "round trip failed for {v}");
        }
    }

    #[test]
    fn strtab_starts_with_empty_string() {
        let mut t = StrTable::new();
        let off_a = t.intern("hello");
        let off_b = t.intern("world");
        // Empty string at offset 0; first interned at 1 (after
        // the leading NUL).
        assert_eq!(off_a, 1);
        assert_eq!(off_b, 1 + b"hello\0".len() as u32);
    }

    fn decode_uleb128(buf: &[u8]) -> (u64, usize) {
        let mut value: u64 = 0;
        let mut shift = 0;
        let mut i = 0;
        loop {
            let b = buf[i];
            value |= ((b & 0x7f) as u64) << shift;
            i += 1;
            if b & 0x80 == 0 {
                return (value, i);
            }
            shift += 7;
        }
    }

    fn decode_sleb128(buf: &[u8]) -> (i64, usize) {
        let mut value: i64 = 0;
        let mut shift = 0;
        let mut i = 0;
        loop {
            let b = buf[i];
            value |= ((b & 0x7f) as i64) << shift;
            i += 1;
            shift += 7;
            if b & 0x80 == 0 {
                if (b & 0x40) != 0 && shift < 64 {
                    value |= -1i64 << shift;
                }
                return (value, i);
            }
        }
    }
}
