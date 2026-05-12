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
use super::token::Token;

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
mod run_compile;
mod sizeof_expr;
mod stmt;
mod type_layout;
pub(crate) mod types;

use types::{is_floating_scalar, is_pointer_ty};

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

/// Optional preprocessor / driver knobs threaded through compiler
/// construction. Everything here has a sensible default (empty
/// vectors, empty label, tracing off); only callers that need to
/// pass `-D` / `-I` / `-include` / `-H` flags or a real source
/// filename for diagnostics have to fill any of these in.
///
/// Builder-style methods (`with_defines`, `with_undefines`,
/// `with_include_paths`, `with_force_includes`, `with_source_label`,
/// `with_show_includes`) return `self` so the typical CLI shape is
/// `CompileOptions::default().with_defines(d).with_include_paths(p)`.
#[derive(Default, Debug, Clone)]
pub struct CompileOptions {
    /// `-D name[=body]` predefines installed before the source
    /// runs through the preprocessor.
    pub defines: Vec<(String, String)>,
    /// `-U name` -- names removed from the predefines table.
    pub undefines: Vec<String>,
    /// `-I path` -- filesystem search paths probed before the
    /// bundled in-binary headers on `#include`.
    pub include_paths: Vec<String>,
    /// `-include FILE` -- headers force-included before the source.
    pub force_includes: Vec<String>,
    /// Filename string used in compiler diagnostics
    /// (`<file>:<line>: error: ...`). Empty for library / fixture
    /// callers; the preprocessor then falls back to the historical
    /// `<source>` placeholder.
    pub source_label: String,
    /// `-H` / `--show-includes` -- when true the preprocessor
    /// pushes one line per `#include` resolve into the include
    /// trace, drainable via [`Compiler::take_include_trace`].
    pub show_includes: bool,
}

impl CompileOptions {
    /// Replace the `-D` predefine list.
    pub fn with_defines(mut self, defines: Vec<(String, String)>) -> Self {
        self.defines = defines;
        self
    }
    /// Replace the `-U` undefine list.
    pub fn with_undefines(mut self, undefines: Vec<String>) -> Self {
        self.undefines = undefines;
        self
    }
    /// Replace the `-I` include-search-path list.
    pub fn with_include_paths(mut self, include_paths: Vec<String>) -> Self {
        self.include_paths = include_paths;
        self
    }
    /// Replace the `-include FILE` force-include list.
    pub fn with_force_includes(mut self, force_includes: Vec<String>) -> Self {
        self.force_includes = force_includes;
        self
    }
    /// Set the source-file label used in diagnostics.
    pub fn with_source_label(mut self, label: impl Into<String>) -> Self {
        self.source_label = label.into();
        self
    }
    /// Flip the gcc-style `-H` include trace on or off.
    pub fn with_show_includes(mut self, on: bool) -> Self {
        self.show_includes = on;
        self
    }
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

    /// Construct a compiler for a specific native target with all
    /// driver options left at their defaults.
    pub fn with_target(source: String, target: Target) -> Self {
        Self::with_options(source, target, CompileOptions::default())
    }

    /// Drain the gcc `-H`-shape include trace produced by the
    /// preprocessor. Empty when constructed without
    /// `CompileOptions::with_show_includes(true)`. The CLI calls
    /// this after `compile()` and dumps the list to stderr;
    /// library callers can do the same.
    pub fn take_include_trace(&mut self) -> Vec<String> {
        core::mem::take(&mut self.include_trace)
    }

    /// Construct a compiler with the full set of preprocessor /
    /// driver knobs bundled into a [`CompileOptions`] struct.
    /// This is the single shared implementation behind every
    /// `Compiler::new` and `Compiler::with_target` callable;
    /// callers that need `-D` / `-I` / `-include` / source-label
    /// / `-H` flags reach for this directly.
    ///
    /// Preprocessor failures (unterminated `#if`, duplicate
    /// `#else`, ...) are stored on the struct and surfaced when
    /// [`Self::compile`] runs -- this keeps the construction API
    /// infallible so the `Compiler::new(src).compile()` shape
    /// every existing caller uses keeps working.
    pub fn with_options(source: String, target: Target, opts: CompileOptions) -> Self {
        // Run the preprocessor first so we know the
        // `#pragma binding(...)` set before seeding the symbol
        // table. The bindings come from whichever standard headers
        // the source `#include`s (or doesn't); a fixture that needs
        // `printf` but skips `<stdio.h>` will fail with a clear
        // "no `#pragma binding(... ::printf, ...)` is in scope"
        // error out of the codegen's import resolver, not a
        // mysterious link-time mismatch.
        let mut pp = Preprocessor::new(target.id_str(), target, env!("CARGO_PKG_VERSION"));
        pp.set_source_label(&opts.source_label);
        pp.set_show_includes(opts.show_includes);
        for path in &opts.include_paths {
            pp.add_search_path(path);
        }
        for name in &opts.force_includes {
            pp.add_force_include(name);
        }
        for (name, body) in &opts.defines {
            pp.define(name, body);
        }
        for name in &opts.undefines {
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

    /// Resolve the bytecode PCs for the program entry point
    /// (`main` or the `#pragma entrypoint(<name>)` override) and
    /// for an optional user-defined `DllMain`.
    ///
    /// `main` is optional today: shared-library output
    /// (`OutputKind::SharedLibrary`) doesn't need an entry point,
    /// and the executable-output writer surfaces a clear error if
    /// `entry_pc` doesn't land on real code. When neither `main`,
    /// any `#pragma export(...)`, nor a user-defined `DllMain` is
    /// present we still refuse, since the result would be an
    /// image with no callable entries at all.
    ///
    /// `#pragma entrypoint(<name>)` overrides the canonical
    /// `main`. The override goes through the same symbol-table
    /// lookup so the diagnostic is uniform: a missing entrypoint
    /// always reads `<name>() not defined`.
    ///
    /// A user-defined `DllMain` (any source-level function with
    /// that exact name) overrides the boilerplate `mov eax, 1;
    /// ret` DllMain stub the PE shared-library writer otherwise
    /// emits. We record the bytecode PC here unconditionally --
    /// the VM / JIT / non-PE writers ignore it, and the PE writer
    /// only consults it for `--shared` builds. No signature
    /// validation: c5 trusts user `main` the same way and DllMain
    /// is just a different ABI.
    fn resolve_entry_and_dllmain_pcs(&self) -> Result<(usize, Option<usize>), C5Error> {
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
                return Err(self.compile_err(format!("{entry_name_str}() not defined")));
            }
        };
        let dllmain_pc =
            dllmain_idx.and_then(|idx| has_user_dllmain.then(|| self.symbols[idx].val as usize));
        Ok((entry_pc, dllmain_pc))
    }

    /// Resolve `#pragma export(<name>)` directives against the
    /// now-finalised symbol table. Each name must resolve to a
    /// `Token::Fun` (a function defined in this translation
    /// unit); anything else gets a clear diagnostic so a
    /// misspelled export doesn't silently produce a shared object
    /// missing the symbol the user expected.
    ///
    /// Drains `self.pending_exports` -- callers should only invoke
    /// once on the way out of `compile()`.
    fn resolve_exports(&mut self) -> Result<Vec<crate::c5::program::ExportedFunction>, C5Error> {
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
        Ok(exports)
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
        let (entry_pc, dllmain_pc) = self.resolve_entry_and_dllmain_pcs()?;
        let exports = self.resolve_exports()?;
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
}
