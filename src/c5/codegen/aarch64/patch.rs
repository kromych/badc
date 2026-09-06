//! Page-relative relocation patching.
//!
//! Every consumer that resolves an AArch64 page-relative address
//! materialisation -- the three image writers, the linker, and the JIT --
//! rewrites the same two fields: an `adrp` carrying the signed page delta
//! and a second instruction carrying the in-page offset. The field
//! layouts come from [`super::encode`], which is byte-verified against a
//! reference assembler, so a fix there reaches every consumer.
//!
//! The two fields are relocated independently: the ABI lets one `adrp`
//! serve any number of in-page references, and lets an in-page reference
//! precede its `adrp`. [`AddrPart`] selects which fields a call covers,
//! so a caller holding one relocation patches one site.
//!
//! Two kinds of reference, and a consumer must pick the one matching its
//! site. [`patch_addr`] materialises an address and keeps the in-page
//! instruction's form. [`patch_slot`] resolves a reference that reaches
//! its target through a GOT / IAT slot the loader fills, so the in-page
//! instruction becomes a load whatever form the input carried.

use super::encode::{Reg, enc_adrp, enc_ldr_imm, enc_ldr32_imm};
use alloc::format;
use alloc::string::String;

/// Which fields of a page-relative reference a fixup record covers.
///
/// A record built from one relocation covers one field. badc's own
/// codegen emits the two halves as one adjacent pair and records
/// [`AddrPart::Whole`], which is also the only shape on x86_64, where a
/// reference is a single rip-relative displacement.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub(crate) enum AddrPart {
    /// The whole reference: an `adrp` at the site with its in-page half
    /// at `+4` on aarch64, the displacement field on x86_64.
    #[default]
    Whole,
    /// The `adrp` page half alone.
    Page,
    /// The in-page half alone.
    InPage,
}

/// Why a page-relative reference could not be patched.
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
    let imm12 = if is_add_imm(word) {
        in_page
    } else if is_ldst_unsigned(word) {
        let scale = 1u32 << ldst_scale_log2(word);
        if !in_page.is_multiple_of(scale) {
            return Err(PairError::Lo12Unscalable { in_page, scale });
        }
        in_page / scale
    } else {
        return Err(PairError::NotLo12(word));
    };
    Ok((word & !(0xFFF << 10)) | ((imm12 & 0xFFF) << 10))
}

/// `add rd, rn, #imm12` with no `lsl #12`.
fn is_add_imm(word: u32) -> bool {
    word & 0x7F80_0000 == 0x1100_0000
}

/// Load/store with an unsigned, size-scaled 12-bit immediate offset.
fn is_ldst_unsigned(word: u32) -> bool {
    word & 0x3B00_0000 == 0x3900_0000
}

/// log2 of the access size such a load/store scales its imm12 by.
/// `size` (bits 31..30) gives it for the general-register forms; the
/// SIMD/FP forms (V, bit 26) extend it with `opc<1>` (bit 23), which is
/// the only encoding of a 128-bit access.
fn ldst_scale_log2(word: u32) -> u32 {
    let size = word >> 30;
    if word & (1 << 26) != 0 {
        size | ((word >> 23) & 1) << 2
    } else {
        size
    }
}

/// Access width of a slot load: `ldr w` or `ldr x`.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum SlotWidth {
    W32,
    W64,
}

impl SlotWidth {
    fn bytes(self) -> u32 {
        match self {
            Self::W32 => 4,
            Self::W64 => 8,
        }
    }
}

/// In-page word of a slot reference rebuilt as a load of `in_page` bytes
/// past `rn`. The destination comes from the word being replaced, so the
/// following code still reads the register it expects.
fn slot_load_word(rn: Reg, word: u32, in_page: u32, width: SlotWidth) -> Result<u32, PairError> {
    if !is_add_imm(word) && !is_ldst_unsigned(word) {
        return Err(PairError::NotLo12(word));
    }
    let scale = width.bytes();
    if !in_page.is_multiple_of(scale) {
        return Err(PairError::Lo12Unscalable { in_page, scale });
    }
    let rt = Reg((word & 0x1F) as u8);
    Ok(match width {
        SlotWidth::W32 => enc_ldr32_imm(rt, rn, in_page),
        SlotWidth::W64 => enc_ldr_imm(rt, rn, in_page),
    })
}

/// Base register an in-page word already addresses through: `Rn` for
/// both the `add` immediate and the unsigned-offset load/store forms.
fn lo12_base_reg(word: u32) -> Reg {
    Reg(((word >> 5) & 0x1F) as u8)
}

/// The in-page word of a slot reference as a load of `width` bytes at
/// offset zero from its own base register, for an object whose
/// relocation fills the scaled immediate.
pub(crate) fn slot_load_form(word: u32, width: SlotWidth) -> Result<u32, PairError> {
    slot_load_word(lo12_base_reg(word), word, 0, width)
}

/// Whether `value` fits a checked field of `bits` bits, signed or unsigned.
pub(crate) fn movw_fits(value: i64, bits: u32, signed: bool) -> bool {
    if signed {
        let lim = 1i128 << (bits - 1);
        (-lim..lim).contains(&(value as i128))
    } else {
        (0..1i128 << bits).contains(&(value as i128))
    }
}

/// `movz` / `movk` word carrying group `group` of `value` in the 16-bit
/// immediate at bits 20:5. A signed group holding a negative value takes the
/// complement's group and turns `movz` into `movn` (opcode bit 30), which is
/// what sets the groups the sequence does not write; `movk` has no `movn`
/// form, so a signed group is only encodable on `movz`.
pub(crate) fn movw_word(word: u32, group: u8, signed: bool, value: i64) -> u32 {
    let negate = signed && value < 0;
    let src = if negate { !value } else { value };
    let imm = ((src as u64) >> (16 * group as u32)) & 0xffff;
    let word = (word & !(0xffff << 5)) | ((imm as u32) << 5);
    if negate { word & !(1 << 30) } else { word }
}

/// `movw_word` over a value that folded to a constant, under the range
/// check the specifier names. GNU as rejects such a value where it does
/// not fit rather than narrowing it, and names the sign in the message.
pub(crate) fn movw_const_word(
    word: u32,
    group: u8,
    signed: bool,
    check: Option<u32>,
    value: i64,
) -> Result<u32, String> {
    if let Some(bits) = check
        && !movw_fits(value, bits, signed)
    {
        return Err(format!(
            "{} value out of range",
            if signed { "signed" } else { "unsigned" }
        ));
    }
    Ok(movw_word(word, group, signed, value))
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

/// Patch the pair at `at` into a load of the value held at `slot_addr`.
/// A reference to an imported object reaches it through a slot the
/// loader fills, so the second instruction must end up a load however
/// the input spelled it -- an object referencing an extern data symbol
/// carries `adrp` + `add`, which materialises the slot's address rather
/// than reading it.
pub(crate) fn patch_slot_load(
    code: &mut [u8],
    at: usize,
    adrp_addr: i64,
    slot_addr: i64,
    width: SlotWidth,
) -> Result<(), PairError> {
    let (pages, in_page) = page_fields(adrp_addr, slot_addr)?;
    let adrp_raw = read_word(code, at);
    let first = adrp_word(adrp_raw, pages)?;
    let rn = Reg((adrp_raw & 0x1F) as u8);
    let second = slot_load_word(rn, read_word(code, at + 4), in_page, width)?;
    write_word(code, at, first);
    write_word(code, at + 4, second);
    Ok(())
}

/// Patch the in-page half of a slot reference on its own site. The base
/// register comes from the word itself, so a site that is not adjacent
/// to its `adrp` needs nothing from it.
pub(crate) fn patch_lo12_slot_load(
    code: &mut [u8],
    at: usize,
    slot_addr: i64,
    width: SlotWidth,
) -> Result<(), PairError> {
    let word = read_word(code, at);
    let patched = slot_load_word(lo12_base_reg(word), word, (slot_addr & 0xFFF) as u32, width)?;
    write_word(code, at, patched);
    Ok(())
}

/// Patch the fields `part` names at `at` so the reference computes
/// `target_addr`. `site_addr` is the runtime address of `at`; it is
/// unused for [`AddrPart::InPage`], whose field is page-independent.
pub(crate) fn patch_addr(
    code: &mut [u8],
    at: usize,
    site_addr: i64,
    target_addr: i64,
    part: AddrPart,
) -> Result<(), PairError> {
    match part {
        AddrPart::Whole => patch_pair(code, at, site_addr, target_addr),
        AddrPart::Page => patch_adrp(code, at, site_addr, target_addr),
        AddrPart::InPage => patch_lo12(code, at, target_addr),
    }
}

/// [`patch_addr`] for a reference reaching its target through
/// `slot_addr`: the in-page instruction ends up a load of `width` bytes.
pub(crate) fn patch_slot(
    code: &mut [u8],
    at: usize,
    site_addr: i64,
    slot_addr: i64,
    width: SlotWidth,
    part: AddrPart,
) -> Result<(), PairError> {
    match part {
        AddrPart::Whole => patch_slot_load(code, at, site_addr, slot_addr, width),
        AddrPart::Page => patch_adrp(code, at, site_addr, slot_addr),
        AddrPart::InPage => patch_lo12_slot_load(code, at, slot_addr, width),
    }
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
        let mut pair = [0u8; 8];
        assert_eq!(
            patch_slot_load(&mut pair, 0, 0, 0, SlotWidth::W64),
            Err(PairError::NotAdrp(0))
        );
    }

    /// A slot reference spelled `adrp` + `add` must come out as a load:
    /// the pair has to read the slot the loader filled, not compute the
    /// slot's own address. Keeping the `add` yields the address of the
    /// import table entry wherever an object's address was wanted.
    #[test]
    fn slot_load_turns_an_address_materialisation_into_a_load() {
        for rd in [0u8, 5, 16, 30] {
            let mut pair = Vec::new();
            pair.extend_from_slice(&enc_adrp(Reg(rd), 0).to_le_bytes());
            pair.extend_from_slice(&enc_add_imm(Reg(rd), Reg(rd), 0).to_le_bytes());
            patch_slot_load(&mut pair, 0, 0x1000, 0x5068, SlotWidth::W64).unwrap();
            assert_eq!(
                u32::from_le_bytes(pair[0..4].try_into().unwrap()),
                enc_adrp(Reg(rd), 4),
                "rd={rd}"
            );
            assert_eq!(
                u32::from_le_bytes(pair[4..8].try_into().unwrap()),
                enc_ldr_imm(Reg(rd), Reg(rd), 0x68),
                "rd={rd}"
            );
        }
    }

    /// A pair already spelled as a load is patched, not rejected, and a
    /// 4-byte slot takes the 32-bit form.
    #[test]
    fn slot_load_accepts_a_load_and_both_widths() {
        let mut pair = Vec::new();
        pair.extend_from_slice(&enc_adrp(Reg(16), 0).to_le_bytes());
        pair.extend_from_slice(&enc_ldr_imm(Reg(16), Reg(16), 0).to_le_bytes());
        patch_slot_load(&mut pair, 0, 0x2000, 0x9040, SlotWidth::W64).unwrap();
        assert_eq!(
            u32::from_le_bytes(pair[4..8].try_into().unwrap()),
            enc_ldr_imm(Reg(16), Reg(16), 0x40)
        );

        let mut pair32 = Vec::new();
        pair32.extend_from_slice(&enc_adrp(Reg(17), 0).to_le_bytes());
        pair32.extend_from_slice(&enc_add_imm(Reg(17), Reg(17), 0).to_le_bytes());
        patch_slot_load(&mut pair32, 0, 0x2000, 0x9044, SlotWidth::W32).unwrap();
        assert_eq!(
            u32::from_le_bytes(pair32[4..8].try_into().unwrap()),
            enc_ldr32_imm(Reg(17), Reg(17), 0x44)
        );
    }

    /// One `adrp` serving several in-page sites: patching each site on
    /// its own reaches every one, and reproduces byte for byte what
    /// patching the halves as adjacent pairs produces.
    #[test]
    fn split_parts_reproduce_the_pair_patch() {
        let (site, target) = (0x1000i64, 0x5abci64);
        let mut pair = Vec::new();
        pair.extend_from_slice(&enc_adrp(Reg(1), 0).to_le_bytes());
        pair.extend_from_slice(&enc_add_imm(Reg(2), Reg(1), 0).to_le_bytes());
        let mut split = pair.clone();
        patch_addr(&mut pair, 0, site, target, AddrPart::Whole).unwrap();
        patch_addr(&mut split, 0, site, target, AddrPart::Page).unwrap();
        patch_addr(&mut split, 4, site + 4, target, AddrPart::InPage).unwrap();
        assert_eq!(pair, split);
    }

    /// The in-page half of a slot reference resolves on its own site,
    /// taking the base register from the word rather than from an
    /// `adrp` that need not be adjacent.
    #[test]
    fn split_slot_in_page_keeps_its_own_base_register() {
        let mut code = Vec::new();
        code.extend_from_slice(&enc_add_imm(Reg(7), Reg(3), 0).to_le_bytes());
        patch_slot(&mut code, 0, 0, 0x9040, SlotWidth::W64, AddrPart::InPage).unwrap();
        assert_eq!(
            u32::from_le_bytes(code[0..4].try_into().unwrap()),
            enc_ldr_imm(Reg(7), Reg(3), 0x40)
        );
    }

    /// The `tramp_alias` sequence -- `movz :abs_g2_s:` then `movk`
    /// `:abs_g1_nc:` / `:abs_g0_nc:` over `x5` -- as GNU ld resolves it.
    /// Words taken from `ld --defsym` over each value; the negative ones
    /// come out `movn` over the complement, which is what sets the groups
    /// the sequence never writes.
    #[test]
    fn movw_sequence_matches_gnu_ld() {
        // The placeholder words GNU as leaves: the group's shift, zero imm.
        const G2S: u32 = 0xd2c0_0005;
        const G1NC: u32 = 0xf2a0_0005;
        const G0NC: u32 = 0xf280_0005;
        for (v, want) in [
            (0i64, [0xd2c0_0005u32, 0xf2a0_0005, 0xf280_0005]),
            (0x1234, [0xd2c0_0005, 0xf2a0_0005, 0xf282_4685]),
            (0xffff_ffff_ffff, [0xd2df_ffe5, 0xf2bf_ffe5, 0xf29f_ffe5]),
            (-0x1, [0x92c0_0005, 0xf2bf_ffe5, 0xf29f_ffe5]),
            (-0x1234, [0x92c0_0005, 0xf2bf_ffe5, 0xf29d_b985]),
            (-0x1_0000_0000_0000, [0x92df_ffe5, 0xf2a0_0005, 0xf280_0005]),
            (0x1234_5678_9abc, [0xd2c2_4685, 0xf2aa_cf05, 0xf293_5785]),
            (-0x1234_5678_9abc, [0x92c2_4685, 0xf2b5_30e5, 0xf28c_a885]),
        ] {
            assert_eq!(movw_word(G2S, 2, true, v), want[0], "g2_s of {v:#x}");
            assert_eq!(movw_word(G1NC, 1, false, v), want[1], "g1_nc of {v:#x}");
            assert_eq!(movw_word(G0NC, 0, false, v), want[2], "g0_nc of {v:#x}");
        }
    }

    /// Only a signed group converts `movz` to `movn`; a no-check unsigned
    /// group truncates a negative value in place and keeps the opcode.
    #[test]
    fn movw_movn_conversion_is_signed_only() {
        let movz = 0xd280_0005u32;
        assert_eq!(movw_word(movz, 0, false, -1), 0xd29f_ffe5);
        assert_eq!(movw_word(movz, 0, true, -1), 0x9280_0005);
        // `movk` keeps its opcode whatever the value, having no `movn`.
        let movk = 0xf280_0005u32;
        assert_eq!(movw_word(movk, 0, false, -1), 0xf29f_ffe5);
    }

    /// The ranges GNU ld admits: the ABI checks group `n` over
    /// `16 * (n + 1)` bits, and the signed forms over one bit more.
    /// Boundaries confirmed against `ld --defsym` in both directions.
    #[test]
    fn movw_link_ranges_match_gnu_ld() {
        // R_AARCH64_MOVW_SABS_G0: [-2^16, 2^16).
        assert!(movw_fits(0xffff, 17, true));
        assert!(!movw_fits(0x10000, 17, true));
        assert!(movw_fits(-0x10000, 17, true));
        assert!(!movw_fits(-0x10001, 17, true));
        // R_AARCH64_MOVW_SABS_G2: [-2^48, 2^48).
        assert!(movw_fits(0xffff_ffff_ffff, 49, true));
        assert!(!movw_fits(0x1_0000_0000_0000, 49, true));
        assert!(movw_fits(-0x1_0000_0000_0000, 49, true));
        assert!(!movw_fits(-0x1_0000_0000_0001, 49, true));
        // R_AARCH64_MOVW_UABS_G0: [0, 2^16). A negative value never fits.
        assert!(movw_fits(0xffff, 16, false));
        assert!(!movw_fits(0x10000, 16, false));
        assert!(!movw_fits(-1, 16, false));
        // The widest signed check must not overflow its own bound.
        assert!(movw_fits(i64::MAX, 64, true));
        assert!(movw_fits(i64::MIN, 64, true));
    }

    /// The narrower ranges GNU as admits when the expression folds at
    /// assembly: group `n` over `16 * (n + 1)` bits for both signs, which
    /// for a signed group is one bit tighter than the link's rule.
    #[test]
    fn movw_assembly_ranges_match_gnu_as() {
        assert!(movw_fits(0x7fff, 16, true));
        assert!(!movw_fits(0x8000, 16, true));
        assert!(movw_fits(-0x8000, 16, true));
        assert!(!movw_fits(-0x8001, 16, true));
        assert!(movw_fits(0x7fff_ffff_ffff, 48, true));
        assert!(!movw_fits(0x8000_0000_0000, 48, true));
    }

    /// A slot whose in-page offset does not divide by the access width
    /// has no scaled encoding.
    #[test]
    fn slot_load_rejects_an_unscalable_offset() {
        let mut pair = Vec::new();
        pair.extend_from_slice(&enc_adrp(Reg(0), 0).to_le_bytes());
        pair.extend_from_slice(&enc_add_imm(Reg(0), Reg(0), 0).to_le_bytes());
        assert_eq!(
            patch_slot_load(&mut pair, 0, 0, 0x14, SlotWidth::W64),
            Err(PairError::Lo12Unscalable {
                in_page: 0x14,
                scale: 8
            })
        );
    }
}
