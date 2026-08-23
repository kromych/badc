//! Cortex-A53 erratum 843419 sequence detection and the encodings its
//! workaround writes. The conditions follow the erratum notice
//! (ARM-EPM-048406) as GNU ld and LLD implement them, with LLD's
//! classification masks: an ADRP at page offset 0xff8 or 0xffc writing
//! Rn; a load/store (single register, STP/STNP, ST1, exclusive, or
//! literal) that does not write Rn; optionally one non-branch
//! instruction; then a load/store from the register-unsigned-immediate
//! class based on Rn. Like both linkers, sequence 2 of the notice is
//! not scanned for.

use alloc::vec::Vec;

pub fn is_adrp(i: u32) -> bool {
    i & 0x9f00_0000 == 0x9000_0000
}

fn is_load_store_class(i: u32) -> bool {
    i & 0x0a00_0000 == 0x0800_0000
}

fn is_st1_multiple_opcode(i: u32) -> bool {
    matches!(i & 0xf000, 0x2000 | 0x6000 | 0x7000 | 0xa000)
}

fn is_st1_single_opcode(i: u32) -> bool {
    matches!(i & 0x0040_e000, 0 | 0x4000 | 0x8000)
}

fn is_st1_multiple(i: u32) -> bool {
    i & 0xbfff_0000 == 0x0c00_0000 && is_st1_multiple_opcode(i)
}

fn is_st1_multiple_post(i: u32) -> bool {
    i & 0xbfe0_0000 == 0x0c80_0000 && is_st1_multiple_opcode(i)
}

fn is_st1_single(i: u32) -> bool {
    i & 0xbfff_0000 == 0x0d00_0000 && is_st1_single_opcode(i)
}

fn is_st1_single_post(i: u32) -> bool {
    i & 0xbfe0_0000 == 0x0d80_0000 && is_st1_single_opcode(i)
}

fn is_st1(i: u32) -> bool {
    is_st1_multiple(i) || is_st1_multiple_post(i) || is_st1_single(i) || is_st1_single_post(i)
}

fn is_load_store_exclusive(i: u32) -> bool {
    i & 0x3f00_0000 == 0x0800_0000
}

fn is_load_exclusive(i: u32) -> bool {
    i & 0x3f40_0000 == 0x0840_0000
}

fn is_load_literal(i: u32) -> bool {
    i & 0x3b00_0000 == 0x1800_0000
}

/// STNP and the three STP addressing forms; the L bit in the mask
/// keeps the load pairs out.
fn is_stnp(i: u32) -> bool {
    i & 0x3bc0_0000 == 0x2800_0000
}

fn is_stp_post(i: u32) -> bool {
    i & 0x3bc0_0000 == 0x2880_0000
}

fn is_stp_offset(i: u32) -> bool {
    i & 0x3bc0_0000 == 0x2900_0000
}

fn is_stp_pre(i: u32) -> bool {
    i & 0x3bc0_0000 == 0x2980_0000
}

fn is_stp(i: u32) -> bool {
    is_stp_post(i) || is_stp_offset(i) || is_stp_pre(i)
}

fn is_ls_unscaled(i: u32) -> bool {
    i & 0x3b00_0c00 == 0x3800_0000
}

fn is_ls_imm_post(i: u32) -> bool {
    i & 0x3b20_0c00 == 0x3800_0400
}

fn is_ls_unpriv(i: u32) -> bool {
    i & 0x3b20_0c00 == 0x3800_0800
}

fn is_ls_imm_pre(i: u32) -> bool {
    i & 0x3b20_0c00 == 0x3800_0c00
}

fn is_ls_register_off(i: u32) -> bool {
    i & 0x3b20_0c00 == 0x3820_0800
}

fn is_ls_unsigned(i: u32) -> bool {
    i & 0x3b00_0000 == 0x3900_0000
}

pub fn rt_field(i: u32) -> u32 {
    i & 0x1f
}

pub fn rn_field(i: u32) -> u32 {
    (i >> 5) & 0x1f
}

fn is_branch(i: u32) -> bool {
    i & 0xfe00_0000 == 0xd600_0000       // register branches
        || i & 0xfe00_0000 == 0x5400_0000 // conditional branch
        || i & 0x7c00_0000 == 0x1400_0000 // B / BL
        || i & 0x7c00_0000 == 0x3400_0000 // compare/test and branch
}

fn is_single_register_ls(i: u32) -> bool {
    is_ls_unscaled(i)
        || is_ls_imm_post(i)
        || is_ls_unpriv(i)
        || is_ls_imm_pre(i)
        || is_ls_register_off(i)
        || is_ls_unsigned(i)
}

/// v8.0 loads that write their Rt: exclusives, literals, and the
/// single-register forms whose size/V/opc select a load (STR of a Q
/// register and PRFM carry opc 2 without loading).
fn is_v8_load(i: u32) -> bool {
    if is_load_exclusive(i) || is_load_literal(i) {
        return true;
    }
    if is_single_register_ls(i) {
        let size = (i >> 30) & 0x3;
        let v = (i >> 26) & 1;
        let opc = (i >> 22) & 0x3;
        return opc != 0
            && !(size == 0 && v == 1 && opc == 2)
            && !(size == 3 && v == 0 && opc == 2);
    }
    false
}

fn has_writeback(i: u32) -> bool {
    is_ls_imm_pre(i)
        || is_ls_imm_post(i)
        || is_stp_pre(i)
        || is_stp_post(i)
        || is_st1_single_post(i)
        || is_st1_multiple_post(i)
}

fn writes_reg(i: u32, r: u32) -> bool {
    (is_v8_load(i) && rt_field(i) == r) || (has_writeback(i) && rn_field(i) == r)
}

/// The three-instruction body of the sequence: the ADRP, the first
/// load/store, and the dependent load/store (the optional intervening
/// instruction is the caller's concern).
pub fn is_sequence(i1: u32, i2: u32, i4: u32) -> bool {
    if !is_adrp(i1) {
        return false;
    }
    let rn = rt_field(i1);
    is_load_store_class(i2)
        && (is_load_store_exclusive(i2)
            || is_load_literal(i2)
            || is_single_register_ls(i2)
            || is_stp(i2)
            || is_stnp(i2)
            || is_st1(i2))
        && !writes_reg(i2, rn)
        && is_ls_unsigned(i4)
        && rn_field(i4) == rn
}

/// One detected occurrence; offsets are relative to the scanned bytes.
/// `ldst_off` is the dependent load/store the workaround branches
/// through a veneer, at `adrp_off + 8` or `adrp_off + 12`.
#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Site {
    pub adrp_off: u64,
    pub ldst_off: u64,
}

/// Scan one code region placed at `addr`, bounding every sequence by
/// the region as ld and LLD bound theirs by the input section.
pub fn scan(bytes: &[u8], addr: u64) -> Vec<Site> {
    let mut sites = Vec::new();
    if !addr.is_multiple_of(4) {
        return sites;
    }
    let len = bytes.len() as u64;
    let word = |o: u64| {
        let o = o as usize;
        u32::from_le_bytes([bytes[o], bytes[o + 1], bytes[o + 2], bytes[o + 3]])
    };
    let mut off = 0xff8_u64.saturating_sub(addr & 0xfff);
    while off + 12 <= len {
        let i1 = word(off);
        let i2 = word(off + 4);
        let i3 = word(off + 8);
        if is_sequence(i1, i2, i3) {
            sites.push(Site {
                adrp_off: off,
                ldst_off: off + 8,
            });
        } else if off + 16 <= len && !is_branch(i3) && is_sequence(i1, i2, word(off + 12)) {
            sites.push(Site {
                adrp_off: off,
                ldst_off: off + 12,
            });
        }
        off += if (addr + off) & 0xfff == 0xff8 {
            4
        } else {
            0xffc
        };
    }
    sites
}

/// Byte distance from the ADRP's own page to the page it materializes:
/// the signed 21-bit immediate scaled by the page size.
pub fn adrp_page_delta(i: u32) -> i64 {
    let imm21 = (((i >> 5) & 0x7ffff) << 2) | ((i >> 29) & 0x3);
    (((imm21 as i64) << 43) >> 43) << 12
}

pub const ADR_MIN: i64 = -(1 << 20);
pub const ADR_MAX: i64 = (1 << 20) - 1;

/// ADR reaching `imm` bytes from its own address, into register `rd`.
pub fn encode_adr(rd: u32, imm: i64) -> u32 {
    let imm = imm as u32 & 0x1f_ffff;
    0x1000_0000 | ((imm & 3) << 29) | (((imm >> 2) & 0x7ffff) << 5) | (rd & 0x1f)
}

#[cfg(test)]
mod tests {
    use super::*;
    use alloc::vec::Vec;

    const ADRP_X0: u32 = 0x9000_0000;
    const LDR_X1_X2: u32 = 0xf940_0041;
    const LDR_X3_X0_8: u32 = 0xf940_0403;
    const STR_X3_X0: u32 = 0xf900_0003;
    const NOP: u32 = 0xd503_201f;
    const RET: u32 = 0xd65f_03c0;

    fn bytes(insns: &[u32]) -> Vec<u8> {
        insns.iter().flat_map(|w| w.to_le_bytes()).collect()
    }

    #[test]
    fn matcher_accepts_the_notice_forms() {
        // Immediate sequel, load and store, and one intervening
        // non-branch instruction.
        assert!(is_sequence(ADRP_X0, LDR_X1_X2, LDR_X3_X0_8));
        assert!(is_sequence(ADRP_X0, LDR_X1_X2, STR_X3_X0));
        // STP and STNP qualify as the first load/store; LDP does not.
        assert!(is_sequence(ADRP_X0, 0xa900_0861, LDR_X3_X0_8)); // stp x1,x2,[x3]
        assert!(is_sequence(ADRP_X0, 0x2800_0861, LDR_X3_X0_8)); // stnp w1,w2,[x3]
        assert!(!is_sequence(ADRP_X0, 0xa940_0861, LDR_X3_X0_8)); // ldp x1,x2,[x3]
        // A vector store and a prefetch do not write their Rt.
        assert!(is_sequence(ADRP_X0, 0x3d80_0020, LDR_X3_X0_8)); // str q0,[x1]
        assert!(is_sequence(ADRP_X0, 0xf980_0040, LDR_X3_X0_8)); // prfm pldl1keep,[x2]
    }

    #[test]
    fn matcher_rejects_the_excluded_forms() {
        // The first load/store must not write Rn: load into x0, or
        // writeback with base x0.
        assert!(!is_sequence(ADRP_X0, 0xf940_0040, LDR_X3_X0_8)); // ldr x0,[x2]
        assert!(!is_sequence(ADRP_X0, 0xf800_8c01, LDR_X3_X0_8)); // str x1,[x0,#8]!
        assert!(is_sequence(ADRP_X0, 0xf800_8c41, LDR_X3_X0_8)); // str x1,[x2,#8]!
        // The dependent access must be register-unsigned-immediate
        // based on Rn.
        assert!(!is_sequence(ADRP_X0, LDR_X1_X2, 0xf940_0443)); // ldr x3,[x2,#8]
        assert!(!is_sequence(ADRP_X0, LDR_X1_X2, 0xf840_8403)); // ldr x3,[x0],#8
        // Position 2 must be a load or store.
        assert!(!is_sequence(ADRP_X0, 0x9100_04a5, LDR_X3_X0_8)); // add x5,x5,#1
        assert!(!is_sequence(NOP, LDR_X1_X2, LDR_X3_X0_8));
    }

    #[test]
    fn scan_honours_page_offsets_and_the_intervening_slot() {
        let seq = [ADRP_X0, LDR_X1_X2, LDR_X3_X0_8, RET];
        // At 0xff8 and 0xffc the sequence matches; off the boundary it
        // does not.
        assert_eq!(
            scan(&bytes(&seq), 0xff8),
            alloc::vec![Site {
                adrp_off: 0,
                ldst_off: 8
            }]
        );
        assert_eq!(
            scan(&bytes(&seq), 0xffc),
            alloc::vec![Site {
                adrp_off: 0,
                ldst_off: 8
            }]
        );
        assert!(scan(&bytes(&seq), 0xff4).is_empty());
        // One intervening instruction is tolerated unless it branches.
        let gap = [ADRP_X0, LDR_X1_X2, NOP, LDR_X3_X0_8];
        assert_eq!(
            scan(&bytes(&gap), 0xff8),
            alloc::vec![Site {
                adrp_off: 0,
                ldst_off: 12
            }]
        );
        let branch = [ADRP_X0, LDR_X1_X2, 0x1400_0001, LDR_X3_X0_8];
        assert!(scan(&bytes(&branch), 0xff8).is_empty());
        // The sequence must fit inside the scanned region.
        assert!(scan(&bytes(&seq[..2]), 0xff8).is_empty());
    }

    #[test]
    fn adr_encoding_round_trips_the_page_delta() {
        // adrp x0, +2 pages: immlo = 2, immhi = 0.
        let adrp = ADRP_X0 | (2 << 29);
        assert_eq!(adrp_page_delta(adrp), 0x2000);
        // adrp x0, -1 page.
        let neg = ADRP_X0 | (0x7ffff << 5) | (3 << 29);
        assert_eq!(adrp_page_delta(neg), -0x1000);
        assert_eq!(encode_adr(0, 8), 0x1000_0040);
        assert_eq!(encode_adr(3, -4), 0x10ff_ffe3);
    }
}
