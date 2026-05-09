//! DWARF emitter.
//!
//! Produces four byte vectors that the per-target writers can drop
//! into their container's debug-section equivalents:
//!
//! * `.debug_str` -- null-terminated strings (function names, the
//!   source filename, plus the c5 type-tag names referenced by the
//!   type catalog).
//! * `.debug_abbrev` -- five abbreviation entries: compile_unit,
//!   subprogram, base_type, variable, formal_parameter.
//! * `.debug_info` -- a single CU DIE with one base-type child per
//!   distinct c5 scalar type tag actually referenced, plus one
//!   subprogram-DIE child per c5 user function. Each subprogram
//!   carries variable / formal_parameter children that reference
//!   the right type DIE. Pointers and structs route through a
//!   placeholder `void *` base DIE until gh #58 and gh #59 extend
//!   the catalog with proper pointer-chain and struct DIEs.
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
//! ## Wire-format conventions
//!
//! Each fixed-layout DWARF header lives next to a `#[repr(C,
//! packed)]` schema struct whose `write_le` body is the source of
//! truth for the on-disk byte layout. The schemas are documentary
//! -- we never transmute them to bytes (packed-struct field reads
//! are unaligned and host-endian-dependent), so the per-field
//! little-endian serialisation in `write_le` is what the consumer
//! sees. Variable-length records (DIE bodies, ULEB / SLEB streams,
//! per-attribute encodings) keep their hand-rolled byte writes;
//! the schema treatment is reserved for the spec's fixed-layout
//! tables.
//!
//! Phase 2 (gh #47): `.debug_frame` / `__eh_frame` for unwinding.
//! Phase 3 (gh #42): wire DWARF into the PE writer.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::format;
use alloc::vec::Vec;

use super::{Build, Target};
use crate::c5::compiler::types;
use crate::c5::op::Op;
use crate::c5::program::Program;
use crate::c5::token::Ty;

// ---- DWARF spec constants ----
//
// Names mirror the DWARF 4 standard's `DW_*` identifiers so a
// reader cross-referencing the spec or another emitter can
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

// `DW_ATE_*` encodings for `DW_TAG_base_type`'s `DW_AT_encoding`.
const DW_ATE_ADDRESS: u8 = 0x01;
const DW_ATE_FLOAT: u8 = 0x04;
const DW_ATE_SIGNED: u8 = 0x05;
const DW_ATE_SIGNED_CHAR: u8 = 0x06;
const DW_ATE_UNSIGNED: u8 = 0x07;
const DW_ATE_UNSIGNED_CHAR: u8 = 0x08;

const DW_FORM_ADDR: u32 = 0x01;
const DW_FORM_DATA1: u32 = 0x0b;
const DW_FORM_DATA8: u32 = 0x07;
const DW_FORM_STRP: u32 = 0x0e;
const DW_FORM_FLAG_PRESENT: u32 = 0x19;
const DW_FORM_SEC_OFFSET: u32 = 0x17;
const DW_FORM_REF4: u32 = 0x13;
const DW_FORM_EXPRLOC: u32 = 0x18;

// `DW_OP_*` opcodes used in location / frame-base expressions.
const DW_OP_FBREG: u8 = 0x91;
/// `DW_OP_breg29 <sleb128>` (= 0x70 + 29) -- "frame base is the
/// value of register x29 plus N". Used in `DW_AT_frame_base` so
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
const DW_LNS_SET_FILE: u8 = 0x04;

// Extended-opcode prefix is `0x00`; the byte after the length
// names the extended op.
const DW_LNE_END_SEQUENCE: u8 = 0x01;
const DW_LNE_SET_ADDRESS: u8 = 0x02;

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

// ---- wire-format schemas ----

/// Compilation-unit header for `.debug_info` (DWARF 4, 32-bit
/// form). Follows the spec table exactly.
#[repr(C, packed)]
struct DebugInfoUnitHeader {
    /// Bytes in this unit *not counting* this `u32` itself.
    unit_length: u32,
    version: u16,
    debug_abbrev_offset: u32,
    address_size: u8,
}

impl DebugInfoUnitHeader {
    /// Bytes the header occupies on the wire. CU-relative offsets
    /// (`DW_FORM_ref4` references) shift body offsets by this much.
    const SIZE: u32 = 11;

    fn write_le(&self, out: &mut Vec<u8>) {
        // Destructure into Copy locals: borrowing fields off a
        // packed struct directly trips `unaligned_references`.
        let DebugInfoUnitHeader {
            unit_length,
            version,
            debug_abbrev_offset,
            address_size,
        } = *self;
        out.extend_from_slice(&unit_length.to_le_bytes());
        out.extend_from_slice(&version.to_le_bytes());
        out.extend_from_slice(&debug_abbrev_offset.to_le_bytes());
        out.push(address_size);
    }
}

/// Statement-program unit header for `.debug_line` (DWARF 4,
/// 32-bit). The bytes that follow `header_length` belong to the
/// program-header schema below + opcode_lengths + dir / file
/// tables; the program itself trails after that block.
#[repr(C, packed)]
struct DebugLineUnitHeader {
    /// Bytes in this unit *not counting* this `u32` itself.
    unit_length: u32,
    version: u16,
    /// Bytes from the end of `header_length` (i.e. from
    /// `minimum_instruction_length`) to the start of the
    /// statement program.
    header_length: u32,
}

impl DebugLineUnitHeader {
    fn write_le(&self, out: &mut Vec<u8>) {
        let DebugLineUnitHeader {
            unit_length,
            version,
            header_length,
        } = *self;
        out.extend_from_slice(&unit_length.to_le_bytes());
        out.extend_from_slice(&version.to_le_bytes());
        out.extend_from_slice(&header_length.to_le_bytes());
    }
}

/// Fixed prologue of the `.debug_line` statement-program header
/// (everything up to but not including the variable-length
/// `standard_opcode_lengths` table).
#[repr(C, packed)]
struct DebugLineProgramHeader {
    minimum_instruction_length: u8,
    maximum_operations_per_instruction: u8,
    default_is_stmt: u8,
    line_base: i8,
    line_range: u8,
    opcode_base: u8,
}

impl DebugLineProgramHeader {
    fn write_le(&self, out: &mut Vec<u8>) {
        let DebugLineProgramHeader {
            minimum_instruction_length,
            maximum_operations_per_instruction,
            default_is_stmt,
            line_base,
            line_range,
            opcode_base,
        } = *self;
        out.push(minimum_instruction_length);
        out.push(maximum_operations_per_instruction);
        out.push(default_is_stmt);
        out.push(line_base as u8);
        out.push(line_range);
        out.push(opcode_base);
    }
}

// ---- Emitter entry point ----

/// The four byte vectors the emitter produces. Per-target writers
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
/// `target` selects the data model used to size c5's `long`
/// (LP64 = 8 bytes vs LLP64 = 4 bytes) so the emitted base-type
/// DIEs match what the codegen actually loads / stores.
/// `code_vmaddr` is the runtime virtual address that
/// `Build::text[0]` will load at; we add it to every
/// codegen-relative offset before writing it as a DWARF
/// `DW_FORM_addr`. `source_path` becomes the CU's `DW_AT_name`
/// and the line program's only file entry -- best supplied as the
/// original `.c` path the user passed to `badc`, falling back to
/// `<unknown>` when no path is available (stdin pipe, etc.).
pub(crate) fn emit(
    program: &Program,
    build: &Build,
    target: Target,
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

    // Walk the bytecode, collect one `Subprog` per `Op::Ent`.
    let subs = collect_subprograms(program, build, code_vmaddr, &mut strs);

    // Build the type catalog: distinct base types referenced by
    // any captured variable, plus a placeholder `void *` for
    // pointers / structs (those reach proper DIEs in gh #58 / gh
    // #59). String interning happens here so the strtab is
    // finalised just before we write `.debug_str`.
    let catalog = TypeCatalog::collect(&subs, &mut strs, target);

    let debug_abbrev = build_debug_abbrev();
    let (debug_line, line_unit_off) = build_debug_line(program, build, code_vmaddr, source_path);
    let debug_info = build_debug_info(
        cu_name_off,
        comp_dir_off,
        producer_off,
        line_unit_off,
        code_vmaddr,
        build.text.len() as u64,
        &catalog,
        &subs,
        target,
    );
    let debug_str = strs.into_bytes();

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
    /// Raw c5 type tag (`Ty` enum encoded as `i64`). Resolved
    /// against the type catalog at `build_debug_info` time so the
    /// DIE picks up the right `DW_AT_type` ref.
    type_tag: i64,
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
    let mut name_seen: BTreeMap<alloc::string::String, u32> = BTreeMap::new();
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
        // `program.variables`. Captured by the c5 frontend at
        // function-body close, indexed by the Ent's bytecode pc
        // so a simple equality check groups them.
        let function_bc_pc = ent_pc as u64;
        let variables = program
            .variables
            .iter()
            .filter(|v| v.function_bc_pc == function_bc_pc)
            .map(|v| SubprogVar {
                name_off: strs.intern(&v.name),
                is_parameter: v.is_parameter,
                type_tag: v.type_tag,
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

// ---- Type catalog ----

/// One distinct scalar base type in the DWARF type tree. The
/// catalog dedupes by this key so two `int` locals share a single
/// DIE.
#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord)]
struct BaseTypeKey {
    /// C source spelling -- "int", "unsigned long", "double", etc.
    /// Becomes the DIE's `DW_AT_name`.
    name: &'static str,
    byte_size: u8,
    /// `DW_ATE_*` encoding, drives the DIE's `DW_AT_encoding`.
    encoding: u8,
}

struct TypeCatalog {
    /// Base types in deterministic emission order. Each entry pairs
    /// a key with its interned `DW_AT_name` offset; the CU-relative
    /// DIE offset is computed at emission time and resolved against
    /// the per-base lookup map built alongside.
    bases: Vec<(BaseTypeKey, u32)>,
    /// True when any captured variable was a pointer or struct, so
    /// we also emit the placeholder `void *` DIE that pointer- /
    /// struct-typed variables reference until gh #58 / gh #59
    /// extend the catalog with proper pointer-chain / struct DIEs.
    needs_void_star: bool,
    void_star_name_off: u32,
}

impl TypeCatalog {
    fn collect(subs: &[Subprog], strs: &mut StrTable, target: Target) -> Self {
        let mut keys: BTreeSet<BaseTypeKey> = BTreeSet::new();
        let mut needs_void_star = false;
        for sub in subs {
            for v in &sub.variables {
                match base_key_for(v.type_tag, target) {
                    Some(key) => {
                        keys.insert(key);
                    }
                    None => {
                        needs_void_star = true;
                    }
                }
            }
        }
        let bases: Vec<(BaseTypeKey, u32)> = keys
            .into_iter()
            .map(|k| (k, strs.intern(k.name)))
            .collect();
        let void_star_name_off = if needs_void_star {
            strs.intern("void *")
        } else {
            0
        };
        TypeCatalog {
            bases,
            needs_void_star,
            void_star_name_off,
        }
    }
}

/// Map a c5 type tag to its scalar base-type key. Returns `None`
/// for pointers (gh #58 will replace the void* placeholder with a
/// proper pointer-chain DIE) and structs (gh #59 likewise).
fn base_key_for(ty: i64, target: Target) -> Option<BaseTypeKey> {
    if types::is_pointer_ty(ty) {
        return None;
    }
    let unsigned = types::is_unsigned_ty(ty);
    let bare = types::strip_unsigned(ty);

    // Struct types share the i64 namespace but live above
    // `types::STRUCT_BASE`; matched here before any of the scalar
    // bands so they don't accidentally fall through.
    if bare >= types::STRUCT_BASE {
        return None;
    }

    let key = if bare == Ty::Char as i64 {
        BaseTypeKey {
            name: if unsigned { "unsigned char" } else { "char" },
            byte_size: 1,
            encoding: if unsigned {
                DW_ATE_UNSIGNED_CHAR
            } else {
                DW_ATE_SIGNED_CHAR
            },
        }
    } else if bare == Ty::Short as i64 {
        BaseTypeKey {
            name: if unsigned { "unsigned short" } else { "short" },
            byte_size: 2,
            encoding: if unsigned { DW_ATE_UNSIGNED } else { DW_ATE_SIGNED },
        }
    } else if bare == Ty::Int as i64 {
        BaseTypeKey {
            name: if unsigned { "unsigned int" } else { "int" },
            byte_size: 4,
            encoding: if unsigned { DW_ATE_UNSIGNED } else { DW_ATE_SIGNED },
        }
    } else if bare == Ty::Long as i64 {
        // LP64: 8 bytes; LLP64 (Windows): 4 bytes. Matches the
        // c5 codegen's load/store width pick (`load_op_for`).
        let byte_size = if target.is_windows() { 4 } else { 8 };
        BaseTypeKey {
            name: if unsigned { "unsigned long" } else { "long" },
            byte_size,
            encoding: if unsigned { DW_ATE_UNSIGNED } else { DW_ATE_SIGNED },
        }
    } else if bare == Ty::LongLong as i64 {
        BaseTypeKey {
            name: if unsigned {
                "unsigned long long"
            } else {
                "long long"
            },
            byte_size: 8,
            encoding: if unsigned { DW_ATE_UNSIGNED } else { DW_ATE_SIGNED },
        }
    } else if bare == Ty::Float as i64 {
        // c5 keeps `float` at 8 bytes today (no f32 narrowing,
        // see `pointee_size_no_struct`); the DIE's byte_size
        // describes the wire layout, so 8 it is until the
        // narrowing lands.
        BaseTypeKey {
            name: "float",
            byte_size: 8,
            encoding: DW_ATE_FLOAT,
        }
    } else if bare == Ty::Double as i64 {
        BaseTypeKey {
            name: "double",
            byte_size: 8,
            encoding: DW_ATE_FLOAT,
        }
    } else {
        return None;
    };
    Some(key)
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
    // variable). `DW_AT_frame_base` carries the location
    // expression that resolves `DW_OP_fbreg` references against
    // c5's frame pointer ($x29).
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

    // Abbrev 3: DW_TAG_base_type. Shared by every scalar base type
    // DIE (one per distinct c5 tag) plus the placeholder void* DIE
    // that pointer / struct variables fall back to in phase 1A.
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
    // variable abbrev; the tag itself is what tells lldb / gdb to
    // render the entry as a parameter rather than a local.
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
    catalog: &TypeCatalog,
    subs: &[Subprog],
    target: Target,
) -> Vec<u8> {
    // Build the body first so we know its size before prepending
    // the unit header. CU-relative `DW_FORM_ref4` offsets are
    // body-position + `DebugInfoUnitHeader::SIZE`.
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

    // Type DIEs (CU children, abbrev 3). One per distinct c5
    // scalar tag the program references; pointer / struct vars
    // route to a single trailing void* placeholder until gh #58 /
    // gh #59. Record CU-relative offsets so the variable /
    // formal_parameter children can back-reference them.
    let mut base_offsets: BTreeMap<BaseTypeKey, u32> = BTreeMap::new();
    for &(key, name_off) in &catalog.bases {
        let off = (body.len() as u32) + DebugInfoUnitHeader::SIZE;
        base_offsets.insert(key, off);
        write_uleb128(&mut body, 3);
        body.extend_from_slice(&name_off.to_le_bytes());
        body.push(key.byte_size);
        body.push(key.encoding);
    }
    let void_star_off = if catalog.needs_void_star {
        let off = (body.len() as u32) + DebugInfoUnitHeader::SIZE;
        write_uleb128(&mut body, 3);
        body.extend_from_slice(&catalog.void_star_name_off.to_le_bytes());
        body.push(8);
        body.push(DW_ATE_ADDRESS);
        Some(off)
    } else {
        None
    };

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

        // Variable / formal_parameter children. Order parameters
        // first; lldb's frame-variable ordering matches
        // declaration order, and c5's single-pass capture lands
        // them sorted on `fp_byte_offset` after the split.
        let mut sorted: Vec<&SubprogVar> = s.variables.iter().collect();
        sorted.sort_by_key(|v| (!v.is_parameter, v.fp_byte_offset));
        for v in sorted {
            let abbrev = if v.is_parameter { 5 } else { 4 };
            write_uleb128(&mut body, abbrev);
            body.extend_from_slice(&v.name_off.to_le_bytes());
            // Resolve this variable's c5 type tag. Pointers /
            // structs route to the void* placeholder; the
            // catalog guarantees `void_star_off` is set whenever
            // any var resolved that way, so the unwrap can't fire.
            let type_off = match base_key_for(v.type_tag, target) {
                Some(key) => *base_offsets
                    .get(&key)
                    .expect("catalog covers every base key referenced by a variable"),
                None => void_star_off
                    .expect("catalog flags needs_void_star whenever a non-base var exists"),
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

    // Prepend the unit header. `unit_length` covers everything
    // after itself: version(2) + abbrev_off(4) + addr_size(1) +
    // body.
    let mut out = Vec::with_capacity(DebugInfoUnitHeader::SIZE as usize + body.len());
    let header = DebugInfoUnitHeader {
        unit_length: (body.len() + 7) as u32,
        version: 4,
        debug_abbrev_offset: 0,
        address_size: 8,
    };
    header.write_le(&mut out);
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
    let mut prog = Vec::with_capacity(256);
    write_line_program(&mut prog, program, build, code_vmaddr);

    // Build everything that follows the `header_length` field --
    // statement-program prologue + opcode_lengths + dir / file
    // tables -- so we can compute the prologue length before
    // prepending the unit header.
    let mut hdr_after_len_field = Vec::with_capacity(32);
    let prog_header = DebugLineProgramHeader {
        minimum_instruction_length: 1,
        maximum_operations_per_instruction: 1,
        default_is_stmt: 1,
        line_base: LINE_BASE,
        line_range: LINE_RANGE,
        opcode_base: OPCODE_BASE,
    };
    prog_header.write_le(&mut hdr_after_len_field);
    // Standard-opcode lengths, indexed 1..opcode_base-1. Defaults
    // from the DWARF 4 spec table.
    for &n in &[0u8, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 1] {
        hdr_after_len_field.push(n);
    }
    // include_directories: empty list (just the terminator).
    hdr_after_len_field.push(0);
    // file_names: DWARF file numbering starts at 1 (0 is reserved
    // for "no file"), so the first entry in this list lands at
    // index 1. We open with the translation-unit path (the CLI
    // sets `program.source_path` from argv before emit), then
    // append every header the lexer's GNU line-marker handling
    // collected -- skipping its placeholder `"<source>"` since
    // we've already emitted the real path. The runtime
    // `source_file_indices` column is remapped to DWARF
    // numbering through `dwarf_file_idx_for_source_files_idx`
    // when emitting `DW_LNS_set_file` rows.
    let tu_name = if source_path.is_empty() {
        "<unknown>"
    } else {
        source_path
    };
    let emit_file_entry = |hdr: &mut Vec<u8>, name: &str| {
        hdr.extend_from_slice(name.as_bytes());
        hdr.push(0);
        write_uleb128(hdr, 0); // dir_idx (0 = comp_dir)
        write_uleb128(hdr, 0); // mtime
        write_uleb128(hdr, 0); // file size
    };
    emit_file_entry(&mut hdr_after_len_field, tu_name);
    for src in &program.source_files {
        // Skip the lexer's placeholder; the TU is already
        // entry 1 under its real path.
        if src == "<source>" {
            continue;
        }
        emit_file_entry(&mut hdr_after_len_field, src);
    }
    hdr_after_len_field.push(0); // file_names terminator

    let header_length = hdr_after_len_field.len() as u32;
    // unit_length covers everything after itself: version(2) +
    // header_length(4) + header_length-bytes + program.
    let unit_length = (2 + 4 + hdr_after_len_field.len() + prog.len()) as u32;

    let mut out = Vec::with_capacity(4 + 2 + 4 + hdr_after_len_field.len() + prog.len());
    let unit_header = DebugLineUnitHeader {
        unit_length,
        version: 4,
        header_length,
    };
    unit_header.write_le(&mut out);
    out.extend_from_slice(&hdr_after_len_field);
    out.extend_from_slice(&prog);

    (out, 0)
}

/// Walk the bytecode, emit one row per (live) op whose source line
/// is known. The DWARF state machine starts at `(address=0,
/// line=1, file=1, is_stmt=true)`; we open with a
/// `DW_LNE_set_address` to anchor at `code_vmaddr` and end with a
/// `DW_LNE_end_sequence` row past the last byte.
fn write_line_program(buf: &mut Vec<u8>, program: &Program, build: &Build, code_vmaddr: u64) {
    // Anchor address at the start of code.
    write_set_address(buf, code_vmaddr);

    // Pre-compute the lexer-index -> DWARF-file-number remap. The
    // `program.source_files` table starts at index 0 (the lexer
    // interns the TU's lexer-side label `"<source>"` first, then
    // each `#include`d header). DWARF file numbers start at 1 (0
    // is reserved for "no file"). We elide the `"<source>"`
    // placeholder from the file table and reserve DWARF index 1
    // for the TU's real path; every other lexer-source entry
    // gets a fresh DWARF index in declaration order.
    let mut next_dwarf_idx: u64 = 2;
    let dwarf_file_for_lex_idx: Vec<u64> = program
        .source_files
        .iter()
        .map(|name| {
            if name == "<source>" {
                1
            } else {
                let idx = next_dwarf_idx;
                next_dwarf_idx += 1;
                idx
            }
        })
        .collect();

    let mut state_addr: u64 = code_vmaddr;
    let mut state_line: i64 = 1;
    let mut state_file: u64 = 1;

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
        // Resolve the lexer's per-PC file index through the
        // remap above. Programs that compiled before the
        // file-table plumbing landed (or that never crossed an
        // `#include` / `#line`) leave `source_file_indices`
        // empty, in which case every PC stays on file 1.
        let lex_idx = program.source_file_indices.get(bc_pc).copied().unwrap_or(0) as usize;
        let file = dwarf_file_for_lex_idx.get(lex_idx).copied().unwrap_or(1);
        let target_addr = code_vmaddr + native as u64;
        if target_addr > state_addr {
            advance_pc(buf, target_addr - state_addr);
            state_addr = target_addr;
        }
        if file != state_file {
            buf.push(DW_LNS_SET_FILE);
            write_uleb128(buf, file);
            state_file = file;
        }
        if line != state_line {
            advance_line(buf, line - state_line);
            state_line = line;
        }
        // DW_LNS_copy emits the row. (We can't use special opcodes
        // here because the address+line deltas aren't bounded by
        // line_base / line_range in general.)
        buf.push(DW_LNS_COPY);
        bc_pc += op.word_size();
    }

    // Close the sequence with end_sequence at one past the last
    // byte.
    let end_addr = code_vmaddr + build.text.len() as u64;
    if end_addr > state_addr {
        advance_pc(buf, end_addr - state_addr);
    }
    write_extended(buf, DW_LNE_END_SEQUENCE, &[]);
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
    // Phase 1 didn't dedupe string contents; the table is small
    // (one entry per user function plus the CU name and producer)
    // and the writer reads it sequentially. The base-type names
    // (gh #57) come from a small `&'static str` set, so dedup
    // won't matter for them either. A dedup pass can land here if
    // it ever shows up on a flame graph.
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

    #[test]
    fn debug_info_unit_header_packs_to_11_bytes() {
        let mut buf = Vec::new();
        let h = DebugInfoUnitHeader {
            unit_length: 0x0102_0304,
            version: 4,
            debug_abbrev_offset: 0,
            address_size: 8,
        };
        h.write_le(&mut buf);
        assert_eq!(buf.len(), DebugInfoUnitHeader::SIZE as usize);
        assert_eq!(&buf[..4], &0x0102_0304u32.to_le_bytes());
        assert_eq!(&buf[4..6], &4u16.to_le_bytes());
        assert_eq!(&buf[6..10], &0u32.to_le_bytes());
        assert_eq!(buf[10], 8);
    }

    #[test]
    fn debug_line_program_header_packs_to_6_bytes() {
        let mut buf = Vec::new();
        let h = DebugLineProgramHeader {
            minimum_instruction_length: 1,
            maximum_operations_per_instruction: 1,
            default_is_stmt: 1,
            line_base: -1,
            line_range: 14,
            opcode_base: 13,
        };
        h.write_le(&mut buf);
        assert_eq!(buf, [1u8, 1, 1, (-1i8) as u8, 14, 13]);
    }

    #[test]
    fn base_key_for_distinguishes_signed_unsigned() {
        let signed = base_key_for(Ty::Int as i64, Target::LinuxX64).unwrap();
        let unsigned = base_key_for(Ty::Int as i64 | types::UNSIGNED_BIT, Target::LinuxX64).unwrap();
        assert_ne!(signed, unsigned);
        assert_eq!(signed.byte_size, 4);
        assert_eq!(signed.encoding, DW_ATE_SIGNED);
        assert_eq!(unsigned.encoding, DW_ATE_UNSIGNED);
    }

    #[test]
    fn base_key_for_long_follows_data_model() {
        let lp64 = base_key_for(Ty::Long as i64, Target::LinuxX64).unwrap();
        let llp64 = base_key_for(Ty::Long as i64, Target::WindowsX64).unwrap();
        assert_eq!(lp64.byte_size, 8);
        assert_eq!(llp64.byte_size, 4);
    }

    #[test]
    fn base_key_for_char_uses_signed_char_encoding() {
        let signed = base_key_for(Ty::Char as i64, Target::LinuxX64).unwrap();
        let unsigned =
            base_key_for(Ty::Char as i64 | types::UNSIGNED_BIT, Target::LinuxX64).unwrap();
        assert_eq!(signed.byte_size, 1);
        assert_eq!(signed.encoding, DW_ATE_SIGNED_CHAR);
        assert_eq!(unsigned.encoding, DW_ATE_UNSIGNED_CHAR);
    }

    #[test]
    fn base_key_for_pointer_falls_through_to_void_star() {
        // `int*` -> None, so the catalog routes it to the void*
        // placeholder until gh #58.
        let int_ptr = (Ty::Int as i64) + (Ty::Ptr as i64);
        assert!(base_key_for(int_ptr, Target::LinuxX64).is_none());
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
