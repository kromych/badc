//! x86-64 GOT references to a symbol the link defines (psABI B.2): the
//! forms GNU ld relaxes reach the symbol directly, and any other
//! instruction reads a slot the link allocates for it.

use crate::c5::object::elf_reloc_types::{
    R_X86_64_GOTPCREL, R_X86_64_GOTPCRELX, R_X86_64_REX_GOTPCRELX,
};

/// A relocation whose disp32 addresses the symbol's GOT slot.
pub(crate) const fn is_x86_64_got_pcrel(rtype: u32) -> bool {
    matches!(
        rtype,
        R_X86_64_GOTPCREL | R_X86_64_GOTPCRELX | R_X86_64_REX_GOTPCRELX
    )
}

/// What the instruction around a GOT reference's disp32 does with the
/// slot, read from its opcode and ModRM bytes.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(crate) enum GotUse {
    /// `mov reg, [rip + disp32]`, REX-prefixed or not; becomes `lea`.
    Load,
    /// `call [rip + disp32]`; becomes `addr32 call rel32`.
    Call,
    /// `jmp [rip + disp32]`; becomes `jmp rel32; nop`.
    Jump,
    /// The slot is an operand of any other instruction.
    Operand,
}

/// Classify the instruction whose disp32 sits at `field`. Only
/// GOTPCRELX marks a branch as relaxable, and plain GOTPCREL a load only.
pub(crate) fn got_use(text: &[u8], field: usize, rtype: u32) -> GotUse {
    let (Some(&op), Some(&modrm)) = (
        field.checked_sub(2).and_then(|i| text.get(i)),
        field.checked_sub(1).and_then(|i| text.get(i)),
    ) else {
        return GotUse::Operand;
    };
    if modrm & 0xC7 != 0x05 || field + 4 > text.len() {
        return GotUse::Operand;
    }
    match (op, modrm) {
        (0x8B, _) => GotUse::Load,
        (0xFF, 0x15) if rtype == R_X86_64_GOTPCRELX => GotUse::Call,
        (0xFF, 0x25) if rtype == R_X86_64_GOTPCRELX => GotUse::Jump,
        _ => GotUse::Operand,
    }
}

/// Rewrite a relaxable instruction to reach the symbol directly and
/// return where its PC32 field now sits. `jmp rel32` is one byte shorter
/// than the indirect form, so its field moves back by one and a `nop`
/// follows it, as GNU ld places them.
pub(crate) fn relax(text: &mut [u8], field: usize, how: GotUse) -> Option<usize> {
    match how {
        GotUse::Load => {
            text[field - 2] = 0x8D;
            Some(field)
        }
        GotUse::Call => {
            text[field - 2] = 0x67;
            text[field - 1] = 0xE8;
            Some(field)
        }
        GotUse::Jump => {
            text[field - 2] = 0xE9;
            text[field + 3] = 0x90;
            Some(field - 1)
        }
        GotUse::Operand => None,
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use alloc::vec;

    #[test]
    fn relaxable_forms_are_read_from_the_opcode_and_modrm() {
        let call = [0xFF, 0x15, 0, 0, 0, 0];
        let jmp = [0xFF, 0x25, 0, 0, 0, 0];
        let mov = [0x48, 0x8B, 0x0D, 0, 0, 0, 0];
        let mov32 = [0x8B, 0x05, 0, 0, 0, 0];
        let cmp = [0x48, 0x3B, 0x05, 0, 0, 0, 0];
        let push = [0xFF, 0x35, 0, 0, 0, 0];
        assert_eq!(got_use(&call, 2, R_X86_64_GOTPCRELX), GotUse::Call);
        assert_eq!(got_use(&jmp, 2, R_X86_64_GOTPCRELX), GotUse::Jump);
        assert_eq!(got_use(&mov, 3, R_X86_64_REX_GOTPCRELX), GotUse::Load);
        assert_eq!(got_use(&mov, 3, R_X86_64_GOTPCREL), GotUse::Load);
        assert_eq!(got_use(&mov32, 2, R_X86_64_GOTPCRELX), GotUse::Load);
        assert_eq!(got_use(&cmp, 3, R_X86_64_REX_GOTPCRELX), GotUse::Operand);
        assert_eq!(got_use(&push, 2, R_X86_64_GOTPCRELX), GotUse::Operand);
        // Only GOTPCRELX declares a branch relaxable.
        assert_eq!(got_use(&call, 2, R_X86_64_GOTPCREL), GotUse::Operand);
        assert_eq!(got_use(&jmp, 2, R_X86_64_REX_GOTPCRELX), GotUse::Operand);
        // A disp32 that is not RIP-relative addressing, or runs past the text.
        assert_eq!(
            got_use(&[0x48, 0x8B, 0x04, 0, 0, 0, 0], 3, R_X86_64_GOTPCRELX),
            GotUse::Operand
        );
        assert_eq!(got_use(&call[..5], 2, R_X86_64_GOTPCRELX), GotUse::Operand);
        assert_eq!(got_use(&call, 1, R_X86_64_GOTPCRELX), GotUse::Operand);
    }

    #[test]
    fn relaxation_matches_gnu_ld() {
        let mut call = vec![0xFF, 0x15, 1, 2, 3, 4];
        assert_eq!(relax(&mut call, 2, GotUse::Call), Some(2));
        assert_eq!(call, [0x67, 0xE8, 1, 2, 3, 4]);
        let mut jmp = vec![0xFF, 0x25, 1, 2, 3, 4];
        assert_eq!(relax(&mut jmp, 2, GotUse::Jump), Some(1));
        assert_eq!(&jmp[..1], [0xE9]);
        assert_eq!(jmp[5], 0x90);
        let mut mov = vec![0x4C, 0x8B, 0x05, 1, 2, 3, 4];
        assert_eq!(relax(&mut mov, 3, GotUse::Load), Some(3));
        assert_eq!(mov, [0x4C, 0x8D, 0x05, 1, 2, 3, 4]);
        let mut cmp = vec![0x48, 0x3B, 0x05, 1, 2, 3, 4];
        assert_eq!(relax(&mut cmp, 3, GotUse::Operand), None);
        assert_eq!(cmp, [0x48, 0x3B, 0x05, 1, 2, 3, 4]);
    }
}
