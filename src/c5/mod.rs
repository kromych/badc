mod ast;
mod codegen;
mod compiler;
mod error;
mod headers;
mod host;
mod ir;
mod lexer;
#[cfg(feature = "linker")]
mod linker;
mod op;
mod preprocessor;
mod program;
#[cfg(feature = "linker")]
mod runtime;
mod symbol;
mod token;
mod vm;

#[cfg(test)]
mod tests;

// Public surface of the c5 module. The `#[allow(unused_imports)]` covers
// re-exports that aren't reached from `main.rs` (only from tests, which
// resolve through the inner module path) -- they are still part of the
// intended public API.
#[allow(unused_imports)]
pub use {
    codegen::{
        NativeOptions, OutputKind, Target, emit_native, emit_native_with_options, jit_run,
        jit_run_with_options,
    },
    compiler::{CompileOptions, Compiler, StructDef, StructField},
    error::C5Error,
    headers::embedded_headers,
    host::{Host, Overwrite},
    lexer::{PredefinedKind, PredefinedSymbol, predefined_symbols},
    op::Op,
    program::{Program, VariableInfo},
    vm::{Trace, Vm},
};

#[cfg(feature = "std")]
pub use host::StdHost;

#[cfg(feature = "linker")]
#[allow(unused_imports)]
pub use linker::{
    ArchiveMember, LinkArchive, LinkOptions, LinkSymbol, LinkUnit, Reloc, RelocKind, SymbolKind,
    link_units, read_archive, read_object, write_archive, write_object,
};
#[cfg(all(feature = "linker", feature = "std"))]
#[allow(unused_imports)]
pub use linker::{
    MergedNative, MergedSymbol, NativeMachine, NativeObject, NativeReloc, NativeSymSection,
    NativeSymbol, PendingImportReloc, PltTrampoline, emit_aarch64_plt, emit_x86_64_plt,
    is_elf_object, link_native_objects, parse_native_elf, write_executable_elf64,
    write_native_image_from_merged,
};
#[cfg(feature = "linker")]
pub use preprocessor::{Binding, DylibSpec, Subsystem};
#[cfg(feature = "linker")]
pub use runtime::embedded_runtime;
#[cfg(feature = "linker")]
pub use symbol::Linkage;

/// Base offset that separates the code address space from the data /
/// stack address spaces. Function-pointer values seen by user code are
/// `CODE_BASE + text_pc`; return addresses pushed by Jsr/Jsri/bootstrap
/// are encoded the same way. Any attempt to read or write through one of
/// those values lands here and is refused by the VM, keeping code and
/// data strictly separate.
///
/// Picked well above `STACK_BASE` (0x1000_0000) so a runaway data segment
/// can't accidentally collide with code addresses.
pub(crate) const CODE_BASE: usize = 0x2000_0000;
