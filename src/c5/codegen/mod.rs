//! Native code generation. Takes a compiled (and optionally optimized)
//! [`Program`] and writes a platform-native executable that runs
//! without involving the VM. The default for the badc CLI; see also
//! [`jit::jit_run`] for the in-process variant.
//!
//! ## Pipeline
//!
//! [`Program`] -> [`ssa_shadow::produce_ssa_funcs`] (per-function
//! SSA + CFG, sourced from the walker / cached `user_ssa_funcs`) ->
//! [`ssa_alloc::allocate`] (graph-coloring register allocation) ->
//! per-arch SSA emit (`ssa_emit_aarch64` / `ssa_emit_x86_64`) ->
//! raw machine code -> per-OS image writer -> bytes on disk ->
//! (Apple Silicon only) shell to `codesign --sign -`.
//!
//! ## What we trade away
//!
//! Native binaries skip the VM's safety net. There's no
//! `--track-pointers` equivalent, no `mprotect` enforcement, no
//! code-vs-data separation check on every load and store. The
//! `--interp` mode runs the same program under the SSA-walking
//! VM if you want the watchful version.
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
// Re-bind the c5-level modules the arch submodules reach through `super::super`;
// moving the large emit/encode files one level deeper changed that path's base.
use crate::c5::{error, ir, op, program};

mod aarch64;
// Host-ABI aggregate classifier. Consumed by `plan_call_args` and
// the walker once struct arguments / returns route through the host
// ABI; the rules + unit tests land first as a standalone unit.
#[allow(dead_code)]
pub(crate) mod abi_classify;
#[cfg(feature = "native-emit")]
mod dwarf;
#[cfg(feature = "native-emit")]
mod dwarf_reloc;
#[cfg(feature = "native-emit")]
mod elf;
#[cfg(feature = "native-emit")]
mod elf_reloc;
mod jit;
#[cfg(feature = "native-emit")]
mod mach_o;
mod passes;
#[cfg(feature = "native-emit")]
mod pe;
#[cfg(feature = "std")]
mod so_versions;
pub(crate) mod ssa;
mod x86_64;

/// Re-exported for the multi-TU link path, which recovers Win64
/// unwind descriptors from merged `.text` bytes. Only the linker
/// (gated on `full`) consumes it.
#[cfg(feature = "full")]
pub(crate) use x86_64::decode_x86_64_prologue_unwind;

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

    /// Whether plain `char` is signed. C99 6.2.5p15 leaves the
    /// signedness of unqualified `char` implementation-defined; to
    /// interoperate with the host toolchain and match the platform
    /// ABI, c5 follows the host C compiler: signed on x86_64 (all
    /// OSes), on Apple AArch64, and on Windows AArch64 (MSVC);
    /// unsigned only on AArch64 ELF (the AAPCS64 default that the
    /// Linux GCC/Clang toolchain keeps). The choice drives the
    /// extension of an 8-bit `char` lvalue widened to a larger
    /// integer.
    pub fn plain_char_signed(self) -> bool {
        !matches!(self, Target::LinuxAarch64)
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

/// Upper bound on ent_pcs the lowering needs to look up. The
/// per-arch `lower` sizes `pc_to_native` by this value so
/// every `ent_pc` / `end_pc` / `block_start_pc` / sentinel write
/// the SSA emit produces lands in range.
pub(super) fn pc_extent_for_lowering(
    program: &Program,
    ssa_funcs: &[crate::c5::ir::FunctionSsa],
) -> usize {
    let from_ssa = ssa_funcs.iter().map(|f| f.end_pc).max().unwrap_or(0);
    // Cross-TU function-import placeholders sit past the
    // highest `end_pc`; the codegen's per-`Inst::Call` fixup
    // pass uses the same dense `pc_to_native` table to
    // recognise them as out-of-range, so the table has to
    // cover the placeholder range too. `extern_function_imports`
    // is empty for every build that didn't go through the
    // relocatable -c path.
    let from_imports = program
        .extern_function_imports
        .iter()
        .map(|(pc, _)| *pc)
        .max()
        .unwrap_or(0);
    from_ssa.max(from_imports)
}

/// Where a single call argument lands on the host ABI. Produced
/// by [`plan_call_args`], consumed by the per-arch lowering at
/// `Inst::CallExt` and (in non-variadic shape) at `Inst::Call`
/// / `Inst::CallIndirect`. The placement is target-agnostic; the
/// per-arch emitter turns each variant into the right load /
/// store instruction pair.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum ArgPlacement {
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
    /// An aggregate passed by value in up to four register slots
    /// (`regs[0..n]`), one per eightbyte / HFA member. Each
    /// [`ClassReg`] names the concrete register and whether it is an
    /// integer or FP register; the emitter loads the k-th slot from
    /// `[arg_addr + 8*k]`. C99 aggregates pass at most two GPRs
    /// (System V eightbytes) or four FP registers (AAPCS64 HFA), so
    /// four slots suffice and the placement stays `Copy`.
    StructRegs { regs: [ClassReg; 4], n: u8 },
    /// An aggregate passed by an implicit reference: the caller
    /// copies it to a temporary and passes the pointer in this
    /// integer register (index into `Abi::int_arg_regs`).
    StructByRefReg(u8),
    /// As `StructByRefReg`, but the implicit-reference pointer
    /// overflows to the outgoing-args stack at `[sp + offset]`.
    StructByRefStack(u32),
    /// An aggregate passed wholly on the outgoing-args stack: the
    /// caller copies `size` bytes to `[sp + off]` (System V MEMORY
    /// class, or a register-bank-exhausted small aggregate).
    StructStack { off: u32, size: u32 },
}

/// One register slot of an [`ArgPlacement::StructRegs`]: the
/// concrete register number plus whether it is an FP register, so
/// the emitter picks the integer vs FP load without re-deriving the
/// class.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) struct ClassReg {
    pub reg: u8,
    pub is_fp: bool,
}

/// Per-call argument plan + the host outgoing-args reservation
/// the call site has to pre-allocate before staging the args.
#[derive(Debug, Clone)]
pub(crate) struct CallPlan {
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
    plan_call_args_aggs(arg_count, fixed_args, fp_arg_mask, abi, &[], false)
}

/// One call argument's aggregate classification, for the
/// struct-aware planner. `class` comes from
/// [`abi_classify::classify_aggregate`]; `size` is the aggregate's
/// byte size (needed for the stack reservation when it is passed by
/// memory or by an implicit-reference copy).
#[derive(Clone)]
#[allow(dead_code)] // constructed by the per-arch emit's struct path
pub(crate) struct ArgAgg {
    pub class: abi_classify::AggClass,
    pub size: u32,
}

/// Struct-aware [`plan_call_args`]. `aggs[i]` is `Some` when
/// `args[i]` is an aggregate passed by value; the scalar arms are
/// identical to the no-aggregate planner. `ret_via_first_int`
/// reserves the first integer argument register for a hidden
/// return-value pointer (System V MEMORY / Win64 oversize return);
/// AAPCS64 uses x8 instead and passes `false`.
pub(super) fn plan_call_args_aggs(
    arg_count: usize,
    fixed_args: usize,
    fp_arg_mask: u32,
    abi: Abi,
    aggs: &[Option<ArgAgg>],
    ret_via_first_int: bool,
) -> CallPlan {
    use abi_classify::{AggClass, RegClass};
    let mut placements = alloc::vec::Vec::with_capacity(arg_count);
    let int_max = abi.int_arg_regs.len();
    let mut int_idx = if ret_via_first_int { 1 } else { 0 };
    let mut fp_idx = 0usize;
    let mut stack_used: u32 = 0;
    for i in 0..arg_count {
        // Aggregate argument: classify into registers / by-reference
        // / by-stack per the host ABI. A variadic aggregate on the
        // macOS AAPCS64 variadic ABI rides the overflow stack like
        // every other variadic argument (the callee's va_arg reads it
        // from there); on the register-save variadic ABIs it stays in
        // the argument registers and the callee spills them to its
        // save area.
        if let Some(Some(agg)) = aggs.get(i) {
            let aligned = (agg.size + 7) & !7;
            if i >= fixed_args && abi.variadic_on_stack {
                let off = stack_used;
                stack_used += aligned;
                placements.push(ArgPlacement::StructStack {
                    off,
                    size: agg.size,
                });
                continue;
            }
            // Win64 (Microsoft x64) places arguments positionally: each
            // argument, including an aggregate, occupies the single
            // register slot for its position rather than a separate
            // integer / SSE bank. The host-ABI path tags only
            // {1,2,4,8}-byte aggregates here, each one GPR; place it at
            // `int_arg_regs[i]` so it lines up with the scalar
            // positional placement above, then overflow to the stack.
            if abi.position_indexed_args {
                let placement = if i < int_max {
                    let mut regs = [ClassReg {
                        reg: 0,
                        is_fp: false,
                    }; 4];
                    regs[0] = ClassReg {
                        reg: abi.int_arg_regs[i],
                        is_fp: false,
                    };
                    ArgPlacement::StructRegs { regs, n: 1 }
                } else {
                    let off = stack_used;
                    stack_used += aligned;
                    ArgPlacement::StructStack {
                        off,
                        size: agg.size,
                    }
                };
                placements.push(placement);
                continue;
            }
            let placement = match &agg.class {
                AggClass::Regs(classes) => {
                    let need_int = classes.iter().filter(|c| **c == RegClass::Integer).count();
                    let need_fp = classes.iter().filter(|c| **c == RegClass::Sse).count();
                    if int_idx + need_int <= int_max && fp_idx + need_fp <= 8 {
                        let mut regs = [ClassReg {
                            reg: 0,
                            is_fp: false,
                        }; 4];
                        let mut n = 0u8;
                        for c in classes {
                            regs[n as usize] = match c {
                                RegClass::Integer => {
                                    let r = abi.int_arg_regs[int_idx];
                                    int_idx += 1;
                                    ClassReg {
                                        reg: r,
                                        is_fp: false,
                                    }
                                }
                                RegClass::Sse => {
                                    let r = fp_idx as u8;
                                    fp_idx += 1;
                                    ClassReg {
                                        reg: r,
                                        is_fp: true,
                                    }
                                }
                            };
                            n += 1;
                        }
                        ArgPlacement::StructRegs { regs, n }
                    } else {
                        // The aggregate spills to the stack. AAPCS64
                        // 6.8.2 then exhausts the matching register file
                        // for the rest of the call: a general (GP)
                        // composite sets NGRN = 8 (C.13), an HFA/HVA sets
                        // NSRN = 8 (C.5). System V AMD64 3.2.3 exhausts
                        // nothing -- only this argument goes to memory and
                        // later arguments keep filling free registers.
                        if matches!(abi.arch, Arch::Aarch64) {
                            if need_fp > 0 && need_int == 0 {
                                fp_idx = 8;
                            } else {
                                int_idx = int_max;
                            }
                        }
                        let off = stack_used;
                        stack_used += aligned;
                        ArgPlacement::StructStack {
                            off,
                            size: agg.size,
                        }
                    }
                }
                AggClass::ByRef => {
                    if int_idx < int_max {
                        let r = abi.int_arg_regs[int_idx];
                        int_idx += 1;
                        ArgPlacement::StructByRefReg(r)
                    } else {
                        let off = stack_used;
                        stack_used += 8;
                        ArgPlacement::StructByRefStack(off)
                    }
                }
                AggClass::ByStack => {
                    let off = stack_used;
                    stack_used += aligned;
                    ArgPlacement::StructStack {
                        off,
                        size: agg.size,
                    }
                }
                AggClass::ReturnIndirect => {
                    // Not an argument classification; treat as
                    // by-stack defensively.
                    let off = stack_used;
                    stack_used += aligned;
                    ArgPlacement::StructStack {
                        off,
                        size: agg.size,
                    }
                }
            };
            placements.push(placement);
            continue;
        }
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
        } else if is_fp && allow_fp_reg {
            // A fixed floating-point argument that exhausted the eight
            // FP argument registers overflows to the host stack, not the
            // integer bank (System V AMD64 3.2.3 / AAPCS64 6.4.1). The
            // integer-bank fall-through below is reserved for variadic
            // FP arguments under `variadic_int_only` (Win64), where
            // `allow_fp_reg` is already false.
            let off = stack_used;
            stack_used += 8;
            ArgPlacement::Stack(off)
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
            match p {
                ArgPlacement::Stack(off)
                | ArgPlacement::StructByRefStack(off)
                | ArgPlacement::StructStack { off, .. } => *off += abi.shadow_space,
                _ => {}
            }
        }
    }
    CallPlan {
        placements,
        scratch_bytes,
    }
}

/// Per-parameter incoming-register plan for a callee. Runs the same
/// [`plan_call_args`] the caller uses, so an interleaved int / FP
/// parameter list resolves each parameter's incoming register from
/// the independent int and FP argument-register banks (System V AMD64
/// 3.2.3 / AAPCS64 6.4.1) rather than by absolute parameter index.
/// `n_params` declared parameters are all treated as fixed (the
/// caller's fixed-argument count for a prototype-having callee).
/// `fp_mask` is [`crate::c5::ir::FunctionSsa::param_fp_mask`].
///
/// The returned placements are consumed by the per-arch callee
/// prologue (which spills each incoming register into the parameter's
/// 16-byte c5 cdecl home cell) and by `Inst::ParamRef` (which reads
/// the parameter from its incoming register or home cell).
pub(crate) fn plan_param_regs(n_params: usize, fp_mask: u32, abi: Abi) -> CallPlan {
    plan_call_args(n_params, n_params, fp_mask, abi)
}

/// Struct-aware [`plan_param_regs`]: resolves each parameter's
/// incoming placement, with `aggs[k]` describing an aggregate
/// parameter passed by value. Mirrors the caller's
/// [`plan_call_args_aggs`] so both ends agree on register
/// assignment.
#[allow(dead_code)] // called by the per-arch callee prologue's struct path
pub(crate) fn plan_param_regs_aggs(
    n_params: usize,
    fp_mask: u32,
    abi: Abi,
    aggs: &[Option<ArgAgg>],
) -> CallPlan {
    plan_call_args_aggs(n_params, n_params, fp_mask, abi, aggs, false)
}

/// The floating-point argument mask, with every FP bit cleared when the
/// resulting placement would interleave register and host-stack
/// arguments. The c5 cdecl parameter-cell layout requires the
/// register-passed arguments to form a contiguous prefix; a parameter
/// list that exhausts the integer bank before a trailing floating-point
/// parameter (the FP bank still has a free register while a preceding
/// integer parameter already overflowed to the stack) breaks that
/// invariant. Clearing the mask routes such a function's arguments
/// entirely through the integer bank, the pre-FP-register lowering,
/// which is always contiguous. Both the caller's per-call `fp_arg_mask`
/// and the callee's `param_fp_mask` pass the same declared
/// argument-class sequence through this, so the two ends agree on the
/// ABI without consulting each other.
pub(crate) fn effective_fp_arg_mask(count: usize, fp_mask: u32, abi: Abi) -> u32 {
    if fp_mask == 0 {
        return 0;
    }
    let plan = plan_call_args(count, count, fp_mask, abi);
    let mut seen_stack = false;
    for p in &plan.placements {
        match p {
            ArgPlacement::Stack(_) => seen_stack = true,
            _ if seen_stack => return 0,
            _ => {}
        }
    }
    fp_mask
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
    if bare == Ty::Bool as i64 {
        // `_Bool` holds 0 / 1 in the low byte; zero-extend.
        return ReturnExt::Zero8;
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
/// for via `Inst::CallExt`, plus everything the codegen and
/// writer need to wire it up. Built once per compilation by
/// [`ResolvedImports::resolve`] from the `#pragma binding(...)`
/// table the preprocessor parsed out of the included headers.
#[derive(Debug, Clone)]
pub(crate) struct ResolvedImport {
    /// Flat index into the program's `#pragma binding(...)` table
    /// -- the value the parser stored in the symbol's `val` field
    /// and emitted as `Inst::CallExt`'s `binding_idx`. The
    /// lowering uses [`ResolvedImports::index_of_binding`] to
    /// translate this back into a GOT / IAT slot index when
    /// patching call sites.
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
    /// `true` when this import resolves through the runtime's flat
    /// namespace rather than [`Self::dylib_index`]'s dylib: a host
    /// symbol a shared library references and the loader supplies at
    /// `dlopen`. The Mach-O writer emits a flat-lookup bind; the ELF
    /// writer an undefined `.dynsym` entry with no `DT_NEEDED`.
    pub flat_lookup: bool,
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

/// Pre-baked DWARF byte streams from the multi-TU link.
/// `synth_build` populates this from `MergedNative`; the
/// final-image writer drops it into the output's `.debug_*`
/// sections instead of regenerating via `dwarf::emit`.
/// Address slots inside still need rebasing -- the producer
/// emitted them as placeholders paired with reloc records.
#[allow(dead_code)]
#[derive(Debug, Clone, Default)]
pub(crate) struct MergedDwarf {
    pub debug_info: Vec<u8>,
    pub debug_abbrev: Vec<u8>,
    pub debug_line: Vec<u8>,
    pub debug_str: Vec<u8>,
    /// Text-targeting DWARF relocs the linker couldn't apply
    /// without the writer's committed `.text` runtime address.
    /// Each entry stores the placeholder offset inside its
    /// parent merged section, the merged-text offset of the
    /// target, and the write width (4 or 8). The writer adds
    /// `text_vaddr` to `merged_text_offset` and writes
    /// little-endian bytes over the placeholder.
    pub debug_info_text_relocs: Vec<DwarfTextReloc>,
    pub debug_line_text_relocs: Vec<DwarfTextReloc>,
}

/// One text-targeting DWARF reloc surfaced through
/// [`MergedDwarf`]. Mirrors [`crate::c5::linker::link::DebugTextReloc`]
/// so the writer doesn't need to reach across the linker module
/// boundary.
#[allow(dead_code)]
#[derive(Debug, Clone, Copy)]
pub(crate) struct DwarfTextReloc {
    pub byte_offset: u64,
    pub merged_text_offset: u64,
    pub width: u8,
}

/// Write the runtime address of a text-targeting DWARF
/// placeholder over its preserved location in a merged DWARF
/// section. The linker leaves `r.byte_offset` cleared; the
/// writer adds `text_vmaddr` to `r.merged_text_offset` and writes
/// the matching `r.width` bytes (4 or 8) little-endian.
pub(super) fn apply_merged_dwarf_text_reloc(
    section_bytes: &mut [u8],
    r: &DwarfTextReloc,
    text_vmaddr: u64,
) -> Result<(), C5Error> {
    let off = r.byte_offset as usize;
    let end = off.checked_add(r.width as usize).ok_or_else(|| {
        C5Error::Compile(crate::c5::error::fmt_internal_err(&format!(
            "DWARF text reloc offset 0x{off:x} + width {} overflows",
            r.width,
        )))
    })?;
    if end > section_bytes.len() {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
            &format!(
                "DWARF text reloc past section end (offset 0x{off:x}, width {}, section length {})",
                r.width,
                section_bytes.len(),
            ),
        )));
    }
    let resolved = text_vmaddr.wrapping_add(r.merged_text_offset);
    let bytes = &resolved.to_le_bytes()[..r.width as usize];
    section_bytes[off..end].copy_from_slice(bytes);
    Ok(())
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
/// the SSA walk + the `#pragma binding` table. Each
/// [`ResolvedImport`]'s position in `imports` is also its GOT / IAT
/// slot index, so the lowering pass and the wire-format writer share
/// a single enumeration without coordinating through a static table.
#[derive(Debug, Default, Clone)]
pub(crate) struct ResolvedImports {
    pub imports: Vec<ResolvedImport>,
    pub dylibs: Vec<ResolvedDylib>,
    /// Data symbols bound to a host data object via `#pragma
    /// binding(data <lib>::<local>, "<host>")`. Each entry is
    /// `(local_name, host_symbol)`: the image-side symbol the source
    /// references and the dynamic symbol it resolves to. The ELF
    /// writer turns each into a COPY relocation; unlike `imports`,
    /// these are not call sites and carry no GOT/PLT slot.
    pub data_bindings: Vec<(String, String)>,
}

impl ResolvedImports {
    /// Look up the slot index for a given binding-flat index.
    /// `None` if the program doesn't reach for that binding --
    /// callers should treat that as a codegen bug (lowering
    /// shouldn't emit a fixup for an `Inst::CallExt` whose
    /// `binding_idx` isn't in the resolved set).
    pub fn index_of_binding(&self, binding_idx: i64) -> Option<usize> {
        self.imports
            .iter()
            .position(|i| i.binding_idx == binding_idx)
    }

    /// Add a binding the writer needs even if the SSA walk didn't
    /// find a call site for it. Currently used by the ELF
    /// writers' `_start` stub, which always tail-calls libc `exit`
    /// regardless of whether the user's code did.
    ///
    /// Resolves by name through `program.dylibs` the same way the
    /// SSA walk would, so a source that forgot `<stdlib.h>` still
    /// gets the friendly "no `#pragma binding(... ::exit, ...)`"
    /// diagnostic instead of a writer-side panic.
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
            flat_lookup: false,
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
            // Any `Sys`-class Ident denotes a reference to an
            // imported function, whether it is the callee of a
            // `Call` (`strcmp(a, b)`) or has its address taken
            // (`fp = strcmp`, `&strcmp`, a dispatch-table entry).
            // The address-of forms lower to `Inst::ImmExtCode` /
            // a `.data` trampoline and still need a resolved import.
            // `val` carries the binding's flat index for every form.
            for expr in &func.ast.exprs {
                let super::ast::Expr::Ident { class, val, .. } = expr else {
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
                // An import whose address is taken (`&strcmp`,
                // `Inst::ImmExtCode`) but never directly called still
                // needs a resolved import + PLT stub.
                if let crate::c5::ir::Inst::ImmExtCode(binding_idx) = inst
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
                        "Inst::CallExt binding_idx {binding_idx} is out of range for the \
                     program's `#pragma binding(...)` table"
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
                flat_lookup: false,
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
        // resolves). The SSA walk above only collects dylibs that
        // owned at least one `Inst::CallExt` binding; declared-
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

        // Data symbols bound via `#pragma binding(data ...)`. A data
        // import is referenced as an object, never called, so it never
        // appears as an `Inst::CallExt`; it is collected here instead.
        // Every such binding in scope is carried through; synth_build
        // emits a COPY relocation only when the final image defines the
        // local symbol (the runtime supplies `environ` for every hosted
        // image, so the binding binds it to the host's data object).
        let mut data_bindings: Vec<(String, String)> = Vec::new();
        for spec in &program.dylibs {
            for b in &spec.bindings {
                if b.is_data {
                    let entry = (b.local_name.clone(), b.real_symbol.clone());
                    if !data_bindings.contains(&entry) {
                        data_bindings.push(entry);
                    }
                }
            }
        }

        Ok(ResolvedImports {
            imports,
            dylibs,
            data_bindings,
        })
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

/// One resolved data-import copy relocation. `host_symbol` is the
/// dynamic data symbol to bind (e.g. `__environ`); the local data
/// object the image already defines sits at `local_offset` within its
/// `.data` (or `.bss` when `is_bss`) section, `size` bytes wide. The
/// ELF writer exports `host_symbol` at that runtime address and emits
/// an `R_*_COPY` so the loader binds the host's object into the image.
#[derive(Debug, Clone)]
pub(crate) struct CopyRelocReq {
    pub host_symbol: String,
    pub local_offset: u64,
    pub is_bss: bool,
    pub size: u64,
}

/// Where each piece of the program-being-built ends up in the final
/// image. The codegen and image-writer halves both populate this --
/// the codegen knows the code bytes, the pinned data bytes, and which
/// libc symbols the code wants to call; the writer arranges them into
/// segments and patches the codegen's GOT / data / function-pointer
/// placeholders with the actual vmaddrs.
/// A defined global symbol exported from an executable image so a
/// dynamically loaded module can bind against it. `offset` is the
/// byte offset within the symbol's section; the writer adds the
/// section's runtime base to form the symbol value.
#[derive(Debug, Clone)]
pub(crate) struct DynamicExport {
    pub name: String,
    pub section: DynamicExportSection,
    pub offset: u64,
}

/// The image section a [`DynamicExport`] lives in. Selects the
/// Mach-O section index and runtime base the writer applies.
/// Uninitialized (`.bss`) globals are not exported: badc lays its
/// program globals into the file-backed data section, so a `.bss`
/// section symbol (a coalesced tentative definition) has no mapped
/// data-segment address to publish.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum DynamicExportSection {
    Text,
    Data,
}

#[derive(Debug, Default)]
pub(crate) struct Build {
    /// Machine code, ready to be placed in `__TEXT,__text`.
    pub text: Vec<u8>,
    /// Data-import copy relocations resolved against the merged symbol
    /// table (multi-TU link path). Each names a host data symbol to
    /// export at a local data/bss slot the image defines, bound with an
    /// `R_*_COPY` relocation. Empty on the single-TU and non-ELF paths.
    pub copy_relocs: Vec<CopyRelocReq>,
    /// Initialised data segment: string literals + zero-initialised
    /// globals. Copied into `__DATA,__data` by the writer; offsets
    /// into this buffer match the SSA emit's view of the data
    /// segment, so a `DataFixup { data_offset: K }` resolves to
    /// byte K of this `Vec`.
    pub data: Vec<u8>,
    /// Bytes of zero-initialised data placed past the file image, in the
    /// `[data.len(), data.len() + bss_size)` offset range. Carries no file
    /// storage: the loader zero-fills it (ELF `p_memsz > p_filesz`, PE
    /// `VirtualSize > SizeOfRawData`, Mach-O `vmsize > filesize`). A data
    /// offset at or past `data.len()` names a byte in this region.
    pub bss_size: i64,
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
    /// Sparse map from SSA-tier PC (ent_pc / end_pc /
    /// block_start_pc / sentinel) to the byte offset within
    /// `Build::text` where that PC's emitted instructions start.
    /// `usize::MAX` for indices that aren't a recognised PC. The
    /// last entry is the total code length, so `[i+1] - [i]` gives
    /// the byte length covered between PCs `i` and `i+1`.
    pub pc_to_native: Vec<usize>,
    /// `ent_pc` of every function the lowering emitted, in
    /// lowering (= emission) order. The DWARF builder iterates
    /// this to produce one `Subprog` per function.
    pub func_ent_pcs: Vec<usize>,
    /// Source-level function names parallel to `func_ent_pcs`,
    /// populated from `FunctionSsa::name` during the per-arch
    /// emit loop. Empty entries surface for archive-reloaded
    /// units (the name doesn't round-trip yet) and for test-only
    /// fixtures. The symbol-table and DWARF emitters consult
    /// this column first, then fall back to a `fn_<ent_pc>`
    /// placeholder.
    pub func_names: Vec<String>,
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
    /// Cross-TU data references. Populated by the SSA emitters
    /// for every `Inst::ImmData(0)` whose value-id appears in
    /// `FunctionSsa::extern_imm_data_refs`. The
    /// `OutputKind::Relocatable` writer turns each entry into
    /// a named undefined-data symbol + a `.rela.text` pair
    /// (`R_AARCH64_ADR_PREL_PG_HI21 + ADD_ABS_LO12_NC` on
    /// aarch64, `R_X86_64_PC32` on x86_64). Final-image writers
    /// resolve them through the linker's merged symbol table.
    #[allow(dead_code)] // consumed only by the std-only elf_reloc writer
    pub user_extern_data_refs: Vec<UserExternDataRef>,
    /// SSA-side `.debug_line` rows: each `(native_pc, line,
    /// file_idx)` entry says "the instruction whose first byte
    /// lives at `native_pc` in `Build::text` corresponds to source
    /// line `line` of file `file_idx`". Populated by the per-arch
    /// SSA emit each time the walker-recorded source position
    /// changes between consecutive `Inst`s. `file_idx` is an index
    /// into `Program::source_files`. Empty for builds whose SSA
    /// has no source info attached.
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
    /// per-target codegen lowering for `Inst::TlsAddr` reads
    /// `tls_data.len()` to compute variant-2 (x86_64) negative
    /// offsets at emit time.
    pub tls_data: Vec<u8>,
    /// Number of `tls_data` bytes that are statically initialised.
    /// `tls_data.len() - tls_init_size` bytes are zero-fill.
    pub tls_init_size: usize,
    /// Win64 TLS-index fixups -- one entry per `Inst::TlsAddr`
    /// lowering site on a Win64 target. The writer reserves a
    /// 4-byte `_tls_index` slot in `.data`, builds the
    /// `IMAGE_TLS_DIRECTORY`, and patches each fixup with the
    /// displacement to the slot. Empty for non-Win64 targets and
    /// for Win64 programs with no `_Thread_local` globals.
    pub tls_index_fixups: Vec<TlsIndexFixup>,
    /// macOS arm64 Thread-Local Variable fixups -- one entry per
    /// `Inst::TlsAddr` site on macOS. Each records an
    /// `adrp + add` pair to be patched with the address of the
    /// per-variable `__thread_vars` descriptor.
    pub macho_tlv_fixups: Vec<MachoTlvFixup>,
    /// macOS arm64 TLV descriptors. One entry per distinct TLS
    /// variable referenced by the program; each descriptor's
    /// `offset_in_block` is the byte offset within
    /// `Build::tls_data` (matching `Inst::TlsAddr`'s operand).
    /// The writer emits a 24-byte descriptor per entry into the
    /// `__DATA,__thread_vars` section: `[ __tlv_bootstrap | 0 |
    /// offset_in_block ]`. Empty unless the target is macOS arm64
    /// and the program declares `_Thread_local` globals.
    pub macho_tlv_descriptors: Vec<MachoTlvDescriptor>,
    /// Linux/x86_64 TLS access fixups -- one entry per `Inst::TlsAddr`
    /// site. The codegen emits `mov rd, fs:[0]; sub rd, imm32` with
    /// `imm32` left 0; the linker patches it with the variable's
    /// negative offset from the thread pointer once the units' TLS
    /// blocks are merged. Carries the access target (a cross-unit
    /// extern symbol, or this unit's own TLS at a byte offset) because
    /// the per-variable offset is only known after the merge. Empty for
    /// non-Linux/x86_64 targets and for programs with no TLS access.
    pub elf_tpoff_fixups: Vec<ElfTpoffFixup>,
    /// Address-of-global initializers (`int *p = &x;`). Each
    /// entry pairs a 8-byte slot in `data` with the data-
    /// segment offset of the variable being pointed at. Mirror
    /// of [`Program::data_relocs`]; `lower_for` clones it onto
    /// `Build` so the per-format writer doesn't have to plumb
    /// the program through alongside the build.
    pub data_relocs: Vec<crate::c5::program::DataReloc>,
    /// Pointer-to-extern-data initializers; mirror of
    /// [`Program::extern_data_relocs`]. The per-format writer emits a
    /// named relocation against the data symbol, resolved at link time.
    pub extern_data_relocs: Vec<crate::c5::program::ExternDataReloc>,
    /// Function-pointer initializers in the data segment. Mirror
    /// of [`Program::code_relocs`]. Each entry pairs a data-segment
    /// slot with the ent_pc of a function; the per-format
    /// writer translates the PC to the native code offset via
    /// `pc_to_native` and patches the slot to the runtime
    /// code address.
    pub code_relocs: Vec<crate::c5::program::CodeReloc>,
    /// `#pragma export(<name>)`-declared functions. Mirror of
    /// [`Program::exports`]. Empty for executable output;
    /// populated for shared-library output, when the
    /// per-format writer turns each entry into a real export
    /// record.
    pub exports: Vec<crate::c5::program::ExportedFunction>,
    /// Defined global symbols carried as dynamic exports of an
    /// executable image. macOS links an executable so its
    /// default-visibility globals are exported, which lets a
    /// dynamically loaded module (`dlopen`) bind against the
    /// executable's symbols (a Python C extension `.so` resolving
    /// `PyBool_Type` and the C-API). Populated only for executable
    /// Mach-O output; empty for shared libraries (which use
    /// `exports`) and on other targets, whose writers ignore it.
    pub dynamic_exports: Vec<DynamicExport>,
    /// Whether this build should produce an executable or a
    /// shared library (dylib / .so / DLL). Set from
    /// [`NativeOptions::output_kind`]. The writer dispatches
    /// on this to pick filetype, entry-point machinery, and
    /// export-table layout.
    pub output_kind: OutputKind,
    /// The shared library's own name, recorded in the image so a
    /// consumer that links against it by name references the file it
    /// loads at runtime (PE export-directory Name, Mach-O
    /// `LC_ID_DYLIB` install name). `None` falls back to the
    /// per-format default. Set to the `-o` basename for `--shared`.
    pub shared_lib_name: Option<alloc::string::String>,
    /// Bytecode PC of a user-defined `DllMain`. Mirror of
    /// [`Program::dllmain_pc`]; only the PE writer reads it,
    /// and only for [`OutputKind::SharedLibrary`] output.
    /// `None` (no user DllMain) -> writer emits the
    /// boilerplate `mov eax, 1; ret` stub. `Some(pc)` -> writer
    /// suppresses the stub and points
    /// `IMAGE_OPTIONAL_HEADER64::AddressOfEntryPoint` at the
    /// user's body via `pc_to_native[pc]`.
    pub dllmain_pc: Option<usize>,
    /// Mirror of [`NativeOptions::debug_info`]. The per-format
    /// writers gate DWARF section emission on this -- when
    /// `false`, no `.debug_*` sections appear in the output
    /// image. Defaults to `true` for `Build::default()`
    /// so existing tests that build a `Build` by hand keep
    /// debug info enabled.
    pub debug_info: bool,
    /// Pre-baked merged DWARF byte streams. Set by the
    /// multi-TU link synthesizer (`synth_build.rs`) so the
    /// final-image writer consumes the linker-merged bytes
    /// instead of regenerating via `dwarf::emit`. `None`
    /// (the in-memory compile path) falls back to the on-the-fly
    /// emitter. Each tuple element is the matching standard
    /// section payload; relocs against runtime addresses
    /// (`DwarfReloc` entries from the producer) are still
    /// pending and need to be applied by the writer once it
    /// knows the final vmaddr layout.
    #[allow(dead_code)]
    pub merged_dwarf: Option<MergedDwarf>,
    /// Byte offset within `Build::text` of each import's PLT
    /// trampoline. Indexed by `ResolvedImports::imports` slot --
    /// `plt_trampoline_offsets[i]` is the local code address the
    /// per-format writer should expose as `imports[i].local_name`
    /// in the static symbol table.
    ///
    /// Each trampoline is a tiny GOT/IAT-load + tail-jump (3
    /// instructions on aarch64 / 1 instruction on x86_64) that
    /// the per-arch lowering emits at the tail of the user code.
    /// Every `Inst::CallExt` / `Terminator::TailExt` lowering
    /// branches here via `bl` / `call rel32` instead of inlining
    /// the GOT load -- so a debugger's `b malloc` resolves
    /// against this in-image local symbol rather than getting
    /// lost in the dynamic linker's macro-expansion sites.
    pub plt_trampoline_offsets: Vec<usize>,
    /// Post-prologue native byte offset of each function, keyed by
    /// `ent_pc`. The SSA emit records `code.len()` right after the
    /// prologue; the DWARF CFI pass turns the value into the FDE's
    /// `DW_CFA_advance_loc` so the post-prologue CFA / saved-reg
    /// rule installs at the right PC. Keyed by the function's own
    /// `ent_pc` (unique per function) rather than a derived PC slot
    /// in `pc_to_native`, which a neighbouring function's PC can
    /// alias when both are small.
    pub func_prologue_native: alloc::collections::BTreeMap<usize, usize>,
    /// Frame slots mem2reg promoted to registers, keyed by the
    /// function's `ent_pc`. The debug-info emitter drops the frame
    /// location for a local on one of these slots, since the slot no
    /// longer holds the value (a stale `DW_OP_fbreg` would make the
    /// debugger read uninitialised frame memory).
    pub promoted_local_slots: alloc::collections::BTreeMap<usize, alloc::vec::Vec<i64>>,
    /// Per-function map from a declared local's original frame slot to the
    /// new slot it was coalesced onto, keyed by `ent_pc`. The slot-coalescing
    /// pass compacts the frame regardless of debug info; the debug-info
    /// emitter consults this so a surviving local's `DW_OP_fbreg` location
    /// uses its post-coalesce offset. Slots coalesced onto shared storage are
    /// recorded in `promoted_local_slots` (empty location) instead.
    pub coalesced_slot_remap:
        alloc::collections::BTreeMap<usize, alloc::collections::BTreeMap<i64, i64>>,
    /// Per-function x86_64 Win64 unwind descriptors, in emission
    /// order. The PE writer turns each into a `RUNTIME_FUNCTION` +
    /// `UNWIND_INFO` pair so `RtlVirtualUnwind` can recover the
    /// caller's RIP/RSP/RBP at any body fault. Populated by the
    /// x86_64 lowering (from the prologue layout it just emitted)
    /// and by the multi-TU linker (from the merged prologue bytes).
    /// Empty for non-x86_64 builds and for hand-built test `Build`s;
    /// the PE writer then falls back to the coarse whole-`.text`
    /// entry.
    pub fn_unwind: Vec<FnUnwind>,
}

/// x86_64 Win64 prologue unwind descriptor for one function.
///
/// `begin` / `end` are absolute byte offsets in [`Build::text`];
/// every `*_end` prologue boundary is relative to `begin` (the
/// `CodeOffset` domain a Win64 `UNWIND_CODE` uses). The PE writer
/// adds the entry-stub prologue length to `begin` / `end` to derive
/// RVAs and synthesizes the `UNWIND_CODE` array (Win64 ABI, x64
/// exception handling) from the recorded boundaries.
///
/// The c5 prologue order is (optional arg-spill group) `pop r10;
/// sub rsp,M; <spills>; push r10`, then the standard frame `push
/// rbp; mov rbp,rsp; [sub rsp,N]`. Each `*_end` field is the byte
/// offset just past the matching instruction, which the unwind
/// codes use as their `CodeOffset` (the offset of the next
/// instruction). The net stack effect of the arg-spill group is a
/// single `-M` decrement (the intermediate `pop`/`push` of the
/// return address cancel), so it encodes as one `UWOP_ALLOC` of
/// `M` whose `CodeOffset` is the end of the `push r10`.
#[derive(Debug, Clone, Default)]
pub(crate) struct FnUnwind {
    /// Byte offset of the function's first instruction in `text`.
    pub begin: u32,
    /// Byte offset one past the function's last instruction in
    /// `text` (its `[begin, end)` extent).
    pub end: u32,
    /// `true` for a leaf-elided function with no standard frame
    /// (no `push rbp` / `mov rbp,rsp`): the `UNWIND_INFO` carries
    /// no codes and no frame register, and the unwinder treats it
    /// as a frameless body returning off the top-of-stack RA.
    pub leaf: bool,
    /// Total bytes the arg-spill group allocates (`param_spill_bytes`).
    /// 0 when the function takes no register/stack parameters into
    /// c5 cdecl cells.
    pub param_spill_bytes: u32,
    /// Offset (from `begin`) past the arg-spill group's `push r10`.
    /// Set only when `param_spill_bytes > 0`.
    pub arg_spill_end: u32,
    /// Offset (from `begin`) past `push rbp`.
    pub push_rbp_end: u32,
    /// Offset (from `begin`) past `mov rbp,rsp`.
    pub set_fpreg_end: u32,
    /// Bytes the standard frame allocation reserves (`frame_bytes`).
    /// 0 when the function reserves no locals / spill / callee-save
    /// area.
    pub frame_bytes: u32,
    /// Offset (from `begin`) past `sub rsp,frame_bytes`. Set only
    /// when `frame_bytes > 0`.
    pub frame_alloc_end: u32,
}

/// One macOS arm64 Thread-Local Variable. A 24-byte `__thread_vars`
/// descriptor is emitted per entry; the codegen's
/// [`MachoTlvFixup`]s reference these by index.
#[derive(Debug, Clone)]
pub(crate) struct MachoTlvDescriptor {
    /// Byte offset within this unit's TLS block where the variable
    /// starts. Mirrors `Inst::TlsAddr`'s operand. The linker rebases
    /// it by the unit's base in the merged TLS block; for a `symbol`
    /// descriptor it is overwritten with the resolved offset.
    pub offset_in_block: u64,
    /// Set for a cross-unit `extern _Thread_local` access: the
    /// referenced variable's name. The linker resolves it to the
    /// variable's offset in the merged TLS block. `None` for a
    /// unit-local definition (the `offset_in_block` path).
    pub symbol: Option<alloc::string::String>,
}

/// Refer-by-index relocation between a code site and a `__got` slot.
/// The codegen emits zero bytes where the adrp + ldr would go, then
/// records this so the Mach-O writer can fill them in once it knows
/// the data segment's final vmaddr.
/// Per-call-site placeholder the trampoline post-pass patches once the import
/// trampolines are laid out at the tail of `code`: a `CALL`/`JMP rel32`
/// (x86_64) or `BL`/`B` / `adrp+add` (aarch64) whose displacement resolves to
/// the import's shared stub. Shared by both backends.
#[derive(Debug, Clone, Copy)]
pub(crate) struct PltCallFixup {
    /// Byte offset within `code` of the patched instruction.
    pub(crate) instr_offset: usize,
    /// Import slot the call reaches via its trampoline.
    pub(crate) import_index: usize,
    /// Tail jump (`JMP`/`B`) when true, else a call (`CALL`/`BL`).
    pub(crate) is_tail: bool,
    /// Address-materialisation site (`LEA rip` / `adrp+add`) taking the
    /// import's address rather than transferring control; `is_tail` unused.
    pub(crate) is_addr: bool,
}

#[derive(Debug, Clone, Copy)]
pub(crate) struct GotFixup {
    /// Byte offset within `Build::text` of the adrp instruction.
    /// `adrp_offset + 4` is the matching ldr.
    pub adrp_offset: usize,
    /// Index into [`aarch64::IMPORTS`].
    pub import_index: usize,
    /// True when the site is a data-import reference that must read
    /// the IAT slot's value rather than branch to a call thunk. On
    /// x86_64 the reference is a `lea reg, [rip+disp32]` the writer
    /// rewrites to `mov reg, [rip+disp32]` against the slot RVA; a
    /// data import emits no `jmp [IAT]` trampoline. On aarch64 the
    /// adrp + ldr form already loads the slot, so the flag is unused.
    pub is_data_load: bool,
}

/// Relocation for `Inst::ImmData`: the codegen emits an
/// `adrp + add` placeholder pair to materialize the address into
/// the VM accumulator, and the writer patches both halves once
/// it knows where `__data` lands in vmaddr space.
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
// lowers `Inst::TlsAddr`. The codegen materialises the final
// immediate inline; the writer just needs `Build::tls_data` /
// `Build::tls_init_size` to lay out `.tdata` / `.tbss`.
//
// Win64 is different: TLS access goes through `_tls_index`, a
// DWORD whose runtime value the loader writes when it processes
// the TLS directory. The codegen reads that value at every TLS
// access (so the same compiled image works regardless of which
// slot the loader picked). The address of `_tls_index` isn't
// known until the writer lays out the data segments, so each
// `Inst::TlsAddr` lowering site records a [`TlsIndexFixup`] for
// the writer to patch.

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

/// TLS access relocation whose immediate the linker resolves against
/// the merged TLS block once every unit's `.tdata` / `.tbss` is
/// concatenated. Three access shapes record it, distinguished by the
/// linker (see `link_native_objects` Pass 4.1):
///   * Linux/x86_64 -- `mov rd, fs:[0]; sub rd, imm32`: variant-2
///     places the block below the thread pointer, so `imm32 =
///     merged_size - merged_offset` and the access computes `TP -
///     imm32`.
///   * Linux/aarch64 -- `mrs rd, tpidr_el0; add rd, rd, #imm12`:
///     variant-1 places the block above the thread pointer after a
///     16-byte TCB reserve, so `imm12 = 16 + merged_offset`.
///   * Windows/aarch64 -- the TEB sequence (`ldr x16, [x18, #0x58]`,
///     index by `_tls_index`, `add rd, x16, #imm12`): x16 already
///     holds the module's TLS block base, so `imm12 = merged_offset`
///     with no thread-pointer bias. This shape also records a
///     `TlsIndexFixup`, which is how the linker tells it apart from
///     the variant-1 ELF shape on the same machine.
/// The codegen leaves the immediate at a single-unit default (or 0 for
/// an extern access); `target` selects how the linker finds
/// `merged_offset`.
#[derive(Debug, Clone)]
pub(crate) struct ElfTpoffFixup {
    /// Byte offset within `Build::text` of the immediate field the
    /// linker rewrites (the `sub` imm32 / the `add` imm12 word).
    pub imm_offset: usize,
    pub target: ElfTpoffTarget,
}

/// How the linker resolves an [`ElfTpoffFixup`] to a byte offset in
/// the merged TLS block.
#[derive(Debug, Clone)]
pub(crate) enum ElfTpoffTarget {
    /// Cross-unit `extern _Thread_local`: the merged offset is the
    /// named symbol's entry in the merged TLS symbol table.
    Extern(String),
    /// Same-unit `_Thread_local`: the merged offset is this unit's
    /// base in the merged TLS block plus this byte offset within the
    /// unit's own block.
    Local(u64),
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
    /// `true` for an address-of site (`lea` rip-relative on
    /// x86_64, `adrp + add` on aarch64) materializing the import's
    /// stub address (`Inst::ImmExtCode`). The relocatable writer
    /// emits a PC-relative data reloc (`R_X86_64_PC32` /
    /// `R_AARCH64_ADR_PREL_PG_HI21` + `R_AARCH64_ADD_ABS_LO12_NC`)
    /// against the import symbol rather than the call relocation.
    #[allow(dead_code)]
    pub is_addr: bool,
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

/// Cross-TU data reference. Same `adrp + add` (aarch64) or
/// `lea` rip-rel (x86_64) shape as [`DataFixup`], but the
/// target is a named symbol defined in another TU rather than
/// a local `.data` byte offset. The writer emits one undefined
/// `STT_OBJECT STB_GLOBAL` symbol per unique name and one reloc
/// per ref pointing at that symbol.
#[derive(Debug, Clone)]
#[allow(dead_code)] // consumed only by the std-only elf_reloc writer
pub(crate) struct UserExternDataRef {
    /// Byte offset within `Build::text` of the `adrp` /
    /// `lea`-prefix instruction. The writer pairs it with the
    /// follow-up `add` on aarch64 to emit both halves of the
    /// page-relative load.
    pub instr_offset: usize,
    /// Symbol name of the cross-TU data global.
    pub symbol_name: alloc::string::String,
}

/// Relocation for a function-pointer literal (`Inst::ImmCode`).
/// Same `adrp + add` shape as [`DataFixup`], but the target is
/// another position inside `Build::text` rather than `Build::data`.
#[derive(Debug, Clone, Copy)]
pub(crate) struct FuncFixup {
    /// Byte offset within `Build::text` of the adrp instruction.
    pub adrp_offset: usize,
    /// Byte offset within `Build::text` of the target function's first
    /// instruction. Resolved by the codegen during `lower()` so the
    /// writer doesn't need to consult `pc_to_native` for this entry.
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
    /// Run the SSA optimization passes before register allocation:
    /// mem2reg promotion of address-free local slots, function
    /// inlining (bounded by `inline_cap`), rotate-idiom recognition,
    /// branch const-folding, and immediate deduplication. Off by
    /// default; the per-arch lowering runs these passes only when set.
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
    /// Off by default, matching gcc / clang, which emit no debug
    /// info without `-g`. Enabling it via `-g` / `--debug` adds
    /// compile time (the type-catalog walk is non-trivial on big
    /// inputs) and artifact size (~10-30% on a large translation
    /// unit). The default keeps builds fast and binaries small;
    /// because the DWARF blob is the only output that varies with
    /// the source path, a no-DWARF build is also byte-identical
    /// across runs, useful for golden-hash bisection.
    pub debug_info: bool,
    /// Print each SSA function's IR + allocator output to stderr
    /// before lowering. Same as `--dump-asm` for native code: a
    /// diagnostic emitted alongside the build. Off by default.
    pub dump_ssa: bool,
    /// Upper bound (in SSA `Inst` count) on a leaf function body
    /// that may be inlined at its call sites under `-O`. The
    /// `--inline-cap=N` CLI flag drives this; 0 disables the pass.
    /// Default 64, matching gcc / clang `-O2`'s
    /// `--param max-inline-insns-single=N` (gcc 70, clang ~50).
    pub inline_cap: u32,
    /// Segregate wholly-zero data objects into a no-file-backing
    /// `.bss` region instead of packing them into the file image.
    /// On by default; `BADC_NO_BSS_SEGREGATE` forces it off.
    pub bss_segregate: bool,
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
    /// Consumed by a system linker (`ld`, `lld`, `link.exe`) or by
    /// this compiler's `link_native_objects`. Locks the target at
    /// compile time -- a relocatable produced for one target can't
    /// be linked into a binary for a different one.
    Relocatable,
}

impl Default for NativeOptions {
    /// Defaults: executable output, DWARF off, optimizations off.
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
            debug_info: false,
            dump_ssa: false,
            inline_cap: 64,
            bss_segregate: true,
        }
    }

    /// Set [`Self::inline_cap`] and return self.
    pub const fn with_inline_cap(mut self, cap: u32) -> Self {
        self.inline_cap = cap;
        self
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
#[cfg(feature = "native-emit")]
pub fn emit_native(program: &Program, target: Target) -> Result<Vec<u8>, C5Error> {
    emit_native_with_options(program, target, NativeOptions::default())
}

/// Variant of [`emit_native`] that accepts user-controllable
/// [`NativeOptions`]. `options.optimize` gates the SSA optimization
/// passes (see [`NativeOptions::optimize`]).
#[cfg(feature = "native-emit")]
pub fn emit_native_with_options(
    program: &Program,
    target: Target,
    options: NativeOptions,
) -> Result<Vec<u8>, C5Error> {
    emit_native_with_options_named(program, target, options, None)
}

/// Route a single-TU final image's `#pragma binding(data ...)`
/// references through the GOT, the same way the multi-TU linker does.
///
/// The walker lowers a data-binding reference to an `Inst::ImmData` that
/// the emitter records as a [`UserExternDataRef`] -- a named undefined
/// data reference. The relocatable (`.o`) writer turns that into an
/// undefined symbol the linker later binds through the GOT; a single-TU
/// final image has no link step, so resolve it here instead: register
/// the host data symbol as a flat-namespace import and load its address
/// from the dyld-filled GOT slot, leaving an `adrp + ldr` pair for
/// [`mach_o`] to patch. Without this the reference stays an unresolved
/// `.data`-relative address and faults at runtime.
///
/// Mach-O only: ELF binds the local copy through an `R_*_COPY`
/// relocation and the PE writer has no data-import path.
#[cfg(feature = "native-emit")]
fn route_single_tu_data_imports(build: &mut Build, target: Target) {
    if target != Target::MacOSAarch64 || build.output_kind == OutputKind::Relocatable {
        return;
    }
    if build.imports.data_bindings.is_empty() || build.user_extern_data_refs.is_empty() {
        return;
    }
    // (local name -> host symbol) for every data binding in scope.
    let hosts: alloc::collections::BTreeMap<String, String> = build
        .imports
        .data_bindings
        .iter()
        .map(|(l, h)| (l.clone(), h.clone()))
        .collect();
    let mut import_for: alloc::collections::BTreeMap<String, usize> =
        alloc::collections::BTreeMap::new();
    let mut remaining = Vec::with_capacity(build.user_extern_data_refs.len());
    for r in core::mem::take(&mut build.user_extern_data_refs) {
        let Some(host) = hosts.get(&r.symbol_name) else {
            remaining.push(r);
            continue;
        };
        let idx = *import_for.entry(r.symbol_name.clone()).or_insert_with(|| {
            let i = build.imports.imports.len();
            build.imports.imports.push(ResolvedImport {
                binding_idx: i as i64,
                local_name: r.symbol_name.clone(),
                real_symbol: host.clone(),
                dylib_index: 0,
                flat_lookup: true,
                is_variadic: false,
                fixed_args: 0,
                return_type_tag: 0,
                returns_long_double: false,
                param_types: Vec::new(),
            });
            i
        });
        build.got_fixups.push(GotFixup {
            adrp_offset: r.instr_offset,
            import_index: idx,
            is_data_load: false,
        });
    }
    build.user_extern_data_refs = remaining;
}

/// Whether `BADC_NO_BSS_SEGREGATE` opts a build out of segregating
/// wholly-zero data objects into a no-file-backing `.bss` region. The
/// opt-out exists for debugging and for diffing against the pre-`.bss`
/// file image; segregation is otherwise on by default.
#[cfg(feature = "native-emit")]
fn bss_segregation_disabled() -> bool {
    std::env::var("BADC_NO_BSS_SEGREGATE").is_ok()
}

/// Variant of [`emit_native_with_options`] that records the shared
/// library's own name in the image (PE export-directory Name, Mach-O
/// `LC_ID_DYLIB` install name) so a consumer linking against it by name
/// references the file it loads at runtime. `shared_lib_name` is the
/// `-o` basename for `--shared`; `None` falls back to the per-format
/// default and is ignored for non-shared output.
#[cfg(feature = "native-emit")]
pub fn emit_native_with_options_named(
    program: &Program,
    target: Target,
    options: NativeOptions,
    shared_lib_name: Option<&str>,
) -> Result<Vec<u8>, C5Error> {
    // C99 6.2.2 / 6.7.8: drop static data no surviving function or
    // relocation references, repacking `.data` and rewriting every offset
    // surface (symbol values, AST data offsets, relocation slots). The one
    // compaction feeds both the backend lowering (which bakes data-relative
    // fixups) and the container writer (which emits the symbol table), so
    // the emitted `.data` and its symbols stay consistent.
    let (compacted, bss_size) = crate::c5::codegen::ssa::shadow::compact_program_data(
        program,
        target,
        options.bss_segregate && !bss_segregation_disabled(),
    )?;
    let program = &compacted;
    let mut build = lower_for(program, target, options)?;
    build.bss_size = bss_size;
    route_single_tu_data_imports(&mut build, target);
    if options.output_kind == OutputKind::SharedLibrary {
        build.shared_lib_name = shared_lib_name.map(alloc::string::String::from);
    }
    write_for(program, &build, target)
}

/// Test-only: emit a complete native image for a single program,
/// satisfying the PE entry stub's `__c5_*` runtime-helper references
/// that the bare single-TU path cannot link (production links them
/// from the embedded startup runtime). The injected symbols point at
/// the program entry; the image is inspected for structure, not run.
/// ELF / Mach-O ignore the extra names.
#[cfg(all(test, feature = "native-emit"))]
pub(crate) fn emit_native_single_tu_for_test(
    program: &Program,
    target: Target,
    options: NativeOptions,
) -> Result<alloc::vec::Vec<u8>, C5Error> {
    let (compacted, bss_size) = crate::c5::codegen::ssa::shadow::compact_program_data(
        program,
        target,
        options.bss_segregate && !bss_segregation_disabled(),
    )?;
    let program = &compacted;
    let mut build = lower_for(program, target, options)?;
    build.bss_size = bss_size;
    let pc = build.pc_to_native.len();
    build.pc_to_native.push(build.entry_offset);
    // The entry adapter targets `__c5_entry`; the real link path
    // supplies it from the startup runtime.
    build
        .func_names
        .push(alloc::string::String::from("__c5_entry"));
    build.func_ent_pcs.push(pc);
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
    // The SSA walk only finds bindings the user's code calls --
    // a `int main() { return 42; }` carries no call into `exit` --
    // so force-include it here. Resolves through the same
    // `program.dylibs` lookup as user-emitted bindings would, so a
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
    build.extern_data_relocs = program.extern_data_relocs.clone();
    build.code_relocs = program.code_relocs.clone();
    build.exports = program.exports.clone();
    build.output_kind = options.output_kind;
    build.dllmain_pc = program.dllmain_pc;
    build.debug_info = options.debug_info;
    append_build_info(&mut build);
    Ok(build)
}

/// Append the [`crate::OUTPUT_MARKER`] to the tail of
/// `Build::text`. The bytes never get executed -- the entry
/// point is at `build.entry_offset` and every function ends
/// with a return -- so this is purely a `strings(1)`-friendly
/// fingerprint that says which badc version emitted the binary.
/// The marker is the release version only, with no git state, so
/// the same source/flags/target produce identical output bytes
/// regardless of the build environment.
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
    build
        .text
        .extend_from_slice(crate::OUTPUT_MARKER.as_bytes());
    build.text.push(0);
}

/// Write a native image for `target` given an already-lowered `build`
/// and its source `program`. Internal entry point shared between
/// [`emit_native_with_options`] (single-TU path) and the linker's
/// MergedNative-to-Build synthesizer (multi-TU `.o` link path). The
/// synthesizer is gated behind the `full` + `std` features; the
/// no-default-features build has no consumer for this entry point.
#[cfg(all(feature = "full", feature = "std"))]
pub(crate) fn write_native_image(
    program: &Program,
    build: &Build,
    target: Target,
) -> Result<Vec<u8>, C5Error> {
    write_for(program, build, target)
}

#[cfg(feature = "native-emit")]
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
        return elf_reloc::write_relocatable(program, build, machine, target);
    }
    // The no-std build can't reach the relocatable writer; the
    // `-c` path lives in the CLI, which itself is std-only. If
    // a no-std caller ever surfaces `Relocatable` it would
    // fall through to the final-image writers below; the
    // unreachable branch keeps the match arms exhaustive
    // without pulling `elf_reloc` into the no-std build.
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
    /// patchers) carry one struct around rather than two.
    #[allow(dead_code)]
    pub arch: Arch,
    /// Any args past the slice spill to the native stack at
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
    /// regs used at every variadic call site.
    pub variadic_zero_xmm_count: bool,
    /// Windows commits thread stack on demand behind a guard page, so a
    /// prologue allocating more than one page must touch each page in
    /// descending order or a later access faults. SysV / macOS grow the
    /// stack without a probe. Set for the Windows targets.
    pub stack_probe: bool,
}

impl Abi {
    /// True when variadic c5 callees use the System V AMD64 host
    /// variadic ABI (Linux x86_64): the named and variadic arguments
    /// ride the standard integer + FP argument-register banks
    /// (System V AMD64 3.2.3) and the callee spills a register save
    /// area (3.5.7). System V is the x86_64 target with no shadow
    /// space, no by-position argument placement, and the `al`
    /// XMM-count convention; this distinguishes it from Win64
    /// (`position_indexed_args`, shadow space, no `al`) and from
    /// the aarch64 targets. The caller passes the real `fp_arg_mask`
    /// for such a callee so floating-point varargs land in xmm0..xmm7.
    pub(crate) fn sysv_host_variadic(self) -> bool {
        matches!(self.arch, Arch::X86_64)
            && self.shadow_space == 0
            && !self.position_indexed_args
            && self.variadic_zero_xmm_count
    }

    /// True when variadic c5 callees use the AAPCS64 host variadic ABI
    /// (Linux aarch64): the named and variadic arguments ride the
    /// standard integer + FP argument-register banks (AAPCS64 6.4.1)
    /// and the callee spills a general / vector register save area
    /// (AAPCS64 Appendix B). Among the aarch64 targets macOS sets
    /// `variadic_on_stack` (named in registers, variadic tail on the
    /// stack) and Windows sets `variadic_int_only` (one integer bank);
    /// the plain AAPCS64 target sets neither, so this gate selects
    /// Linux aarch64 alone. The caller passes the real `fp_arg_mask`
    /// for such a callee so floating-point varargs land in d0..d7.
    pub(crate) fn aarch64_host_variadic(self) -> bool {
        matches!(self.arch, Arch::Aarch64) && !self.variadic_on_stack && !self.variadic_int_only
    }
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
                stack_probe: false,
            },
            Target::LinuxAarch64 => Abi {
                arch: Arch::Aarch64,
                int_arg_regs: AARCH64_INT_ARGS,
                shadow_space: 0,
                variadic_on_stack: false,
                variadic_int_only: false,
                position_indexed_args: false,
                variadic_zero_xmm_count: false,
                stack_probe: false,
            },
            Target::LinuxX64 => Abi {
                arch: Arch::X86_64,
                int_arg_regs: SYSV_INT_ARGS,
                shadow_space: 0,
                variadic_on_stack: false,
                variadic_int_only: false,
                position_indexed_args: false,
                variadic_zero_xmm_count: true,
                stack_probe: false,
            },
            Target::WindowsX64 => Abi {
                arch: Arch::X86_64,
                int_arg_regs: WIN64_INT_ARGS,
                shadow_space: 32,
                variadic_on_stack: false,
                variadic_int_only: true,
                position_indexed_args: true,
                variadic_zero_xmm_count: false,
                stack_probe: true,
            },
            Target::WindowsAarch64 => Abi {
                arch: Arch::Aarch64,
                int_arg_regs: AARCH64_INT_ARGS,
                shadow_space: 0,
                variadic_on_stack: false,
                variadic_int_only: true,
                position_indexed_args: false,
                variadic_zero_xmm_count: false,
                stack_probe: true,
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

#[cfg(test)]
mod abi_plan_tests {
    use super::abi_classify::{AggClass, RegClass};
    use super::{ArgAgg, ArgPlacement, Target, plan_call_args_aggs};

    // A register-passed aggregate that spills must exhaust the correct
    // register file: nothing on System V (only the aggregate goes to
    // memory), the matching file on AAPCS64 (NGRN for a GP composite,
    // NSRN for an HFA). Earlier code unconditionally pinned the integer
    // file, stranding trailing scalars at the FFI boundary.
    #[test]
    fn sysv_spilled_aggregate_keeps_int_reg_for_trailing_scalar() {
        let abi = Target::LinuxX64.abi();
        let gp = ArgAgg {
            class: AggClass::Regs(alloc::vec![RegClass::Integer, RegClass::Integer]),
            size: 16,
        };
        // five int scalars, a 2-eightbyte GP aggregate that can't fit the
        // one remaining int reg, then one int scalar.
        let aggs = [None, None, None, None, None, Some(gp), None];
        let plan = plan_call_args_aggs(7, 7, 0, abi, &aggs, false);
        assert!(matches!(
            plan.placements[5],
            ArgPlacement::StructStack { .. }
        ));
        assert_eq!(
            plan.placements[6],
            ArgPlacement::IntReg(abi.int_arg_regs[5])
        );
    }

    #[test]
    fn aapcs64_spilled_hfa_exhausts_fp_not_int_file() {
        let abi = Target::LinuxAarch64.abi();
        let hfa = ArgAgg {
            class: AggClass::Regs(alloc::vec![RegClass::Sse; 4]),
            size: 16,
        };
        // five FP scalars, a 4-float HFA that can't fit the remaining FP
        // regs, then one int scalar that the integer file must still hold.
        let aggs = [None, None, None, None, None, Some(hfa), None];
        let plan = plan_call_args_aggs(7, 7, 0b1_1111, abi, &aggs, false);
        assert!(matches!(
            plan.placements[5],
            ArgPlacement::StructStack { .. }
        ));
        assert_eq!(
            plan.placements[6],
            ArgPlacement::IntReg(abi.int_arg_regs[0])
        );
    }
}
