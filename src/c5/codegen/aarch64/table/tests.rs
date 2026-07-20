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
    // An offset the scaled form cannot represent falls back to the unscaled
    // simm9 sibling, exactly as the assembler selects; where neither fits it
    // is an error. Words match the assembler at the selection boundaries.
    let mem = |base: u8, off: i64| Opnd::Mem {
        base,
        off,
        pre: false,
    };
    assert_eq!(enc("ldr", &[x(0), mem(1, -8)]), 0xF85F8020); // ldur
    assert_eq!(enc("ldr", &[x(0), mem(1, 4)]), 0xF8404020); // ldur (misaligned)
    assert_eq!(enc("ldr", &[x(0), mem(1, 255)]), 0xF84FF020); // ldur (max imm9)
    assert_eq!(enc("ldr", &[x(0), mem(1, 256)]), 0xF9408020); // scaled again
    assert_eq!(enc("ldr", &[x(0), mem(1, 32760)]), 0xF97FFC20); // max scaled
    assert_eq!(enc("ldrsw", &[x(0), mem(1, -4)]), 0xB89FC020); // ldursw
    assert_eq!(enc("ldrsh", &[x(0), mem(1, 1)]), 0x78801020); // ldursh
    assert_eq!(enc("strh", &[w(0), mem(1, 255)]), 0x780FF020); // sturh
    assert!(encode("ldr", &[x(0), mem(1, 257)]).is_err()); // fits neither
    assert!(encode("ldr", &[x(0), mem(1, 32768)]).is_err());
    assert!(encode("ldr", &[x(0), mem(1, -257)]).is_err());
    // The explicit unscaled/unprivileged mnemonics stay as written.
    assert_eq!(enc("ldur", &[x(0), mem(1, 8)]), 0xF8408020);
    assert_eq!(enc("prfum", &[Opnd::Imm(0), mem(1, -8)]), 0xF89F8020);
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
    // A byte access has no scaling shift (log2 zero): a #1 shift is rejected,
    // and a written `lsl #0` is the S = 1 encoding, as the assembler emits.
    assert!(encode("ldrb", &[w(0), mr(2, 0b011, Some(1))]).is_err());
    assert_eq!(enc("ldrb", &[w(0), mr(2, 0b011, Some(0))]), 0x38627820);
    // For wider accesses a written #0 keeps S = 0.
    assert_eq!(enc("ldrh", &[w(0), mr(2, 0b011, Some(0))]), 0x78626820);
}

#[test]
fn load_store_writeback() {
    // Pre-index `[Xn, #off]!` and post-index `[Xn], #off` are distinct
    // catalogue shapes taking an unscaled simm9, across every access size.
    // Words match the assembler.
    let pre = |base: u8, off: i64| Opnd::Mem {
        base,
        off,
        pre: true,
    };
    let post0 = |base: u8| Opnd::Mem {
        base,
        off: 0,
        pre: false,
    };
    assert_eq!(enc("ldrb", &[w(0), pre(1, 4)]), 0x38404C20);
    assert_eq!(enc("ldrh", &[w(0), pre(1, 4)]), 0x78404C20);
    assert_eq!(enc("strh", &[w(0), pre(1, 2)]), 0x78002C20);
    assert_eq!(enc("strb", &[w(0), pre(1, 255)]), 0x380FFC20);
    assert_eq!(enc("ldrsw", &[x(0), pre(1, -8)]), 0xB89F8C20);
    assert_eq!(enc("str", &[w(0), pre(1, -256)]), 0xB8100C20);
    assert_eq!(enc("ldrsb", &[x(0), post0(1), Opnd::Imm(-4)]), 0x389FC420);
    assert_eq!(enc("ldrsh", &[w(0), post0(1), Opnd::Imm(6)]), 0x78C06420);
    assert_eq!(enc("ldrb", &[w(0), post0(1), Opnd::Imm(-256)]), 0x38500420);
    assert_eq!(enc("strb", &[w(0), post0(1), Opnd::Imm(17)]), 0x38011420);
    assert_eq!(enc("ldr", &[w(0), post0(1), Opnd::Imm(255)]), 0xB84FF420);
    // A post-index offset must ride the trailing operand: an offset inside the
    // brackets has no encoding (it would be silently dropped otherwise).
    let mem = |base: u8, off: i64| Opnd::Mem {
        base,
        off,
        pre: false,
    };
    assert!(encode("ldr", &[x(0), mem(1, 8), Opnd::Imm(16)]).is_err());
    // A base-only shape rejects a nonzero offset outright (ldar has no
    // offset field).
    assert!(encode("ldar", &[w(0), mem(1, 8)]).is_err());
    assert!(encode("ldar", &[w(0), mem(1, 0)]).is_ok());
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
    // The 128-bit `qN` register: immediate offset scaled by 16, register offset
    // with the size-4 shift.
    let q = Opnd::QReg;
    assert_eq!(enc("ldr", &[q(0), mem(1, 0)]), 0x3DC0_0020);
    assert_eq!(enc("ldr", &[q(0), mem(1, 16)]), 0x3DC0_0420);
    assert_eq!(enc("str", &[q(0), mem(1, 32)]), 0x3D80_0820);
    assert_eq!(enc("ldr", &[q(0), mr(None)]), 0x3CE2_6820);
    assert_eq!(enc("ldr", &[q(0), mr(Some(4))]), 0x3CE2_7820);
    assert!(encode("ldr", &[q(0), mem(1, 8)]).is_err()); // not a multiple of 16
}

#[test]
fn simd_vector() {
    // `vN.T`: size is the element-size log2, q the 128- vs 64-bit register.
    let v = |num: u8, size: u8, q: bool| Opnd::VecReg { num, size, q };
    // dup Vd.T, Rn: imm5 carries the element size (one-hot); Q the register.
    assert_eq!(enc("dup", &[v(0, 2, true), w(1)]), 0x4E04_0C20); // v0.4s, w1
    assert_eq!(enc("dup", &[v(0, 0, false), w(1)]), 0x0E01_0C20); // v0.8b, w1
    assert_eq!(enc("dup", &[v(0, 3, true), x(1)]), 0x4E08_0C20); // v0.2d, x1
    // Three-same integer add/sub/mul.
    assert_eq!(
        enc("add", &[v(0, 2, true), v(1, 2, true), v(2, 2, true)]),
        0x4EA2_8420
    );
    assert_eq!(
        enc("add", &[v(0, 0, true), v(1, 0, true), v(2, 0, true)]),
        0x4E22_8420
    );
    assert_eq!(
        enc("sub", &[v(0, 2, true), v(1, 2, true), v(2, 2, true)]),
        0x6EA2_8420
    );
    assert_eq!(
        enc("mul", &[v(0, 2, true), v(1, 2, true), v(2, 2, true)]),
        0x4EA2_9C20
    );
    // Compares and min/max (also three-same, on .4s here).
    let t = |m: &str| enc(m, &[v(0, 2, true), v(1, 2, true), v(2, 2, true)]);
    assert_eq!(t("cmeq"), 0x6EA2_8C20);
    assert_eq!(t("cmgt"), 0x4EA2_3420);
    assert_eq!(t("cmge"), 0x4EA2_3C20);
    assert_eq!(t("cmhi"), 0x6EA2_3420);
    assert_eq!(t("cmhs"), 0x6EA2_3C20);
    assert_eq!(t("smax"), 0x4EA2_6420);
    assert_eq!(t("smin"), 0x4EA2_6C20);
    assert_eq!(t("umax"), 0x6EA2_6420);
    assert_eq!(t("umin"), 0x6EA2_6C20);
    // Logical (byte arrangement only).
    assert_eq!(
        enc("and", &[v(0, 0, true), v(1, 0, true), v(2, 0, true)]),
        0x4E22_1C20
    );
    assert_eq!(
        enc("orr", &[v(0, 0, true), v(1, 0, true), v(2, 0, true)]),
        0x4EA2_1C20
    );
    assert_eq!(
        enc("eor", &[v(0, 0, true), v(1, 0, true), v(2, 0, true)]),
        0x6E22_1C20
    );
    let b = |m: &str| enc(m, &[v(0, 0, true), v(1, 0, true), v(2, 0, true)]);
    assert_eq!(b("bic"), 0x4E62_1C20);
    assert_eq!(b("orn"), 0x4EE2_1C20);
    // Mismatched arrangements and a non-byte logical op are rejected; GP `add`
    // and `bic` (register operands) still reach the catalogue.
    assert!(encode("add", &[v(0, 2, true), v(1, 0, true), v(2, 2, true)]).is_err());
    assert!(encode("and", &[v(0, 2, true), v(1, 2, true), v(2, 2, true)]).is_err());
    assert_eq!(enc("add", &[x(0), x(1), x(2)]), 0x8B02_0020);
    assert_eq!(enc("bic", &[x(0), x(1), x(2)]), 0x8A22_0020);
}

#[test]
fn fp_vector() {
    let s4 = |m: &str| {
        enc(
            m,
            &[
                Opnd::VecReg {
                    num: 0,
                    size: 2,
                    q: true,
                },
                Opnd::VecReg {
                    num: 1,
                    size: 2,
                    q: true,
                },
                Opnd::VecReg {
                    num: 2,
                    size: 2,
                    q: true,
                },
            ],
        )
    };
    // FP three-same on .4s; sz bit selects double, each base bakes the opcode.
    assert_eq!(s4("fadd"), 0x4E22_D420);
    assert_eq!(s4("fsub"), 0x4EA2_D420);
    assert_eq!(s4("fmul"), 0x6E22_DC20);
    assert_eq!(s4("fdiv"), 0x6E22_FC20);
    assert_eq!(s4("fmax"), 0x4E22_F420);
    assert_eq!(s4("fmin"), 0x4EA2_F420);
    assert_eq!(s4("fcmeq"), 0x4E22_E420);
    assert_eq!(s4("fcmgt"), 0x6EA2_E420);
    assert_eq!(s4("fcmge"), 0x6E22_E420);
    // The sz bit for .2d, the Q bit for .2s.
    let d2 = |n: u8| Opnd::VecReg {
        num: n,
        size: 3,
        q: true,
    };
    assert_eq!(enc("fadd", &[d2(0), d2(1), d2(2)]), 0x4E62_D420);
    let s2 = |n: u8| Opnd::VecReg {
        num: n,
        size: 2,
        q: false,
    };
    assert_eq!(enc("fadd", &[s2(0), s2(1), s2(2)]), 0x0E22_D420);
    // FP vector needs 2s/4s/2d; a byte arrangement is rejected. Scalar fadd
    // (VReg operands) still reaches the scalar arm.
    let b8 = |n: u8| Opnd::VecReg {
        num: n,
        size: 0,
        q: false,
    };
    assert!(encode("fadd", &[b8(0), b8(1), b8(2)]).is_err());
    let d = |n: u8| Opnd::VReg { num: n, is_d: true };
    assert_eq!(enc("fadd", &[d(0), d(1), d(2)]), 0x1E62_2820);
}

#[test]
fn vector_shift() {
    let v = |n: u8, size: u8, q: bool| Opnd::VecReg { num: n, size, q };
    let sh = |m: &str, size: u8, q: bool, amt: i64| {
        enc(m, &[v(0, size, q), v(1, size, q), Opnd::Imm(amt)])
    };
    // shl: immh:immb = esize + shift; the arrangement rides the field, not a size
    // slot. shift 0..esize-1 is valid.
    assert_eq!(sh("shl", 2, true, 3), 0x4F23_5420); // .4s #3
    assert_eq!(sh("shl", 0, true, 1), 0x4F09_5420); // .16b #1
    assert_eq!(sh("shl", 3, true, 7), 0x4F47_5420); // .2d #7
    assert_eq!(sh("shl", 1, true, 5), 0x4F15_5420); // .8h #5
    assert_eq!(sh("shl", 2, true, 0), 0x4F20_5420); // .4s #0 (min)
    // sshr/ushr: immh:immb = 2*esize - shift; U at bit 29 picks unsigned. shift
    // 1..esize is valid (esize is the max, not esize-1).
    assert_eq!(sh("sshr", 2, true, 3), 0x4F3D_0420);
    assert_eq!(sh("ushr", 2, true, 3), 0x6F3D_0420);
    assert_eq!(sh("sshr", 0, true, 8), 0x4F08_0420); // .16b #8 (max)
    assert_eq!(sh("ushr", 3, true, 64), 0x6F40_0420); // .2d #64 (max)
    assert_eq!(sh("sshr", 2, true, 32), 0x4F20_0420); // .4s #32 (max)
    // Out-of-range amounts and the reserved .1d arrangement are rejected.
    assert!(encode("shl", &[v(0, 2, true), v(1, 2, true), Opnd::Imm(32)]).is_err());
    assert!(encode("sshr", &[v(0, 2, true), v(1, 2, true), Opnd::Imm(0)]).is_err());
    assert!(encode("sshr", &[v(0, 2, true), v(1, 2, true), Opnd::Imm(33)]).is_err());
    assert!(encode("shl", &[v(0, 3, false), v(1, 3, false), Opnd::Imm(1)]).is_err());
}

#[test]
fn vector_lane_transfer() {
    let ve = |n: u8, size: u8, index: u8| Opnd::VecElem {
        num: n,
        size,
        index,
    };
    // umov Rd, Vn.T[i]: imm5 = (index << (size+1)) | (1<<size); the destination
    // width is fixed by the element (W for b/h/s, X for d, Q following).
    assert_eq!(enc("umov", &[w(0), ve(1, 2, 0)]), 0x0E04_3C20); // .s[0]
    assert_eq!(enc("umov", &[w(0), ve(1, 2, 3)]), 0x0E1C_3C20); // .s[3]
    assert_eq!(enc("umov", &[x(0), ve(1, 3, 1)]), 0x4E18_3C20); // .d[1]
    assert_eq!(enc("umov", &[w(0), ve(1, 0, 5)]), 0x0E0B_3C20); // .b[5]
    assert_eq!(enc("umov", &[w(0), ve(1, 1, 2)]), 0x0E0A_3C20); // .h[2]
    // smov Rd, Vn.T[i]: sign-extends; Q follows the chosen destination width.
    assert_eq!(enc("smov", &[w(0), ve(1, 0, 5)]), 0x0E0B_2C20); // Wd <- b
    assert_eq!(enc("smov", &[x(0), ve(1, 1, 2)]), 0x4E0A_2C20); // Xd <- h
    // ins Vd.T[i], Rn (and the `mov` alias): Q fixed, source width follows the
    // element.
    assert_eq!(enc("ins", &[ve(0, 2, 1), w(2)]), 0x4E0C_1C40); // .s[1] <- w2
    assert_eq!(enc("ins", &[ve(0, 3, 1), x(2)]), 0x4E18_1C40); // .d[1] <- x2
    assert_eq!(enc("ins", &[ve(0, 0, 5), w(2)]), 0x4E0B_1C40); // .b[5] <- w2
    assert_eq!(enc("mov", &[ve(0, 2, 1), w(2)]), 0x4E0C_1C40); // alias
    // Width mismatches are rejected: umov of a d element into W, smov whose
    // element is as wide as the destination, ins of a d element from W.
    assert!(encode("umov", &[w(0), ve(1, 3, 0)]).is_err());
    assert!(encode("smov", &[w(0), ve(1, 2, 0)]).is_err());
    assert!(encode("ins", &[ve(0, 3, 0), w(2)]).is_err());
}

#[test]
fn vector_immediate() {
    let v = |n: u8, size: u8, q: bool| Opnd::VecReg { num: n, size, q };
    // movi: 8-bit value split abc:defgh; cmode picks element size and shift.
    assert_eq!(enc("movi", &[v(0, 2, true), Opnd::Imm(0)]), 0x4F00_0400); // .4s #0
    assert_eq!(enc("movi", &[v(0, 0, true), Opnd::Imm(0)]), 0x4F00_E400); // .16b #0
    assert_eq!(enc("movi", &[v(0, 2, true), Opnd::Imm(1)]), 0x4F00_0420); // .4s #1
    assert_eq!(enc("movi", &[v(0, 2, true), Opnd::Imm(0xFF)]), 0x4F07_07E0); // .4s #0xff
    assert_eq!(enc("movi", &[v(0, 1, true), Opnd::Imm(2)]), 0x4F00_8440); // .8h #2
    assert_eq!(enc("movi", &[v(0, 3, true), Opnd::Imm(0)]), 0x6F00_E400); // .2d #0
    // The lsl shift selects the higher-cmode word/half variants.
    assert_eq!(
        enc("movi", &[v(0, 2, true), Opnd::Imm(1), Opnd::Lsl(8)]),
        0x4F00_2420
    );
    assert_eq!(
        enc("movi", &[v(0, 2, true), Opnd::Imm(1), Opnd::Lsl(16)]),
        0x4F00_4420
    );
    // mvni sets the op bit; not defined for byte or .2d.
    assert_eq!(enc("mvni", &[v(0, 2, true), Opnd::Imm(0)]), 0x6F00_0400);
    assert!(encode("mvni", &[v(0, 0, true), Opnd::Imm(0)]).is_err());
    // .2d replicates each immediate bit to a byte; non-0x00/0xFF bytes and an
    // out-of-range 8-bit value are rejected.
    assert!(encode("movi", &[v(0, 3, true), Opnd::Imm(0x1122)]).is_err());
    assert!(encode("movi", &[v(0, 2, true), Opnd::Imm(256)]).is_err());
    assert!(encode("movi", &[v(0, 2, true), Opnd::Imm(1), Opnd::Lsl(20)]).is_err());
}

#[test]
fn vector_one_source() {
    let v = |n: u8, size: u8, q: bool| Opnd::VecReg { num: n, size, q };
    let u = |m: &str, size: u8| enc(m, &[v(0, size, true), v(1, size, true)]);
    // Sign, bitwise, popcount, reverses -- each base bakes U and the opcode.
    assert_eq!(u("abs", 2), 0x4EA0_B820); // .4s
    assert_eq!(u("neg", 2), 0x6EA0_B820);
    assert_eq!(u("not", 0), 0x6E20_5820); // .16b
    assert_eq!(u("cnt", 0), 0x4E20_5820);
    assert_eq!(u("rev64", 2), 0x4EA0_0820);
    assert_eq!(u("rev32", 0), 0x6E20_0820);
    assert_eq!(u("rev16", 0), 0x4E20_1820);
    // FP unary on 2s/4s/2d.
    assert_eq!(u("fneg", 2), 0x6EA0_F820); // .4s
    assert_eq!(u("fabs", 3), 0x4EE0_F820); // .2d
    assert_eq!(u("fsqrt", 2), 0x6EA1_F820);
    // Scalar fneg/fabs (VReg) still reach the scalar arm.
    let d = |n: u8| Opnd::VReg { num: n, is_d: true };
    assert_eq!(enc("fneg", &[d(0), d(1)]), 0x1E61_4020);
    assert_eq!(enc("fabs", &[d(0), d(1)]), 0x1E60_C020);
    // Element-size bounds: rev16 is byte-only, cnt is byte-only, fneg needs
    // 2s/4s/2d, and .1d is reserved for the all-size ops.
    assert!(encode("rev16", &[v(0, 2, true), v(1, 2, true)]).is_err()); // not .4s
    assert!(encode("cnt", &[v(0, 1, true), v(1, 1, true)]).is_err()); // not .8h
    assert!(encode("fneg", &[v(0, 0, true), v(1, 0, true)]).is_err()); // not .16b
    assert!(encode("neg", &[v(0, 3, false), v(1, 3, false)]).is_err()); // .1d
}

#[test]
fn vector_three_same_batch3() {
    let v = |n: u8, size: u8, q: bool| Opnd::VecReg { num: n, size, q };
    let t = |m: &str| enc(m, &[v(0, 2, true), v(1, 2, true), v(2, 2, true)]); // .4s
    // Saturating add/sub, multiply-accumulate, absolute difference, pairwise.
    assert_eq!(t("sqadd"), 0x4EA2_0C20);
    assert_eq!(t("uqadd"), 0x6EA2_0C20);
    assert_eq!(t("sqsub"), 0x4EA2_2C20);
    assert_eq!(t("uqsub"), 0x6EA2_2C20);
    assert_eq!(t("mla"), 0x4EA2_9420);
    assert_eq!(t("mls"), 0x6EA2_9420);
    assert_eq!(t("sabd"), 0x4EA2_7420);
    assert_eq!(t("uabd"), 0x6EA2_7420);
    assert_eq!(t("addp"), 0x4EA2_BC20);
    // FP multiply-accumulate, absolute difference, pairwise.
    assert_eq!(t("fmla"), 0x4E22_CC20);
    assert_eq!(t("fmls"), 0x4EA2_CC20);
    assert_eq!(t("fabd"), 0x6EA2_D420);
    assert_eq!(t("faddp"), 0x6E22_D420);
    // Element-size bounds match the ISA: add/addp reach 2d, mul/smax/mla do not,
    // and .1d is reserved.
    assert_eq!(
        enc("add", &[v(0, 3, true), v(1, 3, true), v(2, 3, true)]),
        0x4EE2_8420
    );
    assert!(encode("mul", &[v(0, 3, true), v(1, 3, true), v(2, 3, true)]).is_err());
    assert!(encode("smax", &[v(0, 3, true), v(1, 3, true), v(2, 3, true)]).is_err());
    assert!(encode("mla", &[v(0, 3, true), v(1, 3, true), v(2, 3, true)]).is_err());
    assert!(encode("add", &[v(0, 3, false), v(1, 3, false), v(2, 3, false)]).is_err());
}

#[test]
fn vector_widen_narrow() {
    let vr = |n: u8, size: u8, q: bool| Opnd::VecReg { num: n, size, q };
    // Widening (long): dst element is twice the source width; size field is the
    // source width, U selects unsigned, the `2` suffix reads 128-bit sources.
    assert_eq!(
        enc("saddl", &[vr(0, 1, true), vr(1, 0, false), vr(2, 0, false)]),
        0x0E22_0020
    ); // .8h <- .8b
    assert_eq!(
        enc("uaddl", &[vr(0, 1, true), vr(1, 0, false), vr(2, 0, false)]),
        0x2E22_0020
    );
    assert_eq!(
        enc("ssubl", &[vr(0, 2, true), vr(1, 1, false), vr(2, 1, false)]),
        0x0E62_2020
    ); // .4s <- .4h
    assert_eq!(
        enc("smull", &[vr(0, 1, true), vr(1, 0, false), vr(2, 0, false)]),
        0x0E22_C020
    );
    assert_eq!(
        enc("umlal", &[vr(0, 2, true), vr(1, 1, false), vr(2, 1, false)]),
        0x2E62_8020
    );
    assert_eq!(
        enc("smlsl", &[vr(0, 1, true), vr(1, 0, false), vr(2, 0, false)]),
        0x0E22_A020
    );
    // `2` variants read the upper half of 128-bit sources.
    assert_eq!(
        enc("saddl2", &[vr(0, 1, true), vr(1, 0, true), vr(2, 0, true)]),
        0x4E22_0020
    );
    assert_eq!(
        enc("smull2", &[vr(0, 3, true), vr(1, 2, true), vr(2, 2, true)]),
        0x4EA2_C020
    );
    // Narrowing: dst element is half the source; size field is the destination.
    assert_eq!(enc("xtn", &[vr(0, 0, false), vr(1, 1, true)]), 0x0E21_2820); // .8b <- .8h
    assert_eq!(enc("xtn2", &[vr(0, 0, true), vr(1, 1, true)]), 0x4E21_2820); // .16b <- .8h
    assert_eq!(
        enc("sqxtn", &[vr(0, 0, false), vr(1, 1, true)]),
        0x0E21_4820
    );
    assert_eq!(
        enc("uqxtn", &[vr(0, 1, false), vr(1, 2, true)]),
        0x2E61_4820
    ); // .4h <- .4s
    assert_eq!(
        enc("sqxtun", &[vr(0, 0, false), vr(1, 1, true)]),
        0x2E21_2820
    );
    // Bad size relationships are rejected: widen dst not one wider, narrow
    // source not 128-bit, and a `2` form on 64-bit sources.
    assert!(encode("saddl", &[vr(0, 2, true), vr(1, 0, false), vr(2, 0, false)]).is_err());
    assert!(encode("xtn", &[vr(0, 0, false), vr(1, 1, false)]).is_err());
    assert!(
        encode(
            "saddl2",
            &[vr(0, 1, true), vr(1, 0, false), vr(2, 0, false)]
        )
        .is_err()
    );
}

#[test]
fn simd_ld_st_multi() {
    let list = |first: u8, count: u8, size: u8, q: bool| Opnd::VecList {
        first,
        count,
        size,
        q,
    };
    let mem = |base: u8| Opnd::Mem {
        base,
        off: 0,
        pre: false,
    };
    // ld1 with 1..4 registers of one arrangement; Rt is the first register, the
    // opcode encodes the count, L (bit 22) marks the load.
    assert_eq!(enc("ld1", &[list(0, 1, 2, true), mem(1)]), 0x4C40_7820); // {v0.4s}
    assert_eq!(enc("ld1", &[list(0, 1, 0, true), mem(1)]), 0x4C40_7020); // {v0.16b}
    assert_eq!(enc("st1", &[list(0, 1, 2, true), mem(1)]), 0x4C00_7820);
    assert_eq!(enc("ld1", &[list(0, 2, 2, true), mem(1)]), 0x4C40_A820);
    assert_eq!(enc("ld1", &[list(0, 3, 2, true), mem(1)]), 0x4C40_6820);
    assert_eq!(enc("ld1", &[list(0, 4, 2, true), mem(1)]), 0x4C40_2820);
    assert_eq!(enc("st1", &[list(0, 2, 3, true), mem(1)]), 0x4C00_AC20); // {v0,v1}.2d
    assert_eq!(enc("ld1", &[list(0, 1, 0, false), mem(1)]), 0x0C40_7020); // {v0.8b}
    // ld2/ld3/ld4 need exactly 2/3/4 registers.
    assert_eq!(enc("ld2", &[list(0, 2, 2, true), mem(1)]), 0x4C40_8820);
    assert!(encode("ld2", &[list(0, 1, 2, true), mem(1)]).is_err());
    assert!(encode("ld3", &[list(0, 2, 2, true), mem(1)]).is_err());
    // Post-index: `, #imm` (imm = list byte size, Rm = 31) or `, Xm` (Rm = Xm);
    // the writeback bit (23) is set.
    assert_eq!(
        enc("ld1", &[list(0, 1, 2, true), mem(1), Opnd::Imm(16)]),
        0x4CDF_7820
    );
    assert_eq!(
        enc("ld1", &[list(0, 2, 2, true), mem(1), Opnd::Imm(32)]),
        0x4CDF_A820
    );
    assert_eq!(
        enc("st1", &[list(0, 1, 0, true), mem(1), Opnd::Imm(16)]),
        0x4C9F_7020
    );
    assert_eq!(
        enc("ld1", &[list(0, 1, 0, false), mem(1), Opnd::Imm(8)]),
        0x0CDF_7020
    );
    assert_eq!(
        enc("ld1", &[list(0, 1, 2, true), mem(1), x(2)]),
        0x4CC2_7820
    );
    assert_eq!(
        enc("st1", &[list(0, 2, 2, true), mem(1), x(2)]),
        0x4C82_A820
    );
    assert_eq!(
        enc("ld2", &[list(0, 2, 2, true), mem(1), Opnd::Imm(32)]),
        0x4CDF_8820
    );
    // A wrong immediate increment (not the list byte size) is rejected.
    assert!(encode("ld1", &[list(0, 1, 2, true), mem(1), Opnd::Imm(8)]).is_err());
    // A non-zero offset needs the post-index form, not yet accepted here.
    assert!(
        encode(
            "ld1",
            &[
                list(0, 1, 2, true),
                Opnd::Mem {
                    base: 1,
                    off: 16,
                    pre: false
                }
            ]
        )
        .is_err()
    );
}

#[test]
fn simd_ld1r() {
    let list = |first: u8, size: u8, q: bool| Opnd::VecList {
        first,
        count: 1,
        size,
        q,
    };
    let mem = |base: u8| Opnd::Mem {
        base,
        off: 0,
        pre: false,
    };
    // Load-replicate: one element broadcast to all lanes; size in bits 11..10.
    assert_eq!(enc("ld1r", &[list(0, 2, true), mem(1)]), 0x4D40_C820); // .4s
    assert_eq!(enc("ld1r", &[list(0, 0, true), mem(1)]), 0x4D40_C020); // .16b
    assert_eq!(enc("ld1r", &[list(0, 3, true), mem(1)]), 0x4D40_CC20); // .2d
    assert_eq!(enc("ld1r", &[list(0, 1, true), mem(1)]), 0x4D40_C420); // .8h
    // Post-index: immediate = element size (1<<size bytes), or a register.
    assert_eq!(
        enc("ld1r", &[list(0, 2, true), mem(1), Opnd::Imm(4)]),
        0x4DDF_C820
    );
    assert_eq!(enc("ld1r", &[list(0, 2, true), mem(1), x(2)]), 0x4DC2_C820);
    // A wrong immediate increment and a multi-register list are rejected.
    assert!(encode("ld1r", &[list(0, 2, true), mem(1), Opnd::Imm(16)]).is_err());
    let l = |first: u8, count: u8, size: u8, q: bool| Opnd::VecList {
        first,
        count,
        size,
        q,
    };
    assert!(encode("ld1r", &[l(0, 2, 2, true), mem(1)]).is_err());
    // ld2r/ld3r/ld4r replicate 2/3/4 registers: opcode 0xC (1/2) or 0xE (3/4),
    // R (bit 21) set for the even counts.
    assert_eq!(enc("ld2r", &[l(0, 2, 2, true), mem(1)]), 0x4D60_C820);
    assert_eq!(enc("ld3r", &[l(0, 3, 0, true), mem(1)]), 0x4D40_E020);
    assert_eq!(enc("ld4r", &[l(0, 4, 3, true), mem(1)]), 0x4D60_EC20);
    // The register count must match the structure.
    assert!(encode("ld2r", &[l(0, 1, 2, true), mem(1)]).is_err());
    assert!(encode("ld3r", &[l(0, 4, 2, true), mem(1)]).is_err());
    // Post-index by the replicated byte size (count << size).
    assert_eq!(
        enc("ld2r", &[l(0, 2, 2, true), mem(1), Opnd::Imm(8)]),
        0x4DFF_C820
    );
}

#[test]
fn simd_ld_st_single_lane() {
    let el = |num: u8, size: u8, index: u8| Opnd::VecElem { num, size, index };
    let mem = |base: u8| Opnd::Mem {
        base,
        off: 0,
        pre: false,
    };
    // The lane index is bit-sliced across Q (30), S (12), and size (11..10); the
    // opcode (15..13) is the element class. L (bit 22) marks the load.
    assert_eq!(enc("ld1", &[el(0, 2, 2), mem(1)]), 0x4D40_8020); // {v0.s}[2]
    assert_eq!(enc("st1", &[el(0, 2, 2), mem(1)]), 0x4D00_8020);
    assert_eq!(enc("ld1", &[el(0, 0, 5), mem(1)]), 0x0D40_1420); // {v0.b}[5]
    assert_eq!(enc("ld1", &[el(0, 3, 1), mem(1)]), 0x4D40_8420); // {v0.d}[1]
    assert_eq!(enc("ld1", &[el(0, 1, 3), mem(1)]), 0x0D40_5820); // {v0.h}[3]
    assert_eq!(enc("st1", &[el(0, 3, 0), mem(1)]), 0x0D00_8420); // {v0.d}[0]
    // Post-index by the element size, or a register.
    assert_eq!(
        enc("ld1", &[el(0, 2, 2), mem(1), Opnd::Imm(4)]),
        0x4DDF_8020
    );
    assert_eq!(enc("ld1", &[el(0, 2, 2), mem(1), x(2)]), 0x4DC2_8020);
    // A wrong immediate increment is rejected.
    assert!(encode("ld1", &[el(0, 2, 2), mem(1), Opnd::Imm(8)]).is_err());
}

#[test]
fn poly_multiply() {
    let v = |n: u8, size: u8, q: bool| Opnd::VecReg { num: n, size, q };
    let x = |n: u8| Opnd::Reg { num: n, is64: true };
    // Byte form widens .8b/.16b to .8h; pmull2 reads the upper 64-bit halves.
    assert_eq!(
        enc("pmull", &[v(0, 1, true), v(1, 0, false), v(2, 0, false)]),
        0x0E22_E020
    );
    assert_eq!(
        enc("pmull2", &[v(0, 1, true), v(1, 0, true), v(2, 0, true)]),
        0x4E22_E020
    );
    // Dword form widens .1d/.2d to .1q (the size-4 element used for GHASH).
    assert_eq!(
        enc("pmull", &[v(0, 4, true), v(1, 3, false), v(2, 3, false)]),
        0x0EE2_E020
    );
    assert_eq!(
        enc("pmull2", &[v(0, 4, true), v(1, 3, true), v(2, 3, true)]),
        0x4EE2_E020
    );
    // pmull needs 64-bit sources, pmull2 needs 128-bit, and the destination must
    // match the source width.
    assert!(encode("pmull", &[v(0, 1, true), v(1, 0, true), v(2, 0, true)]).is_err());
    assert!(encode("pmull2", &[v(0, 4, true), v(1, 3, false), v(2, 3, false)]).is_err());
    assert!(encode("pmull", &[v(0, 2, true), v(1, 0, false), v(2, 0, false)]).is_err());
    // .1q exists only for pmull: dup and vector shift reject it, and dup also
    // rejects the single-lane .1d.
    assert!(encode("dup", &[v(0, 4, true), x(1)]).is_err()); // .1q
    assert!(encode("dup", &[v(0, 3, false), x(1)]).is_err()); // .1d
    assert!(encode("shl", &[v(0, 4, true), v(1, 4, true), Opnd::Imm(1)]).is_err()); // .1q
}

#[test]
fn fp_immediate() {
    let d = |n: u8| Opnd::VReg { num: n, is_d: true };
    let s = |n: u8| Opnd::VReg {
        num: n,
        is_d: false,
    };
    let v = |n: u8, size: u8, q: bool| Opnd::VecReg { num: n, size, q };
    let fp = Opnd::FpImm;
    // Scalar fmov: type bit selects double, the 8-bit VFP value sits at bit 13.
    assert_eq!(enc("fmov", &[d(0), fp(0x70)]), 0x1E6E_1000); // 1.0
    assert_eq!(enc("fmov", &[d(0), fp(0x00)]), 0x1E60_1000); // 2.0
    assert_eq!(enc("fmov", &[d(0), fp(0xF0)]), 0x1E7E_1000); // -1.0
    assert_eq!(enc("fmov", &[s(0), fp(0x70)]), 0x1E2E_1000); // 1.0 single
    // Vector fmov: cmode 1111, op (bit 29) selects the .2d form.
    assert_eq!(enc("fmov", &[v(0, 2, true), fp(0x70)]), 0x4F03_F600); // .4s 1.0
    assert_eq!(enc("fmov", &[v(0, 3, true), fp(0x70)]), 0x6F03_F600); // .2d 1.0
    assert_eq!(enc("fmov", &[v(0, 2, true), fp(0x80)]), 0x4F04_F400); // .4s -2.0
    // Vector fmov immediate needs 2s/4s/2d; a byte arrangement and .1d reject.
    assert!(encode("fmov", &[v(0, 0, true), fp(0x70)]).is_err());
    assert!(encode("fmov", &[v(0, 3, false), fp(0x70)]).is_err());
}

#[test]
fn table_lookup() {
    let v = |n: u8, q: bool| Opnd::VecReg { num: n, size: 0, q };
    let tab = |first: u8, count: u8| Opnd::VecList {
        first,
        count,
        size: 0,
        q: true,
    };
    // tbl: len (bits 14..13) is the table count minus one; Q from the dst/index.
    assert_eq!(
        enc("tbl", &[v(0, true), tab(1, 1), v(2, true)]),
        0x4E02_0020
    );
    assert_eq!(
        enc("tbl", &[v(0, false), tab(1, 1), v(2, false)]),
        0x0E02_0020
    ); // .8b
    assert_eq!(
        enc("tbl", &[v(0, true), tab(1, 2), v(3, true)]),
        0x4E03_2020
    );
    assert_eq!(
        enc("tbl", &[v(0, true), tab(1, 3), v(4, true)]),
        0x4E04_4020
    );
    assert_eq!(
        enc("tbl", &[v(0, true), tab(1, 4), v(5, true)]),
        0x4E05_6020
    );
    // tbx sets bit 12.
    assert_eq!(
        enc("tbx", &[v(0, true), tab(1, 1), v(2, true)]),
        0x4E02_1020
    );
    assert_eq!(
        enc("tbx", &[v(0, true), tab(1, 2), v(3, true)]),
        0x4E03_3020
    );
    // A mismatched dst/index arrangement and a non-.16b table are rejected.
    assert!(encode("tbl", &[v(0, true), tab(1, 1), v(2, false)]).is_err());
    assert!(
        encode(
            "tbl",
            &[
                v(0, true),
                Opnd::VecList {
                    first: 1,
                    count: 1,
                    size: 2,
                    q: true
                },
                v(2, true)
            ]
        )
        .is_err()
    );
}

#[test]
fn across_lane_reduction() {
    let b = |n: u8| Opnd::VScalar { num: n, size: 0 };
    let h = |n: u8| Opnd::VScalar { num: n, size: 1 };
    let s = |n: u8| Opnd::VReg {
        num: n,
        is_d: false,
    };
    let d = |n: u8| Opnd::VReg { num: n, is_d: true };
    let v = |n: u8, size: u8, q: bool| Opnd::VecReg { num: n, size, q };
    // addv/maxv/minv reduce to a scalar at the source element size (b/h/s).
    assert_eq!(enc("addv", &[b(0), v(1, 0, true)]), 0x4E31_B820); // .16b -> b
    assert_eq!(enc("addv", &[h(0), v(1, 1, true)]), 0x4E71_B820); // .8h  -> h
    assert_eq!(enc("addv", &[s(0), v(1, 2, true)]), 0x4EB1_B820); // .4s  -> s
    assert_eq!(enc("smaxv", &[b(0), v(1, 0, true)]), 0x4E30_A820);
    assert_eq!(enc("sminv", &[h(0), v(1, 1, true)]), 0x4E71_A820);
    assert_eq!(enc("umaxv", &[s(0), v(1, 2, true)]), 0x6EB0_A820);
    assert_eq!(enc("uminv", &[b(0), v(1, 0, true)]), 0x6E31_A820);
    // Long reductions widen the destination one element size.
    assert_eq!(enc("saddlv", &[h(0), v(1, 0, true)]), 0x4E30_3820); // .16b -> h
    assert_eq!(enc("uaddlv", &[s(0), v(1, 1, true)]), 0x6E70_3820); // .8h  -> s
    assert_eq!(enc("saddlv", &[d(0), v(1, 2, true)]), 0x4EB0_3820); // .4s  -> d
    // A destination of the wrong width, a .2d source, and a long reduction whose
    // destination is not widened are all rejected.
    assert!(encode("addv", &[s(0), v(1, 0, true)]).is_err()); // .16b needs b
    assert!(encode("addv", &[b(0), v(1, 3, true)]).is_err()); // .2d not a reduction
    assert!(encode("saddlv", &[b(0), v(1, 0, true)]).is_err()); // needs the wider h
}

#[test]
fn crypto() {
    let v = |n: u8, size: u8| Opnd::VecReg {
        num: n,
        size,
        q: true,
    };
    // AES round steps on .16b.
    assert_eq!(enc("aese", &[v(0, 0), v(1, 0)]), 0x4E28_4820);
    assert_eq!(enc("aesd", &[v(0, 0), v(1, 0)]), 0x4E28_5820);
    assert_eq!(enc("aesmc", &[v(0, 0), v(1, 0)]), 0x4E28_6820);
    assert_eq!(enc("aesimc", &[v(0, 0), v(1, 0)]), 0x4E28_7820);
    // SHA update steps on .4s.
    assert_eq!(enc("sha256su0", &[v(0, 2), v(1, 2)]), 0x5E28_2820);
    assert_eq!(enc("sha1su1", &[v(0, 2), v(1, 2)]), 0x5E28_1820);
    assert_eq!(enc("sha256su1", &[v(0, 2), v(1, 2), v(2, 2)]), 0x5E02_6020);
    // SHA256 hash update: Qd, Qn, Vm.4s.
    let q = Opnd::QReg;
    assert_eq!(enc("sha256h", &[q(0), q(1), v(2, 2)]), 0x5E02_4020);
    assert_eq!(enc("sha256h2", &[q(0), q(1), v(2, 2)]), 0x5E02_5020);
    // Wrong arrangements are rejected (AES needs .16b, SHA needs .4s).
    assert!(encode("aese", &[v(0, 2), v(1, 2)]).is_err());
    assert!(encode("sha256su0", &[v(0, 0), v(1, 0)]).is_err());
    assert!(encode("sha256h", &[q(0), q(1), v(2, 0)]).is_err());
}

#[test]
fn vector_permute() {
    let v = |n: u8, size: u8, q: bool| Opnd::VecReg { num: n, size, q };
    let p = |m: &str| enc(m, &[v(0, 2, true), v(1, 2, true), v(2, 2, true)]);
    // zip/uzp/trn on .4s; each base bakes the opcode, size at bit 22, Q at 30.
    assert_eq!(p("zip1"), 0x4E82_3820);
    assert_eq!(p("zip2"), 0x4E82_7820);
    assert_eq!(p("uzp1"), 0x4E82_1820);
    assert_eq!(p("uzp2"), 0x4E82_5820);
    assert_eq!(p("trn1"), 0x4E82_2820);
    assert_eq!(p("trn2"), 0x4E82_6820);
    // The size field tracks the arrangement; .1d (size 3, no Q) is reserved.
    assert_eq!(
        enc("zip1", &[v(0, 0, true), v(1, 0, true), v(2, 0, true)]),
        0x4E02_3820
    ); // .16b
    assert_eq!(
        enc("zip1", &[v(0, 3, true), v(1, 3, true), v(2, 3, true)]),
        0x4EC2_3820
    ); // .2d
    assert!(encode("zip1", &[v(0, 3, false), v(1, 3, false), v(2, 3, false)]).is_err());
    // ext: byte-only, imm4 selects the starting byte of Vm:Vn.
    assert_eq!(
        enc(
            "ext",
            &[v(0, 0, true), v(1, 0, true), v(2, 0, true), Opnd::Imm(4)]
        ),
        0x6E02_2020
    );
    // A non-byte arrangement and an out-of-range index are rejected.
    assert!(
        encode(
            "ext",
            &[v(0, 2, true), v(1, 2, true), v(2, 2, true), Opnd::Imm(1)]
        )
        .is_err()
    );
    assert!(
        encode(
            "ext",
            &[v(0, 0, true), v(1, 0, true), v(2, 0, true), Opnd::Imm(16)]
        )
        .is_err()
    );
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
            | Field::ScaledUImm { op, .. }
            | Field::ScaledSImm { op, .. }
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
    /// (negative for the signed forms, positive for the unsigned ones, scaled
    /// where the field scales), or None for a base-only memory operand.
    fn mem_off(f: &Form, idx: usize) -> Option<i64> {
        f.fields.iter().find_map(|fl| match *fl {
            Field::SImm { op, .. } if op as usize == idx => Some(-8),
            Field::UImm { op, .. } if op as usize == idx => Some(8),
            Field::ScaledSImm { op, scale, .. } if op as usize == idx => Some(-(scale as i64)),
            Field::ScaledUImm { op, scale, .. } if op as usize == idx => Some(scale as i64),
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
            Some(Field::ScaledSImm { width, scale, .. }) => {
                let (bound, scale) = (1i64 << (width - 1), scale as i64);
                [-bound * scale, -scale, (bound - 1) * scale]
                    .iter()
                    .map(|&v| imm(v))
                    .collect()
            }
            Some(Field::ScaledUImm { width, scale, .. }) => {
                let (max, scale) = ((1i64 << width) - 1, scale as i64);
                [scale, max * scale].iter().map(|&v| imm(v)).collect()
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
                    A64Op::X | A64Op::W | A64Op::Mem | A64Op::MemPre | A64Op::MemReg => Vec::new(),
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
                        A64Op::MemPre => {
                            let off = mem_off(f, i).unwrap_or(0);
                            txt.push(alloc::format!("[x{}, #{off}]!", regs[i]));
                            ops.push(Opnd::Mem {
                                base: regs[i],
                                off,
                                pre: true,
                            });
                        }
                        // x7 is outside every regset, so the index never
                        // collides with a base or data register.
                        A64Op::MemReg => {
                            txt.push(alloc::format!("[x{}, x7]", regs[i]));
                            ops.push(Opnd::MemReg {
                                base: regs[i],
                                index: 7,
                                option: 0b011,
                                shift: None,
                            });
                        }
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
            // Register-offset extend variants: every option, both S encodings.
            if let Some(mi) = f.ops.iter().position(|p| matches!(p, A64Op::MemReg))
                && let Some(sl2) = f.fields.iter().find_map(|fl| match *fl {
                    Field::MemRegIdx { sl2, .. } => Some(sl2),
                    _ => None,
                })
            {
                let variants: [(String, u8, Option<u8>); 4] = [
                    (alloc::format!("x7, lsl #{sl2}"), 0b011, Some(sl2)),
                    (String::from("w7, uxtw"), 0b010, None),
                    (alloc::format!("w7, sxtw #{sl2}"), 0b110, Some(sl2)),
                    (String::from("x7, sxtx"), 0b111, None),
                ];
                for (itxt, option, shift) in variants {
                    let (txt, mut ops, m) = build(&regsets[0], usize::MAX, 0);
                    let txt = txt.replace("x7]", &alloc::format!("{itxt}]"));
                    ops[mi] = Opnd::MemReg {
                        base: regsets[0][mi],
                        index: 7,
                        option,
                        shift,
                    };
                    cases.push((txt, ops, m));
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
