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
//! Each CU lays out its children in this order: type DIEs, enum
//! DIEs, objects with static storage duration, then subprograms.
//!
//! Type emission runs in two passes. [`TypeCatalog`] interns every
//! type the unit's locals, file-scope objects and aggregate members
//! reach, keyed structurally so `int *` shares one DIE across the
//! unit. Each interned node is then written into its own buffer with
//! its `DW_FORM_ref4` slots recorded, and the slots are patched once
//! the concatenated layout gives every DIE its CU-relative offset.
//! Because a reference is resolved after layout rather than at write
//! time, a member can name a type whose DIE lands later in the unit,
//! and no emission order can drop one.
//!
//! A type the catalog cannot describe becomes
//! `DW_TAG_unspecified_type` rather than the nearest type that can be
//! spelled: a member keeps its name and offset, and the description
//! reports the type as unknown instead of naming a different one.
//!
//! The `long` base type follows the C99 data model per target: 4
//! bytes on Windows (LLP64), 8 bytes on Linux / macOS (LP64).
//! Bitfield members carry `DW_AT_data_bit_offset` + `DW_AT_bit_size`.
//! `.debug_frame` regenerates from `synth_build`'s symbol set on the
//! merged image rather than being carried per-`.o`.

#![allow(dead_code)]

use alloc::collections::BTreeMap;
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use super::super::program::Program;
use super::super::token::Ty;
use super::Build;
use crate::c5::compiler::{StructDef, StructField};
use crate::c5::layout::write_struct;

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
    /// A defined object with static storage duration, by its index in
    /// [`DwarfRelocatable::reloc_symbols`]. The object writer resolves
    /// the name to its own symbol-table entry.
    Symbol(u32),
    /// A defined `_Thread_local` object, named the same way. The slot
    /// takes the object's offset within the module's thread block, not
    /// an address.
    ThreadLocalSymbol(u32),
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
/// The `Default` (all-empty) value is what a build without `-g`
/// produces, so the relocatable object carries no debug info.
#[derive(Default)]
pub(crate) struct DwarfRelocatable {
    pub debug_info: Vec<u8>,
    pub debug_abbrev: Vec<u8>,
    pub debug_line: Vec<u8>,
    pub info_relocs: Vec<DwarfReloc>,
    pub line_relocs: Vec<DwarfReloc>,
    /// Link names named by [`DwarfRelocTarget::Symbol`] relocs, in the
    /// order the emitter first referenced them.
    pub reloc_symbols: Vec<String>,
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
const DW_TAG_UNSPECIFIED_PARAMETERS: u8 = 0x18;
const DW_TAG_ARRAY_TYPE: u8 = 0x01;
const DW_TAG_SUBRANGE_TYPE: u8 = 0x21;
const DW_TAG_ENUMERATION_TYPE: u8 = 0x04;
const DW_TAG_ENUMERATOR: u8 = 0x28;
const DW_TAG_SUBROUTINE_TYPE: u8 = 0x15;
const DW_TAG_UNSPECIFIED_TYPE: u8 = 0x3b;

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
const DW_AT_EXTERNAL: u8 = 0x3f;
const DW_AT_DECL_LINE: u8 = 0x3b;
const DW_AT_DECL_FILE: u8 = 0x3a;
const DW_AT_PROTOTYPED: u8 = 0x27;
const DW_AT_CALLING_CONVENTION: u8 = 0x36;
const DW_CC_NORMAL: u8 = 0x01;
const DW_AT_UPPER_BOUND: u8 = 0x2f;
const DW_AT_CONST_VALUE: u8 = 0x1c;
const DW_AT_DECLARATION: u8 = 0x3c;

const DW_FORM_ADDR: u8 = 0x01;
const DW_FORM_DATA8: u8 = 0x07;
const DW_FORM_STRING: u8 = 0x08;
const DW_FORM_DATA1: u8 = 0x0b;
const DW_FORM_SEC_OFFSET: u8 = 0x17;
const DW_FORM_EXPRLOC: u8 = 0x18;
const DW_FORM_REF4: u8 = 0x13;
const DW_FORM_UDATA: u8 = 0x0f;
const DW_FORM_FLAG_PRESENT: u8 = 0x19;
const DW_FORM_SDATA: u8 = 0x0d;

// DW_ATE_* encoding values for DW_TAG_base_type.
const DW_ATE_SIGNED: u8 = 0x05;
const DW_ATE_UNSIGNED: u8 = 0x07;
const DW_ATE_SIGNED_CHAR: u8 = 0x06;
const DW_ATE_UNSIGNED_CHAR: u8 = 0x08;
const DW_ATE_BOOLEAN: u8 = 0x02;
const DW_ATE_FLOAT: u8 = 0x04;

const DW_OP_REG29: u8 = 0x6d; // aarch64 frame pointer x29
const DW_OP_REG6: u8 = 0x56; // x86_64 frame pointer rbp
const DW_OP_FBREG: u8 = 0x91; // fbreg N (SLEB128 N)
const DW_OP_ADDR: u8 = 0x03; // addr <target address size>
const DW_OP_CONST8U: u8 = 0x0e; // const8u <8-byte operand>
const DW_OP_GNU_PUSH_TLS_ADDRESS: u8 = 0xe0;

const DW_CHILDREN_NO: u8 = 0x00;
const DW_CHILDREN_YES: u8 = 0x01;

const DW_LANG_C99: u8 = 0x0c;

const DW_LNS_COPY: u8 = 0x01;
const DW_LNS_ADVANCE_PC: u8 = 0x02;
const DW_LNS_ADVANCE_LINE: u8 = 0x03;
const DW_LNS_SET_FILE: u8 = 0x04;
const DW_LNS_SET_PROLOGUE_END: u8 = 0x0a;
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
const ABBREV_UNSPECIFIED_PARAMETERS: u64 = 12;
const ABBREV_ARRAY_TYPE: u64 = 13;
const ABBREV_SUBRANGE_TYPE: u64 = 14;
const ABBREV_ENUMERATION_TYPE: u64 = 15;
const ABBREV_ENUMERATOR: u64 = 16;
const ABBREV_STRUCTURE_TYPE_ANON: u64 = 17;
const ABBREV_UNION_TYPE_ANON: u64 = 18;
const ABBREV_STRUCTURE_TYPE_DECL: u64 = 19;
const ABBREV_UNION_TYPE_DECL: u64 = 20;
const ABBREV_SUBROUTINE_TYPE: u64 = 21;
const ABBREV_SUBROUTINE_TYPE_VOID: u64 = 22;
const ABBREV_FORMAL_PARAMETER_TYPE: u64 = 23;
const ABBREV_SUBRANGE_TYPE_OPEN: u64 = 24;
const ABBREV_POINTER_TYPE_VOID: u64 = 25;
const ABBREV_UNSPECIFIED_TYPE: u64 = 26;
const ABBREV_STATIC_VARIABLE: u64 = 27;
const ABBREV_STATIC_VARIABLE_INTERNAL: u64 = 28;
const ABBREV_MEMBER_ANON: u64 = 29;
const ABBREV_SUBPROGRAM_LEAF_INTERNAL: u64 = 30;
const ABBREV_SUBPROGRAM_WITH_CHILDREN_INTERNAL: u64 = 31;
const ABBREV_TLS_VARIABLE: u64 = 32;
const ABBREV_TLS_VARIABLE_INTERNAL: u64 = 33;

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
    let (debug_info, info_relocs, reloc_symbols) =
        build_debug_info(source_path, program, build, machine, target);
    DwarfRelocatable {
        debug_info,
        debug_abbrev,
        debug_line,
        info_relocs,
        line_relocs,
        reloc_symbols,
    }
}

// ---- .debug_abbrev ----

/// One `.debug_abbrev` declaration: the abbreviation code, its DWARF
/// tag, whether the DIE has children, and the ordered (attribute,
/// form) pairs. `build_debug_abbrev` emits the table from this list
/// and `build_debug_info` writes each DIE's attribute values in the
/// same order under the same code, so the abbrev and the values
/// cannot drift.
struct AbbrevDecl {
    code: u64,
    tag: u8,
    has_children: bool,
    attrs: &'static [(u8, u8)],
}

const ABBREV_DECLS: &[AbbrevDecl] = &[
    // compile_unit with subprogram children.
    AbbrevDecl {
        code: ABBREV_CU,
        tag: DW_TAG_COMPILE_UNIT,
        has_children: true,
        attrs: &[
            (DW_AT_PRODUCER, DW_FORM_STRING),
            (DW_AT_LANGUAGE, DW_FORM_DATA1),
            (DW_AT_NAME, DW_FORM_STRING),
            (DW_AT_COMP_DIR, DW_FORM_STRING),
            (DW_AT_LOW_PC, DW_FORM_ADDR),
            (DW_AT_HIGH_PC, DW_FORM_DATA8),
            (DW_AT_STMT_LIST, DW_FORM_SEC_OFFSET),
        ],
    },
    // subprogram leaf -- name + extent only, for a function with no
    // variables. DW_AT_external (DW_FORM_flag_present) marks the name
    // visible outside the compilation unit (DWARF 4 3.3.1), which
    // C99 6.2.2p3 denies a `static` definition; the internal-linkage
    // form drops it. DW_AT_prototyped is always set: c5 rejects
    // K&R identifier-list declarators per C99 6.7.6.3p14.
    // DW_AT_calling_convention pins DW_CC_normal -- SysV / Win64 /
    // AAPCS64 are the C standard convention per DWARF 4 3.3.1.1.
    AbbrevDecl {
        code: ABBREV_SUBPROGRAM_LEAF,
        tag: DW_TAG_SUBPROGRAM,
        has_children: false,
        attrs: &[
            (DW_AT_NAME, DW_FORM_STRING),
            (DW_AT_LOW_PC, DW_FORM_ADDR),
            (DW_AT_HIGH_PC, DW_FORM_DATA8),
            (DW_AT_EXTERNAL, DW_FORM_FLAG_PRESENT),
            (DW_AT_PROTOTYPED, DW_FORM_FLAG_PRESENT),
            (DW_AT_CALLING_CONVENTION, DW_FORM_DATA1),
        ],
    },
    // subprogram with variable / parameter children. DW_AT_frame_base
    // resolves the fbreg offsets in the children's DW_AT_location.
    AbbrevDecl {
        code: ABBREV_SUBPROGRAM_WITH_CHILDREN,
        tag: DW_TAG_SUBPROGRAM,
        has_children: true,
        attrs: &[
            (DW_AT_NAME, DW_FORM_STRING),
            (DW_AT_LOW_PC, DW_FORM_ADDR),
            (DW_AT_HIGH_PC, DW_FORM_DATA8),
            (DW_AT_EXTERNAL, DW_FORM_FLAG_PRESENT),
            (DW_AT_PROTOTYPED, DW_FORM_FLAG_PRESENT),
            (DW_AT_CALLING_CONVENTION, DW_FORM_DATA1),
            (DW_AT_FRAME_BASE, DW_FORM_EXPRLOC),
        ],
    },
    AbbrevDecl {
        code: ABBREV_SUBPROGRAM_LEAF_INTERNAL,
        tag: DW_TAG_SUBPROGRAM,
        has_children: false,
        attrs: &[
            (DW_AT_NAME, DW_FORM_STRING),
            (DW_AT_LOW_PC, DW_FORM_ADDR),
            (DW_AT_HIGH_PC, DW_FORM_DATA8),
            (DW_AT_PROTOTYPED, DW_FORM_FLAG_PRESENT),
            (DW_AT_CALLING_CONVENTION, DW_FORM_DATA1),
        ],
    },
    AbbrevDecl {
        code: ABBREV_SUBPROGRAM_WITH_CHILDREN_INTERNAL,
        tag: DW_TAG_SUBPROGRAM,
        has_children: true,
        attrs: &[
            (DW_AT_NAME, DW_FORM_STRING),
            (DW_AT_LOW_PC, DW_FORM_ADDR),
            (DW_AT_HIGH_PC, DW_FORM_DATA8),
            (DW_AT_PROTOTYPED, DW_FORM_FLAG_PRESENT),
            (DW_AT_CALLING_CONVENTION, DW_FORM_DATA1),
            (DW_AT_FRAME_BASE, DW_FORM_EXPRLOC),
        ],
    },
    // formal_parameter -- name + fbreg location + DW_AT_type ref4 to
    // a type DIE earlier in the CU. DW_AT_decl_line gives the source
    // line of the declaration.
    AbbrevDecl {
        code: ABBREV_FORMAL_PARAMETER,
        tag: DW_TAG_FORMAL_PARAMETER,
        has_children: false,
        attrs: &[
            (DW_AT_NAME, DW_FORM_STRING),
            (DW_AT_LOCATION, DW_FORM_EXPRLOC),
            (DW_AT_TYPE, DW_FORM_REF4),
            (DW_AT_DECL_FILE, DW_FORM_UDATA),
            (DW_AT_DECL_LINE, DW_FORM_UDATA),
        ],
    },
    // variable -- formal_parameter's shape under DW_TAG_variable so
    // debuggers distinguish locals from arguments.
    AbbrevDecl {
        code: ABBREV_VARIABLE,
        tag: DW_TAG_VARIABLE,
        has_children: false,
        attrs: &[
            (DW_AT_NAME, DW_FORM_STRING),
            (DW_AT_LOCATION, DW_FORM_EXPRLOC),
            (DW_AT_TYPE, DW_FORM_REF4),
            (DW_AT_DECL_FILE, DW_FORM_UDATA),
            (DW_AT_DECL_LINE, DW_FORM_UDATA),
        ],
    },
    // base_type -- name + byte_size + DWARF encoding (DW_ATE_*) for
    // every C99 scalar.
    AbbrevDecl {
        code: ABBREV_BASE_TYPE,
        tag: DW_TAG_BASE_TYPE,
        has_children: false,
        attrs: &[
            (DW_AT_NAME, DW_FORM_STRING),
            (DW_AT_BYTE_SIZE, DW_FORM_DATA1),
            (DW_AT_ENCODING, DW_FORM_DATA1),
        ],
    },
    // pointer_type -- 8-byte pointer wrapping a referenced type DIE.
    // C99 6.2.5p20 leaves pointer size implementation-defined; c5
    // uses 8 bytes everywhere.
    AbbrevDecl {
        code: ABBREV_POINTER_TYPE,
        tag: DW_TAG_POINTER_TYPE,
        has_children: false,
        attrs: &[(DW_AT_BYTE_SIZE, DW_FORM_DATA1), (DW_AT_TYPE, DW_FORM_REF4)],
    },
    // structure_type -- name + byte_size; carries DW_TAG_member
    // children terminated by a null DIE.
    AbbrevDecl {
        code: ABBREV_STRUCTURE_TYPE,
        tag: DW_TAG_STRUCTURE_TYPE,
        has_children: true,
        attrs: &[
            (DW_AT_NAME, DW_FORM_STRING),
            (DW_AT_BYTE_SIZE, DW_FORM_UDATA),
        ],
    },
    // union_type -- structure_type's payload with members at offset 0.
    AbbrevDecl {
        code: ABBREV_UNION_TYPE,
        tag: DW_TAG_UNION_TYPE,
        has_children: true,
        attrs: &[
            (DW_AT_NAME, DW_FORM_STRING),
            (DW_AT_BYTE_SIZE, DW_FORM_UDATA),
        ],
    },
    // structure / union member -- name + type ref4 + byte offset from
    // the start of the aggregate.
    AbbrevDecl {
        code: ABBREV_MEMBER,
        tag: DW_TAG_MEMBER,
        has_children: false,
        attrs: &[
            (DW_AT_NAME, DW_FORM_STRING),
            (DW_AT_TYPE, DW_FORM_REF4),
            (DW_AT_DATA_MEMBER_LOCATION, DW_FORM_UDATA),
        ],
    },
    // The unnamed member C11 6.7.2.1p13 gives an anonymous struct or
    // union. DWARF 4 5.5.3: no DW_AT_name, and the type names the
    // anonymous aggregate whose members the enclosing scope sees.
    AbbrevDecl {
        code: ABBREV_MEMBER_ANON,
        tag: DW_TAG_MEMBER,
        has_children: false,
        attrs: &[
            (DW_AT_TYPE, DW_FORM_REF4),
            (DW_AT_DATA_MEMBER_LOCATION, DW_FORM_UDATA),
        ],
    },
    // bitfield member -- name + type ref4 + DWARF 4
    // DW_AT_data_bit_offset (absolute bit offset from the aggregate
    // start) + DW_AT_bit_size (bit width).
    AbbrevDecl {
        code: ABBREV_BITFIELD_MEMBER,
        tag: DW_TAG_MEMBER,
        has_children: false,
        attrs: &[
            (DW_AT_NAME, DW_FORM_STRING),
            (DW_AT_TYPE, DW_FORM_REF4),
            (DW_AT_DATA_BIT_OFFSET, DW_FORM_UDATA),
            (DW_AT_BIT_SIZE, DW_FORM_UDATA),
        ],
    },
    // unspecified_parameters -- the `...` of a variadic prototype
    // (DWARF 4 3.4.2). The tag alone signals trailing varargs.
    AbbrevDecl {
        code: ABBREV_UNSPECIFIED_PARAMETERS,
        tag: DW_TAG_UNSPECIFIED_PARAMETERS,
        has_children: false,
        attrs: &[],
    },
    // array_type -- DW_AT_type refs the element type DIE; the
    // DW_TAG_subrange_type child carries the bound.
    AbbrevDecl {
        code: ABBREV_ARRAY_TYPE,
        tag: DW_TAG_ARRAY_TYPE,
        has_children: true,
        attrs: &[(DW_AT_TYPE, DW_FORM_REF4)],
    },
    // subrange_type -- DWARF 4 5.13: one array dimension.
    // DW_AT_upper_bound is the last in-bounds index (count - 1).
    AbbrevDecl {
        code: ABBREV_SUBRANGE_TYPE,
        tag: DW_TAG_SUBRANGE_TYPE,
        has_children: false,
        attrs: &[(DW_AT_UPPER_BOUND, DW_FORM_UDATA)],
    },
    // enumeration_type -- a tagged enum (C99 6.7.2.2). Children are
    // DW_TAG_enumerator DIEs; the enum is `int` in c5 so byte_size 4.
    AbbrevDecl {
        code: ABBREV_ENUMERATION_TYPE,
        tag: DW_TAG_ENUMERATION_TYPE,
        has_children: true,
        attrs: &[
            (DW_AT_NAME, DW_FORM_STRING),
            (DW_AT_BYTE_SIZE, DW_FORM_DATA1),
        ],
    },
    // enumerator -- one (name, value) pair. DW_AT_const_value is
    // signed since C99 enum constants can be negative.
    AbbrevDecl {
        code: ABBREV_ENUMERATOR,
        tag: DW_TAG_ENUMERATOR,
        has_children: false,
        attrs: &[
            (DW_AT_NAME, DW_FORM_STRING),
            (DW_AT_CONST_VALUE, DW_FORM_SDATA),
        ],
    },
    // structure / union with no source tag (C99 6.7.2.3). DWARF 4
    // 5.5.1 gives such a type no DW_AT_name; c5's registry key is a
    // synthesized spelling that carries a parse-order serial and so
    // names the same type differently in two units.
    AbbrevDecl {
        code: ABBREV_STRUCTURE_TYPE_ANON,
        tag: DW_TAG_STRUCTURE_TYPE,
        has_children: true,
        attrs: &[(DW_AT_BYTE_SIZE, DW_FORM_UDATA)],
    },
    AbbrevDecl {
        code: ABBREV_UNION_TYPE_ANON,
        tag: DW_TAG_UNION_TYPE,
        has_children: true,
        attrs: &[(DW_AT_BYTE_SIZE, DW_FORM_UDATA)],
    },
    // structure / union the unit only forward-declares (C99 6.7.2.3
    // incomplete type). DWARF 4 5.5.1: DW_AT_declaration and no
    // DW_AT_byte_size, so a consumer reads the size as unknown rather
    // than as zero.
    AbbrevDecl {
        code: ABBREV_STRUCTURE_TYPE_DECL,
        tag: DW_TAG_STRUCTURE_TYPE,
        has_children: false,
        attrs: &[
            (DW_AT_NAME, DW_FORM_STRING),
            (DW_AT_DECLARATION, DW_FORM_FLAG_PRESENT),
        ],
    },
    AbbrevDecl {
        code: ABBREV_UNION_TYPE_DECL,
        tag: DW_TAG_UNION_TYPE,
        has_children: false,
        attrs: &[
            (DW_AT_NAME, DW_FORM_STRING),
            (DW_AT_DECLARATION, DW_FORM_FLAG_PRESENT),
        ],
    },
    // subroutine_type -- the pointee of a function pointer (DWARF 4
    // 5.7). DW_AT_type is the return type; the void-returning form
    // omits it. DW_AT_prototyped is always set (c5 rejects K&R
    // identifier lists). Children are the parameter types.
    AbbrevDecl {
        code: ABBREV_SUBROUTINE_TYPE,
        tag: DW_TAG_SUBROUTINE_TYPE,
        has_children: true,
        attrs: &[
            (DW_AT_PROTOTYPED, DW_FORM_FLAG_PRESENT),
            (DW_AT_TYPE, DW_FORM_REF4),
        ],
    },
    AbbrevDecl {
        code: ABBREV_SUBROUTINE_TYPE_VOID,
        tag: DW_TAG_SUBROUTINE_TYPE,
        has_children: true,
        attrs: &[(DW_AT_PROTOTYPED, DW_FORM_FLAG_PRESENT)],
    },
    // formal_parameter of a subroutine_type: a type with no name and
    // no location, since a function type has no storage.
    AbbrevDecl {
        code: ABBREV_FORMAL_PARAMETER_TYPE,
        tag: DW_TAG_FORMAL_PARAMETER,
        has_children: false,
        attrs: &[(DW_AT_TYPE, DW_FORM_REF4)],
    },
    // subrange with no bound -- the unspecified extent of a flexible
    // array member (C99 6.7.2.1p16) and of the GNU zero-length form.
    AbbrevDecl {
        code: ABBREV_SUBRANGE_TYPE_OPEN,
        tag: DW_TAG_SUBRANGE_TYPE,
        has_children: false,
        attrs: &[],
    },
    // `void *` -- DWARF 4 5.2 spells an untyped pointer as a
    // pointer_type with no DW_AT_type.
    AbbrevDecl {
        code: ABBREV_POINTER_TYPE_VOID,
        tag: DW_TAG_POINTER_TYPE,
        has_children: false,
        attrs: &[(DW_AT_BYTE_SIZE, DW_FORM_DATA1)],
    },
    // unspecified_type (DWARF 4 5.2) -- the target of a member whose
    // type this emitter cannot describe. The member keeps its name and
    // offset and the description says the type is unknown instead of
    // naming a different one.
    AbbrevDecl {
        code: ABBREV_UNSPECIFIED_TYPE,
        tag: DW_TAG_UNSPECIFIED_TYPE,
        has_children: false,
        attrs: &[],
    },
    // Object with static storage duration (C99 6.2.4p3), at compile-unit
    // scope. DW_AT_location is an exprloc holding DW_OP_addr over the
    // object's link-time address. DW_AT_external marks external linkage;
    // the internal-linkage form drops it.
    AbbrevDecl {
        code: ABBREV_STATIC_VARIABLE,
        tag: DW_TAG_VARIABLE,
        has_children: false,
        attrs: &[
            (DW_AT_NAME, DW_FORM_STRING),
            (DW_AT_TYPE, DW_FORM_REF4),
            (DW_AT_EXTERNAL, DW_FORM_FLAG_PRESENT),
            (DW_AT_LOCATION, DW_FORM_EXPRLOC),
            (DW_AT_DECL_FILE, DW_FORM_UDATA),
            (DW_AT_DECL_LINE, DW_FORM_UDATA),
        ],
    },
    AbbrevDecl {
        code: ABBREV_STATIC_VARIABLE_INTERNAL,
        tag: DW_TAG_VARIABLE,
        has_children: false,
        attrs: &[
            (DW_AT_NAME, DW_FORM_STRING),
            (DW_AT_TYPE, DW_FORM_REF4),
            (DW_AT_LOCATION, DW_FORM_EXPRLOC),
            (DW_AT_DECL_FILE, DW_FORM_UDATA),
            (DW_AT_DECL_LINE, DW_FORM_UDATA),
        ],
    },
    // `_Thread_local` object whose address the unit cannot spell: the
    // name and type resolve, and the location is left out rather than
    // given an expression that names the wrong storage. Same shape
    // gcc and clang emit for a thread-local on aarch64.
    AbbrevDecl {
        code: ABBREV_TLS_VARIABLE,
        tag: DW_TAG_VARIABLE,
        has_children: false,
        attrs: &[
            (DW_AT_NAME, DW_FORM_STRING),
            (DW_AT_TYPE, DW_FORM_REF4),
            (DW_AT_EXTERNAL, DW_FORM_FLAG_PRESENT),
            (DW_AT_DECL_FILE, DW_FORM_UDATA),
            (DW_AT_DECL_LINE, DW_FORM_UDATA),
        ],
    },
    AbbrevDecl {
        code: ABBREV_TLS_VARIABLE_INTERNAL,
        tag: DW_TAG_VARIABLE,
        has_children: false,
        attrs: &[
            (DW_AT_NAME, DW_FORM_STRING),
            (DW_AT_TYPE, DW_FORM_REF4),
            (DW_AT_DECL_FILE, DW_FORM_UDATA),
            (DW_AT_DECL_LINE, DW_FORM_UDATA),
        ],
    },
];

fn build_debug_abbrev() -> Vec<u8> {
    let mut out = Vec::new();
    for d in ABBREV_DECLS {
        write_uleb128(&mut out, d.code);
        out.push(d.tag);
        out.push(if d.has_children {
            DW_CHILDREN_YES
        } else {
            DW_CHILDREN_NO
        });
        for (name, form) in d.attrs {
            push_attr(&mut out, *name, *form);
        }
        // End of this declaration's attribute list.
        out.push(0);
        out.push(0);
    }
    // End of the abbrev table.
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
) -> (Vec<u8>, Vec<DwarfReloc>, Vec<String>) {
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

    // Type DIEs. Every type this unit references is interned into a
    // catalog first; the DIEs are then written into per-DIE buffers,
    // laid out, and their `DW_AT_type` slots patched with the
    // resulting CU-relative offsets. Separating layout from writing
    // is what lets a member name a type whose DIE lands later in the
    // unit, so no member is dropped for want of an emission order.
    let mut catalog = TypeCatalog::new(&program.structs, target);
    let var_types: Vec<TypeId> = program
        .variables
        .iter()
        .map(|v| catalog.of_variable(v))
        .collect();
    let statics = static_storage_objects(program);
    let static_types: Vec<TypeId> = statics
        .iter()
        .map(|&i| catalog.of_symbol(&program.symbols[i]))
        .collect();
    catalog.drain();
    let mut dies: Vec<DieBuf> = Vec::new();
    let mut next = 0usize;
    while next < catalog.len() {
        let node = catalog.node(next).clone();
        dies.push(build_type_die(&mut catalog, &node));
        next += 1;
    }
    let type_offsets: Vec<u32> = {
        let mut offs = Vec::with_capacity(dies.len());
        let mut cur = body.len() as u32 + DEBUG_INFO_UNIT_HEADER_SIZE as u32;
        for d in &dies {
            offs.push(cur);
            cur += d.bytes.len() as u32;
        }
        offs
    };
    for die in &mut dies {
        let DieBuf { bytes, refs } = die;
        for &(at, id) in refs.iter() {
            bytes[at..at + 4].copy_from_slice(&type_offsets[id].to_le_bytes());
        }
        body.extend_from_slice(bytes);
    }

    // DW_TAG_enumeration_type DIEs for every tagged enum the
    // parser captured. Standalone definitions -- no variable
    // references them at the type level because c5 collapses
    // enums to `int`, but the DIE still lets `(gdb) ptype enum
    // Tag` resolve the named constants.
    for ed in &program.enums {
        if ed.name.is_empty() || ed.constants.is_empty() {
            continue;
        }
        write_uleb128(&mut body, ABBREV_ENUMERATION_TYPE);
        push_string(&mut body, &ed.name);
        body.push(ed.byte_size());
        for (cname, cval) in &ed.constants {
            write_uleb128(&mut body, ABBREV_ENUMERATOR);
            push_string(&mut body, cname);
            write_sleb128(&mut body, *cval);
        }
        // End-of-children marker for the enumeration_type DIE.
        body.push(0);
    }

    // DW_TAG_variable DIEs for objects with static storage duration
    // (C99 6.2.4p3), at compile-unit scope. `DW_OP_addr` needs the
    // object's link-time address, which the relocation supplies.
    let mut reloc_symbols: Vec<String> = Vec::new();
    for (&idx, &type_id) in statics.iter().zip(static_types.iter()) {
        let sym = &program.symbols[idx];
        let external = sym.linkage == crate::c5::symbol::Linkage::External;
        // A thread-local's location is its offset in the thread block,
        // which needs a module-relative TLS relocation. Only the ELF
        // x86_64 surface has one both linkers resolve, matching what
        // gcc and clang describe per target; elsewhere the object gets
        // its name and type and no location. The 8-byte offset slot is
        // ELFCLASS64's; i386 spells the relocation 4 bytes wide.
        let tls_location =
            sym.is_thread_local && target == super::Target::LinuxX64 && !build.elf_class.is32();
        let located = !sym.is_thread_local || tls_location;
        write_uleb128(
            &mut body,
            match (located, external) {
                (true, true) => ABBREV_STATIC_VARIABLE,
                (true, false) => ABBREV_STATIC_VARIABLE_INTERNAL,
                (false, true) => ABBREV_TLS_VARIABLE,
                (false, false) => ABBREV_TLS_VARIABLE_INTERNAL,
            },
        );
        push_string(&mut body, &sym.name);
        body.extend_from_slice(&type_offsets[type_id].to_le_bytes());
        if located {
            // DW_AT_location: exprloc holding the address form plus an
            // 8-byte slot the reloc below fills in. A thread-local
            // pushes its thread-block offset and lets the consumer add
            // the thread pointer (DWARF 4 2.5.1 vendor extension
            // DW_OP_GNU_push_tls_address).
            write_uleb128(&mut body, if tls_location { 10 } else { 9 });
            body.push(if tls_location {
                DW_OP_CONST8U
            } else {
                DW_OP_ADDR
            });
            let addr_off = body.len() as u64;
            body.extend_from_slice(&[0u8; 8]);
            if tls_location {
                body.push(DW_OP_GNU_PUSH_TLS_ADDRESS);
            }
            let sym_idx = reloc_symbols.len() as u32;
            reloc_symbols.push(sym.link_name().to_string());
            relocs.push(DwarfReloc {
                section: DwarfSectionKind::Info,
                offset: DEBUG_INFO_UNIT_HEADER_SIZE + addr_off,
                width: DwarfRelocWidth::W8,
                target: if tls_location {
                    DwarfRelocTarget::ThreadLocalSymbol(sym_idx)
                } else {
                    DwarfRelocTarget::Symbol(sym_idx)
                },
                addend: 0,
            });
        }
        // `source_files` is 0-indexed with the primary unit at 0; the
        // DWARF file table is 1-indexed with it at slot 1.
        write_uleb128(&mut body, sym.decl_file as u64 + 1);
        write_uleb128(&mut body, sym.decl_line as u64);
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
        // Prototype and linkage come from the matching `Token::Fun`
        // entry. A missing entry means non-variadic and external: a
        // function this unit defines always has one, and only a
        // `static` definition denies the name to other units
        // (C99 6.2.2p3).
        let fn_sym = program
            .symbols
            .iter()
            .find(|s| s.class == super::super::token::Token::Fun as i64 && s.link_name() == name);
        let is_variadic = fn_sym.is_some_and(|s| s.is_variadic);
        let external = fn_sym.is_none_or(|s| s.linkage != crate::c5::symbol::Linkage::Internal);
        // Group this function's parameters and locals out of the
        // flat program.variables list. `function_bc_pc` keys by
        // the function's ent_pc, matching what the amalg path's
        // DWARF emitter uses.
        let vars: Vec<(&super::super::program::VariableInfo, TypeId)> = program
            .variables
            .iter()
            .zip(var_types.iter().copied())
            .filter(|(v, _)| v.function_bc_pc == ent_pc as u64)
            .collect();
        // A variadic function always needs the WITH_CHILDREN
        // abbrev so the trailing DW_TAG_unspecified_parameters DIE
        // has somewhere to live.
        let has_children = !vars.is_empty() || is_variadic;
        write_uleb128(
            &mut body,
            match (has_children, external) {
                (true, true) => ABBREV_SUBPROGRAM_WITH_CHILDREN,
                (true, false) => ABBREV_SUBPROGRAM_WITH_CHILDREN_INTERNAL,
                (false, true) => ABBREV_SUBPROGRAM_LEAF,
                (false, false) => ABBREV_SUBPROGRAM_LEAF_INTERNAL,
            },
        );
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
        // DW_AT_calling_convention -- c5's user-defined functions
        // all use the host C ABI; debuggers treat that as
        // DW_CC_normal.
        body.push(DW_CC_NORMAL);
        if has_children {
            // DW_AT_frame_base: exprloc with a single
            // DW_OP_reg<fp> byte. ULEB128 length(1) + opcode.
            write_uleb128(&mut body, 1);
            body.push(frame_base_op);
            for &(v, type_id) in &vars {
                let type_off = type_offsets[type_id];
                // Slot coalescing may have moved this local onto a new
                // exclusive frame offset; use it so the location is not
                // stale. A local moved onto shared storage is in
                // `promoted_local_slots` and gets an empty location below.
                let eff = build
                    .coalesced_slot_remap
                    .get(&ent_pc)
                    .and_then(|m| m.get(&v.fp_slot))
                    .copied()
                    .unwrap_or(v.fp_slot);
                let fp_byte_offset = fp_byte_offset_for_slot(eff);
                let abbrev = if v.is_parameter {
                    ABBREV_FORMAL_PARAMETER
                } else {
                    ABBREV_VARIABLE
                };
                write_uleb128(&mut body, abbrev);
                push_string(&mut body, &v.name);
                // DW_AT_location: exprloc carrying DW_OP_fbreg
                // <SLEB128 offset>. Length prefix is the byte
                // count of the expression. A slot mem2reg promoted to
                // a register no longer holds the value, so emit an
                // empty location (zero-length exprloc) -- the debugger
                // reports the variable optimized out instead of
                // reading stale frame memory.
                let promoted = build
                    .promoted_local_slots
                    .get(&ent_pc)
                    .is_some_and(|slots| slots.contains(&v.fp_slot));
                if promoted {
                    write_uleb128(&mut body, 0);
                } else {
                    let mut expr: Vec<u8> = Vec::with_capacity(8);
                    expr.push(DW_OP_FBREG);
                    write_sleb128(&mut expr, fp_byte_offset);
                    write_uleb128(&mut body, expr.len() as u64);
                    body.extend_from_slice(&expr);
                }
                // DW_AT_type: DW_FORM_ref4 -- CU-relative byte
                // offset of the matching type DIE emitted above.
                body.extend_from_slice(&type_off.to_le_bytes());
                // DW_AT_decl_file (ULEB128) -- c5's `source_files`
                // is 0-indexed (0 = primary TU, headers at 1+);
                // DWARF file_names is 1-indexed with the primary
                // file at slot 1, so emit `decl_file + 1`.
                write_uleb128(&mut body, v.decl_file as u64 + 1);
                // DW_AT_decl_line (ULEB128).
                write_uleb128(&mut body, v.decl_line as u64);
            }
            // DWARF 4 section 3.4.2: trailing `...` of a variadic
            // prototype becomes a DW_TAG_unspecified_parameters
            // child after the formal-parameter siblings.
            if is_variadic {
                write_uleb128(&mut body, ABBREV_UNSPECIFIED_PARAMETERS);
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

    (out, relocs, reloc_symbols)
}

/// Indices in `program.symbols` of the objects with static storage
/// duration this unit defines, in declaration order. Mirrors the
/// relocatable writer's own selection so every DIE emitted here has a
/// symbol-table entry to relocate against: an alias names another
/// object's storage, and one link name reaches the writer only once.
/// A `_Thread_local` object (C11 6.2.4p4) is included; its location is
/// a thread-block offset rather than a `DW_OP_addr` address.
fn static_storage_objects(program: &Program) -> Vec<usize> {
    use crate::c5::symbol::Linkage;
    use crate::c5::token::Token;
    let mut seen: alloc::collections::BTreeSet<&str> = alloc::collections::BTreeSet::new();
    let mut out = Vec::new();
    for (i, sym) in program.symbols.iter().enumerate() {
        if sym.class != Token::Glo as i64
            || !sym.defined_here
            || sym.name.is_empty()
            || sym.is_alias
            || !matches!(sym.linkage, Linkage::External | Linkage::Internal)
        {
            continue;
        }
        if seen.insert(sym.link_name()) {
            out.push(i);
        }
    }
    out
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
    // True once a function-entry synthetic row has fired but the
    // matching post-prologue source row hasn't landed yet. The next
    // emit_row that materialises a COPY stamps DW_LNS_set_prologue_end
    // first so debuggers land "break main" past the prologue per
    // DWARF 4 section 6.2.5.3.
    let mut prologue_end_pending = false;

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
                false,
            );
            func_start_iter.next();
            prologue_end_pending = true;
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
            prologue_end_pending,
        );
        prologue_end_pending = false;
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
    mark_prologue_end: bool,
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
        if mark_prologue_end {
            buf.push(DW_LNS_SET_PROLOGUE_END);
        }
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

/// Index of a type DIE within the per-unit catalog.
type TypeId = usize;

/// One type DIE in a form independent of emission order: every
/// `DW_AT_type` reference is a [`TypeId`] the layout pass turns into a
/// CU-relative offset, so a member can name a type whose DIE is
/// written later in the unit.
#[derive(Clone, PartialEq, Eq, PartialOrd, Ord)]
enum TypeNode {
    /// C99 scalar, keyed by the leaf tag with its unsigned marker.
    Base(i64),
    /// `DW_TAG_pointer_type`. `None` is `void *`, which DWARF 4 5.2
    /// spells as a pointer with no `DW_AT_type`.
    Pointer(Option<TypeId>),
    /// Struct / union whose definition this unit has.
    Aggregate(usize),
    /// Struct / union the unit only forward-declares (C99 6.7.2.3).
    Declaration(usize),
    /// `DW_TAG_array_type`, one `DW_TAG_subrange_type` child per
    /// dimension, outermost first. A negative bound is unspecified.
    Array { elem: TypeId, dims: Vec<i64> },
    /// `DW_TAG_subroutine_type` -- the pointee of a function pointer.
    /// `ret` is `None` for a void-returning function.
    Subroutine {
        ret: Option<TypeId>,
        params: Vec<TypeId>,
        variadic: bool,
    },
    /// `DW_TAG_unspecified_type` (DWARF 4 5.2): a type this emitter
    /// cannot describe. A member keeps its name and offset and the
    /// description reports the type as unknown rather than naming a
    /// different one.
    Unspecified,
}

/// One DIE (with its children) as bytes, plus the byte offsets of its
/// `DW_FORM_ref4` slots and the type each names. The layout pass
/// resolves the slots once every DIE's size is known.
struct DieBuf {
    bytes: Vec<u8>,
    refs: Vec<(usize, TypeId)>,
}

impl DieBuf {
    fn new() -> Self {
        DieBuf {
            bytes: Vec::new(),
            refs: Vec::new(),
        }
    }

    /// Reserve a `DW_FORM_ref4` slot naming `id`.
    fn push_ref(&mut self, id: TypeId) {
        self.refs.push((self.bytes.len(), id));
        self.bytes.extend_from_slice(&[0u8; 4]);
    }
}

/// Interned type DIEs for one compilation unit. Interning is
/// structural, so `int *` on ten members shares one DIE.
struct TypeCatalog<'a> {
    structs: &'a [StructDef],
    target: super::Target,
    nodes: Vec<TypeNode>,
    index: BTreeMap<TypeNode, TypeId>,
    /// Aggregates interned but whose members have not been walked.
    pending: Vec<usize>,
}

impl<'a> TypeCatalog<'a> {
    fn new(structs: &'a [StructDef], target: super::Target) -> Self {
        TypeCatalog {
            structs,
            target,
            nodes: Vec::new(),
            index: BTreeMap::new(),
            pending: Vec::new(),
        }
    }

    fn len(&self) -> usize {
        self.nodes.len()
    }

    fn node(&self, id: TypeId) -> &TypeNode {
        &self.nodes[id]
    }

    fn intern(&mut self, node: TypeNode) -> TypeId {
        if let Some(&id) = self.index.get(&node) {
            return id;
        }
        let id = self.nodes.len();
        self.nodes.push(node.clone());
        self.index.insert(node, id);
        id
    }

    fn unspecified(&mut self) -> TypeId {
        self.intern(TypeNode::Unspecified)
    }

    fn pointer_chain(&mut self, base: TypeId, depth: u8) -> TypeId {
        let mut cur = base;
        for _ in 0..depth {
            cur = self.intern(TypeNode::Pointer(Some(cur)));
        }
        cur
    }

    /// Walk the members of every aggregate interned so far, which
    /// interns the types they reach. Runs to fixpoint; a cycle
    /// terminates because an aggregate is queued only when its DIE is
    /// first interned.
    fn drain(&mut self) {
        while let Some(id) = self.pending.pop() {
            let structs = self.structs;
            let Some(sd) = structs.get(id) else { continue };
            for m in member_plan(structs, sd) {
                match m {
                    MemberPlan::Field(i) => {
                        self.of_field(&sd.fields[i]);
                    }
                    MemberPlan::Anonymous { id, .. } => {
                        self.of_aggregate(id);
                    }
                }
            }
        }
    }

    fn of_key(&mut self, key: TypeKey) -> TypeId {
        match key {
            TypeKey::Scalar { leaf, depth } => {
                if crate::c5::compiler::types::is_void_ty(leaf) {
                    // `void` itself has no DIE; the shallowest pointer
                    // over it is the untyped `void *`.
                    if depth == 0 {
                        return self.unspecified();
                    }
                    let mut cur = self.intern(TypeNode::Pointer(None));
                    for _ in 1..depth {
                        cur = self.intern(TypeNode::Pointer(Some(cur)));
                    }
                    return cur;
                }
                let base = match base_type_for_leaf(leaf, self.target) {
                    Some(_) => self.intern(TypeNode::Base(leaf)),
                    None => self.unspecified(),
                };
                self.pointer_chain(base, depth)
            }
            TypeKey::Aggregate { id, depth } => {
                let base = self.of_aggregate(id);
                self.pointer_chain(base, depth)
            }
        }
    }

    fn of_tag(&mut self, tag: i64) -> TypeId {
        match decompose_pointer_chain(tag) {
            Some(key) => self.of_key(key),
            None => self.unspecified(),
        }
    }

    fn of_aggregate(&mut self, id: usize) -> TypeId {
        let structs = self.structs;
        let Some(sd) = structs.get(id) else {
            return self.unspecified();
        };
        // The pointer-to-array carrier is an array type, not an
        // aggregate: it exists only to give `T (*)[N]` a type id and
        // holds one array field of the element type.
        if sd.is_array && sd.fields.len() == 1 {
            let f = &sd.fields[0];
            let elem = self.of_tag(f.ty);
            let dims = array_dims(f.array_size, &f.array_dims);
            return self.intern(TypeNode::Array { elem, dims });
        }
        if !sd.is_complete {
            return self.intern(TypeNode::Declaration(id));
        }
        let node = TypeNode::Aggregate(id);
        let fresh = !self.index.contains_key(&node);
        let tid = self.intern(node);
        if fresh {
            self.pending.push(id);
        }
        tid
    }

    /// The type of an aggregate member: a function pointer resolves
    /// through its own `DW_TAG_subroutine_type`, an array member
    /// through a `DW_TAG_array_type` over the element type.
    fn of_field(&mut self, f: &StructField) -> TypeId {
        let base = if f.fn_ptr_indirection >= 1 {
            self.of_function_pointer(f.ty, f.fn_ptr_indirection, &f.params, f.is_variadic)
        } else {
            self.of_tag(f.ty)
        };
        let dims = array_dims(f.array_size, &f.array_dims);
        if dims.is_empty() {
            base
        } else {
            self.intern(TypeNode::Array { elem: base, dims })
        }
    }

    /// The type of an object with static storage duration.
    fn of_symbol(&mut self, sym: &crate::c5::symbol::Symbol) -> TypeId {
        let base = if sym.fn_ptr_indirection >= 1 {
            self.of_function_pointer(
                sym.type_,
                sym.fn_ptr_indirection,
                &sym.params,
                sym.is_variadic,
            )
        } else {
            self.of_tag(sym.type_)
        };
        let dims = array_dims(sym.array_size, &sym.array_dims);
        if dims.is_empty() {
            base
        } else {
            self.intern(TypeNode::Array { elem: base, dims })
        }
    }

    /// The type of a local or parameter. C99 6.7.5.3p7 decays a
    /// parameter array to a pointer, so only a true local contributes
    /// an array type.
    fn of_variable(&mut self, v: &super::super::program::VariableInfo) -> TypeId {
        let base = if v.fn_ptr_indirection >= 1 {
            self.of_function_pointer(v.type_tag, v.fn_ptr_indirection, &v.params, v.is_variadic)
        } else {
            self.of_tag(v.type_tag)
        };
        if v.is_parameter {
            return base;
        }
        let dims = array_dims(v.array_size as i64, &v.array_dims);
        if dims.is_empty() {
            base
        } else {
            self.intern(TypeNode::Array { elem: base, dims })
        }
    }

    /// A function pointer. `indirection` counts the `*` levels the
    /// declarator put over the function type, and `tag` carries the
    /// return type under exactly that many pointer levels, so peeling
    /// them names the return type.
    fn of_function_pointer(
        &mut self,
        tag: i64,
        indirection: i64,
        param_tags: &[i64],
        variadic: bool,
    ) -> TypeId {
        let depth = indirection.clamp(0, 32) as u8;
        let Some(key) = decompose_pointer_chain(tag) else {
            return self.unspecified();
        };
        let ret = match key.peel(depth) {
            None => Some(self.unspecified()),
            // DWARF 4 5.7: a void-returning subroutine type has no
            // DW_AT_type.
            Some(k) if k.is_void_value() => None,
            Some(k) => Some(self.of_key(k)),
        };
        // A `(void)` prototype is an empty parameter list, not one
        // parameter of type void (C99 6.7.5.3p10).
        let params: Vec<TypeId> = param_tags
            .iter()
            .copied()
            .filter(|&p| !crate::c5::compiler::types::is_void_ty(p))
            .map(|p| self.of_tag(p))
            .collect();
        let fn_ty = self.intern(TypeNode::Subroutine {
            ret,
            params,
            variadic,
        });
        self.pointer_chain(fn_ty, depth)
    }
}

/// One child of an aggregate's DIE. C11 6.7.2.1p13 promotes an
/// anonymous struct's or union's members into the enclosing
/// aggregate's namespace; the registry keeps them flattened, and the
/// description restores the unnamed member whose type is the
/// anonymous aggregate.
enum MemberPlan {
    /// Index into `StructDef::fields`.
    Field(usize),
    /// Registry id of the anonymous aggregate and its byte offset in
    /// the enclosing one.
    Anonymous { id: usize, offset: usize },
}

/// The anonymous aggregate whose promotion produced `f`, or `None` for
/// a field the source declared directly. A field promoted through
/// nested anonymous aggregates carries one group id per tag kind; the
/// enclosing one is then the aggregate whose own field list carries
/// the other, since the inner one cannot contain its own ancestor.
fn anon_group_of(structs: &[StructDef], f: &StructField) -> Option<usize> {
    match (f.anon_union_group as usize, f.anon_struct_group as usize) {
        (0, 0) => None,
        (0, s) => Some(s - 1),
        (u, 0) => Some(u - 1),
        (u, s) => {
            let union_within_struct = structs
                .get(s - 1)
                .is_some_and(|sd| sd.fields.iter().any(|g| g.anon_union_group as usize == u));
            Some(if union_within_struct { s - 1 } else { u - 1 })
        }
    }
}

/// The children of `sd`'s DIE in declaration order. A run of fields
/// promoted from one anonymous aggregate collapses into a single
/// unnamed member when the run reproduces that aggregate's own field
/// list at a constant displacement. It does not when the enclosing
/// aggregate re-laid the promoted members (`packed` over an anonymous
/// struct); the fields stay flat there, because nesting them would
/// describe offsets the layout does not have.
fn member_plan(structs: &[StructDef], sd: &StructDef) -> Vec<MemberPlan> {
    let mut out = Vec::new();
    let mut i = 0;
    while i < sd.fields.len() {
        if let Some(id) = anon_group_of(structs, &sd.fields[i])
            && let Some(inner) = structs.get(id)
            && let Some(offset) = anon_run_offset(sd, i, inner)
        {
            out.push(MemberPlan::Anonymous { id, offset });
            i += inner.fields.len();
            continue;
        }
        out.push(MemberPlan::Field(i));
        i += 1;
    }
    out
}

/// The offset `inner`'s promoted members sit at in `sd`, when
/// `sd.fields[at..]` reproduces `inner.fields` member for member at a
/// constant displacement.
fn anon_run_offset(sd: &StructDef, at: usize, inner: &StructDef) -> Option<usize> {
    let n = inner.fields.len();
    if n == 0 || at + n > sd.fields.len() {
        return None;
    }
    let base = sd.fields[at].offset.checked_sub(inner.fields[0].offset)?;
    let placed = sd.fields[at..at + n]
        .iter()
        .zip(inner.fields.iter())
        .all(|(o, i)| {
            o.name == i.name
                && o.offset == base + i.offset
                && o.bit_offset == i.bit_offset
                && o.bit_width == i.bit_width
        });
    placed.then_some(base)
}

/// The dimension list of an array declarator, outermost first, empty
/// when the declarator is not an array. A negative entry is an
/// unspecified bound: c5 records the C99 6.7.2.1p16 flexible array
/// member, the GNU zero-length form and a variable-length array all as
/// a negative count.
fn array_dims(count: i64, dims: &[i64]) -> Vec<i64> {
    if count == 0 {
        return Vec::new();
    }
    if count < 0 {
        return alloc::vec![-1];
    }
    // `dims` also carries shapes whose entries are not a plain
    // dimension list (the redundant-paren form prepends a sentinel), so
    // it is used only when it accounts for the recorded element count.
    if !dims.is_empty() && dims.iter().all(|&d| d > 0) && dims.iter().product::<i64>() == count {
        return dims.to_vec();
    }
    alloc::vec![count]
}

/// Write one type DIE, with its children, into a fresh buffer.
fn build_type_die(catalog: &mut TypeCatalog, node: &TypeNode) -> DieBuf {
    let mut die = DieBuf::new();
    match node {
        TypeNode::Base(leaf) => {
            // Every interned Base was checked to have a description.
            let Some(base) = base_type_for_leaf(*leaf, catalog.target) else {
                write_uleb128(&mut die.bytes, ABBREV_UNSPECIFIED_TYPE);
                return die;
            };
            write_uleb128(&mut die.bytes, ABBREV_BASE_TYPE);
            push_string(&mut die.bytes, base.name);
            die.bytes.push(base.byte_size);
            die.bytes.push(base.encoding);
        }
        TypeNode::Pointer(None) => {
            write_uleb128(&mut die.bytes, ABBREV_POINTER_TYPE_VOID);
            die.bytes.push(8);
        }
        TypeNode::Pointer(Some(inner)) => {
            write_uleb128(&mut die.bytes, ABBREV_POINTER_TYPE);
            die.bytes.push(8);
            die.push_ref(*inner);
        }
        TypeNode::Declaration(id) => {
            let structs = catalog.structs;
            let is_union = structs.get(*id).is_some_and(|s| s.is_union);
            let abbrev = if is_union {
                ABBREV_UNION_TYPE_DECL
            } else {
                ABBREV_STRUCTURE_TYPE_DECL
            };
            write_uleb128(&mut die.bytes, abbrev);
            push_string(&mut die.bytes, structs.get(*id).map_or("", |s| &s.name));
        }
        TypeNode::Aggregate(id) => {
            let structs = catalog.structs;
            let Some(sd) = structs.get(*id) else {
                write_uleb128(&mut die.bytes, ABBREV_UNSPECIFIED_TYPE);
                return die;
            };
            let abbrev = match (sd.is_union, sd.is_anonymous) {
                (false, false) => ABBREV_STRUCTURE_TYPE,
                (true, false) => ABBREV_UNION_TYPE,
                (false, true) => ABBREV_STRUCTURE_TYPE_ANON,
                (true, true) => ABBREV_UNION_TYPE_ANON,
            };
            write_uleb128(&mut die.bytes, abbrev);
            if !sd.is_anonymous {
                push_string(&mut die.bytes, &sd.name);
            }
            write_uleb128(&mut die.bytes, sd.size as u64);
            for m in member_plan(structs, sd) {
                let i = match m {
                    MemberPlan::Field(i) => i,
                    MemberPlan::Anonymous { id, offset } => {
                        let anon_type = catalog.of_aggregate(id);
                        write_uleb128(&mut die.bytes, ABBREV_MEMBER_ANON);
                        die.push_ref(anon_type);
                        write_uleb128(&mut die.bytes, offset as u64);
                        continue;
                    }
                };
                let f = &sd.fields[i];
                let field_type = catalog.of_field(f);
                if f.bit_width > 0 {
                    // DWARF 4 5.6.6: DW_AT_data_bit_offset is the
                    // absolute bit offset from the start of the
                    // aggregate. c5 stores `offset` as the byte offset
                    // of the storage unit and `bit_offset` as the bit
                    // offset within it.
                    let data_bit_offset = (f.offset as u64) * 8 + f.bit_offset as u64;
                    write_uleb128(&mut die.bytes, ABBREV_BITFIELD_MEMBER);
                    push_string(&mut die.bytes, &f.name);
                    die.push_ref(field_type);
                    write_uleb128(&mut die.bytes, data_bit_offset);
                    write_uleb128(&mut die.bytes, f.bit_width as u64);
                } else {
                    write_uleb128(&mut die.bytes, ABBREV_MEMBER);
                    push_string(&mut die.bytes, &f.name);
                    die.push_ref(field_type);
                    write_uleb128(&mut die.bytes, f.offset as u64);
                }
            }
            die.bytes.push(0);
        }
        TypeNode::Array { elem, dims } => {
            write_uleb128(&mut die.bytes, ABBREV_ARRAY_TYPE);
            die.push_ref(*elem);
            for &d in dims {
                if d > 0 {
                    write_uleb128(&mut die.bytes, ABBREV_SUBRANGE_TYPE);
                    write_uleb128(&mut die.bytes, (d as u64) - 1);
                } else {
                    write_uleb128(&mut die.bytes, ABBREV_SUBRANGE_TYPE_OPEN);
                }
            }
            die.bytes.push(0);
        }
        TypeNode::Subroutine {
            ret,
            params,
            variadic,
        } => {
            match ret {
                Some(r) => {
                    write_uleb128(&mut die.bytes, ABBREV_SUBROUTINE_TYPE);
                    die.push_ref(*r);
                }
                None => write_uleb128(&mut die.bytes, ABBREV_SUBROUTINE_TYPE_VOID),
            }
            for p in params {
                write_uleb128(&mut die.bytes, ABBREV_FORMAL_PARAMETER_TYPE);
                die.push_ref(*p);
            }
            if *variadic {
                write_uleb128(&mut die.bytes, ABBREV_UNSPECIFIED_PARAMETERS);
            }
            die.bytes.push(0);
        }
        TypeNode::Unspecified => write_uleb128(&mut die.bytes, ABBREV_UNSPECIFIED_TYPE),
    }
    die
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

impl TypeKey {
    /// The same type with `n` pointer levels removed, or `None` when
    /// it does not have that many.
    fn peel(self, n: u8) -> Option<TypeKey> {
        match self {
            TypeKey::Scalar { leaf, depth } => depth
                .checked_sub(n)
                .map(|depth| TypeKey::Scalar { leaf, depth }),
            TypeKey::Aggregate { id, depth } => depth
                .checked_sub(n)
                .map(|depth| TypeKey::Aggregate { id, depth }),
        }
    }

    /// True for the scalar `void` value type, which DWARF describes by
    /// the absence of a `DW_AT_type` rather than by a DIE.
    fn is_void_value(self) -> bool {
        matches!(self, TypeKey::Scalar { leaf, depth: 0 }
            if crate::c5::compiler::types::is_void_ty(leaf))
    }
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
    use crate::c5::compiler::types::{UNSIGNED_BIT, VOID_BIT};
    const TY_PTR: i64 = Ty::Ptr as i64;
    const BAND_SIZE: i64 = 100;
    const STRUCT_BASE: i64 = 1000;
    const STRUCT_STRIDE: i64 = 1000;
    let unsigned = (type_tag & UNSIGNED_BIT) != 0;
    let bare = crate::c5::compiler::types::strip_unsigned(type_tag);
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
    } else if (Ty::Bool as i64..Ty::Bool as i64 + BAND_SIZE).contains(&bare) {
        (Ty::Bool as i64, ((bare - Ty::Bool as i64) / TY_PTR) as u8)
    } else {
        return None;
    };
    // The unsigned and void markers ride the leaf so `unsigned char`
    // and `char` get distinct DIEs and `void *` stays distinguishable
    // from `unsigned char *`.
    let leaf = if unsigned { leaf | UNSIGNED_BIT } else { leaf } | (type_tag & VOID_BIT);
    Some(TypeKey::Scalar { leaf, depth })
}

/// Map a c5 leaf scalar type tag to its DWARF base_type
/// attributes. Returns `None` for struct types and any tag
/// outside the C99 scalar grid; the caller skips emitting a
/// type DIE for those (debugger falls back to raw bytes).
fn base_type_for_leaf(leaf: i64, target: super::Target) -> Option<BaseTypeDesc> {
    use crate::c5::compiler::types::{UNSIGNED_BIT, is_void_ty};
    if is_void_ty(leaf) {
        return None;
    }
    let unsigned = (leaf & UNSIGNED_BIT) != 0;
    let bare = crate::c5::compiler::types::strip_unsigned(leaf);
    let desc = if bare == Ty::Bool as i64 {
        BaseTypeDesc {
            name: "_Bool",
            byte_size: 1,
            encoding: DW_ATE_BOOLEAN,
        }
    } else if bare == Ty::Char as i64 {
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
    } else if bare == Ty::LongLong as i64 {
        BaseTypeDesc {
            name: if unsigned {
                "unsigned long long"
            } else {
                "long long"
            },
            byte_size: 8,
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

#[cfg(test)]
mod abbrev_golden {
    /// Byte-stability lock for the ET_REL `.debug_abbrev` table.
    /// `build_debug_info` references each abbreviation by code and
    /// supplies its attribute values in the order declared here, so
    /// an accidental edit to a code, tag, or attribute silently
    /// desyncs the two emitters. Any intentional change must update
    /// this golden after re-checking the info emitter.
    #[test]
    fn build_debug_abbrev_is_byte_stable() {
        let hex: alloc::string::String = super::build_debug_abbrev()
            .iter()
            .map(|b| alloc::format!("{b:02x}"))
            .collect();
        assert_eq!(
            hex,
            "0111012508130b03081b081101120710170000022e000308110112073f192719360b\
             0000032e010308110112073f192719360b401800001e2e000308110112072719360b\
             00001f2e010308110112072719360b401800000405000308021849133a0f3b0f0000\
             0534000308021849133a0f3b0f000006240003080b0b3e0b0000070f000b0b491300\
             0008130103080b0f000009170103080b0f00000a0d0003084913380f00001d0d0049\
             13380f00000b0d00030849136b0f0d0f00000c180000000d0101491300000e21002f\
             0f00000f040103080b0b000010280003081c0d00001113010b0f00001217010b0f00\
             0013130003083c19000014170003083c190000151501271949130000161501271900\
             00170500491300001821000000190f000b0b00001a3b0000001b3400030849133f19\
             02183a0f3b0f00001c34000308491302183a0f3b0f0000203400030849133f193a0f\
             3b0f0000213400030849133a0f3b0f000000"
        );
    }
}
