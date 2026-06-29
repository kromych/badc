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
//!   placeholder `void *` base DIE; a future pass extends the
//!   catalog with proper pointer-chain and struct DIEs.
//! * `.debug_line` -- a line-number program mapping every emitted
//!   native byte range to the C source line that produced it.
//!   Read from `build.ssa_line_rows`, populated by the per-arch
//!   SSA emit as it lays out each `Inst`.
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

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::format;
use alloc::vec::Vec;

use super::{Build, Target};
use crate::c5::compiler::{StructDef, types};
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
const DW_TAG_POINTER_TYPE: u8 = 0x0f;
const DW_TAG_FORMAL_PARAMETER: u8 = 0x05;
const DW_TAG_VARIABLE: u8 = 0x34;
const DW_TAG_STRUCTURE_TYPE: u8 = 0x13;
const DW_TAG_UNION_TYPE: u8 = 0x17;
const DW_TAG_MEMBER: u8 = 0x0d;
/// DWARF 5 sec. 3.4.2 -- the `, ...` of a variadic prototype. We
/// emit one as a child of every PLT subprogram whose
/// `is_variadic` flag is set so gdb / lldb render the signature
/// with an ellipsis (`printf (fmt, ...)`).
const DW_TAG_UNSPECIFIED_PARAMETERS: u8 = 0x18;
const DW_TAG_ARRAY_TYPE: u8 = 0x01;
const DW_TAG_SUBRANGE_TYPE: u8 = 0x21;
const DW_TAG_ENUMERATION_TYPE: u8 = 0x04;
const DW_TAG_ENUMERATOR: u8 = 0x28;

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
/// `DW_AT_data_member_location` (0x38) carries the byte offset of
/// a member from the start of its containing struct / union.
const DW_AT_DATA_MEMBER_LOCATION: u32 = 0x38;
/// `DW_AT_bit_offset` (0x0c) is DWARF 3-style; deprecated in v4
/// but every consumer we target still handles it. Encodes the
/// distance from the MSB of the storage unit to the MSB of the
/// bitfield (so on little-endian targets we transform c5's
/// LSB-relative `bit_offset` into `storage_bits - lsb - width`
/// at emit time).
const DW_AT_BIT_OFFSET: u32 = 0x0c;
const DW_AT_BIT_SIZE: u32 = 0x0d;
const DW_AT_DECL_LINE: u32 = 0x3b;
const DW_AT_DECL_FILE: u32 = 0x3a;
const DW_AT_PROTOTYPED: u32 = 0x27;
const DW_AT_UPPER_BOUND: u32 = 0x2f;
const DW_AT_CALLING_CONVENTION: u32 = 0x36;
const DW_CC_NORMAL: u8 = 0x01;
const DW_AT_CONST_VALUE: u32 = 0x1c;

// `DW_ATE_*` encodings for `DW_TAG_base_type`'s `DW_AT_encoding`.
const DW_ATE_ADDRESS: u8 = 0x01;
const DW_ATE_BOOLEAN: u8 = 0x02;
const DW_ATE_FLOAT: u8 = 0x04;
const DW_ATE_SIGNED: u8 = 0x05;
const DW_ATE_SIGNED_CHAR: u8 = 0x06;
const DW_ATE_UNSIGNED: u8 = 0x07;
const DW_ATE_UNSIGNED_CHAR: u8 = 0x08;

const DW_FORM_ADDR: u32 = 0x01;
const DW_FORM_DATA1: u32 = 0x0b;
const DW_FORM_DATA4: u32 = 0x06;
const DW_FORM_DATA8: u32 = 0x07;
const DW_FORM_STRP: u32 = 0x0e;
const DW_FORM_STRING: u32 = 0x08;
const DW_FORM_FLAG_PRESENT: u32 = 0x19;
const DW_FORM_SEC_OFFSET: u32 = 0x17;
const DW_FORM_REF4: u32 = 0x13;
const DW_FORM_EXPRLOC: u32 = 0x18;
const DW_FORM_UDATA: u32 = 0x0f;
const DW_FORM_SDATA: u32 = 0x0d;

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
/// `DW_OP_breg6` -- "frame base is rbp + offset" on x86_64.
const DW_OP_BREG6: u8 = 0x76;
/// `DW_OP_reg0..reg31` -- "this variable IS in register N".
/// Used by PLT formal_parameter DIEs so gdb can evaluate the
/// value of e.g. malloc's `size` arg directly out of the
/// AAPCS64 / SysV calling-convention register at the moment of
/// the call.
const DW_OP_REG_BASE: u8 = 0x50;

const DW_LANG_C99: u8 = 0x0c;

// Standard line-program opcodes we emit.
const DW_LNS_COPY: u8 = 0x01;
const DW_LNS_ADVANCE_PC: u8 = 0x02;
const DW_LNS_ADVANCE_LINE: u8 = 0x03;
const DW_LNS_SET_FILE: u8 = 0x04;
const DW_LNS_SET_PROLOGUE_END: u8 = 0x0a;

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

// ---- Call Frame Information opcodes (DWARF 4, table 7.23) ----

/// `DW_CFA_advance_loc` is encoded as an opcode-with-operand: the
/// top two bits are `0b01` (= 0x40) and the low six bits carry
/// the factored delta. Used inline; broken out as a helper.
const DW_CFA_ADVANCE_LOC_HI: u8 = 0x40;
const DW_CFA_OFFSET_HI: u8 = 0x80;

const DW_CFA_NOP: u8 = 0x00;
const DW_CFA_ADVANCE_LOC1: u8 = 0x02;
const DW_CFA_ADVANCE_LOC2: u8 = 0x03;
const DW_CFA_ADVANCE_LOC4: u8 = 0x04;
const DW_CFA_DEF_CFA: u8 = 0x0c;
/// `DW_CFA_undefined <register>` -- mark a register as having
/// no recoverable value in the previous frame. The unwinder
/// uses this to recognise the bottom of the stack: when the
/// return-address column is undefined, there's nothing to walk
/// to. Used in the `_start` FDE so gdb stops gracefully
/// instead of reading past the bottom-most frame.
const DW_CFA_UNDEFINED: u8 = 0x07;

// Architecture-specific register codes used in CFI rules.
//
// AArch64 follows ABI table A.1: x0..x30 = 0..30, sp = 31.
// x86_64 follows the SysV / DWARF 4 register numbering: rax=0,
// rdx=1, rcx=2, rbx=3, rsi=4, rdi=5, rbp=6, rsp=7, r8..r15=8..15,
// "Return Address" virtual column = 16 (i.e. RIP).

const AARCH64_REG_X29: u8 = 29;
const AARCH64_REG_X30: u8 = 30;
const AARCH64_REG_SP: u8 = 31;

const X86_64_REG_RBP: u8 = 6;
const X86_64_REG_RSP: u8 = 7;
const X86_64_REG_RA: u8 = 16;

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

/// The byte vectors the emitter produces. Per-target writers
/// (Mach-O / ELF / PE) wrap these into their format-specific
/// debug-section containers.
pub(crate) struct DwarfSections {
    pub debug_info: Vec<u8>,
    pub debug_abbrev: Vec<u8>,
    pub debug_line: Vec<u8>,
    pub debug_str: Vec<u8>,
    /// Call Frame Information (DWARF 4 `.debug_frame` form): one
    /// CIE describing c5's standard prologue, plus one FDE per
    /// user function. ELF wires this into `.debug_frame`, Mach-O
    /// into `__debug_frame` of the `__DWARF` segment. Empty when
    /// the build has no callable functions.
    pub debug_frame: Vec<u8>,
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
    start_stub_range: Option<(u64, u64)>,
) -> DwarfSections {
    let mut strs = StrTable::new();
    let producer_off = strs.intern(&format!("badc {}", env!("CARGO_PKG_VERSION")));
    let comp_dir_off = strs.intern("");
    let cu_name_off = strs.intern(if source_path.is_empty() {
        "<unknown>"
    } else {
        source_path
    });

    // Walk the SSA function list, collect one `Subprog` per
    // function.
    let subs = collect_subprograms(program, build, code_vmaddr, &mut strs);

    // Emit one `PltSub` per import. Lets gdb / lldb resolve a
    // `bt` frame pointing at a PLT trampoline to a typed
    // signature like `malloc (size=...)` rather than bare
    // `in malloc ()`.
    let mut plt_subs = collect_plt_subprograms(build, target, code_vmaddr, &mut strs);

    // Append a `_start` entry so gdb stops saying
    // "Cannot find bounds of current function" the moment
    // execution returns from main. Same DIE shape as a PLT stub
    // -- name + range, no formal parameters (the c5 binding
    // model doesn't describe argc/argv at this layer).
    if let Some((lo, hi)) = start_stub_range {
        plt_subs.push(PltSub {
            name_off: strs.intern("_start"),
            low_pc: lo,
            high_pc: hi,
            return_type_tag: 0,
            param_types: Vec::new(),
            param_name_offs: Vec::new(),
            is_variadic: false,
        });
    }

    // Build the type catalog. Walks captured variables and PLT
    // signatures, then transitively pulls in struct fields' types
    // so a member declared `struct Foo *next` reaches a real
    // `DW_TAG_pointer` -> `DW_TAG_structure_type` chain. String
    // interning happens here so the strtab is finalised just
    // before we write `.debug_str`.
    let catalog = TypeCatalog::collect(&subs, &plt_subs, &mut strs, target, &program.structs);

    let debug_abbrev = build_debug_abbrev();
    let (debug_line, line_unit_off) = build_debug_line(program, build, code_vmaddr, source_path);
    // Extend the CU's [low_pc, low_pc + size) range
    // backwards over the `_start` stub when present, so a PC
    // inside the stub still falls inside the CU and gdb can
    // resolve it to the `_start` subprogram DIE we emitted.
    // Without this, the stub DIE is in the table but gdb's
    // CU-keyed lookup misses it -- the symptom is `?? ()` after
    // execution returns from main.
    let (cu_low_pc, cu_size) = match start_stub_range {
        Some((lo, _)) => (lo, build.text.len() as u64 + (code_vmaddr - lo)),
        None => (code_vmaddr, build.text.len() as u64),
    };
    let debug_info = build_debug_info(
        cu_name_off,
        comp_dir_off,
        producer_off,
        line_unit_off,
        cu_low_pc,
        cu_size,
        &catalog,
        &subs,
        &plt_subs,
        target,
        &program.structs,
        &program.enums,
    );
    let debug_frame = build_debug_frame(
        target,
        &subs,
        plt_pool_range(build, code_vmaddr),
        start_stub_range,
    );
    let debug_str = strs.into_bytes();

    DwarfSections {
        debug_info,
        debug_abbrev,
        debug_line,
        debug_str,
        debug_frame,
    }
}

// ---- Subprogram discovery ----

struct Subprog {
    name_off: u32,
    low_pc: u64,
    high_pc: u64,
    /// Native bytes from `low_pc` to the first byte of the
    /// function body (after the standard prologue). Drives the
    /// CFI FDE's `DW_CFA_advance_loc` so the post-prologue CFA
    /// rule starts at the right PC.
    prologue_size: u32,
    /// Locals + formal-parameters that c5 captured for this
    /// subprogram (see `Compiler::variables`). The DWARF emitter
    /// turns each into a `DW_TAG_variable` /
    /// `DW_TAG_formal_parameter` child of the subprogram DIE.
    variables: Vec<SubprogVar>,
}

/// One PLT-trampoline subprogram. Mirrors `Subprog` but
/// drops the c5-frame machinery: a stub has no locals, no
/// prologue, no frame_base. It carries an explicit return type
/// (`Subprog` doesn't, since user-fn return types aren't tracked
/// by the c5 frontend yet) and per-fixed-parameter types so the
/// emitter can write `DW_TAG_formal_parameter` children with
/// proper `DW_AT_type` refs.
struct PltSub {
    name_off: u32,
    low_pc: u64,
    high_pc: u64,
    /// Return type tag (c5 `Symbol::type_` encoding). `0` when
    /// the parser hasn't seen a prototype for this binding;
    /// classified through the same TypeCatalog used for user
    /// variables.
    return_type_tag: i64,
    /// Per-fixed-parameter type tags. One DIE per entry. Empty
    /// when the parser hasn't seen the prototype.
    param_types: Vec<i64>,
    /// Strtab offset of the synthetic name (`arg0`, `arg1`,
    /// ...) we hand each formal_parameter so gdb's `info args`
    /// and `bt` actually print the param. Same length as
    /// `param_types`.
    param_name_offs: Vec<u32>,
    /// `true` if the binding's prototype ended with `, ...)`.
    /// The emitter appends a `DW_TAG_unspecified_parameters`
    /// child after the typed parameters when set.
    is_variadic: bool,
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
    /// True when mem2reg promoted this slot to a register; the frame
    /// slot no longer holds the value, so the DIE gets an empty
    /// location rather than a stale `DW_OP_fbreg`.
    promoted: bool,
    /// Source line of the declaration; surfaces as
    /// `DW_AT_decl_line` on the DIE. Zero when unknown.
    decl_line: u32,
    /// Element count for true local arrays. Drives DW_TAG_array_type
    /// emission. Zero for scalars and for parameters (the latter
    /// decay to pointers per C99 6.7.5.3p7).
    array_size: u32,
    /// c5 source_files index of the declaration's file. The emit
    /// pass maps this to a DWARF file_names index for the DIE's
    /// DW_AT_decl_file.
    decl_file: u32,
}

/// Native bytes from a function's `low_pc` to the first byte of
/// its body -- i.e. the size of the standard prologue emitted by
/// the arch lowerings. Used by the CFI emitter to
/// `DW_CFA_advance_loc` past the prologue before installing the
/// post-prologue CFA rule. Returns 0 for empty / DCE'd functions
/// where the body's PC isn't recoverable; the unwinder then
/// applies the post-prologue rule from PC = low_pc, which is
/// wrong inside the prologue but the function never executes
/// anyway.
fn prologue_size_for(ent_pc: usize, low_pc: usize, build: &Build) -> u32 {
    let body_start = build
        .func_prologue_native
        .get(&ent_pc)
        .copied()
        .unwrap_or(low_pc);
    if body_start <= low_pc {
        0
    } else {
        (body_start - low_pc) as u32
    }
}

/// One-past-the-last byte of user code in `build.text`. The PLT
/// trampoline pool is appended after the last user function;
/// both the line-table end_sequence and the last `Subprog`'s
/// `high_pc` must stop at the boundary so PLT-stub addresses
/// fall outside every DWARF range.
fn end_of_user_text(build: &Build) -> usize {
    build
        .plt_trampoline_offsets
        .first()
        .copied()
        .unwrap_or(build.text.len())
}

/// One [`PltSub`] per import in declaration order. Each
/// trampoline gets its own `DW_TAG_subprogram` DIE so debuggers
/// resolve a `bt` frame at the stub to a typed signature
/// (`malloc (size, ...)`) rather than just the symbol name. The
/// trampolines are emitted contiguously by
/// [`super::aarch64::emit_plt_trampolines`] /
/// [`super::x86_64::emit_plt_trampolines`], so their per-stub
/// size is the constant arithmetic mean -- which we derive from
/// the recorded offsets so the dwarf module stays free of
/// per-arch constants.
fn collect_plt_subprograms(
    build: &Build,
    target: Target,
    code_vmaddr: u64,
    strs: &mut StrTable,
) -> Vec<PltSub> {
    let imports = &build.imports.imports;
    if imports.is_empty() || build.plt_trampoline_offsets.is_empty() {
        return Vec::new();
    }
    debug_assert_eq!(
        imports.len(),
        build.plt_trampoline_offsets.len(),
        "trampoline-offset count must match import count"
    );
    let n = imports.len();
    // Per-stub size. Trampolines are emitted contiguously and
    // are uniform-sized per arch, so the delta between two
    // consecutive offsets is exact. The last-stub-to-text-end
    // delta would also work in isolation, but
    // `append_build_info` appends a NUL-terminated marker string
    // *after* the PLT pool to `build.text` -- so
    // `build.text.len() - offsets.last()` overshoots by the
    // marker bytes (the overshoot was visible as DW_AT_high_pc
    // = 0x1f instead of 0xc on the linked_list fixture).
    let stub_size = if n >= 2 {
        (build.plt_trampoline_offsets[1] - build.plt_trampoline_offsets[0]) as u64
    } else {
        // Single import: fall back to the per-arch constant. Has
        // to match `super::aarch64::emit_plt_trampolines`
        // (3 instructions = 12 bytes) /
        // `super::x86_64::emit_plt_trampolines` (1 jmp = 6
        // bytes).
        match target {
            Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64 => 12,
            Target::LinuxX64 | Target::WindowsX64 => 6,
        }
    };

    imports
        .iter()
        .enumerate()
        .map(|(i, imp)| {
            let off = build.plt_trampoline_offsets[i];
            // Synthetic per-param names: `arg0`, `arg1`, ... The
            // c5 binding doesn't track parameter names, but
            // gdb's `info args` and `bt` skip name-less entries
            // entirely. Synthetic names are interned once per
            // (import, slot) pair; the tiny duplication keeps
            // the writer side simple.
            let param_name_offs = (0..imp.param_types.len())
                .map(|slot| strs.intern(&format!("arg{slot}")))
                .collect();
            PltSub {
                name_off: strs.intern(&imp.local_name),
                low_pc: code_vmaddr + off as u64,
                high_pc: code_vmaddr + off as u64 + stub_size,
                return_type_tag: imp.return_type_tag,
                param_types: imp.param_types.clone(),
                param_name_offs,
                is_variadic: imp.is_variadic,
            }
        })
        .collect()
}

fn collect_subprograms(
    program: &Program,
    build: &Build,
    code_vmaddr: u64,
    strs: &mut StrTable,
) -> Vec<Subprog> {
    let mut out: Vec<Subprog> = Vec::new();

    // Iterate the per-function ent_pcs the lowering recorded
    // in emission order. Native start is
    // `pc_to_native[ent_pc]`; native end is the start of the
    // next function's emission (or `total_native` for the last).
    // A function's source name comes from `build.func_names`
    // (populated by the per-arch emit from `FunctionSsa::name`),
    // with `Program::source_functions[ent_pc]` as a fallback for
    // archive-reloaded units. The per-arch emit pushes
    // `(ent_pc, name)` pairs in lockstep, so an `ent_pc -> name`
    // map covers the sort-by-native-offset reorder below.
    let func_name_by_pc: BTreeMap<usize, alloc::string::String> = build
        .func_ent_pcs
        .iter()
        .copied()
        .zip(build.func_names.iter().cloned())
        .filter(|(_, n)| !n.is_empty())
        .collect();
    let mut ent_pcs: Vec<usize> = build.func_ent_pcs.clone();
    ent_pcs.sort_unstable_by_key(|&pc| build.pc_to_native.get(pc).copied().unwrap_or(usize::MAX));
    // Sentinel for end-of-last-function range. The PLT trampoline
    // pool is appended to `build.text` after the last user
    // function; addresses inside the pool must NOT fall inside any
    // user `Subprog`'s [low_pc, high_pc) range, or else gdb / lldb
    // attribute PLT-stub hits to the closing brace of the last
    // function. Stop the last range at the first trampoline byte
    // when the pool exists.
    let total_native = end_of_user_text(build);

    // c5's source-function tracking sometimes attributes
    // function entries to the wrong containing C function -- in
    // a large translation unit dozens of entries may carry the
    // same source-name even though their actual code belongs to
    // unrelated functions. Without disambiguation,
    // lldb's `b name` returns N matches and the user can't tell
    // which is the real one. Suffix duplicates with `.<N>` so
    // the legitimate first-occurrence keeps the bare name and
    // `b name` resolves to one location. The upstream c5
    // tracking is a separate fix (the suffixed names still
    // point at real code, so backtraces inside the
    // mis-attributed regions are no worse than they were).
    let mut name_seen: BTreeMap<alloc::string::String, u32> = BTreeMap::new();
    for (i, &ent_pc) in ent_pcs.iter().enumerate() {
        let raw_name = func_name_by_pc
            .get(&ent_pc)
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
            .pc_to_native
            .get(ent_pc)
            .copied()
            .unwrap_or(usize::MAX);
        if lo == usize::MAX {
            continue;
        }
        let hi = if let Some(&next_ent) = ent_pcs.get(i + 1) {
            build
                .pc_to_native
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
        // function-body close, indexed by the Ent's ent_pc
        // so a simple equality check groups them.
        let function_bc_pc = ent_pc as u64;
        let variables = program
            .variables
            .iter()
            .filter(|v| v.function_bc_pc == function_bc_pc)
            .map(|v| {
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
                SubprogVar {
                    name_off: strs.intern(&v.name),
                    is_parameter: v.is_parameter,
                    type_tag: v.type_tag,
                    // c5's slot -> byte conversion: positive (args)
                    // use 16-byte AAPCS64 slot stride starting at
                    // `(slot - 1) * 16` (so slot 2 -> +16, slot 3 ->
                    // +32). Negative (locals) use 8-byte stride. Mirror
                    // of `aarch64::lea_offset_bytes`. The x86_64 backend
                    // matches; both arches share this layout.
                    fp_byte_offset: if eff >= 2 { (eff - 1) * 16 } else { eff * 8 },
                    promoted: build
                        .promoted_local_slots
                        .get(&ent_pc)
                        .is_some_and(|slots| slots.contains(&v.fp_slot)),
                    decl_line: v.decl_line,
                    array_size: v.array_size,
                    decl_file: v.decl_file,
                }
            })
            .collect();

        out.push(Subprog {
            name_off,
            low_pc: code_vmaddr + lo as u64,
            high_pc: code_vmaddr + hi as u64,
            prologue_size: prologue_size_for(ent_pc, lo, build),
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

/// One entry in the type catalog. Sort order (derived from the
/// declaration order of the variants and the field order within
/// each variant) puts base DIEs first, then pointer chains grouped
/// by leaf and ordered by ascending depth, then struct DIEs by id,
/// then struct-pointer chains, then the `void *` placeholder. That
/// ordering matters for non-struct entries: a `Pointer` at depth
/// `N` references depth `N - 1`, so the pointee must already be
/// emitted. Struct member type-refs go through a precomputed
/// offset table (the layout pass) so mutually-recursive struct
/// fields work without a forward-decl pass.
#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord)]
enum CatalogEntry {
    /// Scalar base type. Direct DIE -- `DW_AT_name`, `DW_AT_byte_size`,
    /// `DW_AT_encoding`.
    Base(BaseTypeKey),
    /// Pointer chain rooted at `leaf` with `depth >= 1`. The DIE
    /// is a `DW_TAG_pointer_type` whose `DW_AT_type` points at
    /// `Pointer { leaf, depth - 1 }` for `depth > 1`, or at
    /// `Base(leaf)` for `depth == 1`.
    Pointer { leaf: BaseTypeKey, depth: u8 },
    /// Aggregate type by struct-registry id. The DIE is
    /// `DW_TAG_structure_type` (or `DW_TAG_union_type` for unions),
    /// with one `DW_TAG_member` child per `StructField`. Member
    /// type-refs are resolved through the catalog so a
    /// `struct A { struct B *b; }` works regardless of declaration
    /// order.
    Struct { id: u32 },
    /// Pointer chain rooted at a struct. `depth >= 1`; same DIE
    /// shape as `Pointer`, with `DW_AT_type` pointing at
    /// `StructPointer { id, depth - 1 }` for depth > 1 or
    /// `Struct { id }` for depth == 1.
    StructPointer { id: u32, depth: u8 },
    /// Placeholder `void *` for variables we can't classify (a
    /// type tag the c5 frontend produced that doesn't fit any
    /// band). Should be empty in well-formed programs but kept
    /// as a safe fallback so an unknown tag never crashes the
    /// emitter.
    VoidStar,
}

impl CatalogEntry {
    /// Bytes this entry's DIE consumes on the wire. The layout
    /// pass walks `catalog.entries` once with `die_size` to build
    /// a CU-relative offset for every entry, so mutually-recursive
    /// struct fields can pick up a target offset for an entry
    /// that hasn't been written yet. ULEB-encoded abbrev codes
    /// fit in a single byte for codes 1..127; we have 10, so the
    /// 1-byte assumption holds.
    fn die_size(&self, structs: &[StructDef]) -> u32 {
        match self {
            // abbrev(1) + name(4 strp) + byte_size(1) + encoding(1)
            CatalogEntry::Base(_) | CatalogEntry::VoidStar => 7,
            // abbrev(1) + byte_size(1) + type(4 ref4)
            CatalogEntry::Pointer { .. } | CatalogEntry::StructPointer { .. } => 6,
            CatalogEntry::Struct { id } => {
                // abbrev(1) + name(4) + byte_size(4 DATA4)
                let mut size: u32 = 1 + 4 + 4;
                if let Some(s) = structs.get(*id as usize) {
                    for f in &s.fields {
                        // member abbrev(1) + name(4) + type(4) + location(4)
                        size += 13;
                        if f.bit_width > 0 {
                            // + byte_size(1) + bit_offset(1) + bit_size(1)
                            size += 3;
                        }
                    }
                }
                // children-list terminator
                size += 1;
                size
            }
        }
    }
}

struct TypeCatalog {
    /// All entries in deterministic emission order. The `BTreeSet`
    /// ordering doubles as the wire order (see `CatalogEntry`'s
    /// docs); a flat `Vec` after collection lets us index by
    /// emission order.
    entries: Vec<CatalogEntry>,
    /// Per-base interned `DW_AT_name` offset. Pointer DIEs don't
    /// carry a name; the base they ultimately resolve to does.
    base_names: BTreeMap<BaseTypeKey, u32>,
    /// Per-struct interned `DW_AT_name` offset, keyed by struct
    /// id. Anonymous structs (empty source name) get a synthesised
    /// `struct@N` placeholder so DIE resolution still produces a
    /// non-empty string.
    struct_names: BTreeMap<u32, u32>,
    /// Per-struct interned member `DW_AT_name` offsets, keyed by
    /// struct id. The inner `Vec` aligns 1:1 with
    /// `StructDef::fields`.
    struct_member_names: BTreeMap<u32, Vec<u32>>,
    /// `DW_AT_name` for the placeholder `void *` DIE. Zero when
    /// the catalog has no `VoidStar` entry.
    void_star_name_off: u32,
}

impl TypeCatalog {
    fn collect(
        subs: &[Subprog],
        plt_subs: &[PltSub],
        strs: &mut StrTable,
        target: Target,
        structs: &[StructDef],
    ) -> Self {
        let mut entries: BTreeSet<CatalogEntry> = BTreeSet::new();
        // Walk every captured variable / parameter to seed the
        // catalog with the types user code references directly.
        for sub in subs {
            for v in &sub.variables {
                let entry = classify(v.type_tag, target);
                Self::insert_with_chain(&mut entries, entry);
            }
        }
        // Seed types from PLT signatures too -- both the
        // return type and each fixed parameter -- so the per-stub
        // `DW_TAG_subprogram` / `DW_TAG_formal_parameter` DIEs
        // can resolve their `DW_AT_type` refs through the same
        // catalog the user variables use. We need to coerce
        // Struct entries whose id isn't actually declared in
        // `structs` to `VoidStar`: bindings can name opaque
        // forward-declared aggregates (`FILE *`, `DIR *`) the
        // compiler never assigned a real id to, and the existing
        // emit path asserts on out-of-range ids.
        let plt_seed = |ty: i64| -> CatalogEntry {
            let raw = classify(ty, target);
            match raw {
                CatalogEntry::Struct { id } if (id as usize) >= structs.len() => {
                    CatalogEntry::VoidStar
                }
                CatalogEntry::StructPointer { id, .. } if (id as usize) >= structs.len() => {
                    CatalogEntry::VoidStar
                }
                other => other,
            }
        };
        for plt in plt_subs {
            Self::insert_with_chain(&mut entries, plt_seed(plt.return_type_tag));
            for &ty in &plt.param_types {
                Self::insert_with_chain(&mut entries, plt_seed(ty));
            }
        }

        // Transitive expansion: every Struct entry pulls in its
        // members' types, which can themselves pull in more
        // structs. Worklist over distinct struct ids; cycles are
        // broken by `visited`. Mutually-recursive structs (a
        // common shape in real C codebases) are fine because the
        // layout pass below resolves member type-refs against
        // precomputed offsets, not write-time positions.
        let mut visited: BTreeSet<u32> = BTreeSet::new();
        let mut queue: Vec<u32> = entries
            .iter()
            .filter_map(|e| match e {
                CatalogEntry::Struct { id } | CatalogEntry::StructPointer { id, .. } => Some(*id),
                _ => None,
            })
            .collect();
        while let Some(id) = queue.pop() {
            if !visited.insert(id) {
                continue;
            }
            let Some(s) = structs.get(id as usize) else {
                continue;
            };
            for f in &s.fields {
                let entry = classify(f.ty, target);
                Self::insert_with_chain(&mut entries, entry);
                if let CatalogEntry::Struct { id } | CatalogEntry::StructPointer { id, .. } = entry
                {
                    queue.push(id);
                }
            }
        }

        // Intern names. Bases first; then struct names + every
        // struct's member names (BTreeMap iteration is sorted, so
        // the strtab order is deterministic). Void* gets one if
        // any variable resolved that way.
        let mut base_names: BTreeMap<BaseTypeKey, u32> = BTreeMap::new();
        let mut struct_names: BTreeMap<u32, u32> = BTreeMap::new();
        let mut struct_member_names: BTreeMap<u32, Vec<u32>> = BTreeMap::new();
        let needs_void_star = entries.contains(&CatalogEntry::VoidStar);
        for entry in &entries {
            match entry {
                CatalogEntry::Base(key) => {
                    base_names
                        .entry(*key)
                        .or_insert_with(|| strs.intern(key.name));
                }
                CatalogEntry::Struct { id } => {
                    if let Some(s) = structs.get(*id as usize) {
                        let display = if s.name.is_empty() {
                            format!("struct@{id}")
                        } else {
                            s.name.clone()
                        };
                        struct_names
                            .entry(*id)
                            .or_insert_with(|| strs.intern(&display));
                        let members = s.fields.iter().map(|f| strs.intern(&f.name)).collect();
                        struct_member_names.entry(*id).or_insert(members);
                    }
                }
                _ => {}
            }
        }
        let void_star_name_off = if needs_void_star {
            strs.intern("void *")
        } else {
            0
        };

        TypeCatalog {
            entries: entries.into_iter().collect(),
            base_names,
            struct_names,
            struct_member_names,
            void_star_name_off,
        }
    }

    /// Insert `entry` and -- when it's a pointer chain -- every
    /// shallower chain entry plus the rooting type DIE, so the
    /// emission walk finds each level's pointee already present.
    /// Struct-rooted chains follow the same shape with `Struct {
    /// id }` as the eventual root.
    fn insert_with_chain(entries: &mut BTreeSet<CatalogEntry>, entry: CatalogEntry) {
        match entry {
            CatalogEntry::Pointer { leaf, depth } => {
                entries.insert(CatalogEntry::Base(leaf));
                for d in 1..=depth {
                    entries.insert(CatalogEntry::Pointer { leaf, depth: d });
                }
            }
            CatalogEntry::StructPointer { id, depth } => {
                entries.insert(CatalogEntry::Struct { id });
                for d in 1..=depth {
                    entries.insert(CatalogEntry::StructPointer { id, depth: d });
                }
            }
            other => {
                entries.insert(other);
            }
        }
    }
}

/// Resolve a c5 type tag to its catalog entry. Scalars become
/// `Base(...)`, pointer-to-scalar chains become `Pointer { leaf,
/// depth }`, struct values become `Struct { id }`, struct-pointer
/// chains become `StructPointer { id, depth }`. Anything we can't
/// classify falls back to `VoidStar`.
fn classify(ty: i64, target: Target) -> CatalogEntry {
    let unsigned = types::is_unsigned_ty(ty);
    let bare = types::strip_unsigned(ty);

    // Struct band: separate id + pointer-depth via the helpers
    // c5's frontend already uses (`struct_id_of`, `struct_ptr_depth`).
    if bare >= types::STRUCT_BASE {
        let id = types::struct_id_of(bare) as u32;
        let depth = types::struct_ptr_depth(bare) as u8;
        return if depth == 0 {
            CatalogEntry::Struct { id }
        } else {
            CatalogEntry::StructPointer { id, depth }
        };
    }

    let ptr_step = Ty::Ptr as i64;
    let band_size: i64 = 100;

    // Compute (leaf-tag, pointer-depth) by detecting which band
    // `bare` lives in. Each non-integer band sits at a fixed
    // offset; the integer family shares chars (even bare) and
    // ints (odd bare) in the [0, 100) range.
    let (leaf_tag, depth) = if bare < band_size {
        // Integer family: even = char, odd = int.
        let depth = (bare / ptr_step) as u8;
        let leaf = if bare % ptr_step == 0 {
            Ty::Char as i64
        } else {
            Ty::Int as i64
        };
        (leaf, depth)
    } else if (Ty::Float as i64..Ty::Float as i64 + band_size).contains(&bare) {
        let depth = ((bare - Ty::Float as i64) / ptr_step) as u8;
        (Ty::Float as i64, depth)
    } else if (Ty::Double as i64..Ty::Double as i64 + band_size).contains(&bare) {
        let depth = ((bare - Ty::Double as i64) / ptr_step) as u8;
        (Ty::Double as i64, depth)
    } else if (Ty::Long as i64..Ty::Long as i64 + band_size).contains(&bare) {
        let depth = ((bare - Ty::Long as i64) / ptr_step) as u8;
        (Ty::Long as i64, depth)
    } else if (Ty::Short as i64..Ty::Short as i64 + band_size).contains(&bare) {
        let depth = ((bare - Ty::Short as i64) / ptr_step) as u8;
        (Ty::Short as i64, depth)
    } else if (Ty::LongLong as i64..Ty::LongLong as i64 + band_size).contains(&bare) {
        let depth = ((bare - Ty::LongLong as i64) / ptr_step) as u8;
        (Ty::LongLong as i64, depth)
    } else if (Ty::Bool as i64..Ty::Bool as i64 + band_size).contains(&bare) {
        let depth = ((bare - Ty::Bool as i64) / ptr_step) as u8;
        (Ty::Bool as i64, depth)
    } else {
        return CatalogEntry::VoidStar;
    };

    let leaf_signed = if unsigned {
        leaf_tag | types::UNSIGNED_BIT
    } else {
        leaf_tag
    };
    let leaf_key = match base_key_for_leaf(leaf_signed, target) {
        Some(k) => k,
        None => return CatalogEntry::VoidStar,
    };
    if depth == 0 {
        CatalogEntry::Base(leaf_key)
    } else {
        CatalogEntry::Pointer {
            leaf: leaf_key,
            depth,
        }
    }
}

/// Build a `BaseTypeKey` for a *bare* leaf scalar tag (no pointer
/// depth). Caller handles the pointer extraction; this just maps
/// the leaf-band tag to its DWARF wire-form attributes.
fn base_key_for_leaf(leaf_tag: i64, target: Target) -> Option<BaseTypeKey> {
    let unsigned = types::is_unsigned_ty(leaf_tag);
    let bare = types::strip_unsigned(leaf_tag);

    let key = if bare == Ty::Bool as i64 {
        BaseTypeKey {
            name: "_Bool",
            byte_size: 1,
            encoding: DW_ATE_BOOLEAN,
        }
    } else if bare == Ty::Char as i64 {
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
            encoding: if unsigned {
                DW_ATE_UNSIGNED
            } else {
                DW_ATE_SIGNED
            },
        }
    } else if bare == Ty::Int as i64 {
        BaseTypeKey {
            name: if unsigned { "unsigned int" } else { "int" },
            byte_size: 4,
            encoding: if unsigned {
                DW_ATE_UNSIGNED
            } else {
                DW_ATE_SIGNED
            },
        }
    } else if bare == Ty::Long as i64 {
        // LP64: 8 bytes; LLP64 (Windows): 4 bytes. Matches the
        // c5 codegen's load/store width pick (`load_op_for`).
        let byte_size = if target.is_windows() { 4 } else { 8 };
        BaseTypeKey {
            name: if unsigned { "unsigned long" } else { "long" },
            byte_size,
            encoding: if unsigned {
                DW_ATE_UNSIGNED
            } else {
                DW_ATE_SIGNED
            },
        }
    } else if bare == Ty::LongLong as i64 {
        BaseTypeKey {
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
        // A scalar `float` is a 4-byte IEEE-754 single (sizeof(float)==4,
        // LoadKind::F32 reads 4 bytes); the relocatable DWARF path agrees.
        BaseTypeKey {
            name: "float",
            byte_size: 4,
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

// Abbreviation codes. `build_debug_abbrev` declares each entry under
// its code; `build_debug_info` and `emit_type_die` reference the same
// codes when starting a DIE. Naming them keeps the two sides legible
// and matches the ET_REL emitter (`dwarf_reloc`).
const ABBREV_COMPILE_UNIT: u64 = 1;
const ABBREV_SUBPROGRAM: u64 = 2;
const ABBREV_BASE_TYPE: u64 = 3;
const ABBREV_VARIABLE: u64 = 4;
const ABBREV_FORMAL_PARAMETER: u64 = 5;
const ABBREV_POINTER_TYPE: u64 = 6;
const ABBREV_STRUCTURE_TYPE: u64 = 7;
const ABBREV_UNION_TYPE: u64 = 8;
const ABBREV_MEMBER: u64 = 9;
const ABBREV_BITFIELD_MEMBER: u64 = 10;
const ABBREV_PLT_SUBPROGRAM: u64 = 11;
const ABBREV_PLT_FORMAL_PARAMETER: u64 = 12;
const ABBREV_UNSPECIFIED_PARAMETERS: u64 = 13;
const ABBREV_PLT_FORMAL_PARAMETER_LOC: u64 = 14;
const ABBREV_ARRAY_TYPE: u64 = 15;
const ABBREV_SUBRANGE_TYPE: u64 = 16;
const ABBREV_ENUMERATION_TYPE: u64 = 17;
const ABBREV_ENUMERATOR: u64 = 18;

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
    attrs: &'static [(u32, u32)],
}

const ABBREV_DECLS: &[AbbrevDecl] = &[
    // compile_unit with subprogram children.
    AbbrevDecl {
        code: ABBREV_COMPILE_UNIT,
        tag: DW_TAG_COMPILE_UNIT,
        has_children: true,
        attrs: &[
            (DW_AT_PRODUCER, DW_FORM_STRP),
            (DW_AT_LANGUAGE, DW_FORM_DATA1),
            (DW_AT_NAME, DW_FORM_STRP),
            (DW_AT_COMP_DIR, DW_FORM_STRP),
            (DW_AT_LOW_PC, DW_FORM_ADDR),
            (DW_AT_HIGH_PC, DW_FORM_DATA8),
            (DW_AT_STMT_LIST, DW_FORM_SEC_OFFSET),
        ],
    },
    // subprogram with variable / parameter children. DW_AT_frame_base
    // resolves DW_OP_fbreg references against c5's frame pointer.
    // DW_AT_prototyped is always set: c5 rejects K&R declarators per
    // C99 6.7.6.3p14. DW_AT_calling_convention pins DW_CC_normal.
    AbbrevDecl {
        code: ABBREV_SUBPROGRAM,
        tag: DW_TAG_SUBPROGRAM,
        has_children: true,
        attrs: &[
            (DW_AT_NAME, DW_FORM_STRP),
            (DW_AT_LOW_PC, DW_FORM_ADDR),
            (DW_AT_HIGH_PC, DW_FORM_DATA8),
            (DW_AT_EXTERNAL, DW_FORM_FLAG_PRESENT),
            (DW_AT_PROTOTYPED, DW_FORM_FLAG_PRESENT),
            (DW_AT_CALLING_CONVENTION, DW_FORM_DATA1),
            (DW_AT_FRAME_BASE, DW_FORM_EXPRLOC),
        ],
    },
    // base_type -- one per distinct c5 scalar tag, plus the void*
    // placeholder pointer / struct variables fall back to.
    AbbrevDecl {
        code: ABBREV_BASE_TYPE,
        tag: DW_TAG_BASE_TYPE,
        has_children: false,
        attrs: &[
            (DW_AT_NAME, DW_FORM_STRP),
            (DW_AT_BYTE_SIZE, DW_FORM_DATA1),
            (DW_AT_ENCODING, DW_FORM_DATA1),
        ],
    },
    // variable (local). DW_AT_location is DW_OP_fbreg <sleb128>,
    // resolved via the subprogram's DW_AT_frame_base.
    AbbrevDecl {
        code: ABBREV_VARIABLE,
        tag: DW_TAG_VARIABLE,
        has_children: false,
        attrs: &[
            (DW_AT_NAME, DW_FORM_STRP),
            (DW_AT_TYPE, DW_FORM_REF4),
            (DW_AT_LOCATION, DW_FORM_EXPRLOC),
            (DW_AT_DECL_FILE, DW_FORM_UDATA),
            (DW_AT_DECL_LINE, DW_FORM_UDATA),
        ],
    },
    // formal_parameter -- the variable shape under a parameter tag.
    AbbrevDecl {
        code: ABBREV_FORMAL_PARAMETER,
        tag: DW_TAG_FORMAL_PARAMETER,
        has_children: false,
        attrs: &[
            (DW_AT_NAME, DW_FORM_STRP),
            (DW_AT_TYPE, DW_FORM_REF4),
            (DW_AT_LOCATION, DW_FORM_EXPRLOC),
            (DW_AT_DECL_FILE, DW_FORM_UDATA),
            (DW_AT_DECL_LINE, DW_FORM_UDATA),
        ],
    },
    // pointer_type -- 8-byte pointer; DW_AT_type refs the pointee
    // (the next pointer DIE in a chain, or a base / struct DIE).
    AbbrevDecl {
        code: ABBREV_POINTER_TYPE,
        tag: DW_TAG_POINTER_TYPE,
        has_children: false,
        attrs: &[(DW_AT_BYTE_SIZE, DW_FORM_DATA1), (DW_AT_TYPE, DW_FORM_REF4)],
    },
    // structure_type -- DW_AT_byte_size is DATA4 since aggregates
    // routinely exceed 256 bytes; children are DW_TAG_member DIEs.
    AbbrevDecl {
        code: ABBREV_STRUCTURE_TYPE,
        tag: DW_TAG_STRUCTURE_TYPE,
        has_children: true,
        attrs: &[(DW_AT_NAME, DW_FORM_STRP), (DW_AT_BYTE_SIZE, DW_FORM_DATA4)],
    },
    // union_type -- structure_type's shape; members overlap at 0.
    AbbrevDecl {
        code: ABBREV_UNION_TYPE,
        tag: DW_TAG_UNION_TYPE,
        has_children: true,
        attrs: &[(DW_AT_NAME, DW_FORM_STRP), (DW_AT_BYTE_SIZE, DW_FORM_DATA4)],
    },
    // member -- a regular (non-bitfield) field. DW_AT_data_member_-
    // location is the byte offset from the aggregate start.
    AbbrevDecl {
        code: ABBREV_MEMBER,
        tag: DW_TAG_MEMBER,
        has_children: false,
        attrs: &[
            (DW_AT_NAME, DW_FORM_STRP),
            (DW_AT_TYPE, DW_FORM_REF4),
            (DW_AT_DATA_MEMBER_LOCATION, DW_FORM_DATA4),
        ],
    },
    // bitfield member -- DWARF 3-style byte_size + bit_offset +
    // bit_size on top of the regular member triple; lldb / gdb both
    // accept this shape on DWARF 4 input.
    AbbrevDecl {
        code: ABBREV_BITFIELD_MEMBER,
        tag: DW_TAG_MEMBER,
        has_children: false,
        attrs: &[
            (DW_AT_NAME, DW_FORM_STRP),
            (DW_AT_TYPE, DW_FORM_REF4),
            (DW_AT_DATA_MEMBER_LOCATION, DW_FORM_DATA4),
            (DW_AT_BYTE_SIZE, DW_FORM_DATA1),
            (DW_AT_BIT_OFFSET, DW_FORM_DATA1),
            (DW_AT_BIT_SIZE, DW_FORM_DATA1),
        ],
    },
    // PLT-trampoline subprogram -- abbrev 2's shape plus DW_AT_type
    // for the return, without DW_AT_frame_base (no c5 frame); allows
    // formal_parameter / unspecified_parameters children.
    AbbrevDecl {
        code: ABBREV_PLT_SUBPROGRAM,
        tag: DW_TAG_SUBPROGRAM,
        has_children: true,
        attrs: &[
            (DW_AT_NAME, DW_FORM_STRP),
            (DW_AT_LOW_PC, DW_FORM_ADDR),
            (DW_AT_HIGH_PC, DW_FORM_DATA8),
            (DW_AT_EXTERNAL, DW_FORM_FLAG_PRESENT),
            (DW_AT_TYPE, DW_FORM_REF4),
        ],
    },
    // PLT formal_parameter that spilled past the ABI register window:
    // synthetic name + type, no location.
    AbbrevDecl {
        code: ABBREV_PLT_FORMAL_PARAMETER,
        tag: DW_TAG_FORMAL_PARAMETER,
        has_children: false,
        attrs: &[(DW_AT_NAME, DW_FORM_STRP), (DW_AT_TYPE, DW_FORM_REF4)],
    },
    // unspecified_parameters -- the `...` of a variadic prototype.
    // The tag alone signals the ellipsis.
    AbbrevDecl {
        code: ABBREV_UNSPECIFIED_PARAMETERS,
        tag: DW_TAG_UNSPECIFIED_PARAMETERS,
        has_children: false,
        attrs: &[],
    },
    // PLT formal_parameter with a known register location: abbrev 12
    // plus DW_AT_location so gdb's `bt` reads the value from the
    // ABI-pinned register. Only the first N register-resident args.
    AbbrevDecl {
        code: ABBREV_PLT_FORMAL_PARAMETER_LOC,
        tag: DW_TAG_FORMAL_PARAMETER,
        has_children: false,
        attrs: &[
            (DW_AT_NAME, DW_FORM_STRP),
            (DW_AT_TYPE, DW_FORM_REF4),
            (DW_AT_LOCATION, DW_FORM_EXPRLOC),
        ],
    },
    // array_type -- a true local array; DW_AT_type refs the element
    // type and a DW_TAG_subrange_type child carries the bound.
    // Parameters decay to pointers per C99 6.7.5.3p7.
    AbbrevDecl {
        code: ABBREV_ARRAY_TYPE,
        tag: DW_TAG_ARRAY_TYPE,
        has_children: true,
        attrs: &[(DW_AT_TYPE, DW_FORM_REF4)],
    },
    // subrange_type -- DW_AT_upper_bound = element_count - 1 per
    // DWARF 4 5.13.
    AbbrevDecl {
        code: ABBREV_SUBRANGE_TYPE,
        tag: DW_TAG_SUBRANGE_TYPE,
        has_children: false,
        attrs: &[(DW_AT_UPPER_BOUND, DW_FORM_UDATA)],
    },
    // enumeration_type -- tagged C99 6.7.2.2 enums; the enum is `int`
    // in c5 so DW_AT_byte_size is 4. DW_FORM_string keeps the name
    // inline rather than threading the sealed string table.
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
];

fn build_debug_abbrev() -> Vec<u8> {
    let mut buf = Vec::with_capacity(64);
    for d in ABBREV_DECLS {
        write_uleb128(&mut buf, d.code);
        write_uleb128(&mut buf, d.tag as u64);
        buf.push(if d.has_children {
            DW_CHILDREN_YES
        } else {
            DW_CHILDREN_NO
        });
        for (attr, form) in d.attrs {
            write_attr(&mut buf, *attr, *form);
        }
        // End of this declaration's attribute list.
        write_uleb128(&mut buf, 0);
        write_uleb128(&mut buf, 0);
    }
    // End of the abbreviation table.
    write_uleb128(&mut buf, 0);
    buf
}

/// DWARF register number for the `slot`-th integer / pointer arg
/// in `target`'s calling convention, or `None` if the slot
/// overflows the ABI's register window (and thus spills to stack
/// at libc-side offsets we can't describe).
///
/// Mappings:
///
/// * AAPCS64 (every aarch64 OS): args 0..7 in DWARF regs 0..7
///   (= x0..x7).
/// * SysV x86_64 (Linux): args 0..5 in DWARF regs
///   `[5, 4, 1, 2, 8, 9]` (RDI, RSI, RDX, RCX, R8, R9). DWARF
///   x86_64 numbering puts RDX at 1 and RCX at 2 -- swapped
///   relative to the c5 codegen's internal register codes.
/// * Win64 x86_64 (Windows): args 0..3 in DWARF regs
///   `[2, 1, 8, 9]` (RCX, RDX, R8, R9).
fn dwarf_arg_reg(target: Target, slot: usize) -> Option<u8> {
    match target {
        Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64 => {
            (slot < 8).then_some(slot as u8)
        }
        Target::LinuxX64 => [5u8, 4, 1, 2, 8, 9].get(slot).copied(),
        Target::WindowsX64 => [2u8, 1, 8, 9].get(slot).copied(),
    }
}

fn write_attr(buf: &mut Vec<u8>, attr: u32, form: u32) {
    write_uleb128(buf, attr as u64);
    write_uleb128(buf, form as u64);
}

/// Bytes a DW_TAG_array_type DIE plus its DW_TAG_subrange_type
/// child consume. abbrev_array(1) + DW_AT_type ref4(4)
/// + abbrev_subrange(1) + DW_AT_upper_bound uleb128(N)
/// + children_terminator(1). Used by the layout pass so struct
/// member DW_AT_type can forward-ref into the array DIE block.
fn array_die_size(count: u32) -> u32 {
    let upper = count.saturating_sub(1) as u64;
    let upper_bytes = uleb128_byte_len(upper);
    1 + 4 + 1 + upper_bytes + 1
}

fn uleb128_byte_len(mut v: u64) -> u32 {
    let mut n = 0;
    loop {
        n += 1;
        v >>= 7;
        if v == 0 {
            return n;
        }
    }
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
    plt_subs: &[PltSub],
    target: Target,
    structs: &[StructDef],
    enums: &[super::super::compiler::EnumDef],
) -> Vec<u8> {
    // Build the body first so we know its size before prepending
    // the unit header. CU-relative `DW_FORM_ref4` offsets are
    // body-position + `DebugInfoUnitHeader::SIZE`.
    let mut body: Vec<u8> = Vec::with_capacity(64 + subs.len() * 48);

    // CU DIE: abbrev 1.
    write_uleb128(&mut body, ABBREV_COMPILE_UNIT);
    body.extend_from_slice(&producer_off.to_le_bytes());
    body.push(DW_LANG_C99);
    body.extend_from_slice(&cu_name_off.to_le_bytes());
    body.extend_from_slice(&comp_dir_off.to_le_bytes());
    body.extend_from_slice(&cu_low_pc.to_le_bytes());
    body.extend_from_slice(&cu_size.to_le_bytes());
    body.extend_from_slice(&line_unit_off.to_le_bytes());

    // Collect every (element_type, count) pair the unit's arrays
    // need a DIE for. Sources: non-parameter variables with
    // `array_size > 0` (C99 6.7.5.3p7 decays parameter arrays to
    // pointers) and struct fields with `array_size > 0`. Element
    // must be scalar / pointer-to-scalar -- aggregate elements
    // would need an aggregate DIE that doesn't exist yet at the
    // array DIE's reserved position.
    let mut array_pairs: BTreeSet<(CatalogEntry, u32)> = BTreeSet::new();
    for s in subs {
        for v in &s.variables {
            if v.array_size == 0 || v.is_parameter {
                continue;
            }
            let entry = classify(v.type_tag, target);
            if matches!(entry, CatalogEntry::Base(_) | CatalogEntry::Pointer { .. }) {
                array_pairs.insert((entry, v.array_size));
            }
        }
    }
    // Restrict the struct walk to aggregates the catalog actually
    // emits a DIE for. The TypeCatalog only pulls in structs that
    // are transitively reachable from variables / PLT signatures;
    // collecting array pairs from unreferenced structs would name
    // element-type DIEs the layout pass never reserved space for.
    let referenced_struct_ids: BTreeSet<u32> = catalog
        .entries
        .iter()
        .filter_map(|e| match e {
            CatalogEntry::Struct { id } | CatalogEntry::StructPointer { id, .. } => Some(*id),
            _ => None,
        })
        .collect();
    for id in &referenced_struct_ids {
        let Some(s) = structs.get(*id as usize) else {
            continue;
        };
        for f in &s.fields {
            if f.array_size <= 0 || f.bit_width > 0 {
                continue;
            }
            let entry = classify(f.ty, target);
            if matches!(entry, CatalogEntry::Base(_) | CatalogEntry::Pointer { .. }) {
                array_pairs.insert((entry, f.array_size as u32));
            }
        }
    }

    // Layout pass: precompute the CU-relative offset every
    // catalog entry and every array DIE will land at, before
    // writing any of them. Struct fields with array_size > 0
    // reach forward via DW_FORM_ref4 to array DIEs that come
    // after the catalog, so write-time positions aren't enough.
    // `die_size` is deterministic, so the pass is exact.
    let mut entry_offsets: BTreeMap<CatalogEntry, u32> = BTreeMap::new();
    let mut array_offsets: BTreeMap<(CatalogEntry, u32), u32> = BTreeMap::new();
    {
        let mut cursor = (body.len() as u32) + DebugInfoUnitHeader::SIZE;
        for entry in &catalog.entries {
            entry_offsets.insert(*entry, cursor);
            cursor += entry.die_size(structs);
        }
        for &(entry, count) in &array_pairs {
            array_offsets.insert((entry, count), cursor);
            cursor += array_die_size(count);
        }
    }

    // Emit pass: walk entries in catalog order. Each write
    // advances `body` by exactly `die_size` bytes; we sanity-check
    // that against the precomputed offset to catch encoding
    // drift (an attribute width that doesn't match the abbrev
    // declaration would be silent corruption otherwise).
    for entry in &catalog.entries {
        let pre_pos = (body.len() as u32) + DebugInfoUnitHeader::SIZE;
        debug_assert_eq!(
            pre_pos, entry_offsets[entry],
            "die_size disagreed with the emitter for {entry:?}",
        );
        emit_type_die(
            entry,
            &mut body,
            catalog,
            structs,
            &entry_offsets,
            &array_offsets,
            target,
        );
    }

    // Array DIEs at their precomputed offsets. BTreeMap iteration
    // is ordered by key, matching the layout pass.
    for (&(entry, count), &arr_off) in &array_offsets {
        debug_assert_eq!(
            arr_off,
            (body.len() as u32) + DebugInfoUnitHeader::SIZE,
            "array layout disagreed with the emitter for ({entry:?}, {count})",
        );
        let elem_off = entry_offsets[&entry];
        write_uleb128(&mut body, ABBREV_ARRAY_TYPE);
        body.extend_from_slice(&elem_off.to_le_bytes());
        // Subrange child: upper_bound = count - 1.
        write_uleb128(&mut body, ABBREV_SUBRANGE_TYPE);
        write_uleb128(&mut body, (count as u64).saturating_sub(1));
        // Children-list terminator for the array_type DIE.
        body.push(0);
    }

    // DW_TAG_enumeration_type DIEs for every tagged enum the
    // parser captured. Standalone -- no variable references them
    // because c5 collapses enums to `int`. Strings ride inline
    // via DW_FORM_string so the emitter doesn't have to extend
    // the sealed catalog string table at this point.
    for ed in enums {
        if ed.name.is_empty() || ed.constants.is_empty() {
            continue;
        }
        write_uleb128(&mut body, ABBREV_ENUMERATION_TYPE);
        body.extend_from_slice(ed.name.as_bytes());
        body.push(0);
        body.push(4);
        for (cname, cval) in &ed.constants {
            write_uleb128(&mut body, ABBREV_ENUMERATOR);
            body.extend_from_slice(cname.as_bytes());
            body.push(0);
            write_sleb128(&mut body, *cval);
        }
        body.push(0);
    }

    // Subprogram children, each with its own variable /
    // formal_parameter children.
    for s in subs {
        write_uleb128(&mut body, ABBREV_SUBPROGRAM);
        body.extend_from_slice(&s.name_off.to_le_bytes());
        body.extend_from_slice(&s.low_pc.to_le_bytes());
        body.extend_from_slice(&(s.high_pc - s.low_pc).to_le_bytes());
        // DW_AT_external is DW_FORM_flag_present -- no bytes.
        // DW_AT_prototyped is DW_FORM_flag_present -- no bytes.
        // DW_AT_calling_convention: DW_CC_normal pins user-defined
        // functions to the host C ABI (SysV / Win64 / AAPCS64).
        body.push(DW_CC_NORMAL);
        // DW_AT_frame_base (DW_FORM_exprloc): "frame base is the
        // frame pointer + 0" -- DW_OP_breg29 (x29) on aarch64,
        // DW_OP_breg6 (rbp) on x86_64. exprloc length is 2 (opcode +
        // sleb128(0)).
        let frame_base_breg = match target {
            Target::LinuxX64 | Target::WindowsX64 => DW_OP_BREG6,
            Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64 => DW_OP_BREG29,
        };
        write_uleb128(&mut body, 2);
        body.push(frame_base_breg);
        body.push(0);

        // Variable / formal_parameter children. Order parameters
        // first; lldb's frame-variable ordering matches
        // declaration order, and c5's single-pass capture lands
        // them sorted on `fp_byte_offset` after the split.
        let mut sorted: Vec<&SubprogVar> = s.variables.iter().collect();
        sorted.sort_by_key(|v| (!v.is_parameter, v.fp_byte_offset));
        for v in sorted {
            let abbrev = if v.is_parameter {
                ABBREV_FORMAL_PARAMETER
            } else {
                ABBREV_VARIABLE
            };
            write_uleb128(&mut body, abbrev);
            body.extend_from_slice(&v.name_off.to_le_bytes());
            // Resolve this variable's c5 type tag through the
            // catalog: scalar -> Base DIE, pointer-chain ->
            // Pointer DIE at the right depth, struct / unknown ->
            // VoidStar placeholder. The catalog's collect() walks
            // every captured variable, so a lookup miss is
            // impossible.
            let entry = classify(v.type_tag, target);
            let elem_off = *entry_offsets
                .get(&entry)
                .expect("catalog includes every entry produced by classify()");
            // True local arrays reference the array_type DIE if one
            // was reserved for this (element, count) pair above;
            // every other variable references the element / scalar
            // / pointer DIE directly.
            let type_off = if v.array_size > 0 && !v.is_parameter {
                array_offsets
                    .get(&(entry, v.array_size))
                    .copied()
                    .unwrap_or(elem_off)
            } else {
                elem_off
            };
            body.extend_from_slice(&type_off.to_le_bytes());
            // Location: DW_OP_fbreg <sleb128 offset-from-frame-base>.
            // A slot mem2reg promoted to a register no longer holds
            // the value; emit an empty location so the debugger reports
            // it optimized out rather than reading stale frame memory.
            if v.promoted {
                write_uleb128(&mut body, 0);
            } else {
                let mut loc: Vec<u8> = Vec::with_capacity(8);
                loc.push(DW_OP_FBREG);
                write_sleb128(&mut loc, v.fp_byte_offset);
                write_uleb128(&mut body, loc.len() as u64);
                body.extend_from_slice(&loc);
            }
            // DW_AT_decl_file (ULEB128) -- c5's `source_files` is
            // 0-indexed with the primary TU at 0; the DWARF
            // file_names table is 1-indexed with the primary file
            // at slot 1, so emit `decl_file + 1`.
            write_uleb128(&mut body, v.decl_file as u64 + 1);
            // DW_AT_decl_line (ULEB128).
            write_uleb128(&mut body, v.decl_line as u64);
        }
        // Children-list terminator for this subprogram.
        body.push(0);
    }

    // Emit one DW_TAG_subprogram per PLT trampoline. Lets
    // gdb / lldb show typed signatures (`malloc (size, ...)`)
    // when a `bt` frame points into the stub.
    //
    // Bindings can name opaque forward-declared aggregates
    // (`FILE *`, `DIR *`) the compiler never assigned a real
    // struct id to. Coerce those to `VoidStar` so the lookup
    // hits an entry the catalog actually placed -- mirrors the
    // seeding rule in `TypeCatalog::collect`.
    let plt_classify = |ty: i64| -> CatalogEntry {
        let raw = classify(ty, target);
        match raw {
            CatalogEntry::Struct { id } if (id as usize) >= structs.len() => CatalogEntry::VoidStar,
            CatalogEntry::StructPointer { id, .. } if (id as usize) >= structs.len() => {
                CatalogEntry::VoidStar
            }
            other => other,
        }
    };
    for plt in plt_subs {
        // Abbrev 11: name, low_pc, high_pc, external, type.
        write_uleb128(&mut body, ABBREV_PLT_SUBPROGRAM);
        body.extend_from_slice(&plt.name_off.to_le_bytes());
        body.extend_from_slice(&plt.low_pc.to_le_bytes());
        body.extend_from_slice(&(plt.high_pc - plt.low_pc).to_le_bytes());
        // DW_AT_external = flag_present, no bytes.
        // DW_AT_type -> CU-relative ref4. classify(0) returns
        // `Base(char)` -- a usable fallback when the parser hasn't
        // seen the prototype (return_type_tag stays 0). Imperfect
        // for `void` returns (we'd render them as `char`), but no
        // worse than the pre-#67 "in malloc ()" with no signature.
        let ret_entry = plt_classify(plt.return_type_tag);
        let ret_off = *entry_offsets
            .get(&ret_entry)
            .expect("catalog includes every entry produced by plt_classify()");
        body.extend_from_slice(&ret_off.to_le_bytes());

        // One DW_TAG_formal_parameter per fixed param. Args that
        // fit in the ABI's int_arg_reg window get abbrev 14 with
        // a `DW_OP_regN` location so gdb's `bt` reads the value
        // out of the right calling-convention register at the
        // moment of the call. Args beyond the window spill to
        // stack at libc-side offsets we can't describe -- they
        // fall back to abbrev 12 (type-only). A binding with no
        // prototype seen has `param_types` empty; the subprogram
        // still gets the name + return type, just no parameters.
        for (slot, &ty) in plt.param_types.iter().enumerate() {
            let entry = plt_classify(ty);
            let type_off = *entry_offsets
                .get(&entry)
                .expect("catalog includes every entry produced by plt_classify()");
            let name_off = plt.param_name_offs[slot];
            match dwarf_arg_reg(target, slot) {
                Some(reg) => {
                    write_uleb128(&mut body, ABBREV_PLT_FORMAL_PARAMETER_LOC);
                    body.extend_from_slice(&name_off.to_le_bytes());
                    body.extend_from_slice(&type_off.to_le_bytes());
                    // DW_OP_reg<N> is one byte for N <= 31; every
                    // calling convention we support fits in that
                    // range (max is x86_64's R9 = DWARF 9).
                    body.push(1);
                    body.push(DW_OP_REG_BASE + reg);
                }
                None => {
                    write_uleb128(&mut body, ABBREV_PLT_FORMAL_PARAMETER);
                    body.extend_from_slice(&name_off.to_le_bytes());
                    body.extend_from_slice(&type_off.to_le_bytes());
                }
            }
        }
        // Abbrev 13: variadic ellipsis. `printf` and friends
        // surface as `printf(char *, ...)` rather than just
        // `printf(char *)`.
        if plt.is_variadic {
            write_uleb128(&mut body, ABBREV_UNSPECIFIED_PARAMETERS);
        }
        // Children-list terminator for this PLT subprogram.
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

/// Emit one type DIE into `body`. Walks the entry's variant,
/// pulling pointee / member references out of `entry_offsets`
/// (built by the layout pass). The byte count this writes must
/// match `entry.die_size(structs)` exactly -- the layout pass
/// relied on it -- which is why the abbrev / form widths here
/// mirror the abbrev table verbatim.
#[allow(clippy::too_many_arguments)]
fn emit_type_die(
    entry: &CatalogEntry,
    body: &mut Vec<u8>,
    catalog: &TypeCatalog,
    structs: &[StructDef],
    entry_offsets: &BTreeMap<CatalogEntry, u32>,
    array_offsets: &BTreeMap<(CatalogEntry, u32), u32>,
    target: Target,
) {
    match entry {
        CatalogEntry::Base(key) => {
            let name_off = catalog
                .base_names
                .get(key)
                .copied()
                .expect("collect() interned every base in base_names");
            write_uleb128(body, ABBREV_BASE_TYPE);
            body.extend_from_slice(&name_off.to_le_bytes());
            body.push(key.byte_size);
            body.push(key.encoding);
        }
        CatalogEntry::Pointer { leaf, depth } => {
            let pointee = if *depth == 1 {
                CatalogEntry::Base(*leaf)
            } else {
                CatalogEntry::Pointer {
                    leaf: *leaf,
                    depth: depth - 1,
                }
            };
            let pointee_off = *entry_offsets
                .get(&pointee)
                .expect("chain insertion guarantees the pointee was placed");
            write_uleb128(body, ABBREV_POINTER_TYPE);
            body.push(8);
            body.extend_from_slice(&pointee_off.to_le_bytes());
        }
        CatalogEntry::StructPointer { id, depth } => {
            let pointee = if *depth == 1 {
                CatalogEntry::Struct { id: *id }
            } else {
                CatalogEntry::StructPointer {
                    id: *id,
                    depth: depth - 1,
                }
            };
            let pointee_off = *entry_offsets
                .get(&pointee)
                .expect("chain insertion guarantees the pointee was placed");
            write_uleb128(body, ABBREV_POINTER_TYPE);
            body.push(8);
            body.extend_from_slice(&pointee_off.to_le_bytes());
        }
        CatalogEntry::Struct { id } => {
            let s = structs
                .get(*id as usize)
                .expect("Struct entries only land in the catalog when the id is in-range");
            let abbrev = if s.is_union {
                ABBREV_UNION_TYPE
            } else {
                ABBREV_STRUCTURE_TYPE
            };
            let name_off = catalog
                .struct_names
                .get(id)
                .copied()
                .expect("collect() interned every struct name");
            write_uleb128(body, abbrev);
            body.extend_from_slice(&name_off.to_le_bytes());
            // DW_AT_byte_size as DATA4 -- structs over 256 bytes
            // happen routinely; multi-KB aggregates aren't
            // unusual.
            body.extend_from_slice(&(s.size as u32).to_le_bytes());

            let member_names = catalog
                .struct_member_names
                .get(id)
                .expect("collect() interned every struct's member names alongside the name");
            for (i, f) in s.fields.iter().enumerate() {
                let member_name_off = member_names[i];
                // Resolve member type. Arrays decay to the
                // element type DIE today; a follow-up can emit
                // `DW_TAG_array_type` so `ptype` shows
                // `T xs[N]` instead of just `T xs`. The offsets
                // for subsequent fields are already correct
                // because c5 baked the array stride into the
                // member offsets at parse time.
                let member_entry = classify(f.ty, target);
                let elem_off = *entry_offsets
                    .get(&member_entry)
                    .expect("collect() walked every struct field's type into the catalog");
                // True field array: ref the array_type DIE if one
                // was reserved for this (element, count) pair.
                // Bitfields keep the element ref because they
                // aren't arrays in any case.
                let member_type_off = if f.array_size > 0 && f.bit_width == 0 {
                    array_offsets
                        .get(&(member_entry, f.array_size as u32))
                        .copied()
                        .unwrap_or(elem_off)
                } else {
                    elem_off
                };

                if f.bit_width == 0 {
                    // Regular member: abbrev 9.
                    write_uleb128(body, ABBREV_MEMBER);
                    body.extend_from_slice(&member_name_off.to_le_bytes());
                    body.extend_from_slice(&member_type_off.to_le_bytes());
                    body.extend_from_slice(&(f.offset as u32).to_le_bytes());
                } else {
                    // Bitfield: abbrev 10. c5 packs bitfields
                    // into 8-byte storage units; convert c5's
                    // LSB-relative `bit_offset` to DWARF v4's
                    // MSB-relative `DW_AT_bit_offset` on
                    // little-endian targets:
                    //   dwarf_bit_offset = 64 - lsb_offset - width
                    write_uleb128(body, ABBREV_BITFIELD_MEMBER);
                    body.extend_from_slice(&member_name_off.to_le_bytes());
                    body.extend_from_slice(&member_type_off.to_le_bytes());
                    body.extend_from_slice(&(f.offset as u32).to_le_bytes());
                    body.push(8); // DW_AT_byte_size: storage unit is 8 bytes.
                    let dwarf_bit_offset = 64u32
                        .saturating_sub(f.bit_offset)
                        .saturating_sub(f.bit_width);
                    body.push(dwarf_bit_offset as u8);
                    body.push(f.bit_width as u8);
                }
            }
            // Children-list terminator for this struct.
            body.push(0);
        }
        CatalogEntry::VoidStar => {
            // 8-byte address-encoded base type. Effectively
            // `void *` in user-facing rendering -- once unknown
            // tags are extinct this entry can be removed
            // entirely.
            write_uleb128(body, ABBREV_BASE_TYPE);
            body.extend_from_slice(&catalog.void_star_name_off.to_le_bytes());
            body.push(8);
            body.push(DW_ATE_ADDRESS);
        }
    }
}

// ---- .debug_frame (Call Frame Information) ----

/// Coarse arch flavour the CFI emitter dispatches on. Matches
/// `super::Arch` but is decoded directly from `Target` so the
/// helpers can stay self-contained without pulling the full
/// `Build`/`Abi` plumbing in.
#[derive(Clone, Copy, PartialEq, Eq)]
enum CfiArch {
    Aarch64,
    X86_64,
}

impl CfiArch {
    fn of(target: Target) -> Self {
        match target {
            Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64 => {
                CfiArch::Aarch64
            }
            Target::LinuxX64 | Target::WindowsX64 => CfiArch::X86_64,
        }
    }
}

/// `code_alignment_factor` -- the multiplier applied to factored
/// PC deltas in CIE / FDE instructions. AArch64 instructions are
/// uniformly 4 bytes, so 4 minimises the byte cost of
/// `DW_CFA_advance_loc`. x86_64 has variable-length instructions,
/// so 1 is the only safe choice.
fn cfi_code_alignment_factor(arch: CfiArch) -> u64 {
    match arch {
        CfiArch::Aarch64 => 4,
        CfiArch::X86_64 => 1,
    }
}

/// `data_alignment_factor` -- the multiplier applied to factored
/// register-save offsets. We pick `-8` so a positive ULEB factor
/// `N` lands `N * -8` bytes from CFA, which is what every saved
/// register on a 64-bit target wants (caller frame above CFA,
/// saves below).
const CFI_DATA_ALIGNMENT_FACTOR: i64 = -8;

/// DWARF return-address register column. AArch64 saves the link
/// register in x30 at function entry. x86_64 uses the virtual
/// "RA" column 16.
fn cfi_return_address_register(arch: CfiArch) -> u64 {
    match arch {
        CfiArch::Aarch64 => AARCH64_REG_X30 as u64,
        CfiArch::X86_64 => X86_64_REG_RA as u64,
    }
}

/// Initial CFI rules effective at function entry. Encoded into
/// the CIE so every FDE inherits them and only emits the deltas
/// the prologue introduces.
fn write_cie_initial_instructions(out: &mut Vec<u8>, arch: CfiArch) {
    match arch {
        CfiArch::Aarch64 => {
            // CFA = sp + 0; the link register is in x30 (CIE's
            // return-address register column already names it).
            out.push(DW_CFA_DEF_CFA);
            write_uleb128(out, AARCH64_REG_SP as u64);
            write_uleb128(out, 0);
        }
        CfiArch::X86_64 => {
            // `call` pushed the return address before transferring
            // control, so CFA = rsp + 8 with the return address
            // saved at CFA - 8 (factored 1 against -8).
            out.push(DW_CFA_DEF_CFA);
            write_uleb128(out, X86_64_REG_RSP as u64);
            write_uleb128(out, 8);
            out.push(DW_CFA_OFFSET_HI | X86_64_REG_RA);
            write_uleb128(out, 1);
        }
    }
}

/// CFI rules effective from the first byte of the function body
/// (i.e. after the prologue completes). Standard c5 prologue
/// shape: fp/lr saved into a 16-byte slot at the top of the
/// frame; on aarch64 x29 is then set to sp; on x86_64 rbp is set
/// to rsp.
fn write_post_prologue_instructions(out: &mut Vec<u8>, arch: CfiArch) {
    match arch {
        CfiArch::Aarch64 => {
            // CFA = x29 + 16. x29 itself was saved at the new
            // sp = x29 + 0 = CFA - 16; x30 was saved at sp + 8 =
            // CFA - 8. Both factored against -8 (factor 2 / 1).
            out.push(DW_CFA_DEF_CFA);
            write_uleb128(out, AARCH64_REG_X29 as u64);
            write_uleb128(out, 16);
            out.push(DW_CFA_OFFSET_HI | AARCH64_REG_X29);
            write_uleb128(out, 2);
            out.push(DW_CFA_OFFSET_HI | AARCH64_REG_X30);
            write_uleb128(out, 1);
        }
        CfiArch::X86_64 => {
            // CFA = rbp + 16 (rbp covers ret-addr + saved-rbp
            // slots). rbp itself saved at CFA - 16; the return
            // address at CFA - 8 was already declared by the CIE
            // and stays put.
            out.push(DW_CFA_DEF_CFA);
            write_uleb128(out, X86_64_REG_RBP as u64);
            write_uleb128(out, 16);
            out.push(DW_CFA_OFFSET_HI | X86_64_REG_RBP);
            write_uleb128(out, 2);
        }
    }
}

/// Encode a `DW_CFA_advance_loc` covering `bytes` of native code,
/// expanding into the smallest opcode form that fits the factored
/// delta. AArch64 always factors evenly (instructions are 4
/// bytes); x86_64 uses code_alignment_factor = 1 so the byte
/// count goes through unchanged.
fn write_advance_loc(out: &mut Vec<u8>, arch: CfiArch, bytes: u32) {
    let factor = cfi_code_alignment_factor(arch) as u32;
    debug_assert_eq!(
        bytes % factor,
        0,
        "prologue size {bytes} not divisible by code_alignment_factor {factor}"
    );
    let units = bytes / factor;
    if units == 0 {
        return;
    }
    if units < 64 {
        out.push(DW_CFA_ADVANCE_LOC_HI | units as u8);
    } else if units < 256 {
        out.push(DW_CFA_ADVANCE_LOC1);
        out.push(units as u8);
    } else if units < 65_536 {
        out.push(DW_CFA_ADVANCE_LOC2);
        out.extend_from_slice(&(units as u16).to_le_bytes());
    } else {
        out.push(DW_CFA_ADVANCE_LOC4);
        out.extend_from_slice(&units.to_le_bytes());
    }
}

/// Round `body.len()` up to a multiple of 8 (the CIE / FDE
/// alignment for 64-bit DWARF) by appending `DW_CFA_nop` (0x00)
/// padding.
fn pad_to_alignment(body: &mut Vec<u8>, alignment: usize) {
    while !body.len().is_multiple_of(alignment) {
        body.push(DW_CFA_NOP);
    }
}

/// Common-Information Entry header (`.debug_frame` form).
/// `unit_length` covers everything after itself; `cie_id =
/// 0xffffffff` distinguishes a CIE from an FDE in `.debug_frame`
/// (FDEs carry a real offset there). DWARF 4 added the
/// `address_size` / `segment_selector_size` bytes; before that,
/// version 3 ran without them.
#[repr(C, packed)]
struct DebugFrameCieHeader {
    unit_length: u32,
    cie_id: u32,
    version: u8,
    /// First byte of the augmentation cstring (always `0` for
    /// the empty augmentation we use). Splitting it out lets the
    /// schema document the field even though the augmentation is
    /// nominally variable-length.
    augmentation_terminator: u8,
    address_size: u8,
    segment_selector_size: u8,
}

impl DebugFrameCieHeader {
    fn write_le(&self, out: &mut Vec<u8>) {
        let DebugFrameCieHeader {
            unit_length,
            cie_id,
            version,
            augmentation_terminator,
            address_size,
            segment_selector_size,
        } = *self;
        out.extend_from_slice(&unit_length.to_le_bytes());
        out.extend_from_slice(&cie_id.to_le_bytes());
        out.push(version);
        out.push(augmentation_terminator);
        out.push(address_size);
        out.push(segment_selector_size);
    }
}

/// Frame-Description Entry header (`.debug_frame` form).
/// `cie_pointer` is an absolute offset from the start of
/// `.debug_frame` to the matching CIE; we keep one CIE at offset
/// 0 so every FDE here points at 0.
#[repr(C, packed)]
struct DebugFrameFdeHeader {
    unit_length: u32,
    cie_pointer: u32,
    initial_location: u64,
    address_range: u64,
}

impl DebugFrameFdeHeader {
    fn write_le(&self, out: &mut Vec<u8>) {
        let DebugFrameFdeHeader {
            unit_length,
            cie_pointer,
            initial_location,
            address_range,
        } = *self;
        out.extend_from_slice(&unit_length.to_le_bytes());
        out.extend_from_slice(&cie_pointer.to_le_bytes());
        out.extend_from_slice(&initial_location.to_le_bytes());
        out.extend_from_slice(&address_range.to_le_bytes());
    }
}

/// VMA range covered by the PLT trampoline pool, or `None` when
/// the binary has no imports. Used by [`build_debug_frame`] to
/// emit one extra FDE so unwinders can step through a stub
/// (`adrp+ldr+br` on aarch64; `jmp [rip+disp]` on x86_64) without
/// hitting "Cannot find bounds of current function".
///
/// The trampolines are emitted contiguously at the tail of
/// `build.text` by `emit_plt_trampolines`, so the range is
/// `[code_vmaddr + offsets[0], code_vmaddr + build.text.len())`.
fn plt_pool_range(build: &Build, code_vmaddr: u64) -> Option<(u64, u64)> {
    let first = build.plt_trampoline_offsets.first().copied()?;
    let start = code_vmaddr + first as u64;
    let end = code_vmaddr + build.text.len() as u64;
    if end > start {
        Some((start, end))
    } else {
        None
    }
}

/// Build the `.debug_frame` section: one CIE at offset 0, one FDE
/// per `Subprog`, plus optional final FDEs covering the PLT
/// trampoline pool and the ELF `_start` stub.
/// Empty if no callers contributed any range.
///
/// The PLT FDE inherits the CIE's initial rules verbatim --
/// trampolines never touch the stack or LR/RA, so the entry-state
/// CFA description is exactly correct for every byte of every
/// stub. The `_start` FDE additionally marks the return-address
/// column as `DW_CFA_undefined` so the unwinder terminates
/// cleanly: there's no caller below `_start`, the kernel handed
/// us the stack ready-to-go.
fn build_debug_frame(
    target: Target,
    subs: &[Subprog],
    plt_pool: Option<(u64, u64)>,
    start_stub: Option<(u64, u64)>,
) -> Vec<u8> {
    if subs.is_empty() && plt_pool.is_none() && start_stub.is_none() {
        return Vec::new();
    }
    let arch = CfiArch::of(target);
    let mut out: Vec<u8> = Vec::with_capacity(64 + subs.len() * 32);

    // ---- CIE ----
    //
    // Build the body (everything after `unit_length`) so we know
    // its size before writing the prefix.
    let mut cie_body: Vec<u8> = Vec::new();
    write_uleb128(&mut cie_body, cfi_code_alignment_factor(arch));
    write_sleb128(&mut cie_body, CFI_DATA_ALIGNMENT_FACTOR);
    write_uleb128(&mut cie_body, cfi_return_address_register(arch));
    write_cie_initial_instructions(&mut cie_body, arch);

    // Header is 8 bytes for `unit_length + cie_id` plus 4 bytes
    // for `version + augmentation_terminator + address_size +
    // segment_selector_size` -- but we count `unit_length`'s 4
    // bytes for the consumer-facing length, so subtract them.
    // Pad the entire CIE record (header + body) to a multiple of
    // 8 bytes so the FDE that follows starts on an 8-aligned
    // offset (DWARF requires this for 64-bit address-size CFI).
    let mut cie = Vec::with_capacity(16 + cie_body.len());
    let cie_inner_len = (4 /* cie_id */ + 1 /* version */ + 1 /* aug NUL */
        + 1 /* address_size */ + 1 /* segment_size */ + cie_body.len())
        as u32;
    let header = DebugFrameCieHeader {
        unit_length: cie_inner_len,
        cie_id: 0xffff_ffff,
        version: 4,
        augmentation_terminator: 0,
        address_size: 8,
        segment_selector_size: 0,
    };
    header.write_le(&mut cie);
    cie.extend_from_slice(&cie_body);
    pad_to_alignment(&mut cie, 8);
    // Patch the unit_length to cover any DW_CFA_nop padding we
    // added. The header wrote `cie_inner_len` not knowing about
    // alignment; the actual length is `cie.len() - 4` (minus the
    // unit_length field itself).
    let actual_cie_unit_length = (cie.len() - 4) as u32;
    cie[..4].copy_from_slice(&actual_cie_unit_length.to_le_bytes());
    out.extend_from_slice(&cie);

    // ---- FDEs ----

    for sub in subs {
        let mut fde_body: Vec<u8> = Vec::new();
        // Skip past the prologue, then install the post-prologue
        // CFA rule. Functions whose prologue size couldn't be
        // recovered (DCE'd, etc.) pass `prologue_size == 0` and
        // get the rule installed at the function's first byte.
        if sub.prologue_size > 0 {
            write_advance_loc(&mut fde_body, arch, sub.prologue_size);
        }
        write_post_prologue_instructions(&mut fde_body, arch);

        let mut fde = Vec::with_capacity(24 + fde_body.len());
        let fde_inner_len = (4 /* cie_pointer */ + 8 /* initial_location */
            + 8 /* address_range */ + fde_body.len()) as u32;
        let header = DebugFrameFdeHeader {
            unit_length: fde_inner_len,
            cie_pointer: 0,
            initial_location: sub.low_pc,
            address_range: sub.high_pc - sub.low_pc,
        };
        header.write_le(&mut fde);
        fde.extend_from_slice(&fde_body);
        pad_to_alignment(&mut fde, 8);
        let actual_fde_unit_length = (fde.len() - 4) as u32;
        fde[..4].copy_from_slice(&actual_fde_unit_length.to_le_bytes());
        out.extend_from_slice(&fde);
    }

    // Emit one FDE covering the entire PLT trampoline pool.
    // Trampolines are stack-neutral leaves -- aarch64's
    // `adrp+ldr+br` doesn't touch sp / x30, x86_64's `jmp [rip+
    // disp]` doesn't touch rsp. So the CIE's entry-state rule
    // (CFA = sp + 0 with RA in x30, or CFA = rsp + 8 with RA at
    // CFA-8) describes every byte of every stub. The FDE body
    // is therefore empty -- it inherits from the CIE alone.
    if let Some((start, end)) = plt_pool {
        out.extend_from_slice(&fde_with_body(start, end, &[]));
    }

    // Emit one FDE covering the ELF `_start` stub. The kernel
    // arranges the initial stack and jumps directly to `_start`
    // -- there's no caller frame to walk to. Mark the return-
    // address column as `DW_CFA_undefined` so the unwinder
    // recognises the bottom of the stack and stops with a clean
    // "Backtrace stopped: at top of stack" instead of reading
    // garbage.
    if let Some((start, end)) = start_stub {
        let ra_col = cfi_return_address_register(arch);
        let mut body: Vec<u8> = Vec::with_capacity(4);
        body.push(DW_CFA_UNDEFINED);
        write_uleb128(&mut body, ra_col);
        out.extend_from_slice(&fde_with_body(start, end, &body));
    }

    out
}

/// Build one `.debug_frame` FDE record with the given address
/// range and body bytes (the inline CFI program). Pads to
/// 8-byte alignment so the next FDE / record starts aligned.
fn fde_with_body(start: u64, end: u64, body: &[u8]) -> Vec<u8> {
    let mut fde = Vec::with_capacity(24 + body.len());
    let fde_inner_len = (4 /* cie_pointer */ + 8 /* initial_location */
        + 8 /* address_range */ + body.len()) as u32;
    let header = DebugFrameFdeHeader {
        unit_length: fde_inner_len,
        cie_pointer: 0,
        initial_location: start,
        address_range: end - start,
    };
    header.write_le(&mut fde);
    fde.extend_from_slice(body);
    pad_to_alignment(&mut fde, 8);
    let actual_fde_unit_length = (fde.len() - 4) as u32;
    fde[..4].copy_from_slice(&actual_fde_unit_length.to_le_bytes());
    fde
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

/// Walk the SSA-tier line table, emit one row per (live) PC whose
/// source line is known. The DWARF state machine starts at
/// `(address=0, line=1, file=1, is_stmt=true)`; the emit opens with
/// a `DW_LNE_set_address` to anchor at `code_vmaddr` and ends with
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

    // Each function's native start PC. The SSA emit's
    // `record_inst_src` only records a row when an instruction
    // carries a non-zero `inst_src`, so the prologue (which the
    // walker doesn't stamp) emits no row -- the first row in a
    // function lands at the first body instruction, not the
    // function entry. lldb / gdb need a row at the entry PC to
    // attribute a function-name breakpoint to source; without
    // it, a breakpoint at low_pc has no covering line entry and
    // no source is shown. Seed an extra row at each function's
    // entry PC, reusing the line and file from the body's first
    // recorded row.
    let mut func_starts: Vec<usize> = build
        .func_ent_pcs
        .iter()
        .filter_map(|&pc| build.pc_to_native.get(pc).copied())
        .filter(|&n| n != usize::MAX)
        .collect();
    func_starts.sort_unstable();
    func_starts.dedup();
    let mut func_start_iter = func_starts.iter().copied().peekable();

    // Track whether the most recent state (addr, line, file)
    // has already been emitted as a row. After
    // `DW_LNE_set_address`, the state machine sits at
    // (code_vmaddr, line=1, file=1, ...) but no row exists yet;
    // a `DW_LNS_COPY` is what materialises the row.
    let mut row_emitted_at_state: bool = false;

    let emit_row = |buf: &mut Vec<u8>,
                    state_addr: &mut u64,
                    state_line: &mut i64,
                    state_file: &mut u64,
                    row_emitted: &mut bool,
                    target_addr: u64,
                    line: i64,
                    file: u64,
                    mark_prologue_end: bool| {
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
    };

    // One row per source-position change the SSA emit recorded
    // against the emitted native byte offset. Provides per-
    // statement granularity inside each function. Native code
    // emission flows through the SSA pipeline exclusively, so
    // every program with executable bytes populates
    // `ssa_line_rows`; an empty vector means no code was emitted
    // and the closing `DW_LNE_end_sequence` below caps a zero-
    // length sequence.
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
        let target_addr = code_vmaddr + native as u64;
        // Drain every function start at-or-before this row.
        // The drained start gets a synthetic row whose (line,
        // file) match this row's, so the function-entry PC
        // through the body's first statement reports the same
        // source position.
        while let Some(&fn_start) = func_start_iter.peek() {
            let entry_addr = code_vmaddr + fn_start as u64;
            if entry_addr > target_addr {
                break;
            }
            emit_row(
                buf,
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
            buf,
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

    // Close the sequence with end_sequence at one past the last
    // byte of *user* code. The PLT trampoline pool lives
    // past that point; including it would extend the previous row's
    // `[addr_N, addr_{N+1})` coverage over every stub and gdb would
    // mis-attribute PLT-stub hits to the closing brace of the last
    // function.
    let end_addr = code_vmaddr + end_of_user_text(build) as u64;
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
    // The table does not dedupe string contents; it is small
    // (one entry per user function plus the CU name and producer)
    // and the writer reads it sequentially. The base-type names
    // come from a small `&'static str` set, so dedup
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

    /// Byte-stability lock for the amalg `.debug_abbrev` table.
    /// `build_debug_info` references each abbreviation by code and
    /// supplies its attribute values in the order declared here, so
    /// an accidental edit to a code, tag, or attribute silently
    /// desyncs the two emitters. Any intentional change must update
    /// this golden after re-checking the info emitter.
    #[test]
    fn build_debug_abbrev_is_byte_stable() {
        let hex: alloc::string::String = build_debug_abbrev()
            .iter()
            .map(|b| alloc::format!("{b:02x}"))
            .collect();
        assert_eq!(
            hex,
            "011101250e130b030e1b0e1101120710170000022e01030e110112073f192719360b\
             40180000032400030e0b0b3e0b0000043400030e491302183a0f3b0f000005050003\
             0e491302183a0f3b0f0000060f000b0b49130000071301030e0b06000008170103\
             0e0b060000090d00030e4913380600000a0d00030e491338060b0b0c0b0d0b00000b\
             2e01030e110112073f19491300000c0500030e491300000d180000000e0500030e49\
             13021800000f0101491300001021002f0f000011040103080b0b000012280003081c\
             0d000000"
        );
    }

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

    fn base_of(ty: i64, target: Target) -> BaseTypeKey {
        match classify(ty, target) {
            CatalogEntry::Base(k) => k,
            other => panic!("expected Base, got {other:?} for ty={ty}"),
        }
    }

    #[test]
    fn classify_distinguishes_signed_unsigned() {
        let signed = base_of(Ty::Int as i64, Target::LinuxX64);
        let unsigned = base_of(Ty::Int as i64 | types::UNSIGNED_BIT, Target::LinuxX64);
        assert_ne!(signed, unsigned);
        assert_eq!(signed.byte_size, 4);
        assert_eq!(signed.encoding, DW_ATE_SIGNED);
        assert_eq!(unsigned.encoding, DW_ATE_UNSIGNED);
    }

    #[test]
    fn classify_long_follows_data_model() {
        let lp64 = base_of(Ty::Long as i64, Target::LinuxX64);
        let llp64 = base_of(Ty::Long as i64, Target::WindowsX64);
        assert_eq!(lp64.byte_size, 8);
        assert_eq!(llp64.byte_size, 4);
    }

    #[test]
    fn classify_float_is_four_bytes() {
        // A scalar `float` is a 4-byte IEEE single; the executable and
        // relocatable DWARF paths must agree (a debugger reading 8 bytes
        // would mix in adjacent frame memory).
        let f = base_of(Ty::Float as i64, Target::LinuxX64);
        assert_eq!(f.byte_size, 4);
        assert_eq!(f.encoding, DW_ATE_FLOAT);
        let d = base_of(Ty::Double as i64, Target::LinuxX64);
        assert_eq!(d.byte_size, 8);
    }

    #[test]
    fn classify_char_uses_signed_char_encoding() {
        let signed = base_of(Ty::Char as i64, Target::LinuxX64);
        let unsigned = base_of(Ty::Char as i64 | types::UNSIGNED_BIT, Target::LinuxX64);
        assert_eq!(signed.byte_size, 1);
        assert_eq!(signed.encoding, DW_ATE_SIGNED_CHAR);
        assert_eq!(unsigned.encoding, DW_ATE_UNSIGNED_CHAR);
    }

    #[test]
    fn classify_pointer_returns_chain_entry() {
        // `int*` -> Pointer{leaf=int, depth=1}; `int**` -> depth=2.
        let int_ptr = (Ty::Int as i64) + (Ty::Ptr as i64);
        let int_ptr_ptr = (Ty::Int as i64) + 2 * (Ty::Ptr as i64);
        match classify(int_ptr, Target::LinuxX64) {
            CatalogEntry::Pointer { leaf, depth } => {
                assert_eq!(leaf.name, "int");
                assert_eq!(depth, 1);
            }
            other => panic!("expected Pointer, got {other:?}"),
        }
        match classify(int_ptr_ptr, Target::LinuxX64) {
            CatalogEntry::Pointer { leaf, depth } => {
                assert_eq!(leaf.name, "int");
                assert_eq!(depth, 2);
            }
            other => panic!("expected Pointer, got {other:?}"),
        }
    }

    #[test]
    fn classify_struct_value_routes_to_struct_entry() {
        // Plain struct id 0 (no pointer level) lands on the
        // dedicated `Struct` variant, which emits a real
        // DW_TAG_structure_type.
        let struct_ty = types::STRUCT_BASE;
        assert_eq!(
            classify(struct_ty, Target::LinuxX64),
            CatalogEntry::Struct { id: 0 },
        );
    }

    #[test]
    fn classify_struct_pointer_returns_chain_entry() {
        // `struct Foo *` -- id 0 at depth 1.
        let s_ptr = types::STRUCT_BASE + Ty::Ptr as i64;
        assert_eq!(
            classify(s_ptr, Target::LinuxX64),
            CatalogEntry::StructPointer { id: 0, depth: 1 },
        );
    }

    #[test]
    fn plt_pool_range_skips_when_no_imports() {
        let mut build = Build {
            copy_relocs: Default::default(),
            text: alloc::vec![0u8; 0x100],
            ..Build::default()
        };
        assert_eq!(plt_pool_range(&build, 0x1000), None);
        // Once a trampoline is recorded, the range covers from the
        // first stub byte to the end of `build.text`.
        build.plt_trampoline_offsets = alloc::vec![0xc0, 0xcc];
        build.text.extend(alloc::vec![0u8; 0x40]); // pretend trampolines are appended
        assert_eq!(plt_pool_range(&build, 0x1000), Some((0x10c0, 0x1140)));
    }

    #[test]
    fn debug_frame_emits_plt_fde_when_pool_present() {
        // The PLT trampoline pool gets one extra FDE so
        // unwinders can step through a stub. Body is empty -- the
        // FDE inherits the CIE's initial CFA rule, which exactly
        // matches the trampoline's "no stack manipulation" shape.
        let subs: Vec<Subprog> = Vec::new(); // no user subs is fine
        let with_pool =
            build_debug_frame(Target::LinuxAarch64, &subs, Some((0x1100, 0x1140)), None);
        let without_pool = build_debug_frame(Target::LinuxAarch64, &subs, None, None);
        assert!(without_pool.is_empty(), "no subs + no pool -> empty");
        assert!(
            !with_pool.is_empty(),
            "no subs + pool -> CIE + PLT FDE bytes"
        );
        // With an empty FDE body the unit_length field is exactly
        // the inner header size (cie_pointer + initial_location +
        // address_range = 4 + 8 + 8 = 20 bytes), so the FDE record
        // is 4 (unit_length) + 20 = 24 bytes -- already 8-aligned,
        // no DW_CFA_nop padding required.
        let last_24 = &with_pool[with_pool.len() - 24..];
        assert_eq!(&last_24[..4], &20u32.to_le_bytes());
        // initial_location = 0x1100, address_range = 0x40.
        assert_eq!(&last_24[8..16], &0x1100u64.to_le_bytes());
        assert_eq!(&last_24[16..24], &0x40u64.to_le_bytes());
    }

    #[test]
    fn collect_plt_subprograms_uses_offset_delta_not_text_len() {
        // Per-stub size must come from the offset delta
        // between consecutive trampolines, NOT from
        // `build.text.len() - first_offset`. The latter
        // overshoots because `append_build_info` tacks a
        // NUL-terminated marker onto the tail of `build.text`
        // after the PLT pool. Without this fix the DIE's
        // DW_AT_high_pc claimed each stub was 31 bytes (visible
        // in `readelf --debug-dump=info` on hello.c) instead of
        // the actual 12.
        // Two 12-byte aarch64 trampolines at offsets 0xc0, 0xcc.
        // The trailing 16 bytes simulate `append_build_info`'s
        // marker so we'd overshoot if we measured stub_size as
        // `(text.len() - first) / n`.
        let mut text = alloc::vec![0u8; 0xd8];
        text.extend(alloc::vec![0u8; 16]);
        let imports = super::super::ResolvedImports {
            data_bindings: Default::default(),
            imports: alloc::vec![
                super::super::ResolvedImport {
                    binding_idx: 0,
                    local_name: "malloc".into(),
                    real_symbol: "malloc".into(),
                    dylib_index: 0,
                    flat_lookup: false,
                    is_variadic: false,
                    fixed_args: 1,
                    return_type_tag: 0,
                    returns_long_double: false,
                    param_types: alloc::vec![1], // int
                },
                super::super::ResolvedImport {
                    binding_idx: 1,
                    local_name: "free".into(),
                    real_symbol: "free".into(),
                    dylib_index: 0,
                    flat_lookup: false,
                    is_variadic: false,
                    fixed_args: 1,
                    return_type_tag: 0,
                    returns_long_double: false,
                    param_types: alloc::vec![1],
                },
            ],
            ..Default::default()
        };
        let build = Build {
            copy_relocs: Default::default(),
            text,
            plt_trampoline_offsets: alloc::vec![0xc0, 0xcc],
            imports,
            ..Build::default()
        };
        let mut strs = StrTable::new();
        let plt_subs = collect_plt_subprograms(&build, Target::LinuxAarch64, 0x1000, &mut strs);
        assert_eq!(plt_subs.len(), 2);
        // 0xcc - 0xc0 = 12 bytes per stub. high_pc - low_pc must
        // match -- if it overshoots, gdb's DIE lookup for
        // "address near printf" lands on the wrong subprogram and
        // typed PLT signatures fail to resolve.
        assert_eq!(plt_subs[0].high_pc - plt_subs[0].low_pc, 12);
        assert_eq!(plt_subs[1].high_pc - plt_subs[1].low_pc, 12);
        assert_eq!(plt_subs[0].low_pc, 0x10c0);
        assert_eq!(plt_subs[1].low_pc, 0x10cc);
    }

    #[test]
    fn dwarf_arg_reg_maps_per_abi() {
        // AAPCS64 passes args 0..7 in x0..x7 (DWARF regs 0..7 --
        // direct mapping). x86_64 SysV uses
        // RDI/RSI/RDX/RCX/R8/R9 = DWARF 5/4/1/2/8/9. Win64 uses
        // RCX/RDX/R8/R9 = DWARF 2/1/8/9. Slots past the window
        // return None and fall back to a no-location DIE.
        for slot in 0..8 {
            assert_eq!(dwarf_arg_reg(Target::LinuxAarch64, slot), Some(slot as u8));
        }
        assert_eq!(dwarf_arg_reg(Target::LinuxAarch64, 8), None);

        let sysv = [5u8, 4, 1, 2, 8, 9];
        for (slot, &reg) in sysv.iter().enumerate() {
            assert_eq!(dwarf_arg_reg(Target::LinuxX64, slot), Some(reg));
        }
        assert_eq!(dwarf_arg_reg(Target::LinuxX64, 6), None);

        let win64 = [2u8, 1, 8, 9];
        for (slot, &reg) in win64.iter().enumerate() {
            assert_eq!(dwarf_arg_reg(Target::WindowsX64, slot), Some(reg));
        }
        assert_eq!(dwarf_arg_reg(Target::WindowsX64, 4), None);
    }

    #[test]
    fn debug_frame_emits_start_stub_fde_with_undefined_ra() {
        // The `_start` FDE must mark the return-address
        // column as `DW_CFA_undefined` so the unwinder
        // terminates cleanly. Without it the kernel-supplied
        // initial stack reads as garbage and gdb prints
        // "Backtrace stopped: not enough registers or memory
        // available to unwind further".
        let subs: Vec<Subprog> = Vec::new();
        let bytes = build_debug_frame(
            Target::LinuxAarch64,
            &subs,
            None,
            Some((0x1000, 0x1018)), // 24-byte aarch64 _start stub
        );
        // Body bytes: DW_CFA_undefined (0x07) + ULEB(30) -- the
        // RA column for aarch64 is x30. Both fit in 1 byte each.
        // Inner length: 4 (cie_pointer) + 8 (initial_location)
        // + 8 (address_range) + 2 (body) = 22. The full record
        // is 4 (unit_length) + 22 = 26 bytes; pad to 8 -> 32.
        // Verify the trailing record opens with unit_length =
        // 28 (record minus its own 4-byte length field after
        // the alignment pad rounded up the inner len).
        let last_32 = &bytes[bytes.len() - 32..];
        let unit_len = u32::from_le_bytes(last_32[..4].try_into().unwrap());
        assert_eq!(unit_len as usize, 28);
        // initial_location and address_range survive their move
        // into the FDE header.
        assert_eq!(&last_32[8..16], &0x1000u64.to_le_bytes());
        assert_eq!(&last_32[16..24], &0x18u64.to_le_bytes());
        // Body opens with DW_CFA_undefined + reg_id 30 (x30).
        assert_eq!(last_32[24], DW_CFA_UNDEFINED);
        assert_eq!(last_32[25], 30);
    }

    #[test]
    fn end_of_user_text_skips_plt_pool() {
        // When the PLT trampoline pool follows user code,
        // the line-table end_sequence and last Subprog::high_pc
        // must stop at the first trampoline byte. Otherwise gdb /
        // lldb attribute PLT-stub hits to the closing brace of the
        // last user function (e.g. `b malloc` -> `main:34`).
        let mut build = Build {
            copy_relocs: Default::default(),
            text: alloc::vec![0u8; 0x200],
            plt_trampoline_offsets: alloc::vec![0x180, 0x18c, 0x198],
            ..Build::default()
        };
        assert_eq!(end_of_user_text(&build), 0x180);

        // No PLT pool: fall back to the full text length (the
        // pre-#61 behaviour, still hit by hosts without imports
        // and by `Build::default()` test fixtures).
        build.plt_trampoline_offsets.clear();
        assert_eq!(end_of_user_text(&build), 0x200);
    }

    #[test]
    fn pointer_chain_insert_back_fills_shallower_levels() {
        let mut entries: BTreeSet<CatalogEntry> = BTreeSet::new();
        let leaf = base_of(Ty::Int as i64, Target::LinuxX64);
        TypeCatalog::insert_with_chain(&mut entries, CatalogEntry::Pointer { leaf, depth: 3 });
        // Should have: Base(int), Pointer{int, 1}, Pointer{int, 2},
        // Pointer{int, 3}.
        assert!(entries.contains(&CatalogEntry::Base(leaf)));
        for d in 1..=3 {
            assert!(entries.contains(&CatalogEntry::Pointer { leaf, depth: d }));
        }
        assert_eq!(entries.len(), 4);
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

#[cfg(test)]
mod info_golden {
    use super::*;

    /// Byte-stability lock for the amalg `.debug_info` CU. Drives
    /// build_debug_info with a single leaf subprogram and pins the
    /// emitted bytes: the DIE-leading abbreviation codes and the
    /// per-attribute value order are hand-matched to the abbrev
    /// table, so this catches an info-side change that drifts from
    /// build_debug_abbrev. Any intentional change updates this golden
    /// after re-checking both emitters.
    #[test]
    fn build_debug_info_leaf_subprogram_is_byte_stable() {
        let mut strs = StrTable::new();
        let producer_off = strs.intern("badc test");
        let comp_dir_off = strs.intern("");
        let cu_name_off = strs.intern("t.c");
        let name_off = strs.intern("main");
        let subs = alloc::vec![Subprog {
            name_off,
            low_pc: 0x1000,
            high_pc: 0x1010,
            prologue_size: 4,
            variables: alloc::vec![],
        }];
        let plt_subs: alloc::vec::Vec<PltSub> = alloc::vec![];
        let structs: alloc::vec::Vec<StructDef> = alloc::vec![];
        let enums: alloc::vec::Vec<crate::c5::compiler::EnumDef> = alloc::vec![];
        let catalog = TypeCatalog::collect(&subs, &plt_subs, &mut strs, Target::LinuxX64, &structs);
        let info = build_debug_info(
            cu_name_off,
            comp_dir_off,
            producer_off,
            0,
            0x1000,
            0x10,
            &catalog,
            &subs,
            &plt_subs,
            Target::LinuxX64,
            &structs,
            &enums,
        );
        let hex: alloc::string::String = info.iter().map(|b| alloc::format!("{b:02x}")).collect();
        assert_eq!(
            hex,
            "440000000400000000000801010000000c0c0000000b0000000010000000000000\
             10000000000000000000000002100000000010000000000000100000000000000001\
             0276000000"
        );
        // Same unit, aarch64 target: DW_AT_frame_base selects
        // DW_OP_breg29 (0x8d) rather than x86_64's DW_OP_breg6 (0x76).
        let info_a64 = build_debug_info(
            cu_name_off,
            comp_dir_off,
            producer_off,
            0,
            0x1000,
            0x10,
            &catalog,
            &subs,
            &plt_subs,
            Target::LinuxAarch64,
            &structs,
            &enums,
        );
        let hex_a64: alloc::string::String =
            info_a64.iter().map(|b| alloc::format!("{b:02x}")).collect();
        assert!(
            hex_a64.ends_with("028d000000"),
            "aarch64 frame_base should be breg29: {hex_a64}"
        );
    }
}
