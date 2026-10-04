//! The initial-exec, general- and local-dynamic and descriptor sequences
//! an executable link rewrites to local-exec, since its thread-locals sit
//! at offsets it knows, and the general-dynamic and descriptor ones it
//! rewrites to initial-exec for a shared library's thread-local, which sits
//! where the loader places that library's block: the transitions of the
//! x86-64 psABI TLS supplement and AAELF64, as GNU ld and lld make them. A
//! rewritten local-dynamic sequence yields the thread pointer, so its
//! offsets are taken from it. A site whose bytes are not the stated
//! sequence is refused.

use super::object::NativeMachine;
use crate::c5::object::elf_reloc_types::{
    AbsCheck, R_AARCH64_TLSDESC_ADD_LO12, R_AARCH64_TLSDESC_ADR_PAGE21, R_AARCH64_TLSDESC_CALL,
    R_AARCH64_TLSDESC_LD64_LO12, R_AARCH64_TLSGD_ADD_LO12_NC, R_AARCH64_TLSGD_ADR_PAGE21,
    R_AARCH64_TLSIE_ADR_GOTTPREL_PAGE21, R_AARCH64_TLSIE_LD64_GOTTPREL_LO12_NC, R_X86_64_DTPOFF32,
    R_X86_64_DTPOFF64, R_X86_64_GOTPC32_TLSDESC, R_X86_64_GOTTPOFF, R_X86_64_TLSDESC_CALL,
    R_X86_64_TLSGD, R_X86_64_TLSLD,
};

/// The module's thread-local block, named by a local-dynamic descriptor
/// sequence; 0 from the thread pointer once the sequence is rewritten.
pub(crate) const TLS_MODULE_BASE: &str = "_TLS_MODULE_BASE_";

/// The resolver a general- or local-dynamic sequence calls.
pub(crate) const TLS_GET_ADDR: &str = "__tls_get_addr";

/// What a site's bytes had to be for its rewrite.
pub(crate) type Expected = &'static str;

/// The model a rewritten sequence ends in.
#[derive(Clone, Copy)]
pub(crate) enum Model<T> {
    /// Local-exec, with the variable's offset from the thread pointer.
    LocalExec(T),
    /// Initial-exec, reading that offset from a GOT slot the loader fills.
    InitialExec,
}

impl<T> Model<T> {
    pub(crate) fn name(&self) -> &'static str {
        match self {
            Model::LocalExec(_) => "local-exec",
            Model::InitialExec => "initial-exec",
        }
    }
}

/// Where a sequence rewritten to initial-exec addresses its GOT slot: the
/// field's offset and the relocation type that now describes it.
pub(crate) type SlotField = Option<(usize, u32)>;

const A64_NOP: u32 = 0xd503_201f;
const A64_MRS_X1_TP: u32 = 0xd53b_d041; // mrs x1, tpidr_el0
const A64_ADD_X0_X1_X0: u32 = 0x8b00_0020; // add x0, x1, x0
const A64_LDR_X0_X0: u32 = 0xf940_0000; // ldr x0, [x0]
const X64_LOAD_TP: [u8; 9] = [0x64, 0x48, 0x8b, 0x04, 0x25, 0, 0, 0, 0]; // mov %fs:0, %rax

/// Whether an executable link rewrites a relocation of this type, or takes
/// it from the thread pointer once the sequence around it is rewritten.
pub(crate) fn transitions(machine: NativeMachine, rtype: u32) -> bool {
    match machine {
        NativeMachine::X86_64 => matches!(
            rtype,
            R_X86_64_GOTTPOFF
                | R_X86_64_TLSGD
                | R_X86_64_TLSLD
                | R_X86_64_DTPOFF32
                | R_X86_64_DTPOFF64
                | R_X86_64_GOTPC32_TLSDESC
                | R_X86_64_TLSDESC_CALL
        ),
        NativeMachine::Aarch64 => matches!(
            rtype,
            R_AARCH64_TLSIE_ADR_GOTTPREL_PAGE21
                | R_AARCH64_TLSIE_LD64_GOTTPREL_LO12_NC
                | R_AARCH64_TLSGD_ADR_PAGE21
                | R_AARCH64_TLSGD_ADD_LO12_NC
                | R_AARCH64_TLSDESC_ADR_PAGE21
                | R_AARCH64_TLSDESC_LD64_LO12
                | R_AARCH64_TLSDESC_ADD_LO12
                | R_AARCH64_TLSDESC_CALL
        ),
    }
}

/// Whether a relocation of this type addresses the GOT slot holding a
/// thread-local's offset from the thread pointer: the initial-exec model.
pub(crate) fn is_initial_exec(machine: NativeMachine, rtype: u32) -> bool {
    matches!(
        (machine, rtype),
        (NativeMachine::X86_64, R_X86_64_GOTTPOFF)
            | (
                NativeMachine::Aarch64,
                R_AARCH64_TLSIE_ADR_GOTTPREL_PAGE21 | R_AARCH64_TLSIE_LD64_GOTTPREL_LO12_NC
            )
    )
}

/// Whether a relocation of this type belongs to the local-dynamic model,
/// which reaches the module's own block only.
pub(crate) fn is_local_dynamic(machine: NativeMachine, rtype: u32) -> bool {
    machine == NativeMachine::X86_64
        && matches!(
            rtype,
            R_X86_64_TLSLD | R_X86_64_DTPOFF32 | R_X86_64_DTPOFF64
        )
}

/// Whether a relocation of this type opens a sequence calling `__tls_get_addr`.
pub(crate) fn calls_resolver(machine: NativeMachine, rtype: u32) -> bool {
    matches!(
        (machine, rtype),
        (NativeMachine::X86_64, R_X86_64_TLSGD | R_X86_64_TLSLD)
            | (NativeMachine::Aarch64, R_AARCH64_TLSGD_ADD_LO12_NC)
    )
}

/// Where the relocation of the `__tls_get_addr` call belongs in the
/// sequence the `rtype` relocation at `at` in `text` opens, if any.
pub(crate) fn resolver_call(
    machine: NativeMachine,
    rtype: u32,
    text: &[u8],
    at: usize,
) -> Option<usize> {
    match (machine, rtype) {
        (NativeMachine::X86_64, R_X86_64_TLSGD) => Some(at + 8),
        (NativeMachine::X86_64, R_X86_64_TLSLD) => match text.get(at + 4..at + 6)? {
            [0xe8, _] => Some(at + 5),
            [0xff, 0x15] => Some(at + 6),
            _ => None,
        },
        (NativeMachine::Aarch64, R_AARCH64_TLSGD_ADD_LO12_NC) => Some(at + 4),
        _ => None,
    }
}

/// Width and overflow rule of an x86-64 local-dynamic offset field,
/// `x@dtpoff`, which a rewritten sequence reads from the thread pointer.
pub(crate) fn x86_64_dtpoff_field(rtype: u32) -> Option<(u32, AbsCheck)> {
    match rtype {
        R_X86_64_DTPOFF32 => Some((4, AbsCheck::Signed)),
        R_X86_64_DTPOFF64 => Some((8, AbsCheck::None)),
        _ => None,
    }
}

/// The -4 a RIP-relative form's addend carries, which the immediate that
/// replaces the operand does not.
pub(crate) fn x86_64_addend_bias(rtype: u32) -> i64 {
    match rtype {
        R_X86_64_GOTTPOFF | R_X86_64_TLSGD | R_X86_64_GOTPC32_TLSDESC => 4,
        _ => 0,
    }
}

fn read<const N: usize>(text: &[u8], at: usize) -> Option<[u8; N]> {
    text.get(at..at.checked_add(N)?)?.try_into().ok()
}

/// Rewrite the x86-64 sequence whose `rtype` relocation sits at `at` in
/// `text` to the model `to`. Initial-exec is reached from the general-dynamic
/// and descriptor sequences only.
pub(crate) fn x86_64_rewrite(
    text: &mut [u8],
    at: usize,
    rtype: u32,
    to: Model<i32>,
) -> Result<SlotField, Expected> {
    let imm = match to {
        Model::LocalExec(tpoff) => Some(tpoff.to_le_bytes()),
        Model::InitialExec => None,
    };
    match (rtype, imm) {
        (R_X86_64_GOTTPOFF, Some(imm)) => {
            const WANT: Expected = "`mov` or `add` from a RIP-relative quadword to a register";
            let start = at.checked_sub(3).ok_or(WANT)?;
            let [rex, op, modrm] = read(text, start).ok_or(WANT)?;
            read::<4>(text, at).ok_or(WANT)?;
            if !matches!(rex, 0x48 | 0x4c) || !matches!(op, 0x8b | 0x03) || modrm & 0xc7 != 0x05 {
                return Err(WANT);
            }
            let reg = modrm >> 3 & 7;
            let high = rex >> 2 & 1;
            let insn = if op == 0x8b {
                [0x48 | high, 0xc7, 0xc0 | reg]
            } else if reg == 4 {
                [0x48 | high, 0x81, 0xc0 | reg] // `lea` from %rsp or %r12 needs a SIB byte
            } else {
                [0x48 | high << 2 | high, 0x8d, 0x80 | reg << 3 | reg]
            };
            text[start..at].copy_from_slice(&insn);
            text[at..at + 4].copy_from_slice(&imm);
        }
        (R_X86_64_TLSGD, imm) => {
            const WANT: Expected = "`data16 lea` to %rdi, then the `__tls_get_addr` call";
            let start = at.checked_sub(4).ok_or(WANT)?;
            let lead = read::<4>(text, start).ok_or(WANT)?;
            let call = read::<4>(text, at + 4).ok_or(WANT)?;
            read::<4>(text, at + 8).ok_or(WANT)?;
            if lead != [0x66, 0x48, 0x8d, 0x3d]
                || !matches!(call, [0x66, 0x66, 0x48, 0xe8] | [0x66, 0x48, 0xff, 0x15])
            {
                return Err(WANT);
            }
            text[start..start + 9].copy_from_slice(&X64_LOAD_TP);
            let Some(imm) = imm else {
                // add x@gottpoff(%rip), %rax
                text[start + 9..start + 12].copy_from_slice(&[0x48, 0x03, 0x05]);
                return Ok(Some((start + 12, R_X86_64_GOTTPOFF)));
            };
            text[start + 9..start + 12].copy_from_slice(&[0x48, 0x8d, 0x80]);
            text[start + 12..start + 16].copy_from_slice(&imm);
        }
        (R_X86_64_TLSLD, Some(_)) => {
            const WANT: Expected = "`lea` to %rdi, then the `__tls_get_addr` call";
            let start = at.checked_sub(3).ok_or(WANT)?;
            let len = match (read::<3>(text, start), text.get(at + 4..at + 6)) {
                (Some([0x48, 0x8d, 0x3d]), Some([0xe8, _])) => 12,
                (Some([0x48, 0x8d, 0x3d]), Some([0xff, 0x15])) => 13,
                _ => return Err(WANT),
            };
            let end = start + len;
            if end > text.len() {
                return Err(WANT);
            }
            text[start..end - 9].fill(0x66); // data16
            text[end - 9..end].copy_from_slice(&X64_LOAD_TP);
        }
        (R_X86_64_GOTPC32_TLSDESC, imm) => {
            const WANT: Expected = "`lea` of the descriptor to a register";
            let start = at.checked_sub(3).ok_or(WANT)?;
            let [rex, op, modrm] = read(text, start).ok_or(WANT)?;
            read::<4>(text, at).ok_or(WANT)?;
            if rex & 0xfb != 0x48 || op != 0x8d || modrm & 0xc7 != 0x05 {
                return Err(WANT);
            }
            let Some(imm) = imm else {
                text[start + 1] = 0x8b; // mov x@gottpoff(%rip), %reg
                return Ok(Some((at, R_X86_64_GOTTPOFF)));
            };
            text[start..at].copy_from_slice(&[0x48 | rex >> 2 & 1, 0xc7, 0xc0 | modrm >> 3 & 7]);
            text[at..at + 4].copy_from_slice(&imm);
        }
        (R_X86_64_TLSDESC_CALL, _) => {
            if read::<2>(text, at) != Some([0xff, 0x10]) {
                return Err("the descriptor call `call *(%rax)`");
            }
            text[at..at + 2].copy_from_slice(&[0x66, 0x90]); // xchg %ax, %ax
        }
        (_, Some(_)) => return Err("a thread-local access sequence"),
        (_, None) => return Err("a general-dynamic or descriptor sequence"),
    }
    Ok(None)
}

fn word(text: &[u8], at: usize) -> Option<u32> {
    read(text, at).map(u32::from_le_bytes)
}

fn put_word(text: &mut [u8], at: usize, w: u32) {
    text[at..at + 4].copy_from_slice(&w.to_le_bytes());
}

/// Rewrite the aarch64 instruction the `rtype` relocation at `at` in `text`
/// names to its part of the model `to`: `movz` / `movk` of the offset from
/// the thread pointer, the `adrp` / `ldr` of its GOT slot, or a `nop`.
/// Initial-exec is reached from the general-dynamic and descriptor
/// sequences only.
pub(crate) fn aarch64_rewrite(
    text: &mut [u8],
    at: usize,
    rtype: u32,
    to: Model<u32>,
) -> Result<SlotField, Expected> {
    let tpoff = match to {
        Model::LocalExec(tpoff) => Some(tpoff),
        Model::InitialExec => None,
    };
    let movz = |rd: u32| tpoff.map(|t| 0xd2a0_0000 | (t >> 16) << 5 | rd);
    let movk = |rd: u32| tpoff.map(|t| 0xf280_0000 | (t & 0xffff) << 5 | rd);
    // The initial-exec instruction and the GOT slot field it leaves at `at`.
    let slot = |insn: u32, rtype: u32| (Some(insn), Some((at, rtype)));
    let insn = word(text, at).ok_or("an instruction")?;
    let (new, field) = match (rtype, tpoff) {
        (R_AARCH64_TLSIE_ADR_GOTTPREL_PAGE21, Some(_)) => {
            if insn & 0x9f00_0000 != 0x9000_0000 {
                return Err("`adrp`");
            }
            (movz(insn & 0x1f), None)
        }
        // The `movk` completes the `movz` only in the register the page took.
        (R_AARCH64_TLSIE_LD64_GOTTPREL_LO12_NC, Some(_)) => {
            if insn & 0xffc0_0000 != 0xf940_0000 || insn & 0x1f != insn >> 5 & 0x1f {
                return Err("`ldr` of a 64-bit GOT entry into its base register");
            }
            (movk(insn & 0x1f), None)
        }
        // The `adrp` stands; its page becomes the GOT slot's.
        (R_AARCH64_TLSGD_ADR_PAGE21 | R_AARCH64_TLSDESC_ADR_PAGE21, _) => {
            if insn & 0x9f00_001f != 0x9000_0000 {
                return Err("`adrp` to x0");
            }
            match movz(0) {
                Some(movz) => (Some(movz), None),
                None => slot(insn, R_AARCH64_TLSIE_ADR_GOTTPREL_PAGE21),
            }
        }
        (R_AARCH64_TLSGD_ADD_LO12_NC, _) => {
            const WANT: Expected = "`add` to x0 from x0, then `bl __tls_get_addr` and `nop`";
            let (call, nop) = (
                word(text, at + 4).ok_or(WANT)?,
                word(text, at + 8).ok_or(WANT)?,
            );
            if insn & 0xffc0_03ff != 0x9100_0000
                || call & 0xfc00_0000 != 0x9400_0000
                || nop != A64_NOP
            {
                return Err(WANT);
            }
            put_word(text, at + 4, A64_MRS_X1_TP);
            put_word(text, at + 8, A64_ADD_X0_X1_X0);
            match movk(0) {
                Some(movk) => (Some(movk), None),
                None => slot(A64_LDR_X0_X0, R_AARCH64_TLSIE_LD64_GOTTPREL_LO12_NC),
            }
        }
        (R_AARCH64_TLSDESC_LD64_LO12, _) => {
            if insn & 0xffc0_03e0 != 0xf940_0000 {
                return Err("`ldr` of a 64-bit descriptor word from x0");
            }
            match movk(0) {
                Some(movk) => (Some(movk), None),
                None => slot(A64_LDR_X0_X0, R_AARCH64_TLSIE_LD64_GOTTPREL_LO12_NC),
            }
        }
        (R_AARCH64_TLSDESC_ADD_LO12, _) => {
            if insn & 0xffc0_03ff != 0x9100_0000 {
                return Err("`add` to x0 from x0");
            }
            (Some(A64_NOP), None)
        }
        (R_AARCH64_TLSDESC_CALL, _) => {
            if insn & 0xffff_fc1f != 0xd63f_0000 {
                return Err("`blr`");
            }
            (Some(A64_NOP), None)
        }
        (_, Some(_)) => return Err("a thread-local access sequence"),
        (_, None) => return Err("a general-dynamic or descriptor sequence"),
    };
    if let Some(new) = new {
        put_word(text, at, new);
    }
    Ok(field)
}
