/// Compiled program ready for the VM.
///
/// `text` holds the bytecode, `data` is the static data segment (string
/// literals plus zero-initialised globals), and `entry_pc` points at the
/// first instruction of `main` inside `text`.
#[derive(Debug, Clone)]
pub struct Program {
    pub text: Vec<i64>,
    pub data: Vec<u8>,
    pub entry_pc: usize,
}
