mod ast;
mod codegen;
mod compiler;
mod depfile;
mod error;
mod headers;
mod host;
mod ir;
mod layout;
mod lexer;
#[cfg(feature = "full")]
mod linker;
mod object;
mod op;
mod preprocessor;
mod program;
#[cfg(feature = "full")]
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
pub use object::elf_class::ElfClass;
#[allow(unused_imports)]
#[cfg(feature = "native-emit")]
pub use object::{emit_native, emit_native_with_options};
pub use {
    codegen::{
        BinaryFormat, CodeModel, Hardening, IndirectBranch, NativeOptions, OutputKind, Target,
        jit_run, jit_run_with_options,
    },
    compiler::{CompileOptions, Compiler, StructDef, StructField},
    depfile::{escape as dep_escape, prerequisites as dep_prerequisites, render as dep_render},
    error::C5Error,
    headers::embedded_headers,
    host::{Host, Overwrite},
    lexer::{PredefinedKind, PredefinedSymbol, predefined_symbols},
    preprocessor::{IncludeOrigin, IncludeRecord, IncludeStatus},
    program::{Program, VariableInfo},
    vm::{Trace, Vm},
};

#[cfg(feature = "std")]
pub use host::StdHost;

#[cfg(all(feature = "full", feature = "std"))]
#[allow(unused_imports)]
pub use linker::read_archive_at;
#[cfg(all(feature = "full", feature = "std"))]
#[allow(unused_imports)]
pub use linker::{
    ArchiveInclusion, LdsEmit, LdsObject, LdsOptions, LdsResult, LinkerScript, MergedNative,
    MergedSymbol, NativeMachine, NativeObject, NativeReloc, NativeSymSection, NativeSymbol,
    OrphanHandling, PendingImportReloc, PltTrampoline, SectionContribution, SectionMap,
    SharedLibrary, detect_binary_format, emit_aarch64_plt, emit_x86_64_plt, is_elf_object,
    is_mach_o_object, is_native_object, link_native_objects, link_native_objects_with_options,
    link_native_objects_with_shared_libs, link_with_script, parse_lds_object, parse_linker_script,
    parse_native_elf, parse_native_mach_o, parse_native_object, parse_shared_library,
    render_link_map, write_executable_elf64, write_native_image_from_merged,
    write_native_image_from_merged_ex,
};
#[cfg(feature = "full")]
#[allow(unused_imports)]
pub use linker::{ArchiveMember, read_archive, write_archive};
#[cfg(all(feature = "full", feature = "std"))]
#[allow(unused_imports)]
pub use linker::{is_ld_invocation, run_ld};
#[cfg(feature = "full")]
pub use preprocessor::{Binding, DylibSpec, Subsystem};
#[cfg(feature = "full")]
pub use runtime::{embedded_compiler_rt, embedded_libc, embedded_runtime};
#[cfg(feature = "full")]
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
