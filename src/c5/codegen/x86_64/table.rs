//! Table-driven x86-64 encoder.
//!
//! The instruction catalogue in [`super::isa_x86_table`] is a compact set of
//! [`Form`]s generated from an external instruction-set database (see
//! `tools/gen_isa.py`); this module interprets a form against concrete
//! operands to produce machine bytes. It is the single encoder shared by the
//! GP / system surface: the general-instruction lowering and the extended
//! inline-asm path resolve their operands to [`Opnd`]s and call [`encode`].
//!
//! Operand order is Intel (`dst, src`), matching the database signatures. The
//! caller passes operands already resolved to architectural register numbers.

#![allow(dead_code)] // Catalogue breadth runs ahead of lowering coverage.

use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

/// Operand-size width class of a form's operand slot.
///
/// `V` is 16/32/64 (word/dword/qword) selected by the operation width; `Y` is
/// 32/64; the fixed classes bind one width.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum W {
    B,
    Wd,
    L,
    Q,
    V,
    Y,
}

/// Immediate width/signedness class of an immediate operand slot.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum ImmC {
    /// 8-bit immediate.
    Ib,
    /// 8-bit immediate sign-extended to the operand width (the `83 /r` group);
    /// only matches a value that fits in a signed byte.
    Imms8,
    /// 16-bit immediate.
    Iw,
    /// 32-bit immediate.
    Id,
    /// 64-bit immediate.
    Iq,
    /// Operand-width immediate (16/32/32-sx by width; the `iv` group).
    Iv,
    /// The implicit constant `1` (shift-by-one forms).
    One,
}

/// One operand slot of a form, in Intel order.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum OpPat {
    /// Register supplied through `ModRM.reg`.
    Reg(W),
    /// Register-or-memory (`ModRM.rm`).
    Rm(W),
    /// Memory only (`ModRM.rm` with a memory form).
    Mem(W),
    /// Memory of unspecified size (`clflush`, `prefetch`, the descriptor-table
    /// and save/restore ops): matches a memory operand of any width and never
    /// contributes an operand-size prefix.
    MemAny,
    /// Immediate.
    Imm(ImmC),
    /// A fixed architectural register (`al`/`ax`/`eax`/`rax`, `cl`, `dx`, ...).
    Fixed(u8, W),
    /// A relative code offset immediate of the given byte size.
    Rel(u8),
}

/// Legacy opcode map the primary opcode lives in.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum Map {
    Legacy,
    Op0F,
    Op0F38,
    Op0F3A,
}

/// REX.W policy for a form.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum RexW {
    /// Never set (operation is 8/16/32-bit or W is irrelevant).
    W0,
    /// Always set (`REX.W` baked into the opcode string).
    W1,
    /// Set when the operation width is 64-bit.
    ByWidth,
    /// 64-bit is the default operand size in long mode; never set REX.W
    /// (push/pop/call/jmp/leave/ret group).
    Default64,
}

/// Source of the `ModRM.reg` field.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum RegField {
    /// Taken from the operand at this index (a register operand).
    FromOp(u8),
    /// An opcode extension digit (`/0`..`/7`).
    Ext(u8),
    /// No `ModRM.reg` source (a `+r` or nullary form). Named to avoid
    /// colliding with `Option::None` in the glob-imported generated table.
    NoReg,
}

/// One catalogue entry: an operand pattern plus its encoding.
#[derive(Debug, Clone, Copy)]
pub(crate) struct Form {
    pub mnemonic: &'static str,
    pub ops: &'static [OpPat],
    /// Mandatory prefix bytes (`F2`/`F3`/mandatory-`66`), in order, emitted
    /// before REX. The operand-size `66` for 16-bit operations is separate and
    /// added by the encoder from the operation width.
    pub pp: &'static [u8],
    pub map: Map,
    /// Fixed opcode bytes after the map. For a `+r` form the register is added
    /// into the last byte. System forms with a fixed ModRM tail (e.g.
    /// `0F 01 F9`) list every byte here and set `reg` to [`RegField::NoReg`].
    pub opcode: &'static [u8],
    pub plus_r: bool,
    pub rexw: RexW,
    pub reg: RegField,
    /// Index of the operand supplying `ModRM.rm` (a register or memory
    /// operand), or `255` when the form has no ModRM r/m.
    pub rm: u8,
    pub imm: Option<ImmC>,
    /// Index of the immediate operand, or `255` when the immediate is implicit
    /// (the `1` of a shift-by-one form).
    pub imm_op: u8,
}

/// A resolved operand handed to [`encode`]. Register numbers are architectural
/// (0..16). Memory is a `disp(%base)` form: `base` holds the address, `disp` is
/// a byte displacement (0 for the bare `(%base)` form).
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum Opnd {
    Reg { num: u8, width: u8 },
    Mem { base: u8, disp: i32, width: u8 },
    Imm(i64),
}

impl Opnd {
    fn width(self) -> Option<u8> {
        match self {
            Opnd::Reg { width, .. } | Opnd::Mem { width, .. } => Some(width),
            Opnd::Imm(_) => None,
        }
    }
}

fn wbytes(w: W, opw: u8) -> Option<u8> {
    match w {
        W::B => Some(1),
        W::Wd => Some(2),
        W::L => Some(4),
        W::Q => Some(8),
        // `v` is word/dword/qword, `y` is dword/qword; neither is a byte.
        W::V => (opw != 1).then_some(opw),
        W::Y => (opw >= 4).then_some(opw),
    }
}

fn pat_matches(p: OpPat, o: Opnd, opw: u8) -> bool {
    match (p, o) {
        (OpPat::Reg(w), Opnd::Reg { width, .. }) => wbytes(w, opw) == Some(width),
        (OpPat::Rm(w), Opnd::Reg { width, .. }) => wbytes(w, opw) == Some(width),
        (OpPat::Rm(w), Opnd::Mem { width, .. }) => wbytes(w, opw) == Some(width),
        (OpPat::Mem(w), Opnd::Mem { width, .. }) => wbytes(w, opw) == Some(width),
        (OpPat::MemAny, Opnd::Mem { .. }) => true,
        (OpPat::Fixed(num, w), Opnd::Reg { num: n, width }) => {
            n == num && wbytes(w, opw) == Some(width)
        }
        (OpPat::Imm(c), Opnd::Imm(v)) => match c {
            ImmC::Imms8 => (-128..=127).contains(&v),
            ImmC::One => v == 1,
            _ => true,
        },
        (OpPat::Rel(_), Opnd::Imm(_)) => true,
        _ => false,
    }
}

/// Operation width in bytes: the widest register / memory operand, defaulting
/// to 4 (dword) when there are none.
fn op_width(ops: &[Opnd], override_w: Option<u8>) -> u8 {
    if let Some(w) = override_w {
        return w;
    }
    ops.iter().filter_map(|o| o.width()).max().unwrap_or(4)
}

fn rex(w: bool, r: bool, x: bool, b: bool) -> u8 {
    0x40 | ((w as u8) << 3) | ((r as u8) << 2) | ((x as u8) << 1) | (b as u8)
}

fn modrm_reg(reg: u8, rm: u8) -> u8 {
    0xC0 | ((reg & 7) << 3) | (rm & 7)
}

fn emit_modrm_mem(code: &mut Vec<u8>, reg: u8, base: u8, disp: i32) {
    let rm = base & 7;
    // The mod field selects the displacement size. rbp / r13 (rm==5) has no
    // no-displacement form (mod=00 rm=101 is RIP-relative), so a zero
    // displacement there is still encoded as disp8=0.
    let mod_ = if disp == 0 && rm != 5 {
        0
    } else if (-128..=127).contains(&disp) {
        1
    } else {
        2
    };
    if rm == 4 {
        // rsp / r12: rm=100 selects SIB; base=100 (rsp/r12), index=100 (none).
        code.push((mod_ << 6) | ((reg & 7) << 3) | 4);
        code.push(0x24);
    } else {
        code.push((mod_ << 6) | ((reg & 7) << 3) | rm);
    }
    match mod_ {
        1 => code.push(disp as u8),
        2 => code.extend_from_slice(&disp.to_le_bytes()),
        _ => {}
    }
}

fn reg_num(o: Opnd) -> u8 {
    match o {
        Opnd::Reg { num, .. } => num,
        Opnd::Mem { base, .. } => base,
        Opnd::Imm(_) => 0,
    }
}

fn form_matches(f: &Form, mnemonic: &str, ops: &[Opnd], opw: u8) -> bool {
    f.mnemonic == mnemonic
        && f.ops.len() == ops.len()
        && f.ops
            .iter()
            .zip(ops.iter())
            .all(|(&p, &o)| pat_matches(p, o, opw))
}

/// Encode one instruction. `width_override` forces the operation width (an
/// AT&T size suffix); otherwise it comes from the operands. Among the forms
/// that match, the shortest encoding is chosen (ties broken by catalogue
/// order), which deterministically reproduces the assembler's preference for
/// the `83 /r` imm8 short form, the accumulator immediate forms, and the like.
pub(crate) fn encode(
    mnemonic: &str,
    width_override: Option<u8>,
    ops: &[Opnd],
) -> Result<Vec<u8>, String> {
    let opw = op_width(ops, width_override);
    let mut best: Option<Vec<u8>> = None;
    let mut matched = false;
    // The catalogue is sorted by mnemonic (enforced by the generator and the
    // `catalogue_is_sorted` test): binary-search to the mnemonic's contiguous
    // run of forms rather than scanning the whole table.
    let forms = super::isa_x86_table::FORMS;
    let start = forms.partition_point(|f| f.mnemonic < mnemonic);
    for f in &forms[start..] {
        if f.mnemonic != mnemonic {
            break;
        }
        if !form_matches(f, mnemonic, ops, opw) {
            continue;
        }
        matched = true;
        if let Ok(bytes) = encode_form(f, ops, opw)
            && best.as_ref().is_none_or(|b| bytes.len() < b.len())
        {
            best = Some(bytes);
        }
    }
    best.ok_or_else(|| {
        if matched {
            format!("inline asm: `{mnemonic}` operand form not encodable")
        } else {
            format!("inline asm: no encoding for `{mnemonic}` with these operands")
        }
    })
}

fn encode_form(f: &Form, ops: &[Opnd], opw: u8) -> Result<Vec<u8>, String> {
    let mut code = Vec::new();
    // Operand-size prefix for a 16-bit operation. Suppressed for a form with no
    // width-bearing operand (e.g. a sizeless-memory op such as clflush), whose
    // operand width does not select 16-bit operation.
    let has_width_op = f.ops.iter().any(|p| {
        matches!(
            p,
            OpPat::Reg(_) | OpPat::Rm(_) | OpPat::Mem(_) | OpPat::Fixed(..)
        )
    });
    if opw == 2 && has_width_op && f.rexw != RexW::Default64 {
        code.push(0x66);
    }
    code.extend_from_slice(f.pp);

    // Resolve the reg-field and rm operands.
    let reg_op = match f.reg {
        RegField::FromOp(i) => Some(ops[i as usize]),
        _ => None,
    };
    let rm_op = (f.rm != 255).then(|| ops[f.rm as usize]);

    // REX computation.
    let w = match f.rexw {
        RexW::W0 | RexW::Default64 => false,
        RexW::W1 => true,
        RexW::ByWidth => opw == 8,
    };
    let reg_hi = reg_op.map(|o| reg_num(o) >= 8).unwrap_or(false);
    let rm_hi = rm_op.map(|o| reg_num(o) >= 8).unwrap_or(false);
    // A byte operation naming spl/bpl/sil/dil (4..8) needs a REX to reach the
    // new byte registers rather than ah/ch/dh/bh.
    let byte_rex = opw == 1
        && (matches!(reg_op, Some(Opnd::Reg { num, .. }) if (4..8).contains(&num))
            || matches!(rm_op, Some(Opnd::Reg { num, .. }) if (4..8).contains(&num)));
    if w || reg_hi || rm_hi || byte_rex {
        code.push(rex(w, reg_hi, false, rm_hi));
    }

    // Opcode map + opcode bytes.
    match f.map {
        Map::Legacy => {}
        Map::Op0F => code.push(0x0F),
        Map::Op0F38 => code.extend_from_slice(&[0x0F, 0x38]),
        Map::Op0F3A => code.extend_from_slice(&[0x0F, 0x3A]),
    }
    let (last, head) = f.opcode.split_last().expect("form opcode non-empty");
    code.extend_from_slice(head);
    if f.plus_r {
        let r = rm_op.map(reg_num).unwrap_or(0);
        code.push(last + (r & 7));
    } else {
        code.push(*last);
    }

    // ModRM (+ SIB / disp).
    let regfield = match f.reg {
        RegField::FromOp(i) => reg_num(ops[i as usize]) & 7,
        RegField::Ext(d) => d,
        RegField::NoReg => 0,
    };
    // A `+r` form embeds its register in the opcode and has no ModRM byte.
    if !f.plus_r && (f.reg != RegField::NoReg || f.rm != 255) {
        match rm_op {
            Some(Opnd::Reg { num, .. }) => code.push(modrm_reg(regfield, num)),
            Some(Opnd::Mem { base, disp, .. }) => emit_modrm_mem(&mut code, regfield, base, disp),
            _ => return Err(String::from("inline asm: form needs an r/m operand")),
        }
    }

    // Immediate.
    if let Some(c) = f.imm {
        let val = if f.imm_op == 255 {
            1
        } else {
            match ops[f.imm_op as usize] {
                Opnd::Imm(v) => v,
                _ => return Err(String::from("inline asm: immediate operand expected")),
            }
        };
        emit_imm(&mut code, c, val, opw);
    }
    Ok(code)
}

fn emit_imm(code: &mut Vec<u8>, c: ImmC, v: i64, opw: u8) {
    match c {
        ImmC::Ib | ImmC::Imms8 => code.push(v as u8),
        ImmC::Iw => code.extend_from_slice(&(v as u16).to_le_bytes()),
        ImmC::Id => code.extend_from_slice(&(v as u32).to_le_bytes()),
        ImmC::Iq => code.extend_from_slice(&(v as u64).to_le_bytes()),
        ImmC::Iv => {
            if opw == 2 {
                code.extend_from_slice(&(v as u16).to_le_bytes());
            } else {
                code.extend_from_slice(&(v as u32).to_le_bytes());
            }
        }
        ImmC::One => {}
    }
}

#[cfg(test)]
mod tests;
