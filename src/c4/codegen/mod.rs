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
use alloc::vec::Vec;

use super::error::C4Error;
use super::program::Program;

mod aarch64;
mod disasm;
mod elf;
mod mach_o;
mod x86_64;

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
}

impl Target {
    /// Parse the value passed to `--emit-native` (or use the default
    /// for the single supported target). Reserved for when the flag
    /// grows a value form like `--emit-native=linux-x64`.
    pub fn parse(spec: Option<&str>) -> Result<Self, C4Error> {
        match spec {
            None | Some("macos-aarch64") | Some("aarch64-apple-darwin") => Ok(Target::MacOSAarch64),
            Some("linux-aarch64") | Some("aarch64-unknown-linux-gnu") => Ok(Target::LinuxAarch64),
            Some("linux-x64") | Some("linux-x86-64") | Some("x86_64-unknown-linux-gnu") => {
                Ok(Target::LinuxX64)
            }
            Some(other) => Err(C4Error::Compile(format!(
                "unsupported native target: {other:?} \
                 (try `macos-aarch64`, `linux-aarch64`, or `linux-x64`)"
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

/// Translate a [`Program`] into a native binary. The bytes are written
/// to `out` in whatever format the [`Target`] requires; on macOS, the
/// caller is responsible for invoking `codesign` afterwards (handled
/// by the CLI shim, not by this function -- code-signing is a runtime
/// concern, not part of the format).
///
/// Returns the raw image bytes so the caller can decide whether to
/// write them to disk, embed them, hash them, etc.
pub fn emit_native(program: &Program, target: Target) -> Result<Vec<u8>, C4Error> {
    let build = lower_for(program, target)?;
    write_for(&build, target)
}

/// Lower the program for `target`, returning the per-arch `Build`
/// without writing to any container. Used by both [`emit_native`]
/// (which then runs the container writer) and the listing-dump path
/// (which inspects the lowered bytes directly).
fn lower_for(program: &Program, target: Target) -> Result<Build, C4Error> {
    match target {
        Target::MacOSAarch64 | Target::LinuxAarch64 => aarch64::lower(program, target),
        Target::LinuxX64 => x86_64::lower(program, target),
    }
}

fn write_for(build: &Build, target: Target) -> Result<Vec<u8>, C4Error> {
    match target {
        Target::MacOSAarch64 => mach_o::write(build),
        Target::LinuxAarch64 => elf::write(build, Machine::Aarch64),
        Target::LinuxX64 => elf::write(build, Machine::X86_64),
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
    let build = lower_for(program, target)?;
    Ok(disasm::dump(program, &build, target))
}

/// Per-target ABI knobs that affect lowering, not just the final
/// container. Today the only divergence between MacOSAarch64 and
/// LinuxAarch64 is variadic-call ABI; future targets will add to
/// this struct rather than growing the lower-fn signature.
#[derive(Debug, Clone, Copy)]
pub(crate) struct TargetOptions {
    /// macOS arm64 packs variadic args into stack scratch slots
    /// (8-byte spaced) regardless of how many would fit in
    /// x0..x7. Standard AAPCS64 (Linux) uses the same registers as
    /// non-variadic calls. `true` selects the macOS dance.
    pub variadic_on_stack: bool,
}

impl Target {
    pub(crate) fn options(self) -> TargetOptions {
        match self {
            Target::MacOSAarch64 => TargetOptions {
                variadic_on_stack: true,
            },
            Target::LinuxAarch64 => TargetOptions {
                variadic_on_stack: false,
            },
            Target::LinuxX64 => TargetOptions {
                variadic_on_stack: false,
            },
        }
    }
}
