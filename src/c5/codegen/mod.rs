//! Native code generation. Takes a compiled (and optionally optimized)
//! [`Program`] and writes a platform-native executable that runs
//! without involving the VM. The default for the badc CLI; see also
//! [`jit::jit_run`] for the in-process variant.
//!
//! ## Pipeline
//!
//! [`Program`] -> [`ssa_shadow::produce_ssa_funcs`] (per-function
//! SSA + CFG, sourced from the walker / cached `user_ssa_funcs`) ->
//! [`ssa_alloc::allocate`] (linear-scan register allocation) ->
//! per-arch SSA emit (`ssa_emit_aarch64` / `ssa_emit_x86_64`) ->
//! raw machine code -> per-OS image writer -> bytes on disk ->
//! (Apple Silicon only) shell to `codesign --sign -`.
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
use super::program::Program;

mod aarch64;
mod disasm;
mod dwarf;
mod elf;
#[cfg(feature = "std")]
mod elf_reloc;
mod jit;
mod mach_o;
mod pe;
mod ssa_alloc;
pub(crate) mod ssa_build;
#[cfg(feature = "std")]
mod ssa_dump;
mod ssa_emit_aarch64;
mod ssa_emit_common;
mod ssa_emit_x86_64;
mod ssa_native;
pub(crate) mod ssa_shadow;
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

    /// Windows targets follow LLP64: `long` is 32 bits, `long long`
    /// is 64 bits, pointer is 64 bits. Linux and macOS follow LP64
    /// (long is 64 bits). The data-model choice matters at every
    /// `long`-typed memory access -- size, alignment, load / store
    /// op, and the C99 usual-arithmetic-conversions rank.
    pub fn is_windows(self) -> bool {
        matches!(self, Target::WindowsX64 | Target::WindowsAarch64)
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
            Some(other) => Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!(
                    "unsupported native target: {other:?} \
                 (try `macos-aarch64`, `linux-aarch64`, `linux-x64`, \
                 `windows-x64`, or `windows-arm64`)"
                ),
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

/// Post-call extension recipe for a libc return value. The host
/// ABI puts sub-word integer returns in the low bits of the
/// platform's return register and leaves the upper bits undefined
/// (Win64 spec) or merely unspecified (SysV); c5's accumulator is
/// 64-bit so the codegen must extend before downstream ops read
/// it. Built from a [`ResolvedImport::return_type_tag`] via
/// [`return_extension`].
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum ReturnExt {
    /// Already 64-bit (pointer, `long long`, LP64 `long`,
    /// `void`/no return, FP) -- caller copies the host return
    /// register into the accumulator without touching it.
    None,
    /// Sign-extend the low 8 / 16 / 32 bits.
    Sign8,
    Sign16,
    Sign32,
    /// Zero-extend the low 8 / 16 / 32 bits.
    Zero8,
    Zero16,
    Zero32,
}

/// Upper bound on bc_pcs the lowering needs to look up. The
/// per-arch `lower` sizes `bytecode_to_native` by this value so
/// every `ent_pc` / `end_pc` / `block_start_pc` / sentinel write
/// the SSA emit produces lands in range. Takes the max of
/// `program.text.len()` and the largest `end_pc` across
/// `ssa_funcs`; the codegen still walks the bytecode tape for
/// the post-function CRT epilogue stub.
pub(super) fn pc_extent_for_lowering(
    program: &Program,
    ssa_funcs: &[crate::c5::ir::FunctionSsa],
) -> usize {
    let from_ssa = ssa_funcs.iter().map(|f| f.end_pc).max().unwrap_or(0);
    // Cross-TU function-import placeholders sit past `text.len()`;
    // the codegen's per-`Inst::Call` fixup pass uses the same
    // dense `bytecode_to_native` table to recognise them as
    // out-of-range, so the table has to cover the placeholder
    // range too. `extern_function_imports` is empty for every
    // build that didn't go through the relocatable -c path.
    let from_imports = program
        .extern_function_imports
        .iter()
        .map(|(pc, _)| *pc)
        .max()
        .unwrap_or(0);
    program.text.len().max(from_ssa).max(from_imports)
}

/// Where a single call argument lands on the host ABI. Produced
/// by [`plan_call_args`], consumed by the per-arch lowering at
/// `Op::JsrExt` and (in non-variadic shape) at `Op::Jsr` /
/// `Op::Jsri`. The placement is target-agnostic; the per-arch
/// emitter turns each variant into the right load / store
/// instruction pair.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(super) enum ArgPlacement {
    /// Goes into an integer arg register. Index is into
    /// `Abi::int_arg_regs`.
    IntReg(u8),
    /// Goes into a floating-point arg register. Index is the
    /// register number (d0..d7 on aarch64, xmm0..xmm7 on
    /// x86_64).
    FpReg(u8),
    /// Goes onto the host outgoing-args stack at `[sp + offset]`
    /// (post-`shadow_space`, post-scratch-allocation). 8-byte
    /// stride.
    Stack(u32),
}

/// Per-call argument plan + the host outgoing-args reservation
/// the call site has to pre-allocate before staging the args.
#[derive(Debug, Clone)]
pub(super) struct CallPlan {
    /// One entry per c5-stack arg, in source order. Length
    /// matches `arg_count`.
    pub placements: alloc::vec::Vec<ArgPlacement>,
    /// Total bytes the caller must subtract from SP before
    /// writing stack args, rounded up to a 16-byte multiple to
    /// keep SP 16-aligned at the call. Includes `shadow_space`
    /// (Win64 reserves 32 bytes for the callee to spill its
    /// register args; AAPCS64 / SysV reserve 0).
    pub scratch_bytes: u32,
}

/// Decide where each of `arg_count` call arguments lands per
/// `abi`'s ABI dialect, given the per-arg FP-ness bitmap and how
/// many of the args are fixed (the rest are variadic). The
/// returned [`CallPlan`] is consumed by the per-arch emitter.
///
/// Argument-placement rules across the four supported dialects:
///
/// * **Standard AAPCS64 / SysV** (Linux aarch64, Linux x86_64):
///   ints to `int_arg_regs`, FP scalars to the FP-reg bank,
///   overflow to the host stack. Variadic args are placed
///   identically to fixed ones.
/// * **macOS arm64** (`variadic_on_stack`): fixed args follow
///   AAPCS64; variadic args spill to the host stack at 8-byte
///   stride, no FP regs used.
/// * **Win64 / Windows aarch64** (`variadic_int_only`): fixed
///   args follow the standard placement; variadic args use the
///   integer reg bank only (FP variadic args ride int regs as
///   their raw bit pattern), then overflow to the stack.
pub(super) fn plan_call_args(
    arg_count: usize,
    fixed_args: usize,
    fp_arg_mask: u32,
    abi: Abi,
) -> CallPlan {
    let mut placements = alloc::vec::Vec::with_capacity(arg_count);
    let int_max = abi.int_arg_regs.len();
    let mut int_idx = 0usize;
    let mut fp_idx = 0usize;
    let mut stack_used: u32 = 0;
    for i in 0..arg_count {
        let is_fp = (fp_arg_mask & (1u32 << i)) != 0;
        let is_variadic = i >= fixed_args;
        let force_stack = is_variadic && abi.variadic_on_stack;
        let allow_fp_reg = !is_variadic || !abi.variadic_int_only;

        let placement = if force_stack {
            let off = stack_used;
            stack_used += 8;
            ArgPlacement::Stack(off)
        } else if abi.position_indexed_args {
            // Win64: arg position i picks reg i for both int and
            // FP. No separate counters; arg 0 burns slot 0 even
            // if a prior FP arg already used xmm0.
            if i < int_max {
                if is_fp && allow_fp_reg {
                    ArgPlacement::FpReg(i as u8)
                } else {
                    ArgPlacement::IntReg(abi.int_arg_regs[i])
                }
            } else {
                let off = stack_used;
                stack_used += 8;
                ArgPlacement::Stack(off)
            }
        } else if is_fp && allow_fp_reg && fp_idx < 8 {
            let r = fp_idx as u8;
            fp_idx += 1;
            ArgPlacement::FpReg(r)
        } else if int_idx < int_max {
            // Routes both real int args and variadic FP args
            // (under `variadic_int_only`) through the integer
            // bank. The c5 stack stores every value as its raw
            // 8-byte bit pattern, so the int-reg transfer
            // matches what va_arg(double) on Microsoft reads
            // back from the saved-int area.
            let r = abi.int_arg_regs[int_idx];
            int_idx += 1;
            ArgPlacement::IntReg(r)
        } else {
            let off = stack_used;
            stack_used += 8;
            ArgPlacement::Stack(off)
        };
        placements.push(placement);
    }

    // Shadow space rides ABOVE the outgoing-args region on Win64
    // (caller-reserved area the callee may spill register args
    // into). Add it to the reservation so the
    // `[sp + offset]` writes from `Stack(offset)` land past it.
    let raw = stack_used + abi.shadow_space;
    let scratch_bytes = (raw + 15) & !15;
    // Per `Stack(offset)` semantics, the caller writes each arg
    // at `[sp + shadow_space + offset]`. Rebase the offsets so
    // the emitter can use them directly without re-adding
    // shadow_space on each store.
    if abi.shadow_space > 0 {
        for p in placements.iter_mut() {
            if let ArgPlacement::Stack(off) = p {
                *off += abi.shadow_space;
            }
        }
    }
    CallPlan {
        placements,
        scratch_bytes,
    }
}

/// Decide how to extend a libc return value into the c5
/// accumulator. `target` is needed to decide the `long` width:
/// LP64 (Linux / macOS) -- 8 bytes, no extension; LLP64 (Windows)
/// -- 4 bytes, extend per the unsigned bit.
pub(crate) fn return_extension(return_type_tag: i64, target: Target) -> ReturnExt {
    use crate::c5::compiler::types as ty_helpers;
    use crate::c5::token::Ty;
    if return_type_tag == 0 {
        // No prototype on file -- assume the binding's caller
        // already produced a sane 64-bit value (legacy headers
        // that haven't grown a `int foo(...);` declaration). The
        // sites that need extension are the ones with a real
        // prototype.
        return ReturnExt::None;
    }
    let unsigned = ty_helpers::is_unsigned_ty(return_type_tag);
    let bare = ty_helpers::strip_unsigned(return_type_tag);
    if ty_helpers::is_pointer_ty(bare) {
        return ReturnExt::None;
    }
    if ty_helpers::is_float_ty(bare) || ty_helpers::is_double_ty(bare) {
        // FP returns ride XMM / V0; the int-return-register copy
        // is dead code for those signatures.
        return ReturnExt::None;
    }
    if ty_helpers::is_long_long_ty(bare) {
        return ReturnExt::None;
    }
    if ty_helpers::is_long_ty(bare) {
        // LP64: long is 8 bytes -- no extension. LLP64: long is
        // 4 bytes -- extend per signedness.
        if target.long_width_bytes() == 8 {
            return ReturnExt::None;
        }
        return if unsigned {
            ReturnExt::Zero32
        } else {
            ReturnExt::Sign32
        };
    }
    if bare == Ty::Int as i64 {
        return if unsigned {
            ReturnExt::Zero32
        } else {
            ReturnExt::Sign32
        };
    }
    if bare == Ty::Short as i64 {
        return if unsigned {
            ReturnExt::Zero16
        } else {
            ReturnExt::Sign16
        };
    }
    if bare == Ty::Char as i64 {
        // Lexer aliases `void` -> `Ty::Char`. Either way, signed
        // is the safer extension for an 8-bit return; unsigned is
        // a hint from a `unsigned char` prototype.
        return if unsigned {
            ReturnExt::Zero8
        } else {
            ReturnExt::Sign8
        };
    }
    ReturnExt::None
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
    /// Return type tag (`Symbol::type_` encoding -- bare `Ty::Char`
    /// / `Ty::Int` / `Ty::Long` / ... possibly OR'd with the
    /// unsigned bit). The codegen reads it after the call to decide
    /// whether the host's return register holds a sub-word value
    /// that needs sign- or zero-extension before becoming the c5
    /// accumulator. Without the extension, msvcrt's `int` returns
    /// (atoi, fclose, ...) leave the upper 32 bits of RAX
    /// undefined, and a downstream 64-bit comparison against a
    /// negative literal sees garbage. `0` (= `Ty::Char` = "no
    /// prototype seen") falls through with no extension; `void`
    /// also reduces to `Ty::Char` since the lexer aliases it.
    pub return_type_tag: i64,
    /// Prototype's return type was spelled `long double`. The
    /// SysV x86_64 ABI returns long double in x87 `st(0)`; c5's
    /// generic FP-return path reads XMM0 (where plain `double`
    /// returns land), so without this flag the binding's first
    /// caller reads -0.0 or whatever XMM0 had on entry. Plumbed
    /// from `Binding::returns_long_double` through
    /// `apply_fold_to_binding`.
    pub returns_long_double: bool,
    /// Per-fixed-parameter type tags from the prototype. Carried
    /// from `Binding::param_types`; the DWARF emitter
    /// uses these to give every PLT trampoline a
    /// `DW_TAG_subprogram` with `DW_TAG_formal_parameter`
    /// children typed accurately so gdb / lldb show the
    /// signature in `bt`. Empty when the parser hasn't seen the
    /// prototype.
    pub param_types: Vec<i64>,
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
        let mut found: Option<(
            i64,
            &super::preprocessor::DylibSpec,
            &super::preprocessor::Binding,
        )> = None;
        let mut binding_idx: i64 = 0;
        'outer: for spec in &program.dylibs {
            for b in &spec.bindings {
                if b.local_name == local_name {
                    found = Some((binding_idx, spec, b));
                    break 'outer;
                }
                binding_idx += 1;
            }
        }
        let Some((idx, spec, b)) = found else {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!(
                    "no `#pragma binding(<dylib>::{local_name}, ...)` is in scope -- the target's \
                 `_start` stub needs `{local_name}` and the codegen has nowhere to import it from. \
                 Did you forget to `#include <stdlib.h>`?"
                ),
            )));
        };
        let dylib_index = match self.dylibs.iter().position(|d| d.name == spec.name) {
            Some(i) => i,
            None => {
                self.dylibs.push(ResolvedDylib {
                    name: spec.name.clone(),
                    path: spec.path.clone(),
                });
                self.dylibs.len() - 1
            }
        };
        self.imports.push(ResolvedImport {
            binding_idx: idx,
            local_name: local_name.to_string(),
            real_symbol: b.real_symbol.clone(),
            dylib_index,
            is_variadic: b.is_variadic,
            fixed_args: b.fixed_args,
            return_type_tag: b.return_type_tag,
            returns_long_double: b.returns_long_double,
            param_types: b.param_types.clone(),
        });
        Ok(())
    }

    /// Collect every libc binding the program reaches for and
    /// look each one up in `program.dylibs`. The dylib list is
    /// built by deduplicating against `program.dylibs` ordering,
    /// so a program that calls `printf` (in `libc`) and
    /// `LoadLibraryA` (in `kernel32`) gets two dylibs in that
    /// declaration order.
    ///
    /// Sources: every walker AST `Expr::Call` with a `Sys` callee
    /// plus every `Inst::CallExt` / `Terminator::TailExt`
    /// reachable from `synthetic_ssa_funcs` and `user_ssa_funcs`.
    /// The two SSA vectors cover both fresh compiles (AST +
    /// synth) and archive reloads (round-tripped user SSA + synth).
    pub fn resolve(program: &Program) -> Result<Self, C5Error> {
        let mut seen: alloc::collections::BTreeSet<i64> = alloc::collections::BTreeSet::new();
        let mut used: Vec<i64> = Vec::new();
        for func in &program.finished_functions {
            for expr in &func.ast.exprs {
                let super::ast::Expr::Call { callee, .. } = expr else {
                    continue;
                };
                let callee_idx = *callee as usize;
                if callee_idx >= func.ast.exprs.len() {
                    continue;
                }
                let super::ast::Expr::Ident { class, val, .. } = &func.ast.exprs[callee_idx] else {
                    continue;
                };
                if *class != super::token::Token::Sys as i64 {
                    continue;
                }
                if seen.insert(*val) {
                    used.push(*val);
                }
            }
        }
        for func in program
            .synthetic_ssa_funcs
            .iter()
            .chain(program.user_ssa_funcs.iter())
        {
            for inst in &func.insts {
                if let crate::c5::ir::Inst::CallExt { binding_idx, .. } = inst
                    && seen.insert(*binding_idx)
                {
                    used.push(*binding_idx);
                }
            }
            for blk in &func.blocks {
                if let crate::c5::ir::Terminator::TailExt(idx) = blk.terminator
                    && seen.insert(idx)
                {
                    used.push(idx);
                }
            }
        }

        // Resolve each used binding-idx through `program.dylibs`.
        // Build the dylib list lazily: each new dylib gets
        // appended once and its index is reused for any further
        // bindings.
        let mut dylibs: Vec<ResolvedDylib> = Vec::new();
        let mut imports: Vec<ResolvedImport> = Vec::new();
        for binding_idx in used {
            let Some((spec, b)) = lookup_binding(program, binding_idx) else {
                return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                    &format!(
                        "Op::JsrExt operand {binding_idx} is out of range for the program's \
                     `#pragma binding(...)` table"
                    ),
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
                return_type_tag: b.return_type_tag,
                returns_long_double: b.returns_long_double,
                param_types: b.param_types.clone(),
            });
        }

        // A `#pragma dylib(name, "path")` that the source declared
        // but never bound any symbol from still has to flow through
        // as a LOAD_DYLIB / DT_NEEDED entry: a typical use is
        // forcing a framework's runtime-init code to fire (e.g.,
        // AppKit registering the NSApplication class with the
        // Objective-C runtime so `objc_getClass("NSApplication")`
        // resolves). The bytecode walk above only collects dylibs
        // that owned at least one `Op::JsrExt` binding; declared-
        // but-unused dylibs were silently dropped here, with the
        // visible symptom that the program's dynamic-init hook
        // never ran. Append them in source-declared order so the
        // load-command sequence matches the user's intent.
        for spec in &program.dylibs {
            if !dylibs.iter().any(|d| d.name == spec.name) {
                dylibs.push(ResolvedDylib {
                    name: spec.name.clone(),
                    path: spec.path.clone(),
                });
            }
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
    /// Bytecode entry-PCs of every function the lowering emitted,
    /// in lowering (= emission) order. The DWARF builder iterates
    /// this to produce one `Subprog` per function without walking
    /// the bytecode tape for `Op::Ent`.
    pub func_ent_pcs: Vec<usize>,
    /// Per-arch call sites to external symbols recorded during
    /// the SSA emit pass, before PLT trampoline application.
    /// Final-image writers don't read this; the
    /// `OutputKind::Relocatable` writer surfaces each entry as
    /// an ELF `.rela.text` reloc against the import's symbol.
    #[allow(dead_code)] // consumed only by the std-only elf_reloc writer
    pub reloc_call_sites: Vec<RelocCallSite>,
    /// Cross-TU user-function call sites. Each entry pairs the
    /// byte offset of the BL / CALL placeholder with the callee's
    /// symbol name. The codegen redirects every `Inst::Call`
    /// whose `target_pc` matches a [`Program::extern_function_imports`]
    /// placeholder into this list, leaves the imm26 / disp32
    /// at zero, and skips the matching intra-unit `Fixup::Bl`
    /// resolution. The `OutputKind::Relocatable` writer emits one
    /// undefined-extern symbol per unique name plus one
    /// `R_AARCH64_CALL26` / `R_X86_64_PLT32` reloc per call site
    /// in `.rela.text`. Final-image writers leave the field
    /// untouched because no `extern_function_imports` ever land
    /// in a single-TU compile path.
    #[allow(dead_code)] // consumed only by the std-only elf_reloc writer
    pub user_extern_call_sites: Vec<UserExternCallSite>,
    /// SSA-side `.debug_line` rows: each `(native_pc, line,
    /// file_idx)` entry says "the instruction whose first byte
    /// lives at `native_pc` in `Build::text` corresponds to source
    /// line `line` of file `file_idx`". Populated by the per-arch
    /// SSA emit each time the walker-recorded source position
    /// changes between consecutive `Inst`s. `file_idx` is an index
    /// into `Program::source_files`. Empty for builds whose SSA
    /// has no source info attached (lift-produced functions).
    pub ssa_line_rows: Vec<(usize, u32, u32)>,
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
    /// Address-of-global initializers (`int *p = &x;`). Each
    /// entry pairs a 8-byte slot in `data` with the data-
    /// segment offset of the variable being pointed at. Mirror
    /// of [`Program::data_relocs`]; `lower_for` clones it onto
    /// `Build` so the per-format writer doesn't have to plumb
    /// the program through alongside the build.
    pub data_relocs: Vec<crate::c5::program::DataReloc>,
    /// Function-pointer initializers in the data segment. Mirror
    /// of [`Program::code_relocs`]. Each entry pairs a data-segment
    /// slot with the bytecode PC of a function; the per-format
    /// writer translates the PC to the native code offset via
    /// `bytecode_to_native` and patches the slot to the runtime
    /// code address.
    pub code_relocs: Vec<crate::c5::program::CodeReloc>,
    /// `#pragma export(<name>)`-declared functions. Mirror of
    /// [`Program::exports`]. Empty for executable output;
    /// populated for shared-library output, when the
    /// per-format writer turns each entry into a real export
    /// record.
    pub exports: Vec<crate::c5::program::ExportedFunction>,
    /// Whether this build should produce an executable or a
    /// shared library (dylib / .so / DLL). Set from
    /// [`NativeOptions::output_kind`]. The writer dispatches
    /// on this to pick filetype, entry-point machinery, and
    /// export-table layout.
    pub output_kind: OutputKind,
    /// Bytecode PC of a user-defined `DllMain`. Mirror of
    /// [`Program::dllmain_pc`]; only the PE writer reads it,
    /// and only for [`OutputKind::SharedLibrary`] output.
    /// `None` (no user DllMain) -> writer emits the
    /// boilerplate `mov eax, 1; ret` stub. `Some(pc)` -> writer
    /// suppresses the stub and points
    /// `IMAGE_OPTIONAL_HEADER64::AddressOfEntryPoint` at the
    /// user's body via `bytecode_to_native[pc]`.
    pub dllmain_pc: Option<usize>,
    /// Mirror of [`NativeOptions::debug_info`]. The per-format
    /// writers gate DWARF section emission on this -- when
    /// `false`, no `.debug_*` sections appear in the output
    /// image. Defaults to `true` for `Build::default()`
    /// so existing tests that build a `Build` by hand keep
    /// debug info enabled.
    pub debug_info: bool,
    /// Byte offset within `Build::text` of each import's PLT
    /// trampoline. Indexed by `ResolvedImports::imports` slot --
    /// `plt_trampoline_offsets[i]` is the local code address the
    /// per-format writer should expose as `imports[i].local_name`
    /// in the static symbol table.
    ///
    /// Each trampoline is a tiny GOT/IAT-load + tail-jump (3
    /// instructions on aarch64 / 1 instruction on x86_64) that
    /// the per-arch lowering emits at the tail of the user code.
    /// Every `Op::JsrExt` / `Op::TailExt` call site now branches
    /// here via `bl` / `call rel32` instead of inlining the GOT
    /// load -- so a debugger's `b malloc` resolves against this
    /// in-image local symbol rather than getting lost in the
    /// dynamic linker's macro-expansion sites.
    pub plt_trampoline_offsets: Vec<usize>,
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

/// Relocatable-object call site: the byte offset of the BL / B
/// (aarch64) or CALL / JMP (x86_64) placeholder that reaches an
/// external symbol via its PLT trampoline. The final-image
/// writer rewrites these in place after the trampoline pool is
/// laid out; the `OutputKind::Relocatable` writer surfaces them
/// as `R_AARCH64_CALL26` / `R_X86_64_PLT32` entries in
/// `.rela.text` against the import's external symbol.
#[derive(Debug, Clone, Copy)]
#[allow(dead_code)] // consumed only by the std-only elf_reloc writer
pub(crate) struct RelocCallSite {
    /// Byte offset within `Build::text` of the call instruction.
    /// For aarch64 BL/B the imm26 occupies the low 26 bits of
    /// the 4-byte instruction; the ELF reloc applies at this
    /// offset directly. For x86_64 CALL/JMP rel32 the rel32
    /// operand starts at `instr_offset + 1`; the ELF reloc
    /// applies there.
    pub instr_offset: usize,
    /// Index into `Build::imports.imports` -- which external
    /// symbol the call reaches for.
    pub import_index: usize,
    /// `true` for tail-jumps (`b` / `jmp rel32`), `false` for
    /// calls (`bl` / `call rel32`). The relocation type is the
    /// same on each arch -- the link bit / opcode prefix lives
    /// in the placeholder bytes the codegen already emitted.
    #[allow(dead_code)]
    pub is_tail: bool,
}

/// Cross-TU user-function call site. Same shape as
/// [`RelocCallSite`] but the target is named directly --
/// `extern_function_imports` lives on `Program`, not on `Build`,
/// and a single `String` per call site is cheaper than threading
/// a second `Vec<String>` plus an index. Unique names get folded
/// into one undefined symbol each by the writer's strtab build.
#[derive(Debug, Clone)]
#[allow(dead_code)] // consumed only by the std-only elf_reloc writer
pub(crate) struct UserExternCallSite {
    /// Byte offset within `Build::text` of the call instruction.
    /// Same convention as [`RelocCallSite::instr_offset`].
    pub instr_offset: usize,
    /// Symbol name of the cross-TU callee. The writer interns
    /// this into the strtab and emits one undefined symbol per
    /// unique name.
    pub symbol_name: alloc::string::String,
    /// `true` for tail-jumps (`b` / `jmp rel32`), `false` for
    /// calls (`bl` / `call rel32`).
    pub is_tail: bool,
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
#[derive(Debug, Clone, Copy)]
pub struct NativeOptions {
    /// Retired knob. The bytecode-tape optimizer was deleted
    /// along with `lift_program`; the walker is the canonical
    /// SSA producer and reads AST snapshots directly. The flag
    /// is left on the public API for source compatibility but
    /// the codegen path ignores it. Future walker-side
    /// optimization passes may rebind it.
    pub optimize: bool,
    /// Pick the kind of binary the writer should produce.
    /// Default is [`OutputKind::Executable`] -- a normal
    /// runnable program. [`OutputKind::SharedLibrary`] swaps
    /// the writer to dylib / .so / DLL output, drops the
    /// entry-point machinery, and promotes
    /// `Program::exports` to externally visible symbols.
    pub output_kind: OutputKind,
    /// Emit DWARF (`.debug_info` + `.debug_abbrev` + `.debug_line`
    /// + `.debug_str` + `.debug_frame`) into the output binary.
    ///
    /// On by default, matching gcc / clang behaviour for an
    /// implicit `-g` build. Turning it off via `--no-debug` /
    /// `-g0` shrinks the artifact (~10-30% on a large
    /// translation unit), trims compile time (the type-catalog
    /// walk is non-trivial on big inputs), and -- because the
    /// only varying input across runs that differ in source
    /// path is the DWARF blob -- gives byte-identical
    /// production binaries useful for golden-hash bisection.
    pub debug_info: bool,
    /// Print each SSA function's IR + allocator output to stderr
    /// before lowering. Same as `--dump-asm` for native code: a
    /// diagnostic emitted alongside the build. Off by default.
    pub dump_ssa: bool,
}

/// Distinguishes "produce an executable" from "produce a
/// shared library" at the writer entry. Per format:
///
/// * **Mach-O**: `MH_EXECUTE` + `LC_MAIN` vs `MH_DYLIB` +
///   `LC_ID_DYLIB` + symbol-table N_EXT entries.
/// * **ELF**: `ET_EXEC` + `_start` stub vs `ET_DYN` +
///   `STB_GLOBAL` `STT_FUNC` exports in `.dynsym`.
/// * **PE**: regular console image vs `IMAGE_FILE_DLL`
///   characteristic + `IMAGE_DATA_DIRECTORY[0]` Export
///   Directory + DllMain stub.
#[derive(Debug, Clone, Copy, Default, PartialEq, Eq)]
pub enum OutputKind {
    #[default]
    Executable,
    /// Shared library: the writer emits a dylib (Mach-O), an
    /// `.so` (ELF), or a DLL (PE), exposing each
    /// [`Program::exports`] entry as an externally resolvable
    /// symbol. The program need not have a `main` function;
    /// every `#pragma export(<name>)` becomes a callable
    /// entry point.
    SharedLibrary,
    /// Relocatable native object (`.o` on ELF / Mach-O, `.obj` on
    /// PE). Each function emits with cross-TU references left
    /// as relocation entries against the unit's symbol table.
    /// Consumed by a system linker (`ld`, `lld`, `link.exe`) or
    /// by `link_units`' native path. Locks the target at compile
    /// time -- a relocatable produced for one target can't be
    /// linked into a binary for a different one.
    Relocatable,
}

impl Default for NativeOptions {
    /// Defaults: optimizer off, executable output, DWARF on.
    fn default() -> Self {
        Self::new()
    }
}

impl NativeOptions {
    /// Convenience builder. `NativeOptions::new().with_optimize()`.
    pub const fn new() -> Self {
        Self {
            optimize: false,
            output_kind: OutputKind::Executable,
            debug_info: true,
            dump_ssa: false,
        }
    }

    /// Print the SSA IR + allocation for every function. Same
    /// observability shape as `--dump-asm`.
    pub const fn with_dump_ssa(mut self) -> Self {
        self.dump_ssa = true;
        self
    }

    /// Set [`Self::optimize`] = true and return self.
    pub const fn with_optimize(mut self) -> Self {
        self.optimize = true;
        self
    }

    /// Set [`Self::output_kind`] = [`OutputKind::SharedLibrary`]
    /// and return self.
    pub const fn with_shared_library(mut self) -> Self {
        self.output_kind = OutputKind::SharedLibrary;
        self
    }

    /// Set [`Self::debug_info`] and return self. Pass `false`
    /// to skip DWARF emission -- the writer drops the
    /// debug sections entirely from the output image.
    pub const fn with_debug_info(mut self, on: bool) -> Self {
        self.debug_info = on;
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
/// [`NativeOptions`]. `options.optimize` is currently a no-op
/// (see [`NativeOptions::optimize`]).
pub fn emit_native_with_options(
    program: &Program,
    target: Target,
    options: NativeOptions,
) -> Result<Vec<u8>, C5Error> {
    let build = lower_for(program, target, options)?;
    write_for(program, &build, target)
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
    // Linux ELF executables tail-call libc `exit` from
    // `_start`; force-including the binding lets the writer
    // emit the call even if user code never names it.
    // Shared libraries skip this -- they have no `_start`,
    // and pulling in an unused libc reference would surface
    // a "no `#pragma binding(libc::exit, ...)`" error on
    // sources that legitimately don't include `<stdlib.h>`.
    let is_shared = options.output_kind == OutputKind::SharedLibrary;
    // Only force-include libc `exit` when the user
    // already declared a binding for it (typically via
    // `#include <stdlib.h>`). When no `exit` binding is in
    // scope, the ELF `_start` stub falls back to a direct
    // `sys_exit_group` syscall and the resulting binary has no
    // libc dependency at all -- so trivial fixtures like
    // `int main() { return argc; }` compile without any header
    // include.
    let exit_binding_in_scope = program
        .dylibs
        .iter()
        .flat_map(|d| d.bindings.iter())
        .any(|b| b.local_name == "exit");
    if !is_shared
        && matches!(target, Target::LinuxAarch64 | Target::LinuxX64)
        && exit_binding_in_scope
    {
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
    // Linux aarch64 long-double libc returns. AAPCS64 returns
    // binary128 in v0 (full Q register); c5 stores `long double`
    // in an 8-byte FP64 slot, so any libc call whose prototype is
    // `long double f(...)` needs a `__trunctfdf2` follow-up that
    // truncates v0 to d0 before the c5 accumulator reads it. Force
    // the binding in if any in-scope binding carries
    // `returns_long_double`; otherwise the codegen has no import
    // slot to record a fixup against. No-op when nothing in the
    // program calls a `long double`-returning libc function.
    if matches!(target, Target::LinuxAarch64)
        && imports.imports.iter().any(|i| i.returns_long_double)
    {
        imports.force_include_by_name("__trunctfdf2", program)?;
    }
    let mut build = match target {
        Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64 => {
            aarch64::lower(program, target, options, &imports)?
        }
        Target::LinuxX64 | Target::WindowsX64 => x86_64::lower(program, target, options, &imports)?,
    };
    build.imports = imports;
    build.abi = target.abi();
    build.data_relocs = program.data_relocs.clone();
    build.code_relocs = program.code_relocs.clone();
    build.exports = program.exports.clone();
    build.output_kind = options.output_kind;
    build.dllmain_pc = program.dllmain_pc;
    build.debug_info = options.debug_info;
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

fn write_for(program: &Program, build: &Build, target: Target) -> Result<Vec<u8>, C5Error> {
    #[cfg(feature = "std")]
    if build.output_kind == OutputKind::Relocatable {
        // ELF64 ET_REL is the badc-internal relocatable format on
        // every target -- single writer, single reloc table. The
        // final executable still comes out in the target's native
        // container (Mach-O / ELF / PE) at link time.
        let machine = match target {
            Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64 => {
                Machine::Aarch64
            }
            Target::LinuxX64 | Target::WindowsX64 => Machine::X86_64,
        };
        return elf_reloc::write_relocatable(program, build, machine);
    }
    // The no-std build can't reach the relocatable writer; the
    // `-c --emit=native` path lives in the CLI, which itself is
    // std-only. If a no-std caller ever surfaces `Relocatable` it
    // would fall through to the final-image writers below; the
    // unreachable branch keeps the match arms exhaustive without
    // pulling `elf_reloc` into the no-std build.
    #[cfg(not(feature = "std"))]
    if build.output_kind == OutputKind::Relocatable {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
            "Relocatable output requires the `std` feature",
        )));
    }
    match target {
        Target::MacOSAarch64 => mach_o::write(program, build),
        Target::LinuxAarch64 => elf::write(program, build, Machine::Aarch64),
        Target::LinuxX64 => elf::write(program, build, Machine::X86_64),
        Target::WindowsX64 => pe::write(program, build, Machine::X86_64, target),
        Target::WindowsAarch64 => pe::write(program, build, Machine::Aarch64, target),
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
/// the System V `xor eax, eax` (zero XMM count) pre-call
/// instruction is required.
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
    /// Windows variadic ABI passes variadic args through the
    /// integer arg registers + the host stack, never through the
    /// FP arg registers. Microsoft's `va_arg(double)` reads the
    /// raw 8-byte bit pattern from the integer side (`__gr_top`
    /// on Aarch64, the saved-int area on x64), so an AAPCS64-
    /// or SysV-style FP-reg placement causes msvcrt's printf to
    /// see denormal garbage. Mutually exclusive with
    /// `variadic_on_stack` (Apple's all-stack flavour).
    pub variadic_int_only: bool,
    /// Win64 places each arg in the register at its argument
    /// position (arg 0 -> int_arg_regs[0] / xmm0, arg 1 ->
    /// int_arg_regs[1] / xmm1, ...) -- the type of arg 1 doesn't
    /// shift arg 2's register. SysV / AAPCS64 instead advance
    /// independent int and FP counters, so an FP arg in the
    /// middle of an int sequence doesn't burn an int reg slot.
    pub position_indexed_args: bool,
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
                variadic_int_only: false,
                position_indexed_args: false,
                variadic_zero_xmm_count: false,
            },
            Target::LinuxAarch64 => Abi {
                arch: Arch::Aarch64,
                int_arg_regs: AARCH64_INT_ARGS,
                shadow_space: 0,
                variadic_on_stack: false,
                variadic_int_only: false,
                position_indexed_args: false,
                variadic_zero_xmm_count: false,
            },
            Target::LinuxX64 => Abi {
                arch: Arch::X86_64,
                int_arg_regs: SYSV_INT_ARGS,
                shadow_space: 0,
                variadic_on_stack: false,
                variadic_int_only: false,
                position_indexed_args: false,
                variadic_zero_xmm_count: true,
            },
            Target::WindowsX64 => Abi {
                arch: Arch::X86_64,
                int_arg_regs: WIN64_INT_ARGS,
                shadow_space: 32,
                variadic_on_stack: false,
                variadic_int_only: true,
                position_indexed_args: true,
                variadic_zero_xmm_count: false,
            },
            Target::WindowsAarch64 => Abi {
                arch: Arch::Aarch64,
                int_arg_regs: AARCH64_INT_ARGS,
                shadow_space: 0,
                variadic_on_stack: false,
                variadic_int_only: true,
                position_indexed_args: false,
                variadic_zero_xmm_count: false,
            },
        }
    }

    /// Width of `long` for this target, in bytes. LP64 (Linux,
    /// macOS) -- 8 bytes; LLP64 (Windows) -- 4 bytes. Mirrors
    /// what `Compiler::size_of_type` returns for `Ty::Long`;
    /// hoisted onto `Target` so the codegen-side helpers can ask
    /// without dragging in the parser's type table.
    pub(crate) fn long_width_bytes(self) -> usize {
        match self {
            Target::WindowsX64 | Target::WindowsAarch64 => 4,
            Target::MacOSAarch64 | Target::LinuxAarch64 | Target::LinuxX64 => 8,
        }
    }
}
