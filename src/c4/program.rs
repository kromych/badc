use alloc::string::String;
use alloc::vec::Vec;

/// Compiled program ready for the VM.
///
/// `text` holds the bytecode, `data` is the static data segment (string
/// literals plus zero-initialised globals), `entry_pc` points at the
/// first instruction of `main` inside `text`, and `warnings` carries
/// any non-fatal diagnostics the compiler emitted (type mismatches,
/// arity issues). The compiler never fails on a warning -- callers
/// decide whether to print, ignore, or treat them as errors.
#[derive(Debug, Clone)]
pub struct Program {
    pub text: Vec<i64>,
    pub data: Vec<u8>,
    pub entry_pc: usize,
    pub warnings: Vec<String>,
}
