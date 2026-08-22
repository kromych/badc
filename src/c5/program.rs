use alloc::string::String;
use alloc::vec::Vec;

use super::preprocessor::DylibSpec;

/// One `#pragma export(<name>)` resolved against the
/// compiled program: the externally visible name plus the
/// function's `ent_pc` identifier. Shared-object writers
/// translate the identifier to a code-segment offset via
/// `Build::pc_to_native[ent_pc]` and then to a runtime
/// address by adding the code segment's vmaddr base.
#[derive(Debug, Clone)]
pub struct ExportedFunction {
    /// External name as written in `#pragma export(...)`.
    /// Per-format writers may decorate it with a leading
    /// underscore (Mach-O `_foo`) at emit time; the c5-side
    /// name stays as the user wrote it.
    pub name: String,
    /// `ent_pc` identifier of the function's entry. Indexes
    /// into `Build::pc_to_native` to recover the native
    /// code-segment offset.
    pub ent_pc: usize,
}

/// A function defined with `__attribute__((constructor))` or
/// `((destructor))` (GNU practice; C99 has no such attribute).
/// Constructors run before `main`, destructors after it returns.
/// Entries with an explicit priority run in ascending priority
/// order; unprioritized entries run last among constructors (and,
/// symmetrically, in the reverse of that order among destructors).
///
/// The ET_REL writer lowers each into an `.init_array` / `.fini_array`
/// section so a system linker + C library run them (the object stays
/// linkable by `ld` / `lld`). badc's own link path collects the
/// entries and runs them from the startup runtime instead.
#[derive(Debug, Clone)]
pub struct InitFunc {
    /// Defined function's name, as it appears in the symbol table.
    pub name: String,
    /// `ent_pc` identifier of the function's entry, for the single-TU
    /// native path (maps through `Build::pc_to_native`).
    pub ent_pc: usize,
    /// Explicit priority from `constructor(N)`; `None` for the bare
    /// form. GNU reserves priorities 0-100 for the implementation.
    pub priority: Option<u32>,
    /// `true` for `((destructor))`, `false` for `((constructor))`.
    pub is_destructor: bool,
}

/// Where an alias symbol's binding comes from.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum AliasBind {
    /// `__attribute__((alias))` on an external-linkage declarator.
    Global,
    /// The same declarator with `__attribute__((weak))`.
    Weak,
    /// The same declarator with internal linkage.
    Local,
    /// A `.set` of the unit's assembly: local unless a `.globl` / `.weak` of
    /// the unit declared the name.
    Assigned,
}

/// A function symbol declared `__attribute__((alias("target")))` or assigned
/// by a `.set` of the unit's assembly: the object's symbol table carries
/// `name` as an additional symbol at `target`'s address. The target is a
/// function defined in this unit (data aliases ride the regular data-symbol
/// path with the target's offset). TODO: the ELF writer emits these; the
/// Mach-O / PE final-image symbol tables do not carry the extra name (calls
/// resolve at parse time regardless).
#[derive(Debug, Clone)]
pub struct FunctionAlias {
    pub name: String,
    pub target: String,
    pub bind: AliasBind,
}

/// ELF symbol visibility, as the `.hidden` / `.internal` / `.protected`
/// directives name it. The discriminant is the `st_other` visibility field;
/// `STV_DEFAULT` is the absence of an entry.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum SymVisibility {
    Internal = 1,
    Hidden = 2,
    Protected = 3,
}

impl SymVisibility {
    /// The `st_other` visibility value.
    pub fn stv(self) -> u8 {
        self as u8
    }

    /// Whether the visibility keeps the name inside its component. Hidden and
    /// internal do; protected exports the name but forbids preemption.
    pub fn is_local_to_component(self) -> bool {
        matches!(self, SymVisibility::Internal | SymVisibility::Hidden)
    }
}

/// A pointer-to-extern-data initializer. The slot at `data_offset` in
/// [`Program::data`] must hold the runtime address of the data symbol
/// `symbol_name`, which is defined in another translation unit and
/// resolved by name at link time.
#[derive(Debug, Clone)]
pub struct ExternDataReloc {
    pub data_offset: u64,
    pub symbol_name: alloc::string::String,
    /// Byte offset added to the symbol's address -- non-zero for
    /// `&extern_arr[N]` and `&extern_g + K`.
    pub addend: i64,
}

/// A pointer-to-global initializer that needs run-time
/// relocation. `data_offset` is the byte offset within
/// [`Program::data`] where the absolute address of the target
/// must end up at runtime; `target_offset` is the byte offset
/// of the target within the same data segment.
#[derive(Debug, Clone, Copy)]
pub struct DataReloc {
    /// Byte offset in `Program::data` of the 8-byte slot that
    /// holds the runtime address of `target_offset`. Always
    /// 8-byte aligned (c5 lays globals out in 8-byte slots).
    pub data_offset: u64,
    /// Byte offset in `Program::data` of the global being
    /// pointed at. Same data segment; cross-segment
    /// relocations (e.g., into `tls_data`) are future work.
    pub target_offset: u64,
    /// Start offset of the object `target_offset` points into.
    /// The raw offset alone cannot attribute a one-past-the-end
    /// address (C99 6.5.6p8): it coincides with the next object's
    /// start, so data compaction would track the wrong object.
    /// Equals `target_offset` when the producer has no object
    /// identity.
    pub target_anchor: u64,
}

/// A function-pointer initializer that needs run-time relocation.
/// `data_offset` is the byte offset within [`Program::data`] where
/// the function's runtime code address must end up;
/// `target_ent_pc` is the function's `ent_pc` identifier (the
/// codegen maps it through `Build::pc_to_native` to a native
/// code-segment offset, then to a runtime address by adding the
/// text segment's vmaddr).
///
/// Generated by initializers like
/// `static const VTable v = { .xClose = my_close };`. The VM
/// reads the data slot directly because its function pointers
/// carry the small `CODE_BASE + ent_pc` bias and the indirect-
/// call lowering recognises that range. Native writers replace
/// the slot's
/// contents at write time (ELF) or via a dynamic relocation
/// (Mach-O rebase, PE `.reloc DIR64`).
#[derive(Debug, Clone, Copy)]
pub struct CodeReloc {
    /// Byte offset in `Program::data` of the 8-byte slot that
    /// receives the function's runtime code address. Always
    /// 8-byte aligned.
    pub data_offset: u64,
    /// `ent_pc` of the function. The codegen translates this to a
    /// native code-segment offset via `pc_to_native`.
    pub target_ent_pc: u64,
}

/// Compiled program ready for the VM.
///
/// `data` is the static data segment (string literals plus zero-
/// initialised globals), `entry_pc` is an integer identifier for
/// the program's entry function (codegen and the VM look it up
/// against `FunctionSsa::ent_pc`), and `warnings` carries any
/// non-fatal diagnostics the compiler emitted (type mismatches,
/// arity issues). The compiler never fails on a warning -- callers
/// decide whether to print, ignore, or treat them as errors.
#[derive(Debug, Clone)]
pub struct Program {
    pub data: Vec<u8>,
    /// File-scope `asm("...")` templates in source order, parse-time
    /// validated to hold section data directives only. The native
    /// codegen materializes them into the object's named sections
    /// under the emit target's directive conventions; the VM ignores
    /// them (the sections are not loaded).
    pub file_asm: Vec<String>,
    /// `.weak` symbol names from file-scope asm. The object writer
    /// binds the name STB_WEAK wherever it surfaces -- a definition
    /// (function, data, asm-section label, alias) or an undefined
    /// reference. A name that surfaces nowhere else gets no entry, as
    /// GNU as emits none for an unreferenced undefined weak.
    pub asm_weak_names: Vec<String>,
    /// `.globl` symbol names from file-scope asm. A name the unit neither
    /// defines nor references still gets an undefined global entry, as
    /// GNU as emits one; `ld -r` carries it into the next link stage.
    pub asm_global_names: Vec<String>,
    /// Symbol visibility named by `.hidden` / `.internal` / `.protected` in
    /// file-scope asm. The object writer sets `st_other` wherever the name
    /// surfaces. A later directive on the same name wins, as in GNU as.
    pub asm_visibility: Vec<(String, SymVisibility)>,
    /// The unit is assembler source (`.s` / `.S`). The object writer then
    /// takes the GNU as shape: an STT_FILE symbol only per `.file` directive
    /// and a `.comment` section only from `.ident` strings, where a compiled
    /// unit names its source file and carries the producer fingerprint.
    pub asm_unit: bool,
    /// `.file "name"` operands from file-scope asm, in directive order; one
    /// STT_FILE symbol each, as GNU as emits them.
    pub asm_file_names: Vec<String>,
    /// `.ident` strings from file-scope asm, in directive order; pooled
    /// NUL-terminated into `.comment`.
    pub asm_idents: Vec<String>,
    /// Base alignment `data` requires in the image, at least 8;
    /// raised to 16 when a file-scope object carries `_Alignas(16)`
    /// (or the attribute equivalents). The native writers place the
    /// data section at a multiple of it.
    pub data_align: usize,
    /// Length of the read-only prefix of `data`: `const`-qualified
    /// storage with no relocated slot, packed to the front by the
    /// native data compaction so the image writers can map it without
    /// write permission. Zero until that pass runs (VM, JIT, a
    /// freshly compiled unit); any repack resets it, and the pass
    /// re-establishes it for the layout it produced.
    pub data_ro_len: usize,
    /// End of the relro region of `data`: `data[data_ro_len..
    /// data_relro_len]` is `const`-qualified storage whose slots a
    /// relocation writes, so it cannot ride the read-only prefix. The
    /// image writers place it where the loader can patch it and
    /// re-protect it before the entry point runs. Equals
    /// [`Self::data_ro_len`] when the layout produced no such object,
    /// and is reset with it by any repack.
    pub data_relro_len: usize,
    /// Start offsets of anonymous data objects (string literals and the
    /// implicit `__func__` arrays of C99 6.4.2.2) within `data`. Named
    /// globals already carry their offset in `symbols[..].val`; these are
    /// the objects with no symbol. Static DCE treats the sorted union of
    /// these and the named-global offsets as object boundaries: an
    /// `[start, next_start)` interval is one object. Only true object
    /// starts are recorded, so a missing entry merely glues an object to
    /// its predecessor (kept conservatively), never splits a live one.
    pub data_object_starts: Vec<i64>,
    /// `[lo, hi)` ranges of anonymous immutable data within `data`:
    /// string literals (C99 6.4.5p6 makes modifying one undefined),
    /// the implicit `__func__` arrays, and the staged templates a
    /// local aggregate or compound literal is Mcpy-initialized from.
    /// Nothing names them, so their bytes never change after emission;
    /// the const-data load fold reads them like a const object's image.
    pub const_data_ranges: Vec<(i64, i64)>,
    /// `[start, end)` ranges of alignment padding within `data`: bytes
    /// the layout pushed purely to align the next allocation, never
    /// object content. The relocatable writer drops each range and
    /// re-pads to the following object's own alignment when it removes
    /// named-section objects from the default `.data` image.
    pub data_pad_ranges: Vec<(i64, i64)>,
    /// `(offset, align)` boundaries where the layout aligned `data`
    /// above 8. The relocatable writer repacks kept content at these
    /// boundaries; they cover objects the symbol table cannot surface
    /// at write time (a block-scope static's symbol entry is restored
    /// at scope exit).
    pub data_align_marks: Vec<(i64, i64)>,
    pub entry_pc: usize,
    pub warnings: Vec<String>,
    /// Initialised + zero-init thread-local data. Layout matches
    /// the way `data` does for ordinary globals: a flat byte array
    /// indexed by `Inst::TlsAddr`'s operand. The image writers copy
    /// this into `.tdata` (initialised slice = `tls_data[..tls_init_size]`)
    /// and `.tbss` (zero-fill remainder = `tls_data[tls_init_size..]`).
    /// A `_Thread_local int x = 5;` initialiser raises
    /// `tls_init_size` so its bytes land in `.tdata`; an
    /// uninitialised variable keeps its slice zero and in `.tbss`.
    pub tls_data: Vec<u8>,
    /// Number of bytes of `tls_data` that are statically initialised
    /// (i.e., emitted into `.tdata`). The remainder
    /// (`tls_data.len() - tls_init_size` bytes) is zero-init and
    /// goes into `.tbss`. Invariant: `tls_init_size <= tls_data.len()`.
    pub tls_init_size: usize,
    /// Address-of-global initializers. Each entry says "byte
    /// `data_offset` of the data segment must hold the runtime
    /// address of byte `target_offset` of the data segment".
    /// Generated by initializers like
    /// `int *p = &x;` where both `p` and `x` live in `.data`.
    /// The VM ignores this -- it materializes pointers
    /// dynamically by adding `data_base` to the offset immediate.
    /// The native writers translate each entry to the per-format
    /// dynamic relocation:
    ///
    /// * **ELF** (`ET_EXEC`, no slide): write the absolute VA
    ///   into `build.data` at write time. No runtime fixup.
    /// * **Mach-O** (`MH_PIE`, slid): emit a rebase opcode for
    ///   the slot. Initial bytes hold the preferred VA; the
    ///   loader adds the slide.
    /// * **PE** (DYNAMIC_BASE + `.reloc`): emit a
    ///   `IMAGE_REL_BASED_DIR64` entry. Initial bytes hold the
    ///   preferred VA; the loader adds the slide delta.
    pub data_relocs: Vec<DataReloc>,
    /// Pointer-to-extern-data initializers (`int *p = &extern_g;` and the
    /// equivalent extern-array decay). The target is defined in another
    /// translation unit, so the slot at `data_offset` must hold that
    /// symbol's runtime address, resolved by name at link time -- unlike
    /// [`DataReloc`], whose target is a known offset in this unit's data.
    pub extern_data_relocs: Vec<ExternDataReloc>,
    /// Function-pointer initializers in the data segment. Each
    /// entry says "byte `data_offset` of the data segment must
    /// hold the runtime code address of the function whose first
    /// instruction is at ent_pc `target_ent_pc`". Per-format
    /// writer handling mirrors `data_relocs` -- see [`CodeReloc`]
    /// for the per-format strategy.
    pub code_relocs: Vec<CodeReloc>,
    /// Address-constant initializers of `_Thread_local` objects (C99
    /// 6.7.8p4). `data_offset` is a byte offset into [`Self::tls_data`],
    /// the initialization template the runtime copies per thread; the
    /// target is an object in [`Self::data`], as for [`DataReloc`].
    /// The relocation applies to the template image at load time and the
    /// per-thread copies inherit the relocated value: every supported
    /// format materializes the template as ordinary loadable bytes
    /// (`.tdata`, `__DATA,__thread_data`, the PE `.data` TLS blob) and
    /// applies image relocations before any thread's block exists.
    pub tls_data_relocs: Vec<DataReloc>,
    /// [`ExternDataReloc`] whose slot is in [`Self::tls_data`].
    pub tls_extern_data_relocs: Vec<ExternDataReloc>,
    /// [`CodeReloc`] whose slot is in [`Self::tls_data`].
    pub tls_code_relocs: Vec<CodeReloc>,
    /// Functions the program asked to expose externally via
    /// `#pragma export(<name>)`. Each entry pairs the source
    /// name with the function's ent_pc -- the
    /// shared-object writers (Mach-O dylib, ELF .so, PE DLL)
    /// promote each entry to a real export-table record so
    /// callers in another image can resolve the symbol via
    /// `dlsym` / `GetProcAddress`.
    ///
    /// Empty for executable output (the user-supplied
    /// program never reached for `#pragma export`, or the
    /// build asked for an executable rather than a shared
    /// library). The VM and JIT ignore this field; only the
    /// shared-object writer paths consume it.
    pub exports: Vec<ExportedFunction>,
    /// Per-target dylib + binding map produced by the preprocessor
    /// from the `#pragma comment(dylib, ...)` and
    /// `#pragma binding(...)` directives in `headers/badc-{target}.h`.
    /// The native codegen uses this to:
    /// * pick the per-target real-symbol name for each interp op
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
    /// Bytecode PC of a user-defined `DllMain` function, if the
    /// source declared one. Used by the PE writer for
    /// `--shared` output: when present, `AddressOfEntryPoint`
    /// targets the user's body and the boilerplate
    /// `mov eax, 1; ret` stub is suppressed; when `None`, the
    /// writer falls back to the stub. The signature isn't
    /// validated -- the user is trusted to honor the Win64
    /// `BOOL DllMain(HINSTANCE, DWORD, LPVOID)` shape, same as
    /// `main` is trusted today. The Mach-O / ELF / VM / JIT
    /// paths ignore this field.
    pub dllmain_pc: Option<usize>,
    /// Source-file table. Populated by the lexer's GNU line-
    /// marker handling: each `#include` boundary or
    /// `#line N "file"` directive interns a fresh filename.
    /// Index 0 is the user's translation-unit source (the
    /// `--source-path` CLI arg, falling back to the lexer's
    /// initial `"<source>"` placeholder). The DWARF emitter
    /// reads this list and emits one file entry per name; the
    /// per-Inst `inst_src` records the file index inline.
    pub source_files: Vec<String>,
    /// Filesystem path of the input `.c` file, when known. Set by
    /// the CLI shim from the user's argv before
    /// [`crate::emit_native`] runs; the c5 frontend itself doesn't
    /// know the path, so it leaves this empty for the
    /// `compile_str` / stdin / fixture paths.
    ///
    /// The DWARF emitter uses this as the CU's
    /// `DW_AT_name` and the line program's only file entry, so
    /// `lldb image lookup -n foo` reports `foo at /path/to/src.c:N`
    /// instead of `<unknown>:N`. Empty falls back to `<unknown>`.
    /// The VM / JIT / interpreter ignore it.
    pub source_path: String,
    /// Per-function local + formal-parameter records, captured at
    /// function-body close (just before the c5 `Token::Loc`
    /// shadowing is unwound). Indexed by lookup -- consumers
    /// (DWARF emitter) filter by `function_bc_pc` to gather
    /// the variables that belong to each subprogram.
    ///
    /// `fp_slot` is the c5 frame-relative slot the symbol resolves
    /// to: positive values are arguments (`fp + slot*8`, which is
    /// `fp+0x10` for the first arg etc.), negative values are
    /// locals (`fp + slot*8`, e.g. `-1` -> `fp - 8`). DWARF turns
    /// this into a `DW_AT_location` with `DW_OP_fbreg` so lldb /
    /// gdb can resolve a variable name to its current stack
    /// address.
    ///
    /// Empty when c5 is run as a library (no driver-side capture)
    /// or the program contains no functions. The VM / JIT /
    /// interpreter ignore this field.
    pub variables: Vec<VariableInfo>,
    /// Struct / union registry, indexed by the struct id encoded
    /// in c5 type tags (`STRUCT_BASE + id * STRUCT_STRIDE`).
    /// Cloned out of `Compiler::structs` at `compile()` time so
    /// the DWARF emitter can walk member offsets and
    /// bitfield layouts to produce `DW_TAG_structure_type` /
    /// `DW_TAG_union_type` DIEs. The VM / JIT / interpreter
    /// ignore this field.
    pub structs: Vec<crate::c5::compiler::StructDef>,
    /// Captured enum definitions. Sourced from
    /// `Compiler::enums` at `compile()`; the DWARF emitter walks
    /// this to produce DW_TAG_enumeration_type + DW_TAG_enumerator
    /// DIEs so `(gdb) ptype enum Tag` shows the named constants.
    /// Empty for archive-reloaded units (enum tags don't round-trip
    /// through the `.o` format yet).
    pub enums: Vec<crate::c5::compiler::EnumDef>,
    /// Resolved entry-function name: `#pragma entrypoint(<name>)`
    /// when present, otherwise whichever of `main` / `wmain` /
    /// `WinMain` / `wWinMain` the source defines. `None` for
    /// entry-less images (DLL with exports). The PE writer
    /// reads this to pick the stub flavour (`wmain` swaps
    /// `__getmainargs` for `__wgetmainargs`); other writers
    /// ignore it.
    pub entry_name: Option<String>,
    /// The literal `#pragma entrypoint(<name>)` value; `None` when
    /// the source has no such pragma. Distinct from `entry_name`,
    /// which also reflects the CRT fallbacks. The driver reads this
    /// to warn when a relocatable emit drops the pragma (an object
    /// file does not carry it).
    pub entry_pragma: Option<String>,
    /// Function names the auto-include retry bound to a bundled
    /// header during [`crate::c5::Compiler::compile`]. The driver
    /// consults this in a multi-TU build: a name another input
    /// defines is recompiled as an implicit extern so the user's
    /// definition wins over the header's library binding.
    pub auto_includes: Vec<String>,
    /// Source-declared Windows subsystem. Set by
    /// `#pragma subsystem(<kind>)`; `None` falls back to the
    /// PE writer's default (`Console`). Read only by the PE
    /// writers; non-PE targets (Mach-O / ELF) ignore this
    /// field.
    pub subsystem: Option<crate::c5::preprocessor::Subsystem>,
    /// Per-function AST snapshots paired with their function-
    /// shaped metadata (ent_pc, n_params, is_variadic, n_locals,
    /// name). Populated by the parser's dual-emit; the SSA walker
    /// reads from here to lower each function. Empty for builds
    /// that didn't go through the parser path (linker reload from
    /// a `.o` / `.a`).
    pub(crate) finished_functions: alloc::vec::Vec<crate::c5::ast::FinishedFunction>,
    /// Symbol-table snapshot taken at `compile()` close. The AST
    /// walker reads `array_size` (for the C99 6.3.2.1p3
    /// array-to-pointer decay detection) and `type_` (for
    /// `Decl::Local` width selection) off this slice. Empty for
    /// `Program` shapes built outside the parser pipeline.
    pub(crate) symbols: alloc::vec::Vec<crate::c5::symbol::Symbol>,
    /// Synthesised `FunctionSsa` entries the parser produces
    /// outside the AST walker (sys-trampolines + the synthetic
    /// CRT entry). The codegen reads these directly through
    /// `produce_ssa_funcs`.
    pub(crate) synthetic_ssa_funcs: alloc::vec::Vec<crate::c5::ir::FunctionSsa>,
    /// User-function `FunctionSsa` entries produced by the AST
    /// walker; the native linker concatenates and rebases them to
    /// merged PCs. Carries the body for every parser-declared
    /// function. The codegen reads these directly through
    /// `produce_ssa_funcs`. Empty only for `Program` shapes built
    /// outside the parser pipeline.
    pub(crate) user_ssa_funcs: alloc::vec::Vec<crate::c5::ir::FunctionSsa>,
    /// Cross-TU user-function imports surfaced by the parser
    /// for the `-c` (`OutputKind::Relocatable`) path. Each
    /// entry is `(placeholder_pc, symbol_name)`:
    /// the parser assigned `placeholder_pc` as a unique
    /// out-of-range `ent_pc` to every extern-declared function
    /// with no body in this TU. The walker forwards it
    /// through `live_fun_val`, so the matching `Inst::Call`
    /// carries that PC. The native codegen detects it (PC
    /// past every real function's `end_pc`) and surfaces a
    /// `RelocCallSite` against the symbol's name instead of
    /// patching the BL/CALL placeholder against
    /// `pc_to_native`. Empty for builds without
    /// `CompileOptions::no_entry_point`; the regular single-
    /// TU compile errors out on undefined externs earlier.
    pub(crate) extern_function_imports: alloc::vec::Vec<(usize, alloc::string::String)>,
    /// Functions tagged `__attribute__((constructor))` /
    /// `((destructor))`, in source order. The native emit path lowers
    /// these into `.init_array` / `.fini_array`; the VM and JIT run
    /// the constructors before `main`. Empty for programs that declare
    /// none, and for `Program` shapes built outside the parser.
    pub init_funcs: alloc::vec::Vec<InitFunc>,

    /// Function symbols declared `__attribute__((alias("target")))`
    /// in this unit, emitted by the object writers as additional
    /// symbols at the target's address.
    pub function_aliases: alloc::vec::Vec<FunctionAlias>,
}

impl Program {
    /// Data slots holding a `&&label` address, each paired with the
    /// `ent_pc` of the function the label lives in. The slot needs a
    /// relocation and keeps that function reachable.
    pub(crate) fn label_data_slots(&self) -> impl Iterator<Item = (u64, usize)> + '_ {
        self.finished_functions
            .iter()
            .flat_map(|f| f.label_data_slots.iter().map(|s| (s.data_offset, f.ent_pc)))
    }

    /// Every `data` byte offset a slot value is written into after the
    /// initializer bytes are staged: link-time addresses within this
    /// unit, extern symbol addresses, function addresses, and `&&label`
    /// slots. The staged bytes under one are a placeholder, so a reader
    /// of `data` must not take them for the object's value.
    pub(crate) fn data_reloc_offsets(&self) -> alloc::vec::Vec<i64> {
        let mut offsets: alloc::vec::Vec<i64> = self
            .data_relocs
            .iter()
            .map(|r| r.data_offset as i64)
            .chain(self.code_relocs.iter().map(|r| r.data_offset as i64))
            .chain(self.extern_data_relocs.iter().map(|r| r.data_offset as i64))
            .chain(self.label_data_slots().map(|(off, _)| off as i64))
            .collect();
        offsets.sort_unstable();
        offsets
    }
}

/// A single local variable or formal parameter belonging to a
/// specific c5-emitted function, captured for DWARF emission.
/// The function is identified by `function_bc_pc` -- the
/// function's `ent_pc`, which the DWARF emitter already uses to
/// find the matching subprogram DIE.
#[derive(Debug, Clone)]
pub struct VariableInfo {
    /// PC of the owning function's entry. Same value
    /// the subprogram-discovery walk in `dwarf::collect_subprograms`
    /// produces, so the DWARF emitter can group variables by
    /// subprogram with a simple equality check.
    pub function_bc_pc: u64,
    /// Source-level identifier (parameter or local name).
    pub name: String,
    /// c5 type tag (`Ty` enum encoded as `i64`). Pointer levels
    /// follow the `+= 2` convention; struct types live in the
    /// `STRUCT_BASE +` band.
    pub type_tag: i64,
    /// Frame-relative slot. `>=2` is an argument (caller pushed
    /// it at `fp + slot*8`); `<0` is a local (the function
    /// allocated it at `fp + slot*8`, with the value negative).
    /// Slots `0..2` are the saved-x29 / saved-x30 area and don't
    /// hold user-visible variables.
    pub fp_slot: i64,
    /// True for arguments (`Token::Loc` symbols introduced by the
    /// parameter list) so the DWARF emitter picks
    /// `DW_TAG_formal_parameter`; locals get `DW_TAG_variable`.
    pub is_parameter: bool,
    /// Source line of the declaration. Surfaces as `DW_AT_decl_line`
    /// on the matching DIE so `(gdb) info args` / `info locals` can
    /// point at the declaration. Zero when the parser didn't record
    /// a position (archive-reloaded units default here).
    pub decl_line: u32,
    /// Declared element count for true local arrays (`int xs[N]`).
    /// Drives DW_TAG_array_type / DW_TAG_subrange_type emission so
    /// `ptype xs` shows `int [N]` instead of just `int`. Zero for
    /// scalars and for parameters (the latter decay to pointers per
    /// C99 6.7.5.3p7 and keep the pointer-type DIE).
    pub array_size: u32,
    /// `Compiler::source_files` index of the declaration's source
    /// file. Surfaces as `DW_AT_decl_file` after mapping to the
    /// DWARF file_names index. Zero is the primary source.
    pub decl_file: u32,
    /// Function-pointer lineage tag (mirrors
    /// `Symbol::fn_ptr_indirection`): 0 for a non-function-pointer,
    /// `n >= 1` for a value that is the function pointer after
    /// `n - 1` dereferences. With `params` and `is_variadic` it gives
    /// the DWARF emitter the prototype to describe, so the DIE names a
    /// pointer to a `DW_TAG_subroutine_type` rather than a pointer to
    /// the return type.
    pub fn_ptr_indirection: i64,
    /// Parameter type tags of the prototype, empty for a
    /// non-function-pointer or one declared without one.
    pub params: Vec<i64>,
    /// True when the prototype ends in `, ...`.
    pub is_variadic: bool,
    /// Dimension list of a multidimensional local array, outermost
    /// first (mirrors `Symbol::array_dims`). Empty for a scalar or a
    /// one-dimensional array, whose extent `array_size` already gives.
    pub array_dims: Vec<i64>,
    /// How the declaration spelled the type; see
    /// [`crate::c5::symbol::DeclSpelling`]. Debug info only.
    pub decl_spelling: crate::c5::symbol::DeclSpelling,
}

// ---- Data-offset surface ----
//
// Each implementation destructures its type without `..`: a new field
// holding a `Program::data` byte offset does not compile until it is
// classified. See [`crate::c5::layout::DataOffsets`].

use crate::c5::layout::{DataOffsets, DataRemap, remap_self_u64};

impl DataReloc {
    /// Remap the target only. The slot of a TLS-template relocation is a
    /// `tls_data` offset, which the `data` compaction never moves.
    fn remap_target_offsets(&mut self, r: &dyn DataRemap) {
        // The target follows the object its anchor names: a one-past-the-end
        // target (C99 6.5.6p8) sits on the next object's start, so its own
        // value would track the wrong object.
        let anchor = self.target_anchor as i64;
        if r.in_data(anchor) {
            self.target_offset = r.remap(self.target_offset as i64, anchor).unwrap_or(0) as u64;
            remap_self_u64(&mut self.target_anchor, r);
        } else {
            remap_self_u64(&mut self.target_offset, r);
            self.target_anchor = self.target_offset;
        }
    }
}

impl DataOffsets for DataReloc {
    fn remap_data_offsets(&mut self, r: &dyn DataRemap) {
        let Self {
            data_offset,
            target_offset: _, // remapped by `remap_target_offsets`
            target_anchor: _,
        } = self;
        remap_self_u64(data_offset, r);
        self.remap_target_offsets(r);
    }
}

impl DataOffsets for CodeReloc {
    fn remap_data_offsets(&mut self, r: &dyn DataRemap) {
        let Self {
            data_offset,
            target_ent_pc: _, // code address space
        } = self;
        remap_self_u64(data_offset, r);
    }
}

impl DataOffsets for ExternDataReloc {
    fn remap_data_offsets(&mut self, r: &dyn DataRemap) {
        let Self {
            data_offset,
            symbol_name: _,
            addend: _, // relative to the target symbol, not to `data`
        } = self;
        remap_self_u64(data_offset, r);
    }
}

impl DataOffsets for Program {
    fn remap_data_offsets(&mut self, r: &dyn DataRemap) {
        let Self {
            data: _, // the bytes the offsets index; the pass replaces them wholesale
            file_asm: _,
            asm_weak_names: _,
            asm_global_names: _,
            asm_visibility: _,
            asm_unit: _,
            asm_file_names: _,
            asm_idents: _,
            data_align: _, // an alignment, not an offset
            data_ro_len,
            data_relro_len,
            data_object_starts,
            const_data_ranges,
            data_pad_ranges,
            data_align_marks,
            entry_pc: _,
            warnings: _,
            tls_data: _,      // separate image
            tls_init_size: _, // extent of `tls_data`
            data_relocs,
            extern_data_relocs,
            code_relocs,
            tls_data_relocs,
            tls_extern_data_relocs: _, // slot in `tls_data`, target by name
            tls_code_relocs: _,        // slot in `tls_data`, target in code
            exports: _,
            dylibs: _,
            dllmain_pc: _,
            source_files: _,
            source_path: _,
            variables: _, // frame-relative slots
            structs: _,
            enums: _,
            entry_name: _,
            entry_pragma: _,
            auto_includes: _,
            subsystem: _,
            finished_functions,
            symbols,
            synthetic_ssa_funcs,
            user_ssa_funcs,
            extern_function_imports: _, // code address space
            init_funcs: _,              // code address space
            function_aliases: _,
        } = self;
        // A repack invalidates the region boundaries; the producing pass
        // re-establishes them for the layout it emitted.
        *data_ro_len = 0;
        *data_relro_len = 0;
        data_object_starts.retain_mut(|s| match r.remap(*s, *s) {
            Some(_) if !r.in_data(*s) => false,
            Some(new) => {
                *s = new;
                true
            }
            None => false,
        });
        data_pad_ranges.retain_mut(|(lo, hi)| match r.remap_span(*lo, *hi) {
            Some((a, b)) => {
                (*lo, *hi) = (a, b);
                true
            }
            None => false,
        });
        const_data_ranges.retain_mut(|(lo, hi)| match r.remap_span(*lo, *hi) {
            Some((a, b)) => {
                (*lo, *hi) = (a, b);
                true
            }
            None => false,
        });
        data_align_marks.retain_mut(|(off, _)| {
            if !r.in_data(*off) {
                return false;
            }
            match r.remap(*off, *off) {
                Some(new) => {
                    *off = new;
                    true
                }
                None => false,
            }
        });
        for x in data_relocs.iter_mut() {
            x.remap_data_offsets(r);
        }
        for x in extern_data_relocs.iter_mut() {
            x.remap_data_offsets(r);
        }
        for x in code_relocs.iter_mut() {
            x.remap_data_offsets(r);
        }
        for x in tls_data_relocs.iter_mut() {
            x.remap_target_offsets(r);
        }
        for x in symbols.iter_mut() {
            x.remap_data_offsets(r);
        }
        for x in finished_functions.iter_mut() {
            x.remap_data_offsets(r);
        }
        for x in synthetic_ssa_funcs.iter_mut() {
            x.remap_data_offsets(r);
        }
        for x in user_ssa_funcs.iter_mut() {
            x.remap_data_offsets(r);
        }
    }
}

#[cfg(test)]
mod data_offset_tests {
    use super::*;
    use crate::c5::layout::{DataOffsets, DataRemap};

    /// Shifts every offset by a fixed amount so a field the surface does
    /// not reach stays at its original value and is visible as such.
    struct ShiftBy(i64);

    impl DataRemap for ShiftBy {
        fn in_data(&self, off: i64) -> bool {
            (0..1024).contains(&off)
        }
        fn remap(&self, off: i64, _anchor: i64) -> Option<i64> {
            Some(off + self.0)
        }
        fn remap_span(&self, lo: i64, hi: i64) -> Option<(i64, i64)> {
            Some((lo + self.0, hi + self.0))
        }
    }

    /// A `Program` with no content, for seeding one offset per field.
    fn empty_program() -> Program {
        Program {
            data: Vec::new(),
            file_asm: Vec::new(),
            asm_weak_names: Vec::new(),
            asm_global_names: Vec::new(),
            asm_visibility: Vec::new(),
            asm_unit: false,
            asm_file_names: Vec::new(),
            asm_idents: Vec::new(),
            data_ro_len: 0,
            data_relro_len: 0,
            data_object_starts: Vec::new(),
            const_data_ranges: Vec::new(),
            data_pad_ranges: Vec::new(),
            data_align_marks: Vec::new(),
            entry_pc: 0,
            warnings: Vec::new(),
            tls_data: Vec::new(),
            tls_init_size: 0,
            data_relocs: Vec::new(),
            extern_data_relocs: Vec::new(),
            code_relocs: Vec::new(),
            tls_data_relocs: Vec::new(),
            tls_extern_data_relocs: Vec::new(),
            tls_code_relocs: Vec::new(),
            exports: Vec::new(),
            dylibs: Vec::new(),
            dllmain_pc: None,
            source_files: Vec::new(),
            source_path: String::new(),
            variables: Vec::new(),
            structs: Vec::new(),
            enums: Vec::new(),
            entry_name: None,
            entry_pragma: None,
            auto_includes: Vec::new(),
            data_align: 8,
            subsystem: None,
            finished_functions: Vec::new(),
            symbols: Vec::new(),
            synthetic_ssa_funcs: Vec::new(),
            user_ssa_funcs: Vec::new(),
            extern_function_imports: Vec::new(),
            init_funcs: Vec::new(),
            function_aliases: Vec::new(),
        }
    }

    fn seeded() -> Program {
        let mut p = empty_program();
        p.data = alloc::vec![0u8; 1024];
        p.data_object_starts = alloc::vec![16];
        p.data_pad_ranges = alloc::vec![(24, 32)];
        p.data_align_marks = alloc::vec![(40, 16)];
        p.data_relocs = alloc::vec![DataReloc {
            data_offset: 48,
            target_offset: 56,
            target_anchor: 56,
        }];
        p.code_relocs = alloc::vec![CodeReloc {
            data_offset: 64,
            target_ent_pc: 0,
        }];
        p.extern_data_relocs = alloc::vec![ExternDataReloc {
            data_offset: 72,
            symbol_name: alloc::string::String::from("x"),
            addend: 0,
        }];
        let mut sym = crate::c5::symbol::Symbol {
            class: crate::c5::token::Token::Glo as i64,
            val: 80,
            defined_here: true,
            ..Default::default()
        };
        sym.name = alloc::string::String::from("g");
        p.symbols = alloc::vec![sym];
        let with_imm = |off: i64| crate::c5::ir::FunctionSsa {
            insts: alloc::vec![crate::c5::ir::Inst::ImmData(off)],
            ..Default::default()
        };
        p.synthetic_ssa_funcs = alloc::vec![with_imm(88)];
        p.user_ssa_funcs = alloc::vec![with_imm(96)];
        p
    }

    /// Every field of `Program` that stores a `.data` byte offset is
    /// reached by the offset surface. A field dropped from an
    /// implementation's destructuring -- or reached through a `..` that
    /// skips it -- leaves its offset at the pre-compaction value, which
    /// this test reports as an un-shifted offset.
    #[test]
    fn every_offset_bearing_field_is_remapped() {
        let mut p = seeded();
        p.remap_data_offsets(&ShiftBy(1000));
        assert_eq!(
            p.data_object_starts,
            alloc::vec![1016],
            "data_object_starts"
        );
        assert_eq!(
            p.data_pad_ranges,
            alloc::vec![(1024, 1032)],
            "data_pad_ranges"
        );
        assert_eq!(
            p.data_align_marks,
            alloc::vec![(1040, 16)],
            "data_align_marks"
        );
        assert_eq!(
            p.data_relocs[0].data_offset, 1048,
            "data_relocs.data_offset"
        );
        assert_eq!(
            p.data_relocs[0].target_offset, 1056,
            "data_relocs.target_offset"
        );
        assert_eq!(
            p.data_relocs[0].target_anchor, 1056,
            "data_relocs.target_anchor"
        );
        assert_eq!(
            p.code_relocs[0].data_offset, 1064,
            "code_relocs.data_offset"
        );
        assert_eq!(
            p.extern_data_relocs[0].data_offset, 1072,
            "extern_data_relocs.data_offset"
        );
        assert_eq!(p.symbols[0].val, 1080, "symbols[].val");
        let imm_data = |f: &crate::c5::ir::FunctionSsa| match f.insts[0] {
            crate::c5::ir::Inst::ImmData(off) => off,
            _ => panic!("expected ImmData"),
        };
        assert_eq!(
            imm_data(&p.synthetic_ssa_funcs[0]),
            1088,
            "synthetic_ssa_funcs Inst::ImmData"
        );
        assert_eq!(
            imm_data(&p.user_ssa_funcs[0]),
            1096,
            "user_ssa_funcs Inst::ImmData"
        );
    }

    /// A `_Thread_local` symbol's `val` indexes the TLS image, and a
    /// function symbol's is an `ent_pc`; neither is a `.data` offset.
    #[test]
    fn non_data_symbol_values_are_left_alone() {
        let mut p = seeded();
        p.symbols[0].is_thread_local = true;
        let mut fun = crate::c5::symbol::Symbol {
            class: crate::c5::token::Token::Fun as i64,
            val: 90,
            defined_here: true,
            ..Default::default()
        };
        fun.name = alloc::string::String::from("f");
        p.symbols.push(fun);
        p.remap_data_offsets(&ShiftBy(1000));
        assert_eq!(p.symbols[0].val, 80, "TLS offset must not move");
        assert_eq!(p.symbols[1].val, 90, "ent_pc must not move");
    }
}
