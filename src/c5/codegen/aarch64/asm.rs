//! GCC extended inline-asm (AArch64): ARM-syntax template parsing and operand
//! assignment.
//!
//! [`parse_template`] turns a template into a sequence of [`AsmInsnA64`]s with
//! symbolic operand references (`%N` / `%wN` / `%xN`), explicit registers
//! (`x5`, `w5`, `sp`, `xzr`), and immediates (`#imm`). The emitter
//! ([`super::emit`]) assigns a machine register to each register operand per
//! [`assign_operand_regs`], resolves each reference, and encodes the
//! register-concrete instruction through the table encoder
//! ([`super::table`]). Raw-byte pieces (a `.byte` directive or a hex-byte run)
//! ride the same stream so a template may mix them with mnemonics.
//!
//! The VM does not interpret this path (its inline-asm evaluator is x86-only),
//! so AArch64 mnemonic inline asm is native-only.

#![allow(dead_code)]

use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use super::super::ssa::emit_common;

/// One symbolic operand of a template instruction.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) enum AsmOpndA64 {
    /// `%N` / `%wN` / `%xN`: operand N of the statement, at the register width
    /// named by the modifier (or the operand's own width when unmodified).
    Ref { idx: u8, is64: Option<bool> },
    /// An explicit register: `x5` / `w5` / `sp` / `xzr` (`num == 31` is the
    /// zero register or SP, per the instruction).
    Reg { num: u8, is64: bool },
    /// A literal immediate `#imm`.
    Imm(i64),
    /// A `lsl #n` shift modifier (move-wide).
    Lsl(u32),
}

/// One instruction of a parsed template.
#[derive(Debug, Clone)]
pub(crate) struct AsmInsnA64 {
    /// Empty for a raw-byte piece (`bytes` carries the payload).
    pub mnemonic: String,
    pub operands: Vec<AsmOpndA64>,
    /// Literal bytes for a raw-byte piece; empty for a mnemonic.
    pub bytes: Vec<u8>,
}

fn parse_reg(tok: &str) -> Option<(u8, bool)> {
    match tok {
        "sp" | "xzr" => return Some((31, true)),
        "wsp" | "wzr" => return Some((31, false)),
        _ => {}
    }
    let (is64, rest) = match tok.as_bytes().first()? {
        b'x' => (true, &tok[1..]),
        b'w' => (false, &tok[1..]),
        _ => return None,
    };
    let n: u8 = rest.parse().ok()?;
    (n <= 30).then_some((n, is64))
}

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

/// Parse one operand token (already trimmed).
fn parse_operand(tok: &str) -> Result<AsmOpndA64, String> {
    if let Some(rest) = tok.strip_prefix('#') {
        let v = parse_int(rest).ok_or_else(|| format!("inline asm: bad immediate `{tok}`"))?;
        return Ok(AsmOpndA64::Imm(v));
    }
    if let Some(rest) = tok.strip_prefix('%') {
        // `%N`, `%wN`, `%xN`.
        let (is64, digits) = match rest.as_bytes().first() {
            Some(b'w') => (Some(false), &rest[1..]),
            Some(b'x') => (Some(true), &rest[1..]),
            _ => (None, rest),
        };
        let idx: u8 = digits
            .parse()
            .map_err(|_| format!("inline asm: bad operand reference `{tok}`"))?;
        return Ok(AsmOpndA64::Ref { idx, is64 });
    }
    // `lsl #n` shift modifier (the only shift kind the move-wide forms take).
    if let Some(rest) = tok.strip_prefix("lsl") {
        let amt = rest
            .trim()
            .strip_prefix('#')
            .and_then(parse_int)
            .ok_or_else(|| format!("inline asm: bad shift `{tok}`"))?;
        return Ok(AsmOpndA64::Lsl(amt as u32));
    }
    if let Some((num, is64)) = parse_reg(tok) {
        return Ok(AsmOpndA64::Reg { num, is64 });
    }
    Err(format!("inline asm: unsupported operand `{tok}`"))
}

/// Parse an AArch64 inline-asm template into its instruction sequence.
/// Instructions are separated by `;` or newlines; operands by commas. A piece
/// that is all raw bytes (a `.byte`-family directive or a hex-byte run) becomes
/// a raw-byte instruction.
pub(crate) fn parse_template(tmpl: &[u8]) -> Result<Vec<AsmInsnA64>, String> {
    let text =
        core::str::from_utf8(tmpl).map_err(|_| String::from("inline asm: non-UTF8 template"))?;
    let mut insns = Vec::new();
    for piece in text.split([';', '\n']) {
        let piece = piece.trim();
        if piece.is_empty() {
            continue;
        }
        // Reuse the shared raw-byte recognizer for a single piece.
        if let Some(bytes) = emit_common::parse_raw_template(piece.as_bytes()) {
            insns.push(AsmInsnA64 {
                mnemonic: String::new(),
                operands: Vec::new(),
                bytes,
            });
            continue;
        }
        let (mnem, rest) = match piece.find(char::is_whitespace) {
            Some(p) => (&piece[..p], piece[p..].trim()),
            None => (piece, ""),
        };
        let mut operands = Vec::new();
        if !rest.is_empty() {
            for op in rest.split(',') {
                operands.push(parse_operand(op.trim())?);
            }
        }
        insns.push(AsmInsnA64 {
            mnemonic: String::from(mnem),
            operands,
            bytes: Vec::new(),
        });
    }
    Ok(insns)
}

/// Assign an AArch64 register number to each register operand of the statement,
/// per its constraint. Returns a vector parallel to `operands`: `Some(reg)` for
/// a register operand, `None` for an immediate-only operand. `r` operands take
/// free registers from a pool of x0..x15 (the emitter saves and restores them,
/// and reserves x16 / x17 as bridge scratch); matching constraints alias the
/// register of the operand they name.
pub(crate) fn assign_operand_regs(
    operands: &[crate::c5::ir::AsmOperand],
) -> Result<Vec<Option<u8>>, String> {
    use crate::c5::ir::AsmConstraint as C;
    let mut assigned: Vec<Option<u8>> = alloc::vec![None; operands.len()];
    let mut used = [false; 32];
    // x0..x15 are the allocatable pool; x16/x17 are the emitter's scratch.
    let pool: [u8; 16] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
    for (i, op) in operands.iter().enumerate() {
        if matches!(op.constraint, C::Reg | C::Mem) {
            let r = pool
                .iter()
                .copied()
                .find(|&r| !used[r as usize])
                .ok_or_else(|| String::from("inline asm: out of registers for operands"))?;
            used[r as usize] = true;
            assigned[i] = Some(r);
        }
    }
    for i in 0..operands.len() {
        if let C::Match(n) = operands[i].constraint {
            let r = assigned.get(n as usize).copied().flatten().ok_or_else(|| {
                String::from("inline asm: matching constraint on a non-register operand")
            })?;
            assigned[i] = Some(r);
        }
    }
    // Fixed / register-or-immediate constraints are x86-specific and do not
    // occur in AArch64 templates; reject them rather than mis-assign.
    for op in operands {
        if matches!(op.constraint, C::Fixed(_) | C::RegOrImm(_)) {
            return Err(String::from(
                "inline asm: fixed-register constraint not supported on AArch64",
            ));
        }
    }
    Ok(assigned)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn parse_data_processing() {
        let insns = parse_template(b"add %0, %1, %2").unwrap();
        assert_eq!(insns.len(), 1);
        assert_eq!(insns[0].mnemonic, "add");
        assert_eq!(
            insns[0].operands,
            [
                AsmOpndA64::Ref { idx: 0, is64: None },
                AsmOpndA64::Ref { idx: 1, is64: None },
                AsmOpndA64::Ref { idx: 2, is64: None },
            ]
        );
    }

    #[test]
    fn parse_regs_imms_shifts() {
        let insns = parse_template(b"movz x3, #0x1234, lsl #16; mov %w0, wzr").unwrap();
        assert_eq!(insns.len(), 2);
        assert_eq!(insns[0].mnemonic, "movz");
        assert_eq!(
            insns[0].operands,
            [
                AsmOpndA64::Reg { num: 3, is64: true },
                AsmOpndA64::Imm(0x1234),
                AsmOpndA64::Lsl(16),
            ]
        );
        assert_eq!(
            insns[1].operands,
            [
                AsmOpndA64::Ref {
                    idx: 0,
                    is64: Some(false)
                },
                AsmOpndA64::Reg {
                    num: 31,
                    is64: false
                },
            ]
        );
    }

    #[test]
    fn parse_raw_piece_in_stream() {
        let insns = parse_template(b".byte 0x1f, 0x20, 0x03, 0xd5; add %0, %0, %1").unwrap();
        assert_eq!(insns.len(), 2);
        assert_eq!(insns[0].bytes, [0x1f, 0x20, 0x03, 0xd5]);
        assert!(insns[0].mnemonic.is_empty());
        assert_eq!(insns[1].mnemonic, "add");
    }
}
