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
///
/// `data_imm_positions` is a side channel for the native codegen: each
/// entry is a bytecode index where an `Op::Imm` operand holds an
/// offset into `data` (a string-literal address or a global-variable
/// address). The VM ignores it -- pointers are just integers there --
/// but the native backend needs to relocate these into __DATA's actual
/// load address, and there's no way to recover that distinction by
/// inspecting the bytecode alone (data offsets and plain integer
/// constants are indistinguishable).
#[derive(Debug, Clone)]
pub struct Program {
    pub text: Vec<i64>,
    pub data: Vec<u8>,
    pub entry_pc: usize,
    pub warnings: Vec<String>,
    pub data_imm_positions: Vec<usize>,
}
