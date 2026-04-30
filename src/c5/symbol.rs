use alloc::string::String;
use alloc::vec::Vec;

#[derive(Clone, Debug, Default)]
pub(crate) struct Symbol {
    pub name: String,
    pub hash: i64,
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
}
