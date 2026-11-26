//! The assembly text of an A64 instruction, formed from the operands its
//! encoder takes: an instruction an alias spells reads as its preferred
//! disassembly, an alias a template writes as the form it encodes first;
//! immediates read in hexadecimal, shift amounts and bit positions in
//! decimal.

use super::table::Opnd;
use super::{Cond, Reg};
use crate::c5::codegen::listing::A64Field;

/// An operand of an instruction's text. Without the `listing` feature the
/// encoders form it and nothing reads it.
#[derive(Clone, Copy, Debug)]
#[cfg_attr(not(feature = "listing"), allow(dead_code))]
pub(crate) enum Op {
    /// An operand as the instruction catalog takes it.
    T(Opnd),
    /// A decimal immediate.
    Dec(i64),
    /// An unsigned immediate.
    U(u64),
    /// A field the listing reads from the final word, with the value the
    /// encoder gave it.
    At(A64Field, i64),
    /// `[base` and a [`A64Field::Lo12`] offset field`]`.
    MemAt(u8, A64Field),
    /// A 64-bit byte mask, as `movi` spells one.
    Mask(u64),
    /// `vN.4b[index]`, the four-byte group a dot product reads.
    Group4B(u8, u8),
    /// Fixed text.
    Lit(&'static str),
}

/// `xN`, register 31 being `xzr`.
pub(crate) const fn x(r: Reg) -> Op {
    gp(r.0, true, false)
}

/// `xN`, register 31 being `sp`.
pub(crate) const fn xsp(r: Reg) -> Op {
    gp(r.0, true, true)
}

/// `wN`, register 31 being `wzr`.
pub(crate) const fn w(r: Reg) -> Op {
    gp(r.0, false, false)
}

/// `wN`, register 31 being `wsp`.
pub(crate) const fn wsp(r: Reg) -> Op {
    gp(r.0, false, true)
}

/// `xN` or `wN`.
pub(crate) const fn r(r: Reg, is64: bool) -> Op {
    gp(r.0, is64, false)
}

pub(crate) const fn gp(num: u8, is64: bool, sp: bool) -> Op {
    Op::T(Opnd::Reg { num, is64, sp })
}

/// The scalar SIMD&FP register `bN` .. `qN` of the element size log2.
pub(crate) const fn fp(num: u8, size: u8) -> Op {
    Op::T(match size {
        0 | 1 => Opnd::VScalar { num, size },
        2 => Opnd::VReg { num, is_d: false },
        3 => Opnd::VReg { num, is_d: true },
        _ => Opnd::QReg(num),
    })
}

/// `sN`, or `dN` unless `single`.
pub(crate) const fn sd(num: u8, single: bool) -> Op {
    fp(num, if single { 2 } else { 3 })
}

pub(crate) const fn d(num: u8) -> Op {
    fp(num, 3)
}

pub(crate) const fn s(num: u8) -> Op {
    fp(num, 2)
}

/// `vN.T` of the element size log2, 128 bits wide when `q`.
pub(crate) const fn v(num: u8, size: u8, q: bool) -> Op {
    Op::T(Opnd::VecReg { num, size, q })
}

/// `vN.T[index]` of the element size log2.
pub(crate) const fn elem(num: u8, size: u8, index: u8) -> Op {
    Op::T(Opnd::VecElem { num, size, index })
}

pub(crate) const fn imm(v: i64) -> Op {
    Op::T(Opnd::Imm(v))
}

pub(crate) const fn dec(v: i64) -> Op {
    Op::Dec(v)
}

pub(crate) const fn uimm(v: u64) -> Op {
    Op::U(v)
}

/// The 8-bit floating-point immediate of `fmov`.
pub(crate) const fn fp_imm(imm8: u8) -> Op {
    Op::T(Opnd::FpImm(imm8))
}

/// A system register by its `op0:op1:CRn:CRm:op2` selector.
pub(crate) const fn sys_reg(field: u16) -> Op {
    Op::T(Opnd::SysReg(field))
}

/// `{ vN.T }[index]`, one lane of the element size log2.
pub(crate) const fn lane_list(first: u8, size: u8, index: u8) -> Op {
    Op::T(Opnd::VecListLane {
        first,
        count: 1,
        size,
        index,
    })
}

/// An `add`'s 12-bit immediate, which a relocation may fill.
pub(crate) const fn lo12(v: u32) -> Op {
    Op::At(
        A64Field::Lo12 {
            scale: 0,
            mem: false,
        },
        v as i64,
    )
}

/// The target of `adr`.
pub(crate) const fn adr() -> Op {
    Op::At(A64Field::Adr, 0)
}

/// The page of `adrp`.
pub(crate) const fn adrp() -> Op {
    Op::At(A64Field::Adrp, 0)
}

/// `lsl #n`, absent when `n` is zero.
pub(crate) const fn lsl(n: u32) -> Op {
    Op::T(Opnd::Lsl(n))
}

/// `<lsl|lsr|asr|ror> #amount`, of the shift-type field value.
pub(crate) const fn shift(kind: u8, amount: u8) -> Op {
    Op::T(Opnd::Shift { kind, amount })
}

/// An extended register's `<extend> {#amount}`, of the option field value.
pub(crate) const fn ext(option: u8, amount: u8) -> Op {
    Op::T(Opnd::Extend { option, amount })
}

/// `[base, #off]`, or `[base]` at zero.
pub(crate) const fn mem(base: Reg, off: i64) -> Op {
    Op::T(Opnd::Mem {
        base: base.0,
        off,
        pre: false,
    })
}

/// `[base, #off]!`.
pub(crate) const fn pre(base: Reg, off: i64) -> Op {
    Op::T(Opnd::Mem {
        base: base.0,
        off,
        pre: true,
    })
}

/// `[base, index{, <option> #shift}]`.
pub(crate) const fn mem_reg(base: Reg, index: Reg, option: u8, shift: Option<u8>) -> Op {
    Op::T(Opnd::MemReg {
        base: base.0,
        index: index.0,
        option,
        shift,
    })
}

/// `[base, #off]` with the offset a scaled 12-bit field a relocation may
/// fill.
pub(crate) const fn mem_lo12(base: Reg, scale: u8) -> Op {
    Op::MemAt(base.0, A64Field::Lo12 { scale, mem: true })
}

pub(crate) const fn cond(c: Cond) -> Op {
    Op::T(Opnd::Cond(c as u8))
}

/// A branch target, the signed word offset `bits` wide at bit `lo`.
pub(crate) const fn target(lo: u8, bits: u8) -> Op {
    Op::At(A64Field::Branch { lo, bits }, 0)
}

pub(crate) const fn lit(s: &'static str) -> Op {
    Op::Lit(s)
}

#[cfg(feature = "listing")]
pub(crate) use print::Desc;

#[cfg(feature = "listing")]
mod print {
    use alloc::format;
    use alloc::string::String;
    use alloc::vec::Vec;
    use core::fmt::Write;

    use super::super::table::Opnd;
    use super::Op;
    use crate::c5::codegen::listing::{Operand, Text};

    /// The most operands and mnemonic bytes an A64 instruction takes.
    const MAX_OPS: usize = 5;
    const MAX_MNEM: usize = 12;

    /// An instruction's mnemonic and operands.
    #[derive(Clone, Copy, Debug)]
    pub(crate) struct Desc {
        mnem: [u8; MAX_MNEM],
        len: u8,
        ops: [Op; MAX_OPS],
        n: u8,
    }

    impl Desc {
        pub(crate) const fn new(mnem: &str, ops: &[Op]) -> Self {
            let bytes = mnem.as_bytes();
            let mut m = [0; MAX_MNEM];
            let mut i = 0;
            while i < bytes.len() && i < MAX_MNEM {
                m[i] = bytes[i];
                i += 1;
            }
            let mut all = [Op::Lit(""); MAX_OPS];
            let mut k = 0;
            while k < ops.len() && k < MAX_OPS {
                all[k] = ops[k];
                k += 1;
            }
            Desc {
                mnem: m,
                len: i as u8,
                ops: all,
                n: k as u8,
            }
        }

        pub(crate) fn text(&self) -> Text {
            let mnem = core::str::from_utf8(&self.mnem[..usize::from(self.len)]).unwrap_or("?");
            text(mnem, &self.ops[..usize::from(self.n)])
        }
    }

    const CONDS: [&str; 16] = [
        "eq", "ne", "hs", "lo", "mi", "pl", "vs", "vc", "hi", "ls", "ge", "lt", "gt", "le", "al",
        "nv",
    ];

    /// The text of `mnem` over `ops`, in its preferred disassembly.
    pub(crate) fn text(mnem: &str, ops: &[Op]) -> Text {
        let canon = canonical(mnem, ops);
        let (mnem, ops) = match &canon {
            Some((m, o)) => (*m, o.as_slice()),
            None => (mnem, ops),
        };
        let alias = preferred(mnem, ops);
        let (mnem, ops) = match &alias {
            Some((m, o)) => (*m, o.as_slice()),
            None => (mnem, ops),
        };
        let ops = restyle(mnem, ops);
        let mut out = String::from(mnem);
        let mut slot = None;
        let mut first = true;
        for o in &ops {
            if matches!(
                o,
                Op::T(Opnd::Lsl(0)) | Op::T(Opnd::Shift { kind: 0, amount: 0 })
            ) {
                continue;
            }
            out.push_str(if first { " " } else { ", " });
            first = false;
            match *o {
                Op::Mask(0) => out.push_str("#0000000000000000"),
                Op::Mask(v) => {
                    let _ = write!(out, "#{v:#016x}");
                }
                Op::Group4B(num, index) => {
                    let _ = write!(out, "v{num}.4b[{index}]");
                }
                Op::T(t) => opnd(&mut out, &t),
                Op::Dec(v) => {
                    let _ = write!(out, "#{v}");
                }
                Op::U(v) => {
                    let _ = write!(out, "#{v:#x}");
                }
                Op::At(f, _) => slot = Some((out.len(), Operand::A64(f))),
                Op::MemAt(base, f) => {
                    out.push('[');
                    out.push_str(&gpr(base, true, true));
                    slot = Some((out.len(), Operand::A64(f)));
                    out.push(']');
                }
                Op::Lit(s) => out.push_str(s),
            }
        }
        Text {
            text: out,
            operand: slot,
        }
    }

    fn gpr(num: u8, is64: bool, sp: bool) -> String {
        match (num, is64, sp) {
            (31, true, true) => String::from("sp"),
            (31, false, true) => String::from("wsp"),
            (31, true, false) => String::from("xzr"),
            (31, false, false) => String::from("wzr"),
            (n, true, _) => format!("x{n}"),
            (n, false, _) => format!("w{n}"),
        }
    }

    fn hex(v: i64) -> String {
        if v < 0 {
            format!("#-{:#x}", v.unsigned_abs())
        } else {
            format!("#{v:#x}")
        }
    }

    const fn lane(size: u8) -> char {
        match size {
            0 => 'b',
            1 => 'h',
            2 => 's',
            3 => 'd',
            _ => 'q',
        }
    }

    fn arrangement(size: u8, q: bool) -> String {
        let bits = if q { 128 } else { 64 };
        format!("{}{}", bits >> (3 + size), lane(size))
    }

    const EXTENDS: [&str; 8] = [
        "uxtb", "uxth", "uxtw", "uxtx", "sxtb", "sxth", "sxtw", "sxtx",
    ];
    const SHIFTS: [&str; 4] = ["lsl", "lsr", "asr", "ror"];

    fn opnd(out: &mut String, o: &Opnd) {
        match *o {
            Opnd::Reg { num, is64, sp } => out.push_str(&gpr(num, is64, sp)),
            Opnd::RegWb(n) => {
                let _ = write!(out, "{}!", gpr(n, true, false));
            }
            Opnd::VReg { num, is_d } => {
                let _ = write!(out, "{}{num}", if is_d { 'd' } else { 's' });
            }
            Opnd::QReg(n) => {
                let _ = write!(out, "q{n}");
            }
            Opnd::VScalar { num, size } => {
                let _ = write!(out, "{}{num}", lane(size));
            }
            Opnd::VecReg { num, size, q } => {
                let _ = write!(out, "v{num}.{}", arrangement(size, q));
            }
            Opnd::VecElem { num, size, index } => {
                let _ = write!(out, "v{num}.{}[{index}]", lane(size));
            }
            Opnd::VecList {
                first,
                count,
                size,
                q,
            } => {
                out.push_str("{ ");
                for k in 0..count {
                    let sep = if k > 0 { ", " } else { "" };
                    let _ = write!(out, "{sep}v{}.{}", (first + k) % 32, arrangement(size, q));
                }
                out.push_str(" }");
            }
            Opnd::VecListLane {
                first,
                count,
                size,
                index,
            } => {
                out.push_str("{ ");
                for k in 0..count {
                    let sep = if k > 0 { ", " } else { "" };
                    let _ = write!(out, "{sep}v{}.{}", (first + k) % 32, lane(size));
                }
                let _ = write!(out, " }}[{index}]");
            }
            Opnd::Imm(v) => out.push_str(&hex(v)),
            Opnd::FpImm(imm8) => {
                let bits = super::super::vfp_expand_imm(imm8, false);
                let _ = write!(out, "#{:.8}", f64::from_bits(bits));
            }
            Opnd::Lsl(n) => {
                let _ = write!(out, "lsl #{n}");
            }
            Opnd::Shift { kind, amount } => {
                let _ = write!(out, "{} #{amount}", SHIFTS[usize::from(kind & 3)]);
            }
            Opnd::Extend { option, amount } => {
                out.push_str(EXTENDS[usize::from(option & 7)]);
                if amount != 0 {
                    let _ = write!(out, " #{amount}");
                }
            }
            Opnd::SysReg(v) => {
                match (super::super::sysreg_a64_table::SYSREGS.iter()).find(|(_, f)| *f == v) {
                    Some((name, _)) => out.push_str(&name.to_ascii_uppercase()),
                    None => {
                        let f = u32::from(v);
                        let _ = write!(
                            out,
                            "S{}_{}_C{}_C{}_{}",
                            f >> 14,
                            (f >> 11) & 7,
                            (f >> 7) & 15,
                            (f >> 3) & 15,
                            f & 7
                        );
                    }
                }
            }
            Opnd::SysOp(word) => match sys_op(word) {
                Some((_, name)) => out.push_str(name),
                None => {
                    let _ = write!(out, "{word:#x}");
                }
            },
            Opnd::Mem { base, off, pre } => {
                out.push('[');
                out.push_str(&gpr(base, true, true));
                if off != 0 || pre {
                    let _ = write!(out, ", {}", hex(off));
                }
                out.push(']');
                if pre {
                    out.push('!');
                }
            }
            Opnd::MemReg {
                base,
                index,
                option,
                shift,
            } => {
                let _ = write!(
                    out,
                    "[{}, {}",
                    gpr(base, true, true),
                    gpr(index, option & 1 == 1, false)
                );
                match (option, shift) {
                    (3, None) => {}
                    (3, Some(s)) => {
                        let _ = write!(out, ", lsl #{s}");
                    }
                    (o, None) => {
                        let _ = write!(out, ", {}", EXTENDS[usize::from(o & 7)]);
                    }
                    (o, Some(s)) => {
                        let _ = write!(out, ", {} #{s}", EXTENDS[usize::from(o & 7)]);
                    }
                }
                out.push(']');
            }
            Opnd::Cond(c) => out.push_str(CONDS[usize::from(c & 15)]),
            Opnd::SvePattern(p) => match p {
                0 => out.push_str("pow2"),
                1..=8 => {
                    let _ = write!(out, "vl{p}");
                }
                9..=13 => {
                    let _ = write!(out, "vl{}", 16 << (p - 9));
                }
                29 => out.push_str("mul4"),
                30 => out.push_str("mul3"),
                31 => out.push_str("all"),
                _ => {
                    let _ = write!(out, "#{p:#x}");
                }
            },
            Opnd::SveMul(m) => {
                let _ = write!(out, "mul {}", hex(m));
            }
            Opnd::ZReg { num, size } => {
                let _ = write!(out, "z{num}");
                if let Some(s) = size {
                    let _ = write!(out, ".{}", lane(s));
                }
            }
            Opnd::PReg { num, size } => {
                let _ = write!(out, "p{num}");
                if let Some(s) = size {
                    let _ = write!(out, ".{}", lane(s));
                }
            }
            Opnd::PRegQ { num, merge } => {
                let _ = write!(out, "p{num}/{}", if merge { 'm' } else { 'z' });
            }
            Opnd::ZMem { base, size, off } => {
                let _ = write!(out, "[z{base}.{}", lane(size));
                if off != 0 {
                    let _ = write!(out, ", {}", hex(off));
                }
                out.push(']');
            }
            Opnd::ZMemReg {
                base,
                index,
                size,
                ext,
                amount,
            } => {
                let _ = write!(out, "[{}, z{index}.{}", gpr(base, true, true), lane(size));
                let m = ["", "lsl", "uxtw", "sxtw"][usize::from(ext & 3)];
                if !m.is_empty() {
                    let _ = write!(out, ", {m}");
                    if let Some(a) = amount {
                        let _ = write!(out, " #{a}");
                    }
                }
                out.push(']');
            }
            Opnd::ZElem { num, size, index } => {
                let _ = write!(out, "z{num}.{}[{index}]", lane(size));
            }
            Opnd::ZList { first, count, size } => {
                out.push_str("{ ");
                for k in 0..count {
                    let sep = if k > 0 { ", " } else { "" };
                    let _ = write!(out, "{sep}z{}.{}", (first + k) % 32, lane(size));
                }
                out.push_str(" }");
            }
            Opnd::MemVl { base, off } => {
                let _ = write!(out, "[{}", gpr(base, true, true));
                if off != 0 {
                    let _ = write!(out, ", {}, mul vl", hex(off));
                }
                out.push(']');
            }
            Opnd::ZaVec { select, off } => {
                let _ = write!(out, "za[{}, {off}]", gpr(select, false, false));
            }
        }
    }

    /// A general register operand: number, width, and whether 31 is `sp`.
    fn gp(o: &Op) -> Option<(u8, bool, bool)> {
        match *o {
            Op::T(Opnd::Reg { num, is64, sp }) => Some((num, is64, sp)),
            _ => None,
        }
    }

    fn is_zr(o: &Op) -> bool {
        matches!(gp(o), Some((31, _, false)))
    }

    fn is_sp(o: &Op) -> bool {
        matches!(gp(o), Some((31, _, true)))
    }

    fn value(o: &Op) -> Option<i64> {
        match *o {
            Op::T(Opnd::Imm(v)) | Op::Dec(v) | Op::At(_, v) => Some(v),
            Op::U(v) => Some(v as i64),
            _ => None,
        }
    }

    /// The same general register, whatever its 31 reads as.
    fn same_gp(a: &Op, b: &Op) -> bool {
        matches!((gp(a), gp(b)), (Some(x), Some(y)) if x.0 == y.0 && x.1 == y.1)
    }

    /// A shift operand that leaves the register as it is.
    fn no_shift(ops: &[Op]) -> bool {
        ops.iter().all(|o| {
            matches!(
                o,
                Op::T(Opnd::Lsl(0)) | Op::T(Opnd::Shift { amount: 0, .. })
            )
        })
    }

    /// `value` is one `movz` or `movn` of a `bits`-wide register.
    fn move_wide(value: u64, bits: u32) -> bool {
        let mask = if bits == 64 {
            u64::MAX
        } else {
            (1 << bits) - 1
        };
        let one_chunk = |v: u64| (0..bits / 16).any(|hw| v & !(0xFFFF << (16 * hw)) == 0);
        one_chunk(value & mask) || one_chunk(!value & mask)
    }

    fn cond_of(o: &Op) -> Option<u8> {
        match *o {
            Op::T(Opnd::Cond(c)) => Some(c),
            _ => None,
        }
    }

    /// The W view of a general register operand.
    fn as_w(o: &Op) -> Op {
        match *o {
            Op::T(Opnd::Reg { num, sp, .. }) => Op::T(Opnd::Reg {
                num,
                is64: false,
                sp,
            }),
            other => other,
        }
    }

    /// The alias the architecture prefers for `mnem` over `ops`, if one.
    fn preferred(mnem: &str, ops: &[Op]) -> Option<(&'static str, Vec<Op>)> {
        let v = |o: &[Op]| o.to_vec();
        let width = |o: &Op| {
            if matches!(gp(o), Some((_, true, _))) {
                64
            } else {
                32
            }
        };
        Some(match (mnem, ops) {
            ("orr", [rd, rn, rm, sh @ ..]) if is_zr(rn) && gp(rm).is_some() && no_shift(sh) => {
                ("mov", v(&[*rd, *rm]))
            }
            ("orr", [rd, rn, imm]) if is_zr(rn) && gp(rd).is_some() => {
                let value = value(imm)? as u64;
                if move_wide(value, width(rd)) {
                    return None;
                }
                let value = if width(rd) == 64 {
                    value as i64
                } else {
                    i64::from(value as u32 as i32)
                };
                ("mov", v(&[*rd, super::imm(value)]))
            }
            (
                "orr",
                [
                    Op::T(Opnd::VecReg { num: d, size, q }),
                    Op::T(Opnd::VecReg { num: n, .. }),
                    Op::T(Opnd::VecReg { num: m, .. }),
                ],
            ) if n == m => (
                "mov",
                v(&[super::v(*d, *size, *q), super::v(*n, *size, *q)]),
            ),
            ("orn", [rd, rn, rest @ ..]) if is_zr(rn) && gp(rd).is_some() => {
                let mut o = v(&[*rd]);
                o.extend_from_slice(rest);
                ("mvn", o)
            }
            ("not", ops) => ("mvn", v(ops)),
            ("sub" | "subs", [rd, rn, rm, rest @ ..])
                if is_zr(rn) && gp(rm).is_some() && !(mnem == "subs" && is_zr(rd)) =>
            {
                let mut o = v(&[*rd, *rm]);
                o.extend_from_slice(rest);
                (if mnem == "sub" { "neg" } else { "negs" }, o)
            }
            ("subs" | "adds" | "ands", [rd, rest @ ..]) if is_zr(rd) => {
                let alias = match mnem {
                    "subs" => "cmp",
                    "adds" => "cmn",
                    _ => "tst",
                };
                let mut o = v(rest);
                strip_sp_extend(&mut o, false);
                (alias, o)
            }
            (
                "add" | "sub" | "adds" | "subs",
                [rd, rn, Op::T(Opnd::Reg { .. }), Op::T(Opnd::Extend { .. })],
            ) if is_sp(rd) || is_sp(rn) => {
                let mut o = v(ops);
                strip_sp_extend(&mut o, true);
                return Some((static_mnem(mnem), o));
            }
            ("add", [rd, rn, imm]) if (is_sp(rd) || is_sp(rn)) && value(imm) == Some(0) => {
                ("mov", v(&[*rd, *rn]))
            }
            ("movz", [rd, Op::T(Opnd::Imm(imm)), sh @ ..]) => {
                let (imm, sh) = (*imm, lsl_of(sh)?);
                if imm == 0 && sh != 0 {
                    return None;
                }
                let value = if width(rd) == 64 {
                    imm << sh
                } else {
                    i64::from(((imm as u32) << sh) as i32)
                };
                ("mov", v(&[*rd, super::imm(value)]))
            }
            ("movn", [rd, Op::T(Opnd::Imm(imm)), sh @ ..]) => {
                let (imm, sh) = (*imm, lsl_of(sh)?);
                if (imm == 0 && sh != 0) || (width(rd) == 32 && imm == 0xFFFF) {
                    return None;
                }
                let value = if width(rd) == 64 {
                    !(imm << sh)
                } else {
                    i64::from(!((imm as u32) << sh) as i32)
                };
                ("mov", v(&[*rd, super::imm(value)]))
            }
            ("ubfm" | "sbfm", [rd, rn, immr, imms]) => {
                let (immr, imms) = (value(immr)?, value(imms)?);
                let bits = width(rd);
                let top = i64::from(bits - 1);
                let signed = mnem == "sbfm";
                if immr == 0
                    && (imms == 7 || imms == 15 || (imms == 31 && signed && bits == 64))
                    && (signed || bits == 32)
                {
                    let name = match (signed, imms) {
                        (true, 7) => "sxtb",
                        (true, 15) => "sxth",
                        (true, _) => "sxtw",
                        (false, 7) => "uxtb",
                        _ => "uxth",
                    };
                    return Some((name, v(&[*rd, as_w(rn)])));
                }
                if imms == top {
                    return Some((
                        if signed { "asr" } else { "lsr" },
                        v(&[*rd, *rn, super::dec(immr)]),
                    ));
                }
                if !signed && imms + 1 == immr {
                    return Some(("lsl", v(&[*rd, *rn, super::dec(top - imms)])));
                }
                if imms < immr {
                    let name = if signed { "sbfiz" } else { "ubfiz" };
                    let lsb = (i64::from(bits) - immr) & top;
                    return Some((name, v(&[*rd, *rn, super::dec(lsb), super::dec(imms + 1)])));
                }
                let name = if signed { "sbfx" } else { "ubfx" };
                (
                    name,
                    v(&[*rd, *rn, super::dec(immr), super::dec(imms - immr + 1)]),
                )
            }
            ("bfm", [rd, rn, immr, imms]) => {
                let (immr, imms) = (value(immr)?, value(imms)?);
                let bits = i64::from(width(rd));
                if imms < immr {
                    let lsb = (bits - immr) & (bits - 1);
                    if is_zr(rn) {
                        return Some(("bfc", v(&[*rd, super::dec(lsb), super::dec(imms + 1)])));
                    }
                    return Some(("bfi", v(&[*rd, *rn, super::dec(lsb), super::dec(imms + 1)])));
                }
                (
                    "bfxil",
                    v(&[*rd, *rn, super::dec(immr), super::dec(imms - immr + 1)]),
                )
            }
            ("extr", [rd, rn, rm, lsb]) if same_gp(rn, rm) => ("ror", v(&[*rd, *rn, *lsb])),
            ("csinc" | "csinv" | "csneg", [rd, rn, rm, c]) => {
                let c = cond_of(c)?;
                if c >= 14 {
                    return None;
                }
                let inv = Op::T(Opnd::Cond(c ^ 1));
                if is_zr(rn) && is_zr(rm) && mnem != "csneg" {
                    return Some((
                        if mnem == "csinc" { "cset" } else { "csetm" },
                        v(&[*rd, inv]),
                    ));
                }
                if !same_gp(rn, rm) || is_zr(rm) {
                    return None;
                }
                let alias = match mnem {
                    "csinc" => "cinc",
                    "csinv" => "cinv",
                    _ => "cneg",
                };
                (alias, v(&[*rd, *rn, inv]))
            }
            ("madd" | "msub" | "smaddl" | "umaddl" | "smsubl" | "umsubl", [rd, rn, rm, ra])
                if is_zr(ra) =>
            {
                let alias = match mnem {
                    "madd" => "mul",
                    "msub" => "mneg",
                    "smaddl" => "smull",
                    "umaddl" => "umull",
                    "smsubl" => "smnegl",
                    _ => "umnegl",
                };
                (alias, v(&[*rd, *rn, *rm]))
            }
            ("ins", ops) => ("mov", v(ops)),
            ("umov", [rd, e @ Op::T(Opnd::VecElem { size, .. })])
                if (*size == 2 && width(rd) == 32) || (*size == 3 && width(rd) == 64) =>
            {
                ("mov", v(&[*rd, *e]))
            }
            (
                "dup",
                [
                    d @ Op::T(Opnd::VReg { .. } | Opnd::VScalar { .. } | Opnd::QReg(_)),
                    e @ Op::T(Opnd::VecElem { .. }),
                ],
            ) => ("mov", v(&[*d, *e])),
            ("lslv" | "lsrv" | "asrv" | "rorv", ops) => (&static_mnem(mnem)[..3], v(ops)),
            ("ret", [Op::T(Opnd::Reg { num: 30, .. })]) => ("ret", Vec::new()),
            _ => return None,
        })
    }

    /// The shift of a move-wide's optional `lsl` operand.
    fn lsl_of(ops: &[Op]) -> Option<u32> {
        match ops {
            [] => Some(0),
            [Op::T(Opnd::Lsl(sh))] => Some(*sh),
            _ => None,
        }
    }

    /// The `dc` / `ic` / `at` / `tlbi` operation of a `sys` word: the family
    /// and the operation's name.
    fn sys_op(word: u32) -> Option<(&'static str, &'static str)> {
        use super::super::sysreg_a64_table::{AT_OPS, DC_OPS, IC_OPS, TLBI_OPS};
        let key = ((word >> 5) & 0x3FFF) as u16;
        [
            ("dc", DC_OPS),
            ("ic", IC_OPS),
            ("at", AT_OPS),
            ("tlbi", TLBI_OPS),
        ]
        .into_iter()
        .find_map(|(family, ops)| {
            let (name, _) = ops.iter().find(|(_, k)| *k == key)?;
            Some((family, *name))
        })
    }

    /// An alias the template spells, in the form it aliases, so that the
    /// preferred one reads: a bit-field alias as its `ubfm` / `sbfm` /
    /// `bfm`, an unscaled offset as `ldur`, a `sys` operation as its
    /// family, `uxtl` as the `ushll` it shifts by zero.
    fn canonical(mnem: &str, ops: &[Op]) -> Option<(&'static str, Vec<Op>)> {
        use super::dec;
        let imm = |o: &Op| match *o {
            Op::T(Opnd::Imm(v)) | Op::Dec(v) => Some(v),
            _ => None,
        };
        let bits = |o: &Op| {
            if matches!(gp(o), Some((_, true, _))) {
                64i64
            } else {
                32
            }
        };
        Some(match (mnem, ops) {
            ("ubfx" | "sbfx" | "bfxil", [rd, rn, lsb, w]) => {
                let (lsb, w) = (imm(lsb)?, imm(w)?);
                let m = match mnem {
                    "ubfx" => "ubfm",
                    "sbfx" => "sbfm",
                    _ => "bfm",
                };
                (m, alloc::vec![*rd, *rn, dec(lsb), dec(lsb + w - 1)])
            }
            ("ubfiz" | "sbfiz" | "bfi", [rd, rn, lsb, w]) => {
                let (lsb, w, n) = (imm(lsb)?, imm(w)?, bits(rd));
                let m = match mnem {
                    "ubfiz" => "ubfm",
                    "sbfiz" => "sbfm",
                    _ => "bfm",
                };
                (m, alloc::vec![*rd, *rn, dec((n - lsb) % n), dec(w - 1)])
            }
            ("lsl" | "lsr" | "asr", [rd, rn, sh]) => {
                let (sh, n) = (imm(sh)?, bits(rd));
                match mnem {
                    "lsl" => (
                        "ubfm",
                        alloc::vec![*rd, *rn, dec((n - sh) % n), dec(n - 1 - sh)],
                    ),
                    "lsr" => ("ubfm", alloc::vec![*rd, *rn, dec(sh), dec(n - 1)]),
                    _ => ("sbfm", alloc::vec![*rd, *rn, dec(sh), dec(n - 1)]),
                }
            }
            ("uxtl" | "sxtl" | "uxtl2" | "sxtl2", [vd, vn]) => {
                let m = match mnem {
                    "uxtl" => "ushll",
                    "sxtl" => "sshll",
                    "uxtl2" => "ushll2",
                    _ => "sshll2",
                };
                (m, alloc::vec![*vd, *vn, super::imm(0)])
            }
            ("sys" | "dc" | "ic" | "at" | "tlbi", [Op::T(Opnd::SysOp(word)), rest @ ..]) => {
                let (family, name) = sys_op(*word)?;
                let mut o = alloc::vec![Op::Lit(name)];
                o.extend_from_slice(rest);
                if rest.is_empty() && matches!(family, "dc" | "at") {
                    o.push(super::x(super::Reg(31)));
                }
                (family, o)
            }
            (
                _,
                [
                    rt,
                    Op::T(Opnd::Mem {
                        off, pre: false, ..
                    }),
                ],
            ) => {
                let size = access_size(mnem, rt)?;
                if *off >= 0 && off % size == 0 {
                    return None;
                }
                let m = match mnem {
                    "ldr" => "ldur",
                    "str" => "stur",
                    "ldrb" => "ldurb",
                    "strb" => "sturb",
                    "ldrh" => "ldurh",
                    "strh" => "sturh",
                    "ldrsb" => "ldursb",
                    "ldrsh" => "ldursh",
                    _ => "ldursw",
                };
                (m, ops.to_vec())
            }
            _ => return None,
        })
    }

    /// The access size of a single-register load or store, `None` for
    /// another mnemonic.
    fn access_size(mnem: &str, rt: &Op) -> Option<i64> {
        Some(match (mnem, rt) {
            ("ldrb" | "strb" | "ldrsb", _) => 1,
            ("ldrh" | "strh" | "ldrsh", _) => 2,
            ("ldrsw", _) => 4,
            ("ldr" | "str", Op::T(o)) => match *o {
                Opnd::Reg { is64: true, .. } | Opnd::VReg { is_d: true, .. } => 8,
                Opnd::Reg { .. } | Opnd::VReg { .. } => 4,
                Opnd::QReg(_) => 16,
                Opnd::VScalar { size, .. } => 1 << size,
                _ => return None,
            },
            _ => return None,
        })
    }

    /// The prefetch operations `prfm` names, by type, target and policy.
    const PRFOPS: [&str; 18] = [
        "pldl1keep",
        "pldl1strm",
        "pldl2keep",
        "pldl2strm",
        "pldl3keep",
        "pldl3strm",
        "plil1keep",
        "plil1strm",
        "plil2keep",
        "plil2strm",
        "plil3keep",
        "plil3strm",
        "pstl1keep",
        "pstl1strm",
        "pstl2keep",
        "pstl2strm",
        "pstl3keep",
        "pstl3strm",
    ];

    /// The operand spellings particular to a mnemonic: decimal shift and
    /// post-index amounts, a compare with zero, a `movi` byte mask, a
    /// prefetch operation's name, a bitmask immediate unsigned, a dot
    /// product's four-byte group.
    fn restyle(mnem: &str, ops: &[Op]) -> Vec<Op> {
        let mut out = ops.to_vec();
        let structure = |m: &str| {
            let b = m.as_bytes();
            (m.starts_with("ld") || m.starts_with("st"))
                && b.len() >= 3
                && (b'1'..=b'4').contains(&b[2])
                && (b.len() == 3 || &m[3..] == "r")
        };
        // A system instruction's register, and a register move's source,
        // read at the width the encoding takes.
        let wide = match mnem {
            "mrs" | "msr" | "sys" | "dc" | "ic" | "at" | "tlbi" => Some(true),
            "mov" => gp(&ops[0]).map(|(_, w, _)| w),
            _ => None,
        };
        for (i, o) in out.iter_mut().enumerate() {
            let Op::T(t) = *o else { continue };
            *o = match (mnem, t) {
                (_, Opnd::Reg { num, is64, sp }) if wide.is_some_and(|w| w != is64) => {
                    super::gp(num, !is64, sp)
                }
                (
                    "movi",
                    Opnd::VecReg {
                        num,
                        size: 3,
                        q: false,
                    },
                ) if i == 0 => super::d(num),
                ("shll" | "shll2" | "hvc" | "smc", Opnd::Imm(v)) => Op::Dec(v),
                (m, Opnd::Imm(v)) if structure(m) => Op::Dec(v),
                ("cmeq" | "cmge" | "cmgt" | "cmle" | "cmlt", Opnd::Imm(0)) => Op::Lit("#0"),
                (m, Opnd::Imm(0)) if m.starts_with("fcm") => Op::Lit("#0.0"),
                ("movi", Opnd::Imm(v))
                    if matches!(
                        ops[0],
                        Op::T(Opnd::VReg { is_d: true, .. }) | Op::T(Opnd::VecReg { size: 3, .. })
                    ) =>
                {
                    Op::Mask(v as u64)
                }
                // `prfop` is type (bits 4:3), target (2:1) and policy (0).
                ("prfm" | "prfum", Opnd::Imm(v)) if i == 0 && v >> 3 < 3 && (v >> 1) & 3 < 3 => {
                    Op::Lit(PRFOPS[((v >> 3) * 6 + ((v >> 1) & 3) * 2 + (v & 1)) as usize])
                }
                ("and" | "orr" | "eor" | "ands" | "tst", Opnd::Imm(v)) => match gp(&ops[0]) {
                    Some((_, true, _)) => Op::U(v as u64),
                    Some(_) => Op::U(v as u64 & 0xFFFF_FFFF),
                    None => continue,
                },
                (
                    "sdot" | "udot" | "usdot" | "sudot",
                    Opnd::VecElem {
                        num,
                        size: 2,
                        index,
                    },
                ) => Op::Group4B(num, index),
                _ => continue,
            };
        }
        out
    }

    /// The `'static` spelling of a mnemonic the aliases keep.
    fn static_mnem(mnem: &str) -> &'static str {
        match mnem {
            "add" => "add",
            "sub" => "sub",
            "adds" => "adds",
            "subs" => "subs",
            "lslv" => "lslv",
            "lsrv" => "lsrv",
            "asrv" => "asrv",
            _ => "rorv",
        }
    }

    /// The extend of an extended-register operand next to `sp` reads as
    /// `lsl`, and not at all when it shifts by zero: `UXTX` (`UXTW` of a
    /// W register) is the identity there.
    fn strip_sp_extend(ops: &mut Vec<Op>, sp: bool) {
        let sp = sp || ops.first().is_some_and(is_sp);
        let Some(Op::T(Opnd::Extend { option, amount })) = ops.last().copied() else {
            return;
        };
        let wide = ops.first().map(|o| matches!(gp(o), Some((_, true, _))));
        let identity = if wide == Some(true) { 3 } else { 2 };
        if !sp || option != identity {
            return;
        }
        ops.pop();
        if amount != 0 {
            ops.push(Op::T(Opnd::Lsl(u32::from(amount))));
        }
    }

    #[cfg(test)]
    mod tests {
        use super::super::*;
        use super::text;

        fn t(mnem: &str, ops: &[Op]) -> alloc::string::String {
            text(mnem, ops).text
        }

        /// Each alias reads as the architecture's preferred disassembly.
        #[test]
        fn aliases_read_as_preferred() {
            let (x0, x1, zr, sp) = (Reg(0), Reg(1), Reg(31), Reg(31));
            assert_eq!(t("orr", &[x(x0), x(zr), x(x1)]), "mov x0, x1");
            assert_eq!(t("movz", &[x(x0), imm(1), lsl(16)]), "mov x0, #0x10000");
            assert_eq!(
                t("movz", &[x(x0), imm(0), lsl(16)]),
                "movz x0, #0x0, lsl #16"
            );
            assert_eq!(t("movn", &[x(x0), imm(0), lsl(0)]), "mov x0, #-0x1");
            assert_eq!(t("add", &[xsp(x0), xsp(sp), imm(0)]), "mov x0, sp");
            assert_eq!(
                t("ubfm", &[x(x0), x(x1), dec(61), dec(60)]),
                "lsl x0, x1, #3"
            );
            assert_eq!(
                t("ubfm", &[x(x0), x(x1), dec(3), dec(63)]),
                "lsr x0, x1, #3"
            );
            assert_eq!(t("sbfm", &[x(x0), x(x1), dec(0), dec(31)]), "sxtw x0, w1");
            assert_eq!(
                t("ubfm", &[x(x0), x(x1), dec(4), dec(11)]),
                "ubfx x0, x1, #4, #8"
            );
            assert_eq!(
                t("csinc", &[x(x0), x(zr), x(zr), cond(Cond::Ne)]),
                "cset x0, eq"
            );
            assert_eq!(t("madd", &[x(x0), x(x1), x(x1), x(zr)]), "mul x0, x1, x1");
            assert_eq!(t("subs", &[x(zr), x(x0), x(x1)]), "cmp x0, x1");
            assert_eq!(
                t("add", &[xsp(sp), xsp(sp), x(x1), ext(3, 0)]),
                "add sp, sp, x1"
            );
            assert_eq!(t("ldr", &[x(x0), mem(x1, 0)]), "ldr x0, [x1]");
            assert_eq!(
                t("stp", &[x(x0), x(x1), pre(sp, -16)]),
                "stp x0, x1, [sp, #-0x10]!"
            );
            assert_eq!(
                t("ldr", &[x(x0), mem(sp, 0), imm(16)]),
                "ldr x0, [sp], #0x10"
            );
        }
    }
}
