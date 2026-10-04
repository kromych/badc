//! The initial-exec, general- and local-dynamic and descriptor sequences
//! an executable link rewrites to local-exec, since its thread-locals sit
//! at offsets it knows: the transitions of the x86-64 psABI TLS supplement
//! and AAELF64, as GNU ld and lld make them. A rewritten local-dynamic
//! sequence yields the thread pointer, so its offsets are taken from it. A
//! site whose bytes are not the stated sequence is refused.

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

const A64_NOP: u32 = 0xd503_201f;
const A64_MRS_X1_TP: u32 = 0xd53b_d041; // mrs x1, tpidr_el0
const A64_ADD_X0_X1_X0: u32 = 0x8b00_0020; // add x0, x1, x0
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
/// `text` to local-exec with `tpoff`, the offset from the thread pointer.
pub(crate) fn x86_64_local_exec(
    text: &mut [u8],
    at: usize,
    rtype: u32,
    tpoff: i32,
) -> Result<(), Expected> {
    let imm = tpoff.to_le_bytes();
    match rtype {
        R_X86_64_GOTTPOFF => {
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
        R_X86_64_TLSGD => {
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
            text[start + 9..start + 12].copy_from_slice(&[0x48, 0x8d, 0x80]);
            text[start + 12..start + 16].copy_from_slice(&imm);
        }
        R_X86_64_TLSLD => {
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
        R_X86_64_GOTPC32_TLSDESC => {
            const WANT: Expected = "`lea` of the descriptor to a register";
            let start = at.checked_sub(3).ok_or(WANT)?;
            let [rex, op, modrm] = read(text, start).ok_or(WANT)?;
            read::<4>(text, at).ok_or(WANT)?;
            if rex & 0xfb != 0x48 || op != 0x8d || modrm & 0xc7 != 0x05 {
                return Err(WANT);
            }
            text[start..at].copy_from_slice(&[0x48 | rex >> 2 & 1, 0xc7, 0xc0 | modrm >> 3 & 7]);
            text[at..at + 4].copy_from_slice(&imm);
        }
        R_X86_64_TLSDESC_CALL => {
            if read::<2>(text, at) != Some([0xff, 0x10]) {
                return Err("the descriptor call `call *(%rax)`");
            }
            text[at..at + 2].copy_from_slice(&[0x66, 0x90]); // xchg %ax, %ax
        }
        _ => return Err("a thread-local access sequence"),
    }
    Ok(())
}

fn word(text: &[u8], at: usize) -> Option<u32> {
    read(text, at).map(u32::from_le_bytes)
}

fn put_word(text: &mut [u8], at: usize, w: u32) {
    text[at..at + 4].copy_from_slice(&w.to_le_bytes());
}

/// Rewrite the aarch64 instruction the `rtype` relocation at `at` in `text`
/// names to its part of `movz` / `movk` of `tpoff`, or a `nop`.
pub(crate) fn aarch64_local_exec(
    text: &mut [u8],
    at: usize,
    rtype: u32,
    tpoff: u32,
) -> Result<(), Expected> {
    let movz = |rd: u32| 0xd2a0_0000 | (tpoff >> 16) << 5 | rd;
    let movk = |rd: u32| 0xf280_0000 | (tpoff & 0xffff) << 5 | rd;
    let insn = word(text, at).ok_or("an instruction")?;
    let new = match rtype {
        R_AARCH64_TLSIE_ADR_GOTTPREL_PAGE21 => {
            if insn & 0x9f00_0000 != 0x9000_0000 {
                return Err("`adrp`");
            }
            movz(insn & 0x1f)
        }
        // The `movk` completes the `movz` only in the register the page took.
        R_AARCH64_TLSIE_LD64_GOTTPREL_LO12_NC => {
            if insn & 0xffc0_0000 != 0xf940_0000 || insn & 0x1f != insn >> 5 & 0x1f {
                return Err("`ldr` of a 64-bit GOT entry into its base register");
            }
            movk(insn & 0x1f)
        }
        R_AARCH64_TLSGD_ADR_PAGE21 | R_AARCH64_TLSDESC_ADR_PAGE21 => {
            if insn & 0x9f00_001f != 0x9000_0000 {
                return Err("`adrp` to x0");
            }
            movz(0)
        }
        R_AARCH64_TLSGD_ADD_LO12_NC => {
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
            movk(0)
        }
        R_AARCH64_TLSDESC_LD64_LO12 => {
            if insn & 0xffc0_03e0 != 0xf940_0000 {
                return Err("`ldr` of a 64-bit descriptor word from x0");
            }
            movk(0)
        }
        R_AARCH64_TLSDESC_ADD_LO12 => {
            if insn & 0xffc0_03ff != 0x9100_0000 {
                return Err("`add` to x0 from x0");
            }
            A64_NOP
        }
        R_AARCH64_TLSDESC_CALL => {
            if insn & 0xffff_fc1f != 0xd63f_0000 {
                return Err("`blr`");
            }
            A64_NOP
        }
        _ => return Err("a thread-local access sequence"),
    };
    put_word(text, at, new);
    Ok(())
}
