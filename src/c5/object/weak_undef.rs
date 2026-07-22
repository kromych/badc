//! Instruction rewrites that make a reference to an undefined weak
//! symbol behave as a reference to address 0 (ELF semantics for a weak
//! reference nothing on the link line satisfies). A branch becomes a
//! no-op; an address-materializing instruction is rewritten to produce
//! the constant 0, so the `if (fn) fn();` guard idiom reads a null
//! pointer.
//!
//! Each function takes the byte offset of the instruction it rewrites
//! and returns `false` when the bytes at that offset are not the
//! expected shape, leaving the caller to raise a diagnostic. Two
//! callers share these: the multi-unit linker, which locates the site
//! from a relocation, and the single-TU final-image emitter, which has
//! the site recorded by codegen.

/// AArch64 `nop`.
const AARCH64_NOP: u32 = 0xd503_201f;

fn read_u32(text: &[u8], offset: usize) -> Option<u32> {
    text.get(offset..offset + 4)
        .map(|w| u32::from_le_bytes(w.try_into().unwrap()))
}

fn write_u32(text: &mut [u8], offset: usize, word: u32) {
    text[offset..offset + 4].copy_from_slice(&word.to_le_bytes());
}

/// `bl` / `b` at `offset` -> `nop`.
pub(crate) fn aarch64_branch_to_nop(text: &mut [u8], offset: usize) -> bool {
    if read_u32(text, offset).is_none() {
        return false;
    }
    write_u32(text, offset, AARCH64_NOP);
    true
}

/// `adrp xd, <page>` at `offset` -> `movz xd, #0`.
pub(crate) fn aarch64_adrp_to_zero(text: &mut [u8], offset: usize) -> bool {
    let Some(instr) = read_u32(text, offset) else {
        return false;
    };
    write_u32(text, offset, 0xd280_0000 | (instr & 0x1f));
    true
}

/// `add xd, xn, #lo12` at `offset`, following an `adrp` already
/// rewritten to produce 0 in `xn`. Keeps the destination 0 whether or
/// not it aliases the source.
pub(crate) fn aarch64_add_lo12_to_zero(text: &mut [u8], offset: usize) -> bool {
    let Some(instr) = read_u32(text, offset) else {
        return false;
    };
    let rd = instr & 0x1f;
    let rn = (instr >> 5) & 0x1f;
    let repl = if rd == rn {
        AARCH64_NOP
    } else {
        0xd280_0000 | rd
    };
    write_u32(text, offset, repl);
    true
}

/// `call rel32` / `jmp rel32` at `offset` -> the 5-byte `nop`.
pub(crate) fn x86_64_branch_to_nop(text: &mut [u8], offset: usize) -> bool {
    let Some(slot) = text.get_mut(offset..offset + 5) else {
        return false;
    };
    if slot[0] != 0xE8 && slot[0] != 0xE9 {
        return false;
    }
    slot.copy_from_slice(&[0x0F, 0x1F, 0x44, 0x00, 0x00]);
    true
}

/// `REX lea reg, [rip+disp32]` at `offset` -> `mov reg, 0` (`C7 /0
/// imm32`). The modrm reg field moves to rm, so the REX.R bit becomes
/// REX.B; REX.W carries over.
pub(crate) fn x86_64_lea_to_zero(text: &mut [u8], offset: usize) -> bool {
    let Some(slot) = text.get_mut(offset..offset + 7) else {
        return false;
    };
    if !(0x40..=0x4f).contains(&slot[0]) || slot[1] != 0x8D || slot[2] & 0xC7 != 0x05 {
        return false;
    }
    let rex = slot[0];
    let reg = (slot[2] >> 3) & 0x7;
    slot[0] = 0x40 | (rex & 0x08) | ((rex & 0x04) >> 2);
    slot[1] = 0xC7;
    slot[2] = 0xC0 | reg;
    slot[3..7].copy_from_slice(&[0, 0, 0, 0]);
    true
}

#[cfg(test)]
mod tests {
    use super::*;
    use alloc::vec;

    #[test]
    fn lea_rax_becomes_mov_rax_zero() {
        // 48 8d 05 <disp32> -- lea rax, [rip+disp32]
        let mut text = vec![0x48, 0x8D, 0x05, 0x11, 0x22, 0x33, 0x44];
        assert!(x86_64_lea_to_zero(&mut text, 0));
        assert_eq!(text, vec![0x48, 0xC7, 0xC0, 0, 0, 0, 0]);
    }

    #[test]
    fn lea_extended_reg_moves_rex_r_to_rex_b() {
        // 4c 8d 1d <disp32> -- lea r11, [rip+disp32]
        let mut text = vec![0x4C, 0x8D, 0x1D, 0, 0, 0, 0];
        assert!(x86_64_lea_to_zero(&mut text, 0));
        // 49 c7 c3 -- mov r11, 0
        assert_eq!(text, vec![0x49, 0xC7, 0xC3, 0, 0, 0, 0]);
    }

    #[test]
    fn non_lea_shape_is_rejected() {
        let mut text = vec![0x48, 0x8B, 0x05, 0, 0, 0, 0];
        assert!(!x86_64_lea_to_zero(&mut text, 0));
    }

    #[test]
    fn call_becomes_five_byte_nop() {
        let mut text = vec![0xE8, 0x01, 0x02, 0x03, 0x04];
        assert!(x86_64_branch_to_nop(&mut text, 0));
        assert_eq!(text, vec![0x0F, 0x1F, 0x44, 0x00, 0x00]);
    }

    #[test]
    fn adrp_becomes_movz_same_register() {
        // adrp x7, <page>
        let mut text = 0x9000_0007u32.to_le_bytes().to_vec();
        assert!(aarch64_adrp_to_zero(&mut text, 0));
        assert_eq!(
            u32::from_le_bytes(text[..].try_into().unwrap()),
            0xd280_0007
        );
    }

    #[test]
    fn add_lo12_aliasing_source_becomes_nop() {
        // add x7, x7, #0x10
        let mut text = 0x9100_40e7u32.to_le_bytes().to_vec();
        assert!(aarch64_add_lo12_to_zero(&mut text, 0));
        assert_eq!(
            u32::from_le_bytes(text[..].try_into().unwrap()),
            AARCH64_NOP
        );
    }

    #[test]
    fn truncated_site_is_rejected() {
        let mut text = vec![0x48, 0x8D];
        assert!(!x86_64_lea_to_zero(&mut text, 0));
        assert!(!x86_64_branch_to_nop(&mut text, 0));
        assert!(!aarch64_branch_to_nop(&mut text, 0));
    }
}
