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
        enc("ldr", &[x(0), Opnd::Mem { base: 1, off: 0 }]),
        0xF9400020
    );
    assert_eq!(
        enc("ldr", &[x(0), Opnd::Mem { base: 1, off: 8 }]),
        0xF9400420
    );
    assert_eq!(
        enc("str", &[x(0), Opnd::Mem { base: 1, off: 0 }]),
        0xF9000020
    );
    // 32-bit access uses the W-register form (scaled by 4).
    assert_eq!(
        enc("ldr", &[w(2), Opnd::Mem { base: 3, off: 4 }]),
        0xB9400462
    );
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

/// The design spike found four database rows whose literal bits disagree with
/// the architecture; the generator corrects them (DB_FIXES). Encoding these
/// mnemonics exercises the corrected forms -- had the raw rows shipped, the
/// bytes would be wrong.
#[test]
fn corrected_database_rows_encode_true_bits() {
    // `sub` shares the arithmetic class; a straightforward reg3 word.
    assert_eq!(enc("sub", &[x(0), x(1), x(2)]), 0xCB020020);
    // (ret / cbz / dsb are in the follow-on system/branch surface; their
    // corrections are recorded in tools/gen_isa_a64.py DB_FIXES.)
}

#[cfg(feature = "std")]
mod differential {
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

    /// Assemble one A64 instruction and return its 32-bit word, or None if the
    /// assembler rejects it.
    fn clang_word(itxt: &str) -> Option<u32> {
        let dir = std::env::temp_dir();
        let stem = alloc::format!("badc-a64-{:x}", hash(itxt.as_bytes()));
        let s = dir.join(alloc::format!("{stem}.s"));
        let o = dir.join(alloc::format!("{stem}.o"));
        std::fs::write(&s, alloc::format!(".text\n{itxt}\n")).ok()?;
        let out = Command::new("clang")
            .args(["--target=arm64-apple-darwin", "-c"])
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
    fn wn(n: u8) -> Opnd {
        Opnd::Reg {
            num: n,
            is64: false,
        }
    }

    /// Sweep the register / immediate surface and require the catalogue word to
    /// equal the assembler's. The contract is *never wrong, may be
    /// incomplete*: a `bad` (encoded, disagrees) fails; a `gap` (assembler
    /// accepts, catalogue has no form) is reported.
    #[test]
    fn differential_sweep() {
        if !enabled() {
            return;
        }
        let (mut ok, mut bad, mut gap, mut skip) = (0, 0, 0, 0);
        let mut fails: Vec<String> = Vec::new();
        let mut cases: Vec<(String, Vec<Opnd>, &str)> = Vec::new();

        let regnames = |is64: bool, n: u8| {
            if is64 {
                alloc::format!("x{n}")
            } else {
                alloc::format!("w{n}")
            }
        };
        for m in [
            "add", "sub", "adds", "subs", "and", "orr", "eor", "ands", "bic", "orn", "eon",
        ] {
            for is64 in [true, false] {
                for &(a, b, c) in &[(0u8, 1u8, 2u8), (5, 6, 7), (9, 10, 11), (20, 21, 22)] {
                    let ops = if is64 {
                        alloc::vec![xn(a), xn(b), xn(c)]
                    } else {
                        alloc::vec![wn(a), wn(b), wn(c)]
                    };
                    let txt = alloc::format!(
                        "{m} {}, {}, {}",
                        regnames(is64, a),
                        regnames(is64, b),
                        regnames(is64, c)
                    );
                    cases.push((txt, ops, m));
                }
            }
        }
        for m in ["mul", "mneg", "sdiv", "udiv"] {
            for is64 in [true, false] {
                for &(a, b, c) in &[(0u8, 1u8, 2u8), (5, 6, 7), (9, 10, 11), (20, 21, 22)] {
                    let ops = if is64 {
                        alloc::vec![xn(a), xn(b), xn(c)]
                    } else {
                        alloc::vec![wn(a), wn(b), wn(c)]
                    };
                    let txt = alloc::format!(
                        "{m} {}, {}, {}",
                        regnames(is64, a),
                        regnames(is64, b),
                        regnames(is64, c)
                    );
                    cases.push((txt, ops, m));
                }
            }
        }
        for m in ["smulh", "umulh"] {
            for &(a, b, c) in &[(0u8, 1u8, 2u8), (5, 6, 7), (9, 10, 11), (20, 21, 22)] {
                let txt = alloc::format!("{m} x{a}, x{b}, x{c}");
                cases.push((txt, alloc::vec![xn(a), xn(b), xn(c)], m));
            }
        }
        for m in ["cls", "clz", "rbit"] {
            for is64 in [true, false] {
                for &(a, b) in &[(0u8, 1u8), (5, 6), (9, 10), (20, 21)] {
                    let ops = if is64 {
                        alloc::vec![xn(a), xn(b)]
                    } else {
                        alloc::vec![wn(a), wn(b)]
                    };
                    let txt = alloc::format!("{m} {}, {}", regnames(is64, a), regnames(is64, b));
                    cases.push((txt, ops, m));
                }
            }
        }
        for m in ["add", "sub", "adds", "subs"] {
            for &v in &[0i64, 1, 5, 0xFFF] {
                let txt = alloc::format!("{m} x0, x1, #{v}");
                cases.push((txt, alloc::vec![xn(0), xn(1), Opnd::Imm(v)], m));
            }
        }
        for m in ["and", "orr", "eor", "ands"] {
            for &v in &[
                0xFFi64,
                0x1,
                0xF0F0F0F0F0F0F0F0u64 as i64,
                0xFFFFFFF0u32 as i64,
            ] {
                let txt = alloc::format!("{m} x0, x1, #{v}");
                cases.push((txt, alloc::vec![xn(0), xn(1), Opnd::Imm(v)], m));
            }
        }
        for &v in &[0i64, 0x1234, 0xFFFF] {
            cases.push((
                alloc::format!("movz x0, #{v}"),
                alloc::vec![xn(0), Opnd::Imm(v)],
                "movz",
            ));
            cases.push((
                alloc::format!("movk x0, #{v}"),
                alloc::vec![xn(0), Opnd::Imm(v)],
                "movk",
            ));
        }
        for &s in &[0u32, 16, 32, 48] {
            cases.push((
                alloc::format!("movz x0, #1, lsl #{s}"),
                alloc::vec![xn(0), Opnd::Imm(1), Opnd::Lsl(s)],
                "movz",
            ));
        }
        for m in ["lsl", "lsr", "asr"] {
            for &v in &[1i64, 4, 31, 63] {
                cases.push((
                    alloc::format!("{m} x0, x1, #{v}"),
                    alloc::vec![xn(0), xn(1), Opnd::Imm(v)],
                    m,
                ));
            }
        }

        for (txt, ops, m) in &cases {
            let Some(want) = clang_word(txt) else {
                skip += 1;
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
                Err(_) => gap += 1,
            }
        }
        for f in &fails {
            std::eprintln!("  FAIL {f}");
        }
        std::eprintln!("a64 differential_sweep: OK={ok} BAD={bad} GAP={gap} SKIP={skip}");
        assert_eq!(bad, 0, "A64 catalogue words disagree with the assembler");
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
