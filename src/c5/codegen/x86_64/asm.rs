//! GCC extended inline-asm (x86_64): template parsing and instruction
//! encoding.
//!
//! [`parse_template`] turns an AT&T template into a sequence of
//! [`AsmInsn`]s with symbolic operand references (`%N`), explicit
//! registers (`%%reg`), and immediates (`$imm`). The emitter
//! ([`super::emit`]) resolves each reference to a machine register per
//! the operand constraint, builds a [`Concrete`] operand list, and
//! calls [`encode`]. The SSA interpreter reuses the same parse to
//! evaluate the semantics, so both paths agree on operand order and
//! width.
//!
//! The mnemonic catalogue is deliberately small: the register-operand
//! instructions C code reaches through extended asm (double-precision
//! shifts, byte-swap, the timestamp-counter read sequence, the shift /
//! or used to assemble a 64-bit value, and the `in` / `out` port I/O a
//! firmware hardware-access layer needs). Adding an instruction is one
//! arm in [`encode`] and one in the interpreter -- the standard
//! per-mnemonic assembler table, not per-call special casing.

use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use super::super::super::ir::AsmRegSize;

/// Base mnemonic of a template instruction (AT&T size suffix folded
/// out into [`AsmInsn::suffix`]).
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum Mnemonic {
    Shld,
    Shrd,
    Shl,
    Shr,
    Sar,
    Or,
    And,
    Add,
    Sub,
    Xor,
    Mov,
    Bswap,
    Rdtscp,
    Rdtsc,
    Nop,
    /// Port input `in al/ax/eax, dx` (variable-port form). The
    /// accumulator and DX are implicit; the operands' `a`/`d`
    /// constraints tie the values there.
    In,
    /// Port output `out dx, al/ax/eax` (variable-port form).
    Out,
    /// Software interrupt `int $imm` (int3 breakpoint is `int $3`).
    Int,
    /// Spin-loop hint `pause`.
    Pause,
    /// Push the 64-bit RFLAGS, `pushfq`.
    Pushfq,
    /// Pop a 64-bit register, `pop reg`.
    Pop,
    /// `movd` between an MMX register and a GPR / memory (no operand-size
    /// prefix -- the 0x66-prefixed form is the XMM variant).
    Movd,
}

/// One symbolic operand of a template instruction.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum AsmOpnd {
    /// `%N` / `%<size>N`: operand N of the asm statement, at the named
    /// register-name size (or the operand's own width when unmodified).
    Ref { idx: u8, size: Option<AsmRegSize> },
    /// `%%reg`: an explicit register named in the template.
    Reg { reg: u8, size: AsmRegSize },
    /// `$imm`: a literal immediate.
    Imm(i64),
}

/// One instruction of a parsed template, in AT&T operand order.
#[derive(Debug, Clone)]
pub(crate) struct AsmInsn {
    pub mnemonic: Mnemonic,
    pub suffix: Option<AsmRegSize>,
    pub operands: Vec<AsmOpnd>,
}

/// A resolved operand: a concrete register (with its access size) or an
/// immediate. Produced by the emitter / interpreter from an [`AsmOpnd`]
/// once the operand's register assignment (or constant value) is known.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum Concrete {
    Reg { reg: u8, size: AsmRegSize },
    Imm(i64),
}

/// Map an AT&T register name (without the `%` prefix) to its
/// architectural number and access size. Covers the 8/16/32/64-bit
/// names for the 16 GPRs.
pub(crate) fn reg_by_name(name: &str) -> Option<(u8, AsmRegSize)> {
    use AsmRegSize::*;
    let n = name;
    // 64-bit.
    let q = [
        "rax", "rcx", "rdx", "rbx", "rsp", "rbp", "rsi", "rdi", "r8", "r9", "r10", "r11", "r12",
        "r13", "r14", "r15",
    ];
    if let Some(i) = q.iter().position(|&r| r == n) {
        return Some((i as u8, Quad));
    }
    // 32-bit.
    let d = [
        "eax", "ecx", "edx", "ebx", "esp", "ebp", "esi", "edi", "r8d", "r9d", "r10d", "r11d",
        "r12d", "r13d", "r14d", "r15d",
    ];
    if let Some(i) = d.iter().position(|&r| r == n) {
        return Some((i as u8, Long));
    }
    // 16-bit.
    let w = [
        "ax", "cx", "dx", "bx", "sp", "bp", "si", "di", "r8w", "r9w", "r10w", "r11w", "r12w",
        "r13w", "r14w", "r15w",
    ];
    if let Some(i) = w.iter().position(|&r| r == n) {
        return Some((i as u8, Word));
    }
    // 8-bit (low byte; REX-form names for rsp/rbp/rsi/rdi).
    let b = [
        "al", "cl", "dl", "bl", "spl", "bpl", "sil", "dil", "r8b", "r9b", "r10b", "r11b", "r12b",
        "r13b", "r14b", "r15b",
    ];
    if let Some(i) = b.iter().position(|&r| r == n) {
        return Some((i as u8, Byte));
    }
    // MMX registers mm0..mm7. Marked with register numbers 16..24 so they
    // never collide with the 0..16 GPRs; only `movd` reads them, masking
    // the mark back to the 0..8 ModRM.reg field.
    if let Some(rest) = n.strip_prefix("mm")
        && let Ok(i) = rest.parse::<u8>()
        && i < 8
    {
        return Some((16 + i, Quad));
    }
    None
}

/// The register number a `reg_by_name` result carries for `mm0`; MMX
/// registers occupy `MMX_BASE..MMX_BASE+8`.
const MMX_BASE: u8 = 16;

/// Assign an x86 register number to each register operand of an
/// extended-asm statement, per its constraint. Returns a vector
/// parallel to `operands`: `Some(reg)` for a register operand, `None`
/// for a pure immediate. Fixed and matching constraints take their
/// required register; `r` operands take free registers from a fixed
/// pool (never r10 / r11, which the emitter reserves as bridge scratch,
/// nor rsp / rbp). Shared by the emitter and the interpreter so both
/// resolve the template's `%N` references to the same registers.
pub(crate) fn assign_operand_regs(
    operands: &[crate::c5::ir::AsmOperand],
) -> Result<Vec<Option<u8>>, String> {
    use crate::c5::ir::AsmConstraint as C;
    let mut assigned: Vec<Option<u8>> = alloc::vec![None; operands.len()];
    let mut used = [false; 16];
    // Fixed / register-or-immediate operands take their named register.
    for (i, op) in operands.iter().enumerate() {
        if let C::Fixed(r) | C::RegOrImm(r) = op.constraint {
            assigned[i] = Some(r);
            used[r as usize] = true;
        }
    }
    // `r` operands take free pool registers (rax rbx rcx rdx rsi rdi r8 r9).
    let pool = [0u8, 3, 1, 2, 6, 7, 8, 9];
    for (i, op) in operands.iter().enumerate() {
        if matches!(op.constraint, C::Reg) {
            let r = pool
                .iter()
                .copied()
                .find(|&r| !used[r as usize])
                .ok_or_else(|| String::from("inline asm: out of registers for operands"))?;
            used[r as usize] = true;
            assigned[i] = Some(r);
        }
    }
    // Matching constraints alias the register of the operand they name
    // (an earlier output, already assigned above).
    for i in 0..operands.len() {
        if let C::Match(n) = operands[i].constraint {
            let r = assigned.get(n as usize).copied().flatten().ok_or_else(|| {
                String::from("inline asm: matching constraint on a non-register operand")
            })?;
            assigned[i] = Some(r);
        }
    }
    Ok(assigned)
}

/// Known base mnemonic for a template token, if any.
fn mnemonic_by_name(name: &str) -> Option<Mnemonic> {
    Some(match name {
        "shld" => Mnemonic::Shld,
        "shrd" => Mnemonic::Shrd,
        "shl" | "sal" => Mnemonic::Shl,
        "shr" => Mnemonic::Shr,
        "sar" => Mnemonic::Sar,
        "or" => Mnemonic::Or,
        "and" => Mnemonic::And,
        "add" => Mnemonic::Add,
        "sub" => Mnemonic::Sub,
        "xor" => Mnemonic::Xor,
        "mov" => Mnemonic::Mov,
        "bswap" => Mnemonic::Bswap,
        "rdtscp" => Mnemonic::Rdtscp,
        "rdtsc" => Mnemonic::Rdtsc,
        "nop" => Mnemonic::Nop,
        "in" => Mnemonic::In,
        "out" => Mnemonic::Out,
        "int" => Mnemonic::Int,
        "pause" => Mnemonic::Pause,
        "pushfq" => Mnemonic::Pushfq,
        "pop" => Mnemonic::Pop,
        "movd" => Mnemonic::Movd,
        _ => return None,
    })
}

/// Resolve a mnemonic token to its base form plus any AT&T size suffix.
/// A trailing `b`/`w`/`l`/`q` is a suffix only when the token is not a
/// mnemonic as written (so `shl` stays `shl`, but `bswapl` is
/// `bswap` + long).
fn split_mnemonic(tok: &str) -> Option<(Mnemonic, Option<AsmRegSize>)> {
    if let Some(m) = mnemonic_by_name(tok) {
        return Some((m, None));
    }
    let (base, suffix) = match tok.as_bytes().last() {
        Some(b'b') => (&tok[..tok.len() - 1], Some(AsmRegSize::Byte)),
        Some(b'w') => (&tok[..tok.len() - 1], Some(AsmRegSize::Word)),
        Some(b'l') => (&tok[..tok.len() - 1], Some(AsmRegSize::Long)),
        Some(b'q') => (&tok[..tok.len() - 1], Some(AsmRegSize::Quad)),
        _ => return None,
    };
    mnemonic_by_name(base).map(|m| (m, suffix))
}

/// Parse one operand token (already trimmed).
fn parse_operand(tok: &str) -> Result<AsmOpnd, String> {
    let bytes = tok.as_bytes();
    if let Some(rest) = tok.strip_prefix('$') {
        let v = parse_int(rest).ok_or_else(|| format!("inline asm: bad immediate `{tok}`"))?;
        return Ok(AsmOpnd::Imm(v));
    }
    if let Some(rest) = tok.strip_prefix("%%") {
        let (reg, size) =
            reg_by_name(rest).ok_or_else(|| format!("inline asm: unknown register `{tok}`"))?;
        return Ok(AsmOpnd::Reg { reg, size });
    }
    if bytes.first() == Some(&b'%') {
        // `%N` or `%<size>N`. A leading size modifier is a single
        // letter b/w/k/q before the operand digits.
        let body = &tok[1..];
        let (size, digits) = match body.as_bytes().first() {
            Some(&b'b') if body.len() > 1 => (Some(AsmRegSize::Byte), &body[1..]),
            Some(&b'w') if body.len() > 1 => (Some(AsmRegSize::Word), &body[1..]),
            Some(&b'k') if body.len() > 1 => (Some(AsmRegSize::Long), &body[1..]),
            Some(&b'q') if body.len() > 1 => (Some(AsmRegSize::Quad), &body[1..]),
            _ => (None, body),
        };
        let idx: u8 = digits
            .parse()
            .map_err(|_| format!("inline asm: bad operand reference `{tok}`"))?;
        return Ok(AsmOpnd::Ref { idx, size });
    }
    Err(format!("inline asm: unsupported operand `{tok}`"))
}

/// Parse a decimal or `0x`-hex integer, optionally signed.
fn parse_int(s: &str) -> Option<i64> {
    let s = s.trim();
    let (neg, s) = match s.strip_prefix('-') {
        Some(r) => (true, r),
        None => (false, s),
    };
    let v = if let Some(h) = s.strip_prefix("0x").or_else(|| s.strip_prefix("0X")) {
        i64::from_str_radix(h, 16).ok()?
    } else {
        s.parse::<i64>().ok()?
    };
    Some(if neg { -v } else { v })
}

/// Parse an AT&T inline-asm template into its instruction sequence.
/// Instructions are separated by `;` or newlines; operands by commas.
pub(crate) fn parse_template(tmpl: &[u8]) -> Result<Vec<AsmInsn>, String> {
    let text =
        core::str::from_utf8(tmpl).map_err(|_| String::from("inline asm: non-UTF8 template"))?;
    let mut insns = Vec::new();
    for piece in text.split([';', '\n']) {
        let piece = piece.trim();
        if piece.is_empty() {
            continue;
        }
        // Mnemonic is the first whitespace-delimited token; the operand
        // list is the remainder, comma-separated.
        let (mnem_tok, rest) = match piece.find(char::is_whitespace) {
            Some(p) => (&piece[..p], piece[p..].trim()),
            None => (piece, ""),
        };
        let (mnemonic, suffix) = split_mnemonic(mnem_tok)
            .ok_or_else(|| format!("inline asm: unsupported instruction `{mnem_tok}`"))?;
        let mut operands = Vec::new();
        if !rest.is_empty() {
            for op in rest.split(',') {
                operands.push(parse_operand(op.trim())?);
            }
        }
        insns.push(AsmInsn {
            mnemonic,
            suffix,
            operands,
        });
    }
    Ok(insns)
}

// ------------------------------------------------------------------
// Encoding primitives (local copies of the shared REX / ModR/M
// helpers so this module needs no wider visibility into `encode`).
// ------------------------------------------------------------------

fn rex(w: bool, r: bool, x: bool, b: bool) -> u8 {
    let mut v = 0x40;
    if w {
        v |= 0x08;
    }
    if r {
        v |= 0x04;
    }
    if x {
        v |= 0x02;
    }
    if b {
        v |= 0x01;
    }
    v
}

fn modrm_reg(reg: u8, rm: u8) -> u8 {
    // Register-direct form (mod = 11).
    0xC0 | ((reg & 7) << 3) | (rm & 7)
}

/// Emit any needed operand-size / REX prefix for an instruction whose
/// operands are `size`-wide and use ModR/M.reg = `reg`, r/m = `rm`.
/// The 16-bit operand-size prefix (0x66) precedes REX per the SDM.
fn prefix_rex(code: &mut Vec<u8>, size: AsmRegSize, reg: u8, rm: u8) {
    if size == AsmRegSize::Word {
        code.push(0x66);
    }
    let w = size == AsmRegSize::Quad;
    let r = reg >= 8;
    let b = rm >= 8;
    // A byte operation naming spl/bpl/sil/dil (register numbers 4..8) needs
    // a REX prefix to select the new byte registers rather than ah/ch/dh/bh.
    let byte_rex = size == AsmRegSize::Byte && ((4..8).contains(&reg) || (4..8).contains(&rm));
    if w || r || b || byte_rex {
        code.push(rex(w, r, false, b));
    }
}

/// Encode one resolved instruction into `code`. Operands are in AT&T
/// order. Returns an error for an unsupported mnemonic / operand form.
pub(crate) fn encode(
    code: &mut Vec<u8>,
    mnemonic: Mnemonic,
    suffix: Option<AsmRegSize>,
    ops: &[Concrete],
) -> Result<(), String> {
    match mnemonic {
        Mnemonic::Nop => {
            code.push(0x90);
            Ok(())
        }
        Mnemonic::Rdtsc => {
            code.extend_from_slice(&[0x0F, 0x31]);
            Ok(())
        }
        Mnemonic::Rdtscp => {
            code.extend_from_slice(&[0x0F, 0x01, 0xF9]);
            Ok(())
        }
        Mnemonic::Pause => {
            code.extend_from_slice(&[0xF3, 0x90]);
            Ok(())
        }
        Mnemonic::Pushfq => {
            code.push(0x9C);
            Ok(())
        }
        Mnemonic::Int => {
            // `int $imm`: int3 (imm 3) is the one-byte 0xCC breakpoint;
            // any other vector is 0xCD ib.
            match ops.first() {
                Some(Concrete::Imm(3)) => code.push(0xCC),
                Some(Concrete::Imm(n)) => code.extend_from_slice(&[0xCD, *n as u8]),
                _ => return Err(String::from("inline asm: `int` needs an immediate vector")),
            }
            Ok(())
        }
        Mnemonic::Pop => {
            // `pop reg` (64-bit): 0x58+reg, REX.B for r8..r15.
            let (reg, _) = reg_operand(ops.first(), suffix)?;
            if reg >= 8 {
                code.push(rex(false, false, false, true));
            }
            code.push(0x58 + (reg & 7));
            Ok(())
        }
        Mnemonic::Movd => {
            // One operand is an MMX register (marked reg MMX_BASE..+8), the
            // other a GPR. `movd %%mm, %gp` stores the mm register to the
            // GPR (0F 7E /r); `movd %gp, %%mm` loads it (0F 6E /r). The mm
            // register is the ModRM.reg field, the GPR the r/m; no 66 prefix
            // (that selects the XMM form), no REX.W (movd is 32-bit).
            let [a, b] = two(ops)?;
            let mmx = |c: &Concrete| matches!(c, Concrete::Reg { reg, .. } if (MMX_BASE..MMX_BASE + 8).contains(reg));
            let (mm, gp, opcode) = if mmx(&a) {
                (a, b, 0x7E)
            } else if mmx(&b) {
                (b, a, 0x6E)
            } else {
                return Err(String::from("inline asm: `movd` needs one MMX operand"));
            };
            let (Concrete::Reg { reg: mm_reg, .. }, Concrete::Reg { reg: gp_reg, .. }) = (mm, gp)
            else {
                return Err(String::from(
                    "inline asm: `movd` operands must be registers",
                ));
            };
            if gp_reg >= 8 {
                code.push(rex(false, false, false, true)); // REX.B for the GPR r/m
            }
            code.extend_from_slice(&[0x0F, opcode]);
            code.push(modrm_reg(mm_reg - MMX_BASE, gp_reg));
            Ok(())
        }
        Mnemonic::In | Mnemonic::Out => {
            // Variable-port form: `in accumulator, dx` / `out dx,
            // accumulator`. Registers are implicit (AL/AX/EAX + DX),
            // fixed by the operands' constraints, so only the operation
            // width selects the opcode. Width comes from the AT&T suffix
            // (inb/inw/inl), else the accumulator operand.
            let acc = if matches!(mnemonic, Mnemonic::In) {
                ops.first()
            } else {
                ops.get(1)
            };
            let size = suffix
                .or(acc.and_then(|o| match o {
                    Concrete::Reg { size, .. } => Some(*size),
                    _ => None,
                }))
                .unwrap_or(AsmRegSize::Long);
            if size == AsmRegSize::Word {
                code.push(0x66);
            }
            let byte = size == AsmRegSize::Byte;
            let opcode = match mnemonic {
                Mnemonic::In => {
                    if byte {
                        0xEC
                    } else {
                        0xED
                    }
                }
                _ => {
                    if byte {
                        0xEE
                    } else {
                        0xEF
                    }
                }
            };
            code.push(opcode);
            Ok(())
        }
        Mnemonic::Bswap => {
            // `bswap reg`; size from the suffix, else the operand.
            let (reg, size) = reg_operand(ops.first(), suffix)?;
            let size = if matches!(size, AsmRegSize::Byte | AsmRegSize::Word) {
                // BSWAP is defined for 32- and 64-bit operands only.
                AsmRegSize::Long
            } else {
                size
            };
            let w = size == AsmRegSize::Quad;
            if w || reg >= 8 {
                code.push(rex(w, false, false, reg >= 8));
            }
            code.push(0x0F);
            code.push(0xC8 + (reg & 7));
            Ok(())
        }
        Mnemonic::Shld | Mnemonic::Shrd => {
            // AT&T `shld count, src, dst` -> Intel `SHLD dst, src, count`.
            let [count, src, dst] = three(ops)?;
            let (src_reg, ssz) = as_reg(src)?;
            let (dst_reg, dsz) = as_reg(dst)?;
            let size = suffix.unwrap_or(if dsz == AsmRegSize::Byte { ssz } else { dsz });
            let (op_cl, op_imm) = if mnemonic == Mnemonic::Shld {
                (0xA5u8, 0xA4u8)
            } else {
                (0xADu8, 0xACu8)
            };
            prefix_rex(code, size, src_reg, dst_reg);
            code.push(0x0F);
            match count {
                Concrete::Imm(v) => {
                    code.push(op_imm);
                    code.push(modrm_reg(src_reg, dst_reg));
                    code.push((v & 0xFF) as u8);
                }
                Concrete::Reg { reg, .. } => {
                    if reg != 1 {
                        return Err(String::from(
                            "inline asm: double-shift count must be CL or an immediate",
                        ));
                    }
                    code.push(op_cl);
                    code.push(modrm_reg(src_reg, dst_reg));
                }
            }
            Ok(())
        }
        Mnemonic::Shl | Mnemonic::Shr | Mnemonic::Sar => {
            // AT&T `shl count, dst` (count = imm / CL) or `shl dst` (by 1).
            let ext: u8 = match mnemonic {
                Mnemonic::Shl => 4,
                Mnemonic::Shr => 5,
                _ => 7,
            };
            let (count, dst) = one_or_two(ops)?;
            let (dst_reg, dsz) = as_reg(dst)?;
            let size = suffix.unwrap_or(dsz);
            prefix_rex(code, size, 0, dst_reg);
            match count {
                None => {
                    code.push(0xD1);
                    code.push(modrm_reg(ext, dst_reg));
                }
                Some(Concrete::Imm(v)) => {
                    code.push(0xC1);
                    code.push(modrm_reg(ext, dst_reg));
                    code.push((v & 0xFF) as u8);
                }
                Some(Concrete::Reg { reg, .. }) => {
                    if reg != 1 {
                        return Err(String::from(
                            "inline asm: shift count must be CL or immediate",
                        ));
                    }
                    code.push(0xD3);
                    code.push(modrm_reg(ext, dst_reg));
                }
            }
            Ok(())
        }
        Mnemonic::Or
        | Mnemonic::And
        | Mnemonic::Add
        | Mnemonic::Sub
        | Mnemonic::Xor
        | Mnemonic::Mov => {
            // AT&T `op src, dst` -> Intel `op dst, src`.
            let [src, dst] = two(ops)?;
            let (dst_reg, dsz) = as_reg(dst)?;
            let size = suffix.unwrap_or(dsz);
            match src {
                Concrete::Reg { reg: src_reg, .. } => {
                    // `op r/m, r` form: /r with reg = source.
                    let opcode: u8 = match mnemonic {
                        Mnemonic::Or => 0x09,
                        Mnemonic::And => 0x21,
                        Mnemonic::Add => 0x01,
                        Mnemonic::Sub => 0x29,
                        Mnemonic::Xor => 0x31,
                        Mnemonic::Mov => 0x89,
                        _ => unreachable!(),
                    };
                    prefix_rex(code, size, src_reg, dst_reg);
                    code.push(opcode);
                    code.push(modrm_reg(src_reg, dst_reg));
                    Ok(())
                }
                Concrete::Imm(v) => {
                    // `op r/m, imm32` form (`mov` uses its own opcode).
                    if mnemonic == Mnemonic::Mov {
                        prefix_rex(code, size, 0, dst_reg);
                        code.push(0xC7);
                        code.push(modrm_reg(0, dst_reg));
                    } else {
                        let ext: u8 = match mnemonic {
                            Mnemonic::Or => 1,
                            Mnemonic::And => 4,
                            Mnemonic::Add => 0,
                            Mnemonic::Sub => 5,
                            Mnemonic::Xor => 6,
                            _ => unreachable!(),
                        };
                        prefix_rex(code, size, 0, dst_reg);
                        code.push(0x81);
                        code.push(modrm_reg(ext, dst_reg));
                    }
                    code.extend_from_slice(&(v as i32).to_le_bytes());
                    Ok(())
                }
            }
        }
    }
}

fn as_reg(op: Concrete) -> Result<(u8, AsmRegSize), String> {
    match op {
        Concrete::Reg { reg, size } => Ok((reg, size)),
        Concrete::Imm(_) => Err(String::from("inline asm: register operand expected")),
    }
}

fn reg_operand(
    op: Option<&Concrete>,
    suffix: Option<AsmRegSize>,
) -> Result<(u8, AsmRegSize), String> {
    let (reg, size) = as_reg(*op.ok_or_else(|| String::from("inline asm: missing operand"))?)?;
    Ok((reg, suffix.unwrap_or(size)))
}

fn two(ops: &[Concrete]) -> Result<[Concrete; 2], String> {
    if ops.len() != 2 {
        return Err(String::from("inline asm: instruction needs two operands"));
    }
    Ok([ops[0], ops[1]])
}

fn three(ops: &[Concrete]) -> Result<[Concrete; 3], String> {
    if ops.len() != 3 {
        return Err(String::from("inline asm: instruction needs three operands"));
    }
    Ok([ops[0], ops[1], ops[2]])
}

fn one_or_two(ops: &[Concrete]) -> Result<(Option<Concrete>, Concrete), String> {
    match ops {
        [dst] => Ok((None, *dst)),
        [count, dst] => Ok((Some(*count), *dst)),
        _ => Err(String::from("inline asm: shift needs one or two operands")),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn enc(m: Mnemonic, suffix: Option<AsmRegSize>, ops: &[Concrete]) -> Vec<u8> {
        let mut c = Vec::new();
        encode(&mut c, m, suffix, ops).unwrap();
        c
    }

    #[test]
    fn port_io_variable_form() {
        // `in`/`out` DX-port form: width from the AT&T suffix; word takes
        // the 0x66 prefix. Registers are implicit (accumulator + DX).
        assert_eq!(enc(Mnemonic::In, Some(AsmRegSize::Byte), &[]), [0xEC]);
        assert_eq!(enc(Mnemonic::In, Some(AsmRegSize::Word), &[]), [0x66, 0xED]);
        assert_eq!(enc(Mnemonic::In, Some(AsmRegSize::Long), &[]), [0xED]);
        assert_eq!(enc(Mnemonic::Out, Some(AsmRegSize::Byte), &[]), [0xEE]);
        assert_eq!(
            enc(Mnemonic::Out, Some(AsmRegSize::Word), &[]),
            [0x66, 0xEF]
        );
        assert_eq!(enc(Mnemonic::Out, Some(AsmRegSize::Long), &[]), [0xEF]);
    }

    #[test]
    fn system_ops_encoding() {
        assert_eq!(enc(Mnemonic::Pause, None, &[]), [0xF3, 0x90]);
        assert_eq!(enc(Mnemonic::Pushfq, None, &[]), [0x9C]);
        assert_eq!(enc(Mnemonic::Int, None, &[Concrete::Imm(3)]), [0xCC]);
        assert_eq!(
            enc(Mnemonic::Int, None, &[Concrete::Imm(0x20)]),
            [0xCD, 0x20]
        );
        // pop rax = 0x58; pop r8 = REX.B 0x58.
        let rax = Concrete::Reg {
            reg: 0,
            size: AsmRegSize::Quad,
        };
        let r8 = Concrete::Reg {
            reg: 8,
            size: AsmRegSize::Quad,
        };
        assert_eq!(enc(Mnemonic::Pop, None, &[rax]), [0x58]);
        assert_eq!(enc(Mnemonic::Pop, None, &[r8]), [0x41, 0x58]);
    }

    #[test]
    fn port_io_mnemonic_parse() {
        // AT&T `inb`/`inw`/`inl`, `outb`/... split to (In/Out, size).
        assert_eq!(
            split_mnemonic("inb"),
            Some((Mnemonic::In, Some(AsmRegSize::Byte)))
        );
        assert_eq!(
            split_mnemonic("inl"),
            Some((Mnemonic::In, Some(AsmRegSize::Long)))
        );
        assert_eq!(
            split_mnemonic("outb"),
            Some((Mnemonic::Out, Some(AsmRegSize::Byte)))
        );
        assert_eq!(split_mnemonic("in"), Some((Mnemonic::In, None)));
    }
}
