//! AArch64 inline asm under the interpreter: the integer instructions on the
//! general registers, over the operand registers the native lowering assigns.
//! Memory, branches, condition flags, SIMD / FP and system registers are
//! refused rather than mis-modelled.

use alloc::format;

use crate::c5::codegen::aarch64::asm::{AsmOpndA64, assign_operand_regs, parse_template};
use crate::c5::error::C5Error;
use crate::c5::ir::{AsmBlock, AsmConstraint, ValueId};

use super::{Frame, Memory, load_from_memory, store_to_memory, width_load_kind, width_store_kind};

fn refused(what: &str) -> C5Error {
    C5Error::Runtime(format!(
        "inline asm: {what} is not supported under --interp"
    ))
}

/// Mnemonics that read or write the condition flags.
const FLAG_OPS: &[&str] = &[
    "cmp", "cmn", "tst", "adds", "subs", "ands", "bics", "negs", "adc", "adcs", "sbc", "sbcs",
    "ngc", "ngcs", "ccmp", "ccmn", "csel", "csinc", "csinv", "csneg", "cset", "csetm", "cinc",
    "cinv", "cneg",
];

/// Hints and barriers: no effect on the register model.
const NO_OPS: &[&str] = &[
    "nop", "yield", "isb", "dmb", "dsb", "sev", "sevl", "wfe", "wfi", "csdb", "sb", "ssbb", "pssbb",
];

/// Whether an encoded instruction is a hint (`nop`, `yield`, `wfe`, `wfi`,
/// `sev`, `sevl`, `csdb`) or a barrier (`clrex`, `dsb`, `dmb`, `isb`, `sb`),
/// which the parser emits as words.
fn is_hint(word: u32) -> bool {
    let hint = word & 0xffff_f01f == 0xd503_201f && matches!((word >> 5) & 0x7f, 0..=5 | 20);
    let barrier = matches!(
        word & 0xffff_f0ff,
        0xd503_305f | 0xd503_309f | 0xd503_30bf | 0xd503_30df | 0xd503_30ff
    );
    hint || barrier
}

/// Refuse collected instruction bytes unless they are whole hint or
/// barrier words.
fn check_words(bytes: &mut alloc::vec::Vec<u8>) -> Result<(), C5Error> {
    let words = bytes.chunks(4);
    if bytes.len() % 4 != 0
        || words
            .map(|w| u32::from_le_bytes(w.try_into().unwrap()))
            .any(|w| !is_hint(w))
    {
        return Err(refused(
            "an instruction word other than a hint or a barrier",
        ));
    }
    bytes.clear();
    Ok(())
}

/// The general-register file: `x[31]` is the zero register.
struct Gprs {
    x: [u64; 32],
}

impl Gprs {
    fn read(&self, r: usize, is64: bool) -> u64 {
        if is64 {
            self.x[r]
        } else {
            self.x[r] & 0xffff_ffff
        }
    }

    fn write(&mut self, r: usize, is64: bool, v: u64) {
        if r != 31 {
            self.x[r] = if is64 { v } else { v & 0xffff_ffff };
        }
    }
}

struct Model<'a, 'f> {
    asm: &'a AsmBlock,
    op_reg: &'a [Option<u8>],
    frame: &'a Frame<'f>,
    args: &'a [ValueId],
}

impl Model<'_, '_> {
    /// A general-register operand: its slot and whether it is the X view.
    fn gpr(&self, o: Option<&AsmOpndA64>) -> Result<(usize, bool), C5Error> {
        match o {
            Some(&AsmOpndA64::Ref { idx, is64 }) => {
                let r = self.op_reg.get(idx as usize).copied().flatten();
                let r = r.ok_or_else(|| refused("a non-register operand in a register slot"))?;
                let width = self.asm.operands[idx as usize].width;
                Ok((r as usize, is64.unwrap_or(width == 8)))
            }
            Some(&AsmOpndA64::Reg {
                num,
                is64,
                sp: false,
            }) => Ok((num as usize, is64)),
            Some(AsmOpndA64::Reg { sp: true, .. }) => Err(refused("the stack pointer")),
            _ => Err(refused("this operand")),
        }
    }

    /// An immediate operand's value.
    fn imm(&self, o: Option<&AsmOpndA64>) -> Result<u64, C5Error> {
        match o {
            Some(&AsmOpndA64::Imm(v)) => Ok(v as u64),
            Some(&AsmOpndA64::RefConst(idx)) => {
                Ok(self.frame.regs[self.args[idx as usize] as usize] as u64)
            }
            _ => Err(refused("this immediate")),
        }
    }

    /// The flexible second operand at `ops[i..]`: an immediate with an
    /// optional `lsl`, or a register with an optional shift or extend,
    /// read at the operation's width.
    fn operand2(&self, g: &Gprs, ops: &[AsmOpndA64], i: usize, is64: bool) -> Result<u64, C5Error> {
        let bits = if is64 { 64 } else { 32 };
        let (v, reg) = match ops.get(i) {
            Some(AsmOpndA64::Imm(_) | AsmOpndA64::RefConst(_)) => (self.imm(ops.get(i))?, false),
            o => {
                let (r, x) = self.gpr(o)?;
                (g.read(r, x), true)
            }
        };
        let v = match ops.get(i + 1) {
            None => v,
            Some(&AsmOpndA64::Lsl(n)) => v << (n % 64),
            Some(&AsmOpndA64::Shift { kind, amount }) if reg => {
                shift(kind, v, u32::from(amount), bits)
            }
            Some(&AsmOpndA64::Extend { option, amount }) if reg => extend(option, v) << amount,
            Some(_) => return Err(refused("this operand modifier")),
        };
        Ok(truncate(v, is64))
    }
}

fn truncate(v: u64, is64: bool) -> u64 {
    if is64 { v } else { v & 0xffff_ffff }
}

/// Sign-extend the low `bits` of `v`.
fn sext(v: u64, bits: u32) -> u64 {
    if bits >= 64 {
        v
    } else {
        (((v << (64 - bits)) as i64) >> (64 - bits)) as u64
    }
}

fn field_mask(width: u32) -> u64 {
    if width >= 64 {
        u64::MAX
    } else {
        (1u64 << width) - 1
    }
}

/// A shift of `v` within `bits`: `kind` 0 lsl, 1 lsr, 2 asr, 3 ror.
fn shift(kind: u8, v: u64, amount: u32, bits: u32) -> u64 {
    let n = amount % bits;
    let v = v & field_mask(bits);
    let r = match kind {
        0 => v << n,
        1 => v >> n,
        2 => (sext(v, bits) as i64 >> n) as u64,
        _ if n == 0 => v,
        _ => (v >> n) | (v << (bits - n)),
    };
    r & field_mask(bits)
}

/// An extended-register operand: `option` 0..3 zero-extends a byte, half,
/// word or doubleword, 4..7 sign-extends one.
fn extend(option: u8, v: u64) -> u64 {
    let bits = 8u32 << (option & 3);
    if option & 4 != 0 {
        sext(v, bits)
    } else {
        v & field_mask(bits)
    }
}

/// The bitfield move family (`ubfm`, `sbfm`, `bfm`) that every bitfield
/// alias reduces to: `dst` is the destination's prior value for `bfm`.
fn bitfield_move(kind: &str, dst: u64, src: u64, immr: u32, imms: u32, bits: u32) -> u64 {
    let (lsb, width, insert) = if imms >= immr {
        (immr, imms - immr + 1, false)
    } else {
        (bits - immr, imms + 1, true)
    };
    let field = if insert {
        src & field_mask(width)
    } else {
        (src >> lsb) & field_mask(width)
    };
    let r = match (kind, insert) {
        ("bfm", true) => (dst & !(field_mask(width) << lsb)) | (field << lsb),
        ("bfm", false) => (dst & !field_mask(width)) | field,
        ("sbfm", true) => sext(field, width) << lsb,
        ("sbfm", false) => sext(field, width),
        (_, true) => field << lsb,
        _ => field,
    };
    r & field_mask(bits)
}

/// Rewrite a bitfield alias into its `(kind, immr, imms)` move form.
fn bitfield_alias(m: &str, lsb: u32, width: u32, bits: u32) -> Option<(&'static str, u32, u32)> {
    let ext = (lsb + width - 1, (bits - lsb) % bits, width - 1);
    Some(match m {
        "ubfx" => ("ubfm", lsb, ext.0),
        "sbfx" => ("sbfm", lsb, ext.0),
        "bfxil" => ("bfm", lsb, ext.0),
        "ubfiz" => ("ubfm", ext.1, ext.2),
        "sbfiz" => ("sbfm", ext.1, ext.2),
        "bfi" => ("bfm", ext.1, ext.2),
        _ => return None,
    })
}

/// Evaluate one AArch64 inline asm statement on the interpreter's state.
pub(super) fn run(
    mem: &mut Memory,
    frame: &mut Frame<'_>,
    asm: &AsmBlock,
    args: &[ValueId],
    site: ValueId,
) -> Result<(), C5Error> {
    let text = core::str::from_utf8(&asm.template).map_err(|_| refused("a non-UTF8 template"))?;
    let insns = parse_template(text.as_bytes()).map_err(C5Error::Runtime)?;
    let op_reg = assign_operand_regs(&asm.operands, asm.clobber_regs, asm.clobber_fp_regs, &|i| {
        args.get(i)
            .and_then(|&a| crate::c5::asm::asm_operand_const(frame.func, a))
    })
    .map_err(C5Error::Runtime)?;
    for op in &asm.operands {
        match op.constraint {
            AsmConstraint::Fp => return Err(refused("a SIMD / FP register operand")),
            AsmConstraint::Flags(_) => return Err(refused("a condition-flag output")),
            _ => {}
        }
    }
    let mut g = Gprs { x: [0; 32] };
    for (i, op) in asm.operands.iter().enumerate() {
        let Some(r) = op_reg[i] else { continue };
        let r = r as usize;
        if matches!(op.constraint, AsmConstraint::Bound(_))
            || !op.is_output
            || (op.is_rw && op.value)
        {
            g.x[r] = frame.regs[args[i] as usize] as u64;
        } else if op.is_rw {
            let addr = frame.regs[args[i] as usize] as usize;
            g.x[r] = load_from_memory(mem, addr, width_load_kind(op.width))? as u64;
        }
    }
    let model = Model {
        asm,
        op_reg: &op_reg,
        frame,
        args,
    };
    // Instructions written as bytes or data, collected up to the next
    // mnemonic: only hints and barriers, which change no register, run.
    let mut words: alloc::vec::Vec<u8> = alloc::vec::Vec::new();
    for insn in &insns {
        let m = insn.mnemonic.as_str();
        let data = match m {
            ".inst" | ".word" => Some(4),
            _ => crate::c5::asm::data_directive_width(m),
        };
        if let Some(w) = data {
            for o in &insn.operands {
                words.extend_from_slice(&model.imm(Some(o))?.to_le_bytes()[..w]);
            }
            continue;
        }
        words.extend_from_slice(&insn.bytes);
        if m.is_empty() {
            continue;
        }
        check_words(&mut words)?;
        step(&model, &mut g, m, &insn.operands)?;
    }
    check_words(&mut words)?;
    for (i, op) in asm.operands.iter().enumerate() {
        if op.is_output
            && !matches!(op.constraint, AsmConstraint::Bound(_))
            && let Some(r) = op_reg[i]
        {
            let v = g.x[r as usize] as i64;
            if op.value {
                frame.regs[site as usize] = v;
                continue;
            }
            let addr = frame.regs[args[i] as usize] as usize;
            store_to_memory(mem, addr, v, width_store_kind(op.width))?;
        }
    }
    Ok(())
}

/// Execute one instruction on the register file.
fn step(model: &Model<'_, '_>, g: &mut Gprs, m: &str, ops: &[AsmOpndA64]) -> Result<(), C5Error> {
    if NO_OPS.contains(&m) {
        return Ok(());
    }
    if FLAG_OPS.contains(&m) {
        return Err(refused(&format!("`{m}`, which uses the condition flags,")));
    }
    let (d, is64) = model
        .gpr(ops.first())
        .map_err(|_| refused(&format!("`{m}`")))?;
    let bits = if is64 { 64 } else { 32 };
    let src = |i: usize| -> Result<u64, C5Error> {
        let (r, x) = model.gpr(ops.get(i))?;
        Ok(g.read(r, x))
    };
    let imm = |i: usize| -> Result<u32, C5Error> { Ok(model.imm(ops.get(i))? as u32) };
    let v = match m {
        "mov" => match ops.get(1) {
            Some(AsmOpndA64::Imm(_) | AsmOpndA64::RefConst(_)) => model.imm(ops.get(1))?,
            _ => src(1)?,
        },
        "movz" | "movn" | "movk" => {
            let s = match ops.get(2) {
                Some(&AsmOpndA64::Lsl(s)) => s % 64,
                None => 0,
                Some(_) => return Err(refused(&format!("`{m}` with this shift"))),
            };
            let v = (model.imm(ops.get(1))? & 0xffff) << s;
            match m {
                "movz" => v,
                "movn" => !v,
                _ => (g.read(d, is64) & !(0xffff << s)) | v,
            }
        }
        "mvn" => !model.operand2(g, ops, 1, is64)?,
        "neg" => model.operand2(g, ops, 1, is64)?.wrapping_neg(),
        "add" => src(1)?.wrapping_add(model.operand2(g, ops, 2, is64)?),
        "sub" => src(1)?.wrapping_sub(model.operand2(g, ops, 2, is64)?),
        "and" => src(1)? & model.operand2(g, ops, 2, is64)?,
        "orr" => src(1)? | model.operand2(g, ops, 2, is64)?,
        "eor" => src(1)? ^ model.operand2(g, ops, 2, is64)?,
        "bic" => src(1)? & !model.operand2(g, ops, 2, is64)?,
        "orn" => src(1)? | !model.operand2(g, ops, 2, is64)?,
        "eon" => src(1)? ^ !model.operand2(g, ops, 2, is64)?,
        "lsl" | "lsr" | "asr" | "ror" | "lslv" | "lsrv" | "asrv" | "rorv" => {
            let kind = match &m[..3] {
                "lsl" => 0,
                "lsr" => 1,
                "asr" => 2,
                _ => 3,
            };
            let n = match ops.get(2) {
                Some(AsmOpndA64::Imm(_) | AsmOpndA64::RefConst(_)) => model.imm(ops.get(2))?,
                _ => src(2)?,
            };
            shift(kind, src(1)?, (n % 64) as u32, bits)
        }
        "mul" => src(1)?.wrapping_mul(src(2)?),
        "mneg" => src(1)?.wrapping_mul(src(2)?).wrapping_neg(),
        "madd" => src(3)?.wrapping_add(src(1)?.wrapping_mul(src(2)?)),
        "msub" => src(3)?.wrapping_sub(src(1)?.wrapping_mul(src(2)?)),
        "smull" | "umull" | "smnegl" | "umnegl" | "smaddl" | "umaddl" | "smsubl" | "umsubl" => {
            let widen = |v: u64| if m.starts_with('s') { sext(v, 32) } else { v };
            let p = widen(src(1)?).wrapping_mul(widen(src(2)?));
            match m {
                "smull" | "umull" => p,
                "smnegl" | "umnegl" => p.wrapping_neg(),
                "smaddl" | "umaddl" => src(3)?.wrapping_add(p),
                _ => src(3)?.wrapping_sub(p),
            }
        }
        "smulh" => ((i128::from(src(1)? as i64) * i128::from(src(2)? as i64)) >> 64) as u64,
        "umulh" => ((u128::from(src(1)?) * u128::from(src(2)?)) >> 64) as u64,
        "udiv" => src(1)?.checked_div(src(2)?).unwrap_or(0),
        "sdiv" => {
            let (n, q) = (sext(src(1)?, bits) as i64, sext(src(2)?, bits) as i64);
            if q == 0 { 0 } else { n.wrapping_div(q) as u64 }
        }
        "clz" => u64::from((src(1)? << (64 - bits)).leading_zeros().min(bits)),
        "cls" => {
            let v = src(1)?;
            let y = ((v >> 1) ^ v) & field_mask(bits - 1);
            u64::from(y.leading_zeros() - (64 - (bits - 1)))
        }
        "rbit" => src(1)?.reverse_bits() >> (64 - bits),
        "rev" => src(1)?.swap_bytes() >> (64 - bits),
        "rev16" | "rev32" => {
            let chunk = if m == "rev16" { 16 } else { 32 };
            let v = src(1)?;
            (0..bits / chunk).fold(0, |acc, k| {
                let part = (v >> (k * chunk)) & field_mask(chunk);
                acc | ((part.swap_bytes() >> (64 - chunk)) << (k * chunk))
            })
        }
        "uxtb" | "uxth" | "sxtb" | "sxth" | "sxtw" => {
            let option = match m {
                "uxtb" => 0,
                "uxth" => 1,
                "sxtb" => 4,
                "sxth" => 5,
                _ => 6,
            };
            extend(option, src(1)?)
        }
        "ubfm" | "sbfm" | "bfm" => {
            bitfield_move(m, g.read(d, is64), src(1)?, imm(2)?, imm(3)?, bits)
        }
        "ubfx" | "sbfx" | "bfxil" | "ubfiz" | "sbfiz" | "bfi" => {
            let (lsb, width) = (imm(2)?, imm(3)?);
            if width == 0 || lsb + width > bits {
                return Err(refused(&format!("`{m}` with this field")));
            }
            let (kind, immr, imms) = bitfield_alias(m, lsb, width, bits).unwrap();
            bitfield_move(kind, g.read(d, is64), src(1)?, immr, imms, bits)
        }
        "extr" => {
            let lsb = imm(3)? % bits;
            let (hi, lo) = (src(1)?, src(2)?);
            if lsb == 0 {
                lo
            } else {
                (lo >> lsb) | (hi << (bits - lsb))
            }
        }
        _ => return Err(refused(&format!("`{m}`"))),
    };
    g.write(d, is64, truncate(v, is64));
    Ok(())
}
