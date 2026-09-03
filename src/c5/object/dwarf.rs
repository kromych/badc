//! DWARF emitter for a final image: `.debug_info`, `.debug_abbrev`,
//! `.debug_line`, `.debug_str` and `.debug_frame` over committed
//! addresses. The relocatable form lives in `dwarf_reloc`.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::format;
use alloc::vec::Vec;

use super::{Build, Target};
use crate::c5::compiler::{StructDef, types};
use crate::c5::layout::pad_to_align as pad_to_alignment;
use crate::c5::program::Program;
use crate::c5::token::Ty;

// DWARF spec constants ----  Names mirror the DWARF 4 standard's
// `DW_*` identifiers so a reader cross-referencing the spec or another
// emitter can match them at a glance.

const DW_TAG_COMPILE_UNIT: u8 = 0x11;
const DW_TAG_SUBPROGRAM: u8 = 0x2e;
const DW_TAG_BASE_TYPE: u8 = 0x24;
const DW_TAG_POINTER_TYPE: u8 = 0x0f;
const DW_TAG_FORMAL_PARAMETER: u8 = 0x05;
const DW_TAG_VARIABLE: u8 = 0x34;
const DW_TAG_STRUCTURE_TYPE: u8 = 0x13;
const DW_TAG_UNION_TYPE: u8 = 0x17;
const DW_TAG_MEMBER: u8 = 0x0d;
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
const DW_AT_DATA_MEMBER_LOCATION: u32 = 0x38;
const DW_AT_BIT_SIZE: u32 = 0x0d;
const DW_AT_DATA_BIT_OFFSET: u32 = 0x6b;
const DW_AT_DECL_LINE: u32 = 0x3b;
const DW_AT_DECL_FILE: u32 = 0x3a;
const DW_AT_PROTOTYPED: u32 = 0x27;
const DW_AT_UPPER_BOUND: u32 = 0x2f;
const DW_AT_CALLING_CONVENTION: u32 = 0x36;
const DW_CC_NORMAL: u8 = 0x01;
const DW_AT_CONST_VALUE: u32 = 0x1c;

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

const DW_OP_FBREG: u8 = 0x91;
const DW_OP_BREG29: u8 = 0x8d;
const DW_OP_BREG6: u8 = 0x76;
const DW_OP_REG_BASE: u8 = 0x50;

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

/// `DW_CFA_advance_loc` is encoded as an opcode-with-operand: the top two
/// bits are `0b01` (= 0x40) and the low six bits carry the factored delta.
use crate::c5::codegen::ssa::cfi::{
    DW_CFA_ADVANCE_LOC_HI, DW_CFA_ADVANCE_LOC1, DW_CFA_ADVANCE_LOC2, DW_CFA_ADVANCE_LOC4,
    DW_CFA_DEF_CFA, DW_CFA_NEGATE_RA_STATE, DW_CFA_OFFSET_HI, DW_CFA_UNDEFINED, write_sleb128,
    write_uleb128,
};

const AARCH64_REG_X29: u8 = 29;
const AARCH64_REG_X30: u8 = 30;
const AARCH64_REG_SP: u8 = 31;

const X86_64_REG_RBP: u8 = 6;
const X86_64_REG_RSP: u8 = 7;
const X86_64_REG_RA: u8 = 16;

/// Compilation-unit header for `.debug_info` (DWARF 4, 32-bit form).
#[repr(C, packed)]
struct DebugInfoUnitHeader {
    unit_length: u32,
    version: u16,
    debug_abbrev_offset: u32,
    address_size: u8,
}

impl DebugInfoUnitHeader {
    const SIZE: u32 = 11;

    fn write_le(&self, out: &mut Vec<u8>) {
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

/// Statement-program unit header for `.debug_line` (DWARF 4, 32-bit).
#[repr(C, packed)]
struct DebugLineUnitHeader {
    unit_length: u32,
    version: u16,
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

/// Fixed prologue of the `.debug_line` statement-program header (everything
/// up to but not including the variable-length `standard_opcode_lengths`
/// table).
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

/// The byte vectors the emitter produces.
#[derive(Default)]
pub(crate) struct DwarfSections {
    pub debug_info: Vec<u8>,
    pub debug_abbrev: Vec<u8>,
    pub debug_line: Vec<u8>,
    pub debug_str: Vec<u8>,
    pub debug_frame: Vec<u8>,
}

/// Produce DWARF for `program` / `build`.
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

    let subs = collect_subprograms(program, build, code_vmaddr, &mut strs);

    let mut plt_subs = collect_plt_subprograms(build, target, code_vmaddr, &mut strs);

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

    // Build the type catalog. Walks captured variables and PLT signatures,
    // then transitively pulls in struct fields' types so a member declared
    // `struct Foo *next` reaches a real `DW_TAG_pointer` ->
    // `DW_TAG_structure_type` chain.
    let catalog = TypeCatalog::collect(&subs, &plt_subs, &mut strs, target, &program.structs);

    let debug_abbrev = build_debug_abbrev();
    let (debug_line, line_unit_off) = build_debug_line(program, build, code_vmaddr, source_path);
    // Extend the CU's [low_pc, low_pc + size) range backwards over the
    // `_start` stub when present, so a PC inside the stub still falls
    // inside the CU and gdb can resolve it to the `_start` subprogram DIE
    // we emitted.
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

struct Subprog {
    name_off: u32,
    low_pc: u64,
    high_pc: u64,
    prologue_size: u32,
    ra_signed_at: Option<u32>,
    variables: Vec<SubprogVar>,
    /// False for a definition with internal linkage (C99 6.2.2p3), so the
    /// DIE drops `DW_AT_external`.
    external: bool,
}

/// One PLT-trampoline subprogram.
struct PltSub {
    name_off: u32,
    low_pc: u64,
    high_pc: u64,
    return_type_tag: i64,
    param_types: Vec<i64>,
    param_name_offs: Vec<u32>,
    is_variadic: bool,
}

struct SubprogVar {
    name_off: u32,
    is_parameter: bool,
    type_tag: i64,
    fp_byte_offset: i64,
    /// True when mem2reg promoted this slot to a register; the frame slot
    /// no longer holds the value, so the DIE gets an empty location rather
    /// than a stale `DW_OP_fbreg`.
    promoted: bool,
    decl_line: u32,
    array_size: u32,
    decl_file: u32,
}

/// Native bytes from a function's `low_pc` to the first byte of its body --
/// i.e. the size of the standard prologue emitted by the arch lowerings.
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

/// Where the function at `low_pc` signs its return address, read off the
/// emitted code rather than the option: only the a64 emitter decides which
/// functions take the pair, and these are the same instruction words it
/// wrote.
fn paciasp_offset(build: &Build, low_pc: usize) -> Option<u32> {
    use crate::c5::codegen::aarch64::encode;
    let word = |at: usize| -> Option<u32> {
        build
            .text
            .get(at..at + 4)
            .and_then(|w| w.try_into().ok())
            .map(u32::from_le_bytes)
    };
    let mut at = low_pc;
    if word(at) == Some(encode::BTI_C) {
        at += 4;
    }
    while word(at) == Some(encode::NOP) {
        at += 4;
    }
    (word(at) == Some(encode::PACIASP)).then(|| (at - low_pc) as u32)
}

/// One-past-the-last byte of user code in `build.text`.
fn end_of_user_text(build: &Build) -> usize {
    build
        .plt_trampoline_offsets
        .iter()
        .copied()
        .flatten()
        .min()
        .unwrap_or(build.text.len())
}

/// One [`PltSub`] per import in declaration order.
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
    let stubbed: Vec<(&super::ResolvedImport, usize)> = imports
        .iter()
        .zip(build.plt_trampoline_offsets.iter())
        .filter_map(|(imp, off)| off.map(|o| (imp, o)))
        .collect();
    // Per-stub size. Trampolines are emitted contiguously and are
    // uniform-sized per arch, so the delta between two consecutive offsets
    // is exact.
    let stub_size = if stubbed.len() >= 2 {
        (stubbed[1].1 - stubbed[0].1) as u64
    } else {
        match target {
            Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64 => 12,
            Target::LinuxX64 | Target::WindowsX64 => 6,
        }
    };

    stubbed
        .iter()
        .map(|&(imp, off)| {
            // Synthetic per-param names: `arg0`, `arg1`, ... Synthetic
            // names are interned once per (import, slot) pair; the tiny
            // duplication keeps the writer side simple.
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

    // Iterate the per-function ent_pcs the lowering recorded in emission
    // order. The per-arch emit pushes `(ent_pc, name)` pairs in lockstep,
    // so an `ent_pc -> name` map covers the sort-by-native-offset reorder
    // below.
    let ident_by_pc: BTreeMap<usize, &alloc::string::String> = {
        use crate::c5::token::Token;
        program
            .symbols
            .iter()
            .filter(|s| {
                s.class == Token::Fun as i64
                    && (s.asm_name.is_some() || s.inline_body_name.is_some())
                    && !s.name.is_empty()
            })
            .map(|s| (s.val as usize, &s.name))
            .collect()
    };
    // A `static` definition's name is not visible outside the compilation
    // unit (C99 6.2.2p3), so its DIE drops DW_AT_external.
    let internal_pcs: alloc::collections::BTreeSet<usize> = {
        use crate::c5::token::Token;
        program
            .symbols
            .iter()
            .filter(|s| {
                s.class == Token::Fun as i64 && s.linkage == crate::c5::symbol::Linkage::Internal
            })
            .map(|s| s.val as usize)
            .collect()
    };
    let func_name_by_pc: BTreeMap<usize, alloc::string::String> = build
        .func_ent_pcs
        .iter()
        .copied()
        .zip(build.func_names.iter().cloned())
        .map(|(pc, n)| match ident_by_pc.get(&pc) {
            Some(ident) => (pc, (*ident).clone()),
            None => (pc, n),
        })
        .filter(|(_, n)| !n.is_empty())
        .collect();
    let mut ent_pcs: Vec<usize> = build.func_ent_pcs.clone();
    ent_pcs.sort_unstable_by_key(|&pc| build.pc_to_native.get(pc).copied().unwrap_or(usize::MAX));
    // Sentinel for end-of-last-function range. The PLT trampoline pool is
    // appended to `build.text` after the last user function; addresses
    // inside the pool must NOT fall inside any user `Subprog`'s [low_pc,
    // high_pc) range, or else gdb / lldb attribute PLT-stub hits to the
    // closing brace of the last function.
    let total_native = end_of_user_text(build);

    // c5's source-function tracking sometimes attributes function entries
    // to the wrong containing C function -- in a large translation unit
    // dozens of entries may carry the same source-name even though their
    // actual code belongs to unrelated functions. Without disambiguation,
    // lldb's `b name` returns N matches and the user can't tell which is
    // the real one.
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
        // `program.variables`. Captured by the c5 frontend at function-body
        // close, indexed by the Ent's ent_pc so a simple equality check
        // groups them.
        let function_bc_pc = ent_pc as u64;
        let canary_shift = build.canary_frame_bytes.get(&ent_pc).copied().unwrap_or(0) as i64;
        let variables = program
            .variables
            .iter()
            .filter(|v| v.function_bc_pc == function_bc_pc)
            .map(|v| {
                // Slot coalescing may have moved this local onto a new
                // exclusive frame offset; use it so the location is not
                // stale.
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
                    // TODO: an over-aligned automatic lives in the frame's
                    // over-aligned region, not at this slot offset; its
                    // location needs the per-function region base.
                    fp_byte_offset: if eff >= 2 {
                        (eff - 1) * 16
                    } else {
                        // A protected frame reserves its canary region at
                        // the top of the locals, so every local slot sits
                        // that much lower; parameter cells are above the
                        // frame base and keep their offsets.
                        eff * 8 - canary_shift
                    },
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
            ra_signed_at: paciasp_offset(build, lo),
            variables,
            external: !internal_pcs.contains(&ent_pc),
        });
    }

    out
}

/// One distinct scalar base type in the DWARF type tree.
#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord)]
pub(super) struct BaseTypeKey {
    pub(super) name: &'static str,
    pub(super) byte_size: u8,
    pub(super) encoding: u8,
}

/// One entry in the type catalog.
#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord)]
enum CatalogEntry {
    /// Scalar base type.
    Base(BaseTypeKey),
    /// Pointer chain rooted at `leaf` with `depth >= 1`.
    Pointer { leaf: BaseTypeKey, depth: u8 },
    /// Aggregate type by struct-registry id.
    Struct { id: u32 },
    /// Pointer chain rooted at a struct.
    StructPointer { id: u32, depth: u8 },
    /// Placeholder `void *` for variables we can't classify (a type tag the
    /// c5 frontend produced that doesn't fit any band).
    VoidStar,
}

impl CatalogEntry {
    /// Bytes this entry's DIE consumes on the wire.
    fn die_size(&self, structs: &[StructDef]) -> u32 {
        match self {
            CatalogEntry::Base(_) | CatalogEntry::VoidStar => 7,
            CatalogEntry::Pointer { .. } | CatalogEntry::StructPointer { .. } => 6,
            CatalogEntry::Struct { id } => {
                let mut size: u32 = 1 + 4 + 4;
                if let Some(s) = structs.get(*id as usize) {
                    for f in &s.fields {
                        size += if f.bit_width > 0 {
                            9 + uleb128_byte_len((f.offset as u64) * 8 + f.bit_offset as u64)
                                + uleb128_byte_len(f.bit_width as u64)
                        } else {
                            13
                        };
                    }
                }
                size += 1;
                size
            }
        }
    }
}

struct TypeCatalog {
    entries: Vec<CatalogEntry>,
    base_names: BTreeMap<BaseTypeKey, u32>,
    struct_names: BTreeMap<u32, u32>,
    struct_member_names: BTreeMap<u32, Vec<u32>>,
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
        for sub in subs {
            for v in &sub.variables {
                let entry = classify(v.type_tag, target);
                Self::insert_with_chain(&mut entries, entry);
            }
        }
        // Seed types from PLT signatures too -- both the return type and
        // each fixed parameter -- so the per-stub `DW_TAG_subprogram` /
        // `DW_TAG_formal_parameter` DIEs can resolve their `DW_AT_type`
        // refs through the same catalog the user variables use.
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
        for (id, sd) in structs.iter().enumerate() {
            if sd.cast_named {
                Self::insert_with_chain(&mut entries, CatalogEntry::Struct { id: id as u32 });
            }
        }

        // Every Struct entry pulls in its members' types. Mutual
        // recursion resolves because the layout pass below binds member
        // type-refs to precomputed offsets, not write-time positions.
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

        // Intern names. Bases first; then struct names + every struct's
        // member names (BTreeMap iteration is sorted, so the strtab order
        // is deterministic).
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

    /// Insert `entry` and -- when it's a pointer chain -- every shallower
    /// chain entry plus the rooting type DIE, so the emission walk finds
    /// each level's pointee already present.
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

/// Resolve a c5 type tag to its catalog entry.
fn classify(ty: i64, target: Target) -> CatalogEntry {
    let unsigned = types::is_unsigned_ty(ty);
    let bare = types::strip_unsigned(ty);

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

    let (leaf_tag, depth) = if bare < band_size {
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
    let leaf_key = match base_key_for_leaf(leaf_signed, target, 8) {
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

/// Build a `BaseTypeKey` for a *bare* leaf scalar tag (no pointer depth).
pub(super) fn base_key_for_leaf(
    leaf_tag: i64,
    target: Target,
    addr_bytes: u8,
) -> Option<BaseTypeKey> {
    if types::is_void_ty(leaf_tag) {
        return None;
    }
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
        // LLP64 keeps `long` at 4 bytes; the other data models give it the
        // address width, as the codegen's load width does.
        let byte_size = if target.is_windows() { 4 } else { addr_bytes };
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

// Abbreviation codes. Naming them keeps the two sides legible and matches
// the ET_REL emitter (`dwarf_reloc`).
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
const ABBREV_SUBPROGRAM_INTERNAL: u64 = 19;

/// One `.debug_abbrev` declaration: the abbreviation code, its DWARF tag,
/// whether the DIE has children, and the ordered (attribute, form) pairs.
struct AbbrevDecl {
    code: u64,
    tag: u8,
    has_children: bool,
    attrs: &'static [(u32, u32)],
}

const ABBREV_DECLS: &[AbbrevDecl] = &[
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
    // subprogram with variable / parameter children. DW_AT_prototyped is
    // always set: c5 rejects K&R declarators per C99 6.7.6.3p14.
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
    AbbrevDecl {
        code: ABBREV_SUBPROGRAM_INTERNAL,
        tag: DW_TAG_SUBPROGRAM,
        has_children: true,
        attrs: &[
            (DW_AT_NAME, DW_FORM_STRP),
            (DW_AT_LOW_PC, DW_FORM_ADDR),
            (DW_AT_HIGH_PC, DW_FORM_DATA8),
            (DW_AT_PROTOTYPED, DW_FORM_FLAG_PRESENT),
            (DW_AT_CALLING_CONVENTION, DW_FORM_DATA1),
            (DW_AT_FRAME_BASE, DW_FORM_EXPRLOC),
        ],
    },
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
    AbbrevDecl {
        code: ABBREV_POINTER_TYPE,
        tag: DW_TAG_POINTER_TYPE,
        has_children: false,
        attrs: &[(DW_AT_BYTE_SIZE, DW_FORM_DATA1), (DW_AT_TYPE, DW_FORM_REF4)],
    },
    // structure_type -- DW_AT_byte_size is DATA4 since aggregates routinely
    // exceed 256 bytes; children are DW_TAG_member DIEs.
    AbbrevDecl {
        code: ABBREV_STRUCTURE_TYPE,
        tag: DW_TAG_STRUCTURE_TYPE,
        has_children: true,
        attrs: &[(DW_AT_NAME, DW_FORM_STRP), (DW_AT_BYTE_SIZE, DW_FORM_DATA4)],
    },
    AbbrevDecl {
        code: ABBREV_UNION_TYPE,
        tag: DW_TAG_UNION_TYPE,
        has_children: true,
        attrs: &[(DW_AT_NAME, DW_FORM_STRP), (DW_AT_BYTE_SIZE, DW_FORM_DATA4)],
    },
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
    AbbrevDecl {
        code: ABBREV_BITFIELD_MEMBER,
        tag: DW_TAG_MEMBER,
        has_children: false,
        attrs: &[
            (DW_AT_NAME, DW_FORM_STRP),
            (DW_AT_TYPE, DW_FORM_REF4),
            (DW_AT_DATA_BIT_OFFSET, DW_FORM_UDATA),
            (DW_AT_BIT_SIZE, DW_FORM_UDATA),
        ],
    },
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
    AbbrevDecl {
        code: ABBREV_PLT_FORMAL_PARAMETER,
        tag: DW_TAG_FORMAL_PARAMETER,
        has_children: false,
        attrs: &[(DW_AT_NAME, DW_FORM_STRP), (DW_AT_TYPE, DW_FORM_REF4)],
    },
    AbbrevDecl {
        code: ABBREV_UNSPECIFIED_PARAMETERS,
        tag: DW_TAG_UNSPECIFIED_PARAMETERS,
        has_children: false,
        attrs: &[],
    },
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
    AbbrevDecl {
        code: ABBREV_ARRAY_TYPE,
        tag: DW_TAG_ARRAY_TYPE,
        has_children: true,
        attrs: &[(DW_AT_TYPE, DW_FORM_REF4)],
    },
    AbbrevDecl {
        code: ABBREV_SUBRANGE_TYPE,
        tag: DW_TAG_SUBRANGE_TYPE,
        has_children: false,
        attrs: &[(DW_AT_UPPER_BOUND, DW_FORM_UDATA)],
    },
    // enumeration_type -- tagged C99 6.7.2.2 enums; the enum is `int` in c5
    // so DW_AT_byte_size is 4. DW_FORM_string keeps the name inline rather
    // than threading the sealed string table.
    AbbrevDecl {
        code: ABBREV_ENUMERATION_TYPE,
        tag: DW_TAG_ENUMERATION_TYPE,
        has_children: true,
        attrs: &[
            (DW_AT_NAME, DW_FORM_STRING),
            (DW_AT_BYTE_SIZE, DW_FORM_DATA1),
        ],
    },
    // enumerator -- one (name, value) pair. DW_AT_const_value is signed
    // since C99 enum constants can be negative.
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
        write_uleb128(&mut buf, 0);
        write_uleb128(&mut buf, 0);
    }
    write_uleb128(&mut buf, 0);
    buf
}

/// DWARF register number for the `slot`-th integer / pointer arg in
/// `target`'s calling convention, or `None` if the slot overflows the ABI's
/// register window (and thus spills to stack at libc-side offsets we can't
/// describe).
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

/// Bytes a DW_TAG_array_type DIE plus its DW_TAG_subrange_type child
/// consume. abbrev_array(1) + DW_AT_type ref4(4) + abbrev_subrange(1) +
/// DW_AT_upper_bound uleb128(N) + children_terminator(1).
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

/// The compilation unit under construction: the DIE bytes past the unit
/// header and the CU-relative offset of every type DIE, laid out before any
/// DIE is written so a member can reach a type that lands later in the
/// unit.
struct InfoUnit<'a> {
    target: Target,
    catalog: &'a TypeCatalog,
    structs: &'a [StructDef],
    entry_offsets: BTreeMap<CatalogEntry, u32>,
    array_offsets: BTreeMap<(CatalogEntry, u32), u32>,
    body: Vec<u8>,
}

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
    let mut unit = InfoUnit {
        target,
        catalog,
        structs,
        entry_offsets: BTreeMap::new(),
        array_offsets: BTreeMap::new(),
        body: Vec::with_capacity(64 + subs.len() * 48),
    };
    unit.emit_cu_die(
        cu_name_off,
        comp_dir_off,
        producer_off,
        line_unit_off,
        cu_low_pc,
        cu_size,
    );
    let array_pairs = unit.array_pairs(subs);
    unit.layout_types(&array_pairs);
    unit.emit_type_dies();
    unit.emit_array_dies();
    unit.emit_enum_dies(enums);
    unit.emit_subprograms(subs);
    unit.emit_plt_subprograms(plt_subs);
    unit.finish()
}

impl InfoUnit<'_> {
    /// CU-relative offset of the next DIE.
    fn cursor(&self) -> u32 {
        (self.body.len() as u32) + DebugInfoUnitHeader::SIZE
    }

    fn emit_cu_die(
        &mut self,
        cu_name_off: u32,
        comp_dir_off: u32,
        producer_off: u32,
        line_unit_off: u32,
        cu_low_pc: u64,
        cu_size: u64,
    ) {
        let body = &mut self.body;
        write_uleb128(body, ABBREV_COMPILE_UNIT);
        body.extend_from_slice(&producer_off.to_le_bytes());
        body.push(DW_LANG_C99);
        body.extend_from_slice(&cu_name_off.to_le_bytes());
        body.extend_from_slice(&comp_dir_off.to_le_bytes());
        body.extend_from_slice(&cu_low_pc.to_le_bytes());
        body.extend_from_slice(&cu_size.to_le_bytes());
        body.extend_from_slice(&line_unit_off.to_le_bytes());
    }

    /// Every (element type, count) pair the unit's arrays need a DIE for:
    /// non-parameter variables (C99 6.7.5.3p7 decays parameter arrays to
    /// pointers) and fields of the aggregates the catalog emits.
    fn array_pairs(&self, subs: &[Subprog]) -> BTreeSet<(CatalogEntry, u32)> {
        let mut pairs: BTreeSet<(CatalogEntry, u32)> = BTreeSet::new();
        for s in subs {
            for v in &s.variables {
                if v.array_size == 0 || v.is_parameter {
                    continue;
                }
                let entry = classify(v.type_tag, self.target);
                if matches!(entry, CatalogEntry::Base(_) | CatalogEntry::Pointer { .. }) {
                    pairs.insert((entry, v.array_size));
                }
            }
        }
        let referenced_struct_ids: BTreeSet<u32> = self
            .catalog
            .entries
            .iter()
            .filter_map(|e| match e {
                CatalogEntry::Struct { id } | CatalogEntry::StructPointer { id, .. } => Some(*id),
                _ => None,
            })
            .collect();
        for id in &referenced_struct_ids {
            let Some(s) = self.structs.get(*id as usize) else {
                continue;
            };
            for f in &s.fields {
                if f.array_size <= 0 || f.bit_width > 0 {
                    continue;
                }
                let entry = classify(f.ty, self.target);
                if matches!(entry, CatalogEntry::Base(_) | CatalogEntry::Pointer { .. }) {
                    pairs.insert((entry, f.array_size as u32));
                }
            }
        }
        pairs
    }

    /// The CU-relative offset of every catalog entry and every array DIE,
    /// from the deterministic `die_size` of each.
    fn layout_types(&mut self, array_pairs: &BTreeSet<(CatalogEntry, u32)>) {
        let mut cursor = self.cursor();
        for entry in &self.catalog.entries {
            self.entry_offsets.insert(*entry, cursor);
            cursor += entry.die_size(self.structs);
        }
        for &(entry, count) in array_pairs {
            self.array_offsets.insert((entry, count), cursor);
            cursor += array_die_size(count);
        }
    }

    /// The type DIEs in catalog order.
    fn emit_type_dies(&mut self) {
        for entry in &self.catalog.entries {
            debug_assert_eq!(
                self.cursor(),
                self.entry_offsets[entry],
                "die_size disagreed with the emitter for {entry:?}",
            );
            emit_type_die(
                entry,
                &mut self.body,
                self.catalog,
                self.structs,
                &self.entry_offsets,
                &self.array_offsets,
                self.target,
            );
        }
    }

    /// The array DIEs at their laid-out offsets: `DW_TAG_array_type` over
    /// the element with one `DW_TAG_subrange_type` child.
    fn emit_array_dies(&mut self) {
        for (&(entry, count), &arr_off) in &self.array_offsets {
            debug_assert_eq!(
                arr_off,
                self.cursor(),
                "array layout disagreed with the emitter for ({entry:?}, {count})",
            );
            let elem_off = self.entry_offsets[&entry];
            let body = &mut self.body;
            write_uleb128(body, ABBREV_ARRAY_TYPE);
            body.extend_from_slice(&elem_off.to_le_bytes());
            write_uleb128(body, ABBREV_SUBRANGE_TYPE);
            write_uleb128(body, (count as u64).saturating_sub(1));
            body.push(0);
        }
    }

    /// One `DW_TAG_enumeration_type` per tagged enum.
    fn emit_enum_dies(&mut self, enums: &[super::super::compiler::EnumDef]) {
        let body = &mut self.body;
        for ed in enums {
            if ed.name.is_empty() || ed.constants.is_empty() {
                continue;
            }
            write_uleb128(body, ABBREV_ENUMERATION_TYPE);
            body.extend_from_slice(ed.name.as_bytes());
            body.push(0);
            body.push(ed.byte_size());
            for (cname, cval) in &ed.constants {
                write_uleb128(body, ABBREV_ENUMERATOR);
                body.extend_from_slice(cname.as_bytes());
                body.push(0);
                write_sleb128(body, *cval);
            }
            body.push(0);
        }
    }

    /// A subprogram per function with its variable and parameter children
    /// in capture order (parameters first, in declaration order, then the
    /// locals).
    fn emit_subprograms(&mut self, subs: &[Subprog]) {
        let frame_base_breg = match self.target {
            Target::LinuxX64 | Target::WindowsX64 => DW_OP_BREG6,
            Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64 => DW_OP_BREG29,
        };
        for s in subs {
            let body = &mut self.body;
            write_uleb128(
                body,
                if s.external {
                    ABBREV_SUBPROGRAM
                } else {
                    ABBREV_SUBPROGRAM_INTERNAL
                },
            );
            body.extend_from_slice(&s.name_off.to_le_bytes());
            body.extend_from_slice(&s.low_pc.to_le_bytes());
            body.extend_from_slice(&(s.high_pc - s.low_pc).to_le_bytes());
            body.push(DW_CC_NORMAL);
            write_uleb128(body, 2);
            body.push(frame_base_breg);
            body.push(0);
            for v in &s.variables {
                let abbrev = if v.is_parameter {
                    ABBREV_FORMAL_PARAMETER
                } else {
                    ABBREV_VARIABLE
                };
                write_uleb128(body, abbrev);
                body.extend_from_slice(&v.name_off.to_le_bytes());
                let entry = classify(v.type_tag, self.target);
                let elem_off = *self
                    .entry_offsets
                    .get(&entry)
                    .expect("catalog includes every entry produced by classify()");
                let type_off = if v.array_size > 0 && !v.is_parameter {
                    self.array_offsets
                        .get(&(entry, v.array_size))
                        .copied()
                        .unwrap_or(elem_off)
                } else {
                    elem_off
                };
                body.extend_from_slice(&type_off.to_le_bytes());
                if v.promoted {
                    write_uleb128(body, 0);
                } else {
                    let mut loc: Vec<u8> = Vec::with_capacity(8);
                    loc.push(DW_OP_FBREG);
                    write_sleb128(&mut loc, v.fp_byte_offset);
                    write_uleb128(body, loc.len() as u64);
                    body.extend_from_slice(&loc);
                }
                write_uleb128(body, v.decl_file as u64 + 1);
                write_uleb128(body, v.decl_line as u64);
            }
            body.push(0);
        }
    }

    /// A binding can name an opaque forward-declared aggregate (`FILE *`)
    /// the compiler never assigned a struct id to; the catalog seeded such
    /// a type as `VoidStar`.
    fn plt_classify(&self, ty: i64) -> CatalogEntry {
        match classify(ty, self.target) {
            CatalogEntry::Struct { id } if (id as usize) >= self.structs.len() => {
                CatalogEntry::VoidStar
            }
            CatalogEntry::StructPointer { id, .. } if (id as usize) >= self.structs.len() => {
                CatalogEntry::VoidStar
            }
            other => other,
        }
    }

    /// One subprogram per PLT trampoline so a `bt` frame in the stub shows
    /// a typed signature.
    fn emit_plt_subprograms(&mut self, plt_subs: &[PltSub]) {
        for plt in plt_subs {
            let ret_entry = self.plt_classify(plt.return_type_tag);
            let ret_off = *self
                .entry_offsets
                .get(&ret_entry)
                .expect("catalog includes every entry produced by plt_classify()");
            let body = &mut self.body;
            write_uleb128(body, ABBREV_PLT_SUBPROGRAM);
            body.extend_from_slice(&plt.name_off.to_le_bytes());
            body.extend_from_slice(&plt.low_pc.to_le_bytes());
            body.extend_from_slice(&(plt.high_pc - plt.low_pc).to_le_bytes());
            body.extend_from_slice(&ret_off.to_le_bytes());
            for (slot, &ty) in plt.param_types.iter().enumerate() {
                let entry = self.plt_classify(ty);
                let type_off = *self
                    .entry_offsets
                    .get(&entry)
                    .expect("catalog includes every entry produced by plt_classify()");
                let name_off = plt.param_name_offs[slot];
                let body = &mut self.body;
                match dwarf_arg_reg(self.target, slot) {
                    Some(reg) => {
                        write_uleb128(body, ABBREV_PLT_FORMAL_PARAMETER_LOC);
                        body.extend_from_slice(&name_off.to_le_bytes());
                        body.extend_from_slice(&type_off.to_le_bytes());
                        body.push(1);
                        body.push(DW_OP_REG_BASE + reg);
                    }
                    None => {
                        write_uleb128(body, ABBREV_PLT_FORMAL_PARAMETER);
                        body.extend_from_slice(&name_off.to_le_bytes());
                        body.extend_from_slice(&type_off.to_le_bytes());
                    }
                }
            }
            let body = &mut self.body;
            if plt.is_variadic {
                write_uleb128(body, ABBREV_UNSPECIFIED_PARAMETERS);
            }
            body.push(0);
        }
    }

    /// The CU's children terminator and the unit header, whose
    /// `unit_length` covers everything after itself.
    fn finish(mut self) -> Vec<u8> {
        self.body.push(0);
        let mut out = Vec::with_capacity(DebugInfoUnitHeader::SIZE as usize + self.body.len());
        let header = DebugInfoUnitHeader {
            unit_length: (self.body.len() + 7) as u32,
            version: 4,
            debug_abbrev_offset: 0,
            address_size: 8,
        };
        header.write_le(&mut out);
        out.extend_from_slice(&self.body);
        out
    }
}

/// Emit one type DIE into `body`.
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
            body.extend_from_slice(&(s.size as u32).to_le_bytes());

            let member_names = catalog
                .struct_member_names
                .get(id)
                .expect("collect() interned every struct's member names alongside the name");
            for (i, f) in s.fields.iter().enumerate() {
                let member_name_off = member_names[i];
                // Resolve member type. The offsets for subsequent fields
                // are already correct because c5 baked the array stride
                // into the member offsets at parse time.
                let member_entry = classify(f.ty, target);
                let elem_off = *entry_offsets
                    .get(&member_entry)
                    .expect("collect() walked every struct field's type into the catalog");
                // True field array: ref the array_type DIE if one was
                // reserved for this (element, count) pair. Bitfields keep
                // the element ref because they aren't arrays in any case.
                let member_type_off = if f.array_size > 0 && f.bit_width == 0 {
                    array_offsets
                        .get(&(member_entry, f.array_size as u32))
                        .copied()
                        .unwrap_or(elem_off)
                } else {
                    elem_off
                };

                if f.bit_width == 0 {
                    write_uleb128(body, ABBREV_MEMBER);
                    body.extend_from_slice(&member_name_off.to_le_bytes());
                    body.extend_from_slice(&member_type_off.to_le_bytes());
                    body.extend_from_slice(&(f.offset as u32).to_le_bytes());
                } else {
                    let data_bit_offset = (f.offset as u64) * 8 + f.bit_offset as u64;
                    write_uleb128(body, ABBREV_BITFIELD_MEMBER);
                    body.extend_from_slice(&member_name_off.to_le_bytes());
                    body.extend_from_slice(&member_type_off.to_le_bytes());
                    write_uleb128(body, data_bit_offset);
                    write_uleb128(body, f.bit_width as u64);
                }
            }
            body.push(0);
        }
        CatalogEntry::VoidStar => {
            write_uleb128(body, ABBREV_BASE_TYPE);
            body.extend_from_slice(&catalog.void_star_name_off.to_le_bytes());
            body.push(8);
            body.push(DW_ATE_ADDRESS);
        }
    }
}

/// Coarse arch flavour the CFI emitter dispatches on.
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

/// `code_alignment_factor` -- the multiplier applied to factored PC deltas
/// in CIE / FDE instructions.
fn cfi_code_alignment_factor(arch: CfiArch) -> u64 {
    match arch {
        CfiArch::Aarch64 => 4,
        CfiArch::X86_64 => 1,
    }
}

const CFI_DATA_ALIGNMENT_FACTOR: i64 = -8;

/// DWARF return-address register column.
fn cfi_return_address_register(arch: CfiArch) -> u64 {
    match arch {
        CfiArch::Aarch64 => AARCH64_REG_X30 as u64,
        CfiArch::X86_64 => X86_64_REG_RA as u64,
    }
}

/// Initial CFI rules effective at function entry.
fn write_cie_initial_instructions(out: &mut Vec<u8>, arch: CfiArch) {
    match arch {
        CfiArch::Aarch64 => {
            out.push(DW_CFA_DEF_CFA);
            write_uleb128(out, AARCH64_REG_SP as u64);
            write_uleb128(out, 0);
        }
        CfiArch::X86_64 => {
            out.push(DW_CFA_DEF_CFA);
            write_uleb128(out, X86_64_REG_RSP as u64);
            write_uleb128(out, 8);
            out.push(DW_CFA_OFFSET_HI | X86_64_REG_RA);
            write_uleb128(out, 1);
        }
    }
}

/// CFI rules effective from the first byte of the function body (i.e. after
/// the prologue completes).
fn write_post_prologue_instructions(out: &mut Vec<u8>, arch: CfiArch) {
    match arch {
        CfiArch::Aarch64 => {
            out.push(DW_CFA_DEF_CFA);
            write_uleb128(out, AARCH64_REG_X29 as u64);
            write_uleb128(out, 16);
            out.push(DW_CFA_OFFSET_HI | AARCH64_REG_X29);
            write_uleb128(out, 2);
            out.push(DW_CFA_OFFSET_HI | AARCH64_REG_X30);
            write_uleb128(out, 1);
        }
        CfiArch::X86_64 => {
            // CFA = rbp + 16 (rbp covers ret-addr + saved-rbp slots). rbp
            // itself saved at CFA - 16; the return address at CFA - 8 was
            // already declared by the CIE and stays put.
            out.push(DW_CFA_DEF_CFA);
            write_uleb128(out, X86_64_REG_RBP as u64);
            write_uleb128(out, 16);
            out.push(DW_CFA_OFFSET_HI | X86_64_REG_RBP);
            write_uleb128(out, 2);
        }
    }
}

/// Encode a `DW_CFA_advance_loc` covering `bytes` of native code, expanding
/// into the smallest opcode form that fits the factored delta.
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

/// Common-Information Entry header (`.debug_frame` form).
#[repr(C, packed)]
struct DebugFrameCieHeader {
    unit_length: u32,
    cie_id: u32,
    version: u8,
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

/// VMA range covered by the PLT trampoline pool, or `None` when the binary
/// has no imports.
fn plt_pool_range(build: &Build, code_vmaddr: u64) -> Option<(u64, u64)> {
    let first = build
        .plt_trampoline_offsets
        .iter()
        .copied()
        .flatten()
        .min()?;
    let start = code_vmaddr + first as u64;
    let end = code_vmaddr + build.text.len() as u64;
    if end > start {
        Some((start, end))
    } else {
        None
    }
}

/// Build the `.debug_frame` section: one CIE at offset 0, one FDE per
/// `Subprog`, plus optional final FDEs covering the PLT trampoline pool and
/// the ELF `_start` stub.
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

    let mut cie_body: Vec<u8> = Vec::new();
    write_uleb128(&mut cie_body, cfi_code_alignment_factor(arch));
    write_sleb128(&mut cie_body, CFI_DATA_ALIGNMENT_FACTOR);
    write_uleb128(&mut cie_body, cfi_return_address_register(arch));
    write_cie_initial_instructions(&mut cie_body, arch);

    // `unit_length` covers everything after itself, so its own 4 bytes
    // are subtracted. The record is padded to 8 bytes so the FDE that
    // follows starts 8-aligned, as 64-bit address-size CFI requires.
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
    let actual_cie_unit_length = (cie.len() - 4) as u32;
    cie[..4].copy_from_slice(&actual_cie_unit_length.to_le_bytes());
    out.extend_from_slice(&cie);

    for sub in subs {
        let mut fde_body: Vec<u8> = Vec::new();
        let sign_end = sub.ra_signed_at.map(|at| at + 4);
        if let Some(end) = sign_end
            && sub.prologue_size >= end
        {
            write_advance_loc(&mut fde_body, arch, end);
            fde_body.push(DW_CFA_NEGATE_RA_STATE);
            write_advance_loc(&mut fde_body, arch, sub.prologue_size - end);
        } else if sub.prologue_size > 0 {
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

    // Emit one FDE covering the entire PLT trampoline pool. Trampolines are
    // stack-neutral leaves -- aarch64's `adrp+ldr+br` doesn't touch sp /
    // x30, x86_64's `jmp [rip+ disp]` doesn't touch rsp.
    if let Some((start, end)) = plt_pool {
        out.extend_from_slice(&fde_with_body(start, end, &[]));
    }

    // Emit one FDE covering the ELF `_start` stub. Mark the return- address
    // column as `DW_CFA_undefined` so the unwinder recognises the bottom of
    // the stack and stops with a clean "Backtrace stopped: at top of stack"
    // instead of reading garbage.
    if let Some((start, end)) = start_stub {
        let ra_col = cfi_return_address_register(arch);
        let mut body: Vec<u8> = Vec::with_capacity(4);
        body.push(DW_CFA_UNDEFINED);
        write_uleb128(&mut body, ra_col);
        out.extend_from_slice(&fde_with_body(start, end, &body));
    }

    out
}

/// Build one `.debug_frame` FDE record with the given address range and
/// body bytes (the inline CFI program).
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

/// Build the line-number program for the whole binary in one
/// statement-program unit, plus the unit header.
fn build_debug_line(
    program: &Program,
    build: &Build,
    code_vmaddr: u64,
    source_path: &str,
) -> (Vec<u8>, u32) {
    let mut prog = Vec::with_capacity(256);
    write_line_program(&mut prog, program, build, code_vmaddr);

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
    for &n in &[0u8, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 1] {
        hdr_after_len_field.push(n);
    }
    hdr_after_len_field.push(0);
    // file_names: DWARF file numbering starts at 1 (0 is reserved for "no
    // file"), so the first entry in this list lands at index 1.
    let tu_name = if source_path.is_empty() {
        "<unknown>"
    } else {
        source_path
    };
    push_file_entry(&mut hdr_after_len_field, tu_name);
    for src in program.source_files.iter().filter(|s| *s != "<source>") {
        push_file_entry(&mut hdr_after_len_field, src);
    }
    hdr_after_len_field.push(0); // file_names terminator

    let header_length = hdr_after_len_field.len() as u32;
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

/// The statement program: `DW_LNE_set_address` at `code_vmaddr`, the rows,
/// and `DW_LNE_end_sequence` one past the user code, so the last row does
/// not cover the PLT trampolines past it.
fn write_line_program(buf: &mut Vec<u8>, program: &Program, build: &Build, code_vmaddr: u64) {
    write_extended(buf, DW_LNE_SET_ADDRESS, &code_vmaddr.to_le_bytes());
    let files = dwarf_file_numbers(program);
    let mut state = LineState::new(code_vmaddr);
    write_line_rows(buf, build, &files, code_vmaddr, &mut state);
    state.end_sequence(buf, code_vmaddr + end_of_user_text(build) as u64);
}

/// DWARF file number of each `program.source_files` entry.
pub(super) fn dwarf_file_numbers(program: &Program) -> Vec<u64> {
    let mut next: u64 = 2;
    program
        .source_files
        .iter()
        .map(|name| {
            if name == "<source>" {
                1
            } else {
                let n = next;
                next += 1;
                n
            }
        })
        .collect()
}

/// One `file_names` entry: the name, directory 0, no mtime, no size.
pub(super) fn push_file_entry(out: &mut Vec<u8>, name: &str) {
    out.extend_from_slice(name.as_bytes());
    out.push(0);
    write_uleb128(out, 0);
    write_uleb128(out, 0);
    write_uleb128(out, 0);
}

/// The line-number state machine's registers the program advances.
pub(super) struct LineState {
    addr: u64,
    line: i64,
    file: u64,
    row_emitted: bool,
}

impl LineState {
    pub(super) fn new(addr: u64) -> Self {
        LineState {
            addr,
            line: 1,
            file: 1,
            row_emitted: false,
        }
    }

    /// Advance to `(addr, line, file)`, emitting a row when anything
    /// changed; `prologue_end` stamps `DW_LNS_set_prologue_end` on it.
    pub(super) fn emit_row(
        &mut self,
        buf: &mut Vec<u8>,
        addr: u64,
        line: i64,
        file: u64,
        prologue_end: bool,
    ) {
        if addr > self.addr {
            advance_pc(buf, addr - self.addr);
            self.addr = addr;
            self.row_emitted = false;
        }
        if file != self.file {
            buf.push(DW_LNS_SET_FILE);
            write_uleb128(buf, file);
            self.file = file;
            self.row_emitted = false;
        }
        if line != self.line {
            advance_line(buf, line - self.line);
            self.line = line;
            self.row_emitted = false;
        }
        if !self.row_emitted {
            if prologue_end {
                buf.push(DW_LNS_SET_PROLOGUE_END);
            }
            buf.push(DW_LNS_COPY);
            self.row_emitted = true;
        }
    }

    /// `DW_LNE_end_sequence` one past `end`.
    pub(super) fn end_sequence(&mut self, buf: &mut Vec<u8>, end: u64) {
        if end > self.addr {
            advance_pc(buf, end - self.addr);
            self.addr = end;
        }
        write_extended(buf, DW_LNE_END_SEQUENCE, &[]);
    }
}

/// One row per source-position change the SSA emit recorded, at `base` plus
/// the native offset.
pub(super) fn write_line_rows(
    buf: &mut Vec<u8>,
    build: &Build,
    files: &[u64],
    base: u64,
    state: &mut LineState,
) {
    let mut func_starts: Vec<usize> = build
        .func_ent_pcs
        .iter()
        .filter_map(|&pc| build.pc_to_native.get(pc).copied())
        .filter(|&n| n != usize::MAX)
        .collect();
    func_starts.sort_unstable();
    func_starts.dedup();
    let mut func_start_iter = func_starts.iter().copied().peekable();
    let mut prologue_end_pending = false;
    for &(native, line, file_idx) in &build.ssa_line_rows {
        if line == 0 {
            continue;
        }
        let file = files.get(file_idx as usize).copied().unwrap_or(1);
        let target_addr = base + native as u64;
        while let Some(&fn_start) = func_start_iter.peek() {
            let entry_addr = base + fn_start as u64;
            if entry_addr > target_addr {
                break;
            }
            state.emit_row(buf, entry_addr, line as i64, file, false);
            func_start_iter.next();
            prologue_end_pending = true;
        }
        state.emit_row(buf, target_addr, line as i64, file, prologue_end_pending);
        prologue_end_pending = false;
    }
}

pub(super) fn write_extended(buf: &mut Vec<u8>, op: u8, data: &[u8]) {
    buf.push(0);
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

struct StrTable {
    bytes: Vec<u8>,
}

impl StrTable {
    fn new() -> Self {
        // DWARF .debug_str must start with a string at offset 0; a single
        // NUL works as the empty-string root entry.
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

#[cfg(test)]
mod tests {
    use super::*;

    /// Byte-stability lock for the amalg `.debug_abbrev` table.
    #[test]
    fn build_debug_abbrev_is_byte_stable() {
        let hex: alloc::string::String = build_debug_abbrev()
            .iter()
            .map(|b| alloc::format!("{b:02x}"))
            .collect();
        assert_eq!(
            hex,
            "011101250e130b030e1b0e1101120710170000022e01030e110112073f192719360b\
             40180000132e01030e110112072719360b40180000032400030e0b0b3e0b00000434\
             00030e491302183a0f3b0f0000050500030e491302183a0f3b0f0000060f000b0b49\
             130000071301030e0b060000081701030e0b060000090d00030e4913380600000a0d\
             00030e49136b0f0d0f00000b2e01030e110112073f19491300000c0500030e491300\
             000d180000000e0500030e4913021800000f0101491300001021002f0f0000110401\
             03080b0b000012280003081c0d000000"
        );
    }

    /// This module emits DWARF for a single translation unit written
    /// straight to a final image (`emit_native_with_options` with a
    /// non-relocatable `OutputKind`); `dwarf_reloc` emits it for ET_REL,
    /// which the linker merges.
    #[test]
    fn abbrev_attribute_forms_match_the_et_rel_producer() {
        const FIXED_WIDTH_HERE: &[u32] = &[DW_AT_BYTE_SIZE, DW_AT_DATA_MEMBER_LOCATION];

        // The enum DIEs here are written after the string table is sealed,
        // so their names stay inline where every other name in both
        // producers is a `.debug_str` reference.
        let norm = |form: u32| {
            if form == DW_FORM_STRING {
                DW_FORM_STRP
            } else {
                form
            }
        };
        let mut here: BTreeMap<u32, BTreeSet<u32>> = BTreeMap::new();
        for d in ABBREV_DECLS {
            for &(at, form) in d.attrs {
                here.entry(at).or_default().insert(norm(form));
            }
        }
        let mut there: BTreeMap<u32, BTreeSet<u32>> = BTreeMap::new();
        for (at, form) in super::super::dwarf_reloc::abbrev_attr_forms() {
            there.entry(at as u32).or_default().insert(form as u32);
        }
        for (at, forms) in &here {
            if FIXED_WIDTH_HERE.contains(at) {
                continue;
            }
            let Some(other) = there.get(at) else { continue };
            assert_eq!(
                forms, other,
                "attribute {at:#04x} is encoded differently by the two DWARF producers",
            );
        }
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
        let struct_ty = types::STRUCT_BASE;
        assert_eq!(
            classify(struct_ty, Target::LinuxX64),
            CatalogEntry::Struct { id: 0 },
        );
    }

    #[test]
    fn classify_struct_pointer_returns_chain_entry() {
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
        build.plt_trampoline_offsets = alloc::vec![Some(0xc0), Some(0xcc)];
        build.text.extend(alloc::vec![0u8; 0x40]); // pretend trampolines are appended
        assert_eq!(plt_pool_range(&build, 0x1000), Some((0x10c0, 0x1140)));
    }

    #[test]
    fn debug_frame_emits_plt_fde_when_pool_present() {
        // The PLT trampoline pool gets one extra FDE so unwinders can step
        // through a stub. Body is empty -- the FDE inherits the CIE's
        // initial CFA rule, which exactly matches the trampoline's "no
        // stack manipulation" shape.
        let subs: Vec<Subprog> = Vec::new(); // no user subs is fine
        let with_pool =
            build_debug_frame(Target::LinuxAarch64, &subs, Some((0x1100, 0x1140)), None);
        let without_pool = build_debug_frame(Target::LinuxAarch64, &subs, None, None);
        assert!(without_pool.is_empty(), "no subs + no pool -> empty");
        assert!(
            !with_pool.is_empty(),
            "no subs + pool -> CIE + PLT FDE bytes"
        );
        // With an empty FDE body the unit_length field is exactly the inner
        // header size (cie_pointer + initial_location + address_range = 4 +
        // 8 + 8 = 20 bytes), so the FDE record is 4 (unit_length) + 20 = 24
        // bytes -- already 8-aligned, no DW_CFA_nop padding required.
        let last_24 = &with_pool[with_pool.len() - 24..];
        assert_eq!(&last_24[..4], &20u32.to_le_bytes());
        assert_eq!(&last_24[8..16], &0x1100u64.to_le_bytes());
        assert_eq!(&last_24[16..24], &0x40u64.to_le_bytes());
    }

    #[test]
    fn debug_frame_flags_a_signed_return_address() {
        let sub = |ra_signed_at| Subprog {
            name_off: 0,
            low_pc: 0x1000,
            high_pc: 0x1040,
            prologue_size: 12,
            ra_signed_at,
            variables: Vec::new(),
            external: true,
        };
        let body = |ra_signed| {
            let out = build_debug_frame(Target::LinuxAarch64, &[sub(ra_signed)], None, None);
            let fde = 4 + u32::from_le_bytes(out[..4].try_into().unwrap()) as usize;
            let len = u32::from_le_bytes(out[fde..fde + 4].try_into().unwrap()) as usize;
            let mut b = out[fde + 24..fde + 4 + len].to_vec();
            while b.last() == Some(&0) {
                b.pop();
            }
            b
        };
        let plain = body(None);
        let signed = body(Some(0));
        assert!(
            !plain.contains(&DW_CFA_NEGATE_RA_STATE),
            "an unsigned frame claims nothing"
        );
        assert_eq!(
            &signed[..3],
            &[
                DW_CFA_ADVANCE_LOC_HI | 1,
                DW_CFA_NEGATE_RA_STATE,
                DW_CFA_ADVANCE_LOC_HI | 2,
            ]
        );
        assert_eq!(&signed[3..], &plain[1..], "same rules follow");
        let displaced = body(Some(8));
        assert_eq!(
            &displaced[..2],
            &[DW_CFA_ADVANCE_LOC_HI | 3, DW_CFA_NEGATE_RA_STATE]
        );
        assert_eq!(&displaced[2..], &plain[1..], "same rules follow");
    }

    #[test]
    fn collect_plt_subprograms_uses_offset_delta_not_text_len() {
        // Per-stub size must come from the offset delta between consecutive
        // trampolines, NOT from `build.text.len() - first_offset`.
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
                    is_object: false,
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
                    is_object: false,
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
            plt_trampoline_offsets: alloc::vec![Some(0xc0), Some(0xcc)],
            imports,
            ..Build::default()
        };
        let mut strs = StrTable::new();
        let plt_subs = collect_plt_subprograms(&build, Target::LinuxAarch64, 0x1000, &mut strs);
        assert_eq!(plt_subs.len(), 2);
        // 0xcc - 0xc0 = 12 bytes per stub. high_pc - low_pc must match --
        // if it overshoots, gdb's DIE lookup for "address near printf"
        // lands on the wrong subprogram and typed PLT signatures fail to
        // resolve.
        assert_eq!(plt_subs[0].high_pc - plt_subs[0].low_pc, 12);
        assert_eq!(plt_subs[1].high_pc - plt_subs[1].low_pc, 12);
        assert_eq!(plt_subs[0].low_pc, 0x10c0);
        assert_eq!(plt_subs[1].low_pc, 0x10cc);
    }

    #[test]
    fn dwarf_arg_reg_maps_per_abi() {
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
        // The `_start` FDE must mark the return-address column as
        // `DW_CFA_undefined` so the unwinder terminates cleanly.
        let subs: Vec<Subprog> = Vec::new();
        let bytes = build_debug_frame(
            Target::LinuxAarch64,
            &subs,
            None,
            Some((0x1000, 0x1018)), // 24-byte aarch64 _start stub
        );
        let last_32 = &bytes[bytes.len() - 32..];
        let unit_len = u32::from_le_bytes(last_32[..4].try_into().unwrap());
        assert_eq!(unit_len as usize, 28);
        assert_eq!(&last_32[8..16], &0x1000u64.to_le_bytes());
        assert_eq!(&last_32[16..24], &0x18u64.to_le_bytes());
        assert_eq!(last_32[24], DW_CFA_UNDEFINED);
        assert_eq!(last_32[25], 30);
    }

    #[test]
    fn end_of_user_text_skips_plt_pool() {
        // When the PLT trampoline pool follows user code, the line-table
        // end_sequence and last Subprog::high_pc must stop at the first
        // trampoline byte.
        let mut build = Build {
            copy_relocs: Default::default(),
            text: alloc::vec![0u8; 0x200],
            plt_trampoline_offsets: alloc::vec![Some(0x180), Some(0x18c), Some(0x198)],
            ..Build::default()
        };
        assert_eq!(end_of_user_text(&build), 0x180);

        build.plt_trampoline_offsets.clear();
        assert_eq!(end_of_user_text(&build), 0x200);
    }

    #[test]
    fn pointer_chain_insert_back_fills_shallower_levels() {
        let mut entries: BTreeSet<CatalogEntry> = BTreeSet::new();
        let leaf = base_of(Ty::Int as i64, Target::LinuxX64);
        TypeCatalog::insert_with_chain(&mut entries, CatalogEntry::Pointer { leaf, depth: 3 });
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

    /// Byte-stability lock for the amalg `.debug_info` CU.
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
            ra_signed_at: None,
            variables: alloc::vec![],
            external: true,
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
