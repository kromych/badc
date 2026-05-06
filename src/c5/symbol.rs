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

    /// Inner dimension of a 2D array variable. For `T xs[N][M]`
    /// we record `array_size = N*M` (total element count) and
    /// `inner_array_size = M` so subscripting `xs[i]` scales by
    /// `M * sizeof(T)` instead of `sizeof(T)` -- the first index
    /// strides over rows, the second over elements. Zero for 1D
    /// arrays. c5 doesn't express "array of M T" as a type, so
    /// the symbol carries the dimension separately.
    pub inner_array_size: i64,

    /// True once a `Token::Glo` symbol has been seen with an
    /// explicit initializer (`= ...`). Tentative-definition
    /// merges (C11 6.9.2): a forward `static T x;` (or the same
    /// translation unit's `extern T x;`) is allowed to be
    /// re-declared and the later defining initializer fills in
    /// the storage. A second declaration that *also* carries an
    /// initializer is a real duplicate.
    pub has_initializer: bool,
}
