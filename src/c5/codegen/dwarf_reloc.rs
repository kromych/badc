//! Relocatable DWARF emitter for `OutputKind::Relocatable` output.
//!
//! Produces a DWARF 4 triple suitable for placement in an ELF
//! ET_REL object:
//!
//!   * `.debug_info`   -- one compilation-unit DIE per `.o` with
//!                        type catalog + subprogram DIEs + their
//!                        formal_parameter / variable children.
//!   * `.debug_abbrev` -- the matching abbreviation table.
//!   * `.debug_line`   -- one line-number program covering the unit's
//!                        `.text`.
//!
//! Every address slot is emitted as a placeholder paired with an
//! [`DwarfReloc`] record so the linker can rebase the section once
//! the per-unit `.text` / `.debug_line` / `.debug_abbrev` bases are
//! known. This matches gcc / clang `-c -g` output for c5's subset.
//!
//! Each CU lays out its children in this order: type catalog
//! (base_type + pointer_type DIEs) then subprograms. Subprograms
//! carry `DW_AT_frame_base` and emit formal_parameter / variable
//! children with `DW_AT_location` (DW_OP_fbreg + offset) and
//! `DW_AT_type` cross-DIE references (`DW_FORM_ref4`) to the type
//! catalog earlier in the same CU. The `long` base type follows
//! the C99 data model per target: 4 bytes on Windows (LLP64),
//! 8 bytes on Linux / macOS (LP64). Struct / union types are
//! emitted as `DW_TAG_structure_type` / `DW_TAG_union_type` DIEs
//! with `DW_TAG_member` children; member `DW_AT_type` refs the
//! scalar catalog above. Nested aggregate fields and bitfield
//! `DW_AT_bit_offset` encoding stay deferred. `.debug_frame`
//! regenerates from `synth_build`'s symbol set on the merged
//! image rather than being carried per-`.o`.

#![allow(dead_code)]

use alloc::collections::BTreeMap;
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use super::super::program::Program;
use super::super::token::Ty;
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
const DW_TAG_SUBPROGRAM: u8 = 0x2e;
const DW_TAG_FORMAL_PARAMETER: u8 = 0x05;
const DW_TAG_VARIABLE: u8 = 0x34;
const DW_TAG_BASE_TYPE: u8 = 0x24;
const DW_TAG_POINTER_TYPE: u8 = 0x0f;
const DW_TAG_STRUCTURE_TYPE: u8 = 0x13;
const DW_TAG_UNION_TYPE: u8 = 0x17;
const DW_TAG_MEMBER: u8 = 0x0d;

const DW_AT_NAME: u8 = 0x03;
const DW_AT_STMT_LIST: u8 = 0x10;
const DW_AT_LOW_PC: u8 = 0x11;
const DW_AT_HIGH_PC: u8 = 0x12;
const DW_AT_LANGUAGE: u8 = 0x13;
const DW_AT_COMP_DIR: u8 = 0x1b;
const DW_AT_PRODUCER: u8 = 0x25;
const DW_AT_LOCATION: u8 = 0x02;
const DW_AT_FRAME_BASE: u8 = 0x40;
const DW_AT_BYTE_SIZE: u8 = 0x0b;
const DW_AT_ENCODING: u8 = 0x3e;
const DW_AT_TYPE: u8 = 0x49;
const DW_AT_DATA_MEMBER_LOCATION: u8 = 0x38;
const DW_AT_BIT_SIZE: u8 = 0x0d;
const DW_AT_DATA_BIT_OFFSET: u8 = 0x6b;

const DW_FORM_ADDR: u8 = 0x01;
const DW_FORM_DATA8: u8 = 0x07;
const DW_FORM_STRING: u8 = 0x08;
const DW_FORM_DATA1: u8 = 0x0b;
const DW_FORM_SEC_OFFSET: u8 = 0x17;
const DW_FORM_EXPRLOC: u8 = 0x18;
const DW_FORM_REF4: u8 = 0x13;
const DW_FORM_UDATA: u8 = 0x0f;

// DW_ATE_* encoding values for DW_TAG_base_type.
const DW_ATE_SIGNED: u8 = 0x05;
const DW_ATE_UNSIGNED: u8 = 0x07;
const DW_ATE_SIGNED_CHAR: u8 = 0x06;
const DW_ATE_UNSIGNED_CHAR: u8 = 0x08;
const DW_ATE_FLOAT: u8 = 0x04;

const DW_OP_REG29: u8 = 0x6d; // aarch64 frame pointer x29
const DW_OP_REG6: u8 = 0x56; // x86_64 frame pointer rbp
const DW_OP_FBREG: u8 = 0x91; // fbreg N (SLEB128 N)

const DW_CHILDREN_NO: u8 = 0x00;
const DW_CHILDREN_YES: u8 = 0x01;

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
const ABBREV_SUBPROGRAM_LEAF: u64 = 2;
const ABBREV_SUBPROGRAM_WITH_CHILDREN: u64 = 3;
const ABBREV_FORMAL_PARAMETER: u64 = 4;
const ABBREV_VARIABLE: u64 = 5;
const ABBREV_BASE_TYPE: u64 = 6;
const ABBREV_POINTER_TYPE: u64 = 7;
const ABBREV_STRUCTURE_TYPE: u64 = 8;
const ABBREV_UNION_TYPE: u64 = 9;
const ABBREV_MEMBER: u64 = 10;
const ABBREV_BITFIELD_MEMBER: u64 = 11;

/// Compilation-unit header for `.debug_info` (DWARF 4, 32-bit
/// form). Follows the spec table exactly.
#[repr(C, packed)]
#[derive(Clone, Copy)]
struct DebugInfoUnitHeader {
    unit_length: u32,
    version: u16,
    debug_abbrev_offset: u32,
    address_size: u8,
}

const DEBUG_INFO_UNIT_HEADER_SIZE: u64 = 11;
const _: () =
    assert!(core::mem::size_of::<DebugInfoUnitHeader>() == DEBUG_INFO_UNIT_HEADER_SIZE as usize);

/// `.debug_line` unit header (DWARF 4, 32-bit form).
#[repr(C, packed)]
#[derive(Clone, Copy)]
struct DebugLineUnitHeader {
    unit_length: u32,
    version: u16,
    header_length: u32,
}

const DEBUG_LINE_UNIT_HEADER_SIZE: u64 = 10;
const _: () =
    assert!(core::mem::size_of::<DebugLineUnitHeader>() == DEBUG_LINE_UNIT_HEADER_SIZE as usize);

/// Fixed-shape prefix of the `.debug_line` program (the bytes
/// between the unit header's `header_length` field and the
/// variable include_directories / file_names lists). DWARF 4
/// section 6.2.4.
#[repr(C, packed)]
#[derive(Clone, Copy)]
struct DebugLineProgramHeader {
    minimum_instruction_length: u8,
    maximum_operations_per_instruction: u8,
    default_is_stmt: u8,
    line_base: i8,
    line_range: u8,
    opcode_base: u8,
    /// `standard_opcode_lengths[i]` is the operand count for
    /// standard opcode `i+1`. Sized for the twelve DWARF 4
    /// standard opcodes (`DW_LNS_copy` through `DW_LNS_set_isa`).
    standard_opcode_lengths: [u8; 12],
}

const DEBUG_LINE_PROGRAM_HEADER_SIZE: u64 = 18;
const _: () = assert!(
    core::mem::size_of::<DebugLineProgramHeader>() == DEBUG_LINE_PROGRAM_HEADER_SIZE as usize
);

fn write_struct<T: Copy>(out: &mut Vec<u8>, value: &T) {
    let bytes = unsafe {
        core::slice::from_raw_parts((value as *const T) as *const u8, core::mem::size_of::<T>())
    };
    out.extend_from_slice(bytes);
}

/// Emit the relocatable DWARF triple plus the address-reloc list.
/// `source_path` becomes the CU's `DW_AT_name`; the line table's
/// file numbering reuses [`Program::source_files`].
pub(crate) fn emit(
    program: &Program,
    build: &Build,
    source_path: &str,
    machine: super::Machine,
    target: super::Target,
) -> DwarfRelocatable {
    let debug_abbrev = build_debug_abbrev();
    let (debug_line, line_relocs) = build_debug_line(program, build);
    let (debug_info, info_relocs) = build_debug_info(source_path, program, build, machine, target);
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
    let mut out = Vec::new();
    // Abbrev 1: compile_unit with subprogram children.
    write_uleb128(&mut out, ABBREV_CU);
    out.push(DW_TAG_COMPILE_UNIT);
    out.push(DW_CHILDREN_YES);
    push_attr(&mut out, DW_AT_PRODUCER, DW_FORM_STRING);
    push_attr(&mut out, DW_AT_LANGUAGE, DW_FORM_DATA1);
    push_attr(&mut out, DW_AT_NAME, DW_FORM_STRING);
    push_attr(&mut out, DW_AT_COMP_DIR, DW_FORM_STRING);
    push_attr(&mut out, DW_AT_LOW_PC, DW_FORM_ADDR);
    push_attr(&mut out, DW_AT_HIGH_PC, DW_FORM_DATA8);
    push_attr(&mut out, DW_AT_STMT_LIST, DW_FORM_SEC_OFFSET);
    out.push(0);
    out.push(0);
    // Abbrev 2: subprogram leaf -- name + extent only. Used when
    // the function has no variables.
    write_uleb128(&mut out, ABBREV_SUBPROGRAM_LEAF);
    out.push(DW_TAG_SUBPROGRAM);
    out.push(DW_CHILDREN_NO);
    push_attr(&mut out, DW_AT_NAME, DW_FORM_STRING);
    push_attr(&mut out, DW_AT_LOW_PC, DW_FORM_ADDR);
    push_attr(&mut out, DW_AT_HIGH_PC, DW_FORM_DATA8);
    out.push(0);
    out.push(0);
    // Abbrev 3: subprogram with variable / parameter children.
    // Adds DW_AT_frame_base so the debugger can resolve fbreg
    // offsets in the children's DW_AT_location attrs.
    write_uleb128(&mut out, ABBREV_SUBPROGRAM_WITH_CHILDREN);
    out.push(DW_TAG_SUBPROGRAM);
    out.push(DW_CHILDREN_YES);
    push_attr(&mut out, DW_AT_NAME, DW_FORM_STRING);
    push_attr(&mut out, DW_AT_LOW_PC, DW_FORM_ADDR);
    push_attr(&mut out, DW_AT_HIGH_PC, DW_FORM_DATA8);
    push_attr(&mut out, DW_AT_FRAME_BASE, DW_FORM_EXPRLOC);
    out.push(0);
    out.push(0);
    // Abbrev 4: formal_parameter -- name + fbreg location +
    // DW_AT_type cross-DIE reference to a type DIE earlier in
    // the same CU.
    write_uleb128(&mut out, ABBREV_FORMAL_PARAMETER);
    out.push(DW_TAG_FORMAL_PARAMETER);
    out.push(DW_CHILDREN_NO);
    push_attr(&mut out, DW_AT_NAME, DW_FORM_STRING);
    push_attr(&mut out, DW_AT_LOCATION, DW_FORM_EXPRLOC);
    push_attr(&mut out, DW_AT_TYPE, DW_FORM_REF4);
    out.push(0);
    out.push(0);
    // Abbrev 5: variable -- same shape as formal_parameter but
    // with the DW_TAG_variable tag so debuggers distinguish args
    // from locals.
    write_uleb128(&mut out, ABBREV_VARIABLE);
    out.push(DW_TAG_VARIABLE);
    out.push(DW_CHILDREN_NO);
    push_attr(&mut out, DW_AT_NAME, DW_FORM_STRING);
    push_attr(&mut out, DW_AT_LOCATION, DW_FORM_EXPRLOC);
    push_attr(&mut out, DW_AT_TYPE, DW_FORM_REF4);
    out.push(0);
    out.push(0);
    // Abbrev 6: base_type -- name + byte_size + DWARF encoding
    // (DW_ATE_*). Used for every C99 scalar (char / short / int
    // / long / long long / float / double, signed and unsigned
    // variants).
    write_uleb128(&mut out, ABBREV_BASE_TYPE);
    out.push(DW_TAG_BASE_TYPE);
    out.push(DW_CHILDREN_NO);
    push_attr(&mut out, DW_AT_NAME, DW_FORM_STRING);
    push_attr(&mut out, DW_AT_BYTE_SIZE, DW_FORM_DATA1);
    push_attr(&mut out, DW_AT_ENCODING, DW_FORM_DATA1);
    out.push(0);
    out.push(0);
    // Abbrev 7: pointer_type -- 8-byte pointer wrapping a
    // referenced type DIE. C99 6.2.5p20: pointer size is
    // implementation-defined; c5 picks 8 bytes everywhere.
    write_uleb128(&mut out, ABBREV_POINTER_TYPE);
    out.push(DW_TAG_POINTER_TYPE);
    out.push(DW_CHILDREN_NO);
    push_attr(&mut out, DW_AT_BYTE_SIZE, DW_FORM_DATA1);
    push_attr(&mut out, DW_AT_TYPE, DW_FORM_REF4);
    out.push(0);
    out.push(0);
    // Abbrev 8: structure_type -- name + byte_size; carries
    // DW_TAG_member children terminated by a null DIE.
    write_uleb128(&mut out, ABBREV_STRUCTURE_TYPE);
    out.push(DW_TAG_STRUCTURE_TYPE);
    out.push(DW_CHILDREN_YES);
    push_attr(&mut out, DW_AT_NAME, DW_FORM_STRING);
    push_attr(&mut out, DW_AT_BYTE_SIZE, DW_FORM_UDATA);
    out.push(0);
    out.push(0);
    // Abbrev 9: union_type -- same payload as structure_type but
    // members all live at offset 0.
    write_uleb128(&mut out, ABBREV_UNION_TYPE);
    out.push(DW_TAG_UNION_TYPE);
    out.push(DW_CHILDREN_YES);
    push_attr(&mut out, DW_AT_NAME, DW_FORM_STRING);
    push_attr(&mut out, DW_AT_BYTE_SIZE, DW_FORM_UDATA);
    out.push(0);
    out.push(0);
    // Abbrev 10: structure / union member -- name + type ref4
    // + byte offset from the start of the aggregate.
    write_uleb128(&mut out, ABBREV_MEMBER);
    out.push(DW_TAG_MEMBER);
    out.push(DW_CHILDREN_NO);
    push_attr(&mut out, DW_AT_NAME, DW_FORM_STRING);
    push_attr(&mut out, DW_AT_TYPE, DW_FORM_REF4);
    push_attr(&mut out, DW_AT_DATA_MEMBER_LOCATION, DW_FORM_UDATA);
    out.push(0);
    out.push(0);
    // Abbrev 11: bitfield member -- name + type ref4 +
    // DWARF 4 DW_AT_data_bit_offset (absolute bit offset from
    // the start of the aggregate) + DW_AT_bit_size (bit width).
    write_uleb128(&mut out, ABBREV_BITFIELD_MEMBER);
    out.push(DW_TAG_MEMBER);
    out.push(DW_CHILDREN_NO);
    push_attr(&mut out, DW_AT_NAME, DW_FORM_STRING);
    push_attr(&mut out, DW_AT_TYPE, DW_FORM_REF4);
    push_attr(&mut out, DW_AT_DATA_BIT_OFFSET, DW_FORM_UDATA);
    push_attr(&mut out, DW_AT_BIT_SIZE, DW_FORM_UDATA);
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

fn build_debug_info(
    source_path: &str,
    program: &Program,
    build: &Build,
    machine: super::Machine,
    target: super::Target,
) -> (Vec<u8>, Vec<DwarfReloc>) {
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
    let low_pc_off_in_body = body.len() as u64;
    body.extend_from_slice(&[0u8; 8]);
    relocs.push(DwarfReloc {
        section: DwarfSectionKind::Info,
        offset: DEBUG_INFO_UNIT_HEADER_SIZE + low_pc_off_in_body,
        width: DwarfRelocWidth::W8,
        target: DwarfRelocTarget::Text,
        addend: 0,
    });
    // DW_AT_high_pc as DATA8 (size in bytes from low_pc). No reloc
    // needed; the linker keeps low_pc + size pointing at the same
    // span because the per-unit `.text` slice is contiguous.
    let text_size = build.text.len() as u64;
    body.extend_from_slice(&text_size.to_le_bytes());
    // DW_AT_stmt_list -- 4-byte section offset into .debug_line.
    // Each `.o` has exactly one CU and its line program lands at
    // offset 0 inside `.debug_line`; the linker rebases the slot
    // when concatenating per-unit `.debug_line` blobs.
    let stmt_list_off_in_body = body.len() as u64;
    body.extend_from_slice(&[0u8; 4]);
    relocs.push(DwarfReloc {
        section: DwarfSectionKind::Info,
        offset: DEBUG_INFO_UNIT_HEADER_SIZE + stmt_list_off_in_body,
        width: DwarfRelocWidth::W4,
        target: DwarfRelocTarget::DebugLine,
        addend: 0,
    });

    // Per-target frame-pointer DWARF register encoding for
    // DW_AT_frame_base. aarch64 uses x29 (DW_OP_reg29); x86_64
    // uses rbp (DW_OP_reg6). The frame-base expr is a single
    // opcode byte, so DW_FORM_exprloc length = 1.
    let frame_base_op: u8 = match machine {
        super::Machine::Aarch64 => DW_OP_REG29,
        super::Machine::X86_64 => DW_OP_REG6,
    };

    // Collect every distinct (base_leaf, pointer_depth) tuple
    // referenced by this unit's variables. Emit base_type DIEs
    // followed by pointer_type wrappers; pointer levels chain
    // via DW_AT_type ref4 to the next-shallower wrapper (or to
    // the leaf type at depth 1). Map keys back to the
    // DW_FORM_ref4 offset (CU-relative byte offset = body offset
    // + DEBUG_INFO_UNIT_HEADER_SIZE).
    let mut type_offsets: BTreeMap<TypeKey, u32> = BTreeMap::new();
    {
        // Gather distinct leaf bases and aggregates referenced
        // by this unit's variables and struct fields, along
        // with the maximum pointer depth each one needs.
        // Aggregate fields that reference other aggregates pull
        // those in too via the field-walk below.
        let mut max_depth_per_scalar: BTreeMap<i64, u8> = BTreeMap::new();
        let mut max_depth_per_aggregate: BTreeMap<usize, u8> = BTreeMap::new();
        for v in &program.variables {
            match decompose_pointer_chain(v.type_tag) {
                Some(TypeKey::Scalar { leaf, depth }) => {
                    let e = max_depth_per_scalar.entry(leaf).or_insert(0);
                    if depth > *e {
                        *e = depth;
                    }
                }
                Some(TypeKey::Aggregate { id, depth }) => {
                    let e = max_depth_per_aggregate.entry(id).or_insert(0);
                    if depth > *e {
                        *e = depth;
                    }
                }
                None => continue,
            }
        }
        // Pull in field types: aggregates whose fields reference
        // scalar / pointer-to-scalar leafs need those DIEs in
        // the catalog. Nested aggregate fields stay deferred
        // (TODO -- needs topological sort) and surface without
        // DW_AT_type.
        for &id in max_depth_per_aggregate.keys() {
            if let Some(sd) = program.structs.get(id) {
                for f in &sd.fields {
                    if let Some(TypeKey::Scalar { leaf, depth }) = decompose_pointer_chain(f.ty) {
                        let e = max_depth_per_scalar.entry(leaf).or_insert(0);
                        if depth > *e {
                            *e = depth;
                        }
                    }
                }
            }
        }
        // Emit base_type DIEs first so the pointer wrappers and
        // aggregate members can reference them at smaller
        // offsets.
        for (&leaf, &max_depth) in &max_depth_per_scalar {
            let Some(base) = base_type_for_leaf(leaf, machine, target) else {
                continue;
            };
            let off = body.len() as u32 + DEBUG_INFO_UNIT_HEADER_SIZE as u32;
            type_offsets.insert(TypeKey::Scalar { leaf, depth: 0 }, off);
            write_uleb128(&mut body, ABBREV_BASE_TYPE);
            push_string(&mut body, base.name);
            body.push(base.byte_size);
            body.push(base.encoding);
            // Pointer wrappers: one DIE per depth from 1 to
            // max_depth. Each wrapper references the
            // next-shallower entry (depth N references depth
            // N-1).
            let mut prev_off = off;
            for depth in 1..=max_depth {
                let ptr_off = body.len() as u32 + DEBUG_INFO_UNIT_HEADER_SIZE as u32;
                type_offsets.insert(TypeKey::Scalar { leaf, depth }, ptr_off);
                write_uleb128(&mut body, ABBREV_POINTER_TYPE);
                body.push(8);
                body.extend_from_slice(&prev_off.to_le_bytes());
                prev_off = ptr_off;
            }
        }
        // Aggregate (struct / union) DIEs. Each carries
        // DW_TAG_member children referring back into the scalar
        // catalog above; nested-aggregate members get skipped
        // for now and surface without DW_AT_type.
        for (&id, &max_depth) in &max_depth_per_aggregate {
            let Some(sd) = program.structs.get(id) else {
                continue;
            };
            let off = body.len() as u32 + DEBUG_INFO_UNIT_HEADER_SIZE as u32;
            type_offsets.insert(TypeKey::Aggregate { id, depth: 0 }, off);
            let abbrev = if sd.is_union {
                ABBREV_UNION_TYPE
            } else {
                ABBREV_STRUCTURE_TYPE
            };
            write_uleb128(&mut body, abbrev);
            push_string(&mut body, &sd.name);
            write_uleb128(&mut body, sd.size as u64);
            for f in &sd.fields {
                let Some(TypeKey::Scalar { leaf, depth }) = decompose_pointer_chain(f.ty) else {
                    continue;
                };
                let Some(&field_type_off) = type_offsets.get(&TypeKey::Scalar { leaf, depth })
                else {
                    continue;
                };
                if f.bit_width > 0 {
                    // DWARF 4 5.6.6 bitfield: DW_AT_data_bit_offset
                    // is the absolute bit offset from the start of
                    // the aggregate. c5's StructField stores
                    // `offset` as the byte offset of the storage
                    // unit and `bit_offset` as the bit offset
                    // within that unit, so the absolute bit
                    // offset is `offset * 8 + bit_offset`.
                    let data_bit_offset = (f.offset as u64) * 8 + f.bit_offset as u64;
                    write_uleb128(&mut body, ABBREV_BITFIELD_MEMBER);
                    push_string(&mut body, &f.name);
                    body.extend_from_slice(&field_type_off.to_le_bytes());
                    write_uleb128(&mut body, data_bit_offset);
                    write_uleb128(&mut body, f.bit_width as u64);
                } else {
                    write_uleb128(&mut body, ABBREV_MEMBER);
                    push_string(&mut body, &f.name);
                    body.extend_from_slice(&field_type_off.to_le_bytes());
                    write_uleb128(&mut body, f.offset as u64);
                }
            }
            // End-of-children marker for the structure DIE.
            body.push(0);
            // Pointer wrappers for `Foo *`, `Foo **`, etc.
            let mut prev_off = off;
            for depth in 1..=max_depth {
                let ptr_off = body.len() as u32 + DEBUG_INFO_UNIT_HEADER_SIZE as u32;
                type_offsets.insert(TypeKey::Aggregate { id, depth }, ptr_off);
                write_uleb128(&mut body, ABBREV_POINTER_TYPE);
                body.push(8);
                body.extend_from_slice(&prev_off.to_le_bytes());
                prev_off = ptr_off;
            }
        }
    }

    // Subprogram child DIEs. One per defined function in the
    // unit. With parameters / variables present, the subprogram
    // takes the with-children abbrev (carries DW_AT_frame_base)
    // and ends in a null DIE terminator; otherwise the leaf
    // abbrev runs.
    for (i, &ent_pc) in build.func_ent_pcs.iter().enumerate() {
        let lo = match build.pc_to_native.get(ent_pc).copied() {
            Some(off) if off != usize::MAX => off as u64,
            _ => continue,
        };
        let hi = build
            .func_ent_pcs
            .get(i + 1)
            .and_then(|&next_ent| build.pc_to_native.get(next_ent).copied())
            .unwrap_or(build.text.len()) as u64;
        let size = hi.saturating_sub(lo);
        if size == 0 {
            continue;
        }
        let name = build
            .func_names
            .get(i)
            .map(|s| s.as_str())
            .filter(|s| !s.is_empty())
            .unwrap_or("<unknown>");
        // Group this function's parameters and locals out of the
        // flat program.variables list. `function_bc_pc` keys by
        // the function's ent_pc, matching what the amalg path's
        // DWARF emitter uses.
        let vars: Vec<&super::super::program::VariableInfo> = program
            .variables
            .iter()
            .filter(|v| v.function_bc_pc == ent_pc as u64)
            .collect();
        let has_children = !vars.is_empty();
        if has_children {
            write_uleb128(&mut body, ABBREV_SUBPROGRAM_WITH_CHILDREN);
        } else {
            write_uleb128(&mut body, ABBREV_SUBPROGRAM_LEAF);
        }
        push_string(&mut body, name);
        let low_pc_off = body.len() as u64;
        body.extend_from_slice(&[0u8; 8]);
        relocs.push(DwarfReloc {
            section: DwarfSectionKind::Info,
            offset: DEBUG_INFO_UNIT_HEADER_SIZE + low_pc_off,
            width: DwarfRelocWidth::W8,
            target: DwarfRelocTarget::Text,
            addend: lo as i64,
        });
        body.extend_from_slice(&size.to_le_bytes());
        if has_children {
            // DW_AT_frame_base: exprloc with a single
            // DW_OP_reg<fp> byte. ULEB128 length(1) + opcode.
            write_uleb128(&mut body, 1);
            body.push(frame_base_op);
            for v in &vars {
                let Some(key) = decompose_pointer_chain(v.type_tag) else {
                    continue;
                };
                let Some(&type_off) = type_offsets.get(&key) else {
                    continue;
                };
                let fp_byte_offset = fp_byte_offset_for_slot(v.fp_slot);
                let abbrev = if v.is_parameter {
                    ABBREV_FORMAL_PARAMETER
                } else {
                    ABBREV_VARIABLE
                };
                write_uleb128(&mut body, abbrev);
                push_string(&mut body, &v.name);
                // DW_AT_location: exprloc carrying DW_OP_fbreg
                // <SLEB128 offset>. Length prefix is the byte
                // count of the expression.
                let mut expr: Vec<u8> = Vec::with_capacity(8);
                expr.push(DW_OP_FBREG);
                write_sleb128(&mut expr, fp_byte_offset);
                write_uleb128(&mut body, expr.len() as u64);
                body.extend_from_slice(&expr);
                // DW_AT_type: DW_FORM_ref4 -- CU-relative byte
                // offset of the matching type DIE emitted above.
                body.extend_from_slice(&type_off.to_le_bytes());
            }
            // End-of-children marker for this subprogram.
            body.push(0);
        }
    }

    // DWARF 4 5.7.2: end-of-children marker for the CU's
    // DW_CHILDREN_yes DIE. Single null entry closes the sibling
    // list.
    body.push(0);

    // Unit header. `unit_length` covers everything after itself
    // (version + debug_abbrev_offset + address_size + body).
    let unit_length: u32 = (DEBUG_INFO_UNIT_HEADER_SIZE as u32 - 4) + body.len() as u32;
    let header = DebugInfoUnitHeader {
        unit_length,
        version: 4,
        debug_abbrev_offset: 0,
        address_size: 8,
    };
    let mut out: Vec<u8> = Vec::with_capacity(DEBUG_INFO_UNIT_HEADER_SIZE as usize + body.len());
    write_struct(&mut out, &header);
    // debug_abbrev_offset slot inside the header gets a reloc
    // against the `.debug_abbrev` section symbol; each `.o`'s
    // abbrev table starts at offset 0 inside its own
    // `.debug_abbrev`, so addend stays zero and the linker
    // rebases to the merged offset.
    relocs.push(DwarfReloc {
        section: DwarfSectionKind::Info,
        offset: 6, // unit_length(4) + version(2)
        width: DwarfRelocWidth::W4,
        target: DwarfRelocTarget::DebugAbbrev,
        addend: 0,
    });
    out.extend_from_slice(&body);

    (out, relocs)
}

// ---- .debug_line ----

fn build_debug_line(program: &Program, build: &Build) -> (Vec<u8>, Vec<DwarfReloc>) {
    // File table: DWARF 4 uses 1-based file indices. The CU's
    // primary file is index 1; every other entry the lexer
    // recorded follows. The `<source>` placeholder is the lexer's
    // pre-marker default and gets folded into entry 1.
    // Fixed-shape header prefix per DWARF 4 section 6.2.4.
    // `standard_opcode_lengths` carries the operand count for
    // each of the 12 DWARF 4 standard opcodes (DW_LNS_copy
    // through DW_LNS_set_isa); the table value matches
    // DWARF 4 Figure 38.
    let prog_header = DebugLineProgramHeader {
        minimum_instruction_length: 1,
        maximum_operations_per_instruction: 1,
        default_is_stmt: 1,
        line_base: LINE_BASE,
        line_range: LINE_RANGE,
        opcode_base: OPCODE_BASE,
        standard_opcode_lengths: [0, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 1],
    };
    let mut hdr: Vec<u8> = Vec::new();
    write_struct(&mut hdr, &prog_header);
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

    let unit_length: u32 =
        (DEBUG_LINE_UNIT_HEADER_SIZE as u32 - 4) + hdr.len() as u32 + prog.len() as u32;
    let header = DebugLineUnitHeader {
        unit_length,
        version: 4,
        header_length,
    };
    let mut out: Vec<u8> =
        Vec::with_capacity(DEBUG_LINE_UNIT_HEADER_SIZE as usize + hdr.len() + prog.len());
    write_struct(&mut out, &header);
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

/// c5's frame-slot index to native byte offset from the frame
/// pointer. Mirror of the amalg-path DWARF emitter: locals
/// (slot < 0) stride by 8 bytes; parameters (slot >= 2) stride
/// by 16 bytes starting at `(slot - 1) * 16` so slot 2 lands at
/// +16. Slots 0..2 are the saved-fp / saved-ret area and don't
/// carry user-visible values.
fn fp_byte_offset_for_slot(slot: i64) -> i64 {
    if slot >= 2 { (slot - 1) * 16 } else { slot * 8 }
}

/// Wire-form attributes for a DWARF base_type DIE.
struct BaseTypeDesc {
    name: &'static str,
    byte_size: u8,
    encoding: u8,
}

/// A type-catalog key: either a scalar leaf with pointer depth,
/// or a struct/union with id + pointer depth. The unsigned bit
/// stays bundled into the scalar leaf so signed / unsigned
/// variants get distinct entries.
#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
enum TypeKey {
    Scalar { leaf: i64, depth: u8 },
    Aggregate { id: usize, depth: u8 },
}

/// Split a c5 type tag into its catalog key. Mirror of the
/// amalg-path `classify` band layout: each non-integer scalar
/// type occupies a 100-wide band; pointer depth is encoded as
/// `bare_band_offset / Ty::Ptr`. The integer family shares the
/// `[0, 100)` band with even values for char and odd values for
/// int. Struct / union types live in the `[STRUCT_BASE,
/// STRUCT_BASE + N*STRUCT_STRIDE)` range with one band per
/// struct id.
fn decompose_pointer_chain(type_tag: i64) -> Option<TypeKey> {
    const UNSIGNED_BIT: i64 = 1 << 30;
    const TY_PTR: i64 = Ty::Ptr as i64;
    const BAND_SIZE: i64 = 100;
    const STRUCT_BASE: i64 = 1000;
    const STRUCT_STRIDE: i64 = 1000;
    let unsigned = (type_tag & UNSIGNED_BIT) != 0;
    let bare = type_tag & !UNSIGNED_BIT;
    if bare < 0 {
        return None;
    }
    // Struct / union band: identify the struct id by dividing
    // the band offset by the stride. Pointer depth is the
    // intra-band remainder over Ty::Ptr.
    if bare >= STRUCT_BASE {
        let band_off = bare - STRUCT_BASE;
        let id = (band_off / STRUCT_STRIDE) as usize;
        let depth_off = band_off % STRUCT_STRIDE;
        if depth_off % TY_PTR != 0 {
            return None;
        }
        let depth = (depth_off / TY_PTR) as u8;
        return Some(TypeKey::Aggregate { id, depth });
    }
    let (leaf, depth) = if bare < BAND_SIZE {
        let leaf = if bare % TY_PTR == 0 {
            Ty::Char as i64
        } else {
            Ty::Int as i64
        };
        (leaf, (bare / TY_PTR) as u8)
    } else if (Ty::Float as i64..Ty::Float as i64 + BAND_SIZE).contains(&bare) {
        (Ty::Float as i64, ((bare - Ty::Float as i64) / TY_PTR) as u8)
    } else if (Ty::Double as i64..Ty::Double as i64 + BAND_SIZE).contains(&bare) {
        (
            Ty::Double as i64,
            ((bare - Ty::Double as i64) / TY_PTR) as u8,
        )
    } else if (Ty::Long as i64..Ty::Long as i64 + BAND_SIZE).contains(&bare) {
        (Ty::Long as i64, ((bare - Ty::Long as i64) / TY_PTR) as u8)
    } else if (Ty::Short as i64..Ty::Short as i64 + BAND_SIZE).contains(&bare) {
        (Ty::Short as i64, ((bare - Ty::Short as i64) / TY_PTR) as u8)
    } else if (Ty::LongLong as i64..Ty::LongLong as i64 + BAND_SIZE).contains(&bare) {
        (
            Ty::LongLong as i64,
            ((bare - Ty::LongLong as i64) / TY_PTR) as u8,
        )
    } else {
        return None;
    };
    let leaf = if unsigned { leaf | UNSIGNED_BIT } else { leaf };
    Some(TypeKey::Scalar { leaf, depth })
}

/// Map a c5 leaf scalar type tag to its DWARF base_type
/// attributes. Returns `None` for struct types and any tag
/// outside the C99 scalar grid; the caller skips emitting a
/// type DIE for those (debugger falls back to raw bytes).
fn base_type_for_leaf(
    leaf: i64,
    _machine: super::Machine,
    target: super::Target,
) -> Option<BaseTypeDesc> {
    const UNSIGNED_BIT: i64 = 1 << 30;
    let unsigned = (leaf & UNSIGNED_BIT) != 0;
    let bare = leaf & !UNSIGNED_BIT;
    let desc = if bare == Ty::Char as i64 {
        BaseTypeDesc {
            name: if unsigned { "unsigned char" } else { "char" },
            byte_size: 1,
            encoding: if unsigned {
                DW_ATE_UNSIGNED_CHAR
            } else {
                DW_ATE_SIGNED_CHAR
            },
        }
    } else if bare == Ty::Short as i64 {
        BaseTypeDesc {
            name: if unsigned { "unsigned short" } else { "short" },
            byte_size: 2,
            encoding: if unsigned {
                DW_ATE_UNSIGNED
            } else {
                DW_ATE_SIGNED
            },
        }
    } else if bare == Ty::Int as i64 {
        BaseTypeDesc {
            name: if unsigned { "unsigned int" } else { "int" },
            byte_size: 4,
            encoding: if unsigned {
                DW_ATE_UNSIGNED
            } else {
                DW_ATE_SIGNED
            },
        }
    } else if bare == Ty::Long as i64 {
        // LP64 (Linux / macOS): `long` = 8 bytes. LLP64
        // (Windows): `long` = 4 bytes. Matches the c5
        // codegen's load/store width pick in `load_op_for` and
        // the amalg path's DWARF base_type emission.
        let byte_size = if target.is_windows() { 4 } else { 8 };
        BaseTypeDesc {
            name: if unsigned { "unsigned long" } else { "long" },
            byte_size,
            encoding: if unsigned {
                DW_ATE_UNSIGNED
            } else {
                DW_ATE_SIGNED
            },
        }
    } else if bare == Ty::Float as i64 {
        BaseTypeDesc {
            name: "float",
            byte_size: 4,
            encoding: DW_ATE_FLOAT,
        }
    } else if bare == Ty::Double as i64 {
        BaseTypeDesc {
            name: "double",
            byte_size: 8,
            encoding: DW_ATE_FLOAT,
        }
    } else {
        return None;
    };
    Some(desc)
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
