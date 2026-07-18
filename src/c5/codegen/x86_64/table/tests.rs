//! Tests for the table-driven x86-64 encoder.
//!
//! The golden cases run everywhere and lock exact encodings. The differential
//! sweep and the seeded fuzzer cross-check the catalogue against the system
//! assembler; both are gated on `BADC_FUZZ_ASM=1` and the presence of
//! `clang` + `objdump`, so a bare `cargo test` skips them.

use super::*;

fn enc(mnem: &str, ops: &[Opnd]) -> Vec<u8> {
    encode(mnem, None, ops).unwrap_or_else(|e| panic!("{mnem}: {e}"))
}

fn r(num: u8, width: u8) -> Opnd {
    Opnd::Reg { num, width }
}
fn m(base: u8, width: u8) -> Opnd {
    Opnd::Mem { base, width }
}

#[test]
fn alu_reg_reg_widths() {
    // add: 8/16/32/64-bit register-to-register, low and high registers.
    assert_eq!(enc("add", &[r(0, 1), r(3, 1)]), [0x00, 0xd8]); // add al, bl
    assert_eq!(enc("add", &[r(0, 2), r(3, 2)]), [0x66, 0x01, 0xd8]); // add ax, bx
    assert_eq!(enc("add", &[r(0, 4), r(3, 4)]), [0x01, 0xd8]); // add eax, ebx
    assert_eq!(enc("add", &[r(0, 8), r(3, 8)]), [0x48, 0x01, 0xd8]); // add rax, rbx
    assert_eq!(enc("add", &[r(0, 8), r(8, 8)]), [0x4c, 0x01, 0xc0]); // add rax, r8
    assert_eq!(enc("add", &[r(8, 8), r(0, 8)]), [0x49, 0x01, 0xc0]); // add r8, rax
    // the byte-register REX for sil/dil.
    assert_eq!(enc("add", &[r(6, 1), r(7, 1)]), [0x40, 0x00, 0xfe]); // add sil, dil
}

#[test]
fn alu_reg_mem_and_imm() {
    // load / store direction picks 03 (RM) vs 01 (MR).
    assert_eq!(enc("add", &[r(0, 8), m(6, 8)]), [0x48, 0x03, 0x06]); // add rax, [rsi]
    assert_eq!(enc("add", &[m(6, 8), r(0, 8)]), [0x48, 0x01, 0x06]); // add [rsi], rax
    // imm8 sign-extended form (83 /0) vs imm32 form (81 /0) by value range.
    assert_eq!(
        enc("add", &[r(0, 8), Opnd::Imm(7)]),
        [0x48, 0x83, 0xc0, 0x07]
    );
    // rax + imm32: the accumulator form (05 id, 6 bytes) is shorter than the
    // 81 /0 id form (7 bytes), so shortest-wins picks it (as the assembler does).
    assert_eq!(
        enc("add", &[r(0, 8), Opnd::Imm(0x1234)]),
        [0x48, 0x05, 0x34, 0x12, 0x00, 0x00]
    );
    // a non-accumulator destination has no short form: 81 /0 id.
    assert_eq!(
        enc("add", &[r(3, 8), Opnd::Imm(0x1234)]),
        [0x48, 0x81, 0xc3, 0x34, 0x12, 0x00, 0x00]
    );
    // sub uses /5; the extension digit rides ModRM.reg.
    assert_eq!(enc("sub", &[r(1, 4), Opnd::Imm(3)]), [0x83, 0xe9, 0x03]); // sub ecx, 3
}

#[test]
fn shifts_and_unary() {
    // shl r/m, imm8 (C1 /4); shl r/m, 1 (D1 /4); shl r/m, cl (D3 /4).
    assert_eq!(
        enc("shl", &[r(0, 8), Opnd::Imm(3)]),
        [0x48, 0xc1, 0xe0, 0x03]
    );
    assert_eq!(enc("shl", &[r(0, 8), r(1, 1)]), [0x48, 0xd3, 0xe0]); // shl rax, cl
    assert_eq!(enc("neg", &[r(2, 4)]), [0xf7, 0xda]); // neg edx
    assert_eq!(enc("bswap", &[r(0, 8)]), [0x48, 0x0f, 0xc8]); // bswap rax
    assert_eq!(enc("bswap", &[r(8, 4)]), [0x41, 0x0f, 0xc8]); // bswap r8d
}

#[test]
fn atomics_and_system() {
    // xadd / cmpxchg into memory (the lock prefix is emitted separately).
    assert_eq!(enc("xadd", &[m(7, 8), r(0, 8)]), [0x48, 0x0f, 0xc1, 0x07]);
    assert_eq!(enc("cmpxchg", &[m(7, 4), r(1, 4)]), [0x0f, 0xb1, 0x0f]);
    // nullary system ops.
    assert_eq!(enc("rdtsc", &[]), [0x0f, 0x31]);
    assert_eq!(enc("rdtscp", &[]), [0x0f, 0x01, 0xf9]);
    assert_eq!(enc("cli", &[]), [0xfa]);
    assert_eq!(enc("hlt", &[]), [0xf4]);
    assert_eq!(enc("cpuid", &[]), [0x0f, 0xa2]);
}

#[test]
fn double_precision_and_ext_moves() {
    // movzx / movsx keep the source and destination widths distinct.
    assert_eq!(enc("movzx", &[r(1, 8), m(2, 1)]), [0x48, 0x0f, 0xb6, 0x0a]); // movzx rcx, byte [rdx]
    assert_eq!(enc("movsxd", &[r(0, 8), r(1, 4)]), [0x48, 0x63, 0xc1]); // movsxd rax, ecx
}

#[test]
fn setcc_byte_forms() {
    // 0F 90+cc /0 with an r/m8 operand; the reg field is a zero extension.
    // High byte registers (sil, r10b) take the REX / REX.B prefix, verified
    // byte-identical to the assembler.
    assert_eq!(enc("sete", &[r(0, 1)]), [0x0f, 0x94, 0xc0]); // sete al
    assert_eq!(enc("setne", &[r(3, 1)]), [0x0f, 0x95, 0xc3]); // setne bl
    assert_eq!(enc("setl", &[r(1, 1)]), [0x0f, 0x9c, 0xc1]); // setl cl
    assert_eq!(enc("setg", &[r(2, 1)]), [0x0f, 0x9f, 0xc2]); // setg dl
    assert_eq!(enc("seta", &[r(6, 1)]), [0x40, 0x0f, 0x97, 0xc6]); // seta sil
    assert_eq!(enc("setbe", &[r(10, 1)]), [0x41, 0x0f, 0x96, 0xc2]); // setbe r10b
    // An alias spelling encodes identically to its canonical form.
    assert_eq!(enc("setz", &[r(0, 1)]), enc("sete", &[r(0, 1)]));
    assert_eq!(enc("setnge", &[r(0, 1)]), enc("setl", &[r(0, 1)]));
}

#[test]
fn cmov_forms() {
    // 0F 40+cc /r: reg is the destination, r/m the source, width from the
    // operands. Verified byte-identical to the assembler.
    assert_eq!(enc("cmove", &[r(0, 8), r(6, 8)]), [0x48, 0x0f, 0x44, 0xc6]); // cmove rax, rsi
    assert_eq!(enc("cmovl", &[r(2, 4), r(1, 4)]), [0x0f, 0x4c, 0xd1]); // cmovl edx, ecx
    assert_eq!(enc("cmovg", &[r(9, 8), r(8, 8)]), [0x4d, 0x0f, 0x4f, 0xc8]); // cmovg r9, r8
    // Alias spellings match their canonical condition.
    assert_eq!(
        enc("cmovnle", &[r(0, 8), r(1, 8)]),
        enc("cmovg", &[r(0, 8), r(1, 8)])
    );
    assert_eq!(
        enc("cmovz", &[r(0, 8), r(1, 8)]),
        enc("cmove", &[r(0, 8), r(1, 8)])
    );
}

#[test]
fn accumulator_extend_and_fences() {
    // Accumulator sign-extends: the 64-bit forms carry REX.W on a nullary
    // opcode. AT&T spellings alias the Intel ones.
    assert_eq!(enc("cwde", &[]), [0x98]);
    assert_eq!(enc("cdqe", &[]), [0x48, 0x98]);
    assert_eq!(enc("cdq", &[]), [0x99]);
    assert_eq!(enc("cqo", &[]), [0x48, 0x99]);
    assert_eq!(enc("cltq", &[]), enc("cdqe", &[]));
    assert_eq!(enc("cqto", &[]), enc("cqo", &[]));
    // Fences carry their full second opcode byte.
    assert_eq!(enc("lfence", &[]), [0x0f, 0xae, 0xe8]);
    assert_eq!(enc("mfence", &[]), [0x0f, 0xae, 0xf0]);
    assert_eq!(enc("sfence", &[]), [0x0f, 0xae, 0xf8]);
}

// ------------------------------------------------------------------
// Differential + fuzz harness against the system assembler.
// ------------------------------------------------------------------

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

    const REG64: &[&str] = &[
        "rax", "rcx", "rdx", "rbx", "rsp", "rbp", "rsi", "rdi", "r8", "r9", "r10", "r11", "r12",
        "r13", "r14", "r15",
    ];
    const REG32: &[&str] = &[
        "eax", "ecx", "edx", "ebx", "esp", "ebp", "esi", "edi", "r8d", "r9d", "r10d", "r11d",
        "r12d", "r13d", "r14d", "r15d",
    ];
    const REG16: &[&str] = &[
        "ax", "cx", "dx", "bx", "sp", "bp", "si", "di", "r8w", "r9w", "r10w", "r11w", "r12w",
        "r13w", "r14w", "r15w",
    ];
    const REG8: &[&str] = &[
        "al", "cl", "dl", "bl", "spl", "bpl", "sil", "dil", "r8b", "r9b", "r10b", "r11b", "r12b",
        "r13b", "r14b", "r15b",
    ];

    fn rname(num: u8, width: u8) -> &'static str {
        match width {
            1 => REG8[num as usize],
            2 => REG16[num as usize],
            4 => REG32[num as usize],
            _ => REG64[num as usize],
        }
    }

    fn intel(mnem: &str, ops: &[Opnd]) -> String {
        let mut parts = Vec::new();
        for o in ops {
            parts.push(match *o {
                Opnd::Reg { num, width } => String::from(rname(num, width)),
                Opnd::Mem { base, width } => {
                    let sz = match width {
                        1 => "byte",
                        2 => "word",
                        4 => "dword",
                        _ => "qword",
                    };
                    alloc::format!("{sz} ptr [{}]", REG64[base as usize])
                }
                Opnd::Imm(v) => alloc::format!("{v}"),
            });
        }
        if parts.is_empty() {
            String::from(mnem)
        } else {
            alloc::format!("{mnem} {}", parts.join(", "))
        }
    }

    /// Run objdump on a `.byte` blob and return the single normalized
    /// (mnemonic, operands) it decodes to, or an error string.
    fn disasm(bytes: &[u8]) -> Result<(String, Vec<String>), String> {
        let dir = std::env::temp_dir();
        let stem = alloc::format!("badc-asm-{}", bytes_hash(bytes));
        let s = dir.join(alloc::format!("{stem}.s"));
        let o = dir.join(alloc::format!("{stem}.o"));
        let src = alloc::format!(
            ".text\n.byte {}\n",
            bytes
                .iter()
                .map(|b| alloc::format!("0x{b:02x}"))
                .collect::<Vec<_>>()
                .join(",")
        );
        std::fs::write(&s, src).map_err(|e| e.to_string())?;
        let out = Command::new("clang")
            .args(["--target=x86_64-linux-gnu", "-c"])
            .arg(&s)
            .arg("-o")
            .arg(&o)
            .output()
            .map_err(|e| e.to_string())?;
        if !out.status.success() {
            let _ = std::fs::remove_file(&s);
            return Err(String::from("assemble failed"));
        }
        let dis = Command::new("objdump")
            .args(["-d", "--no-show-raw-insn"])
            .arg(&o)
            .output()
            .map_err(|e| e.to_string())?;
        let _ = std::fs::remove_file(&s);
        let _ = std::fs::remove_file(&o);
        let text = String::from_utf8_lossy(&dis.stdout);
        let mut insns: Vec<_> = text.lines().filter_map(insn_body).map(normalize).collect();
        match insns.len() {
            1 => Ok(insns.pop().unwrap()),
            n => Err(alloc::format!("decoded to {n} instructions")),
        }
    }

    /// An objdump disassembly line begins with a whitespace-indented hex
    /// address followed by `:` then a tab. The file-format header
    /// (`obj.o:\tfile format ...`) also ends in `:` before a tab but has no
    /// leading indent and a non-hex label, so require both.
    fn insn_body(line: &str) -> Option<&str> {
        let tab = line.find('\t')?;
        let before = &line[..tab];
        if !before.starts_with(char::is_whitespace) {
            return None;
        }
        let addr = before.trim().strip_suffix(':')?;
        if addr.is_empty() || !addr.bytes().all(|b| b.is_ascii_hexdigit()) {
            return None;
        }
        Some(&line[tab + 1..])
    }

    fn bytes_hash(b: &[u8]) -> u64 {
        // A stable non-crypto hash so concurrent cases use distinct temp files.
        let mut h = 0xcbf29ce484222325u64;
        for &x in b {
            h = (h ^ x as u64).wrapping_mul(0x100000001b3);
        }
        h
    }

    /// Normalize an AT&T disassembly to (base-mnemonic, operand tokens) with
    /// size suffixes, immediate spelling, and `%`/`movabs`/`nop` aliasing
    /// folded out, so a legal-but-different form choice does not read as a
    /// mismatch.
    fn normalize(dis: &str) -> (String, Vec<String>) {
        let dis = dis.split('#').next().unwrap_or("").trim();
        let mut it = dis.splitn(2, char::is_whitespace);
        let mut mn = it.next().unwrap_or("").to_string();
        let rest = it.next().unwrap_or("").trim();
        if mn == "movabs" {
            mn = String::from("mov");
        }
        if mn == "nop" || mn == "xchg" {
            // xchg eax,eax and its width variants alias to nop; fold both.
            if rest.is_empty() || rest.contains("ax,%") {
                return (String::from("nop"), Vec::new());
            }
        }
        // Drop a trailing AT&T size suffix (addq -> add) but keep movzbq-style
        // compound mnemonics distinct.
        if !matches!(mn.as_str(), "call" | "jmp")
            && mn.len() > 3
            && mn.ends_with(['b', 'w', 'l', 'q'])
            && !mn.starts_with("movz")
            && !mn.starts_with("movs")
        {
            mn.pop();
        }
        let mut ops = Vec::new();
        if !rest.is_empty() {
            for o in rest.split(',') {
                let o = o.trim();
                if o.starts_with('$') {
                    ops.push(String::from("IMM"));
                } else {
                    ops.push(o.replace('%', ""));
                }
            }
        }
        (mn, ops)
    }

    fn clang_intent(itxt: &str) -> Option<(String, Vec<String>)> {
        let dir = std::env::temp_dir();
        let stem = alloc::format!("badc-int-{:x}", bytes_hash(itxt.as_bytes()));
        let s = dir.join(alloc::format!("{stem}.s"));
        let o = dir.join(alloc::format!("{stem}.o"));
        std::fs::write(
            &s,
            alloc::format!(".intel_syntax noprefix\n.text\n{itxt}\n"),
        )
        .ok()?;
        let out = Command::new("clang")
            .args(["--target=x86_64-linux-gnu", "-c"])
            .arg(&s)
            .arg("-o")
            .arg(&o)
            .output()
            .ok()?;
        if !out.status.success() {
            if std::env::var("BADC_FUZZ_DEBUG").is_ok() {
                std::eprintln!(
                    "intent asm fail [{itxt}]: {}",
                    String::from_utf8_lossy(&out.stderr)
                );
            }
            let _ = std::fs::remove_file(&s);
            return None;
        }
        let dis = Command::new("objdump")
            .args(["-d", "--no-show-raw-insn"])
            .arg(&o)
            .output()
            .ok()?;
        let _ = std::fs::remove_file(&s);
        let _ = std::fs::remove_file(&o);
        let text = String::from_utf8_lossy(&dis.stdout);
        let mut insns: Vec<_> = text.lines().filter_map(insn_body).map(normalize).collect();
        (insns.len() == 1).then(|| insns.pop().unwrap())
    }

    /// Outcome tallies of a differential run. The contract is *never wrong,
    /// may be incomplete*: `bad` (the encoder produced bytes that decode to a
    /// different instruction than intended) is the hard failure; `gap` (the
    /// assembler accepts the instruction but the catalogue has no form for it)
    /// is reported, not fatal; `skip` is a case the assembler itself rejects.
    struct Tally {
        ok: usize,
        bad: usize,
        gap: usize,
        skip: usize,
        fails: Vec<String>,
        gaps: Vec<String>,
    }

    /// Assemble each case's intent, encode it through the table, disassemble
    /// the result, and require the two decode to the same instruction.
    fn check(cases: &[(&str, Vec<Opnd>)]) -> Tally {
        let mut t = Tally {
            ok: 0,
            bad: 0,
            gap: 0,
            skip: 0,
            fails: Vec::new(),
            gaps: Vec::new(),
        };
        for (mnem, ops) in cases {
            let itxt = intel(mnem, ops);
            let Some(intent) = clang_intent(&itxt) else {
                t.skip += 1;
                continue;
            };
            match encode(mnem, None, ops) {
                Ok(bytes) => match disasm(&bytes) {
                    Ok(got) if got == intent => t.ok += 1,
                    Ok(got) => {
                        t.bad += 1;
                        if t.fails.len() < 40 {
                            t.fails.push(alloc::format!(
                                "{itxt}: got {got:?} want {intent:?} bytes={}",
                                hex(&bytes)
                            ));
                        }
                    }
                    Err(e) => {
                        t.bad += 1;
                        t.fails
                            .push(alloc::format!("{itxt}: disasm {e} bytes={}", hex(&bytes)));
                    }
                },
                Err(_) => {
                    t.gap += 1;
                    if t.gaps.len() < 20 {
                        t.gaps.push(itxt);
                    }
                }
            }
        }
        t
    }

    fn hex(b: &[u8]) -> String {
        b.iter().map(|x| alloc::format!("{x:02x}")).collect()
    }

    fn r(num: u8, width: u8) -> Opnd {
        Opnd::Reg { num, width }
    }
    fn m(base: u8, width: u8) -> Opnd {
        Opnd::Mem { base, width }
    }

    fn sweep_cases() -> Vec<(&'static str, Vec<Opnd>)> {
        let mut cases: Vec<(&'static str, Vec<Opnd>)> = Vec::new();
        let alu = ["add", "sub", "and", "or", "xor", "cmp", "adc", "sbb", "mov"];
        let widths = [1u8, 2, 4, 8];
        let regs = [0u8, 3, 8, 15];
        for mnem in alu {
            for &w in &widths {
                for &a in &regs {
                    for &b in &[3u8, 8] {
                        cases.push((mnem, vec![r(a, w), r(b, w)]));
                    }
                    cases.push((mnem, vec![r(a, w), m(6, w)]));
                    cases.push((mnem, vec![m(6, w), r(a, w)]));
                    cases.push((mnem, vec![r(a, w), Opnd::Imm(7)]));
                    cases.push((mnem, vec![r(a, w), Opnd::Imm(0x1234)]));
                }
            }
        }
        for mnem in ["inc", "dec", "neg", "not", "mul", "imul", "div", "idiv"] {
            for &w in &widths {
                for &a in &[0u8, 8] {
                    cases.push((mnem, vec![r(a, w)]));
                }
            }
        }
        // setcc: one r/m8 operand, canonical and alias spellings; the high
        // registers exercise the REX-prefix path (sil/dil, r8b..r15b).
        for mnem in [
            "seto", "setno", "setb", "setnb", "setz", "setnz", "setbe", "setnbe", "sets", "setns",
            "setp", "setnp", "setl", "setnl", "setle", "setnle", "sete", "setne", "seta", "setae",
            "setg", "setge", "setc", "setnc",
        ] {
            for &a in &[0u8, 3, 4, 8, 15] {
                cases.push((mnem, vec![r(a, 1)]));
            }
            cases.push((mnem, vec![m(6, 1)]));
        }
        // cmovcc: reg, r/m of width 16/32/64.
        for mnem in [
            "cmovo", "cmovno", "cmovb", "cmovnb", "cmovz", "cmovnz", "cmovbe", "cmovnbe", "cmovs",
            "cmovns", "cmovp", "cmovnp", "cmovl", "cmovnl", "cmovle", "cmovnle", "cmove", "cmovne",
            "cmova", "cmovg",
        ] {
            for &w in &[2u8, 4, 8] {
                for &a in &[0u8, 8] {
                    cases.push((mnem, vec![r(a, w), r(3, w)]));
                    cases.push((mnem, vec![r(a, w), m(6, w)]));
                }
            }
        }
        for mnem in ["shl", "shr", "sar", "rol", "ror"] {
            for &w in &widths {
                for &a in &[0u8, 8] {
                    cases.push((mnem, vec![r(a, w), Opnd::Imm(3)]));
                    cases.push((mnem, vec![r(a, w), r(1, 1)])); // , cl
                }
            }
        }
        for &w in &[4u8, 8] {
            for &a in &[0u8, 8] {
                cases.push(("bswap", vec![r(a, w)]));
                cases.push(("xadd", vec![m(6, w), r(a, w)]));
                cases.push(("cmpxchg", vec![m(6, w), r(a, w)]));
            }
        }
        for mnem in [
            "rdtsc", "rdtscp", "cpuid", "cli", "sti", "hlt", "nop", "cwde", "cdqe", "cdq", "cqo",
            "lfence", "mfence", "sfence",
        ] {
            cases.push((mnem, vec![]));
        }
        cases
    }

    #[test]
    fn differential_sweep() {
        if !enabled() {
            return;
        }
        let t = check(&sweep_cases());
        for f in &t.fails {
            std::eprintln!("  FAIL {f}");
        }
        std::eprintln!(
            "differential_sweep: OK={} BAD={} GAP={} SKIP={}",
            t.ok,
            t.bad,
            t.gap,
            t.skip
        );
        // The hand-built sweep is well-typed, so it must be complete as well as
        // correct.
        assert_eq!(t.bad, 0, "table encodings disagree with the assembler");
        assert_eq!(
            t.gap, 0,
            "sweep case not covered by the catalogue: {:?}",
            t.gaps
        );
    }

    /// Seeded deterministic fuzzer: draw random operands for each catalogue
    /// mnemonic and cross-check the encoding against the assembler.
    #[test]
    fn seeded_fuzz() {
        if !enabled() {
            return;
        }
        let mut st = 0x0123_4567_89ab_cdefu64;
        let mut next = || {
            st ^= st << 13;
            st ^= st >> 7;
            st ^= st << 17;
            st
        };
        let widths = [1u8, 2, 4, 8];
        let mut cases: Vec<(&'static str, Vec<Opnd>)> = Vec::new();
        let mnems = [
            "add", "sub", "and", "or", "xor", "cmp", "adc", "sbb", "mov", "test", "shl", "shr",
            "sar", "rol", "ror", "inc", "dec", "neg", "not", "bswap", "xadd", "cmpxchg", "movzx",
            "movsx",
        ];
        for _ in 0..2000 {
            let mnem = mnems[(next() as usize) % mnems.len()];
            let w = widths[(next() as usize) % widths.len()];
            let a = (next() as u8) & 15;
            let shape = next() % 4;
            let ops = match mnem {
                "inc" | "dec" | "neg" | "not" | "bswap" => vec![r(a, w.max(4))],
                "movzx" | "movsx" => vec![r(a, 8), r((next() as u8) & 15, 1)],
                "xadd" | "cmpxchg" => vec![m((next() as u8) & 15, w), r(a, w)],
                _ => match shape {
                    0 => vec![r(a, w), r((next() as u8) & 15, w)],
                    1 => vec![r(a, w), Opnd::Imm((next() as i32 % 200) as i64)],
                    2 => vec![r(a, w), m((next() as u8) & 15, w)],
                    _ => vec![m((next() as u8) & 15, w), r(a, w)],
                },
            };
            cases.push((mnem, ops));
        }
        let t = check(&cases);
        for f in t.fails.iter().take(30) {
            std::eprintln!("  FUZZ FAIL {f}");
        }
        std::eprintln!(
            "seeded_fuzz: OK={} BAD={} GAP={} SKIP={} (gaps e.g. {:?})",
            t.ok,
            t.bad,
            t.gap,
            t.skip,
            t.gaps.iter().take(3).collect::<Vec<_>>()
        );
        // Wrong bytes are the hard failure; a gap (a valid form the catalogue
        // does not yet cover) is reported but tolerated by the fuzzer.
        assert_eq!(
            t.bad, 0,
            "fuzzed table encodings disagree with the assembler"
        );
    }
}
