use alloc::format;
use alloc::string::String;
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
mod call_fixups;
mod const_expr;
mod control_flow;
mod convert;
mod decl_base;
mod declarator;
mod diag;
mod emit;
mod enum_decl;
mod expr;
mod function;
mod global_init;
mod initializer;
mod locals;
mod sizeof_expr;
mod stmt;
mod type_layout;
pub(crate) mod types;

use types::{
    UNSIGNED_BIT, format_signature, is_decl_modifier, is_floating_scalar, is_pointer_ty,
    is_struct_ty, struct_id_of, struct_ptr_depth,
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

    /// True while parsing the body of a function whose declared
    /// return type was bare `void`. Drives two emit decisions:
    ///   * the trailing synthetic `Op::Lev` prepends `Op::Imm 0`
    ///     so a caller that misclassifies the prototype reads
    ///     `0` rather than stale accumulator bits (C99 6.8.6.4p3
    ///     -- a `void` callee produces no value).
    ///   * a `return;` statement emits the same `Imm 0` prefix
    ///     before `Op::Lev`; a `return <expr>;` is rejected
    ///     (C99 6.8.6.4p1 constraint violation).
    /// Set at function-body entry from the function's symbol
    /// (`Symbol::returns_void`), cleared at exit.
    current_func_returns_void: bool,

    /// Side channel from the base-type parsers
    /// (`parse_decl_base_type`, the inline base-type loop in
    /// `run_compile`, and `parse_aggregate_body`) to the
    /// function-decl path: set to `true` when the just-consumed
    /// base spelled bare `void`, `false` otherwise. The type
    /// encoding itself collapses both `void` and `char` to
    /// `Ty::Char | UNSIGNED_BIT` (so `void *` arithmetic,
    /// sizeof, struct-field layout, and function-pointer
    /// encoding stay byte-identical to the legacy void-as-char
    /// behavior); the void-ness is carried out-of-band here.
    /// Cleared at the start of every base-type parse and
    /// consumed by the function-decl path right after
    /// `parse_declarator` returns -- `returns_void` on the
    /// function's symbol is set when the flag is true *and* the
    /// declarator added no leading `*`s (so `void (*fp)(...)`
    /// and `void *p` don't trip the void-return path).
    pending_base_was_void: bool,

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
            current_func_returns_void: false,
            pending_base_was_void: false,
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

    /// Compile the source. On success, the returned `Program` contains the
    /// bytecode, the static data segment, and the PC of `main`.
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
            // Reset the bare-`void` side channel for this
            // declaration. Set further down if the base-type loop
            // matches `Token::Void`; consumed by the function-decl
            // path to mark `Symbol::returns_void`.
            self.pending_base_was_void = false;
            // Storage-class prefixes -- can appear in any order
            // and any combination before the type. C lets you
            // mix `static extern` (silly but legal in some
            // compilers) and `_Thread_local extern` (legal),
            // so we accept any ordering. `extern` and `static`
            // are no-ops in c5 (every symbol already has
            // internal linkage and there's no separate
            // translation-unit story); `_Thread_local` flips
            // the per-thread storage flag. The int-modifier
            // soup (`signed`, `unsigned`, `short`, `long*`,
            // `_Bool`) flows through the shared `IntModifiers`
            // accumulator so `parse_decl_base_type` and the
            // file-scope path interpret it identically.
            let mut thread_local = false;
            let mut is_typedef = false;
            let mut m = decl_base::IntModifiers::default();
            loop {
                if self.lex.tk == Token::ThreadLocal {
                    thread_local = true;
                    self.next()?;
                } else if self.lex.tk == Token::Typedef {
                    is_typedef = true;
                    self.next()?;
                } else if self.try_consume_int_modifier(&mut m)? {
                    // Consumed an int modifier; the helper already
                    // advanced the lexer.
                } else if self.lex.tk == Token::Extern
                    || self.lex.tk == Token::Static
                    || is_decl_modifier(self.lex.tk)
                {
                    self.next()?;
                } else {
                    break;
                }
            }
            if self.lex.tk == Token::Int {
                self.next()?;
                bt = m.int_base();
            } else if self.lex.tk == Token::Char {
                self.next()?;
                bt = m.char_tag();
            } else if self.lex.tk == Token::Void {
                self.next()?;
                // Bare `void` shares the `unsigned char` encoding
                // (so void-pointer arithmetic / sizeof / fn-ptr
                // tables stay identical to the legacy
                // void-as-char path). The void-ness is captured
                // out-of-band via `pending_base_was_void`, which
                // the function-decl path consumes below to set
                // `Symbol::returns_void`.
                self.pending_base_was_void = true;
                bt = Ty::Char as i64 | UNSIGNED_BIT;
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
                bt = self.parse_aggregate_base_type()?;
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
            } else if m.saw_int_mod {
                // Bare modifier(s) without an explicit type keyword:
                // `unsigned x;` / `short x;` / `long x;` /
                // `long long x;` (the implicit-int rule).
                bt = m.int_base();
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
                // Carry the bare-`void` side channel onto the
                // declarator. `pending_base_was_void` was set if
                // the base type spelled `void`; it stays valid
                // for the FIRST declarator in a comma-separated
                // group only -- subsequent ones see the flag
                // and would mis-fire if the declarator added
                // pointer levels in between. Gate on
                // "no leading `*` added" by checking that the
                // declarator's returned `ty` still equals the
                // bare-void encoding. Any declarator that bumped
                // `ty` by `Ty::Ptr` falls out.
                let declarator_is_bare_void =
                    self.pending_base_was_void && ty == (Ty::Char as i64 | UNSIGNED_BIT);
                // Consume the flag so the next iteration of the
                // declarator loop (`void *a, b;`) doesn't
                // re-trigger on a different declarator's shape.
                self.pending_base_was_void = false;
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
                    // Carry the bare-`void` return marker onto the
                    // symbol so the body-emit path zeroes the
                    // accumulator before `Op::Lev`, and so a
                    // future call-site check can reject value-
                    // context use of a void callee. Prototypes
                    // pick it up too -- a later body that
                    // re-declares with a different bare-void-ness
                    // is itself a C99 6.7p4 redecl violation
                    // covered by the parameter-list check above.
                    if declarator_is_bare_void {
                        self.symbols[id_idx].returns_void = true;
                    }

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
                    self.current_func_returns_void = self.symbols[id_idx].returns_void;
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

                    // `float` parameters get the same "rebind to a
                    // freshly allocated local" treatment as struct
                    // by-value params, but for a different reason:
                    // c5's call ABI passes every arg as an 8-byte
                    // c5-stack slot holding the value's `f64::to_bits`
                    // (the caller's `expr` left an `f64` in the
                    // accumulator and `Si` wrote all 8 bytes). With
                    // `sizeof(float) == 4`, the matching `Op::Lf`
                    // load that the body would emit reads only the
                    // *low* 4 bytes of the slot, which for a typical
                    // `double`-shaped bit pattern is the *low* half
                    // of the mantissa -- garbage, not the f32 of the
                    // passed value. The fix: at function entry,
                    // narrow each `float`-typed param through the
                    // `Op::Sf` store path (`Li` reads the caller's
                    // 8-byte f64 bits, `Sf` narrows to f32 and
                    // writes 4 bytes into a fresh local slot). The
                    // symbol is repointed to that local; every
                    // subsequent body access goes through the
                    // narrow-storage path the rest of the
                    // float-typed code expects, and the load/store
                    // semantics stay consistent.
                    for &idx in params.indices.iter() {
                        let pty = self.symbols[idx].type_ & !UNSIGNED_BIT;
                        if pty != Ty::Float as i64 {
                            continue;
                        }
                        let param_val = self.symbols[idx].val;
                        self.loc_offs += 1; // float local takes 1 slot
                        let local_val = -self.loc_offs;
                        if self.loc_offs > self.max_loc_offs {
                            self.max_loc_offs = self.loc_offs;
                        }
                        // dst = &local
                        self.emit_lea(local_val);
                        self.emit_op(Op::Psh);
                        // Load the caller-pushed f64::to_bits from
                        // the param slot. The full 8-byte load is
                        // intentional -- the caller pushed 8 bytes
                        // and the f32 information lives across all
                        // 8 of them (as an f64).
                        self.emit_lea(param_val);
                        self.emit_op(Op::Li);
                        // Narrow to f32 + write 4 bytes to the local.
                        // The rounding is round-to-nearest-ties-to-
                        // even, matching `f64 as f32` in Rust and
                        // `cvtsd2ss` / `fcvt s, d` on the JIT path.
                        self.emit_op(Op::Sf);
                        // Symbol now points at the f32-storage local.
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
                    // C99 6.8.6.4p3: a `void`-returning function
                    // doesn't produce a value. Zero the accumulator
                    // before the trailing synthetic `Op::Lev` so a
                    // caller that misclassifies the prototype (or
                    // invokes the function through a typed
                    // function-pointer table whose slot was set
                    // from a value-returning cast) reads `0`
                    // instead of whatever the function body
                    // happened to leave in the accumulator.
                    if self.current_func_returns_void {
                        self.emit_op(Op::Imm);
                        self.emit_val(0);
                    }
                    self.emit_op(Op::Lev);
                    self.current_function_name.clear();
                    self.current_func_returns_void = false;

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
