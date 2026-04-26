use alloc::string::String;

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
}
