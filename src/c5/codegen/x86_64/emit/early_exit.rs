//! The return a function takes ahead of its frame (`ssa::early_exit`): the
//! test at the entry and the return it branches to, after the body, both
//! evaluated from the argument registers. Temporaries are rax, r10 and r11:
//! caller-saved and no argument register under either convention, so the
//! frame path finds every argument where the caller left it.

use super::super::ssa::early_exit::{EarlyExit, ShadowExpr, ShadowTest};
use super::*;

const TEMPS: [Reg; 3] = [Reg(0), SCRATCH_R10, SCRATCH_R11];

struct Shadow<'a> {
    code: &'a mut Vec<u8>,
    next: usize,
}

impl Shadow<'_> {
    fn temp(&mut self) -> Option<Reg> {
        let r = *TEMPS.get(self.next)?;
        self.next += 1;
        Some(r)
    }

    /// The register a node computed from `rn` writes: `rn` itself when it
    /// is a temporary, which holds one operand read once.
    fn result_of(&mut self, rn: Reg) -> Option<Reg> {
        if TEMPS.contains(&rn) {
            Some(rn)
        } else {
            self.temp()
        }
    }

    /// `rd` = `rn` converted from the low bytes of `kind`, sign-extended.
    fn convert(&mut self, rd: Reg, rn: Reg, kind: LoadKind) {
        match kind {
            LoadKind::I8 => super::encode::emit_movsx_r_r8(self.code, rd, rn),
            LoadKind::I16 => super::encode::emit_movsx_r_r16(self.code, rd, rn),
            LoadKind::I32 => super::encode::emit_movsxd_r_r(self.code, rd, rn),
            _ => emit_mov_rr(self.code, rd, rn),
        }
    }

    /// `e`'s 64-bit value in a register; a parameter that needs no
    /// conversion stays in its argument register.
    fn reg(&mut self, e: &ShadowExpr) -> Option<Reg> {
        Some(match e {
            ShadowExpr::Param { reg, kind } => match kind {
                LoadKind::I8 | LoadKind::I16 | LoadKind::I32 => {
                    let rd = self.temp()?;
                    self.convert(rd, Reg(*reg), *kind);
                    rd
                }
                _ => Reg(*reg),
            },
            ShadowExpr::Imm(k) => {
                let rd = self.temp()?;
                emit_mov_r_imm64(self.code, rd, *k);
                rd
            }
            ShadowExpr::Extend { value, kind } => {
                let rn = self.reg(value)?;
                let rd = self.result_of(rn)?;
                self.convert(rd, rn, *kind);
                rd
            }
            ShadowExpr::Binop { op, lhs, rhs } => {
                let rn = self.reg(lhs)?;
                let rd = self.result_of(rn)?;
                let disp = match (op, &**rhs) {
                    (BinOp::Add, ShadowExpr::Imm(k)) => i32::try_from(*k).ok(),
                    (BinOp::Sub, ShadowExpr::Imm(k)) => {
                        k.checked_neg().and_then(|k| i32::try_from(k).ok())
                    }
                    _ => None,
                };
                if let Some(disp) = disp {
                    super::encode::emit_lea_r_mem(self.code, rd, rn, disp);
                    return Some(rd);
                }
                emit_mov_rr(self.code, rd, rn);
                let shift = match op {
                    BinOp::Shl => Some(Mnem::Shl),
                    BinOp::Shr => Some(Mnem::Sar),
                    BinOp::Shru => Some(Mnem::Shr),
                    _ => None,
                };
                let alu = match op {
                    BinOp::Add => Some(Mnem::Add),
                    BinOp::Sub => Some(Mnem::Sub),
                    BinOp::And => Some(Mnem::And),
                    BinOp::Or => Some(Mnem::Or),
                    BinOp::Xor => Some(Mnem::Xor),
                    _ => None,
                };
                let imm = match **rhs {
                    ShadowExpr::Imm(k) => Some(k),
                    _ => None,
                };
                match (imm, shift, alu) {
                    (Some(k), Some(m), _) if (0..64).contains(&k) => {
                        emit_shift_ri(self.code, m, 8, rd, k as u8)
                    }
                    (Some(k), None, Some(m)) if i32::try_from(k).is_ok() => {
                        emit_ri(self.code, m, 8, rd, k as i32)
                    }
                    // A variable shift count takes cl, an argument register.
                    (_, None, Some(m)) => {
                        let rm = self.reg(rhs)?;
                        emit_rr(self.code, m, 8, rd, rm);
                    }
                    _ => return None,
                }
                rd
            }
        })
    }

    /// A register whose low word is `e`'s: a 32-bit parameter's own.
    fn low_word(&mut self, e: &ShadowExpr) -> Option<Reg> {
        match e {
            ShadowExpr::Param { reg, kind } if !matches!(kind, LoadKind::I8 | LoadKind::I16) => {
                Some(Reg(*reg))
            }
            _ => self.reg(e),
        }
    }

    /// Set the flags for `lhs` against `rhs`, 32-bit when `narrow`.
    fn cmp(&mut self, lhs: &ShadowExpr, rhs: &ShadowExpr, narrow: bool) -> Option<()> {
        let width = if narrow { 4 } else { 8 };
        let rn = if narrow {
            self.low_word(lhs)?
        } else {
            self.reg(lhs)?
        };
        match *rhs {
            ShadowExpr::Imm(0) => emit_rr(self.code, Mnem::Test, width, rn, rn),
            ShadowExpr::Imm(k) if i32::try_from(k).is_ok() => {
                emit_ri(self.code, Mnem::Cmp, width, rn, k as i32)
            }
            _ => {
                let rm = if narrow {
                    self.low_word(rhs)?
                } else {
                    self.reg(rhs)?
                };
                emit_rr(self.code, Mnem::Cmp, width, rn, rm);
            }
        }
        Some(())
    }

    /// The returned value into rax.
    fn result(&mut self, e: &ShadowExpr) -> Option<()> {
        let rax = Reg(0);
        match e {
            ShadowExpr::Param { reg, kind } => self.convert(rax, Reg(*reg), *kind),
            ShadowExpr::Imm(k) => emit_mov_r_imm64(self.code, rax, *k),
            _ => {
                let r = self.reg(e)?;
                emit_mov_rr(self.code, rax, r);
            }
        }
        Some(())
    }

    /// The test and its branch; the offset of the branch's displacement.
    fn test(&mut self, exit: &EarlyExit) -> Option<usize> {
        let to_exit = match &exit.test {
            ShadowTest::Cmp {
                op,
                lhs,
                rhs,
                narrow,
            } => {
                self.cmp(lhs, rhs, *narrow)?;
                let holds = int_cmp_cc(*op)?;
                if exit.exit_when { holds } else { holds.flip() }
            }
            ShadowTest::Value { value, low_word } => {
                let (rt, width) = if *low_word {
                    (self.low_word(value)?, 4)
                } else {
                    (self.reg(value)?, 8)
                };
                emit_rr(self.code, Mnem::Test, width, rt, rt);
                if exit.exit_when { Cc::Ne } else { Cc::E }
            }
        };
        emit_jcc_rel32(self.code, to_exit, 0);
        Some(self.code.len() - 4)
    }
}

/// The entry's test of `exit`, branching to the early return. The offset of
/// the branch's displacement, or `None`, with nothing emitted, where the
/// test needs more temporaries than it has.
pub(super) fn emit_early_test(code: &mut Vec<u8>, exit: &EarlyExit) -> Option<usize> {
    let start = code.len();
    let site = Shadow { code, next: 0 }.test(exit);
    if site.is_none() {
        code.truncate(start);
    }
    site
}

/// The early return of `exit`: the returned value into rax, then the return.
/// `false`, with nothing emitted, where it needs more temporaries than it has.
pub(super) fn emit_early_return(
    code: &mut Vec<u8>,
    exit: &EarlyExit,
    abi: super::Abi,
    extern_sites: &mut Vec<super::UserExternCallSite>,
) -> bool {
    let start = code.len();
    let mut sh = Shadow { code, next: 0 };
    if let Some(ret) = &exit.ret
        && sh.result(ret).is_none()
    {
        code.truncate(start);
        return false;
    }
    emit_hardened_ret(code, abi, extern_sites);
    true
}

/// Point the test's branch, its displacement at `site`, to `target`.
pub(super) fn patch_early_branch(code: &mut [u8], site: usize, target: usize) {
    let rel = (target - (site + 4)) as i32;
    code[site..site + 4].copy_from_slice(&rel.to_le_bytes());
}
