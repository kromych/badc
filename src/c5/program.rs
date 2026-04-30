use alloc::string::String;
use alloc::vec::Vec;

use super::preprocessor::DylibSpec;

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
    /// Per-target dylib + binding map produced by the preprocessor
    /// from the `#pragma comment(dylib, ...)` and
    /// `#pragma binding(...)` directives in `headers/badc-{target}.h`.
    /// The native codegen uses this to:
    /// * pick the per-target real-symbol name for each c4 op
    ///   (`printf` -> `_printf` on macOS, `_printf` on Windows
    ///   msvcrt, `printf` on Linux),
    /// * conditionally include only those dylibs whose bindings the
    ///   program actually references (so a c5 source that never
    ///   calls `mprotect` doesn't drag `kernel32.dll` into the
    ///   import table on Windows), and
    /// * emit a hard error when a referenced op has no binding for
    ///   the chosen target, or when a declared dylib path doesn't
    ///   exist on disk.
    ///
    /// The VM ignores this field; only `emit_native` reaches for it.
    pub(crate) dylibs: Vec<DylibSpec>,
}
