//! The operations of the MSVC intrinsics (`crate::c5::ms_intrinsic`): the
//! bit and multiply forms in IR, the 16-byte compare-exchange on
//! `Inst::AtomicCas16`, and an instruction C has no operator for as the
//! inline asm the target's assembler encodes.

use alloc::boxed::Box;
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use super::access::{load_kind_for, load_kind_for_width, store_kind_for};
use super::*;
use crate::c5::compiler::types::pointee_ty;
use crate::c5::ir::{AsmBlock, AsmConstraint, AsmOperand, BitCountOp};
use crate::c5::ms_intrinsic::{BitModify, Op};

fn asm_operand(constraint: AsmConstraint, is_output: bool, width: u8) -> AsmOperand {
    AsmOperand {
        constraint,
        is_output,
        is_rw: false,
        width,
        seg: AsmSeg::None,
        static_arg: false,
        value: false,
        volatile_object: false,
        early_clobber: false,
    }
}

/// Volatile asm with `operands`, an output's argument being the address
/// it stores to. A fixed register is preserved across it, as for a
/// written statement.
fn emit_asm(
    b: &mut SsaBuilder,
    template: &str,
    operands: Vec<(AsmOperand, ValueId)>,
    clobber_regs: u32,
    memory: bool,
) {
    let mut clobbers = clobber_regs;
    for (op, _) in &operands {
        if let AsmConstraint::Fixed(r) = op.constraint {
            clobbers |= 1 << r;
        }
    }
    let (operands, args) = operands.into_iter().unzip();
    let block = AsmBlock {
        template: template.as_bytes().to_vec(),
        operands,
        clobber_regs: clobbers,
        clobber_fp_regs: 0,
        clobber_memory: memory,
        volatile: true,
    };
    b.inline_asm(Box::new(block), args);
}

/// The `width`-byte value the template leaves in `%0`, `inputs` following.
fn asm_value(
    b: &mut SsaBuilder,
    template: &str,
    inputs: Vec<(AsmOperand, ValueId)>,
    width: u8,
) -> ValueId {
    let slot = b.alloc_synthetic_local();
    let at = b.local_addr(slot);
    let mut operands = alloc::vec![(asm_operand(AsmConstraint::Reg, true, width), at)];
    operands.extend(inputs);
    emit_asm(b, template, operands, 0, false);
    b.load_local(slot, load_kind_for_width(u32::from(width)))
}

fn count_leading_zeros(b: &mut SsaBuilder, x: ValueId, width: u8) -> ValueId {
    if width >= 4 {
        return b.bit_count(BitCountOp::Clz, x, width);
    }
    let clz = b.bit_count(BitCountOp::Clz, x, 4);
    b.binop_imm(BinOp::Sub, clz, 32 - i64::from(width) * 8)
}

/// The low `width` bytes of `v`, zero-extended.
fn zero_extend(b: &mut SsaBuilder, v: ValueId, width: u8) -> ValueId {
    match width {
        8 => v,
        w => b.binop_imm(BinOp::And, v, (1 << (i64::from(w) * 8)) - 1),
    }
}

fn rotate(b: &mut SsaBuilder, x: ValueId, n: ValueId, left: bool, width: u8) -> ValueId {
    let x = zero_extend(b, x, width);
    let top = i64::from(width) * 8 - 1;
    let n = b.binop_imm(BinOp::And, n, top);
    let neg = b.neg(n);
    let back = b.binop_imm(BinOp::And, neg, top);
    let (l, r) = if left { (n, back) } else { (back, n) };
    let hi = b.binop(BinOp::Shl, x, l);
    let lo = b.binop(BinOp::Shru, x, r);
    let v = b.binop(BinOp::Or, hi, lo);
    zero_extend(b, v, width)
}

/// Bit `bit` of the bit string at `base`, byte-addressed as on a
/// little-endian target: byte `bit >> 3`, bit `bit & 7`.
fn bit_test(
    b: &mut SsaBuilder,
    base: ValueId,
    bit: ValueId,
    modify: BitModify,
    atomic: Option<MemOrder>,
) -> ValueId {
    let byte_off = b.binop_imm(BinOp::Shr, bit, 3);
    let addr = b.binop(BinOp::Add, base, byte_off);
    let pos = b.binop_imm(BinOp::And, bit, 7);
    let one = b.imm(1);
    let mask = b.binop(BinOp::Shl, one, pos);
    let (op, operand) = match modify {
        BitModify::Keep | BitModify::Set => (AtomicRmwOp::Or, mask),
        BitModify::Reset => (AtomicRmwOp::And, b.binop_imm(BinOp::Xor, mask, 0xff)),
        BitModify::Complement => (AtomicRmwOp::Xor, mask),
    };
    let old = match atomic {
        Some(order) if modify != BitModify::Keep => b.atomic_rmw(op, addr, operand, 1, order),
        _ => {
            let byte = b.load(addr, LoadKind::U8);
            if modify != BitModify::Keep {
                let bin = match op {
                    AtomicRmwOp::Or => BinOp::Or,
                    AtomicRmwOp::And => BinOp::And,
                    _ => BinOp::Xor,
                };
                let new = b.binop(bin, byte, operand);
                b.store(addr, new, StoreKind::I8);
            }
            byte
        }
    };
    let at = b.binop(BinOp::Shru, old, pos);
    b.binop_imm(BinOp::And, at, 1)
}

/// The 128-bit `(lo, hi)` shifted by `count & 63`, its high half for a
/// left shift and its low half for a right one. The other half enters
/// through a one-bit pre-shift, so a count of 0 shifts by no more than 63.
fn shift128(b: &mut SsaBuilder, lo: ValueId, hi: ValueId, count: ValueId, left: bool) -> ValueId {
    let n = b.binop_imm(BinOp::And, count, 63);
    let rest = b.binop_imm(BinOp::Xor, n, 63);
    let (kept, entering, shift, pre) = if left {
        (hi, lo, BinOp::Shl, BinOp::Shru)
    } else {
        (lo, hi, BinOp::Shru, BinOp::Shl)
    };
    let main = b.binop(shift, kept, n);
    let entering = b.binop_imm(pre, entering, 1);
    let entering = b.binop(pre, entering, rest);
    b.binop(BinOp::Or, main, entering)
}

/// The system register `ARM64_SYSREG` encodes: op0's low bit at 14, then
/// op1, CRn, CRm and op2 in 3, 4, 4 and 3 bits.
fn sysreg_name(enc: i64) -> String {
    format!(
        "s{}_{}_c{}_c{}_{}",
        2 | ((enc >> 14) & 1),
        (enc >> 11) & 7,
        (enc >> 7) & 15,
        (enc >> 3) & 15,
        enc & 7
    )
}

impl<'a> Walker<'a> {
    /// The call `Expr::MsIntrinsic` at `id`: the arguments in order, then
    /// the operation.
    pub(super) fn walk_ms_intrinsic(
        &mut self,
        b: &mut SsaBuilder,
        id: ExprId,
    ) -> Result<ValueId, WalkError> {
        let Expr::MsIntrinsic { op, args, imm, ty } = self.ast.expr(id) else {
            unreachable!("an MSVC intrinsic node");
        };
        let (op, imm, ty, args) = (*op, *imm, *ty, args.clone());
        let mut v = Vec::with_capacity(args.len());
        let mut arg_tys = Vec::with_capacity(args.len());
        for &a in &args {
            v.push(self.walk_expr_rvalue(b, a)?);
            arg_tys.push(crate::c5::ast::expr_ty(self.ast.expr(a)).unwrap_or(Ty::Int as i64));
        }
        let target = self.target;
        let arm64 = target.is_aarch64();
        let reg = |width| asm_operand(AsmConstraint::Reg, false, width);
        Ok(match op {
            Op::BitScan { reverse, width } => {
                let found = b.binop_imm(BinOp::Ne, v[1], 0);
                let (store, done) = (b.new_block(), b.new_block());
                b.branch_zero(found, done, store);
                b.switch_to(store);
                let at = if reverse {
                    let clz = b.bit_count(BitCountOp::Clz, v[1], width);
                    b.binop_imm(BinOp::Xor, clz, i64::from(width) * 8 - 1)
                } else {
                    b.bit_count(BitCountOp::Ctz, v[1], width)
                };
                b.store(v[0], at, StoreKind::I32);
                b.jmp(done);
                b.switch_to(done);
                found
            }
            Op::Popcount { width } => b.bit_count(BitCountOp::Popcount, v[0], width.max(4)),
            Op::LeadingZeros { width } => count_leading_zeros(b, v[0], width),
            Op::TrailingZeros { width } => b.bit_count(BitCountOp::Ctz, v[0], width),
            Op::LeadingOnes { width } => {
                let flipped = b.binop_imm(BinOp::Xor, v[0], -1);
                let flipped = zero_extend(b, flipped, width);
                count_leading_zeros(b, flipped, width)
            }
            Op::LeadingSigns { width } => b.bit_count(BitCountOp::Clrsb, v[0], width),
            Op::Rotate { left, width } => rotate(b, v[0], v[1], left, width),
            Op::BitTest { modify, atomic } => bit_test(b, v[0], v[1], modify, atomic),
            Op::MulHigh { signed } => {
                b.binop(if signed { BinOp::Mulh } else { BinOp::Mulhu }, v[0], v[1])
            }
            Op::Mul128 { signed } => {
                let high = b.binop(if signed { BinOp::Mulh } else { BinOp::Mulhu }, v[0], v[1]);
                b.store(v[2], high, StoreKind::I64);
                b.binop(BinOp::Mul, v[0], v[1])
            }
            Op::Shift128 { left } => shift128(b, v[0], v[1], v[2], left),
            Op::VolatileLoad => b.load_vol(v[0], load_kind_for(ty, target), true),
            Op::VolatileStore => {
                let kind = store_kind_for(pointee_ty(arg_tys[0]), target);
                b.store_vol(v[0], v[1], kind, true);
                b.imm(0)
            }
            Op::GsLoad => b.seg_load(v[0], load_kind_for(ty, target), AsmSeg::Gs, true),
            Op::GsStore => {
                let kind = store_kind_for(arg_tys[1], target);
                b.seg_store(v[0], v[1], kind, AsmSeg::Gs, true);
                b.imm(0)
            }
            Op::X18Load | Op::X18Store => {
                let base = asm_value(b, "mov %0, x18", Vec::new(), 8);
                let addr = b.binop(BinOp::Add, base, v[0]);
                if op == Op::X18Load {
                    b.load_vol(addr, load_kind_for(ty, target), true)
                } else {
                    b.store_vol(addr, v[1], store_kind_for(arg_tys[1], target), true);
                    b.imm(0)
                }
            }
            Op::GetReg => {
                let src = if imm == 31 {
                    String::from("sp")
                } else {
                    format!("x{imm}")
                };
                asm_value(b, &format!("mov %0, {src}"), Vec::new(), 8)
            }
            Op::ReadStatusReg => {
                asm_value(b, &format!("mrs %0, {}", sysreg_name(imm)), Vec::new(), 8)
            }
            Op::WriteStatusReg => {
                let template = format!("msr {}, %0", sysreg_name(imm));
                emit_asm(b, &template, alloc::vec![(reg(8), v[0])], 0, true);
                b.imm(0)
            }
            Op::Crc32 { width, castagnoli } => {
                let size = match width {
                    1 => 'b',
                    2 => 'h',
                    4 => 'w',
                    _ => 'x',
                };
                let c = if castagnoli { "c" } else { "" };
                let data = if width == 8 { 'x' } else { 'w' };
                let template = format!("crc32{c}{size} %w0, %w1, %{data}2");
                let inputs = alloc::vec![(reg(4), v[0]), (reg(width.max(4)), v[1])];
                asm_value(b, &template, inputs, 4)
            }
            Op::DebugBreak => {
                emit_asm(
                    b,
                    if arm64 { "brk #0xf000" } else { "int3" },
                    Vec::new(),
                    0,
                    true,
                );
                b.imm(0)
            }
            Op::FastFail => {
                if arm64 {
                    emit_asm(
                        b,
                        "mov w0, %w0\n\tbrk #0xf003",
                        alloc::vec![(reg(4), v[0])],
                        1,
                        true,
                    );
                } else {
                    let code = asm_operand(AsmConstraint::Fixed(1), false, 4);
                    emit_asm(b, "int $0x29", alloc::vec![(code, v[0])], 0, true);
                }
                b.imm(0)
            }
            Op::Insn(name) => {
                emit_asm(b, name, Vec::new(), 0, true);
                b.imm(0)
            }
            Op::Barrier(name) => {
                emit_asm(b, &format!("{name} #{imm}"), Vec::new(), 0, true);
                b.imm(0)
            }
            Op::Pause => b.intrinsic(Intrinsic::CpuRelax as i64, Vec::new()),
            Op::Cpuid { sub } => {
                let fixed = |r, out| asm_operand(AsmConstraint::Fixed(r), out, 4);
                let mut operands = Vec::new();
                for (i, r) in [0u8, 3, 1, 2].into_iter().enumerate() {
                    let at = b.binop_imm(BinOp::Add, v[0], 4 * i as i64);
                    operands.push((fixed(r, true), at));
                }
                let subleaf = if sub { v[2] } else { b.imm(0) };
                operands.push((fixed(0, false), v[1]));
                operands.push((fixed(1, false), subleaf));
                emit_asm(b, "cpuid", operands, 0, true);
                b.imm(0)
            }
            Op::Rdtsc => {
                let (lo, hi) = (b.alloc_synthetic_local(), b.alloc_synthetic_local());
                let out = |r| asm_operand(AsmConstraint::Fixed(r), true, 4);
                let operands = alloc::vec![(out(0), b.local_addr(lo)), (out(2), b.local_addr(hi))];
                emit_asm(b, "rdtsc", operands, 0, false);
                let lo = b.load_local(lo, LoadKind::U32);
                let hi = b.load_local(hi, LoadKind::U32);
                let hi = b.binop_imm(BinOp::Shl, hi, 32);
                b.binop(BinOp::Or, hi, lo)
            }
            Op::CompareExchange128 { order } => {
                let desired = self.int128_materialize(b, (v[2], v[1]));
                b.atomic_cas16(v[0], v[3], desired, order)
            }
            Op::Assume
            | Op::Noop
            | Op::CompilerBarrier
            | Op::ReturnAddress
            | Op::AddressOfReturnAddress
            | Op::Atomic { .. } => {
                return Err(WalkError::UnsupportedExpr {
                    id,
                    kind: "an MSVC intrinsic the parser lowers",
                });
            }
        })
    }
}
