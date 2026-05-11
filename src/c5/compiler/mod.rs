use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

use super::CODE_BASE;
use super::codegen::Target;
use super::error::C5Error;
use super::lexer::{self, Lexer};
use super::op::Op;
use super::preprocessor::{DylibSpec, Preprocessor};
use super::program::Program;
use super::symbol::Symbol;
use super::token::{Token, Ty};

mod aggregate;
mod const_expr;
mod declarator;
mod enum_decl;
mod function;
mod global_init;
mod initializer;
mod locals;
mod sizeof_expr;
mod stmt;
pub(crate) mod types;

use types::{
    UNSIGNED_BIT, format_signature, format_type, fp_result_ty, is_decl_modifier,
    is_floating_scalar, is_pointer_ty, is_scalar_load_op_val, is_struct_ty, is_type_start_token,
    is_unsigned_ty, load_op_for, pointee_size_no_struct, reemit_scalar_load, store_op_for,
    struct_id_of, struct_ptr_depth, struct_ty_for, usual_arith_common_ty,
};

#[derive(Debug, Clone)]
pub struct StructDef {
    pub name: String,
    /// Total size in bytes -- sum of field sizes (each placed at
    /// its natural alignment) for structs, `max(field size)` for
    /// unions, padded up to the struct's own alignment. Always at
    /// least 8 (c5 has no zero-sized aggregates).
    pub size: usize,
    /// Alignment of the aggregate in bytes -- the max alignment of
    /// any field, capped at 8 (the rest of c5's IR -- locals,
    /// stack pushes, GOT entries -- is 8-byte slotted, so
    /// over-aligning a struct above 8 buys nothing). `0` until
    /// `parse_aggregate_body` finishes.
    pub align: usize,
    pub fields: Vec<StructField>,
    /// `true` for `union` definitions. The only effect on layout
    /// is that every field sits at offset 0 and the aggregate
    /// size is `max(field size)` instead of the sum. Member
    /// access otherwise reuses the struct path verbatim.
    pub is_union: bool,
}

/// Relocation kind for one initializer-element value. Tracks
/// whether the bytes need to be patched at link / load time so
/// the per-format writer can emit the right rebase entry.
#[derive(Debug, Clone, Copy)]
pub(super) enum InitElemReloc {
    /// Plain integer constant; bytes are final.
    None,
    /// Value is a data-segment offset; needs a DataReloc.
    Data,
    /// Value is a function bytecode PC; needs a CodeReloc. The
    /// payload is the function's symbol index, captured at parse
    /// time so the post-body fixup pass can look up the
    /// resolved bytecode PC and patch both the data bytes and
    /// the matching `Program::code_relocs` entry.
    Code(usize),
    /// Value is an IEEE-754 f64 bit pattern produced by a float
    /// literal or a constant-folded float arithmetic expression.
    /// The writer narrows to f32 when the element type is
    /// `float` (4 bytes) and stores the full pattern when it's
    /// `double` (8 bytes). No on-image relocation; the marker
    /// only flows through to disambiguate `static float a[] = {
    /// 1.0f, ... }` (f64 bit pattern) from `static float a[] = {
    /// 1, ... }` (raw int that still has to be converted to
    /// f32 bits, since the storage slot is FP, not integer).
    Float64Bits,
}

#[derive(Debug, Clone)]
pub struct StructField {
    pub name: String,
    /// Byte offset of the field from the start of the struct.
    /// For a bitfield, the byte offset of the *storage unit*
    /// (8-byte word) the bitfield lives in.
    pub offset: usize,
    /// `ty`-encoded type of the field.
    pub ty: i64,
    /// Array dimension if the field was declared as `T xs[N]`;
    /// 0 when the field is a scalar / pointer / struct value.
    /// For a 2D field `T xs[N][M]` this stores the total element
    /// count (`N * M`) and `inner_array_size = M`. `s.xs` decays
    /// to a pointer-to-element the same way a local array does.
    pub array_size: i64,
    /// Inner dimension for a 2D-or-greater array field
    /// (`T xs[N][M]` -> `M`). Mirrors `Symbol::inner_array_size`:
    /// with this set, the `s.xs[i]` postfix scales `i` by
    /// `M * sizeof(T)` and stays at pointer type so the next
    /// `[j]` decays to an element. Used by the 2D-init padding
    /// path. 0 for 1D / scalar fields.
    pub inner_array_size: i64,
    /// Full dimension list for an N-dim array field, outermost
    /// first. Mirrors `Symbol::array_dims`. Empty for non-array
    /// or 1D-array fields. The field-access decay path reads
    /// this to compute the per-level strides for `s.xs[i][j][k]`.
    pub array_dims: Vec<i64>,
    /// Bit offset within the 8-byte storage unit. Meaningful only
    /// when `bit_width > 0`.
    pub bit_offset: u32,
    /// Bit width of a bitfield, or 0 for a regular field. Bitfields
    /// pack into shared 8-byte storage units; reads emit
    /// `Li; Imm bit_offset; Shr; Imm mask; And` and writes emit a
    /// load-clear-shift-or-store sequence.
    pub bit_width: u32,
}

/// Bundle returned from `parse_function_params` -- keeps the per-param
/// symbol indices (needed by the function-body binding step) together
/// with the declared types and the variadic flag (needed by the type
/// checker at every call site).
pub(super) struct ParsedParams {
    pub(super) indices: Vec<usize>,
    pub(super) types: Vec<i64>,
    pub(super) is_variadic: bool,
}

/// Single-pass C compiler. Holds the lexer, the symbol table, and the
/// codegen scaffolding. `compile(self)` consumes the compiler and produces
/// a [`Program`] ready for the VM.
pub struct Compiler {
    lex: Lexer,
    symbols: Vec<Symbol>,
    /// Side hash index over `symbols`, kept in lockstep with it so
    /// `find_symbol` / `resolve_symbol` are O(1) amortised instead of
    /// scanning the whole vector on every identifier.
    symbol_index: lexer::SymbolIndex,

    // --- Codegen state ---
    text: Vec<i64>,
    data: Vec<u8>,
    /// Type of the current expression -- set by `expr` callees, read by callers
    /// to decide between byte and word loads/stores and for pointer scaling.
    ty: i64,
    /// Number of local-variable slots currently reserved in the active stack
    /// frame. User-declared locals push it up monotonically; call-arg staging
    /// (parse_function_args) bumps it temporarily for each in-flight call's
    /// reverse-push temp slots and then restores it.
    loc_offs: i64,
    /// Per-function high-water mark of `loc_offs` -- patched into `Op::Ent`
    /// at the end of the function so the prologue reserves enough stack for
    /// every nested-call temp the function ever needs.
    max_loc_offs: i64,

    /// True once the current function has emitted at least one
    /// `Op::Intrinsic(Alloca)` call. Drives the function-end
    /// backpatch that grows `Op::Ent`'s local count to include the
    /// alloca arena and sets the matching `Op::AllocaInit`'s
    /// operand to the alloca-top slot index. Reset on each new
    /// function definition.
    uses_alloca_in_current_fn: bool,

    /// PC of the `Op::AllocaInit` placeholder emitted right after
    /// each function's `Op::Ent`. The function-end fixup pass
    /// writes the alloca-top slot index here when the function
    /// turned out to use alloca; otherwise the placeholder
    /// stays at 0 and the codegen treats AllocaInit as a no-op.
    alloca_init_operand_pc: usize,

    // --- Patch lists ---
    loop_breaks: Vec<Vec<usize>>,
    loop_continues: Vec<Vec<usize>>,
    /// Linear table of `(label_name, text_pc)`. Per-function (cleared
    /// at every function start), so it stays small -- typically 0-2
    /// entries even in code that uses `goto`. Linear scan beats
    /// pulling in `HashMap` (which would force `std`).
    labels: Vec<(String, usize)>,
    unresolved_gotos: Vec<(String, usize)>,
    switch_cases: Vec<Vec<(i64, usize)>>,
    switch_defaults: Vec<Option<usize>>,

    /// Defined struct types, indexed by struct id.
    pub(super) structs: Vec<StructDef>,

    /// Type-mismatch warnings collected during compilation. Stored as
    /// formatted lines so the final consumer (CLI / test) can dump them
    /// without knowing their structure. Warnings never fail the compile --
    /// c4 was permissive by design and many idioms (NULL=0, void*~char*)
    /// would otherwise drown the output.
    warnings: Vec<String>,

    /// gcc `-H`-shape include trace produced by the preprocessor when
    /// `with_full_options_and_label_with_trace(.., show_includes =
    /// true)` was used. Empty otherwise. The CLI flushes this list
    /// to stderr after the compile finishes; library callers can
    /// drain it via [`Self::take_include_trace`].
    include_trace: Vec<String>,

    /// `#pragma entrypoint(<name>)` value drained from the
    /// preprocessor. Default `None` means "use `main`".
    /// Read in `compile()` to compute `entry_pc` and threaded onto
    /// `Program::entry_name`.
    pp_entrypoint: Option<String>,
    /// `#pragma subsystem(<kind>)` value drained from the
    /// preprocessor. Default `None` means "PE writer
    /// picks `Console`". Read only by the PE writers.
    pp_subsystem: Option<crate::c5::preprocessor::Subsystem>,

    /// `#pragma intrinsic("name")` map drained from the
    /// preprocessor. Used at declaration time to stamp
    /// `Symbol::intrinsic` on matching callables so the
    /// call-site lowering can substitute `Op::Intrinsic <id>`
    /// for the regular Psh/Jsr/JsrExt + Adj sequence.
    pp_intrinsics: alloc::collections::BTreeMap<String, i64>,

    /// Bytecode positions (indices into `text`) of `Op::Imm` operands
    /// that hold an offset into the data segment. Recorded at emit time
    /// because the native backend can't rediscover them from the
    /// bytecode alone -- a small Imm could be a global's address or
    /// just an integer literal. The VM doesn't care; this rides along
    /// in `Program` for the native codegen to consume.
    data_imm_positions: Vec<usize>,
    /// Mirror of [`Self::data_imm_positions`] for function-
    /// pointer literals. Each entry is the bc index of an
    /// `Op::Imm` operand whose value is (CODE_BASE + bc_pc).
    /// Recorded explicitly so the codegen can disambiguate
    /// without a value-range heuristic that would misclassify
    /// any user integer constant in the [CODE_BASE, CODE_BASE +
    /// text.len()) range.
    code_imm_positions: Vec<usize>,

    /// Thread-local data segment. Same shape as `data` but the
    /// codegen lowers accesses with the per-target TLS sequence
    /// (TPIDR_EL0 + offset on aarch64, fs:0 + offset on x86_64,
    /// the .tls$ callback chain on Win64). Each `_Thread_local`
    /// global gets `slots_of_type(ty) * 8` bytes here, with
    /// `Symbol::val` holding the byte offset within `tls_data`.
    /// Today we don't parse TLS initialisers, so the segment is
    /// always zero-filled and goes entirely into .tbss; the layout
    /// leaves room for a future "initialised TLS image -> .tdata"
    /// path.
    tls_data: Vec<u8>,
    /// Number of bytes at the start of [`Self::tls_data`] that
    /// are statically initialised by an explicit
    /// `_Thread_local int x = 5;` initializer. The remainder
    /// (`tls_data.len() - tls_init_size`) is zero-fill. Today
    /// only TLS initializer variants supported by the parser
    /// land here; uninitialised TLS keeps the field at 0 and
    /// the bytes are zeros.
    tls_init_size: usize,
    /// Address-of-global initializers seen at file scope:
    /// `int *p = &x;`. Each entry says "the 8 bytes at
    /// `data_offset` in the data segment must contain the
    /// runtime address of `target_offset` in the same
    /// segment." Threaded through to `Program::data_relocs`;
    /// the per-format writer materializes the relocation as
    /// either an absolute write (ELF / ET_EXEC), a Mach-O
    /// rebase opcode, or a PE `.reloc` entry.
    data_relocs: Vec<crate::c5::program::DataReloc>,
    /// Function-pointer relocations for static initializers like
    /// `static const VTable v = { .xClose = my_close };`. Each
    /// entry is the byte offset in `data` of an 8-byte slot plus
    /// the bytecode PC of the function to point at; the per-format
    /// writers patch the slot to the real code address at write or
    /// load time. The VM reads the slot directly because c5
    /// function pointers carry the small `CODE_BASE + bc_pc` bias
    /// and `Op::Jsri` recognises that range.
    code_relocs: Vec<crate::c5::program::CodeReloc>,
    /// Names from `#pragma export(<name>)` directives, in
    /// declaration order. Validated at the end of
    /// [`Self::run_compile`] -- each must resolve to a
    /// `Token::Fun` symbol -- and copied onto
    /// `Program::exports` together with the function's
    /// bytecode PC. Empty for executables that don't reach
    /// for the directive.
    pending_exports: Vec<String>,
    /// Per-libc-call FP-argument bitmaps. Filled when emitting an
    /// `Op::JsrExt` whose argument list contains at least one
    /// floating-point operand; the codegen reads it back to route
    /// those args through the platform's FP-arg registers. Empty
    /// for the all-integer case, which is most calls.
    call_fp_arg_masks: Vec<(usize, u32)>,

    /// Return type of the function whose body is currently being
    /// parsed (0 outside any function). Used by the `return s`
    /// path to emit a struct-copy through the hidden out-pointer
    /// when the function's declared return type is a struct
    /// value -- the caller pre-allocates a result temp and passes
    /// its address at param val=2; struct-returning callees treat
    /// declared params as starting at val=3.
    current_func_return_ty: i64,

    /// Preprocessor failure (e.g. unterminated `#if`) deferred from
    /// `with_target` until `compile` runs, so the construction API
    /// stays infallible (matches all the `Compiler::new(src).compile()`
    /// callers in tests / examples). `None` if preprocessing
    /// succeeded.
    deferred_error: Option<C5Error>,

    /// Dylibs + bindings the preprocessor extracted from the
    /// per-target header. Threaded onto `Program` so `emit_native`
    /// can drive its import table from this list rather than the
    /// codegen's hardcoded knowledge of which libc symbols live
    /// where.
    dylibs: Vec<DylibSpec>,

    /// The native target this compilation is producing for.
    /// Drives data-model picks: `long` is 8 bytes on LP64
    /// (Linux / macOS) and 4 bytes on LLP64 (Windows). Stored
    /// here so per-`ty` helpers (`size_of_type`, `align_of_type`,
    /// `load_op_for`, `store_op_for`) can pick the right width
    /// without threading the target through every call site.
    target: Target,

    /// Side channel from `parse_declarator` to `run_compile`: when
    /// the declarator's nested-paren branch encounters a "function
    /// returning function pointer" shape (`T (*name(args1))(args2)`),
    /// it parses `args1` via `parse_function_params` and stashes
    /// them here so the caller can bind `name` as a function and
    /// continue with the body. `args2` is consumed as a no-op via
    /// the trailing-decoration loop. None when the declarator
    /// wasn't this shape.
    pending_fn_params: Option<ParsedParams>,

    /// Side channel from `parse_declarator` to its caller: when
    /// the declarator was function-pointer-shaped, this is the
    /// number of pointer levels between the resulting variable's
    /// loaded value and the underlying fn-pointer rvalue, plus 1
    /// (matching `Symbol::fn_ptr_indirection`'s convention).
    /// `None` when the declarator wasn't fn-pointer-shaped, so
    /// the caller doesn't have to clear a stale value before
    /// each parse. The caller takes() the value when binding the
    /// symbol.
    pending_fn_ptr_indirection: Option<i64>,

    /// Override stride for the next `[i]` postfix index. When we
    /// load the address of a 2D-array variable (`T xs[N][M]`),
    /// the first subscript should scale the index by
    /// `M * sizeof(T)`, not `sizeof(T)`. The expr() identifier
    /// branch sets this to `inner_array_size * sizeof(elem)` on a
    /// 2D-array decay; the Brak postfix handler reads-and-clears
    /// it before falling back to the regular pointer-arithmetic
    /// stride. Zero means "use the regular stride."
    pending_index_stride: i64,

    /// Strides for the *remaining* subscript levels of an N-dim
    /// array (N >= 3), beyond the first one held in
    /// `pending_index_stride`. For `T xs[A][B][C]` after the
    /// `xs` decay the levels are: first = `B*C*sizeof(T)`
    /// (in `pending_index_stride`), then `C*sizeof(T)` (in this
    /// vec), then the regular `sizeof(T)` fall-through. Each
    /// Brak postfix consumes one stride and shifts the rest
    /// down. Empty means "no further multi-dim strides queued."
    pending_index_strides_tail: Vec<i64>,

    /// Snapshot of the multi-dim stride queue taken at the bottom
    /// of every `expr()` -- just before the defensive clear
    /// runs. Lets an outer operator that ran a recursive `expr()`
    /// (notably unary `*` on a pointer-to-array operand)
    /// recover what the inner parse seeded but nothing
    /// consumed. Reset to zero on the next `expr()` exit, so
    /// the inspector window is one operator deep.
    end_of_expr_stride: i64,
    end_of_expr_strides_tail: Vec<i64>,

    /// Per-row element count for the next 2D-array initializer.
    /// Set by callers of `collect_array_initializer` when the
    /// declarator has a `[N][M]` shape so a nested `{ ... }`
    /// row that lists fewer than M values can be zero-padded to
    /// keep subsequent rows on the right stride. Zero means
    /// "flatten without padding" (1D arrays, struct-array
    /// initializers that own their layout). The collector
    /// reads-and-clears this on entry.
    pending_init_inner_dim: i64,

    /// Set whenever the most recent `expr()` step ended with an
    /// array-decay-to-pointer (a bare array variable, or a
    /// struct field whose declared shape is `T xs[N]`). Carries
    /// the array's element count so `sizeof(<expr>)` can return
    /// `array_size * sizeof(elem)` instead of the decayed
    /// pointer's `sizeof(T*) = 8`. Cleared at the top of every
    /// `expr()` call so a previous decay doesn't leak into an
    /// unrelated sizeof.
    last_array_decay_size: i64,

    /// Companion to `last_array_decay_size` for cases where the
    /// row's byte size is known directly but its shape can't be
    /// reduced to a single `count * sizeof(elem_ty)` pair --
    /// concretely, multi-dim subscripts of a pointer-to-array
    /// like `T (*p)[A][B]; sizeof(p[0])`. The Brak postfix
    /// handler stashes the consumed `multi_dim_stride` here so
    /// `sizeof` can return the whole row size. Cleared the same
    /// way as `last_array_decay_size` so it doesn't leak.
    last_array_decay_bytes: i64,

    /// Depth from the value currently in the accumulator down to
    /// a function-pointer rvalue, or -1 if the running expression
    /// has no function-pointer lineage. Concretely:
    ///
    ///   * 0  -- value IS a fn pointer; one more unary `*` is the
    ///           C function-pointer-decay no-op.
    ///   * N>0 -- N more derefs to reach the fn pointer.
    ///   * -1 -- not in a fn-ptr-tracked chain; existing behavior.
    ///
    /// Seeded by the identifier-load path from
    /// `Symbol::fn_ptr_indirection` and updated by unary `*` /
    /// `&`. Cleared by `emit_op` so any unrelated emit
    /// invalidates the trace; identifier loads and `*` re-set it
    /// when applicable. Used to suppress the spurious `Li` that
    /// the existing unary `*` handler would emit when chasing a
    /// function pointer whose return type is itself a pointer
    /// (so the post-`*` type still satisfies `is_pointer_ty` and
    /// the call-site fallback can't fire).
    fn_ptr_chain_depth: i64,

    /// Per-bytecode-PC source line, parallel to `text`. Updated
    /// on every emit_op / emit_val / emit_data_imm so each
    /// emitted word carries the line number of the C statement
    /// it came from. The codegen surfaces this through
    /// `--dump-asm` and the runtime crash reporter.
    source_lines: Vec<u32>,
    /// Per-bytecode-PC current function name, parallel to
    /// `text`. Empty string for top-level emit (data
    /// initializers, file-scope decls).
    source_functions: Vec<String>,
    /// File-name table. Index 0 is the user's translation unit;
    /// every distinct filename observed via the lexer's
    /// `(file, line)` state (i.e. crossing a GNU line marker on
    /// `#include` enter / a `#line N "file"` directive) gets
    /// a fresh entry. The DWARF emitter writes one
    /// `DW_LNE_define_file` per entry and switches with
    /// `DW_LNS_set_file` when `source_file_indices` changes.
    source_files: Vec<String>,
    /// Per-bytecode-PC index into `source_files`, parallel to
    /// `source_lines`. The two columns together pin a PC to a
    /// specific (file, line). Without this column lldb would
    /// claim every PC came from the user's translation unit even
    /// when it actually originated inside a header.
    source_file_indices: Vec<u16>,
    /// Per-function locals + parameters captured at body close,
    /// before the c5 shadow-symbol restore unwinds the binding.
    /// The DWARF emitter walks this list to attach
    /// `DW_TAG_variable` / `DW_TAG_formal_parameter` DIEs to the
    /// matching subprogram, which lets lldb's `frame variable` and
    /// `watchpoint set variable foo` work for c5-emitted code.
    variables: Vec<crate::c5::program::VariableInfo>,
    /// Name of the C function whose body is currently being
    /// emitted. Set on `Op::Ent` emit and cleared on `Op::Lev`.
    current_function_name: String,
    /// Forward-call backpatch list. Each entry pairs a `Jsr`
    /// operand's text position with the symbol it called. The
    /// emit site stores `0` as a placeholder when the callee
    /// hasn't seen its body yet (`Symbol::val == 0`); when the
    /// body finally lands and `val` updates to the new `ent_pc`,
    /// we walk this list and rewrite the placeholders. Without
    /// this fixup pass any code that calls a function declared
    /// in a header but defined further down jumps to PC 0 --
    /// the binary's `main` entry -- and recurses into garbage.
    fn_call_fixups: Vec<(usize, usize)>,
    /// Parallel symbol index for each entry in `code_relocs`.
    /// `parse_constant_init_value` records a CodeReloc with the
    /// callee's `Symbol::val` at parse time -- which is `0` for
    /// any function whose body hasn't been emitted yet (e.g. a
    /// dispatch table that names every callback before any
    /// callback's body lands). The `apply_fn_call_fixups` pass
    /// uses this index to rewrite each CodeReloc's
    /// `target_bc_pc` and the matching data-segment bytes once
    /// every body has been parsed.
    code_reloc_sym_idx: Vec<usize>,
    /// Per-libc-symbol trampoline registry. When source code
    /// reaches for the *address* of a `Token::Sys` binding --
    /// either bare (`fp = lstat;`) or in a static initializer
    /// (a function-pointer dispatch table referencing libc) --
    /// c5 has no compile-time
    /// libc address to fold in. Instead we synthesize a tiny
    /// c5 function that re-pushes its parameters and re-dispatches
    /// through `Op::JsrExt`. Each entry maps `sys_sym_idx` to a
    /// fresh synthetic-symbol idx whose `.val` carries the
    /// trampoline's `bc_pc`; the existing `apply_fn_call_fixups`
    /// machinery then patches every recorded data slot or
    /// `Imm` operand to `CODE_BASE + bc_pc`. Trampolines are
    /// emitted in [`Self::emit_sys_trampolines`] after every
    /// real function body lands so they never split a caller
    /// mid-emission.
    sys_trampoline_sym: alloc::collections::BTreeMap<usize, usize>,
}

impl Compiler {
    /// Construct a compiler for the default target (the host).
    /// Equivalent to `Compiler::with_target(source,
    /// Target::default_target())`. Most tests reach for this; the
    /// CLI uses the explicit-target form so `--target=` flows
    /// through to the codegen.
    pub fn new(source: String) -> Self {
        Self::with_target(source, Target::default_target())
    }

    /// Construct a compiler for a specific native target. Runs the
    /// preprocessor (with the target predefines: `__APPLE__` /
    /// `__linux__` / `_WIN32`, plus arch macros) over `source`, then
    /// feeds the substituted text to the lexer. The target choice
    /// drives the predefines -- `#include`d headers (`<stdio.h>`,
    /// `<string.h>`, ...) gate their `#pragma binding(...)` blocks
    /// off them so the right libc / libSystem / msvcrt symbols get
    /// bound for this target.
    pub fn with_target(source: String, target: Target) -> Self {
        Self::with_options(source, target, &[], &[])
    }

    /// Drain the gcc `-H`-shape include trace produced by the
    /// preprocessor. Empty when constructed without
    /// `with_full_options_and_label_with_trace(.., show_includes =
    /// true)`. The CLI calls this after `compile()` and dumps the
    /// list to stderr; library callers can do the same.
    pub fn take_include_trace(&mut self) -> Vec<String> {
        core::mem::take(&mut self.include_trace)
    }

    /// Construct a compiler with explicit `-D` / `-U` predefines
    /// from the CLI driver. Each `defines` entry is a
    /// `(name, body)` pair installed before the source runs through
    /// the preprocessor; `undefines` lists names to remove from
    /// the predefines table. Source-level `#define` / `#undef`
    /// still win the last-writer fight in the normal way.
    pub fn with_options(
        source: String,
        target: Target,
        defines: &[(String, String)],
        undefines: &[String],
    ) -> Self {
        Self::with_full_options(source, target, defines, undefines, &[], &[])
    }

    /// Same as [`Self::with_options`] but also takes a list of
    /// filesystem search paths probed before the bundled in-binary
    /// headers on `#include`, plus a list of headers to force-
    /// include before the source. Plumbed in from the CLI's
    /// `-I path` flag (auto-detected defaults `./include`,
    /// `./headers/include`) and `-include FILE` flag.
    pub fn with_full_options(
        source: String,
        target: Target,
        defines: &[(String, String)],
        undefines: &[String],
        include_paths: &[String],
        force_includes: &[String],
    ) -> Self {
        Self::with_full_options_and_label(
            source,
            target,
            defines,
            undefines,
            include_paths,
            force_includes,
            "",
        )
    }

    /// Same as [`Self::with_full_options`] plus a `source_label`
    /// argument: the filename string used in compiler diagnostics
    /// (`<file>:<line>: error: ...`) and the lexer's per-token file
    /// attribution. The CLI passes the user's argv path so error
    /// messages name the file the user opened; library / fixture
    /// callers that don't have a path leave it empty and the
    /// preprocessor falls back to the historical `<source>`
    /// placeholder.
    pub fn with_full_options_and_label(
        source: String,
        target: Target,
        defines: &[(String, String)],
        undefines: &[String],
        include_paths: &[String],
        force_includes: &[String],
        source_label: &str,
    ) -> Self {
        Self::with_full_options_and_label_with_trace(
            source,
            target,
            defines,
            undefines,
            include_paths,
            force_includes,
            source_label,
            false,
        )
    }

    /// Variant of [`Self::with_full_options_and_label`] that also
    /// flips on the gcc `-H`-shape include trace. The preprocessor
    /// pushes one line per `#include` resolve into a `Vec<String>`
    /// available via [`Self::take_include_trace`] after construction.
    /// Wired in by the CLI's `-H` / `--show-includes` flag; library
    /// callers that don't want tracing keep the flag at `false` and
    /// the trace stays empty.
    //
    // Long arg list reflects the family of `with_*` constructors
    // the CLI grew alongside the preprocessor surface (predefines,
    // search paths, force-includes, label, trace). A future
    // refactor will collapse the lot into a single `CompileOptions`
    // struct -- new flags should land there rather than here.
    #[allow(clippy::too_many_arguments)]
    pub fn with_full_options_and_label_with_trace(
        source: String,
        target: Target,
        defines: &[(String, String)],
        undefines: &[String],
        include_paths: &[String],
        force_includes: &[String],
        source_label: &str,
        show_includes: bool,
    ) -> Self {
        // Run the preprocessor first so we know the
        // `#pragma binding(...)` set before seeding the symbol
        // table. The bindings come from whichever standard headers
        // the source `#include`s (or doesn't); a fixture that needs
        // `printf` but skips `<stdio.h>` will fail with a clear
        // "no `#pragma binding(... ::printf, ...)` is in scope"
        // error out of the codegen's import resolver, not a
        // mysterious link-time mismatch.
        //
        // Preprocessor failures (unterminated `#if`, duplicate
        // `#else`, ...) are stored on the struct and surfaced when
        // `compile()` runs -- this keeps the construction API
        // infallible so the `Compiler::new(src).compile()` shape
        // every existing caller uses keeps working.
        let mut pp = Preprocessor::new(target.id_str(), target, env!("CARGO_PKG_VERSION"));
        pp.set_source_label(source_label);
        pp.set_show_includes(show_includes);
        for path in include_paths {
            pp.add_search_path(path);
        }
        for name in force_includes {
            pp.add_force_include(name);
        }
        for (name, body) in defines {
            pp.define(name, body);
        }
        for name in undefines {
            pp.undef(name);
        }
        let (preprocessed, deferred_error) = match pp.process(&source) {
            Ok(s) => (s, None),
            Err(e) => (String::new(), Some(e)),
        };
        // Debug knob: when BADC_DUMP_PP is set, write the post-
        // preprocessor source to /tmp/badc-pp.c so a developer
        // chasing a parser failure can inspect the exact token
        // stream the lexer is about to see. Uses std::env so it
        // only fires under the std feature; no_std builds skip it.
        #[cfg(feature = "std")]
        if std::env::var("BADC_DUMP_PP").is_ok() {
            let _ = std::fs::write("/tmp/badc-pp.c", &preprocessed);
        }
        let dylibs = pp.dylibs;
        let pending_exports = pp.exports;
        // Drain the preprocessor's diagnostic list -- missing-include
        // and unknown-directive warnings ride the same Program.warnings
        // pipeline as the parser's type-warning output, so a build
        // driver sees one unified list.
        let pp_warnings = pp.warnings;
        let pp_include_trace = pp.include_trace;
        let pp_entrypoint = pp.entrypoint;
        let pp_subsystem = pp.subsystem;
        let pp_intrinsics = pp.intrinsics;

        let mut symbols = Vec::new();
        let mut symbol_index = lexer::SymbolIndex::new();
        lexer::init_symbols(&mut symbols, &mut symbol_index, &dylibs);

        // Reserve the first 8 bytes of `.data` so no symbol's
        // offset is zero. The c5 dialect models pointers as
        // raw data offsets (no per-segment base in the VM, and
        // `data_vmaddr` is the base on native targets), so a
        // global at offset 0 would be indistinguishable from
        // the integer literal `0` -- which c5 uses for NULL.
        // Reserving the first 8 bytes pushes every actual
        // global / string literal to offset >= 8, preserving
        // the `pointer != 0 <=> non-NULL` invariant that
        // `int *p = &x; if (p == 0) ...` style code expects.
        // Native binaries are unaffected (the bytes are just
        // an unused prefix in `.data`); the VM's address space
        // gains 8 bytes of reserved padding at offset 0.
        let data: Vec<u8> = alloc::vec![0u8; 8];

        Self {
            lex: Lexer::new(preprocessed),
            symbols,
            symbol_index,
            deferred_error,
            dylibs,
            target,
            text: Vec::new(),
            data,
            ty: 0,
            loc_offs: 0,
            max_loc_offs: 0,
            uses_alloca_in_current_fn: false,
            alloca_init_operand_pc: 0,
            loop_breaks: Vec::new(),
            loop_continues: Vec::new(),
            labels: Vec::new(),
            unresolved_gotos: Vec::new(),
            switch_cases: Vec::new(),
            switch_defaults: Vec::new(),
            structs: Vec::new(),
            warnings: pp_warnings,
            include_trace: pp_include_trace,
            pp_entrypoint,
            pp_subsystem,
            pp_intrinsics,
            data_imm_positions: Vec::new(),
            code_imm_positions: Vec::new(),
            tls_data: Vec::new(),
            tls_init_size: 0,
            data_relocs: Vec::new(),
            code_relocs: Vec::new(),
            pending_exports,
            call_fp_arg_masks: Vec::new(),
            current_func_return_ty: 0,
            pending_fn_params: None,
            pending_fn_ptr_indirection: None,
            pending_index_stride: 0,
            pending_index_strides_tail: Vec::new(),
            end_of_expr_stride: 0,
            end_of_expr_strides_tail: Vec::new(),
            pending_init_inner_dim: 0,
            source_lines: Vec::new(),
            source_functions: Vec::new(),
            source_files: Vec::new(),
            source_file_indices: Vec::new(),
            variables: Vec::new(),
            current_function_name: String::new(),
            fn_call_fixups: Vec::new(),
            code_reloc_sym_idx: Vec::new(),
            sys_trampoline_sym: alloc::collections::BTreeMap::new(),
            last_array_decay_size: 0,
            last_array_decay_bytes: 0,
            fn_ptr_chain_depth: -1,
        }
    }

    /// Append a type-checking / signature-mismatch warning. We never
    /// fail compilation on these -- the codegen has enough info to
    /// keep going, and refusing every type squabble would be hostile
    /// to amalgamated code that almost-but-not-quite agrees with
    /// itself. Callers grab the list off `Program.warnings` after
    /// `compile()`.
    ///
    /// The output shape mirrors gcc / clang:
    ///   `<file>:<line>: warning: <message>`
    /// so jump-to-error in editors works out of the box, and the CLI
    /// can color the `warning:` word when stderr is a TTY.
    fn warn_at(&mut self, line: usize, message: alloc::string::String) {
        let file = &self.lex.file;
        self.warnings
            .push(alloc::format!("{file}:{line}: warning: {message}"));
    }

    /// Build a `C5Error::Compile` whose message follows the
    /// gcc / clang-shape convention everything else in this codebase
    /// uses for diagnostics:
    ///   `<file>:<line>: error: <message>`
    /// Pulls `<file>` / `<line>` out of `self.lex` so call sites
    /// don't have to thread them through every `format!`.
    fn compile_err(&self, message: impl AsRef<str>) -> super::error::C5Error {
        super::error::C5Error::Compile(super::error::fmt_compile_err(
            &self.lex.file,
            self.lex.line,
            message.as_ref(),
        ))
    }

    /// Same shape as [`Self::compile_err`] but lets the caller pin
    /// the line to a value that isn't the lexer's current one --
    /// useful when a diagnostic refers back to where a structure /
    /// function / argument *started*, not where the parser noticed
    /// the problem.
    fn compile_err_at(&self, line: usize, message: impl AsRef<str>) -> super::error::C5Error {
        super::error::C5Error::Compile(super::error::fmt_compile_err(
            &self.lex.file,
            line,
            message.as_ref(),
        ))
    }

    /// Test whether `actual` is assignable / passable where `declared`
    /// is expected. Returns a human-readable warning string when they
    /// don't match under badc's rules; `None` when they do.
    ///
    /// Compatibility is intentionally lax -- c4 itself does no checking,
    /// so jumping straight to ISO-C strictness would drown the suite.
    /// What we *do* catch:
    ///   * pointer <-> non-zero scalar (one side a pointer, the other an
    ///     integer that isn't a literal 0)
    ///   * struct of different concrete types
    ///   * struct value vs anything non-struct
    ///
    /// What we deliberately *don't* catch (yet):
    ///   * pointer base mismatch (`int*` <-> `char*`); both pointers, both
    ///     fit in a register, common in c5 idioms
    ///   * char <-> int width difference; c convention
    ///
    /// `actual_is_zero_literal` is a hint from the caller -- when an
    /// expression compiles to exactly `Imm 0`, treat the value as the
    /// NULL pointer for the purposes of this check.
    fn type_warning(
        declared: i64,
        actual: i64,
        actual_is_zero_literal: bool,
    ) -> Option<&'static str> {
        Self::type_warning_with_flags(declared, actual, actual_is_zero_literal, false)
    }

    /// Like [`type_warning`] but with an extra `actual_is_untyped_call`
    /// flag. When set, the actual rvalue came from an `Op::Jsri`
    /// indirect call whose return type the dialect can't track --
    /// silence pointer-vs-int mismatches in either direction since
    /// the register value is preserved bit-for-bit at the assignment
    /// store regardless of the tag.
    fn type_warning_with_flags(
        declared: i64,
        actual: i64,
        actual_is_zero_literal: bool,
        actual_is_untyped_call: bool,
    ) -> Option<&'static str> {
        if declared == actual {
            return None;
        }
        if actual_is_untyped_call {
            // Indirect call's defaulted return type. `Op::Jsri`
            // leaves the full 64-bit register value intact, so
            // pointer-vs-int doesn't truncate anything in
            // practice. Quiet either direction.
            let decl_is_ptr = is_pointer_ty(declared);
            let act_is_ptr = is_pointer_ty(actual);
            if (decl_is_ptr && !act_is_ptr) || (!decl_is_ptr && act_is_ptr) {
                return None;
            }
            // Also accept struct-pointer <-> int the same way.
            if is_struct_ty(declared) && struct_ptr_depth(declared) > 0 && !act_is_ptr {
                return None;
            }
        }
        let decl_is_struct = is_struct_ty(declared);
        let act_is_struct = is_struct_ty(actual);
        let decl_is_ptr = is_pointer_ty(declared);
        let act_is_ptr = is_pointer_ty(actual);

        // C's `void *` rule: a pointer to `char` (which c5 uses as
        // its `void *`) is freely interconvertible with any other
        // pointer type. The dialect's headers declare libc functions
        // like `memset(char *, int, int)` and `malloc -> char *`;
        // real-world C routinely passes struct pointers to memset
        // and assigns malloc's result to struct* variables. Without
        // this rule every such site fires "incompatible struct
        // types" / "pointer assigned to integer" noise.
        let char_ptr = (Ty::Char as i64) + (Ty::Ptr as i64);
        // Strip UNSIGNED_BIT before comparing: `char *` (which c5
        // treats as unsigned), `signed char *`, and `unsigned char *`
        // are all interchangeable here -- the compatibility rule
        // is "is this any kind of byte pointer?", not "do the
        // signedness tags line up".
        let decl_is_char_ptr = decl_is_ptr && (declared & !UNSIGNED_BIT) == char_ptr;
        let act_is_char_ptr = act_is_ptr && (actual & !UNSIGNED_BIT) == char_ptr;
        if decl_is_char_ptr && act_is_ptr {
            return None;
        }
        if act_is_char_ptr && decl_is_ptr {
            return None;
        }

        // Struct types must match exactly (when one side is a struct).
        if decl_is_struct || act_is_struct {
            // Already returned None above when declared == actual; if we
            // reach here, the struct sides differ. But allow struct
            // pointer vs untyped 0 (NULL).
            if (decl_is_ptr && actual_is_zero_literal) || (act_is_ptr && declared == 0) {
                return None;
            }
            return Some("incompatible struct types");
        }

        match (decl_is_ptr, act_is_ptr) {
            // Both pointers (any base/depth) -- fine.
            (true, true) => None,
            // Pointer <-> literal 0: NULL idiom.
            (true, false) if actual_is_zero_literal => None,
            // Pointer <-> non-zero integer: warn.
            (true, false) => Some("integer assigned to pointer"),
            (false, true) => Some("pointer assigned to integer"),
            // Both numeric (char vs int) -- c convention, silent.
            (false, false) => None,
        }
    }

    /// Reconcile mixed int/float operands for an arithmetic /
    /// comparison op so the matching `Op::Fxxx` can run. Two
    /// shapes need bytecode work:
    ///   * LHS float, RHS int: RHS is in `a`; emit `Op::Fcvtif`
    ///     in place to lift it to f64.
    ///   * LHS int, RHS float: LHS is on the c5 stack and `a`
    ///     holds the float RHS. Spill RHS to a temp via
    ///     `Op::StLocI`, recover LHS into `a` with `Imm 0; Or`
    ///     (Or pops the stack into `a`), lift LHS via Fcvtif,
    ///     push, then reload RHS into `a`. Net effect mirrors
    ///     the float-float pattern.
    ///
    /// Returns `Ok(())` for both-float and both-int cases (no
    /// emit). The caller's `is_floating_scalar(t) ||
    /// is_floating_scalar(self.ty)` gate decides whether to use
    /// the FP op afterwards; on return `self.ty` is the lifted
    /// RHS's type when a lift happened.
    fn require_both_float(&mut self, lhs: i64, _op: &str) -> Result<(), C5Error> {
        let lhs_is_fp = is_floating_scalar(lhs);
        let rhs_is_fp = is_floating_scalar(self.ty);
        if lhs_is_fp == rhs_is_fp {
            return Ok(());
        }
        if lhs_is_fp && !rhs_is_fp {
            self.emit_op(Op::Fcvtif);
            self.ty = lhs;
            return Ok(());
        }
        // !lhs_is_fp && rhs_is_fp -- spill float RHS, lift int LHS.
        self.loc_offs += 1;
        if self.loc_offs > self.max_loc_offs {
            self.max_loc_offs = self.loc_offs;
        }
        let rhs_temp = -self.loc_offs;
        let rhs_ty = self.ty;
        self.emit_op(Op::StLocI);
        self.emit_val(rhs_temp);
        // Pop LHS off the c5 stack into `a` via Imm 0; Or.
        self.emit_imm(0);
        self.emit_op(Op::Or);
        self.emit_op(Op::Fcvtif);
        self.emit_op(Op::Psh);
        // Reload RHS into `a`.
        self.emit_lea(rhs_temp);
        self.emit_op(Op::Li);
        self.ty = rhs_ty;
        Ok(())
    }

    /// Apply the C99 6.5.16.1p2 assignment conversion: when the
    /// destination is a floating type and `a` holds an integer-
    /// typed value, lift via `Op::Fcvtif`; when the destination
    /// is an integer / pointer and `a` holds a float / double,
    /// drop via `Op::Fcvtfi`. Same-class assignments leave the
    /// bit pattern alone. Called from every scalar store path
    /// so an `unsigned char` initializer of a `float` local /
    /// global / struct field round-trips through the IEEE-754
    /// representation rather than the raw integer bit pattern.
    pub(super) fn convert_assign_rhs(&mut self, dest_ty: i64) {
        let dest_is_fp = is_floating_scalar(dest_ty);
        let src_is_fp = is_floating_scalar(self.ty);
        if dest_is_fp && !src_is_fp && !is_pointer_ty(self.ty) {
            self.emit_op(Op::Fcvtif);
            self.ty = dest_ty;
        } else if !dest_is_fp && src_is_fp && !is_pointer_ty(dest_ty) {
            self.emit_op(Op::Fcvtfi);
            self.ty = dest_ty;
        }
    }

    /// True when the most recently emitted instruction is `Imm 0` --
    /// i.e. the expression that just finished compiling was the literal
    /// `0`. Used by [`Compiler::type_warning`] to suppress the NULL
    /// idiom warning on `pointer = 0`.
    fn last_emit_is_zero(&self) -> bool {
        let n = self.text.len();
        n >= 2 && self.text[n - 1] == 0 && self.text[n - 2] == Op::Imm as i64
    }

    /// True if the most recent emitted op is `Op::Jsri` -- an indirect
    /// call through a variable / struct field whose return type the
    /// dialect can't track. Used by `type_warning` to silently accept
    /// an `int`-tagged rvalue assigned to a pointer lvalue (or vice
    /// versa): the actual register value carries a full 8-byte return
    /// regardless, so the assignment is a runtime no-op even though
    /// the type tag mismatches. The walker tolerates a trailing
    /// `Op::Adj N` (cleanup of pushed args) since that's the standard
    /// Jsri tail.
    fn last_emit_was_indirect_call(&self) -> bool {
        let n = self.text.len();
        if n >= 1 && self.text[n - 1] == Op::Jsri as i64 {
            return true;
        }
        // Jsri + Adj N: 3 trailing words.
        n >= 3 && self.text[n - 2] == Op::Adj as i64 && self.text[n - 3] == Op::Jsri as i64
    }

    /// Element size in bytes for a pointer type. Pointer-to-struct
    /// looks up the struct's real size; everything else falls back
    /// to the static [`pointee_size_no_struct`] (1 for `char*`, 8
    /// for any other pointer level), with one target-dependent
    /// override: `long *` is 4 bytes on LLP64 (Windows) and 8
    /// bytes on LP64 (Linux / macOS).
    fn pointee_size(&self, ptr_ty: i64) -> i64 {
        if is_struct_ty(ptr_ty) && struct_ptr_depth(ptr_ty) == 1 {
            // Single-level pointer-to-struct: the pointee is the
            // struct value, whose size lives in the struct table.
            return self.structs[struct_id_of(ptr_ty)].size as i64;
        }
        let stripped = ptr_ty & !UNSIGNED_BIT;
        if stripped == (Ty::Long as i64) + (Ty::Ptr as i64) && self.target.is_windows() {
            return 4;
        }
        pointee_size_no_struct(ptr_ty)
    }

    /// True if pointer arithmetic on `ptr_ty` scales the offset by
    /// the pointee's byte size. False only for `char*` (one byte
    /// per element, no scaling). Replaces the old fixed-8 check
    /// which got struct-pointer scaling wrong.
    fn is_ptr_scaling_nontrivial(&self, ptr_ty: i64) -> bool {
        is_pointer_ty(ptr_ty) && self.pointee_size(ptr_ty) > 1
    }

    /// Step size used by `++` / `--` on a value of `ty`: the
    /// pointee size for a pointer (so `p++` advances by exactly
    /// `sizeof(*p)`), or `1` for any non-pointer scalar.
    fn pointee_step(&self, ty: i64) -> i64 {
        if is_pointer_ty(ty) {
            self.pointee_size(ty)
        } else {
            1
        }
    }

    /// Linear lookup of a struct by its tag name. Returns the id used in
    /// `struct_ty_for(id)` and as an index into `self.structs`.
    fn find_struct_id(&self, name: &str) -> Option<usize> {
        self.structs.iter().position(|s| s.name == name)
    }

    /// Find an existing struct tag by name or register a fresh
    /// forward declaration (size 0, no fields) and return that.
    /// Used by every type-position that mentions `struct Foo`
    /// before the struct's body has been seen -- common idioms
    /// like `typedef struct Foo Foo;` and `struct Foo *p;` rely
    /// on this.
    fn find_or_forward_declare_struct(&mut self, name: &str) -> usize {
        if let Some(id) = self.find_struct_id(name) {
            return id;
        }
        self.structs.push(StructDef {
            name: name.to_string(),
            size: 0,
            align: 1,
            fields: Vec::new(),
            is_union: false,
        });
        self.structs.len() - 1
    }

    /// True when the current lexer position starts a type. The free
    /// function `is_type_start_token` covers the keyword tokens
    /// (`int`, `char`, `const`, ...); this method extends it by
    /// recognising any identifier whose symbol carries
    /// `class == Token::Typedef` -- shapes like
    /// `typedef struct X X; X *p;` would otherwise misparse as
    /// `Int p;`.
    fn lex_is_type_start(&self) -> bool {
        is_type_start_token(self.lex.tk) || self.is_lex_typedef_name()
    }

    /// True when the current lexer token is an identifier bound to a
    /// typedef. A separate predicate so callers that want only the
    /// typedef case (e.g. `parse_decl_base_type`) can check without
    /// also matching keyword type-starts.
    fn is_lex_typedef_name(&self) -> bool {
        self.lex.tk == Token::Id
            && self.symbols[self.lex.curr_id_idx].class == Token::Typedef as i64
    }

    /// Size in bytes of a value of the given `ty`.
    ///   * pointers (any base type)  -> 8
    ///   * scalar `char`             -> 1
    ///   * scalar `int`              -> 4 (32-bit signed)
    ///   * scalar `long`             -> 8
    ///   * scalar `float` / `double` -> 8 (c5 stores every FP value
    ///     through an 8-byte slot; IEEE 754 single-precision
    ///     narrowing is future work)
    ///   * struct values             -> recorded in the struct table
    fn size_of_type(&self, ty: i64) -> usize {
        // Unsigned bit is orthogonal to width: `unsigned char` is
        // still 1 byte, `unsigned int` is still 4 bytes. Strip it
        // before consulting the band identity.
        let ty = ty & !UNSIGNED_BIT;
        if is_struct_ty(ty) {
            if struct_ptr_depth(ty) > 0 {
                8
            } else {
                self.structs[struct_id_of(ty)].size
            }
        } else if ty == Ty::Char as i64 {
            1
        } else if ty == Ty::Void as i64 {
            // C99 6.5.3.4 forbids `sizeof(void)`. Returning 0
            // here means a stray `sizeof((void)expr)` produces
            // a 0 -- a constraint-violation diagnostic at the
            // call site is the proper fix, but 0 is harmless
            // and matches GCC's `-Wpointer-arith` behavior.
            0
        } else if ty == Ty::Short as i64 {
            2
        } else if ty == Ty::Int as i64 {
            4
        } else if ty == Ty::Long as i64 {
            // Per-target: LP64 (Linux / macOS) -> 8; LLP64
            // (Windows) -> 4. The `long long` spelling stays at
            // 8 bytes everywhere via `Ty::LongLong`.
            if self.target.is_windows() { 4 } else { 8 }
        } else {
            // `long long`, `float`, `double`, all pointers
            // (long long*, long*, int*, char*, short*, float*,
            // ...) -- 8 bytes each.
            8
        }
    }

    /// Natural alignment (in bytes) for a value of the given `ty`.
    /// Mirrors the C alignment rule: the value lives on a boundary
    /// equal to its size for scalars (`char` = 1, `int` = 4,
    /// `long` / pointer = 8). Struct values inherit the max
    /// alignment of their fields, but c5 currently caps struct
    /// alignment at 8 to match the rest of the IR's slot model.
    fn align_of_type(&self, ty: i64) -> usize {
        let ty = ty & !UNSIGNED_BIT;
        if is_struct_ty(ty) {
            if struct_ptr_depth(ty) > 0 {
                8
            } else {
                // Struct alignment = max field alignment, capped at 8.
                // Computed eagerly during layout so we don't have to
                // walk every nested struct on each call.
                self.structs[struct_id_of(ty)].align.max(1)
            }
        } else if ty == Ty::Char as i64 || ty == Ty::Void as i64 {
            // `void` aligns like `char` -- 1-byte. Bare `void`
            // shouldn't appear as a value in practice, but
            // align_of_type is consulted for `void *` field
            // alignment computations in some paths.
            1
        } else if ty == Ty::Short as i64 {
            2
        } else if ty == Ty::Int as i64 {
            4
        } else if ty == Ty::Long as i64 {
            if self.target.is_windows() { 4 } else { 8 }
        } else {
            8
        }
    }

    /// Number of c5 stack slots required to hold a value of `ty`.
    /// Each c5 slot is 8 bytes; struct values may span several. The
    /// existing scalar / pointer paths always return 1, so existing
    /// `loc_offs += 1` patterns map to `loc_offs += slots_of(ty)`
    /// without changing emit semantics.
    fn slots_of_type(&self, ty: i64) -> i64 {
        if is_struct_ty(ty) && struct_ptr_depth(ty) == 0 {
            // Struct fields are 8-byte aligned (see parse_struct_body),
            // so the size is already a multiple of 8 -- the +7 round
            // is defensive in case a future change adds sub-8-byte
            // packing.
            ((self.structs[struct_id_of(ty)].size as i64) + 7) / 8
        } else {
            1
        }
    }

    /// Emit code for accessing a bitfield. On entry `a` holds the
    /// address of the bitfield's 8-byte storage unit. The dispatch
    /// peeks at the next token: if it's `=`, an assignment follows
    /// and we emit a load-clear-shift-or-store sequence; otherwise
    /// we emit a load-shift-and-mask read sequence and let the
    /// surrounding expression continue.
    ///
    /// Self-contained on the c5 stack: read leaves the bitfield's
    /// value in `a` with no net stack change; write leaves the
    /// stored full-word value in `a` (the surrounding expression
    /// rarely uses a bitfield assignment's value, and the
    /// approximation is acceptable for the common case).
    fn emit_bitfield_access(&mut self, bit_offset: u32, bit_width: u32) -> Result<(), C5Error> {
        let mask: i64 = if bit_width >= 64 {
            -1
        } else {
            (1i64 << bit_width) - 1
        };
        if self.lex.tk == Token::Assign {
            // Bitfield write: `s.f = expr`. The c5 stack discipline
            // is delicate here -- we need the storage address
            // available for the final Si, so push it now and reload
            // through indirection later.
            self.next()?; // consume `=`
            // a = field_addr; stack: [...]
            self.emit_op(Op::Psh); // stack: [..., field_addr]; a = field_addr
            self.emit_op(Op::Li); // a = old_value; stack: [..., field_addr]
            self.emit_op(Op::Psh); // stack: [..., field_addr, old_value]
            self.emit_op(Op::Imm);
            self.emit_val(!(mask << bit_offset)); // a = ~(mask << off)
            self.emit_op(Op::And); // a = old_value & ~(mask << off); stack: [..., field_addr]
            self.emit_op(Op::Psh); // stack: [..., field_addr, cleared]
            self.expr(Token::Assign as i64)?; // a = new_value
            self.emit_op(Op::Psh); // stack: [..., field_addr, cleared, new_value]
            self.emit_imm(mask);
            self.emit_op(Op::And); // a = new_value & mask; stack: [..., field_addr, cleared]
            if bit_offset > 0 {
                self.emit_op(Op::Psh);
                self.emit_imm(bit_offset as i64);
                self.emit_op(Op::Shl); // a = (new_value & mask) << bit_offset
            }
            // a = shifted; stack: [..., field_addr, cleared].
            // Op::Or pops cleared, ORs into a. After: a = combined;
            // stack: [..., field_addr]. The trailing Si pops
            // field_addr as the destination.
            self.emit_op(Op::Or);
            self.emit_op(Op::Si); // pops field_addr, stores a (=combined).
            self.ty = Ty::Int as i64;
            Ok(())
        } else {
            // Bitfield read: `s.f` in any non-assignment context.
            self.emit_op(Op::Li); // a = full storage word
            if bit_offset > 0 {
                self.emit_op(Op::Psh);
                self.emit_imm(bit_offset as i64);
                self.emit_op(Op::Shr); // a = (top >> bit_offset)
            }
            self.emit_op(Op::Psh);
            self.emit_imm(mask);
            self.emit_op(Op::And); // a = (...) & mask
            self.ty = Ty::Int as i64;
            Ok(())
        }
    }

    /// Skip tokens until the matching close paren. Caller has
    /// just consumed the opening `(`; on exit, `tk` is one past
    /// the matching `)`. Tracks nested parens and stops when the
    /// outermost `)` is reached. Used by the function-pointer
    /// declarator path to discard parameter type lists c5 doesn't
    /// yet record.
    fn skip_balanced_parens_after_open(&mut self) -> Result<(), C5Error> {
        let mut depth: i64 = 1;
        while depth > 0 && self.lex.tk != 0 {
            if self.lex.tk == '(' {
                depth += 1;
            } else if self.lex.tk == ')' {
                depth -= 1;
                if depth == 0 {
                    self.next()?;
                    return Ok(());
                }
            }
            self.next()?;
        }
        Err(self.compile_err("unmatched parentheses"))
    }

    fn parse_decl_base_type(&mut self) -> Result<i64, C5Error> {
        // Leading qualifiers / modifiers / specifiers. Most are
        // no-ops in c5; the ones that carry semantic weight:
        //   * `IntMod` (`_Bool`): trips the implicit-int rule.
        //   * `Signed`: a `signed char` base loads sign-extending
        //     via `Op::Lcs` (instead of bare-`char`'s zero-ext).
        //   * `Unsigned`: ORs `UNSIGNED_BIT` into the type tag.
        //   * `Short`: selects the 16-bit `Ty::Short` storage class.
        //   * `Long`: first occurrence selects `Ty::Long`. Second
        //     occurrence promotes to `Ty::LongLong` (the C99 / C11
        //     `long long` type, always 64 bits regardless of
        //     target). The first-vs-second distinction matters on
        //     LLP64 (Windows): `long` is 32 bits there, `long long`
        //     stays 64.
        let mut saw_int_mod = false;
        let mut saw_signed = false;
        let mut saw_unsigned = false;
        let mut long_count: u8 = 0;
        let mut saw_short = false;
        while is_decl_modifier(self.lex.tk) {
            if self.lex.tk == Token::IntMod {
                saw_int_mod = true;
            } else if self.lex.tk == Token::Signed {
                saw_signed = true;
                saw_int_mod = true;
            } else if self.lex.tk == Token::Unsigned {
                saw_unsigned = true;
                saw_int_mod = true;
            } else if self.lex.tk == Token::Long {
                long_count = long_count.saturating_add(1);
                saw_int_mod = true;
            } else if self.lex.tk == Token::Short {
                saw_short = true;
                saw_int_mod = true;
            }
            self.next()?;
        }
        let saw_long = long_count >= 1;
        let saw_long_long = long_count >= 2;

        let bt = if self.lex.tk == Token::Int {
            self.next()?;
            // `long long int` -> Ty::LongLong (always 64-bit);
            // `long int` -> Ty::Long (LP64 = 64-bit, LLP64 =
            // 32-bit); `short int` -> Ty::Short (2 bytes);
            // bare `int` -> Ty::Int (4 bytes).
            let base = if saw_long_long {
                Ty::LongLong as i64
            } else if saw_long {
                Ty::Long as i64
            } else if saw_short {
                Ty::Short as i64
            } else {
                Ty::Int as i64
            };
            if saw_unsigned {
                base | UNSIGNED_BIT
            } else {
                base
            }
        } else if self.lex.tk == Token::Void {
            self.next()?;
            // C99 6.2.5: `void` is a distinct type with no values.
            // `void *` is the implicit "any pointer" type per
            // 6.3.2.3; the historical c5 encoding treats it as
            // `Ty::Char | UNSIGNED + Ptr` (so existing void-pointer
            // code keeps working without explicit casts).
            // Peeking past `void` for `*` switches the base to
            // `unsigned char` so the trailing `*`-loop in
            // `parse_declarator` builds the right family;
            // otherwise we return `Ty::Void` so the caller can
            // diagnose value-context uses and zero the
            // accumulator at the matching `Op::Lev`.
            if self.lex.tk == Token::MulOp {
                Ty::Char as i64 | UNSIGNED_BIT
            } else {
                Ty::Void as i64
            }
        } else if self.lex.tk == Token::Char {
            self.next()?;
            // `signed char` is a real 1-byte signed type; loads via
            // `Op::Lcs` so the high bit propagates. Plain `char` is
            // treated as unsigned in c5 (loads via `Op::Lc`,
            // zero-extending), the same as `unsigned char`. The
            // type tag distinguishes the two via `UNSIGNED_BIT`:
            // bare and unsigned char carry it; signed char doesn't.
            if saw_signed {
                Ty::Char as i64
            } else {
                // Both bare `char` and `unsigned char` -- c5 picks
                // the unsigned tag so existing code that loads byte
                // values gets the zero-ext behavior it has always
                // had. The store path is the same (`Op::Sc`).
                Ty::Char as i64 | UNSIGNED_BIT
            }
        } else if self.lex.tk == Token::Float {
            self.next()?;
            Ty::Float as i64
        } else if self.lex.tk == Token::Double {
            self.next()?;
            // `long double` is only as wide as `double` here -- c5
            // has no 80- or 128-bit FP type. The trailing-modifier
            // loop already silently consumes any extra `long`.
            Ty::Double as i64
        } else if self.lex.tk == Token::Enum {
            // `enum [Tag] [{ ... }]` -- in c5 every enum collapses
            // to plain `int`. Consume any tag name and any optional
            // body; return Int as the underlying type.
            self.next()?;
            if self.lex.tk == Token::Id {
                self.next()?;
            }
            if self.lex.tk == '{' {
                // Re-parse the body via the same constants-loop the
                // file-scope path uses. Save and restore the line
                // since parse_enum_decl_body emits no other state.
                self.parse_enum_body()?;
            }
            Ty::Int as i64
        } else if self.lex.tk == Token::Struct || self.lex.tk == Token::Union {
            // Struct and union share the same tag table and the same
            // "find or forward-declare" rule. The aggregate's
            // is_union flag is set when the body lands; until then
            // an opaque tag works for both shapes through pointers
            // and typedefs. Anonymous form (`typedef struct { ... }
            // Name;`) gets a synthesised tag so it can register
            // properly.
            let is_union = self.lex.tk == Token::Union;
            let kind = if is_union { "union" } else { "struct" };
            self.next()?;
            let name = if self.lex.tk == Token::Id {
                let n = self.symbols[self.lex.curr_id_idx].name.clone();
                self.next()?;
                n
            } else if self.lex.tk == '{' {
                format!("__anon_{kind}_{}", self.structs.len())
            } else {
                return Err(self.compile_err(format!("{kind} name or `{{` expected")));
            };
            let id = if self.lex.tk == '{' {
                self.parse_aggregate_body(&name, is_union)?
            } else {
                self.find_or_forward_declare_struct(&name)
            };
            struct_ty_for(id)
        } else if self.is_lex_typedef_name() {
            // Typedef-name as base type. Resolve to the aliased
            // type and consume the identifier.
            let aliased = self.symbols[self.lex.curr_id_idx].type_;
            // Carry the typedef's fn-pointer lineage forward (gh
            // #19) so a later `fn_t fp` declaration ends up with
            // the right indirection count.
            let typedef_fpi = self.symbols[self.lex.curr_id_idx].fn_ptr_indirection;
            if typedef_fpi > 0 {
                self.pending_fn_ptr_indirection = Some(typedef_fpi);
            }
            self.next()?;
            aliased
        } else if saw_int_mod {
            // Bare `unsigned x;` / `long x;` / `long long x;` /
            // `short x;` / `_Bool x;` -- the C implicit-int rule
            // applies for int-modifier-only decls. `long long`
            // selects `Ty::LongLong` (always 64-bit); `long`
            // selects `Ty::Long` (LP64 -> 64-bit, LLP64 ->
            // 32-bit); `short` selects `Ty::Short` (16-bit).
            let base = if saw_long_long {
                Ty::LongLong as i64
            } else if saw_long {
                Ty::Long as i64
            } else if saw_short {
                Ty::Short as i64
            } else {
                Ty::Int as i64
            };
            if saw_unsigned {
                base | UNSIGNED_BIT
            } else {
                base
            }
        } else {
            return Err(self.compile_err("type expected"));
        };

        // Trailing qualifiers / modifiers: `int const`, `int long`,
        // `unsigned int long long`, etc. all collapse to the base type
        // already chosen.
        while is_decl_modifier(self.lex.tk) {
            self.next()?;
        }

        Ok(bt)
    }

    /// Compile the source. On success, the returned `Program` contains the
    /// bytecode, the static data segment, and the PC of `main`.
    /// Resolve every recorded direct-call / function-pointer
    /// reference against its callee's final `val`. Forward
    /// declarations stash `val = 0` (the prototype-time
    /// `text.len()`) at every call site emit; once the body
    /// lands, `val` is rewritten to the body's `ent_pc`. This
    /// pass walks the recorded operand positions and patches
    /// each one in `text`. The bias on bare-function-reference
    /// emits (`CODE_BASE + val`) is detected by reading the op
    /// preceding the operand: `Op::Imm` means a value-context
    /// reference (fp = name) so the operand carries the
    /// `CODE_BASE` bias; otherwise the op is `Op::Jsr` and the
    /// operand is a raw bytecode PC.
    fn apply_fn_call_fixups(&mut self) -> Result<(), C5Error> {
        for &(operand_pc, sym_idx) in &self.fn_call_fixups {
            let target = self.symbols[sym_idx].val;
            let op = self.text[operand_pc - 1];
            if op == Op::Imm as i64 {
                self.text[operand_pc] = CODE_BASE as i64 + target;
            } else {
                self.text[operand_pc] = target;
            }
        }
        // Static-initializer function-pointer entries (vtables /
        // function-pointer struct fields, e.g. dispatch tables of
        // libc callbacks). Each `CodeReloc` was recorded at parse
        // time with the
        // symbol's prototype-time `val` (often 0); the parallel
        // `code_reloc_sym_idx` tracks the originating symbol so
        // we can read its post-body `val` here. We rewrite both
        // the `target_bc_pc` and the matching little-endian
        // bytes in `data` -- both are sourced from the same
        // value at write time, so both must agree post-fixup.
        // The two arrays must be the same length (one symbol idx
        // per code reloc); a length mismatch is a bug in a
        // CodeReloc-emitting site that forgot to record its
        // sym idx.
        if self.code_relocs.len() != self.code_reloc_sym_idx.len() {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!(
                    "code_relocs ({}) and code_reloc_sym_idx ({}) length mismatch \
                 -- a CodeReloc emitter forgot to record its symbol idx",
                    self.code_relocs.len(),
                    self.code_reloc_sym_idx.len()
                ),
            )));
        }
        for (reloc, &sym_idx) in self
            .code_relocs
            .iter_mut()
            .zip(self.code_reloc_sym_idx.iter())
        {
            let new_target = self.symbols[sym_idx].val as u64;
            reloc.target_bc_pc = new_target;
            // Don't rewrite the data bytes -- the VM and per-target
            // writers walk `code_relocs` and lay down their own
            // bias (`CODE_BASE + target_bc_pc` for the VM; native
            // VA for ELF / Mach-O / PE). They read `target_bc_pc`,
            // not the placeholder bytes.
        }
        Ok(())
    }

    /// Look up (or lazily allocate) the synthetic-symbol idx that
    /// names the Sys-binding's per-call trampoline. Two clients
    /// reach for this:
    ///
    /// * Static initializers that take the address of a libc fn
    ///   (a `dispatch_table[7].pCurrent = fcntl`-style table).
    /// * Bare expression-position references (`fp = readlink;`).
    ///
    /// Both want a callable c5 function-pointer value with the
    /// same call shape as the libc fn. We synthesize it lazily
    /// in [`Self::emit_sys_trampolines`]; here we only ensure a
    /// stable symbol exists that downstream fixups can reference.
    fn ensure_sys_trampoline_sym(&mut self, sys_sym_idx: usize) -> usize {
        if let Some(&idx) = self.sys_trampoline_sym.get(&sys_sym_idx) {
            return idx;
        }
        let name = alloc::format!("__c5_sys_trampoline_{sys_sym_idx}");
        let hash = lexer::hash_name(name.as_bytes());
        let sym = crate::c5::symbol::Symbol {
            name,
            token: Token::Id as i64,
            class: Token::Fun as i64,
            type_: self.symbols[sys_sym_idx].type_,
            params: self.symbols[sys_sym_idx].params.clone(),
            is_variadic: self.symbols[sys_sym_idx].is_variadic,
            val: 0,
            ..Default::default()
        };
        let idx = self.symbols.len();
        self.symbols.push(sym);
        // SymbolIndex must stay in sync with `symbols` -- even
        // for synthetic names that real source code can't reach
        // for. Without this the next user identifier the lexer
        // tries to register lands at a stale `idx` and chains
        // get crossed (and unrelated identifiers vanish). The
        // synthetic name is uniquely numbered so it can't shadow
        // anything user-visible.
        self.symbol_index.record(hash);
        self.sys_trampoline_sym.insert(sys_sym_idx, idx);
        idx
    }

    /// Emit the body of every requested Sys trampoline. Called
    /// after every real function body has been parsed -- so the
    /// emitted bytecode lands at the tail of `text` and never
    /// splits a caller mid-emission. Each trampoline is the
    /// shortest possible "re-push args, JsrExt, return" sequence:
    ///
    /// ```text
    /// Ent 0
    /// Lea 2  ; first arg slot
    /// Li
    /// Psh
    /// Lea 3  ; second arg slot
    /// Li
    /// Psh
    /// ...    ; one more pair per declared param
    /// JsrExt <binding-idx>
    /// Adj N  ; only if N > 0
    /// Lev
    /// ```
    ///
    /// Variadic libc fns lose anything beyond their declared
    /// fixed prefix -- a trampoline can only forward what its
    /// signature tells it to push. The known callers (e.g.
    /// dispatch-table slots for `fcntl` and `ioctl`) work
    /// because the cast at the use site lines up with the fixed
    /// prefix the trampoline does forward.
    fn emit_sys_trampolines(&mut self) {
        let entries: alloc::vec::Vec<(usize, usize)> = self
            .sys_trampoline_sym
            .iter()
            .map(|(&sys_idx, &tr_idx)| (sys_idx, tr_idx))
            .collect();
        for (sys_idx, tr_idx) in entries {
            let bc_pc = self.text.len();
            self.symbols[tr_idx].val = bc_pc as i64;

            let fixed_nargs = self.symbols[sys_idx].params.len();
            let is_variadic = self.symbols[sys_idx].is_variadic;
            let binding_idx = self.symbols[sys_idx].val;

            // Two trampoline shapes coexist:
            //
            // * Prototype-bearing bindings (`int fopen(char *,
            //   char *);`, ..., or any `int foo(...);`) get the
            //   classic `Ent + Lea/Li/Psh + JsrExt + Adj + Lev`
            //   body. The forwarded arg count matches the
            //   prototype, and the JsrExt lowering's per-arg
            //   FP-mask + post-call sub-word extension (#48) both
            //   stay in scope.
            //
            // * Bindings with *no* declared params (just
            //   `int Name();`) -- e.g. kernel32 entries that
            //   real-world dispatch tables cast back to the
            //   right arity at the call site -- get the
            //   single-op `Op::TailExt` body. The trampoline is
            //   `jmp [rip+iat]` and the caller's `Op::Jsri`
            //   lowering owns the host-ABI arg setup, return-
            //   register copy, and stack adjustment. Sub-word
            //   extension is left to the caller (the call site
            //   casts the result to the right type explicitly),
            //   which matches what real-world dispatch-table
            //   consumers already do.
            if fixed_nargs == 0 && !is_variadic {
                self.emit_op(Op::TailExt);
                self.emit_val(binding_idx);
                continue;
            }

            // For variadic libc fns the binding-declared param
            // count is only the fixed prefix; common dispatch
            // tables (open/fcntl/ioctl) want the trampoline to
            // forward *one* of the variadic args so the caller's
            // 3-argument cast lines up with what `JsrExt` packs
            // onto the macOS arm64 variadic-args stack region.
            // Callers that pass strictly the fixed prefix end up
            // reading one junk slot from above their own pushes,
            // but no in-the-wild caller does -- they all add at
            // least one extra arg precisely to feed the variadic.
            // The general case (forward N variadic args where N
            // is unknown at compile time) needs a real va_args
            // bridge -- tracked separately with the `c5 va_list`
            // work.
            let nargs = if is_variadic {
                fixed_nargs + 1
            } else {
                fixed_nargs
            };

            self.emit_op(Op::Ent);
            self.emit_val(0);
            // c5 uses cdecl push order: the first declared arg
            // ends up on top of the stack (lowest address) so
            // JsrExt can load arg-K from `sp + K*16`. We re-emit
            // the pushes right-to-left -- last declared arg
            // first -- so the trampoline's own JsrExt sees the
            // same shape its caller passed in.
            for i in (0..nargs).rev() {
                self.emit_lea((i + 2) as i64);
                self.emit_op(Op::Li);
                self.emit_op(Op::Psh);
            }
            self.emit_op(Op::JsrExt);
            self.emit_val(binding_idx);
            if nargs > 0 {
                self.emit_op(Op::Adj);
                self.emit_val(nargs as i64);
            }
            self.emit_op(Op::Lev);
        }
    }

    pub fn compile(mut self) -> Result<Program, C5Error> {
        if let Some(e) = self.deferred_error.take() {
            return Err(e);
        }
        self.run_compile()?;
        // Trampolines must land before fixups so their bc_pcs are
        // resolved when `apply_fn_call_fixups` walks the recorded
        // operands and `target_bc_pc` slots.
        self.emit_sys_trampolines();
        self.apply_fn_call_fixups()?;
        // `main` is optional today: shared-library output
        // (`OutputKind::SharedLibrary`) doesn't need an entry
        // point, and the executable-output writer surfaces a
        // clear error if `entry_pc` doesn't land on real code.
        // When neither `main`, any `#pragma export(...)`, nor
        // a user-defined `DllMain` is present we still refuse,
        // since the result would be an image with no callable
        // entries at all.
        // `#pragma entrypoint(<name>)` overrides the
        // canonical `main`. The override goes through the same
        // symbol-table lookup so the diagnostic is uniform: a
        // missing entrypoint always reads `<name>() not defined`.
        let entry_name_str: &str = self.pp_entrypoint.as_deref().unwrap_or("main");
        let entry_idx = lexer::find_symbol(&self.symbols, &self.symbol_index, entry_name_str);
        let dllmain_idx = lexer::find_symbol(&self.symbols, &self.symbol_index, "DllMain");
        let has_user_dllmain =
            dllmain_idx.is_some_and(|idx| self.symbols[idx].class == Token::Fun as i64);
        let entry_pc = match entry_idx {
            Some(idx) if self.symbols[idx].class == Token::Fun as i64 => {
                self.symbols[idx].val as usize
            }
            _ if !self.pending_exports.is_empty() || has_user_dllmain => 0,
            _ => {
                return Err(self.compile_err(alloc::format!("{entry_name_str}() not defined")));
            }
        };
        // Resolve `#pragma export(<name>)` directives against
        // the now-finalised symbol table. Each name must
        // resolve to a `Token::Fun` (a function defined in
        // this translation unit); anything else gets a clear
        // diagnostic so a misspelled export doesn't silently
        // produce a shared object missing the symbol the user
        // expected.
        let mut exports = Vec::with_capacity(self.pending_exports.len());
        for name in core::mem::take(&mut self.pending_exports) {
            let Some(idx) = lexer::find_symbol(&self.symbols, &self.symbol_index, &name) else {
                return Err(self.compile_err(format!(
                    "`#pragma export({name})` -- no such symbol; the name must \
                     refer to a function defined in this source"
                )));
            };
            if self.symbols[idx].class != Token::Fun as i64 {
                return Err(self.compile_err(format!(
                    "`#pragma export({name})` -- expected a function, but `{name}` \
                     is class {} (only locally-defined functions are exportable today; \
                     globals would need data-export support that isn't wired up yet)",
                    self.symbols[idx].class
                )));
            }
            exports.push(crate::c5::program::ExportedFunction {
                name,
                bytecode_pc: self.symbols[idx].val as usize,
            });
        }
        // A user-defined `DllMain` (any source-level function with
        // that exact name) overrides the boilerplate
        // `mov eax, 1; ret` DllMain stub the PE shared-library
        // writer otherwise emits. We record the bytecode PC here
        // unconditionally -- the VM / JIT / non-PE writers ignore
        // it, and the PE writer only consults it for `--shared`
        // builds. No signature validation: c5 trusts user `main`
        // the same way and DllMain is just a different ABI.
        let dllmain_pc =
            dllmain_idx.and_then(|idx| has_user_dllmain.then(|| self.symbols[idx].val as usize));
        Ok(Program {
            text: self.text,
            data: self.data,
            entry_pc,
            warnings: self.warnings,
            data_imm_positions: self.data_imm_positions,
            code_imm_positions: self.code_imm_positions,
            tls_data: self.tls_data,
            tls_init_size: self.tls_init_size,
            call_fp_arg_masks: self.call_fp_arg_masks,
            exports,
            data_relocs: self.data_relocs,
            code_relocs: self.code_relocs,
            dylibs: self.dylibs,
            dllmain_pc,
            source_lines: self.source_lines,
            source_functions: self.source_functions,
            source_files: self.source_files,
            source_file_indices: self.source_file_indices,
            // The compiler doesn't see the input path -- the CLI
            // shim sets this on the returned `Program` before
            // calling `emit_native_*`.
            source_path: String::new(),
            variables: self.variables,
            // Struct registry, exposed so the DWARF emitter can
            // walk member offsets / bitfield layouts and produce
            // `DW_TAG_structure_type` DIEs. The VM /
            // JIT / interpreter ignore this field.
            structs: self.structs,
            // Source-driven entry-name and
            // Windows subsystem flags drained from the
            // preprocessor. Both default to None (image writers
            // pick `main` / `Console` respectively).
            entry_name: self.pp_entrypoint,
            subsystem: self.pp_subsystem,
        })
    }

    // ---- Lexer plumbing ----

    fn next(&mut self) -> Result<(), C5Error> {
        self.lex
            .next(&mut self.symbols, &mut self.symbol_index, &mut self.data)
    }

    // ---- Code emission ----

    fn emit_op(&mut self, op: Op) {
        // Any emit invalidates the function-pointer chain
        // tracking. Identifier loads and the unary `*` handler
        // re-seed it after their own emits when the symbol /
        // result is in fn-ptr lineage (see
        // `fn_ptr_chain_depth`).
        self.fn_ptr_chain_depth = -1;
        self.text.push(op as i64);
        // Mirror text.len() one-for-one in source_lines /
        // source_functions / source_file_indices so a bc_pc
        // lookup is a direct index. Operand slots inherit the
        // op's source position.
        let file_idx = self.intern_source_file();
        self.source_lines.push(self.lex.line as u32);
        self.source_functions
            .push(self.current_function_name.clone());
        self.source_file_indices.push(file_idx);
    }

    fn emit_val(&mut self, val: i64) {
        self.text.push(val);
        let file_idx = self.intern_source_file();
        self.source_lines.push(self.lex.line as u32);
        self.source_functions
            .push(self.current_function_name.clone());
        self.source_file_indices.push(file_idx);
    }

    /// Look up the lexer's current `(file)` in `source_files`,
    /// pushing a fresh entry if this is the first time we see it.
    /// Returns the resulting index. Index 0 is reserved for the
    /// translation unit's filename so the file table is always
    /// non-empty for the DWARF emitter (which uses index 0 as the
    /// CU's primary file).
    fn intern_source_file(&mut self) -> u16 {
        let name = &self.lex.file;
        if let Some(pos) = self.source_files.iter().position(|f| f == name) {
            // Cap at u16::MAX to keep `source_file_indices` a tight
            // column. A translation unit with > 65k distinct
            // headers is well past anything we've seen; clamp
            // rather than overflow so the codegen still produces
            // *some* attribution.
            return pos.min(u16::MAX as usize) as u16;
        }
        let idx = self.source_files.len();
        self.source_files.push(name.clone());
        idx.min(u16::MAX as usize) as u16
    }

    /// Emit a plain `Op::Imm <val>` -- a 2-word `[op, operand]`
    /// pair that pushes a 64-bit constant into the accumulator.
    /// The constant is treated as a literal value with no
    /// runtime address-fixup; for data-segment offsets that need
    /// `__data` relocation use [`emit_data_imm`] instead.
    fn emit_imm(&mut self, val: i64) {
        self.emit_op(Op::Imm);
        self.emit_val(val);
    }

    /// Emit `Op::Lea <slot_off>` -- load the effective address of
    /// a stack slot (param positive, local negative) into the
    /// accumulator. Convenience wrapper for the very common
    /// `emit_op(Lea); emit_val(off);` pair.
    fn emit_lea(&mut self, slot_off: i64) {
        self.emit_op(Op::Lea);
        self.emit_val(slot_off);
    }

    /// Emit `Op::Jmp <target_pc>` -- direct branch to a known
    /// bytecode PC. The placeholder shape (Jmp + 0 operand whose
    /// PC is captured for a later patch) doesn't fit this helper
    /// and stays inline at its handful of sites.
    fn emit_jmp(&mut self, target_pc: i64) {
        self.emit_op(Op::Jmp);
        self.emit_val(target_pc);
    }

    /// Emit `Psh; Imm <val>; <op>` -- the three-op idiom for
    /// "apply `op` to the accumulator with `val` as the right-
    /// hand operand". The optimizer's immediate-form pass fuses
    /// the same triple into AddI / MulI / ShlI / etc., so the
    /// runtime cost is identical; this helper just consolidates
    /// the 11-odd parser sites that emit pointer-arithmetic
    /// scaling, bitfield mask-and-shift, post/pre-increment step
    /// values, and the like.
    fn emit_binop_with_imm(&mut self, op: Op, val: i64) {
        self.emit_op(Op::Psh);
        self.emit_imm(val);
        self.emit_op(op);
    }

    /// Pre-divide / pre-modulo C99 6.3.1.3 conversion to the unsigned
    /// common type. When one operand is signed and the common type is
    /// unsigned narrower than 8 bytes, the signed operand carries
    /// sign-extended high bits in the 64-bit accumulator
    /// (`(int)-1` is `0xFFFFFFFFFFFFFFFF`); the unsigned-divide op
    /// would treat that as a huge positive instead of the 32-bit
    /// `0xFFFFFFFF` C99 prescribes. Mask both operands to the common
    /// width before the divide.
    ///
    /// Layout going in: stack-top = LHS, accumulator = RHS.
    /// Layout going out: same shape, but each masked to `common`.
    fn maybe_mask_operands_to_unsigned_common(&mut self, lhs_ty: i64, rhs_ty: i64) {
        let common = usual_arith_common_ty(lhs_ty, rhs_ty, self.target);
        if !is_unsigned_ty(common) {
            return;
        }
        let mask: i64 = match self.size_of_type(common) {
            1 => 0xff,
            2 => 0xffff,
            4 => 0xffff_ffff,
            _ => return,
        };
        // Stash RHS to a scratch local so we can pop the LHS off the
        // c5 stack into the accumulator, mask it, push it back, and
        // reload RHS for the divide.
        self.loc_offs += 1;
        if self.loc_offs > self.max_loc_offs {
            self.max_loc_offs = self.loc_offs;
        }
        let temp = -self.loc_offs;
        self.emit_op(Op::StLocI);
        self.emit_val(temp);
        // Pop LHS off the c5 stack into accumulator: `Imm 0; Or` pops
        // stack-top into acc by virtue of `Op::Or` ORing acc with the
        // popped stack-top (acc was set to 0 a moment ago).
        self.emit_imm(0);
        self.emit_op(Op::Or);
        self.emit_binop_with_imm(Op::And, mask);
        self.emit_op(Op::Psh);
        self.emit_lea(temp);
        self.emit_op(Op::Li);
        self.emit_binop_with_imm(Op::And, mask);
    }

    /// After an Add / Sub / Mul, normalize the 64-bit accumulator
    /// to the C99 6.3.1.8 common type's storage width.
    ///
    /// Unsigned common type: mask with `(1 << N) - 1`. C99 mandates
    /// wrap-modulo-2^N; without this `(uint)0xFFFFFFFF + 1u` leaves
    /// 0x100000000 in the 64-bit register, and any consumer that
    /// widens the result before it reaches a typed slot
    /// (a long-typed slot, a variadic FP boundary, an
    /// immediately-following cast) reads the wider value.
    ///
    /// Signed common type: signed-int overflow is undefined behavior
    /// per C99 6.5p5, but clang and gcc both consistently truncate
    /// the result to the type's width and sign-extend back. c5
    /// matches that convention via `Shl K; Shr K` where `K = 64 -
    /// width_bits`. So `(int)50000 * (int)50000` becomes
    /// 0x9502F900 sign-extended = -1794967296.
    fn maybe_mask_to_unsigned_width(&mut self, lhs_ty: i64, rhs_ty: i64) {
        if is_pointer_ty(lhs_ty) || is_pointer_ty(rhs_ty) {
            return;
        }
        if is_floating_scalar(lhs_ty) || is_floating_scalar(rhs_ty) {
            return;
        }
        let common = usual_arith_common_ty(lhs_ty, rhs_ty, self.target);
        let common_size = self.size_of_type(common);
        if is_unsigned_ty(common) {
            let mask: i64 = match common_size {
                1 => 0xff,
                2 => 0xffff,
                4 => 0xffff_ffff,
                _ => return,
            };
            self.emit_binop_with_imm(Op::And, mask);
        } else {
            // Signed: integer promotion already widens char / short
            // to int, so the only narrow signed common type that
            // reaches here is `int` (size 4), or `long` on LLP64
            // (also size 4). Width-8 signed types fill the
            // accumulator and need no normalization.
            let shift_bits: i64 = match common_size {
                1 => 56,
                2 => 48,
                4 => 32,
                _ => return,
            };
            self.emit_binop_with_imm(Op::Shl, shift_bits);
            self.emit_binop_with_imm(Op::Shr, shift_bits);
        }
    }

    /// Emit `==` (or `!=` if `invert`) accounting for C99 6.3.1.8
    /// usual-arithmetic-conversions when the LHS / RHS have
    /// different signedness or widths.
    ///
    /// Plain `Op::Eq` is bit-equality at 64 bits, which goes wrong
    /// when (a) the common type is narrower than 8 bytes and
    /// (b) one operand is sign-extended into the high half while
    /// the other isn't. e.g. `(int)-1 == (uint)0xFFFFFFFF` should be
    /// true at the common `unsigned int` width, but the LHS lives
    /// in the register as 0xFFFFFFFFFFFFFFFF (sign-extended via
    /// `Op::Lw`) and the RHS as 0x00000000FFFFFFFF (zero-extended
    /// via `Op::Lwu`), so straight `Eq` returns false.
    ///
    /// Strategy: if the common type is narrower than 8 bytes, fold
    /// the LHS-on-stack and RHS-in-acc through XOR (which pops the
    /// stack), AND with the common-width mask, then compare against
    /// 0. Equal iff the masked-XOR is 0. The `Op::Xor` -> `Op::And`
    /// -> `Op::Eq`/`Op::Ne` sequence is 5 ops; the wide-common
    /// path uses 1, so the cost only lands on mixed-width sites.
    fn emit_eq_with_common_width(&mut self, lhs_ty: i64, invert: bool) {
        let plain_op = if invert { Op::Ne } else { Op::Eq };
        // Pointers are 8 bytes regardless of pointee type and are
        // always compared as full-width values; the common-width
        // mask is only correct for actual integers. `p == 0`
        // would otherwise mask the pointer to 32 bits and accept
        // any pointer with low-half-zero as NULL.
        if is_pointer_ty(lhs_ty) || is_pointer_ty(self.ty) {
            self.emit_op(plain_op);
            return;
        }
        // The XOR-mask trick only matters when one operand is
        // signed and the other unsigned at a width narrower than
        // 8 bytes -- that's when the sign-extension into the
        // 64-bit register can make `(int)-1 == (uint)0xFFFFFFFF`
        // come out false. When both operands have the same
        // signedness, both loads produce matching 64-bit
        // representations and plain `Op::Eq` already does the
        // right thing. Skipping the trick for the same-
        // signedness case keeps the per-eq cost at 1 op for the
        // overwhelmingly common path.
        let lhs_unsigned = is_unsigned_ty(lhs_ty);
        let rhs_unsigned = is_unsigned_ty(self.ty);
        if lhs_unsigned == rhs_unsigned {
            self.emit_op(plain_op);
            return;
        }
        let common = usual_arith_common_ty(lhs_ty, self.ty, self.target);
        let common_size = self.size_of_type(common);
        if common_size >= 8 {
            self.emit_op(plain_op);
            return;
        }
        // Narrow common type, mixed signedness: emit
        // XOR-then-mask-then-compare-zero so the comparison sees
        // only the low common-width bytes.
        let mask: i64 = match common_size {
            1 => 0xff,
            2 => 0xffff,
            4 => 0xffff_ffff,
            _ => -1,
        };
        if mask == -1 {
            self.emit_op(plain_op);
            return;
        }
        // Acc holds RHS; stack-top holds LHS. `Op::Xor` does
        // `acc = acc XOR top, sp += 8` -- after this, acc holds
        // `LHS XOR RHS` (XOR is commutative) and the stack is
        // restored to its pre-comparison state.
        self.emit_op(Op::Xor);
        // Mask the XOR to the common-type width: the comparison
        // only cares about the low N bytes.
        self.emit_binop_with_imm(Op::And, mask);
        // Compare against 0.
        self.emit_binop_with_imm(plain_op, 0);
    }

    /// Save the current `class` / `type_` / `val` of
    /// `self.symbols[idx]` into the matching shadow fields
    /// `h_class` / `h_type` / `h_val`. Used at function-body
    /// scope when a parameter or local declaration shadows an
    /// outer name; the function-exit cleanup pass restores the
    /// outer binding by reading the shadow fields back.
    fn shadow_symbol(&mut self, idx: usize) {
        let s = &mut self.symbols[idx];
        s.h_class = s.class;
        s.h_type = s.type_;
        s.h_val = s.val;
        s.h_fn_ptr_indirection = s.fn_ptr_indirection;
    }

    /// Inverse of [`shadow_symbol`]: restore the saved outer
    /// binding from the `h_*` shadow fields. Static method
    /// because the cleanup pass walks `self.symbols.iter_mut()`
    /// and already holds a `&mut Symbol`; passing the symbol
    /// reference avoids re-borrowing the symbol table.
    fn restore_shadowed_symbol(sym: &mut Symbol) {
        sym.class = sym.h_class;
        sym.type_ = sym.h_type;
        sym.val = sym.h_val;
        sym.fn_ptr_indirection = sym.h_fn_ptr_indirection;
    }

    /// Emit `Op::Imm <data_offset>` and record the operand's bytecode
    /// position in [`Compiler::data_imm_positions`]. Use this anywhere
    /// the immediate is the address of a string literal or a global --
    /// the VM treats the result identically to a plain `Op::Imm`, but
    /// the native backend needs the side channel to relocate the value
    /// against the real `__data` vmaddr at link time.
    fn emit_data_imm(&mut self, data_offset: i64) {
        self.emit_op(Op::Imm);
        self.data_imm_positions.push(self.text.len());
        self.emit_val(data_offset);
    }

    /// Pad `self.data` with zero bytes so the next allocation lands on
    /// an 8-byte boundary. c5 treats every non-char type as i64-aligned
    /// (short / int / pointers / structs all 8-byte), so a global array
    /// of i64s placed after a char array (or any odd-length blob) would
    /// otherwise start unaligned and `ldr x19, [x19]` would fault on
    /// macOS arm64.
    fn align_data_to_8(&mut self) {
        while !self.data.len().is_multiple_of(8) {
            self.data.push(0);
        }
    }

    /// If the most recently emitted op is a scalar load (`Op::Lc`
    /// / `Op::Lw` / `Op::Li`), rewrite it in place to `Op::Psh` and
    /// return the matching reload op so the caller can `emit_op` it
    /// to put the original loaded value back into the accumulator.
    /// Returns `None` if the trailing op isn't a scalar load, in
    /// which case the caller reports its own "bad lvalue" error.
    ///
    /// The pattern shows up in pre/post-increment, plain
    /// assignment, and compound assignment. Centralising the
    /// `last() / last_mut() / Op::Psh` triple keeps the four
    /// call sites in sync when new load-op variants are added.
    fn rewrite_trailing_load_as_psh(&mut self) -> Option<Op> {
        let last = *self.text.last()?;
        if !is_scalar_load_op_val(last) {
            return None;
        }
        *self.text.last_mut().unwrap() = Op::Psh as i64;
        Some(reemit_scalar_load(last))
    }

    /// If the most recently emitted op is a scalar load (`Op::Lc`
    /// / `Op::Lw` / `Op::Li`), pop it -- the load's address-
    /// producing source op then sits at the new tail, ready to
    /// drive the surrounding lvalue operation. Returns `true` on
    /// success. Used by `&expr` to convert an rvalue load chain
    /// into an lvalue-address chain.
    fn pop_trailing_scalar_load(&mut self) -> bool {
        if matches!(self.text.last(), Some(&op) if is_scalar_load_op_val(op)) {
            self.text.pop();
            // Keep parallel debug arrays in sync with `text`.
            // Without these matching pops the
            // source_functions / source_lines tail drifts past
            // text.len() and every later emit_op lands in the
            // wrong slot.
            self.source_lines.pop();
            self.source_functions.pop();
            self.source_file_indices.pop();
            true
        } else {
            false
        }
    }

    /// Open a fresh `break` + `continue` scope for a `while` /
    /// `for` / `do-while` body. Both stacks are pushed; the caller
    /// finishes with [`patch_loop_continues`] (to land continues
    /// at the loop's step / cond-check PC) and [`patch_loop_breaks`]
    /// (to land breaks just past the loop), in that order.
    fn enter_loop(&mut self) {
        self.loop_breaks.push(Vec::new());
        self.loop_continues.push(Vec::new());
    }

    /// Open a `break`-only scope for a `switch` body. C disallows
    /// `continue` inside a switch, so only `loop_breaks` gets a
    /// new stack frame; the caller finishes with
    /// [`patch_loop_breaks`] alone.
    fn enter_switch(&mut self) {
        self.loop_breaks.push(Vec::new());
    }

    /// Patch every `Jmp` operand recorded by the innermost loop's
    /// `continue` statements to land at `target_pc`, then drop the
    /// scope. Must be called before [`patch_loop_breaks`] so the
    /// stack discipline stays balanced.
    fn patch_loop_continues(&mut self, target_pc: usize) {
        for pc in self.loop_continues.pop().unwrap() {
            self.text[pc] = target_pc as i64;
        }
    }

    /// Patch every `Jmp` operand recorded by the innermost loop's
    /// or switch's `break` statements to land at `target_pc`, then
    /// drop the scope.
    fn patch_loop_breaks(&mut self, target_pc: usize) {
        for pc in self.loop_breaks.pop().unwrap() {
            self.text[pc] = target_pc as i64;
        }
    }

    /// Record the operand-PC of a `Jmp` emitted for an explicit
    /// `break` statement; the enclosing loop / switch's exit
    /// patcher backfills the target. Caller has already verified
    /// the loop_breaks stack is non-empty.
    fn record_break_jmp(&mut self, jmp_operand_pc: usize) {
        self.loop_breaks.last_mut().unwrap().push(jmp_operand_pc);
    }

    /// Record the operand-PC of a `Jmp` emitted for an explicit
    /// `continue` statement; the enclosing loop's continue
    /// patcher backfills the target. Caller has already verified
    /// the loop_continues stack is non-empty.
    fn record_continue_jmp(&mut self, jmp_operand_pc: usize) {
        self.loop_continues.last_mut().unwrap().push(jmp_operand_pc);
    }

    // ---- Recursive descent ----

    fn expr(&mut self, lev: i64) -> Result<(), C5Error> {
        let mut t: i64;

        if self.lex.tk == 0 {
            return Err(self.compile_err("unexpected eof in expression"));
        } else if self.lex.tk == Token::Num {
            self.emit_imm(self.lex.ival);
            self.next()?;
            self.ty = Ty::Int as i64;
        } else if self.lex.tk == Token::FloatNum {
            // The lexer parsed `1.5` etc. into f64 and stored
            // `f64::to_bits()` cast to i64 in `ival`. The byte
            // pattern flows through Op::Imm unmodified -- a future
            // float codegen reads it back with `f64::from_bits`.
            // Until then, the `is_floating_scalar` self-ty marks
            // the value so it can't accidentally feed into integer
            // arithmetic (the binary-op handlers gate on this).
            self.emit_imm(self.lex.ival);
            self.next()?;
            self.ty = Ty::Double as i64;
        } else if self.lex.tk == '"' {
            self.emit_data_imm(self.lex.ival);
            self.next()?;
            // C concatenates adjacent string literals -- `"a" "b"` is one
            // string. The lexer leaves the NUL off so the bytes flow
            // straight together; we add the single trailing NUL here.
            while self.lex.tk == '"' {
                self.next()?;
            }
            self.data.push(0);
            self.ty = Ty::Ptr as i64;
        } else if self.lex.tk == Token::Sizeof {
            // C99 6.5.3.4: `sizeof(<type>)`, `sizeof(<expr>)`, or
            // `sizeof <unary-expr>`. The shared helper handles
            // all three shapes; this site just emits the result
            // as a runtime immediate and pins the expression
            // type at `int`.
            self.next()?;
            let total_bytes = self.sizeof_operand_bytes()?;
            self.emit_imm(total_bytes);
            self.ty = Ty::Int as i64;
        } else if self.lex.tk == Token::Id {
            let id_idx = self.lex.curr_id_idx;
            self.next()?;
            if self.lex.tk == '(' {
                self.next()?;
                // Compiler-builtin intrinsic call (`alloca`, future
                // atomics / cpuid / ...). The frontend stamped the
                // symbol's `intrinsic` field at declaration time
                // from `#pragma intrinsic("name")`. Skip the usual
                // staging-slot dance and per-arg FP-mask shenanigans
                // -- intrinsics today take exactly one integer
                // argument and leave the result in the accumulator,
                // so we just evaluate the arg expression and emit
                // `Op::Intrinsic <id>`. Multi-arg / FP-arg intrinsics
                // can grow this branch as needed.
                if let Some(&intrinsic_id) = self.pp_intrinsics.get(&self.symbols[id_idx].name) {
                    let fn_name = self.symbols[id_idx].name.clone();
                    if self.lex.tk == ')' {
                        return Err(self
                            .compile_err(format!("intrinsic `{fn_name}` requires one argument")));
                    }
                    self.expr(Token::Assign as i64)?;
                    // Coerce a float argument to int when the
                    // intrinsic expects an integer size (the only
                    // shape we have today). Mirrors the assignment
                    // conversion in `convert_assign_rhs`.
                    if is_floating_scalar(self.ty) {
                        self.emit_op(Op::Fcvtfi);
                        self.ty = Ty::Int as i64;
                    }
                    if self.lex.tk != ')' {
                        return Err(self.compile_err(format!(
                            "intrinsic `{fn_name}` takes exactly one argument"
                        )));
                    }
                    self.next()?;
                    self.emit_op(Op::Intrinsic);
                    self.emit_val(intrinsic_id);
                    // Flag the function for the alloca-arena
                    // patch-up at function-end. We don't reserve
                    // the alloca-top slot here -- the function
                    // might still grow more regular locals after
                    // this point, and the slot must sit just
                    // below them so the arena ends up at the
                    // deepest part of the frame.
                    if intrinsic_id == (crate::c5::op::Intrinsic::Alloca as i64) {
                        self.uses_alloca_in_current_fn = true;
                    }
                    // Result is a `void *` -- bump the return type
                    // to a pointer so downstream uses (assigning to
                    // a `T *`, casting via `(T *)alloca(n)`) see the
                    // right shape.
                    self.ty = (Ty::Char as i64) + (Ty::Ptr as i64);
                } else {
                    // Snapshot the declared signature up front: the per-arg
                    // type checks read from `expected_params` and `is_variadic`,
                    // and we don't want a recursive call to clobber them via
                    // self-mutation. Cloning the Vec is cheap (typically 1-3
                    // i64s) compared to the cost of the type check itself.
                    let expected_params = self.symbols[id_idx].params.clone();
                    let is_variadic = self.symbols[id_idx].is_variadic;
                    let fn_name_for_warn = self.symbols[id_idx].name.clone();
                    // Struct-returning callees use a hidden out-pointer
                    // arg at val=2: the caller pre-allocates a temp for
                    // the result and passes its address as arg 0; the
                    // callee's `return s` writes to *(out_pointer)
                    // before Lev. The result expression's value (in
                    // `a`) becomes the temp's address so an enclosing
                    // `lhs = call(...)` Mcpy reads from there.
                    let callee_ret_ty = self.symbols[id_idx].type_;
                    let callee_returns_struct = self.symbols[id_idx].class == Token::Fun as i64
                        && is_struct_ty(callee_ret_ty)
                        && struct_ptr_depth(callee_ret_ty) == 0;
                    // Token::Sys (libc) calls returning a struct by
                    // value would need real platform-ABI register
                    // packing -- SysV's two-register split for
                    // 8 < size <= 16, Win64's hidden out-pointer for
                    // size > 8, AAPCS64's HFA / two-GPR split, and so
                    // on. The c5-internal "address-as-value, hidden
                    // out-pointer at val=2" convention only works for
                    // c5-to-c5 calls. Refuse the call up front rather
                    // than emit a silently-broken sequence.
                    if self.symbols[id_idx].class == Token::Sys as i64
                        && is_struct_ty(callee_ret_ty)
                        && struct_ptr_depth(callee_ret_ty) == 0
                    {
                        return Err(self.compile_err(format!(
                            "`{}` returns a struct by value, but the \
                         platform-ABI struct-return convention isn't \
                         implemented for Token::Sys calls. Use a \
                         pointer-returning variant or pass an out-buffer.",
                            fn_name_for_warn
                        )));
                    }
                    let mut nargs = 0;
                    // For struct returns, allocate a result temp now
                    // so its address can be pushed before the
                    // declared-arg pushes.
                    let saved_loc_offs_for_result = self.loc_offs;
                    let result_temp_off: i64 = if callee_returns_struct {
                        let slots = self.slots_of_type(callee_ret_ty);
                        self.loc_offs += slots;
                        if self.loc_offs > self.max_loc_offs {
                            self.max_loc_offs = self.loc_offs;
                        }
                        -self.loc_offs
                    } else {
                        0
                    };
                    // c5 uses cdecl-style arg passing: args are pushed
                    // right-to-left so the i'th declared param sits at
                    // `[bp + 16*(i+1)]`. The parser still has to evaluate
                    // args left-to-right (so observable side effects
                    // happen in source order), so each arg gets parked in
                    // a transient temp local and we re-emit the pushes in
                    // reverse once they're all evaluated.
                    let saved_loc_offs = self.loc_offs;
                    let mut temp_offsets: Vec<i64> = Vec::new();
                    // Per-arg FP flag, captured at evaluation time. Used
                    // below when the call is `Token::Sys` to build a bit
                    // mask the codegen reads for variadic FP packing
                    // (`printf("%f", x)` etc.). Order matches
                    // `temp_offsets`: index 0 = first declared arg.
                    let mut arg_is_fp: Vec<bool> = Vec::new();
                    while self.lex.tk != ')' {
                        let arg_line = self.lex.line;
                        // Allocate a temp slot for this arg.
                        self.loc_offs += 1;
                        if self.loc_offs > self.max_loc_offs {
                            self.max_loc_offs = self.loc_offs;
                        }
                        let temp_off = -self.loc_offs;
                        temp_offsets.push(temp_off);

                        // Emit the `*temp = expr;` shape that c5's
                        // assignment path already supports: address
                        // first, push, then RHS, then Si.
                        self.emit_lea(temp_off);
                        self.emit_op(Op::Psh);
                        self.expr(Token::Assign as i64)?;

                        // Type-check before the Si overwrites self.ty.
                        if (nargs as usize) < expected_params.len() {
                            let want = expected_params[nargs as usize];
                            let zero = self.last_emit_is_zero();
                            let untyped = self.last_emit_was_indirect_call();
                            if let Some(reason) =
                                Self::type_warning_with_flags(want, self.ty, zero, untyped)
                            {
                                let got = self.ty;
                                let want_s = format_type(want, &self.structs);
                                let got_s = format_type(got, &self.structs);
                                self.warn_at(
                                arg_line,
                                format!(
                                    "{reason} in argument {} of `{}` (param={want_s}, arg={got_s})",
                                    nargs + 1,
                                    fn_name_for_warn,
                                ),
                            );
                            }
                            // C99 6.5.2.2p7: declared-parameter call
                            // arguments undergo the same assignment
                            // conversion as the `= expr` rule. If the
                            // prototype expects `double` and the
                            // actual is an integer, lift via
                            // `Op::Fcvtif` so the IEEE-754 bit pattern
                            // reaches the FP-arg register the codegen
                            // routes through (xmm_N / d_N). Without
                            // this, the integer bit pattern lands in
                            // the GPR-arg register and libm reads
                            // garbage out of the FP register.
                            self.convert_assign_rhs(want);
                        } else if !expected_params.is_empty() && !is_variadic {
                            self.warn_at(
                                arg_line,
                                format!(
                                    "too many arguments to `{}` (expected {}, got at least {})",
                                    fn_name_for_warn,
                                    expected_params.len(),
                                    nargs + 1,
                                ),
                            );
                        }

                        arg_is_fp.push(is_floating_scalar(self.ty));
                        // Refuse passing a struct by value to a
                        // Token::Sys callee. The c5-internal "push
                        // the address" convention works for c5-to-c5
                        // calls (the callee copies into a fresh local
                        // on entry); platform ABIs for libc instead
                        // expect the bytes packed into argument
                        // registers (SysV/AAPCS64: 1-2 GPRs for
                        // structs <= 16 bytes; Win64: a single GPR
                        // for <= 8 bytes, hidden pointer otherwise).
                        // Implementing those splits is future work;
                        // for now flag the mismatch loudly.
                        if self.symbols[id_idx].class == Token::Sys as i64
                            && is_struct_ty(self.ty)
                            && struct_ptr_depth(self.ty) == 0
                        {
                            return Err(self.compile_err_at(
                                arg_line,
                                format!(
                                    "argument {} of `{}` is a struct passed by value, \
                                 but the platform-ABI struct-arg convention isn't \
                                 implemented for Token::Sys calls. Pass `&s` (a \
                                 pointer to the struct) instead.",
                                    nargs + 1,
                                    fn_name_for_warn
                                ),
                            ));
                        }
                        self.emit_op(Op::Si);
                        nargs += 1;
                        if self.lex.tk == ',' {
                            self.next()?;
                        }
                    }
                    // Push from temp slots right-to-left so the first
                    // declared param ends up on top of the c5 stack.
                    for &temp_off in temp_offsets.iter().rev() {
                        self.emit_lea(temp_off);
                        self.emit_op(Op::Li);
                        self.emit_op(Op::Psh);
                    }
                    // For struct-returning callees, push the hidden
                    // out-pointer (address of the result temp) so it
                    // lands at val=2 -- ahead of the first declared
                    // arg in the c5 stack walk. The callee's `return
                    // s` writes through it; on return we set `a` to
                    // the temp's address so the enclosing assignment
                    // can Mcpy from it.
                    if callee_returns_struct {
                        self.emit_lea(result_temp_off);
                        self.emit_op(Op::Psh);
                    }
                    // Release the staging slots; they'll be reused by
                    // the next call in this function. The result-temp
                    // slot stays alive (loc_offs not reset to it) until
                    // the enclosing expression consumes it.
                    let target_loc_offs = if callee_returns_struct {
                        saved_loc_offs_for_result + self.slots_of_type(callee_ret_ty)
                    } else {
                        saved_loc_offs
                    };
                    self.loc_offs = target_loc_offs;
                    // Arity underflow check (after the loop, when nargs is
                    // final). Only fires for non-variadic functions with a
                    // recorded signature.
                    if !is_variadic
                        && !expected_params.is_empty()
                        && (nargs as usize) < expected_params.len()
                    {
                        let line = self.lex.line;
                        self.warn_at(
                            line,
                            format!(
                                "too few arguments to `{}` (expected {}, got {})",
                                fn_name_for_warn,
                                expected_params.len(),
                                nargs,
                            ),
                        );
                    }
                    self.next()?;
                    if self.symbols[id_idx].class == Token::Sys as i64 {
                        // External library call. The symbol's `val` is
                        // the binding's flat index across all
                        // `#pragma binding(...)` directives the
                        // preprocessor parsed; the codegen / VM use it
                        // as the GOT slot lookup key (native) or the
                        // dispatch-table key (VM).
                        let jsrext_pc = self.text.len();
                        self.emit_op(Op::JsrExt);
                        self.emit_val(self.symbols[id_idx].val);
                        // Capture per-arg FP-ness for the codegen. Only
                        // needed when at least one arg is FP; an
                        // all-integer call rides the existing path.
                        let mut mask: u32 = 0;
                        for (i, &is_fp) in arg_is_fp.iter().enumerate() {
                            if is_fp && i < 32 {
                                mask |= 1u32 << i;
                            }
                        }
                        if mask != 0 {
                            self.call_fp_arg_masks.push((jsrext_pc, mask));
                        }
                    } else if self.symbols[id_idx].class == Token::Fun as i64 {
                        self.emit_op(Op::Jsr);
                        // Record a fixup so the operand gets re-resolved
                        // after the callee's body lands. `val == 0`
                        // means the body hasn't been parsed yet (the
                        // symbol is from a forward declaration); the
                        // value we emit now is a placeholder. After
                        // every function body is parsed we walk this
                        // list and rewrite each operand to the
                        // post-body `ent_pc` of its callee. Calls that
                        // already see a non-zero `val` (the callee's
                        // body lands before the call, the common case)
                        // still record an entry but the post-body walk
                        // re-emits the same value -- a no-op rather
                        // than a bug.
                        let operand_pc = self.text.len();
                        self.fn_call_fixups.push((operand_pc, id_idx));
                        self.emit_val(self.symbols[id_idx].val);
                    } else if self.symbols[id_idx].class == Token::Loc as i64
                        || self.symbols[id_idx].class == Token::Glo as i64
                    {
                        if self.symbols[id_idx].class == Token::Loc as i64 {
                            self.emit_lea(self.symbols[id_idx].val);
                        } else {
                            self.emit_data_imm(self.symbols[id_idx].val);
                        }
                        self.emit_op(Op::Li);
                        self.emit_op(Op::Jsri);
                    } else {
                        let name = self.symbols[id_idx].name.clone();
                        let suggestion = match super::headers::header_declaring(&name) {
                            Some(h) => format!(" -- try `#include <{h}>`"),
                            None => String::new(),
                        };
                        return Err(
                            self.compile_err(format!("unknown function `{name}`{suggestion}"))
                        );
                    }
                    let total_pushed = if callee_returns_struct {
                        nargs + 1
                    } else {
                        nargs
                    };
                    if total_pushed > 0 {
                        self.emit_op(Op::Adj);
                        self.emit_val(total_pushed);
                    }
                    // For struct-returning callees, the result lives
                    // in the caller-allocated temp. After the call,
                    // load the temp's address into `a` so the
                    // expression's value (struct-rvalue semantics:
                    // address-as-value) flows into the enclosing
                    // assignment / `.field` access.
                    if callee_returns_struct {
                        self.emit_lea(result_temp_off);
                    }
                    // For direct calls (Jsr/JsrExt) the symbol's `type_`
                    // is the declared return type. For indirect calls
                    // through a variable (Jsri), `type_` is the *variable*
                    // type (e.g. `int *` for a function pointer), not the
                    // return type -- the dialect has no place to record
                    // a function pointer's return type. Default to `int`
                    // for the result; the actual register value carries
                    // the full 8-byte return regardless of the tag, so
                    // assigning to a wider lvalue still preserves bits.
                    self.ty = if self.symbols[id_idx].class == Token::Loc as i64
                        || self.symbols[id_idx].class == Token::Glo as i64
                    {
                        Ty::Int as i64
                    } else {
                        self.symbols[id_idx].type_
                    };
                } // close intrinsic-vs-normal-call else branch
            } else if self.symbols[id_idx].class == Token::Num as i64 {
                self.emit_imm(self.symbols[id_idx].val);
                self.ty = Ty::Int as i64;
            } else if self.symbols[id_idx].class == Token::Fun as i64 {
                // Bare function reference (e.g. `fp = add;`). The value
                // becomes a user-visible pointer, so it gets the CODE_BASE
                // bias -- that lets the VM tell apart "function pointer"
                // from "data pointer", and refuse to deref the former.
                self.emit_op(Op::Imm);
                let operand_pc = self.text.len();
                self.fn_call_fixups.push((operand_pc, id_idx));
                // Record the operand_pc so the native codegen knows
                // this Imm carries (CODE_BASE + bc_pc) -- otherwise
                // a user constant that happens to land in the
                // [CODE_BASE, CODE_BASE + text.len()) range would be
                // misclassified as a function-pointer literal.
                self.code_imm_positions.push(operand_pc);
                self.emit_val(CODE_BASE as i64 + self.symbols[id_idx].val);
                // Type as `int*` rather than `char*`: matches the
                // conventional `int *fp = some_function;` idiom and
                // keeps the type-check loose-but-not-wrong.
                self.ty = Ty::Int as i64 + Ty::Ptr as i64;
            } else if self.symbols[id_idx].class == Token::Sys as i64 {
                // Bare libc reference -- `fp = readlink;`. We can't
                // fold in the real GOT/IAT address at compile time,
                // so we point the value at a per-Sys trampoline (a
                // tiny synthetic c5 function that re-dispatches
                // through `Op::JsrExt`). `apply_fn_call_fixups`
                // then patches this `Imm` operand to
                // `CODE_BASE + trampoline_pc` once
                // [`Self::emit_sys_trampolines`] has placed the
                // trampolines at the tail of `text`. The
                // accompanying `code_imm_positions` entry tells the
                // codegen this Imm carries a code pointer so it
                // emits the right ADRP/ADD (or RIP-relative LEA)
                // sequence.
                let tr_idx = self.ensure_sys_trampoline_sym(id_idx);
                self.emit_op(Op::Imm);
                let operand_pc = self.text.len();
                self.fn_call_fixups.push((operand_pc, tr_idx));
                self.code_imm_positions.push(operand_pc);
                self.emit_val(CODE_BASE as i64);
                self.ty = Ty::Int as i64 + Ty::Ptr as i64;
            } else {
                if self.symbols[id_idx].class == Token::Loc as i64 {
                    self.emit_lea(self.symbols[id_idx].val);
                } else if self.symbols[id_idx].class == Token::Glo as i64
                    && self.symbols[id_idx].is_thread_local
                {
                    // `_Thread_local` global: emit Op::TlsLea so
                    // the codegen lowers via the per-target TLS
                    // sequence (TPIDR_EL0 + offset on aarch64,
                    // fs:0 + offset on x86_64). The operand is the
                    // byte offset within the program's TLS block.
                    self.emit_op(Op::TlsLea);
                    self.emit_val(self.symbols[id_idx].val);
                } else if self.symbols[id_idx].class == Token::Glo as i64 {
                    self.emit_data_imm(self.symbols[id_idx].val);
                } else {
                    return Err(self
                        .compile_err(format!("undefined variable {}", self.symbols[id_idx].name)));
                }
                self.ty = self.symbols[id_idx].type_;
                let is_struct_value = is_struct_ty(self.ty) && struct_ptr_depth(self.ty) == 0;
                let is_array_var = self.symbols[id_idx].array_size > 0;
                // Array variables decay to a pointer to the first
                // element: the symbol's address IS its value, no
                // load. Bump the type by one pointer level so
                // downstream pointer arithmetic / indexing scales
                // correctly. Struct values follow the same
                // "address-as-value" rule but keep their type
                // because the `.field` operator needs the struct's
                // value type to look up offsets.
                if is_array_var {
                    self.ty += Ty::Ptr as i64;
                    // Stash the array's element count so a
                    // surrounding `sizeof(<arr>)` can compute
                    // `count * sizeof(elem)` instead of the
                    // decayed pointer's `sizeof(T*) = 8`.
                    self.last_array_decay_size = self.symbols[id_idx].array_size;
                    // N-dim-array decay: seed strides for each of
                    // the N-1 levels of multi-dim subscript. The
                    // first stride goes into `pending_index_stride`
                    // (consumed by the next Brak); the rest queue
                    // in `pending_index_strides_tail` and shift
                    // down per Brak.
                    let elem_ty = self.symbols[id_idx].type_;
                    let elem_size = self.size_of_type(elem_ty) as i64;
                    let dims = self.symbols[id_idx].array_dims.clone();
                    self.seed_multi_dim_strides(&dims, elem_size);
                } else if !is_struct_value {
                    // Pointers to structs and every scalar type go
                    // through the normal load_op_for path.
                    self.emit_op(load_op_for(self.ty, self.target));
                    // Seed the fn-pointer chain depth from
                    // the symbol's recorded indirection. emit_op
                    // just cleared the field; re-set it now so the
                    // surrounding unary-`*` chain can recognise
                    // function-pointer decay. `fn_ptr_indirection`
                    // is "indirection above fn-ptr, plus 1"; depth
                    // after the load is one less (the load itself
                    // consumed one indirection level).
                    let fpi = self.symbols[id_idx].fn_ptr_indirection;
                    if fpi > 0 {
                        self.fn_ptr_chain_depth = fpi - 1;
                    }
                    // N-dim-array parameter decay: a parameter
                    // declared as `T name[A][B][C]` carries
                    // `array_dims = [A, B, C]` on its symbol but
                    // the function-param binder wiped `array_size`
                    // to 0 (per C99 6.7.5.3p7 the outermost
                    // dimension decays to a pointer, and params
                    // don't own storage). The loaded value is
                    // already a pointer (one level less than the
                    // array would have been), so the pointee size
                    // is `pointee_size(self.ty)` rather than the
                    // element size; the strides for `[i]`, `[j]`,
                    // ... `[N-1]` are seeded into the pending
                    // queue.
                    let dims = self.symbols[id_idx].array_dims.clone();
                    if !dims.is_empty() && is_pointer_ty(self.ty) {
                        if dims[0] == 0 {
                            // Pointer-to-array variable
                            // (`T (*p)[M1][Mn]`): the declarator
                            // baked one Ptr per `Mi` into the
                            // symbol's type. Collapse those Ptrs so
                            // the surviving level is the single
                            // decayed-array pointer to the scalar
                            // element. Element size comes from the
                            // type at the bottom of the array Ptrs;
                            // the n-1 trailing Ptrs (one per Mi
                            // after the `*` itself) get peeled.
                            let array_ptrs = (dims.len() as i64) - 1;
                            let scalar_ty =
                                self.symbols[id_idx].type_ - (dims.len() as i64) * (Ty::Ptr as i64);
                            self.ty -= array_ptrs * (Ty::Ptr as i64);
                            let elem_size = self.size_of_type(scalar_ty) as i64;
                            self.seed_multi_dim_strides(&dims, elem_size);
                        } else {
                            let elem_size = self.pointee_size(self.ty);
                            self.seed_multi_dim_strides(&dims, elem_size);
                        }
                    }
                }
            }
        } else if self.lex.tk == '(' {
            self.next()?;
            if self.lex_is_type_start() {
                // C-style cast: `(<type>)expr`. Accepts int, char,
                // float, double, or struct base, with any number of
                // `*` markers and pointer-level qualifiers.
                t = self.parse_decl_base_type()?;
                // Fn-pointer lineage: if the base type came from a
                // typedef-of-fn-pointer, parse_decl_base_type seeded
                // `pending_fn_ptr_indirection`; the leading `*`s
                // below add directly to that count. The abstract
                // fn-ptr branch further down overrides this when a
                // `(*)(args)` shape is present in the cast.
                let mut cast_fpi = self.pending_fn_ptr_indirection.take();
                while self.lex.tk == Token::MulOp {
                    self.next()?;
                    t += Ty::Ptr as i64;
                    if let Some(fpi) = cast_fpi {
                        cast_fpi = Some(fpi + 1);
                    }
                    while self.lex.tk == Token::TypeQual {
                        self.next()?;
                    }
                }
                // Function-pointer cast inside a cast expression:
                // any abstract function-pointer declarator after
                // the base type. Common shapes:
                //   `(int (*)(args))expr`
                //   `(void (*)(void))expr`
                //   `(void(*(*)(args))(void))expr`  -- function
                //       returning function pointer
                // c5's type representation is base + pointer-level,
                // so we treat the entire abstract-declarator tail
                // as a no-op pointer level. Counted-parens scan
                // until the cast's outer `)` so even nested fp
                // shapes consume cleanly.
                if self.lex.tk == '(' {
                    let mut depth: i64 = 1;
                    self.next()?;
                    let mut nested_ptrs: i64 = 0;
                    while depth > 0 && self.lex.tk != 0 {
                        if self.lex.tk == '(' {
                            depth += 1;
                        } else if self.lex.tk == ')' {
                            depth -= 1;
                            if depth == 0 {
                                self.next()?;
                                break;
                            }
                        } else if self.lex.tk == Token::MulOp && depth == 1 {
                            nested_ptrs += 1;
                        }
                        self.next()?;
                    }
                    // C99 6.7.6 abstract declarators after the
                    // inner `)`: a `(args)` arg-list for the
                    // function-returning-fn shape OR a `[N]` /
                    // `[]` array suffix for the
                    // pointer-to-array shape (`T (*)[N]`). Both
                    // are no-ops at c5's type-tag granularity --
                    // the resulting type is the pointer level
                    // already accumulated. Multiple `[N]`
                    // suffixes (`T (*)[N][M]`) are absorbed too;
                    // they don't change the result type beyond
                    // what `nested_ptrs` already encodes.
                    if self.lex.tk == '(' {
                        self.next()?;
                        self.skip_balanced_parens_after_open()?;
                    }
                    while self.lex.tk == Token::Brak {
                        self.next()?;
                        if self.lex.tk == ']' {
                            self.next()?;
                        } else {
                            let _ = self.parse_constant_int()?;
                            if self.lex.tk == ']' {
                                self.next()?;
                            }
                        }
                    }
                    t += nested_ptrs * (Ty::Ptr as i64);
                    // Abstract fn-ptr declarator: the inner `*`
                    // count IS the indirection from the cast's
                    // result down to the fn-ptr rvalue, plus 1
                    // (matching `Symbol::fn_ptr_indirection`).
                    if nested_ptrs > 0 {
                        cast_fpi = Some(nested_ptrs);
                    }
                }
                if self.lex.tk == ')' {
                    self.next()?;
                } else {
                    return Err(self.compile_err("bad cast"));
                }
                self.expr(Token::Inc as i64)?;
                // FP-vs-int casts emit conversion ops so the bit
                // pattern in r13 is consistent with the new type.
                // Same-class casts (int<->ptr, float<->double) are
                // bit-pattern-compatible and need no conversion.
                let target_is_fp = is_floating_scalar(t);
                let source_is_fp = is_floating_scalar(self.ty);
                if target_is_fp && !source_is_fp {
                    self.emit_op(Op::Fcvtif);
                } else if !target_is_fp && source_is_fp {
                    self.emit_op(Op::Fcvtfi);
                } else if !target_is_fp
                    && !source_is_fp
                    && !is_pointer_ty(t)
                    && !is_pointer_ty(self.ty)
                {
                    // Cast to a non-pointer integer narrower than
                    // 8 bytes: re-extend the accumulator to the
                    // target storage width. c5 keeps every value
                    // sign- or zero-extended to 64 bits in the
                    // accumulator, so a cast that narrows in C99
                    // is otherwise invisible until the value lands
                    // in a typed slot.
                    //
                    // Unsigned target -> mask the high bits.
                    // Signed target  -> shift-left then arith-shift-
                    //                   right by (64 - width*8) so
                    //                   the high bit of the target
                    //                   propagates.
                    let target_size = self.size_of_type(t);
                    let source_size = self.size_of_type(self.ty);
                    if is_unsigned_ty(t) {
                        let mask: i64 = match target_size {
                            1 => 0xff,
                            2 => 0xffff,
                            4 => 0xffff_ffff,
                            _ => -1,
                        };
                        if mask != -1 {
                            self.emit_binop_with_imm(Op::And, mask);
                        }
                    } else if target_size == 1 || target_size == 2 || target_size == 4 {
                        // Signed cast: shift-pair to mask + sign-extend
                        // to the target storage width. Fires when:
                        //  * the cast genuinely narrows (target_size <
                        //    source_size) -- e.g. `(signed char)int_val`,
                        //  * source is unsigned at the same width as the
                        //    signed target -- the accumulator is zero-
                        //    extended, but `(signed char)(unsigned char)`
                        //    has to flip values >= 0x80 to negative per
                        //    C99 6.3.1.3.
                        // Skipped for same-width signed-to-signed casts
                        // (already correctly sign-extended in the
                        //  accumulator) and widening signed casts (the
                        //  source-side load did the extension).
                        let source_is_unsigned = is_unsigned_ty(self.ty);
                        let needs_extend = target_size < source_size
                            || (target_size == source_size && source_is_unsigned);
                        if needs_extend {
                            let bits = 64i64 - (target_size as i64) * 8;
                            self.emit_binop_with_imm(Op::Shl, bits);
                            self.emit_binop_with_imm(Op::Shr, bits);
                        }
                    }
                }
                self.ty = t;
                // Re-seed the fn-ptr chain depth from the
                // cast destination so a unary `*` chain that
                // follows a `(fn_t*)expr` cast (e.g.
                // `(**(finder_type*)pVfs->pAppData)(...)`) can
                // recognise the decay. The cast result lives
                // in `a`, so the depth is `cast_fpi - 1`.
                if let Some(fpi) = cast_fpi
                    && fpi > 0
                {
                    self.fn_ptr_chain_depth = fpi - 1;
                }
            } else {
                self.expr(Token::Assign as i64)?;
                // Comma operator within parens: `(a, b, c)` evaluates
                // each subexpression for its side effects and yields
                // the last. Outside parens, comma stays a separator
                // (function args, declarators) -- this branch only
                // fires inside `(...)` because expr(Assign) doesn't
                // consume `,`.
                while self.lex.tk == ',' {
                    self.next()?;
                    self.expr(Token::Assign as i64)?;
                }
                if self.lex.tk == ')' {
                    self.next()?;
                } else {
                    return Err(self.compile_err("close paren expected"));
                }
                // Forward the inner expr's exit snapshot into the
                // active multi-dim queue so the outer expression's
                // postfix can keep striding through, e.g.,
                // `(*p)[k]` on a pointer-to-array (the unary `*`
                // consumed one dim, the `[k]` should pick up the
                // next). Without this transfer the inner expr's
                // defensive clear strands the remaining strides.
                self.pending_index_stride = core::mem::take(&mut self.end_of_expr_stride);
                self.pending_index_strides_tail =
                    core::mem::take(&mut self.end_of_expr_strides_tail);
            }
        } else if self.lex.tk == Token::MulOp {
            self.next()?;
            // Stash whatever the surrounding scope had in the
            // "end-of-expr" capture slots so the recursive expr()
            // that parses our operand can populate them fresh.
            // After the parse, the new values tell us what
            // strides the operand left unconsumed -- the signal
            // we use to decide whether `*p` is a pointer-to-array
            // row deref. The outer snapshot is restored afterwards
            // so a containing operator's view isn't disturbed.
            let saved_eos_stride = core::mem::take(&mut self.end_of_expr_stride);
            let saved_eos_tail = core::mem::take(&mut self.end_of_expr_strides_tail);
            self.expr(Token::Inc as i64)?;
            let leftover_stride = core::mem::take(&mut self.end_of_expr_stride);
            let leftover_tail = core::mem::take(&mut self.end_of_expr_strides_tail);
            self.end_of_expr_stride = saved_eos_stride;
            self.end_of_expr_strides_tail = saved_eos_tail;
            // C function-pointer decay (6.3.2.1 / 6.3.4): `*` on
            // a function-pointer rvalue is a no-op -- it yields
            // back the same function pointer. The chain-depth
            // side-channel marks the operand as already at the
            // fn-ptr level, so we suppress the load and leave
            // both the type and the accumulator unchanged. Next
            // `*` keeps decaying; eventually the postfix `(`
            // call-site reads `a` as the function pointer.
            //
            // Without this branch the existing handler emits a
            // spurious `Li` that loads through the function
            // pointer's bit pattern, hits unmapped memory, and
            // SIGBUSes when called. The conservative pop in the
            // call-site path catches this only when the result
            // type drops to a non-pointer; if the function's
            // return type is itself a pointer (e.g. an
            // `io_methods *`-returning fn-ptr typedef)
            // the pop is short-circuited and the
            // garbage call target slips through.
            if self.fn_ptr_chain_depth == 0 {
                // Decay no-op. Keep depth at 0: the decayed
                // result is itself a fn-ptr rvalue, so any
                // further `*`s also decay.
                // Note: emit_op was not called, so the chain
                // depth is preserved (no clear happened).
            } else if leftover_stride > 0 {
                // Pointer-to-array operand: `*p` is the row
                // deref, equivalent to `p[0]`. The row's address
                // is already in `a` -- no load, no Ptr peel.
                // Consume the head stride (we just stepped over
                // one dim at index 0) and shift the rest into
                // the active queue so a following postfix `[k]`
                // strides correctly. Surface the row's byte
                // size via `last_array_decay_bytes` so an
                // enclosing `sizeof` recovers it.
                self.last_array_decay_bytes = leftover_stride;
                let mut tail = leftover_tail;
                self.pending_index_stride = if tail.is_empty() { 0 } else { tail.remove(0) };
                self.pending_index_strides_tail = tail;
            } else {
                if is_pointer_ty(self.ty) {
                    self.ty -= Ty::Ptr as i64;
                } else {
                    return Err(self.compile_err("bad dereference"));
                }
                // `*p` where `p` is a struct pointer yields a struct
                // *value*. c5 represents struct values address-as-
                // value: the address goes in `a`, no load. The next
                // op (`.field`, `= rhs` lowering Mcpy, etc.) reads
                // the address from `a` directly.
                let result_is_struct_value =
                    is_struct_ty(self.ty) && struct_ptr_depth(self.ty) == 0;
                if !result_is_struct_value {
                    let prior_depth = self.fn_ptr_chain_depth;
                    self.emit_op(load_op_for(self.ty, self.target));
                    // emit_op cleared the chain depth. Restore it
                    // one level deeper if the operand was tracked:
                    // a real deref consumes one level of indirection
                    // toward the fn-ptr. (-1 stays -1.)
                    if prior_depth > 0 {
                        self.fn_ptr_chain_depth = prior_depth - 1;
                    }
                }
            }
        } else if self.lex.tk == Token::AndOp {
            self.next()?;
            self.expr(Token::Inc as i64)?;
            // Order matters here: a struct-value rvalue (`p->mutex`
            // where `mutex` is a struct field, or `*p` where `p`
            // is a struct pointer) leaves the field's address in
            // `a` *without* emitting a trailing Li for the load
            // that produced the address. But the parser may still
            // have emitted an Li for *something earlier in the
            // chain* (e.g. the `Li` that loaded `p`'s value to
            // reach `p->mutex`). Popping that Li would unwind one
            // step too far and yield `&p` instead of `&p->mutex`.
            //
            // So check the resulting type *first*: if `&expr`
            // yields a struct value, the underlying address is
            // already in `a` and we leave the IR alone. Only the
            // remaining scalar / pointer-rvalue cases pop the
            // trailing load.
            if is_struct_ty(self.ty) && struct_ptr_depth(self.ty) == 0 {
                // Struct value -- the parser already left the
                // address in `a` (no final-load Li). `&s` just
                // raises the type by one pointer level; no IR
                // change needed.
            } else if self.pop_trailing_scalar_load() {
                // Scalar / pointer lvalue: dropped the trailing
                // load so what's left is the address-producing op.
            } else if is_pointer_ty(self.ty) {
                // Array-decay shape: `&arr` and `&pPager->dbFileVers`
                // when `dbFileVers` is a `char[16]` field. The
                // expression already yielded the array's address as
                // its rvalue (no Li was emitted), so `&` is a no-op
                // at the IR level; the type bump below tracks the
                // extra pointer level.
            } else {
                return Err(self.compile_err("bad address-of"));
            }
            self.ty += Ty::Ptr as i64;
            // `&` adds one pointer level toward the fn-ptr
            // for any chain we were tracking. -1 (untracked) stays
            // -1.
            if self.fn_ptr_chain_depth >= 0 {
                self.fn_ptr_chain_depth += 1;
            }
        } else if self.lex.tk == '!' {
            self.next()?;
            self.expr(Token::Inc as i64)?;
            self.emit_binop_with_imm(Op::Eq, 0);
            self.ty = Ty::Int as i64;
        } else if self.lex.tk == '~' {
            self.next()?;
            self.expr(Token::Inc as i64)?;
            self.emit_binop_with_imm(Op::Xor, -1);
            // C99 6.5.3.3: `~` applies integer promotions; the result
            // has the promoted operand's type. `unsigned char` /
            // `unsigned short` promote to signed `int`, so no mask.
            // `unsigned int` (size 4 unsigned that doesn't promote
            // down) stays unsigned int -- mask the high half back to
            // 32 bits so the register doesn't carry the
            // 0xFFFFFFFF.... high pattern from `XOR -1`.
            let operand_ty = self.ty;
            if is_unsigned_ty(operand_ty) && self.size_of_type(operand_ty) == 4 {
                self.emit_binop_with_imm(Op::And, 0xffff_ffff);
                self.ty = operand_ty;
            } else {
                self.ty = Ty::Int as i64;
            }
        } else if self.lex.tk == Token::AddOp {
            // Unary `+`: a no-op per C99 6.5.3.3p2. The operand's
            // type is preserved (subject to integer promotion for
            // sub-int integer operands -- a `(unsigned char)c`
            // promotes to `int`, which the `+` doesn't undo).
            // Critically, FP operands must keep their FP type --
            // otherwise `+0.5` poses as an integer and a later
            // `r + (+0.5)` lowers to `Op::Add` instead of `Op::Fadd`.
            self.next()?;
            self.expr(Token::Inc as i64)?;
            if !is_floating_scalar(self.ty) {
                self.ty = Ty::Int as i64;
            }
        } else if self.lex.tk == Token::SubOp {
            self.next()?;
            // Constant-fold `-<int-literal>` into `Imm -N`. Float
            // literals don't qualify -- we want Op::Fneg to apply
            // to the parsed f64 bit pattern, not a sign flip on the
            // integer-shaped operand.
            if self.lex.tk == Token::Num {
                self.emit_imm(-self.lex.ival);
                self.next()?;
                self.ty = Ty::Int as i64;
            } else {
                self.expr(Token::Inc as i64)?;
                if is_floating_scalar(self.ty) {
                    self.emit_op(Op::Fneg);
                    // self.ty already matches the operand's FP type
                } else {
                    self.emit_binop_with_imm(Op::Mul, -1);
                    self.ty = Ty::Int as i64;
                }
            }
        } else if self.lex.tk == Token::Inc || self.lex.tk == Token::Dec {
            t = self.lex.tk.raw();
            self.next()?;
            self.expr(Token::Inc as i64)?;
            let reload = self
                .rewrite_trailing_load_as_psh()
                .ok_or_else(|| self.compile_err("bad lvalue in pre-increment"))?;
            self.emit_op(reload);
            if is_floating_scalar(self.ty) {
                return Err(self.compile_err("floating-point ++/-- not yet implemented"));
            }
            self.emit_op(Op::Psh);
            self.emit_imm(self.pointee_step(self.ty));
            self.emit_op(if t == Token::Inc as i64 {
                Op::Add
            } else {
                Op::Sub
            });
            self.emit_op(store_op_for(self.ty, self.target));
        } else {
            // The parse-error message includes the enclosing function
            // name and (for `Token::Id`) the identifier name -- those
            // two facts make a parse error like a stuck macro
            // expansion tractable, vs. a generic "bad expression"
            // which is otherwise opaque.
            let func = self.current_function_name.clone();
            let id_suffix = if self.lex.tk == Token::Id {
                format!(" `{}`", self.symbols[self.lex.curr_id_idx].name)
            } else {
                String::new()
            };
            return Err(self.compile_err(format!(
                "bad expression: got {}{id_suffix} (in {func})",
                super::token::describe(self.lex.tk),
            )));
        }

        while self.lex.tk >= lev || self.lex.tk == '(' {
            t = self.ty;
            // The array-decay flag tracks the *trailing* decay so
            // `sizeof(arr)` recovers the real array size. Once
            // any further postfix / binop runs, the value is
            // consumed -- clear the flag so the decay doesn't
            // leak into a sizeof of an unrelated subexpression.
            self.last_array_decay_size = 0;
            self.last_array_decay_bytes = 0;
            if self.lex.tk == '(' {
                // Postfix indirect call: the expression so far put a
                // function-pointer value in `a`. Examples:
                //   `s.fp(args)` -- function-pointer struct field
                //   `arr[i](args)` -- function-pointer array element
                //   `(*fp)(args)` -- explicit dereference shape
                //   `(**fpp)(args)` -- dereference through a pointer
                //                       to a function-pointer variable
                // Direct identifier calls (`name(args)`) take the
                // dedicated path higher up that knows the symbol's
                // class and signature; that path consumes `(`
                // immediately and never reaches the Pratt loop.
                //
                // C's function-pointer-decay rule says `*fp` (where
                // `fp` is a function-pointer rvalue) is a no-op:
                // the dereferenced "function lvalue" auto-decays
                // back to a function pointer for any subsequent use.
                // The unary `*` handler emits an `Op::Li` regardless
                // -- it can't tell at parse time that the operand
                // will be called rather than loaded -- so the chain
                // ends one Li too deep, with `a` holding the first
                // 8 bytes of the callee's code instead of its
                // address. We undo that here: if `self.ty` says we
                // ended on a non-pointer (= the last `*` removed
                // the final pointer level) and the most recent emit
                // was an `Op::Li`, pop the Li and restore one
                // pointer level so the spill below sees the actual
                // function pointer.
                if !is_pointer_ty(self.ty) {
                    let last = self.text.last().copied();
                    let is_load = matches!(
                        last,
                        Some(x) if x == Op::Li as i64
                            || x == Op::Lc as i64
                            || x == Op::Lw as i64
                            || x == Op::Lwu as i64
                    );
                    if is_load {
                        self.text.pop();
                        self.source_lines.pop();
                        self.source_functions.pop();
                        self.source_file_indices.pop();
                        self.ty += Ty::Ptr as i64;
                    }
                }
                self.next()?;
                // Spill the FP into a fresh local temp via Op::StLocI.
                // The plain `Lea N; Si` shape can't express this
                // without losing `a` (Lea clobbers `a`), so the c5
                // dialect carries a dedicated store-local op for the
                // case where `a` already holds the value.
                self.loc_offs += 1;
                if self.loc_offs > self.max_loc_offs {
                    self.max_loc_offs = self.loc_offs;
                }
                let fp_temp = -self.loc_offs;
                self.emit_op(Op::StLocI);
                self.emit_val(fp_temp);
                // Each arg lands in its own temp slot first
                // (left-to-right eval), then we push them
                // right-to-left so the first arg ends up on top of
                // the c5 stack.
                let mut temp_offsets: Vec<i64> = Vec::new();
                let mut nargs: i64 = 0;
                while self.lex.tk != ')' {
                    self.loc_offs += 1;
                    if self.loc_offs > self.max_loc_offs {
                        self.max_loc_offs = self.loc_offs;
                    }
                    let temp_off = -self.loc_offs;
                    temp_offsets.push(temp_off);
                    self.emit_lea(temp_off);
                    self.emit_op(Op::Psh);
                    self.expr(Token::Assign as i64)?;
                    self.emit_op(Op::Si);
                    nargs += 1;
                    if self.lex.tk == ',' {
                        self.next()?;
                    }
                }
                self.next()?; // consume `)`
                for &temp_off in temp_offsets.iter().rev() {
                    self.emit_lea(temp_off);
                    self.emit_op(Op::Li);
                    self.emit_op(Op::Psh);
                }
                self.emit_lea(fp_temp);
                self.emit_op(Op::Li);
                self.emit_op(Op::Jsri);
                if nargs > 0 {
                    self.emit_op(Op::Adj);
                    self.emit_val(nargs);
                }
                // The dialect can't declare the return type of a
                // function pointer, so default to `int`. The actual
                // register value carries the full 8-byte return
                // regardless of the tag.
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::Assign {
                self.next()?;
                let lhs_is_struct_value = is_struct_ty(t) && struct_ptr_depth(t) == 0;
                if lhs_is_struct_value {
                    // Struct-to-struct copy. The LHS already left
                    // its address in `a`; push it so the RHS can
                    // produce the source address into `a`. Then
                    // emit Op::Mcpy with the byte size; the runtime
                    // (VM and both codegens) takes top-of-stack as
                    // dst, accumulator as src, and copies `size`
                    // bytes. Returns dst in `a` to mirror libc
                    // memcpy.
                    //
                    // This branch must run *before* the scalar Li/Lc
                    // rewrite below: for `*pItem = struct_rvalue`
                    // where pItem is a struct pointer, the deref
                    // elides the trailing struct-value load but
                    // leaves the pointer-load Li in place, so
                    // `last == Op::Li` would otherwise misroute us
                    // into the scalar path and rewrite the wrong Li
                    // into a Psh.
                    self.emit_op(Op::Psh);
                    self.expr(Token::Assign as i64)?;
                    if !is_struct_ty(self.ty) || struct_ptr_depth(self.ty) != 0 {
                        return Err(self.compile_err("cannot assign non-struct value to a struct"));
                    }
                    if t != self.ty {
                        let lhs_s = format_type(t, &self.structs);
                        let rhs_s = format_type(self.ty, &self.structs);
                        return Err(self.compile_err(format!(
                            "struct types differ on either side of `=` \
                             (lhs={lhs_s}, rhs={rhs_s})"
                        )));
                    }
                    let size = self.size_of_type(t);
                    self.emit_op(Op::Mcpy);
                    self.emit_val(size as i64);
                    self.ty = t;
                } else if self.rewrite_trailing_load_as_psh().is_some() {
                    // Scalar / pointer assignment: trailing load
                    // rewritten to a push so the address is
                    // preserved on the stack while the RHS evaluates.
                    let line = self.lex.line;
                    self.expr(Token::Assign as i64)?;
                    let rhs_is_zero = self.last_emit_is_zero();
                    let rhs_is_untyped = self.last_emit_was_indirect_call();
                    if let Some(reason) =
                        Self::type_warning_with_flags(t, self.ty, rhs_is_zero, rhs_is_untyped)
                    {
                        let lhs_s = format_type(t, &self.structs);
                        let rhs_s = format_type(self.ty, &self.structs);
                        self.warn_at(
                            line,
                            format!("{reason} in assignment (lhs={lhs_s}, rhs={rhs_s})"),
                        );
                    }
                    // C99 6.5.16.1p2 assignment conversion: when
                    // the lvalue is float / double and the rvalue
                    // is integer (or vice versa), bit-cast through
                    // the IEEE-754 conversion ops so the stored
                    // value matches the destination type's
                    // representation rather than the source's.
                    self.convert_assign_rhs(t);
                    self.ty = t;
                    self.emit_op(store_op_for(self.ty, self.target));
                } else {
                    return Err(self.compile_err("bad lvalue in assignment"));
                }
            } else if self.lex.tk == Token::AssignOp {
                // Compound assignment `a OP= b`. The lexer stuffed
                // the underlying binop's Token into `lex.ival`. The
                // shape mirrors plain `=`: rewrite the trailing
                // load (Op::Lc / Op::Li) into Op::Psh so the
                // address sits on the stack, then load it again
                // via Op::Li (or Op::Lc), push, evaluate the RHS,
                // emit the binop, and store. Only scalar / pointer
                // lvalues qualify -- structs and bitfields don't
                // accept compound assignment in c5.
                let binop = self.lex.ival;
                self.next()?;
                // Rewrite the trailing load into a Psh so the
                // address sits on the c5 stack across the compound
                // op; the helper hands back the matching reload op
                // so we can put the current value back into `a`
                // before pushing it for the binop's pop.
                let reload = self
                    .rewrite_trailing_load_as_psh()
                    .ok_or_else(|| self.compile_err("bad lvalue in compound assignment"))?;
                self.emit_op(reload);
                // Push the current value so the binop can pop it.
                self.emit_op(Op::Psh);
                // For pointer arithmetic with `+=` / `-=`, scale
                // the RHS by the element size before applying the
                // op. We capture lhs ty here; rhs ty is known after
                // expr().
                let lhs_ty = self.ty;
                self.expr(Token::Assign as i64)?;
                if (binop == Token::AddOp as i64 || binop == Token::SubOp as i64)
                    && is_pointer_ty(lhs_ty)
                    && !is_floating_scalar(lhs_ty)
                {
                    let elem_ty = lhs_ty - Ty::Ptr as i64;
                    let elem_size = self.size_of_type(elem_ty) as i64;
                    if elem_size > 1 {
                        self.emit_binop_with_imm(Op::Mul, elem_size);
                    }
                }
                // Floating-point lvalue (`double x; x *= 2.0;`) needs
                // the FP variant of the binop, not the integer one.
                // Without this, `x *= y` lowered to `Op::Mul` which
                // multiplied the bit patterns of the two doubles as
                // signed integers, producing a useless result. Same
                // shape applies to `+=` / `-=` / `/=` on doubles.
                let lhs_is_fp = is_floating_scalar(lhs_ty);
                // C99 6.5.16.2: a compound assignment is equivalent
                // to `E1 = (E1) OP (E2)` with E1 evaluated once. The
                // OP step is the same arithmetic step as the binary
                // operator, so when one side is FP we have to apply
                // the same int->FP lift the binary path uses --
                // otherwise `x *= -1` (FP lvalue, int rvalue) hands
                // the FP op a 64-bit signed `-1` and produces NaN
                // straight away. C99 6.5.16.2 specifies that the
                // arithmetic is performed in the type of `E1 op
                // E2` and the result is converted back to E1's
                // type, so an integer RHS must be widened to
                // double before the FP op runs.
                if lhs_is_fp || is_floating_scalar(self.ty) {
                    self.require_both_float(lhs_ty, "compound assign")?;
                }
                let op = match binop {
                    x if x == Token::AddOp as i64 => {
                        if lhs_is_fp {
                            Op::Fadd
                        } else {
                            Op::Add
                        }
                    }
                    x if x == Token::SubOp as i64 => {
                        if lhs_is_fp {
                            Op::Fsub
                        } else {
                            Op::Sub
                        }
                    }
                    x if x == Token::MulOp as i64 => {
                        if lhs_is_fp {
                            Op::Fmul
                        } else {
                            Op::Mul
                        }
                    }
                    x if x == Token::DivOp as i64 => {
                        if lhs_is_fp {
                            Op::Fdiv
                        } else if is_unsigned_ty(lhs_ty) {
                            Op::Divu
                        } else {
                            Op::Div
                        }
                    }
                    x if x == Token::ModOp as i64 => {
                        if is_unsigned_ty(lhs_ty) {
                            Op::Modu
                        } else {
                            Op::Mod
                        }
                    }
                    x if x == Token::AndOp as i64 => Op::And,
                    x if x == Token::OrOp as i64 => Op::Or,
                    x if x == Token::XorOp as i64 => Op::Xor,
                    x if x == Token::ShlOp as i64 => Op::Shl,
                    x if x == Token::ShrOp as i64 => {
                        if is_unsigned_ty(lhs_ty) {
                            Op::Shru
                        } else {
                            Op::Shr
                        }
                    }
                    _ => {
                        return Err(self.compile_err("unknown compound-assign opcode"));
                    }
                };
                self.emit_op(op);
                self.ty = lhs_ty;
                self.emit_op(store_op_for(self.ty, self.target));
            } else if self.lex.tk == Token::Cond {
                self.next()?;
                self.emit_op(Op::Bz);
                let b_else = self.text.len();
                self.emit_val(0);
                self.expr(Token::Assign as i64)?;
                // Comma operator in the middle of a ternary:
                // `cond ? (side_effect, value) : alt`. C allows
                // `e1, e2, ..., eN` in the ternary's then-arm
                // because the spec says it's an *expression*, not
                // an assignment-expression. expr(Assign) stops at
                // `,`; resume the chain here so the colon search
                // finds its match.
                while self.lex.tk == ',' {
                    self.next()?;
                    self.expr(Token::Assign as i64)?;
                }
                if self.lex.tk == ':' {
                    self.next()?;
                } else {
                    return Err(self.compile_err("conditional missing colon"));
                }
                let b_end_val = (self.text.len() + 2) as i64;
                self.text[b_else] = b_end_val;
                self.emit_op(Op::Jmp);
                let b_end = self.text.len();
                self.emit_val(0);
                self.expr(Token::Cond as i64)?;
                self.text[b_end] = self.text.len() as i64;
            } else if self.lex.tk == Token::Lor {
                self.next()?;
                self.emit_op(Op::Bnz);
                let b = self.text.len();
                self.emit_val(0);
                self.expr(Token::Lan as i64)?;
                self.text[b] = self.text.len() as i64;
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::Lan {
                self.next()?;
                self.emit_op(Op::Bz);
                let b = self.text.len();
                self.emit_val(0);
                self.expr(Token::OrOp as i64)?;
                self.text[b] = self.text.len() as i64;
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::OrOp {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::XorOp as i64)?;
                self.emit_op(Op::Or);
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::XorOp {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::AndOp as i64)?;
                self.emit_op(Op::Xor);
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::AndOp {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::EqOp as i64)?;
                self.emit_op(Op::And);
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::EqOp {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::LtOp as i64)?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, "==")?;
                    self.emit_op(Op::Feq);
                } else {
                    self.emit_eq_with_common_width(t, /*invert=*/ false);
                }
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::NeOp {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::LtOp as i64)?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, "!=")?;
                    self.emit_op(Op::Fne);
                } else {
                    self.emit_eq_with_common_width(t, /*invert=*/ true);
                }
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::LtOp {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::ShlOp as i64)?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, "<")?;
                    self.emit_op(Op::Flt);
                } else if is_unsigned_ty(usual_arith_common_ty(t, self.ty, self.target)) {
                    self.emit_op(Op::Ult);
                } else {
                    self.emit_op(Op::Lt);
                }
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::GtOp {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::ShlOp as i64)?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, ">")?;
                    self.emit_op(Op::Fgt);
                } else if is_unsigned_ty(usual_arith_common_ty(t, self.ty, self.target)) {
                    self.emit_op(Op::Ugt);
                } else {
                    self.emit_op(Op::Gt);
                }
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::LeOp {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::ShlOp as i64)?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, "<=")?;
                    self.emit_op(Op::Fle);
                } else if is_unsigned_ty(usual_arith_common_ty(t, self.ty, self.target)) {
                    self.emit_op(Op::Ule);
                } else {
                    self.emit_op(Op::Le);
                }
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::GeOp {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::ShlOp as i64)?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, ">=")?;
                    self.emit_op(Op::Fge);
                } else if is_unsigned_ty(usual_arith_common_ty(t, self.ty, self.target)) {
                    self.emit_op(Op::Uge);
                } else {
                    self.emit_op(Op::Ge);
                }
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::ShlOp {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::AddOp as i64)?;
                self.emit_op(Op::Shl);
                // C99 6.5.7: `E1 << E2` has the type of `E1` after
                // integer promotion. `char` / `short` (signed or
                // unsigned, size 1 or 2) promote to signed `int`.
                // Wider operands keep their type. For an unsigned
                // size-4 LHS the result needs a mask back to 32 bits
                // because bits shifted past bit 31 survive in the
                // 64-bit accumulator.
                let lhs_size = self.size_of_type(t);
                if lhs_size <= 2 {
                    self.ty = Ty::Int as i64;
                } else {
                    if is_unsigned_ty(t) && lhs_size == 4 {
                        self.emit_binop_with_imm(Op::And, 0xffff_ffff);
                    }
                    self.ty = t;
                }
            } else if self.lex.tk == Token::ShrOp {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::AddOp as i64)?;
                // Pick logical (Shru) for unsigned LHS, arithmetic (Shr) otherwise.
                // The RHS is the shift count; only the LHS sign matters.
                if is_unsigned_ty(t) {
                    self.emit_op(Op::Shru);
                    // Preserve LHS unsigned-ness so chained shifts/compares stay unsigned.
                    self.ty = t;
                } else {
                    self.emit_op(Op::Shr);
                    self.ty = Ty::Int as i64;
                }
            } else if self.lex.tk == Token::AddOp {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::MulOp as i64)?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, "+")?;
                    self.emit_op(Op::Fadd);
                    self.ty = fp_result_ty(t, self.ty);
                } else if !is_pointer_ty(t) && is_pointer_ty(self.ty) {
                    // `int + ptr`: result is the pointer type.
                    // When the pointee size is > 1, the int has to
                    // be scaled by it (it's currently on the c5
                    // stack, so spill the rhs ptr to a temp, lift
                    // the int into `a`, scale, push, reload, add).
                    // For unscaled pointee (`char *`, `void *`)
                    // the byte add is already correct -- we just
                    // need to set the result type to ptr.
                    let rhs_ty = self.ty;
                    if self.is_ptr_scaling_nontrivial(rhs_ty) {
                        let scale = self.pointee_size(rhs_ty);
                        self.loc_offs += 1;
                        if self.loc_offs > self.max_loc_offs {
                            self.max_loc_offs = self.loc_offs;
                        }
                        let rhs_temp = -self.loc_offs;
                        self.emit_op(Op::StLocI);
                        self.emit_val(rhs_temp);
                        // Pop the int LHS off the c5 stack into
                        // `a` via `Imm 0; Or` (Or pops stack-top).
                        self.emit_imm(0);
                        self.emit_op(Op::Or);
                        self.emit_binop_with_imm(Op::Mul, scale);
                        self.emit_op(Op::Psh);
                        self.emit_lea(rhs_temp);
                        self.emit_op(Op::Li);
                    }
                    self.emit_op(Op::Add);
                    self.ty = rhs_ty;
                } else {
                    let rhs_ty = self.ty;
                    if self.is_ptr_scaling_nontrivial(t) {
                        let scale = self.pointee_size(t);
                        self.emit_binop_with_imm(Op::Mul, scale);
                    }
                    self.emit_op(Op::Add);
                    if is_pointer_ty(t) {
                        self.ty = t;
                    } else {
                        self.maybe_mask_to_unsigned_width(t, rhs_ty);
                        self.ty = usual_arith_common_ty(t, rhs_ty, self.target);
                    }
                }
            } else if self.lex.tk == Token::SubOp {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::MulOp as i64)?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, "-")?;
                    self.emit_op(Op::Fsub);
                    self.ty = fp_result_ty(t, self.ty);
                } else if is_pointer_ty(t) && t == self.ty {
                    // ptr - ptr -> element count (Int). Divide by
                    // the pointee size to convert raw byte distance
                    // into element distance (skipped for `char*`,
                    // where byte and element counts coincide).
                    self.emit_op(Op::Sub);
                    if self.is_ptr_scaling_nontrivial(t) {
                        let scale = self.pointee_size(t);
                        self.emit_binop_with_imm(Op::Div, scale);
                    }
                    self.ty = Ty::Int as i64;
                } else if self.is_ptr_scaling_nontrivial(t) {
                    let scale = self.pointee_size(t);
                    self.emit_binop_with_imm(Op::Mul, scale);
                    self.emit_op(Op::Sub);
                    self.ty = t;
                } else {
                    let rhs_ty = self.ty;
                    self.emit_op(Op::Sub);
                    if is_pointer_ty(t) {
                        self.ty = t;
                    } else {
                        self.maybe_mask_to_unsigned_width(t, rhs_ty);
                        self.ty = usual_arith_common_ty(t, rhs_ty, self.target);
                    }
                }
            } else if self.lex.tk == Token::MulOp {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::Inc as i64)?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, "*")?;
                    self.emit_op(Op::Fmul);
                    self.ty = fp_result_ty(t, self.ty);
                } else {
                    let rhs_ty = self.ty;
                    self.emit_op(Op::Mul);
                    self.maybe_mask_to_unsigned_width(t, rhs_ty);
                    self.ty = usual_arith_common_ty(t, rhs_ty, self.target);
                }
            } else if self.lex.tk == Token::DivOp {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::Inc as i64)?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, "/")?;
                    self.emit_op(Op::Fdiv);
                    self.ty = fp_result_ty(t, self.ty);
                } else {
                    // C99 6.3.1.8: when either operand is unsigned, the
                    // common type is unsigned, so the divide is unsigned
                    // too. Route to Op::Divu (UDIV / DIV instead of
                    // SDIV / IDIV). When the common type is narrower
                    // than the 8-byte register, mix-of-signed-and-
                    // unsigned operands need C99 conversion to the
                    // unsigned width applied first -- otherwise a
                    // sign-extended `-1` enters the udiv as
                    // 0xFFFFFFFFFFFFFFFF instead of 0xFFFFFFFF.
                    let common = usual_arith_common_ty(t, self.ty, self.target);
                    if is_unsigned_ty(common) {
                        self.maybe_mask_operands_to_unsigned_common(t, self.ty);
                        self.emit_op(Op::Divu);
                    } else {
                        self.emit_op(Op::Div);
                    }
                    self.ty = common;
                }
            } else if self.lex.tk == Token::ModOp {
                self.next()?;
                if is_floating_scalar(t) {
                    return Err(self.compile_err("`%` is not defined on floating-point operands"));
                }
                self.emit_op(Op::Psh);
                self.expr(Token::Inc as i64)?;
                if is_floating_scalar(self.ty) {
                    return Err(self.compile_err("`%` is not defined on floating-point operands"));
                }
                let common = usual_arith_common_ty(t, self.ty, self.target);
                if is_unsigned_ty(common) {
                    self.maybe_mask_operands_to_unsigned_common(t, self.ty);
                    self.emit_op(Op::Modu);
                } else {
                    self.emit_op(Op::Mod);
                }
                self.ty = common;
            } else if self.lex.tk == Token::Inc || self.lex.tk == Token::Dec {
                let reload = self
                    .rewrite_trailing_load_as_psh()
                    .ok_or_else(|| self.compile_err("bad lvalue in post-increment"))?;
                self.emit_op(reload);
                if is_floating_scalar(self.ty) {
                    return Err(self.compile_err("floating-point ++/-- not yet implemented"));
                }
                self.emit_op(Op::Psh);
                self.emit_imm(self.pointee_step(self.ty));
                self.emit_op(if self.lex.tk == Token::Inc {
                    Op::Add
                } else {
                    Op::Sub
                });
                self.emit_op(store_op_for(self.ty, self.target));
                self.emit_op(Op::Psh);
                self.emit_imm(self.pointee_step(self.ty));
                self.emit_op(if self.lex.tk == Token::Inc {
                    Op::Sub
                } else {
                    Op::Add
                });
                self.next()?;
            } else if self.lex.tk == Token::Brak {
                self.next()?;
                // Read-and-park the multi-dim stride queue. The
                // identifier / param / field-decay branches seed
                // strides for each of the N-1 multi-dim subscript
                // levels of an N-dim array. The inner expr() that
                // parses the index expression clears the pending
                // state at its exit, so save the head + tail
                // locally, hand the inner parse a clean slate, and
                // shift the queue back after it returns.
                let multi_dim_stride = self.pending_index_stride;
                let saved_tail = core::mem::take(&mut self.pending_index_strides_tail);
                self.pending_index_stride = 0;
                self.emit_op(Op::Psh);
                self.expr(Token::Assign as i64)?;
                // Restore the queue and shift one level down so
                // the next `[i]` sees the stride for that level
                // in `pending_index_stride` and the rest in the
                // tail. While we still have strides queued, the
                // result type stays at pointer level so multi-dim
                // shape carries forward; the innermost subscript
                // (queue empty) falls through to the regular
                // sizeof + decay path.
                self.pending_index_strides_tail = saved_tail;
                self.pending_index_stride = if self.pending_index_strides_tail.is_empty() {
                    0
                } else {
                    self.pending_index_strides_tail.remove(0)
                };
                if self.lex.tk == ']' {
                    self.next()?;
                } else {
                    return Err(self.compile_err("close bracket expected"));
                }
                if !is_pointer_ty(t) {
                    return Err(self.compile_err("pointer type expected"));
                }
                if multi_dim_stride > 0 {
                    self.emit_binop_with_imm(Op::Mul, multi_dim_stride);
                    self.emit_op(Op::Add);
                    // Multi-dim row pointer -- ty stays at the same
                    // pointer level; the innermost `[k]` decays it
                    // the regular way to a scalar element.
                    self.ty = t;
                    // The subscript just produced one row of the
                    // remaining shape -- exactly `multi_dim_stride`
                    // bytes wide (the stride was computed as
                    // `elem_size * product(remaining_dims)`).
                    // Surface that byte count so an enclosing
                    // `sizeof` recovers the full row size instead
                    // of the decayed-pointer `sizeof(T*) = 8`. The
                    // size flows in raw bytes because the row may
                    // itself be multi-dim, which c5's type encoding
                    // can't represent as `count * sizeof(elem_ty)`.
                    // The next postfix iteration clears this flag
                    // at its top so it doesn't leak past the
                    // subscript.
                    self.last_array_decay_bytes = multi_dim_stride;
                } else {
                    if self.is_ptr_scaling_nontrivial(t) {
                        let scale = self.pointee_size(t);
                        self.emit_binop_with_imm(Op::Mul, scale);
                    }
                    self.emit_op(Op::Add);
                    self.ty = t - Ty::Ptr as i64;
                    // `xs[i]` where `xs` is a `struct Foo *` yields a
                    // struct value -- the address-as-value rule. Skip
                    // the load so the `.field` operator can apply the
                    // field offset to the just-computed element
                    // address. Scalar / pointer / nested-pointer
                    // element types still take the regular load.
                    let elem_is_struct_value =
                        is_struct_ty(self.ty) && struct_ptr_depth(self.ty) == 0;
                    if !elem_is_struct_value {
                        self.emit_op(load_op_for(self.ty, self.target));
                    }
                }
            } else if self.lex.tk == Token::Arrow || self.lex.tk == Token::Dot {
                // p->field / s.field. Both shapes resolve a struct
                // field offset and load the field. The difference is
                // upstream: `->` runs on a struct pointer (which the
                // preceding subexpression loaded into `a` via Op::Li),
                // while `.` runs on a struct value, where the parser
                // suppressed the load and `a` already holds the
                // struct's address.
                let is_dot = self.lex.tk == Token::Dot;
                let valid = if is_dot {
                    is_struct_ty(t) && struct_ptr_depth(t) == 0
                } else {
                    is_struct_ty(t) && struct_ptr_depth(t) == 1
                };
                if !valid {
                    let want = if is_dot {
                        "struct value"
                    } else {
                        "single-level struct pointer"
                    };
                    let op = if is_dot { "." } else { "->" };
                    return Err(self.compile_err(format!("{op} requires a {want}")));
                }
                self.next()?;
                if self.lex.tk != Token::Id {
                    let op = if is_dot { "." } else { "->" };
                    return Err(self.compile_err(format!("field name expected after {op}")));
                }
                let field_name = self.symbols[self.lex.curr_id_idx].name.clone();
                self.next()?;

                let sid = struct_id_of(t);
                let field = self.structs[sid]
                    .fields
                    .iter()
                    .find(|f| f.name == field_name)
                    .ok_or_else(|| {
                        self.compile_err(format!(
                            "struct {} has no field {}",
                            self.structs[sid].name, field_name
                        ))
                    })?
                    .clone();

                if field.offset > 0 {
                    self.emit_binop_with_imm(Op::Add, field.offset as i64);
                }
                self.ty = field.ty;

                if field.bit_width > 0 {
                    // Bitfield. Two shapes:
                    //   `s.f = expr`  -- emit a load-clear-or-store
                    //                    sequence that preserves the
                    //                    other bits in the storage
                    //                    unit.
                    //   anything else -- emit a `Li; Shr; And`
                    //                    extraction that lands the
                    //                    bitfield's value in `a` for
                    //                    the surrounding expression.
                    self.emit_bitfield_access(field.bit_offset, field.bit_width)?;
                } else {
                    // Trailing Lc/Li loads the field. The assignment handler
                    // (in the same loop) converts a trailing Li/Lc to Psh, so
                    // `p->x = value` and `s.x = value` work the same way as
                    // `*ptr = value`. Struct-typed fields get no load -- the
                    // address propagates so `s.inner.field` chains. Array
                    // fields decay to a pointer-to-element with the same
                    // address-as-value rule as a local array.
                    let field_is_struct_value =
                        is_struct_ty(self.ty) && struct_ptr_depth(self.ty) == 0;
                    if field.array_size > 0 {
                        self.ty += Ty::Ptr as i64;
                        // Stash the array's element count so an
                        // enclosing sizeof can recover the real
                        // size; otherwise `sizeof(s.field)` for a
                        // `T field[N]` returns 8 (decayed pointer)
                        // instead of `N * sizeof(T)`.
                        self.last_array_decay_size = field.array_size;
                        // N-dim-array decay: mirror the Id-path so
                        // `s.xs[i][j][k]` scales each level by its
                        // row stride and only the innermost
                        // subscript decays to a scalar.
                        let dims = field.array_dims.clone();
                        let elem_size = self.size_of_type(field.ty) as i64;
                        self.seed_multi_dim_strides(&dims, elem_size);
                    } else if !field_is_struct_value {
                        self.emit_op(load_op_for(self.ty, self.target));
                        // Pointer-to-array field (`T (*field)[M1]...[Mn]`):
                        // declarator stashed dims as `[0, M1, ...]`
                        // with a leading-0 sentinel, and bumped
                        // `field.ty` by one Ptr for the `*` plus
                        // one per trailing `[Mi]`. The Mi Ptrs are
                        // a positional record of the array shape,
                        // not real indirections -- collapse them
                        // here so the surviving Ptr is the single
                        // "decayed array pointer to scalar element"
                        // level. Without this, each subscript past
                        // the seeded multi-dim queue routes through
                        // `pointee_size` on a multi-level pointer
                        // and falls into the default-8 branch,
                        // mis-striding (and mis-sizing) by `8/elem`.
                        if field.array_dims.len() >= 2
                            && field.array_dims[0] == 0
                            && is_pointer_ty(self.ty)
                        {
                            let dims = field.array_dims.clone();
                            let array_ptrs = (dims.len() as i64) - 1;
                            let scalar_ty = field.ty - (dims.len() as i64) * (Ty::Ptr as i64);
                            self.ty -= array_ptrs * (Ty::Ptr as i64);
                            let elem_size = self.size_of_type(scalar_ty) as i64;
                            self.seed_multi_dim_strides(&dims, elem_size);
                        }
                    }
                }
            } else {
                return Err(self.compile_err(format!(
                    "compiler error: unexpected {}",
                    super::token::describe(self.lex.tk)
                )));
            }
        }
        // Multi-dim stride queue: set by the id-load / param /
        // field-decay branches when an N-dim array decays,
        // consumed by the Brak postfix. If we leave this expr()
        // without seeing every `[i]` -- e.g., the array was
        // passed to a function as a bare argument with `foo(arr)`
        // -- the queue must not leak to the next expression.
        // Otherwise the next array access in a fresh expression
        // would inherit a stale row stride and skip its scalar
        // load, leaving no lvalue for a following `=`.
        //
        // Snapshot what was still in the queue here so an outer
        // unary `*` -- which runs a recursive `expr()` to parse
        // its operand -- can tell whether that operand was a
        // pointer-to-array decay whose strides nothing consumed.
        // The snapshot is one operator deep: the next `expr()`
        // exit overwrites it.
        self.end_of_expr_stride = self.pending_index_stride;
        self.end_of_expr_strides_tail = core::mem::take(&mut self.pending_index_strides_tail);
        self.pending_index_stride = 0;
        Ok(())
    }

    /// Seed the multi-dim subscript stride queue for an N-dim
    /// array with element size `elem_size`. The first N-1
    /// dimensions each get a stride; the innermost subscript
    /// falls through to the regular `sizeof(elem)` path. For
    /// `T[A][B][C]` the strides are `[B*C*s, C*s]`. The head
    /// goes into `pending_index_stride`; the rest queue in
    /// `pending_index_strides_tail`. Empty `dims` or a 1D shape
    /// produces no stride hint at all.
    fn seed_multi_dim_strides(&mut self, dims: &[i64], elem_size: i64) {
        self.pending_index_stride = 0;
        self.pending_index_strides_tail.clear();
        if dims.len() < 2 || elem_size <= 0 {
            return;
        }
        // strides[k] = elem_size * product(dims[k+1..]) for k in 0..N-1.
        let n = dims.len();
        let mut strides: Vec<i64> = Vec::with_capacity(n - 1);
        let mut running: i64 = elem_size;
        // Build right-to-left: stride[N-2] = elem*dims[N-1],
        // stride[N-3] = stride[N-2]*dims[N-2], etc.
        for k in (0..n - 1).rev() {
            running = running.saturating_mul(dims[k + 1]);
            strides.push(running);
        }
        strides.reverse();
        if let Some((&head, tail)) = strides.split_first() {
            self.pending_index_stride = head;
            self.pending_index_strides_tail.extend_from_slice(tail);
        }
    }

    // The statement family (parse_for_stmt, parse_switch_stmt,
    // parse_block_typedef, parse_block_local_decl, parse_block_stmt,
    // stmt, consume) lives in `compiler/stmt.rs`.

    fn run_compile(&mut self) -> Result<(), C5Error> {
        self.next()?;
        while self.lex.tk != 0 {
            // C11 6.7.10 `_Static_assert(<expr>, "<msg>");` at
            // file scope -- consume the construct as a parse-time
            // assertion. Zero expression aborts compilation with
            // the message verbatim through the standard error path.
            if self.lex.tk == Token::StaticAssert {
                self.parse_static_assert()?;
                continue;
            }
            let mut bt = Ty::Int as i64;
            // Storage-class prefixes -- can appear in any order
            // and any combination before the type. C lets you
            // mix `static extern` (silly but legal in some
            // compilers) and `_Thread_local extern` (legal),
            // so we accept any ordering. `extern` and `static`
            // are no-ops in c5 (every symbol already has
            // internal linkage and there's no separate
            // translation-unit story); `_Thread_local` flips
            // the per-thread storage flag.
            let mut thread_local = false;
            let mut is_typedef = false;
            let mut saw_signed = false;
            let mut saw_unsigned = false;
            // Track `long` count and `short` separately from the
            // other int-modifiers so `typedef long long int u64;`
            // picks the 8-byte `Ty::LongLong`, `typedef long int
            // l;` picks `Ty::Long` (LP64 -> 8 bytes, LLP64 -> 4),
            // and `typedef short int s16;` picks `Ty::Short`,
            // instead of all falling through as 4-byte `Ty::Int`.
            let mut long_count: u8 = 0;
            let mut saw_short = false;
            let mut saw_int_mod = false;
            loop {
                if self.lex.tk == Token::ThreadLocal {
                    thread_local = true;
                    self.next()?;
                } else if self.lex.tk == Token::Typedef {
                    is_typedef = true;
                    self.next()?;
                } else if self.lex.tk == Token::Signed {
                    saw_signed = true;
                    saw_int_mod = true;
                    self.next()?;
                } else if self.lex.tk == Token::Unsigned {
                    saw_unsigned = true;
                    saw_int_mod = true;
                    self.next()?;
                } else if self.lex.tk == Token::Long {
                    long_count = long_count.saturating_add(1);
                    saw_int_mod = true;
                    self.next()?;
                } else if self.lex.tk == Token::Short {
                    saw_short = true;
                    saw_int_mod = true;
                    self.next()?;
                } else if self.lex.tk == Token::IntMod {
                    saw_int_mod = true;
                    self.next()?;
                } else if self.lex.tk == Token::Extern
                    || self.lex.tk == Token::Static
                    || is_decl_modifier(self.lex.tk)
                {
                    self.next()?;
                } else {
                    break;
                }
            }
            let saw_long = long_count >= 1;
            let saw_long_long = long_count >= 2;
            if self.lex.tk == Token::Int {
                self.next()?;
                // `long long int` -> Ty::LongLong; `long int` ->
                // Ty::Long; `short int` -> Ty::Short; bare `int`
                // -> Ty::Int. Mirror the dispatch in
                // `parse_decl_base_type`.
                let base = if saw_long_long {
                    Ty::LongLong as i64
                } else if saw_long {
                    Ty::Long as i64
                } else if saw_short {
                    Ty::Short as i64
                } else {
                    Ty::Int as i64
                };
                bt = if saw_unsigned {
                    base | UNSIGNED_BIT
                } else {
                    base
                };
            } else if self.lex.tk == Token::Void {
                self.next()?;
                // `void *foo` is the implicit "any pointer" type --
                // route through the char-pointer encoding so the
                // existing void-pointer arithmetic / conversions
                // keep working. Bare `void f();` carries
                // `Ty::Void` so the function-end emit knows to
                // zero the accumulator before `Op::Lev`.
                bt = if self.lex.tk == Token::MulOp {
                    Ty::Char as i64 | UNSIGNED_BIT
                } else {
                    Ty::Void as i64
                };
            } else if self.lex.tk == Token::Char {
                self.next()?;
                // `signed char` is a real 1-byte signed type; bare
                // `char` and `unsigned char` are unsigned. Mirror
                // parse_decl_base_type.
                bt = if saw_signed {
                    Ty::Char as i64
                } else {
                    Ty::Char as i64 | UNSIGNED_BIT
                };
            } else if self.lex.tk == Token::Float {
                self.next()?;
                bt = Ty::Float as i64;
            } else if self.lex.tk == Token::Double {
                self.next()?;
                bt = Ty::Double as i64;
            } else if self.lex.tk == Token::Enum {
                self.parse_enum_decl()?;
            } else if self.lex.tk == Token::Struct || self.lex.tk == Token::Union {
                // Aggregate (struct or union) declaration. Three
                // shapes:
                //   <kw> Name { ... };           -- definition only
                //   <kw> Name;                   -- forward declaration
                //   <kw> Name *p;                -- type use, declarators follow
                //   typedef <kw> Name {...} Name; -- definition + typedef alias
                let is_union = self.lex.tk == Token::Union;
                let kind = if is_union { "union" } else { "struct" };
                self.next()?;
                let name = if self.lex.tk == Token::Id {
                    let n = self.symbols[self.lex.curr_id_idx].name.clone();
                    self.next()?;
                    n
                } else if self.lex.tk == '{' {
                    // Anonymous: `typedef struct { ... } Foo;`. Synth
                    // a tag so the inner body can register and so
                    // the typedef-side declarator that follows still
                    // sees a struct type.
                    format!("__anon_{kind}_{}", self.structs.len())
                } else {
                    return Err(self.compile_err(format!("{kind} name or `{{` expected")));
                };

                if self.lex.tk == '{' {
                    let id = self.parse_aggregate_body(&name, is_union)?;
                    bt = struct_ty_for(id);
                } else {
                    let id = self.find_or_forward_declare_struct(&name);
                    bt = struct_ty_for(id);
                }
            } else if self.is_lex_typedef_name() {
                // Typedef-name as base type at file scope: `Foo bar;`
                // where `Foo` was bound by a prior `typedef`.
                bt = self.symbols[self.lex.curr_id_idx].type_;
                // Carry the typedef's fn-ptr lineage forward so a
                // declarator like `fn_t fp` (no leading `*`) still
                // gets `Symbol::fn_ptr_indirection = 1`. The
                // declarator itself, if it adds leading `*`s, will
                // bump this further before the symbol is bound.
                let typedef_fpi = self.symbols[self.lex.curr_id_idx].fn_ptr_indirection;
                if typedef_fpi > 0 {
                    self.pending_fn_ptr_indirection = Some(typedef_fpi);
                }
                self.next()?;
            } else if saw_int_mod {
                // Bare modifier(s) without an explicit type keyword:
                // `unsigned x;` / `short x;` / `long x;` /
                // `long long x;` (the implicit-int rule). Mirror
                // parse_decl_base_type's tail: `long long` ->
                // Ty::LongLong, `long` -> Ty::Long, `short` ->
                // Ty::Short.
                let base = if saw_long_long {
                    Ty::LongLong as i64
                } else if saw_long {
                    Ty::Long as i64
                } else if saw_short {
                    Ty::Short as i64
                } else {
                    Ty::Int as i64
                };
                bt = if saw_unsigned {
                    base | UNSIGNED_BIT
                } else {
                    base
                };
            }
            // Trailing qualifiers / int modifiers between the base
            // type and the declarators -- `Foo const *p`, `int long
            // x`, etc. The base type is already chosen; these are
            // pure no-ops in c5 but appear in real C source.
            while is_decl_modifier(self.lex.tk) {
                self.next()?;
            }

            while self.lex.tk != ';' && self.lex.tk != '}' {
                let (id_idx, ty, array_size) = self.parse_declarator(bt)?;
                // Pick up the fn-pointer indirection count
                // the declarator (or its typedef base type)
                // recorded, and store it on the symbol so a later
                // identifier load can seed the chain-depth tracker.
                let fn_ptr_indirection = self.pending_fn_ptr_indirection.take().unwrap_or(0);
                self.ty = ty;
                self.symbols[id_idx].array_size = array_size;
                if fn_ptr_indirection > 0 {
                    self.symbols[id_idx].fn_ptr_indirection = fn_ptr_indirection;
                }
                // Function-returning-FP shape: parse_declarator
                // already consumed the outer function's params.
                // Synthesize the function-definition path: bind the
                // symbol as Fun, install the captured params, then
                // proceed straight into the body (the next token is
                // `{`, not `(`).
                let preconsumed_params = self.pending_fn_params.take();

                // typedef branch: register a type alias and skip the
                // function / global storage path entirely. Re-declaring
                // an existing typedef with the same underlying type is
                // tolerated -- amalgamated translation units routinely
                // re-emit identical typedefs through several `#include`
                // paths -- but a clashing redefinition or a clash with
                // a non-typedef symbol is rejected.
                if is_typedef {
                    // C99 function-type typedef: `typedef RET NAME(args);`.
                    // The declarator stopped at NAME; the `(args)`
                    // that follows is the function's parameter
                    // list. Parse it and bind NAME as a function-
                    // pointer alias (fpi=1, type bumped by one
                    // Ptr) -- every real use is through `NAME cb`
                    // (decays to fn-ptr per C99 6.3.2.1p4) or
                    // `NAME *cb` (already fn-ptr), so the two
                    // spellings collapse to the same effective
                    // shape in c5's model.
                    //
                    // parse_function_params binds each named parameter
                    // as a Loc symbol (it's shared with function-decl
                    // parsing). For a typedef there's no body to put
                    // those locals into scope for, so we restore each
                    // param's shadowed binding right after.
                    let (typedef_ty, typedef_fpi, typedef_params) =
                        if self.lex.tk == '(' && preconsumed_params.is_none() {
                            self.next()?; // consume `(`
                            let pp = self.parse_function_params()?;
                            for &p in &pp.indices {
                                Self::restore_shadowed_symbol(&mut self.symbols[p]);
                            }
                            let fty = ty + Ty::Ptr as i64;
                            (fty, 1i64, Some(pp))
                        } else {
                            (ty, fn_ptr_indirection, None)
                        };
                    let prior_class = self.symbols[id_idx].class;
                    let prior_type = self.symbols[id_idx].type_;
                    if prior_class != 0 && prior_class != Token::Typedef as i64 {
                        return Err(self.compile_err(format!(
                            "typedef name `{}` clashes with prior non-typedef declaration",
                            self.symbols[id_idx].name
                        )));
                    }
                    if prior_class == Token::Typedef as i64 && prior_type != typedef_ty {
                        return Err(self.compile_err(format!(
                            "typedef `{}` redefined with a different type",
                            self.symbols[id_idx].name
                        )));
                    }
                    self.symbols[id_idx].class = Token::Typedef as i64;
                    self.symbols[id_idx].type_ = typedef_ty;
                    self.symbols[id_idx].val = 0;
                    if typedef_fpi > 0 {
                        self.symbols[id_idx].fn_ptr_indirection = typedef_fpi;
                    }
                    if let Some(pp) = typedef_params {
                        self.symbols[id_idx].params = pp.types;
                        self.symbols[id_idx].is_variadic = pp.is_variadic;
                    }
                    if self.lex.tk == ',' {
                        self.next()?;
                    }
                    continue;
                }

                // Sys-class predefined symbols (the per-target
                // header's libc bindings) are allowed to be
                // *re-declared* as prototypes -- the source uses the
                // declaration to teach the parser the type signature
                // without overriding the function's binding-driven
                // class/val. Function symbols with no body yet
                // (Token::Fun, val == 0) can also be re-declared
                // -- amalgamated translation units include the
                // same prototype many times. A second body for
                // the same Fun is still a real duplicate.
                let was_sys = self.symbols[id_idx].class == Token::Sys as i64;
                // Forward / repeat function declarations: allowed
                // either when the next token is `(` (the regular
                // `int foo(args)` shape) OR when parse_declarator
                // already consumed the outer params for the
                // function-returning-FP shape (tk is `;` or `{`
                // depending on prototype-vs-definition).
                let was_fwd_fun = self.symbols[id_idx].class == Token::Fun as i64
                    && (self.lex.tk == '(' || preconsumed_params.is_some());
                // Tentative-definition merge (C11 6.9.2): a prior
                // `static T x;` (no `=`) becomes the defining
                // declaration when re-declared, optionally with an
                // initializer this time. Function-shaped re-decls
                // never go through this path.
                let was_tentative_glo = self.symbols[id_idx].class == Token::Glo as i64
                    && !self.symbols[id_idx].has_initializer
                    && self.lex.tk != '(';
                if self.symbols[id_idx].class != 0 && !was_sys && !was_fwd_fun && !was_tentative_glo
                {
                    return Err(self.compile_err("duplicate global definition"));
                }
                // Snapshot the prior signature before overwriting
                // `type_` so the redeclaration-mismatch warnings
                // below have something to compare against.
                let prior_return_ty = self.symbols[id_idx].type_;
                let prior_params = self.symbols[id_idx].params.clone();
                let prior_is_variadic = self.symbols[id_idx].is_variadic;
                self.symbols[id_idx].type_ = ty;

                if self.lex.tk == '(' || preconsumed_params.is_some() {
                    if !was_sys {
                        self.symbols[id_idx].class = Token::Fun as i64;
                        // Leave `val` untouched. For a first-time
                        // prototype it stays at the Symbol default
                        // (0); calls before the body see that 0 as
                        // a placeholder, and `apply_fn_call_fixups`
                        // rewrites them once the body sets `val =
                        // ent_pc`. For a redeclaration after the
                        // body has been emitted, `val` already
                        // points at the real `ent_pc` and we must
                        // *not* clobber it -- a previous version
                        // of this code wrote `val = self.text.len()`
                        // whenever val was 0, which silently broke
                        // any function whose body legitimately
                        // started at PC 0.
                    }
                    // Only warn on user-vs-user redeclarations.
                    // Sys symbols (the per-target header's libc
                    // bindings) start out with stub signatures
                    // that the user's `<stdio.h>` etc. is *expected*
                    // to refine -- complaining about every printf
                    // / memcpy / fcntl in the standard library
                    // would drown real bugs.
                    let prior_was_known = was_fwd_fun;
                    let params = if let Some(pp) = preconsumed_params {
                        pp
                    } else {
                        self.next()?;
                        self.parse_function_params()?
                    };

                    // Stash the signature on the function symbol so
                    // call sites can type-check arguments later. For
                    // both prototypes and bodied definitions.
                    self.symbols[id_idx].params = params.types.clone();
                    self.symbols[id_idx].is_variadic = params.is_variadic;

                    // Warn if a redeclaration disagrees with the
                    // prior signature. C99 6.7p4 requires
                    // compatibility (same return type + same
                    // parameter list, modulo unprototyped forms);
                    // amalgamated translation units occasionally
                    // disagree by accident (a header was edited
                    // but one .c forgot to pick it up), which is
                    // a real bug worth surfacing -- but not one
                    // the c5 codegen is in a position to refuse,
                    // since it only has the redeclaration in scope.
                    // C99 6.7.5.3p14: an empty list in a non-defining
                    // function declarator means "no information about
                    // the number or types of the parameters is
                    // supplied" -- not a claim about a particular
                    // signature. Comparing such an unspecified-shape
                    // prototype against a fully-specified one isn't a
                    // mismatch under the standard, so we skip the
                    // parameter-list check when either side is empty.
                    // Two `static`-scope-but-amalgamated definitions
                    // that fully specify different parameters still
                    // warn, because both sides specify them.
                    let either_unspecified = prior_params.is_empty() || params.types.is_empty();
                    let return_differs = prior_return_ty != ty;
                    let variadic_differs = prior_is_variadic != params.is_variadic;
                    let params_differ = !either_unspecified && prior_params != params.types;
                    if prior_was_known && (return_differs || variadic_differs || params_differ) {
                        let name = self.symbols[id_idx].name.clone();
                        let line = self.lex.line;
                        let prior_sig = format_signature(
                            prior_return_ty,
                            &prior_params,
                            prior_is_variadic,
                            &self.structs,
                        );
                        let new_sig =
                            format_signature(ty, &params.types, params.is_variadic, &self.structs);
                        self.warn_at(
                            line,
                            format!(
                                "redeclaration of `{name}` differs from the previous \
                                 declaration\n  previous: {prior_sig}\n  now:      {new_sig}",
                            ),
                        );
                    }

                    // For Sys symbols (header-bound libc functions),
                    // also fold the variadic flag onto the matching
                    // `#pragma binding`. The native lowering reads it
                    // when it picks the variadic ABI dance (macOS
                    // arm64 stack-packing, SysV xor eax,eax) instead
                    // of asking the symbol table at codegen time --
                    // which has long since gone out of scope.
                    if was_sys {
                        let name = self.symbols[id_idx].name.clone();
                        let fixed = params.types.len();
                        let variadic = params.is_variadic;
                        // `ty` is the return type the parser extracted just
                        // above. Stash it so the codegen knows whether the
                        // libc call leaves a 32-bit value with junk in the
                        // upper half of the host return register (msvcrt
                        // `int` returns) and needs sign / zero extension
                        // before the result becomes the c5 accumulator.
                        let ret_ty = ty;
                        for spec in self.dylibs.iter_mut() {
                            for binding in spec.bindings.iter_mut() {
                                if binding.local_name == name {
                                    binding.is_variadic = variadic;
                                    binding.fixed_args = fixed;
                                    binding.return_type_tag = ret_ty;
                                    // Per-param types for the
                                    // DWARF subprogram DIE the codegen
                                    // emits over each PLT trampoline.
                                    // Without these, gdb shows
                                    // `in malloc ()` instead of
                                    // `in malloc (size=...)`.
                                    binding.param_types = params.types.clone();
                                }
                            }
                        }
                    }

                    if self.lex.tk == ';' {
                        // Forward declaration / prototype --
                        // `int foo(int a, ...);`. Restore the param
                        // symbols' outer class (parse_function_params
                        // marked them as `Loc`) so subsequent
                        // declarations of the same names don't trip
                        // the duplicate-global check.
                        for sym in self.symbols.iter_mut() {
                            if sym.class == Token::Loc as i64 {
                                Self::restore_shadowed_symbol(sym);
                            }
                        }
                        // Outer loop sees `;` and exits; `self.next()`
                        // after the loop consumes it.
                        if self.lex.tk == ',' {
                            self.next()?;
                        }
                        continue;
                    }

                    if was_sys {
                        return Err(self.compile_err(format!(
                            "cannot give a body to predefined library function `{}` \
                             (the per-target header's `#pragma binding` provides the \
                             implementation -- use a prototype only)",
                            self.symbols[id_idx].name
                        )));
                    }
                    if self.lex.tk != '{' {
                        return Err(self.compile_err("bad function definition"));
                    }
                    self.next()?;

                    // Track this function's declared return type
                    // so the `return s` lowering knows whether to
                    // emit a struct-copy through the hidden
                    // out-pointer.
                    let return_ty = self.symbols[id_idx].type_;
                    self.current_func_return_ty = return_ty;
                    self.current_function_name = self.symbols[id_idx].name.clone();
                    let returns_struct =
                        is_struct_ty(return_ty) && struct_ptr_depth(return_ty) == 0;

                    // c5 callers push args right-to-left (cdecl-style), so
                    // the i'th declared param ends up at `[bp + 16*(i+1)]`,
                    // i.e. val = i + 2: the first declared param is at the
                    // shallowest c5 stack slot, the last is deepest.
                    // Variadic args follow after the last declared, at
                    // val = N+2, N+3, ... -- which is what stdarg.h walks.
                    //
                    // Functions returning a struct value get a hidden
                    // out-pointer at val=2 (the caller pre-allocates a
                    // result temp and pushes its address as the first
                    // arg); declared params start at val=3 in that
                    // case. Variadic + struct-return aren't useful
                    // together so we don't bother optimising for it.
                    let param_base = if returns_struct { 3 } else { 2 };
                    for (i, &idx) in params.indices.iter().enumerate() {
                        self.symbols[idx].val = (i as i64) + param_base;
                    }

                    self.loc_offs = 0;
                    self.max_loc_offs = 0;
                    self.labels.clear();
                    self.unresolved_gotos.clear();
                    self.uses_alloca_in_current_fn = false;

                    let ent_pc = self.text.len();
                    // Now that the body is being emitted, point the
                    // symbol at the real `ent_pc`. Forward-declared
                    // callers embedded `0` (the prototype-time
                    // `text.len()`); the fixup pass at end of
                    // run_compile rewrites their operands to this
                    // post-body PC.
                    self.symbols[id_idx].val = ent_pc as i64;
                    self.emit_op(Op::Ent);
                    self.emit_val(0); // patched below
                    // Placeholder AllocaInit. If the function body
                    // emits any `Op::Intrinsic(Alloca)`, the
                    // function-end fixup pass writes the
                    // alloca-top slot index here. Otherwise the 0
                    // stays and codegen treats the op as a no-op.
                    self.emit_op(Op::AllocaInit);
                    self.alloca_init_operand_pc = self.text.len();
                    self.emit_val(0);

                    // Struct-value parameters: the caller pushed
                    // the struct's *address* into the param slot
                    // (matching the "address is the value" rule
                    // for struct rvalues). Without a copy the
                    // function body's `p.field = v` would land in
                    // the caller's storage, which isn't C
                    // by-value. Memcpy each struct param into a
                    // freshly allocated local and re-point the
                    // param's symbol so subsequent accesses inside
                    // the function go to the local copy. The
                    // sequence reuses Op::Mcpy so neither codegen
                    // needs new shapes for parameter passing.
                    for &idx in params.indices.iter() {
                        let pty = self.symbols[idx].type_;
                        if !is_struct_ty(pty) || struct_ptr_depth(pty) != 0 {
                            continue;
                        }
                        let slots = self.slots_of_type(pty);
                        let size = self.size_of_type(pty);
                        let param_val = self.symbols[idx].val;
                        self.loc_offs += slots;
                        let local_val = -self.loc_offs;
                        if self.loc_offs > self.max_loc_offs {
                            self.max_loc_offs = self.loc_offs;
                        }
                        // dst = &local
                        self.emit_lea(local_val);
                        self.emit_op(Op::Psh);
                        // src = *param_slot (the passed address;
                        // val from the param-base-aware
                        // numbering above)
                        self.emit_lea(param_val);
                        self.emit_op(Op::Li);
                        // Mcpy size
                        self.emit_op(Op::Mcpy);
                        self.emit_val(size as i64);
                        // The symbol now points at the local copy.
                        self.symbols[idx].val = local_val;
                    }

                    // C99 block-scope: declarations may appear
                    // anywhere a statement may. Each iteration
                    // either parses a local decl (with optional
                    // initializer) into the function's symbol
                    // frame, or parses a statement.
                    while self.lex.tk != '}' {
                        if self.lex.tk == Token::StaticAssert {
                            // C11 6.7.10 lets static_assert sit
                            // anywhere a declaration may appear,
                            // including the function-body top
                            // level (and the inner blocks reached
                            // through parse_block_stmt).
                            self.parse_static_assert()?;
                        } else if self.lex_is_type_start() {
                            self.parse_function_body_local_decl()?;
                        } else {
                            self.stmt()?;
                        }
                    }
                    // C99 6.8.6.4p3: a `void`-returning function's
                    // expression value is not a value. Zero the
                    // accumulator before the trailing synthetic
                    // `Op::Lev` so a caller that ignores the
                    // prototype sees `0` instead of stale register
                    // state. The matching `return;` statement
                    // emits the same prefix.
                    if self.current_func_return_ty == Ty::Void as i64 {
                        self.emit_op(Op::Imm);
                        self.emit_val(0);
                    }
                    self.emit_op(Op::Lev);
                    self.current_function_name.clear();

                    // Patch Ent's local-slot count. With alloca,
                    // bump it by 1 (the alloca-top bookkeeping
                    // slot) plus the fixed arena slot count so the
                    // prologue reserves the arena alongside the
                    // regular locals. The alloca-top slot sits at
                    // index `max_loc_offs + 1` (just below all
                    // regular locals); the arena occupies indices
                    // `[max_loc_offs + 2, max_loc_offs + 1 + ARENA_SLOTS]`.
                    let regular_locals = self.max_loc_offs.max(self.loc_offs);
                    if self.uses_alloca_in_current_fn {
                        let alloca_top_slot = regular_locals + 1;
                        self.text[ent_pc + 1] =
                            regular_locals + 1 + crate::c5::op::ALLOCA_ARENA_SLOTS;
                        self.text[self.alloca_init_operand_pc] = alloca_top_slot;
                    } else {
                        self.text[ent_pc + 1] = regular_locals;
                    }

                    for (name, pc) in &self.unresolved_gotos {
                        match self.labels.iter().find(|(n, _)| n == name) {
                            Some(&(_, target)) => self.text[*pc] = target as i64,
                            None => {
                                return Err(self.compile_err(format!("unresolved label: {}", name)));
                            }
                        }
                    }

                    // Snapshot the function's locals +
                    // formal parameters before `restore_shadowed_symbol`
                    // unwinds the bindings. The DWARF emitter groups
                    // these by `function_bc_pc` (the Ent's PC) and
                    // emits `DW_TAG_formal_parameter` /
                    // `DW_TAG_variable` DIEs as children of the
                    // matching subprogram, with `DW_OP_fbreg` locations
                    // derived from `fp_slot * 8`. Slots `0..2` cover
                    // the saved-x29 / saved-x30 area and don't
                    // correspond to a user-visible name; everything
                    // else is either a parameter (val >= 2) or a
                    // local (val < 0).
                    let param_set: alloc::collections::BTreeSet<usize> =
                        params.indices.iter().copied().collect();
                    for (i, sym) in self.symbols.iter().enumerate() {
                        if sym.class == Token::Loc as i64
                            && sym.val != 0
                            && sym.val != 1
                            && !sym.name.is_empty()
                        {
                            self.variables.push(crate::c5::program::VariableInfo {
                                function_bc_pc: ent_pc as u64,
                                name: sym.name.clone(),
                                type_tag: sym.type_,
                                fp_slot: sym.val,
                                is_parameter: param_set.contains(&i),
                            });
                        }
                    }
                    for sym in self.symbols.iter_mut() {
                        if sym.class == Token::Loc as i64 {
                            Self::restore_shadowed_symbol(sym);
                        }
                    }
                } else {
                    self.symbols[id_idx].class = Token::Glo as i64;
                    if !was_tentative_glo {
                        self.symbols[id_idx].is_thread_local = thread_local;
                    }
                    // Deferred-size array global: the dimension
                    // comes from the initializer and storage is
                    // reserved after parsing it. Disallow on TLS
                    // globals -- the per-target rebase ordering
                    // needs design work.
                    if array_size == -1 {
                        if self.lex.tk != Token::Assign {
                            return Err(self.compile_err(format!(
                                "array `{}` declared with empty brackets needs an initializer",
                                self.symbols[id_idx].name
                            )));
                        }
                        if thread_local {
                            return Err(self.compile_err(
                                "deferred-size `_Thread_local` arrays are not supported",
                            ));
                        }
                        self.next()?;
                        if is_struct_ty(ty) && struct_ptr_depth(ty) == 0 {
                            // `struct T xs[] = { {...}, {...}, ... };`
                            // Pre-scan the source to count elements so
                            // every element's storage is pre-reserved
                            // contiguously *before* any string literal
                            // inside an element gets appended to
                            // `self.data` and pushes subsequent
                            // elements to a non-contiguous offset.
                            let elem_size = self.size_of_type(ty);
                            if self.lex.tk != '{' {
                                return Err(
                                    self.compile_err("array initializer must start with `{{`")
                                );
                            }
                            let count = self.lex.count_top_level_groups_in_array() as i64;
                            self.next()?;
                            self.align_data_to_8();
                            let off = self.data.len() as i64;
                            self.symbols[id_idx].val = off;
                            for _ in 0..(count * elem_size as i64) {
                                self.data.push(0);
                            }
                            let sid = struct_id_of(ty);
                            let mut i: i64 = 0;
                            while self.lex.tk != '}' {
                                if i >= count {
                                    return Err(self.compile_err(format!("struct array element count miscount (parser scanned {count}, parsed past)")));
                                }
                                let here = off + i * elem_size as i64;
                                if self.lex.tk == '{' {
                                    self.collect_struct_initializer(sid, here)?;
                                } else {
                                    return Err(self
                                        .compile_err("struct array element must be a brace list"));
                                }
                                i += 1;
                                if self.lex.tk == ',' {
                                    self.next()?;
                                }
                            }
                            self.next()?; // consume `}`
                            self.symbols[id_idx].array_size = count;
                            // Pad data to 8-byte alignment so the next
                            // global doesn't land on an odd offset.
                            while !self.data.len().is_multiple_of(8) {
                                self.data.push(0);
                            }
                            self.symbols[id_idx].has_initializer = true;
                            if self.lex.tk == ',' {
                                self.next()?;
                            }
                            continue;
                        }
                        self.pending_init_inner_dim = self.symbols[id_idx].inner_array_size;
                        let elements = self.collect_array_initializer(ty)?;
                        let final_size = elements.len() as i64;
                        self.symbols[id_idx].array_size = final_size;
                        let total_bytes = (self.size_of_type(ty) as i64) * final_size;
                        let aligned = ((total_bytes + 7) / 8) * 8;
                        // On a tentative-merge path the prior
                        // declaration would have had no `[]` either
                        // (deferred size cannot be a re-decl), so
                        // always allocate fresh storage here.
                        if self.size_of_type(ty) > 1 {
                            self.align_data_to_8();
                        }
                        let off = self.data.len() as i64;
                        self.symbols[id_idx].val = off;
                        for _ in 0..aligned {
                            self.data.push(0);
                        }
                        self.write_array_init_into_data(off, ty, &elements);
                        self.symbols[id_idx].has_initializer = true;
                    } else {
                        let bytes = if array_size > 0 {
                            let total = (self.size_of_type(ty) as i64) * array_size;
                            ((total + 7) / 8) * 8
                        } else {
                            self.slots_of_type(ty) * 8
                        };
                        // Tentative-merge: reuse the storage that was
                        // already allocated for the prior declaration.
                        // The initializer (if any) writes into the
                        // existing slot. Mismatched array sizes between
                        // the prior tentative and the new defining
                        // declaration aren't merged here -- the prior
                        // allocation would be too small or too large.
                        let var_offset = if was_tentative_glo {
                            self.symbols[id_idx].val
                        } else if thread_local {
                            let off = self.tls_data.len() as i64;
                            self.symbols[id_idx].val = off;
                            for _ in 0..bytes {
                                self.tls_data.push(0);
                            }
                            off
                        } else {
                            if self.size_of_type(ty) > 1 {
                                self.align_data_to_8();
                            }
                            let off = self.data.len() as i64;
                            self.symbols[id_idx].val = off;
                            for _ in 0..bytes {
                                self.data.push(0);
                            }
                            off
                        };

                        // Optional initializer. For non-arrays, the
                        // restricted constant-expression path
                        // (parse_global_initializer) handles
                        // integer / NULL / address-of-global. For
                        // known-size arrays, a string literal or a
                        // brace list populates the leading bytes;
                        // the rest stays zero (the allocation
                        // pre-zeroed self.data). For struct-value
                        // globals, a `{ ... }` brace list with
                        // designators or positional entries
                        // populates per-field; unspecified fields
                        // stay zero.
                        if self.lex.tk == Token::Assign {
                            self.next()?;
                            if array_size > 0 && is_struct_ty(ty) && struct_ptr_depth(ty) == 0 {
                                if thread_local {
                                    return Err(self.compile_err(
                                        "array `_Thread_local` initialisers are not supported",
                                    ));
                                }
                                // Known-size struct array: write each
                                // brace-list element into the pre-
                                // allocated slot. Missing trailing
                                // entries stay zero-init.
                                let elem_size = self.size_of_type(ty);
                                let sid = struct_id_of(ty);
                                if self.lex.tk != '{' {
                                    return Err(
                                        self.compile_err("array initializer must start with `{{`")
                                    );
                                }
                                self.next()?;
                                let mut idx: i64 = 0;
                                while self.lex.tk != '}' {
                                    if idx >= array_size {
                                        return Err(self.compile_err(format!(
                                            "too many initializers for `{}`",
                                            self.symbols[id_idx].name
                                        )));
                                    }
                                    let here = var_offset + idx * elem_size as i64;
                                    if self.lex.tk == '{' {
                                        self.collect_struct_initializer(sid, here)?;
                                    } else {
                                        return Err(self.compile_err(
                                            "struct array element must be a brace list",
                                        ));
                                    }
                                    idx += 1;
                                    if self.lex.tk == ',' {
                                        self.next()?;
                                    }
                                }
                                self.next()?; // consume `}`
                            } else if array_size > 0 {
                                if thread_local {
                                    return Err(self.compile_err(
                                        "array `_Thread_local` initialisers are not supported",
                                    ));
                                }
                                self.pending_init_inner_dim = self.symbols[id_idx].inner_array_size;
                                let elements = self.collect_array_initializer(ty)?;
                                if elements.len() > array_size as usize {
                                    return Err(self.compile_err(format!(
                                        "too many initializers for array `{}` ({} > {})",
                                        self.symbols[id_idx].name,
                                        elements.len(),
                                        array_size
                                    )));
                                }
                                self.write_array_init_into_data(var_offset, ty, &elements);
                            } else if is_struct_ty(ty) && struct_ptr_depth(ty) == 0 {
                                if thread_local {
                                    return Err(self.compile_err(
                                        "struct `_Thread_local` initialisers are not supported",
                                    ));
                                }
                                let sid = struct_id_of(ty);
                                self.collect_struct_initializer(sid, var_offset)?;
                            } else {
                                self.parse_global_initializer(ty, var_offset, thread_local)?;
                            }
                            self.symbols[id_idx].has_initializer = true;
                        }
                    }
                }
                if self.lex.tk == ',' {
                    self.next()?;
                }
            }
            self.next()?;
        }
        Ok(())
    }
}
