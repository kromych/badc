//! gcc's `-Wvla-larger-than=N`: a variable-length array whose size is not
//! known to be at most N bytes. gcc runs the check when optimizing and takes
//! the bound from value ranges; badc takes it from the size expression: the
//! operand types, constants, casts, `&`, `%`, `/`, `>>`, `+`, `*`, and `?:`
//! whose condition compares the selected operand with a constant.
//! TODO: a bound only a dominating condition proves (`if (n > 50) return;`).

use super::super::ast::{Expr, ExprId, UnOp};
use super::super::diag::Code;
use super::Compiler;
use crate::c5::ir::BinOp;

/// The values an expression may take, both ends included.
type Range = (i128, i128);

/// A constraint the `?:` condition places on one identifier.
#[derive(Clone, Copy)]
struct Known {
    sym: u32,
    range: Range,
}

impl Compiler {
    /// Report the array of `elem_size`-byte elements `dim` sizes when its
    /// byte size may exceed the `-Wvla-larger-than=` bound.
    pub(super) fn check_vla_bound(&mut self, dim: ExprId, elem_size: u64) {
        let Some(limit) = self.vla_larger_than else {
            return;
        };
        if !self.optimize || !self.sink.may_emit(Code::VLA_LARGER_THAN) {
            return;
        }
        let bytes = self
            .value_range(dim, None)
            .filter(|r| r.0 >= 0)
            .map(|(lo, hi)| {
                let n = i128::from(elem_size);
                (lo.saturating_mul(n), hi.saturating_mul(n))
            });
        let text = match bytes {
            Some((_, hi)) if hi <= i128::from(limit) => return,
            Some((lo, _)) if lo > i128::from(limit) => "is too large",
            _ => "may be too large",
        };
        let msg = alloc::format!("argument to variable-length array {text}");
        self.warn_at(Code::VLA_LARGER_THAN, self.lex.line, msg);
    }

    /// The values of the integer type `ty`.
    fn type_range(&self, ty: i64) -> Option<Range> {
        use super::types::{is_integer_scalar_ty, is_unsigned_ty, strip_unsigned};
        if !is_integer_scalar_ty(ty) {
            return None;
        }
        if strip_unsigned(ty) == crate::c5::token::Ty::Bool as i64 {
            return Some((0, 1));
        }
        let bits = 8 * self.size_of_type(ty) as u32;
        Some(if is_unsigned_ty(ty) {
            (0, (1i128 << bits) - 1)
        } else {
            (-(1i128 << (bits - 1)), (1i128 << (bits - 1)) - 1)
        })
    }

    fn value_range(&self, e: ExprId, known: Option<Known>) -> Option<Range> {
        let within = |r: Range, ty: i64| {
            let t = self.type_range(ty)?;
            Some(if r.0 >= t.0 && r.1 <= t.1 { r } else { t })
        };
        match self.ast.expr(e) {
            Expr::IntLit { val, .. } => Some((i128::from(*val), i128::from(*val))),
            Expr::Ident { sym, ty, .. } => match known {
                Some(k) if k.sym == *sym => Some(k.range),
                _ => self.type_range(*ty),
            },
            Expr::Unary {
                op: UnOp::Renormalize { .. },
                child,
                ty,
            } => match self.value_range(*child, known) {
                Some(r) => within(r, *ty),
                None => self.type_range(*ty),
            },
            Expr::Unary {
                op: UnOp::LogNot, ..
            } => Some((0, 1)),
            Expr::Cast { child, to_ty } => match self.value_range(*child, known) {
                Some(r) => within(r, *to_ty),
                None => self.type_range(*to_ty),
            },
            Expr::Binary { op, lhs, rhs, ty } => {
                let ranged = (self.value_range(*lhs, known), self.value_range(*rhs, known));
                let r = match (op, ranged) {
                    (BinOp::And, (Some(l), Some(r))) if l.0 >= 0 || r.0 >= 0 => {
                        let nonneg = [l, r].into_iter().filter(|x| x.0 >= 0);
                        Some((0, nonneg.map(|x| x.1).min().unwrap_or(0)))
                    }
                    (BinOp::Mod | BinOp::Modu, (Some(l), Some((c, c2)))) if c == c2 && c > 0 => {
                        Some(if l.0 >= 0 {
                            (0, (c - 1).min(l.1))
                        } else {
                            (1 - c, c - 1)
                        })
                    }
                    (BinOp::Div | BinOp::Divu, (Some(l), Some((c, c2)))) if c == c2 && c > 0 => {
                        Some((l.0 / c, l.1 / c))
                    }
                    (BinOp::Shr | BinOp::Shru, (Some(l), Some((s, s2))))
                        if s == s2 && (0..127).contains(&s) && l.0 >= 0 =>
                    {
                        Some((l.0 >> s, l.1 >> s))
                    }
                    (BinOp::Add, (Some(l), Some(r))) => Some((l.0 + r.0, l.1 + r.1)),
                    (BinOp::Sub, (Some(l), Some(r))) => Some((l.0 - r.1, l.1 - r.0)),
                    (BinOp::Mul, (Some(l), Some(r))) => {
                        let p = [l.0 * r.0, l.0 * r.1, l.1 * r.0, l.1 * r.1];
                        Some((*p.iter().min()?, *p.iter().max()?))
                    }
                    _ => None,
                };
                match r {
                    Some(r) => within(r, *ty),
                    None => self.type_range(*ty),
                }
            }
            Expr::VlaSizeof { size_slot } => {
                let size = *self.vla_type_sizes.get(size_slot)?;
                self.value_range(size, known)
            }
            Expr::Ternary {
                cond,
                then_e,
                else_e,
                ty,
                elvis: false,
            } => {
                let then_r = self.value_range(*then_e, self.narrowed(*cond, true).or(known))?;
                let else_r = self.value_range(*else_e, self.narrowed(*cond, false).or(known))?;
                within((then_r.0.min(else_r.0), then_r.1.max(else_r.1)), *ty)
            }
            _ => None,
        }
    }

    /// What `cond` evaluating to `holds` says of an identifier it compares
    /// with a constant.
    fn narrowed(&self, cond: ExprId, holds: bool) -> Option<Known> {
        let Expr::Binary { op, lhs, rhs, .. } = self.ast.expr(cond) else {
            return None;
        };
        let (sym, ty, k, flipped) = match (self.ast.expr(*lhs), self.ast.expr(*rhs)) {
            (Expr::Ident { sym, ty, .. }, Expr::IntLit { val, .. }) => (*sym, *ty, *val, false),
            (Expr::IntLit { val, .. }, Expr::Ident { sym, ty, .. }) => (*sym, *ty, *val, true),
            _ => return None,
        };
        let k = i128::from(k);
        let (lo, hi) = self.type_range(ty)?;
        // `x op k` that holds: the interval of `x`; a flipped compare
        // mirrors the operator, a failing one negates it.
        use BinOp::*;
        let op = match (op, flipped) {
            (Lt | Ult, true) => Gt,
            (Gt | Ugt, true) => Lt,
            (Le | Ule, true) => Ge,
            (Ge | Uge, true) => Le,
            (Ult, false) => Lt,
            (Ugt, false) => Gt,
            (Ule, false) => Le,
            (Uge, false) => Ge,
            (op, _) => *op,
        };
        let op = match (op, holds) {
            (op, true) => op,
            (Lt, false) => Ge,
            (Gt, false) => Le,
            (Le, false) => Gt,
            (Ge, false) => Lt,
            (Eq, false) => Ne,
            (Ne, false) => Eq,
            _ => return None,
        };
        let range = match op {
            Lt => (lo, hi.min(k - 1)),
            Le => (lo, hi.min(k)),
            Gt => (lo.max(k + 1), hi),
            Ge => (lo.max(k), hi),
            Eq => (k, k),
            _ => return None,
        };
        (range.0 <= range.1).then_some(Known { sym, range })
    }
}
