//! The return a function takes ahead of its frame (`ssa::early_exit`): the
//! test at the entry and the return it branches to, after the body, both
//! evaluated from the argument registers. Temporaries are x9..x15:
//! caller-saved, and neither an argument nor the indirect-result register,
//! so the frame path finds every argument where the caller left it.

use super::super::ssa::early_exit::{EarlyExit, ShadowExpr, ShadowTest};
use super::*;

const TEMPS: [u8; 7] = [9, 10, 11, 12, 13, 14, 15];

struct Shadow<'a> {
    code: &'a mut Vec<u8>,
    next: usize,
}

impl Shadow<'_> {
    fn temp(&mut self) -> Option<Reg> {
        let r = *TEMPS.get(self.next)?;
        self.next += 1;
        Some(Reg(r))
    }

    /// The register a node computed from `rn` writes: `dst` when given, else
    /// `rn` itself when it is a temporary, which holds one operand read once.
    fn result_of(&mut self, rn: Reg, dst: Option<Reg>) -> Option<Reg> {
        match dst {
            Some(rd) => Some(rd),
            None if TEMPS.contains(&rn.0) => Some(rn),
            None => self.temp(),
        }
    }

    /// `e`'s 64-bit value in a register of the evaluation's choosing.
    fn reg(&mut self, e: &ShadowExpr) -> Option<Reg> {
        self.eval(e, None)
    }

    /// `e`'s 64-bit value in `dst`, or in a register of the evaluation's
    /// choosing. Each node writes its register after reading its operands.
    fn eval(&mut self, e: &ShadowExpr, dst: Option<Reg>) -> Option<Reg> {
        let out = |sh: &mut Self| dst.or_else(|| sh.temp());
        Some(match e {
            ShadowExpr::Param { reg, kind } => {
                if dst.is_none() && !matches!(kind, LoadKind::I8 | LoadKind::I16 | LoadKind::I32) {
                    return Some(Reg(*reg));
                }
                let rd = out(self)?;
                emit_sign_extend(self.code, rd, Reg(*reg), *kind);
                rd
            }
            ShadowExpr::Imm(k) => {
                let rd = out(self)?;
                load_imm64(self.code, rd, *k as u64);
                rd
            }
            ShadowExpr::Extend { value, kind } => {
                let rn = self.reg(value)?;
                let rd = self.result_of(rn, dst)?;
                emit_sign_extend(self.code, rd, rn, *kind);
                rd
            }
            ShadowExpr::Binop { op, lhs, rhs } => {
                let rn = self.reg(lhs)?;
                let rd = self.result_of(rn, dst)?;
                let word = match **rhs {
                    ShadowExpr::Imm(k) => binop_imm_peephole(*op, k, false, rd, rn),
                    _ => None,
                };
                let word = match word {
                    Some(w) => w,
                    None => {
                        let rm = self.reg(rhs)?;
                        int_binop_word(*op, rd, rn, rm)?
                    }
                };
                emit(self.code, word);
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
        let rn = if narrow {
            self.low_word(lhs)?
        } else {
            self.reg(lhs)?
        };
        if let ShadowExpr::Imm(k) = *rhs
            && let Some(imm) = cmp_imm12(k)
        {
            let word = if narrow {
                super::encode::enc_subs_imm_w(Reg::SP, rn, imm)
            } else {
                enc_subs_imm(Reg::SP, rn, imm)
            };
            emit(self.code, word);
            return Some(());
        }
        let rm = if narrow {
            self.low_word(rhs)?
        } else {
            self.reg(rhs)?
        };
        let word = if narrow {
            super::encode::enc_cmp_reg_w(rn, rm)
        } else {
            enc_cmp_reg(rn, rm)
        };
        emit(self.code, word);
        Some(())
    }

    /// The test and its branch; the offset of the word to patch.
    fn test(&mut self, exit: &EarlyExit, far: bool) -> Option<usize> {
        let word = match &exit.test {
            ShadowTest::Cmp {
                op,
                lhs,
                rhs,
                narrow,
            } => {
                self.cmp(lhs, rhs, *narrow)?;
                let holds = compare_cond(*op)?;
                let taken = if exit.exit_when != far {
                    holds
                } else {
                    holds.flip()
                };
                enc_b_cond(taken, 0)
            }
            ShadowTest::Value { value, low_word } => {
                let rt = if *low_word {
                    self.low_word(value)?
                } else {
                    self.reg(value)?
                };
                match (exit.exit_when != far, low_word) {
                    (true, false) => enc_cbnz(rt, 0),
                    (false, false) => enc_cbz(rt, 0),
                    (true, true) => super::encode::enc_cbnz_w(rt, 0),
                    (false, true) => super::encode::enc_cbz_w(rt, 0),
                }
            }
        };
        if far {
            emit(self.code, word | (2 << 5));
            emit(self.code, enc_b(0));
        } else {
            emit(self.code, word);
        }
        Some(self.code.len() - 4)
    }
}

/// The entry's test of `exit`, branching to the early return, through a `B`
/// when `far`. The branch's offset, or `None`, with nothing emitted, where
/// the test needs more temporaries than it has.
pub(super) fn emit_early_test(code: &mut Vec<u8>, exit: &EarlyExit, far: bool) -> Option<usize> {
    let start = code.len();
    let site = Shadow { code, next: 0 }.test(exit, far);
    if site.is_none() {
        code.truncate(start);
    }
    site
}

/// The early return of `exit`: the returned value into x0, then `ret`.
/// `false`, with nothing emitted, where it needs more temporaries than it has.
pub(super) fn emit_early_return(code: &mut Vec<u8>, exit: &EarlyExit) -> bool {
    let start = code.len();
    let mut sh = Shadow { code, next: 0 };
    if let Some(ret) = &exit.ret
        && sh.eval(ret, Some(Reg(0))).is_none()
    {
        code.truncate(start);
        return false;
    }
    emit(code, enc_ret(Reg(30)));
    true
}

/// Point the test's branch at `site` to `target`; `false` when a
/// conditional branch does not reach.
pub(super) fn patch_early_branch(code: &mut [u8], site: usize, target: usize, far: bool) -> bool {
    let words = (target - site) / 4;
    let word = u32::from_le_bytes(code[site..site + 4].try_into().expect("a branch word"));
    let word = if far {
        word | (words as u32 & 0x03FF_FFFF)
    } else if words < 1 << 18 {
        word | ((words as u32) << 5)
    } else {
        return false;
    };
    code[site..site + 4].copy_from_slice(&word.to_le_bytes());
    true
}
