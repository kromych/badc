//! Native code generation. Takes a compiled (and optionally optimized)
//! [`Program`] and writes a platform-native executable that runs
//! without involving the VM. The default for the badc CLI; see also
//! [`jit::jit_run`] for the in-process variant.
//!
//! The story is intentionally simple: lower the existing stack-machine
//! bytecode straight to native instructions, then wrap the bytes in
//! whatever executable container the OS wants. Lowering is one pass
//! per arch; an opt-in register-pool analyzer ([`regalloc`]) routes
//! short-lived push/pop pairs through real registers when `-O` is on.
//!
//! ## Pipeline
//!
//! [`Program`] -> per-arch lowering -> raw machine code -> per-OS
//! image writer -> bytes on disk -> (Apple Silicon only) shell to
//! `codesign --sign -`.
//!
//! ## What we trade away
//!
//! Native binaries skip the VM's safety net. There's no
//! `--track-pointers` equivalent, no `mprotect` enforcement, no
//! code-vs-data separation check on every load and store. The
//! `--interp` mode runs the same bytecode under the VM if you want
//! the watchful version.
//!
//! ## Supported targets
//!
//! macOS aarch64, Linux aarch64 + x86_64, Windows aarch64 + x86_64.
//! Cross-compile from any host to any of those by passing
//! `--target=<spec>`. See [`Target`] for the per-target details.

use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

use super::error::C5Error;
use super::op::Op;
use super::program::Program;

mod aarch64;
mod disasm;
mod elf;
mod jit;
mod mach_o;
mod pe;
mod regalloc;
mod x86_64;

pub use jit::{jit_run, jit_run_with_options};

/// Which native binary to produce. Adding a target is a structural
/// change (new variant, new match arm in [`emit_native`]) rather than
/// a silent string parse, and gives `--target=...` somewhere to grow.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Target {
    /// macOS on Apple Silicon. Mach-O / arm64e-not-required, links
    /// against `libSystem.B.dylib` for libc, signed ad-hoc with
    /// `codesign --sign -` so dyld will load it.
    MacOSAarch64,
    /// Linux on AArch64. ELF / EM_AARCH64, links against `libc.so.6`
    /// via `/lib/ld-linux-aarch64.so.1`. No code-signing step.
    LinuxAarch64,
    /// Linux on x86_64. ELF / EM_X86_64, same scheme as
    /// `LinuxAarch64` but with a different encoder and a different
    /// dynamic-linker path (`/lib64/ld-linux-x86-64.so.2`).
    LinuxX64,
    /// Windows on x86_64. PE32+ with a console subsystem; binds
    /// against `msvcrt.dll` for the libc shapes and `kernel32.dll`
    /// for `VirtualProtect` / `LoadLibraryA` / friends. Tested via
    /// WINE on macOS hosts since native Windows runners aren't in
    /// the CI matrix.
    WindowsX64,
    /// Windows on AArch64. Same PE32+ container as `WindowsX64`,
    /// just with the COFF `Machine` field set to `IMAGE_FILE_MACHINE_ARM64`
    /// and the entry stub / mprotect thunk emitted as aarch64
    /// instructions. AAPCS64 calling convention; the existing
    /// aarch64 lowering reuses verbatim (no Windows-specific arm64
    /// ABI knobs).
    WindowsAarch64,
}

impl Target {
    /// Canonical short name for this target. Round-trips through
    /// [`Target::parse`]; used as the value of the preprocessor's
    /// `__BADC_TARGET__` macro and as the file-stem suffix for the
    /// per-target header (`headers/badc-{id}.h`).
    pub fn id_str(self) -> &'static str {
        match self {
            Target::MacOSAarch64 => "macos-aarch64",
            Target::LinuxAarch64 => "linux-aarch64",
            Target::LinuxX64 => "linux-x64",
            Target::WindowsX64 => "windows-x64",
            Target::WindowsAarch64 => "windows-arm64",
        }
    }

    /// Default target -- used when callers (mostly tests) construct a
    /// [`Compiler`] without an explicit `--target` choice. Picks the
    /// target matching the host badc is running on; someone running
    /// `badc foo.c` without naming a target gets a binary that runs
    /// on this machine. Cross-compilation always goes through
    /// `--target=...` (or `Compiler::with_target`).
    ///
    /// On a host that isn't one of badc's supported targets, falls
    /// back to `MacOSAarch64`. That fallback is mostly there to keep
    /// `cargo build` happy on, say, FreeBSD; the resulting binary
    /// will fail at exec time, but the compiler still builds.
    pub fn default_target() -> Self {
        Target::host()
    }

    /// Target matching the host this build of badc is running on.
    /// The match is resolved at compile time via `cfg!`, so each
    /// build only ever returns one value.
    pub fn host() -> Self {
        if cfg!(all(target_os = "macos", target_arch = "aarch64")) {
            Target::MacOSAarch64
        } else if cfg!(all(target_os = "linux", target_arch = "aarch64")) {
            Target::LinuxAarch64
        } else if cfg!(all(target_os = "linux", target_arch = "x86_64")) {
            Target::LinuxX64
        } else if cfg!(all(target_os = "windows", target_arch = "x86_64")) {
            Target::WindowsX64
        } else if cfg!(all(target_os = "windows", target_arch = "aarch64")) {
            Target::WindowsAarch64
        } else {
            Target::MacOSAarch64
        }
    }

    /// Parse the value passed to `--target=...` (or pick the host
    /// default when the flag is absent).
    pub fn parse(spec: Option<&str>) -> Result<Self, C5Error> {
        match spec {
            None => Ok(Target::host()),
            Some("macos-aarch64") | Some("aarch64-apple-darwin") => Ok(Target::MacOSAarch64),
            Some("linux-aarch64") | Some("aarch64-unknown-linux-gnu") => Ok(Target::LinuxAarch64),
            Some("linux-x64") | Some("linux-x86-64") | Some("x86_64-unknown-linux-gnu") => {
                Ok(Target::LinuxX64)
            }
            Some("windows-x64")
            | Some("windows-x86-64")
            | Some("x86_64-pc-windows-gnu")
            | Some("x86_64-pc-windows-msvc") => Ok(Target::WindowsX64),
            Some("windows-arm64")
            | Some("windows-aarch64")
            | Some("aarch64-pc-windows-gnullvm")
            | Some("aarch64-pc-windows-msvc") => Ok(Target::WindowsAarch64),
            Some(other) => Err(C5Error::Compile(format!(
                "unsupported native target: {other:?} \
                 (try `macos-aarch64`, `linux-aarch64`, `linux-x64`, \
                 `windows-x64`, or `windows-arm64`)"
            ))),
        }
    }
}

/// ELF machine type discriminator -- which instruction set the
/// emitted code is for. The ELF writer reads this to pick the right
/// `e_machine`, dynamic-linker path, relocation type, and `_start`
/// stub generator. Mach-O has its own dispatch.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum Machine {
    Aarch64,
    X86_64,
}

/// One resolved external import: a binding the program reaches
/// for via `Op::JsrExt`, plus everything the codegen and writer
/// need to wire it up. Built once per compilation by
/// [`ResolvedImports::resolve`] from the `#pragma binding(...)`
/// table the preprocessor parsed out of the included headers.
#[derive(Debug, Clone)]
pub(crate) struct ResolvedImport {
    /// Flat index into the program's `#pragma binding(...)` table
    /// -- the value the parser stored in the symbol's `val` field
    /// and emitted as the operand of `Op::JsrExt`. The lowering
    /// uses [`ResolvedImports::index_of_binding`] to translate this
    /// back into a GOT / IAT slot index when patching call sites.
    pub binding_idx: i64,
    /// The portable c5-side name (`"printf"`). Used by the VM to
    /// dispatch to the right Rust shim, and in compile-error
    /// messages.
    pub local_name: String,
    /// The dylib's exported symbol (`"_printf"` on macOS,
    /// `"printf"` on Linux, `"printf"` on msvcrt). Goes verbatim
    /// into the symbol table / IAT name table.
    pub real_symbol: String,
    /// Index into [`ResolvedImports::dylibs`] -- which dylib this
    /// binding resolves through. Determines the LC_LOAD_DYLIB /
    /// DT_NEEDED / IMAGE_IMPORT_DESCRIPTOR the writer emits.
    pub dylib_index: usize,
    /// `true` if the binding's prototype ended with `, ...)`. The
    /// lowering reads this to decide whether the call site needs
    /// the platform's variadic ABI (macOS arm64 stack-packing,
    /// SysV `xor eax, eax`). Default `false` for bindings whose
    /// prototype the parser hasn't seen.
    pub is_variadic: bool,
    /// Number of fixed (non-variadic) parameters from the
    /// prototype -- the count *before* the trailing `...`.
    /// macOS arm64's variadic ABI passes these in `int_arg_regs`
    /// per AAPCS64; only the variadic tail spills to the stack.
    /// Meaningful only when `is_variadic == true`.
    pub fixed_args: usize,
}

/// One resolved dylib the program needs at load time. Distinct from
/// [`super::preprocessor::DylibSpec`] in that this only contains the
/// dylibs whose bindings the program *uses* -- declaring `<windows.h>`
/// without calling any of its symbols won't pull in `kernel32.dll`.
#[derive(Debug, Clone)]
pub(crate) struct ResolvedDylib {
    /// Header-side handle (`"libc"`, `"kernel32"`). Currently used
    /// only for error messages.
    #[allow(dead_code)]
    pub name: String,
    /// Loader-search-name or filesystem path. Goes verbatim into the
    /// LC_LOAD_DYLIB / DT_NEEDED / IMAGE_IMPORT_DESCRIPTOR Name field.
    pub path: String,
}

/// The full set of imports a single compilation needs, derived from
/// the bytecode walk + the `#pragma binding` table. Each
/// [`ResolvedImport`]'s position in `imports` is also its GOT / IAT
/// slot index, so the lowering pass and the wire-format writer share
/// a single enumeration without coordinating through a static table.
#[derive(Debug, Default, Clone)]
pub(crate) struct ResolvedImports {
    pub imports: Vec<ResolvedImport>,
    pub dylibs: Vec<ResolvedDylib>,
}

impl ResolvedImports {
    /// Look up the slot index for a given binding-flat index.
    /// `None` if the program doesn't reach for that binding --
    /// callers should treat that as a codegen bug (lowering
    /// shouldn't emit a fixup for an `Op::JsrExt` operand that
    /// isn't in the resolved set).
    pub fn index_of_binding(&self, binding_idx: i64) -> Option<usize> {
        self.imports
            .iter()
            .position(|i| i.binding_idx == binding_idx)
    }

    /// Add a binding the writer needs even if the bytecode walk
    /// didn't find a call site for it. Currently used by the ELF
    /// writers' `_start` stub, which always tail-calls libc `exit`
    /// regardless of whether the user's code did.
    ///
    /// Resolves by name through `program.dylibs` the same way the
    /// bytecode walk would, so a source that forgot `<stdlib.h>`
    /// still gets the friendly
    /// "no `#pragma binding(... ::exit, ...)`" diagnostic instead
    /// of a writer-side panic.
    pub fn force_include_by_name(
        &mut self,
        local_name: &str,
        program: &Program,
    ) -> Result<(), C5Error> {
        if self.imports.iter().any(|i| i.local_name == local_name) {
            return Ok(());
        }
        let mut found: Option<(i64, &str, &str, &str, bool, usize)> = None;
        let mut binding_idx: i64 = 0;
        'outer: for spec in &program.dylibs {
            for b in &spec.bindings {
                if b.local_name == local_name {
                    found = Some((
                        binding_idx,
                        spec.name.as_str(),
                        spec.path.as_str(),
                        b.real_symbol.as_str(),
                        b.is_variadic,
                        b.fixed_args,
                    ));
                    break 'outer;
                }
                binding_idx += 1;
            }
        }
        let Some((idx, dylib_name, dylib_path, real_symbol, is_variadic, fixed_args)) = found
        else {
            return Err(C5Error::Compile(format!(
                "no `#pragma binding(<dylib>::{local_name}, ...)` is in scope -- the target's \
                 `_start` stub needs `{local_name}` and the codegen has nowhere to import it from. \
                 Did you forget to `#include <stdlib.h>`?"
            )));
        };
        let dylib_index = match self.dylibs.iter().position(|d| d.name == dylib_name) {
            Some(i) => i,
            None => {
                self.dylibs.push(ResolvedDylib {
                    name: dylib_name.to_string(),
                    path: dylib_path.to_string(),
                });
                self.dylibs.len() - 1
            }
        };
        self.imports.push(ResolvedImport {
            binding_idx: idx,
            local_name: local_name.to_string(),
            real_symbol: real_symbol.to_string(),
            dylib_index,
            is_variadic,
            fixed_args,
        });
        Ok(())
    }

    /// Walk `program.text`, collect every `Op::JsrExt` binding-idx
    /// the bytecode reaches for, look each one up in
    /// `program.dylibs`, and return the resolved set.
    ///
    /// The dylib list is built by deduplicating against
    /// `program.dylibs` ordering, so a program that calls `printf`
    /// (in `libc`) and `LoadLibraryA` (in `kernel32`) gets two
    /// dylibs in that declaration order.
    pub fn resolve(program: &Program) -> Result<Self, C5Error> {
        // Walk bytecode, collecting used binding-flat indices in
        // first-encounter order. The order determines GOT slot
        // indices; within a single compilation it just needs to be
        // deterministic.
        //
        // The walker has to skip every operand-bearing op's operand
        // word so the next iteration lands on a real opcode rather
        // than a stray operand value. The optimizer's
        // immediate-arith ops (`AddI`, `LdLocI`, ...) carry one
        // operand each; missing them in the skip set used to make
        // the walk drift onto operand bytes after the first
        // optimized site, decoding garbage and stopping early --
        // any `Op::JsrExt` past that point would then be invisible
        // and the codegen would fail with "no import slot for
        // binding N".
        let mut seen: alloc::collections::BTreeSet<i64> = alloc::collections::BTreeSet::new();
        let mut used: Vec<i64> = Vec::new();
        let mut pc = 0;
        while pc < program.text.len() {
            let Some(op) = Op::from_i64(program.text[pc]) else {
                // Unknown opcode -- not our problem here; the
                // optimizer / VM will surface it.
                break;
            };
            if matches!(op, Op::JsrExt) {
                let idx = program.text[pc + 1];
                if seen.insert(idx) {
                    used.push(idx);
                }
            }
            pc += op.word_size();
        }

        // Resolve each used binding-idx through `program.dylibs`.
        // Build the dylib list lazily: each new dylib gets
        // appended once and its index is reused for any further
        // bindings.
        let mut dylibs: Vec<ResolvedDylib> = Vec::new();
        let mut imports: Vec<ResolvedImport> = Vec::new();
        for binding_idx in used {
            let Some((spec, b)) = lookup_binding(program, binding_idx) else {
                return Err(C5Error::Compile(format!(
                    "Op::JsrExt operand {binding_idx} is out of range for the program's \
                     `#pragma binding(...)` table"
                )));
            };
            let dylib_index = match dylibs.iter().position(|d| d.name == spec.name) {
                Some(i) => i,
                None => {
                    dylibs.push(ResolvedDylib {
                        name: spec.name.clone(),
                        path: spec.path.clone(),
                    });
                    dylibs.len() - 1
                }
            };
            imports.push(ResolvedImport {
                binding_idx,
                local_name: b.local_name.clone(),
                real_symbol: b.real_symbol.clone(),
                dylib_index,
                is_variadic: b.is_variadic,
                fixed_args: b.fixed_args,
            });
        }

        Ok(ResolvedImports { imports, dylibs })
    }
}

/// Find the binding at flat-index `binding_idx` across all dylibs
/// in declaration order. The lexer assigned this index when seeding
/// each binding's local_name as a `Token::Sys` symbol.
fn lookup_binding(
    program: &Program,
    binding_idx: i64,
) -> Option<(
    &super::preprocessor::DylibSpec,
    &super::preprocessor::Binding,
)> {
    if binding_idx < 0 {
        return None;
    }
    let target = binding_idx as usize;
    let mut running = 0usize;
    for spec in &program.dylibs {
        if running + spec.bindings.len() > target {
            return Some((spec, &spec.bindings[target - running]));
        }
        running += spec.bindings.len();
    }
    None
}

/// Where each piece of the program-being-built ends up in the final
/// image. The codegen and image-writer halves both populate this --
/// the codegen knows the code bytes, the pinned data bytes, and which
/// libc symbols the code wants to call; the writer arranges them into
/// segments and patches the codegen's GOT / data / function-pointer
/// placeholders with the actual vmaddrs.
#[derive(Debug, Default)]
pub(crate) struct Build {
    /// Machine code, ready to be placed in `__TEXT,__text`.
    pub text: Vec<u8>,
    /// Initialised data segment: string literals + zero-initialised
    /// globals. Copied into `__DATA,__data` by the writer; offsets
    /// into this buffer match the bytecode's view of the data segment,
    /// so a `DataFixup { data_offset: K }` resolves to byte K of this
    /// `Vec`.
    pub data: Vec<u8>,
    /// Offset (within `text`) of the program's entry point. Becomes
    /// the entry address of `LC_MAIN`.
    pub entry_offset: usize,
    /// Each `(adrp_offset, import_index)` records a pair of
    /// placeholder instructions (adrp + ldr) the codegen left for the
    /// image writer to patch with the resolved page address of the
    /// matching __got slot. See [`aarch64::IMPORTS`] for the symbol
    /// order; the writer relies on the same indexing.
    pub got_fixups: Vec<GotFixup>,
    /// Each entry records an `adrp + add` placeholder pair the codegen
    /// left for a load-of-data-address sequence. The writer patches it
    /// with the page-relative address of `__data + data_offset`.
    pub data_fixups: Vec<DataFixup>,
    /// Each entry records an `adrp + add` placeholder pair the codegen
    /// left for a function-pointer literal. The writer patches it with
    /// the page-relative address of `__text + target_native_offset`.
    pub func_fixups: Vec<FuncFixup>,
    /// Sparse map from bytecode PC (index into `Program::text`) to
    /// the byte offset within `Build::text` where that op's emitted
    /// instructions start. `usize::MAX` for indices that aren't a
    /// bytecode instruction's first word (operand slots, etc.). The
    /// last entry is the total code length, so `[i+1] - [i]` gives
    /// the byte length of the op at PC `i`.
    pub bytecode_to_native: Vec<usize>,
    /// Per-Build resolved import set. Built by lowering once it knows
    /// which libc ops the program uses; consumed by the wire-format
    /// writer to populate the IAT / dynsym / __got tables.
    /// `GotFixup::import_index` is an index into `imports.imports`.
    pub imports: ResolvedImports,
    /// ABI in effect for this build. Set by `lower_for` from the
    /// target. The wire-format writers read it for entry-stub
    /// register choices (which int-arg register holds argc /
    /// argv at `_start`, etc.) so the choice lives in one place
    /// rather than being re-derived from `Machine` per writer.
    pub abi: Abi,
    /// Thread-local data segment, byte-for-byte copy of
    /// `Program::tls_data`. The writer routes the first
    /// `tls_init_size` bytes to `.tdata` (initialised TLS image)
    /// and the remainder to `.tbss` (zero-fill TLS bss). The
    /// per-target codegen lowering for `Op::TlsLea` reads
    /// `tls_data.len()` to compute variant-2 (x86_64) negative
    /// offsets at emit time.
    pub tls_data: Vec<u8>,
    /// Number of `tls_data` bytes that are statically initialised.
    /// `tls_data.len() - tls_init_size` bytes are zero-fill.
    pub tls_init_size: usize,
    /// Win64 TLS-index fixups -- one entry per `Op::TlsLea` site
    /// on a Win64 target. The writer reserves a 4-byte
    /// `_tls_index` slot in `.data`, builds the
    /// `IMAGE_TLS_DIRECTORY`, and patches each fixup with the
    /// displacement to the slot. Empty for non-Win64 targets and
    /// for Win64 programs with no `_Thread_local` globals.
    pub tls_index_fixups: Vec<TlsIndexFixup>,
    /// macOS arm64 Thread-Local Variable fixups -- one entry per
    /// `Op::TlsLea` site on macOS. Each records an
    /// `adrp + add` pair to be patched with the address of the
    /// per-variable `__thread_vars` descriptor.
    pub macho_tlv_fixups: Vec<MachoTlvFixup>,
    /// macOS arm64 TLV descriptors. One entry per distinct TLS
    /// variable referenced by the program; each descriptor's
    /// `offset_in_block` is the byte offset within
    /// `Build::tls_data` (matching what `Op::TlsLea` records).
    /// The writer emits a 24-byte descriptor per entry into the
    /// `__DATA,__thread_vars` section: `[ __tlv_bootstrap | 0 |
    /// offset_in_block ]`. Empty unless the target is macOS arm64
    /// and the program declares `_Thread_local` globals.
    pub macho_tlv_descriptors: Vec<MachoTlvDescriptor>,
}

/// One macOS arm64 Thread-Local Variable. A 24-byte `__thread_vars`
/// descriptor is emitted per entry; the codegen's
/// [`MachoTlvFixup`]s reference these by index.
#[derive(Debug, Clone, Copy)]
pub(crate) struct MachoTlvDescriptor {
    /// Byte offset within `Build::tls_data` where this variable
    /// starts. Mirrors `Op::TlsLea`'s operand.
    pub offset_in_block: u64,
}

/// Refer-by-index relocation between a code site and a `__got` slot.
/// The codegen emits zero bytes where the adrp + ldr would go, then
/// records this so the Mach-O writer can fill them in once it knows
/// the data segment's final vmaddr.
#[derive(Debug, Clone, Copy)]
pub(crate) struct GotFixup {
    /// Byte offset within `Build::text` of the adrp instruction.
    /// `adrp_offset + 4` is the matching ldr.
    pub adrp_offset: usize,
    /// Index into [`aarch64::IMPORTS`].
    pub import_index: usize,
}

/// Relocation for `Op::Imm <data_offset>`: the codegen emits an
/// `adrp + add` placeholder pair to materialize the address into the
/// VM accumulator, and the writer patches both halves once it knows
/// where `__data` lands in vmaddr space.
#[derive(Debug, Clone, Copy)]
pub(crate) struct DataFixup {
    /// Byte offset within `Build::text` of the adrp instruction.
    /// `adrp_offset + 4` is the matching add.
    pub adrp_offset: usize,
    /// Offset into `Build::data`.
    pub data_offset: u64,
}

// TLS relocations don't need a writer-time fixup type for Linux:
// the per-target TLS offset (variant-1 TCB_HEAD + offset on
// aarch64, variant-2 -(tls_size - offset) on x86_64) only depends
// on the total TLS block size, which is known when the codegen
// lowers `Op::TlsLea`. The codegen materialises the final
// immediate inline; the writer just needs `Build::tls_data` /
// `Build::tls_init_size` to lay out `.tdata` / `.tbss`.
//
// Win64 is different: TLS access goes through `_tls_index`, a
// DWORD whose runtime value the loader writes when it processes
// the TLS directory. The codegen reads that value at every TLS
// access (so the same compiled image works regardless of which
// slot the loader picked). The address of `_tls_index` isn't
// known until the writer lays out the data segments, so each
// `Op::TlsLea` records a [`TlsIndexFixup`] for the writer to
// patch.

/// Relocation for a Win64 TLS access. Records a code site whose
/// instruction needs to be patched with the displacement to the
/// `_tls_index` DWORD slot. The PE writer reserves the slot in
/// `.data` and patches all such fixups once it knows the layout.
///
/// On x86_64 the fixup points at the start of the
/// `mov ecx, [rip+disp32]` instruction; the writer rewrites the
/// disp32 field. On aarch64 the fixup points at an `adrp + ldr`
/// pair (same encoding shape as [`DataFixup`]) that loads the
/// 32-bit `_tls_index` value.
#[derive(Debug, Clone, Copy)]
pub(crate) struct TlsIndexFixup {
    /// Byte offset within `Build::text` of the instruction (or
    /// instruction pair) needing patching. See the per-arch
    /// docs above for the exact encoding shape.
    pub instr_offset: usize,
}

/// Relocation for a Win64 TLS access whose final per-variable
/// offset is too large to fit the inline `add` immediate. The
/// codegen records the offset; the writer patches a
/// movz/movk-style sequence. None of our current fixtures trip
/// this -- the `add x19, x16, #imm12` form covers TLS blocks
/// up to 4080 bytes -- but the type is here so larger TLS
/// programs surface a real error rather than silent
/// truncation.
#[derive(Debug, Clone, Copy)]
#[allow(dead_code)]
pub(crate) struct TlsOffsetFixup {
    pub instr_offset: usize,
    pub var_offset: u64,
}

/// Relocation for a macOS arm64 Thread-Local Variable access.
/// The codegen emits an `adrp + add` pair that materialises the
/// address of the variable's `__thread_vars` descriptor (a
/// 24-byte triple of pointers); the Mach-O writer patches both
/// halves with the descriptor's vmaddr once the
/// `__DATA,__thread_vars` section is laid out.
///
/// The descriptor is shared across every access to the same TLS
/// variable -- the walker dedups TlsLea offsets up front so each
/// variable gets a single descriptor with a stable
/// `descriptor_index` ordering.
#[derive(Debug, Clone, Copy)]
pub(crate) struct MachoTlvFixup {
    /// Byte offset within `Build::text` of the adrp instruction
    /// that opens the descriptor-address materialisation. The
    /// matching `add` lives at `adrp_offset + 4`.
    pub adrp_offset: usize,
    /// Index into [`Build::macho_tlv_descriptors`]. The writer
    /// resolves this to the descriptor's vmaddr at patch time.
    pub descriptor_index: usize,
}

/// Relocation for a function-pointer literal (`Op::Imm <CODE_BASE+pc>`).
/// Same `adrp + add` shape as [`DataFixup`], but the target is another
/// position inside `Build::text` rather than `Build::data`.
#[derive(Debug, Clone, Copy)]
pub(crate) struct FuncFixup {
    /// Byte offset within `Build::text` of the adrp instruction.
    pub adrp_offset: usize,
    /// Byte offset within `Build::text` of the target function's first
    /// instruction. Resolved by the codegen during `lower()` so the
    /// writer doesn't need a bytecode-to-native map.
    pub target_native_offset: usize,
}

/// User-controllable knobs for the native lowering pass. Distinct
/// from [`TargetOptions`] (which encodes platform ABI -- not user
/// choosable). Threaded through [`emit_native_with_options`],
/// [`dump_native_listing_with_options`], and
/// [`jit_run_with_options`]; the zero-arg public functions
/// (`emit_native`, ...) construct `NativeOptions::default()` and
/// delegate.
#[derive(Debug, Clone, Copy, Default)]
pub struct NativeOptions {
    /// Run the per-function register allocator. The c5 bytecode
    /// pushes the left operand of every binary op onto the stack;
    /// the regalloc routes most of those pushes through registers
    /// instead (x20..x27 + x9..x15 on aarch64; rbx/r12/r14/r15 on
    /// x86_64) so the matching binary op / `Si` / `Sc` reads its
    /// operand from a register. The prologue saves only the
    /// callee-saved slots actually used, and any function whose
    /// max depth exceeds the per-arch pool capacity falls back to
    /// real-stack pushes verbatim.
    ///
    /// Off by default. `--optimize` / `-O` flips it on, alongside
    /// the bytecode optimizer. The two passes are independent --
    /// each is correct on the other's input -- but together they
    /// produce the fastest emitted code.
    ///
    /// The two always-on peepholes -- self-mov elision (in
    /// `emit_mov_reg` / `emit_mov_rr`) and the cmp+branch fusion
    /// described in the per-backend module docs -- run regardless
    /// of this flag, since neither has a tradeoff worth gating.
    pub optimize: bool,
}

impl NativeOptions {
    /// Convenience builder. `NativeOptions::new().with_optimize()`.
    pub const fn new() -> Self {
        Self { optimize: false }
    }

    /// Set [`Self::optimize`] = true and return self.
    pub const fn with_optimize(mut self) -> Self {
        self.optimize = true;
        self
    }
}

/// Translate a [`Program`] into a native binary. The bytes are written
/// to `out` in whatever format the [`Target`] requires; on macOS, the
/// caller is responsible for invoking `codesign` afterwards (handled
/// by the CLI shim, not by this function -- code-signing is a runtime
/// concern, not part of the format).
///
/// Returns the raw image bytes so the caller can decide whether to
/// write them to disk, embed them, hash them, etc.
///
/// This is the zero-options shorthand; pass `NativeOptions` via
/// [`emit_native_with_options`] to enable optimization knobs like
/// the register allocator.
pub fn emit_native(program: &Program, target: Target) -> Result<Vec<u8>, C5Error> {
    emit_native_with_options(program, target, NativeOptions::default())
}

/// Variant of [`emit_native`] that accepts user-controllable
/// optimization knobs.
pub fn emit_native_with_options(
    program: &Program,
    target: Target,
    options: NativeOptions,
) -> Result<Vec<u8>, C5Error> {
    let build = lower_for(program, target, options)?;
    write_for(&build, target)
}

/// Lower the program for `target`, returning the per-arch `Build`
/// without writing to any container. Used by both [`emit_native`]
/// (which then runs the container writer) and the listing-dump path
/// (which inspects the lowered bytes directly).
///
/// Resolves the import set once up front (so the per-arch lowerings
/// share an enumeration with the writer) and stitches it onto the
/// returned [`Build`] before handing it back.
fn lower_for(program: &Program, target: Target, options: NativeOptions) -> Result<Build, C5Error> {
    let mut imports = ResolvedImports::resolve(program)?;
    // Linux ELF's `_start` always tail-calls libc `exit` so glibc
    // gets to flush stdio and run atexit before the kernel reaps us.
    // The bytecode walk only finds ops the *user's* code calls --
    // a `int main() { return 42; }` has no `Op::Exit` -- so we
    // force-include it here. Resolves through the same
    // `program.dylibs` lookup as user-emitted ops would, so a
    // source that omits `<stdlib.h>` still gets the friendly
    // "no `#pragma binding(... ::exit, ...)`" error.
    if matches!(target, Target::LinuxAarch64 | Target::LinuxX64) {
        imports.force_include_by_name("exit", program)?;
    }
    // macOS arm64 with `_Thread_local` globals needs libSystem
    // loaded so dyld can bind `__tlv_bootstrap` for the TLV
    // descriptors. The bind opcode the writer emits names
    // libSystem by ordinal (the position of the libSystem
    // LC_LOAD_DYLIB in the load-command stream); when the
    // program doesn't call any libc function the resolver
    // wouldn't otherwise pull libSystem in, so we force one
    // libSystem-resident symbol -- `exit`, which the prelude
    // always declares -- to keep the dylib in scope. The
    // forced binding is harmless for programs that never call
    // exit themselves.
    if matches!(target, Target::MacOSAarch64) && !program.tls_data.is_empty() {
        imports.force_include_by_name("exit", program)?;
    }
    let mut build = match target {
        Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64 => {
            aarch64::lower(program, target, options, &imports)?
        }
        Target::LinuxX64 | Target::WindowsX64 => x86_64::lower(program, target, options, &imports)?,
    };
    build.imports = imports;
    build.abi = target.abi();
    append_build_info(&mut build);
    Ok(build)
}

/// Append the [`crate::BUILD_INFO`] marker to the tail of
/// `Build::text`. The bytes never get executed -- the entry
/// point is at `build.entry_offset` and every function ends
/// with a return -- so this is purely a `strings(1)`-friendly
/// fingerprint that says which badc revision emitted the
/// binary.
///
/// The marker is NUL-terminated and prefixed by a 4-byte
/// alignment pad so the start of the string sits on a 4-byte
/// boundary regardless of the per-arch instruction stream's
/// trailing alignment. Disassemblers walking past the last
/// real instruction will see noise; that's fine because the
/// runtime never branches into this region.
fn append_build_info(build: &mut Build) {
    // 4-byte align the start so the marker is easy to spot in a
    // hex dump (and so per-arch instruction-alignment invariants
    // aren't violated for any later additions).
    while !build.text.len().is_multiple_of(4) {
        build.text.push(0);
    }
    build.text.extend_from_slice(crate::BUILD_INFO.as_bytes());
    build.text.push(0);
}

fn write_for(build: &Build, target: Target) -> Result<Vec<u8>, C5Error> {
    match target {
        Target::MacOSAarch64 => mach_o::write(build),
        Target::LinuxAarch64 => elf::write(build, Machine::Aarch64),
        Target::LinuxX64 => elf::write(build, Machine::X86_64),
        Target::WindowsX64 => pe::write(build, Machine::X86_64),
        Target::WindowsAarch64 => pe::write(build, Machine::Aarch64),
    }
}

/// Render a textual listing of the lowered native code for `target`,
/// grouped by the c4 op that produced each region. Output is hex
/// bytes per op plus header metadata (target, sizes, entry offset,
/// fixup counts). Triggered by the CLI's `--dump-asm` flag.
pub fn dump_native_listing(
    program: &Program,
    target: Target,
) -> Result<alloc::string::String, C5Error> {
    dump_native_listing_with_options(program, target, NativeOptions::default())
}

/// Variant of [`dump_native_listing`] that accepts optimization
/// knobs. The returned listing reflects whatever lowering the
/// options selected.
pub fn dump_native_listing_with_options(
    program: &Program,
    target: Target,
    options: NativeOptions,
) -> Result<alloc::string::String, C5Error> {
    let build = lower_for(program, target, options)?;
    Ok(disasm::dump(program, &build, target))
}

/// Per-target ABI knobs that affect lowering, not just the final
/// Architecture flavour the lowering pass picks. Mirrors
/// [`Machine`] but lives next to [`Abi`] so the per-target table
/// can carry it directly without an extra cross-reference.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum Arch {
    Aarch64,
    X86_64,
}

/// Per-target ABI description. Replaces the old free-form
/// `TargetOptions { variadic_on_stack, win64_abi }` with an
/// explicit catalogue of every choice the lowering pass has to
/// make: which registers carry integer arguments, how much
/// shadow space the caller reserves, whether variadic calls go
/// through the macOS-flavoured stack-packing path, and whether
/// the System V `xor eax, eax` (zero XMM count) pre-call dance
/// is required.
///
/// Each native backend reads only the fields it needs; adding a
/// target is one new row in [`Target::abi`]. Register lists are
/// raw `u8` codes (the same encoding `aarch64::Reg` /
/// `x86_64::Reg` use) so a single `Abi` struct can describe
/// both arches without a big sum type at the use site -- the
/// per-arch lowering wraps the bytes in its own `Reg`.
#[derive(Debug, Clone, Copy)]
pub(crate) struct Abi {
    /// Arch the lowering should produce instructions for. The
    /// `lower_for` dispatch already keys on this, but having it
    /// inside `Abi` lets ABI-aware helpers (entry stubs, fixup
    /// patchers) carry one struct around rather than two. Read
    /// in step 3 of the ABI plan when the entry-stub builder
    /// lands.
    #[allow(dead_code)]
    pub arch: Arch,
    /// Integer arg-passing registers, in declaration order. The
    /// lowering walks c4-stack arg slots into these in order;
    /// any args past the slice spill to the native stack at
    /// `[rsp + shadow_space + (i - regs.len()) * 8]`.
    ///
    /// AAPCS64 (Linux/macOS/Windows on aarch64): x0..x7.
    /// SysV x86_64: rdi, rsi, rdx, rcx, r8, r9.
    /// Win64 x86_64: rcx, rdx, r8, r9.
    pub int_arg_regs: &'static [u8],
    /// Bytes of caller-reserved "shadow space" at the start of
    /// the outgoing-args area. Win64 reserves 32 (4 register
    /// args' worth) so the callee may spill them to known
    /// offsets; SysV / AAPCS64 reserve none.
    pub shadow_space: u32,
    /// Variadic calls follow a non-register-only ABI on macOS
    /// arm64: variadic args spill to the native stack with
    /// 8-byte spacing rather than going through `int_arg_regs`.
    /// The lowering pre-allocates a scratch region before the
    /// call and packs args there. Linux AAPCS64 and SysV both
    /// pass variadic args identically to fixed args, so this
    /// flag is unset for them.
    pub variadic_on_stack: bool,
    /// SysV x86_64 requires `%al` to hold the count of XMM
    /// regs used at every variadic call site; c4 has no
    /// floats so the count is always 0, which means a single
    /// `xor eax, eax` before each variadic call. Win64 has no
    /// such requirement.
    pub variadic_zero_xmm_count: bool,
}

impl Default for Abi {
    /// Picks `MacOSAarch64`'s row. Only the
    /// `#[derive(Default)]` on `Build` reaches this path; real
    /// call sites resolve through `Target::abi`. The choice of
    /// macOS-aarch64 mirrors `Target::default_target` on the
    /// macOS host (and is harmless on others, since
    /// `Build::default` outputs are never used by writers).
    fn default() -> Self {
        Target::MacOSAarch64.abi()
    }
}

impl Target {
    /// ABI description for this target. Used by both the
    /// lowering pass and the entry-stub builders. Kept as a
    /// match against `Target` so adding a target is one row
    /// here.
    pub(crate) fn abi(self) -> Abi {
        // Register-number constants for the per-arch register
        // banks. These match `aarch64::Reg::X0`..`X7` and
        // `x86_64::Reg::RAX`..`R15`; spelled out as raw bytes
        // so this table compiles without depending on either
        // per-arch module.
        const X86_RAX: u8 = 0;
        const X86_RCX: u8 = 1;
        const X86_RDX: u8 = 2;
        const X86_RSI: u8 = 6;
        const X86_RDI: u8 = 7;
        const X86_R8: u8 = 8;
        const X86_R9: u8 = 9;
        let _ = X86_RAX; // intentional: kept for symmetry / future use
        const AARCH64_INT_ARGS: &[u8] = &[0, 1, 2, 3, 4, 5, 6, 7];
        const SYSV_INT_ARGS: &[u8] = &[X86_RDI, X86_RSI, X86_RDX, X86_RCX, X86_R8, X86_R9];
        const WIN64_INT_ARGS: &[u8] = &[X86_RCX, X86_RDX, X86_R8, X86_R9];

        match self {
            Target::MacOSAarch64 => Abi {
                arch: Arch::Aarch64,
                int_arg_regs: AARCH64_INT_ARGS,
                shadow_space: 0,
                variadic_on_stack: true,
                variadic_zero_xmm_count: false,
            },
            Target::LinuxAarch64 => Abi {
                arch: Arch::Aarch64,
                int_arg_regs: AARCH64_INT_ARGS,
                shadow_space: 0,
                variadic_on_stack: false,
                variadic_zero_xmm_count: false,
            },
            Target::LinuxX64 => Abi {
                arch: Arch::X86_64,
                int_arg_regs: SYSV_INT_ARGS,
                shadow_space: 0,
                variadic_on_stack: false,
                variadic_zero_xmm_count: true,
            },
            Target::WindowsX64 => Abi {
                arch: Arch::X86_64,
                int_arg_regs: WIN64_INT_ARGS,
                shadow_space: 32,
                variadic_on_stack: false,
                variadic_zero_xmm_count: false,
            },
            Target::WindowsAarch64 => Abi {
                arch: Arch::Aarch64,
                int_arg_regs: AARCH64_INT_ARGS,
                shadow_space: 0,
                variadic_on_stack: false,
                variadic_zero_xmm_count: false,
            },
        }
    }
}
