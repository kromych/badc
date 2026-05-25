//! `LinkUnit` -- the pre-link representation of one translation
//! unit. A superset of [`Program`]: everything `Program` carries
//! plus a per-TU symbol table (defined and undefined names) and
//! a relocation list naming each cross-TU reference's location
//! and target.
//!
//! `Program` is the post-link shape: a single self-contained
//! image with every reference already pointing at a real `text`
//! / `data` offset. `LinkUnit` is the on-disk shape of a `.o`
//! file's payload (the ELF wrapper carries the same fields, just
//! split into sections). The linker consumes one or more
//! `LinkUnit`s and produces one `Program`.

use alloc::string::String;
use alloc::vec::Vec;

use crate::c5::compiler::StructDef;
use crate::c5::preprocessor::{DylibSpec, Subsystem};
use crate::c5::program::{CodeReloc, DataReloc, ExportedFunction, VariableInfo};

use super::reloc::Reloc;
use super::symbol::LinkSymbol;

/// Pre-link, single-translation-unit container. Field layout
/// intentionally mirrors [`Program`] so the [`Program`] -> writer
/// pipeline can be re-used after the link step concatenates
/// everything into one merged unit.
///
/// The mirror is deliberate: when `link_units` finishes, it
/// constructs a single `Program` whose `text` / `data` /
/// `tls_data` are the concatenation of every unit's
/// counterparts, plus the merged dylib / struct / source-file
/// / export tables. The merged Program is then handed to the
/// existing `emit_native_*` codegen unchanged.
#[derive(Debug, Clone, Default)]
pub struct LinkUnit {
    // ---- Bytecode and static data (mirror of Program) ----
    pub text: Vec<i64>,
    pub data: Vec<u8>,
    pub tls_data: Vec<u8>,
    pub tls_init_size: usize,

    // ---- Per-PC side tables (PC-indexed; remapped at link) ----
    /// Indices into `text` of `Op::Imm` operands whose value is a
    /// data-segment byte offset. Mirror of
    /// `Program::data_imm_positions`.
    pub data_imm_positions: Vec<usize>,
    /// Indices into `text` of `Op::Imm` operands whose value is
    /// `CODE_BASE + bc_pc`. Mirror of
    /// `Program::code_imm_positions`.
    pub code_imm_positions: Vec<usize>,
    /// Mirror of `Program::variadic_functions`. Each entry is the
    /// unit-local `Op::Ent` PC of a c5 function whose declarator
    /// ended in `...`. The linker re-bases each by
    /// `text_offset[unit]` and unions them into the merged
    /// program's `variadic_functions` set.
    pub variadic_functions: Vec<usize>,
    /// Mirror of `Program::source_lines`, parallel to `text`.
    pub source_lines: Vec<u32>,
    /// Mirror of `Program::source_functions`, parallel to `text`.
    pub source_functions: Vec<String>,
    /// Filename table for the unit. Indices in
    /// `source_file_indices` reference this list; the linker
    /// merges per-unit tables into a single global file table
    /// and re-indexes the per-PC vector.
    pub source_files: Vec<String>,
    /// Mirror of `Program::source_file_indices`, parallel to
    /// `text`.
    pub source_file_indices: Vec<u16>,
    /// Mirror of `Program::variables` -- per-function DWARF
    /// locals. `function_bc_pc` is unit-local and re-based by
    /// `text_offset[unit]` at link.
    pub variables: Vec<VariableInfo>,

    // ---- Intra-unit relocations (resolved at compile, surfaced for codegen) ----
    /// Intra-unit address-of-global initializers. The two
    /// offsets are unit-local; the linker re-bases both by
    /// `data_offset[unit]`.
    pub data_relocs: Vec<DataReloc>,
    /// Intra-unit function-pointer slot initializers. The
    /// `target_bc_pc` is unit-local and re-based by
    /// `text_offset[unit]`; the `data_offset` is re-based by
    /// `data_offset[unit]`.
    pub code_relocs: Vec<CodeReloc>,

    // ---- Preprocessor / parser metadata (merged at link) ----
    pub dylibs: Vec<DylibSpec>,
    pub structs: Vec<StructDef>,
    pub exports: Vec<ExportedFunction>,
    pub dllmain_pc: Option<usize>,
    pub entry_name: Option<String>,
    pub subsystem: Option<Subsystem>,
    pub source_path: String,
    pub warnings: Vec<String>,

    // ---- Linker-specific ----
    /// Per-unit symbol table. Each entry names a function or
    /// data symbol defined in this unit (with external or
    /// internal linkage) or an unresolved external reference.
    /// Internal-linkage symbols are kept in the table so the
    /// per-unit relocation list can point at them by index --
    /// the link step itself never surfaces them across the
    /// global symbol map.
    pub symbols: Vec<LinkSymbol>,
    /// Cross-TU patches. Each entry points at a location in
    /// `text` or `data` whose final value depends on resolving
    /// a [`LinkSymbol`]; the linker applies the patch once it
    /// has merged all units.
    pub relocs: Vec<Reloc>,
    /// Per-function AST snapshots captured at parse-time by
    /// `compile_to_link_unit`. The linker preserves them so the
    /// walker can drive the codegen post-link. Multi-TU links
    /// re-base each entry's `ent_pc` by the unit's `text_offset`
    /// (mirroring how `code_imm_positions` and similar PC-indexed
    /// side tables re-base).
    pub(crate) finished_functions: Vec<crate::c5::ast::FinishedFunction>,
    /// Parser symbol-table snapshot at compile-end. The walker
    /// reads `array_size` + `type_` off these for shapes the AST
    /// node fields don't yet carry. Multi-TU links concatenate;
    /// `Expr::Ident.sym` indices into this slice are unit-local
    /// and re-based by the unit's `symbols_offset` if the
    /// linker grows that bookkeeping.
    pub(crate) parser_symbols: Vec<crate::c5::symbol::Symbol>,
    /// Sys-trampoline `FunctionSsa` entries synthesised by
    /// `emit_sys_trampolines`. Each one mirrors a bytecode
    /// trampoline in the unit's text; the linker rebases
    /// `ent_pc` / `end_pc` by `text_base[i]` and remaps the
    /// `CallExt::binding_idx` / `Terminator::TailExt(idx)`
    /// through `binding_remap_per_unit[i]`. Surviving across
    /// object-file round-trips lets the codegen reach the
    /// trampolines without re-running `lift_program`.
    pub(crate) synthetic_ssa_funcs: Vec<crate::c5::ir::FunctionSsa>,
    /// User-function `FunctionSsa` entries, produced by the
    /// walker during `compile_to_link_unit`. Carries the
    /// canonical SSA across `.o` round-trips so the codegen
    /// can consume it directly from the archive-reload path.
    /// Empty only for `Program` shapes built outside the
    /// parser pipeline (optimizer unit tests with raw
    /// bytecode, codegen writer fixtures); `produce_ssa_funcs`
    /// routes those through `lift_program`.
    pub(crate) user_ssa_funcs: Vec<crate::c5::ir::FunctionSsa>,
}
