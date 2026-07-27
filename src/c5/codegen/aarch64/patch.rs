//! `adrp`-pair relocation patching.
//!
//! Every consumer that resolves an AArch64 page-relative address
//! materialisation -- the three image writers, the linker, and the JIT --
//! rewrites the same two instructions: an `adrp` carrying the signed page
//! delta and a second instruction carrying the in-page offset. The field
//! layouts come from [`super::encode`], which is byte-verified against a
//! reference assembler, so a fix there reaches every consumer.

use super::encode::{Reg, enc_adrp};
use alloc::format;
use alloc::string::String;

/// Why an `adrp` pair could not be patched.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum PairError {
    /// The page delta does not fit `adrp`'s signed 21-bit page field,
    /// i.e. the target is more than +-4 GiB from the instruction.
    PageRange(i64),
    /// The first instruction is not an `adrp`.
    NotAdrp(u32),
    /// The in-page offset is not a multiple of the paired load/store's
    /// access size, so its scaled immediate cannot represent it.
    Lo12Unscalable { in_page: u32, scale: u32 },
    /// The second instruction is neither an `add` immediate nor an
    /// unsigned-offset load/store.
    NotLo12(u32),
}

impl PairError {
    /// Render with `label` naming the reference being patched.
    pub(crate) fn describe(self, label: &str) -> String {
        match self {
            Self::PageRange(d) => {
                format!("{label}: adrp page delta {d:#x} out of +-4 GiB range")
            }
            Self::NotAdrp(w) => format!("{label}: expected adrp, found {w:#010x}"),
            Self::Lo12Unscalable { in_page, scale } => format!(
                "{label}: low-12 offset {in_page:#x} not aligned to load/store size {scale}"
            ),
            Self::NotLo12(w) => {
                format!("{label}: adrp paired with an unrecognized instruction {w:#010x}")
            }
        }
    }
}

/// Signed page delta and in-page offset for an `adrp` at `adrp_addr`
/// materialising `target_addr`. Both addresses are in the same space
/// (runtime vmaddr, image RVA, or section-relative offset).
pub(crate) fn page_fields(adrp_addr: i64, target_addr: i64) -> Result<(i32, u32), PairError> {
    let delta = (target_addr & !0xFFF) - (adrp_addr & !0xFFF);
    let pages = delta >> 12;
    if !(-(1 << 20)..(1 << 20)).contains(&pages) {
        return Err(PairError::PageRange(delta));
    }
    Ok((pages as i32, (target_addr & 0xFFF) as u32))
}

/// `adrp` word carrying `pages`, keeping `word`'s destination register.
pub(crate) fn adrp_word(word: u32, pages: i32) -> Result<u32, PairError> {
    if word & 0x9F00_0000 != 0x9000_0000 {
        return Err(PairError::NotAdrp(word));
    }
    Ok(enc_adrp(Reg((word & 0x1F) as u8), pages))
}

/// Second word of an `adrp` pair carrying `in_page`. Accepts
/// `add rd, rn, #imm12` and the unsigned-offset load/store forms, whose
/// immediate is scaled by the access size. Only the immediate field is
/// rewritten, so operand width, shift, and opcode survive -- a foreign
/// object's 32-bit `add` keeps its width.
pub(crate) fn lo12_word(word: u32, in_page: u32) -> Result<u32, PairError> {
    let imm12 = if word & 0x7F80_0000 == 0x1100_0000 {
        in_page
    } else if word & 0x3B00_0000 == 0x3900_0000 {
        let scale = 1u32 << (word >> 30);
        if !in_page.is_multiple_of(scale) {
            return Err(PairError::Lo12Unscalable { in_page, scale });
        }
        in_page / scale
    } else {
        return Err(PairError::NotLo12(word));
    };
    Ok((word & !(0xFFF << 10)) | ((imm12 & 0xFFF) << 10))
}

fn read_word(code: &[u8], at: usize) -> u32 {
    u32::from_le_bytes([code[at], code[at + 1], code[at + 2], code[at + 3]])
}

fn write_word(code: &mut [u8], at: usize, word: u32) {
    code[at..at + 4].copy_from_slice(&word.to_le_bytes());
}

/// Patch the `adrp` at `at` so its page base reaches `target_addr`.
pub(crate) fn patch_adrp(
    code: &mut [u8],
    at: usize,
    adrp_addr: i64,
    target_addr: i64,
) -> Result<(), PairError> {
    let (pages, _) = page_fields(adrp_addr, target_addr)?;
    let word = adrp_word(read_word(code, at), pages)?;
    write_word(code, at, word);
    Ok(())
}

/// Patch the in-page half of an `adrp` pair at `at`.
pub(crate) fn patch_lo12(code: &mut [u8], at: usize, target_addr: i64) -> Result<(), PairError> {
    let word = lo12_word(read_word(code, at), (target_addr & 0xFFF) as u32)?;
    write_word(code, at, word);
    Ok(())
}

/// Patch both halves of the `adrp` pair starting at `at` so the pair
/// computes `target_addr`.
pub(crate) fn patch_pair(
    code: &mut [u8],
    at: usize,
    adrp_addr: i64,
    target_addr: i64,
) -> Result<(), PairError> {
    let (pages, in_page) = page_fields(adrp_addr, target_addr)?;
    let first = adrp_word(read_word(code, at), pages)?;
    let second = lo12_word(read_word(code, at + 4), in_page)?;
    write_word(code, at, first);
    write_word(code, at + 4, second);
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::super::encode::enc_add_imm;
    use super::*;

    /// The linker patched `adrp` by masking the immediate fields out of the
    /// instruction it found; the writers rebuilt the word through
    /// [`enc_adrp`]. Over every destination register and every encodable
    /// page delta the two agree bit for bit, so routing the linker through
    /// the shared encoder cannot change an image.
    #[test]
    fn adrp_field_patch_matches_shared_encoder() {
        for rd in 0u8..32 {
            for pages in -(1i32 << 20)..(1 << 20) {
                let placeholder = enc_adrp(Reg(rd), 0);
                let immlo = (pages as u32) & 0x3;
                let immhi = ((pages as u32) >> 2) & 0x7_FFFF;
                let masked = (placeholder & !0x60ff_ffe0) | (immlo << 29) | (immhi << 5);
                assert_eq!(
                    adrp_word(placeholder, pages).unwrap(),
                    masked,
                    "rd={rd} pages={pages}"
                );
            }
        }
    }

    /// Same comparison for the in-page half: the linker masked `imm12` in
    /// place, the writers rebuilt an `add` through [`enc_add_imm`]. They
    /// agree for every 12-bit offset and register pair, given the 64-bit
    /// unshifted `add` the codegen emits as the placeholder.
    #[test]
    fn add_lo12_field_patch_matches_shared_encoder() {
        for rd in 0u8..32 {
            for rn in [0u8, 1, 15, 16, 30, 31] {
                for in_page in 0u32..4096 {
                    let placeholder = enc_add_imm(Reg(rd), Reg(rn), 0);
                    let masked = (placeholder & !0x003f_fc00) | (in_page << 10);
                    assert_eq!(
                        lo12_word(placeholder, in_page).unwrap(),
                        masked,
                        "rd={rd} rn={rn} in_page={in_page}"
                    );
                    assert_eq!(
                        lo12_word(placeholder, in_page).unwrap(),
                        enc_add_imm(Reg(rd), Reg(rn), in_page),
                        "rebuild disagrees: rd={rd} rn={rn} in_page={in_page}"
                    );
                }
            }
        }
    }

    /// An `adrp` whose target sits past +-4 GiB has no encoding. The shared
    /// path reports it; the release build of `enc_adrp` alone would have
    /// truncated the delta silently.
    #[test]
    fn page_delta_past_4gib_is_rejected() {
        assert_eq!(page_fields(0, 1 << 32), Err(PairError::PageRange(1 << 32)));
        assert_eq!(
            page_fields((1 << 32) + 4096, 0),
            Err(PairError::PageRange(-(1 << 32) - 4096))
        );
        // The last encodable page in each direction still resolves: the
        // field is signed 21-bit, so [-2^20, 2^20 - 1].
        assert_eq!(page_fields(0, (1 << 32) - 4096).unwrap().0, (1 << 20) - 1);
        assert_eq!(page_fields(1 << 32, 0).unwrap().0, -(1 << 20));
    }

    /// A 32-bit `add` keeps its operand width: only `imm12` is rewritten.
    /// The rebuild-from-scratch form the writers used would have widened it.
    #[test]
    fn lo12_preserves_operand_width() {
        let add32 = enc_add_imm(Reg(3), Reg(4), 0) & !(1 << 31);
        let patched = lo12_word(add32, 0xabc).unwrap();
        assert_eq!(patched >> 31, 0, "sf bit must survive");
        assert_eq!((patched >> 10) & 0xFFF, 0xabc);
    }

    /// A scaled load/store carries the offset divided by its access size.
    #[test]
    fn lo12_scales_load_store_immediate() {
        // `ldr x0, [x1, #imm]` -- size field 3, so the immediate is /8.
        let ldr64 = 0xF940_0020u32;
        assert_eq!((lo12_word(ldr64, 0x40).unwrap() >> 10) & 0xFFF, 0x40 / 8);
        assert_eq!(
            lo12_word(ldr64, 4),
            Err(PairError::Lo12Unscalable {
                in_page: 4,
                scale: 8
            })
        );
    }

    /// Neither half accepts an instruction of the wrong shape.
    #[test]
    fn wrong_shapes_are_refused() {
        assert_eq!(adrp_word(0, 0), Err(PairError::NotAdrp(0)));
        assert_eq!(lo12_word(0, 0), Err(PairError::NotLo12(0)));
    }
}
