use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

use super::CODE_BASE;
use super::codegen::Target;
use super::error::C5Error;
use super::lexer::{self, Lexer};
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
pub(crate) use type_layout::{StructReturnAbi, host_abi_agg_desc, struct_return_abi};
pub(crate) mod types;

/// Captured enum tag + constants for DWARF emission. C99 6.7.2.2
/// enums collapse to `int` in c5 -- the tag carries no semantic
/// weight at the type level -- but preserving the (name, value)
/// pairs lets the DWARF emitter produce DW_TAG_enumeration_type
/// + DW_TAG_enumerator children so `(gdb) ptype enum Tag` works.
/// Anonymous enums (no tag) skip emission; their constants stay
/// reachable through plain integer DW_AT_const_value lookups in
/// the symbol table.
#[derive(Debug, Clone)]
pub struct EnumDef {
    pub name: String,
    pub constants: Vec<(String, i64)>,
}

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
    /// Bit offset within the storage unit. Meaningful only when
    /// `bit_width > 0`.
    pub bit_offset: u32,
    /// Bit width of a bitfield, or 0 for a regular field. Bitfields
    /// pack into shared storage units sized by their base type
    /// (C99 6.7.2.1p11); reads emit a load-shift-mask sequence and
    /// writes emit a load-clear-shift-or-store sequence keyed by
    /// `bit_unit_size`.
    pub bit_width: u32,
    /// Storage-unit size in bytes (1, 2, 4, or 8). Picks the
    /// matching `Lc/Lh/Lw/Li` and `Sc/Sh/Sw/Si` opcodes for the
    /// bitfield read / write so a 32-bit-base bitfield does not
    /// load eight bytes (which would mix in adjacent fields).
    /// Meaningful only when `bit_width > 0`; 0 otherwise.
    pub bit_unit_size: u8,
    /// Function-pointer lineage tag (mirrors
    /// `Symbol::fn_ptr_indirection`). 0 for non-fn-ptr fields;
    /// `n >= 1` for fields whose value, after `n - 1` derefs, is
    /// the fn-pointer rvalue. `Symbol::fn_ptr_indirection`'s
    /// convention: 1 means the field IS the fn-pointer, 2 means
    /// it's a pointer-to-fn-pointer, etc. The post-load handler
    /// in member access seeds `pending.fn_ptr_chain_depth` from
    /// this so a following unary `*` recognises the C99 6.3.2.1
    /// function-to-pointer no-op decay instead of emitting a
    /// spurious `Li` that loads through code memory.
    pub fn_ptr_indirection: i64,
    /// Parameter type tags of a function-pointer field, captured from
    /// the field declarator's prototype (mirrors `Symbol::params`).
    /// Empty for a non-function-pointer field or one declared without a
    /// prototype. A `s.fp(args)` / `s->fp(args)` call reads this to
    /// narrow each argument to its declared parameter type (C99
    /// 6.5.2.2p7), matching the direct-identifier and array-element
    /// call paths.
    pub params: Vec<i64>,
    /// True when the function-pointer field's prototype is variadic
    /// (`int (*fp)(int, ...)`). Mirrors `Symbol::is_variadic`. A
    /// `s.fp(args)` / `s->fp(args)` call reads this with `params` to
    /// split the argument list at the fixed-parameter count for the host
    /// variadic ABI. False for a non-function-pointer field or a
    /// non-variadic prototype.
    pub is_variadic: bool,
    /// Non-zero for a field promoted from an anonymous union (C11
    /// 6.7.2.1p13). All members of one anonymous union share the same
    /// value; the same id groups them so a brace-list initializer
    /// treats the whole union as a single positional sub-object
    /// (C99 6.7.8: one initializer fills the first member). Zero for a
    /// regular field and for anonymous-struct members, which keep
    /// distinct positions.
    pub anon_union_group: u32,
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
    /// `-Wdead-store` -- when true the compiler emits a
    /// per-store `dead store: value assigned to ...` diagnostic
    /// alongside the per-symbol `unused variable` / `set but
    /// never used` warnings. Off by default, matching gcc and
    /// clang's policy of shipping only the per-symbol form on by
    /// default.
    pub warn_dead_store: bool,
    /// When true, [`Compiler::compile`] returns
    /// `Program { entry_pc: 0, entry_name: None, .. }`
    /// instead of erroring out on a missing `main` /
    /// `wmain` / `WinMain` / `wWinMain`. Set for `-c`
    /// builds where the resulting Program is fed to the
    /// relocatable codegen (no `_start` stub, no entry-point
    /// requirement -- the linker picks the entry once it
    /// merges every TU).
    pub no_entry_point: bool,
    /// When true, every non-static function defined in this unit is
    /// exported in addition to any named by `#pragma export`. Set for
    /// `--shared` builds so a runtime `dlopen` consumer can `dlsym` the
    /// module's entry points without source-level export pragmas,
    /// matching the default visibility of a system toolchain's shared
    /// library.
    pub export_all_functions: bool,
    /// `--gnu` -- when true the preprocessor defines the GCC identity
    /// macros (`__GNUC__` and the rest, via
    /// [`Preprocessor::enable_gnu`]). Off by default: badc implements
    /// most but not all of the GNU C surface, so it claims `__GNUC__`
    /// only when the caller opts in.
    pub gnu: bool,
}

impl CompileOptions {
    /// Enable the `--gnu` GCC identity predefines.
    pub fn with_gnu(mut self, gnu: bool) -> Self {
        self.gnu = gnu;
        self
    }
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
    /// Enable per-store dead-store diagnostics. See
    /// [`Self::warn_dead_store`].
    pub fn with_warn_dead_store(mut self, on: bool) -> Self {
        self.warn_dead_store = on;
        self
    }
    /// Export every non-static function. See
    /// [`Self::export_all_functions`].
    pub fn with_export_all_functions(mut self, on: bool) -> Self {
        self.export_all_functions = on;
        self
    }
    /// Drop the "must define main" requirement. Returns a
    /// `Program` with `entry_pc = 0` / `entry_name = None`
    /// when no entry function is defined, instead of erroring.
    /// Used by the relocatable `-c` path where the entry is a
    /// link-time decision.
    pub fn with_no_entry_point(mut self, on: bool) -> Self {
        self.no_entry_point = on;
        self
    }
}

/// Ephemeral side-channel state passed between parser layers --
/// the "stuff a deeper parse needs to relay back to its caller
/// without bloating its return type." Groups the
/// declarator-handoff flags, the multi-dim subscript stride
/// queue, the array-decay sizeof recovery channel, and the
/// function-pointer chain-depth tracker into one carrier so the
/// `Compiler` field list reads as "lexer + symbols + codegen
/// output + transient state" instead of eleven loose fields.
#[derive(Debug)]
pub(in crate::c5::compiler) struct Pending {
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
    /// declarator added no leading `*`s.
    pub base_was_void: bool,

    /// Side channel from `parse_decl_base_type` to the function-
    /// prototype path: the base type was spelled `long double`,
    /// not bare `double`. Cleared at the start of every base-type
    /// parse. The function-decl path consumes this when stamping
    /// a libc binding so the codegen knows to read the return
    /// value out of x87 `st(0)` on SysV x86_64 (long-double libc
    /// returns) instead of XMM0 (which carries double / float).
    /// The encoded type stays `Ty::Double` for storage so the
    /// rest of the compiler treats the value as an 8-byte double;
    /// the distinction is libc-ABI-only.
    pub base_was_long_double: bool,

    /// Side channel from `parse_declarator` to `run_compile`: when
    /// the declarator's nested-paren branch encounters a "function
    /// returning function pointer" shape (`T (*name(args1))(args2)`),
    /// it parses `args1` via `parse_function_params` and stashes
    /// them here so the caller can bind `name` as a function and
    /// continue with the body. `args2` is consumed as a no-op via
    /// the trailing-decoration loop. None when the declarator
    /// wasn't this shape.
    pub fn_params: Option<function::ParsedParams>,

    /// Side channel from `parse_declarator` to its caller: when
    /// the declarator was function-pointer-shaped, this is the
    /// number of pointer levels between the resulting variable's
    /// loaded value and the underlying fn-pointer rvalue, plus 1
    /// (matching `Symbol::fn_ptr_indirection`'s convention).
    /// `None` when the declarator wasn't fn-pointer-shaped, so
    /// the caller doesn't have to clear a stale value before
    /// each parse. The caller takes() the value when binding the
    /// symbol.
    pub fn_ptr_indirection: Option<i64>,

    /// Set when the base type of the declarator currently being parsed
    /// came from a function-TYPE typedef (`typedef RET F(args)`), so the
    /// declarator absorbs the first `*` (it forms the pointer-to-function
    /// the typedef already half-encodes). Consumed and cleared by
    /// `parse_declarator`.
    pub base_is_function_type: bool,

    /// Set by `parse_declarator` when the declared identifier has a bare
    /// function type: the base came from a function-TYPE typedef and no
    /// pointer level was added (`F name`, not `F *name`). Per C99 6.9.1 such
    /// an identifier is a function declaration, not a function-pointer object.
    /// Read once by the file-scope declaration path.
    pub bare_function_type_declarator: bool,

    /// Override stride for the next `[i]` postfix index. When we
    /// load the address of a 2D-array variable (`T xs[N][M]`),
    /// the first subscript should scale the index by
    /// `M * sizeof(T)`, not `sizeof(T)`. The expr() identifier
    /// branch sets this to `inner_array_size * sizeof(elem)` on a
    /// 2D-array decay; the Brak postfix handler reads-and-clears
    /// it before falling back to the regular pointer-arithmetic
    /// stride. Zero means "use the regular stride."
    pub index_stride: i64,

    /// Strides for the *remaining* subscript levels of an N-dim
    /// array (N >= 3), beyond the first one held in
    /// `index_stride`. For `T xs[A][B][C]` after the
    /// `xs` decay the levels are: first = `B*C*sizeof(T)`
    /// (in `index_stride`), then `C*sizeof(T)` (in this
    /// vec), then the regular `sizeof(T)` fall-through. Each
    /// Brak postfix consumes one stride and shifts the rest
    /// down. Empty means "no further multi-dim strides queued."
    pub index_strides_tail: Vec<i64>,

    /// Snapshot of the multi-dim stride queue taken at the bottom
    /// of every `expr()` -- just before the defensive clear
    /// runs. Lets an outer operator that ran a recursive `expr()`
    /// (notably unary `*` on a pointer-to-array operand)
    /// recover what the inner parse seeded but nothing
    /// consumed. Reset to zero on the next `expr()` exit, so
    /// the inspector window is one operator deep.
    pub end_of_expr_stride: i64,
    pub end_of_expr_strides_tail: Vec<i64>,

    /// Inner dimensions (below the outermost) for the next
    /// `collect_array_initializer` call, outermost first. Set by
    /// callers from the declarator's `array_dims[1..]` so a nested
    /// `{ ... }` at each level can be zero-padded to the element count
    /// its sub-array spans (the product of the dimensions below it),
    /// keeping every level on the right stride for N-dim arrays. Empty
    /// means "flatten without padding" (1D arrays, struct-array
    /// initializers that own their layout). The collector reads-and-
    /// clears this on entry and reinstates the tail before recursing
    /// into a nested brace.
    pub init_inner_dims: alloc::vec::Vec<i64>,

    /// Target array bound for the next `collect_array_initializer`
    /// call. Set by callers that know the declarator's `[N]` so
    /// the string-literal branch can drop the trailing NUL when
    /// the literal would otherwise overflow by exactly one byte
    /// per C99 6.7.8p14. Zero means "no bound" (deferred-size
    /// array). Read-and-cleared on entry.
    pub init_target_array_size: i64,

    /// Set whenever the most recent `expr()` step ended with an
    /// array-decay-to-pointer (a bare array variable, or a
    /// struct field whose declared shape is `T xs[N]`). Carries
    /// the array's element count so `sizeof(<expr>)` can return
    /// `array_size * sizeof(elem)` instead of the decayed
    /// pointer's `sizeof(T*) = 8`. Cleared at the top of every
    /// `expr()` call so a previous decay doesn't leak into an
    /// unrelated sizeof.
    /// Side channel from the base-type parsers to the declarator-
    /// binding sites: when the base type was a typedef whose
    /// alias resolved to an array, this carries the typedef's
    /// element count so the bound declarator can inherit the
    /// array-ness. C99 6.7.7 paragraph 3: a typedef name
    /// "denotes the same type" as its aliased type, including
    /// the array length. Cleared by every base-type parse
    /// (`0` means "not from an array typedef").
    pub typedef_base_array_size: i64,
    /// Binding-site carrier for a function-pointer typedef's
    /// prototype: `Some((fixed_param_count, is_variadic))` when the
    /// base type was a typedef whose alias is a function-pointer
    /// type. A variable declared `fn_ptr_t cb` inherits the
    /// callee's variadic-ness and named-parameter count so an
    /// indirect call through `cb` can split its arguments into the
    /// fixed register prefix and the variadic stack tail (the macOS
    /// arm64 variadic ABI). `None` for non-fn-pointer base types.
    /// Cleared by every base-type parse.
    pub typedef_fn_proto: Option<(usize, bool)>,
    /// The pointed-to function's parameter type tags, captured by the
    /// fn-pointer declarator alongside `typedef_fn_proto`. Lets an
    /// indirect call narrow each argument to its declared parameter type
    /// instead of applying the default argument promotions. `None` when
    /// the prototype carries no types (an empty parameter list).
    pub fn_ptr_param_types: Option<alloc::vec::Vec<i64>>,
    /// Parameter type tags of the function pointer that an in-progress
    /// postfix indirect call (`tbl[i](args)`, `(*fp)(args)`) will call.
    /// The flat type tag in the accumulator carries only the callee's
    /// return type, not its parameter list, so this side-channel ferries
    /// the parameters from the producing symbol (a function-pointer array
    /// element or a dereferenced function-pointer variable) to the call's
    /// argument loop, which narrows each argument to its declared type
    /// (C99 6.5.2.2p7) the same way the direct-identifier call path does.
    /// Set at the array-decay and identifier-load sites, preserved across
    /// a subscript index parse, cleared at a `.`/`->` field access and at
    /// each statement boundary so it cannot reach an unrelated call.
    pub indirect_callee_params: Option<alloc::vec::Vec<i64>>,
    /// True when the indirect callee whose parameter types are held in
    /// `indirect_callee_params` is variadic. Threaded alongside the
    /// parameter list so an indirect variadic call recovers the
    /// pre-ellipsis (fixed) argument count and places the variadic tail
    /// per the host variadic ABI (C99 6.5.2.2; the macOS/AAPCS64 Darwin
    /// variant passes the tail on the stack). Set and cleared at the same
    /// sites as `indirect_callee_params`.
    pub indirect_callee_is_variadic: bool,
    /// Set while parsing a function-pointer declarator's parameter list.
    /// The parameters form a prototype: their names are irrelevant, so
    /// `parse_function_params` records each type without binding the name
    /// (a named parameter that shadows an enclosing function's parameter --
    /// a callback type nested in another prototype -- must not trip the
    /// duplicate-parameter check).
    pub parsing_fn_ptr_proto: bool,
    /// Set by `parse_function_params` immediately before the per-parameter
    /// `parse_declarator` call and taken (cleared) at the top of that call,
    /// so it applies only to the parameter's own declarator and not to any
    /// nested one. In parameter position a function-typed declarator
    /// `RET (name)(args)` decays to a pointer to function (C99 6.7.5.3p8),
    /// the same as `RET (*name)(args)`.
    pub param_decl_context: bool,
    pub last_array_decay_size: i64,

    /// Companion to `last_array_decay_size` for cases where the
    /// row's byte size is known directly but its shape can't be
    /// reduced to a single `count * sizeof(elem_ty)` pair --
    /// concretely, multi-dim subscripts of a pointer-to-array
    /// like `T (*p)[A][B]; sizeof(p[0])`. The Brak postfix
    /// handler stashes the consumed `multi_dim_stride` here so
    /// `sizeof` can return the whole row size. Cleared the same
    /// way as `last_array_decay_size` so it doesn't leak.
    pub last_array_decay_bytes: i64,

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
    /// `&`. Cleared by `mark_emit_other` so any unrelated emit
    /// invalidates the trace; identifier loads and `*` re-set it
    /// when applicable. Used to suppress the spurious `Li` that
    /// the existing unary `*` handler would emit when chasing a
    /// function pointer whose return type is itself a pointer
    /// (so the post-`*` type still satisfies `is_pointer_ty` and
    /// the call-site fallback can't fire).
    pub fn_ptr_chain_depth: i64,

    /// Symbol index of the Token::Loc whose value was loaded by
    /// the most recently emitted scalar load (`LoadKind::I64` /
    /// `LoadKind::U8` / `LoadKind::I16` / `LoadKind::I32`, or the fused local-load
    /// shorthand) in the identifier-rvalue path. The
    /// assignment / address-of
    /// callers consult this when they pop or rewrite that
    /// trailing load: if the load is removed before the
    /// program text is finalised, the symbol's was_read flag
    /// must be reverted to its prior state -- the load never
    /// ran, but the symbol may still have been read by an
    /// earlier expression. Cleared by `mark_emit_scalar_load`
    /// whenever a scalar load lands at the tail through a path
    /// that is not the identifier-rvalue branch (field access,
    /// array indexing, deref, bitfield extraction) so a downstream
    /// pop/rewrite does not retract was_read from a symbol
    /// whose load is no longer trailing.
    pub last_loaded_local: Option<usize>,

    /// `was_read` value the most recently parsed identifier
    /// load saw on the symbol immediately before flipping it
    /// to true. Captured in lockstep with `last_loaded_local`
    /// so `take_last_loaded_local` can restore the prior state
    /// when the load gets popped or rewritten -- preserving
    /// reads recorded by earlier expressions in the function.
    pub last_loaded_local_prior_was_read: bool,

    /// `pending_stores` value the most recently parsed
    /// identifier load saw on the symbol immediately before
    /// clearing it. Captured in lockstep with
    /// `last_loaded_local` so a tentative load that the
    /// surrounding assignment / address-of rewrites does not
    /// permanently drop the dead-store entries -- they restore
    /// alongside `was_read`.
    pub last_loaded_local_prior_pending: Vec<usize>,

    /// AST id of the rhs expression that the bitfield write path
    /// (`emit_bitfield_access`'s Assign branch) just parsed. The
    /// storage emit the same routine produces afterwards triggers
    /// `ast_apply_assign`, which clears `ast_acc` -- so the
    /// caller can't observe the rhs from `ast_acc`. Captured
    /// here before the store runs and read by the Member handler
    /// in `expr.rs` to build `Expr::BitfieldAssign`. `None`
    /// outside the bitfield-assign window.
    pub bf_assign_rhs: Option<crate::c5::ast::ExprId>,
    /// Compound-assignment counterpart of `bf_assign_rhs`. Holds
    /// `(rhs_ast_id, op)` where `op` is the binary operator the
    /// assignment expanded to. The Member handler reads this and
    /// builds `Expr::BitfieldAssign { rhs: Binop(read, op, rhs) }`
    /// per C99 6.5.16.2 (`E1 OP= E2` == `E1 = E1 OP E2`).
    pub bf_compound_assign: Option<(crate::c5::ast::ExprId, crate::c5::ir::BinOp)>,

    /// True while the trailing emit is an indirect-call shape
    /// (the indirect-call tag, optionally followed by a
    /// stack-arg cleanup). Set at the indirect-call site,
    /// preserved across the matching cleanup, cleared by any
    /// other emit. Read by
    /// `Self::last_emit_was_indirect_call` to suppress the
    /// type-warning on `T x = fp();` shapes where c5 can't see
    /// the callee's return type.
    pub last_emit_was_indirect_call: bool,

    /// True while the trailing emit is a literal-zero integer
    /// immediate. Set by `emit_imm(0)`, cleared by every other
    /// emit. Read by
    /// `Self::last_emit_is_zero` to suppress the NULL-idiom
    /// warning on `pointer = 0`.
    pub last_imm_was_zero: bool,

    /// Number of grouping parentheses stripped from around a compound
    /// literal by `skip_opt_compound_literal_cast` (`((T){...})`,
    /// C99 6.5.1/6.5.2.5). The aggregate-initializer dispatch consumes
    /// this many closing `)` after the literal's brace list. 0 when the
    /// literal carried no surrounding parentheses.
    pub compound_lit_close_parens: i64,

    /// Side channel from `skip_attribute_specifiers`: set true when a
    /// consumed attribute named `unused` / `maybe_unused` (C23
    /// 6.7.12.4 `[[maybe_unused]]` or GNU `__attribute__((unused))`).
    /// Read by `parse_block_stmt` right after the leading-attribute
    /// skip to mark the declared locals so their unused-variable
    /// diagnostics are suppressed.
    pub attr_maybe_unused: bool,
    /// A consumed `__declspec(thread)`. Read by the declaration parse to mark
    /// the declared object thread-local (the storage class `_Thread_local`
    /// reaches the same flag through the keyword path).
    pub attr_thread_local: bool,
    /// A consumed `__declspec(dllexport)`. Read after the declarator to add the
    /// declared name to the export list -- the equivalent of `#pragma export`.
    pub attr_dllexport: bool,
}

impl Default for Pending {
    fn default() -> Self {
        Self {
            base_was_void: false,
            base_was_long_double: false,
            fn_params: None,
            fn_ptr_indirection: None,
            base_is_function_type: false,
            bare_function_type_declarator: false,
            index_stride: 0,
            index_strides_tail: Vec::new(),
            end_of_expr_stride: 0,
            end_of_expr_strides_tail: Vec::new(),
            init_inner_dims: alloc::vec::Vec::new(),
            init_target_array_size: 0,
            typedef_base_array_size: 0,
            typedef_fn_proto: None,
            fn_ptr_param_types: None,
            indirect_callee_params: None,
            indirect_callee_is_variadic: false,
            parsing_fn_ptr_proto: false,
            param_decl_context: false,
            last_array_decay_size: 0,
            last_array_decay_bytes: 0,
            // `-1` means "not in a fn-ptr-tracked chain"; see field
            // docs above.
            fn_ptr_chain_depth: -1,
            last_loaded_local: None,
            last_loaded_local_prior_was_read: false,
            last_loaded_local_prior_pending: Vec::new(),
            bf_assign_rhs: None,
            bf_compound_assign: None,
            last_emit_was_indirect_call: false,
            last_imm_was_zero: false,
            compound_lit_close_parens: 0,
            attr_maybe_unused: false,
            attr_thread_local: false,
            attr_dllexport: false,
        }
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
    /// Next available `ent_pc` identifier for a user function or
    /// Sys trampoline. Bumped once per function at recording time
    /// so `ent_pc` / `end_pc` form a strictly increasing,
    /// non-overlapping per-TU sequence the linker can rebase
    /// across translation units.
    next_ent_pc: usize,
    data: Vec<u8>,
    /// Start offsets of anonymous data objects (string literals,
    /// `__func__`) recorded as they are placed in `data`, for static
    /// DCE object boundaries. See `Program::data_object_starts`.
    data_object_starts: Vec<i64>,
    /// Type of the current expression -- set by `expr` callees, read by callers
    /// to decide between byte and word loads/stores and for pointer scaling.
    ty: i64,
    /// Number of local-variable slots currently reserved in the active stack
    /// frame. User-declared locals push it up monotonically; call-arg staging
    /// (parse_function_args) bumps it temporarily for each in-flight call's
    /// reverse-push temp slots and then restores it.
    loc_offs: i64,
    /// Per-function high-water mark of `loc_offs` -- the SSA
    /// builder uses it to size the function's local slot count
    /// so the prologue reserves enough stack for every nested-call
    /// temp the function ever needs.
    max_loc_offs: i64,
    /// `(base_offset, cells)` for each multi-cell temporary the parser
    /// allocates that carries no symbol (a struct call result, a
    /// struct-by-value parameter copy, a struct compound literal). Slot
    /// coalescing reserves these interior cells; without a symbol they are
    /// absent from the per-function variable list. Reset per function.
    multi_cell_temps: alloc::vec::Vec<(i64, i64)>,

    /// True once the current function has emitted at least one
    /// alloca intrinsic. Drives the function-end backpatch that
    /// grows the function's local count to include the alloca
    /// arena and sets the matching `Inst::AllocaInit`'s operand to
    /// the alloca-top slot index. Reset on each new function
    /// definition.
    uses_alloca_in_current_fn: bool,

    /// True when the most recent decl-spec parse consumed an
    /// `inline` / `__inline` / `__inline__` keyword. Captured at
    /// function-symbol commit time onto `FinishedFunction::is_inline`
    /// and reset after, so it scopes to the immediately following
    /// declarator only.
    pending_is_inline: bool,

    /// True when the most recent decl-spec parse consumed a
    /// `_Noreturn` / `noreturn` keyword. Captured at function-symbol
    /// commit time onto `Symbol::is_noreturn` and reset after, so it
    /// scopes to the immediately following declarator only.
    pending_noreturn: bool,

    /// Per-function AST. The arena is reset at every function
    /// entry; the SSA walker reads from these snapshots at codegen
    /// entry.
    pub(super) ast: super::ast::Ast,

    /// ExprId of the value currently in the c5 accumulator,
    /// matching the parser's "every expression leaves its result
    /// in `a`" invariant. `None` between statements or when the
    /// expression site doesn't produce an AST node (address-only
    /// producers that the call-site path consumes directly).
    pub(super) ast_acc: Option<super::ast::ExprId>,

    /// ExprIds matching values on the c5 stack-machine stack --
    /// the stack push records the current `ast_acc` here;
    /// arithmetic / store ops pop the top entry. `Option`
    /// because some parser sites push address-only producers
    /// (address-of-local for a temp, data-segment immediate)
    /// that aren't AST-wired yet; pushing `None` keeps the
    /// vstack depth in lockstep with the c5 stack so a later pop
    /// hits the right slot rather than a stale value
    /// from a previous statement. `Vec` is per-function, never
    /// grows past the deepest expression nesting in any one
    /// function.
    pub(super) ast_vstack: Vec<Option<super::ast::ExprId>>,

    /// Per-function AST snapshots, captured at every function's
    /// closing return. The codegen entry walks these in order to
    /// produce one `FunctionSsa` per source function. Order
    /// matches function-definition order.
    pub(super) finished_functions: Vec<super::ast::FinishedFunction>,

    /// Synthesised `FunctionSsa` entries for parser-emitted
    /// helpers that aren't built from source (sys-trampolines).
    /// The codegen reads these directly via `produce_ssa_funcs`.
    pub(super) synthetic_ssa_funcs: Vec<super::ir::FunctionSsa>,

    /// Per-function map from goto label name -> AST `LabelId`.
    /// Reset at every function entry (alongside `ast_reset`).
    /// Keeps the AST's flat per-function label-id space in sync
    /// with the parser's name-keyed `self.labels` /
    /// `self.unresolved_gotos`, so `goto L; ... L:` resolves on
    /// the AST side regardless of source order.
    pub(super) ast_labels: Vec<(String, super::ast::LabelId)>,

    /// Cross-helper carry: `emit_local_init_store` stashes the
    /// initializer's ExprId here so the calling `parse_*_local_decl`
    /// can wrap it in `Decl::Local { init: Scalar(_) }`. Always
    /// cleared to None by the consumer; None on entry means an
    /// uninitialized local declaration.
    pub(super) pending_local_init_ast: Option<super::ast::ExprId>,

    /// Cross-helper carry for aggregate (constant brace-list)
    /// local initializers: `emit_local_array_init` stashes the
    /// staged `(src_data_off, size_bytes)` here so the decl site
    /// can build `Decl::Local { init: Aggregate(_) }`. Holds the
    /// Mcpy source descriptor; `None` means the decl is scalar /
    /// uninitialized.
    pub(super) pending_local_aggregate_ast: Option<(i64, i64)>,

    /// Cross-helper carry for runtime brace-list local
    /// initializers: `emit_local_array_init_runtime` and
    /// `emit_struct_local_init_runtime` append one entry per
    /// element-store, so the decl site can build
    /// `Decl::Local { init: Runtime { zero_init, elements } }`.
    /// The optional `zero_init` is filled by the preceding
    /// `emit_local_array_init` Mcpy-zero prelude (struct path);
    /// the array path has no zero prelude today.
    pub(super) pending_local_runtime_elements: Vec<super::ast::RuntimeInitElement>,

    // --- Lex-time scope depth ---
    /// Number of currently-open `break`-eligible scopes
    /// (`while` / `for` / `do-while` bodies, plus `switch`
    /// bodies). Used to flag `break` outside any such scope.
    /// The walker handles branch-target resolution from the
    /// AST; only the depth counter survives here for the
    /// "break outside loop / switch" check.
    loop_break_depth: usize,
    /// Number of currently-open `continue`-eligible scopes
    /// (loops only; `switch` doesn't open one).
    loop_continue_depth: usize,
    /// Linear table of `(label_name, text_pc)`. Per-function (cleared
    /// at every function start), so it stays small -- typically 0-2
    /// entries even in code that uses `goto`. Linear scan beats
    /// pulling in `HashMap` (which would force `std`).
    /// Names of `label:` statements seen in the current function;
    /// `Compiler::run_compile` validates every `goto` target
    /// against this list at function end. Cleared at every
    /// function start.
    labels: Vec<String>,
    /// Names of `goto label` statements whose target wasn't yet
    /// defined when the goto was parsed. Each name is rechecked
    /// against `labels` at function end; an unresolved entry is
    /// a compile error.
    unresolved_gotos: Vec<String>,
    /// Per nested `switch` body: drained at switch close. The
    /// AST emitter records each case's constant on its `Stmt::Case`
    /// node; this stack is the parser-side depth tracker that
    /// gates `case` / `default` legality.
    switch_cases: Vec<Vec<i64>>,
    /// Per nested `switch` body: `true` once a `default:` label
    /// was seen.
    switch_defaults: Vec<bool>,

    /// Defined struct types, indexed by struct id.
    pub(super) structs: Vec<StructDef>,
    /// Per-scope struct/union tag bindings (C99 6.2.1: tags have
    /// block scope). Each entry is a Vec of `(tag_name, struct_id)`
    /// declared in that scope. The first entry is the file scope; an
    /// inner block pushes an empty scope on entry and pops it on
    /// exit, so a `struct T` in a nested block shadows an outer one
    /// without colliding. `self.structs` keeps the StructDef storage
    /// reachable by id even after a scope pops.
    pub(super) tag_scopes: Vec<Vec<(String, usize)>>,
    /// Captured enum definitions. Populated by `parse_enum_body`
    /// when the parser sees `enum Tag { ... }`; the (tag, constants)
    /// pairs feed the DWARF emitter's enum DIEs.
    pub(super) enums: Vec<EnumDef>,

    /// Type-mismatch warnings collected during compilation. Stored as
    /// formatted lines so the final consumer (CLI / test) can dump them
    /// without knowing their structure.
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
    /// call-site lowering can substitute an `Inst::Intrinsic`
    /// emit for the regular call + stack-cleanup sequence.
    pp_intrinsics: alloc::collections::BTreeMap<String, i64>,

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
    /// Pointer-to-extern-data static initializers; the target symbol is
    /// resolved by name at link time. See [`program::ExternDataReloc`].
    pub(super) extern_data_relocs: Vec<crate::c5::program::ExternDataReloc>,
    /// Function-pointer relocations for static initializers like
    /// `static const VTable v = { .xClose = my_close };`. Each
    /// entry is the byte offset in `data` of an 8-byte slot plus
    /// the ent_pc of the function to point at; the per-format
    /// writers patch the slot to the real code address at write or
    /// load time. The VM reads the slot directly because c5
    /// function pointers carry the small `CODE_BASE + ent_pc` bias
    /// and the indirect-call lowering recognises that range.
    code_relocs: Vec<crate::c5::program::CodeReloc>,
    /// Names from `#pragma export(<name>)` directives, in
    /// declaration order. Validated at the end of
    /// [`Self::run_compile`] -- each must resolve to a
    /// `Token::Fun` symbol -- and copied onto
    /// `Program::exports` together with the function's
    /// ent_pc. Empty for executables that don't reach
    /// for the directive.
    pending_exports: Vec<String>,
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
    ///   * the synthetic return prepended at function end
    ///     emits a zero so a caller that misclassifies the
    ///     prototype reads `0` rather than stale accumulator bits
    ///     (C99 6.8.6.4p3 -- a `void` callee produces no value).
    ///   * a `return;` statement emits the same zero prefix
    ///     before the return; a `return <expr>;` is rejected
    ///     (C99 6.8.6.4p1 constraint violation).
    /// Set at function-body entry from the function's symbol
    /// (`Symbol::returns_void`), cleared at exit.
    current_func_returns_void: bool,

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

    /// Side-channel state shared between parser layers -- the
    /// 11 transient flags / stride queues / chain-depth counters
    /// the recursive descent reaches for. Grouped into one
    /// carrier so `Compiler` doesn't grow per parser-feature.
    /// Reset to `Pending::default()` at compiler construction.
    pending: Pending,

    /// Symbols with at least one entry in `Symbol::pending_stores`.
    /// Tracked separately so the branch and call AST emitters
    /// can flush every pending store without walking the full
    /// symbol table on each control-flow point. Cleared in
    /// lockstep with the per-symbol vectors.
    pending_store_symbols: Vec<usize>,

    /// Mirror of [`CompileOptions::warn_dead_store`]. Stashed on
    /// the compiler so the parser's dead-store helpers don't
    /// have to thread the option through every call site.
    warn_dead_store: bool,
    /// Mirror of [`CompileOptions::no_entry_point`]. Drops the
    /// "must define main / wmain / WinMain / wWinMain" check
    /// in `resolve_entry_and_dllmain_pcs`; `compile()` then
    /// returns a `Program` with `entry_pc = 0` /
    /// `entry_name = None` if no entry symbol exists.
    no_entry_point: bool,

    /// Mirror of [`CompileOptions::export_all_functions`]. When set,
    /// `resolve_exports` adds every non-static defined function to the
    /// export list so a `--shared` consumer can `dlsym` it.
    export_all_functions: bool,

    /// File-name table. Index 0 is the user's translation unit;
    /// every distinct filename observed via the lexer's
    /// `(file, line)` state (i.e. crossing a GNU line marker on
    /// `#include` enter / a `#line N "file"` directive) gets
    /// a fresh entry. The DWARF emitter writes one
    /// `DW_LNE_define_file` per entry and switches with the
    /// walker's per-Inst `inst_src` file index.
    source_files: Vec<String>,
    /// Label of the primary translation-unit source as supplied
    /// through [`CompileOptions::source_label`]. Compared against
    /// [`lexer::Lexer::file`] at declaration sites so unused-symbol
    /// diagnostics can skip declarations that landed via
    /// `#include`d headers (which the user can't act on from
    /// this TU). Empty when the caller didn't set a label; the
    /// preprocessor's `"<source>"` placeholder then stands in.
    source_label: String,
    /// Per-function locals + parameters captured at body close,
    /// before the c5 shadow-symbol restore unwinds the binding.
    /// The DWARF emitter walks this list to attach
    /// `DW_TAG_variable` / `DW_TAG_formal_parameter` DIEs to the
    /// matching subprogram, which lets lldb's `frame variable` and
    /// `watchpoint set variable foo` work for c5-emitted code.
    variables: Vec<crate::c5::program::VariableInfo>,
    /// Block-scoped locals captured at each block exit, before the
    /// shadow-symbol restore unwinds their binding and removes them
    /// from the symbol table the function-close collection walks.
    /// Drained into `variables` at function close with the function's
    /// entry PC. The entries flatten into function scope; precise
    /// `DW_TAG_lexical_block` ranges are not emitted yet (TODO).
    pending_block_locals: Vec<crate::c5::program::VariableInfo>,
    /// Name of the C function whose body is currently being
    /// emitted. Set on function-entry emit and cleared on the
    /// closing return.
    current_function_name: String,
    /// Parallel symbol index for each entry in `code_relocs`.
    /// `parse_constant_init_value` records a CodeReloc with the
    /// callee's `Symbol::val` at parse time -- which is `0` for
    /// any function whose body hasn't been emitted yet (e.g. a
    /// dispatch table that names every callback before any
    /// callback's body lands). [`Compiler::resolve_code_relocs`]
    /// reads this index post-parse and rewrites each CodeReloc's
    /// `target_ent_pc` to the originating symbol's now-resolved
    /// `Symbol::val`.
    code_reloc_sym_idx: Vec<usize>,

    /// Parser-symbol indices for every immediate emit whose
    /// operand carries a global's tentative address. The data
    /// reference shape becomes a cross-TU reference when the
    /// target global is defined in another translation unit;
    /// `link_unit` walks the list at construction time to flag
    /// cross-TU references to `_Thread_local` globals (which c5
    /// doesn't support yet) before the walker's
    /// `extern_imm_data_refs` / `extern_tls_refs` channels take
    /// over resolution. Empty in single-TU compiles.
    pub(super) glo_imm_refs: alloc::vec::Vec<usize>,
    /// Per-`data_relocs` originating symbol index. Tracks the
    /// `Token::Glo` whose address an initializer like
    /// `int *p = &x;` baked into the data segment. Cross-TU
    /// link-unit assembly walks this list in parallel with
    /// `data_relocs` to convert any entry whose `x` is an
    /// undefined external reference into a `DataDataAbs64`
    /// relocation. Length matches `data_relocs.len()` -- one
    /// symbol idx per emitted reloc -- so the parallel arrays
    /// don't drift out of sync.
    pub(super) data_reloc_sym_idx: alloc::vec::Vec<usize>,
    /// Per-libc-symbol trampoline registry. When source code
    /// reaches for the *address* of a `Token::Sys` binding --
    /// either bare (`fp = lstat;`) or in a static initializer
    /// (a function-pointer dispatch table referencing libc) --
    /// c5 has no compile-time
    /// libc address to fold in. Instead the parser synthesizes a
    /// tiny c5 function that re-pushes its parameters and
    /// re-dispatches through an external call. Each entry maps
    /// `sys_sym_idx` to a
    /// fresh synthetic-symbol idx whose `.val` carries the
    /// trampoline's `ent_pc`; the walker reads that live `val`
    /// through `live_fun_val` when it emits the matching
    /// `Inst::ImmCode` for the address-of site, and
    /// `resolve_code_relocs` patches any data-slot CodeReloc
    /// against the same `Symbol::val`. Trampolines are
    /// emitted in [`Self::emit_sys_trampolines`] after every
    /// real function body lands so they never split a caller
    /// mid-emission.
    sys_trampoline_sym: alloc::collections::BTreeMap<usize, usize>,

    /// Per-TU counter for anonymous compound-literal backing
    /// symbols. C99 6.5.2.5 compound literals at file scope
    /// (`Type *p = &(Type){ ... };`) need a synthetic symbol so the
    /// linker can resolve the `&` reloc; the name is
    /// `__compound.<n>` with `n` incrementing on every literal.
    /// The same counter feeds block-scope compound literals that
    /// spill to internal-linkage storage. Reset implicitly via
    /// `Compiler::default()` on every fresh compile.
    next_compound_literal_id: usize,

    /// Original `(source, opts)` snapshot captured in `with_options`
    /// when auto-include retry is permitted. On a "unknown function
    /// `name`" error during [`Self::compile`] the snapshot is
    /// re-used: the header that declares `name` (looked up in
    /// `headers::header_declaring`) is appended to
    /// `opts.force_includes` and a fresh `Compiler` runs the source
    /// from scratch. C99 7.1.4p2 lets standard library functions be
    /// referenced without a prior declaration; this turns that
    /// permission into an actually-working build for fixtures that
    /// rely on it. `None` after the first retry attempt, so the
    /// recursion bottoms out at one level.
    retry_state: Option<(String, CompileOptions)>,
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
    /// Run the preprocessor on `source` with the same setup
    /// `with_options` performs and return the expanded text. Used
    /// by the `--dump-pp` / `-E` CLI mode to surface what the
    /// lexer is about to see, without paying for the parse / codegen
    /// passes. Errors propagate via `Result` rather than the
    /// deferred-error channel because the caller has no compiler
    /// state to attach them to.
    pub fn preprocess(
        source: String,
        target: Target,
        opts: CompileOptions,
    ) -> Result<String, C5Error> {
        let mut pp = Preprocessor::new(target.id_str(), target, env!("CARGO_PKG_VERSION"));
        if opts.gnu {
            pp.enable_gnu();
        }
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
        pp.process(&source)
    }

    pub fn with_options(source: String, target: Target, opts: CompileOptions) -> Self {
        Self::with_options_inner(source, target, opts, true)
    }

    fn with_options_inner(
        source: String,
        target: Target,
        opts: CompileOptions,
        allow_auto_include_retry: bool,
    ) -> Self {
        let retry_state = if allow_auto_include_retry {
            Some((source.clone(), opts.clone()))
        } else {
            None
        };
        let mut this = Self::build(source, target, opts);
        this.retry_state = retry_state;
        this
    }

    fn build(source: String, target: Target, opts: CompileOptions) -> Self {
        // Run the preprocessor first so we know the
        // `#pragma binding(...)` set before seeding the symbol
        // table. The bindings come from whichever standard headers
        // the source `#include`s (or doesn't); a fixture that needs
        // `printf` but skips `<stdio.h>` will fail with a clear
        // "no `#pragma binding(... ::printf, ...)` is in scope"
        // error out of the codegen's import resolver, not a
        // mysterious link-time mismatch.
        let mut pp = Preprocessor::new(target.id_str(), target, env!("CARGO_PKG_VERSION"));
        if opts.gnu {
            pp.enable_gnu();
        }
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
        #[cfg(feature = "codegen_test")]
        let pp_start = std::time::Instant::now();
        let (preprocessed, deferred_error) = match pp.process(&source) {
            Ok(s) => (s, None),
            Err(e) => (String::new(), Some(e)),
        };
        #[cfg(feature = "codegen_test")]
        if std::env::var("BADC_TIME_PASSES").is_ok() {
            eprintln!("pass: preprocess -- {}us", pp_start.elapsed().as_micros());
        }
        // Debug knob: when BADC_DUMP_PP is set, write the post-
        // preprocessor source to /tmp/badc-pp.c so the exact token
        // stream the lexer is about to see can be inspected. Read
        // only under the `codegen_test` feature so a production build
        // never consults the environment.
        #[cfg(feature = "codegen_test")]
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

        let lex = {
            let mut l = Lexer::new(preprocessed);
            // `wchar_t` is 2 bytes (UTF-16) on Windows, 4 bytes on the
            // Unix targets; wide literals follow suit.
            l.wchar_bytes = if matches!(
                target,
                super::codegen::Target::WindowsX64 | super::codegen::Target::WindowsAarch64
            ) {
                2
            } else {
                4
            };
            l.char_signed = target.plain_char_signed();
            l
        };
        Self {
            lex,
            symbols,
            symbol_index,
            deferred_error,
            dylibs,
            target,
            next_ent_pc: 0,
            data,
            data_object_starts: Vec::new(),
            ty: 0,
            loc_offs: 0,
            max_loc_offs: 0,
            multi_cell_temps: alloc::vec::Vec::new(),
            uses_alloca_in_current_fn: false,
            pending_is_inline: false,
            pending_noreturn: false,
            ast: super::ast::Ast::new(),
            ast_acc: None,
            ast_vstack: Vec::new(),
            finished_functions: Vec::new(),
            synthetic_ssa_funcs: Vec::new(),
            ast_labels: Vec::new(),
            pending_local_init_ast: None,
            pending_local_aggregate_ast: None,
            pending_local_runtime_elements: Vec::new(),
            loop_break_depth: 0,
            loop_continue_depth: 0,
            labels: Vec::new(),
            unresolved_gotos: Vec::new(),
            switch_cases: Vec::new(),
            switch_defaults: Vec::new(),
            structs: Vec::new(),
            tag_scopes: alloc::vec![alloc::vec::Vec::new()],
            enums: Vec::new(),
            warnings: pp_warnings,
            include_trace: pp_include_trace,
            pp_entrypoint,
            pp_subsystem,
            pp_intrinsics,
            tls_data: Vec::new(),
            tls_init_size: 0,
            data_relocs: Vec::new(),
            extern_data_relocs: Vec::new(),
            code_relocs: Vec::new(),
            pending_exports,
            current_func_return_ty: 0,
            current_func_returns_void: false,
            pending: Pending::default(),
            pending_store_symbols: Vec::new(),
            warn_dead_store: opts.warn_dead_store,
            no_entry_point: opts.no_entry_point,
            export_all_functions: opts.export_all_functions,
            source_files: Vec::new(),
            source_label: opts.source_label.clone(),
            variables: Vec::new(),
            pending_block_locals: Vec::new(),
            current_function_name: String::new(),
            code_reloc_sym_idx: Vec::new(),
            sys_trampoline_sym: alloc::collections::BTreeMap::new(),
            glo_imm_refs: alloc::vec::Vec::new(),
            data_reloc_sym_idx: alloc::vec::Vec::new(),
            next_compound_literal_id: 0,
            retry_state: None,
        }
    }

    /// Resolve the ent_pcs for the program entry point
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
    /// emits. We record the ent_pc here unconditionally --
    /// the VM / JIT / non-PE writers ignore it, and the PE writer
    /// only consults it for `--shared` builds. No signature
    /// validation: c5 trusts user `main` the same way and DllMain
    /// is just a different ABI.
    fn resolve_entry_and_dllmain_pcs(
        &self,
    ) -> Result<(usize, Option<usize>, Option<String>), C5Error> {
        let pragma_name = self.pp_entrypoint.as_deref();
        let default_name: &str = pragma_name.unwrap_or("main");
        let lookup_fun = |name: &str| {
            lexer::find_symbol(&self.symbols, &self.symbol_index, name)
                .filter(|&idx| self.symbols[idx].class == Token::Fun as i64)
        };
        // Without `#pragma entrypoint(<name>)`, accept any of
        // `main` / `wmain` / `WinMain` / `wWinMain` in that
        // priority order.
        let resolved_idx = lookup_fun(default_name).or_else(|| {
            if pragma_name.is_some() {
                None
            } else {
                ["wmain", "WinMain", "wWinMain"]
                    .iter()
                    .find_map(|&n| lookup_fun(n).map(|idx| (n, idx)))
                    .map(|(_, idx)| idx)
            }
        });

        let dllmain_idx = lexer::find_symbol(&self.symbols, &self.symbol_index, "DllMain");
        let has_user_dllmain =
            dllmain_idx.is_some_and(|idx| self.symbols[idx].class == Token::Fun as i64);

        let (entry_pc, entry_name) = match resolved_idx {
            Some(idx) => (
                self.symbols[idx].val as usize,
                Some(self.symbols[idx].name.clone()),
            ),
            None if !self.pending_exports.is_empty() || has_user_dllmain || self.no_entry_point => {
                (0, None)
            }
            None => {
                return Err(self.compile_err(format!("{default_name}() not defined")));
            }
        };
        let dllmain_pc =
            dllmain_idx.and_then(|idx| has_user_dllmain.then(|| self.symbols[idx].val as usize));
        Ok((entry_pc, dllmain_pc, entry_name))
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
                ent_pc: self.symbols[idx].val as usize,
            });
        }
        // For a `--shared` build, export every non-static function
        // defined in this unit, matching the default visibility a
        // system toolchain gives a shared library: a runtime `dlopen`
        // consumer resolves an entry point (e.g. quickjs's
        // `js_init_module`) by name without a source-level pragma.
        // Functions named by `#pragma export` above are skipped here to
        // avoid duplicate export entries.
        if self.export_all_functions {
            use crate::c5::symbol::Linkage;
            for idx in 0..self.symbols.len() {
                let sym = &self.symbols[idx];
                if sym.class != Token::Fun as i64
                    || sym.linkage != Linkage::External
                    || !sym.defined_here
                {
                    continue;
                }
                if exports.iter().any(|e| e.name == sym.name) {
                    continue;
                }
                exports.push(crate::c5::program::ExportedFunction {
                    name: sym.name.clone(),
                    ent_pc: sym.val as usize,
                });
            }
        }
        Ok(exports)
    }

    /// Recover the function name from a compile error whose
    /// message has the shape ``unknown function `<name>`...``,
    /// returning `None` for any other error. Used to drive the
    /// auto-include retry in [`Self::compile`] -- a parser-level
    /// "unknown function" lands in `C5Error::Compile(_)` with the
    /// matching text, and `header_declaring` keys off the
    /// extracted name to pick the right `#include`.
    fn parse_unknown_function_name_from(err: &C5Error) -> Option<String> {
        let msg = match err {
            C5Error::Compile(m) => m,
            _ => return None,
        };
        let start = msg.find("unknown function `")? + "unknown function `".len();
        let rest = &msg[start..];
        let end = rest.find('`')?;
        Some(rest[..end].to_string())
    }

    /// Compile the source. On success, the returned `Program`
    /// carries the per-function SSA + static data segment + the
    /// ent_pc of `main`.
    ///
    /// Auto-include retry: when the first pass fails with
    /// `unknown function `name`` and `name` is declared by one of
    /// the embedded standard headers (per `headers::header_declaring`
    /// + the build-time index in `BINDING_TO_HEADER`), this method
    /// transparently re-runs the compile with the matching header
    /// force-included. C99 7.1.4p2 lets standard library functions
    /// be used without a prior declaration; this turns that
    /// permission into a successful build instead of a friendly
    /// error. The retry runs only once -- a second-pass failure
    /// propagates the original error.
    pub fn compile(mut self) -> Result<Program, C5Error> {
        let retry_state = self.retry_state.take();
        let target = self.target;
        let mut result = self.compile_one_pass();
        let Some((source, mut opts)) = retry_state else {
            return result;
        };
        // Auto-include retry. Each pass that fails on an undeclared
        // function names the header declaring it; force-include that
        // header and run again. Looping (rather than retrying once)
        // resolves a chain -- a `__builtin_*` thunk header pulling in
        // the library function's header -- and several independent
        // missing headers. The force-include set only grows, and a
        // header already in it ends the loop, so progress is monotone.
        let mut infos: Vec<String> = Vec::new();
        loop {
            let e = match result {
                Ok(mut prog) => {
                    // Surface each recovery through the same diagnostic
                    // pipeline the CLI colourises (`info:` -> bold
                    // green), oldest first above the retry pass's own
                    // warnings.
                    for info in infos.into_iter().rev() {
                        prog.warnings.insert(0, info);
                    }
                    return Ok(prog);
                }
                Err(e) => e,
            };
            let Some(name) = Self::parse_unknown_function_name_from(&e) else {
                return Err(e);
            };
            let header = match super::headers::header_declaring(&name) {
                Some(h) => h,
                None => return Err(e),
            };
            if opts.force_includes.iter().any(|h| h == header) {
                return Err(e);
            }
            opts.force_includes.push(header.to_string());
            infos.push(format!(
                "info: auto-including <{header}> for undeclared `{name}`"
            ));
            result = Compiler::with_options_inner(source.clone(), target, opts.clone(), false)
                .compile_one_pass();
        }
    }

    /// Run the full compile pipeline once with no auto-include
    /// retry. Shared by [`Self::compile`] (first pass) and by the
    /// retry branch inside the same method.
    fn compile_one_pass(mut self) -> Result<Program, C5Error> {
        if let Some(e) = self.deferred_error.take() {
            return Err(e);
        }
        #[cfg(feature = "codegen_test")]
        let parse_start = std::time::Instant::now();
        self.run_compile()?;
        #[cfg(feature = "codegen_test")]
        if std::env::var("BADC_TIME_PASSES").is_ok() {
            eprintln!(
                "pass: run_compile (parse + AST build) -- {}us",
                parse_start.elapsed().as_micros()
            );
        }
        // Trampolines must land before the code-reloc resolve
        // pass: every static-init function-pointer site that
        // names a libc symbol references its trampoline by
        // sym idx, and `resolve_code_relocs` reads the
        // trampoline's `Symbol::val` (set during
        // `emit_sys_trampolines`) to backfill each CodeReloc's
        // `target_ent_pc`.
        self.emit_sys_trampolines();
        self.resolve_code_relocs()?;
        // macOS resolves a `#pragma binding(data ...)` import (e.g.
        // environ) through the GOT -- a flat-namespace bind to the host
        // data symbol -- not through a COPY-relocated local slot, so the
        // symbol must stay undefined even in a self-contained image. The
        // no_entry_point clear below does this for relocatable objects;
        // do the same for a data binding's local here regardless of
        // no_entry_point so `live_glo_addr` returns `GloAddr::Extern` and
        // routes the reference through `imm_data_extern` to the GOT
        // rather than an uninitialized `.data` slot.
        if self.target == Target::MacOSAarch64 {
            let data_locals: alloc::collections::BTreeSet<String> = self
                .dylibs
                .iter()
                .flat_map(|d| d.bindings.iter())
                .filter(|b| b.is_data)
                .map(|b| b.local_name.clone())
                .collect();
            for sym in self.symbols.iter_mut() {
                if sym.class == Token::Glo as i64
                    && sym.is_extern_decl
                    && !sym.has_initializer
                    && data_locals.contains(&sym.name)
                {
                    sym.defined_here = false;
                    sym.val = 0;
                }
            }
        }
        // Cross-TU function imports. Every extern-declared
        // `Token::Fun` symbol with no body in this TU gets a
        // unique placeholder ent_pc (past `text.len()`), then has
        // `Symbol::val` rewritten to that PC. The walker reads
        // `Symbol::val` through `live_fun_val` when lowering an
        // `Inst::Call`, so the matching call site carries the
        // placeholder as its `target_pc`. The native codegen
        // detects the placeholder (outside `[0, text.len())`)
        // and emits a `RelocCallSite` against the symbol's name
        // instead of resolving in place. Single-TU compiles
        // without `no_entry_point` never reach this branch with
        // an unresolved call: `resolve_entry_and_dllmain_pcs`
        // errors out first.
        let extern_imports = if self.no_entry_point {
            use crate::c5::symbol::Linkage;
            let mut imports: alloc::vec::Vec<(usize, String)> = alloc::vec::Vec::new();
            let mut next_pc = self.next_ent_pc + 1;
            for sym in self.symbols.iter_mut() {
                if sym.class != Token::Fun as i64
                    || sym.defined_here
                    || sym.linkage != Linkage::External
                {
                    continue;
                }
                imports.push((next_pc, sym.name.clone()));
                sym.val = next_pc as i64;
                next_pc += 1;
            }
            // C99 6.7.1 + 6.9.2: an `extern T x;` / `extern T
            // x[N];` declaration with no defining initializer in
            // this TU contributes no storage. The parser-time
            // tentative slot at `sym.val` is meaningless once the
            // unit is linked against the defining TU; clear it so
            // the walker's `live_glo_addr` returns
            // `GloAddr::Extern` and routes the address producer
            // through `imm_data_extern`. Without this clear, the
            // walker emits `Inst::ImmData(stale_offset)` and the
            // ET_REL writer lowers it as a `.data section symbol +
            // 0` reloc, losing the symbol identity needed for
            // cross-TU resolution.
            for sym in self.symbols.iter_mut() {
                if sym.class == Token::Glo as i64
                    && sym.linkage == Linkage::External
                    && sym.is_extern_decl
                    && !sym.has_initializer
                {
                    sym.defined_here = false;
                    sym.val = 0;
                }
            }
            // Function-pointer initializers (`int (*const fp)
            // (...) = some_fn;`) recorded a `code_relocs` row
            // whose `target_ent_pc` was the symbol's val at
            // parse time -- before the loop above assigned
            // placeholder PCs to extern callees. Refresh each
            // row whose source symbol is an extern function so
            // the ET_REL writer can identify it as a cross-TU
            // reference. Local code_relocs already carry the
            // function's ent_pc and keep it.
            for (reloc, &sym_idx) in self
                .code_relocs
                .iter_mut()
                .zip(self.code_reloc_sym_idx.iter())
            {
                if sym_idx == usize::MAX || sym_idx >= self.symbols.len() {
                    continue;
                }
                let sym = &self.symbols[sym_idx];
                if sym.class == Token::Fun as i64
                    && !sym.defined_here
                    && sym.linkage == Linkage::External
                {
                    reloc.target_ent_pc = sym.val as u64;
                }
            }
            imports
        } else {
            alloc::vec::Vec::new()
        };
        let (entry_pc, dllmain_pc, resolved_entry_name) = self.resolve_entry_and_dllmain_pcs()?;
        let exports = self.resolve_exports()?;
        Ok(Program {
            data: self.data,
            data_object_starts: self.data_object_starts,
            entry_pc,
            warnings: self.warnings,
            tls_data: self.tls_data,
            tls_init_size: self.tls_init_size,
            exports,
            data_relocs: self.data_relocs,
            extern_data_relocs: self.extern_data_relocs,
            code_relocs: self.code_relocs,
            dylibs: self.dylibs,
            dllmain_pc,
            source_files: self.source_files,
            // `source_label` carries the path the CLI passed at
            // `with_source_label`; mirror it onto the returned
            // `Program` so DWARF emitters that consume the path
            // (DW_AT_name on the CU DIE, line-program file 0)
            // don't surface empty fields when the caller forgets
            // to set it explicitly. Downstream emitters overwrite
            // the field when they have a more specific value.
            source_path: self.source_label.clone(),
            variables: self.variables,
            // Struct registry, exposed so the DWARF emitter can
            // walk member offsets / bitfield layouts and produce
            // `DW_TAG_structure_type` DIEs. The VM /
            // JIT / interpreter ignore this field.
            structs: self.structs,
            enums: self.enums,
            // Resolved entry name. Includes the value from a
            // source-level `#pragma entrypoint(<name>)` plus the
            // CRT-recognised fallbacks (`wmain`, `WinMain`,
            // `wWinMain`) chosen when `main` is absent.
            entry_name: resolved_entry_name,
            subsystem: self.pp_subsystem,
            // Compile output is pre-optimizer; only the explicit
            // `optimize()` step flips this on.
            finished_functions: self.finished_functions,
            // Snapshot the symbol table for the SSA walker. Only
            // the `array_size` and `type_` fields are read today,
            // but cloning the full Symbol keeps the walker's view
            // in sync with any later field additions.
            symbols: self.symbols,
            synthetic_ssa_funcs: self.synthetic_ssa_funcs,
            // The single-TU compile path doesn't run the walker
            // eagerly; produce_ssa_funcs invokes it at codegen
            // time via finished_functions. Leave empty so the
            // codegen sees the walker as the source of truth.
            user_ssa_funcs: Vec::new(),
            extern_function_imports: extern_imports,
        })
    }
}
