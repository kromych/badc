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

    /// Full dimension list, outermost first. For `T xs[N][M][K]`
    /// this is `[N, M, K]`. Empty for non-array or 1D-array
    /// symbols (the 1D case is fully described by `array_size`).
    /// The indexing path reads this to compute strides for each
    /// `[i]` subscript level: stride at level `k` is
    /// `product(array_dims[k+1..]) * sizeof(elem)`, with the
    /// final innermost subscript falling through to the regular
    /// `sizeof(elem)` + decay path.
    pub array_dims: Vec<i64>,

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
}
