//! Native code generation. Takes a compiled (and optionally optimized)
//! [`Program`] and writes a platform-native executable that runs
//! without involving the VM.
//!
//! The story is intentionally simple: lower the existing stack-machine
//! bytecode straight to native instructions (no SSA, no register
//! allocation worth the name -- the VM "accumulator" lives in a
//! callee-saved register, the VM "stack" rides on the native stack),
//! then wrap the bytes in whatever executable container the OS wants.
//!
//! ## Pipeline
//!
//! [`Program`] -> per-arch [`Codegen`] -> raw machine code -> per-OS
//! image writer -> bytes on disk -> (Apple Silicon only) shell to
//! `codesign --sign -`.
//!
//! ## What we trade away
//!
//! Native binaries skip the VM's safety net. There's no `--track-pointers`
//! equivalent, no `mprotect` enforcement, no code-vs-data separation
//! check on every load and store. If you want those, run under the VM
//! instead. `--emit-native` is the "I want a real binary" mode; the
//! VM is the "I want my hand held" mode.
//!
//! ## Supported targets
//!
//! Phase 1: macOS aarch64 only. Other targets land later --
//! see milestone tracker for the order.

use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

use super::error::C4Error;
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
/// a silent string parse, and gives `--emit-native` somewhere to grow.
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
    /// target matching the host badc is running on; the assumption is
    /// that someone running `badc foo.c --emit-native` without naming
    /// a target wants a binary that will run on this machine. Cross-
    /// compilation always goes through `--target=...` (or
    /// `Compiler::with_target`).
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
    pub fn parse(spec: Option<&str>) -> Result<Self, C4Error> {
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
            Some(other) => Err(C4Error::Compile(format!(
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

/// One resolved libc import: a libc op the program reaches for, plus
/// everything the codegen and writer need to wire it up. Built once
/// per compilation by [`ResolvedImports::resolve`] from the
/// `#pragma binding(...)` table the preprocessor parsed out of the
/// included headers.
#[derive(Debug, Clone)]
pub(crate) struct ResolvedImport {
    /// The bytecode op that lowers to this call (e.g. [`Op::Prtf`]).
    /// Used by the lowering pass to find the matching slot when it
    /// emits an adrp+ldr / call-qword-rip sequence.
    pub op: Op,
    /// The portable c4-side name (`"printf"`). Currently only kept
    /// for diagnostics in compile-error messages; the lowering and
    /// writers key off `op` and `real_symbol`.
    #[allow(dead_code)]
    pub c4_name: String,
    /// The dylib's exported symbol (`"_printf"` on macOS,
    /// `"printf"` on Linux, `"printf"` on msvcrt). Goes verbatim
    /// into the symbol table / IAT name table.
    pub real_symbol: String,
    /// Index into [`ResolvedImports::dylibs`] -- which dylib this
    /// binding resolves through. Determines the LC_LOAD_DYLIB /
    /// DT_NEEDED / IMAGE_IMPORT_DESCRIPTOR the writer emits.
    pub dylib_index: usize,
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
    /// Look up the slot index for a given op. `None` if the program
    /// doesn't use it -- callers should treat that as a codegen bug
    /// (lowering shouldn't emit a fixup for an op that isn't in the
    /// resolved set).
    pub fn index_of_op(&self, op: Op) -> Option<usize> {
        self.imports.iter().position(|i| i.op == op)
    }

    /// Add a binding the writer needs even if the bytecode walk
    /// didn't find a call site for it. Currently used by the ELF
    /// writers' `_start` stub, which always tail-calls `Op::Exit`
    /// regardless of whether the user's code did.
    ///
    /// Resolves through `program.dylibs` the same way the bytecode
    /// walk would, so a source that forgot `<stdlib.h>` still gets
    /// the same "no `#pragma binding(... ::exit, ...)`" diagnostic
    /// instead of a writer-side panic.
    pub fn force_include(&mut self, op: Op, program: &Program) -> Result<(), C4Error> {
        if self.index_of_op(op).is_some() {
            return Ok(());
        }
        let c4_name = op_to_c4_name(op).expect("force_include called with non-libc op");
        let mut found: Option<(&str, &str, &str)> = None;
        for spec in &program.dylibs {
            if let Some(b) = spec.bindings.iter().find(|b| b.c4_name == c4_name) {
                found = Some((
                    spec.name.as_str(),
                    spec.path.as_str(),
                    b.real_symbol.as_str(),
                ));
                break;
            }
        }
        let Some((dylib_name, dylib_path, real_symbol)) = found else {
            return Err(C4Error::Compile(format!(
                "no `#pragma binding(<dylib>::{c4_name}, ...)` is in scope -- the target's \
                 `_start` stub needs `{c4_name}` and the codegen has nowhere to import it from. \
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
            op,
            c4_name: c4_name.to_string(),
            real_symbol: real_symbol.to_string(),
            dylib_index,
        });
        Ok(())
    }

    /// Walk `program.text`, collect every libc op the bytecode
    /// reaches for, look each one up in `program.dylibs`, and
    /// return the resolved set.
    ///
    /// The dylib list is built by deduplicating against
    /// `program.dylibs` ordering, so a program that uses `printf`
    /// (in `libc`) and `LoadLibraryA` (in `kernel32`) gets two
    /// dylibs in that declaration order.
    pub fn resolve(program: &Program) -> Result<Self, C4Error> {
        // Walk bytecode, collecting used libc ops in first-encounter
        // order. The order determines GOT slot indices; within a
        // single compilation it just needs to be deterministic.
        let mut seen: alloc::collections::BTreeSet<Op> = alloc::collections::BTreeSet::new();
        let mut used: Vec<Op> = Vec::new();
        let mut pc = 0;
        while pc < program.text.len() {
            let Some(op) = Op::from_i64(program.text[pc]) else {
                // Unknown opcode -- not our problem here; the
                // optimizer / VM will surface it.
                break;
            };
            pc += 1;
            if matches!(
                op,
                Op::Lea | Op::Imm | Op::Ent | Op::Adj | Op::Jmp | Op::Jsr | Op::Bz | Op::Bnz
            ) {
                pc += 1;
            }
            if op_to_c4_name(op).is_some() && seen.insert(op) {
                used.push(op);
            }
        }

        // Resolve each used op through `program.dylibs`. Build the
        // dylib list lazily: each new dylib gets appended once and
        // its index is reused for any further bindings.
        let mut dylibs: Vec<ResolvedDylib> = Vec::new();
        let mut imports: Vec<ResolvedImport> = Vec::new();
        for op in used {
            let c4_name = op_to_c4_name(op).expect("only c4-name-bearing ops were inserted");
            let mut found: Option<(&str, &str, &str)> = None;
            for spec in &program.dylibs {
                if let Some(b) = spec.bindings.iter().find(|b| b.c4_name == c4_name) {
                    found = Some((
                        spec.name.as_str(),
                        spec.path.as_str(),
                        b.real_symbol.as_str(),
                    ));
                    break;
                }
            }
            let Some((dylib_name, dylib_path, real_symbol)) = found else {
                return Err(C4Error::Compile(format!(
                    "no `#pragma binding(<dylib>::{c4_name}, ...)` is in scope -- the program \
                     calls `{c4_name}` and the codegen has nowhere to import it from. Did you \
                     forget to `#include <stdio.h>` / `<string.h>` / `<stdlib.h>` / `<unistd.h>` \
                     / `<dlfcn.h>`?"
                )));
            };
            let dylib_index = match dylibs.iter().position(|d| d.name == dylib_name) {
                Some(i) => i,
                None => {
                    dylibs.push(ResolvedDylib {
                        name: dylib_name.to_string(),
                        path: dylib_path.to_string(),
                    });
                    dylibs.len() - 1
                }
            };
            imports.push(ResolvedImport {
                op,
                c4_name: c4_name.to_string(),
                real_symbol: real_symbol.to_string(),
                dylib_index,
            });
        }

        Ok(ResolvedImports { imports, dylibs })
    }
}

/// Map a bytecode op to its portable c4-side name, used as the
/// `c4_name` lookup key against `#pragma binding`. Returns `None` for
/// non-libc ops -- those don't go through GOT/IAT.
fn op_to_c4_name(op: Op) -> Option<&'static str> {
    Some(match op {
        Op::Open => "open",
        Op::Read => "read",
        Op::Clos => "close",
        Op::Prtf => "printf",
        Op::Malc => "malloc",
        Op::Free => "free",
        Op::Mset => "memset",
        Op::Mcmp => "memcmp",
        Op::Mcpy => "memcpy",
        Op::Exit => "exit",
        Op::Write => "write",
        Op::Genv => "getenv",
        Op::Senv => "setenv",
        Op::Dlop => "dlopen",
        Op::Dlsm => "dlsym",
        Op::Dlcl => "dlclose",
        Op::Dler => "dlerror",
        _ => return None,
    })
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
    /// Run the per-function register allocator. The c4 bytecode
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
pub fn emit_native(program: &Program, target: Target) -> Result<Vec<u8>, C4Error> {
    emit_native_with_options(program, target, NativeOptions::default())
}

/// Variant of [`emit_native`] that accepts user-controllable
/// optimization knobs.
pub fn emit_native_with_options(
    program: &Program,
    target: Target,
    options: NativeOptions,
) -> Result<Vec<u8>, C4Error> {
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
fn lower_for(program: &Program, target: Target, options: NativeOptions) -> Result<Build, C4Error> {
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
        imports.force_include(Op::Exit, program)?;
    }
    let mut build = match target {
        Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64 => {
            aarch64::lower(program, target, options, &imports)?
        }
        Target::LinuxX64 | Target::WindowsX64 => x86_64::lower(program, target, options, &imports)?,
    };
    build.imports = imports;
    Ok(build)
}

fn write_for(build: &Build, target: Target) -> Result<Vec<u8>, C4Error> {
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
) -> Result<alloc::string::String, C4Error> {
    dump_native_listing_with_options(program, target, NativeOptions::default())
}

/// Variant of [`dump_native_listing`] that accepts optimization
/// knobs. The returned listing reflects whatever lowering the
/// options selected.
pub fn dump_native_listing_with_options(
    program: &Program,
    target: Target,
    options: NativeOptions,
) -> Result<alloc::string::String, C4Error> {
    let build = lower_for(program, target, options)?;
    Ok(disasm::dump(program, &build, target))
}

/// Per-target ABI knobs that affect lowering, not just the final
/// container. Each native backend reads only the fields it needs;
/// adding a target normally just means adding a row to `options()`.
#[derive(Debug, Clone, Copy)]
pub(crate) struct TargetOptions {
    /// macOS arm64 packs variadic args into stack scratch slots
    /// (8-byte spaced) regardless of how many would fit in
    /// x0..x7. Standard AAPCS64 (Linux) uses the same registers as
    /// non-variadic calls. `true` selects the macOS dance.
    pub variadic_on_stack: bool,
    /// Use the Windows x64 calling convention rather than System V:
    /// integer args go in `rcx`, `rdx`, `r8`, `r9` (only four
    /// register slots, not six), the caller reserves a 32-byte
    /// shadow space below each call site, and the entry point comes
    /// in 16-aligned with the OS-pushed return address on top of
    /// the stack instead of a Linux-style argc-on-stack vector.
    pub win64_abi: bool,
}

impl Target {
    pub(crate) fn options(self) -> TargetOptions {
        match self {
            Target::MacOSAarch64 => TargetOptions {
                variadic_on_stack: true,
                win64_abi: false,
            },
            Target::LinuxAarch64 => TargetOptions {
                variadic_on_stack: false,
                win64_abi: false,
            },
            Target::LinuxX64 => TargetOptions {
                variadic_on_stack: false,
                win64_abi: false,
            },
            Target::WindowsX64 => TargetOptions {
                variadic_on_stack: false,
                win64_abi: true,
            },
            Target::WindowsAarch64 => TargetOptions {
                // Standard AAPCS64 (no macOS-style stack-packed
                // variadic); the win64_abi flag is x86_64-only and
                // doesn't apply on aarch64.
                variadic_on_stack: false,
                win64_abi: false,
            },
        }
    }
}
