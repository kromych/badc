//! Tests for the table-driven AArch64 encoder.
//!
//! Golden cases run everywhere and lock exact words, including the
//! logical-immediate encoder and the rows the design spike found miscoded in
//! the source database. The differential sweep cross-checks the catalogue
//! against the native assembler; it is gated on `BADC_FUZZ_ASM=1` plus `clang`
//! and `objdump`, so a bare `cargo test` skips it.

use super::*;

fn x(n: u8) -> Opnd {
    Opnd::Reg { num: n, is64: true }
}
fn w(n: u8) -> Opnd {
    Opnd::Reg {
        num: n,
        is64: false,
    }
}
fn m(base: u8) -> Opnd {
    Opnd::Mem {
        base,
        off: 0,
        pre: false,
    }
}
fn enc(mnem: &str, ops: &[Opnd]) -> u32 {
    encode(mnem, ops).unwrap_or_else(|e| panic!("{mnem}: {e}"))
}

#[test]
fn reg3_data_processing() {
    assert_eq!(enc("add", &[x(0), x(1), x(2)]), 0x8B020020); // add x0, x1, x2
    assert_eq!(enc("add", &[w(0), w(1), w(2)]), 0x0B020020); // add w0, w1, w2
    assert_eq!(enc("sub", &[x(3), x(4), x(5)]), 0xCB050083); // sub x3, x4, x5
    assert_eq!(enc("orr", &[x(0), x(1), x(2)]), 0xAA020020); // orr x0, x1, x2
    assert_eq!(enc("and", &[x(9), x(10), x(11)]), 0x8A0B0149); // and x9, x10, x11
    assert_eq!(enc("subs", &[x(0), x(1), x(2)]), 0xEB020020); // subs x0, x1, x2
}

#[test]
fn add_sub_immediate() {
    assert_eq!(enc("add", &[x(0), x(1), Opnd::Imm(1)]), 0x91000420); // add x0, x1, #1
    assert_eq!(enc("add", &[x(0), x(1), Opnd::Imm(0xFFF)]), 0x913FFC20);
    assert_eq!(enc("sub", &[w(2), w(3), Opnd::Imm(4)]), 0x51001062); // sub w2, w3, #4
}

#[test]
fn move_wide() {
    assert_eq!(enc("movz", &[x(0), Opnd::Imm(0x1234)]), 0xD2824680); // movz x0, #0x1234
    assert_eq!(
        enc("movz", &[x(3), Opnd::Imm(0x1234), Opnd::Lsl(16)]),
        0xD2A24683
    ); // movz x3, #0x1234, lsl #16
    assert_eq!(enc("movk", &[x(0), Opnd::Imm(0xABCD)]), 0xF29579A0);
    assert_eq!(enc("movz", &[w(1), Opnd::Imm(0xFF)]), 0x52801FE1);
}

#[test]
fn load_store_immediate() {
    // ldr/str Xt, [Xn, #off]: the offset is scaled by the access size (8).
    assert_eq!(
        enc(
            "ldr",
            &[
                x(0),
                Opnd::Mem {
                    base: 1,
                    off: 0,
                    pre: false
                }
            ]
        ),
        0xF9400020
    );
    assert_eq!(
        enc(
            "ldr",
            &[
                x(0),
                Opnd::Mem {
                    base: 1,
                    off: 8,
                    pre: false
                }
            ]
        ),
        0xF9400420
    );
    assert_eq!(
        enc(
            "str",
            &[
                x(0),
                Opnd::Mem {
                    base: 1,
                    off: 0,
                    pre: false
                }
            ]
        ),
        0xF9000020
    );
    // 32-bit access uses the W-register form (scaled by 4).
    assert_eq!(
        enc(
            "ldr",
            &[
                w(2),
                Opnd::Mem {
                    base: 3,
                    off: 4,
                    pre: false
                }
            ]
        ),
        0xB9400462
    );
    // Pre-index `[Xn, #off]!` and post-index `[Xn], #off` take an unscaled
    // signed byte offset (imm9), unlike the scaled offset form above.
    let pre = |base: u8, off: i64| Opnd::Mem {
        base,
        off,
        pre: true,
    };
    let off0 = |base: u8| Opnd::Mem {
        base,
        off: 0,
        pre: false,
    };
    assert_eq!(enc("ldr", &[x(0), pre(1, 16)]), 0xF8410C20);
    assert_eq!(enc("str", &[x(0), pre(1, -8)]), 0xF81F8C20);
    assert_eq!(enc("ldr", &[w(0), pre(1, 4)]), 0xB8404C20);
    assert_eq!(enc("ldr", &[x(0), off0(1), Opnd::Imm(16)]), 0xF8410420); // post
    assert!(encode("ldr", &[x(0), pre(1, 256)]).is_err()); // > imm9
}

#[test]
fn load_store_register_offset() {
    // ldr/str Xt, [Xn, Rm{, <ext> #s}]: option 3 = LSL/UXTX, 6 = SXTW, 2 = UXTW.
    // A shift selects the S bit only at the access-size log2 (3 for X, 2 for W).
    let mr = |index: u8, option: u8, shift: Option<u8>| Opnd::MemReg {
        base: 1,
        index,
        option,
        shift,
    };
    assert_eq!(enc("ldr", &[x(0), mr(2, 0b011, None)]), 0xF8626820);
    assert_eq!(enc("ldr", &[x(0), mr(2, 0b011, Some(3))]), 0xF8627820);
    assert_eq!(enc("str", &[x(0), mr(2, 0b011, None)]), 0xF8226820);
    assert_eq!(enc("str", &[x(0), mr(2, 0b011, Some(3))]), 0xF8227820);
    assert_eq!(enc("ldr", &[w(0), mr(2, 0b011, None)]), 0xB8626820);
    assert_eq!(enc("ldr", &[w(0), mr(2, 0b011, Some(2))]), 0xB8627820);
    assert_eq!(enc("ldr", &[x(0), mr(2, 0b110, None)]), 0xF862C820); // sxtw
    assert_eq!(enc("ldr", &[x(0), mr(2, 0b110, Some(3))]), 0xF862D820);
    assert_eq!(enc("ldr", &[x(0), mr(2, 0b010, None)]), 0xF8624820); // uxtw
    assert_eq!(enc("str", &[w(0), mr(2, 0b010, Some(2))]), 0xB8225820);
    // A shift that is neither zero nor the access-size log2 is rejected.
    assert!(encode("ldr", &[x(0), mr(2, 0b011, Some(2))]).is_err());
    // The subword sizes share the base word `0x38200800 | size<<30 | opc<<22`.
    assert_eq!(enc("ldrb", &[w(0), mr(2, 0b011, None)]), 0x38626820);
    assert_eq!(enc("strb", &[w(0), mr(2, 0b011, None)]), 0x38226820);
    assert_eq!(enc("ldrh", &[w(0), mr(2, 0b011, None)]), 0x78626820);
    assert_eq!(enc("ldrh", &[w(0), mr(2, 0b011, Some(1))]), 0x78627820);
    assert_eq!(enc("strh", &[w(0), mr(2, 0b011, None)]), 0x78226820);
    assert_eq!(enc("ldrsb", &[x(0), mr(2, 0b011, None)]), 0x38A26820);
    assert_eq!(enc("ldrsh", &[x(0), mr(2, 0b011, None)]), 0x78A26820);
    assert_eq!(enc("ldrsw", &[x(0), mr(2, 0b011, None)]), 0xB8A26820);
    assert_eq!(enc("ldrsw", &[x(0), mr(2, 0b011, Some(2))]), 0xB8A27820);
    // A byte access has no scaling shift (log2 zero): a #1 shift is rejected.
    assert!(encode("ldrb", &[w(0), mr(2, 0b011, Some(1))]).is_err());
}

#[test]
fn catalogue_load_rejects_pre_index_writeback() {
    // The catalogue carries only offset forms. A pre-index `[Xn, #off]!` operand
    // must not match one and silently drop the writeback (the subword loads have
    // no writeback form), so it is a clear error rather than a miscompile.
    let offset = |base: u8, off: i64| Opnd::Mem {
        base,
        off,
        pre: false,
    };
    let writeback = |base: u8, off: i64| Opnd::Mem {
        base,
        off,
        pre: true,
    };
    assert!(encode("ldrb", &[w(0), offset(1, 4)]).is_ok());
    assert!(encode("ldrb", &[w(0), writeback(1, 4)]).is_err());
    assert!(encode("ldrh", &[w(0), writeback(1, 4)]).is_err());
    assert!(encode("strh", &[w(0), writeback(1, 2)]).is_err());
}

#[test]
fn sys_op_dc_ic_tlbi() {
    // The base word carries op1/CRn/CRm/op2 with Rt empty; the encoder ORs in
    // the register operand, or xzr (31) when there is none. Words match clang.
    assert_eq!(enc("dc", &[Opnd::SysOp(0xD50B_7A20), x(0)]), 0xD50B_7A20); // dc cvac, x0
    assert_eq!(enc("dc", &[Opnd::SysOp(0xD50B_7A20)]), 0xD50B_7A3F); // dc cvac (xzr)
    assert_eq!(enc("tlbi", &[Opnd::SysOp(0xD508_8700)]), 0xD508_871F); // tlbi vmalle1
    assert_eq!(enc("tlbi", &[Opnd::SysOp(0xD508_8720), x(3)]), 0xD508_8723); // tlbi vae1, x3
    assert_eq!(enc("ic", &[Opnd::SysOp(0xD508_7100)]), 0xD508_711F); // ic ialluis
}

#[test]
fn conditional_compare() {
    // ccmp/ccmn Xn, Xm|#imm5, #nzcv, cond -- cond at bit 12, nzcv at bit 0.
    assert_eq!(
        enc("ccmp", &[x(0), x(1), Opnd::Imm(0), Opnd::Cond(0)]),
        0xFA41_0000
    ); // eq
    assert_eq!(
        enc("ccmp", &[x(0), Opnd::Imm(5), Opnd::Imm(2), Opnd::Cond(1)]),
        0xFA45_1802
    ); // #5, ne
    assert_eq!(
        enc("ccmn", &[x(0), x(1), Opnd::Imm(4), Opnd::Cond(10)]),
        0xBA41_A004
    ); // ge
    assert_eq!(
        enc("ccmp", &[w(0), w(1), Opnd::Imm(0), Opnd::Cond(0)]),
        0x7A41_0000
    ); // 32-bit
}

#[test]
fn bitfield_aliases() {
    // Xd, Xn, #lsb, #width. Extract keeps immr=lsb, imms=lsb+width-1; insert
    // sets immr=-lsb mod regsize, imms=width-1. Words match the assembler.
    let i = Opnd::Imm;
    assert_eq!(enc("ubfx", &[x(0), x(1), i(4), i(8)]), 0xD344_2C20);
    assert_eq!(enc("sbfx", &[x(0), x(1), i(4), i(8)]), 0x9344_2C20);
    assert_eq!(enc("bfxil", &[x(0), x(1), i(4), i(8)]), 0xB344_2C20);
    assert_eq!(enc("ubfiz", &[x(0), x(1), i(4), i(8)]), 0xD37C_1C20);
    assert_eq!(enc("sbfiz", &[x(0), x(1), i(4), i(8)]), 0x937C_1C20);
    assert_eq!(enc("bfi", &[x(0), x(1), i(4), i(8)]), 0xB37C_1C20);
    assert_eq!(enc("ubfx", &[w(0), w(1), i(4), i(8)]), 0x5304_2C20); // 32-bit
    // The base ubfm goes through the catalogue with raw immr/imms.
    assert_eq!(enc("ubfm", &[x(0), x(1), i(4), i(11)]), 0xD344_2C20);
    // A field running past the register width is rejected.
    assert!(encode("ubfx", &[w(0), w(1), i(28), i(8)]).is_err());
    assert!(encode("bfi", &[x(0), w(1), i(4), i(8)]).is_err()); // mixed widths
}

#[test]
fn prefetch() {
    // prfm <prfop>, [Xn{, #off | , Rm}]: the prfop code fills the Rt slot; the
    // immediate offset is scaled by 8, the register offset feeds Rm.
    let mem = |base: u8, off: i64| Opnd::Mem {
        base,
        off,
        pre: false,
    };
    assert_eq!(enc("prfm", &[Opnd::Imm(0), mem(1, 0)]), 0xF980_0020); // pldl1keep, [x1]
    assert_eq!(enc("prfm", &[Opnd::Imm(19), mem(1, 16)]), 0xF980_0833); // pstl2strm, #16
    let mr = Opnd::MemReg {
        base: 1,
        index: 2,
        option: 0b011,
        shift: None,
    };
    assert_eq!(enc("prfm", &[Opnd::Imm(2), mr]), 0xF8A2_6822); // pldl2keep, [x1, x2]
    // The immediate offset must be a multiple of the access size.
    assert!(encode("prfm", &[Opnd::Imm(0), mem(1, 4)]).is_err());
}

#[test]
fn fmov_gp_fp() {
    let d = |num: u8| Opnd::VReg { num, is_d: true };
    let s = |num: u8| Opnd::VReg { num, is_d: false };
    assert_eq!(enc("fmov", &[x(0), d(0)]), 0x9E66_0000); // Xd, Dn
    assert_eq!(enc("fmov", &[d(0), x(0)]), 0x9E67_0000); // Dd, Xn
    assert_eq!(enc("fmov", &[w(0), s(0)]), 0x1E26_0000); // Wd, Sn
    assert_eq!(enc("fmov", &[s(0), w(0)]), 0x1E27_0000); // Sd, Wn
    assert_eq!(enc("fmov", &[d(0), d(1)]), 0x1E60_4020); // Dd, Dn
    assert_eq!(enc("fmov", &[s(0), s(1)]), 0x1E20_4020); // Sd, Sn
    assert_eq!(enc("fmov", &[x(3), d(5)]), 0x9E66_00A3);
    // A width mismatch (X<->S or W<->D) has no encoding.
    assert!(encode("fmov", &[x(0), s(0)]).is_err());
    assert!(encode("fmov", &[d(0), w(0)]).is_err());
}

#[test]
fn fp_arithmetic() {
    let d = |num: u8| Opnd::VReg { num, is_d: true };
    let s = |num: u8| Opnd::VReg { num, is_d: false };
    // Two-source: type bit 22 selects double, opcode sits at bit 12.
    assert_eq!(enc("fmul", &[d(0), d(1), d(2)]), 0x1E62_0820);
    assert_eq!(enc("fdiv", &[d(0), d(1), d(2)]), 0x1E62_1820);
    assert_eq!(enc("fadd", &[d(0), d(1), d(2)]), 0x1E62_2820);
    assert_eq!(enc("fsub", &[d(0), d(1), d(2)]), 0x1E62_3820);
    assert_eq!(enc("fmax", &[d(0), d(1), d(2)]), 0x1E62_4820);
    assert_eq!(enc("fnmul", &[d(0), d(1), d(2)]), 0x1E62_8820);
    assert_eq!(enc("fadd", &[s(0), s(1), s(2)]), 0x1E22_2820); // single
    // One-source: single = double base less the type bit.
    assert_eq!(enc("fabs", &[d(0), d(1)]), 0x1E60_C020);
    assert_eq!(enc("fneg", &[d(0), d(1)]), 0x1E61_4020);
    assert_eq!(enc("fsqrt", &[d(0), d(1)]), 0x1E61_C020);
    assert_eq!(enc("fneg", &[s(0), s(1)]), 0x1E21_4020);
    // fcmp/fcmpe set the flags; the result field is the compare opcode: the
    // register form is zero, `#0.0` sets bit 3, and `fcmpe` adds bit 4.
    assert_eq!(enc("fcmp", &[d(1), d(2)]), 0x1E62_2020);
    assert_eq!(enc("fcmp", &[s(1), s(2)]), 0x1E22_2020);
    assert_eq!(enc("fcmp", &[d(1), Opnd::Imm(0)]), 0x1E60_2028); // fcmp d1, #0.0
    assert_eq!(enc("fcmp", &[s(1), Opnd::Imm(0)]), 0x1E20_2028);
    assert_eq!(enc("fcmpe", &[d(1), d(2)]), 0x1E62_2030);
    assert_eq!(enc("fcmpe", &[d(1), Opnd::Imm(0)]), 0x1E60_2038);
    // Mismatched widths and a GP operand have no encoding.
    assert!(encode("fadd", &[d(0), s(1), d(2)]).is_err());
    assert!(encode("fadd", &[d(0), d(1), x(2)]).is_err());
}

#[test]
fn fp_conversions() {
    let d = |num: u8| Opnd::VReg { num, is_d: true };
    let s = |num: u8| Opnd::VReg { num, is_d: false };
    // int -> fp: sf (int width) at bit 31, type (fp width) at bit 22.
    assert_eq!(enc("scvtf", &[d(0), x(1)]), 0x9E62_0020);
    assert_eq!(enc("scvtf", &[s(0), w(1)]), 0x1E22_0020);
    assert_eq!(enc("scvtf", &[d(0), w(1)]), 0x1E62_0020); // int32 -> double
    assert_eq!(enc("scvtf", &[s(0), x(1)]), 0x9E22_0020); // int64 -> single
    assert_eq!(enc("ucvtf", &[d(0), x(1)]), 0x9E63_0020);
    // fp -> int (toward zero).
    assert_eq!(enc("fcvtzs", &[x(0), d(1)]), 0x9E78_0020);
    assert_eq!(enc("fcvtzs", &[w(0), s(1)]), 0x1E38_0020);
    assert_eq!(enc("fcvtzs", &[w(0), d(1)]), 0x1E78_0020);
    assert_eq!(enc("fcvtzu", &[x(0), d(1)]), 0x9E79_0020);
    // fp size conversion.
    assert_eq!(enc("fcvt", &[s(0), d(1)]), 0x1E62_4020); // double -> single
    assert_eq!(enc("fcvt", &[d(0), s(1)]), 0x1E22_C020); // single -> double
    // fcvt needs different widths; a swapped register file has no encoding.
    assert!(encode("fcvt", &[d(0), d(1)]).is_err());
    assert!(encode("scvtf", &[x(0), d(1)]).is_err());
}

#[test]
fn fp_load_store() {
    let d = |num: u8| Opnd::VReg { num, is_d: true };
    let s = |num: u8| Opnd::VReg { num, is_d: false };
    let mem = |base: u8, off: i64| Opnd::Mem {
        base,
        off,
        pre: false,
    };
    // Immediate offset scaled by the access size (8 for d, 4 for s).
    assert_eq!(enc("ldr", &[d(0), mem(1, 0)]), 0xFD40_0020);
    assert_eq!(enc("ldr", &[d(0), mem(1, 16)]), 0xFD40_0820);
    assert_eq!(enc("str", &[d(0), mem(1, 8)]), 0xFD00_0420);
    assert_eq!(enc("ldr", &[s(0), mem(1, 0)]), 0xBD40_0020);
    assert_eq!(enc("str", &[s(0), mem(1, 4)]), 0xBD00_0420);
    // Register offset (option 3 = LSL, S selects the size scale).
    let mr = |shift| Opnd::MemReg {
        base: 1,
        index: 2,
        option: 0b011,
        shift,
    };
    assert_eq!(enc("ldr", &[d(0), mr(None)]), 0xFC62_6820);
    assert_eq!(enc("str", &[d(0), mr(Some(3))]), 0xFC22_7820);
    // A misaligned immediate offset is rejected.
    assert!(encode("ldr", &[d(0), mem(1, 4)]).is_err());
}

#[test]
fn load_store_pair() {
    let mem = |base: u8, off: i64| Opnd::Mem {
        base,
        off,
        pre: false,
    };
    // stp/ldp Xt1, Xt2, [Xn, #off]: signed offset scaled by the access size.
    assert_eq!(enc("stp", &[x(0), x(1), mem(2, 0)]), 0xA9000440);
    assert_eq!(enc("stp", &[x(0), x(1), mem(2, 16)]), 0xA9010440);
    assert_eq!(enc("ldp", &[x(0), x(1), mem(2, 16)]), 0xA9410440);
    assert_eq!(enc("stp", &[x(0), x(1), mem(2, -64)]), 0xA93C0440); // min imm7
    assert_eq!(enc("stp", &[w(0), w(1), mem(2, 8)]), 0x29010440); // W scaled by 4
    // Pre-index writeback `[Xn, #off]!` and post-index `[Xn], #off` (the offset
    // a trailing operand); both write the base back.
    let mem_pre = |base: u8, off: i64| Opnd::Mem {
        base,
        off,
        pre: true,
    };
    assert_eq!(enc("stp", &[x(0), x(1), mem_pre(31, -16)]), 0xA9BF07E0);
    assert_eq!(enc("stp", &[w(0), w(1), mem_pre(31, -8)]), 0x29BF07E0);
    assert_eq!(
        enc("ldp", &[x(0), x(1), mem(31, 0), Opnd::Imm(16)]),
        0xA8C107E0
    );
    // A mismatched width, an unaligned offset, and an out-of-range offset are
    // rejected rather than silently mis-encoded.
    assert!(encode("stp", &[x(0), w(1), mem(2, 0)]).is_err());
    assert!(encode("stp", &[x(0), x(1), mem(2, 4)]).is_err()); // not a multiple of 8
    assert!(encode("stp", &[x(0), x(1), mem(2, 512)]).is_err()); // imm7 overflow
}

#[test]
fn mov_alias() {
    // mov Rd, Rm is orr Rd, xzr, Rm; the width follows the destination.
    assert_eq!(enc("mov", &[x(0), x(1)]), 0xAA0103E0);
    assert_eq!(enc("mov", &[w(0), w(1)]), 0x2A0103E0);
    assert_eq!(enc("mov", &[x(0), x(31)]), 0xAA1F03E0); // mov x0, xzr
    // mov Rd, #imm is movz Rd, #imm for a 16-bit immediate.
    assert_eq!(enc("mov", &[x(0), Opnd::Imm(5)]), 0xD28000A0);
    assert_eq!(enc("mov", &[w(3), Opnd::Imm(42)]), 0x52800543);
    // A wider immediate needs an explicit movz/movk/movn.
    assert!(encode("mov", &[x(0), Opnd::Imm(0x10000)]).is_err());
    // (mov Rd, sp / mov sp, Rd are rewritten to add ..., #0 by the parser.)
}

#[test]
fn catalogue_is_sorted() {
    // encode() binary-searches the catalogue by mnemonic; the generator emits it
    // sorted. Lock the invariant.
    let forms = super::super::isa_a64_table::FORMS;
    assert!(
        forms.windows(2).all(|w| w[0].mnemonic <= w[1].mnemonic),
        "isa_a64_table::FORMS must be sorted by mnemonic"
    );
}

#[test]
fn multiply_and_conditional_select() {
    // mul = madd with the zero register as addend.
    assert_eq!(enc("mul", &[x(0), x(1), x(2)]), 0x9B027C20); // mul x0, x1, x2
    assert_eq!(enc("mul", &[w(0), w(1), w(2)]), 0x1B027C20); // mul w0, w1, w2
    // csel Xd, Xn, Xm, <cond>: the 4-bit condition sits at bit 12.
    assert_eq!(enc("csel", &[x(0), x(1), x(2), Opnd::Cond(1)]), 0x9A821020); // ne
    assert_eq!(enc("csel", &[x(3), x(4), x(5), Opnd::Cond(0)]), 0x9A850083); // eq
    assert_eq!(enc("csel", &[w(0), w(1), w(2), Opnd::Cond(12)]), 0x1A82C020); // gt
}

#[test]
fn conditional_select_family() {
    // csinc/csinv/csneg place the written condition directly at bit 12.
    assert_eq!(enc("csinc", &[x(0), x(1), x(2), Opnd::Cond(1)]), 0x9A821420); // csinc x0, x1, x2, ne
    assert_eq!(
        enc("csinc", &[w(1), w(2), w(3), Opnd::Cond(11)]),
        0x1A83B441
    ); // csinc w1, w2, w3, lt
    assert_eq!(
        enc("csinv", &[x(3), x(4), x(5), Opnd::Cond(11)]),
        0xDA85B083
    ); // csinv x3, x4, x5, lt
    assert_eq!(
        enc("csneg", &[x(3), x(4), x(5), Opnd::Cond(11)]),
        0xDA85B483
    ); // csneg x3, x4, x5, lt
    assert_eq!(
        enc("csneg", &[w(20), w(21), w(22), Opnd::Cond(10)]),
        0x5A96A6B4
    ); // csneg w20, w21, w22, ge
    // cset/csetm fold Rn = Rm = zr into the base and store the inverted
    // condition.
    assert_eq!(enc("cset", &[x(0), Opnd::Cond(11)]), 0x9A9FA7E0); // cset x0, lt
    assert_eq!(enc("cset", &[w(7), Opnd::Cond(1)]), 0x1A9F07E7); // cset w7, ne
    assert_eq!(enc("csetm", &[x(2), Opnd::Cond(12)]), 0xDA9FD3E2); // csetm x2, gt
    // al/nv have no inversion; the aliases reject them.
    assert!(encode("cset", &[x(0), Opnd::Cond(14)]).is_err());
    assert!(encode("csetm", &[w(0), Opnd::Cond(15)]).is_err());
}

#[test]
fn data_processing_registers() {
    // 2-source divide.
    assert_eq!(enc("udiv", &[x(0), x(1), x(2)]), 0x9AC20820); // udiv x0, x1, x2
    assert_eq!(enc("udiv", &[w(0), w(1), w(2)]), 0x1AC20820); // udiv w0, w1, w2
    assert_eq!(enc("sdiv", &[x(3), x(4), x(5)]), 0x9AC50C83); // sdiv x3, x4, x5
    // 3-source multiply with the addend fixed to the zero register.
    assert_eq!(enc("mneg", &[x(0), x(1), x(2)]), 0x9B02FC20); // mneg x0, x1, x2
    assert_eq!(enc("smulh", &[x(0), x(1), x(2)]), 0x9B427C20); // smulh x0, x1, x2
    assert_eq!(enc("umulh", &[x(0), x(1), x(2)]), 0x9BC27C20); // umulh x0, x1, x2
    // bit count / bit reverse.
    assert_eq!(enc("cls", &[x(0), x(1)]), 0xDAC01420); // cls x0, x1
    assert_eq!(enc("clz", &[x(0), x(1)]), 0xDAC01020); // clz x0, x1
    assert_eq!(enc("rbit", &[w(0), w(1)]), 0x5AC00020); // rbit w0, w1
    // 3-source multiply-accumulate: the addend Ra sits at bit 10.
    assert_eq!(enc("madd", &[x(0), x(1), x(2), x(3)]), 0x9B020C20); // madd x0, x1, x2, x3
    assert_eq!(enc("madd", &[w(0), w(1), w(2), w(3)]), 0x1B020C20); // madd w0, w1, w2, w3
    assert_eq!(enc("msub", &[x(3), x(4), x(5), x(6)]), 0x9B059883); // msub x3, x4, x5, x6
    // byte reverse: rev is 32-bit only, rev32 64-bit only, rev16 both.
    assert_eq!(enc("rev", &[w(0), w(1)]), 0x5AC00820); // rev w0, w1
    assert_eq!(enc("rev16", &[x(0), x(1)]), 0xDAC00420); // rev16 x0, x1
    assert_eq!(enc("rev32", &[x(0), x(1)]), 0xDAC00820); // rev32 x0, x1
}

#[test]
fn system_register_move() {
    // mrs Xt, <sysreg> = 0xD5300000 | field<<5 | Rt; msr <sysreg>, Xt =
    // 0xD5100000 | field<<5 | Rt. CTR_EL0 field 0x5801 is cross-checked against
    // the pattern-matched encoding 0xD53B0020.
    assert_eq!(enc("mrs", &[x(0), Opnd::SysReg(0x5801)]), 0xD53B0020);
    assert_eq!(enc("mrs", &[x(5), Opnd::SysReg(0x5801)]), 0xD53B0025);
    assert_eq!(enc("msr", &[Opnd::SysReg(0x5801), x(0)]), 0xD51B0020);
}

#[test]
fn shifts_by_immediate() {
    assert_eq!(enc("lsl", &[x(0), x(1), Opnd::Imm(4)]), 0xD37CEC20); // lsl x0, x1, #4
    assert_eq!(enc("lsr", &[x(0), x(1), Opnd::Imm(4)]), 0xD344FC20); // lsr x0, x1, #4
    assert_eq!(enc("asr", &[w(0), w(1), Opnd::Imm(3)]), 0x13037C20); // asr w0, w1, #3
}

#[test]
fn logical_immediate_encoder() {
    // The verified bitmask encoder: field is N<<12 | immr<<6 | imms.
    let field = |n: u32, immr: u32, imms: u32| (n << 12) | (immr << 6) | imms;
    assert_eq!(encode_logical_imm(0xFF, true), Some(field(1, 0, 7)));
    assert_eq!(
        encode_logical_imm(0xF0F0_F0F0_F0F0_F0F0, true),
        Some(field(0, 4, 0x33))
    );
    assert_eq!(encode_logical_imm(0x1, true), Some(field(1, 0, 0)));
    assert_eq!(
        encode_logical_imm(0xFFFF_FFFF_FFFF_FFF0, true),
        Some(field(1, 60, 0x3B))
    );
    // Not encodable: zero, all-ones, and (for W) a value with high bits set.
    assert_eq!(encode_logical_imm(0, true), None);
    assert_eq!(encode_logical_imm(u64::MAX, true), None);
    assert_eq!(encode_logical_imm(0x1_0000_0000, false), None);

    // Applied through `and`: `and x0, x1, #0xff`.
    assert_eq!(enc("and", &[x(0), x(1), Opnd::Imm(0xFF)]), 0x92401C20);
    assert_eq!(enc("orr", &[x(5), x(6), Opnd::Imm(0x1)]), 0xB24000C5); // orr x5, x6, #1
}

/// Differential sweeps found seven database rows disagreeing with the
/// architecture; the generator corrects them (DB_FIXES). Encoding the
/// corrected forms locks the true bits -- had the raw rows shipped, the bytes
/// would be wrong.
#[test]
fn corrected_database_rows_encode_true_bits() {
    // `sub` shares the arithmetic class; a straightforward reg3 word.
    assert_eq!(enc("sub", &[x(0), x(1), x(2)]), 0xCB020020);
    // subps: the shipped row lacked the S bit (carried subp's opcode).
    assert_eq!(enc("subps", &[x(0), x(1), x(2)]), 0xBAC20020);
    // crc32x/crc32cx: the shipped rows named W destinations X.
    assert_eq!(enc("crc32x", &[w(1), w(2), x(3)]), 0x9AC34C41);
    // (ret / cbz / dsb are in the follow-on system/branch surface; their
    // corrections are recorded in tools/gen_isa_a64.py DB_FIXES.)
}

/// The signature classifier catalogues every GP row the field model expresses;
/// lock one word per newly covered class (all verified against the assembler).
#[test]
fn classified_catalogue_growth() {
    assert_eq!(enc("adc", &[x(1), x(2), x(3)]), 0x9A030041); // carry arithmetic
    assert_eq!(enc("smull", &[x(1), w(2), w(3)]), 0x9B237C41); // mixed-width multiply
    assert_eq!(enc("umaddl", &[x(1), w(2), w(3), x(4)]), 0x9BA31041);
    assert_eq!(enc("extr", &[x(1), x(2), x(3), Opnd::Imm(5)]), 0x93C31441);
    assert_eq!(enc("ror", &[x(1), x(2), x(3)]), 0x9AC32C41); // rorv alias
    assert_eq!(enc("rev64", &[x(5), x(6)]), 0xDAC00CC5); // rev X spelling
    assert_eq!(enc("svc", &[Opnd::Imm(1)]), 0xD4000021); // exception class
    assert_eq!(enc("hint", &[Opnd::Imm(7)]), 0xD50320FF);
    assert_eq!(enc("nop", &[]), 0xD503201F); // zero-operand class
    // chkfeat's spelling is newer than the local assembler; the base equals
    // its architectural `hint #40` identity.
    assert_eq!(enc("chkfeat", &[]), 0xD503251F);
}

/// Base-register memory operands and positional register fields (Rs/Rt/Rt2/Rd2,
/// and Rd/Rn at written positions the fixed model rejected). One word per newly
/// covered class, all verified against the assembler.
#[test]
fn memory_and_positional_registers() {
    // Load-acquire / store-release: the data register feeds Rd/Rs at bit 0, the
    // base feeds Rn at bit 5. SP is base register 31.
    assert_eq!(enc("stlr", &[w(0), m(1)]), 0x889FFC20); // stlr w0, [x1]
    assert_eq!(enc("stlr", &[x(2), m(3)]), 0xC89FFC62);
    assert_eq!(enc("ldar", &[x(6), m(7)]), 0xC8DFFCE6);
    assert_eq!(enc("ldar", &[x(0), m(31)]), 0xC8DFFFE0); // ldar x0, [sp]
    // Compare-and-swap: Rs at bit 16, Rt at bit 0, base at bit 5. The word form
    // sets bit 23 (the corrected database row).
    assert_eq!(enc("cas", &[w(8), w(9), m(10)]), 0x88A87D49);
    assert_eq!(enc("cas", &[x(11), x(12), m(13)]), 0xC8AB7DAC);
    assert_eq!(enc("casb", &[w(8), w(9), m(10)]), 0x08A87D49); // byte form unchanged
    // Atomic memory ops share the Rs@16 / Rt@0 / base layout.
    assert_eq!(enc("swp", &[w(14), w(15), m(16)]), 0xB82E820F);
    assert_eq!(enc("ldadd", &[x(17), x(18), m(19)]), 0xF8310272);
    // Store-exclusive: the status register is Rd at bit 16 (not bit 0); the
    // stored value may be wider than the status register.
    assert_eq!(enc("stlxr", &[w(20), w(21), m(22)]), 0x8814FED5);
    assert_eq!(enc("stlxr", &[w(23), x(24), m(25)]), 0xC817FF38);
    // Load/store exclusive pair: Rd2/Rs2 at bit 10.
    assert_eq!(enc("ldaxp", &[x(0), x(1), m(2)]), 0xC87F8440);
    assert_eq!(enc("stxp", &[w(3), w(4), w(5), m(6)]), 0x882314C4);
    // Register at written index 0 mapping to Rn (no Rd operand): relaxing the
    // fixed slot order.
    assert_eq!(enc("blr", &[x(9)]), 0xD63F0120);
    assert_eq!(enc("cmn", &[x(5), x(6)]), 0xAB0600BF);
    assert_eq!(enc("cmn", &[w(7), Opnd::Imm(10)]), 0x310028FF);
    assert_eq!(enc("cmpp", &[x(3), x(4)]), 0xBAC4007F);
}

/// Memory operands carrying an immediate offset (the unscaled/unprivileged
/// signed imm9 and the byte unsigned imm12) and the standalone signed
/// immediate (`smax`/`smin` imm8). One word per class, all verified against
/// the assembler. The offset feeds a `SImm`/`UImm` field from the same memory
/// operand whose base feeds `Rn`.
#[test]
fn signed_and_offset_immediates() {
    let mem = |base: u8, off: i64| Opnd::Mem {
        base,
        off,
        pre: false,
    };
    // Unscaled/unprivileged signed imm9 (bit 12): sign-encoded two's complement.
    assert_eq!(enc("ldtr", &[w(0), mem(1, -4)]), 0xB85FC820); // ldtr w0, [x1, #-4]
    assert_eq!(enc("ldtr", &[x(2), mem(3, 255)]), 0xF84FF862); // max imm9
    assert_eq!(enc("sttr", &[w(4), mem(5, -256)]), 0xB81008A4); // min imm9
    assert_eq!(enc("ldur", &[x(6), mem(7, -1)]), 0xF85FF0E6);
    assert_eq!(enc("stur", &[w(8), mem(9, 0)]), 0xB8000128);
    assert_eq!(enc("ldtrsw", &[x(4), mem(5, -256)]), 0xB89008A4);
    // Sign-extending byte/halfword loads carry opc[23:22] inverted: the 32-bit
    // (Wd) variant is opc=11, the 64-bit (Xd) opc=10 (corrected from the db).
    assert_eq!(enc("ldtrsb", &[w(1), mem(2, -8)]), 0x38DF8841);
    assert_eq!(enc("ldtrsb", &[x(1), mem(2, -8)]), 0x389F8841);
    assert_eq!(enc("ldtrsh", &[w(1), mem(2, -8)]), 0x78DF8841);
    assert_eq!(enc("ldursb", &[x(1), mem(2, -8)]), 0x389F8041);
    assert_eq!(enc("ldapur", &[x(0), mem(1, -4)]), 0xD95FC020);
    assert_eq!(enc("stlur", &[w(2), mem(3, 5)]), 0x99005062);
    // Byte unsigned imm12 (bit 10, scale 1): a raw unsigned field.
    assert_eq!(enc("ldrb", &[w(0), mem(1, 5)]), 0x39401420);
    assert_eq!(enc("strb", &[w(2), mem(3, 4095)]), 0x393FFC62); // max imm12
    // Standalone signed imm8 (bit 10).
    assert_eq!(enc("smax", &[w(0), w(1), Opnd::Imm(-1)]), 0x11C3FC20);
    assert_eq!(enc("smax", &[x(2), x(3), Opnd::Imm(127)]), 0x91C1FC62);
    assert_eq!(enc("smin", &[w(4), w(5), Opnd::Imm(-128)]), 0x11CA00A4);
    // Range checks reject values the field cannot hold.
    assert!(encode("ldtr", &[w(0), mem(1, 256)]).is_err()); // > imm9 max
    assert!(encode("ldtr", &[w(0), mem(1, -257)]).is_err()); // < imm9 min
    assert!(encode("smax", &[w(0), w(1), Opnd::Imm(128)]).is_err()); // > imm8 max
}

#[cfg(feature = "std")]
mod differential {
    use super::super::super::isa_a64_table;
    use super::super::*;
    use alloc::string::String;
    use alloc::vec::Vec;
    use std::process::Command;

    fn enabled() -> bool {
        std::env::var("BADC_FUZZ_ASM").is_ok()
            && Command::new("clang").arg("--version").output().is_ok()
            && Command::new("objdump").arg("--version").output().is_ok()
    }

    fn hash(b: &[u8]) -> u64 {
        let mut h = 0xcbf29ce484222325u64;
        for &x in b {
            h = (h ^ x as u64).wrapping_mul(0x100000001b3);
        }
        h
    }

    /// Assembler invocations to try in order: the native target first, then a
    /// feature-maximal cross target for extension instructions (MTE, TME, CPA,
    /// GCS) the native default rejects.
    const ARGSETS: &[&[&str]] = &[
        &["--target=arm64-apple-darwin"],
        &[
            "--target=aarch64-linux-gnu",
            "-march=armv9.5a+memtag+tme+cpa+gcs",
        ],
    ];

    /// Assemble one A64 instruction and return its 32-bit word, or None if
    /// every argset rejects it.
    fn clang_word(itxt: &str) -> Option<u32> {
        ARGSETS.iter().find_map(|args| clang_word_with(itxt, args))
    }

    fn clang_word_with(itxt: &str, args: &[&str]) -> Option<u32> {
        let dir = std::env::temp_dir();
        let stem = alloc::format!("badc-a64-{:x}", hash(itxt.as_bytes()));
        let s = dir.join(alloc::format!("{stem}.s"));
        let o = dir.join(alloc::format!("{stem}.o"));
        std::fs::write(&s, alloc::format!(".text\n{itxt}\n")).ok()?;
        let out = Command::new("clang")
            .args(args)
            .arg("-c")
            .arg(&s)
            .arg("-o")
            .arg(&o)
            .output()
            .ok()?;
        if !out.status.success() {
            let _ = std::fs::remove_file(&s);
            return None;
        }
        let dis = Command::new("objdump").arg("-d").arg(&o).output().ok()?;
        let _ = std::fs::remove_file(&s);
        let _ = std::fs::remove_file(&o);
        let text = String::from_utf8_lossy(&dis.stdout);
        // "       0: 8b020020    \tadd\tx0, x1, x2"
        for line in text.lines() {
            if let Some(colon) = line.find(':') {
                let after = line[colon + 1..].trim_start();
                let hexword: String = after
                    .chars()
                    .take_while(|c| c.is_ascii_hexdigit())
                    .collect();
                if hexword.len() == 8
                    && line[..colon].trim().bytes().all(|b| b.is_ascii_hexdigit())
                    && !line[..colon].trim().is_empty()
                {
                    return u32::from_str_radix(&hexword, 16).ok();
                }
            }
        }
        None
    }

    fn xn(n: u8) -> Opnd {
        Opnd::Reg { num: n, is64: true }
    }

    fn cond_name(c: u8) -> &'static str {
        [
            "eq", "ne", "cs", "cc", "mi", "pl", "vs", "vc", "hi", "ls", "ge", "lt", "gt", "le",
            "al", "nv",
        ][c as usize & 15]
    }

    /// The field consuming the operand slot at `idx`.
    fn field_for(f: &Form, idx: usize) -> Option<Field> {
        f.fields.iter().copied().find(|fl| match *fl {
            Field::UImm { op, .. }
            | Field::SImm { op, .. }
            | Field::LogicalImm { op, .. }
            | Field::MovImm { op }
            | Field::MovHw { op }
            | Field::LslAlias { op, .. }
            | Field::ShrAlias { op }
            | Field::Cond { op, .. } => op as usize == idx,
            _ => false,
        })
    }

    /// A representative in-range offset for a memory slot that carries one
    /// (negative for the signed imm9 forms, positive for the byte unsigned
    /// form), or None for a base-only memory operand.
    fn mem_off(f: &Form, idx: usize) -> Option<i64> {
        f.fields.iter().find_map(|fl| match *fl {
            Field::SImm { op, .. } if op as usize == idx => Some(-8),
            Field::UImm { op, .. } if op as usize == idx => Some(8),
            _ => None,
        })
    }

    /// Candidates for a non-register slot, derived from its field kind:
    /// rendered text plus the operand, `None` for an omitted optional shift.
    fn slot_cands(f: &Form, idx: usize) -> Vec<Option<(String, Opnd)>> {
        let is64 = matches!(f.ops.first(), Some(A64Op::X));
        let imm = |v: i64| Some((alloc::format!("#{v}"), Opnd::Imm(v)));
        match field_for(f, idx) {
            Some(Field::UImm { width, .. }) => {
                let max = (1i64 << width) - 1;
                let mut vs = alloc::vec![1i64, 5, max];
                vs.retain(|v| *v <= max);
                vs.dedup();
                vs.into_iter().map(imm).collect()
            }
            Some(Field::SImm { width, .. }) => {
                // Two's-complement field: exercise the extremes and a negative.
                let bound = 1i64 << (width - 1);
                [-bound, -1, bound - 1].iter().map(|&v| imm(v)).collect()
            }
            Some(Field::LogicalImm { is64, .. }) => if is64 {
                &[
                    0xFFi64,
                    1,
                    0xF0F0_F0F0_F0F0_F0F0u64 as i64,
                    0x0000_FFFF_0000_FFFF,
                ][..]
            } else {
                &[0xFFi64, 1, 0xF0F0_F0F0u32 as i64, 0xFFFF][..]
            }
            .iter()
            .map(|&v| imm(v))
            .collect(),
            Some(Field::MovImm { .. }) => [0x1234i64, 0, 0xFFFF].iter().map(|&v| imm(v)).collect(),
            Some(Field::MovHw { .. }) => {
                let lsl = |s: u32| Some((alloc::format!("lsl #{s}"), Opnd::Lsl(s)));
                let mut vs = alloc::vec![None, lsl(16)];
                if is64 {
                    vs.push(lsl(48));
                }
                vs
            }
            Some(Field::LslAlias { is64, .. }) => {
                let w = if is64 { 64 } else { 32 };
                [1i64, 4, w - 1].iter().map(|&v| imm(v)).collect()
            }
            Some(Field::ShrAlias { .. }) => {
                let w = if is64 { 64 } else { 32 };
                [1i64, 4, w - 1].iter().map(|&v| imm(v)).collect()
            }
            Some(Field::Cond { inv, .. }) => {
                let mut cs = alloc::vec![1u8, 11];
                if !inv {
                    cs.push(14); // al: valid only where the condition is direct
                }
                cs.into_iter()
                    .map(|c| Some((String::from(cond_name(c)), Opnd::Cond(c))))
                    .collect()
            }
            _ => Vec::new(),
        }
    }

    /// Sweep the catalogue itself: synthesize operands for every form from its
    /// operand pattern and require the encoded word to equal the assembler's.
    /// Register numbers avoid 31, so no zr/sp alias re-canonicalization can
    /// shift the assembler's word choice. `bad` (encoded, disagrees) and `gap`
    /// (assembler accepts, encode refuses) both fail; `skip` counts forms the
    /// local assemblers reject (extension spellings), reported per mnemonic.
    #[test]
    fn differential_sweep() {
        if !enabled() {
            return;
        }
        let regsets: [[u8; 4]; 3] = [[1, 2, 3, 4], [9, 10, 11, 12], [20, 21, 22, 23]];
        let mut cases: Vec<(String, Vec<Opnd>, &'static str)> = Vec::new();
        for f in isa_a64_table::FORMS {
            let cands: Vec<Vec<Option<(String, Opnd)>>> = f
                .ops
                .iter()
                .enumerate()
                .map(|(i, p)| match p {
                    A64Op::X | A64Op::W | A64Op::Mem => Vec::new(),
                    _ => slot_cands(f, i),
                })
                .collect();
            let build = |regs: &[u8; 4], slot: usize, pick: usize| {
                let mut txt: Vec<String> = Vec::new();
                let mut ops: Vec<Opnd> = Vec::new();
                for (i, p) in f.ops.iter().enumerate() {
                    match p {
                        A64Op::X | A64Op::W => {
                            let is64 = matches!(p, A64Op::X);
                            txt.push(alloc::format!(
                                "{}{}",
                                if is64 { 'x' } else { 'w' },
                                regs[i]
                            ));
                            ops.push(Opnd::Reg { num: regs[i], is64 });
                        }
                        A64Op::Mem => match mem_off(f, i) {
                            Some(off) => {
                                txt.push(alloc::format!("[x{}, #{off}]", regs[i]));
                                ops.push(Opnd::Mem {
                                    base: regs[i],
                                    off,
                                    pre: false,
                                });
                            }
                            None => {
                                txt.push(alloc::format!("[x{}]", regs[i]));
                                ops.push(Opnd::Mem {
                                    base: regs[i],
                                    off: 0,
                                    pre: false,
                                });
                            }
                        },
                        _ => {
                            if let Some((t, o)) = &cands[i][if i == slot { pick } else { 0 }] {
                                txt.push(t.clone());
                                ops.push(*o);
                            }
                        }
                    }
                }
                let txt = if txt.is_empty() {
                    String::from(f.mnemonic)
                } else {
                    alloc::format!("{} {}", f.mnemonic, txt.join(", "))
                };
                (txt, ops, f.mnemonic)
            };
            let has_regs = f.ops.iter().any(|p| matches!(p, A64Op::X | A64Op::W));
            for regs in regsets.iter().take(if has_regs { 3 } else { 1 }) {
                cases.push(build(regs, usize::MAX, 0));
            }
            for (i, c) in cands.iter().enumerate() {
                for pick in 1..c.len() {
                    cases.push(build(&regsets[0], i, pick));
                }
            }
        }

        let (mut ok, mut bad, mut gap, mut skip) = (0, 0, 0, 0);
        let mut fails: Vec<String> = Vec::new();
        let mut gaps: Vec<String> = Vec::new();
        let mut skipped: std::collections::BTreeSet<&'static str> = Default::default();
        for (txt, ops, m) in &cases {
            let Some(want) = clang_word(txt) else {
                skip += 1;
                skipped.insert(m);
                continue;
            };
            match encode(m, ops) {
                Ok(got) if got == want => ok += 1,
                Ok(got) => {
                    bad += 1;
                    if fails.len() < 40 {
                        fails.push(alloc::format!("{txt}: got {got:08x} want {want:08x}"));
                    }
                }
                Err(e) => {
                    gap += 1;
                    if gaps.len() < 40 {
                        gaps.push(alloc::format!("{txt}: {e}"));
                    }
                }
            }
        }
        for f in &fails {
            std::eprintln!("  FAIL {f}");
        }
        for g in &gaps {
            std::eprintln!("  GAP {g}");
        }
        std::eprintln!(
            "a64 differential_sweep: forms={} cases={} OK={ok} BAD={bad} GAP={gap} SKIP={skip}",
            isa_a64_table::FORMS.len(),
            cases.len()
        );
        if !skipped.is_empty() {
            let names: Vec<&str> = skipped.into_iter().collect();
            std::eprintln!("  skipped (assembler rejects): {}", names.join(" "));
        }
        assert_eq!(bad, 0, "A64 catalogue words disagree with the assembler");
        assert_eq!(gap, 0, "synthesized catalogue operands failed to encode");
    }

    /// Cross-check the logical-immediate encoder against the assembler for
    /// every canonical bitmask element size, both 64- and 32-bit.
    #[test]
    fn logical_immediate_matches_assembler() {
        if !enabled() {
            return;
        }
        let mut checked = 0;
        let mut bad = 0;
        // A representative spread of masks per element size.
        let masks64: &[u64] = &[
            0xFF,
            0x1,
            0xF0F0_F0F0_F0F0_F0F0,
            0xFFFF_FFFF_FFFF_FFF0,
            0x0000_FFFF_0000_FFFF,
            0x8000_0000_0000_0001,
            0xAAAA_AAAA_AAAA_AAAA,
            0x3FFF_FFFF_FFFF_FFFF,
        ];
        for &mask in masks64 {
            let Some(want) = clang_word(&alloc::format!("and x0, x1, #{mask}")) else {
                continue;
            };
            let got = encode("and", &[xn(0), xn(1), Opnd::Imm(mask as i64)]).unwrap();
            checked += 1;
            if got != want {
                bad += 1;
                std::eprintln!("  logimm {mask:#x}: got {got:08x} want {want:08x}");
            }
        }
        std::eprintln!("a64 logical_immediate: checked={checked} bad={bad}");
        assert_eq!(
            bad, 0,
            "logical-immediate encoding disagrees with the assembler"
        );
    }
}
