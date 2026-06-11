use alloc::string::String;
use alloc::vec::Vec;

#[derive(Clone, Debug, Default)]
pub(crate) struct Symbol {
    pub name: String,
    pub token: i64,
    pub class: i64,
    pub type_: i64,
    pub val: i64,
    pub h_class: i64,
    pub h_type: i64,
    pub h_val: i64,

    // ---- Function-only metadata ----
    /// For `Token::Fun` and `Token::Sys` symbols, the declared parameter
    /// types in source order. Empty for non-functions.
    pub params: Vec<i64>,
    /// True if the function accepts trailing varargs (e.g. `printf`).
    /// Type-checking only verifies the fixed parameters.
    pub is_variadic: bool,

    /// True for a function declared `_Noreturn` / `noreturn` (C11
    /// 6.7.4) or one of the built-in non-returning library functions
    /// (`exit`, `abort`, ...). The reachability analysis treats a call
    /// to such a function as not reaching its continuation, so a
    /// caller whose last statement is the call does not fall off its
    /// end.
    pub is_noreturn: bool,

    /// Set on a `Token::Glo` symbol declared with the
    /// `_Thread_local` storage class (C11). Drives the TLS
    /// lowering paths in the per-target writers: ELF .tdata /
    /// .tbss + GOT slot, PE TLS directory + _tls_index, Mach-O
    /// __thread_data + __thread_vars. The VM treats the slot
    /// like a regular global (single-threaded execution).
    pub is_thread_local: bool,

    /// For an array-typed local or global, the declared element
    /// count from `int xs[N]`. Zero means "not an array" (the
    /// symbol is a scalar, struct value, or pointer). The
    /// element type is in `type_`; the total byte storage is
    /// `array_size * size_of_type(type_)`. In expression
    /// position the symbol decays to a pointer-to-element --
    /// the load step is suppressed and `type_` is bumped by
    /// `Ty::Ptr`. Multi-dim arrays would extend this with a
    /// vector of dimensions; today only the single-dimension
    /// case lands.
    pub array_size: i64,

    /// Shadow slot for `array_size`. C99 6.2.1 paragraph 4: an
    /// inner block-scope or function-parameter declaration that
    /// reuses an outer name fully hides the outer binding for the
    /// duration of the inner scope, and the outer binding becomes
    /// visible again unchanged on scope exit. The parameter and
    /// local-decl paths overwrite `array_size` on the same symbol
    /// slot; without this save the outer typedef-array dimension
    /// (e.g. `typedef long jmp_buf[64]`) is permanently lost when
    /// a prototype reuses the name (`f(void *jmp_buf)`).
    pub h_array_size: i64,

    /// Inner dimension of a 2D-or-greater array variable. For
    /// `T xs[N][M]` we record `array_size = N*M` and
    /// `inner_array_size = M` so subscripting `xs[i]` scales by
    /// `M * sizeof(T)` instead of `sizeof(T)` -- the first index
    /// strides over rows, the second over elements. For 3D
    /// `T xs[N][M][K]` this stays `M` (the size immediately
    /// below the outermost dim). Used by the 2D-init-padding
    /// path, which only needs the row size. Higher-dim indexing
    /// uses `array_dims` (below) for the full stride ladder. Zero
    /// for 1D arrays.
    pub inner_array_size: i64,

    /// Shadow slot for `inner_array_size`. See `h_array_size`.
    pub h_inner_array_size: i64,

    /// Full dimension list, outermost first. For `T xs[N][M][K]`
    /// this is `[N, M, K]`. Empty for non-array or 1D-array
    /// symbols (the 1D case is fully described by `array_size`).
    /// The indexing path reads this to compute strides for each
    /// `[i]` subscript level: stride at level `k` is
    /// `product(array_dims[k+1..]) * sizeof(elem)`, with the
    /// final innermost subscript falling through to the regular
    /// `sizeof(elem)` + decay path.
    pub array_dims: Vec<i64>,

    /// Shadow slot for `array_dims`. See `h_array_size`.
    pub h_array_dims: Vec<i64>,

    /// True once a `Token::Glo` symbol has been seen with an
    /// explicit initializer (`= ...`). Tentative-definition
    /// merges (C11 6.9.2): a forward `static T x;` (or the same
    /// translation unit's `extern T x;`) is allowed to be
    /// re-declared and the later defining initializer fills in
    /// the storage. A second declaration that *also* carries an
    /// initializer is a real duplicate.
    pub has_initializer: bool,

    /// Number of derefs from this variable's *loaded value* down
    /// to a function-pointer rvalue, plus 1, or 0 if the variable
    /// has no function-pointer lineage. Concretely:
    ///
    ///   * `int (*fp)(int)`        -> 1 (loaded value IS the fn ptr)
    ///   * `fn_t fp;` via typedef  -> 1 (same)
    ///   * `fn_t *pp;`             -> 2 (one more deref needed)
    ///   * `int x;`                -> 0 (no lineage)
    ///
    /// The `+1` lets a default-zero field encode "no lineage"
    /// distinctly from "value is direct fn ptr" (which would
    /// otherwise also be zero). Read by the identifier-load path
    /// to seed `Compiler::fn_ptr_chain_depth` and ultimately
    /// decide whether a unary `*` is a real deref or a C decay
    /// no-op. c5 doesn't carry the function-pointer
    /// distinction in the type tag itself, so this side-channel
    /// is the only durable trace.
    pub fn_ptr_indirection: i64,
    /// Shadow slot for `fn_ptr_indirection`, saved by
    /// `shadow_symbol` and restored by `restore_shadowed_symbol`.
    /// Without it, a parameter or local that re-uses an outer
    /// fn-ptr name (or any name a previous binding tagged as
    /// fn-ptr lineage) inherits the stale tag, and a plain
    /// `*p = ...` against the rebound scalar pointer is treated
    /// as a fn-ptr decay no-op.
    pub h_fn_ptr_indirection: i64,
    /// True for a typedef of a function TYPE (`typedef RET F(args)`),
    /// as opposed to a function POINTER (`typedef RET (*F)(args)`). The
    /// type encoding pre-decays both to a function pointer (`RET` plus
    /// one pointer level), so they are otherwise indistinguishable; a
    /// declarator needs the distinction because `F *p` over a function
    /// type forms the pointer-to-function (a function pointer) while
    /// `F *p` over a function pointer is a pointer to one.
    pub is_function_type: bool,

    /// Set on a `Token::Fun` symbol whose declared return type
    /// was bare `void`. The type encoding (`type_`) still records
    /// `Ty::Char | UNSIGNED_BIT` -- a side-channel rather than
    /// a separate `Ty::Void` band, because a real band collides
    /// with the function-pointer encoding C99 6.7.6.3 uses for
    /// `void (*)(...)` slots inside dispatch tables. Consumed by:
    ///   * the function-body emit path: prepends a zero
    ///     immediate before the trailing synthetic return so a
    ///     caller that misclassifies the prototype reads `0`
    ///     rather than stale accumulator state (C99 6.8.6.4p3).
    ///   * the `return` statement: bare `return;` in a void
    ///     function emits the same zero prefix; a `return
    ///     <expr>;` is rejected as a constraint violation
    ///     (C99 6.8.6.4p1).
    pub returns_void: bool,

    /// Set on a `Token::Typedef` symbol whose alias chain ends
    /// at the bare `void` keyword. Because `void` and
    /// `unsigned char` share the same type encoding, the
    /// function-parameter parser consults this flag to
    /// distinguish `int f(VOID)` (no parameters) from
    /// `int f(BYTE)` (one byte-typed parameter).
    pub is_void_typedef: bool,

    /// True for a typedef whose base type is an `enum`. The base
    /// collapses to `int`, but an enum bitfield reads as unsigned, so
    /// a field declared with this typedef plus a bitfield width needs
    /// the unsigned (zero-extending) extraction.
    pub is_enum_typedef: bool,

    /// C99 6.2.2 linkage class of a file-scope identifier.
    /// `Linkage::None` for block-scope names; `Linkage::Internal`
    /// for `static`-qualified file-scope names; `Linkage::External`
    /// for everything else at file scope. Used by the linker
    /// (when the `full` feature is enabled) to decide whether
    /// this symbol participates in the cross-translation-unit
    /// symbol table -- internal-linkage names stay private to the
    /// translation unit. Inside a single TU compile this field is
    /// informational only.
    pub linkage: Linkage,

    /// True for a `Token::Fun` whose body has been emitted into
    /// `Compiler::text`, or a `Token::Glo` whose storage has been
    /// allocated in `Compiler::data` / `Compiler::tls_data`.
    /// False for forward prototypes (`int foo();`) and for
    /// `extern T x;` declarations whose definition lives in
    /// another translation unit -- those become undefined-symbol
    /// references in the link-unit symbol table.
    pub defined_here: bool,

    /// True for a file-scope declaration that explicitly carried
    /// the `extern` storage-class keyword. Combined with
    /// `defined_here == false`, it distinguishes an extern
    /// declaration (a forward reference satisfied by another TU)
    /// from a tentative definition that the parser is still
    /// waiting to resolve.
    pub is_extern_decl: bool,

    /// True for a block-scope `static` local that shadowed an outer
    /// binding (a file-scope object of the same name). The local is
    /// promoted to `Glo` class for its data-segment storage but keeps
    /// block scope (C99 6.2.1, 6.2.4p3), so the function-exit cleanup
    /// must restore the shadowed outer binding even though the
    /// symbol's class is no longer `Loc`. Cleared on restore.
    pub is_scope_static: bool,

    /// True for a `typedef` declared at the function-body top level
    /// (C99 6.7.7, 6.2.1: block scope). The name binds to `Typedef`
    /// class for the function body but must not leak to file scope,
    /// so the function-exit cleanup restores the shadowed outer
    /// binding even though the class is not `Loc`. Cleared on restore.
    pub is_scope_typedef: bool,

    /// True once the parser has emitted any reference to this
    /// symbol after its declaration -- a read, a write, an
    /// address-of, or a decay. Set by the expression parser's
    /// identifier resolution path; consulted at block / function
    /// exit to emit a C99-style "unused variable" diagnostic for
    /// block-scope locals and parameters that were never
    /// mentioned in the body.
    pub was_referenced: bool,

    /// True once a scalar load (`LoadKind::I64` / `LoadKind::U8` / ...) of
    /// this symbol's value survives in the parser's recent-emit
    /// ring -- i.e., the runtime would actually read the stored
    /// value. Distinct from `was_referenced`: the identifier-
    /// rvalue path tentatively sets `was_read` when it tags the
    /// load, and the assignment / address-of helpers retract the
    /// bit if they remove the load before the parse closes.
    /// Consulted alongside `was_written` to emit the "value
    /// assigned but never used" diagnostic for dead stores.
    pub was_read: bool,

    /// True once a scalar store of this symbol's lvalue surface
    /// has been emitted, or a declaration
    /// initializer wrote the storage. Set by the assignment /
    /// compound-assignment / increment paths in the expression
    /// parser and by `allocate_local_with_init` for declarations
    /// with `= ...`. Consulted alongside `was_read` to emit the
    /// dead-store diagnostic.
    pub was_written: bool,

    /// True once the symbol's address has been taken (`&local`
    /// or array decay). The address might escape to an unknown
    /// callee that reads or writes the storage, so the
    /// unused-symbol diagnostics suppress themselves
    /// conservatively when this flag is set.
    pub address_escaped: bool,

    /// Source lines of stores to this symbol that have not yet
    /// been followed by a read. Pushed by the assignment paths
    /// in the expression parser and by
    /// `allocate_local_with_init` for declarations with `= ...`.
    /// Cleared when an identifier-rvalue load of the symbol
    /// tags the trailing scalar load. Branches and function calls
    /// also clear the list (conservatively; the analysis is
    /// intra-segment to avoid flow-sensitivity false positives).
    /// Drained at function exit to emit the dead-store
    /// diagnostic for any line still present.
    pub pending_stores: Vec<usize>,

    /// Source line where this declaration was parsed. Captured at
    /// declaration time so unused-variable diagnostics can point
    /// at the declaration rather than the surrounding block's
    /// closing brace.
    pub decl_line: usize,

    /// `Compiler::source_files` index of the file the declaration
    /// was parsed from. Captured at declaration time alongside
    /// `decl_line`. Surfaces as `DW_AT_decl_file` in the DWARF
    /// variable / formal_parameter DIE after mapping to the
    /// DWARF file_names index. Zero means the primary source.
    pub decl_file: u32,

    /// True if the declaration was parsed while the lexer was
    /// reading the primary source (matched against
    /// `Compiler::source_label`); false when the declaration came
    /// from a header pulled in by `#include`. Used to suppress
    /// unused-symbol diagnostics on header-internal static
    /// helpers -- those are only dead with respect to the current
    /// translation unit, and the header is the wrong place to
    /// flag them.
    pub decl_in_main_source: bool,
}

/// C99 6.2.2 linkage class. `None` is the default for block-scope
/// declarations and for the symbol-table predefines; file-scope
/// declarations resolve to one of `Internal` (`static`) or
/// `External` (everything else, including bare declarations and
/// `extern T x;`). Materialised onto every symbol so the linker
/// can decide whether to surface the name in the cross-TU symbol
/// table or keep it private.
#[derive(Debug, Clone, Copy, Default, PartialEq, Eq)]
pub enum Linkage {
    /// No linkage -- block-scope names, function parameters,
    /// per-target header predefines, and any symbol the linker
    /// has no business looking at. The default for a freshly-
    /// constructed `Symbol`.
    #[default]
    None,
    /// `static` file-scope identifiers. Visible only within the
    /// containing translation unit; never emitted into the
    /// link-unit symbol table.
    Internal,
    /// Unqualified file-scope identifiers and `extern T x;`
    /// references. Visible to other translation units through
    /// the link-unit symbol table.
    External,
}
